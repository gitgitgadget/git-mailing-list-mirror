Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=103.168.172.146
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794834486;
	b=PztNfchwOLRCRaquRLyo8Khj396iLAbLHYTgy1LBvnL/sLy0NVE4dQO65WQ2NvQeBNkA
	 6dqSErTqp0aaZNn+bwykBBxlQ13u2A+A9jv74Sg9MB8sVEYG/atTjDAdsDD9nQZZ4O6Q+
	 G/SDqhBjabLVfidZTVJmeLD6p9ZkKwk0A7kXqs02szFgJq+1XzWcu4+MWC1xGUUXHkgQW
	 psbg0ZPoZDhTpgBBtsjnuoLUyOmYN6Gs4f8dNx9qqQ5xd9I9ZBFZGcb7AV9hP+H9ZbQQA
	 /LBKairCbRkRg7Z5YvJplxBpeADzrOk1JzbO3BFW4xttfeFroI+GvNzhhOhULpdUpJQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794834486;
	h=DMARC-Filter:Received:Received:DKIM-Signature:DKIM-Signature:
	 X-DKIM2-Info:DKIM2-Signature:X-DKIM2-Info:Message-Instance:
	 X-ME-Sender:X-ME-Received:X-ME-Proxy-Cause:X-ME-Proxy:Feedback-ID:
	 Received:Received:From:Date:Subject:MIME-Version:Content-Type:
	 Content-Transfer-Encoding:Message-Id:References:In-Reply-To:To:Cc:
	 X-Mailer;
	bh=tPmLQaRvlggzYWklxeoQ8IgHVB8pVtQePUoa747pR+M=;
	b=Y8Iaks7dYNbuiry6Pvf8a7ZbYjq/QGK++b5huYRmbTXUWoHBIFWhjD4QsBuDkiuAO4wh
	 DtUgDbubPA0Z3u60a+H72OLri4DHaXsKpnYeo9LE0hnSyziITkRUASVfAwF29QIshbMI7
	 j6H3ZtsvFtibDJSLiRlOEERg3SFKGhmM2rZFM1OJU8MjfDEWQhuPC6R1rStRG/YkJBltc
	 9Nuy4spustghvA43cVWvpCI3+BRUM3dSa2GdbvJjt3Hv8Xk82r2hT9oP61gIm8RVCSGni
	 ecD0Oni4sSotLGrJ/Man9USPenLMMqZ1AcTLx3zvS1TaaVLvbMK+mrUAXpBDcVNjRaQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=pks.im;
	spf=pass smtp.mailfrom=pks.im;
	dkim=pass header.d=pks.im header.i=@pks.im header.a=rsa-sha256 header.s=fm3 header.b=i4eknsKr;
	dkim=pass header.d=messagingengine.com header.i=@messagingengine.com header.a=rsa-sha256 header.s=fm3 header.b=cj5rBRyX;
	arc=none smtp.remote-ip=103.168.172.146
Received: from fout-a3-smtp.messagingengine.com (fout-a3-smtp.messagingengine.com [103.168.172.146])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5A008606A323
	for <git@vger.kernel.org>; Mon, 16 Nov 2026 13:08:06 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 5A008606A323
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=pks.im header.i=@pks.im header.a=rsa-sha256 header.s=fm3 header.b=i4eknsKr;
	dkim=pass (2048-bit key, unprotected) header.d=messagingengine.com header.i=@messagingengine.com header.a=rsa-sha256 header.s=fm3 header.b=cj5rBRyX
Received: from phl-compute-01.internal (phl-compute-01.internal [10.202.2.41])
	by mailfout.phl.internal (Postfix) with ESMTP id 6BC1BEC0102
	for <git@vger.kernel.org>; Mon, 16 Nov 2026 08:08:05 -0500 (EST)
