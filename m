Received: from fhigh-b2-smtp.messagingengine.com (fhigh-b2-smtp.messagingengine.com [202.12.124.153])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 533F3423A93
	for <git@vger.kernel.org>; Tue, 19 May 2026 09:51:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.153
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779184318; cv=none; b=SH8FdbK6r+FV6mUXinmv9zUtdZeEtwD/+B7Q/PL4/pxyOsO5nvn7RErkgNIjnDLA3I8OJ9+n1IbH86ejkqkvcSuou4G8zoD9YxuEleF2JzPBHqXKp1uti95/svdWrjDobVBIPFtaOrnMBdqFaYxtzuVmnMxJ0IQlMAFfdroPU3o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779184318; c=relaxed/simple;
	bh=PUf0fLyA7/ZY1CFJ5ALx2XW3TN8+ial2QvfDief3GZg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=dU9HsNIhYdrudCoHTVfAtoaMJegIKRz7d/gZm64qvF0PMP/O9mZV/9wQcHu690XU9zuH2Ycb1QB2u7bHzyikRcHWexavO5awY0MQZCPkfVihFLsu9c+S9ysQH4RjpEAv4jgPq1BGzzlmx7vrnSuq1cwhsXbqlCaWY1NUUVSR4UA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=NOPP9vk5; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=RyAadvNI; arc=none smtp.client-ip=202.12.124.153
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="NOPP9vk5";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="RyAadvNI"
Received: from phl-compute-03.internal (phl-compute-03.internal [10.202.2.43])
	by mailfhigh.stl.internal (Postfix) with ESMTP id A6AAC7A0052;
	Tue, 19 May 2026 05:51:56 -0400 (EDT)
Received: from phl-frontend-03 ([10.202.2.162])
  by phl-compute-03.internal (MEProxy); Tue, 19 May 2026 05:51:56 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1779184316; x=1779270716; bh=rkRYOpuKrZ
	o8RwPCnibTQJGJfomgBoEfWmXJZNtWELI=; b=NOPP9vk5S31+hXqnigBu69vrkV
	LxiY8fI5ZWFDp8IW/fPT2nmRXhKYCrj1zC7fJMFNrtE7GMtWFQ3UF3sUsbUkf05o
	KZU+Gqf8aeKXhIxv70bo+37QxOlkjfhZtkfLWO0oKDWBJU7gkF/bhAzsOjoaO2iQ
	sPCtO5m/IrHle7ZeVQneVgMPILeN8i7QY4uQhS56Z2h3SM8i13UpXa4iR06//wnP
	kX3Ko4ctFbRpOzAO9Gamrwlb/D0+Lttqok1QyDOPbp/7T4Bokh28JfmIaXgc3w/7
	oHxMfLm46imhy0ZljL13viZRXWFj1x2nLo7pNC/VURrIOuq1OUl6SoLRVlrg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
	1779184316; x=1779270716; bh=rkRYOpuKrZo8RwPCnibTQJGJfomgBoEfWmX
	JZNtWELI=; b=RyAadvNIahTyi883/sOR2WM5BPvV+E+16mRPxpE56r1x4Y528EO
	Sv0hImxnkKpaNEbVflxAkEaVqh9cF4kF8E0xjTTcCmpBB8y9j8P5J/gIDwoAi2VD
	uwORiRTCEWl/PIHxErdBPeLL1wIl0kDBVNEmFaIFHZTHiuGkLp49CaCfvdpRXYN1
	BJw61hVjJx4imTz4V1+Uxzqe9ATLNr8wP22HNX4MrdPjcplEfBr5f1IOVVZ0aXNH
	LKTydj+c4gxBO0OZt6iqzv26ZxF3pcF9kTfMlzJvZVbt4YsIGfRHJ4eWVTHpZ2Uk
	HXTjqRiXv0dlJdfFC5/2eJ0Taf9quIpogaw==
X-ME-Sender: <xms:vDIMaugt_IPRKZhQkqMdDqJF8GCh_GVBroZiXjOsST77wnwL9K5lWw>
    <xme:vDIMal7iqmBUPyPXwVyVlGhDmF5-tcC_pnUsLuBrnhrxlMcCGEuipxvlQ6WzEabjw
    nPrIxXOEiUEguq9hfdG20jf_WFal4ADHKZyiaryPeI7G-KgE5MVpw>
