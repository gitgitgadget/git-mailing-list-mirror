Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=103.168.172.159
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794411498;
	b=gQTT4etpnEUa4h5dAXfL56OZ4Jly3L9zePEeT69YdS7HuTdNlAMKZtI6RE/7aPNTVSrq
	 x9xgjq0ki14wMVzfqleQgVcOmz+TrDPyiEV0bx0LSiasV9vtUHr8QLpnAqMZQp4aTTm5R
	 RSCZHOC4o5VWqEEslsJE4wwxdS88cOOrm+a4LTYlMM8TILvqae7LGUqk10Yv99qTM2jeA
	 A/FfXYd/fePynrk8OR+DgbW0kt1t7q88bMnm2tsVQRbb+qMu5TDOgHPDvRd6eFraNc4TT
	 3orFBIfVYwvAKnVhSgGRurEuehR2cS8Thcy8nWBg1dbabykbFoQYA/K14nP3xzFLPmw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794411498;
	h=DMARC-Filter:Received:Received:DKIM-Signature:DKIM-Signature:
	 X-DKIM2-Info:DKIM2-Signature:X-DKIM2-Info:Message-Instance:
	 X-ME-Sender:X-ME-Received:X-ME-Proxy-Cause:X-ME-Proxy:Feedback-ID:
	 Received:From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 User-Agent:MIME-Version:Content-Type;
	bh=9TX4d6dk+iqgtZCIi8o6Iu6PMAqqn/z655+lQorXog0=;
	b=RAPTlpXvpjIPQGa3XB2iqSqBEvkGpSWydG5wqzRO7KC3WucvmYQ8l7oZUNQNRjFpNggE
	 ibzUpriTgB2AsXyj/kEdsiHa8LhpcoJd8rDzjKurmF4xYl0VH6QoNPrEDYnIVgR7rkWCn
	 0kkvyeWxbnFcTfEd8e2o6YjEQXnB40gJka2jKfKOFQXWGtXVFP6nrHSaBzjX+s1+D218N
	 U69tiovCGDfkPfj5PhpZdALfHzJd9KnlNI3mzUxyKhJQKfTjDBb7CJki6h4hXOxgFzxXb
	 qPZK5YILzaLzSxGKfdJCG8mhB9y2KhLAAVocag2jFW7FKX3mOzgKVyKfqe1vg1Tq8uQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=pobox.com;
	spf=pass smtp.mailfrom=pobox.com;
	dkim=pass header.d=pobox.com header.i=@pobox.com header.a=rsa-sha256 header.s=fm2 header.b="F7nuy/VA";
	dkim=pass header.d=messagingengine.com header.i=@messagingengine.com header.a=rsa-sha256 header.s=fm3 header.b=uBaJEfjQ;
	arc=none smtp.remote-ip=103.168.172.159
Received: from fhigh-a8-smtp.messagingengine.com (fhigh-a8-smtp.messagingengine.com [103.168.172.159])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 92D67606A321
	for <git@vger.kernel.org>; Wed, 11 Nov 2026 15:38:17 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 92D67606A321
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=pobox.com header.i=@pobox.com header.a=rsa-sha256 header.s=fm2 header.b=F7nuy/VA;
	dkim=pass (2048-bit key, unprotected) header.d=messagingengine.com header.i=@messagingengine.com header.a=rsa-sha256 header.s=fm3 header.b=uBaJEfjQ
Received: from phl-compute-02.internal (phl-compute-02.internal [10.202.2.42])
	by mailfhigh.phl.internal (Postfix) with ESMTP id D8D9B1400141
	for <git@vger.kernel.org>; Wed, 11 Nov 2026 10:38:16 -0500 (EST)
