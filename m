Received: from fhigh-b5-smtp.messagingengine.com (fhigh-b5-smtp.messagingengine.com [202.12.124.156])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0D0C0190664
	for <git@vger.kernel.org>; Thu, 24 Jul 2025 06:22:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.156
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753338134; cv=none; b=TtJpe4SYMid+xlsgaR09E/9XSt9DYaF0kc8ue2tv6VfqeFA7I6bnTTlcbYZMNP9RitQsmaszRl1dly2HTHuffH+XFDpYQcQ1TtWV2FMfTDvz9lxusS8duytH6dortiakxjYHpCTLDio7ME7OLYu4mIzF3zwYtfghQNNXm1TDWC8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753338134; c=relaxed/simple;
	bh=ZlozVtxpyttdReG7xvQs+MWphqlnK03R0H9KcBJf1ik=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=LcqWkQFhB76Z9IZv5AB47y40ARqh2etOR6p2GGwyJRTeQVvY/hJ88OIKlKgrPAtcJpQ/O7yw2qbiP8SA1K7YyNo2YznSBsjQykLxqeavZYUts6tudWPlAnDmc1ggYEnNYj+zJl1HZyK0jtBrgwkSa5yh84f/CIp+6l3X2X0jf40=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=fo1K2pNH; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=EX7UhtsW; arc=none smtp.client-ip=202.12.124.156
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="fo1K2pNH";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="EX7UhtsW"
Received: from phl-compute-12.internal (phl-compute-12.phl.internal [10.202.2.52])
	by mailfhigh.stl.internal (Postfix) with ESMTP id D303F7A0046;
	Thu, 24 Jul 2025 02:22:10 -0400 (EDT)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-12.internal (MEProxy); Thu, 24 Jul 2025 02:22:11 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1753338130; x=1753424530; bh=UiIEK5tp7J
	EJBZ5bhpAtVW5rOK0JkdHPQrW9V1lSxrQ=; b=fo1K2pNH1+UPMPSCfbAdl0pJFq
	iZHC2oybh6oWEZj665Z32IUfAsKw/2QdulXAxIPJ3phXHW2dyNsSm2gHUNuSocgM
	BuyBQuSJ0HYfhPSJwD73ls6ZJu2025+4DGCb5WwFzrQNSk5vHMkIerp0YjUthFmy
	j0LvUshaS0QqyEPisQsZd3Nug0tg4daO7DjM4SHyOXNvtjewvyQTMmMBQppJr6V4
	q60dJ7T6MWurMpk3rRhe+dT9pDBc1a66GQc0Dm+4P4ahWfa7ypdPa0uI5TbxzqKd
	RVAePsnaHVw/UCT0fEPeauFUJOR9hdjEewZPKLX9cxaWzhYNlOOm9im4F1kQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=
	1753338130; x=1753424530; bh=UiIEK5tp7JEJBZ5bhpAtVW5rOK0JkdHPQrW
	9V1lSxrQ=; b=EX7UhtsWzn9luVQzJLnDFNwszEwD5FItWlEfi9Ywoeg+Dlusgfh
	iLihYOdujvsoRTi+eIM7pc5to/4tNX1KTYXGcQjscODftVPlClDQvicdqrQIdbrK
	Hs6/3a+iAxL7ld3lsdLydXzch27SwFVOTvk1wyJBnllEBkCMCEGI9l7HgD8hU3Pe
	RVV7cUPRCRmBIm6gObEDwN4aH0uGr6v33tb855AXlNX5nhv7qjF6tIJeq7+aHj3b
	spq/+ojHp6StKTwOhU4qrGGDRhcRKnw3H8s2D8vmjUOSocIlb4JsW/sSx+lnliym
	FwLD6U4o2oGrZBRDrqw9Yzfc8x61fgnLRZg==
X-ME-Sender: <xms:EtGBaKGwIOkIFQ5j_o0pS-Wi8STnUEukUkCBHFVOPyK_qH1nTS-gfw>
    <xme:EtGBaAhpRjxV9wmeZ1wgK4XXzdXD0Ryon4_Imhd6hymIlkl4LdT-x_XJswwHb3ec0
    n95kG8SEYvSWkRgIg>
X-ME-Received: <xmr:EtGBaFDmb5Cp4EPGGXXPRKh2LYwfBVaTzGjPvx-BOchdyITcCW4yHRMgQIPvkPNuKNnLdA8akTzY8HpNYMpisG28faFa4MnpJ7K5l7P_fig>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdefgdejleelvdcutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpuffrtefokffrpgfnqfghnecuuegr
    ihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjug
    hrpeffhffvvefukfhfgggtuggjsehttdertddttddvnecuhfhrohhmpefrrghtrhhitghk
    ucfuthgvihhnhhgrrhguthcuoehpshesphhkshdrihhmqeenucggtffrrghtthgvrhhnpe
    evkeekfffhiedtleduiefgjedttedvledvudehgfeugedugffhueekhfejvdektdenucev
    lhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehpshesphhksh
    drihhmpdhnsggprhgtphhtthhopeekpdhmohguvgepshhmthhpohhuthdprhgtphhtthho
    pehphhhilhhlihhprdifohhougesughunhgvlhhmrdhorhhgrdhukhdprhgtphhtthhope
    hjlhhtohgslhgvrhesghhmrghilhdrtghomhdprhgtphhtthhopehoshifrghlugdrsghu
    ugguvghnhhgrghgvnhesghhmgidruggvpdhrtghpthhtoheplhhutggrshhsvghikhhioh
    hshhhirhhosehgmhgrihhlrdgtohhmpdhrtghpthhtohepkhgrrhhthhhikhdrudekkees
    ghhmrghilhdrtghomhdprhgtphhtthhopehgihhtshhtvghrsehpohgsohigrdgtohhmpd
    hrtghpthhtohepsggvnhdrkhhnohgslhgvsehgmhgrihhlrdgtohhmpdhrtghpthhtohep
    ghhithesvhhgvghrrdhkvghrnhgvlhdrohhrgh
