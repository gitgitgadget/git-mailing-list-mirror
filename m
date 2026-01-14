Received: from cloud.peff.net (cloud.peff.net [104.130.231.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 53F4F2D6E70
	for <git@vger.kernel.org>; Wed, 14 Jan 2026 21:02:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=104.130.231.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768424521; cv=none; b=Wz6U7m+E/B+ZSQmb2HoN9WhaEPYzBesQPafZqrhH1ct253kgiEMNxbqF+ApScaOpmVk9cBkFB+XIbJ3sDVZ9SisCDoaMpHBSQATViLL7TR3hVHGUn+I20ln2n6ZTWg+Hhk5OyHBuRP4Pttsf/vQZDDVPv3wSSxYKvjMsdlryShU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768424521; c=relaxed/simple;
	bh=9eNvw0EsDAzApl0rzPRZGLbkU4b7QwPWqrCdy9DgnkM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=nsgLZSmifJ1oXdBFvMCep9UHf0YKTeaqr8JaCopqbxdUKDMxwe7KKgRJqJZzxyPp/XThbh40qWU85Fe6EhbKSJx5s81qcSJgY/BLLxC/gdMUCdE+r2hzTVAqV4Yhw0fOfy8t9MucV6t1KNsndXTn387RvU+mJsahdI9XFVZ0yHk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=peff.net; spf=pass smtp.mailfrom=peff.net; dkim=pass (2048-bit key) header.d=peff.net header.i=@peff.net header.b=ENbxDKXg; arc=none smtp.client-ip=104.130.231.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=peff.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=peff.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=peff.net header.i=@peff.net header.b="ENbxDKXg"
Received: (qmail 41639 invoked by uid 109); 14 Jan 2026 21:01:59 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=peff.net; h=date:from:to:cc:subject:message-id:references:mime-version:content-type:content-transfer-encoding:in-reply-to; s=20240930; bh=9eNvw0EsDAzApl0rzPRZGLbkU4b7QwPWqrCdy9DgnkM=; b=ENbxDKXgD4G0/6PVFvabGzWj7drs8dYw4LZ6Ecu7j0tN58EH0/zMATZSMRWinGjUHj5P2SLPsJMI4iEgUrr2SwcbVIhOREauW7Pf3Uef8o63mDfL/uCbgBE2rgtoY7F9zjvlzC3kNDdjUVpn3BBMd8iu1v0bKZKcpxXvvzP96M9WZMS2BKkLTkO+uydhSVgHh4Jp8uhdS+Z/NL94rsJULDUZy/L3QzEA/nT8Nr8RCc8TdZjZ6CsuwebTKSjuo/sW+MmzhGTLWgSv25zDjOvyeymjqFf/sztfDJVC2wnRboPTesOOgyqNijVKkn0ogckWt7sRuLOYTilB9Hxv+vRN9Q==
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Wed, 14 Jan 2026 21:01:59 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 69809 invoked by uid 111); 14 Jan 2026 21:02:00 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Wed, 14 Jan 2026 16:02:00 -0500
Authentication-Results: peff.net; auth=none
Date: Wed, 14 Jan 2026 16:01:58 -0500
From: Jeff King <peff@peff.net>
To: Harald Nordgren <haraldnordgren@gmail.com>
Cc: git@vger.kernel.org, gitgitgadget@gmail.com
Subject: Re: Triangular workflow
Message-ID: <20260114210158.GA1008851@coredump.intra.peff.net>
References: <20260114162427.GA885771@coredump.intra.peff.net>
 <20260114174845.61215-1-haraldnordgren@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20260114174845.61215-1-haraldnordgren@gmail.com>

On Wed, Jan 14, 2026 at 06:48:45PM +0100, Harald Nordgren wrote:

> > Sure, but:
> > 
> >   1. It is a lot shorter to type @{push}. ;)
> > 
> >   2. Using @{push} works everywhere, even on my non-triangular repos,
> >      because it takes into account the push configuration. So it's a
> >      much nicer muscle-memory to acquire.
> 
> Makes sense, I’m all out of arguments here 😅 Please don’t take this the
> wrong way, but it reminds me of this XKCD: https://xkcd.com/1172/

Perhaps if the person in that comic was the one who implemented @{push}
in the first place. ;)

That said, I really don't think my use case is exotic. I've set up "git
push" in the only way that makes sense for my triangular setup. I just
don't happen to use it that often, and I don't want to be reminded me
unnecessarily of the relationship between each branch and its push
destination.

> As long as this is turned on by default then I’m mostly happy. Maybe JCH
> and others can weigh in on if this needs to be this configurable or always
> on.

IMHO not making it configurable is a show-stopper, because without that
it leaves people who don't like the new behavior with no escape hatch.

As to the default for that config option, I don't have a strong opinion.
I'd lean towards "off", as I do not find the feature that compelling
myself, and I don't recall ever hearing of it as a pain point for other
Git users. But I also recognize that's based on vague vibes, and I think
users are generally not very savvy about setting up triangular workflows
in the first place.

-Peff
