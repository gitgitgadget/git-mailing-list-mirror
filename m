Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=202.12.124.159
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792705607;
	b=gCDPC6boD4tXcbLDdHLwfjDEiOU4rTEunSoXnHcID9QrHUw+j1x67qySUzgxD5LMIMYZ
	 R1fI6WShWqM7UOQEzOichzShlu0uiozS9dCPmI+iP+9kySoyVBk6+rWpe+c1gxNmxb2ur
	 Ombc4sEcTKElTW8w4aPaQ/yAAtZBJiysovbZlz2joqPEP9tZfsNIIGjNorG21QJIEZxnj
	 VfUG41fgbWVYtZaf8+3whBQnv2xbLbMTbqchpuT30xt/KTNoQOS8RbcM35yvEx536KOZT
	 xlMwKq5RSJr4og7e7cOAyms7NuMJsBMULbHUgaQhx4H1+7mKG/U63aCft5DV6yrBhAQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792705607;
	h=DMARC-Filter:Received:Received:DKIM-Signature:DKIM-Signature:
	 X-DKIM2-Info:DKIM2-Signature:X-DKIM2-Info:Message-Instance:
	 X-ME-Sender:X-ME-Received:X-ME-Proxy-Cause:X-ME-Proxy:Feedback-ID:
	 Received:From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 User-Agent:MIME-Version:Content-Type;
	bh=qr9OomgWEZpsHqweNOXrzSAgZSrtHiQO01YW9q6Rrdk=;
	b=Q70YT0Y/xRME1efxTeRdiFrl8az4Txcp9a2EEPuU8APXuZ6/gqrqotTIiCchsvlrE4H9
	 U0NWvebervUvtqerwI8+Jfz0i5MoM0i3y66sUdbPdV7sV0qrNCEqNQmlVjYiMraooZNxO
	 fuLUuqkLfozHDMVovYeYF6Wnm0e5JtUZHGZSXsZVCIKwn7kM4cMgp02kcq8fwUyEIFtFP
	 SWZ99ZnQQnnnEqsdiqm7nIExosjKl+zuNln9YtyPeCoZaVOLsW793HcoiYrwTlu9dm1d+
	 7a2KFxyiNOeZh9JGsy96s0TxgeFzAnfMaIGfowFhYu7vnnwjXYaCMhldOvCgto5qylQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=pobox.com;
	spf=pass smtp.mailfrom=pobox.com;
	dkim=pass header.d=pobox.com header.i=@pobox.com header.a=rsa-sha256 header.s=fm1 header.b=W4PaMyTR;
	dkim=pass header.d=messagingengine.com header.i=@messagingengine.com header.a=rsa-sha256 header.s=fm2 header.b=yk3MXwNv;
	arc=none smtp.remote-ip=202.12.124.159
Received: from fhigh-b8-smtp.messagingengine.com (fhigh-b8-smtp.messagingengine.com [202.12.124.159])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5B89B606A31B
	for <git@vger.kernel.org>; Thu, 22 Oct 2026 21:46:47 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 5B89B606A31B
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=pobox.com header.i=@pobox.com header.a=rsa-sha256 header.s=fm1 header.b=W4PaMyTR;
	dkim=pass (2048-bit key, unprotected) header.d=messagingengine.com header.i=@messagingengine.com header.a=rsa-sha256 header.s=fm2 header.b=yk3MXwNv
Received: from phl-compute-05.internal (phl-compute-05.internal [10.202.2.45])
	by mailfhigh.stl.internal (Postfix) with ESMTP id 7187F7A00E7
	for <git@vger.kernel.org>; Thu, 22 Oct 2026 17:46:46 -0400 (EDT)
