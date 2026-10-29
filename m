Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=202.12.124.153
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793312468;
	b=Yp4JymNnueiqK1qTXGYO65LMo9mUuUJbOIoyabJYkxlJB8qw9j+XCTbhMEljBHbqfhqt
	 O6PN3DP2OG7dEeeZD9HQ9Z8XeuHVF7D/qh6b9wuPTNtrGkgadoHesqAgnWy6/8wy6XUWm
	 q/lbwGLO5iivazkKywNvCkQbCzmujEKSifNuSMCsl7m4SOKDFdXgjwF4ard+wqfmse6v6
	 NnPswPKp2Dy9ZIgT7Ubw/IAx1w3g/02q08NWIN7C5jArkfVow63Q9jZBmGHD4InCIGwam
	 mCX9dMhtT6sKHqreR1OpGi2bjnOK2o9EbGYjJrOi9FbQGiC09I1WTLKwJ++pRGkaFZA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793312468;
	h=DMARC-Filter:Received:Received:DKIM-Signature:DKIM-Signature:
	 X-DKIM2-Info:DKIM2-Signature:X-DKIM2-Info:Message-Instance:
	 X-ME-Sender:X-ME-Received:X-ME-Proxy-Cause:X-ME-Proxy:Feedback-ID:
	 Received:From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 User-Agent:MIME-Version:Content-Type;
	bh=H2cohHa4Wkvu2woOBmcYEkrCG3z4FEyq040AELzaFIg=;
	b=GwNqaq0a3IUdyC/Lh4V24VjpdncnPLIJfSAcPYhzJ1EHxufGycTRL9GwkGSa6ROdEJz/
	 rUYkDauXVLHJU02tNc9yvG6RxDvoCeN3jd8t1w5KOJ3IYtpDMhmYwenxKEr2y61r6OOrW
	 1VqCEe7V0rIlvWJw7ReE4fQzCbKnA/0eP6nnK1kcQQwfRG9atH2ps7jacsI3ZkZU2wrMv
	 fVhi14OESSIqc2wbqBA5LO1M4ESWrm+UTG2eUYrViQZZ/ZsLRIyeWS940EirTFlBGwIg9
	 cXstajqCb2u6NOgokoussxVylvVWa4GxuBW/chhu4P79K3rwCDLxMFna/z4iRptmWcA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=pobox.com;
	spf=pass smtp.mailfrom=pobox.com;
	dkim=pass header.d=pobox.com header.i=@pobox.com header.a=rsa-sha256 header.s=fm1 header.b="Pi+4/PPH";
	dkim=pass header.d=messagingengine.com header.i=@messagingengine.com header.a=rsa-sha256 header.s=fm2 header.b=sWAYNIgC;
	arc=none smtp.remote-ip=202.12.124.153
Received: from fhigh-b2-smtp.messagingengine.com (fhigh-b2-smtp.messagingengine.com [202.12.124.153])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F07E5606A31A
	for <git@vger.kernel.org>; Thu, 29 Oct 2026 22:21:07 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org F07E5606A31A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=pobox.com header.i=@pobox.com header.a=rsa-sha256 header.s=fm1 header.b=Pi+4/PPH;
	dkim=pass (2048-bit key, unprotected) header.d=messagingengine.com header.i=@messagingengine.com header.a=rsa-sha256 header.s=fm2 header.b=sWAYNIgC
Received: from phl-compute-02.internal (phl-compute-02.internal [10.202.2.42])
	by mailfhigh.stl.internal (Postfix) with ESMTP id 418E07A012B
	for <git@vger.kernel.org>; Thu, 29 Oct 2026 18:21:07 -0400 (EDT)
