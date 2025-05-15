Received: from mail-wr1-f47.google.com (mail-wr1-f47.google.com [209.85.221.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 81DD12980B2
	for <git@vger.kernel.org>; Thu, 15 May 2025 13:11:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747314718; cv=none; b=YwMXnTl+N+gVgY2+yFzNxZ1WBIHIJx6ZzEptcay6eq/UW7JjkqeRnFBgeTh4/cLZrxOYM3JX5I5gwwzNXiW4zbsVSHeOZE7cnNvMqdF8iVc5bROQCSFebaY0sImTdaCbmVhadZg2UYZnbl0W0a4uFTJW8xVilLe5THOLLSr4E7o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747314718; c=relaxed/simple;
	bh=TCGzSGHIfjbfEFjMS9WmpIzhZq89NENDNC42I+xbA5Q=;
	h=Message-Id:In-Reply-To:References:From:Date:Subject:Content-Type:
	 MIME-Version:To:Cc; b=URQ0Tvpob46EF+39wCLaQ3ZjLM+R5sNExJoP6hNZfnzxzP2cl85v9YR+LKE6ADZpVT0TCNioLpzhdkp5vClptoT4KZwWCcUL6FOWblb7bfUtsmFvDoUqj/Ai4wrMsDyW2DgvN4MT1cR7ezM9YypGHKxc2GR35VBaDbyGweJe17w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=L8uY4DlD; arc=none smtp.client-ip=209.85.221.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="L8uY4DlD"
Received: by mail-wr1-f47.google.com with SMTP id ffacd0b85a97d-3a0b135d18eso522196f8f.2
        for <git@vger.kernel.org>; Thu, 15 May 2025 06:11:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1747314714; x=1747919514; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Ccv+dMAiiacq8ie+5zVYxR1DmoVe8ovvvnc/k0KJK+w=;
        b=L8uY4DlDhG/iHD5ZzRafTi1AnjR3oPjb6UL5sPEh4uvWwMVR+3BbXmrzJCWWzoD+j9
         RvbRIQbpe2WMzKCNPrCluUbIbNDBDDmQJZEmLvMwqKhGvVn14qBHOLAhtqlGALc4uqlP
         6D81WxdSQmIiH2aksT5WJkvaIZCv4gYhxkKHSvSPSFOAYtx8TZVWkavIyOs6zFZR1QUW
         IrwVU0AgVryMQ+nc/nQa8l3kt5D3IFRddPpO3M2t6pUf7fCJhhqRjcarTp0KUrK8LcUw
         PGr0ZnPzroVRPUPRDe2TDVYn7grBq0+al6+uqP3MT+zObT4m07tI9VnH7rYQ4D4sYwQ8
         9wRw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1747314714; x=1747919514;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Ccv+dMAiiacq8ie+5zVYxR1DmoVe8ovvvnc/k0KJK+w=;
        b=j43nIxOQEH2a8grEmbo4tvwOZ6NvatmcZZTnhuPfJ+vfLprLaS4iJ4ipBhRItLMoCl
         wlV6j025S5YPgA9ypbcWP55OW4iLa6FTI6hwZ+MaeZ++0Pt8UGC0OLrj83YVbG74W3Hw
         MKtqMmSCqB+T3XGjy9J8BtU6hufrbUBFIKFuv7FePqdwcD0Jir03uq+LxgFEVTNXCfzk
         0LybbRGfxiHPxiJMCf63jB/YkMDSwk3ZCuPpRUqkZP0ta8AFzX6jOv2NWXFJBdwWC11n
         Bm84nw6HSZIcBZfx6ARW0YznteAmM2v6QTBjC/B1CHprTSsPW8SlSaaVLG3QH0Y8vAWL
         VCgg==
X-Gm-Message-State: AOJu0YwXx6oXQ5/DXA0UNS0JTFpwy69lf2TfbcsBJpa6gXo2P26EgDmk
	aAFxC14xz44A8v5LOJ+3r75g7lEkqf4KdD6XqhYXkDqt9LIfojE8pKo+Sg==
X-Gm-Gg: ASbGncs9FhbLsozsSjcu3pvdPdM5sryvWkLcbY4tOyMglCWuR1heBaxUElWHczJI1zJ
	M0+681stlJdzdIbDstk21gHlb+GvpMtHEa/RumBa+YRM6H4AbrSfilu/df28bNCovj+vSOxvznJ
	xgOworFeF1I9b8f3QI190mtFalW2GJJjmzUoTFekwDgziu/dw0VLrBXV4mV5zHfOL9Z0jGv2rOd
	XlPOpDOYOXTYx6jo8vuY6pvgkhDjWUc0ul7st+IYDO4yX5kjF7x2zzm8/1Cmp0lNRfQQLEtyu02
	EqcP7bPuYcb/3kminEFq6auzExBev/EyvvCk/Zt4Bg+BKw+822iS
X-Google-Smtp-Source: AGHT+IFdtLOcp8gVSsUdWm1uTp5qxL4IXm3Hc6+c/EtlC6euD4cf4JL8w7fBUbQhN1sINqRYWV983g==
X-Received: by 2002:a5d:588b:0:b0:3a0:b784:8826 with SMTP id ffacd0b85a97d-3a35373a038mr2059456f8f.19.1747314713955;
        Thu, 15 May 2025 06:11:53 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3a1f5a4bbf0sm22395134f8f.82.2025.05.15.06.11.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 15 May 2025 06:11:53 -0700 (PDT)
Message-Id: <5a3a8880a68f8c69c2af39d2e32ebb56eb5fa483.1747314709.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1891.git.1747314709.gitgitgadget@gmail.com>
References: <pull.1891.git.1747314709.gitgitgadget@gmail.com>
From: "Johannes Schindelin via GitGitGadget" <gitgitgadget@gmail.com>
Date: Thu, 15 May 2025 13:11:41 +0000
Subject: [PATCH 03/11] commit-graph: avoid malloc'ing a local variable
Fcc: Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
To: git@vger.kernel.org
Cc: Johannes Schindelin <johannes.schindelin@gmx.de>,
    Johannes Schindelin <johannes.schindelin@gmx.de>

From: Johannes Schindelin <johannes.schindelin@gmx.de>

We do need a context to write the commit graph, but that context is only
needed during the life time of `commit_graph_write()`, therefore it can
easily be a stack variable.

This also helps CodeQL recognize that it is safe to assign the address
of other local variables to the context's fields.

Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
---
 commit-graph.c | 141 ++++++++++++++++++++++++-------------------------
 1 file changed, 69 insertions(+), 72 deletions(-)

diff --git a/commit-graph.c b/commit-graph.c
index 6394752b0b08..9f0115dac9b5 100644
--- a/commit-graph.c
+++ b/commit-graph.c
@@ -2509,7 +2509,17 @@ int write_commit_graph(struct object_directory *odb,
 		       const struct commit_graph_opts *opts)
 {
 	struct repository *r = the_repository;
-	struct write_commit_graph_context *ctx;
+	struct write_commit_graph_context ctx = {
+		.r = r,
+		.odb = odb,
+		.append = flags & COMMIT_GRAPH_WRITE_APPEND ? 1 : 0,
+		.report_progress = flags & COMMIT_GRAPH_WRITE_PROGRESS ? 1 : 0,
+		.split = flags & COMMIT_GRAPH_WRITE_SPLIT ? 1 : 0,
+		.opts = opts,
+		.total_bloom_filter_data_size = 0,
+		.write_generation_data = (get_configured_generation_version(r) == 2),
+		.num_generation_data_overflows = 0,
+	};
 	uint32_t i;
 	int res = 0;
 	int replace = 0;
@@ -2531,17 +2541,6 @@ int write_commit_graph(struct object_directory *odb,
 		return 0;
 	}
 
-	CALLOC_ARRAY(ctx, 1);
-	ctx->r = r;
-	ctx->odb = odb;
-	ctx->append = flags & COMMIT_GRAPH_WRITE_APPEND ? 1 : 0;
-	ctx->report_progress = flags & COMMIT_GRAPH_WRITE_PROGRESS ? 1 : 0;
-	ctx->split = flags & COMMIT_GRAPH_WRITE_SPLIT ? 1 : 0;
-	ctx->opts = opts;
-	ctx->total_bloom_filter_data_size = 0;
-	ctx->write_generation_data = (get_configured_generation_version(r) == 2);
-	ctx->num_generation_data_overflows = 0;
-
 	bloom_settings.hash_version = r->settings.commit_graph_changed_paths_version;
 	bloom_settings.bits_per_entry = git_env_ulong("GIT_TEST_BLOOM_SETTINGS_BITS_PER_ENTRY",
 						      bloom_settings.bits_per_entry);
@@ -2549,14 +2548,14 @@ int write_commit_graph(struct object_directory *odb,
 						  bloom_settings.num_hashes);
 	bloom_settings.max_changed_paths = git_env_ulong("GIT_TEST_BLOOM_SETTINGS_MAX_CHANGED_PATHS",
 							 bloom_settings.max_changed_paths);
-	ctx->bloom_settings = &bloom_settings;
+	ctx.bloom_settings = &bloom_settings;
 
 	init_topo_level_slab(&topo_levels);
-	ctx->topo_levels = &topo_levels;
+	ctx.topo_levels = &topo_levels;
 
-	prepare_commit_graph(ctx->r);
-	if (ctx->r->objects->commit_graph) {
-		struct commit_graph *g = ctx->r->objects->commit_graph;
+	prepare_commit_graph(ctx.r);
+	if (ctx.r->objects->commit_graph) {
+		struct commit_graph *g = ctx.r->objects->commit_graph;
 
 		while (g) {
 			g->topo_levels = &topo_levels;
@@ -2565,15 +2564,15 @@ int write_commit_graph(struct object_directory *odb,
 	}
 
 	if (flags & COMMIT_GRAPH_WRITE_BLOOM_FILTERS)
-		ctx->changed_paths = 1;
+		ctx.changed_paths = 1;
 	if (!(flags & COMMIT_GRAPH_NO_WRITE_BLOOM_FILTERS)) {
 		struct commit_graph *g;
 
-		g = ctx->r->objects->commit_graph;
+		g = ctx.r->objects->commit_graph;
 
 		/* We have changed-paths already. Keep them in the next graph */
 		if (g && g->bloom_filter_settings) {
-			ctx->changed_paths = 1;
+			ctx.changed_paths = 1;
 
 			/* don't propagate the hash_version unless unspecified */
 			if (bloom_settings.hash_version == -1)
@@ -2586,116 +2585,114 @@ int write_commit_graph(struct object_directory *odb,
 
 	bloom_settings.hash_version = bloom_settings.hash_version == 2 ? 2 : 1;
 
-	if (ctx->split) {
-		struct commit_graph *g = ctx->r->objects->commit_graph;
+	if (ctx.split) {
+		struct commit_graph *g = ctx.r->objects->commit_graph;
 
 		while (g) {
-			ctx->num_commit_graphs_before++;
+			ctx.num_commit_graphs_before++;
 			g = g->base_graph;
 		}
 
-		if (ctx->num_commit_graphs_before) {
-			ALLOC_ARRAY(ctx->commit_graph_filenames_before, ctx->num_commit_graphs_before);
-			i = ctx->num_commit_graphs_before;
-			g = ctx->r->objects->commit_graph;
+		if (ctx.num_commit_graphs_before) {
+			ALLOC_ARRAY(ctx.commit_graph_filenames_before, ctx.num_commit_graphs_before);
+			i = ctx.num_commit_graphs_before;
+			g = ctx.r->objects->commit_graph;
 
 			while (g) {
-				ctx->commit_graph_filenames_before[--i] = xstrdup(g->filename);
+				ctx.commit_graph_filenames_before[--i] = xstrdup(g->filename);
 				g = g->base_graph;
 			}
 		}
 
-		if (ctx->opts)
-			replace = ctx->opts->split_flags & COMMIT_GRAPH_SPLIT_REPLACE;
+		if (ctx.opts)
+			replace = ctx.opts->split_flags & COMMIT_GRAPH_SPLIT_REPLACE;
 	}
 
-	ctx->approx_nr_objects = repo_approximate_object_count(the_repository);
+	ctx.approx_nr_objects = repo_approximate_object_count(the_repository);
 
-	if (ctx->append && ctx->r->objects->commit_graph) {
-		struct commit_graph *g = ctx->r->objects->commit_graph;
+	if (ctx.append && ctx.r->objects->commit_graph) {
+		struct commit_graph *g = ctx.r->objects->commit_graph;
 		for (i = 0; i < g->num_commits; i++) {
 			struct object_id oid;
 			oidread(&oid, g->chunk_oid_lookup + st_mult(g->hash_len, i),
 				the_repository->hash_algo);
-			oid_array_append(&ctx->oids, &oid);
+			oid_array_append(&ctx.oids, &oid);
 		}
 	}
 
 	if (pack_indexes) {
-		ctx->order_by_pack = 1;
-		if ((res = fill_oids_from_packs(ctx, pack_indexes)))
+		ctx.order_by_pack = 1;
+		if ((res = fill_oids_from_packs(&ctx, pack_indexes)))
 			goto cleanup;
 	}
 
 	if (commits) {
-		if ((res = fill_oids_from_commits(ctx, commits)))
+		if ((res = fill_oids_from_commits(&ctx, commits)))
 			goto cleanup;
 	}
 
 	if (!pack_indexes && !commits) {
-		ctx->order_by_pack = 1;
-		fill_oids_from_all_packs(ctx);
+		ctx.order_by_pack = 1;
+		fill_oids_from_all_packs(&ctx);
 	}
 
-	close_reachable(ctx);
+	close_reachable(&ctx);
 
-	copy_oids_to_commits(ctx);
+	copy_oids_to_commits(&ctx);
 
-	if (ctx->commits.nr >= GRAPH_EDGE_LAST_MASK) {
+	if (ctx.commits.nr >= GRAPH_EDGE_LAST_MASK) {
 		error(_("too many commits to write graph"));
 		res = -1;
 		goto cleanup;
 	}
 
-	if (!ctx->commits.nr && !replace)
+	if (!ctx.commits.nr && !replace)
 		goto cleanup;
 
-	if (ctx->split) {
-		split_graph_merge_strategy(ctx);
+	if (ctx.split) {
+		split_graph_merge_strategy(&ctx);
 
 		if (!replace)
-			merge_commit_graphs(ctx);
+			merge_commit_graphs(&ctx);
 	} else
-		ctx->num_commit_graphs_after = 1;
+		ctx.num_commit_graphs_after = 1;
 
-	ctx->trust_generation_numbers = validate_mixed_generation_chain(ctx->r->objects->commit_graph);
+	ctx.trust_generation_numbers = validate_mixed_generation_chain(ctx.r->objects->commit_graph);
 
-	compute_topological_levels(ctx);
-	if (ctx->write_generation_data)
-		compute_generation_numbers(ctx);
+	compute_topological_levels(&ctx);
+	if (ctx.write_generation_data)
+		compute_generation_numbers(&ctx);
 
-	if (ctx->changed_paths)
-		compute_bloom_filters(ctx);
+	if (ctx.changed_paths)
+		compute_bloom_filters(&ctx);
 
-	res = write_commit_graph_file(ctx);
+	res = write_commit_graph_file(&ctx);
 
-	if (ctx->changed_paths)
+	if (ctx.changed_paths)
 		deinit_bloom_filters();
 
-	if (ctx->split)
-		mark_commit_graphs(ctx);
+	if (ctx.split)
+		mark_commit_graphs(&ctx);
 
-	expire_commit_graphs(ctx);
+	expire_commit_graphs(&ctx);
 
 cleanup:
-	free(ctx->graph_name);
-	free(ctx->base_graph_name);
-	free(ctx->commits.list);
-	oid_array_clear(&ctx->oids);
+	free(ctx.graph_name);
+	free(ctx.base_graph_name);
+	free(ctx.commits.list);
+	oid_array_clear(&ctx.oids);
 	clear_topo_level_slab(&topo_levels);
 
-	for (i = 0; i < ctx->num_commit_graphs_before; i++)
-		free(ctx->commit_graph_filenames_before[i]);
-	free(ctx->commit_graph_filenames_before);
+	for (i = 0; i < ctx.num_commit_graphs_before; i++)
+		free(ctx.commit_graph_filenames_before[i]);
+	free(ctx.commit_graph_filenames_before);
 
-	for (i = 0; i < ctx->num_commit_graphs_after; i++) {
-		free(ctx->commit_graph_filenames_after[i]);
-		free(ctx->commit_graph_hash_after[i]);
+	for (i = 0; i < ctx.num_commit_graphs_after; i++) {
+		free(ctx.commit_graph_filenames_after[i]);
+		free(ctx.commit_graph_hash_after[i]);
 	}
-	free(ctx->commit_graph_filenames_after);
-	free(ctx->commit_graph_hash_after);
-
-	free(ctx);
+	free(ctx.commit_graph_filenames_after);
+	free(ctx.commit_graph_hash_after);
 
 	return res;
 }
-- 
gitgitgadget

