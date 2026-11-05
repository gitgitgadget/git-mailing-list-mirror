Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=103.168.172.153
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793915573;
	b=M3cmmd/UPfWKmbbY1EALICTvkMoVQaBkdFXV7DowGEfdESX9sg9TInjxlHnz6xLg351Z
	 nENBI7MhIVCMOvjUdMowxo4A3WdMwVRk+zmmPiXzqZC94vTKT5GlVn7J8g1GP7nOtYOR9
	 6EniWJrj1ewLjLDXV62qpYAM0Z+/ZRJPBNWJidcxMCR6Z0uwWaC6lKFUb8paFfjqE04Qs
	 nLK3ftsRqHLq1X6ErquGe3pD2Ghm0JN2jmDGFiUnd7Xe8BojJv2F3GB2jia6Q7/JWLILV
	 t0FZYYEcn+K7urb7ESwucmZtfICgF521Rznxos9n2bv6kiwh1+dsf970stXItkG1jTQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793915573;
	h=DMARC-Filter:Received:Received:DKIM-Signature:DKIM-Signature:
	 X-DKIM2-Info:DKIM2-Signature:X-DKIM2-Info:Message-Instance:
	 X-ME-Sender:X-ME-Received:X-ME-Proxy-Cause:X-ME-Proxy:Feedback-ID:
	 Received:From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 User-Agent:MIME-Version:Content-Type;
	bh=yYp0DXb4RExqzSgygZN4nVfe7SMnVnNiGD4rK6vIP44=;
	b=l9zguyl76ZNY4Ws5eJ4rjDzxQmQ4SRDrxaa55f5PXvcdMDXIh4vLUTVHznVo9qdVR2OJ
	 JfGVNy95iNAE9DVZ7ikuTIzUj0KYeJ3So661yx2wgAuB9+NaeOksESep8Bz0ccNeR/ygS
	 JqkwlAI42RdBsBCxwUdF0JrG2C8iAeg6PG3Sv6xoNffUNpyizF6A1E3iG4T8bbGeYULMP
	 4IvvRztO9C0YhPGaczlUQ3poWhP7supNxa8bP5UP+3GZOF3KIW3tj27FYaWGVD5AtcL1X
	 3FF1AqOvuNOIHEevxd8yl0N9JK8JXYX9N638feblpiLY3dy4W/+DN5+93H/5eW6lgvQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=pobox.com;
	spf=pass smtp.mailfrom=pobox.com;
	dkim=pass header.d=pobox.com header.i=@pobox.com header.a=rsa-sha256 header.s=fm2 header.b=Xh4qzlsJ;
	dkim=pass header.d=messagingengine.com header.i=@messagingengine.com header.a=rsa-sha256 header.s=fm3 header.b=vzXzZWjW;
	arc=none smtp.remote-ip=103.168.172.153
Received: from fhigh-a2-smtp.messagingengine.com (fhigh-a2-smtp.messagingengine.com [103.168.172.153])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C659B606A31B
	for <git@vger.kernel.org>; Thu,  5 Nov 2026 21:52:52 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org C659B606A31B
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=pobox.com header.i=@pobox.com header.a=rsa-sha256 header.s=fm2 header.b=Xh4qzlsJ;
	dkim=pass (2048-bit key, unprotected) header.d=messagingengine.com header.i=@messagingengine.com header.a=rsa-sha256 header.s=fm3 header.b=vzXzZWjW
Received: from phl-compute-04.internal (phl-compute-04.internal [10.202.2.44])
	by mailfhigh.phl.internal (Postfix) with ESMTP id ACF12140013E
	for <git@vger.kernel.org>; Thu,  5 Nov 2026 16:52:51 -0500 (EST)
