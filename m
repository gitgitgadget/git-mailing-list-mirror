Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=217.216.95.84
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792977460;
	b=yXUOtTaVZHkNvZOIZLYIn5Ez0rk3IMrHB6R+b5nioE2x0azAOkuz1S/zRYJ+EU8Tq8Ew
	 hpzik0Yuidg0cEXWuv22aVM866MKei8+7wz9kRo/muIcLb0m1v1qu5QlhYHvsJjy0UsfE
	 LCiBADN6RgfD1RMlkSPICO/C0R7a8sEg1tqeQHG5K4eQ0cM1GeHuP2mUXasb8NCzO0NlR
	 XWlvLWkwZh+e8ccIr3owHXMbFDfH1Y42L6oOKHBOEEadETL9DSrRbzyGUYcCw0ATBIrk1
	 pn8GCeCNIaaGtRnF6nO3NiyMwpF7qKS9FVPIAdOU0I/E/WM6G7niemVwjR8/mwTBSzQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792977460;
	h=DMARC-Filter:Received:DKIM-Signature:Received:Received:Received:Date:
	 From:To:Cc:Subject:Message-ID:References:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To;
	bh=2jL3uRzX+TVFSs+4iDPmn4MzR/ibTb7WPrV9c2zzMTc=;
	b=0LjiXtKCl/tBSkqoxxxnxySKocrBFTxf+AzGi1USS1j7JttatiqGVy1Eokf28W+tbtQW
	 us0RJZhm/OHimC1alUQbsseHeKzEkLbFl/S0oqG2ihLKMdCURQXKC41YWOpJWBloGdDU4
	 fbR3RoBJj8rvCCC9wHknq/Bv05Ln6gVcnBSuQGvrfvIa22sjxLCRHks3mZzlFOx/BPgJY
	 iZbNwk74ouFzDjwrUmIplAt/wZPZIVTzGZJGAryHemiwrwE4JgCfPoLLRty0hAtsWyzjk
	 7qaoXDVjrHrQ+aQSK6hUvXFdc6+MNWsRw6Jem7rOXnbb80vg/iKJHSeSl785X6VFS7w==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=peff.net;
	spf=pass smtp.mailfrom=peff.net;
	dkim=pass header.d=peff.net header.i=@peff.net header.a=rsa-sha256 header.s=20240930 header.b=UrbQv01n;
	arc=none smtp.remote-ip=217.216.95.84
Received: from cloud.peff.net (cloud.peff.net [217.216.95.84])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5C1F7606A31B
	for <git@vger.kernel.org>; Mon, 26 Oct 2026 01:17:39 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 5C1F7606A31B
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=peff.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=peff.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=peff.net header.i=@peff.net header.a=rsa-sha256 header.s=20240930 header.b=UrbQv01n
Received: (qmail 31959 invoked by uid 106); 26 Oct 2026 01:17:32 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=peff.net; h=date:from:to:cc:subject:message-id:references:mime-version:content-type:in-reply-to; s=20240930; bh=hUKX4KA7SlTC161HGbn1NRfsGCmqyThvZ+biyLYm/CA=; b=UrbQv01n7dhvYjR5KQ0ov/R1uLVA9t62bSOvaja7GPTk0eSamP4YHLMIVTCQc3atnv+PU21DRWfOu8/lzIVagTZne2enEJr/Mev2OMvWrEJLGjlTe+sirsJciUwKWUDoKCWznOL7N+h2UQlpuudAXcOHEYU1gmU5+/nGear3vQYoj8xHuw2ygQAQGYAxFQk0U/uOf7cIM6pVcFGG7e6TPqCrL8g3VxcWfEA2340EiocNnuEW6XYkpbvGJwqkGHqavHy8BJFXH5npAJc/pLuKtu8w66iThgpPev4rESWbtjbORSx4CrRj2vfgMUxM3PGLx0Uq61a6pLb+FGx92ktyUw==
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Mon, 26 Oct 2026 01:17:32 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 251820 invoked by uid 111); 26 Oct 2026 01:17:32 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Sun, 25 Oct 2026 21:17:32 -0400
Authentication-Results: peff.net; auth=none
Date: Sun, 25 Oct 2026 21:17:31 -0400
From: Jeff King <peff@peff.net>
To: Tuomas Ahola <taahol@utu.fi>
Cc: Junio C Hamano <gitster@pobox.com>,
	Phillip Wood <phillip.wood123@gmail.com>,
	Emily Shaffer <nasamuffin@google.com>, git@vger.kernel.org,
	Justin Tobler <jltobler@gmail.com>
Subject: Re: [PATCH] Documentation: propose community voting process
Message-ID: <20261026011731.GA3575069@coredump.intra.peff.net>
References: <summit-2026.94e33e9ddf234334.06@ttaylorr.com>
 <20261021200341.378978-1-emilyshaffer@google.com>
 <CAJoAoZnhc6Tjm9m9dmTA6UD18HzkxAv2_ifB5x74ectqX8YieA@mail.gmail.com>
 <b36dcec9-ad9c-4ddd-b3e1-e246d2fc093e@gmail.com>
 <xmqq4iedc99a.fsf@gitster.g>
 <20261024111856.8s8qu%taahol@utu.fi>
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
In-Reply-To: <20261024111856.8s8qu%taahol@utu.fi>

On Sat, Oct 24, 2026 at 02:18:56PM +0300, Tuomas Ahola wrote:

> Junio C Hamano <gitster@pobox.com> wrote:
> 
> > [...]
> > I previously mentioned "topic count", but commits are far easier to
> > count.  So instead of requiring two topics in released versions,
> > perhaps requiring five commits would be easier to implement and
> > explain.
> > 
> 
> Quoting the summit notes:
> 
> } * Emily: Have we used a voting process for something like this before?
> } 
> } * Patrick: We need proposals and a vote. Who would be allowed to vote?
> } 
> } * Peff: Active developers with a track record; perhaps a threshold such
> }   as 50 merged patches.
> } 
> 
> So it seems that Peff's proposed threshold was substantially higher
> than what has been put forth in this thread.  Any comments on that?

I'm a bit behind on the list and haven't been following this discussion
closely yet, but I'll just say: the number 50 was made up by me on the
spot. So I wouldn't read too much into it.

But if somebody is picking a number, looking at "git shortlog -ns
--no-merges | sort -rn" may be interesting, just to get a sense of how
many people we are talking about:

  - there are 44 people with >= 200 commits
  - there are 133 people with >= 50 commits
  - there are 439 people with >= 10 commits
  - there are 2388 people with >= 1 commit

At some point it gets kind of unwieldy.

I saw proposals elsewhere to cut it by time. I think "N commits in the
last M years" is awkward, because there are people who have been around
for a long time with steady but slow participation steady-but-slow
participation. But if you just intersect "N commits over all time" and
"has _any_ commits in the last M years", then you can get a table like:

total    | Active in the last N years
commits  |  N=1    N=2    N=3    N=5
----------------------------------------------------
    200  |   17     22     24     30
     50  |   34     47     56     67
     10  |   71    104    124    155
      1  |  239    357    457    628

Those aren't necessarily perfect metrics, but if we consider them good
enough and just want to tune the parameters, we could probably pick a
spot in the table that has about the number of votes we'd want to deal
with.

-Peff
