Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=202.12.124.145
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793118558;
	b=WMig4wJ6jZhE9IYPpwai2weSGBavcQGRarnDrj5jprUPwCX0o74KisBeqnk6P5NQyq9y
	 piKt0amBeVqrPaQVXzIvjchlv/dwWHOJpBhkUz8enCVKt4loceKz/FzQhQTolvwC7Pl/n
	 MW/9fTBYPnsWMnGyMKdZJE6e+Aj5W1JYJh80DNhGOH43W+i1pDj1k0goTgxAEzbgW9VB6
	 LqypRSTeo59ysKrbVo1gikjUElx26QNxcdLmNQY9dbhMsNuOiUGpgNakQq/kjC6eteMWz
	 iSpyNQXfOYMpsfUn8Vp0XDLOmfuVNu4u/NxL3QtBUJOm4tAzWGsxXVwraAIbovHEcwA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793118558;
	h=DMARC-Filter:Received:Received:DKIM-Signature:DKIM-Signature:
	 X-DKIM2-Info:DKIM2-Signature:X-DKIM2-Info:Message-Instance:
	 X-ME-Sender:X-ME-Received:X-ME-Proxy-Cause:X-ME-Proxy:Feedback-ID:
	 Received:From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 User-Agent:MIME-Version:Content-Type;
	bh=wAcU4UzivI6V6PkxLEaDJzbsKp239eaF/92v76NDJPM=;
	b=x8uBQiaCHZ7mNFUuTZV58V1ra+yRXWxY6Cu0C6yk8uRdViR7qdZ2f3O+xfFg89wGr0iB
	 ASPXkZ8BHaNk2LCdOKZkphXrooxVfqnjYU1KBmNo4v7/pV9wto9m86V1C6cFp/HZqmMPC
	 9pOPBFfRsiNrxsdemFYB8QYKKNv/8Ol7sC5hwhNpP3RMcoyM/aHSDyRUeemctskau0sJn
	 c4t+LJ03ijki8kZaBCQMkIoJSVb6CaLcM8GWmKAuctc0P7cS9Hhq/szn5TnQhz1iquzi8
	 ONCnt+8vyc5fSFBILdXNKttZu3Cyl+3h492AKlwskaBuJyXF1RqM/e5I3kjRAeAAyFA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=pobox.com;
	spf=pass smtp.mailfrom=pobox.com;
	dkim=pass header.d=pobox.com header.i=@pobox.com header.a=rsa-sha256 header.s=fm1 header.b=ixhq8A3h;
	dkim=pass header.d=messagingengine.com header.i=@messagingengine.com header.a=rsa-sha256 header.s=fm2 header.b=ukHKTeaz;
	arc=none smtp.remote-ip=202.12.124.145
Received: from fout-b2-smtp.messagingengine.com (fout-b2-smtp.messagingengine.com [202.12.124.145])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 976C5606A31B
	for <git@vger.kernel.org>; Tue, 27 Oct 2026 16:29:17 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 976C5606A31B
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=pobox.com header.i=@pobox.com header.a=rsa-sha256 header.s=fm1 header.b=ixhq8A3h;
	dkim=pass (2048-bit key, unprotected) header.d=messagingengine.com header.i=@messagingengine.com header.a=rsa-sha256 header.s=fm2 header.b=ukHKTeaz
Received: from phl-compute-04.internal (phl-compute-04.internal [10.202.2.44])
	by mailfout.stl.internal (Postfix) with ESMTP id 0330B1D0011E
	for <git@vger.kernel.org>; Tue, 27 Oct 2026 12:29:16 -0400 (EDT)
