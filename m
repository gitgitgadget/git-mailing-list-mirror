Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=103.168.172.156
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795177390;
	b=HKjFOsaN6Yvv5dRdhfWxofuLuZu57aFVMWKLfiHgcKvk48VI1DzCmZButFsvqhG+VMlv
	 LfaZrjuFuvGOea/sFDWlosI7Er6ab8JBrIrfhqw0tUsTFAYJkAawPTq9te5fRAYXZDr/V
	 60AQo8zU8aGpBzUTrzXsd5ikl4q4yfs33Z41w2RZnfm1MtXW+Vcx5k+AitBrkBOpqCwug
	 Nwj8F81qE5x07Xm6gfC6Zv1biYBAFqqS+dbRfGItuMNGgTqPS8SSaa6aggc8iT04B682N
	 yHzkKEx+ZW2VKV36yu421QSTTDImeuGQ8B/hU+XH2kMNHtvjXPkm11tjhrhJ1yyFCGw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795177390;
	h=DMARC-Filter:Received:Received:DKIM-Signature:DKIM-Signature:
	 X-DKIM2-Info:DKIM2-Signature:X-DKIM2-Info:Message-Instance:
	 X-ME-Sender:X-ME-Received:X-ME-Proxy-Cause:X-ME-Proxy:Feedback-ID:
	 Received:Received:From:Date:Subject:MIME-Version:Content-Type:
	 Content-Transfer-Encoding:Message-Id:References:In-Reply-To:To:Cc:
	 X-Mailer;
	bh=0ZsQYnZx08isQzZR3DVV2LFuysFZwCX1bINj3UtvUd4=;
	b=5ZT4hsLVWIgcpti2J/LDhsaSDbDSDpjItzjh/6OEsIxeQDteolFn0ljhScTdnC12pffq
	 A2G40BZQmHSAbGmIlZZtR3Yj8eAR3xJ8LGyRxk+O7G8Gb2LYzwjjVAKkCm54sACQ7OgA5
	 I67sYTMNlzwyIjWlgzk2frj+fmZS9EF/boPpQr24vD8MOUD9AguYtWnOrP9tLVI7Ba1CA
	 TZ+ZKHGqAM+neXD0HNoNZTD2/eeX7z2601hGgV13QPgLW5ZI+Dybmnt8WiPLlBx0QxyEf
	 t7n5V4E/dcr7omtk9I+4ASchZVQXXF9DPZldKhOAaQvFTCPWVwcCjUiUjJbuqQUVEag==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=pks.im;
	spf=pass smtp.mailfrom=pks.im;
	dkim=pass header.d=pks.im header.i=@pks.im header.a=rsa-sha256 header.s=fm3 header.b=K8EHHdE3;
	dkim=pass header.d=messagingengine.com header.i=@messagingengine.com header.a=rsa-sha256 header.s=fm3 header.b=kXkEU6od;
	arc=none smtp.remote-ip=103.168.172.156
Received: from fhigh-a5-smtp.messagingengine.com (fhigh-a5-smtp.messagingengine.com [103.168.172.156])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B4550606A320
	for <git@vger.kernel.org>; Fri, 20 Nov 2026 12:23:09 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org B4550606A320
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=pks.im header.i=@pks.im header.a=rsa-sha256 header.s=fm3 header.b=K8EHHdE3;
	dkim=pass (2048-bit key, unprotected) header.d=messagingengine.com header.i=@messagingengine.com header.a=rsa-sha256 header.s=fm3 header.b=kXkEU6od
Received: from phl-compute-11.internal (phl-compute-11.internal [10.202.2.51])
	by mailfhigh.phl.internal (Postfix) with ESMTP id D5C9F140023F
	for <git@vger.kernel.org>; Fri, 20 Nov 2026 07:23:08 -0500 (EST)
