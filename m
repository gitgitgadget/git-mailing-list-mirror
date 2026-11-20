Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=103.168.172.149
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795177403;
	b=QfmLvVW8waoOAhI7AJQRpdaKFZg0/dC5q+7kMRVX+stxODG53gQmgnpDLoxaVxkEvd0G
	 xCr4gWf+0vO5h5KhIb29ScjVvklltyWkI3F32BUDaNIIB/mSvKcZlxBm/Mm3zby93tihj
	 Lh/PM8F0o7HYGX8R4MFeekA0n5sTtlzkUv7hPoUBv1CNoJmP9/MUuwB8nyuL/nwMDIa8U
	 d1gtkjmprG3Kq/OV5QuktwpyRL24N3F1xk2udv05udBfBid4Q1dHldq1rnExyw21WA94b
	 d1jDH0gJArwCsSYIXWRvoHzTGRCWlyUkkvKGkV/hxC36dfRVlXpd9R0Smsv4qEgPFIQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795177403;
	h=DMARC-Filter:Received:Received:DKIM-Signature:DKIM-Signature:
	 X-DKIM2-Info:DKIM2-Signature:X-DKIM2-Info:Message-Instance:
	 X-ME-Sender:X-ME-Received:X-ME-Proxy-Cause:X-ME-Proxy:Feedback-ID:
	 Received:Received:From:Date:Subject:MIME-Version:Content-Type:
	 Content-Transfer-Encoding:Message-Id:References:In-Reply-To:To:Cc:
	 X-Mailer;
	bh=ruPKsyw3c4CuNFLYHwC8G9ZkQ1FfquxrJ/N+oA0XhnI=;
	b=n+KBzbM7ARGPirz+iOKbsDSU+t6TAlfSkImQT94uCLszP0W+RwDih64w/oxgbVb+dGAU
	 7FcVOINiDx80bgk/1FoVu4IRcoy7SH0BrVSN0Ki18O2hsjeFH3dv85s3OOPoX4gQcGWSK
	 gaT0C0AUz2sf23amjVcaQUdzDnLXnoCLyi13+D7NK1e77hJFdHRDC6w2/NQySCi25RR8A
	 nYg+GOkGNteE1Rt38uBF4b9Fmuw95JSnYkDX+3/QViaj57wEtPI0JBNs0/43rObrn4b25
	 Lm9OF5e06tGvKqryGgwOB6SDHrXzn2cJs92+64fUlZO/s6HhhbPMXFgDyimHdz8F94Q==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=pks.im;
	spf=pass smtp.mailfrom=pks.im;
	dkim=pass header.d=pks.im header.i=@pks.im header.a=rsa-sha256 header.s=fm3 header.b=xkjcK3Hy;
	dkim=pass header.d=messagingengine.com header.i=@messagingengine.com header.a=rsa-sha256 header.s=fm3 header.b=JBTVdJVA;
	arc=none smtp.remote-ip=103.168.172.149
Received: from fout-a6-smtp.messagingengine.com (fout-a6-smtp.messagingengine.com [103.168.172.149])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3835A606A325
	for <git@vger.kernel.org>; Fri, 20 Nov 2026 12:23:23 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 3835A606A325
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=pks.im header.i=@pks.im header.a=rsa-sha256 header.s=fm3 header.b=xkjcK3Hy;
	dkim=pass (2048-bit key, unprotected) header.d=messagingengine.com header.i=@messagingengine.com header.a=rsa-sha256 header.s=fm3 header.b=JBTVdJVA
Received: from phl-compute-01.internal (phl-compute-01.internal [10.202.2.41])
	by mailfout.phl.internal (Postfix) with ESMTP id 5EA8DEC08F1
	for <git@vger.kernel.org>; Fri, 20 Nov 2026 07:23:22 -0500 (EST)
