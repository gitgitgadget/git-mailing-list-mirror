Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=202.12.124.158
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794401336;
	b=D5rTuTDxkIFUkmivZalMTgaaxUun+5S6OazxpnQJKSXvE5kkDGpb2oD88KMQlhM47sOE
	 J86KQUG4t99Vo4k85rbJWwPCX0oMCpSL3/JvcuFghQWHWGZCbLLo+EOpeOzqhvwnM/KNP
	 M905quckqvt/69RJGDV2PHrgEBTVCgG815daD5vOKJe7kiiFxQWGbnrfG+UINS7YAZy2o
	 14ijwOeyvdlL3TusuPmj9szMC37qbn2P37455SSV0Rzu2gW+JYSglyYdIrvl/NNQhnmGu
	 /u9PUvosow8gnKOHtVWexhwaqCJW9eXwRrl/X9UYDpstGyB12SxSPY4WV5Jy+h+GTkQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794401336;
	h=DMARC-Filter:Received:Received:DKIM-Signature:DKIM-Signature:
	 X-DKIM2-Info:DKIM2-Signature:X-DKIM2-Info:Message-Instance:
	 X-ME-Sender:X-ME-Received:X-ME-Proxy-Cause:X-ME-Proxy:Feedback-ID:
	 Received:Received:Date:From:To:Cc:Subject:Message-ID:References:
	 MIME-Version:Content-Type:Content-Disposition:In-Reply-To;
	bh=sCQf8F6niWrO3zug4rkejUDrMyMqv6bQqJ+JXU/LSCw=;
	b=KBqFcMYB2vwkid9/7X5VybGM/rVohNJVAPV3jfKffF4onzuP0PaJUK/LL3EkAviLc3qM
	 7o4pT/9KzgVW8VXtd1TtT35DE0ZnkPXSZsa+sSVdPfuWNXwlgpd0MPZH2ScOtCtm7akA1
	 YUc/L7DZM5rqqdMXAs4NsfnxiwJ4ctp3vzkpASSrT0GedRx8xczPoYM/Gw9esB6hAJXDQ
	 UM3qG/B1vNLg8RNbEiRIUZxTCGDJ7upU+Cs7UAO91P9H87A0j5YUd8sglESntgJ//BLL5
	 XglI1sNFFpZ2DXpjtHBfLk8IS7+yrOBybKrwOCC76riM8gZtFj6iEW38uhIaYLfkcHg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=pks.im;
	spf=pass smtp.mailfrom=pks.im;
	dkim=pass header.d=pks.im header.i=@pks.im header.a=rsa-sha256 header.s=fm3 header.b=F46sLzjJ;
	dkim=pass header.d=messagingengine.com header.i=@messagingengine.com header.a=rsa-sha256 header.s=fm3 header.b=yMDy9Hhm;
	arc=none smtp.remote-ip=202.12.124.158
Received: from fhigh-b7-smtp.messagingengine.com (fhigh-b7-smtp.messagingengine.com [202.12.124.158])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8DFA3606A321
	for <git@vger.kernel.org>; Wed, 11 Nov 2026 12:48:55 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 8DFA3606A321
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=pks.im header.i=@pks.im header.a=rsa-sha256 header.s=fm3 header.b=F46sLzjJ;
	dkim=pass (2048-bit key, unprotected) header.d=messagingengine.com header.i=@messagingengine.com header.a=rsa-sha256 header.s=fm3 header.b=yMDy9Hhm
Received: from phl-compute-06.internal (phl-compute-06.internal [10.202.2.46])
	by mailfhigh.stl.internal (Postfix) with ESMTP id B6BDB7A029A
	for <git@vger.kernel.org>; Wed, 11 Nov 2026 07:48:54 -0500 (EST)
