Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=202.12.124.146
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792766027;
	b=whG+lnlUAaUMr0nWiclaXRg1j7xtGcyh/4vHMlfBRvrEZ+70FIvoZ4bPnEtpLxPKgAmy
	 uGVo33UhF1wmslm96sBUsgL8aJ0SGqxWqqAb9bJzJfiBHo5IYrEMT4Gg+MGe5dOTUX5fL
	 nv5yTDy8riDqL6+pkM2RHaSpb8oBrYb+A91WYo+ZraZgKyPWoyZJIZOR0ZlfXiWaB8kbq
	 kYsO0FowbDKZ5CV6expFYCVVvO0HBGwE0kS0BYNW05G94Qo4Cqnep9mS6o9tLu1Oo9lBY
	 mHeHw9vYVDNCcZ2M/uT4aoDdT4HTu22qO8PUmf++AJO7JZYyOkxfK9WDjT3tvbyiH1A==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792766027;
	h=DMARC-Filter:Received:Received:DKIM-Signature:DKIM-Signature:
	 X-DKIM2-Info:DKIM2-Signature:X-DKIM2-Info:Message-Instance:
	 X-ME-Sender:X-ME-Proxy-Cause:X-ME-Proxy:Feedback-ID:Received:X-Mailer:
	 MIME-Version:X-ThreadId:Date:From:To:Cc:Message-Id:In-Reply-To:
	 References:Subject:Content-Type:Content-Transfer-Encoding;
	bh=fYpmZ32dUjQzLL3T5MeWJbujiqsde3fQqLCE8r3lRJg=;
	b=VCvv4KI3S6NCr/PMfvwYOEnDIAbd9ayG9MoHOYJj02VTgUyenKHffSKsBqGNo5M307Vy
	 GPfB5UxzqUl98gdDGIG2ay3s/euXBppkPjeU2H3DegXI7IV9pDL8Y68MmOkjlL7RKqQBy
	 qZqctcZNeHF+1iT4H+PC9I6cyCoJZm0aA0ufpPJ84oJ0yJMdvwT5B4Nd4+g52Yz+G4uNM
	 zoMcYDsJo2jfep68pRWbnlS8BGTn9NNt1VoJtcDe6wbZjVCDF3TBLDcRccS9xLiOXZB2O
	 twHLAJB9KwQ2e0ebo3RxGOJoJFZSeZtdzdI0I+k9HeoES5AAM3eDCF4SXUAxdTcewUg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=fastmail.com;
	spf=pass smtp.mailfrom=fastmail.com;
	dkim=pass header.d=fastmail.com header.i=@fastmail.com header.a=rsa-sha256 header.s=fm2 header.b=R7eI+HX6;
	dkim=pass header.d=messagingengine.com header.i=@messagingengine.com header.a=rsa-sha256 header.s=fm2 header.b=fHKyB0AX;
	arc=none smtp.remote-ip=202.12.124.146
Received: from fout-b3-smtp.messagingengine.com (fout-b3-smtp.messagingengine.com [202.12.124.146])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A0624606A323
	for <git@vger.kernel.org>; Fri, 23 Oct 2026 14:33:46 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org A0624606A323
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fastmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fastmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=fastmail.com header.i=@fastmail.com header.a=rsa-sha256 header.s=fm2 header.b=R7eI+HX6;
	dkim=pass (2048-bit key, unprotected) header.d=messagingengine.com header.i=@messagingengine.com header.a=rsa-sha256 header.s=fm2 header.b=fHKyB0AX
Received: from ams-compute-01.internal (ams-compute-01.internal [10.64.2.61])
	by mailfout.stl.internal (Postfix) with ESMTP id E48F91D001DB
	for <git@vger.kernel.org>; Fri, 23 Oct 2026 10:33:45 -0400 (EDT)
