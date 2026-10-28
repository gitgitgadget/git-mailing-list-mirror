Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=202.12.124.151
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793172374;
	b=ktZCKYCBuaW5ieOwzWuw0x4SLzyKZXk6axt9EQ9ir4waUnySkLi9WTRVvCL3Q6L7i1tp
	 Dg+5wsLxMYE01WucLSu+TBoUTpBUoq5G2Skldjq5YyG+udbf7ciuhG6VeHTHKzmSwUW+o
	 1Gk5vCgxtp/3M70zP3FMzCtVOZI+uLl0rb9TQ6f/Ca2PctFXmMCOLZUzr25m3T6Ctdn8R
	 pTRzoQKRiboOP+WuhSmoMYQHYoIlsqR/yjI7aPMDP/E7VPjpqOgQg+NiJ94+48m4l9qTs
	 ySLE5JEYY2U7GBqXHblBr/jtzjqQ6SWH1rhoz3N14FcsbxexoN5nlAC6cCiPI5TTs0g==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793172374;
	h=DMARC-Filter:Received:Received:DKIM-Signature:DKIM-Signature:
	 X-DKIM2-Info:DKIM2-Signature:X-DKIM2-Info:Message-Instance:
	 X-ME-Sender:X-ME-Received:X-ME-Proxy-Cause:X-ME-Proxy:Feedback-ID:
	 Received:Received:Date:From:To:Cc:Subject:Message-ID:References:
	 MIME-Version:Content-Type:Content-Disposition:In-Reply-To;
	bh=yid6IZQJoo/a/LohgOnRJTy3I9kxp5+TQiYYq+uhoOM=;
	b=MCydgdYWV7UWha8OM/D6vlTZUr3J2JuLzPFlEuXPMmFZtiDSbIdkj/f/QMwbgCeTS6ND
	 PmPEBYHqF2KVklPbN3gmKhFmypKj5AKONFyr2rXSMs/pCjEGeu1ElFNy+H58vBJUfzif2
	 mdyBYsCj54gC9BPxL8aZ21zd94t7eP3U796yHWf6mbbJ1a+3K2nyOk19tSWlC6eUK1K7Q
	 ZxICR0aFPd9NgA3oH6mIk/S0yQL5hP7Hc29MyLo+kmQgVgOozXvXJpcEI9ojs8vEv1QSt
	 NKp+j393lj8eLel47O3HbH5H+Tj8KZhgyPeyT6uLrZksJkLOpTr56XoC7xZJspOyn2g==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=pks.im;
	spf=pass smtp.mailfrom=pks.im;
	dkim=pass header.d=pks.im header.i=@pks.im header.a=rsa-sha256 header.s=fm2 header.b=UjPWFhwG;
	dkim=pass header.d=messagingengine.com header.i=@messagingengine.com header.a=rsa-sha256 header.s=fm2 header.b=mUS0SLmf;
	arc=none smtp.remote-ip=202.12.124.151
Received: from fout-b8-smtp.messagingengine.com (fout-b8-smtp.messagingengine.com [202.12.124.151])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C77FF606A31A
	for <git@vger.kernel.org>; Wed, 28 Oct 2026 07:26:13 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org C77FF606A31A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=pks.im header.i=@pks.im header.a=rsa-sha256 header.s=fm2 header.b=UjPWFhwG;
	dkim=pass (2048-bit key, unprotected) header.d=messagingengine.com header.i=@messagingengine.com header.a=rsa-sha256 header.s=fm2 header.b=mUS0SLmf
Received: from phl-compute-08.internal (phl-compute-08.internal [10.202.2.48])
	by mailfout.stl.internal (Postfix) with ESMTP id DED431D00179
	for <git@vger.kernel.org>; Wed, 28 Oct 2026 03:26:12 -0400 (EDT)
