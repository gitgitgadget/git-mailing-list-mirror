Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=202.12.124.154
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793981714;
	b=WCUT3eLUpX/e3eJYPFl0CA2u8XZcRITLYgAX/hjR+4jxe78hgxy9p3qSmR9vjjQXZG31
	 u4l/DNDi754XVGyfF3Wh7zsToy2R19ug+DZQiyISHSYRb8vHwMmGdAyilXjRKPKwL5qVZ
	 iKIs+Ahmmox3wY3s+rrfJfxSeInJ06K35Ekf4sbGBAsYQgwX7uno/y29dOKQPpDu3PeSS
	 l4LfMMv7xefjjUr/X9OM0Qg2FXU211hcykpUfL32x2pD0FWHs9KPhRLCaavcpyuASQv2H
	 /KpRBgA47c7ovOO8vOqD9ZmLpn6s9A01OjrJh4qom2iVx1HJOrHPkOdNjnyoJ1wxesA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793981714;
	h=DMARC-Filter:Received:Received:DKIM-Signature:DKIM-Signature:
	 X-DKIM2-Info:DKIM2-Signature:X-DKIM2-Info:Message-Instance:
	 X-ME-Sender:X-ME-Received:X-ME-Proxy-Cause:X-ME-Proxy:Feedback-ID:
	 Received:From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 User-Agent:MIME-Version:Content-Type;
	bh=mcVqh31hLwbQIlArSqp8Bq11YMPolQCBYYYJRAvRpJU=;
	b=OpEKGvvmd9PUx/XbEa+qi+nWXNm8CRry2XrLU41AvCNmmpd+M9+b85V+E+8NWaewU9mG
	 vW0GsTjDLu2i6Y6ZbReKmUxsw6Ml8LHFdR/3zZX+ZmFDJBgHVgS1XNu5EvjEYsJwo1TwJ
	 WDiT/ekzbnirP8s1o9WPuBiZQtgkAsEp/d3IxKp7a5nEZc9TkqD8ljhmk6zvA7NfUi+Cg
	 VQVEHsaoigMudJWIss+RRaleoV9urcavVQ8KFfS8Syxs73GdhYU1FY1K/DPBK6LK7f5uD
	 ZOdYnLppkvAZ5umsKshwabYtBTe3Jsme0+p20mgoHgeefIXS6d/Hj7xYZu5rBO9HBcw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=pobox.com;
	spf=pass smtp.mailfrom=pobox.com;
	dkim=pass header.d=pobox.com header.i=@pobox.com header.a=rsa-sha256 header.s=fm2 header.b=hXw0Mo5U;
	dkim=pass header.d=messagingengine.com header.i=@messagingengine.com header.a=rsa-sha256 header.s=fm3 header.b=ReehUPmP;
	arc=none smtp.remote-ip=202.12.124.154
Received: from fhigh-b3-smtp.messagingengine.com (fhigh-b3-smtp.messagingengine.com [202.12.124.154])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8281B606A32C
	for <git@vger.kernel.org>; Fri,  6 Nov 2026 16:15:13 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 8281B606A32C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=pobox.com header.i=@pobox.com header.a=rsa-sha256 header.s=fm2 header.b=hXw0Mo5U;
	dkim=pass (2048-bit key, unprotected) header.d=messagingengine.com header.i=@messagingengine.com header.a=rsa-sha256 header.s=fm3 header.b=ReehUPmP
Received: from phl-compute-01.internal (phl-compute-01.internal [10.202.2.41])
	by mailfhigh.stl.internal (Postfix) with ESMTP id D30DC7A0106
	for <git@vger.kernel.org>; Fri,  6 Nov 2026 11:15:12 -0500 (EST)
