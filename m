Received: from mail-lj1-f180.google.com (mail-lj1-f180.google.com [209.85.208.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7147B254B1B
	for <git@vger.kernel.org>; Thu,  2 Oct 2025 23:35:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759448142; cv=none; b=m7eVvOoGBvyoqaEq83DkVhqDSIDk585uQZLaaaCaEMptu1V3HDcK2KmWQ36SYddBKJJFtznPL94GEMw38hDfeOExOqdi661QLWoxpr+thu8ZU1fP7TJWqHPXMnFv4emfYE1qNB0XE0fk7tJKqoRKLkYHKmjbhJGTDwvnQXjY5vI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759448142; c=relaxed/simple;
	bh=H3rwMI5WAVZO1ZjrWBb0GrsBtnCY0G1zhjRtP2qNOig=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Gnh1UvqcCpHa3sSxYn0p6+EDwXoFI0v8o056e77m1zjWp8h59QJKh2zSjJrKMfWz7jDgEX8Bk/nkDpB46R/jzvGb3KaL33EDO7z5SedSvJ/knar1mVg5sMqPZNV6dB0HQPRuRZKZQNwMcDWt0+k0AvVuZNuy8opnwhcw+Gp0RHg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=A/t6V4+n; arc=none smtp.client-ip=209.85.208.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="A/t6V4+n"
Received: by mail-lj1-f180.google.com with SMTP id 38308e7fff4ca-36a6a39752bso17442081fa.0
        for <git@vger.kernel.org>; Thu, 02 Oct 2025 16:35:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1759448138; x=1760052938; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=bBHAbjLhRhiwOQB3o6i/+9vLxV+mao51lGiPdMpKGnk=;
        b=A/t6V4+nSRmzD5DvFFU8APau7c/tiH8cMeZzJOrS3rngRWlVvXkOtPxMywUQBMMDcK
         3dwerAvd/1YQQscqQb2mgfH1NXyQnhB21Vx4dWgZ6RjoKi7c4ZudZOre5r046u9O57VL
         Y+8AhaDOCal+X9cU9ohN/5VFT3vVAc7I9C8MHxZXbQNC9S7dZqbHXI+B+F89G9/uK3jC
         n1N5fBOoAu1gvroD57iVNcBd4rGIwZzcPu1+8tngH5DYCJKfvxSxj8436/pnHtE4/SWA
         RwcDqxKlOb/6MayfiQX+Vm+02Z6kazLTpdv9n/jI9h7LW7AaeBkFVmZQDT9tiTZ/a1ne
         MSuA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759448138; x=1760052938;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=bBHAbjLhRhiwOQB3o6i/+9vLxV+mao51lGiPdMpKGnk=;
        b=oR21fz85+8sZftg+hnoogtbwC00aJLNuvz0rXwHRC3xZIG89NfZamLPbuyNFY/Yi/l
         tEtFxc7H43nJxe7C7Fa9VM2WWFNJHIDWAf4fXe7o0L9szogsTut+vCKT/yvhbAtBLUJw
         AFAhlhjDwPDQOT94I9nCW0Pho1Cy/jeEwZGJyHKMZ8H+eeKMgvZF9IFH5goxQP4Yzss6
         2wmRH26dPpjonft66tT5vY8qbIudrURm61d6ChAxvCLv6tEjAjZWh1/6qeGZ7pBqpRas
         SqENJDoL9wNV2qDFOdO9ChMh+1bMAhMfT42J0h2mPbfZ1EDXikPWg35SGhs4q1z+h04E
         MPKw==
X-Gm-Message-State: AOJu0Yw2txF2gMe/db8p65Cd1yI4f9O+/LBsEg7crS+4VDH7T1y5wmcn
	K+M9DGvnbRqnPb51aXovRLDnAKexKi2JOlX6PyCZ9l0ALHDQqevaXVOfvarM79Xy7fQxdT6Pb5V
	apH74DUfs9t3NdryfIy+hFHgRDDZhSMWH8NUMAJs=
X-Gm-Gg: ASbGncvhbSHsO1vDsV6MNQujRg4G/ERS2CQmSgu36ioJ9kTACkDzvU+HHTGZWn1JmWY
	sBybcFUTopJMu377nF97+iMAPyC6gPvuUYGceDe1q9HKQyWwwwg2zB9rDeRGPcibaYc00BID+tM
	v+G+rSb16xfyGtSGGkVyzEFhhDce8yFD7hnUO3hSw4CUoKIYfaaTNGljxMI2gGvIPAXKlFC/wxP
	gmSV5xBixAkQN/wIniw5vNfHaEyJzDe9Vv8GvAjjEI=
X-Google-Smtp-Source: AGHT+IEb8UlspXC7e9ftM5dgLF8ZDEibunRBxIDO5lNIQwnx59jPHZ8aDWnTyc/Bw8BG6ihi7oa6DXAfYdZhO7ZNQCo=
X-Received: by 2002:a05:651c:12c1:b0:363:d806:7d5b with SMTP id
 38308e7fff4ca-374c3402645mr2203151fa.0.1759448138249; Thu, 02 Oct 2025
 16:35:38 -0700 (PDT)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250904-b4-pks-rust-breaking-change-v1-0-3af1d25e0be9@pks.im> <20251002-b4-pks-rust-breaking-change-v8-0-3a89fd5b1ce7@pks.im>
In-Reply-To: <20251002-b4-pks-rust-breaking-change-v8-0-3a89fd5b1ce7@pks.im>
From: Ezekiel Newren <ezekielnewren@gmail.com>
Date: Thu, 2 Oct 2025 17:35:27 -0600
X-Gm-Features: AS18NWAU3NXQe8O0T918sRZmScAkPHhJnY_tEeUgGDpdXNDV-sKNoJbqBt4xjNE
Message-ID: <CAH=ZcbA9mXxVU4RWVe-fw7bJa4_BpPSZKUBqGLKqGTWM04gw4g@mail.gmail.com>
Subject: Re: [PATCH v8 0/9] Introduce Rust and announce that it will become mandatory
To: Patrick Steinhardt <ps@pks.im>
Cc: git@vger.kernel.org, "Haelwenn (lanodan) Monnier" <contact@hacktivis.me>, 
	"brian m. carlson" <sandals@crustytoothpaste.net>, Ben Knoble <ben.knoble@gmail.com>, 
	Christian Brabandt <cb@256bit.org>, Collin Funk <collin.funk1@gmail.com>, 
	Eli Schwartz <eschwartz@gentoo.org>, Elijah Newren <newren@gmail.com>, 
	Johannes Schindelin <Johannes.Schindelin@gmx.de>, Junio C Hamano <gitster@pobox.com>, 
	Phillip Wood <phillip.wood123@gmail.com>, 
	Pierre-Emmanuel Patry <pierre-emmanuel.patry@embecosm.com>, Sam James <sam@gentoo.org>, 
	Taylor Blau <me@ttaylorr.com>, Kristoffer Haugsbakk <kristofferhaugsbakk@fastmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Oct 2, 2025 at 1:30=E2=80=AFAM Patrick Steinhardt <ps@pks.im> wrote=
:
> Range-diff versus v7:
>
>  1:  3f916bebd4 =3D  1:  bf7b33291d meson: add infrastructure to build in=
ternal Rust library
>  2:  ed849dcfed =3D  2:  59e7879c63 Makefile: reorder sources after inclu=
des
>  3:  955f262ef5 =3D  3:  635cebc0a6 Makefile: introduce infrastructure to=
 build internal Rust library
>  4:  7a90192b5a =3D  4:  43b50563cc help: report on whether or not Rust i=
s enabled
>  5:  9365a78efd !  5:  37d03d7774 varint: use explicit width for integers
>     @@ Metadata
>       ## Commit message ##
>          varint: use explicit width for integers
>
>     -    The varint subsystem currently uses implcit widths for integers.=
 On the
>     +    The varint subsystem currently uses implicit widths for integers=
. On the
>          one hand we use `uintmax_t` for the actual value. On the other h=
and, we
>          use `int` for the length of the encoded varint.
>
>     -    Both of these have known maximum vaules, as we only support at m=
ost 16
>     +    Both of these have known maximum values, as we only support at m=
ost 16
>          bytes when encoding varints. Thus, we know that we won't ever ex=
ceed
>          `uint64_t` for the actual value and `uint8_t` for the prefix len=
gth.
>
>  6:  e7e0621b68 =3D  6:  0d265f9675 varint: reimplement as test balloon f=
or Rust
>  7:  8d8e9cb8a8 =3D  7:  a6e0d668f0 BreakingChanges: announce Rust becomi=
ng mandatory
>  8:  07dc8171ac =3D  8:  79470835fd ci: convert "pedantic" job into full =
build with breaking changes
>  9:  708a0d3c67 =3D  9:  67f8dea13f ci: enable Rust for breaking-changes =
jobs
>
> ---
> base-commit: 2462961280690837670d997bde64bd4ebf8ae66d
> change-id: 20250904-b4-pks-rust-breaking-change-7167d9d3e37d

I think it's ready to be merged.