Received: from phl-frontend-03 ([10.202.2.162])
  by phl-compute-01.internal (MEProxy); Fri, 20 Nov 2026 07:23:22 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm3; t=1795177402;
	 x=1795263802; bh=ruPKsyw3c4CuNFLYHwC8G9ZkQ1FfquxrJ/N+oA0XhnI=; b=
	xkjcK3Hyq+ZEIAQJaF4BbOCGv71Zsc66hDyRcvedjkKgbTEFS+XxIX29sZoZxMX6
	ASg14X66HzeQ9flMdV7MT+au+e1skXM/R/4tEyVy59wlcFxzRCJra9hBX10WMJZG
	T/1xSjCv2sh1WRjjMxB+eQjRtlKBQKYJ3+KXSWLycSzy6TtaE74DjSvuRey9gxrp
	Z/0kuKrWft+b4CuIOgaVmO8wO3BV8mGkuH5yuYuymgFjYv1bwpC/xO6Zc0/lBwrw
	gSW6ccgWAhU26N5mMTiz4ZLUy9MFXaDzmwFGLpdxgYUu6FJYjHh6Vu/NWB6Y2CVh
	F/CDwED3/0dAtXQF/OXr3A==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1795177402; x=
	1795263802; bh=ruPKsyw3c4CuNFLYHwC8G9ZkQ1FfquxrJ/N+oA0XhnI=; b=J
	BTVdJVAm1+MfNXCSNjq2PHx4150LVFGrqIwJJ4SA5ZvGWvqr4h5wQGEomiy10g8u
	EbhU4CIc592sZg4CDHLT3wJF43ggAgqpdd6egGM6CRREaVvxmTWWFeMGdmC41rkV
	3tLzTMufowBBWlCVp7EW29lfWqi/JuUNoLn12ODBbaY9VMzNxgKHdiEDQ+RaPS4o
	ZA2/fGqPgAJFxBw6hiLx1cbceXcqd/N33wxSaNNMMFe+r7QX8rSA0jjzdYxj8nA6
	MhxuqxH0v1S95Rxbi6paYAYGQ3nRa7BRfBSXiG81/O1oYBz6ROqiqnQmygKc65Q7
	6otIXsDlLx7DhnhQbSNwg==
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-09;
	repo=github.com/dkim2wg/interop; date=2026-11-03; sw=lmtpprox;
	action=sign d=pks.im a=rsa-sha256;
DKIM2-Signature: i=1; m=1; t=1795177402; d=pks.im; mf=PHBzQHBrcy5pbT4=;
	rt=PGdpdEB2Z2VyLmtlcm5lbC5vcmc+;
	s=fm3:rsa-sha256:KYeDNaHWU0z3bWS1trFP2DyeW2wo+4qVXzdjg1mM/G+WVuA
	A7mNquz5FsdjQ96Jv1NiYt4TWWXEPgiLuhniItFu6VffwRjkyoMr4CwMOYSHvLvI
	QYyy0mP8QVH62xhN7MTM3LgFO1GS9ryNvwfis5rbWekhwVFuBggMiOQvFpS3yTjC
	xp3vY8u5aCbH+G52id5jRjs0W3tqhtPKScgzfq0igczCGb5X+BonKfiEVdzUpzj6
	PRU0GD6qVtjFPDr0WHJMmUk1lbDvaBbIKHd2hhtIZEhjg9r7715otmhBkMKGSlKr
	xAbvSHQUit8I4Tfz2NX80Se8xzk5x7+MHKR6Sug==;
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-09;
	repo=github.com/dkim2wg/interop; date=2026-11-03; sw=lmtpprox;
	action=mi-m=1; hc=12;
	hn=cc,content-transfer-encoding,content-type,date,feedback-id,
	from,in-reply-to,message-id,mime-version,references,subject,to;
