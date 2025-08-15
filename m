Received: from fout-a2-smtp.messagingengine.com (fout-a2-smtp.messagingengine.com [103.168.172.145])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A80A6218EB1
	for <git@vger.kernel.org>; Fri, 15 Aug 2025 05:50:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.145
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755237005; cv=none; b=kF2kd/q4g4DFQnBTrVYfIgSdRayIulcqKZQpsZBb7E+2r5Pkv60J78h5lF8vvKsBAt037SSdJBiTzPgQIdaDsIhlLLIjpgv+OyfBkNTR8pVjMYHmEtgO2YlgGdPkHRwZohLIUEMvsWoq5KDF3luw25fcDuqH+IIqU1zSK52w2ck=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755237005; c=relaxed/simple;
	bh=1O9S5zFKlmrw8/Ay4Mzk6ca/6ZGmuUWhmCzLW7mUNn0=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=bN2qWdnreNTClL1U9zWLPcnpded2yUQ8tdM0W1EidC5TqzW8dJTiH26mmqcYPgCvFIY3MnJ2Dzz/v3LdxsPptuipxSS9WZoPvQlaqBxZ4iWH9hUijr9aZs9ajRK9U/Qp2jElAjqqKVlG9VtGiNbzQKwhGEd5yf+YiYFmf0yje0s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=K4Bs6LPt; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=LO/eSv6c; arc=none smtp.client-ip=103.168.172.145
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="K4Bs6LPt";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="LO/eSv6c"
Received: from phl-compute-01.internal (phl-compute-01.internal [10.202.2.41])
	by mailfout.phl.internal (Postfix) with ESMTP id A2782EC012A;
	Fri, 15 Aug 2025 01:50:02 -0400 (EDT)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-01.internal (MEProxy); Fri, 15 Aug 2025 01:50:02 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm3; t=1755237002;
	 x=1755323402; bh=MpR+f6wdY63SdtTIBjFl+DdW8VmOvy8TRyHLyhQz7WQ=; b=
	K4Bs6LPt8RcvrWEzR2dXPEuK3PQSMX5rOvfq74Zr5y5HssKD9FPcxUfwrcyr2q1V
	7N+Kg2DgfmeZ/gAb76bjblotwQ6ufJE4xa4QzZL5h3gGi5itIvIo1NV+7NmnbU0L
	1gpoUWLG9VBK49DefgeyIH8HEa1FQnyx/e4z/a50xCY3GYzeD7mSULtnnRfVZ6D7
	u+f40wrAd7SPMUhYBYr2PKL2JpHJW8FJnbPJKikbj/n0YVArKTqoi5fdZe6wETc5
	d+w/fAoCsfkiiRYOa48DtiT+FR+Oy+TCoLnIsZYfabPEwq01zmAplTw1NqbXuizc
	Ql9YYnup5PCcEKvug6Fsbg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1755237002; x=
	1755323402; bh=MpR+f6wdY63SdtTIBjFl+DdW8VmOvy8TRyHLyhQz7WQ=; b=L
	O/eSv6clnnoLSZMNQOhIIS2d5jPj1XRqu7Cb5aRxlZi8Ru/SmSAO3zqw3/ku3uCf
	y3z5jKUi/WgaQ0Ooy0/WAKhcA3J/IrJmBLh5gssnlN/ZlQOE0ttmGqzLTlVGRNTI
	yA5QCjqDzTX9CFMaVXinbpzHsLjsjwcFk4nvT0EBZgsn75R08g5ZLYSFu2ZFakb5
	sJBQ9e2l891Nset0Fxt3wi9Lerui1EmIbaC+OziZ76HKLuu9mf+FUMM2dhSTVc/5
	uhkbL8mRdH2o02WiqZciF+xlitH1IfaXYC5f8FB45HptuYLTEAuAcQPJl0gCp2M4
	igXRp5GBqI/IVPni0blJQ==
X-ME-Sender: <xms:isqeaA1Utz0F5qJQjIo663aM_WG_HNf_iMpfBZFJZtvCIBIWPNNk2A>
    <xme:isqeaGkKoWHRiFN0jESvqA3ykicmPltIQwD9iUPsnJgo_Js-Qf4eVKngqKcTG6oER
    Kc8VeOolYhTK2g_iQ>
X-ME-Received: <xmr:isqeaPXuWG0yaD8Qs22W3aD9Vkyxm00GteAhPzsGIcp1BL3C6vKFRHVI9GNPXrr-KIxFesgX8uzhvxYzxFeWtt71YB43bJAo3l9MefMKng>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdefgddugeefudejucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhephfffufggtgfgkfhfjgfvvefosehtjeertdertdejnecuhfhrohhmpefrrghtrhhi
    tghkucfuthgvihhnhhgrrhguthcuoehpshesphhkshdrihhmqeenucggtffrrghtthgvrh
    hnpeffueeiudejvdekheeuvdekfeffiedvueelteekudehjeetkeegvddugfdtgfeileen
    ucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehpshesph
    hkshdrihhmpdhnsggprhgtphhtthhopeehpdhmohguvgepshhmthhpohhuthdprhgtphht
    thhopehsthholhgvvgesghhmrghilhdrtghomhdprhgtphhtthhopehoshifrghlugdrsg
    huugguvghnhhgrghgvnhesghhmgidruggvpdhrtghpthhtohepmhgvsehtthgrhihlohhr
    rhdrtghomhdprhgtphhtthhopehgihhtshhtvghrsehpohgsohigrdgtohhmpdhrtghpth
    htohepghhithesvhhgvghrrdhkvghrnhgvlhdrohhrgh
