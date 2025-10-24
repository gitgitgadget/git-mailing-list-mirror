Received: from fhigh-b5-smtp.messagingengine.com (fhigh-b5-smtp.messagingengine.com [202.12.124.156])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AC104212B31
	for <git@vger.kernel.org>; Fri, 24 Oct 2025 05:14:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.156
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761282899; cv=none; b=NSbdXyEM4FYwP7y2DLHbz4a9MVNBzOPPksXZ15Z11Dd60MjuDFMkQOxbzrIPnTelry9+THQ+RDwS6SYn++iJCC6KoDlQswF7H+WuU1xTNNiGXqAPjyOGnLgJKK4UXaVVI4mwf4kQDb9F9ZkFZ6qozKeGNKaShmpQrh3vBxKPFOA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761282899; c=relaxed/simple;
	bh=Dr8msDUaGXzMeiOoNzzzrFN817rORBWYPQWygOcwZh0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=beHR/IQ/9JcXv+R5wEP34VF8wxjZPInbmrzQX4so4wOhGkw3dQUiNRyE9/HbIsST8Pxe7rVc2HeBOiuB4tMifdd9WF0Y0LU3DjQLPhXD1OnRz3KnWCjOQCwoEt+wkV3MucM7uY4g8BF1aKaVZSzFLNeJcAahTSXeRIDGC0lg3yw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=aBjqck6F; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=Jx02/d0H; arc=none smtp.client-ip=202.12.124.156
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="aBjqck6F";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="Jx02/d0H"
Received: from phl-compute-06.internal (phl-compute-06.internal [10.202.2.46])
	by mailfhigh.stl.internal (Postfix) with ESMTP id AC19E7A0165;
	Fri, 24 Oct 2025 01:14:56 -0400 (EDT)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-06.internal (MEProxy); Fri, 24 Oct 2025 01:14:56 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1761282896; x=1761369296; bh=i99WlWZtXB
	ffUhebsy2rm5EY6xU/AdCypdfz7bR0qFg=; b=aBjqck6F6/vG45lTkd1+AUUCYx
	+GLx9h2wFHYreHYvj9IZsRrj5TSwvjnrajpkGyMWBoIVV4FIHOKM3q5liFR6FNQR
	dm7t3PiHaQ/jaA1pUqIKCLOi/8lYdhcNkfzaL59++A1hyNl5GMmNQFdFVxXnb9ts
	uBMs09ipRl+xb2GgjDSaWu4tjO9BMa4D8Fq9a1DXTFa1sg4bNZrhMI4MDezCVZhQ
	nR+JgwWetMnXFAQ82TbuReVntxH4jP5vJn07W9cmlKqokp8QKoHnWi9A+QYPVvGt
	1hwpsIPIfZtPvrMoFE4OtEFuX5e201Sdbqr6+phV6kdtdvq8dGUpC+bJtQiw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=
	1761282896; x=1761369296; bh=i99WlWZtXBffUhebsy2rm5EY6xU/AdCypdf
	z7bR0qFg=; b=Jx02/d0HSShfEH5yoVzBC8I7JdsdKmB2UQsUpcfvWrnh1lX6MMO
	6tFAMGTRxzPUOvwnAb9nAMuAZaqKLN7daiAxwLX1Vl8mZYSL/78S8owGa7XRcunq
	2rOB28PEtNyZRgeRriu0Hs9R+2zyjZwENo+/XaBr+V+v1VLi7o1maeSamDGQcopm
	opHHd9Nv3V9ScjYd4vRurEFGedSSQrwgVM/0a+Y/fNsM/PEXYpKCE5cObMzR3LAI
	2EjOmoesId4tTa+Ec4gQOV3lrTNKH/rLPryQ9FIFQ71kkzkGnKTzhhH7Q27iheBV
	1vTmwy3fRZ9DZ1viOmOenXT+v+RlDLe5efA==
X-ME-Sender: <xms:UAv7aKfmRGMgj4T9Sr12iY4THP-CoABGg64X6iiTI7XkDgtepvYRaQ>
    <xme:UAv7aLElsbpuoEmuyIJCf2rnRMMYIH3kcYHvO1Qurm-1sRZL6uoQqN0KWwOOUr9OU
    I6lvikbJ6_R1plXIlXUDdhz5PHlROz7STGVi9AmkTMehuD5iyEx8sc>
