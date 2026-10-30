Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=202.12.124.144
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793341214;
	b=22ekWX4HxuXWxWW1Snw3jcHzoc0eNkxJDQ3DsTO9keQYIOSc6pKIkMIkmq+EfodjlJ1m
	 s4WH82Zs7QzRxXylIgKIKq5IDC5TgV8ZK8+AgeGxWGM00GCHxFQTr7/jbxGTyUQaEbLNv
	 VTKarwayGl5Z10ryiOf6ntN8DDE2lCHYewuTHgm/IqSzu5h3jHyW/hLuUDofHbhAVM7pS
	 9LFDngxvDJdGMdvngdDGCu+3n8DNY2xoZPikuZzHzqt+ZooVoXcwUd02QBafWwtSusGVr
	 0yclDzJ4sbmJmF8Vf9c5W/mXspygxWx9sU+Pi1QnFv1zAa0iHOvxpVk6rdmOOuhReBQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793341214;
	h=DMARC-Filter:Received:Received:DKIM-Signature:DKIM-Signature:
	 X-DKIM2-Info:DKIM2-Signature:X-DKIM2-Info:Message-Instance:
	 X-ME-Sender:X-ME-Received:X-ME-Proxy-Cause:X-ME-Proxy:Feedback-ID:
	 Received:Received:Date:From:To:Cc:Subject:Message-ID:References:
	 MIME-Version:Content-Type:Content-Disposition:In-Reply-To;
	bh=0I2Tk4UbJxFRiSIZXtFnBHZSDJgi4W+8ac2b8hTN5pw=;
	b=mA4QZTqgu/joGIRtE8jHesOneK5ZdfQEkBgUutX50jWbP37zdLf3dxB+cDL2YgVBiqr8
	 xt/x5MvZORw8V2rcOFXAJLsrsMMnTiMeonyEZClHGL0SloJRhwImoLuPSlcFUt3aRA/Nl
	 VmYFapMdzb/BbnUgzimft0KJQq3szKiUkr5UaJuTei4hyj4xVhA82ZZ3CyVt4SUcpRjan
	 n1fLbqgHopg/FBntv9Stw0yw+OKKGg73WAKfaECvFBF8wFnZF/yVJEjuAWCuwmw7jXfOO
	 x8wYYeM0g7O+7wGT2CFvrbx2kbDvSf45MXu3+pj9+jPCMFPBoqL74JtJacGoJ7yBDiA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=pks.im;
	spf=pass smtp.mailfrom=pks.im;
	dkim=pass header.d=pks.im header.i=@pks.im header.a=rsa-sha256 header.s=fm2 header.b=uNao+JL2;
	dkim=pass header.d=messagingengine.com header.i=@messagingengine.com header.a=rsa-sha256 header.s=fm2 header.b=MJk7YhQa;
	arc=none smtp.remote-ip=202.12.124.144
Received: from fout-b1-smtp.messagingengine.com (fout-b1-smtp.messagingengine.com [202.12.124.144])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3A50F606A31A
	for <git@vger.kernel.org>; Fri, 30 Oct 2026 06:20:12 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 3A50F606A31A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=pks.im header.i=@pks.im header.a=rsa-sha256 header.s=fm2 header.b=uNao+JL2;
	dkim=pass (2048-bit key, unprotected) header.d=messagingengine.com header.i=@messagingengine.com header.a=rsa-sha256 header.s=fm2 header.b=MJk7YhQa
Received: from phl-compute-05.internal (phl-compute-05.internal [10.202.2.45])
	by mailfout.stl.internal (Postfix) with ESMTP id 3713F1D0016D
	for <git@vger.kernel.org>; Fri, 30 Oct 2026 02:20:12 -0400 (EDT)
