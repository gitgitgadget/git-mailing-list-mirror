Received: from cloud.peff.net (cloud.peff.net [104.130.231.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7CF4717624D
	for <git@vger.kernel.org>; Mon,  7 Oct 2024 20:47:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=104.130.231.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728334059; cv=none; b=cucUf0iIHHyFv1a/5YO5IMCf8UgnskexUr39PK8zjPs81fl9pYgeXR+eEfkZ9W8Nt8lVPuVaMM+p31A2eny0lDj0uGWbI5arNEoH71nRWatZQsEEPrgS0wayCvqHG4wLanE9SMXwCQbtEuNKwLeWcIarBJfnsm57BvIj5r+tyqU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728334059; c=relaxed/simple;
	bh=L+vLyHkGBRCifzgLBqC276+ipbQ+gZni+eSzSvkV3ac=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=hLuKP7G/kS++4nPtfqZQhFEZYVjR2mymIrGFaBK/uDOZM6BK2YYNMh7DDwjsfJOTT4461EurX5FcDFwSKspG4dCLjp20Rs7+c6G1AEsNCfBsYAkxxVG1sRc8ZObTeoLEFbm8N4O2qy2DoIekXL0f+7Xde+IUnoCoif6IB0A7/jM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=peff.net; spf=pass smtp.mailfrom=peff.net; dkim=pass (2048-bit key) header.d=peff.net header.i=@peff.net header.b=g63jEGfU; arc=none smtp.client-ip=104.130.231.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=peff.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=peff.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=peff.net header.i=@peff.net header.b="g63jEGfU"
Received: (qmail 5020 invoked by uid 109); 7 Oct 2024 20:47:36 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=peff.net; h=date:from:to:cc:subject:message-id:references:mime-version:content-type:in-reply-to; s=20240930; bh=L+vLyHkGBRCifzgLBqC276+ipbQ+gZni+eSzSvkV3ac=; b=g63jEGfU4UYC9yNjx03lJoJ/bz0zCoz9IL8PFsR/7+jh9c4vQjzSsdLbZiIBS8DMBuPN8Zt4zRNirSKpn8m5XX1mJO0lz2z+0jPD8aDsPoeMAIoas/xKUQ6wCEBLs5VkvPYqnqXNiCuqsRcabNPjPcHirDVsi9vSY82529uuutk2H9KiL4xii+2HCNmFTgblQgaEGku9AuvR+HnasrQg+zxb4HMtMn+eJCvTIFfuvkGcjEHLlbnRo9phELLhmpGTs/fp+K66PYvxbLlmuQQNc9wSIEBcAeb4FcNG/UtVal3ZRcFJ4CyFr6XqhZ52/ymzJKvD3JQvPO/PvHKihmOnJA==
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Mon, 07 Oct 2024 20:47:36 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 9436 invoked by uid 111); 7 Oct 2024 20:47:35 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Mon, 07 Oct 2024 16:47:35 -0400
Authentication-Results: peff.net; auth=none
Date: Mon, 7 Oct 2024 16:47:35 -0400
From: Jeff King <peff@peff.net>
To: Kristoffer Haugsbakk <code@khaugsbakk.name>
Cc: git@vger.kernel.org
Subject: Re: [PATCH 3/3] t1402: exercise disallowed branch names
Message-ID: <20241007204735.GC603285@coredump.intra.peff.net>
References: <cover.1728331771.git.code@khaugsbakk.name>
 <8262b81141bbd36cd7a17e6abe5eb6bb688290f3.1728331771.git.code@khaugsbakk.name>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <8262b81141bbd36cd7a17e6abe5eb6bb688290f3.1728331771.git.code@khaugsbakk.name>

On Mon, Oct 07, 2024 at 10:15:19PM +0200, Kristoffer Haugsbakk wrote:

> Signed-off-by: Kristoffer Haugsbakk <code@khaugsbakk.name>
> ---

Can we give some more details here? These are cases that already passed
before your series, right? At least I'd expect the "HEAD" one to do so,
but I guess the "@" fix is new?

I don't need a lengthy explanation, just trying to understand how this
change fits into your series. It might be simpler if this came first,
adding new tests for existing behavior that was not covered, and then
your 2/3 patch just adds the "@" line in the same spot.

-Peff
