Received: from mail-qk1-f169.google.com (mail-qk1-f169.google.com [209.85.222.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B443F10F4
	for <git@vger.kernel.org>; Thu,  2 May 2024 00:33:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714610040; cv=none; b=VBaNxBWG25DPwj8iRl0xhFsDgX5cHPf9jLblpzk/eGFNOTucldyxVnnSnoDAgfXbUs1w7KltA4I8xbMRaXhbhu7wQFXmTE/lvWdCKA2G86WqTBBtnlGUnuuqPotejg1+qvvZVDes/b+UqG69LNUPRjevZ7QHO6TiAWkd4z1qmNg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714610040; c=relaxed/simple;
	bh=l2tTvjUjbQ6Enp2M/7HCGeBdXFlor4UYps/pCS0wx0w=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=JPrlYDqd1iKOjKQpEg3jdC00qJ+Ztm15F0tvLQv4szBOXtMjktpkqIk2R/opPGEyDBdXtIwQdbOHVcjK7qtnKmDZhYs7YEB6IVnnsjzl0VekK/TLsYLXd/WRJpHDoQ7uIkdx2LIU1UHPGeka1XpyAlWHZFXUVcL4eyM80FZlNyo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ttaylorr.com; spf=none smtp.mailfrom=ttaylorr.com; dkim=pass (2048-bit key) header.d=ttaylorr-com.20230601.gappssmtp.com header.i=@ttaylorr-com.20230601.gappssmtp.com header.b=i33noQlY; arc=none smtp.client-ip=209.85.222.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ttaylorr.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=ttaylorr.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ttaylorr-com.20230601.gappssmtp.com header.i=@ttaylorr-com.20230601.gappssmtp.com header.b="i33noQlY"
Received: by mail-qk1-f169.google.com with SMTP id af79cd13be357-790eedf44faso319088885a.3
        for <git@vger.kernel.org>; Wed, 01 May 2024 17:33:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20230601.gappssmtp.com; s=20230601; t=1714610037; x=1715214837; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=8YzJJG6YIxxblC4ahl0DaFHcLelp9swiP5JXDyynoT4=;
        b=i33noQlY9qy6bG+NySJFGn8OIuh3D3+0BszBNmf95qQo3rrC8lCLlQ6xYXmufOWaaq
         K+NGxGNxfwUyTAMlkwrzNn5FIPJ0PJJh5MoGC5B0jWW+cw0KbjUS6bakc/TypgaTtTcx
         OHzDxN8IUklMC6pJKXcm47ds588sCXITArLlPTcY4Q/X12QB/cv5oeVQ0fUyskdWCnZA
         lBV0QySDy2a6KdUZ5SiRCr9WOgEZbP0Z6yD//sJy3/Kna4OB2z/iqxg7CoRlQ5C9QiQM
         N+gUVtRIh4QI7CagpaTX5mSnKsbnuuN64959vLqowGZISSJOyZLNf9d9fTEf5gcl20ZP
         pQDg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714610037; x=1715214837;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=8YzJJG6YIxxblC4ahl0DaFHcLelp9swiP5JXDyynoT4=;
        b=w+rg9Qi+6GpLeSIixC+s0XT2BfvB0HaLzDaUULE38rJsTRubW02dLDOVzWACwONnCI
         mxwHzJ46cos1ht/Smi5kOKw4sW72EXwC+3zG89i4+/yaqA429MCWwXxDV/jMP4FuH5PB
         8YCGlV3bD/sOBCB+0Ab1ZYf6ItI6AQKBvcoGe0j7kmRhqCSLPXzxrXGV8F+l+OjCfSHO
         bng1DXOwZN1rNquGiqUcMu7qzPkzq6rEk+0i10ulvFWYktI7oNOka6wDeXsRnjKGfTfq
         5fHWgL66SX859xDzRH6LvJR4HTZAJ4FpEijOECsaDRBRFHM6GGG7tRZBOgWhkyFQbRb2
         vUXw==
X-Forwarded-Encrypted: i=1; AJvYcCUU7c0CT9jk+V0JCbJxdwqkdv1/NPT4MJpfI7jpJ4tp8zcrIjsQ3GRguhi67zdPTjs4jVxRSZgL+wYYvqmAqqzrOP3W
X-Gm-Message-State: AOJu0YyYencDaga8S/srjONxgpF7gUveTO+KAVr48uLh8eFEUOBJXkTz
	H9I6kkFtWdRjWzt30bNf8m8D/iJLbW/wNbluqi8fnxdbe6ITAcv19b2N1hCAjao=
X-Google-Smtp-Source: AGHT+IHswYow1QuYxsNUBua0KC7eMAhle857SWeaOQnjiwy4p0S1nVqP6Y2GvSGva4e6I2Tc2ibkSQ==
X-Received: by 2002:a05:620a:4443:b0:78e:df07:f88f with SMTP id w3-20020a05620a444300b0078edf07f88fmr4736511qkp.39.1714610037495;
        Wed, 01 May 2024 17:33:57 -0700 (PDT)
Received: from localhost (104-178-186-189.lightspeed.milwwi.sbcglobal.net. [104.178.186.189])
        by smtp.gmail.com with ESMTPSA id vq10-20020a05620a558a00b007909c6e5270sm6231346qkn.90.2024.05.01.17.33.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 01 May 2024 17:33:57 -0700 (PDT)
Date: Wed, 1 May 2024 20:33:52 -0400
From: Taylor Blau <me@ttaylorr.com>
To: Jeff King <peff@peff.net>
Cc: Dhruva Krishnamurthy <dhruvakm@gmail.com>,
	John Cai <johncai86@gmail.com>,
	Karthik Nayak <karthik.188@gmail.com>, git@vger.kernel.org
Subject: Re: using tree as attribute source is slow, was Re: Help
 troubleshoot performance regression cloning with depth: git 2.44 vs git 2.42
Message-ID: <ZjLfcCxjLq4o7hpw@nand.local>
References: <CAKOHPAn1btewYTdLYWpW+fOaXMY+JQZsLCQxUSwoUqnnFN_ohA@mail.gmail.com>
 <20240501220030.GA1442509@coredump.intra.peff.net>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20240501220030.GA1442509@coredump.intra.peff.net>

On Wed, May 01, 2024 at 06:00:30PM -0400, Jeff King wrote:
> Bisecting show the culprit is 2386535511 (attr: read attributes from
> HEAD when bare repo, 2023-10-13), which is in v2.43.0. Before that, a
> bare repository would only look for attributes in the info/attributes
> file. But after, we look at the HEAD tree-ish, too. And pack-objects
> will check the "delta" attribute for every path of every object we are
> packing. And remember that in-tree lookups for foo/bar/baz require
> looking not just for .gitattributes, but also foo/.gitattributes,
> foo/bar/.gitattributes, and foo/bar/baz/.gitattributes.

Thanks for the explanation and bisection. I agree that 2386535511 makes
sense as a likely culprit given what you wrote here.

>   - the problem doesn't show up if the repo has reachability bitmaps.
>     This is because the bitmap result doesn't have the pathnames of each
>     object (we do have the "name hash", but it's not enough for us to do
>     an attr lookup), and so objects we get from a bitmap do not
>     respect the delta attribute at all.
>
>     But when doing a shallow clone, we have to disable bitmaps and do a
>     regular traversal. So even if you have bitmaps, you still run into
>     the problem.
>
>     The example above should not have bitmaps (we do build them by
>     default when repacking bare repos these days, but I don't think
>     we'll do so right after cloning). If you have a local repo that
>     already has bitmaps, you should be able to see the difference by
>     using "git -c pack.usebitmaps=false pack-objects".

Yikes. I was hoping that bitmaps would be a saving grace here for setups
that have bitmap generation enabled, but it makes sense that it doesn't
help if you are doing a shallow clone where you have to disable bitmaps.

>     So even if you are a server which generally enables bitmaps, you can
>     still get bit by this for shallow clones, but also for other
>     non-bitmap invocations, like say "git repack -ad". There I see the
>     same 3-minute slowdown in the enumeration phase.

That's also pretty scary, and a worthwhile callout.

> So what to do? It seems like some kind of caching would help here. We're
> looking up the same paths over and over, for two reasons:
>
>   1. We'll have many objects with the same paths, one for each time the
>      path was modified through history.
>
>   2. Adjacent objects share the higher-level lookups. Both "dir/a" and
>      "dir/b" will need to look up "dir/.gitattributes" (and all the way
>      up to ".gitattributes").

Right. I guess you need to cache something like on the order of the set
of dirnames of all modified paths in the repository (and recursively the
dirnames of those dirnames up until you get to the root).

> So even something simple and stupid like this:

...makes sense.

> restores the v2.42 performance. But there are probably better options:
>
>   - this is caching whole .gitattributes buffers. In pack-objects we
>     only care about a single bit for try_delta. For linux.git it doesn't
>     really matter, as 99% of our entries are just CACHE_MISSING and the
>     real value is avoiding the negative lookups. But the same problem
>     exists to a lesser degree for "git log -p" in a bare repo. So I
>     think it makes sense to try to solve it in the attr layer.
>
>   - the string keys have a lot of duplication. You'll have
>     "foo/.gitattributes", "foo/bar/.gitattributes", and so on. A trie
>     structure split by path component would let you store each component
>     just once. And perhaps have even faster lookups. I think this is
>     roughly the same issue faced by the kernel VFS for doing path
>     lookups, so something dentry/dcache-like would help.
>
>     I don't know how much it matters in practice, though. The sum of all
>     of the paths in HEAD for linux.git is ~3.5MB, which is a rounding
>     error on the needs of the rest of the packing process.

This was my gut reaction when I started reading this bullet point, too.
I have a hard time imagining a repository that would be so large that it
would have a lot of unique paths, but not so large that it would be
otherwise cheap to run pack-objects.

>   - As noted above, most entries are just CACHE_MISSING. So rather than
>     lazily looking up and caching entries, we could just prepopulate the
>     cache. And then you know that if an entry isn't present in the
>     cache, it does not exist in the tree. The downside is that you pay
>     to walk the all of HEAD^{tree}, even if you only have a few lookups
>     to do. That's a good tradeoff for pack-objects (which usually ends
>     up looking for every path anyway), but not for "git diff" (where you
>     only care about a few changed paths.

That seems reasonable to do.

Thanks,
Taylor