Received: from phl-frontend-03 ([10.202.2.162])
  by phl-compute-05.internal (MEProxy); Fri, 30 Oct 2026 02:20:12 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1793341211; x=1793427611; bh=0I2Tk4UbJx
	FRiSIZXtFnBHZSDJgi4W+8ac2b8hTN5pw=; b=uNao+JL2ZGQ9aBXw70DmwXUZ2o
	3qUGZZaTT/c6yGnvBORliPakALPAwG79VL/hw5rG7xxkujdob0Pwl7ST/JfjegD/
	RIZfzHDqo2bM8LsgHcjFpDaLVN5Gv6aiXDuXRW6njVaoPfxMy3fDw7PN069+0Drw
	gs8RzdHbXbXDDh/h3zilWAM1Y19ECrLvkvFKBP0NsWMSKAIbxrzVTlbY1+sum9sV
	HB0A9w8PiyixnqAC0WcrR1Pi5lYmxJ3h46apfqSVpAh6/SLhp6y4k3nCbEN8PiQu
	DYXhp/rq+g2bwbBiRgCGWG7zH/2SlJobgu0trpmvqeKlIZP4njihYvg5uEyQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=
	1793341211; x=1793427611; bh=0I2Tk4UbJxFRiSIZXtFnBHZSDJgi4W+8ac2
	b8hTN5pw=; b=MJk7YhQajbK+BypGxlgba676tVnt3qpoxc7h2ib2VPe9Alyf+z2
	JyKSD+W88Smzh0pMN4fUlA3xxRsl4zN+CTFMucNmajl4gPrQikN5CrNT/Ip/Zhr6
	Z8qTIef39n4ovAzz/VNdOYvV8hes9qFwb14ySAP4G1ajSYVc97KKPmlti2WTnQtJ
	sqLwkBEh2/vMbGiqN5h1FTPWNhOC16r+Tuut4EwfNMe/96xeKmzvh4ULMbx5wWM6
	ElPP1ONtwAwX/8A7sfxIXu9bVh1pDwAPq4XeS/dc42TZiXjYInylpWWK4EIvaQ+V
	0NgJ/UsjRD5rZt0ubDeXKfiU2Dx6SoTjnNA==
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-08;
	repo=github.com/dkim2wg/interop; date=2026-10-28; sw=lmtpprox;
	action=sign d=pks.im a=rsa-sha256;
DKIM2-Signature: i=1; m=1; t=1793341211; d=pks.im; mf=PHBzQHBrcy5pbT4=;
	rt=PGdpdEB2Z2VyLmtlcm5lbC5vcmc+;
	s=fm2:rsa-sha256:JQrZUplq6t5wooCB00HJxwVf/oaPoqOH07mbe5FNmEqoRX5
	dhL1ilebxksSiz6SB1F/VB+cjTm2q5FeqjZSvCvEUfRx5pUt9f4p1vKcXUEP/WXB
	FPnd9HB1bJNm8+/Of69rhosrmdtTN01tbREZwa5ZHSi1NZhxTRK6zFqVDVR8FZJv
	eCn5wkUvr1xAwmuKnmLNnMhp+bKtiVgfWcDhzOYP5B4Q4qbQl8CrR/SqM+p1zQxB
	tbNA62/WyyZzQbaPtFtbwaIQG/rsBWNPpJoudA8oB/xtKYzu2OX5nytdk+Zzy1Db
	F3Y6USls5YGhBaGdY0qcAcjgO39TuOg9eENGFTA==;
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-08;
	repo=github.com/dkim2wg/interop; date=2026-10-28; sw=lmtpprox;
	action=mi-m=1; hc=12;
	hn=cc,content-disposition,content-type,date,feedback-id,from,
	in-reply-to,message-id,mime-version,references,subject,to;
Message-Instance: m=1; h=sha256:7GL4Y/D3oRIi3gwt4UJYCCtjaLlY8vgKeg6lmHFCt/o=:dMmUn43Ua2+o3SCqvVLEY8K6gMZ6T99bWVyqedix23w=;
X-ME-Sender: <xms:GzfkausezNxbmnAcP-uElN3MjkoReoAUsbnwWT7YNhDk0a5EBgNl7Q>
    <xme:Gzfkapfr54kQ3Nv6gFWOrf6MYGBNMd49bsBlkKImz5mWJVE_3MoYKOYUyyB-9xvJ6
    Y_bEqyp2_5KoK0FY3lG3U-RcPnEHejd2MD7ytZGb9GsU_7jFAkWAhM>
