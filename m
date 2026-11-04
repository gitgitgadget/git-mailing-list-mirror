Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=103.168.172.159
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793816279;
	b=WZIZ1MShK840KN/sDLCTAryBGC9+e07Udw3kfK3D4erTFbtSu7tekw7pgoHjldjMSe9b
	 luDYEWLkSVb6Ia3zgJzZ9mBAPV0m4d8Ur/ysMIHuWmBEEXsSfKsqfwgAqV0GRQGpcb3Rg
	 MRMDwzWm5CRfsQl+TDsyYcXx1wCIhtvwDHWfQBws/P9pIB5c3NxI3nlcTY50i0+r9Hawm
	 0Nuzyl1X+mfi/ifERvUC8OGQH5NfA8fgXh9Nbyl/PjkOWNkR6/StOVR5Fi6xPRYdMT4Ds
	 3Zwk+6RjO7g9TQ+aV71+corsTayN6KNilMKnbGS8TFucmi4aXUqnqKDABg30AQKnXVA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793816279;
	h=DMARC-Filter:Received:Received:DKIM-Signature:DKIM-Signature:
	 X-DKIM2-Info:DKIM2-Signature:X-DKIM2-Info:Message-Instance:
	 X-ME-Sender:X-ME-Received:X-ME-Proxy-Cause:X-ME-Proxy:Feedback-ID:
	 Received:From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 User-Agent:MIME-Version:Content-Type;
	bh=ecYPN6GtMRuHvfLAAqqO5g9yPrGk92pTju+gNmacND0=;
	b=sNeCdzh3oaYxs32WgAiqlMEHqHNTee2XbwBmmdu7M0RvSoNj0k/lLPDlDAdtPiZOM7cX
	 u+nzxNLqziZ6ViBiDU3UmwIfUqszrD3iAqY8XEPlBfV6u3XQWXWNEyZ9S5L6sT84k2U+Z
	 mWP1KUs88PfCWITTZpNAMHaCgcuYb7sTvYzdb0fcJUAatD8S9+A6kXhsYf2c9wyJXgCVr
	 dDbl9hWqQS6cSegdF0yd1Fy+ErXCbujQq909GS5lkRE20YsEUWBotOEDSkfouEAPAd5Gc
	 RJYrm2Jr5pC3RAyQPLcZ1A5oUu09EzR5/xgis+w+8mUJ5WyWYzTCm/Snp3LRWx24COg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=pobox.com;
	spf=pass smtp.mailfrom=pobox.com;
	dkim=pass header.d=pobox.com header.i=@pobox.com header.a=rsa-sha256 header.s=fm2 header.b=Uo+JsuU3;
	dkim=pass header.d=messagingengine.com header.i=@messagingengine.com header.a=rsa-sha256 header.s=fm3 header.b=4PqFx+AF;
	arc=none smtp.remote-ip=103.168.172.159
Received: from fhigh-a8-smtp.messagingengine.com (fhigh-a8-smtp.messagingengine.com [103.168.172.159])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A9597606A31B
	for <git@vger.kernel.org>; Wed,  4 Nov 2026 18:17:58 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org A9597606A31B
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=pobox.com header.i=@pobox.com header.a=rsa-sha256 header.s=fm2 header.b=Uo+JsuU3;
	dkim=pass (2048-bit key, unprotected) header.d=messagingengine.com header.i=@messagingengine.com header.a=rsa-sha256 header.s=fm3 header.b=4PqFx+AF
Received: from phl-compute-05.internal (phl-compute-05.internal [10.202.2.45])
	by mailfhigh.phl.internal (Postfix) with ESMTP id DF82B140016F
	for <git@vger.kernel.org>; Wed,  4 Nov 2026 13:17:57 -0500 (EST)
