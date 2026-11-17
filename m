Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=202.12.124.155
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794930034;
	b=j0q7lq8ZkZF2Nqbq0PjdyfjvSy3JDX5Pkb5XP2CNaa4f1IQBeeiBaag2+RpBEbZYY/l3
	 bBWPzkn5OFn2uxPEjsOJCIJs7AulZZVm5T9FPmoCm3dTXzOMjyqY1g8FwQtWlenNNegWM
	 qspvSiMA8FlNKMDMguzr9+4wVfBW10giC90r0qmkCJwbbnomz/JG2cwULYolDj5UuFh/f
	 kuohgRjYqvcmneSAkhnoQv554X+8QlEMQ/fSfJG2SUvhZSDTbiiv4pmprx5MUcohPSF1Y
	 pRaaLcuQmnDXa4CboLSldlwi0tlcssZ4qU5sFaflP+5j+zR8XUoHxxEx5damYq5T5Aw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794930034;
	h=DMARC-Filter:Received:Received:DKIM-Signature:DKIM-Signature:
	 X-DKIM2-Info:DKIM2-Signature:X-DKIM2-Info:Message-Instance:
	 X-ME-Sender:X-ME-Received:X-ME-Proxy-Cause:X-ME-Proxy:Feedback-ID:
	 Received:From:To:Cc:Subject:In-Reply-To:References:User-Agent:Date:
	 Message-ID:MIME-Version:Content-Type;
	bh=Q3x7omd/PLvxyepkCeVqaZxKtTK3D0820qN2T9L10tQ=;
	b=sN+9Wv29NSvMNIGIty5PyT60SByvZvL1rhEvwDrOW5t4jxak7oecs6t0BkwAOOhSKHdy
	 sG6Vnm3S2wUEZjItHVvlcw55YdsAqIRJ+BGPWFWTWYpxl5vr/mhW4elfsJPpXS31nlAzP
	 yB+9Wu0BifHgrsVxvKsllm/zg/g+WrBsaSSXX38q9ma3yAkd1Ptnqkf0/tb+a6GM1G9Ap
	 rI5+JxkxdxMPoF8DurQVdZbWWATaqgcdHERDd4sDk0pNu/dAsOY1JZesfI+JBSlE2SbFJ
	 ua5AKPxEWVL4eKplfM8EsEB8kdUxaF9mCG8fxfubRyDmwJU7xTnv/9JDSJxfcvGTANA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=pobox.com;
	spf=pass smtp.mailfrom=pobox.com;
	dkim=pass header.d=pobox.com header.i=@pobox.com header.a=rsa-sha256 header.s=fm2 header.b=l8Seun7L;
	dkim=pass header.d=messagingengine.com header.i=@messagingengine.com header.a=rsa-sha256 header.s=fm3 header.b=HYhNkREu;
	arc=none smtp.remote-ip=202.12.124.155
Received: from fhigh-b4-smtp.messagingengine.com (fhigh-b4-smtp.messagingengine.com [202.12.124.155])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8FF1D606A31C
	for <git@vger.kernel.org>; Tue, 17 Nov 2026 15:40:33 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 8FF1D606A31C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=pobox.com header.i=@pobox.com header.a=rsa-sha256 header.s=fm2 header.b=l8Seun7L;
	dkim=pass (2048-bit key, unprotected) header.d=messagingengine.com header.i=@messagingengine.com header.a=rsa-sha256 header.s=fm3 header.b=HYhNkREu
Received: from phl-compute-03.internal (phl-compute-03.internal [10.202.2.43])
	by mailfhigh.stl.internal (Postfix) with ESMTP id EBBB07A0038
	for <git@vger.kernel.org>; Tue, 17 Nov 2026 10:40:32 -0500 (EST)