Received: from phl-frontend-03 ([10.202.2.162])
  by phl-compute-08.internal (MEProxy); Wed, 28 Oct 2026 03:26:12 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1793172371; x=1793258771; bh=yid6IZQJoo
	/a/LohgOnRJTy3I9kxp5+TQiYYq+uhoOM=; b=UjPWFhwGXWuGSvPQGEkm7MOUk5
	QweMiok6UAPgIyN1T/RL+RUeAMNGKMXV56ovF8uG/tqaeHB02vmN60nOkBmkafB0
	1vs7MeqyQ8UcU4hxbAY4QTs/dFdrMjV415VsFr2HveafnY/meGjGicNxMn3dSy+3
	qOTA2zWtLBG/CQDtP1iX8//bxuvuI2neNxV7Yk7n5286VnXn6xzeIokUX8gJWzA9
	UMY7lnXqQT0NcUs/2NTxaGimxlW+fZEWpiJZt2kCzCxkIZdWC3kCImuXjS3V2IgI
	nEzF1BJIoU5O2uPsAFwxlxye596/y4KN1psjSiggfIUsHhOg0kQzXrPSetZg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=
	1793172371; x=1793258771; bh=yid6IZQJoo/a/LohgOnRJTy3I9kxp5+TQiY
	Yq+uhoOM=; b=mUS0SLmfJ8eAf9L4FlWRqH2gesdly8e0FTCl31BmCIuYT0/D0DU
	k4n7cfhWLQW7ksW7Uvsxsywi7GezT6NBKIsHHhc1XETvonp+ZsOEjoU5vcBsDprC
	0H7QBFO7l7RzMmnUl5yIOWg63A8tk9v88KOgjG7Eew6GyR0/OKrs555+CL39bLJT
	OCNbQniKCkNXMaPaDYbe04qA9Fo5DaLYz4ULhvhSVK5MfAmk/POmaJDhvSwGWOfS
	fWt5u4Ahs81oEPBY+Pu6X5mnG3ATxAiuORO6tDyfenwzrHss3ZZ43+pHXoPxrdoR
	Mqh+apOsC45ZtxNLjZCPlYdgQkHHKlf8TPQ==
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-07;
	repo=github.com/dkim2wg/interop; date=2026-10-18; sw=lmtpprox;
	action=sign d=pks.im a=rsa-sha256;
DKIM2-Signature: i=1; m=1; t=1793172371; d=pks.im; mf=PHBzQHBrcy5pbT4=;
	rt=PGdpdEB2Z2VyLmtlcm5lbC5vcmc+;
	s=fm2:rsa-sha256:UasFsyiMiEuz0fzAHwm03WQPhUhRP2NPRQufJMRgHlJOBr+
	9ZC20PXfw9zByi6D0zWLPs2BkVutKaEiDKpO8b+1qp3RTYVRZAzrmQq2YChd8jP8
	h5ka0Mlpeb3k7zRmLtFeqbKjiCXtePgpoX5eCtskAILEo30xp99TKEg2kBhnSs4p
	zr0r+g3QEO+kddrAXJYxMTbJqXVLKzOolTfApbd1hLt8iaiWvaZoLgGDpvXLzxmo
	okJ0yy+/ZKy9vYHMJu72rwjvqvQdarDBEggZFxoOiQ7DVxPKCeECPtsZ9V629ZYB
	/oJKV9LhWcHHoEDCleLetXGJtpN2c28OQHuCO1Q==;
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-07;
	repo=github.com/dkim2wg/interop; date=2026-10-18; sw=lmtpprox;
	action=mi-m=1; hc=12;
	hn=cc,content-disposition,content-type,date,feedback-id,from,
	in-reply-to,message-id,mime-version,references,subject,to;
Message-Instance: m=1; h=sha256:8nnf6TFPaKmQ9MaWRtWfRhta60/zLvmw8TbOsYdiAc0=:v8NuCOJJfHi4MmoooXJG2GutG/anMEh42IZLWyNtTzE=;
X-ME-Sender: <xms:k6PharU71SB35fLIkI4QhioraDrKWWBd2UMA-gdDCJzcwnSC3SOQmw>
    <xme:k6PharABHUHdpqk69UhLZ64Bux77FC7lXSoRQ8qyhDtOD9OD4hL0cAyIiFdYSkunj
    1RmIa63dJHagscMEo8FeFYCvaKC1J_yvNnUlXmPo7Pp8z5yXsiKEDs>
