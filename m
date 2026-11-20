Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=103.168.172.149
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795177406;
	b=g4fCWolZs7sQjaty2QAkqyCyFv9NtJeL60hdLkvJCwXPXbLZ4JHW2Sh3XD+40L81FPtJ
	 7sZ8qOE4V4K1Pvf1xztp3Zsu6Vtihee2jyIL+1C7bkTz/+xrxskqOKzZGFrfkL07zfJrO
	 Q5hJ/46wJNdEeyK/cAdgB4HtfPYSEcLgsRcGzxrusu2G9cIcltkRv4X9U+vA0DcA/k8bX
	 z2l/va1v2IoBpDG28dlax1fkLGYEPQ4yZ8NtdH4uyNmbv3i4Lo0ULB3qf8Gxcz94tpfSd
	 cOsxxrA4vRqD7EEKV4GQIbx6wHciG77M/MmTFLT2UzpbAms5/9bYk9iQYp6rsFfeoYA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795177406;
	h=DMARC-Filter:Received:Received:DKIM-Signature:DKIM-Signature:
	 X-DKIM2-Info:DKIM2-Signature:X-DKIM2-Info:Message-Instance:
	 X-ME-Sender:X-ME-Received:X-ME-Proxy-Cause:X-ME-Proxy:Feedback-ID:
	 Received:Received:From:Date:Subject:MIME-Version:Content-Type:
	 Content-Transfer-Encoding:Message-Id:References:In-Reply-To:To:Cc:
	 X-Mailer;
	bh=BIg4cu4GNmjk839gjkpRGA2cggfN3i/I8PIZQqgH0hg=;
	b=wEPfjBhK1sVyrp5d9nbKLGMpGCtsnxV+BhCNMDQUmHaaAOR2GbeA1KA8YmjTpCb2i6yq
	 DXw+m2nYYqHPfhcFKxo3bDp98Fa7v+1uPE/aGS0q2S4AN4OrZ1SFqkOPGlE5WtrKL3+Hn
	 g1qNE4oWX+jBZtx+PzCQB+GvwP6aYuaxtllSWacr7Ry5ln1yOyrLn8UsoqgQZ0v/mixgM
	 OAnIdY7fvHx0792JMwIpPRZUZCxwE7n3OMDyD3mFiHgYcSeCq1Hqls2Wr20lJA4nAqep1
	 EVCnnkoM4ofe/ot846qcZnHLc/PBUIaQYoQCinvSVoo7X1XDBlCcRxoDbvOevXcUxaw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=pks.im;
	spf=pass smtp.mailfrom=pks.im;
	dkim=pass header.d=pks.im header.i=@pks.im header.a=rsa-sha256 header.s=fm3 header.b=YyHdTtFK;
	dkim=pass header.d=messagingengine.com header.i=@messagingengine.com header.a=rsa-sha256 header.s=fm3 header.b=bHmeu7EM;
	arc=none smtp.remote-ip=103.168.172.149
Received: from fout-a6-smtp.messagingengine.com (fout-a6-smtp.messagingengine.com [103.168.172.149])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2FFCC606A320
	for <git@vger.kernel.org>; Fri, 20 Nov 2026 12:23:26 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 2FFCC606A320
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=pks.im header.i=@pks.im header.a=rsa-sha256 header.s=fm3 header.b=YyHdTtFK;
	dkim=pass (2048-bit key, unprotected) header.d=messagingengine.com header.i=@messagingengine.com header.a=rsa-sha256 header.s=fm3 header.b=bHmeu7EM
Received: from phl-compute-05.internal (phl-compute-05.internal [10.202.2.45])
	by mailfout.phl.internal (Postfix) with ESMTP id 41CABEC00C6
	for <git@vger.kernel.org>; Fri, 20 Nov 2026 07:23:25 -0500 (EST)
