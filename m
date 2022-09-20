Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 979CDC54EE9
	for <git@archiver.kernel.org>; Tue, 20 Sep 2022 05:59:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230331AbiITF7B (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 20 Sep 2022 01:59:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54704 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230306AbiITF6e (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 20 Sep 2022 01:58:34 -0400
Received: from mail-wm1-x333.google.com (mail-wm1-x333.google.com [IPv6:2a00:1450:4864:20::333])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C7F4E3CBC0
        for <git@vger.kernel.org>; Mon, 19 Sep 2022 22:58:30 -0700 (PDT)
Received: by mail-wm1-x333.google.com with SMTP id e18so1081291wmq.3
        for <git@vger.kernel.org>; Mon, 19 Sep 2022 22:58:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date;
        bh=vwOX/ZCi8G+wlKKOmWBCsYtzxhzukrNNITBOu2uKXNk=;
        b=auk29UXwTQlq0EcVU1VtTFxEuF3g5Am4AyHp37PioMjED3CYZGKHEDzXwXSfIewGkZ
         U0neNIl/69nYFlWMBBH6rTreikeLCfIsPaoGs8euPul0yWkKNrrwTUB12SEjYmCXNNrB
         kyMQxXTACD6ffY1V5lDwg3tWzadPKyp+P0agnAcr0aKlZPw8QtIY+ZrGSNuY/4jOZG6d
         UjyPHDGxfCRH1grmzKZ1z2Z/SIcDVZCCmVUcE1IDKu3c9ARNqlHN8ac7zHvVhTfxV+ph
         mDVuVeaLG3S0QB8cgGWrqDToiovPULLGvC+3X+TOTKC+QB7l09R+frDxv/DAOdJqMhCp
         LeFQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-message-state:from:to:cc
         :subject:date;
        bh=vwOX/ZCi8G+wlKKOmWBCsYtzxhzukrNNITBOu2uKXNk=;
        b=gMuEPBNi9nW9jZKoX6ouk0v4VFw9eQOuxnubDTK2VsnR5XtYaQoatgND8atYhpMQJa
         WAfkZo4DPU2UTGuoH/zLSebtdfJigi4MK/AaDD+l5JqBiIHyrRLPGgliCvcRQGR1ZYAE
         8X3SigacACuqwdd0XSFAQjSjjTUGPEmKXTWoXEZng6S7R6EHxF4L8ZfNi1hjCS1DImih
         63nHovC02sp+paiMQEYINKBpLhZoHTM7m+GCTYWF3KOAcKeBzHPsB249ip6PlTkRCI3i
         oQixLeDHQn9Usd/zM70cQdZtZXCHPESP9gOHf63MGdEkdadxoAZkts5QuFPyvqgcF7z1
         jD1A==
X-Gm-Message-State: ACrzQf13+OhkTrE61a0AcweS0HL1PV2K1FEsMGg4wcq+ShGfrctqX5bV
        LXoGaU2o63LpF4vlIAKUNos0hYi2IVM=
X-Google-Smtp-Source: AMsMyM5f3k2W65PJIaZGwFZtgF6zw42lrLKJnKB/iS7yVbu+vMeiONH9ZWghMprFbJ5aQMWgQO2C+g==
X-Received: by 2002:a05:600c:1c8e:b0:3b4:9247:7ecc with SMTP id k14-20020a05600c1c8e00b003b492477eccmr1088399wms.40.1663653508686;
        Mon, 19 Sep 2022 22:58:28 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id d9-20020a05600c34c900b003a844885f88sm982068wmq.22.2022.09.19.22.58.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 19 Sep 2022 22:58:28 -0700 (PDT)
Message-Id: <6abb1ced1bde21098502342fcb776fe6805a7873.1663653506.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1359.git.1663653505.gitgitgadget@gmail.com>
References: <pull.1359.git.1663653505.gitgitgadget@gmail.com>
From:   "Jerry Zhang via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Tue, 20 Sep 2022 05:58:25 +0000
Subject: [PATCH 2/2] patch-id: use stable patch-id for rebases
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Jerry Zhang <jerry@skydio.com>, Jerry Zhang <jerry@skydio.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Jerry Zhang <jerry@skydio.com>

Git doesn't persist patch-ids during the rebase process, so there is
no need to specifically invoke the unstable variant.

This allows the legacy unstable id logic to be cleaned up.

Signed-off-by: Jerry Zhang <jerry@skydio.com>
---
 builtin/log.c |  2 +-
 diff.c        | 12 ++++--------
 diff.h        |  2 +-
 patch-ids.c   | 10 +++++-----
 patch-ids.h   |  2 +-
 5 files changed, 12 insertions(+), 16 deletions(-)

diff --git a/builtin/log.c b/builtin/log.c
index 047f9e5278d..3bb49fd7406 100644
--- a/builtin/log.c
+++ b/builtin/log.c
@@ -1762,7 +1762,7 @@ static void prepare_bases(struct base_tree_info *bases,
 		struct object_id *patch_id;
 		if (*commit_base_at(&commit_base, commit))
 			continue;
-		if (commit_patch_id(commit, &diffopt, &oid, 0, 1))
+		if (commit_patch_id(commit, &diffopt, &oid, 0))
 			die(_("cannot get patch id"));
 		ALLOC_GROW(bases->patch_id, bases->nr_patch_id + 1, bases->alloc_patch_id);
 		patch_id = bases->patch_id + bases->nr_patch_id;
diff --git a/diff.c b/diff.c
index 2f8f0c2e4f4..8c46531cd44 100644
--- a/diff.c
+++ b/diff.c
@@ -6185,7 +6185,7 @@ static void patch_id_add_mode(git_hash_ctx *ctx, unsigned mode)
 }
 
 /* returns 0 upon success, and writes result into oid */
-static int diff_get_patch_id(struct diff_options *options, struct object_id *oid, int diff_header_only, int stable)
+static int diff_get_patch_id(struct diff_options *options, struct object_id *oid, int diff_header_only)
 {
 	struct diff_queue_struct *q = &diff_queued_diff;
 	int i;
@@ -6268,21 +6268,17 @@ static int diff_get_patch_id(struct diff_options *options, struct object_id *oid
 				return error("unable to generate patch-id diff for %s",
 					     p->one->path);
 		}
-		if (stable)
-			flush_one_hunk(oid, &ctx);
+		flush_one_hunk(oid, &ctx);
 	}
 
-	if (!stable)
-		the_hash_algo->final_oid_fn(oid, &ctx);
-
 	return 0;
 }
 
-int diff_flush_patch_id(struct diff_options *options, struct object_id *oid, int diff_header_only, int stable)
+int diff_flush_patch_id(struct diff_options *options, struct object_id *oid, int diff_header_only)
 {
 	struct diff_queue_struct *q = &diff_queued_diff;
 	int i;
-	int result = diff_get_patch_id(options, oid, diff_header_only, stable);
+	int result = diff_get_patch_id(options, oid, diff_header_only);
 
 	for (i = 0; i < q->nr; i++)
 		diff_free_filepair(q->queue[i]);
diff --git a/diff.h b/diff.h
index 8ae18e5ab1e..fd33caeb25d 100644
--- a/diff.h
+++ b/diff.h
@@ -634,7 +634,7 @@ int run_diff_files(struct rev_info *revs, unsigned int option);
 int run_diff_index(struct rev_info *revs, unsigned int option);
 
 int do_diff_cache(const struct object_id *, struct diff_options *);
-int diff_flush_patch_id(struct diff_options *, struct object_id *, int, int);
+int diff_flush_patch_id(struct diff_options *, struct object_id *, int);
 void flush_one_hunk(struct object_id *result, git_hash_ctx *ctx);
 
 int diff_result_code(struct diff_options *, int);
diff --git a/patch-ids.c b/patch-ids.c
index 8bf425555de..fefddc487e9 100644
--- a/patch-ids.c
+++ b/patch-ids.c
@@ -11,7 +11,7 @@ static int patch_id_defined(struct commit *commit)
 }
 
 int commit_patch_id(struct commit *commit, struct diff_options *options,
-		    struct object_id *oid, int diff_header_only, int stable)
+		    struct object_id *oid, int diff_header_only)
 {
 	if (!patch_id_defined(commit))
 		return -1;
@@ -22,7 +22,7 @@ int commit_patch_id(struct commit *commit, struct diff_options *options,
 	else
 		diff_root_tree_oid(&commit->object.oid, "", options);
 	diffcore_std(options);
-	return diff_flush_patch_id(options, oid, diff_header_only, stable);
+	return diff_flush_patch_id(options, oid, diff_header_only);
 }
 
 /*
@@ -48,11 +48,11 @@ static int patch_id_neq(const void *cmpfn_data,
 	b = container_of(entry_or_key, struct patch_id, ent);
 
 	if (is_null_oid(&a->patch_id) &&
-	    commit_patch_id(a->commit, opt, &a->patch_id, 0, 0))
+	    commit_patch_id(a->commit, opt, &a->patch_id, 0))
 		return error("Could not get patch ID for %s",
 			oid_to_hex(&a->commit->object.oid));
 	if (is_null_oid(&b->patch_id) &&
-	    commit_patch_id(b->commit, opt, &b->patch_id, 0, 0))
+	    commit_patch_id(b->commit, opt, &b->patch_id, 0))
 		return error("Could not get patch ID for %s",
 			oid_to_hex(&b->commit->object.oid));
 	return !oideq(&a->patch_id, &b->patch_id);
@@ -82,7 +82,7 @@ static int init_patch_id_entry(struct patch_id *patch,
 	struct object_id header_only_patch_id;
 
 	patch->commit = commit;
-	if (commit_patch_id(commit, &ids->diffopts, &header_only_patch_id, 1, 0))
+	if (commit_patch_id(commit, &ids->diffopts, &header_only_patch_id, 1))
 		return -1;
 
 	hashmap_entry_init(&patch->ent, oidhash(&header_only_patch_id));
diff --git a/patch-ids.h b/patch-ids.h
index ab6c6a68047..490d7393716 100644
--- a/patch-ids.h
+++ b/patch-ids.h
@@ -20,7 +20,7 @@ struct patch_ids {
 };
 
 int commit_patch_id(struct commit *commit, struct diff_options *options,
-		    struct object_id *oid, int, int);
+		    struct object_id *oid, int);
 int init_patch_ids(struct repository *, struct patch_ids *);
 int free_patch_ids(struct patch_ids *);
 
-- 
gitgitgadget
