Received: from cloud.peff.net (cloud.peff.net [104.130.231.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F2E52200CB
	for <git@vger.kernel.org>; Tue,  4 Feb 2025 02:35:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=104.130.231.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738636523; cv=none; b=HHqilK00HYG8YfeD0UIjSwl6fGJt1tecnERwEc20fHIPgtR/RGRNEgq9iAS/wlQQbHlCYdUL51ix4KY2V73VxJBPfokLZqVF8kHHe+5k9vfvzXYpll+YHA7tNAVG3+yTTP4c7mjqBWkhKHdFXcgd00wHcKBcSRJdCOIQGc22mDI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738636523; c=relaxed/simple;
	bh=OIsipeDUxAMwnCt5Ke5bSnEA8/is2KPL1MMuMYn1qMI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=A4NVHTmj5fVJPnLS1RAxxylvYR5Fae3oMn07/CkTkMaXo5HHGUziHa0FXNyHABIWkTlcVoM/r8opHlZNUN2f8GJbpA+EuuRT7OsI5V0af4lvQBMSFfNjFYzZipNTocX3OZ8wTx4Z8SZXZC8ZLmjlQbigYHZ0W4evC71/1IZXEzY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=peff.net; spf=pass smtp.mailfrom=peff.net; dkim=pass (2048-bit key) header.d=peff.net header.i=@peff.net header.b=RsOJh4bq; arc=none smtp.client-ip=104.130.231.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=peff.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=peff.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=peff.net header.i=@peff.net header.b="RsOJh4bq"
Received: (qmail 21786 invoked by uid 109); 4 Feb 2025 02:35:20 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=peff.net; h=date:from:to:cc:subject:message-id:references:mime-version:content-type:in-reply-to; s=20240930; bh=OIsipeDUxAMwnCt5Ke5bSnEA8/is2KPL1MMuMYn1qMI=; b=RsOJh4bqMHhwHzAJorB1T76ZE6Ctxuiok13PgZLc9RpxCbku+WP0xSZZb+ZRgZp8S4ony+WM38DKo50UcaD2+HG98cvpEwMe0M3PzkfkChAjY236gPbHQIVcZxs0moCxTBNT3V5E/pydQlONQmdToemVk2giZuEIPe3t4qKhi400TDNh8yXnD/GRU7rmHQzZoY+UY5upBUPHRGL5dBzOR9X5BO5Cvc94IBOZiu/FPqVLNyMQT+g6Ne5FwSYz6teCerh9Ic0+OtCn3Xfko6/Iur/kMQ+hMzUIoHG1vFybZ7fXlbnnHXSbg4oRF0y7U9htJ3NQOjYH2xS1yJmd0mJfGA==
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Tue, 04 Feb 2025 02:35:20 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 30052 invoked by uid 111); 4 Feb 2025 02:35:22 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Mon, 03 Feb 2025 21:35:22 -0500
Authentication-Results: peff.net; auth=none
Date: Mon, 3 Feb 2025 21:35:18 -0500
From: Jeff King <peff@peff.net>
To: Junio C Hamano <gitster@pobox.com>
Cc: git@vger.kernel.org
Subject: Re: What's cooking in git.git (Jan 2025, #06; Wed, 22)
Message-ID: <20250204023518.GA23954@coredump.intra.peff.net>
References: <xmqqbjvyv510.fsf@gitster.g>
 <20250123003613.GA3900660@coredump.intra.peff.net>
 <xmqq5xm6uwip.fsf@gitster.g>
 <20250131233452.GB3544301@coredump.intra.peff.net>
 <xmqq1pwi5yt9.fsf@gitster.g>
 <20250201022946.GA4088801@coredump.intra.peff.net>
 <xmqqseov3oic.fsf@gitster.g>
 <xmqqo6zjyw4a.fsf@gitster.g>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <xmqqo6zjyw4a.fsf@gitster.g>

On Mon, Feb 03, 2025 at 05:51:33AM -0800, Junio C Hamano wrote:

> After seeing a few of your messages that begin with "Coverity
> complains ...", I appreciate them a lot.  Earlier I was naively
> hoping that triage-and-hand-off-to-original-author would be much
> less work but no, we very much need to somehow find a way to push
> the triaging part to individual topic authors or this thing will not
> scale.

Yeah, there's definitely some human intelligence needed to pick apart
Coverity (and I probably only end up reporting a portion of what it
mentions; some are just nonsense, and some are old and probably
unimportant issues).

OTOH I basically end up triaging them when they hit 'next' anyway. So
unless there are a lot of topics that hit 'jch' but never make it to
'next', it's really just moving the workload around in time.

The thing that would increase workload is if I end up spending time on
patches whose issues would have been caught during regular review (or
maybe even already were, racing with them making it into 'jch').

> Perhaps I can control the rate of topics that trickle into 'jch'
> from 'seen' to keep them a bit more manageable somehow?
>
> If an iffy topic that begins its life in 'seen' gets rerolled number
> of times while there, but after the final reroll before getting
> merged to 'jch' (because it was marked as "Will merge to 'next'?" or
> better in the What's cooking draft), it never gets rerolled until it
> hits 'next', then your workload would not change compared to the
> days back when you built yours on 'next'.

So, yeah, this. The rate of topics entering is not so big a deal as the
quality of topics when they make the transition to jch. As you note...

> Of course, the question then becomes "who will vet these topics so
> that they do not need a big reroll before it hits 'jch'?", and we
> are back to square one?

..this work still has to happen somewhere. But I think people reviewing
and discussing patches is one way that the load is spread out. If review
settles down on a topic then maybe that's a sign it's ready to be looked
at.

Of course the effort to look at Coverity could be spread out, too. It's
just hard to do because their interface is closed-ish (everybody needs
to make their own account, we can't share links, etc). And also because
there's a coordination problem. I mostly look at the "new defects since
the last build" list since there's so much old noise. But I don't know
how I'd mark an uninteresting issue as "I looked at this, and nobody
else needs to".

I guess if we had a bot that sent a summary of Coverity results to the
list, that thread could be a central point for discussion. But their
notification emails have no details; most of the richness is in their
web interface. I think it would be hard to condense that into an email
that would be useful to people. But maybe I could mine it with a script
or something.

I dunno. I think there are possibilities there, and if the results were
incredibly useful I'd be more excited about spending time on it. ;) For
now let's try it with me following jch and see how that goes.

-Peff
