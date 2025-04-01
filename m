Received: from cloud.peff.net (cloud.peff.net [104.130.231.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D50741EA7C1
	for <git@vger.kernel.org>; Tue,  1 Apr 2025 09:29:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=104.130.231.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743499797; cv=none; b=gS44z4OlnZHdWq9lYPwAWQZ60MSR2dxho8k1zbUc3zmznKxmHyZgcxi0xbLbMhShY9ekR6zUGsgWjpe2VR0i5zzvTykz5gAzacoS9s0Nx6dgEhAiLUnid5iUuS8RL9eBYGCm8k3yOzQW3ZmYeZqZosX14E5+hnGFTJaUYdSPt60=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743499797; c=relaxed/simple;
	bh=9LDDmPgNEu348xZsLTatSZXM0Eb5+Tw6/179fXhh7w0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=FiMf3X1ww48Bv9aXC5+5qPeJ32Z8gijN2zv1z0MAf1x2sganDnqWwtBurm7NuqpBlSevPnM73Y4QZhRc9pAmBCHtLsVqGo57rjYrVFSyvFPUUKNDMV4jynoALVpz9irY0asywxLlt/xzmnSqo6GTDo6FiBqHRaOBVH1EsPuLYuQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=peff.net; spf=pass smtp.mailfrom=peff.net; dkim=pass (2048-bit key) header.d=peff.net header.i=@peff.net header.b=B9aAGfXP; arc=none smtp.client-ip=104.130.231.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=peff.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=peff.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=peff.net header.i=@peff.net header.b="B9aAGfXP"
Received: (qmail 21130 invoked by uid 109); 1 Apr 2025 09:29:53 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=peff.net; h=date:from:to:cc:subject:message-id:references:mime-version:content-type:in-reply-to; s=20240930; bh=9LDDmPgNEu348xZsLTatSZXM0Eb5+Tw6/179fXhh7w0=; b=B9aAGfXPCTAjl9OTYaCkY6pOG7NtCL1pRdUf6UwWBYYBBNNHGZ7VlrK1Aih2x/G6JgmNg3YYiUcoYjZTLw2hY8ShVI+SJI81dH0UwelzGw1YAUSrAEr61hp5ewhXyVvB/iAfIWrA9dEO0EsHERuh+p4IRbfAWGXTCZ9CJ/SalZXDcNL0HP+qckvoW94E78a9N9QRs6D4jn7k54XTdnztEtrCLXciEpRpiBZzJMECMI38cMqWv5a6kXbA4kGuYJ5EsW2hXdV5NcAsUFuLSUOom7h7TTjGgQUcnb/KzyKvfkrZgi8ZJBeSnJ7Ith2vmT6++XDbh2CM/Bdl27v8Hmyk7g==
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Tue, 01 Apr 2025 09:29:53 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 16854 invoked by uid 111); 1 Apr 2025 09:29:53 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Tue, 01 Apr 2025 05:29:53 -0400
Authentication-Results: peff.net; auth=none
Date: Tue, 1 Apr 2025 05:29:52 -0400
From: Jeff King <peff@peff.net>
To: Taylor Blau <me@ttaylorr.com>
Cc: Toon Claes <toon@iotcl.com>, git@vger.kernel.org,
	Patrick Steinhardt <ps@pks.im>,
	=?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
Subject: Re: [PATCH 0/8] Introduce git-blame-tree(1) command
Message-ID: <20250401092952.GD21089@coredump.intra.peff.net>
References: <20250326-toon-blame-tree-v1-0-4173133f3786@iotcl.com>
 <Z+Rl43VR3ErE0Bu4@nand.local>
 <20250327063243.GB3042475@coredump.intra.peff.net>
 <Z+XJ+1L3PnC9Dyba@nand.local>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <Z+XJ+1L3PnC9Dyba@nand.local>

On Thu, Mar 27, 2025 at 05:58:19PM -0400, Taylor Blau wrote:

> On Thu, Mar 27, 2025 at 02:32:43AM -0400, Jeff King wrote:
> > The pathspec-trie stuff is, I think, still a reasonable idea for general
> > use. But IIRC, the rewritten blame-tree you guys worked on does not
> > benefit from it, because it ditches pathspecs entirely (both because
> > they're too slow without the tries, but also because it's important to
> > continually narrow the pathspec while traversing). That trie code was
> > never run in production, I think (and I see there is a patch to narrow
> > the pathspec while traversing; I suspect that likewise was never used).
> 
> Yeah, the rewritten blame-tree code uses changed-path Bloom filters to
> narrow the set of revisions that we need to actually compute tree-diffs
> for.
> 
> The general idea is that we have a set of paths that we have yet to
> blame, and those are the "interesting" ones. IOW, if a changed-path
> Bloom filter tells us that we are at some revision where there is maybe
> a change to one or more unblamed paths, we need to compute a tree-diff.
> But if the Bloom filter says "no", then we can skip the tree-diff at
> that layer entirely.

You'd still in theory benefit from the tree-diffs you _do_ run using a
continually narrowing pathspec. Skimming over the code from your
tb/blame-tree branch, it looks like it's just fed the original pathspec.
But that's probably good enough in practice. Especially for
non-recursive blame-trees, where pruning already-matched entries will
never save you from opening another tree anyway.

> > So yeah. I don't know if all of this is really a very good starting
> > point. Taylor, if you can share the current code that GitHub is running,
> > I think that would be beneficial for the community.
> 
> Sure. You can fetch from the 'tb/blame-tree' branch from my tree (which
> is located at 'git@github.com:ttaylorr/git.git'). I owe a huge "thank
> you" to Victoria Dye, who split out the various topics from GitHub's
> fork into individual rebased branches.

Thanks. I don't have time to pick it up as a topic myself, but hopefully
it can be useful to Toon (or any others interested in the topic).

-Peff