Received: from phl-frontend-03 ([10.202.2.162])
  by phl-compute-11.internal (MEProxy); Fri, 20 Nov 2026 07:23:08 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm3; t=1795177388;
	 x=1795263788; bh=0ZsQYnZx08isQzZR3DVV2LFuysFZwCX1bINj3UtvUd4=; b=
	K8EHHdE3dCjS9kgGnPaHvLINMyPtifFs32lW4pShc/c6ZZ4vjYRKUuwU+2peaA5c
	yei4IbPEZT7Bqtn/p7s+NKzTSfKS6JXm+i8o3uSJDKEtPj6hgPYGaB5pg9oyYRLV
	nycrycPlycNdI4fQWmO30VMN9okZdYELffAiT6sYYDDe+5Td73pHGNJjjIF0/0CQ
	AYeH3clNNvmFYrmpnkAeWehSR/WG62ZakQE+Slonn4e9A2PT+TkvCatGPzLPBgt6
	yxT6cIovI6DTlQJPhyeUETH1NdgiJrxROEq+mHW5pVLqxeXIIkNgkl7QgDosY95v
	Mm32dhIqRbyKFlk6e6TTJA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1795177388; x=
	1795263788; bh=0ZsQYnZx08isQzZR3DVV2LFuysFZwCX1bINj3UtvUd4=; b=k
	XkEU6od5oHrm03C44pd0JGVq5CzAl5stVi43fEuEmA45nm+C+sJ13QisS65WQofV
	Bt7vnmOVClkSgRay1amFUqvYsnD74TAgmSOBpmoE+oQlG+k2XfcZAYKsir4iP/4C
	Egas9zxGq4bjgTt/AjYUfGxzrV9AiQ2X/KtFrRG40aRgT7KdJcXdHUHild8CvE/s
	HRtBUg3C4tezsiYixLDCG2UdwhEI47eSvUhvEW2DtHnndSdQV6JyLlHYAoD2Tl6D
	6jeE3/+lbMkkQH5DtMyTFISu5LAuXD1zVYj+P7shAdz6wNkfG6pGYmrVPaTASFg5
	zrY/yDMDzcPNTmKMH/2Ww==
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-09;
	repo=github.com/dkim2wg/interop; date=2026-11-03; sw=lmtpprox;
	action=sign d=pks.im a=rsa-sha256;
DKIM2-Signature: i=1; m=1; t=1795177388; d=pks.im; mf=PHBzQHBrcy5pbT4=;
	rt=PGdpdEB2Z2VyLmtlcm5lbC5vcmc+;
	s=fm3:rsa-sha256:n0z00Q7O2fIt1yBG/3JSepa5M8GmnrKqUsqpkmNdnUsttUN
	g5qSxBhoihSK+V/B5l/dlL8AKcJiTHmr+Kp9AsxWcyQU2Getk1nL2jcgJ3BR5mtU
	6B3f5V5MtWCL/6YV7AgZ8z0m5jAtQiqwtriW/iaUjf5DhMWeZvtKGB5uk0K3vumc
	JXFLLWRJIaHc7IgD9515JrryrOXdkRS9Atpc2fuj/UVoWxgriBhPnxl2zc+XPSLR
	GB8XSLg1tAtQuZTn6qQcglFjUbxvZ17sao+utHeZjzCUXWqe1rb7ouYDyLnjr+jB
	B3TAHWPJGA9sySfeIuLoHkFSvtl0gISl8O0eH9A==;
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-09;
	repo=github.com/dkim2wg/interop; date=2026-11-03; sw=lmtpprox;
	action=mi-m=1; hc=12;
	hn=cc,content-transfer-encoding,content-type,date,feedback-id,
	from,in-reply-to,message-id,mime-version,references,subject,to;
Message-Instance: m=1; h=sha256:CbYHyzmESRy5gRvaCRvJMeeFdhy1fMJrjmR20Rp4ZaQ=:Z4untdC4mQjB/YMEsr4FWXU5bHxK4lLVBZ89DEUK09g=;
X-ME-Sender: <xms:rDsAaz0p_qQHrser0THjVIHkcA0rawl4barIFpOeJd6yBzRzRl3V9A>
    <xme:rDsAa4H8E1xnB4Pgo3Az1yDPT7ZY_0DVl6kTohf7gFq7ssEgIQOy5lviRGgZ5XV8o
    ilXoIyrQ8RXnypl8nHvSFX3mrRJ-dv8OI9zeare1NNXSWHBHrRI3v8>
