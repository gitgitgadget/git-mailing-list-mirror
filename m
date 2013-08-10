From: Jonas Fonseca <fonseca@diku.dk>
Subject: [ANNOUNCE] tig-1.2
Date: Sat, 10 Aug 2013 16:54:32 +0200
Message-ID: <20130810145431.GA32420@diku.dk>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Aug 10 17:19:15 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1V8Awj-0002H8-FN
	for gcvg-git-2@plane.gmane.org; Sat, 10 Aug 2013 17:19:13 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S934280Ab3HJPTI convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sat, 10 Aug 2013 11:19:08 -0400
Received: from mgw2.diku.dk ([130.225.96.92]:42746 "EHLO mgw2.diku.dk"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S934153Ab3HJPTH (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 10 Aug 2013 11:19:07 -0400
X-Greylist: delayed 1463 seconds by postgrey-1.27 at vger.kernel.org; Sat, 10 Aug 2013 11:19:06 EDT
Received: from localhost (localhost [127.0.0.1])
	by mgw2.diku.dk (Postfix) with ESMTP id BDD2219BCC8
	for <git@vger.kernel.org>; Sat, 10 Aug 2013 16:54:40 +0200 (CEST)
Received: from mgw2.diku.dk ([127.0.0.1])
 by localhost (mgw2.diku.dk [127.0.0.1]) (amavisd-new, port 10024) with ESMTP
 id 31841-16 for <git@vger.kernel.org>; Sat, 10 Aug 2013 16:54:32 +0200 (CEST)
Received: from nhugin.diku.dk (nhugin.diku.dk [130.225.96.140])
	by mgw2.diku.dk (Postfix) with ESMTP id 3FD6D19BC9E
	for <git@vger.kernel.org>; Sat, 10 Aug 2013 16:54:32 +0200 (CEST)
Received: from tyr.diku.dk (tyr.diku.dk [130.225.96.226])
	by nhugin.diku.dk (Postfix) with ESMTP id AAD6B6DF9AB
	for <git@vger.kernel.org>; Sat, 10 Aug 2013 16:54:14 +0200 (CEST)
Received: by tyr.diku.dk (Postfix, from userid 3873)
	id 227512A72E; Sat, 10 Aug 2013 16:54:32 +0200 (CEST)
Content-Disposition: inline
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/232102>

Hello,

It's been almost a year since the last release of tig, so here is a muc=
h
needed update. It brings a lot of cool new features, such as the abilit=
y
to jump directly from diff to the corresponding line in the changed
file, a stash view, improvements to the log view, plus a bunch of bug
fixes.

On behalf of everyone who contributed to this release, please enjoy.

What is tig?
------------
Tig is an ncurses-based text-mode interface for git. It functions mainl=
y
as a git repository browser, but can also assist in staging changes for
commit at chunk level and act as a pager for output from various git
commands.

 - Homepage:	http://jonas.nitro.dk/tig/
 - Manual:	http://jonas.nitro.dk/tig/manual.html
 - Tarballs:	http://jonas.nitro.dk/tig/releases/
 - Git URL:	git://github.com/jonas/tig.git=20
 - Gitweb:	http://repo.or.cz/w/tig.git
 - Q&A:		http://stackoverflow.com/questions/tagged/tig

Release notes
-------------
 - Tig now has its own tag on Stack Overflow, where users are invited t=
o
   ask questions: http://stackoverflow.com/questions/tagged/tig

Improvements:

 - Make tig prompt commands bindable to keys. For example:
   `bind diff F :set diff-options =3D --full-diff`. (GH #69, #116)
 - Add a diff-options setting for specifying default diff options.
   Example: `set diff-options =3D --patience`. (GH #116)
 - Options in diff-options and blame-options matching tig browsing stat=
e
   variables are replaced.
 - Show diff stats as wide as the terminal. (GH #109)
 - Show line numbers in the branch view. (GH #135)
 - Add toggles for showing author email or email user names. (GH #115)
 - Open editor at the selected line by prefixing the file argument with
   `+<lineno>`. Tested in vi, vim, emacs, nano, gedit, geany. Disable
   by adding `set editor-line-number =3D no` to ~/.tigrc. (GH #118, #11=
9)
 - Add toggle-files to control whether to show full commit diff or only
   the diff concerning the currently selected file, e.g. for blame.
 - Optionally highlight exceeding characters in long commit titles.
   The default title max width is 50 characters. Customize using:
   `set title-overflow =3D 50` (GH #125)
 - Add +ESC key bindings. Example: `bind generic ^[v move-page-up` (GH =
#120)
 - Create temporary files in TMPDIR, TEMP, or TMP before defaulting to =
/tmp.
 - Reenable `tig log` as a subcommand. (GH #146)
 - Enable tilde expansion in ~/.tigrc "source" commands. (GH #168)
 - Introduce the stash view, bound to the 'y' keybinding. (GH #169, #17=
4)

Bug fixes:

 - Fix blame and status to work in directories starting with a dot. (GH=
 #172)
 - Reload current branch name when reloading the status view. (GH #93)
 - Fix compile errors on old Solaris. (GH #97)
 - Reload HEAD info when reloading the stage view. (GH #104, #93)
 - Fix disappearing branch labels after external commands. (GH #148)
 - Fix diff view display for staged/unstaged changes when using 'd'.
 - Fix display of status messages when toggling view options. (GH #111)
 - Fix illegal memory access. (GH #98)
 - Fix display of all branches label in repos with short branch names.
 - Fix rendering glitch for branch names.
 - Do not apply diff styling to untracked files in the stage view. (GH =
#153)
 - Fix tree indentation for entries containing combining characters. (G=
H #170)
 - Ignore unrepresentable characters when transliterating text for rend=
ering.
 - Transliterate text to output encoding before trimming it to avoid
   misalignment. (GH #86)
 - Introduce a more natural context-sensitive log display. (GH #155)

Change summary
--------------
The diffstat and log summary for changes made in this release.

 BUGS                        |    3 +-
 Makefile                    |   32 +-
 NEWS                        |   51 ++
 SITES                       |    1 +
 autogen.sh                  |    2 +-
 compat/compat.h             |   44 ++
 compat/mkstemps.c           |  152 +++++
 compat/setenv.c             |  186 ++++++
 config.make.in              |    4 +
 configure.ac                |   13 +-
 contrib/aspell.dict         |    3 +-
 contrib/config.make-Darwin  |    1 +
 contrib/header.h            |   12 +
 contrib/tig-completion.bash |    2 +-
 contrib/tig.spec.in         |    4 +
 git.h                       |    4 +-
 graph.c                     |   10 +-
 graph.h                     |    5 +-
 io.c                        |   42 +-
 io.h                        |    7 +-
 manual.txt                  |   34 +-
 refs.c                      |   12 +-
 refs.h                      |    5 +-
 test-graph.c                |   24 +-
 tig.1.txt                   |   18 +-
 tig.c                       | 1124 +++++++++++++++++++++++++----------
 tig.h                       |   32 +-
 tigrc.5.txt                 |   69 ++-
 28 files changed, 1509 insertions(+), 387 deletions(-)

     1	Aaron Franks
     1	Beat Bolli
     1	Dominik Vogt
     2	Drew Northup
     3	IWASAKI Yudai
     1	Joakim Sernbrant
    61	Jonas Fonseca
     1	Julian Langschaedel
     4	Kumar Appaiah
     1	Menghan Zheng
     1	Michael Gr=FCnewald
     1	Rafael Laboissiere
     1	Romain Francoise
     2	Sven Wegener
    10	Thomas Sibley
     1	Tristan Matthews
     8	Vivien Didelot
     1	lvzhandong

--=20
Jonas Fonseca
