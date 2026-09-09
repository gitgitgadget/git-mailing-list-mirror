Received: from fhigh-b8-smtp.messagingengine.com (fhigh-b8-smtp.messagingengine.com [202.12.124.159])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0641C302CC1
	for <git@vger.kernel.org>; Wed,  9 Sep 2026 05:48:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.159
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788932912; cv=none; b=WqZlHDV2hrp0VtrIEv2IBiJ4RABsyfoFonCqVeqaZhpuErn7nBHmNayifsbEuEZzc6KXY3be6+mQ8nXjk6dhH9a1iL2w1pU7Osznki9tfTfl2OIdxYEL6HwKhU8c0MX4zgmGBAv5C3Bc9o9wLPwTPKs3o5/0w182cUSljx6SUAw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788932912; c=relaxed/simple;
	bh=hhHFRhqgwwRQ3jPAO9MczjYibwFRdG7xQEQwx8OUFJM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=DekGUsr+1cqDbupcmCij6Ev2zDayAbgmjqz/YO40t9YJC7gbARDiKKeiiH/DA/FtoHMqDbC30LSIpv0rDBYFfmPTwqtAvu974o3WPYIYCOO1GrZuk4YvJjvUmjx1vf8BXS9AcQq3+ZNw0D3Lon4GeGqFFVIrYjhEqS30tY7bNdw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=ZdBVq0+U; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=r4UcXZP1; arc=none smtp.client-ip=202.12.124.159
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="ZdBVq0+U";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="r4UcXZP1"
Received: from phl-compute-02.internal (phl-compute-02.internal [10.202.2.42])
	by mailfhigh.stl.internal (Postfix) with ESMTP id 0D8577A00AD;
	Wed,  9 Sep 2026 01:48:30 -0400 (EDT)
Received: from phl-frontend-03 ([10.202.2.162])
  by phl-compute-02.internal (MEProxy); Wed, 09 Sep 2026 01:48:30 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1788932909; x=1789019309; bh=a+8MYHQ5hL
	IgAN+Ou4J3QNmB+qaDluxOq2uTE1oroZc=; b=ZdBVq0+Uvq0OBBvV5G+AQFK40O
	GftT+YgnZAXJUNaHJ4kEYJjp4ZC/v0Ob8wBDj+G8QAtjCGKjkVfjXGZ5wLTV8+hp
	gxru7ZLspXrm2kogZOudzx8hhzK5JkSh/H4jP3cQF7oeNfqbo76Ayd8D/yQEU40K
	CbC/8blSsQZiNAQCKGzEYjWMSZLnNWVHi/ylEWwDlMriK0CaynTEDMgLcjrgWfPm
	Kv2EGFbcsWBvAqF5qqRYeQBlP4ZHOlAjwc7ZUpYn57WwHUnLL0bViIMXQp1m8QSD
	b709OhM6EgtsMgJzHs5b5qgzG0Lhyynos+EbrD0LDM4EFYeq5RMHsZV2vyWA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
	1788932909; x=1789019309; bh=a+8MYHQ5hLIgAN+Ou4J3QNmB+qaDluxOq2u
	TE1oroZc=; b=r4UcXZP1XLO1GShOUjUwnMzFUaCkykBPjHgz58TyIEFxL0WdtAm
	/EV/cDBVou1Ytg44luZZatG1fXDWuZgtSeaAPnhPXgosK/zbTtYahXqYGIUB+chU
	gfVsibmubk1MdHoZ58zYxr3njId+EaSFW9+NTJ6UG1ITEOMlDatSjdLje2b4mjO+
	RLmscWhA7Twlv+dPSGVcjEGdylYzzLpRid94uEvqqvCuKnMCf/R5MAOG1gKbHEOb
	vwiLZS76I88EViUDCWcNGS050lF28QMl8FfjzeWChlUVCMHtV6IP4NTkeu5z1svS
	+/Xxpp3mB1ZbheMi7HhI6zFjA4XLQxClQvw==
X-ME-Sender: <xms:LfOgatBUhCOrWxeyQL9xOfUdmJokaKYde_vpApXkuEwctEwV7j8Vig>
    <xme:LfOgaii9efYGV2rBHy49DP5uZeQFrFdDStrEk5eNSsjVlkpKT9jwmJ1k6hF1CD-k7
    7Yzr0hr5yDZAgaAZ8YVU4T1004QFRE4zMgdcxsC2iCHOO6I6LOFdA>
