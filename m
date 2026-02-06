Received: from cloud.peff.net (cloud.peff.net [104.130.231.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 10D5C355029
	for <git@vger.kernel.org>; Fri,  6 Feb 2026 09:04:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=104.130.231.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770368646; cv=none; b=hEVoS6xUCjcLiGvpn0Dpebtf30yWME6oJfXauu7E+nLWW1DgPpB+sL0ceFzQL5DJU98JYFAJjh1MISi5hyJwxGjKaLI2m+HLdeoqgBS4R3dD9V1Qz8OphKjjktjPHkl7nVikCPqb1C/pka5OfMPDBhtg9JYzMr8d85J4ewakafI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770368646; c=relaxed/simple;
	bh=aLVhwG0VMzr+zTq4kDdYQ2OQ86VeTkX4hlL2+5ecSRk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=kfQu5MhdE7hkZ4dLc5oisdFiLVFej1AFtn5PMmJDCF48pQD+ea+WJxa022hd7Qr52wHZncYQzR/IFwA319Ouzc/7mub+OZpMZ0/qytcQaOX16CejJ6Ka/KQBb5VJb5SJdH2oL+RhAStHCZ1qYT74uoe1IJWfLJpOJcB9lQLtjcs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=peff.net; spf=pass smtp.mailfrom=peff.net; dkim=pass (2048-bit key) header.d=peff.net header.i=@peff.net header.b=CoYakeAL; arc=none smtp.client-ip=104.130.231.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=peff.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=peff.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=peff.net header.i=@peff.net header.b="CoYakeAL"
Received: (qmail 297785 invoked by uid 109); 6 Feb 2026 09:03:59 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=peff.net; h=date:from:to:cc:subject:message-id:references:mime-version:content-type:in-reply-to; s=20240930; bh=aLVhwG0VMzr+zTq4kDdYQ2OQ86VeTkX4hlL2+5ecSRk=; b=CoYakeALVWWcQIALtHltOEXm3mPIM4v0KFEINIWOk7m6cFZ9r2XZBaIKk3YNkY+VvnOXYe2P1E9uLNjx8zSplkINNCfnLu+N7enpj/MviSFqwez4wrk/cI4yTVOALTOo2x9VBxls5BSGv0Ha0ZAi/lAGphDy128oxBEXEFyvb8eD33otOXaB9/hl9d27PDZtJv9xs/4F3Bvw19kwmKcEtN6SxVwd4WxQhyrowz1BJiHAYh9Yie9aMHKICehs7RsTGQlzptvUjiJV+wWy6M/jkuqz4NHfVBHHlrD8ezDLRWlI6jlzLZeFZLNYpA0YEX5WFNDewSlb4pg98MixHia1Fg==
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Fri, 06 Feb 2026 09:03:59 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 598296 invoked by uid 111); 6 Feb 2026 09:04:03 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Fri, 06 Feb 2026 04:04:03 -0500
Authentication-Results: peff.net; auth=none
Date: Fri, 6 Feb 2026 04:03:58 -0500
From: Jeff King <peff@peff.net>
To: Matthias Beyer <mail@beyermatthias.de>
Cc: Jacob Keller <jacob.keller@gmail.com>, git@vger.kernel.org,
	pyokagan@gmail.com
Subject: Re: git-am applies commit message diffs
Message-ID: <20260206090358.GA2761602@coredump.intra.peff.net>
References: <bcqvh7ahjjgzpgxwnr4kh3hfkksfruf54refyry3ha7qk7dldf@fij5calmscvm>
 <CA+P7+xqcBcV8uySGgDfvt2ruAnFmfgaUy6aRbUC2zCzmCgPubw@mail.gmail.com>
 <hn6q2mdjdqezzvtxfxffmatctnlf4ttvwedfk7wnw7xw75gy4g@hetctv53f7bh>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <hn6q2mdjdqezzvtxfxffmatctnlf4ttvwedfk7wnw7xw75gy4g@hetctv53f7bh>

On Fri, Feb 06, 2026 at 09:18:50AM +0100, Matthias Beyer wrote:

> That said, I am no expert in either C or the git codebase at all, but
> from what I saw from reading the git-am codebase, it looks like it tries
> to find the patch by looking for three dashes on a line with a linebreak
> behind ("---\n").

Yes, that is how the split is made.

> From what I read, it looks for that from the first line.
> What I would think of here is looking for that "patchbreak" from the
> _end_ of the email rather than from the top, that would have prevented
> this issue, right?

The patch itself may legitimately contain "---" on a line by itself (it
would indicate that the line "--" was removed from a file). That would
confuse your parser, including in a way that we end up only applying
part of the diff (everything before that fake "---" becomes commit
message, and everything after becomes cover-letter material up to the
next "diff" line).

I suspect it also creates corner cases with cover-letter material
(between the "---" and the diff itself) that itself contains any "---"
marker.

I don't think there is a way to unambiguously parse the single-stream
output that format-patch produces. This is a reasonably well-known
gotcha (at least around here). E.g., some earlier discussions:

  2024: https://lore.kernel.org/git/ca13705ae4817ffba16f97530637411b59c9eb19.camel@scientia.org/
  2022: https://lore.kernel.org/git/d0b577825124ac684ab304d3a1395f3d2d0708e8.1662333027.git.matheus.bernardino@usp.br/
  2015: https://lore.kernel.org/git/CAFOYHZC6Qd9wkoWPcTJDxAs9u=FGpHQTkjE-guhwkya0DRVA6g@mail.gmail.com/

There are probably more, but it's actually a tricky thing to search for
in the archive, so I stopped digging. ;)

I think the general attitude has been that such things are a nuisance
when you trigger them accidentally, but probably an unlikely security
issue if we assume a human is reading the patch (and if they're not, all
bets are off anyway).

Ironically, you can ask format-patch to split the message and patch
using the "--attach" option, which should be unambiguous (they are in
two mime parts). But git-mailinfo (which powers git-am under the hood)
decodes the two parts into a single stream, and still takes a "diff"
line in the commit message part as the start of the diff.

Arguably that could be improved, but I suspect might break other cases
(I think it is trying to be forgiving to folks who have shoved the whole
patch into an attachment). So you'd have to pull the attachments apart
yourself and feed them individually to "git apply" and "git commit -F".

-Peff
