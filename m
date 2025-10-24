Received: from fout-b6-smtp.messagingengine.com (fout-b6-smtp.messagingengine.com [202.12.124.149])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F35E363CF
	for <git@vger.kernel.org>; Fri, 24 Oct 2025 05:45:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.149
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761284712; cv=none; b=GUYN0S6QKn3L1Aq0KieoBi+VWryRd6wzIFuNLTrcyySiQPA+SRmaJ+zpB1azYgmEShe/HLhjeFUFdHRciPxCXzh10VIzZ2YpVIAo7hiQkLFEnbstE7x7rUfZvQKU/eC6njOtKMTpQEz3BqyDtT/RrYRYxkrL/b/tIS8VdFWZsOc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761284712; c=relaxed/simple;
	bh=mGj1aKR9RUPUAhUPyD0amIsznU/vAZdfjR6AL2A7owI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=nn85+UmaaWpTuKNYm9vvqpI815NfS5jZGu3+R8g/oMwRxgHpOuL6XuS6QTl2gKirrdMp6XDKgeEhg4lIrIkJs1+qYQAQyaUakNGl4WxYxD5U+TtY+TpsZH5NJEdR0YxpdPDK8X3/5Dnwalwo/3zp+ObjvzFMu/bwmVh8dgxYHN0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=mVYnv8p2; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=H2uUwfoc; arc=none smtp.client-ip=202.12.124.149
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="mVYnv8p2";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="H2uUwfoc"
Received: from phl-compute-03.internal (phl-compute-03.internal [10.202.2.43])
	by mailfout.stl.internal (Postfix) with ESMTP id D9F461D000B0;
	Fri, 24 Oct 2025 01:45:08 -0400 (EDT)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-03.internal (MEProxy); Fri, 24 Oct 2025 01:45:08 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1761284708; x=1761371108; bh=Mq61svvJ6b
	uxgu743BQfJeUEauBthwxaBC0kvsAqneQ=; b=mVYnv8p2ZLFzvyEst7iv8uApPt
	k1UfWbZB4r62himNC+PMzNg4qkJjCOmKRF1+IeJPq2iZAhFlNi7s+ho7TYRMchV7
	YUdMU3mi4GVIBEKszVdjzwhOn+YkzIv/O13IR3QIcsmZ7SjrXvYffXD13hl8LESS
	TzW+S1RWWXJz+8CGXE45GmmNfbnSSK28nnYuZyAozREqbqRhHYFneCMC3QU64SUi
	z33nUW3cC9nqhwS/5/maIpC8RBPzJEcH/rPBWg1fRAlfCkGc6eL+uw5I5k2RhZT2
	3iaZlyDSOEuxB57NLpLUNq/H+26aLpkaeXWgZvXnN9JYs3jWQhq+QoTscdDw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=
	1761284708; x=1761371108; bh=Mq61svvJ6buxgu743BQfJeUEauBthwxaBC0
	kvsAqneQ=; b=H2uUwfoculEJpuNOThP3yKu1zki7Dmb0IbSR2P/K6ESphRaLM3C
	ceft37P0VGLVVrLaT2Z5tGGBy2Xv87aVBarYxVZK41ek6RShilx2yLXw2Jj4jpoz
	cbQV14WG8vvtIcoxdir6GF0WGv+YG8tasA6mzABxW2DIuCzKCBPPPyf0o1f0TyRt
	p07zNarhfc2aJfZbqnzVDR+etDw/NgsfivC6vlouUQ3DV3BEi/BjAlwxjgp0aNS/
	GWy62Ner0EK7huN+yK2uSAvZshrVsfz2fxqIUoCu3W3iBL0tEUCPsInyBxmYbj9p
	XOOq3lxnqt+RTm5MB3A5r0Qy7yzzgiBT1jw==
X-ME-Sender: <xms:ZBL7aMBrJ-ex3BUoVo7JDXP5pvrc6Yoyp8uHcF3gimXjJi0dMam2Kw>
    <xme:ZBL7aF9YaV2UGPvNREbshYJ1KNR1zPkWtZ7qAljGpdgCxW54Ins9jQBzT8FjlM9fj
    MSMWjTCmDnW2vv94boGOdk9y2Ck1WMD0xyNGKIIwMqDDGHn88xY>
