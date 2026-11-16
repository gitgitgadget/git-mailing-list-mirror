Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=103.168.172.159
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794834499;
	b=NSbZqOfyV+LJkDELuD/UUfTNct1FfqbrruulEEBsIOZeN0Stpa3T4sQC8hIgLOcPfPMr
	 EJ0mYodqTqmdpSDLVRh8+v//aGx1BIwoadIyToWfOnnAJt3rlQqoVVbSxqz4pvvD3kJIC
	 7YRKdaB9bQb6KR+vbGxlHWLAknj3k8izrAmIb6DAXJb/IFpGYEPEnO/xn1Cac7xA6jgoE
	 4eqPMOl5PvX1pLUfyuzXUDgLGZi8pYLFT4Eq0ju/9kBiwLvYoaYnChmuudriXC31D6xGp
	 Yo4DmQEoHrt71/VKJtaip4R2UYzaksF6ApJm61ZiBIx9QRnLSXBAso2VrTPC3b+J/9Q==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794834499;
	h=DMARC-Filter:Received:Received:DKIM-Signature:DKIM-Signature:
	 X-DKIM2-Info:DKIM2-Signature:X-DKIM2-Info:Message-Instance:
	 X-ME-Sender:X-ME-Received:X-ME-Proxy-Cause:X-ME-Proxy:Feedback-ID:
	 Received:Received:From:Date:Subject:MIME-Version:Content-Type:
	 Content-Transfer-Encoding:Message-Id:References:In-Reply-To:To:Cc:
	 X-Mailer;
	bh=2dBECUjAn+ExjpfW+GmrWnf6g9n0+QdoTevjWyMuFtk=;
	b=S16D+izAAVoEDjBXbzLQYPn9vyK5mmW+agGkffv8jZIHZKfYNC4ny10RNrmWtg2MvfF1
	 XgUeCl0kVb63+aCGP+H53V/umhCYph4jWyFJMnc7NRuTQv+2bbLG044bFhjh+acGBSHRc
	 Wb9hZgJizTRhEJmrIp3wDurKzTDbJ1cvRcjYRnETvQI7xK+cA/idcGU+m4Jevb8vuePQm
	 MXQBJNrQ1A8ZxKHQp17VLXivpDKxUOFOWlCj++I3AbMpzoam2cqY0zEMzv4fA57PxZ+oN
	 xDkOWf3ABDkyQKPfyH2dTCzUG6RNKHGHLc2UvvOq8z30XvfS0IEDB2rZfrVUOrrF2OA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=pks.im;
	spf=pass smtp.mailfrom=pks.im;
	dkim=pass header.d=pks.im header.i=@pks.im header.a=rsa-sha256 header.s=fm3 header.b=IYs6wFRC;
	dkim=pass header.d=messagingengine.com header.i=@messagingengine.com header.a=rsa-sha256 header.s=fm3 header.b=KVECQ3zI;
	arc=none smtp.remote-ip=103.168.172.159
Received: from fhigh-a8-smtp.messagingengine.com (fhigh-a8-smtp.messagingengine.com [103.168.172.159])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0818A606A32F
	for <git@vger.kernel.org>; Mon, 16 Nov 2026 13:08:18 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 0818A606A32F
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=pks.im header.i=@pks.im header.a=rsa-sha256 header.s=fm3 header.b=IYs6wFRC;
	dkim=pass (2048-bit key, unprotected) header.d=messagingengine.com header.i=@messagingengine.com header.a=rsa-sha256 header.s=fm3 header.b=KVECQ3zI
Received: from phl-compute-06.internal (phl-compute-06.internal [10.202.2.46])
	by mailfhigh.phl.internal (Postfix) with ESMTP id 3F8B61400043
	for <git@vger.kernel.org>; Mon, 16 Nov 2026 08:08:18 -0500 (EST)
