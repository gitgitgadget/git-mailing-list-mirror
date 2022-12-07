Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 26031C352A1
	for <git@archiver.kernel.org>; Wed,  7 Dec 2022 17:26:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230071AbiLGR0j (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 7 Dec 2022 12:26:39 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34000 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229969AbiLGR0G (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 7 Dec 2022 12:26:06 -0500
Received: from mail-wr1-x431.google.com (mail-wr1-x431.google.com [IPv6:2a00:1450:4864:20::431])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6C3846A771
        for <git@vger.kernel.org>; Wed,  7 Dec 2022 09:26:04 -0800 (PST)
Received: by mail-wr1-x431.google.com with SMTP id y16so29088745wrm.2
        for <git@vger.kernel.org>; Wed, 07 Dec 2022 09:26:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=O22MfRRRtoXbCAgJQHjyf/Tyih0cuI2+bKHpdzLx/Gs=;
        b=QmqVt8YZPJAfYy8RDvNSdF3E8NXxmJqSmqhyIG73hdC/tlMf2dL2eTZI6fvsikCUZy
         4X7/bT3bJpvXfnHyDBG/ar39Gd9VyaIhCnKkLQpaauoEsRART7gB1iAZk79ZBWFoLDaF
         or62hFtKJ4ILPYj8zu2BE7144Ohe3YvOtA+tJRQXaMCqyvdlk2bj6qSEm76vDEvRZgVH
         LM//0iqb4v4qz9hvqQ8Vo3NxE/1GDXWYAoiQje24Sm0V9DrE/EAHo6iQweoyasLb6NOK
         Op9I9qw7xtvcaxCw0hmOjWNRSp9Tb8Ge0gr3hTk2eLsUlG2tWz8tmAyEvGC6WHBGYUcu
         puLw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=O22MfRRRtoXbCAgJQHjyf/Tyih0cuI2+bKHpdzLx/Gs=;
        b=Tiok483fkkaQ3a5qiX/e+KmW2mtXa05urWcNlgISKj8AxQN80sx62IEqxODTryG10T
         OQg3Na+R6PakuNEF25+gFgKQsmuChR/Q4uonpohCcs+GdIPSiyw5Pm/az9daEkpdQ4OF
         Oq4lPGE7wEDG7AixkTHnXw+RY2IzsDQo0R4wm8bY2gL0+6dUpR2KpEBqfnfPtbiVvRRF
         SVGDyW1FnqHEj/8gWvlat1xGT7HHoTx9NQ87tVhv6La2ep8C9ciOBCMVLJqnpOD3aXTh
         69Yr4KN9Luq2LRWsONOPzmEHMy8bxhNL0uyZ57Hlzw4f32DEdO9lhoxZkTVfouV38qmf
         6hlA==
X-Gm-Message-State: ANoB5pne4FpeQrI/EY4QFbfz4exEdyjkiykOLGV5n/a5+f66OaHLGZrg
        BIvNnRiW6+k0VZqjCQp95cpc22T8GWE=
X-Google-Smtp-Source: AA0mqf4i5h6DPzJJZ0BoJlo6CSaZK3d0Wz69bIosMPOOysr4GsyXPUqXBI0pG1am4R7fyROstgQ/OQ==
X-Received: by 2002:a5d:6947:0:b0:242:17a5:ee80 with SMTP id r7-20020a5d6947000000b0024217a5ee80mr26946195wrw.628.1670433962669;
        Wed, 07 Dec 2022 09:26:02 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id z5-20020adff745000000b002383fc96509sm19732824wrp.47.2022.12.07.09.26.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 07 Dec 2022 09:26:02 -0800 (PST)
Message-Id: <77bf5d5ff27729a39ac00d52af3c09610d733b14.1670433958.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1439.git.1670433958.gitgitgadget@gmail.com>
References: <pull.1439.git.1670433958.gitgitgadget@gmail.com>
From:   "Derrick Stolee via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Wed, 07 Dec 2022 17:25:58 +0000
Subject: [PATCH 4/4] features: feature.manyFiles implies fast index writes
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     gitster@pobox.com, vdye@github.com, avarab@gmail.com,
        newren@gmail.com, Derrick Stolee <derrickstolee@github.com>,
        Derrick Stolee <derrickstolee@github.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Derrick Stolee <derrickstolee@github.com>

The recent addition of the index.skipHash config option allows index
writes to speed up by skipping the hash computation for the trailing
checksum. This is particularly critical for repositories with many files
at HEAD, so add this config option to two cases where users in that
scenario may opt-in to such behavior:

 1. The feature.manyFiles config option enables some options that are
    helpful for repositories with many files at HEAD.

 2. 'scalar register' and 'scalar reconfigure' set config options that
    optimize for large repositories.

In both of these cases, set index.skipHash=true to gain this
speedup. Add tests that demonstrate the proper way that
index.skipHash=true can override feature.manyFiles=true.

Signed-off-by: Derrick Stolee <derrickstolee@github.com>
---
 Documentation/config/feature.txt |  3 +++
 read-cache.c                     |  7 ++++---
 repo-settings.c                  |  2 ++
 repository.h                     |  1 +
 scalar.c                         |  1 +
 t/t1600-index.sh                 | 13 ++++++++++++-
 6 files changed, 23 insertions(+), 4 deletions(-)

diff --git a/Documentation/config/feature.txt b/Documentation/config/feature.txt
index 95975e50912..f0e1d4cb2be 100644
--- a/Documentation/config/feature.txt
+++ b/Documentation/config/feature.txt
@@ -23,6 +23,9 @@ feature.manyFiles::
 	working directory. With many files, commands such as `git status` and
 	`git checkout` may be slow and these new defaults improve performance:
 +
+* `index.skipHash=true` speeds up index writes by not computing a trailing
+  checksum.
++
 * `index.version=4` enables path-prefix compression in the index.
 +
 * `core.untrackedCache=true` enables the untracked cache. This setting assumes
diff --git a/read-cache.c b/read-cache.c
index fb4d6fb6387..1844953fba7 100644
--- a/read-cache.c
+++ b/read-cache.c
@@ -2923,12 +2923,13 @@ static int do_write_index(struct index_state *istate, struct tempfile *tempfile,
 	int ieot_entries = 1;
 	struct index_entry_offset_table *ieot = NULL;
 	int nr, nr_threads;
-	int skip_hash;
 
 	f = hashfd(tempfile->fd, tempfile->filename.buf);
 
-	if (!git_config_get_maybe_bool("index.skiphash", &skip_hash))
-		f->skip_hash = skip_hash;
+	if (istate->repo) {
+		prepare_repo_settings(istate->repo);
+		f->skip_hash = istate->repo->settings.index_skip_hash;
+	}
 
 	for (i = removed = extended = 0; i < entries; i++) {
 		if (cache[i]->ce_flags & CE_REMOVE)
diff --git a/repo-settings.c b/repo-settings.c
index 3021921c53d..3dbd3f0e2ec 100644
--- a/repo-settings.c
+++ b/repo-settings.c
@@ -47,6 +47,7 @@ void prepare_repo_settings(struct repository *r)
 	}
 	if (manyfiles) {
 		r->settings.index_version = 4;
+		r->settings.index_skip_hash = 1;
 		r->settings.core_untracked_cache = UNTRACKED_CACHE_WRITE;
 	}
 
@@ -61,6 +62,7 @@ void prepare_repo_settings(struct repository *r)
 	repo_cfg_bool(r, "pack.usesparse", &r->settings.pack_use_sparse, 1);
 	repo_cfg_bool(r, "core.multipackindex", &r->settings.core_multi_pack_index, 1);
 	repo_cfg_bool(r, "index.sparse", &r->settings.sparse_index, 0);
+	repo_cfg_bool(r, "index.skiphash", &r->settings.index_skip_hash, r->settings.index_skip_hash);
 
 	/*
 	 * The GIT_TEST_MULTI_PACK_INDEX variable is special in that
diff --git a/repository.h b/repository.h
index 6c461c5b9de..e8c67ffe165 100644
--- a/repository.h
+++ b/repository.h
@@ -42,6 +42,7 @@ struct repo_settings {
 	struct fsmonitor_settings *fsmonitor; /* lazily loaded */
 
 	int index_version;
+	int index_skip_hash;
 	enum untracked_cache_setting core_untracked_cache;
 
 	int pack_use_sparse;
diff --git a/scalar.c b/scalar.c
index 6c52243cdf1..b49bb8c24ec 100644
--- a/scalar.c
+++ b/scalar.c
@@ -143,6 +143,7 @@ static int set_recommended_config(int reconfigure)
 		{ "credential.validate", "false", 1 }, /* GCM4W-only */
 		{ "gc.auto", "0", 1 },
 		{ "gui.GCWarning", "false", 1 },
+		{ "index.skipHash", "false", 1 },
 		{ "index.threads", "true", 1 },
 		{ "index.version", "4", 1 },
 		{ "merge.stat", "false", 1 },
diff --git a/t/t1600-index.sh b/t/t1600-index.sh
index 55816756607..be0a0a8a008 100755
--- a/t/t1600-index.sh
+++ b/t/t1600-index.sh
@@ -72,7 +72,18 @@ test_expect_success 'index.skipHash config option' '
 		test_trailing_hash .git/index >hash &&
 		echo $(test_oid zero) >expect &&
 		test_cmp expect hash &&
-		git fsck
+		git fsck &&
+
+		rm -f .git/index &&
+		git -c feature.manyFiles=true add a &&
+		test_trailing_hash .git/index >hash &&
+		test_cmp expect hash &&
+
+		rm -f .git/index &&
+		git -c feature.manyFiles=true \
+		    -c index.skipHash=false add a &&
+		test_trailing_hash .git/index >hash &&
+		! test_cmp expect hash
 	)
 '
 
-- 
gitgitgadget