Received: from phl-frontend-02 ([10.202.2.161])
  by phl-compute-04.internal (MEProxy); Tue, 27 Oct 2026 12:29:17 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1793118556; x=1793204956; bh=wAcU4UzivI
	6V6PkxLEaDJzbsKp239eaF/92v76NDJPM=; b=ixhq8A3hX1UZJerEmooVIkrKur
	+V8lxznNytH0BcutlVBLVo3a4EQgE36TzlBYXyyh9jqtMdRta1y5hQoeBEFhwkR2
	t16RvM49tFMIyHY0k1j8fLWXzktoTtwP0O8Y/jN6WrlkVLLfkBhkP9Pa3xKUHpMk
	0NtXIshap9E8Hst7pGhvqmQCXOrk4JDfaXxh5+QLK+zX/P+gC3DTCwlWCsTJBBWW
	KMdRl17jxBso/Jg8QeJMXy8f/sKxKI0z7kVYoSQjpVHB7ft2ntyqtRCyLx643MqZ
	xpepoWQv41mfjm8dQ5BajmACVom02EopP8CGjUmpMPtjJDiaWkuBc/k7YF+A==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=
	1793118556; x=1793204956; bh=wAcU4UzivI6V6PkxLEaDJzbsKp239eaF/92
	v76NDJPM=; b=ukHKTeazlkTaR8mu0yViYcjY6iHTDq8EvQnCeZbgMMHu/s2N6Do
	5IaPu7Rd2+UNb07amHmuL1gCH92g826c1tV9FOnJZIMs0OYHaxqWv4vchDQUi98D
	voPKxuTqJUGf7R30W1R0UHKrnnWoHGjHpC5DG5kr2XFVZb17KRW99fKb2ZbOrPSD
	yvViYEdYq6FO8uZCXpvW/FFRsfKNXF55erEKE25KefyVJrq4C86pTInWo/BsdNvn
	caKgXYGw7OvsULxM2Ux4Wnzr5wIHIy4Qw9s2OHZM4V/Nmuvin3ZUWWtmk7oerxBv
	bc7DzdgzBc+qOQWPnKWVsVobFSvI2RzluPw==
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-07;
	repo=github.com/dkim2wg/interop; date=2026-10-18; sw=lmtpprox;
	action=sign d=pobox.com a=rsa-sha256;
DKIM2-Signature: i=1; m=1; t=1793118556; d=pobox.com;
	mf=PGdpdHN0ZXJAcG9ib3guY29tPg==;
	rt=PGdpdEB2Z2VyLmtlcm5lbC5vcmc+;
	s=fm1:rsa-sha256:TJ+uuRJM7OaXNcBTEsdTsdhA5Sy2UHaIGWK5Izj9jJeZbtJ
	X6vU6wh67tXhN0zxUT0NTu/1Uh9T7ly2hbDYhgSHWTQHKd8yHlSxoT5fphFX2B59
	ZHx8aNDoJBtjnR3jhczv/UXlr+DIstS0Aoz0MRgrKdZJmtx+fxNeCUjxCw7ZqMLQ
	7kWbN3tt+rMFqkW3BjqnuriGW6E8XUmoNbBuVnXPNQiBBvfLw3im2GLaFuAwEbMQ
	ht16oRF+VtiBHJQ595He+EE58+2fmUHbjjJB9d3xfI4BIe8RL3wYdvGZjUghmaLk
	edDEZ+OT9E1bhSvUC8bff6u7Ec8rmDn6Cvu4Mkg==;
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-07;
	repo=github.com/dkim2wg/interop; date=2026-10-18; sw=lmtpprox;
	action=mi-m=1; hc=12;
	hn=cc,content-type,date,feedback-id,from,in-reply-to,message-id,
	mime-version,references,subject,to,user-agent;
Message-Instance: m=1; h=sha256:laENV17tQ5LLZJMa5JcyHckUfD1JoudK0Fbh9DMlP3I=:5JIiDYjAqmdA+qCngvgXoPz535aGCcHeU4GET9q18WA=;
X-ME-Sender: <xms:XNHgamL5yIKwvMcBG5dBDjZ6CR_Guc9RXi4jsTPakO1Xfy10NBJwpg>
    <xme:XNHgah18aRkCieSgkzO0oAXSA7TkSWcz48W2cxChZajEZ6u5c_OuOK_4KucKK-n17
    4D0L2Jal2JvK8n_XUKmcGucai_P7syDuLKw6phjUAH0TIpG_Jqy0kU>
