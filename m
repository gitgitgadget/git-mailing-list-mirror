Received: from cloud.peff.net (cloud.peff.net [104.130.231.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3514D1B983E
	for <git@vger.kernel.org>; Fri,  3 Jan 2025 18:57:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=104.130.231.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1735930651; cv=none; b=MmzWuKJilK7rnsr9e2HDJ/B2WDr//0jXxoZMzAFc5OBhEl/S/Cra0mWyrUxCo0LLb4hqza7KJlVzC6MCvxPgQ4mcDXZQAV4Me0yZSoAg03o+6hV3daGUaTg10Pn2+SQgzEygHUZUWNGktB6Ea5yMURZXORVIE3dbp0RuTBBYkq8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1735930651; c=relaxed/simple;
	bh=chI/jhd5YXByyIKgft/tU6PeVHIUSFBqrg+ftkE3lVg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=rmad3hQ9zRgpm754DzbnLG0qDXqlNMOLQ+23J72Xyl8hc6fdEHkfk7xj0nEO1x7bQGScZDlxaGQPSxolPAcKCopO3y8yQDLwkqWZW1pUqpbzT1YY4ym723QL/h1cZNN2mRJqQXJdRd0suaR03K5S2vutlWTwFXe4wNc6uX+FqIs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=peff.net; spf=pass smtp.mailfrom=peff.net; dkim=pass (2048-bit key) header.d=peff.net header.i=@peff.net header.b=IuQb/Riv; arc=none smtp.client-ip=104.130.231.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=peff.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=peff.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=peff.net header.i=@peff.net header.b="IuQb/Riv"
Received: (qmail 18382 invoked by uid 109); 3 Jan 2025 18:57:28 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=peff.net; h=date:from:to:cc:subject:message-id:references:mime-version:content-type:in-reply-to; s=20240930; bh=chI/jhd5YXByyIKgft/tU6PeVHIUSFBqrg+ftkE3lVg=; b=IuQb/RivZ0SUw0pV13KtiDHc3HPbHj+/UJ5jtNnFNcFcFkBTvx8k0aFGVZtu6ULu/C61GxKwpD5f3qs6VDhlHjOKKE1pwkuCBV4HwuDNHhuWeGXcGGTzCeZsAoogwCFcleZg55gG0Y2vMjdRV6eaSzTibLftQdA8Lu1UM0m5wMeJvFSML58jJ3yG0h1pjuEMsy1Mo2SnfN/aeJd/OjAOK4A1M7Jqh1D5IKUkXpdFj3XbjBFNq9n5YUzLpgrM7kVOEUxFLh6irgPk16bsLZEg9N6RBGTUvwk6Ac2TPfLSqy6y0TbldQX0ItJOMdMys2R868wkoawnYpokFXmPrF+Cxg==
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Fri, 03 Jan 2025 18:57:28 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 3979 invoked by uid 111); 3 Jan 2025 18:57:27 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Fri, 03 Jan 2025 13:57:27 -0500
Authentication-Results: peff.net; auth=none
Date: Fri, 3 Jan 2025 13:57:27 -0500
From: Jeff King <peff@peff.net>
To: Patrick Steinhardt <ps@pks.im>
Cc: git@vger.kernel.org
Subject: Re: [PATCH 00/10] A couple of CI improvements
Message-ID: <20250103185727.GB3208749@coredump.intra.peff.net>
References: <20250103-b4-pks-ci-fixes-v1-0-a9bb95dff833@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20250103-b4-pks-ci-fixes-v1-0-a9bb95dff833@pks.im>

On Fri, Jan 03, 2025 at 03:46:37PM +0100, Patrick Steinhardt wrote:

> this patch series addresses a couple of issues I've found while
> investigating flaky CI jobs. Besides two more fixes for flaky jobs it
> also removes some stale code and simplifies the setup on GitHub Actions
> to always use containerized jobs on Linux.

I left comments on two patches, but the rest seemed fine to me (and I am
very happy to see cleanup of old/stale code).

-Peff
