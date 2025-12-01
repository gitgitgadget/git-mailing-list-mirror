Received: from fout-a5-smtp.messagingengine.com (fout-a5-smtp.messagingengine.com [103.168.172.148])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 128DB2D3EF2
	for <git@vger.kernel.org>; Mon,  1 Dec 2025 07:58:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.148
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764575930; cv=none; b=kKoTkHgVvlhvZL9RvjVZeDdhl0MvA0zOk7Ap77UD2v1bc8sIoOk/Xf5I4tkIMqX4LjyHCfG8pCyxrFTCdUZKcJR42O99FsbYICmVz4A3oEUtvdM5Ot7esJIREMYlUJU+MduywAhbFS5ateJ/E72wz6DBxVXryezA6M8FHJpfI3E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764575930; c=relaxed/simple;
	bh=pnCV2WqPhRVyL9nV7NMGgoz4Lzgv4HCdIWwwXO9OLGs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=HolOrq5amy102gqQuz8VubBSqU1mkV8v6gaBfXQ8oW4AfH4z0GnEh2DKkly/LZx0n/W4OTSsEV1HJoo523eEp5zh9kpPkVeMrPZD14ToEAVr0cexfQfcG//8rBfGHK1TclkBcsRCUbYXGQ1qjTVSj0TzcVP51RpMxil6aYMlRu0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=k6DUvuPz; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=OlY6Dhce; arc=none smtp.client-ip=103.168.172.148
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="k6DUvuPz";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="OlY6Dhce"
Received: from phl-compute-05.internal (phl-compute-05.internal [10.202.2.45])
	by mailfout.phl.internal (Postfix) with ESMTP id E6DECEC0867;
	Mon,  1 Dec 2025 02:58:46 -0500 (EST)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-05.internal (MEProxy); Mon, 01 Dec 2025 02:58:46 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1764575926; x=1764662326; bh=k8lYNrjzWX
	zEWUksDJWEH59FEaUmTI1UG1dvI2ioRl8=; b=k6DUvuPzPeydIhP94NuA+Vd/Pp
	7P9u+/n9P9WNRHM3L+aa9Zr1xEVtcRQfzEgoq/LyEj9DTvNYZMxB0g89vKsGQXXS
	e2SRchSVg4krXhuHHxsffjBpcFRBeeuoquO4LetCJuaGIuLB9XUPTQXt0gy6ljrB
	ob7LRdqVia76WLLBpHde7QJIsijiHwXh4Z4d1zLAH7RVhBz21Qy3PgRXjJJGendb
	rYEj5ic7bMmD03p0q9zY/tAYgorpXWiBFLUXUofto81nZ3owjSmexPPnD37pltl2
	ycPWludeq2ctpbUQsF2uKDSjh3vS+ZAnPJ0rU8UL41/N3toNNv25JWnse1tQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
	1764575926; x=1764662326; bh=k8lYNrjzWXzEWUksDJWEH59FEaUmTI1UG1d
	vI2ioRl8=; b=OlY6DhceuqZGHNj9/qYaWISWgEnaJOBEmaT49blD84sZ+PQo2XV
	0UzmmhPCPrIN55GzTH0dZZja2BUbDHg4+sAZq6QHM5ueYaIB0cy9B3J1hb8o11D6
	l1SCX7ftMjSEkBsXEdBdEgiAW3bRWU5Pw5Rmoj91CHX+YgUsii/u+0NSoiag8ny5
	CM22K79QQLYMo0zndX7uzxYERg61IbMijjAqSIMEFsRCR8amC3u2O7ab/JQdFwBC
	jphjgUWh8achdiH4WjYohY9Dd4a8z+pv3Yv+bfPg9bLw04xZnZMwok2qTkpXf3lz
	T7NXKZy2jPCI7i4ZjUf8kU+80er0HKqzFBQ==
X-ME-Sender: <xms:tkotaeA2hTyRKv_LN2pseDxWzjHUys3JyY76apTO-mGWGk5jCL8XVQ>
    <xme:tkotafhdtK31MxXc1eEmXWulLmzNoTQoq98R3KQVke9ODtNgnfzjK4lUSfqlMah69
    l13XmtW7ZQ3dOw0gqIQhegvkZCRkYD6aJya-8pGnmvYN273oTBgzw>
