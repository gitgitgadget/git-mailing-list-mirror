From: Brad Roberts <braddr@gameboy2.puremagic.com>
Subject: [PATCH 10/19] migrate check-files.c to the new cache api's
Date: Thu, 21 Apr 2005 11:36:59 -0700
Message-ID: <200504211836.j3LIaxuE027588@gameboy2.puremagic.com>
X-From: git-owner@vger.kernel.org Thu Apr 21 20:34:37 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DOgUE-00085z-Rd
	for gcvg-git@gmane.org; Thu, 21 Apr 2005 20:33:15 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261672AbVDUShe (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 21 Apr 2005 14:37:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261675AbVDUShe
	(ORCPT <rfc822;git-outgoing>); Thu, 21 Apr 2005 14:37:34 -0400
Received: from bellevue.puremagic.com ([209.189.198.108]:42120 "EHLO
	bellevue.puremagic.com") by vger.kernel.org with ESMTP
	id S261672AbVDUShB (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 21 Apr 2005 14:37:01 -0400
Received: from gameboy2.puremagic.com (root@gameboy2.puremagic.com [209.189.198.109])
	by bellevue.puremagic.com (8.13.3/8.13.3/Debian-6) with ESMTP id j3LIavE3028002
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NOT)
	for <git@vger.kernel.org>; Thu, 21 Apr 2005 11:36:57 -0700
Received: from gameboy2.puremagic.com (braddr@localhost [127.0.0.1])
	by gameboy2.puremagic.com (8.13.3/8.13.3/Debian-3) with ESMTP id j3LIaxn8027590
	for <git@vger.kernel.org>; Thu, 21 Apr 2005 11:36:59 -0700
Received: (from braddr@localhost)
	by gameboy2.puremagic.com (8.13.3/8.13.3/Submit) id j3LIaxuE027588
	for git@vger.kernel.org; Thu, 21 Apr 2005 11:36:59 -0700
To: git@vger.kernel.org
X-Virus-Scanned: by amavisd-new
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

tree 54aca1a1c5f41995c79fdf6b5f720574d0bfd8ef
parent 50a6596bf7f51ecd598cd02d9c44379a9b92044a
author Brad Roberts <braddr@puremagic.com> 1114077105 -0700
committer Brad Roberts <braddr@gameboy2.puremagic.com> 1114077105 -0700

[PATCH] migrate check-files.c to the new cache api's

Signed-off-by: Brad Roberts <braddr@puremagic.com>
---

 check-files.c |    2 +-
 1 files changed, 1 insertion(+), 1 deletion(-)

Index: check-files.c
===================================================================
--- 50a6596bf7f51ecd598cd02d9c44379a9b92044a:1/check-files.c  (mode:100644 sha1:7d16691aa9d51b5b4670d5837b3527ee7c7da79c)
+++ a94803645fb68119be8835d466585c91e664a173:1/check-files.c  (mode:100644 sha1:919e418b5f0f85220445c876a37bf4cf61d26525)
@@ -26,7 +26,7 @@
 	pos = cache_name_pos(path, strlen(path));
 	if (pos < 0)
 		die("preparing to update existing file '%s' not in cache", path);
-	ce = active_cache[pos];
+	ce = get_cache_entry(pos);
 
 	if (fstat(fd, &st) < 0)
 		die("fstat(%s): %s", path, strerror(errno));

