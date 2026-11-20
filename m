Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=103.168.172.149
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795177394;
	b=Qz1ThpYUX1/Sf4PEvT3KOZ8iieGdEYQEI++tnU76n2t6l60HODb4n/nySwHA3iXWW/jQ
	 TUB41PBSGxxtuN1UU1tXifsbNEacublJrH1SjixY6Z3o/sdxYQtUl+prz35tt65pA8J9s
	 VZBLw9vG8ybbKGbGyiMa9olALLpF4ZGJXNbriz8mtsymwVqvO6D5Q6N3ndxw6gGRhPThm
	 uuCPTUDymNsx3UzRQr6IIkAeSb3+h7qzAx3gUurdbg+FMgYRYm7bYl9tviK4iWsEFKzWy
	 qDA9HPwAwuIjYbPwWJ0MXIWAjxgylpw0VuVcImK1WtytTeDVlu1pUsc08muCMi1LQmQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795177394;
	h=DMARC-Filter:Received:Received:DKIM-Signature:DKIM-Signature:
	 X-DKIM2-Info:DKIM2-Signature:X-DKIM2-Info:Message-Instance:
	 X-ME-Sender:X-ME-Received:X-ME-Proxy-Cause:X-ME-Proxy:Feedback-ID:
	 Received:Received:From:Date:Subject:MIME-Version:Content-Type:
	 Content-Transfer-Encoding:Message-Id:References:In-Reply-To:To:Cc:
	 X-Mailer;
	bh=+DyIpjz4HkKso37kTtpz8QpM2AbLntZ6+0HoAe92HG8=;
	b=D0xdb17V1KfM43KcdSC/vaUc1coGNYXIie8JrTTeZ3ziwm8w6rARh0IOAa/aIhX7RsfD
	 2S3FfwkPdjbs093AWWKNU1Q0WDDPM7/Mx4im7X8NIP2xOKCQ1Jk+rhyDhVHCb9c6h8ayH
	 KG3cyyxkgE7YocRsAY+XlAJbWDfZQV0udaTeo59cBmwTWH8mHbSGkerj5Z+sC5oTWOgFs
	 OF7054SkzWEc0dHmlzskiJykZsttHiy9b84lptCmTRWAnZ6DYb75RCswLM0S8YxZ8ggBm
	 84xIP7yBuqLozXPsn/R8H2giJmCvdL492OJk1B8s+Jf1C/G+r3qR0fB3mUxmL6IPtMw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=pks.im;
	spf=pass smtp.mailfrom=pks.im;
	dkim=pass header.d=pks.im header.i=@pks.im header.a=rsa-sha256 header.s=fm3 header.b=df2O32DR;
	dkim=pass header.d=messagingengine.com header.i=@messagingengine.com header.a=rsa-sha256 header.s=fm3 header.b=UeyD5sOM;
	arc=none smtp.remote-ip=103.168.172.149
Received: from fout-a6-smtp.messagingengine.com (fout-a6-smtp.messagingengine.com [103.168.172.149])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BDCAF606A320
	for <git@vger.kernel.org>; Fri, 20 Nov 2026 12:23:13 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org BDCAF606A320
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=pks.im header.i=@pks.im header.a=rsa-sha256 header.s=fm3 header.b=df2O32DR;
	dkim=pass (2048-bit key, unprotected) header.d=messagingengine.com header.i=@messagingengine.com header.a=rsa-sha256 header.s=fm3 header.b=UeyD5sOM
Received: from phl-compute-01.internal (phl-compute-01.internal [10.202.2.41])
	by mailfout.phl.internal (Postfix) with ESMTP id B9480EC08F1
	for <git@vger.kernel.org>; Fri, 20 Nov 2026 07:23:12 -0500 (EST)
