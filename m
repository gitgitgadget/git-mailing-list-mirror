Received: from cloud.peff.net (cloud.peff.net [104.130.231.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9FB6833B6DD
	for <git@vger.kernel.org>; Fri, 16 Jan 2026 16:54:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=104.130.231.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768582497; cv=none; b=C8FSXYiE43mMAs8DS+HuVsFezXtpaCjZToKIpobEOuImqrlr8tDFjaihRd7uE+6I2JQ2suSBvgGufnhfMqgomidgCvrWY2iepDJNTW/dc2FIhIJa2DAOpTqNJ4R+qEJHkUfaTfqG/nsbkA80xO68hHwGGLztnH0SdzaXZLReqtw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768582497; c=relaxed/simple;
	bh=HfzFn4tD8ihlhEkjJ59nGO9VdoNGXtHiKvZCsWGO6Iw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=L1ISsAnuXNXGDIVTXI9a09zxZ34y5JB/fmS/6VVKxwbJxWvhqcadEB1ZUVerYLM/4laS25vquhfkUsUaixjGjvNrxp5CqNdQHsIQxsVBwgkFCtWvKLy+jsnMf9Um/G8uzs3SN+BUE5a9CXt0uxwZgkLvY9ZyB8mtwaOnFBAaBe8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=peff.net; spf=pass smtp.mailfrom=peff.net; dkim=pass (2048-bit key) header.d=peff.net header.i=@peff.net header.b=Wsfm4vxb; arc=none smtp.client-ip=104.130.231.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=peff.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=peff.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=peff.net header.i=@peff.net header.b="Wsfm4vxb"
Received: (qmail 59460 invoked by uid 109); 16 Jan 2026 16:54:52 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=peff.net; h=date:from:to:cc:subject:message-id:references:mime-version:content-type:in-reply-to; s=20240930; bh=HfzFn4tD8ihlhEkjJ59nGO9VdoNGXtHiKvZCsWGO6Iw=; b=Wsfm4vxbtEErEGlBl21Px2F6ZihTFqyuUZp36ELxz4IgodT3PgNl44dkLaOj6bxf2paN6p7S2uFQI86ksDp6o+Wo6vbAEQTB+y0Gj3n3o4Bo4KWtPTKxJ/0v9t5QGdDHbIYerVOBg6+LcUF9/Y1h2jopBwOZNXboNOaVtsBGUzyXOTPj92nr0u4RRAzUdv5oYaBz3RYhhtZE9k9DYtaDclSgUcuk4NWkGBbBn7HZkY3+vJ+ERoAN+0O3Q+gkBzpWd8QRCQWr+Q5dUyUk5Wy1dEFuld2ube0jn0IXZtk/8HNQmjZ7TMi8J0gw4jUdki0FnxdWyz9/mKu0d9lQWMxDtg==
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Fri, 16 Jan 2026 16:54:52 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 93788 invoked by uid 111); 16 Jan 2026 16:54:53 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Fri, 16 Jan 2026 11:54:53 -0500
Authentication-Results: peff.net; auth=none
Date: Fri, 16 Jan 2026 11:54:51 -0500
From: Jeff King <peff@peff.net>
To: Ramsay Jones <ramsay@ramsayjones.plus.com>
Cc: git@vger.kernel.org, Patrick Steinhardt <ps@pks.im>
Subject: Re: [PATCH 0/2] more t/perf meson/GIT-BUILD-OPTIONS fallout
Message-ID: <20260116165451.GB1636797@coredump.intra.peff.net>
References: <20260106101043.GA3723319@coredump.intra.peff.net>
 <1a430542-715e-4cf1-86f5-d9424951204a@ramsayjones.plus.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <1a430542-715e-4cf1-86f5-d9424951204a@ramsayjones.plus.com>

On Tue, Jan 06, 2026 at 05:07:11PM +0000, Ramsay Jones wrote:

> I hesitated to send this email because I have been reduced to simply skimming
> the git mailing list (very busy with other projects/real life!), and I may
> have misunderstood what you aim to do here. ;)
> 
> In essence, I was triggered by the 'GIT-BUILD-OPTIONS fallout' phrase in the
> subject line! That reminded me of a problem/patch I was looking at earlier
> this (wait, last) year. The patch (below) was a complete 'hack' (as you can
> see) to allow the environment to override the 'GIT-BUILD-OPTIONS' file. This
> was in an old branch named 'meson-wip' which I have been meaning to look at
> again to either delete or fix-up.
> 
> One of the many reasons (apart from being a disgusting hack) that I didn't
> progress this patch is because I felt that not all 'options' in that file
> should be able to be 'overridden'. So, that implies that the file needs to
> be split into two; one file of options which can be overridden from the
> environment and one that can't. If so, then someone has to decide which is
> which.

I think you understood my goal. :) This is more or less what my patch is
doing, but just for a select set of options (to un-break t/perf). I
think a larger fix may look something like this, but:

  1. I agree with you that we may need to consider which options should
     be able to be overridden and which should not.

  2. This hack has to go everywhere that GIT-BUILD-OPTIONS is read. So
     in test-lib.sh where you have it, but also in perf-lib.sh (matching
     the fix by Dscho earlier) and also in t/perf/run (matching the fix
     here).

It would be nice if we could write GIT-BUILD-OPTIONS in a way that did
the right thing. E.g., by writing:

  : ${GIT_FOO:=some-value}

And then the writer (which is the ultimate source of authority for which
variables are included) could decide which ones can be overridden.

I _thought_ this wouldn't work because we also source the build options
files from the Makefile (and so it has to support both syntaxes). But a
quick grep doesn't show us including it. So maybe we used to do so, or
maybe I'm mis-remembering (and confusing it with GIT-VERSION-FILE
perhaps?).

-Peff