Received: from phl-frontend-01 ([10.202.2.160])
  by phl-compute-03.internal (MEProxy); Tue, 17 Nov 2026 10:40:32 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1794930032; x=1795016432; bh=Q3x7omd/PL
	vxyepkCeVqaZxKtTK3D0820qN2T9L10tQ=; b=l8Seun7LNLWxIfVSUVgLQBmCZ6
	Ays73oHeDriFt1ykQMDD//5LDWVE9eFHKsyhyJP42e7zKxzxsmvhHahEeK+AYI76
	IbVu6BCK4jMQqVJneuc9P+NOhRHupJb/YANBeBHnifX+bGzWekWKruuuCjgtPb68
	fTPnWIq+8+7IfzmIWmz/R7oSWEynjLirP8KMr+gh4/1ZdJKLvOWfOI05ckMsfriX
	VewuHY2VLT83VHdnNAgJ1p6upubZHzoEDV1FR7TiKMjCQOJP3ubwWQOhK6x/9CGN
	3fVBoD20OjcofznYFfnEDjI5p14PjWyS68TcC1RSdvv0Ph0U67T6EaxnZx0A==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
	1794930032; x=1795016432; bh=Q3x7omd/PLvxyepkCeVqaZxKtTK3D0820qN
	2T9L10tQ=; b=HYhNkREuCNJREL2PqqSLeEMcpFCi5fAP29bZ+GTVRH+2pBnTulj
	WHoqpKSAyqLcjspS5Y98Qv0bE8vXn2gVfCswqLYUAjJZLULfiyooY7EX3Mv+IN8e
	MloveoWzGN7ZsrHPcJdqCOiVo+4jK6cj7KpLyLVs4am6lsZrA3R0Vb+j+KpHQCTc
	o1Ny0+nwAdGduvG3ZkGXjpvt5pdtLai/4CwiGqNCX89vzB7uejDgUgG4Jr1hNwFH
	SZXLy885hVL1owFwqhAvDUqduEhI8SUpaXSUkA7sq5h3tv/s4u+b4v0LP90AJdVv
	viKltWUXFBVDjMRbCL7ZVR6EUXtWiWGSS2g==
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-09;
	repo=github.com/dkim2wg/interop; date=2026-11-03; sw=lmtpprox;
	action=sign d=pobox.com a=rsa-sha256;
DKIM2-Signature: i=1; m=1; t=1794930032; d=pobox.com;
	mf=PGdpdHN0ZXJAcG9ib3guY29tPg==;
	rt=PGdpdEB2Z2VyLmtlcm5lbC5vcmc+;
	s=fm2:rsa-sha256:R+gGbmuH1miDgLiQqs9qAeRsJ0CzsnzoDjOZOB/tJ2e7NC9
	q5EooyE8HPUxZRyILCzYldz465H0W30eV+qFHJMkyA9bJLv5OgKudc5yOjLHD0Hx
	n8q0cqqwi2HMLBCijojI8c4tz2kZIYSNwnb6BOjP5x5iWD5iNymJUGHmm2ZXtt1c
	U9G0oDCLDO9Sh+vrNn6voefGJtk78j0u0iAGZaMO8NM2LLAtgaKBcck/f5DzkMw9
	sretTg7yb6OLZaAg3kAohCZJA4aWVkmhmNijB5cxX5SYapyxTUYoSZO9Ou9vTnQk
	zxiZADqmgTTc7501FmAkmnoX/yFtWo7JyBLfH1A==;
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-09;
	repo=github.com/dkim2wg/interop; date=2026-11-03; sw=lmtpprox;
	action=mi-m=1; hc=12;
	hn=cc,content-type,date,feedback-id,from,in-reply-to,message-id,
	mime-version,references,subject,to,user-agent;
Message-Instance: m=1; h=sha256:UgA9/evfaxvoYqcfq6lbjAg5CDKaZLG204Ipcahr/ds=:n4ezZoejdXQ2Mmv0tOhTiKqtxRVmvV1cD3+HbSH/B9U=;
X-ME-Sender: <xms:cHX8aoKkbr7FH0-hgOi8Ox0msnjEFMgVFwKc-n_kref4QqPNtwGwIA>
    <xme:cHX8aqbbjt-PWhhguEzwi98-lVU2NWL2WIaKVFJviPD4oSEUL_RMZH5EK1VEma5W9
    1XAycMSVM9e4KwFUlmMzOhj3huXKgdkwmcm4o5N5qsQ8Io0Zv3eLQ>
