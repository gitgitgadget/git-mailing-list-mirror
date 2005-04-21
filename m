From: Brad Roberts <braddr@gameboy2.puremagic.com>
Subject: [PATCH 03/19] convert show-diff.c to use new cache hiding api's
Date: Thu, 21 Apr 2005 11:35:12 -0700
Message-ID: <200504211835.j3LIZCSZ027430@gameboy2.puremagic.com>
X-From: git-owner@vger.kernel.org Thu Apr 21 20:32:01 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DOgSN-0007oU-FB
	for gcvg-git@gmane.org; Thu, 21 Apr 2005 20:31:19 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261634AbVDUSfj (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 21 Apr 2005 14:35:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261649AbVDUSfj
	(ORCPT <rfc822;git-outgoing>); Thu, 21 Apr 2005 14:35:39 -0400
Received: from bellevue.puremagic.com ([209.189.198.108]:4232 "EHLO
	bellevue.puremagic.com") by vger.kernel.org with ESMTP
	id S261634AbVDUSfO (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 21 Apr 2005 14:35:14 -0400
Received: from gameboy2.puremagic.com (root@gameboy2.puremagic.com [209.189.198.109])
	by bellevue.puremagic.com (8.13.3/8.13.3/Debian-6) with ESMTP id j3LIZAEd027794
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NOT)
	for <git@vger.kernel.org>; Thu, 21 Apr 2005 11:35:10 -0700
Received: from gameboy2.puremagic.com (braddr@localhost [127.0.0.1])
	by gameboy2.puremagic.com (8.13.3/8.13.3/Debian-3) with ESMTP id j3LIZCw9027432
	for <git@vger.kernel.org>; Thu, 21 Apr 2005 11:35:12 -0700
Received: (from braddr@localhost)
	by gameboy2.puremagic.com (8.13.3/8.13.3/Submit) id j3LIZCSZ027430
	for git@vger.kernel.org; Thu, 21 Apr 2005 11:35:12 -0700
To: git@vger.kernel.org
X-Virus-Scanned: by amavisd-new
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

tree bbc50100a5cfd22264c2b0731ef8678656a399d8
parent 27fc41dcd4aecafdaf583f3962697a2fa3fb6480
author Brad Roberts <braddr@puremagic.com> 1114073516 -0700
committer Brad Roberts <braddr@gameboy2.puremagic.com> 1114073516 -0700

[PATCH] convert show-diff.c to use new cache hiding api's

Signed-off-by: Brad Roberts <braddr@puremagic.com>
---

 show-diff.c |    4 ++--
 1 files changed, 2 insertions(+), 2 deletions(-)

Index: show-diff.c
===================================================================
--- 27fc41dcd4aecafdaf583f3962697a2fa3fb6480:1/show-diff.c  (mode:100644 sha1:da364e26e28823f951a6be1b686a458575f28ea1)
+++ d70686e08f453199e5451b27fc7d0b36b73a5c7f:1/show-diff.c  (mode:100644 sha1:e2642b65805b3e52a16c6309b44a92c2a2bd13c3)
@@ -154,7 +154,7 @@
 	prepare_diff_cmd();
 	for (i = 0; i < entries; i++) {
 		struct stat st;
-		struct cache_entry *ce = active_cache[i];
+		struct cache_entry *ce = get_cache_entry(i);
 		int changed;
 		unsigned long size;
 		char type[20];
@@ -172,7 +172,7 @@
 				printf("%s: Unmerged\n",
 				       ce->name);
 			while (i < entries &&
-			       !strcmp(ce->name, active_cache[i]->name))
+			       !strcmp(ce->name, get_cache_entry(i)->name))
 				i++;
 			i--; /* compensate for loop control increments */
 			continue;