Received: from phl-frontend-01 ([10.202.2.160])
  by phl-compute-02.internal (MEProxy); Thu, 29 Oct 2026 18:21:07 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1793312466; x=1793398866; bh=H2cohHa4Wk
	vu2woOBmcYEkrCG3z4FEyq040AELzaFIg=; b=Pi+4/PPHPa3nOwf0eIom+BNYlK
	cl+7ANVhapsJg/WsyT7wP2tYzWWIus2t3jeOpxaOLYKYstyy/dJ/Ql9+eFvrgGvV
	I0r3taI225cwujgE8C/5dLs77tuokGBzAOOe88FrUq010TVwCyfnl8EF6zujAjSV
	W3ZZCiBMC357sjOX/NFchM3VoBNC6fvc/GnUiRI0R5vXYJTL/qgBNs7EwHBL/Lpx
	TqrySr2Jlelk+amHJROUjuOnIuvsDYdDs3GJgtAXf+D2tAxZZdiNcy80iS4DQAaL
	dyZFeG+JIFMFWXGjUNtSbrlRGzigusY5WiCxsrYAtrbTttnDE7Q3EY7ZMMog==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=
	1793312466; x=1793398866; bh=H2cohHa4Wkvu2woOBmcYEkrCG3z4FEyq040
	AELzaFIg=; b=sWAYNIgCuF+hUUhmCHMJtQcqBlMDxz3T6mzLhAjgEi96RJr0FdL
	kThNljW0s2Opzg8viaDFsrxkcoms0H4CrBvgHVSR8vLmImC7+ov+ArQp+te4o610
	+t4yInmcsxMfLtrxodbvjNyJGFHP2K0iMDN8IaY07iIWwbRSlh/k0p7elSoMyPww
	tpgsuthAD1niyA/PfwF84hxfXMFjmy6b3Rr8ODZkuPbBUJpfTSCdwf5AC5OIAS2e
	r/P9Mf9TwQN7nJ6OcVQthSK6n5W9yJm40K2O51GonBoAJr9HvNaHbkGU1TnEw9LA
	YnFvv6uxD5RqzC30T7EYE8z/Y09CgerxPNg==
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-08;
	repo=github.com/dkim2wg/interop; date=2026-10-28; sw=lmtpprox;
	action=sign d=pobox.com a=rsa-sha256;
DKIM2-Signature: i=1; m=1; t=1793312466; d=pobox.com;
	mf=PGdpdHN0ZXJAcG9ib3guY29tPg==;
	rt=PGdpdEB2Z2VyLmtlcm5lbC5vcmc+;
	s=fm1:rsa-sha256:lRZHB45MAVBJ3oRusiY1oeDPOu3r2L5zeLF/LoFgc1PTNa3
	ynYEQA7SGBIIfPBFKvIC5IIXIps8er3isJ4LRglpkFm8Vj5Ro3T1G2MQa3uy8o09
	HWHngO5ljBGyuqWuBp5edb59aOgheov+xSDxuSxFP+G64NvDAURKOSMHCpgBcvd3
	SK8WB55MGtcBYILKrYtlqTrTL3vIBm2WWWN7fkd0Rb+c1bUDQsBNXisu+I6Pcmja
	otGvJpPv1hb+KNEP7dIXN6U+azyv1rN/V+nj5Yd8zDSrSPpmL7izI5dLQgTm4Cy5
	oZWJZ61fesQ0YwbefUbbG54oNr80BpAi8iCdLYg==;
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-08;
	repo=github.com/dkim2wg/interop; date=2026-10-28; sw=lmtpprox;
	action=mi-m=1; hc=12;
	hn=cc,content-type,date,feedback-id,from,in-reply-to,message-id,
	mime-version,references,subject,to,user-agent;
Message-Instance: m=1; h=sha256:KRgZ+EiR7ulRhRmT1bpRfQJ/g/M3sfqIeBUTtX6KTM4=:H2cohHa4Wkvu2woOBmcYEkrCG3z4FEyq040AELzaFIg=;
X-ME-Sender: <xms:0cbjannkHpuMXsck3pi3IR10sWtkzVlrUBWOa2brsx387oX9Z4AGFA>
    <xme:0cbjakJt5T5I4hBeNHj82BQepRM7KJ1igB1HbtzwNVugXC4zc9R9TS3T8z-jyIl5C
    qUu41yeZOBV1Ge1X2brQ7N7dQxNywjMTi-J6EJ4OTXVsTrS5euqRg>
