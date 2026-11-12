Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=202.12.124.153
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794510563;
	b=pAJAmbYffZA8+DD8+llziR3NFW99zomcZxjtOi364hQK6iuIsBX/LQqhgBuZeG0WY70m
	 ieOTAWXqHJtTzWC5iKkmb+6sNxmSNFMTC9JBZr4A+E6v4wekdSB65aNSUQrqkQEjs97T1
	 QoXqbkp+NfR0V9eUqVzMarOJqf/p/E9wWo1SyzeG+h861IFQKZeWpOVFNscsubCC7o1gx
	 9I0xePUSgi1nuWy2IIQ/Fxxj0Vg/Ym/hiPWwkcnHv2IvD0Qq3fTR8aSW8q/QZFvHX5n9K
	 H96yafdNsQn5hVH85cHvpPf9uUo3wQDAQP2+YM9T/yXeggepSa50bE8+cHKsH5r2jNA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794510563;
	h=DMARC-Filter:Received:Received:DKIM-Signature:DKIM-Signature:
	 X-DKIM2-Info:DKIM2-Signature:X-DKIM2-Info:Message-Instance:
	 X-ME-Sender:X-ME-Received:X-ME-Proxy-Cause:X-ME-Proxy:Feedback-ID:
	 Received:From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 User-Agent:MIME-Version:Content-Type;
	bh=h3KwLy/4LAMStAwf0zowXIfJJy9nUXmluEawMDVUQZM=;
	b=Tet0dySTZVDiQ6Ey28P4ozbI72yidSlmDXQnR2ZALnSznjG9EwDe0XfnhYUJyeUjRtx4
	 zGodOyfDwJOc9+aT8y7C5jQ9600BCvoh69jV55R7bNrfta3FlSmRZdLf2STI0jETMTdiJ
	 bEWculTIizYlBaMn1yZyquhtszAINIWo3ftkMuIdtuWCQsKDkL9aMZbEar1dFwynTjl3z
	 oZ1E4WkF2wnGLRSA4TiF4AjPU2jOLU8depvxidWokPB94iCXT3GYIsnyrDZT9yydHTdQw
	 m9uGNAGrn8NIugPrxm1D0ZP2n3AnRGF7GM4luGK0wx6REMHjlKPk0tIkfSuZMwDCb6g==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=pobox.com;
	spf=pass smtp.mailfrom=pobox.com;
	dkim=pass header.d=pobox.com header.i=@pobox.com header.a=rsa-sha256 header.s=fm2 header.b=Rsh9Khd0;
	dkim=pass header.d=messagingengine.com header.i=@messagingengine.com header.a=rsa-sha256 header.s=fm3 header.b=ZpOAyxRX;
	arc=none smtp.remote-ip=202.12.124.153
Received: from fhigh-b2-smtp.messagingengine.com (fhigh-b2-smtp.messagingengine.com [202.12.124.153])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 906E9606A899
	for <git@vger.kernel.org>; Thu, 12 Nov 2026 19:09:22 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 906E9606A899
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=pobox.com header.i=@pobox.com header.a=rsa-sha256 header.s=fm2 header.b=Rsh9Khd0;
	dkim=pass (2048-bit key, unprotected) header.d=messagingengine.com header.i=@messagingengine.com header.a=rsa-sha256 header.s=fm3 header.b=ZpOAyxRX
Received: from phl-compute-07.internal (phl-compute-07.internal [10.202.2.47])
	by mailfhigh.stl.internal (Postfix) with ESMTP id A42F67A02EA
	for <git@vger.kernel.org>; Thu, 12 Nov 2026 14:09:21 -0500 (EST)
