Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=202.12.124.153
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792668640;
	b=bvDCXsznIjI0/ww4NttDUjSaDIZbX3lV/k0edJDdider9Gfg9wAUocQvdYbplsweMxVn
	 vSVVMCGCpm7U6j7Lfg1+gTts2G5p1miAJNwqY5z9RyOqkS9Jbh94GQaenJzrIHNL8z2P5
	 o4sdiLyC2Vxqh1zHBvaTT1Uh8YeWhZ5nOFQoanekLWzpbpnRH/gsSK1bSRoio1JO3pQI5
	 ZIxxRlmPCjtN4C64Llr+PVp2oH2iPBy7LxbcnahcUv6VFW7gj3FAHHN91TO3SN4hCkk0l
	 qQGC4xLrGWZ/ow/Rb/gconqRO++T5jd0zuIyDqGKh18wKBE0fkm0X89EB2NTnTi+Low==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792668640;
	h=DMARC-Filter:Received:Received:DKIM-Signature:DKIM-Signature:
	 X-DKIM2-Info:DKIM2-Signature:X-DKIM2-Info:Message-Instance:
	 X-ME-Sender:X-ME-Received:X-ME-Proxy-Cause:X-ME-Proxy:Feedback-ID:
	 Received:Received:Date:From:To:Cc:Subject:Message-ID:References:
	 MIME-Version:Content-Type:Content-Disposition:In-Reply-To;
	bh=vjqO+v+YkMOdwGZ7HA95GSMituXn4ek3cdWCuaeV0mc=;
	b=rR6G4VMSJy7ixNIMDdezT6PLTldxZYPdSNVEaMgRjoEeDuKJJwyODsHfLwqySFYytNFO
	 y7c+XRnyed5xCmDWpFAdsBHNvTMxR0WpcOggsk55JP5awgGTAA4zT+xqBbVhNsktokezu
	 kAMlWdjsYzflsjaRPIaG9G9fH/YssrLEtcBubpo2KeHpSo12t5lvqVNFmAbF/fyieh77n
	 F5CsQUeP4WkoOX9g81n2t+O3CI5BpvaZdMJrE7+wh/AXuYB98/65sPlEkgJE2wNl7JaLb
	 vZp7ukQKHTCxOetsNICljIvAiQfpYgSzhMlKpI3wUueJHLf5S9NC+uBN8LVMtccxVOQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=pks.im;
	spf=pass smtp.mailfrom=pks.im;
	dkim=pass header.d=pks.im header.i=@pks.im header.a=rsa-sha256 header.s=fm2 header.b=BGZHERIh;
	dkim=pass header.d=messagingengine.com header.i=@messagingengine.com header.a=rsa-sha256 header.s=fm2 header.b=UpZDqnDc;
	arc=none smtp.remote-ip=202.12.124.153
Received: from fhigh-b2-smtp.messagingengine.com (fhigh-b2-smtp.messagingengine.com [202.12.124.153])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2CA0B606A319
	for <git@vger.kernel.org>; Thu, 22 Oct 2026 11:30:39 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 2CA0B606A319
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=pks.im header.i=@pks.im header.a=rsa-sha256 header.s=fm2 header.b=BGZHERIh;
	dkim=pass (2048-bit key, unprotected) header.d=messagingengine.com header.i=@messagingengine.com header.a=rsa-sha256 header.s=fm2 header.b=UpZDqnDc
Received: from phl-compute-01.internal (phl-compute-01.internal [10.202.2.41])
	by mailfhigh.stl.internal (Postfix) with ESMTP id 6F8D27A016B
	for <git@vger.kernel.org>; Thu, 22 Oct 2026 07:30:39 -0400 (EDT)
