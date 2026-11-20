Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=103.168.172.149
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795177400;
	b=SsAZZ8RHKtAFh837d17mITzjBj+0VxOIGE7eeMRX9Tt3hpKLCelzF478EirKCrlJ2wUn
	 9VxzASQLW0Eh+zfZi9W6pSH/sgKDpnR7GqslpNVVG+TD+jGQj8ugGNIgpvOlG6Q9YDQdh
	 JRtOHVA2qd5dYr1UQ2WK09y9BLn/NmhHrM3hifQaIRjG8eW3iczEewAg55FtpHDpU5oj8
	 yvGtA8HunzTTkpe9RSZsMab3dwYhKvR/UCXkY1YpuVdAPGalIiMlClLEz7dk4iT8glSqo
	 D1PLE0DwlMBicAOHB+A+v7G/CRcAHXz0xBliS0Z+L+jC8yd/7q0SslHBloq+lngtRDA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795177400;
	h=DMARC-Filter:Received:Received:DKIM-Signature:DKIM-Signature:
	 X-DKIM2-Info:DKIM2-Signature:X-DKIM2-Info:Message-Instance:
	 X-ME-Sender:X-ME-Received:X-ME-Proxy-Cause:X-ME-Proxy:Feedback-ID:
	 Received:Received:From:Date:Subject:MIME-Version:Content-Type:
	 Content-Transfer-Encoding:Message-Id:References:In-Reply-To:To:Cc:
	 X-Mailer;
	bh=Rx6wwbpACmDUJFeUnqYfRf5efor/bgdtoa0tO/JXXUE=;
	b=Gt+f1ZdCbTb/hUh8DF3rvg1dxITdrDE8FKf9UDcyDGVxJquS3pPgutXLzkLCCYNXLZ7U
	 e+NPxb4IAWDLYes0CsBAUolcJvrwZC57zGcf0mqmb7MwZyPlIUO2k/Po4yofmRCZ9qDt9
	 to51sBDY2PmuoMpRr0MsnCHqAxfGjtAldxPfI/AyqWu4J7s5xall74/J8j6Ga+6t9bnTy
	 edsGVRbx4zcEj2t0c8lYR7JWZ55p7tLWWMfvl/tmao+nbFg06jxaB4Yu3FpMm6+aZDXI0
	 Aiwxh8eDuWoL69xS54dBy1BdGVediPXeyjloY8NLIw2HSyoBtiVESPjJ1hq/UVL+KZg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=pks.im;
	spf=pass smtp.mailfrom=pks.im;
	dkim=pass header.d=pks.im header.i=@pks.im header.a=rsa-sha256 header.s=fm3 header.b=v57FwAuY;
	dkim=pass header.d=messagingengine.com header.i=@messagingengine.com header.a=rsa-sha256 header.s=fm3 header.b=gFKdLUWb;
	arc=none smtp.remote-ip=103.168.172.149
Received: from fout-a6-smtp.messagingengine.com (fout-a6-smtp.messagingengine.com [103.168.172.149])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 528FF606A320
	for <git@vger.kernel.org>; Fri, 20 Nov 2026 12:23:20 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 528FF606A320
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=pks.im header.i=@pks.im header.a=rsa-sha256 header.s=fm3 header.b=v57FwAuY;
	dkim=pass (2048-bit key, unprotected) header.d=messagingengine.com header.i=@messagingengine.com header.a=rsa-sha256 header.s=fm3 header.b=gFKdLUWb
Received: from phl-compute-03.internal (phl-compute-03.internal [10.202.2.43])
	by mailfout.phl.internal (Postfix) with ESMTP id 7E76BEC00C6
	for <git@vger.kernel.org>; Fri, 20 Nov 2026 07:23:19 -0500 (EST)
