Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=217.216.95.84
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793907797;
	b=P/Y349llf5JZci6lEshTR0+5HrKll8a78SQmwUUBQVvWUn6o6qJUMVZA1gMbEpX0fTPV
	 MjMGTkKXlD0bwFO8Y7VTe52pBqzfLttWW5Hxgv/UDV7QZPff0l8NnlBIUmg4BtKB/Amui
	 gAlQN+W0NM9+cWM44drV1PV9SkL4gMAinLpG7UPrpO03zN/aRVbOSFtj6sqF6fyYu1vvp
	 NwqTO793r0V98aa72u2RnvvT7wxuOVu7ra6XCVH3rOYLxgmoE1sZ5H0k1BQg8njTU4Dyb
	 yeOZHRUR690aWlNX3jvOSkpsk9o9b6iITc2W8jCqwFA46cNtotVL++BnBHVLuIXgi7g==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793907797;
	h=DMARC-Filter:Received:DKIM-Signature:Received:Received:Received:Date:
	 From:To:Cc:Subject:Message-ID:References:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To;
	bh=XPGFWO8fOQByD7vJN9FsR5gg0CnhzYCMoM6KLpEdIzs=;
	b=y5BXUwFJ0cHpQJ3aANwTttPGCdN2WZuM9DNByuRHYd+e1FumZ/1WzsoUWmmqqOeNN8Js
	 v2zZ+0DYKJuNSjHYLWJuhZ59DriHpEh5q70eq4on5+HAH0A1nmNLUoi+X6ien/6pZ23ou
	 ktYlqd/Gd+e/p5PVk960UHCtQGzEgExAPVOpsrNbgmfsIqJUjVUw9Pv/6pphMawKKAQZj
	 5ByPmfn0egeHwhv+9zA4iTKEI8ZyICYXdeC64JepYdFL5Tmuyqb167se04Mw6RbCydD6K
	 Qr1qKP4ircgK/c73Y5rVHXqr24BNY0tN44ypVXekjDg1qPZ/1WGHvmYeIJnBIGxcoJw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=peff.net;
	spf=pass smtp.mailfrom=peff.net;
	dkim=pass header.d=peff.net header.i=@peff.net header.a=rsa-sha256 header.s=20240930 header.b=AcwIDE2A;
	arc=none smtp.remote-ip=217.216.95.84
Received: from cloud.peff.net (cloud.peff.net [217.216.95.84])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5F2B3606A6C4
	for <git@vger.kernel.org>; Thu,  5 Nov 2026 19:43:16 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 5F2B3606A6C4
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=peff.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=peff.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=peff.net header.i=@peff.net header.a=rsa-sha256 header.s=20240930 header.b=AcwIDE2A
Received: (qmail 31807 invoked by uid 106); 5 Nov 2026 19:43:15 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=peff.net; h=date:from:to:cc:subject:message-id:references:mime-version:content-type:in-reply-to; s=20240930; bh=74TpPSHJ/ehD79b09Hp2NY1Le3mLxRbDTRQnzLlbVX4=; b=AcwIDE2AgBkCkz0osiUqONX7Tb4HSnpTRnKBpp5zdbj/Wgnq8OYydDEbB23D6Qne1SLzIVXscUf4rsggteVsAI4zJPBIqE+LiHMsQULDifpOp/iZHplyXzKkqJ2k57/ZoE9j7SZP2Ha4s1VNsMnHBXAmnIi9kTOdHZflkUe2peqLQWqGpG/ha8ZSEEa/smkkqhZb0+8nmuZrhLxMoCoYlJhwVoUiTJUH5izKuKtpScY/Tdyi07Cvigw65/dpZSfg47RWCRpKiPF9PYhcZgsg7nDd/hV99ciY0pDJ8CRSPQDcENYDS3j+1IsCxch77K4H5hvlUkmZIEvOusThrwvU7Q==
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Thu, 05 Nov 2026 19:43:15 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 62887 invoked by uid 111); 5 Nov 2026 19:43:14 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Thu, 05 Nov 2026 14:43:14 -0500
Authentication-Results: peff.net; auth=none
Date: Thu, 5 Nov 2026 14:43:14 -0500
From: Jeff King <peff@peff.net>
To: Patrick Steinhardt <ps@pks.im>
Cc: git@vger.kernel.org, Patrick Ohly <patrick.ohly@intel.com>
Subject: Re: [PATCH 2/2] odb/source-loose: fix existence checks for newly
 written objects
Message-ID: <20261105194314.GB2898829@coredump.intra.peff.net>
References: <20261104-pks-odb-loose-stale-cache-v1-0-a00d5cdb5e7d@pks.im>
 <20261104-pks-odb-loose-stale-cache-v1-2-a00d5cdb5e7d@pks.im>
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Post: <mailto:git@vger.kernel.org>
List-Help: <mailto:git+help@vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
List-Owner: <mailto:git+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20261104-pks-odb-loose-stale-cache-v1-2-a00d5cdb5e7d@pks.im>

On Wed, Nov 04, 2026 at 01:16:35PM +0100, Patrick Steinhardt wrote:

> This issue can cause git-merge(1) to die in a partial clone because we
> try to fetch an object that we have just written, as reported in [1]:
> 
>   1. `prefetch_for_content_merges()` performs quick existence checks for
>      all blobs that need a content merge to figure out which ones need
>      to be fetched from the promisor remote. These lookups populate the
>      loose object cache for the respective sharding directories.
> 
>   2. We lazily fetch the missing blobs, which writes a new packfile.
> 
>   3. We perform the merge and write the resulting blobs as loose
>      objects. The cache is not updated, so for all blobs whose sharding
>      directory was populated in (1), the object existence checks will
>      fail.
> 
>   4. When checking out the merge result, `prefetch_cache_entries()`
>      performs existence checks for all index entries that need to be
>      written to the worktree. But due to the stale cache, the merged
>      blobs are reported as missing, and consequently we try to fetch
>      them from the promisor remote. This fetch fails because the remote
>      will most likely not have them.

I don't doubt this sequence of events, but it feels like it is pointing
to a separate underlying bug.

Anybody who is passing QUICK should be prepared to get a false negative
and recover reasonably. That's what QUICK is for. And anybody who is not
passing QUICK will not use the cache (as you note, they do not use the
cache at all, but it would also be reasonable to use it and fall back to
a refresh).

So it sounds like somebody is using QUICK who should not be in this
path. At first glance, it makes sense for prefetch_cache_entries() to be
QUICK: it is just a prefetch, so it's happy to get a wrong answer.

But as we've seen, a false negative here can be a problem because it
actually tries the fetch. The most obvious issue is the one we saw here:
if the fetch fails because the object is in fact local-only, then rather
than say "oh well, I guess it is not something we can pre-fetch" we barf
at the lower level, in promisor_remote_get_direct(). It feels like that
low-level function should be informed that the caller is in "false
negatives are OK" QUICK mode and quietly return failure.

But even that is tricky. Our fetch request is all-or-nothing, so one
missing local object means we can't prefetch anything. Not great. Plus,
even a quietly-discarded fetch attempt is expensive to do, when we could
much more cheaply get the object by just looking again at the
filesystem.

So I kind of wonder if prefetch_cache_entries(), along with any caller
doing an OBJECT_INFO_FOR_PREFETCH check, ought to omit the QUICK flag.
It would mean that the normal case of having missing partial objects
(about to be fetched) would cause us to re-scan the local pack list, but
that's not _that_ expensive, especially compared to the fetch we're
about to do.

Possibly we'd want some logic to avoid doing the re-scan for every
object (so if you are about to prefetch for a million objects, you don't
want to trigger a million SECOND_READ re-scans, but rather do it once).
That would require some refactoring.

But it would fix this problem, along with any other related ones. In
particular, I think your fix here is leaving lots of cases with the same
problem. Missing our own loose write in the cache is an obvious problem,
but it's not the only reason we might fail to see a local object: it
could be in a pack now, or it could have been written as a loose object
by some _other_ process.

So I suspect you could cause the same problem racily by running "git
log" on some local-only commits while somebody else is repacking, with a
sequence like:

  1. git-log scans the odb and builds an internal packlist.

  2. git-repack runs in another process, migrating loose objects to
     packs. git-log doesn't know about our new pack.

  3. git-log tries to diff a commit. In a non-partial clone, the diff
     code eventually tries to read that object, realizes we can't find
     it, and does a SECOND_READ. But in a partial clone, we try to
     prefetch via diff_queued_diff_prefetch(). That uses the same
     FOR_PREFETCH flag and will try to fetch it.

I'd guess most such cases are going to be racy, though you can imagine
ones that aren't. E.g., if mktree actually did pre-fetching, then
something like:

	for fn in $files
	do
		oid=$(git hash-object -w $fn)
		printf "100644 blob $oid\t$fn"
	done |
	git mktree

might run into similar problems. It needs to know about newly written
local loose objects, but they were written externally. You might even be
able to find a similar case where git-merge ends up writing the objects
via a helper process, but I didn't check.

So I dunno. This is fixing a real case and not making anything worse, so
maybe it is reasonable in the interim. But it's the tip of the iceberg,
I think.

> We could in theory fix this by flushing all the loose object caches
> again, like we used to do before 5946a564cdd. But that wouldn't address
> the root cause: the cache would still be stale unless somebody does a
> non-QUICK read for a missing object. Instead, fix the bug by updating
> the cache whenever we write a new loose object.

I agree that the object cache flushing was only fixing this problem by
chance. But I think it might be worth reconsidering the change from
5946a564cdd. Flushing the cache (or not) should always be an
optimization problem, not a correctness one (assuming the rest of the
code is bug-free and using QUICK sensibly). But a SECOND_READ fallback
is a good indication that information about our odb is stale, and it's a
good time (from an optimization perspective) to flush them.

  Side note: I do think there is a correctness problem with caches going
  the other way, with false positives. We might say "we have object X"
  because we saw that it was loose earlier and cached the result, but a
  simultaneous maintenance job then pruned it. So imagine something like
  a fetch, where we opportunistically optimize by saying "oh, we already
  have X".  Later, when it turns out we don't, the fetch fails, even
  though it _could_ have succeeded if we realized from the start that we
  didn't have it.

  But that is a general problem with racy pruning in Git, and it affects
  both packs and loose objects. Nor would flushing the caches solve it
  (though it could help reduce the race window in some cases).

  So not something to solve here, but I just wanted to qualify my "cache
  flushing should never affect correctness" claim. :)

-Peff
