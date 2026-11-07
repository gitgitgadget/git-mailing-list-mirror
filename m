Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=103.168.172.157
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794026283;
	b=Cs9nj2HHbO68N6oXTjTBizdGpqqDiinvZ+0hQ3o9UCxIsPe3I+acH/jyTv/mfaKTjuTt
	 UMNBzJMegQj09sd9Xd8K9aAxR1ay7rsON2zk3ABzwlUupDqAEoHN/yKvGgyMlGlByn97B
	 m8osFSKAE7QDmyfLcBCjBjKf18hOf88/Dkwy0cCQL70l3XOGROcQE10bIrjnnWImeRlrJ
	 7XKTGW0wmfvMQBOgZexPnj6y9dpk9h/FzhStHF14/UItpQAxE5zlWQn7LEDJWD5ydrUWD
	 Zd9TLLMSkSoybObb2bzxm0gqcMYBfVzMXrH1QDi1rwplEpcx9aRUV0nxCQt8k1CwQaA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794026283;
	h=DMARC-Filter:Received:Received:DKIM-Signature:DKIM-Signature:
	 X-DKIM2-Info:DKIM2-Signature:X-DKIM2-Info:Message-Instance:
	 X-ME-Sender:X-ME-Received:X-ME-Proxy-Cause:X-ME-Proxy:Feedback-ID:
	 Received:From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 User-Agent:MIME-Version:Content-Type;
	bh=u8K/ULughR9Q9ag1jaUnUVmdGGZGizOwypZf6pHcEr0=;
	b=OWxhTvG+4tl2lj+h9lkjzVJbrTctjGGsPAgVO/fvLKNhdoVG4AygxOX1OG2Hw35n3JZ6
	 /nVVUekaYpVolya/tHbO2lvXQfwXjL0o9ijtbSaAtvUWnBNa/eVEiR6T2NpUSeBrEzqL6
	 Dx29+9e76BXavo0TfYffJbWwdo3IX16DEDlZMDr1ofQL7J31l4CHmAdavswgBJxtFR68f
	 2xNvxn/NOud3PKvA1cH37+o0eS3+I06l4N8NnVOgrf/woDpTmtJASSEpeFbNdchFqMaXK
	 NYri04JrZ1gOlVc127ZmK76qBHrevxtwuXb1JgfA5NczF/045fXB46IiKd71h/QfRPg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=pobox.com;
	spf=pass smtp.mailfrom=pobox.com;
	dkim=pass header.d=pobox.com header.i=@pobox.com header.a=rsa-sha256 header.s=fm2 header.b=m0aWTgst;
	dkim=pass header.d=messagingengine.com header.i=@messagingengine.com header.a=rsa-sha256 header.s=fm3 header.b=bCHn9fkx;
	arc=none smtp.remote-ip=103.168.172.157
Received: from fhigh-a6-smtp.messagingengine.com (fhigh-a6-smtp.messagingengine.com [103.168.172.157])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5C688606A32C
	for <git@vger.kernel.org>; Sat,  7 Nov 2026 04:38:02 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 5C688606A32C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=pobox.com header.i=@pobox.com header.a=rsa-sha256 header.s=fm2 header.b=m0aWTgst;
	dkim=pass (2048-bit key, unprotected) header.d=messagingengine.com header.i=@messagingengine.com header.a=rsa-sha256 header.s=fm3 header.b=bCHn9fkx
Received: from phl-compute-03.internal (phl-compute-03.internal [10.202.2.43])
	by mailfhigh.phl.internal (Postfix) with ESMTP id 91B231400068
	for <git@vger.kernel.org>; Fri,  6 Nov 2026 23:38:01 -0500 (EST)
