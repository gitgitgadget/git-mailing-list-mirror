From: Erik Faye-Lund <kusmabite@googlemail.com>
Subject: [PATCH/RFC 05/11] inet_ntop: fix a couple of old-style decls
Date: Thu, 26 Nov 2009 00:44:14 +0000
Message-ID: <1259196260-3064-6-git-send-email-kusmabite@gmail.com>
References: <1259196260-3064-1-git-send-email-kusmabite@gmail.com>
 <1259196260-3064-2-git-send-email-kusmabite@gmail.com>
 <1259196260-3064-3-git-send-email-kusmabite@gmail.com>
 <1259196260-3064-4-git-send-email-kusmabite@gmail.com>
 <1259196260-3064-5-git-send-email-kusmabite@gmail.com>
Cc: git@vger.kernel.org, dotzenlabs@gmail.com,
	Erik Faye-Lund <kusmabite@gmail.com>
To: msysgit@googlegroups.com
X-From: git-owner@vger.kernel.org Thu Nov 26 01:44:53 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1NDSTY-00019s-5e
	for gcvg-git-2@lo.gmane.org; Thu, 26 Nov 2009 01:44:48 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965067AbZKZAoe (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 25 Nov 2009 19:44:34 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1760011AbZKZAoe
	(ORCPT <rfc822;git-outgoing>); Wed, 25 Nov 2009 19:44:34 -0500
Received: from ey-out-2122.google.com ([74.125.78.24]:40313 "EHLO
	ey-out-2122.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1759963AbZKZAoc (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 25 Nov 2009 19:44:32 -0500
Received: by ey-out-2122.google.com with SMTP id 4so88193eyf.19
        for <git@vger.kernel.org>; Wed, 25 Nov 2009 16:44:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:cc:subject:date
         :message-id:x-mailer:in-reply-to:references;
        bh=TxAxl6amCyDkG1NvhFzbaXdl4CNwvBz+GF//Mdxace4=;
        b=nRZevPADDmKaek1ZGOC9yn36n86LSQFvVaYisWY29q2wnlLaYIILYj8Ap0IamT3TWU
         IfEZtxOXUDxDfb6pnLZcVsBbIjC1GZZ2a4zX6VRBeFOVye9WMUhGrQnPb6ujdkl96OJ2
         YkYm/RA+TzII8EG15RcQwDC3j2qGT32bgmVBM=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=googlemail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        b=eC/R7HB46mg/Vn0VYshkaLWxLkku0W1NS3Ey4PSWVjSrZ45T0gGJcTHrjWPu1XlFe6
         xlmxqxcauTfXw2jH8aoqS5ZfefmgkLJZ1nCZYlpu6UEE9Z5gsFAr16sb9IlFfRZju+RX
         byutXqddJG6unzk5xKniAHKxsUsH6dDkWXR3k=
Received: by 10.213.110.17 with SMTP id l17mr7502868ebp.18.1259196278999;
        Wed, 25 Nov 2009 16:44:38 -0800 (PST)
Received: from localhost (cm-84.215.142.12.getinternet.no [84.215.142.12])
        by mx.google.com with ESMTPS id 7sm386294eyg.41.2009.11.25.16.44.38
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Wed, 25 Nov 2009 16:44:38 -0800 (PST)
X-Mailer: git-send-email 1.6.4
In-Reply-To: <1259196260-3064-5-git-send-email-kusmabite@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/133736>

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
