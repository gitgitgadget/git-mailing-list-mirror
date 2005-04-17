From: Steven Cole <elenstev@mesatop.com>
Subject: [PATCH] Add lsremote command.
Date: Sat, 16 Apr 2005 23:36:51 -0600
Message-ID: <200504162336.51937.elenstev@mesatop.com>
Mime-Version: 1.0
Content-Type: Multipart/Mixed;
  boundary="Boundary-00=_zXfYCc2u3EvKYfj"
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Apr 17 07:37:13 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DN2T3-00009W-19
	for gcvg-git@gmane.org; Sun, 17 Apr 2005 07:37:13 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261265AbVDQFky (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 17 Apr 2005 01:40:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261266AbVDQFky
	(ORCPT <rfc822;git-outgoing>); Sun, 17 Apr 2005 01:40:54 -0400
Received: from taco.zianet.com ([216.234.192.159]:37638 "HELO taco.zianet.com")
	by vger.kernel.org with SMTP id S261265AbVDQFko (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 17 Apr 2005 01:40:44 -0400
Received: (qmail 97938 invoked from network); 17 Apr 2005 05:40:42 -0000
Received: from 216-31-65-116.zianet.com (216.31.65.116)
  by 0 with SMTP; 17 Apr 2005 05:40:42 -0000
To: Petr Baudis <pasky@ucw.cz>
User-Agent: KMail/1.6.1
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org


--Boundary-00=_zXfYCc2u3EvKYfj
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

This is a fairly trivial addition, but if users are adding remote repositories
with git addremote, then those users should be able to list out the remote
list without having to know the details of where the remotes file is kept.

Steven


--Boundary-00=_zXfYCc2u3EvKYfj
Content-Type: text/x-diff;
  charset="us-ascii";
  name="add-lsremote-command.diff"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
	filename="add-lsremote-command.diff"

Adds lsremote command to list remotes.

Signed-Off-By: Steven Cole <elenstev@mesatop.com>

-------------

diff -urN git-pasky-orig/git git-pasky/git
--- git-pasky-orig/git	2005-04-16 22:47:22.000000000 -0600
+++ git-pasky/git	2005-04-16 22:49:14.000000000 -0600
@@ -41,6 +41,7 @@
 	log
 	ls		[TREE_ID]
 	lsobj		[OBJTYPE]
+	lsremote
 	merge		-b BASE_ID FROM_ID
 	pull		[RNAME]
 	rm		FILE...
@@ -105,6 +106,7 @@
 "log")        gitlog.sh "$@";;
 "ls")         gitls.sh "$@";;
 "lsobj")      gitlsobj.sh "$@";;
+"lsremote")   gitlsremote.sh "$@";;
 "merge")      gitmerge.sh "$@";;
 "pull")       gitpull.sh "$@";;
 "rm")         gitrm.sh "$@";;
diff -urN git-pasky-orig/gitlsremote.sh git-pasky/gitlsremote.sh
--- git-pasky-orig/gitlsremote.sh	1969-12-31 17:00:00.000000000 -0700
+++ git-pasky/gitlsremote.sh	2005-04-16 22:58:15.000000000 -0600
@@ -0,0 +1,7 @@
+#!/bin/sh
+#
+# ls remotes in GIT repository
+#
+[ -e .git/remotes ] && cat .git/remotes && exit 1
+
+echo 'List of remotes is empty. See git addremote.'

--Boundary-00=_zXfYCc2u3EvKYfj--
