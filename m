From: skimo@liacs.nl
Subject: [PATCH 2/6] export get_short_sha1
Date: Thu, 12 Jul 2007 21:05:59 +0200
Message-ID: <11842671633205-git-send-email-skimo@liacs.nl>
References: <11842671631744-git-send-email-skimo@liacs.nl>
Cc: Johannes Schindelin <johannes.schindelin@gmx.de>
To: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu Jul 12 21:07:21 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1I940X-0003wn-8h
	for gcvg-git@gmane.org; Thu, 12 Jul 2007 21:07:21 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753774AbXGLTGu (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 12 Jul 2007 15:06:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754744AbXGLTGu
	(ORCPT <rfc822;git-outgoing>); Thu, 12 Jul 2007 15:06:50 -0400
Received: from rhodium.liacs.nl ([132.229.131.16]:46089 "EHLO rhodium.liacs.nl"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753358AbXGLTGt (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 12 Jul 2007 15:06:49 -0400
Received: from pc117b.liacs.nl (pc117b.liacs.nl [132.229.129.143])
	by rhodium.liacs.nl (8.13.0/8.13.0/LIACS 1.4) with ESMTP id l6CJ63LU029831;
	Thu, 12 Jul 2007 21:06:08 +0200
Received: by pc117b.liacs.nl (Postfix, from userid 17122)
	id 92A053C00C; Thu, 12 Jul 2007 21:06:03 +0200 (CEST)
X-Mailer: git-send-email 1.5.3.rc0.63.gc956
In-Reply-To: <11842671631744-git-send-email-skimo@liacs.nl>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/52325>

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
1.5.3.rc0.100.ge60b4