Received: from phl-frontend-03 ([10.202.2.162])
  by phl-compute-01.internal (MEProxy); Thu, 22 Oct 2026 07:30:39 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1792668638; x=1792755038; bh=vjqO+v+YkM
	OdwGZ7HA95GSMituXn4ek3cdWCuaeV0mc=; b=BGZHERIhhHZJLy9nNtx5dYQTGp
	dbM+/aC/2uj5Qe9azHcYvadPKjsuoOBZkZqc6IQnMKK8oxi7Y+HP2w+Nzr8ztUz6
	ryi6gFhqXH7hAUVqjinWgY32iur6u0AgCrrk+PUqqaEFK1cxXJgUO2up9t5wbwNr
	gDgXdwkgEHOZHyM+66kYjMh/oRxj14b9AHvjmf8Yhm3x1Tv4U7JITCMMyM8P1Cph
	hH1JruOg7h9xRwzSgkrr4MflEqwx44YyN1raq6gfvsAWUhBFPF/Cro0evhyCdePJ
	mI/GHt9HnHsXWQojYIu+BOhnFLGl68Jo+d+as1+MHg4ZIEqeoPPCfB1v2csA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=
	1792668638; x=1792755038; bh=vjqO+v+YkMOdwGZ7HA95GSMituXn4ek3cdW
	CuaeV0mc=; b=UpZDqnDc0HDhhwR99stffJDcZ+sWPKIp7kHb1DkbfGw8/egpA5y
	YocbmZrkS5pdszu0aeCWOMqo7XDDQBl4Zq5EkMpvYpkWPyfLNjrk3hTIjwZPIam6
	tUAjwFX2FfHQAO1rGzVhzS4kVeRCv5gz/7crVw13TcvTDmv9+7/NSIrcjAUzwjie
	J3oQg9GysuMii012jrgG9oz8JWbtYNBO971NOuYGMcprLCJ6Wmt//AbihQLQfZiV
	acySmWqkpS3nD97UPf5bgDGMRWIrN0UL1e+oO2F+749NEuBkXCYCYkbyjMoFz5W/
	Ln40t6x/5caTOFALti/X1sPOHpjTFyFuoqA==
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-07;
	repo=github.com/dkim2wg/interop; date=2026-10-18; sw=lmtpprox;
	action=sign d=pks.im a=rsa-sha256;
DKIM2-Signature: i=1; m=1; t=1792668638; d=pks.im; mf=PHBzQHBrcy5pbT4=;
	rt=PGdpdEB2Z2VyLmtlcm5lbC5vcmc+;
	s=fm2:rsa-sha256:WZlMx+U6fB5o5gSkDFRd8ej5niZsUBU1Q/W/SGvvV4CGDV1
	NhuQw39dvr9ckMJtc+PoADR3fgj1oUgxwXfKLZUNy9tNzVLnIISaGLR0Q96Mwk8T
	W1NujpZESVU7CWejq+CbwmLgwzrmGBXqHneKcKVD4fTe+98UAC/JOPy7Bfp2zKtM
	Yw/6nNMNhxSGtAgMel+rytSG7Zx/PmfGCpPqsqLutyT0+6XkdQkA37YXyt9ulu75
	32xkGkRBmGphk5uTfjYFMEBHUhBcsh4dGKwAliEy+E9DtTqI81xCaevWqTqwPpyP
	CCC0y3c7vw/LQIeCRckpuE80NJaCU7nx3O0KlzQ==;
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-07;
	repo=github.com/dkim2wg/interop; date=2026-10-18; sw=lmtpprox;
	action=mi-m=1; hc=12;
	hn=cc,content-disposition,content-type,date,feedback-id,from,
	in-reply-to,message-id,mime-version,references,subject,to;
Message-Instance: m=1; h=sha256:ZpH2lETj20KuBX382VefGfiOVJxns8R3JiedVCOOmZk=:7ZamgK4vg4wpR0b+EQ31dPcxEdeqIlkjPNuGZs/NclE=;
X-ME-Sender: <xms:3vPZalB2_BF3-d9_lsMnlWgVSqCF8ppYnjJMWtP2RAAD5kM4GGEx_g>
    <xme:3vPZanOB--MH4az9_ylWF_E4TbxSUev6f31h7eGTcJVZ23F9sXJZptt0We7W4KHsK
    oRkOX7iQqlO-zh_J6NQT4x7OJvSCx1Yox-pNLkPlrKIIVylRK0>
