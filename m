Received: from fhigh-a5-smtp.messagingengine.com (fhigh-a5-smtp.messagingengine.com [103.168.172.156])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EC9E3253F07
	for <git@vger.kernel.org>; Thu,  7 Aug 2025 08:05:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.156
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754553911; cv=none; b=V4O/RmVGcnjkOl+3J926Xhthn12+URSbf4ohpYzie44+RXf8/htoXlz1Mlho6drIvn97cIKJ2ChGYX7iU4hxSXi5p/dhvhpsttats3MJD99t5EgpTGZE1her89fIMo8M6uwNreyccDPZ2+oOJEzuToUxI3hQf6TzfltNzruEPaw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754553911; c=relaxed/simple;
	bh=txXPlyzPMoepEy5VK7sozFCR/jrS8Y191tD8jUi5yPM=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=JfZCRqiVJzHC6XhW/Lai4D/rax161ZZW4sAiwC9xoPZNtluzOfLVa3IqfQfv+A8wIFD6cyQLP+m8y8mYseSpvfF78/6FcLMyL2bUSHl7eu0yDa/CYJXsLJpS9DAFgs+ULtB/s1gjb9/tS69W2TCfbexPMuuRLc/AgHbG1paA4SI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=W9Etwy78; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=WW2OI7xn; arc=none smtp.client-ip=103.168.172.156
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="W9Etwy78";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="WW2OI7xn"
Received: from phl-compute-01.internal (phl-compute-01.internal [10.202.2.41])
	by mailfhigh.phl.internal (Postfix) with ESMTP id 27CA2140016F;
	Thu,  7 Aug 2025 04:05:09 -0400 (EDT)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-01.internal (MEProxy); Thu, 07 Aug 2025 04:05:09 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm3; t=1754553909;
	 x=1754640309; bh=cA8yP33KMnLdS96Qye+uqI6CP8F0m6cN4oXVuoO7cuk=; b=
	W9Etwy78eF+qDBBtU7waRJqDUtkjqr2Fozdtclh5IMHEgleUsOMH9tMDcKfmOLFG
	3hdhIkoimAqqK0llcacZhXxgWuXKHcLKo7DBRAAUexEL+6DlcsJhE+yy5b24Uk4G
	QKLkhN+n+P4KiQvjUukGFeP+yvM8tBDVQi/WEk89wDZoseddRLs/Q89oVum0PlRZ
	IuE/vndoyhybucOEomaCpltd/yz7xKWcr/rQ+tNj18+U61MRkmks6hlgQCyRg05u
	0ckhw4uHTk/FtQnXWguMFQM4gme+f3DdjHowWSwb4BDY2Nui6LYUI3a8oidp5HrQ
	k4AzjSxtL0X6AUAuWDZAdQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1754553909; x=
	1754640309; bh=cA8yP33KMnLdS96Qye+uqI6CP8F0m6cN4oXVuoO7cuk=; b=W
	W2OI7xnY//H2a3IMX5sD0fTTtj5YNOWixGAGEpptXdPD4IvGG2H6hA2a4yhOgQd5
	tD91X+Wypj9k6e54VPQcjx8wNUjUcWPnUwsFTri+wrqoHZVZ+bVC1l/VNFJTx2ZP
	BdU3BeSqJxQwmVtGlKdvFUCuXi5ZIIL94eYsUV4sJ+Hqpy/VSS6af1sSaKt/Yoin
	xGv6tWqR//juCu1Ivc9P0w9MyrWLNDANN34LUqIFin04P5narYIBiS/nb1+SM598
	AWQLJjzVMlVg+3GWypEOcBHDEQpsaeYpqfMpeIdAvKXrfKgoOxmo83oqNqVrD44s
	XRjug148tFFVyh5TJRnZQ==
X-ME-Sender: <xms:NF6UaNcv8aoyqYrKgNFfN1RVtnK0Al2c-0s0LZxvaDdbhL366BPRXQ>
    <xme:NF6UaGsb86hqJ52wdZ2fTNBY4H8oqcanNV01DfVdeNx_UgOBvaFTSasD0175uD2n-
    1AzcvrZAAzBnizKyQ>
