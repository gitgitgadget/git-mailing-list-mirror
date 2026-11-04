Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=103.168.172.146
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793807872;
	b=j4iy2VY10zgB7eeDQ0JmtKbEMqisje/OugN+MS+irkWMYYNBvy/tUiBJEQVmeEcoz2K6
	 W0JnJL8ugzosE7mA1VJgVtJ7SrlRNawDdVoX+dRw3XyRmJxmGyU13kpxVKdHzYR4w4c+a
	 8Iq6lAHjUaHdPMuG/gX/QQI1fkQOPqZY92WqTf0PJuJCtdv3IIDFTATgrGU1ZEqeGfeCu
	 gydtxbxRV0YapPplySPUibzgbi5tu/J4vgS/bFQg09IX8UvPqbkMWGEZ1jfLkN8oDlCMp
	 fhPvRoMXuQRwhcypouITS6loEZtu1kbFpNL5BcMi91ZwnDV+t8pTobWfybd37W5TipA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793807872;
	h=DMARC-Filter:Received:Received:DKIM-Signature:DKIM-Signature:
	 X-DKIM2-Info:DKIM2-Signature:X-DKIM2-Info:Message-Instance:
	 X-ME-Sender:X-ME-Received:X-ME-Proxy-Cause:X-ME-Proxy:Feedback-ID:
	 Received:Received:From:Date:Subject:MIME-Version:Content-Type:
	 Content-Transfer-Encoding:Message-Id:References:In-Reply-To:To:Cc:
	 X-Mailer;
	bh=TT6BzTfSvA3zO/1yaGhbSbm3AorK0GddlxzCUTeG9dA=;
	b=3h+DZZtvgV8xSt3QKdEp2mQcEtsp4J2mFU65puCIWnDpYOJUOq2QyHwKbDnSUpGxtdgF
	 pr1Lv3Uxr2FE80w1lDHhmb+4o/u4u8aS8zFsATgtEApHF1/NwNKCf/TOJLmCHeFWTr5zB
	 jJXzhauP3o05eerNd2QH9QFYGS4qZQ5S9HrF7GQMW+6rpTk3ivVhwBlB53ShVJ08+6iHh
	 oqqG5cP2nMcVcXCDhH6xtAtNdDzR/mQXAYNsbet9APiwcOiSvVy5XVN9R6mNmttZ+0iWO
	 1t3T/AeCGZBpYx+UuDiy8hCjWPT76FduvTwqYzYg9aeqqFHHO8n+XnEkIeec0FPni2g==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=pks.im;
	spf=pass smtp.mailfrom=pks.im;
	dkim=pass header.d=pks.im header.i=@pks.im header.a=rsa-sha256 header.s=fm3 header.b=jf1Xko+f;
	dkim=pass header.d=messagingengine.com header.i=@messagingengine.com header.a=rsa-sha256 header.s=fm3 header.b=n+XHcPM9;
	arc=none smtp.remote-ip=103.168.172.146
Received: from fout-a3-smtp.messagingengine.com (fout-a3-smtp.messagingengine.com [103.168.172.146])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3D500606EE9E
	for <git@vger.kernel.org>; Wed,  4 Nov 2026 15:57:52 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 3D500606EE9E
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=pks.im header.i=@pks.im header.a=rsa-sha256 header.s=fm3 header.b=jf1Xko+f;
	dkim=pass (2048-bit key, unprotected) header.d=messagingengine.com header.i=@messagingengine.com header.a=rsa-sha256 header.s=fm3 header.b=n+XHcPM9
Received: from phl-compute-04.internal (phl-compute-04.internal [10.202.2.44])
	by mailfout.phl.internal (Postfix) with ESMTP id 752CEEC00D7
	for <git@vger.kernel.org>; Wed,  4 Nov 2026 10:57:51 -0500 (EST)
