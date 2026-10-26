Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=103.168.172.151
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793021154;
	b=T8bVnKvPXXScVKjChahQliEHY4gklSKJntYvKqvcvU46TaDkdUvRylasp7FNjJfSi6Xb
	 e0yKWApK6rCv+WVVt7KGGc2F+9/1ey7XqiKeh5iaVwVMdz6hl7SkHMRTwO5on1WDLcVvB
	 RCQhEAcjM1vaGUAJ2Eptf7sVGdw7IGPbv+MmCr/5W00ngvxGALL7O1xjoeag0VuvZ2rRo
	 F2/7lJr/gV4UGqaigoR7i35rYuF9EJ5MYUgZqphi2IchJTJUZfYl2wH8ZmMfEoH7iCEE2
	 bjk4P3aeC61kws+u+ctw4wfKVppoGprjhouUZDb3oajO84DlQAERdST9In5hx1oGMuA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793021154;
	h=DMARC-Filter:Received:Received:DKIM-Signature:DKIM-Signature:
	 X-DKIM2-Info:DKIM2-Signature:X-DKIM2-Info:Message-Instance:
	 X-ME-Sender:X-ME-Received:X-ME-Proxy-Cause:X-ME-Proxy:Feedback-ID:
	 Received:Received:Date:From:To:Cc:Subject:Message-ID:References:
	 MIME-Version:Content-Type:Content-Disposition:In-Reply-To;
	bh=cvJIgZGNp57NfNV3eezeZScovF7yLHqwJfvx9y2xtXY=;
	b=cURa/jCUwaPuIPDt0m+Aovpl2JPK0RGTe4ku8cnFDun0MYNwnJ0Nb80sHSzPhLdKcm35
	 1Qd108B7hMHckeDRAE+U835yROqONCor2ug/eDUGYFJ+cXVd1Pxksoz8F+zM7TYh9Hoci
	 ELpk54oVGGg/uuzzHL2Y4EebjlXB9aPDFs93NrWo1w4ChahmbINvYPjq0UUjL8Dg3sGTv
	 T4/rGpa9YaFs1LoXENv4yEoIvd+P5M3dpb3eWy4i39Qwl7a4D0KgmXljO7QjvRK3jD9dj
	 F9hdJ0f+r2jO/R2KlZSVeujQnjtjLzcqmeqIPveKpCdzyAkckVGILEM5gEjEnYqoodQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=pks.im;
	spf=pass smtp.mailfrom=pks.im;
	dkim=pass header.d=pks.im header.i=@pks.im header.a=rsa-sha256 header.s=fm2 header.b=vCIhu36M;
	dkim=pass header.d=messagingengine.com header.i=@messagingengine.com header.a=rsa-sha256 header.s=fm2 header.b=bS+kyArj;
	arc=none smtp.remote-ip=103.168.172.151
Received: from fout-a8-smtp.messagingengine.com (fout-a8-smtp.messagingengine.com [103.168.172.151])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4BCC3606A31B
	for <git@vger.kernel.org>; Mon, 26 Oct 2026 13:25:54 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 4BCC3606A31B
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=pks.im header.i=@pks.im header.a=rsa-sha256 header.s=fm2 header.b=vCIhu36M;
	dkim=pass (2048-bit key, unprotected) header.d=messagingengine.com header.i=@messagingengine.com header.a=rsa-sha256 header.s=fm2 header.b=bS+kyArj
Received: from phl-compute-05.internal (phl-compute-05.internal [10.202.2.45])
	by mailfout.phl.internal (Postfix) with ESMTP id 76EF3EC0A89
	for <git@vger.kernel.org>; Mon, 26 Oct 2026 09:25:53 -0400 (EDT)
