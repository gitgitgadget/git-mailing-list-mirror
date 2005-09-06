From: Rene Scharfe <rene.scharfe@lsrfire.ath.cx>
Subject: Subject: [PATCH] Update documentation for git-get-tar-commit-id and add a copyright notice.
Date: Tue, 6 Sep 2005 21:21:16 +0200
Message-ID: <11260344762228-git-send-email-rene.scharfe@lsrfire.ath.cx>
Reply-To: Rene Scharfe <rene.scharfe@lsrfire.ath.cx>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Cc: git@vger.kernel.org, Rene Scharfe <rene.scharfe@lsrfire.ath.cx>
X-From: git-owner@vger.kernel.org Tue Sep 06 21:23:40 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1ECj0S-0002nC-Uk
	for gcvg-git@gmane.org; Tue, 06 Sep 2005 21:21:21 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750814AbVIFTVS (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 6 Sep 2005 15:21:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750815AbVIFTVS
	(ORCPT <rfc822;git-outgoing>); Tue, 6 Sep 2005 15:21:18 -0400
Received: from neapel230.server4you.de ([217.172.187.230]:26532 "EHLO
	neapel230.server4you.de") by vger.kernel.org with ESMTP
	id S1750814AbVIFTVR (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 6 Sep 2005 15:21:17 -0400
Received: from neapel230.server4you.de (localhost [127.0.0.1])
	by neapel230.server4you.de (Postfix) with SMTP id BF241B1;
	Tue,  6 Sep 2005 21:21:16 +0200 (CEST)
In-Reply-To: 
X-Mailer: git-send-email-script
To: Junio C Hamano <junkio@cox.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/8140>

Signed-off-by: Rene Scharfe <rene.scharfe@lsrfire.ath.cx>

---

 Documentation/git-get-tar-commit-id.txt |   23 +++++++++++------------
 get-tar-commit-id.c                     |    3 +++
 2 files changed, 14 insertions(+), 12 deletions(-)

5144a0393d17d721c83a42ce743d2ce46909f222
diff --git a/Documentation/git-get-tar-commit-id.txt b/Documentation/git-get-tar-commit-id.txt
--- a/Documentation/git-get-tar-commit-id.txt
+++ b/Documentation/git-get-tar-commit-id.txt
@@ -3,25 +3,24 @@ git-get-tar-commit-id(1)
 
 NAME
 ----
-git-get-tar-commit-id - Some git command not yet documented.
+git-get-tar-commit-id - Extract commit ID from an archive created using git-tar-tree.
 
 
 SYNOPSIS
 --------
-'git-get-tar-commit-id' [ --option ] <args>...
+'git-get-tar-commit-id' < <tarfile>
+
 
 DESCRIPTION
 -----------
-Does something not yet documented.
-
-
-OPTIONS
--------
---option::
-	Some option not yet documented.
-
-<args>...::
-	Some argument not yet documented.
+Acts as a filter, extracting the commit ID stored in archives created by
+git-tar-tree.  It reads only the first 1024 bytes of input, thus its
+runtime is not influenced by the size of <tarfile> very much.
+
+If no commit ID is found, git-get-tar-commit-id quietly exists with a
+return code of 1.  This can happen if <tarfile> had not been created
+using git-tar-tree or if the first parameter of git-tar-tree had been
+a tree ID instead of a commit ID or tag.
 
 
 Author
diff --git a/get-tar-commit-id.c b/get-tar-commit-id.c
--- a/get-tar-commit-id.c
+++ b/get-tar-commit-id.c
@@ -1,3 +1,6 @@
+/*
+ * Copyright (C) 2005 Rene Scharfe
+ */
 #include <stdio.h>
 #include <string.h>
 #include <unistd.h>
