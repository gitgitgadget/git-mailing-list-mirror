From: Steven Cole <elenstev@mesatop.com>
Subject: [PATCH] Add cg-printenv command.
Date: Sun, 8 May 2005 19:11:10 -0600
Message-ID: <200505081911.10371.elenstev@mesatop.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon May 09 03:09:11 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DUwla-0000m8-69
	for gcvg-git@gmane.org; Mon, 09 May 2005 03:09:02 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263019AbVEIBQI (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 8 May 2005 21:16:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263020AbVEIBQI
	(ORCPT <rfc822;git-outgoing>); Sun, 8 May 2005 21:16:08 -0400
Received: from nacho.zianet.com ([216.234.192.105]:55570 "HELO
	nacho.zianet.com") by vger.kernel.org with SMTP id S263019AbVEIBQB
	(ORCPT <rfc822;git@vger.kernel.org>); Sun, 8 May 2005 21:16:01 -0400
Received: (qmail 42768 invoked from network); 9 May 2005 01:15:59 -0000
Received: from 216-31-65-49.zianet.com (216.31.65.49)
  by 0 with SMTP; 9 May 2005 01:15:59 -0000
To: Petr Baudis <pasky@ucw.cz>
User-Agent: KMail/1.6.1
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

The cg-printenv command will print exported git environment variables.

Signed-off-by: Steven Cole <elenstev@mesatop.com>

Index: Makefile
===================================================================
--- 3974261da777f55a7a11aff6e02f584bbfe2b475/Makefile  (mode:100644)
+++ uncommitted/Makefile  (mode:100644)
@@ -48,7 +48,8 @@
 SCRIPT=	commit-id tree-id parent-id cg-add cg-admin-lsobj cg-admin-uncommit \
 	cg-branch-add cg-branch-ls cg-cancel cg-clone cg-commit cg-diff \
 	cg-export cg-help cg-init cg-log cg-ls cg-merge cg-mkpatch cg-patch \
-	cg-pull cg-restore cg-rm cg-seek cg-status cg-tag cg-tag-ls cg-update
+	cg-printenv cg-pull cg-restore cg-rm cg-seek cg-status cg-tag cg-tag-ls \
+	cg-update
 
 LIB_SCRIPT=cg-Xlib cg-Xdiffdo cg-Xmergefile
 
Index: cg-help
===================================================================
--- 3974261da777f55a7a11aff6e02f584bbfe2b475/cg-help  (mode:100755)
+++ uncommitted/cg-help  (mode:100755)
@@ -35,6 +35,7 @@
 	cg-merge	[-c] [-b BASE_ID] FROM_ID
 	cg-mkpatch	[-s] [-r FROM_ID[:TO_ID]]
 	cg-patch			< patch on stdin
+	cg-printenv
 	cg-pull		[BNAME]
 	cg-restore	[FILE]...
 	cg-rm		FILE...
Index: cg-printenv
===================================================================
--- /dev/null  (tree:3974261da777f55a7a11aff6e02f584bbfe2b475)
+++ uncommitted/cg-printenv  (mode:100755)
@@ -0,0 +1,21 @@
+#!/usr/bin/env bash
+#
+# Print exported git environment variables
+# Copyright (c) Steven Cole 2005
+#
+#These git environment variables are used in case
+#values other than that returned by getpwuid(getuid())
+#are desired when performing a commit.
+#
+#AUTHOR_NAME		Author's name
+#AUTHOR_EMAIL		Author's e-mail address
+#AUTHOR_DATE		Date, perhaps from a patch e-mail
+#COMMIT_AUTHOR_NAME	Committer's name
+#COMMIT_AUTHOR_EMAIL	Committer's e-mail address
+#
+# Takes no parameters.
+echo "AUTHOR_NAME="$AUTHOR_NAME
+echo "AUTHOR_EMAIL="$AUTHOR_EMAIL
+echo "AUTHOR_DATE="$AUTHOR_DATE
+echo "COMMIT_AUTHOR_NAME="$COMMIT_AUTHOR_NAME
+echo "COMMIT_AUTHOR_EMAIL="$COMMIT_AUTHOR_EMAIL
