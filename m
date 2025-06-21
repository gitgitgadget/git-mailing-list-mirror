Received: from cloud.peff.net (cloud.peff.net [104.130.231.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B0E2E10957
	for <git@vger.kernel.org>; Sat, 21 Jun 2025 05:07:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=104.130.231.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750482467; cv=none; b=AiFzsuRxWCS3NNNOG0THkpfsh94UYfi86pBkvCWjVwaJet712my7jUIGSnvKTd5+ydlSSri/7wGwARxmfHxBHdLjGGyYXXylu7nw/JQxGT1O1C1UTFUUujhx0DuQyHK93D2JmYnFcmmhwPUq4DsPMF8E49op/GPBLz/3ahGChsk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750482467; c=relaxed/simple;
	bh=U7OydsxbQ6sJJoO5dYQYAxe7Hq3Npg13tGXZYS8H4+0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=piq+s5EXcG6gbyIOORcGh7CzGD49B/g3leZLxKvPdBZU95JUt3/Q+HztHWLTRMzDP7tRjuyGb5U16Fs9qEKqAFWyDFTK4TbjELYxJEIQW+v5DqSrjM9ZEAqeyX5Yj3cMsFPQZHKGbTZ7/noOOaV/ILQuZ6OQ4djSouaf42jozOw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=peff.net; spf=pass smtp.mailfrom=peff.net; dkim=pass (2048-bit key) header.d=peff.net header.i=@peff.net header.b=Dp517OUo; arc=none smtp.client-ip=104.130.231.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=peff.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=peff.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=peff.net header.i=@peff.net header.b="Dp517OUo"
Received: (qmail 31686 invoked by uid 109); 21 Jun 2025 05:07:45 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=peff.net; h=date:from:to:cc:subject:message-id:references:mime-version:content-type:in-reply-to; s=20240930; bh=U7OydsxbQ6sJJoO5dYQYAxe7Hq3Npg13tGXZYS8H4+0=; b=Dp517OUoHLH04lNBUYaz/+MCatuiC5YPLZqJVmh0PBv6iKM/1o9JQOBZHFNS9xQQk+dnaL9TY26bnhU1hrDNx/eWuvr5ksJ+SKIPKv12i9TNq5jOjCqw/4wIeSIOqDc3Yc/BvbiuL6bcfw8f3cobwa97TvOHoVQJuYQ9MOcX4/bABqF7oSFJf9p9elZy6OyORnEtAq3mRIv3YVCQ8LvnNUaf8wJlG6diVNbttTLURmjRQzQicKIEUWgXpf6i3LmiHAP9w0tcz4kB/OmScjRUt5eO5Bc3IMw2kMNo82+698uz/Wx4rt9cp3RU51zJLxjyOVeMvcpATNZCuTvo8XJdKA==
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Sat, 21 Jun 2025 05:07:45 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 12316 invoked by uid 111); 21 Jun 2025 05:07:48 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Sat, 21 Jun 2025 01:07:48 -0400
Authentication-Results: peff.net; auth=none
Date: Sat, 21 Jun 2025 01:07:43 -0400
From: Jeff King <peff@peff.net>
To: Christian Couder <christian.couder@gmail.com>
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org,
	Karthik Nayak <karthik.188@gmail.com>,
	Patrick Steinhardt <ps@pks.im>,
	=?utf-8?B?UmVuw6k=?= Scharfe <l.s.r@web.de>
Subject: Re: .clang-format: how useful, how often used, and how well
 maintained?
Message-ID: <20250621050743.GA3007684@coredump.intra.peff.net>
References: <xmqqmsa3adpw.fsf@gitster.g>
 <CAP8UFD0YEgh4Oy8MDpT0DfZJgo++NHf3mF6VsYxAG1CjhrKGLQ@mail.gmail.com>
 <xmqqfrfv8dr3.fsf@gitster.g>
 <CAP8UFD27tQ3uhQW5zkPfFZSF=3FGEmi-rBYu3A_zZ8oNbUiNag@mail.gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CAP8UFD27tQ3uhQW5zkPfFZSF=3FGEmi-rBYu3A_zZ8oNbUiNag@mail.gmail.com>

On Fri, Jun 20, 2025 at 04:08:32PM +0200, Christian Couder wrote:

> > A post-commit hook that does *not* prevent your changes that do not
> > pass the "style-check" from getting committed, but does give you a
> > feedback that let you consider before moving forward?
> 
> It's up to each one to decide if they prefer post-commit or pre-commit
> hooks or other ways to trigger the style check. So yeah, we could both
> suggest using hooks and add a format-patch option to make it easier
> for those who don't want a hook.

I'm not sure I would want to make changes at the format-patch stage. If
I am adjusting commits, I'd want those changes in my local commits, too.
Then they'd be there if I re-roll, etc (plus they'd actually be tested
when I run "make test"!). Ditto for folks using GGG, where they need to
push the fully-realized commits.

My ideal workflow would probably be taking a pass with:

  git rebase -x 'git clang-format --style=file -p HEAD^ || git commit --no-edit --amend -a'

is a better match. That command is a bit of a mouthful, but we could
perhaps roll it into a script or a Makefile target. The current "make
style" only looks at uncommitted changes in the working tree (and of
course isn't interactive).

The big pain I see in this (or any other workflow) is getting bugged
about suggestions you've rejected. In an ideal world we'd tune
.clang-format so that all of its suggestions are good, but I don't think
we're there yet. ;)

-Peff
