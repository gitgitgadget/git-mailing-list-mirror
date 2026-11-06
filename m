Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=103.168.172.153
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793963812;
	b=pcEyHbiWG0+sRGYd5Q6vs+DyuoN1ol5RATFEGG79slv2l/QNSTzlsrshnRyalbX7Gb3O
	 h+S7it0OGouvB8p06doAoi9GomuaKEmIfC87KQzcNjKehD+5zN62gjDlKzZZvoeFlqcLx
	 Z/qQMcL8+Snnrqv6TIXu9zmdtjgNEFpafPjDUazE9GDIYm8FneNY4vPqKy3LQ6L+/i+cq
	 +lflP85IoGWIseqmqYPrY5AiSR3N9vs4UbZgTMADw/h4i8fkEHHJgdCXxGxnkJo29xOAw
	 1rbqbnT0Hzw6VBQ2Q9OP95/lRvBnHNC5KkDTFeCV1KXOcFNJanj6LYzAUsdxdQGP/+Q==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793963812;
	h=DMARC-Filter:Received:Received:DKIM-Signature:DKIM-Signature:
	 X-DKIM2-Info:DKIM2-Signature:X-DKIM2-Info:Message-Instance:
	 X-ME-Sender:X-ME-Received:X-ME-Proxy-Cause:X-ME-Proxy:Feedback-ID:
	 Received:Received:Date:From:To:Cc:Subject:Message-ID:References:
	 MIME-Version:Content-Type:Content-Disposition:In-Reply-To;
	bh=3g7toC8Sv+pI9+k5VtnNYf3VgWuwOe2EOU08UcVLPjw=;
	b=fZp80eQXFGmovZ7zJYdoroX0ge93kcP7wBnRe1xothN2We2jQSZtQsgEAXh/lVo8yNUC
	 3xttwsye7cTwVATxr/tS3r84keBbADfNAow4AgwrTBsdeNwuXIRWEqD9+cMVp2gQ9ORvm
	 Ll9ROiGjRwqmmFEoZwqKUFKQc+u6R48I+jx+MzuMZJ4zcCly1bA559KqlgEkq4duDOWTM
	 JJB16NSAh1uYtzmoCWp0MzcI8vriWFTwJCzoS0+vOxZSDOUV2VFb1rgfATBRLp/kIi1hn
	 m8uS2zIE3wttiQw+2JKO2truQA5aJuo7j6DUaRj11BLUxz7rSnVBPgpfr71jhHdnEYw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=pks.im;
	spf=pass smtp.mailfrom=pks.im;
	dkim=pass header.d=pks.im header.i=@pks.im header.a=rsa-sha256 header.s=fm3 header.b=0PSNlbOK;
	dkim=pass header.d=messagingengine.com header.i=@messagingengine.com header.a=rsa-sha256 header.s=fm3 header.b=mQDZZqN4;
	arc=none smtp.remote-ip=103.168.172.153
Received: from fhigh-a2-smtp.messagingengine.com (fhigh-a2-smtp.messagingengine.com [103.168.172.153])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 31CF9606A32C
	for <git@vger.kernel.org>; Fri,  6 Nov 2026 11:16:52 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 31CF9606A32C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=pks.im header.i=@pks.im header.a=rsa-sha256 header.s=fm3 header.b=0PSNlbOK;
	dkim=pass (2048-bit key, unprotected) header.d=messagingengine.com header.i=@messagingengine.com header.a=rsa-sha256 header.s=fm3 header.b=mQDZZqN4
Received: from phl-compute-06.internal (phl-compute-06.internal [10.202.2.46])
	by mailfhigh.phl.internal (Postfix) with ESMTP id 72DD214000E5
	for <git@vger.kernel.org>; Fri,  6 Nov 2026 06:16:51 -0500 (EST)
