Received: from fout-a5-smtp.messagingengine.com (fout-a5-smtp.messagingengine.com [103.168.172.148])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DAF0725D543
	for <git@vger.kernel.org>; Fri, 28 Feb 2025 10:51:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.148
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740739886; cv=none; b=Kc7db1F3yoGq/V3GD9/U1oK9Z+eoBKPKF/7Vwwn5MXqD1WWlkkRr98HoF6jYhSp5dT4gFquW2naQJI5ugPpTLNaa2EoUgGPMpRL8Jr+NxW3XjPf5v4O1ucb1yiUlQgYPRT8iNkf4fWETwxgRGJFZui7raFQWH49BFL7hCrshM28=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740739886; c=relaxed/simple;
	bh=ckj0qyt8mV/UB0kPRRnzIEsDWG1s2Ap34BbsPWwuFDs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=BTALR+fTERej4Id1/G9nNGA2Kju/GU7xxhZcuLwQFJs3mfN5NS1ffF2Tp3rv5E2FcyCONZwQ/IlMgEpsaaM+Z6nIyzMbs+Lqri7xk0UYoBJF6e0DQdAqgtGsE1xjY/F0Hrm9CyfnEj4bPQPSFb0QtNcbQAm9jyPYG0slqS/fkHI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=airzcqAv; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=SqJMQ9Ro; arc=none smtp.client-ip=103.168.172.148
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="airzcqAv";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="SqJMQ9Ro"
Received: from phl-compute-05.internal (phl-compute-05.phl.internal [10.202.2.45])
	by mailfout.phl.internal (Postfix) with ESMTP id DC77B1380A16;
	Fri, 28 Feb 2025 05:51:23 -0500 (EST)
Received: from phl-mailfrontend-02 ([10.202.2.163])
  by phl-compute-05.internal (MEProxy); Fri, 28 Feb 2025 05:51:23 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1740739883; x=1740826283; bh=d4l/b8U8Z0
	MyVz1DOSgSMv3BGSUxaGHn8JjIhQ932Co=; b=airzcqAvQsFEgMfVDFw80F1SY0
	0eiWMvF26sSrfAUydnbXwN8cvgq2qEQ+/24v5nwBVrD0Z+jqfueH8QEuvouDt4lW
	CZEbC5TU403qatJRGa2zHNiXjFKwubQ7n2OKVEhLsHSydOTZyw3kOIAY9ZlcfGhS
	3k7YrFrYU5s4u3+J8scqbRmZkh0VgLH3EDDcRXlWmsBYTUK1XxtqRVtDPv302MfG
	PvSh9nrFzKTqwlivXa4ME3wEnTyJEp+0BEsnZt/UNc5ktmbQE1PP2jtf5azpAQjR
	Cnj4O26dJSWWWMW2QtzUxje0zx5UI2Bs8kQft9SJEi0MbLTFMXkMr9zcjapA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
	1740739883; x=1740826283; bh=d4l/b8U8Z0MyVz1DOSgSMv3BGSUxaGHn8Jj
	IhQ932Co=; b=SqJMQ9RoFslI0CYpBsFPE+ZcUJdijGJwyvfjseI2GZ7wNMusZ+Y
	OBX/ARBiQqtz1MUGkvwrG20LQ1m803kx9r4/EpF5yR92ih4Oym7JGQaxqXYjAwuO
	qsguKikj8DOA1YaPWgZfQgjX9kZVN/amESK3f1Pms1jpLQyucJzZUN3PsDpnwjfd
	UOk5bAZgT19kJiwE77uvMHQnyg79fVmQGj1hJZj04JHj2ul9Btx1tErmlhT8ICeC
	Ws+4w6i6xN9LmeX6IL9lOmsaJcZU9lsW3EawjQoK8z47/0eDUNQ/LumJ/urnNCbr
	XbBz7wbZztje/7Uj1OXERmHJb11lkkJI9VA==
X-ME-Sender: <xms:K5XBZ5PVWtEidrF1-drxiIEOy5mwE9MionMmZdWGU9RhO_2IgbWCSw>
    <xme:K5XBZ78dCWU_fXULkjcDdyIbfMU8L1T6N1sZnEHbXo1TGUezspjh40I5gbO6tdAdR
    XD0feVqsNlR-KgCsA>