Received: from phl-frontend-02 ([10.202.2.161])
  by phl-compute-07.internal (MEProxy); Thu, 12 Nov 2026 14:09:21 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1794510560; x=1794596960; bh=h3KwLy/4LA
	MStAwf0zowXIfJJy9nUXmluEawMDVUQZM=; b=Rsh9Khd03osBlUTTzo/HaByl6Z
	4RcE3fy/Iz80nh8ULjoKNVayKSGKJOCDMQfzjdOOnVkhY9wcoiAwZRIYjK4gWOfH
	TTpBcyIIU9ukfkF4KzI3IOyJFeMUJiGyTykT39ASTRx5JFIEtoWMlO4E8BpqtkHN
	GFWhJU5Arvc9FhWV1maqub5LHzANJL0x2HNPgfkTB7BWn334DREbPLkeiBzGUZmb
	xiKacjul6ic4XbuyK2sK7Bj5lHwaZffQxaXOufjuIusR/0l5SulpWpcEcNmXBj63
	jDNq9NFdz6WOiQ75ff6DH/enKjFOylz7rK2vAzd+qSKo0iN+uknSNOmU2TDA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
	1794510560; x=1794596960; bh=h3KwLy/4LAMStAwf0zowXIfJJy9nUXmluEa
	wMDVUQZM=; b=ZpOAyxRXHf+p5/WGAHvm3IyAw89RVFMO40RcRCBo9unciXpIPDI
	8Xlo6F2Ja4UyugYQopKvfa3PNmT4//mRAnk0KL0kICMmgB+xg7RjmKmTlS9rbgob
	+wy9g+kq3IXLcRYXSpPOhyruUueGrIuczdOxPda/Lu6REdpMDBYk+o/Ii6YZymQq
	uU+DLk/JT+VdDfDOn0Durnw7jvjQ6WHh0rRyb5+v0KsFXPxfstIeG6LDjjlAGnQM
	HrlzwfsHO2nTK+5uiQQw7l2T/IEPtrRMmQTMplcO4J/JDXmebCiXCf00c91DE07w
	gu1RKX5r7tsviNzUvU8HmDdjo7uqRNrk/tQ==
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-09;
	repo=github.com/dkim2wg/interop; date=2026-11-03; sw=lmtpprox;
	action=sign d=pobox.com a=rsa-sha256;
DKIM2-Signature: i=1; m=1; t=1794510560; d=pobox.com;
	mf=PGdpdHN0ZXJAcG9ib3guY29tPg==;
	rt=PGdpdEB2Z2VyLmtlcm5lbC5vcmc+;
	s=fm2:rsa-sha256:lMAnIZ3hE7hS6k2Fi4J7ZKybSLsqmcvwaUcRvRQVNTpSMc6
	3jHJ+G74AMTs0LLB6eA/JDnbSvy3boMCcbyO614F674SIKJ0gF3WwVpRT9mJxCxY
	8Pw7wpqMfOfks6XyzeTuyRXBaL3EcWCd8VacS0IiO3sDauqzlm21qJj2HhoBiYlk
	gsk1q/IhUe8M8mszQyQiSjyv3upNzN1aPT8gZIvHPdtWWovz6cXmRbyD1OgVstJj
	JSukhR6ZOeMhgP1r8EnnQDaI7ylLKQHAP0j8b4oQ7EN5V20LOEEB0bzhxr+Vcepp
	v6Pu42qvQcYgcUYYLhkC7oDllCmylEmzrkqFmrg==;
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-09;
	repo=github.com/dkim2wg/interop; date=2026-11-03; sw=lmtpprox;
	action=mi-m=1; hc=12;
	hn=cc,content-type,date,feedback-id,from,in-reply-to,message-id,
	mime-version,references,subject,to,user-agent;
Message-Instance: m=1; h=sha256:kuQVf6TON9vPsydRbECLdfjYEi8l1j3utrRmQU1jHKE=:BqJkv5ZHMgDJpXZXGwLhMw0uxGl0ZyZjQytHpygq3ec=;
X-ME-Sender: <xms:4A72am3tiPf7rXO2U7zuaD_OE__SG3sIxyulei-CoSA6kfQHz2wPKA>
    <xme:4A72asxGishhcNZArgZa05eB2JHyaQTgHIu-NV3C09pBzISgXFL3vCkZ8ghXqhQP5
    Na-9CZrlyLSBFcwF9svLFTk2a8jxgqyZIzy-fAnUZqrOWZAx8cjuso>
