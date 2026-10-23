Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=202.12.124.157
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792780206;
	b=xllZtQJkJ7XJUhmMKQkcddeJXTaoEp8+1aOIaFLUU3QIQuuelWxaOY2KkUEq9Rgg8GOC
	 UabnDGXtMUclKJIvCOjEkjx6jLVQ/lUjBSpMCNjPidDXtcMumQoT37vqBnPODmrS/TQny
	 y1HExDGuT/hkhcytn0ZKWgBnO4uocEHIafmQSrIYnmFYfray4/32t0bClgLszq5rulPUo
	 wk11sCEmDJVg5YHh/oMxvbZSzEOu+1WenrwH54phaj1W/vNNnOetIQXoVjchfs4us3Ynz
	 uy6BjWHGV3srCM0W5W3ILx3uBaAVv3y1deXdWAQSyzWhEbfINHhu2z5nXYql0LTK33Q==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792780206;
	h=DMARC-Filter:Received:Received:DKIM-Signature:DKIM-Signature:
	 X-DKIM2-Info:DKIM2-Signature:X-DKIM2-Info:Message-Instance:
	 X-ME-Sender:X-ME-Received:X-ME-Proxy-Cause:X-ME-Proxy:Feedback-ID:
	 Received:From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 User-Agent:MIME-Version:Content-Type;
	bh=luMIxewqg4J9NC7SJnb29nKaVuYccm+Cz9xXvOMSgpA=;
	b=K/icQ5Baj36S5iA787X1LZL8rFJfbrO1Oqgt9CJuZRuFsttF9i0BeN+8PoNQ3Kan1mh2
	 gnhD/QUJNITRLPEtyXlpBYMLks1q1Vd1TyXpneTQWvWS/oM0DJCKMOWvQDFoRDygHMFro
	 ZM7nuFrzcn+hnkg/ejUjofWZschE7KFFa7gGpARzsTDKt/upmU8vkP2ncJav1KlMxrjX8
	 QUvm+Bw1GiDYiZimgO+wOJ9c17KxQwy4Q/vf4wVE3kYvyxklnElMPamqhubsaDZHYNDs2
	 SWQQZIK1QtemeD5r7XKm0d/r9PhG9SwZlzaWIhMVt4NpKzUIJH3kJeZARucLcp5shbw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=pobox.com;
	spf=pass smtp.mailfrom=pobox.com;
	dkim=pass header.d=pobox.com header.i=@pobox.com header.a=rsa-sha256 header.s=fm1 header.b=fkuwTH59;
	dkim=pass header.d=messagingengine.com header.i=@messagingengine.com header.a=rsa-sha256 header.s=fm2 header.b=d0x6LYkX;
	arc=none smtp.remote-ip=202.12.124.157
Received: from fhigh-b6-smtp.messagingengine.com (fhigh-b6-smtp.messagingengine.com [202.12.124.157])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3867B606A31A
	for <git@vger.kernel.org>; Fri, 23 Oct 2026 18:30:06 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 3867B606A31A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=pobox.com header.i=@pobox.com header.a=rsa-sha256 header.s=fm1 header.b=fkuwTH59;
	dkim=pass (2048-bit key, unprotected) header.d=messagingengine.com header.i=@messagingengine.com header.a=rsa-sha256 header.s=fm2 header.b=d0x6LYkX
Received: from phl-compute-06.internal (phl-compute-06.internal [10.202.2.46])
	by mailfhigh.stl.internal (Postfix) with ESMTP id 447407A015C
	for <git@vger.kernel.org>; Fri, 23 Oct 2026 14:30:05 -0400 (EDT)
