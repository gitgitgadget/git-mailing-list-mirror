Received: from fout-b2-smtp.messagingengine.com (fout-b2-smtp.messagingengine.com [202.12.124.145])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 77D07191F95
	for <git@vger.kernel.org>; Mon, 14 Apr 2025 06:50:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.145
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744613431; cv=none; b=GxfufgM+x9u65kU4oUIvBss52iaTXbSXZOsN2Gg6m0+Jpa0jJwdWdcGOMt9/W3PvCq1vit77Pmde1mO4ENPXuMERexyRYcm1y2MG9j1+doD+qK1xE/ysh99npfNYdZ6HfdSNPji9CGfTEE7ut/Kz8jWnkAXj8+KFR4H/sQkaP6w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744613431; c=relaxed/simple;
	bh=2ghpc5KfiOCcJjT0D/5UKoIvt/4vslHywrk7EEhfd7A=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=sC3+PxB13HNUA3a4yPBkO0od7lSkotBc34C90WRs3prod0+CLE1n8ZyWxvxhD4PT0bODbBSJW+xcI1jNg3MhbcWEzMwBdn7jJZNCoyHy7/g3a2aqPkr0tlhQ3BkUtrRsLJcSbMD6t4/c39tIweOznfOYFkH2RwHFm7vq+26ziao=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=mbiLhv8p; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=Wdvi5UTs; arc=none smtp.client-ip=202.12.124.145
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="mbiLhv8p";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="Wdvi5UTs"
Received: from phl-compute-12.internal (phl-compute-12.phl.internal [10.202.2.52])
	by mailfout.stl.internal (Postfix) with ESMTP id 72826114012D;
	Mon, 14 Apr 2025 02:50:28 -0400 (EDT)
Received: from phl-mailfrontend-02 ([10.202.2.163])
  by phl-compute-12.internal (MEProxy); Mon, 14 Apr 2025 02:50:28 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1744613428; x=1744699828; bh=VmYrC9tLYx
	jq3IX5p0ThxgL6ghzuWgQc0CuTfw5+dxU=; b=mbiLhv8pkpWfTVqCv9+EGLjH7U
	FuUjISSXwXARuC3xr+SkmCZ2j1Vz+/S/U+qyyxAPaE0brKZGLHDiVrk8hVUIich+
	1FHQKkWikahuCEuDgKFvrijlyxwM0rRdjgZY/8RKjXpUaO+3jAtj6AD3CvlCIMWU
	HjI+ORIQi5fYU/kKkP9Tu09RO+RFaYGHDkDSyh1jELf3yD4yDXDNghcRBG1Gfg9M
	p2w6DyKCgxHSRPhbyhudS3Y7ZGZO7OGowuvvABhHb3gISX8VUxcnApsBdPezDfXw
	BLvuWPfI/BLEIWlyw1DiI3jMdoRE6TcHP/TfDBk7kIRI8PLa93aOxWHQBrMw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=
	1744613428; x=1744699828; bh=VmYrC9tLYxjq3IX5p0ThxgL6ghzuWgQc0Cu
	Tfw5+dxU=; b=Wdvi5UTsUtRbJL/zYSfwskD+39EbbbOz0yYKeZOYz+YwqL8fMDv
	HIRFxeVLmBz67u86w/2rx5tIkhWZj8EAtkhRqxcvBHeS/7jK5O1/ndj09urxDvyy
	n5AIzx8cutPjbz1tRfNkKK0U0zaS6v2XmOgCcJ3IMo4XuSJRZyig9szX/AWatUwJ
	y8RhOhoTBRIMczRBmjh11exSwrpa7xuWUvyhIGgiFUQ/LPgMBDGxPaItWYRLP/NR
	InttxcK5AzkfUe3t6FUMProCEyQaO4RjxFU7YeYcJ0Db3qVL1Y4bz0vhXKlGmyo8
	dyJLYHni/iHCEQxIbfNssFAD9pJNjV58LlQ==
X-ME-Sender: <xms:M7D8Zzf6gfsX0sWbxGPkU9FFOuyPppOosQhZ3GyPzj1cQXiO1VbkiA>
    <xme:M7D8Z5MPz4FBp9mtULAdpWrQVKV-PyRJAvy-uid2Ye77FwTlS6NXsJwC6gL-hRj1O
    0_JJhPm4khpgevHAw>
X-ME-Received: <xmr:M7D8Z8gLDBrY9WhTN2XgQINlv3hfHv_uOTpTeaQpTurDAhJkE9DYAQBkfcJgo7QZnxCIrEa5EVBiEqlCaGmquzdjLPJ9WDMK72c2cmVNneFH>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgddvudelkeejucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggv
    pdfurfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpih
    gvnhhtshculddquddttddmnecujfgurhepfffhvfevuffkfhggtggujgesthdtredttddt
    vdenucfhrhhomheprfgrthhrihgtkhcuufhtvghinhhhrghrughtuceophhssehpkhhsrd
    himheqnecuggftrfgrthhtvghrnhepveekkeffhfeitdeludeigfejtdetvdelvdduhefg
    ueegudfghfeukefhjedvkedtnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpe
    hmrghilhhfrhhomhepphhssehpkhhsrdhimhdpnhgspghrtghpthhtohepvddpmhhouggv
    pehsmhhtphhouhhtpdhrtghpthhtohepghhithesvhhgvghrrdhkvghrnhgvlhdrohhrgh
    dprhgtphhtthhopehtohhonhesihhothgtlhdrtghomh