Message-Instance: m=1; h=sha256:rHk5rT9oKOOjVQ1kSd+XaL5EOd3/MNuBgpa1+COADo0=:7FOUDsyfzqSJ6FZ6FZu4IfKTe9wbT9r9rFxDmtN6oyY=;
X-ME-Sender: <xms:ujsAawRdJ9VzzF8ldkTsAnf-RAimYrsebLs4P_Fs9Pr5QJmZ-Xaalg>
    <xme:ujsAazzSly9ADoXe75T0zja2Ew8Qx2HxuxPEt1rWYZnpxYpQXZSvt-0dNQu_ZiOhe
    lRPkB7EdZn_g4k5y5x_QXvPysNnECnOrg_r7fJuyP5GyCLC3YOsEiw>
X-ME-Received: <xmr:ujsAa7dhH7b0WpWIlTkRTgt-0jh0pCiKwx6bMB4HtXkrn45ciYjgtCWpFinkpJ0BllGsfBM>
X-ME-Proxy-Cause: dmFkZTEZNt7M3JXGz8Rq/NfenXBeR+j+thvlV8UjDLU6wMBPSqPvFwnOirkVJI41TWvjze
    qdCpPCxgTUkEDCsoFiWBR6QTkwcvz+aJ8XeIjxxelXoUutBmnMBiZarMjcggP9boeOpt+B
    TyrJ7nqwYVccnIFJ003aoXlYe9rJBBPzymvR2Q+3E4H0jlAflIDW5XAwrgmUDwgagT8run
    uWD7A8CEgWuEWGqlzYBWnBtj1G0sJIsFICA+3okRtiAdfOWTpbyk/5TbFRzHxQ3wf4cveT
    BI0zACaZbjXWwjC991vJcw/FRa/q6yCgoLnQcf4QRWw7j7qnzLIrbnXzsLQLLHNPaYCZqi
    b67G2fq40tD7JHzAtnXfsd1pZrZg+aDu+Xn9cWY+N4ht25LHKRQGRObX7bMJP6janoNdOx
    DWDJjWNRl2F1L+9tBL4hESIf8m/v6rumQbW1nm+ofzq2rZX18EB0BcOzVZkDRL+QIQsuX0
    0WHjfRNPn1MPHVZTAgN9088Df7W6ZNbvL+PnglhXyhz0LpAz8ZsQdOY0ec8uBMrpKSlw3W
    dRAQckIS/RZJKG/tQrmTZIVr6q0lK5O4KeL51p9wCysPgfu0Yq+7b/tHfpjO3Ar2EvCnQx
    ytVhIF1n4oaDAo1hxvAmDveMMlXYBlfrI/c1ObIPINt/1ubyy9doi4LVp20w
X-ME-Proxy: <xmx:ujsAa_JNtau73s07mQGUeTGkG-LCR8NIBWLpU5HjNiOFJ00tRjFnBw>
    <xmx:ujsAa8EZGKFKj3gSzts8OVeblA04u87sMXfW08YDxVWicyUWPRZnGA>
    <xmx:ujsAa5pI6veFxzX1qnjurntdcUeaNMwZzGWIuHuOEfmG6_xYVoafJw>
    <xmx:ujsAa1T4h2HNNfbTmFnaQpvaEWzxZNyFun0CGpmPTLR_aiX_ZoVgnw>
    <xmx:ujsAazo9I2d137y4zl8KGhWRYpm0i8cH_A1CRjIhiqYFqhL1gB9ZNW2a>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 20 Nov 2026 07:23:21 -0500 (EST)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id e335ab99 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Fri, 20 Nov 2026 12:23:20 +0000 (UTC)
From: Patrick Steinhardt <ps@pks.im>
Date: Fri, 20 Nov 2026 13:22:54 +0100
Subject: [PATCH v2 6/7] commit-graph: introduce common exit for
 `write_commit_graph_file()`
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
Message-Id: <20261120-pks-odb-pluggable-commit-graphs-v2-6-31f2341a9932@pks.im>
References: <20261120-pks-odb-pluggable-commit-graphs-v2-0-31f2341a9932@pks.im>
In-Reply-To: <20261120-pks-odb-pluggable-commit-graphs-v2-0-31f2341a9932@pks.im>
To: git@vger.kernel.org
Cc: Junio C Hamano <gitster@pobox.com>
X-Mailer: b4 0.15.2

