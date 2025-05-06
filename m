Received: from fout-a1-smtp.messagingengine.com (fout-a1-smtp.messagingengine.com [103.168.172.144])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1E9C32459D8
	for <git@vger.kernel.org>; Tue,  6 May 2025 10:39:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.144
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746527980; cv=none; b=GxEZTj+2c1bG/kdbkIQEaB/J8JmzNyxcK1Kl/Al4i81zNBM3raRPg2fVz5GKWGLFQPzZsb3wcGHw6xoJUdKG9omc7JkyjZ2uu853Nor0I53MUoHMsEoQzhLBu1PpCozkx/4QCTbpKzVhwE2OpQOC1dWAOYCPOaoxTl4maG7Ekng=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746527980; c=relaxed/simple;
	bh=g8ph5BUgjHPW1f5JEq9ahBk1CvzNg7uAJeO2XM3/Tv0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=FX20yMeZ3j+Dx8uTKdxqAdUstcsJZGgBWOzaRjzs5TRV69P4QN+lWINX86Ll06+ma7XkmA8lQ3LhmbwUxZURyaYQ+VK8WPdBAuc6iv+nQ2CDfpP9OZEcBMI8CLVNvsxQLH0y97bj7z9JeCtw49tclmItCr1/6jk1bp5DQwN59M0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=xeZSj+a8; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=MoshGhem; arc=none smtp.client-ip=103.168.172.144
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="xeZSj+a8";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="MoshGhem"
Received: from phl-compute-05.internal (phl-compute-05.phl.internal [10.202.2.45])
	by mailfout.phl.internal (Postfix) with ESMTP id 2D5541380227;
	Tue,  6 May 2025 06:39:37 -0400 (EDT)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-05.internal (MEProxy); Tue, 06 May 2025 06:39:37 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1746527977; x=1746614377; bh=qX9XIdLQ2f
	lsxiHAKiieY9qchXnde0njNN2y3i6kzsU=; b=xeZSj+a8jsJycitDohNGP0Pft/
	2R3gsbRRZnef5eWiWC/0SWuP8zQZC950COXQgxA1MYfx0LXbO5o0dVVl+Ny679+b
	qDRt5phWPX5OY07slGrO95S4tighmiNq1+1yR0wIh52d8kuIFjnIJyIHub8mpufA
	B2n7vss5aEzyE5cXF6a8Shbbf0cDaZ1+7sswwmPye7P6RCkavLdJxMvGy6LB/yyY
	Pn8+vgM1tf67Z/ktuVTTgvzojEORqL0hoq1WYzsO30K9DMaQ/5c2OOm6csE6bb8j
	tidJFioIO0K3aNFSUVgkYo+eKRZh1RPsSzwVubW9A6yNPhNPcGbmL6eF3t9A==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
	1746527977; x=1746614377; bh=qX9XIdLQ2flsxiHAKiieY9qchXnde0njNN2
	y3i6kzsU=; b=MoshGhemGD9OIjoCfySKpdwgaa7qBCCpnNkbboypUAkHrecg9zL
	eXGsEtdvgcl59yd+lEwQJMdCw+29f+rW5l0PEW9R2MuVlDlWzqgLGWlD3m03FKwX
	9nUCVTk+Gr4va9ZVQhNrfUCR2BQIDc7exfk0GER2Jq9PGjFjKvz3hxLO4qbihaLs
	ViRpDYYQ6PYUydlRG3unHyrj/RSzbR2adjauyiUOauw9eB6Snes90ww1oq3cSs5f
	QEbIBBSTz2Gmp/aNXL9O+3YdEZYiCoS53prk3/APCWAHbmvPOYpc7b6Y2k4j6ftg
	5E1BqE6MiQtIk2WtBeXC5lw2Ywp6H3kWgdw==
X-ME-Sender: <xms:6OYZaO5gx-rYenfb5UCRN_UcM6DSdgSKJlExPvdHyuoG1PG32z_6sw>
    <xme:6OYZaH41WB8RPbHWFfzqRLUgipElz9H2xK_tEX0uE57Lo6IToNqVqnc5_FFeGE8Eg
    XDPihMhHqCAIXCNJw>
