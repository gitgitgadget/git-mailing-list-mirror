Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B3613C433EF
	for <git@archiver.kernel.org>; Thu, 30 Sep 2021 14:51:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 98DB961A56
	for <git@archiver.kernel.org>; Thu, 30 Sep 2021 14:51:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1351938AbhI3Owt (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 30 Sep 2021 10:52:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41132 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1351923AbhI3Owt (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 30 Sep 2021 10:52:49 -0400
Received: from mail-wr1-x429.google.com (mail-wr1-x429.google.com [IPv6:2a00:1450:4864:20::429])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 20C87C06176A
        for <git@vger.kernel.org>; Thu, 30 Sep 2021 07:51:06 -0700 (PDT)
Received: by mail-wr1-x429.google.com with SMTP id d21so10497486wra.12
        for <git@vger.kernel.org>; Thu, 30 Sep 2021 07:51:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=pq38z/Ts2Q1i/3RuHIH4JqscSdd1ZyLNOkr2P0NxmCM=;
        b=X7lPXlRuqHhzinvfx4sdNwU5PLtVEB6GPBFPNcviY/sIZTVMGtVMiubqr+XL1UV+95
         wAyMmCTPPB8CG7Vp7c1okS7lNNmY40tASyHllkutoN4ZT66cUTrJcHRuc/e5OT9aYOja
         MHYS5urn6Faeggd8ISGD0gCN/sU+nAstUzcbJS7HDvDOTGILQf5aTkoif8yI7pYXcQfd
         VCSuA+yqUp47odsFjiahepQo4VLxtMNT+9MGbA3aW1qNkX7rNAu5EHoA9kluRdA924De
         CBkb6pAZHqda7AIKvqvnLMHwZ40iymRXkTW70MuaiUFpa5WMAxhWCjG1BwLAhe6dtsYj
         j3Pw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=pq38z/Ts2Q1i/3RuHIH4JqscSdd1ZyLNOkr2P0NxmCM=;
        b=dT2DeTVk1B0J8AUNuP+2EHXqe2UEsVnL23SQdKw7rmDo6XJQkIVmShL4N3YzzccpDb
         cNDm9SyNLkWkllVcT5BOKxP4iJdLp0fTzf4yB/niJs8XgWa2FrDVf6+IibLWZE5psZVJ
         h5wmCA0X8YxnLMdm/H4ObCeDS1p6W7JEpyBzKDiqI8U82fc8zKfJjQ+2tVBxUKDFrT/s
         hhlDhVlDvSRWAxK5thMRiHTZVHWMNnBSY9Vm2TOMJRjfihra7kqbVcdiJBF8jJ4fkmWY
         2zQAcy7Dk13z5vczIE5COWD3hdpWYefAxiP3IHTpP+R4SG+kxBH2OB+XvBJgABPU/Q45
         z7uw==
X-Gm-Message-State: AOAM530wVhjlskBexak8Gpmke+BwGpkbxTTx0Std2GY8omUx6sat8vD8
        MjGliPFn0bf8xR9mi22JjydL8cQuozM=
X-Google-Smtp-Source: ABdhPJyEQ56Y5YTS4D8f0xyqajlne6iVj2LQxaII9DPB21Rjo84MaHFiwLt0KN3y3w+IlUs1C/gv3Q==
X-Received: by 2002:a5d:50cf:: with SMTP id f15mr6913238wrt.237.1633013464771;
        Thu, 30 Sep 2021 07:51:04 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id x17sm3225346wrc.51.2021.09.30.07.51.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 30 Sep 2021 07:51:04 -0700 (PDT)
Message-Id: <d033c5e365fec8e3e0c5c67c2fadbc87e15dd16c.1633013461.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1048.git.1633013461.gitgitgadget@gmail.com>
References: <pull.1048.git.1633013461.gitgitgadget@gmail.com>
From:   "Victoria Dye via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Thu, 30 Sep 2021 14:50:57 +0000
Subject: [PATCH 3/7] reset: expand test coverage for sparse checkouts
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     stolee@gmail.com, gitster@pobox.com, newren@gmail.com,
        Victoria Dye <vdye@github.com>, Victoria Dye <vdye@github.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Victoria Dye <vdye@github.com>

Add new tests for `--merge` and `--keep` modes, as well as mixed reset with
pathspecs both inside and outside of the sparse checkout definition. New
performance test cases exercise various execution paths for `reset`.

Co-authored-by: Derrick Stolee <dstolee@microsoft.com>
Signed-off-by: Derrick Stolee <dstolee@microsoft.com>
Signed-off-by: Victoria Dye <vdye@github.com>
---
 t/perf/p2000-sparse-operations.sh        |   3 +
 t/t1092-sparse-checkout-compatibility.sh | 107 +++++++++++++++++++++++
 2 files changed, 110 insertions(+)

diff --git a/t/perf/p2000-sparse-operations.sh b/t/perf/p2000-sparse-operations.sh
index 597626276fb..bfd332120c8 100755
--- a/t/perf/p2000-sparse-operations.sh
+++ b/t/perf/p2000-sparse-operations.sh
@@ -110,5 +110,8 @@ test_perf_on_all git add -A
 test_perf_on_all git add .
 test_perf_on_all git commit -a -m A
 test_perf_on_all git checkout -f -
+test_perf_on_all git reset
+test_perf_on_all git reset --hard
+test_perf_on_all git reset -- does-not-exist
 
 test_done
diff --git a/t/t1092-sparse-checkout-compatibility.sh b/t/t1092-sparse-checkout-compatibility.sh
index aed8683e629..e36fb18098d 100755
--- a/t/t1092-sparse-checkout-compatibility.sh
+++ b/t/t1092-sparse-checkout-compatibility.sh
@@ -479,6 +479,113 @@ test_expect_success 'checkout and reset (mixed) [sparse]' '
 	test_sparse_match git reset update-folder2
 '
 
+# NEEDSWORK: with mixed reset, files with differences between HEAD and <commit>
+# will be added to the work tree even if outside the sparse checkout
+# definition, and even if the file is modified to a state of having no local
+# changes. The file is "re-ignored" if a hard reset is executed. We may want to
+# change this behavior in the future and enforce that files are not written
+# outside of the sparse checkout definition.
+test_expect_success 'checkout and mixed reset file tracking [sparse]' '
+	init_repos &&
+
+	test_all_match git checkout -b reset-test update-deep &&
+	test_all_match git reset update-folder1 &&
+	test_all_match git reset update-deep &&
+
+	# At this point, there are no changes in the working tree. However,
+	# folder1/a now exists locally (even though it is outside of the sparse
+	# paths).
+	run_on_sparse test_path_exists folder1 &&
+
+	run_on_all rm folder1/a &&
+	test_all_match git status --porcelain=v2 &&
+
+	test_all_match git reset --hard update-deep &&
+	run_on_sparse test_path_is_missing folder1 &&
+	test_path_exists full-checkout/folder1
+'
+
+test_expect_success 'checkout and reset (merge)' '
+	init_repos &&
+
+	write_script edit-contents <<-\EOF &&
+	echo text >>$1
+	EOF
+
+	test_all_match git checkout -b reset-test update-deep &&
+	run_on_all ../edit-contents a &&
+	test_all_match git reset --merge deepest &&
+	test_all_match git status --porcelain=v2 &&
+
+	test_all_match git reset --hard update-deep &&
+	run_on_all ../edit-contents deep/a &&
+	test_all_match test_must_fail git reset --merge deepest
+'
+
+test_expect_success 'checkout and reset (keep)' '
+	init_repos &&
+
+	write_script edit-contents <<-\EOF &&
+	echo text >>$1
+	EOF
+
+	test_all_match git checkout -b reset-test update-deep &&
+	run_on_all ../edit-contents a &&
+	test_all_match git reset --keep deepest &&
+	test_all_match git status --porcelain=v2 &&
+
+	test_all_match git reset --hard update-deep &&
+	run_on_all ../edit-contents deep/a &&
+	test_all_match test_must_fail git reset --keep deepest
+'
+
+test_expect_success 'reset with pathspecs inside sparse definition' '
+	init_repos &&
+
+	write_script edit-contents <<-\EOF &&
+	echo text >>$1
+	EOF
+
+	test_all_match git checkout -b reset-test update-deep &&
+	run_on_all ../edit-contents deep/a &&
+
+	test_all_match git reset base -- deep/a &&
+	test_all_match git status --porcelain=v2 &&
+
+	test_all_match git reset base -- nonexistent-file &&
+	test_all_match git status --porcelain=v2 &&
+
+	test_all_match git reset deepest -- deep &&
+	test_all_match git status --porcelain=v2
+'
+
+test_expect_success 'reset with sparse directory pathspec outside definition' '
+	init_repos &&
+
+	test_all_match git checkout -b reset-test update-deep &&
+	test_all_match git reset --hard update-folder1 &&
+	test_all_match git reset base -- folder1 &&
+	test_all_match git status --porcelain=v2
+'
+
+test_expect_success 'reset with pathspec match in sparse directory' '
+	init_repos &&
+
+	test_all_match git checkout -b reset-test update-deep &&
+	test_all_match git reset --hard update-folder1 &&
+	test_all_match git reset base -- folder1/a &&
+	test_all_match git status --porcelain=v2
+'
+
+test_expect_success 'reset with wildcard pathspec' '
+	init_repos &&
+
+	test_all_match git checkout -b reset-test update-deep &&
+	test_all_match git reset --hard update-folder1 &&
+	test_all_match git reset base -- \*/a &&
+	test_all_match git status --porcelain=v2
+'
+
 test_expect_success 'merge, cherry-pick, and rebase' '
 	init_repos &&
 
-- 
gitgitgadget

