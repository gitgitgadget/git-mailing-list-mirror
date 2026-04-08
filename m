Received: from fhigh-a3-smtp.messagingengine.com (fhigh-a3-smtp.messagingengine.com [103.168.172.154])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CC12F39DBD6
	for <git@vger.kernel.org>; Wed,  8 Apr 2026 08:22:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.154
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775636556; cv=none; b=iun1WfFEDvx1dbZwjhgcLUALah9CEV48OBJt8CqLQ0r5EiYVbeXjfdYCZl8VYXiBtXl7v/CRGaN/kl16p7vZNq1equq00fctM1CMfY3YpZU2h/ed/U7x3Bm7b6Q+9BrAINNVLs1gA7CHaJNfkU3mZetnpa/najVCUmj6M+X+1cI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775636556; c=relaxed/simple;
	bh=5xbVhPyT/FjbA/o3hLwphy4m7qKAx7TjHvtU7u2wfsg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=WIbNZryY+KlWLAfHVHupm7xhbwpFfweXtC/EwZub9+oxGj9+VXL557ZCkABmYGTZsHqjiJdLY0ZUK5MwU/eITmNbwrcD35V2+bREDL8vmKu3BtWZNyDK+fscxigo4O/mHzFb8Z4hDPP0Mm3fgn079/sORFzp0zGiCODHiV4F1ck=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=DuW9KOpR; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=uIARmAk9; arc=none smtp.client-ip=103.168.172.154
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="DuW9KOpR";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="uIARmAk9"
Received: from phl-compute-03.internal (phl-compute-03.internal [10.202.2.43])
	by mailfhigh.phl.internal (Postfix) with ESMTP id 2B63A140018D;
	Wed,  8 Apr 2026 04:22:34 -0400 (EDT)
Received: from phl-frontend-04 ([10.202.2.163])
  by phl-compute-03.internal (MEProxy); Wed, 08 Apr 2026 04:22:34 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1775636554; x=1775722954; bh=tVW69YywI5
	G3zhcYAYWk/zitDvqqn97jWqYwMpoqPXM=; b=DuW9KOpRtbqJhc817ZUGRTPAWD
	Dqm9xJEHrFNsakU4Q+arwaPacYAGzfZlBUdRiZy+2h+zbc6dCRYW997rr9BN1xFb
	QgZ42G0KzO3S7zTbhw84q3m1uDqrAjfJq+BrNWPHwRmGXk9SizxE1CtvHoqb6uMu
	4Y4nq0GQ2VgmRcaWhFJu9162XZizhg2gvqhl+AgqkQwTNSNP31opchv912qhDt5N
	43vIW8iiUCEEmiIdTtvFYXcpe7FvViVmOGNoJvpbSjG8bKI9+zQRPDrj4utfPPDJ
	MwQO9l5qjXralc60guMSb/qV9L0cWJ4CrDQpcVuL9qO9V8XsUbPEuBPekeqQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=
	1775636554; x=1775722954; bh=tVW69YywI5G3zhcYAYWk/zitDvqqn97jWqY
	wMpoqPXM=; b=uIARmAk9vMT526BGgnfBFNDvPeKIUi70stfDWfYfmZ9xWMgwKRk
	np+qaE4lRQqFj3aBT7M4NNW4l2Vc6wyFfUBIYPbSeDCw5bgKEB5xeM2ApT5knP5L
	cpk7+cE3PSygcwziyTo7QjA3nBLaoyUHFBvoBT66wQS1/dPA27Arky7qkZjemTcC
	2l0mO1ZAKpnN5HLyCLN/lIoGvoCvT/Ax0S0B5t65ST1/V6y5bnJM/K3EGyQJWZ4p
	L9gzbFCiluFehSSsv9KDnhlivuLa0Bpg3USRT63TVhkHHpsN4W6Lh3EMT3cUDsmK
	EwrKHHhBAXidLxjOI0qtQxWbyjesQgN0hUg==
X-ME-Sender: <xms:SRDWaR5QQKdolUgSe9CMIcSJB33lt1U4ad56xARDeoyeB97LznTTgw>
    <xme:SRDWaU6wmLZeJ41-QVvtfbDyuh0TyqnWHDdeoPe5L5GiAzpNmYfXS_fAbvVJz1R2t
    M9-jh2iOBRgtoGlbVfGvAzB1E5oX9sdKeAmgy4DWvIHhRs0zH8R1w>
