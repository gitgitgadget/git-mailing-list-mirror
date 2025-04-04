Received: from tiger.tulip.relay.mailchannels.net (tiger.tulip.relay.mailchannels.net [23.83.218.248])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3705FDF59
	for <git@vger.kernel.org>; Fri,  4 Apr 2025 03:28:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=23.83.218.248
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743737291; cv=pass; b=U4u1gDvaPte5p9vq1nX4W6VBzIrgSvEqTBrhDtaA6WELPvz1N2udURbibBZxnfdtJLVvALFOqGk+S0iKrj2dLX3ajmuUGJ/+lzOIIx7LNpexFz5AS18lF8foCOnV4L4h/+5Uyb+JzSVRezBPr7YH0vVKnb1t+BKHBw5487dMiKE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743737291; c=relaxed/simple;
	bh=oRnX7fr8rXMh6srRV5ySexSg4WK9wQKIHMna8BK1uto=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ffMkXPuHspTsG+Om/MAj2jwlSI4gZfpSWuXptaJ5u6TmNlh4Rw/c2psE5cptbCwoupFMri/UdrC4V5TYG4v3LH/OUbUmkGTmsP/R5u9adZ7Y4c399xhXCfQIQkGezKqGe5om4S5ZTs9sJVJbOJ9VhyGDUqY/GCgdTb5kiRDx6nw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=cryptonector.com; spf=pass smtp.mailfrom=cryptonector.com; dkim=pass (2048-bit key) header.d=cryptonector.com header.i=@cryptonector.com header.b=kcY+Rz2g; arc=pass smtp.client-ip=23.83.218.248
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=cryptonector.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cryptonector.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cryptonector.com header.i=@cryptonector.com header.b="kcY+Rz2g"
X-Sender-Id: dreamhost|x-authsender|nico@cryptonector.com
Received: from relay.mailchannels.net (localhost [127.0.0.1])
	by relay.mailchannels.net (Postfix) with ESMTP id 8E84B82DD2;
	Fri,  4 Apr 2025 03:11:25 +0000 (UTC)
Received: from pdx1-sub0-mail-a259.dreamhost.com (100-99-49-173.trex-nlb.outbound.svc.cluster.local [100.99.49.173])
	(Authenticated sender: dreamhost)
	by relay.mailchannels.net (Postfix) with ESMTPA id 2986683BBD;
	Fri,  4 Apr 2025 03:11:25 +0000 (UTC)
ARC-Seal: i=1; s=arc-2022; d=mailchannels.net; t=1743736285; a=rsa-sha256;
	cv=none;
	b=jtwroH6NWhjQDt6pibH5b3MOtcj1zbOvIYASEfIT4x/CKwZ8nwASdAnl5CKRkMseN3fB5q
	PLG9u5DleqB8gaxnpsmlQT/a0pBrUVAR3+dPXE9nkB3NXkQTDDt/RxjtwA2qRV+5fvCIOq
	p42+BCYSeaPp76L0hyKKOC1V833hT2vAaNSk654W25xtSl1fV/B/04/tpvVZ4/uESpr9/b
	GrGBvxDOFIAHgZtvemD3wKO6GOg9N12F9HQZ0/tLVPUW/v4IXEheQ7vqzu+IMefBBvagrD
	HiqhjP6YXuO76ghKGYG8NLCia4LtSVQJomp0QbYkfmARGpInNSNxcE2lbuLRLw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed;
 d=mailchannels.net;
	s=arc-2022; t=1743736285;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references:dkim-signature;
	bh=fOrcvvrJ+rugrAIMHMIqICrAaZWuqqkbET5km6xHtuI=;
	b=klUHTOwJy53P4GvH+Qmvv/Gez88uh2ebPO9BjhFj2sYRAJF5+BJHAQ3pUAU+O4DSuiPusd
	yfMqPaIgT07lOdvT3cZFQZlXbNaPp1KMeS3Sof+2hFCeOp3deKYlFk/w/aEfaN85TVQqf9
	1FMWaE3UEIcqEkhrO2mir1m1kOvae2psvBmY1F4ddS7BAidkgdOmjKwvb+G8SK1MFf5XjA
	3s62xJ8voWkANxU+ZYJagsNSEsRYtGAXBDstIzYcCR2bHK1r9cp/timR75XK8FnghE+ehz
	BN5ti9/gfX9FyqNrwzEhvgYNKltvhHu4NvR3zQ1+P1Mj03Kgm/vD37zaSaxrpQ==