Received: from phl-frontend-03 ([10.202.2.162])
  by phl-compute-01.internal (MEProxy); Mon, 16 Nov 2026 08:08:05 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm3; t=1794834485;
	 x=1794920885; bh=tPmLQaRvlggzYWklxeoQ8IgHVB8pVtQePUoa747pR+M=; b=
	i4eknsKr+4munjWO5FXNeaLAN4uMlNjG+8yamZ1cyIr8ixUVPTTerVfqBA0G0eCk
	YR50JRzfLgeVwi+KAh1Lp2W1Y+8zVaRdY5g2M2vKtQALxeOklUHNfSPzqNHvJn7N
	LlcVkq43W730qQ3NOrpSUKTJXR9r1rCs/5Shp2IeveG3unYb38S7t+lEGVFFOm3n
	cy+jI/0bED3ystds/p/be2E7LPrSyV7U10Sr6rBJdWO7kuOp4e9yJXv7Hot26CBn
	5yG0pweVoj59LTgyYeh1hSJrKrkKT4O5J64T3+qOpxl2GH7pRf/hcNTUh+w1Mrb9
	CnL9EWuKoVNUegkdHZmeNA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1794834485; x=
	1794920885; bh=tPmLQaRvlggzYWklxeoQ8IgHVB8pVtQePUoa747pR+M=; b=c
	j5rBRyX6RtlCJpIa/n/UB+TJlYxh72LIYCjhg3AdAGbh+bpYlXHqudoVa+TStmaB
	MvpnyCuhY47gP8LmytIKTDCZObIUTSdR8Xag58qGR8aR1GpDwI6+KFAY7fNDeJLN
	3kAdq01DTqs8eHs1mR9qMcWBKLymm4zJ7iF2dYFDvElV/UbQHoO8d4MEPzlAK2VD
	AW7BnmkL5WqBPKZurJVEaH92T1ml1ienTfKouQIgJA+LP3JaxBoVTBjcDtXs1duT
	8RX2Pr+e/Q1wtiiaHgA4nH6pi4OavewplRTBpPxQ9d0lPP5y146GDAkFU04weKWl
	YrGxN0A+HaVjFhmsCSO5Q==
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-09;
	repo=github.com/dkim2wg/interop; date=2026-11-03; sw=lmtpprox;
	action=sign d=pks.im a=rsa-sha256;
DKIM2-Signature: i=1; m=1; t=1794834485; d=pks.im; mf=PHBzQHBrcy5pbT4=;
	rt=PGdpdEB2Z2VyLmtlcm5lbC5vcmc+;
	s=fm3:rsa-sha256:ubN01fENi1AN3lTj0FY4NCIgWDj0VEgL5NH3Q3LwHmtNTqi
	Q1o7UYCWiVEnmQSQ63+uXvccOXx5hfiR3FqVRSPL9uEN49xDk/Xw6Ehap4hB2Nb8
	7LJAcnNEjRr6w3GJ+xNLXWKsFgcv5NbYptOtQgFN+p39tUnJDhx2/qxCps6oGURV
	/DtdKTSf7O0108ve/tqOwNm76HjqCysq7DblLFlAUmynMBEc3YSsi6H7UxWmIrcd
	qoHjOLcocetjw1Adq/eIuxj+uPCDifZNCPIAcZewoC9e5az/yAsyjVPENpoAi+KU
	XvCM8eSapjmSgdPQpC0y39FgMmnqQ08smaDxzug==;
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-09;
	repo=github.com/dkim2wg/interop; date=2026-11-03; sw=lmtpprox;
	action=mi-m=1; hc=12;
	hn=cc,content-transfer-encoding,content-type,date,feedback-id,
	from,in-reply-to,message-id,mime-version,references,subject,to;
Message-Instance: m=1; h=sha256:Qcpqd/2YSIN667om+Ku0LX6pgI78WZDREI/WTOAqk6I=:tLIapzW/g2hy9GvF8WTmxdGww09p7tQHDnN9nrq4yeA=;
X-ME-Sender: <xms:NQD7ajllmhajsJdTAvYLi0SKMBaKsrIBOVw0TrxZvsXoILfysx6vdA>
    <xme:NQD7atxj2ruTPRsA1ImwGWad8UJYWToYg5Blh7RxzqwY72pmar02fVcMZFwg2-lUB
    yTMB1vxYWlb8YdSPe2yXKDlG3YVnsuoUM6GOCPVfPeP_1n1qLxaKa-g>