X-ME-Received: <xmr:NF6UaM_4afCKpW3tZ78tzfjYreGSxGmpboTSk61hQk0_RH1q5hK9SgM4ZnJR-KHlasFUFvCl1PkD_MM8WEU3qPB7wj_aifwk4VCMdwtWgA>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdefgdduvddtgeduucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhephfffufggtgfgkfhfjgfvvefosehtjeertdertdejnecuhfhrohhmpefrrghtrhhi
    tghkucfuthgvihhnhhgrrhguthcuoehpshesphhkshdrihhmqeenucggtffrrghtthgvrh
    hnpeffueeiudejvdekheeuvdekfeffiedvueelteekudehjeetkeegvddugfdtgfeileen
    ucevlhhushhtvghrufhiiigvpedvnecurfgrrhgrmhepmhgrihhlfhhrohhmpehpshesph
    hkshdrihhmpdhnsggprhgtphhtthhopeehpdhmohguvgepshhmthhpohhuthdprhgtphht
    thhopehgihhtsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtohepmhgvsehtth
    grhihlohhrrhdrtghomhdprhgtphhtthhopehgihhtshhtvghrsehpohgsohigrdgtohhm
    pdhrtghpthhtohepohhsfigrlhgurdgsuhguuggvnhhhrghgvghnsehgmhigrdguvgdprh
    gtphhtthhopehsthholhgvvgesghhmrghilhdrtghomh
X-ME-Proxy: <xmx:NF6UaB2nkqgaA63QcfYUDAGIUfN-i7Zl3978A5buFn8vVzihGownmg>
    <xmx:NV6UaBCPTcHL7fb15YLthZ4eZfe6vrpCLiAF08jGhEc1hS5Ntw-7Mg>
    <xmx:NV6UaNeRhxXSgrTHAnWG9JhKBy-vmai3uL5NEU4eCwfUKnqVEbi2bg>
    <xmx:NV6UaO6DZdObUN0zxuLD7obLyxsIjM1TkQcZscK_OSEyULbnqAjKqg>
    <xmx:NV6UaCq4HeZKOGcM4Is3uZBuywAUhkp5xYv3cOtDP3kRV4GWdeafS8_r>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 7 Aug 2025 04:05:08 -0400 (EDT)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id ed562dea (TLSv1.3:TLS_CHACHA20_POLY1305_SHA256:256:NO);
	Thu, 7 Aug 2025 08:05:07 +0000 (UTC)
From: Patrick Steinhardt <ps@pks.im>
Date: Thu, 07 Aug 2025 10:04:48 +0200
Subject: [PATCH v3 06/10] commit-graph: store the hash algorithm instead of
 its length
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250807-b4-pks-commit-graph-wo-the-repository-v3-6-82edef830a1e@pks.im>
References: <20250807-b4-pks-commit-graph-wo-the-repository-v3-0-82edef830a1e@pks.im>
In-Reply-To: <20250807-b4-pks-commit-graph-wo-the-repository-v3-0-82edef830a1e@pks.im>
To: git@vger.kernel.org
Cc: Taylor Blau <me@ttaylorr.com>, Derrick Stolee <stolee@gmail.com>, 
 Oswald Buddenhagen <oswald.buddenhagen@gmx.de>, 
 Junio C Hamano <gitster@pobox.com>
X-Mailer: b4 0.14.2

The commit-graph stores the length of the hash algorithm it uses. In
subsequent commits we'll need to pass the whole hash algorithm around
though, which we currently don't have access to.

Refactor the code so that we store the hash algorithm instead of only
its size.

Signed-off-by: Patrick Steinhardt <ps@pks.im>
---
 commit-graph.c | 36 ++++++++++++++++++------------------
 commit-graph.h |  2 +-
 2 files changed, 19 insertions(+), 19 deletions(-)

