Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=103.168.172.146
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793997539;
	b=HjnFgmJwKbBsnkDXTGjFarh03TlXtSdhXDpRGoa56f6hmOGeicQ/y88RJiZ0Uoc+K/n9
	 WgQw+btccPw0FBOjz630tbvzyFfRivfIn3AKttC0d6HpGOCXH5zBHqfd9V1r4fH+0QpTh
	 gwvQsf07noe4yhNMyX0LDap0UTeHKOhGpjdC9TaHbUZ473fvS+58gv93+t0xp83aSRm1U
	 Lx4LwGij+J1xFOFK4JeBaGmGvwetKOgUipTR3X7LZjC66hrSw00g/9hPXev5vbejyF9//
	 iRbkA4WKgoxxo+WHfryPyw5ZbntbhcWpJKtj/+6rrfBC52m5SFdmVVYgnDHKYn9DWZw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793997539;
	h=DMARC-Filter:Received:Received:DKIM-Signature:DKIM-Signature:
	 X-DKIM2-Info:DKIM2-Signature:X-DKIM2-Info:Message-Instance:
	 X-ME-Sender:X-ME-Received:X-ME-Proxy-Cause:X-ME-Proxy:Feedback-ID:
	 Received:From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 User-Agent:MIME-Version:Content-Type;
	bh=TTBMl6ajOcGBpLB5hywvzwhWmbfi6sVmMul46vImGiI=;
	b=Dn1h9DEB4BWhyoBz3kgwcGfbAqJRbEoNbcOw3gCBEFi3fW0SC8fMWQ2wbw4gcAW2T28C
	 00bP+wZyATw65Bo9l3ydvjOclJQCudanXW+JneBJO7ERQ8tRX3US76zf90yXoP9FueV7S
	 AkE1P+2m7G8AkCbwWpw589LLXMZIIXiM3190i0cdXxgfQiYQl/HkG4PxXPgaMporXWMCc
	 9ALGClXmJlmjSN0/MMeuNxsGrxysKqwZaomUji04qafjBsWCUCbID2BCKIATLJt2ghsC/
	 WAljN63gz7IhKTAMP+3Xwm+W7sBHbrqs5bTUw8yfD3X28u/fCUNJ21as1UnZiNYzoiA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=pobox.com;
	spf=pass smtp.mailfrom=pobox.com;
	dkim=pass header.d=pobox.com header.i=@pobox.com header.a=rsa-sha256 header.s=fm2 header.b=Nq0nntqP;
	dkim=pass header.d=messagingengine.com header.i=@messagingengine.com header.a=rsa-sha256 header.s=fm3 header.b=bN4vfolB;
	arc=none smtp.remote-ip=103.168.172.146
Received: from fout-a3-smtp.messagingengine.com (fout-a3-smtp.messagingengine.com [103.168.172.146])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7114B606A326
	for <git@vger.kernel.org>; Fri,  6 Nov 2026 20:38:59 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 7114B606A326
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=pobox.com header.i=@pobox.com header.a=rsa-sha256 header.s=fm2 header.b=Nq0nntqP;
	dkim=pass (2048-bit key, unprotected) header.d=messagingengine.com header.i=@messagingengine.com header.a=rsa-sha256 header.s=fm3 header.b=bN4vfolB
Received: from phl-compute-03.internal (phl-compute-03.internal [10.202.2.43])
	by mailfout.phl.internal (Postfix) with ESMTP id AA4BFEC016E
	for <git@vger.kernel.org>; Fri,  6 Nov 2026 15:38:58 -0500 (EST)