X-ME-Received: <xmr:UAv7aD2liIXV_7nzwINQpDI5nkIM2MbChnvPOivm-wfJJs1uLHLpSy-ALmYT8ldNCl-f37N66ZEmbvMhoaE56PymMyPN9DGmtSO7Mi9KjA>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdeggddugeekgeekucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhepfffhvfevuffkfhggtggujgesthdtredttddtvdenucfhrhhomheprfgrthhrihgt
    khcuufhtvghinhhhrghrughtuceophhssehpkhhsrdhimheqnecuggftrfgrthhtvghrnh
    epveekkeffhfeitdeludeigfejtdetvdelvdduhefgueegudfghfeukefhjedvkedtnecu
    vehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepphhssehpkh
    hsrdhimhdpnhgspghrtghpthhtohephedpmhhouggvpehsmhhtphhouhhtpdhrtghpthht
    ohepshhunhhshhhinhgvsehsuhhnshhhihhnvggtohdrtghomhdprhgtphhtthhopehkrg
    hrthhhihhkrddukeeksehgmhgrihhlrdgtohhmpdhrtghpthhtohepghhithhsthgvrhes
    phhosghogidrtghomhdprhgtphhtthhopehjlhhtohgslhgvrhesghhmrghilhdrtghomh
    dprhgtphhtthhopehgihhtsehvghgvrhdrkhgvrhhnvghlrdhorhhg
X-ME-Proxy: <xmx:UAv7aDlTgF8YKDFLphMlaJvuty9HgVpIu_dBisJSxTKu1oExxC3kIQ>
    <xmx:UAv7aD9iClDU9RdbRGqbYXk5dWJOeLbakpQm5FqdTcnaJY3OUec6qg>
    <xmx:UAv7aIrIwKCR3ORj7dJ9ZW2ovSZCNGKnza2Xp4LoHTzthKYq1vebyw>
    <xmx:UAv7aMmmsodF__lQodpZ1ay6ZrMfhUUMhictLKaPVp4PoVoJfHwmiA>
    <xmx:UAv7aCA3QhsXjeZgXvTaoS3Jc-mYB8MP8JUvimfAtijDFSviY0VJkufz>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 24 Oct 2025 01:14:55 -0400 (EDT)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id 4694986e (TLSv1.3:TLS_CHACHA20_POLY1305_SHA256:256:NO);
	Fri, 24 Oct 2025 05:14:54 +0000 (UTC)
Date: Fri, 24 Oct 2025 07:14:51 +0200
From: Patrick Steinhardt <ps@pks.im>
To: Junio C Hamano <gitster@pobox.com>
Cc: Justin Tobler <jltobler@gmail.com>, git@vger.kernel.org,
	karthik.188@gmail.com, sunshine@sunshineco.com
Subject: Re: [PATCH v6 0/7] builtin/repo: introduce structure subcommand
Message-ID: <aPsLS6lbzG27W-C8@pks.im>
References: <20251015211213.361797-1-jltobler@gmail.com>
 <20251021182601.2687284-1-jltobler@gmail.com>
 <xmqqtszps5ja.fsf@gitster.g>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <xmqqtszps5ja.fsf@gitster.g>

On Thu, Oct 23, 2025 at 01:54:17PM -0700, Junio C Hamano wrote:
> Justin Tobler <jltobler@gmail.com> writes:
> 
> > In this initial version, the "structure" subcommand only surfaces counts
> > of the various reference and object types in a repository. In a
> > follow-up series, I would like to introduce additional data points that
> > are present in git-sizer(1) such as largest objects, combined object
> > sizes by type, and other general repository shape information.
> >
> > Some other general features that would be nice to introduce eventually:
> >
> > - A "level of concern" meter for reported stats. This could indicate to
> >   users which stats may be worth looking into further.
> > - Links to OIDs of interesting objects that correspond to certain stats.
> > - Options to limit which references to use when evaluating the
> >   repository.
> >
> > Changes since V5:
> > - Instead of using `filter_refs()` to get an array of all references, we
> >   now use `refs_for_each_ref()` to count references, and setup OIDs for
> >   the path walk, in place. Doing this not only allows us to avoid
> >   wasting memory storing all the reference info, but also to display
> >   progress info to the user while iterating across the references
> >   initially.
> > - Add a prepatory patch to export `ref_kind_from_refname()` via
> >   "ref_filter.h" so we can reuse logic to categorize references while
> >   counting.
> 
> This round looked pretty well done to me.  Shall we declare victory
> and mark it for 'next' real soon now?

Agreed, I also think that this round looks good and is ready to be
merged down to next.

Thanks!

Patrick
