Received: from fhigh-b2-smtp.messagingengine.com (fhigh-b2-smtp.messagingengine.com [202.12.124.153])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6D1FC1D5AB9
	for <git@vger.kernel.org>; Mon, 10 Mar 2025 07:11:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.153
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741590671; cv=none; b=cJXK5hZJVAtuIwKRrMd4VZZlyWOS57xQyfW6Ze1YH0fqMf7lC8AvjobkboTxIUcz7KJQvKr1C3+brP5MHgmbXDyD8EAkdapvwOggBZyJcjKuOlX1R4XeGhMpknB1pA//BaRxbw9eBMosqr4hqRdMXYeQ6txNV+hVpAp29e0vnxI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741590671; c=relaxed/simple;
	bh=/+WaN4hhrNrYq+3PULofrHcyPFmPY8oR8BVovuNfRY0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=qs18IIpSXaMzDjU3MmebNreouXb6FNdhqeblmvdnB9OkBmdyX4qgqM48yZGory22W2blyQsER84gA0lPr3bQgna0hb/keegh7DgBNm3TxF/8KR9KMWlldkmnyg0Uc3kf06f51r1wNPvdjDxRmqC3cenuTls6q0yd5gj/wM+T6OY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=nYld2Ex9; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=oleV+Mu9; arc=none smtp.client-ip=202.12.124.153
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="nYld2Ex9";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="oleV+Mu9"
Received: from phl-compute-10.internal (phl-compute-10.phl.internal [10.202.2.50])
	by mailfhigh.stl.internal (Postfix) with ESMTP id 5A8922540104;
	Mon, 10 Mar 2025 03:11:08 -0400 (EDT)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-10.internal (MEProxy); Mon, 10 Mar 2025 03:11:08 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm1; t=1741590668;
	 x=1741677068; bh=nLlLoRG6YI6d5j2+PSefXwmZ2a1tS3AmfIeW+5K4qsc=; b=
	nYld2Ex9/CIHlVHW1bomOUXx5NhXo/pmM4l9WKzwxPEvrL0o1fmSHfYFoM5lm/K8
	i4zwz9wfo36wNFi9kX9M6rq7XSbSoYgVJKPOE8TgB//VVatbqpCtxhKkaUGFFixx
	yoW2DHtFbCFyfKcMTlf70CewP9a3iBUMRCFeoEmuqe8VJjOsTihOvgYnPYFptc1t
	rsogont4lYs7K7hguGZuwLnGDc8agfwfxwBeyFR64jeMkzsRfm/7GOudo4mUU7sa
	EfpsmhhmcdkzeTrQjzO/xDOaeMKSb1Bb57Sx4KSEHW9DPRh4P4YBU/oNcweW8Uov
	gNovGJ/fmKETkiFPuHZWSg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1741590668; x=
	1741677068; bh=nLlLoRG6YI6d5j2+PSefXwmZ2a1tS3AmfIeW+5K4qsc=; b=o
	leV+Mu92vK0tVaCbWGOU7ZGZwJfwPqPz/HjBQ6Jw+Px0ZxU0MT2yT1WTy+s8l68U
	1JbZKCG5sb+iChMcDpZ9/82UtTN4NrOyE+dBYTQLe9K3inb3Sv5epjGgV1F3Zq9X
	c0HAL51JVjm16Az5BtAOFHCnL29erer04yjn6r7ssT8xMw5ngUEqoK1xIYbhTutK
	aRlIIhSiLUh7AYCIUulV+schlBglcgfsmmkOVJpM2eCuKqhchRItK0v5qXfn6Mk/
	zPPsoNW1uhiafaotBPfjU/V/v0Dic6nBEj+n62B2eIgY1OimSpEAa1jaoUcLfsZo
	p9/QhYHRQ6NuVeMZVhK9A==
X-ME-Sender: <xms:jJDOZ0qZqxYheTcmBB7fNWQEcZHkVS5NgvF7WYQ0gZh9FJheDklvqg>
    <xme:jJDOZ6rc9pai32Zi0qc1Yl33zUlxp1VOUqWSKZdI32ppyRMOwc8vZOOyZJI2DNulK
    VpFW7KwyX96_GclSg>
X-ME-Received: <xmr:jJDOZ5MIdeEsysuHYifNCZvC0OebgmQgE7HxsV_Lr4n0yeq0aWzkToRFQfehfWJnByf7v6_U_pRhjQPHkStxkveu8fSrfkzIfajLiCpEmhUvbg>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgdduudekjeduucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggv
    pdfurfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpih
    gvnhhtshculddquddttddmnecujfgurhepfffhvfevuffkfhggtggugfgjsehtkeertddt
    tdejnecuhfhrohhmpefrrghtrhhitghkucfuthgvihhnhhgrrhguthcuoehpshesphhksh
    drihhmqeenucggtffrrghtthgvrhhnpedvfeejiedtteelheeiteekveeftdefvdehkedv
    veetffdvveevjeejleegtedvgfenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmh
    epmhgrihhlfhhrohhmpehpshesphhkshdrihhmpdhnsggprhgtphhtthhopeegpdhmohgu
    vgepshhmthhpohhuthdprhgtphhtthhopehkrghrthhhihhkrddukeeksehgmhgrihhlrd
    gtohhmpdhrtghpthhtohepjhhlthhosghlvghrsehgmhgrihhlrdgtohhmpdhrtghpthht
    ohepnhgvfihrvghnsehgmhgrihhlrdgtohhmpdhrtghpthhtohepghhithesvhhgvghrrd
    hkvghrnhgvlhdrohhrgh
