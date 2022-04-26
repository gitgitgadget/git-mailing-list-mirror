Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6FCE4C433FE
	for <git@archiver.kernel.org>; Tue, 26 Apr 2022 20:43:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1355128AbiDZUqs (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 26 Apr 2022 16:46:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56560 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1355122AbiDZUqh (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 26 Apr 2022 16:46:37 -0400
Received: from mail-wr1-x432.google.com (mail-wr1-x432.google.com [IPv6:2a00:1450:4864:20::432])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CC8DE13C65D
        for <git@vger.kernel.org>; Tue, 26 Apr 2022 13:43:28 -0700 (PDT)
Received: by mail-wr1-x432.google.com with SMTP id j15so13821305wrb.2
        for <git@vger.kernel.org>; Tue, 26 Apr 2022 13:43:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=GfXMeHCQb9cUCMVaqBi6pfGj7gRjow9+K2YTy4zFUtI=;
        b=imMhMY4t6r6OzN0F2OgLkO4E88gCnq8ZkN0qo0R0hzpALJ6Oisvl/LP0meH9Sys3UE
         JC6Cjxn5beAwsdRMC10B0Hun/ODC6VXx4MdVvuxAXqZa2wvUpxxECUOlkrLNPkvx987m
         OJAtKU7I9w/MablmRr1V3QmrZ15kU3zBYXUiLWJMOYiGnZ2d8sI/YFTAfpjRs5tDdqS+
         BO9eB2Qo2b68j26E7WeQ5QACNOQCrF5DHliqggJvFXkgOGJvNlRM8e6rqh2epLUIAfLn
         o8LzdfdSSQCncntv8aj9sHvoGPShzgZEYZvmLpwoqS9GoKIZWFUde83JNbXTnvQy7MHF
         LEBw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=GfXMeHCQb9cUCMVaqBi6pfGj7gRjow9+K2YTy4zFUtI=;
        b=JghR5xyAFEjtThZiAKAd9pkM0ZwwBXDGP2VDfGT0BmbBrL4/YxGJuysrpu13AAlvbZ
         ZRlvB73piIGZAqjheuVjudpJrjSVaTUj6IJ5gF/eh185QKIVv1Vx9a8eFpi0BA4oPXjy
         PZ5FVfmiqc24yQ81aBR+G6UgMcqpQK73JKI+I6gP76tJSGR+l8MHcapCT0GKCPRIAGAO
         HWGcP/PRYLsf97cwkN5j0U8ShL0UI7/n716v2Bbwwj+MoeAvXAGRgb2oUPYz/5aaPs29
         Ug0y2RecJn4Y951f5qOL9601pMMYmPvOYLEgLKKan4fcy3MiWoVxrr2nv0+TBB9NZsHe
         MIjA==
X-Gm-Message-State: AOAM532IwHRy8EE7iPQfkbU+W7r+lbf2DLadw1kQLwvrJnfUK/AAk+HP
        UNdikiIQ3FDquNLiFH+imWw/4fL7Jd0=
X-Google-Smtp-Source: ABdhPJwOeydAAsbBUwahqFVmTAGGRSaYAgZ9gRo04jiTZ7x88HPIJZaWK+efTcs9OT/SX/0K7vq64A==
X-Received: by 2002:a5d:64e6:0:b0:20a:d88b:f631 with SMTP id g6-20020a5d64e6000000b0020ad88bf631mr11056166wri.441.1651005807038;
        Tue, 26 Apr 2022 13:43:27 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id o9-20020adf8b89000000b0020adeb916d8sm5081299wra.30.2022.04.26.13.43.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 26 Apr 2022 13:43:26 -0700 (PDT)
Message-Id: <69efe637a18786b289db79971e9e49137306b57c.1651005800.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1207.v2.git.1651005800.gitgitgadget@gmail.com>
References: <pull.1207.git.1649349442.gitgitgadget@gmail.com>
        <pull.1207.v2.git.1651005800.gitgitgadget@gmail.com>
From:   "Derrick Stolee via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Tue, 26 Apr 2022 20:43:20 +0000
Subject: [PATCH v2 5/5] rev-parse: integrate with sparse index
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     gitster@pobox.com, vdye@github.com, shaoxuan.yuan02@gmail.com,
        Philip Oakley <philipoakley@iee.email>,
        Josh Steadmon <steadmon@google.com>,
        Derrick Stolee <derrickstolee@github.com>,
        Derrick Stolee <derrickstolee@github.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Derrick Stolee <derrickstolee@github.com>

It is not obvious that the 'git rev-parse' builtin would use the sparse
index, but it is possible to parse paths out of the index using the
":<path>" syntax. The 'git rev-parse' output is only the OID of the
object found at that location, but otherwise behaves similarly to 'git
show :<path>'. This includes the failure conditions on directories and
the error messages depending on whether a path is in the worktree or
not.

The only code change required is to change the
command_requires_full_index setting in builtin/rev-parse.c, and we can
re-use many existing 'git show' tests for the rev-parse case.

Signed-off-by: Derrick Stolee <derrickstolee@github.com>
---
 builtin/rev-parse.c                      |  3 ++
 t/t1092-sparse-checkout-compatibility.sh | 45 +++++++++++++-----------
 2 files changed, 28 insertions(+), 20 deletions(-)

diff --git a/builtin/rev-parse.c b/builtin/rev-parse.c
index 8480a59f573..4fc6185b2d1 100644
--- a/builtin/rev-parse.c
+++ b/builtin/rev-parse.c
@@ -723,6 +723,9 @@ int cmd_rev_parse(int argc, const char **argv, const char *prefix)
 			prefix = setup_git_directory();
 			git_config(git_default_config, NULL);
 			did_repo_setup = 1;
+
+			prepare_repo_settings(the_repository);
+			the_repository->settings.command_requires_full_index = 0;
 		}
 
 		if (!strcmp(arg, "--")) {
diff --git a/t/t1092-sparse-checkout-compatibility.sh b/t/t1092-sparse-checkout-compatibility.sh
index fa1d5603605..93bcfd20bbc 100755
--- a/t/t1092-sparse-checkout-compatibility.sh
+++ b/t/t1092-sparse-checkout-compatibility.sh
@@ -1151,29 +1151,32 @@ test_expect_success 'clean' '
 	test_sparse_match test_path_is_dir folder1
 '
 
-test_expect_success 'show (cached blobs/trees)' '
-	init_repos &&
+for builtin in show rev-parse
+do
+	test_expect_success "$builtin (cached blobs/trees)" "
+		init_repos &&
 
-	test_all_match git show :a &&
-	test_all_match git show :deep/a &&
-	test_sparse_match git show :folder1/a &&
+		test_all_match git $builtin :a &&
+		test_all_match git $builtin :deep/a &&
+		test_sparse_match git $builtin :folder1/a &&
 
-	# The error message differs depending on whether
-	# the directory exists in the worktree.
-	test_all_match test_must_fail git show :deep/ &&
-	test_must_fail git -C full-checkout show :folder1/ &&
-	test_sparse_match test_must_fail git show :folder1/ &&
+		# The error message differs depending on whether
+		# the directory exists in the worktree.
+		test_all_match test_must_fail git $builtin :deep/ &&
+		test_must_fail git -C full-checkout $builtin :folder1/ &&
+		test_sparse_match test_must_fail git $builtin :folder1/ &&
 
-	# Change the sparse cone for an extra case:
-	run_on_sparse git sparse-checkout set deep/deeper1 &&
+		# Change the sparse cone for an extra case:
+		run_on_sparse git sparse-checkout set deep/deeper1 &&
 
-	# deep/deeper2 is a sparse directory in the sparse index.
-	test_sparse_match test_must_fail git show :deep/deeper2/ &&
+		# deep/deeper2 is a sparse directory in the sparse index.
+		test_sparse_match test_must_fail git $builtin :deep/deeper2/ &&
 
-	# deep/deeper2/deepest is not in the sparse index, but
-	# will trigger an index expansion.
-	test_sparse_match test_must_fail git show :deep/deeper2/deepest/
-'
+		# deep/deeper2/deepest is not in the sparse index, but
+		# will trigger an index expansion.
+		test_sparse_match test_must_fail git $builtin :deep/deeper2/deepest/
+	"
+done
 
 test_expect_success 'submodule handling' '
 	init_repos &&
@@ -1396,11 +1399,13 @@ test_expect_success 'sparse index is not expanded: diff' '
 	ensure_not_expanded diff --cached
 '
 
-test_expect_success 'sparse index is not expanded: show' '
+test_expect_success 'sparse index is not expanded: show and rev-parse' '
 	init_repos &&
 
 	ensure_not_expanded show :a &&
-	ensure_not_expanded show :deep/a
+	ensure_not_expanded show :deep/a &&
+	ensure_not_expanded rev-parse :a &&
+	ensure_not_expanded rev-parse :deep/a
 '
 
 test_expect_success 'sparse index is not expanded: update-index' '
-- 
gitgitgadget
