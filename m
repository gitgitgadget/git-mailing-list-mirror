Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=103.168.172.146
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793807886;
	b=pHZ1d5y1uOF1s/D2SnM4OLbpB3XE38Cg2sHTp2VnNEFjINNTe4Q/zBPI4QKahdFCFxw6
	 MBPdano1YKyNNMjSjrF+9ervzH6XumhxPLb55tXmb9VfsZKuN35gOsjmk0Aylug7zCnTY
	 Dt2aQxt+CxobwAu5GpY8/PvTP4s27MS001jhU3YWXW6z3FLMqaVPXjKv1i0mivXMQX1NN
	 b5yPq9gJM/9PL13BKjjA/FZtnCc5RoZ6jQJc6Yq0m6wfeRvuh2kKcCtiI4d/Ve8HlxlMc
	 taoHYnvu6py7G1kvQarRcnU6NEI4Ly3j1fREi62VEKi8bG2UHhdJ9tLPaYO0EmP0Ctw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793807886;
	h=DMARC-Filter:Received:Received:DKIM-Signature:DKIM-Signature:
	 X-DKIM2-Info:DKIM2-Signature:X-DKIM2-Info:Message-Instance:
	 X-ME-Sender:X-ME-Received:X-ME-Proxy-Cause:X-ME-Proxy:Feedback-ID:
	 Received:Received:From:Date:Subject:MIME-Version:Content-Type:
	 Content-Transfer-Encoding:Message-Id:References:In-Reply-To:To:Cc:
	 X-Mailer;
	bh=grtk+skdL7oA6uOWoa6lVRBAKUVwBNuVdtmi0K2OJBI=;
	b=FIxI5ru3g15WrPqLZCiVAD1KDth5DCFdt0FBE9PACseodPnb1O5quHyL85fkWXf4zz6D
	 U0s0lO+AiNayhKFuGR+M04zFwnLIKjYUNP4JLTdAErlyYux7oHForAgEZhVHBsiHb/kX0
	 KiIvtaMe6UUh7svm0ar9KwaVfFbm1SG0rlKGumbmwCMkJDU/SDYtjc6zZKyuAVw3HEpvL
	 TQKbASYB7n5rpCwz+WDBgGS1mtY69MgZz0bo+R0oNrTo40wNeNE13R3Y+RNwy3zUNDpqo
	 fO2md7knrP1asApCIxjjThJ5uwGGAsbtMVrNwqIjbnfnT2Te+fkzixHV85wUlRdWFGg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=pks.im;
	spf=pass smtp.mailfrom=pks.im;
	dkim=pass header.d=pks.im header.i=@pks.im header.a=rsa-sha256 header.s=fm3 header.b=OHJzQTzj;
	dkim=pass header.d=messagingengine.com header.i=@messagingengine.com header.a=rsa-sha256 header.s=fm3 header.b=fPaMeJPC;
	arc=none smtp.remote-ip=103.168.172.146
Received: from fout-a3-smtp.messagingengine.com (fout-a3-smtp.messagingengine.com [103.168.172.146])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6B5696082BE3
	for <git@vger.kernel.org>; Wed,  4 Nov 2026 15:58:05 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 6B5696082BE3
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=pks.im header.i=@pks.im header.a=rsa-sha256 header.s=fm3 header.b=OHJzQTzj;
	dkim=pass (2048-bit key, unprotected) header.d=messagingengine.com header.i=@messagingengine.com header.a=rsa-sha256 header.s=fm3 header.b=fPaMeJPC
Received: from phl-compute-03.internal (phl-compute-03.internal [10.202.2.43])
	by mailfout.phl.internal (Postfix) with ESMTP id C78C1EC0239
	for <git@vger.kernel.org>; Wed,  4 Nov 2026 10:58:04 -0500 (EST)
