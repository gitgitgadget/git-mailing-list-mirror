Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=103.168.172.157
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795088862;
	b=b4PLHkq5NGwCllXpf1EuXTy0S6HzPBTCgeLF6RauaPDPcJY8AG1J6lKWh+O8x868Zs1b
	 iYC1jXC/u0lILnzXLYPcaJfeAgEE8UEkaoPrZABQvLVdn/xoSsGTpgb6n++rjF2f77KAJ
	 mFTTOVUrX2gfRbq8p3GnVr/Ys/TwCRR2XsMwGRPUW9jml/zRaWIgKWMa0wAq7bX9QM90R
	 Two8iAknPwuKRd4/2DwOy18wFoQCy2wLBewZ0e7eKoydzJlT3Z9KBxUFERdU8Pyx5WK/3
	 7Cb3tdlZRs+KHP8MHZh4fOj4sxS3OQHyvhtAD9ZmPa31ByTnSJTqipR37o2td8JedZg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795088862;
	h=DMARC-Filter:Received:Received:DKIM-Signature:DKIM-Signature:
	 X-DKIM2-Info:DKIM2-Signature:X-DKIM2-Info:Message-Instance:
	 X-ME-Sender:X-ME-Received:X-ME-Proxy-Cause:X-ME-Proxy:Feedback-ID:
	 Received:Received:From:Date:Subject:MIME-Version:Content-Type:
	 Content-Transfer-Encoding:Message-Id:References:In-Reply-To:To:Cc:
	 X-Mailer;
	bh=kM5h+dvE65mQ/pEoh/iOXyzfb+nw7FtJSyG4q7oqnSk=;
	b=17P9rfMjKMx+t+W3JBFDpcJD/Vt1L8GVSp+xKY3+93kMbsjBRXrIjYQgmDPkRLlNO6om
	 oqnlzgHdAo82GGY4BcjPtCA8LAz1X7VAvevKE5D3YVXZzuIcKAXXHNxeeqqenLKbaEYJo
	 wNdNRBDfRktrnGm1+bMtC7pnlVtC1J+Q2IIBmtTJEDzkzAaBDYsXmVc9xd+9xTdb8z9Um
	 o/Gx24ArUgfP/cYVGEa1t0yjOWjY01yZ8r5m9yGA2C3QKVX9sXcrv3q9VlFgtQa/h8z55
	 yoZBLZYv4GAlMLFSvu1RrO4FEcW7mXjFRcfV93AnleRcZqYbKzqIACT/pN459WXGb3w==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=pks.im;
	spf=pass smtp.mailfrom=pks.im;
	dkim=pass header.d=pks.im header.i=@pks.im header.a=rsa-sha256 header.s=fm3 header.b=aJK1ozWq;
	dkim=pass header.d=messagingengine.com header.i=@messagingengine.com header.a=rsa-sha256 header.s=fm3 header.b=fBJSOrgd;
	arc=none smtp.remote-ip=103.168.172.157
Received: from fhigh-a6-smtp.messagingengine.com (fhigh-a6-smtp.messagingengine.com [103.168.172.157])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E38FF60A2608
	for <git@vger.kernel.org>; Thu, 19 Nov 2026 11:47:41 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org E38FF60A2608
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=pks.im header.i=@pks.im header.a=rsa-sha256 header.s=fm3 header.b=aJK1ozWq;
	dkim=pass (2048-bit key, unprotected) header.d=messagingengine.com header.i=@messagingengine.com header.a=rsa-sha256 header.s=fm3 header.b=fBJSOrgd
Received: from phl-compute-03.internal (phl-compute-03.internal [10.202.2.43])
	by mailfhigh.phl.internal (Postfix) with ESMTP id 0FA42140018D
	for <git@vger.kernel.org>; Thu, 19 Nov 2026 06:47:41 -0500 (EST)
