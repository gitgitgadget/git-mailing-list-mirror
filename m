Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=202.12.124.154
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793380961;
	b=1N2QOh/WHEHokenexcZBc740sThEeiFYzDFs72aW0KAS0vGX7WdmyMHsGecc1EeMHXbf
	 2ALW0K8AAPRvPU9wzsu1A3PhUgBWs05GoLBxl4+0/okrRIZln7tFDA9F9+5kdlrFllkj/
	 6uPAZR6g0k5GWCeIauPKuJfuj25+/9mJon4N5GMvFdjFn2sZ6IcVs/fCXyvDD+WdZPg2b
	 Cw1kjlUXv3FJfB+znA1n695vRs/JqJGcyK175kLkDaVkB9iVE63OZuFmTSIzBH8I7Z+/v
	 6Jh9S035YoTvnCqSfCNuQ5bmcAKUJfkiz3eDn6cJskcWjBYLZddrwCYyoJCrGaWdHWQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793380961;
	h=DMARC-Filter:Received:Received:DKIM-Signature:DKIM-Signature:
	 X-DKIM2-Info:DKIM2-Signature:X-DKIM2-Info:Message-Instance:
	 X-ME-Sender:X-ME-Received:X-ME-Proxy-Cause:X-ME-Proxy:Feedback-ID:
	 Received:From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 User-Agent:MIME-Version:Content-Type;
	bh=YYj/wFiNPmYdBJgsnf4dRPuEQnve4Cg/gjOxo7TEt6k=;
	b=Kh0RqWpEYb95XqyTTLI3tjEmyHYshYMJgATbvOMAOsW3LfA7IFSFGxj61yxAAdXrn0sa
	 XYrsmJK1wx8rspNkTCy7ERfcASHbYuS1RyNI/3KV3KEAz95zpRGJSsd0Xgq0dAfDkv69P
	 +5m9vGMYlAjcP139ePrpXXko09bT5KH7pgLJ3aNjt6VStk6Fk8Dnjw2R3AcZboMqYg9Bn
	 DbFoHLpoP9yf2vO97u7imc+7ZglX6MPsv3fQ8j/oaYhyl7vhwXi8KM1dyL8+liYLuZS0V
	 SUgjwclKeJvL5mQbyj23vddwOGj3sYVxk6xXESQeFG1KwkY5EGNeRpYr/KzMZN3jhAw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=pobox.com;
	spf=pass smtp.mailfrom=pobox.com;
	dkim=pass header.d=pobox.com header.i=@pobox.com header.a=rsa-sha256 header.s=fm1 header.b="DaC/IT7s";
	dkim=pass header.d=messagingengine.com header.i=@messagingengine.com header.a=rsa-sha256 header.s=fm2 header.b=try7Lq3x;
	arc=none smtp.remote-ip=202.12.124.154
Received: from fhigh-b3-smtp.messagingengine.com (fhigh-b3-smtp.messagingengine.com [202.12.124.154])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9F3EE606A31A
	for <git@vger.kernel.org>; Fri, 30 Oct 2026 17:22:40 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 9F3EE606A31A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=pobox.com header.i=@pobox.com header.a=rsa-sha256 header.s=fm1 header.b=DaC/IT7s;
	dkim=pass (2048-bit key, unprotected) header.d=messagingengine.com header.i=@messagingengine.com header.a=rsa-sha256 header.s=fm2 header.b=try7Lq3x
Received: from phl-compute-06.internal (phl-compute-06.internal [10.202.2.46])
	by mailfhigh.stl.internal (Postfix) with ESMTP id 0C9E37A00F7
	for <git@vger.kernel.org>; Fri, 30 Oct 2026 13:22:40 -0400 (EDT)
