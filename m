Received: from fout-b2-smtp.messagingengine.com (fout-b2-smtp.messagingengine.com [202.12.124.145])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F28CF2DCC1F
	for <git@vger.kernel.org>; Fri, 16 Jan 2026 07:03:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.145
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768547000; cv=none; b=Jj0OY9Btw8J1g/mg/iju8lOwxssAdwghvQ1LpMfUAJAyJFqWe5NVHbRveNfIefUv81BfkuM0PZZgNvxf7gtu1ZWqPy8cw+nHc/Ohd2oIxiHtlYMSjVS1mjXpsWWUqpUygfhdf2i2N9wt3UDZUmcuQxr099Vpa3zhChkta4lWtuY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768547000; c=relaxed/simple;
	bh=OJbKi3ep5phlmXjOHrkEbDrJ2NEbWHCoZWrV+P4G/+4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=FXZ3R2QJCBrvWcPfVB5O2OpzGcsBK7g2stKNtFyajJp53efmfx4x9cRrEcvlo8cFLBJ/6cws3i3exx8CC1T29J9/XUgN8FPrASclNZEZcHzO2Pzc9TT1ICitkGmrgrq699oUnoGsx0PgoE5EJzjaJcEXuQletd0OxFVop/89nGo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=gtbmFtyP; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=hO+S6+eX; arc=none smtp.client-ip=202.12.124.145
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="gtbmFtyP";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="hO+S6+eX"
Received: from phl-compute-03.internal (phl-compute-03.internal [10.202.2.43])
	by mailfout.stl.internal (Postfix) with ESMTP id 54A231D0009D;
	Fri, 16 Jan 2026 02:03:18 -0500 (EST)
Received: from phl-frontend-03 ([10.202.2.162])
  by phl-compute-03.internal (MEProxy); Fri, 16 Jan 2026 02:03:18 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1768546998; x=1768633398; bh=IYH5+yptF7
	ox4Flx2/X0t2OhYBN65MQg05v+e9SL3Zc=; b=gtbmFtyPs7RdZ2M4DsTzKXNAr6
	KZl2MHujtRzBGpovIe4VJexIC5b0YtK9uDZwW5Q0CaJqjSYDKkemnNLBKwCCbx0k
	4WUIOj/4wr5gEJ94Qx6JHjpHtyPNpR6ogegZe/Ai4+6bzgzq4wj7LiDa4XZ5YWVo
	femxpsc5/S6McpoPOtdJAO/8t5PfgnG4TbvNtAgOK/T+mkk3CZetiWhzlAMM9O4t
	orZhRMGlsVhMPSjFQgE/p6+b9XrlPu7y91Bkf2sj7OOCVAhpzPxKztfyuGaO5PAW
	DCS4QrBpJ9yZ1W9ni7OVty/hkxkcoYv5RnemqH4oUYm8khPEYJ5EsCj4v9Xg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=
	1768546998; x=1768633398; bh=IYH5+yptF7ox4Flx2/X0t2OhYBN65MQg05v
	+e9SL3Zc=; b=hO+S6+eXBHLfYIf61xtAsvS4IbIXSIJA9EwD8n7arcr6Hr4T2Ti
	dhw3ffs9bggN2G/BwvjT6mXwTD0CsNZeQMt4lzYTNjL9Q0gKuPoE8/209duLa2Bp
	p60grnf0sD6Y134YLMO9dSMhLPb/3wjP+wqZLZaME0bYCjzwnNekXbfuwuLtPwa7
	/IM9aJ9OGWh+/NW6A0MrdZySeFY257IvsGUSCbBtOvHNFf2A7CapbjmpspyEPDuI
	t1qn715qyJwtZpDeIprSL+DcnjQtS97EknCsh+x2UtdWHxwzTr/W4wfAOrd+SWk/
	iugolpqPZ3b6t2cy7GU4vHl+vt6+SzPxziA==
