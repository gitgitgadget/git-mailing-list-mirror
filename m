Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=202.12.124.149
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794811171;
	b=z3aBTzVxBUoT6ArjWxupm5v0tfXH6/IAc4csJ5wgm/wsf9OcGAbNErrlfzBpos4xKRfv
	 QGhO6L095fGR1p6/1xmFRj8yIJBKaQZrhEEwP0RFOuuEhtVbZ8rx/6vZWC8ILyy4gxNiO
	 LD2Qos5qPzPTbnljvAEH2+nhKq8fTM2pU9r6kNsKgBSPSFnDhD35ozKVRYHlZos/SxcGp
	 /JIhaEPxCUiNuxgyj5MXxxPioSFQlE7B1ZG1VVfmqTr2Kp8Y8rS9XKRirGMlm3gR+fKEE
	 NSMfp1hAd+IXATmYvs9SQYIMfP8jxEYYZ5eel8gQaoqubw3mcUD7qfjWXkIPZHKFtnQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794811171;
	h=DMARC-Filter:Received:Received:DKIM-Signature:DKIM-Signature:
	 X-DKIM2-Info:DKIM2-Signature:X-DKIM2-Info:Message-Instance:
	 X-ME-Sender:X-ME-Received:X-ME-Proxy-Cause:X-ME-Proxy:Feedback-ID:
	 Received:Received:Date:From:To:Cc:Subject:Message-ID:References:
	 MIME-Version:Content-Type:Content-Disposition:
	 Content-Transfer-Encoding:In-Reply-To;
	bh=GaFdp3vKrLn+Am8gqwDmv1LRfFR5IWw25YLcC6Cxpk8=;
	b=KWciRsT87muJT7TEiz2RISlZzGEeu+GzwveRlhcahizTd23ovqC90GnPXwiFiQxtrIcl
	 I55rxcDyoXkdf4573Wxp+R0eKGdVYgmz/FWmZofnjTLbHf26WiZAxLpmqiXrDyia9v+TT
	 RkDhTkizV8xAngYBjPNawb8RhY1gZTwuWM81lpb4REbFdhNfO0xSuMneyEAGgsHcAKQ5H
	 NFDL1JHDY8pAbbysj9kUm7Oxizd5RmxOb/D5/Hr49MbWg4hTqZ1TFGFg8p6ZuQVSO3IUr
	 AB8BTCWtPJYQGDlk17fT/QCyX9bpDMtHxXdUSDxULmYzBkriVKu1vkkSp72Rn0DX8Zw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=pks.im;
	spf=pass smtp.mailfrom=pks.im;
	dkim=pass header.d=pks.im header.i=@pks.im header.a=rsa-sha256 header.s=fm3 header.b=e3DQ0YeD;
	dkim=pass header.d=messagingengine.com header.i=@messagingengine.com header.a=rsa-sha256 header.s=fm3 header.b="c/II5vPs";
	arc=none smtp.remote-ip=202.12.124.149
Received: from fout-b6-smtp.messagingengine.com (fout-b6-smtp.messagingengine.com [202.12.124.149])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3EBCE606A339
	for <git@vger.kernel.org>; Mon, 16 Nov 2026 06:39:31 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 3EBCE606A339
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=pks.im header.i=@pks.im header.a=rsa-sha256 header.s=fm3 header.b=e3DQ0YeD;
	dkim=pass (2048-bit key, unprotected) header.d=messagingengine.com header.i=@messagingengine.com header.a=rsa-sha256 header.s=fm3 header.b=c/II5vPs
Received: from phl-compute-11.internal (phl-compute-11.internal [10.202.2.51])
	by mailfout.stl.internal (Postfix) with ESMTP id 51F1C1D000B6
	for <git@vger.kernel.org>; Mon, 16 Nov 2026 01:39:30 -0500 (EST)