Received: from phl-frontend-04 ([10.202.2.163])
  by phl-compute-05.internal (MEProxy); Mon, 26 Oct 2026 09:25:53 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1793021153; x=1793107553; bh=cvJIgZGNp5
	7NfNV3eezeZScovF7yLHqwJfvx9y2xtXY=; b=vCIhu36Mrh8VZKaWNUgCGpcMgp
	iBspqk/j+BUPqVWrCrADQtHffqY5wqyaLean+Bk103x01KPEGNY641m3ETFFXPWK
	4cIYlS+oNU63mxVWxbds9pORcyMzzMYNOwh2fpXZgQdqZd+fMYP5tcPbntcNE5WP
	4OqF93+5ssOOEHQHN9V0r4fHMZpt97KwjAE404QQ8R59acWiiGz6Zlz1PSfg2uP+
	aAMk5xdxEotwY7zdwixwcb+YOKJBbiVaKQ3F/24+jPqlr05jbK/1kzvnoHl6dRGX
	rzogqwF4O4+TLdEZI3fqdssriAFECdmwrc3SE8CaHmgdOte7zouhmG6rogmg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=
	1793021153; x=1793107553; bh=cvJIgZGNp57NfNV3eezeZScovF7yLHqwJfv
	x9y2xtXY=; b=bS+kyArj6h5dojF51IVKyGfEqC/4kyTq7JcWP189XOQvdBq/DzH
	+auSASER7ZnwooB8A8ozwVxRBWAPn4/74orPxU1ihncJgYbNEWHMyxxzUQ6mShYQ
	tONkoUCM5bd5LRcpAyzpHpME8cdiQVhFbrigJtLgEGTFbiUZ7biZkp9GyXZsZyCo
	Js+rOvTbP/ivlDM5pdA2p0eoWxiHldmPvhD01kUa3gonSRH47Z9vBfmu+zc/rT/G
	nhUG23FaDm7wnoPIRT0T1RJ0gD8YTpSENohT8e9Od6y+vXsoLqsNdilf59aXZSrc
	dREyn819rpVTSHAfUeWFS+jU/4w0rMK+0jw==
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-07;
	repo=github.com/dkim2wg/interop; date=2026-10-18; sw=lmtpprox;
	action=sign d=pks.im a=rsa-sha256;
DKIM2-Signature: i=1; m=1; t=1793021153; d=pks.im; mf=PHBzQHBrcy5pbT4=;
	rt=PGdpdEB2Z2VyLmtlcm5lbC5vcmc+;
	s=fm2:rsa-sha256:Iiqju5/Fo+Rx9gowtGFsoaXFOfVSLir6KV3Ibzm9MjmAQ63
	7fYPHVjXi/nW9t1km1XMebjVj3CrZlZPU4Yny1vI9DGDT/cK3bVk/klQ4oFCuril
	F35FiTTdLCn3PSjBuhgfHjdI8BlmdgiuasQmXGI+ubYBEXThcqh7TR31p36Nill6
	2fAE11MU3LSydMsSuyrXov2Wno2jIQ6tEKS5s+9n7uapy1qwwyTrEe6Emb5RG1Uu
	pdkHZguhk0jt5b3b2t4wcb1yeXQ5XMpCpthua+a3T2tUfgWIO2rRvpjBXVTLARri
	Jkk2den+8oUIR2N+iGEXje0CsM25qG+tTZYRNwg==;
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-07;
	repo=github.com/dkim2wg/interop; date=2026-10-18; sw=lmtpprox;
	action=mi-m=1; hc=12;
	hn=cc,content-disposition,content-type,date,feedback-id,from,
	in-reply-to,message-id,mime-version,references,subject,to;
Message-Instance: m=1; h=sha256:CBh3sMzdd0PgcOkoGSI8/UHi6ni9jm63wsLyAwswpaw=:rEKyi9GQiu19UjyQGR1gPfim7vL5ubJQ/Rg4tlGxqDY=;
X-ME-Sender: <xms:4VTfaiVGQrHo_1-8leKsT5328YCrR2ls80DGJFKGv_MNDnJu30prsg>
    <xme:4VTfag0gJ8PaYt0ZC-4OCIGWmHHbHAnvOOwxeyj62LL_zJWX0HY-7HPh4xVoqeSs8
    P6FzDzxCb7fUQvtA_MCz4YkAuYIxl6yuauj2M1Ov44VXCb-EQBMtg>