Received: from phl-frontend-03 ([10.202.2.162])
  by phl-compute-03.internal (MEProxy); Fri, 20 Nov 2026 07:23:19 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm3; t=1795177399;
	 x=1795263799; bh=Rx6wwbpACmDUJFeUnqYfRf5efor/bgdtoa0tO/JXXUE=; b=
	v57FwAuYRI0XRy6o4M9g0l4CPlY8E+LlqqPlhNCB99nSbhGoiZ8MI2tI3Ca0h6jp
	z0Wmw3K3b9L1Am0M4vA4M5RCZDsY1YOKwLyZPA4V+rrDB8BMz5lGx1koWP/PeAD0
	lMBuUid27Rpdpv5vZ6jc5PoMD6i9Vv2uy0Up1b32K/EMB5elZJreICq7zpBZYWt1
	sOBPxErKvdO2N3C9tIJTwq7RXtZd1RFILk1vUlkCBLoZLHnVZ2JEBRbXEgqK5Rdf
	ZDvdlYkaeGJS431gmt7aImQUSO2VOUHAiDerBVIgaG9y3CpCK8VN1gHOdiynAVR1
	snIWGHup9z4Z9LkukSwhTw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1795177399; x=
	1795263799; bh=Rx6wwbpACmDUJFeUnqYfRf5efor/bgdtoa0tO/JXXUE=; b=g
	FKdLUWbvY1WCsh7d8936kb/ooIAe7QSj8bioJC2KDpn+DDkNLY0gtPrP05EevLhK
	aW3++K8xcViLQFlj+96YkfJ82icNtwzNURkhW4GLT5n3Jp313+wy2G9Md9lYwibg
	Me2jF+20bvMm27Z/9wXqvqBZ1BbzUzLwkOvUL666GeLGigTe5LqjuZuaB6AUWEoS
	zWOSrTtCOAC6Ulq751OOGCUJragrZ/s2mbKLiZ0fO+4o4px3Y23PeGtVDZKiPk+K
	7BkM1o9pcAWGfSNoXbY6iNk/9M6lUHIHDZFjIMzkGROaVJcYQHTKxeMhHHIw+4aw
	/NyluupFi78Via39LNe8g==
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-09;
	repo=github.com/dkim2wg/interop; date=2026-11-03; sw=lmtpprox;
	action=sign d=pks.im a=rsa-sha256;
DKIM2-Signature: i=1; m=1; t=1795177399; d=pks.im; mf=PHBzQHBrcy5pbT4=;
	rt=PGdpdEB2Z2VyLmtlcm5lbC5vcmc+;
	s=fm3:rsa-sha256:RdqhPZn3nEglHtF9z7dZu1cgBP2V8lVWCVzRQNIUYdDWLDe
	LgcBLRazdH2qIkBEXtxZrl59PajHgrc/VUz4ih9pAY101ZHLBLUci/1DIEwLdTo1
	KbtPhc+vecKooOSnOPVDptSgy5fdto+VmuPvlRlUz04dskSacIBhbS86SoXe149D
	RdsCppO/FdfUSDc+mFVG92bs8i5Mltdq7320zpNa4i/3BonDPOJ+9DLHc/oT3iHV
	rr5Hq/hv3fat9wNW+Je7pUFU4wPi2dxxPar4Mbi4WE1aiIhu5lanVGC/2UhPXbaa
	HH5Coy2lYojTfdp7zR+6/IOgW6YoKkHxHq8uKtw==;
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-09;
	repo=github.com/dkim2wg/interop; date=2026-11-03; sw=lmtpprox;
	action=mi-m=1; hc=12;
	hn=cc,content-transfer-encoding,content-type,date,feedback-id,
	from,in-reply-to,message-id,mime-version,references,subject,to;
Message-Instance: m=1; h=sha256:c8uT5be1xqWwb2IGu09wKu7ly+1cFwdpLXAgCdtOjZU=:h9esywmzXNL3Iryv7k6vJ8tzq+2Yw73IpPxrWImLy4M=;
X-ME-Sender: <xms:tzsAa2Z1p6SzrXraZYs2cpbiucT-u3VH9383H84ASAq7LmHPbDWZHA>
    <xme:tzsAa_Y_YhWdl8_WatPb5NUL-NGt_2nHAqo2u8waM2fh_tdxKk6czSJ337lVeNLp6
    pKle0VkwpPgPFQiQIwpCRHAioV9XfPcLNcE_0jP7BaHdEbeiNe5rug>
X-ME-Received: <xmr:tzsAa-k1Xd-Y_FBRh4r9xlF2FvodOSlQ6WVnB9xkc3ew-DzF1XbZndDxw90QFW7Pr9wdc7I>
X-ME-Proxy-Cause: dmFkZTGk7YT2yemqBOPjvzAuyDV68iorRlK4Xo6WwG03rGjWK+00U2BhtqTLzoU1V/kR9J
    mrsZe6qPeL9f02NkLRZJNVxDtm6aV1U6/JEbOybioHVYp+inpmBHnwLx8L61Y/DQah1ZF9
    M+/50ooCYO8PLPnqyMWJeYY0pOfb5QeTSOOVwXAlzX/Mc7fo/bCDKkSQNxdJvjRdnyeqAZ
    Tn63tnpzbxHAS312Iu0zzBbcuk8mqJOFNhzUx0lVr5mL6H9NPoIS6w0l+K2wLS1+qT/mqR
    D/CGzlh4XVUGE92ZajM4JwVICG7KLAYDZD/B50IueMEt0ozQTquKmRbSjvy+i5un1YaZGW
    KfjdLqG+SVynO/g/bnwm76nlczZciWqiXFhZTqJ53bb+3xeBTQxPFQRbiGCa2aUjI9p+Te
    nZ92IykG4H8Qsr4EvBg+WOC1gRT/lXGnwaGkR8FIWaNrTABDFHLmcLfvI7fGMfkHYTt+zV
    QQ3Gq6/E7k2gwgJCZBc+JnbG279DPm5H+EhQIBMMKxADR0emRidtV4FoIS1BFG/L4JfnED
    +wSjJMKDP7JZws01Iw0/fPqciZyroAnCSULgsOj4tyK+hfMKNrpZWkHEToOAOewMrIpnz2
    aiXSXoiiiyWWx2I8y/NA9bymi1PLgdKRW43YrHk8qEzJ1WaalJ8YjyqFRU7g
