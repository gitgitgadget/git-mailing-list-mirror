Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 9FD711F453
	for <e@80x24.org>; Fri, 26 Apr 2019 19:21:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726659AbfDZTVL (ORCPT <rfc822;e@80x24.org>);
        Fri, 26 Apr 2019 15:21:11 -0400
Received: from mail-pf1-f194.google.com ([209.85.210.194]:36477 "EHLO
        mail-pf1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725875AbfDZTVK (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 26 Apr 2019 15:21:10 -0400
Received: by mail-pf1-f194.google.com with SMTP id z5so2182079pfn.3
        for <git@vger.kernel.org>; Fri, 26 Apr 2019 12:21:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=/xGT0FjoZi7gwZeqWbL/jpoR+5N+lbz2j9gE6+Momo8=;
        b=gvPGghqtUS7iCXgEoXUktxB1lL1jFHOl4EBf7FNOAZ/rCAc08omQ7q6z9rs2OOXzPt
         96WHlpO4kH+RWeS0t+2QMCEcZ1p/su0xC3XxJ8slrFWVJg7PTOdHYKmtD1u1aaq2Nwno
         Rx90Sv4I6X/yaerAevoZtBR1n9IqhsExNFZa9k0YsdcIz9NN/iKA45phBZcC6mJDWHwM
         oi+gHlcYSb+cGl2RVQPgXJH0WqRcVGzifaAeUMmnbv1EwNGa3VPQWh8gBp3Q01heNEuF
         uSepPG9tk7lHyGPzMTqt7fwtHM6rr0JXUhcDoJeagdNPGWz/rOQ43MuDr1+F3gMncJkf
         hkog==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=/xGT0FjoZi7gwZeqWbL/jpoR+5N+lbz2j9gE6+Momo8=;
        b=B1DlGF3g80/pUOFir9mdb3XJyG/j/GRoXH1M6pJwQxlpqPunclYUvTr6zJIMJ1Pwhc
         50KoJVM+rL1HM4HyL5KQ9qexocoKRGAF87FXevUlyUVE7gdH2vMnLgDkg8riciiZNhC7
         DpEAy/qmC77pcMmjORe10QwR5sQseynAVvbXJ0+ULXk0s7I1ugOzFOEmSyt3t3wbd4h2
         9kV1oPkHVWktj213LvoPDYIKToRwMvlVodIZNtmKfnU6xF02kc1RmwwV9KiIOKUUqKwe
         tsJ4SnND3zPZyGq1w4K5vUVPgnDB1Mh0+6hnYNKPR56QRinWH/pRF3A+uV1tcvLQp+Cz
         6mMg==
X-Gm-Message-State: APjAAAVLUdepErVekDn24SIZ/ynbKAJeVhxsZFq8mp2NWj1TxYR24HmP
        RQE66hNiqqmhG/bdHDH6ttQfqRd5XyE=
X-Google-Smtp-Source: APXvYqxqP8TKx7SX70b12TlE2v2oqMr5W42E3CowdY0/Lxh7PdOa4op4zUMneKwpNBkaUSZk64N49Q==
X-Received: by 2002:a65:64da:: with SMTP id t26mr8828532pgv.322.1556306469697;
        Fri, 26 Apr 2019 12:21:09 -0700 (PDT)
Received: from dev-l ([149.28.199.249])
        by smtp.gmail.com with ESMTPSA id h19sm43047012pfd.130.2019.04.26.12.21.08
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 26 Apr 2019 12:21:08 -0700 (PDT)
Date:   Fri, 26 Apr 2019 12:21:08 -0700
From:   Denton Liu <liu.denton@gmail.com>
To:     Git Mailing List <git@vger.kernel.org>
Cc:     Eric Sunshine <sunshine@sunshineco.com>,
        Junio C Hamano <gitster@pobox.com>
Subject: [PATCH v2 1/3] t2018: cleanup in current test
Message-ID: <9d04faf29dd61eb04ea292786d72eda0a3832e51.1556305561.git.liu.denton@gmail.com>
References: <cover.1556226502.git.liu.denton@gmail.com>
 <cover.1556305561.git.liu.denton@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1556305561.git.liu.denton@gmail.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Before, in t2018, if do_checkout failed to create `branch2`, the next
test-case would run `git branch -D branch2` but then fail because it was
expecting `branch2` to exist, even though it doesn't. As a result, an
early failure could cause a cascading failure of tests.

Make test-case responsible for cleaning up their own branches so that
future tests can start with a sane environment.

Signed-off-by: Denton Liu <liu.denton@gmail.com>
---
 t/t2018-checkout-branch.sh | 43 +++++++++++++++-----------------------
 1 file changed, 17 insertions(+), 26 deletions(-)

diff --git a/t/t2018-checkout-branch.sh b/t/t2018-checkout-branch.sh
index c5014ad9a6..f1c7023e1a 100755
--- a/t/t2018-checkout-branch.sh
+++ b/t/t2018-checkout-branch.sh
@@ -60,38 +60,40 @@ test_expect_success 'setup' '
 '
 
 test_expect_success 'checkout -b to a new branch, set to HEAD' '
+	test_when_finished "
+		git checkout branch1 &&
+		test_might_fail git branch -D branch2" &&
 	do_checkout branch2
 '
 
 test_expect_success 'checkout -b to a new branch, set to an explicit ref' '
-	git checkout branch1 &&
-	git branch -D branch2 &&
-
+	test_when_finished "
+		git checkout branch1 &&
+		test_might_fail git branch -D branch2" &&
 	do_checkout branch2 $HEAD1
 '
 
 test_expect_success 'checkout -b to a new branch with unmergeable changes fails' '
-	git checkout branch1 &&
-
-	# clean up from previous test
-	git branch -D branch2 &&
-
 	setup_dirty_unmergeable &&
 	test_must_fail do_checkout branch2 $HEAD1 &&
 	test_dirty_unmergeable
 '
 
 test_expect_success 'checkout -f -b to a new branch with unmergeable changes discards changes' '
+	test_when_finished "
+		git checkout branch1 &&
+		test_might_fail git branch -D branch2" &&
+
 	# still dirty and on branch1
 	do_checkout branch2 $HEAD1 "-f -b" &&
 	test_must_fail test_dirty_unmergeable
 '
 
 test_expect_success 'checkout -b to a new branch preserves mergeable changes' '
-	git checkout branch1 &&
-
-	# clean up from previous test
-	git branch -D branch2 &&
+	test_when_finished "
+		git reset --hard &&
+		git checkout branch1 &&
+		test_might_fail git branch -D branch2" &&
 
 	setup_dirty_mergeable &&
 	do_checkout branch2 $HEAD1 &&
@@ -99,27 +101,18 @@ test_expect_success 'checkout -b to a new branch preserves mergeable changes' '
 '
 
 test_expect_success 'checkout -f -b to a new branch with mergeable changes discards changes' '
-	# clean up from previous test
-	git reset --hard &&
-
-	git checkout branch1 &&
-
-	# clean up from previous test
-	git branch -D branch2 &&
-
+	test_when_finished git reset --hard HEAD &&
 	setup_dirty_mergeable &&
 	do_checkout branch2 $HEAD1 "-f -b" &&
 	test_must_fail test_dirty_mergeable
 '
 
 test_expect_success 'checkout -b to an existing branch fails' '
-	git reset --hard HEAD &&
-
+	test_when_finished git reset --hard HEAD &&
 	test_must_fail do_checkout branch2 $HEAD2
 '
 
 test_expect_success 'checkout -b to @{-1} fails with the right branch name' '
-	git reset --hard HEAD &&
 	git checkout branch1 &&
 	git checkout branch2 &&
 	echo  >expect "fatal: A branch named '\''branch1'\'' already exists." &&
@@ -160,6 +153,7 @@ test_expect_success 'checkout -f -B to an existing branch with unmergeable chang
 '
 
 test_expect_success 'checkout -B to an existing branch preserves mergeable changes' '
+	test_when_finished git reset --hard &&
 	git checkout branch1 &&
 
 	setup_dirty_mergeable &&
@@ -168,9 +162,6 @@ test_expect_success 'checkout -B to an existing branch preserves mergeable chang
 '
 
 test_expect_success 'checkout -f -B to an existing branch with mergeable changes discards changes' '
-	# clean up from previous test
-	git reset --hard &&
-
 	git checkout branch1 &&
 
 	setup_dirty_mergeable &&
-- 
2.21.0.1033.g0e8cc1100c