Received: from phl-frontend-03 ([10.202.2.162])
  by phl-compute-01.internal (MEProxy); Fri, 20 Nov 2026 07:23:12 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm3; t=1795177392;
	 x=1795263792; bh=+DyIpjz4HkKso37kTtpz8QpM2AbLntZ6+0HoAe92HG8=; b=
	df2O32DRc46y0OJ3eqFjE+02UCC10AZg39Pta1alGmqIlmY838EtySJodnmDb8r1
	AgLTtYzw7nnofT5bkg8bhcdTOgx8S7s6Anb9YaILTsJlOP9v2ZJcob8PVpYHznQa
	v5U2tcV/5ZUBKXGecHNois2Mqzfzix383j+6Nw3nP3WVS1562+4zcSemsPImhmL6
	9JIGgi18mfOFJjR15FLufcac2wIjeRRCVjPQ5dKnLxnxwHA0+KXY4SUpuFpSfYvl
	9BdF+qLDToG67gAfBB1eKrZw/2p3UyzRD4mi2jj1PbWD7YCos4rJ1JCE+7N6Nn2K
	2FYcUESroNk1DJfZHolL+A==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1795177392; x=
	1795263792; bh=+DyIpjz4HkKso37kTtpz8QpM2AbLntZ6+0HoAe92HG8=; b=U
	eyD5sOMcSJT0N3eQmAV65AVRwVbH5sJdXm8x9uae4PV1qRUu3wm5DowvObLGyXBT
	1XaB0bBlX+a523bw4uXkfUA7J0mdHv9o3WeaTOkMLMDinQTFJK+70md+MqXW4FKQ
	h8oGXugIgOzNLIchHSU20dQjt3FYZG8mNGQmSM2tGwE+AiXKOOjsuQy6/yOVmCjz
	3BYFDtFjxflcgdZjZwNMcNfcK7dega3TCKNpHl8zsqdwycKnhDF63XvawaeQGupX
	oUE28HgqW9/erbxFgHOahHqoeDt8AafJFT061YYOdhoS2O/jBRaLYP328mFkAjng
	IZ8GWfxQ4Ur7dECD2wjUA==
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-09;
	repo=github.com/dkim2wg/interop; date=2026-11-03; sw=lmtpprox;
	action=sign d=pks.im a=rsa-sha256;
DKIM2-Signature: i=1; m=1; t=1795177392; d=pks.im; mf=PHBzQHBrcy5pbT4=;
	rt=PGdpdEB2Z2VyLmtlcm5lbC5vcmc+;
	s=fm3:rsa-sha256:b4v6PR0x9JoMMpArARvzmcRI/IPqArUuort6zWkZkdybWyk
	GR2OV4gSwlWjz1YI4CPAaiP1TN2lnRCb33Lqa+kx24mRTMjdjO73AF3N/3Qf65Qy
	HUsSdKbzNtOmNNw9L6NsLKa6DGejv+ZQJicPecS3FbCRGzXFFuGMu1O5TykczRzX
	fY2qNm8ey8gBKE020L8Bdp3iEb/mc6zFtQHqNJ9oKsSj4aTfe/czJAHcUN0htejm
	AlJC5mS/y7MZvTvIJm0QTjoSb15g3vDSzonP21bs7WBvfxP4HeD1kLToSGbANCxF
	OjNBczKMHHqH02AKFGkzil2UnRRsmXbMk5dGeDw==;
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-09;
	repo=github.com/dkim2wg/interop; date=2026-11-03; sw=lmtpprox;
	action=mi-m=1; hc=12;
	hn=cc,content-transfer-encoding,content-type,date,feedback-id,
	from,in-reply-to,message-id,mime-version,references,subject,to;
Message-Instance: m=1; h=sha256:VIFa3XE54eilvxxQ6nQ4i5fs4IUIUDowr+FOmtGkJG8=:RkxyV13orByFPU9Rcm8VPN/24MVCFcJxaOjgEi1SvR8=;
X-ME-Sender: <xms:sDsAa-v_063FgILsMmKYgfmkdDE7Bkx4nbmMMKSxEfwuDKcaKS-Shw>
    <xme:sDsAa5e4aArEODPlppq5GdKvdlfA_CVYVG1lTnCXxNqYdbmCVqALIuNkg1u-qyO-J
    QCDKsRm52bsvv2LW5l-mLyOi6UgnjuXeAW6y08x8-xzozJqfFZBV-k>
