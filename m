From: Erik Faye-Lund <kusmabite@gmail.com>
Subject: [PATCH 03/15] inet_ntop: fix a couple of old-style decls
Date: Fri, 22 Oct 2010 02:05:32 +0200
Message-ID: <1287705944-5668-3-git-send-email-kusmabite@gmail.com>
References: <1287705944-5668-1-git-send-email-kusmabite@gmail.com>
Cc: msysgit@googlegroups.com, j6t@kdbg.org, avarab@gmail.com,
	sunshine@sunshineco.com, jrnieder@gmail.com, schwab@linux-m68k.org,
	patthoyts@gmail.com
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Oct 22 02:06:41 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1P959a-0004NN-HB
	for gcvg-git-2@lo.gmane.org; Fri, 22 Oct 2010 02:06:38 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1759132Ab0JVAGf (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 21 Oct 2010 20:06:35 -0400
Received: from mail-ey0-f174.google.com ([209.85.215.174]:34643 "EHLO
	mail-ey0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757314Ab0JVAGe (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 21 Oct 2010 20:06:34 -0400
Received: by eye27 with SMTP id 27so248736eye.19
        for <git@vger.kernel.org>; Thu, 21 Oct 2010 17:06:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:cc:subject:date
         :message-id:x-mailer:in-reply-to:references;
        bh=ODl6t8qe0fhd+U1AH6XekeL8xCIqSsaavsoSlPIcWlU=;
        b=bFV5t57oSo7dUCLFQQw+58xNBrDmhZnD3PS9aboIjfp+9yRAOXqeBWZSqOLG5MgpOs
         X6UWOhnqUkcbiYHeOOvrL7rExvYc9hcSjZtkrv2LhFlpBx6esY+HYiq7tBhPZhWnVIdU
         aKKME4ocVJBIkGf/ZIiv9QRamByXwJI46D0Yo=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        b=XTda6zwCYhP1s+1HdzsbZ07Y9330a9wOXz1n7LiVjrCxHBjaY1DWDiXm0+3sEwoKHS
         0IZfASriihetMF9y+VGe7912qwLBMJZDBzP10dcNYePAYPGt3vhZSNW2Pbmv8oP8XW5r
         Y0OqBcqHS2ehj7+mdTJw/H2bCrFKCbMeYILDI=
Received: by 10.213.13.3 with SMTP id z3mr2505271ebz.28.1287705992958;
        Thu, 21 Oct 2010 17:06:32 -0700 (PDT)
Received: from localhost (cm-84.215.188.225.getinternet.no [84.215.188.225])
        by mx.google.com with ESMTPS id x54sm2463225eeh.23.2010.10.21.17.06.31
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Thu, 21 Oct 2010 17:06:32 -0700 (PDT)
X-Mailer: git-send-email 1.7.3.165.gdfe39.dirty
In-Reply-To: <1287705944-5668-1-git-send-email-kusmabite@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/159592>

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
