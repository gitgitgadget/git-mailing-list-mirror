From: Nicolas Pitre <nico@fluxnic.net>
Subject: [PATCH 02/23] export packed_object_info()
Date: Tue, 27 Aug 2013 00:25:46 -0400
Message-ID: <1377577567-27655-3-git-send-email-nico@fluxnic.net>
References: <1377577567-27655-1-git-send-email-nico@fluxnic.net>
Content-Transfer-Encoding: 7BIT
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Aug 27 06:26:38 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VEArW-000780-Gt
	for gcvg-git-2@plane.gmane.org; Tue, 27 Aug 2013 06:26:38 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753055Ab3H0E0d (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 27 Aug 2013 00:26:33 -0400
Received: from relais.videotron.ca ([24.201.245.36]:30513 "EHLO
	relais.videotron.ca" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752705Ab3H0E0a (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 27 Aug 2013 00:26:30 -0400
Received: from yoda.home ([70.83.209.44]) by VL-VM-MR006.ip.videotron.ca
 (Oracle Communications Messaging Exchange Server 7u4-22.01 64bit (built Apr 21
 2011)) with ESMTP id <0MS600DCD9O4IO90@VL-VM-MR006.ip.videotron.ca> for
 git@vger.kernel.org; Tue, 27 Aug 2013 00:26:29 -0400 (EDT)
Received: from xanadu.home (xanadu.home [192.168.2.2])	by yoda.home (Postfix)
 with ESMTP id CFE7C2DA05FA	for <git@vger.kernel.org>; Tue,
 27 Aug 2013 00:26:28 -0400 (EDT)
X-Mailer: git-send-email 1.8.4.22.g54757b7
In-reply-to: <1377577567-27655-1-git-send-email-nico@fluxnic.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/233048>

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
1.8.4.22.g54757b7
