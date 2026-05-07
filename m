Received: from fhigh-a6-smtp.messagingengine.com (fhigh-a6-smtp.messagingengine.com [103.168.172.157])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 667872E8B6B
	for <git@vger.kernel.org>; Thu,  7 May 2026 10:24:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.157
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778149451; cv=none; b=J/HGFiCNH2AzedGxf7OKchHvaOCT0jB4u2mn4g2jVwTmwLP8dwk4OOVsJ/7L10RoWPJU3sryacpsuTXNFxrvKL4RyXn0l6k6COmD+wWmQIqZBANwIhJ0MT62x3KnQzXXmq2WkeoLgwYszCZ4fNMDe2g7CkEhhFyzYnu9FwtakWc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778149451; c=relaxed/simple;
	bh=Zxv8mvCLptBXEtWdliRpyXzn/lcT9dO6UcsEw+/rjnM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=r3+sAL9De55f4oOCBZLPSuBCUDno6Si6T8qjePd0ahqgqdJHxO71Uwn8OnsfNSGTpDfG5cui29aP14upT2dNjOieTMHb+cnMMoRss7c1mVUINj3KkcJKHiuCr74ARcb/KPVG6HJfgew0BiSX0yGoXACrmvQtbYCFPn4I0UdVGrA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=eikBPCyl; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=s9urpDJL; arc=none smtp.client-ip=103.168.172.157
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="eikBPCyl";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="s9urpDJL"
Received: from phl-compute-01.internal (phl-compute-01.internal [10.202.2.41])
	by mailfhigh.phl.internal (Postfix) with ESMTP id 996DE14000EC;
	Thu,  7 May 2026 06:24:09 -0400 (EDT)
Received: from phl-frontend-03 ([10.202.2.162])
  by phl-compute-01.internal (MEProxy); Thu, 07 May 2026 06:24:09 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1778149449; x=1778235849; bh=KjUMsfJqde
	KnwILsylt7TJZFjiQ+e5HBqIap5LkFWVw=; b=eikBPCylXQAbuwBd+Ru75Vdw6a
	ApDI30SyTLDDNIdiASzk3+0xQxTNvRh3s65M3fp/8KHEMKbekxoyCr/qXxWXSgU5
	X2OzkB8pxJnHe1iIXRelZ/eE+z9m4WjESBqCqk5ELGNy7XApp+ybnL6N9iMUMRcm
	wZ7t4nhDuWnZ3JUdmrELW+APRGqJbZFrjfT97H0i0Q6FYHHOX7MJbjFstje20v7H
	yU4NlzusPAEeamPN/xcYlAClmyfcv0tgV1D5s0ZIJAGglWAgi7rwVqR0AidwaUlQ
	+Ai67WKxAlfbBrCy/DijAYlrUQIM7WdK+ANRJJEJe0QjoiY5xbytJb5zzihQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
	1778149449; x=1778235849; bh=KjUMsfJqdeKnwILsylt7TJZFjiQ+e5HBqIa
	p5LkFWVw=; b=s9urpDJLOHG7wGzb8c7sOFfZDUXDfkBF0irtigmJrWkWwnzOWg5
	fHPTCyWQc5YcrWgDBIZa+xiGzZwEYskDOhDqua6zzLVvM1Hu0y78T1tf56JrWLaS
	d0LrY+yjnskY195ROrGkvx0FQTCNsrHs5cSpRcwLkMrYFX5ygmZ1qyYYphyoDITb
	fxdVWhvlQaZVDScCRn95F+Cpk9jdeCNbhOt3HYPcr+OFmVwNBeKPt3MyGNN/cXoF
	D/NbKQlLx35kl7Dy/zDWQkU6KaHKqSJZqckzugQna1zOCqpHxgDNG21dJJ8rIGRl
	EYG05PDvMss0mRPmwN3adk8SA2lqpu4/KYA==
X-ME-Sender: <xms:SWj8ablUPxp3jugXPYHQRRFYhMtJ_5pio-NDi0BW6s4WM_h_T4GelQ>
    <xme:SWj8aRFNb5ruKYNShbI220MZsSyDpRwNnVxALqJx7dUxxOob0SykOsitQ8UOu_hBT
    yEO661pfSUVAH1drUfQBLnET_Qm8aOoNNWHus0SAEYbbki1BwkLyA>