Received: from phl-frontend-02 ([10.202.2.161])
  by phl-compute-02.internal (MEProxy); Wed, 11 Nov 2026 10:38:16 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1794411496; x=1794497896; bh=9TX4d6dk+i
	qgtZCIi8o6Iu6PMAqqn/z655+lQorXog0=; b=F7nuy/VAyDluRJF0e4Y05+HO4z
	jkWtVkf4GU9q+htjircF4kRDhVeHK9o2amcZhk82FJXB8OzvDt6gmDWlawufQ0Yd
	+XJwW2Sdhjn2nviT8fYCxkYkA55NAPUkvrbwEwosCJvNKvSPSUK2yXB11dQm9UVQ
	ydM7Lo7VsZrWmMFtrR3kiM95ud5TXnZq7MbM/TFwRvQvVFScdVmoRkz1afg9xVwv
	ENtw+tGklP7cx5w3U9mVgpJ4m3HMubxsEd3YyTZ3AAXZLPDoQNxVNLlyKAl0etZU
	vhYHYij56/jN8lCfMX+L8f/d9g35uxzVYDP6rmT16T8Yu/k/vIZmTX2LIgDA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
	1794411496; x=1794497896; bh=9TX4d6dk+iqgtZCIi8o6Iu6PMAqqn/z655+
	lQorXog0=; b=uBaJEfjQTMWybnARF9ZTSeMMObBD4rJ99JG+fOydGDancDWVtuR
	ysKk+eFUvWOasYO3kGjQCZylShhCe5XVDXtat71Y9urR5NJRo22id8UQ1G0UIl/z
	WavFmDWEABTluAabl5yoAzk/QtTDQpHKCPVNIisiBqtBOQ/wnELb5Cerfo9vi1q1
	KQARlDoCO3cBdAwht9kwv/cvBLTII9qFCr7GEG6ZvwTDp4t5bemVXbDDbGJhjxHa
	A0muZEyttfqrFoxFtxfHO4y0h8bSsEn3m5vFpiYvsjsi9RQwJm26pl3fzHB+GiUk
	KU8nMwO/ccJvIRzmkl672aji1cCsgHOmdzA==
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-09;
	repo=github.com/dkim2wg/interop; date=2026-11-03; sw=lmtpprox;
	action=sign d=pobox.com a=rsa-sha256;
DKIM2-Signature: i=1; m=1; t=1794411496; d=pobox.com;
	mf=PGdpdHN0ZXJAcG9ib3guY29tPg==;
	rt=PGdpdEB2Z2VyLmtlcm5lbC5vcmc+;
	s=fm2:rsa-sha256:XHW9B1SwkIESF3kA60/5umvyqob5r/yVDZwzxHtBSkDrY+P
	dAJzBFy3VKwWyP6pggLIDhrbzBymuaQEyvIXcfDGLY4QN6vvmYP3VlApGO+sMSpE
	8nvOuHkGpuZJ7Q2ABeUXUsni1EXSo09GzWSJMkjiPpIx6zoewS0BBoWJScoj4YDS
	/8QEdzW7K2F+ZbyWJ5sV12itQHNXxGum6r05vd42TFBPPrdyK+Qrp+mUefQerntC
	4jdxSqiLuo0MVR6L0lQKU4uOgWHSDL/JfnWefac4tefE1QluGVRPzj62DrkunWD1
	RLpugbssE7Y63WnSRKEN8Lcty+wC4Xr2QOEkkRw==;
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-09;
	repo=github.com/dkim2wg/interop; date=2026-11-03; sw=lmtpprox;
	action=mi-m=1; hc=12;
	hn=cc,content-type,date,feedback-id,from,in-reply-to,message-id,
	mime-version,references,subject,to,user-agent;
Message-Instance: m=1; h=sha256:VA3iQBE+htyCeNMcCHJKlQqbl8O2StV4aGpya7MuTMc=:N9z3/RAMK7PBpMl7rksXVBxT5PJDMGsRdwyd8nCMfBI=;
X-ME-Sender: <xms:6Iv0aknPcGH87UcLnfn8ocufm7Wy6WdG9O9m-TdljHr3ClVCphZJpQ>
    <xme:6Iv0amHcXTux9GOVHg9ieffuIW942UcLJAKN55D8IU-HWwIL4gDaGtRVO4-5PyTJU
    q7rmn34A8Ebs-eRs8hufAQMkXRU1GNCOxXvFF4p54xg5d05XLpLuw>
