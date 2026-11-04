Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=103.168.172.146
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793807877;
	b=znxkhEgBqYBOJaqIB5PDoRQuOHVXFU60JvTmegFth9q/2AMQM2iv+FDBa1npYyMubS0W
	 /Tn33o3H5lSvDOIrmupR7Ey+vNFzd0WpO2mjIPNwz4F/T4sixezjh3q27gipu47sL1ofU
	 AXQHrH6WcyUIn35aNNY7Fowpd7uJSV5PIeiXodszWY/SSim4sD3RcqTmF6W0+gj9E25tI
	 aSP8Cp+Yu0JwQWx2zQ/6gJme8edh5Brq8rjEb8wRVAPI4c0Exd5ub2xIv4by8u8VxDYs4
	 KVslxL0LkyzVKcnPfjnD6K9R7WwLih7CB2ZHTHpVDv3xqYqPKKani+R93v94L0tO1yA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793807877;
	h=DMARC-Filter:Received:Received:DKIM-Signature:DKIM-Signature:
	 X-DKIM2-Info:DKIM2-Signature:X-DKIM2-Info:Message-Instance:
	 X-ME-Sender:X-ME-Received:X-ME-Proxy-Cause:X-ME-Proxy:Feedback-ID:
	 Received:Received:From:Date:Subject:MIME-Version:Content-Type:
	 Content-Transfer-Encoding:Message-Id:References:In-Reply-To:To:Cc:
	 X-Mailer;
	bh=ZV2sWCHjMAC2Af8HSSjVnMY2QrNhD1lN/R8CL7P/64o=;
	b=3H/bGg8wDNWB19pkIzw5D7dQu1UwCq4yJ9nmgcMYCvOHlTo9R5ivZJR3yIh48wGfPTyg
	 OyvtjkbO/IHA0rzr2YRLKHRwuiNCc79qrGONKztIQW3m8l3SwfqXOiY4w7vczSpUc4x6z
	 JfwuGIjAOm1hKhDIT2tI7SYVcFV7+xAPVrEMVTFJSqW5SXqGsH5ouevM1PCAF8S5vTok4
	 KLCdrLI9NydZ33+gfoHJ+wsSO4DPDN4ejMY6Kie+TLHDWE5PON6xo3+WYW/ZHURXd3x8B
	 x36uYqxeKcYMJeABcnggWZ9lE6PhzcQ6xTStgnM1XnzklM3CiEcxM5CWfACPrK7ZrLQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=pks.im;
	spf=pass smtp.mailfrom=pks.im;
	dkim=pass header.d=pks.im header.i=@pks.im header.a=rsa-sha256 header.s=fm3 header.b=SZUyOne9;
	dkim=pass header.d=messagingengine.com header.i=@messagingengine.com header.a=rsa-sha256 header.s=fm3 header.b=r20h3cbX;
	arc=none smtp.remote-ip=103.168.172.146
Received: from fout-a3-smtp.messagingengine.com (fout-a3-smtp.messagingengine.com [103.168.172.146])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 73BF0606D810
	for <git@vger.kernel.org>; Wed,  4 Nov 2026 15:57:57 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 73BF0606D810
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=pks.im header.i=@pks.im header.a=rsa-sha256 header.s=fm3 header.b=SZUyOne9;
	dkim=pass (2048-bit key, unprotected) header.d=messagingengine.com header.i=@messagingengine.com header.a=rsa-sha256 header.s=fm3 header.b=r20h3cbX
Received: from phl-compute-08.internal (phl-compute-08.internal [10.202.2.48])
	by mailfout.phl.internal (Postfix) with ESMTP id C2F38EC028D
	for <git@vger.kernel.org>; Wed,  4 Nov 2026 10:57:56 -0500 (EST)
