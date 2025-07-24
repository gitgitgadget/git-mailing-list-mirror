Received: from fhigh-b5-smtp.messagingengine.com (fhigh-b5-smtp.messagingengine.com [202.12.124.156])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 92FCD19882B
	for <git@vger.kernel.org>; Thu, 24 Jul 2025 07:42:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.156
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753342969; cv=none; b=NKH3WDHKwO+5Bs+H9cu/GW5GWcGwQW6grmFYUncNBV8bWHOrOS2i25zCC+g4wrmZElvEz+vsMevkiukr7M+aqrDA15dQbvgybWh0xf1F1j+ynPHTtakWLd/grfWii0ic/3rTl4TFhg8NjO8CsU9Aty4pVKqIdp998xHdZi59DxM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753342969; c=relaxed/simple;
	bh=GG1gH3vDB+8MPeEcONBRZVWEOBe9Icr1dHUI1BRGTbY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Miyi8J/tSuBV151txqOOOo2VETPUEqBVT5ND98uj3wrRbacC5nknzCBRkHFD5Y1ZuQKJ+psho5HzX20XEepfstm98oGOQv1n82rDeHv2KSjgtGDZI47SPZFIjzPZztymzIpHZwjydIb3BZQguoI/jJzVkTIarTzQRTlxpEH8FLE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=P8QaGBiX; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=P2iOigZu; arc=none smtp.client-ip=202.12.124.156
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="P8QaGBiX";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="P2iOigZu"
Received: from phl-compute-06.internal (phl-compute-06.phl.internal [10.202.2.46])
	by mailfhigh.stl.internal (Postfix) with ESMTP id A74717A0129;
	Thu, 24 Jul 2025 03:42:46 -0400 (EDT)
Received: from phl-mailfrontend-02 ([10.202.2.163])
  by phl-compute-06.internal (MEProxy); Thu, 24 Jul 2025 03:42:46 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1753342966; x=1753429366; bh=gzI7szHjwu
	YjBv10laBL9QZCIAz6h3taPOWL1XP9XK4=; b=P8QaGBiXWOpbSVsaPoZG7acCVP
	U6ompT8jPcmlhH+2G5lsnlKFy9EiNMstFQu8VNBUfOv9pNjSqPylEVI+7Ayx8skf
	eHAmQyPj/gsf10EW17BNiATShPLzjXY82Or48TuM8MxkDBn/8no+C/5hnIZZ6jyx
	+aWY+iwG7Rk7k7IiysRoJBg5H9/Dc3hb9Y7gGj2xbP5hZQncQic7wMiTGEx78tzP
	VYUf9SsFtMf40hgsMxulHiMg3uxiQ2NqVBoLLf3yzWOMDCxhG3FAhpvoMk3TgTLG
	fsowRiLS4kMkS6jAUjXr5UhpbAsgRpHPXz7tGY6gXJJrEX1TeHzxMabNSZOw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=
	1753342966; x=1753429366; bh=gzI7szHjwuYjBv10laBL9QZCIAz6h3taPOW
	L1XP9XK4=; b=P2iOigZuUca8V/P/cijvgjaXm449VYKpErb3DT/FcyCQRR602fz
	DJvNzu3x2AcGQeOsojl8JqrzhuvADX3MEnHOVL44zNwfZWY1c17GBZiLKnLglf2m
	xGIJqmd90/O0PsMdfKmCAoc92Se3WgT1Rzyxo9ZNTwxPitfS13vKbkMs/+lCo7tR
	WjsI9bazkEqOpL0aZ5ABzFIzWUV6cOG7M/TuAemmDuazwY9NtBevDQCXdgZL2jyJ
	P/2fM/cfF/mPg8XlJm+SWB0yNFwdK44Fyu4CmuPYQBWuPRNM38UnJE0ZCibc30Ts
	gRKo/9z97mtQBG9hy+OjIv0jiEaCilDr3DA==
X-ME-Sender: <xms:9uOBaBIAeC1PIVCAJZVzmku51J8d1kdGuuCEmKV_QLMHUvTQ7ZqOng>
    <xme:9uOBaAY8Pg2EG5As7iwmdpPeQnn6e7Fn1T7qv4Wift6Y1-znHTAYiEDK5rzwTr1dY
    DX6tNsl_vGwXNuKvQ>
