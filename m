Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=103.168.172.151
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793900580;
	b=decQRN1pQWstZ2zsIZPJjoKmGpTupqLBagfXDpyzot1MtrOIF81+rWw3msXUShjvZZ8c
	 gJJO0wOc1TZZGxjzge9GGwZ4+tL0eJtFgopCOrDjSl1ROXjxjzSYwqsphvkHjp5ALNey6
	 vAeMfY50As0h0miYNVMke3rlmpid/oZa4Cx/4b4BMvT66jV4ityxvpFhTcfNsHxyuBIA6
	 KFiTnUTeR3rivG1PoR8sFLnsYpNORADCeTTm07nt7vmwuHFIpOSQqLpY1tTy4HTm5DCiy
	 Azv7qe8Tn9pWkdMK5ILwG43N2pkvpEP3FzTJDmS4F5yhB1yY2Xhk8Fp4whnlGyO1N+g==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793900580;
	h=DMARC-Filter:Received:Received:DKIM-Signature:DKIM-Signature:
	 X-DKIM2-Info:DKIM2-Signature:X-DKIM2-Info:Message-Instance:
	 X-ME-Sender:X-ME-Received:X-ME-Proxy-Cause:X-ME-Proxy:Feedback-ID:
	 Received:From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 User-Agent:MIME-Version:Content-Type;
	bh=DZgroA1gPXIOB8aJQ79YvvaQ+GQEzdaTK8KlloJ/l/E=;
	b=mCJxDUhSHdhUnPAjOo1TxooSvMCl0+fxIMAcxMo0qR7XAlg4zkfIKXAol8JKSgZWs/k/
	 HYYTvCeU2pLmsGp3hFKkBrJB2aVjE/wfyu7h1vO+s++7fPUjR2EL7B8UjbEiyEQ/q/Tks
	 TA+fZJayoiRJy10lmd/L81rvdxduRCgYJzDGaP/oGTHNvU9I1E5TOsshNkWJzIKRFbNBD
	 EPlr+d/bN3LIWP8v4EIjLeBMddAmZXwh0SdB6u15OEtioAIytffBQfAUXI9rVLTEh1/wd
	 zGOEzNRFaVrowYXKNa2ZkF3W5LGWAombmCbIsIboUisWe0AcrybakLIyHBgzah2etig==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=pobox.com;
	spf=pass smtp.mailfrom=pobox.com;
	dkim=pass header.d=pobox.com header.i=@pobox.com header.a=rsa-sha256 header.s=fm2 header.b=XnutJBXG;
	dkim=pass header.d=messagingengine.com header.i=@messagingengine.com header.a=rsa-sha256 header.s=fm3 header.b=thPT5nNz;
	arc=none smtp.remote-ip=103.168.172.151
Received: from fout-a8-smtp.messagingengine.com (fout-a8-smtp.messagingengine.com [103.168.172.151])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CDC33606A326
	for <git@vger.kernel.org>; Thu,  5 Nov 2026 17:42:59 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org CDC33606A326
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=pobox.com header.i=@pobox.com header.a=rsa-sha256 header.s=fm2 header.b=XnutJBXG;
	dkim=pass (2048-bit key, unprotected) header.d=messagingengine.com header.i=@messagingengine.com header.a=rsa-sha256 header.s=fm3 header.b=thPT5nNz
Received: from phl-compute-05.internal (phl-compute-05.internal [10.202.2.45])
	by mailfout.phl.internal (Postfix) with ESMTP id 0A95BEC01F6
	for <git@vger.kernel.org>; Thu,  5 Nov 2026 12:42:59 -0500 (EST)
