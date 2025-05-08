Received: from cloud.peff.net (cloud.peff.net [104.130.231.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1765E2797B2
	for <git@vger.kernel.org>; Thu,  8 May 2025 20:24:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=104.130.231.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746735880; cv=none; b=U1ozrJ8fO863hJzAkHxJLq8nHNqPkW/Vble/8KD/Mr49wftkkRoj0lejqHX6nSNj+qE/BH/mDDo8Od68+UUF19iDfYVq2bOaooSbC1PF3T4d3VYVfaoIFKU8Y0y2bSAFv+otJJQ04FqfjRjKnNCOT/U4/TCLYq0YCk2Ayiq1YWs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746735880; c=relaxed/simple;
	bh=tGZy554nXgRLZy2rhZAdrWyKj3XfvcjfvIew1gs+75o=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Bd2QwbitHG9IYA04D8BDJmm6+RevXXENAYiSEe3OTt83NMnF119oQSp3or/9xVMsMh/rkY+Gjd1QfoNHYsVRKlnIkWtk+kHzZXLVgUcifM0RvvPZnSnfzjVjcEaS9x75LXYehslTl9nMufhWvLtk2mXt+YTC8CouDKjYg2YgX/Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=peff.net; spf=pass smtp.mailfrom=peff.net; dkim=pass (2048-bit key) header.d=peff.net header.i=@peff.net header.b=YykVHL1I; arc=none smtp.client-ip=104.130.231.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=peff.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=peff.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=peff.net header.i=@peff.net header.b="YykVHL1I"
Received: (qmail 29332 invoked by uid 109); 8 May 2025 20:24:38 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=peff.net; h=date:from:to:cc:subject:message-id:references:mime-version:content-type:content-transfer-encoding:in-reply-to; s=20240930; bh=tGZy554nXgRLZy2rhZAdrWyKj3XfvcjfvIew1gs+75o=; b=YykVHL1I9lHZ+B4O774Rmb6mzg4tj3gmpyqu0FoWste/GzM26PZsmr+O1qfkXGYG8BmB+4V1bYYZYWB7xHTWMVl3XpHBnDkye8XxVVu1/lEw6qjKOHNxZDxuk8WHIwsPgzfPtkuVkG5fA3KRRRzyHqeUTdoFVtLiqjGmMxj60EhD6fagKSu4QBvFHeIW19CqZeSuN3p+7F6O6hJKgSmkseXAN5TsqVx+lz115a2A4a4QxzDncsGeTqGi7RpPgTypOZHqKc4q8f9JQAbaDzavfTbycurHTL/RK5nPm3l5b8upqjuN8oDPY2h8GnWo7Ag2F/Ur2y8LRtPqWzpWgQuP5g==
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Thu, 08 May 2025 20:24:38 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 20334 invoked by uid 111); 8 May 2025 20:24:39 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Thu, 08 May 2025 16:24:39 -0400
Authentication-Results: peff.net; auth=none
Date: Thu, 8 May 2025 16:24:37 -0400
From: Jeff King <peff@peff.net>
To: Kristoffer Haugsbakk <kristofferhaugsbakk@fastmail.com>
Cc: git@vger.kernel.org, Patrick Steinhardt <ps@pks.im>,
	Adam Dinwoodie <adam@dinwoodie.org>,
	Ramsay Jones <ramsay@ramsayjones.plus.com>,
	Taylor Blau <me@ttaylorr.com>
Subject: Re: Comment trailers vs. bracketed lines
Message-ID: <20250508202437.GF18229@coredump.intra.peff.net>
References: <a4472d6d1551e7c25540c4c8361bcb6b1c9f92ff.1729084997.git.ps@pks.im>
 <658fe4fa540a0a5316e11ed43f9139d5ef818ee5.1729226155.git.ps@pks.im>
 <20241018052952.GE2408674@coredump.intra.peff.net>
 <71e8e44e-dbf9-482e-a351-3a82aa1ca5dd@app.fastmail.com>
 <20241019212135.GB589728@coredump.intra.peff.net>
 <ae56dc14-bbae-4d5e-a890-20735131d484@app.fastmail.com>
 <29ff888d-9749-4fbe-9722-95dd71008a2a@app.fastmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <29ff888d-9749-4fbe-9722-95dd71008a2a@app.fastmail.com>

On Wed, May 07, 2025 at 06:41:27PM +0200, Kristoffer Haugsbakk wrote:

> > But thinking about the signoff requirement: you already have all the
> > information you need from the next trailer, namely the signoff.  In
> > other words this:
> >
> >     [kh: Added tests]
> >     Signed-off-by: Kristoffer Haugsbakk <code@khaugsbakk.name>
> >
> > Has the same information as this:
> >
> >     Comment: Added tests
> >     Signed-off-by: Kristoffer Haugsbakk <code@khaugsbakk.name>
> >
> > Because the signoff order tells you who left the comment.  So I was
> > wondering to myself why this uniform approach wasn’t used.
> >
> > † 1: Since the brackets become “non-trailer values” or something
> >    (git-interpret-trailers(1)), i.e. the discarded parts of the trailer
> >    block
> 
> I was just reminded of this: https://lore.kernel.org/git/xmqqikmce67y.fsf@gitster.g/T/#m68c22c9b7dbc9b295e923a913e9d67e3ab28a2a4
> 
> I’m just doing a little bump of this topic in case anyone has any
> thoughts.  I hope that is okay.

It is the same information _if_ there is another trailer with the ident
that comes afterwards. In our project, you'd usually have a sign-off
there. But not all projects would, and even in git.git you don't
necessarily need one, depending on what is in the comment.

That said, if I were designing trailers from scratch today, I'd probably
require something that looks more like "Comment:" just because it would
reduce the complexity of the trailer parser (and its "non trailer
portions"). But since we live in a world where we support that for
historical reasons, I don't mind using it (I find it more natural to
read, but possibly my mind is polluted by years of practice).

-Peff