Received: from phl-frontend-02 ([10.202.2.161])
  by phl-compute-04.internal (MEProxy); Thu, 05 Nov 2026 16:52:51 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1793915571; x=1794001971; bh=yYp0DXb4RE
	xqzSgygZN4nVfe7SMnVnNiGD4rK6vIP44=; b=Xh4qzlsJDy3iafYWQ/Vj1uS37D
	tsJCh4k4/vrEHER7P3UAT3I2LU8fu14EXhXmj4boIDcRkq9B1e88REhX+rRIRzRY
	C/XCjnRi3ACzxAPVaewR0Tl7GDI5AdDfp0Sy7niuD0aXf4ViH7bPXM7XBfOtUPwv
	0JDQlwVuZh8q+ltZ7Eysk7rJp0ji/ObIjH7Sh2/wFQnLA/mTB0+XB4TnvsUDiPes
	fbZxEEpIVXg8X7l707/bTeUtjsO+Lgd7qI9K+KtRsQ2BLxxS84egfphYF2N076v6
	JDkxLEvj2nMbVxcIIa7XHWROqzHQ91roiZwbWsSWPByeC3/D7IQGxNDoGdAw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
	1793915571; x=1794001971; bh=yYp0DXb4RExqzSgygZN4nVfe7SMnVnNiGD4
	rK6vIP44=; b=vzXzZWjWyn6UO57KiIroz6iWtF8XVAeox3+6+ZEO5TeVarmZz98
	vmFn6ldPU+dAAkE9Bx5dK+MMlSF9NkjFCH89q/iZDnQEYOg5lEwQKCsf5Qxp+eXz
	sEbqiug9a58ruTIpOiWs3zKf6Qjl+WJp4+t1eLz42FobkVhrfKyDfhuzHzLgqL7c
	I22/4wIa5bN6GnhJHWq9Rxl0o272jQrRYAnuH1+Y+Pji9x26JyR8ZZvJgUdALokZ
	47e+CkoV/z9thUhp3OFf5AYsrdhlMDj2OuTRwhPiHpkiM3oXfeIxhb0Cj7xuCJrt
	PuIMOFlsYZ0INTRT/wOHQEcSm5Cu/aCy8XQ==
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-09;
	repo=github.com/dkim2wg/interop; date=2026-11-03; sw=lmtpprox;
	action=sign d=pobox.com a=rsa-sha256;
DKIM2-Signature: i=1; m=1; t=1793915571; d=pobox.com;
	mf=PGdpdHN0ZXJAcG9ib3guY29tPg==;
	rt=PGdpdEB2Z2VyLmtlcm5lbC5vcmc+;
	s=fm2:rsa-sha256:m2lblHJEviqeWRp6VSZGK3us1M3Mn3GurDnvPiHCVSIJsG8
	r5Q0dYyuQKD65D/m3+bB6jJSagDtm6VTSlpAOm9450OZiXgYg6u/U4Q3XOw4qa/4
	8beSXnpD2x4ZV5COBg/6T7GiGEc/6PUhSKTVsf9F0QddxnorhrIXl+2EeavBFlUj
	eZGetiQb04Jk1k/DIXwIHrTr38NeDHLay9oyFvW4uJhIzI5WxSGU7MXekAh1yQJi
	LvvLt0hI6Y9UEITxyoCkzprj8jj3CvXJt/h+p6O7pUuOSF8JBDz6PmSq4ApMI+9d
	jWqA/6VPnIFIPn5Ed0jJEDLfyLzdsdwiXIJxKlQ==;
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-09;
	repo=github.com/dkim2wg/interop; date=2026-11-03; sw=lmtpprox;
	action=mi-m=1; hc=12;
	hn=cc,content-type,date,feedback-id,from,in-reply-to,message-id,
	mime-version,references,subject,to,user-agent;
Message-Instance: m=1; h=sha256:HD+27iua7y/bYiEhJGrit1bJqp0HQ6K0AZPnYeeEw1k=:os+FWYHelaLViwD8Ey8x6uYk4Hah7XSP5HUDX+mnnu4=;
X-ME-Sender: <xms:s_rsas0ViHOsfmqbTwKxxcjQP526D6nhw_taizXpRNuHqLiKHa4q8w>
    <xme:s_rsauE2srY3fmNHN3N10GnGAqwUZ2XWehKrEz28BymF-ryX2HSozsAj4y98D3-KN
    MjjmOPllCMog-vGnGM58DPchRc5Nh6h8qmoYCStyFnDyBljPct5pw>
