Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=103.168.172.146
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793807867;
	b=1ueQ3FbLIJ24ttKPc7fVNz4dFVtXMQSOjWopmlDvSuTCQsmv0yyyk75X73daPL+AMulN
	 DHbXwSWxj6iB7jED313ihluWADCB3+n+NEMHKQcVRbeRihnq+hKApxVVqEd+P5aTW+SwC
	 2d2znxIPCnzANrx4M8MNZlxMEuIjp4oHJ1tkm9NjpXdfZcgUvbdGGl9aaBsOzrN7iwF+M
	 I/E2H8cs4/fa8dAzSC7LhIoM9cRu8T77ukRb295XHouWSKuOhgwqc265Wzb+yBv5Dtv8A
	 nlmTuC8Yzm+TCfn79ekB8FTpIAT22y13E4ZTtQWRSsY2VvBgaXaduQkaVDWFrT4n5Pw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793807867;
	h=DMARC-Filter:Received:Received:DKIM-Signature:DKIM-Signature:
	 X-DKIM2-Info:DKIM2-Signature:X-DKIM2-Info:Message-Instance:
	 X-ME-Sender:X-ME-Received:X-ME-Proxy-Cause:X-ME-Proxy:Feedback-ID:
	 Received:Received:From:Date:Subject:MIME-Version:Content-Type:
	 Content-Transfer-Encoding:Message-Id:References:In-Reply-To:To:Cc:
	 X-Mailer;
	bh=TUY6YxJPkG/Kxt5NlIEZbbhu2TbChS+hnxj2eCh8rmg=;
	b=OyGhnsOiA+2aETEtoOZOQ3UCBHqXVDkbfYkrrSTyYIz+sNLuhC29VTIqDfeyxoYkh7+y
	 yRGQHeMvl1atpzMXEXmPv1BWp2t5BYCdibgAwItJG848fd5ss1gIA/SUGxstAkvU2Nqap
	 OEujnt91gegPXqb9wZo5p+rDywKMGV58O66Dd1yLOf8c7lu7o69tHOU1rrkAbAb5xTJsL
	 GJHg1QZCrE9mPNo2lqpV+qIsjuyEX+3KydgWJ8CS3m5Z4IRh9cb+aYqlFgvUwEqlsJdTn
	 0pi5aNrpPRj+zJOa9ABr/HPDfrFtLNEQ0HmyoF8plxh0vPmvquJKU2OG+fWJN75UWnQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=pks.im;
	spf=pass smtp.mailfrom=pks.im;
	dkim=pass header.d=pks.im header.i=@pks.im header.a=rsa-sha256 header.s=fm3 header.b=E+a+uu6g;
	dkim=pass header.d=messagingengine.com header.i=@messagingengine.com header.a=rsa-sha256 header.s=fm3 header.b=2F6W978U;
	arc=none smtp.remote-ip=103.168.172.146
Received: from fout-a3-smtp.messagingengine.com (fout-a3-smtp.messagingengine.com [103.168.172.146])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DF396606D802
	for <git@vger.kernel.org>; Wed,  4 Nov 2026 15:57:46 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org DF396606D802
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=pks.im header.i=@pks.im header.a=rsa-sha256 header.s=fm3 header.b=E+a+uu6g;
	dkim=pass (2048-bit key, unprotected) header.d=messagingengine.com header.i=@messagingengine.com header.a=rsa-sha256 header.s=fm3 header.b=2F6W978U
Received: from phl-compute-04.internal (phl-compute-04.internal [10.202.2.44])
	by mailfout.phl.internal (Postfix) with ESMTP id 1F6B2EC02B2
	for <git@vger.kernel.org>; Wed,  4 Nov 2026 10:57:46 -0500 (EST)
