Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D62C9C433FE
	for <git@archiver.kernel.org>; Tue, 10 May 2022 23:32:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237926AbiEJXcp (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 10 May 2022 19:32:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44984 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233422AbiEJXcj (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 10 May 2022 19:32:39 -0400
Received: from mail-wm1-x336.google.com (mail-wm1-x336.google.com [IPv6:2a00:1450:4864:20::336])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 24EDA1D5008
        for <git@vger.kernel.org>; Tue, 10 May 2022 16:32:38 -0700 (PDT)
Received: by mail-wm1-x336.google.com with SMTP id k126-20020a1ca184000000b003943fd07180so269751wme.3
        for <git@vger.kernel.org>; Tue, 10 May 2022 16:32:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=igvrIJQoQ0c+Op40m9NQxfZ07jOrWXFTaW9zMmhrCSA=;
        b=Gwmtk5Tphfb7m1ycXD9+oXLUHrdNsRhsBTECrIVF5RTLbMfj+E0j0fcavVhRl7bAH+
         99TrOfVFrCTPm/S4aFcFGznbQe18piYnqg+YTAynxERPZjLUVHqfBOF6PynSGvPL0+CD
         02fYC8J/BMIAy4CXFhcks2MRldogonW5syyBNbJKemT82zswqqjldrmh9KoqI7nAUjQA
         G4CaxqMGsJRLxYQN5dLVKJ1Ai1tWLB45uHCWI+AJpaZjmg7FTfo4Oh9xvxu/O4aIs+Tu
         InJUtbBEXjYRU4tPEus0Hz2N57h3IrpKKXtjw/OAXJOnAfuionXOl/pGDdn6HUva2CkP
         eDrQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=igvrIJQoQ0c+Op40m9NQxfZ07jOrWXFTaW9zMmhrCSA=;
        b=Wm/vTl2TmYagze7oNNeE10QpJs4+detpEIROSMR+lgGvPZ+kgCjl0zBwANa/r7txGE
         ytciZ4WqGbS8KSV2Ja8ZUJDrvi9R0gE2JNbfh2+fH4MClSMOP2FOsKx1vLY7kSfMNlrz
         B8CuVf4w5JGt0PG/dYxUyNcUU5kgVip0c3uEaOT/hMgrsi/ed3Ps/s9M5rGkOjQGtYSc
         /bsRL5aRNzF/u4Nb29nL5Dx+JXw+Ke4uCuRxAT7MICu2ir/BABLo85XHxfq9oeUu4day
         CV8m+fs7aYrD7/ft+Rhs3009gO1uMrrJbWIMpB1nfc/f/lufXqLhM5/HVCSyIrl2N2wU
         NrgA==
X-Gm-Message-State: AOAM530DFNc2yR02cDQS7Blox0BzLwei9ROIbN3ZHv0VkLr1k5zdmrnH
        O7TZRUd+nv677LlmqSmnthLKtcjWhMw=
X-Google-Smtp-Source: ABdhPJyQgaeCl6A8PtAbv4ZVpTN2Fbkr41a76uzSkOwuS8HO6OW7g71vMyRv9d0hvjqRdfSOjMiH+w==
X-Received: by 2002:a05:600c:5008:b0:394:533c:54a1 with SMTP id n8-20020a05600c500800b00394533c54a1mr2098413wmr.15.1652225556349;
        Tue, 10 May 2022 16:32:36 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id j18-20020a05600c1c1200b003947e11c3ecsm506409wms.17.2022.05.10.16.32.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 10 May 2022 16:32:35 -0700 (PDT)
Message-Id: <4e0a09f7a3ce55ea5478a3539c0c0e80188bf533.1652225552.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1171.v3.git.1652225552.gitgitgadget@gmail.com>
References: <pull.1171.v2.git.1651083378.gitgitgadget@gmail.com>
        <pull.1171.v3.git.1652225552.gitgitgadget@gmail.com>
From:   "Victoria Dye via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Tue, 10 May 2022 23:32:27 +0000
Subject: [PATCH v3 1/6] stash: expand sparse-checkout compatibility testing
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     derrickstolee@github.com, newren@gmail.com, gitster@pobox.com,
        Victoria Dye <vdye@github.com>, Victoria Dye <vdye@github.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Victoria Dye <vdye@github.com>

Add tests verifying expected 'git stash' behavior in
't1092-sparse-checkout-compatibility'. These cases establish the expected
behavior of 'git stash' in a sparse-checkout and verify consistency both
with and without a sparse index. Although no sparse index compatibility has
been integrated into 'git stash' yet, the tests are all 'expect_success' -
we don't want the cone-mode sparse-checkout behavior to change depending on
whether it is using a sparse index or not. Therefore, we expect these tests
to continue passing once sparse index is integrated with 'git stash'.

Additionally, add performance test cases for 'git stash' both with and
without untracked files. Note that, unlike the other tests in
'p2000-sparse-operations.sh', the tests added for 'stash' are combination
operations. This is done to ensure the stash/unstash is not blocked by the
modification of '$SPARSE_CONE/a' performed as part of 'test_perf_on_all'.

Signed-off-by: Victoria Dye <vdye@github.com>
---
 t/perf/p2000-sparse-operations.sh        |  2 +
 t/t1092-sparse-checkout-compatibility.sh | 49 ++++++++++++++++++++++++
 2 files changed, 51 insertions(+)

diff --git a/t/perf/p2000-sparse-operations.sh b/t/perf/p2000-sparse-operations.sh
index 382716cfca9..76710cbef35 100755
--- a/t/perf/p2000-sparse-operations.sh
+++ b/t/perf/p2000-sparse-operations.sh
@@ -106,6 +106,8 @@ test_perf_on_all () {
 }
 
 test_perf_on_all git status
+test_perf_on_all 'git stash && git stash pop'
+test_perf_on_all 'echo >>new && git stash -u && git stash pop'
 test_perf_on_all git add -A
 test_perf_on_all git add .
 test_perf_on_all git commit -a -m A
diff --git a/t/t1092-sparse-checkout-compatibility.sh b/t/t1092-sparse-checkout-compatibility.sh
index 236ab530284..86312b30444 100755
--- a/t/t1092-sparse-checkout-compatibility.sh
+++ b/t/t1092-sparse-checkout-compatibility.sh
@@ -1034,6 +1034,55 @@ test_expect_success 'cherry-pick with conflicts' '
 	test_all_match test_must_fail git cherry-pick to-cherry-pick
 '
 
+test_expect_success 'stash' '
+	init_repos &&
+
+	write_script edit-contents <<-\EOF &&
+	echo text >>$1
+	EOF
+
+	# Stash a sparse directory (folder1)
+	test_all_match git checkout -b test-branch rename-base &&
+	test_all_match git reset --soft rename-out-to-out &&
+	test_all_match git stash &&
+	test_all_match git status --porcelain=v2 &&
+
+	# Apply the sparse directory stash without reinstating the index
+	test_all_match git stash apply -q &&
+	test_all_match git status --porcelain=v2 &&
+
+	# Reset to state where stash can be applied
+	test_sparse_match git sparse-checkout reapply &&
+	test_all_match git reset --hard rename-out-to-out &&
+
+	# Apply the sparse directory stash *with* reinstating the index
+	test_all_match git stash apply --index -q &&
+	test_all_match git status --porcelain=v2 &&
+
+	# Reset to state where we will get a conflict applying the stash
+	test_sparse_match git sparse-checkout reapply &&
+	test_all_match git reset --hard update-folder1 &&
+
+	# Apply the sparse directory stash with conflicts
+	test_all_match test_must_fail git stash apply --index -q &&
+	test_all_match test_must_fail git stash apply -q &&
+	test_all_match git status --porcelain=v2 &&
+
+	# Reset to base branch
+	test_sparse_match git sparse-checkout reapply &&
+	test_all_match git reset --hard base &&
+
+	# Stash & unstash an untracked file outside of the sparse checkout
+	# definition.
+	run_on_sparse mkdir -p folder1 &&
+	run_on_all ../edit-contents folder1/new &&
+	test_all_match git stash -u &&
+	test_all_match git status --porcelain=v2 &&
+
+	test_all_match git stash pop -q &&
+	test_all_match git status --porcelain=v2
+'
+
 test_expect_success 'checkout-index inside sparse definition' '
 	init_repos &&
 
-- 
gitgitgadget