ARC-Authentication-Results: i=1;
	rspamd-5c8769d675-xdpcl;
	auth=pass smtp.auth=dreamhost smtp.mailfrom=nico@cryptonector.com
X-Sender-Id: dreamhost|x-authsender|nico@cryptonector.com
X-MC-Relay: Neutral
X-MailChannels-SenderId: dreamhost|x-authsender|nico@cryptonector.com
X-MailChannels-Auth-Id: dreamhost
X-Suffer-Cooperative: 59ccd1f25dc77543_1743736285435_952594484
X-MC-Loop-Signature: 1743736285435:1238152484
X-MC-Ingress-Time: 1743736285434
Received: from pdx1-sub0-mail-a259.dreamhost.com (pop.dreamhost.com
 [64.90.62.162])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384)
	by 100.99.49.173 (trex/7.0.3);
	Fri, 04 Apr 2025 03:11:25 +0000
Received: from ubby (syn-075-081-095-064.res.spectrum.com [75.81.95.64])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: nico@cryptonector.com)
	by pdx1-sub0-mail-a259.dreamhost.com (Postfix) with ESMTPSA id 4ZTNt374g5zGG;
	Thu,  3 Apr 2025 20:11:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cryptonector.com;
	s=dreamhost; t=1743736285;
	bh=fOrcvvrJ+rugrAIMHMIqICrAaZWuqqkbET5km6xHtuI=;
	h=Date:From:To:Cc:Subject:Content-Type;
	b=kcY+Rz2giokZzuy5LflVSz/fg/ZVFiBUOcKG/pKAwgXMZqrJ7pprX3Ct4XMamp9PR
	 i2pjaUkK08hNLxfUnv2eyqm4I8mgNb4HtA0Uz2qvn11h6n1FBw/Vx9Tkt5pUW+qkmO
	 ylGxRsgZFqlYwDyCxy3pLTrHqkaRimBQ/qHS8A5zjq4V3gvkaGXQ/54+wrBquCxD1F
	 5Rw64SI/KBFDTLvvs+I84cDAd2ZjMJlxXz4gbCHxVf+07ZA/XeMkm23YkenvEC1oOO
	 3CvuupPenLndEXYXh1pEMlYl+hjRsBwtE/ZyQE6Im5TMog3aY/Yu8bRfZQVr/XJDt1
	 I0PnBFsoec25g==
Date: Thu, 3 Apr 2025 22:11:21 -0500
From: Nico Williams <nico@cryptonector.com>
To: Martin von Zweigbergk <martinvonz@google.com>
Cc: Elijah Newren <newren@gmail.com>,
	Git Mailing List <git@vger.kernel.org>,
	Edwin Kempin <ekempin@google.com>,
	Scott Chacon <scott@gitbutler.com>, remo@buenzli.dev,
	"philipmetzger@bluewin.ch" <philipmetzger@bluewin.ch>
Subject: Re: Gerrit, GitButler, and Jujutsu projects collaborating on
 change-id commit footer
