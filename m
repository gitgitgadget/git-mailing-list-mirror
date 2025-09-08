Received: from mail-lj1-f172.google.com (mail-lj1-f172.google.com [209.85.208.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3655920ADF8
	for <git@vger.kernel.org>; Mon,  8 Sep 2025 16:15:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757348145; cv=none; b=XmG7yiWoBFR62e9h/x/+66LontU6wn4oxTr7tlePCWvj/GjQq5RnPMDk6trQ5o3J2+jl/82dEDko31tivTApFm/AqHBaFQ1vCqJLsisKi+f8dxu+GalNbOROunoofyJWy/uKKeiw4C/z68IScQ6YtsM5L9onJniVnzZFUjQ+ljI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757348145; c=relaxed/simple;
	bh=uIRXG6xMt9vdC7FWwgnEnqcz0zSPFaiJ/WczZmw82ws=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=n3ZP8nFlK5ib1HAYOxsXVrS/pYNJWlPMXrlxk3DciZ90ihLQfFRG7Q1LTmFKCiGbQoPGMk6DiCGfo5F6OvH84JJkSoZV4RxfobH7TIy2MBHQuz6qsrCxQC8hIMbIcCnLK1YAHc7Amg43vGB1GAsn6PfrdHCj611saRrfbf6m9nI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=cWQPLyOf; arc=none smtp.client-ip=209.85.208.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="cWQPLyOf"
Received: by mail-lj1-f172.google.com with SMTP id 38308e7fff4ca-336b071e7e5so37404381fa.1
        for <git@vger.kernel.org>; Mon, 08 Sep 2025 09:15:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1757348142; x=1757952942; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=cuFlsvV5bDVMIL3mQUE6Qxlc0OGxJpzNHPZYAojw6cY=;
        b=cWQPLyOfNhJqV5DY48vL3yvpq4y1CpC/adO1H2U/sCDUfJCahot90E6XYtwXstuYxK
         OsJfXM+4yMaBePFNwcQ2QNxTM9+zJPLG8sygX0uAXvXFzdqfNlAG0oDilTLgrD2xnFFQ
         +MAlM6PD8Caf6q9EgXcMcPOchxrw+TvcLTeC/B1IIHw96oEQxP38TvX6jJ7RHqjpKyMz
         9h2Aqh4p8Vi/laMRM9CUuxV7QhqSLpdJKXudPe3NwLu2S69wdCPS9AYmh9RfCzGHYPyP
         cSKjqddjMMoUBUIixJpoJdydz0GFdWJ4fxIkX5kwCUhwrSR6o/PK1z5w1bwotbiPRomW
         dOTg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757348142; x=1757952942;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=cuFlsvV5bDVMIL3mQUE6Qxlc0OGxJpzNHPZYAojw6cY=;
        b=VjwfnYFQ/56VfMfja0jkQvhDP2hB9UTugCRZQwUf4dWA2hcoNBz+YW6e9V4xVxIbzU
         IiBCchvrkrb4s+h/gCi8fgz2F57es2I8doOgd5HJo/ehlpunYFjt63+H4oGtB7iZGaT9
         67CWgZSz/8xv6BRmY2AmMY8akCMySGrSPAmyo9VLXWQM5kys757l1wQjKPSVwc2+S8KH
         tnp/V4YaDFkGfr4X6ZmHFgd5GM8z9ap8oTqJpptfpJrE4TwRE8hhqnzKwUAM6Zl0CjYh
         ZGw5+bdB09XYxScVJUMIBYfN7wC/w5D6Kl0Y83F5ToojHjNwmG/A7m2NCGLO3E0SH8kY
         3dtg==
X-Forwarded-Encrypted: i=1; AJvYcCWeGxvxuItQhetnPhZbVeCbqPy0e8vIHHLqU2xVViep1H6VD4QjWauYOZSPCf6pBNmsb5w=@vger.kernel.org
X-Gm-Message-State: AOJu0YxLo14T4apY7apRtCAuq34EJo8dG5hHI22BGqBy38C2eAtibehc
	YCe8JeuBG8c2Ah1JyFJRJ6cBaU55iXmTVH1zMHdY59fucG4v9lhf/oppICk6fdlPxfZW3a9qIBS
	qUMCk1TjOYkjHYTuB0he6MNfOx2OrQfI=
X-Gm-Gg: ASbGnctAU/2MK3l2B/6xSUhx4+KRMtpn/uOtgBGiMotMxp3tIlwlTbsSDGcu7pSUjO5
	Ip8xvCWtTEnmJoxydwR6jfALCzIdWE5GUs0fLSlHd0KpTuAPHkzaWNOxMhZDcD0cv+Xm7h3Z/Of
	Q0/KhC9h908seG80V/a9ve5ryK33aBQG+R8ANirNpVk1O09qk3L8tdENh10PDuxM9RHn680v0yO
	XDUdTec2wa/aE+G2Ww=
X-Google-Smtp-Source: AGHT+IGVAAqbXLBjd5aEBzpRCZ4FNYeJ7rRyHWhtMdsVeoq7VuriMij1aLEpFa30bMcB/Q5ZiHTBc9RhN3M35jsrGLE=
X-Received: by 2002:a05:651c:1505:b0:332:5171:3114 with SMTP id
 38308e7fff4ca-33b4c66b650mr21384331fa.10.1757348142231; Mon, 08 Sep 2025
 09:15:42 -0700 (PDT)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <pull.2048.git.git.1757274320.gitgitgadget@gmail.com>
 <2a7d5b05c18d4a96f1905b7043d47c62d367cd2a.1757274320.git.gitgitgadget@gmail.com>
 <xmqqjz29x9r1.fsf@gitster.g>
In-Reply-To: <xmqqjz29x9r1.fsf@gitster.g>
From: Ezekiel Newren <ezekielnewren@gmail.com>
Date: Mon, 8 Sep 2025 10:15:30 -0600
X-Gm-Features: Ac12FXyOlUMWpYCjF1IfCuOgos3d1P6GKU-cFF0eunO4aMGpXh5dlI78KGZdB0M
Message-ID: <CAH=ZcbByi8ouj7mcHpOGtVYnHSq_E5_cFXiuiXJmLP-=4nrsvg@mail.gmail.com>
Subject: Re: [PATCH 10/17] compat/rust_types.h: define rust primitive types
To: Junio C Hamano <gitster@pobox.com>
Cc: Ezekiel Newren via GitGitGadget <gitgitgadget@gmail.com>, git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Sep 8, 2025 at 9:08=E2=80=AFAM Junio C Hamano <gitster@pobox.com> w=
rote:
> The standard guarantees that these are all of the above are exactly
> N-bits wide, so I can buy the above types.  But before I can buy the
> above typedefs, don't we need to rename existing variables that
> squat on these names?
>
>     $ git grep -n -E -e '\<[ui](8|16|32|64)\>'
>
> gives some hits, like
>
>     reftable/record.c:678:      uint8_t i64[8];
>     t/helper/test-parse-options.c:123:  uint16_t u16 =3D 0;
>     t/helper/test-parse-options.c:148:          OPT_UNSIGNED(0, "u16", &u=
16, "get a 16 bit unsigned integer"),
>
> to avoid confusion?  There are handful other hits.

Those places should be cleaned up, but it's not an immediate problem
because compat/rust_types.h is not auto included anywhere. These
typedefs live in git-compat-util.h in my "Introduce Rust" patch series
and I never had a problem with compilation or testing. One reason I
included compat/posix.h instead of git-compat-util.h is because it
includes stdbool.h where git-compat-util.h doesn't. I'll be happy to
do that cleanup.

> > +typedef float     f32;
> > +typedef double    f64;
>
> It may be that they can be used interchangeably in practice on
> popular platforms, but are these guaranteed to be equivalent by some
> standard?  C only cares about the minimum required range and
> precision, so you may have allocated enough bytes thinking you can
> fit a f32 but your float may not fit there.
>
> Or does Rust care only about platforms with IEEE 754 and would
> refuse to port to other exotic architectures so the above worries
> would not apply?

If the typedefs in compat/rust_types.h are incorrect for a
platform/target then compat/posix.h or compat/rust_types.h should be
updated rather than relying on Rust's core::ffi's guess as what it is.

On the Rust side: core::ffi assumes that a C 'float' is the same as
f32 and that a C 'double' is an f64[1,2,3]. So I am making the same
assumption that the Rust maintainers are _and_ I'm keeping ambiguity
on the C side rather than eroding Rust's type precision. If a platform
does not follow these assumptions then the compat/rust_types.h should
warn those using that platform or fail to build entirely.

[1] https://doc.rust-lang.org/1.89.0/core/ffi/type.c_float.html
[2] https://doc.rust-lang.org/1.63.0/src/core/ffi/mod.rs.html#80-81
[3] https://doc.rust-lang.org/1.89.0/src/core/ffi/primitives.rs.html#34-35
