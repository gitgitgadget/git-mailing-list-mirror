X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.176.0/21
X-Spam-Status: No, score=-3.3 required=3.0 tests=AWL,BAYES_00,
	DKIM_ADSP_CUSTOM_MED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MSGID_FROM_MTA_HEADER,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
From: Andy Parkins <andyparkins@gmail.com>
Subject: [PATCH 2/4] Rename remote_only to display_mode
Date: Thu, 2 Nov 2006 11:11:09 +0000
Message-ID: <200611021111.09434.andyparkins@gmail.com>
References: <bec6ab7849e3fcacac23cca44a0ba93282af5fca.1162465753.git.andyparkins@gmail.com>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
NNTP-Posting-Date: Thu, 2 Nov 2006 11:11:22 +0000 (UTC)
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
In-Reply-To: <bec6ab7849e3fcacac23cca44a0ba93282af5fca.1162465753.git.andyparkins@gmail.com>
X-TUID: 5a68b793aab4c930
X-UID: 157
X-Length: 1993
Content-Disposition: inline
X-OriginalArrivalTime: 02 Nov 2006 11:12:15.0936 (UTC) FILETIME=[C0FE6400:01C6FE6F]
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/30721>
Received: from vger.kernel.org ([209.132.176.167]) by ciao.gmane.org with
 esmtp (Exim 4.43) id 1GfaTc-0003xJ-5g for gcvg-git@gmane.org; Thu, 02 Nov
 2006 12:11:16 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand id
 S1752125AbWKBLLN (ORCPT <rfc822;gcvg-git@m.gmane.org>); Thu, 2 Nov 2006
 06:11:13 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752843AbWKBLLN
 (ORCPT <rfc822;git-outgoing>); Thu, 2 Nov 2006 06:11:13 -0500
Received: from mail.360visiontechnology.com ([194.70.53.226]:12134 "EHLO
 369run02s.360vision.com") by vger.kernel.org with ESMTP id S1752125AbWKBLLM
 (ORCPT <rfc822;git@vger.kernel.org>); Thu, 2 Nov 2006 06:11:12 -0500
Received: from dvr.360vision.com ([192.189.1.24]) by 369run02s.360vision.com
 with Microsoft SMTPSVC(5.0.2195.6713); Thu, 2 Nov 2006 11:12:15 +0000
Received: from localhost ([127.0.0.1]) by dvr.360vision.com with esmtp (Exim
 3.36 #1 (Debian)) id 1GfaTW-0003ve-00 for <git@vger.kernel.org>; Thu, 02 Nov
 2006 11:11:11 +0000
To: git@vger.kernel.org
Sender: git-owner@vger.kernel.org

Signed-off-by: Andy Parkins <andyparkins@gmail.com>
---
 builtin-branch.c |   10 +++++-----
 1 files changed, 5 insertions(+), 5 deletions(-)

diff --git a/builtin-branch.c b/builtin-branch.c
index 368b68e..85b7007 100644
--- a/builtin-branch.c
+++ b/builtin-branch.c
@@ -100,12 +100,12 @@ static int ref_cmp(const void *r1, const
 	return strcmp(*(char **)r1, *(char **)r2);
 }
 
-static void print_ref_list(int remote_only)
+static void print_ref_list(int display_mode)
 {
 	int i;
 	char c;
 
-	if (remote_only)
+	if (display_mode)
 		for_each_remote_ref(append_ref, NULL);
 	else
 		for_each_branch_ref(append_ref, NULL);
@@ -160,7 +160,7 @@ static void create_branch(const char *na
 
 int cmd_branch(int argc, const char **argv, const char *prefix)
 {
-	int delete = 0, force_delete = 0, force_create = 0, remote_only = 0;
+	int delete = 0, force_delete = 0, force_create = 0, display_mode = 0;
 	int reflog = 0;
 	int i;
 
@@ -189,7 +189,7 @@ int cmd_branch(int argc, const char **ar
 			continue;
 		}
 		if (!strcmp(arg, "-r")) {
-			remote_only = 1;
+			display_mode = 1;
 			continue;
 		}
 		if (!strcmp(arg, "-l")) {
@@ -209,7 +209,7 @@ int cmd_branch(int argc, const char **ar
 	if (delete)
 		delete_branches(argc - i, argv + i, force_delete);
 	else if (i == argc)
-		print_ref_list(remote_only);
+		print_ref_list(display_mode);
 	else if (i == argc - 1)
 		create_branch(argv[i], head, force_create, reflog);
 	else if (i == argc - 2)
-- 
1.4.3.2

