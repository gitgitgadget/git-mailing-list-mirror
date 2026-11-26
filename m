Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=202.12.124.156
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795720889;
	b=zq+nLyfvV6/XwXO+TqUysODSOHNYMCDasMvkAgq8ANr2wQEqydYaQXKp5VANqoeli+ph
	 zGXJXAfqppMsnbLm3SNXzAUwGUMdCJaRohnCcCMh0OfEUBiOCIvm0cUjPQWW//erKqbzt
	 1HCyqKOMWOiZMBnm6J1rUE8bfX679c/biX4oVwx3eU2yRskI3pJqW2G66b8e/ofrbNQXT
	 LF4SA011s++VsX8X7Iy/4EtxRuM2APNpFNcFJw3Np2EiJTRCEjGEf3p0ia/8TxOL1k+5j
	 Byqm2m5s2tQ+nDPkd0yqIXLg+JNyE5o7VUg8wB27h2xAS4OzeOjnu/AI9FcHRU5UoYA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795720889;
	h=DMARC-Filter:Received:Received:DKIM-Signature:DKIM-Signature:
	 X-DKIM2-Info:DKIM2-Signature:X-DKIM2-Info:Message-Instance:
	 X-ME-Sender:X-ME-Received:X-ME-Proxy-Cause:X-ME-Proxy:Feedback-ID:
	 Received:From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 User-Agent:MIME-Version:Content-Type;
	bh=DRvbgKCq5O2ejdEYEZnPNewOZ1F0rSok3kX12P+xOHk=;
	b=306U796GDhbb59TKs1zndKtez4Em3hHa4VJFflD3lhnef+76X7MPq+3LxeP7YIqco/Wb
	 JxrbdaEX8kL0MDE6eSgCwkrCE/ojsRog5Ss2na86rQQr6fK0ABXduejVV2DNZdL3d8T3B
	 A5KXdQ1IjRk7jNEJU9yqjLEcrfZk7XNDDi1Die4IPgvCEhzxwPTs26GC5KGZ6xN6jPSXt
	 E8sTpmBvv34n3flqRb7jP347VbZ07h2Bunt8zoLQLgDQmfotZy1IBTJnQ6fGLZiTrrCEQ
	 2quhhEnfCw7CpYH15U/5wGukD545qRw9boo7U8xT9N8Wvt+M+SExrW0BxvCTGeUIdXQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=pobox.com;
	spf=pass smtp.mailfrom=pobox.com;
	dkim=pass header.d=pobox.com header.i=@pobox.com header.a=rsa-sha256 header.s=fm2 header.b="YSVpw/Fq";
	dkim=pass header.d=messagingengine.com header.i=@messagingengine.com header.a=rsa-sha256 header.s=fm3 header.b="IikD/irQ";
	arc=none smtp.remote-ip=202.12.124.156
Received: from fhigh-b5-smtp.messagingengine.com (fhigh-b5-smtp.messagingengine.com [202.12.124.156])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DBEAE606A323
	for <git@vger.kernel.org>; Thu, 26 Nov 2026 19:21:28 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org DBEAE606A323
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=pobox.com header.i=@pobox.com header.a=rsa-sha256 header.s=fm2 header.b=YSVpw/Fq;
	dkim=pass (2048-bit key, unprotected) header.d=messagingengine.com header.i=@messagingengine.com header.a=rsa-sha256 header.s=fm3 header.b=IikD/irQ
Received: from phl-compute-01.internal (phl-compute-01.internal [10.202.2.41])
	by mailfhigh.stl.internal (Postfix) with ESMTP id 14A3B7A0497
	for <git@vger.kernel.org>; Thu, 26 Nov 2026 14:21:28 -0500 (EST)
