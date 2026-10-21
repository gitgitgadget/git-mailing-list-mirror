Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=202.12.124.154
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792601446;
	b=ZxjUAHARjKTZ6Sg4LdadWSKcQPRGftjhH3kMC37aotyypJUgkrpx+cgUZv59TMUbiYWO
	 cXmlRh4wXe1X3b1EtgnTnFAF7Nz3JFibHZY4jXxy/7paBPbNHdqun46dYZhBQdEjKuXDC
	 oD/bVf06zo6FX/uwh61YJk2jP2VOFy/hlzvLeN02GeJVWmiq3tqWXkAPPjoSE3qB4Wm0d
	 2vV4u7lZbPcXx/6uSZnPpL2txwkSYaR0mLLytnWBIJ1Ta5U1JYDm0M32jrpOCDUVIaC24
	 MnpPiufWLzvqpmiBdTaB/OusL/W3a66CF8sZ5WlK7Y9Jy88QieWmizp22NzvFcW7+HA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792601446;
	h=DMARC-Filter:Received:Received:DKIM-Signature:DKIM-Signature:
	 X-DKIM2-Info:DKIM2-Signature:X-DKIM2-Info:Message-Instance:
	 X-ME-Sender:X-ME-Received:X-ME-Proxy-Cause:X-ME-Proxy:Feedback-ID:
	 Received:From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 User-Agent:MIME-Version:Content-Type;
	bh=VqsGKQfoUwAWuXZBanDXinXsw3kNf10P8pOnRILxsK0=;
	b=qk5YfaROr5XA0FIT7TKN+e9y3I00orYKhvC1Rmg6bHVXsspv3YGsgtzA4ZqZJ25OFFOk
	 XwKu8s0syS5AChX6sX6YH7m5sgpTzxEYLu16qjR2JpXnGJ9oEKA4WBol296XgJW9wHgz0
	 MVBbA8yI87U4AdEP2MGXM/lZse48mBcOZ6WnmBFTRy2h7v1e82huxTM0pKJ43cMFUksFS
	 e8L9vpjWEdDQToTqfH/0nbpHDHhZsZ1EyYkoJbWxwrMMSmzrBaRrvvdlEKfExJTEkl2Kb
	 cOvqtq/1jHWQTKTHNr+WC4Si+OdNkyiEqa7f15snmJ56esIaA430YJL6sT14FfZmiQg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=pobox.com;
	spf=pass smtp.mailfrom=pobox.com;
	dkim=pass header.d=pobox.com header.i=@pobox.com header.a=rsa-sha256 header.s=fm1 header.b=HQRDZRxv;
	dkim=pass header.d=messagingengine.com header.i=@messagingengine.com header.a=rsa-sha256 header.s=fm2 header.b=em7RE1W5;
	arc=none smtp.remote-ip=202.12.124.154
Received: from fhigh-b3-smtp.messagingengine.com (fhigh-b3-smtp.messagingengine.com [202.12.124.154])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EEEBC606A319
	for <git@vger.kernel.org>; Wed, 21 Oct 2026 16:50:45 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org EEEBC606A319
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=pobox.com header.i=@pobox.com header.a=rsa-sha256 header.s=fm1 header.b=HQRDZRxv;
	dkim=pass (2048-bit key, unprotected) header.d=messagingengine.com header.i=@messagingengine.com header.a=rsa-sha256 header.s=fm2 header.b=em7RE1W5
Received: from phl-compute-05.internal (phl-compute-05.internal [10.202.2.45])
	by mailfhigh.stl.internal (Postfix) with ESMTP id 372757A00DF
	for <git@vger.kernel.org>; Wed, 21 Oct 2026 12:50:45 -0400 (EDT)
