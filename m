Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=103.168.172.148
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794842989;
	b=OabRTnNTOGEQbUrn/1b9Z78lCgucSO/Ukv8kbWqP+MY4wmvaoOxbdo1BNIDz5ZDyRnUI
	 wHxI+3Jw7Dgp8bYDyq7SLb+kAZ1rM1dIAsJvZna/FnJyAYrSAn5Y/GJLEHi47r/oQg014
	 CTja0xS1e7gdeP88J/245TT7lwdbwWgDBh2ViWiPy8iukiL0pGULTtR4ATCvL6gHj/To4
	 lGRM3Yl8Nvcxr6o08+kaM4YWhOQ+xznpfUsV18t/NmXdbmqm1YgG9UsREoWs6QhfoiPce
	 jyiGtNZBoppz5dGAkOBrg9hJEp5qb9SOS1//BZnWg5FJUIh/+Kh3H4Iu2DXcxUZ9F8w==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794842989;
	h=DMARC-Filter:Received:Received:DKIM-Signature:DKIM-Signature:
	 X-DKIM2-Info:DKIM2-Signature:X-DKIM2-Info:Message-Instance:
	 X-ME-Sender:X-ME-Received:X-ME-Proxy-Cause:X-ME-Proxy:Feedback-ID:
	 Received:From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 User-Agent:MIME-Version:Content-Type;
	bh=Nvjh2WydB/dczEVKpkUJYdQ60xeQVUHZogkwiqu1T8s=;
	b=WRkj2n+ebH/8aMqoI7d3XLN/qrOprFM+UKod2aQW2DADIy7VJtkPgSJ7hv+eT9XI+Fpo
	 wkQuOOhmFIFiKdGOqLJ4JoZHT+ij5G5+2qK+g+r2PCF+NnMJPiNtQdm+YDvrRXu/MuO+2
	 7SobAZ0XwaicvWKrWJ3U73WGmEesF073NDiih88/RqrKsKCSeTZE8UZb/6qSKPN/7bEJv
	 nU9HLqDOD1lRhExyoFcT6bXgFC85uNvWEwKL3oBdOnLmi/xBfeujfUSSaA5UuEjSxze8b
	 x2BaM4s1C9EPaAtM/xoQIhXxyWGaT7SR63B75bcEz2MwVz20ER0UxWvTFHVf4HBh9pQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=pobox.com;
	spf=pass smtp.mailfrom=pobox.com;
	dkim=pass header.d=pobox.com header.i=@pobox.com header.a=rsa-sha256 header.s=fm2 header.b=ePuYTm7Z;
	dkim=pass header.d=messagingengine.com header.i=@messagingengine.com header.a=rsa-sha256 header.s=fm3 header.b=MPkifvGz;
	arc=none smtp.remote-ip=103.168.172.148
Received: from fout-a5-smtp.messagingengine.com (fout-a5-smtp.messagingengine.com [103.168.172.148])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 78398606A33E
	for <git@vger.kernel.org>; Mon, 16 Nov 2026 15:29:49 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 78398606A33E
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=pobox.com header.i=@pobox.com header.a=rsa-sha256 header.s=fm2 header.b=ePuYTm7Z;
	dkim=pass (2048-bit key, unprotected) header.d=messagingengine.com header.i=@messagingengine.com header.a=rsa-sha256 header.s=fm3 header.b=MPkifvGz
Received: from phl-compute-08.internal (phl-compute-08.internal [10.202.2.48])
	by mailfout.phl.internal (Postfix) with ESMTP id 90D7CEC0179
	for <git@vger.kernel.org>; Mon, 16 Nov 2026 10:29:48 -0500 (EST)
