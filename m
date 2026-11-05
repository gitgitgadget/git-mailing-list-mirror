Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=103.168.172.151
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793900705;
	b=VdohbI4S1N5Yxw735NdlPoc8BMNw5kW/mOK+i2qHhLGRdWuJD/Qi564qJIYFMR9GGa4i
	 0JfG+owfMLjk7srsVb0wJ3uP3ZiFpNe0ptFWemABtFPx5+u/4krgTrdEUFtLEhaiEyfY9
	 ZT5JgjXeeN8+Y/EhTj/cLVFtmYRjSv0MOj8x+8RxNmi8EiNg+wO7JWxVJZaXN+/gp5SW6
	 38W0FEZLLD5H98thPDCf4WaXYirChV9KdniqQPdwqeTE79eRvH58ni194wnDopzPh3PTd
	 h1NZfQcYA7SLzyUkBMKyLEbAvdO7Zw4Vl9AeBfuxU8feNTFjJ27uLh61dyX/6BJwqOQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793900705;
	h=DMARC-Filter:Received:Received:DKIM-Signature:DKIM-Signature:
	 X-DKIM2-Info:DKIM2-Signature:X-DKIM2-Info:Message-Instance:
	 X-ME-Sender:X-ME-Received:X-ME-Proxy-Cause:X-ME-Proxy:Feedback-ID:
	 Received:From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 User-Agent:MIME-Version:Content-Type;
	bh=V/OAMM2qYWemAiFCIji+DugpYs+jaqRc5E0OjxHPlWo=;
	b=UNazVfY9L0DKRDMp8Aw0e/oe4pv9j6jxKSNssPLws4sPlN02Bd7ooexVT+viuK4n3525
	 conESZaqBxAgxEo7GahglFZrhV83eMtrBeICGtln5w2+4b9bQyG5bvt5QO/SrUTFi9027
	 Vctd2CsERWiYiSQQzBAhQlwr3IOlyNPvzC73pMoausOtukEkXLCv63zxBz7Woo5UZ/v9F
	 l0lQnuL0dfgqm/OjkHMmCaXOWiQEX422mPGfeOnDEEOrPRkkUsExW5KXxCoWxPh6Vhe2D
	 c4ZYPe8lpTXi9B7dMoSYukBjFfy4C9Q953SjkHaEYJ0BOUOcNAF9Kyavhv/h/NscO9w==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=pobox.com;
	spf=pass smtp.mailfrom=pobox.com;
	dkim=pass header.d=pobox.com header.i=@pobox.com header.a=rsa-sha256 header.s=fm2 header.b=R7WxO61j;
	dkim=pass header.d=messagingengine.com header.i=@messagingengine.com header.a=rsa-sha256 header.s=fm3 header.b=3VW9XU6Y;
	arc=none smtp.remote-ip=103.168.172.151
Received: from fout-a8-smtp.messagingengine.com (fout-a8-smtp.messagingengine.com [103.168.172.151])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B6A1F606A328
	for <git@vger.kernel.org>; Thu,  5 Nov 2026 17:45:04 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org B6A1F606A328
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=pobox.com header.i=@pobox.com header.a=rsa-sha256 header.s=fm2 header.b=R7WxO61j;
	dkim=pass (2048-bit key, unprotected) header.d=messagingengine.com header.i=@messagingengine.com header.a=rsa-sha256 header.s=fm3 header.b=3VW9XU6Y
Received: from phl-compute-04.internal (phl-compute-04.internal [10.202.2.44])
	by mailfout.phl.internal (Postfix) with ESMTP id A6871EC023C
	for <git@vger.kernel.org>; Thu,  5 Nov 2026 12:45:03 -0500 (EST)
