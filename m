Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=103.168.172.156
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795177397;
	b=BEdbgJz9DrYx1Km1UpKy0wHdolgWQcXcP37nABlopKo6yFjd4RnblbBWVKa4DiLPghjy
	 vwhMa4ZctJ0JNAiFZPbpYWcr+AuNrnwVorgHiSRG7fITOw88bXMjUibJhY012dbYtuZ1y
	 pN/ZCjRlq3xoPqZ/Bi4xOC+Z144XPn+7ReyPmhCQY6evVmJVYn5Ee7Qw4iUCX9nqQYeVF
	 Nng63xrrdxdT9smbH4xEzTUMUO1tTlfY7m5NJOpljDzd77ZuZTmM7gswTnyhUgr3FpdSv
	 3Jl7NRo3mXVS9bxlsAopJDDFtTpSs6La6EcoZQu9FNJVbr1LgZOj5YANQtA1kimwXLw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795177397;
	h=DMARC-Filter:Received:Received:DKIM-Signature:DKIM-Signature:
	 X-DKIM2-Info:DKIM2-Signature:X-DKIM2-Info:Message-Instance:
	 X-ME-Sender:X-ME-Received:X-ME-Proxy-Cause:X-ME-Proxy:Feedback-ID:
	 Received:Received:From:Date:Subject:MIME-Version:Content-Type:
	 Content-Transfer-Encoding:Message-Id:References:In-Reply-To:To:Cc:
	 X-Mailer;
	bh=k1em0gqEWxJ9YsEW7gaqPvrNhQvp8LlO7YlzFiFxcs0=;
	b=UBiSeZEREL7Th55qEjI3au0nhj9PJHHQdIoQ3WgHQyyGTNtwY3wiCB8I10MDRo+Rqyb9
	 6CWD1ER+QN9fgWxHeXkLnaJOPyE6Vp9oLY1NFVqYHHG6zUsXUf/JwEYs7ukhqYbwF7ERL
	 li2vTfKR4OI6XP9BR4gvDoRfZGRsVKqTkcgjLeiWQZFQG71JrGm3YqTxpUxjaeMb+q7Gx
	 4+nC3wKaxgBbf6j09uj8KWKp0VHyit4v11wD/y3iMspYDhjV4auH1D5eDwdbmTsZIN8Ff
	 mM4xCX8ngwzJuYZ0ZysmpWRIWoJtopGiuBMwA6hr9XmIo5q/9lcpuBhYvcZcQCZYfkg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=pks.im;
	spf=pass smtp.mailfrom=pks.im;
	dkim=pass header.d=pks.im header.i=@pks.im header.a=rsa-sha256 header.s=fm3 header.b=gcgc+2FG;
	dkim=pass header.d=messagingengine.com header.i=@messagingengine.com header.a=rsa-sha256 header.s=fm3 header.b=uWBvjcv3;
	arc=none smtp.remote-ip=103.168.172.156
Received: from fhigh-a5-smtp.messagingengine.com (fhigh-a5-smtp.messagingengine.com [103.168.172.156])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7D56A606A320
	for <git@vger.kernel.org>; Fri, 20 Nov 2026 12:23:16 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 7D56A606A320
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=pks.im header.i=@pks.im header.a=rsa-sha256 header.s=fm3 header.b=gcgc+2FG;
	dkim=pass (2048-bit key, unprotected) header.d=messagingengine.com header.i=@messagingengine.com header.a=rsa-sha256 header.s=fm3 header.b=uWBvjcv3
Received: from phl-compute-03.internal (phl-compute-03.internal [10.202.2.43])
	by mailfhigh.phl.internal (Postfix) with ESMTP id 96A1A1400242
	for <git@vger.kernel.org>; Fri, 20 Nov 2026 07:23:15 -0500 (EST)