X-ME-Received: <xmr:XNHgaghB63B8M79wZxSgap8FnOIkOCwvazdkouD-yKS58qw_b_qV_fAXzTpwaf-zgTiRzeYLCwV1MaIaOnRX5TxAEtOe9Xf0TPYj>
X-ME-Proxy-Cause: dmFkZTEKos6FvFGx1QFeVnQhXI7RmYyX4McxhCPE6CL86FWsHLbe1WkNXLNi0yuTqwLC+1
    UNLHyeLbGRBlVj4k4/lUMr+R3hxSGvgy3Mf/6sXjV+RS50/1dM7D+vUmzGxTe/HoPJUOMJ
    pS0WSBF8Mp+m84eLDs7tIwqAdzVIFAU+d4uw29JW34US7XjfM/zPAhim0KhBv3ktS4RVBG
    r0+MX+JKHOKUtUqEuBFKAmAq0uCdRAeZJKlrQdjpmwMoy2zp328Zu3Xxx04kjQem0jh9rl
    dXRMRLIDAhckzlrMCAyHujchkeFD4iUwHa1OjRF2brFEM4O4MgCDrASaD7fj9dd+3aE9Q3
    c6HQDuA5EALfI7AuUBzxffTwg4VRIQVlpDkERHIjLtah8KVnUpsGRnE+BiZLquKoONzwCf
    NOrBt3zDMaVZp/G55QZTjF2ir8GgacfLgZOXgHhOUPdYiRM0b1DKwAjpva7NjBT7ICFMCB
    klXrxILO4PeT9xzbbNSB3nZTPuq83GRdkaqvFz5PAEVTTbqvFHG6LfU9dQrv1+PcEi5uyK
    axqV2rO/TPMmZzs2IbHeiyKTiN0D6sXFKwFwjCbWdn64d6k5GAPuII7vmSUZPmg1KjoJA4
    7ajEj11Bzy6u5k6r1O4EtoqC9ZPPpBfAeEAO7nYxil+VRTxSEEpxKuSDnM4g
X-ME-Proxy: <xmx:XNHgaiVQ5TeJ1xxc9PLMxYY_5T0EsLUGFenaHj-8fJTT8LVtwe0XzA>
    <xmx:XNHgavUsNjEBy78zRCB0ggS3xDfJq0NNaZt1230mETQ_9uTpT1wrIA>
    <xmx:XNHgaihhgRefRnvUpQq8yW_EnRNY67YNZWu3HsbIcgZPAKvxxCDjaw>
    <xmx:XNHgaqbESI5AVBX_nBWnXqx_cPFRxBahVqDWpsZhqrN53ARXV2v3YA>
    <xmx:XNHgalu1iCaJwQyMgRnZPgHcwdZd9kWU5f3UwH6Zjirz9YoihZFhM2lA>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 27 Oct 2026 12:29:16 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: Fien Dora <fiendora5@gmail.com>
Cc: git@vger.kernel.org,  christian.couder@gmail.com,
  siddharthasthana31@gmail.com,  phillip.wood123@gmail.com
Subject: Re: [Outreachy PATCH] t1402: test --no-allow-onelevel option
 precedence
In-Reply-To: <CACWAS-U2-riX0ajiaE4VgiQWxmoWcL-d9-arrSASa+dnVxoyEA@mail.gmail.com>
	(Fien Dora's message of "Tue, 27 Oct 2026 12:56:47 +0100")
References: <20261026132525.45414-1-fiendora5@gmail.com>
	<xmqqfqxsp3xb.fsf@gitster.g>
	<CACWAS-U2-riX0ajiaE4VgiQWxmoWcL-d9-arrSASa+dnVxoyEA@mail.gmail.com>
Date: Tue, 27 Oct 2026 09:29:15 -0700
Message-ID: <xmqqpkwvm7j8.fsf@gitster.g>
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

Fien Dora <fiendora5@gmail.com> writes:

> Thank you for the feedback.
>
> I'll revise the commit message to better explain why check-ref-format
> needs these tests, with the rationale highlighting its handcrafted
> option-parsing loop and the planned conversion to parse_options(),
> then send a v2 patch.
>
> Thank you

Please do not top-post.  Your response will come _after_ the lines you
quote from the message you are responding to.

And trim your quote to the parts necessary for bystanders to understand
what is being discussed.  Do not quote the entire message.

Thanks.
