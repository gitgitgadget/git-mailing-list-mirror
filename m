Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.6 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RCVD_IN_SORBS_SPAM,RP_MATCHES_RCVD shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 0601520A93
	for <e@80x24.org>; Tue, 10 Jan 2017 01:46:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1161624AbdAJBp7 (ORCPT <rfc822;e@80x24.org>);
        Mon, 9 Jan 2017 20:45:59 -0500
Received: from mail-pf0-f172.google.com ([209.85.192.172]:33853 "EHLO
        mail-pf0-f172.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1032193AbdAJBp5 (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 9 Jan 2017 20:45:57 -0500
Received: by mail-pf0-f172.google.com with SMTP id 127so37233107pfg.1
        for <git@vger.kernel.org>; Mon, 09 Jan 2017 17:45:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=65psVJ8/rDDwk4plHyM5iTmP8UdPWzn4Tg6hUTVL0rQ=;
        b=FfqBeeWrgB0IJjB2SMSsOoDpAwKw8FhYLFDSTpguNdpR1VQZwaDWfC/q8mDIgtnpCQ
         4/+dD4uJqFEsdZqi/7ZHMejH30+C967L+0O57vEw0Kwu6i13s6mYd0FtqyEZ4nUU4LIv
         34pOWTOlmhzFBid8RH4oiWFiZGhZip9tqDXaxaSZWzUmzDhkoO0YC1eqZXtVj4aP+Kl5
         s0XX/kp80IaSoDZVn/9Tyqhm1Qu87yxLlT6M/+LVb8KDuOKAtOUYEWFm7cUrYzzwH2ln
         5cGNnugJKikN+VsJxefxCR9MYNRZa4f2CqRWzedhQrXhSFBiLt9nfsIrq/AC2xICsG9d
         Mbkg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=65psVJ8/rDDwk4plHyM5iTmP8UdPWzn4Tg6hUTVL0rQ=;
        b=QlQGezp4/s0E4Gj8cadWozxSpsl27okdyuMiPMAD76UZtE6t6lj3F4CYHMe5RYMsir
         QZi5IqSqvAwk5VLfsgctgewH7HBaASsH09o1nCEaSLGin5FIUbpbH0EiJQBWlgU+vrVq
         ox5kWtDBsFBL1xy4AiX/yoodSbCyVECTpwr/NQr60foMVb0xsDoLZFafIo6KJs9qAS62
         4YAmRbdjZrviiEb4RzMKNf1Jek/cc1/IQkpkx42Ny6JLmZDr+5q7aue3GK5OnMFKa/Aj
         5EEC2A8jzPbTz5gAXKnYHuRmpFNSzvusCIXZ3sJmrVuNz451u2iFTam3qu3kLjJVHMHj
         RIjQ==
X-Gm-Message-State: AIkVDXJi4DvyQlTNMj6LYZQH92L33LI5nI773HeAnujmW8betb+O+arfeiCWcDB5gNm2OuFH
X-Received: by 10.99.108.7 with SMTP id h7mr506304pgc.71.1484012755714;
        Mon, 09 Jan 2017 17:45:55 -0800 (PST)
Received: from localhost ([2620:0:1000:5b10:1e2:be00:4066:92e5])
        by smtp.gmail.com with ESMTPSA id y12sm365819pfg.81.2017.01.09.17.45.55
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Mon, 09 Jan 2017 17:45:55 -0800 (PST)
From:   Stefan Beller <sbeller@google.com>
To:     bmwill@google.com, novalis@novalis.org
Cc:     git@vger.kernel.org, Stefan Beller <sbeller@google.com>
Subject: [PATCH 3/4] t1001: modernize style
Date:   Mon,  9 Jan 2017 17:45:41 -0800
Message-Id: <20170110014542.19352-4-sbeller@google.com>
X-Mailer: git-send-email 2.11.0.rc2.30.g7c4be45.dirty
In-Reply-To: <20170110014542.19352-1-sbeller@google.com>
References: <20170110014542.19352-1-sbeller@google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

The preferred style in tests seems to be

test_expect_success 'short description, ended by 2 single quotes' '
	here comes the test &&
	and chains over many lines &&
 	ended by a quote
'

Or going by the numbers:
    $ git -C t/ grep "' '$" | wc -l
    9796
    $ git -C t/ grep test_expect_ |wc -l
    11861

Signed-off-by: Stefan Beller <sbeller@google.com>
---
 t/t1001-read-tree-m-2way.sh | 641 ++++++++++++++++++++++----------------------
 1 file changed, 320 insertions(+), 321 deletions(-)

diff --git a/t/t1001-read-tree-m-2way.sh b/t/t1001-read-tree-m-2way.sh
index db1b6f5cf4..7b70089705 100755
--- a/t/t1001-read-tree-m-2way.sh
+++ b/t/t1001-read-tree-m-2way.sh
@@ -14,10 +14,10 @@ all the combinations described in the two-tree merge "carry forward"
 rules, found in <Documentation/git read-tree.txt>.
 
 In the test, these paths are used:
-        bozbar  - in H, stays in M, modified from bozbar to gnusto
-        frotz   - not in H added in M
-        nitfol  - in H, stays in M unmodified
-        rezrov  - in H, deleted in M
+	bozbar  - in H, stays in M, modified from bozbar to gnusto
+	frotz   - not in H added in M
+	nitfol  - in H, stays in M unmodified
+	rezrov  - in H, deleted in M
 	yomin   - not in H or M
 '
 . ./test-lib.sh
@@ -60,336 +60,335 @@ EOF
 
 sed -e 's/bozbar/gnusto (earlier bozbar)/' bozbar-old >bozbar-new
 
-test_expect_success \
-    setup \
-    'echo frotz >frotz &&
-     echo nitfol >nitfol &&
-     cat bozbar-old >bozbar &&
-     echo rezrov >rezrov &&
-     echo yomin >yomin &&
-     git update-index --add nitfol bozbar rezrov &&
-     treeH=$(git write-tree) &&
-     echo treeH $treeH &&
-     git ls-tree $treeH &&
-
-     cat bozbar-new >bozbar &&
-     git update-index --add frotz bozbar --force-remove rezrov &&
-     git ls-files --stage >M.out &&
-     treeM=$(git write-tree) &&
-     echo treeM $treeM &&
-     git ls-tree $treeM &&
-     git diff-tree $treeH $treeM'
-
-test_expect_success \
-    '1, 2, 3 - no carry forward' \
-    'rm -f .git/index &&
-     read_tree_twoway $treeH $treeM &&
-     git ls-files --stage >1-3.out &&
-     test_cmp M.out 1-3.out &&
-     check_cache_at bozbar dirty &&
-     check_cache_at frotz dirty &&
-     check_cache_at nitfol dirty'
+test_expect_success 'setup' '
+	echo frotz >frotz &&
+	echo nitfol >nitfol &&
+	cat bozbar-old >bozbar &&
+	echo rezrov >rezrov &&
+	echo yomin >yomin &&
+	git update-index --add nitfol bozbar rezrov &&
+	treeH=$(git write-tree) &&
+	echo treeH $treeH &&
+	git ls-tree $treeH &&
+
+	cat bozbar-new >bozbar &&
+	git update-index --add frotz bozbar --force-remove rezrov &&
+	git ls-files --stage >M.out &&
+	treeM=$(git write-tree) &&
+	echo treeM $treeM &&
+	git ls-tree $treeM &&
+	git diff-tree $treeH $treeM
+'
 
+test_expect_success '1, 2, 3 - no carry forward' '
+	rm -f .git/index &&
+	read_tree_twoway $treeH $treeM &&
+	git ls-files --stage >1-3.out &&
+	test_cmp M.out 1-3.out &&
+	check_cache_at bozbar dirty &&
+	check_cache_at frotz dirty &&
+	check_cache_at nitfol dirty
+'
 echo '+100644 X 0	yomin' >expected
 
-test_expect_success \
-    '4 - carry forward local addition.' \
-    'rm -f .git/index &&
-     read_tree_must_succeed $treeH &&
-     git checkout-index -u -f -q -a &&
-     git update-index --add yomin &&
-     read_tree_twoway $treeH $treeM &&
-     git ls-files --stage >4.out &&
-     test_must_fail git diff --no-index M.out 4.out >4diff.out &&
-     compare_change 4diff.out expected &&
-     check_cache_at yomin clean'
-
-test_expect_success \
-    '5 - carry forward local addition.' \
-    'rm -f .git/index &&
-     read_tree_must_succeed $treeH &&
-     git checkout-index -u -f -q -a &&
-     echo yomin >yomin &&
-     git update-index --add yomin &&
-     echo yomin yomin >yomin &&
-     read_tree_twoway $treeH $treeM &&
-     git ls-files --stage >5.out &&
-     test_must_fail git diff --no-index M.out 5.out >5diff.out &&
-     compare_change 5diff.out expected &&
-     check_cache_at yomin dirty'
-
-test_expect_success \
-    '6 - local addition already has the same.' \
-    'rm -f .git/index &&
-     read_tree_must_succeed $treeH &&
-     git checkout-index -u -f -q -a &&
-     git update-index --add frotz &&
-     read_tree_twoway $treeH $treeM &&
-     git ls-files --stage >6.out &&
-     test_cmp M.out 6.out &&
-     check_cache_at frotz clean'
-
-test_expect_success \
-    '7 - local addition already has the same.' \
-    'rm -f .git/index &&
-     read_tree_must_succeed $treeH &&
-     git checkout-index -u -f -q -a &&
-     echo frotz >frotz &&
-     git update-index --add frotz &&
-     echo frotz frotz >frotz &&
-     read_tree_twoway $treeH $treeM &&
-     git ls-files --stage >7.out &&
-     test_cmp M.out 7.out &&
-     check_cache_at frotz dirty'
-
-test_expect_success \
-    '8 - conflicting addition.' \
-    'rm -f .git/index &&
-     read_tree_must_succeed $treeH &&
-     git checkout-index -u -f -q -a &&
-     echo frotz frotz >frotz &&
-     git update-index --add frotz &&
-     if read_tree_twoway $treeH $treeM; then false; else :; fi'
-
-test_expect_success \
-    '9 - conflicting addition.' \
-    'rm -f .git/index &&
-     read_tree_must_succeed $treeH &&
-     git checkout-index -u -f -q -a &&
-     echo frotz frotz >frotz &&
-     git update-index --add frotz &&
-     echo frotz >frotz &&
-     if read_tree_twoway $treeH $treeM; then false; else :; fi'
-
-test_expect_success \
-    '10 - path removed.' \
-    'rm -f .git/index &&
-     read_tree_must_succeed $treeH &&
-     git checkout-index -u -f -q -a &&
-     echo rezrov >rezrov &&
-     git update-index --add rezrov &&
-     read_tree_twoway $treeH $treeM &&
-     git ls-files --stage >10.out &&
-     test_cmp M.out 10.out'
-
-test_expect_success \
-    '11 - dirty path removed.' \
-    'rm -f .git/index &&
-     read_tree_must_succeed $treeH &&
-     git checkout-index -u -f -q -a &&
-     echo rezrov >rezrov &&
-     git update-index --add rezrov &&
-     echo rezrov rezrov >rezrov &&
-     if read_tree_twoway $treeH $treeM; then false; else :; fi'
-
-test_expect_success \
-    '12 - unmatching local changes being removed.' \
-    'rm -f .git/index &&
-     read_tree_must_succeed $treeH &&
-     git checkout-index -u -f -q -a &&
-     echo rezrov rezrov >rezrov &&
-     git update-index --add rezrov &&
-     if read_tree_twoway $treeH $treeM; then false; else :; fi'
-
-test_expect_success \
-    '13 - unmatching local changes being removed.' \
-    'rm -f .git/index &&
-     read_tree_must_succeed $treeH &&
-     git checkout-index -u -f -q -a &&
-     echo rezrov rezrov >rezrov &&
-     git update-index --add rezrov &&
-     echo rezrov >rezrov &&
-     if read_tree_twoway $treeH $treeM; then false; else :; fi'
+test_expect_success '4 - carry forward local addition.' '
+	rm -f .git/index &&
+	read_tree_must_succeed $treeH &&
+	git checkout-index -u -f -q -a &&
+	git update-index --add yomin &&
+	read_tree_twoway $treeH $treeM &&
+	git ls-files --stage >4.out &&
+	test_must_fail git diff --no-index M.out 4.out >4diff.out &&
+	compare_change 4diff.out expected &&
+	check_cache_at yomin clean
+'
+
+test_expect_success '5 - carry forward local addition.' '
+	rm -f .git/index &&
+	read_tree_must_succeed $treeH &&
+	git checkout-index -u -f -q -a &&
+	echo yomin >yomin &&
+	git update-index --add yomin &&
+	echo yomin yomin >yomin &&
+	read_tree_twoway $treeH $treeM &&
+	git ls-files --stage >5.out &&
+	test_must_fail git diff --no-index M.out 5.out >5diff.out &&
+	compare_change 5diff.out expected &&
+	check_cache_at yomin dirty
+'
+
+test_expect_success '6 - local addition already has the same.' '
+	rm -f .git/index &&
+	read_tree_must_succeed $treeH &&
+	git checkout-index -u -f -q -a &&
+	git update-index --add frotz &&
+	read_tree_twoway $treeH $treeM &&
+	git ls-files --stage >6.out &&
+	test_cmp M.out 6.out &&
+	check_cache_at frotz clean
+'
+
+test_expect_success '7 - local addition already has the same.' '
+	rm -f .git/index &&
+	read_tree_must_succeed $treeH &&
+	git checkout-index -u -f -q -a &&
+	echo frotz >frotz &&
+	git update-index --add frotz &&
+	echo frotz frotz >frotz &&
+	read_tree_twoway $treeH $treeM &&
+	git ls-files --stage >7.out &&
+	test_cmp M.out 7.out &&
+	check_cache_at frotz dirty
+'
+
+test_expect_success '8 - conflicting addition.' '
+	rm -f .git/index &&
+	read_tree_must_succeed $treeH &&
+	git checkout-index -u -f -q -a &&
+	echo frotz frotz >frotz &&
+	git update-index --add frotz &&
+	if read_tree_twoway $treeH $treeM; then false; else :; fi
+'
+
+test_expect_success '9 - conflicting addition.' '
+	rm -f .git/index &&
+	read_tree_must_succeed $treeH &&
+	git checkout-index -u -f -q -a &&
+	echo frotz frotz >frotz &&
+	git update-index --add frotz &&
+	echo frotz >frotz &&
+	if read_tree_twoway $treeH $treeM; then false; else :; fi
+'
+
+test_expect_success '10 - path removed.' '
+	rm -f .git/index &&
+	read_tree_must_succeed $treeH &&
+	git checkout-index -u -f -q -a &&
+	echo rezrov >rezrov &&
+	git update-index --add rezrov &&
+	read_tree_twoway $treeH $treeM &&
+	git ls-files --stage >10.out &&
+	test_cmp M.out 10.out
+'
+
+test_expect_success '11 - dirty path removed.' '
+	rm -f .git/index &&
+	read_tree_must_succeed $treeH &&
+	git checkout-index -u -f -q -a &&
+	echo rezrov >rezrov &&
+	git update-index --add rezrov &&
+	echo rezrov rezrov >rezrov &&
+	if read_tree_twoway $treeH $treeM; then false; else :; fi
+'
+
+test_expect_success '12 - unmatching local changes being removed.' '
+	rm -f .git/index &&
+	read_tree_must_succeed $treeH &&
+	git checkout-index -u -f -q -a &&
+	echo rezrov rezrov >rezrov &&
+	git update-index --add rezrov &&
+	if read_tree_twoway $treeH $treeM; then false; else :; fi
+'
+
+test_expect_success '13 - unmatching local changes being removed.' '
+	rm -f .git/index &&
+	read_tree_must_succeed $treeH &&
+	git checkout-index -u -f -q -a &&
+	echo rezrov rezrov >rezrov &&
+	git update-index --add rezrov &&
+	echo rezrov >rezrov &&
+	if read_tree_twoway $treeH $treeM; then false; else :; fi
+'
 
 cat >expected <<EOF
 -100644 X 0	nitfol
 +100644 X 0	nitfol
 EOF
 
-test_expect_success \
-    '14 - unchanged in two heads.' \
-    'rm -f .git/index &&
-     read_tree_must_succeed $treeH &&
-     git checkout-index -u -f -q -a &&
-     echo nitfol nitfol >nitfol &&
-     git update-index --add nitfol &&
-     read_tree_twoway $treeH $treeM &&
-     git ls-files --stage >14.out &&
-     test_must_fail git diff --no-index M.out 14.out >14diff.out &&
-     compare_change 14diff.out expected &&
-     check_cache_at nitfol clean'
-
-test_expect_success \
-    '15 - unchanged in two heads.' \
-    'rm -f .git/index &&
-     read_tree_must_succeed $treeH &&
-     git checkout-index -u -f -q -a &&
-     echo nitfol nitfol >nitfol &&
-     git update-index --add nitfol &&
-     echo nitfol nitfol nitfol >nitfol &&
-     read_tree_twoway $treeH $treeM &&
-     git ls-files --stage >15.out &&
-     test_must_fail git diff --no-index M.out 15.out >15diff.out &&
-     compare_change 15diff.out expected &&
-     check_cache_at nitfol dirty'
-
-test_expect_success \
-    '16 - conflicting local change.' \
-    'rm -f .git/index &&
-     read_tree_must_succeed $treeH &&
-     git checkout-index -u -f -q -a &&
-     echo bozbar bozbar >bozbar &&
-     git update-index --add bozbar &&
-     if read_tree_twoway $treeH $treeM; then false; else :; fi'
-
-test_expect_success \
-    '17 - conflicting local change.' \
-    'rm -f .git/index &&
-     read_tree_must_succeed $treeH &&
-     git checkout-index -u -f -q -a &&
-     echo bozbar bozbar >bozbar &&
-     git update-index --add bozbar &&
-     echo bozbar bozbar bozbar >bozbar &&
-     if read_tree_twoway $treeH $treeM; then false; else :; fi'
-
-test_expect_success \
-    '18 - local change already having a good result.' \
-    'rm -f .git/index &&
-     read_tree_must_succeed $treeH &&
-     git checkout-index -u -f -q -a &&
-     cat bozbar-new >bozbar &&
-     git update-index --add bozbar &&
-     read_tree_twoway $treeH $treeM &&
-     git ls-files --stage >18.out &&
-     test_cmp M.out 18.out &&
-     check_cache_at bozbar clean'
-
-test_expect_success \
-    '19 - local change already having a good result, further modified.' \
-    'rm -f .git/index &&
-     read_tree_must_succeed $treeH &&
-     git checkout-index -u -f -q -a &&
-     cat bozbar-new >bozbar &&
-     git update-index --add bozbar &&
-     echo gnusto gnusto >bozbar &&
-     read_tree_twoway $treeH $treeM &&
-     git ls-files --stage >19.out &&
-     test_cmp M.out 19.out &&
-     check_cache_at bozbar dirty'
-
-test_expect_success \
-    '20 - no local change, use new tree.' \
-    'rm -f .git/index &&
-     read_tree_must_succeed $treeH &&
-     git checkout-index -u -f -q -a &&
-     cat bozbar-old >bozbar &&
-     git update-index --add bozbar &&
-     read_tree_twoway $treeH $treeM &&
-     git ls-files --stage >20.out &&
-     test_cmp M.out 20.out &&
-     check_cache_at bozbar dirty'
-
-test_expect_success \
-    '21 - no local change, dirty cache.' \
-    'rm -f .git/index &&
-     read_tree_must_succeed $treeH &&
-     git checkout-index -u -f -q -a &&
-     cat bozbar-old >bozbar &&
-     git update-index --add bozbar &&
-     echo gnusto gnusto >bozbar &&
-     if read_tree_twoway $treeH $treeM; then false; else :; fi'
+test_expect_success '14 - unchanged in two heads.' '
+	rm -f .git/index &&
+	read_tree_must_succeed $treeH &&
+	git checkout-index -u -f -q -a &&
+	echo nitfol nitfol >nitfol &&
+	git update-index --add nitfol &&
+	read_tree_twoway $treeH $treeM &&
+	git ls-files --stage >14.out &&
+	test_must_fail git diff --no-index M.out 14.out >14diff.out &&
+	compare_change 14diff.out expected &&
+	check_cache_at nitfol clean
+'
+
+test_expect_success '15 - unchanged in two heads.' '
+	rm -f .git/index &&
+	read_tree_must_succeed $treeH &&
+	git checkout-index -u -f -q -a &&
+	echo nitfol nitfol >nitfol &&
+	git update-index --add nitfol &&
+	echo nitfol nitfol nitfol >nitfol &&
+	read_tree_twoway $treeH $treeM &&
+	git ls-files --stage >15.out &&
+	test_must_fail git diff --no-index M.out 15.out >15diff.out &&
+	compare_change 15diff.out expected &&
+	check_cache_at nitfol dirty
+'
+
+test_expect_success '16 - conflicting local change.' '
+	rm -f .git/index &&
+	read_tree_must_succeed $treeH &&
+	git checkout-index -u -f -q -a &&
+	echo bozbar bozbar >bozbar &&
+	git update-index --add bozbar &&
+	if read_tree_twoway $treeH $treeM; then false; else :; fi
+'
+
+test_expect_success '17 - conflicting local change.' '
+	rm -f .git/index &&
+	read_tree_must_succeed $treeH &&
+	git checkout-index -u -f -q -a &&
+	echo bozbar bozbar >bozbar &&
+	git update-index --add bozbar &&
+	echo bozbar bozbar bozbar >bozbar &&
+	if read_tree_twoway $treeH $treeM; then false; else :; fi
+'
+
+test_expect_success '18 - local change already having a good result.' '
+	rm -f .git/index &&
+	read_tree_must_succeed $treeH &&
+	git checkout-index -u -f -q -a &&
+	cat bozbar-new >bozbar &&
+	git update-index --add bozbar &&
+	read_tree_twoway $treeH $treeM &&
+	git ls-files --stage >18.out &&
+	test_cmp M.out 18.out &&
+	check_cache_at bozbar clean
+'
+
+test_expect_success '19 - local change already having a good result, further modified.' '
+	rm -f .git/index &&
+	read_tree_must_succeed $treeH &&
+	git checkout-index -u -f -q -a &&
+	cat bozbar-new >bozbar &&
+	git update-index --add bozbar &&
+	echo gnusto gnusto >bozbar &&
+	read_tree_twoway $treeH $treeM &&
+	git ls-files --stage >19.out &&
+	test_cmp M.out 19.out &&
+	check_cache_at bozbar dirty
+'
+
+test_expect_success '20 - no local change, use new tree.' '
+	rm -f .git/index &&
+	read_tree_must_succeed $treeH &&
+	git checkout-index -u -f -q -a &&
+	cat bozbar-old >bozbar &&
+	git update-index --add bozbar &&
+	read_tree_twoway $treeH $treeM &&
+	git ls-files --stage >20.out &&
+	test_cmp M.out 20.out &&
+	check_cache_at bozbar dirty
+'
+
+test_expect_success '21 - no local change, dirty cache.' '
+	rm -f .git/index &&
+	read_tree_must_succeed $treeH &&
+	git checkout-index -u -f -q -a &&
+	cat bozbar-old >bozbar &&
+	git update-index --add bozbar &&
+	echo gnusto gnusto >bozbar &&
+	if read_tree_twoway $treeH $treeM; then false; else :; fi
+'
 
 # This fails with straight two-way fast-forward.
-test_expect_success \
-    '22 - local change cache updated.' \
-    'rm -f .git/index &&
-     read_tree_must_succeed $treeH &&
-     git checkout-index -u -f -q -a &&
-     sed -e "s/such as/SUCH AS/" bozbar-old >bozbar &&
-     git update-index --add bozbar &&
-     if read_tree_twoway $treeH $treeM; then false; else :; fi'
+test_expect_success '22 - local change cache updated.' '
+	rm -f .git/index &&
+	read_tree_must_succeed $treeH &&
+	git checkout-index -u -f -q -a &&
+	sed -e "s/such as/SUCH AS/" bozbar-old >bozbar &&
+	git update-index --add bozbar &&
+	if read_tree_twoway $treeH $treeM; then false; else :; fi
+'
 
 # Also make sure we did not break DF vs DF/DF case.
-test_expect_success \
-    'DF vs DF/DF case setup.' \
-    'rm -f .git/index &&
-     echo DF >DF &&
-     git update-index --add DF &&
-     treeDF=$(git write-tree) &&
-     echo treeDF $treeDF &&
-     git ls-tree $treeDF &&
-
-     rm -f DF &&
-     mkdir DF &&
-     echo DF/DF >DF/DF &&
-     git update-index --add --remove DF DF/DF &&
-     treeDFDF=$(git write-tree) &&
-     echo treeDFDF $treeDFDF &&
-     git ls-tree $treeDFDF &&
-     git ls-files --stage >DFDF.out'
-
-test_expect_success \
-    'DF vs DF/DF case test.' \
-    'rm -f .git/index &&
-     rm -fr DF &&
-     echo DF >DF &&
-     git update-index --add DF &&
-     read_tree_twoway $treeDF $treeDFDF &&
-     git ls-files --stage >DFDFcheck.out &&
-     test_cmp DFDF.out DFDFcheck.out &&
-     check_cache_at DF/DF dirty &&
-     :'
-
-test_expect_success \
-    'a/b (untracked) vs a case setup.' \
-    'rm -f .git/index &&
-     : >a &&
-     git update-index --add a &&
-     treeM=$(git write-tree) &&
-     echo treeM $treeM &&
-     git ls-tree $treeM &&
-     git ls-files --stage >treeM.out &&
-
-     rm -f a &&
-     git update-index --remove a &&
-     mkdir a &&
-     : >a/b &&
-     treeH=$(git write-tree) &&
-     echo treeH $treeH &&
-     git ls-tree $treeH'
-
-test_expect_success \
-    'a/b (untracked) vs a, plus c/d case test.' \
-    'read_tree_u_must_fail -u -m "$treeH" "$treeM" &&
-     git ls-files --stage &&
-     test -f a/b'
-
-test_expect_success \
-    'a/b vs a, plus c/d case setup.' \
-    'rm -f .git/index &&
-     rm -fr a &&
-     : >a &&
-     mkdir c &&
-     : >c/d &&
-     git update-index --add a c/d &&
-     treeM=$(git write-tree) &&
-     echo treeM $treeM &&
-     git ls-tree $treeM &&
-     git ls-files --stage >treeM.out &&
-
-     rm -f a &&
-     mkdir a &&
-     : >a/b &&
-     git update-index --add --remove a a/b &&
-     treeH=$(git write-tree) &&
-     echo treeH $treeH &&
-     git ls-tree $treeH'
-
-test_expect_success \
-    'a/b vs a, plus c/d case test.' \
-    'read_tree_u_must_succeed -u -m "$treeH" "$treeM" &&
-     git ls-files --stage | tee >treeMcheck.out &&
-     test_cmp treeM.out treeMcheck.out'
+test_expect_success 'DF vs DF/DF case setup.' '
+	rm -f .git/index &&
+	echo DF >DF &&
+	git update-index --add DF &&
+	treeDF=$(git write-tree) &&
+	echo treeDF $treeDF &&
+	git ls-tree $treeDF &&
+
+	rm -f DF &&
+	mkdir DF &&
+	echo DF/DF >DF/DF &&
+	git update-index --add --remove DF DF/DF &&
+	treeDFDF=$(git write-tree) &&
+	echo treeDFDF $treeDFDF &&
+	git ls-tree $treeDFDF &&
+	git ls-files --stage >DFDF.out
+'
+
+test_expect_success 'DF vs DF/DF case test.' '
+	rm -f .git/index &&
+	rm -fr DF &&
+	echo DF >DF &&
+	git update-index --add DF &&
+	read_tree_twoway $treeDF $treeDFDF &&
+	git ls-files --stage >DFDFcheck.out &&
+	test_cmp DFDF.out DFDFcheck.out &&
+	check_cache_at DF/DF dirty &&
+	:
+'
+
+test_expect_success 'a/b (untracked) vs a case setup.' '
+	rm -f .git/index &&
+	: >a &&
+	git update-index --add a &&
+	treeM=$(git write-tree) &&
+	echo treeM $treeM &&
+	git ls-tree $treeM &&
+	git ls-files --stage >treeM.out &&
+
+	rm -f a &&
+	git update-index --remove a &&
+	mkdir a &&
+	: >a/b &&
+	treeH=$(git write-tree) &&
+	echo treeH $treeH &&
+	git ls-tree $treeH
+'
+
+test_expect_success 'a/b (untracked) vs a, plus c/d case test.' '
+	read_tree_u_must_fail -u -m "$treeH" "$treeM" &&
+	git ls-files --stage &&
+	test -f a/b
+'
+
+test_expect_success 'a/b vs a, plus c/d case setup.' '
+	rm -f .git/index &&
+	rm -fr a &&
+	: >a &&
+	mkdir c &&
+	: >c/d &&
+	git update-index --add a c/d &&
+	treeM=$(git write-tree) &&
+	echo treeM $treeM &&
+	git ls-tree $treeM &&
+	git ls-files --stage >treeM.out &&
+
+	rm -f a &&
+	mkdir a &&
+	: >a/b &&
+	git update-index --add --remove a a/b &&
+	treeH=$(git write-tree) &&
+	echo treeH $treeH &&
+	git ls-tree $treeH
+'
+
+test_expect_success 'a/b vs a, plus c/d case test.' '
+	read_tree_u_must_succeed -u -m "$treeH" "$treeM" &&
+	git ls-files --stage | tee >treeMcheck.out &&
+	test_cmp treeM.out treeMcheck.out
+'
 
 test_expect_success '-m references the correct modified tree' '
 	echo >file-a &&
-- 
2.11.0.rc2.30.g7c4be45.dirty

