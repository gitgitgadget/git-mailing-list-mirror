From: Erik Faye-Lund <kusmabite@googlemail.com>
Subject: [PATCH v2 04/14] inet_ntop: fix a couple of old-style decls
Date: Fri, 15 Jan 2010 22:30:23 +0100
Message-ID: <1263591033-4992-5-git-send-email-kusmabite@gmail.com>
References: <1263591033-4992-1-git-send-email-kusmabite@gmail.com>
Cc: git@vger.kernel.org, j6t@kdbg.org,
	Erik Faye-Lund <kusmabite@gmail.com>
To: msysgit@googlegroups.com
X-From: git-owner@vger.kernel.org Fri Jan 15 22:31:26 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1NVtlL-0005cC-Ne
	for gcvg-git-2@lo.gmane.org; Fri, 15 Jan 2010 22:31:24 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758373Ab0AOVbS (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 15 Jan 2010 16:31:18 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1758370Ab0AOVbR
	(ORCPT <rfc822;git-outgoing>); Fri, 15 Jan 2010 16:31:17 -0500
Received: from mail-ew0-f209.google.com ([209.85.219.209]:42825 "EHLO
	mail-ew0-f209.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758366Ab0AOVbO (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 15 Jan 2010 16:31:14 -0500
Received: by mail-ew0-f209.google.com with SMTP id 1so568991ewy.28
        for <git@vger.kernel.org>; Fri, 15 Jan 2010 13:31:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:cc:subject:date
         :message-id:x-mailer:in-reply-to:references;
        bh=5UMpK5nMTbQK+Apy1IwKEW2ZOXzg3dw1N47/GlBd12g=;
        b=c+OhpGPP1wu7kJAcSLCezI86YZ6MiMXOwYTr+p/e8F72c1nm/RoRXWAkyFvJICaMVk
         S0RnzADrPnJFCVb4rXNbnAZjJaZqxhr0H+8O6kTPhD7ruZ7K6WjyhNNAwz9asFcenXjM
         ED2M1mhJ9dUofLWkeuXl/zXmjvpFF1GAUFHRA=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=googlemail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        b=HQCwswQB//VJwxpzvgbBQjtE94jib8rTnmIauduCVS4m3SdNvTR24QQ3H1NX77GHI5
         LZOq77GQIPHJIOnjgoudhoX61leLJg3qV7oQIOASE5c/8oMw377raA+ppA7+63YU2CgL
         kWYrdZ7sKa1xmS2BXz3ro3Ze2QTCfoZfwhLH8=
Received: by 10.213.24.2 with SMTP id t2mr1573460ebb.6.1263591072910;
        Fri, 15 Jan 2010 13:31:12 -0800 (PST)
Received: from localhost (cm-84.215.142.12.getinternet.no [84.215.142.12])
        by mx.google.com with ESMTPS id 14sm694338ewy.15.2010.01.15.13.31.12
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Fri, 15 Jan 2010 13:31:12 -0800 (PST)
X-Mailer: git-send-email 1.6.6.95.g5f22c
In-Reply-To: <1263591033-4992-1-git-send-email-kusmabite@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/137121>

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
1.6.6.211.g26720
