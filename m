Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=103.168.172.154
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793807870;
	b=C85JIjVAiiQyjIOgRW+NtntQ3h85Y/HO2oVcaSDQiw4XsCtlxsxUQVetWpm6pObaxg/5
	 HEu08toCN3H2JsAH1h2yh0ljM0bHiy9K1gxHYHj47Hu6L0cW3ESbVfnvosDZsDj/xR6hr
	 hGBs0Mya3Au8CbVYioghTGmXAugIK+drg96QhC/3KQRU/q1j+jIu8wDsf0M6DGmlnXCyU
	 Lv+jGtw4bKl72iWCAd8jMOMC3M5slnlPxlW+W9t2rZciQx+stnHlWf8ah/DrdxfLnbbiA
	 pUFTwXWKt60Z+WXjqyD3HWfqrpywBvFWnhYVqLu47p+W7lr5KOhMd3xM6DG8etkxiIA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793807870;
	h=DMARC-Filter:Received:Received:DKIM-Signature:DKIM-Signature:
	 X-DKIM2-Info:DKIM2-Signature:X-DKIM2-Info:Message-Instance:
	 X-ME-Sender:X-ME-Received:X-ME-Proxy-Cause:X-ME-Proxy:Feedback-ID:
	 Received:Received:From:Date:Subject:MIME-Version:Content-Type:
	 Content-Transfer-Encoding:Message-Id:References:In-Reply-To:To:Cc:
	 X-Mailer;
	bh=543P9JaUh95Z4rijiwBXNjCkWK+p+OGU4LFnrtJ68IE=;
	b=FFrj4cX4XN58fhOfz2i2plgQAGSEkgtp8n4eSVECl620MSYO52ZoHAQbm+M5Ev7ING4i
	 7T1u1+o18a/0A7urT0zTndSOdleOfTmIobza6IqgveuKv6XVcliJgQ5xniTTtsQQqSzAW
	 5jmuRWt/r3qYaQnIut0lR86IzFcLdsIbZrhghoWaZWrdD5bkxxx8lBiX0R1aPqgBLN2ME
	 mHfE3osTPs3Vr9TA1R8/TvhWJ4L4kJhulac4kDyGKYsx/hpJ+dg5KryXKUPrJ35WEKn8a
	 v3KOja29JvXNSaiAE7pg8RDnnZt4Ovp7LhKyVB+MItHafnTyYb4sz9BQ0eQcJJsiyzQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=pks.im;
	spf=pass smtp.mailfrom=pks.im;
	dkim=pass header.d=pks.im header.i=@pks.im header.a=rsa-sha256 header.s=fm3 header.b=y6suq6ID;
	dkim=pass header.d=messagingengine.com header.i=@messagingengine.com header.a=rsa-sha256 header.s=fm3 header.b=PWv49bIw;
	arc=none smtp.remote-ip=103.168.172.154
Received: from fhigh-a3-smtp.messagingengine.com (fhigh-a3-smtp.messagingengine.com [103.168.172.154])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9B2A9606D802
	for <git@vger.kernel.org>; Wed,  4 Nov 2026 15:57:49 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 9B2A9606D802
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=pks.im header.i=@pks.im header.a=rsa-sha256 header.s=fm3 header.b=y6suq6ID;
	dkim=pass (2048-bit key, unprotected) header.d=messagingengine.com header.i=@messagingengine.com header.a=rsa-sha256 header.s=fm3 header.b=PWv49bIw
Received: from phl-compute-07.internal (phl-compute-07.internal [10.202.2.47])
	by mailfhigh.phl.internal (Postfix) with ESMTP id D41DE1400153
	for <git@vger.kernel.org>; Wed,  4 Nov 2026 10:57:48 -0500 (EST)
