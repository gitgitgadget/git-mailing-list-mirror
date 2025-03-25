Received: from fhigh-a3-smtp.messagingengine.com (fhigh-a3-smtp.messagingengine.com [103.168.172.154])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3D79925949A
	for <git@vger.kernel.org>; Tue, 25 Mar 2025 12:54:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.154
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742907299; cv=none; b=QbJg6vXki3KHVCNtWssViuGseMEipnglnxWPBDip5GTqjP5ie6jeUdGb5OIvGNrdGlGFs+6qDKcN6bRumuQKCCNhyvn/+qRPyu6vwCDviUxKWgKT1Ct4OgIoppxHrKkaM1ILhnwGnLwh8M8a79OWQEcMAZYPlGMuqXDhgJ4ehOA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742907299; c=relaxed/simple;
	bh=OZbnmE4lxhgM4vqdghqAC/NNVu/aPzSlZvhoO/IA5lI=;
	h=Date:From:To:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=i3Aw2jfXUdqP8Hi5YMTBKArqVvn9/0pJ/9gFXFsI31nHYgAixkDj4RL4DgJg1tW3PmSlzWfOUwIAknJIHlVHVR8Y1y+05ajjoShQ+aQY4dYCCDe01Cp4ryep/Xwt7ijZplIYeSXrZW3gYkKS7wrdUBhjCszEVmgohcRzQlYZ+Bw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=TG6aJUnN; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=aKAnYuFZ; arc=none smtp.client-ip=103.168.172.154
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="TG6aJUnN";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="aKAnYuFZ"
Received: from phl-compute-01.internal (phl-compute-01.phl.internal [10.202.2.41])
	by mailfhigh.phl.internal (Postfix) with ESMTP id 5F6AF114028E;
	Tue, 25 Mar 2025 08:54:54 -0400 (EDT)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-01.internal (MEProxy); Tue, 25 Mar 2025 08:54:54 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1742907294; x=1742993694; bh=MOVy1vcLa8
	JjDj9Y+X1pDE1D38sTLFPBndytVscnGTE=; b=TG6aJUnN2f2GuBLF20sa/knQsz
	hJ1wVOfTpJFz0J2ISu/dW2tJahzPCAnvFqC68Wxx5CfFRFSjCKUOfnBhfedNBwMT
	KOlHGnqHXqkuE7DejFM7oWVn3aZqfyspnPb1yhUwdSCKozeNJq1e+hDmVBbBSfb9
	F9lR3Bwdwk32197Ud2Bjr02FIMoDVg8QJLwo0/RfAENBrXlNU9KxnhJP/PiZwDVz
	UIxoy1E7hHLUzHdaC93bbgaRIXTwKWEPxhq/0wakSnAU8ON7ppnOiObqxTYwO38Z
	6pgvOybIeeL80qZ57vyElxJeTIF7z/Ye3t96ISbhHCMFFN2S+c7GhTydClPw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=
	1742907294; x=1742993694; bh=MOVy1vcLa8JjDj9Y+X1pDE1D38sTLFPBndy
	tVscnGTE=; b=aKAnYuFZdZOcovw8fWN+WIO1arx4ESvMW3GZs6PvvG86LKSVY8/
	/a7PbH1Bs0SZqik04TE1Bg5LL55sDaaw5f7F90kwB/XaB8SdOonC0U7Gbz5jAM+S
	33Rv4Peop9FPONQq8eWYniaz6ZOrtgJYR9xJFVpUjXmylySVX4Lx+ZzQvXB+xanO
	VyYx+ixttWWILjdSfZw4cNf6c41bMpVABgTXwLlCb1xqtPl+C1lDkWVhUdTu7esl
	oPtT9HyajP19WXkS98aZCa1PU/vE97bjLngBTcrHjyQdzAoJ3fX1k1agTCH7wT8y
	yfv1mn5Iw6ofw22jchBH6rj0bwsI6Bp6niA==
X-ME-Sender: <xms:nqfiZ9vRAs-pPZbxVnZiyQjXSoOiLpunFoL6vGF1WvmoneHgD0HmMg>
    <xme:nqfiZ2c4mFSWbTsopcV2KvSkfbXy2DwEg7O7yvqQe7VUHgmmbR5xENhSFw4KmvXtq
    D-Shfb8yiLSnVL82w>