Received: from phl-frontend-02 ([10.202.2.161])
  by phl-compute-03.internal (MEProxy); Fri, 06 Nov 2026 23:38:01 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1794026281; x=1794112681; bh=u8K/ULughR
	9Q9ag1jaUnUVmdGGZGizOwypZf6pHcEr0=; b=m0aWTgstiBaL8dGRhDtuZiL65m
	R3rBGiU8XsS103GcSi76tbotlJtQLPdc3vBaf9d0vgs7zvfk/yX9fWnkuKBump+a
	ZzATz1hKh0BYf2Qb6BoI91YL+lHWNIbJIbH1Zvu1X7OM2TZqEWaioDszcJW4jWED
	U9mw2lQeD3WrPpmOLQfsw52HmZSusejlWp49tLIbCQeAFo1AsunqCd9XRpqUByDJ
	DkLYNhjVP1xMuPPTzCrYLyAGB9mx8NEbRaPDIeS0afHRW9RKKcrLLmRmIw+0rZ0v
	aVwwhgJ+dIp0V8tenafiRWmJGNh3Sod6W4XdauqqQfSq3Uyl6DTZP9Zr9gPg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
	1794026281; x=1794112681; bh=u8K/ULughR9Q9ag1jaUnUVmdGGZGizOwypZ
	f6pHcEr0=; b=bCHn9fkxfhqiaz+1cjnIIYN2BdbpH1LeKGOOwgKW5F5SqGyIljP
	Gx6PC5cqCYiY/lPTOE+EslXMcZAwece4rNIdq7s1koUzt3nnjTnR3pBhBcPiQEqK
	jz7B5OC4StRJ5UwXGlGNhsrsC+X8w6v0z3PDxHouwmp4HY4WnMjaU1dQ9+lp8R5n
	resTf5cd8XmoVaGiUePE1jh+ToOchDJYwlC6iYIIM9slnxqOGPJ5macH9PUbCAmy
	mW3hC0qy2gMgSII9CaSW/zbfG8Vbkh1z7pMMbokvfuiUrzmm3olfqhGmOqHBntAp
	SibeAF8ZcC73vqwL+ZNGm8OqE3VvSF/nJ+w==
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-09;
	repo=github.com/dkim2wg/interop; date=2026-11-03; sw=lmtpprox;
	action=sign d=pobox.com a=rsa-sha256;
DKIM2-Signature: i=1; m=1; t=1794026281; d=pobox.com;
	mf=PGdpdHN0ZXJAcG9ib3guY29tPg==;
	rt=PGdpdEB2Z2VyLmtlcm5lbC5vcmc+;
	s=fm2:rsa-sha256:KEhzgqPTBiaiajzLaBUQJ+THisgqQ9vjOMA2KaGEMotT34R
	A/BpYIVLqxaqKLP82scLDsaQo+voyG85EBjm77fvVNAKivxYJzmrnvZmprnYeM9k
	UQfzuzyRwsnhk5XcteQ0i2yzpOCUGYBXCJuvbRvpSIDAc5RfSPy5HHXUhW5oxFXL
	caTWpi1YfSgOJGhMfyqkmkC6aujK87w9raGRj4NPGvhr++hDt6mC/Com0UhGjDQB
	/pbsqWv4ROaVKTwuAGX8kpDnrlvL1no3lSd8BvUyDF0k3f1Iu1Dq5XwdnGtvU7dU
	5crEgFm7sm2/kaHXbA4n5sqhwbr7ejKHPvZXA3g==;
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-09;
	repo=github.com/dkim2wg/interop; date=2026-11-03; sw=lmtpprox;
	action=mi-m=1; hc=12;
	hn=cc,content-type,date,feedback-id,from,in-reply-to,message-id,
	mime-version,references,subject,to,user-agent;
Message-Instance: m=1; h=sha256:wmeETQF8pph7MJIWHYXuXjWcyTljQupVVXKrKxGnxFU=:qsU8Cs4T4nd6zv9XXpY8nD5xj+sCwG+8+ldlQueZJkE=;
X-ME-Sender: <xms:KavuajZuN17_cFs1FAE0L2rrbNGchdnJXSk50NIQnWAGjM_o0wKlrQ>
    <xme:Kavuakp1NFeM9rC4Z3UxB3Yi4f8LmoYDWDcUdCforgI2wXUeT_Cy1iLZqS6QVh2ax
    qhZYvsGGJyjbVQP__PjtI7jjDxm8y3CDCcLRhUMYUn8t3iwspiFGYw>