Received: from phl-frontend-04 ([10.202.2.163])
  by phl-compute-07.internal (MEProxy); Wed, 04 Nov 2026 10:57:48 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm3; t=1793807868;
	 x=1793894268; bh=543P9JaUh95Z4rijiwBXNjCkWK+p+OGU4LFnrtJ68IE=; b=
	y6suq6IDUeCPEApVRg6TFL0rdpANKVm26e7/hjJJK+tlLqfyg6ZHmwP6f+nVTDrR
	9TjEvv9KZ7rWFeUWHTfEgFuOS0x92tPgBduPJcZIcc0QW+AGkMK2NUCDeqRXAjwG
	EjzfC1iAmupvIcIrf1xzFPZT93P+anUOCuV+OpUOSXDT5l6Og/AXkYmNnscyvAKa
	ZPY0/kIgLylqdpOppLaeyC0J/zfLA071TlieIxWo/KwKD4yp02U7/jHDkbsE4q94
	1ohKot1KHSX/uwxU4q5pRRppakUmVMiYoQxzkKj1twlNygtFj+GQJ8MVu2rI5lmm
	XE/NKNT0vBY8/0c0PE277g==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1793807868; x=
	1793894268; bh=543P9JaUh95Z4rijiwBXNjCkWK+p+OGU4LFnrtJ68IE=; b=P
	Wv49bIwC9ID5D70I/nrMylPOlxD54ajYa7ojxJpVsQwUTyzTY6BzniPQmGJr6/lQ
	zOAIfVrEK+v78343ypNMi9aPlm9Wy5CjHcrsYLrMoS6A66HIFl6etzxKuYAyGhaj
	/U/1ZzAxdAGcm5EMSN1nJmh922Nq29Mw0NnavuNoT0Lg91XUBopN4O4+yFJtu5lx
	86sg27XRZkVNi01wCU9X0m6EZBay1l566Ndo7oNfLZJRqjod7dR8ShneBwHq7uel
	oiJ/VGdVK6qjFkeDvkNG+VzdbOVnVzQUnKYTY1V+ki7fGeCrAn5NDluDOiN/Bgrh
	tG8aGkT2SCtHpDlpVdk2Q==
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-08;
	repo=github.com/dkim2wg/interop; date=2026-10-28; sw=lmtpprox;
	action=sign d=pks.im a=rsa-sha256;
DKIM2-Signature: i=1; m=1; t=1793807868; d=pks.im; mf=PHBzQHBrcy5pbT4=;
	rt=PGdpdEB2Z2VyLmtlcm5lbC5vcmc+;
	s=fm3:rsa-sha256:nOIAI1oZusyoIsGWjr2iuq/oFi5DDzXyHCBERS/cWTUcFxf
	P5AFrmdqbippUuPHpmGwXE2dQpm4O66QkM2Jv+cwNdHyaG0GC+iqcPhSyL+/DMGD
	Rxk69h0nL2zKsucyhdLX0YdpyBpaww9UqpKFnEK8nPiAr7fLEN4HvFgi3pVXNLE8
	haaGmOH12Gu3qYnGoxTrwCRKz6DTiVaJGN++t/sCLHosR8EhJlHQQlVv8KoOYEKT
	9rZ72EMT3f8JMMs6bgWWfrs4tnVv4tlYQI1xQCGvtNjuA0g5ww7rpnXiCG1rtYmA
	5fq/JcTPcg/6OF1r/a5W3MsmdjW8usPtw1a/CWg==;
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-08;
	repo=github.com/dkim2wg/interop; date=2026-10-28; sw=lmtpprox;
	action=mi-m=1; hc=12;
	hn=cc,content-transfer-encoding,content-type,date,feedback-id,
	from,in-reply-to,message-id,mime-version,references,subject,to;
Message-Instance: m=1; h=sha256:YR1mcrk+xQbhrm0t5JEpGj6FCjxd/QvkJLKj2SculP4=:cUr+XgCwA+3iuojjXUQNKyd1nZKxbvXjEfStqFJGgU8=;
X-ME-Sender: <xms:_FXraupQqwhgoSQzG0WHe_dQJTACdg9XkmlTEJpFzZrfZYrYmeuLbg>
    <xme:_FXrajnE-8VEP5QKSCmHdezDpbIjLnWjoxLRY9XZOzLBSyiyxXgG5V-E8lfcpj6jw
    j5lLzBQACVDjeFomqRhNJbJ-Waq95D-GiMsxgSFz8TxdWo1N_KUrA>
