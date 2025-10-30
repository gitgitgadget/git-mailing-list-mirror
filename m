Received: from cloud.peff.net (cloud.peff.net [104.130.231.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E8BC6243968
	for <git@vger.kernel.org>; Thu, 30 Oct 2025 15:08:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=104.130.231.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761836899; cv=none; b=sy8sStIGdXJRX51M2iFB+LnrXv180/c8XZ85mZpHKeBHOneZTtHfhe8ImHi1ePOVfzNMYMtl+teoT2dG8NFSgqH81zRK9impa3T1+Nb/mBwpgLyVrwXDflawssk1CI8P/PMpKunBRqP1u/6fbsyVdGu4KLJ4oyWpiQqgSwcz47g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761836899; c=relaxed/simple;
	bh=A9Z4BfQrSpCIgFhiYUWXEzLxSX7VOlpe/PL99Jl7sCg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=W6psrqxURfC/PYY2poqLJE013sK1qBIrnDSvMRj5ZvFCwbppDf8vFows1rKQirlQJaFni8dNx+WP2FxGr4jjIdccw4piaULRrmryYvo5S/+CLcoJnj/AERgf2hO57iBx+9C9omS/rRh3edU5rdskPm36gFDu7+mhb4YTl1o+7T8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=peff.net; spf=pass smtp.mailfrom=peff.net; dkim=pass (2048-bit key) header.d=peff.net header.i=@peff.net header.b=XfOtZpRF; arc=none smtp.client-ip=104.130.231.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=peff.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=peff.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=peff.net header.i=@peff.net header.b="XfOtZpRF"
Received: (qmail 387053 invoked by uid 109); 30 Oct 2025 15:08:15 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=peff.net; h=date:from:to:cc:subject:message-id:references:mime-version:content-type:content-transfer-encoding:in-reply-to; s=20240930; bh=A9Z4BfQrSpCIgFhiYUWXEzLxSX7VOlpe/PL99Jl7sCg=; b=XfOtZpRFK5MueWDHjze/ZXIv5SF3VX2BeAslow16ZnhICgooWc7XQbuxAADzkDackkiCDf5BnwdOQmGIsHhkLW6OfyLQS6oeVcxGPw6ENfVyVIeDjZNaZVW8IfMmpTQz0Xl0Jch8fTOm/2Ng/LlLahU19F1OxjphXtUueh6SCerykNiguGxvSLQpeBR24ziI81bvxlgWj6eQAymk6Hx5cTnztZ/XWCajH2bl4QySTV0ffkE0QYyXiPgnw33r/MxR7/1kNVylm88b7CG//HDnMUf6WsPe/ifmjqDwYFuSML4NQwU63XTcyAF7oFHNFZlYcBax/+1cRC03KkGbaLAWkw==
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Thu, 30 Oct 2025 15:08:15 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 603196 invoked by uid 111); 30 Oct 2025 15:08:14 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Thu, 30 Oct 2025 11:08:14 -0400
Authentication-Results: peff.net; auth=none
Date: Thu, 30 Oct 2025 11:08:14 -0400
From: Jeff King <peff@peff.net>
To: "D. Ben Knoble" <ben.knoble@gmail.com>
Cc: Junio C Hamano <gitster@pobox.com>,
	Sruteesh Kumar <sruteesh.oss@protonmail.com>,
	"git@vger.kernel.org" <git@vger.kernel.org>
Subject: Re: [PATCH] doc: document backslash in gitignore patterns
Message-ID: <20251030150814.GA1275070@coredump.intra.peff.net>
References: <20251014003404.GC1507@coredump.intra.peff.net>
 <xmqq7bwltlb8.fsf@gitster.g>
 <20251026152614.GB2095501@coredump.intra.peff.net>
 <xmqq7bwhmecb.fsf@gitster.g>
 <20251027142902.GB2758515@coredump.intra.peff.net>
 <xmqq4irkl5ms.fsf@gitster.g>
 <20251028231945.GA4128296@coredump.intra.peff.net>
 <20251029153237.GA1133542@coredump.intra.peff.net>
 <20251029155559.GA1134232@coredump.intra.peff.net>
 <CALnO6CButUc89H0a+FrrdY4pWh10=U8yeWfd7Oesb=1wpHMmSg@mail.gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CALnO6CButUc89H0a+FrrdY4pWh10=U8yeWfd7Oesb=1wpHMmSg@mail.gmail.com>

On Thu, Oct 30, 2025 at 09:40:36AM -0400, D. Ben Knoble wrote:

> > There's also the "pathspec" entry in gitglossary(7), which does mention
> > fnmatch(3). Though it is even more confusing because of the literal
> > matching that pathspecs do. I don't know if we'd want anything there
> > (and I kind of doubt people get as exotic about patterns there as they
> > would in gitignore).
>
> I certainly wondered about the pathspec case, since the commit message
> called out the difference in behavior. For example, at least in this
> one corner, we can't reliably use Git commands with pathspecs to build
> up example gitignore patterns to throw in .gitignore?

They're close enough that I suspect people do use them interchangeably,
but there are definitely important corner cases. Like the anchoring
stuff below.

> BTW, is the literal matching intended to be conveyed by
> 
>            •   any path matches itself
> 
> ? If so, I'm not quite sure how to interpret a pathspec like a/b given
> a repo with a/b and dir/a/b—do both match or only the former? I expect
> in combination with the 2 subsequent bullets that only the former
> matches. Conversely, with a pathspec "b" in that case, I think I could
> read the docs as suggesting both match, when IIRC none do. Hm!

I may not be the right person to ask, as I wasn't aware of the literal
match behavior here until I tried to write that wildmatch test, and then
walked it through the debugger. ;) Finding the documentation
justification came later.

But yeah, I think that a pathspec "a/b" will not match "dir/a/b",
because pathspecs are implicitly anchored to the start of the path. So
"foo" in .gitignore will match "some/dir/foo". You'd need to "/foo" to
anchor it to the top-level. But pathspecs always start at the top-level,
and you'd need "**/foo" to be the equivalent of gitignore's "foo".

But even that's not entirely true. We allow "*" to match even directory
separators in pathspecs (which is what makes "*.c" match anywhere), so
"*/foo" is enough.

> But this is a bit of a tangent, and the pathspec entry is already, uh,
> complicated [1]. Without a good place to leave extra notes for cases
> like this, I'm not sure what to do. Certainly unifying the behavior
> would be incompatible (if obscure).

It's definitely complicated, but I'm not sure which of those features
are important for command-line ergonomics, and which are just pointless
inconsistencies. I'd be scared to start changing things and finding out. :)

I certainly don't have any objection to improving the pathspec
documentation if it's unclear, though I think that can be done
separately on top of the patch in this thread (and I'm not planning to
tackle it myself).

-Peff