Received: from phl-frontend-03 ([10.202.2.162])
  by phl-compute-03.internal (MEProxy); Fri, 20 Nov 2026 07:23:15 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm3; t=1795177395;
	 x=1795263795; bh=k1em0gqEWxJ9YsEW7gaqPvrNhQvp8LlO7YlzFiFxcs0=; b=
	gcgc+2FGWfTky1x0SW+MP2frYJ2TpNG0N3lIr37pgjg8rbrDmfVupNtcO5V6qxNi
	Z4leuR/5KvOXjXB85kkXnLaL+sr8MEd39yrmZQ00MYuP2HXbb1HUlU8JQaaTLTmW
	2IPBgY4+DEcEB/KmxIwXQXXODaXgmpXOrSGUtr8bzEVBxjNUgKNkivOgdjD0nCnZ
	RUfPVeIl0u8E/+TZhni0DuPF0k1VL8dVQaXjxQ54bET3O0Zg1i2CVITx4OTYcUJG
	rEJsPXdZrTGJaMcqjIfdgxB+Y+tYV4dGukqBXv98BHzH8lCPsAjRs7xcmiTvGbim
	cqBMhFRBTjqj25u3wTQloA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1795177395; x=
	1795263795; bh=k1em0gqEWxJ9YsEW7gaqPvrNhQvp8LlO7YlzFiFxcs0=; b=u
	WBvjcv3AWvDEznnnenmZAR+yBXQc/yLZmmO0fHIWx2P1fB14ln4QhohujyGXkMOv
	rKnWAXBptLW+ImT8C9plimNGHvyPeDclZLOS7duMIA03rmFWs0ILJF8HBmawewjP
	oVo4FJypTngRegLeeXVKpWPKcR9ef8uo8LcTU1rPj8yIaNfg6KhnidWqff42v0bv
	oZJtQvEMH8r7db8qfRKdBssHyDvGgrt1xJPEbbdEvYq7rNfDTaEkDM7RaR7FjGvV
	aFp2UJ/YSuQlc4dRbg+KaqQCg3rcRoZjjeQjE+xeF7sSgkwhX5ahhqFZZbAHMwLM
	+VegIqHV10ix0UT+3JUng==
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-09;
	repo=github.com/dkim2wg/interop; date=2026-11-03; sw=lmtpprox;
	action=sign d=pks.im a=rsa-sha256;
DKIM2-Signature: i=1; m=1; t=1795177395; d=pks.im; mf=PHBzQHBrcy5pbT4=;
	rt=PGdpdEB2Z2VyLmtlcm5lbC5vcmc+;
	s=fm3:rsa-sha256:WhZEDD21NyI07PZzgoy5WiEDbqE0dVFUlnfyA4H4pfeqRQn
	rzXUe5BYeZT9PheJrf0Qzqlhgx9IUOycQkrlfx1M3pvlwXoXBAbLQcz6igKE6L5Y
	rO068qOZq/XWDVbnOo9vF+0zYBTD3LuwXS/If9py1/Vaedt7YtbQwqEMW4Hj4eBf
	cBSztzmm+1+QGjnnbDH+rAE+MJeM6pP7IEoY02cKw/3FP8zIg5chNgOuPlPLvvG2
	TYG+qOPH+S3Tuv+tZKxBRn048TMQ00pR4UxBRDz1uZMRW6xGk06gbMIc8ztxH6eq
	9e12sBZ9AW9hgg/dKMaPMC8Zop3dALs3rG1RivQ==;
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-09;
	repo=github.com/dkim2wg/interop; date=2026-11-03; sw=lmtpprox;
	action=mi-m=1; hc=12;
	hn=cc,content-transfer-encoding,content-type,date,feedback-id,
	from,in-reply-to,message-id,mime-version,references,subject,to;
Message-Instance: m=1; h=sha256:s/hbJMkqEWOLseouH/+GCvJJFJ6zjWL0JpLwNdSfiGE=:jb9XZSeG3cHZM68KwNqM6fLwSy0BkalglL3j+TlZvsM=;
X-ME-Sender: <xms:szsAa-BCi9bQWzWengt3nSLE4Jq3knBCJxjZfMtV2TyW_tBLXeFsKw>
    <xme:szsAa-hYdDa6vDEdSrIJVym9Vgd8QxVvohBEjaZ5zprLSy1JIB2Utzezx68ePKz12
    kJz38Jv7WMLRFJQkWjMk23Zbkns4gVR2aMtmS0a-yaJzp0su-UMZkI>
X-ME-Received: <xmr:szsAa_NAkxFIkltzaRRiGpC6z7zwrRjOhdfaMcQJ8ki8oOWvJeNd3Iepm3Jhb8R7llNVA90>
X-ME-Proxy-Cause: dmFkZTEZNt7M3JXGz8Rq/NfenXBeR+j+thvlV8UjDLU6wMBPSqPvFwnOirkVJI41TWvjze
    qdCpPCxgTUkEDCsoFiWBR6QTkwcvz+aJ8XeIjxxelXoUutBmnMBiZarMjcggP9boeOpt+B
    TyrJ7nqwYVccnIFJ003aoXlYe9rJBBPzymvR2Q+3E4H0jlAflIDW5XAwrgmUDwgagT8run
    uWD7A8CEgWuEWGqlzYBWnBtj1G0sJIsFICA+3okRtiAdfOWTpbyk/5TbFRzHxQ3wf4cveT
    BI0zACaZbjXWwjC991vJcw/FRa/q6yCgoLnQcf4QRWw7j7qnzLIrbnXzsLQLLHNPaYCZde
    OqcR0FABxMsAjFChMe64RN6KGP1KqTd08DjOW29/Ju8NnoIjc5PYzNFi78YJPGYd80BdZX
    g1LI4aM505yIZbvPHhsTLAziLDN2kaWn2i6AXQbQZLK4HsgGlL22jt+jadgGiMrdxJRNlN
    XN2q5qKdIQdjPdndmNqJEd5gUflsfiO9ScSTycTkxiY62RS9C1hqM/sA6onXOqcykyZcMC
    DhtvCc7TOdGUPsobHB+YJIwxajOkgudFo9Rx+ljXkBd778jYkBBuiRq9i68Ij1gI1IH9RU
    aJ4ijJX5Ee5W7L9bmYxxOBGZrgtTRi+p5bvgdI6Q5BudqjzkkWm9+x4CU18w
