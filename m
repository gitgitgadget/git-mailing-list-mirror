From: Jim Meyering <jim@meyering.net>
Subject: [PATCH] (encode_85, decode_85): Mark source buffer pointer as "const".
Date: Tue, 10 Apr 2007 00:56:33 +0200
Message-ID: <877islxila.fsf@rho.meyering.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Apr 10 05:05:18 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Hb2ms-00087a-GH
	for gcvg-git@gmane.org; Tue, 10 Apr 2007 00:56:39 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753514AbXDIW4f (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 9 Apr 2007 18:56:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753540AbXDIW4f
	(ORCPT <rfc822;git-outgoing>); Mon, 9 Apr 2007 18:56:35 -0400
Received: from mx.meyering.net ([82.230.74.64]:36461 "EHLO mx.meyering.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753514AbXDIW4e (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 9 Apr 2007 18:56:34 -0400
Received: by rho.meyering.net (Acme Bit-Twister, from userid 1000)
	id 4714B551FC; Tue, 10 Apr 2007 00:56:33 +0200 (CEST)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/44097>

Signed-off-by: Jim Meyering <jim@meyering.net>
---
 base85.c |    4 ++--
 cache.h  |    4 ++--
 2 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/base85.c b/base85.c
index a9e97f8..a6c41d5 100644
--- a/base85.c
+++ b/base85.c
@@ -37,7 +37,7 @@ static void prep_base85(void)
 	}
 }
 
-int decode_85(char *dst, char *buffer, int len)
+int decode_85(char *dst, const char *buffer, int len)
 {
 	prep_base85();
 
@@ -82,7 +82,7 @@ int decode_85(char *dst, char *buffer, int len)
 	return 0;
 }
 
-void encode_85(char *buf, unsigned char *data, int bytes)
+void encode_85(char *buf, const unsigned char *data, int bytes)
 {
 	prep_base85();
 
diff --git a/cache.h b/cache.h
index eb57507..b1bd9e4 100644
--- a/cache.h
+++ b/cache.h
@@ -472,8 +472,8 @@ extern int pager_in_use;
 extern int pager_use_color;
 
 /* base85 */
-int decode_85(char *dst, char *line, int linelen);
-void encode_85(char *buf, unsigned char *data, int bytes);
+int decode_85(char *dst, const char *line, int linelen);
+void encode_85(char *buf, const unsigned char *data, int bytes);
 
 /* alloc.c */
 struct blob;
-- 
1.5.1.rc3-dirty
