Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=103.168.172.146
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794834497;
	b=z6PV1cE2g+EOFgMkUEbzVrYQdRZT9lXxEY4Dng4EFyLZZJacvzqnTc3VL02XhYV6JBCj
	 4Li2u3j6ZBRKabCYgJS8+YpdEv6XkOYSpAP29G99liEvvN/QZZTKzUGfCTWve0GfJkRbp
	 8gJ6+Jq5hFPcSqtGRbJlosAurVx31zYlmSgKHe0l7zTLRiKUDjCv72mn5oPX5h9bM9y1E
	 1S03SCK9RUfJyGxXrOU+KRr0PbtC/3KFm+HX3lJyu0ByW/2vwLO5nP2jx1HbBd/4AHATb
	 ghkoS1xVyuGboMc4+kH0Xf5aaA0KK6LSmPata7cSoJFWBk7Az7XWQ/QDlKqbUSwTLdQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794834497;
	h=DMARC-Filter:Received:Received:DKIM-Signature:DKIM-Signature:
	 X-DKIM2-Info:DKIM2-Signature:X-DKIM2-Info:Message-Instance:
	 X-ME-Sender:X-ME-Received:X-ME-Proxy-Cause:X-ME-Proxy:Feedback-ID:
	 Received:Received:From:Date:Subject:MIME-Version:Content-Type:
	 Content-Transfer-Encoding:Message-Id:References:In-Reply-To:To:Cc:
	 X-Mailer;
	bh=wZrqGnRwsePFsVI0Nf/SRaiC5q3mK6krTzRjkc1OT70=;
	b=xqdpEnkxr00FkgbBgM4QJy/LQ1YXO0TgRYMgC/D676r3zVSQucLZmJ7mfPAjub8vdLcx
	 lwGB8coceo+y6p2HVNLCbZoHuZs1h0md5gJNH8/srND1lF8og8XVLkikSwcD5FCV8r83A
	 En/Hs68BFpRSs+hhw4VTJMMMnKWlm8Zx8Ny3pCOiajv7hVxKbKAjHB+0xhehb6xoyJsVl
	 Ov/KY4DHUwX1TV4NGQeolZUQAJ3rVQXsQ97WywJz9FczuVU7z4RbQWcJm+3JwI9f5dWvV
	 QZcD+86aZsq5bD/jn9VYBQPGyqh6kIU0sL/oWp6y85fJNnjpp2a+gdJw3FJ4Dw4RS8Q==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=pks.im;
	spf=pass smtp.mailfrom=pks.im;
	dkim=pass header.d=pks.im header.i=@pks.im header.a=rsa-sha256 header.s=fm3 header.b=iYv+Qss9;
	dkim=pass header.d=messagingengine.com header.i=@messagingengine.com header.a=rsa-sha256 header.s=fm3 header.b=DUeWc9oc;
	arc=none smtp.remote-ip=103.168.172.146
Received: from fout-a3-smtp.messagingengine.com (fout-a3-smtp.messagingengine.com [103.168.172.146])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 67D6F606A898
	for <git@vger.kernel.org>; Mon, 16 Nov 2026 13:08:16 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 67D6F606A898
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=pks.im header.i=@pks.im header.a=rsa-sha256 header.s=fm3 header.b=iYv+Qss9;
	dkim=pass (2048-bit key, unprotected) header.d=messagingengine.com header.i=@messagingengine.com header.a=rsa-sha256 header.s=fm3 header.b=DUeWc9oc
Received: from phl-compute-04.internal (phl-compute-04.internal [10.202.2.44])
	by mailfout.phl.internal (Postfix) with ESMTP id 782B8EC004E
	for <git@vger.kernel.org>; Mon, 16 Nov 2026 08:08:15 -0500 (EST)
