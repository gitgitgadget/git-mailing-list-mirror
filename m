Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=103.168.172.159
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793721898;
	b=cheL3thnJB9qGrA821AUVbA4XU5hskxMmBOAdftGytF1zitZdODsxTNspnZJVJl90tKu
	 BrzE+LkjrO9fjRirhL9su98pWUwvrwtoe56HFCLvc97zPMtIXNZznp0YV+TJcNKs8E7HE
	 PE9Vwi0cyWoo0NKtTrkblupJvAHIF1oYF14Hl3H4yldOXxOzc7MDT5PUHkqeWV/WjrXVq
	 r2aop3ZtVzzT3wRiI47Iqe/sioK8BMP+JGjHX5Cj7KonPXG8tCaEtvtlmIQP0pcFSS3ZV
	 6l0LNRYp7Gug3rGGFd2zuaToKrX+qBhLZJK0wulLIK0yf3faTAYLBCT8//noc6nrcLw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793721898;
	h=DMARC-Filter:Received:Received:DKIM-Signature:DKIM-Signature:
	 X-DKIM2-Info:DKIM2-Signature:X-DKIM2-Info:Message-Instance:
	 X-ME-Sender:X-ME-Received:X-ME-Proxy-Cause:X-ME-Proxy:Feedback-ID:
	 Received:From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 User-Agent:MIME-Version:Content-Type;
	bh=uMTbpRa03dxfFmj3ko4pMcoOVwcr+Z40oNeeVgFFDZw=;
	b=JfGJJRVlF77Uu2W2fcGk1s6zV7ULmyVLXEW03Yr5KqPUOm/xws7H2IDTlB3NsuoZpL6T
	 p7IW18yjudXiMzkiqd45wYK/nbgYzZg4K6FMCUMn0bc9ADL21zcT8AXv3wzH49TWSZOoT
	 Zt9ppuwIk10dTP2T1o11SYj+jJNT1zP10jjRJj633C5u40wmlS1KROnp7ysiS8fuEPJxR
	 0KchmP66qeOHe0LebXqobwuaCnTwPGGlhK3yuEDeSqnD7dTnzGkuQFvlfQf0SZQ9rPhBc
	 lmZ1t6Wt9iMiGG0J1qnR3RHLvcWqBa6M3CQKsGb6CwqweC0z3xqAsmw9WxFwhhqvN5A==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=pobox.com;
	spf=pass smtp.mailfrom=pobox.com;
	dkim=pass header.d=pobox.com header.i=@pobox.com header.a=rsa-sha256 header.s=fm2 header.b=eMqj+US7;
	dkim=pass header.d=messagingengine.com header.i=@messagingengine.com header.a=rsa-sha256 header.s=fm3 header.b="gGXGP/ud";
	arc=none smtp.remote-ip=103.168.172.159
Received: from fhigh-a8-smtp.messagingengine.com (fhigh-a8-smtp.messagingengine.com [103.168.172.159])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3CD1E606A324
	for <git@vger.kernel.org>; Tue,  3 Nov 2026 16:04:58 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 3CD1E606A324
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=pobox.com header.i=@pobox.com header.a=rsa-sha256 header.s=fm2 header.b=eMqj+US7;
	dkim=pass (2048-bit key, unprotected) header.d=messagingengine.com header.i=@messagingengine.com header.a=rsa-sha256 header.s=fm3 header.b=gGXGP/ud
Received: from phl-compute-03.internal (phl-compute-03.internal [10.202.2.43])
	by mailfhigh.phl.internal (Postfix) with ESMTP id 6F2D514000BF
	for <git@vger.kernel.org>; Tue,  3 Nov 2026 11:04:57 -0500 (EST)
