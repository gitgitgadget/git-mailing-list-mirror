X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.176.0/21
X-Spam-Status: No, score=-3.3 required=3.0 tests=AWL,BAYES_00,
	DKIM_ADSP_CUSTOM_MED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MSGID_FROM_MTA_HEADER,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
From: Andy Parkins <andyparkins@gmail.com>
Subject: [PATCH 1/4] Remove uneccessarily similar printf() from print_ref_list()
Date: Thu, 2 Nov 2006 11:10:52 +0000
Message-ID: <200611021110.52952.andyparkins@gmail.com>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
NNTP-Posting-Date: Thu, 2 Nov 2006 11:11:12 +0000 (UTC)
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
X-TUID: 00b6da1e5e6f0ab7
X-UID: 156
X-Length: 1161
Content-Disposition: inline
X-OriginalArrivalTime: 02 Nov 2006 11:11:59.0764 (UTC) FILETIME=[B75ABD40:01C6FE6F]
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/30720>
Received: from vger.kernel.org ([209.132.176.167]) by ciao.gmane.org with
 esmtp (Exim 4.43) id 1GfaTM-0003ss-H1 for gcvg-git@gmane.org; Thu, 02 Nov
 2006 12:11:00 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand id
 S1752115AbWKBLK5 (ORCPT <rfc822;gcvg-git@m.gmane.org>); Thu, 2 Nov 2006
 06:10:57 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752125AbWKBLK5
 (ORCPT <rfc822;git-outgoing>); Thu, 2 Nov 2006 06:10:57 -0500
Received: from mail.360visiontechnology.com ([194.70.53.226]:10086 "EHLO
 369run02s.360vision.com") by vger.kernel.org with ESMTP id S1752115AbWKBLK5
 (ORCPT <rfc822;git@vger.kernel.org>); Thu, 2 Nov 2006 06:10:57 -0500
Received: from dvr.360vision.com ([192.189.1.24]) by 369run02s.360vision.com
 with Microsoft SMTPSVC(5.0.2195.6713); Thu, 2 Nov 2006 11:11:59 +0000
Received: from localhost ([127.0.0.1]) by dvr.360vision.com with esmtp (Exim
 3.36 #1 (Debian)) id 1GfaTG-0003vJ-00 for <git@vger.kernel.org>; Thu, 02 Nov
 2006 11:10:54 +0000
To: git@vger.kernel.org
Sender: git-owner@vger.kernel.org

Signed-off-by: Andy Parkins <andyparkins@gmail.com>
---
 builtin-branch.c |    8 +++++---
 1 files changed, 5 insertions(+), 3 deletions(-)

diff --git a/builtin-branch.c b/builtin-branch.c
index e028a53..368b68e 100644
--- a/builtin-branch.c
+++ b/builtin-branch.c
@@ -103,6 +103,7 @@ static int ref_cmp(const void *r1, const
 static void print_ref_list(int remote_only)
 {
 	int i;
+	char c;
 
 	if (remote_only)
 		for_each_remote_ref(append_ref, NULL);
@@ -112,10 +113,11 @@ static void print_ref_list(int remote_on
 	qsort(ref_list, ref_index, sizeof(char *), ref_cmp);
 
 	for (i = 0; i < ref_index; i++) {
+		c = ' ';
 		if (!strcmp(ref_list[i], head))
-			printf("* %s\n", ref_list[i]);
-		else
-			printf("  %s\n", ref_list[i]);
+			c = '*';
+
+		printf("%c %s\n", c, ref_list[i]);
 	}
 }
 
-- 
1.4.3.2