Received: from phl-frontend-02 ([10.202.2.161])
  by phl-compute-01.internal (MEProxy); Thu, 26 Nov 2026 14:21:28 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1795720887; x=1795807287; bh=DRvbgKCq5O
	2ejdEYEZnPNewOZ1F0rSok3kX12P+xOHk=; b=YSVpw/FqGczn6lY0tNyRZxq6eI
	3bPD4aKBv2tSPfBybd8MgyNxQl7lWwGDXh+wDAyDWBPv4f5Iu7wZe731YufPg/pc
	Y0omcc9cwtKHZWg4yzsdWXMOmnjFZfuC8Z9MO2L2GJ6qVJdDxDY8i1zWUpqkk3JJ
	m6f+C6r6OBoAlepS7Y1nx2JLqhKDVIPsV+b8mSuwIoREaF4yZDlzDRjN9bGboE9+
	LsjtyeaDzxXGCQHXLovoGtLdePgrrSeOGBXD6B3gCUNBQUxfXdLf1MArjKw5R0CI
	Mnuv1mlEQh5O2BCE9g/QnPAkScI3ZmYswrrPmbSvad+83SLLGiDFPPw+UWFA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
	1795720887; x=1795807287; bh=DRvbgKCq5O2ejdEYEZnPNewOZ1F0rSok3kX
	12P+xOHk=; b=IikD/irQtsykGz8eCQj3/ay7k+tcGuRjZwHPCU0gZAS32/D9W33
	j735Cp0dz5GdyI4LwL9T68U6UOzQ9ywxsFKIk7NkNYimmsc7Iq73YYPgUwUpXIdR
	TIbehm52hy+mwFjMPky28vdFc6ZHCauvba1ReY3dtT/+XtE2bCuVsmPE8DEY89mp
	eG4tds3FEMi6kknoRgBqfR+QiTSrddqlN4VaKxcK7dZZPhselrzHXZ6wo3XPP0Tf
	YdhJuVPwJO7vJW7sY+fmAQM0HcM23ryr2FnPX6pRfkuqbw8DaFE7sgE8k+TiMQy9
	fea8cr1F52Ui2qELAC7YtWO1j4OA29HPurA==
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-09;
	repo=github.com/dkim2wg/interop; date=2026-11-03; sw=lmtpprox;
	action=sign d=pobox.com a=rsa-sha256;
DKIM2-Signature: i=1; m=1; t=1795720887; d=pobox.com;
	mf=PGdpdHN0ZXJAcG9ib3guY29tPg==;
	rt=PGdpdEB2Z2VyLmtlcm5lbC5vcmc+;
	s=fm2:rsa-sha256:iAF4OrSht7skc6aMtw4cbW/XKONdHA/lJoUbTjm0XBoNqcy
	yfpC3vtpJGlIR3GdjQomrfnXVKwulJl5siesw7VYnHLeWNkFElzTrAKqlS2hPMhp
	jU9wBj8rHFhpyuQMacVxlKxGqJZ5+ZW29Y7lUqt8msW7tg5OBfvFkwf6pqdsXDPb
	oCh9q3FGICAUGYqf+FvII++uaZ4tYVKHve7dB6Zmbq0fN9Z3fByL6MNedt96SGgR
	mPcxML64OFXCW+A2isv+TZeAYDPpO0ddV+eDZ8ROV75L3zyjKGFV1h69vsKR8EFm
	er8ux/jVWwU6RyPibkuctDkBjSmLcLeG01cVNGg==;
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-09;
	repo=github.com/dkim2wg/interop; date=2026-11-03; sw=lmtpprox;
	action=mi-m=1; hc=12;
	hn=cc,content-type,date,feedback-id,from,in-reply-to,message-id,
	mime-version,references,subject,to,user-agent;
Message-Instance: m=1; h=sha256:+bzu9QQARyhqBUnjneqk/7h8XsFob1pUmExFHNPxYKA=:2HIECZxbb+KYD0yrSMTzjat91xk9DvFpGZ35HP3Vk2A=;
X-ME-Sender: <xms:t4YIaxPavkBFsoksS8WcZUg4qvp32S-r2DDQOFrzb_01dA1I2dv_bw>
    <xme:t4YIa63S4Kc97ZAKlviJS2ilp1Kqq637Hia8UJkgnYUhDKDi1WxhKi2788TQxbTIl
    TD0XPhbSPXkypBcQtwNcNS4xSM81XUngLFywU64NKtpK4vUzo281Nc>
