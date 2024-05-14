Received: from mail-oi1-f169.google.com (mail-oi1-f169.google.com [209.85.167.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E274FED8
	for <git@vger.kernel.org>; Tue, 14 May 2024 00:58:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715648301; cv=none; b=bgEmcaN0JKChL/14njWFB5q2maiHk1nVWQ/Vi9CmKbwr49Vmu7rztGOHMe/a3rlUbrFu+o1pM01kDCMABl7cuknZ7vS7rymUWtN9SHNmhsoc7RmKlknytz/USNZR6fod0P3GczFRkY8TVvr6mj9FIGbs//0/Sl93/9KtezsU7uY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715648301; c=relaxed/simple;
	bh=VQGVgS5sb0FSxETi9CZNAzOjTMCsx77BhBOPdogADOY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Waux/IA22pJvAEdyJ9UehCp/IpC3HGvvjz4wozdruEhAV4bgLgVWmwYp0iLaF2uvDBx2JA8IBJxoC8auigZOdTlqjX0Mp9RhBZ3DMx57PEvrkQCmc+Y4pvZTSUkWNbi7qTch5XRDnPwxwO6ioohK4UCHzxImGRIxWjYCCEnezow=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ttaylorr.com; spf=none smtp.mailfrom=ttaylorr.com; dkim=pass (2048-bit key) header.d=ttaylorr-com.20230601.gappssmtp.com header.i=@ttaylorr-com.20230601.gappssmtp.com header.b=X51jqsFK; arc=none smtp.client-ip=209.85.167.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ttaylorr.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=ttaylorr.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ttaylorr-com.20230601.gappssmtp.com header.i=@ttaylorr-com.20230601.gappssmtp.com header.b="X51jqsFK"
Received: by mail-oi1-f169.google.com with SMTP id 5614622812f47-3c996526c69so2637030b6e.1
        for <git@vger.kernel.org>; Mon, 13 May 2024 17:58:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20230601.gappssmtp.com; s=20230601; t=1715648299; x=1716253099; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=iV5PZrcZwatD5elwHQ0k3eG+Z3m38hiYlaKOio7qgy0=;
        b=X51jqsFKLcd2Y6xaK96uLU5AHM07VwxGexS3X0QATtu1+FJIEkLIrFXVWhqNGWU0jh
         ORRQaOSeXvPHw0Ls0E9q6U1LeuOw1JrmVbk9cndjbshTH1bO7e174EiFrw2uBNW1VGbr
         QY+XLwMJ1fKl0YjSZJPYy2vsU8ZrXlNAubCNhHxa1mnEJWYE0mQNXQbJ8D9IfuxaWzZf
         xM2ZDtfiQWRnDz8s0T6PFoTcoozvtoYvpatmAkynTzKcE6W+fwkjFq4i2o7i4pWD1sH3
         JoP8bjbImuguTQtK+LPz33FKaJ/YOZyGoaPTTP8CbD+lhGPZoWqUTIjv3ZHCNuQFZNSM
         jOdQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715648299; x=1716253099;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=iV5PZrcZwatD5elwHQ0k3eG+Z3m38hiYlaKOio7qgy0=;
        b=fYSK8GNJhNZasGPlWJdtOW3yqsqRsUwIoJlusbjopQjWxkdyDOak5yrczhdHVStoyc
         LdxXNKo8+cxXyRKIKS2lKPLj0zHXfic0xU4aYRF9UeuZnUExpNAnPj4zpcrJhc9QQ9Lf
         j6a6SalFP+bG7kcq4Kxr0E3REw9pv5omA7fUMZnADvaBhzV8pYvs3U4qZXc6sFQ3EqIw
         lGHX2Lb+kU6PgD/eMRkF9k98bdbcsr1nGJRO5mWXwFJGZYZG4WLjBjayLgnI4PvO9dH9
         BivN6Fiu+GHMYq3Gg9DZirKJzu/De943TuS/3DENOOor+vjK0Cx8reOa+Zbdt0H40sKA
         WqqA==
X-Gm-Message-State: AOJu0YzQMd0pTSOt4GHOyB54BPIrIqLxK1eCTMmYFm0IymOCZ7e7tciq
	v5Vitz0zi+XjgzGjnYvKhAETItCRK0SE6z0d2bX70I1jWg+Z9izw9WBfEKuWVp3klLvHl6zasbO
	G
X-Google-Smtp-Source: AGHT+IGislD22XA+YLnlckTOM9GnulAaSOApUi7tY3wcVu/muAsXoE5QNwJszoQkGIZvVFN00CXjYQ==
X-Received: by 2002:a05:6808:18a7:b0:3c9:96a2:61a6 with SMTP id 5614622812f47-3c9970cc3e6mr15371631b6e.41.1715648298918;
        Mon, 13 May 2024 17:58:18 -0700 (PDT)
Received: from localhost (104-178-186-189.lightspeed.milwwi.sbcglobal.net. [104.178.186.189])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-6a15f185787sm48616406d6.45.2024.05.13.17.58.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 13 May 2024 17:58:18 -0700 (PDT)
Date: Mon, 13 May 2024 20:58:17 -0400
From: Taylor Blau <me@ttaylorr.com>
To: Jeff King <peff@peff.net>
Cc: git@vger.kernel.org, Elijah Newren <newren@gmail.com>,
	Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v2 09/23] pseudo-merge: implement support for selecting
 pseudo-merge commits
Message-ID: <ZkK3KYkA6+zUxu9A@nand.local>
References: <cover.1710972293.git.me@ttaylorr.com>
 <cover.1714422410.git.me@ttaylorr.com>
 <86a1e4b8b9be99563836d1539fbf2ed4c4a6920d.1714422410.git.me@ttaylorr.com>
 <20240513190340.GC2675586@coredump.intra.peff.net>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20240513190340.GC2675586@coredump.intra.peff.net>

On Mon, May 13, 2024 at 03:03:40PM -0400, Jeff King wrote:
> On Mon, Apr 29, 2024 at 04:43:37PM -0400, Taylor Blau wrote:
>
> > Teach the new pseudo-merge machinery how to select non-bitmapped commits
> > for inclusion in different pseudo-merge group(s) based on a handful of
> > criteria.
> >
> > Pseudo-merges are derived first from named pseudo-merge groups (see the
> > `bitmapPseudoMerge.<name>.*` configuration options). They are
> > (optionally) further segmented within an individual pseudo-merge group
> > based on any capture group(s) within the pseudo-merge group's pattern.
> >
> > For example, a configuration like so:
> >
> >     [bitmapPseudoMerge "all"]
> >         pattern = "refs/"
> >         threshold = now
> >         stableThreshold = never
> >         sampleRate = 100
> >         maxMerges = 64
> >
> > would group all non-bitmapped commits into up to 64 individual
> > pseudo-merge commits.
>
> I was going to complain that explanatory text like this should probably
> go into the documentation, not a commit message. But I see you do later
> add documentation. Which seems to happen when this code is actually
> wired up to the bitmap-writer. Maybe a moot point now that I figured it
> out, but I think we'd be better off with the two commits squashed
> together.

I dunno. This commit is already rather large, and I like the split of
"here's how we select these things", versus "now we actually start
selecting/writing them".

But maybe it results in a slightly awkward break in the middle that
leaves some of the stuff that would otherwise fit well in the EXAMPLES
section (as you mention below) in a weird limbo state.

> And consider whether this commit message can be shortened a lot to just
> refer to the embedded docs (and especially if there is any useful info
> here that is not covered in the docs, and should be moved there). I do
> think some of these explanatory examples are good for users, but we
> don't necessarily have a good spot to put them. The git-config
> documentation is more of a reference, and huge example sections would
> probably bog it down. Maybe in the EXAMPLES section of pack-objects?
> It's already a pretty big manpage, though, and this is just one tiny
> corner.

There's a good amount of information already in
Documentation/technical/bitmap-format.txt, though perhaps some of the
pieces mentioned here could be added there. Let me know if you think one
is missing something the other has (or if we could move significant
portions of the latter into the former).

> I've got to break here in reviewing for the moment, but I think in a lot
> of ways this commit is going to be the most interesting one, because the
> usefulness of the whole pseudo-merge scheme depends on picking good sets
> of commits (ones that cover a lot of ground but have a low chance of
> being invalidated). So I'll pick up again with a careful look at this
> one.

I agree that this is where things start to get interesting ;-). I'm
looking forward to your review when you get back to it!

Thanks,
Taylor
