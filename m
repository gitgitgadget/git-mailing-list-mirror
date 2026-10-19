Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=103.168.172.144
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792432807;
	b=3fugH7qEuY2eGRR8xeQ3x1JuV+6llpb3C3Fzsc7xY5iPWyzxzPBnYydf10+OnB5eoXbr
	 UVVhLsBvCLxcxm0NjwsG/trl9wIoIZ/PilgQoQ1xx9ZOzP55PunArZBPT0RsKHwA5g6MV
	 uG1DEh8ORekwN6rZt+d+WvfdC/7wrLxY0iVrXx7rLVR6L0Gip871wcwxE3dlo9/lR60i5
	 6T2d7BI1f9WKpIqeEav2CySyNB5T2os8umvh50tH+0HMnYJ57e+etPp6k51gitCTSqdMw
	 S3llvorlkKzNa86ne6mFOHUIfuP2p3/GSgkN2oL4R/GDj4hT9mWDGrZeyfHvY5XBZVw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792432807;
	h=DMARC-Filter:Received:Received:DKIM-Signature:DKIM-Signature:
	 X-DKIM2-Info:DKIM2-Signature:X-DKIM2-Info:Message-Instance:
	 X-ME-Sender:X-ME-Received:X-ME-Proxy-Cause:X-ME-Proxy:Feedback-ID:
	 Received:From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 User-Agent:MIME-Version:Content-Type;
	bh=m6vWc/yrg6wPXw34yuea9kT1JOPsP0NQEiCiY0Jya2Q=;
	b=t1SFp/K9yr3e58Ne7r43c8mI9bmgXqvyWGGtbqY+TWJuQbYw0NB/6epPa1PhtfmJKupZ
	 0hZpRNHexEnP6B51o7K1UTp8z/pO3Cd9lqV3tDPn6Sh6Le2vxXIkxoHYRK6/WmRr2KoMB
	 dbdvrk2aeJzJ04tJkJ7OVwz6X/8ILAuzQq06et1yEZYrjyOvj3Ay+u3qtMN/hGNYGPQV+
	 YibjJshRDfTd8IIr1mWq2aLIt52JNB6ibcgceuxStnwthMtr3CeNQe3yvz12jpEpIWaLT
	 3X7fADjKOwLa3c2HmFvQuXASoFNycSZ3ZFnDnd4qArDxjvkgDv32BxMFrfguVoAAeEw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=pobox.com;
	spf=pass smtp.mailfrom=pobox.com;
	dkim=pass header.d=pobox.com header.i=@pobox.com header.a=rsa-sha256 header.s=fm1 header.b=mG0cnooh;
	dkim=pass header.d=messagingengine.com header.i=@messagingengine.com header.a=rsa-sha256 header.s=fm2 header.b=TZpedB45;
	arc=none smtp.remote-ip=103.168.172.144
Received: from fout-a1-smtp.messagingengine.com (fout-a1-smtp.messagingengine.com [103.168.172.144])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 769E8606A319
	for <git@vger.kernel.org>; Mon, 19 Oct 2026 18:00:06 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 769E8606A319
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=pobox.com header.i=@pobox.com header.a=rsa-sha256 header.s=fm1 header.b=mG0cnooh;
	dkim=pass (2048-bit key, unprotected) header.d=messagingengine.com header.i=@messagingengine.com header.a=rsa-sha256 header.s=fm2 header.b=TZpedB45
Received: from phl-compute-07.internal (phl-compute-07.internal [10.202.2.47])
	by mailfout.phl.internal (Postfix) with ESMTP id 9C9CBEC019E
	for <git@vger.kernel.org>; Mon, 19 Oct 2026 14:00:05 -0400 (EDT)
