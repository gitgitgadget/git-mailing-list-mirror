Received: from fhigh-a6-smtp.messagingengine.com (fhigh-a6-smtp.messagingengine.com [103.168.172.157])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6F3512C181
	for <git@vger.kernel.org>; Mon, 15 Sep 2025 07:31:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.157
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757921465; cv=none; b=EB2VSXPY+rwOYMq8UK+u97YveWPM/p0rjs7A9NEyewq1Y7RdBwsgvovwduikTuaF4dr/6DcnUaVY3Dp7wOERfJUdZgKUG2+2+wDT+XKubW/CwEpjaHKcR90GY98bEfx4aSof4IfobgXi1S/W+lruyItGzyzwGqU9knsD4fP924o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757921465; c=relaxed/simple;
	bh=Os9WlL5FxN8hSrBdZ4AX7MffFeLxRlvsYboOoNs1n20=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=SOzjvRgTVwWI66tfGyphX1msHyxvDYurOxoRBns95iGYhhcquZAcLUxh2bW5bZ+u6ZeyD+vgVaYB87q+txkmGVBG9j/k1lnlyUFFti6gwu0SVKdNdmN4ZH+JxN/6gYjgjrsfnU2TrmfR5HbT8+aYmKFSVFTz+kfK1+dZ5pK4Vdk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=qUtlKvtr; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=WMEHrNCh; arc=none smtp.client-ip=103.168.172.157
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="qUtlKvtr";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="WMEHrNCh"
Received: from phl-compute-06.internal (phl-compute-06.internal [10.202.2.46])
	by mailfhigh.phl.internal (Postfix) with ESMTP id 953B014001AA;
	Mon, 15 Sep 2025 03:31:02 -0400 (EDT)
Received: from phl-mailfrontend-02 ([10.202.2.163])
  by phl-compute-06.internal (MEProxy); Mon, 15 Sep 2025 03:31:02 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1757921462; x=1758007862; bh=YK2bHI3Dve
	fKlhK8fjDMQ/Kp4k7KomgFKj+oQ62c0tU=; b=qUtlKvtrdYSvrTHhZELAxVGFyG
	wqI0Q9I8q9RISJO8dHRNXSKvjfsZqf08KR1BT5uUKM4wZ++sbyKAfy+3MxXA6ltl
	r9Pwbi5PIxGi1lKsXywjWObTwlzIoWs2YdAZXonJj9Gmc4jxcWu6pNtZP/RI+P1x
	FlYEx8GoZ4x5irYlEXLM6fkBbptG3/NVSgvD1dfMibUNfV5AcRT+QfvKpgAsf1w3
	u2UE1GhtYoTsNVmUQNBYnGUnuetIUAVSc84VFOlDys0+jqfecY94+nFXQT41vwLt
	VrHvPiO/q14Y6cZjWxHld2cPRi/fQ/4PZno9SZ9QoY/x/rjmQSCgrnfnXpLw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
	1757921462; x=1758007862; bh=YK2bHI3DvefKlhK8fjDMQ/Kp4k7KomgFKj+
	oQ62c0tU=; b=WMEHrNChGiJR3bkKTLVU/D80JPYajKnoPl+FqE00n13pi10ixxf
	JhOp6H5ucLsuM2rpzRBuzyt4pBhLMO62521aOTTHXlUfOPRtMgVXmAZAipc/sWMr
	HxcEGW4tFpimUHwmJjTnGfYeJP1DrjHtD+47EVK6obaEGpJ7+n5U7gu27ObCUzUR
	980XbXX3i4oPod1xPrPTecvu2gVpKpVat1zwCVVKdkm/nFUl1oA1EQ72d+CwxYTi
	J4FZrC1SXlbPlEAq08NKRZJA3EeBAhsA9KnN0cDO53jJsorF6Q76aDo3gZWNpI05
	F+WnlaDmbBcBtWbHb1ovlgLZQlTJ5Rkcenw==
X-ME-Sender: <xms:tsDHaP5J9L0dvEFvIuCnAeAJRmQhQvpDi1biInlW9Otv-dggYlehwg>
    <xme:tsDHaPfCj0Oxg9fSc68zLDktmlw0ZwoHhtgA3v_aF1lLtHqU99IxGJl96-y1RPmXg
    HS5DlW6qUkf1i3K6A>
X-ME-Received: <xmr:tsDHaDD7M7SchZog7HloXI3y26y35xL4rlf2qh_snmYDKIIVwZt0JXVfr5DBZA6KaN2Xs55MMvU8vbJprqJ9MvfMG7XfT93fHtoVsO2RwcvV8w>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdeggdefjedutdcutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpuffrtefokffrpgfnqfghnecuuegr
    ihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjug
    hrpeffhffvvefukfhfgggtuggjsehttdertddttddvnecuhfhrohhmpefrrghtrhhitghk
    ucfuthgvihhnhhgrrhguthcuoehpshesphhkshdrihhmqeenucggtffrrghtthgvrhhnpe
    evkeekfffhiedtleduiefgjedttedvledvudehgfeugedugffhueekhfejvdektdenucev
    lhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehpshesphhksh
    drihhmpdhnsggprhgtphhtthhopeegpdhmohguvgepshhmthhpohhuthdprhgtphhtthho
    pehpvghffhesphgvfhhfrdhnvghtpdhrtghpthhtohepkhgrrhhthhhikhdrudekkeesgh
    hmrghilhdrtghomhdprhgtphhtthhopehgihhtsehvghgvrhdrkhgvrhhnvghlrdhorhhg
    pdhrtghpthhtohepmhgvsehtthgrhihlohhrrhdrtghomh
