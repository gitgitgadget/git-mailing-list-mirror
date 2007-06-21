From: "Shawn O. Pearce" <spearce@spearce.org>
Subject: [PATCH 1/2] Document git-gui, git-citool as mainporcelain manual pages
Date: Thu, 21 Jun 2007 00:51:00 -0400
Message-ID: <20070621045100.GA13977@spearce.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Jakub Narebski <jnareb@gmail.com>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu Jun 21 06:51:19 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1I1EdY-0002at-Rt
	for gcvg-git@gmane.org; Thu, 21 Jun 2007 06:51:17 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753004AbXFUEvJ (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 21 Jun 2007 00:51:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752870AbXFUEvI
	(ORCPT <rfc822;git-outgoing>); Thu, 21 Jun 2007 00:51:08 -0400
Received: from corvette.plexpod.net ([64.38.20.226]:37308 "EHLO
	corvette.plexpod.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752776AbXFUEvH (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 21 Jun 2007 00:51:07 -0400
Received: from [74.70.48.173] (helo=asimov.home.spearce.org)
	by corvette.plexpod.net with esmtpa (Exim 4.66)
	(envelope-from <spearce@spearce.org>)
	id 1I1EdK-0001wF-U9; Thu, 21 Jun 2007 00:51:03 -0400
Received: by asimov.home.spearce.org (Postfix, from userid 1000)
	id EAF4720FBAE; Thu, 21 Jun 2007 00:51:00 -0400 (EDT)
Content-Disposition: inline
User-Agent: Mutt/1.5.11
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - corvette.plexpod.net
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - spearce.org
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/50591>

Jakub Narebski pointed out that the git-gui blame viewer is not a
widely known feature, but is incredibly useful.  Part of the issue
is advertising.  Up until now we haven't even referenced git-gui from
within the core Git manual pages, mostly because I just wasn't sure
how I wanted to supply git-gui documentation to end-users, or how
that documentation should integrate with the core Git documentation.

Based upon Jakub's comment that many users may not even know that
the gui is available in a stock Git distribution I'm offering up
two basic manual pages: git-citool and git-gui.  These should offer
enough of a starting point for users to identify that the gui exists,
and how to start it.  Future releases of git-gui may contain their
own documentation system available from within a running git-gui.
But not today.

Signed-off-by: Shawn O. Pearce <spearce@spearce.org>
---

 From Jakub Narebski <jnareb@gmail.com>:
 > It would be nice though to have git-gui(1) man page describing
 > 'blame' subcommand of git-gui

 Yes, it would!  You might find one below.  ;-)


 Documentation/cmd-list.perl  |    2 +
 Documentation/git-citool.txt |   32 ++++++++++++
 Documentation/git-gui.txt    |  115 ++++++++++++++++++++++++++++++++++++++++++
 git.spec.in                  |   12 +++--
 4 files changed, 156 insertions(+), 5 deletions(-)
 create mode 100644 Documentation/git-citool.txt
 create mode 100644 Documentation/git-gui.txt

diff --git a/Documentation/cmd-list.perl b/Documentation/cmd-list.perl
index a181f75..fcea1d7 100755
--- a/Documentation/cmd-list.perl
+++ b/Documentation/cmd-list.perl
@@ -86,6 +86,7 @@ git-check-attr                          purehelpers
 git-check-ref-format                    purehelpers
 git-cherry                              ancillaryinterrogators
 git-cherry-pick                         mainporcelain
+git-citool                              mainporcelain
 git-clean                               mainporcelain
 git-clone                               mainporcelain
 git-commit                              mainporcelain
@@ -111,6 +112,7 @@ git-fsck	                        ancillaryinterrogators
 git-gc                                  mainporcelain
 git-get-tar-commit-id                   ancillaryinterrogators
 git-grep                                mainporcelain
+git-gui                                 mainporcelain
 git-hash-object                         plumbingmanipulators
 git-http-fetch                          synchelpers
 git-http-push                           synchelpers
diff --git a/Documentation/git-citool.txt b/Documentation/git-citool.txt
new file mode 100644
index 0000000..5217ab2
--- /dev/null
+++ b/Documentation/git-citool.txt
@@ -0,0 +1,32 @@
+git-citool(1)
+=============
+
+NAME
+----
+git-citool - Graphical alternative to git-commit
+
+SYNOPSIS
+--------
+'git citool'
+
+DESCRIPTION
+-----------
+A Tcl/Tk based graphical interface to review modified files, stage
+them into the index, enter a commit message and record the new
+commit onto the current branch.  This interface is an alternative
+to the less interactive gitlink:git-commit[1] program.
+
+git-citool is actually a standard alias for 'git gui citool'.
+See gitlink:git-gui[1] for more details.
+
+Author
+------
+Written by Shawn O. Pearce <spearce@spearce.org>.
+
+Documentation
+--------------
+Documentation by Shawn O. Pearce <spearce@spearce.org>.
+
+GIT
+---
+Part of the gitlink:git[7] suite
diff --git a/Documentation/git-gui.txt b/Documentation/git-gui.txt
new file mode 100644
index 0000000..bd613b2
--- /dev/null
+++ b/Documentation/git-gui.txt
@@ -0,0 +1,115 @@
+git-gui(1)
+==========
+
+NAME
+----
+git-gui - A portable graphical interface to Git
+
+SYNOPSIS
+--------
+'git gui' [<command>] [arguments]
+
+DESCRIPTION
+-----------
+A Tcl/Tk based graphical user interface to Git.  git-gui focuses
+on allowing users to make changes to their repository by making
+new commits, amending existing ones, creating branches, performing
+local merges, and fetching/pushing to remote repositories.
+
+Unlike gitlink:gitk[1], git-gui focuses on commit generation
+and single file annotation, and does not show project history.
+It does however supply menu actions to start a gitk session from
+within git-gui.
+
+git-gui is known to work on all popular UNIX systems, Mac OS X,
+and Windows (under both Cygwin and MSYS).  To the extent possible
+OS specific user interface guidelines are followed, making git-gui
+a fairly native interface for users.
+
+COMMANDS
+--------
+blame::
+	Start a blame viewer on the specified file on the given
+	version (or working directory if not specified).
+
+browser::
+	Start a tree browser showing all files in the specified
+	commit (or 'HEAD' by default).	Files selected through the
+	browser are opened in the blame viewer.
+
+citool::
+	Start git-gui and arrange to make exactly one commit before
+	exiting and returning to the shell.  The interface is limited
+	to only commit actions, slightly reducing the application's
+	startup time and simplifying the menubar.
+
+version::
+	Display the currently running version of git-gui.
+
+
+Examples
+--------
+git gui blame Makefile::
+
+	Show the contents of the file 'Makefile' in the current
+	working directory, and provide annotations for both the
+	original author of each line, and who moved the line to its
+	current location.  The uncommitted file is annotated, and
+	uncommitted changes (if any) are explicitly attributed to
+	'Not Yet Committed'.
+
+git gui blame v0.99.8 Makefile::
+
+	Show the contents of 'Makefile' in revision 'v0.99.8'
+	and provide annotations for each line.	Unlike the above
+	example the file is read from the object database and not
+	the working directory.
+
+git gui citool::
+
+	Make one commit and return to the shell when it is complete.
+
+git citool::
+
+	Same as 'git gui citool' (above).
+
+git gui browser maint::
+
+	Show a browser for the tree of the 'maint' branch.  Files
+	selected in the browser can be viewed with the internal
+	blame viewer.
+
+See Also
+--------
+'gitk(1)'::
+	The git repository browser.  Shows branches, commit history
+	and file differences.  gitk is the utility started by
+	git-gui's Repository Visualize actions.
+
+Other
+-----
+git-gui is actually maintained as an independent project, but stable
+versions are distributed as part of the Git suite for the convience
+of end users.
+
+A git-gui development repository can be obtained from:
+
+  git clone git://repo.or.cz/git-gui.git
+
+or
+
+  git clone http://repo.or.cz/r/git-gui.git
+
+or browsed online at http://repo.or.cz/w/git-gui.git/[].
+
+Author
+------
+Written by Shawn O. Pearce <spearce@spearce.org>.
+
+Documentation
+--------------
+Documentation by Shawn O. Pearce <spearce@spearce.org>.
+
+GIT
+---
+Part of the gitlink:git[7] suite
diff --git a/git.spec.in b/git.spec.in
index b9dc1d5..287057e 100644
--- a/git.spec.in
+++ b/git.spec.in
@@ -164,11 +164,10 @@ rm -rf $RPM_BUILD_ROOT
 %{_bindir}/git-gui
 %{_bindir}/git-citool
 %{_datadir}/git-gui/
-# Not Yet...
-# %{!?_without_docs: %{_mandir}/man1/git-gui.1}
-# %{!?_without_docs: %doc Documentation/git-gui.html}
-# %{!?_without_docs: %{_mandir}/man1/git-citool.1}
-# %{!?_without_docs: %doc Documentation/git-citool.html}
+%{!?_without_docs: %{_mandir}/man1/git-gui.1}
+%{!?_without_docs: %doc Documentation/git-gui.html}
+%{!?_without_docs: %{_mandir}/man1/git-citool.1}
+%{!?_without_docs: %doc Documentation/git-citool.html}
 
 %files -n gitk
 %defattr(-,root,root)
@@ -188,6 +187,9 @@ rm -rf $RPM_BUILD_ROOT
 %{!?_without_docs: %doc Documentation/technical}
 
 %changelog
+* Thu Jun 21 2007 Shawn O. Pearce <spearce@spearce.org>
+- Added documentation files for git-gui
+
 * Tue May 13 2007 Quy Tonthat <qtonthat@gmail.com>
 - Added lib files for git-gui
 - Added Documentation/technical (As needed by Git Users Manual)
-- 
1.5.2.2.1050.g51a8b