Received: from phl-frontend-01 ([10.202.2.160])
  by phl-compute-03.internal (MEProxy); Fri, 06 Nov 2026 15:38:58 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1793997538; x=1794083938; bh=TTBMl6ajOc
	GBpLB5hywvzwhWmbfi6sVmMul46vImGiI=; b=Nq0nntqPDerZBefaeBKticcTXD
	uSC7dkW1hqIOGdIxoJnBvYxvlTmimbueWgG845NZpNmZR02h1NBmT/WJhF/CvI22
	rJZdXLctPSV9GocC55tHMxUqc81IWUKeAneS1IEyrj+z9qJPqfO6oTwbcQIkZAmX
	CvCWYY1EiQzWJ5FBsVS5ylCnsEN/QmfWtr4KEtWNf427Qj+U06n7CKGGs0w7BKKC
	QWoWbTpVtP6me8mtmiToW07ykiKow9C0eYTWfjCjTbjqVBZjFmt9zUUKZQMbDksp
	MlNUqldVzaegMv3dyXqkP9tGPgwZXwSderSfmRiAMgPk8z9h9RlnOM0cjJXw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
	1793997538; x=1794083938; bh=TTBMl6ajOcGBpLB5hywvzwhWmbfi6sVmMul
	46vImGiI=; b=bN4vfolBe4+4tns08Yj53fjKoeAHLiOR2gr6xO5ZCFpfZyY0LSZ
	h5MvAwZMIPpfd5tfkDk/m3Uw+9mRFIWDWgCYuqwMQ3WXi/L1pCI95N6MpH34gIor
	P0BFStahc6o1sB0qaQudZrkW+PNDbbBo5xoD1LvUaIPdmwgb5ZvR6KciNL5Ztfkk
	67vJa/YDEQOJWycLTk9gZXQt+TFs2yfUVj/Wvl7LiYkVeSE36SDGw5cXLODlU3rY
	1sLfCe48Z1I1FjvzoUCgc331Jj6aGhok2KIl9/FBTv2arn+cI+G3Px/erDvkCBVR
	nqvvp8cqsajh8pEMLbZbnw0k48OMON2RJlw==
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-09;
	repo=github.com/dkim2wg/interop; date=2026-11-03; sw=lmtpprox;
	action=sign d=pobox.com a=rsa-sha256;
DKIM2-Signature: i=1; m=1; t=1793997538; d=pobox.com;
	mf=PGdpdHN0ZXJAcG9ib3guY29tPg==;
	rt=PGdpdEB2Z2VyLmtlcm5lbC5vcmc+;
	s=fm2:rsa-sha256:dLMFFlDYGxc8+HE3kK0ulxew6f8dVOMKOXG/eVR/fqOmjic
	h5ZfEcCzTidJ8bCvFiMYtefNmPoB/rApoHFUN0NzluetERjzcesoles6/43m60yL
	QZ3nKlgCdCTXd9PEb5K6BEf3YiBmD/DpBcTXijLNjBdrsUfnqbrXOzZAvr5wDs4V
	qFLqC1eauIOl2IhuyHTLfZwbATAlEEpbFxD9o5Adkf72dOIMh2WJd0QSlwJI96+7
	X57Pa/q787AeMrTD/gMJZL4iDOCYPp3aH4Lh653YGx8n3xJoJE8UaKix21qw1p8d
	7QRmtO6H1SBBLQjs+Qvyr73nOmtCjiSSAGabu9g==;
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-09;
	repo=github.com/dkim2wg/interop; date=2026-11-03; sw=lmtpprox;
	action=mi-m=1; hc=12;
	hn=cc,content-type,date,feedback-id,from,in-reply-to,message-id,
	mime-version,references,subject,to,user-agent;
Message-Instance: m=1; h=sha256:GoE1I8oblSU0rKQBwW9FInjgj47o2JfOelCQR0htgLw=:s0zYm27oCc3MO+OTEQzSASLg2/NV1NS5xSEiWVKLnT4=;
X-ME-Sender: <xms:4jruapWHV9-AqeZToPSUYGGlh_GnZayn4FDw_i37ebILE1oNb7gzvw>
    <xme:4jruaglZn1Lxy9UZ3ukx-0-C-F72ZjrNF0J95Tn3NWBc93R_FLKZPgqgiK5Lf86F5
    6UzSRyxxIEWqvxoRUxb_SXqQt_CY0w8exNTro6MyVHT_MLsAVJFQNlv>