Received: from phl-frontend-04 ([10.202.2.163])
  by phl-compute-06.internal (MEProxy); Fri, 06 Nov 2026 06:16:51 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1793963811; x=1794050211; bh=3g7toC8Sv+
	pI9+k5VtnNYf3VgWuwOe2EOU08UcVLPjw=; b=0PSNlbOK7ynzjdoRM5nRs9A2hy
	JYcrH2sa4FyIwB/KrapOxPJ7v6vmNiUktL0VI1Jnh+lGm1j186mKS0p3YasZQo+/
	8VxlHbGtWv0S25S+sf4X+B+bJdepCv2RB47/oI4wDF+zn63aanPh8ychmPtDL9ZJ
	3XY50zV1I8md0KS6dysF6xTABzesdrm+IkWQOhFNCMvOpBXsc8kvRKgr2+U8gbn2
	f4wZh3Bb5OQGI+G3oxrPu+lllKhz20nHUwPya2qV2BkJFYPu7pV3Yx7dAawd2+gb
	EZHHICChDliOeHce+XVzJiXb8BVcQ9Qk5xBaf+OfApUqx9J58FTZbDbWpRww==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
	1793963811; x=1794050211; bh=3g7toC8Sv+pI9+k5VtnNYf3VgWuwOe2EOU0
	8UcVLPjw=; b=mQDZZqN4t2v3s1f0TyuqZxr/gV+wfZ2+1mPtQxK45xgVP4uxcfh
	e+z1GNAjMciQTZqzDwY2UZ77Qn2vSS00Zn5MmMR+JT1z7Mby2NDQjfv51SdDucQ+
	ksBZoAryZHU8ZiKm/fEPLgnslo31Yih7EcLAnl2ibYhJgyIIzgT9jm+1qHieAxhb
	f5bWhmroszGJGmjmhpKcPCbDdKx6bHouZGxTqzG+zWyQUmntFTpzTjfnbyNFi6dP
	ye/LZK0ViXktyfZLHAr+QB6msN5ep+p1tjUJMHE+s/3I/hpz2LUrClrcLK1go2SH
	/qhdT9g9dvN5tXIy1CzwegRSU2MkNwFJzJg==
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-09;
	repo=github.com/dkim2wg/interop; date=2026-11-03; sw=lmtpprox;
	action=sign d=pks.im a=rsa-sha256;
DKIM2-Signature: i=1; m=1; t=1793963811; d=pks.im; mf=PHBzQHBrcy5pbT4=;
	rt=PGdpdEB2Z2VyLmtlcm5lbC5vcmc+;
	s=fm3:rsa-sha256:L0pM/fOEI9lTnnOgl03FIJ3wyYxYmCoF9B57gxqGgaDetrJ
	UH9i0ukrlvm8uLKfEwYM21fY5OCFs+i9X/hekcWLVIs4VSy5cJLj+OQOFgcijLtk
	/dBQnsteUxXXJHMRo1f8IAjMNqq5x7MIfChQ+nTUCOBAYUQslniJZE+3vCGJcahM
	20LNx3VIp8qr3lD5afLUFmEhpDCgS9SG9F9ODH9x1M4s5L/agXdfmXDVhIp7dsNP
	clZJ5i2KiOc/kLQ5TZGGkVC9t2i9ANrGNmVzMxpb6r7QdXL1LRe7TbrLpLUqivZX
	0P1etpNhGMHFW6pcpiuLLCgNmUGF1jIRI1dvJHA==;
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-09;
	repo=github.com/dkim2wg/interop; date=2026-11-03; sw=lmtpprox;
	action=mi-m=1; hc=12;
	hn=cc,content-disposition,content-type,date,feedback-id,from,
	in-reply-to,message-id,mime-version,references,subject,to;
Message-Instance: m=1; h=sha256:vSVaZ1NJsxGuJJedFYQJWFhTBlhjN+vMr85+lPJcjmY=:FM0b45qlfZFtDIerOMSwYe0Ru719TVoZWfvgjah55E8=;
X-ME-Sender: <xms:I7ftasSLmn5z_QwFctPUBG5DX6LkNSbXzhcCzuvPP9Y5ipJxwW4MoQ>
    <xme:I7ftahOS4UP3WOJXISCcB4TOS5DsYH9V0j46lViBRH1SOAUweLzirYmpR6YDrYDv1
    bb1quYv8YozDNZ77nhzJGU-T__SzLRkPWXTzyy5q1RkLm4KpARorOM>