X-ME-Received: <xmr:s_rsap6RhQoI8OU8hza8tTBsqI4D7axsWtbPo9yx_b-QC153pb01h2xQqNMIZaITUeq_CBByylhhnp8peOe3yPxVSIFq1l0_30rv>
X-ME-Proxy-Cause: dmFkZTFFxhoYJ0hBcU0NXYHaNpRBtSkccggMJX06cugM88C5hMxTIbG/m29Vxf7LSMKr+o
    LLSFqu8s00JMxfyvYD2mIWtoL78waF6uDDtpKFdy+NQUfeTWJ5mE2Bc5RRkcZMPqbBfdu3
    L4r5xq15iDrN5m4vMutYKivprwvxsXGYqslJcjVuMGR4sJAVERiQXVg7B3psHhztgBARaR
    Ju45VKu7ZRf+bvGV3a8Auj5/HhueshwCZU/1Db15j6JdcHs9HBSXsSRoA2PuUOWWFmwmqJ
    ffwRARugmGZ5EW5CwmfsIlltvzNq+uhMetx2qcfPKTSjiRu1tSwoV3KtskY/S847xiA9qC
    PdIBVPqNPLY592nxCwONZ1se9G4F6gJEDPNWnddpJs5EBE9p4oF6aSEWTCS359gFCfdR2S
    GVuALnkBMpfAHZ3FirhdpElwlvW6bFIGuoyqcdKcHyNYrhwpsQiURlZ5uLwt3x+F2E4b02
    G8gNLJ6zfxKtmuaJVGbIjAmJLBL2a1uiHbcvw3j5MZbl24akI8ANWV/xaPs72+IIaSn27O
    9pCsnDdPn+uqCEVd8psfA5DTq63N1p/6Q0AGzyd3kJGJZJlEyPD9K1USXEvlsdRjQh63H7
    oGUljpKjKtjqBmhk6a+WUFlnAe+W3uz+SKHkcZwMG7bbktfR83VH5geYtQDQ
X-ME-Proxy: <xmx:s_rsaksCe5bOPseY6KgpmgF-8BUNFl5beGwUc2bRAxQJIakTf-GkEw>
    <xmx:s_rsaq6R1Gojafykn_5PZJppa2TGx5OkoSqGjKaR3IPbEdBea0hMjw>
    <xmx:s_rsavWoYvau8SwS3qNBlNH9ZpiIWlnnY1qoe5F5EC6PMCTo4UUh0Q>
    <xmx:s_rsas8hlUtyNVf5B6Z350tRQD0bq5lDVKQGOi5pUuMi2yKN-ZAXQg>
    <xmx:s_rsakYwGWGtGvQYTp-6QVMXWFPP5vqiV_9mrsrzzp3GDB_nuk8_n-Pi>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 5 Nov 2026 16:52:51 -0500 (EST)
From: Junio C Hamano <gitster@pobox.com>
To: Phillip Wood <phillip.wood123@gmail.com>
Cc: git@vger.kernel.org,  =?utf-8?B?6YeN55Sw5LiA6IGW?=
 <kazumasa.shigeta@kanamei.com>
Subject: Re: [PATCH v4 0/7] stash creation: avoid unecessary index loads and
 refreshes
In-Reply-To: <cover.1792767794.git.phillip.wood@dunelm.org.uk> (Phillip Wood's
	message of "Fri, 23 Oct 2026 16:03:28 +0100")
References: <cover.1791218125.git.phillip.wood@dunelm.org.uk>
	<cover.1792767794.git.phillip.wood@dunelm.org.uk>
Date: Thu, 05 Nov 2026 13:52:49 -0800
Message-ID: <xmqqse1fq72m.fsf@gitster.g>
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

Phillip Wood <phillip.wood123@gmail.com> writes:

> Changes since V3:
>  - Avoid implict cast of enum create_result to int in create_stash()
>  - Fixed enum initializers
>  - Use switch() rather than if() when checking enum create_result
>    return values

These changes look very good.

> 5:  de5e0c196a9 = 5:  b62d3d080a8 stash create: rework temporary index creation
> 6:  61e4ce22a0f = 6:  8c54c118307 stash create: remove unnecessary index load and refresh
> 7:  a486a625c95 = 7:  f61ebbf9a3e stash: simplify reset_tree() function signature

I'll have another look at latter half of the series which I didn't
comment on in my earlier review separately.

Thanks.