X-ME-Received: <xmr:ZBL7aM8CUnmT3bg22hAlGfaEo-Fg3jaexCEubhdBowmrigepAt1R7Zurp0MmNjzXJAw3pHiilGqXrc5i0riSI-3PEXZ7DNZHZDq4STEGWQ>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdeggddugeekheefucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhepfffhvfevuffkfhggtggujgesthdtredttddtvdenucfhrhhomheprfgrthhrihgt
    khcuufhtvghinhhhrghrughtuceophhssehpkhhsrdhimheqnecuggftrfgrthhtvghrnh
    epveekkeffhfeitdeludeigfejtdetvdelvdduhefgueegudfghfeukefhjedvkedtnecu
    vehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepphhssehpkh
    hsrdhimhdpnhgspghrtghpthhtohepfedpmhhouggvpehsmhhtphhouhhtpdhrtghpthht
    ohepmhgvsehtthgrhihlohhrrhdrtghomhdprhgtphhtthhopehsthholhgvvgesghhmrg
    hilhdrtghomhdprhgtphhtthhopehgihhtsehvghgvrhdrkhgvrhhnvghlrdhorhhg
X-ME-Proxy: <xmx:ZBL7aMevD1jRIJV58zKKPbt1aI819_QU5xailBLv-1zLBYJs2LFv3w>
    <xmx:ZBL7aFEdcJ603VzZt6vTNYsL6h1nt-YrC11wLJqczbYnqobT5aAjXQ>
    <xmx:ZBL7aKfCUH_j8-Z6-ca3K-iaYSpHRHW-1dHapYmmX2bmtm7a0PBa3w>
    <xmx:ZBL7aPH0C3YbkvIbeSFiVN5BcfOd5me2WDePD5KhjQ5j8s0-F-rGRg>
    <xmx:ZBL7aPYUmRvZ4I2TbCaMir8OLfklKREG7vmvJT2RN61rc7uzGAxbXKEN>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 24 Oct 2025 01:45:07 -0400 (EDT)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id 4b66d4db (TLSv1.3:TLS_CHACHA20_POLY1305_SHA256:256:NO);
	Fri, 24 Oct 2025 05:45:06 +0000 (UTC)
Date: Fri, 24 Oct 2025 07:44:57 +0200
From: Patrick Steinhardt <ps@pks.im>
To: Taylor Blau <me@ttaylorr.com>
Cc: git@vger.kernel.org, Derrick Stolee <stolee@gmail.com>
Subject: Re: [PATCH 3/8] builtin/maintenance: introduce "geometric-repack"
 task
Message-ID: <aPsSWf8W7y_XvVuI@pks.im>
References: <20251016-pks-maintenance-geometric-strategy-v1-0-18943d474203@pks.im>
 <20251016-pks-maintenance-geometric-strategy-v1-3-18943d474203@pks.im>
 <aPLC9FIDR8Y3ayn+@nand.local>
 <aPeD75W4FjtTZDYr@pks.im>
 <aPp/0/kU1LMBjt7g@nand.local>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aPp/0/kU1LMBjt7g@nand.local>

On Thu, Oct 23, 2025 at 03:19:47PM -0400, Taylor Blau wrote:
> On Tue, Oct 21, 2025 at 03:00:31PM +0200, Patrick Steinhardt wrote:
> > > > +	# Verify that the number of packfiles matches our expectation.
> > > > +	ls -l .git/objects/pack/*.pack >packfiles &&
> > > > +	test_line_count = "$EXPECTED_PACKS" packfiles &&
> > > > +
> > > > +	# And verify that there are no loose objects anymore.
> > > > +	cat >expect <<-\EOF &&
> > > > +	info
> > > > +	pack
> > > > +	EOF
> > > > +	ls .git/objects >actual &&
> > >
> > > I wonder if there is an easier way to check for loose objects here that
> > > doesn't require you to know that the "info" and "pack" directories
> > > exist. Perhaps something like:
> > >
> > > test_stdout_line_count = 0 find .git/objects/?? -type f
> > >
> > > , or even
> > >
> > >     find .git/objects/?? -type f >loose.objs &&
> > >     test_must_be_empty loose.objs
> >
> > This doesn't work though in case there is not even a single sharding
> > directory:
> >
> >     find: '.git/objects/??': No such file or directory
> >
> > I didn't really have any other idea for now to do this.
> 
> Mmm, good point. What about using 'git count-objects -v' directly?
> 
>     test_loose_object_nr() {
>       local nr="$1" &&
>       git count-objects -v >count &&
>       grep '^count $nr$" count
>     }

I guess that works. We can even simplify this case as we really only
want to check that there are no loose objects at all:

    git count-objects -v >count &&
    test_grep '^count: 0$' count

Thanks!

Patrick