Received: from phl-frontend-02 ([10.202.2.161])
  by phl-compute-03.internal (MEProxy); Tue, 03 Nov 2026 11:04:57 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1793721897; x=1793808297; bh=uMTbpRa03d
	xfFmj3ko4pMcoOVwcr+Z40oNeeVgFFDZw=; b=eMqj+US7x/JKDql0P2XPtUdREj
	0VujgcD6VpMYIfJt4/asL/eCAA8xwQuEEbCMXNgBYMbRV4frhw4Hu+TGxIKKkeGC
	0oO5GeR8D16v5mjjUjzhedqqzf4bJ+IAYMs7X8GtcecG3aplEYd7bn9BJXta5ZV8
	ToKAX69YI8d1nZwP/IqUv0OVAcsR74UMfudKiTXQE5WglDpNc+FY5i/B9EsKRXTL
	AP82WaXTOL+zkrVxPIL3vg/qNfrvwU0FGRx/DQvAYAJmAJG7PpnOxMPWsZOW20EJ
	hGzjMU+m3S7wQ8scK5b5h7rEvLxIrIGL5S/rzGDVLGQnxFyv945ZaBv9r8/g==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
	1793721897; x=1793808297; bh=uMTbpRa03dxfFmj3ko4pMcoOVwcr+Z40oNe
	eVgFFDZw=; b=gGXGP/udisuDiSfkPlNZELcbRiLpLUmE5vwox4FjsWXh6i3dIy9
	Nd6vE8I7RL22ajRnTiFxL4JfdXcNOoLL7WiPgsaqM4bKKAICXmhwMv9BnxDO+Px9
	VadFtAjsKjlbukAUe1Qgcw5s8TpaMlLMKbM9aULiwU//b2zLrTpN/5xIEKHDIuHH
	GHN8isitN38rXqsVrmjKJ5c1/Mk4Mc8DciW3seIl+r46SCHpVvieAfSGOp6Xq82y
	4WDFDC/ycGFanDFwAg2WVRSeVYsS4sdfyjVBJdpjhu7J2mn4sXMKG6RqqQkTthaJ
	W9hjACYPCioLZsvJiLxgkuDWRSurX2naCVQ==
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-08;
	repo=github.com/dkim2wg/interop; date=2026-10-28; sw=lmtpprox;
	action=sign d=pobox.com a=rsa-sha256;
DKIM2-Signature: i=1; m=1; t=1793721897; d=pobox.com;
	mf=PGdpdHN0ZXJAcG9ib3guY29tPg==;
	rt=PGdpdEB2Z2VyLmtlcm5lbC5vcmc+;
	s=fm2:rsa-sha256:J7zEX0MsJRXNVo2ISwQZuZZ6gfbKv6V3L/RUz9cmyuxFKF6
	vIlfa5rzFDNZkS5BGIyqWj3oZlRBio+DBotRclz45vA49SpRsJEHIXuQ+uJGCCPk
	Su3q4jwjm82dxhdEyU9pUHeNHI3E7eCQRdNakrV9Npb7lTkabh0KDnMubjOAyFdr
	G9IEB+v9Qv8PL7n6JE/MT6R1RKktSCYnpoY4oHX+qUX+YMZh/nfoM7zbunY0GScd
	NQEbCDqJiolUHZsvQvlzP9PVvkTUCsc4Qbv7ZHnyCgRS0Ypn8p1N9BMbGkyl61Cr
	btUJXnmqwcC4tzzulNDpEpnCSteMzuTk+AFHU3g==;
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-08;
	repo=github.com/dkim2wg/interop; date=2026-10-28; sw=lmtpprox;
	action=mi-m=1; hc=12;
	hn=cc,content-type,date,feedback-id,from,in-reply-to,message-id,
	mime-version,references,subject,to,user-agent;
Message-Instance: m=1; h=sha256:0B3MSH5fuwzgoRflVfYw3lbxX+MsXVu5AP5vIxv2xjc=:uMTbpRa03dxfFmj3ko4pMcoOVwcr+Z40oNeeVgFFDZw=;
X-ME-Sender: <xms:KQbqauBgMDopusePEwJCmaMACKualPVgglRuIWvLnlQkOqQQnaOL3g>
    <xme:KQbqavg_US97lbX_hvWCD2nH9EmN1rri_-F7psgZF7OP_7JCJ3RQG4DMyZ-1K7u9z
    1uYSsjBJu0PSVXDfleV1-SwysHKWR73Y9YB4CniJ5RrhhKSs-0cQpEk>