Received: from phl-frontend-04 ([10.202.2.163])
  by phl-compute-04.internal (MEProxy); Wed, 04 Nov 2026 10:57:51 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm3; t=1793807871;
	 x=1793894271; bh=TT6BzTfSvA3zO/1yaGhbSbm3AorK0GddlxzCUTeG9dA=; b=
	jf1Xko+fTnWpqIFerlt3J61uyPab+Bp2c1kXNgUvzFaXwatHs0M95u/ZhYTjL1va
	pI4DMHiFLpccE/nAYF7Y+xdkLdJrcAOKj8oqYnKFoqka5/ZbxquUkdUR9e8Z1ZPI
	c/mG4og+EDnCV6hKfWP84Av9X0FJOsGlvjz4OfkbyMzmLxYiZxGg3EtoKdTSotHf
	lXiSa4VW1fe9F51xLP2e+VPVaw8v/1ppJTRGEag1qrkvPG57PVmuic9Nzqa/7Pqy
	gMpq6/oCFqXy4bSzPs49moypvcZDNDue1iyBPhzk6oPldTJ0UPPhja30wA0PaYaE
	xZDQv0UYXf6XtPG263MEMw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1793807871; x=
	1793894271; bh=TT6BzTfSvA3zO/1yaGhbSbm3AorK0GddlxzCUTeG9dA=; b=n
	+XHcPM9yYZ5pbd/CuOI1/pkcJkTbVYEfFb7uz+eddoXC++DsjAD3xJ6sSRsr231P
	FSfc0YTn1LeOl+xqRDqPELPQ7wushdWabMdATHT59uRxEG3T3b/sbqEMX7W8oBBg
	yYWakTC06uxdVGr8HnrMF1pdBzwdPPIwfkoLs92wtXvqcSGqNosRhfWqgYGdojoe
	3NUU8o5iS+J+IYOqrIRN4EDnPqZuySzxtTk7kSml3DH3dmT6G/lG+6tCqIMRbN3d
	snFZOGgO71V/dQQH7fUay7SoHU2sR6x5FAt+PqfzcLUyy0tj+pK2c/V81l+necpn
	56O/7kQXUFZxw3P/Vw4Gg==
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-08;
	repo=github.com/dkim2wg/interop; date=2026-10-28; sw=lmtpprox;
	action=sign d=pks.im a=rsa-sha256;
DKIM2-Signature: i=1; m=1; t=1793807871; d=pks.im; mf=PHBzQHBrcy5pbT4=;
	rt=PGdpdEB2Z2VyLmtlcm5lbC5vcmc+;
	s=fm3:rsa-sha256:JXLPaWH5TawnbCxIfRTHRZJtTIpQ2j5hWp9szrkrumx98m/
	se33hR+9nS7kMcn4GUTAimhaXcXkHcyczmitTifyr720UDKVjzBhZ0quG/NARpft
	FN6CEVhdQCH11l3sUUa0dPxIG6/0j6x5KlsJexFHh0OTSXoiemKVNtEhBVmWVvZP
	jOU313wrvY1+JuV0vPxKBeVECjWoBMjFq2FmOOtm3AQ6Bq+uIL7K2pL/I5Sc+4lY
	lWmgzC0XNrwBv3QRJeYnXsfQvvnzJG4zlU+su4nH8oTxkoTH0Rnb2xyap9BNaSbp
	HoW2ZbLFYXbQWRIx6J8DklAFN9yVoYFbSnqrC/w==;
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-08;
	repo=github.com/dkim2wg/interop; date=2026-10-28; sw=lmtpprox;
	action=mi-m=1; hc=12;
	hn=cc,content-transfer-encoding,content-type,date,feedback-id,
	from,in-reply-to,message-id,mime-version,references,subject,to;
Message-Instance: m=1; h=sha256:nshMpRlPcUZLhDIXXRznVi+bCPFRHH3g4VD8oMZFImM=:tUY29DGtilQvlFhvUoi4PG4QYivOST6IWiLTvlpsDiA=;
X-ME-Sender: <xms:_1XragEEWZHoSz6hIBhkSyre4sqZAI19JOX29w69DfOdtSZrHL6F0A>
    <xme:_1XragSvCxLWYSrf2hk27Q_6nV_8L2iz3LEOed-uN5-Mtm8q6KsLOeUg6E9ABjeE3
    OUIpfRriLewjvNl9jyqZTtgVyJZ4MHdxeDK-zCvZ5uT67-n-H7JMA>
