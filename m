Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6C8F9C433F5
	for <git@archiver.kernel.org>; Mon, 23 May 2022 13:49:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236745AbiEWNtY (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 23 May 2022 09:49:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41916 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236702AbiEWNtE (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 23 May 2022 09:49:04 -0400
Received: from mail-wr1-x436.google.com (mail-wr1-x436.google.com [IPv6:2a00:1450:4864:20::436])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 99FD156409
        for <git@vger.kernel.org>; Mon, 23 May 2022 06:49:02 -0700 (PDT)
Received: by mail-wr1-x436.google.com with SMTP id e2so9841470wrc.1
        for <git@vger.kernel.org>; Mon, 23 May 2022 06:49:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=CQWvGccqzvRWATprGD+CZtA2wSznDAeD0JXUqWIYgLI=;
        b=VoqjaH2Mc4UFqPxE7QHATQpBuVy8gw6g/QdXfhwakvSvfvv4QYXz61S9941RV4OYKW
         WMjM248Uv9j5g6MMfwHiUnw9ZbsVmJ4LAzFktI4+olpSxTAZ9K6QOjgYntKAidUeOfXj
         90x13siDdCen4vUFqd5nXhOrVZRteRZO4YtSRiRrUWO+PEiOBcJW5Ujdv7pujXoka2cK
         /GPJ9JEeLf6jNjTNIPiaO5qt+3zYH5pFOrj6mMPqlqeElsMV7I/iG1oxRk+rui7eBSrz
         jYSQQsZ0f/ZkEmEO8jzROE0cuJrgQaJ7nEWUS+7DZ1875NA1HP+3uQpc9SQv655hlMjv
         9E3g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=CQWvGccqzvRWATprGD+CZtA2wSznDAeD0JXUqWIYgLI=;
        b=GlgMYTiZSjG7TvVEdy7z+v/+CB8pasYpVkGGyUDCZdiwNpfK2Y9xQZ8XD2fKSZwIjX
         Jhx7vRU4akXv6n/9q90n5LSLjgvDRmHsja+7upqJvVwFXkZGV7fz5+WDhKhtOv2B0TUt
         70rOEp/IRjMObV7rqt87MXFnLGBiiy14VXKWXCCHeYl/UocfP3w1YuqfRR5U28Evhc/Y
         VuZ2WOWvV6T0WVFdYdjEttnqzCcbYWhW71PG9YMP0JfXE/u5EKi7CXXNRJxp6hRO+KqQ
         c8wYV6eExBGEZcr6oWfk1TCfWXpaaD+U0qZAXfH9iRYfV3MQGGoVQJS/IWvuhdMkZdWX
         JYIA==
X-Gm-Message-State: AOAM5330IKMZLphwH5cb46O5L29HK5HsEPXR2cWrh73+v6nnQGvt7PkE
        0IxB5XaOqJND+4RI8GuUWqgcpueLQBQ=
X-Google-Smtp-Source: ABdhPJzxxcq8Tc0kC8yJyuOvGN+v5sS4rswhnbXsVvZz2DF1jdIcqBac1tVV74S45lO3/LPZ93gU3Q==
X-Received: by 2002:a5d:64a2:0:b0:20e:6404:b32d with SMTP id m2-20020a5d64a2000000b0020e6404b32dmr19289281wrp.202.1653313741811;
        Mon, 23 May 2022 06:49:01 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id e22-20020adf9bd6000000b0020c5253d8c2sm10507746wrc.14.2022.05.23.06.49.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 23 May 2022 06:49:00 -0700 (PDT)
Message-Id: <11728619120a2d616daab57c57c66e47052f5c89.1653313727.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1208.v3.git.1653313726.gitgitgadget@gmail.com>
References: <pull.1208.v2.git.1652982758.gitgitgadget@gmail.com>
        <pull.1208.v3.git.1653313726.gitgitgadget@gmail.com>
From:   "Derrick Stolee via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Mon, 23 May 2022 13:48:46 +0000
Subject: [PATCH v3 10/10] sparse-checkout: integrate with sparse index
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     gitster@pobox.com, vdye@github.com, shaoxuan.yuan02@gmail.com,
        Derrick Stolee <derrickstolee@github.com>,
        Derrick Stolee <dstolee@microsoft.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Derrick Stolee <dstolee@microsoft.com>

When modifying the sparse-checkout definition, the sparse-checkout
builtin calls update_sparsity() to modify the SKIP_WORKTREE bits of all
cache entries in the index. Before, we needed the index to be fully
expanded in order to ensure we had the full list of files necessary that
match the new patterns.

Insert a call to reset_sparse_directories() that expands sparse
directories that are within the new pattern list, but only far enough
that every necessary file path now exists as a cache entry. The
remaining logic within update_sparsity() will modify the SKIP_WORKTREE
bits appropriately.

This allows us to disable command_requires_full_index within the
sparse-checkout builtin. Add tests that demonstrate that we are not
expanding to a full index unnecessarily.

We can see the improved performance in the p2000 test script:

Test                           HEAD~1            HEAD
------------------------------------------------------------------------
2000.24: git ... (sparse-v3)   2.14(1.55+0.58)   1.57(1.03+0.53) -26.6%
2000.25: git ... (sparse-v4)   2.20(1.62+0.57)   1.58(0.98+0.59) -28.2%

These reductions of 26-28% are small compared to most examples, but the
time is dominated by writing a new copy of the base repository to the
worktree and then deleting it again. The fact that the previous index
expansion was such a large portion of the time is telling how important
it is to complete this sparse index integration.

Signed-off-by: Derrick Stolee <derrickstolee@github.com>
---
 builtin/sparse-checkout.c                |  3 +++
 t/t1092-sparse-checkout-compatibility.sh | 25 ++++++++++++++++++++++++
 unpack-trees.c                           |  4 ++++
 3 files changed, 32 insertions(+)

diff --git a/builtin/sparse-checkout.c b/builtin/sparse-checkout.c
index 1db51c3fd72..67d1d146de5 100644
--- a/builtin/sparse-checkout.c
+++ b/builtin/sparse-checkout.c
@@ -937,6 +937,9 @@ int cmd_sparse_checkout(int argc, const char **argv, const char *prefix)
 
 	git_config(git_default_config, NULL);
 
+	prepare_repo_settings(the_repository);
+	the_repository->settings.command_requires_full_index = 0;
+
 	if (argc > 0) {
 		if (!strcmp(argv[0], "list"))
 			return sparse_checkout_list(argc, argv);
diff --git a/t/t1092-sparse-checkout-compatibility.sh b/t/t1092-sparse-checkout-compatibility.sh
index 785820f9fd5..73f4cf47314 100755
--- a/t/t1092-sparse-checkout-compatibility.sh
+++ b/t/t1092-sparse-checkout-compatibility.sh
@@ -1584,6 +1584,31 @@ test_expect_success 'ls-files' '
 	ensure_not_expanded ls-files --sparse
 '
 
+test_expect_success 'sparse index is not expanded: sparse-checkout' '
+	init_repos &&
+
+	ensure_not_expanded sparse-checkout set deep/deeper2 &&
+	ensure_not_expanded sparse-checkout set deep/deeper1 &&
+	ensure_not_expanded sparse-checkout set deep &&
+	ensure_not_expanded sparse-checkout add folder1 &&
+	ensure_not_expanded sparse-checkout set deep/deeper1 &&
+	ensure_not_expanded sparse-checkout set folder2 &&
+
+	# Demonstrate that the checks that "folder1/a" is a file
+	# do not cause a sparse-index expansion (since it is in the
+	# sparse-checkout cone).
+	echo >>sparse-index/folder2/a &&
+	git -C sparse-index add folder2/a &&
+
+	ensure_not_expanded sparse-checkout add folder1 &&
+
+	# Skip checks here, since deep/deeper1 is inside a sparse directory
+	# that must be expanded to check whether `deep/deeper1` is a file
+	# or not.
+	ensure_not_expanded sparse-checkout set --skip-checks deep/deeper1 &&
+	ensure_not_expanded sparse-checkout set
+'
+
 # NEEDSWORK: a sparse-checkout behaves differently from a full checkout
 # in this scenario, but it shouldn't.
 test_expect_success 'reset mixed and checkout orphan' '
diff --git a/unpack-trees.c b/unpack-trees.c
index 7f528d35cc2..8908b27c03e 100644
--- a/unpack-trees.c
+++ b/unpack-trees.c
@@ -18,6 +18,7 @@
 #include "promisor-remote.h"
 #include "entry.h"
 #include "parallel-checkout.h"
+#include "sparse-index.h"
 
 /*
  * Error messages expected by scripts out of plumbing commands such as
@@ -2018,6 +2019,9 @@ enum update_sparsity_result update_sparsity(struct unpack_trees_options *o)
 			goto skip_sparse_checkout;
 	}
 
+	/* Expand sparse directories as needed */
+	expand_index(o->src_index, o->pl);
+
 	/* Set NEW_SKIP_WORKTREE on existing entries. */
 	mark_all_ce_unused(o->src_index);
 	mark_new_skip_worktree(o->pl, o->src_index, 0,
-- 
gitgitgadget
