Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=202.12.124.144
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794399548;
	b=nd8TmExTFpHzow/qCBofzBmKTcBNKsxtIJ5wGHj6roIot9vd7brnFmIu3olRp/OvudK6
	 ee27lMCRaTIUQJ65b2GfCiWznsAhonK6x0U1Z8YE1rICKNIPk8bXctdo8Rphd0wT3STGw
	 t/qe2vCj9l7dcbLy0KqEicZr6252oEobePPgqzXzzCZ2+PSGwQ6MG12WhcIJeOwH0CBH7
	 HDoTzn1h2XXGE80UZgUqo1+ukyoEysE1SLILO6R05el0ym6c1vOMdVRVUAj3b4nqpIUvV
	 bh7LAlRRXyCNzuQmgL3Nh1H6TOZ27AVVG7nQpY3UAuKwPbaSqg5gWTuTYIMvpWtv/FA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794399548;
	h=DMARC-Filter:Received:Received:DKIM-Signature:DKIM-Signature:
	 X-DKIM2-Info:DKIM2-Signature:X-DKIM2-Info:Message-Instance:
	 X-ME-Sender:X-ME-Received:X-ME-Proxy-Cause:X-ME-Proxy:Feedback-ID:
	 Received:Received:From:Date:Subject:MIME-Version:Content-Type:
	 Content-Transfer-Encoding:Message-Id:References:In-Reply-To:To:Cc:
	 X-Mailer;
	bh=EBbeqap/NSpy8vHKLDG3xxDtdYKyEnpO8GmQfVLAmvQ=;
	b=4DTsMBFkKOWzRFVaY3v5IFkCaAuBBAHUqDCaJtrooNVAh2MU69AoM6QcQFRRJLzBCaVm
	 wLFjWIMfgaSXJcmn5s5dDA0RDu8hl9ZGDYrlNqhKZmc4fBjYcCUBqsZesc64CkuVrZaf6
	 vpfKWK3zS7OgCdZxi4B9J6OWoXNn4Ec6gajyeRzHlQZdpxDj9Mvr3EDQdQOQfnRuJewZa
	 kyHqsQmP3Uw6/pXBOfGLY3bZ+kYe6K+0eTdyeHrJVzlFc6Kyp+vxW65lK7E70P+ayLbRT
	 l3bzAJxxnryLF1bHJ7XJGqXl3RCS7yD+tF2d/NzJk2VsqzLKx3bc2N+WHiNWvtdzw0g==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=pks.im;
	spf=pass smtp.mailfrom=pks.im;
	dkim=pass header.d=pks.im header.i=@pks.im header.a=rsa-sha256 header.s=fm3 header.b=GLNU45qF;
	dkim=pass header.d=messagingengine.com header.i=@messagingengine.com header.a=rsa-sha256 header.s=fm3 header.b=XW22rjws;
	arc=none smtp.remote-ip=202.12.124.144
Received: from fout-b1-smtp.messagingengine.com (fout-b1-smtp.messagingengine.com [202.12.124.144])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7C865606A32A
	for <git@vger.kernel.org>; Wed, 11 Nov 2026 12:19:08 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 7C865606A32A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=pks.im header.i=@pks.im header.a=rsa-sha256 header.s=fm3 header.b=GLNU45qF;
	dkim=pass (2048-bit key, unprotected) header.d=messagingengine.com header.i=@messagingengine.com header.a=rsa-sha256 header.s=fm3 header.b=XW22rjws
Received: from phl-compute-12.internal (phl-compute-12.internal [10.202.2.52])
	by mailfout.stl.internal (Postfix) with ESMTP id C90701D001F1
	for <git@vger.kernel.org>; Wed, 11 Nov 2026 07:19:07 -0500 (EST)
