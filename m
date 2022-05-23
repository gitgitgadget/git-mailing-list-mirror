Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DC905C433EF
	for <git@archiver.kernel.org>; Mon, 23 May 2022 13:49:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236717AbiEWNtF (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 23 May 2022 09:49:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41672 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236668AbiEWNs5 (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 23 May 2022 09:48:57 -0400
Received: from mail-wr1-x42a.google.com (mail-wr1-x42a.google.com [IPv6:2a00:1450:4864:20::42a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C2D23562DE
        for <git@vger.kernel.org>; Mon, 23 May 2022 06:48:55 -0700 (PDT)
Received: by mail-wr1-x42a.google.com with SMTP id h5so20334579wrb.11
        for <git@vger.kernel.org>; Mon, 23 May 2022 06:48:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=PzcezCpmXzCVNgqBLunvHr3HL+2W8ZouqZBn4pMXpHQ=;
        b=H63jVCLUqGB9tP+3VQZy8gPJ3tPLb6hI9TFk4zKoU60yuKdTgcPO8LBc2e3+8FnucR
         THThJkk6IfeH8GecYBEJWv90yOYHt82GRjZCYualO73ui44OilTB6vjjR4rn4i5963KL
         GW6XuBIrdRgh3kX46NvwHfTTCZseUE2c6NpFZWSKZuxNP+W4MatigUTBlNBHxDTiBGBE
         KguMPPvgf1YTpuX7IQ+FmfKUGQwQ4o0nOC1gla4hW0NezsnyP8XxKrkteF2lJ2Qy+8KD
         GM+MABiDSMuFo1D3eo+yL98L1QPeqJIkx2lsSWRJ/wPNhRjYklV04tGO2BPn7dTjWK26
         m38w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=PzcezCpmXzCVNgqBLunvHr3HL+2W8ZouqZBn4pMXpHQ=;
        b=kr9kYF8QBOUT8co67KRYjKgzyPzHFyMb051Ul8uuFnxGKjfUbx76GI6cY7nvsPdOVH
         w0VI5hFGiGqoTEGlhYny/ijeC3Kh52PyIBNwZLm5183LmUTTDpS7+HjYuFRPCgOeDoSa
         WwRj1G8NJC9Ea3Jil77sArJBT0Nc1w6QH4F4Nq2vrvexAcQFX/XyYl5pp25TUqW46XKO
         oNprgkKqrPsvsFGNMDul8q3mPN1rjWTDzHaFuIDfQa325wesZk1GdYkYGWGSyw1Sra99
         xfMTvr355EKJbXA6ATesgIB6bAuOovNHe03q4PTAsr8tp5ZsiYOBfiB/0t6FtoFAfhmU
         1mMQ==
X-Gm-Message-State: AOAM5314vhIVNr8yTA9GogI/BPMiLBVNeVv7I8ddf/BHnuxb/4xoakSj
        gCbvWxhaSfdzMsUIV2bI8BkL7FCKT7w=
X-Google-Smtp-Source: ABdhPJwvzyNSTBtQiMIN9KkK89oWYymLsuvdQGC7Lb0cX/MQOaSDZnyd+TtHiGTUJkJNJEb+GuABhA==
X-Received: by 2002:a5d:618f:0:b0:20c:ffa0:95a8 with SMTP id j15-20020a5d618f000000b0020cffa095a8mr19018996wru.306.1653313733922;
        Mon, 23 May 2022 06:48:53 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id y14-20020a1c4b0e000000b003974df805c7sm1967757wma.8.2022.05.23.06.48.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 23 May 2022 06:48:53 -0700 (PDT)
Message-Id: <8a459d6c67d2cd2cb6f5e6a7d2ea1bff29adb883.1653313726.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1208.v3.git.1653313726.gitgitgadget@gmail.com>
References: <pull.1208.v2.git.1652982758.gitgitgadget@gmail.com>
        <pull.1208.v3.git.1653313726.gitgitgadget@gmail.com>
From:   "Derrick Stolee via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Mon, 23 May 2022 13:48:40 +0000
Subject: [PATCH v3 04/10] sparse-index: introduce partially-sparse indexes
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

A future change will present a temporary, in-memory mode where the index
can both contain sparse directory entries but also not be completely
collapsed to the smallest possible sparse directories. This will be
necessary for modifying the sparse-checkout definition while using a
sparse index.

For now, convert the single-bit member 'sparse_index' in 'struct
index_state' to be a an 'enum sparse_index_mode' with three modes:

* INDEX_EXPANDED (0): No sparse directories exist. This is always the
  case for repositories that do not use cone-mode sparse-checkout.

* INDEX_COLLAPSED: Sparse directories may exist. Files outside the
  sparse-checkout cone are reduced to sparse directory entries whenever
  possible.

* INDEX_PARTIALLY_SPARSE: Sparse directories may exist. Some file
  entries outside the sparse-checkout cone may exist. Running
  convert_to_sparse() may further reduce those files to sparse directory
  entries.

The main reason to store this extra information is to allow
convert_to_sparse() to short-circuit when the index is already in
INDEX_EXPANDED mode but to actually do the necessary work when in
INDEX_PARTIALLY_SPARSE mode.

The INDEX_PARTIALLY_SPARSE mode will be used in an upcoming change.

Signed-off-by: Derrick Stolee <derrickstolee@github.com>
---
 builtin/sparse-checkout.c |  2 +-
 cache.h                   | 33 +++++++++++++++++++++++++--------
 read-cache.c              |  6 +++---
 sparse-index.c            |  6 +++---
 4 files changed, 32 insertions(+), 15 deletions(-)

diff --git a/builtin/sparse-checkout.c b/builtin/sparse-checkout.c
index 0217d44c5b1..5b054400bf3 100644
--- a/builtin/sparse-checkout.c
+++ b/builtin/sparse-checkout.c
@@ -128,7 +128,7 @@ static void clean_tracked_sparse_directories(struct repository *r)
 	 * sparse index will not delete directories that contain
 	 * conflicted entries or submodules.
 	 */
-	if (!r->index->sparse_index) {
+	if (r->index->sparse_index == INDEX_EXPANDED) {
 		/*
 		 * If something, such as a merge conflict or other concern,
 		 * prevents us from converting to a sparse index, then do
diff --git a/cache.h b/cache.h
index 6226f6a8a53..e171ce882a2 100644
--- a/cache.h
+++ b/cache.h
@@ -310,6 +310,29 @@ struct untracked_cache;
 struct progress;
 struct pattern_list;
 
+enum sparse_index_mode {
+	/*
+	 * There are no sparse directories in the index at all.
+	 *
+	 * Repositories that don't use cone-mode sparse-checkout will
+	 * always have their indexes in this mode.
+	 */
+	INDEX_EXPANDED = 0,
+
+	/*
+	 * The index has already been collapsed to sparse directories
+	 * whereever possible.
+	 */
+	INDEX_COLLAPSED,
+
+	/*
+	 * The sparse directories that exist are outside the
+	 * sparse-checkout boundary, but it is possible that some file
+	 * entries could collapse to sparse directory entries.
+	 */
+	INDEX_PARTIALLY_SPARSE,
+};
+
 struct index_state {
 	struct cache_entry **cache;
 	unsigned int version;
@@ -323,14 +346,8 @@ struct index_state {
 		 drop_cache_tree : 1,
 		 updated_workdir : 1,
 		 updated_skipworktree : 1,
-		 fsmonitor_has_run_once : 1,
-
-		 /*
-		  * sparse_index == 1 when sparse-directory
-		  * entries exist. Requires sparse-checkout
-		  * in cone mode.
-		  */
-		 sparse_index : 1;
+		 fsmonitor_has_run_once : 1;
+	enum sparse_index_mode sparse_index;
 	struct hashmap name_hash;
 	struct hashmap dir_hash;
 	struct object_id oid;
diff --git a/read-cache.c b/read-cache.c
index 4df97e185e9..b236042eee1 100644
--- a/read-cache.c
+++ b/read-cache.c
@@ -112,7 +112,7 @@ static const char *alternate_index_output;
 static void set_index_entry(struct index_state *istate, int nr, struct cache_entry *ce)
 {
 	if (S_ISSPARSEDIR(ce->ce_mode))
-		istate->sparse_index = 1;
+		istate->sparse_index = INDEX_COLLAPSED;
 
 	istate->cache[nr] = ce;
 	add_name_hash(istate, ce);
@@ -1856,7 +1856,7 @@ static int read_index_extension(struct index_state *istate,
 		break;
 	case CACHE_EXT_SPARSE_DIRECTORIES:
 		/* no content, only an indicator */
-		istate->sparse_index = 1;
+		istate->sparse_index = INDEX_COLLAPSED;
 		break;
 	default:
 		if (*ext < 'A' || 'Z' < *ext)
@@ -3149,7 +3149,7 @@ static int do_write_locked_index(struct index_state *istate, struct lock_file *l
 				 unsigned flags)
 {
 	int ret;
-	int was_full = !istate->sparse_index;
+	int was_full = istate->sparse_index == INDEX_EXPANDED;
 
 	ret = convert_to_sparse(istate, 0);
 
diff --git a/sparse-index.c b/sparse-index.c
index a11b5cf1314..7848910c154 100644
--- a/sparse-index.c
+++ b/sparse-index.c
@@ -173,7 +173,7 @@ int convert_to_sparse(struct index_state *istate, int flags)
 	 * If the index is already sparse, empty, or otherwise
 	 * cannot be converted to sparse, do not convert.
 	 */
-	if (istate->sparse_index || !istate->cache_nr ||
+	if (istate->sparse_index == INDEX_COLLAPSED || !istate->cache_nr ||
 	    !is_sparse_index_allowed(istate, flags))
 		return 0;
 
@@ -214,7 +214,7 @@ int convert_to_sparse(struct index_state *istate, int flags)
 	FREE_AND_NULL(istate->fsmonitor_dirty);
 	FREE_AND_NULL(istate->fsmonitor_last_update);
 
-	istate->sparse_index = 1;
+	istate->sparse_index = INDEX_COLLAPSED;
 	trace2_region_leave("index", "convert_to_sparse", istate->repo);
 	return 0;
 }
@@ -259,7 +259,7 @@ void expand_index(struct index_state *istate, struct pattern_list *pl)
 	 * If the index is already full, then keep it full. We will convert
 	 * it to a sparse index on write, if possible.
 	 */
-	if (!istate || !istate->sparse_index)
+	if (!istate || istate->sparse_index == INDEX_EXPANDED)
 		return;
 
 	/*
-- 
gitgitgadget

