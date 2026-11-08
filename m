Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=103.168.172.157
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794163060;
	b=z6t244qa8MbnEZ2lg1TZbjnY7+EHho94SBJo6Am/xLgPgj8uhxt5AdiAKaa4bx43DZwy
	 miQv9FJqkBHWQOdygCPGtxOsiKW0LrRM7fGTYncUG75PX37S8hiNH/iHy7UaWGVkSKwkC
	 AYmdbU4PhEVQ5VHS1M2OyFKINec0aIE9qW7x2gwZlvlTYOTZb2rXrFtKgTgRmuxal/ZHZ
	 /aAyp3IAfjd7vzbWsunCG2cc+dAXOYbU5DyxneXMSQrAOP5Zviavg398F2/0A5Vsrzwsd
	 fuSOSbY5s7AC+oVteiKMq/QdMhqADKqlD6feYknfCNPCj7eOsYFTx+MXaaD1VCEpQoQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794163060;
	h=DMARC-Filter:Received:Received:DKIM-Signature:DKIM-Signature:
	 X-DKIM2-Info:DKIM2-Signature:X-DKIM2-Info:Message-Instance:
	 X-ME-Sender:X-ME-Received:X-ME-Proxy-Cause:X-ME-Proxy:Feedback-ID:
	 Received:From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 User-Agent:MIME-Version:Content-Type;
	bh=QPJFoXulrghEYchs/uqv8F48snmb0SMXn8Yp7VUUt4A=;
	b=2tJuCXjDPoUFb9drvysX6waSGF4xzwP8WpjWPDntQMoQRxd0tb2NO+Ils0vfiF1OfjDI
	 v+N2FDpEfLJqCfFbKQyFlgrSitAU+JsXIuuPPvuGCgcNdaWVhroiEE2hB2caVNST0z3mr
	 W5oHi9K4rb1UMz/QdK5qS5enJC4xF7MtIUlzGKOKan5vBiyO/E43+vs/CNwuA5nBiu2+q
	 rD/SfyKdGfMRPQqghln/NN8r4809EfApEo8LIAJPROrhfawCRv2drEu420PfAWV5tdQuX
	 WGTzQ9qpkISrSTw4m9TltqlAmKZxE/mmyxcWd8ztuIoEJ4916SwJhQ1w50xGaslYsPw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=pobox.com;
	spf=pass smtp.mailfrom=pobox.com;
	dkim=pass header.d=pobox.com header.i=@pobox.com header.a=rsa-sha256 header.s=fm2 header.b=OpN80Imi;
	dkim=pass header.d=messagingengine.com header.i=@messagingengine.com header.a=rsa-sha256 header.s=fm3 header.b=RD4JK7+Y;
	arc=none smtp.remote-ip=103.168.172.157
Received: from fhigh-a6-smtp.messagingengine.com (fhigh-a6-smtp.messagingengine.com [103.168.172.157])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C8F50606A31C
	for <git@vger.kernel.org>; Sun,  8 Nov 2026 18:37:39 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org C8F50606A31C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=pobox.com header.i=@pobox.com header.a=rsa-sha256 header.s=fm2 header.b=OpN80Imi;
	dkim=pass (2048-bit key, unprotected) header.d=messagingengine.com header.i=@messagingengine.com header.a=rsa-sha256 header.s=fm3 header.b=RD4JK7+Y
Received: from phl-compute-10.internal (phl-compute-10.internal [10.202.2.50])
	by mailfhigh.phl.internal (Postfix) with ESMTP id B2F07140011B
	for <git@vger.kernel.org>; Sun,  8 Nov 2026 13:37:38 -0500 (EST)
