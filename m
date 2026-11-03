Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=202.12.124.154
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793701411;
	b=OPlMOpdkwq3nIm7JD5MRjIDKxmqpPTFz/yeMgjxsinaQX7HvOR4mugdnuo/P/nfsEWW6
	 d6dFmOHxeEbpBt/kQOKvFUgfZ/BQkrvXx8M9ku90a0doA/GdHeJNUsdLbp36oJbPRthMO
	 cv3hJwLm4kgRgoNtTHbqUP1ryufZQJR0ja1cfluxzMgU5uo7KTUCLs8hoZz0NtEej6+if
	 +Y3mIkstG7yk0vmscAUONk3qtVlOcGjU2ARwL62vSyvhCNVlgPRCXdPxjKhTzAOm7a6sR
	 B9tWE3gZ4ou8Ws2vzbAEUU36d2h5UIo3VjIsmX0vpll60v2lRL1E/1g/9w7wKN1o/lg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793701411;
	h=DMARC-Filter:Received:Received:DKIM-Signature:DKIM-Signature:
	 X-DKIM2-Info:DKIM2-Signature:X-DKIM2-Info:Message-Instance:
	 X-ME-Sender:X-ME-Received:X-ME-Proxy-Cause:X-ME-Proxy:Feedback-ID:
	 Received:Received:Date:From:To:Cc:Subject:Message-ID:References:
	 MIME-Version:Content-Type:Content-Disposition:In-Reply-To;
	bh=4+DtNXJlW7VEt+iPXWbUDbZco7ck2uhWgTkIiJkxi/8=;
	b=u88XUu1aWBJRDv0/SgmQI2g+A5gPMUpO0qWwW8OVrt5jIAiZtaWqtrwaAFumxSeKilLv
	 kCXga3c+3u2eiVolIqSM0N4pH0kyx9XEdZ0YnxVqEnY1LhRUqCuSCg+Q2bjijl/xCzsJL
	 DhQ6wxpPMTHsUOVXti+scv163VFG1e52Z3++utL7QX5xR2Yrh7QwF0UVvuFqWsNLUe1Ts
	 Vtr+hMORqlMEzcmH1CY0SfWMbSFCFfDo6TA5yIAV08D5140NLUViXanf5rJBXGeyzEBP4
	 EJBA20XA5G7Tx0e17+zAyIsH4I0GTta0/xVDRGHFHcYLzxNPc/K3liLKvAYJwjr5P7w==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=pks.im;
	spf=pass smtp.mailfrom=pks.im;
	dkim=pass header.d=pks.im header.i=@pks.im header.a=rsa-sha256 header.s=fm3 header.b=ewK7ImZU;
	dkim=pass header.d=messagingengine.com header.i=@messagingengine.com header.a=rsa-sha256 header.s=fm3 header.b=qMGvKtVo;
	arc=none smtp.remote-ip=202.12.124.154
Received: from fhigh-b3-smtp.messagingengine.com (fhigh-b3-smtp.messagingengine.com [202.12.124.154])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3150C6083601
	for <git@vger.kernel.org>; Tue,  3 Nov 2026 10:23:30 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 3150C6083601
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=pks.im header.i=@pks.im header.a=rsa-sha256 header.s=fm3 header.b=ewK7ImZU;
	dkim=pass (2048-bit key, unprotected) header.d=messagingengine.com header.i=@messagingengine.com header.a=rsa-sha256 header.s=fm3 header.b=qMGvKtVo
Received: from phl-compute-07.internal (phl-compute-07.internal [10.202.2.47])
	by mailfhigh.stl.internal (Postfix) with ESMTP id 7BEB07A007F
	for <git@vger.kernel.org>; Tue,  3 Nov 2026 05:23:30 -0500 (EST)
