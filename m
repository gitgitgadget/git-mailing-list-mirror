Received: from fout-a4-smtp.messagingengine.com (fout-a4-smtp.messagingengine.com [103.168.172.147])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CDFAB1DFD89
	for <git@vger.kernel.org>; Tue,  8 Oct 2024 14:23:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.147
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728397420; cv=none; b=d/mR6I4USlqbdErqqYZQcp0MK7Z80ieof0rm71KBAYnXuYA/pcmFtgvzKPVOUNN4U8cTNOx1O4Mj/hehLb8bTr/K896g4e5I3/knIgETjcC3V6/uSY2TBGdKMx9yWGPnz9OQ3uBWzLhxmzkoIhJsMm4fURMyfzgakHXBiRX0PHo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728397420; c=relaxed/simple;
	bh=TSKZI/Zb+yss/rPDf66GqBjkEsnA2lvTFTCP8l+WtMc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=nbAj74v/X7QS9WEw0n3yjoHLYwWrC8ZBf8T11RkUvBq6o96rXFf86zStvx/4JjaJZNcyAbRAsigBZ77BaEco54V5Q5Nl5gaOoQHw7ZFFIsFLjgWC99lWO4YYZqFlMofFFUgCRDQMXI/CswHZ41PeqP5muWnIwNbtSPsz05CXm6Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=nzWVOanT; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=hiyhszOt; arc=none smtp.client-ip=103.168.172.147
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="nzWVOanT";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="hiyhszOt"
Received: from phl-compute-02.internal (phl-compute-02.phl.internal [10.202.2.42])
	by mailfout.phl.internal (Postfix) with ESMTP id D3CC913802F6;
	Tue,  8 Oct 2024 10:23:36 -0400 (EDT)
Received: from phl-mailfrontend-02 ([10.202.2.163])
  by phl-compute-02.internal (MEProxy); Tue, 08 Oct 2024 10:23:36 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1728397416; x=1728483816; bh=6gbcTd57yH
	lLRTom4bgxEigyUVN086cIRppuAur3UEc=; b=nzWVOanTR/5elhAtMj9hCKhERn
	m5ZVfF8Bpx7E3OLjm+M97F+LYzcZhD0gZ5Qhnjw2KMcn1ezlaVsiLWOs0iu760HS
	2VE2bD12aZ1JzA5tj9oDQUxINzEWXdVDX0jgoOPtII0q9EBLuoyGsqTrcwNUw9a4
	Qz/QZfhKxVwAGUYvuQ8W9oG7ZJJpS3v4Vf8FejsSAnxLtXpIylixWKn4yAoRNMat
	O6iIBgLm8ajvBXDXF0g8KEIYTme8xHlGs1shSYZAgsv7Kly+iyukyr9JbKLTG3cG
	FBT1UYz5BpmbQc4M+MaDSG9h+IhPpm2Z+rOg2i0SRWWmVZlUXNWXxkQBuWHw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm2; t=1728397416; x=1728483816; bh=6gbcTd57yHlLRTom4bgxEigyUVN0
	86cIRppuAur3UEc=; b=hiyhszOt5g7RoZxZrDJq7EGCAvZfnk9qN+o6U6MwQacx
	VUZEYXoWv1Qf1rUh3BouxyZA/TCDuP6APN5G3OYtZy41CBc/KyFs2zCysOMrLIn9
	nMbbh8XpEIY0SxuYACALrC3GXYYUK+hHAr3BcIP2DXRedQJcfEB1adEsfRPsoDot
	uDUGhXr6rCEt2fGfM/BDOOQud2x0p3h1+UFyAD+JWcvqx9UYYxkhKtZqj9cm/2sF
	Gz6tL0QrbAto0FKUZm/duX3J96YZHupPDt62D/r3gCCMgLr9g1FVGYlLj8kUyKVE
	i3AgGSYkvfdRk++b4aHicVuUC5hPr9tKs1dFXNhW6g==
