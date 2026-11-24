Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=103.168.172.158
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795558986;
	b=i12XuQX94FM8yztKt+dGxuJpaZYSdsKCpD8mXE8zm25CHH7MXabDWouxXcN0iJOqfhI9
	 dI7yMyYiyDuqNfljdN+u+CcVUtWMrmjVC6sbgRbeIgncqJKuW4jTxeCh5axLslsB/pWa8
	 rMObDTAVtDBdt/a4keEvnqIF/pgLiYZX5l04P4yLL0N04HEZfqFEskfj6vf2m9r0+oy+M
	 s72+n6RokZcCrfglEV7iQDtPIPsmwRUDTvbXZC1t4Cl6ZQzPEzyZYGShUoy3urjCbwlRL
	 H8Bf2d+Fkju3/317wJG1Yr/de3dfT0r3gKeFKLSENyMO67ocgpjTgu2q/neuHc1mGbA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795558986;
	h=DMARC-Filter:Received:Received:DKIM-Signature:DKIM-Signature:
	 X-DKIM2-Info:DKIM2-Signature:X-DKIM2-Info:Message-Instance:
	 X-ME-Sender:X-ME-Received:X-ME-Proxy-Cause:X-ME-Proxy:Feedback-ID:
	 Received:From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 User-Agent:MIME-Version:Content-Type;
	bh=lAo20onub3CLPQP/GXxFWJQu5bVo68hcbcVNSec3E3w=;
	b=PCA9Yxkuo59Jq2AhJnvPSNRxg6mP3NMhrBxlMI6HDtjkTYLt4QHYz6wb5HIMCbmj3drN
	 f0OsuYhGRrNDcCEC5X+hTtNGMoH5+26oa1Eud2+UBty0u23zgMEvGqke+G8l17FQ2f1uu
	 Dg0RNrqd3zATpPShG6Hp0G+fem6qj1LlPXIxbRd9cK3w4MAyaeI9TIZ+WFirs54EPY7DJ
	 6zy7b+cqemvZveSNOWdaYbhqtY0axGmU3eywnZmATZtHGJPJvRyKc1mGKZOMIl04wf4hc
	 KsoEyfjyhygSAyQ6NpocFqYLOBncwYxeBArjbwN5/7Ymt4JLSZIBuCGklAec17x8vhA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=pobox.com;
	spf=pass smtp.mailfrom=pobox.com;
	dkim=pass header.d=pobox.com header.i=@pobox.com header.a=rsa-sha256 header.s=fm2 header.b=YIIPKO+C;
	dkim=pass header.d=messagingengine.com header.i=@messagingengine.com header.a=rsa-sha256 header.s=fm3 header.b=5ZcrXb4A;
	arc=none smtp.remote-ip=103.168.172.158
Received: from fhigh-a7-smtp.messagingengine.com (fhigh-a7-smtp.messagingengine.com [103.168.172.158])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5A61A606A31E
	for <git@vger.kernel.org>; Tue, 24 Nov 2026 22:23:05 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 5A61A606A31E
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=pobox.com header.i=@pobox.com header.a=rsa-sha256 header.s=fm2 header.b=YIIPKO+C;
	dkim=pass (2048-bit key, unprotected) header.d=messagingengine.com header.i=@messagingengine.com header.a=rsa-sha256 header.s=fm3 header.b=5ZcrXb4A
Received: from phl-compute-06.internal (phl-compute-06.internal [10.202.2.46])
	by mailfhigh.phl.internal (Postfix) with ESMTP id 71A501400306
	for <git@vger.kernel.org>; Tue, 24 Nov 2026 17:23:04 -0500 (EST)
