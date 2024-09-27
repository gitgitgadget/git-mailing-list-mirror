Received: from cloud.peff.net (cloud.peff.net [104.130.231.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 63E9B16F8F5
	for <git@vger.kernel.org>; Fri, 27 Sep 2024 03:57:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=104.130.231.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727409436; cv=none; b=QnWOcQ8sqwu8p0odJxoCX2r0Zd/WnY7BXufpYzuczfjlPTJTYhvvvbd81Walg5c2JHa+yZJQm7GhS9IvAd/gqc5Y88ckVSinM2L/7rM2lYaTHant6RHNxS8Y4cz85Yysbfi1sLDjcVAmxtCcMeauE4tLjt1bmpBG19kcmDRm5N0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727409436; c=relaxed/simple;
	bh=8T3aKefTQ8EcbImZnQ3oH3enNIbr1K2z17B5icgAfbA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Gzi3YW6xNcf4ERtpPtb6IuQ5hMWkckhpNHuJxv1SWiejdf3h9yr2YTrvucYVjsXSVXJ2Ecbtkr56qXZEbjM+GMXoVyP+XB0haNNKD1+k1iA7IvBJP6L2+UCJ9l+TN/edO7GlNVXqWigtFAtE/ku5attnnvx/S/aZaK8EMtATDP4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=peff.net; spf=pass smtp.mailfrom=peff.net; arc=none smtp.client-ip=104.130.231.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=peff.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=peff.net
Received: (qmail 4893 invoked by uid 109); 27 Sep 2024 03:57:13 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Fri, 27 Sep 2024 03:57:13 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 9089 invoked by uid 111); 27 Sep 2024 03:57:12 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Thu, 26 Sep 2024 23:57:12 -0400
Authentication-Results: peff.net; auth=none
Date: Thu, 26 Sep 2024 23:57:12 -0400
From: Jeff King <peff@peff.net>
To: Taylor Blau <me@ttaylorr.com>
Cc: git@vger.kernel.org, "brian m. carlson" <sandals@crustytoothpaste.net>,
	Elijah Newren <newren@gmail.com>, Patrick Steinhardt <ps@pks.im>,
	Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v5 0/8] hash.h: support choosing a separate SHA-1 for
 non-cryptographic uses
Message-ID: <20240927035712.GH567395@coredump.intra.peff.net>
References: <cover.1725206584.git.me@ttaylorr.com>
 <cover.1727364141.git.me@ttaylorr.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <cover.1727364141.git.me@ttaylorr.com>

On Thu, Sep 26, 2024 at 11:22:27AM -0400, Taylor Blau wrote:

> Range-diff against v4:
> -:  ---------- > 1:  6f1ee91fff finalize_object_file(): check for name collision before renaming
> -:  ---------- > 2:  133047ca8c finalize_object_file(): refactor unlink_or_warn() placement
> 1:  ed9eeef851 ! 3:  41d38352a4 finalize_object_file(): implement collision check
> [...]
> 2:  3cc7f7b1f6 = 4:  611475d83e pack-objects: use finalize_object_file() to rename pack/idx/etc
> 3:  8f8ac0f5b0 = 5:  9913a5d971 sha1: do not redefine `platform_SHA_CTX` and friends
> 4:  d300e9c688 = 6:  65de6d724d hash.h: scaffolding for _unsafe hashing variants
> 5:  af8fd9aa4e = 7:  3884cd0e3a Makefile: allow specifying a SHA-1 for non-cryptographic uses
> 6:  4b83dd05e9 ! 8:  62abddf73d csum-file.c: use unsafe SHA-1 implementation when available

Funny range-diff, but I think those patches are here in the series as
expected.

Anyway, the result looks good to me!

-Peff