Received: from phl-frontend-03 ([10.202.2.162])
  by phl-compute-03.internal (MEProxy); Thu, 19 Nov 2026 06:47:41 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm3; t=1795088861;
	 x=1795175261; bh=kM5h+dvE65mQ/pEoh/iOXyzfb+nw7FtJSyG4q7oqnSk=; b=
	aJK1ozWqPc9rN3L1IlR3dhU6r5t9DOF2U1guxej3aY16nFydcqmRu8pX1uPUbMSE
	51rJMyM5heAIV1jAFR+kATplUr5dbDi9dDs/+DyN0ZTaDOAFcBhTw4JOFM4xv6AH
	ilaRrXyS3qZ1lixzEAM7diJ3GidRd4CXeZ5PeIu6UVb8CdV58eW1sL6p4Y8BcV0q
	G5cOHbCL8UWl2sxbXCNb6a1Eu98Rm/nPvZtvF7oVQk3Kkbh49NGNqODyIVsrMkTI
	jc7NTkvPkT53N09n6ZK4ajEF4caGZ7Tx72avkzcIpLvElXsJs9LcHSeh08Gm+eqh
	JEglm2d0LC9Dh23eXGoHBQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1795088861; x=
	1795175261; bh=kM5h+dvE65mQ/pEoh/iOXyzfb+nw7FtJSyG4q7oqnSk=; b=f
	BJSOrgdHrz62r8MmtVUk5Vff4iCRGjhNW0BewuMm6PLkC8NwZwC1tkC3ZiC2D37n
	R511cGZjj6TDiWAwMSo4gNCGbq4924apa7FxvuKDXMDFCRlSq60foXa+P7UV2C85
	6NvHcAnu63vBMQrSMQNOjNMvvNlsgzA8XaXcPlK1Q/buT/vVA59F14ScoMrEdx82
	6mNaJYKc662SSDT9h0e0pIND4Cd8OYYErNFOpsCnkmJqqWz05szEXN6BfyxM1o14
	PwUkhquasYQfrNhGdL5dNnAVuuixtqZRD4UWZfDEjOGBNqIPWbHraneoZkywhgHQ
	JNhjmoB1JG01X6V7Ft2iw==
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-09;
	repo=github.com/dkim2wg/interop; date=2026-11-03; sw=lmtpprox;
	action=sign d=pks.im a=rsa-sha256;
DKIM2-Signature: i=1; m=1; t=1795088861; d=pks.im; mf=PHBzQHBrcy5pbT4=;
	rt=PGdpdEB2Z2VyLmtlcm5lbC5vcmc+;
	s=fm3:rsa-sha256:kFPWJcK2J+PXz+FxyAfBkipZT1xfELMpDqT8iP9oN9FMcsH
	BXC3ojdNbPj03khM7d9Z+ktrvq91g9BF3k6AYRlG71v4Ozu1IqvmFpHAiyqnnRhN
	Ji9chsr0bSGwprHTXZUqnuU/urty3QFFIVpEWfFhdOz+KPoHutO5MPs0b0tO+vzn
	62Id628WJTI8ZgkmtbDRoG2XF6hR0+40jlAzuPT7Pmrx2CMmSO8w5BCFRU2ijHct
	t0cU0Ynt4Hhxawp49hiNM7CmR3aqWnhUcf7UmBp15W5l5xBiNWYyQGzI1/VdlKJR
	yiei7ZA0fNzVe+ckl6o9mX99i+6wD2HMpZMx1MQ==;
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-09;
	repo=github.com/dkim2wg/interop; date=2026-11-03; sw=lmtpprox;
	action=mi-m=1; hc=12;
	hn=cc,content-transfer-encoding,content-type,date,feedback-id,
	from,in-reply-to,message-id,mime-version,references,subject,to;
