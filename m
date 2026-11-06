Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=202.12.124.157
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793978071;
	b=YVSi7QZGoChRrNhNIEe37GZypsMdKps/qj5Q2C/Dmo/he7IkG7Sd9Bhb1DsWjALmDrtK
	 0w0v8TZ/KIGdNqVOPnfTLsGo+2qjMmNNPmU+AdRRvOa0VQILfvnZUdz4EGtDRHQ/RSZ7b
	 aRdx2N/Wtrbb2S4lMgkMsx8lxcmqoCAOwUnjvxWnf3iuUZ3p1mjmkcRPElARydxRTzRGa
	 6oswcGzbDGoMdaKb+RGnZ+FYUuvh4KF/6ipJ9UXaTg1YBvzE9IJTDvl9vttIVopGtWabg
	 lOtF3WOuDkCo7M+L64d5sIjV7rlIEPUiTAAL1vHfsa+AAxIlD9n3eWkBOc8oJZZPSmQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793978071;
	h=DMARC-Filter:Received:Received:DKIM-Signature:DKIM-Signature:
	 X-DKIM2-Info:DKIM2-Signature:X-DKIM2-Info:Message-Instance:
	 X-ME-Sender:X-ME-Received:X-ME-Proxy-Cause:X-ME-Proxy:Feedback-ID:
	 Received:Received:From:Date:Subject:MIME-Version:Content-Type:
	 Content-Transfer-Encoding:Message-Id:References:In-Reply-To:To:Cc:
	 X-Mailer;
	bh=48ELPAmJjhTh6osXNbgzgvuKYc1Py//FpTWfUy01+2k=;
	b=4uNLco/GSAgM9BtBn1CxFH8LQB46pT9o40FJmfm3V9hL9YQ3CZul2i7JCQRu2CJRIEww
	 atAd5lsjX/tE2W1+1qAbTQ1Z1vQML3b3EIY1iZXecWvCzGHiRc/srUwEn0hsvboPwnHyL
	 Gt+MEfjFnemDEip3NV7mlj+y8jHhat7TOK4kW4hZCb/m1LaFY1foMSPfMkGfONV0atY3y
	 2T326gObVqnImUJb6StD3xe55CLRyeybiMDYUYrW3dXCgoOyQwK0IKDEj/5mFGz/SbV5o
	 TOshORtbZW67wVso4b4owJNw1LQ3zHAubmSABwPaSiE1pP2vRHZN61erwuPOPVipV/A==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=pks.im;
	spf=pass smtp.mailfrom=pks.im;
	dkim=pass header.d=pks.im header.i=@pks.im header.a=rsa-sha256 header.s=fm3 header.b=pW987zpS;
	dkim=pass header.d=messagingengine.com header.i=@messagingengine.com header.a=rsa-sha256 header.s=fm3 header.b=g3RlYPjy;
	arc=none smtp.remote-ip=202.12.124.157
Received: from fhigh-b6-smtp.messagingengine.com (fhigh-b6-smtp.messagingengine.com [202.12.124.157])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 51FBC606A32C
	for <git@vger.kernel.org>; Fri,  6 Nov 2026 15:14:30 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 51FBC606A32C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=pks.im header.i=@pks.im header.a=rsa-sha256 header.s=fm3 header.b=pW987zpS;
	dkim=pass (2048-bit key, unprotected) header.d=messagingengine.com header.i=@messagingengine.com header.a=rsa-sha256 header.s=fm3 header.b=g3RlYPjy
Received: from phl-compute-06.internal (phl-compute-06.internal [10.202.2.46])
	by mailfhigh.stl.internal (Postfix) with ESMTP id D34407A008A
	for <git@vger.kernel.org>; Fri,  6 Nov 2026 10:14:29 -0500 (EST)
