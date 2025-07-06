Received: from cloud.peff.net (cloud.peff.net [104.130.231.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1286F610D
	for <git@vger.kernel.org>; Sun,  6 Jul 2025 03:30:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=104.130.231.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751772657; cv=none; b=XjhIfdiohSiR1sscFDyzNmyG/ZGw1A754P+oOE1iC5pfu0FHW2KHQSMR8sFjI6+lbjJsvFZ338di+QntDRMsirOnGu2HwzowAYV0haNiilqLBjB9+BjBsD7Y/o2ob5RoemfzVZgs4ozTAYgScq30sKT0R4xTqWIkBDqiCw4gvOE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751772657; c=relaxed/simple;
	bh=zHn6I4ngbXrhGFAeOl+6htwHjDn1P9b07VQ8hLPHnC8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=saF3LlCftjkQI+FRrrmentWBqMK3odZie1cYfWmmuTiB03TRC+VZsJMeRMP7uTIjj13luIOFUShE9IXcDZbzY0LTQJKzr5cc9wMwJYeAUGDLqdtXxUMsMFo1htqxaep5T5hOcR49WCeefBJzqOq8voooiH9mlzo2vN4/W+8a6QQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=peff.net; spf=pass smtp.mailfrom=peff.net; dkim=pass (2048-bit key) header.d=peff.net header.i=@peff.net header.b=SAUttXnA; arc=none smtp.client-ip=104.130.231.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=peff.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=peff.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=peff.net header.i=@peff.net header.b="SAUttXnA"
Received: (qmail 26496 invoked by uid 109); 6 Jul 2025 03:30:55 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=peff.net; h=date:from:to:cc:subject:message-id:references:mime-version:content-type:in-reply-to; s=20240930; bh=zHn6I4ngbXrhGFAeOl+6htwHjDn1P9b07VQ8hLPHnC8=; b=SAUttXnAYlrXbaQD+qYYTsHhS8H4EeeQY7u/ZOn0p1nwZs2gAxiJXR1f7sH6UpafempLwN0hU33rr3T2siuRUJs5gzh2jWMXtSg48URvzITW6lTeMdiw9qIKLLgk3s0rPbkIMaGUK8wTwq/5PgxVA1bVS6c3PC9MbFtwch0eU1V7b2ogdfhF5AzGAy9WBpOVExOaffpt+iN1WOdNJJ7icdLW7wooaN0OPaGV+f7TwFExtnhdbr7vQx7Svsei7ojQolWVspi0/s7OVP3AYCHRVctc/jyE5QqcgrVJL0PsAODQalNaqMhb1briThf40GcRbsH0x1flYa7oEJwnMqogCg==
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Sun, 06 Jul 2025 03:30:55 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 11518 invoked by uid 111); 6 Jul 2025 03:30:58 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Sat, 05 Jul 2025 23:30:58 -0400
Authentication-Results: peff.net; auth=none
Date: Sat, 5 Jul 2025 23:30:54 -0400
From: Jeff King <peff@peff.net>
To: Todd Zullinger <tmz@pobox.com>
Cc: Kristoffer Haugsbakk <kristofferhaugsbakk@fastmail.com>,
	Boris Kolpackov <boris@codesynthesis.com>,
	Han Young <hanyang.tony@bytedance.com>, git@vger.kernel.org,
	karen@codesynthesis.com
Subject: Re: Document ability to disable template directory in git-init
Message-ID: <20250706033054.GC3041790@coredump.intra.peff.net>
References: <boris.20250703161436@codesynthesis.com>
 <CAG1j3zEiD341X-_ZdR2puaEmZZ0ZBWSmyboyyGZaDXcDTcmAeA@mail.gmail.com>
 <boris.20250704123013@codesynthesis.com>
 <aGfcyfJ0hkZ7kF7_@teonanacatl.net>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <aGfcyfJ0hkZ7kF7_@teonanacatl.net>

On Fri, Jul 04, 2025 at 09:53:13AM -0400, Todd Zullinger wrote:

> > Thanks for digging this up. So in a sense this is an obscurely-
> > documented behavior that people could reasonably choose to rely
> > upon. I think only more reason to document this more prominently.
> 
> The commit which added it, d65d2b2fb4 (init: handle empty
> "template" parameter, 2008-07-28), notes the behavior:
> 
>     init: handle empty "template" parameter
>     
>     If a user passes "--template=", then our template parameter
>     is blank. Unfortunately, copy_templates() assumes it has at
>     least one character, and does all sorts of bad things like
>     reading from template[-1] and then proceeding to link all of
>     '/' into the .git directory.
>     
>     This patch just checks for that condition in copy_templates
>     and aborts. As a side effect, this means that --template=
>     now has the meaning "don't copy any templates."
> 
> It was released in 1.5.6.5, just in case anyone is looking
> at the release notes for 1.5.6.4 and wondering why this
> isn't mentioned. :)
> 
> It came up in <20080722200911.GA3097@sigill.intra.peff.net>
> on the list.
> 
> It's been this way for 17 years and seems unlikely to
> change.  Documenting it ought to be a good thing.

Oops, I suppose this is my fault. I agree that this is the intended
behavior, and probably ought to be documented.

However, as Kristoffer mentioned, "--no-template" should work in the
same way and is IMHO a bit more ergonomic. It didn't exist back when
that commit was made (we weren't using parse-options yet).

So perhaps the documentation for --template ought to point people in
that direction. But probably we should still mention the "empty string"
behavior in all of the other spots, since as you mentioned it works
equally for the config and environment variables (where is no "--no-"
equivalent).

-Peff
