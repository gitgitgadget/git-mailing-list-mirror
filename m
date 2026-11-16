Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=103.168.172.146
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794834491;
	b=UF7ZxsauuiLY6MMw+6wBAJpXcaNQDQmT2qq6Gp5e25eeJ2BJzkvu3llDCimt8cjXw9vW
	 n78WRLT+3HKp7DCJ2tE2xixvblFpicZa6u7aRC0H0mCAUdvc40QKfIrYzGzFc7+jMKNaM
	 e0BMeBJcEBR/9jQ0hTiYYDSHZ5Dh1WiKQWRA0el1TQNkd0dO/8CpPhqwbkjbqIZah3+1k
	 BFOTTGUUyZnr9FCkUK4IJz9Yq8ynBj4zuGiu50FKRNHoED3HR3ortER+ymz7sQ81xqSTN
	 WGaTROcxUNR+rwXZMiia754msoeHLk/GKPn3KisluCVYK67tkUFQ2rafH+TAJ1kWnvw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794834491;
	h=DMARC-Filter:Received:Received:DKIM-Signature:DKIM-Signature:
	 X-DKIM2-Info:DKIM2-Signature:X-DKIM2-Info:Message-Instance:
	 X-ME-Sender:X-ME-Received:X-ME-Proxy-Cause:X-ME-Proxy:Feedback-ID:
	 Received:Received:From:Date:Subject:MIME-Version:Content-Type:
	 Content-Transfer-Encoding:Message-Id:References:In-Reply-To:To:Cc:
	 X-Mailer;
	bh=D3RKG9LO12c43dZp9TiTnPSkKVPUA/XUONhd01meVa0=;
	b=YgIZ1TmchbFYA/5RYSm4MRLzAy2HP9U5CKtW9TLBWoKjOhKJXxpFaHYWz1gXzHj9qOms
	 jUSjiy+XWI5NZzVgy6Isk7CjMTbg9PnAs2oANo30I9ZujccM7Z3y6yWIjlzuRclWauPc5
	 a9m2Hc6wQEmQQDGoAbG6CHq0u5/Qf7Bc6dT9WFZoPtgXXq5gaVdVNf9stkTbkb/oE4eTn
	 AMNU7jscB2TGZU1JBjmDbJ9VMZwdvLd4Af5DnKFKyBpWfb3EjL9S55fIJseK2zBDiTtz6
	 2fDZH2tG6gm7HDJy0LbW4XgOC+SYC+UrpaeqKM5LjdvrXWHePyngzKhjQeHzIJdOlHg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=pks.im;
	spf=pass smtp.mailfrom=pks.im;
	dkim=pass header.d=pks.im header.i=@pks.im header.a=rsa-sha256 header.s=fm3 header.b=XaWLbsE+;
	dkim=pass header.d=messagingengine.com header.i=@messagingengine.com header.a=rsa-sha256 header.s=fm3 header.b=ajCVlvCH;
	arc=none smtp.remote-ip=103.168.172.146
Received: from fout-a3-smtp.messagingengine.com (fout-a3-smtp.messagingengine.com [103.168.172.146])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BFE5C606A334
	for <git@vger.kernel.org>; Mon, 16 Nov 2026 13:08:10 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org BFE5C606A334
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=pks.im header.i=@pks.im header.a=rsa-sha256 header.s=fm3 header.b=XaWLbsE+;
	dkim=pass (2048-bit key, unprotected) header.d=messagingengine.com header.i=@messagingengine.com header.a=rsa-sha256 header.s=fm3 header.b=ajCVlvCH
Received: from phl-compute-01.internal (phl-compute-01.internal [10.202.2.41])
	by mailfout.phl.internal (Postfix) with ESMTP id E20ABEC0108
	for <git@vger.kernel.org>; Mon, 16 Nov 2026 08:08:09 -0500 (EST)
