Received: from cloud.peff.net (cloud.peff.net [104.130.231.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 17D2E4D8A1
	for <git@vger.kernel.org>; Thu, 30 May 2024 07:14:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=104.130.231.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717053275; cv=none; b=Q5jCkzYsQTMycpjCTE9d73sKop0edolWNxPWlHkUjTssnVBU35ou10SFt3eDlrBZ51rTX4MbC9Ex9i1RYE69SBK3DsCNs30LAhut45XuqQnqtkzu04VOg2NZi+XR3Dytrj+M35cN56F59zRT48gH59ZoRzpBpa/yED8elwfkonU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717053275; c=relaxed/simple;
	bh=8Qt2N+EYDZBfr3X0CFoh6ERj1veUn5r2p1JRknbJrsE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=F0llHOIR4baoIsE9RdHnle6hnbTBJwuoBIbvMrSNxdcZa87pZYQtOHSZYsWNBbUwSNW9JzGs+KeqZ5PYRVaniv9ShNyYvBLp/T7xOfpRKf+ZWv0MpnyIN2cNqoUZ+Hq6LBQEXZfPBXU0Mg1pkCvLNG5a6DN3qhnrfybJ8f9oaeA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=peff.net; spf=pass smtp.mailfrom=peff.net; arc=none smtp.client-ip=104.130.231.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=peff.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=peff.net
Received: (qmail 16953 invoked by uid 109); 30 May 2024 07:14:33 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Thu, 30 May 2024 07:14:33 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 28139 invoked by uid 111); 30 May 2024 07:14:30 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Thu, 30 May 2024 03:14:30 -0400
Authentication-Results: peff.net; auth=none
Date: Thu, 30 May 2024 03:14:32 -0400
From: Jeff King <peff@peff.net>
To: Taylor Blau <me@ttaylorr.com>
Cc: git@vger.kernel.org, Elijah Newren <newren@gmail.com>,
	Patrick Steinhardt <ps@pks.im>, Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v2 0/8] midx-write: miscellaneous clean-ups for
 incremental MIDXs
Message-ID: <20240530071432.GD1949834@coredump.intra.peff.net>
References: <cover.1716482279.git.me@ttaylorr.com>
 <cover.1717023301.git.me@ttaylorr.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <cover.1717023301.git.me@ttaylorr.com>

On Wed, May 29, 2024 at 06:55:15PM -0400, Taylor Blau wrote:

> This is a small reroll of my series which has a grab-bag of midx-write
> related cleanups that I pulled out of a larger series to implement
> incremental MIDX chains.

These all look pretty reasonable to me. Thanks for breaking them off of
the larger series. I think it's generally nice to get things in smaller
chunks.

Sometimes it is a little tough to evaluate refactorings without seeing
the larger context in which they'd be used. But all of these were either
immediate improvements, or didn't take much imagination to see where
they'd make later things easier.

-Peff