Received: from phl-frontend-03 ([10.202.2.162])
  by phl-compute-05.internal (MEProxy); Fri, 20 Nov 2026 07:23:25 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm3; t=1795177405;
	 x=1795263805; bh=BIg4cu4GNmjk839gjkpRGA2cggfN3i/I8PIZQqgH0hg=; b=
	YyHdTtFKTKCHHQQhghAYL1EqWqWSQq5GLy54VN4u32/EiqoxaJrAPuUEGo4EyMRj
	r2xQookYaQCeYU4zfbTUcusynYW1Q/je2bhfiLV4OynC5ue2I2CvHn6VG2gMWRPj
	7vSZm/YFNpPfU9X3Pms9z3JH95pYzWlNRcXj5pfdSZmOQxDt/Bkzaq5+4Xbq/rfF
	41z0zykGo59rQHO1HhZKKbUdUpvxNnu3a8d1r/jBw8KZzxBFk/cckdhMQK4sKud7
	BM3lB3a4uKovQIBZFCXFXqCzww1QzgMR6iPVAxvoZoBTmBu1jafEzFahYk7i0Trk
	qGnP89PgxpaVDcUqsXPcUg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1795177405; x=
	1795263805; bh=BIg4cu4GNmjk839gjkpRGA2cggfN3i/I8PIZQqgH0hg=; b=b
	Hmeu7EM5/9QfoDUo82kvTo3lSkSEZW5m0jxhZI0tAw/z5yAfMNoCtDWPoGEvFGxf
	G8iHLdp9vHpqAmCIC3i8k8m7z7xhgFITJns5pXxTYQusN4BFNjraM0kdJcaRCZme
	XogsxVEceWApMIEglt3oL2BMNce7kiVThe2inuEo7+SKMSry2acvmmXFmojRUPqt
	KhfRkLtUryVFgsRar+3BufdO/wVZRvvlPIzcvhjgk/K9xhdC0TxeoZ6UHTkgsdX9
	du8uPAk0053MRhiVv+1OdaVmVv0NuHtL0SQ+O+SAoVKaubwlWU2SgElbD34M8b30
	rwx3JmSLW+kh5xFfnavVQ==
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-09;
	repo=github.com/dkim2wg/interop; date=2026-11-03; sw=lmtpprox;
	action=sign d=pks.im a=rsa-sha256;
DKIM2-Signature: i=1; m=1; t=1795177405; d=pks.im; mf=PHBzQHBrcy5pbT4=;
	rt=PGdpdEB2Z2VyLmtlcm5lbC5vcmc+;
	s=fm3:rsa-sha256:HLHNcGr+hrQKfkxfJRn2uMKbR1e6TC+5L3HHxr+6ANLcZDQ
	w6CdcXn9ybbmbnl8s8WDgVH8irV3+ITUvdHQPyT3Dze1HALtLeGQ6MVyG79cPDVr
	Ma/a/weqnkp0czSoTTcw+nnA37EOkHlnvHxmcD1aDVoUubUS4e6cXlfKm8y6Su1S
	3qFhXo8CDX9MSz9DHGM8XeE97Ha9llspEJ9mIXBh8hC+Si5IDoD2FXHHWpiCOL9T
	FkKHof8tEoYqB0MIkzUbiqv4UuyBwsuTZ/KLqY1joK6wsbUv3HS0q6hdXTNTPQX+
	lHT3hHwOLdT+NanqlbVFTOCBTeX6DkhRQe/UFBw==;
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-09;
	repo=github.com/dkim2wg/interop; date=2026-11-03; sw=lmtpprox;
	action=mi-m=1; hc=12;
	hn=cc,content-transfer-encoding,content-type,date,feedback-id,
	from,in-reply-to,message-id,mime-version,references,subject,to;
Message-Instance: m=1; h=sha256:a7jT7HyiGQ7Lxr+JB3ngktrkHN4wSE3skNxrdnmGDBg=:Ib1VsaJDT4Phn8fM7moKkV/+9AxyVvz5UvkNH/X5q7c=;
X-ME-Sender: <xms:vTsAa2HwBRzx4a7TGWXzSEqpj5LlGCVAxEXcrCaQyxhzMMl4H1BsqA>
    <xme:vTsAa9UeftRjJXYXyyxf9cqfmC-KAdpMbMNj2bb8XbUywZ6NqmCAnuyj-mJUgwZlT
    ICEk_Lb_61GdLvij8X1Mk3eejtkjU2PvDumq1hrSC4Vzli62FsgJKM>