X-ME-Received: <xmr:KQbqamkam5vOJWUtyJFf9a2uaUPrR4VudTVu8DDHRvYEu48SLFRaGSaTDvukZBgLOMEXhcKNnaS5LtqQ2YxgD6f3x5wAvpKvo1cj>
X-ME-Proxy-Cause: dmFkZTEB1T7/8nvexxMclIpukEzoMCyExHbWmkGtTISsHKzsOW/xC68TREPRIHmN3Gdv2s
    f015lqhxR+zHNqr2+EQVxhKHp2bn+ruVl5ADXikUYpGRF6h69gIRyEKSK+GYzJgu5Gi5y+
    2VQIIown2ffsJWhc3bYQgGKNfxTBIT13dvtV0BoP9K/tTDM0SBVI4AfFGxudG6Db1DNeG7
    ZtdzeO0F5IZPcYkYTGZnKXkwCqhXg6lKMRMzUonrBw+hjNF84EPdfSMWVCzIM9NaCuxGFt
    BPkCSXWnyqp19ZXD5MBsucJquZxeaSVGcrMO6iTuysPYbK0URX1wzJeySL9Sr2LFW675jV
    HyRe26NGq26tQHvYE9e9AhimJMHjLF+nMkKVbltNMOxyvGmrUGUSy4BW/P1/v++uDu0Ifg
    Xv8qghD2Qs4ZPoT5w3XichBEYHdEolRsjZWUD/7G14ouNoWI3pZJuhgO2ExUwGqmHNvSSC
    JAcu0bt2dsEYafgCoOg/4e4CZp0YYHo5ALZqmkDKO2ex8euoS8eCWEqlRmvnHWckhLMnnb
    MXoxM5CzRD24JpCY/WTVeNeHTRZIMMWrDqAUiYWA2hKiUni2nEcrqvFnI0OiQDor6zrCU+
    aIBUWX/bXbnwOVc5KFib4xrFzn+OMFS4oYZhfZ0R/qmGqEm8U/AKh71vTjRA
X-ME-Proxy: <xmx:KQbqarqisNrT6SLp4_vxIBKqImbmWWczED58OPloXDG_h9m_dJIGvg>
    <xmx:KQbqavGaIczWEdIcAUI7AET1XEG0mFzNp2lW13WRwRP-RHkHvN5a4A>
    <xmx:KQbqanzMRT4XIfI55To6RVEsUf6IEuVu27vcI2CxHPxhe4Jj5nWBnQ>
    <xmx:KQbqakqMqsvLk6EPE2laRsFPDYJwxREBphPLBZFjtjxJtr-j4-JXYQ>
    <xmx:KQbqauH9No9Fv22rJhOqDJSxPsS2OyeKlJNquT_bT0DoMupaI8_Hzkri>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 3 Nov 2026 11:04:56 -0500 (EST)
From: Junio C Hamano <gitster@pobox.com>
To: Patrick Steinhardt <ps@pks.im>
Cc: git@vger.kernel.org,  Phillip Wood <phillip.wood123@gmail.com>
Subject: Re: Ejecting things more aggressively out of 'seen'?
In-Reply-To: <aumNkxzE7wfa519p@pks.im> (Patrick Steinhardt's message of "Tue,
	3 Nov 2026 08:30:27 +0100")
References: <xmqqfr15ruw7.fsf@gitster.g>
	<f5f7af53-df3e-4902-b350-8fcf8ccb02ad@gmail.com>
	<xmqq1pclc210.fsf@gitster.g>
	<414ebe62-c7f6-4d44-bde2-b689e35accfc@gmail.com>
	<xmqqbjbpptzr.fsf@gitster.g>
	<47bd0302-fc52-4df0-98a0-6fad7eb0fb05@gmail.com>
	<xmqq1p93ofjx.fsf@gitster.g> <auhfD1ryB-7JwOYl@pks.im>
	<xmqqv76fjjhg.fsf@gitster.g> <aumNkxzE7wfa519p@pks.im>
Date: Tue, 03 Nov 2026 08:04:55 -0800
Message-ID: <xmqqbj85c34o.fsf@gitster.g>
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

Patrick Steinhardt <ps@pks.im> writes:

> The question that newcomers often have here is whether they need to do
> anything about this. They basically wonder whether that question is
> directed at them specifically. Maybe rewording it to "Will merge to next
> [on <day>] unless told otherwise" may help clarify?

That is quite a mouthful and [on <day>] is harder to automate, so
I'd probably keep the '?' and describe what it means near the top,
where I already talk about what it means to be in 'next' etc.