Received: from phl-frontend-03 ([10.202.2.162])
  by phl-compute-06.internal (MEProxy); Wed, 11 Nov 2026 07:48:54 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1794401334; x=1794487734; bh=sCQf8F6niW
	rO3zug4rkejUDrMyMqv6bQqJ+JXU/LSCw=; b=F46sLzjJgByzIol2HA1B2uD69A
	ssNQjvgDp+dwoaFtYqRiO4qSSnpIM5o7J5cprxAfDXvsaQi7ql0AJkDeCDW/xzqR
	wm2h0VSazfl/Bkwq+ZCzbvFXruFtyE6P1UDhNO/kyvUtOHaUTf9/weZU8tz8+L6m
	pLjvrHzALJhGnX6oPAmMH31I5YIDdYDEl3oViC+Zg1WzhmP9xJuD7jT/HTJfSFKE
	Iqbq9dGZRilT67FDVx9kQFRt3zYAvtZCVQVpe1/oUg1tK1g1KMTg+rwS0Z//8DVA
	VtrxDmIJqmhuUc63QWd0PUQgkesljteHV4lofVIhAEtQYaaiR37115K1jDvw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
	1794401334; x=1794487734; bh=sCQf8F6niWrO3zug4rkejUDrMyMqv6bQqJ+
	JXU/LSCw=; b=yMDy9HhmhZgpVon9fTbxjyE1uOklEIIxcsaUqA7lC1L7Y3fCcwG
	8EMaja+wBMLeN5cGYjM4zPESs/CpwBvv51el+21WnIhTJwobZrMWQXMDTK7hXEB9
	0xQWVTnTxBR4SlQMvvxCC5y71Sdg+08P1PvjHNx1cXzSvBcbgi8BttbfDtkU/yzG
	PGOpACb0lM6i2CQUQptmThm0u9cdY+hbb5C65YLJlCkYFYpUpNSGmEZPWjy0KL3l
	VgakG5Jpws71uGX5Vo5sA5myTo85n1EU4Q8zmMDv6HHZTiQtqSoX0nsvScs+N0z2
	hqWTiFQgVe194QdsGqC5/XBpdEK9n1HM6OA==
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-09;
	repo=github.com/dkim2wg/interop; date=2026-11-03; sw=lmtpprox;
	action=sign d=pks.im a=rsa-sha256;
DKIM2-Signature: i=1; m=1; t=1794401334; d=pks.im; mf=PHBzQHBrcy5pbT4=;
	rt=PGdpdEB2Z2VyLmtlcm5lbC5vcmc+;
	s=fm3:rsa-sha256:H7J/2EqJqEFpSZDX0GsC8Op8o5sgfmHKaJqUmpL4yDhrjC/
	yVIGVdndJ5iTqtvcVgj4e+wYoTX6KRJomI3PTHQEdv9kJZWOpbSXaZ2h+pNJBZDp
	bYo2TLacbp2DxACx70AtVGa9OgYkTpMc/VyDuz9KTeyRnoBXr0A5KdB5cXEMNzRK
	VUSaBBX9EBOfFxIsNqxSCY/LjFJx9w5WA0w/tU01ekCU/QdA4y0FaL2Bhffy0C60
	UrtfX3slmK+rY6G3rqkpf15DK7JmDuZoxqeXjUodaa0TeaFCtNH/gLmrXrCsUB5/
	r2OXOlOTcMru+0lD4pUL2TrgRi5nAJMkOHu/XJA==;
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-09;
	repo=github.com/dkim2wg/interop; date=2026-11-03; sw=lmtpprox;
	action=mi-m=1; hc=12;
	hn=cc,content-disposition,content-type,date,feedback-id,from,
	in-reply-to,message-id,mime-version,references,subject,to;
Message-Instance: m=1; h=sha256:WB3ZZA09t2fGR2vTzC93qJg7w2BLOVFLaAa332ffYNQ=:511xHfCP49dhncGzGZH62U69d6sVzkfV2uiMmloKdV0=;
X-ME-Sender: <xms:NmT0arZgWuzZwpKnST0hT34iIoU-LntfFAFGslBQy-ykXBBhfDGhuQ>
    <xme:NmT0agZRuqnb4s7QQR5UgxPoKx34phE1rDs5XzIzLCe0MNZRe3kfxvwBhMPh0mYDF
    tQx9ugfPNzlXMMcQtbdKP0WpjEpwGVMfX5H16eQn0HV8vmowD-HCVYN>
