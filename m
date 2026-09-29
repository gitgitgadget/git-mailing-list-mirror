Received: from cloud.peff.net (cloud.peff.net [217.216.95.84])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E26124E66AD
	for <git@vger.kernel.org>; Tue, 29 Sep 2026 18:28:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.216.95.84
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790706534; cv=none; b=fdo7XAu9B/HHDcjBnBP1riq4Rp1D15SAD+EgaG0HM803i+3k30EhrmUr6pJ3Qk1JuBviGbFv17Vp+0rgD+eIJFDJOC6UXUGiqeOtak6vD3uz3CX6d/JD9tEZkn0SNO+/waRu7dVw9T2skE4rpex+5UHpGn/LPyWQn4iP8aOoggA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790706534; c=relaxed/simple;
	bh=KhNGkS5JZc5VXkN8WncMhdV+4Bd3+l0XA3W95NOlZUM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=V9K09T0XFWCO33T5+6WEWkh+RqRZ1InvMLYUWZmipK1wh7Zao81zel3/JrLWunguM13zzb5doi5M7Qf/rKcAYi9gm33v0ejsbPCDRAzrwmiHLXZ+f26sCkoqBjgruAND4layu0cAbXPzgtE9Lb1uwkk+IEk6aVmeKZvIenebV+w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=peff.net; spf=pass smtp.mailfrom=peff.net; dkim=pass (2048-bit key) header.d=peff.net header.i=@peff.net header.b=c8e1UYih; arc=none smtp.client-ip=217.216.95.84
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=peff.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=peff.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=peff.net header.i=@peff.net header.b="c8e1UYih"
Received: (qmail 837 invoked by uid 106); 29 Sep 2026 18:28:50 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=peff.net; h=date:from:to:cc:subject:message-id:references:mime-version:content-type:in-reply-to; s=20240930; bh=KhNGkS5JZc5VXkN8WncMhdV+4Bd3+l0XA3W95NOlZUM=; b=c8e1UYihT4IbNajzGL9wQhwp9ukANr+w0mIVjpHC2+Vn878tV8WYAVfAV1uooUvCSI4qhEW71N3uL+44anEKcMQXGa9oiDPjabni01DVk0Iq62b7b6XAKJ82ayK1V8DSp85cgpwqyWigQt6/o0JrmnuTZBTxpXObVw42Am7K+ck+OK+2IUYQuElNHgOtV/GbkbNTqCPbwKWZGDTEuRY5TsPIN9VQ1vimPsU/UxOmaHBTRcrmJfaS3rv14X3BnnyDuh/8x2YfbsOuFeF25JW+u4L6TM6jjgw1VrCca/Ge+L/q7tXifW6wim+8AVNULz3VraEbBkdQaf3wn9B4lpXj/Q==
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Tue, 29 Sep 2026 18:28:50 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 2223 invoked by uid 111); 29 Sep 2026 18:28:50 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Tue, 29 Sep 2026 14:28:50 -0400
Authentication-Results: peff.net; auth=none
Date: Tue, 29 Sep 2026 14:28:50 -0400
From: Jeff King <peff@peff.net>
To: Ignacio Encinas <ignacio@iencinas.com>
Cc: Isabella Caselli <bellacaselli20@gmail.com>, git@vger.kernel.org
Subject: Re: hostname: includeIf =?utf-8?Q?conditio?= =?utf-8?B?biDigJQ=?=
 anyone already working on this?
Message-ID: <20260929182850.GB1710046@coredump.intra.peff.net>
References: <CAK4AdTRdNEU8cLFQ_7A=CUUL6u6dc327rn_H-SeBBD_dD-K7PA@mail.gmail.com>
 <20260929014415.GB1089022@coredump.intra.peff.net>
 <DLRSIZ3JV2DF.10GG1YB2D8DHW@iencinas.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <DLRSIZ3JV2DF.10GG1YB2D8DHW@iencinas.com>

On Tue, Sep 29, 2026 at 01:14:34PM +0100, Ignacio Encinas wrote:

> > Yes, that is the tricky part. :) There were some patches in 2024:
> >
> >   https://lore.kernel.org/git/20240307205006.467443-1-ignacio@iencinas.com/
> >
> > where the issue came up. Based on my recollection and a quick skim of
> > the thread, I think the consensus was that it's OK to document that it
> > is system-dependent whether we'll match against a short of fully
> > qualified hostname. But exposing our view of the hostname via git-var
> > (e.g., "git var GIT_HOSTNAME") might be a helpful debugging aid.
> >
> > It looks like after review on v3 of the series we never saw more. I'd
> > guess the author (cc'd) just never got around to pushing it forward.
> 
> That's what happened. Similar to Isabella, I was looking for a small
> contribution but it ended up being more complicated than expected. I got
> a bit overwhelmed and decided to drop it.
> 
> I kept wondering if I should have communicated that, so apologies if
> that was the case.

Nah, it's not a big deal. This is open source, so everybody is here
voluntarily, and it's normal for people to come in and out as time and
interest permits. Plus the very reason that people end up dropping a
series (getting overwhelmed) often makes it hard to decide whether and
when to write the "I'm dropping this" email. :)

> I hope the discussion from 2024 is at least helpful now if this ends up
> being implemented by Isabella.

Yeah, I think there's a lot of good discussion there, and the patches
themselves can probably give a boost to another attempt. Even if we did
not finish it back then, thank you for the work so far.

-Peff