Received: from phl-frontend-02 ([10.202.2.161])
  by phl-compute-05.internal (MEProxy); Wed, 04 Nov 2026 13:17:57 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1793816277; x=1793902677; bh=ecYPN6GtMR
	uHvfLAAqqO5g9yPrGk92pTju+gNmacND0=; b=Uo+JsuU3zC8917eciyxU8jzQz0
	oYNy1POLfOzZcLTMAOlddZD5xZVHMZaiJ6IRjoCPC7gNDWCsNWkwSVJcxTA47rOo
	MDQDvASVnrKwO/lrqv2+iihLbNlLgfBNNA8T9Ar4POJF3QVpQYs1poZBeT7C9+69
	mC7wQLkVZZe0OZADaOR0SgIiV4LkMIGVWeQGFnYD0EgvrE7yfdsqjA9oxxCWvWjk
	jeIdyH3eUeysRVsR/EwyziNP4XqmWIqjNiE8aA35j3rul2V+YDglNtKNk3P+JzUQ
	nJsBaR6EhCXqKrJ6ViVNZdvwO3AQcBK0XF5pIz9AEBppmc1T1FyBJU09EOww==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
	1793816277; x=1793902677; bh=ecYPN6GtMRuHvfLAAqqO5g9yPrGk92pTju+
	gNmacND0=; b=4PqFx+AF2XPy5gc4Vx7h2cUspXZOIGx5+hv45sE2J6rYyYA7QG+
	qIa+uqtMl+bRUcp4AHzAXv3B57nWCGG/NWR31kVG8LozuulCzn6QaKG7pvT5Jb1G
	2AFBK+0Kx0gOCM71d6P8PQMofRRI0KDhFFvcMcMi93yM3OIE4PyolzLi0dBE5XGM
	WlU/tFHZnEBGElwmu1K8335dwzVQn4YJ97Kqn7Rlr07+N2g5SapPmMz5Dzlaj2wx
	zdV3EZ/GY7f4Ye0NyKGlyzLGFftETvI2WOgnHiLRi71/3pqf8PHOjPoR/lJTb8qB
	LQCUAJEvwPbXHKDt/MzuYl3APJiN2JDwDQg==
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-08;
	repo=github.com/dkim2wg/interop; date=2026-10-28; sw=lmtpprox;
	action=sign d=pobox.com a=rsa-sha256;
DKIM2-Signature: i=1; m=1; t=1793816277; d=pobox.com;
	mf=PGdpdHN0ZXJAcG9ib3guY29tPg==;
	rt=PGdpdEB2Z2VyLmtlcm5lbC5vcmc+;
	s=fm2:rsa-sha256:ZSR1yaEgGKLlRvaLaZGjq7i5dT5/eeHNVdTHntltI0lUsXw
	jh4yCBcy73dnHO+NaJZDRBWly6IkwTVBZKNus8LzoZrTbqmQ5UM6kh16zepA3uTD
	8LRaLvHyuU3PZ4iDMU+Lf9h/HumoaTeaNSo0kp5lgMM7pz4kC7YtpjJ8RMhuptFh
	3sDB2MSPnjQBUY+qi89RDdg5zIvIHr5LFwR3XPo9p2Hu6YML62XgnHx0kuD0ZClx
	mlWoO8Y8ECtTP5ECsfC7Eu0K74uICF5ytyqQfpYWT5L9FXquG9LsZIqEbb8Bb2yx
	PjcbUDA4HCrspNgkuqB6lE4Fq9tnsx2sdoxUlug==;
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-08;
	repo=github.com/dkim2wg/interop; date=2026-10-28; sw=lmtpprox;
	action=mi-m=1; hc=12;
	hn=cc,content-type,date,feedback-id,from,in-reply-to,message-id,
	mime-version,references,subject,to,user-agent;
Message-Instance: m=1; h=sha256:sTKvl4SIiucgF+ZlLqDhUQfxm4rWWAEl2t9Rew/6QMc=:xE1ANoby7+1xpj/vQ2hL31+8/dSlUxMtTYTfALBPnhE=;
X-ME-Sender: <xms:1Xbrap2S2KmrhfZJ5MiHoswwjkjMpFIDgyYDZlHcELHVnkMrxb3fmg>
    <xme:1Xbram9h2E45diIp6dc8EYPeu7uG8qFVArLf1OJye5MVvdGQB8e1gl9wsTcuwnsT5
    CTGHgU9uxp0ooun8DuPgdExJ6wHaxitFDZtoOVrEL6jB1-cSuaO1Os>
X-ME-Received: <xmr:1XbraiPJEbFzVDCVRFJ_gzt0n940KFZNzAPZcxlegwl54qFhYKNW0B2WvX34hLFFMYyzagbb2Hn9xu-2uaDeO8MAqo5tDBFowPb->
X-ME-Proxy-Cause: dmFkZTGIOlRc3qDpqQBJAOOg/HxP2PLKkBQWiUH7cZG/+6x6P3AIoDbtJ4vGFyJ3H827pb
    tVfwXhoxAzYCms+Y7VjVcAzR+oqP0OCMcmLThbG45XXMrnjiHn4iRW597QgMslAzReWb0S
    LRmZAaDouW2BexTVlTurtDQQZCuIcGU2GdhbsgCD5HS/vapciklRX55pQoTnVvTlZtV3jg
    cHNBLd5XwjV83S2nGVT1FC+XhtR/5+tRlfarsMWbjNFJUwqxl9HU8vc4Rk5vQjYdCUy1af
    e6DQzOo/5pmHASg3YRSEWMBwO8+jdkVVpMhFySSRhVWr8b6Ba3xUm8ba0viqZUzJzBBkRX
    UkQKfRGlHiqW2CXGKPfQYAEt5VPxXQRBTG0Ru5T2GPQuUbeNavhZ/6cUjIMM6+RSL6ajwO
    pg5/CK9qVxF27DHGyOoUQb5rm3fTvxAHAqHHK9kinvfXdAvj/TAfobd5cz4CumX3OKS3qB
    UVLH9j1gJF9eM9T/di67HPlMDcC7Ii5Bs7EwvkSMtnREe2Vk8g6NjlLmUei+iBg9sNf/+Z
    n8daizCBhZs3pBm2Wlt5bldZbyV4qeAWYWWTBreG+0yd2xmEukM2UzWVdb0OaUhYWUba3h
    dIelcYsEN7ofaE2m055YIBx+WlN5TUyVQkT30vEOOevB0Af2rX+7/iE31Mow