Received: from phl-frontend-03 ([10.202.2.162])
  by phl-compute-01.internal (MEProxy); Mon, 16 Nov 2026 08:08:09 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm3; t=1794834489;
	 x=1794920889; bh=D3RKG9LO12c43dZp9TiTnPSkKVPUA/XUONhd01meVa0=; b=
	XaWLbsE+67WAql15hNBf0RZ+j1CL+qviCnd3aQruufzRDHtYPIHHoysglJgFw8ow
	lbiQqROY7knluPSUggwWM6TILhgvxYSbS+kEBhEs5gXa4p13KgTo9NWCHHDT195p
	tBlzaTXNZhJ+Zl+kLIr22XjGBpfAGH/ncL4spTfkGCqVcyn4Aof5+a6O3f2a33OP
	oVS5Re0WHtzHfpoSrKVB7BHZM6FQUMqzf3jB6KbfvolUvgCQTKA/C9LhWMEV6jwu
	mljmqXY5DNNw9Erggj1V/Nt3KoYe+ZWnamUuUTfSDYfRu4iVPyb3xHfFW9hAYJ7n
	of+ttucH2jVcD3i22IlzrQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1794834489; x=
	1794920889; bh=D3RKG9LO12c43dZp9TiTnPSkKVPUA/XUONhd01meVa0=; b=a
	jCVlvCHtPtMlUHRJTd13HWudL3piec6Qu9C60jGV5cLxItIb6kUCqqAWNomXan3C
	SiPLgE2VMdIzbi7d9F3qpGc8ujUrsuL1oZb4OUFhmU8ACN2RMENLHYUUUr/Q5rlh
	XiM6j0FuIa2oC0pnIYzxFyBZ0AZP6dhdZ4zw93l/NZO3GoZKDbACmynuVuElDvoA
	HnUneEK37rssvLMAIVhhJ0yFFKSzKl5l5tVhTg4HzwmLUIU6aku4lxIpuFxT4mt9
	R98HV4e08+lEKeD9gBKDaBsbDbn+VJ9fbQviXZlhQtrsyLOs+OJ2n18fbA5gaxqi
	nxSBe3FN7f1RQqNFvdXBg==
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-09;
	repo=github.com/dkim2wg/interop; date=2026-11-03; sw=lmtpprox;
	action=sign d=pks.im a=rsa-sha256;
DKIM2-Signature: i=1; m=1; t=1794834489; d=pks.im; mf=PHBzQHBrcy5pbT4=;
	rt=PGdpdEB2Z2VyLmtlcm5lbC5vcmc+;
	s=fm3:rsa-sha256:agtrLo6UTfG4SkCe/9QG9jqgkXnEHcz2Lp46WFcCbNWkBpv
	W8tRYdPxDh5nTEFDDpA0sKAw+mbDwt2IG5vHlHACjvnM/gMi4KfFe6kyi3J8oduo
	Tz11uOrv1g3QbvAbV+wj9y4mjGFh8ThgYLJUqE/afYCtvm/5xkLRHsR0LOD651+4
	KyGKOf1WXOqkOWfgetWtK9c6owuz3DRnmWygdFYOYAbe443husYZ+CevcwXNaX3n
	svwJ5IDkIknmHZzNeKL/FZCyBM8OlVDtVc49zrgYYMnnKmNjLy+RabEXtQYsIBmJ
	cZa7g6tgJUbKWi8MU9e3rqN/SyMYFlgDtjdGaxQ==;
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-09;
	repo=github.com/dkim2wg/interop; date=2026-11-03; sw=lmtpprox;
	action=mi-m=1; hc=12;
	hn=cc,content-transfer-encoding,content-type,date,feedback-id,
	from,in-reply-to,message-id,mime-version,references,subject,to;
Message-Instance: m=1; h=sha256:IdkXimi61tWkx0HXxvqPjNEN+3tE4vzuNhwUiOZ7bGc=:1d53joGnd3s8sZtdikZQxZpcre1tLCows1V7pz45M98=;
X-ME-Sender: <xms:OQD7aujWJC9Hcp5VDgGMMMdGTM0V21nTYaykbHeFL8Etk2S7ykmquQ>
    <xme:OQD7al8FRCB1cUz_kFfW6nnNDbhEQhuKYY-1YESxcOWKFVmqWNBGdoIwIaOZkZ25c
    bEtJylnprIrQWxJeqgJgExTQkdjup8RHOY4rT5iHYNEctINfFR7lVo>
