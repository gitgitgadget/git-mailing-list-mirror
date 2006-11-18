X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.176.0/21
X-Spam-Status: No, score=-2.6 required=3.0 tests=BAYES_00,DKIM_ADSP_NXDOMAIN,
	HEADER_FROM_DIFFERENT_DOMAINS,MSGID_FROM_MTA_HEADER,RP_MATCHES_RCVD
	shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
From: Rene Scharfe <rene.scharfe@lsrfire.ath.cx>
Subject: [PATCH] sparse fix: Using plain integer as NULL pointer
Date: Sat, 18 Nov 2006 13:06:56 +0100
Message-ID: <455EF760.6040505@lsrfire.ath.cx>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: 7bit
NNTP-Posting-Date: Sat, 18 Nov 2006 12:06:59 +0000 (UTC)
Cc: Git Mailing List <git@vger.kernel.org>
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
User-Agent: Thunderbird 1.5.0.8 (Windows/20061025)
X-Enigmail-Version: 0.94.0.0
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/31769>
Received: from vger.kernel.org ([209.132.176.167]) by ciao.gmane.org with
 esmtp (Exim 4.43) id 1GlOyA-0002Qz-0G for gcvg-git@gmane.org; Sat, 18 Nov
 2006 13:06:50 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand id
 S1754498AbWKRMGm (ORCPT <rfc822;gcvg-git@m.gmane.org>); Sat, 18 Nov 2006
 07:06:42 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754505AbWKRMGm
 (ORCPT <rfc822;git-outgoing>); Sat, 18 Nov 2006 07:06:42 -0500
Received: from static-ip-217-172-187-230.inaddr.intergenia.de
 ([217.172.187.230]:13992 "EHLO neapel230.server4you.de") by vger.kernel.org
 with ESMTP id S1754498AbWKRMGl (ORCPT <rfc822;git@vger.kernel.org>); Sat, 18
 Nov 2006 07:06:41 -0500
Received: from [10.0.1.3] (p508E406F.dip.t-dialin.net [80.142.64.111]) by
 neapel230.server4you.de (Postfix) with ESMTP id 93E4C23001; Sat, 18 Nov 2006
 13:06:40 +0100 (CET)
To: Junio C Hamano <junkio@cox.net>
Sender: git-owner@vger.kernel.org

Z_NULL is defined as 0, use a proper NULL pointer in its stead.

Signed-off-by: Rene Scharfe <rene.scharfe@lsrfire.ath.cx>
---
 archive-zip.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/archive-zip.c b/archive-zip.c
index 28e7352..ae5572a 100644
--- a/archive-zip.c
+++ b/archive-zip.c
@@ -160,7 +160,7 @@ static int write_zip_entry(const unsigne
 	void *buffer = NULL;
 	void *deflated = NULL;
 
-	crc = crc32(0, Z_NULL, 0);
+	crc = crc32(0, NULL, 0);
 
 	path = construct_path(base, baselen, filename, S_ISDIR(mode), &pathlen);
 	if (verbose)
-- 
1.4.4