X-ME-Received: <xmr:_FXrao0tLE2zOsJmoQZtUYmfuCkXnKjOrEmS2I2xn4cJb9l5edKElco3wGmvIyxW4jiscKE>
X-ME-Proxy-Cause: dmFkZTFw3tLeqBm2yMfxOXiI7pizCa0BvSrd+MN0reYyXc8v4g2hytQ3bivqJOo2obrD5k
    SpaZW2vebwJ1KtSeer+Sijnsorv13fH0nSGt9T/GJzADexDMBI+CoqtbP8QDG1iwN9ihjf
    ptbnStT47Mv8LArOF53GI2nE52RFb12Yi70W59OzASzT9plTJYHdFDFZk7v+8D5oNRwvyE
    8u9XZPkV6ImDDxaF9dmpntsX0OnnFqBOACOetDa0Iu9btWNsN9xHoDyCvNJvew2QAKYKie
    O63igIdY32S2FmLcKxnXdzbcl8aaP2nWm6udRoayKCEzdWX3i4hYw4oQOze7/AScJ2HUBh
    mmEjIqGGd6cD84QKvNE+hrQhenUl8en35ljcMJexPivjlZG3r3HzpTNx98Jv5D6viAhOla
    DtYEE2FVjedVh1lbomaXaACfCJbTY5QFQN9LtdPLdk5SFfDqblm3MCBOFbalgenSNvUh3V
    Z3bq9aC9Jk9jeP3zRanJTCPPg58s8O4d3Di4O5viPR001qmBWQFg3CADcGezFypskOiZ+x
    TLMIazjN8CtwYWSJ1C1A4T3jAy3ZJF3JUCNeNkFjRhegdwNJHlcpeGO/NnifzOew9zzF4x
    oz6scrSwVc1hbYZJnhfjAENZx0jiML1KeWaIFkTmcb0vPFpNtOuqo4Detykw
X-ME-Proxy: <xmx:_FXrajCULTkTOEd2GSyAad86pXrQzhj4aG8SAeB3InLwnvUQVNx1KQ>
    <xmx:_FXratwt8CgK2_U0tDwDRKUqfiAHrAp5pIsMq6jvAn5lvV25CLlvSQ>
    <xmx:_FXrapkb8gexBbrzvH-R-1BLY5SJswDHD1YcywuUm30183xfvGNzkQ>
    <xmx:_FXraqE_7BSoajGHPdqztsw5uGxXGld61hwuA2kXFoek6rs1BAco4Q>
    <xmx:_FXraqJPb2c0n5CNITia9sFPl4fqF62-OGEUIYBdyIBD45l6fM060AhZ>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA for
 <git@vger.kernel.org>; Wed, 4 Nov 2026 10:57:48 -0500 (EST)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id be2e9011 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO)
	for <git@vger.kernel.org>;
	Wed, 4 Nov 2026 15:57:47 +0000 (UTC)
From: Patrick Steinhardt <ps@pks.im>
Date: Wed, 04 Nov 2026 16:57:26 +0100
Subject: [PATCH 04/10] commit-graph: drop redundant flags in write context
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
Message-Id: <20261104-pks-commit-graph-write-refactorings-v1-4-d013d9401a59@pks.im>
References: <20261104-pks-commit-graph-write-refactorings-v1-0-d013d9401a59@pks.im>
In-Reply-To: <20261104-pks-commit-graph-write-refactorings-v1-0-d013d9401a59@pks.im>
To: git@vger.kernel.org
Cc: 
X-Mailer: b4 0.15.2

In the preceding commit we have moved the flags that control how we
write a commit graph into its options structure. As a consequence we
have those flags implicitly available in the write context, too, as it
already contains a pointer to the options struct. This makes a couple of
individual flags that we track in the write context redundant as they
are a simple alias of the flags.

Drop these redundant flags.

Signed-off-by: Patrick Steinhardt <ps@pks.im>
---
 commit-graph.c | 61 ++++++++++++++++++++++++++++------------------------------
 1 file changed, 29 insertions(+), 32 deletions(-)

