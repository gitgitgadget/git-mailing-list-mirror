Received: from cloud.peff.net (cloud.peff.net [104.130.231.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5731C3587DF
	for <git@vger.kernel.org>; Fri,  5 Dec 2025 18:40:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=104.130.231.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764960024; cv=none; b=AwUEpsenbONVm523jRxFid1Z+/2jK6/SbHu+/T4tTzeEu2/DKfTPkYiI7DGKCU/IRtC0nwMUMAr1U6zzRKyPqP1gbEMGjTdJtFoNwGlwOzTvojNM4Ewqjg3RA5rg+eoaEtZwCTvBabnAgfM20eCz+GSPvoLT7nYNlSKTVRCqXdg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764960024; c=relaxed/simple;
	bh=3Vux7asuGf3K5W7ohxYHMN2QHfN97kkJrlmOotZkfBs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=k2lnFNG6l6GS0xAKLo34qIwKfLNzuW26dc6uJIdWBbOPF+ixazmf2+5+eWUH+3FWsGDikoa98nefeswvyfMIMwnIDFvEE2tO3v051VyjELi6JeqqstVgM5C0tCXr3Q2t7VhngK3HMA7F8G/09q7c8Hp9AcRbSwl2hQS/Yjw2sZQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=peff.net; spf=pass smtp.mailfrom=peff.net; dkim=pass (2048-bit key) header.d=peff.net header.i=@peff.net header.b=ZHOLMDeu; arc=none smtp.client-ip=104.130.231.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=peff.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=peff.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=peff.net header.i=@peff.net header.b="ZHOLMDeu"
Received: (qmail 271919 invoked by uid 109); 5 Dec 2025 18:40:21 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=peff.net; h=date:from:to:cc:subject:message-id:references:mime-version:content-type:in-reply-to; s=20240930; bh=3Vux7asuGf3K5W7ohxYHMN2QHfN97kkJrlmOotZkfBs=; b=ZHOLMDeuRZV9nACBw+v544E4l5LHJV4fHwaEX9H6BSp76VgMWxqlEU6k2YTxRrw2hILazm1kn99YbTL5qMzSLzHE0KE5aLJ6ocYE2ebmd/n/Up3pEm5BIYl0DUoA+gpLYT6vKjQVQyOSiG9qa+d3FJuEEJMSn6sE1r9scwGUScDEuSqOhlMcbSmap/C5qf2CKmODphFClgVSCqYe5ggXfYeh5bWpOJceXIDgJFzPKJL5lcg+1D3Lzhtd6p++zq4FO1RjNOKYag3EnNJ7g6XdHs2wys89ahANv5nfVcQw7JBiv2P8LsK2nW/UcrlLC7WfHedorvVb9SbxVdzmTIk+eg==
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Fri, 05 Dec 2025 18:40:21 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 340471 invoked by uid 111); 5 Dec 2025 18:40:22 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Fri, 05 Dec 2025 13:40:22 -0500
Authentication-Results: peff.net; auth=none
Date: Fri, 5 Dec 2025 13:40:20 -0500
From: Jeff King <peff@peff.net>
To: Patrick Steinhardt <ps@pks.im>
Cc: git@vger.kernel.org, Phillip Wood <phillip.wood123@gmail.com>
Subject: Re: [PATCH 1/2] t/unit-tests: update clar to 39f11fe
Message-ID: <20251205184020.GB33447@coredump.intra.peff.net>
References: <20251205-b4-pks-clar-update-v1-0-fd70aac2ab90@pks.im>
 <20251205-b4-pks-clar-update-v1-1-fd70aac2ab90@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20251205-b4-pks-clar-update-v1-1-fd70aac2ab90@pks.im>

On Fri, Dec 05, 2025 at 01:57:52PM +0100, Patrick Steinhardt wrote:

> -#define cl_assert_equal_i(i1,i2) clar__assert_equal(CLAR_CURRENT_FILE,CLAR_CURRENT_FUNC,CLAR_CURRENT_LINE,#i1 " != " #i2, 1, "%d", (int)(i1), (int)(i2))
> -#define cl_assert_equal_i_(i1,i2,note) clar__assert_equal(CLAR_CURRENT_FILE,CLAR_CURRENT_FUNC,CLAR_CURRENT_LINE,#i1 " != " #i2 " (" #note ")", 1, "%d", (i1), (i2))
> -#define cl_assert_equal_i_fmt(i1,i2,fmt) clar__assert_equal(CLAR_CURRENT_FILE,CLAR_CURRENT_FUNC,CLAR_CURRENT_LINE,#i1 " != " #i2, 1, (fmt), (int)(i1), (int)(i2))
> +#define cl_assert_compare_i_(i1, i2, cmp, error, ...) clar__assert_compare_i(CLAR_CURRENT_FILE, CLAR_CURRENT_FUNC, CLAR_CURRENT_LINE, 1, cmp, \
> +									     (i1), (i2), "Expected comparison to hold: " error, __VA_ARGS__)

OK, so "i" use to always mean "int", and now...

> +#define cl_assert_compare_i(i1, i2, cmp, error, fmt) do { \
> +	intmax_t v1 = (i1), v2 = (i2); \
> +	clar__assert_compare_i(CLAR_CURRENT_FILE, CLAR_CURRENT_FUNC, CLAR_CURRENT_LINE, 1, cmp, \
> +			       v1, v2, "Expected comparison to hold: " error, fmt, v1, v2); \
> +} while (0)

we use intmax_t. That seems OK, and lets us handle any size integer; the
caller just needs to distinguish signed from unsigned (having "i"
meaning "signed" is a little funny, but I don't have a better
suggestion).

This one is a little odd, though:

> +#define cl_assert_equal_i_fmt(i1, i2, fmt) cl_assert_compare_i_(i1, i2, CLAR_COMPARISON_EQ, #i1 " == " #i2,  fmt " != " fmt, (int)(i1), (int)(i2))

Here we still cast to int. I guess we have to in order to keep custom
"%o" and friends working. They probably ought to be using PRIoMAX, but
that would require changes to the tests to do so (and I wonder if we
might hit any portability issues).

-Peff
