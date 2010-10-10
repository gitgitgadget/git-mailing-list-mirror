From: Erik Faye-Lund <kusmabite@gmail.com>
Subject: [PATCH v3 04/14] inet_ntop: fix a couple of old-style decls
Date: Sun, 10 Oct 2010 15:20:44 +0200
Message-ID: <1286716854-5744-5-git-send-email-kusmabite@gmail.com>
References: <1286716854-5744-1-git-send-email-kusmabite@gmail.com>
Cc: msysgit@googlegroups.com, j6t@kdbg.org
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Oct 10 15:22:23 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1P4vr3-0004u7-5S
	for gcvg-git-2@lo.gmane.org; Sun, 10 Oct 2010 15:22:21 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752283Ab0JJNV6 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 10 Oct 2010 09:21:58 -0400
Received: from mail-ew0-f46.google.com ([209.85.215.46]:54307 "EHLO
	mail-ew0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751763Ab0JJNV5 (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 10 Oct 2010 09:21:57 -0400
Received: by mail-ew0-f46.google.com with SMTP id 20so255794ewy.19
        for <git@vger.kernel.org>; Sun, 10 Oct 2010 06:21:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:cc:subject:date
         :message-id:x-mailer:in-reply-to:references;
        bh=g4o6G2Q72WNEKWgKAz75atazPMGUvqUiEDK97WVwleo=;
        b=l4Ge2I1h1qbWkJniyXMDQxX2DI2t9YySRvQ1NO6r1A2GV9+sLCVJ8oM0fcLPxdpGso
         Tl3x0gZIGW57qLjjjck55gVqaFnVdGH22q4l7NVOGzygRlSK7pEubOVPm9BhBJmgaKiP
         R5M3BSt3IHf4pXN8VsopkrdqEELP+h0gN6OgI=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        b=uT5CQbCmhRD+6cubidy4TsG33VPLRlid+HlsfbWfUcccRdehtp2Hg25Z2FjCS81+q3
         LgOCzu/cmGhL72DbnedhrJCDzoDJBolODmN2nsFR7+bTvetO5SCpOQVcSLP7LcY8sdZT
         2/+RB3lZBOlaOlztCHPj9uPjWABMvY6Yjww5A=
Received: by 10.213.32.193 with SMTP id e1mr163611ebd.73.1286716917007;
        Sun, 10 Oct 2010 06:21:57 -0700 (PDT)
Received: from localhost (cm-84.215.188.225.getinternet.no [84.215.188.225])
        by mx.google.com with ESMTPS id z55sm9036447eeh.21.2010.10.10.06.21.55
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Sun, 10 Oct 2010 06:21:56 -0700 (PDT)
X-Mailer: git-send-email 1.7.3.165.gdfe39.dirty
In-Reply-To: <1286716854-5744-1-git-send-email-kusmabite@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/158663>

Signed-off-by: Erik Faye-Lund <kusmabite@gmail.com>
---
 compat/inet_ntop.c |   16 +++-------------
 1 files changed, 3 insertions(+), 13 deletions(-)

diff --git a/compat/inet_ntop.c b/compat/inet_ntop.c
index e5b46a0..ea249c6 100644
--- a/compat/inet_ntop.c
+++ b/compat/inet_ntop.c
@@ -50,10 +50,7 @@
  *	Paul Vixie, 1996.
  */
 static const char *
-inet_ntop4(src, dst, size)
-	const u_char *src;
-	char *dst;
-	size_t size;
+inet_ntop4(const u_char *src, char *dst, size_t size)
 {
 	static const char fmt[] = "%u.%u.%u.%u";
 	char tmp[sizeof "255.255.255.255"];
@@ -78,10 +75,7 @@ inet_ntop4(src, dst, size)
  *	Paul Vixie, 1996.
  */
 static const char *
-inet_ntop6(src, dst, size)
-	const u_char *src;
-	char *dst;
-	size_t size;
+inet_ntop6(const u_char *src, char *dst, size_t size)
 {
 	/*
 	 * Note that int32_t and int16_t need only be "at least" large enough
@@ -178,11 +172,7 @@ inet_ntop6(src, dst, size)
  *	Paul Vixie, 1996.
  */
 const char *
-inet_ntop(af, src, dst, size)
-	int af;
-	const void *src;
-	char *dst;
-	size_t size;
+inet_ntop(int af, const void *src, char *dst, size_t size)
 {
 	switch (af) {
 	case AF_INET:
-- 
1.7.3.1.51.ge462f.dirty
