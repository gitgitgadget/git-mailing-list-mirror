Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=202.12.124.153
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793267861;
	b=mIARft1wZz6H6JUFcrezD4zQzH/HOIwHBz9O9PgT0b7jzkp5CbQeSiU11gEQm/dqDrvR
	 3TK9eu7Bp+ncKb208XmjiDBCzo8gfFIhyEKgTIKs5MKGWBiVFYObVD6Tuol/zhY55Cfx7
	 q4Sk1EYxwJSFfQJmES3T4rjAmrFf0qIFvd7B2Bex5IRylZcjyxFervNca/J+bqv2haIr4
	 fzwJcfbJpXvrWGkpWSwnmVg/WPrVQvMtDLg62KgEStoZGzQxZJRMBN52bMVcV7os6N5M8
	 1gkIvqoD9a9OmWm7L/+Yj3d+x6yW3VNNDoKsxeZEas3qs2PtfJeC6ZJnoBrMGMI2tPg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793267861;
	h=DMARC-Filter:Received:Received:DKIM-Signature:DKIM-Signature:
	 X-DKIM2-Info:DKIM2-Signature:X-DKIM2-Info:Message-Instance:
	 X-ME-Sender:X-ME-Received:X-ME-Proxy-Cause:X-ME-Proxy:Feedback-ID:
	 Received:Received:From:Date:Subject:MIME-Version:Content-Type:
	 Content-Transfer-Encoding:Message-Id:References:In-Reply-To:To:Cc:
	 X-Mailer;
	bh=jeJhoejj84yjypkiHWvOUQMBSm85kLPD6CCO+YWpeow=;
	b=W4/ciwcw2Kz6Id0vB5O7GBv0h9cooZy3U69tIjqq7Cubydf8BU9hD5CF4cbkRCzhHZaJ
	 GMZrG7N8utzQ1AiXjs1J5NWgSTRuU/ChpAM71U23knd2i+wQ6E0VXFg+eQutqdrq9nAr1
	 /VEbbJoTVCdWsbDGHSGt1c+fshqVr8aoY0VO1mKTCRFcsqEKKcNabCy4b8o0p96Gl1AiB
	 /R/Om9PmPsBLEIduDK9EauO5dJhoMEtWtizO8w607CtbKTZ7vjroDu4gqmbC75Bb8JiM4
	 gl6NQ/3hKtCMYmb/YMjImoXALRB/9zbFPxp68+2i8HFJBmL5uIZwWMsMSYddmgtX/kg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=pks.im;
	spf=pass smtp.mailfrom=pks.im;
	dkim=pass header.d=pks.im header.i=@pks.im header.a=rsa-sha256 header.s=fm2 header.b=hMTViGB3;
	dkim=pass header.d=messagingengine.com header.i=@messagingengine.com header.a=rsa-sha256 header.s=fm2 header.b="nK/sNuP7";
	arc=none smtp.remote-ip=202.12.124.153
Received: from fhigh-b2-smtp.messagingengine.com (fhigh-b2-smtp.messagingengine.com [202.12.124.153])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 639D0606A323
	for <git@vger.kernel.org>; Thu, 29 Oct 2026 09:57:41 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 639D0606A323
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=pks.im header.i=@pks.im header.a=rsa-sha256 header.s=fm2 header.b=hMTViGB3;
	dkim=pass (2048-bit key, unprotected) header.d=messagingengine.com header.i=@messagingengine.com header.a=rsa-sha256 header.s=fm2 header.b=nK/sNuP7
Received: from phl-compute-07.internal (phl-compute-07.internal [10.202.2.47])
	by mailfhigh.stl.internal (Postfix) with ESMTP id B56307A0156
	for <git@vger.kernel.org>; Thu, 29 Oct 2026 05:57:40 -0400 (EDT)