Received: from phl-frontend-04 ([10.202.2.163])
  by phl-compute-06.internal (MEProxy); Fri, 06 Nov 2026 10:14:29 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm3; t=1793978069;
	 x=1794064469; bh=48ELPAmJjhTh6osXNbgzgvuKYc1Py//FpTWfUy01+2k=; b=
	pW987zpSE3lz5kQ2ircsXJyFW4+pptXKWwTkuT8iFgJMxqxEt/fFrVYcjYItmlAE
	TbxrIVxww1Ne+4RNNgahrVRmrij1SdUMglu6BTqmEd/fgymbkPuGaS/OI14ywasA
	DX6bwFBQP7/MFh9Mr7eLL5zK/1TkXy22jGtaEYXa7EUEf2KtZK3w9j63Yq2ycUeL
	C4OVirSsksM8ATc/RWxUgfdTxRhv0n3SzkbokM8/vmAndIJFFjSPcL3HYy3JPK/Z
	k5CZjqXdjMTFnF4/S3yPdFg3pODoVYNCODU/rX+itNTL5HfLnarfxDXNPmBP1Yw8
	Z+qGUZNU4xsXp0D5RPX14w==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1793978069; x=
	1794064469; bh=48ELPAmJjhTh6osXNbgzgvuKYc1Py//FpTWfUy01+2k=; b=g
	3RlYPjyKn+RcXh3hVkyQAJHhAGTRxb+kwSX6vYdI4nN01MaMVuEM29MYkm51231c
	5hqkEIjs+RibtNneYIyZsaSQT3brV49UaqrW2M5tygvUuenB6NWcYvZDn7PNwTO7
	DzYSeUNNmSzawJXF9sWioWGdotFpVqjYCY6KduCrzn48Tt7n54bjmvBFOGz1GYab
	fPCWc0l1S2q+eJixqQAMO/CKNGJGfkefwN70JeIaELXpkeIPLTkfOOS5BJ3LX99d
	OO2jUXjLY9Inw57f8/sFrWUpoLEoM3Dszp9pTaLUPJ3w2Ek8llHbzK2YW6pWLwe1
	JuM2nHSLj2bciyim1WgWg==
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-09;
	repo=github.com/dkim2wg/interop; date=2026-11-03; sw=lmtpprox;
	action=sign d=pks.im a=rsa-sha256;
DKIM2-Signature: i=1; m=1; t=1793978069; d=pks.im; mf=PHBzQHBrcy5pbT4=;
	rt=PGdpdEB2Z2VyLmtlcm5lbC5vcmc+;
	s=fm3:rsa-sha256:LLokONS7zezEXYH04deQ4trHh7k7qPgb9mzXHKw13bNCBaN
	P9VOjhDurkp7T7qibzytaCg5K5HgheX6RHNnqYoLXBSuwkUbhtof60hfj9wnMlhR
	vPkgfb3gYI2hcLTk62oITxwUqxzOKtFFT4NvVfe7Bh761q2sZ6VBjcNoxSRQ3rnC
	bD1CQd6khzCneSivatpuF97RFHgCNN2golncJbCkdEFMG2XZkFkIFFfQPrkpnNtR
	SYtq6VU2IqTxrRfzh/kvEZ77ermutk1P9w5JmSvctLl+FcBjjpVZfi7li/xe2HGV
	RPfVDvt+RsAKH/PJ6eGUReMqPjj1FfqzFpMI5zw==;
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-09;
	repo=github.com/dkim2wg/interop; date=2026-11-03; sw=lmtpprox;
	action=mi-m=1; hc=12;
	hn=cc,content-transfer-encoding,content-type,date,feedback-id,
	from,in-reply-to,message-id,mime-version,references,subject,to;
Message-Instance: m=1; h=sha256:/wk27Kqnzu5k42pnwNl7LMaq96DBsLxP38J9BQUI3sc=:9dmNM07Zz+hsy/PvhVQlf0y1F4AmMv1QQIzFMSy/uM0=;
X-ME-Sender: <xms:1e7taqDkouCe_Z5KC7mn_Quk7pZeNCnkMW_d7t5yowxSM_YoE4ZRnQ>
    <xme:1e7tarjYceXAa0plSnQrr7NyrYCITXb_N3X5KuXE_2mDGntzugIVigQ3mkIDg_LC5
    Gd2jOJmeWfPw3f6JFLlGc_KmrRmnUsj88jxdtbKLrn1dWlBz9zXSUk>
X-ME-Received: <xmr:1e7taimkuMHGr_xJLdd_FZFtzQcs2tt0Gr-lp0dlmL916vT-rVY4aA4r6vlAjpIIutfkbA>
X-ME-Proxy-Cause: dmFkZTFpG1n8BNjrOjL9sUhDw3ZiP4mtgTk1U3/fCZUgMmr4wlQPFq/1BnXTuXw+zlS6mE
    IootibMXKeybvuZS0F3Yl3ONkICg0FdWX43CJz0MizalQ8U974cAXPiWoPbZL736ZnzCO8
    EtZYWO3+BkHKQalNcN1fXtfVzPi/xvBnpUp03+88tRsq0flFwtX3krA66QaVLRCtO0jyzT
    QGpB1Esb6lCXsgSSEoGleb1C2sdrFLHGOqn+Comvczkv/UdY1E3MphcIfbyMG6XxkZYVIW
    /gH+dST+86WdOm7ctQVetJGB/OBHpugz5WE4LKZe182sP1CEPsX1V+0sw13sos7UzXA8iu
    HUGGsygH0KPymGB0cGDi6sDVE7QklzvrFArbORaXn5rNNsYKt0mZqWxDW52KtLh8E5bU/E
    kzNDey4IJizbDxlx2bMGPiZevhZR+UlbHVk5FarOCYck7hhiKpnnFL1k91+HsFNrArvH3J
    6JyA9GZwK7TTXGTg0NouY6u/txpaxw60nMVqxxCuPJ+EEzFPHDjjoKYoxmPiCU0V5wN61q
    GvjXaiXvUhqQvNrj6n5QWSniMNgojtl7xpqHO4/U+mCErSykM0jA6ipxm032FQnX9kgpBb
    w9WEgruKYdJnpa2nm+AjHeRobPtweyvwLVOETHlDm9tzv27UX760Dw0XoWLQ