Received: from phl-frontend-03 ([10.202.2.162])
  by phl-compute-11.internal (MEProxy); Mon, 16 Nov 2026 01:39:30 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm3; t=1794811170;
	 x=1794897570; bh=GaFdp3vKrLn+Am8gqwDmv1LRfFR5IWw25YLcC6Cxpk8=; b=
	e3DQ0YeDqvuUi1JJ73nffP1hlLB9lYljyiyui0E/wsCcvPt549s6F+BSQrGN+CLO
	sMBQbU9wFzg1UqNzgsL9dQbdVp1mkl9JV7zQmUuKWe4sDzOyT12FA4z9XfairM+w
	TMv3ztB9LTFAdNwm9T/UcGwp/v09Iwy8SowJ544vesxPqmLob7hOo46ygxk5FIOJ
	bAODDtMo6Io+Csx91dRjF86ELiWh9iJ43z07IEBWCSebjyiWByNQi/EAatGsgin/
	dTIJXlCGSOmOqjmoJfm+bcvjksFCCtkMN4o9Rl/oYffnk/uoVl7N+PyacrNPkciN
	iBVyaB0QlxFxV0hyjfKVxg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1794811170; x=
	1794897570; bh=GaFdp3vKrLn+Am8gqwDmv1LRfFR5IWw25YLcC6Cxpk8=; b=c
	/II5vPsMgfsFKfxqOHFuQ7fB3D3v4K3VBcVcSliZ1lojAnGsDz9/Odi65wNLP7c1
	78oHbjbc7yoISqJpnNforo5HgxygH0Yu4zRX2VCxgO8vDBk4MERaWfg6LJlje/Ul
	5YDI86dgxukogj32sPLXl6LJm8RgNj2p/ZUTdxf/o5VltVbtpJZ9VPzngPLwyZ5X
	drMmojaObrzQckZSzpUmVmbmJoI0PfhUeeMImLb+MEi289NA/Nh5vXAQJ9Qymcob
	FRaAkiGZHT6D8Hvv9lpiDcAmoHeHNd8Cqfjza0dKXMKOCWVM6aAOpL2FR7DG9aY0
	GhyLXWku9vaAnAAz8biHA==
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-09;
	repo=github.com/dkim2wg/interop; date=2026-11-03; sw=lmtpprox;
	action=sign d=pks.im a=rsa-sha256;
DKIM2-Signature: i=1; m=1; t=1794811170; d=pks.im; mf=PHBzQHBrcy5pbT4=;
	rt=PGdpdEB2Z2VyLmtlcm5lbC5vcmc+;
	s=fm3:rsa-sha256:ue5TOxFXxOWyUqnHmlUFuo6HSqLs2EC/NqTP8pc/gTBVm/3
	kev0YsGX6jo9FBSMdGY/GbM4IPftjw4UQA94zDhgDVumhlpeGhJ2qCfn3/V+H9XY
	vpJC7z+IXmvw41XLzA7l5/TBCGOqac2Suau3iyM6OomWkFqTaodugJp5yPSHYL4V
	uty2mHUOHOoKvjklXgHIxFzJ3nO76eebg5/We+sgbM725Mwa5HK5JtqeghTu9jvR
	DJCb2DqKi99RJ1zP65Y005X7FaqhEHCsrAvwAbhsCWEN2MHYviA7MWYWgg6C6I3g
	jWO5bTt/xcSs86y1oL0WSCSU5FKqQ2WO1Ny5u1Q==;
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-09;
	repo=github.com/dkim2wg/interop; date=2026-11-03; sw=lmtpprox;
	action=mi-m=1; hc=13;
	hn=cc,content-disposition,content-transfer-encoding,
	content-type,date,feedback-id,from,in-reply-to,message-id,
	mime-version,references,subject,to;
Message-Instance: m=1; h=sha256:BEKQucsnHzwSGS2Mbi82zDCt/wSpsZcTY8E8NkNEzB8=:a65WhtTGrr3l96TejR9VlLdBR5VGevtTfYsxr2ACnXA=;
X-ME-Sender: <xms:IaX6auQpFG8Wygl5Kl0gqLDQMYyuCkAHgp9PWWld2_TuHA5o8esqkg>
    <xme:IaX6apxN_JfgvK7ST-za5twUFT6nNS93BUe3m-8lEqM3dqIDMotCQWH6NR7WP9y7D
    p2-idFkrMZNQTf8mVZ9_GYZp-M97DUa7hbPNGBByNWuCKEHsEccc6KA>