X-ME-Proxy: <xmx:jJDOZ74k8Mp0h--TzUJCJ86gVE8QNZarI3WpBAAwNXUADSkefp2P0w>
    <xmx:jJDOZz4drgjoaYx_BS1O1Zw7L8DCl_-NwLPsQTSiMmqKSHchQQDUBw>
    <xmx:jJDOZ7jDdlpLWn17ru-6hUrWx10M1w-0X7QH6r9JGCx6r-7TsZ3uug>
    <xmx:jJDOZ942pqjJbep22qigoxXCB7V8GH0SpCx3i3yoASXTndVT7uGN9A>
    <xmx:jJDOZ22DiB5YwQIj4zt4QMVa2dd2cz9w9P2yMlnJV2vQ9wdM0-4q4-MI>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 10 Mar 2025 03:11:07 -0400 (EDT)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id 21822516 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Mon, 10 Mar 2025 07:11:04 +0000 (UTC)
Date: Mon, 10 Mar 2025 08:11:03 +0100
From: Patrick Steinhardt <ps@pks.im>
To: Elijah Newren <newren@gmail.com>
Cc: git@vger.kernel.org, Karthik Nayak <karthik.188@gmail.com>,
	Justin Tobler <jltobler@gmail.com>
Subject: Re: [PATCH v3 12/12] hash: stop depending on `the_repository` in
 `null_oid()`
Message-ID: <Z86Qh1yLUC7aIaG9@pks.im>
References: <20250307-b4-pks-objects-without-the-repository-v3-0-7bccf408731e@pks.im>
 <20250307-b4-pks-objects-without-the-repository-v3-12-7bccf408731e@pks.im>
 <CABPp-BG0AtKdUH2g8+_f0J0ViWs5xZKM9kCcbWYZ=uEu6bswdQ@mail.gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CABPp-BG0AtKdUH2g8+_f0J0ViWs5xZKM9kCcbWYZ=uEu6bswdQ@mail.gmail.com>

On Sat, Mar 08, 2025 at 08:05:09AM -0800, Elijah Newren wrote:
> On Fri, Mar 7, 2025 at 6:20 AM Patrick Steinhardt <ps@pks.im> wrote:
> >
> > The `null_oid()` function returns the object ID that only consists of
> > zeroes. Naturally, this ID also depends on the hash algorithm used, as
> > the number of zeroes is different between SHA1 and SHA256. Consequently,
> > the function returns the hash-algorithm-specific null object ID.
> >
> > This is currently done by depending on `the_hash_algo`, which implicitly
> > makes us depend on `the_repository`. Refactor the function to instead
> > pass in the hash algorithm for which we want to retrieve the null object
> > ID. Adapt callsites accordingly by passing in `the_repository`, thus
> > bubbling up the dependency on that global variable by one layer.
> >
> > There are a couple of trivial exceptions for subsystems that already got
> > rid of `the_repository`. These subsystems instead use the repository
> > that is available via the calling context:
> >
> >   - "builtin/grep.c"
> >   - "grep.c"
> >   - "refs/debug.c"
> >
> > There are also two non-trivial exceptions:
> >
> >   - "diff-no-index.c": Here we know that we may not have a repository
> >     initialized at all, so we cannot rely on `the_repository`. Instead,
> >     we adapt `diff_no_index()` to get a `struct git_hash_algo` as
> >     parameter. The only caller is located in "builtin/diff.c", where we
> >     know to call `repo_set_hash_algo()` in case we're running outside of
> >     a Git repository. Consequently, it is fine to continue passing
> >     `the_repository->hash_algo` even in this case.
> >
> >   - "builtin/ls-files.c": There is an in-flight patch series that drops
> >     `USE_THE_REPOSITORY_VARIABLE` in this file, which causes a semantic
> >     conflict because we use `null_oid()` in `show_submodule()`. The
> >     value is passed to `repo_submodule_init()`, which may use the object
> >     ID to resolve a tree-ish in the superproject from which we want to
> >     read the submodule config. As such, the object ID should refer to an
> >     object in the superproject, and consequently we need to use its hash
> >     algorithm.
> >
> > This means that we could in theory just not bother about this edge case
> > at all and just use `the_repository` in "diff-no-index.c". But doing so
> > would feel misdesigned.
> 
> Very minor, but this was a bit jarring to me -- shouldn't this
> paragraph be indented over since it is a continuation of the second
> bullet above?

Yes, you're right!

> > @@ -4304,7 +4304,7 @@ static int process_entry(struct merge_options *opt,
> >                 /* Deleted on both sides */
> >                 ci->merged.is_null = 1;
> >                 ci->merged.result.mode = 0;
> > -               oidcpy(&ci->merged.result.oid, null_oid());
> > +               oidcpy(&ci->merged.result.oid, null_oid(the_hash_algo));
> >                 assert(!ci->df_conflict);
> >                 ci->merged.clean = !ci->path_conflict;
> >         }
> 
> What you have is an improvement since it's at least making things
> explicit, but these should really be opt->repo->hash_algo.

Oh, yeah, I suspect that we'll have a bunch of places where we can
already plug in a repository as available via the context. I typically
refrain from doing though unless really necessary (e.g. when the file at
hand doesn't declare `USE_THE_REPOSITORY_VARIABLE` anymore). This is so
that neither I nor reviewers have to carefully vet every callsite, but
to make this a mechanical change that is obviously correct because it is
identical to the old state. So I'm basically leaving it to the next
patch series that gets rid of `USE_THE_REPOSITORY_VARIABLE` to think
more carefully about those callsites.

Thanks!

Patrick