Received: from phl-frontend-01 ([10.202.2.160])
  by phl-compute-01.internal (MEProxy); Fri, 06 Nov 2026 11:15:12 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1793981712; x=1794068112; bh=mcVqh31hLw
	bQIlArSqp8Bq11YMPolQCBYYYJRAvRpJU=; b=hXw0Mo5UhHbf1XdH24z5mHKZTN
	eiAkbU7BiQSiusmJ51zaAugnkOqApuUTjq7hJhizohMOdGGapCCxrqVhN8CbGi3o
	/O8iSRIu5zmWBp1UDmJLx9QmuiHR4Zhg1OIv7kqHJBzKt8mgCtJLPip1vUDk7jtq
	+eqaapWf/vKA9YgMO5e1c5CVZL6Bm4wWLX+OY4D7tzsD7WRY/5G/sQn94CJNJfvv
	jzaSas35PxMvdS+ncEp8GjPEJw8RDYOPQjXAmMlIJNmkh24rSGmVTOBXM/ataIj7
	4Jye+/1Cm7wYeSQRiiQJoM1w//kSKFxZrllx7+IGNPUpXJIpN5POWcwEKv/A==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
	1793981712; x=1794068112; bh=mcVqh31hLwbQIlArSqp8Bq11YMPolQCBYYY
	JRAvRpJU=; b=ReehUPmPbX3+KTSitBkKlh1bgg4dl6s2nHSy0VGCXS/xQkqnAtk
	9hZvzUryudH3CSzJbXLrhfDYUEM70mMnAW6pMLeHb3b0lbPmB/mMNjlnQPopDYNx
	E+IZdSR98uRQiki0ZlNM/aleIWXWWRBm7fyam2Xab+ZppRZQGPFZGuMtp8Rl5kYD
	LZE1APjKJUsi7TYbjzCs1bpdEu5ic5yEVYHtd5R13o/PIo26IT4SkjiTXkUdkJlk
	6RTIcTHjcNh2URjlJw90E24zt+ealViSM2hkjWqKIhB0ePd6b/o/2nUZMSi6gmC6
	NGX9ilgjgsi/Z9dyHnp8diId1BW1Z+qv/cw==
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-09;
	repo=github.com/dkim2wg/interop; date=2026-11-03; sw=lmtpprox;
	action=sign d=pobox.com a=rsa-sha256;
DKIM2-Signature: i=1; m=1; t=1793981712; d=pobox.com;
	mf=PGdpdHN0ZXJAcG9ib3guY29tPg==;
	rt=PGdpdEB2Z2VyLmtlcm5lbC5vcmc+;
	s=fm2:rsa-sha256:YfwIc6ySMsyX6gWa6zUxz12ivLjd7b4pHdOXX4+gDEucMGU
	guoMZO9kPbUk0FPWu8/SydQ1odg/I4v/wbQpc5MgIo5D+K7sUfjiRu6y82+sbGXn
	SbC0mt8vduEkJn4g7dJJwJHYnuHit4hCDMspqlReq4+uNZDpvOMhR4iskd1+ZT4q
	an1Jgk6IYcychbElBd1HaM1a2Z4lIeQUhKQ8ofT8Qv2atkHJGLRP+hTNREbwm8Si
	c0n4BKOoS1zvYv+JdIxaNVqAUjqWiA9SI4TXrFabqzk7Q6b/riZyod/1EisypIDx
	3uLKv6MXawsL/JEU0g4oeEsCKCIfA7Ow9tvMAyQ==;
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-09;
	repo=github.com/dkim2wg/interop; date=2026-11-03; sw=lmtpprox;
	action=mi-m=1; hc=12;
	hn=cc,content-type,date,feedback-id,from,in-reply-to,message-id,
	mime-version,references,subject,to,user-agent;
Message-Instance: m=1; h=sha256:WzwTjo7PjOvzoqSXVzRs0t2DUugFZqRjFkKHuFDyJPo=:0gtMvkOcIqrUZ7pKavpOimaKUtVQo9Ys89IIsoIgDXs=;
X-ME-Sender: <xms:EP3tahDb-e6S5na2bJn-dTTPoHWHurFQSyQzx4EFf47QRVmwpXstAQ>
    <xme:EP3tamhmIXFnNPvGTGY9Mh7AB4CvBcpHQ8Qu1Bjbati2j0dgni2fovnPWNGGSxddQ
    lni_LzhfxZ2GX4f2jWhhYUtQbHbQ_isVGQrieszSjnYmIpgyCGQC0I>
