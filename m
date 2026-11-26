Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=202.12.124.158
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795733894;
	b=clOASjHXTJTGS7D+zlN7ftSdX5X+WWtfwBYKqR/0oepHaPTupOJ2NkO2qGNpuqk0vKag
	 u0XX3P2IKm1UgTbHICT1+as9EEkI9vrZjBZVSKBc3f1ksO6qMDOXt6EZYfKnX+C0uqI48
	 F4ZQrKP0HzuYLao81iuYjTheKI6HtDVB0k1mxp5n4/y90NS15+UK9xjUCxFhYO3H9zVAR
	 B86QdmetxmLqaTWHNMUPrimu4OF/4iR6NRZTSvSdJcbfO2i3gQRn3ZEL4nybvhGozkcfa
	 ZPOsVfOosWQ1VLskYz+PKQftvXDHrtiWwbBq76j+3ofB9LkZ3g3Nv1RmcWKOMpJ56ZA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795733894;
	h=DMARC-Filter:Received:Received:DKIM-Signature:DKIM-Signature:
	 X-DKIM2-Info:DKIM2-Signature:X-DKIM2-Info:Message-Instance:
	 X-ME-Sender:X-ME-Received:X-ME-Proxy-Cause:X-ME-Proxy:Feedback-ID:
	 Received:From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 User-Agent:MIME-Version:Content-Type;
	bh=KR1nbYytN/N4sg8mQDngplm9wn/QnPTzZjYo7gKm5wk=;
	b=mTX6akgXXGW8/FrPQqTx7iwK0J/CR5/ZghkvSVHjasctE1Fgu88Sl+pQA5IKeYYBH9BO
	 z9J/T/RmUApC/y2gST/9NMWe+1nbiIF7ccOFn6G2cfBVUiDA9in8lXXuEp6rMw1Yd8mdg
	 xUlHz20Z8cK1D9hTisxnoGXYrOJFi2X34nVh/yCJD4c2lIjDxJC3z2eoaKeg8s/FZXRGS
	 A41IsMQeAvEVUwZRBbmzb1YhCEH9uZHlQctNfp/5Qu1GQaP3GMw/i/kq1YNzxraEfKtg5
	 HdFx/+KibE1eyjg5lrUIQ2P6GZf4rGyunCENW/vvTYKyMBzhp4fFZ8an+A3COxR4Hhw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=pobox.com;
	spf=pass smtp.mailfrom=pobox.com;
	dkim=pass header.d=pobox.com header.i=@pobox.com header.a=rsa-sha256 header.s=fm2 header.b=ajuN5aBK;
	dkim=pass header.d=messagingengine.com header.i=@messagingengine.com header.a=rsa-sha256 header.s=fm3 header.b=RU4fWWTN;
	arc=none smtp.remote-ip=202.12.124.158
Received: from fhigh-b7-smtp.messagingengine.com (fhigh-b7-smtp.messagingengine.com [202.12.124.158])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8DF7A606A31C
	for <git@vger.kernel.org>; Thu, 26 Nov 2026 22:58:13 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 8DF7A606A31C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=pobox.com header.i=@pobox.com header.a=rsa-sha256 header.s=fm2 header.b=ajuN5aBK;
	dkim=pass (2048-bit key, unprotected) header.d=messagingengine.com header.i=@messagingengine.com header.a=rsa-sha256 header.s=fm3 header.b=RU4fWWTN
Received: from phl-compute-06.internal (phl-compute-06.internal [10.202.2.46])
	by mailfhigh.stl.internal (Postfix) with ESMTP id B14817A032A
	for <git@vger.kernel.org>; Thu, 26 Nov 2026 17:58:12 -0500 (EST)
