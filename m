Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=103.168.172.159
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794834488;
	b=Jv56C6pe5I7Whx8N8f3Pr+rQECQ2m6ZK4EYF5Jnp/XKi7O1ySTBk80jfNZ7ELcL4cQjz
	 EbuKSXpaV7NzMV+R47igg1OgUi6l7sIM2+f295H/qwIAMc6II1TpatGs17TUJzWivA0nS
	 mpiy35jWJ3x23MH2WvTqS3OWqgHCM9Fa6m0CMUaPnYY1w699+dKLp8k3Bobn9rQ2POSa3
	 nSQ0GENjvO9YowV0KfsgZoDrYEZa9aVzaa5t3e+QuSRXFhN6ksln9vWV+sAK9HHDRZ+PO
	 CStUzlgvd4QCxNYDkkzBdkE4II6BURWFbYjYVqEgIRVNHohTqgoILySWgsW7eASa7Sw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794834488;
	h=DMARC-Filter:Received:Received:DKIM-Signature:DKIM-Signature:
	 X-DKIM2-Info:DKIM2-Signature:X-DKIM2-Info:Message-Instance:
	 X-ME-Sender:X-ME-Received:X-ME-Proxy-Cause:X-ME-Proxy:Feedback-ID:
	 Received:Received:From:Date:Subject:MIME-Version:Content-Type:
	 Content-Transfer-Encoding:Message-Id:References:In-Reply-To:To:Cc:
	 X-Mailer;
	bh=Tq174/jVsp9gUc8NbvDbcJBHJSHuiZrk4erR7h7AM6o=;
	b=DNbzmd1sx1mzbKi4KKZkut4XYl3LbWspeEOcOmq0p88kz8I+r16zDpOBOBY/VlKue9QY
	 rKa9Zdqjx1UOydpqN/ZY4UqPa2L0zsGFshz4miFeGYbm5DEga3bNQvoNWXBdgYAwxQm18
	 RDhCYVy9a7ZkolV9vFCHK28uXnW2zEemRmk9ion2ab1v3Zc65lnb1KprzL+H2MjE5g+g9
	 8E7s041edC3gobiNPVdOPyObi7bpqcDJYNrqiNeWgwOt3lhU/WTzilBHPrpkZjpXO614J
	 5qPyQs5v44RHnSbb9roVJHKbu02HNbu6K9pqonNghjTGuXjaanp8i/lF6OVNZDBvoJQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=pks.im;
	spf=pass smtp.mailfrom=pks.im;
	dkim=pass header.d=pks.im header.i=@pks.im header.a=rsa-sha256 header.s=fm3 header.b=nuvRJtcS;
	dkim=pass header.d=messagingengine.com header.i=@messagingengine.com header.a=rsa-sha256 header.s=fm3 header.b=aipuOFm9;
	arc=none smtp.remote-ip=103.168.172.159
Received: from fhigh-a8-smtp.messagingengine.com (fhigh-a8-smtp.messagingengine.com [103.168.172.159])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2F504606A338
	for <git@vger.kernel.org>; Mon, 16 Nov 2026 13:08:07 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 2F504606A338
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=pks.im header.i=@pks.im header.a=rsa-sha256 header.s=fm3 header.b=nuvRJtcS;
	dkim=pass (2048-bit key, unprotected) header.d=messagingengine.com header.i=@messagingengine.com header.a=rsa-sha256 header.s=fm3 header.b=aipuOFm9
Received: from phl-compute-01.internal (phl-compute-01.internal [10.202.2.41])
	by mailfhigh.phl.internal (Postfix) with ESMTP id 2DD5F1400044
	for <git@vger.kernel.org>; Mon, 16 Nov 2026 08:08:07 -0500 (EST)
