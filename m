Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=202.12.124.149
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794810592;
	b=T3V839GE4Ol6U/vt/cI0lPDRF5FepjlcxZN5WdaMRGXmRPc5X83FtV36/Obn1ZSjjC6d
	 n2YKDTZ/UeDunjfsbq/2LUiEq2tvLprvAjFy9+HClyFJL0XONhx9i6m6EzwSdIU71nHWm
	 63QdStsBXCSZTf9qLHzwoWgJGVJuk355+guuNGkb8/4qNpxJFvjkVXlMQ6A/t1aiAc6e2
	 FlNWt6xKHMZlUVl9hrCh+6Ugurw5EkKcBMg0C4IbZ8XDwQeFkkIDMSoml7qfi9RDM3mbv
	 EHChCrbKUBUisVAlBpm5A2pIET/hWVmVdu+J6uA/OTx/WsjYaCdqYwUFgJCUV8Vyzew==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794810592;
	h=DMARC-Filter:Received:Received:DKIM-Signature:DKIM-Signature:
	 X-DKIM2-Info:DKIM2-Signature:X-DKIM2-Info:Message-Instance:
	 X-ME-Sender:X-ME-Received:X-ME-Proxy-Cause:X-ME-Proxy:Feedback-ID:
	 Received:Received:Date:From:To:Cc:Subject:Message-ID:References:
	 MIME-Version:Content-Type:Content-Disposition:In-Reply-To;
	bh=FhezGn0cDQZ6QKu22r+TvAqwgD0v7oENfYLuA7eO6sI=;
	b=dnfrbRFbbky3YnAquc145BRMeNOGFCat/xskPOZUzgtU2yvEy+u96Gr4hwJbTkUp9GDP
	 xMKalvHuElGlwtFtshCo59Fa4JYsVuZriRNUWpS2+HJkToV8jgTORQwp1O1XCQdOTi6AL
	 x0sSg09EBMWPlDwwYPGAE11yGLfn7KuWLXMqBM8IvDfc1vg43O24n+rv1BmHx/1y46Gnq
	 QxYQCzyqMBGIv5YSN0B6+pG8EjiUHM/dqwC7/xoSdTcHv+nyGE0f9ciGsU3MIYyjbSiGp
	 dgwm2eFa3nmTp8XYYgNhl2fIi/Y8ozu+/mDLlyGUCMfCsqXb2PhubmtMgUedVnWxaOg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=pks.im;
	spf=pass smtp.mailfrom=pks.im;
	dkim=pass header.d=pks.im header.i=@pks.im header.a=rsa-sha256 header.s=fm3 header.b=s38DH4U9;
	dkim=pass header.d=messagingengine.com header.i=@messagingengine.com header.a=rsa-sha256 header.s=fm3 header.b=ps6hFV8d;
	arc=none smtp.remote-ip=202.12.124.149
Received: from fout-b6-smtp.messagingengine.com (fout-b6-smtp.messagingengine.com [202.12.124.149])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CECA6606A32C
	for <git@vger.kernel.org>; Mon, 16 Nov 2026 06:29:51 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org CECA6606A32C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=pks.im header.i=@pks.im header.a=rsa-sha256 header.s=fm3 header.b=s38DH4U9;
	dkim=pass (2048-bit key, unprotected) header.d=messagingengine.com header.i=@messagingengine.com header.a=rsa-sha256 header.s=fm3 header.b=ps6hFV8d
Received: from phl-compute-03.internal (phl-compute-03.internal [10.202.2.43])
	by mailfout.stl.internal (Postfix) with ESMTP id 37BEC1D000FE
	for <git@vger.kernel.org>; Mon, 16 Nov 2026 01:29:51 -0500 (EST)
