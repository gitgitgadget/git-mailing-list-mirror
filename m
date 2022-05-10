Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0B0ECC433F5
	for <git@archiver.kernel.org>; Tue, 10 May 2022 23:32:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234459AbiEJXcx (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 10 May 2022 19:32:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45128 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237988AbiEJXcp (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 10 May 2022 19:32:45 -0400
Received: from mail-wr1-x42f.google.com (mail-wr1-x42f.google.com [IPv6:2a00:1450:4864:20::42f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4EC971D89D0
        for <git@vger.kernel.org>; Tue, 10 May 2022 16:32:44 -0700 (PDT)
Received: by mail-wr1-x42f.google.com with SMTP id q23so665456wra.1
        for <git@vger.kernel.org>; Tue, 10 May 2022 16:32:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=kXdEkvmmjHc6q6OBG6CFaQ3cHJOMCpde/55Y8aMKBZ4=;
        b=PXgrSQJEJUMMvCejLzY42GgdftGeLFTFOWs0boLHHt1Zk+qRPWQ5zROw9Yxtvxmqm+
         BsRwMy32vN+4WJw4RgswvMxOGsFQe7ZMg8/Is6uWVDcGUVZBmusLP0b1DaCSWlfuli34
         eLOGVQFjUZ1WZ9WGWu5dBu0eXx/a/qK5m/7YCm3zhP6EUdoR98dJ/S+t4d7DI7mVPxiz
         xEEwY8BTWR5jJE4XwkfOPFd3pqp9ajsnb9prJRoToUCXJtnQq3t/mqZoJLfqrOAnq9tQ
         maDWGiM8jsRFcR8t4k2zzM7jF94llRZeTXFlgTOmDmn/TrDTOk6zHCamhuwMM+qZR9vg
         MzNw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=kXdEkvmmjHc6q6OBG6CFaQ3cHJOMCpde/55Y8aMKBZ4=;
        b=5+hjaPk0ZhRyntZ+b/uM4q8tWbL/5EMifY8xRHnFY8uaKd53l0b7qY1hZIVaU+8Gd3
         VFEpUSaHrWH/8e9ox4sJKwq/87cwkWVYp8TpEAszVycgY3vI8y4BWwjbejo8jXTUVGA/
         RHfrrF5/kt231Q6qpOJ4nt+2LSg3RXaOrNptojupVEtTd10m8y+zCGdHu1KWhi/2oXx3
         wTM0fgloM3cTt2xnRHC/1DsYRFUqN+fmAiqLvNuAKia3H1Zv8wvWAPz5q8UEevoxnCgO
         KTYu5K8Wg/ty3rQwGw7SkasHAew20nnao2+htJibMuvYYZelN2zGVdTmhARSRtmRzzxW
         4oog==
X-Gm-Message-State: AOAM5319V9f/0RFMT+0pxkiFt2lpixhBLcgQC4qUV9cOBk0ny0xERFhW
        HB4Gu/k4rX72R8oVymjOpzWObfrc0s4=
X-Google-Smtp-Source: ABdhPJwCsJew9bmeZ9K24YUVP58GzwqkUEuE2WpHfMr9bjYJwymwzsi+e1HDNUbjWEdqbGGVR4YOfg==
X-Received: by 2002:a5d:61cc:0:b0:20a:d154:9806 with SMTP id q12-20020a5d61cc000000b0020ad1549806mr19724296wrv.439.1652225562393;
        Tue, 10 May 2022 16:32:42 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id c10-20020adfef4a000000b0020c5253d8fdsm170734wrp.73.2022.05.10.16.32.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 10 May 2022 16:32:41 -0700 (PDT)
Message-Id: <e733c2fd9f497a8d80555126ec2e166e182ab8db.1652225552.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1171.v3.git.1652225552.gitgitgadget@gmail.com>
References: <pull.1171.v2.git.1651083378.gitgitgadget@gmail.com>
        <pull.1171.v3.git.1652225552.gitgitgadget@gmail.com>
From:   "Victoria Dye via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Tue, 10 May 2022 23:32:31 +0000
Subject: [PATCH v3 5/6] stash: apply stash using 'merge_ort_nonrecursive()'
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

Update 'stash' to use 'merge_ort_nonrecursive()' to apply a stash to the
current working tree. When 'git stash apply' was converted from its shell
script implementation to a builtin in 8a0fc8d19d (stash: convert apply to
builtin, 2019-02-25), 'merge_recursive_generic()' was used to merge a stash
into the working tree as part of 'git stash (apply|pop)'. However, with the
single merge base used in 'do_apply_stash()', the commit wrapping done by
'merge_recursive_generic()' is not only unnecessary, but misleading (the
*real* merge base is labeled "constructed merge base"). Therefore, a
non-recursive merge of the working tree, stashed tree, and stash base tree
is more appropriate.

There are two options for a non-recursive merge-then-update-worktree
function: 'merge_trees()' and 'merge_ort_nonrecursive()'. Use
'merge_ort_nonrecursive()' to align with the default merge strategy used by
'git merge' (6a5fb96672 (Change default merge backend from recursive to ort,
2021-08-04)) and, because merge-ort does not operate in-place on the index,
avoid unnecessary index expansion. Update tests in 't1092' verifying index
expansion for 'git stash' accordingly.

Signed-off-by: Victoria Dye <vdye@github.com>
---
 builtin/stash.c                          | 30 +++++++++++++++++++-----
 t/t1092-sparse-checkout-compatibility.sh |  4 ++--
 2 files changed, 26 insertions(+), 8 deletions(-)

diff --git a/builtin/stash.c b/builtin/stash.c
index 1bfba532044..3fe549f7d3c 100644
--- a/builtin/stash.c
+++ b/builtin/stash.c
@@ -7,6 +7,7 @@
 #include "cache-tree.h"
 #include "unpack-trees.h"
 #include "merge-recursive.h"
+#include "merge-ort-wrappers.h"
 #include "strvec.h"
 #include "run-command.h"
 #include "dir.h"
@@ -492,13 +493,13 @@ static void unstage_changes_unless_new(struct object_id *orig_tree)
 static int do_apply_stash(const char *prefix, struct stash_info *info,
 			  int index, int quiet)
 {
-	int ret;
+	int clean, ret;
 	int has_index = index;
 	struct merge_options o;
 	struct object_id c_tree;
 	struct object_id index_tree;
-	struct commit *result;
-	const struct object_id *bases[1];
+	struct tree *head, *merge, *merge_base;
+	struct lock_file lock = LOCK_INIT;
 
 	read_cache_preload(NULL);
 	if (refresh_and_write_cache(REFRESH_QUIET, 0, 0))
@@ -541,6 +542,7 @@ static int do_apply_stash(const char *prefix, struct stash_info *info,
 
 	o.branch1 = "Updated upstream";
 	o.branch2 = "Stashed changes";
+	o.ancestor = "Stash base";
 
 	if (oideq(&info->b_tree, &c_tree))
 		o.branch1 = "Version stash was based on";
@@ -551,10 +553,26 @@ static int do_apply_stash(const char *prefix, struct stash_info *info,
 	if (o.verbosity >= 3)
 		printf_ln(_("Merging %s with %s"), o.branch1, o.branch2);
 
-	bases[0] = &info->b_tree;
+	head = lookup_tree(o.repo, &c_tree);
+	merge = lookup_tree(o.repo, &info->w_tree);
+	merge_base = lookup_tree(o.repo, &info->b_tree);
+
+	repo_hold_locked_index(o.repo, &lock, LOCK_DIE_ON_ERROR);
+	clean = merge_ort_nonrecursive(&o, head, merge, merge_base);
+
+	/*
+	 * If 'clean' >= 0, reverse the value for 'ret' so 'ret' is 0 when the
+	 * merge was clean, and nonzero if the merge was unclean or encountered
+	 * an error.
+	 */
+	ret = clean >= 0 ? !clean : clean;
+
+	if (ret < 0)
+		rollback_lock_file(&lock);
+	else if (write_locked_index(o.repo->index, &lock,
+				      COMMIT_LOCK | SKIP_IF_UNCHANGED))
+		ret = error(_("could not write index"));
 
-	ret = merge_recursive_generic(&o, &c_tree, &info->w_tree, 1, bases,
-				      &result);
 	if (ret) {
 		rerere(0);
 
diff --git a/t/t1092-sparse-checkout-compatibility.sh b/t/t1092-sparse-checkout-compatibility.sh
index 85c6a56f1b7..aaf4d880dbc 100755
--- a/t/t1092-sparse-checkout-compatibility.sh
+++ b/t/t1092-sparse-checkout-compatibility.sh
@@ -1385,7 +1385,7 @@ test_expect_success 'sparse-index is not expanded: stash' '
 	ensure_not_expanded stash &&
 	ensure_not_expanded stash list &&
 	ensure_not_expanded stash show stash@{0} &&
-	! ensure_not_expanded stash apply stash@{0} &&
+	ensure_not_expanded stash apply stash@{0} &&
 	ensure_not_expanded stash drop stash@{0} &&
 
 	echo >>sparse-index/deep/new &&
@@ -1399,7 +1399,7 @@ test_expect_success 'sparse-index is not expanded: stash' '
 	oid=$(git -C sparse-index stash create) &&
 	ensure_not_expanded stash store -m "test" $oid &&
 	ensure_not_expanded reset --hard &&
-	! ensure_not_expanded stash pop
+	ensure_not_expanded stash pop
 '
 
 test_expect_success 'sparse index is not expanded: diff' '
-- 
gitgitgadget

