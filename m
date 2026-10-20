Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=103.168.172.157
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792459498;
	b=FPKBrvBWajXEn5ov1n43b99v96HdffIphnXke8Wb84iKSxw2Gyds2AfYXYf09UtpQVjw
	 j8RVAky8wg16VU6owZO9yXqKm6b9CKBAvaUUsNxeMgls6iF/Xs4TsRQ+Gx5MhF431Lcsh
	 TMI2xyRLAVqBLIo+KeAgkyUtU8Ysf1c9AlPifxnVh10j5gAdtx7uuxH9VUUCMem1/uaQu
	 bEwVbG09Q/JKWWl8eXTAYs7+oEc8ckcMHiIBDBV5/6bxsWSaPsvzipZonVTY4EuUP66MS
	 x/WQf8dRKy/hl12mgrcZtcMVKQvjlaCNOjjgmRq64lvs+AiKRwiw4AF14/OGKt2SRkg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792459498;
	h=DMARC-Filter:Received:Received:DKIM-Signature:DKIM-Signature:
	 X-DKIM2-Info:DKIM2-Signature:X-DKIM2-Info:Message-Instance:
	 X-ME-Sender:X-ME-Received:X-ME-Proxy-Cause:X-ME-Proxy:Feedback-ID:
	 Received:From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 User-Agent:MIME-Version:Content-Type;
	bh=eW7V9nYKy5Qq1H5t111d56cy3OsDQLHCNVMmI1L7XI8=;
	b=0indu6v36TZBeAdjUD5W4ldyHCAuniPCXxRg/EIOkst7e0QlF4LHaA5Aw3lSMMRGLAE8
	 LUGt4xqzMhQrYavWfrqzbBsR2OPbTKY+PIifvsO54vywtYXkJBmxdGTE1G/SkP2NybuKs
	 vPT1YBRKIr2orOmkYBiw5+pV9Ml/GZdtMgsHOrCFzE0Vv2HciX1TuQVX0kOqIiA+/KMbc
	 pHnezOUVv8hJa1VYPfIRMsfLMCJvl2KchP1iYUxj6A0dZWIpT+O5K0f8RXMyyevXF2Aid
	 0QGaw+ZwutZZWI2oJ6zfXcq+eGxvdGGVUQnEjRLU0+EvhJk4fyL+txKd7aKv35WEH5A==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=pobox.com;
	spf=pass smtp.mailfrom=pobox.com;
	dkim=pass header.d=pobox.com header.i=@pobox.com header.a=rsa-sha256 header.s=fm1 header.b=koeZf352;
	dkim=pass header.d=messagingengine.com header.i=@messagingengine.com header.a=rsa-sha256 header.s=fm2 header.b=oDuaMlqc;
	arc=none smtp.remote-ip=103.168.172.157
Received: from fhigh-a6-smtp.messagingengine.com (fhigh-a6-smtp.messagingengine.com [103.168.172.157])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E3BE7606A319
	for <git@vger.kernel.org>; Tue, 20 Oct 2026 01:24:57 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org E3BE7606A319
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=pobox.com header.i=@pobox.com header.a=rsa-sha256 header.s=fm1 header.b=koeZf352;
	dkim=pass (2048-bit key, unprotected) header.d=messagingengine.com header.i=@messagingengine.com header.a=rsa-sha256 header.s=fm2 header.b=oDuaMlqc
Received: from phl-compute-01.internal (phl-compute-01.internal [10.202.2.41])
	by mailfhigh.phl.internal (Postfix) with ESMTP id 0C77B14000F2
	for <git@vger.kernel.org>; Mon, 19 Oct 2026 21:24:57 -0400 (EDT)