X-ME-Received: <xmr:vDIMauZo3YX6KORLCB0koi5dbgX5fctaI4IzD987vY2vkMyy-MMmrhVDYMDaWwUjuGDoiovk2aY7ZVKVBwiENmpZ_2pH3ezx_afN3zjFXSk>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefhedrtddtgddugedugeegucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhepfffhvfevuffkfhggtggujgesthdtredttddtvdenucfhrhhomheprfgrthhrihgt
    khcuufhtvghinhhhrghrughtuceophhssehpkhhsrdhimheqnecuggftrfgrthhtvghrnh
    epveekkeffhfeitdeludeigfejtdetvdelvdduhefgueegudfghfeukefhjedvkedtnecu
    vehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepphhssehpkh
    hsrdhimhdpnhgspghrtghpthhtohephedpmhhouggvpehsmhhtphhouhhtpdhrtghpthht
    ohepghhithhsthgvrhesphhosghogidrtghomhdprhgtphhtthhopegtrghtsehmrghloh
    hnrdguvghvpdhrtghpthhtohepnhgvfihrvghnsehgmhgrihhlrdgtohhmpdhrtghpthht
    ohepghhithesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopehkrghrthhhih
    hkrddukeeksehgmhgrihhlrdgtohhm
X-ME-Proxy: <xmx:vDIMai54LZmwScMp9u4F6MVvggydA1H2MSGB-ovpN4GMgfJSlsqC4Q>
    <xmx:vDIMapA80_VQLq_trkzKt4k3SDWYDTZwAImd2o4VwpduBjhk2TmbrA>
    <xmx:vDIMageDFizQ8dl420r42LR5ifGbPDqRGY1_Otvzsy0Lr1d9ubBX9g>
    <xmx:vDIMagJc-zG5bmwhM2ONnHJ01B8WxDFOBDRapo8NID9LS8B9znHeZA>
    <xmx:vDIMatIni_t0y5Qq-6C6ZRBlZkGUz8HaiC52E4t_CRFFOx0JtIqmOh6u>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 19 May 2026 05:51:55 -0400 (EDT)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id f97afa15 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Tue, 19 May 2026 09:51:54 +0000 (UTC)
Date: Tue, 19 May 2026 11:51:51 +0200
From: Patrick Steinhardt <ps@pks.im>
To: Karthik Nayak <karthik.188@gmail.com>
Cc: git@vger.kernel.org, Elijah Newren <newren@gmail.com>,
	Junio C Hamano <gitster@pobox.com>, Tian Yuchen <cat@malon.dev>
Subject: Re: [PATCH v2 00/18] setup: drop uses of `the_repository`
Message-ID: <agwytzUXxa6zIBHV@pks.im>
References: <20260420-pks-setup-wo-the-repository-v1-0-f4a81c4988e8@pks.im>
 <20260518-pks-setup-wo-the-repository-v2-0-6933c0f1d568@pks.im>
 <CAOLa=ZSxhtorR+t-4M_COxfu6HwpcB0hr43OhqcwgkU+VLX6qQ@mail.gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAOLa=ZSxhtorR+t-4M_COxfu6HwpcB0hr43OhqcwgkU+VLX6qQ@mail.gmail.com>

On Tue, May 19, 2026 at 02:26:35AM -0700, Karthik Nayak wrote:
> Patrick Steinhardt <ps@pks.im> writes:
> 
> > Hi,
> >
> > I've had enough of "setup.c" and its complexities, so I finally decided
> > to take the bullet and start refactoring this subsystem. This here is
> > the first out of the following three steps:
> >
> >   1. Drop all uses of `the_repository`. This doesn't yet allow us to get
> >      rid of `USE_THE_REPOSITORY_VARIABLE`.
> >
> >   2. Convert a couple of global variables and drop
> >      `is_bare_repository_cfg`, which then allows us to drop
> >      `USE_THE_REPOSITORY_VARIABLE`.
> >
> >   3. Refactor the subsystem a bit so that we stop intermixing repository
> >      discovery and repository initialization. This is my original
> >      motivation as I want to get rid of `odb_prepare_alternates()`, but
> >      due to the way we initialize the repository it has proven to be
> >      extremely tedious.
> >
> > Most of the patches in this series here are rather mechanical. There's
> > only a handful of patches that warrant more attention:
> >
> >   -  2/18: setup: stop using `the_repository` in `is_inside_worktree()`
> >   -  3/18: setup: stop using `the_repository` in `is_inside_git_dir()`
> >   -  9/18: setup: stop using `the_repository` in `setup_work_tree()`
> >   - 10/18: setup: stop using `the_repository` in `set_git_work_tree()`
> >
> 
> I think the series looks to be in a good state, I left some small nits,
> feel free to ignore.

I'll send one more round to address your feedback. Thanks!

Patrick