Received: from phl-frontend-03 ([10.202.2.162])
  by phl-compute-07.internal (MEProxy); Thu, 29 Oct 2026 05:57:40 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm2; t=1793267860;
	 x=1793354260; bh=jeJhoejj84yjypkiHWvOUQMBSm85kLPD6CCO+YWpeow=; b=
	hMTViGB3v+deKRM0oiN9iF+AVPxgmx3uMRdnLr2/INXzaMRcQo/awY8Hx8G0X+pW
	Bh90YkjwuSFOXM97tqFts84YzcfLU8FID+CFHmHeS2lRI29nxFA5vn3NfXrwpccz
	7rRARoSKNfZl+HZp7+edNQ279rNnDehRhbDjDfNZ17qxEhQWXSg6HVWwGoQyfd/w
	APbk10pwuEC1NG4tlqcaLFmYcV1FXdg9Wo/mURdAkaSOJx6u+kb3F3jWQuKncxYL
	rHjfHVnWrr+H5hNHjBoR8PUiGFM3vR98oRuRVnt7KF6CxIzMQGX8C68bMQVHElVu
	LIGMFkzy/04Wsim+3BWB5w==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1793267860; x=
	1793354260; bh=jeJhoejj84yjypkiHWvOUQMBSm85kLPD6CCO+YWpeow=; b=n
	K/sNuP7DegwXduFMO8AtgqLnP2SAHeatCPQXKrwouIwFfrjVErFeNftCZbPRAfQe
	/+gJF/xdRfMAtabJDSB/Sttz/VkULHMoId1AfYF/hcXPsRTuYZvOiWIVJ2WaXBta
	bbRUCEe3PtwUp3wr+l1Dp1yb+GVBxk0/+utfmof1VUfjgDPbKRvZ7BOEYILRMTg3
	v2x73owyvWs9wxaEQm/VZGQQ0p93vuP6n4cbhCJbVQpFR/DV6zRmEZVbznMZiaoI
	S3sqTnwKASOei+tc2OUI0zcHOjqyUu0+Fg2buF9TWSsIsGBcLAY2yd5QhonqsK3L
	hKzj5m6fvcwMnKEDII15Q==
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-08;
	repo=github.com/dkim2wg/interop; date=2026-10-28; sw=lmtpprox;
	action=sign d=pks.im a=rsa-sha256;
DKIM2-Signature: i=1; m=1; t=1793267860; d=pks.im; mf=PHBzQHBrcy5pbT4=;
	rt=PGdpdEB2Z2VyLmtlcm5lbC5vcmc+;
	s=fm2:rsa-sha256:Py+HD68y1/bv9G8JADvsLla4cT7dg+7c3XMnxyiN/PUjIWd
	yj4tcjDBbvWUbQlzy6r3LkmMaz8PQvpF5riPVSaj8RhWhy4GCtp7AN78jqxvf64b
	HX4IzL06numQsCHfpbMY+cuOIU6iKeuxpu5OG3KsAXeSsvc/FemRMPXGvkZxVPhH
	gkAzqCd7x2mPxMqAWrgr2WiJPykBexR125OKv5YLS4BIDscAK6LttxR8rVn6I5BA
	ocx1h/GBTkqZplIZ7moAI4lCDF5rI+2r5Ut7ov6XxgTeyPdV5gLVvXverAA9WU3s
	vga4I49Fa64YHodWT4rbXstqj4w1dA2rcvf8gpw==;
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-08;
	repo=github.com/dkim2wg/interop; date=2026-10-28; sw=lmtpprox;
	action=mi-m=1; hc=12;
	hn=cc,content-transfer-encoding,content-type,date,feedback-id,
	from,in-reply-to,message-id,mime-version,references,subject,to;
Message-Instance: m=1; h=sha256:J/aNdO/XYQeXOjJoE9ofh8iVyE0PahTfSip94BCdHs8=:zFs1YAgGv0i+JZ8+KacJTbUvsTP8u/wPwRHGGXUEM6g=;
X-ME-Sender: <xms:lBjjar8PlIYK__pGG76phuFxYy1BVByWcWayaM6f4Mjx0lxbmyX1hA>
    <xme:lBjjavJFFiuSBArP7vmoBFqa5DS9lFQUU2elL_tQKOUlrK0Squf3Cq0AdtKpMJKtX
    80sR71GiDmWRNYGudmF0LiXi0B6rpUTxLyDK4h5YxX-TAqLhCc2LlE>