Message-Instance: m=1; h=sha256:6j/kxtQt0lOoW236iw6O5VZkVQpkwGgBKCkKiC54Dco=:hWkRbLoEOvOQvgV/KiJQG4wr7jofgIiNVhyqFG1eqfI=;
X-ME-Sender: <xms:3OH-aoXn0ZuRduiHXV7GXFwqWKZGoIxvrENYONmZ8iMFXsHJ9W3z2Q>
    <xme:3OH-ajnSKxYAvAuhzBKfUafPuXBccSzF_oFQWgJ-16N3VLpFKvKvbbs7xZhwpGDKX
    laLfXeCUeZxryOvhNQVhFfgSN2NVC_lNHxVGVdDsi8zS4Oakdymkg4>
X-ME-Received: <xmr:3OH-ahbG_XeqH2RIx-F66dmug50HFEkhNN8pNC6IbH0LCn2bCs9pmB0WrIiDxHNzk7uqGu8>
X-ME-Proxy-Cause: dmFkZTGI8Ax+S5Me/90verxaIn26rbOdrgBU+Z55rUVHa2b94Uw9RFz5Wwhmi7v5FyLB5w
    6CHi7eXpcybp/lMu+8oIvVaGsAG8FArC//0h3DUnt51RCcTAyw6geuQb2O0CLwNQiDqTkN
    4XNJOBsfHpNr3iXTWWDaOnMpPdw+FjaMvgx20Vw07k2LpW1RKCl7llTSsg2R6N56E6dioE
    nCUNXLemFL7+F+fQt0wGtivP4IOCMI+AhDKX/Ku8nuNpH08fcCqlj3oDJUcg4Uk+6ly+Hg
    V51mzZENE93LXXI6tKTalM7QAOYM9/CpD34P77bNggn03kN97mLPQYLRXFC/FwL0RV4zOV
    KxhZrnQSG8+j5y8etIBWqEAE0pDzLAbBoooO1h1hjpAEbBvFENYkbsSbXasuqdEXh4E2dU
    UDqGYlY+fnuJTXX5UjIbZwrZGiTnkKFcSfKx/gsaUap045cNCApaYfgUvrmcaCddU3+sHb
    UpH2Nm2JyUDG56RHBHnGHFArff+jpv0e5PoL0i4VaEACk8eF4qnmDCiQIRVimDrVTxXuYJ
    30lYI1NUWnwjzQkEHMyABNYR0S502VrWIE/qGYGt3ErHhX7yBboGyjOzOjScHUQGE5k2s1
    zbkwFCma9i3Sa+4YfjM7P9MMCLWiqdigj1HAcvZ7dQAXKsQmcm890146Z1Mw
X-ME-Proxy: <xmx:3OH-amMpbaA413TVSJOshxduJ88bagVTlMrkzUKM1c7JYQLUhFUT5A>
    <xmx:3eH-aubGLhDAiPUdaMBQTaFBp3WIB32lAF2xoZMSVdDZs52vCJZU6g>
    <xmx:3eH-as2hOwna5lPG5YZ4C3FXZY3pRdmFwwfUJ1MrHS76LUcqe28Rtg>
    <xmx:3eH-asclqfj2jGF6QDmNqVE6zDrN2FEbMrWXS8mLbxpyj53mCaEHsg>
    <xmx:3eH-as4jd4_efp2AjH7oeFnV2WZZxkeQLfcABTQQwOhodtBeM94j24sQ>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 19 Nov 2026 06:47:39 -0500 (EST)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id dbbfe391 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Thu, 19 Nov 2026 11:47:39 +0000 (UTC)
From: Patrick Steinhardt <ps@pks.im>
Date: Thu, 19 Nov 2026 12:47:08 +0100
Subject: [PATCH v5 07/13] builtin/rerere: turn "status" into a proper
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
Message-Id: <20261119-pks-rerere-subcommands-v5-7-0c1092b88958@pks.im>
References: <20261119-pks-rerere-subcommands-v5-0-0c1092b88958@pks.im>
In-Reply-To: <20261119-pks-rerere-subcommands-v5-0-0c1092b88958@pks.im>
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
2.56.1.831.g720f3f5937.dirty

