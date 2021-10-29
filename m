Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D1C8FC433EF
	for <git@archiver.kernel.org>; Fri, 29 Oct 2021 13:51:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B640861184
	for <git@archiver.kernel.org>; Fri, 29 Oct 2021 13:51:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231481AbhJ2NyE (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 29 Oct 2021 09:54:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36546 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231328AbhJ2NyB (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 29 Oct 2021 09:54:01 -0400
Received: from mail-wr1-x433.google.com (mail-wr1-x433.google.com [IPv6:2a00:1450:4864:20::433])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 910BBC061714
        for <git@vger.kernel.org>; Fri, 29 Oct 2021 06:51:31 -0700 (PDT)
Received: by mail-wr1-x433.google.com with SMTP id i5so8610633wrb.2
        for <git@vger.kernel.org>; Fri, 29 Oct 2021 06:51:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=EhqpCoJT+8YeldSMIWB/k40BGZlaaKWhf6LrVKaEhLE=;
        b=p1F7RNzwssFvv6nWrWjllnxf9hnTXn7dvy+X/mhdYHowRZkD0toqm6SOkNpwIV/LMB
         aGweFCKxgB0ieaHheVUOu/IGKy1DU64Lh/5AKBK7dPeyysF0yxhRILTQ01S9zcRcoruA
         2kfLsmghw7EohPhtkQQpxQRJhjs4kD4VswRFGILwcoC72aDmg4oncEAfOJelfWc9bPWw
         mIKpHI/iqfVePGy3dQD/TTDXLve+4iQAxj1QDO4OWstKY7VDA2WLzdowofDrJ0Hsch9T
         hh6AI93Xcj2rkb9E2A2yNfPvF6VWO746UXCcOOM6YxMj+wkmVZj7FbnT7ZTJ7eAYjC9x
         uOMg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=EhqpCoJT+8YeldSMIWB/k40BGZlaaKWhf6LrVKaEhLE=;
        b=N3p1Qq8+2P3g8mbn2x2cMAydeEtayMtlWxFuI9gVXWUumEtrQTsq633TqRVvmYs7m7
         LjRnUytNgXdppAdrQZq1CNiFtLsVWrg4606hS533FwuA1rPdtkfrtKdhlz6YSgU6ySZn
         hiKuJcUrKnnmXAxnOTHL3Z83XQM9uxZ/nnW+8pPypX/lHr1fhaRB3M8C6Udu3PCI6ZG7
         g0VqOw+9EiC3QcSWiCUbaN9joa0u74JdKRch3RSd9k2rxRkwL0CV3HVatIcWJfwJ9F1s
         XYpMbRk3eYFwP7Qa94AleBZI8ehlZ09aiYrWEXR8tVq4sd7Tp/EWMOmxJixYEQdjRa6X
         Fs3g==
X-Gm-Message-State: AOAM532pRe7WbOBDObNme7ZOD6mPskK8aWeyeOEKx/0yeGZsLqCCm5o/
        FwPFzdj1zmMKqPS2x8bhprowVA014uU=
X-Google-Smtp-Source: ABdhPJzwJ/yKrsIYyab36fGgn1LEfIlFWeJCbxlsL3tVHp5g7+VXr6Xg3vgDtSxUxsBXKDULc+sHBA==
X-Received: by 2002:a5d:444c:: with SMTP id x12mr14398189wrr.38.1635515490223;
        Fri, 29 Oct 2021 06:51:30 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id g3sm7305030wri.45.2021.10.29.06.51.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 29 Oct 2021 06:51:29 -0700 (PDT)
Message-Id: <d2133ca1724258be01d7d2c3ac4888cd67eb3642.1635515487.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1059.v4.git.1635515487.gitgitgadget@gmail.com>
References: <pull.1059.v3.git.1635358812.gitgitgadget@gmail.com>
        <pull.1059.v4.git.1635515487.gitgitgadget@gmail.com>
From:   "Victoria Dye via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Fri, 29 Oct 2021 13:51:25 +0000
Subject: [PATCH v4 3/4] sparse-index: add ensure_correct_sparsity function
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
index 85613cd8a3a..a1d505d50e9 100644
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
@@ -316,6 +329,18 @@ void ensure_full_index(struct index_state *istate)
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

