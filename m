From: Petr Baudis <pasky@suse.cz>
Subject: [PATCH] Update the git-ls-tree documentation
Date: Mon, 05 Dec 2005 00:31:08 +0100
Message-ID: <20051204233108.6730.28024.stgit@machine.or.cz>
Cc: <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Mon Dec 05 00:32:27 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1Ej3Jo-0004q7-Q6
	for gcvg-git@gmane.org; Mon, 05 Dec 2005 00:30:57 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751325AbVLDXay (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 4 Dec 2005 18:30:54 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751327AbVLDXay
	(ORCPT <rfc822;git-outgoing>); Sun, 4 Dec 2005 18:30:54 -0500
Received: from w241.dkm.cz ([62.24.88.241]:62383 "EHLO machine.or.cz")
	by vger.kernel.org with ESMTP id S1751325AbVLDXax (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 4 Dec 2005 18:30:53 -0500
Received: (qmail 6744 invoked from network); 5 Dec 2005 00:31:08 +0100
Received: from localhost (HELO machine.or.cz) (xpasky@127.0.0.1)
  by localhost with SMTP; 5 Dec 2005 00:31:08 +0100
To: Junio C Hamano <junkio@cox.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/13198>

This patch aims to freshen up a bit the git-ls-tree documentation. It hints
that the list of paths are in fact patterns to be matched, explains the new
-t, --name-only and --name-status options, corrects the original autorship
information to refer to yours sincerely, corrects several grammar mistakes,
etc.

Since the documentation still deserves some significant work (at least
proper description of the pattern matching), I also added the stub notice.

Signed-off-by: Petr Baudis <pasky@suse.cz>
---

 Documentation/git-ls-tree.txt |   43 ++++++++++++++++++++++++++++-------------
 1 files changed, 29 insertions(+), 14 deletions(-)

diff --git a/Documentation/git-ls-tree.txt b/Documentation/git-ls-tree.txt
index ba0438e..b92a8b2 100644
--- a/Documentation/git-ls-tree.txt
+++ b/Documentation/git-ls-tree.txt
@@ -8,12 +8,15 @@ git-ls-tree - Lists the contents of a tr
 
 SYNOPSIS
 --------
-'git-ls-tree' [-d] [-r] [-z] <tree-ish> [paths...]
+'git-ls-tree' [-d] [-r] [-t] [-z] [--name-only] [--name-status] <tree-ish> [paths...]
 
 DESCRIPTION
 -----------
-Lists the contents of a tree object, like what "/bin/ls -a" does
-in the current working directory.
+Lists the contents of a given tree object, like what "/bin/ls -a" does
+in the current working directory. Note that the usage is subtly different,
+though - 'paths' denote just a list of patterns to match, e.g. so specifying
+directory name (without '-r') will behave differently, and order of the
+arguments does not matter.
 
 OPTIONS
 -------
@@ -21,36 +24,48 @@ OPTIONS
 	Id of a tree-ish.
 
 -d::
-	show only the named tree entry itself, not its children
+	Show only the named tree entry itself, not its children.
 
 -r::
-	recurse into sub-trees
+	Recurse into sub-trees.
+
+-t::
+	Show tree entries even when going to recurse them. Has no effect
+	if '-r' was not passed. '-d' implies '-t'.
 
 -z::
-	\0 line termination on output
+	\0 line termination on output.
+
+--name-only::
+--name-status::
+	List only filenames (instead of the "long" output), one per line.
 
 paths::
-	When paths are given, show them.  Otherwise implicitly
-	uses the root level of the tree as the sole path argument.
+	When paths are given, show them (note that this isn't really raw
+	pathnames, but rather a list of patterns to match).  Otherwise
+	implicitly uses the root level of the tree as the sole path argument.
 
 
 Output Format
 -------------
         <mode> SP <type> SP <object> TAB <file>
 
-When `-z` option is not used, TAB, LF, and backslash characters
-in pathnames are represented as `\t`, `\n`, and `\\`,
-respectively.
+When the `-z` option is not used, TAB, LF, and backslash characters
+in pathnames are represented as `\t`, `\n`, and `\\`, respectively.
 
 
 Author
 ------
-Written by Linus Torvalds <torvalds@osdl.org>
-Completely rewritten from scratch by Junio C Hamano <junkio@cox.net>
+Written by Petr Baudis <pasky@suse.cz>
+Completely rewritten from scratch by Junio C Hamano <junkio@cox.net>,
+another major rewrite by Linus Torvalds <torvalds@osdl.org>
 
 Documentation
 --------------
-Documentation by David Greaves, Junio C Hamano and the git-list <git@vger.kernel.org>.
+Documentation by David Greaves, Junio C Hamano and the git-list
+<git@vger.kernel.org>.
+
+This manual page is a stub. You can help the git documentation by expanding it.
 
 GIT
 ---
