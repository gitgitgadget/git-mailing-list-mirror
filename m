X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.176.0/21
X-Spam-Status: No, score=-2.6 required=3.0 tests=BAYES_00,DKIM_ADSP_NXDOMAIN,
	HEADER_FROM_DIFFERENT_DOMAINS,MSGID_FROM_MTA_HEADER,RP_MATCHES_RCVD
	shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
From: Rene Scharfe <rene.scharfe@lsrfire.ath.cx>
Subject: [PATCH] sparse fix: non-ANSI function declaration
Date: Sat, 18 Nov 2006 13:07:06 +0100
Message-ID: <455EF76A.5070705@lsrfire.ath.cx>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: 7bit
NNTP-Posting-Date: Sat, 18 Nov 2006 12:06:57 +0000 (UTC)
Cc: Git Mailing List <git@vger.kernel.org>
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
User-Agent: Thunderbird 1.5.0.8 (Windows/20061025)
X-Enigmail-Version: 0.94.0.0
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/31768>
Received: from vger.kernel.org ([209.132.176.167]) by ciao.gmane.org with
 esmtp (Exim 4.43) id 1GlOy9-0002Qz-Dh for gcvg-git@gmane.org; Sat, 18 Nov
 2006 13:06:49 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand id
 S1754501AbWKRMGq (ORCPT <rfc822;gcvg-git@m.gmane.org>); Sat, 18 Nov 2006
 07:06:46 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754505AbWKRMGq
 (ORCPT <rfc822;git-outgoing>); Sat, 18 Nov 2006 07:06:46 -0500
Received: from static-ip-217-172-187-230.inaddr.intergenia.de
 ([217.172.187.230]:14504 "EHLO neapel230.server4you.de") by vger.kernel.org
 with ESMTP id S1754501AbWKRMGp (ORCPT <rfc822;git@vger.kernel.org>); Sat, 18
 Nov 2006 07:06:45 -0500
Received: from [10.0.1.3] (p508E406F.dip.t-dialin.net [80.142.64.111]) by
 neapel230.server4you.de (Postfix) with ESMTP id 689A723007; Sat, 18 Nov 2006
 13:06:44 +0100 (CET)
To: Junio C Hamano <junkio@cox.net>
Sender: git-owner@vger.kernel.org

The declaration of discard_cache() in cache.h already has its "void".

Signed-off-by: Rene Scharfe <rene.scharfe@lsrfire.ath.cx>
---
 index-pack.c |    2 +-
 read-cache.c |    2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/index-pack.c b/index-pack.c
index 042aea8..8331d99 100644
--- a/index-pack.c
+++ b/index-pack.c
@@ -90,7 +90,7 @@ static SHA_CTX input_ctx;
 static int input_fd, output_fd, mmap_fd;
 
 /* Discard current buffer used content. */
-static void flush()
+static void flush(void)
 {
 	if (input_offset) {
 		if (output_fd >= 0)
diff --git a/read-cache.c b/read-cache.c
index 97c3867..0f5fb5b 100644
--- a/read-cache.c
+++ b/read-cache.c
@@ -844,7 +844,7 @@ unmap:
 	die("index file corrupt");
 }
 
-int discard_cache()
+int discard_cache(void)
 {
 	int ret;
 
-- 
1.4.4
