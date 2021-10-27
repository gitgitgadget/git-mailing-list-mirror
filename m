Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ACB1AC4332F
	for <git@archiver.kernel.org>; Wed, 27 Oct 2021 18:20:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 984D0610E6
	for <git@archiver.kernel.org>; Wed, 27 Oct 2021 18:20:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243443AbhJ0SWl (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 27 Oct 2021 14:22:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41130 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240277AbhJ0SWk (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 27 Oct 2021 14:22:40 -0400
Received: from mail-wr1-x42e.google.com (mail-wr1-x42e.google.com [IPv6:2a00:1450:4864:20::42e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6E9FFC061570
        for <git@vger.kernel.org>; Wed, 27 Oct 2021 11:20:14 -0700 (PDT)
Received: by mail-wr1-x42e.google.com with SMTP id u18so5665691wrg.5
        for <git@vger.kernel.org>; Wed, 27 Oct 2021 11:20:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=y9DSYtFvIGP2JlhwqcUXT2M4dmf3I5NnGTL5+yyZCpw=;
        b=HLvKtKREK+aiZVYx1glvtbg6/3lceeWs2xQz6t4DHenleuWPfSEo1hw+SFgvFjJWDz
         K4zJheb75QIA59y6V4FiUQoEWouzVRvFy4y8JD4rbeu7cqh7c0cvnEHBrNwVx+9YlYBG
         iiezI13uaV8siCpXrnK354t8xyJmw58bDfk0BUl6VjL8DRHVI4Lv5y+8LSCE+W03/nDx
         8PauRBX9YcViWOH5rv7eyiu9p5pjUeFNz4/3fz7rgZwpDQc5Izn306QRWX6Z3DiZSqKB
         jma3AIuFXA6lG/ucSfMeOHDhbno1McPQwiOIwDbaLBJxOoFNbdiLryvuizq8NQO+Q+lU
         9vug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=y9DSYtFvIGP2JlhwqcUXT2M4dmf3I5NnGTL5+yyZCpw=;
        b=yLNRZVlFXZIN8ImZUdP3p/PlNHDC3dPtKFdSBqEFF1yY0GI9DtG02FMGrUKtbh9Y2H
         bibb97rWwxb3tLLrCbxwVa62iTneaXNkJtajNHuy4Cb5y8LrxkLJDSV20VSwuGTgFS+4
         ZntEZUHozoVHshY8kHLT/AwQ2NqXkf3eg748ATPYWGohZ9G7QwI3ySWlpeqGzvAcsHPf
         DmxfH+g7hMnPihqFZMcVBZ4CCUqr/L7t+00CvWQ+iCdsNG6d7E2zi62u6bBDXbVWcP5G
         ROA/EsSoy8X6KwRFsvlAbkKRoqmFn4jF/eC1oH2vLWY/taH6Tq+nrzuXAgBy1jhVjLu3
         +H4g==
X-Gm-Message-State: AOAM5323+j46Gz5vWNaNVUvuyJRgWZHYMsXYH0x2QWDKjzXq5/897NUc
        oBTtEID8e7vNlLFPJJpBP8dAwx7sKGg=
X-Google-Smtp-Source: ABdhPJykXMWmUwqxta2tkGVLjlXzIgJgZyZJmmpE3f3yZ8q1GyTDtm4JvVpCzQIb4QUjEEbeCgdoDg==
X-Received: by 2002:a5d:668e:: with SMTP id l14mr9763781wru.173.1635358812992;
        Wed, 27 Oct 2021 11:20:12 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id d3sm705786wrb.36.2021.10.27.11.20.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 27 Oct 2021 11:20:12 -0700 (PDT)
Message-Id: <pull.1059.v3.git.1635358812.gitgitgadget@gmail.com>
In-Reply-To: <pull.1059.v2.git.1634849307.gitgitgadget@gmail.com>
References: <pull.1059.v2.git.1634849307.gitgitgadget@gmail.com>
From:   "Victoria Dye via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Wed, 27 Oct 2021 18:20:08 +0000
Subject: [PATCH v3 0/3] sparse-index: expand/collapse based on 'index.sparse'
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     stolee@gmail.com, gitster@pobox.com, Victoria Dye <vdye@github.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

This series updates do_read_index to use the index.sparse config setting
when determining whether the index should be expanded or collapsed. If the
command & repo allow use of a sparse index, index.sparse is enabled, and a
full index is read from disk, the index is collapsed before returning to the
caller. Conversely, if index.sparse is disabled but the index read from disk
is sparse, the index is expanded before returning. This allows index.sparse
to control use of the sparse index in addition to its existing control over
how the index is written to disk. It also introduces the ability to
enable/disable the sparse index on a command-by-command basis (e.g.,
allowing a user to troubleshoot a sparse-aware command with '-c
index.sparse=false' [1]).

While testing this change, a bug was found in 'test-tool read-cache' in
which config settings for the repository were not initialized before
preparing the repo settings. This caused index.sparse to always be 'false'
when using the test helper in a cone-mode sparse checkout, breaking tests in
t1091 and t1092. The issue is fixed by moving prepare_repo_settings after
config setup.


Changes since V1
================

 * Add ensure_correct_sparsity function that ensures the index is sparse if
   the repository settings (including index.sparse) allow it, otherwise
   ensuring the index is expanded to full.
 * Restructure condition in do_read_index to, rather than check specifically
   for the index.sparse config setting, call ensure_correct_sparsity
   unconditionally when command_requires_full_index is false.


Changes since V2
================

 * Rename can_convert_to_sparse to is_sparse_index_allowed to more
   accurately reflect what the function returns.
 * Remove index-iterating checks from is_sparse_index_allowed, leaving only
   inexpensive checks on config settings & sparse checkout patterns. Checks
   are still part of convert_to_sparse to ensure it behaves exactly as it
   did before this series.
 * Restructure ensure_correct_sparsity for better readability.
 * Fix test_env variable scope.

[1]
https://lore.kernel.org/git/cc60c6e7-ecef-ae22-8ec7-ab290ff2b830@gmail.com/

Thanks! -Victoria

Victoria Dye (3):
  test-read-cache.c: prepare_repo_settings after config init
  sparse-index: add ensure_correct_sparsity function
  sparse-index: update do_read_index to ensure correct sparsity

 read-cache.c                             |  8 ++++++
 sparse-index.c                           | 33 +++++++++++++++++++++---
 sparse-index.h                           |  1 +
 t/helper/test-read-cache.c               |  5 ++--
 t/t1092-sparse-checkout-compatibility.sh | 31 ++++++++++++++++++++++
 5 files changed, 72 insertions(+), 6 deletions(-)


base-commit: f443b226ca681d87a3a31e245a70e6bc2769123c
Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-1059%2Fvdye%2Fsparse%2Findex-sparse-config-v3
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-1059/vdye/sparse/index-sparse-config-v3
Pull-Request: https://github.com/gitgitgadget/git/pull/1059

Range-diff vs v2:

 1:  6974ce7e7f5 = 1:  6974ce7e7f5 test-read-cache.c: prepare_repo_settings after config init
 2:  0b6e6633bb2 ! 2:  9d6511db072 sparse-index: add ensure_correct_sparsity function
     @@ Metadata
       ## Commit message ##
          sparse-index: add ensure_correct_sparsity function
      
     -    The purpose of the `ensure_correct_sparsity` function is to provide a means
     -    of aligning the in-core index with the sparsity required by the repository
     -    settings and other properties of the index. The function will first attempt
     -    to convert the index to sparse, now with a "SPARSE_INDEX_VERIFY_ALLOWED"
     -    flag that forces the function to return a nonzero value if repository
     -    settings do not allow use of a sparse index. If a nonzero value is returned,
     -    the index is expanded to full with `ensure_full_index`.
     +    The `ensure_correct_sparsity` function is intended to provide a means of
     +    aligning the in-core index with the sparsity required by the repository
     +    settings and other properties of the index. The function first checks
     +    whether a sparse index is allowed (per repository & sparse checkout pattern
     +    settings). If the sparse index may be used, the index is converted to
     +    sparse; otherwise, it is explicitly expanded with `ensure_full_index`.
      
          Helped-by: Junio C Hamano <gitster@pobox.com>
          Signed-off-by: Victoria Dye <vdye@github.com>
     @@ sparse-index.c: static int index_has_unmerged_entries(struct index_state *istate
       }
       
      -int convert_to_sparse(struct index_state *istate, int flags)
     -+static int can_convert_to_sparse(struct index_state *istate, int flags)
     ++static int is_sparse_index_allowed(struct index_state *istate, int flags)
       {
     - 	int test_env;
     +-	int test_env;
      -	if (istate->sparse_index || !istate->cache_nr ||
      -	    !core_apply_sparse_checkout || !core_sparse_checkout_cone)
      +	if (!core_apply_sparse_checkout || !core_sparse_checkout_cone)
       		return 0;
       
       	if (!istate->repo)
     + 		istate->repo = the_repository;
     + 
     + 	if (!(flags & SPARSE_INDEX_MEMORY_ONLY)) {
     ++		int test_env;
     ++
     + 		/*
     + 		 * The sparse index is not (yet) integrated with a split index.
     + 		 */
      @@ sparse-index.c: int convert_to_sparse(struct index_state *istate, int flags)
     - 	if (cache_tree_update(istate, WRITE_TREE_MISSING_OK))
     + 	if (!istate->sparse_checkout_patterns->use_cone_patterns)
       		return 0;
       
      +	return 1;
     @@ sparse-index.c: int convert_to_sparse(struct index_state *istate, int flags)
      +
      +int convert_to_sparse(struct index_state *istate, int flags)
      +{
     -+	int verify = flags & SPARSE_INDEX_VERIFY_ALLOWED;
     -+
      +	/*
     -+	 * If validating with strict checks against whether the sparse index is
     -+	 * allowed, we want to check `can_convert_to_sparse` *before* exiting
     -+	 * early due to an already sparse or empty index.
     -+	 *
     -+	 * If not performing strict validation, the order is reversed to avoid
     -+	 * the more expensive checks in `can_convert_to_sparse` whenver possible.
     ++	 * If the index is already sparse, empty, or otherwise
     ++	 * cannot be converted to sparse, do not convert.
      +	 */
     -+	if (verify) {
     -+		if (!can_convert_to_sparse(istate, flags))
     -+			return -1;
     -+		else if (istate->sparse_index || !istate->cache_nr)
     -+			return 0;
     -+	} else if (istate->sparse_index || !istate->cache_nr ||
     -+		   !can_convert_to_sparse(istate, flags))
     ++	if (istate->sparse_index || !istate->cache_nr ||
     ++	    !is_sparse_index_allowed(istate, flags))
      +		return 0;
      +
     - 	remove_fsmonitor(istate);
     - 
     - 	trace2_region_enter("index", "convert_to_sparse", istate->repo);
     + 	/*
     + 	 * NEEDSWORK: If we have unmerged entries, then stay full.
     + 	 * Unmerged entries prevent the cache-tree extension from working.
      @@ sparse-index.c: void ensure_full_index(struct index_state *istate)
       	trace2_region_leave("index", "ensure_full_index", istate->repo);
       }
     @@ sparse-index.c: void ensure_full_index(struct index_state *istate)
      +void ensure_correct_sparsity(struct index_state *istate)
      +{
      +	/*
     -+	 * First check whether the index can be converted to sparse by attempting
     -+	 * to convert it with the SPARSE_INDEX_VERIFY_ALLOWED flag. If the
     -+	 * SPARSE_INDEX_VERIFY_ALLOWED checks indicate that the index cannot
     -+	 * be converted because repository settings and/or index properties
     -+	 * do not allow it, expand the index to full.
     ++	 * If the index can be sparse, make it sparse. Otherwise,
     ++	 * ensure the index is full.
      +	 */
     -+	if (convert_to_sparse(istate, SPARSE_INDEX_VERIFY_ALLOWED))
     ++	if (is_sparse_index_allowed(istate, 0))
     ++		convert_to_sparse(istate, 0);
     ++	else
      +		ensure_full_index(istate);
      +}
      +
     @@ sparse-index.c: void ensure_full_index(struct index_state *istate)
      
       ## sparse-index.h ##
      @@
     - 
       struct index_state;
       #define SPARSE_INDEX_MEMORY_ONLY (1 << 0)
     -+#define SPARSE_INDEX_VERIFY_ALLOWED (1 << 1)
       int convert_to_sparse(struct index_state *istate, int flags);
      +void ensure_correct_sparsity(struct index_state *istate);
       
 3:  437cf398256 = 3:  d6c3c694e1e sparse-index: update do_read_index to ensure correct sparsity

-- 
gitgitgadget
