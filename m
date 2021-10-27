Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BDDF9C433EF
	for <git@archiver.kernel.org>; Wed, 27 Oct 2021 14:39:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A6C2460720
	for <git@archiver.kernel.org>; Wed, 27 Oct 2021 14:39:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242628AbhJ0OmA (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 27 Oct 2021 10:42:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46446 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238902AbhJ0Oly (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 27 Oct 2021 10:41:54 -0400
Received: from mail-wr1-x436.google.com (mail-wr1-x436.google.com [IPv6:2a00:1450:4864:20::436])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5C64AC061570
        for <git@vger.kernel.org>; Wed, 27 Oct 2021 07:39:28 -0700 (PDT)
Received: by mail-wr1-x436.google.com with SMTP id u18so4577976wrg.5
        for <git@vger.kernel.org>; Wed, 27 Oct 2021 07:39:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=kb73tIJKEniDWqTeYxI92yj2S3EyQHnwcWkfm6tEo94=;
        b=nyt4U4dJ8eXw4UwPi3pgct9lwrAbgWnhnywKM9to+WJavlFa52j7UjwrYJW0dMj9yY
         MgVz4/uP/VYvZL+L4CQxmCxk3VTxjXKIJCVFomcZrrftG2Qz0MFzWm/xYhom2QWhYkPn
         kjGSv+JUgo8bl8bFoUmLyfkW4h6eux3BtCltuJVAeyrv4Hcjuu3Q5IfvU5rU/hjR7mTu
         bdmagkROej0nyjzfK1bfnifqJcnlh37w7V3HnDANnIIM3e066T7MZCseQbFV0DThnmyd
         DjxVUe+ACc4FSoYZ9ZzWQKPsgfkaPaqjYfIbAAageQs1g0QXdJSaTqAt+ZfFwsfXbaZB
         2PkA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=kb73tIJKEniDWqTeYxI92yj2S3EyQHnwcWkfm6tEo94=;
        b=JH71OaSZkR566RuvB5qoRysi92cGh1vr+UEXu0Mf8Cvh0UfDw4JnFF7t3syQ7LLxJW
         4zAC2EKyIdhDbVHWRQNwSYieQ3kYBbRtwdD+dBG8d9UzNq9GrqRtDeWUVNRk6y7m+Jhg
         mMcE7E/JL1aCD/xI3xr7pzNqLJCa11ZWjzBnANbtVFO+dZt+m0zS42yh7jpCxvb912P8
         OzAOOoUjP6DD2tQJ2bpGeKAX/srisUJEeRPxpF2/cZMJ02m4URxDBbSRXUIDFhwMHMNo
         EdVGgXaND1G2ceNru3tmwCuDp8sZTabPBPfe0i/RwLe5BztNz/B1yqAufO6fu4uV2u8V
         rTqQ==
X-Gm-Message-State: AOAM531yrb1PowK8SVBb7jWN+vJwGyZpHOnYB9FT0ZLy5DaguujD3oXa
        6xcgs5ZYOPWiqafq/sm8uJZh/G2nARs=
X-Google-Smtp-Source: ABdhPJye7g4g0PtC6vcVTpGhEIWpD81q5OAVDQS9zTezgahRo7RAbFNU8Kw4V0YWXTVqnE/8jIZfKw==
X-Received: by 2002:a5d:5092:: with SMTP id a18mr6025685wrt.421.1635345567013;
        Wed, 27 Oct 2021 07:39:27 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id d8sm49351wrv.80.2021.10.27.07.39.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 27 Oct 2021 07:39:26 -0700 (PDT)
Message-Id: <cc76c6946476d51a269da3ad91aaae014e2a48d8.1635345563.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1048.v5.git.1635345563.gitgitgadget@gmail.com>
References: <pull.1048.v4.git.1633984222.gitgitgadget@gmail.com>
        <pull.1048.v5.git.1635345563.gitgitgadget@gmail.com>
From:   "Victoria Dye via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Wed, 27 Oct 2021 14:39:19 +0000
Subject: [PATCH v5 4/8] reset: expand test coverage for sparse checkouts
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
        Emily Shaffer <emilyshaffer@google.com>,
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
index cab6340a9d0..a8583030b38 100755
--- a/t/t1092-sparse-checkout-compatibility.sh
+++ b/t/t1092-sparse-checkout-compatibility.sh
@@ -475,6 +475,90 @@ test_expect_success 'checkout and reset (mixed)' '
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

