Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 91BD3C433EF
	for <git@archiver.kernel.org>; Mon, 11 Oct 2021 20:30:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7894C60F14
	for <git@archiver.kernel.org>; Mon, 11 Oct 2021 20:30:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229632AbhJKUcb (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 11 Oct 2021 16:32:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42792 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234963AbhJKUc2 (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 11 Oct 2021 16:32:28 -0400
Received: from mail-wr1-x430.google.com (mail-wr1-x430.google.com [IPv6:2a00:1450:4864:20::430])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DD087C061745
        for <git@vger.kernel.org>; Mon, 11 Oct 2021 13:30:27 -0700 (PDT)
Received: by mail-wr1-x430.google.com with SMTP id o20so59695370wro.3
        for <git@vger.kernel.org>; Mon, 11 Oct 2021 13:30:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=jlukojs1Ds21JUu9v6m+mSRfHzD2bmC8njuDTMJkZac=;
        b=ZGNlbMV0zw2dT+xPJifO1nxvJB0R84DeIgyatWCepbCPzXLys3XNMIiqqTXHppXmdn
         2vId31pfm4VjD5cSUfXKptj0zswAR8uCoO0/kukEyMD06tysgyCevvp/TSTafYdkIxjo
         slYqECZDNepDoy26PuPdc0oKJpTf/+eEHX4TlT5JSsOYz1JYGwinFE/ZtmlgZE+bd1jB
         1J4aW3DuNeNXOlLP7/MAk5umUGlxpmqADaAndjqIPX+aYw4yC878mtqz9tEa9wbc8bfN
         y2ISKvleq1F9PVZmLYITfftbMRAjaG/0cqu+YZyroWXj+t4sYHQBzcTEakjMPQRhWzMh
         BOCw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=jlukojs1Ds21JUu9v6m+mSRfHzD2bmC8njuDTMJkZac=;
        b=ko9uV5a61A+c2ZHf7TiYWwvvRkTiSD/iIKnalDn/5WjxETavmcqkKy+d9dtCTG/kJj
         3RRFysQbVydLjqFDDsI/jdZ3LDfdHb/wdOfVIbprXfQnn2lI1sb/qyAHKTyoKSgAgGKA
         VwJ2P3oMt30yQkEPYGb0BEIhG63n97RsvF+njFyyd5N4zrG2bxEtVJgxL8mmVWAzoHvM
         MiwllpiQ+4A2x1GMnFmrlvCXdHomiFKXE48Qs4iMSUf7aR5B7NxMaRjOmqj0lxpez0LJ
         Dh56K2399NPEgSWVT/1eODZ9ptypaQr6nS/Dqv9GujogxH3iC312PPe6ehqcb2T8cqJl
         ZRbA==
X-Gm-Message-State: AOAM533nnM03fVQ2nC1S5wVCxwGJ+NUVGTDpwgUszrurQ3C24slYSZav
        lNCaI6c/NZgMB/vWUGjOxNqyJCswb04=
X-Google-Smtp-Source: ABdhPJxwpo4+WqaB4apgawi8RTFQ+TTQc4Z4HI+vCV90/YwIvkXCqvKQzyjMXckh1LQSqlI33kc9Zw==
X-Received: by 2002:a5d:4f8d:: with SMTP id d13mr26278077wru.239.1633984226525;
        Mon, 11 Oct 2021 13:30:26 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id x24sm531614wmk.31.2021.10.11.13.30.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 11 Oct 2021 13:30:26 -0700 (PDT)
Message-Id: <cfbb23e9fe2d25140ae0db65479dcd3798428e1c.1633984222.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1048.v4.git.1633984222.gitgitgadget@gmail.com>
References: <pull.1048.v3.git.1633641339.gitgitgadget@gmail.com>
        <pull.1048.v4.git.1633984222.gitgitgadget@gmail.com>
From:   "Victoria Dye via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Mon, 11 Oct 2021 20:30:18 +0000
Subject: [PATCH v4 4/8] reset: expand test coverage for sparse checkouts
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     stolee@gmail.com, gitster@pobox.com, newren@gmail.com,
        Taylor Blau <me@ttaylorr.com>,
        Bagas Sanjaya <bagasdotme@gmail.com>,
        =?UTF-8?Q?=C3=86var_Arnfj=C3=B6r=C3=B0?= Bjarmason 
        <avarab@gmail.com>, Phillip Wood <phillip.wood123@gmail.com>,
        Victoria Dye <vdye@github.com>, Victoria Dye <vdye@github.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Victoria Dye <vdye@github.com>

Add new tests for `--merge` and `--keep` modes, as well as mixed reset with
pathspecs. New performance test cases exercise various execution paths for
`reset`.

Co-authored-by: Derrick Stolee <dstolee@microsoft.com>
Signed-off-by: Derrick Stolee <dstolee@microsoft.com>
Signed-off-by: Victoria Dye <vdye@github.com>
---
 t/perf/p2000-sparse-operations.sh        |  3 +
 t/t1092-sparse-checkout-compatibility.sh | 84 ++++++++++++++++++++++++
 2 files changed, 87 insertions(+)

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
index e1422797013..535686a2954 100755
--- a/t/t1092-sparse-checkout-compatibility.sh
+++ b/t/t1092-sparse-checkout-compatibility.sh
@@ -472,6 +472,90 @@ test_expect_success 'checkout and reset (mixed)' '
 	run_on_sparse test_path_is_missing folder1
 '
 
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
+# Although the working tree differs between full and sparse checkouts after
+# reset, the state of the index is the same.
+test_expect_success 'reset with pathspecs outside sparse definition' '
+	init_repos &&
+	test_all_match git checkout -b reset-test base &&
+
+	test_sparse_match git reset update-folder1 -- folder1 &&
+	git -C full-checkout reset update-folder1 -- folder1 &&
+	test_sparse_match git status --porcelain=v2 &&
+	test_all_match git rev-parse HEAD:folder1 &&
+
+	test_sparse_match git reset update-folder2 -- folder2/a &&
+	git -C full-checkout reset update-folder2 -- folder2/a &&
+	test_sparse_match git status --porcelain=v2 &&
+	test_all_match git rev-parse HEAD:folder2/a
+'
+
+test_expect_success 'reset with wildcard pathspec' '
+	init_repos &&
+
+	test_all_match git checkout -b reset-test update-deep &&
+	test_all_match git reset base -- \*/a &&
+	test_all_match git status --porcelain=v2 &&
+	test_all_match git rev-parse HEAD:folder1/a &&
+
+	test_all_match git reset base -- folder\* &&
+	test_all_match git status --porcelain=v2 &&
+	test_all_match git rev-parse HEAD:folder2
+'
+
 test_expect_success 'merge, cherry-pick, and rebase' '
 	init_repos &&
 
-- 
gitgitgadget