Received: from phl-frontend-01 ([10.202.2.160])
  by phl-compute-05.internal (MEProxy); Thu, 22 Oct 2026 17:46:46 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1792705606; x=1792792006; bh=qr9OomgWEZ
	psHqweNOXrzSAgZSrtHiQO01YW9q6Rrdk=; b=W4PaMyTRuwRd5wbGwCkURA6Nt/
	zZ9WRiF59l6CaOTivNJKB3fqqtW5l3ouHC7ygn01mkjxeqby628yP5NW0iRKUCLj
	FksyNPvlDfmuHs0dVSY9MYMyuxge5nw0b+B/bvH0GQs56Ede+lM2JWn0fme/mGxJ
	wBxlIKOOTmzI0+klOpuVjFeMfY9VwR4X/oEbTf5bWBE9FkKO4c994cNMYA2QwNi4
	c2RW60gmenEg6cCwGY8rW92qSfWBO2+QRZrW8woCQio3rR4R8byk9CP+CnikVQdw
	9V+QrhZ+MPr3NP6IxnYQtNoNAJs0HV4Ir8zRRvmJuKGblhtvno2pBgN5SKhQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=
	1792705606; x=1792792006; bh=qr9OomgWEZpsHqweNOXrzSAgZSrtHiQO01Y
	W9q6Rrdk=; b=yk3MXwNvCW83CJSDJXJM4QUMd+I/7lMcE/Au+uSJ8E35ncOyWJH
	QhR1pySfsboN8SOCeMtq2MHF1tzOMiBhsuFnoNZ4jcwB9r0i8MvSjEe+1JK2wyXr
	O0Hd2akDSyGX2KYdlo3gJEYQuNoGu7UEtUvWI2g/jOCqjSZceYx0UnYG1+MA0otk
	rS37e27WbDBf/ot4D/2F80NQriBCApOkE1XC39y/zkrNc6Ed9/R46HLIKWf7pmLa
	rEsO3094CGyBm7w/j7JZH0e2w08ar8DVkihHgz3KZU6CiENxbLYcP4ONfUzQhqAp
	otdOBiPpPL+qDqwBleuBS44tzkMtByaqyRQ==
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-07;
	repo=github.com/dkim2wg/interop; date=2026-10-18; sw=lmtpprox;
	action=sign d=pobox.com a=rsa-sha256;
DKIM2-Signature: i=1; m=1; t=1792705606; d=pobox.com;
	mf=PGdpdHN0ZXJAcG9ib3guY29tPg==;
	rt=PGdpdEB2Z2VyLmtlcm5lbC5vcmc+;
	s=fm1:rsa-sha256:e4TjJ8wvsfCvp52HCrNRtAoWBLGkNI+eE5AsmdEtwKXaQMv
	nyb+Kbo1g80yEV9jC8ZtDKV/3Lilz6TU1mfGYT04fDXQI9dLdMMVnXcqtUac/uB6
	WGKKJ2YusUF0D3tFbBBnWap3nuCif6X9zLlaJdse21+uiXZJ1IrG3uOuaYop5e0N
	uAMkATecyBP9S2RrHMnjDSDK4OcvtyiFJCTVpeDmckzRRYSbiQM84UqQsdUWOy3e
	9+WTLJMPrulbUjwwGtZMIIvTvwf0z1MZ8J6M4GNWs6di433K5GQVdIfkjPF1e651
	l5d0k96sU03b6fH20hNilbP37PZuDycNlrMhzOw==;
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-07;
	repo=github.com/dkim2wg/interop; date=2026-10-18; sw=lmtpprox;
	action=mi-m=1; hc=12;
	hn=cc,content-type,date,feedback-id,from,in-reply-to,message-id,
	mime-version,references,subject,to,user-agent;
Message-Instance: m=1; h=sha256:DCAA1H1xHTcPDBImfw8DACt+fcnRJsb+hegONf1wf2o=:LFLkXt+f1y/kRGp1fTAY9miGNDv0pHSj+H7laC9DAQ8=;
X-ME-Sender: <xms:RYTaaicFJz9PnKyCZYNArhfZInKdXsEOMXG6BF1gziDP3Rnph2Iu2w>
    <xme:RYTaaoCmY0GzvJtxzaBW2k8ikKMVTPabdVpiM1_fDIhwxeZpFySHh3fa4E9T2KG61
    2LP1-Pe_SVZvdtDDTBLiJEYUpY-jascxEnfYWvxLNuZwIS-AUInkA>