Received: from phl-frontend-01 ([10.202.2.160])
  by phl-compute-06.internal (MEProxy); Fri, 30 Oct 2026 13:22:40 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1793380959; x=1793467359; bh=YYj/wFiNPm
	YdBJgsnf4dRPuEQnve4Cg/gjOxo7TEt6k=; b=DaC/IT7sljqCzX8xawco2qMFrI
	gNoxV+BOBDJRWlkzPE1gh4No7XO6GeUUBKahKTyn72aMV0fsaiPISwqZHX2NDEOj
	05Pg4XxZxj5qvtYgfe9tPpMzDuupdRUaqAXv/6tYIM5Zz/Pn2RxdzNxV7343yRar
	LZX7okq5tox19c+iDN3bXIxeMkfA+2ihoEyxDWRi9kee90xn2bx/UY6yhHGLRMGx
	onKnov+Hj6lZ/k79V67Jr4s595UoER43731htrCdfcfnF/yg+O2mHAi1TWS1ydRr
	3SGPtq/vxWbMUNhw7GLWL32n3hwgCs5DEmXAUdsVyPSPCMALE1fAcmrNcYRA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=
	1793380959; x=1793467359; bh=YYj/wFiNPmYdBJgsnf4dRPuEQnve4Cg/gjO
	xo7TEt6k=; b=try7Lq3xGbwUVCA2NIrr6DtakqmlH16IXMcKzNBO0vlR9WyAuVM
	bM6v+/7iDTeGt2P/0y6C+BcwKfLOeJkmGUM83Osziav4O4dz+a0mQ5FTUkHXPHmD
	VFocIQsn1Z1LPlCQyV0A1fxA8DceLbwrvalvsqxUmXyFFYI/R6N3/ztZoS1FLi9y
	C/MjL05uUixAewP/rocgmD8dcNkMEvPzI7VomvEcs7ifnndcb+H5TF02Vo418Dsk
	xvIrvcTE9rxbgOlr1CK7iB2nb1B98ZyY9UqCtUlyiMxT3lG4+KQIUSwHApY6uvbf
	1C5q7K8Vxy2LWsGVOgMzjq6tg8qBpj8vrfQ==
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-08;
	repo=github.com/dkim2wg/interop; date=2026-10-28; sw=lmtpprox;
	action=sign d=pobox.com a=rsa-sha256;
DKIM2-Signature: i=1; m=1; t=1793380959; d=pobox.com;
	mf=PGdpdHN0ZXJAcG9ib3guY29tPg==;
	rt=PGdpdEB2Z2VyLmtlcm5lbC5vcmc+;
	s=fm1:rsa-sha256:F5uV4dCuWu6Kdz3c1anlho3M4XAbu8RMYJjcTZvRixrc+Wo
	WPY1m+PaLPU5wZXhjW1kZG1ZIlE8gyMGjYDh3SkjgQuUFCrUttyWkI+vfw09vLJa
	M/scLg52iY62RvKQBARlyVjok0rD5uw5vy4UuyHuilsXgAJXjD2zXRjphiPeBFDc
	NE73UdFzuyCqoK90WGof2iqBwA9HHG6H8Lq95v6rl4dp+8v4gu3c4d+Ric+Hrmmt
	aXBZ6Xe/6+3OElZ4IRvqzy2ycHUs5G8TAi+6ozq2r44tznsgekOQ9At+WPdxjv0o
	FUq/euYlPhMehdGA2vI8HU9ER8bLrNIKAqQ9lYA==;
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-08;
	repo=github.com/dkim2wg/interop; date=2026-10-28; sw=lmtpprox;
	action=mi-m=1; hc=12;
	hn=cc,content-type,date,feedback-id,from,in-reply-to,message-id,
	mime-version,references,subject,to,user-agent;
Message-Instance: m=1; h=sha256:dff9STu2H3SoRpR2dRD3tt2DYszZ362u6n2Yi1/EAm8=:YYj/wFiNPmYdBJgsnf4dRPuEQnve4Cg/gjOxo7TEt6k=;
X-ME-Sender: <xms:X9Lkau3W83Cg1AluNsbQt5ifUVhWYWiELEZS8vPrh9ILUswWJvubww>
    <xme:X9LkaohoOYWyQFXuvIxFsO97hvdK-1a6QfQe5oM1wE92-z94Exr0LM-dJgyeMC3EC
    _3X8SvhsVQ8EfWTqs7WT6FTcFg4KfMAnxkit9DRKhElc1r_34jJgjs>