X-ME-Received: <xmr:K5XBZ4ScDzvGsJhVuBa0kfmNaN2QzsHK_gPRhk3VidvWSoA4H6NppeUAHw0TkqvC2Zsst5UouVLqMhZHDdHBqxQo0g4h6QH8aRvg89X0pTG0_80z>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgdeltddvtdcutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpggftfghnshhusghstghrihgsvgdp
    uffrtefokffrpgfnqfghnecuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivg
    hnthhsucdlqddutddtmdenucfjughrpeffhffvvefukfhfgggtuggjsehttdertddttddv
    necuhfhrohhmpefrrghtrhhitghkucfuthgvihhnhhgrrhguthcuoehpshesphhkshdrih
    hmqeenucggtffrrghtthgvrhhnpeevkeekfffhiedtleduiefgjedttedvledvudehgfeu
    gedugffhueekhfejvdektdenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmh
    grihhlfhhrohhmpehpshesphhkshdrihhmpdhnsggprhgtphhtthhopedvpdhmohguvgep
    shhmthhpohhuthdprhgtphhtthhopehtohhonhesihhothgtlhdrtghomhdprhgtphhtth
    hopehgihhtsehvghgvrhdrkhgvrhhnvghlrdhorhhg
X-ME-Proxy: <xmx:K5XBZ1uo1zJqr3QXPziEWJ_OP6cdIPPZDtCSDJQDeO7Oll8xwO6o2w>
    <xmx:K5XBZxc1PMGn8eZmQNCAv9mElT9rRiVTJHfJqqbx0pSMX630DH_poA>
    <xmx:K5XBZx3hb8JfjKyfJfrjPfYjw2oEcW8QXvyTDLLZjJNVog0jJE_R5w>
    <xmx:K5XBZ994PG3cLEOod-NEGBjWlCXp-SsnM3DN8AmNplDoxvB9beBK_A>
    <xmx:K5XBZyou2v9ViGlrHXp8EFobgkXoWDMp_8cNM0zNWzTYb0SKfItwRLC1>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 28 Feb 2025 05:51:22 -0500 (EST)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id 6b0b573b (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Fri, 28 Feb 2025 10:51:21 +0000 (UTC)
Date: Fri, 28 Feb 2025 11:51:20 +0100
From: Patrick Steinhardt <ps@pks.im>
To: Toon Claes <toon@iotcl.com>
Cc: git@vger.kernel.org
Subject: Re: [PATCH 2/9] builtin/cat-file: wire up an option to filter objects
Message-ID: <Z8GVKLee75GDG2S4@pks.im>
References: <20250221-pks-cat-file-object-type-filter-v1-0-0852530888e2@pks.im>
 <20250221-pks-cat-file-object-type-filter-v1-2-0852530888e2@pks.im>
 <874j0graug.fsf@iotcl.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <874j0graug.fsf@iotcl.com>

On Wed, Feb 26, 2025 at 04:20:55PM +0100, Toon Claes wrote:
> Patrick Steinhardt <ps@pks.im> writes:
> 
> > In batch mode, git-cat-file(1) enumerates all objects and prints them
> > by iterating through both loose and packed objects. This works without
> > considering their reachability at all, and consequently most options to
> > filter objects as they exist in e.g. git-rev-list(1) are not applicable.
> > In some situations it may still be useful though to filter objects based
> > on properties that are inherent to them. This includes the object size
> > as well as its type.
> >
> > Such a filter already exists in git-rev-list(1) with the `--filter=`
> > command line option. While this option supports a couple of filters that
> > are not applicable to our usecase, some of them are quite a neat fit.
> >
> > Wire up the filter as an option for git-cat-file(1). This allows us to
> > reuse the same syntax as in git-rev-list(1) so that we don't have to
> > reinvent the wheel. For now, we die when any of the filter options has
> > been passed by the user, but they will be wired up in subsequent
> > commits.
> >
> > Note that we don't use the same `--filter=` name fo the option as we use
> > in git-rev-list(1). We already have `--filters`, and having both
> > `--filter=` and `--filters` would be quite confusing. Instead, the new
> > option is called `--objects-filter`.
> 
> I'm not sure I agree. I would rather have consistency in various
> commands. Because `--filters` doesn't accept an argument, so I would say
> having both `--filters` and `--filter=` is fine. I see in various places
> we already use `OPT_PARSE_LIST_OBJECTS_FILTER` which defines the option
> as `--filter=`, so it's pretty standard for several commands. I'd
> prefer git-cat-file(1) to follow that as well. But that's my 2 cents.

I'll wait for a third party to chime in as a tie breaker here :) I'm not
feeling overly strong about it, but still think that it's just too easy
to get wrong when those options are so extremely similarly named.

Patrick
