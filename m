From: Jonas Fonseca <fonseca@diku.dk>
Subject: [ANNOUNCE] tig-1.0
Date: Thu, 10 May 2012 15:44:49 +0200
Message-ID: <20120510134449.GA31836@diku.dk>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu May 10 15:44:28 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SSTfP-00038u-Km
	for gcvg-git-2@plane.gmane.org; Thu, 10 May 2012 15:44:27 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758865Ab2EJNoY convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 10 May 2012 09:44:24 -0400
Received: from mgw2.diku.dk ([130.225.96.92]:45599 "EHLO mgw2.diku.dk"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1758840Ab2EJNoX (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 10 May 2012 09:44:23 -0400
Received: from localhost (localhost [127.0.0.1])
	by mgw2.diku.dk (Postfix) with ESMTP id 7598019BDFB
	for <git@vger.kernel.org>; Thu, 10 May 2012 15:44:21 +0200 (CEST)
Received: from mgw2.diku.dk ([127.0.0.1])
 by localhost (mgw2.diku.dk [127.0.0.1]) (amavisd-new, port 10024) with ESMTP
 id 06311-15 for <git@vger.kernel.org>; Thu, 10 May 2012 15:44:16 +0200 (CEST)
Received: from nhugin.diku.dk (nhugin.diku.dk [130.225.96.140])
	by mgw2.diku.dk (Postfix) with ESMTP id 71DD119BDE3
	for <git@vger.kernel.org>; Thu, 10 May 2012 15:44:16 +0200 (CEST)
Received: from tyr.diku.dk (tyr.diku.dk [130.225.96.226])
	by nhugin.diku.dk (Postfix) with ESMTP id 2E3AE6DFD82
	for <git@vger.kernel.org>; Thu, 10 May 2012 15:39:28 +0200 (CEST)
Received: by tyr.diku.dk (Postfix, from userid 3873)
	id 62A9423A95; Thu, 10 May 2012 15:44:49 +0200 (CEST)
Content-Disposition: inline
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/197563>

Hello,

Version 1.0 of tig is now available. This release brings many smaller
tweaks and improvements as well as a number of fixes and compatibility
changes to work with the newer versions of git. See the release notes
below for a detailed list of changes.

Note that the master repository has been moved to:

	git://github.com/jonas/tig.git.

So if you were tracking the old master repository, please update your
=2Egit/config or run:

	$ git remote set-url origin git://github.com/jonas/tig.git

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

Release notes
-------------
The master repository is git://github.com/jonas/tig.git, and the old
master repository (http://jonas.nitro.dk/tig/tig.git) will be retired.

Improvements:

 - Use git-log(1)s default commit ordering. The old behavior can be
   restored by adding `set commit-order =3D topo` to ~/.tigrc.
 - Support staging of single lines. Bound to '1' default. (GH #21)
 - Use +<lineno> to open the initial view at an arbitrary line. (GH #20=
)
 - Add show-notes ~/.tigrc option. Notes are displayed by default.
 - Support jumping to specific SHAs in the main view.
 - Decorate replaced commits.
 - Display line numbers in main view.
 - Colorize binary diff stats. (GH #17)
 - Custom colorization of lines matching a string prefix (GH #16).
   Example configuration: color "Reported-by:" green default
 - Use git's color settings for the main, status and diff views.
   Put `set read-git-colors =3D no` in ~/.tigrc to disable.
 - Handle editor options with multiple arguments. (GH #12)
 - Show filename when running tig blame with copy detection. (GH #19)
 - Use 'source <path>' command to load additional files from ~/.tigrc
 - User-defined commands prefixed with '@' are run with no console
   output, e.g.

   	bind generic 3 !@rm sys$command

 - Make display of space changes togglable in the diff and stage view.
   Bound to 'W' by default.
 - Use per-file encoding specified in gitattributes(5) for blobs and
   unstaged files.
 - Obsolete commit-encoding option and pass --encoding=3DUTF-8 to revis=
ion
   commands.
 - Main view: show uncommitted changes as staged/unstaged commits.
   Can be disabled by putting `set show-changes =3D no` in ~/.tigrc.
 - Add %(prompt) external command variable, which will prompt for the
   argument value.
 - Log information about git commands when the TIG_TRACE environment
   variable is set. Example: `TIG_TRACE=3D/tmp/tig.log tig`
 - Branch view: Show the title of the last commit.
 - Increase the author auto-abbreviation threshold to 10. (GH #49)
 - For old commits show number of years in relative dates. (GH #50)

Bug fixes:

 - Fix navigation behavior when going from branch to main view. (GH #38=
)
 - Fix segfault when sorting the tree view by author name.
 - Fix diff stat navigation for unmodified files with stat changes.
 - Show branches/refs which names are a substring of the current branch=
=2E
 - Stage view: fix off-by-one error when jumping to a file in a diff
   with only one file.
 - Fix diff-header colorization. (GH #15)

Change summary
--------------
The diffstat and log summary for changes made in this release.

 BUGS                        |    6 +-
 INSTALL                     |    5 +-
 Makefile                    |   29 +-
 NEWS                        |   56 +
 SITES                       |    4 +-
 TODO                        |   41 -
 VERSION                     |    1 -
 asciidoc.conf               |    3 +
 contrib/aspell.dict         |   17 +-
 contrib/release.sh          |    4 +-
 contrib/tig-completion.bash |    4 +-
 contrib/tig.spec.in         |    2 +-
 contrib/tigrc               |    1 -
 git.h                       |   55 +
 io.c                        |  167 +++-
 io.h                        |   14 +-
 manual.txt                  |   13 +-
 refs.c                      |  242 ++++
 refs.h                      |   41 +
 tig.1.txt                   |   15 +-
 tig.c                       | 2514 ++++++++++++++++++++++-------------
 tig.h                       |  107 ++-
 tigmanual.7.txt             |    2 +-
 tigrc.5.txt                 |   99 ++-
 24 files changed, 2368 insertions(+), 1074 deletions(-)

     4	Giuseppe Bilotta
     6	Heiko Schlichting
   108	Jonas Fonseca
     3	Jonathan Neusch=E4fer
     1	Kumar Appaiah
     1	Michael J Gruber
     1	P. Sadik
     1	Pierre Habouzit
     1	Robert Clausecker
     1	Romain Francoise
     9	Thomas Sibley
     1	Vivien Didelot
     2	zomfg

--=20
Jonas Fonseca