Received: from ams-imap-15 ([10.64.2.35])
  by ams-compute-01.internal (MEProxy); Fri, 23 Oct 2026 10:33:46 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fastmail.com; h=
	cc:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm2; t=1792766024;
	 x=1792852424; bh=fYpmZ32dUjQzLL3T5MeWJbujiqsde3fQqLCE8r3lRJg=; b=
	R7eI+HX6dVOINU/D8M7pvMcPcOPoPBbKZtk5I6/vays4k0F6rif5tRAUPm6onCDi
	rIeTWO14x4+3emAI5TydjVcuPdweVQeqsAu2B5PJAVQD3gcQIHZjUZZ73rSljXhp
	prEh6K83RxvZq6KfOybkOV4Depy4ovB1VRtgxDrOK+sNwHHmzWKsU9xr0Wj8b5Dh
	WwG/WkBdJX6D4WXstT7fwoRvabpbUJgcnTsLlMKx1pZP1CAyhgo9icBr7bSqkiQU
	VvdxedYvQ7EQoYOfcJRCDakDBz67murrKMJ4866hW1DjJnw/J4rEpTBo5ubc/P/J
	YxuJxZBA/D6IGdZfMusd9A==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1792766024; x=
	1792852424; bh=fYpmZ32dUjQzLL3T5MeWJbujiqsde3fQqLCE8r3lRJg=; b=f
	HKyB0AX2/vjbQzzFCh1BEFAGz2HOZVilwNiMDJKtPqc/uWXxC99ZjoJ605hEW5fx
	MXUZakQc7c4xoUFkSfRTnoI9GcUikX2lCT3mPDTvflgXCQPJn4H7KIijxHgZF2X9
	6A74LldbFnDLub1M4EUequqznC/Kd/2um1ZgcnhjYapaNqM0+LEMN2Zja0tUHYpb
	TOPOLMsIhR96CUvl9p1H6Fj+WIxFGCF8YgbWrHUwLWZ2gA6Pn3bwpqEyVlYPyO7y
	ZPPrYnP6m+rRbOvGbgFTC7pUEgipn/0CbFv3+Pw/TNVA8yqPGov1UdRsaMB4juaX
	HHG+f/nkPMOeUJUJjV3uw==
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-07;
	repo=github.com/dkim2wg/interop; date=2026-10-18; sw=lmtpprox;
	action=sign d=fastmail.com a=rsa-sha256;
DKIM2-Signature: i=1; m=1; t=1792766024; d=fastmail.com;
	mf=PGtyaXN0b2ZmZXJoYXVnc2Jha2tAZmFzdG1haWwuY29tPg==;
	rt=PGdpdEB2Z2VyLmtlcm5lbC5vcmc+;
	s=fm2:rsa-sha256:rCkWpggopR/GX0r828my3mXXtIoyZVe8qzy6HAhmUzRtBFy
	A2SaMJyUbYSatx44iD0VMTYrS503yKqk6xSaTydVVA3P4+j+eZuuWwY8+imLKN9G
	dzdth2egMtTAuMX5nuFpQRlOh6LoB0EMoOzxfjgGiKllrZ3s3Ju6G/SoXrslzCXk
	JmCXtdTZfudFTIj4Z//1MzBVY04yuPsleZRhgwhKReNsaqR2BktffUH8+B9M4DaQ
	DMt98eOfCQTkSf6jzSwfDDl21D25F44B/4hrWu1wkBKd5rCgcBK5dL2YSrRl9hjK
	N1Q37Q7Y0ntz+YVk3/O+W/a3VaZNmFTGKZYCqOg==;
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-07;
	repo=github.com/dkim2wg/interop; date=2026-10-18; sw=lmtpprox;
	action=mi-m=1; hc=12;
	hn=cc,content-transfer-encoding,content-type,date,feedback-id,
	from,in-reply-to,message-id,mime-version,references,subject,to;
Message-Instance: m=1; h=sha256:nxOMRgZh02XvEU1YyAarxEzzZhjFN8+03OjbFYnKR7U=:AFCn5gub4X+uwgHuoKI/IalJnGseMNKya9hM+3VmLYg=;
X-ME-Sender: <xms:RnDbaj8dzZu80af-O2nVuY9dO-VNZ39MqICnkHMjpStqBlV98ay7X60>
    <xme:RnDbaqjhPhK6_embLsS2KKs_wtuaMXehZVz0Rryd9GsLzTc63cEBG_xC3V1wVpCS3
    qhA8ZapDVMgxFeUNQ9YIFFcf7NEz_cAb5nEr1CcIryrHWnd620xCyI>