X-ME-Received: <xmr:OQD7arsOgKu-khHRONLmQTHQvVmV7oJ2nuhqjfOIKcogLz0xCIN9-OHumT-heH7dPMFPk3Y>
X-ME-Proxy-Cause: dmFkZTGUadbCh8PYVzO+W98xO36esdaT9Eix5aVF7MyFuNyzrqEzalcNM9Mjew9UpwZvRj
    x3nTyTLMef4ef7P6EpH7QXWf/LZHZKuTx0r7fxS9GfAU74pOZ7Yh4nSofSUiFZw95M7nY9
    gjNAICkC6pEdvu+SjyFNNhBesAXtfqwDyzh5yr1FUIS3Y1rR8+FVIvi145XZlDJNogJw1V
    v2zHSU2YrL4odH2LqdNvkQSBsQEVYpYQKWTa2S2G7fxZtJF0uLduCFDwENnCD81HRQNXc1
    fb7KtPPll2p/GH5sgSZCt6oMY2lgXrxJrqwSVSbcUnQdR1SDk8ocUvWFnJtPLD1mupA6bs
    dH5BI5StvL73TKVSwqugT1lq+q7o/zRsrEBtknxK7XhqU8Q4gmLEB/EX4UB7Y3RKllLg1w
    PTNoE/CVbXlFzBfgW6VkUMk7yoV3jtgNjC9Gcng4wZMS41PZaWnzC4ogHP9dLobUmUMfyp
    gOmt6a8HfE2oF2DfsLxMrCi24wBaeS6GofdSzuj1xqGonAwUzOGaxpDvsWaDKzLtpCv0q1
    QLMyvPepw2Pby6fNAnKxqIjdgMi7tTXQuOmg+bM2ApR76JL0X7mGiwTMwvkRly7Bp9Koh4
    m+CbLljONFrM/3MA/Hdx4TnuvrthaqK9gIzSM4seN3XZV+hBxMptg3PKPjvQ
X-ME-Proxy: <xmx:OQD7asbImzkKaJi2BQQXqPWnC4_nI2f-HQQ7jMe7Yd-0wPLiKVmWNQ>
    <xmx:OQD7arpVY-kBaMsKSG-EbrnsZW84ttnaedW23036wHZcH5n-aSTUgA>
    <xmx:OQD7ah-Jc7OoEDXMIFoj7Ofd2w-TWO0f2q1LNj1u76p5nM27nWtWXA>
    <xmx:OQD7aq9F9o5Twwej52_stQtBKRka5gEYu8I6ZuqbcLNz1RqKBWkeVQ>
    <xmx:OQD7arjVy3P5na3yS2DhFgfFobZYKQFpMhSd59xCfwpcdPQ0AkHyqWu4>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA for
 <git@vger.kernel.org>; Mon, 16 Nov 2026 08:08:09 -0500 (EST)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id 2ea2a42c (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO)
	for <git@vger.kernel.org>;
	Mon, 16 Nov 2026 13:08:08 +0000 (UTC)
From: Patrick Steinhardt <ps@pks.im>
Date: Mon, 16 Nov 2026 14:07:42 +0100
Subject: [PATCH 06/12] commit-graph: derive layer infos from the passed-in
 chain
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
Message-Id: <20261116-pks-odb-pluggable-commit-graphs-v1-6-a83fc1ff0808@pks.im>
References: <20261116-pks-odb-pluggable-commit-graphs-v1-0-a83fc1ff0808@pks.im>
In-Reply-To: <20261116-pks-odb-pluggable-commit-graphs-v1-0-a83fc1ff0808@pks.im>
To: git@vger.kernel.org
Cc: 
X-Mailer: b4 0.15.2

In addition to writing the new commit-graph layer, we also need to do a
bit of bookkeeping when writing a split commit graph.

  - We track the list of hashes that the new chain is supposed to
    consist of.

  - We track the list of filenames part of the new chain so that we
    don't prune them.

  - We track the list of filenames that will be merged so that we can
    bump their mtime.

  - We track the name of the old non-split commit-graph so that we can
    rename it in case it is being converted into a split commit-graph.

All of this information is passed in by the caller via a couple of
arrays in the write context, but it is in fact redundant: we already
have all information available via the passed-in commit graph.

