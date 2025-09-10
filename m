Received: from cloud.peff.net (cloud.peff.net [104.130.231.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EBD36243374
	for <git@vger.kernel.org>; Wed, 10 Sep 2025 05:13:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=104.130.231.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757481237; cv=none; b=bOGF/lsLFjOFEg5bPY+SlPwUsDA6G50E6KbpjB01EQfR0LfsFutyJzMTLkxPUQC0OCgllhEZxRAnz2fZpsmufRCcrxu1YJcLHXSZyW7QukUh0dZaVQGD9Fcc2ZLeXzXbjX2UXUJ7Yip3BbvPaFA+WfD1mZkrJvKKG8GSzXNwmmY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757481237; c=relaxed/simple;
	bh=bPl9dyZsK+DMqY7n40+lF4JgjFEGmPP0QnQqm6Cn/Vw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=uz+5t/stSgav2PtC8KtpNtbWJ84jI0HaeHykHnaDNMPedbakcschIvdCL4y8DIGKIcyvlM8AHFBc4H1992mVZUeIUjgRRZu60TgabnAglQxKmeT+mBUQfToEqEhc2XL5ry7gSc1HbR/3BZV0A+l+ISs8RSJPEMs+g2SRQnm0LYE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=peff.net; spf=pass smtp.mailfrom=peff.net; dkim=pass (2048-bit key) header.d=peff.net header.i=@peff.net header.b=Ft/XOXET; arc=none smtp.client-ip=104.130.231.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=peff.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=peff.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=peff.net header.i=@peff.net header.b="Ft/XOXET"
Received: (qmail 36957 invoked by uid 109); 10 Sep 2025 05:13:48 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=peff.net; h=date:from:to:cc:subject:message-id:references:mime-version:content-type:in-reply-to; s=20240930; bh=bPl9dyZsK+DMqY7n40+lF4JgjFEGmPP0QnQqm6Cn/Vw=; b=Ft/XOXETH/fzFYVn42AknWKwf+aGdV/+w8T7SWzwXa933NqHzgAx00Jli+j/UVF2KdxVIngwTjzDecNZaBJEklRr7tTwPktf6SbuZPa6ruAlLfxPThtI58FRd3diCZEktX3dcaf6/8YuWWmBBB2NruyoP8uHjH93J1KcjiduXImez6GpCEeWl/w6Y7y91+t0mw92dPcgrDAETF9bfEQHwJjplp8KlDGnljphS8usUKohn8VU/FfIn+Oz0MawjUx3463rL7IwW+Fc0Ji6dxXJD2vlmeIhEKCbRTe6SUZm1G02jtMMhFVFu/rZW+LpjrCjn4gLDxD66H7U1aMIimlmEg==
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Wed, 10 Sep 2025 05:13:48 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 61116 invoked by uid 111); 10 Sep 2025 05:13:47 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Wed, 10 Sep 2025 01:13:47 -0400
Authentication-Results: peff.net; auth=none
Date: Wed, 10 Sep 2025 01:13:47 -0400
From: Jeff King <peff@peff.net>
To: kristofferhaugsbakk@fastmail.com
Cc: git@vger.kernel.org, Kristoffer Haugsbakk <code@khaugsbakk.name>,
	Eric Sunshine <sunshine@sunshineco.com>,
	Patrick Steinhardt <ps@pks.im>
Subject: Re: [PATCH v4 2/7] git: allow alias-shadowing deprecated builtins
Message-ID: <20250910051347.GA556174@coredump.intra.peff.net>
References: <cover.1757345711.git.code@khaugsbakk.name>
 <cover.1757446619.git.code@khaugsbakk.name>
 <672253e0e7167c40290d1fef6d5076adfbe25d80.1757446619.git.code@khaugsbakk.name>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <672253e0e7167c40290d1fef6d5076adfbe25d80.1757446619.git.code@khaugsbakk.name>

On Tue, Sep 09, 2025 at 09:45:52PM +0200, kristofferhaugsbakk@fastmail.com wrote:

> +		if (is_deprecated_command(args->v[0]) &&
> +		    alias_lookup(args->v[0])) {
> +			if (!handle_alias(args))
> +				break;
> +			done_alias = 1;
> +			continue;
> +		}

I think this is failing the SANITIZE=leak jobs, because alias_lookup()
returns an allocated string with the alias. You need to capture and free
it, or introduce an alias_exists() wrapper to do so.

There might also be a way to do it just by calling handle_alias() and
checking its return value (it seems to indicate whether an alias was
found, but I didn't look through the whole function carefully, or think
about the implications of how the done_alias flag works).

-Peff