Received: from phl-frontend-04 ([10.202.2.163])
  by phl-compute-03.internal (MEProxy); Wed, 04 Nov 2026 10:58:04 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm3; t=1793807884;
	 x=1793894284; bh=grtk+skdL7oA6uOWoa6lVRBAKUVwBNuVdtmi0K2OJBI=; b=
	OHJzQTzjt789U6Ob5pwU8h5suGJaeZXqrTxBaUTMn4nVa9XbFh9mHVSoE/1gddEB
	/RZCSqnOicqPZJypfEN29qqBoDhKoL4gVfA2IJW/QMvLa0WKbEYqtBVNv7qFA0kt
	ygdIOCKtvKRfRzbgV8nNAe1Pewo2hEJdlrghdilKuOeSEagsZbFT8GC5JW7Sb4A1
	zmLYzXu8fvlTG40ovDUdITXUCPFaGcnFYmBKwE12JKWvdtG5Q+zc1T3AAUaOyplV
	oWmgdjlO+tprdX14iCPIRJWcPh7aY41egpIivMhiri49D9uaOr86eQ6QaLNF759J
	vucSspdKO09JhT4pbW5Yuw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1793807884; x=
	1793894284; bh=grtk+skdL7oA6uOWoa6lVRBAKUVwBNuVdtmi0K2OJBI=; b=f
	PaMeJPCIJDUcyAC4TTJuHGRa3M+qqCJCMGIO99cltljku0OK221IXwI2kduzQW3c
	xmceHdLn7uZ1d0x2B0XRsRNCch/IH+ykOJEzf/j1OOjQp2jqj/hDukVH29ZVOiyZ
	g1ftyN3y1ypL/pwhoerakQBlvrA/LUbACzT7gDN7vJjbEo59UvRTAjMFWg790+qU
	y21q7r8SoqUuMT7UujHdjOOnDxa2CsfAvRyhVVELJGUptGd+G3ud+JUzxAnleuQ6
	YIJ9yiPhLMnq+Avvy28SPpZP0iB1qLtm0Fj7ReFxZIgXgNHo7nlD377arpRzB6Xe
	g5xds83b8dbiI/wtwgV8Q==
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-08;
	repo=github.com/dkim2wg/interop; date=2026-10-28; sw=lmtpprox;
	action=sign d=pks.im a=rsa-sha256;
DKIM2-Signature: i=1; m=1; t=1793807884; d=pks.im; mf=PHBzQHBrcy5pbT4=;
	rt=PGdpdEB2Z2VyLmtlcm5lbC5vcmc+;
	s=fm3:rsa-sha256:G1ozKP/HDLIhT8kYF5gwaGKSbHNFWMLaTSxcVKgy5QiyorH
	SacAt16PinvyhIFxMGxQjie62lgoQxSF6EU9rbFSCvyE8Ev4p2B7OqecYfNDMk1o
	tqLTj0R1rQ8ndR6pAVuSYUNBCUMKqNTznlBf7kgIuNh16Gugjwe/rzFo+22toSIF
	s4gduv6JkwmsC32FBqNzJPjfanyEnmqK4KLuQ4YII7gNIlbqkqttFOhWBQB9ZTej
	msAs4vqi2dpzMrSYUXljOIZP831heunv/QmL7OvKbx+j1ctWdzLFME1/3QHFkicu
	NQ2qGO8V/GzIl4GGC2mKoK3CJf/Jxb937nKwISg==;
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-08;
	repo=github.com/dkim2wg/interop; date=2026-10-28; sw=lmtpprox;
	action=mi-m=1; hc=12;
	hn=cc,content-transfer-encoding,content-type,date,feedback-id,
	from,in-reply-to,message-id,mime-version,references,subject,to;
