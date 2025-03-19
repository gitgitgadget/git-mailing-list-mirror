Received: from mail-il1-f174.google.com (mail-il1-f174.google.com [209.85.166.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ADC151B2182
	for <git@vger.kernel.org>; Wed, 19 Mar 2025 14:20:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742394025; cv=none; b=JQS+dFLzIpEzfC0wQUAJuusCNWqZP+Dp6IJefdnkF5qdeA0n4KA9oMf4cYYLu/4PmWHOMNHZ9kzBqu5Q8POYWB5IEz+anW4z6OHQQmKPcmLEK2WnD0UKSeT174LdUqx/LGWpXjKhhrYFi4XMX/t+mVoturDl2H383wkgxTAMLhQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742394025; c=relaxed/simple;
	bh=E+NcCKVFaQ0UJxtt897WrU0BLSaoZXcpdwEYv3PM1VE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=tp9P108PF553jdeqicYlAW/TomEHpiIU5KtSdynKa9CL+Gn1UZOdduGve2uFq0eM0zAscvexvxVnjhv5CcBTYtY4HuiaunOKMyeHPnHnIR4mKNpZ5s/E3vFd0iGe7gQlrQwHenzIMrbExXkkjppOtlw4V5kMcW+DXSmbtOLy2pQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=YJNr3Ntd; arc=none smtp.client-ip=209.85.166.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="YJNr3Ntd"
Received: by mail-il1-f174.google.com with SMTP id e9e14a558f8ab-3cf880d90bdso25150635ab.3
        for <git@vger.kernel.org>; Wed, 19 Mar 2025 07:20:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1742394023; x=1742998823; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Wms8Rx5cxF2jWdfgScsw/XwDmpT9TCwqPhSAcnqufNI=;
        b=YJNr3NtdR4pyT7PsJczlS6/fnlI08wr3VwMyzqo9duC7vSe8zviO2A8EJ9sVd9wmlG
         8nn7H4x9W4axl1WFo33Ylyj2jkxeSzb7ncmbb+VIecbHzY4JGhm3jT0XarHKtxBIBF0y
         nKeUIoDvW6Hxdem0/32uo/QL2omXjb8KhDuNVF/tnaW7yVIv3lJCXCFkSDULmmNIYmPD
         xEnuWs3cQ1z0AMJuG+i5nUXv25v6Ik1xGHjh5AboatchUwNWQQWUcV7+oA4ihRueK4+z
         Q3gzBkGo3UMe2s9eMUL6xchVqGMg3Z8uOSssmzyTneXysYudQYAgCXYg0J1k4wgEcrEQ
         zwWw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742394023; x=1742998823;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Wms8Rx5cxF2jWdfgScsw/XwDmpT9TCwqPhSAcnqufNI=;
        b=Il5h/ubszKt8arlcIKHRd0eA+p7pRvK82lVxlVVsHYwkEza2KOj0SaTG03Q0HBCmBP
         zowS7HuZxP2eNOFq2GQZcLUHb3VU/8qN3fK9wleJEL90C3EjMeS+fkfJdUCADE7U+yBl
         jOKpVaW5xWby5I/XczIAZQwES/V7oD2/BwoS2AcgxUZJdigT5YVxAru1iSRFZBx9rg1o
         VCEVpc0LY1ZMbYfJ94B6wJOHT2iRYI8wpbN5jOeNkh6SQFM2UPYMOD9d72SncNFCzOwO
         DCF3tAAYJYlMASMqZI+QHerhj7alnEy9tJVJgamtX4cCg6ffh35oEv/WgXD6Xq34wvKC
         twvw==
X-Gm-Message-State: AOJu0YwZCh+y4D8BfAfI+/7GJxSEZmrU0LgO0pxt/stWLgevS4MJqbBU
	OuOX6DRQGJ2GFQFdgRI+Wk1Rz8+AVF8OSaqvmZxoIEcIrHy963A10saB40xKpM3GfxuXhxXCBk0
	hmdSUzYfYPfsW0W8ANXh8+UVzfHc=
X-Gm-Gg: ASbGncvCiNyK+OWLmsTe45TvRQBQMhEZZWlaTvU0MrtujYUkepeTy4gxyIlEKuZXWHA
	Ug0+fqG6uzSgucvOttmuf56NS1w0BVuVVkUk0vMrAWnKhUCx0PzSwtJGiaTbptB9+on3BbAycW/
	RaiGOTt4vUUgtPtuLs591w1dirP+MW
X-Google-Smtp-Source: AGHT+IGt4aJKVqP7gg8Wntg1IT8w5rUfC7/wTsSZV0uZzF+ROVCWbp7TJT82wRiV2jnqjrBzTH1IvOHkB3K6V545AvQ=
X-Received: by 2002:a92:c263:0:b0:3d3:fdb8:1792 with SMTP id
 e9e14a558f8ab-3d586ba4e6emr22342995ab.14.1742394022478; Wed, 19 Mar 2025
 07:20:22 -0700 (PDT)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <cover.1742252411.git.me@ttaylorr.com> <5e8bd3e66e304f42d4e84ec2aa9f06b82321d64b.1742252411.git.me@ttaylorr.com>
In-Reply-To: <5e8bd3e66e304f42d4e84ec2aa9f06b82321d64b.1742252411.git.me@ttaylorr.com>
From: Elijah Newren <newren@gmail.com>
Date: Wed, 19 Mar 2025 07:20:11 -0700
X-Gm-Features: AQ5f1JouehHiIVMO4fQu_MNJ2W8XdGLfKw9wTopNaSTpjHp3aMxQyZZnASV_DS0
Message-ID: <CABPp-BHmFCHX85e4SrLpTshMVx2nbAkLhnZoZ5LRX15V8MEs8A@mail.gmail.com>
Subject: Re: [PATCH 2/5] t/t7704-repack-cruft.sh: clarify wording in
 --max-cruft-size tests
To: Taylor Blau <me@ttaylorr.com>
Cc: git@vger.kernel.org, Jeff King <peff@peff.net>, Junio C Hamano <gitster@pobox.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Mar 17, 2025 at 4:00=E2=80=AFPM Taylor Blau <me@ttaylorr.com> wrote=
:
>
> Now that a number of new tests have landed in t7704, make sure that they
> all make sense and are testing the things they say they are.
>
> Things are mostly OK, but a handful of tests needed tweaks. Those tweaks
> are as follows:
>
>   - Use the terms "too large" or "too small" in tests that exercise the
>     '--max-cruft-size' behavior. This has historically been treated as a
>     threshold beneath which to combine cruft packs, but that will change
>     in a subsequent commit. Prepare for that by using a more generic
>     term.
>
>   - Remove references to "--max-cruft-size" in the freshening tests.
>     These tests provide coverage of our ability to record updated mtimes
>     for objects already in cruft packs whose mtimes are upserted from
>     various sources (loose objects, finding that object in a new pack,
>     another cruft pack, etc.).
>
>     These have nothing to do with the '--max-cruft-size' feature, and in
>     fact none of the tests even *use* '--max-cruft-size'. Name them
>     appropriately to make it clear that these tests exercise freshening
>     behavior, not '--max-cruft-size' behavior.
>
> Signed-off-by: Taylor Blau <me@ttaylorr.com>
> ---
>  t/t7704-repack-cruft.sh | 20 ++++++++++----------
>  1 file changed, 10 insertions(+), 10 deletions(-)
>
> diff --git a/t/t7704-repack-cruft.sh b/t/t7704-repack-cruft.sh
> index cd452040ea..e6e4c2fad8 100755
> --- a/t/t7704-repack-cruft.sh
> +++ b/t/t7704-repack-cruft.sh
> @@ -149,7 +149,7 @@ generate_cruft_pack () {
>         echo "$packdir/pack-$pack.mtimes"
>  }
>
> -test_expect_success '--max-cruft-size creates new packs when above thres=
hold' '
> +test_expect_success '--max-cruft-size creates new packs when too large' =
'
>         git init max-cruft-size-large &&
>         (
>                 cd max-cruft-size-large &&
> @@ -173,7 +173,7 @@ test_expect_success '--max-cruft-size creates new pac=
ks when above threshold' '
>         )
>  '
>
> -test_expect_success '--max-cruft-size combines existing packs when below=
 threshold' '
> +test_expect_success '--max-cruft-size combines existing packs when not t=
oo large' '
>         git init max-cruft-size-small &&
>         (
>                 cd max-cruft-size-small &&
> @@ -236,10 +236,10 @@ test_expect_success '--max-cruft-size combines smal=
ler packs first' '
>         )
>  '
>
> -test_expect_success 'setup --max-cruft-size with freshened objects' '
> -       git init max-cruft-size-freshen &&
> +test_expect_success 'setup cruft with freshened objects' '
> +       git init cruft-freshen &&
>         (
> -               cd max-cruft-size-freshen &&
> +               cd cruft-freshen &&
>
>                 test_commit base &&
>                 git repack -ad &&
> @@ -257,9 +257,9 @@ test_expect_success 'setup --max-cruft-size with fres=
hened objects' '
>         )
>  '
>
> -test_expect_success '--max-cruft-size with freshened objects (loose)' '
> +test_expect_success 'cruft with freshened objects (loose)' '
>         (
> -               cd max-cruft-size-freshen &&
> +               cd cruft-freshen &&
>
>                 # regenerate the object, setting its mtime to be more rec=
ent
>                 foo=3D"$(generate_random_blob foo 64)" &&
> @@ -275,9 +275,9 @@ test_expect_success '--max-cruft-size with freshened =
objects (loose)' '
>         )
>  '
>
> -test_expect_success '--max-cruft-size with freshened objects (packed)' '
> +test_expect_success 'cruft with freshened objects (packed)' '
>         (
> -               cd max-cruft-size-freshen &&
> +               cd cruft-freshen &&
>
>                 # regenerate the object and store it in a packfile,
>                 # setting its mtime to be more recent
> @@ -304,7 +304,7 @@ test_expect_success '--max-cruft-size with freshened =
objects (packed)' '
>         )
>  '
>
> -test_expect_success '--max-cruft-size with freshened objects (previously=
 cruft)' '
> +test_expect_success 'multi-cruft with freshened objects (previously cruf=
t)' '
>         repo=3D"max-cruft-size-threshold" &&
>
>         test_when_finished "rm -fr $repo" &&
> --
> 2.49.0.rc0.6.g7f120c35e9

Using --color-words for this diff makes it easy to see the small
wording clarifications; looks good.