X-ME-Received: <xmr:NQD7avSXpoSflOw1wWpfPfbLvJkwPRKp56YhNG3E8lKDoNnCfZHWMN3AuMveXyMfsTTl3O0>
X-ME-Proxy-Cause: dmFkZTGziUKUgJYsbiHWfb5HWuWorQnHHq6YP0ByYpkZ6e9sVItzSNrjxVNiJjpykGt6EH
    +Wo+jZCDwFt+/bcnf++syQUvL1OVsCKhGqPwr3BK64IVWifW0xci0pdI+2+/Q2cKlJ86Bw
    MPjq5Gxm3EfNjPHHZxB/qKmy2lYBxm28RGRVDzQY/DL8x0mrFRQC08IpgtrlSdKQSvTTzK
    jI4Dzrh8Ro4PE+97yI0qzoNNhqp2HeoBh5o/zQx/r+4v+GKIjmbaBlrMKGm2iApi+hz2OH
    ZU0TLEDo5HjB+hj+++nQGClhpGKhIpSL+UXhvZrJuTSG26O5MqYj9dLI/adyQM7bNfpGh2
    zrrG27/9lzhNYhEjm0OTmEHxgPbXdljiegYZcBff6dLZJsQdna2UId6n38hU3KWzE14O71
    gK907p2nRxN7jPBxaruAz3JH2xgRMLHyqS+V/CENY8l25ekGDCp/oY0zSFCjJpANExTVpD
    lfaPeYuuPqAWRfLghJTK9NA4EKYvT98Om1TZZvQxSQBT1XjwzKGoelXmdX1RYfjMkeFl1h
    /rQMsbrEeGjjOKDKSUosVgcSc0jjT5FdlKVBDacHCrYBgoLXzrxOy0YgCrvuVnod0t563D
    1Q1lCSLENvPtKmaXi31tPi2XLcuyAdtrfXHda+JUqlhn9/hTn553GPf8jkwg
X-ME-Proxy: <xmx:NQD7agts2TzxDlvnqu5HNUJaE1MR_Wz66nRUFEvcwme6zmAl1veRMg>
    <xmx:NQD7ahvY7QSio2rHOhTbyM0td4yJVwJxmduv7A8K66e_64cnwzR1DA>
    <xmx:NQD7amwy_C3obR4oFtLOHrrWUNL95RfUi3Eq44DDyyJiVLhbTOBs-g>
    <xmx:NQD7aniJPVw87iYDKRFiin1jusfB60eR4AEhrUP5kc9ZPnIFNQ1p8w>
    <xmx:NQD7aj3U_JzpHodnamC3zJrZ99RxqcuGJtWk4A4LIMbxVsslERIivMvr>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA for
 <git@vger.kernel.org>; Mon, 16 Nov 2026 08:08:04 -0500 (EST)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id b772ac56 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO)
	for <git@vger.kernel.org>;
	Mon, 16 Nov 2026 13:08:03 +0000 (UTC)
From: Patrick Steinhardt <ps@pks.im>
Date: Mon, 16 Nov 2026 14:07:40 +0100
Subject: [PATCH 04/12] commit-graph: decide mergeable and chainable layers
 by depth
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
Message-Id: <20261116-pks-odb-pluggable-commit-graphs-v1-4-a83fc1ff0808@pks.im>
References: <20261116-pks-odb-pluggable-commit-graphs-v1-0-a83fc1ff0808@pks.im>
In-Reply-To: <20261116-pks-odb-pluggable-commit-graphs-v1-0-a83fc1ff0808@pks.im>
To: git@vger.kernel.org
Cc: 
X-Mailer: b4 0.15.2

When writing a split commit graph, `split_graph_merge_strategy()`
decides which layers of the existing chain get merged into the new
layer and which layer the new one builds upon. This is decided on two
simple rules:

  - A layer may be merged in case it is part of the same local object
    directory.

  - A layer may be added to the chain in case it is either a split
    commit graph layer, regardless of whether it is local or not. Or in
    case it is local, we may also add it to our chain in case it is a
    non-split commit graph, in which case we convert it to a split one.

These checks require us to know about where exactly these commit graphs
are stored on disk as we compare directories of the respective files
with one another to figure out whether or not a layer is local. So as a
consequence, this policy becomes backend-specific once the backend
controls where exactly commit graphs are stored.

Refactor the code so that we instead tell the merge strategy how many of
the topmost layers are mergeable and chainable, respectively, which will
let the backends decide on that property.

Signed-off-by: Patrick Steinhardt <ps@pks.im>
---
 commit-graph.c | 51 ++++++++++++++++++++++++++++++++++++++++-----------
 1 file changed, 40 insertions(+), 11 deletions(-)