Received: from phl-frontend-01 ([10.202.2.160])
  by phl-compute-08.internal (MEProxy); Mon, 16 Nov 2026 10:29:48 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1794842988; x=1794929388; bh=Nvjh2WydB/
	dczEVKpkUJYdQ60xeQVUHZogkwiqu1T8s=; b=ePuYTm7ZTBWhSJX6RnHqiQmihI
	wrRv8zC2pyD0hgnuZZmzYTmTpBeltN0pWtnM7vpHwOzGZnmtuDajNbpR7GQrsuVm
	QgbLjy30nx2jf+bChBi06QQzCoJBzxVtStgR8yv9qCyEbqlNVzGgg0yxHxadKMvg
	vZXK2+DTeKYSBGb0pnitdMpEuRbCtte9yNk+zSEqxIH2a+rB7QHxlqF7C5X/Sa69
	oRaFTiBevA6Kg6E5KEXpUPA29961332AtiB35AABRREX2MddbRA1Ko6tcmjDVb4+
	UkFeH6dd0d32Trz9RW20xnLdWjYofRV4pgOCM7A1LOR1wKfcAvW5ghl34xQg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
	1794842988; x=1794929388; bh=Nvjh2WydB/dczEVKpkUJYdQ60xeQVUHZogk
	wiqu1T8s=; b=MPkifvGzl5OnE2J3S2m6njBCqvPZnaQUOyknp9n9QdGP2jK5Jhf
	S/mqVP4wYuh72pc8HG3A3OTOPnXxlcyTZHyceVrwRMFNAshq+3kYXbU+0gLL162y
	vfl6SHTDbZ4HNiRdTs+dHsfKsnj0+x1OX5m9EK92XP3nxSHXVZNxak38Lke3V3qr
	T3WMStWpp/65DX54k2ehVLgZBfsKpy51su/pJ1XDdgblE1fONjf7FDV/vPIBsL06
	JCiumaE1fhJIyedwtJ9qxp19C+MzJGpwoR2Y83BlG8FFTer3WF33DzWmXEBnozmK
	Pq2ZfX5fGZdFElvqNN0Eu00muchWY9Mdyiw==
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-09;
	repo=github.com/dkim2wg/interop; date=2026-11-03; sw=lmtpprox;
	action=sign d=pobox.com a=rsa-sha256;
DKIM2-Signature: i=1; m=1; t=1794842988; d=pobox.com;
	mf=PGdpdHN0ZXJAcG9ib3guY29tPg==;
	rt=PGdpdEB2Z2VyLmtlcm5lbC5vcmc+;
	s=fm2:rsa-sha256:iFFTCTtFs8QzLDoBQKDbbj63B8tqFVQMBTnjDX7CuMxe/v1
	NLy8QeT25raw0BFnm3KaOEhcSZRalJpVNp7lNh3DZCxIFfR9Osj4LlBzT1VMsb0n
	EZFGzGm/pvup9dIyFAInprtRoaZB/dRez3lX7FTnvHXbxulGyeqyrocooLwkkfhm
	AFZldUK8wy5EGTLgz0YyJMHD2rGmFy2AtCX5q1AnqeCBCgSaOElOzw445+mfEM0f
	/tumX4Thz/O+YWZ7n3qi5m1aJpwImNp+W2DGxFs7l2gcKiwxHqov70CPc/e38e7W
	7YmkBlN+zVBe1gT63d1wUJMJS/VNdWgQPhwOzEA==;
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-09;
	repo=github.com/dkim2wg/interop; date=2026-11-03; sw=lmtpprox;
	action=mi-m=1; hc=12;
	hn=cc,content-type,date,feedback-id,from,in-reply-to,message-id,
	mime-version,references,subject,to,user-agent;
Message-Instance: m=1; h=sha256:IS34A8RvI7QVaGpJTi3UD0Du2sgt4LV3FK0888Vvjjw=:H94OmSofthoKGPiceAzhJPNfCY0ey/3f9C6QDfGr0Rs=;
X-ME-Sender: <xms:bCH7amPKKumqP8lLv4tsNIdvolJLQ7voemjgrc8Sy0b16Ibx55vpeg>
    <xme:bCH7ar_ef4klFZFW5Bgti3-bs_UsZLG8hn3Th3sUpUHIZWaczBr37xPC7VoPOAU_U
    pElgzX-94Xw0m1jRbs9dVzmmW4FJM0aKfTk0lT7KluVb4DUt3vgcKpn>
