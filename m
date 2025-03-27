Received: from cloud.peff.net (cloud.peff.net [104.130.231.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 184E2AD4B
	for <git@vger.kernel.org>; Thu, 27 Mar 2025 06:32:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=104.130.231.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743057168; cv=none; b=WSavw79shWGz4V/4vF3edfdO0lm+uuVptCf5O5+3jdrp3YrySjSaE/DqnhjhLcFMDqW5JXG/OuyPaWpsBAvFuFjhgMbQkc0Fs34vspbq/4qyKkG9SWzIVzpS+2EgE5f4Kpv5QOsXQrnReThN6J3uyuI5FWvjRvapMH+synJwdx0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743057168; c=relaxed/simple;
	bh=3cX6bji7m7D9EJJHjWi1Pw8rAw82kciYJe4sMNVk5Ts=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=jna4OFx1z8BUVS5seEwZ1fjuXldfKyLFnzGn/VbYogJLkXV/UH7pgAtrz/Jnsvxv0qLGYCzix3Z9mESCiAR7K2Hp6LJN2oj+6GhvnzuSexcBRNEYrM0P/5jHOfzMXpR8o8sAIqNAmhaug/ud+tdjrKPh/X5g5j1txptDuoA4SpQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=peff.net; spf=pass smtp.mailfrom=peff.net; dkim=pass (2048-bit key) header.d=peff.net header.i=@peff.net header.b=QCX37PsJ; arc=none smtp.client-ip=104.130.231.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=peff.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=peff.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=peff.net header.i=@peff.net header.b="QCX37PsJ"
Received: (qmail 19437 invoked by uid 109); 27 Mar 2025 06:32:44 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=peff.net; h=date:from:to:cc:subject:message-id:references:mime-version:content-type:content-transfer-encoding:in-reply-to; s=20240930; bh=3cX6bji7m7D9EJJHjWi1Pw8rAw82kciYJe4sMNVk5Ts=; b=QCX37PsJ0YhFDHj5AWK5mDEWZLkLvscsRCrEkyresWFPZob4oeYXazhECgFYSvj5HBdSKkk5ajNazXdMyWC77eCJ6xXHYg7OsaSAujiWNsKN2nImRDI/nb7Fqvw/NaHZSKVVwk7edtm8gclvd+a9VHcrGsq1HqTibg1ID6S2GJfS7L7tb1VVSqcqhjAr2jTLjuRqJU4Zv0sQJMx6pxz7YgYK5f0vDRCnPzM501VqH1RcRdd7rGA9e7+cFTHV56hsU8EhwMfsl2wVp69F0w9uuBJvoXfFRmQi9CbadPySU8XhMGzK3QhfSd7JM6mKoaUeA1p1rYyVRj6Tdn5uhMhFZg==
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Thu, 27 Mar 2025 06:32:44 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 27833 invoked by uid 111); 27 Mar 2025 06:32:44 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Thu, 27 Mar 2025 02:32:44 -0400
Authentication-Results: peff.net; auth=none
Date: Thu, 27 Mar 2025 02:32:43 -0400
From: Jeff King <peff@peff.net>
To: Taylor Blau <me@ttaylorr.com>
Cc: Toon Claes <toon@iotcl.com>, git@vger.kernel.org,
	Patrick Steinhardt <ps@pks.im>,
	=?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
Subject: Re: [PATCH 0/8] Introduce git-blame-tree(1) command
Message-ID: <20250327063243.GB3042475@coredump.intra.peff.net>
References: <20250326-toon-blame-tree-v1-0-4173133f3786@iotcl.com>
 <Z+Rl43VR3ErE0Bu4@nand.local>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <Z+Rl43VR3ErE0Bu4@nand.local>

On Wed, Mar 26, 2025 at 04:38:59PM -0400, Taylor Blau wrote:

> On Wed, Mar 26, 2025 at 09:18:24PM +0100, Toon Claes wrote:
> > This is yet another attempt to upstream the builtin command
> > `git-blame-tree(1)`. This command is similar to git-blame(1) and shows
> > the most recent modification to paths in a tree..
> >
> > The last attempt (I'm aware of) was made by Ævar in 2023[1]. That
> > series was based of patches by Peff written in 2011[2].
> 
> For what it's worth, the blame-tree implementation that this came from
> has evolved significantly since it was originally written in 2011. Most
> recently Stolee and I worked on a version that uses changed-path Bloom
> filters to narrow the search, passing un-blamed paths to their parents
> at each level of the traversal.
> 
> I wonder if it would be easier to start from scratch with the modern
> implementation rather than land this one and try to build on top of it.

Yeah, I'd suggest starting with that work from you and Stolee (though I
do not know if it was ever made public?). It should be much faster and
will have been battle-tested in production.

The pathspec-trie stuff is, I think, still a reasonable idea for general
use. But IIRC, the rewritten blame-tree you guys worked on does not
benefit from it, because it ditches pathspecs entirely (both because
they're too slow without the tries, but also because it's important to
continually narrow the pathspec while traversing). That trie code was
never run in production, I think (and I see there is a patch to narrow
the pathspec while traversing; I suspect that likewise was never used).

The max-depth diff code is also in theory a reasonable thing to have in
general. But it is awkward to use, and not really necessary for
blame-tree. There we really only care about recursing vs not recursing,
but the usual "recursive" flag for diffing isn't enough (we have to
recurse down to the tree of interest, but may not want to go further). I
don't remember how that is handled in your blame-tree rewrites.

So that really mostly leaves the blame-tree scaffolding itself. I
remember Junio left a lot of good comments on the original thread on how
merges should be handled, but I don't think I ever fixed those bits. I
don't recall what your rewritten code does there, but I think it may
have improved things.

So yeah. I don't know if all of this is really a very good starting
point. Taylor, if you can share the current code that GitHub is running,
I think that would be beneficial for the community.

-Peff