Message-Instance: m=1; h=sha256:INZgJTn+XhJxuQ6XA1YRJhrM2iy7qPvdx3o0mK/VOLE=:6SLuVBlr12pAIDsBhIgCBvVNXVJJukK5MymUPaFq+dc=;
X-ME-Sender: <xms:DFbravH9dNUT0zGgSr6x9AuB4Rq-JwLjos0MBeGVdMM_8spx1ywDhg>
    <xme:DFbrajS6wr2JRjSZ4fX2dS5fijAqn8roVOjiKBAtgtwBgA9f9JPnk8DE4HmPEXPsw
    99NQdkhv1hOsJZevZdNG1jy91Iox3oIUoH_0Q5xlfQSHaEuFK1ntA>
X-ME-Received: <xmr:DFbramxrRvspD9dLetaEVddQyJ3-IXcjNDXgHWKE6FXhrEiDqJJ8YgdqqYtR55_qd1c20RA>
X-ME-Proxy-Cause: dmFkZTFP9F9oJWwJG85mnHzfFOqny0OiD5iiWGUykvkiOCtsZJx63XeSWFS5hvnOTWaXXM
    pVNW68EmUAqObsBxHEoTqZGxr1uInZq5ObL120XJ6obWw31M/SqAAh2FRln8SyYDsBRQAc
    XgLSwbTYIIRAuqer3KFyQcFJVx1upExtgeuk4+nospz6pknGbvTFoQtONK00uHdyGa71ei
    05eeKL8ZFbs8tu8jIH8bDRz+5s8LGUqkWAZAgjQZeduYIONS+s4caycfiuwagcsfkJCBbf
    gsJbttQXJ4DA/1KBEx2aj29+xUBhITr/+i7EpjG9SxzktIlj30krZRuziPbpuPiywKxRkH
    62ScJbnpYisoKiNahVAjqZPQhxOjB4pgma/ds+9Hn5YXmBFEtfOcZ9hoxgIVF+d/I9az++
    hnDVMBNfB6yymxV1Z7ajUwUegtnCrT7lZrz0K9N71fuEcSU6pEhjOoVJJzpJHoPaxJfiNu
    J0ypfat0LFCLdYC+1jEY0CnJHj+9y2EfVvzEBiJWaCVjlmDkhWBC7XgJiRScQYCtRzBGLQ
    bT/p6Ywu35TRhlQxU1YdwBQwQpVy+BJXTgNWE30EP47uUXTrUMyqpNOOr43bqfEvr3rEDo
    KGbbp6VHOFFxV4GbKuvtaVarSwZloCxtDR5bh/Lc/EgosYzgCE7SW2SFAyxQ
X-ME-Proxy: <xmx:DFbraiNGhFnwovAiyY6izIA_RDegw5u4OSwQ4Wq4chWoaRApIvD5ZA>
    <xmx:DFbralNEvpcojwbT-QSeHrVaYI6ekg8IRPE9E5UbdjYPZ_G21N6bCw>
    <xmx:DFbrakSWlEU3eGpBO96IqHdHkHtSwgj1sK4bEoaFuaWbR9R3dIAUCg>
    <xmx:DFbranAc9KxjSH_6pQLDqzYs9I1Hd3KkKQF-30j2uIJkNALPaGezgQ>
    <xmx:DFbralVk8gxRiPFf_CcAII08ViVd_zKw1LFEZjCdjZpGN7BgAr8ZI5UZ>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA for
 <git@vger.kernel.org>; Wed, 4 Nov 2026 10:58:04 -0500 (EST)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id 4f5a2454 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO)
	for <git@vger.kernel.org>;
	Wed, 4 Nov 2026 15:58:04 +0000 (UTC)
From: Patrick Steinhardt <ps@pks.im>
Date: Wed, 04 Nov 2026 16:57:32 +0100
Subject: [PATCH 10/10] commit-graph: modernize function names
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
Message-Id: <20261104-pks-commit-graph-write-refactorings-v1-10-d013d9401a59@pks.im>
References: <20261104-pks-commit-graph-write-refactorings-v1-0-d013d9401a59@pks.im>
In-Reply-To: <20261104-pks-commit-graph-write-refactorings-v1-0-d013d9401a59@pks.im>
To: git@vger.kernel.org
Cc: 
X-Mailer: b4 0.15.2

