Received: from fhigh-a1-smtp.messagingengine.com (fhigh-a1-smtp.messagingengine.com [103.168.172.152])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C9C6D1FDA89
	for <git@vger.kernel.org>; Fri, 15 Aug 2025 05:50:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.152
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755237007; cv=none; b=Z0qCUOU/3i81jYz92MKn4vn+BTzr/EAlDee/3aCNmTvZhdQfXI5ikn02Y8XBnyi3U57kBaYKS/5MvqYTECVWfmnjFVj4mq1s3HN+mICkyknrHX9tFV3q6zzPcQKaOLnQHE2x+OltT+7nw3NbeEeHz3GaoJdgBOq6n/a1m6LFw5o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755237007; c=relaxed/simple;
	bh=hO8eVRNeBwpp5uBg/6I1p574xS8w1Odopl8+lqVb/pk=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=F2h/u2mfb8Ct/9uHgB7JrYKNIQunqt7U5r+sb9xYy8kPlbCuEDvLSdxS+kpd5zIX89YUGcvr2oLuClNfZ6MjdPlk/9zDlPPykkj4hoxpk4/Od1m1CtqPgb9XUPDtNz/4VWkpWSxxM8/7yQ8zBPcxbsD8qjXTUR86A8ihnORM5Y0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=GY7xT5S6; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=mZcNAqjG; arc=none smtp.client-ip=103.168.172.152
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="GY7xT5S6";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="mZcNAqjG"
Received: from phl-compute-03.internal (phl-compute-03.internal [10.202.2.43])
	by mailfhigh.phl.internal (Postfix) with ESMTP id D50D31400048;
	Fri, 15 Aug 2025 01:50:04 -0400 (EDT)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-03.internal (MEProxy); Fri, 15 Aug 2025 01:50:04 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm3; t=1755237004;
	 x=1755323404; bh=flZZ7cHWDXow+KdyctJvcjpGDcdY5u4fKqrv/qT/g9o=; b=
	GY7xT5S6cKHG5lfSVDNWkwz2nLqosJOEPUE2khtE36tCOIZ6jgHhsBd2JDwvY3kY
	pja5+wq/fvbi2P+QKQlx0MaHP/X63M0KDeSeRDHWzSdVCFZeLiYlxhVeSAK1f/vE
	wbPqvAxdGX1Ukwps5k/qJeOY8NiIlAQA70zhXNYM/MU1djtOzArSRvq4OGjWmSQl
	ROoiJli8QGXRzxpaow8yXQCxnHSQ8VYRI6MoyamOwiH101P97Ha5XvhEAQ2MZAIz
	IezlABsUGj6WBqlP8oqVVt4PrFlb0/6KJmBhInNjx0PlB2bZ472j1C7Mmdp6Kped
	KnsTuKwVYeT8Cz2fTRZFDg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1755237004; x=
	1755323404; bh=flZZ7cHWDXow+KdyctJvcjpGDcdY5u4fKqrv/qT/g9o=; b=m
	ZcNAqjGpJoTGlzUwcQkEZSOu4Zf14dga54Ue6AAJWjTq5a71J6SE5Eas+G3wB6sZ
	HKEwqyApaUJnRP4RJ/lGCZUiHVwzs032sNBN4EmPTgmqhzwvFQK3ENR7qOjH3z4v
	UYe7UoQeYfRGj7H2DCNurhRWeMunbbeljvENYZYc0XUjErerBypVw85tsO6EhilU
	3eFNKyNqxlz5ds+TbZW+odJ0g2qF69PFYywr7yjpcfGVcmY7zAKtlKiGQ93uDgJP
	wnUDwzMFAQkpfrESDn1Ov+1XRa7zxLWZRgRRB3Pv2nqYVcbV4n/beWMteeOnRnql
	dBmAw/Qgmqy6Nl134wRNA==
