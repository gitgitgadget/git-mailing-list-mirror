Received: from cloud.peff.net (cloud.peff.net [104.130.231.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 12E74275B18
	for <git@vger.kernel.org>; Thu, 19 Feb 2026 11:43:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=104.130.231.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771501390; cv=none; b=bps/VXiLvYnfk/bYKz0rjwkftDkNguKuN+kQXeH1D1tJl1OPZ/xnTwUVsgb+eBV0iDtCwdYcqBcuE5/TcvEnjT2dRQuyWmdrOwmLWoFggUDkCCtCkhmfoIpmsmq6ZhzR0QG3wEMJeZZVOkcex6Lbscr9vdxNm5bQyHnKEEeWfl4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771501390; c=relaxed/simple;
	bh=B1tRL63Bp3E7Mo08j5vIIgfZ006jCZiKyOMS4+h7UNs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=hvVM+9kZxNsCVoPfEYpkJhThp2eqZr391oh3E/oH314QjZXEv4YB7qrTO2958UfFL24dewZGTYJ+l/Y5cgrq68LddslMlahiFzzyUyB5Q9+EE4meQlBydZuscKvrzrTm4+TEWAx+QnZ8E+VxFqTkjuU06Xs5Ihsm5s3/K70Zxhc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=peff.net; spf=pass smtp.mailfrom=peff.net; dkim=pass (2048-bit key) header.d=peff.net header.i=@peff.net header.b=bghFbnmV; arc=none smtp.client-ip=104.130.231.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=peff.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=peff.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=peff.net header.i=@peff.net header.b="bghFbnmV"
Received: (qmail 2384 invoked by uid 109); 19 Feb 2026 11:43:08 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=peff.net; h=date:from:to:cc:subject:message-id:references:mime-version:content-type:in-reply-to; s=20240930; bh=B1tRL63Bp3E7Mo08j5vIIgfZ006jCZiKyOMS4+h7UNs=; b=bghFbnmVf8xoqPeUmpqg0mJ66V3ucB0dl2W8vT0jKEoQKP2HAKFr06FRqR75utteejHewSjI5cz5sDo6hb7xOwgVmKEluJpwNnvpbLBHKcU4pP3Gnagpkc0KF12jbtG8//3sWZw/4igypVthn1wcdcfjggJrr/z6olh5ZOfsyuMCFWtPscZlHyozXzg+rezRAwgccuGDKBVEe2dDUDvC6m93tTx8jB6SHjYk1oZ25g8GFXUwAkXXL6h4I55xyuh0Y4kATXDQ7aaIIqBo9jSj+n+1nTUPCqZI/Q3/EapfxPXiRUPOzOShv765mU56FndGXHt3BYyHz5fkPeE2+CYlig==
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Thu, 19 Feb 2026 11:43:08 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 4977 invoked by uid 111); 19 Feb 2026 11:43:07 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Thu, 19 Feb 2026 06:43:07 -0500
Authentication-Results: peff.net; auth=none
Date: Thu, 19 Feb 2026 06:43:07 -0500
From: Jeff King <peff@peff.net>
To: Junio C Hamano <gitster@pobox.com>
Cc: Patrick Steinhardt <ps@pks.im>, Mirko Faina <mroik@delayed.space>,
	git@vger.kernel.org
Subject: Re: [PATCH v2] format-patch: fix From header in cover letter
Message-ID: <20260219114307.GC3529@coredump.intra.peff.net>
References: <aZAMr6XOwKkTa55q@exploit>
 <20260216152730.37478-1-mroik@delayed.space>
 <aZQJEDyUyMv4_c1l@pks.im>
 <20260217063400.GA101988@coredump.intra.peff.net>
 <xmqqecmje6o6.fsf@gitster.g>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <xmqqecmje6o6.fsf@gitster.g>

On Tue, Feb 17, 2026 at 07:22:33AM -0800, Junio C Hamano wrote:

> > I never
> > use it (and I probably forgot it even existed, given that most people
> > would use send-email's cover letter generation, and I do my own thing
> > with mutt).
> 
> I use it myself and I really hate the way it lists the patches.  We
> should have done "log --oneline --reverse" instead of "shortlog", as
> it is hard to understand the reference the cover letter message
> makes to individual patches like "the first two patches do X", etc.

Agreed. I have long hated the shortlog version. According to the commit
history of my personal scripts, I've been sending with:

   [1/3]: subject of the first patch
   [2/3]: the second patch
   [3/3]: and so on

since at least 2009, and nobody has complained. ;)

Sadly I don't think there is an easy way to do so with "log --format",
as it can't just be a single output placeholder (you have to do the
whole traversal to get the "/3" part, so the caller needs to know this
and queue up the output).

I do it locally by piping the format-patch output through something
like:

  sed -ne 's/^Subject: //p' |
  sed -e 's/\[PATCH /[/' \
      -e 's/]/]:/' \
      -e 's/^/  /'

Of course that does not handle rfc822 header continuations, which we
started to do at some point for long subjects. So now the first part is
some gnarly perl. :-/

Probably some combination of "git log --format=%s", "nl", "wc -l" would
be less horrid. I stuck with format-patch because of its somewhat
magical command-line parsing of revisions. E.g., saying "git
format-patch @{upstream}" will give you the patches on the topic branch,
rather than all history down to the roots.

But anyway, if this were happening internally in format-patch's
cover-letter code, it should be quite easy to do (we have the complete
list of patches and their subjects there already).

-Peff