X-ME-Received: <xmr:t4YIa4m0j1hOjr548xf-Yr-dUJmHRx230Pn9vFg2aVw0fkotjFQfPqK0ybgZyB3Bnwq3LvFh34wyp1qlZc1336pj0f2UmiwQPJqIXVY>
X-ME-Proxy-Cause: dmFkZTE5HkqM5CdPPbpOaPE3UtYD4oeUVXCYchBQoGvp/3OyJ+QwdAtlyLYT9kD+/88aUa
    4yYqAIujTSfzeoqqUdjRQR37d7FgoLueBAQ2UgM9SeLxCSArbSQSi3RQF+IzD+HR+Uj5uf
    //VH0BM3MWl2zznhwo7svF5axOPbSnZMDa1pqkbJoQKJPkGWdJ4kubN0s7Ufk+dZkaXgG4
    39R4BCMrl73sooy4gwCnkow/HD2llgRloZ0I4dIhrCpprdXrfXXg8VujiBDUIw/oSrelNn
    IXvmN4kLsxkj8eKZE/yK50M71CV/7lyIBPQ+4eqz5I878s8uGIdoc4+6LoqyoNzS5jrsg4
    aDo42eLx0wKaWeg5bavbMOt+oSJQwKer7bHeT3OwIAGI6pF26vouO/nFwG/5senamWSn8U
    iIseIUVOdW6kWK3d+VIPeMqrgBl9h3Krm8MAQzkxgxuPRzZfMo0S9DZYcCLTvwkWZRHuLl
    rtIDrNUJYLIsdIVSmzbpOTveMFLWTS3LX8Y9UCMiURK9BYjFcy8FTr38Qte819oN583nu9
    /JBzJYtsO4ivlKyTJvCTAh34OMwOWRJrIJxS2Hca/GHtDFy3uSMqh3IrB6rj4KWey9SSUm
    HL08+wH44mWod/DiyRsFuBop60xvgJhtNcxTdTDbbN7JfNMqpkMR8ja/pf/w
X-ME-Proxy: <xmx:t4YIa5UeUJPS84oPhFIon8L4VpHG6A32LzLeT69UENBJTtaJn6pxyQ>
    <xmx:t4YIa2ugCFGHWuZ_nNhlqA5ygqUX1Zzh9eGOgekOCT-HYW5cwaBqzg>
    <xmx:t4YIa0bJbPF8HosPmV_qfQtsxWDbkRyLz0l727CwNFdklztCe7PM6Q>
    <xmx:t4YIa9Xe5x7pmsVlzP0clAKLQO-H9dsDbrlcQRIEnPgukrCSGEJO3g>
    <xmx:t4YIa2y-Um8kRYiZBYED54RQq2SgnPxc_s0tDwMl-Z3EvlOBCtc1Ub9O>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 26 Nov 2026 14:21:27 -0500 (EST)
From: Junio C Hamano <gitster@pobox.com>
To: "blanet via GitGitGadget" <gitgitgadget@gmail.com>
Cc: git@vger.kernel.org,  blanet <bupt_xingxin@163.com>,  Xing Xin
 <xingxin.xx@bytedance.com>
Subject: Re: [PATCH] read-cache: hash the shared index even with index.skipHash
In-Reply-To: <pull.2337.git.1795701443098.gitgitgadget@gmail.com> (blanet via
	GitGitGadget's message of "Thu, 26 Nov 2026 13:57:23 +0000")
References: <pull.2337.git.1795701443098.gitgitgadget@gmail.com>
Date: Thu, 26 Nov 2026 11:21:26 -0800
Message-ID: <xmqqld6fjt55.fsf@gitster.g>
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

"blanet via GitGitGadget" <gitgitgadget@gmail.com> writes:

> From: Xing Xin <xingxin.xx@bytedance.com>
>
> The shared index of a split index is named after its trailing hash,
> which the split index records in its "link" extension to find it.
> Since ee1f0c242e (read-cache: add index.skipHash config option,
> 2023-01-06), do_write_index() skips that hash for the shared index
> too, so with index.skipHash and core.splitIndex both set, the shared
> index is written as "sharedindex.<null OID>" and the split index
> records a null OID as its base. Reading the index back, a null base
> means there is no shared index: the entries that were moved there are
> lost, "git ls-files" no longer shows them and "git status" reports
> them as deleted and untracked. With fsmonitor, it hits a BUG() in
> fsmonitor.c instead, as the fsmonitor bitmap refers to more entries
> than the index has.

It is correct to point out that the two "features", skipHash and
splitIndex, are incompatible.  With skipHash, splitIndex will not
correctly work.  We can say skipHash breaks splitIndex.

But does this change to _force_ the base index files to be hashed,
against the user's wish expressed by skipHash, take us in a better
direction, I have to wonder?  With this change, skipHash's promise to
improve performance is not kept.  We can say splitIndex breaks skipHash.

Stepping back a bit, isn't the expectation of splitIndex that these
incremental modifications held in non-base index files are relatively
small, thanks to the bulk of data that the base index file holds
covering almost everything in the repository?  In other words, isn't the
use of splitIndex a strong sign that the base index file would benefit
the most from skipHash?  And this patch is breaking the skipHash feature
for the use case that would benefit the most.  And not hashing the index
files that are not bases would not save as much, since they are expected
to be much smaller.

I wonder if going in the other direction, i.e., when both are enabled,
disabling splitIndex and working only on the base hash, would be an
alternative that is equally viable as this change?  Both will *break*
the promise of one feature so that the result can live with the other
feature.  What are the pros and cons between them?