X-ME-Received: <xmr:4VTfaoovtPtH1mTKQ9RNKDjjOd5a06tAz7Zt_OB4L8QbQy-_JWAL9g>
X-ME-Proxy-Cause: dmFkZTFA8TzET7AhD15kLc3DOG6AO1ARrEhI7bu2J9mSBuIVOyeDbHFKTZKLkM/FDrVrkj
    aGaa9gtyb8ZI+zJ+QIDbOQ5YRigXU4/KIbAQbjcJpNt14ZT3Og0zPmQZE3AZWw3/9/Okuo
    UuggX9UwbkoGNRDm0q/cnbFa7HpqgB1OWhxG1ayL73s1M2VFqfp9Zjkh9/MjhSBupL0uLt
    BYeJ7bSaCVVAbJXY5loatgXVjjR30Gp9pHRwWzegDA1orBoxvPwSLH9TQzcxcoZwjnCbzj
    ADGNoZEDN0/9h7kOgP0/b61ePj18bWR9d6ctwxVJX49qEeu0MB1GIarwz+nrgXDSDMLkf4
    qOYT4yJUcjSYG0ouC+JwJbW9W1M90IdlLLxlOlBljkcf3S3Cyz2waiNR1efFEmc1alla21
    hcXbxm+lgGUL4UJ8u5tqx7znadpzAbsQe8dvzgOTrzQGJkxZ1RUnVNtlSIoorYL4QjjdA7
    jpShTtu89RRD7eT9mxvRXQfDwpUNNJBSlIga3vu08DMG7TQoSBVvnqpgeigwsNeL7Mq4Uw
    c0noXnaK8+E5IJj7SwmmDPnai00wpN34wShV6gwuOIRCzbBJuZGkwH75DiForCCodrEbmX
    bP0Ihn2IiCZ3qY2kmY4lQuoXo2HhOTxQVcNQ6IEvt7TPI7Vya1D1mzfy3umQ
X-ME-Proxy: <xmx:4VTfavWnVRyNwOVm-Lhu7BuNX1vHCGpO02GEBFl1XYfy0N0V2Mjq1g>
    <xmx:4VTfarZ175iS2-WgW-Fgj9XRMXI75dMVpHSYKSCeJ6a-sYflDXdGQw>
    <xmx:4VTfakcCzOtHs4fwVYpYiSI1bpKRAW_vMnQQbC6sHWn96LF7buCSIQ>
    <xmx:4VTfat0dN89VhkyPbm5mN4cvTwd82KhC4DsPiVPteYcck1Av1BSfzg>
    <xmx:4VTfapD19bHb-kRNVshlbmZ8b8K_YQmZcez2_sqFSnYvKkuFrxq_wkF7>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 26 Oct 2026 09:25:51 -0400 (EDT)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id a2d87a69 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Mon, 26 Oct 2026 13:25:50 +0000 (UTC)
Date: Mon, 26 Oct 2026 14:25:47 +0100
From: Patrick Steinhardt <ps@pks.im>
To: Aniket Gupta <aniketgupta3001@gmail.com>
Cc: git@vger.kernel.org, gitster@pobox.com, christian.couder@gmail.com,
	cat@malon.dev, belkid98@gmail.com, phillip.wood123@gmail.com
Subject: Re: [PATCH 0/4] environment: move line ending config variables into
 repo_config_values
Message-ID: <at9U26GJKmbHAAg0@pks.im>
References: <at9HOXZhVcl53CGX@pks.im>
 <20261026131023.408-1-aniketgupta3001@gmail.com>
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
In-Reply-To: <20261026131023.408-1-aniketgupta3001@gmail.com>

Hey Aniket,

On Mon, Oct 26, 2026 at 01:10:23PM +0000, Aniket Gupta wrote:
> Hi Patrick,
> 
> Thanks for the explanation. I was not aware of this and will hold off.
> Is there any thread or branch about decoupling that I could read? I
> would love to contribute to it if I can.

Sorry, I should have provided a reference right from the start. I think
<xmqq8q5n1fa2.fsf@gitster.g> is where we discussed this most in-depth.

Thanks!

Patrick