diff --git a/commit-graph.c b/commit-graph.c
index e86569b7ced..4f3563f4d0b 100644
--- a/commit-graph.c
+++ b/commit-graph.c
@@ -1158,10 +1158,7 @@ struct write_commit_graph_context {
 	uint32_t new_num_commits_in_base;
 	struct commit_graph *new_base_graph;
 
-	unsigned append:1,
-		 report_progress:1,
-		 split:1,
-		 changed_paths:1,
+	unsigned changed_paths:1,
 		 order_by_pack:1,
 		 write_generation_data:1,
 		 trust_generation_numbers:1;
@@ -1570,7 +1567,7 @@ static void close_reachable(struct write_commit_graph_context *ctx)
 	struct commit *commit;
 	enum commit_graph_split_flags flags = ctx->opts->split_flags;
 
-	if (ctx->report_progress)
+	if (ctx->opts->flags & COMMIT_GRAPH_WRITE_PROGRESS)
 		ctx->progress = start_delayed_progress(
 					ctx->r,
 					_("Loading known commits in commit graph"),
@@ -1588,7 +1585,7 @@ static void close_reachable(struct write_commit_graph_context *ctx)
 	 * than the number of missing commits in the reachable
 	 * closure.
 	 */
-	if (ctx->report_progress)
+	if (ctx->opts->flags & COMMIT_GRAPH_WRITE_PROGRESS)
 		ctx->progress = start_delayed_progress(
 					ctx->r,
 					_("Expanding reachable commits in commit graph"),
@@ -1599,7 +1596,7 @@ static void close_reachable(struct write_commit_graph_context *ctx)
 
 		if (!commit)
 			continue;
-		if (ctx->split) {
+		if (ctx->opts->flags & COMMIT_GRAPH_WRITE_SPLIT) {
 			if ((!repo_parse_commit(ctx->r, commit) &&
 			     commit_graph_position(commit) == COMMIT_NOT_FROM_GRAPH) ||
 			    flags == COMMIT_GRAPH_SPLIT_REPLACE)
@@ -1609,7 +1606,7 @@ static void close_reachable(struct write_commit_graph_context *ctx)
 	}
 	stop_progress(&ctx->progress);
 
-	if (ctx->report_progress)
+	if (ctx->opts->flags & COMMIT_GRAPH_WRITE_PROGRESS)
 		ctx->progress = start_delayed_progress(
 					ctx->r,
 					_("Clearing commit marks in commit graph"),
@@ -1731,7 +1728,7 @@ static void compute_topological_levels(struct write_commit_graph_context *ctx)
 		.data = ctx,
 	};
 
-	if (ctx->report_progress)
+	if (ctx->opts->flags & COMMIT_GRAPH_WRITE_PROGRESS)
 		info.progress = ctx->progress
 			      = start_delayed_progress(
 					ctx->r,
@@ -1766,7 +1763,7 @@ static void compute_generation_numbers(struct write_commit_graph_context *ctx)
 		.set_generation = set_generation_v2,
 	};
 
-	if (ctx->report_progress)
+	if (ctx->opts->flags & COMMIT_GRAPH_WRITE_PROGRESS)
 		info.progress = ctx->progress
 			      = start_delayed_progress(
 					ctx->r,
@@ -1844,7 +1841,7 @@ static void compute_bloom_filters(struct write_commit_graph_context *ctx)
 
 	init_bloom_filters();
 
-	if (ctx->report_progress)
+	if (ctx->opts->flags & COMMIT_GRAPH_WRITE_PROGRESS)
 		progress = start_delayed_progress(
 			ctx->r,
 			_("Computing commit changed paths Bloom filters"),
@@ -1948,7 +1945,7 @@ static int fill_oids_from_packs(struct write_commit_graph_context *ctx,
 	struct strbuf progress_title = STRBUF_INIT;
 	int ret = 0;
 
-	if (ctx->report_progress) {
+	if (ctx->opts->flags & COMMIT_GRAPH_WRITE_PROGRESS) {
 		strbuf_addf(&progress_title,
 			    Q_("Finding commits for commit graph in %"PRIuMAX" pack",
 			       "Finding commits for commit graph in %"PRIuMAX" packs",
@@ -2014,7 +2011,7 @@ static void fill_oids_from_all_packs(struct write_commit_graph_context *ctx)
 		.typep = &type,
 	};
 
-	if (ctx->report_progress)
+	if (ctx->opts->flags & COMMIT_GRAPH_WRITE_PROGRESS)
 		ctx->progress = start_delayed_progress(
 			ctx->r,
 			_("Finding commits for commit graph among packed objects"),
@@ -2037,7 +2034,7 @@ static void copy_oids_to_commits(struct write_commit_graph_context *ctx)
 	enum commit_graph_split_flags flags = ctx->opts->split_flags;
 
 	ctx->num_extra_edges = 0;
-	if (ctx->report_progress)
+	if (ctx->opts->flags & COMMIT_GRAPH_WRITE_PROGRESS)
 		ctx->progress = start_delayed_progress(
 			ctx->r,
 			_("Finding extra edges in commit graph"),
@@ -2051,11 +2048,13 @@ static void copy_oids_to_commits(struct write_commit_graph_context *ctx)
 
 		commit = lookup_commit(ctx->r, &ctx->oids.oid[i]);
 
-		if (ctx->split && flags != COMMIT_GRAPH_SPLIT_REPLACE &&
+		if ((ctx->opts->flags & COMMIT_GRAPH_WRITE_SPLIT) &&
+		    flags != COMMIT_GRAPH_SPLIT_REPLACE &&
 		    commit_graph_position(commit) != COMMIT_NOT_FROM_GRAPH)
 			continue;
 
-		if (ctx->split && flags == COMMIT_GRAPH_SPLIT_REPLACE)
+		if ((ctx->opts->flags & COMMIT_GRAPH_WRITE_SPLIT) &&
+		    flags == COMMIT_GRAPH_SPLIT_REPLACE)
 			repo_parse_commit(ctx->r, commit);
 		else
 			repo_parse_commit_no_graph(ctx->r, commit);
@@ -2100,14 +2099,14 @@ static int write_commit_graph_file(struct write_commit_graph_context *ctx)
 {
 	uint32_t i;
 	struct hashfile *f;
-	struct tempfile *graph_layer; /* when ctx->split is non-zero */
+	struct tempfile *graph_layer; /* when COMMIT_GRAPH_WRITE_SPLIT is non-zero */
 	struct lock_file lk = LOCK_INIT;
 	const unsigned hashsz = ctx->r->hash_algo->rawsz;
 	struct strbuf progress_title = STRBUF_INIT;
 	struct chunkfile *cf;
 	unsigned char file_hash[GIT_MAX_RAWSZ];
 
-	if (ctx->split) {
+	if (ctx->opts->flags & COMMIT_GRAPH_WRITE_SPLIT) {
 		struct strbuf tmp_file = STRBUF_INIT;
 
 		strbuf_addf(&tmp_file,
@@ -2124,7 +2123,7 @@ static int write_commit_graph_file(struct write_commit_graph_context *ctx)
 		return -1;
 	}
 
-	if (ctx->split) {
+	if (ctx->opts->flags & COMMIT_GRAPH_WRITE_SPLIT) {
 		char *lock_name = get_commit_graph_chain_filename(ctx->dir);
 
 		repo_hold_lock_file_for_update_mode(ctx->r, &lk, lock_name,
@@ -2195,7 +2194,7 @@ static int write_commit_graph_file(struct write_commit_graph_context *ctx)
 	hashwrite_u8(f, get_num_chunks(cf));
 	hashwrite_u8(f, ctx->num_commit_graphs_after - 1);
 
-	if (ctx->report_progress) {
+	if (ctx->opts->flags & COMMIT_GRAPH_WRITE_PROGRESS) {
 		strbuf_addf(&progress_title,
 			    Q_("Writing out commit graph in %d pass",
 			       "Writing out commit graph in %d passes",
@@ -2212,7 +2211,8 @@ static int write_commit_graph_file(struct write_commit_graph_context *ctx)
 	stop_progress(&ctx->progress);
 	strbuf_release(&progress_title);
 
-	if (ctx->split && ctx->base_graph_name && ctx->num_commit_graphs_after > 1) {
+	if ((ctx->opts->flags & COMMIT_GRAPH_WRITE_SPLIT) &&
+	    ctx->base_graph_name && ctx->num_commit_graphs_after > 1) {
 		char *new_base_hash = xstrdup(oid_to_hex(&ctx->new_base_graph->oid));
 		char *new_base_name = get_split_graph_filename(ctx->new_base_graph->dir, new_base_hash);
 
@@ -2227,7 +2227,7 @@ static int write_commit_graph_file(struct write_commit_graph_context *ctx)
 			  CSUM_HASH_IN_STREAM | CSUM_FSYNC);
 	free_chunkfile(cf);
 
-	if (ctx->split) {
+	if (ctx->opts->flags & COMMIT_GRAPH_WRITE_SPLIT) {
 		FILE *chainf = fdopen_lock_file(&lk, "w");
 		char *final_graph_name;
 		int result;
@@ -2406,7 +2406,7 @@ static void sort_and_scan_merged_commits(struct write_commit_graph_context *ctx)
 {
 	uint32_t i, dedup_i = 0;
 
-	if (ctx->report_progress)
+	if (ctx->opts->flags & COMMIT_GRAPH_WRITE_PROGRESS)
 		ctx->progress = start_delayed_progress(
 					ctx->r,
 					_("Scanning merged commits"),
@@ -2452,7 +2452,7 @@ static void merge_commit_graphs(struct write_commit_graph_context *ctx,
 	while (g && current_graph_number >= ctx->num_commit_graphs_after) {
 		current_graph_number--;
 
-		if (ctx->report_progress)
+		if (ctx->opts->flags & COMMIT_GRAPH_WRITE_PROGRESS)
 			ctx->progress = start_delayed_progress(ctx->r,
 							       _("Merging commit-graph"), 0);
 
@@ -2501,7 +2501,7 @@ static void expire_commit_graphs(struct write_commit_graph_context *ctx)
 
 	if (ctx->opts->expire_time)
 		expire_time = ctx->opts->expire_time;
-	if (!ctx->split) {
+	if (!(ctx->opts->flags & COMMIT_GRAPH_WRITE_SPLIT)) {
 		char *chain_file_name = get_commit_graph_chain_filename(ctx->dir);
 		unlink(chain_file_name);
 		free(chain_file_name);
@@ -2558,9 +2558,6 @@ int write_commit_graph(struct repository *r,
 {
 	struct write_commit_graph_context ctx = {
 		.r = r,
-		.append = opts->flags & COMMIT_GRAPH_WRITE_APPEND ? 1 : 0,
-		.report_progress = opts->flags & COMMIT_GRAPH_WRITE_PROGRESS ? 1 : 0,
-		.split = opts->flags & COMMIT_GRAPH_WRITE_SPLIT ? 1 : 0,
 		.opts = opts,
 		.total_bloom_filter_data_size = 0,
 		.write_generation_data = (get_configured_generation_version(r) == 2),
@@ -2624,7 +2621,7 @@ int write_commit_graph(struct repository *r,
 
 	bloom_settings.hash_version = bloom_settings.hash_version == 2 ? 2 : 1;
 
-	if (ctx.split) {
+	if (ctx.opts->flags & COMMIT_GRAPH_WRITE_SPLIT) {
 		for (struct commit_graph *chain = g; chain; chain = chain->base_graph)
 			ctx.num_commit_graphs_before++;
 
@@ -2642,7 +2639,7 @@ int write_commit_graph(struct repository *r,
 	if (odb_count_objects(r->objects, ODB_COUNT_OBJECTS_APPROXIMATE, &ctx.approx_nr_objects) < 0)
 		ctx.approx_nr_objects = 0;
 
-	if (ctx.append && g) {
+	if ((ctx.opts->flags & COMMIT_GRAPH_WRITE_APPEND) && g) {
 		for (i = 0; i < g->num_commits; i++) {
 			struct object_id oid;
 			oidread(&oid, g->chunk_oid_lookup + st_mult(g->hash_algo->rawsz, i),
@@ -2680,7 +2677,7 @@ int write_commit_graph(struct repository *r,
 	if (!ctx.commits.nr && !replace)
 		goto cleanup;
 
-	if (ctx.split) {
+	if (ctx.opts->flags & COMMIT_GRAPH_WRITE_SPLIT) {
 		split_graph_merge_strategy(&ctx, g);
 
 		if (!replace)
@@ -2703,7 +2700,7 @@ int write_commit_graph(struct repository *r,
 	if (ctx.changed_paths)
 		deinit_bloom_filters();
 
-	if (ctx.split)
+	if (ctx.opts->flags & COMMIT_GRAPH_WRITE_SPLIT)
 		mark_commit_graphs(&ctx);
 
 	expire_commit_graphs(&ctx);

-- 
2.56.0.500.g5d06dc02cd.dirty