Message-ID: <Z+9N2REkYZhrbkzb@ubby>
References: <CAESOdVAspxUJKGAA58i0tvks4ZOfoGf1Aa5gPr0FXzdcywqUUw@mail.gmail.com>
 <CABPp-BFRz-yjnti4W17AEBozb0v52kmNsgTLUZW6-MF34R-xdw@mail.gmail.com>
 <Z+7PDi5y4wXJBK4r@ubby>
 <CAESOdVAd+X=6nEULHtKKotH_W5yNaJAcUajRU79EuG+0SF3m1A@mail.gmail.com>
 <Z+8IF67AC8gSouYc@ubby>
 <CAESOdVAWWP=Rte4bx3zUZc6p0XiZaJS2OZr8ezRPkfq8K1TYfw@mail.gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAESOdVAWWP=Rte4bx3zUZc6p0XiZaJS2OZr8ezRPkfq8K1TYfw@mail.gmail.com>

On Thu, Apr 03, 2025 at 03:47:30PM -0700, Martin von Zweigbergk wrote:
> I think part of the problem is that I didn't consider that Git doesn't
> really like to work in detached HEAD mode and doesn't automatically
> update refs pointing to rewritten commits. This does take away a lot
> of the usefulness, unfortunately. It would still be a bit useful as an
> argument to readonly commands.

I work in detached HEAD mode almost all the time.  And yeah, Git won't
update refs when in detached HEAD mode because... what ref should it
update?  The whole point of detached HEAD mode is that it does not.

> > What would `git switch <change ID>` do?  `git switch` switches between
> > branches, but a change ID can't possibly identify a branch since many
> > commits could exist with the same change ID all in different branches.
> 
> Yes, the same change id *can* exist on many branches, but it's pretty
> uncommon. It might happen after cherry-picking, depending on what we

The whole point of change IDs for me is that if I need to backport bug
fixes [0] then I can identify the bug fixes by change ID and then
cherry-pick them onto support branches, which means that yes, there will
be many commits with the same change ID, each on different branches.

Besides backports another use case that leaves multiple commits with the
same change ID is when I'm working on multiple different approaches to
implementing some feature on a complex codebase.  I might have two or
three branches exploring different ways to implement some feature, and
of course I would want to use the same change IDs for similar commits
even if I didn't use cherry-pick to create all but the first.

Here's a third use-case that's quite real for me at $WORK where I have
repos for Debian-style packaging and use different branches for
different OS releases.  Some such pkgs are ones that we patch locally,
so each release-specific branch targets a different OS release, but they
all mostly have the same contents, in which case this is similar to
backports.  Other pkgs are locally developed and rarely differ on
different OS releases but occasionally they have to for <reasons> --
this is not similar to backports.

[0] Granted, the industry has moved away from backports.  But many open
source projects still backport security fixes.  E.g., OpenSSL,
PostgreSQL, etc.  So this is relevant.

> decide there, but it should very rarely happen in other cases. When
> you rewrite a commit, the old commit usually becomes unreachable, so
> if your change id resolved to one commit before the rewrite, then it
> will resolve to one commit after the rewrite. [...]

No matter what you will not have a guarantee of one commit for any given
change ID.  Therefore `git switch $change_id` is not workable, not
without interaction, and even then still not workable because Git might
have to search _many_ branches to find commits matching the given change
ID.  (Fossil could have an index on change ID and trivially make that
search possible, but for Git adding an index is more complicated.)

> > I'd expect many commits with the same change ID in a _repo_, but at most
> > one in a _branch_.
> 
> There may be multiple commits with the same change ID in a repo if you
> had cherry-picked the commit, depending on what we decide to do with
> the change ID on cherry-pick. But cherry-picks are not very common
> anyway. Or maybe it's common in some workflow? Oh, are you thinking of
> a scenario where you cherry-pick your own commit to see if an
> alternative approach is better? Sure, if cherry-pick preserve the
> change ID, then you would have multiple commits with the same change
> ID in that case.

Even if cherry-picking were not common it's supported, therefore you
can't have change IDs be unique like this.  That doesn't make change IDs
useless -- on the contrary, their utility comes from the fact that they
are not repo-wide unique!

Nico
-- 