X-ME-Sender: <xms:aEAFZ9_oDhoj5gElMzvAlOIwf0khB_ZSM83xYxm7XYwPzYX-yAD6ig>
    <xme:aEAFZxudG9XzxYDxiZMvRDyOo2AiExR3vTEMEcXRD9Ku7VG6Nzv1KAE87hqjRUa4o
    5f1gjGj6nrdnc_r9A>
X-ME-Received: <xmr:aEAFZ7B-LMIoL4BWqxsRx1vSwrSOAZEGTs97DfC7ismv0C9-QpdvcXosbxqPyVcDPEDZvrkEJypvmCquR9bgZ90FWW-cxp4LwZKHToLZe4ASiMw>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeftddrvdefuddgjeeiucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggvpdfu
    rfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnh
    htshculddquddttddmnecujfgurhepfffhvfevuffkfhggtggujgesthdtrodttddtvden
    ucfhrhhomheprfgrthhrihgtkhcuufhtvghinhhhrghrughtuceophhssehpkhhsrdhimh
    eqnecuggftrfgrthhtvghrnhepjedttdegffekudejjeegudehgfehtdfgtdeiudelueel
    gfeuteehledugeeuueevnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrg
    hilhhfrhhomhepphhssehpkhhsrdhimhdpnhgspghrtghpthhtohepfedpmhhouggvpehs
    mhhtphhouhhtpdhrtghpthhtohepghhithesvhhgvghrrdhkvghrnhgvlhdrohhrghdprh
    gtphhtthhopehphhhilhhlihhprdifohhougesughunhgvlhhmrdhorhhgrdhukhdprhgt
    phhtthhopegvshgthhifrghrthiisehgvghnthhoohdrohhrgh
X-ME-Proxy: <xmx:aEAFZxd951Xrsq88j2uDoYs_8pEefrJF4XynqnejysPAX2KyN8cWDQ>
    <xmx:aEAFZyOxag2z9cEhR759TlMT1gtiOltj1Dgf43h2OKn0coC6lcSnnQ>
    <xmx:aEAFZzl6vbiQLz7y-k_jI4WQxzmtAw0Y5oM4Z9KNvQ36kfyEygW-0w>
    <xmx:aEAFZ8vRpXG_Qbg4lJG-5j1CzA1h47tfqXXEd3AqX_qBPJRv9kH6Ew>
    <xmx:aEAFZ_qNO3YELrnH4aBGR-7llMwhW-VptVIEivwvdqDNBwVv5Fh6cSLw>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 8 Oct 2024 10:23:35 -0400 (EDT)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id 85d641e3 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Tue, 8 Oct 2024 14:22:32 +0000 (UTC)
Date: Tue, 8 Oct 2024 16:23:32 +0200
From: Patrick Steinhardt <ps@pks.im>
To: phillip.wood@dunelm.org.uk
Cc: git@vger.kernel.org, Eli Schwartz <eschwartz@gentoo.org>
Subject: Re: [RFC PATCH 15/21] Makefile: consistently use @PLACEHOLDER@ to
 substitute
Message-ID: <ZwVAXNGTQhUNvBXL@pks.im>
References: <cover.1727881164.git.ps@pks.im>
 <6aaf3263228eefab2478e744197f7d4b651795da.1727881164.git.ps@pks.im>
 <87ab47ef-8ac8-4e4c-9a1e-f5f630f1d21e@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <87ab47ef-8ac8-4e4c-9a1e-f5f630f1d21e@gmail.com>

On Tue, Oct 08, 2024 at 03:04:29PM +0100, Phillip Wood wrote:
> Hi Patrick
> 
> On 02/10/2024 16:16, Patrick Steinhardt wrote:
> > We have a bunch of placeholders in our scripts that we replace at build
> > time, for example by using sed(1). These placeholders come in three
> > different formats: @PLACEHOLDER@, @@PLACEHOLDER@@ and ++PLACEHOLDER++.
> 
> I agree that it's a good idea to stanardise on a single format here.
> 
> > Next to being inconsistent it also creates a bit of a problem with
> > CMake, which only supports the first syntax.
> 
> I'm a bit confused - is this referring to CMake's "configure_file" command?

Ah, yes. I should've made this more explicit.

Patrick
