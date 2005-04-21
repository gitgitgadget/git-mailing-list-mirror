From: Brad Roberts <braddr@gameboy2.puremagic.com>
Subject: [PATCH 05/19] migrate checkout-cache.c to the new cache api's
Date: Thu, 21 Apr 2005 11:35:43 -0700
Message-ID: <200504211835.j3LIZhlA027471@gameboy2.puremagic.com>
X-From: git-owner@vger.kernel.org Thu Apr 21 20:32:47 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DOgSq-0007sB-1C
	for gcvg-git@gmane.org; Thu, 21 Apr 2005 20:31:48 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261649AbVDUSgJ (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 21 Apr 2005 14:36:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261661AbVDUSgJ
	(ORCPT <rfc822;git-outgoing>); Thu, 21 Apr 2005 14:36:09 -0400
Received: from bellevue.puremagic.com ([209.189.198.108]:10888 "EHLO
	bellevue.puremagic.com") by vger.kernel.org with ESMTP
	id S261649AbVDUSfp (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 21 Apr 2005 14:35:45 -0400
Received: from gameboy2.puremagic.com (root@gameboy2.puremagic.com [209.189.198.109])
	by bellevue.puremagic.com (8.13.3/8.13.3/Debian-6) with ESMTP id j3LIZfVQ027820
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NOT)
	for <git@vger.kernel.org>; Thu, 21 Apr 2005 11:35:41 -0700
Received: from gameboy2.puremagic.com (braddr@localhost [127.0.0.1])
	by gameboy2.puremagic.com (8.13.3/8.13.3/Debian-3) with ESMTP id j3LIZhl6027473
	for <git@vger.kernel.org>; Thu, 21 Apr 2005 11:35:43 -0700
Received: (from braddr@localhost)
	by gameboy2.puremagic.com (8.13.3/8.13.3/Submit) id j3LIZhlA027471
	for git@vger.kernel.org; Thu, 21 Apr 2005 11:35:43 -0700
To: git@vger.kernel.org
X-Virus-Scanned: by amavisd-new
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

tree b95df78e4cc90db8c4c8d0ad870bef74b7fd29e2
parent 40bf732f5bcb986943070a2ed6c09a16543d81be
author Brad Roberts <braddr@puremagic.com> 1114074234 -0700
committer Brad Roberts <braddr@gameboy2.puremagic.com> 1114074234 -0700

[PATCH] migrate checkout-cache.c to the new cache api's

Signed-off-by: Brad Roberts <braddr@puremagic.com>
---

 checkout-cache.c |    6 +++---
 1 files changed, 3 insertions(+), 3 deletions(-)

Index: checkout-cache.c
===================================================================
--- 40bf732f5bcb986943070a2ed6c09a16543d81be:1/checkout-cache.c  (mode:100644 sha1:8bf86016b5d5fd88a52ce694fc59bb9ecb550d22)
+++ f908b2542a9a3ea321633a31cf0e7ca2c8b669d4:1/checkout-cache.c  (mode:100644 sha1:bf9cd0572c883219d37f2788ec5f5553a136df2b)
@@ -128,15 +128,15 @@
 			fprintf(stderr, "checkout-cache: %s is not in the cache\n", name);
 		return -1;
 	}
-	return checkout_entry(active_cache[pos]);
+	return checkout_entry(get_cache_entry(pos));
 }
 
 static int checkout_all(void)
 {
 	int i;
 
-	for (i = 0; i < active_nr ; i++) {
-		struct cache_entry *ce = active_cache[i];
+	for (i = 0; i < get_num_cache_entries() ; i++) {
+		struct cache_entry *ce = get_cache_entry(i);
 		if (ce_stage(ce))
 			continue;
 		if (checkout_entry(ce) < 0)

