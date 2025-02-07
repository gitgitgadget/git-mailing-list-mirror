Received: from fhigh-a7-smtp.messagingengine.com (fhigh-a7-smtp.messagingengine.com [103.168.172.158])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BE26316DEA9
	for <git@vger.kernel.org>; Fri,  7 Feb 2025 06:16:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.158
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738908979; cv=none; b=DAF6R7XmWfbzyRQx3iK9VyhSzeym2FEmsVjXWRV1459Vy+tS+F4DxFy4d0j03Z4usWWjsZj232o7RYxYBASTc1BDWgVTdKJtqle7BixRcCBmSCAqigedzs8rc4VBfTOjAxHcaMkJk1ySxfF3/Q4lsDQHHjFWhtchPu+OlGWLgKg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738908979; c=relaxed/simple;
	bh=d/CKmruFge+2zhjP0iuXFEpLJcHv1nhScmx09H6OOqQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=IlQZMIZNgop0cnZBE+mt2EhrDneaDk0J50lPvflk/n538GSTcjnAZ91rHQ628j90LDD7sac3dHXl54eIcFfEEZ/IpmmLtVX3Qf7g3xQHLReubVoJXLjIIWibvL/5NpBDBkgOvjKEkZjaGdgYQ+HN65O/ihwLOt+LL4zsETkivXc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=p7OypCe9; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=FEL+Ojop; arc=none smtp.client-ip=103.168.172.158
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="p7OypCe9";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="FEL+Ojop"
Received: from phl-compute-01.internal (phl-compute-01.phl.internal [10.202.2.41])
	by mailfhigh.phl.internal (Postfix) with ESMTP id BB195114017D;
	Fri,  7 Feb 2025 01:16:16 -0500 (EST)
Received: from phl-mailfrontend-02 ([10.202.2.163])
  by phl-compute-01.internal (MEProxy); Fri, 07 Feb 2025 01:16:16 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1738908976; x=1738995376; bh=kuOsp4L1E/
	r9eLO/oPyu1Ms4wY8HOMTkYvwNTkOnYeg=; b=p7OypCe96s8aSIkM76R/2qiZWr
	rId/Aids5VbDeFf4/2ViYS5LrB5nlnlgfmxcxQPBZ0U9/XSlvjvgHI5rPnIU4+IL
	K5/EDY+E8VX1YMo2iLgKbfMKHbcZ2H3Iq+AlKN1jaSDcbrX1iEHLDT5+2AAzHulX
	u8M8nR9jHqB9L6WI4U17yw7DJszbBy+ltY4F7YnM9IZZnC+gkiQ5BGaJnlSKB9dB
	iS1iFsnK5nwnyeSRLdAqAa2NXMszgnq3A1OdZmOENBKyNK+3nPq27e+yVMbVtHIh
	XPHkTR59jooltiuxqAHyV9wek+SySjZ03SUffu0Nx1aSdw5ltrMOo0qKNQXQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
	1738908976; x=1738995376; bh=kuOsp4L1E/r9eLO/oPyu1Ms4wY8HOMTkYvw
	NTkOnYeg=; b=FEL+OjopNfyP7sn42DBgYLWF+KQI3RgVeHiirp+GaDPLvvNQt0U
	mslnVBPyYp3RTZTzYZmQBtD5UYP6vF6Y9NLNRwbPHs60Hp/q8ueMRT0CMadTljSH
	TawOQdtIc7kyhci18q0NvSnv93cP4kClKbnB2Hwuk+Cv7bqntxMffmqzBnBJ/Gdh
	TEzOGCERZEV6NDJkAPG9IrPC0ZLXZ9zJzNUltrwIDddvXkzvn0V7JInxxwgJsYUG
	h1AWvumOPtM6hMhvyni+ZaWrBuZdKjC5A45ptqm6BihxaLJ8sjBT6gFcJgspguTR
	gR8ZCeSVWxQR5hxz/7bt3vfdPOY41sVR2NQ==
X-ME-Sender: <xms:MKWlZ4sk-fVTyuFALZcReluvEkw-43qtXSdnonxvpswhTgyTUAZSRw>
    <xme:MKWlZ1eNAxSaFfMDrnsjbX4av-nN_32HIZJMOK7j8B72qa-EpGUhr8FJwTvuAD4fI
    TqGGIcUAtoyAG9iKw>