X-ME-Received: <xmr:4A72aovHThOBz_u92ChFSbDEXACgAaMVLIIP7s3Fv3NOXnnckKHUxcyoSgc2D2Je7niRpbW0W8a3aoomyo-7SvEiG9ie_f8zfUqR>
X-ME-Proxy-Cause: dmFkZTEimuDRs0tkdXhe6DmBImMhroeQuo8ET80HitlEJD3dlzTZzE2Uj5UccAItjM9kI/
    xefx+q6xFOg9j1W+TcxlK1x9hbGqg2Kg+SgljlhEFOLAQMVzsLpAYAEOtW5vKiY5rp7gju
    NVUEyd+uhaEO8oDW6ohYrnizMDmH50RLX2gw6jBFx1etyfhZACkzOy36lFScNy19lTGFdG
    crV0oPzMLPq05lHtn7u2+RqHm+vZQLDceLJ0MJHYg66vmwhF/jGbIJZ2/sZ50U51W9/ZVs
    BGDBATqSO76klLnip2vvwz2LzYNLhHqSoz6B37iRw3fcbetIzydi0ImxWO1uaKX5UFI0CB
    4VVdp+OGKpyhNhpLEoR/L6MyyF+jCFdDsfkAWlLUjb1+MiZ52Xco7gdX6+GHdPLTjkXgAt
    gy8qi0HnAyEcfz9uM0kasr3/EwpRLIAgs81a5EWRdjl2YBkx+/Fw2loa/UcFxLouuLdSrk
    dD0dJGML8EQbvHLs1bKLWgw1P0C4iwWw5wT11O5Eo6AAOLtrS/ARIq+6OA2Lc3ifB98PJw
    AupcJO/VK4EHt4eBnwYnOLUghbhctxe3NHz0hOUyu6HXbKOPNM1EIHTzJYRCtiruExP9Fw
    iacnU6kBHmlDfYbYY64mO7ToLm79PIrwgsUvkbQgjxIZcNNwRBwDLUKJ8cuQ
X-ME-Proxy: <xmx:4A72auxH42Hx-5BOAfqJgwsgTR47gap_VCKWtA4bKjHjp_BjoUyJtA>
    <xmx:4A72arB2aTz4vLqnRhwwUM2x6UNLhuzmNJXyf4fi_e2AtE_qE9dmSw>
    <xmx:4A72asfH-RKEoR8IBijT28U9lqYPdpODV_blDZEygL8ZkWyPfEwjjA>
    <xmx:4A72allQU0kWRUE1cIZg70HIfb6Gq2k09KC2GmsbjB3JXOtwCyjrwA>
    <xmx:4A72akxVCvwv7VX9ygwQKd7ON1lzTwiq4A5k6d13Ci2B7fXMfOGTjBPN>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 12 Nov 2026 14:09:20 -0500 (EST)
From: Junio C Hamano <gitster@pobox.com>
To: Miklos Vajna <vmiklos@collabora.com>
Cc: ps@pks.im,  jltobler@gmail.com,  szeder.dev@gmail.com,  git@vger.kernel.org
Subject: Re: [PATCH] log: make --follow following renames for non-linear
 history optional
In-Reply-To: <avWBQ_10mHUNQcFi@collabora.com> (Miklos Vajna's message of "Thu,
	12 Nov 2026 09:05:07 +0000")
References: <avRtsm5VQpC_g9yN@pks.im> <avWBQ_10mHUNQcFi@collabora.com>
Date: Thu, 12 Nov 2026 11:09:19 -0800
Message-ID: <xmqqqzgpj28w.fsf@gitster.g>
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

Miklos Vajna <vmiklos@collabora.com> writes:

> Hi Junio,
>
> On Wed, Nov 11, 2026 at 08:44:42AM -0800, Junio C Hamano <gitster@pobox.com> wrote:
>> This sounds sensible, and is far better than reverting and declaring
>> "The original 'checkbox hack' should stay here forever because doing
>> it right will be very expensive".
>
> If that is fine with you, I suggest just replacing the
> mv/log-follow-speedup branch with this patch.
>
> Hi Patrick,
>
> On Wed, Nov 11, 2026 at 02:29:22PM +0100, Patrick Steinhardt <ps@pks.im> wrote:
>> I don't really have a good sense of how far this patch series is on its
>> road to getting merged. So how about we first land a single-patch series
>> that introduces the knob that we can merge without the remaining parts
>> in this series here?
>
> I like the idea, here is a patch to do that.

OK, let me eject the "speedup" topic and queue this one instead for
now.  We can discuss how the --follow-merge code can be improved
separately once we are happy with this "opt-in" change.

Thanks.