Received: from phl-frontend-02 ([10.202.2.161])
  by phl-compute-06.internal (MEProxy); Tue, 24 Nov 2026 17:23:04 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1795558984; x=1795645384; bh=lAo20onub3
	CLPQP/GXxFWJQu5bVo68hcbcVNSec3E3w=; b=YIIPKO+CuhRXhhkOzI8XTe2rnv
	KqHFLhR6Q7lSzOhjdbLHAkipkx/fTrANc5pz38nK5Dj415MAsLEBH/+LcabJRtTo
	E4waHIxEtpMgLbYsFej7veO33jkUq3BM2TElpm6UI47DssxQAbxY/PMBTR+Z26DG
	9YHIDMmx7GemvJKvk454kGwX7h3MRAxhtCHcsSip5fRe7/q00E59Gm+fMkl0qZy8
	aQPPi11fLrF48PCXz8zh8hT7bnwHohyTSPK4BFQAQUTVof90iAVbMUhF5sOe+qE9
	mKH/0Bz2ggOmIhhNVwdBkf/jmlI9zg8/pAcyhjK78vt1JTOnGQ7wn1XaqOyg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
	1795558984; x=1795645384; bh=lAo20onub3CLPQP/GXxFWJQu5bVo68hcbcV
	NSec3E3w=; b=5ZcrXb4A1ihLyWoLYWlJ4fJAvh3//GFLZ30EmP6WrC/vDZBM4xw
	0pK+wEbsweEWtu8BFvPVJqpsrI5A5k5VL/vPenZ3zLLe8/khfmc7Gssh4PzMWprP
	tJ8VJFXTUHVFbnTYnDUyjC2wiEo/ur1nnhnN4w4KyIp6A/rO2SMQZzVcgWdKrh4O
	0zbEuBzPBSZ470slRcsBWbrTZbGneySeLa/var8luUbA3Oj4a96YlZ7F30Xp+bV3
	UIOPNFlvSKQ8m4NUZPCZcGG8TQaR00EaTDbiYhFgWNmcgNwvF7juoqHkE544xkQl
	t+LerNhrT44g3bzOp+roroLc7qtbP7F6aTg==
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-09;
	repo=github.com/dkim2wg/interop; date=2026-11-03; sw=lmtpprox;
	action=sign d=pobox.com a=rsa-sha256;
DKIM2-Signature: i=1; m=1; t=1795558984; d=pobox.com;
	mf=PGdpdHN0ZXJAcG9ib3guY29tPg==;
	rt=PGdpdEB2Z2VyLmtlcm5lbC5vcmc+;
	s=fm2:rsa-sha256:hgsHMifkojUFDYUfOW6jUbNldGiF36O2zqH3zjB8kQGA0bm
	tqEuBHaV1rGWnts+pAWHwpmFDap3+2jJlZV/0w1pvIzg1/hUnrq7S/QAyv3yHHDu
	2mzYo8LsKxu4KXZEamDLGfj05tiLwbuJjBM6G9P6Cyd0WDNVZmYQm1EOm2jexprc
	cd1g//dVpnboRHy2GF9AAPR2KKtDY+MQl+zwfoKAmBHXUUIWREXq28mw7ckfNoVV
	pHGjtLAyz1uVjNyD1hAnXc5GrtS04jcvJzrKEWgz3sb1oo5dX/G68omqx+s2PDbg
	Qd9jNHyzb3LJx9pZn3xbOTdBPcKJ/hZ0qy+fMqQ==;
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-09;
	repo=github.com/dkim2wg/interop; date=2026-11-03; sw=lmtpprox;
	action=mi-m=1; hc=12;
	hn=cc,content-type,date,feedback-id,from,in-reply-to,message-id,
	mime-version,references,subject,to,user-agent;
Message-Instance: m=1; h=sha256:GuP3yuRTF6JxsLHqOjV6latGDhvnNy6wzEaWKXtcc9w=:QqpUsHrurB+NsOKANDwZ2OpDnU9MZWrkWjIa4vo4thQ=;
X-ME-Sender: <xms:SA4Ga18ndIYtXZoyImjsX7baZjWkmbsl22BoqEc7sf_GNQXc-J3iuQ>
    <xme:SA4Ga78hNkca9YP0NRD4M9FvmJiIrswtoQklc90vJL6DY3gNMt4Ws5Nc7ZShXNjgj
    3Lzivt4k_hKHoUOEcIvRlXr8X6CJ9nEECj-mKpI4BwYsleD6suHFbw>
X-ME-Received: <xmr:SA4Ga1TUtZ0iDMIRX9ZI1XeKlNtKcKg7LpA3140RSHLvHCGFPIrexxevbh-iBcn3ygNTQczfa8EWGgj8po3y-7d33eqMFvDfmgutGRY>
X-ME-Proxy-Cause: dmFkZTGsTXWbyLHNHWvTmT1GZhVF1mJ5ZkaPAhM3lhG+a2X+DQ0CdO+ontzDubjDadMXqs
    LcDZvge6Hf20sPKj1TGy7F2mjrAJtLTV6K8/5CzV7e04Wk5E4X3wld6Y17l8Hn73UBzOBz
    cmgfgDVXgEnYy6xDx3OK3uCXDDMFddv4RH3C8h3lmKNxrbg5JailMX6CQa/YeMQGdbpkLo
    J+0j+X5hrVz6/Iq3jBdGVuZqWyXLpuQz5iQUVfgBCSt+k37lPbP+TQEN07Wo9wTFA5vEWE
    4dcXt3GelQY5Siy96PLtwuermJ6sf+dWdFINkbnTrD34K8acrQVBa82KrN/6ADQ+o4Mjrg
    ihiy51kLJF87VYExXaF7DI6np33He+mZv8VYD4aZGlb1n8ED0ReKHNhgzRszbsetjhFx/m
    wlQ0ApmABf/bOHfLfwdn/3mUIU4OMjjF6TvHv7RbG32MRtEjhcD2NqSCKXR7mmQqf67qJc
    wvs97+3J0kQIEXTS032EAMoyuJwhQEwhUc0V0IDHNzyjannfxSEUDqMYfdoGypCYYunYsJ
    PfbQGmQySRyDNnouFTlipK1qu8o0iP+M83Eo3YXQpoc9XtLsSgxkLbQGpPuM7hPM/gUXdc
    HO0vPmgEBsZQTrzfxBOHWB0+n+bQ1TxCMwsqALOPAZfDm7gOi9X0E6S53Pyw
