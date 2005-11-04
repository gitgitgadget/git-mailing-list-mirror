From: Petr Baudis <pasky@suse.cz>
Subject: [PATCH] Document the --no-commit flag
Date: Fri, 04 Nov 2005 15:55:05 +0100
Message-ID: <20051104145505.6586.32084.stgit@machine.or.cz>
Cc: <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Fri Nov 04 15:57:03 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1EY2yG-0003kC-T8
	for gcvg-git@gmane.org; Fri, 04 Nov 2005 15:55:13 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750759AbVKDOzJ (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 4 Nov 2005 09:55:09 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750959AbVKDOzJ
	(ORCPT <rfc822;git-outgoing>); Fri, 4 Nov 2005 09:55:09 -0500
Received: from w241.dkm.cz ([62.24.88.241]:29096 "EHLO machine.or.cz")
	by vger.kernel.org with ESMTP id S1750759AbVKDOzH (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 4 Nov 2005 09:55:07 -0500
Received: (qmail 6606 invoked from network); 4 Nov 2005 15:55:05 +0100
Received: from localhost (HELO machine.or.cz) (127.0.0.1)
  by localhost with SMTP; 4 Nov 2005 15:55:05 +0100
To: Junio C Hamano <junkio@cox.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/11131>

Also add the reference to merge and fetch options in git-pull's synopsis.

Signed-off-by: Petr Baudis <pasky@suse.cz>
---

 Documentation/git-merge.txt |    6 +++++-
 Documentation/git-pull.txt  |    2 +-
 git-pull.sh                 |    2 +-
 3 files changed, 7 insertions(+), 3 deletions(-)

diff --git a/Documentation/git-merge.txt b/Documentation/git-merge.txt
index 8c9c4d8..4174da9 100644
--- a/Documentation/git-merge.txt
+++ b/Documentation/git-merge.txt
@@ -8,7 +8,7 @@ git-merge - Grand Unified Merge Driver
 
 SYNOPSIS
 --------
-'git-merge' [-n] [-s <strategy>]... <msg> <head> <remote> <remote>...
+'git-merge' [-n] [--no-commit] [-s <strategy>]... <msg> <head> <remote> <remote>...
 
 
 DESCRIPTION
@@ -22,6 +22,10 @@ OPTIONS
 -n::
 	Do not show diffstat at the end of the merge.
 
+--no-commit::
+	Do not commit right away - it just does the merge and lets you commit
+	manually after you inspect the changes done.
+
 -s <strategy>::
 	use that merge strategy; can be given more than once to
 	specify them in the order they should be tried.  If
diff --git a/Documentation/git-pull.txt b/Documentation/git-pull.txt
index cef4c0a..a46d6b9 100644
--- a/Documentation/git-pull.txt
+++ b/Documentation/git-pull.txt
@@ -8,7 +8,7 @@ git-pull - Pull and merge from another r
 
 SYNOPSIS
 --------
-'git-pull' <repository> <refspec>...
+'git-pull' [merge_options] [fetch_options] <repository> <refspec>...
 
 
 DESCRIPTION
diff --git a/git-pull.sh b/git-pull.sh
index 9601627..e23d4f5 100755
--- a/git-pull.sh
+++ b/git-pull.sh
@@ -7,7 +7,7 @@
 . git-sh-setup || die "Not a git archive"
 
 usage () {
-    die "git pull [-n] [-s strategy]... <repo> <head>..."
+    die "git pull [-n] [--no-commit] [-s strategy]... <repo> <head>..."
 }
 
 strategy_args= no_summary= no_commit=
