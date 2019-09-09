Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.9 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id F34CA1F461
	for <e@80x24.org>; Mon,  9 Sep 2019 01:54:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732589AbfIIByW (ORCPT <rfc822;e@80x24.org>);
        Sun, 8 Sep 2019 21:54:22 -0400
Received: from omta011.uswest2.a.cloudfilter.net ([35.164.127.234]:41537 "EHLO
        omta011.uswest2.a.cloudfilter.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1732197AbfIIByW (ORCPT
        <rfc822;git@vger.kernel.org>); Sun, 8 Sep 2019 21:54:22 -0400
X-Greylist: delayed 427 seconds by postgrey-1.27 at vger.kernel.org; Sun, 08 Sep 2019 21:54:22 EDT
Received: from cxr.smtp.a.cloudfilter.net ([10.0.17.211])
        by cmsmtp with ESMTP
        id 6wqmi2uhlfISc78luidfo4; Mon, 09 Sep 2019 01:47:15 +0000
Received: from thunderbird.smith.home ([68.231.71.156])
        by cmsmtp with ESMTPSA
        id 78lsiEGEtjSWO78ltiYXUQ; Mon, 09 Sep 2019 01:47:14 +0000
Authentication-Results: cox.net; auth=pass (LOGIN) smtp.auth=ischis2@cox.net
X-Authority-Analysis: v=2.3 cv=Xaj3M7x5 c=1 sm=1 tr=0
 a=3BwGCz7hYCwPRAPwzRnSaA==:117 a=3BwGCz7hYCwPRAPwzRnSaA==:17
 a=jpOVt7BSZ2e4Z31A5e1TngXxSK0=:19 a=J70Eh1EUuV4A:10 a=kviXuzpPAAAA:8
 a=syx1Sf1t1GXH5zMEbJgA:9 a=qrIFiuKZe2vaD64auk6j:22 a=Z5ABNNGmrOfJ6cZ5bIyy:22
 a=UDnyf2zBuKT2w-IlGP_r:22
Received: from thunderbird.smith.home (localhost [127.0.0.1])
        by thunderbird.smith.home (Postfix) with ESMTP id C36B9B82907
        for <git@vger.kernel.org>; Sun,  8 Sep 2019 18:47:11 -0700 (MST)
From:   "Stephen P. Smith" <ischis2@cox.net>
To:     git@vger.kernel.org
Subject: [PATCH 2/2] test_date.c: Remove reference to GIT_TEST_DATE_NOW
Date:   Sun,  8 Sep 2019 18:47:11 -0700
Message-Id: <20190909014711.3894-3-ischis2@cox.net>
X-Mailer: git-send-email 2.23.0
In-Reply-To: <20190909014711.3894-1-ischis2@cox.net>
References: <20190909014711.3894-1-ischis2@cox.net>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CMAE-Envelope: MS4wfD7O2jqcELQ87kxNxMrMyYHZThMGtv9StFEWLwKsprPs36x4ViUVvUnOnutO/f08hiluQLSz3NR00MB0AJyd4v8oYQdu5GxGQmIOwmBOPOK1khYg5WI9
 irEmlO7A/kjaRgqMuTKA/iq5qhixzHR9VgO2XJF1KpHGwdVe1jGC9/KWL+RXbgsskKWu/akS7zAAQA==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Remove the reference to the GIT_TEST_DATE_NOW which is done in date.c.
The intialization of variable x with the value from GIT_TEST_DATE_NOW
is unneeded since x is initalized by skip_prefix().

Signed-off-by: Stephen P. Smith <ischis2@cox.net>
---
 t/helper/test-date.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/t/helper/test-date.c b/t/helper/test-date.c
index deb5869343..099eff4f0f 100644
--- a/t/helper/test-date.c
+++ b/t/helper/test-date.c
@@ -104,7 +104,6 @@ static void getnanos(const char **argv)
 int cmd__date(int argc, const char **argv)
 {
 	const char *x;
-	x = getenv("GIT_TEST_DATE_NOW");
 
 	argv++;
 	if (!*argv)
-- 
2.23.0