X-ME-Proxy: <xmx:isqeaEuZf2pZky7BDr1vIIRlNkiFL11W9qAaDI8faa4GAhKtgCY1cA>
    <xmx:isqeaKYALlsFCZQltJe30hU3Hv20bFxTDOLaQtvAoBYKWxcMgQV2cg>
    <xmx:isqeaLWybAokrwunIRlYdV-IpGaJ_5UfhwC1eje-Hr-nAQ1P22UFfg>
    <xmx:isqeaHT2I8VY6TpMskuoOoRjIXZ457BNu3McOgpNQGJqJ4RqMS6GqQ>
    <xmx:isqeaBi-dG9sneN3oAl5MOhTUL7uaeCL8bvCHr_JY-5scz45Jss7v7AG>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 15 Aug 2025 01:50:00 -0400 (EDT)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id 88b3eb91 (TLSv1.3:TLS_CHACHA20_POLY1305_SHA256:256:NO);
	Fri, 15 Aug 2025 05:50:00 +0000 (UTC)
From: Patrick Steinhardt <ps@pks.im>
Date: Fri, 15 Aug 2025 07:49:49 +0200
Subject: [PATCH v4 3/6] commit-graph: refactor `parse_commit_graph()` to
 take a repository
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250815-b4-pks-commit-graph-wo-the-repository-v4-3-b6b651178cce@pks.im>
References: <20250815-b4-pks-commit-graph-wo-the-repository-v4-0-b6b651178cce@pks.im>
In-Reply-To: <20250815-b4-pks-commit-graph-wo-the-repository-v4-0-b6b651178cce@pks.im>
To: git@vger.kernel.org
Cc: Taylor Blau <me@ttaylorr.com>, Derrick Stolee <stolee@gmail.com>, 
 Oswald Buddenhagen <oswald.buddenhagen@gmx.de>, 
 Junio C Hamano <gitster@pobox.com>
X-Mailer: b4 0.14.2

Refactor `parse_commit_graph()` so that it takes a repository instead of
taking repository settings. On the one hand this allows us to get rid of
instances where we access `the_hash_algo` by using the repository's hash
algorithm instead. On the other hand it also allows us to move the call
of `prepare_repo_settings()` into the function itself.

Note that there's one small catch, as the commit-graph fuzzer calls this
function directly without having a fully functional repository at hand.
And while the fuzzer already initializes `the_repository` with relevant
info, the call to `prepare_repo_settings()` would fail because we don't
have a fully-initialized repository.

Work around the issue by also settings `settings.initialized` to pretend
that we've already read the settings.

While at it, remove the redundant `parse_commit_graph()` declaration in
the fuzzer. It was added together with aa658574bf (commit-graph, fuzz:
add fuzzer for commit-graph, 2019-01-15), but as we also declared the
same function in "commit-graph.h" it wasn't ever needed.

Signed-off-by: Patrick Steinhardt <ps@pks.im>
---
 commit-graph.c               | 23 ++++++++++++-----------
 commit-graph.h               |  2 +-
 oss-fuzz/fuzz-commit-graph.c |  6 ++----
 3 files changed, 15 insertions(+), 16 deletions(-)

diff --git a/commit-graph.c b/commit-graph.c
index 5053d125340..2f314a7407e 100644
--- a/commit-graph.c
+++ b/commit-graph.c
@@ -271,9 +271,8 @@ struct commit_graph *load_commit_graph_one_fd_st(struct repository *r,
 	}
 	graph_map = xmmap(NULL, graph_size, PROT_READ, MAP_PRIVATE, fd, 0);
 	close(fd);
-	prepare_repo_settings(r);
-	ret = parse_commit_graph(&r->settings, graph_map, graph_size);
 
+	ret = parse_commit_graph(r, graph_map, graph_size);
 	if (ret)
 		ret->odb_source = source;
 	else
@@ -373,7 +372,7 @@ static int graph_read_bloom_data(const unsigned char *chunk_start,
 	return 0;
 }
 