Received: from phl-frontend-04 ([10.202.2.163])
  by phl-compute-04.internal (MEProxy); Wed, 04 Nov 2026 10:57:46 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm3; t=1793807866;
	 x=1793894266; bh=TUY6YxJPkG/Kxt5NlIEZbbhu2TbChS+hnxj2eCh8rmg=; b=
	E+a+uu6g9jEtjp/FV9oTt1i6dlYu3e/D1ZEETaowO5jTtA1NwBiXOAomqON2khza
	iI0m1XYep1hk8Z1XFApbwldfXtia0ridhOUHN9VeF6f9rBWuLgbg/Y7JEOOaLXBr
	XGeX7ZKgFKeXG7owjnBRb/7ydBF+Th15TOjsiB/pEPyOCs+688T0nYOlcfwMO8Tf
	MYpMqdRnXQAciWyjdGTKz1uRcncEBtVmIg42EboPEYHwMyAI8YQJTxUEI7gXNd0C
	KAdYpAntBa06muXAEAeLT0mPPfxBigBMhJzd/hP2e9dFAbDqBwpCgMyzUE28jmUH
	8RiLkZSDtFNLr6J4pTCGCA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1793807866; x=
	1793894266; bh=TUY6YxJPkG/Kxt5NlIEZbbhu2TbChS+hnxj2eCh8rmg=; b=2
	F6W978UnDDsswF0xO12IP2pLlxS500N21hXJXfGdFFcDMYLu3kepIpX91F4uoXzc
	rFvPeFoFl3KVCl8zhreACmwqGOpQkMNHUf7a2SchBd+KmhQAhcbFGX7ebcWtVIMW
	ZR1TXiapJzEuKj+GkgtHB4pLYG1pKfQ03Em5LHU4aWbOLkTqFdnhM8z9MyY6/g+D
	e/npK3CC0kbDHr3tBDRSMs6KKOgFr4SFYJAP8Jb1Xlvk01BQCdMZoTc+XAZMAd4V
	VuEzAEymbqj3xvk1wPzrSx4RVY7UR2uSRN0qALENnxz6alHdi1HIjuQ2wa0AbqF7
	INmM/KSNhjmH8UYKO0/Vg==
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-08;
	repo=github.com/dkim2wg/interop; date=2026-10-28; sw=lmtpprox;
	action=sign d=pks.im a=rsa-sha256;
DKIM2-Signature: i=1; m=1; t=1793807866; d=pks.im; mf=PHBzQHBrcy5pbT4=;
	rt=PGdpdEB2Z2VyLmtlcm5lbC5vcmc+;
	s=fm3:rsa-sha256:D6KT/phmqImy/L7ZGWhoQlWRBEkwdUYtCHhgjsCy9vNeFMD
	LjOrww9GtzHkeaeyKKIJDPmTRfBnJGvO87CxjNYu2GgZcgCf0I4bGqE4BmLzd0rs
	MaCWypravS5jdnLFf61L0oncc89kTKVOZCRjr5uy23DqhaQM0oNy6emYbU7tif1W
	mSUDTDEpvRV44qMJICIkUBHODy47c6De/uBHu0laSQL4mSCUrXsCBGj4YPwt4lW9
	nDMWfePPXsGpBLXGbwxsqQZiXCWLjQ0T2vejwnxYcU1Y45d+tJv1kjb6jHJY2BbM
	KTrZFKG5agdLwPZvJvJeWFLgY/2PTFWTPVCFxBw==;
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-08;
	repo=github.com/dkim2wg/interop; date=2026-10-28; sw=lmtpprox;
	action=mi-m=1; hc=12;
	hn=cc,content-transfer-encoding,content-type,date,feedback-id,
	from,in-reply-to,message-id,mime-version,references,subject,to;
Message-Instance: m=1; h=sha256:E3KqBdh0YFaosEGuEghRj1004Mtnk/OVBSwJxyZzlQM=:ThOmuw7cwxtJdLH7A7k1KYyQRBqYNCi1eZ4z6zileW0=;
X-ME-Sender: <xms:-lXralK5Q8b_f5JU_IXXaoQN0_V_59ZOnPbcOR1OWkVI1ZVEmrb0wQ>
    <xme:-lXraoGojd2GubXsbDexxHdmcNrThPt9IUC5GoLSFSVWePNjlp-MPUhfz6zWUeU-E
    dVsVHLCOThPcQi_rC8WEwyznUQ2vtNXJcA9IqnnfkuiAsy7xsQNww>