Received: from phl-frontend-03 ([10.202.2.162])
  by phl-compute-07.internal (MEProxy); Tue, 03 Nov 2026 05:23:30 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1793701410; x=1793787810; bh=4+DtNXJlW7
	VEt+iPXWbUDbZco7ck2uhWgTkIiJkxi/8=; b=ewK7ImZUrnJw0+F1cWFBa1Ytio
	bdMYoEQKoZtmF697F4v2iXF+I61ql3uZ9pJ4tFQfRxsn6NU9WBR4BkP7BNaTmlXD
	O5Vnza9CwRd23K9A1+YHzEu51qEI9JFzXpg4ue+GsjtFAxbSZVcwA1IpbjmbSbYX
	bQbizayc/MQFwuD2qT/cRBXaSrjTGWWvfueLWVYcG4V/P6O8jPnkxLDDHHgEm00n
	xTIp+o8n4XcNK619k3SaTRsZ9lN61cuMjptPQV7wcYVQGo2SO9/zIrDMrM9j+f/c
	AZbYihBa3MuaiiX8Ro1/6tI4s+6b4ujgkPTCCOibc8wlyr+XugFi9woIP1KQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
	1793701410; x=1793787810; bh=4+DtNXJlW7VEt+iPXWbUDbZco7ck2uhWgTk
	IiJkxi/8=; b=qMGvKtVo6/Mt3bcKseDff40Plj7Ww96dxdn+/eEb/Kmeyefp/UC
	oVDPq7TnQ6Zbdn9maq/Fiu8+LbbtfS+7LN38JwIRsN4FSfU0WtCUBKTVGZShaqDS
	1D2JJZzTSEBP8l0CzqarFPoXbYbN+UxZ+N+gMf27ckvqfbyEuWsaXh+d+ERS/g4s
	6YRFRSC4qGM0TYMnWfGQPEEWFirIHQoLw8YHMkM93LuPA7IcdstgOqL21JGY07iz
	CRogqkkk8gmjQscSFZtzUEfB2skaTRzzvu0J+MlQClJ8nX1ncUFg6AijpkECadkN
	7kbm7e8yI/Gu9c8Ht1RXrdFuHcX0gmgqf8g==
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-08;
	repo=github.com/dkim2wg/interop; date=2026-10-28; sw=lmtpprox;
	action=sign d=pks.im a=rsa-sha256;
DKIM2-Signature: i=1; m=1; t=1793701410; d=pks.im; mf=PHBzQHBrcy5pbT4=;
	rt=PGdpdEB2Z2VyLmtlcm5lbC5vcmc+;
	s=fm3:rsa-sha256:ojk56Hl/DcZIh6fUrh7qhvn+NlPbe3jYiOqydbTNpolxXzK
	jfX/mKypSioI14h1CaQLXSlwFH2LG41GTX8wODZVxkKgn/BZAYB7NUioeTY/j7Hd
	lWLOTWXqGY/W5+6N8HZNjLj2+CLHshS9AijrtkTxQuF1+AA6/zAgSpDKAfG33Z/H
	1CGuTPoxKaFz6BLlzRwR3QphLztDjUNAolz1cXMci39EauDFkGRqhhTMg7HaGzbH
	ByzranQ6fxbbfaUIE6rdD45vneNns//zwtwpc+3ZVSzs94sG9Yvp42B5dfoeipkh
	1NUozHDnZQY0rfxH77lXXG8O9Aw5FIrK0HB7jDg==;
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-08;
	repo=github.com/dkim2wg/interop; date=2026-10-28; sw=lmtpprox;
	action=mi-m=1; hc=12;
	hn=cc,content-disposition,content-type,date,feedback-id,from,
	in-reply-to,message-id,mime-version,references,subject,to;
Message-Instance: m=1; h=sha256:cXz8i8mzUGUQptShTdKbjiDo039crqXZ7TzmeFyghe0=:L6lGAP9I+LZvBZaQx2sahuItLilQuq3VwlUx3pKQFn8=;
X-ME-Sender: <xms:Irbpau95UzBCNDlgzpcw3nPk8Ed8VuDVNbZdb2DoO5TpmEu1JahuKw>
    <xme:IrbpaktE_xVo7tinmDRw7sirDSLST6I0wULhkN9Dgi3YOyX9dJe6oimcxt08RmBzH
    nmSbKB4IIdtxb3i8hvJJBg0C7hF6-QtP18KOxBnp4rBKM7VX5ua29w>