Received: from phl-frontend-04 ([10.202.2.163])
  by phl-compute-08.internal (MEProxy); Wed, 04 Nov 2026 10:57:56 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm3; t=1793807876;
	 x=1793894276; bh=ZV2sWCHjMAC2Af8HSSjVnMY2QrNhD1lN/R8CL7P/64o=; b=
	SZUyOne9TlHAPhgtNzZS+ZwzsfEJHfqjbUH7AyfMIRB+GLjbQRNVQAC1C1yFzOMK
	fLccMf0vOX+RXZKLCyKMtPrTRmclOsz6AnQRkiwkB8y2wIG5xnaTFJp3ksIyiFwC
	EPJx21mjD30mZGiHIDlkj6OzO5KGMSfrsNy9YYXF+pnckq4jBZNavNgfdaYs6wIJ
	fxOrYO2j6iEOl82cUbunBi3HE2rQ4Q6qGaBjY5BGhUR0j+mY7UA2NXZ8x3oSb55e
	9OdnTzBRz5/kRvHuFE4bUNTuBIG3dIgtVtANtiDnf70kUG6GhJp8EpwSt4aFRQ3x
	rnPjeByf7YljWDStE1ArkA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1793807876; x=
	1793894276; bh=ZV2sWCHjMAC2Af8HSSjVnMY2QrNhD1lN/R8CL7P/64o=; b=r
	20h3cbXkUgOIvVkv6DN8Wef3H18JUv8xSEw6uOA4X6W3/tXPVZX2TheF8Z/LSENa
	3mMreR7+fk4OD42FNAX4I4cdUQ33RWmQaX6HF/cFdO8IYGt4RfRaZ6VJ5jN2nRrc
	ULpyKa7DmzFTzzXpxC4LVyC5U3rsy3iwZzdEWdvHDntud6ZC3lTOYJMULAcubgsu
	RJ/IBwjRLzPNV4C/O2rN7GSw0b+LXvmcH9y14BgpzgawHiRp+ozgdZcCZOlJ48Cy
	WkxxUIV6wwi+l3novXwzBMjBy4P4CIQWSc+1ftqKCWtGVIsjKuAU8Vm8lF9qpBIe
	W45nKZStn8cjDFP70pdvA==
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-08;
	repo=github.com/dkim2wg/interop; date=2026-10-28; sw=lmtpprox;
	action=sign d=pks.im a=rsa-sha256;
DKIM2-Signature: i=1; m=1; t=1793807876; d=pks.im; mf=PHBzQHBrcy5pbT4=;
	rt=PGdpdEB2Z2VyLmtlcm5lbC5vcmc+;
	s=fm3:rsa-sha256:sptb5NVDSPJXUQxcNuQ1dHgzUyTFb11t2ckU1pW6LLUm9av
	2JdkpG93ZXOh85AiGfvhP4ibkUEb7WXjfwz3Ud9SYUEjDArt/f+95qHgG21yJa1Y
	xlS3lOzycUaUUhaTE+18hcMcbklrOHUwf79KrNNWUKjx3krq5tc32B8Ku5jHJh59
	O1OAIGoCOFvmUQCk8Lag2/yWXcxPiEWZtzIyPIX80H+Dx1g/TLZ7RiWh6MzTd87h
	EwOAkMs+G2kNM6c/b8Jjml3Su0ylvbe7mA4kUBgV4GHRZLkd1NfFFGE/FCNMoSdr
	G+UY/VQr8ynAJRBVAikrmJsRicrxJTtuZ7tnz6A==;
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-08;
	repo=github.com/dkim2wg/interop; date=2026-10-28; sw=lmtpprox;
	action=mi-m=1; hc=12;
	hn=cc,content-transfer-encoding,content-type,date,feedback-id,
	from,in-reply-to,message-id,mime-version,references,subject,to;
