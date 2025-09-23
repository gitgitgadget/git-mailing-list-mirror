Received: from cloud.peff.net (cloud.peff.net [104.130.231.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8575327EC80
	for <git@vger.kernel.org>; Tue, 23 Sep 2025 17:48:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=104.130.231.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758649709; cv=none; b=GYsV1mlfy4mLqaPtKIxPVqIrtIMghHzFLf5yRgN45p5tppHgtw1PvrAnGXtVCuNJpZ6riqabOQS/H9bD7LPXqD4xwT+YxxxKA/xnrPWIBWNOL77ZDaj3POXZcUT0U6AXNnepVAYjC3VcYN8MJH7l1N6pvPT15FwnpgvH/2EUI8M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758649709; c=relaxed/simple;
	bh=ZnlwPW3AaoNVW1W+1p7cl9wqalH0QyzmO56oVmg6O9c=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=XFPpgzMGNfUCIJ2t0PcqUwGEaMwkMgIejLR0q8LxE96jYc9r8NeBR2Q6L8NUsL0SVTr+s3lRWXO+51Vm/TRSBkBPCwgvGyl0tv76WCvpaWRAvWFiyeD8eIQtvFcd0/uE1i4GBewOcyDVQ9yXn8ags6VMXi0Uo6S+hq4z0mf5xdE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=peff.net; spf=pass smtp.mailfrom=peff.net; dkim=pass (2048-bit key) header.d=peff.net header.i=@peff.net header.b=NKMngtFz; arc=none smtp.client-ip=104.130.231.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=peff.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=peff.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=peff.net header.i=@peff.net header.b="NKMngtFz"
Received: (qmail 8267 invoked by uid 109); 23 Sep 2025 17:48:26 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=peff.net; h=date:from:to:cc:subject:message-id:references:mime-version:content-type:in-reply-to; s=20240930; bh=ZnlwPW3AaoNVW1W+1p7cl9wqalH0QyzmO56oVmg6O9c=; b=NKMngtFzE6FEecR1SGCJrFSrxnjxfBYm4Mpph9+BJptRzotjgr0GqMPr44XJxAoXBlKweU6jDhrO6EBHzWRl5PQXrISI8UI02EWbSMEM/Ez+EzYGE1HE1F9jEouI2rGqC6dBTCGz0Ox3AM/BkBJMKG2/LNxS340n8tieUKFsQJbB2PaBPEHY8gHnv/wCh6wJYtWdvmbOdH6uRPpOJE98nzXCgrG5VZdj/a0gr89pVAsNx/e+q7xBwUrE1OjkxaF82tx9FX6AOfE3/YxhsKKwtXlfHCcc5lgDAXTQh3nSjaui+xheL6lnvF35X2coR8SFhkUPY4XKuv/JzY80aaABEw==
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Tue, 23 Sep 2025 17:48:26 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 11795 invoked by uid 111); 23 Sep 2025 17:48:25 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Tue, 23 Sep 2025 13:48:25 -0400
Authentication-Results: peff.net; auth=none
Date: Tue, 23 Sep 2025 13:48:25 -0400
From: Jeff King <peff@peff.net>
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Cc: Phillip Wood <phillip.wood123@gmail.com>,
	Ezekiel Newren via GitGitGadget <gitgitgadget@gmail.com>,
	git@vger.kernel.org, Elijah Newren <newren@gmail.com>,
	Ezekiel Newren <ezekielnewren@gmail.com>,
	"brian m. carlson" <sandals@crustytoothpaste.net>
Subject: Re: gitoxide-compatible licensing of Git's Rust code, was Re: [PATCH
 6/7] xdiff: conditionally use Rust's implementation of xxhash
Message-ID: <20250923174825.GB1136654@coredump.intra.peff.net>
References: <pull.1980.git.git.1752784344.gitgitgadget@gmail.com>
 <5a959c9bdad79cf972b95dcf4324135dd7c94dac.1752784344.git.gitgitgadget@gmail.com>
 <5596e569-6632-c2b1-37af-a978de5408cd@gmx.de>
 <dd3a7ab0-947b-4592-a086-8c7028f02ffd@gmail.com>
 <9818dc92-3569-3e6f-0252-245c2bf0bf84@gmx.de>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <9818dc92-3569-3e6f-0252-245c2bf0bf84@gmx.de>

On Tue, Sep 23, 2025 at 11:57:18AM +0200, Johannes Schindelin wrote:

> It would not even take more than something as simple as GPLv2+exception.
> We do have prior art for that: The Git project itself suggests in its very
> own `COPYING` file to use the following license in new files:
> 
>         This file is licensed under the GPL v2, or a later version
>         at the discretion of Linus.
> 
> Note the exception? For new Rust code (and of course excluding code that
> has been ported verbatim from GPLv2-licensed code), GPL v2 could be used
> with an exception along these lines: This file is licensed under the GPL
> v2, with the exception that it can be freely used in the Gitoxide project.

I think this "and of course" parenthetical might be a sticking point.
Obviously taking the code verbatim and re-licensing it is not allowed.
But I think even reading the C code and then writing substantially
similar Rust code may be legally questionable. The Rust code under the
more permissive license has to either be clean-room, or have permission
for re-licensing from the original authors (which is getting to be all
but impossible over time as code ends up being touched by many people).

I think this is the same issue that libgit2 ran into. If it were just a
matter of porting over and re-writing new features, more of it would
have been done. But for code to come under the new license it can't just
be a port, but has to be an independent work.

So I wonder if this just creates the same awkward silo between Git's
Rust code and its C code (that we already have between Git and libgit2).

> I am not a lawyer (which everybody but laywers are nowadays required to
> say), therefore this likely needs some tweaking.

Me either. I do like the goal you're trying to accomplish, but I worry
that it will end up causing headaches down the line. Even if we, the
developers, are a bit permissive about what constitutes "porting" and
don't require a clean-room implementation, this kind of thing scares off
the legal teams that approve using the Rust modules in bigger projects.
IIRC Microsoft put in a big effort into vetting libgit2's provenance
before agreeing to use it in Visual Studio.

-Peff
