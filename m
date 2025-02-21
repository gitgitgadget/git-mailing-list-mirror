Received: from cloud.peff.net (cloud.peff.net [104.130.231.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4F2AB1EE028
	for <git@vger.kernel.org>; Fri, 21 Feb 2025 20:54:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=104.130.231.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740171296; cv=none; b=q5etJZMePdySJRG5lJihe6ir4LscM4AhhCuK0+JAWDdPfcKsFmVs0sxYocJy94GjgWXnJ9SvGfMbpOF+QaRjcGwrCpYXo/1ifSvJ58vyEfCIBIdI5vD+YBt/5PhVtzzoheJqqH1eSs2o5b/6lOlEgyMrZoSfkBl2eJbaVC3xSCY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740171296; c=relaxed/simple;
	bh=+UTLozpWPUpRQzhjzMvUdKGgWJbSFIMIevXrxXO4h5s=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=f/KhGNUAw1JIlmvpRjtQWUIOm1a1dKTYx4bOmW4OMzfCxqeTRqRwUzw4NDUy3n/vmrYJWzihOdVOx7/CTnrXPAnj4Q8ww+QSlM9t+hdmGP3B3J2ynVQBpoT1ScoyYKPWMJUjPbcuLLOBCowyuPlFtxz3c5Ev/qvFr6rUunRoCaw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=peff.net; spf=pass smtp.mailfrom=peff.net; dkim=pass (2048-bit key) header.d=peff.net header.i=@peff.net header.b=MBpv6310; arc=none smtp.client-ip=104.130.231.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=peff.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=peff.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=peff.net header.i=@peff.net header.b="MBpv6310"
Received: (qmail 11121 invoked by uid 109); 21 Feb 2025 20:54:52 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=peff.net; h=date:from:to:cc:subject:message-id:references:mime-version:content-type:in-reply-to; s=20240930; bh=+UTLozpWPUpRQzhjzMvUdKGgWJbSFIMIevXrxXO4h5s=; b=MBpv63106bi8K0IgrK+AwuyiRxuT68RZ4effCYcu9q+qgTOInDSjk0bM2S8NA7vSDfkypRuSZCLSq2xo9n/5v9IS+5B2F4fHhLBkh8pN03CwJ+fahBYZ/PCigx5xaM9uNyU15mpfMocIZekib326kY6fWdlBwqrO8OgtHXcSXbisv9w3n0GatNfXeXYSeSXTmL5gtE8nwOejJGBvjwKsaca0MEEHUTfL1IvSCCTDXI/3rdcBm3QdB7gFPgr7tLgn6vSnTLzoqzZxZXBZneQyJ1mUfuwv9J0NAnVwqRJf8fXmpuiE2Br4Pv8z9UScCFG/pJ1BcZ+Fx0cVYCRUdgLr1w==
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Fri, 21 Feb 2025 20:54:52 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 7971 invoked by uid 111); 21 Feb 2025 20:54:48 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Fri, 21 Feb 2025 15:54:48 -0500
Authentication-Results: peff.net; auth=none
Date: Fri, 21 Feb 2025 15:54:48 -0500
From: Jeff King <peff@peff.net>
To: Audrey Dutcher <audrey@rhelmot.io>
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
Subject: Re: [PATCH] git-compat-util.h: Bump _XOPEN_SOURCE on OpenBSD
Message-ID: <20250221205448.GA3069593@coredump.intra.peff.net>
References: <20250221180225.3176533-1-audrey@rhelmot.io>
 <xmqqeczr9guk.fsf@gitster.g>
 <CADanSV3w++kkTgedLQorKgJ15kc5bEkNvYTidRU1UbwW4jCC6Q@mail.gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CADanSV3w++kkTgedLQorKgJ15kc5bEkNvYTidRU1UbwW4jCC6Q@mail.gmail.com>

On Fri, Feb 21, 2025 at 01:41:08PM -0700, Audrey Dutcher wrote:

> > Is this a recent regression?  Blaming these two line ranges ...
> >
> > >
> > > [1] https://github.com/openbsd/src/blob/6a403588e27467d1f271831ca1de62a3befea6a0/include/stdio.h#L236-L237
> > > [2] https://github.com/openbsd/src/blob/6a403588e27467d1f271831ca1de62a3befea6a0/sys/sys/cdefs.h#L299-L302
> >
> > ... in the OpenBSD repository says they haven't changed for many
> > years, and I am wondering what triggered this all of a sudden.
> >
> > If we know how we used to have no issue, in addition to how we now
> > have issue with the current OpenBSD (which you outlined very well
> > above), and when the situation changed, please add to the proposed
> > log message.  That would help people on OpenBSD to decide when they
> > want to upgrade their copy of Git.
> 
> The thing that changed was the release of clang 19, which enabled the
> mentioned Werror by default. This is showing up now because I am
> experimenting with building software for OpenBSD through nixpkgs,
> which prefers the most recent version of everything. I am not sure
> what of this is appropriate to add to the commit message.

I'd guess a missing piece of the puzzle is your config.mak settings. We
do not use getdelim() unless HAVE_GETDELIM is set, and our default
platform settings in config.mak.uname do so only for Linux and macOS.

There is a check for it in configure.ac, so if you are using autoconf,
that may enable it in config.mak.autogen. But most Git developers (who
ordinarily would build with -Werror) do not use autoconf. So that may
explain why nobody complained about it until now.

I do wonder if the autoconf test should be more picky about making sure
it builds without warnings, but I'd guess those are usually lenient by
default to avoid false negatives.

All that said, fixing the source to build without warnings like you are
doing is obviously the right thing to do.

Patches to config.mak.uname to turn it on by default for OpenBSD would
also be welcome. We tend to be conservative in flipping those switches,
and wait until somebody who actively uses the platform and cares enough
proposes a patch.

-Peff