X-ME-Received: <xmr:IaX6apcpQGyDCM1_pCcEFHS-uln-Aoqs2e9VHC0jJRm7nFvtzNO42p1a6lJ4y82pwZU8VhE>
X-ME-Proxy-Cause: dmFkZTGYTH6U9olBBtqdXBlucXoOM5wmah81yxlwJN8t2dTUVjDZMlrIsqt5hHS2PJQ+jG
    VUEeqLq7t3tdsuBD61eZG3j/tNqXM8YISw/UTZK+SYh0DUjpg+y73vOKAgYd88bgF6SZCs
    s3ysb0exznPBuUckfWt+Y8O4NNX4xo+ufcYYNXxQMPKzwvpbrDNHcaV5kIHdpj7gh9TJxO
    5IUx/mO34dCou1g00kDVMKqLwXKyoH06J28fTfdKiN5zeKZrLc4WZCKiUecIMfCWqHbYvp
    Lcn/KBNisM5zbs67fHaQ6gFOI1oIkjn4P318a83k28Pey2u1iUyMt8jb+Lg8Cy8FmFicB0
    XYWFJbFASIRwUZt/33uNlq3WRIGbbXf6TGSYixghP3vS4XPw5+kyo3Y8wwKn5PyjS1Tg9w
    szYg9aWrzQ44eRomMKgoPnHJS/UHxmw9mcqtIconiZ7l1Ttp2fmwTw4WHVg5JJP0OPEDno
    DOkKz5L6D87IFW6A8Pt5LW1YEm45rzZtCOWJbM578HxuZyMfShi/RgoY/Dd42oQ66zRl7L
    8kgLeDOR03zRCFBt0RQvCYk373XwKhkj8XHNEqBoNZmJLZ31GF12QqZBKcLEM1Ey3lB//3
    xMVeuDsKliYbi8q41KodD1Rs5SAw6q12TIZVs1PlJxozjgfaB0cG6Rg6RdPg
X-ME-Proxy: <xmx:IaX6alKovS2oenhdvlNRNuHuA0aBfYZ8AJEXnQ-WxMgBmOR6NusCQg>
    <xmx:IaX6aqHUWBAWF-bdaoWUSZm-MrcKLtpZUY7H5EzN_WASPL6bFRmDqg>
    <xmx:IaX6avoZ3wQamNfUms_HcxpQfFA6KRqilSlcL1xCsNstg6EaerAunw>
    <xmx:IaX6ajReYR5TZCfYNhNoSnlXBAx8XV1R3Sf94udwvYq-HfHT8npmVg>
    <xmx:IqX6atgXhkJJFv58XxgL3Lyr4P0wfi_xizOoyS9TfNt7mScTacSO_loH>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 16 Nov 2026 01:39:29 -0500 (EST)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id 69f0d39f (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Mon, 16 Nov 2026 06:39:28 +0000 (UTC)
Date: Mon, 16 Nov 2026 07:39:24 +0100
From: Patrick Steinhardt <ps@pks.im>
To: Kristofer Karlsson <krka@spotify.com>
Cc: git@vger.kernel.org
Subject: Re: [PATCH 2/2] builtin/repo: don't fully parse trees
Message-ID: <avqlHHo36SDmupF6@pks.im>
References: <20261113-pks-repo-count-objects-speedup-v1-0-7ba4f29e74fb@pks.im>
 <20261113-pks-repo-count-objects-speedup-v1-2-7ba4f29e74fb@pks.im>
 <CAL71e4PscLozeuQbwNePkgn=QdDPhE1zqTtuGahnKWDN++B0Hw@mail.gmail.com>
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Post: <mailto:git@vger.kernel.org>
List-Help: <mailto:git+help@vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
List-Owner: <mailto:git+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAL71e4PscLozeuQbwNePkgn=QdDPhE1zqTtuGahnKWDN++B0Hw@mail.gmail.com>

On Fri, Nov 13, 2026 at 03:15:16PM +0100, Kristofer Karlsson wrote:
> On Fri, 13 Nov 2026 at 14:06, Patrick Steinhardt <ps@pks.im> wrote:
> >
> >   Benchmark 1: ./git repo structure (commit = HEAD~) (10 runs)
> >                   mean     ±       σ          min     …     max
> >     Wall Time    9.635 s   ±   0.072 s      9.534 s   …   9.799 s
> >     Memory         3.4 GiB ±     0.0 GiB      3.4 GiB …     3.4 GiB
> >
> >   Benchmark 2: ./git repo structure (commit = HEAD) (10 runs)
> >                   mean     ±       σ          min     …     max
> >     Wall Time    7.676 s   ±   0.106 s      7.568 s   …   7.823 s            -20.3%
> >     Memory         0.7 GiB ±     0.0 GiB      0.7 GiB …     0.7 GiB          -80.4%  (5.1x less)
> 
> That's quite a nice memory reduction!
> 
> > But besides the speedup, the bigger win here is that we no longer keep
> > these parsed trees in memory at all, which translates in a significant
> > reduction in peak memory usage.
> 
> I took a look at this since it is very similar to what I
> recently did for the incremental connectivity check, where
> the tree verifier also reads raw tree buffers instead of
> going through parse_object_buffer(), for the same memory
> reasons (I only needed to track the oids, not the full objects).
> 
> Both patches look good to me.

Thanks for your review!

Patrick