X-ME-Received: <xmr:sDsAa3Y469X2ozt7LOGi8P6F0CaoVq22ASVYcmotiFpJxs3Zs-BIzDhWq1x2N-Wgol9hwDY>
X-ME-Proxy-Cause: dmFkZTE30M4DhJ6BlHACvgSE3qTozkDJYeVV5N8aECYztHKd+6E8X7EyVKhmUcqZHARQ9G
    ej74kFF9SXDEsQnJvo5KV9xr56t6d7cAr5SC+cvGFgXtwIVM9RNry7YbsVmEwl8iGhUGYE
    i94KEexOvxUB3Xpfp+LqNlCW8iaxnYw1nOhKDw6IvPJZNp69jwBY818qCib3BngrmnpnJ5
    7GRESSQDlu2eh2zQMkObV8nXZWnGxLSicwIhnsgfCcv0yqz5g4qu0XlVibB6OGdKMoRGc/
    hDCA+IMYG5jWIBgOpjbR8IU1dmxYNUIQnl75V1QWBKAUdVL/kuH07PjlVt3ejjqggP1kO6
    PJj2ygKiVkr3ly4eFx7mP5487SG05YI3yeVGFZ5ccHUFZEksTeYqZrjczVCe4L9Aiw2u5h
    xC6mhqHIEaHJXlrpWB50QXsI1jggtsz+4UGQPJObh97mLeL7e5wQpPisHFybSnTYclzkzY
    q+bCwOsbnYDQkFODeC5cnlER15/PZR84Nr7H1HNJ6rrS0f0batHh89YFOWmHRFBLrZ/KaS
    ImcR99KmGpe4GnSYfrCFMEvfSTlwAgehmdl2ivOuojqwTmquJhOcGXMJinPcx+GHctrwFU
    NHfGHjsngZhjWQCcZbn7NxaYUSVmHMNcDolt9P1FvxBPULqg+fku7GC8Frzg