Received: from phl-frontend-01 ([10.202.2.160])
  by phl-compute-06.internal (MEProxy); Fri, 23 Oct 2026 14:30:05 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1792780204; x=1792866604; bh=luMIxewqg4
	J9NC7SJnb29nKaVuYccm+Cz9xXvOMSgpA=; b=fkuwTH59LNKmRpIQd6Wcg/OLiF
	gkLscl5cxO1VkGHO6JnLMBul3WrPm/HlLXL+A+v8IXSdb9rK28m9RWIiwYzWQNTE
	OJ6SzXzjrYMVaEPxm+rNm3f+0wSAp9nA33a09R9bJerIi8A20F419J2FU2rVbFUM
	AaeCWi4VfxySA5z78tAAQQlXO/FCL5OSo0/C43QTfHi3KTbRmQgi9Wxir/Ui9T+g
	Q+CXjmRAZDhG1jVBqCgx0n5vlzYT09GDY3cX5RcNxGkSQe+I897qP2qEYeV1qMHR
	rdMOYSwF4dmjzWdc6qWexhvIDrzQ5LkINkj7iIAXOM5WmcrdVhSuFzfuLtKQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=
	1792780204; x=1792866604; bh=luMIxewqg4J9NC7SJnb29nKaVuYccm+Cz9x
	XvOMSgpA=; b=d0x6LYkXRE5SXjQj7obE94hzV/s6Bv827GoOyr9KNkMRDqnGmZq
	DDyXPqsc/yxC2HuJiDkhn3fWNcdv0J07Zd5qwfR2lNDR8jZ8EAcXeyK5YI2E5SgI
	7A+b7LnSw+poKmrRhGxJ0+p4SThWWDWDRcl7Nv2VpB44VyY5uY97uLSben6BLUKI
	0rR4cYbcFPdWlFEFITFKgfCiu5NTLWHMhGelFCywSR+F7dwHOakL5WpMuQEqTDJF
	iJfVbIcsMaw6KsEWbz4friHCn+Y7lMyTjsZf+uTWJraDa7BIgxy6YeV8WUj5VLZi
	y14sIvQmeYv6stEgK7izthigjrZSqHL/Fcg==
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-07;
	repo=github.com/dkim2wg/interop; date=2026-10-18; sw=lmtpprox;
	action=sign d=pobox.com a=rsa-sha256;
DKIM2-Signature: i=1; m=1; t=1792780204; d=pobox.com;
	mf=PGdpdHN0ZXJAcG9ib3guY29tPg==;
	rt=PGdpdEB2Z2VyLmtlcm5lbC5vcmc+;
	s=fm1:rsa-sha256:ebFcvFdSRkEadZLHlmLQk9nUWT4VvJwq24BhpBJ9ECJo7zS
	eqq8/dSSuJg8oDaV8i3Opne1PQ1je7wlbnMQQ2ovwDsWjqOa0DfgED4SvzKbmpJp
	TWb/9Hu7EV73tzPkhl5/m3yzPsSK5m/Oc5aLm4kstBDrjzggswTtWdUDszF+hjFe
	HRaDvGMo3/BJOGuDe5tiuUrc2TMkJ4yBZ0fF4UCGEERCSYxlUdLVqw79It27U8Mq
	FDihKf1xmGaD+GcTxGH/mRQchFnS0DkUKrX/+VH/0PB4Y/NwUAMBCkB9GAjNvpTq
	GSKV80gLzHnqU79WAwImZXmuyM8WlmPI1JYCibw==;
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-07;
	repo=github.com/dkim2wg/interop; date=2026-10-18; sw=lmtpprox;
	action=mi-m=1; hc=12;
	hn=cc,content-type,date,feedback-id,from,in-reply-to,message-id,
	mime-version,references,subject,to,user-agent;
Message-Instance: m=1; h=sha256:b+xIwR8Kg+Ren5Q87Dw5UpO+3QcsnwZRSAr8IwLuHIs=:mTaefBvb/6rkHxpWUYb8SRK75x3JkztZGgQJyHApx7Y=;
X-ME-Sender: <xms:rKfbaknyTlwE5N3HS9dkGisa56p4xG-rwFaijbdv__yZ_3wEI2wlSw>
    <xme:rKfbangACNzF_ESTHQ7R2GBPukOXAeaEjbDc0TgR5gUHv7Z6leBEIJn48r7xAxy_7
    jkTzhNS2hM0lwmj8EaM7_xUNcs_TZCNefEF8W9ZqTYu8UNq15ckWA>
