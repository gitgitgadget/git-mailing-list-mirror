Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=103.168.172.159
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794834478;
	b=fwB5E5AVkRuo/ZF82ecigdkKTA03e6vSvb7fvyOOLQ5Jg04DtptCzNdNMYnQexxAcI78
	 SsqQn7hGv2hpMy+eOisdn0b/hCA4/ixtS21ddeioZ03ZTcQo+s3VbxzQI+jxywca5Y6Sg
	 +FuAnuyVzSs23pW88SuvXvT5xWVs9KeRli5QYsxwBjrLrnDg2URWLJxkfUdenLlFkk2zi
	 NmJiuF6tWA1BHltZeu44VAohXj+vDNU05lE9IIO2FA3sueqrHOL9Z5Y90xXbO9jBDDZ8d
	 RDwW4mWlwRzjyx/kgKBp/tNOMInDJdgdla2XQQOHgK4bKINS4HgMbS6raY/qzxa7rWg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794834478;
	h=DMARC-Filter:Received:Received:DKIM-Signature:DKIM-Signature:
	 X-DKIM2-Info:DKIM2-Signature:X-DKIM2-Info:Message-Instance:
	 X-ME-Sender:X-ME-Received:X-ME-Proxy-Cause:X-ME-Proxy:Feedback-ID:
	 Received:Received:From:Date:Subject:MIME-Version:Content-Type:
	 Content-Transfer-Encoding:Message-Id:References:In-Reply-To:To:Cc:
	 X-Mailer;
	bh=rDmaC9lIbs4ERVWVfSI9wQS1jPnQ1BMq5x0VSrPrSLA=;
	b=wKoWcUYEBmVXp/QKflqyLD+Iq1eA3W3U45e4mQOlZcukDkpco3/Sn7vGFUyPcRqpo6mX
	 7WJhx5c/C8bqkYeOq4jHj7tJwRa57sg/EGZ4unVX/AEIBjQ2bwEeaG5CROpr925E3GJS5
	 DmagmPPwHH80G0dQ5tzS/u8si+Ytzfj/pqxILJ9z8xh3TSWmDpxdsQfYp0a8CABXgPAko
	 bxDvJ8W1BPRALGmn7vlkMLmWHu1VKgFT20S1X4a41ZWI8fDfTZer7Bqi5GASqYIXI1XxF
	 k8EtwagxLW+8sg5laeZRIOft5tEToyxis6ERX/0rgM2lwGgZYWN5SgLk2ulrwCbt30g==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=pks.im;
	spf=pass smtp.mailfrom=pks.im;
	dkim=pass header.d=pks.im header.i=@pks.im header.a=rsa-sha256 header.s=fm3 header.b=MpHGkuLG;
	dkim=pass header.d=messagingengine.com header.i=@messagingengine.com header.a=rsa-sha256 header.s=fm3 header.b=hND98Z6S;
	arc=none smtp.remote-ip=103.168.172.159
Received: from fhigh-a8-smtp.messagingengine.com (fhigh-a8-smtp.messagingengine.com [103.168.172.159])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 02C89606A89B
	for <git@vger.kernel.org>; Mon, 16 Nov 2026 13:07:57 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 02C89606A89B
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=pks.im header.i=@pks.im header.a=rsa-sha256 header.s=fm3 header.b=MpHGkuLG;
	dkim=pass (2048-bit key, unprotected) header.d=messagingengine.com header.i=@messagingengine.com header.a=rsa-sha256 header.s=fm3 header.b=hND98Z6S
Received: from phl-compute-10.internal (phl-compute-10.internal [10.202.2.50])
	by mailfhigh.phl.internal (Postfix) with ESMTP id 1D51C1400024
	for <git@vger.kernel.org>; Mon, 16 Nov 2026 08:07:57 -0500 (EST)