X-ME-Proxy: <xmx:tsDHaC9JUEsoF7OoSRCn31fhtknyBXIsH0kE28-DjHtReTsg9hc4Kg>
    <xmx:tsDHaOKw2boC_7oqJYk_ubiB6Sczubc7eYXDBgivg3eTgmcZOyZz2Q>
    <xmx:tsDHaLhv3rdYsv0M4SDik9VzG9jm0hxCVL5jMqlKez1_LRB2NYTN3A>
    <xmx:tsDHaO7H4cpcM8TKlD47BNRmZHkERwwNZnuqgaxfMAkPZpSQ9RWH5A>
    <xmx:tsDHaKToNKhsAYh2SrF8r8WhOEpD8_E84gD9_UFKO2h7yo0YDYtAGSaF>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 15 Sep 2025 03:31:01 -0400 (EDT)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id 67f5c23e (TLSv1.3:TLS_CHACHA20_POLY1305_SHA256:256:NO);
	Mon, 15 Sep 2025 07:30:59 +0000 (UTC)
Date: Mon, 15 Sep 2025 09:30:56 +0200
From: Patrick Steinhardt <ps@pks.im>
To: Taylor Blau <me@ttaylorr.com>
Cc: git@vger.kernel.org, Karthik Nayak <karthik.188@gmail.com>,
	Jeff King <peff@peff.net>
Subject: Re: [PATCH v2 14/16] packfile: remove `get_packed_git()`
Message-ID: <aMfAsIEX9Wf8LOx8@pks.im>
References: <20250821-b4-pks-packfiles-store-v2-0-d10623355e9f@pks.im>
 <20250821-b4-pks-packfiles-store-v2-14-d10623355e9f@pks.im>
 <aK5hpwcCgjkgQB1N@nand.local>
 <aLav7vdfxPGTVDQd@pks.im>
 <aMNahx/RBoRljSZd@nand.local>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aMNahx/RBoRljSZd@nand.local>

On Thu, Sep 11, 2025 at 07:25:59PM -0400, Taylor Blau wrote:
> On Tue, Sep 02, 2025 at 10:50:54AM +0200, Patrick Steinhardt wrote:
> > On Tue, Aug 26, 2025 at 09:38:47PM -0400, Taylor Blau wrote:
> > > On Thu, Aug 21, 2025 at 09:39:12AM +0200, Patrick Steinhardt wrote:
> > > > We have two different functions to retrieve packfiles for a packfile
> > > > store:
> > > >
> > > >   - `get_packed_git()` returns the list of packfiles after having called
> > > >     `prepare_packed_git()`.
> > > >
> > > >   - `get_all_packs()` calls `prepare_packed_git()`, as well, but also
> > > >     calls `prepare_midx_pack()` for each pack.
> > >
> > > Yeah, having two of these functions that are named so similarly as to
> > > suggest they do the same thing (even though they don't) is unfortunate,
> > > and I am glad that we are looking at it here.
> > >
> > > > This means that the latter function also properly loads the info of
> > > > whether or not a packfile is part of a multi-pack index. Preparing this
> > > > extra information also shouldn't be significantly more expensive:
> > >
> > > Right; get_packed_git() only loads the non-MIDX'd packs, and
> > > get_all_packs() loads everything (regardless whether or not a pack is
> > > part of the MIDX or not).
> >
> > I initially understood the distinction of these functions to be exactly
> > this. But after looking further I don't think this is the actual
> > distinction: both functions end up loading all packfiles in the repo,
> > with the only distinction being that `get_all_packs()` also prepares the
> > MIDX for each MIDX'd packfile.
> 
> Calling both get_packed_git() and get_all_packs() both result in:
> 
>  - prepare_packed_git(), which calls
>  - prepare_packed_git_one(), which calls
>  - for_each_file_in_pack_dir(), which calls (via callback)
>  - prepare_pack
> 
> prepare_pack() only calls add_packed_git() and install_packed_git() if
> the file it's look at ends in "*.idx", *and* there is either no MIDX, or
> (if there is one) the packfile is not listed in the MIDX.
> 
> get_all_packs(), on the other hand, *does* call prepare_midx_pack() on
> all MIDXs across all ODB sources, after having called
> prepare_packed_git(). And prepare_midx_pack() will add MIDX'd packs to
> the global list of packs, which is what differentiates these two calls.
> 
> I think this gets a little funky in practice if you have already called
> prepare_midx_pack() on one or more MIDX'd packfiles before calling
> get_packed_git(), because of the side effect of prepare_midx_pack()
> installing packs into the global list.
> 
> So the above behavior isn't guaranteed, but there definitely is a
> difference between those two functions depending on whether or not some
> other site has called prepare_midx_pack().
> 
> > > So I think that want_object_in_pack_mtime() may need a small tweak, and
> > > I am not 100% certain that cmd_grep() is OK to convert.
> >
> > I initially misunderstood the distinction between these two functions
> > the same as you did, and had a similar list to the above in the initial
> > commit message. But with the adjusted understanding of the actual
> > difference between these functions I think it shouldn't be necessary
> > anymore to go through each caller one by one.
> 
> From the above, I am not sure that this is true.

Yeah, I'll drop that part from this patch series for now and will handle
this in a subsequent series.

Patrick