X-ME-Received: <xmr:_1XravyHCXoZBZmYQlEvrsH7g-HMy3sQLSiv0GtX5cxRjUSXtpJrbhOsCliLNAgeIALPnf4>
X-ME-Proxy-Cause: dmFkZTEijChPbfh12L7GHgr1wrlICXQjT2WvPmwEzxfsGQeLnPBN5oSEwqQKp1JrSMf4h2
    DTN/FhucVO/TQWnw9AZiUtvh8J+fsiLopNU0yraxvKr/Q5k6FwxtXHmQHlwXcQwI9Lgxa2
    KpQciHVAjeQsDLrFiis2meieS5nomLtKrrgC2Bfp/5mKeU/162bo79wFoJ0Cq01G8nOoTz
    k5sL5HSaBb+b4flS4nj1fvAsLywsdoo6Dhiicp1vKE1NVHIIUp/v+/Aah8Go+J72JZTS+p
    B8AZs+BBkJIvGkshYWCxV+sfbpqUheUXpJxmAzqikWEJhVTHdVWlEIBaAQ/FD3Gk7XlqE6
    /m/VA0WwQ+A29o6g0JkASvHaFDdgSb1OwTN2vNya/iLDhOwo1waZs7r0Z85JE+zLnixcts
    LvQ8N6PFFen+033f/sSsNNq59fouwNM8eGdM6efrvVcuo+P+KhHADStUCtP7KTvNFhY/KM
    VJfwyR8tUlLsxGuyC049IPYhXQU2tXXG3goH2VvpaABZjubeKJY5iL9RcSZGFwJOibXqbm
    hVVMQ2nlRdU7ZSJbCBR862s3EphY0NKZKADuJK4w1MlX2jkA3KWXCnz/E0CIHkFtOX9N8c
    xkMBkNehTHY0mKL/jpQCumiKvyz5PEJQphYwrrkY6TtWQ+tM4oqgq4+JMOGg
X-ME-Proxy: <xmx:_1XranPPANMWEJpalrByop5tpBob1Ea31u05MrxL-NdtHks5RUTOHA>
    <xmx:_1XramOb4ioNtPtBUYksyfgPa2puB1OwcZ3saTlUeJcTLG6IOVUmpQ>
    <xmx:_1XrahQIBrWspjvYK0QLfu4IG8BLuYvCHr1UV_qcPCrXBWJl_S1vKA>
    <xmx:_1XragByQlj46-PgmU5XrmGMdVxKGXt3ZGtC9FgzH-iN8fltVTq4Rg>
    <xmx:_1XraqXh4xZ0_ZBKUmR57dxaNxy4ban93sMqkbIElGIvWn-8tjFV4n4G>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA for
 <git@vger.kernel.org>; Wed, 4 Nov 2026 10:57:50 -0500 (EST)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id 63d45246 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO)
	for <git@vger.kernel.org>;
	Wed, 4 Nov 2026 15:57:50 +0000 (UTC)
From: Patrick Steinhardt <ps@pks.im>
Date: Wed, 04 Nov 2026 16:57:27 +0100
Subject: [PATCH 05/10] commit-graph: merge the two commit graph writers
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Post: <mailto:git@vger.kernel.org>
List-Help: <mailto:git+help@vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
List-Owner: <mailto:git+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261104-pks-commit-graph-write-refactorings-v1-5-d013d9401a59@pks.im>
References: <20261104-pks-commit-graph-write-refactorings-v1-0-d013d9401a59@pks.im>
In-Reply-To: <20261104-pks-commit-graph-write-refactorings-v1-0-d013d9401a59@pks.im>
To: git@vger.kernel.org
Cc: 
X-Mailer: b4 0.15.2

We have two entry points for writing commit graphs:

  - `write_commit_graph()` either writes a commit graph for all commits
    in the object database, or for the commits specified via its options
    struct.

  - `write_commit_graph_reachable()` writes a commit graph for all
    reachable commits.

It's somewhat pointless though to have a separate entry point for
writing a commit graph for reachable commits, as this use case can be
trivially satisfied via a flag.

Introduce that flag and drop the separate entry point in favor of
`write_commit_graph()`. This ensures we have a single entry point for
writing commit graphs, only, which will make it easier to eventually
introduce pluggable commit graphs via the object database.

Signed-off-by: Patrick Steinhardt <ps@pks.im>
---
 builtin/commit-graph.c |  8 ++------
 builtin/fetch.c        |  7 +++++--
 builtin/gc.c           |  5 +++--
 commit-graph.c         | 47 ++++++++++++++++++++++-------------------------
 commit-graph.h         |  4 +---
 5 files changed, 33 insertions(+), 38 deletions(-)

