Received: from fhigh-a1-smtp.messagingengine.com (fhigh-a1-smtp.messagingengine.com [103.168.172.152])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9E3CB8F77
	for <git@vger.kernel.org>; Wed,  2 Jul 2025 02:31:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.152
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751423482; cv=none; b=szzfkxckRnA8RIQotpOtq21RlPKVMs+pOUGwnoK5eLfOr/su+H35JBNPLj9wADHAuE3GTPTThOGoyB2/olS/Ef3Y6Yls3RUnmwNbkVg4gidTAXxS/3Wo1PvbbCUXu7xEIrGOa1783K9FpKjWWm5GuJ6/rgh1U8P48IlEU8iRFeE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751423482; c=relaxed/simple;
	bh=+5aW+DAheFbfkcOSIn3kDUbi5M+AvjTreQT7U1Qmzrg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=EsqWVTG6N3CmDpXW1IE1buTgCp7//WEdSe7Ga5tsnfkyQ8rSTnXntWMJRsBS4DrMeuUHtorxJ6gWBVxy1CN8KuETfBUkI5854SnLaE8WlJRx40XNeZ5xlmtcLbxWy4AzbKlqseE0/KJ3JfAbNMciEvqv2uDXs+zXWu2JuYrpdcI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=exkvmufQ; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=VycZLPrT; arc=none smtp.client-ip=103.168.172.152
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="exkvmufQ";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="VycZLPrT"
Received: from phl-compute-03.internal (phl-compute-03.phl.internal [10.202.2.43])
	by mailfhigh.phl.internal (Postfix) with ESMTP id BE63414001B7;
	Tue,  1 Jul 2025 22:31:19 -0400 (EDT)
Received: from phl-mailfrontend-02 ([10.202.2.163])
  by phl-compute-03.internal (MEProxy); Tue, 01 Jul 2025 22:31:19 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm2; t=1751423479;
	 x=1751509879; bh=m742QMZv7rYw2D4wKksv0f6ZQfN9Kkk2RJnAotrD3Es=; b=
	exkvmufQy0pgmahsWSkjbESW36HYigQnprOeE2SCXPGPoASDcEjc+d3R/VUloA4u
	hi3cnwf+u3z07PiGKwb6KTG3lVilAMSu5r0lUe0yKEz5hT9tDC411E5QZd/SmTQS
	aHzfCClpDXaYyJK4lxHRIVJ9BD1u85lFjeEXTxlbo+txY2t6i1IQYViTleH0tHp1
	KmYQBKBW0nC48CcuSO+qJ+Av3ljebq5rI/IsTHCBR5vxA8AqPfhSi0SHyrOUVrQm
	swZhV3KBRjUhXkY2RvKKN4/KznCXHdWbJTiR0ASVxqNNZSWuq64F/yiNn7e5G7vU
	h2ZcrKHaneeSeNgy9pqqZw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1751423479; x=
	1751509879; bh=m742QMZv7rYw2D4wKksv0f6ZQfN9Kkk2RJnAotrD3Es=; b=V
	ycZLPrTK8D7XpwAHMd6M06BGjEDD1fvNWxYM5pEokEX4SI2f4pnyaZGkrS38x+RV
	SPClV+JKf8F52NAg4QYgBk4kmPz7Sut8U1DGSv0ZGEFqM0REHxQ4Li292CnF49FK
	zETsIP/SqsTUKRDINs7WY53KwlBgnB9QecJZJ05Kl6O6nZVXXIJsB674Zf++P2fx
	dQgnqG2jxCpxiXflQu0w30FF3quRkxwC6Xr3wFpJPRhepnvdQQ7l1M0A6Zt4HwC4
	1DTaPOicV9mgI3sEBoXidvNXBGdEkyNXkr0lfC5k2rGRR1uzvED9MfAvmLZyEA8Q
	Nm+tC85eZ4h7/oRjqP6+w==
X-ME-Sender: <xms:95lkaJEH4b19sZSmlZ3bFdpeIqpUIExfOmqPkPi8Z6zga5tbVSzabQ>
    <xme:95lkaOWaPgVtm5OWdR_aHgQWr8yD9aZ-05gb58BRYGtuvWMFb1XvcJggRWxcF2g35
    D40kswK36UFNrOUYw>
