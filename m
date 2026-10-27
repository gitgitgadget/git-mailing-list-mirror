Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=202.12.124.157
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793098042;
	b=KpIx6dhTosCOy8eBsxBIaOgJULbf6yb6UA7QWtGERSukMmHxDWPGOLFWMW8Krm87YqZp
	 RcFWOgEJ2lXlvUQnnNYBCKDKP/BwPXokHe9TRb2ZFCvbX3Uj76P+jCsPE17Hn1dSLWSCN
	 ib1z0JFna7H+4cuUTMVcenk1TjAOT6v0QmMkcXhv3ZJ/z4nPGTz5QHzQ0n9VYO8KIDlpV
	 kQ94L/rUPh7lB/WrJ+dWc2jd6xxa5+G+bOknOG7AJC0yc72RGe7NubAoqmxohOAr86G5/
	 qnInGjbIgnctlyHzcy+rINEEKGQA+YPGyinFmNg3dkH4egVFDvIV0N0UovUDYq8Dhyw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793098042;
	h=DMARC-Filter:Received:Received:DKIM-Signature:DKIM-Signature:
	 X-DKIM2-Info:DKIM2-Signature:X-DKIM2-Info:Message-Instance:
	 X-ME-Sender:X-ME-Received:X-ME-Proxy-Cause:X-ME-Proxy:Feedback-ID:
	 Received:Received:From:Date:Subject:MIME-Version:Content-Type:
	 Content-Transfer-Encoding:Message-Id:References:In-Reply-To:To:Cc:
	 X-Mailer;
	bh=eOQkwiKFIsR4NSZ41JrTlwh04XkcYAi0b77yEDwY3xc=;
	b=Jo1dWN7G7fFIviWPKpnA2j1sJRmaSiFxux2XNVtZZbcbz6y+0bk/Drk674uB7qNFLXWo
	 G/wygdDhHQZTsLzSAyA/I0DWASsElGJ6aoxo+Ezj/pJbo1Ke0MEdycop12WqM5boIj9OS
	 IYHoNU+55tsXEObWd8kEM/fFgdWZUrrcBzGh2ZDYW+UFiYgMxMCdHtEFa6ADwo+pSJBVD
	 n8PZ0Dd9YHvmFl2vGmLYqePcaxKEynTb39ddhPSaTa8rFO89BCY168aGPNqU2cFU1yd9/
	 zWbUrIeR1KTyeqFnXW7iutEwKvgEwznttn0Xw6PPhZ55om/1j4zs3A7W09/ieCBpgNg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=pks.im;
	spf=pass smtp.mailfrom=pks.im;
	dkim=pass header.d=pks.im header.i=@pks.im header.a=rsa-sha256 header.s=fm2 header.b=dTTfyJCk;
	dkim=pass header.d=messagingengine.com header.i=@messagingengine.com header.a=rsa-sha256 header.s=fm2 header.b="FEVZnBK/";
	arc=none smtp.remote-ip=202.12.124.157
Received: from fhigh-b6-smtp.messagingengine.com (fhigh-b6-smtp.messagingengine.com [202.12.124.157])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 45C05606A31B
	for <git@vger.kernel.org>; Tue, 27 Oct 2026 10:47:22 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 45C05606A31B
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=pks.im header.i=@pks.im header.a=rsa-sha256 header.s=fm2 header.b=dTTfyJCk;
	dkim=pass (2048-bit key, unprotected) header.d=messagingengine.com header.i=@messagingengine.com header.a=rsa-sha256 header.s=fm2 header.b=FEVZnBK/
Received: from phl-compute-01.internal (phl-compute-01.internal [10.202.2.41])
	by mailfhigh.stl.internal (Postfix) with ESMTP id 993907A00CE
	for <git@vger.kernel.org>; Tue, 27 Oct 2026 06:47:21 -0400 (EDT)