X-ME-Received: <xmr:9uOBaDJ2v_9T_w-7NdAVh94jfo4HXxYSUbkBmwuSLWrG6ytCqeXChvYhw6QFvpA3oaJ2ldOB5gSUg_8EDlHSB7uyG-mZYG2B_qAQSwc0D9k>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdefgdektddtkecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpuffrtefokffrpgfnqfghnecuuegr
    ihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjug
    hrpeffhffvvefukfhfgggtuggjsehttdertddttddvnecuhfhrohhmpefrrghtrhhitghk
    ucfuthgvihhnhhgrrhguthcuoehpshesphhkshdrihhmqeenucggtffrrghtthgvrhhnpe
    evkeekfffhiedtleduiefgjedttedvledvudehgfeugedugffhueekhfejvdektdenucev
    lhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehpshesphhksh
    drihhmpdhnsggprhgtphhtthhopeefpdhmohguvgepshhmthhpohhuthdprhgtphhtthho
    pehkrghrthhhihhkrddukeeksehgmhgrihhlrdgtohhmpdhrtghpthhtohepghhithesvh
    hgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopehjlhhtohgslhgvrhesghhmrghi
    lhdrtghomh
X-ME-Proxy: <xmx:9uOBaOC6L6UuowfK_mLnxUJgmqlJqnGdl8hm1BIXIyQqrUwT3-AqBQ>
    <xmx:9uOBaIpSScj_rsrBFj6qMeDsosopdRxBta0Pr8_NmhPPc9JfH8l_SA>
    <xmx:9uOBaJgqa1gjTiZgdlLcclVjiJ-4DEdy8RyYvfjfPI3zVGnHWDtbnA>
    <xmx:9uOBaFBzNGWTVCM4oumzsQ3EOlOuN4jEpUC-_oyGKDz1-I_K0mWpyw>
    <xmx:9uOBaJVGw5lXo_gtJgIE9MUyytlbfq7MroYxBTF_zL3mD-oSxZ2A9-X0>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 24 Jul 2025 03:42:45 -0400 (EDT)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id e95a376f (TLSv1.3:TLS_CHACHA20_POLY1305_SHA256:256:NO);
	Thu, 24 Jul 2025 07:42:45 +0000 (UTC)
Date: Thu, 24 Jul 2025 09:42:42 +0200
From: Patrick Steinhardt <ps@pks.im>
To: Justin Tobler <jltobler@gmail.com>
Cc: git@vger.kernel.org, Karthik Nayak <karthik.188@gmail.com>
Subject: Re: [PATCH 6/8] refs: fix identity for migrated reflogs
Message-ID: <aIHj8g08j8p_FY-d@pks.im>
References: <20250722-pks-reflog-append-v1-0-183e5949de16@pks.im>
 <20250722-pks-reflog-append-v1-6-183e5949de16@pks.im>
 <tg72v5vgu56b6akawy7sfapi2qtrmy7q3uruhersy4dtzkpvju@wamlylndp3xv>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <tg72v5vgu56b6akawy7sfapi2qtrmy7q3uruhersy4dtzkpvju@wamlylndp3xv>

On Wed, Jul 23, 2025 at 02:41:27PM -0500, Justin Tobler wrote:
> On 25/07/22 01:20PM, Patrick Steinhardt wrote:
> > diff --git a/refs.c b/refs.c
> > index 188989e4113..64544300dc3 100644
> > --- a/refs.c
> > +++ b/refs.c
> > @@ -3017,6 +3026,8 @@ static int migrate_one_reflog(const char *refname, void *cb_data)
> >  		.transaction = migration_data->transaction,
> >  		.errbuf = migration_data->errbuf,
> >  		.sb = &migration_data->sb,
> > +		.name = &migration_data->name,
> > +		.mail = &migration_data->mail,
> 
> I was a bit confused at first why we cared to assign the name and mail
> fields here as it didn't look like we actually use them, but it looks
> like we do this to release the the underlying strbuf as we don't free it
> from `reflog_migration_data`.

This is an optimization: instead of reallocating a new buffer every time
we compute the name and mail we reuse a buffer. But because we're two
callbacks deep in the callchain we have to splice these buffers through
via multiple callback data structs.

I'll add a note to the commit message.

Patrick
