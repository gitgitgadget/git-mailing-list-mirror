Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3AAEBC433FE
	for <git@archiver.kernel.org>; Tue, 11 Jan 2022 18:07:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1350160AbiAKSG6 (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 11 Jan 2022 13:06:58 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51670 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1350384AbiAKSGB (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 11 Jan 2022 13:06:01 -0500
Received: from mail-wm1-x334.google.com (mail-wm1-x334.google.com [IPv6:2a00:1450:4864:20::334])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9E1C5C034004
        for <git@vger.kernel.org>; Tue, 11 Jan 2022 10:05:17 -0800 (PST)
Received: by mail-wm1-x334.google.com with SMTP id p1-20020a1c7401000000b00345c2d068bdso1961329wmc.3
        for <git@vger.kernel.org>; Tue, 11 Jan 2022 10:05:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=vgtL8S/eAgndCV0d3/fTMEM5ZElz0rglN71Y5wY0Wqk=;
        b=AcWO0IrfXf48CxNaj1YAHSpyLT/cEWg1rbY7DL3Qx+Qyqg8VAWfyzwOfsRZeC2ZS74
         EEDLumCxdPJElRZiZ3M8GR55o7an922jRWKWMYUmpNV9NXq9S8oaUJVB5etXzHhEfNQh
         J0SwRdq8mCTRHKD8YdxovJDtbCoyGganOK++tVM41vsIt/zc3VAnM1ZicYilpvYZz/J0
         5zUc/ML3gCI29jE/u8FrWCjLo0fkIgRkIghpElNLLJULHYlrMBS+956hsHuPbukKWD9N
         cySoOnzR6ajDpGWupodNuIU+G68iJ/tou9Clmp/1UPmggfcXt2E7XjAdflBRMXWXf0Fo
         2fPQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=vgtL8S/eAgndCV0d3/fTMEM5ZElz0rglN71Y5wY0Wqk=;
        b=ZDomjNxVLXrUc/e143Rt9SbvuWkx2h9Bi6oQVfTTtCGg3pI4chhyLSR+jbodRp3Tpy
         nA1+IZBcT0UkrEIJ/Lgc2g1jwn27gSUL4Jj8dt1pkeFtnVfSeOFj7rEwktjhMeegMZyl
         KdOq0B6vFnkM1cGA+0Cl9BcYHRVzXL+RQPpMNfRrFJON8Llhjj6caCYvXQXBOhWSq5k4
         4Jyye1KKRMm7wl8bB9JCkSM5FA4dBJmbJ5KizHC7WZkP1kLrJtbfpIBKqaO6iIKfEEcy
         MtWNfNXb/p+32GjGMp+Cgpldx8DcU17J/8MTvmO6dxIA8rR1KpKL8ZR0c18pf125CGe9
         FeLQ==
X-Gm-Message-State: AOAM531TvWLHVoNdaiPFhfLpLv3bILOctLkJvd+GvaTP+jRsVjGUpwKS
        BCJ3pFcvFHRPCKRLjZLZwx1HfHqAnv8=
X-Google-Smtp-Source: ABdhPJwdzPJadVvZfBGwm+vOtiWC7J2N3JOhZJPyANPn7btnvIhPGXJwag8UAKEVq/ejasWR0opd1g==
X-Received: by 2002:a05:600c:35d3:: with SMTP id r19mr3477727wmq.29.1641924316087;
        Tue, 11 Jan 2022 10:05:16 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id o15sm11436969wri.106.2022.01.11.10.05.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 11 Jan 2022 10:05:15 -0800 (PST)
Message-Id: <9ddc51a47d50dcce219b6c88c85797b4818b7456.1641924306.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1109.v2.git.1641924306.gitgitgadget@gmail.com>
References: <pull.1109.git.1641317820.gitgitgadget@gmail.com>
        <pull.1109.v2.git.1641924306.gitgitgadget@gmail.com>
From:   "Victoria Dye via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Tue, 11 Jan 2022 18:05:05 +0000
Subject: [PATCH v2 8/9] update-index: integrate with sparse index
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     stolee@gmail.com, newren@gmail.com, gitster@pobox.com,
        Victoria Dye <vdye@github.com>, Victoria Dye <vdye@github.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Victoria Dye <vdye@github.com>

Enable use of the sparse index with `update-index`. Most variations of
`update-index` work without explicitly expanding the index or making any
other updates in or outside of `update-index.c`.

The one usage requiring additional changes is `--cacheinfo`; if a file
inside a sparse directory was specified, the index would not be expanded
until after the cache tree is invalidated, leading to a mismatch between the
index and cache tree. This scenario is handled by rearranging
`add_index_entry_with_check`, allowing `index_name_stage_pos` to expand the
index *before* attempting to invalidate the relevant cache tree path,
avoiding cache tree/index corruption.

Signed-off-by: Victoria Dye <vdye@github.com>
---
 builtin/update-index.c                   |  3 +++
 read-cache.c                             | 10 +++++++---
 t/t1092-sparse-checkout-compatibility.sh | 15 +++++++++++++++
 3 files changed, 25 insertions(+), 3 deletions(-)

diff --git a/builtin/update-index.c b/builtin/update-index.c
index 187203e8bb5..605cc693bbd 100644
--- a/builtin/update-index.c
+++ b/builtin/update-index.c
@@ -1077,6 +1077,9 @@ int cmd_update_index(int argc, const char **argv, const char *prefix)
 
 	git_config(git_default_config, NULL);
 
+	prepare_repo_settings(r);
+	the_repository->settings.command_requires_full_index = 0;
+
 	/* we will diagnose later if it turns out that we need to update it */
 	newfd = hold_locked_index(&lock_file, 0);
 	if (newfd < 0)
diff --git a/read-cache.c b/read-cache.c
index cbe73f14e5e..b4600e954b6 100644
--- a/read-cache.c
+++ b/read-cache.c
@@ -1339,9 +1339,6 @@ static int add_index_entry_with_check(struct index_state *istate, struct cache_e
 	int skip_df_check = option & ADD_CACHE_SKIP_DFCHECK;
 	int new_only = option & ADD_CACHE_NEW_ONLY;
 
-	if (!(option & ADD_CACHE_KEEP_CACHE_TREE))
-		cache_tree_invalidate_path(istate, ce->name);
-
 	/*
 	 * If this entry's path sorts after the last entry in the index,
 	 * we can avoid searching for it.
@@ -1352,6 +1349,13 @@ static int add_index_entry_with_check(struct index_state *istate, struct cache_e
 	else
 		pos = index_name_stage_pos(istate, ce->name, ce_namelen(ce), ce_stage(ce), EXPAND_SPARSE);
 
+	/*
+	 * Cache tree path should be invalidated only after index_name_stage_pos,
+	 * in case it expands a sparse index.
+	 */
+	if (!(option & ADD_CACHE_KEEP_CACHE_TREE))
+		cache_tree_invalidate_path(istate, ce->name);
+
 	/* existing match? Just replace it. */
 	if (pos >= 0) {
 		if (!new_only)
diff --git a/t/t1092-sparse-checkout-compatibility.sh b/t/t1092-sparse-checkout-compatibility.sh
index 91f849f541e..fceaba7101d 100755
--- a/t/t1092-sparse-checkout-compatibility.sh
+++ b/t/t1092-sparse-checkout-compatibility.sh
@@ -1253,6 +1253,21 @@ test_expect_success 'sparse index is not expanded: diff' '
 	ensure_not_expanded diff --cached
 '
 
+test_expect_success 'sparse index is not expanded: update-index' '
+	init_repos &&
+
+	deep_a_oid=$(git -C full-checkout rev-parse update-deep:deep/a) &&
+	ensure_not_expanded update-index --cacheinfo 100644 $deep_a_oid deep/a &&
+
+	echo "test" >sparse-index/README.md &&
+	echo "test2" >sparse-index/a &&
+	rm -f sparse-index/deep/a &&
+
+	ensure_not_expanded update-index --add README.md &&
+	ensure_not_expanded update-index a &&
+	ensure_not_expanded update-index --remove deep/a
+'
+
 test_expect_success 'sparse index is not expanded: blame' '
 	init_repos &&
 
-- 
gitgitgadget

