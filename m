Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.4 required=3.0 tests=AWL,BAYES_00,
	DATE_IN_PAST_06_12,DKIM_ADSP_CUSTOM_MED,FORGED_GMAIL_RCVD,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI shortcircuit=no autolearn=no
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 8094220A1E
	for <e@80x24.org>; Fri, 14 Dec 2018 13:05:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729847AbeLNNF4 (ORCPT <rfc822;e@80x24.org>);
        Fri, 14 Dec 2018 08:05:56 -0500
Received: from mail.javad.com ([54.86.164.124]:53916 "EHLO mail.javad.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729760AbeLNNF4 (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 14 Dec 2018 08:05:56 -0500
Received: from osv (unknown [89.175.180.246])
        by mail.javad.com (Postfix) with ESMTPSA id A64C13FC95;
        Fri, 14 Dec 2018 12:56:20 +0000 (UTC)
Authentication-Results: ip-172-31-2-110;
        spf=pass (sender IP is 89.175.180.246) smtp.mailfrom=sorganov@gmail.com smtp.helo=osv
Received-SPF: pass (ip-172-31-2-110: connection is authenticated)
Received: from osv by osv with local (Exim 4.84_2)
        (envelope-from <sorganov@gmail.com>)
        id 1gXn0s-0003AH-RA; Fri, 14 Dec 2018 15:56:18 +0300
Message-Id: <5baa84089fbfdb16a2887a0144800354297aa0b5.1544764226.git.sorganov@gmail.com>
In-Reply-To: <cover.1544762343.git.sorganov@gmail.com>
References: <cover.1544762343.git.sorganov@gmail.com>
From:   Sergey Organov <sorganov@gmail.com>
Date:   Fri, 14 Dec 2018 07:53:51 +0300
Subject: [PATCH v2 4/4] t3506: validate '-m 1 -ff' is now accepted for
 non-merge commits
To:     git@vger.kernel.org
Cc:     gitster@pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Signed-off-by: Sergey Organov <sorganov@gmail.com>
---
 t/t3506-cherry-pick-ff.sh | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/t/t3506-cherry-pick-ff.sh b/t/t3506-cherry-pick-ff.sh
index fb889ac..127dd00 100755
--- a/t/t3506-cherry-pick-ff.sh
+++ b/t/t3506-cherry-pick-ff.sh
@@ -64,10 +64,10 @@ test_expect_success 'merge setup' '
 	git checkout -b new A
 '
 
-test_expect_success 'cherry-pick a non-merge with --ff and -m should fail' '
+test_expect_success 'cherry-pick explicit first parent of a non-merge with --ff' '
 	git reset --hard A -- &&
-	test_must_fail git cherry-pick --ff -m 1 B &&
-	git diff --exit-code A --
+	git cherry-pick --ff -m 1 B &&
+	git diff --exit-code C --
 '
 
 test_expect_success 'cherry pick a merge with --ff but without -m should fail' '
-- 
2.10.0.1.g57b01a3