X-ME-Received: <xmr:-lXrajUQw0sMgQK7BKLt9nHk2cBxnp8V1jgha2ArPfXgLPabw4PxfMTwSwVP2n9gvgI5j64>
X-ME-Proxy-Cause: dmFkZTFP9F9oJWwJG85mnHzfFOqny0OiD5iiWGUykvkiOCtsZJx63XeSWFS5hvnOTWaXXM
    pVNW68EmUAqObsBxHEoTqZGxr1uInZq5ObL120XJ6obWw31M/SqAAh2FRln8SyYDsBRQAc
    XgLSwbTYIIRAuqer3KFyQcFJVx1upExtgeuk4+nospz6pknGbvTFoQtONK00uHdyGa71ei
    05eeKL8ZFbs8tu8jIH8bDRz+5s8LGUqkWAZAgjQZeduYIONS+s4caycfiuwagcsfkJCBbf
    gsJbttQXJ4DA/1KBEx2aj29+xUBhITr/+i7EpjG9SxzktIlj30krZRuziPbpuPiywKxRiA
    pIrHGk4zwSNDBjOpT0uRCbaNOd0BPlcZzlwo4RTVr5pGluCqZJ7jnPHvxJW3gJxXpSl6gq
    1Qpcpu3xH983ollYH61erxcCyynMDvlI2jdsadybn9oWp1t9TWoYjILOxIjT3sfCIlDCF5
    F3oxrJpsjbOn//I9wI8RpJFW8gt620hS1PeMtvVkqbtvvYFbh8sDO7TkSr+/h+Cy5tqdls
    /z7QdtlH1wOBngDZRTZrJxj9+1U9lOEo2muJW1rQcYieZeQyycxkINu3ec5Qag9nPMgeP+
    Oja2sc9ZI/IjltOdrUPcjTruszY5CgJFmuCRjchfeu7bk7QQF6LVosDXaJ3g
X-ME-Proxy: <xmx:-lXrargF79GDQ3L5QxExSEGyXRAEX7JmtTBOnW4Vwko--kRtx2b1nw>
    <xmx:-lXrasS0rZjVcFJXVL5XtwhXx8h5R2wxgrzjG-0vkvKSxBzvMZlvbQ>
    <xmx:-lXramH8uHBjn0-idbXKGzXxRoMiQSPGqM6IGv10uqcvFr-PKmGE5A>
    <xmx:-lXrasmk7QeQ6O3FE1p36gnQsOJteQftJ4-joJdaRkEgwqNd-_wO4w>
    <xmx:-lXraiozECV1WfYnBjXqrEgLeDMZaegwrKVJuPuow3Vrh_zAFIBqLiNI>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA for
 <git@vger.kernel.org>; Wed, 4 Nov 2026 10:57:45 -0500 (EST)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id 75f4e921 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO)
	for <git@vger.kernel.org>;
	Wed, 4 Nov 2026 15:57:44 +0000 (UTC)
From: Patrick Steinhardt <ps@pks.im>
Date: Wed, 04 Nov 2026 16:57:25 +0100
Subject: [PATCH 03/10] commit-graph: drop `NULL` checks for write options
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
Message-Id: <20261104-pks-commit-graph-write-refactorings-v1-3-d013d9401a59@pks.im>
References: <20261104-pks-commit-graph-write-refactorings-v1-0-d013d9401a59@pks.im>
In-Reply-To: <20261104-pks-commit-graph-write-refactorings-v1-0-d013d9401a59@pks.im>
To: git@vger.kernel.org
Cc: 
X-Mailer: b4 0.15.2

The commit-graph writer still handles the case where `ctx->opts` is not
set by falling back to defaults sprinkled across several functions. But
since we have moved the write flags into the options structure in the
preceding commit all callers pass it, and we can thus start to treat it
as a mandatory parameter now.

Drop the checks and use the options unconditionally.

