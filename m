Received: from cloud.peff.net (cloud.peff.net [104.130.231.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F2E8B405CC
	for <git@vger.kernel.org>; Wed, 15 May 2024 06:49:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=104.130.231.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715755755; cv=none; b=ASHvxAlyWrAFBxyQJLqTIwcgQVeAXUvlXoTi9UAT3WeXBf1eFqoTVZI/QBYCPYOQ4RBKxzewHhvTr3SUugLg+k7/yT+ohhsy8eYjmaPeKgUEllxsbTQPbJiOQB1yiq+JN8E4O+UVhXJArTjcwe0ZFKvBb/mAyUHiW3L+oqmfd88=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715755755; c=relaxed/simple;
	bh=Ms2Cz8KhK/rm2vnFPxUfnLXAJPcMJM3u4rU9e7Lts6M=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=lbKoTxKq6PpPZH6GT3Bw2IriuEpWbBoBH49cImOFkbQfPfwswzDp0A/2dU8x+/kWc/q3lr7dRxEbBjFFTOBYfsl9zEMW71Oc32QQrGvM5DMYsoWxx9FqDAOcpc9HdNCM7CpWZO8QVAEOmIQ/i8zurwsL18C2hTOb8SEa9SsmqbQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=peff.net; spf=pass smtp.mailfrom=peff.net; arc=none smtp.client-ip=104.130.231.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=peff.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=peff.net
Received: (qmail 15871 invoked by uid 109); 15 May 2024 06:49:13 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Wed, 15 May 2024 06:49:13 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 30996 invoked by uid 111); 15 May 2024 06:49:17 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Wed, 15 May 2024 02:49:17 -0400
Authentication-Results: peff.net; auth=none
Date: Wed, 15 May 2024 02:49:12 -0400
From: Jeff King <peff@peff.net>
To: Patrick Steinhardt <ps@pks.im>
Cc: git@vger.kernel.org, Karthik Nayak <karthik.188@gmail.com>,
	Phillip Wood <phillip.wood123@gmail.com>,
	Junio C Hamano <gitster@pobox.com>,
	Justin Tobler <jltobler@gmail.com>,
	Kristoffer Haugsbakk <code@khaugsbakk.name>
Subject: Re: [PATCH v3 07/10] refs: root refs can be symbolic refs
Message-ID: <20240515064912.GF110841@coredump.intra.peff.net>
References: <cover.1714398019.git.ps@pks.im>
 <cover.1714637671.git.ps@pks.im>
 <92a71222e1067ca4ce9ecaaa555d78d0cce0d9d0.1714637671.git.ps@pks.im>
 <20240503181339.GH3631237@coredump.intra.peff.net>
 <ZkQ3EiL1OY10Y2JP@tanuki>
 <ZkQ8mDrBB2eGg8Ns@tanuki>
 <20240515062220.GC110841@coredump.intra.peff.net>
 <ZkRXyH0dX3At3vDm@tanuki>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <ZkRXyH0dX3At3vDm@tanuki>

On Wed, May 15, 2024 at 08:35:52AM +0200, Patrick Steinhardt wrote:

> > Yeah, and I'd expect that the more-strict check_refname_format() that I
> > proposed elsewhere would be in the same boat. The only reason I used the
> > "_syntax()" variant is that it was obviously wrong to do existence
> > checks there. Once those are gone, then naturally it should be able to
> > rely on is_root_ref() itself.
> 
> This series hasn't been queued/merged yet, right? Do you plan to reroll
> it? I think that the changes in there are a good complementary addition
> to the clarifications in my patch series.

Correct, I don't think Junio picked it up. It needed a re-roll anyway,
so I'd plan to do it on top of your patches, assuming they are on track
to get merged (and it sounds like there are no real objections).

-Peff
