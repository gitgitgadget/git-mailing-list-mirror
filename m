From: Florian Forster <octo@verplant.org>
Subject: [PATCH 6/7] Change types used in bitfields to be `int's.
Date: Sun, 18 Jun 2006 17:18:08 +0200
Message-ID: <1150643889961-git-send-email-octo@verplant.org>
References: <11506438893544-git-send-email-octo@verplant.org>
Reply-To: Florian Forster <octo@verplant.org>
Cc: Florian Forster <octo@verplant.org>
X-From: git-owner@vger.kernel.org Sun Jun 18 17:18:39 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1Frz2n-0005K3-Pf
	for gcvg-git@gmane.org; Sun, 18 Jun 2006 17:18:34 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751176AbWFRPSS (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 18 Jun 2006 11:18:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751180AbWFRPSS
	(ORCPT <rfc822;git-outgoing>); Sun, 18 Jun 2006 11:18:18 -0400
Received: from verplant.org ([213.95.21.52]:36489 "EHLO huhu.verplant.org")
	by vger.kernel.org with ESMTP id S1751176AbWFRPSN (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 18 Jun 2006 11:18:13 -0400
Received: from leeloo.lan.home.verplant.org ([2001:780:104:1:2e0:18ff:fead:37e4] ident=Debian-exim)
	by huhu.verplant.org with esmtpsa (TLS-1.0:RSA_AES_256_CBC_SHA:32)
	(Exim 4.50)
	id 1Frz2S-0004Zc-5p; Sun, 18 Jun 2006 17:18:12 +0200
Received: from localhost
	([127.0.0.1] helo=localhost.localdomain ident=octo)
	by leeloo.lan.home.verplant.org with esmtp (Exim 4.62)
	(envelope-from <octo@verplant.org>)
	id 1Frz2P-00028O-F6; Sun, 18 Jun 2006 17:18:09 +0200
To: git@vger.kernel.org
X-Mailer: git-send-email 1.3.3
In-Reply-To: <11506438893544-git-send-email-octo@verplant.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/22090>

According to ANSI C99 bitfields are only defined for `signed int' and `unsigned
int'. This patch corrects the bitfield in the `msg_data_t' type from
`imap-send.c'.

Signed-off-by: Florian Forster <octo@verplant.org>


---

 imap-send.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

471838c5e32b83bc8b84584343daeb1174d0e968
diff --git a/imap-send.c b/imap-send.c
index 285ad29..94e39cd 100644
--- a/imap-send.c
+++ b/imap-send.c
@@ -93,7 +93,7 @@ typedef struct {
 	char *data;
 	int len;
 	unsigned char flags;
-	unsigned char crlf:1;
+	unsigned int crlf:1;
 } msg_data_t;
 
 #define DRV_OK          0
-- 
1.3.3