X-ME-Received: <xmr:Gzfkanbv5Wpfyl_8S82oufCnVjry6Pd8QYUft_JR_ep-cFP7tUSrJksq7o41zoD4Dl4iQQ>
X-ME-Proxy-Cause: dmFkZTElL0oWRogpDMvPQiaETJYBWDPH20d2XXfJhbOY4Wa3UHcTF7412uhyjh1xlkGGAy
    jdIHd9c91b7b8YiS4Qh+nMYLP+Vag29GKrK8yPpqoijp6baBTQBVuGn443W02d1N90vCio
    YoZyFmOJJ2+hzhftkoZLVx+5DxFgB2CphnFTzyvrcbcVWj0GLmlD7yWpk5dl7UXVIvBwf0
    6Y2QkloIfQaGAuYUs5ilcsnBmdYTOS1rjTw5gfFPTQ6erNAg5oGNkMzBEFgkMKIPPpdnE0
    aAl/NgNhDExPUUOgMAhiHn18iyqLOzUDaF+BiCWYVz/TPWUM/Rg9/t3AeGJQjSeXdlpckY
    LioiOaAZRajBxVGDcZmQMjADA9z6lek6pQrybTvnKSBz5h7W6MyNZJwSShLzq2k1nxpv6k
    QEUp8ryHx3WdKidwm6d07VVdc0pw4svWV7kmQ4JtVhR+GTWDi3CNvuw2y5Bu8rn4VSsJGj
    HPEQFdy+Cy6/pWO/9xYFby0TgHI7mNMzLBOKxS0OxV5KH8yVZRoh9fECNthTax8VIvU5B9
    zwsXU10Zsvs8wegSH0Yu/OifNNHESftoBRd4utznaCB0DpX7Hnk//pqj94RbVHgVzLM4Bt
    CgvNdqcWTwAp+UHSAkzi80Tv4iOn98n/r5ULqJeZOQXZbA34ak8aK/XC+Bhg
X-ME-Proxy: <xmx:GzfkakVCrVWwbHNzpaDhjjt2ehwtvD-wzEQk22M7OiBK3eWfjnsaSw>
    <xmx:GzfkahizsfvzOV5_px7ormLml0AmHZv3eBZCGWgRDQZv3jlLxj7gfg>
    <xmx:GzfkaqW8SFlQDtxcbAGWTeVVsSYUM0zE9IA2bCpsVUHfad5yUbe2Gw>
    <xmx:GzfkagNDJTe-Izsqy5HRVCCZ5rPkZ8mUNmoTGl2zEyz4WfQ_4poc8w>
    <xmx:GzfkapfQHYzOnn57m87iyy8OwqjYym0xmTU-4XzOVreIbpQwJjU-YKFv>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 30 Oct 2026 02:20:11 -0400 (EDT)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id 0ef1baf7 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Fri, 30 Oct 2026 06:20:08 +0000 (UTC)
Date: Fri, 30 Oct 2026 07:20:05 +0100
From: Patrick Steinhardt <ps@pks.im>
To: Justin Tobler <jltobler@gmail.com>
Cc: git@vger.kernel.org
Subject: Re: [PATCH v3 0/4] loose: fix migrating "loose-object-idx" with
 batch fsync
Message-ID: <auQ3FTXbn1awcP70@pks.im>
References: <20261029002413.3291184-1-jltobler@gmail.com>
 <20261029232220.1245827-1-jltobler@gmail.com>
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
In-Reply-To: <20261029232220.1245827-1-jltobler@gmail.com>

On Thu, Oct 29, 2026 at 06:22:16PM -0500, Justin Tobler wrote:
> Changes since V2:
>   - Reading the src mapping file is now done prior to acquiring the lock
>     to reduce the critical window.
>   - Added a comment to `loose_object_idx_merge()` and updated some
>     commit messages to improve clarity.

The changes and range-diff both look exacty as expected, so I'm happy
with this version. Thanks!

Patrick