Received: from phl-frontend-01 ([10.202.2.160])
  by phl-compute-05.internal (MEProxy); Thu, 05 Nov 2026 12:42:59 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1793900579; x=1793986979; bh=DZgroA1gPX
	IOB8aJQ79YvvaQ+GQEzdaTK8KlloJ/l/E=; b=XnutJBXGAwW/pq00FhiiG7eO4P
	8wpJ8HhBh9ETn4N5wjWjzrZeic8AcyJksEswPRawJ7ycnxfVm3dx+1LIgDbE9cTT
	7Gr8oPlOh6squ9LZ/x8wuCj54ZcMnrKIK7Jx5a2WaoQiLBhzd/fDCPQ2nsiBgmNA
	lCp5YqVzj1HE/5jduMISs6EqwtBIFhAlUA+g6RL3t0v+Lo+K4to8aBD/8aDrpOeF
	LobQqstg59mnXK2LynlmUTwSxOQeBxZJvcEiig9d+TAMcK2U5EcmkF02FY1CnuWj
	i/I9Dt1X+kBXJyCcrL3Odmsnw1Vc/MEtsTsX/K/oIhUlvG7TXM9JVNGD3Tbg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
	1793900579; x=1793986979; bh=DZgroA1gPXIOB8aJQ79YvvaQ+GQEzdaTK8K
	lloJ/l/E=; b=thPT5nNz7yWyhJIk7eyJ/OTSg9ErMYMS24YHGnZrWQsI/pO6LdR
	rrE8apCmuk1xVKOo8Fv5wepTsck08PsvQXDtHfmoRxKlEhxbZqr1+Qa1/UvaVJsG
	hvcfi+dXzLHlngroYU87rkXGWpiFq9x/Mf99cpSEYO0NfIywpUqVNV+vJRP9jX0U
	1RMCSW9/NVHOFZ0iJwzHGusgD+pKMeMDH+bnx6HAb5mVq3gPlXR/6tbAIseQhtM8
	gDe3O+RHHbJunjQUp9kXcDnF/Cf1t5ZhWh558us+aqAJ6Ua/a9aboW5WReMP8UF6
	we4fYYqEbbaluoFrTS4kNXnsPhWNzHGJ2fg==
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-09;
	repo=github.com/dkim2wg/interop; date=2026-11-03; sw=lmtpprox;
	action=sign d=pobox.com a=rsa-sha256;
DKIM2-Signature: i=1; m=1; t=1793900579; d=pobox.com;
	mf=PGdpdHN0ZXJAcG9ib3guY29tPg==;
	rt=PGdpdEB2Z2VyLmtlcm5lbC5vcmc+;
	s=fm2:rsa-sha256:KjeoGt/B1H7sRKsAPas6nNJ6qdIEmV9CvCDEBVlXBpY8B58
	AQMMgcsda/J0yL3462jVAYegw6nYeYyzgwLcMYacvKDE1XcL2YogpRtRB+Sc6A4f
	W0/u50iE/jHgxv/P8CcjuZJFGBloR7FpVoyrBxkQuP1ihSmEqUhEVzrEt3s+vada
	R+5MnT0cYWBK2cj/XJ1HR3p6sorg1C89/x5TrT+2Mz2zly8KvjHycyjz2ae9SfiM
	QY5+vXKPwIhIgQIoAuV1RfmGDba5Le7tnkZIajB5BRLGJwF+OY1fNtXDfY9SU+09
	zYI/5bzHpVWUQVQ0mINrhXZBS2HRHlsPw+71MQQ==;
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-09;
	repo=github.com/dkim2wg/interop; date=2026-11-03; sw=lmtpprox;
	action=mi-m=1; hc=12;
	hn=cc,content-type,date,feedback-id,from,in-reply-to,message-id,
	mime-version,references,subject,to,user-agent;
Message-Instance: m=1; h=sha256:Xo7+NgJI3l74NppL/V1ROWMLdXWA8FINN3VYG0MURFU=:LfNX5KMTsiGh4lnX2uHQqfIajTx1snWkV1YwGF4hPb0=;
X-ME-Sender: <xms:IsDsatD1fb3eyMo1rWtgxe9oWb8PMs_2ONoEQKRuX-tk60l4qmZ5Mw>
    <xme:IsDsaiZwZ_C1-vr_VmgCWLzN_utPQrpT39p79_laMHGvyGdYeFoASBFaAaLJCyLAP
    1-nvkYl50BhWAX4tDdwtJDxXc2NkwtyZZ3JPvKpei-HrI_nrdGuXA>
