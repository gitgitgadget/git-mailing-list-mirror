Received: from cloud.peff.net (cloud.peff.net [104.130.231.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 81592216E23
	for <git@vger.kernel.org>; Thu, 19 Dec 2024 05:42:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=104.130.231.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734586948; cv=none; b=gHvd+SdQLx+iEqn4dSgK+Quwl8NguZHKK6XtG+vg8iFFTwa+JEZUOqSinP9E2x66TQI+4EIOIdRWI7DDAKsFeBFWvH4V/wCo21BMw7MxSxLO/3rCtd0CqLjeLY9UItmEwwgYtzMKwE/d91cWzSGSSVAX8Om8/29SksmxFBijKpQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734586948; c=relaxed/simple;
	bh=bTyEcv8gXIjJcyTIfj7UwMR0yhDm6OLZfqXypOTenug=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=bxHtenDlLCF6yDDlfvC6rhPeRUkylH8ly96m8ezN+d2XSX+2++Qww9cxNFYEKc3i0XQJFKtQ8LqF0r9zN5FR9zQv/VOiy/goQ6B41/mvdmF9iAzb6453Rl+iRkza5aNNrvrVa5o2MjIPeUYq806OgLIsCQtQ9eOo1PEeKt/vNvo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=peff.net; spf=pass smtp.mailfrom=peff.net; dkim=pass (2048-bit key) header.d=peff.net header.i=@peff.net header.b=C01N3tmJ; arc=none smtp.client-ip=104.130.231.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=peff.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=peff.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=peff.net header.i=@peff.net header.b="C01N3tmJ"
Received: (qmail 19373 invoked by uid 109); 19 Dec 2024 05:42:25 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=peff.net; h=date:from:to:cc:subject:message-id:references:mime-version:content-type:in-reply-to; s=20240930; bh=bTyEcv8gXIjJcyTIfj7UwMR0yhDm6OLZfqXypOTenug=; b=C01N3tmJq/VCLGpx5Gzo/t02lUJvr5xaWAEUJp+iT7ZhhLm9BmvOvxllmoAIWPkZk4NfrYpsLMjV0x7UNDbJNRHJl+Dxjp7bmWEmVITT61nAzMMoIkaey48XnK10eK+pZ0JyyOiLqhqFBXC6M0Lg+nsC8zPpq5V2ESNrB02bQITVshHHWSLvx2dXnDdvrB+cjAEHizB7RKeK4Feujl+UHXtnQFhMljPOTMxqamKjzs0NqgFWIwctzSsLRF3SPtdwb4B7Xk49FoMgeml3FQConFRsLy3BdGKcv7BlXNxXaL/VsF/oZ7LGfAu8AyAbNg7pLACuAuZLa+v4fftRrH6kbA==
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Thu, 19 Dec 2024 05:42:25 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 807 invoked by uid 111); 19 Dec 2024 05:42:23 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Thu, 19 Dec 2024 00:42:23 -0500
Authentication-Results: peff.net; auth=none
Date: Thu, 19 Dec 2024 00:42:22 -0500
From: Jeff King <peff@peff.net>
To: Boomman <boomman37@gmail.com>
Cc: git@vger.kernel.org
Subject: Re: git gc does not clean tmp_pack* files
Message-ID: <20241219054222.GA2310556@coredump.intra.peff.net>
References: <CADMKT2-vsUUi-23YGexvxbW9wj0Br+cQcv34eStnw-0EDRiKMw@mail.gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CADMKT2-vsUUi-23YGexvxbW9wj0Br+cQcv34eStnw-0EDRiKMw@mail.gmail.com>

On Wed, Dec 18, 2024 at 06:19:06PM -0800, Boomman wrote:

> D:\Platform>dir .git\objects\pack\tmp*
>  Directory of D:\Platform\.git\objects\pack
> 
> 12/18/2024  05:33 PM     7,367,032,832 tmp_pack_FG1inp
> 12/18/2024  05:35 PM     3,787,194,368 tmp_pack_IFvamY
> 12/18/2024  05:39 PM     7,713,062,912 tmp_pack_khHCC9
> 09/11/2024  11:33 AM     3,068,002,304 tmp_pack_XTVFUi
>                4 File(s) 21,935,292,416 bytes
>                0 Dir(s)         339,968 bytes free
> 
> I believe that before trying to write *anything* to disk "git gc"
> should try to take exclusive handles on these and wipe them, ideally
> by default. The total size of these tmp* files is multiple times
> larger than the repo I'm trying to compact, so if the command just did
> this pre-cleaning I'd not have hit this problem once I cleaned enough
> disk space.

git-gc does know how to clean up these files, but they are subject to
the same mtime grace period that loose objects are. This is to avoid
deleting a file that is being actively used by a simultaneous process.

Try "git gc --prune=now" if you know there are no other active processes
in the repository.

We usually prune things after finishing the repack. So if you're running
out of disk space to repack, there might be a chicken-and-egg problem.
You can run "git prune" manually in that case.

Possibly git-gc should prune first for this reason, but I'd be hesitant
to do so for actual loose objects. It's a little weird that tempfile
cleanup is lumped in with loose object cleanup, and is mostly
historical. Possibly those should be split.

-Peff