Received: from phl-frontend-03 ([10.202.2.162])
  by phl-compute-04.internal (MEProxy); Mon, 16 Nov 2026 08:08:15 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm3; t=1794834495;
	 x=1794920895; bh=wZrqGnRwsePFsVI0Nf/SRaiC5q3mK6krTzRjkc1OT70=; b=
	iYv+Qss97F+A2z486OqRBmk8rFVe5W3ZizwV3ILWlomnC9VgsDI6nEBmR4rIPpjJ
	wAiSLgO1qSbBvFKvje4xMvA6IYmFiqu0OpDyLpBIUl/h35JjutV4ZbH7EsiNQBKa
	MtoOIS0vN6kfcJjuOwqGZtyHLm4M/2Ce4Ox1jWWHYvTmYtZuqP3xgMRSkYr9SrQ/
	D574SBTslPK4CoLRG05IGeaMMMgYiELrMeIeBiccPrAYmEMSRIxHthuwsdDoZUsz
	HLn9m4A2REOB2eiLKTGDRpyStyhLtFFlns+fjmysE+j7mnmMODQVQ7R5orf0BYjU
	mjbLG7kwsRN3qRU3Rf1x9w==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1794834495; x=
	1794920895; bh=wZrqGnRwsePFsVI0Nf/SRaiC5q3mK6krTzRjkc1OT70=; b=D
	UeWc9oc6BDwahFbcfPWStsQuxWNOuT7qKXhcqcJy7HdeH/tXWeZGQsJfknjOOx2r
	X3e+zSOfN4ZDlCuyaBNB/7fQf29S0H6pakRRw9uqyrUGFiQOX0qeSGofyl4pZzpX
	d2A4pAzndKHtcDlpuz7ZjaBQvGOEN6FbL3SnluJoP2kXwq+za9CmXMyhZvYJ2YbG
	rM9Y09FH9LTuaLsKclhmMnvYeR+JlwaNcdGzX4sXdnoHDug+4f8OqbOl6b0oi9So
	ItwjLHulX54515HWFXAksiEZc/A3yYW/AQRg79CVNBFO02DzdiqbVIywYmrf7XKQ
	jhB2/83lFdcL96sHrUPHw==
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-09;
	repo=github.com/dkim2wg/interop; date=2026-11-03; sw=lmtpprox;
	action=sign d=pks.im a=rsa-sha256;
DKIM2-Signature: i=1; m=1; t=1794834495; d=pks.im; mf=PHBzQHBrcy5pbT4=;
	rt=PGdpdEB2Z2VyLmtlcm5lbC5vcmc+;
	s=fm3:rsa-sha256:B4d2wgjYHZXJoOwzeSN0CvcsBWGat7Mj519tzKBqHyDa7Kc
	b1xjp0PV7hkouqpiHGRPELgXdP3j7uMIkV2FKeqFbWa0lJWpyVfxECqVUqjBl7PB
	sToxWmfhuliWpnAgnYhxZleaY0TWE1BMozOpD7p8SyKCxCqR8JFQESpODiK3/htx
	RG+f7+rbVR0YabB9w9rt8u07hYBBPNY3JJzd36qQGGcDNosEuTV5houVxYnRw60v
	iLNqLzwfRVrQqgYB6gdlYGcICHmN1baHewo6EI0acEPbipjvVyXUZ4lvRQ0o1QEE
	bxkjC92qmLH+AkWWJE0uIqx1seMI0+Kj1/X6iGQ==;
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-09;
	repo=github.com/dkim2wg/interop; date=2026-11-03; sw=lmtpprox;
	action=mi-m=1; hc=12;
	hn=cc,content-transfer-encoding,content-type,date,feedback-id,
	from,in-reply-to,message-id,mime-version,references,subject,to;
Message-Instance: m=1; h=sha256:Xqpl6qP2BswmNU5TG+MND8WWFTcrP51H7p18d+FW/cQ=:HewasxNvBiz/+F7XjXNPEmBHp0n4S2kkrxYBajhogpg=;
X-ME-Sender: <xms:PwD7anwMSrTD8hsOAQ6B127E0mLKM1okjixbK2J0jX76UfKFnBiW-Q>
    <xme:PwD7amPNrvsA6D8mu2GF1RkEILA2x0SSbybfglM3ktlbf8QBLyv_W-_dR7i5zWOnJ
    pjPUSx7o0DBv17HjWIRQXcusm9fdLwS3AjCDAek5cW4DYesdr_nUX0>