X-ME-Received: <xmr:I7ftanNMSuh9gLsKPlZqXh5-KRXm7QehMh_kRrh14YlGvyP5FDrSkEeB6wCFCXR1mhPd4Q>
X-ME-Proxy-Cause: dmFkZTFwzX4MsbU8yZZZl+y3FfZhDR60gOrU0L8vHjB4Mmt/2jpgetjqII/hcZXeepzRIN
    bODbo5ZiqR9xNE5B7YpG1jMXpSCRjb/V2Tb1W7IVPLId7HQyCBTFdsNYKokYg05I25Q52r
    q66MBjPJC/FKSDSakhdx+VreMplw7heZNybgvwE2Kbl3oian3n0VITFtnfFk+a7qDmX97T
    pgnYCI9XrK4jML1PpyyMUfU7y0ATez2jSn+eKUc7iYqzCbBNYIf3+HbdrSwiEvSy+EMXku
    Tkr8po77Wh32ljY1x0011pL5Yts9qRXFMerBFGdWMAS4EYE8bSz3FnSXxQWB0VrosT4jq+
    3o7FZc07hhX5Vv3QfXMW5Ui8YhutECXNZTuQiKLMMR+ADkwlqyTsvr2hO472dsFBrd8aEA
    I4prE2S+wwCYJ3kgAmcjbjbYOK54DZ+oVuvnKFjSusxCaprzBNZUUQa5RsyXPMIHHWMjol
    1AwneaK9DATWnuafEFiRzCJqF32qtIBF73nYN1eriwv1u1JIDSkSVyF3h/37LJnMeatrEP
    W/Q2yT4ogLEw3NEY/brWww1BTtFdFuAp9ShcCEN4ywUCx5avfMv/MpUS93iqdoJzan/3rO
    yaSQuuuIEuR9xDWe8adQbeuOfZLpT2V6oAP373Y8o66j8mU3CN/JQXCZ3WLg
X-ME-Proxy: <xmx:I7ftaptiIMUcgI52XPRY-vYs-mvk7zSuJ92xdSvJzvzQ1IjH9lUmcQ>
    <xmx:I7ftapW5psJ2nP5d4KG1RkwBFSKxvOr7-9q6-wwYfNWjl5rU5OJGQA>
    <xmx:I7ftaptjpgE827sybyRUya9Y_RGNz9VGc5u-sUl_Izz-THdmrb1U1A>
    <xmx:I7ftatW0DNz6IYR4zcVJmTsQtvDPl8nw3ZHyvlCQIo-BFQm9EfzqsQ>
    <xmx:I7ftallusPr2pOvO7lcJ2wJ0lxjp0_7XX2mWZuwNES14QnuIbG0k0izR>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 6 Nov 2026 06:16:50 -0500 (EST)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id 2c52a747 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Fri, 6 Nov 2026 11:16:49 +0000 (UTC)
Date: Fri, 6 Nov 2026 12:16:46 +0100
From: Patrick Steinhardt <ps@pks.im>
To: Jeff King <peff@peff.net>
Cc: git@vger.kernel.org, Patrick Ohly <patrick.ohly@intel.com>
Subject: Re: [PATCH 2/2] odb/source-loose: fix existence checks for newly
 written objects
Message-ID: <au23Hvzp09yrym9s@pks.im>
References: <20261104-pks-odb-loose-stale-cache-v1-0-a00d5cdb5e7d@pks.im>
 <20261104-pks-odb-loose-stale-cache-v1-2-a00d5cdb5e7d@pks.im>
 <20261105194314.GB2898829@coredump.intra.peff.net>
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Post: <mailto:git@vger.kernel.org>
List-Help: <mailto:git+help@vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
List-Owner: <mailto:git+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20261105194314.GB2898829@coredump.intra.peff.net>

On Thu, Nov 05, 2026 at 02:43:14PM -0500, Jeff King wrote:
> On Wed, Nov 04, 2026 at 01:16:35PM +0100, Patrick Steinhardt wrote:
> 
> > This issue can cause git-merge(1) to die in a partial clone because we
> > try to fetch an object that we have just written, as reported in [1]:
> > 
> >   1. `prefetch_for_content_merges()` performs quick existence checks for
> >      all blobs that need a content merge to figure out which ones need
> >      to be fetched from the promisor remote. These lookups populate the
> >      loose object cache for the respective sharding directories.
> > 
> >   2. We lazily fetch the missing blobs, which writes a new packfile.
> > 
> >   3. We perform the merge and write the resulting blobs as loose
> >      objects. The cache is not updated, so for all blobs whose sharding
> >      directory was populated in (1), the object existence checks will
> >      fail.
> > 
> >   4. When checking out the merge result, `prefetch_cache_entries()`
> >      performs existence checks for all index entries that need to be
> >      written to the worktree. But due to the stale cache, the merged
> >      blobs are reported as missing, and consequently we try to fetch
> >      them from the promisor remote. This fetch fails because the remote
> >      will most likely not have them.
> 
> I don't doubt this sequence of events, but it feels like it is pointing
> to a separate underlying bug.
> 
> Anybody who is passing QUICK should be prepared to get a false negative
> and recover reasonably. That's what QUICK is for. And anybody who is not
> passing QUICK will not use the cache (as you note, they do not use the
> cache at all, but it would also be reasonable to use it and fall back to
> a refresh).
> 
> So it sounds like somebody is using QUICK who should not be in this
> path. At first glance, it makes sense for prefetch_cache_entries() to be
> QUICK: it is just a prefetch, so it's happy to get a wrong answer.
> 
> But as we've seen, a false negative here can be a problem because it
> actually tries the fetch. The most obvious issue is the one we saw here:
> if the fetch fails because the object is in fact local-only, then rather
> than say "oh well, I guess it is not something we can pre-fetch" we barf
> at the lower level, in promisor_remote_get_direct(). It feels like that
> low-level function should be informed that the caller is in "false
> negatives are OK" QUICK mode and quietly return failure.
> 
> But even that is tricky. Our fetch request is all-or-nothing, so one
> missing local object means we can't prefetch anything. Not great. Plus,
> even a quietly-discarded fetch attempt is expensive to do, when we could
> much more cheaply get the object by just looking again at the
> filesystem.
> 
> So I kind of wonder if prefetch_cache_entries(), along with any caller
> doing an OBJECT_INFO_FOR_PREFETCH check, ought to omit the QUICK flag.
> It would mean that the normal case of having missing partial objects
> (about to be fetched) would cause us to re-scan the local pack list, but
> that's not _that_ expensive, especially compared to the fetch we're
> about to do.