Received: from phl-frontend-03 ([10.202.2.162])
  by phl-compute-10.internal (MEProxy); Mon, 16 Nov 2026 08:07:57 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm3; t=1794834477;
	 x=1794920877; bh=rDmaC9lIbs4ERVWVfSI9wQS1jPnQ1BMq5x0VSrPrSLA=; b=
	MpHGkuLGRjKpu/z/qdeFtS7jEVWAT7mnB17WKYNgpTlvEVYrzBPBOTEOGKTYCxWT
	DrkPmMSx40ljTx2e/HqKyDEqh7Xf3nuc4IHI4UynHSvBfBAa0mb+F6lizcI7+d4j
	DgeHp/sJkZNc3b8aOjbf8HVoDosY9UqbOquqAT+0uL7UJfAFEcEwSb422/Uj4Okb
	RECh1D0uJSSYz9sOiVcvViiqjmPt2F7SRWl7OebqNKx/7b1+4FMFJoso4ubxeUfd
	7NrbHFXqHbBprovTiqkjdic3C2VXelfZDlP8iTGP/1cZmoBT6C5V7R6uoUyZTpSf
	A+qkBTyWQtUP79PnI8/GfQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1794834477; x=
	1794920877; bh=rDmaC9lIbs4ERVWVfSI9wQS1jPnQ1BMq5x0VSrPrSLA=; b=h
	ND98Z6SqhEm55Z4CuMJARwO4s5lxbN0BpDD6db+c+gDspVIu/I8kkeFmChaOvrmr
	N65MNDz6bxPShAZJ1k+vlFYNUrxXd7pUAsgxTGPSb59CR+Yz++fLBsNvOKcQJykq
	W6GnCCO6hKMir4UguMpG4K5HcFmcj4lrbqhcCGXpAyVaj9aUVEE/ai5YDW5l9XTf
	E+Xq+9NroI2gbiG+P7Ja5lmcLtRtWS/cD2Iu7qbwVXFWcPs/T86iLH32a0XbEAmC
	xcao2i8XlpxtMFYWF6apFbONVxzFb1udZt2gfoEOs4uixp95Fk/ZrTBLMoMzlXak
	7epKNWhR36Lk9j6Lvt2Rg==
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-09;
	repo=github.com/dkim2wg/interop; date=2026-11-03; sw=lmtpprox;
	action=sign d=pks.im a=rsa-sha256;
DKIM2-Signature: i=1; m=1; t=1794834477; d=pks.im; mf=PHBzQHBrcy5pbT4=;
	rt=PGdpdEB2Z2VyLmtlcm5lbC5vcmc+;
	s=fm3:rsa-sha256:jZB368e9Fo6zQRRhgeNzgTgpSecBwWcxaFR7KyuK57325v8
	nwVLt9JxsL5O1AgiXnrtznVQRA1p2tD7EKs5CAyAwex0T90lQgqt95zQ6uyv3mAW
	S/s9jOR3TzldpePf1VJGwzG6JoL23M0MIjMfkK1KireqWJsAgJhznFJHjRB5NgY4
	I+KSyZgV6XG9JlboArMWUdHPUhFuX+Wwn5QSuJUqZ0ukClSIVjkk7jP/jbPcHpmp
	xIzLVF77Z3mCSkSj6sIfqf6kH9fywrrT/c3jsMwa81+N6sZrXW9mZ3K5zSImsZvX
	1O0qkcAzIpBOG6ErOI+JAK6KcGV14ch05qgDE2A==;
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-09;
	repo=github.com/dkim2wg/interop; date=2026-11-03; sw=lmtpprox;
	action=mi-m=1; hc=12;
	hn=cc,content-transfer-encoding,content-type,date,feedback-id,
	from,in-reply-to,message-id,mime-version,references,subject,to;
Message-Instance: m=1; h=sha256:cHf4UJ5JBEsS3gA/Sp8cyvKgFwFydrbhisOE0Btxtls=:46Ass7uz4yOzjxgxc5ONDsDZr6IsHJNbv77Oh4hy3Kk=;
X-ME-Sender: <xms:LAD7aqy0MmrYLjpOezs7ePdTP7kOM0htc9CDOGd5s31eyy0LbCBu1Q>
    <xme:LAD7atOJGSPTGMGf5z4avqBfV56yLBl0x4Qct1vuXhPWtmNVk1aDg0iR2CFZYTERh
    yReoKlpv1-2PE3mga4NNtfZCMPIKO-3rKAjp6S5K8gZ0Zh5RDwm0DQ>
X-ME-Received: <xmr:LAD7ah-sWWjaNrh2RDTTgXozjOLgVWb0OD_5wEpaFwrn6rWDb6L17i2DNy6wZdWCoSvE_Ng>
X-ME-Proxy-Cause: dmFkZTFZEY3dRZaxYHKztVo3PV5exS7LC5so/OemZvN+WRzyMAuPxUkF0s8DXR9rm3sIft
    TNy3msB44N8fedNp8OEKsFykHBMtYYTrfbK0L+IwZ5LKw3S98nfrCPUmkqNy5t4VRzNB1H
    O1k+n5la66tVUCb3ERJIwzKtcyG8zt2k7Nq63bv8Bsb1mnjRJ95cbEfwctWmirTzT7W0Vv
    +wbH8aDjSJMImH6U0aTopBPlpGclwtUfOlL0sb99rKBTgdFJT1iNWAATNvrbto6s5wHgrA
    pyryLSwJgJXsiTvNzA0Sp3b/jhixtqv/ivz+VDrfFpK2d437jTBw6zWR21v5KA2lf8++nz
    a4F28Aj/Wo64v66d792PtJlb+UyOav+2dcT8+U1KWL9as7fnDdTomSLztKIQkoNTVTHrzt
    j5F5RJ/D8zCm4qi3NlaHi04kbzp8HtUqYIf9IINVWPOWAczi/WCK8+R2emC2N1eboEgWiI
    bfcaXtIOME1wQNIbFJIjdeE2IwxjBpXjWAArj0YqxHPSjqhx6MYKjI2SXCv4rKvjll31r+
    wHYpT/jhsyZobgWiU5mD1DNaPOZrOcuAxnCpHJ+arqTNHLhg9iiKX2O8XYvHkQPVyEMkpy
    PTvWSIf+xAAhMfhiKEkNBcxe7KDV4wQBnU7BKgyAbJ4cTVc80OTl6y+pUdOw
