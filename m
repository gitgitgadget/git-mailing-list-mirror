Received: from fout-a6-smtp.messagingengine.com (fout-a6-smtp.messagingengine.com [103.168.172.149])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A44FF2C190
	for <git@vger.kernel.org>; Mon, 31 Mar 2025 07:48:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.149
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743407282; cv=none; b=HhkzuXaIGeqz9PVaH0yBPKstwnMzHojjKGpo3UAu37p4wZWTAUo8/8mXvamVLu11yR9AvtLpOTSohQnjlWGiCvYI3gpi0ZkGsTLmhTH+0Hn1PgPNQtSRB8e2LCSMmBXNRDMy3f7MUuX+HNXHWYtA+tdS4I/jwxFCVKAgznJ78dE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743407282; c=relaxed/simple;
	bh=CVcQ1QqQauo3wm+gzxqOf00Tv3dBSg/LLhA3VC1JWIw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=tXCzsO0VvQbeVcvz6vDKkDGs/fbxv22QHx/I/L05YgGmJDgBeu4SJng24LFTDfDNpPEBGMYAYPLBcAxlWgA8AVZ4AbvcAO79C4QrUxtqPzicdklYX5ReTJ8YUTm/TcisqOkOM8M/MV/3J/r+2uJBVBsBTSUSyMLjwzB0DdCSxGQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=PlbeBmvX; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=Dan6pllV; arc=none smtp.client-ip=103.168.172.149
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="PlbeBmvX";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="Dan6pllV"
Received: from phl-compute-11.internal (phl-compute-11.phl.internal [10.202.2.51])
	by mailfout.phl.internal (Postfix) with ESMTP id C4E3813842AD;
	Mon, 31 Mar 2025 03:47:59 -0400 (EDT)
Received: from phl-mailfrontend-02 ([10.202.2.163])
  by phl-compute-11.internal (MEProxy); Mon, 31 Mar 2025 03:47:59 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1743407279; x=1743493679; bh=pe1wjD1yQm
	HmbqaX7q7ixuz/lH4ZtfB6T0XxzlF9Ic4=; b=PlbeBmvXwJn83xJOkbQo6P7yJZ
	K5EP5AuUIhmZPORvMXWsVo6Na5p5tz1iLB/I7EHIpwSfz9FUV9oDAgBzlGgOXkvm
	6CZ48c/DbeNqYwO9Eju8Ii7pZzFGgm6GLwgpe4pK7NW6FkAH/v50QpdMNLfX2esI
	lqOoEGkzsAKBNeAue0AokDN1pjAVB3ImHel/SxWc6tgK3cvoN9DvPyCgtOtf5p60
	dghCHHb0AuNL+18Xc2m7FlXxKI96W+Srl/t9HnP8xTrIX/Rx2uCI7UFTQ1Qfoxrf
	DsfYtjSwEbtQx2rDkZywKoP+bZ+Zz0s/TzK0W85E2IcgGxB3iqWvrL2YtNmQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=
	1743407279; x=1743493679; bh=pe1wjD1yQmHmbqaX7q7ixuz/lH4ZtfB6T0X
	xzlF9Ic4=; b=Dan6pllVXISCEeKsM48JBy9I894zbj/78Y4p5EiDA9puc432pt7
	CllGtQLCgEsGt46u7bZHhI2ku/w0phRd3ESd5qU24cFbw6hNOPvzl5rmvf49mv+G
	4gsCFOoxyNJtxYKl5chC0sLIWWb6q58nxb58dIhjRI4caXEPnFriKUTzGqLcj9lM
	lfB8/c5TYkxVHq+1T98cE7qvgzKyxJJuNhTJ7jGfz/2hzlm5WOMd97anSdOYaZ6D
	w0fha+C6D9QAbPUAJQ8q52hmx2yzWeHaC4y2Ci+p+BcsU0UTm6ngIDZ6OXTotbjn
	z+UCqTiNjicVia4PZbcRiSMh+YoicpgZogQ==
X-ME-Sender: <xms:r0jqZwNnQgFPxZ60gsqzH-XXSomwNKDQMS-uHGpWXU3dLZK1vqRlJw>
    <xme:r0jqZ2-qjAoq3B0Kigz1sZ27c17mvupTdWZ53n7Czscs_oDcKaJiuErgQh-f6wTdo
    a-S1Cr0XUBjBbxp7A>