Received: from phl-frontend-02 ([10.202.2.161])
  by phl-compute-07.internal (MEProxy); Mon, 19 Oct 2026 14:00:05 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1792432805; x=1792519205; bh=m6vWc/yrg6
	wPXw34yuea9kT1JOPsP0NQEiCiY0Jya2Q=; b=mG0cnoohvTVkhQGpQsumSac3ew
	Cb5Zgp6PNyMJXRlu6DaL0hFg3VuO28WurYK42eiQ5KCDCHruzWsSBL7bOJFWxNIF
	mfP+0viGwU0A16/FpZfFU5AdbbwnwoE5ClKmYMNiCADZouYKYS25gsNEN0hWK6W6
	C26zFBSCE5/317EySc7HaZ2RPIeqLWj6+V0kNiIMx/ICLFkjtG/xhmDwWxRnF7kM
	OrqzVt+NIL7L6u3w+CRIWX3vluGSpMrWu6hLKhgyN9f7gET+9EmnxUrKOeNwTeJS
	uf7upb5Oeg7nQJUUtDIYNvABpXYnp16dL4PVXnciJ/6x9qsImN9ZTstP1kPA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=
	1792432805; x=1792519205; bh=m6vWc/yrg6wPXw34yuea9kT1JOPsP0NQEiC
	iY0Jya2Q=; b=TZpedB45ytydUToC5aIqpIg0LKGHyydSB/NZEpi2+tEyUUlPqSu
	5T0h4w4HcVP3FBwRFM4H6X1f6lLZQhc6BfWNEdkSW9dj/vfVqAj1CW0BViT9fjDn
	XbGrsU2z+gIFzBwPxgviSgc8H+DqanpgxqyK3i3JMUpILWFS0aL3vKNRuigUJNMI
	HzLCgNoXZM2ychGsQy8Ta/34zo/5pMso9wHPZaAEB2/VqpCzCd8mZm1lkFtqnC0C
	Uy/mU9NiApgPA/5kQ78wNu+b5WC1no97vzMByc9soZTDJIkmPH+mZpBzaRY5QpWw
	47YFxf3w3ULT65vroGi+5KuvIGbQH35pBlQ==
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-06;
	repo=github.com/dkim2wg/interop; date=2026-10-08; sw=lmtpprox;
	action=sign d=pobox.com a=rsa-sha256;
DKIM2-Signature: i=1; m=1; t=1792432805; d=pobox.com;
	mf=PGdpdHN0ZXJAcG9ib3guY29tPg==;
	rt=PGdpdEB2Z2VyLmtlcm5lbC5vcmc+;
	s=fm1:rsa-sha256:Fnb2jzrcGB2Y/CRMqBuwsZoHj1NOQ/A2pjh0wsZBEOl0niV
	WWVRaDBNyIgi8TmCj7e5l0VjtYN2+B6R5yQNMemxL+RKRbbF1UUUFxpiVkE3h4k6
	gt3yLht1mCCj7M9Ie6r0gK6SEEFZ6syBRfFnSywxTzKXRT5KBY27fRiq7e1L74A6
	KFYu/4Lv2ZUxJVVo94eZTwqL8GOEI34Ka19bqobhror4hZADO0eHe2Vfn8BjtRLU
	A+VToHqCV1WBd2GJetoGdG7l4AxEKUKoxZPDwB0fgBnci0QT7ejW7SeYkci1+VxK
	iPQIFDn8fIf0SmK5+FcW43Nx1hleq2gbwZDwVkg==;
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-06;
	repo=github.com/dkim2wg/interop; date=2026-10-08; sw=lmtpprox;
	action=mi-m=1; hc=12;
	hn=cc,content-type,date,feedback-id,from,in-reply-to,message-id,
	mime-version,references,subject,to,user-agent;
Message-Instance: m=1; h=sha256:700oEqLuovXy/nXqV0rA7Te8Ry+/D0cNqFna9icrHeA=:TEF25dF9ATlqPSEgvm1VFEJNs87EPmDt8wrPqH6+EGo=;
X-ME-Sender: <xms:pVrWakBTrlkiaiVXT7QiRl2NWln70IKvUnjkp1v3D8AnolswmmuGsw>
    <xme:pVrWat_p1r4Mpkl9wcsKmhYPr2QJMl-8f4vvCrd5-kokg9xNBMcumpHAhAxruqGXQ
    tMrwcJT1JMwggitXZLOE0j6QPfFznuKstJmwdOt0fcWxJ4RRCW4y0w>
