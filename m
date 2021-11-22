Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 08801C433FE
	for <git@archiver.kernel.org>; Mon, 22 Nov 2021 22:42:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234897AbhKVWp6 (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 22 Nov 2021 17:45:58 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46016 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234856AbhKVWpw (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 22 Nov 2021 17:45:52 -0500
Received: from mail-wm1-x334.google.com (mail-wm1-x334.google.com [IPv6:2a00:1450:4864:20::334])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2BE8AC061714
        for <git@vger.kernel.org>; Mon, 22 Nov 2021 14:42:45 -0800 (PST)
Received: by mail-wm1-x334.google.com with SMTP id i8-20020a7bc948000000b0030db7b70b6bso494749wml.1
        for <git@vger.kernel.org>; Mon, 22 Nov 2021 14:42:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=gjvBVKiO7PicYvpuOn7hXg1b3+7BxCjEUKA8KQhgMZE=;
        b=T3s6dHVQomtkfakHWD9EYWYeohatiz2HUueXJfnAXDzclZRz2qJOkStylmC+S+/nmN
         UhJ8B7wfktng8zDJkM6L1Vbtm4zaW0eD6eU4yIYXF+ujfs2La9okvVlt/TrtuVYdBFBw
         wYC8sPIZmAqjDo9HX9c1tS1umXbleIUJzDtJc8+oBdIR/VYHgKkxYswMcDJFdDpfKvUM
         17EI8kNHzl9gP+eYXPi1yPXqps3ddab1gpy5uCIT15Gaarh6DDEZR8A03wm9QbjM8HI8
         VUikoOwhOJEp3hWKL46RP10Zi3UUETksTJca7Eod1WbHZh6jQPQA+V2uP41VvESelPwj
         IMqQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=gjvBVKiO7PicYvpuOn7hXg1b3+7BxCjEUKA8KQhgMZE=;
        b=zht8TUTqHRGlfeTPpn+Gp1O16W/6sj+xEOh3pdSBbVhugvcPsxsjgMmn+6+1ePiFwT
         icmRVtM8LUZ4fkwCdveAf8HOuMG26/k2bLva2aUC9hFzrwiIkGCGD8lHz557xfIWWn25
         sno4LrjMr3nN2UGGzDnQnYu5vWy1Zzl+kCCI4utEiURU7SOmFNFdjnQcCTqq1FgSjTU8
         fHu4VcPYD5vCM43zukgitgXKsxjAYr1FlbDFiTUJ8UDI++aTH5F+MdWJ0HgYtegJV67d
         FaspvhtP9PYXau5YfD53mHHzB+gceq9B5Eb9nT0Cn9Zf7yzdz6kkA5iJ6CmlrrSwSQzG
         2cog==
X-Gm-Message-State: AOAM533fy0d9uYKmAl7hOCymEg7wfqBlovBHopyiDWpR2zogYlsWpZeC
        1YLWuE/NzE1XrH7iHRf/L35TyMHrB+4=
X-Google-Smtp-Source: ABdhPJxSBL55YoNMaQcG5riHcqvJhTJHYft+sGMAwh6UgH/ObvyvDETFzeGpR75TFZkM0OQuQFRWQw==
X-Received: by 2002:a05:600c:34d6:: with SMTP id d22mr35339819wmq.111.1637620963568;
        Mon, 22 Nov 2021 14:42:43 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id v7sm9809217wrq.25.2021.11.22.14.42.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 22 Nov 2021 14:42:43 -0800 (PST)
Message-Id: <7acf5118bf5602fbafca2d42c4f363b5adbcbd54.1637620958.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1050.v4.git.1637620958.gitgitgadget@gmail.com>
References: <pull.1050.v3.git.1635802069.gitgitgadget@gmail.com>
        <pull.1050.v4.git.1637620958.gitgitgadget@gmail.com>
From:   "Lessley Dennington via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Mon, 22 Nov 2021 22:42:38 +0000
Subject: [PATCH v4 4/4] blame: enable and test the sparse index
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     stolee@gmail.com, gitster@pobox.com, newren@gmail.com,
        Taylor Blau <me@ttaylorr.com>,
        Lessley Dennington <lessleydennington@gmail.com>,
        Lessley Dennington <lessleydennington@gmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Lessley Dennington <lessleydennington@gmail.com>

Enable the sparse index for the 'git blame' command. The index was already
not expanded with this command, so the most interesting thing to do is to
add tests that verify that 'git blame' behaves correctly when the sparse
index is enabled and that its performance improves. More specifically, these
cases are:

1. The index is not expanded for 'blame' when given paths in the sparse
checkout cone at multiple levels.

2. Performance measurably improves for 'blame' with sparse index when given
paths in the sparse checkout cone at multiple levels.

The `p2000` tests demonstrate a ~60% execution time reduction when running
'blame' for a file two levels deep and and a ~30% execution time reduction
for a file three levels deep.

Test                                         before  after
----------------------------------------------------------------
2000.62: git blame f2/f4/a (full-v3)         0.31    0.32 +3.2%
2000.63: git blame f2/f4/a (full-v4)         0.29    0.31 +6.9%
2000.64: git blame f2/f4/a (sparse-v3)       0.55    0.23 -58.2%
2000.65: git blame f2/f4/a (sparse-v4)       0.57    0.23 -59.6%
2000.66: git blame f2/f4/f3/a (full-v3)      0.77    0.85 +10.4%
2000.67: git blame f2/f4/f3/a (full-v4)      0.78    0.81 +3.8%
2000.68: git blame f2/f4/f3/a (sparse-v3)    1.07    0.72 -32.7%
2000.99: git blame f2/f4/f3/a (sparse-v4)    1.05    0.73 -30.5%

We do not include paths outside the sparse checkout cone because blame
currently does not support blaming files outside of the sparse definition.
Attempting to do so fails with the following error:

  fatal: no such path '<path outside sparse definition>' in HEAD

Signed-off-by: Lessley Dennington <lessleydennington@gmail.com>
---
 builtin/blame.c                          |  5 +++
 t/perf/p2000-sparse-operations.sh        |  4 +-
 t/t1092-sparse-checkout-compatibility.sh | 49 ++++++++++++++++++------
 3 files changed, 46 insertions(+), 12 deletions(-)

diff --git a/builtin/blame.c b/builtin/blame.c
index 641523ff9af..247b9eaf88f 100644
--- a/builtin/blame.c
+++ b/builtin/blame.c
@@ -902,6 +902,11 @@ int cmd_blame(int argc, const char **argv, const char *prefix)
 	long anchor;
 	const int hexsz = the_hash_algo->hexsz;
 
+	if (startup_info->have_repository) {
+		prepare_repo_settings(the_repository);
+		the_repository->settings.command_requires_full_index = 0;
+	}
+
 	setup_default_color_by_age();
 	git_config(git_blame_config, &output_option);
 	repo_init_revisions(the_repository, &revs, NULL);
diff --git a/t/perf/p2000-sparse-operations.sh b/t/perf/p2000-sparse-operations.sh
index 5cf94627383..9ac76a049b8 100755
--- a/t/perf/p2000-sparse-operations.sh
+++ b/t/perf/p2000-sparse-operations.sh
@@ -114,6 +114,8 @@ test_perf_on_all git reset
 test_perf_on_all git reset --hard
 test_perf_on_all git reset -- does-not-exist
 test_perf_on_all git diff
-test_perf_on_all git diff --cached
+test_perf_on_all git diff --staged
+test_perf_on_all git blame $SPARSE_CONE/a
+test_perf_on_all git blame $SPARSE_CONE/f3/a
 
 test_done
diff --git a/t/t1092-sparse-checkout-compatibility.sh b/t/t1092-sparse-checkout-compatibility.sh
index 53524660759..d680dbd8867 100755
--- a/t/t1092-sparse-checkout-compatibility.sh
+++ b/t/t1092-sparse-checkout-compatibility.sh
@@ -442,21 +442,36 @@ test_expect_success 'log with pathspec outside sparse definition' '
 test_expect_success 'blame with pathspec inside sparse definition' '
 	init_repos &&
 
-	test_all_match git blame a &&
-	test_all_match git blame deep/a &&
-	test_all_match git blame deep/deeper1/a &&
-	test_all_match git blame deep/deeper1/deepest/a
+	for file in a \
+			deep/a \
+			deep/deeper1/a \
+			deep/deeper1/deepest/a
+	do
+		test_all_match git blame $file
+	done
 '
 
-# TODO: blame currently does not support blaming files outside of the
-# sparse definition. It complains that the file doesn't exist locally.
-test_expect_failure 'blame with pathspec outside sparse definition' '
+# NEEDSWORK: This test documents the current behavior, but this could
+# change in the future if we decide to support blaming files outside
+# the sparse definition.
+test_expect_success 'blame with pathspec outside sparse definition' '
 	init_repos &&
+	test_sparse_match git sparse-checkout set &&
 
-	test_all_match git blame folder1/a &&
-	test_all_match git blame folder2/a &&
-	test_all_match git blame deep/deeper2/a &&
-	test_all_match git blame deep/deeper2/deepest/a
+	for file in a \
+			deep/a \
+			deep/deeper1/a \
+			deep/deeper1/deepest/a
+	do
+		test_sparse_match test_must_fail git blame $file &&
+		cat >expect <<-EOF &&
+		fatal: Cannot lstat '"'"'$file'"'"': No such file or directory
+		EOF
+		# We compare sparse-checkout-err and sparse-index-err in
+		# `test_sparse_match`. Given we know they are the same, we
+		# only check the content of sparse-index-err here.
+		test_cmp expect sparse-index-err
+	done
 '
 
 test_expect_success 'checkout and reset (mixed)' '
@@ -878,6 +893,18 @@ test_expect_success 'sparse index is not expanded: diff' '
 	ensure_not_expanded diff --staged
 '
 
+test_expect_success 'sparse index is not expanded: blame' '
+	init_repos &&
+
+	for file in a \
+			deep/a \
+			deep/deeper1/a \
+			deep/deeper1/deepest/a
+	do
+		ensure_not_expanded blame $file
+	done
+'
+
 # NEEDSWORK: a sparse-checkout behaves differently from a full checkout
 # in this scenario, but it shouldn't.
 test_expect_success 'reset mixed and checkout orphan' '
-- 
gitgitgadget