X-ME-Proxy: <xmx:1XbraidALatyhIquTodbK377_fcaCup3435LKZ_0SJ4aizH3uWmOJw>
    <xmx:1XbrapUX8bThMXpH-xoNqv2svvClH3drHoV9VFjTdbWvr4DdVnw6ZA>
    <xmx:1XbraihCL52ixW1FvrKhmdYxtwc80Ks3BPJbcaFVwXO3lVjEfUHZWQ>
    <xmx:1Xbrag9jqGWPETsdLhzIzsm4OjIgrhAjNiyAfN48lCPsPR60gdssNg>
    <xmx:1Xbraj7JfAUxYFJHzwNTUrtwcmMX3XnTmHlrqmK2itUPHwDlb5-_GHmI>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 4 Nov 2026 13:17:57 -0500 (EST)
From: Junio C Hamano <gitster@pobox.com>
To: Kristofer Karlsson <krka@spotify.com>
Cc: Patrick Steinhardt <ps@pks.im>,  Linus Torvalds
 <torvalds@linux-foundation.org>,  git@vger.kernel.org
Subject: Re: [PATCH] describe: count the distance correctly when commit
 dates are skewed
In-Reply-To: <CAL71e4PqEQkGoont3tL5wJWd1_itsaaxfX+DOkLj64x-S7xR1A@mail.gmail.com>
	(Kristofer Karlsson's message of "Wed, 4 Nov 2026 12:01:58 +0100")
References: <20261031065525.19883-2-torvalds@kernel.org>
	<auiGP4XhObUzC9vD@pks.im>
	<CAHk-=wijLfduoJyOM+AW6FS6c02cuEFRAuQWLE+uf7SGhj8jXA@mail.gmail.com>
	<aumKXUS7_x0i7ZU1@pks.im> <xmqq5wyd4epv.fsf@gitster.g>
	<CAL71e4PqEQkGoont3tL5wJWd1_itsaaxfX+DOkLj64x-S7xR1A@mail.gmail.com>
Date: Wed, 04 Nov 2026 10:17:56 -0800
Message-ID: <xmqqv76c1mwb.fsf@gitster.g>
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

Kristofer Karlsson <krka@spotify.com> writes:

> What remains is knowing when to stop.  With the queue ordered by
> generation number, as in Linus's patch, that is exact for commits in
> the commit-graph.  For commits outside of it, it is exact as long as
> no commit is dated more than some epsilon before one of its own
> ancestors.  That is a sufficient condition, not a necessary one: on
> linux.git the worst such case since v6.0 is about 60 days, but a

Unbelievably bad clock skew.  I wonder if these people do not check
their machine clock at all, but knowing the answer to that or learning
why they don't would not help the issue at hand at all, so I'll stop.

> miscount also needs the skew to be right where the walk stops, and
> an epsilon of a week gave exact depths for every commit I tried,
> including the ones right around the skewed spots, at no measurable
> cost.
>
> A nice property is that this also works well with a partial
> commit-graph.  The commits outside of it are visited first, and only
> those rely on the epsilon; once the walk reaches the commits in it,
> it can stop as soon as the depths are final.  So the commit-graph
> does not need to be fully up to date to help, much like with other
> walks that use generation numbers.
>
> For 2a500a04d6f9 it gives v7.3-19059 with and without a
> commit-graph, in about the same time as master, and it matches
> "rev-list --count" on the ~450 commits of the last merge window.
> Both expected failures in t6120 pass with it, with and without
> GIT_TEST_COMMIT_GRAPH.  The change is about 120 lines added and 60
> removed in builtin/describe.c.
>
> Would this be worth pursuing, either instead of or on top of
> Linus's patch?  If so, I would be happy to clean it up and send it.

Sounds interesting to me.

Thanks.
