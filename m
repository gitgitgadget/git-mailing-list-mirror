From: skimo@liacs.nl
Subject: [PATCH 1/4] export get_short_sha1
Date: Sun,  8 Jul 2007 18:23:24 +0200
Message-ID: <11839118081240-git-send-email-skimo@liacs.nl>
References: <11839118073186-git-send-email-skimo@liacs.nl>
To: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sun Jul 08 18:24:09 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1I7ZYN-0003RT-Qg
	for gcvg-git@gmane.org; Sun, 08 Jul 2007 18:24:08 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754621AbXGHQXv (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 8 Jul 2007 12:23:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754572AbXGHQXu
	(ORCPT <rfc822;git-outgoing>); Sun, 8 Jul 2007 12:23:50 -0400
Received: from rhodium.liacs.nl ([132.229.131.16]:60206 "EHLO rhodium.liacs.nl"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753262AbXGHQXk (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 8 Jul 2007 12:23:40 -0400
Received: from pc117b.liacs.nl (pc117b.liacs.nl [132.229.129.143])
	by rhodium.liacs.nl (8.13.0/8.13.0/LIACS 1.4) with ESMTP id l68GNSUH031439;
	Sun, 8 Jul 2007 18:23:33 +0200
Received: by pc117b.liacs.nl (Postfix, from userid 17122)
	id 591913C00B; Sun,  8 Jul 2007 18:23:28 +0200 (CEST)
X-Mailer: git-send-email 1.5.3.rc0.63.gc956
In-Reply-To: <11839118073186-git-send-email-skimo@liacs.nl>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/51894>

From: Sven Verdoolaege <skimo@kotnet.org>

Sometimes it is useful to check whether a given string
is exactly a short SHA1.

Signed-off-by: Sven Verdoolaege <skimo@kotnet.org>
---
 cache.h     |    1 +
 sha1_name.c |    3 +--
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/cache.h b/cache.h
index e64071e..8fda8ee 100644
--- a/cache.h
+++ b/cache.h
@@ -391,6 +391,7 @@ static inline unsigned int hexval(unsigned char c)
 
 extern int get_sha1(const char *str, unsigned char *sha1);
 extern int get_sha1_with_mode(const char *str, unsigned char *sha1, unsigned *mode);
+extern int get_short_sha1(const char *name, int len, unsigned char *sha1, int quietly);
 extern int get_sha1_hex(const char *hex, unsigned char *sha1);
 extern char *sha1_to_hex(const unsigned char *sha1);	/* static buffer result! */
 extern int read_ref(const char *filename, unsigned char *sha1);
diff --git a/sha1_name.c b/sha1_name.c
index 858f08c..0bed79d 100644
--- a/sha1_name.c
+++ b/sha1_name.c
@@ -154,8 +154,7 @@ static int find_unique_short_object(int len, char *canonical,
 	return 0;
 }
 
-static int get_short_sha1(const char *name, int len, unsigned char *sha1,
-			  int quietly)
+int get_short_sha1(const char *name, int len, unsigned char *sha1, int quietly)
 {
 	int i, status;
 	char canonical[40];
-- 
1.5.3.rc0.68.geec71-dirty
