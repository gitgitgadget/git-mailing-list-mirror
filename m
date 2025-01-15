Received: from cloud.peff.net (cloud.peff.net [104.130.231.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F3A871DAC8D
	for <git@vger.kernel.org>; Wed, 15 Jan 2025 21:29:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=104.130.231.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736976597; cv=none; b=K494ERN+Wl6cpzZ3TTY0/gW9nLYz1PAydJvMUYu9PCufYUxAeo1HHZfswbB/WI0dgP/+2UBaO7gbklgEqCbYg5i8KLuzXwo4l/DyE6whljgyWMBumbhdEAbl/LwczZ9vAF1ZanybbcZodpGUAZ/zZHIOIRsXpyi0CNBUDAvgnXs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736976597; c=relaxed/simple;
	bh=Xx4y09roBY7DTS9fp7ljzcdAvSSkIUjP7J8iA0bDKc8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=GEHgy0Kgii+LbRngeSx8MA5uYbh8HLASMVFdaofOzTW6eedCfOkHVv/FdjYFUDeeneI7cNF89KTC7WscvZ3pHBtlH/LINC/Ux+SYbG8PUVq4XjDOD7ZLzp+tr9X/ZgLT+sKqv1qpQqz7IR7phzqK1Y1+Yo9PQJw5W4A2OO2qPZ8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=peff.net; spf=pass smtp.mailfrom=peff.net; dkim=pass (2048-bit key) header.d=peff.net header.i=@peff.net header.b=OKxkIsu5; arc=none smtp.client-ip=104.130.231.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=peff.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=peff.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=peff.net header.i=@peff.net header.b="OKxkIsu5"
Received: (qmail 7432 invoked by uid 109); 15 Jan 2025 21:29:54 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=peff.net; h=date:from:to:cc:subject:message-id:references:mime-version:content-type:in-reply-to; s=20240930; bh=Xx4y09roBY7DTS9fp7ljzcdAvSSkIUjP7J8iA0bDKc8=; b=OKxkIsu5i//hLRNeE+5TEDnppKLDdIt6ULmbXEX02RrdyUw5aataYuEC5dBDaBOZjhpt+/1bK/HLhFCYfs2h/HVzoitRkqGEX2iUjJtwP+ahFfa5LoIRIpf7PGlZzSe03orSIzeIDETzEFiHu3gZ6D2nvIWKsNE+RNvvR8YATs4eZ9rv1sFikWBD1jZ+nWxJ+u8TBV2HI7rdExcVax0VeTiJG1rGBQYQesiA6rlEzdbuFITouvDKCpDMq9DNTtqrZ5tndPTQ8P1iVzfr0fmrvIyMCNDaajz+Rj5SuxYpaULb5j6XZHnQD9Pi/s4qIPVS5BxJS/c+QmtXEdAoyVKevg==
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Wed, 15 Jan 2025 21:29:53 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 14949 invoked by uid 111); 15 Jan 2025 21:29:55 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Wed, 15 Jan 2025 16:29:55 -0500
Authentication-Results: peff.net; auth=none
Date: Wed, 15 Jan 2025 16:29:52 -0500
From: Jeff King <peff@peff.net>
To: Junio C Hamano <gitster@pobox.com>
Cc: Kristoffer Haugsbakk <kristofferhaugsbakk@fastmail.com>,
	=?utf-8?B?TWF0xJtq?= Cepl <mcepl@cepl.eu>,
	Jonas Konrad <jonas.konrad@uni-muenster.de>, git@vger.kernel.org
Subject: Re: Git branch outputs usage message on stderr
Message-ID: <20250115212952.GA96537@coredump.intra.peff.net>
References: <04cfaa3b-847f-4850-9dd6-c1cf9f72807f@uni-muenster.de>
 <D72M6S9O1E9F.WVEBV7ZJ1JTC@cepl.eu>
 <xmqqed1414gt.fsf@gitster.g>
 <c92e7b16-b70d-46f3-9858-2be805c5285f@app.fastmail.com>
 <20250115171423.GB57018@coredump.intra.peff.net>
 <xmqqmsfsx8oo.fsf@gitster.g>
 <20250115182419.GA86610@coredump.intra.peff.net>
 <xmqqa5brydz1.fsf@gitster.g>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <xmqqa5brydz1.fsf@gitster.g>

On Wed, Jan 15, 2025 at 01:16:50PM -0800, Junio C Hamano wrote:

> Jeff King <peff@peff.net> writes:
> 
> > Yeah, I agree it is funny to have a "maybe noop, maybe exit" function.
> > Perhaps a different name would help? I'd expect show_usage_help() to
> > always do what the name says. Maybe check_help_option() or something?
> 
> maybe_show_usage_help()?

Heh, I almost suggested that one, too, but worried it was too clunky.
But maybe since we both thought of it...

> > I think parse-options will exit(129) in this case, and that's what t0012
> > insists upon.
> 
> Yeah, but the test can be adjusted to updated reality if needed.  
> 
> In this case, the command is doing what the end-user asked it to do,
> and if we were writing the system from scratch, 0 would certainly be
> the right exit status in this case.  If hit usage_with_options()
> because the command line option supplied by the user was nonsense,
> we should exit with non-zero, but I am not sure if exit(129) is a
> good idea here.

I certainly see an argument for exit(0), but whatever we do should be
consistent with how parse-options handles it (since whether we use this
or leave it to parse-options is purely an implementation detail that the
user should not need to be aware of).

And it uses code 129, even for "-h". I don't see any explicit rationale
for that in the history; I think it goes back to the beginning of
parse-options. It happens via the PARSE_OPT_HELP flag, but curiously we
also trigger that for ambiguous options (which should exit with error).
That might be a bug-in-waiting if we start handling PARSE_OPT_HELP
differently.

-Peff