Message-Instance: m=1; h=sha256:xZ3vVJWL4R1S4xrfwa+hQapWJ3TNRhv9P55Ioo9Op4g=:3EKfvjD4zBnW5M+21Dny39jcm2c9qGyVTPSmnR9iIP0=;
X-ME-Sender: <xms:BFbralGOCx28dDZdm66z9aURjXxpP0fvtXsiNUSjV-i3lk5IGZ0DMg>
    <xme:BFbrahRzFNdJ-MMpJktPhbpu_i4ilOZoO1XY_z0uww2kfsLQ7qJ1CI8VVvbrKBTou
    aLef2OdJRlJ0mWtfGowqRByJl6fvdq7_e0PVhjGWJAc_UeGqSanrQ>
X-ME-Received: <xmr:BFbrasxiq91_jGdrvG4PIW5tmWFq3LN2evheugd-bd_irY7tCndQFyDmY6vKB2ooBRH7Kbo>
X-ME-Proxy-Cause: dmFkZTFP9F9oJWwJG85mnHzfFOqny0OiD5iiWGUykvkiOCtsZJx63XeSWFS5hvnOTWaXXM
    pVNW68EmUAqObsBxHEoTqZGxr1uInZq5ObL120XJ6obWw31M/SqAAh2FRln8SyYDsBRQAc
    XgLSwbTYIIRAuqer3KFyQcFJVx1upExtgeuk4+nospz6pknGbvTFoQtONK00uHdyGa71ei
    05eeKL8ZFbs8tu8jIH8bDRz+5s8LGUqkWAZAgjQZeduYIONS+s4caycfiuwagcsfkJCBbf
    gsJbttQXJ4DA/1KBEx2aj29+xUBhITr/+i7EpjG9SxzktIlj30krZRuziPbpuPiywKxRV8
    PIIo048DUpgFP8LWy610EKZoNsPqATl0VrArC0TZHFfW3RRLPwbg4IHEQQtrHgf7uCaZiV
    djDZGI+tTEemcMJzDqebIkcdS8tWaMBeYVjuMiIxR5vcw9nbF8VzqH6UPsQ3dCrrSkhShY
    L07rt10BX7Q6VXbiSxVCMqNTCu0G03huk2L5Ky8mgfkAvllKG3V66rtPZJ18Dm3hTS/ux9
    hX9lKjkeE9tsYpDYcXDWhI1vspYqrWWpa1jQtAsJYz9HODjnXT0SuEIxfqrRgAYa/Mc5E5
    98TDdIK0auq/63obc5E+olb+Ap0akH1XOZZpIE9vxm4M2guhIlyFILcpdv7w
X-ME-Proxy: <xmx:BFbragPaQcENViyOYJdfInYEyDeCsYDZAUqmRVZIqZWplDVFl8vx2w>
    <xmx:BFbrarN60ajHT5hc23o2CPLNOAVOgf9u9PC93_LUXLOAGVZneqYJoQ>
    <xmx:BFbraiT9HC7Np4nMF8-BL_K3VMwDW2liGhUGf6lMGbESk7Ak3XQMXg>
    <xmx:BFbratAp9VEz0_axyWM9Or-a2s3hMRT7DXy7gqWQiHPfWWR4wrxzTg>
    <xmx:BFbrajWwvOANcuZrMPn2FL0Qaeo_7yWnePDi4y3PDb1MmiwgOfwdQsKC>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA for
 <git@vger.kernel.org>; Wed, 4 Nov 2026 10:57:56 -0500 (EST)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id 3acca8bc (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO)
	for <git@vger.kernel.org>;
	Wed, 4 Nov 2026 15:57:55 +0000 (UTC)
From: Patrick Steinhardt <ps@pks.im>
Date: Wed, 04 Nov 2026 16:57:29 +0100
Subject: [PATCH 07/10] commit-graph: fix mixup of write/verify flags
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
Message-Id: <20261104-pks-commit-graph-write-refactorings-v1-7-d013d9401a59@pks.im>
References: <20261104-pks-commit-graph-write-refactorings-v1-0-d013d9401a59@pks.im>
In-Reply-To: <20261104-pks-commit-graph-write-refactorings-v1-0-d013d9401a59@pks.im>
To: git@vger.kernel.org
Cc: 
X-Mailer: b4 0.15.2