X-ME-Received: <xmr:vTsAa9x0CyAlLncRsobqMTbFWIcXTq3Ky6w4D6hDkRhIK_DJHspsSLr0nPW_QjFZasLJedM>
X-ME-Proxy-Cause: dmFkZTE30M4DhJ6BlHACvgSE3qTozkDJYeVV5N8aECYztHKd+6E8X7EyVKhmUcqZHARQ9G
    ej74kFF9SXDEsQnJvo5KV9xr56t6d7cAr5SC+cvGFgXtwIVM9RNry7YbsVmEwl8iGhUGYE
    i94KEexOvxUB3Xpfp+LqNlCW8iaxnYw1nOhKDw6IvPJZNp69jwBY818qCib3BngrmnpnJ5
    7GRESSQDlu2eh2zQMkObV8nXZWnGxLSicwIhnsgfCcv0yqz5g4qu0XlVibB6OGdKMoRGc/
    hDCA+IMYG5jWIBgOpjbR8IU1dmxYNUIQnl75V1QWBKAUdVL/kuH07PjlVt3ejjqggP1kPY
    TvGvxRNUqMiFOEyIsGQ0Jev8aVPgUr71aaxBvU+K1Cq1y57Ny+7+28UxY6CN6uFaBvl7Sw
    04yhDGWSBZSy79vqR48mMmxL6tDy/4XGNLYJnmuIkQDDWTeRQicKMSyW04/9dz1L7P2NCv
    xE2vz6UwEz0maPaAQSQN0xyPbBGl+GhL65pFUbc99FS3AM0GRQm/BiEUg+Lb7hga61wA2i
    ZaC8fLuH6BSS/mb3cIC8B6XltXlV3LAZAlmu+Gy5HBdGx+k1pjrqIiNwHjcKBpHlKhSk0O
    shIt7NPkZoyscxQNhmhzNpEy/68ShyS6syXUZPx/NsccQztvtPaGabrZ30Dw
X-ME-Proxy: <xmx:vTsAa7OyiJp6k_gmNgo7Tg1NrqDBBqatqPAD1-_nTzePbYGWI88r3Q>
    <xmx:vTsAa-5li33-LOy1ySpnL61DxEUNsAKd70NBTrA0YFHd_DznZEhLVA>
    <xmx:vTsAa8Ml7qrsAUiZc5YtWqx1acR8tUjc_haTWfxDdTUzst5n-8dvbA>
    <xmx:vTsAa8n4q4KXiKvnmgp602jrJctbEjlQtYQAo40cZNIomxL5JuXg6Q>
    <xmx:vTsAaxfD508KoMHqHIYvMB6mvnFCPJThCAbUZmZ5kybwd2PHFYvnjcaK>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 20 Nov 2026 07:23:24 -0500 (EST)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id 619d307f (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Fri, 20 Nov 2026 12:23:24 +0000 (UTC)
From: Patrick Steinhardt <ps@pks.im>
Date: Fri, 20 Nov 2026 13:22:55 +0100
Subject: [PATCH v2 7/7] commit-graph: derive layer infos from the passed-in
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
Message-Id: <20261120-pks-odb-pluggable-commit-graphs-v2-7-31f2341a9932@pks.im>
References: <20261120-pks-odb-pluggable-commit-graphs-v2-0-31f2341a9932@pks.im>
In-Reply-To: <20261120-pks-odb-pluggable-commit-graphs-v2-0-31f2341a9932@pks.im>
To: git@vger.kernel.org
Cc: Junio C Hamano <gitster@pobox.com>
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
index 59adf4cae4a..2b7d7919c2c 100644
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
@@ -1156,14 +1157,10 @@ struct write_commit_graph_context {
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
 
@@ -2095,14 +2092,24 @@ static int write_graph_chunk_base(struct hashfile *f,
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
@@ -2212,78 +2219,102 @@ static int write_commit_graph_file(struct write_commit_graph_context *ctx)
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
 
@@ -2296,7 +2327,6 @@ static void split_graph_merge_strategy(struct write_commit_graph_context *ctx,
 	int max_commits = ctx->opts->max_commits;
 	int size_mult = 2;
 	size_t depth = 0;
-	uint32_t i;
 
 	if (ctx->opts->size_multiple)
 		size_mult = ctx->opts->size_multiple;
@@ -2343,30 +2373,12 @@ static void split_graph_merge_strategy(struct write_commit_graph_context *ctx,
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
@@ -2470,48 +2482,37 @@ static void merge_commit_graphs(struct write_commit_graph_context *ctx,
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
 
@@ -2522,7 +2523,6 @@ static void expire_commit_graphs(struct write_commit_graph_context *ctx)
 	dirnamelen = path.len;
 	while ((de = readdir(dir)) != NULL) {
 		struct stat st;
-		uint32_t i, found = 0;
 
 		strbuf_setlen(&path, dirnamelen);
 		strbuf_addstr(&path, de->d_name);
@@ -2535,20 +2535,12 @@ static void expire_commit_graphs(struct write_commit_graph_context *ctx)
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
@@ -2658,14 +2650,6 @@ int commit_graph_write(struct repository *r,
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
 
@@ -2733,14 +2717,8 @@ int commit_graph_write(struct repository *r,
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
@@ -2756,17 +2734,6 @@ int commit_graph_write(struct repository *r,
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
2.56.1.831.g720f3f5937.dirty