Received: from phl-frontend-03 ([10.202.2.162])
  by phl-compute-01.internal (MEProxy); Mon, 16 Nov 2026 08:08:07 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm3; t=1794834487;
	 x=1794920887; bh=Tq174/jVsp9gUc8NbvDbcJBHJSHuiZrk4erR7h7AM6o=; b=
	nuvRJtcSxO+FeEwzyfSM1ZuEQTh5HxzopFu1D98KktG23/8iplUIcXnkCwaDrZ6i
	Ie04JgB7z0Y5rPFWx5ewBFi51sxtLBikTiHS9v7j2QlQWnFxE5x+dz/5QPPMVk1U
	geDp6TmXQnpDO9g3SXP3LOYDbWUhH9gAf2gO151VQhs0hkj3WUQkkQl5vlaKqN0C
	fiJhKgr7/d0TqNbZsh+rIhzb8F5qM0k0dH53ceCYWNp2S/+jQIOAULjbC6U2EhPu
	0f7cvAuRFZ944udbxupHsbg8IEJ+fydnmSK4mCjeVhXeb/d3BgFhit/XLT1ZcETK
	HTU/18N+JxAs2uINkGeMJA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1794834487; x=
	1794920887; bh=Tq174/jVsp9gUc8NbvDbcJBHJSHuiZrk4erR7h7AM6o=; b=a
	ipuOFm9d36HqmUjeFmZKBqHS+8xPFu0vXeaY13pIbB2aghaLx/34Ov8aUUJWr8N/
	esv6a7zID0UflvjwvEbVk9SanCJuBnKuypA9m0VkSuoNRPVz0DQ4Xv0yrUTNBLAt
	e1rQNl9AvJgBMojDleufjB1vpS8n1RkeaQs10ZsMsS9qZjrUkEIAiY3musNdvWeJ
	OYOMEheNmUVs8HU1BceEWhh+4nOtEJlvdNilT9qwnHrQu3DO7V7UvtKXLe/VF3K3
	Ibw2z8KKp6Sf79lQQS70PE8ZH6USgSlQOYklzt+VyOHqcRFPBvELIA5zdp0aZxjM
	7W+RDZEHGVHeCM6CtvS+w==
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-09;
	repo=github.com/dkim2wg/interop; date=2026-11-03; sw=lmtpprox;
	action=sign d=pks.im a=rsa-sha256;
DKIM2-Signature: i=1; m=1; t=1794834487; d=pks.im; mf=PHBzQHBrcy5pbT4=;
	rt=PGdpdEB2Z2VyLmtlcm5lbC5vcmc+;
	s=fm3:rsa-sha256:UPKd5XFrPH9V+b9gzrXKfOTu7Co1yMG/JH29WSUz8Cri1CN
	zmsxub7xn4V3PwhS+yHbEtDnYPjYpTycbPpb2a/cWk4KDzfSHphlRmDMUXH7Tb6I
	qfcTkg7srCA/6eZHL7hNkyetnCG36fhTR0OFbblW0edwEtRpTxNbtwe5lpRdgiA5
	Sz/3Z2vno2ZqMAW79JpkAta/PSOTsBNQR5Te/ZlDRdzTAUP/qUV2sOdmu2oRW8Nk
	C0mbWpa7lvKlO6iZu6LRHACaJmh3PitSNlMWdB70MxkItIyNLe6FzOhQsS/G/KVE
	BWIqqSbIFrFycu6DaNzkIvHDYvNwwrfoyHkZ10Q==;
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-09;
	repo=github.com/dkim2wg/interop; date=2026-11-03; sw=lmtpprox;
	action=mi-m=1; hc=12;
	hn=cc,content-transfer-encoding,content-type,date,feedback-id,
	from,in-reply-to,message-id,mime-version,references,subject,to;
Message-Instance: m=1; h=sha256:Zx3HI2WrrrH6n4X9ouMJGNKufY9s0CoLzRR+cpFqKFE=:OHJ1uKUhhNZ5VopLA1TjCzSM81wYe1ksoX18f12CIHw=;
X-ME-Sender: <xms:NwD7avEFeWJGqD7g9XS00thOdIUSGkER4tWfi4GA4yFH_v8ZHCLF2A>
    <xme:NwD7ajQiqsesrjrBTxd-0At712m0RY4dztEHl6uaBH7zL4FJln5hD4qJLwYvKVlPH
    y2f0kgZx1Em11oEHfzu1qAIyVn9IRwUnhu_UsNe6xx4RyBwAvEbkt8>
