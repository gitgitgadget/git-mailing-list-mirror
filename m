Received: from cloud.peff.net (cloud.peff.net [104.130.231.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E720827F728
	for <git@vger.kernel.org>; Sat, 20 Sep 2025 23:15:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=104.130.231.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758410113; cv=none; b=ikj9rHIvELX8UcNanlKMJAlLCj93p5AJZ3t8wuh47ccf5D2X7lXwGq70cmfAtehnqzOQeYAlM5Z8LT7nP4+OoMuuSfB5zEsBZuthOpNgFtHCso9moEikIqWTPv7ym1UwCIrbSeuOYkEmKWG+uqG2JNGP58CPU81yQ/tS45BrGIM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758410113; c=relaxed/simple;
	bh=51Zu6babpMVuCiNM3AQEv+tthsJwhdH7EeDgH8GHnfA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=fLwXH0DcYq1kAu5Rh0PCYa5Jr2SXwjgJY4UBAWuBdaWIgnrAC3CEBpxj1sSGLsYFmwsoe5IqAZWwmtjbLQGGwnc26TKXD+sfnVgbkRkjPE/wf25l6JpkJoLajG+AI3LuqWTVyFvJSkECLHZ0FfN+m9cTfvwGwBtvMuo8mGTEyRk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=peff.net; spf=pass smtp.mailfrom=peff.net; dkim=pass (2048-bit key) header.d=peff.net header.i=@peff.net header.b=e4TIlJ7G; arc=none smtp.client-ip=104.130.231.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=peff.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=peff.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=peff.net header.i=@peff.net header.b="e4TIlJ7G"
Received: (qmail 143193 invoked by uid 109); 20 Sep 2025 23:15:10 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=peff.net; h=date:from:to:cc:subject:message-id:references:mime-version:content-type:in-reply-to; s=20240930; bh=51Zu6babpMVuCiNM3AQEv+tthsJwhdH7EeDgH8GHnfA=; b=e4TIlJ7Gl3xso1Fmc31XF1p9vuq9FC/unAQz0jcqYCL3Ig0INxakAEZSQDLktVKvNwzX2d0r2Rgf2FEZc2xE585WgoDKS2tOyBL5SmXKcE6CciCmSsDZbgU9kYtny+QSQks02QbuqHJcX+QtHDlvUuBoth210Hovno+Wj2bk8g7Ws4Fxe+308m7IMRELV9pTIT6hp7mpaLXGiFYbFYLisKTvnq3UhkZAdtfer02rtl77rDT44At6elg1L3nbQ8oprMlDjONwjnBcZ3FfaIPtBBSP7JcPFD+9QSsuuzrGd+qsl4G6j+Rjvy6WoFca5Bu6H85F9xXEZbuog5h9OzHJgg==
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Sat, 20 Sep 2025 23:15:09 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 225830 invoked by uid 111); 20 Sep 2025 23:15:08 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Sat, 20 Sep 2025 19:15:08 -0400
Authentication-Results: peff.net; auth=none
Date: Sat, 20 Sep 2025 19:15:08 -0400
From: Jeff King <peff@peff.net>
To: Junio C Hamano <gitster@pobox.com>
Cc: Ben Knoble <ben.knoble@gmail.com>,
	Ezekiel Newren via GitGitGadget <gitgitgadget@gmail.com>,
	git@vger.kernel.org, Elijah Newren <newren@gmail.com>,
	Phillip Wood <phillip.wood123@gmail.com>,
	Ezekiel Newren <ezekielnewren@gmail.com>
Subject: Re: [PATCH v3 01/10] xdiff: delete static forward declarations in
 xprepare
Message-ID: <20250920231508.GA1018519@coredump.intra.peff.net>
References: <xmqqh5wxxcwq.fsf@gitster.g>
 <83F61517-06DB-402E-911A-E33EE07D54AE@gmail.com>
 <20250920184638.GA1010995@coredump.intra.peff.net>
 <xmqqy0q8wxc6.fsf@gitster.g>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <xmqqy0q8wxc6.fsf@gitster.g>

On Sat, Sep 20, 2025 at 03:52:41PM -0700, Junio C Hamano wrote:

> > PS I sometimes find:
> >
> >      git log --format='%(trailers:only,keyonly)' |
> >      sort | uniq -c | sort -rn
> >
> >    amusing to look through for this sort of thing.
> 
> The top entries are as expecte (this is with --since=5.years)
> 
>   24336 Signed-off-by
>   17501 
>     740 Helped-by
>     703 Reviewed-by
>     495 Acked-by
>     485 Reported-by
>     420 Mentored-by
>     186 Co-authored-by
>     164 Suggested-by
> 
> but I have to wonder what the empty one is.

I think %(trailers) always ends each trailer line with its own newline,
including the final one.  So then --format adds its own final newline,
and you get a bunch of blank lines between commits. It's easier to see
with --format='%h %s%n(trailers:only,keyonly)'.

I don't think you'd want to change %(trailers) to omit the final
newline, otherwise a format like:

  git log --format='%h %s%n%(trailers)---'

would break.

Possibly the formatter could be more clever about adding the final
newline only when the formatted text does not itself end with one. But I
suspect some people's custom formats do rely on the current behavior, so
you probably need some kind of new option or format placeholder.

-Peff
