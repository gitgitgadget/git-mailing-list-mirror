From: Samuel Bronson <naesten@gmail.com>
Subject: [PATCH] wt-status.c: disable those distracting -Wformat-zero-length warnings
Date: Fri, 20 Dec 2013 10:45:01 -0500
Message-ID: <1387554301-23901-1-git-send-email-naesten@gmail.com>
Cc: Samuel Bronson <naesten@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Dec 20 16:45:29 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Vu2GV-0001kK-4T
	for gcvg-git-2@plane.gmane.org; Fri, 20 Dec 2013 16:45:27 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752950Ab3LTPpX (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 20 Dec 2013 10:45:23 -0500
Received: from mail-qe0-f51.google.com ([209.85.128.51]:46697 "EHLO
	mail-qe0-f51.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752575Ab3LTPpW (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 20 Dec 2013 10:45:22 -0500
Received: by mail-qe0-f51.google.com with SMTP id 1so2466932qee.24
        for <git@vger.kernel.org>; Fri, 20 Dec 2013 07:45:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id;
        bh=MdF3CbY+OmgdVeONXcKCGHeMUSugvXpSfFbEu34bu7M=;
        b=inACkbkW8DAQv/u9aL+6g3TLQJEn+S+cNRypaYqD+xByj5V4idU2xeBfZlZvq//ehn
         RVGt7G5JNtSA4SP78Jl8csj4u3riNSTwbZFmBTRASmUWbpYdp0g7KwSzp4sZEaP7mp6e
         0VwXP+6Z+f3Rosl3jLLJUUWzGHeq0E767UiSQnXjed+9Wo26Jn1/MgIm6aPsHAUXottL
         ddIEnBKCKhHIukBgte5YbDupr/p0r73uuq7DYT8S7hDvg4X7M1uRCrGn5N6tdy9OVfTl
         KbAnwCOKcZqcT+ei4ZaBQC5Vr8VXC1eB8gpi0fh9tM24SVlnDCZXNfGLXMd3nuc9vRTm
         xH0Q==
X-Received: by 10.224.147.75 with SMTP id k11mr15051818qav.22.1387554320349;
        Fri, 20 Dec 2013 07:45:20 -0800 (PST)
Received: from hydrogen (naesten-pt.tunnel.tserv4.nyc4.ipv6.he.net. [2001:470:1f06:57::2])
        by mx.google.com with ESMTPSA id g1sm6821085qec.9.2013.12.20.07.45.19
        for <multiple recipients>
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Fri, 20 Dec 2013 07:45:19 -0800 (PST)
Received: from naesten by hydrogen with local (Exim 4.80)
	(envelope-from <naesten@gmail.com>)
	id 1Vu2GM-0006EC-Bo; Fri, 20 Dec 2013 10:45:18 -0500
X-Mailer: git-send-email 1.8.4.3
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/239574>

These warnings don't really seem to make much sense for this file.

Signed-off-by: Samuel Bronson <naesten@gmail.com>
---
 wt-status.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/wt-status.c b/wt-status.c
index 4e55810..542cc65 100644
--- a/wt-status.c
+++ b/wt-status.c
@@ -17,6 +17,11 @@
 #include "strbuf.h"
 #include "utf8.h"
 
+/* We have good reasons for using zero-length format strings, and
+ * there's unfortunately no way to turn this off on a per-function
+ * basis ... */
+#pragma GCC diagnostic ignored "-Wformat-zero-length"
+
 static char cut_line[] =
 "------------------------ >8 ------------------------\n";
 
-- 
1.8.4.3