Received: from phl-frontend-04 ([10.202.2.163])
  by phl-compute-01.internal (MEProxy); Tue, 27 Oct 2026 06:47:21 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm2; t=1793098041;
	 x=1793184441; bh=eOQkwiKFIsR4NSZ41JrTlwh04XkcYAi0b77yEDwY3xc=; b=
	dTTfyJCkbLG7KyjivB8PgNH24TIg37mrDLLtfTcfH+nLFBNGwUkn9XpfEDU95+lg
	AiGdoI5GAUTfDGBwEHE51CgQo8KDOmLyvX7Sj/Ep/eeujxXYOp8dUyj3bxcgLR2k
	nidONoogKJuWu6d3Zmr9rU2/XP/V8EE70UddvXupuuusdMGlKebXmzUtNgcrUXDT
	BWso/C8/DAsDimzrmHtOQ0VA+N9zjTn2S7GIfXnRToM+ricc/c4gLkOuI92M9Kox
	eoEz1Or6WX/qllxjaMi9oHotwxOff9iC2X8d9ccLgbxj4CeUdYu+klGAMDQtgDAq
	Q98Od+QAkc5WknRCxktf9A==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1793098041; x=
	1793184441; bh=eOQkwiKFIsR4NSZ41JrTlwh04XkcYAi0b77yEDwY3xc=; b=F
	EVZnBK/Uq87XMPJjTrNy8BlmEHkPjkSLAduG1YYDOxRPE6YXur1ldu44kK/i+i25
	6fArrJ7dU35PxF66RLS98KhRKJKjidFBD2EVAi0udyYNShJNPLW6xRm6HbAaTX4/
	17doh6DBK8lmjCrRVHLQ6LJreLEl78AOmay/TnnakNem1RE2G9QUfH78yCCywJM6
	SlnwiNm0USxcjxMWfQeAUdPqk+RtzSJKK7wS5OHcnjIayB+q9+kPzb80G1c9cViI
	BScIiOM559VhFTujZJ9h5ZO3O6AYUh6G7tBQVVbXzyuKEsaFerNbnhtmv5+FuPMn
	au6zAsIdjo0FmqBsSrzpw==
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-07;
	repo=github.com/dkim2wg/interop; date=2026-10-18; sw=lmtpprox;
	action=sign d=pks.im a=rsa-sha256;
DKIM2-Signature: i=1; m=1; t=1793098041; d=pks.im; mf=PHBzQHBrcy5pbT4=;
	rt=PGdpdEB2Z2VyLmtlcm5lbC5vcmc+;
	s=fm2:rsa-sha256:mbh6/dJbSX/1/j7jhpP9po7GN646sveeGLXMrN45HL9aYmL
	O/ZymoD7EAjWh9VfOOKOaWQALpABl4hrGwtlhhgjIl6q4ngaoYSyuMV9YPgRcLqI
	rVfo7c7wAXnM67jbBwQ4ri61mf4bahkVlmT8uqILSBdguCYtYnOrERaiglXM2gx3
	KAvLqAGSNqEadNw3nMj26lHoSc0egDSrB8qocFH8RFfmkiDXLdwptZUOn6mNQilb
	V5fFlKssSfr/V3q6Y8bX6ExOY1lYOslfYDhSa3l1K6Rh0oz00nLt179IVfVYmTbp
	Kna5Yk1OEdtEPYkcH6crt/8/6yFwUZCoEW2rKwA==;
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-07;
	repo=github.com/dkim2wg/interop; date=2026-10-18; sw=lmtpprox;
	action=mi-m=1; hc=12;
	hn=cc,content-transfer-encoding,content-type,date,feedback-id,
	from,in-reply-to,message-id,mime-version,references,subject,to;
Message-Instance: m=1; h=sha256:zFGNAV4rsJRea4ZYK6ncp2x2srCnG1MZ/83a8kWNzT8=:/9iBaFhbzEaB8ciAIOiVBuROxR4GCUPb/U6CFjT3K0Q=;
X-ME-Sender: <xms:OYHgaiRvFCOXrOM0PHi6AsTe1zAsZm5Eozztf1oR_2Rud6XUtafBFA>
    <xme:OYHgauu-XZ8pTa8nhWBFL1kJONQGkZ7NqHIcZMh4oZ3BmuFKjX3BGiaqd7dzZB5KU
    oAQBgGFOQfbh8GArU2YfFlAcT2nO-npHWSPbf5uZjKE9tQm4ViSzA>