X-ME-Received: <xmr:MKWlZzywE2xjwhaYyXyb0DniH4NO7HGHtvhEo9m7EwJjXglVF3plZVt-wJSgselHKz9uplLekayr4YteeST0pVUmlbW3omdpjLtyrxKUMfxTDBd->
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgddvkeehvdcutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpggftfghnshhusghstghrihgsvgdp
    uffrtefokffrpgfnqfghnecuuegrihhlohhuthemuceftddtnecunecujfgurhepfffhvf
    evuffkfhggtggujgesthdtredttddtvdenucfhrhhomheprfgrthhrihgtkhcuufhtvghi
    nhhhrghrughtuceophhssehpkhhsrdhimheqnecuggftrfgrthhtvghrnhepveekkeffhf
    eitdeludeigfejtdetvdelvdduhefgueegudfghfeukefhjedvkedtnecuvehluhhsthgv
    rhfuihiivgepudenucfrrghrrghmpehmrghilhhfrhhomhepphhssehpkhhsrdhimhdpnh
    gspghrtghpthhtohepvddpmhhouggvpehsmhhtphhouhhtpdhrtghpthhtohepshhhvghj
    ihgrlhhuohesghhmrghilhdrtghomhdprhgtphhtthhopehgihhtsehvghgvrhdrkhgvrh
    hnvghlrdhorhhg
X-ME-Proxy: <xmx:MKWlZ7Nd63jKvBST1kRQGeGlbSoHWgegh11KNDsTFuzkcjqBTM4m8A>
    <xmx:MKWlZ497rclUnvKLyLIApNL5vbwjh7AMmTKHOboMd5fDH2ghsCy4_A>
    <xmx:MKWlZzWymiZYd-fqDUKQUWdApNO1NR-2wLdDarNILaiNg8ViukuFUg>
    <xmx:MKWlZxcQcx2vqpK-m6MAYP2jMNUIR2j11K3xffDcxXZ-gTheBpCknA>
    <xmx:MKWlZ6LLkCjgJOjvCvgJXuSJ_XVrraqpfa8qTbGnEZOOlNsld9DuDcRh>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 7 Feb 2025 01:16:15 -0500 (EST)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id 0e762434 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Fri, 7 Feb 2025 06:16:14 +0000 (UTC)
Date: Fri, 7 Feb 2025 07:16:13 +0100
From: Patrick Steinhardt <ps@pks.im>
To: shejialuo <shejialuo@gmail.com>
Cc: git@vger.kernel.org
Subject: Re: [PATCH 00/16] path: remove dependency on `the_repository`
Message-ID: <Z6WlLdwvHuBZg_Is@pks.im>
References: <20250206-b4-pks-path-drop-the-repository-v1-0-4e77f0313206@pks.im>
 <Z6Tf1uSjKpXsg9aO@ArchLinux>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Z6Tf1uSjKpXsg9aO@ArchLinux>

On Fri, Feb 07, 2025 at 12:14:14AM +0800, shejialuo wrote:
> On Thu, Feb 06, 2025 at 08:57:56AM +0100, Patrick Steinhardt wrote:
> > Hi,
> > 
> > this patch series removes the dependency on `the_repository` from the
> > "path" subsystem. The series is structured as follows:
> > 
> >   - Patches 1 to 5 unifyf the interfaces that can be used to retrieve
> >     repository paths (gitdir, commondir, workdir and submodule paths)
> >     and adapts callers accodringly.
> > 
> >   - Patches 6 to 12 drop repository path functions that had an implicit
> >     dependency on `the_repository`.
> > 
> >   - Patches 13 to 16 refactor "path.c"-internal code to stop depending
> >     on `the_repository`.
> > 
> 
> Thanks for working on this. However, I feel a little hard when reviewing
> the code for patch 13 to patch 16. They are not so relevant to the
> previous twelfth patches.

Thanks for your review!

> One thing I want to recommend is that we may combine the first and the
> second step. It is a little wired that we first refactor the code then
> we use the new one. When reading the code, I have to step back to the
> previous patch to understand something.

But those are about very different things. The first step fills in
missing interfaces and unifies the calling conventions, whereas the
second step removes users of functions that don't have a dependency on
`the_repository`. From my perspective, mixing these two steps up with
one another would only lead to confusion as we're doing too many things
at once.

Patrick
