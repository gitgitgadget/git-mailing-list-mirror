From: Brad Roberts <braddr@gameboy2.puremagic.com>
Subject: [PATCH 06/19] migrate show-files.c to the new cache api's
Date: Thu, 21 Apr 2005 11:35:58 -0700
Message-ID: <200504211835.j3LIZwHN027498@gameboy2.puremagic.com>
X-From: git-owner@vger.kernel.org Thu Apr 21 20:33:10 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DOgT8-0007ug-Ae
	for gcvg-git@gmane.org; Thu, 21 Apr 2005 20:32:06 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261653AbVDUSg3 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 21 Apr 2005 14:36:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261672AbVDUSg3
	(ORCPT <rfc822;git-outgoing>); Thu, 21 Apr 2005 14:36:29 -0400
Received: from bellevue.puremagic.com ([209.189.198.108]:20360 "EHLO
	bellevue.puremagic.com") by vger.kernel.org with ESMTP
	id S261653AbVDUSf7 (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 21 Apr 2005 14:35:59 -0400
Received: from gameboy2.puremagic.com (root@gameboy2.puremagic.com [209.189.198.109])
	by bellevue.puremagic.com (8.13.3/8.13.3/Debian-6) with ESMTP id j3LIZuRv027879
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NOT)
	for <git@vger.kernel.org>; Thu, 21 Apr 2005 11:35:56 -0700
Received: from gameboy2.puremagic.com (braddr@localhost [127.0.0.1])
	by gameboy2.puremagic.com (8.13.3/8.13.3/Debian-3) with ESMTP id j3LIZwdm027500
	for <git@vger.kernel.org>; Thu, 21 Apr 2005 11:35:58 -0700
Received: (from braddr@localhost)
	by gameboy2.puremagic.com (8.13.3/8.13.3/Submit) id j3LIZwHN027498
	for git@vger.kernel.org; Thu, 21 Apr 2005 11:35:58 -0700
To: git@vger.kernel.org
X-Virus-Scanned: by amavisd-new
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

tree a3bd48d2beba79d70e97d8647ee35a645e494350
parent f908b2542a9a3ea321633a31cf0e7ca2c8b669d4
author Brad Roberts <braddr@puremagic.com> 1114074486 -0700
committer Brad Roberts <braddr@gameboy2.puremagic.com> 1114074486 -0700

[PATCH] migrate show-files.c to the new cache api's

Signed-off-by: Brad Roberts <braddr@puremagic.com>
---

 show-files.c |    8 ++++----
 1 files changed, 4 insertions(+), 4 deletions(-)

Index: show-files.c
===================================================================
--- f908b2542a9a3ea321633a31cf0e7ca2c8b669d4:1/show-files.c  (mode:100644 sha1:0b49ca051de413e7182445dd8fb9144125716974)
+++ 32efd81a3292a923ce5b5ae2e39ffefd0b08664d:1/show-files.c  (mode:100644 sha1:11fbbccef2df50d528105ceb48b15275f2a5693e)
@@ -116,8 +116,8 @@
 			printf("%s%s%c", tag_other, dir[i], line_terminator);
 	}
 	if (show_cached | show_stage) {
-		for (i = 0; i < active_nr; i++) {
-			struct cache_entry *ce = active_cache[i];
+		for (i = 0; i < get_num_cache_entries(); i++) {
+			struct cache_entry *ce = get_cache_entry(i);
 			if (show_unmerged && !ce_stage(ce))
 				continue;
 			if (!show_stage)
@@ -136,8 +136,8 @@
 		}
 	}
 	if (show_deleted) {
-		for (i = 0; i < active_nr; i++) {
-			struct cache_entry *ce = active_cache[i];
+		for (i = 0; i < get_num_cache_entries(); i++) {
+			struct cache_entry *ce = get_cache_entry(i);
 			struct stat st;
 			if (!stat(ce->name, &st))
 				continue;