Signed-off-by: Patrick Steinhardt <ps@pks.im>
---
 commit-graph.c | 30 ++++++++++--------------------
 1 file changed, 10 insertions(+), 20 deletions(-)

diff --git a/commit-graph.c b/commit-graph.c
index 9216d051c1f..e86569b7ced 100644
--- a/commit-graph.c
+++ b/commit-graph.c
@@ -1568,8 +1568,7 @@ static void close_reachable(struct write_commit_graph_context *ctx)
 {
 	int i;
 	struct commit *commit;
-	enum commit_graph_split_flags flags = ctx->opts ?
-		ctx->opts->split_flags : COMMIT_GRAPH_SPLIT_UNSPECIFIED;
+	enum commit_graph_split_flags flags = ctx->opts->split_flags;
 
 	if (ctx->report_progress)
 		ctx->progress = start_delayed_progress(
@@ -1858,7 +1857,7 @@ static void compute_bloom_filters(struct write_commit_graph_context *ctx)
 	else
 		QSORT(sorted_commits, ctx->commits.nr, commit_gen_cmp);
 
-	max_new_filters = ctx->opts && ctx->opts->max_new_filters >= 0 ?
+	max_new_filters = ctx->opts->max_new_filters >= 0 ?
 		ctx->opts->max_new_filters : ctx->commits.nr;
 
 	for (i = 0; i < ctx->commits.nr; i++) {
@@ -2035,8 +2034,7 @@ static void fill_oids_from_all_packs(struct write_commit_graph_context *ctx)
 static void copy_oids_to_commits(struct write_commit_graph_context *ctx)
 {
 	uint32_t i;
-	enum commit_graph_split_flags flags = ctx->opts ?
-		ctx->opts->split_flags : COMMIT_GRAPH_SPLIT_UNSPECIFIED;
+	enum commit_graph_split_flags flags = ctx->opts->split_flags;
 
 	ctx->num_extra_edges = 0;
 	if (ctx->report_progress)
@@ -2290,20 +2288,13 @@ static void split_graph_merge_strategy(struct write_commit_graph_context *ctx,
 {
 	struct commit_graph *g;
 	uint32_t num_commits;
-	enum commit_graph_split_flags flags = COMMIT_GRAPH_SPLIT_UNSPECIFIED;
-	uint32_t i;
-
-	int max_commits = 0;
+	enum commit_graph_split_flags flags = ctx->opts->split_flags;
+	int max_commits = ctx->opts->max_commits;
 	int size_mult = 2;
+	uint32_t i;
 
-	if (ctx->opts) {
-		max_commits = ctx->opts->max_commits;
-
-		if (ctx->opts->size_multiple)
-			size_mult = ctx->opts->size_multiple;
-
-		flags = ctx->opts->split_flags;
-	}
+	if (ctx->opts->size_multiple)
+		size_mult = ctx->opts->size_multiple;
 
 	g = graph_to_merge;
 	num_commits = ctx->commits.nr;
@@ -2508,7 +2499,7 @@ static void expire_commit_graphs(struct write_commit_graph_context *ctx)
 	size_t dirnamelen;
 	timestamp_t expire_time = time(NULL);
 
-	if (ctx->opts && ctx->opts->expire_time)
+	if (ctx->opts->expire_time)
 		expire_time = ctx->opts->expire_time;
 	if (!ctx->split) {
 		char *chain_file_name = get_commit_graph_chain_filename(ctx->dir);
@@ -2645,8 +2636,7 @@ int write_commit_graph(struct repository *r,
 				ctx.commit_graph_filenames_before[--i] = xstrdup(chain->filename);
 		}
 
-		if (ctx.opts)
-			replace = ctx.opts->split_flags & COMMIT_GRAPH_SPLIT_REPLACE;
+		replace = ctx.opts->split_flags & COMMIT_GRAPH_SPLIT_REPLACE;
 	}
 
 	if (odb_count_objects(r->objects, ODB_COUNT_OBJECTS_APPROXIMATE, &ctx.approx_nr_objects) < 0)

-- 
2.56.0.500.g5d06dc02cd.dirty