X-ME-Received: <xmr:6Iv0ak7Xpc3xUE8q4e3H9Y3kRKXZ5FiP3SIBJtTvsPEJweJo0zEth6d_4qdLFmP7KjzJfJ_NqgOs_7vTtl5z8jcQn-ka_uiZM78L>
X-ME-Proxy-Cause: dmFkZTFAheqyHMoGWso62AqH8WUDU0S4p19nmw3y1yk1IwlUSbIq75Bi7KUPat0vsIJ/Ys
    QMg8oOpFFJr1j/jbrUEq5jaCUSXxdYn8tLB193o+GRPOmJsYk1IEaidQI1vHEvmY59IyHN
    HBt4sDMrRGm9KsHpbJpz38B9G9nhsakHzpf+SbxQFrOZixhB26Mulss8bM309lZg0+MyeC
    nGEKhGHlwa5c17Mx18cKLDYGmvam9KRUZXqYnclooOUnOx9GJ69NuzDslMo7C17SmugmMT
    Q2ChnzEV2lckmCtkBsBx0/1GAdT0Ycu86WscL8y1Sp89ys2Ogk56adwSSRB1eiel+VTMnz
    eh1QBRt897Ka7dfgzrx0Ww3njkjAwM3o560n0lDhdCclR6DjNdZU+c/1oPt9pICV90PSvr
    xaJDBBJuXvr4YKL7nfr/9f5CtjGJOUj2u96/GuuAHTRhOtmLsmIIfnZ+A1aD68EhS5EOTK
    TNgLXKIeW8rDDZHld5cvmcqPABqhKEl0/AW7q5k9mqIZPBMrlePfoR8NhGNUtrS/j2kcUy
    yNMlE6AibmjtxBu+tkzhrrQnFQqhiPprUZd55Zizs/K4WnEOzqUC1UBVZjR2+GGJbSjTDX
    9tyJsF0A3QfEgK1ndaP3PP/fm+5g02FhUGuXdbtYf2vqNow9XlekfGakEDgA
X-ME-Proxy: <xmx:6Iv0amkupD13KMuIMKa2QdiNmqz6qt_zAGQMAtwI4N8pTa_cszB3Lw>
    <xmx:6Iv0ahrtGt8NStzqkMKCELIIaZtiug9MOXRT9fMDHUqKsAlay1O3uw>
    <xmx:6Iv0atuvwaGV4ckk4--QcKk1btqvBMBbR9zKrlKm5EVNfBrX9s-lig>
    <xmx:6Iv0auH9NF8XRqoDOfTbeTozRCaFE2Vv0l6WLHsf0khs-drWz3ZPIw>
    <xmx:6Iv0auK34FbhFqR9TPQi2gKvWlnuY-fJynhY4JVOEMnx0DjoM8RQr4rw>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 11 Nov 2026 10:38:16 -0500 (EST)
From: Junio C Hamano <gitster@pobox.com>
To: "Kristofer Karlsson via GitGitGadget" <gitgitgadget@gmail.com>
Cc: git@vger.kernel.org,  Patrick Steinhardt <ps@pks.im>,  Johannes Sixt
 <j6t@kdbg.org>,  Kristofer Karlsson <krka@spotify.com>,  Collin Funk
 <collin.funk1@gmail.com>
Subject: Re: [PATCH v3] t: add "test-tool genbytes" to avoid slow tr(1) on
 macOS
In-Reply-To: <pull.2301.v3.git.1794335168170.gitgitgadget@gmail.com>
	(Kristofer Karlsson via GitGitGadget's message of "Tue, 10 Nov 2026
	18:26:08 +0000")
References: <pull.2301.git.1794063565.gitgitgadget@gmail.com>
	<pull.2301.v3.git.1794335168170.gitgitgadget@gmail.com>
Date: Wed, 11 Nov 2026 07:38:14 -0800
Message-ID: <xmqqse17nztl.fsf@gitster.g>
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

"Kristofer Karlsson via GitGitGadget" <gitgitgadget@gmail.com>
writes:

> From: Kristofer Karlsson <krka@spotify.com>
>
> Several tests create fixture data consisting of a single repeated
> character with "test-tool genzeros <count> | tr '\000' <char>".  This
> works well on platforms where tr(1) is implemented efficiently.

This looks good as-is, but once we merge this down, we will find
that there is a new use of the pattern that pipes test-tool genzeros
into tr in t/t1600-index.sh recently merged as part of the Git
2.50.2 update.

Perhaps we should rebase to catch that callsite?

Thanks.