Received: from phl-frontend-02 ([10.202.2.161])
  by phl-compute-04.internal (MEProxy); Thu, 05 Nov 2026 12:45:03 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1793900703; x=1793987103; bh=V/OAMM2qYW
	emAiFCIji+DugpYs+jaqRc5E0OjxHPlWo=; b=R7WxO61jrKLO9mg8xZ6DeMlMPd
	i5HQkhMXO1n1QJXurzg+/6wodHno2aWnnFIphZlWGopC4SRj9xxL0bXexdmCL2sN
	o6BwGjBs9rMErWEM0cBjkeSrSj3Z0TBGTH+Qwsh0wAWRWluxXizGkiRyV35EkMOJ
	1vqrEieYjYF+yGTEQUEXMOpV1WchCtBoUtgNogd/rts+SiJKrBpuGpPks6nusoLH
	hFEZx7MtGyW0NSJqA77nbY824Cue2B1JuYOUdDFDoTO2rWUNs67qhVR6uYOLzIDH
	zN1kvPNN1JFmJE6dYTgbw/IXT/MO+fBnzB50ASJ9zaqaocsmHIiFc5LU8XMg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
	1793900703; x=1793987103; bh=V/OAMM2qYWemAiFCIji+DugpYs+jaqRc5E0
	OjxHPlWo=; b=3VW9XU6Yk/XqmGsPci8tuvuRTjQ3zIms9NEO46ymc7E5y/mkKt6
	sMlh9ECA1HKczgQ7N3WVyxgSUmyCImDL6YgN1ihIcqW3QRX/uyasyZWlDGp8hSfb
	SF723k6Uv/dVfFbv3upPNElUX0nNpmiX3DCNqqdPc8CYMAehEitH+BEAcpHbPsqu
	RCkuI1aWK5WKO0z8MP6a1Yrj7yE2Z9dCxQqlRafCAy06+HCLCJ1AcUYOvckBlR/E
	Us0odmlanyUA+K1czOwTAp38wVUW0L3MJFLSG2MaopfiLhCd8R0ZU1M+EsSiO/wn
	wAFdzi947g6GbraFMLgBpghZUjpYlJdMTzw==
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-09;
	repo=github.com/dkim2wg/interop; date=2026-11-03; sw=lmtpprox;
	action=sign d=pobox.com a=rsa-sha256;
DKIM2-Signature: i=1; m=1; t=1793900703; d=pobox.com;
	mf=PGdpdHN0ZXJAcG9ib3guY29tPg==;
	rt=PGdpdEB2Z2VyLmtlcm5lbC5vcmc+;
	s=fm2:rsa-sha256:kOCsybp1scQWRHdErM8k3bqwwVPbaOHsm584WTwd6QdK/6R
	c6nhTeLjP/uI5dkN8+NHBrPHAH0atF7OtHoSZOBo8YAd88+TEFr1xl3GTFP+3j/6
	htflzNxZDSeE8N3Ms1lp2QMAF0ZFb2QecxpYWvAu1/fgswrjUjpDv1udz6t5OIJe
	3w/bANJ/zRB4YJWnmMcspp/DvWnSUHaCzoxUKYyNF3OqVhdCg9Xy0iVbhnKNqZ0x
	saCjg++dD8lEZThcjsE0ODW009LB+vy1TQgMjkI1tDiNqJKkiST7GDPuaU587Lej
	5M8P02GxqoGnp+J74H85ByU4iqJN5JOxaMsVm7w==;
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-09;
	repo=github.com/dkim2wg/interop; date=2026-11-03; sw=lmtpprox;
	action=mi-m=1; hc=12;
	hn=cc,content-type,date,feedback-id,from,in-reply-to,message-id,
	mime-version,references,subject,to,user-agent;
Message-Instance: m=1; h=sha256:36mMfr2mKQdeEFwZuLNOIPvM8hxJCDIav9VQhTHZx+A=:EIe/jEgyufnewMrDK8fStorRcxEo0lduMClghOK7mxU=;
X-ME-Sender: <xms:n8Dsaq62I1fAQHS6Xx5C9ZVQpRu-IfTxv3aOSH8dOfCvyJD_5T5KAQ>
    <xme:n8DsanldLnQ7RTYwACczyxiRF6JwA0NOzjSihDVmQYbhCgPcZB2BLsZheQ8aGN0A1
    fL4AxBXjkdyoq2rgNb0JxgbRt9LepHpmKFP8iMD4Xl97b_00iZZiPI>