Received: from phl-frontend-03 ([10.202.2.162])
  by phl-compute-03.internal (MEProxy); Mon, 16 Nov 2026 01:29:51 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1794810591; x=1794896991; bh=FhezGn0cDQ
	Z6QKu22r+TvAqwgD0v7oENfYLuA7eO6sI=; b=s38DH4U9KUPvQYM1mS8hJoeUtE
	cD9KJflfcANmd2zMKX7+h3B570Cg7jmz3vEh4x6uMBjeVD1oIAF2uxd6DqI2FE79
	Jw54gLCoiJnzMbuuj9uwHU5rtXJ7RiVbWIzfMwGMRhy9GDppgoxPSuW7796l+GSX
	3yzR2A0C+LuUSOR3VEPyDMbY/ElvfgruQCtqNBHvxf6jQP0zmroS8LHEwP2fKnYu
	TINutBqvKD9TgUX0ZC8oirUhQFCbn66fev0/HtgUWN0kBXovUzGJdkhhdCVy2Ras
	u97vQ3Tj7FWRB73qtQPBOy2ZEVHd5/CmDZfdm4ErVQRTB8fCksLhG9ra6VYA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
	1794810591; x=1794896991; bh=FhezGn0cDQZ6QKu22r+TvAqwgD0v7oENfYL
	uA7eO6sI=; b=ps6hFV8d7GTF1qPSuj1ZrqqVyM7dCHUnppohOieRHSmka5zgh80
	cYcgdZAqUrQ3q7a6JKWO1GuLGkEmfLU6RWsdS6iPOm6otdm7Yo99zxTQKYV1tJlu
	veMBmgFMNHaIQv7lmZk/FUnsXk6VgPwUit8gIzdmftBwN45dee5OYRPtH6HAeQFl
	Is4gH3UU2XImKJ+VkpBaMCiE92FV+9vxnnxm3xHqlRY9pworiy76WN1WSYubYboZ
	uEwD6uGwT9la5xh05JRax/KOba5maLTbCWKLAVua57KMyaS/GnuULMFKWqeWMyAf
	otAqxRHBv6EfpgQSRbfFnLN8MsMGZdNeUqQ==
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-09;
	repo=github.com/dkim2wg/interop; date=2026-11-03; sw=lmtpprox;
	action=sign d=pks.im a=rsa-sha256;
DKIM2-Signature: i=1; m=1; t=1794810591; d=pks.im; mf=PHBzQHBrcy5pbT4=;
	rt=PGdpdEB2Z2VyLmtlcm5lbC5vcmc+;
	s=fm3:rsa-sha256:qKgVNY0BCCPLAzYKajuhceBuKiDDjGozrPiqWhz2KXW4kWi
	OXOofu9dkKidnVaJZYDt7H9mm6usi8sf0u9Quu8v5JsKIc2s+w7UmQbTcgM5/hVn
	kd1QnePGkxuXZ3sYqqhC5L9WTHVHp7imrLveVMPV8HIk9BoJBGRa07Y3/ztzHnPf
	wyrHbB84+joQxTz58lOw0mOG1nRqM8q0OzUAK/d6U+gxtU3upgb39OQSKoIdSnZp
	ktAjFXA2rNp+Hh3+gFCnEWa5IKgeVGjE11O7paUiIaxd9DK5eMU2UXzOPn/daBWM
	Lo2JJSBm4HZj5sJwmdPsCDJraPgdvkclw6jjluw==;
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-09;
	repo=github.com/dkim2wg/interop; date=2026-11-03; sw=lmtpprox;
	action=mi-m=1; hc=12;
	hn=cc,content-disposition,content-type,date,feedback-id,from,
	in-reply-to,message-id,mime-version,references,subject,to;
Message-Instance: m=1; h=sha256:ryc3tjc9LiZohziByiEb21E8foi/CtUIvCl4xgOhVMU=:SGjQgzYyfsEPvX4MLbOrKOA9jvIYZa7gzK5pJzcd69E=;
X-ME-Sender: <xms:3qL6avQv2xnacKC7OLn5yKMdY01WGP55R-I7Q_DSd0ThFzfd5IRgRw>
    <xme:3qL6aoOaKm6sMcYXDPHivbVW4TTh2xjYNqk3A4HZWswz-cJ_iTUyF7DpTC1XfWF0E
    SWiLbbIovkzTsLDC_B1Dh0SURsLkHpGOr8A7ZtwvL5rcIVQAKp86w>