X-ME-Proxy: <xmx:LQD7alqk2_UfY7Q83wsEGBYVNjdstzEHc8OKXmT176msm7FQKnn8NA>
    <xmx:LQD7ar7LSjRv7Uw_2qhtFx902E27GSHKVV-oxKWiBssEBiylZHRxew>
    <xmx:LQD7atNguM-ptgis0L8P-FBfgX0artXLfzzdA6Bi4sMmi0ZyMtcXcA>
    <xmx:LQD7alPVAWSbvxp_n3KjfVFAVs9OAKGA8D9Cp6guAtFyuMHlqOYRpw>
    <xmx:LQD7aky-yb4P7OMLzSoCBKRfiW7LeYXLiQRoIdNlabH4_ahncH0VRp2o>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA for
 <git@vger.kernel.org>; Mon, 16 Nov 2026 08:07:56 -0500 (EST)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id 698af524 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO)
	for <git@vger.kernel.org>;
	Mon, 16 Nov 2026 13:07:55 +0000 (UTC)
From: Patrick Steinhardt <ps@pks.im>
Date: Mon, 16 Nov 2026 14:07:37 +0100
Subject: [PATCH 01/12] commit-graph: simplify linking commit graph chains
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
Message-Id: <20261116-pks-odb-pluggable-commit-graphs-v1-1-a83fc1ff0808@pks.im>
References: <20261116-pks-odb-pluggable-commit-graphs-v1-0-a83fc1ff0808@pks.im>
In-Reply-To: <20261116-pks-odb-pluggable-commit-graphs-v1-0-a83fc1ff0808@pks.im>
To: git@vger.kernel.org
Cc: 
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

Signed-off-by: Patrick Steinhardt <ps@pks.im>
---
 commit-graph.c | 52 ++++++++++++++++++++++++----------------------------
 commit-graph.h |  8 ++++++++
 2 files changed, 32 insertions(+), 28 deletions(-)

diff --git a/commit-graph.c b/commit-graph.c
index da65cd3deb9..94c761907a0 100644
--- a/commit-graph.c
+++ b/commit-graph.c
@@ -575,50 +575,48 @@ static void validate_mixed_bloom_settings(struct commit_graph *g)
 	}
 }
 
-static int add_graph_to_chain(struct commit_graph *g,
-			      struct commit_graph *chain,
-			      struct object_id *oids,
-			      int n)
+int commit_graph_link_base(struct commit_graph *g,
+			   struct commit_graph *base)
 {
-	struct commit_graph *cur_g = chain;
+	struct commit_graph *layer;
+	size_t n = 0;
+
+	for (layer = base; layer; layer = layer->base_graph)
+		n++;
 
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
-		if (!cur_g ||
-		    !oideq(&oids[n], &cur_g->oid) ||
-		    !hasheq(oids[n].hash, g->chunk_base_graphs + st_mult(g->hash_algo->rawsz, n),
+		if (!hasheq(layer->oid.hash,
+			    g->chunk_base_graphs + st_mult(g->hash_algo->rawsz, n),
 			    g->hash_algo)) {
 			warning(_("commit-graph chain does not match"));
-			return 0;
+			return -1;
 		}
-
-		cur_g = cur_g->base_graph;
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
@@ -652,20 +650,19 @@ struct commit_graph *load_commit_graph_chain_fd_st(struct object_database *odb,
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
@@ -682,7 +679,7 @@ struct commit_graph *load_commit_graph_chain_fd_st(struct object_database *odb,
 			free(graph_name);
 
 			if (g) {
-				if (add_graph_to_chain(g, graph_chain, oids, i)) {
+				if (!commit_graph_link_base(g, graph_chain)) {
 					graph_chain = g;
 					valid = 1;
 				} else {
@@ -702,7 +699,6 @@ struct commit_graph *load_commit_graph_chain_fd_st(struct object_database *odb,
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
2.56.1.763.g16177fe143.dirty

