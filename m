From: Erik Faye-Lund <kusmabite@gmail.com>
Subject: [PATCH v5 04/16] inet_ntop: fix a couple of old-style decls
Date: Fri, 22 Oct 2010 02:35:15 +0200
Message-ID: <1287707727-5780-5-git-send-email-kusmabite@gmail.com>
References: <1287707727-5780-1-git-send-email-kusmabite@gmail.com>
Mime-Version: 1.0
Cc: msysgit@googlegroups.com,
	j6t@kdbg.org,
	avarab@gmail.com,
	sunshine@sunshineco.com,
	jrnieder@gmail.com,
	schwab@linux-m68k.org,
	patthoyts@gmail.com
To: git@vger.kernel.org
X-From: msysgit+bncCOPdven-DxCIuYPmBBoEpmWlFQ@googlegroups.com Fri Oct 22 02:36:48 2010
Return-path: <msysgit+bncCOPdven-DxCIuYPmBBoEpmWlFQ@googlegroups.com>
Envelope-to: gcvm-msysgit@m.gmane.org
Received: from mail-wy0-f186.google.com ([74.125.82.186])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <msysgit+bncCOPdven-DxCIuYPmBBoEpmWlFQ@googlegroups.com>)
	id 1P95cm-0002V4-9X
	for gcvm-msysgit@m.gmane.org; Fri, 22 Oct 2010 02:36:48 +0200
Received: by mail-wy0-f186.google.com with SMTP id 11sf139996wyi.3
        for <gcvm-msysgit@m.gmane.org>; Thu, 21 Oct 2010 17:36:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlegroups.com; s=beta;
        h=domainkey-signature:received:mime-version:x-beenthere:received
         :received:received:received:received-spf:received:received:received
         :from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references
         :x-original-sender:x-original-authentication-results:precedence
         :mailing-list:list-id:list-post:list-help:list-archive:sender
         :list-subscribe:list-unsubscribe;
        bh=ODl6t8qe0fhd+U1AH6XekeL8xCIqSsaavsoSlPIcWlU=;
        b=Bn/HkxmAES06CFqESYxyUEy0I4nJq7BP0WCpBZv6cIAI8cDjP81AEh1oSdozE4TpS8
         46Yh8ea2PTw8T7BJRoWdZCJxAKtOe1KSpJ7o+Dw+HiFib4s/euOotZM28b8c9ZnFlIe8
         x1yh1BN3JiP3JxfVTwOF3LLje7ALrRx6YfAAI=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=googlegroups.com; s=beta;
        h=mime-version:x-beenthere:received-spf:from:to:cc:subject:date
         :message-id:x-mailer:in-reply-to:references:x-original-sender
         :x-original-authentication-results:precedence:mailing-list:list-id
         :list-post:list-help:list-archive:sender:list-subscribe
         :list-unsubscribe;
        b=x5moJARyFpqijM7RqhymyBktyWz1eJWU07rm87AR1Vdxu6QQB7Dvdt2KXNwBQfVY7Q
         mxussIsXNwdwv015VokEzwOo0tN+wKT1wextFOesxEwIQoT/KmjI2E4XMpIbNwLuR77f
         2swUTw20X/BSF6KFy0Ca9fJlW9XQANkaM5Wmo=
Received: by 10.216.6.132 with SMTP id 4mr225913wen.20.1287707784138;
        Thu, 21 Oct 2010 17:36:24 -0700 (PDT)
X-BeenThere: msysgit@googlegroups.com
Received: by 10.14.26.28 with SMTP id b28ls269639eea.5.p; Thu, 21 Oct 2010
 17:36:23 -0700 (PDT)
Received: by 10.14.53.12 with SMTP id f12mr159747eec.0.1287707783501;
        Thu, 21 Oct 2010 17:36:23 -0700 (PDT)
Received: by 10.14.53.12 with SMTP id f12mr159746eec.0.1287707783453;
        Thu, 21 Oct 2010 17:36:23 -0700 (PDT)
Received: from mail-ey0-f175.google.com (mail-ey0-f175.google.com [209.85.215.175])
        by gmr-mx.google.com with ESMTP id q11si1451415eeh.4.2010.10.21.17.36.22;
        Thu, 21 Oct 2010 17:36:22 -0700 (PDT)
Received-SPF: pass (google.com: domain of kusmabite@gmail.com designates 209.85.215.175 as permitted sender) client-ip=209.85.215.175;
Received: by eya28 with SMTP id 28so162851eya.34
        for <msysgit@googlegroups.com>; Thu, 21 Oct 2010 17:36:22 -0700 (PDT)
Received: by 10.213.4.136 with SMTP id 8mr2501838ebr.98.1287707782305;
        Thu, 21 Oct 2010 17:36:22 -0700 (PDT)
Received: from localhost (cm-84.215.188.225.getinternet.no [84.215.188.225])
        by mx.google.com with ESMTPS id v56sm2483108eeh.14.2010.10.21.17.36.20
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Thu, 21 Oct 2010 17:36:21 -0700 (PDT)
X-Mailer: git-send-email 1.7.3.165.gdfe39.dirty
In-Reply-To: <1287707727-5780-1-git-send-email-kusmabite@gmail.com>
X-Original-Sender: kusmabite@gmail.com
X-Original-Authentication-Results: gmr-mx.google.com; spf=pass (google.com:
 domain of kusmabite@gmail.com designates 209.85.215.175 as permitted sender)
 smtp.mail=kusmabite@gmail.com; dkim=pass (test mode) header.i=@gmail.com
Precedence: list
Mailing-list: list msysgit@googlegroups.com; contact msysgit+owners@googlegroups.com
List-ID: <msysgit.googlegroups.com>
List-Post: <http://groups.google.com/group/msysgit/post?hl=en_US>, <mailto:msysgit@googlegroups.com>
List-Help: <http://groups.google.com/support/?hl=en_US>, <mailto:msysgit+help@googlegroups.com>
List-Archive: <http://groups.google.com/group/msysgit?hl=en_US>
Sender: msysgit@googlegroups.com
List-Subscribe: <http://groups.google.com/group/msysgit/subscribe?hl=en_US>, <mailto:msysgit+subscribe@googlegroups.com>
List-Unsubscribe: <http://groups.google.com/group/msysgit/subscribe?hl=en_US>, <mailto:msysgit+unsubscribe@googlegroups.com>
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/159615>

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
1.7.3.1.199.g72340
