Received: from mail-yw1-f180.google.com (mail-yw1-f180.google.com [209.85.128.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9E1AE19ABC6
	for <git@vger.kernel.org>; Thu, 29 Jan 2026 02:31:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769653888; cv=none; b=PiEhiZXjBpun6b79KwWCV3XDdy6iqKnt2EqBS6QbzHk3dQKLYLHgLdGrw+kQ29Db5vB+UMhUEBuLKDQz8EXcCrNGYYEpF6U5izHb16Owpa9FzZu9cftOuMV7WzNXo3cxkX7Nxcr33YzFf/JbuCUmIHe/kQ2s8gGn0RLfsHpy/a4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769653888; c=relaxed/simple;
	bh=0Jw8b+INWHHQS/olWaqShnvSeGC8ZZHgC7N/YtDvXSg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=OqAv7UZk+rAu3rdAZVxuTttEvh3Cj5fP6NewZ91IbN4bCH+ld1hWs67UJurQRg79QGz0s3gF3B/m8Wse1oAZyvTFbeeRWyRR+RnMlamtK+ZO5hJoMnH7OT/mXuNL3pdou9xA8u3IKj7tvlBdHUfHioSVrl/7EARS6elAYX2Gaw0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ttaylorr.com; spf=pass smtp.mailfrom=ttaylorr.com; dkim=pass (2048-bit key) header.d=ttaylorr.com header.i=@ttaylorr.com header.b=gIjPN3JC; arc=none smtp.client-ip=209.85.128.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ttaylorr.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ttaylorr.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ttaylorr.com header.i=@ttaylorr.com header.b="gIjPN3JC"
Received: by mail-yw1-f180.google.com with SMTP id 00721157ae682-7942b9663f8so4821657b3.2
        for <git@vger.kernel.org>; Wed, 28 Jan 2026 18:31:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr.com; s=google; t=1769653886; x=1770258686; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=AF22rS6fp1Kh29cvXv2bctrqL/lbfCBHgSWI9S1lguc=;
        b=gIjPN3JC2shNBTp+6rOrlK29yUjEcfs7386udjYvjFObQzMIWl69jgO9BYI2FdMUhq
         VGqAzLKtUE99qztjVP/W4cjRzguHwgPBeIIvehv9iXeXeUldiyzGCjPYd+xkIkod0xYb
         /IdPG8GrtnfQRbkFEDbNiw8raeSWD+guzbf9CGbrImBVhfoJkBT19kxnFwxsKR5z3QSy
         iksU6pmJiARVV4MtjDIzCqmP50C1jyfwkM1JETLPcgdaOWMHSt3q1wp4NQisAPjU1s2d
         +BF1T1HctDApxlsyGOV8OewUj2Miy88D9IvCtm+UwOA1PMjksMqXhDRAqZjmkss9ZfAB
         A0dw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1769653886; x=1770258686;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=AF22rS6fp1Kh29cvXv2bctrqL/lbfCBHgSWI9S1lguc=;
        b=COUbnQ8EAqukBvOI06EHDXaGA6eu0Y6d20jsJliFlUzh1gOaz1WPy4OfzUfgdCuh7T
         MgVuGvV6Ql4+rhvFPXuJpD18gs1DmkxdywgShkTn9PRYtiD5gzCLTn2SX33LXUtdSjCf
         /5Z4bakODXL+PxfhLmfy+4+ChLq1OzAievEOmNr+CAeReQ7TMAKooTjHU2yq2C8fQCaX
         ierusmXHPAFOssmjtoTWobm9MYqQPpLywU2GDzv3CfxiaQb5+g2d0UXXO2zXEPDfLP/O
         QapOICRLVSnZcYaMt9qiHPjxPeK9bkAWBdFs8INulK0UJJmxDih0IBvmxKo5Pco6gIGi
         jAGw==
X-Gm-Message-State: AOJu0YyH9RShwPWezg/xDpmYjjZLpArX++Gw8gVtYILNxbPrD8fO6B/r
	CnNSOzPP8anUJ3OYEGadC6rUsZvp9OzkOqcH3xKeHPQwRw1c3XLtwI/cXkf0Ck0X1+U=
X-Gm-Gg: AZuq6aKBE0iTxinteX7FkoVWbw85xkX3iWgTsRxwvALPvwtwq/zX2Ww8gYPM1b89iO+
	BupEYBImkJ3hGOcvSDvG2AVcaCut0sYpWFrvrdQuv+jBH6iE627YHIVeZP+SDKUVkX4mdXnnla/
	dfuWo3ao9HrPikdfDXfXVDKN8PhPKs2yH4rC7Xp+x7IJyXRI7i7IK+xQM+iUy3JPqCcl+MwFYRC
	FI2sRrQIJjhWjGnZDQc0ldPjRasrKrgu/JXTo+FuD8RieauiQ4j9Q63HxRuOZHZS3zmbsfa1LLK
	pHrniywPW5KbXP2O6HEn/s4fdV1KxbS/pDGN7oGp71W9N2mopxTfwn6GtETxaXAVXKejYVhtQ0I
	CUueifB9CNOEpHAnB0NXnIkuW+bNLU3PGM0IXIZZu15Ot0phyzgyReFQfG6GHV6yClnBnXD5nlI
	pkUG8bcxdOpOOv2f2hMW1yxta+vMnNb59xJkXifbFv/lDx3LQRBAgnmhxzIT6r/iTebNlhJjGPB
	LMuhiebhwRcm0C+Lg==
X-Received: by 2002:a05:690c:30c:b0:783:6f68:2a05 with SMTP id 00721157ae682-7947ab1cec8mr59150837b3.14.1769653886328;
        Wed, 28 Jan 2026 18:31:26 -0800 (PST)
Received: from localhost (104-178-186-189.lightspeed.milwwi.sbcglobal.net. [104.178.186.189])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-794861d2086sm14176647b3.39.2026.01.28.18.31.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 28 Jan 2026 18:31:26 -0800 (PST)
Date: Wed, 28 Jan 2026 21:31:24 -0500
From: Taylor Blau <me@ttaylorr.com>
To: Patrick Steinhardt <ps@pks.im>
Cc: git@vger.kernel.org
Subject: Re: [PATCH 2/3] pack-bitmap: fix bug with exact ref match in
 "pack.preferBitmapTips"
Message-ID: <aXrGfGUJQ34JAmuz@nand.local>
References: <20260128-b4-pks-fix-for-each-ref-in-misuse-v1-0-deccae3ea725@pks.im>
 <20260128-b4-pks-fix-for-each-ref-in-misuse-v1-2-deccae3ea725@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20260128-b4-pks-fix-for-each-ref-in-misuse-v1-2-deccae3ea725@pks.im>

On Wed, Jan 28, 2026 at 09:49:21AM +0100, Patrick Steinhardt wrote:
> The "pack.preferBitmapTips" configuration allows the user to specify
> which references should be preferred when generating bitmaps. This
> option is typically expected to be set to a reference prefix, like for
> example "refs/heads/".
>
> It's not unreasonable though for a user to configure one specific
> reference as preferred. But if they do, they'll hit a `BUG()`:
>
>     $ git -c pack.preferBitmapTips=refs/heads/main repack -adb
>     BUG: ../refs/iterator.c:366: attempt to trim too many characters
>     error: pack-objects died of signal 6

Oops. While we should definitely not BUG() here, I am not sure I
understand the desired use-case of specifying a single reference as a
value for pack.preferBitmapTips.

Looking at the implementation of bitmap_writer_select_commits(), we do
not guarantee that *any* reference specified by pack.preferBitmapTips
will receive a bitmap. That's because we don't necessarily enumerate the
entire set of commits when determining which ones to bitmap.

For example, if I do something like (assuming that the bug described
here is fixed):

    $ git -c pack.preferBitmapTips=refs/heads/foo \
          -c pack.preferBitmapTips=refs/heads/bar repack -adb

, and suppose "indexed_commits" list has the commits pointed to by "foo"
and "bar" next to each other. We'll look at the next batch of bitmap
candidates, realize that commit "foo" has the NEEDS_BITMAP flag set,
mark it as chosen, and then skip ahead to the next chunk, all without
having looked at "bar".

Looking at the code, I *think* it's the case that specifying a single
preferred bitmap tip with an exact reference name will guarantee that we
select it for bitmapping, but it's not the case in general.

> One resulting weirdness is that two refs "refs/heads/base" and
> "refs/heads/base-something" would now match if the user configured
> "refs/heads/base" as bitmap tips. One could arguably change the
> semantics of the configuration such that a string without a trailing
> slash needs to be an exact reference match, whereas a string with a
> trailing slash indicates a directory hierarchy. But such a change would
> potentially cause regressions with dubious benefits, so this issue is
> ignored for now.

(Setting aside the for_each_ref vs. for_each_fullref issue for a
moment...)

Am I understanding this change correctly that doing something like -c
pack.preferBitmapTips=refs/heads/foo would match both foo and foobar?

If so, I am not sure that that is a desirable interface, especially
since we went the opposite direction in 10e8a9352bc (refs.c: stop
matching non-directory prefixes in exclude patterns, 2025-03-06). Having
the two behave inconsistently from one another feels somewhat awkward to
me and may lead to unexpected results.

At the very least, if we do end up going in this direction (and I am not
necessarily advocating that we do, since I would prefer a more
consistent set of behavior), we should at minimum document it in
git-config(1).

Thanks,
Taylor