Yeah, that's a valid point. Honestly, by now I'm almost urged to just
drop the QUICK flag altogther. It's a source of bugs, and the longer we
look at it the more cases we find where the existing users thereof are
buggy in specific edge cases. We just recently removed one user of
QUICK, and this here is another dubious case. I wouldn't be surprised if
we could find edge cases for the other, remaining users, as well.

> Possibly we'd want some logic to avoid doing the re-scan for every
> object (so if you are about to prefetch for a million objects, you don't
> want to trigger a million SECOND_READ re-scans, but rather do it once).
> That would require some refactoring.
> 
> But it would fix this problem, along with any other related ones. In
> particular, I think your fix here is leaving lots of cases with the same
> problem. Missing our own loose write in the cache is an obvious problem,
> but it's not the only reason we might fail to see a local object: it
> could be in a pack now, or it could have been written as a loose object
> by some _other_ process.

True. I think it's a valuable fix regardless as it ensures that our
cache reflects what we ourselves just did, so it's a simple improvement.
But there's definitely more edge cases to this whole thing.

> So I suspect you could cause the same problem racily by running "git
> log" on some local-only commits while somebody else is repacking, with a
> sequence like:
> 
>   1. git-log scans the odb and builds an internal packlist.
> 
>   2. git-repack runs in another process, migrating loose objects to
>      packs. git-log doesn't know about our new pack.
> 
>   3. git-log tries to diff a commit. In a non-partial clone, the diff
>      code eventually tries to read that object, realizes we can't find
>      it, and does a SECOND_READ. But in a partial clone, we try to
>      prefetch via diff_queued_diff_prefetch(). That uses the same
>      FOR_PREFETCH flag and will try to fetch it.
> 
> I'd guess most such cases are going to be racy, though you can imagine
> ones that aren't. E.g., if mktree actually did pre-fetching, then
> something like:
> 
> 	for fn in $files
> 	do
> 		oid=$(git hash-object -w $fn)
> 		printf "100644 blob $oid\t$fn"
> 	done |
> 	git mktree
> 
> might run into similar problems. It needs to know about newly written
> local loose objects, but they were written externally. You might even be
> able to find a similar case where git-merge ends up writing the objects
> via a helper process, but I didn't check.
> 
> So I dunno. This is fixing a real case and not making anything worse, so
> maybe it is reasonable in the interim. But it's the tip of the iceberg,
> I think.

No arguing there. I'd propose to still move ahead with this particular
fix here as it addresses the original bug report and addresses the
regression. But I agree that we may want to invest some more time into
this problem space after it lands.

> > We could in theory fix this by flushing all the loose object caches
> > again, like we used to do before 5946a564cdd. But that wouldn't address
> > the root cause: the cache would still be stale unless somebody does a
> > non-QUICK read for a missing object. Instead, fix the bug by updating
> > the cache whenever we write a new loose object.
> 
> I agree that the object cache flushing was only fixing this problem by
> chance. But I think it might be worth reconsidering the change from
> 5946a564cdd. Flushing the cache (or not) should always be an
> optimization problem, not a correctness one (assuming the rest of the
> code is bug-free and using QUICK sensibly). But a SECOND_READ fallback
> is a good indication that information about our odb is stale, and it's a
> good time (from an optimization perspective) to flush them.

It may be, but it may just as well not be. In some cases we may truly
not have a specific object, and the caller would want to know about
that. And in that case we should avoid flushing to only those cases
where it's really necessary.

Patrick
