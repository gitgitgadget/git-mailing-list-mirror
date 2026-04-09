Received: from cloud.peff.net (cloud.peff.net [217.216.95.84])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 79FDC1448E0
	for <git@vger.kernel.org>; Thu,  9 Apr 2026 20:33:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.216.95.84
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775766821; cv=none; b=uiG7sOMP4AegzarIGIWwHJi8FJhPTivcHAu7qR2xZHXjPSMqBRW1qWDrmuq7PyHviLLP/yYi5pl09o817NAlkqcKsL2pskKtAqoArY4S+5uy7Uih4z9uc7zuUzViVj7WffFmi8fCOgLm2odsdxQFn/ANeoGN9IcaFpz/D16sC3Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775766821; c=relaxed/simple;
	bh=epe1kRWJ5CQ/mu+MGw/Y+EDTuFQteiWdMvAlguRy428=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=MyUw05+FdKp4sXExAbpzYQxtjmnxb1p7Jq0Yx8VxVmWi+jAhcBj8QNl57vooG/j69Xcq3YzYvmIb5j2V4dmjehgaYy8RT9d8wqClrHDCxeIrIGrCsOF5dLT/ThBdt87losDwlu5OWLcF3KTIPrC+zPj0zQnSzyKeqC5kd3bt360=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=peff.net; spf=pass smtp.mailfrom=peff.net; dkim=pass (2048-bit key) header.d=peff.net header.i=@peff.net header.b=AoT5kir7; arc=none smtp.client-ip=217.216.95.84
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=peff.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=peff.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=peff.net header.i=@peff.net header.b="AoT5kir7"
Received: (qmail 294884 invoked by uid 106); 9 Apr 2026 20:33:39 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=peff.net; h=date:from:to:cc:subject:message-id:references:mime-version:content-type:in-reply-to; s=20240930; bh=epe1kRWJ5CQ/mu+MGw/Y+EDTuFQteiWdMvAlguRy428=; b=AoT5kir73ia5l8DcPJcUq32VpdJWlbdcf42wfKBiRY9ll+sCwexqU8qBhsierTGJRJR8V1znBjvw+/IOz/5/gaWWYDQ/p4bNJ5NiT/A3kzaEgv405kCDr3RXO5zmAy6iZkzCqDAbl6K6eiV8T8AqT7/3Yfsnp/uXd5DzyaMxhkuodX1tifr9gb6tY40YGYOJdeFOSi9Z5YJeCnJctw2SkDCNqxP0LmyU7nYgZ7aRhiSPEpa33nok68grNwQp0MNBwwLRfi2DGl+OhDyXHK7qA09zo7sBWkT5nZfh8CJImpWuhhBgJXqsMFK/pCzGg1PHJlnOw+Fj5VtndLSM81lFTg==
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Thu, 09 Apr 2026 20:33:39 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 487339 invoked by uid 111); 9 Apr 2026 20:33:39 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Thu, 09 Apr 2026 16:33:39 -0400
Authentication-Results: peff.net; auth=none
Date: Thu, 9 Apr 2026 16:33:38 -0400
From: Jeff King <peff@peff.net>
To: rsbecker@nexbridge.com
Cc: 'Patrick Steinhardt' <ps@pks.im>,
	"'brian m. carlson'" <sandals@crustytoothpaste.net>,
	'Junio C Hamano' <gitster@pobox.com>, git@vger.kernel.org
Subject: Re: Git 2.54.0-rc1, subtests of t5310, t5326, t5327
Message-ID: <20260409203338.GB3076846@coredump.intra.peff.net>
References: <20260408173949.GB2850002@coredump.intra.peff.net>
 <xmqq4illz5g9.fsf@gitster.g>
 <014e01dcc793$8a9bab90$9fd302b0$@nexbridge.com>
 <xmqqqzopxkxa.fsf@gitster.g>
 <016b01dcc79e$87472860$95d57920$@nexbridge.com>
 <xmqqcy09xh53.fsf@gitster.g>
 <20260408223233.GB2873736@coredump.intra.peff.net>
 <adbwyvQ-R2Ag1vox@fruit.crustytoothpaste.net>
 <addgkjiB80pgKw69@pks.im>
 <021a01dcc827$4e6342c0$eb29c840$@nexbridge.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <021a01dcc827$4e6342c0$eb29c840$@nexbridge.com>

On Thu, Apr 09, 2026 at 09:46:39AM -0400, rsbecker@nexbridge.com wrote:

> >--- a/git-compat-util.h
> >+++ b/git-compat-util.h
> >@@ -690,14 +690,8 @@ static inline uint64_t u64_add(uint64_t a, uint64_t b)
> >  * to override this, if the definition of SSIZE_MAX given by the platform
> >  * is broken.
> >  */
> >-#ifndef MAX_IO_SIZE
> >-# define MAX_IO_SIZE_DEFAULT (8*1024*1024) -# if defined(SSIZE_MAX) &&
> >(SSIZE_MAX < MAX_IO_SIZE_DEFAULT) -#  define MAX_IO_SIZE SSIZE_MAX -# else
> -
> >#  define MAX_IO_SIZE MAX_IO_SIZE_DEFAULT -# endif -#endif
> >+#undef MAX_IO_SIZE
> >+#define MAX_IO_SIZE 128
> [...]
> Please do not make the change in git-compat-util. This will break xwrite().
> We already have MAX_IO_SIZE working and verified from years ago. Changing
> that will remove our platform from being supportable.

I think that was just there to demonstrate that the patch works
regardless of the size, and would not be included in the final.
Building with:

  make CFLAGS=-DMAX_IO_SIZE=128

is probably a nicer way of doing that, though. ;)

-Peff