X-ME-Received: <xmr:EP3tahkYBDPy6EdorxFFe0aArWua3bjL849KvHG3NLUexhNq-VKWNhYQRuZbxRYPyQUzHoELoxMoKdNmd4L-P2Bl8J2RguDfgsqa>
X-ME-Proxy-Cause: dmFkZTFEZPhu6pX/dg5qRa85OB3A4RSp6okVDXR7vhZBr80FlY5TXwmx5RGpPeJiZ+VM4K
    L5aZaqtxwqH7pN0Ia+S6Kf27oD0vsKt4Zbzf0DCS4TlOiIwl2zalm2SFPHY8U/ZaGHjxkM
    QNO3kyighOf4BMAyhsz1SKNelfCrhjTvqROdYs0NUeR6SPwMdRzmfcqEIJOgjGJ2ZLO+rm
    Hbwz0kDOfAQo+CNlqAbnB3Cj0kFplBI63Gy4slXSnsyodJtCicCnNKdbrYsTflMj42rSz2
    u7xPOR7s+q6yu+PUUl7I9XKUtpAkoiV2OItA9WReYZ+00YFXEeu2H/uwBpEt9rwEuNx2DK
    wp/xdfmkE65zRFCpFCVeajDGDZlpsoh7wlYT1dkNhzN/QfqRrT7xiMKqNNzEKE4Lt/bb77
    cKXm8HoEPOwKBgpRsgLDvguX8D4ELqv0cTSDCnwfMWbAtwsayUQiNkqjos2YgONtSc8lvG
    qUMoSRfp+8bHvLtpHzhydIV0yd6tGW1OY+SPxeuRlee9xsRDgszoL9/ExYZdtmQcto4Pyn
    pGlRKzQEY8q8UL1FhKseg/TJG04DvEYLqJokFvHnCz1ZXK4BR+OdFWxYC1Ygwd1cNrb3i4
    Aaz1B3P98FLanaZbm0BnHwbcbIFJQg1TWAANvk+fFYRvR3XHzHz9aoNupdZQ
X-ME-Proxy: <xmx:EP3taqrGkCRZ8z_EGJEutTNAgPHmjEHOpDQpXMSJWGWb9yeG_A-Ikw>
    <xmx:EP3taiGIGuIaBvLzULcBUWGMPFJwz5wEW1aUioEql_KebFDRyixXkw>
    <xmx:EP3tauzpm4bX3ph_tJUm2aGqeOE65gNLV5v4A2Gv1Gud51FvceQAnw>
    <xmx:EP3tavq0BzoeTfqx7Sb9ZQ6BsolGp4nOKlkyX7uQ187rJgICy-aawA>
    <xmx:EP3tas3Owjs-tYEf9UeQlLea19IHLKUnpeUFFH9e-NyC5ZvfTx3AERLd>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 6 Nov 2026 11:15:11 -0500 (EST)
From: Junio C Hamano <gitster@pobox.com>
To: "Matt Hunter" <m@lfurio.us>
Cc: "Colin Hinton" <colinlewishinton@gmail.com>,  <git@vger.kernel.org>
Subject: Re: [PATCH v2] remote.c: defer remote.<name>.followRemoteHEAD
 validation
In-Reply-To: <DMO0XC1PL4MP.1J5830XZ4GCS5@lfurio.us> (Matt Hunter's message of
	"Fri, 06 Nov 2026 04:34:46 -0500")
References: <20261018235508.848-1-colinlewishinton@gmail.com>
	<20261023185007.21642-1-colinlewishinton@gmail.com>
	<xmqqecdezfr1.fsf@gitster.g>
	<CAHeTm9NOqLA=BfTU9ABDFt8+jOzaRDPRrMNP8thzAQN2NVZAew@mail.gmail.com>
	<xmqqmrrxdhox.fsf@gitster.g> <DMHZCS9LOW3N.ZJ3947HUCXZ8@lfurio.us>
	<xmqq33tnz0hb.fsf@gitster.g> <DMJFKJCI5DLL.12R7AMFO4DK2Y@lfurio.us>
	<xmqqjymqobc3.fsf@gitster.g> <DMO0XC1PL4MP.1J5830XZ4GCS5@lfurio.us>
Date: Fri, 06 Nov 2026 08:15:10 -0800
Message-ID: <xmqq1p8ylywh.fsf@gitster.g>
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

"Matt Hunter" <m@lfurio.us> writes:

> On Thu Nov 5, 2026 at 11:03 PM EST, Junio C Hamano wrote:
>>
>> Hmph, interesting.  Can you rewrite Colin's patch using this, and
>> then merge the result into 'seen' (after reverting Colin's topic
>> ch/remote-defer-follow-remote-head-validation from 'seen' first) to
>> see how badly it crashes with other topics in flight?
>
> I still have the commit sitting around.  I tried this and a replay of
> the current topic to compare -- the conflict is the same in both
> cases.  eg: Nothing else in flight is touching the
> get_follow_remote_head() function.

Thanks for investigating.  

Your approach of passing more context into get_follow_remote_head()
and have _it_ do the (lazy) conversion from string to value makes it
much easier for callers to make calls from multiple branches to the
function, because the need to "set-up" to make the call disappears.

Very cleanly done.

Colin, what's your preference?  Can we move this topic past the
finish line?

Thanks.