X-ME-Proxy: <xmx:tzsAazyTxcGvZUto6OFupvPG2lM_PY3QqSY2zhSwyTF-QgqMZS9Z3g>
    <xmx:tzsAa0MWfrCX0zwKjXo2lSs-TARFWB7-fUpz16aXm5zOCumv4r_bVA>
    <xmx:tzsAa_SXC6tXYNkuGj63bpY5ooF-nFitQ6MeWkRnxJuF-OpwrNx7tw>
    <xmx:tzsAa6ad-cZvlrdY9R_yGYXh_AT5ZfXUHbEBhIbr8n3nXL8qhk03xw>
    <xmx:tzsAa5wuUd__PujPz5mtUNrDOuNkTqnTsxzoO7RqfrJUSOCj1m1CrvV9>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 20 Nov 2026 07:23:18 -0500 (EST)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id c715d193 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Fri, 20 Nov 2026 12:23:17 +0000 (UTC)
From: Patrick Steinhardt <ps@pks.im>
Date: Fri, 20 Nov 2026 13:22:53 +0100
Subject: [PATCH v2 5/7] commit-graph: decide mergeable and chainable layers
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
Message-Id: <20261120-pks-odb-pluggable-commit-graphs-v2-5-31f2341a9932@pks.im>
References: <20261120-pks-odb-pluggable-commit-graphs-v2-0-31f2341a9932@pks.im>
In-Reply-To: <20261120-pks-odb-pluggable-commit-graphs-v2-0-31f2341a9932@pks.im>
To: git@vger.kernel.org
Cc: Junio C Hamano <gitster@pobox.com>
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
index e48d8fc0a78..ff2a5cbcbac 100644
--- a/commit-graph.c
+++ b/commit-graph.c
@@ -1157,6 +1157,8 @@ struct write_commit_graph_context {
 	uint64_t progress_cnt;
 
 	char *base_graph_name;
+	size_t mergeable_layers;
+	size_t chainable_layers;
 	int num_commit_graphs_before;
 	int num_commit_graphs_after;
 	char **commit_graph_filenames_before;
@@ -2289,6 +2291,7 @@ static void split_graph_merge_strategy(struct write_commit_graph_context *ctx,
 	enum commit_graph_split_flags flags = ctx->opts->split_flags;
 	int max_commits = ctx->opts->max_commits;
 	int size_mult = 2;
+	size_t depth = 0;
 	uint32_t i;
 
 	if (ctx->opts->size_multiple)
@@ -2305,7 +2308,7 @@ static void split_graph_merge_strategy(struct write_commit_graph_context *ctx,
 	    flags != COMMIT_GRAPH_SPLIT_REPLACE) {
 		while (g && (g->num_commits <= st_mult(size_mult, num_commits) ||
 			    (max_commits && num_commits > max_commits))) {
-			if (strcmp(g->dir, ctx->dir))
+			if (depth >= ctx->mergeable_layers)
 				break;
 
 			if (unsigned_add_overflows(num_commits, g->num_commits))
@@ -2315,6 +2318,7 @@ static void split_graph_merge_strategy(struct write_commit_graph_context *ctx,
 				    (uintmax_t)g->num_commits);
 			num_commits += g->num_commits;
 			g = g->base_graph;
+			depth++;
 
 			ctx->num_commit_graphs_after--;
 		}
@@ -2326,16 +2330,13 @@ static void split_graph_merge_strategy(struct write_commit_graph_context *ctx,
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
@@ -2566,6 +2567,7 @@ int commit_graph_write(struct repository *r,
 	struct oidset reachable_commits = OIDSET_INIT;
 	struct topo_level_slab topo_levels;
 	struct commit_graph *g;
+	bool mergeable = true;
 
 	if (!!opts->pack_indexes + !!opts->commits + !!(opts->flags & COMMIT_GRAPH_WRITE_REACHABLE) > 1)
 		BUG("attempting to write commit-graph with mutually incompatible options");
@@ -2603,6 +2605,33 @@ int commit_graph_write(struct repository *r,
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
2.56.1.831.g720f3f5937.dirty