X-ME-Received: <xmr:bCH7aiR_j9Xs2_XMHuMEYQ9GtzX28U-gLME_uKGRc6OsPDD8viRuxQMSuSIs8xNk2YtYRPzx9Ut1C86aSol3K1oKPtOKOoZLehRx>
X-ME-Proxy-Cause: dmFkZTEbaEiONYz8mzbOE3IFyHUykTjwGSwdYPmvWfJpqwCkf5vBKYBZmOUSDkq7kwlFdQ
    xilBJXApjp8pAT6Dl+le/FOWd4DCGH+U67G7PcvJir4/FcaFB//Kmluh/oWJEQz9ML8QUd
    fvv/dXmKz0ycnlS5siVDSJ3uSY1LqHVoxfQmioxk1uBK+vrE5eJBw/8NmJ8id71oYg+K7i
    cqXJigK0vVj82yVyZlELqvNAwO3LhY1jpkPkHk0eaNDZGsuusARBST/RzbnkMjMU526666
    p8FgqmjSFTqODFUy2LRHzumyJGlmvNbqkhpxzG2N7rp9IcCsFWo8fK1wEOQ6AyySoYDRB2
    64sTtikuGnzuaoFSnxumhC6TLlAeAx6+QVxa4WNF7dlvslHyPPsFYwY1paKvVJcJQBhtyp
    e8vIjLltKb2hDk0qPRHnqLyzttxcMXluTYKop5wZCLTJ9wn6Jif6Qp3IkBnhidQS2nv7qy
    AmOFC0UJFjpPX2w2KtjJ5AgX6T+OYvl8qWzAAlmIJA/I2gyzRfBTTfg3Z50CCS/Lcbra+o
    B8X8fiI5kjfNLkJf2MwhULhJu0aCfQ1FpfFvpECyL8IPlIDgiJk8vNyNNAx2iUcPr280b8
    roboTV0euH+X0lJX6K0gca6QJOaEUmPvtrfm9lG6CF3j0HGmvTh6KFFgPlzg
X-ME-Proxy: <xmx:bCH7almIoyB31dURYqcEvadxtZq0ILEu_zPDq0X-Y6z40Czt_8173w>
    <xmx:bCH7aqQ5bl-Lz27jNDbkKruhx10iwEf0KCDr05m1AXgLg3AL8iY5cQ>
    <xmx:bCH7arMwflOu3k2d5x-Sp36y3VKErN3R_1_I12Lfh563sajG8m_vfw>
    <xmx:bCH7arWhapP1SBvL0C_8moJBv_BVzLd7Ob9TIWjK4UBkthZ7Q2TeFg>
    <xmx:bCH7alx6NzECBCVEN_fR7UVI2TCI5hqiBjT_4eMIgja5BE_v8DOa8kgD>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 16 Nov 2026 10:29:48 -0500 (EST)
From: Junio C Hamano <gitster@pobox.com>
To: Patrick Steinhardt <ps@pks.im>
Cc: Christian Couder <christian.couder@gmail.com>,  git@vger.kernel.org
Subject: Re: [PATCH] promisor-remote: fix crash without a repository
In-Reply-To: <avqkLnnMwBNeWWtK@pks.im> (Patrick Steinhardt's message of "Mon,
	16 Nov 2026 07:35:26 +0100")
References: <20261113000600.202744-2-christian.couder@gmail.com>
	<xmqq33t4bjrc.fsf@gitster.g> <avqkLnnMwBNeWWtK@pks.im>
Date: Mon, 16 Nov 2026 07:29:46 -0800
Message-ID: <xmqqtslgn6ad.fsf@gitster.g>
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

> I was wondering myself whether a better fix would be to start passing
> down the repository and then detect this case by checking for `!repo`
> instead.

That would be the most sensible way forward, as it would potentially
allow us to help more code paths free from the_repository.

> From my point of view it's nowadays a bit of a code smell to
> check whether the passed repository itself is actually an initialized
> one or not: if we aren't operating inside a repository, then the caller
> shouldn't pass one.
>
> That may be a bigger refactoring though, so depending on its scope I'm
> happy to live with the easier fix for now.

Yes.

>> +	/* 
>> +	 * "ls-remote" has no business talking about promisors, and worse yet,
>> +	 * it can be run outside a repository.
>> +	 */
>> +	if (!repo->gitdir) {
>> +		if (accepted_out)
>> +			*accepted_out = NULL;
>> +		return;
>> +	}
>
> But in any case, we should also detect the case where `!repo`, I'd say.
> Otherwise we'll have to adapt this code again once this funciton's call
> chains get rid of `the_repository`.

Yes, again, but as long as we have sufficient test coverage right
now, the dereference repo->gitdir would immediately segfault when
our caller stops passing the_repository and instead passes NULL when
it notices that we are not in a repository ;-)