Received: from phl-frontend-01 ([10.202.2.160])
  by phl-compute-10.internal (MEProxy); Sun, 08 Nov 2026 13:37:38 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1794163058; x=1794249458; bh=QPJFoXulrg
	hEYchs/uqv8F48snmb0SMXn8Yp7VUUt4A=; b=OpN80ImiTFH08oOJxXBdetI/Hn
	dKICU42hgBE6AzQDnjk19/sTJd7AkKYtwx0FzWC8hCrys6gEWcl4y2Obo/M9Wrku
	SPeyi8h1Htc28NBAbh9HnFNyr8ChuLEdUVB6OREzRc7FpgW+RQBxuRqB0Szf+GJ9
	BLsjf9MYB1e0xFp8ZVWwncsC7knc0hVOabQlGhPegiX/BqrUVNtMIho4ull65NHL
	EAOI3CFEZQNySEMW64cHeAGe/J/4EWRT5ndk+f/UXMdcAoVjia5OwSX8PSW+iecN
	UMWrk2k6cj2dpV4fvQjF/+lcbk+lZHPcKp1gb6X14Krbq9l8bjAOf2mOpgGg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
	1794163058; x=1794249458; bh=QPJFoXulrghEYchs/uqv8F48snmb0SMXn8Y
	p7VUUt4A=; b=RD4JK7+YF2Q4vva8eKcqbI1Qh93zu0Z5vXiZwj36EFMkMWTe3a4
	Q3iEtPOxStmBgmMKaxdvVmPIBgMh81+YFYNIYhrtCJHwM09Mlhi6t/Iqp1OzubOS
	1+r5xREMP7XRCHGUtZ0J89pRPUEFMYg/ECPWVdvr6II2KkFDxLHvcoCc7O5f9QoL
	K3Vxi2YnLAUKSCM9V3VD2+FS26T+z222MAjlhgj2MOuPG+5Zo5IcMeGTgcv40508
	ADDb7SDwfFMuwFRrDByZlxRHwEz7EgWwC0UY7N8Vn8BnAKyiWtvoIh4auNCmQJVD
	wyRaSMMjdBPGocAdAjo+h8nk/AAaVVo6gTQ==
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-09;
	repo=github.com/dkim2wg/interop; date=2026-11-03; sw=lmtpprox;
	action=sign d=pobox.com a=rsa-sha256;
DKIM2-Signature: i=1; m=1; t=1794163058; d=pobox.com;
	mf=PGdpdHN0ZXJAcG9ib3guY29tPg==;
	rt=PGdpdEB2Z2VyLmtlcm5lbC5vcmc+;
	s=fm2:rsa-sha256:IeP7o8rX6bg73kIr1wwuXDx0DyxytOY+9iJRxJ1w10Oix32
	JBsF/DCvhrm6JMnA0ThyHmomo/wm1ame3A/w5bfj2rEQV4Z2ZqS9SMzYAdhyamII
	k1WK+WT5ycLbiv8H3QkFIw+AxMSaGN5YkZ8DwNx43kdNx2gSWX4fOJOurJubUQxj
	/VQ/jxJr8Iz2kH8Y2uTqQIjWdNGcURK2zh9VUAFMuqfT2uq5JKCp1Kc2K7d5OrTJ
	rrEe4MYY23vDy3OL02iZ19hLgflxGRwktg5uFV8w5VByaXMoYbx3gJLO6JhkGYC1
	zOhJtpv+ojPDwI2HXPyzmpr7iLnTBrWjXWmPlyA==;
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-09;
	repo=github.com/dkim2wg/interop; date=2026-11-03; sw=lmtpprox;
	action=mi-m=1; hc=12;
	hn=cc,content-type,date,feedback-id,from,in-reply-to,message-id,
	mime-version,references,subject,to,user-agent;
Message-Instance: m=1; h=sha256:GoBiFZajszMTnuL8q6OUm+8LmW2H2VXR5iZzZKYlE7o=:Ou0gKyZaIabiFJYuMLm+GWOvwsXZ23H/twt1Z6I2TyU=;
X-ME-Sender: <xms:csHwaqFOV3rpd_bjxPPV7hD9WqgmkMya5ARsED7H1eBN-q7bxqynWg>
    <xme:csHwavBhrpmaeB-QLKacdQ_h1c0IbWWes_rBaDosaLAmhKOPJP8j8HyFzTwZhJDwF
    cMEn3zPEJF9vlHh0fgqF1rK8OOE0Il-MEBnmlLSY_1BbfhIKjmRBSQ>