X-ME-Proxy: <xmx:EtGBaKRAFD1RXisW4ZmcYSORLLHuJX4GcZ84CjXRY93bT4E43nOmow>
    <xmx:EtGBaCW-ljVijBXtKwNa_PaAdBFk4Sg4ykW0bNp-FomIRNaLSsKd2Q>
    <xmx:EtGBaLcIPifwFa2OkmoruFsrkX_cHzYIiYzCrRvMWT7i5dgzB48dmQ>
    <xmx:EtGBaGLVfjnzm7TDxOQ5YNRBYDOlwwq1WEkUOo0IK5jnuvHtd5K6fw>
    <xmx:EtGBaB-uSzxaQzS6s1OKBoS8UxO2US3Rf5YtnPn9ecI_rDlFsjNGeW5P>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 24 Jul 2025 02:22:08 -0400 (EDT)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id 45ac8f59 (TLSv1.3:TLS_CHACHA20_POLY1305_SHA256:256:NO);
	Thu, 24 Jul 2025 06:22:06 +0000 (UTC)
Date: Thu, 24 Jul 2025 08:22:03 +0200
From: Patrick Steinhardt <ps@pks.im>
To: Junio C Hamano <gitster@pobox.com>
Cc: Karthik Nayak <karthik.188@gmail.com>,
	Lucas Seiki Oshiro <lucasseikioshiro@gmail.com>,
	git@vger.kernel.org, oswald.buddenhagen@gmx.de,
	ben.knoble@gmail.com, phillip.wood@dunelm.org.uk,
	jltobler@gmail.com
Subject: Re: [GSoC PATCH v5 1/5] repo: declare the repo command
Message-ID: <aIHRCz_qswp7RgSy@pks.im>
References: <20250610152117.14826-1-lucasseikioshiro@gmail.com>
 <20250722002835.33428-1-lucasseikioshiro@gmail.com>
 <20250722002835.33428-2-lucasseikioshiro@gmail.com>
 <CAOLa=ZREo19jCj3i+XkRM15AzaAV9ZLOvt42pTiUFmcZpCyS5g@mail.gmail.com>
 <xmqqtt34tfna.fsf@gitster.g>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <xmqqtt34tfna.fsf@gitster.g>

On Tue, Jul 22, 2025 at 08:21:45AM -0700, Junio C Hamano wrote:
> Karthik Nayak <karthik.188@gmail.com> writes:
> 
> > Lucas Seiki Oshiro <lucasseikioshiro@gmail.com> writes:
> >
> >> Currently, `git rev-parse` covers a wide range of functionality not
> >> directly related to parsing revisions, as its name suggests. Over time,
> >> many features like parsing datestrings, options, paths, and others
> >> were added to it because there wasn't a more appropriate command
> >> to place them.
> >>
> >> Create a new Git command called `repo`. `git repo` will be the main
> >> command for obtaining the information about a repository (such as
> >> metadata and metrics), returning them in a machine readable format
> >> following the syntax "field<LF>value<NUL>".
> >>
> >
> > Doesn't the latter sentence only apply to 'git repo info'? Other
> > sub-commands may not follow the field<LF>value<NUL> syntax, no?
> 
> True.
> 
> I also wonder who it helps to use <LF> as a field separator.  Once
> we require consumers to properly handle <NUL>, it does not make it
> easier to write such a consumer script if the format uses <LF>
> there, does it?  Besides, wouldn't it possible that field may have
> to contain any end-user specified key, including <LF>?  If so, we'd
> need to have some quoting/unquoting mechanism in the syntax anyway,
> so the behefit of using <NUL> to simplify the parser would already
> be lost.

Scripts should always use NUL, true. But sometimes a user may want to
inspect these key-value pairs, as well, just to double check a certain
property of the repository, or to figure out how a certain property
looks like while writing a script that parses the same key-value but
NUL-separated pairs. Using NUL bytes would be a bit of a pain in that
situation.

I'm not really too sure whether we need to bother with quoting. The
LF-separated output shouldn't ever be used in a script, so I don't mind
too much whether it always works. But I guess it wouldn't be hard either
to just have something like:

    if (uses_newline)
        quote_c_style(...);

So with that in mind it's probably better to just do the right thing.

Patrick