X-ME-Sender: <xms:jMqeaO6kqQkA3imcIxh7le8F8HGbBckuB3NJNQjZvR4Xbu7AlQrtaA>
    <xme:jMqeaDag45kMnj1dLI6AfIOuTUt8TNO28kHiSavNqPBPR7DvZBAdRXmNZ8idfhjjb
    AoR3N36CXM93pVtQg>
X-ME-Received: <xmr:jMqeaD7lRBOEdiaxO06siCK4l8N1dZzzpsZpETInoJydbVO2g_QOM0Vz9Czz_yHobOjXJ_BNm-sxNXyoSOojqDmnL7rxK7lRqSb0VGipTw>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdefgddugeefudeiucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhephfffufggtgfgkfhfjgfvvefosehtjeertdertdejnecuhfhrohhmpefrrghtrhhi
    tghkucfuthgvihhnhhgrrhguthcuoehpshesphhkshdrihhmqeenucggtffrrghtthgvrh
    hnpeffueeiudejvdekheeuvdekfeffiedvueelteekudehjeetkeegvddugfdtgfeileen
    ucevlhhushhtvghrufhiiigvpedunecurfgrrhgrmhepmhgrihhlfhhrohhmpehpshesph
    hkshdrihhmpdhnsggprhgtphhtthhopeehpdhmohguvgepshhmthhpohhuthdprhgtphht
    thhopehoshifrghlugdrsghuugguvghnhhgrghgvnhesghhmgidruggvpdhrtghpthhtoh
    epghhithhsthgvrhesphhosghogidrtghomhdprhgtphhtthhopehsthholhgvvgesghhm
    rghilhdrtghomhdprhgtphhtthhopehgihhtsehvghgvrhdrkhgvrhhnvghlrdhorhhgpd
    hrtghpthhtohepmhgvsehtthgrhihlohhrrhdrtghomh
X-ME-Proxy: <xmx:jMqeaGAMiWiNkULNdC8UeXtIRxb8T_XsOgNYmVJ23GwPBAx1QBTYqg>
    <xmx:jMqeaJfe9E90fmOxESCwEpKpluDYtgdSwPeKF7uqJYSY0m2fPr3W7g>
    <xmx:jMqeaFK4q4aHuF9blqJyQQCi_y64NGY7Us9riSc-oNF2Gl-lCD_VIg>
    <xmx:jMqeaE1owJ0dHFQ4rNWgmzIBm2HsPMlLCl-nz5O5XIsJZKuH1Gb6sw>
    <xmx:jMqeaM0YtY-hWYYXYeCuq9isDvdczCauGUS0c6eQ3bndjzkB6VjD5Te1>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 15 Aug 2025 01:50:03 -0400 (EDT)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id df9e1e13 (TLSv1.3:TLS_CHACHA20_POLY1305_SHA256:256:NO);
	Fri, 15 Aug 2025 05:50:03 +0000 (UTC)
From: Patrick Steinhardt <ps@pks.im>
Date: Fri, 15 Aug 2025 07:49:50 +0200
Subject: [PATCH v4 4/6] commit-graph: stop using `the_hash_algo`
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250815-b4-pks-commit-graph-wo-the-repository-v4-4-b6b651178cce@pks.im>
References: <20250815-b4-pks-commit-graph-wo-the-repository-v4-0-b6b651178cce@pks.im>
In-Reply-To: <20250815-b4-pks-commit-graph-wo-the-repository-v4-0-b6b651178cce@pks.im>
To: git@vger.kernel.org
Cc: Taylor Blau <me@ttaylorr.com>, Derrick Stolee <stolee@gmail.com>, 
 Oswald Buddenhagen <oswald.buddenhagen@gmx.de>, 
 Junio C Hamano <gitster@pobox.com>
X-Mailer: b4 0.14.2

Stop using `the_hash_algo` as it implicitly relies on `the_repository`.
Instead, we either use the hash algo provided via the context or, if
there is no such hash algo, we use `the_repository` explicitly. Such
uses will be removed in subsequent commits.

Signed-off-by: Patrick Steinhardt <ps@pks.im>
---
 builtin/commit-graph.c |  3 ++-
 commit-graph.c         | 27 ++++++++++++++-------------
 commit-graph.h         |  3 ++-
 3 files changed, 18 insertions(+), 15 deletions(-)