Received: from phl-frontend-03 ([10.202.2.162])
  by phl-compute-06.internal (MEProxy); Mon, 16 Nov 2026 08:08:18 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm3; t=1794834498;
	 x=1794920898; bh=2dBECUjAn+ExjpfW+GmrWnf6g9n0+QdoTevjWyMuFtk=; b=
	IYs6wFRCZM2qtv/p7/lHl4aM0d+8n4Hz91FeX/50WM5RXp6js6ql/Iga+QHBoAkq
	cldcXzlUA+gdYfcfYk4XZV6xNWaWJrl4TaQd7jNQ/PhPYKRxO87E/18hr45JDQJJ
	6Ly4gWJ/LAkIpyGAmVpKSLj3ef7KosOjccVBU1aGEJxoR/JQr7WnYis+hg9J/ue3
	5CKiJIqkW0XW/AbL5WLZHuXWNvv8pCTxXOeDhR33Nh+uyX4oOFmY71q8rJxXPbev
	qr2DLG0QnvHSDHNZY7H+pY9j4u3y/OoNK+7+dWVVi4MUjUNDZfhNnU6CGQhoeY+v
	RKbMuzEfLcu765yvfyHtkA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1794834498; x=
	1794920898; bh=2dBECUjAn+ExjpfW+GmrWnf6g9n0+QdoTevjWyMuFtk=; b=K
	VECQ3zIf3IidaAljT3c0rOoQWllcmuisSU1RLtUE/kGv9AgWaru9tmYHM5hkUQQB
	6TjrvDQagdbY18fJWEigTGuR9NTuNEupheJkqNRs1dckZiJ4M49GQI8YOzmVzied
	i3pFD8hDimfsdX9TpHrW28Sm1KzQRLo8TRDQItYBo8awvixCc2PTSRu0ePB/3pDF
	QuSPJt7z3oAdcVk0dAyEVHCa5SrLpVn3IkBBQmBCIl/SmQGc7sUJSG/SG7Y8PvrR
	XmZ1KiIERsxahol5KKO6f3RQI4qhsVU9FcyvAerE4p83UTNhwiNf9VbCQJSlTd7l
	gSiZRIH2KDWQ4ZIwlg2/Q==
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-09;
	repo=github.com/dkim2wg/interop; date=2026-11-03; sw=lmtpprox;
	action=sign d=pks.im a=rsa-sha256;
DKIM2-Signature: i=1; m=1; t=1794834498; d=pks.im; mf=PHBzQHBrcy5pbT4=;
	rt=PGdpdEB2Z2VyLmtlcm5lbC5vcmc+;
	s=fm3:rsa-sha256:nLodhQ08a6N4PocPYHYYRDvrBuVRzGnSkbzQD5gaN8FtV9x
	vE201QfYyI3YeS9Zs+tepFySbJjzUyFxm3xoeYdFT3vxShceUnHNyYeEHaTOvQm8
	5qQeMLP02WeI6mmn6IdRomSmaQK5Q1tf1eI0Vi/4wfNd6OrYxQmNcPDymau/Mj6c
	EQWCosMnwJwqNr/0FROvQoBPLQbB98wK3Cpg7pQbQYfk50W4XxnGoUeILlJNg3lX
	bVPvr7Zoh9AEPAGrWqdU6yktnXRo/VZvZsgd/llPqQSP5zP+/0MNUTSSgGi1oG3J
	dyo+pqWZeeFnwfTlopERozuV1Qzdsu5hjBfjLYw==;
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-09;
	repo=github.com/dkim2wg/interop; date=2026-11-03; sw=lmtpprox;
	action=mi-m=1; hc=12;
	hn=cc,content-transfer-encoding,content-type,date,feedback-id,
	from,in-reply-to,message-id,mime-version,references,subject,to;
Message-Instance: m=1; h=sha256:aS+ampVWRiUkSOeqfe1WYZ9EmyvYHC37BjTCAqZN3Z4=:Lr1KJkGQvXXQbr3snuHXkPoi6S5MgmygPOmM9R+fPWE=;
X-ME-Sender: <xms:QgD7ajZ5Ae_N5yJZDISNgYhF_aYKL2qXETY4GvbcOQWEF5FatJ0EHg>
    <xme:QgD7apU0707oxuulX0Z629W_0V2cmX_y3ySoBYYR_pRiAgO2oKVZ6wxplbtsAvTsN
    CPvK7D_Im4l0FwSV1UDPyaQBZ_kkTMcZgWlRlnnOq5dRWbL0yWKMik>
