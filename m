Received: from fhigh-a5-smtp.messagingengine.com (fhigh-a5-smtp.messagingengine.com [103.168.172.156])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DB7562FB2
	for <git@vger.kernel.org>; Mon, 28 Apr 2025 07:47:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.156
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745826467; cv=none; b=eR47avgXCFB2DazbIZD5hvdR/1FXJcdT6m9WdLCpylzbo+WyMn78RTSisZsvYROcADflLTfW6wbEJzuaVOBgnh6v85ukbGH9/qJ91FLg8AbwuUKmk1/cVjSwShAUY0o1WVh7h9lpjYjV9BvoCp0nkxxKva6e42Dfw2RgNdFMv7E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745826467; c=relaxed/simple;
	bh=iae+jTNmOiJQCkUcjHKWN+oxAdkL633BgC0DgG+dd2E=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=cWb7XFavNgs/BM1ZdBI3Bt4rJmUr46rBNBhyjmolAnD8Q5sITY4itzpf1e9m0HB3CwU9hnhQ/CGwuw+9MJTXLdwOUL6zUJn/DqOFwEpZ+HUxfMKZdFGc3gs8EcwgnyAkj/fCCy1NaDBCkT71ae2mwLEvCpqR4IrNNv9LAtGsFcQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=jY/gV7r5; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=H0EJLmnj; arc=none smtp.client-ip=103.168.172.156
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="jY/gV7r5";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="H0EJLmnj"
Received: from phl-compute-01.internal (phl-compute-01.phl.internal [10.202.2.41])
	by mailfhigh.phl.internal (Postfix) with ESMTP id C75991140122;
	Mon, 28 Apr 2025 03:47:44 -0400 (EDT)
Received: from phl-mailfrontend-02 ([10.202.2.163])
  by phl-compute-01.internal (MEProxy); Mon, 28 Apr 2025 03:47:44 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1745826464; x=1745912864; bh=/wELDcScGt
	EISTAAOaaWN/whTwCZay136Ww4kqzPN4w=; b=jY/gV7r5ImHYmVdxoDGkt0yvY9
	UE3XlN7B+2viKoTdfjFf9gLbQyvK5lMAEyibNZ6pkJsBzquwpFl4u1PmktNIFtJL
	g1rxE31ehXqBDWKtuWOoUU6gZ9UnXzLl6QVsvHMgG++QnidQxOwAm4uB1ymfzkaq
	HS0v0hwxWtuJSj2c0YdlkgG3hULI+5tg8m4OlIgsFBAhsF1zkk0s2StDS27GPBRK
	UKLip69BMJwE5zYBTg/aS4XjwqKA7+bi0G6JvU3/OV/hYUdS6lyL50G5s7nWxi+W
	9/srEdsk8lIfsW1B4wwy/SRUHGR0Veb3QEq2BSd7yVw/H0Qdc0ydoNcIJCAw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
	1745826464; x=1745912864; bh=/wELDcScGtEISTAAOaaWN/whTwCZay136Ww
	4kqzPN4w=; b=H0EJLmnjr1yf6XbdI8K1O0FthsvjJE3xw3yYRrCz2QoCRWJq65h
	t0PNnutLlloxlp+siKpHI/rlL6l9hluBNLt/nppGFb1G/1tEM8pz3V7VCAaN9KvZ
	5F1WW5PeAvOYgjuy9Som6asXKXJpt89cF4l7EaDwdkA7iXEKtMc0gPx/J05IDLKy
	mAj55f7w+03wP6rCjgORwvh3MrD+QdACNk4RX+fO1DwdiwvN3tvbUh2QlAv4SgPl
	vz41hs4480vSEUFmHX6B2clP4Rm/zU+wWFsmZab7TaeQlZjoFryscQ8cOKF0oH0o
	OBLXw4GSa6Tp6dtIPFViHXLtLgCGzBGAByw==
X-ME-Sender: <xms:oDIPaDWs8ZPsWxLkaPbcZaukON39zUpT1r1hcAItmOyHRRYua4QCsA>
    <xme:oDIPaLkMcB3E4EjSskUOcVSowDBzu1RlBjPXjOpyNtxb2JjjxlCstgUgNI6Jabnnd
    p_dYJLWZktXVbOSAA>
X-ME-Received: <xmr:oDIPaPb4D1Szc0dH_u7X7iMhSNegMsOLLDB3ZP89dqPB8szf0zXQso6JikkdfyZhLmkw70JG8WRCPT6caIwReP6C6NypvYFaP1dRq-1Hy1rM>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgddviedtfeekucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggv
    pdfurfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpih
    gvnhhtshculddquddttddmnecujfgurhepfffhvfevuffkfhggtggujgesthdtredttddt
    vdenucfhrhhomheprfgrthhrihgtkhcuufhtvghinhhhrghrughtuceophhssehpkhhsrd
    himheqnecuggftrfgrthhtvghrnhepveekkeffhfeitdeludeigfejtdetvdelvdduhefg
    ueegudfghfeukefhjedvkedtnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpe
    hmrghilhhfrhhomhepphhssehpkhhsrdhimhdpnhgspghrtghpthhtohepgedpmhhouggv
    pehsmhhtphhouhhtpdhrtghpthhtohepghhithhgihhtghgrughgvghtsehgmhgrihhlrd
    gtohhmpdhrtghpthhtohepghhithhsthgvrhesphhosghogidrtghomhdprhgtphhtthho
    pehjohhhrghnnhgvshdrshgthhhinhguvghlihhnsehgmhigrdguvgdprhgtphhtthhope
    hgihhtsehvghgvrhdrkhgvrhhnvghlrdhorhhg
