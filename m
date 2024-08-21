Received: from mail-qv1-f46.google.com (mail-qv1-f46.google.com [209.85.219.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 098AB1AF4E4
	for <git@vger.kernel.org>; Wed, 21 Aug 2024 17:02:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724259779; cv=none; b=iWmeajjCRbsFFDSWwoOkPLS4WqWMwmvhIxnwUT8taHG6P1yKt/iBUmUCw0Eb2GmwZOx1SpKD5897TyZpZFox2P2LePwGjgcn9j7UpTwP/zJ7GGK3MsAwWNRCvCulwTDeLRxS/2ak0twKrsNbVOhB0QxV1KdS1eQpcvrotmUVLRI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724259779; c=relaxed/simple;
	bh=RPEBaAT7raU4DmWkTOFQbmj8qyoUnDW/75dFGP+hz+I=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=U+FA6ZEc2kSDE3dC+vbM/HxvZ3Hy9LczFKG2gVn1t7k1D+DhEDH7wEAms3QgD7em0gQe+P0NW8ApYqiIL3wDI2mnWrjpQS6DO9x/Mh9KmxMn8eDTAxiRxfobI17EHdsIBX8Y0gdxGKEN5BkiYn2vB6hOKth15Y76WN3ICFgduSs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sunshineco.com; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.219.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sunshineco.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qv1-f46.google.com with SMTP id 6a1803df08f44-6bf80db6c8eso3103406d6.3
        for <git@vger.kernel.org>; Wed, 21 Aug 2024 10:02:56 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724259776; x=1724864576;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=eM+5xcWRfRwf3BIT11Z95ndRg851L4Ec7fvoCFKUagY=;
        b=TCINXyoXLZVrgLwPthWRvp3Re5QGDqL9dkSzGPeR4ZrmwbMiimidlMD4tWuqTKmcIW
         lBJfuXDaffM/BVpyrNloqrq6S5Rc06JTb5guYwLYzaOukW3qwhhB2DejWB/vLswzEcac
         APZFtHNDJHYY+Kqv2oZlnlt1wUdAY8+8872jutFGDeEHwPPWYRzRSQ6tOfA1rMqFE+qU
         LtubgnLc60cbWrSHQGB/cvm6ccAWGk9squZke2SNcsB+e1k0Pg0mNGctf+4BG/ggft90
         ZF3pGWDagrR9jq6J4+A1hIe5ygxzKeyxDvcHbMoQXfTHqleei6sQIBIc+dN732V4Iuig
         q6aA==
X-Gm-Message-State: AOJu0YyRG1j0tSd70SiZmXsjcW9i8k81YrUoC2rFLTXtgKgtn3m8TqL0
	dU3Aw+rYD0tIP5mCCSR6+wmdYmNbEYi/1mpi+Mv9tY7OL8jiI/a/5NHlghY81QQimNrmOoZv4aj
	wy0aAxu//7YWYa6fDue2pQVxTSVg=
X-Google-Smtp-Source: AGHT+IGC2JEXYyxuUu8UN8+y+eqGH8P4VNVEi6vuPXZ8Y3B9K0VYrs7PEkwwf1wIXBOLwQnpkzJipSZqlZoYXcbNRZA=
X-Received: by 2002:a05:6214:3006:b0:6bf:6ef8:70c2 with SMTP id
 6a1803df08f44-6c155c864f4mr22273186d6.0.1724259775712; Wed, 21 Aug 2024
 10:02:55 -0700 (PDT)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240710083416.GA2060328@coredump.intra.peff.net>
 <20240710083755.GE2060601@coredump.intra.peff.net> <CAPig+cTACjostXvjJMnLEpgbnfat9cjM63pLXwNJm1=2P3gq8g@mail.gmail.com>
 <20240821121454.GA498761@coredump.intra.peff.net>
In-Reply-To: <20240821121454.GA498761@coredump.intra.peff.net>
From: Eric Sunshine <sunshine@sunshineco.com>
Date: Wed, 21 Aug 2024 13:02:44 -0400
Message-ID: <CAPig+cRDgzPnYw77VnyGfZbnM69+fu9tMtuR8_2BVK36=Vn2tw@mail.gmail.com>
Subject: Re: [PATCH v2 5/9] chainlint.pl: check line numbers in expected output
To: Jeff King <peff@peff.net>
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>, =?UTF-8?Q?Ren=C3=A9_Scharfe?= <l.s.r@web.de>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Aug 21, 2024 at 8:14=E2=80=AFAM Jeff King <peff@peff.net> wrote:
> On Wed, Aug 21, 2024 at 03:00:05AM -0400, Eric Sunshine wrote:
> > I'm surprised that we're not closing the two file handles opened on
> > each iteration of this loop. Is that intentional? Or am I forgetting
> > my Perl and they are somehow getting closed anyhow (for instance, by
> > the <...> operator hitting EOF)?
>
> They're scoped to the loop with "my", so they'll both be closed for each
> iteration of the outer loop when the handles go out of scope.

Makes sense. I thought that might be the case but it's been years
since I read the "camel book" (thus may have forgotten it), and wasn't
able to find any Perl documentation which stated so (which is not to
say such documentation doesn't exist, but rather that I couldn't find
it).

> You can verify with something like:
>
>   touch foo bar baz
>   strace -e openat,write,close \
>   perl -e '
>         for my $script (@ARGV) {
>                 syswrite(STDOUT, "opening $script");
>                 open(my $in, "<", $script);
>                 syswrite(STDOUT, "finished $script");
>         }
>   ' foo bar baz >/dev/null
>
> which should show:
>
>   write(1, "opening foo", 11)             =3D 11
>   openat(AT_FDCWD, "foo", O_RDONLY|O_CLOEXEC) =3D 3
>   write(1, "finished foo", 12)            =3D 12
>   close(3)                                =3D 0
>   write(1, "opening bar", 11)             =3D 11

Thanks for illustrating. I did think of `strace` but I never use it
because it doesn't exist on macOS and I was too lazy to spin up a
Linux VM and read the `strace` documentation to figure out how to do
what you did above.
