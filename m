From: Stefan Beller <stefanbeller@googlemail.com>
Subject: [PATCH 3/4] diff-no-index: Remove unused variable.
Date: Sun, 14 Jul 2013 23:35:48 +0200
Message-ID: <1373837749-14402-3-git-send-email-stefanbeller@googlemail.com>
References: <1373837749-14402-1-git-send-email-stefanbeller@googlemail.com>
Cc: Stefan Beller <stefanbeller@googlemail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Jul 14 23:36:02 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UyTxV-0001TD-Fb
	for gcvg-git-2@plane.gmane.org; Sun, 14 Jul 2013 23:35:57 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753330Ab3GNVfw (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 14 Jul 2013 17:35:52 -0400
Received: from mail-ee0-f54.google.com ([74.125.83.54]:54575 "EHLO
	mail-ee0-f54.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753316Ab3GNVfu (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 14 Jul 2013 17:35:50 -0400
Received: by mail-ee0-f54.google.com with SMTP id t10so7243102eei.27
        for <git@vger.kernel.org>; Sun, 14 Jul 2013 14:35:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        bh=cnJrJdjG5u6kjVsaqZZKB+hTtlN8sPuEMipxcXuOUDc=;
        b=CVWEn2JtKGBsltODJpH4yXgpf1RwFxhyysrkUHIyilGtcbd+hLFs6WIB3Jpivx0AQ2
         ORZvWeDqGkrKSkgkn8Z+5LreaY3ZNlJNKWhErOaDYN3C9MXnoCQrwAnXWDEu7OB1V3ws
         NDNEAppK4YsCQSEPCuFUWZvdwg60AR87lnNVZccTBc1LhuPfneLHHv0jkPbD+E4YlzxV
         Lu9oKoVnM3+M7VhQMCnlC+PRwltZc1UE3fFx8yA3ZCR04KyNoYVfIA60SGpscMitxieI
         MaNcG8klxAO1N2peuntfVloTtXBkxnDYt2szdshzMkM+4MoW3BiTD/HFg49MDALel4i+
         5OXA==
X-Received: by 10.14.100.135 with SMTP id z7mr56020888eef.113.1373837749055;
        Sun, 14 Jul 2013 14:35:49 -0700 (PDT)
Received: from localhost (ip-109-91-109-128.unitymediagroup.de. [109.91.109.128])
        by mx.google.com with ESMTPSA id cg12sm97548173eeb.7.2013.07.14.14.35.47
        for <multiple recipients>
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Sun, 14 Jul 2013 14:35:48 -0700 (PDT)
X-Mailer: git-send-email 1.8.3.2.806.gdee5b9b
In-Reply-To: <1373837749-14402-1-git-send-email-stefanbeller@googlemail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/230395>

Signed-off-by: Stefan Beller <stefanbeller@googlemail.com>
---
 diff-no-index.c | 5 +----
 1 file changed, 1 insertion(+), 4 deletions(-)

diff --git a/diff-no-index.c b/diff-no-index.c
index e66fdf3..842add4 100644
--- a/diff-no-index.c
+++ b/diff-no-index.c
@@ -181,19 +181,18 @@ static int queue_diff(struct diff_options *o,
 	}
 }
 
 void diff_no_index(struct rev_info *revs,
 		   int argc, const char **argv,
 		   int nongit, const char *prefix)
 {
 	int i, prefixlen;
 	int no_index = 0;
-	unsigned options = 0;
 	const char *paths[2];
 
 	/* Were we asked to do --no-index explicitly? */
 	for (i = 1; i < argc; i++) {
 		if (!strcmp(argv[i], "--")) {
 			i++;
 			break;
 		}
 		if (!strcmp(argv[i], "--no-index"))
@@ -218,22 +217,20 @@ void diff_no_index(struct rev_info *revs,
 	if (argc != i + 2)
 		usagef("git diff %s <path> <path>",
 		       no_index ? "--no-index" : "[--no-index]");
 
 	diff_setup(&revs->diffopt);
 	for (i = 1; i < argc - 2; ) {
 		int j;
 		if (!strcmp(argv[i], "--no-index"))
 			i++;
-		else if (!strcmp(argv[i], "-q")) {
-			options |= DIFF_SILENT_ON_REMOVED;
+		else if (!strcmp(argv[i], "-q"))
 			i++;
-		}
 		else if (!strcmp(argv[i], "--"))
 			i++;
 		else {
 			j = diff_opt_parse(&revs->diffopt, argv + i, argc - i);
 			if (!j)
 				die("invalid diff option/value: %s", argv[i]);
 			i += j;
 		}
 	}
-- 
1.8.3.2.806.gdee5b9b
