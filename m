Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B4BDFC433F5
	for <git@archiver.kernel.org>; Fri,  3 Dec 2021 21:16:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1383210AbhLCVTp (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 3 Dec 2021 16:19:45 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33846 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1383192AbhLCVTk (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 3 Dec 2021 16:19:40 -0500
Received: from mail-wm1-x331.google.com (mail-wm1-x331.google.com [IPv6:2a00:1450:4864:20::331])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 57416C061353
        for <git@vger.kernel.org>; Fri,  3 Dec 2021 13:16:16 -0800 (PST)
Received: by mail-wm1-x331.google.com with SMTP id p3-20020a05600c1d8300b003334fab53afso5834683wms.3
        for <git@vger.kernel.org>; Fri, 03 Dec 2021 13:16:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=uU/hEQjnAF5FZQWZ40iR+eukDquJq7jW0O71gy/5HiE=;
        b=GRSmw3RC6PnJXzquc4iFxOGxXs7P/oIvtRsDywHPWZBRrSnEilEbh2660njl9UWbjW
         jy1333C5Yq66TGNQAEX7L6zQMRHVK+Q7B/hNRXNR2HRN+rxqPjnEaYLS1/7hGkxdaum2
         JxSpKR5j4/o9STBeJoo6nVL3kACxFN0h/y/dCjURewP8ykAnOVaQxIhoHT2W8KS8qaEn
         lk2JIBS92DyL9so72RuQfC1ynlCLtj3ah6CNtnzPEcLsYp1VJMyWGhKqWC/WbuowBMM7
         5g6jEvGskM+YRGKdr5Jo8KGX9pKvS91yaBEykspZ6HWBAQ3ucg7LuPIF3mlAhjZXf0X8
         G8nQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=uU/hEQjnAF5FZQWZ40iR+eukDquJq7jW0O71gy/5HiE=;
        b=fEYJZbXuCWfDGYoy8Fj6bF2gwt7NFpni/G1co8G94A8QXjY0kSTQegXIBAMAnUvjaL
         6ErnCYOVQZ0D4yZcWfTifVYnlTgxw4DFil7Vg0ZYhWMi9rQST01pFXqa8apwCvg8Wtlk
         FUAOkYCc7T0tdiqMrMX3czx5qBHth4bo+wLymRdgyg2fwyXmepQk4xoF2yGgfn+1HSoq
         EzfEXi3cMwQxl7AD6ZrYx9p7Fp0QC9w9WU282Sq5NTXzpo+YTepNNwkND5IkzaOknlDl
         u0i3lk0jrdQNCT1e1RbAQIbt1OG+bQ7cBQ1ODQZPhQS78EVx5jYkLCUgvQN+zETITHBh
         EDAg==
X-Gm-Message-State: AOAM530DvrrsyX1bbXIcWYL2ktAXOVMDhDl9UNGg0Y7hYT2ygq/7RWwo
        TUAAfUxXkvPXCWPig1hTI1Rc3N+oCz8=
X-Google-Smtp-Source: ABdhPJx1wJUeVbcbbRzs/aIL97yuodHIbUZYSyP/oZ5LsV0EIRrpMVAzxdRrrF4J+LoT+KwJnSU7Wg==
X-Received: by 2002:a1c:1fcf:: with SMTP id f198mr17745909wmf.66.1638566174778;
        Fri, 03 Dec 2021 13:16:14 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id l11sm3461555wrp.61.2021.12.03.13.16.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 03 Dec 2021 13:16:14 -0800 (PST)
Message-Id: <0453237873422a3919200b3f641b7847d44f0efa.1638566166.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1050.v5.git.1638566165.gitgitgadget@gmail.com>
References: <pull.1050.v4.git.1637620958.gitgitgadget@gmail.com>
        <pull.1050.v5.git.1638566165.gitgitgadget@gmail.com>
From:   "Lessley Dennington via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Fri, 03 Dec 2021 21:16:05 +0000
Subject: [PATCH v5 7/7] blame: enable and test the sparse index
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
does not support blaming files that are not present in the working
directory. This is true in both sparse and full checkouts.

Signed-off-by: Lessley Dennington <lessleydennington@gmail.com>
---
 builtin/blame.c                          |  3 ++
 t/perf/p2000-sparse-operations.sh        |  2 +
 t/t1092-sparse-checkout-compatibility.sh | 49 ++++++++++++++++++------
 3 files changed, 43 insertions(+), 11 deletions(-)

diff --git a/builtin/blame.c b/builtin/blame.c
index 641523ff9af..33e411d2203 100644
--- a/builtin/blame.c
+++ b/builtin/blame.c
@@ -940,6 +940,9 @@ parse_done:
 	revs.diffopt.flags.follow_renames = 0;
 	argc = parse_options_end(&ctx);
 
+	prepare_repo_settings(the_repository);
+	the_repository->settings.command_requires_full_index = 0;
+
 	if (incremental || (output_option & OUTPUT_PORCELAIN)) {
 		if (show_progress > 0)
 			die(_("--progress can't be used with --incremental or porcelain formats"));
diff --git a/t/perf/p2000-sparse-operations.sh b/t/perf/p2000-sparse-operations.sh
index 5cf94627383..cb777c74a24 100755
--- a/t/perf/p2000-sparse-operations.sh
+++ b/t/perf/p2000-sparse-operations.sh
@@ -115,5 +115,7 @@ test_perf_on_all git reset --hard
 test_perf_on_all git reset -- does-not-exist
 test_perf_on_all git diff
 test_perf_on_all git diff --cached
+test_perf_on_all git blame $SPARSE_CONE/a
+test_perf_on_all git blame $SPARSE_CONE/f3/a
 
 test_done
diff --git a/t/t1092-sparse-checkout-compatibility.sh b/t/t1092-sparse-checkout-compatibility.sh
index abfb4994bb9..6187a997b7d 100755
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
+# Without a revision specified, blame will error if passed any file that
+# is not present in the working directory (even if the file is tracked).
+# Here we just verify that this is also true with sparse checkouts.
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
@@ -892,6 +907,18 @@ test_expect_success 'sparse index is not expanded: diff' '
 	ensure_not_expanded diff --cached
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
