Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7E8C8C433EF
	for <git@archiver.kernel.org>; Mon,  1 Nov 2021 21:28:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 671B860D07
	for <git@archiver.kernel.org>; Mon,  1 Nov 2021 21:28:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231450AbhKAVaf (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 1 Nov 2021 17:30:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38662 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231511AbhKAVa2 (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 1 Nov 2021 17:30:28 -0400
Received: from mail-wr1-x42c.google.com (mail-wr1-x42c.google.com [IPv6:2a00:1450:4864:20::42c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 76C69C061714
        for <git@vger.kernel.org>; Mon,  1 Nov 2021 14:27:54 -0700 (PDT)
Received: by mail-wr1-x42c.google.com with SMTP id b12so25747246wrh.4
        for <git@vger.kernel.org>; Mon, 01 Nov 2021 14:27:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=RMIjIIQxALZ7BH6/pH+BQSPK72pmxz50nY1aC7EupjU=;
        b=Zt3TBavU5NZCoYlsqbrjYcaTzXku4rtY8t3J8PpcaiWmEze2a5q30KUGxCFzibRmpU
         B28q7KVx3wgkSceQm5RZgsUDvLL6RzG5ozxKT/AD4IqCwfwKTY4oHD6v1yEaYsMtWrBy
         jc5uernFwugg7YrMNWFa0qT6K9OViHa4f5lGg0ecF1YriCt26KPScKvqHcZrLNS4SHvq
         2L7JDzomy6oA05UZM0f8YWYmrSSTWgrD7pmEjJkDim2bQM3VJ0aE0caqlxKTo7YXPzyz
         kq8E+ezQuLMPy64att+9AsYAdj35ndpW5C5I4QseD72vMFKEnHE19jbaVI+bfjLJi8k7
         hz4A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=RMIjIIQxALZ7BH6/pH+BQSPK72pmxz50nY1aC7EupjU=;
        b=yyDAgFpaCiq4gP6m0nMMYNLvuwJQsi5k3d50AScCJ9Z3oXawbB6hptMeNDfPiSUoCx
         O6JvwnkJAsG3M65aitmmYt8bULbQlPduQ96z6cZy7RUZbI68T6FxYVfJuW1NHlQW85Nm
         PZk4UUJYPx/sVkbQSTYAaEA2UfXAvW9HgMHGjzLB913OvuvsBNnxC6zNHyAam5Z7E/yr
         I+bO1GUZ8CjKRxR3i53oRNyAQDoh5soGCmxP5k8BvmcoVYHAs591pibtll2fjNqFXWRT
         NKLXX273RiyhHbDkRLcTXbN4nqdeQuMM7DHuFm1szaY/QkkoC0wOyQm8o92vjltUIIXG
         ZtWQ==
X-Gm-Message-State: AOAM531t/LJhTHBwJ3KpsKnbU3jp70vg00RwoZX+vjaYeu4upf7NnE64
        OkqdkwEceFix9qRc0R6FXMoCxi8bAHQ=
X-Google-Smtp-Source: ABdhPJxDHqLoWtWs4ZwlU1tUlUtpVO+46d6SA2lkUmJqp7BdC2Q0hAeEy//k4V/wGqts2BKYSs5g1w==
X-Received: by 2002:a05:600c:1:: with SMTP id g1mr1673283wmc.19.1635802072825;
        Mon, 01 Nov 2021 14:27:52 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id q14sm578942wmq.4.2021.11.01.14.27.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 01 Nov 2021 14:27:52 -0700 (PDT)
Message-Id: <cfdd33129ec6860cbec0cb20302598429db1115e.1635802069.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1050.v3.git.1635802069.gitgitgadget@gmail.com>
References: <pull.1050.v2.git.1634332835.gitgitgadget@gmail.com>
        <pull.1050.v3.git.1635802069.gitgitgadget@gmail.com>
From:   "Lessley Dennington via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Mon, 01 Nov 2021 21:27:49 +0000
Subject: [PATCH v3 2/2] blame: enable and test the sparse index
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
 builtin/blame.c                          |  3 ++
 t/perf/p2000-sparse-operations.sh        |  2 +
 t/t1092-sparse-checkout-compatibility.sh | 48 ++++++++++++++++++------
 3 files changed, 42 insertions(+), 11 deletions(-)

diff --git a/builtin/blame.c b/builtin/blame.c
index 641523ff9af..af3d81e2bd4 100644
--- a/builtin/blame.c
+++ b/builtin/blame.c
@@ -902,6 +902,9 @@ int cmd_blame(int argc, const char **argv, const char *prefix)
 	long anchor;
 	const int hexsz = the_hash_algo->hexsz;
 
+	prepare_repo_settings(the_repository);
+	the_repository->settings.command_requires_full_index = 0;
+
 	setup_default_color_by_age();
 	git_config(git_blame_config, &output_option);
 	repo_init_revisions(the_repository, &revs, NULL);
diff --git a/t/perf/p2000-sparse-operations.sh b/t/perf/p2000-sparse-operations.sh
index bff93f16e93..9ac76a049b8 100755
--- a/t/perf/p2000-sparse-operations.sh
+++ b/t/perf/p2000-sparse-operations.sh
@@ -115,5 +115,7 @@ test_perf_on_all git reset --hard
 test_perf_on_all git reset -- does-not-exist
 test_perf_on_all git diff
 test_perf_on_all git diff --staged
+test_perf_on_all git blame $SPARSE_CONE/a
+test_perf_on_all git blame $SPARSE_CONE/f3/a
 
 test_done
diff --git a/t/t1092-sparse-checkout-compatibility.sh b/t/t1092-sparse-checkout-compatibility.sh
index 53524660759..da442f3dcff 100755
--- a/t/t1092-sparse-checkout-compatibility.sh
+++ b/t/t1092-sparse-checkout-compatibility.sh
@@ -442,21 +442,35 @@ test_expect_success 'log with pathspec outside sparse definition' '
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
+# Blame does not support blaming files outside of the sparse
+# definition, so we verify this scenario.
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
@@ -878,6 +892,18 @@ test_expect_success 'sparse index is not expanded: diff' '
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