X-ME-Received: <xmr:RYTaau4dVqVS5AxD-NNaV_aQcFK2PGM01cNwhHB0Gj--C3eXTEXZ3ur-TRkx_sP80_M46bd5fOBvL29NYBQyok4oXSZZCInv2hEp>
X-ME-Proxy-Cause: dmFkZTGMPMa3wip3GPabI/n5kAF41vkvxd9UfEuNTRru8o7pUgXLYt2QajAy9JrsmeFywD
    Fwp3uIaj0Mqt8ZjgsOp16VZMgjR5E7S/cXiBlM5Gj+mlXbFyhyV+CrVkOGQG4Mjh33C4me
    yUJMldM1iir4hzoWHbWaeVrvp57XpL+BQvgemmFhQ4zmqP/0E/Pl+IJKX79OlSFMCsw266
    IWxIvTkq01JhGsrhItdBsZGKDtIys6OzA9mcNsgKLwxt0XEmGoMrJA3JF6JAMq8OUSsdBn
    9CQgUV71hWX1cGV/z//TDfNZAIjppY3HG9dlcicCbVvXwSJZxpdT/ISESI9xzGU7Ze7JBK
    2SCy6ysUcAEkuoymXvCAIU9jPF0pGHoIepYFlpXnQq+f9A7TSxUhB1KYjADCCyZDxtA9uU
    KVZtq/S8ctvw0Wzjho+CZa5h1FnEODDP+/rKwmjW+ExUKRryR914ZSPfupXZlm4qXyeTXk
    0WuB5o9GMbhnaMlhdx85OucRJQM57wSLIgUsVf2clYzpW2jAhnBxd7g5Fv2eHc3u+dvCE8
    06CBV2njRJgNZFbyXE4Cz2eIYapNoCANz9ViinkG6mqmCd7bce0hw/8wO17dkqKtAZKuAn
    dReuc9TEWMG8g/Bg09Am2RULmV3ekst9OW8iY/hEtJrK0M1O8sMAnjCYjE0Q
X-ME-Proxy: <xmx:RYTaapfPpPKOXYXhlc4iq1ZiMz3GSgQOnBVK1x8Lj6iFMRuXn5j8fg>
    <xmx:RYTaasujbPq3Vt8q2vnSmRgE5VouagHa0DCtDIstnrwmmE_EPI7mbw>
    <xmx:RYTaahnxjG_Lm-flW8fAt9bYkupLpU-KbAcdfRkXvkZJ_fVD398j-g>
    <xmx:RYTaanQrRNrBATlOfwI2rYkALkRE04WPrYI9utxcrVX-pxNNowjMRg>
    <xmx:RoTaagQ6-4OQAeCL7km8xa4fvgImb0Xn0oCXgt4bugCNrOjbeu9TvW5B>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 22 Oct 2026 17:46:45 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: Taylor Blau <ttaylorr@openai.com>
Cc: Patrick Steinhardt <ps@pks.im>,  git@vger.kernel.org,  Jeff King
 <peff@peff.net>,  Elijah Newren <newren@gmail.com>,  Jonathan Tan
 <jonathantanmy@fastmail.com>,  =?utf-8?Q?Ren=C3=A9?= Scharfe
 <l.s.r@web.de>,  Derrick
 Stolee <stolee@gmail.com>,  Ted Nyman <tnyman@openai.com>,  Daniel Reynaud
 <dreynaud@openai.com>,  Aaron Friel <friel@openai.com>
Subject: Re: [PATCH] negotiator/skipping.c: parse parents before queueing
In-Reply-To: <atp0Q5dFHQHAZAov@com-79390> (Taylor Blau's message of "Thu, 22
	Oct 2026 15:38:27 -0500")
References: <dc3dfa3647c42da9170bf3289f4e8a4a8a55c8e2.1792441003.git.me@ttaylorr.com>
	<athgd6Ya12zRdIR_@pks.im> <atp0Q5dFHQHAZAov@com-79390>
Date: Thu, 22 Oct 2026 14:46:44 -0700
Message-ID: <xmqq1p9he7cr.fsf@gitster.g>
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

Taylor Blau <ttaylorr@openai.com> writes:

> Thanks, I realized when responding here that we don't even need the
> 'haves' intermediate file, so we can replace this and the above line
> with:
>
>     sed -n "s/.*fetch> have //p" trace | head -n 2 >actual &&

Looks good enough.  Thanks.

I wondered if we can avoid pipes, but the best I could come up with
was this:

    sed -n '/.*fetch> have /{s///p;x;/./q;H;}' trace >actual

which is not exactly readable.  Even folks on process/fork starved
platforms would not appreciate it X-<.