X-ME-Received: <xmr:pVrWak_2sYd7eIXN1yUlg8WhCmLrHoY7YYqlqAB0di75Ub3biUmOsMe90M2SO8ipxUR79wIGiD2j1SitApOhBuIS4BKYgMMSE4CD>
X-ME-Proxy-Cause: dmFkZTFt0oqUaWkO1vMYZQjKvtl6qrSH8zN1N3G15YUJiJGl8uGWrxlQbDLH8rQHuehLPD
    C+MFiGaRCoPTISWkFtej0ylxixlZrg7ha21WebYqOz6gZJ55/Rbvif1JBvHtgwtgtcJurr
    DsMw7EOwyn2rUcD9fUj9zZ6zLLEKFf61ifoQ2f/VD27/V7wTge6qiECPuMEg2BW7VzecXk
    yegHoyddh6On8yncOVs4e1zK4VoNV73OOh4JlBCDrxzjZH31OpZYZMEZ8V4QCo2T/EUKB+
    hs3kNzVbi8+cCPhNcapbAgmR8vrhbQfX4bF5rIIHqiOZyRgWUkoV3rnuoKQzVPXySpJtD9
    Oa99zzkmqgJdsuNXF6lsgut1wfY/hBrItB4OOkqCqNS9piJeufQvNyKOTU2u6ls47zsCx8
    oS56v7tEVd1AbZG+690p0CwqJ/MRNl5HOQcqIcARspU9kHpkv1eCFU0/L95pjwABDwC/Wh
    uV2vBybFWUGhD0Up0WuRwhsWZ6eNn5jDDYKE8UixISG1A7TkpDPJ25mJKagR+PMgrKgkOV
    Vk1s7h/v7mnim5hwkyAxIusg/LZVobQ8/ATsU6tYNZIXwb6PhQR1dRl3QKWiJC0fC8apzc
    OxLH54XyN3qwZ56PhDgro8Yk9X7AEtcPt/q+e2Zc5eKq/9Uiy3Nm1yY99MLg
X-ME-Proxy: <xmx:pVrWakddryVrGjWeqfqv4u_BvZ2Wi-MKwUAt7fNjiW7RDXuyiCmo-A>
    <xmx:pVrWatH8TZOiwaGTkbnUVXLYC4_Ejcs9nzmH6stLic6z2PiDvNN40Q>
    <xmx:pVrWaifslSLVay0bwOwFVBtQAX7XpkYA6KlmnFEcKxlolTq7pEWeBQ>
    <xmx:pVrWanGgx196F3ea8-I0h2DBJXxHb2GRONQSIpLjSbdbijSYkGUC0w>
    <xmx:pVrWasgU86PQJ0SYo8yQ7IsDLHea-oa5hwOegMIPRzXD_pKkfx9RHFYc>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 19 Oct 2026 14:00:04 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: Patrick Steinhardt <ps@pks.im>
Cc: git@vger.kernel.org
Subject: Re: [PATCH] github-ci: update macos jobs to macos-15
In-Reply-To: <atXC91tL7MHRioPZ@pks.im> (Patrick Steinhardt's message of "Mon,
	19 Oct 2026 09:12:55 +0200")
References: <xmqqfqy5clgz.fsf@gitster.g> <atXC91tL7MHRioPZ@pks.im>
Date: Mon, 19 Oct 2026 11:00:02 -0700
Message-ID: <xmqqy0bt4llp.fsf@gitster.g>
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

>>            - jobname: osx-meson
>>              cc: clang
>> -            pool: macos-14
>> +            pool: macos-15
>
> Do we maybe want to update those jobs to use a mixture of macos-15 and
> macos-26? In GitLab CI we use macos-15 for osx-clang and macos-26 for
> everything else. Like that we have higher test coverage compared to only
> exercising one major release.

I do not care too deeply, but variety is better than monoculture.
Let me roll a die and send v2 ;-)

Thanks.