In the next commit we're going to refactor `write_commit_graph_file()`.
As part of that refactoring we'll perform a couple more allocations in
this function that need to be cleaned up on exit.

Prepare for this by introducing a common exit path now already, as that
will make the diff a tiny bit easier to read.

Signed-off-by: Patrick Steinhardt <ps@pks.im>
---
 commit-graph.c | 34 +++++++++++++++++++---------------
 1 file changed, 19 insertions(+), 15 deletions(-)

diff --git a/commit-graph.c b/commit-graph.c
index ff2a5cbcbac..59adf4cae4a 100644
--- a/commit-graph.c
+++ b/commit-graph.c
@@ -2105,6 +2105,7 @@ static int write_commit_graph_file(struct write_commit_graph_context *ctx)
 	struct strbuf progress_title = STRBUF_INIT;
 	struct chunkfile *cf;
 	unsigned char file_hash[GIT_MAX_RAWSZ];
+	int ret;
 
 	if (ctx->opts->flags & COMMIT_GRAPH_WRITE_SPLIT) {
 		struct strbuf tmp_file = STRBUF_INIT;
@@ -2118,9 +2119,9 @@ static int write_commit_graph_file(struct write_commit_graph_context *ctx)
 	}
 
 	if (safe_create_leading_directories(ctx->r, ctx->graph_name)) {
-		error(_("unable to create leading directories of %s"),
-			ctx->graph_name);
-		return -1;
+		ret = error(_("unable to create leading directories of %s"),
+			    ctx->graph_name);
+		goto out;
 	}
 
 	if (ctx->opts->flags & COMMIT_GRAPH_WRITE_SPLIT) {
@@ -2132,14 +2133,14 @@ static int write_commit_graph_file(struct write_commit_graph_context *ctx)
 
 		graph_layer = mks_tempfile_m(ctx->graph_name, 0444);
 		if (!graph_layer) {
-			error(_("unable to create temporary graph layer"));
-			return -1;
+			ret = error(_("unable to create temporary graph layer"));
+			goto out;
 		}
 
 		if (adjust_shared_perm(ctx->r, get_tempfile_path(graph_layer))) {
-			error(_("unable to adjust shared permissions for '%s'"),
-			      get_tempfile_path(graph_layer));
-			return -1;
+			ret = error(_("unable to adjust shared permissions for '%s'"),
+				    get_tempfile_path(graph_layer));
+			goto out;
 		}
 
 		f = hashfd(ctx->r->hash_algo,
@@ -2233,8 +2234,8 @@ static int write_commit_graph_file(struct write_commit_graph_context *ctx)
 		int result;
 
 		if (!chainf) {
-			error(_("unable to open commit-graph chain file"));
-			return -1;
+			ret = error(_("unable to open commit-graph chain file"));
+			goto out;
 		}
 
 		if (ctx->base_graph_name) {
@@ -2249,8 +2250,8 @@ static int write_commit_graph_file(struct write_commit_graph_context *ctx)
 				result = rename(ctx->base_graph_name, dest);
 
 				if (result) {
-					error(_("failed to rename base commit-graph file"));
-					return -1;
+					ret = error(_("failed to rename base commit-graph file"));
+					goto out;
 				}
 			}
 		} else {
@@ -2273,14 +2274,17 @@ static int write_commit_graph_file(struct write_commit_graph_context *ctx)
 			fprintf(get_lock_file_fp(&lk), "%s\n", ctx->commit_graph_hash_after[i]);
 
 		if (result) {
-			error(_("failed to rename temporary commit-graph file"));
-			return -1;
+			ret = error(_("failed to rename temporary commit-graph file"));
+			goto out;
 		}
 	}
 
 	commit_lock_file(&lk);
+	ret = 0;
 
-	return 0;
+out:
+	rollback_lock_file(&lk);
+	return ret;
 }
 
 static void split_graph_merge_strategy(struct write_commit_graph_context *ctx,

-- 
2.56.1.831.g720f3f5937.dirty