X-ME-Proxy: <xmx:szsAa35C64kKDPrFD2VIjoN9078rHHH9f1vH4BxfQu5CBO9G-dOanw>
    <xmx:szsAa10B15DZ3BH0Bj8i1P0ep82r5obVTdhlSsetoZrqqyf_NedYLg>
    <xmx:szsAawYOGVwhyQLOmwmvLPvVUgPEZJ9Kym-CDBhlpSWh9P69uT4uKw>
    <xmx:szsAa1APYbbq2eA3jTC_plITPBtFC1-wzn7tBbKNXXz-e4yYM2NruA>
    <xmx:szsAaxZBG02aRiNiyVKjOFDoaJ3_2p0KAsoSc6Ykqsbm8mY1WjkNkOdR>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 20 Nov 2026 07:23:14 -0500 (EST)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id 2eb03e6a (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Fri, 20 Nov 2026 12:23:14 +0000 (UTC)
From: Patrick Steinhardt <ps@pks.im>
Date: Fri, 20 Nov 2026 13:22:52 +0100
Subject: [PATCH v2 4/7] commit-graph: expose function to validate a commit
 graph chain
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
Message-Id: <20261120-pks-odb-pluggable-commit-graphs-v2-4-31f2341a9932@pks.im>
References: <20261120-pks-odb-pluggable-commit-graphs-v2-0-31f2341a9932@pks.im>
In-Reply-To: <20261120-pks-odb-pluggable-commit-graphs-v2-0-31f2341a9932@pks.im>
To: git@vger.kernel.org
Cc: Junio C Hamano <gitster@pobox.com>
X-Mailer: b4 0.15.2

When we have loaded a commit graph chain we need to validate whether all
of its layers have been written with compatible settings. If that's not
the case, then some functionality of the chain needs to be restricted as
it would otherwise yield inconsistent results.

In a subsequent commit we'll move loading of commit graphs into the
object database backend, and consequently the backend will have to
perform this validation. Expose this functionality to prepare for this.

Signed-off-by: Patrick Steinhardt <ps@pks.im>
---
 commit-graph.c | 9 +++++++--
 commit-graph.h | 7 +++++++
 2 files changed, 14 insertions(+), 2 deletions(-)

diff --git a/commit-graph.c b/commit-graph.c
index 08a151af29a..e48d8fc0a78 100644
--- a/commit-graph.c
+++ b/commit-graph.c
@@ -574,6 +574,12 @@ static void validate_mixed_bloom_settings(struct commit_graph *g)
 	}
 }
 
+void commit_graph_validate_chain(struct commit_graph *g)
+{
+	validate_mixed_generation_chain(g);
+	validate_mixed_bloom_settings(g);
+}
+
 int commit_graph_link_base(struct commit_graph *g,
 			   struct commit_graph *base)
 {
@@ -701,8 +707,7 @@ struct commit_graph *load_commit_graph_chain_fd_st(struct object_database *odb,
 		}
 	}
 
-	validate_mixed_generation_chain(graph_chain);
-	validate_mixed_bloom_settings(graph_chain);
+	commit_graph_validate_chain(graph_chain);
 
 	fclose(fp);
 	strbuf_release(&line);
diff --git a/commit-graph.h b/commit-graph.h
index 8660c7fe698..dc4f6194c72 100644
--- a/commit-graph.h
+++ b/commit-graph.h
@@ -134,6 +134,13 @@ struct commit_graph *load_commit_graph_chain_fd_st(struct object_database *odb,
  */
 int commit_graph_link_base(struct commit_graph *g,
 			   struct commit_graph *base);
+
+/*
+ * Validate the chain of commit graph layers to ensure that all layers are
+ * compatible with one another. This may disable generation data and Bloom
+ * filters in case they aren't.
+ */
+void commit_graph_validate_chain(struct commit_graph *g);
 struct commit_graph *read_commit_graph_one(struct repository *repo,
 					   const char *dir);
 

-- 
2.56.1.831.g720f3f5937.dirty

