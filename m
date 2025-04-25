Received: from mail-ed1-f44.google.com (mail-ed1-f44.google.com [209.85.208.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 40A5023278D
	for <git@vger.kernel.org>; Fri, 25 Apr 2025 08:09:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745568574; cv=none; b=tqKHxYPcyxDn2RekFfpuX19Gfv2v2fgAAXHgbgW2YWSS5gHX6jVgYrn8opgO73KQQS6PQSx0mJi0BxCl2WQaRSuIYGEAX5GXHSc8YZ3/D2Fux0gjRvCOGGkfGgx/YN4bxLdbyjJ5yiC8TL21CCI0iQM04QBKCewlp4LqdEyfj7c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745568574; c=relaxed/simple;
	bh=Ugr9IRFrJjwvLMUVD6LZb3t9GA8KlK6KS3o6DUA0wwY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=glJ5qwTzmzM/6qkpDmepyiMOaBnSD1tXbJd8UAuEXMmLxGR6+OWvTLpNLHwB+9eGTU5e92u1BunYjo0PKwLh3cP3EawwZK4Cyy1w41gMh6+2ufRPFQ1LVGM8w55ADyeE0TgbeVEi4WjDxBBoGze5H3HVLmKW5y3peI28YJbpWpo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=GPDHiIw1; arc=none smtp.client-ip=209.85.208.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="GPDHiIw1"
Received: by mail-ed1-f44.google.com with SMTP id 4fb4d7f45d1cf-5f624291db6so3405097a12.3
        for <git@vger.kernel.org>; Fri, 25 Apr 2025 01:09:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1745568570; x=1746173370; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=SaCpO/X7FudlFC7/WPqiE3kVP+tHvg33YHtVZdJ/N0Q=;
        b=GPDHiIw1QnHKtMHUKajgrDbo2lwMFC/3ZbbGrRtSIoRUjeueOsxFutZghzXVbBdEBT
         CYauFPoASIgdzhgcOrniHHdK3kch0SRC9IkaX6n6E4c+6VR+mpUZeZhGd3lc/Ywv3PsG
         aqt+v4kWY9wHRAMAfoAUMzYGhvjOQXKspmqG4x5yX3EDd1UuNpXkUqww9lX5yhLzYArf
         YYgOXmYo5l4XppyrNmXwLTGRKI0hIf3jMZ8CmZWpuNBg9qJWU3Gk54SdWpzbVdkUmhQh
         h3ZWQFqzvLiaCPKHBqi5+gEIvJ9ITfAxDphH0nHMJvg4qJnGcWOPxqDCJITFfS4vNVqT
         AD1Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1745568570; x=1746173370;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=SaCpO/X7FudlFC7/WPqiE3kVP+tHvg33YHtVZdJ/N0Q=;
        b=xLFCViMm8XI2w4GGs1dPBaUCIyOsNaoBPcVZowqtgUkRgs0nfvfDpLH9syPx18/s+L
         UTJFBJlJpnvAeDBAPPI/l9xwElr8SGydUm25FmKqcRlPUhqbf8S7r8T0sgCM19lQgtEy
         q0hwET13TtjL0pYeqbePjei84Hb6CYZBauGigQX80Fnm6zjxT9kSKZXhsw963YJdgInX
         lKR1ZJOYEDpVCEJKK3kub/9J1cXV5bTsuFaWCporfWje/6nkCjgUdbu/pTqHa8P8MOTO
         wueQtmN9g7nmovmr44gd43hymXYzqoO9K5QcviAg10cOuJzbAfMhnZLn/I00x4t+9HYu
         4psQ==
X-Gm-Message-State: AOJu0Yx6dnnk6VJvQR7vxcU8cEJb7EPdlryie0N69jXySbFzVvCbDxdA
	+rvGtC+lZnPZCEVN+MEGHMY7oYUOqiYnd35/XnUik4wcM8gFtzLj6sG1bf4mJF6sMEAO6ln5u7d
	ShRbvzHXCfave0Qrx0dV3iT1qW9mqJTlh
X-Gm-Gg: ASbGncv4oicuPN21C5tu1gvSDyizrU6oqcUL8Zwij70xNklGhfV6bGMp4w/ISTtqbdr
	TR/m6EDxedViqFJv0x8WxdDGxmMwqmREL1VBRNRYgvVR6Yq74ghUuuHd+jltM5Cp/N+gHxCRrne
	7ogkMkgtzbFrYP4Pc1Fur0U0a8Pecs+pqYcTru1dvOcS64yOhR43RX0g==
X-Google-Smtp-Source: AGHT+IGoJxVWKg6P1Owcq5c5qirh10U0clvNwrE8bwFxOJHauQSmRJ0ql8tJnzC6G67rL0EgtIDyPAsr7YeguahuPt4=
X-Received: by 2002:a17:907:7d89:b0:ac3:f1dc:f3db with SMTP id
 a640c23a62f3a-ace71087fc2mr131443966b.13.1745568570355; Fri, 25 Apr 2025
 01:09:30 -0700 (PDT)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250425-pks-meson-benchmarks-v4-0-6b89555052c3@pks.im>
 <20250425-pks-meson-benchmarks-v4-4-6b89555052c3@pks.im> <CAP8UFD0rq7Z=6PUPyPZOXaKyXzbWW7Eb0rDfoTxrd7k4Qo8ciQ@mail.gmail.com>
 <aAtBQ67Vveg1f598@pks.im>
In-Reply-To: <aAtBQ67Vveg1f598@pks.im>
From: Christian Couder <christian.couder@gmail.com>
Date: Fri, 25 Apr 2025 10:09:18 +0200
X-Gm-Features: ATxdqUGkj8lRG0OA43FE_HDxvCzEodXd9Q1xUfKjxnUFCZqTsBUpIxyES4TF9fU
Message-ID: <CAP8UFD37tRiCyZSzJwSbbL=D5b61TGOBMgM5qzeHOQaP-hzbow@mail.gmail.com>
Subject: Re: [PATCH v4 4/5] meson: wire up benchmarks
To: Patrick Steinhardt <ps@pks.im>
Cc: git@vger.kernel.org, Toon Claes <toon@iotcl.com>, Junio C Hamano <gitster@pobox.com>, 
	Christian Couder <chriscool@tuxfamily.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Apr 25, 2025 at 10:01=E2=80=AFAM Patrick Steinhardt <ps@pks.im> wro=
te:
>
> On Fri, Apr 25, 2025 at 09:57:33AM +0200, Christian Couder wrote:
> > On Fri, Apr 25, 2025 at 9:28=E2=80=AFAM Patrick Steinhardt <ps@pks.im> =
wrote:
> > >
> > > Wire up benchmarks in Meson. The setup is mostly the same as how we w=
ire
> > > up our tests. The only difference is that benchmarks get wired up via
> > > the `benchmark()` option instead of via `test()`, which gives them a =
bit
> > > of special treatment:
> > >
> > >   - Benchmarks never run in parallel.
> > >
> > >   - Benchmarks aren't run by default when tests are executed.
> > >
> > >   - Meson does not inject the `MALLOC_PERTURB` environment variable.
> >
> > [...]
> >
> > > diff --git a/meson.build b/meson.build
> > > index 410bbf93dad..2cd05a9b1ba 100644
> > > --- a/meson.build
> > > +++ b/meson.build
> > > @@ -70,6 +70,12 @@
> > >  #      # Execute single test interactively such that features like `=
debug ()` work.
> > >  #      $ meson test -i --test-args=3D'-ix' t1400-update-ref
> > >  #
> > > +#      # Execute all benchmarks.
> > > +#      $ meson test -i --benchmark
> > > +#
> > > +#      # Execute single benchmark.
> > > +#      $ meson test -i --benchmark p0000-*
> > > +#
> > >  #   Test execution is parallelized by default and scales with the nu=
mber of
> > >  #   processor cores available. You can change the number of processe=
s by passing
> > >  #   the `-jN` flag to `meson test`.
> >
> > Doesn't the above give the impression that benchmarks are also
> > parallelized by default while the commit message says they are not?
>
> To me it doesn't because it talks about test execution, not benchmark
> execution. The comments for each of the invocations also discern between
> tests and benchmarks. I'm happy to hear about alternative ways to word
> this though.

Maybe something like:

"Test execution (but not benchmark execution) is parallelized by default ..=
."