diff --git a/builtin/commit-graph.c b/builtin/commit-graph.c
index d49faf543b4..644f7736c91 100644
--- a/builtin/commit-graph.c
+++ b/builtin/commit-graph.c
@@ -299,17 +299,13 @@ static int cmd_commit_graph_write(int argc,
 	if (opts.enable_changed_paths == 1 ||
 	    git_env_bool(GIT_TEST_COMMIT_GRAPH_CHANGED_PATHS, 0))
 		write_opts.flags |= COMMIT_GRAPH_WRITE_BLOOM_FILTERS;
+	if (opts.reachable)
+		write_opts.flags |= COMMIT_GRAPH_WRITE_REACHABLE;
 
 	dir = odb_source_files_find_dir(repo->objects, opts.obj_dir);
 	if (!dir)
 		die(_("could not find object directory matching %s"), opts.obj_dir);
 
-	if (opts.reachable) {
-		if (write_commit_graph_reachable(repo, dir->abspath, &write_opts))
-			result = 1;
-		goto cleanup;
-	}
-
 	if (opts.stdin_packs) {
 		struct strbuf packname = STRBUF_INIT;
 		size_t dirlen;
diff --git a/builtin/fetch.c b/builtin/fetch.c
index b76e7725728..637d7ddaa06 100644
--- a/builtin/fetch.c
+++ b/builtin/fetch.c
@@ -2941,6 +2941,8 @@ int cmd_fetch(int argc,
 		write_opts.flags |= COMMIT_GRAPH_WRITE_SPLIT;
 		if (progress)
 			write_opts.flags |= COMMIT_GRAPH_WRITE_PROGRESS;
+		if (graph_write_mode != GRAPH_WRITE_TIPS)
+			write_opts.flags |= COMMIT_GRAPH_WRITE_REACHABLE;
 
 		if (graph_write_mode != GRAPH_WRITE_SKIP) {
 			trace2_region_enter("fetch", "write-commit-graph",
@@ -2951,9 +2953,10 @@ int cmd_fetch(int argc,
 					the_repository->objects->source->path,
 					NULL, &updated_tips, &write_opts);
 			else
-				write_commit_graph_reachable(
+				write_commit_graph(
 					the_repository,
-					the_repository->objects->source->path, &write_opts);
+					the_repository->objects->source->path,
+					NULL, NULL, &write_opts);
 			trace2_region_leave("fetch", "write-commit-graph",
 					    the_repository);
 		}
diff --git a/builtin/gc.c b/builtin/gc.c
index a157909ed54..709789dbf2c 100644
--- a/builtin/gc.c
+++ b/builtin/gc.c
@@ -737,11 +737,12 @@ int cmd_gc(int argc,
 	if (the_repository->settings.gc_write_commit_graph == 1) {
 		struct commit_graph_write_options write_opts = COMMIT_GRAPH_WRITE_OPTIONS_INIT;
 
+		write_opts.flags |= COMMIT_GRAPH_WRITE_REACHABLE;
 		if (!opts.quiet && !daemonized)
 			write_opts.flags |= COMMIT_GRAPH_WRITE_PROGRESS;
 
-		write_commit_graph_reachable(the_repository,
-					     the_repository->objects->source->path, &write_opts);
+		write_commit_graph(the_repository, the_repository->objects->source->path,
+				   NULL, NULL, &write_opts);
 	}
 
 	if (!daemonized) {
diff --git a/commit-graph.c b/commit-graph.c
index 4f3563f4d0b..97be0f71484 100644
--- a/commit-graph.c
+++ b/commit-graph.c
@@ -37,10 +37,11 @@ void git_test_write_commit_graph_or_die(struct repository *repo)
 	if (!git_env_bool(GIT_TEST_COMMIT_GRAPH, 0))
 		return;
 
+	opts.flags |= COMMIT_GRAPH_WRITE_REACHABLE;
 	if (git_env_bool(GIT_TEST_COMMIT_GRAPH_CHANGED_PATHS, 0))
 		opts.flags |= COMMIT_GRAPH_WRITE_BLOOM_FILTERS;
 
-	if (write_commit_graph_reachable(repo, repo->objects->source->path, &opts))
+	if (write_commit_graph(repo, repo->objects->source->path, NULL, NULL, &opts))
 		die("failed to write commit-graph under GIT_TEST_COMMIT_GRAPH");
 }
 
@@ -1910,32 +1911,23 @@ static int add_ref_to_set(const struct reference *ref, void *cb_data)
 	return 0;
 }
 
-int write_commit_graph_reachable(struct repository *repo,
-				 const char *dir,
-				 const struct commit_graph_write_options *opts)
+static void fill_oids_from_reachable(struct write_commit_graph_context *ctx,
+				     struct oidset *commits)
 {
-	struct oidset commits = OIDSET_INIT;
-	struct refs_cb_data data;
-	int result;
-
-	memset(&data, 0, sizeof(data));
-	data.repo = repo;
-	data.commits = &commits;
+	struct refs_cb_data data = {
+		.repo = ctx->r,
+		.commits = commits,
+	};
 
-	if (opts->flags & COMMIT_GRAPH_WRITE_PROGRESS)
+	if (ctx->opts->flags & COMMIT_GRAPH_WRITE_PROGRESS)
 		data.progress = start_delayed_progress(
-			repo,
+			ctx->r,
 			_("Collecting referenced commits"), 0);
 
-	refs_for_each_ref(get_main_ref_store(repo), add_ref_to_set,
+	refs_for_each_ref(get_main_ref_store(ctx->r), add_ref_to_set,
 			  &data);
 
 	stop_progress(&data.progress);
-
-	result = write_commit_graph(repo, dir, NULL, &commits, opts);
-
-	oidset_clear(&commits);
-	return result;
 }
 
 static int fill_oids_from_packs(struct write_commit_graph_context *ctx,
@@ -2567,9 +2559,13 @@ int write_commit_graph(struct repository *r,
 	int res = 0;
 	int replace = 0;
 	struct bloom_filter_settings bloom_settings = DEFAULT_BLOOM_FILTER_SETTINGS;
+	struct oidset reachable_commits = OIDSET_INIT;
 	struct topo_level_slab topo_levels;
 	struct commit_graph *g;
 
+	if (!!pack_indexes + !!commits + !!(opts->flags & COMMIT_GRAPH_WRITE_REACHABLE) > 1)
+		BUG("attempting to write commit-graph with mutually incompatible options");
+
 	prepare_repo_settings(r);
 	if (!r->settings.core_commit_graph) {
 		warning(_("attempting to write a commit-graph, but 'core.commitGraph' is disabled"));
@@ -2652,14 +2648,14 @@ int write_commit_graph(struct repository *r,
 		ctx.order_by_pack = 1;
 		if ((res = fill_oids_from_packs(&ctx, pack_indexes)))
 			goto cleanup;
-	}
-
-	if (commits) {
+	} else if (commits) {
 		if ((res = fill_oids_from_commits(&ctx, commits)))
 			goto cleanup;
-	}
-
-	if (!pack_indexes && !commits) {
+	} else if (opts->flags & COMMIT_GRAPH_WRITE_REACHABLE) {
+		fill_oids_from_reachable(&ctx, &reachable_commits);
+		if ((res = fill_oids_from_commits(&ctx, &reachable_commits)))
+			goto cleanup;
+	} else {
 		ctx.order_by_pack = 1;
 		fill_oids_from_all_packs(&ctx);
 	}
@@ -2710,6 +2706,7 @@ int write_commit_graph(struct repository *r,
 	free(ctx.base_graph_name);
 	free(ctx.dir);
 	commit_stack_clear(&ctx.commits);
+	oidset_clear(&reachable_commits);
 	oid_array_clear(&ctx.oids);
 	clear_topo_level_slab(&topo_levels);
 
diff --git a/commit-graph.h b/commit-graph.h
index 7461093a990..4adbd5f18d9 100644
--- a/commit-graph.h
+++ b/commit-graph.h
@@ -160,6 +160,7 @@ enum commit_graph_write_flags {
 	COMMIT_GRAPH_WRITE_SPLIT      = (1 << 2),
 	COMMIT_GRAPH_WRITE_BLOOM_FILTERS = (1 << 3),
 	COMMIT_GRAPH_NO_WRITE_BLOOM_FILTERS = (1 << 4),
+	COMMIT_GRAPH_WRITE_REACHABLE  = (1 << 5),
 };
 
 enum commit_graph_split_flags {
@@ -192,9 +193,6 @@ struct commit_graph_write_options {
  * canonicalized internally so that it compares equal to the directory of
  * graphs that have already been loaded.
  */
-int write_commit_graph_reachable(struct repository *repo,
-				 const char *dir,
-				 const struct commit_graph_write_options *opts);
 int write_commit_graph(struct repository *r,
 		       const char *dir,
 		       const struct string_list *pack_indexes,

-- 
2.56.0.500.g5d06dc02cd.dirty