X-ME-Received: <xmr:QgD7armslbDGlBWTKSop4dH0C_vLj4Ku2mUIahZopk9cgMu3VlxW-TdE_ADA_m0uu-BY4lk>
X-ME-Proxy-Cause: dmFkZTGziUKUgJYsbiHWfb5HWuWorQnHHq6YP0ByYpkZ6e9sVItzSNrjxVNiJjpykGt6EH
    +Wo+jZCDwFt+/bcnf++syQUvL1OVsCKhGqPwr3BK64IVWifW0xci0pdI+2+/Q2cKlJ86Bw
    MPjq5Gxm3EfNjPHHZxB/qKmy2lYBxm28RGRVDzQY/DL8x0mrFRQC08IpgtrlSdKQSvTTzK
    jI4Dzrh8Ro4PE+97yI0qzoNNhqp2HeoBh5o/zQx/r+4v+GKIjmbaBlrMKGm2iApi+hz2OH
    ZU0TLEDo5HjB+hj+++nQGClhpGKhIpSL+UXhvZrJuTSG26O5MqYj9dLI/adyQM7bNfpGaW
    Q+esMKV2CPbrwKWZuTX+zIg0I3TMVv5YL0isaSuak9xnvSHlAP5wd6H7NhyMW70l07BPdr
    IBcbfYQ4ms9KopYFthgo/tFumV+7DWO+FdA3vzwrDfxApGdWPcDop8XhMB18mmjoTPZThI
    7ni0xHcUIWkPb2Dfbclz24ZQ865CkGotXMQob0TrHNpXZMTtlmRRxmFtRKnH0VBBlKbo4/
    +vXH7yG36LCdCeMTRkHsOoZVjDIWmNy1mNS9ab2sb+9ORjrMKEStxCv8zXyDyCOMPAY1lp
    xlCF/u83S+FSe3oiECjOYf8/dHl10t859PgvBkJcS2muykabiGovKEuVWgcg
X-ME-Proxy: <xmx:QgD7auxB6rn7HGB0Zz9W747TeYPd8KYmgmvgbrsPEPtiEQ_k0lgcQQ>
    <xmx:QgD7augOra7twJrUYb4CaHxQoBzGRpYC7knZKDQIJE1MAlnR0Npb0g>
    <xmx:QgD7arW1norXdUUZFhgENmpUNNVDKcR-DajnBtJZhPeRwUek1UyFzg>
    <xmx:QgD7ao0FryQAbDk-j29kpYX02XR3M5_tmuJLKUn9T9zf0f0iLlN0eA>
    <xmx:QgD7al7k4skAtdrsYrGRmlfAeShfRU_HUVcgpFxcxUcxGOwG3_6tVG8T>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA for
 <git@vger.kernel.org>; Mon, 16 Nov 2026 08:08:17 -0500 (EST)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id 6cae73b1 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO)
	for <git@vger.kernel.org>;
	Mon, 16 Nov 2026 13:08:17 +0000 (UTC)
From: Patrick Steinhardt <ps@pks.im>
Date: Mon, 16 Nov 2026 14:07:45 +0100
Subject: [PATCH 09/12] commit-graph: mark incomplete commit graph chains
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
Message-Id: <20261116-pks-odb-pluggable-commit-graphs-v1-9-a83fc1ff0808@pks.im>
References: <20261116-pks-odb-pluggable-commit-graphs-v1-0-a83fc1ff0808@pks.im>
In-Reply-To: <20261116-pks-odb-pluggable-commit-graphs-v1-0-a83fc1ff0808@pks.im>
To: git@vger.kernel.org
Cc: 
X-Mailer: b4 0.15.2

When loading a commit graph chain it may happen that we only find a
subset of its layers. Such a commit graph is still usable though in the
case where we have the base and layers building on top of it, so we
still return such an incomplete commit graph to the caller.

While valid and usable, we of course want to warn about such commit
graphs in `git commit-graph verify`, which is why there is an
`incomplete` out-parameter in `load_commit_graph_chain_fd_st()`. In a
subsequent commit though we want to hide this function in favor of a
pluggable interface, but carrying such a flag there feels wrong.

Instead, have the function set a new `incomplete` field in the commit
graph structure itself.