Received: from phl-frontend-04 ([10.202.2.163])
  by phl-compute-12.internal (MEProxy); Wed, 11 Nov 2026 07:19:07 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm3; t=1794399547;
	 x=1794485947; bh=EBbeqap/NSpy8vHKLDG3xxDtdYKyEnpO8GmQfVLAmvQ=; b=
	GLNU45qFRwxxfE9v8Z9fmJz6Adc4+bAAtjNdZJaeSEvc8/s+slisJIjzn+v9smQI
	jddR+0cmlS0HXlhOXeAy7WvDfUxNRo2m2o4UyYoHHQvyjem013nNcKBmE3Y3oQtc
	ewlCi8DITn8/kpm0QQjGC1KdkTKlcb7ICegUTy1w9SGCdBLXpM/uk7+WuAtXAQhH
	Sl3buBjJxHWrB7z7OW7hV2EAf4jQ9p4lyuWKkMOQJ9Z12hjQLI9dRfedyUBKX9XQ
	mv39t6vqFgq2/C4je1o0DTBOJ0CJvpPhastCdE1jqxzWdwEYBDCCCjQWyqdATKd7
	piqTxxFzo1xFtZ7+MRLxBQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1794399547; x=
	1794485947; bh=EBbeqap/NSpy8vHKLDG3xxDtdYKyEnpO8GmQfVLAmvQ=; b=X
	W22rjws8K2UQn2tVuH4r1DdAJAYrCvSMFzAPsR4HVe3pERGS/Rla0q2Q1ibUMAYd
	dXC/3Y2fFAy/GMczJY0J9ltWSvqm1nFKfruTJrNPuy0Wn1q1Hi2yUbiVco0V7gGi
	12ss3yVXC7oCW7G9y13p+d0TYdEzQ3hdY589dFuItxJ4J6DTJVKrpjIcWwxO/VQ/
	lRimoZQPF4C1fNvwIY2zUOvYRlp2TdOTJjGqo6cNy/Lai0TyXG7BsAnF3Cm5SLvv
	lXf3j3Vh+61qykf1uB1J/vKHROhJwHbFNjnC0PjT9TM9DSzj/QTyb22p9ToHAtXy
	d6C1iuE/SG95sAMPEdwYw==
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-09;
	repo=github.com/dkim2wg/interop; date=2026-11-03; sw=lmtpprox;
	action=sign d=pks.im a=rsa-sha256;
DKIM2-Signature: i=1; m=1; t=1794399547; d=pks.im; mf=PHBzQHBrcy5pbT4=;
	rt=PGdpdEB2Z2VyLmtlcm5lbC5vcmc+;
	s=fm3:rsa-sha256:rV2bxaH/nioKEymMPVSSS3dWT+UgT4Q3DrOI2a4elR7xUSE
	ihgs7LxIjBXS4fCjzakeae0SzqA57A0Ut92DSjk3OgPtgFi/iCDr1YTl6jYm3Hzw
	I006Gl23dRLZolc4k8P9KNUpRUK3W72Ym3qvmIUtdmBekLIUr6xDS26KQLqWazWU
	5HEqRd7RN6jJR42cjlv3o91z4X5R6JvuJ7W7efiZ3te+xictfV5Lz032i+61vziN
	7J8GLeJM7rn21YIDMmNdCJyj8BXj7yOUxbEtv8htd9AP6k0Pj4KtBuDfacnM/4GD
	ryG7POhbPw1QlQX6k3FIsp7YuUh687sCl//DqxQ==;
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-09;
	repo=github.com/dkim2wg/interop; date=2026-11-03; sw=lmtpprox;
	action=mi-m=1; hc=12;
	hn=cc,content-transfer-encoding,content-type,date,feedback-id,
	from,in-reply-to,message-id,mime-version,references,subject,to;
Message-Instance: m=1; h=sha256:jgaofeE267W1xvk7SOOTDD6OkiGKVIPcsCe+28YdZ9Q=:VXkgH4vULAQ63VH8PiRDynljt6dndrOdBdz63NKIzG4=;
X-ME-Sender: <xms:O130ao38AUDCmIrA26ciYaxSAlm8UmqWm-fycc0CAdIOBTGq6Ui30g>
    <xme:O130aqH26YSlHw4I0jxK2PJMHmqraHJZe3BbfFwe0bj41P9K3ahPZgECvvjOPsKMC
    HogXOyFg4Tq59m6EiGNmC_XHeR_rf32nT_xeM_tEka_DhkkWKpxPg>
X-ME-Received: <xmr:O130al62iDNQg0MkAaVdnYJ3OsmZcQWzvhO06bePU8SDRvOEYFb4GEFf6fzgNZOtuSd8rg>
X-ME-Proxy-Cause: dmFkZTFDM2UfMmXJZR1iHcNsSwiMuOCbMl5T818vkXV/qNRQFpT6PgDNN8oRUZX1XoIjn9
    7Xg/XfWwtaYe4Ka9dUY7guzpRuB2SfZ/12BRs2qbqYdBuSIunG3pmbzkFcYDqZchCA+oB4
    MDf+NFgTUOijFI5iwMbLndfo2X1CFCd1p3PJx6jUwOtgKvNVwHykRaWWnozBx8shDL0hNm
    xae6qKlIJqDeAMK4vx85nweNDVFlJi4aWx/7fwoodyEswyM5figra6ZOK/+Fc5zONeDQdr
    FjaAbo2MRfLuDwPH1DErm6nU5HhqV3tB/+00MAfBNFIW5nbAiKPlcFEPdHSFhik9usH3h8
    E7r7V8mCwO70gcNbRGYpELvqHwvP7dv3hjJY65iu6ATuto+uRUYSay79P+UgnDwS9a+XJb
    PVMU2C9Kq8C5bwSPM9omqJxoDnMDPKGd/hNK5F5xp+HjL7niJYdKngmmq+SnWAz7MIPkCk
    IGXMz0MBFTYs8Fe+diieGVAsYjSLNyh0U/vw6zY496fi43A+Z0Aa2S0ax2YsB+y5e5tG5s
    WqjMaU6rG5Wyxy8PH49X6xD3rJpLtoG2ZCwN3nrXbcazRpFNPrD7zxp5sWbd4a4x7PWM3x
    DGOMPv0RXe7iGayThBHFvb05m1GzGazkRBxiyc3yHQE5zJle9Bvv/+BbP3Ag