X-ME-Received: <xmr:csHwat-tQM273CsPTNI3j2wKbgitudGziUlbWUKnqC5ERp97s368NkxDmzlhT7OifqZBQjYNpdr3c2FUB-V6QZtrPADOcKwx-nXK>
X-ME-Proxy-Cause: dmFkZTGnqgBvwszE80gaI5l2cw/QAvFLQPtLkKBq4PtaEIBKWmOHXbmgOvE5snR0NerRYg
    PrIfk6UEusNhqxfFM6ZFoeOLy4T0G3x/QQqYy+2Lcqh3cX6Ldd9K67dbBgvFKvaOPXoEpf
    5S7D4+nhu+xVlXcvWHQLKchkG7aamcSmdb+eeDCyoSolZ2pLMsFg/Apf2oYFDwpr1zysLf
    y/52nWsLU0t2l3iJJaDEmooPzKM3W8+hmMW1LUtBgiGeJ7rdDwOqnBYQ7BR5eL/9MnMWAl
    O5BrvxErzHvDz63rbpPOhG9m4K9TndGPJtVNq5gN8csfvFjLX6nxG178ETcPOwP1ZuWwVw
    tJdAPaBtOpONUmdzMB0APtv5Lk+INFTXCgIXEK80xARHfvzOVXhpMjluNnRNq7LLThH70B
    SmlruJdyb92HMDu8/Cd3BNRvpLAW5Yf4sQ5XWWCdPfUcRKZHmvr3oQULg0NnBXhW/3HHrd
    BjwpoknG18Rdl0yM/WnScp/USX+JZF/MLtAxSLD5FcV2w/D5Cod3ebrHyfQMKTjxKsiV0T
    s3dBOE/9dzSzoSezv8pxFn2s8Gp1LnVPqItNK7Su1P0rwFCfARFM7yfPgdLaLGGhKPFnL8
    jPubm63hfG0PMK2Vnbt8W32Ho6FLZtILPII31EF0SLOqZ0iyEujnC2Ymx7mg
X-ME-Proxy: <xmx:csHwarDRQRD4axbQyiRKYmP_bnVUqQ_FlEjhUCQrjJIQlTuBGpW7Qg>
    <xmx:csHwaiQ3IGNBoLFxUo1Iae_GbJ12LUbV_QSc6UuRlG0CraCdsMXXJw>
    <xmx:csHwaivxocIjNIk-FDDK_00YncgoXknDUCb9mdkX6z1-aylGlNhBvg>
    <xmx:csHwau3HTAnw1-OgJRbZ0yd1YVPSo9oxGQyWCp16qy_RP8L_41plvQ>
    <xmx:csHwan61zybMpIETtLrmoAKreL5iTMa_ZbZIhk5XUcElqCVJj3v_Lc0w>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Sun,
 8 Nov 2026 13:37:38 -0500 (EST)
From: Junio C Hamano <gitster@pobox.com>
To: Johannes Sixt <j6t@kdbg.org>
Cc: Kristofer Karlsson <krka@spotify.com>,  Patrick Steinhardt <ps@pks.im>,
  git@vger.kernel.org,  Kristofer Karlsson via GitGitGadget
 <gitgitgadget@gmail.com>
Subject: Re: [PATCH 2/3] t: add "test-tool genbytes" to avoid slow tr(1) on
 macOS
In-Reply-To: <50b6c35f-e9c3-47ef-8fca-aebd2620623a@kdbg.org> (Johannes Sixt's
	message of "Sun, 8 Nov 2026 09:54:23 +0100")
References: <pull.2301.git.1794063565.gitgitgadget@gmail.com>
	<4c02ada9b85028f26f7e7bcc62e2ac12443da9c5.1794063565.git.gitgitgadget@gmail.com>
	<50b6c35f-e9c3-47ef-8fca-aebd2620623a@kdbg.org>
Date: Sun, 08 Nov 2026 10:37:36 -0800
Message-ID: <xmqq7bin41an.fsf@gitster.g>
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

Johannes Sixt <j6t@kdbg.org> writes:

> All cases that do not need a particular character can use
>
> 	printf %0.500d 0

I read this "printf is an easy and efficient way to create a long
sequence of bytes if you do not care what value these bytes have"
discussion and found it very illuminating (including the mention of
glitches that are platform specific).

Thanks.