Received: from phl-frontend-01 ([10.202.2.160])
  by phl-compute-06.internal (MEProxy); Thu, 26 Nov 2026 17:58:12 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1795733892; x=1795820292; bh=KR1nbYytN/
	N4sg8mQDngplm9wn/QnPTzZjYo7gKm5wk=; b=ajuN5aBKxRbjss2PoEircgScks
	gPLT5DjdDlgCS/5r9v5hrFvbAEndbZ/QZz4rT+sVIsSTxRMfbHR1Rfrr4x54U3Hx
	mkaskSbm7SbSp4mYthM843hoVGHzoQnfr3Qe2zAbXrg1ilrmI0Hp6h2v2Jer/L4L
	HiG601h2FrrGIPO+KYDR3knPRdVU2GLIosQxXLU/I0/Yg+hSx/mI/QBuc5zfhEVe
	2HE9MBVnBbHZHJjG6hWvcK8nkgXaG7xbak7pInZ8O3+1IOwcw8hvjvahFFFhI7XF
	CeXVHHDuNRtf9pnrqYJ0/8Srgj+QteGRYHRNJoit8vxOL1SQ5wmaXV+dZR2A==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
	1795733892; x=1795820292; bh=KR1nbYytN/N4sg8mQDngplm9wn/QnPTzZjY
	o7gKm5wk=; b=RU4fWWTNKI+LalFBM/2H/tkGcFJYvmQ+IUMCCu7MiwH0UstCs+f
	TbLOlEEg2ebQ6Tp2rUwm/UjDfLgkLh996Co+VgpaLXWXFIfSp1trsDJrAuz4MO9m
	tgDpp4/l1jK3CJThbiYDduSTVftXrB/PWaU8IOIygblX42qEwpjjGtP4XQiBkdIZ
	8FCpnQdZHfNDub/EeUkOJCghJ8H8e0ZNPj4QnA2+PHZR1GrNJMrTM87t14DHj3Cj
	Y4OZhOwdh67YdNIgMNEU6cF6xGxz5CGAiny3buBvXh31xwk9CxB0rvGV29CF8Q9a
	N8jr0wgqVgQxWM5VSSqBQ0va+BoNYmLz0cA==
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-09;
	repo=github.com/dkim2wg/interop; date=2026-11-03; sw=lmtpprox;
	action=sign d=pobox.com a=rsa-sha256;
DKIM2-Signature: i=1; m=1; t=1795733892; d=pobox.com;
	mf=PGdpdHN0ZXJAcG9ib3guY29tPg==;
	rt=PGdpdEB2Z2VyLmtlcm5lbC5vcmc+;
	s=fm2:rsa-sha256:QDFtqcwzllLdfKH9rO9wL6Ux+zdjInUhSKf7O66ODEWEpB5
	J4vcbvkAzYYnF30E/+5bl0HxhqerfdiqM65akChvPWEykw65CWLy96jX0a7iAMf7
	fxu7B1OLcsiHqS6BRwbT2V9PvZjzAw9PH+77hPeT/bTxTxIzX2YUStYeaRUr1+G3
	9a82JVob5FRqmBDeMg5vSo5ooDS/bMqQQ/Q5uAJefZSg+JGqfCBYCXNLymc3/GiL
	uCogmlTNXjx8++ytdjLx6KgsyiC1HwkGyVDIMAB1GURUg0ZXaXOtJrpIGRxnnuns
	xRYG47MAe9RN5otEt5y+r0cTT80HHxsR2d5ITFA==;
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-09;
	repo=github.com/dkim2wg/interop; date=2026-11-03; sw=lmtpprox;
	action=mi-m=1; hc=12;
	hn=cc,content-type,date,feedback-id,from,in-reply-to,message-id,
	mime-version,references,subject,to,user-agent;
Message-Instance: m=1; h=sha256:QGzn5YBph1uQ1LOHCSl9CYvdVRExKQb6rKBKhftq+yk=:GpBzTlkxwkAYYkl+jiMQmwE2+YLErQtAFKgT12xBk5c=;
X-ME-Sender: <xms:g7kIayAQnuFTfnh4mi-5beE3exb48P6ohFOyptAT-X4UedkPb14URg>
    <xme:g7kIa7mYsj5Mu3ew9DJwkaEvnNP6VBdN2UwTYafCCylewew5VJNpJDGx9sTsE2iaS
    tVXxAEsGONpZ-gy_OVm3tYqOrInPWpHqmRThxN9xH9XePyY-CL3>