X-ME-Received: <xmr:95lkaLIJTtM3oKUthoWsqb3_17_7UTPMaE2vm9waKI2eKnuO2Wj9xV8hteV9PBMd9NVjFKcej9NpaiitNvOSH3CKb53KR3rngok69fXLJA>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdefgdduiedvtdcutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpuffrtefokffrpgfnqfghnecuuegr
    ihhlohhuthemuceftddtnecunecujfgurhepfffhvfevuffkfhggtggugfgjsehtkeertd
    dttdejnecuhfhrohhmpefrrghtrhhitghkucfuthgvihhnhhgrrhguthcuoehpshesphhk
    shdrihhmqeenucggtffrrghtthgvrhhnpedvfeejiedtteelheeiteekveeftdefvdehke
    dvveetffdvveevjeejleegtedvgfenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgr
    mhepmhgrihhlfhhrohhmpehpshesphhkshdrihhmpdhnsggprhgtphhtthhopedvpdhmoh
    guvgepshhmthhpohhuthdprhgtphhtthhopehgihhtsehvghgvrhdrkhgvrhhnvghlrdho
    rhhgpdhrtghpthhtoheplhdrshdrrhesfigvsgdruggv
X-ME-Proxy: <xmx:95lkaPF466VJ9oF8O9ItD2PvtiCii2jxVGwgvoRyK0sMILiI50CRdw>
    <xmx:95lkaPXIWuyxp5a-GmJMfAp_A0Yqq6Xf_fxuC9iPEYUzKlXER9tgzg>
    <xmx:95lkaKNK9muSLDy-upmkBR7ImBC-GcfJgnphhK2D2gAfbw-tB97gPw>
    <xmx:95lkaO3KzdmWjZoU1oVWtSlhAekoOlVwnO_YAcgFsAfULuofwdbeWg>
    <xmx:95lkaFE-Ljoj1Ql-Gl53mApaLCS-N-scY0f7eT7PB523MGc7DbXpZemM>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 1 Jul 2025 22:31:19 -0400 (EDT)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id c9a79fe9 (TLSv1.3:TLS_CHACHA20_POLY1305_SHA256:256:NO);
	Wed, 2 Jul 2025 02:31:18 +0000 (UTC)
Date: Wed, 2 Jul 2025 04:31:14 +0200
From: Patrick Steinhardt <ps@pks.im>
To: =?utf-8?B?UmVuw6k=?= Scharfe <l.s.r@web.de>
Cc: Git List <git@vger.kernel.org>
Subject: Re: [PATCH 2/6] parse-options: add precision handling for
 OPTION_SET_INT
Message-ID: <aGSZ8jHWz0HnPGnO@pks.im>
References: <cf5cd57d-733f-4239-80f8-23bdc1523ab2@web.de>
 <3690df99-8a83-4377-9b03-6766f7958c21@web.de>
 <aGO-l81JiOESvbS9@pks.im>
 <fb50bdea-f529-447a-9cf1-0fbde3f8e22e@web.de>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <fb50bdea-f529-447a-9cf1-0fbde3f8e22e@web.de>

On Tue, Jul 01, 2025 at 05:54:41PM +0200, René Scharfe wrote:
> On 7/1/25 12:55 PM, Patrick Steinhardt wrote:
> > On Sun, Jun 29, 2025 at 01:50:39PM +0200, René Scharfe wrote:
> >> diff --git a/parse-options.c b/parse-options.c
> >> index da07a000a3..bbb68603cc 100644
> >> --- a/parse-options.c
> >> +++ b/parse-options.c
> >> +static int signed_int_fits(intmax_t value, size_t size)
> >> +{
> >> +	size_t bits = size * CHAR_BIT;
> >> +	intmax_t upper_bound = INTMAX_MAX >> (bitsizeof(intmax_t) - bits);
> >> +	intmax_t lower_bound = -upper_bound - 1;
> >> +	return lower_bound <= value && value <= upper_bound;
> >> +}
> >> +
> > 
> > Should we s/size/precision/ so that it's clear what kind of size this
> > exactly is?
> It's the width of an integer variable as in sizeof(), so the name fits.
> We can inline this single-caller function if it's indeed confusing.

The issue to me is rather that it's unclear what the unit is. Is it size
in bytes, bits, nibbles? You wouldn't know that the expectation is that
the caller passes in `sizeof()` without taking a deeper look.

In any case, this is only a minor nit in the first place, not worth much
bikeshedding.

Patrick