diff --git a/commit-graph.c b/commit-graph.c
index e75fb8e6ea..430eab0b86 100644
--- a/commit-graph.c
+++ b/commit-graph.c
@@ -310,7 +310,7 @@ static int graph_read_oid_lookup(const unsigned char *chunk_start,
 {
 	struct commit_graph *g = data;
 	g->chunk_oid_lookup = chunk_start;
-	if (chunk_size / g->hash_len != g->num_commits)
+	if (chunk_size / g->hash_algo->rawsz != g->num_commits)
 		return error(_("commit-graph OID lookup chunk is the wrong size"));
 	return 0;
 }
@@ -412,7 +412,7 @@ struct commit_graph *parse_commit_graph(struct repo_settings *s,
 
 	graph = alloc_commit_graph();
 
-	graph->hash_len = the_hash_algo->rawsz;
+	graph->hash_algo = the_hash_algo;
 	graph->num_chunks = *(unsigned char*)(data + 6);
 	graph->data = graph_map;
 	graph->data_len = graph_size;
@@ -477,7 +477,7 @@ struct commit_graph *parse_commit_graph(struct repo_settings *s,
 		FREE_AND_NULL(graph->bloom_filter_settings);
 	}
 
-	oidread(&graph->oid, graph->data + graph->data_len - graph->hash_len,
+	oidread(&graph->oid, graph->data + graph->data_len - graph->hash_algo->rawsz,
 		the_repository->hash_algo);
 
 	free_chunkfile(cf);
@@ -583,7 +583,7 @@ static int add_graph_to_chain(struct commit_graph *g,
 		return 0;
 	}
 
-	if (g->chunk_base_graphs_size / g->hash_len < n) {
+	if (g->chunk_base_graphs_size / g->hash_algo->rawsz < n) {
 		warning(_("commit-graph base graphs chunk is too small"));
 		return 0;
 	}
@@ -593,7 +593,7 @@ static int add_graph_to_chain(struct commit_graph *g,
 
 		if (!cur_g ||
 		    !oideq(&oids[n], &cur_g->oid) ||
-		    !hasheq(oids[n].hash, g->chunk_base_graphs + st_mult(g->hash_len, n),
+		    !hasheq(oids[n].hash, g->chunk_base_graphs + st_mult(g->hash_algo->rawsz, n),
 			    the_repository->hash_algo)) {
 			warning(_("commit-graph chain does not match"));
 			return 0;
@@ -805,7 +805,7 @@ int generation_numbers_enabled(struct repository *r)
 		return 0;
 
 	first_generation = get_be32(g->chunk_commit_data +
-				    g->hash_len + 8) >> 2;
+				    g->hash_algo->rawsz + 8) >> 2;
 
 	return !!first_generation;
 }
@@ -849,7 +849,7 @@ void close_commit_graph(struct object_database *o)
 static int bsearch_graph(struct commit_graph *g, const struct object_id *oid, uint32_t *pos)
 {
 	return bsearch_hash(oid->hash, g->chunk_oid_fanout,
-			    g->chunk_oid_lookup, g->hash_len, pos);
+			    g->chunk_oid_lookup, g->hash_algo->rawsz, pos);
 }
 
 static void load_oid_from_graph(struct commit_graph *g,
@@ -869,7 +869,7 @@ static void load_oid_from_graph(struct commit_graph *g,
 
 	lex_index = pos - g->num_commits_in_base;
 
-	oidread(oid, g->chunk_oid_lookup + st_mult(g->hash_len, lex_index),
+	oidread(oid, g->chunk_oid_lookup + st_mult(g->hash_algo->rawsz, lex_index),
 		the_repository->hash_algo);
 }
 
@@ -911,8 +911,8 @@ static void fill_commit_graph_info(struct commit *item, struct commit_graph *g,
 	graph_data = commit_graph_data_at(item);
 	graph_data->graph_pos = pos;
 
-	date_high = get_be32(commit_data + g->hash_len + 8) & 0x3;
-	date_low = get_be32(commit_data + g->hash_len + 12);
+	date_high = get_be32(commit_data + g->hash_algo->rawsz + 8) & 0x3;
+	date_low = get_be32(commit_data + g->hash_algo->rawsz + 12);
 	item->date = (timestamp_t)((date_high << 32) | date_low);
 
 	if (g->read_generation_data) {
@@ -930,10 +930,10 @@ static void fill_commit_graph_info(struct commit *item, struct commit_graph *g,
 		} else
 			graph_data->generation = item->date + offset;
 	} else
-		graph_data->generation = get_be32(commit_data + g->hash_len + 8) >> 2;
+		graph_data->generation = get_be32(commit_data + g->hash_algo->rawsz + 8) >> 2;
 
 	if (g->topo_levels)
-		*topo_level_slab_at(g->topo_levels, item) = get_be32(commit_data + g->hash_len + 8) >> 2;
+		*topo_level_slab_at(g->topo_levels, item) = get_be32(commit_data + g->hash_algo->rawsz + 8) >> 2;
 }
 
 static inline void set_commit_tree(struct commit *c, struct tree *t)
@@ -957,7 +957,7 @@ static int fill_commit_in_graph(struct repository *r,
 	fill_commit_graph_info(item, g, pos);
 
 	lex_index = pos - g->num_commits_in_base;
-	commit_data = g->chunk_commit_data + st_mult(g->hash_len + 16, lex_index);
+	commit_data = g->chunk_commit_data + st_mult(g->hash_algo->rawsz + 16, lex_index);
 
 	item->object.parsed = 1;
 
@@ -965,12 +965,12 @@ static int fill_commit_in_graph(struct repository *r,
 
 	pptr = &item->parents;
 
-	edge_value = get_be32(commit_data + g->hash_len);
+	edge_value = get_be32(commit_data + g->hash_algo->rawsz);
 	if (edge_value == GRAPH_PARENT_NONE)
 		return 1;
 	pptr = insert_parent_or_die(r, g, edge_value, pptr);
 
-	edge_value = get_be32(commit_data + g->hash_len + 4);
+	edge_value = get_be32(commit_data + g->hash_algo->rawsz + 4);
 	if (edge_value == GRAPH_PARENT_NONE)
 		return 1;
 	if (!(edge_value & GRAPH_EXTRA_EDGES_NEEDED)) {
@@ -2622,7 +2622,7 @@ int write_commit_graph(struct odb_source *source,
 		struct commit_graph *g = ctx.r->objects->commit_graph;
 		for (i = 0; i < g->num_commits; i++) {
 			struct object_id oid;
-			oidread(&oid, g->chunk_oid_lookup + st_mult(g->hash_len, i),
+			oidread(&oid, g->chunk_oid_lookup + st_mult(g->hash_algo->rawsz, i),
 				the_repository->hash_algo);
 			oid_array_append(&ctx.oids, &oid);
 		}
@@ -2753,7 +2753,7 @@ static int verify_one_commit_graph(struct repository *r,
 	for (i = 0; i < g->num_commits; i++) {
 		struct commit *graph_commit;
 
-		oidread(&cur_oid, g->chunk_oid_lookup + st_mult(g->hash_len, i),
+		oidread(&cur_oid, g->chunk_oid_lookup + st_mult(g->hash_algo->rawsz, i),
 			the_repository->hash_algo);
 
 		if (i && oidcmp(&prev_oid, &cur_oid) >= 0)
@@ -2798,7 +2798,7 @@ static int verify_one_commit_graph(struct repository *r,
 		timestamp_t generation;
 
 		display_progress(progress, ++(*seen));
-		oidread(&cur_oid, g->chunk_oid_lookup + st_mult(g->hash_len, i),
+		oidread(&cur_oid, g->chunk_oid_lookup + st_mult(g->hash_algo->rawsz, i),
 			the_repository->hash_algo);
 
 		graph_commit = lookup_commit(r, &cur_oid);
diff --git a/commit-graph.h b/commit-graph.h
index f5b032e982..2228c714cb 100644
--- a/commit-graph.h
+++ b/commit-graph.h
@@ -84,7 +84,7 @@ struct commit_graph {
 	const unsigned char *data;
 	size_t data_len;
 
-	unsigned char hash_len;
+	const struct git_hash_algo *hash_algo;
 	unsigned char num_chunks;
 	uint32_t num_commits;
 	struct object_id oid;

-- 
2.51.0.rc0.215.g125493bb4a.dirty

