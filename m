From: Erik Faye-Lund <kusmabite@gmail.com>
Subject: [PATCH v6 04/16] inet_ntop: fix a couple of old-style decls
Date: Wed,  3 Nov 2010 17:31:22 +0100
Message-ID: <1288801894-1168-5-git-send-email-kusmabite@gmail.com>
References: <1288801894-1168-1-git-send-email-kusmabite@gmail.com>
Cc: gitster@pobox.com
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Nov 03 17:32:19 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PDgFo-0001tf-QI
	for gcvg-git-2@lo.gmane.org; Wed, 03 Nov 2010 17:32:05 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755832Ab0KCQb5 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 3 Nov 2010 12:31:57 -0400
Received: from mail-ey0-f174.google.com ([209.85.215.174]:55502 "EHLO
	mail-ey0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755809Ab0KCQby (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 3 Nov 2010 12:31:54 -0400
Received: by mail-ey0-f174.google.com with SMTP id 27so386169eye.19
        for <git@vger.kernel.org>; Wed, 03 Nov 2010 09:31:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:cc:subject:date
         :message-id:x-mailer:in-reply-to:references;
        bh=3eLrUOP2wCix2jTdEzdzOaeojGJ3PF+eUhM5ify19mg=;
        b=W48wAzQOm22hoDcJeWKSli0ozZwFFMLhmCRVX/mrAPoRQxN1tVydYuboyj1ikjau6U
         1/lY7dGZ76Z5D5lYdcXm7odaRidGyskQdciyTJjDlRUqmDFsrJ4hIiBOfMXLgq5gt70z
         ClSO9IM0oFbPc0qAul80tZ0oT8hEu23sWgCSs=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        b=rRI0VLCTFpBbXwuP9i8Sot1PLBSTCKuqmfKwiymSjHeqB5C8uZIIAQr11fIF6GcoW1
         A3Zu75iPhj/clLS9XWhxDBAzxstIdp8D3nUilYjXsuj817lQ/kwkNbMrrVOMaM2D1eVH
         Uk0sFUaznj42lv7qVM5/Im+cQn0s3xt7/+8IQ=
Received: by 10.14.47.200 with SMTP id t48mr852804eeb.23.1288801913749;
        Wed, 03 Nov 2010 09:31:53 -0700 (PDT)
Received: from localhost ([77.40.159.131])
        by mx.google.com with ESMTPS id v56sm6704427eeh.8.2010.11.03.09.31.52
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Wed, 03 Nov 2010 09:31:52 -0700 (PDT)
X-Mailer: git-send-email 1.7.2.3.msysgit.0.2.g22c0a
In-Reply-To: <1288801894-1168-1-git-send-email-kusmabite@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/160614>

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
1.7.3.2.161.gd6e00