X-ME-Proxy: <xmx:oDIPaOVwJUBg1fuNow3dGPV-whKNUxc21U74yaHToptnBuEqfKnOiA>
    <xmx:oDIPaNmTvthZNSlDtr3Kp9EZAnqh5KbJ3vZ4S2yhFh_CcXtW2gh93Q>
    <xmx:oDIPaLeF7HzN-x0xi7mru22wbRXiediuHZKpBVbzJRrO8T_y2x9nUg>
    <xmx:oDIPaHHqKBrMJyNILigH-8vy9qyI2TRwnMqxsT8V8nt8Vf4zdpgdQw>
    <xmx:oDIPaBwDGmyhDc94F7sW1a2m_7HzWqMSWVGrTwky1nOw1K1Gk7-Qrt74>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 28 Apr 2025 03:47:43 -0400 (EDT)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id 932ebc51 (TLSv1.3:TLS_CHACHA20_POLY1305_SHA256:256:NO);
	Mon, 28 Apr 2025 07:47:41 +0000 (UTC)
Date: Mon, 28 Apr 2025 09:47:37 +0200
From: Patrick Steinhardt <ps@pks.im>
To: Junio C Hamano <gitster@pobox.com>
Cc: Johannes Schindelin via GitGitGadget <gitgitgadget@gmail.com>,
	git@vger.kernel.org,
	Johannes Schindelin <johannes.schindelin@gmx.de>
Subject: Re: [PATCH] ci(win+Meson): build in Release mode, avoiding t7001-mv
 hangs
Message-ID: <aA8ymUzWM2t0QkFP@pks.im>
References: <pull.1908.git.1745593515875.gitgitgadget@gmail.com>
 <xmqqmsc4uv6d.fsf@gitster.g>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <xmqqmsc4uv6d.fsf@gitster.g>

On Fri, Apr 25, 2025 at 08:18:02AM -0700, Junio C Hamano wrote:
> "Johannes Schindelin via GitGitGadget" <gitgitgadget@gmail.com>
> writes:
> 
> > From: Johannes Schindelin <johannes.schindelin@gmx.de>
> >
> > Since switching to `--vsenv`, the t7001-mv test consistently times out
> > after six hours in the CI builds on GitHub. This kind of waste is
> > inconsistent with my values.
> 
> With mine too and I would presume everybody else's.  I've been
> annoyed for a long time by one of those sharded Meson-Win test jobs
> that hang around until timeout.
> 
> Thank you very much for addressing the issue.

Indeed, thanks for fixing the issue! I haven't noticed these failing
jobs yet on my end, probably because on GitLab we only execute the
Win+Meson changes manually. Which is not great given that it makes me
miss issues with Meson like this.

I'll send a patch to run these tests by default so that I can see the
pain myself and address any issues that come up before others are forced
to.

> > The reason for this timeout is the test case 'nonsense mv triggers
> > assertion failure and partially updated index' in t7001-mv (which is
> > not even a regression test, but instead merely demonstrates a bug that
> > someone thought someone else should fix at some time). As the name
> > suggests, it triggers an assertion. The problem with this is that an
> > assertion on Windows, at least when run in Debug mode, will open a modal
> > dialog that patiently awaits some buttons to be clicked. Which never
> > happens in automated builds.
> 
> Interesting.
> 
> So another viable fix (no, I am not suggesting a counter-proposal,
> but asking a pure question to see if I understand the issue
> correctly) is to rewrite "assert(cond)" to "if (cond) BUG(...)"
> or something like that, so that it truly fails?

On the surface this sounds like a reasonable thing to do, but I don't
have enough context to be really able to tell.

> > diff --git a/.github/workflows/main.yml b/.github/workflows/main.yml
> > index 83ca8e4182b..275240be5dc 100644
> > --- a/.github/workflows/main.yml
> > +++ b/.github/workflows/main.yml
> > @@ -265,7 +265,7 @@ jobs:
> >        run: pip install meson ninja
> >      - name: Setup
> >        shell: pwsh
> > -      run: meson setup build --vsenv -Dperl=disabled -Dcredential_helpers=wincred
> > +      run: meson setup build --vsenv -Dbuildtype=release -Dperl=disabled -Dcredential_helpers=wincred
> >      - name: Compile
> >        shell: pwsh
> >        run: meson compile -C build

So I'm fine with this trivial change as a band aid for now. The diff
looks obviously good to me.

Patrick
