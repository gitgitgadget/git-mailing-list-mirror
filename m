Received: from fout-a3-smtp.messagingengine.com (fout-a3-smtp.messagingengine.com [103.168.172.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6B6752EAE0
	for <git@vger.kernel.org>; Thu, 17 Oct 2024 04:29:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.146
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729139346; cv=none; b=F1Y/9chU7x/k5RXDvUgzZKbHgrzC5aKv0we9y114o1Fin9e1zJmjvMsCXHGMvQWFLZ1YG765TnP09HlLF4NXr4VL4Yu84Yp2ecIDaXWYLMirpgdcePe3VfoGBsP3AKpJYerEjSCnEIpY/XXbUHZfoKpp9N0d3irzf1nW5XNZBN4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729139346; c=relaxed/simple;
	bh=P1lomknxiHYqw7rDnX/bVNpiXjirDpH8TvFWDcAv/Hs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=SkDhcQW/7vt/g5Kewky0vuT+k0CH0ayxCkviWiIMtShFCeFxnL+de7c/PuCj6fd5HYYng5uafgJyHgK0dxA785yKCPC7SRJic3TTtaMIyDyEAxct88n5dTjVIUNOPPc49qeRoM+zJKkQALxiQqZA/mEdWUtMHJKRAkI3phOGkXM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=VOfU//5e; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=YY2g8GBc; arc=none smtp.client-ip=103.168.172.146
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="VOfU//5e";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="YY2g8GBc"
Received: from phl-compute-05.internal (phl-compute-05.phl.internal [10.202.2.45])
	by mailfout.phl.internal (Postfix) with ESMTP id 6E78713802C8;
	Thu, 17 Oct 2024 00:29:03 -0400 (EDT)
Received: from phl-mailfrontend-02 ([10.202.2.163])
  by phl-compute-05.internal (MEProxy); Thu, 17 Oct 2024 00:29:03 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1729139343; x=1729225743; bh=CTAfRRVwEq
	DoM7+c6BLUu1TK3/GS14Yj/qZzJl9hquM=; b=VOfU//5exfOSlGeRWxwMNwKa5S
	ckXsdFLI2VcuZ65KtOdaP3076IhCsqH5t0S6A8qtkL0wwcwOzGYEjgPLL8TKQeWO
	TcgrChTJH3QpcywJYcPGDtkZZdCvMK4YG/mm6Wtk/iCQoX6W/DUmz7NAcgWeUGos
	OfmMPv06oO7jETaBzYPpnd4TQCYPC3djD3mI/HNsGfg+TXwlwqI56sH+zwy2B99Q
	za3//og6b5XGfTEHJkzjAPRtfYFVtIme7Xm/pIJU9kvhXv7wse48iMuqF9BJD6DE
	4cHZvekgZIFby85G3PIDkE+X2ZhJ7qdpu2y/vxtKvEnZ6fsMWz0fgWIX1v1A==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm2; t=1729139343; x=1729225743; bh=CTAfRRVwEqDoM7+c6BLUu1TK3/GS
	14Yj/qZzJl9hquM=; b=YY2g8GBc5P4WSw2EAhbpojhwoweBEi1rEMca/BDPSG43
	Ng/C0TPbEOigTEQKR3hDqMXy43ZEgcZmCSaIMGW7cXenVw5ZxUAWiutqkqAbe/PT
	C3bgljFgR/+u0nKusCiWMRR6KrirCC+a8RXYWkmYjXH190LGSdmghw0IXBA3+O4A
	cRp526opp41n+HS3ftT7kgTbKO3rnDH2pOR7+1LTU6JEztqBl7vwWdPZQ5/nL6fC
	rgn8yRUAYKsIsdi3+1ipt7Y9AlghtSr6o9rYWH2ib3iPWNzPZrMeEh4Kb87PP10h
	HL4q4TFB0aEZGQQqKew0AMimelOTkNP3Y+GkFDq1sw==
X-ME-Sender: <xms:j5IQZ6Qgs6c8cof2W2Ykaoahu3MBUCGz_Qh4MJGrGYKoB8Q6NVKEBQ>
    <xme:j5IQZ_xZvu0J3OAT5IVymdX-_UHbv9zIRkxzhvpdmtIauVKr1nGdnngxYuEUe0v_Q
    AOQTt7izg-oS8abfQ>
X-ME-Received: <xmr:j5IQZ30QlbKp4TCWrtlLBhjOpnZI0oCoXMy_KWgtoSpeBq3acaetel8PIIoDKX17Iz1UVB2-ow4lM7BhPn5FJcUPySl1WZrtAH7IZcvwJ17cWg>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeftddrvdehtddgkeefucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggvpdfu
    rfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnh
    htshculddquddttddmnecujfgurhepfffhvfevuffkfhggtggujgesthdtredttddtvden
    ucfhrhhomheprfgrthhrihgtkhcuufhtvghinhhhrghrughtuceophhssehpkhhsrdhimh
    eqnecuggftrfgrthhtvghrnhepveekkeffhfeitdeludeigfejtdetvdelvdduhefgueeg
    udfghfeukefhjedvkedtnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrg
    hilhhfrhhomhepphhssehpkhhsrdhimhdpnhgspghrtghpthhtohephedpmhhouggvpehs
    mhhtphhouhhtpdhrtghpthhtohepphgvfhhfsehpvghffhdrnhgvthdprhgtphhtthhope
    hgihhtsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtohepshhtohhlvggvsehg
    mhgrihhlrdgtohhmpdhrtghpthhtohepvhguhigvsehgihhthhhusgdrtghomhdprhgtph
    htthhopehmvgesthhtrgihlhhorhhrrdgtohhm
X-ME-Proxy: <xmx:j5IQZ2C_Z9Shi9XSDboIneW2HYDTCjUfalKdXLcVXOibKDCQtjDTKw>
    <xmx:j5IQZziA4I6cOhMNFL5MmeKP4EUsQSxngGP3uRAG1CFlsluMqvEBSg>
    <xmx:j5IQZyqET80zI8sMfchQ01QYQNBaQS64bqkgFtSIY6dt7p88fTRwZQ>
    <xmx:j5IQZ2iT7pAsQu4RkKYnTmlmFSHPJsVcnNH6y4aE8DShhdglA4TDQg>
    <xmx:j5IQZ5YS8cmeD5XzBxoJluaX3w9b5QkqRj3O0oMcMdBehN1TImgt3r6s>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 17 Oct 2024 00:29:02 -0400 (EDT)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id c251aa02 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Thu, 17 Oct 2024 04:27:41 +0000 (UTC)
Date: Thu, 17 Oct 2024 06:28:54 +0200
From: Patrick Steinhardt <ps@pks.im>
To: Jeff King <peff@peff.net>
Cc: Taylor Blau <me@ttaylorr.com>, git@vger.kernel.org,
	Victoria Dye <vdye@github.com>, Derrick Stolee <stolee@gmail.com>
Subject: Re: [PATCH] ref-filter: format iteratively with lexicographic
 refname sorting
Message-ID: <ZxCShtdTlv7t5fYy@pks.im>
References: <a873ed828ccae426214cc8f87610df97ff9a269e.1729055871.git.ps@pks.im>
 <ZxA6I67FfPe4fV2F@nand.local>
 <20241017024828.GC1858436@coredump.intra.peff.net>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241017024828.GC1858436@coredump.intra.peff.net>

On Wed, Oct 16, 2024 at 10:48:28PM -0400, Jeff King wrote:
> On Wed, Oct 16, 2024 at 06:11:47PM -0400, Taylor Blau wrote:
> 
> > On Wed, Oct 16, 2024 at 08:00:30AM +0200, Patrick Steinhardt wrote:
> > > But there is one exception here where we _can_ get away with sorting
> > > refs while streaming: ref backends sort references returned by their
> > > iterators in lexicographic order. So if the following conditions are all
> > > true we can do iterative streaming:
> > >
> > >   - The caller uses at most a single name pattern. Otherwise we'd have
> > >     to sort results from multiple invocations of the iterator.
> > >
> > >   - There must be at most a single sorting specification, as otherwise
> > >     we're not using plain lexicographic ordering.
> > >
> > >   - The sorting specification must use the "refname".
> > >
> > >   - The sorting specification must not be using any flags, like
> > >     case-insensitive sorting.
> > 
> > Perhaps a niche case, but what about ancient packed-refs files that were
> > written before the 'sorted' capability was introduced?
> 
> We should be OK there. In that case we actually read in and sort the
> packed-refs entries ourselves. We have to, since we do an in-order merge
> with the loose refs while iterating.
> 
> I do think this optimization is worth doing, and not a problem with our
> current backends. The biggest worries would be:
> 
>   1. Some new ref backend that doesn't return sorted results. I find
>      this unlikely, and anyway it's easily caught by having coverage in
>      the test suite (which I assume we already have, but I didn't look).

My assumption is that a ref iterator that _isn't_ sorted would lead to
undesirable behaviour. I'd be surprised if git-show-ref(1) started to
show refs in a random order. So we have essentially baked the
requirement that ref iterators return refs in lexicographic order into
our codebase already.

>   2. Some new flag combination that requires disabling the optimization,
>      and which must be dealt with in the code. This seems unlikely to me
>      but not impossible. I think enabling the optimization is worth it,
>      though.

And this part is an issue with or without my patch. The logic we have
in the ref-filter API is quite fragile, and everybody who wants to add
some new flags must remember to update `can_do_iterative_format()`. I'm
not really a huge fan of that, but on the other hand the subsystem does
not change all that frequently anyway.

> > >     to sort results from multiple invocations of the iterator.
> 
> I think this part is erring on the cautious side, as we can often
> collapse these into a single iteration due to the ref-prefix work. It
> may be OK to keep using the slower code here if multiple patterns aren't
> commonly used, but I'd suspect that:
> 
>   git for-each-ref --sort=refname refs/heads refs/tags
> 
> could benefit.

Mh. So we do end up using `refs_for_each_fullref_in_prefixes()`, which
may or may not end up collapsing the prefixes. We do sort and dedup the
prefixes via `find_longest_prefixes()`, so we don't have to worry about
e.g. `git for-each-ref refs/tags refs/heads refs/tags`.

So... it should be fine to also use this with multiple patterns? None of
our tests fail, either, which reassures me a bit.

I'll send a v2 that loosens this requirement.

Thanks for your input!

Patrick