X-ME-Received: <xmr:nqfiZwzm0A-wWadgZqaHz9qN5T9QFiYP63AXah52v2URBqfKaold2Rmf8s32sjR8yCa_DwF2gS0aTVzTLnFZW-mDFTcylqsA7BH8krI0j0Uf4w>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgdduiedvjedtucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggv
    pdfurfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucenucfjughrpeffhf
    fvuffkfhggtggujgesthdtredttddtvdenucfhrhhomheprfgrthhrihgtkhcuufhtvghi
    nhhhrghrughtuceophhssehpkhhsrdhimheqnecuggftrfgrthhtvghrnhepheekfeefge
    egvdegvdeffeehtedttdffjeeuffelgffgheefleffleejvdefheeinecuvehluhhsthgv
    rhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepphhssehpkhhsrdhimhdpnh
    gspghrtghpthhtohepfedpmhhouggvpehsmhhtphhouhhtpdhrtghpthhtohepghhithes
    vhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopehsrghnuggrlhhssegtrhhush
    hthihtohhothhhphgrshhtvgdrnhgvthdprhgtphhtthhopehmvgesthhtrgihlhhorhhr
    rdgtohhm
X-ME-Proxy: <xmx:nqfiZ0MnlCpUBf3mztDRKCoVtR0vuUdhf4A0egFsEDoPWCIRWZlZNA>
    <xmx:nqfiZ9-tYsSXBRKdwTjFOKEA3A8tekVkbITQ4QNYq6d5seg5YlSJRg>
    <xmx:nqfiZ0X-tHIaLsQWga_zCcm79z1bTwEbeP8Bn4f5wCdYoOOAki9GIQ>
    <xmx:nqfiZ-fSuyNmS1LW0zRaKy28-TjUJ8j-8IOvUs4INdwJuseBlt7rbQ>
    <xmx:nqfiZ4YH47P3kEYEL_pAB-_pfq_1Xc1onki_FpY7SVzcj6wU3neHXw16>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 25 Mar 2025 08:54:53 -0400 (EDT)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id 339504ad (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Tue, 25 Mar 2025 12:54:52 +0000 (UTC)
Date: Tue, 25 Mar 2025 13:54:51 +0100
From: Patrick Steinhardt <ps@pks.im>
To: "brian m. carlson" <sandals@crustytoothpaste.net>, git@vger.kernel.org,
	Taylor Blau <me@ttaylorr.com>
Subject: Re: Possible venues for Git Merge 2025
Message-ID: <Z-Knm2WGeMI9a7zt@pks.im>
References: <Z9vuiCnKcMRRXHOR@pks.im>
 <Z9ySGbE4sq0JfgKs@tapette.crustytoothpaste.net>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Z9ySGbE4sq0JfgKs@tapette.crustytoothpaste.net>

On Thu, Mar 20, 2025 at 10:09:29PM +0000, brian m. carlson wrote:
> On 2025-03-20 at 10:31:36, Patrick Steinhardt wrote:
> > given that this year is the 20th anniversary of the Git project it would
> > be great to host another Git Merge so that the wider community can come
> > together and celebrate. Taylor and I have been chatting about this
> > opportunity a bit to figure out what we're going to do this year.
> > 
> > We have been discussing two different options:
> > 
> >   - Hosting in the US in San Francisco at the GitHub HQ.
> > 
> >   - Hosting in the EU in Amsterdam colocated with the Open Source
> >     Summit Europe.
> > 
> > Typically, the location is alternating on a yearly basis between the US
> > and the EU. So given that last year it was hosted in Berlin it would be
> > the US' turn. But given the recent political climate in the US I'm
> > afraid that many people would not feel comfortable traveling there right
> > now. So in the spirit of being inclusive I think we should at least
> > consider whether we may want to break the typical alternating cycle and
> > host in the EU again.
> 
> Yes, I do think that given current circumstances the U.S. is not a good
> place to host events.  Perhaps that will change in the future, but I
> don't think that would be a prudent choice right now.  I've talked to
> several people who are uncomfortable traveling there, so we'd probably
> get better attendance hosting elsewhere.
> 
> I would be fine with Amsterdam, and I might also suggest a major
> Canadian city (such as Toronto, Montreal, or Vancouver) if we preferred
> to do this in North America (since we've traditionally alternated
> continents).  I can imagine other locations outside of the U.S. that
> might be fine as well, so I'm willing to keep an open mind if a good
> opportunity comes up.

The only reasons why I proposed Amsterdam are the Open Source Summit and
that I have some ways to help out with organizing the event over there.
I would be equally happy with alternatives like Canada, but didn't
really want to propose alternatives like this myself because I would
have to push the entire burden onto somebody else.

So if it would be a possibility and if people could help out getting
things organized in other countries/continents I'd be happy.

Patrick