X-ME-Received: <xmr:SWj8aT7ykHUwwf0A974_TM0NBYeeENAXgd77XyTKJTEkgTyMbCAIx7GECPqOgOlWDnXN0Nb_14csd4H6LLK-KM2Se7WFAXI6cLczhxTxBmJ8lA>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefhedrtddtgddutdejvddvucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhepfffhvfevuffkfhggtggujgesthdtredttddtvdenucfhrhhomheprfgrthhrihgt
    khcuufhtvghinhhhrghrughtuceophhssehpkhhsrdhimheqnecuggftrfgrthhtvghrnh
    epjeevudeggfffffeigeethffgieekveeffeehvedvgeeiteegueejleeihfeitdeunecu
    ffhomhgrihhnpehkvghrnhgvlhdrohhrghenucevlhhushhtvghrufhiiigvpedtnecurf
    grrhgrmhepmhgrihhlfhhrohhmpehpshesphhkshdrihhmpdhnsggprhgtphhtthhopeej
    pdhmohguvgepshhmthhpohhuthdprhgtphhtthhopehtsghovghgihesfigvsgdruggvpd
    hrtghpthhtohepghhithesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopehg
    ihhtghhithhgrggughgvthesghhmrghilhdrtghomhdprhgtphhtthhopehsthholhgvvg
    esghhmrghilhdrtghomhdprhgtphhtthhopehgihhtshhtvghrsehpohgsohigrdgtohhm
    pdhrtghpthhtohepphgvfhhfsehpvghffhdrnhgvthdprhgtphhtthhopehjohhhrghnnh
    gvshdrshgthhhinhguvghlihhnsehgmhigrdguvg
X-ME-Proxy: <xmx:SWj8aZlGMuz3ZcVT-PkFaPyoyhabzOflSXumaRTaiuAPxGwJ_k8gbg>
    <xmx:SWj8aYpZlse4vot9A3yC0IgQKOis-8Ww2_WlAoGV5YtUj5QNUMBbZQ>
    <xmx:SWj8aYt7-5j2aP2xiJOMFwgXtKa2NnSnyP7lIqb0Ptq5CF3vdCPQ_w>
    <xmx:SWj8adHXEPYXtwv7cvng3A5ryTapMaNqIfmad2LGkUTJQGrSVL6Egg>
    <xmx:SWj8aUTZXJOGc0Zvqu6hyyW2RbRCDI2xz7IhUvswitvZFs8qlKZ73win>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 7 May 2026 06:24:08 -0400 (EDT)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id ca42807e (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Thu, 7 May 2026 10:24:05 +0000 (UTC)
Date: Thu, 7 May 2026 12:24:02 +0200
From: Patrick Steinhardt <ps@pks.im>
To: Junio C Hamano <gitster@pobox.com>
Cc: Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Derrick Stolee <stolee@gmail.com>,
	Johannes Schindelin via GitGitGadget <gitgitgadget@gmail.com>,
	git@vger.kernel.org,
	Torsten =?utf-8?Q?B=C3=B6gershausen?= <tboegi@web.de>,
	Jeff King <peff@peff.net>
Subject: Re: [PATCH v2 11/11] ci: run expensive tests on push builds to
 integration branches
Message-ID: <afxoQh8SxCqBCaFP@pks.im>
References: <pull.2102.git.1777393580.gitgitgadget@gmail.com>
 <pull.2102.v2.git.1777914508.gitgitgadget@gmail.com>
 <1eaaa7fad7a1432dd97ffdd7c45e8162f61bc302.1777914508.git.gitgitgadget@gmail.com>
 <42f96e54-7b94-4075-91b1-1c2447b93322@gmail.com>
 <xmqq5x52nhg6.fsf@gitster.g>
 <CAPc5daUzr+mn6ojzsqpW6mCXzc2yVqpevVk8njefx4j09G_OgA@mail.gmail.com>
 <e00dbf04-5866-008f-12e9-efdaacc3f2e0@gmx.de>
 <87se83efx1.fsf@gitster.g>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <87se83efx1.fsf@gitster.g>

On Thu, May 07, 2026 at 06:18:34PM +0900, Junio C Hamano wrote:
> Johannes Schindelin <Johannes.Schindelin@gmx.de> writes:
> 
> >> I thought we updated the codebase to avoid stripping away constness
> >> with strchr() and friends, but the error seems to be more like one
> >> hand in the system passing -Wc11-extensions to stick to older version
> >> of C and the other hand in the system that uses _Generic to implement
> >> the const/non-const variants of strchr() in the system header not
> >> knowing that the other tells C11 const-preserving strchr() should not
> >> be used?
> >
> > This was diagnosed (with a proposed fix) by Patrick over in
> > https://lore.kernel.org/git/20260505-b4-pks-ci-tolerate-glibc-generic-v1-1-5786386fe512@pks.im/.
> 
> Indeed.
> 
> > tl;dr It's not about `const`-ness at all, but about glibc using a C11
> > construct which clang's strict c99 checker now refuses, thanks to the
> > upgrade to Ubuntu 26.04 in the `ubuntu:rolling` runners.
> 
> Yes, that is exactly what I meant by one hand knowing that it was
> told not to use c11 extensions while the other hand ignoring and
> always using c11 extensions in the header.  I recall that in the
> past gnu library headers were a bit more careful to make the life
> more pleasant when we use (or decline to use) various features by
> using conditional compilation, but apparently not this case.

Yeah, it's a bit unfortunate indeed. I'd claim that this is a plain bug
though -- as mentioned in the commit message, I think what glibc should
have used is `_has_feature()` instead of `_has_extension()`,  and if so,
I think the issue wouldn't exist.

But oh, well.

Patrick
