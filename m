Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id E17A91F462
	for <e@80x24.org>; Tue, 18 Jun 2019 18:14:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730319AbfFRSOc (ORCPT <rfc822;e@80x24.org>);
        Tue, 18 Jun 2019 14:14:32 -0400
Received: from mail-ed1-f65.google.com ([209.85.208.65]:32926 "EHLO
        mail-ed1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730258AbfFRSOb (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 18 Jun 2019 14:14:31 -0400
Received: by mail-ed1-f65.google.com with SMTP id i11so23098602edq.0
        for <git@vger.kernel.org>; Tue, 18 Jun 2019 11:14:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:message-id:in-reply-to:references:from:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=bOFlLyxpHLdWRXJZ22zetERTFuCAURHR8yhMjlyIu5I=;
        b=TSXqe+q5cpUZQNXFdwJ/oT24cs5VobX59dcvT4Vr9hrpxEN6EF9WO/01wWuGWLX4zV
         yS5n8Tfqa2fpBoXv8FkLSYJuImZ0rAt/SNTuWxtvRAGROfjuldMt+96xr50ETHweU6BP
         SJkWine/yVe3xclnSq6ylvZZhUy4C5WBB4aWKBZ3Orxx23zG7vlVeTiTO2zZl5qzC/5e
         AUAx3sVnzr5qfPqFyEDzLR2jtdev7rvZxWw6kYMvfu1vYwhqTC9R9eoAiPKHkLLSQ2z/
         de+rTzXDxkSNMM57MFSuqwfC1nLaxxSPG5qIcezmIByRjFzG1+mobz7Rr4k2NmCRD4II
         RzVQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:message-id:in-reply-to:references:from
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=bOFlLyxpHLdWRXJZ22zetERTFuCAURHR8yhMjlyIu5I=;
        b=qY+zbODtHHKCP8j56tAQB0sGeKKtVrVd+ieOdnMxa7M4Te+MtvhdW92ciXbrZShqLJ
         BWxnRoDHQyZwGoob8mzCN5l5oxrhZsZhI5G1lWrCmAZpkKX8zQvWgv8yzMr4jRHbkH5s
         sAqRtNA5Hgu3Q7rwtzpElpKD454z3geRc1XYfxBYFced2FdvonJ2KAM/5cDrMdBEtvhd
         1pnnGMsp/2gJUD7koQZEpaWKgyFyn+4oRzi8lqtXBrNpB5qUAlPe52lBfBubFtvxkPaD
         g2FYKABhxI3TPB4Qzf/f1j7uAxD7QA3VudKB9v88yutmVDHVT5ZwUE/eDg3va/Qt4rcM
         REug==
X-Gm-Message-State: APjAAAU8e58xinAFqlO+mi7FS62Dnq6pv1kUBdJLkBxPVWkSkP6GVbMU
        M2QhHflaAATFflwLg73QlBNlyDCq
X-Google-Smtp-Source: APXvYqzf+8H9z4UgX0OVi4sBEl98z3lc4lueEO8gFo053IUTln1MXNYIVJeFBlCC3UsO+GD2eBtKQQ==
X-Received: by 2002:a17:906:6413:: with SMTP id d19mr51909831ejm.147.1560881668314;
        Tue, 18 Jun 2019 11:14:28 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id b53sm4973952edd.45.2019.06.18.11.14.27
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 18 Jun 2019 11:14:27 -0700 (PDT)
Date:   Tue, 18 Jun 2019 11:14:27 -0700 (PDT)
X-Google-Original-Date: Tue, 18 Jun 2019 18:14:09 GMT
Message-Id: <ee8c09fc5e6ce4b790e006e79458309b1e1e0acd.1560881661.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.184.v6.git.gitgitgadget@gmail.com>
References: <pull.184.v5.git.gitgitgadget@gmail.com>
        <pull.184.v6.git.gitgitgadget@gmail.com>
From:   "Derrick Stolee via GitGitGadget" <gitgitgadget@gmail.com>
Subject: [PATCH v6 07/18] commit-graph: write commit-graph chains
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     peff@peff.net, avarab@gmail.com, git@jeffhostetler.com,
        jrnieder@google.com, steadmon@google.com,
        johannes.schindelin@gmx.de, philipoakley@iee.org,
        Junio C Hamano <gitster@pobox.com>,
        Derrick Stolee <dstolee@microsoft.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Derrick Stolee <dstolee@microsoft.com>

Extend write_commit_graph() to write a commit-graph chain when given the
COMMIT_GRAPH_SPLIT flag.

This implementation is purposefully simplistic in how it creates a new
chain. The commits not already in the chain are added to a new tip
commit-graph file.

Much of the logic around writing a graph-{hash}.graph file and updating
the commit-graph-chain file is the same as the commit-graph file case.
However, there are several places where we need to do some extra logic
in the split case.

Track the list of graph filenames before and after the planned write.
This will be more important when we start merging graph files, but it
also allows us to upgrade our commit-graph file to the appropriate
graph-{hash}.graph file when we upgrade to a chain of commit-graphs.

Note that we use the eighth byte of the commit-graph header to store the
number of base graph files. This determines the length of the base
graphs chunk.

A subtle change of behavior with the new logic is that we do not write a
commit-graph if we our commit list is empty. This extends to the typical
case, which is reflected in t5318-commit-graph.sh.

Signed-off-by: Derrick Stolee <dstolee@microsoft.com>
---
 commit-graph.c          | 286 ++++++++++++++++++++++++++++++++++++++--
 commit-graph.h          |   2 +
 t/t5318-commit-graph.sh |   2 +-
 3 files changed, 278 insertions(+), 12 deletions(-)

diff --git a/commit-graph.c b/commit-graph.c
index f2163e109f..f0698b0599 100644
--- a/commit-graph.c
+++ b/commit-graph.c
@@ -300,12 +300,18 @@ static struct commit_graph *load_commit_graph_one(const char *graph_file)
 
 	struct stat st;
 	int fd;
+	struct commit_graph *g;
 	int open_ok = open_commit_graph(graph_file, &fd, &st);
 
 	if (!open_ok)
 		return NULL;
 
-	return load_commit_graph_one_fd_st(fd, &st);
+	g = load_commit_graph_one_fd_st(fd, &st);
+
+	if (g)
+		g->filename = xstrdup(graph_file);
+
+	return g;
 }
 
 static struct commit_graph *load_commit_graph_v1(struct repository *r, const char *obj_dir)
@@ -730,8 +736,19 @@ struct write_commit_graph_context {
 	struct progress *progress;
 	int progress_done;
 	uint64_t progress_cnt;
+
+	char *base_graph_name;
+	int num_commit_graphs_before;
+	int num_commit_graphs_after;
+	char **commit_graph_filenames_before;
+	char **commit_graph_filenames_after;
+	char **commit_graph_hash_after;
+	uint32_t new_num_commits_in_base;
+	struct commit_graph *new_base_graph;
+
 	unsigned append:1,
-		 report_progress:1;
+		 report_progress:1,
+		 split:1;
 };
 
 static void write_graph_chunk_fanout(struct hashfile *f,
@@ -801,6 +818,16 @@ static void write_graph_chunk_data(struct hashfile *f, int hash_len,
 					      ctx->commits.nr,
 					      commit_to_sha1);
 
+			if (edge_value >= 0)
+				edge_value += ctx->new_num_commits_in_base;
+			else {
+				uint32_t pos;
+				if (find_commit_in_graph(parent->item,
+							 ctx->new_base_graph,
+							 &pos))
+					edge_value = pos;
+			}
+
 			if (edge_value < 0)
 				BUG("missing parent %s for commit %s",
 				    oid_to_hex(&parent->item->object.oid),
@@ -821,6 +848,17 @@ static void write_graph_chunk_data(struct hashfile *f, int hash_len,
 					      ctx->commits.list,
 					      ctx->commits.nr,
 					      commit_to_sha1);
+
+			if (edge_value >= 0)
+				edge_value += ctx->new_num_commits_in_base;
+			else {
+				uint32_t pos;
+				if (find_commit_in_graph(parent->item,
+							 ctx->new_base_graph,
+							 &pos))
+					edge_value = pos;
+			}
+
 			if (edge_value < 0)
 				BUG("missing parent %s for commit %s",
 				    oid_to_hex(&parent->item->object.oid),
@@ -878,6 +916,16 @@ static void write_graph_chunk_extra_edges(struct hashfile *f,
 						  ctx->commits.nr,
 						  commit_to_sha1);
 
+			if (edge_value >= 0)
+				edge_value += ctx->new_num_commits_in_base;
+			else {
+				uint32_t pos;
+				if (find_commit_in_graph(parent->item,
+							 ctx->new_base_graph,
+							 &pos))
+					edge_value = pos;
+			}
+
 			if (edge_value < 0)
 				BUG("missing parent %s for commit %s",
 				    oid_to_hex(&parent->item->object.oid),
@@ -969,7 +1017,13 @@ static void close_reachable(struct write_commit_graph_context *ctx)
 		display_progress(ctx->progress, i + 1);
 		commit = lookup_commit(ctx->r, &ctx->oids.list[i]);
 
-		if (commit && !parse_commit_no_graph(commit))
+		if (!commit)
+			continue;
+		if (ctx->split) {
+			if (!parse_commit(commit) &&
+			    commit->graph_pos == COMMIT_NOT_FROM_GRAPH)
+				add_missing_parents(ctx, commit);
+		} else if (!parse_commit_no_graph(commit))
 			add_missing_parents(ctx, commit);
 	}
 	stop_progress(&ctx->progress);
@@ -1165,8 +1219,16 @@ static uint32_t count_distinct_commits(struct write_commit_graph_context *ctx)
 
 	for (i = 1; i < ctx->oids.nr; i++) {
 		display_progress(ctx->progress, i + 1);
-		if (!oideq(&ctx->oids.list[i - 1], &ctx->oids.list[i]))
+		if (!oideq(&ctx->oids.list[i - 1], &ctx->oids.list[i])) {
+			if (ctx->split) {
+				struct commit *c = lookup_commit(ctx->r, &ctx->oids.list[i]);
+
+				if (!c || c->graph_pos != COMMIT_NOT_FROM_GRAPH)
+					continue;
+			}
+
 			count_distinct++;
+		}
 	}
 	stop_progress(&ctx->progress);
 
@@ -1189,7 +1251,13 @@ static void copy_oids_to_commits(struct write_commit_graph_context *ctx)
 		if (i > 0 && oideq(&ctx->oids.list[i - 1], &ctx->oids.list[i]))
 			continue;
 
+		ALLOC_GROW(ctx->commits.list, ctx->commits.nr + 1, ctx->commits.alloc);
 		ctx->commits.list[ctx->commits.nr] = lookup_commit(ctx->r, &ctx->oids.list[i]);
+
+		if (ctx->split &&
+		    ctx->commits.list[ctx->commits.nr]->graph_pos != COMMIT_NOT_FROM_GRAPH)
+			continue;
+
 		parse_commit_no_graph(ctx->commits.list[ctx->commits.nr]);
 
 		for (parent = ctx->commits.list[ctx->commits.nr]->parents;
@@ -1204,18 +1272,86 @@ static void copy_oids_to_commits(struct write_commit_graph_context *ctx)
 	stop_progress(&ctx->progress);
 }
 
+static int write_graph_chunk_base_1(struct hashfile *f,
+				    struct commit_graph *g)
+{
+	int num = 0;
+
+	if (!g)
+		return 0;
+
+	num = write_graph_chunk_base_1(f, g->base_graph);
+	hashwrite(f, g->oid.hash, the_hash_algo->rawsz);
+	return num + 1;
+}
+
+static int write_graph_chunk_base(struct hashfile *f,
+				  struct write_commit_graph_context *ctx)
+{
+	int num = write_graph_chunk_base_1(f, ctx->new_base_graph);
+
+	if (num != ctx->num_commit_graphs_after - 1) {
+		error(_("failed to write correct number of base graph ids"));
+		return -1;
+	}
+
+	return 0;
+}
+
+static void init_commit_graph_chain(struct write_commit_graph_context *ctx)
+{
+	struct commit_graph *g = ctx->r->objects->commit_graph;
+	uint32_t i;
+
+	ctx->new_base_graph = g;
+	ctx->base_graph_name = xstrdup(g->filename);
+	ctx->new_num_commits_in_base = g->num_commits + g->num_commits_in_base;
+
+	ctx->num_commit_graphs_after = ctx->num_commit_graphs_before + 1;
+
+	ALLOC_ARRAY(ctx->commit_graph_filenames_after, ctx->num_commit_graphs_after);
+	ALLOC_ARRAY(ctx->commit_graph_hash_after, ctx->num_commit_graphs_after);
+
+	for (i = 0; i < ctx->num_commit_graphs_before - 1; i++)
+		ctx->commit_graph_filenames_after[i] = xstrdup(ctx->commit_graph_filenames_before[i]);
+
+	if (ctx->num_commit_graphs_before)
+		ctx->commit_graph_filenames_after[ctx->num_commit_graphs_before - 1] =
+			get_split_graph_filename(ctx->obj_dir, oid_to_hex(&g->oid));
+
+	i = ctx->num_commit_graphs_before - 1;
+
+	while (g) {
+		ctx->commit_graph_hash_after[i] = xstrdup(oid_to_hex(&g->oid));
+		i--;
+		g = g->base_graph;
+	}
+}
+
 static int write_commit_graph_file(struct write_commit_graph_context *ctx)
 {
 	uint32_t i;
+	int fd;
 	struct hashfile *f;
 	struct lock_file lk = LOCK_INIT;
-	uint32_t chunk_ids[5];
-	uint64_t chunk_offsets[5];
+	uint32_t chunk_ids[6];
+	uint64_t chunk_offsets[6];
 	const unsigned hashsz = the_hash_algo->rawsz;
 	struct strbuf progress_title = STRBUF_INIT;
 	int num_chunks = 3;
+	struct object_id file_hash;
+
+	if (ctx->split) {
+		struct strbuf tmp_file = STRBUF_INIT;
+
+		strbuf_addf(&tmp_file,
+			    "%s/info/commit-graphs/tmp_graph_XXXXXX",
+			    ctx->obj_dir);
+		ctx->graph_name = strbuf_detach(&tmp_file, NULL);
+	} else {
+		ctx->graph_name = get_commit_graph_filename(ctx->obj_dir);
+	}
 
-	ctx->graph_name = get_commit_graph_filename(ctx->obj_dir);
 	if (safe_create_leading_directories(ctx->graph_name)) {
 		UNLEAK(ctx->graph_name);
 		error(_("unable to create leading directories of %s"),
@@ -1223,8 +1359,23 @@ static int write_commit_graph_file(struct write_commit_graph_context *ctx)
 		return -1;
 	}
 
-	hold_lock_file_for_update(&lk, ctx->graph_name, LOCK_DIE_ON_ERROR);
-	f = hashfd(lk.tempfile->fd, lk.tempfile->filename.buf);
+	if (ctx->split) {
+		char *lock_name = get_chain_filename(ctx->obj_dir);
+
+		hold_lock_file_for_update(&lk, lock_name, LOCK_DIE_ON_ERROR);
+
+		fd = git_mkstemp_mode(ctx->graph_name, 0444);
+		if (fd < 0) {
+			error(_("unable to create '%s'"), ctx->graph_name);
+			return -1;
+		}
+
+		f = hashfd(fd, ctx->graph_name);
+	} else {
+		hold_lock_file_for_update(&lk, ctx->graph_name, LOCK_DIE_ON_ERROR);
+		fd = lk.tempfile->fd;
+		f = hashfd(lk.tempfile->fd, lk.tempfile->filename.buf);
+	}
 
 	chunk_ids[0] = GRAPH_CHUNKID_OIDFANOUT;
 	chunk_ids[1] = GRAPH_CHUNKID_OIDLOOKUP;
@@ -1233,6 +1384,10 @@ static int write_commit_graph_file(struct write_commit_graph_context *ctx)
 		chunk_ids[num_chunks] = GRAPH_CHUNKID_EXTRAEDGES;
 		num_chunks++;
 	}
+	if (ctx->num_commit_graphs_after > 1) {
+		chunk_ids[num_chunks] = GRAPH_CHUNKID_BASE;
+		num_chunks++;
+	}
 
 	chunk_ids[num_chunks] = 0;
 
@@ -1247,13 +1402,18 @@ static int write_commit_graph_file(struct write_commit_graph_context *ctx)
 						4 * ctx->num_extra_edges;
 		num_chunks++;
 	}
+	if (ctx->num_commit_graphs_after > 1) {
+		chunk_offsets[num_chunks + 1] = chunk_offsets[num_chunks] +
+						hashsz * (ctx->num_commit_graphs_after - 1);
+		num_chunks++;
+	}
 
 	hashwrite_be32(f, GRAPH_SIGNATURE);
 
 	hashwrite_u8(f, GRAPH_VERSION);
 	hashwrite_u8(f, oid_version());
 	hashwrite_u8(f, num_chunks);
-	hashwrite_u8(f, 0);
+	hashwrite_u8(f, ctx->num_commit_graphs_after - 1);
 
 	for (i = 0; i <= num_chunks; i++) {
 		uint32_t chunk_write[3];
@@ -1279,11 +1439,67 @@ static int write_commit_graph_file(struct write_commit_graph_context *ctx)
 	write_graph_chunk_data(f, hashsz, ctx);
 	if (ctx->num_extra_edges)
 		write_graph_chunk_extra_edges(f, ctx);
+	if (ctx->num_commit_graphs_after > 1 &&
+	    write_graph_chunk_base(f, ctx)) {
+		return -1;
+	}
 	stop_progress(&ctx->progress);
 	strbuf_release(&progress_title);
 
+	if (ctx->split && ctx->base_graph_name && ctx->num_commit_graphs_after > 1) {
+		char *new_base_hash = xstrdup(oid_to_hex(&ctx->new_base_graph->oid));
+		char *new_base_name = get_split_graph_filename(ctx->obj_dir, new_base_hash);
+
+		free(ctx->commit_graph_filenames_after[ctx->num_commit_graphs_after - 2]);
+		free(ctx->commit_graph_hash_after[ctx->num_commit_graphs_after - 2]);
+		ctx->commit_graph_filenames_after[ctx->num_commit_graphs_after - 2] = new_base_name;
+		ctx->commit_graph_hash_after[ctx->num_commit_graphs_after - 2] = new_base_hash;
+	}
+
 	close_commit_graph(ctx->r->objects);
-	finalize_hashfile(f, NULL, CSUM_HASH_IN_STREAM | CSUM_FSYNC);
+	finalize_hashfile(f, file_hash.hash, CSUM_HASH_IN_STREAM | CSUM_FSYNC);
+
+	if (ctx->split) {
+		FILE *chainf = fdopen_lock_file(&lk, "w");
+		char *final_graph_name;
+		int result;
+
+		close(fd);
+
+		if (!chainf) {
+			error(_("unable to open commit-graph chain file"));
+			return -1;
+		}
+
+		if (ctx->base_graph_name) {
+			result = rename(ctx->base_graph_name,
+					ctx->commit_graph_filenames_after[ctx->num_commit_graphs_after - 2]);
+
+			if (result) {
+				error(_("failed to rename base commit-graph file"));
+				return -1;
+			}
+		} else {
+			char *graph_name = get_commit_graph_filename(ctx->obj_dir);
+			unlink(graph_name);
+		}
+
+		ctx->commit_graph_hash_after[ctx->num_commit_graphs_after - 1] = xstrdup(oid_to_hex(&file_hash));
+		final_graph_name = get_split_graph_filename(ctx->obj_dir,
+					ctx->commit_graph_hash_after[ctx->num_commit_graphs_after - 1]);
+		ctx->commit_graph_filenames_after[ctx->num_commit_graphs_after - 1] = final_graph_name;
+
+		result = rename(ctx->graph_name, final_graph_name);
+
+		for (i = 0; i < ctx->num_commit_graphs_after; i++)
+			fprintf(lk.tempfile->fp, "%s\n", ctx->commit_graph_hash_after[i]);
+
+		if (result) {
+			error(_("failed to rename temporary commit-graph file"));
+			return -1;
+		}
+	}
+
 	commit_lock_file(&lk);
 
 	return 0;
@@ -1306,6 +1522,30 @@ int write_commit_graph(const char *obj_dir,
 	ctx->obj_dir = obj_dir;
 	ctx->append = flags & COMMIT_GRAPH_APPEND ? 1 : 0;
 	ctx->report_progress = flags & COMMIT_GRAPH_PROGRESS ? 1 : 0;
+	ctx->split = flags & COMMIT_GRAPH_SPLIT ? 1 : 0;
+
+	if (ctx->split) {
+		struct commit_graph *g;
+		prepare_commit_graph(ctx->r);
+
+		g = ctx->r->objects->commit_graph;
+
+		while (g) {
+			ctx->num_commit_graphs_before++;
+			g = g->base_graph;
+		}
+
+		if (ctx->num_commit_graphs_before) {
+			ALLOC_ARRAY(ctx->commit_graph_filenames_before, ctx->num_commit_graphs_before);
+			i = ctx->num_commit_graphs_before;
+			g = ctx->r->objects->commit_graph;
+
+			while (g) {
+				ctx->commit_graph_filenames_before[--i] = xstrdup(g->filename);
+				g = g->base_graph;
+			}
+		}
+	}
 
 	ctx->approx_nr_objects = approximate_object_count();
 	ctx->oids.alloc = ctx->approx_nr_objects / 32;
@@ -1360,6 +1600,14 @@ int write_commit_graph(const char *obj_dir,
 		goto cleanup;
 	}
 
+	if (!ctx->commits.nr)
+		goto cleanup;
+
+	if (ctx->split)
+		init_commit_graph_chain(ctx);
+	else
+		ctx->num_commit_graphs_after = 1;
+
 	compute_generation_numbers(ctx);
 
 	res = write_commit_graph_file(ctx);
@@ -1368,6 +1616,21 @@ int write_commit_graph(const char *obj_dir,
 	free(ctx->graph_name);
 	free(ctx->commits.list);
 	free(ctx->oids.list);
+
+	if (ctx->commit_graph_filenames_after) {
+		for (i = 0; i < ctx->num_commit_graphs_after; i++) {
+			free(ctx->commit_graph_filenames_after[i]);
+			free(ctx->commit_graph_hash_after[i]);
+		}
+
+		for (i = 0; i < ctx->num_commit_graphs_before; i++)
+			free(ctx->commit_graph_filenames_before[i]);
+
+		free(ctx->commit_graph_filenames_after);
+		free(ctx->commit_graph_filenames_before);
+		free(ctx->commit_graph_hash_after);
+	}
+
 	free(ctx);
 
 	return res;
@@ -1555,5 +1818,6 @@ void free_commit_graph(struct commit_graph *g)
 		g->data = NULL;
 		close(g->graph_fd);
 	}
+	free(g->filename);
 	free(g);
 }
diff --git a/commit-graph.h b/commit-graph.h
index 6e7d42cf32..c321834533 100644
--- a/commit-graph.h
+++ b/commit-graph.h
@@ -47,6 +47,7 @@ struct commit_graph {
 	unsigned char num_chunks;
 	uint32_t num_commits;
 	struct object_id oid;
+	char *filename;
 
 	uint32_t num_commits_in_base;
 	struct commit_graph *base_graph;
@@ -71,6 +72,7 @@ int generation_numbers_enabled(struct repository *r);
 
 #define COMMIT_GRAPH_APPEND     (1 << 0)
 #define COMMIT_GRAPH_PROGRESS   (1 << 1)
+#define COMMIT_GRAPH_SPLIT      (1 << 2)
 
 /*
  * The write_commit_graph* methods return zero on success
diff --git a/t/t5318-commit-graph.sh b/t/t5318-commit-graph.sh
index 3b6fd0d728..063f906b3e 100755
--- a/t/t5318-commit-graph.sh
+++ b/t/t5318-commit-graph.sh
@@ -20,7 +20,7 @@ test_expect_success 'verify graph with no graph file' '
 test_expect_success 'write graph with no packs' '
 	cd "$TRASH_DIRECTORY/full" &&
 	git commit-graph write --object-dir . &&
-	test_path_is_file info/commit-graph
+	test_path_is_missing info/commit-graph
 '
 
 test_expect_success 'close with correct error on bad input' '
-- 
gitgitgadget