X-ME-Proxy: <xmx:M7D8Z08g-nrjW9D7n3kPh5Pj2JECMCiT-V5Lacoidtkkl8dbUtV1UA>
    <xmx:M7D8Z_t_npx37bLKIcxuW0ija7mwGSULdMi1Z-pr8LsrJU6Q-8_n6w>
    <xmx:M7D8ZzGcwjye9EiK2_moK5U3NAU68i48F0iIU1F9RgGwafRIl9NdfQ>
    <xmx:M7D8Z2MY-qRHGL1Ct4bW8MkojENJzhU0iVBD8VisbPF8P8pu_JOaxw>
    <xmx:NLD8Z_d763p7a7mC_y_qAmNVh3YLAf1PTJJi-h24-qnYhdgnRU2O0ydM>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 14 Apr 2025 02:50:27 -0400 (EDT)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id 0afbf6e0 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Mon, 14 Apr 2025 06:50:26 +0000 (UTC)
Date: Mon, 14 Apr 2025 08:50:26 +0200
From: Patrick Steinhardt <ps@pks.im>
To: Toon Claes <toon@iotcl.com>
Cc: git@vger.kernel.org
Subject: Re: [PATCH 4/5] meson: wire up benchmarks
Message-ID: <Z_ywMpJ7PuOvQu2k@pks.im>
References: <20250331-pks-meson-benchmarks-v1-0-b2ace85616a3@pks.im>
 <20250331-pks-meson-benchmarks-v1-4-b2ace85616a3@pks.im>
 <87r020dyvc.fsf@iotcl.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <87r020dyvc.fsf@iotcl.com>

On Thu, Apr 10, 2025 at 01:44:55PM +0200, Toon Claes wrote:
> Patrick Steinhardt <ps@pks.im> writes:
> 
> > Wire up benchmarks in Meson. The setup is mostly the same as how we wire
> > up our tests. The only difference is that benchmarks get wired up via
> > the `benchmark()` option instead of via `test()`, which gives them a bit
> > of special treatment:
> >
> >   - Benchmarks never run in parallel.
> >
> >   - Benchmarks aren't run by default when tests are executed.
> >
> >   - Meson does not inject the `MALLOC_PERTURB` environment variable.
> >
> > Using benchmarks is quite simple:
> >
> >     ```
> >     $ meson setup build
> >     # Run all benchmarks.
> >     $ meson test -C build --benchmark
> >     # Run a specific benchmark.
> >     $ meson test -C build --benchmark p0000-*
> >     ```
> 
> I really appreciate the efforts, and I'd love to run the perf tests with
> Meson, but at the moment I don't know how these changes are useful
> because this doesn't print anything relevant:
> 
>     $ meson test -C build --benchmark 'p0005-*'
>     ninja: Entering directory `/home/toon/devel/git/build'
>     [1/28] Generating GIT-VERSION-FILE with a custom command (wrapped by meson to set env)
>     1/1 p0005-status        OK              7.39s
> 
>     Ok:                 1
>     Expected Fail:      0
>     Fail:               0
>     Unexpected Pass:    0
>     Skipped:            0
>     Timeout:            0
> 
>     Full log written to /home/toon/devel/git/build/meson-logs/testlog.txt

You can execute with `meson test -i`, which will cause Meson to print
the benchmark's output.

> > Other than that the usual command line arguments accepted when running
> > tests are also accepted when running benchmarks.
> >
> > Note that the benchmarking target is somewhat limited because it will
> > only run benchmarks for the current build. Other usecases, like running
> > benchmarks against multiple different versions of Git, are not currently
> > supported. Users should continue to use "t/perf/run" for those usecases.
> > The script should get extended at one point in time to support Meson,
> > but this is outside of the scope of this series.
> 
> Yeah, this is unfortunate, but totally understandable. I've been digging
> in `t/perf/run` and `f/perf/aggregate.perl` and it doesn't look easy to
> adapt to Meson.
> 
> But I was wondering, instead of trying to fully integrate Meson into
> those scripts, could we modify the scripts so they work with binaries
> built by Meson? I mean, if we could run
> `cd t/perf && ./run ../../build1 ../../build2 p0005*` and it would
> simply run the benchmarks in those directories (without trying to check
> out code and build the sources). I think this would help a lot already.

This is another thing we could (and eventually should) do, but it's
orthogonal to this patch series from my point of view.

Patrick
