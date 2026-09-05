Received: from cloud.peff.net (cloud.peff.net [217.216.95.84])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8AD352744F
	for <git@vger.kernel.org>; Sat,  5 Sep 2026 14:02:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.216.95.84
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788616949; cv=none; b=BAUo+kdXecTX5kvAvwRrokMNYAWIOGcSbvkx6pnHrTVXiaoJuMbkklOrB619Fu/y/N9NKLIC5P0De+pTvWqGIG6JaLNMynwt27VnM0WbPj0yBBJLEIszXFaEZZ05E1bM3+icwDUWFLqmrUhzXavLqFXqLo2E+fT/4xnb7MWyNmc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788616949; c=relaxed/simple;
	bh=xmN7UC+RrFII69W8HibUTh4ScJJyIvUHP2clbPt6na8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=k89M1/bpno23WfEt9ZBv26SBd5ZJwzpVUudevYrdxUAQRtShI3xnr9U1FW0BRfcaSWxECNqwo4uiRvYhaHC3UegyIYgWiB4N7B6Od/bVZHj6Jf6qKnQwodKeBfxzf54fz2Tt4xB1c7AQAC4Ks5Yrcc2tXqHdO+tTTexkTh+nFWU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=peff.net; spf=pass smtp.mailfrom=peff.net; dkim=pass (2048-bit key) header.d=peff.net header.i=@peff.net header.b=ehgDIYzK; arc=none smtp.client-ip=217.216.95.84
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=peff.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=peff.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=peff.net header.i=@peff.net header.b="ehgDIYzK"
Received: (qmail 18755 invoked by uid 106); 5 Sep 2026 14:02:17 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=peff.net; h=date:from:to:cc:subject:message-id:references:mime-version:content-type:in-reply-to; s=20240930; bh=xmN7UC+RrFII69W8HibUTh4ScJJyIvUHP2clbPt6na8=; b=ehgDIYzKh6LsQVmCIFizr0lkabkLPAeY62p45A6HgDXHSVWR3c6LAeksp56j4jEfw9wnlxX38NQDEsFvTIu+wO/mD9ZpoIw8/KEI07q3sCSWqdjC4NpTmfjQHBqiDQckZQjmG8yK9Lx8zswPqyYTLYQ2E5RiQo7YmR4rFPUMjiWztFIOuXkgfrVIXbWZzUe5I4ZeFz1OJd2n1OoCIJlZQJA/U2fJtDnR4NAUjkgM+iNM7iD3fRykYlMf4mBvC28HL8rlt+mONTDf0Tq7EJvr5U0GB62Rx7MTRy2y2PV6T+pBnDU+XSZz/gNMX6UqLZDzp8msqKMBB+hd10StCCogSw==
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Sat, 05 Sep 2026 14:02:17 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 93364 invoked by uid 111); 5 Sep 2026 14:02:17 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Sat, 05 Sep 2026 10:02:17 -0400
Authentication-Results: peff.net; auth=none
Date: Sat, 5 Sep 2026 10:02:17 -0400
From: Jeff King <peff@peff.net>
To: Patrick Steinhardt <ps@pks.im>
Cc: Junio C Hamano <gitster@pobox.com>,
	=?utf-8?Q?Jean-No=C3=ABl?= Avila <jn.avila@free.fr>,
	git@vger.kernel.org
Subject: Re: [PATCH 2/2] ci: use system asciidoctor
Message-ID: <20260905140217.GA3914642@coredump.intra.peff.net>
References: <20260902071113.GA70165@coredump.intra.peff.net>
 <20260902071613.GB641414@coredump.intra.peff.net>
 <apfWhYF6nmcFGKE3@pks.im>
 <20260902090146.GA1791728@coredump.intra.peff.net>
 <apfzihj-1YAhn5lT@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <apfzihj-1YAhn5lT@pks.im>

On Wed, Sep 02, 2026 at 11:59:38AM +0200, Patrick Steinhardt wrote:

> On Wed, Sep 02, 2026 at 05:01:46AM -0400, Jeff King wrote:
> > On Wed, Sep 02, 2026 at 09:55:49AM +0200, Patrick Steinhardt wrote:
> > 
> > > One thing that we might have to worry about is compatibility with _old_
> > > versions of asciidoctor. Now that we're using a more modern version of
> > > it we might start relying on features that weren't available in older
> > > versions, and we wouldn't notice anymore. So we kind of have the reverse
> > > problem now.
> > 
> > Right, this is the "we could in theory check both" path I mentioned
> > earlier.
> > 
> > v1.5.8 is sufficiently old that I don't think we need to care anymore.
> > We can still take bug reports if somebody happens to use it and finds a
> > problem. Checking other older versions isn't likely to be that
> > interesting (the next version after 1.5.8 is 2.0.0, which had a higher
> > than usual chance of breaking things).
> 
> Yeah, I agree. We can still reconsider if we ever hit a scenario where
> it caused problems after all.

BTW, after having dug into Debian versioning for another patch this
morning, I bothered to look at which asciidoctors they ship. Even Debian
11, which just went out of LTS, was on asciidoctor 2.x. Ditto for RHEL8,
which has a 10-year cycle (it hasn't been 10 years since asciidoctor
2.0.0, but it luckily was released in the right part of the cycle).

I don't think that changes our conclusions. Just adding a little bit of
research for posterity.

-Peff
