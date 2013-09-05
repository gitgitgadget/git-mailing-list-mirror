From: Nicolas Pitre <nico@fluxnic.net>
Subject: [PATCH 02/38] export packed_object_info()
Date: Thu, 05 Sep 2013 02:19:25 -0400
Message-ID: <1378362001-1738-3-git-send-email-nico@fluxnic.net>
References: <1378362001-1738-1-git-send-email-nico@fluxnic.net>
Content-Transfer-Encoding: 7BIT
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Sep 05 08:22:19 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VHSxL-0000D7-VP
	for gcvg-git-2@plane.gmane.org; Thu, 05 Sep 2013 08:22:16 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1763202Ab3IEGWH (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 5 Sep 2013 02:22:07 -0400
Received: from relais.videotron.ca ([24.201.245.36]:53284 "EHLO
	relais.videotron.ca" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756970Ab3IEGUQ (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 5 Sep 2013 02:20:16 -0400
Received: from yoda.home ([70.83.209.44]) by VL-VM-MR006.ip.videotron.ca
 (Oracle Communications Messaging Exchange Server 7u4-22.01 64bit (built Apr 21
 2011)) with ESMTP id <0MSN00ANT2XQCY00@VL-VM-MR006.ip.videotron.ca> for
 git@vger.kernel.org; Thu, 05 Sep 2013 02:20:14 -0400 (EDT)
Received: from xanadu.home (xanadu.home [192.168.2.2])	by yoda.home (Postfix)
 with ESMTP id 6C3BF2DA05D6	for <git@vger.kernel.org>; Thu,
 05 Sep 2013 02:20:14 -0400 (EDT)
X-Mailer: git-send-email 1.8.4.38.g317e65b
In-reply-to: <1378362001-1738-1-git-send-email-nico@fluxnic.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/233932>

Signed-off-by: Nicolas Pitre <nico@fluxnic.net>
---
 cache.h     | 1 +
 sha1_file.c | 4 ++--
 2 files changed, 3 insertions(+), 2 deletions(-)

diff --git a/cache.h b/cache.h
index 85b544f..b6634c4 100644
--- a/cache.h
+++ b/cache.h
@@ -1160,6 +1160,7 @@ struct object_info {
 	} u;
 };
 extern int sha1_object_info_extended(const unsigned char *, struct object_info *);
+extern int packed_object_info(struct packed_git *, off_t, struct object_info *);
 
 /* Dumb servers support */
 extern int update_server_info(int);
diff --git a/sha1_file.c b/sha1_file.c
index 8e27db1..c2020d0 100644
--- a/sha1_file.c
+++ b/sha1_file.c
@@ -1782,8 +1782,8 @@ unwind:
 	goto out;
 }
 
-static int packed_object_info(struct packed_git *p, off_t obj_offset,
-			      struct object_info *oi)
+int packed_object_info(struct packed_git *p, off_t obj_offset,
+		       struct object_info *oi)
 {
 	struct pack_window *w_curs = NULL;
 	unsigned long size;
-- 
1.8.4.38.g317e65b