X-ME-Received: <xmr:KavuaoNIMnpssQlAuGXqP0WGi-KohIJ7wU6nvN9bFARG6cqm2sBD8m71JAzCB4ra3XsN-QJcJHpOYdhHbRZ1e1YXRmw0w__831YW>
X-ME-Proxy-Cause: dmFkZTGvzdtAq2P14XGEhf3z2VA50U/SD5i139vBBlCVpnTCh89uxfNsjLOKPHTWLmALjk
    whbhUSiOEqKVaL4AXV8NQtaHioXOaaOaqm6Xs5rneG1hVOMD9xmhM0+YUhYiqQYIsDBZ75
    RkBrmGkTEtV013TL9ntSX2Ud6AppwuckXNeu1tnPLhymtqy/6au/E8P2fOmKVvxQZf8HU2
    I2DnRv0h6ZHspxKQzrji9Haba8mnVevxmeJ1MYZkHjCt9P3sr2loRWqgIWqEUfceDCa9X2
    QrBeo1COHICFbkcpsUdHmDaLrJQhJxcy9FFqhJbvg4GcPlhW+kE9uvM0a4Eq/wXtL600Nq
    nUlpwVMWkesVnck0m5BBpilYlXs2J0pnY3uumLwnVEbyjr0eZNbGb2o8nfmY2k9A4U/8N9
    Lg1TifSvGOhPIWVPqCf1yO8L/DTbQXjF2AIYciCfqk5ns92FSKUkeFW9+QmLch3w/qrDqX
    7xPX1wDzo+7xoDDctNP4D9d1NLonbcgbdumcwtXaKYlKvR9XVLLjx2dCyxkP/QZgagfIRC
    brzrCTZ+8HOFjiGlm8vn+uuCLFUJMfZ6mK1vU32lw2hGyYeWbY8GaCW69u9HEc0/D7i2UX
    RVZFj4ZPMmgUYOqc31vPsOaK1tdrX/0N5wyEQvH50rjTcK6h52oU5ZJN6gmQ
X-ME-Proxy: <xmx:Kavuavr_ATb2afYwWF56j_9JX7v1ZXpHTLGmvFXJERTuN9pAgSRLWA>
    <xmx:KavuatdtAdllm3gx1Wafw6gIEl4RdOAu0ICtFXt8Cs3zS4gTwjz2Lg>
    <xmx:KavualROzLT207xy1dfiSIwHwmg4FKAbReW88ukw_VMhO6fnzkvJyw>
    <xmx:KavuamYtpwqJ4MM6pC6460i7Uz50BEWDvBEwNHquwYIqbZUWfBQPCA>
    <xmx:Kavuarp4areOfDP-Rn8lvCJsOLlhsRP6O2xJfeYm3Ph5Q_gbxz2Kz7co>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 6 Nov 2026 23:38:00 -0500 (EST)
From: Junio C Hamano <gitster@pobox.com>
To: "Ravi Mistry via GitGitGadget" <gitgitgadget@gmail.com>
Cc: git@vger.kernel.org,
  Vaidas Pilkauskas <vaidas.pilkauskas@shopify.com>,
  Patrick Steinhardt <ps@pks.im>,
  "brian m. carlson" <sandals@crustytoothpaste.net>,
  Ravi Mistry <rmistry@google.com>
Subject: Re: [PATCH v3 0/5] http: exponential backoff, configurable status
 codes, and post_rpc() retries
In-Reply-To: <pull.2287.v3.git.1794022836.gitgitgadget@gmail.com> (Ravi Mistry
	via GitGitGadget's message of "Sat, 07 Nov 2026 03:40:31 +0000")
References: <pull.2287.git.1793462224.gitgitgadget@gmail.com>
	<pull.2287.v3.git.1794022836.gitgitgadget@gmail.com>
Date: Fri, 06 Nov 2026 20:37:59 -0800
Message-ID: <xmqqse1d9ryw.fsf@gitster.g>
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

"Ravi Mistry via GitGitGadget" <gitgitgadget@gmail.com> writes:

> Changes since v2:
>
>  * Patches 1/5..4/5: Unchanged from v2.
>  * Added Patch 5/5 to default http.retryAfter to 10 seconds instead of 0
>    when Retry-After is absent (per feedback from Junio C Hamano and brian m.
>    carlson).

We usually do not structure our topics this way, to first implement
one decision (i.e., "waiting 0 is the right thing to do") and then
change the decision in the middle of the topic (i.e., "no, hammering
the server immediately is a mistake, so let's give it the initial
wait of 10 seconds").

This might make it easier to later switch it to 30 seconds if we
wanted to, by identifying exact places that needs to be updated?

I dunno.  brian, what do you think?

Thanks.