X-ME-Proxy: <xmx:1e7tanrJBhwd7VRL3gy5_4rP6TmNKDfC2Qj_4jYXDwHDMFMOYWfAow>
    <xmx:1e7tarGaoD2tJsbsi-0DUvwGZdv-xlkfvscHGahlS4SnGk9RCd8uIw>
    <xmx:1e7tajwxH_D3nFL6jJ_aoFqY7v7_-KKxKeFFKTQDJORNyu4Klr5ZBA>
    <xmx:1e7tagryvjZPSNELWj4Z1iz1ylElrmWIetFsxxC_89l1hTlnF-07Tg>
    <xmx:1e7taqE3OkxSg2D-VCR9Anqavf9nEkhbyCHogwrmAmHrXRSnW0JbktTo>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 6 Nov 2026 10:14:28 -0500 (EST)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id 7509803a (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Fri, 6 Nov 2026 15:14:28 +0000 (UTC)
From: Patrick Steinhardt <ps@pks.im>
Date: Fri, 06 Nov 2026 16:14:01 +0100
Subject: [PATCH v3 07/12] builtin/rerere: turn "status" into a proper
 subcommand
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
Message-Id: <20261106-pks-rerere-subcommands-v3-7-4ff164d8fb81@pks.im>
References: <20261106-pks-rerere-subcommands-v3-0-4ff164d8fb81@pks.im>
In-Reply-To: <20261106-pks-rerere-subcommands-v3-0-4ff164d8fb81@pks.im>
To: git@vger.kernel.org
Cc: "Mark C. Chu-Carroll" <markchucarroll@fastmail.com>, 
 Junio C Hamano <gitster@pobox.com>, Karthik Nayak <karthik.188@gmail.com>
X-Mailer: b4 0.15.2

As explained in a preceding commit, a subsequent commit will introduce
proper subcommands as supported by our parse-options subsystem. Refactor
the "status" subcommand to use parse-options as a preparatory step.

Signed-off-by: Patrick Steinhardt <ps@pks.im>
---
 builtin/rerere.c | 40 +++++++++++++++++++++++++++++-----------
 1 file changed, 29 insertions(+), 11 deletions(-)

diff --git a/builtin/rerere.c b/builtin/rerere.c
index 62f69b488b0..2bcd270a1f1 100644
--- a/builtin/rerere.c
+++ b/builtin/rerere.c
@@ -94,6 +94,32 @@ static int cmd_rerere_forget(int argc,
 	return ret;
 }
 
+static int cmd_rerere_status(int argc,
+			     const char **argv,
+			     const char *prefix,
+			     struct repository *repo)
+{
+	struct option options[] = {
+		OPT_END(),
+	};
+	struct string_list merge_rr = STRING_LIST_INIT_DUP;
+	struct rerere_cache cache;
+
+	argc = parse_options(argc, argv, prefix, options, rerere_usage, 0);
+	if (argc)
+		usage(_("too many arguments"));
+
+	if (rerere_cache_setup(&cache, repo, &merge_rr,
+			       RERERE_READONLY) < 0)
+		return 0;
+	for (size_t i = 0; i < merge_rr.nr; i++)
+		printf("%s\n", merge_rr.items[i].string);
+
+	string_list_clear(&merge_rr, 1);
+	rerere_cache_release(&cache);
+	return 0;
+}
+
 int cmd_rerere(int argc,
 	       const char **argv,
 	       const char *prefix,
@@ -132,17 +158,9 @@ int cmd_rerere(int argc,
 	} else if (!strcmp(argv[0], "gc"))
 		rerere_gc(repo, &merge_rr,
 			  skip_locked ? RERERE_NOWAIT : 0);
-	else if (!strcmp(argv[0], "status")) {
-		struct rerere_cache cache;
-
-		if (rerere_cache_setup(&cache, repo, &merge_rr,
-				       RERERE_READONLY) < 0)
-			return 0;
-		for (size_t i = 0; i < merge_rr.nr; i++)
-			printf("%s\n", merge_rr.items[i].string);
-
-		rerere_cache_release(&cache);
-	} else if (!strcmp(argv[0], "remaining")) {
+	else if (!strcmp(argv[0], "status"))
+		return cmd_rerere_status(argc, argv, prefix, repo);
+	else if (!strcmp(argv[0], "remaining")) {
 		rerere_remaining(repo, &merge_rr);
 		for (size_t i = 0; i < merge_rr.nr; i++) {
 			if (merge_rr.items[i].util != RERERE_RESOLVED)

-- 
2.56.0.500.g5d06dc02cd.dirty