X-ME-Received: <xmr:IsDsag5350QANHxMY-4hENDPsBUnmWtpGbyI8iBoMQ5kYhcroYo_sdQgkUO_G18vad_XQXL_ixCRwOP-lmOdltL6uKLNTmTBigWq>
X-ME-Proxy-Cause: dmFkZTEaWADjM+Qb8XcL1hGku96c0MAArNdpiqmiSM6t2dzU7yfGwoyfX29N0irQyUG0v2
    f7wZ9FuBnHsqlkGdOtBmT/62R3lQ7PS+d9dfLrfYQpqPJR3xMXZz4bz8EMYjTW7R7enSRP
    lSh+xm6wtOeJpZkeDLwtU4MqpYAF5WPGBL/P6W+RUlIR5vjOkzw9OhobDpbybfamvnDA3y
    pvZf3l8NiButSdhYftCK3k65eRmzC+A9hW3Heg+6wKUN5+ml3pJaPEg3ywUsj5XlBmzDwO
    tfF7VgYyVFvQBJ+0fF97+H4POyXoS4XpS8gX0QWjvde3eszlVAwETYv9Wgc4r7URQ1dxf7
    VW9EgMn7Iw1pY96q4gFmd3+diXIWTWIogN4TUEqnLXmdm0H55GUqVwHIF2KTLYXaE894Lq
    wauVxzgJ0mYPSdvuNuLnba8P8AAzwI8sdQyME/2rn03i9jc0lJGc3oE5bABOEmyO34Psyu
    HGEChRzR5t6qC9UQVF9nq67FoSQgHo35oxhIIC0+7XgXaNtHWpK/5otGkZLiwsBVVFB2uz
    FojhzWwyaUbjVCfYw8ii+yq2eK5OM2w6TBK+PjIV5ICYL5cZ/O+EHADydcBE1D3Smh6c4p
    4Fql9V+6f3OKzKTg1KIidToDweKJEbYSDLss1B1hhZWCtqc2FP0Ul1agCvMA
X-ME-Proxy: <xmx:IsDsajZvDbbdIBvMbneonsZjyN-roTTLP7CwNqJzADTEsVK1f1AvlQ>
    <xmx:IsDsaviagCSWoaMS6_jW1GdpEd8jYVi3E5bDQ7aozKistdpwBRf4cQ>
    <xmx:IsDsak8lmQZMvb86OHi8wYS6QC-1FyynylVmcsCU5QiXVkoCS9Mkqg>
    <xmx:IsDsaqokx6P6-dtoY3jp8V2EU5MsNuue2o5XIxlvAGub0WXdv0f77A>
    <xmx:I8Dsav4QHjd3ZWHeHuii4bqeZaLB-_dhFj6zs0pVXGyWak8YO01RmN6S>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 5 Nov 2026 12:42:58 -0500 (EST)
From: Junio C Hamano <gitster@pobox.com>
To: Taylor Blau <ttaylorr@openai.com>
Cc: Derrick Stolee via GitGitGadget <gitgitgadget@gmail.com>,
  git@vger.kernel.org,  Derrick Stolee <stolee@gmail.com>
Subject: Re: [PATCH] path-walk: allow revisiting paths from tagged trees
In-Reply-To: <auuvwlhhRpA0T2ml@com-79390> (Taylor Blau's message of "Wed, 4
	Nov 2026 16:20:50 -0600")
References: <pull.2296.git.1793819268371.gitgitgadget@gmail.com>
	<auuvwlhhRpA0T2ml@com-79390>
Date: Thu, 05 Nov 2026 09:42:57 -0800
Message-ID: <xmqqecczw4wu.fsf@gitster.g>
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

> On Wed, Nov 04, 2026 at 07:07:48PM +0000, Derrick Stolee via GitGitGadget wrote:
>>  path-walk.c       |  5 ++++-
>>  t/t7700-repack.sh | 23 +++++++++++++++++++++++
>>  2 files changed, 27 insertions(+), 1 deletion(-)
>
> Nice find and fix! Thanks for looking at it, this patch LGTM.

Thanks, both.
