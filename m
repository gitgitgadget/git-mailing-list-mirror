From: Erik Faye-Lund <kusmabite@gmail.com>
Subject: [PATCH v7 04/16] inet_ntop: fix a couple of old-style decls
Date: Thu,  4 Nov 2010 02:35:12 +0100
Message-ID: <1288834524-2400-5-git-send-email-kusmabite@gmail.com>
References: <1288834524-2400-1-git-send-email-kusmabite@gmail.com>
Cc: gitster@pobox.com
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Nov 04 02:35:50 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PDok1-00013V-Kc
	for gcvg-git-2@lo.gmane.org; Thu, 04 Nov 2010 02:35:50 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754443Ab0KDBfk (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 3 Nov 2010 21:35:40 -0400
Received: from mail-ew0-f46.google.com ([209.85.215.46]:57379 "EHLO
	mail-ew0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754398Ab0KDBfg (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 3 Nov 2010 21:35:36 -0400
Received: by ewy7 with SMTP id 7so738633ewy.19
        for <git@vger.kernel.org>; Wed, 03 Nov 2010 18:35:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:cc:subject:date
         :message-id:x-mailer:in-reply-to:references;
        bh=srCqIX4oBCRamgZZP7m5dNVWvC7ds3ADB/2akiUr5BE=;
        b=M6OTlCWF2Hp2HCc9jYOmIBbW0+8KEF9pTIFTleymsS+WFweL7RzGzWgsTTd4+kFkmQ
         fWRsIVFmt3RAWLaBsuiKoNb2wTI/UwPLBkwui+G0zKijL3Z3CLOllNKTg0b9i6+Rduc4
         KZl49xsFusYAu0Q2b01jCNnFREOrOhGrMY2E8=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        b=m/EjQP/zp5gcTdVKXgzPobUKmJ8jsqI6MpR7+jVIHnI+/zJwQfbgx+joND4NoJ29yA
         lraF9rVdFY0MOzBxa/S07Mdk8FYtAj3I20CO2lzrQMkdENp6TcVnBtO9AalHgk3ZkpEn
         7jSL6Z8ACxwAvJ3XBzkkJDa9VBXrc+MGIPsyk=
Received: by 10.213.22.71 with SMTP id m7mr74155ebb.22.1288834535026;
        Wed, 03 Nov 2010 18:35:35 -0700 (PDT)
Received: from localhost (cm-84.215.188.225.getinternet.no [84.215.188.225])
        by mx.google.com with ESMTPS id x54sm7192024eeh.5.2010.11.03.18.35.34
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Wed, 03 Nov 2010 18:35:34 -0700 (PDT)
X-Mailer: git-send-email 1.7.3.165.gdfe39.dirty
In-Reply-To: <1288834524-2400-1-git-send-email-kusmabite@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/160663>

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
1.7.3.2.162.g09d37
