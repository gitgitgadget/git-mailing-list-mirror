Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 02B0AC433F5
	for <git@archiver.kernel.org>; Wed, 27 Oct 2021 18:20:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E1A08610A4
	for <git@archiver.kernel.org>; Wed, 27 Oct 2021 18:20:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243468AbhJ0SWo (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 27 Oct 2021 14:22:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41138 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240277AbhJ0SWl (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 27 Oct 2021 14:22:41 -0400
Received: from mail-wr1-x433.google.com (mail-wr1-x433.google.com [IPv6:2a00:1450:4864:20::433])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A93AAC061570
        for <git@vger.kernel.org>; Wed, 27 Oct 2021 11:20:15 -0700 (PDT)
Received: by mail-wr1-x433.google.com with SMTP id u18so5665758wrg.5
        for <git@vger.kernel.org>; Wed, 27 Oct 2021 11:20:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=VR2Z2fLSfarik6H2oV1f213mqXM+f4ls0tb3YM3OJfA=;
        b=mlAGq1uT5BN555gD3Swe9Hk+OtlOu4cozG76WCYnmkFPwqMB+4+v5R/s02MHN1HDYu
         XELPkxPHNM0JrDnIPV/1tw+c7hQZp6kDnJRyajsDermRT1wCZyCCUE+uro2gmW2rCVLw
         Lbn79FERH4ZMjnWvY1EEjYu0awfcrfhkZOKi4Z7QCFYTDBdJzms8bVd31f2v4pdgy7Tm
         ODX2rJoYekY6USaYH2CudBHYcSWcJeZnM2NhCiujTSFMpAY8YhoeLSe6n7CNzKqe986R
         n6/g8ephObYcaqLop5529087jrFJJ53sPXKbmjRGLVd3CmCmhoydIa25RHv/ew9AlfxS
         qk/g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=VR2Z2fLSfarik6H2oV1f213mqXM+f4ls0tb3YM3OJfA=;
        b=cQFHI1Izf2p1CkzYPHO7fGHLRhw9cPR304CL300ikVJ41Ov2IVSFDh1vzDjPdPvBA4
         dJvoJLIG6OIKfZNTS3fgE/1Xf0ipmzFnq8WPVLm+/VofgK336v/jGiguAZuesYuvRaV9
         xImq7b6XAZCuvlwY2eKgl7rG1/z0MpQ2PYcooFx3QiHsHeiexXxARk4+lAPoenBiBQaj
         gVJ8D5aF/02xV5XKDtbejk2/9ty3MXeN4bZseAyN/flHODLCS9DoY3Whihbf5sC2IIw4
         g7kkrW554FrMJ86cShnqmi+U7+r6zu7UdoDKCe4RnQ+7B6R2buaKpWohVyVsOx81Zm6s
         p66Q==
X-Gm-Message-State: AOAM530vphjnKeZIV0rW++0clV07qOH5O8MLBNwi95tUhmM+k0LBz6n3
        zLaAzzH5zT6YreQ49tV28xkqxO8dP2Q=
X-Google-Smtp-Source: ABdhPJwTjoA15MPBoSTGPdkKnpVjwjUkq1Nqpk6g4sylRB2ZbAW1zQKFd7kN3c72Hg8+BWqPv7rGvw==
X-Received: by 2002:adf:d0cf:: with SMTP id z15mr17252136wrh.219.1635358814177;
        Wed, 27 Oct 2021 11:20:14 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id m3sm1793316wms.25.2021.10.27.11.20.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 27 Oct 2021 11:20:13 -0700 (PDT)
Message-Id: <9d6511db0728e9880a96f3d9e3a025a9ddc5bc9e.1635358812.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1059.v3.git.1635358812.gitgitgadget@gmail.com>
References: <pull.1059.v2.git.1634849307.gitgitgadget@gmail.com>
        <pull.1059.v3.git.1635358812.gitgitgadget@gmail.com>
From:   "Victoria Dye via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Wed, 27 Oct 2021 18:20:10 +0000
Subject: [PATCH v3 2/3] sparse-index: add ensure_correct_sparsity function
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     stolee@gmail.com, gitster@pobox.com,
        Victoria Dye <vdye@github.com>, Victoria Dye <vdye@github.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Victoria Dye <vdye@github.com>

The `ensure_correct_sparsity` function is intended to provide a means of
aligning the in-core index with the sparsity required by the repository
settings and other properties of the index. The function first checks
whether a sparse index is allowed (per repository & sparse checkout pattern
settings). If the sparse index may be used, the index is converted to
sparse; otherwise, it is explicitly expanded with `ensure_full_index`.

Helped-by: Junio C Hamano <gitster@pobox.com>
Signed-off-by: Victoria Dye <vdye@github.com>
---
 sparse-index.c | 33 +++++++++++++++++++++++++++++----
 sparse-index.h |  1 +
 2 files changed, 30 insertions(+), 4 deletions(-)

diff --git a/sparse-index.c b/sparse-index.c
index 7b7ff79e044..bc3ee358c63 100644
--- a/sparse-index.c
+++ b/sparse-index.c
@@ -122,17 +122,17 @@ static int index_has_unmerged_entries(struct index_state *istate)
 	return 0;
 }
 
-int convert_to_sparse(struct index_state *istate, int flags)
+static int is_sparse_index_allowed(struct index_state *istate, int flags)
 {
-	int test_env;
-	if (istate->sparse_index || !istate->cache_nr ||
-	    !core_apply_sparse_checkout || !core_sparse_checkout_cone)
+	if (!core_apply_sparse_checkout || !core_sparse_checkout_cone)
 		return 0;
 
 	if (!istate->repo)
 		istate->repo = the_repository;
 
 	if (!(flags & SPARSE_INDEX_MEMORY_ONLY)) {
+		int test_env;
+
 		/*
 		 * The sparse index is not (yet) integrated with a split index.
 		 */
@@ -168,6 +168,19 @@ int convert_to_sparse(struct index_state *istate, int flags)
 	if (!istate->sparse_checkout_patterns->use_cone_patterns)
 		return 0;
 
+	return 1;
+}
+
+int convert_to_sparse(struct index_state *istate, int flags)
+{
+	/*
+	 * If the index is already sparse, empty, or otherwise
+	 * cannot be converted to sparse, do not convert.
+	 */
+	if (istate->sparse_index || !istate->cache_nr ||
+	    !is_sparse_index_allowed(istate, flags))
+		return 0;
+
 	/*
 	 * NEEDSWORK: If we have unmerged entries, then stay full.
 	 * Unmerged entries prevent the cache-tree extension from working.
@@ -313,6 +326,18 @@ void ensure_full_index(struct index_state *istate)
 	trace2_region_leave("index", "ensure_full_index", istate->repo);
 }
 
+void ensure_correct_sparsity(struct index_state *istate)
+{
+	/*
+	 * If the index can be sparse, make it sparse. Otherwise,
+	 * ensure the index is full.
+	 */
+	if (is_sparse_index_allowed(istate, 0))
+		convert_to_sparse(istate, 0);
+	else
+		ensure_full_index(istate);
+}
+
 /*
  * This static global helps avoid infinite recursion between
  * expand_to_path() and index_file_exists().
diff --git a/sparse-index.h b/sparse-index.h
index 9f3d7bc7faf..656bd835b25 100644
--- a/sparse-index.h
+++ b/sparse-index.h
@@ -4,6 +4,7 @@
 struct index_state;
 #define SPARSE_INDEX_MEMORY_ONLY (1 << 0)
 int convert_to_sparse(struct index_state *istate, int flags);
+void ensure_correct_sparsity(struct index_state *istate);
 
 /*
  * Some places in the codebase expect to search for a specific path.
-- 
gitgitgadget