X-ME-Proxy: <xmx:SA4Ga_dNTqfpGSuA81ziSM1eH-mImZ26eCzzNNoMM56Z74CczBjEgg>
    <xmx:SA4Ga5Dwy-9xsoOqB2eqwPrq3-e73rEFwsW5MTsMaKYfnOYLeFxnxA>
    <xmx:SA4GaxktBEvLyHEv4cf2uWV14LKzSoyc54XE8Lwdf4PUrM5tIE3-uQ>
    <xmx:SA4Ga0cFMmYe-96cl-IfLJOPeifhXY9YcN1c4pbX0lWkQFMwfbhGbQ>
    <xmx:SA4Ga2-mz2UQHK1ijYXkfk1MO1IlA65MvuliuRj6bPtNb6r0DS6XwXCq>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 24 Nov 2026 17:23:03 -0500 (EST)
From: Junio C Hamano <gitster@pobox.com>
To: "Ravi Mistry via GitGitGadget" <gitgitgadget@gmail.com>
Cc: git@vger.kernel.org,  Vaidas Pilkauskas <vaidas.pilkauskas@shopify.com>,
  Patrick Steinhardt <ps@pks.im>,  "brian m. carlson"
 <sandals@crustytoothpaste.net>,  Ravi Mistry <rmistry@google.com>
Subject: Re: [PATCH v4 1/5] http: fix retry count and Retry-After timing
In-Reply-To: <d4d34077283370cfa22e9d8f57edfb35de9c692a.1795103883.git.gitgitgadget@gmail.com>
	(Ravi Mistry via GitGitGadget's message of "Thu, 19 Nov 2026 15:57:59
	+0000")
References: <pull.2287.git.1793462224.gitgitgadget@gmail.com>
	<pull.2287.v4.git.1795103883.gitgitgadget@gmail.com>
	<d4d34077283370cfa22e9d8f57edfb35de9c692a.1795103883.git.gitgitgadget@gmail.com>
Date: Tue, 24 Nov 2026 14:23:02 -0800
Message-ID: <xmqq4id5lvi1.fsf@gitster.g>
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

> From: Ravi Mistry <rmistry@google.com>
>
> Commit 640657ffd0 (http: add support for HTTP 429 rate limit retries,
> 2026-03-17) introduced two small bugs in HTTP 429 retry handling:
>
> 1. In http_request_recoverable(), rate_limit_retries is initialized to
>    http_max_retries (the number of retries to perform after the initial
>    failed request) and decremented with pre-decrement
>    (--rate_limit_retries) in the while condition. Because of the
>    pre-decrement, setting http.maxRetries=1 performs 0 retries, and
>    more generally N configured retries only retries N-1 times. In
>    addition, if the first request returns 401 (HTTP_REAUTH) and the
>    re-authenticated request returns 429 when http.maxRetries is 0,
>    --rate_limit_retries wraps from 0 to -1 (truthy in C).

This describes what the existing code does very well.  Moving the
http_max_retries <= 0 guard to after the loop also keeps a 401 followed
by a 429 from wrapping or emitting a misleading "retries-exhausted"
Trace2 event when retries are disabled.

>  	while ((ret == HTTP_REAUTH && --i) ||
> -	       (ret == HTTP_RATE_LIMITED && --rate_limit_retries)) {
> +	       (ret == HTTP_RATE_LIMITED && http_max_retries > 0 &&
> +		rate_limit_retries-- > 0)) {
>  		long retry_delay = -1;

Switching to post-decrement with an explicit http_max_retries > 0 guard
allows the full N retries, and avoids looping if http.maxRetries is
negative.

Looking good.