Refactor the code accordingly. This will make it easier to move this
logic into the "files" backend as we can now cleanly split out the
path-dependent logic from `write_commit_graph_file()`.

While the logic should be mostly equivalent, there's one change in
behaviour: in the preimage, we call `expire_commit_graphs()` regardless
of whether or not writing the new commit graph file succeeds, but now we
only do so on success. This is arguably an improvement though, as
expiring commit graphs even when we haven't written any new ones is
somewhat puzzling.

Signed-off-by: Patrick Steinhardt <ps@pks.im>
---
 commit-graph.c | 227 ++++++++++++++++++++++++---------------------------------
 1 file changed, 97 insertions(+), 130 deletions(-)

diff --git a/commit-graph.c b/commit-graph.c
index c146f20f68f..caf40fd6b01 100644
--- a/commit-graph.c
+++ b/commit-graph.c
@@ -25,6 +25,7 @@
 #include "bloom.h"
 #include "commit-slab.h"
 #include "shallow.h"
+#include "string-list.h"
 #include "json-writer.h"
 #include "trace2.h"
 #include "tree.h"
@@ -1150,14 +1151,10 @@ struct write_commit_graph_context {
 	int progress_done;
 	uint64_t progress_cnt;
 
-	char *base_graph_name;
 	size_t mergeable_layers;
 	size_t chainable_layers;
 	int num_commit_graphs_before;
 	int num_commit_graphs_after;
-	char **commit_graph_filenames_before;
-	char **commit_graph_filenames_after;
-	char **commit_graph_hash_after;
 	uint32_t new_num_commits_in_base;
 	struct commit_graph *new_base_graph;
 
@@ -2089,14 +2086,24 @@ static int write_graph_chunk_base(struct hashfile *f,
 	return 0;
 }
 
+static void mark_commit_graphs(struct commit_graph *tip,
+			       struct commit_graph *base);
+static void expire_commit_graphs(const char *dirpath,
+				 struct string_list *kept,
+				 timestamp_t expire_time);
+
 static int write_commit_graph_file(struct write_commit_graph_context *ctx)
 {
-	uint32_t i;
 	struct hashfile *f;
-	struct tempfile *graph_layer; /* when COMMIT_GRAPH_WRITE_SPLIT is non-zero */
+	struct tempfile *graph_layer = NULL; /* when COMMIT_GRAPH_WRITE_SPLIT is non-zero */
 	struct lock_file lk = LOCK_INIT;
 	const unsigned hashsz = ctx->r->hash_algo->rawsz;
 	struct strbuf progress_title = STRBUF_INIT;
+	struct string_list chain_hashes = STRING_LIST_INIT_DUP;
+	struct string_list kept = STRING_LIST_INIT_DUP;
+	struct commit_graph *base = ctx->new_base_graph, *chain;
+	char *base_rename_from = NULL, *base_rename_to = NULL;
+	char *new_path = NULL;
 	struct chunkfile *cf;
 	unsigned char file_hash[GIT_MAX_RAWSZ];
 	int ret;
@@ -2206,78 +2213,102 @@ static int write_commit_graph_file(struct write_commit_graph_context *ctx)
 	stop_progress(&ctx->progress);
 	strbuf_release(&progress_title);
 
-	if ((ctx->opts->flags & COMMIT_GRAPH_WRITE_SPLIT) &&
-	    ctx->base_graph_name && ctx->num_commit_graphs_after > 1) {
-		char *new_base_hash = xstrdup(oid_to_hex(&ctx->new_base_graph->oid));
-		char *new_base_name = get_split_graph_filename(ctx->new_base_graph->dir, new_base_hash);
+	finalize_hashfile(f, file_hash, FSYNC_COMPONENT_COMMIT_GRAPH,
+			  CSUM_HASH_IN_STREAM | CSUM_FSYNC);
+	free_chunkfile(cf);
+
+	/*
+	 * Snapshot everything we need from the current chain before closing
+	 * it, as we must not have any layers mapped when replacing them.
+	 */
+	if (ctx->opts->flags & COMMIT_GRAPH_WRITE_SPLIT) {
+		const char *new_hash = hash_to_hex_algop(file_hash, ctx->r->hash_algo);
+
+		new_path = get_split_graph_filename(ctx->dir, new_hash);
+
+		string_list_append(&chain_hashes, new_hash);
+		for (chain = base; chain; chain = chain->base_graph)
+			string_list_append(&chain_hashes, oid_to_hex(&chain->oid));
 
-		free(ctx->commit_graph_filenames_after[ctx->num_commit_graphs_after - 2]);
-		free(ctx->commit_graph_hash_after[ctx->num_commit_graphs_after - 2]);
-		ctx->commit_graph_filenames_after[ctx->num_commit_graphs_after - 2] = new_base_name;
-		ctx->commit_graph_hash_after[ctx->num_commit_graphs_after - 2] = new_base_hash;
+		/*
+		 * In case we have a non-split commit graph we need to convert
+		 * it into the base layer of the new split commit graph by
+		 * renaming it.
+		 */
+		if (base) {
+			base_rename_to = get_split_graph_filename(base->dir, oid_to_hex(&base->oid));
+			if (strcmp(base->filename, base_rename_to))
+				base_rename_from = xstrdup(base->filename);
+			else
+				FREE_AND_NULL(base_rename_to);
+		}
+
+		for (chain = base; chain; chain = chain->base_graph) {
+			if (chain == base && base_rename_to)
+				string_list_append(&kept, base_rename_to);
+			else
+				string_list_append(&kept, chain->filename);
+		}
+		string_list_append(&kept, new_path);
+
+		mark_commit_graphs(ctx->r->objects->commit_graph, base);
 	}
 
 	commit_graph_close(ctx->r->objects);
-	finalize_hashfile(f, file_hash, FSYNC_COMPONENT_COMMIT_GRAPH,
-			  CSUM_HASH_IN_STREAM | CSUM_FSYNC);
-	free_chunkfile(cf);
 
 	if (ctx->opts->flags & COMMIT_GRAPH_WRITE_SPLIT) {
 		FILE *chainf = fdopen_lock_file(&lk, "w");
-		char *final_graph_name;
-		int result;
 
 		if (!chainf) {
 			ret = error(_("unable to open commit-graph chain file"));
 			goto out;
 		}
 
-		if (ctx->base_graph_name) {
-			const char *dest;
-			int idx = ctx->num_commit_graphs_after - 1;
-			if (ctx->num_commit_graphs_after > 1)
-				idx--;
-
-			dest = ctx->commit_graph_filenames_after[idx];
-
-			if (strcmp(ctx->base_graph_name, dest)) {
-				result = rename(ctx->base_graph_name, dest);
-
-				if (result) {
-					ret = error(_("failed to rename base commit-graph file"));
-					goto out;
-				}
+		if (base_rename_from) {
+			if (rename(base_rename_from, base_rename_to)) {
+				ret = error(_("failed to rename base commit-graph file"));
+				goto out;
 			}
-		} else {
+		} else if (!base) {
 			char *graph_name = get_commit_graph_filename(ctx->dir);
 			unlink(graph_name);
 			free(graph_name);
 		}
 
-		free(ctx->commit_graph_hash_after[ctx->num_commit_graphs_after - 1]);
-		ctx->commit_graph_hash_after[ctx->num_commit_graphs_after - 1] =
-			xstrdup(hash_to_hex_algop(file_hash, ctx->r->hash_algo));
-		final_graph_name = get_split_graph_filename(ctx->dir,
-					ctx->commit_graph_hash_after[ctx->num_commit_graphs_after - 1]);
-		free(ctx->commit_graph_filenames_after[ctx->num_commit_graphs_after - 1]);
-		ctx->commit_graph_filenames_after[ctx->num_commit_graphs_after - 1] = final_graph_name;
-
-		result = rename_tempfile(&graph_layer, final_graph_name);
-
-		for (i = 0; i < ctx->num_commit_graphs_after; i++)
-			fprintf(get_lock_file_fp(&lk), "%s\n", ctx->commit_graph_hash_after[i]);
-
-		if (result) {
+		if (rename_tempfile(&graph_layer, new_path)) {
 			ret = error(_("failed to rename temporary commit-graph file"));
 			goto out;
 		}
+
+		/*
+		 * Chain hashes are ordered newest-first, but the chain file is
+		 * oldest-first so we iterate in reverse.
+		 */
+		for (size_t i = chain_hashes.nr; i; i--)
+			fprintf(chainf, "%s\n", chain_hashes.items[i - 1].string);
 	}
 
 	commit_lock_file(&lk);
+
+	if (!(ctx->opts->flags & COMMIT_GRAPH_WRITE_SPLIT)) {
+		char *chain_name = get_commit_graph_chain_filename(ctx->dir);
+		unlink(chain_name);
+		free(chain_name);
+	}
+
+	expire_commit_graphs(ctx->dir, &kept,
+			     ctx->opts->expire_time ? ctx->opts->expire_time : time(NULL));
+
 	ret = 0;
 
 out:
 	rollback_lock_file(&lk);
+	delete_tempfile(&graph_layer);
+	string_list_clear(&chain_hashes, 0);
+	string_list_clear(&kept, 0);
+	free(base_rename_from);
+	free(base_rename_to);
+	free(new_path);
 	return ret;
 }
 
@@ -2290,7 +2321,6 @@ static void split_graph_merge_strategy(struct write_commit_graph_context *ctx,
 	int max_commits = ctx->opts->max_commits;
 	int size_mult = 2;
 	size_t depth = 0;
-	uint32_t i;
 
 	if (ctx->opts->size_multiple)
 		size_mult = ctx->opts->size_multiple;
@@ -2337,30 +2367,12 @@ static void split_graph_merge_strategy(struct write_commit_graph_context *ctx,
 		ctx->new_base_graph = NULL;
 	}
 
-	CALLOC_ARRAY(ctx->commit_graph_filenames_after, ctx->num_commit_graphs_after);
-	CALLOC_ARRAY(ctx->commit_graph_hash_after, ctx->num_commit_graphs_after);
-
-	for (i = 0; i < ctx->num_commit_graphs_after &&
-		    i < ctx->num_commit_graphs_before; i++)
-		ctx->commit_graph_filenames_after[i] = xstrdup(ctx->commit_graph_filenames_before[i]);
-
-	i = ctx->num_commit_graphs_before - 1;
-	g = graph_to_merge;
-
-	while (g) {
-		if (i < ctx->num_commit_graphs_after)
-			ctx->commit_graph_hash_after[i] = xstrdup(oid_to_hex(&g->oid));
-
-		/*
-		 * If the topmost remaining layer has generation data chunk, the
-		 * resultant layer also has generation data chunk.
-		 */
-		if (i == ctx->num_commit_graphs_after - 2)
-			ctx->write_generation_data = !!g->chunk_generation_data;
-
-		i--;
-		g = g->base_graph;
-	}
+	/*
+	 * If the topmost remaining layer has generation data chunk, the
+	 * resultant layer also has generation data chunk.
+	 */
+	if (ctx->new_base_graph)
+		ctx->write_generation_data = !!ctx->new_base_graph->chunk_generation_data;
 }
 
 static void merge_commit_graph(struct write_commit_graph_context *ctx,
@@ -2464,48 +2476,37 @@ static void merge_commit_graphs(struct write_commit_graph_context *ctx,
 		ctx->new_num_commits_in_base = g->num_commits + g->num_commits_in_base;
 	}
 
-	if (ctx->new_base_graph)
-		ctx->base_graph_name = xstrdup(ctx->new_base_graph->filename);
-
 	sort_and_scan_merged_commits(ctx);
 }
 
-static void mark_commit_graphs(struct write_commit_graph_context *ctx)
+static void mark_commit_graphs(struct commit_graph *tip,
+			       struct commit_graph *base)
 {
-	uint32_t i;
 	time_t now = time(NULL);
 
-	for (i = ctx->num_commit_graphs_after - 1; i < ctx->num_commit_graphs_before; i++) {
+	for (struct commit_graph *g = tip; g && g != base; g = g->base_graph) {
 		struct stat st;
 		struct utimbuf updated_time;
 
-		if (stat(ctx->commit_graph_filenames_before[i], &st) < 0)
+		if (stat(g->filename, &st) < 0)
 			continue;
 
 		updated_time.actime = st.st_atime;
 		updated_time.modtime = now;
-		utime(ctx->commit_graph_filenames_before[i], &updated_time);
+		utime(g->filename, &updated_time);
 	}
 }
 
-static void expire_commit_graphs(struct write_commit_graph_context *ctx)
+static void expire_commit_graphs(const char *dirpath,
+				 struct string_list *kept,
+				 timestamp_t expire_time)
 {
 	struct strbuf path = STRBUF_INIT;
 	DIR *dir;
 	struct dirent *de;
 	size_t dirnamelen;
-	timestamp_t expire_time = time(NULL);
-
-	if (ctx->opts->expire_time)
-		expire_time = ctx->opts->expire_time;
-	if (!(ctx->opts->flags & COMMIT_GRAPH_WRITE_SPLIT)) {
-		char *chain_file_name = get_commit_graph_chain_filename(ctx->dir);
-		unlink(chain_file_name);
-		free(chain_file_name);
-		ctx->num_commit_graphs_after = 0;
-	}
 
-	strbuf_addstr(&path, ctx->dir);
+	strbuf_addstr(&path, dirpath);
 	strbuf_addstr(&path, "/info/commit-graphs");
 	dir = opendir(path.buf);
 
@@ -2516,7 +2517,6 @@ static void expire_commit_graphs(struct write_commit_graph_context *ctx)
 	dirnamelen = path.len;
 	while ((de = readdir(dir)) != NULL) {
 		struct stat st;
-		uint32_t i, found = 0;
 
 		strbuf_setlen(&path, dirnamelen);
 		strbuf_addstr(&path, de->d_name);
@@ -2529,20 +2529,12 @@ static void expire_commit_graphs(struct write_commit_graph_context *ctx)
 		if (path.len < 6 || strcmp(path.buf + path.len - 6, ".graph"))
 			continue;
 
-		for (i = 0; i < ctx->num_commit_graphs_after; i++) {
-			if (!strcmp(ctx->commit_graph_filenames_after[i],
-				    path.buf)) {
-				found = 1;
-				break;
-			}
-		}
-
-		if (!found)
+		if (!unsorted_string_list_has_string(kept, path.buf))
 			unlink(path.buf);
 	}
 
 out:
-	if(dir)
+	if (dir)
 		closedir(dir);
 	strbuf_release(&path);
 }
@@ -2652,14 +2644,6 @@ int commit_graph_write(struct repository *r,
 		for (struct commit_graph *chain = g; chain; chain = chain->base_graph)
 			ctx.num_commit_graphs_before++;
 
-		if (ctx.num_commit_graphs_before) {
-			ALLOC_ARRAY(ctx.commit_graph_filenames_before, ctx.num_commit_graphs_before);
-			i = ctx.num_commit_graphs_before;
-
-			for (struct commit_graph *chain = g; chain; chain = chain->base_graph)
-				ctx.commit_graph_filenames_before[--i] = xstrdup(chain->filename);
-		}
-
 		replace = ctx.opts->split_flags & COMMIT_GRAPH_SPLIT_REPLACE;
 	}
 
@@ -2727,14 +2711,8 @@ int commit_graph_write(struct repository *r,
 	if (ctx.changed_paths)
 		deinit_bloom_filters();
 
-	if (ctx.opts->flags & COMMIT_GRAPH_WRITE_SPLIT)
-		mark_commit_graphs(&ctx);
-
-	expire_commit_graphs(&ctx);
-
 cleanup:
 	free(ctx.graph_name);
-	free(ctx.base_graph_name);
 	free(ctx.dir);
 	commit_stack_clear(&ctx.commits);
 	oidset_clear(&reachable_commits);
@@ -2750,17 +2728,6 @@ int commit_graph_write(struct repository *r,
 		}
 	}
 
-	for (i = 0; i < ctx.num_commit_graphs_before; i++)
-		free(ctx.commit_graph_filenames_before[i]);
-	free(ctx.commit_graph_filenames_before);
-
-	for (i = 0; i < ctx.num_commit_graphs_after; i++) {
-		free(ctx.commit_graph_filenames_after[i]);
-		free(ctx.commit_graph_hash_after[i]);
-	}
-	free(ctx.commit_graph_filenames_after);
-	free(ctx.commit_graph_hash_after);
-
 	return res;
 }
 

-- 
2.56.1.763.g16177fe143.dirty