X-ME-Received: <xmr:6OYZaNdSJiTB2SCKcDB0lvRw5BNfu1Oe1jGAnD8WvAR2JwbWuulaqBi9iTQbv62kpaNsmDTFegPH3T-CmBqKYCBku0aA_ItTFtJIWprE>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgddvkeefjeeiucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggv
    pdfurfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpih
    gvnhhtshculddquddttddmnecujfgurhepfffhvfevuffkfhggtggujgesthdtredttddt
    vdenucfhrhhomheprfgrthhrihgtkhcuufhtvghinhhhrghrughtuceophhssehpkhhsrd
    himheqnecuggftrfgrthhtvghrnhepveekkeffhfeitdeludeigfejtdetvdelvdduhefg
    ueegudfghfeukefhjedvkedtnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpe
    hmrghilhhfrhhomhepphhssehpkhhsrdhimhdpnhgspghrtghpthhtohepfedpmhhouggv
    pehsmhhtphhouhhtpdhrtghpthhtohepjhhohhgrnhhnvghsrdhstghhihhnuggvlhhinh
    esghhmgidruggvpdhrtghpthhtohepghhithesvhhgvghrrdhkvghrnhgvlhdrohhrghdp
    rhgtphhtthhopehgihhtshhtvghrsehpohgsohigrdgtohhm
X-ME-Proxy: <xmx:6OYZaLLb1eeb34y_ZegLgAvww3KQ-s37dzqQnGVZrrsV8tmxwT3f2A>
    <xmx:6OYZaCI7zPmDJFo3AW6eic26MSif7i29fmeZggDmK0LlWh5zl1x5xA>
    <xmx:6OYZaMxVVFnmp1i34AN1pOTozMIADPKFlaqlxc_9YiolVJyuuaX3ig>
    <xmx:6OYZaGJhq0DGPWctqwO5tHtLy3r1T3lYFSYWN3XZuO4RkB0ioqb1Dw>
    <xmx:6eYZaIaISEIU0F0At3-D451JCAS4QuQSlprj1R_7ULyTJ6kFN4U2suEs>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 6 May 2025 06:39:36 -0400 (EDT)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id d7a0fc30 (TLSv1.3:TLS_CHACHA20_POLY1305_SHA256:256:NO);
	Tue, 6 May 2025 10:39:34 +0000 (UTC)
Date: Tue, 6 May 2025 12:39:29 +0200
From: Patrick Steinhardt <ps@pks.im>
To: Junio C Hamano <gitster@pobox.com>
Cc: Johannes Schindelin <Johannes.Schindelin@gmx.de>, git@vger.kernel.org
Subject: Re: [PATCH] gitlab-ci: always run MSVC-based Meson job
Message-ID: <aBnm4fP1RYgoIEc4@pks.im>
References: <20250428-pks-gitlab-ci-execute-win-meson-v1-1-f68683552b9e@pks.im>
 <56a0f8fd-7568-b579-1ff3-e0b088b53345@gmx.de>
 <xmqqv7qoceiv.fsf@gitster.g>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <xmqqv7qoceiv.fsf@gitster.g>

On Mon, Apr 28, 2025 at 11:44:08AM -0700, Junio C Hamano wrote:
> Johannes Schindelin <Johannes.Schindelin@gmx.de> writes:
> 
> > .... From my
> > point of view, Git is spending way more compute than is warranted. The way
> > Git's CI builds are set up, in many cases a single regression will cause
> > many tests/jobs to fail, and that indicates to me that Git's CI definition
> > (and even Git's test suite) contains too many redundant parts.
> 
> While I also feel frustrated by watching paint dry after pushing
> day's integration results out, and often seeing that multiple CI
> jobs fail due to the same breakage in 'seen' I do feel if there are
> ways to avoid such waste, I do not think of a good way to do so [*].
> Are there some concrete proposals?

We could probably combine at least some CI jobs. The "pedantic" Fedora
job for example feels rather weird because it just builds without
testing anything. It could be merged into one of the other jobs by
executing tests on Fedora instead, with pedantic compiler flags. But
other than that I don't really have any other good ideas.

> [Footnote]
> 
>  * For example, if gitlab-ci and github-ci run the same CI jobs on
>    the same exact revision of Git using the same exact docker image,
>    if there is no reason to expect one to succeed and one to fail,
>    perhaps we can drop one and keep the other? 

At GitLab we will definitely want to have a full pipeline for Git given
that we use a merge request-based workflow all the time. So if parts of
the GitLab CI went away, we would have to handroll it again and backfill
any jobs that went missing to enable our own workflow.

While it's inefficient to have the same pipeline effectively run twice,
this is the kind of behaviour you get in a distributed system, I guess.

>    Or perhaps we pick a
>    single representative job and only after it passes start other
>    jobs?  None of the tweaks along these lines I can think of feel
>    satisfying to me.

Wouldn't that only mean that the pipeline takes even longer from start
to finish? Even if the representative job succeeds it doesn't tell me
anything about whether there are leaks, or whether it works on Windows,
or on macOS. But given that I am on Linux, I especially care about jobs
that use a platform different than my own and always wait for them to
finish before sending out a patch series to the mailing list.

Patrick
