Received: from cloud.peff.net (cloud.peff.net [217.216.95.84])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5821B27A916
	for <git@vger.kernel.org>; Thu, 27 Aug 2026 05:10:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.216.95.84
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787807457; cv=none; b=EUxQl0/ngf9rtSS6YHezVUtsvNFwg8gOoFge6xHr+ZOi792436ifMzvZeZUWqMhyKuvRZ04LuTXpy5o+J1ZbL2ieW6KP/mY/rVBUJ/FVe+uaSGBPScDvsewg7TKapbOGZK9q2Yvf4ccne8Ycu2AuPZ4ZVblUGS4+JKUuDVR7V1s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787807457; c=relaxed/simple;
	bh=oaE7Jgw0p+ZzJoye1JOlF4qhrgQjUz9tuX3KW31HM0M=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=X6aJ0cG97uEaUtwbZEy4DpASS69ItMYZVutXw/kBKyuSaekZIdda8rqPP8kK1GSMHQJKIFocLBKDCYoZW2VyBJirruMiG5Y7JUbMmuSoSr0MNUX9Fa7J1jD+NremmJy6oUG74dynj+/Q6n5rDeG5O/PV642frYeDhMt2FhD/UT8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=peff.net; spf=pass smtp.mailfrom=peff.net; dkim=pass (2048-bit key) header.d=peff.net header.i=@peff.net header.b=AKStI8zX; arc=none smtp.client-ip=217.216.95.84
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=peff.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=peff.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=peff.net header.i=@peff.net header.b="AKStI8zX"
Received: (qmail 6976 invoked by uid 106); 27 Aug 2026 05:10:54 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=peff.net; h=date:from:to:cc:subject:message-id:references:mime-version:content-type:in-reply-to; s=20240930; bh=oaE7Jgw0p+ZzJoye1JOlF4qhrgQjUz9tuX3KW31HM0M=; b=AKStI8zX5F1OGq+tz/og2oFHhvGlEoZoB6dB7zWaMpZilewaaliutpiyjccCDpMWYybXin+JjLWEiN5X5iSiSoK5ka4lvpKyVDSfGCo/2M8FOlaHr67GAFMhrMVlNm1JizN9iMQQkzMkH1xAi82dSjyfEkhqB/5cuzo9hT6GfTUKkDq4YKW8KoGyTulIDM/s2yXuup3r/8urvwhA7KKgvlHyTY4+giR009M3IidJDCRuuL0mj3PdGRZLNBsGeY/d701c8oMv2iP0I6F36/KwAr7AmLmrPz9jF6d+jh/T4Nw4/kXQHDo9FzSxcNh0jfM8k8PdJHSP33qkj2N3hvlEkg==
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Thu, 27 Aug 2026 05:10:54 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 34977 invoked by uid 111); 27 Aug 2026 05:10:58 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Thu, 27 Aug 2026 01:10:58 -0400
Authentication-Results: peff.net; auth=none
Date: Thu, 27 Aug 2026 01:10:53 -0400
From: Jeff King <peff@peff.net>
To: Derrick Stolee via GitGitGadget <gitgitgadget@gmail.com>
Cc: git@vger.kernel.org, gitster@pobox.com,
	Taylor Blau <ttaylorr@openai.com>,
	Derrick Stolee <stolee@gmail.com>
Subject: Re: [PATCH v2 1/7] banned-die: create header for banning of functions
Message-ID: <20260827051053.GB176544@coredump.intra.peff.net>
References: <pull.2178.git.1784131932489.gitgitgadget@gmail.com>
 <pull.2178.v2.git.1787684181.gitgitgadget@gmail.com>
 <84634717e2eca479026d1cdf39a089a8f61d131e.1787684181.git.gitgitgadget@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <84634717e2eca479026d1cdf39a089a8f61d131e.1787684181.git.gitgitgadget@gmail.com>

On Tue, Aug 25, 2026 at 06:56:15PM +0000, Derrick Stolee via GitGitGadget wrote:

> We have universally-banned functions listed in banned.h since
> c8af66ab8ad (automatically ban strcpy(), 2018-07-26), but some layers of
> the code should be more strict than others.
> 
> One such example is the trace2 API which runs during atexit() and can
> prove to cause die()-handler recursion problems if it calls die().
> 
> Create a new banned-die.h header file that will ban some Git methods
> that call die(). Include that in all trace2 API implementation files.
> This currently only bans die() itself, and that was already not used.

There's a subtle but big difference between the universal code bans in
banned.h and this banned-die.h. In the former case we are deciding
strcpy() is unfit for our code base and outlawing it everywhere. The
potential problem is in the source code, so catching it while compiling
the source code is OK.

But we are not doing that with die(). It is a perfectly OK function in
general, but we do not want to ever trigger its runtime effects from
certain code paths. Banning it from being called from those code paths
can catch _some_ instances, but not any transitive calls. If we call
foo(), it may call die() itself, and we would not want to ban foo() from
doing so. And recursively for functions called by foo() and so on.

So you end up playing whack-a-mole with functions that might call die()
and adding them to this ban list.

I think that's _probably_ the best we can do in practice. I think the
framing above suggests that we could approach the problem more directly
with a runtime flag: when we enter those code paths, set a flag to avoid
the unwanted behavior, and have the low-level code respect that. But
die() is a special case here, because we'd want to suppress its
no-return behavior. And its callers are not prepared for die() to
suddenly start returning because of some global flag.

So I think the whack-a-mole is the best we can do. But I would not want
to see this strategy extended to other areas. In most cases some kind of
runtime support is probably a better solution.

-Peff