X-ME-Received: <xmr:k6PhakzgmysyR3mi67MviFXaAxxAaQlI7UagpOTFyz-r2smncQbODw>
X-ME-Proxy-Cause: dmFkZTFOLpUHFEP9LTD6IGSTgHYy0O9LTlme+oye1W71CQWrm5T5p/zTaIMTxb9awqtnm+
    42S9Qbv1CY3SkxeUzL1abWg+r5RVABqlOzeb205MXP2p84uTKwiteyrMkQ4aKQf2lF3tKW
    +ke4oI4IcB8E3TWJk4DtZHmz8Uf9COD5MF1BkzJjV6ON4iVCmwPA+4FimtajVMcUKXQZry
    CRiUplhsBzUvo3HmVk4gqsc5WU1UisgX+Ui96UshbUG/LJwRVqSlmDN+rTvvDpTQzjNQ/S
    Q9rO5L6L/LpNjHjCDNkPdPBcUqOugO7ma6f1rZDn+PVy/aEuDGt80NlXV6mNjOSQPuI4L+
    lcgCmKKCpfqz3qMkqgO2oRnpT4KNl3ngEOKddgd3FfwGXLyFIWP9BEwTN8MYdn7rM8ATzS
    FVrrt+YTDvNILdUGSMJtsOLQ9qVH+pGuN91DJUopiZ6+ZHvaMWbJgdx8Zq6u4FOsyqYLE9
    XIktXjkN5Yihxk2dBDKdFQoD0Eyv4x7jzKvkHQQaxGXUxWd5lZjkG7rgxFE1vGZmGmIQOt
    SjEC4v+zP6BClwF/QyRjGoY13WR1RiLvwT4DBLnWDaScFP1FMgCr3WHQxkhahG5oXlB91B
    zPoREvWS44N0B0wYpBKZCkqYsy0qCE1drvfCUS+C8/PkVwtzkyrJnSKI+5Dw
X-ME-Proxy: <xmx:k6PhagBMvTPgX-noZyT-vNbmbLAd6zGf8nAwVJ_nVKbn0mqhIwN0Mg>
    <xmx:k6PhapbXQpS49mFqYqp7E6HEDRKNVVAs9KZYyOIJDWmK4-5IszHJOw>
    <xmx:k6PhaggQAAsHJnE4pDXsM1MddKqQR69tnAO_WsX201KVaL7sZwAh5g>
    <xmx:k6Phaj4NoeKTlnhnwmnl2s1rVj4xQqXE-4Bc12i9C1Xbz_h-2RAftw>
    <xmx:k6PhavCnS0lA5j2qofhIGDwIvbbMeEm1IahEJvKWeJSlxOuKPYUg_QR6>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 28 Oct 2026 03:26:10 -0400 (EDT)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id 691a36ec (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Wed, 28 Oct 2026 07:26:09 +0000 (UTC)
Date: Wed, 28 Oct 2026 08:26:06 +0100
From: Patrick Steinhardt <ps@pks.im>
To: "Mark C. Chu-Carroll" <markchucarroll@fastmail.com>
Cc: git@vger.kernel.org, Daniel Zoghalchali <daniel@latchkey.dev>
Subject: Re: [PATCH] pack-objects: handle missing objects kkkjwhen excluding
 promisor objects
Message-ID: <auGjjv-zVYPFQLIK@pks.im>
References: <20261027-b4-pks-pack-objects-repack-links-with-missing-objects-v1-1-f50f90651274@pks.im>
 <03704f3590183aadc16d5d81bdc64e9a@fastmail.com>
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
In-Reply-To: <03704f3590183aadc16d5d81bdc64e9a@fastmail.com>

On Tue, Oct 27, 2026 at 12:02:11PM -0400, Mark C. Chu-Carroll wrote:
> 
> On Tue, 27 Oct 2026 08:00:28 +0100, Patrick Steinhardt <ps@pks.im> wrote:
> > In a partial clone Git tries to maintain two different sets of objects:
> > promisor objects should be those that we have received from the remote,
> > and any such object may not be fully connected. Locally created objects
> > on the other hand should be stored as non-promisor objects. The goal is
> > that promisor objects should never reference non-promisor objects as the
> > "promisor" property is contagious, where a promisor implicitly means
> > that any of its referenced objects are promisor objects, too.
> 
> Wordsmithing nitpick: this reads awkwardly. You start by saying there 
> are two different kinds of things, and then introduce one of them,
> followed by a comma, followed by something which _isn't_ the second 
> type of thing.
> 
> Maybe:
> In a partial clone, Git tries to maintain two different sets of objects:
> promisor objects (which are those we have recieved from a remote, and may 
> not be fully connected), and non-promisor objects (including any locally
> created objects). The goal is that .... 

That reads better indeed. Queued locally for now, I'll wait a bit longer
before sending this out. Thanks!

Patrick