diff --git a/commit-graph.c b/commit-graph.c
index 9464522feb5..7f7146e752a 100644
--- a/commit-graph.c
+++ b/commit-graph.c
@@ -1151,6 +1151,8 @@ struct write_commit_graph_context {
 	uint64_t progress_cnt;
 
 	char *base_graph_name;
+	size_t mergeable_layers;
+	size_t chainable_layers;
 	int num_commit_graphs_before;
 	int num_commit_graphs_after;
 	char **commit_graph_filenames_before;
@@ -2283,6 +2285,7 @@ static void split_graph_merge_strategy(struct write_commit_graph_context *ctx,
 	enum commit_graph_split_flags flags = ctx->opts->split_flags;
 	int max_commits = ctx->opts->max_commits;
 	int size_mult = 2;
+	size_t depth = 0;
 	uint32_t i;
 
 	if (ctx->opts->size_multiple)
@@ -2299,7 +2302,7 @@ static void split_graph_merge_strategy(struct write_commit_graph_context *ctx,
 	    flags != COMMIT_GRAPH_SPLIT_REPLACE) {
 		while (g && (g->num_commits <= st_mult(size_mult, num_commits) ||
 			    (max_commits && num_commits > max_commits))) {
-			if (strcmp(g->dir, ctx->dir))
+			if (depth >= ctx->mergeable_layers)
 				break;
 
 			if (unsigned_add_overflows(num_commits, g->num_commits))
@@ -2309,6 +2312,7 @@ static void split_graph_merge_strategy(struct write_commit_graph_context *ctx,
 				    (uintmax_t)g->num_commits);
 			num_commits += g->num_commits;
 			g = g->base_graph;
+			depth++;
 
 			ctx->num_commit_graphs_after--;
 		}
@@ -2320,16 +2324,13 @@ static void split_graph_merge_strategy(struct write_commit_graph_context *ctx,
 		BUG("split_graph_merge_strategy: num_commit_graphs_after "
 		    "should be 1 with --split=replace");
 
-	if (ctx->num_commit_graphs_after == 2) {
-		char *old_graph_name = get_commit_graph_filename(g->dir);
-
-		if (!strcmp(g->filename, old_graph_name) &&
-		    strcmp(g->dir, ctx->dir)) {
-			ctx->num_commit_graphs_after = 1;
-			ctx->new_base_graph = NULL;
-		}
-
-		free(old_graph_name);
+	/*
+	 * If we cannot add the new base to our chain we instead merge it and
+	 * all of its base layers.
+	 */
+	if (ctx->new_base_graph && depth >= ctx->chainable_layers) {
+		ctx->num_commit_graphs_after = 1;
+		ctx->new_base_graph = NULL;
 	}
 
 	CALLOC_ARRAY(ctx->commit_graph_filenames_after, ctx->num_commit_graphs_after);
@@ -2560,6 +2561,7 @@ int commit_graph_write(struct repository *r,
 	struct oidset reachable_commits = OIDSET_INIT;
 	struct topo_level_slab topo_levels;
 	struct commit_graph *g;
+	bool mergeable = true;
 
 	if (!!opts->pack_indexes + !!opts->commits + !!(opts->flags & COMMIT_GRAPH_WRITE_REACHABLE) > 1)
 		BUG("attempting to write commit-graph with mutually incompatible options");
@@ -2597,6 +2599,33 @@ int commit_graph_write(struct repository *r,
 	for (struct commit_graph *chain = g; chain; chain = chain->base_graph)
 		chain->topo_levels = &topo_levels;
 
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
+		bool is_local = !strcmp(layer->dir, ctx.dir);
+
+		free(path);
+
+		if (!is_local && !is_split)
+			break;
+		if (!is_local)
+			mergeable = false;
+
+		if (mergeable)
+			ctx.mergeable_layers++;
+		ctx.chainable_layers++;
+	}
+
 	if (opts->flags & COMMIT_GRAPH_WRITE_BLOOM_FILTERS)
 		ctx.changed_paths = 1;
 	if (!(opts->flags & COMMIT_GRAPH_NO_WRITE_BLOOM_FILTERS)) {

-- 
2.56.1.763.g16177fe143.dirty

