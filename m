Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=217.216.95.84
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793774208;
	b=rGb2mddIKTUW2VKoYbNN/5xQ7uSxwzYHddkFmLOG19uqD1+dEevcm4TPZ+0KlFgJ+Fbh
	 7lppzwOiqFWGFEh87Gib73qqiF4KmqmK6UQh7jro9XvwkSb1w11SJFrWu2rOPT9nMZp0T
	 IJcFPkULUQU2pFfy6EwHPz34X3xP5dR9cz/ZDHuzpISMuOKC9phiNEHCcg1yEs3K65BtQ
	 2SgwxNFPM18uupA7bTeFxHY5ehiveDSAQW1yuRv1cXDSxGwjj2kmhcrOWQiYXoDokweEX
	 NbgpxATOrteBAjc/uvjMFH3l7RWMCJ70VBDKddsirDHjtI8QrB4KUS1YPTeCCo0q65A==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793774208;
	h=DMARC-Filter:Received:DKIM-Signature:Received:Received:Received:Date:
	 From:To:Cc:Subject:Message-ID:References:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To;
	bh=lm/Vw1hP70aF+EYRdfTH0rxDQww4d9uywcUIhb2Iif4=;
	b=mDPKNU3sBdQAqhK9I3Kfskvb3CcnRzwBK6lizhsR/J33AswqlCCcMGVzMRsR3/e/prAE
	 WBYHN8Xyc+oW/cs1RaC8IIWK6ciPrssEHIyqVlURPmLELwwqs0i2N+beFVkOXrb8QHC/9
	 xg7MlEvo6Y62x6sX0kn0hRCCexxBxuaAIPknuvpDoLnriSo577i3IXmIx/oZdvhKePBiA
	 Nbzy9/BObaMuQG1KyqveF+rsR6ZDRj0Ro9lOGZNQVwHqQ3/ilQwQujKyCllIeyfBZdPG6
	 Z8tQMarWf5+K1Nq0+6i1EdZZC4MCBQi5TjYLhiuXOI1xVVgMGo6sOdXxtEEYbRLccUw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=peff.net;
	spf=pass smtp.mailfrom=peff.net;
	dkim=pass header.d=peff.net header.i=@peff.net header.a=rsa-sha256 header.s=20240930 header.b=Q3+i9I8I;
	arc=none smtp.remote-ip=217.216.95.84
Received: from cloud.peff.net (cloud.peff.net [217.216.95.84])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 69B6B606A31B
	for <git@vger.kernel.org>; Wed,  4 Nov 2026 06:36:47 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 69B6B606A31B
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=peff.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=peff.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=peff.net header.i=@peff.net header.a=rsa-sha256 header.s=20240930 header.b=Q3+i9I8I
Received: (qmail 12329 invoked by uid 106); 4 Nov 2026 06:36:46 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=peff.net; h=date:from:to:cc:subject:message-id:references:mime-version:content-type:in-reply-to; s=20240930; bh=XENOOB1MHgw/K8yM539qIks7I/jbMK9mVHOuNuA/NVw=; b=Q3+i9I8INKi4vbnW53hXuRlTf8pKjCFn3dpUPzQG7W+YZrVgbdK8OEj1kYdj/Ju9OrQJltJjYvpEbPUGsA+3tZnyJvtvhqffXOPILfj1+3blUsrxpnqJwryLCJ0hy5HupeD6K3g03NPAAfvb7daQwJe6bUcqz21mY5RKloYH0pJx6wZ4KPsvLkTG39JN4SzldZeMS3Q2j+oKcx7tnSWmxU8tW/swn5Jv5Pnrz94F8fVAQ30b+zr26wGjZzx7RE8lyWv+jF/F6b0mEdqDjhqZyxS3OM4dBfXC0zVZQEn6S0LkKMbTxUDqtJMkLjWn9Zi+Dl6GRDvzu3Hv+L6wXQ+Btw==
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Wed, 04 Nov 2026 06:36:46 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 29642 invoked by uid 111); 4 Nov 2026 06:36:45 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Wed, 04 Nov 2026 01:36:45 -0500
Authentication-Results: peff.net; auth=none
Date: Wed, 4 Nov 2026 01:36:45 -0500
From: Jeff King <peff@peff.net>
To: phillip.wood@dunelm.org.uk
Cc: Patrick Steinhardt <ps@pks.im>, git@vger.kernel.org,
	Junio C Hamano <gitster@pobox.com>,
	Kaartic Sivaraam <kaartic.sivaraam@gmail.com>,
	Toon Claes <toon@iotcl.com>
Subject: Re: [PATCH v2 0/7] ci: consolidate test variables
Message-ID: <20261104063645.GC1543013@coredump.intra.peff.net>
References: <20261027-b4-pks-ci-test-vars-consolidation-v1-0-f28edf79bd6c@pks.im>
 <20261102-b4-pks-ci-test-vars-consolidation-v2-0-a5485c437c62@pks.im>
 <0b0a3de3-b758-4a1b-b8a0-9804b362b261@gmail.com>
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Post: <mailto:git@vger.kernel.org>
List-Help: <mailto:git+help@vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
List-Owner: <mailto:git+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <0b0a3de3-b758-4a1b-b8a0-9804b362b261@gmail.com>

On Mon, Nov 02, 2026 at 04:03:29PM +0000, Phillip Wood wrote:

> On 02/11/2026 11:17, Patrick Steinhardt wrote:
> > 
> > The series is built on top of 37b3475fb53 (The 9th batch, 2026-10-25).
> > 
> > Changes in v2:
> >    - Drop the last patch, as the reviewers seemed to favor an approach
> >      that's not compatible with my own use case for this change. We can
> >      still discuss this separately.
> 
> Fair enough, this is ready for next as far as I concerned

Me too.

-Peff