X-ME-Received: <xmr:rDsAaxhfkwLoH3YEm54ieGIqxoYPqxapGdHSThT_A4dt2c_oZKg7w3U02PU2-1SiYYM-gnk>
X-ME-Proxy-Cause: dmFkZTE30M4DhJ6BlHACvgSE3qTozkDJYeVV5N8aECYztHKd+6E8X7EyVKhmUcqZHARQ9G
    ej74kFF9SXDEsQnJvo5KV9xr56t6d7cAr5SC+cvGFgXtwIVM9RNry7YbsVmEwl8iGhUGYE
    i94KEexOvxUB3Xpfp+LqNlCW8iaxnYw1nOhKDw6IvPJZNp69jwBY818qCib3BngrmnpnJ5
    7GRESSQDlu2eh2zQMkObV8nXZWnGxLSicwIhnsgfCcv0yqz5g4qu0XlVibB6OGdKMoRGc/
    hDCA+IMYG5jWIBgOpjbR8IU1dmxYNUIQnl75V1QWBKAUdVL/kuH07PjlVt3ejjqggP1kal
    K9OtqVVcuGGuTCP9bng8LAKtHtbK++5cTqBPV0LQCPYxpxcsysikrPbYOCh41wFCABWNzq
    Tt64kCqbD4MenVO2NH/DDauC3RziHnqyVub5Vm0BkeJNR4lTiIFy1sH0Z9gitXlyi+2YvI
    3lLARMSjphbzkOqmn/PR5/3h62SMZcoOCeyqzhtyogK/PaVTITy4v73y0yVAKVDBJXctfm
    mkTmTrMR3UYrduCbEVlGaoQ3vXKBg6OwUE9b1qVNs6c8N69X+1OUE1PI67uoHS3+a+C8WJ
    +y6EsjlI/eQ+5oVN8J2nR+MSBlFwnsDaBW623io6BAQurRUy9FbV65R2HRgw
X-ME-Proxy: <xmx:rDsAaz9WKSJJ0TQTqpELhq-uyT8ft8z5619GJy7duGQ2A_gec59LtQ>
    <xmx:rDsAa4rQ8LzG4Z39YLEcNBbc-VJ_lFz4jDPzeZHJg3jgcyDzmcp0sQ>
    <xmx:rDsAay-ytFYmWEs820rcz0-SkzYptzw1MkGJF2rVccQe53jbb5TtZg>
    <xmx:rDsAa8XK7iPhTnoCzKSuWPsVVgooz69Nf6bYwA2R97EVxnibIlEH7Q>
    <xmx:rDsAa_OZGfUERgGz6bU2p1npCuuzeqrcaPIDA0aue5Eyfn21HVROaGBj>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 20 Nov 2026 07:23:08 -0500 (EST)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id 32a616fb (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Fri, 20 Nov 2026 12:23:07 +0000 (UTC)
From: Patrick Steinhardt <ps@pks.im>
Date: Fri, 20 Nov 2026 13:22:50 +0100
Subject: [PATCH v2 2/7] commit-graph: simplify linking commit graph chains
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
Message-Id: <20261120-pks-odb-pluggable-commit-graphs-v2-2-31f2341a9932@pks.im>
References: <20261120-pks-odb-pluggable-commit-graphs-v2-0-31f2341a9932@pks.im>
In-Reply-To: <20261120-pks-odb-pluggable-commit-graphs-v2-0-31f2341a9932@pks.im>
To: git@vger.kernel.org
Cc: Junio C Hamano <gitster@pobox.com>
X-Mailer: b4 0.15.2

When we load a commit graph chain we verify for every layer that the
hash of the base commit graph matches what the current tip has in its
base graphs chunk. To do so we pass both the chain itself as well as the
array of object IDs that we have read from the commit-graph chain file
to `add_graph_to_chain()`.

But the array of object IDs is redundant information: we have already
loaded and linked the base layers, and as part of that we have stored
their respective hashes in the structure itself. Consequently, we can
already derive the hashes by walking the chain of base layers.

Refactor the function to only take the new tip and base layers as input
and derive all the other information ad-hoc and make the function
public. This prepares for a subsequent commit, where we are about to
move the logic that creates commit graph chains into the object database
backend.

While at it, align on error semantics so that we return 0 on success, or
a negative error code otherwise.

Signed-off-by: Patrick Steinhardt <ps@pks.im>
---
 commit-graph.c | 50 ++++++++++++++++++++++++++------------------------
 commit-graph.h |  8 ++++++++
 2 files changed, 34 insertions(+), 24 deletions(-)

diff --git a/commit-graph.c b/commit-graph.c
index 0c75939910d..9e5656992eb 100644
--- a/commit-graph.c
+++ b/commit-graph.c
@@ -575,44 +575,48 @@ static void validate_mixed_bloom_settings(struct commit_graph *g)
 	}
 }
 
