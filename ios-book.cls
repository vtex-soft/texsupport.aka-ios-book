%% This is file `ios-book.cls'
%%
%% Generic LaTeX 2e class file for the IOS Press publications
%% Loads standart `book.cls' and then modifys it
%% Use as replacement to 'book.cls'
%%
%% Macros written by Vytas Statulevicius, VTeX, Lithuania
%% for IOS Press, The Netherlands
%% Please submit bugs or your comments to latex-support@vtex.lt
%%
%% You are free to use this class file as you see fit, provided 
%% that you do not make changes to the file. 
%% If you DO make changes, you are required to rename this file.
%%
%% It may be distributed under the terms of the LaTeX Project Public
%% License, as described in lppl.txt in the base LaTeX distribution.
%% Either version 1.0 or, at your option, any later version.
%%
%% \CharacterTable
%%  {Upper-case    \A\B\C\D\E\F\G\H\I\J\K\L\M\N\O\P\Q\R\S\T\U\V\W\X\Y\Z
%%   Lower-case    \a\b\c\d\e\f\g\h\i\j\k\l\m\n\o\p\q\r\s\t\u\v\w\x\y\z
%%   Digits        \0\1\2\3\4\5\6\7\8\9
%%   Exclamation   \!     Double quote  \"     Hash (number) \#
%%   Dollar        \$     Percent       \%     Ampersand     \&
%%   Acute accent  \'     Left paren    \(     Right paren   \)
%%   Asterisk      \*     Plus          \+     Comma         \,
%%   Minus         \-     Point         \.     Solidus       \/
%%   Colon         \:     Semicolon     \;     Less than     \<
%%   Equals        \=     Greater than  \>     Question mark \?
%%   Commercial at \@     Left bracket  \[     Backslash     \\
%%   Right bracket \]     Circumflex    \^     Underscore    \_
%%   Grave accent  \`     Left brace    \{     Vertical bar  \|
%%   Right brace   \}     Tilde         \~}
%%
%%   Options:
%%   proof (default) - no runningheads, pagenumbers, copyright lines
%%   crc             - final layout
%%   trimpapersize   - page size will be set to trim width
%%   crop            - package 'crop' will be loaded and cropmarks will be printed
%% 
%% 
%% Bug fixes and changes:
%% 2006.09.27 - start 

\def\iosfmt@version{2023/10/23}

\NeedsTeXFormat{LaTeX2e}[1995/12/01]
\ProvidesClass{ios-book}[\iosfmt@version, IOS Press 'book' style (VS)]

\PassOptionsToPackage{psamsfonts}{amssymb}
\PassOptionsToPackage{cmex10}{amsmath}

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% LOCAL OPTIONS

% Use the trim size as papersize:
\newif\if@trimpapersize
\DeclareOption{trimpapersize}{\@trimpapersizetrue}

% Load crop.sty  for cropmarks:
\newif\if@load@crop
\DeclareOption{crop}{\@load@croptrue}

%% Trim size (book model):
\DeclareOption{160x240}{
    \def\iosbook@trimwidth{160mm}
    \def\iosbook@trimheight{240mm}
    \def\iosbook@textwidth{124mm}
    \def\iosbook@textheight{200mm}
    \def\iosbook@oddsidemargin{16mm}
    \def\iosbook@topmargin{13mm}
                    }


%% Proof mode: no RH, no copyright
\newif\if@proof@mode

\DeclareOption{proof}{\@proof@modetrue}
\DeclareOption{crc}{\@proof@modefalse}

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% EXECUTE OPTIONS

\DeclareOption*{\PassOptionsToClass{\CurrentOption}{book}}
\ExecuteOptions{160x240,proof}
\ProcessOptions*

\LoadClass[twoside,12pt,a4paper]{book}


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% DIMENSIONS
% TEXT DIMENSIONS
\setlength\parindent {18\p@}
\setlength\textwidth    {\iosbook@textwidth}
\setlength\textheight   {\iosbook@textheight}
%\advance\textheight by \topskip
\setlength\columnsep    {24\p@}
\setlength\columnseprule{0\p@}
\columnwidth=\textwidth
\advance\columnwidth by-\columnsep
\divide\columnwidth by2

% HEADS:
\setlength\headheight{12\p@}
\setlength\headsep   {14\p@}
\setlength\topskip   {10\p@}
\setlength\footskip  {24\p@}
\setlength\maxdepth  {.5\topskip}

% SIDE MARGINS
\setlength\oddsidemargin   {\iosbook@oddsidemargin}
\@tempdima=\iosbook@trimwidth
\advance\@tempdima by-\oddsidemargin
\advance\@tempdima by-\textwidth
\setlength\evensidemargin  {\@tempdima}%   outer

\setlength\topmargin       {\iosbook@topmargin}
\advance\topmargin by-5pt

% BREAKS
\setlength\smallskipamount{7\p@ \@plus 1\p@ \@minus 1\p@}
\setlength\medskipamount  {14\p@ \@plus 3\p@ \@minus 3\p@}
\setlength\bigskipamount  {21\p@ \@plus 3\p@ \@minus 3\p@}

% Set to point:
\@settopoint\textwidth
\@settopoint\textheight
\@settopoint\columnwidth
\@settopoint\oddsidemargin
\@settopoint\evensidemargin
\@settopoint\topmargin

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% putting text area on page

\if@trimpapersize
  \voffset=-1in
  \hoffset=-1in
  \setlength\paperwidth {\iosbook@trimwidth}
  \setlength\paperheight{\iosbook@trimheight}
  \def\special@papersize{\AtBeginDvi{\special{papersize=\the\paperwidth, \the\paperheight}}}
\else % center on page
  \@tempdima=\paperwidth  \advance\@tempdima by-\iosbook@trimwidth
  \divide\@tempdima by2   \advance\@tempdima by-1in
  \hoffset=\@tempdima

  \@tempdima=\paperheight \advance\@tempdima by-\iosbook@trimheight
  \divide\@tempdima by2    \advance\@tempdima by-1in
  \voffset=\@tempdima
\fi


% if option 'crop' is specified, print the cropmarks:

\if@load@crop
   \newdimen\stockwidth
   \stockwidth\paperwidth
   \newdimen\stockheight
   \stockheight\paperheight

   \paperwidth\iosbook@trimwidth
   \paperheight\iosbook@trimheight

   \advance\oddsidemargin by-1in
   \advance\evensidemargin by-1in
   \advance\topmargin by-1in

% if *trimpapersize* is specified, we will print according to IOS Press requirements
  \if@trimpapersize
    \stockwidth=\iosbook@trimwidth   \advance\stockwidth  by1in
    \@settopoint\stockwidth
    \stockheight=\iosbook@trimheight \advance\stockheight by1in
    \@settopoint\stockheight
  \fi
  \RequirePackage[cam,center]{crop}
\else
  \csname special@papersize\endcsname
\fi


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% frontmatter
\renewenvironment{frontmatter}{%
    \pagenumbering{roman}%
    \setcounter{page}{5}%
  }{%
    \mainmatter
  }

\newenvironment{abstract}{\chapter*{Abstract}}{}


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% address, maketitle

\def\subtitle#1{\gdef\@subtitle{#1}}
\def\address#1{\gdef\@address{#1}}
\let\@author\@undefined

\def\maketitle{%
  \@maketitle
  \global\let\title\relax
  \global\let\subtitle\relax
  \global\let\author\relax
  \global\let\address\relax
  \global\let\affiliation\relax
  \global\let\@address\@empty}


\def\@maketitle{%
  \newpage
  \thispagestyle{empty} 
  \bgroup
    \centering
    {\fontsize{24}{26}\selectfont\@title\par}
    \vskip11pc
    \@ifundefined{@author}{}{{\fontsize{18}{22}\selectfont\@author\par}}
    \vskip 24pt
    {\normalsize\itshape\@address\par}
    \vfill 
    {\normalfont\publisher@text\par}
  \egroup
  \clearpage
    }

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% part

\def\part{\cleardoublepage
          \thispagestyle{empty}
          \secdef\@part\@spart}

\def\@part[#1]#2{%
   \refstepcounter{part}%
   \begingroup%
     \no@harm%
     \xdef\@argi{#2}%
   \endgroup%
   \addcontentsline{toc}{part}{\protect\numberline{\thepart}\@argi}%
   \markboth{}{}%
   \@makeparthead{#2}%
}


\def\@makeparthead#1{%
   \vspace*{80\p@}
   \bgroup
     \centering\bfseries
     {\huge\partname\ \thepart\par}
     \vskip12\p@
     \noindent\rule{\textwidth}{1pt}\par
     \vskip12\p@
     {\Huge #1\par}
   \egroup
   \vfill
   \clearpage
}


\def\@spart#1{%
   \begingroup%
     \no@harm%
     \xdef\@argi{#1}%
   \endgroup%
   \addcontentsline{toc}{part}{\@argi}%
   \markboth{}{}%
   \@makesparthead{#1}%
}


\def\@makesparthead#1{%
   \vspace*{80\p@}
   \bgroup
     \centering\bfseries
     {\huge #1\par}
   \egroup
   \vfill
   \clearpage
}


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%  chapter

\def\@makechapterhead#1{%
  \vspace*{84\p@}%
  \bgroup
    %\centering
    \gdef\last@sect@mark@title{}%  
    \setlength\parindent{0\p@}
    \bfseries
    \interlinepenalty\@M
    \ifappend
         {\Large\appendixname\ \thechapter\par}
    \else
      \if@mainmatter
         {\Large\chaptername\ \thechapter\par}
      \else
         {\phantom{\Large\chaptername\ \thechapter}\par}
      \fi
    \fi
    \vskip-12pt
    \rule{\textwidth}{0.5pt}
    {\LARGE #1\par}
  \egroup
  \vskip 24\p@ plus 12\p@
  %\thispagestyle{copyright}
  \thispagestyle{plain}
}

\def\@makeschapterhead#1{%
  \vspace*{84\p@}%
  \markboth{#1}{#1}
  \bgroup
    %\centering
    \setlength\parindent{0\p@}
    \bfseries
    \interlinepenalty\@M
    \Large #1\par
  \egroup
  \vskip 24\p@ plus 12\p@
}

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% sections

\renewcommand\section{\@startsection {section}{1}{\z@}%
                                   {-\bigskipamount}%
                                   {\medskipamount}%
                                   {\normalsize\bfseries\mathversion{bold}\raggedright\nohyphen}}

\renewcommand\subsection{\@startsection {subsection}{2}{\z@}%
                                   {-\medskipamount}%
                                   {\medskipamount}%
                                   {\normalsize\bfseries\mathversion{bold}\raggedright\nohyphen}}

\renewcommand\subsubsection{\@startsection{subsubsection}{3}{\z@}%
                                     {-\medskipamount}%
                                     {\smallskipamount}%
                                     {\normalsize\raggedright\nohyphen}}

\renewcommand\paragraph{\@startsection{paragraph}{4}{\z@}%
                                    {\medskipamount}%
                                    {-1em}%
                                    {\normalsize\itshape}}

\renewcommand\subparagraph{\@startsection{subparagraph}{5}{\parindent}%
                                       {\smallskipamount}%
                                       {-1em}%
                                      {\normalsize\itshape}}

\xdef\last@chapt@mark@title{}
\xdef\last@sect@mark@title{}
\xdef\sect@level@section{section}

\def\@sect@sav#1#2#3#4#5#6[#7]#8{%
  \ifnum #2>\c@secnumdepth
    \let\@svsec\@empty
  \else
    \refstepcounter{#1}%
    \protected@edef\@svsec{\@seccntformat{#1}\relax}%
  \fi
  \@tempskipa #5\relax
  \ifdim \@tempskipa>\z@
    \begingroup
      #6{%
        \@hangfrom{\hskip #3\relax\@svsec}%
          \interlinepenalty \@M #8\@@par}%
    \endgroup
    \csname #1mark\endcsname{#7}%
    \addcontentsline{toc}{#1}{%
      \ifnum #2>\c@secnumdepth \else
        \protect\numberline{\csname the#1\endcsname}%
      \fi
      #8}%
  \else
    \def\@svsechd{%
      #6{\hskip #3\relax
      \@svsec #8}%
      \csname #1mark\endcsname{#7}%
      \addcontentsline{toc}{#1}{%
        \ifnum #2>\c@secnumdepth \else
          \protect\numberline{\csname the#1\endcsname}%
        \fi
        #8}}%
  \fi
  \@xsect{#5}}

%\let\@sect@sav\@sect
\def\@sect#1#2#3#4#5#6[#7]#8{%
  \@sect@sav{#1}{#2}{#3}{#4}{#5}{#6}[#7]{#8}%
  \edef\sect@level@name{#1}%
  \ifx\sect@level@name\sect@level@section
    \xdef\last@sect@mark@title{#7}%
  \fi
  \markright{\if.\last@sect@mark@title.\else \thechapter.\the\c@section. \last@sect@mark@title\fi}%
  }

% Format for the counter:
\def\@seccntformat#1{{\csname the#1\endcsname.\enspace}}

% Counter for sections
\setcounter{secnumdepth}{4}

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% running heads

% Normal RH
\def\ps@headings{\let\@mkboth\@gobbletwo%
      \let\@oddfoot\@empty%
      \let\@evenfoot\@empty%
      %\def\@evenhead{\runninghead@size\rlap{\pagenumber@size\thepage}\hfill\leftmark\hfill}%
      %\def\@oddhead{\runninghead@size\hfill\rightmark\hfill\llap{\pagenumber@size\thepage}}%
      \def\@evenhead{%
        \runninghead@size
        \rlap{\pagenumber@size\thepage}%
        \hfill
        \expandafter\MakeUppercase\expandafter{\textsl{\leftmark}}%
        }%
      \def\@oddhead{%
        \runninghead@size
        \expandafter\MakeUppercase\expandafter{\textsl{\rightmark}}%
        \hfill
        \llap{\pagenumber@size\thepage}%
        }%
}%
% Empty RH
\def\ps@empty{\let\@mkboth\@gobbletwo%
     \let\@oddhead\@empty%
     \let\@oddfoot\@empty%
     \let\@evenhead\@oddhead%
     \let\@evenfoot\@oddfoot}
%
% RH  with drop folio
\def\ps@plain{\let\@mkboth\@gobbletwo%
     \let\@oddhead\@empty%
     \let\@oddfoot\@empty%
     \let\@evenhead\@oddhead%
     \def\@oddfoot{\hfill\pagenumber@size\thepage\hfill}%
     \def\@evenfoot{\hfill\pagenumber@size\thepage\hfill}}

% Copyright  RH
\def\ps@copyright{\let\@mkboth\@gobbletwo
  \def\@evenhead{\parbox[t]{.90\textwidth}{\copyright@size\copyright@text}\hfill\pagenumber@size\thepage}%
  \def\@oddhead {\parbox[t]{.90\textwidth}{\copyright@size\copyright@text}\hfill\pagenumber@size\thepage}%
  \let\@oddfoot\relax%
  \let\@evenfoot\@oddfoot%
}


\def\chaptermark#1{%
  \xdef\last@chapt@mark@title{#1}%
  \markboth{\chaptername\ \thechapter. \last@chapt@mark@title}{}%
  }
\let\sectionmark\@gobble

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% table, figure

\setlength\belowcaptionskip{4\p@}

\long\def\@makecaption#1#2{%
  \vskip\abovecaptionskip
  \sbox\@tempboxa{\footnotesize\textbf{#1.}\enskip #2}%
  \ifdim \wd\@tempboxa >\hsize
    \unhbox\@tempboxa
  \else
    \global \@minipagefalse
    \hb@xt@\hsize{\hfil\box\@tempboxa\hfil}%
  \fi
  \vskip\belowcaptionskip}

\def\@floatboxreset{%
        \reset@font
        \footnotesize
        \@setminipage
        \centering
}


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% equations

\arraycolsep 1.5pt 
\tabcolsep 4pt 
\arrayrulewidth .5pt
\doublerulesep 2pt 
\tabbingsep\labelsep

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% list

% general list indent
\def\list@parindent{18\p@}

% enumerate
\def\enumerate@indent{\list@parindent}
\def\enumerate@parindent{\list@parindent}
\def\enumerate@labelsep{.5em}
\def\enumerate@firsttopsep{\smallskipamount}
\def\enumerate@topsep{\smallskipamount}
\def\enumerate@rightskip{\z@}% {\z@ plus 1fill}
\let\enumerate@hook\relax

% itemize
\def\itemize@indent{\list@parindent}
\def\itemize@parindent{\list@parindent}
\def\itemize@labelsep{.5em}
\def\itemize@firsttopsep{\smallskipamount}
\def\itemize@topsep{\z@}
\def\itemize@rightskip{\z@}% {\z@ plus 1fill}
\let\itemize@hook\relax

% description
\def\description@indent{\list@parindent}
\let\description@topsep\smallskipamount
\let\description@hook\relax

% quotation
\let\quotation@size\footnotesize
\def\quotation@itemindent{\list@parindent}
\def\quotation@parindent{\list@parindent}
\def\quotation@leftmargin{\list@parindent}
\let\quotation@rightmargin\z@
\let\quotation@topsep\smallskipamount

% quote
\let\quote@size\footnotesize
\def\quote@indent{\z@}
\def\quote@leftmargin{2pc}
\def\quote@rightmargin{2pc}
\let\quote@topsep\smallskipamount

% verse
\def\verse@margin{2pc}
\let\verse@topsep\smallskipamount

%%%%%%%%%%%%%% Enumerate

\def\enumerate{\@ifnextchar[{\@enumerate}{\@enumerate[]}}

\def\@enumerate[#1]{%
    \ifnum \@enumdepth >\thr@@ \@toodeep\else
    \advance\@enumdepth \@ne 
    \edef\@enumctr{enum\romannumeral\the\@enumdepth}%
    \list {\csname label\@enumctr\endcsname}%
       {\usecounter{\@enumctr}
        \def\makelabel##1{{\hfill\normalfont ##1}}
%
        \ifx.#1.%
           \setcounter{\@enumctr}{3}% 
           \expandafter\settowidth\expandafter\labelwidth\expandafter{\csname label\@enumctr\endcsname}%
           \setcounter{\@enumctr}{0}%
        \else%
           \settowidth{\labelwidth}{#1}
        \fi%
        \labelsep=\enumerate@labelsep%
        \itemindent=\labelwidth \advance\itemindent\labelsep%
        \ifnum \@enumdepth=1\advance\itemindent by\enumerate@indent\fi%
        \leftmargin=\the\itemindent%
        \itemindent\z@%
        \partopsep\z@  \parsep\z@ \itemsep\z@ \rightmargin\z@
        \ifnum \@enumdepth=1 \topsep\enumerate@firsttopsep \else \topsep\enumerate@topsep\fi%
        \listparindent\enumerate@parindent%        
        \@rightskip\enumerate@rightskip%
        \enumerate@hook% 
        }\fi}


%%%%%%%%%%%%%%  itemize

\def\itemize{\@ifnextchar[{\@itemize}{\@itemize[]}}

\def\@itemize[#1]{%
    \ifnum \@itemdepth >\thr@@ \@toodeep\else
    \advance\@itemdepth \@ne 
    \edef\@itemitem{labelitem\romannumeral\the\@itemdepth}%
    \list {\csname\@itemitem\endcsname}%
       {\def\makelabel##1{{\hfill\normalfont ##1}}        
%
        \ifx.#1.%
           \settowidth\labelwidth{\csname\@itemitem\endcsname}%
        \else%
           \settowidth{\labelwidth}{#1}
        \fi%
        \labelsep=\itemize@labelsep%
        \itemindent=\labelwidth \advance\itemindent\labelsep%
        \ifnum \@itemdepth=1\advance\itemindent by\itemize@indent\fi%
        \leftmargin=\the\itemindent%
        \itemindent\z@%
        \partopsep\z@  \parsep\z@ \itemsep\z@ \rightmargin\z@
        \ifnum \@itemdepth=1 \topsep\itemize@firsttopsep \else \topsep\itemize@topsep\fi%
        \listparindent\itemize@parindent%        
        \@rightskip\itemize@rightskip%
        \itemize@hook% 
        }\fi}

%%%%%%%%%%%%%%  description

\def\description{%
         \list{}{\labelwidth\z@ \labelsep\z@  \rightmargin\z@
         \leftmargin\z@ \advance\leftmargin by\description@indent
         \itemindent-\description@indent
         \partopsep\z@ \topsep\description@topsep \parsep\z@
         \itemsep\z@ \listparindent\z@
         \description@hook%
         \let\makelabel\descriptionlabel}}

\def\enddescription{\endlist}

\def\descriptionlabel#1{\if.#1.\else\bfseries #1\hskip.5em\fi}

%%%%%%%%%%%%%%  quotation

\def\quotation{%
        \list{}{\quotation@size%
        \listparindent\quotation@parindent%
        \itemindent   \quotation@itemindent%
        \rightmargin\quotation@rightmargin   \leftmargin\quotation@leftmargin%
        \partopsep\z@ \topsep\quotation@topsep \parsep\z@%
                        }%
        \item[\Q@strut]\relax}

\def\endquotation{\endlist}

\def\Q@strut{\leavevmode\hbox{\vrule height9pt depth1pt width0pt}}

%%%%%%%%%%%%%%  quote

\def\quote{%
        \list{}{\quote@size%
        \listparindent\quote@indent%
        \itemindent \listparindent%
        \rightmargin\quote@rightmargin   \leftmargin\quote@leftmargin%
        \partopsep\z@ \topsep\quote@topsep \parsep\z@%
                       }%
        \item\relax}

\def\endquote{\endlist}

%%%%%%%%%%%%%%  verse


\def\verse{%
   \let\\\@centercr
   \list{}{\itemindent\z@ \listparindent\z@ \rightmargin\verse@margin \leftmargin\rightmargin
	   \partopsep\z@ \parsep\z@ \topsep\verse@topsep \itemsep\z@}%
   \item\relax}

\def\endverse{\endlist}



%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% appendix
\newif\ifappend

\def\appendix{\clearpage\thispagestyle{empty}
  \setcounter{chapter}{0}
  \setcounter{section}{0}
  \setcounter{subsection}{0}
  \appendtrue
  \def\@chapapp{App.\ }
  \def\thechapter{\Alph{chapter}}%
  \edef\chaptername{Appendix}%
  \immediate\write\@auxout{\string\@writefile{toc}{\string\edef\string\chaptername{Appendix}}}%
  }


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% thebibliography

% normal *numbered* bibliography
\def\@openbib@code{\addcontentsline{toc}{chapter}{Bibliography}\markboth{\bibname}{\bibname}\itemsep\z@}

% check for natbib package:
\def\check@natbib{%
\@ifpackageloaded{natbib}{% natbib is loaded
    \setlength\bibsep{0pt}%
    \renewcommand{\bibsection}{%
      \chapter*{\bibname}
      \markboth{\bibname}{\bibname}
      \csname phantomsection\endcsname
      \addcontentsline{toc}{chapter}{\bibname}}
}{}}

\AtBeginDocument{\check@natbib}


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% table of contents
\setcounter{tocdepth}{1}

\renewcommand\@dotsep{10000}

\renewcommand*\l@part[2]{%
  \ifnum \c@tocdepth >-2\relax
    \addpenalty{-\@highpenalty}%
    \medskip
    \begingroup
      \parindent \z@ 
      \def\numberline##1{\ifx.##1.\else\partname\ ##1.\enspace\fi}
      {\leavevmode
       \bfseries #1}\par
       \nobreak
         \global\@nobreaktrue
         \everypar{\global\@nobreakfalse\everypar{}}%
    \endgroup
  \fi}


\renewcommand*\l@chapter[2]{%
  \ifnum \c@tocdepth >\m@ne
    \addpenalty{-\@highpenalty}%
    \smallskip
    \setlength\@tempdima{1.5em}%
    \begingroup
      \parindent \z@ \rightskip \@pnumwidth
      \parfillskip -\@pnumwidth
      \def\numberline##1{\ifx.##1.\else\chaptername\ ##1.\enspace\fi}
      \leavevmode \bfseries
      \advance\leftskip\@tempdima
      \hskip -\leftskip
      #1\nobreak\hfil \nobreak\hb@xt@\@pnumwidth{\hss #2}\par
      \penalty\@highpenalty
    \endgroup
  \fi}

\def\@chapter[#1]#2{\ifnum \c@secnumdepth >\m@ne
                       \if@mainmatter
                         \refstepcounter{chapter}%
                         \typeout{\@chapapp\space\thechapter.}%
                         \addcontentsline{toc}{chapter}%
                                   {\protect\numberline{\thechapter}#2}%
                       \else
                         \addcontentsline{toc}{chapter}{#2}%
                       \fi
                    \else
                      \addcontentsline{toc}{chapter}{#2}%
                    \fi
                    \chaptermark{#1}%
                    \addtocontents{lof}{\protect\addvspace{10\p@}}%
                    \addtocontents{lot}{\protect\addvspace{10\p@}}%
                    \if@twocolumn
                      \@topnewpage[\@makechapterhead{#2}]%
                    \else
                      \@makechapterhead{#2}%
                      \@afterheading
                    \fi}


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% support macros

% no rh on empty pages
\def\cleardoublepage{\clearpage\ifodd\c@page\else\hbox{}\thispagestyle{empty}\newpage\fi}


\def\no@harm{\let\thanks=\@gobble\let~\space \let\\=\@empty \def\protect{\noexpand\protect\noexpand}}


\def\nohyphen{\pretolerance=\@M \tolerance=\@M \hyphenpenalty=\@M \exhyphenpenalty=\@M}

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% setpkgattr, getpkgattr, do@option@list

\def\setpkgattr{\@ifnextchar[\@setpkgattr{\@setpkgattr[]}}
\def\@setpkgattr[#1]#2#3#4{\expandafter\gdef\csname #2@#3\endcsname{#4}}
\def\getpkgattr#1#2{\csname #1@#2\endcsname}
\def\sep@key@value#1=#2/?/#3{\setpkgattr{#3}{#1}{#2}}
\def\do@option@list#1#2{%
  \@for\curr@option:={#2}\do{%
    \expandafter\sep@key@value\curr@option/?/{#1}\relax
  }%
}


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% settings
\def\pubyear#1{\def\@pubyear{#1}}


\setpkgattr{runninghead}{size} {\footnotesize}
\setpkgattr{pagenumber} {size} {\footnotesize}
\setpkgattr{publisher}  {text} {IOS Press}
\setpkgattr{book}     {rights} {\textcopyright\ \@pubyear\ \@author. All rights reserved.}

\setpkgattr{copyright}  {size} {\footnotesize\raggedright\itshape}
\setpkgattr{copyright}{text}{
   \@ifundefined{@title}  {}{\@title\\}%
   \@ifundefined{@author} {}{\@author\\}%
   \@ifundefined{@pubyear}{}{\publisher@text, \@pubyear\\}
   \@ifundefined{@pubyear}{}{\book@rights}}


\if@proof@mode
  \let\ps@headings\ps@empty  
  \let\ps@plain\ps@empty
  \let\ps@copyright\ps@empty
\fi

\ps@headings

\endinput
%%
%% End of file `ios-book.cls'.