X-ME-Sender: <xms:tuJpaUDllDgzUKrhj9OrvDym9nCjB1QKQIpNxef3DowPWS2jh2CvJA>
    <xme:tuJpaci78IzgXhhuVTqXSLGaDlGI8x77UapDF-BzCRY_W6TDoVktsPl3YAXemNBdt
    je75bXr6h0rHDPT6URtWVRDuEr8f2XbD1fRo0yIKLUqH6ufjl2riT0>
X-ME-Received: <xmr:tuJpaVOa3gtzuBonKMwcaLn0HEAZlj5rhTCl08E9J0OyjDNiXl9F5Xvo3sXgI-BtT4AMPDMM9XhauOr_v3cd0WjL-R4siPiELzSxgjfsPg>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgdduvdekfedtucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucenucfjughrpeffhffvvefukfhfgggtuggjsehttdertd
    dttddvnecuhfhrohhmpefrrghtrhhitghkucfuthgvihhnhhgrrhguthcuoehpshesphhk
    shdrihhmqeenucggtffrrghtthgvrhhnpeevkeekfffhiedtleduiefgjedttedvledvud
    ehgfeugedugffhueekhfejvdektdenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgr
    mhepmhgrihhlfhhrohhmpehpshesphhkshdrihhmpdhnsggprhgtphhtthhopedvpdhmoh
    guvgepshhmthhpohhuthdprhgtphhtthhopehgihhtshhtvghrsehpohgsohigrdgtohhm
    pdhrtghpthhtohepghhithesvhhgvghrrdhkvghrnhgvlhdrohhrgh
X-ME-Proxy: <xmx:tuJpaV6QzHKzLosQCjUjSDi2vet_ZARFA6p97-YWkiKQqrRpbFalRA>
    <xmx:tuJpab1pPC8PKKq0TTjR0SpOu3FEcBUKeas7XmKqVIuhhk2yEOMvAw>
    <xmx:tuJpaea-jGFWj7b2oH6nrs3DbxngQIfpmhnCJGViN7gz2CyE9eYixg>
    <xmx:tuJpabCeDEirg8lUB0o7f4nfgliwq-INzZDnCoyFGAEKh1f7oEBm2Q>
    <xmx:tuJpaXaThYeoMowwFOuMOK1tN4tn2ENFRFBkpFZXm6dTPHyj14vN6_gl>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 16 Jan 2026 02:03:17 -0500 (EST)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id 84fde481 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Fri, 16 Jan 2026 07:03:16 +0000 (UTC)
Date: Fri, 16 Jan 2026 08:03:13 +0100
From: Patrick Steinhardt <ps@pks.im>
To: Junio C Hamano <gitster@pobox.com>
Cc: git@vger.kernel.org
Subject: Re: [PATCH 00/14] odb: introduce `odb_for_each_object()`
Message-ID: <aWnisVFbgXIG492W@pks.im>
References: <20260115-pks-odb-for-each-object-v1-0-5418a91d5d99@pks.im>
 <xmqqy0lzc7e4.fsf@gitster.g>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <xmqqy0lzc7e4.fsf@gitster.g>

On Thu, Jan 15, 2026 at 05:50:11AM -0800, Junio C Hamano wrote:
> Patrick Steinhardt <ps@pks.im> writes:
> 
> > The patch series is built on top of 8745eae506 (The 17th batch,
> > 2026-01-11) with the following two series merged into it:
> >
> >   - ps/read-object-info-improvements at b7f649ca93 (Merge
> >     remote-tracking branch 'junio/ps/read-object-info-improvements' into
> >     HEAD, 2026-01-15).
> >
> >   - ps/packfile-store-in-odb-source at 1ff0e42d33 (Merge remote-tracking
> >     branch 'junio/ps/packfile-store-in-odb-source' into HEAD,
> >     2026-01-15).
> 
> These two commit objects you cite have never been at the tip of
> these branches in my tree; I'll go by the branch name for now ;-)

Ugh, yeah. I referenced the merge commits in my tree, which is of course
dumb. Will fix the cover letter to point to what you have now.

Patrick
