From: Petr Baudis <pasky@suse.cz>
Subject: [PATCH] Documentation for git-fmt-merge-msg
Date: Tue, 01 Nov 2005 21:45:55 +0100
Message-ID: <20051101204555.19131.90275.stgit@machine.or.cz>
Cc: <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Tue Nov 01 21:47:43 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1EX31P-0003C0-Kt
	for gcvg-git@gmane.org; Tue, 01 Nov 2005 21:46:19 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751207AbVKAUp7 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 1 Nov 2005 15:45:59 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751212AbVKAUp6
	(ORCPT <rfc822;git-outgoing>); Tue, 1 Nov 2005 15:45:58 -0500
Received: from w241.dkm.cz ([62.24.88.241]:2495 "EHLO machine.or.cz")
	by vger.kernel.org with ESMTP id S1751207AbVKAUp5 (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 1 Nov 2005 15:45:57 -0500
Received: (qmail 19147 invoked from network); 1 Nov 2005 21:45:55 +0100
Received: from localhost (HELO machine.or.cz) (127.0.0.1)
  by localhost with SMTP; 1 Nov 2005 21:45:55 +0100
To: Junio C Hamano <junkio@cox.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/10953>

Simple description. It appears to be mostly internal command, but hey, it
is (it seems) the only undocumented one, so let's fix it up...

Also add a note about it to git-merge documentation.

Signed-off-by: Petr Baudis <pasky@suse.cz>
---

 Documentation/git-fmt-merge-msg.txt |   39 +++++++++++++++++++++++++++++++++++
 Documentation/git-merge.txt         |   10 +++++++++
 2 files changed, 49 insertions(+), 0 deletions(-)

diff --git a/Documentation/git-fmt-merge-msg.txt b/Documentation/git-fmt-merge-msg.txt
new file mode 100644
index 0000000..a70eb39
--- /dev/null
+++ b/Documentation/git-fmt-merge-msg.txt
@@ -0,0 +1,39 @@
+git-fmt-merge-msg(1)
+====================
+
+NAME
+----
+git-fmt-merge-msg - Produce a merge commit message
+
+
+SYNOPSIS
+--------
+'git-fmt-merge-msg' <$GIT_DIR/FETCH_HEAD
+
+DESCRIPTION
+-----------
+Takes the list of merged objects on stdin and produces a suitable
+commit message to be used for the merge commit, usually to be
+passed as the '<merge-message>' argument of `git-merge`.
+
+This script is intended mostly for internal use by scripts
+automatically invoking `git-merge`.
+
+
+SEE ALSO
+--------
+gitlink:git-merge[1]
+
+
+Author
+------
+Written by Junio C Hamano <junkio@cox.net>
+
+Documentation
+--------------
+Documentation by Petr Baudis, Junio C Hamano and the git-list <git@vger.kernel.org>.
+
+GIT
+---
+Part of the gitlink:git[7] suite
+
diff --git a/Documentation/git-merge.txt b/Documentation/git-merge.txt
index a007a8b..8c9c4d8 100644
--- a/Documentation/git-merge.txt
+++ b/Documentation/git-merge.txt
@@ -28,6 +28,11 @@ OPTIONS
 	there is no `-s` option, built-in list of strategies is
 	used instead.
 
+<msg>::
+	The commit message to be used for the merge commit (in case
+	it is created). The `git-fmt-merge-msg` script can be used
+	to give a good default for automated `git-merge` invocations.
+
 <head>::
 	our branch head commit.
 
@@ -37,6 +42,11 @@ OPTIONS
 	obviously means you are trying an Octopus.
 
 
+SEE ALSO
+--------
+gitlink:git-fmt-merge-msg[1]
+
+
 Author
 ------
 Written by Junio C Hamano <junkio@cox.net>