X-ME-Received: <xmr:PwD7am_QWuOiH75S4j9CYa2tvWmCeIm3HYXhpMyH2XrS6yxnQ0ycouv8tLAtHHzoqiDwkE8>
X-ME-Proxy-Cause: dmFkZTFZEY3dRZaxYHKztVo3PV5exS7LC5so/OemZvN+WRzyMAuPxUkF0s8DXR9rm3sIft
    TNy3msB44N8fedNp8OEKsFykHBMtYYTrfbK0L+IwZ5LKw3S98nfrCPUmkqNy5t4VRzNB1H
    O1k+n5la66tVUCb3ERJIwzKtcyG8zt2k7Nq63bv8Bsb1mnjRJ95cbEfwctWmirTzT7W0Vv
    +wbH8aDjSJMImH6U0aTopBPlpGclwtUfOlL0sb99rKBTgdFJT1iNWAATNvrbto6s5wHgrA
    pyryLSwJgJXsiTvNzA0Sp3b/jhixtqv/ivz+VDrfFpK2d437jTBw6zWR21v5KA2lf8++Qw
    iHkFD3r8Wnq9Nv6dZswjun69IWHgZXLzipAsyiGdOp+e56RTzxuWYzZ68mGL8/TnFT7C6J
    aZnL6jMo54yBzcEX46YckME1VvPDb0WJX1/56nu1deOr5mfjgJ4B5DcNj+bNJqOPQXU2mW
    V5rP9n04mvO2ZixGCwoK34gpgZRTsPgggfK+6OwUUzz+KeDlQbTNuV2gzpMMgYunCdAJja
    cgWGr86wusIEKeq6LOhOl4QICDjFGnOd9/41597QGhOSzttcpS+1Klz4Wz/BRb3YXbqyj3
    q0OoV1grUV14334pz/0z4shvnbJnq/SnBWdLs+B4JbIk429UhA1SM98YGdbA
X-ME-Proxy: <xmx:PwD7amr6tzWRiRJY-ib2yS0Z72-9iwyqFACjHdAQzQi3pewNUCLhig>
    <xmx:PwD7ao7QLZGT5TdXagOYfA5MyySsLn5wF9g3lLLck15KTL8cBnCj7Q>
    <xmx:PwD7amNNdCJcm8eLoRI2gbya-IEkraxyTD7lir4LkiYuRflaxtKozg>
    <xmx:PwD7aqPuTmlBizTTmtfOhleS2jv_wTRXQD5AH6y0RzlbU62exA069g>
    <xmx:PwD7aly4p62rkBsGebT7cABv9dTPrrDRlY2J2j9bUS2eWhLKNrn6DpAN>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA for
 <git@vger.kernel.org>; Mon, 16 Nov 2026 08:08:14 -0500 (EST)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id 9bbebce0 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO)
	for <git@vger.kernel.org>;
	Mon, 16 Nov 2026 13:08:14 +0000 (UTC)
From: Patrick Steinhardt <ps@pks.im>
Date: Mon, 16 Nov 2026 14:07:44 +0100
Subject: [PATCH 08/12] commit-graph: split out logic to write a new commit
 graph layer
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
Message-Id: <20261116-pks-odb-pluggable-commit-graphs-v1-8-a83fc1ff0808@pks.im>
References: <20261116-pks-odb-pluggable-commit-graphs-v1-0-a83fc1ff0808@pks.im>
In-Reply-To: <20261116-pks-odb-pluggable-commit-graphs-v1-0-a83fc1ff0808@pks.im>
To: git@vger.kernel.org
Cc: 
X-Mailer: b4 0.15.2

The logic to write a new commit graph is mostly contained in
`write_commit_graph_file()`. This function has two different
responsibilities:

  - It writes the content of the new commit graph layer.

  - It manages the location of the newly written files, as well as the
    deletion of old files.

While the former is generic functionality, the latter is specific to the
actual backend once we make commit graphs pluggable.

Separate these two concerns by introducing `commit_graph_write_layer()`,
which is only responsible for writing the content of the new file.
The backend-specific handling of paths remain the responsibility of
`commit_graph_write()`, which allows us to move that logic into the
backend in a subsequent commit.

Signed-off-by: Patrick Steinhardt <ps@pks.im>
---
 commit-graph.c | 247 ++++++++++++++++++++++++++++++++-------------------------
 commit-graph.h |  27 +++++++
 2 files changed, 166 insertions(+), 108 deletions(-)

