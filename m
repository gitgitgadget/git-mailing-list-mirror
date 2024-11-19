Received: from mail-yb1-f169.google.com (mail-yb1-f169.google.com [209.85.219.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3209B1D14F3
	for <git@vger.kernel.org>; Tue, 19 Nov 2024 20:56:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732049816; cv=none; b=AzetUVXAdU2OY7XBiS049csslKUKc93z2xc8OPA4ri1OqwE3Iq7f8q2uOY9vN+bB069P2ZzsxahCz+yoPf9mNLEkRamdg0e22L6ltmWcY9YQPu4UY8M/D5LriF/RoXB8l+u4R9ezfYWVESRSm++eFEGjj7hgkwDapz23Y/SX8dA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732049816; c=relaxed/simple;
	bh=Y8MDP9qSu1PlMVQPjcHWKqgAz6ikbYU4y5ygtOn4Kn4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=FW3ZDDNpwzTI2kbyERIKCaKypyvBFaEcjpm6qFSJrbb9Lna3FM24d2bEw14Ek2XzgkwIfbpczvx59TEW9G2LYj4+h/e6elKlN/uAevHFzTiD/tYGkC7IbBZr3pNlRACSvmvLZXHeZgm78YLP9tTguj2fqJYCmwa6IbhuUfdlgP8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ttaylorr.com; spf=pass smtp.mailfrom=ttaylorr.com; dkim=pass (2048-bit key) header.d=ttaylorr-com.20230601.gappssmtp.com header.i=@ttaylorr-com.20230601.gappssmtp.com header.b=KrcbpTH7; arc=none smtp.client-ip=209.85.219.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ttaylorr.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ttaylorr.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ttaylorr-com.20230601.gappssmtp.com header.i=@ttaylorr-com.20230601.gappssmtp.com header.b="KrcbpTH7"
Received: by mail-yb1-f169.google.com with SMTP id 3f1490d57ef6-e38b425ce60so202113276.1
        for <git@vger.kernel.org>; Tue, 19 Nov 2024 12:56:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20230601.gappssmtp.com; s=20230601; t=1732049813; x=1732654613; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=jkv5/qN/RZhHVtC+aWQbozmpYJRndHFpHN+g9Ln6kSQ=;
        b=KrcbpTH7KTjdAkaad8vx5QjAEJwBBpm0x/h/u2T+l2Stp6ZpVitKg4MxuXT2+W7UbT
         ZVAn7PfM/OO7xO3pWzBHcykyrECcZGiiyBjt2Q7XumJ3ZznSToq/DmRl18T/SDDHT8NF
         SwxeOxHaruA/0oiP/RIZARTUazghukZ4glR4RL9iHOBZdssTJkfU62s2GfI1GEZCAl/t
         r4LqcrKoH8wctmnF7fpBbtju0ysVxbDpp0OxlJK7oW44d+m8QaPqtJfFYyuatolISGBO
         2LDFLn6z6PpQti+zhxRygOU+oy6yJ+j5IVd0hGbp9zgvQKK3jg2BVO3SfTlXPSF4HWHE
         Lxvg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1732049813; x=1732654613;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=jkv5/qN/RZhHVtC+aWQbozmpYJRndHFpHN+g9Ln6kSQ=;
        b=d703GToZ9Uz/UmhU9rz/SPf0RGQ+hdhJkyPliJ9TdAuSotyMlr82f173/1nA3o1W31
         zowQSDC2J3gEuwDnbxwrOXhGXH1dQdXEyx1h4MSRoUYYwJcEfK/7pAOeb6JqGqA35Znf
         lI2/PtlLWhhjiimYOKomoBKw3UvfCqJz/eABGq9zgQfFl7HwsLqkxSbQ4BRGMdTbma32
         buZCaQyp5Tt2v5BYaaTJ88hv6hAy7sygT6p0D1N5kbkKsp3NEp0UaxKSU/z79GaqcNLX
         86IP1NqkoeSokN82JTZM/oDDyfREdoDHuuF188SM8lBhRnB5MdwncdI1bEji3w8RQ+54
         ThAA==
X-Forwarded-Encrypted: i=1; AJvYcCUcDirr+9DZViubf4JyyiYwqv3Edn39RIHlrMjgAbTlIkIvVIRHjwsXwsWL9jVbmwL0BDQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YxWcrHh1SBp6bKV8DtlO0Lb6BqIuVphH9nmhMKXLiAo2gV3Domk
	6NfgyN3XLHT63rDzN/A7s2iYL5LuPrwjFVwu1UMp+DQqeAjXG6qAvIX37C9q6hI=
X-Google-Smtp-Source: AGHT+IFM3pRys1y52w5/vIemT7CUyoRHdXHAXc20eA1JClKAUFoxFr39TMrS9y/i/83BlrdkRidn+A==
X-Received: by 2002:a05:6902:1b02:b0:e38:b2ea:a9c5 with SMTP id 3f1490d57ef6-e38ca105522mr477630276.13.1732049812932;
        Tue, 19 Nov 2024 12:56:52 -0800 (PST)
Received: from localhost (104-178-186-189.lightspeed.milwwi.sbcglobal.net. [104.178.186.189])
        by smtp.gmail.com with ESMTPSA id 3f1490d57ef6-e387e73caddsm2753509276.13.2024.11.19.12.56.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 19 Nov 2024 12:56:52 -0800 (PST)
Date: Tue, 19 Nov 2024 15:56:45 -0500
From: Taylor Blau <me@ttaylorr.com>
To: Jeff King <peff@peff.net>
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
Subject: Re: [PATCH] fixup! midx: implement writing incremental MIDX bitmaps
Message-ID: <Zzz7jdI7Y+QEbwRw@nand.local>
References: <cover.1723755667.git.me@ttaylorr.com>
 <cover.1723760847.git.me@ttaylorr.com>
 <afefb4555750661ffd2c573a33d92f8fcb9f435a.1723760847.git.me@ttaylorr.com>
 <xmqqseuozg53.fsf_-_@gitster.g>
 <20240828183356.GA4043247@coredump.intra.peff.net>
 <ZtDEhNRfXth63SJs@nand.local>
 <20240829192713.GA423429@coredump.intra.peff.net>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20240829192713.GA423429@coredump.intra.peff.net>

On Thu, Aug 29, 2024 at 03:27:13PM -0400, Jeff King wrote:
> On Thu, Aug 29, 2024 at 02:57:08PM -0400, Taylor Blau wrote:
>
> > On Wed, Aug 28, 2024 at 02:33:56PM -0400, Jeff King wrote:
> > > Is that right, though? It looks like the caller might pass in a
> > > tempfile name like .../pack/multi-pack-index.d/tmp_midx_XXXXXX,
> > > if we're in incremental mode. But we'll write directly to
> > > "multi-pack-index-$hash.bitmap" in the same directory. I'm not sure to
> > > what degree it matters, since that's the name we want in the long run.
> > > But would we possibly overwrite an active-in-use file rather than doing
> > > the atomic rename-into-place if we happened to generate the same midx?
> > >
> > > It feels like we should still respect the name the caller is using for
> > > tempfiles, and then rename it into the correct spot at the end.
> >
> > In either case, we're going to write to a temporary file initialized by
> > the pack-bitmap machinery and then rename() it into place at the end of
> > bitmap_writer_finish().
>
> OK, that addresses my worry, if we're always writing to a tempfile (and
> I verified with some recent stracing that this is the case). So renaming
> that into tmp_midx_XXXXXX.bitmap would just be a pointless extra layer
> of renames.

Yeah, I think we are OK here.

> I do wonder if it's possible for us to generate a new different revindex
> and bitmap pair for the same midx hash, and for a reader to see a
> mismatched set for a moment. But that's an atomicity problem, and an
> extra layer of renames is not going to solve that.

What you're describing is basically the bug that we fixed in 95e8383bac
(midx.c: make changing the preferred pack safe, 2022-01-25). That commit
sought to ensure that there was no way to have a different reverse index
(IOW, pseudo-pack order) for a given MIDX hash.

It's possible that there is some case that we're not yet covering, but I
can't think of it. The things that we care about are (a) the set of
objects, (b) the set of packs those objects came from, and (c) the
preferred pack. We don't store (c) directly, but we can infer it from
the reverse index, which we do write within the RIDX chunk as you note
below.

> > On the caller side, in the non-incremental mode, we'll pass
> > $GIT_DIR/objects/pack/multi-pack-index-$hash.bitmap as the location,
> > write its contents into a temporary file, and then rename() it there.
> >
> > But in the incremental mode this series introduces, I think it would be
> > a bug to pass a tmp_midx_XXXXXX file path there, since nobody would move
> > it from tmp_midx_XXXXX-$HASH.bitmap into its final location.
> >
> > So I think what's written here with the fixup! patch is right (and
> > should be squashed into 13/13 in the next round), but let me know if I'm
> > missing something.
>
> What confused me is that write_midx_reverse_index() _does_ still take
> midx_name, and respects it. But I think that is a bug!
>
> We do not usually even call that function, since modern midx's have a
> RIDX chunk inside them instead of a separate file. But if you do this:
>
>   # generate an extra pack
>   git commit --allow-empty -m foo
>   git repack -d
>
>   # make an incremental midx with a .rev file; usually this ends up
>   # as a RIDX chunk, so we have to force it.
>   GIT_TEST_MIDX_WRITE_REV=1 git multi-pack-index write --incremental --bitmap
>
> then you'll end up with a tmp_midx_XXXXXX-*.rev file leftover in
> multi-pack-index.d (since, as you note, nobody is moving those into
> place).
>
> So probably write_midx_reverse_index() needs the same treatment to
> derive its own filenames for the incremental case, and to drop the
> midx_name parameter.
>
> Or I wonder if we could simply drop the code to write a separate .rev
> file entirely? I don't think there's a reason anybody would want it.

I would kind of like to get rid of it, but we use it in a couple of
places in the test suite:

    $ git grep GIT_TEST_MIDX_WRITE_REV=
    t/t5327-multi-pack-bitmaps-rev.sh:GIT_TEST_MIDX_WRITE_REV=1
    t/t5334-incremental-multi-pack-index.sh:        GIT_TEST_MIDX_WRITE_REV=1 git multi-pack-index write --bitmap &&

And both of those tests are testing the old behavior, which we need an
out-of-MIDX .rev file in order to do. Alternatively, we could store a
test fixture in the repository that contains these files so we don't
have to build them from scratch.

But after the xz incident earlier this year, I am *very* wary of adding
binary test fixtures into the tree, since they seem like an easy vector
for attack.

So I'm content to fix the bug here and keep the old code around for a
while longer. The fix is indeed as simple as you described, which is
nice ;-).

Thanks,
Taylor
