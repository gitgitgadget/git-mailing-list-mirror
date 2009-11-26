From: Erik Faye-Lund <kusmabite@googlemail.com>
Subject: [PATCH/RFC 05/11] inet_ntop: fix a couple of old-style decls
Date: Thu, 26 Nov 2009 00:39:12 +0000
Message-ID: <1259195958-2372-6-git-send-email-kusmabite@gmail.com>
References: <1259195958-2372-1-git-send-email-kusmabite@gmail.com>
 <1259195958-2372-2-git-send-email-kusmabite@gmail.com>
 <1259195958-2372-3-git-send-email-kusmabite@gmail.com>
 <1259195958-2372-4-git-send-email-kusmabite@gmail.com>
 <1259195958-2372-5-git-send-email-kusmabite@gmail.com>
Cc: git@vger.kernel.org, dotzenlabs@gmail.com,
	Erik Faye-Lund <kusmabite@gmail.com>
To: msysgit@googlecode.com
X-From: git-owner@vger.kernel.org Thu Nov 26 01:39:53 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1NDSOm-0007rM-Mp
	for gcvg-git-2@lo.gmane.org; Thu, 26 Nov 2009 01:39:53 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S935205AbZKZAjh (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 25 Nov 2009 19:39:37 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S935197AbZKZAjh
	(ORCPT <rfc822;git-outgoing>); Wed, 25 Nov 2009 19:39:37 -0500
Received: from ey-out-2122.google.com ([74.125.78.25]:25856 "EHLO
	ey-out-2122.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S935015AbZKZAjg (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 25 Nov 2009 19:39:36 -0500
Received: by ey-out-2122.google.com with SMTP id 4so87639eyf.19
        for <git@vger.kernel.org>; Wed, 25 Nov 2009 16:39:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:cc:subject:date
         :message-id:x-mailer:in-reply-to:references;
        bh=TxAxl6amCyDkG1NvhFzbaXdl4CNwvBz+GF//Mdxace4=;
        b=PTW9Uts/swrebpjXZMgInZ1nujn7AnKBBF1TNXEa15Csbp7ip3wXiNnGswlktNZM/I
         7JqEIYzpAC5qZa3xghvDNOp9KZvzmTzBZ29jO4aZFghGgQip/IaCWWDY8SIcHucP9lDs
         rouReZMDPcG7RP7wLx16L74K757R4O7kRWd0k=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=googlemail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        b=W11D/bTIcgRTrcFmwkAN2YlFGLapYZA6VlmXyryBUrbaJu6hG6fPbUr9h7GB8YAb7I
         pJLwAx3W82gp+6FJ1B8Y1NUaZtyQ/ayVZIEHRwL2iRmXznFOu9j8Zl9jJDJK/fWdLd8Q
         4SoqylZdFWwZa5Ttug98/OQeWyqWPdjTccMMk=
Received: by 10.213.24.2 with SMTP id t2mr2713643ebb.23.1259195981876;
        Wed, 25 Nov 2009 16:39:41 -0800 (PST)
Received: from localhost (cm-84.215.142.12.getinternet.no [84.215.142.12])
        by mx.google.com with ESMTPS id 28sm379800eyg.44.2009.11.25.16.39.41
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Wed, 25 Nov 2009 16:39:41 -0800 (PST)
X-Mailer: git-send-email 1.6.4
In-Reply-To: <1259195958-2372-5-git-send-email-kusmabite@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/133723>

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
1.6.5.rc2.7.g4f8d3