X-ME-Received: <xmr:r0jqZ3SjuDY4gxDSijFZlvsqfAHu-yYL3dM6_aq_jp_evyQymhKMtzkM8AK0B2VYrWvAuqS_ohK-_LPE0W69MUfJdheie7e8ifajjFju-Sesw4eq>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgddujeelfeeiucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggv
    pdfurfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpih
    gvnhhtshculddquddttddmnecujfgurhepfffhvfevuffkfhggtggujgesthdtredttddt
    vdenucfhrhhomheprfgrthhrihgtkhcuufhtvghinhhhrghrughtuceophhssehpkhhsrd
    himheqnecuggftrfgrthhtvghrnhepveekkeffhfeitdeludeigfejtdetvdelvdduhefg
    ueegudfghfeukefhjedvkedtnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpe
    hmrghilhhfrhhomhepphhssehpkhhsrdhimhdpnhgspghrtghpthhtohepvddpmhhouggv
    pehsmhhtphhouhhtpdhrtghpthhtohepghhithesvhhgvghrrdhkvghrnhgvlhdrohhrgh
    dprhgtphhtthhopegrshhhphhilhhkihhnsehgmhgrihhlrdgtohhm
X-ME-Proxy: <xmx:r0jqZ4s8S7tEJY48WaDSY_8AZ75zuMQaNFtLUldKxOeOsnrUDCYOgw>
    <xmx:r0jqZ4dt1e1EWiD-USFt13YcwCxLfsTq1vQrRwQ7AQo0dff9xLJLlw>
    <xmx:r0jqZ82IoY9E9wYpg2ZV7P_OQLQaA5LwKLbIUuSNpj81nLJXphJAlQ>
    <xmx:r0jqZ8_-SJ5ImL1dBnhGv3k7-ylTD0osG1cjT0OLufon75LzQMf9Lw>
    <xmx:r0jqZ5oE2KHeWSxkrvoAYGxFk30GVDY_3lc14zH9v2OPt1OZ96HW8MJS>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 31 Mar 2025 03:47:58 -0400 (EDT)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id 5a3023b4 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Mon, 31 Mar 2025 07:47:57 +0000 (UTC)
Date: Mon, 31 Mar 2025 09:47:56 +0200
From: Patrick Steinhardt <ps@pks.im>
To: Alexander Shpilkin <ashpilkin@gmail.com>
Cc: git@vger.kernel.org
Subject: Re: A cross between 'git stash create' and 'git stash push
 --include-untracked'?
Message-ID: <Z-pIrCp6ZewWuPI0@pks.im>
References: <d8f596cfac9b001350b8b5e408067bb4caa073a7.camel@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <d8f596cfac9b001350b8b5e408067bb4caa073a7.camel@gmail.com>

On Sun, Mar 30, 2025 at 05:37:42PM +0300, Alexander Shpilkin wrote:
> Hi,
> 
> I'm trying to write a script for my use that would run before every
> invocation of 'make' and record the working tree state at that point. 
> Stripping out the boring parts, it is basically just
> 
>     git update-ref --create-reflog refs/build $(git stash create)
> 
> but the problem is that what I want is less like 'git stash create' and
> more like 'git stash create --include-untracked', in case there are any
> new and as yet untracked source files that are nevertheless picked up
> by the build system.
> 
> Of course, that does not exist and, because of the syntax of 'git stash
> create', cannot exist.  I've looked at the code in builtin/stash.c and
> it looks like there are only two callers of do_create_stash(): one is
> create_stash() and hardcodes the include_untracked argument to zero,
> the other is do_push_stash() and (assuming I try to undo its effects
> with 'git stash pop' afterwards) will potentially destroy my working
> tree's mtimes and cause more rebuilding than necessary.  So it seems
> like I'm stuck here.

Indeed.

> Any suggestions?

I guess the obvious answer here is to extend `git stash create` so that
it knows to handle "--include-untracked".

Unfortunately, it wouldn't be quite as simple as just wiring up the
command line option and passing the flag to `do_create_stash()` because
`save_untracked_files()` saves untracked files by modifying the
repository's index. Consequentially, we would still end up modifying the
repository, even though the checked out files would ultimately remain
unmodified.

I think we'd have to teach `save_untracked_files()` to do the changes on
an in-memory index instead of invoking git-update-index(1). And if it
knew to do that we could easily wire it up for `git stash create` and
thus implement your usecase.

I won't be working on this myself as I'm short on time, but I assume
that patches would very much be welcome.

Thanks!

Patrick