X-ME-Received: <xmr:n8DsajTdB4IlSgrHItCVOjPSZn6VlvuX8pZ8n1FC71yz68u_K_QwbnJM-L7j1hLFHc2Y3dl9YuvGKNppFdxoQtlOz19COu3wPZXE>
X-ME-Proxy-Cause: dmFkZTEaWADjM+Qb8XcL1hGku96c0MAArNdpiqmiSM6t2dzU7yfGwoyfX29N0irQyUG0v2
    f7wZ9FuBnHsqlkGdOtBmT/62R3lQ7PS+d9dfLrfYQpqPJR3xMXZz4bz8EMYjTW7R7enSRP
    lSh+xm6wtOeJpZkeDLwtU4MqpYAF5WPGBL/P6W+RUlIR5vjOkzw9OhobDpbybfamvnDA3y
    pvZf3l8NiButSdhYftCK3k65eRmzC+A9hW3Heg+6wKUN5+ml3pJaPEg3ywUsj5XlBmzDwO
    tfF7VgYyVFvQBJ+0fF97+H4POyXoS4XpS8gX0QWjvde3eszlVAwETYv9Wgc4r7URQ1dxQj
    sndt6Wttq+DOVRNHRJe9DAa6BSHZKlGhBSPzPx5sWaoFUbnjCjlj/MCyzNZXyTk2kMEi1T
    V+spyYArK++nUjwLULdzsWM8BodM7qTL69VorHv3kyOnNEF9B7ZGSjHVAiy5O4tteWVOWh
    DHTR5V8ur+vuehElM5mj9XpSUQUeB0AEMIg6MuMP/ZzLbET7/YvA6WR+U1Gp3imGnFfjDX
    OXZJmHvm6E9DzBscLQCrlo9J+uYRgxeGp7kKs18QjKeWyhJmxEUmrsREHhZI9BaM01EscJ
    fpUxG9I9muoA8x/QbW1nWmTcHdkE3Fi6X5KqRc1pL2wCkEzZHcgrKIcsG5lw
X-ME-Proxy: <xmx:n8DsauFW81XGMGoXV-w8B-uH5K16fhNgL7c6mCz_xAcSLR96V1XG7Q>
    <xmx:n8DsagHzi9R0YaN5L1IH-hb6JMqVpfSyO5LxMBJKeX_lCHkPVCSZVA>
    <xmx:n8DsakR8Ba6HCLdXEFol2zXNb2bc8cyCwJPaKFaMUl1LcDbc4H2Wpw>
    <xmx:n8DsapJ3s5qlq4Xe34biEf-GHx_NGna8nsGgCzAZp730M2C_pdlSzA>
    <xmx:n8Dsaj8XuHMMDtbhZ3sAt5pEL3lgTal6HCaMunxiP9u9qFCVicsOAC5o>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 5 Nov 2026 12:45:02 -0500 (EST)
From: Junio C Hamano <gitster@pobox.com>
To: Ravi Mistry <rmistry@google.com>
Cc: "brian m. carlson" <sandals@crustytoothpaste.net>,  git@vger.kernel.org,
  Vaidas Pilkauskas <vaidas.pilkauskas@shopify.com>,  Patrick Steinhardt
 <ps@pks.im>
Subject: Re: [PATCH v2 2/4] http: add exponential backoff without Retry-After
In-Reply-To: <CAF+mdifcp+qkESZzd=8SmrL6eckxAQXR-4nxxSuL=xCV48OhVQ@mail.gmail.com>
	(Ravi Mistry's message of "Wed, 4 Nov 2026 16:10:10 -0800")
References: <pull.2287.git.1793462224.gitgitgadget@gmail.com>
	<pull.2287.v2.git.1793732247.gitgitgadget@gmail.com>
	<fe1e847dede7579da911b5a9ba16c806b5332723.1793732247.git.gitgitgadget@gmail.com>
	<auusPUaYRmUBDsdI@fruit.crustytoothpaste.net>
	<CAF+mdifcp+qkESZzd=8SmrL6eckxAQXR-4nxxSuL=xCV48OhVQ@mail.gmail.com>
Date: Thu, 05 Nov 2026 09:45:00 -0800
Message-ID: <xmqqa4nnw4tf.fsf@gitster.g>
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

Ravi Mistry <rmistry@google.com> writes:

> "brian m. carlson" <sandals@crustytoothpaste.net> writes:
>
>> We should not immediately retry on a 429 response, even if that's the
>> behaviour we have now.  The server told us we were being too aggressive,
>> so the exact thing we should not do is to continue making requests.  As
>> a server operator, I definitely don't want this behaviour; instead, we
>> should pick something sensible if no Retry-After is given, such as 30
>> seconds.
>
> Makes sense. Junio noted on v1 as well that defaulting http.retryAfter
> to 0 does not mesh well with exponential backoff.
>
> What do you think about defaulting http.retryAfter to 1 second, matching
> curl's --retry behavior (1s, 2s, 4s, ...)? Because the delay doubles on
> each attempt (and Patch 3/4 also reuses http.retryAfter for opt-in
> transient 5xx retries), starting at 30s would turn 3 retries into 30s,
> 60s, and 120s. Starting at 1s avoids hammering the server immediately
> while ramping up on repeated failures.
>
> If 1s sounds reasonable, I can send a v3 with that change.

I am not brian and I cannot tell why he suggested "such as 30 seconds",
but matching what somebody else like curl does sounds sensible, if
you ask me.

Thanks.