diff --git a/builtin/commit-graph.c b/builtin/commit-graph.c
index 25018a0b9d..fa6dd34d8d 100644
--- a/builtin/commit-graph.c
+++ b/builtin/commit-graph.c
@@ -108,7 +108,8 @@ static int graph_verify(int argc, const char **argv, const char *prefix,
 		opened = OPENED_GRAPH;
 	else if (errno != ENOENT)
 		die_errno(_("Could not open commit-graph '%s'"), graph_name);
-	else if (open_commit_graph_chain(chain_name, &fd, &st))
+	else if (open_commit_graph_chain(chain_name, &fd, &st,
+					 the_repository->hash_algo))
 		opened = OPENED_CHAIN;
 	else if (errno != ENOENT)
 		die_errno(_("could not open commit-graph chain '%s'"), chain_name);
diff --git a/commit-graph.c b/commit-graph.c
index 2f314a7407..46f55c8bb4 100644
--- a/commit-graph.c
+++ b/commit-graph.c
@@ -264,7 +264,7 @@ struct commit_graph *load_commit_graph_one_fd_st(struct repository *r,
 
 	graph_size = xsize_t(st->st_size);
 
-	if (graph_size < graph_min_size(the_hash_algo)) {
+	if (graph_size < graph_min_size(r->hash_algo)) {
 		close(fd);
 		error(_("commit-graph file is too small"));
 		return NULL;
@@ -319,7 +319,7 @@ static int graph_read_commit_data(const unsigned char *chunk_start,
 				  size_t chunk_size, void *data)
 {
 	struct commit_graph *g = data;
-	if (chunk_size / graph_data_width(the_hash_algo) != g->num_commits)
+	if (chunk_size / graph_data_width(g->hash_algo) != g->num_commits)
 		return error(_("commit-graph commit data chunk is wrong size"));
 	g->chunk_commit_data = chunk_start;
 	return 0;
@@ -620,7 +620,8 @@ static int add_graph_to_chain(struct commit_graph *g,
 }
 
 int open_commit_graph_chain(const char *chain_file,
-			    int *fd, struct stat *st)
+			    int *fd, struct stat *st,
+			    const struct git_hash_algo *hash_algo)
 {
 	*fd = git_open(chain_file);
 	if (*fd < 0)
@@ -629,7 +630,7 @@ int open_commit_graph_chain(const char *chain_file,
 		close(*fd);
 		return 0;
 	}
-	if (st->st_size < the_hash_algo->hexsz) {
+	if (st->st_size < hash_algo->hexsz) {
 		close(*fd);
 		if (!st->st_size) {
 			/* treat empty files the same as missing */
@@ -653,7 +654,7 @@ struct commit_graph *load_commit_graph_chain_fd_st(struct repository *r,
 	int i = 0, valid = 1, count;
 	FILE *fp = xfdopen(fd, "r");
 
-	count = st->st_size / (the_hash_algo->hexsz + 1);
+	count = st->st_size / (r->hash_algo->hexsz + 1);
 	CALLOC_ARRAY(oids, count);
 
 	odb_prepare_alternates(r->objects);
@@ -715,7 +716,7 @@ static struct commit_graph *load_commit_graph_chain(struct repository *r,
 	int fd;
 	struct commit_graph *g = NULL;
 
-	if (open_commit_graph_chain(chain_file, &fd, &st)) {
+	if (open_commit_graph_chain(chain_file, &fd, &st, r->hash_algo)) {
 		int incomplete;
 		/* ownership of fd is taken over by load function */
 		g = load_commit_graph_chain_fd_st(r, fd, &st, &incomplete);
@@ -907,7 +908,7 @@ static void fill_commit_graph_info(struct commit *item, struct commit_graph *g,
 		die(_("invalid commit position. commit-graph is likely corrupt"));
 
 	lex_index = pos - g->num_commits_in_base;
-	commit_data = g->chunk_commit_data + st_mult(graph_data_width(the_hash_algo), lex_index);
+	commit_data = g->chunk_commit_data + st_mult(graph_data_width(g->hash_algo), lex_index);
 
 	graph_data = commit_graph_data_at(item);
 	graph_data->graph_pos = pos;
@@ -1111,7 +1112,7 @@ static struct tree *load_tree_for_commit(struct repository *r,
 		g = g->base_graph;
 
 	commit_data = g->chunk_commit_data +
-			st_mult(graph_data_width(the_hash_algo),
+			st_mult(graph_data_width(g->hash_algo),
 				graph_pos - g->num_commits_in_base);
 
 	oidread(&oid, commit_data, the_repository->hash_algo);
@@ -1220,7 +1221,7 @@ static int write_graph_chunk_oids(struct hashfile *f,
 	int count;
 	for (count = 0; count < ctx->commits.nr; count++, list++) {
 		display_progress(ctx->progress, ++ctx->progress_cnt);
-		hashwrite(f, (*list)->object.oid.hash, the_hash_algo->rawsz);
+		hashwrite(f, (*list)->object.oid.hash, f->algop->rawsz);
 	}
 
 	return 0;
@@ -1251,7 +1252,7 @@ static int write_graph_chunk_data(struct hashfile *f,
 			die(_("unable to parse commit %s"),
 				oid_to_hex(&(*list)->object.oid));
 		tree = get_commit_tree_oid(*list);
-		hashwrite(f, tree->hash, the_hash_algo->rawsz);
+		hashwrite(f, tree->hash, ctx->r->hash_algo->rawsz);
 
 		parent = (*list)->parents;
 
@@ -2034,7 +2035,7 @@ static int write_graph_chunk_base_1(struct hashfile *f,
 		return 0;
 
 	num = write_graph_chunk_base_1(f, g->base_graph);
-	hashwrite(f, g->oid.hash, the_hash_algo->rawsz);
+	hashwrite(f, g->oid.hash, g->hash_algo->rawsz);
 	return num + 1;
 }
 
@@ -2058,7 +2059,7 @@ static int write_commit_graph_file(struct write_commit_graph_context *ctx)
 	struct hashfile *f;
 	struct tempfile *graph_layer; /* when ctx->split is non-zero */
 	struct lock_file lk = LOCK_INIT;
-	const unsigned hashsz = the_hash_algo->rawsz;
+	const unsigned hashsz = ctx->r->hash_algo->rawsz;
 	struct strbuf progress_title = STRBUF_INIT;
 	struct chunkfile *cf;
 	unsigned char file_hash[GIT_MAX_RAWSZ];
@@ -2146,7 +2147,7 @@ static int write_commit_graph_file(struct write_commit_graph_context *ctx)
 	hashwrite_be32(f, GRAPH_SIGNATURE);
 
 	hashwrite_u8(f, GRAPH_VERSION);
-	hashwrite_u8(f, oid_version(the_hash_algo));
+	hashwrite_u8(f, oid_version(ctx->r->hash_algo));
 	hashwrite_u8(f, get_num_chunks(cf));
 	hashwrite_u8(f, ctx->num_commit_graphs_after - 1);
 
diff --git a/commit-graph.h b/commit-graph.h
index 7bbc69989c..df10daf01c 100644
--- a/commit-graph.h
+++ b/commit-graph.h
@@ -32,7 +32,8 @@ struct string_list;
 char *get_commit_graph_filename(struct odb_source *source);
 char *get_commit_graph_chain_filename(struct odb_source *source);
 int open_commit_graph(const char *graph_file, int *fd, struct stat *st);
-int open_commit_graph_chain(const char *chain_file, int *fd, struct stat *st);
+int open_commit_graph_chain(const char *chain_file, int *fd, struct stat *st,
+			    const struct git_hash_algo *hash_algo);
 
 /*
  * Given a commit struct, try to fill the commit struct info, including:

-- 
2.51.0.rc1.215.g0f929dcec7.dirty

