Received: from cloud.peff.net (cloud.peff.net [217.216.95.84])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1A6454D9F8E
	for <git@vger.kernel.org>; Wed, 14 Oct 2026 09:21:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.216.95.84
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791969700; cv=none; b=eS6KzLx24kC6CUx9ZL1lRxbA8z8W7KDL7/u+qkYdOEiB9nYcVBKpUSKZaPrqDDcx8zKXnYrlY+NeIAW7x73pDp9ozl7IzT6OAE1V1icMoffxlOz6hUFm2c8aGnQzWppR93bL1Qag4oY4NRzF5wsjfzrX/w8GE1dJWqqlxzQZO60=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791969700; c=relaxed/simple;
	bh=xnNWMxN32LNJvvwwPDNgLrS5x0CuTUBWH+CGILoXFoU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=PX94B5lq9hc3AxPNyqiARvu97rLoIAyBVfwvrD+hkNBJ/rPTZm0gTJwS1GpBNeBWVXF7wyCBCaqMnHx2ftO3ieaCEZL//tqCqZoRC6g549MXrnzMC05yCKbl59F+ZRx+i+gcAp7OVjcl+5jd2BIxAngNd20/0tzlcJd8wgi151M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=peff.net; spf=pass smtp.mailfrom=peff.net; dkim=pass (2048-bit key) header.d=peff.net header.i=@peff.net header.b=W+l7lexq; arc=none smtp.client-ip=217.216.95.84
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=peff.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=peff.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=peff.net header.i=@peff.net header.b="W+l7lexq"
Received: (qmail 68939 invoked by uid 106); 14 Oct 2026 09:21:38 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=peff.net; h=date:from:to:cc:subject:message-id:references:mime-version:content-type:in-reply-to; s=20240930; bh=xnNWMxN32LNJvvwwPDNgLrS5x0CuTUBWH+CGILoXFoU=; b=W+l7lexq/EUFLV9Hs5D1qynHad2/o4y9byNDhIKwSItoJaeazYNe61XewUNn8dNapG3FSME/Jebza97kFG+WDws75+NqF3kxfO7h+Yf4Xm0/kXuVhWLDP117gsu2fcGQ/cDX4j9gVyIrWNgRS3JYwRkM4s4T2VJeyVcInr/0+Tgn6ufAQq+4itiZaA0jFPk/XZfWsB3HIJ+JUpvySpzTAF+YRWGlzntMJWrisSjiW2nZ5J0nBUbAOHChmf2lqaIYdT8OqQWYBIoSWIGP+RQaZyL9DLkFRc+OQ8+LS7kNZtRnJ1HPN35CR5OctupIf4pxkfWB7WYyxgQLBuWL5VXXhQ==
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Wed, 14 Oct 2026 09:21:38 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 35718 invoked by uid 111); 14 Oct 2026 09:21:42 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Wed, 14 Oct 2026 05:21:42 -0400
Authentication-Results: peff.net; auth=none
Date: Wed, 14 Oct 2026 05:21:37 -0400
From: Jeff King <peff@peff.net>
To: Patrick Steinhardt <ps@pks.im>
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
	Todd Zullinger <tmz@pobox.com>,
	SZEDER =?utf-8?B?R8OhYm9y?= <szeder.dev@gmail.com>
Subject: Re: [PATCH v3 8/8] ci: improve reftable test coverage
Message-ID: <20261014092137.GF1341124@coredump.intra.peff.net>
References: <20261014-pks-ci-housekeeping-v3-0-04c24e1f480d@pks.im>
 <20261014-pks-ci-housekeeping-v3-8-04c24e1f480d@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20261014-pks-ci-housekeeping-v3-8-04c24e1f480d@pks.im>

On Wed, Oct 14, 2026 at 10:30:34AM +0200, Patrick Steinhardt wrote:

> The "linux-reftable" job exercises Git with reftables as its default
> backend. But this job is arguably redundant because we already have the
> "linux-reftable-leaks" job that exercises reftables with the leak
> sanitizer enabled, and it is unlikely that we will catch any extra bugs
> with the leak sanitizer disabled.
> 
> One may thus be triggered to just drop the "linux-reftable" job in favor
> of the leak-checking variant. But the latter disables a couple of other
> tests that exercise git-p4, git-svn and other tools. Those tools may not
> be an essential part of Git nowadays, but I don't quite feel comfortable
> with reducing test coverage.
> 
> Instead, adapt the job to run reftables together with SHA256. which is
> an area that we don't have test coverage for.

Hmm. Aren't both sha256 and reftables by default part of the breaking
changes flag? So I think we probably are already getting coverage there.

-Peff