X-ME-Received: <xmr:cHX8aq-FduX03iUwnv1wKYfatYVv-PgiZZIzYepcd1d2fa4G2PyEmL7BnNbtqXoSEaMUJDTF8LWVc5PFGeQZibRv7pfGm11G4wUq>
X-ME-Proxy-Cause: dmFkZTFd+D3/TsHaqaMXXxLUaRsllWGErJPeK94ogxJ4pF6QZruDOX5HqeTLgWTTPOjz8k
    6IHQaEf2asb6ZS1lto1Xyn5DOqEWJzIK1YEiO5iDRh4Xn0QlzjJxBEEreIUesFd+dRTQNB
    NbSWiZw55nGBts8mkA7OfSZ9ifu++shMyu0XKDMKAYu7vVp6vtQygFer7hyqK9Eg9svM9x
    /AxkrF0Gqa7TstMw3vxrO6TrPBLuIzCyeCh/y4mor7nv62FZ2p6dydGkeJcH9PTe9td0Xh
    8gxtBAP/WV3Bla7JzhvNF8s1cscbGxtA8R0QY7mc4DFT0KxnTe86g/3rNY5wCYVrkAGHm1
    cw8b5uXnGc+/t8f0KtOjJEZ2GFmkNj8bPSZyD5UHiJPUUvFnDq/rOLeIwC6JxH/rumaXUU
    hPVYOHvBUcsS0AkPonRRInlHcvC24yGkh8bW8mfvDnnd03+DY6w8W+kXqIwUBSlhaOh7vl
    Pq+eN5m2G+Zawh10F68uIOV0/KNKj8mwj61JABuQDVYaf/DACnSaYAvIWUt/AsjHlevBXi
    U/T/IXANOxeN372zoKnAUkxDBoDnqdAbSnfojgidrKn6GaSEGnGSiLH4EgxatKzWi4TH0u
    carK4vLBxKgjxdFEAnGp0f8P3FcmGd6KNqIhcSJO2oHgtHWWmI2J5IfKHSIA
X-ME-Proxy: <xmx:cHX8araTlb1rZUloMNFRW986mNqVmanM1RuuxMpBaIJ8eLiEsqSibg>
    <xmx:cHX8auM84mKQMBnYBb4A6tqGzoYgxgYJLh9UKRxDnmknL8kwq-AbGw>
    <xmx:cHX8anA-margDR6UjB2fzwjx0fy49jupidMyVlLZeyMP40I8C1dJVA>
    <xmx:cHX8alKRcnR7YDJOqiuMjGbOtGkM6xp8fjeQaUG81uOic8IuvANWxQ>
    <xmx:cHX8arE7oAFPl1BNtosJb_nLlKvIH8n2SqQqki63SRXPAaYDVbnB6amJ>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 17 Nov 2026 10:40:31 -0500 (EST)
From: Junio C Hamano <gitster@pobox.com>
To: Phillip Wood <phillip.wood123@gmail.com>
Cc: Harald Nordgren via GitGitGadget <gitgitgadget@gmail.com>,
  git@vger.kernel.org,  "D. Ben Knoble" <ben.knoble@gmail.com>,  Matt
 Hunter <m@lfurio.us>,  Harald Nordgren <haraldnordgren@gmail.com>
Subject: Re: [PATCH v14 1/5] fetch: add remote.<name>.fetchRefmap
In-Reply-To: <5a1a9f6b-48c8-4daa-9059-bf9459587a17@gmail.com> (Phillip Wood's
	message of "Tue, 17 Nov 2026 15:03:11 +0000")
References: <pull.2412.git.git.1789829246437.gitgitgadget@gmail.com>
	<pull.2412.v14.git.git.1794681496.gitgitgadget@gmail.com>
	<c63699b40228b1d47368778d7397b1ddc6ba2a36.1794681496.git.gitgitgadget@gmail.com>
	<5a1a9f6b-48c8-4daa-9059-bf9459587a17@gmail.com>
User-Agent: Gnus/5.13 (Gnus v5.13)
Date: Tue, 17 Nov 2026 07:40:30 -0800
Message-ID: <xmqq7bibh3f5.fsf@gitster.g>
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

Phillip Wood <phillip.wood123@gmail.com> writes:

> However, I think it becomes confusing if we store the ref in two 
> places when the user configures ".fetchRefmap" and then passes "src:dst" 
> on the commandline because users are used to a commandline "src:dst" 
> overriding the ".fetch" config, not adding to it.

True, but the src:dst on the command line in your example is still
overriding the .fetch configuration.  Wouldn't it make it confusing
if it overrode .fetchRefmap configuration, since src:dst on the
command line is what .fetch configuration gives the defaults for
(and .fetchRefmap configuration gives the defaults for --refmap, not
the refspec like src:dst).  It may be just as confusing as if, say, a
command line --refmap suddenly started overriding .fetch
configuration, I am afraid.

I can buy it if the suggestion was to allow passing --no-refmap from
the command line (or would --refmap="" work?) to ignore .fetchRefmap
configuration, though.

Thanks.