X-ME-Received: <xmr:SRDWaWEbmk3jlIIxtJ9yVRAxnSJx_ZAhLe8r9UqYeY8z_6hnkMFI5ySyJJcBdAB0b2fK8FosWVegDKl6QkTvHdrEGAKdIGFP46bq5Cs>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefhedrtddtgddvfedtkecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpuffrtefokffrpgfnqfghnecuuegr
    ihhlohhuthemuceftddtnecunecujfgurhepfffhvfevuffkfhggtggujgesthdtredttd
    dtvdenucfhrhhomheprfgrthhrihgtkhcuufhtvghinhhhrghrughtuceophhssehpkhhs
    rdhimheqnecuggftrfgrthhtvghrnhepveekkeffhfeitdeludeigfejtdetvdelvdduhe
    fgueegudfghfeukefhjedvkedtnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghm
    pehmrghilhhfrhhomhepphhssehpkhhsrdhimhdpnhgspghrtghpthhtohepvddpmhhoug
    gvpehsmhhtphhouhhtpdhrtghpthhtohepghhithesvhhgvghrrdhkvghrnhgvlhdrohhr
    ghdprhgtphhtthhopehgihhtshhtvghrsehpohgsohigrdgtohhm
X-ME-Proxy: <xmx:SRDWaVQXfQKUnUieRw_dsz9bYEDzPBUfR0jRLLDnDUtziQx107kgIw>
    <xmx:SRDWaXvkbrV7M6Nx-GhF-fLq99yYXy-xVT2afEAd3VG1CLTa8NYXMA>
    <xmx:SRDWacy1ecrHhrW25ojPpoFZsZCTzCqOOwPefDnWypg7HWSqgCA-3Q>
    <xmx:SRDWaZ5izOq6hbgGYGokYhGpprxBjtlJafSQ7cmTZ8-A5GbF9eeDfg>
    <xmx:ShDWaVTFxcuCGz8HvyQOpTz81TvFS-xO8V0wZ56bnE1AnCzsxka7C_TK>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 8 Apr 2026 04:22:33 -0400 (EDT)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id 34632c1f (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Wed, 8 Apr 2026 08:22:31 +0000 (UTC)
Date: Wed, 8 Apr 2026 10:22:22 +0200
From: Patrick Steinhardt <ps@pks.im>
To: Junio C Hamano <gitster@pobox.com>
Cc: git@vger.kernel.org
Subject: Re: [PATCH 00/16] odb: introduce "inmemory" source
Message-ID: <adYQPmnajLmVr-vh@pks.im>
References: <20260403-b4-pks-odb-source-inmemory-v1-0-8b8d1abaa25e@pks.im>
 <xmqqa4vknjab.fsf@gitster.g>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <xmqqa4vknjab.fsf@gitster.g>

On Fri, Apr 03, 2026 at 08:41:16AM -0700, Junio C Hamano wrote:
> Patrick Steinhardt <ps@pks.im> writes:
> 
> > this patch series introduces the second object database source type,
> > which is the "inmemory" source.
> 
> I cannot read the word without a hyphen, i.e.e.g., "in-memory".

Fair. I think I'll keep it as `odb_source_inmemory` in the sources,
which I find easier ot parse than `odb_source_in_memory`, but will adapt
to "in-memory" in prose. I already did this for most of the part, but
not in the cover letter indeed.

> > This source may seem somewhat odd at first: it always starts out empty,
> > and any object written into it will only exist in memory until the
> > process exits. But the source already serves a purpose in our codebase,
> > where some commands, for example git-blame(1), write an in-memory
> > worktree commit.
> 
> Intermediate tree and blob objects you need while making an octopus
> merge may also benefit from this feature, to stay only in-core
> without having to get written out to the outside world.
> 
> I understand that this is not meant to be used as a "we create them
> only for ourselves and they are available only to us while we work,
> but once we are satisfied we make them available to others", which
> is much better done by creating an on-disk ephemeral object store,
> write such objects in them, and then decide at the end of the
> process between discarding the ephemeral store and moving objects
> from there to the main object store.

Yeah, I think there's a bunch of use cases where this could be useful
going forward.

Patrick