diff --git a/commit-graph.c b/commit-graph.c
index c673c0424da..7bb6b112b2e 100644
--- a/commit-graph.c
+++ b/commit-graph.c
@@ -1140,8 +1140,6 @@ struct tree *get_commit_tree_in_graph(struct repository *r, const struct commit
 
 struct write_commit_graph_context {
 	struct repository *r;
-	char *dir;
-	char *graph_name;
 	struct oid_array oids;
 	struct commit_stack commits;
 	int num_extra_edges;
@@ -2092,68 +2090,16 @@ static void expire_commit_graphs(const char *dirpath,
 				 struct string_list *kept,
 				 timestamp_t expire_time);
 
-static int write_commit_graph_file(struct write_commit_graph_context *ctx)
+static int write_commit_graph_file(struct write_commit_graph_context *ctx,
+				   int fd, const char *path,
+				   unsigned char *file_hash)
 {
-	struct hashfile *f;
-	struct tempfile *graph_layer = NULL; /* when COMMIT_GRAPH_WRITE_SPLIT is non-zero */
-	struct lock_file lk = LOCK_INIT;
 	const unsigned hashsz = ctx->r->hash_algo->rawsz;
 	struct strbuf progress_title = STRBUF_INIT;
-	struct string_list chain_hashes = STRING_LIST_INIT_DUP;
-	struct string_list kept = STRING_LIST_INIT_DUP;
-	struct commit_graph *base = ctx->new_base_graph, *chain;
-	char *base_rename_from = NULL, *base_rename_to = NULL;
-	char *new_path = NULL;
+	struct hashfile *f;
 	struct chunkfile *cf;
-	unsigned char file_hash[GIT_MAX_RAWSZ];
-	int ret;
-
-	if (ctx->opts->flags & COMMIT_GRAPH_WRITE_SPLIT) {
-		struct strbuf tmp_file = STRBUF_INIT;
-
-		strbuf_addf(&tmp_file,
-			    "%s/info/commit-graphs/tmp_graph_XXXXXX",
-			    ctx->dir);
-		ctx->graph_name = strbuf_detach(&tmp_file, NULL);
-	} else {
-		ctx->graph_name = get_commit_graph_filename(ctx->dir);
-	}
-
-	if (safe_create_leading_directories(ctx->r, ctx->graph_name)) {
-		ret = error(_("unable to create leading directories of %s"),
-			    ctx->graph_name);
-		goto out;
-	}
-
-	if (ctx->opts->flags & COMMIT_GRAPH_WRITE_SPLIT) {
-		char *lock_name = get_commit_graph_chain_filename(ctx->dir);
-
-		repo_hold_lock_file_for_update_mode(ctx->r, &lk, lock_name,
-						    LOCK_DIE_ON_ERROR, 0444);
-		free(lock_name);
-
-		graph_layer = mks_tempfile_m(ctx->graph_name, 0444);
-		if (!graph_layer) {
-			ret = error(_("unable to create temporary graph layer"));
-			goto out;
-		}
-
-		if (adjust_shared_perm(ctx->r, get_tempfile_path(graph_layer))) {
-			ret = error(_("unable to adjust shared permissions for '%s'"),
-				    get_tempfile_path(graph_layer));
-			goto out;
-		}
-
-		f = hashfd(ctx->r->hash_algo,
-			   get_tempfile_fd(graph_layer), get_tempfile_path(graph_layer));
-	} else {
-		repo_hold_lock_file_for_update_mode(ctx->r, &lk,
-						    ctx->graph_name,
-						    LOCK_DIE_ON_ERROR, 0444);
-		f = hashfd(ctx->r->hash_algo,
-			   get_lock_file_fd(&lk), get_lock_file_path(&lk));
-	}
 
+	f = hashfd(ctx->r->hash_algo, fd, path);
 	cf = init_chunkfile(f);
 
 	add_chunk(cf, GRAPH_CHUNKID_OIDFANOUT, GRAPH_FANOUT_SIZE,
@@ -2217,14 +2163,114 @@ static int write_commit_graph_file(struct write_commit_graph_context *ctx)
 			  CSUM_HASH_IN_STREAM | CSUM_FSYNC);
 	free_chunkfile(cf);
 
+	return 0;
+}
+
+int commit_graph_write(struct repository *r,
+		       const char *dir,
+		       const struct commit_graph_write_options *opts)
+{
+	struct string_list chain_hashes = STRING_LIST_INIT_DUP;
+	struct string_list kept = STRING_LIST_INIT_DUP;
+	struct tempfile *graph_layer = NULL;
+	struct lock_file lk = LOCK_INIT;
+	struct commit_graph *g, *chain, *base = NULL;
+	char *base_rename_from = NULL, *base_rename_to = NULL;
+	char *graph_name = NULL, *abs_dir = NULL, *new_path = NULL;
+	size_t mergeable_layers = 0, chainable_layers = 0;
+	unsigned char hash[GIT_MAX_RAWSZ];
+	bool mergeable = true;
+	const char *out_path;
+	int out_fd;
+	int ret;
+
+	if (!commit_graph_write_allowed(r))
+		return 0;
+
+	abs_dir = absolute_pathdup(dir);
+
+	g = prepare_commit_graph(r);
+
+	/*
+	 * We only consider merging layers that belong to our own object
+	 * directory. Furthermore, we can only chain on top of either:
+	 *
+	 *   - A split commit graph layer, regardless of whether or not it is
+	 *     local.
+	 *
+	 *   - A local non-split commit graph, in which case we'll convert that
+	 *     layer into a split commit graph layer.
+	 */
+	for (struct commit_graph *layer = g; layer; layer = layer->base_graph) {
+		char *path = get_commit_graph_filename(layer->dir);
+		bool is_split = !!strcmp(layer->filename, path);
+		bool is_local = !strcmp(layer->dir, abs_dir);
+
+		free(path);
+
+		if (!is_local && !is_split)
+			break;
+		if (!is_local)
+			mergeable = false;
+
+		if (mergeable)
+			mergeable_layers++;
+		chainable_layers++;
+	}
+
+	if (opts->flags & COMMIT_GRAPH_WRITE_SPLIT) {
+		graph_name = xstrfmt("%s/info/commit-graphs/tmp_graph_XXXXXX", abs_dir);
+	} else {
+		graph_name = get_commit_graph_filename(abs_dir);
+	}
+
+	if (safe_create_leading_directories(r, graph_name)) {
+		ret = error(_("unable to create leading directories of %s"),
+			    graph_name);
+		goto out;
+	}
+
+	if (opts->flags & COMMIT_GRAPH_WRITE_SPLIT) {
+		char *chain_name = get_commit_graph_chain_filename(abs_dir);
+
+		repo_hold_lock_file_for_update_mode(r, &lk, chain_name,
+						    LOCK_DIE_ON_ERROR, 0444);
+		free(chain_name);
+
+		graph_layer = mks_tempfile_m(graph_name, 0444);
+		if (!graph_layer) {
+			ret = error(_("unable to create temporary graph layer"));
+			goto out;
+		}
+
+		if (adjust_shared_perm(r, get_tempfile_path(graph_layer))) {
+			ret = error(_("unable to adjust shared permissions for '%s'"),
+				    get_tempfile_path(graph_layer));
+			goto out;
+		}
+
+		out_fd = get_tempfile_fd(graph_layer);
+		out_path = get_tempfile_path(graph_layer);
+	} else {
+		repo_hold_lock_file_for_update_mode(r, &lk, graph_name,
+						    LOCK_DIE_ON_ERROR, 0444);
+		out_fd = get_lock_file_fd(&lk);
+		out_path = get_lock_file_path(&lk);
+	}
+
+	ret = commit_graph_write_layer(r, opts, mergeable_layers, chainable_layers,
+				       out_fd, out_path, &base, hash);
+	if (ret <= 0)
+		goto out;
+
 	/*
 	 * Snapshot everything we need from the current chain before closing
 	 * it, as we must not have any layers mapped when replacing them.
 	 */
-	if (ctx->opts->flags & COMMIT_GRAPH_WRITE_SPLIT) {
-		const char *new_hash = hash_to_hex_algop(file_hash, ctx->r->hash_algo);
+	if (opts->flags & COMMIT_GRAPH_WRITE_SPLIT) {
+		const char *new_hash = hash_to_hex_algop(hash, r->hash_algo);
 
-		new_path = get_split_graph_filename(ctx->dir, new_hash);
+		new_path = get_split_graph_filename(abs_dir, new_hash);
 
 		string_list_append(&chain_hashes, new_hash);
 		for (chain = base; chain; chain = chain->base_graph)
@@ -2251,12 +2297,12 @@ static int write_commit_graph_file(struct write_commit_graph_context *ctx)
 		}
 		string_list_append(&kept, new_path);
 
-		mark_commit_graphs(ctx->r->objects->commit_graph, base);
+		mark_commit_graphs(g, base);
 	}
 
-	commit_graph_close(ctx->r->objects);
+	commit_graph_close(r->objects);
 
-	if (ctx->opts->flags & COMMIT_GRAPH_WRITE_SPLIT) {
+	if (opts->flags & COMMIT_GRAPH_WRITE_SPLIT) {
 		FILE *chainf = fdopen_lock_file(&lk, "w");
 
 		if (!chainf) {
@@ -2270,7 +2316,7 @@ static int write_commit_graph_file(struct write_commit_graph_context *ctx)
 				goto out;
 			}
 		} else if (!base) {
-			char *graph_name = get_commit_graph_filename(ctx->dir);
+			char *graph_name = get_commit_graph_filename(abs_dir);
 			unlink(graph_name);
 			free(graph_name);
 		}
@@ -2290,14 +2336,14 @@ static int write_commit_graph_file(struct write_commit_graph_context *ctx)
 
 	commit_lock_file(&lk);
 
-	if (!(ctx->opts->flags & COMMIT_GRAPH_WRITE_SPLIT)) {
-		char *chain_name = get_commit_graph_chain_filename(ctx->dir);
+	if (!(opts->flags & COMMIT_GRAPH_WRITE_SPLIT)) {
+		char *chain_name = get_commit_graph_chain_filename(abs_dir);
 		unlink(chain_name);
 		free(chain_name);
 	}
 
-	expire_commit_graphs(ctx->dir, &kept,
-			     ctx->opts->expire_time ? ctx->opts->expire_time : time(NULL));
+	expire_commit_graphs(abs_dir, &kept,
+			     opts->expire_time ? opts->expire_time : time(NULL));
 
 	ret = 0;
 
@@ -2308,7 +2354,9 @@ static int write_commit_graph_file(struct write_commit_graph_context *ctx)
 	string_list_clear(&kept, 0);
 	free(base_rename_from);
 	free(base_rename_to);
+	free(graph_name);
 	free(new_path);
+	free(abs_dir);
 	return ret;
 }
 
@@ -2562,13 +2610,19 @@ bool commit_graph_write_allowed(struct repository *r)
 	return true;
 }
 
-int commit_graph_write(struct repository *r,
-		       const char *dir,
-		       const struct commit_graph_write_options *opts)
+int commit_graph_write_layer(struct repository *r,
+			     const struct commit_graph_write_options *opts,
+			     size_t mergeable_layers,
+			     size_t chainable_layers,
+			     int fd, const char *path,
+			     struct commit_graph **base,
+			     unsigned char *hash)
 {
 	struct write_commit_graph_context ctx = {
 		.r = r,
 		.opts = opts,
+		.mergeable_layers = mergeable_layers,
+		.chainable_layers = chainable_layers,
 		.total_bloom_filter_data_size = 0,
 		.write_generation_data = (get_configured_generation_version(r) == 2),
 		.num_generation_data_overflows = 0,
@@ -2580,16 +2634,17 @@ int commit_graph_write(struct repository *r,
 	struct oidset reachable_commits = OIDSET_INIT;
 	struct topo_level_slab topo_levels;
 	struct commit_graph *g;
-	bool mergeable = true;
 
 	if (!!opts->pack_indexes + !!opts->commits + !!(opts->flags & COMMIT_GRAPH_WRITE_REACHABLE) > 1)
 		BUG("attempting to write commit-graph with mutually incompatible options");
+	if (chainable_layers < mergeable_layers)
+		BUG("attempting to write commit-graph with more mergeable than chainable layers");
+
+	*base = NULL;
 
 	if (!commit_graph_write_allowed(r))
 		return 0;
 
-	ctx.dir = absolute_pathdup(dir);
-
 	bloom_settings.hash_version = r->settings.commit_graph_changed_paths_version;
 	bloom_settings.bits_per_entry = git_env_ulong("GIT_TEST_BLOOM_SETTINGS_BITS_PER_ENTRY",
 						      bloom_settings.bits_per_entry);
@@ -2606,33 +2661,6 @@ int commit_graph_write(struct repository *r,
 	for (struct commit_graph *chain = g; chain; chain = chain->base_graph)
 		chain->topo_levels = &topo_levels;
 
-	/*
-	 * We only consider merging layers that belong to our own object
-	 * directory. Furthermore, we can only chain on top of either:
-	 *
-	 *   - A split commit graph layer, regardless of whether or not it is
-	 *     local.
-	 *
-	 *   - A local non-split commit graph, in which case we'll convert that
-	 *     layer into a split commit graph layer.
-	 */
-	for (struct commit_graph *layer = g; layer; layer = layer->base_graph) {
-		char *path = get_commit_graph_filename(layer->dir);
-		bool is_split = !!strcmp(layer->filename, path);
-		bool is_local = !strcmp(layer->dir, ctx.dir);
-
-		free(path);
-
-		if (!is_local && !is_split)
-			break;
-		if (!is_local)
-			mergeable = false;
-
-		if (mergeable)
-			ctx.mergeable_layers++;
-		ctx.chainable_layers++;
-	}
-
 	if (opts->flags & COMMIT_GRAPH_WRITE_BLOOM_FILTERS)
 		ctx.changed_paths = 1;
 	if (!(opts->flags & COMMIT_GRAPH_NO_WRITE_BLOOM_FILTERS)) {
@@ -2717,21 +2745,24 @@ int commit_graph_write(struct repository *r,
 	if (ctx.changed_paths)
 		compute_bloom_filters(&ctx);
 
-	res = write_commit_graph_file(&ctx);
+	res = write_commit_graph_file(&ctx, fd, path, hash);
 
 	if (ctx.changed_paths)
 		deinit_bloom_filters();
 
+	if (!res) {
+		*base = ctx.new_base_graph;
+		res = 1;
+	}
+
 cleanup:
-	free(ctx.graph_name);
-	free(ctx.dir);
 	commit_stack_clear(&ctx.commits);
 	oidset_clear(&reachable_commits);
 	oid_array_clear(&ctx.oids);
 	clear_topo_level_slab(&topo_levels);
 
-	if (ctx.r->objects->commit_graph) {
-		struct commit_graph *g = ctx.r->objects->commit_graph;
+	if (r->objects->commit_graph) {
+		struct commit_graph *g = r->objects->commit_graph;
 
 		while (g) {
 			g->topo_levels = NULL;
diff --git a/commit-graph.h b/commit-graph.h
index e2fc0c8da4c..1cc0d097321 100644
--- a/commit-graph.h
+++ b/commit-graph.h
@@ -201,6 +201,33 @@ struct commit_graph_write_options {
 /* Check whether the repository's configuration allows writing commit graphs. */
 bool commit_graph_write_allowed(struct repository *r);
 
+/*
+ * Write a single commit-graph layer to the given file descriptor. When writing
+ * a split commit graph then the repository's loaded commit graph will be used
+ * as the base. This can be tweaked:
+ *
+ *   - `mergeable_layers` controls how many of the topmost layers may be merged
+ *     together.
+ *
+ *   - `chainable_layers` controls how many of the topmost layers may be used
+ *     as base. In case the picked base is not chainable, then it and all of
+ *     its bases are merged.
+ *
+ * On success, `*base` is set to the layer of the currently-loaded chain that
+ * the new layer builds upon, or NULL if the new layer is standalone. `hash`
+ * receives the trailing checksum of the new layer.
+ *
+ * Returns 1 in case a new layer has been written, 0 in case there was nothing
+ * to write, a negative error code otherwise.
+ */
+int commit_graph_write_layer(struct repository *r,
+			     const struct commit_graph_write_options *opts,
+			     size_t mergeable_layers,
+			     size_t chainable_layers,
+			     int fd, const char *path,
+			     struct commit_graph **base,
+			     unsigned char *hash);
+
 /*
  * The commit_graph_write* methods return zero on success
  * and a negative value on failure. Note that if the repository

-- 
2.56.1.763.g16177fe143.dirty