X-ME-Received: <xmr:rKfbasddN6e39AIC9TVS2vXdVjJSlpgo5ziVm11zpVA0fqrL01f0InuNmIuIOK551dMuq-L_mNcHtwD4n7eH-HiQT7R9OR7qz16Y>
X-ME-Proxy-Cause: dmFkZTFf7iDiHzDf3TvRb4RaNrKg5h1jSotayf8BWcM4mbcUC5ofQ8HZak1aCFDKe733jG
    FtGbVEsEVMArU3jmxel/0EiID79H0kZbIpWn83lp4iKt9jzxJAw2ID21hlD8YobVnU7QTQ
    TBuHBA6eUIV+KDAbPa+OYHaJznyBaq8YLWiYAI/FzNuq5ExbDh7/HIFX+8Yt82TcIOAFoh
    JGxd25qRTbmlaJfTWi4J/JpZd6g/RkF9RXwEZh7L4GLYwrEfybECr8q8R0NZ110jdhWNM0
    W7wuEggBFKuyX/g9NPMMjUZTMmfCyUthaF3/X9PP703bIafya2B1nj6eEnZbF7h+kfn7Cr
    IQMI+CbMQEGx24HCik0QiUs/o1ydiIfkcxB+ECJqYpZAVFJKq51yX3cLvzuLp+evyjv1w8
    WdPeeHeWOSdw2/vi9awJYjF2RAaoHPIJrCHErwLQ8tBcb7lg3t2LUlx3z5l9ljTC7Qw8mg
    kXJBGqGfciMqcQkaKNAhEPdwlKrXvHSSXnk7R29aPYWNIKX0yVPHyNqfBWbtPQCMsbNq07
    OEchI5dnsLwv2uPi5w4io2oD2RG40SL4T9qjlHbCrU32e4jWf9WiOiVmDbTlJauebTlpo4
    8lZ0o0bJrjHtFvun2dGzwj71oQNIFs0Wl6Qv3Bks7Wg17j2Q6tlf1rPRI3gw
X-ME-Proxy: <xmx:rKfbangnNdqRM_OlebXUZdtrMiep1rrLAvz04z-DCnZl6NJQmoUK6Q>
    <xmx:rKfbakxtLYOAaZ13et3QNPQu505GN_G04n3TAzS41X_Gn3fdfV0SBg>
    <xmx:rKfbajPwyeMomb1vn5mSK_olJAs1uPuJxvgUhAsotuZ-vhmpIE_RJg>
    <xmx:rKfbalWO1SFM_emXfSCL8YI5hEJMpl9B_Dl5X7ADIWCMOMdp_Z7EYQ>
    <xmx:rKfbatFcDQpp9joye05ifEnEhuce8dJ5ulXkw_0qSt-6oOy8VTB2EliX>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 23 Oct 2026 14:30:03 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: Jasper Mayone <me@jaspermayone.com>
Cc: git@vger.kernel.org,  haraldnordgren@gmail.com,
  sunshine@sunshineco.com,  ben.knoble@gmail.com
Subject: Re: [RFC PATCH 1/1] worktree list: add --merged and --no-merged
In-Reply-To: <20261021173350.67854-2-me@jaspermayone.com> (Jasper Mayone's
	message of "Wed, 21 Oct 2026 13:33:37 -0400")
References: <20261021173350.67854-1-me@jaspermayone.com>
	<20261021173350.67854-2-me@jaspermayone.com>
Date: Fri, 23 Oct 2026 11:30:02 -0700
Message-ID: <xmqqqzhg5kyd.fsf@gitster.g>
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

Jasper Mayone <me@jaspermayone.com> writes:

> Users who keep one worktree per topic have no direct way to find the
> worktrees whose work has already landed. "git branch --merged" lists
> the branches, but the user then has to match each branch to a
> worktree by hand, and a detached worktree has no branch to match.
> "git branch --delete-merged" skips any branch that is checked out in
> a worktree, so these are exactly the branches it leaves behind.

Real review on this patch never happened, it seems, perhaps because
a discussion on a side issue distracted everybody?

It looks like the intro unfairly narrows the problem space.  Even
for those users who do not use one worktree per topic do need to
find worktrees based on what branch they check out.  While I agree
that among the criteria to choose these branches to filter worktrees
on, "--merged" and "--not-merged" may be two of the most useful ones,
the feature does not have to be limited to them.

I wonder if "git worktree list --branch=...", where --branch= can be
given multiple times, is a better primitive?  With that you could do
something like

  $ git worktree list $(git branch --contains HEAD | sed -e 's/^/--branch=/')

to reuse the same machinery without any extra code.
