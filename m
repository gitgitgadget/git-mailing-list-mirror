Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4CCBBC433F5
	for <git@archiver.kernel.org>; Mon, 23 May 2022 13:49:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236720AbiEWNtH (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 23 May 2022 09:49:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41604 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236644AbiEWNs5 (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 23 May 2022 09:48:57 -0400
Received: from mail-wr1-x436.google.com (mail-wr1-x436.google.com [IPv6:2a00:1450:4864:20::436])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3EA8C5640B
        for <git@vger.kernel.org>; Mon, 23 May 2022 06:48:54 -0700 (PDT)
Received: by mail-wr1-x436.google.com with SMTP id u3so21488009wrg.3
        for <git@vger.kernel.org>; Mon, 23 May 2022 06:48:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=2e/lmMHKxljW0UmkwNfLmy3N7RbVBrxm9U5bxVh7FeI=;
        b=Pl1r+br6a/EdsVpbNL2QjEAo38gScqj3WQPA9dpfjMJ/K045sFk9f//K3iUnkE8Fkz
         IqLxsdcW+6AQthJTaU0e5lY42AFnFkz1t/y6mnyE8iA1mP2z/4G6xP44Ddsld+FS/kl6
         pTYl17zEIUH2D/4jmVbebC79NayS4LIDF8jL4Nxwawqkn8dQXHIE+q5Q4QIrm8wXn4yf
         HGkyWwzVVguVuzXC0b9Wn+jV5rDa/Z9+0+Q09g+GLxVWt7UvMhG1Tkq96xr1mNv/HHZ+
         Kwf3bXpIHaC9Ioj+adnjrwZdU/xH8TGXm0iIf2IgINtj/vzNowPr52ugibdTSdrY8cag
         60LA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=2e/lmMHKxljW0UmkwNfLmy3N7RbVBrxm9U5bxVh7FeI=;
        b=4Th3zoDiKd2HlfSP91fFsGATXm07DleW2FxAGZQRw5HfMon8jZDXhFC4VxytW/iBg4
         Pvc11ovwWp5g2E2LoIuxTiGcoGFORK2fRuv4rZ9ZsDcmZEM24h8wHcWQBwRrHCCsLLjr
         1301rv+aRB+3+9SUSBXTKEQX/zGasBpdtWh1f9J4vx51WusIv9XwzhJhxq/iGEZZ359b
         L28FIfYKpusGH3FDM9qYBqgxOeyWrV0as+cDoBtFrwQzf2lcYwFqZz91dCHpngy6NXy3
         Pi6c7Es3+P+C7NcBOj69d0nm+lcSlJF+kNvn2qFyloQavpPiKPvGrBZ8bYyeeS1nx3Os
         6KWg==
X-Gm-Message-State: AOAM532hEelizRj6f9fDWhvQ2CUnQ87cm67Xwwoqg2fFWPQMY8jBI2Jq
        hyTD5A17OZBiAfRbS5YDDXnvibujx6E=
X-Google-Smtp-Source: ABdhPJzV7tit8qqXLUO9QW4SmUHJPxxqepd8GRkBP3/VvOO7kY9xS2FcLaycP9iy76/hL0HTN1sFgQ==
X-Received: by 2002:adf:9cc2:0:b0:20f:e59a:ec41 with SMTP id h2-20020adf9cc2000000b0020fe59aec41mr2650118wre.124.1653313732223;
        Mon, 23 May 2022 06:48:52 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id q6-20020adfbb86000000b0020c5253d902sm10430596wrg.78.2022.05.23.06.48.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 23 May 2022 06:48:51 -0700 (PDT)
Message-Id: <44b0549a2882df07a5b7c96a637c8f0d2e0d9798.1653313726.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1208.v3.git.1653313726.gitgitgadget@gmail.com>
References: <pull.1208.v2.git.1652982758.gitgitgadget@gmail.com>
        <pull.1208.v3.git.1653313726.gitgitgadget@gmail.com>
From:   "Derrick Stolee via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Mon, 23 May 2022 13:48:39 +0000
Subject: [PATCH v3 03/10] sparse-index: create expand_index()
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

This is the first change in a series to allow modifying the
sparse-checkout pattern set without expanding a sparse index to a full
one in the process. Here, we focus on the problem of expanding the
pattern set through a command like 'git sparse-checkout add <path>'
which needs to create new index entries for the paths now being written
to the worktree.

To achieve this, we need to be able to replace sparse directory entries
with their contained files and subdirectories. Once this is complete,
other code paths can discover those cache entries and write the
corresponding files to disk before committing the index.

We already have logic in ensure_full_index() that expands the index
entries, so we will use that as our base. Create a new method,
expand_index(), which takes a pattern list, but for now mostly ignores
it. The current implementation is only correct when the pattern list is
NULL as that does the same as ensure_full_index(). In fact,
ensure_full_index() is converted to a shim over expand_index().

A future update will actually implement expand_index() to its full
capabilities. For now, it is created and documented.

Signed-off-by: Derrick Stolee <derrickstolee@github.com>
---
 sparse-index.c | 32 +++++++++++++++++++++++++++++---
 sparse-index.h | 13 +++++++++++++
 2 files changed, 42 insertions(+), 3 deletions(-)

diff --git a/sparse-index.c b/sparse-index.c
index 8636af72de5..a11b5cf1314 100644
--- a/sparse-index.c
+++ b/sparse-index.c
@@ -248,19 +248,40 @@ static int add_path_to_index(const struct object_id *oid,
 	return 0;
 }
 
-void ensure_full_index(struct index_state *istate)
+void expand_index(struct index_state *istate, struct pattern_list *pl)
 {
 	int i;
 	struct index_state *full;
 	struct strbuf base = STRBUF_INIT;
+	const char *tr_region;
 
+	/*
+	 * If the index is already full, then keep it full. We will convert
+	 * it to a sparse index on write, if possible.
+	 */
 	if (!istate || !istate->sparse_index)
 		return;
 
+	/*
+	 * If our index is sparse, but our new pattern set does not use
+	 * cone mode patterns, then we need to expand the index before we
+	 * continue. A NULL pattern set indicates a full expansion to a
+	 * full index.
+	 */
+	if (pl && !pl->use_cone_patterns)
+		pl = NULL;
+
 	if (!istate->repo)
 		istate->repo = the_repository;
 
-	trace2_region_enter("index", "ensure_full_index", istate->repo);
+	/*
+	 * A NULL pattern set indicates we are expanding a full index, so
+	 * we use a special region name that indicates the full expansion.
+	 * This is used by test cases, but also helps to differentiate the
+	 * two cases.
+	 */
+	tr_region = pl ? "expand_index" : "ensure_full_index";
+	trace2_region_enter("index", tr_region, istate->repo);
 
 	/* initialize basics of new index */
 	full = xcalloc(1, sizeof(struct index_state));
@@ -322,7 +343,12 @@ void ensure_full_index(struct index_state *istate)
 	cache_tree_free(&istate->cache_tree);
 	cache_tree_update(istate, 0);
 
-	trace2_region_leave("index", "ensure_full_index", istate->repo);
+	trace2_region_leave("index", tr_region, istate->repo);
+}
+
+void ensure_full_index(struct index_state *istate)
+{
+	expand_index(istate, NULL);
 }
 
 void ensure_correct_sparsity(struct index_state *istate)
diff --git a/sparse-index.h b/sparse-index.h
index 633d4fb7e31..b1f2cdbb164 100644
--- a/sparse-index.h
+++ b/sparse-index.h
@@ -23,4 +23,17 @@ void expand_to_path(struct index_state *istate,
 struct repository;
 int set_sparse_index_config(struct repository *repo, int enable);
 
+struct pattern_list;
+
+/**
+ * Scan the given index and compare its entries to the given pattern list.
+ * If the index is sparse and the pattern list uses cone mode patterns,
+ * then modify the index to contain the all of the file entries within that
+ * new pattern list. This expands sparse directories only as far as needed.
+ *
+ * If the pattern list is NULL or does not use cone mode patterns, then the
+ * index is expanded to a full index.
+ */
+void expand_index(struct index_state *istate, struct pattern_list *pl);
+
 #endif
-- 
gitgitgadget