X-ME-Received: <xmr:IrbpahpseOjEWIoc6M1XlpoGSqbEkw_-3NDdebDeVoszEoq4Z_pteg>
X-ME-Proxy-Cause: dmFkZTEb/CAqrq5/mgKLN1ULDb1n2Rf43HVn0pgBRT/e3x9Gqy9o7Yv1uNaBeGTP2sEDpq
    j2E8cI0hguZuoMLeGr3wen43ZyPeuEAZr/9/7NYiVlKFAk62FcbPP1HZbXXcqJDbnkSX4z
    KyX82EUVabFdQEuznewHQ+M8P5qcLCm62DkvKFu4Y7Kmf+tqloUBxMniovPuupUVn8HeBG
    R7e7TyshBA4zj+1/lPVH83Yz1V+n3bV2X4BWi82dItWQouM49QA2fbvKXAC1PztAFZ5KB3
    +yJsZSdDmWGIZy0pbzS1w+BNJlABa3ER9Dr07lqMz1zoB/HfnJLd/PE0EPqPjvp/ixMQJR
    8KxIWpSQVCbenYULB9YTkUR2hsSjlSKpL2JSeU8mkm+yaUMNhyb17vOq5L6SStmKtCeLAf
    H6ISpsQfBkkPzh895WxjT7MuzHNF1EHLR9JeW4rDmLlzGaVTNy2p2yf3LK7oku6XxU+tS4
    YJ7kSbwteNx6cOTw4+hYEzl0H0T9PmcjfAnfWHlJ9uIzgKQEYeF6SkxsBEjhICJJzWxdmo
    tpQgDEHQm4YcO1ANl5+Oc15RUQDY8xr9NK+SRJeFpBmF6ThfHI/Krm4YoNMOgnGjHxYZZ9
    vQBvzD7enzdiDljG+Lb00rlUft2oeRs0sqVN4DRPO1fZ3CDNSvtGn9xAlBoQ
X-ME-Proxy: <xmx:IrbpahmsN4ht9Xo5hCWf29_rAeT4GjSget6ca0_Vj7FZ9UO_6tx42w>
    <xmx:Irbpalw6JUM2_uQTQwYJfVtUeK-ejZDAIbnOsczOle2vmWAIrxHYYw>
    <xmx:IrbpaplssDtuB_Cmev1e7MmKsC5dh6jhyJ1EbA8EXvXXlkVespAXlA>
    <xmx:IrbpaudlUJLtI354RqLNEjLUzPVEUztu09XcflDLQePCanTT-fNsHQ>
    <xmx:IrbpaqUrL_5XlvBzB5ESrkZWZnseHQnq6pLKs6TwGYxvHHwUWTFB2Pmg>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 3 Nov 2026 05:23:29 -0500 (EST)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id f8c4a47c (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Tue, 3 Nov 2026 10:23:28 +0000 (UTC)
Date: Tue, 3 Nov 2026 11:23:25 +0100
From: Patrick Steinhardt <ps@pks.im>
To: Junio C Hamano <gitster@pobox.com>
Cc: git@vger.kernel.org
Subject: Re: [PATCH 2/4] add -i: hide init/clear_add_i_state() functions
Message-ID: <aum2HcP3BlSDQCGJ@pks.im>
References: <20261030173956.585250-1-gitster@pobox.com>
 <20261030173956.585250-3-gitster@pobox.com>
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Post: <mailto:git@vger.kernel.org>
List-Help: <mailto:git+help@vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
List-Owner: <mailto:git+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20261030173956.585250-3-gitster@pobox.com>

On Fri, Oct 30, 2026 at 10:39:54AM -0700, Junio C Hamano wrote:
> The "add -i" machinery is encapsulated in run_add_i() function,
> which uses init_add_i_state() to initialize the machinery, does its
> thing, and clear_add_i_state() to tear it down.  External callers
> have no need to call anything other than run_add_i(), starting at
> d51b61f5da (add-patch: remove dependency on "add-interactive"
> subsystem, 2026-03-02) refactored the code paths involved.

This sentence reads a bit odd. Probably missing a "which"?

Patrick
