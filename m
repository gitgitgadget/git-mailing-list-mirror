Received: from cloud.peff.net (cloud.peff.net [104.130.231.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EBE9F5475E
	for <git@vger.kernel.org>; Fri, 18 Apr 2025 09:16:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=104.130.231.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744967785; cv=none; b=Lf0nKY8W7kWFxtpFbjJQKs/0WTPvUQf3jpxpyLVT+N6YCcrtXQw5hcIyG4VJo/e1HNnsZTIfausoEfxmq8hiIfbB0lNIk+NLG9a0N5FT2dA/aYv0BRvUMWBnY6T9KZ1ZzGG1X666TAuyAlTfsxxnyFePMW8fOw5ERx7JIKIEefg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744967785; c=relaxed/simple;
	bh=1rp8Ag4Ri70mLgzrcCGFevAFz90aJofTt8ONP28gh0s=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=TekPI+d7ctkx4jm3MPmho8J47O9LoNjqHetVXVc+QaXDZnYmazucyGGlCVlKcvQ/Y6PEvOGqcl1DwROMRE3nUwYvAvlOyyJkxCw9kGStcjFgN5ESWmX/WwTEiRnqV8nFOeTMCHkI2NUaVUB9LvJhlMHxcgpCUeRFdV1yl7WYEM8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=peff.net; spf=pass smtp.mailfrom=peff.net; dkim=pass (2048-bit key) header.d=peff.net header.i=@peff.net header.b=YwDHdx3L; arc=none smtp.client-ip=104.130.231.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=peff.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=peff.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=peff.net header.i=@peff.net header.b="YwDHdx3L"
Received: (qmail 16197 invoked by uid 109); 18 Apr 2025 09:16:15 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=peff.net; h=date:from:to:cc:subject:message-id:references:mime-version:content-type:in-reply-to; s=20240930; bh=1rp8Ag4Ri70mLgzrcCGFevAFz90aJofTt8ONP28gh0s=; b=YwDHdx3L8V60Urpzo0/jq4mqoeSWXn3CZfMRYxgWRJgLDc4OwDD5GvVpoMESQSSPcU0q0SRLejZrLCYTR2FXw9DLMcg7nDsGl0PTyuSdJj9siMjHiXoe4L2bhHiCpQAumyzh2WeM3Nkw8eyAI84SuRdeagvDPUNMLaKXFqsE/OJmenefyXW34C6mt24yt3F3N1zjC1h8QLyf6JsGtqu4LbhfPodvdrNZUkgdQkZ+bHd+UENcKe/khqtjeeGEkkFv5xxuhLwB8T97d4gdgVh5L5DByf2QMxEw6UJDZT4+PIXgfuDz7TPxN3l4qv61eFqDBUoZ63ArxcNJH7tZ6x9oow==
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Fri, 18 Apr 2025 09:16:14 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 30961 invoked by uid 111); 18 Apr 2025 09:16:17 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Fri, 18 Apr 2025 05:16:17 -0400
Authentication-Results: peff.net; auth=none
Date: Fri, 18 Apr 2025 05:16:12 -0400
From: Jeff King <peff@peff.net>
To: Keith Thompson <Keith.S.Thompson@gmail.com>
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
Subject: Re: Bug report: Minor glitch in "git help" error message
Message-ID: <20250418091612.GA10441@coredump.intra.peff.net>
References: <CAAHpriMkqapiJuUGimn-i8SqcZmvmc=Wpk6oUr844uAkCYgMxA@mail.gmail.com>
 <xmqq5xj2clcx.fsf@gitster.g>
 <CAAHpriNYikDFwiTpjZEupG4yWOkbzW5DnBcsUnBKkfxxxtWNkw@mail.gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CAAHpriNYikDFwiTpjZEupG4yWOkbzW5DnBcsUnBKkfxxxtWNkw@mail.gmail.com>

On Thu, Apr 17, 2025 at 08:52:10PM -0700, Keith Thompson wrote:

> Some proposed solutions, none of which I really like (except maybe
> the first):
> 
> * Assume that the unrecognized word is a subcommand name. There will
>   be errors (a message referring to "git-topic" that should have been
>   "gittopic"), but I speculate that *most* (mistyped) arguments are
>   command names.

I think the problem is that it's not unrecognized at all by Git. We
don't have a list of topic pages, so we just assume any non-command is a
topic, and hand if to "man". And it is "man" that realizes there is no
such page. So you cannot assume up-front, as it would hand the wrong
name to "man". But...

> * Produce an error message like:
>   "No such manual entry for git-foo or gitfoo"
>   Problem: The error message comes directly from the "man" command,
>   which can't be persuaded to produce the above message.
>   Probably more effort than it's worth, and a potential new source
>   of bugs.

We could detect a non-zero exit code from "man" and print more messages
afterwards. Something like:

  $ git help foo
  No manual entry for gitfoo
  error: no command "git-foo" detected, and viewing the concept manual for "gitfoo" failed

But I don't know how reliable that exit code is.

In Debian's "man" implementation, code 16 is documented as "page not
found". I'd expect most man implementations to at least return non-zero
for that case. I would worry a bit about implementations which return
non-zero even on success (e.g., if the roff formatter gets SIGPIPE when
the pager closes early, would man ever propagate that code? If so, we'd
get bogus error messages).

The other complication is that "man" is not the only viewer. We might be
showing HTML documentation with a browser, or even GNU info pages. And
you're less likely to get a good exit code there (e.g., I'd expect most
browser invocations to just remote-control an existing browser to open a
new window/tab).


I think the most accurate and foolproof thing is that "git help" could
tell what it is doing as it works: it sees that "foo" is not a git
command, so it decides to try it as the "gitfoo" topic page. It could
say so:

  $ git help foo
  warning: no command "git-foo" found, assuming "foo" is a topic
  No manual entry for gitfoo

Of course that is bad when "gitfoo" _does_ exist, because the first line
is mostly noise then. It does generally get covered up by man's pager,
but you may still see it after the pager exits (or immediately if you're
just invoking a remote browser anyway).

So probably a bad idea.


The other thing it's tempting to do is teach "git help" to check the
list of recognized topics, like it checks the list of recognized
commands. I think that would work _mostly_ work, if we baked in the list
at compile time based on what's in Documentation/. But it wouldn't
automatically pick up third-party topic manual pages. We pick up
third-party commands automatically by looking in the $PATH for them. But
I don't think we can do the same for documentation (we'd have to search
$MANPATH ourselves, which is bad enough, but of course it might be HTML
or info pages; the user might not even have the manpages installed).

-Peff