X-ME-Received: <xmr:4jruaqYMDaiXfxrPE42IO506OceOAVDUFCyGkCtWnCteQ8EaqIem0BWhVI6Fr68cpoxddkbbDKloa1SV4LUrqgnIQGCubXn1WXKK>
X-ME-Proxy-Cause: dmFkZTFiTAGG5Jc+6v9dsnksxJGvvFHjd2OAxUdTCewWI31/asch+FmCjGL4jLxSQXQTOb
    CbDUIP0PY8CB+VULHqQys0igNwoK6cobxSWD/EZ63++Yvxfyc0vTRHCPP009wkri8PUyTr
    ZtXpfEog0WyW99/+3XWgZ/TNbJ+Is/IrKpMki7F06HGJy1h3LZHY510EIT03Mw8cBAe9eu
    Od801QdggRkGkVAC/84vFmI280L4CnsP9v2rPCFouB3ipBi8CDWC+pUKww6bc6a464t94/
    ax3pnN6Pl32XBvLJT/mlGU7xzRyXYnTyh+ygDDUNyOOoyLcLeEfWet4gUmyBff3tt72Nd4
    yog6dEMzgfg49i9Waoh+53rL0UjGHi6WWqqI5Xoxhvne75W83pXoy16gdiHuWFyGFeY47P
    T7brW/TwgstnmjrPP80/Oj+7s6PM+E42qBkdB/zNXRfEg47kZ6iYJSATUvxdqIWhCBnPXR
    iYACAHHJoAup1E0H1vdtNfvUpvWqcZqfvjzfUNYc3UTQ/1sEzPAhSiQxfDp9JVaeaCPZl2
    BY4fmSKFOwtl1hu91iV1UtxPpP1bo6tkTG9IzxnFap/OF8P73Bqwy7HbFC1vS6ozW4ROXI
    7+yYnfcZ+n4TG7R6MbvbwnXhEsUgijeQHf5AnIs4JEFSax1p8o6uwrVlD3NQ
X-ME-Proxy: <xmx:4jruarOUE700_zfb09_6xDCAti8m4cwvdQDf6BeiYdHDY87SpYHYDg>
    <xmx:4jruavZXNBUiR-uJSKaCK65hU-brgukNIAH8xcKTWEkKlwFpsNhvuA>
    <xmx:4jruap3FrscEtBXWcpVsnMBv28_9ziQEUYaADCeawWNfMqJhQX94BQ>
    <xmx:4jrualdFnOUN_3R6lwYtd2wDnmftqIgMIxgkZMI8gYwEoiRu1HdNqQ>
    <xmx:4jrual4-WjB5vcUcOs0ZQYJtVI5KufQ39QHa9Ghqy47tU0h4N0ge2WCB>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 6 Nov 2026 15:38:58 -0500 (EST)
From: Junio C Hamano <gitster@pobox.com>
To: Phillip Wood <phillip.wood123@gmail.com>
Cc: Patrick Steinhardt <ps@pks.im>,  git@vger.kernel.org
Subject: Re: Ejecting things more aggressively out of 'seen'?
In-Reply-To: <48a6c039-75b6-4fa4-a18e-ea3240037be9@gmail.com> (Phillip Wood's
	message of "Mon, 2 Nov 2026 16:34:23 +0000")
References: <xmqqfr15ruw7.fsf@gitster.g>
	<f5f7af53-df3e-4902-b350-8fcf8ccb02ad@gmail.com>
	<xmqq1pclc210.fsf@gitster.g>
	<414ebe62-c7f6-4d44-bde2-b689e35accfc@gmail.com>
	<xmqqbjbpptzr.fsf@gitster.g>
	<47bd0302-fc52-4df0-98a0-6fad7eb0fb05@gmail.com>
	<xmqq1p93ofjx.fsf@gitster.g> <auhfD1ryB-7JwOYl@pks.im>
	<xmqqv76fjjhg.fsf@gitster.g>
	<48a6c039-75b6-4fa4-a18e-ea3240037be9@gmail.com>
Date: Fri, 06 Nov 2026 12:38:57 -0800
Message-ID: <xmqqqzgxg0f2.fsf@gitster.g>
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

> Perhaps making it clear that when a topic is ejected it can be re-added 
> if there is renewed interest in it would lessen any worry about 
> demotivating contributors?

Yes, that is a good suggestion.

Mentioning this possibility when a topic is ejected from 'seen'
should help soften the impact and clarify that ejection is not a
permanent rejection, just a reflection of current review.

I'll try this as the heading for the discarded section.

    [Discarded]

    Many of these topics were picked up prematurely but did not prove
    ready for inclusion, and will be removed.  They can be resubmit if
    they gained enough interest and showed good fit to the system in the
    future, unless noted otherwise.