X-ME-Proxy-Cause: dmFkZTFDnameqkgIjuVxBQ3qmw7jSwimuD57GN/yIy8cAS1laXe1Oq2ovlBFXMDJQiO85R
    yAfdYSUI8MposrtLofyPP1IMU/B7GXym8wKTDYkNoyMucKzuRbDSBIgJkUqpaneFbd0CpF
    2LzUyEjGxwGvolQ5pmsM4aqb6LKBukmv2BcJaaVj1JZBSb36xDXbbs3V6y5PAgHCbNGiGr
    h56jIoEOXjw1oE1nelyBVljhB9fNihWlvNgzIqKHzCWrALAJ0DtvqTqnlQ7A89ugJ1fteo
    Qa7+I2Z+Q2HukCbvEgoOJQnfneCJ3Yd75nL6rEzhryyrqVigmOfYpaW840tJPTle5yvxYY
    eAiJ8b/qjxqhSRXTsWEzbZ5aiBKxZt/LsauKkJPpgeN1R/Tq0fO1zitsTtKp6j+mLjjrLa
    aXqQ/6BeSfH8n5+QmBkvUEfzkt15ZcQ6Q3WwFT3piK75kYaq5ClXLBEI9SXDXZSJ1h1JLK
    ckOIPsx0QFCV6zm3QkYe3EMIisy27SPdf72Q6fceKfOLAuk8LRsaeaIlTXXTaRgNLRkb0c
    04wgacwGtITs8tT7dIPkl+Xa5rsAr+yRveFCbKtN0d9qv/ZAxQqtqSIEt3Au/r1rdULLkm
    dDWNrupFKQBCfkaoj7dtt0l9otJwqxJc8RsTANA7SQI2N6EWGfyne1Sq6O0A
X-ME-Proxy: <xmx:R3Dbal5YVjr_j_CiDCJbn6Wqap92_Hhk_z83Lfc9ZoSst4DTyPmDZQ>
    <xmx:R3DbaqqXmk23QjCT5-nKxYYcPiV-A_aM5gPKC4qOeeM0uUW20p6cuw>
    <xmx:R3DbavjKLpYlikKru-9qjiRT8OlLpzGrkkPAJGyWuQ5ZE4DH8RQhTQ>
    <xmx:R3DbasK8eDMNZ3ozqjg2SSZbscMyJsfV1V0zwsXzFjyJrJUQnnxE3Q>
    <xmx:SHDbau375g9d9hjw34HkvbuylRu0Z19j4tQsQZDtdrVVOmXRiQfgq2Ac>
Feedback-ID: i8b11424c:Fastmail
Received: by mailuser.ams.internal (Postfix, from userid 501)
	id 7690F22C009C; Fri, 23 Oct 2026 10:33:42 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Post: <mailto:git@vger.kernel.org>
List-Help: <mailto:git+help@vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
List-Owner: <mailto:git+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
X-ThreadId: AvDGsdf4RFW7
Date: Fri, 23 Oct 2026 16:33:22 +0200
From: "Kristoffer Haugsbakk" <kristofferhaugsbakk@fastmail.com>
To: "D. Ben Knoble" <ben.knoble@gmail.com>, git@vger.kernel.org
Cc: "Patrick Steinhardt" <ps@pks.im>
Message-Id: <4f14a14a-99a9-4a01-bbab-ee1630e109f6@app.fastmail.com>
In-Reply-To: <cover.1792761643.git.ben.knoble@gmail.com>
References: <cover.1791827304.git.ben.knoble@gmail.com>
 <cover.1792761643.git.ben.knoble@gmail.com>
Subject: Re: [PATCH v2 0/5] stash completion miscellany
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On Fri, Oct 23, 2026, at 15:20, D. Ben Knoble wrote:
> This short patch series takes care of a few paper cuts in stash
> completion. The first patch is a small code cleanup I noticed a while
> back while working on bfc1b34859 (completion: add stash import, export,
> 2026-02-07), I think. The next 2 take care of a problem I've been havi=
ng
> with Zsh's completion of stashes (cf. Unix & Linux SE [1]).
>
> [1]: https://unix.stackexchange.com/q/807580/301073
>
>[snip]
>
> Generated-with: git format-patch @{u}.. -o p -v2
> --range-diff=3D@{u}..d1d0bf2d9a7d380d10771b5d1bceb8db91c5f05e
> --in-reply-to=3Dcover.1791827304.git.ben.knoble@gmail.com --cc=3D'Patr=
ick
> Steinhardt <ps@pks.im>'
>
> I accidentally left the above line in v1, but I'm considering leaving =
it in from
> now on?

;)

> It's the exact command I run to generate patches; I store it as a
> "trailer" in the branch description, then run "git generated-with"=E2=80=
=A0 which
> (effectively) does
>
>     eval "$(git bdesc | git interpret-trailers --parse | grep
> ^Generated-with | cut -d: -f 2-)"
>
> where "bdesc" is an alias for
>
>     git -c core.editor=3Dcat branch --edit-description | git stripspac=
e -s
>
> Anyway, I've been hand-editing them out of cover letters for the last =
few
> series, but if it doesn't bother anyone I'll just leave it around. Mig=
ht be
> helpful for new folks learning how to format patches?

I think it=E2=80=99s a decent-to-good idea to leave it in.

>
> =E2=80=A0:
> https://github.com/benknoble/Dotfiles/blob/master/links/bin/git-genera=
ted-with
>[snip]
