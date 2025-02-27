Received: from mail-yb1-f180.google.com (mail-yb1-f180.google.com [209.85.219.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 07B43277811
	for <git@vger.kernel.org>; Thu, 27 Feb 2025 23:03:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740697394; cv=none; b=Dab87pHBeMUFEaJbMuRppD8Wr56M4wxQTyCtw3zHSMRM25vOBGfwHSLdjj+87CM6zs41u8RY1XqBY/URi9n8jvJ52AoscuOa0PctRxXqbg60Gr/kZ7OBogvXHJ6pYqqKomy5LhxcyAdc9AoBg0e72dXFc6zYfU9BpdLvh+aYGeU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740697394; c=relaxed/simple;
	bh=S5ZIaHbn/1lKPC/cRK86HP4hXDL5p6EQ+cfHOuQQrlA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=SoXvaRmcfyUQj8CSLVWIceHESFjBvxJQHY5bxJP39fouWTY7/41a9r/Tut0dln6UysAutPIL+TRI239lseobrvNwLI+dCVm1ZZzopq3O/leclxyZsYuG/BK9ms+rsOQ4SoICHgxmcYBd3kdhirc8BoCshk/BspLFbUhW9JrJQb4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ttaylorr.com; spf=pass smtp.mailfrom=ttaylorr.com; dkim=pass (2048-bit key) header.d=ttaylorr-com.20230601.gappssmtp.com header.i=@ttaylorr-com.20230601.gappssmtp.com header.b=OqzW1zdY; arc=none smtp.client-ip=209.85.219.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ttaylorr.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ttaylorr.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ttaylorr-com.20230601.gappssmtp.com header.i=@ttaylorr-com.20230601.gappssmtp.com header.b="OqzW1zdY"
Received: by mail-yb1-f180.google.com with SMTP id 3f1490d57ef6-e545c1e8a15so1864076276.1
        for <git@vger.kernel.org>; Thu, 27 Feb 2025 15:03:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20230601.gappssmtp.com; s=20230601; t=1740697392; x=1741302192; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=23/4tx8id9TgvKutn01F/r+Zgd0OJojlp+9Jyh5cBXE=;
        b=OqzW1zdYXIk/7Jj1E9DXia5QiiIsDv/rmfWT2AWfYrmzdUmU7sc7TtzsQ+9bkrI8vL
         4pUCLeRxHp5Xt7ueKGN4qV/elSPEp3r6mUny0S9F2yQh3Tj0qOWXacUBxORct3nrxkdA
         3xXk1/RrQJUhevEXiXL6mHFtfGPvFAG7DqK8l1NNYpCGUI8j292yeZK+kAqbfzkKEZZu
         YuNphTm4N55KPj8lQCR1lYkdhpbeghpkz9fsEqWr7bWGf0Omj6u4ecGGtPMYUKDweJZN
         EfK7DUDAqaM+fvfg1PsmNNyWbWf31YFbmHNU9nxsKNkV1qQugfH0But7DIwm+ZenDAdo
         MiSA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740697392; x=1741302192;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=23/4tx8id9TgvKutn01F/r+Zgd0OJojlp+9Jyh5cBXE=;
        b=Nkhf99J54A6zmE9WsCqKsxi33ELDcTEGcPlDXVNAeWZogc2Mp6ptCOtZMuwVTwqbtw
         EK6ybG12G+AH8a40X/ZGZ4sOrYsWSJ6C1xGBf7qdLU8OTM7HDxuLk+c17yzmVWMCkUPx
         n/Us3voVPrjOEWROvm9rEmO427FteUcwF1E4/WgJxoDXv5++jFq+EESVOaW+2WDsyUMH
         f+mhW40MUoeXWQs9ZV1a8nlzU9YOrsB5wHxs2XcZjIZyFY/SmFSYV+L0cBwmtngQxyEi
         +yB5cXJ6TGIxnpcjF+pJjsK/nj+MwVehrQuj1yb9/sShQStHlxjAYbJ+RoxGlQDVsHx9
         YFew==
X-Gm-Message-State: AOJu0YzOycAl5YQayZ0ueDEoPpj+wy8hLYLQASJZe+S5LnSnU51TVkf9
	N2XU1O4V9uiNlszY34lcLbBFiPxnD5YeukWO/F2jQNa64cSC/p0io8BT7br4wBA=
X-Gm-Gg: ASbGncsz6QBCHsp4ImpABB6npt7v8jNWFe/L99DVWCLn9CFBP1vY3U5CywQ/sbYcmM3
	MDN0sU6j9wzELL9hs2/uWRBSouoWpt+T3NFARwCydVoemdrnUYOjp0/Oc1w0kQdKn/jjOfWcSTE
	xiv1DclQJ/6zHMDBO40ZSNaa6YcX8JHBJb5qj/zBG1yJdNgJvbPsmVCZtrHWgeyWB8sMd8NWjau
	gYuIj85la/LQZMTNMO0tyZCkK4TvQaRa6K571oGLcKtTOgsYMDfdkxE7svA8dnuND0QfVBuKY7U
	uCt05bX0dCVFudhH8AJaTTEZliaYm9QwCrPlL6/RTdZIN5d8wYS60hmnx4lj8Rk3n7dEfiSftA=
	=
X-Google-Smtp-Source: AGHT+IEvoKaxTb4P04MeB72HN5CXSFOHMCOEMVQTQ9zkW0zDB1NjvpOSqidLwfvEICxNGusw1GwmYQ==
X-Received: by 2002:a05:6902:320c:b0:e5b:1805:36be with SMTP id 3f1490d57ef6-e60b2e91c81mr1170999276.6.1740697391692;
        Thu, 27 Feb 2025 15:03:11 -0800 (PST)
Received: from localhost (104-178-186-189.lightspeed.milwwi.sbcglobal.net. [104.178.186.189])
        by smtp.gmail.com with UTF8SMTPSA id 3f1490d57ef6-e60a3a1fddesm707269276.2.2025.02.27.15.03.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 27 Feb 2025 15:03:11 -0800 (PST)
Date: Thu, 27 Feb 2025 18:03:10 -0500
From: Taylor Blau <me@ttaylorr.com>
To: Elijah Newren <newren@gmail.com>
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
	Jeff King <peff@peff.net>
Subject: Re: [PATCH 2/2] builtin/pack-objects.c: freshen objects from
 existing cruft packs
Message-ID: <Z8DvLkWys6KaQNJl@nand.local>
References: <cover.1740680964.git.me@ttaylorr.com>
 <c0c926adde2b7c8f4b53b7a274d5b8c040f77e62.1740680964.git.me@ttaylorr.com>
 <CABPp-BGv6J307nTo1sUgAnE+7ZnueSPm4CJLb10wBGQGaPPDWA@mail.gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CABPp-BGv6J307nTo1sUgAnE+7ZnueSPm4CJLb10wBGQGaPPDWA@mail.gmail.com>

On Thu, Feb 27, 2025 at 11:26:32AM -0800, Elijah Newren wrote:
> > However, this process breaks down when we attempt to freshen an object
> > packed in an earlier cruft pack that is larger than the threshold and
> > thus will survive the repack.
>
> ...packed in an earlier cruft pack, and that cruft pack is larger than
> the threshold...
>
> (Otherwise, it's unclear whether you are talking about the object or
> the cruft pack it is in being larger than the threshold.)

Good suggestion, thanks!

> > When this is the case, it is impossible to freshen objects in cruft
> > pack(s) which are larger than the threshold. This is because we avoid
> > writing them in the new cruft pack entirely, for a couple of reasons.
>
> ...freshen objects in cruft packs when those cruft packs are larger
> than the threshold...
>
> Again, just to clarify what thing is "larger".

Likewise, this makes sense as well, and I applied it in my local copy.

> Also, this paragraph while fine on its own is slightly unclear whether
> you are discussing pre-patch or post-patch state, which when reading
> the next two items causes some double takes.  Perhaps just spell it
> out slightly clearer here that for the next two enumerated items you
> are discussing the existing state previous to your changes?

I adjusted the paragraph before this one to make it a little clearer.
Instead of saying "However, [...]", I rewrote it as "Prior to this
patch, however, [...]".

> >  - exists in a non-cruft pack that we are retaining, regardless of that
> >    pack's mtime, or
> >
> >  - exists in a cruft pack with an mtime more recent than the copy we are
> >    debating whether or not to pack, in which case freshening would be
> >    redundant.
>
> s/more recent than/at least as recent as/ ?

Thanks for the careful read, and yes, the comparison here is a >= rather
than a strict >, and that difference is worth being precise about.

> >
> > To do this, keep track of whether or not we have any cruft packs in our
> > in-core kept list with a new 'ignore_packed_keep_in_core_has_cruft'
> > flag. When we end up in this new special case, we replace a call to
> > 'has_object_kept_pack()' to 'want_cruft_object_mtime()', and only
> > reject objects when we have a copy in an existing cruft pack with a more
> > recent mtime (in which case "freshening" would be redundant).
>
> Again, s/a more recent/at least as recent/ ?

I like this suggestion, but I think the wording ends up a little awkward
if applied as-is. I turned this sentence into:

  [...], and only reject objects when we have a copy in an existing
  cruft pack with at least as recent an mtime as our candidate (in which
  case "freshening" would be redundant).

Let me know what you think!
> > +test_expect_success '--max-cruft-size with freshened objects (previously cruft)' '
> > +       git init max-cruft-size-threshold &&
> > +       (
> > +               cd max-cruft-size-threshold &&
> > +
> > +               test_commit base &&
> > +               foo="$(generate_random_blob foo $((2*1024*1024)))" &&
> > +               bar="$(generate_random_blob bar $((2*1024*1024)))" &&
> > +               baz="$(generate_random_blob baz $((2*1024*1024)))" &&
> > +
> > +               test-tool chmtime --get -100000 \
> > +                       "$objdir/$(test_oid_to_path "$foo")" >foo.old &&
> > +               test-tool chmtime --get -100000 \
> > +                       "$objdir/$(test_oid_to_path "$bar")" >bar.old &&
> > +               test-tool chmtime --get -100000 \
> > +                       "$objdir/$(test_oid_to_path "$baz")" >baz.old &&
> > +
> > +               git repack --cruft -d &&
> > +
> > +               # Make a packed copy of object $foo with a more recent
> > +               # mtime.
>
> s/$foo/foo/ ?

Eh. $foo holds the OID of that blob, so "foo" on its own doesn't really
mean anything (even though the implicit meaning is clear from context).
I think changing it is fine (leaving it alone is equally fine in my
mind, but I don't feel strongly about it).

> > +               foo="$(generate_random_blob foo $((2*1024*1024)))" &&
>
> I thought this was creating a completely different foo, which would
> defeat the point of the test.  It might be worth adding a comment that
> because generate_random_blob uses a very simplistic and repeatable
> random character generator with the first argument as the seed, that
> this will regenerate the same loose object as above for foo.

I think the part of the comment which reads "packed copy of" makes it
clear-ish that we're creating an identical copy, but it doesn't hurt to
be more explicit here.

Thanks for the careful read!

Thanks,
Taylor