X-ME-Proxy: <xmx:sDsAa0VXg_KpkbsRd9gd9NfKUTdwvzr4X_iN4LJekZzVZv2b7Zlc_g>
    <xmx:sDsAaxiktnVIzFwGxjbTxGn7QQ0pY7lc8W0GED_POIXgUKi_Yn0SMA>
    <xmx:sDsAa6VZ6ekYrgOnAD41bcR09oaK54b12oFuACe20HHRVNfAhJFXCg>
    <xmx:sDsAawMcltRx0Bka6rQi4jA_0ZAFfEcflsn2-SIcwHEX8IPZt-YdCQ>
    <xmx:sDsAa6FftihwHJ8GjRZ7Fcu99reXXP-X390FrBCnybjJQurWWqlEtyZs>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 20 Nov 2026 07:23:11 -0500 (EST)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id ae8f935f (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Fri, 20 Nov 2026 12:23:11 +0000 (UTC)
From: Patrick Steinhardt <ps@pks.im>
Date: Fri, 20 Nov 2026 13:22:51 +0100
Subject: [PATCH v2 3/7] commit-graph: simplify reading a single commit
 graph
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
Message-Id: <20261120-pks-odb-pluggable-commit-graphs-v2-3-31f2341a9932@pks.im>
References: <20261120-pks-odb-pluggable-commit-graphs-v2-0-31f2341a9932@pks.im>
In-Reply-To: <20261120-pks-odb-pluggable-commit-graphs-v2-0-31f2341a9932@pks.im>
To: git@vger.kernel.org
Cc: Junio C Hamano <gitster@pobox.com>
X-Mailer: b4 0.15.2

In a subsequent commit we're about to move the logic to locate commit
graphs and commit graph chains into the object database backend. With
that change, the responsibility of the commit-graph subsystem changes so
that it only provides the functionality to read and write commit graphs,
whereas the backend owns the locations those are read from and written
to.

The function `load_commit_graph_one_fd_st()` is responsible for loading
a single commit graph layer from disk. It receives as input the file
descriptor and the directory it is being read from. While the former
makes sense, the latter doesn't: we already populate the graph's file
name in `load_commit_graph_one()`, so we populate paths in two different
locations.

Besides that, the actual paths are about to become a responsibility of
the backend. So arguably, generic functionality that loads the commit
graph should not be exposed to it.

Stop passing the directory path and instead populate it in
`load_commit_graph_one()`, which will later on be moved into the "files"
backend. While at it, rename `load_commit_graph_one_fd_st()` to
`commit_graph_read()`.

Signed-off-by: Patrick Steinhardt <ps@pks.im>
---
 builtin/commit-graph.c |  2 +-
 commit-graph.c         | 15 +++++++--------
 commit-graph.h         | 12 +++++-------
 3 files changed, 13 insertions(+), 16 deletions(-)

diff --git a/builtin/commit-graph.c b/builtin/commit-graph.c
index 8194a528406..2a5a75dc22f 100644
--- a/builtin/commit-graph.c
+++ b/builtin/commit-graph.c
@@ -111,7 +111,7 @@ static int cmd_commit_graph_verify(int argc,
 	if (opened == OPENED_NONE)
 		return 0;
 	else if (opened == OPENED_GRAPH)
-		graph = load_commit_graph_one_fd_st(repo, dir->abspath, fd, &st);
+		graph = commit_graph_read(repo, fd, &st);
 	else
 		graph = load_commit_graph_chain_fd_st(repo->objects, fd, &st,
 						      &incomplete_chain);
diff --git a/commit-graph.c b/commit-graph.c
index 9e5656992eb..08a151af29a 100644
--- a/commit-graph.c
+++ b/commit-graph.c
@@ -257,9 +257,8 @@ int open_commit_graph(const char *graph_file, int *fd, struct stat *st)
 	return 1;
 }
 
-struct commit_graph *load_commit_graph_one_fd_st(struct repository *repo,
-						 const char *dir,
-						 int fd, struct stat *st)
+struct commit_graph *commit_graph_read(struct repository *repo,
+				       int fd, struct stat *st)
 {
 	void *graph_map;
 	size_t graph_size;
@@ -276,9 +275,7 @@ struct commit_graph *load_commit_graph_one_fd_st(struct repository *repo,
 	close(fd);
 
 	ret = commit_graph_parse(repo, graph_map, graph_size);
-	if (ret)
-		ret->dir = absolute_pathdup(dir);
-	else
+	if (!ret)
 		munmap(graph_map, graph_size);
 
 	return ret;
@@ -508,9 +505,11 @@ static struct commit_graph *load_commit_graph_one(struct repository *repo,
 	if (!open_ok)
 		return NULL;
 
-	g = load_commit_graph_one_fd_st(repo, dir, fd, &st);
-	if (g)
+	g = commit_graph_read(repo, fd, &st);
+	if (g) {
+		g->dir = absolute_pathdup(dir);
 		g->filename = absolute_pathdup(graph_file);
+	}
 
 	return g;
 }
diff --git a/commit-graph.h b/commit-graph.h
index f0e7cc93461..8660c7fe698 100644
--- a/commit-graph.h
+++ b/commit-graph.h
@@ -117,14 +117,12 @@ struct commit_graph {
 };
 
 /*
- * Load commit graphs from the given object directory `dir`. The directory may
- * be given as a relative path; it is canonicalized internally so that graphs
- * loaded from the same directory compare equal regardless of how the caller
- * spelled the path.
+ * Read a single commit graph layer from the given file descriptor. The file
+ * descriptor will be closed regardless of whether loading succeeds. Returns
+ * NULL on error.
  */
-struct commit_graph *load_commit_graph_one_fd_st(struct repository *repo,
-						 const char *dir,
-						 int fd, struct stat *st);
+struct commit_graph *commit_graph_read(struct repository *repo,
+				       int fd, struct stat *st);
 struct commit_graph *load_commit_graph_chain_fd_st(struct object_database *odb,
 						   int fd, struct stat *st,
 						   int *incomplete_chain);

-- 
2.56.1.831.g720f3f5937.dirty

