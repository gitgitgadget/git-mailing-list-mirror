Received: from cloud.peff.net (cloud.peff.net [217.216.95.84])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 19E66146A66
	for <git@vger.kernel.org>; Fri, 15 May 2026 03:53:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.216.95.84
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778817229; cv=none; b=TXOBmUw8jrRbA0T11lGreLM0AkavcV1ppGUlHHagMDnnfk9+4cZEvvFNZIWwGmzqrCN2tiqmhr9QS3UrYVuYoWvK1W3AZ3aLom5URUTSQWl+hQ/vJuGPryc5bbxej+ZHheSjZSmhDDHDTsWyZWB5BWXhiojtS3UEKH6/UD/884U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778817229; c=relaxed/simple;
	bh=j6eNKrN1eFyySMx6qihO/8H81FLkZsb8VJlIZjjKemg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=rmOKs63mpL8Jm/R2s6tcCukCzUU2qBDKWja1dpYj6j6aKISpZbHH64xdxjj3i/8O0kM/5icT//hsZd1OWOo+gYb2kJGMzuYRWeeSJGfkjLaBTz7CcNbbKd6dccgdcPKn/2ZAydkXsdwStAa+Cq5r3vsZNNhqct2JoXaM5OD9Z3M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=peff.net; spf=pass smtp.mailfrom=peff.net; dkim=pass (2048-bit key) header.d=peff.net header.i=@peff.net header.b=Y4s871Tt; arc=none smtp.client-ip=217.216.95.84
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=peff.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=peff.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=peff.net header.i=@peff.net header.b="Y4s871Tt"
Received: (qmail 52598 invoked by uid 106); 15 May 2026 03:53:40 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=peff.net; h=date:from:to:cc:subject:message-id:references:mime-version:content-type:content-transfer-encoding:in-reply-to; s=20240930; bh=j6eNKrN1eFyySMx6qihO/8H81FLkZsb8VJlIZjjKemg=; b=Y4s871Ttfh1n1yzQfB4FFhLpqqRFKepv0GTa+xBs4rr/fuoTI5j7CvYRX7fx8iX76f7qlsz6Zk9uZRGvMXXM3buwRmn5TNia/jsrEGaDse/72ypWkWcoPS35fXlx3n6w9pvTpbEvQv9UzVFGUYtNz6m1Ykt4aOk7MMJNe0HgJxmh5yRbAC9R6NTb1Vv1HkqgIoGNrznZV1riVIjTv8fU57bJ6gs4FE/obt52F/tIO2YLhVsbH+tqcokkHBAxwjeJrR8UWnT5Yz1L761jUzjT2zNHMlFAek6N9ilZFo4o1W83hez6M8wxC3D+07PGYYZMYU3F1Otgh0DNTvyNkKAO/A==
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Fri, 15 May 2026 03:53:40 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 96198 invoked by uid 111); 15 May 2026 03:53:39 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Thu, 14 May 2026 23:53:39 -0400
Authentication-Results: peff.net; auth=none
Date: Thu, 14 May 2026 23:53:39 -0400
From: Jeff King <peff@peff.net>
To: =?utf-8?B?UmVuw6k=?= Scharfe <l.s.r@web.de>
Cc: git@vger.kernel.org
Subject: Re: [PATCH 1/4] strbuf: add strbuf_add_uint()
Message-ID: <20260515035339.GA75627@coredump.intra.peff.net>
References: <20260512115603.80780-1-l.s.r@web.de>
 <20260512115603.80780-2-l.s.r@web.de>
 <20260512184238.GC70851@coredump.intra.peff.net>
 <60b1ef2a-3b12-449e-be0b-cb206425c80c@web.de>
 <20260513162232.GB103037@coredump.intra.peff.net>
 <20260513164948.GE103037@coredump.intra.peff.net>
 <f51cdd89-dab1-44f3-8f63-7d34f6fbbba5@web.de>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <f51cdd89-dab1-44f3-8f63-7d34f6fbbba5@web.de>

On Thu, May 14, 2026 at 01:09:24PM +0200, René Scharfe wrote:

> > And btw, one final thing to look at if you are interested in
> > micro-optimizing strbufs: using intrinsics for overflow detection.
> > 
> > Right now we use unsigned_add_overflows(), and then do the actual add.
> > Using __builtin_add_overflow() might be faster.
> Curious.  Clang and GCC emit the same instructions for our
> unsigned_add_overflows() vs. __builtin_add_overflow() on x64, but clang
> on ARM64 fails to elide the comparison: https://godbolt.org/z/91d35KofM

Ah, neat. I always assumed there was low-hanging fruit to pick here, but
it sounds like the compiler is (usually) more clever than I expected.

-Peff