X-ME-Received: <xmr:tkotaWngwiCymuQffcB-2wfTqmb8IklbNOGvfRZkkDEOhv-TGiEGZw5fQT4CVIQ6VKYl3F_aEQjs8Nr7l-ny0JlcMRCCp1iP-bdWUky1>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdeggddvheejudejucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhepfffhvfevuffkfhggtggujgesthdtredttddtvdenucfhrhhomheprfgrthhrihgt
    khcuufhtvghinhhhrghrughtuceophhssehpkhhsrdhimheqnecuggftrfgrthhtvghrnh
    epveekkeffhfeitdeludeigfejtdetvdelvdduhefgueegudfghfeukefhjedvkedtnecu
    vehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepphhssehpkh
    hsrdhimhdpnhgspghrtghpthhtohepgedpmhhouggvpehsmhhtphhouhhtpdhrtghpthht
    ohepghhithesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopehgihhtshhtvg
    hrsehpohgsohigrdgtohhmpdhrtghpthhtohepghhithhgihhtghgrughgvghtsehgmhgr
    ihhlrdgtohhmpdhrtghpthhtohepjhhohhgrnhhnvghsrdhstghhihhnuggvlhhinhesgh
    hmgidruggv
X-ME-Proxy: <xmx:tkotabrwg9BnMXwauh5I1FIMARvHzgmbaL5TGuJZoZiMQggZ6kW_eg>
    <xmx:tkotafHQLTeLRlpBp1iFNy81ZKQUtQJiGJhAR997d9PrHtSnkVvwuQ>
    <xmx:tkotaXzK_JIi7HrWpzFPapYYp0pyEJPljURDBQ9ykaoWP1C0BIP62g>
    <xmx:tkotaUqyyG2-8eajSP2Rz1NQOQ7VUmd89539cbbHfQKgzyFMRqScQQ>
    <xmx:tkotab-YZ9qjplmv7AikYk2NwikuvEvPx0JIOReczukXn5t2QgqvYPdt>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 1 Dec 2025 02:58:45 -0500 (EST)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id 9148da52 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Mon, 1 Dec 2025 07:58:43 +0000 (UTC)
Date: Mon, 1 Dec 2025 08:58:34 +0100
From: Patrick Steinhardt <ps@pks.im>
To: Junio C Hamano <gitster@pobox.com>
Cc: Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Johannes Schindelin via GitGitGadget <gitgitgadget@gmail.com>,
	git@vger.kernel.org
Subject: Re: [PATCH] make strip: include `scalar`
Message-ID: <aS1KqrTRxHSGDDZY@pks.im>
References: <pull.2004.git.1763409086322.gitgitgadget@gmail.com>
 <xmqq7bvoiadg.fsf@gitster.g>
 <235775ef-d12f-4b19-0b80-672c4e5e1812@gmx.de>
 <xmqq4iqhraem.fsf@gitster.g>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <xmqq4iqhraem.fsf@gitster.g>

On Tue, Nov 25, 2025 at 02:54:09PM -0800, Junio C Hamano wrote:
> Johannes Schindelin <Johannes.Schindelin@gmx.de> writes:
> 
> >> > -strip: $(PROGRAMS) git$X
> >> > +strip: $(PROGRAMS) git$X scalar$X
> >> >  	$(STRIP) $(STRIP_OPTS) $^
> >> 
> >> I wonder why the original names git$X here explicitly, instead of
> >> using say $(OTHER_PROGRAMS) that covers both of these.  I know that
> >> the undocumented INCLUDE_DLLS_IN_ARTIFACTS knob uses OTHER_PROGRAMS
> >> by throwing in non-programs like DLLs to it, so that artifacts-tar
> >> target would include them, but perhaps instead of working around the
> >> misdesign of that target, wouldn't it be better to correct its use
> >> of OTHER_PROGRAMS and use it here instead?
> >> 
> >> The change (including the "strip scalar, too!" part) should look
> >> like this, I think.
> >
> > Sure.
> >
> >> Also do we need a matching change to CMake and meson?
> >
> > I am unfamiliar with Meson, and do not see anything about stripping in
> > `meson.build` apart from a `--strip` option that is mentioned in a comment
> > (and which I would assume already handles all executables, otherwise the
> > move to Meson really is not worth all the hassle).
> 
> That's a great point.
> 
> Anyway, the original patch that started this thread is not wrong, so
> let me queue it as-is.  Those who want to improve on it can build on
> top.

Yup, Dscho is exactly right. Meson handles stripping natively via the
`--strip` option that you can pass at setup time. If so, it knows to
strip all binaries when installing.

So there's nothing we need to do for Meson, thanks!

Patrick