X-ME-Received: <xmr:NwD7amyzPfqOeRRaLm7I-s4g2v07xsey8b-1xKaaZApKmscBYAuvZQgaZMHxtEtVX4L841s>
X-ME-Proxy-Cause: dmFkZTGUadbCh8PYVzO+W98xO36esdaT9Eix5aVF7MyFuNyzrqEzalcNM9Mjew9UpwZvRj
    x3nTyTLMef4ef7P6EpH7QXWf/LZHZKuTx0r7fxS9GfAU74pOZ7Yh4nSofSUiFZw95M7nY9
    gjNAICkC6pEdvu+SjyFNNhBesAXtfqwDyzh5yr1FUIS3Y1rR8+FVIvi145XZlDJNogJw1V
    v2zHSU2YrL4odH2LqdNvkQSBsQEVYpYQKWTa2S2G7fxZtJF0uLduCFDwENnCD81HRQNXc1
    fb7KtPPll2p/GH5sgSZCt6oMY2lgXrxJrqwSVSbcUnQdR1SDk8ocUvWFnJtPLD1mupA6nk
    LhBtkNL8UN25YqA/UoAhfzEU3KF5CdzEA1qS0gi8gQla9mQ9MVajkSlV2DPP2weGJq9gJA
    AW3gZoXvrLJcvT7ewt2X/yHr6pzhX1YxirPbSUElJVd0h7Y5Fvdq4qPG50RCzp+cU7/RXE
    TUNHZE53d8fd0ZesowCElgYeD/4HUo4ThrUaM6yxiK6BQC4zotOXqD6pz6IFlljASbPHSk
    8Iv2QSAYT7p0+no3qsL6QyOSSZ7R4CqElm0SkWrr4pNRiHNY8UWDF1bJaKKXkS6DS9wXHD
    m0ZuQ5YeMcrE08Xqv5Iz6OFdlPfe9bBveMhcII3F0ZuHeEMzhcu3aJyHD0LQ
X-ME-Proxy: <xmx:NwD7aiPufXMmHt9fbiH5MTtzI3lHCOAMNK7rY6xpC7JJlOtXLC9HTg>
    <xmx:NwD7alPM-tNSQUV73f8pTdbl3GzS6ePB_RW6niht1hWh-DWcsAawQQ>
    <xmx:NwD7akR-iq01HrSUndJJAsN8gENrYd1oQsmttkPl-oFUlugIzoKKZA>
    <xmx:NwD7anDkF7_B0us-x_cM5CTA0eYFRHuvTuYIUwPaAsto0VgC7tjP9Q>
    <xmx:NwD7alUMprj3DFnAUe0ZzjqAF4FCuuaiYIWO1v9S8xj2KDH4wOWe71ts>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA for
 <git@vger.kernel.org>; Mon, 16 Nov 2026 08:08:06 -0500 (EST)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id 5f6b47aa (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO)
	for <git@vger.kernel.org>;
	Mon, 16 Nov 2026 13:08:06 +0000 (UTC)
From: Patrick Steinhardt <ps@pks.im>
Date: Mon, 16 Nov 2026 14:07:41 +0100
Subject: [PATCH 05/12] commit-graph: introduce common exit for
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
Message-Id: <20261116-pks-odb-pluggable-commit-graphs-v1-5-a83fc1ff0808@pks.im>
References: <20261116-pks-odb-pluggable-commit-graphs-v1-0-a83fc1ff0808@pks.im>
In-Reply-To: <20261116-pks-odb-pluggable-commit-graphs-v1-0-a83fc1ff0808@pks.im>
To: git@vger.kernel.org
Cc: 
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
index 7f7146e752a..c146f20f68f 100644
--- a/commit-graph.c
+++ b/commit-graph.c
@@ -2099,6 +2099,7 @@ static int write_commit_graph_file(struct write_commit_graph_context *ctx)
 	struct strbuf progress_title = STRBUF_INIT;
 	struct chunkfile *cf;
 	unsigned char file_hash[GIT_MAX_RAWSZ];
+	int ret;
 
 	if (ctx->opts->flags & COMMIT_GRAPH_WRITE_SPLIT) {
 		struct strbuf tmp_file = STRBUF_INIT;
@@ -2112,9 +2113,9 @@ static int write_commit_graph_file(struct write_commit_graph_context *ctx)
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
@@ -2126,14 +2127,14 @@ static int write_commit_graph_file(struct write_commit_graph_context *ctx)
 
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
@@ -2227,8 +2228,8 @@ static int write_commit_graph_file(struct write_commit_graph_context *ctx)
 		int result;
 
 		if (!chainf) {
-			error(_("unable to open commit-graph chain file"));
-			return -1;
+			ret = error(_("unable to open commit-graph chain file"));
+			goto out;
 		}
 
 		if (ctx->base_graph_name) {
@@ -2243,8 +2244,8 @@ static int write_commit_graph_file(struct write_commit_graph_context *ctx)
 				result = rename(ctx->base_graph_name, dest);
 
 				if (result) {
-					error(_("failed to rename base commit-graph file"));
-					return -1;
+					ret = error(_("failed to rename base commit-graph file"));
+					goto out;
 				}
 			}
 		} else {
@@ -2267,14 +2268,17 @@ static int write_commit_graph_file(struct write_commit_graph_context *ctx)
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
2.56.1.763.g16177fe143.dirty