X-ME-Received: <xmr:X9LkakS6Oc_TXZVnWgHEvvJB_651gDYc9cL1ICunHyU6WUdr3gbMu_Qhp0kNKUOufsg0xYYANRTqkRZkfdP2IL0uri8yo1mBR4Y0>
X-ME-Proxy-Cause: dmFkZTGQm0JuIjnP9EkvuHJQb7x6eEdYCq2LDnBJawW19h4dFlQ0QEF3QHmN1pCEkdI/+R
    6hgk2dkicuYx6xJFgi71MYWiUmfaHh35z5XXQajjRgjRSfAvYOUh5+xN8xPsTWoW4DcqMW
    Ja+lEqSonBknuOmLNcvWPCWRmzH0n5YNar2v0BsdEytq59Ht5JCjM9yoTcI+LXrKd6oLYo
    Fp13nKb8TeYlJ9U5YXN6+fcmPo5MjyCfE7ZqSs5IK7UlN6WbmEqaO97mUQhkHEzNwgK8lS
    oEHCi7F74WPuIdWt5wME/2w7LjaoF4lkkm+hAEbJ4g/9XvJEUSR1wVPiaxQI7MmvTdh/OZ
    IRZ/2nsYoXwW5ce/D1CLmQV8OAqZ2RpGzIeYoA7YeKWbPre0shKXgHt+UR5VBGT/aEgD4X
    q9C3UYmjhzQxNImg0R2LiqQJIEpPCytVUJ47xvdD1iteWWiL2E23pTPNgSZ5oAoORKMvyi
    eR2XDP0VhuZ+jMsGu6di90fWi0/0A7L5Lp/SCAU2W7oHqI1vYziyBoKXSAoiutBHkY+d4j
    lHAWqq+GYqBU7MetJ13kQoaPISersrKPJxrW47V6+v+8JJR2ONDCCO3Fxjx7IC7lmQ76ql
    Eviw4BpEuQ48bfxjNyVg+fOON00lv0MWuLPjCRH49IWLslCzvFJQvwUXAqDw
X-ME-Proxy: <xmx:X9LkapjqZ7BqHgIgEn9gKbstpEqYyqwH-91Q56rJv9b7SMj-Za5lLg>
    <xmx:X9Lkak7uhPcoO3ays6ZRierq7ZQzB9CVoesAwa-RrAJaGALp6s6Fxg>
    <xmx:X9LkamAMLTAx_Ccydz60UIDPvNT3AzlfdmmNfEygjQmkyHtLIPrnSQ>
    <xmx:X9LkaraOnxIM0LHdH1HtZYvYB40Hacy0lnCFPs0qYqzN9iowX7bZww>
    <xmx:X9LkasgMhMhjmiUQfi1OrOuznZLTk7gNnq1yDfxH9eSDvg21OKZU4Emj>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 30 Oct 2026 13:22:39 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: Edson <edsonwasswa54@gmail.com>
Cc: git@vger.kernel.org
Subject: Re: [PATCH v5] builtin/diff-files: convert ad hoc option parsing to
 parse-options API
In-Reply-To: <20261030131338.1513-1-edsonwasswa54@gmail.com> (Edson's message
	of "Fri, 30 Oct 2026 16:13:38 +0300")
References: <20261030131338.1513-1-edsonwasswa54@gmail.com>
Date: Fri, 30 Oct 2026 10:22:38 -0700
Message-ID: <xmqqmrrvw1b5.fsf@gitster.g>
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

Your message has no In-Reply-To (or References) headers, even though
this is [v5] and should clearly have its own history.

This hurts both automation and human readers, as people cannot find
and compare the previous round (v4) from the message of v5.

Please sort it out before sending more patches, as messages with
broken threading will take more resources and time out of your
recipients.

Thanks.
