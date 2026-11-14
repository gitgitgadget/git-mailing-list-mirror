Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=202.12.124.149
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794624893;
	b=FKqx3GmU6lyfyTcctWR5iu6d1ykj3Q/TGH9YvDC4VLczshUzVVUoAVXzZM15oQac04f4
	 DgYf6db9/SXuX2VccW5IHuEIQeiTb/I8Cw1kOw9oMzrultvPPCiTU54I39ATozxDuop3l
	 ZPsO97Ld+ZyOFDZNwV+tu0mXt4NS6l0zL5dAWFcB6OsLNA8t3avuG/9hIld0/QOWciyk3
	 rRvo7CX4bRwYrIkT88qwgX7yVPYYL4Lvd0FY4JJn6FVdys7JvxRffXSoddgH0U37azBeb
	 qcpIzR09BzIrG/kMCOj8h3skqfuSxDDH+sJWGZJ/qP/YcJP9FwvIRzoy3Z22LSmFc2g==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794624893;
	h=DMARC-Filter:Received:Received:DKIM-Signature:DKIM-Signature:
	 X-DKIM2-Info:DKIM2-Signature:X-DKIM2-Info:Message-Instance:
	 X-ME-Sender:X-ME-Received:X-ME-Proxy-Cause:X-ME-Proxy:Feedback-ID:
	 Received:From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 User-Agent:MIME-Version:Content-Type;
	bh=LM4ISbcsofxTvjc/C7qdeJFe2OTMf4MDY/dAdYpO1vM=;
	b=WeVKfRU8F/X6hbKI5ZNoLLrYqMOQh2DUS4XDbksBEiTaes2k+uv3Gl7Y0JJZGnahFhq4
	 8stttI9fPwW8H4eqIQexL0aoXU9XYePEloBXuzeDsi2e558fvW+JcbXfjtFit4qPr4LVC
	 Wt8TvkIcdt3FIXbI62v+LBeZLtLK8+UZ+kCXLXM8EcDmWfVBgIo5Zdac6v4KY4ukN8ch6
	 YOVuQsUuMJC3UrSe15J24RC/X4MuoAyJf2pjVdHJy5/5fURvy9URA+8CjcAX6Oi7OOMwa
	 LLlme1j4iVRfWzWxgJvJxxADjnLXgp8ZinBylMNq+0oPXykbBtcIO5TG2M0qdwaWmeg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=pobox.com;
	spf=pass smtp.mailfrom=pobox.com;
	dkim=pass header.d=pobox.com header.i=@pobox.com header.a=rsa-sha256 header.s=fm2 header.b=keueWQIa;
	dkim=pass header.d=messagingengine.com header.i=@messagingengine.com header.a=rsa-sha256 header.s=fm3 header.b=NPgqrMqG;
	arc=none smtp.remote-ip=202.12.124.149
Received: from fout-b6-smtp.messagingengine.com (fout-b6-smtp.messagingengine.com [202.12.124.149])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D671F606A323
	for <git@vger.kernel.org>; Sat, 14 Nov 2026 02:54:52 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org D671F606A323
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=pobox.com header.i=@pobox.com header.a=rsa-sha256 header.s=fm2 header.b=keueWQIa;
	dkim=pass (2048-bit key, unprotected) header.d=messagingengine.com header.i=@messagingengine.com header.a=rsa-sha256 header.s=fm3 header.b=NPgqrMqG
Received: from phl-compute-05.internal (phl-compute-05.internal [10.202.2.45])
	by mailfout.stl.internal (Postfix) with ESMTP id 227291D000AC
	for <git@vger.kernel.org>; Fri, 13 Nov 2026 21:54:52 -0500 (EST)
