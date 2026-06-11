Received: from cloud.peff.net (cloud.peff.net [217.216.95.84])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A3DAB2E7631
	for <git@vger.kernel.org>; Thu, 11 Jun 2026 08:31:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.216.95.84
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781166702; cv=none; b=Qne2gM6FDBKvE9AVOz28ck+zBxJmSJyChkflxVBoVR9sveRJXcVGuZT1xDSFwJL+2miEBHk0QjkYercjRqI9wWKAzOClYJ/AhZy7c4IeVNWRAULAgXzkIZMSwf9zCXiVebFWdurTN27Q3ahJ89umiDWK02T/VtZhJFfX9jLtvm0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781166702; c=relaxed/simple;
	bh=fRNr+zZno4g8fWRz9ABH0qL9rjjMh9eFIKzUL9gAtgI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=L4NdTlsuJSw+9vWQBScNIiQzgIvkkdpeRHn+51a5Dq3+/LvQbsdfsySZ55CABBRWXbESzMqQcTdA+WLMGV+DWOXRn3cKe92R0Dt8XacmKVOCKg3xjFP/eA1PuQhzwrp4fOAEqdH3MG2DIPez5gbpI8mYI03b9ag0o9+5ED6Ij8I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=peff.net; spf=pass smtp.mailfrom=peff.net; dkim=pass (2048-bit key) header.d=peff.net header.i=@peff.net header.b=IWKS0yRa; arc=none smtp.client-ip=217.216.95.84
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=peff.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=peff.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=peff.net header.i=@peff.net header.b="IWKS0yRa"
Received: (qmail 106942 invoked by uid 106); 11 Jun 2026 08:31:39 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=peff.net; h=date:from:to:cc:subject:message-id:references:mime-version:content-type:in-reply-to; s=20240930; bh=fRNr+zZno4g8fWRz9ABH0qL9rjjMh9eFIKzUL9gAtgI=; b=IWKS0yRa2yRRwVzP+QgHsOzE7plhaqd60t+ad/Q4Q53Ucg0zUhA8/8G9+cXdG0TsldDhVdO/2BMdksFH03bvrnoDaJ6XfkdxJJ+z1GbB+2bJhw79jAzDw2yHRbxGBJ1G0C+/Sqs9r72DF2n5VJrxBjyNT7kQPWXlsX4ZaiN200dg98CD6hS+w7h4+I4KEa8SFQqqmCjoHAjvE54I5E/pdsTCOuL4hg6GJWKyC69tFSEIp/WZeahNy6qif/gbqToZlHK6a3Q4NnGjfgHVQaj+neRD9y1yNE1YyMsFJrnJ2Ohvv14mh6G2mGr9OOxGrWxL1MDtb6EWtsncaUFFrLnjCw==
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Thu, 11 Jun 2026 08:31:39 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 315098 invoked by uid 111); 11 Jun 2026 08:31:44 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Thu, 11 Jun 2026 04:31:44 -0400
Authentication-Results: peff.net; auth=none
Date: Thu, 11 Jun 2026 04:31:39 -0400
From: Jeff King <peff@peff.net>
To: Tuomas Ahola <taahol@utu.fi>
Cc: git@vger.kernel.org,
	Kristoffer Haugsbakk <kristofferhaugsbakk@fastmail.com>,
	Junio C Hamano <gitster@pobox.com>,
	=?utf-8?Q?Jean-No=C3=ABl?= Avila <jn.avila@free.fr>
Subject: Re: [PATCH v2 3/3] doc: git-config: escape erroneous highlight markup
Message-ID: <20260611083139.GA2237523@coredump.intra.peff.net>
References: <20260610185148.23920-1-taahol@utu.fi>
 <20260610225513.6269-1-taahol@utu.fi>
 <20260610225513.6269-4-taahol@utu.fi>
 <20260611061156.GC2187173@coredump.intra.peff.net>
 <20260611080242.lqXwi%taahol@utu.fi>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20260611080242.lqXwi%taahol@utu.fi>

On Thu, Jun 11, 2026 at 11:02:42AM +0300, Tuomas Ahola wrote:

> > >  If _<message>_ begins with one or more whitespaces followed
> > > -by "#", it is used as-is.  If it begins with "#", a space is
> > > +by "\#", it is used as-is.  If it begins with "\#", a space is
> > >  prepended before it is used.  Otherwise, a string " # " (a
> > >  space followed by a hash followed by a space) is prepended
> > 
> > I saw the comment on round 1 about this second "#" on the line. But
> > while we are here, should we be doing the one in the context, too?
> > 
> > -Peff
> 
> It seems adding that second backslash was already too much, as doc-diff (which
> I neglected to run before submitting V2) shows:
> 
> ```
> $ ./doc-diff V1 V2
>  
>             If <message> begins with one or more whitespaces followed by "#",
> -           it is used as-is. If it begins with "#", a space is prepended
> +           it is used as-is. If it begins with "\#", a space is prepended
>             before it is used. Otherwise, a string " # " (a space followed by a
>             hash followed by a space) is prepended to it. The resulting string
>             is placed immediately after the value defined for the variable. The
> ```

Heh, it would not be the first time I am baffled by asciidoc's parsing. :)

Adding a backslash to the third instance "fixes" the second one to me,
but I wouldn't want to rely on that (plus it breaks the third instance).

Using backticks does work, though it always opens a typographical
question. When reading the source, you see `#`, so you get a punctuation
delimiter but no typographical one. In the rendered output, you'll see
it in a typewriter font (assuming we fix the config issue), but we'd
lose the visible punctuation. I could live with that.

But for " # ", it gets weirder. We need punctuation to call out the
spaces, but what should happen to the quotes? They are not really part
of the literal string, so should they go inside or outside the
backticks? I think it may be a moot point as "` # `" is not parsed as
you might hope by asciidoc. Doing `" # "` does work, and is probably OK
enough here.

-Peff