X-ME-Proxy: <xmx:O130agso1kBzu00hCKg-y1krn_B9TkSu-BWnUBD8_SFmI8xEffmOyQ>
    <xmx:O130am4kjiTuHD43f4Aj8Svou0Ky5Z1P48DuaC0AYsvh4iWsyT-47w>
    <xmx:O130arWkPo0DalW3lXEjl7L6UMM5jiV_ILitgSfgdQGHVnLKzKtEtA>
    <xmx:O130ao_SbcBYgDt8zkZoqr-bNFoAjX0JGW9UzfH-QGrA6goaURFvuw>
    <xmx:O130ahY-rl7fe7W7fdb7HRwYVH5Vqq1w7-uCJ68ElzXr-uZkyi55_cAA>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 11 Nov 2026 07:19:06 -0500 (EST)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id 35ee9a8c (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Wed, 11 Nov 2026 12:19:05 +0000 (UTC)
From: Patrick Steinhardt <ps@pks.im>
Date: Wed, 11 Nov 2026 13:18:42 +0100
Subject: [PATCH v4 06/12] builtin/rerere: turn "clear" into a proper
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
Message-Id: <20261111-pks-rerere-subcommands-v4-6-df0c8bf79e16@pks.im>
References: <20261111-pks-rerere-subcommands-v4-0-df0c8bf79e16@pks.im>
In-Reply-To: <20261111-pks-rerere-subcommands-v4-0-df0c8bf79e16@pks.im>
To: git@vger.kernel.org
Cc: "Mark C. Chu-Carroll" <markchucarroll@fastmail.com>, 
 Junio C Hamano <gitster@pobox.com>, Karthik Nayak <karthik.188@gmail.com>
X-Mailer: b4 0.15.2

As explained in a preceding commit, a subsequent commit will introduce
proper subcommands as supported by our parse-options subsystem. Refactor
the "clear" subcommand to use parse-options as a preparatory step.

Signed-off-by: Patrick Steinhardt <ps@pks.im>
---
 builtin/rerere.c | 25 ++++++++++++++++++++++---
 1 file changed, 22 insertions(+), 3 deletions(-)

diff --git a/builtin/rerere.c b/builtin/rerere.c
index 5d2ae154ff8..62f69b488b0 100644
--- a/builtin/rerere.c
+++ b/builtin/rerere.c
@@ -52,6 +52,26 @@ static int diff_two(const char *file1, const char *label1,
 	return ret;
 }
 
+static int cmd_rerere_clear(int argc,
+			    const char **argv,
+			    const char *prefix,
+			    struct repository *repo)
+{
+	struct option options[] = {
+		OPT_END(),
+	};
+	struct string_list merge_rr = STRING_LIST_INIT_DUP;
+
+	argc = parse_options(argc, argv, prefix, options, rerere_usage, 0);
+	if (argc)
+		usage(_("too many arguments"));
+
+	rerere_clear(repo, &merge_rr);
+
+	string_list_clear(&merge_rr, 1);
+	return 0;
+}
+
 static int cmd_rerere_forget(int argc,
 			     const char **argv,
 			     const char *prefix,
@@ -107,9 +127,8 @@ int cmd_rerere(int argc,
 
 	if (!strcmp(argv[0], "forget"))
 		return cmd_rerere_forget(argc, argv, prefix, repo);
-
-	if (!strcmp(argv[0], "clear")) {
-		rerere_clear(repo, &merge_rr);
+	else if (!strcmp(argv[0], "clear")) {
+		return cmd_rerere_clear(argc, argv, prefix, repo);
 	} else if (!strcmp(argv[0], "gc"))
 		rerere_gc(repo, &merge_rr,
 			  skip_locked ? RERERE_NOWAIT : 0);

-- 
2.56.0.611.g1030f0b940.dirty