-struct commit_graph *parse_commit_graph(struct repo_settings *s,
+struct commit_graph *parse_commit_graph(struct repository *r,
 					void *graph_map, size_t graph_size)
 {
 	const unsigned char *data;
@@ -385,7 +384,7 @@ struct commit_graph *parse_commit_graph(struct repo_settings *s,
 	if (!graph_map)
 		return NULL;
 
-	if (graph_size < graph_min_size(the_hash_algo))
+	if (graph_size < graph_min_size(r->hash_algo))
 		return NULL;
 
 	data = (const unsigned char *)graph_map;
@@ -405,22 +404,22 @@ struct commit_graph *parse_commit_graph(struct repo_settings *s,
 	}
 
 	hash_version = *(unsigned char*)(data + 5);
-	if (hash_version != oid_version(the_hash_algo)) {
+	if (hash_version != oid_version(r->hash_algo)) {
 		error(_("commit-graph hash version %X does not match version %X"),
-		      hash_version, oid_version(the_hash_algo));
+		      hash_version, oid_version(r->hash_algo));
 		return NULL;
 	}
 
 	graph = alloc_commit_graph();
 
-	graph->hash_algo = the_hash_algo;
+	graph->hash_algo = r->hash_algo;
 	graph->num_chunks = *(unsigned char*)(data + 6);
 	graph->data = graph_map;
 	graph->data_len = graph_size;
 
 	if (graph_size < GRAPH_HEADER_SIZE +
 			 (graph->num_chunks + 1) * CHUNK_TOC_ENTRY_SIZE +
-			 GRAPH_FANOUT_SIZE + the_hash_algo->rawsz) {
+			 GRAPH_FANOUT_SIZE + r->hash_algo->rawsz) {
 		error(_("commit-graph file is too small to hold %u chunks"),
 		      graph->num_chunks);
 		free(graph);
@@ -451,7 +450,9 @@ struct commit_graph *parse_commit_graph(struct repo_settings *s,
 	pair_chunk(cf, GRAPH_CHUNKID_BASE, &graph->chunk_base_graphs,
 		   &graph->chunk_base_graphs_size);
 
-	if (s->commit_graph_generation_version >= 2) {
+	prepare_repo_settings(r);
+
+	if (r->settings.commit_graph_generation_version >= 2) {
 		read_chunk(cf, GRAPH_CHUNKID_GENERATION_DATA,
 			   graph_read_generation_data, graph);
 		pair_chunk(cf, GRAPH_CHUNKID_GENERATION_DATA_OVERFLOW,
@@ -462,7 +463,7 @@ struct commit_graph *parse_commit_graph(struct repo_settings *s,
 			graph->read_generation_data = 1;
 	}
 
-	if (s->commit_graph_changed_paths_version) {
+	if (r->settings.commit_graph_changed_paths_version) {
 		read_chunk(cf, GRAPH_CHUNKID_BLOOMINDEXES,
 			   graph_read_bloom_index, graph);
 		read_chunk(cf, GRAPH_CHUNKID_BLOOMDATA,
@@ -479,7 +480,7 @@ struct commit_graph *parse_commit_graph(struct repo_settings *s,
 	}
 
 	oidread(&graph->oid, graph->data + graph->data_len - graph->hash_algo->rawsz,
-		the_repository->hash_algo);
+		r->hash_algo);
 
 	free_chunkfile(cf);
 	return graph;
diff --git a/commit-graph.h b/commit-graph.h
index 7dc1f2b22bd..7bbc69989ce 100644
--- a/commit-graph.h
+++ b/commit-graph.h
@@ -128,7 +128,7 @@ struct repo_settings;
  * Callers should initialize the repo_settings with prepare_repo_settings()
  * prior to calling parse_commit_graph().
  */
-struct commit_graph *parse_commit_graph(struct repo_settings *s,
+struct commit_graph *parse_commit_graph(struct repository *r,
 					void *graph_map, size_t graph_size);
 
 /*
diff --git a/oss-fuzz/fuzz-commit-graph.c b/oss-fuzz/fuzz-commit-graph.c
index fbb77fec197..fb8b8787a46 100644
--- a/oss-fuzz/fuzz-commit-graph.c
+++ b/oss-fuzz/fuzz-commit-graph.c
@@ -4,9 +4,6 @@
 #include "commit-graph.h"
 #include "repository.h"
 
-struct commit_graph *parse_commit_graph(struct repo_settings *s,
-					void *graph_map, size_t graph_size);
-
 int LLVMFuzzerTestOneInput(const uint8_t *data, size_t size);
 
 int LLVMFuzzerTestOneInput(const uint8_t *data, size_t size)
@@ -22,9 +19,10 @@ int LLVMFuzzerTestOneInput(const uint8_t *data, size_t size)
 	 * possible.
 	 */
 	repo_set_hash_algo(the_repository, GIT_HASH_SHA1);
+	the_repository->settings.initialized = 1;
 	the_repository->settings.commit_graph_generation_version = 2;
 	the_repository->settings.commit_graph_changed_paths_version = 1;
-	g = parse_commit_graph(&the_repository->settings, (void *)data, size);
+	g = parse_commit_graph(the_repository, (void *)data, size);
 	repo_clear(the_repository);
 	free_commit_graph(g);
 

-- 
2.51.0.rc1.215.g0f929dcec7.dirty