X-ME-Received: <xmr:OYHgalfXN1vdIGiysxvwO46mItSpvotZ00ZN4JdSdI7qp474wqW3yQ>
X-ME-Proxy-Cause: dmFkZTFQAhMj+d0VRKgbWkhQwzvS4rn6woO60XWJgpMQw13+GFEJ7sBYn1M9REZbRMminc
    RV4HpjduuDdThTCjnqvWCotDxzb41XrrctGzW39RSaf3bCqRXQVyuBlJpA6NeQKCmf8Rcn
    YhvWf9p3ep+Rx4eE7VUYOyHZTFzVJD3BoV22KZdB1856Bsa6txC7gvZtr4r5EUiPFvuIQP
    v3xzl5KrEOx7einZ5pRDQDHnGKWM2TfCMzw1sxuo2PA8whmwT3udzd4Epz6l1Kg35uo/Gy
    F+NTFyuktJVVE1HRJX1RSJxl0p0jrURqk2jdSpsm3DvLx9EvAQgO5G2SJTmtA/kzNjBzg0
    t79zPZtdM6lR0HIat1e9B0u45vXT1/2lwSPMgxegzQ9jIIvkArOLxJ2XJwhrfAwy+/onoY
    xwVmQBn+8fzW/pFWXrKaiWEAqF/hQKHwhsti2FneflQuNFBRLdx0GraSQjFR6pWiLXX0is
    G6IxAp1ZtAiNCML3JOH6ZA9ImCOt+2Ox4Q1N6MfGLzKyAoNea3Xue9GO5VKzwohew2af8x
    LNvMcT/xvzxZmqewCpwLXsysr5tLyqct5DXvSWGI4Bl47PxN7Sihoro3VcHo+8MbqojUV3
    C2HAX2r8QFBVmrjNJHHcdrt/oN28yEhje0kEPhNFgBmPrYRGMfOicrvzxgSg
X-ME-Proxy: <xmx:OYHgajJb6GAFpydIcePry2091puEK_swoUXP4URFjOgxsPOL7Vsxlg>
    <xmx:OYHgara1GhSKah-hSPwOJSlmB9jdYA9ACX7K-BBKtwekR0vGANj07g>
    <xmx:OYHgamvPE6gQqMuDokaaqHv5KVKrU6ToWTuDEFQk7mpLF04CeBh6qg>
    <xmx:OYHgagt8bGw3se1LrWjWgVc8IS6FPLGGYTmWTR7BKXC3yZXXynepfQ>
    <xmx:OYHgaiTbUeCxh0C2BBNj5fa54-v_j2eY9osH2Y4fvRbbvqhWd96Zw2oN>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA for
 <git@vger.kernel.org>; Tue, 27 Oct 2026 06:47:20 -0400 (EDT)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id a0677e62 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO)
	for <git@vger.kernel.org>;
	Tue, 27 Oct 2026 10:47:19 +0000 (UTC)
From: Patrick Steinhardt <ps@pks.im>
Date: Tue, 27 Oct 2026 11:46:50 +0100
Subject: [PATCH 07/12] builtin/rerere: turn "status" into a proper
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
Message-Id: <20261027-pks-rerere-subcommands-v1-7-d836c36ce0c5@pks.im>
References: <20261027-pks-rerere-subcommands-v1-0-d836c36ce0c5@pks.im>
In-Reply-To: <20261027-pks-rerere-subcommands-v1-0-d836c36ce0c5@pks.im>
To: git@vger.kernel.org
Cc: 
X-Mailer: b4 0.15.2

As explained in a preceding commit, a subsequent commit will introduce
proper subcommands as supported by our parse-options subsystem. Refactor
the "status" subcommand to use parse-options as a preparatory step.

Signed-off-by: Patrick Steinhardt <ps@pks.im>
---
 builtin/rerere.c | 40 +++++++++++++++++++++++++++++-----------
 1 file changed, 29 insertions(+), 11 deletions(-)

diff --git a/builtin/rerere.c b/builtin/rerere.c
index 96e98bc411c..e2955fea20e 100644
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
2.56.0.341.g393f52fd96.dirty