Modernize a couple of function names of the commit-graph subsystem so
that they follow our modern `<subsystem>_<verb>` naming schema.

Signed-off-by: Patrick Steinhardt <ps@pks.im>
---
 Documentation/gitformat-chunk.adoc |  2 +-
 builtin/commit-graph.c             |  6 +++---
 builtin/fetch.c                    |  2 +-
 builtin/gc.c                       |  2 +-
 commit-graph.c                     | 20 ++++++++++----------
 commit-graph.h                     | 14 +++++++-------
 odb.c                              |  2 +-
 oss-fuzz/fuzz-commit-graph.c       |  4 ++--
 t/helper/test-read-graph.c         |  2 +-
 9 files changed, 27 insertions(+), 27 deletions(-)

diff --git a/Documentation/gitformat-chunk.adoc b/Documentation/gitformat-chunk.adoc
index 3315df6201d..061803932b4 100644
--- a/Documentation/gitformat-chunk.adoc
+++ b/Documentation/gitformat-chunk.adoc
@@ -118,7 +118,7 @@ Examples
 These file formats use the chunk-format API, and can be used as examples
 for future formats:
 
-* *commit-graph:* see `write_commit_graph_file()` and `parse_commit_graph()`
+* *commit-graph:* see `write_commit_graph_file()` and `commit_graph_parse()`
   in `commit-graph.c` for how the chunk-format API is used to write and
   parse the commit-graph file format documented in
   the commit-graph file format in linkgit:gitformat-commit-graph[5].