Received: from phl-frontend-02 ([10.202.2.161])
  by phl-compute-01.internal (MEProxy); Mon, 19 Oct 2026 21:24:57 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1792459497; x=1792545897; bh=eW7V9nYKy5
	Qq1H5t111d56cy3OsDQLHCNVMmI1L7XI8=; b=koeZf352PdchGuf8fOUZZvkMgp
	1EJYr0e+AcCBlqvORmXhC5P5rWPUgRbhvvXdSCHmwvNYZwewdMqGUvCoAj6W3vZF
	51+siPh7iuONOtP3IKqz0M0EdeOBEIwu3qo5y4WVdC56FX0n23uR4Hnv6akarItx
	SiGwVA18lM2zVI/1JWAjupTgekA4xw4LsqxrmvO+3+Mrl3h2c9ELYfNPgJXS0m77
	Tg2LfP7SaeCfX4mWPqHG6o9Jlr2WcNMlVGOTvUDwJe04kv1kYQpCr5UZW4ban6Dx
	6p6F7LmQ/VLDmSz3Ip+RQ9x3kdDMC9PSX8jibrddTdADuOn0V2f59y3wQe+A==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=
	1792459497; x=1792545897; bh=eW7V9nYKy5Qq1H5t111d56cy3OsDQLHCNVM
	mI1L7XI8=; b=oDuaMlqcOVpVe1Pf+kgcEkWSW3+9CYq7p72AwBYzKbmgG3y2R8m
	J3wNp6/5N04w7u3ThizOU3dib1hleP7BqGv4SqOr/Q/c7TK1YK10+WhxIGjC2TCK
	SWz4M4tH6gkAX3mKEMIsvfYOb4IkiHoaNJouDs1IM9MAE+xKvLPpMWMb0B5oT/bR
	fJ1daUDbxWMxi02joHKJ+hCieaLHXsHxrbO38NiDSWtTMtHji1p6FEBxzQ311CRV
	jOY7gV5qjeFCKjOp6JqDt7d3LWstRXzen5m+cP4tthMrGnkvpT+12S9RZoe85Any
	RfqtPPlkH5zsBok7jhCTuABRLvtxJSENynw==
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-06;
	repo=github.com/dkim2wg/interop; date=2026-10-08; sw=lmtpprox;
	action=sign d=pobox.com a=rsa-sha256;
DKIM2-Signature: i=1; m=1; t=1792459497; d=pobox.com;
	mf=PGdpdHN0ZXJAcG9ib3guY29tPg==;
	rt=PGdpdEB2Z2VyLmtlcm5lbC5vcmc+;
	s=fm1:rsa-sha256:NXr69jmXdyER4MUKZotbcsWMOYpgvJgccCETUTzYfWkLdU0
	KZ82HD4ihalAoFbuFqg6KglMXSsI/kgEwwvwlL1H1FzjyaMXSKHwimRc5Jz+XPD/
	b1k2n2Dw6aEsxy/UhLsOva4yeRRcJuLRZQL3MiRXaCki/bf6krDQNWamveAcMC05
	VdnkAvf+BuTbHKaw6f5iw+jXmmcTLgZG+Vy2TvGySPbcMixl4Hnukqmow5fhKTbp
	PA7GiGU3o3N6AbmFbQ4BfmIi2VLfasNYACpKUpzSYjMwkLlyuAJY/eGxFVbeHshC
	r3IrYQoM/1bmzauOyLX2I39JnrELLY2APtGFSVQ==;
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-06;
	repo=github.com/dkim2wg/interop; date=2026-10-08; sw=lmtpprox;
	action=mi-m=1; hc=12;
	hn=cc,content-type,date,feedback-id,from,in-reply-to,message-id,
	mime-version,references,subject,to,user-agent;
Message-Instance: m=1; h=sha256:A1ZvQJrmqReRN52btNVTmXAiKQ/ClDWJ2m6goCsPUlw=:eW7V9nYKy5Qq1H5t111d56cy3OsDQLHCNVMmI1L7XI8=;
X-ME-Sender: <xms:6MLWavMLYz-tlcnFF2C9PmcNkq1ohEAHuINTKbbgHmAAm0-V-ifPww>
    <xme:6MLWag1PGdOOuZCy1ltr813gEOdnX2BJnw659OlOW6RySpZRlo6do8_cLeRrazfMs
    aLDS6zl9mDiyxTGfaT6zHa3kLPRIYn6Ngx0he1BCrsYzod-KpUoLCo>
