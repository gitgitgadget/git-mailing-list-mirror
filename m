Received: from cloud.peff.net (cloud.peff.net [104.130.231.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9CFE626BDAF
	for <git@vger.kernel.org>; Wed, 26 Feb 2025 22:06:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=104.130.231.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740607595; cv=none; b=P3HS/FESIQJGdVTo8Df01ZgvqgUQdGtrtJuY590jOM7Bv1ieYvOmVMpsCcZn3tvP7zypbVWNpRDluMpJ7EysrAI7z+bc6XN9VpGJSFb5pDy+8F7jUAFZa+UIonHk5HvV/66FZsHqcgpiS71BzraIZ/bgnZUX2wbUnLvj3Eoa7zQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740607595; c=relaxed/simple;
	bh=qHanT5Ato2YL/KetZPfjBvjlCHgfSSrPrqVqGutMKMw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=e50qypdAvUD1icvqFKYUn3Q1SbobdC29TCq6Q9zjmcz/v41i9U/KPho1ODLN50fAPRihnCmYoVeOMPAKhg8mSO4r21Gt29GsJ0YRUUKfz1YxgwrrtlDHrQ3OGy9iv7AbKdGOVl/r8pTiQHZpeVwiJSlpsKKjEmlI/c51N2tctCs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=peff.net; spf=pass smtp.mailfrom=peff.net; dkim=pass (2048-bit key) header.d=peff.net header.i=@peff.net header.b=L+WpBIgM; arc=none smtp.client-ip=104.130.231.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=peff.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=peff.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=peff.net header.i=@peff.net header.b="L+WpBIgM"
Received: (qmail 12922 invoked by uid 109); 26 Feb 2025 22:06:31 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=peff.net; h=date:from:to:cc:subject:message-id:references:mime-version:content-type:in-reply-to; s=20240930; bh=qHanT5Ato2YL/KetZPfjBvjlCHgfSSrPrqVqGutMKMw=; b=L+WpBIgMi5eRG+ZuvyuE9/CUHvFZdZpm9bx9/+S1txTw40dMPiMW+MMp8a4+1q2suCRDjaGZXujVkDvY7tYCMWQwrQBRkBRMTUWfbbYURrCwD8fUaQ+U3uZQwaKtozsk/7BjT14dBGnJrtBJICQqd6lbkEsr2i367CfJlnCBqAi1VO6QpEJlejlDaXBWxHdsPhbwegvhrst+6uxbn706LveA34ijkmkNjXFVybFuTh0RnEbAIRYCHvFeMEJOKg7S2GNcv+qnnS1XT0lnFFUajMHXndyPDdfxbowrfNOlQJU/6qfOYXlsta9J9G7l0F2kRDai68YepowO0FsTiuh4UQ==
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Wed, 26 Feb 2025 22:06:31 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 32281 invoked by uid 111); 26 Feb 2025 22:06:28 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Wed, 26 Feb 2025 17:06:28 -0500
Authentication-Results: peff.net; auth=none
Date: Wed, 26 Feb 2025 17:06:28 -0500
From: Jeff King <peff@peff.net>
To: Kyle Lippincott <spectral@google.com>
Cc: Yaakov Smith <Yaakov.Smith@wisetechglobal.com>,
	"git@vger.kernel.org" <git@vger.kernel.org>
Subject: Re: \b character escapes in CLI usage
Message-ID: <20250226220628.GA600528@coredump.intra.peff.net>
References: <SYBPR01MB579278DD5EC6E13CA9A213FDE2C32@SYBPR01MB5792.ausprd01.prod.outlook.com>
 <20250226073822.GA21138@coredump.intra.peff.net>
 <20250226080902.GA29996@coredump.intra.peff.net>
 <CAO_smVjC=CWeAEjZjr9PPuBTkyYus59o_J9hfnpJCB-AsBE0HA@mail.gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CAO_smVjC=CWeAEjZjr9PPuBTkyYus59o_J9hfnpJCB-AsBE0HA@mail.gmail.com>

On Wed, Feb 26, 2025 at 08:38:15AM -0800, Kyle Lippincott wrote:

> > In modern versions of less you can get around it with:
> >
> >   LESS="-U --proc-tab"
> >
> > or:
> >
> >   LESS="--PROC-BACKSPACE"
> >
> > but those are new in less 632, from the last year or two. So I don't
> > think we can rely on it in our default variable, but people with recent
> > versions of less should consider setting it.
> 
> From another issue (https://github.com/gwsw/less/issues/557) I learned
> you can do this:
> 
> LESSKEY_CONTENT='#env;#version>=632 LESS=${LESS} --PROC-BACKSPACE'
> 
> I haven't tested it yet, but that might be a decent solution? I don't
> know how composable those are; e.g. if you wanted both
> --PROC-BACKSPACE on >=632 and --no-poll on >=670, I'm *assuming* you
> can do that, but I don't know what the syntax looks like.

Thanks for the pointer, I didn't know about that. I think it is fully
composable, as the "#version" conditional just applies to one line. So:

  LESSKEY_CONTENT='#env;#version>=632 LESS=${LESS} --PROC-BACKSPACE;#version >=670 LESS=${LESS} --no-poll'

However, I couldn't get even the basic version to work. Turns out that
LESSKEY_CONTENT was added in 645, and I'm running 643 from Debian
unstable).

So it kind-of works for our case if we make 645 the minimum (and don't
help versions between 632 and 645 at all). I think we could get even
hackier to support old versions like:

  # probably would be $prefix/share/git/lesskey in a real install
  fn=/tmp/lesskey
  {
	echo "#env"
	echo "#version >= 632 LESS=${LESS} --PROC-BACKSPACE"
  } >"$fn"

  # This works back to less 582. Before that we have to compile it to a
  # binary format with "lesskey" and point to it with $LESSKEY.
  LESSKEYIN=$fn git log

I guess we'd also need to put more details into setup_pager_env(). Right
now its logic is just "do not set $FOO if $FOO is already set". But we'd
probably want rules like "if $LESS is set, do not try to override it
with $LESSKEY_CONTENT".

I'm inclined to punt on it for a while. People can set up $LESS
themselves based on what they have available, and once these features
have been around for a while, we might then consider adding them to our
defaults.

-Peff