Received: from phl-frontend-01 ([10.202.2.160])
  by phl-compute-05.internal (MEProxy); Fri, 13 Nov 2026 21:54:52 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1794624891; x=1794711291; bh=LM4ISbcsof
	xTvjc/C7qdeJFe2OTMf4MDY/dAdYpO1vM=; b=keueWQIa6fUVwRV+2pZSaxT/iG
	SH2ofrk9OJs0Wzvr1we+PFGYhExYTpti2EFhgVhrL9NX9dWuKgpZo+odItA4G52X
	A2Wn2fkSr5PWYYYoWDZKVPH4lQbRiJBIB3v0VtFfbpoQPPlAeOpgWQ+DpUmBD/f6
	vTadLx8tg+B0i/ufTwX1Z51e7pMgigmqZBZA3REzGOlmLN2P3JYp3qLnsWHdTWK+
	DmNIlhRH13qUcGlbQrom5d1pYXFMD8fT8875+VkZQ1N2fLBD6NH6Y0lpslvsKTj2
	VzOgG5hGCJP3zTL4IzKpyMnDYIyzTB8mv6julZBHvCpmCsMMmTZPoIF0Hf7w==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
	1794624891; x=1794711291; bh=LM4ISbcsofxTvjc/C7qdeJFe2OTMf4MDY/d
	AdYpO1vM=; b=NPgqrMqGD+RznignWtcwhaHmySOatSYoOxFqQZlJ+AyrttFILlD
	F9hqB9/x8NwDQ5S1Kk+n6jLa7u/EiHOaGf0jcA6mSZxseUnB9Ev1fvdQksGHC0xT
	pDFfBVaw7oVJmelTijXkqSeB8nXASt7IaWdW/QbBH7oRd9vp9iLeHLBEM4XnMs8o
	UshBPS2cPMQCYyN2qXgViTulXH+qBAt45z6jYq5PkiJ4LeFzvxJmEBxqVMIPVPhg
	1LtJm0kRCdeNdkTWC3GjxnQIFm7ipBIqe1oZMgxOgi24M3KRbPRrAeSoePseqAHi
	Ixbk+JTYXcfX2uEoe+c7JbWZDB/BhvqzoBw==
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-09;
	repo=github.com/dkim2wg/interop; date=2026-11-03; sw=lmtpprox;
	action=sign d=pobox.com a=rsa-sha256;
DKIM2-Signature: i=1; m=1; t=1794624891; d=pobox.com;
	mf=PGdpdHN0ZXJAcG9ib3guY29tPg==;
	rt=PGdpdEB2Z2VyLmtlcm5lbC5vcmc+;
	s=fm2:rsa-sha256:d5PGeq8f+EBt0Vzc/ZUbq25avraVkbf9ctpjn3agO58pv0f
	5pq3VE1GcA5qRYzP3oj304z/jtyrajwEAPqDTfnEbPgm4bNK7+K8xz7IW8Cz4VB9
	Xty7ZSC1NhaUkJIUc5P1q3SZPgYNyMfO2FPgX+MRZD4MDheP2WhRdK8SM0nXGCCP
	AChT2h8/x98dmuqkagPBWJP3IYBu+V3y99Pt2lOwemXMCTqdB/8pkRLj5I8y73ec
	x290nWKpykZZR4fqBc/bVON6IRzsJTVjrnvxasYa8BME7sinrKkDZD6hnXz4SDCd
	ODlHD9CFD8lbnRmeHr+fpxhHE2qzvRLz6ZLQpVQ==;
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-09;
	repo=github.com/dkim2wg/interop; date=2026-11-03; sw=lmtpprox;
	action=mi-m=1; hc=12;
	hn=cc,content-type,date,feedback-id,from,in-reply-to,message-id,
	mime-version,references,subject,to,user-agent;
Message-Instance: m=1; h=sha256:tXQaZGeAoKxaScDg44mpB71zL3WXLgWm03CR37hL+Jw=:fH4nLeS9Cr6V8yEYJQ25lOKPhuS2YRezGV+Q+8JIh1E=;
X-ME-Sender: <xms:e833agpcK_DXpGomdFjNFoGU-JUuY7vDppcJDq5fWC3yO1K_BBP13A>
    <xme:e833aqVt0LPpAu2YIEeu8ly-zhYeVCQGj8bPn2RSyC5yJ3bdS-ZqFAjm1f8DGf7aO
    lnioWb1eI0p1wMPl4MSGlJ9l9biizbILuSWR9HOZ6aZBJD3_O9Q1nM>