X-ME-Received: <xmr:6MLWamnp2mfhKrhNWbKsaSjOrbjqzLYnNUS0c5GZk4Z4AQo93RB7Uqa_IiQ-porVewXWyY14blv9ysUlnVSIHxw4xjN8TN8EyKFr>
X-ME-Proxy-Cause: dmFkZTEtLGaIOFadLQliw7uNtLERy2GMjRgRnl5XvGmj/i2gX7Cq0QFIbd1Z2YVPICS0ZI
    Lmt0meHbywXGEXuJn3BSstJel2mFF1V4wUgrG5sL4nvPE/GKTF2wUdTDZhWmWJ+SvPP34n
    +bW1V2pl95KiQDfC+WBYzyOJIF87eNWfBIo1CVUIDgXocmnLh5cuTTloI4OFWGWr8mJeVJ
    noTnC+2l5EiOdPaq+y/ae4QaHfMmEUOYVBrji37KUprjnSfwnixR4WJdcW2D+i1kd2IgOF
    Ghrw80RJFDg8ymS+oRiLfbELWcXFFH5oXS9hH0/RtvifuTyeqns623bNZzBOe0x+z48fXa
    bh2egT+tBSYvEY016aqYn6K191Up+GO8v7JfERlC48c4iwQzuea65VjVU0pvWcVqZ5CRy+
    q0YKr7hFUdRGn/+/+bnXD82sDVn4HtxidwV/Y7UF7eXKEWeNjHn9BNue5P9Y5XFtCBc1wU
    ccsgHwoWObu71GN/nFBQrwYDtb97hhc71E2vrE5hOQyIQT0KdJix0ldoMVlUVkVOU1tSA/
    lPS6+LmLvw4H2h107lTK9W2WC4AIRO+mopVaf2dLP41vX/yH4ggKRyzrLeFkaBqzclCykF
    jlV3nAx7u5aWJ0axGLcEnFkIK//8Sb7MjbQSIabuT3mLOLC7NAspgiQhAR/g
X-ME-Proxy: <xmx:6MLWavXhVqZJOzNy-Atwp373OX1BEmOgYypWc7ExNF1ZY_p5GI0mDg>
    <xmx:6MLWaksQ8trD0uY1JNFC8WV7PdrdMz9n09dNj4qsL_UhJzPEXLV8Gw>
    <xmx:6MLWaqar1MZT8mqlkK9QRuUNK8FQQ8Mi8QCOo8ICsNMnPJF1GJzm_A>
    <xmx:6MLWarWBBUKYciP-1rnUmSpKNmKX77qjZ6B1KDPmy3uuvzM1vUOGEg>
    <xmx:6cLWamloEjnLJRY1jabRwf5Wdy6rvc41z5CZCdSD65bEig82NdC7f8Sq>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 19 Oct 2026 21:24:56 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: "Julia Evans via GitGitGadget" <gitgitgadget@gmail.com>
Cc: git@vger.kernel.org,  "D. Ben Knoble" <ben.knoble@gmail.com>,  Julia
 Evans <julia@jvns.ca>
Subject: Re: [PATCH v2 0/2] doc: add new git tutorial
In-Reply-To: <pull.2248.v2.git.1792421748.gitgitgadget@gmail.com> (Julia Evans
	via GitGitGadget's message of "Mon, 19 Oct 2026 14:55:46 +0000")
References: <pull.2248.git.1791315422.gitgitgadget@gmail.com>
	<pull.2248.v2.git.1792421748.gitgitgadget@gmail.com>
Date: Mon, 19 Oct 2026 18:24:55 -0700
Message-ID: <xmqqld7tyxi0.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Post: <mailto:git@vger.kernel.org>
List-Help: <mailto:git+help@vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
List-Owner: <mailto:git+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain

"Julia Evans via GitGitGadget" <gitgitgadget@gmail.com> writes:

> So far we've gotten 112 comments from 30ish beta testers who have tried to
> learn Git for the first using this tutorial....

And we waited for 10 hours after seeing this cover letter in
anticipation, but the patches haven't appeared on the list archive.
Does GGG need to be given a gentle nudge somehow?