-static int add_graph_to_chain(struct commit_graph *g,
-			      struct commit_graph *chain,
-			      struct object_id *oids,
-			      int n)
+int commit_graph_link_base(struct commit_graph *g,
+			   struct commit_graph *base)
 {
+	struct commit_graph *layer;
+	size_t n = 0;
+
+	for (layer = base; layer; layer = layer->base_graph)
+		n++;
+
 	if (n && !g->chunk_base_graphs) {
 		warning(_("commit-graph has no base graphs chunk"));
-		return 0;
+		return -1;
 	}
 
 	if (g->chunk_base_graphs_size / g->hash_algo->rawsz < n) {
 		warning(_("commit-graph base graphs chunk is too small"));
-		return 0;
+		return -1;
 	}
 
-	while (n) {
+	for (layer = base; layer; layer = layer->base_graph) {
 		n--;
-
-		if (!hasheq(oids[n].hash, g->chunk_base_graphs + st_mult(g->hash_algo->rawsz, n),
+		if (!hasheq(layer->oid.hash,
+			    g->chunk_base_graphs + st_mult(g->hash_algo->rawsz, n),
 			    g->hash_algo)) {
 			warning(_("commit-graph chain does not match"));
-			return 0;
+			return -1;
 		}
 	}
 
-	if (chain) {
-		if (unsigned_add_overflows(chain->num_commits,
-					   chain->num_commits_in_base)) {
+	if (base) {
+		if (unsigned_add_overflows(base->num_commits,
+					   base->num_commits_in_base)) {
 			warning(_("commit count in base graph too high: %"PRIuMAX),
-				(uintmax_t)chain->num_commits_in_base);
-			return 0;
+				(uintmax_t)base->num_commits_in_base);
+			return -1;
 		}
-		g->num_commits_in_base = chain->num_commits + chain->num_commits_in_base;
+		g->num_commits_in_base = base->num_commits + base->num_commits_in_base;
 	}
 
-	g->base_graph = chain;
+	g->base_graph = base;
 
-	return 1;
+	return 0;
 }
 
 int open_commit_graph_chain(const char *chain_file,
@@ -646,20 +650,19 @@ struct commit_graph *load_commit_graph_chain_fd_st(struct object_database *odb,
 {
 	struct commit_graph *graph_chain = NULL;
 	struct strbuf line = STRBUF_INIT;
-	struct object_id *oids;
 	int i = 0, valid = 1, count;
 	FILE *fp = xfdopen(fd, "r");
 
 	count = st->st_size / (odb->repo->hash_algo->hexsz + 1);
-	CALLOC_ARRAY(oids, count);
 
 	for (i = 0; i < count; i++) {
 		struct odb_source_files *files;
+		struct object_id oid;
 
 		if (strbuf_getline_lf(&line, fp) == EOF)
 			break;
 
-		if (get_oid_hex_algop(line.buf, &oids[i], odb->repo->hash_algo)) {
+		if (get_oid_hex_algop(line.buf, &oid, odb->repo->hash_algo)) {
 			warning(_("invalid commit-graph chain: line '%s' not a hash"),
 				line.buf);
 			valid = 0;
@@ -680,9 +683,9 @@ struct commit_graph *load_commit_graph_chain_fd_st(struct object_database *odb,
 				 * Verify that the loaded commit graph's
 				 * trailer matches the chain file.
 				 */
-				if (!oideq(&g->oid, &oids[i])) {
+				if (!oideq(&g->oid, &oid)) {
 					warning(_("commit-graph chain does not match"));
-				} else if (add_graph_to_chain(g, graph_chain, oids, i)) {
+				} else if (!commit_graph_link_base(g, graph_chain)) {
 					graph_chain = g;
 					valid = 1;
 				}
@@ -702,7 +705,6 @@ struct commit_graph *load_commit_graph_chain_fd_st(struct object_database *odb,
 	validate_mixed_generation_chain(graph_chain);
 	validate_mixed_bloom_settings(graph_chain);
 
-	free(oids);
 	fclose(fp);
 	strbuf_release(&line);
 
diff --git a/commit-graph.h b/commit-graph.h
index 2156499a688..f0e7cc93461 100644
--- a/commit-graph.h
+++ b/commit-graph.h
@@ -128,6 +128,14 @@ struct commit_graph *load_commit_graph_one_fd_st(struct repository *repo,
 struct commit_graph *load_commit_graph_chain_fd_st(struct object_database *odb,
 						   int fd, struct stat *st,
 						   int *incomplete_chain);
+
+/*
+ * Link the commit graph layer `g` on top of the chain `base`. `base` may be
+ * NULL if `g` is the root of a new chain. Returns 0 on success, a negative
+ * error code otherwise.
+ */
+int commit_graph_link_base(struct commit_graph *g,
+			   struct commit_graph *base);
 struct commit_graph *read_commit_graph_one(struct repository *repo,
 					   const char *dir);
 

-- 
2.56.1.831.g720f3f5937.dirty

