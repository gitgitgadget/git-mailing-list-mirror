Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.2 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 66F7F1F954
	for <e@80x24.org>; Sat, 18 Aug 2018 04:50:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726070AbeHRH4h (ORCPT <rfc822;e@80x24.org>);
        Sat, 18 Aug 2018 03:56:37 -0400
Received: from host02.zombieandprude.com ([80.82.119.138]:45118 "EHLO
        host02.zombieandprude.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725916AbeHRH4g (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 18 Aug 2018 03:56:36 -0400
X-Greylist: delayed 423 seconds by postgrey-1.27 at vger.kernel.org; Sat, 18 Aug 2018 03:56:36 EDT
Received: from [12.10.41.130] (port=39403 helo=localhost.localdomain)
        by host02.zombieandprude.com with esmtpsa (TLS1.2:RSA_AES_128_CBC_SHA256:128)
        (Exim 4.80)
        (envelope-from <cb@hashpling.org>)
        id 1fqt53-0001CX-PH; Sat, 18 Aug 2018 05:43:18 +0100
From:   CB Bailey <cb@hashpling.org>
To:     git@vger.kernel.org
Cc:     CB Bailey <cb@hashpling.org>
Subject: [PATCH] t2024: mark test using "checkout -p" with PERL prerequisite
Date:   Fri, 17 Aug 2018 21:43:10 -0700
Message-Id: <20180818044310.14446-1-cb@hashpling.org>
X-Mailer: git-send-email 2.14.3 (Apple Git-98)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

checkout with the -p switch uses the "add interactive" framework which
is written in Perl. Add a PERL prerequisite to skip this test when built
with NO_PERL.

Signed-off-by: CB Bailey <cb@hashpling.org>
---
 t/t2024-checkout-dwim.sh | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/t/t2024-checkout-dwim.sh b/t/t2024-checkout-dwim.sh
index f79dfbbdd6..0e512c3066 100755
--- a/t/t2024-checkout-dwim.sh
+++ b/t/t2024-checkout-dwim.sh
@@ -75,7 +75,7 @@ test_expect_success 'checkout of branch from multiple remotes fails #1' '
 	test_branch master
 '
 
-test_expect_success 'checkout of branch from multiple remotes fails with advice' '
+test_expect_success PERL 'checkout of branch from multiple remotes fails with advice' '
 	git checkout -B master &&
 	test_might_fail git branch -D foo &&
 	test_must_fail git checkout foo 2>stderr &&
-- 
2.14.3 (Apple Git-98)