X-ME-Received: <xmr:NmT0arnZ8MJ132JiG8LJtCbisfNAA08SIaOvYLnQI6ZANSJ4F3cmnV_NGq26uodMsjO5xg>
X-ME-Proxy-Cause: dmFkZTETE9yuxpIoX8BLLEfMwbD/+TY9OE32N5thd+EVzO4Jo/PZ7xh4VmMZdFqmawN3MK
    zAAamKT7TzAzbtPYmuj6QMdxWxLWLPzXmiv4Ua8ffl7AN4tV+icgZUwWUTcFUpIeIYAkvY
    vUJ7vdRG3+oBjeooLAu+Re9NkUOr33yWGHrchx9bLQ5ya/eoevM4LA97izXh3SYGI/XOds
    9Xt+Ijs2MQqz5Uq/seZqRwAnhUUdQTHQunALKvnU0RJoyWc2AfaK3iLVBrtbCdwZQlKZFj
    KCj9ya8lS1vwBsgQJ4ubhDaedK0iCl7JExvoC7uiO4jgMrnRZZS4uPHWqVPhjPjEASrMUa
    9PGa8bRDtkWKbR4mSljeH/IhRfyjsFzXHUGChkKqPaQlmu6n5/adSGGQVNmHXzVWIZM653
    digTzNzcnVD6Q0/TvqAJkqQfFKDd0Z+VszJw7ObWUzEfh2mVelCnn9ueb/fEPVtGuVWQXn
    JobpgWB6vlRAtrT7KleLrF8MPD4/dNXE7cVtQNhTENQnzziWAfqOPuzaLbf5j6X1icjjRe
    7tC3hAgYRDFSd7TAyaozHJvEBlxCFf3xhl1eaPIOAAXin2R9zg/F/TL45oqVq1ueuTo/ut
    hPPwGj3o0cD/xV/G5du8vqjsEDcw9Na/Af6IVSFzmHi8B/e1/lXUcxx1W1PA
X-ME-Proxy: <xmx:NmT0aswyj7Bck4HM_lxKGPCrM1znva3TiF2ii6ZbZbK2EzYLP8tt5w>
    <xmx:NmT0apNmcnp3onrsGW2ykYWXT0UCmO2aevXygFjBywFCiriNFk030w>
    <xmx:NmT0agSq-ZGxbpoNmVfmSgV6MomEks6-ZOetEX5RIrrxVU8wEccA3g>
    <xmx:NmT0anauUYVC3cOf4bE8-H1qtSHrGkd_RrPfhgjkZYSpXbpMc5EP-w>
    <xmx:NmT0ahL3Ba9ZsGiSDz4C8CEqMqodScUzrQR2otVylGTDj2Oen5LouYFJ>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 11 Nov 2026 07:48:53 -0500 (EST)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id 7c16396c (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Wed, 11 Nov 2026 12:48:52 +0000 (UTC)
Date: Wed, 11 Nov 2026 13:48:48 +0100
From: Patrick Steinhardt <ps@pks.im>
To: Derrick Stolee <stolee@gmail.com>
Cc: git@vger.kernel.org
Subject: Re: [PATCH v2 0/2] unpack-trees.c w/o the_repository
Message-ID: <avRkMPUmkqoCGmQC@pks.im>
References: <xmqqtsltbfdv.fsf@gitster.g>
 <20261109205438.369060-1-gitster@pobox.com>
 <37267fd4-c565-4559-9c5c-01d58cd0426d@gmail.com>
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
In-Reply-To: <37267fd4-c565-4559-9c5c-01d58cd0426d@gmail.com>

On Tue, Nov 10, 2026 at 08:22:26AM -0500, Derrick Stolee wrote:
> On 11/9/2026 3:54 PM, Junio C Hamano wrote:
> > unpack_trees() API serves as low-level functions to implement merge
> > and checkout.  It heavily relies on the_repository, making it clear
> > it only works with that repository instance.  We however can use the
> > repository instance pointed at by key data structures passed
> > throughout the callchain.
> > 
> > This is almost the exact copy of what I have at 
> > 
> >     https://lore.kernel.org/git/xmqqtsltbfdv.fsf@gitster.g/
> > 
> > The only changes since that version are removals of two blank lines.
> LGTM.

Likewise, I'm happy with this version. Thanks!

Patrick