Signed-off-by: Patrick Steinhardt <ps@pks.im>
---
 builtin/commit-graph.c | 9 ++++-----
 commit-graph.c         | 9 ++++-----
 commit-graph.h         | 4 ++--
 3 files changed, 10 insertions(+), 12 deletions(-)

diff --git a/builtin/commit-graph.c b/builtin/commit-graph.c
index 2a5a75dc22f..5ecce4b6caa 100644
--- a/builtin/commit-graph.c
+++ b/builtin/commit-graph.c
@@ -66,7 +66,6 @@ static int cmd_commit_graph_verify(int argc,
 	enum commit_graph_verify_flags flags = isatty(2) ? COMMIT_GRAPH_VERIFY_PROGRESS : 0;
 	int fd;
 	struct stat st;
-	int incomplete_chain = 0;
 	int ret;
 	struct option options[] = {
 		OPT_BIT(0, "shallow", &flags,
@@ -113,20 +112,20 @@ static int cmd_commit_graph_verify(int argc,
 	else if (opened == OPENED_GRAPH)
 		graph = commit_graph_read(repo, fd, &st);
 	else
-		graph = load_commit_graph_chain_fd_st(repo->objects, fd, &st,
-						      &incomplete_chain);
+		graph = load_commit_graph_chain_fd_st(repo->objects, fd, &st);
 
 	if (!graph)
 		return 1;
 
 	ret = commit_graph_verify(graph, flags);
-	commit_graph_free(graph);
 
-	if (incomplete_chain) {
+	if (graph->incomplete) {
 		error("one or more commit-graph chain files could not be loaded");
 		ret |= 1;
 	}
 
+	commit_graph_free(graph);
+
 	return ret;
 }
 
diff --git a/commit-graph.c b/commit-graph.c
index 7bb6b112b2e..0ae9f586f21 100644
--- a/commit-graph.c
+++ b/commit-graph.c
@@ -651,8 +651,7 @@ int open_commit_graph_chain(const char *chain_file,
 }
 
 struct commit_graph *load_commit_graph_chain_fd_st(struct object_database *odb,
-						   int fd, struct stat *st,
-						   int *incomplete_chain)
+						   int fd, struct stat *st)
 {
 	struct commit_graph *graph_chain = NULL;
 	struct strbuf line = STRBUF_INIT;
@@ -703,11 +702,12 @@ struct commit_graph *load_commit_graph_chain_fd_st(struct object_database *odb,
 	}
 
 	commit_graph_validate_chain(graph_chain);
+	if (graph_chain)
+		graph_chain->incomplete = !valid;
 
 	fclose(fp);
 	strbuf_release(&line);
 
-	*incomplete_chain = !valid;
 	return graph_chain;
 }
 
@@ -720,9 +720,8 @@ static struct commit_graph *load_commit_graph_chain(struct repository *repo,
 	struct commit_graph *g = NULL;
 
 	if (open_commit_graph_chain(chain_file, &fd, &st, repo->hash_algo)) {
-		int incomplete;
 		/* ownership of fd is taken over by load function */
-		g = load_commit_graph_chain_fd_st(repo->objects, fd, &st, &incomplete);
+		g = load_commit_graph_chain_fd_st(repo->objects, fd, &st);
 	}
 
 	free(chain_file);
diff --git a/commit-graph.h b/commit-graph.h
index 1cc0d097321..3b5e0eb2d73 100644
--- a/commit-graph.h
+++ b/commit-graph.h
@@ -93,6 +93,7 @@ struct commit_graph {
 	struct object_id oid;
 	char *dir;
 	char *filename;
+	bool incomplete;
 
 	uint32_t num_commits_in_base;
 	unsigned int read_generation_data;
@@ -124,8 +125,7 @@ struct commit_graph {
 struct commit_graph *commit_graph_read(struct repository *repo,
 				       int fd, struct stat *st);
 struct commit_graph *load_commit_graph_chain_fd_st(struct object_database *odb,
-						   int fd, struct stat *st,
-						   int *incomplete_chain);
+						   int fd, struct stat *st);
 
 /*
  * Link the commit graph layer `g` on top of the chain `base`. `base` may be

-- 
2.56.1.763.g16177fe143.dirty