Received: from phl-frontend-01 ([10.202.2.160])
  by phl-compute-05.internal (MEProxy); Wed, 21 Oct 2026 12:50:45 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1792601444; x=1792687844; bh=VqsGKQfoUw
	AWuXZBanDXinXsw3kNf10P8pOnRILxsK0=; b=HQRDZRxvDjvXX00JIOpqaezRJT
	/cxYaaKa81hxfYYTnKxhLs3462KkuaqIG89A4lELzo0IUeKdLubITfx28Xp55Hbd
	P+aAwmI/V8qC8kopqY/SIACfV3EfRv55cXGgUqjrxKtEWGqM0oMBMjtlO1FcCCvk
	++MjD7+M6kxVYWxDOtDQHfLFFEijbeSJcRcMqJUOZ0EnEgCccZnycarRM3r8jr4z
	HBI8RxAZfZM3HlmSXTsDeb9chZAfRR2LzSdLDRoBkIRbQkiKAFVtdYXBAeTH04kp
	f9agiM4zL0DfCrKsLNlypD47TO+FM2n9ZANx/GzCnjVybD1qb6yMxTByqwlw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=
	1792601444; x=1792687844; bh=VqsGKQfoUwAWuXZBanDXinXsw3kNf10P8pO
	nRILxsK0=; b=em7RE1W50Kl58k1i1+/Syw1K3Lhl02SBfuYRLZHo4BIYLInW9gp
	lDLAscnmYHLgu5WJgGVKK/CjXsXzcHcv/6T/5wdPxInO9tu1Y1tV1BJh6v0hea2d
	PQMGwCoh4C4mxlCyQ8ch0J71kGsPhYLIFvBpgWYLhTf5uHr5I3zhJT4prwjoRhPg
	zwzUJSJCvG+nKWqVUPjyuOsPY1X0iUqwrfMkK/tVMx0J+pZVl5pc1x8kiIecIQuK
	D1xEG7TUZUz/JBx4QiqUPZAzYuAR6bCWs48DwN9pyJfZozTdTeJgS7EeCRI5FbWt
	sbie5CpPygBekHq2zLeSqqfs+LoZyacBm7g==
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-07;
	repo=github.com/dkim2wg/interop; date=2026-10-18; sw=lmtpprox;
	action=sign d=pobox.com a=rsa-sha256;
DKIM2-Signature: i=1; m=1; t=1792601444; d=pobox.com;
	mf=PGdpdHN0ZXJAcG9ib3guY29tPg==;
	rt=PGdpdEB2Z2VyLmtlcm5lbC5vcmc+;
	s=fm1:rsa-sha256:PKATtk30gehph+Rh6JoOyrWQSRR2itvc3Yte5biiKa3mPtM
	81X3QluQ97nRJeDsBnLhyxHOPcZUfDC0ysDBdqb+/WzDvUb7U3F59zP/fr8Tl+RH
	nXMNay1bFM/p6TN8UmbCZl4IX3wddc/T3Qglh3R0yfsyk924BmsHNQNKw+gln6s7
	dN7nP6ImVnXuQD0Odl5D0V4tcVT4kLo1ODnY3vIzAszx8utV2nGcKgSIl1f467sA
	8zlhwy3aHYtBuYT+p8XAcus7DK2UjHW1n+q+j7JU8d69h+SeB6Lg1fZSKGu0l4IO
	ZS4PoxO5lDLUULKYWUmY3YMtASnfBPFAee6pC1g==;
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-07;
	repo=github.com/dkim2wg/interop; date=2026-10-18; sw=lmtpprox;
	action=mi-m=1; hc=12;
	hn=cc,content-type,date,feedback-id,from,in-reply-to,message-id,
	mime-version,references,subject,to,user-agent;
Message-Instance: m=1; h=sha256:yPTSRG/4usQUBVh8q5eJupmUKITrnQHkYZ4p65AUGeo=:p+YZ6CC2jDmin04bBD54Lpr/iy6hKr2JFm8fz3enmhE=;
X-ME-Sender: <xms:ZO3YatEWFf0GRQzDQ2GniGkrxHTr6FnQqqjQj2uFCYfq23mWTUz07Q>
    <xme:ZO3YapNjUxYjahaqdGQaHLREzVlyiidY2_IxzZ2CD_h70NbBlUmUpuob9oIiT38J_
    79tZsQsYCLogaDZ7oJyQ8x5dULq9QpbVHUtmGLn1h4abdKIjpkSBw>
