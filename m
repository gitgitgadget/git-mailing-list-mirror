Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6EFA8C433EF
	for <git@archiver.kernel.org>; Wed, 27 Apr 2022 18:16:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244731AbiD0ST7 (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 27 Apr 2022 14:19:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42504 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244679AbiD0STv (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 27 Apr 2022 14:19:51 -0400
Received: from mail-wr1-x433.google.com (mail-wr1-x433.google.com [IPv6:2a00:1450:4864:20::433])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 410772C661
        for <git@vger.kernel.org>; Wed, 27 Apr 2022 11:16:29 -0700 (PDT)
Received: by mail-wr1-x433.google.com with SMTP id d5so3641680wrb.6
        for <git@vger.kernel.org>; Wed, 27 Apr 2022 11:16:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=1qAvMrK9QQnFN1vnNGvpGaSBmcFGP+U1S3g7XKOBhP8=;
        b=GD8TEd1lKE5m1qL41CPdKishTO5/CoNDkQZHzt016D6xgFsFSVj44zSvOsVvCt0gSb
         AK1hPVPZxzg5ANgXR3odO4k5b1nlY15lgJGVzlF6rQoP3RLqMz1dE1S8pN25Q6D9Pjgz
         vuWr4jevsV41xPS6YwosQ4UZnKI8eS8JTICzeejJW4ucFGg/dr2oRJJV59gCDfe1NAuk
         VXSv2kThwb6xPG4lhid+ItGFBtwGJXd/O2ImV3I04SyAv6ZxPsMKcWwc1AMnL9bjHMfR
         oF0eqfTGgNWT1QQTueATcYjY6ENGFpvs083Y6Hjn26mqdZmyNpHbUkHXUs3Q/5U6+ZcK
         7DFA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=1qAvMrK9QQnFN1vnNGvpGaSBmcFGP+U1S3g7XKOBhP8=;
        b=DEbk0moR7vsCQqWfhtuDdqqeKxw8MnzkvBJF3nvXfp06WTIXakv+sF+oYzX7T2DoSz
         B35JtPrnHJLfQ2VOFD6G6sHVNmVgSWt0xQyK5MZ5neyxjz/54McPPWiFbXlgqwsLdAA6
         SEdDMu+Q5Pq577ZjFqIFPrvpx5B8tfa0T3FD0YKSD7kKbOHAFhe4YYpy/8eoUP8Xgf3t
         422q3WnMYsN7VpYpvvsIvRK2SlMWczVHKaQT3ao4tAnZyIrw1dgS/kTOfQp3KKVV4hxE
         uEXBDRbdK08V3xfsLciwdUJjmRtXIYjBjDfHOdwmNdwei5TAvqWeBXy9TR6UW83otXOv
         oBEQ==
X-Gm-Message-State: AOAM530lEY1ypucT1O6nmJHh2568Fr9c+AO47TloLgsOEpXM7L/HF0s8
        ZGU3t0xlVbxqrtvnc76KFbUJdEmSoU0=
X-Google-Smtp-Source: ABdhPJzRrvSJ7276T+xo7vHx3t5LvRiPNuQOtcDJiPYLOYurAauWAu+/Yv7kL0DBgIxbcEmteEQLmQ==
X-Received: by 2002:a5d:6dd1:0:b0:207:92c4:eaef with SMTP id d17-20020a5d6dd1000000b0020792c4eaefmr23784867wrz.498.1651083387327;
        Wed, 27 Apr 2022 11:16:27 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id p4-20020a1c5444000000b00391ca5976c8sm2603334wmi.0.2022.04.27.11.16.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 27 Apr 2022 11:16:26 -0700 (PDT)
Message-Id: <4537d473b937b182cd79b2f3c5673b75d92cab23.1651083378.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1171.v2.git.1651083378.gitgitgadget@gmail.com>
References: <pull.1171.git.1650908957.gitgitgadget@gmail.com>
        <pull.1171.v2.git.1651083378.gitgitgadget@gmail.com>
From:   "Victoria Dye via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Wed, 27 Apr 2022 18:16:16 +0000
Subject: [PATCH v2 5/7] merge-recursive: add merge function arg to
 'merge_recursive_generic'
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

Replace the hardcoded 'merge_recursive()' function used by the
'merge_recursive_generic()' with a caller-specific merge function. This will
allow us to use 'merge_ort_recursive()' (and therefore avoid the index
expansion of 'merge_recursive()') in commands that perform merges with
'merge_recursive_generic()', such as 'git stash pop'.

Note that this patch is strictly a refactor; all callers still use
'merge_recursive()', and any changing to 'merge_ort_recursive()' will be
done in a later commit.

Signed-off-by: Victoria Dye <vdye@github.com>
---
 builtin/am.c              | 2 +-
 builtin/merge-recursive.c | 2 +-
 builtin/stash.c           | 2 +-
 merge-ort.c               | 3 ++-
 merge-recursive.c         | 4 ++--
 merge-recursive.h         | 9 ++++++++-
 6 files changed, 15 insertions(+), 7 deletions(-)

diff --git a/builtin/am.c b/builtin/am.c
index 0f4111bafa0..6d01185d122 100644
--- a/builtin/am.c
+++ b/builtin/am.c
@@ -1614,7 +1614,7 @@ static int fall_back_threeway(const struct am_state *state, const char *index_pa
 	if (state->quiet)
 		o.verbosity = 0;
 
-	if (merge_recursive_generic(&o, &our_tree, &their_tree, 1, bases, &result)) {
+	if (merge_recursive_generic(&o, &our_tree, &their_tree, 1, bases, merge_recursive, &result)) {
 		repo_rerere(the_repository, state->allow_rerere_autoupdate);
 		free(their_tree_name);
 		return error(_("Failed to merge in the changes."));
diff --git a/builtin/merge-recursive.c b/builtin/merge-recursive.c
index b9acbf5d342..687ed1e527b 100644
--- a/builtin/merge-recursive.c
+++ b/builtin/merge-recursive.c
@@ -81,7 +81,7 @@ int cmd_merge_recursive(int argc, const char **argv, const char *prefix)
 	if (o.verbosity >= 3)
 		printf(_("Merging %s with %s\n"), o.branch1, o.branch2);
 
-	failed = merge_recursive_generic(&o, &h1, &h2, bases_count, bases, &result);
+	failed = merge_recursive_generic(&o, &h1, &h2, bases_count, bases, merge_recursive, &result);
 
 	free(better1);
 	free(better2);
diff --git a/builtin/stash.c b/builtin/stash.c
index 1bfba532044..16171eb1dab 100644
--- a/builtin/stash.c
+++ b/builtin/stash.c
@@ -554,7 +554,7 @@ static int do_apply_stash(const char *prefix, struct stash_info *info,
 	bases[0] = &info->b_tree;
 
 	ret = merge_recursive_generic(&o, &c_tree, &info->w_tree, 1, bases,
-				      &result);
+				      merge_recursive, &result);
 	if (ret) {
 		rerere(0);
 
diff --git a/merge-ort.c b/merge-ort.c
index 8545354dafd..4bccdfcf355 100644
--- a/merge-ort.c
+++ b/merge-ort.c
@@ -4737,7 +4737,8 @@ void merge_incore_recursive(struct merge_options *opt,
 	trace2_region_enter("merge", "incore_recursive", opt->repo);
 
 	/* We set the ancestor label based on the merge_bases */
-	assert(opt->ancestor == NULL);
+	assert(opt->ancestor == NULL ||
+	       !strcmp(opt->ancestor, "constructed merge base"));
 
 	trace2_region_enter("merge", "merge_start", opt->repo);
 	merge_start(opt, result);
diff --git a/merge-recursive.c b/merge-recursive.c
index 1ee6364e8b1..2088f5c5fb3 100644
--- a/merge-recursive.c
+++ b/merge-recursive.c
@@ -3806,6 +3806,7 @@ int merge_recursive_generic(struct merge_options *opt,
 			    const struct object_id *merge,
 			    int num_merge_bases,
 			    const struct object_id **merge_bases,
+			    recursive_merge_fn_t merge_fn,
 			    struct commit **result)
 {
 	int clean;
@@ -3829,8 +3830,7 @@ int merge_recursive_generic(struct merge_options *opt,
 	}
 
 	repo_hold_locked_index(opt->repo, &lock, LOCK_DIE_ON_ERROR);
-	clean = merge_recursive(opt, head_commit, next_commit, ca,
-				result);
+	clean = merge_fn(opt, head_commit, next_commit, ca, result);
 	if (clean < 0) {
 		rollback_lock_file(&lock);
 		return clean;
diff --git a/merge-recursive.h b/merge-recursive.h
index b88000e3c25..6a21f2da538 100644
--- a/merge-recursive.h
+++ b/merge-recursive.h
@@ -53,6 +53,12 @@ struct merge_options {
 	struct merge_options_internal *priv;
 };
 
+typedef int (*recursive_merge_fn_t)(struct merge_options *opt,
+				    struct commit *h1,
+				    struct commit *h2,
+				    struct commit_list *merge_bases,
+				    struct commit **result);
+
 void init_merge_options(struct merge_options *opt, struct repository *repo);
 
 /* parse the option in s and update the relevant field of opt */
@@ -105,7 +111,7 @@ int merge_recursive(struct merge_options *opt,
 
 /*
  * merge_recursive_generic can operate on trees instead of commits, by
- * wrapping the trees into virtual commits, and calling merge_recursive().
+ * wrapping the trees into virtual commits, and calling the provided merge_fn.
  * It also writes out the in-memory index to disk if the merge is successful.
  *
  * Outputs:
@@ -120,6 +126,7 @@ int merge_recursive_generic(struct merge_options *opt,
 			    const struct object_id *merge,
 			    int num_merge_bases,
 			    const struct object_id **merge_bases,
+			    recursive_merge_fn_t merge_fn,
 			    struct commit **result);
 
 #endif
-- 
gitgitgadget