X-ME-Received: <xmr:LfOgatmHkdDhhpCuG9ky6Cb1P2DapIt66j1JuNpLtXh3B6PFpdNuUkF0jssmysK7Sal22g>
X-ME-Proxy-Cause: dmFkZTGqiWueItAUgUmNgAQiK7d9yQ3PCxYPLlIkKKfGE0hKC4EnHqHgpyINkgL5PxVuqF
    pNfqkvA3qWnICCkcpTLLtEP1awWNO1O6/+pUrSn+jovH18Y2a1/YA9acEYyR/V7pgIkJZr
    lzZX7pVzqkAXrd9oWyOWvH8GVzIIw2BMENRWGp+urZFG3CUasynS3VcPoyukvJ/mogBtWT
    dzeNFQF11Nck4ooQ2fQOAcrMJkmUFfQvA9k0iQKymR6ia1neCK9clSTIW0mNvhmjzYD5/D
    Eh4YA4r0QuwdleI10QhsIYyiuvc3yNNPrAKZa/s14BK8qh0a7sdj/6av6QyJC+QvXk9Xl7
    ZxA6TOkx8SOR4lliqCkRZ1bBPxJCM+Wlczx+o3DEJookJq77up7U7Xv+rEiAomQFSJjQRX
    djUm4N5bJCVhb8/N8/hwWbRyScNBp/EroEwpqA/afyu/OnJEPsxcFDVm/j6dHu3imMAseB
    wb1sOMArhHo18CjeG9lJ95mCkXgkEdgZ+5qSHOYJtGvtIER8Jp1rmiFqet4pTOcjnqHeYc
    ncIQSvOziA0ku6bFrZYJcKWTHnssrNpMVm4vMcLT1hFBn4ssuO7swwieUTEyuWLGQNp5km
    zlTjKgOnpihOc/wGncQbOQJqEF8OL4iDp9pQPMEtuvk0Rq7V+NnbhOpdjMCw
X-ME-Proxy: <xmx:LfOgamrbL9FhmZICGDh2U0WgIk22H4dwYN6vrJd4D2uYamS1PQpcRw>
    <xmx:LfOgauHdeu8KQoWT1n-aPAbkSwgXwaNXm0Ezac6poKUgoPhxRAdMSw>
    <xmx:LfOgaqzsqlKFA81wLId7IIJ78CgJZzbnk9X9k6x9BXgtA00SyWkdSw>
    <xmx:LfOgarpg5KGE2Uz6fvCWeT-dqrY8-XgpIM4PulWdjxIlfKBW3UtPEw>
    <xmx:LfOgaomcePG4QL8v1dA_YKLKHV3eHLxd1J3jD2p3-hddDlrGaDHR5rNZ>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 9 Sep 2026 01:48:28 -0400 (EDT)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id 8b720549 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Wed, 9 Sep 2026 05:48:27 +0000 (UTC)
Date: Wed, 9 Sep 2026 07:48:25 +0200
From: Patrick Steinhardt <ps@pks.im>
To: Justin Tobler <jltobler@gmail.com>
Cc: git@vger.kernel.org, Toon Claes <toon@iotcl.com>,
	Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v3 2/9] builtin/clone: defer setup of the object database
Message-ID: <aqDzKcce-65R_aRE@pks.im>
References: <20260907-pks-odb-write-alternates-at-creation-time-v3-0-735d0b5b3e00@pks.im>
 <20260907-pks-odb-write-alternates-at-creation-time-v3-2-735d0b5b3e00@pks.im>
 <aqCI5pfM3AGtfQsJ@denethor>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aqCI5pfM3AGtfQsJ@denethor>

On Tue, Sep 08, 2026 at 05:20:06PM -0500, Justin Tobler wrote:
> On 26/09/07 10:25AM, Patrick Steinhardt wrote:
> > When cloning a repository we defer initialization of the reference
> > database. This is because we don't yet know all details required for us
> > to initialize the refdb in the first place. Most importantly, what we
> > are missing is information about the object hash.
> > 
> > We don't do the same thing for the object database yet, but here we
> > essentially have the same problem. While the "files" database does not
> > need any information about the object format at creation time, alternate
> > backends are likely to require that information so that they can
> > properly set up their data structures.
> > 
> > Besides this forward-looking future proofing though, we also have a
> > second use case for deferring initialization of the object database,
> > namely alternates. When initializing the object database we do not yet
> > know whether we'll need alternates or not because this depends on the
> > repository we're about to clone from. If it is a local repository and
> > the user has passed "--refernce{,-if-able}", then we will end up writing
> > alternates into the object database.
> > 
> > The ugly part though is that we cannot determine where the repository is
> > getting cloned from before it has been initialized. While we of course
> > already have access to the user-provided URI, that URI can be very well
> > rewritten via "url.<base>.insteadOf". We can of course read the global-
> > and system-level configuration to resolve it. But we explicitly resolve
> > the URI a second time after we have initialized the repository because
> > it can happen that we copy a ".git/config" over from our templates, and
> > that file may cause us to rewrite the path.
> > 
> > In a subsequent commit though we'll start to write alternates as part of
> > the repository initialization, so we'll need to have the URI properly
> > resolved before we can initialize the object database. This is ugly, but
> > as mentioned above it makes sense for us to defer its initialization
> > anyway so that we also know about the object hash already.
> > 
> > Defer creation of the object database until after we have resolved the
> > URI.
> > 
> > Note that this also requires us to defer the call to `setup_reference()`
> > until after we have created the object database. While you might think
> > that this function has something to do with references ("refs/*"), it is
> > in fact responsible for setting up alternates. Consequently, we can only
> > call it after we have created the object database already.
> 
> Ah ok, so now that we are deferring ODB creation a bit further, we need
> to also move ref DB creation to afterwards too. Makes sense.

This is not about the reference database, `setup_reference()` sets up
out alternates. But I think you just miswrote here, as you do mention
alternates further down in your reply.

Patrick