While we already have flags specific to `verify_commit_graph()`, the
function also uses `COMMIT_GRAPH_WRITE_PROGRESS`. This mixup is a bit of
a footgun though, as it may easily happen that the value of that flag
is the exact same value as a future `COMMIT_GRAPH_VERIFY_*` flag.

Fix this mixup by introducing a new `COMMIT_GRAPH_VERIFY_PROGRESS` flag.
While at it, convert the verify flags into an enum.

Signed-off-by: Patrick Steinhardt <ps@pks.im>
---
 builtin/commit-graph.c | 4 ++--
 commit-graph.c         | 5 +++--
 commit-graph.h         | 8 ++++++--
 3 files changed, 11 insertions(+), 6 deletions(-)

diff --git a/builtin/commit-graph.c b/builtin/commit-graph.c
index f2c374d0176..09b09d6ac5c 100644
--- a/builtin/commit-graph.c
+++ b/builtin/commit-graph.c
@@ -70,9 +70,9 @@ static int cmd_commit_graph_verify(int argc,
 	char *graph_name;
 	char *chain_name;
 	enum { OPENED_NONE, OPENED_GRAPH, OPENED_CHAIN } opened = OPENED_NONE;
+	enum commit_graph_verify_flags flags = 0;
 	int fd;
 	struct stat st;
-	int flags = 0;
 	int incomplete_chain = 0;
 	int ret;
 	struct option options[] = {
@@ -97,7 +97,7 @@ static int cmd_commit_graph_verify(int argc,
 	if (opts.shallow)
 		flags |= COMMIT_GRAPH_VERIFY_SHALLOW;
 	if (opts.progress)
-		flags |= COMMIT_GRAPH_WRITE_PROGRESS;
+		flags |= COMMIT_GRAPH_VERIFY_PROGRESS;
 
 	dir = odb_source_files_find_dir(repo->objects, opts.obj_dir);
 	if (!dir)
diff --git a/commit-graph.c b/commit-graph.c
index 077213b5336..c82776b0667 100644
--- a/commit-graph.c
+++ b/commit-graph.c
@@ -2904,7 +2904,8 @@ static int verify_one_commit_graph(struct commit_graph *g,
 	return verify_commit_graph_error;
 }
 
-int verify_commit_graph(struct commit_graph *g, int flags)
+int verify_commit_graph(struct commit_graph *g,
+			enum commit_graph_verify_flags flags)
 {
 	struct progress *progress = NULL;
 	int local_error = 0;
@@ -2915,7 +2916,7 @@ int verify_commit_graph(struct commit_graph *g, int flags)
 		return 1;
 	}
 
-	if (flags & COMMIT_GRAPH_WRITE_PROGRESS) {
+	if (flags & COMMIT_GRAPH_VERIFY_PROGRESS) {
 		uint64_t total = g->num_commits;
 		if (!(flags & COMMIT_GRAPH_VERIFY_SHALLOW))
 			total += g->num_commits_in_base;
diff --git a/commit-graph.h b/commit-graph.h
index 0e03e82a04a..80d59bd23bd 100644
--- a/commit-graph.h
+++ b/commit-graph.h
@@ -199,9 +199,13 @@ int write_commit_graph(struct repository *r,
 		       const char *dir,
 		       const struct commit_graph_write_options *opts);
 
-#define COMMIT_GRAPH_VERIFY_SHALLOW	(1 << 0)
+enum commit_graph_verify_flags {
+	COMMIT_GRAPH_VERIFY_SHALLOW = (1 << 0),
+	COMMIT_GRAPH_VERIFY_PROGRESS = (1 << 1),
+};
 
-int verify_commit_graph(struct commit_graph *g, int flags);
+int verify_commit_graph(struct commit_graph *g,
+			enum commit_graph_verify_flags flags);
 
 void close_commit_graph(struct object_database *);
 void free_commit_graph(struct commit_graph *);

-- 
2.56.0.500.g5d06dc02cd.dirty

