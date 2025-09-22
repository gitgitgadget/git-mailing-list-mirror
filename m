Received: from mail-lj1-f169.google.com (mail-lj1-f169.google.com [209.85.208.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F30CA19CC37
	for <git@vger.kernel.org>; Mon, 22 Sep 2025 15:31:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758555086; cv=none; b=oW6twYw5Qf90nMov5x5L6DT+aCjSKELP3Xvz+xomo6g165i4X2ce+dFNQsLhzCjxFuZitVdKLxul911kvfBlgsRTehJsTvFxYzLQCw7/BqJ6CRXZsxnP2K+F4fa7g3f8keq6B9tKLOU8LjfJ28qqLoS/Uy8LJE4xWrLImhZLmaI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758555086; c=relaxed/simple;
	bh=TXNabU0LpjPgE3mHAK/RXSJyVM01RNz0ZRhvetIB1GQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=kGWlS/HQSTUTszVNMM4UW7TCAg9WSZijtCsj/S7qUaL1AARHkWxLdwUhWL8xPWwx6+ToUuekLny0Lq/b6vu/qFg2QU0oGI9wTL9C86aC47KSbyy9S05/igGAumJUDbiVQLRDALvrkRloKOL8rFBr8EcX3ypyKmFgxr8fpa7TIyc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=aOPv1oUc; arc=none smtp.client-ip=209.85.208.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="aOPv1oUc"
Received: by mail-lj1-f169.google.com with SMTP id 38308e7fff4ca-36527ac0750so24666941fa.3
        for <git@vger.kernel.org>; Mon, 22 Sep 2025 08:31:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1758555083; x=1759159883; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Vyv0viX9FyX33Ev3G7XyIcWJiJrokJVwL28eb7Vc1JI=;
        b=aOPv1oUclnpInkDgxlSQTRXVbwUgWqmsjxt15xSTIN0g5M/nljog6JA8TyKtXjol/5
         vgxUoSUHG1OtFA32bLIiTmdmB2AfGbXvYG1k7jdblcf75WYWA3pDljrezMykheK52Bxu
         bIezxigkB5OCaHtOY3deLW1Ri8A5EnDiCpH0ID30ySsZHS8Z5qWvvHhNz2P0t3DaACqh
         vwJc954UoUaN4u0F1dSU4uPGqn3FG/tSNpYHaI8SzUGcz9T9kvbEQynLq2zT4wcCbzqV
         7ALAHFgslCU7zgrQvumQkEU7CdcQ8aD7hHQTAnWkCztUShgVJhhQ7hISXm57OLZimsQ6
         pT9Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758555083; x=1759159883;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Vyv0viX9FyX33Ev3G7XyIcWJiJrokJVwL28eb7Vc1JI=;
        b=bgEcUajLO+jRajs9A1AV0PbWK9WDuOml9/xU2wqDtiN7TR5QK5KcONejwxwMXX+d/Z
         q1bucIoWl/ol0jkxJ3c0HBI2YwkWXYYXB8poDgmJT0a5lN2tq8afObxhlOoSBRVPtOvV
         8vyia+2DUPcUFZwLd5+D/VsUkgRyAB2kDsfcMOzKt/Osv3ro1r4YAPKuz60fxbq5mfR2
         2IWUo8i8zIfjcRTceVqCk5ODiMF0IBGv+qbtCvGM4F5Ky7lq1NXiaSeiwhEiH3V7C+IZ
         I90+TurG4o1xfZxzUGF34NkTKsVyEJlNjYVgt7q0uL4FWDVeJGWWXX654fhdP+VdNjtP
         6n6g==
X-Forwarded-Encrypted: i=1; AJvYcCVhWnkfkx8sXRNVSZIapsLSvWKxv2Ehjl2HzC6dxxt881W6vxwvq3ZiiOK/Wqce7TXlZdg=@vger.kernel.org
X-Gm-Message-State: AOJu0YytIxpXrEguZmrF1KY2skaIRO0PS5R9ELMepciU38aF6cIVc1UJ
	hBQHWg+kGlrik6Db5+TObvNVASgfDHr05ZPvTrVcmmG4POJ6BPcc4LR5hS1knE5r41KnUbDBffI
	uhhZ68oX9cDbbKW6Tgw9gBLiXfOv1JYiq4SK+
X-Gm-Gg: ASbGncudzV45CNACFreOr7b5xucVC+D1G1ZHJp0iMTjNn7UY7ZlEegRxJcGiHG1s3Mf
	ASM0TNowxQjwvtGZMKiS1PJ8xTP3RqLMgsQTd5lhVgZOBbaH0rV5DMMZF+v32ti4UZGYeh9ni+D
	uyqXLXVHyQ3RJ/Gew9CXE4AfLXNXBfKjgVYhAzFEoXv+tbxlukOQTFt/WJJqeFjXULoffn40kM/
	ukt+QV/22hEiJ2E/Qs=
X-Google-Smtp-Source: AGHT+IG6agkEdkIviIXFxgsT2FHHCyCEA6XKXPsNoR36e6RbWliQ1/sNjLse642DjC29TNy9SrZ11dAR8OAriQ0o+fY=
X-Received: by 2002:a2e:a587:0:b0:36b:95e3:1c90 with SMTP id
 38308e7fff4ca-36b95e31fdbmr11441751fa.44.1758555082898; Mon, 22 Sep 2025
 08:31:22 -0700 (PDT)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <pull.2043.git.git.1756496539.gitgitgadget@gmail.com>
 <pull.2043.v2.git.git.1758071798.gitgitgadget@gmail.com> <aMpODEpyaaVhFMO0@pks.im>
 <CAH=ZcbBNFSwU7E+P7hkQnt9UrMKiCRESgGvWPL7pRUa0i2U5-Q@mail.gmail.com> <aNFIozagGc0MoseL@pks.im>
In-Reply-To: <aNFIozagGc0MoseL@pks.im>
From: Ezekiel Newren <ezekielnewren@gmail.com>
Date: Mon, 22 Sep 2025 09:31:10 -0600
X-Gm-Features: AS18NWAGexN21Sbt8Qj-O5KD2Af9HqOJurXOxJ0lpFapYM8pZRfWKgUuQn7QoyI
Message-ID: <CAH=ZcbCZXavx52521cFHdXZn=BCWBiR1aG10ekZVg3PVVJb2VA@mail.gmail.com>
Subject: Re: [PATCH v2 00/18] Introduce rust: In xdiff
To: Patrick Steinhardt <ps@pks.im>
Cc: Ezekiel Newren via GitGitGadget <gitgitgadget@gmail.com>, git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Sep 22, 2025 at 7:01=E2=80=AFAM Patrick Steinhardt <ps@pks.im> wrot=
e:
> I don't think there'd have to be major changes to the current version
> of my patch series. The idea of that patch series is very much getting
> buy-in regarding our roadmap and focus less on the actual build infra.
> So the changes introduced are mostly an MVC, and I very much think that
> we'll have to iterate quite a bit on it, but that's intended.

So long as you're flexible with the build infra details then I'm ok
with rebasing on your work.

What does MVC stand for?

> I think that a lot of the steps you outline below are logical next steps
> to get there. If I can change anything to make these next steps easier
> for you I'm happy to do so. But I also don't think it's too bad if we
> have to change the current infra quite significantly to get there.

I think we can discuss those code and infra changes in a later patch series=
.

> > I wanted feedback on:
> >   * Cleaning up Rust type name collisions
> >     * People don't like it, so I'll drop that
>
> I don't have a strong opinion on this. If it creates issues I personally
> don't mind fixing it.

Junio doesn't like it, so I'm not going to do it.

> >   * Have Makefile produce libgit.a correctly.
> >     * I think this is a good idea, but it doesn't belong in this patch =
series.
> >   * Adding Rust unit test which required fixing Make and adding
> > build-helper to reduce boilerplate code
> >     * I think this is a good idea, but should be added later.
> >   * Introduce cbindgen to avoid desync errors between Rust and C.
> >     * LIke other points above; This should be added later.
>
> Agreed, these all make sense to me.

I think the changes to Makefile to build ligbit.a correctly can be an
orthogonal patch series. The rest can come later.

> >   * What should we call the crate that will be the new home for .c and
> > .h files in the root of Git?
>
> We could call this something like "libgit-ffi", but I don't care too
> much.

I prefer Eric Sunshine's suggestion of gitcore, no hyphen.