X-ME-Received: <xmr:e833avBHIEWOYPeQtNBAp3peDpmW_bIp_ZUvpzg6fbBcwyru8e4nQTrB_QkCSEPcX2QYmVnwNNEzhZ41UNLVWLkRxzws71aHX4tV>
X-ME-Proxy-Cause: dmFkZTEwwilK9K6odQb4QVLKlJt73O7CVgKhawRdL1Egj3aX09aY8XleTurYsv/SbFro0H
    T1MIvHwAdPAYqCP0I9e5h9nXz4SFaMMflcClnRzzkI+JkfNRkTOuXKvspVtwQiUZrZkFFc
    ei7y9rGkYptAXK9QXTe2rZzSHFPM2096hbTtkAq/I0ntNcfgP4SINm8D9sjOCuwVqOkp6M
    2LnsE1Q+49krcjiFgHh70x1rNxN53siokqzEjq1FO+R0ugdH5mWMQ/VTQS5BRIrxdv30YE
    aMKh/9bCseCjUFvlCBmBYebJUxDfJ//frOAXjRSkRcKz9drVFgTu5fsdwGihrxF04HQjKY
    3Mj213CQntX/BLG66juJvsa6GfgIimePLnNgebf6gApyjBLxH2mwAmPrYe5++t0pKiLsMf
    e+7IDzZ3d65lzWrYguBKDrQg77/mDFeCk47le1xeV4u8V8qKea/t3VW9qeEvQZXqv3oZsf
    XFD3Ti2r/Z6bfPWyFWKXnow/8fdZq8epkmLNNRcgKlLBtNb/ITTK0A51oXzA7hrQHMdYwl
    vvTMIClWn5ZFZxE+Hz9KHmb5CFaeLFV4J/btPxPUKkq4Y9sqz29FRI2kjy678y+ZBt38kK
    IKezA7r9q5ER0C8u66HTmmd2N0r5d47OHvddjXCRQRQKQtkS/24Ev9l5EpEg
X-ME-Proxy: <xmx:e833au2wjcS_X3NpKKHEugDRi-Mpvv1fBytTv_3jjuslUe_40r-3lw>
    <xmx:e833ah0SOwSNPntn3HZ26I5-FcLQLd8Z5MU5i59EzbOkdJH4z3uqgg>
    <xmx:e833ajDjWEeDG35r1oIOH_OLjGAZaHnDPM65hZk73gJEWIxhIEPseQ>
    <xmx:e833ag5SPlvvvhyI_cWR20W5C4bdnHHMUOjiOybmq37Pl7I_P_6DPg>
    <xmx:e833aoOciKzteCm32C49CCgtOPoUyqy-bCjO6khxKzFu-vql9ZRF51OO>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 13 Nov 2026 21:54:50 -0500 (EST)
From: Junio C Hamano <gitster@pobox.com>
To: Julia Evans <julia@jvns.ca>
Cc: "D. Ben Knoble" <ben.knoble@gmail.com>,  Julia Evans via GitGitGadget
 <gitgitgadget@gmail.com>,  git@vger.kernel.org,  Kristoffer Haugsbakk
 <kristofferhaugsbakk@fastmail.com>
Subject: Re: [PATCH v4] doc: checkout: rewrite detached HEAD state explanation
In-Reply-To: <xmqqpkw89yzi.fsf@gitster.g> (Junio C. Hamano's message of "Fri,
	13 Nov 2026 13:56:49 -0800")
References: <pull.2250.git.1791384721919.gitgitgadget@gmail.com>
	<pull.2250.v4.git.1792177409868.gitgitgadget@gmail.com>
	<xmqqh5ile4h4.fsf@gitster.g>
	<CALnO6CBGcG42NxtpuPaJVrzAMC=J8iVstsHCSi6vDQhDmFJ-Kw@mail.gmail.com>
	<ddc6d42c-6e40-46a5-bb70-f89f11525ac4@jvns.ca>
	<xmqq5wy2kqhl.fsf@gitster.g>
	<931a94e4-feab-49a9-b5c6-479f0d7f8b75@jvns.ca>
	<xmqqik21j1ie.fsf@gitster.g>
	<4d6f9b6a-e658-4797-bc4a-0cfc533056d8@jvns.ca>
	<xmqqfqx5foxd.fsf@gitster.g>
	<36e73720-287f-47a5-bd3f-dc53629ac968@jvns.ca>
	<xmqq33t4fxx7.fsf@gitster.g>
	<c12bf331-0d11-497b-b5ae-874534a42385@jvns.ca>
	<xmqqpkw89yzi.fsf@gitster.g>
Date: Fri, 13 Nov 2026 18:54:49 -0800
Message-ID: <xmqq4idk86me.fsf@gitster.g>
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

Junio C Hamano <gitster@pobox.com> writes:

> This is a manual page, which means it has to cater to both audiences.
> Unlike a tutorial or guide, we cannot say we target this audience
> primarily and expect the other audience to figure things out
> themselves.

The detached-head.adoc is still a part of a manual page for the
checkout command, but gitdetached-head.adoc can have its own
material.  It does not need to stay "just include detached-head.adoc
and be done with it" documentation at all.

> Perhaps a FAQ or "survival guide" that targets these inexperienced
> users would help?  Unlike manual pages, guides have more freedom in
> choosing the material covered and the order in which they are
> presented.  I dunno.

So the rest of the gitdetached-head.adoc, other than the "include
detached-head.adoc" line, can be the "survival guide" document, if
we wanted it to.