X-ME-Received: <xmr:ZO3YancKjlVIEEd6G50zlgugmvONjxP40-2oBLh9E6VyDHIN19itzH8iQi_qVnIxAeel6T1GAGcdA1pjup0B4yI-gzX-XuODJsZh>
X-ME-Proxy-Cause: dmFkZTE7t/4Zsget9VKVoqQo6RUw4wlZbtWfaxNJrk3fsGwIcDP0WXKl/igPtx91uNPxxh
    WbQG8GeCdExcItcnaObEj1AYuTooqWTtJN+q/2RvIGwYHUD9aBtZnHxj5MrVdLimbTiDVP
    oGdPDjas1npO4cvSvyIWXXJzFrWTA5kp6s5OifWw0OLAVW9B8t2HZvZ72dF65Yu3KUlUCA
    +h3Vj62CIjFE/m4Ru5yz+6sHyGVLaXBtDbypVBoeWO14EhYFr2LV88mvresiGWfDgiHM+i
    yaKBRaaxuz6Qnb4f0sgj0UK3uoNkA2ZmegSgAgdUulg7n1Im2wLRi9WuyYjReXKWMeD7SU
    RWwJp94RMOYVsBOEzIX2sxORcTczdkaFgHI7bdLxxJJZMWlp0vW6QocxRgCVeGnEVjPP7u
    2yy9snikBSb1kZDnpacIR23skeu3z2cPhJogohr6c7bm6fu4byTQUU+w8hfA0RBGMflW4y
    fBnkdKJPssNE+KIoozGOTiENEAPHLewYsFSLcD4auJcCMhiTTztgLZn2jnK/kthaNbjPD8
    Sw+Lq18g8dZnOys2DM5GH0f1kYsnm8UbHE48mHvVRdU+Zj1rXvl0BCG9VfTyWaCvIcf6bU
    DfWOsBP0oUDXa5uzsemSmw8hVP9M8GsOoKC1sAgXTI+gssRF8HmM3xG1Yezw
X-ME-Proxy: <xmx:ZO3YauuINmiton9Ug9opNcqgspgW_OTsacYFcgVsbITJpn7GreisRQ>
    <xmx:ZO3Yagkr9ZV5gOg56pmolRX-mVQv364MDd531fkqn7SA343zZsTuxQ>
    <xmx:ZO3YaozCVZzWWCDF2NGSDoTlilqqQj_B_bUG1eG0LGPLzqpMeS4yMQ>
    <xmx:ZO3YaqPllrQTDasHw3PDMKgyakg16k3_ZOm8Og_C-JKDja8Uj_JwFQ>
    <xmx:ZO3Yat8etgPs7SQ0VCEfBBCI8LSP6e-dzlSGPZ3viTvom4pr6JT-NpEC>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 21 Oct 2026 12:50:44 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: "D. Ben Knoble" <ben.knoble@gmail.com>
Cc: Kristoffer Haugsbakk <kristofferhaugsbakk@fastmail.com>,
  git@vger.kernel.org,  Patrick Steinhardt <ps@pks.im>
Subject: Re: [PATCH v2 0/5] doc: move BreakingChanges to a manpage
In-Reply-To: <CALnO6CBuKKF=nCObFCK0coCDqbK=OJTWEshEtj6NaVV6XpWGuw@mail.gmail.com>
	(D. Ben Knoble's message of "Tue, 20 Oct 2026 09:48:20 -0400")
References: <CV_gitbrchanges7_please.d1c@m5gid.xyz>
	<V2_CV_gitbrchanges7_please.dc4@m5gid.xyz>
	<612b6065-9043-425c-83a7-2cfdbe140c4a@app.fastmail.com>
	<CALnO6CBuKKF=nCObFCK0coCDqbK=OJTWEshEtj6NaVV6XpWGuw@mail.gmail.com>
Date: Wed, 21 Oct 2026 09:50:43 -0700
Message-ID: <xmqq5wyvq9p8.fsf@gitster.g>
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

"D. Ben Knoble" <ben.knoble@gmail.com> writes:

>> Is there any interest in continuing this series?
>
> For myself, I favor making more of Git's documentation accessible to folks.

I do not know about "manual pages", but making this available from
"git help" would be good.  It raises a huge question about what to
do when Git 3.0 comes, though.  Are we going to change every section
and rewrite them to say "we used to do this differently before 3.0"?