X-ME-Received: <xmr:0cbjak6gJkM0e2XUcqFcml2gGe6kaHagHB1cZ-sd0eDQOKVtHGego9f2jPIp7y5GP_8zx2af7mYqRqGqB7amSIi-yo9Tbwozapoq>
X-ME-Proxy-Cause: dmFkZTFC0W3mGVPqmNbFMJgjQzWqXRX2tziPk2A0Oa7snunec9k9qLX2UhtV4Rx1bO4gf9
    bSrOPrMhvesdSlsAJBSVwvfy1uZPr+NHsTwzkU+gEOIm4B2yyJMzCnKzfqD47Ha+zpFdnF
    bF1c36Fn8s61iTi+X6Y9QOXMUjxCUdAWBHOQ4xb9P1xDP2sT1pWZFFK6YS4coN53vPmaey
    z1KtnPbMXp5lMozawoLIQNbSpdeaA9VHaHy/VODWL56CmGVgYMoRf9/2P9t4I0h9ibb9Tm
    Q3L9Ow5zEMFArdJg83i+2V+9zzB2wjvvwRHFinFkrzakNVNBveUpUVGevFkg57GyUDILr5
    DjDZVqPGkK886OOGbFY2jl7FwBV1Y0i3cf06L3d7WrGvSFObyvJhOfU3PxIRSvXfJP4WzY
    43xg1wWGCEKY3YkOQxOQ6YSO9EeE9dQEoMOUl+R4R0Kx5WLYx7GcxMTBXYzyaXe3LMZfub
    UuQHOFuu7CiCPiPA5rqoo7yFn01wRp61wC1lKLvKlSqmkwsf52ARKrBwouGXI5n5lgwPZT
    OM9FbbJ0S22988JWMzvbiQia/45UHj1jA2MT3wIYowjS2RP3kqsEd/NXUJthjmhWU6j4FC
    f1PG7fiJHVqIN8t1mzpnqRRsHlW09CzLjQMlOoDZeuLfMhZYI1hKhxfg4Kcw
X-ME-Proxy: <xmx:0cbjag10kEZ2W16myWH4ocdz97vJHVG-5UQLXHwO8qaVmFmsDwugEg>
    <xmx:0cbjaieOySNFij1-kCuRGAi-8LP1vvUa8JnetoAyhSB6xqzE_Vs16Q>
    <xmx:0cbjaueUSi826UMiMI0IycNUP-IlVOHZjlOGvTkBeO9g0kk3nChdJQ>
    <xmx:0cbjalzMwKY_SaZUck_O2w9FJ8tMh6Xo4UTR3NeewI7WyLEuDlz7jA>
    <xmx:0sbjajEjod91GInZJTkiqWxyi9VFumnPOh9fXXDIoFyuE40C4mNh17kx>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 29 Oct 2026 18:21:05 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: Ben Knoble <ben.knoble@gmail.com>
Cc: phillip.wood@dunelm.org.uk,  Harald Nordgren via GitGitGadget
 <gitgitgadget@gmail.com>,  git@vger.kernel.org,  Harald Nordgren
 <haraldnordgren@gmail.com>
Subject: Re: [PATCH v10 1/5] fetch: add remote.<name>.refmap
In-Reply-To: <E50044F1-41F6-4FD8-9A22-A43FF36932F2@gmail.com> (Ben Knoble's
	message of "Thu, 29 Oct 2026 10:30:10 -0400")
References: <e6af5d1e-4ca1-48a5-8a84-5e0cefbdbc2b@gmail.com>
	<E50044F1-41F6-4FD8-9A22-A43FF36932F2@gmail.com>
Date: Thu, 29 Oct 2026 15:21:03 -0700
Message-ID: <xmqqmrrwywq8.fsf@gitster.g>
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

Ben Knoble <ben.knoble@gmail.com> writes:

> Yes, I would love to add pushRefmap atop later! It would
> ease my working with notes, I think.

> Yes, I would love to add pushRefmap atop later! It would
> ease my working with notes, I think.

Tell us more when you are off mobile ;-).

I do not think I planned to add '--refmap' support on the push side,
even from the command line, but I can imagine there would be
reasonable workflows that benefit from having one.
