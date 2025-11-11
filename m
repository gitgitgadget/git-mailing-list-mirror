Received: from cloud.peff.net (cloud.peff.net [104.130.231.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 879A5316918
	for <git@vger.kernel.org>; Tue, 11 Nov 2025 19:15:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=104.130.231.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762888522; cv=none; b=mqgSGOCOrw4z1Jm4HDe8dpS54Tb1CjbmIWJru8bxldqVhKyp+YeWdAugLsCP82NvLAggD//pHZfGgDHtUfeUV0SUy6S9JFfiO/ESG1qFX6SDLqbDQnMl8JJ3cu65AnJwnfO/TyiH0ZMaGpHycEQmEz441U0BjEjYMMOOvbHOBa4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762888522; c=relaxed/simple;
	bh=ANgdxBb37Dn7Qk0OwkQZe26NWX37OaGpCUrvRf9Q1cg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=C++Hr6NNDZ2jlSdabOrM5xtz8rwXYxvKgz34JP9POW6OIgrZMwCsTA4y6qCmX3VlOUBwntpnnpWLoYspu0CwNUw4zowTgorNCyqvpv4O3KwbghXl2PdHY8Um0WilxqXnQCgBMIEbndo8KTUaKZFvGIbjFRsW7B1U4sXaw8lKbrk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=peff.net; spf=pass smtp.mailfrom=peff.net; dkim=pass (2048-bit key) header.d=peff.net header.i=@peff.net header.b=M/pJtC09; arc=none smtp.client-ip=104.130.231.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=peff.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=peff.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=peff.net header.i=@peff.net header.b="M/pJtC09"
Received: (qmail 489252 invoked by uid 109); 11 Nov 2025 19:15:13 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=peff.net; h=date:from:to:cc:subject:message-id:references:mime-version:content-type:in-reply-to; s=20240930; bh=ANgdxBb37Dn7Qk0OwkQZe26NWX37OaGpCUrvRf9Q1cg=; b=M/pJtC09BSzaRt/ESFfhCv3zvBVGmkW8oiQmPM/uioTd+RAO78UOTWx/P46amE+zhMt15xPZ9K+ld+WC7CfCQH7RG95PcuP4ZJd+PnE5QZZERAg971xhMfqlJGwNmGfDmhgF9V1Bue7u8t71eZpVlMoAeh1N02DG1ONXv1VMgwwOme5uYw7UdWncHaVIhjGT99FOlnTixx4uGQT28CiN/AwhfF7jPZO1cBa12rux2ZmPaEKRwjeVUjhvnlgm2+6w/STZQcYa9X2GuwstLCQ4Z0lkBcSaN0a/jqiOn170Tr7KyUwKt2Jlt+G0GC/uLqanQgHPL1ZKZOnwM+NEyok9KA==
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Tue, 11 Nov 2025 19:15:12 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 778823 invoked by uid 111); 11 Nov 2025 19:15:09 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Tue, 11 Nov 2025 14:15:09 -0500
Authentication-Results: peff.net; auth=none
Date: Tue, 11 Nov 2025 14:15:08 -0500
From: Jeff King <peff@peff.net>
To: ZheNing Hu <adlternative@gmail.com>
Cc: "brian m. carlson" <sandals@crustytoothpaste.net>,
	phillip.wood@dunelm.org.uk,
	ZheNing Hu via GitGitGadget <gitgitgadget@gmail.com>,
	git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] commit: add --committer option
Message-ID: <20251111191508.GA1907007@coredump.intra.peff.net>
References: <pull.1997.git.1762683774166.gitgitgadget@gmail.com>
 <6be20c41-15a0-4732-bd12-4927a59a9f59@gmail.com>
 <aRIoleD6nP-kA4Xn@fruit.crustytoothpaste.net>
 <20251110201136.GB127132@coredump.intra.peff.net>
 <CAOLTT8RweGOmxNK=vKDv8w-8AJM7QUfLBw4WOKeY1EpSVeB6iQ@mail.gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CAOLTT8RweGOmxNK=vKDv8w-8AJM7QUfLBw4WOKeY1EpSVeB6iQ@mail.gmail.com>

On Tue, Nov 11, 2025 at 09:42:38PM +0800, ZheNing Hu wrote:

> > Is a "--committer" option the best solution there, though? I'd think
> > you'd want to set user.* in the repo-level .git/config (or using a
> > dir-specific include) would be less error-prone.
> >
> > That doesn't help for using two identities for the same repo, but in my
> > experience it is easier to use two separate repositories for that to
> > match the organization of the work (even if you may sometimes fetch
> > between them).
> >
> > I'm not totally opposed to the new flag, and in general I'd defer to
> > people who say they find a new feature useful. I'm just having a hard
> > time imagining a scenario where it's the best option.
> 
> Sometimes it's because I forgot to configure the repository-level git user
> config and started development first. Only when I tried to correct the
> committer did I feel the pain.

OK, this workflow does make sense to me. Fixing up an earlier mistake is
inherently a one-off thing, and a command-line option is more ergonomic
than using the environment variables.

Two small thoughts:

  - I suspect what you'd usually want there is for the committer and the
    author to match. We have --committer-date-is-author-date for rebase,
    and conceptually I think something like --committer-is-author would
    do what you want here. But obviously it's less flexible, and I don't
    know if it's that much easier to use.

  - Because it's easy to make such mistakes, when you override the
    author (so that it doesn't match the committer), git-commit prints
    an extra "Author:" line in the output to make that more obvious.
    Should we do the same with committer when you've overridden it?  We
    already do print "Committer:" when the ident was guessed from system
    info, but I wonder if it would make sense to print when it was
    forced. I dunno. I guess the time you most need the hint is when you
    meant to use --committer and --author together, but only used
    --author. But I don't know how Git would infer that case (versus the
    normal case of you applying someone else's work and crediting them
    with --author).

I'm not sure if either is a useful direction, but they seemed
sufficiently not-dumb for me to at least type them out. ;)

-Peff