X-ME-Received: <xmr:3qL6aiOEN26Zl-pnv4_SB-dHWDv5kHCprWG8EYVLo7NPizqvir13eJjL8iZRjSp9C_xT-ww>
X-ME-Proxy-Cause: dmFkZTEu1D9sI5+SphOh9uPoJWs7+5eMdNcAa0iPNHOvE4rPoPwrJmSdvucP7Sae4se1rJ
    iq3QLPc4QhWI4REpfyT1k9CM4UdItyZPCbAmoLEj0cc2XaXEup2BeSpEzwtlXndBkdMjjy
    QTul69rWdT8sk8TBkQxZ/dZyjrpRA2h20LkNVo4Z86rnx20V69bMFwbs+25hp7wYfhlyvU
    VOr/y3LtCsek3fJ49kGW3Pzj7S07zDzlPma4CkK8FJMMFhrAB3/EOyUMnkJ7tjvCtGiE2m
    7qTv+CLhGWHcYFriT9cCdFaBYzTFeJkA/P1xWJoliGWr2ZSyggp7YYDquEeZipOI6XAqlf
    u8skjOnWJwUV5LjxR14ZEb9dQhU4FJ47ePcPCe6hirtHBuoEg8CMTeNxMjYiFYZMkUyWCQ
    ZNhSS+hfKh8mRPqR4qnzHoGPu/BR9XRcBIwGtyjRG42awRzy75FL9RdY8uRFCjlJa160ZS
    Gjq4N8mPOmZ9T2EUq70S8yCA0GTmWfu7hLpycRo6jSJ5YJSedUe7Nlp2Qva8pHm0ZGiJa5
    riaNOyv8r8f9Y/wTuXJ0dLrw/YcQsJ4nyX0I0WTuS8zc7mBSryO7G/jb3bt7Vx0mqDhntP
    6v6d1MAjE9RG8cIUiW3oSJ2oYB+Zmd4PaEdEPkKBLnmkqXdQZBNGDFru5mBw
X-ME-Proxy: <xmx:3qL6aos4aeHFbNQrSxb276c9OLt-e4EhV8M6xN8dtiQxW1TjE9pPIQ>
    <xmx:3qL6asVwH5fPfIdG1b0I50IgyUP3bjAhkTenTs4BDqC3uPZoroXFLg>
    <xmx:3qL6aguD4W3o7BCNh-eFbv8txPO4JHpFeeSM8n4pDMO7qtNTOfisKA>
    <xmx:3qL6aoW3tyoKg6SbxnvQTNx-MKNmdx0aGi9ecdndtN1T7tqx1qUuqg>
    <xmx:36L6ai4XXgUMCFKjl3YDbFcru30sjO6Ni69T968BHT2MUz3h8yuPilrQ>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 16 Nov 2026 01:29:50 -0500 (EST)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id ee5dde17 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Mon, 16 Nov 2026 06:29:48 +0000 (UTC)
Date: Mon, 16 Nov 2026 07:29:44 +0100
From: Patrick Steinhardt <ps@pks.im>
To: yusuke8h@gmail.com
Cc: git@vger.kernel.org, Jeff King <peff@peff.net>
Subject: Re: [PATCH v2] http-backend: drop strbuf pre-sizing from
 get_info_packs()
Message-ID: <avqi2Jpd-QT5iNU9@pks.im>
References: <20261113-http-backend-drop-strbuf-presizing-v1-1-7d66aae03b22@gmail.com>
 <20261115-http-backend-drop-strbuf-presizing-v2-1-b7ffe1be4482@gmail.com>
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
In-Reply-To: <20261115-http-backend-drop-strbuf-presizing-v2-1-b7ffe1be4482@gmail.com>

On Sun, Nov 15, 2026 at 09:58:47AM +0000, Yusuke Hayashi via B4 Relay wrote:
> From: Yusuke Hayashi <yusuke8h@gmail.com>
> 
> `get_info_packs()` iterates over all packs in the repository to count
> local packs, calls `strbuf_grow(&buf, cnt * 53 + 2)`, and then iterates
> over the packs a second time to format each entry with `strbuf_addf()`.
> This pre-sizing dates back to 2f4038ab33 (Git-aware CGI to provide dumb
> HTTP transport, 2009-10-30): `53` assumes the length of a SHA-1
> "P pack-<hex>.pack\n" line (under-counting the 77-byte lines in SHA-256
> repositories), and `cnt * 53 + 2` uses unchecked arithmetic.
> 
> Rather than fixing the size calculation with `the_hash_algo->hexsz` and
> `st_mult()` / `st_add()`, drop the pre-sizing altogether.
> `get_info_packs()` is a one-shot CGI handler for dumb HTTP
> `/objects/info/packs` requests that formats a single response and exits.
> A typical repository only has a few dozen packs (a few kilobytes of
> output), and even with thousands of packs `strbuf`'s geometric growth
> only performs a couple dozen reallocations. That cost is negligible next
> to CGI startup, scanning `objects/pack` to populate the pack list, and
> writing the HTTP response, whereas computing `cnt` up front requires an
> extra pass over the pack list.

Yeah, that's a much more convincing message. The other angle that this
is missing a bit is that giving a size hint ensures that we allocate
exactly as many bytes as we need. But that shouldn't matter in the
general case, and if you have to allocate gigabytes of memory to store
the list of packfiles... well, then you really have bigger problems to
worry about.

So I think this version is good enough, thanks!

Patrick
