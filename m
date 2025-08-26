Received: from mail-lf1-f43.google.com (mail-lf1-f43.google.com [209.85.167.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C231C2C17A3
	for <git@vger.kernel.org>; Tue, 26 Aug 2025 18:47:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756234041; cv=none; b=nZt+vugJBvBhdu1yrrHMq3I5CFovcgMRKH6u+mbEgoRbMoIgzfFBbnWgPhD5gqpZ3b5DQ6KLB/d48yzKcc8F2qZfutGEYwZpD5v0thfHEVTXJRgs+rbgh/3/3IsyB8USK9L1F8XILMJTZNcaQ4fiVqzL/xKH826xV/QaiZ+hC+Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756234041; c=relaxed/simple;
	bh=e0x55Qstzwd2e0KrioTkojt/qd7EH67kO+tmK/Y/WpE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=cwsQUugH6xBPI8juiuwp/9OdUJYbOO3j09Hg7p7PtBLBMCJNQZviZA0GuWVHnPTLOe5oD1pQqtpOBnYYJDGeDlELaePQqdXYYu+c6YqmNf7JXO5SUoRLLphAGB/oNhBgIshaYxhUkZeYFZg+ug+h2tUAEnSPMYPMoJJ3dYUNeGQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=HMhwA8p3; arc=none smtp.client-ip=209.85.167.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="HMhwA8p3"
Received: by mail-lf1-f43.google.com with SMTP id 2adb3069b0e04-55f39fc7967so3126188e87.1
        for <git@vger.kernel.org>; Tue, 26 Aug 2025 11:47:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1756234038; x=1756838838; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=e0x55Qstzwd2e0KrioTkojt/qd7EH67kO+tmK/Y/WpE=;
        b=HMhwA8p32m3ogRUtbYi0Y1SZAnEL9yF59z3cz1KMXr2cknGWY+cBzfguV1kq8GWkkV
         tQure8mJO9mTzJEyPqLNiOCy1iZl/ueUtQV8Y1o9xgaF8mmTCFZaSKVgwFV0P+iTFU4y
         HYtmWhr5rtoSeNzYEtlcfBxXzGoBcCCab1x4IceHMG/ScNhkkhyYYsx1/jVev+GefO14
         kX4LwZU1KxZYsHxXdskHkxlYj93mlaA3lKRLWItHfp0DUsAnqDnOOJLQCxO6MIN+7cHX
         Bkej5EF7S+xRnUtBPFsFL3iXDrj7qQoHnl6bs7ZFVvFPyCOzLUw7G+W6DkJCbB4L9WRP
         PJhg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756234038; x=1756838838;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=e0x55Qstzwd2e0KrioTkojt/qd7EH67kO+tmK/Y/WpE=;
        b=bs7tYxxIKmPGzeYeQzgpLcFFXlbFDxnk5zpV9i7XCItcD8amPU25ANzg6ban9O+7vT
         JGx48ohk5Z8NxJeL94E2wsXW5+TLGnRWLINmSavgw9LnBylLS5oKWZgUXQDNEWGL+Lk2
         /mtrG0wbt+Z4Veor/oCy3ihrW7+/oQS1VFshZiLatDTCoMPNfnBnM3ec3JncezZkfllc
         Gwkn7H0vcBYrCVOp9GG+L31sw5jwFHwdLoP8xSu4dg4KGkmWUtJ9TRCYG7je4jGk7cPc
         6AC36bVGsjLgYHaFJ4be9HSBZ29ZcTKTK+RRMhu1tNxR0kkxF1NUiG39jnySRcfiqQZL
         CtEw==
X-Forwarded-Encrypted: i=1; AJvYcCXhPTRXTtw0EdD+yttxPrKVgvKnppAZBbPiO3QVJIpKe1p4hDwPTiQRuBX94ovsfUOfw+k=@vger.kernel.org
X-Gm-Message-State: AOJu0YwH/IZoTtcSOcIquII2Oz/W6fFOpUlmGwROtZ6y4Ex6XQDFR4qu
	TLGQw39bHz8XyV2+3I1XqQ3BRbMdfq+CXeOGKJgs4LBpw4a3RoFfNyfLwPcmliiEukuTTKGi7bI
	R5DinfhrdmJZQZrZY9XUJbDU+pi9pm6lUrcNX8/4=
X-Gm-Gg: ASbGncszfc2SKRssRyfuMkHqrm3TLsMFxzjoMW2c5BDhhH5lfSbYi42pOL/Klqw8X1A
	G+IZoK67SYqf+3721aSFaN65BMHohmZUGNj0EOFXvqZSBvwxZLn+lDzZ4XVOjFituTrltDdAhHd
	XCysDfNZZA/IZ8ZdvoV0ZFS2zuJHB8AWtVVCCe6ueiDLLmCf1D/+xB0JfiwNDfM0ZkicpVaD53M
	Lq44UjE
X-Google-Smtp-Source: AGHT+IFHHxEGRaTecHwn3+H2+YSupBi1feKbxNiqz+wVnIblZirp2WYHWwU6kOcB/YbdQM9yFHib2DkwpxsXX0oaX2w=
X-Received: by 2002:a05:6512:4403:b0:55f:5308:fe03 with SMTP id
 2adb3069b0e04-55f5308ff9bmr218443e87.54.1756234037332; Tue, 26 Aug 2025
 11:47:17 -0700 (PDT)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <db5d22b188740bcb830e4ccf7f19dcc4e6b557bd.1755921357.git.gitgitgadget@gmail.com>
 <71B2DFE6-77E5-47FE-9FAC-AFC1B85DA0E2@gmail.com> <CAH=ZcbA=-iEFnJ-TecAZL_EX-f3pAShDhdq=S2XWkQHYgRZV7Q@mail.gmail.com>
 <CALnO6CASgMQ=cbQ_ijWXV0RMMSZgvS47r8ucTro7Wc4pgZ9_jQ@mail.gmail.com>
In-Reply-To: <CALnO6CASgMQ=cbQ_ijWXV0RMMSZgvS47r8ucTro7Wc4pgZ9_jQ@mail.gmail.com>
From: Ezekiel Newren <ezekielnewren@gmail.com>
Date: Tue, 26 Aug 2025 12:47:06 -0600
X-Gm-Features: Ac12FXxfcmstxYKl2TvY8e-T7QFoF3LJPDWRsC_TTdYpfB1CmwlJWaf_KYQ0TnI
Message-ID: <CAH=ZcbD_pX1YdZbt9b-xMmcu2806twhjECez4HhCyE9iBf-9=Q@mail.gmail.com>
Subject: Re: [PATCH v3 06/15] ivec: create a vector type that is interoperable
 between C and Rust
To: "D. Ben Knoble" <ben.knoble@gmail.com>
Cc: Ezekiel Newren via GitGitGadget <gitgitgadget@gmail.com>, git@vger.kernel.org, 
	Elijah Newren <newren@gmail.com>, "brian m. carlson" <sandals@crustytoothpaste.net>, 
	Taylor Blau <me@ttaylorr.com>, Christian Brabandt <cb@256bit.org>, 
	Phillip Wood <phillip.wood123@gmail.com>, Eli Schwartz <eschwartz@gentoo.org>, 
	"Haelwenn (lanodan) Monnier" <contact@hacktivis.me>, Johannes Schindelin <johannes.schindelin@gmx.de>, 
	=?UTF-8?Q?Matthias_A=C3=9Fhauer?= <mha1993@live.de>, 
	Patrick Steinhardt <ps@pks.im>, Sam James <sam@gentoo.org>, Collin Funk <collin.funk1@gmail.com>, 
	Mike Hommey <mh@glandium.org>, 
	Pierre-Emmanuel Patry <pierre-emmanuel.patry@embecosm.com>, 
	Ramsay Jones <ramsay@ramsayjones.plus.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Aug 26, 2025 at 7:30=E2=80=AFAM D. Ben Knoble <ben.knoble@gmail.com=
> wrote:
> > > Am I reading the patch correctly that the ivec implementation is prim=
arily C? I=E2=80=99m not familiar with too many FFI projects in Rust, but I=
 might have hoped we could write parts in Rust to gain any benefits from th=
at, too. Is that a fool=E2=80=99s errand I=E2=80=99m thinking of?
> >
> > The ivec type is defined and implemented in C (interop/ivec.[ch]) and
> > Rust (rust/interop/src/ivec.rs). When I started writing the ivec type
> > I didn't know if the Git community would accept a hard dependency on
> > Rust, so I made ivec usable in C without needing Rust.
>
> Right=E2=80=94I saw both implementations, but it looked like C did most o=
f the
> work, which was my main question. Re-reading, it looks like Rust does
> more work than I thought (with implementations of insert/push/etc.)
>
> That said, I think it's sensible to leave the type useable from just C
> unless/until Rust becomes required (and then we can move things over).

I like your idea of implementation consolidation. I just don't know
what that would look like yet.

It's not straightforward because C doesn't have generics. I'll use
IVec as an example, but this applies to any generic type in Rust. For
a function like push() in IVec<T> it will have N definitions if there
are N IVec types. e.g. If your code uses IVec<u64>, IVec<u8>,
IVec<i32> that would mean that pub fn push(&mut self) {} would compile
to 3 functions. If you don't use #[no_mangle] you'd have to figure out
the Rust compiler's exact behavior for function names when calling it
from C, which isn't stable or easily predictable. If you do use
#[no_mangle] then the Rust compiler can't generate a generic function
for each type.

Another problem is that the functions in ivec mostly deal with
resizing the memory rather than controlling access to memory for the C
side. Even if the C side used Rust defined functions, that wouldn't
solve memory access issues to the pointer on the C side. We could
enforce access to each element by requiring C to call a Rust defined
function for each element, but that sounds very painful and slow. ivec
is meant to be used as a scaffolding type to help transition C to
Rust.

Other projects that do use Rust's builtin Vec (or some other
collection type) often Box it and write wrapper functions. This means
that the C side sees an opaque void* instead of a transparent struct
like ivec with ptr, length, capacity, and element_size.

I'm curious if the community has more design feedback, or suggestions
for an alternative to my ivec type.