diff --git a/builtin/commit-graph.c b/builtin/commit-graph.c
index 218c30ed3ed..8194a528406 100644
--- a/builtin/commit-graph.c
+++ b/builtin/commit-graph.c
@@ -119,8 +119,8 @@ static int cmd_commit_graph_verify(int argc,
 	if (!graph)
 		return 1;
 
-	ret = verify_commit_graph(graph, flags);
-	free_commit_graph(graph);
+	ret = commit_graph_verify(graph, flags);
+	commit_graph_free(graph);
 
 	if (incomplete_chain) {
 		error("one or more commit-graph chain files could not be loaded");
@@ -324,7 +324,7 @@ static int cmd_commit_graph_write(int argc,
 		stop_progress(&progress);
 	}
 
-	if (write_commit_graph(repo, dir->abspath, &write_opts))
+	if (commit_graph_write(repo, dir->abspath, &write_opts))
 		result = 1;
 
 cleanup:
diff --git a/builtin/fetch.c b/builtin/fetch.c
index 7278cee8ca7..cf8cafc4520 100644
--- a/builtin/fetch.c
+++ b/builtin/fetch.c
@@ -2949,7 +2949,7 @@ int cmd_fetch(int argc,
 		if (graph_write_mode != GRAPH_WRITE_SKIP) {
 			trace2_region_enter("fetch", "write-commit-graph",
 					    the_repository);
-			write_commit_graph(the_repository,
+			commit_graph_write(the_repository,
 					   the_repository->objects->source->path,
 					   &write_opts);
 			trace2_region_leave("fetch", "write-commit-graph",
diff --git a/builtin/gc.c b/builtin/gc.c
index 7bf88861df0..68cb04a672d 100644
--- a/builtin/gc.c
+++ b/builtin/gc.c
@@ -741,7 +741,7 @@ int cmd_gc(int argc,
 		if (!opts.quiet && !daemonized)
 			write_opts.flags |= COMMIT_GRAPH_WRITE_PROGRESS;
 
-		write_commit_graph(the_repository, the_repository->objects->source->path,
+		commit_graph_write(the_repository, the_repository->objects->source->path,
 				   &write_opts);
 	}
 
diff --git a/commit-graph.c b/commit-graph.c
index c82776b0667..da65cd3deb9 100644
--- a/commit-graph.c
+++ b/commit-graph.c
@@ -41,7 +41,7 @@ void git_test_write_commit_graph_or_die(struct repository *repo)
 	if (git_env_bool(GIT_TEST_COMMIT_GRAPH_CHANGED_PATHS, 0))
 		opts.flags |= COMMIT_GRAPH_WRITE_BLOOM_FILTERS;
 
-	if (write_commit_graph(repo, repo->objects->source->path, &opts))
+	if (commit_graph_write(repo, repo->objects->source->path, &opts))
 		die("failed to write commit-graph under GIT_TEST_COMMIT_GRAPH");
 }
 
@@ -275,7 +275,7 @@ struct commit_graph *load_commit_graph_one_fd_st(struct repository *repo,
 	graph_map = xmmap(NULL, graph_size, PROT_READ, MAP_PRIVATE, fd, 0);
 	close(fd);
 
-	ret = parse_commit_graph(repo, graph_map, graph_size);
+	ret = commit_graph_parse(repo, graph_map, graph_size);
 	if (ret)
 		ret->dir = absolute_pathdup(dir);
 	else
@@ -375,7 +375,7 @@ static int graph_read_bloom_data(const unsigned char *chunk_start,
 	return 0;
 }
 
-struct commit_graph *parse_commit_graph(struct repository *r,
+struct commit_graph *commit_graph_parse(struct repository *r,
 					void *graph_map, size_t graph_size)
 {
 	const unsigned char *data;
@@ -686,7 +686,7 @@ struct commit_graph *load_commit_graph_chain_fd_st(struct object_database *odb,
 					graph_chain = g;
 					valid = 1;
 				} else {
-					free_commit_graph(g);
+					commit_graph_free(g);
 				}
 
 				break;
@@ -830,14 +830,14 @@ struct bloom_filter_settings *get_bloom_filter_settings(struct repository *r)
 	return NULL;
 }
 
-void close_commit_graph(struct object_database *o)
+void commit_graph_close(struct object_database *o)
 {
 	if (!o->commit_graph)
 		return;
 
 	clear_commit_graph_data_slab(&commit_graph_data_slab);
 	deinit_bloom_filters();
-	free_commit_graph(o->commit_graph);
+	commit_graph_free(o->commit_graph);
 	o->commit_graph = NULL;
 }
 
@@ -2214,7 +2214,7 @@ static int write_commit_graph_file(struct write_commit_graph_context *ctx)
 		ctx->commit_graph_hash_after[ctx->num_commit_graphs_after - 2] = new_base_hash;
 	}
 
-	close_commit_graph(ctx->r->objects);
+	commit_graph_close(ctx->r->objects);
 	finalize_hashfile(f, file_hash, FSYNC_COMPONENT_COMMIT_GRAPH,
 			  CSUM_HASH_IN_STREAM | CSUM_FSYNC);
 	free_chunkfile(cf);
@@ -2542,7 +2542,7 @@ static void expire_commit_graphs(struct write_commit_graph_context *ctx)
 	strbuf_release(&path);
 }
 
-int write_commit_graph(struct repository *r,
+int commit_graph_write(struct repository *r,
 		       const char *dir,
 		       const struct commit_graph_write_options *opts)
 {
@@ -2904,7 +2904,7 @@ static int verify_one_commit_graph(struct commit_graph *g,
 	return verify_commit_graph_error;
 }
 
-int verify_commit_graph(struct commit_graph *g,
+int commit_graph_verify(struct commit_graph *g,
 			enum commit_graph_verify_flags flags)
 {
 	struct progress *progress = NULL;
@@ -2937,7 +2937,7 @@ int verify_commit_graph(struct commit_graph *g,
 	return local_error;
 }
 
-void free_commit_graph(struct commit_graph *g)
+void commit_graph_free(struct commit_graph *g)
 {
 	while (g) {
 		struct commit_graph *next = g->base_graph;
diff --git a/commit-graph.h b/commit-graph.h
index 80d59bd23bd..2156499a688 100644
--- a/commit-graph.h
+++ b/commit-graph.h
@@ -135,9 +135,9 @@ struct repo_settings;
 
 /*
  * Callers should initialize the repo_settings with prepare_repo_settings()
- * prior to calling parse_commit_graph().
+ * prior to calling commit_graph_parse().
  */
-struct commit_graph *parse_commit_graph(struct repository *r,
+struct commit_graph *commit_graph_parse(struct repository *r,
 					void *graph_map, size_t graph_size);
 
 /*
@@ -186,7 +186,7 @@ struct commit_graph_write_options {
 }
 
 /*
- * The write_commit_graph* methods return zero on success
+ * The commit_graph_write* methods return zero on success
  * and a negative value on failure. Note that if the repository
  * is not compatible with the commit-graph feature, then the
  * methods will return 0 without writing a commit-graph.
@@ -195,7 +195,7 @@ struct commit_graph_write_options {
  * canonicalized internally so that it compares equal to the directory of
  * graphs that have already been loaded.
  */
-int write_commit_graph(struct repository *r,
+int commit_graph_write(struct repository *r,
 		       const char *dir,
 		       const struct commit_graph_write_options *opts);
 
@@ -204,11 +204,11 @@ enum commit_graph_verify_flags {
 	COMMIT_GRAPH_VERIFY_PROGRESS = (1 << 1),
 };
 
-int verify_commit_graph(struct commit_graph *g,
+int commit_graph_verify(struct commit_graph *g,
 			enum commit_graph_verify_flags flags);
 
-void close_commit_graph(struct object_database *);
-void free_commit_graph(struct commit_graph *);
+void commit_graph_close(struct object_database *);
+void commit_graph_free(struct commit_graph *);
 
 /*
  * Disable further use of the commit graph in this process when parsing a
diff --git a/odb.c b/odb.c
index 2c93a9490c6..b89457d0c91 100644
--- a/odb.c
+++ b/odb.c
@@ -739,7 +739,7 @@ struct object_database *odb_new(struct repository *repo,
 void odb_close(struct object_database *o)
 {
 	odb_source_close(o->source);
-	close_commit_graph(o);
+	commit_graph_close(o);
 }
 
 static void odb_free_sources(struct object_database *o)
diff --git a/oss-fuzz/fuzz-commit-graph.c b/oss-fuzz/fuzz-commit-graph.c
index 59bbb849d1e..e941cd9fc56 100644
--- a/oss-fuzz/fuzz-commit-graph.c
+++ b/oss-fuzz/fuzz-commit-graph.c
@@ -23,9 +23,9 @@ int LLVMFuzzerTestOneInput(const uint8_t *data, size_t size)
 	the_repository->settings.initialized = 1;
 	the_repository->settings.commit_graph_generation_version = 2;
 	the_repository->settings.commit_graph_changed_paths_version = 1;
-	g = parse_commit_graph(the_repository, (void *)data, size);
+	g = commit_graph_parse(the_repository, (void *)data, size);
 	repo_clear(the_repository);
-	free_commit_graph(g);
+	commit_graph_free(g);
 
 	return 0;
 }
diff --git a/t/helper/test-read-graph.c b/t/helper/test-read-graph.c
index aceac4f6995..9642e55b8c0 100644
--- a/t/helper/test-read-graph.c
+++ b/t/helper/test-read-graph.c
@@ -119,6 +119,6 @@ int cmd__read_graph(int argc, const char **argv)
 	}
 
 done:
-	free_commit_graph(graph);
+	commit_graph_free(graph);
 	return ret;
 }

-- 
2.56.0.500.g5d06dc02cd.dirty

