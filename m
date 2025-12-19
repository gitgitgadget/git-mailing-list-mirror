Received: from cloud.peff.net (cloud.peff.net [104.130.231.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1C302280A3B
	for <git@vger.kernel.org>; Fri, 19 Dec 2025 23:26:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=104.130.231.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766186807; cv=none; b=ZkeQ9Y9YalKdIu/IO8rmt1LF/DOlt3pJ1CQi+rQA/tU+J4LB1WO0nJygI7P3uFeOdASCKotH2qfQ2F68Otcgh/9ov7ltk8nmik3dowmzI7al7Q87YX24IGu9dyx/vfu88oJVSd5WbUIgtXX/EMapbwq69CBGAon9FCc2/gUgIUQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766186807; c=relaxed/simple;
	bh=vhYibCjvyxffxLApXzX4iZX5gULKPKvVNcyYWB9xU/s=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=pbXOxnZ5SupjsOVgWpUs+mJeKVpqweS9XcCRfnZViJpH7WgRS7cx6FxWeIftBgZC2AzNM7L11q1BWyP7pZEqSQ0vxeyK4cOb30KIZKSU2IThtHD7+i8+HGIjVrOJtkXmdeKx/WjAuJat/fFxgK6fpXcsSsVLYFOqqNwxqekMOCA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=peff.net; spf=pass smtp.mailfrom=peff.net; dkim=pass (2048-bit key) header.d=peff.net header.i=@peff.net header.b=I5bywFi3; arc=none smtp.client-ip=104.130.231.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=peff.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=peff.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=peff.net header.i=@peff.net header.b="I5bywFi3"
Received: (qmail 400018 invoked by uid 109); 19 Dec 2025 23:26:44 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=peff.net; h=date:from:to:cc:subject:message-id:references:mime-version:content-type:in-reply-to; s=20240930; bh=vhYibCjvyxffxLApXzX4iZX5gULKPKvVNcyYWB9xU/s=; b=I5bywFi3LQdjScZnWCWVlTVdmGUge7QnAbCF1A8tfc3zfTmZnmx1ZJz1JHhA5qijgewmpyfb57ZlVbi/qZNM0pwVo1C92sX77vV4VLf8180YDn4oGR6DyoOpbgHtUHzFcGbLm9JtPnkLZfTm5ABJkQw9v8ElOJ/RvnVttJnm6pQpT/ygHslyaWS46ks5jLHr2Y0hZG9sKyiMZuOK1h0TBVFejgDq0KS4sFVinMmQIHRqBDR65On9jtruyAJJeEXtO06L2/sQwl01+HqNQCPkdsJmWN5JSNKiDpW/lRSdkmQEBCPqFwdJHm+sDVI4FGN7ed8t3G5KGH97FZQln4ryfA==
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Fri, 19 Dec 2025 23:26:44 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 540319 invoked by uid 111); 19 Dec 2025 23:26:46 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Fri, 19 Dec 2025 18:26:46 -0500
Authentication-Results: peff.net; auth=none
Date: Fri, 19 Dec 2025 18:26:43 -0500
From: Jeff King <peff@peff.net>
To: Junio C Hamano <gitster@pobox.com>
Cc: git@vger.kernel.org
Subject: Re: What's cooking in git.git (Dec 2025, #06)
Message-ID: <20251219232643.GB3960837@coredump.intra.peff.net>
References: <xmqqfr96v2oe.fsf@gitster.g>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <xmqqfr96v2oe.fsf@gitster.g>

On Sat, Dec 20, 2025 at 01:47:45AM +0900, Junio C Hamano wrote:

> * jk/test-curl-updates (2025-12-18) 3 commits
>  - t5563: relax whitespace assumptions for unfolded headers
>  - t5563: add missing end-of-line in HTTP header
>  - t5551: handle trailing slashes in expected cookies output
> 
>  Update HTTP tests to adjust for changes in curl 8.18.0
> 
>  Will merge to 'next'?
>  cf. <613s97no-7021-pp15-79s4-302o39p7n5r8@unkk.fr>
>  source: <20251218121120.GA3252258@coredump.intra.peff.net>

I left a message in the thread, but it occurred to me that responding
here might catch your attention better. With Daniel's fixes for curl, we
could probably just drop the third patch (it doesn't hurt much to keep
it, but if we don't need to complexify our tests, we might as well not
do so). The first two patches will still be needed.

-Peff
