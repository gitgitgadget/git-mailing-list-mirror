Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.4 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 4180B1F403
	for <e@80x24.org>; Fri,  8 Jun 2018 22:42:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753284AbeFHWme (ORCPT <rfc822;e@80x24.org>);
        Fri, 8 Jun 2018 18:42:34 -0400
Received: from mail-wr0-f196.google.com ([209.85.128.196]:40346 "EHLO
        mail-wr0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752889AbeFHWmH (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 8 Jun 2018 18:42:07 -0400
Received: by mail-wr0-f196.google.com with SMTP id l41-v6so14772850wre.7
        for <git@vger.kernel.org>; Fri, 08 Jun 2018 15:42:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=B8uSGz0XLDFJtmnDyyvUsG6Ctz1tf17TsdY0ALBsYnE=;
        b=ERXPmOHMJdcmwCPg3ElgGrNqnLlzm1ptZhk26D7UgIeo5fupeXAS4UNEk2ALMOgP5N
         wVjaLMT6W6vL2hrRcDtWFOXH4S02W7xfaaxN7EU/rWQf46c3WC1YV4H6URMo3ZiNya8I
         irJxwmidHGGR1H1wIWehzfP7tJzUSAVQ76cb1/lyZLj5NZoRSYdjC9GCLN3+if+UE/qe
         rsw7GJXpVDClc7QPDum40cT0H+3wiptED7Q0JpSRbIUrwaytT97Ic/jTfUr/m8upJu/Y
         d8AntLZA+JMxpfnx3gzzvSGq754r+IQR4nksh/DRXXfHUqrXqX3CpZMyG+7M5J6qx1PN
         6Rmg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=B8uSGz0XLDFJtmnDyyvUsG6Ctz1tf17TsdY0ALBsYnE=;
        b=d61J7ki1wjlT/f0mlEPb/6pvE3i90jdr0we9MLEE+201g4uTK1yQBvQSRU1EBoNCIG
         RibyNWt8nj9mRnJY6nDzhl3zxVmY74OAvounvj0LG5QKNSKom8bo6ojo3wjogcM/OA9l
         twsjv8TAAua2Wrq3RyAHDiPO5cca6pAPSL4LOLyBWdQBhUgTxbMBKhjKq4aa6kz+5+V0
         JJat1gCNQrA48Py+O3rr5qx+lhV8gHwtvEq0hnlejgH5LG7uQMrP9KRqrQrZGiHT79To
         QOn3Wq6MVSXvvOon1PQnZe/0pnDUTFsfeFZb75a0Xqufxpt4zrxbJai+XONQyNjrvMRG
         r5OQ==
X-Gm-Message-State: APt69E3zMPRv3XqfiMg0bWYvJqxeNPrWLT+upY6/5XJu8lb0sIYckTi5
        i4bnTWqTBxAJw4+EaydPaItkes7f
X-Google-Smtp-Source: ADUXVKLjmRiIiPHzIv6WlHKIoC28LN25mbjguGM/k+sl5DS47yA9bEBWUmYLtsTfisBx1pwckvTAdw==
X-Received: by 2002:a5d:478d:: with SMTP id w13-v6mr481945wrq.188.1528497725511;
        Fri, 08 Jun 2018 15:42:05 -0700 (PDT)
Received: from u.nix.is ([2a01:4f8:190:5095::2])
        by smtp.gmail.com with ESMTPSA id w15-v6sm36350010wro.52.2018.06.08.15.42.04
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 08 Jun 2018 15:42:04 -0700 (PDT)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>, dstolee@microsoft.com,
        git@jeffhostetler.com, peff@peff.net, johannes.schindelin@gmx.de,
        jrnieder@gmail.com, Linus Torvalds <torvalds@linux-foundation.org>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH 12/20] abbrev tests: test for --abbrev and core.abbrev=[+-]N
Date:   Fri,  8 Jun 2018 22:41:28 +0000
Message-Id: <20180608224136.20220-13-avarab@gmail.com>
X-Mailer: git-send-email 2.17.0.290.gded63e768a
In-Reply-To: <20180608224136.20220-1-avarab@gmail.com>
References: <20180608224136.20220-1-avarab@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

In a later change I mean to make values like -1 and +1 mean something
different, but right now they're implicitly parsed. Let's test for the
current behavior before changing it.

Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
---
 t/t0014-abbrev.sh | 131 ++++++++++++++++++++++++++++++++++++++++++++--
 1 file changed, 128 insertions(+), 3 deletions(-)

diff --git a/t/t0014-abbrev.sh b/t/t0014-abbrev.sh
index 5a99cbe434..6dee92f35e 100755
--- a/t/t0014-abbrev.sh
+++ b/t/t0014-abbrev.sh
@@ -74,7 +74,7 @@ test_expect_success 'abbrev non-integer value handling differs ' '
 	! test -s stderr
 '
 
-for i in -41 -20 -10 -1 0 1 2 3 41
+for i in -41 -20 -10 -1 -0 +0 0 1 2 3 41
 do
 	test_expect_success "core.abbrev value $i out of range errors out" "
 		test_must_fail git -c core.abbrev=$i log -1 --pretty=format:%h 2>stderr &&
@@ -90,7 +90,7 @@ do
 	"
 done
 
-for i in 0 1 2 3 4
+for i in 0 1 2 3 4 -0 +0 +1 +2 +3 +4
 do
 	test_expect_success "non-negative --abbrev=$i value <MINIMUM_ABBREV falls back on MINIMUM_ABBREV" "
 		git log --abbrev=$i -1 --pretty=format:%h >log &&
@@ -98,7 +98,7 @@ do
 	"
 done
 
-for i in 41 9001
+for i in 41 9001 +41 +9001
 do
 	test_expect_success "non-negative --abbrev=$i value >MINIMUM_ABBREV falls back on 40" "
 		git log --abbrev=$i -1 --pretty=format:%h >log &&
@@ -116,6 +116,10 @@ do
 		git log --abbrev=$i -1 --pretty=format:%h >log &&
 		test_byte_count = $i log &&
 
+		# core.abbrev=+N is the same as core.abbrev=N
+		git -c core.abbrev=+$i log -1 --pretty=format:%h >log &&
+		test_byte_count = $i log &&
+
 		# The --abbrev option should take priority over
 		# core.abbrev
 		git -c core.abbrev=20 log --abbrev=$i -1 --pretty=format:%h >log &&
@@ -172,16 +176,39 @@ do
 	"
 done
 
+test_expect_success 'blame core.abbrev=[-+]1 and --abbrev=[-+]1' '
+	test_must_fail git -c core.abbrev=+1 blame A.t | cut_tr_d_n_field_n 1 >blame &&
+	test_must_fail git -c core.abbrev=-1 blame A.t | cut_tr_d_n_field_n 1 >blame &&
+
+	git blame --abbrev=-1 A.t | cut_tr_d_n_field_n 1 >blame &&
+	test_byte_count = 5 blame &&
+
+	git blame --abbrev=+1 A.t | cut_tr_d_n_field_n 1 >blame &&
+	test_byte_count = 5 blame
+'
+
 for i in $(test_seq 4 40)
 do
 	test_expect_success "branch core.abbrev=$i and --abbrev=$i" "
 		git -c core.abbrev=$i branch -v | cut_tr_d_n_field_n 3 >branch &&
 		test_byte_count = $i branch &&
+
 		git branch --abbrev=$i -v | cut_tr_d_n_field_n 3 >branch &&
 		test_byte_count = $i branch
 	"
 done
 
+test_expect_success 'branch core.abbrev=[-+]1 and --abbrev=[-+]1' '
+	test_must_fail git -c core.abbrev=+1 branch -v | cut_tr_d_n_field_n 3 >branch &&
+	test_must_fail git -c core.abbrev=-1 branch -v | cut_tr_d_n_field_n 3 >branch &&
+
+	git branch --abbrev=-1 -v | cut_tr_d_n_field_n 3 >branch &&
+	test_byte_count = 4 branch &&
+
+	git branch --abbrev=+1 -v | cut_tr_d_n_field_n 3 >branch &&
+	test_byte_count = 4 branch
+'
+
 test_expect_success 'describe core.abbrev and --abbrev special cases' '
 	# core.abbrev=0 behaves as usual...
 	test_must_fail git -c core.abbrev=0 describe &&
@@ -203,6 +230,17 @@ do
 	"
 done
 
+test_expect_success 'describe core.abbrev=[-+]1 and --abbrev=[-+]1' '
+	test_must_fail git -c core.abbrev=+1 describe | sed_g_tr_d_n >describe &&
+	test_must_fail git -c core.abbrev=-1 describe | sed_g_tr_d_n >describe &&
+
+	git describe --abbrev=-1 | sed_g_tr_d_n >describe &&
+	test_byte_count = 4 describe &&
+
+	git describe --abbrev=+1 | sed_g_tr_d_n >describe &&
+	test_byte_count = 4 describe
+'
+
 for i in $(test_seq 4 40)
 do
 	test_expect_success "log core.abbrev=$i and --abbrev=$i" "
@@ -213,6 +251,20 @@ do
 	"
 done
 
+test_expect_success 'log core.abbrev=[-+]1 and --abbrev=[-+]1' '
+	test_must_fail git -c core.abbrev=+1 log --pretty=format:%h -1 2>stderr &&
+	test_i18ngrep "abbrev length out of range" stderr &&
+
+	test_must_fail git -c core.abbrev=-1 log --pretty=format:%h -1 2>stderr &&
+	test_i18ngrep "abbrev length out of range" stderr &&
+
+	git log --abbrev=+1 --pretty=format:%h -1 | tr_d_n >log &&
+	test_byte_count = 4 log &&
+
+	git log --abbrev=-1 --pretty=format:%h -1 | tr_d_n >log &&
+	test_byte_count = 40 log
+'
+
 for i in $(test_seq 4 40)
 do
 	test_expect_success "diff --no-index --raw core.abbrev=$i and --abbrev=$i" "
@@ -244,6 +296,46 @@ do
 	"
 done
 
+test_expect_success 'diff --no-index --raw core.abbrev=[-+]1 and --abbrev=[-+]1' '
+	test_must_fail git -c core.abbrev=+1 diff --no-index --raw X Y 2>stderr &&
+	test_i18ngrep "abbrev length out of range" stderr &&
+
+	test_must_fail git -c core.abbrev=-1 diff --no-index --raw X Y 2>stderr &&
+	test_i18ngrep "abbrev length out of range" stderr &&
+
+	test_must_fail git diff --no-index --raw --abbrev=+1 X Y >diff &&
+	cut_tr_d_n_field_n 3 <diff >diff.3 &&
+	test_byte_count = 4 diff.3 &&
+	cut_tr_d_n_field_n 4 <diff >diff.4 &&
+	test_byte_count = 4 diff.4 &&
+
+	test_must_fail git diff --no-index --raw --abbrev=-1 X Y >diff &&
+	cut_tr_d_n_field_n 3 <diff >diff.3 &&
+	test_byte_count = 4 diff.3 &&
+	cut_tr_d_n_field_n 4 <diff >diff.4 &&
+	test_byte_count = 4 diff.4
+'
+
+test_expect_success 'diff --raw core.abbrev=[-+]1 and --abbrev=[-+]1' '
+	test_must_fail git -c core.abbrev=+1 diff HEAD~ 2>stderr &&
+	test_i18ngrep "abbrev length out of range" stderr &&
+
+	test_must_fail git -c core.abbrev=-1 diff HEAD~ 2>stderr &&
+	test_i18ngrep "abbrev length out of range" stderr &&
+
+	git diff --raw --abbrev=+1 HEAD~ >diff &&
+	cut_tr_d_n_field_n 3 <diff >diff.3 &&
+	test_byte_count = 4 diff.3 &&
+	cut_tr_d_n_field_n 4 <diff >diff.4 &&
+	test_byte_count = 4 diff.4 &&
+
+	git diff --raw --abbrev=-1 HEAD~ >diff &&
+	cut_tr_d_n_field_n 3 <diff >diff.3 &&
+	test_byte_count = 40 diff.3 &&
+	cut_tr_d_n_field_n 4 <diff >diff.4 &&
+	test_byte_count = 40 diff.4
+'
+
 for i in $(test_seq 4 40)
 do
 	test_expect_success "ls-files core.abbrev=$i and --abbrev=$i" "
@@ -254,6 +346,17 @@ do
 	"
 done
 
+test_expect_success 'ls-files core.abbrev=[-+]1 and --abbrev=[-+]1' '
+	test_must_fail git -c core.abbrev=+1 ls-files --stage A.t | cut_tr_d_n_field_n 2 >ls-files &&
+	test_must_fail git -c core.abbrev=-1 ls-files --stage A.t | cut_tr_d_n_field_n 2 >ls-files &&
+
+	git ls-files --abbrev=-1 --stage A.t | cut_tr_d_n_field_n 2 >ls-files &&
+	test_byte_count = 4 ls-files &&
+
+	git ls-files --abbrev=+1 --stage A.t | cut_tr_d_n_field_n 2 >ls-files &&
+	test_byte_count = 4 ls-files
+'
+
 for i in $(test_seq 4 40)
 do
 	test_expect_success "ls-tree core.abbrev=$i and --abbrev=$i" "
@@ -264,6 +367,17 @@ do
 	"
 done
 
+test_expect_success 'ls-tree core.abbrev=[-+]1 and --abbrev=[-+]1' '
+	test_must_fail git -c core.abbrev=+1 ls-tree HEAD A.t | cut -f 1 | cut_tr_d_n_field_n 3 >ls-tree &&
+	test_must_fail git -c core.abbrev=-1 ls-tree HEAD A.t | cut -f 1 | cut_tr_d_n_field_n 3 >ls-tree &&
+
+	git ls-tree --abbrev=-1 HEAD A.t | cut -f 1 | cut_tr_d_n_field_n 3 >ls-tree &&
+	test_byte_count = 4 ls-tree &&
+
+	git ls-tree --abbrev=+1 HEAD A.t | cut -f 1 | cut_tr_d_n_field_n 3 >ls-tree &&
+	test_byte_count = 4 ls-tree
+'
+
 for i in $(test_seq 4 40)
 do
 	test_expect_success "show-ref core.abbrev=$i and --abbrev=$i" "
@@ -276,4 +390,15 @@ do
 	"
 done
 
+test_expect_success 'show-ref core.abbrev=[-+]1 and --abbrev=[-+]1' '
+	test_must_fail git -c core.abbrev=+1 show-ref --hash refs/heads/master | tr_d_n >show-ref &&
+	test_must_fail git -c core.abbrev=-1 show-ref --hash refs/heads/master | tr_d_n >show-ref &&
+
+	git show-ref --abbrev=-1 --hash refs/heads/master | tr_d_n >show-ref &&
+	test_byte_count = 4 show-ref &&
+
+	git show-ref --abbrev=+1 --hash refs/heads/master | tr_d_n >show-ref &&
+	test_byte_count = 4 show-ref
+'
+
 test_done
-- 
2.17.0.290.gded63e768a