X-ME-Received: <xmr:lBjjamY86ebGPeQr428Om5sFHlzvUGILD2aJ6NsuGJYCWFEV7P9NMw>
X-ME-Proxy-Cause: dmFkZTGN6oeJR7otfSSVvdw42gSnuM/vOiOuTFBIRXaaTX+WyfNptir2dKNLWXae0Ccg/H
    Dw0kdIlCEIriHaB/16Z4yhETxZy9WpWVbCV5No/000ftN4GNucPScoQ5KkAWUzjoZWT0y/
    4K+z8cN8RbbwmEbCVA2o3dxUR234Pvg7fa8zCjVDYwZ4a88+TvOSFTJqaXKepL5aLugymQ
    94eqDXIHH+KgCM/ysQAVHXtzWZ+jp+UH8ANfqy8XQANds0O69Nn3IcrRQjn65hWQ4o24gk
    +sSNI7PSlqQEftXcXQKG4q+6scpPc+oCvIFhg4XMKrhkbLuMtLc2NHSNJl7zBq44s+shdJ
    ONgjlUbOCu8XsXNFB7KcKde2OHMHjuakhS1+2wRSnjldhxEkz48n0Acsm31Jk5QpCfrUKN
    jViSXMS17SUECm+y5Ply/tzT4fPIxhOw8iCt9O52iQK4SdtTr9/66cjuPBsO6aYRW3Yw05
    +yRl2VcTwRx7ABTegp/GWwH5y4BOeYKWez+thRWjuXHAcy8FXbGfkEBUtZyfHi3lJ6T2ek
    3CrSJ5H6EZ5GIie5MZlTpaCZFsuKnOJkhoZZae++yuV/Hh20z2kcI9Qot4+r17xOa0wFfq
    QMqFAHJrvTY9LE+3CgNmD5ifn7338KUaDKitn2dNXI4b/CIxX+PbBYKiZi2w
X-ME-Proxy: <xmx:lBjjahLfZOiuQI9hVoswiHdYdDBWy4dugSYkSPzfy3cdAh86l63WnQ>
    <xmx:lBjjakCiVj4Z_eZhODbN59XMV_MVeWBsUMbGrXWVaKbvSGkVnoSJsQ>
    <xmx:lBjjamoWOn5Y5W63M4vP5DkDnPrpreznczF9xJdC6IPL1J7HxO1cSw>
    <xmx:lBjjavjQafIQxgNAfVL3WEexxkqgjmVEev2MPWwbiKZwdgD8CLh1Ng>
    <xmx:lBjjal8ykvkrnNebX7uXPlSLx85oiMsTwLbBddXAdkxi1Sptknah1zMW>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 29 Oct 2026 05:57:39 -0400 (EDT)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id ba657630 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Thu, 29 Oct 2026 09:57:38 +0000 (UTC)
From: Patrick Steinhardt <ps@pks.im>
Date: Thu, 29 Oct 2026 10:57:16 +0100
Subject: [PATCH v2 07/12] builtin/rerere: turn "status" into a proper
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
Message-Id: <20261029-pks-rerere-subcommands-v2-7-07d5ba18e882@pks.im>
References: <20261029-pks-rerere-subcommands-v2-0-07d5ba18e882@pks.im>
In-Reply-To: <20261029-pks-rerere-subcommands-v2-0-07d5ba18e882@pks.im>
To: git@vger.kernel.org
Cc: "Mark C. Chu-Carroll" <markchucarroll@fastmail.com>, 
 Junio C Hamano <gitster@pobox.com>
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
2.56.0.341.g393f52fd96.dirty