X-ME-Received: <xmr:g7kIa7z6WfOX8zxydjBeiQYstn08drzWEC2cQ-vMjc1FZGXknNrwAWEsAKvW2gPDA5D83eTKibrs5HS0Taysi3IHVF-ciUZjIwR9c4w>
X-ME-Proxy-Cause: dmFkZTFpfltFlca5wkZaROt6JdiSYy4fOaWiaEVhTfWDoW7AlqixJQAeAYSXBKbcZh0xxD
    wNmEqqPGZgzxR1uAxgKnz+WP2AR6dEHHj1jcKMyEN8kVR4fE6FoPfX8uMKtT1CSP1OrS07
    y5pLQleIcJXwYEXK0GQZX7ivztW7VzfWdyCr3ZACYNdgpwrve5l0vevhwLfmR3Jfil5nfj
    ODs3bY2cPmhlneRUIAG4cSEEwo2Er4w/DKy4R7/fNl59PYdvY4FVTeirnoM4sjS6+Sy6nO
    CuYIkTP4F/bGS0d2VHhq8P1+81UGH+JzaURIRRI6qSRDgTGO/+YGyk55KA4LKju8lR3dkA
    NfQc68LRlzL+BlBzAZPMXt1Qjw5D+VhlytTvlp+/XRWN2FWyeR0iXyMWNVB4keY4a87ZIL
    asfVJnOH1pEH9kfyHDUJA1p3BtjX4Mm06AESs03pJGTv5CU8VRj+pNXyTZ7SEOPt71M9ws
    7B1lfaVFp6Z3tQys79F/fDN9URoSN+6TnbhPbzTiUcs6OArr42q214Yzp05eCfPK2SjvNj
    Qkylc0tGCdH+/A75bAU5RGT6la0xpCHitQYbwrSIhX7wL02RwXO5UYbAp0kgr3hfati9PR
    iPaXQbLHfejGIpj9X643YGURbh6wClbfUvcJDOb/6uLNW87PiKYLZZAXtfSw
X-ME-Proxy: <xmx:hLkIa9THzRboUVagwsSAI3hHk8tPM3qiHlqz4twxm6evXGLenhuaZQ>
    <xmx:hLkIa78b1c5KGDsLysqnyCt45R-jxiJ7jmlTMW36FGqZtoIOmI7m2A>
    <xmx:hLkIaztodp7UnVqFNPZaQPCFXwK4WZhKjmroRpD9QDSbXIwVmRGP1g>
    <xmx:hLkIa7OzNp1ntHuG9uKlzlL97QdoiYR4pNZe2C_srdZrIbuUMXiXeA>
    <xmx:hLkIa1O_LypwoDhMSFPxpmAGApO-7SpsYuaokUBwkuXJP9jmJETW3Ta6>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 26 Nov 2026 17:58:11 -0500 (EST)
From: Junio C Hamano <gitster@pobox.com>
To: "brian m. carlson" <sandals@crustytoothpaste.net>
Cc: Christian Couder <christian.couder@gmail.com>,  git@vger.kernel.org,
  Patrick Steinhardt <ps@pks.im>,  Elijah Newren <newren@gmail.com>,  Jeff
 King <peff@peff.net>,  Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH v2 07/13] builtin: populate pack index v3 fields when
 indexing
In-Reply-To: <awiyY0v5pUnWm-Gd@fruit.crustytoothpaste.net> (brian m. carlson's
	message of "Thu, 26 Nov 2026 22:27:47 +0000")
References: <20261023072559.3204273-1-christian.couder@gmail.com>
	<20261023072559.3204273-8-christian.couder@gmail.com>
	<xmqq1p87i7t1.fsf@gitster.g>
	<awiyY0v5pUnWm-Gd@fruit.crustytoothpaste.net>
Date: Thu, 26 Nov 2026 14:58:10 -0800
Message-ID: <xmqqv75jgpz1.fsf@gitster.g>
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

"brian m. carlson" <sandals@crustytoothpaste.net> writes:

> I believe a later patch in the series will force v3 when there's a
> compatibility algorithm in use.  This is much like SHA-256 bundles
> always use bundle v3 since v2 can't express the hash algorithm in use.

That makes sense.  Thanks for a clarification.