X-ME-Received: <xmr:3vPZaqbKKmFmHGtWkNxldKo1Xdpcjj3to2tyFL1_q8VIAp-PWUS5kARk21nAdsub1U9KOQ>
X-ME-Proxy-Cause: dmFkZTFoGq8TjXfYTuSbnG1c2MfHGBmY9NzAZdEnwndJN0djhFPN6Pe0xcUKZOmQsDuvgW
    AHq0z0zXqdpBpY9lCJMNgyNoqzeoMSUzN5jopN2REPvxgYrG8S/Oaua62lh06B1m1tPV/8
    pJGVd/fsJXmJyL75hbjih/9gAXT3dGAG/G4l+7aB3cWZVoTS3inlqVQ4FKOdaHSfFLQK2z
    1SW4MnPH6aJsgN7+QRWNW4fT/xfP0l/PMnH1pQj1y6LhANIYc8C7uCuhyaatlHtyzjnJBC
    Gguzj8MflXL6KPdkJWmvbSA2A68lF2M0Uw5QiPb1yrRBlnYNoX382hNlbyA63ML8x2+Qig
    /6H7L1H+YI/Y7R/GPi9p6dCooAFw6EFRBf+3lL/31X5ZQx5N5OVu/fycvc96E2JDTOg5Gi
    YB7OiAnGQneq8VUh06A/879oiSrE33rF7HvfubqnQufWCgCXiv5w07TUS9lmHdfcTDAAx+
    xFWxC4y3iFdeHvCG6vsGvuYhjQeNeOathk/6OzZ2FsCszW1eFxjaMtk2Vr//yi+IIl9ugf
    9SMlOSfXNLUbBEwV96nBJ20DhlvirOtDT3q696kjFvrg3VSEuR6zm+5QNix553qRr/kdOz
    YDImAKM4H5c6urqFAo0SNc4yVB8xUnOzx3o0te9uQCwEw0KZ82LwS+eO+Jqw
X-ME-Proxy: <xmx:3vPZamvcPnq9VKv5fcBKFzOtiBdKKyUgxGd37Uz3Y8bFW__mBomidA>
    <xmx:3vPZasPK5elGdIFYA23nzXnqZAB1OYzJQGx9lTJ2IP3irQXA8cwmQA>
    <xmx:3vPZat6l9p8pBW_xlbwMjUt5es1GOFHh-773zUu7_tJYB6iayMLqlA>
    <xmx:3vPZaiSKui9Aw5rX8U9TZ8_diubrlr3oEjYbPEMD39I1_FyuvCoRHg>
    <xmx:3vPZatsUYgCVxOmdlFKHfStMsiMruiqqC8LPt3W65vD4eCbdefk61Yp8>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 22 Oct 2026 07:30:37 -0400 (EDT)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id 71b35d29 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Thu, 22 Oct 2026 11:30:37 +0000 (UTC)
Date: Thu, 22 Oct 2026 13:30:34 +0200
From: Patrick Steinhardt <ps@pks.im>
To: Joy Gundu via GitGitGadget <gitgitgadget@gmail.com>
Cc: git@vger.kernel.org,
	"Kristoffer Haugsbakk@imap.fastmail.com>" <kristofferhaugsbakk@fastmail.com>,
	"Christian Couder>" <christian.couder@gmail.com>,
	"Usman Akinyemi@imap.fastmail.com>" <usmanakinyemi202@gmail.com>,
	Joie Joie <soniqjjj@gmail.com>
Subject: Re: [PATCH v2 2/2] config: move pack size limit into repo config
Message-ID: <atnz2koLCp6FMD0u@pks.im>
References: <pull.2271.git.1792522587065.gitgitgadget@gmail.com>
 <pull.2271.v2.git.1792662432.gitgitgadget@gmail.com>
 <05ae50b5daf0caea8666b0b7c8aaeb9f5c397017.1792662432.git.gitgitgadget@gmail.com>
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
In-Reply-To: <05ae50b5daf0caea8666b0b7c8aaeb9f5c397017.1792662432.git.gitgitgadget@gmail.com>

On Thu, Oct 22, 2026 at 09:47:12AM +0000, Joy Gundu via GitGitGadget wrote:
> From: Joy Gundu <soniqjjj@gmail.com>
> 
> The pack size limit is currently stored in a standalone global
> variable, even though it is repository configuration.
> 
> Move the value into repo_config_values and update the configuration
> parser and pack-writing code to read it from the repository's
> configuration values.
> 
> This removes one piece of global configuration state and helps
> make Git code easier to reuse as a library component.

This reads well to me, thanks.

Patrick
