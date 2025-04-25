Received: from mail-ej1-f50.google.com (mail-ej1-f50.google.com [209.85.218.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B71282CCA5
	for <git@vger.kernel.org>; Fri, 25 Apr 2025 07:57:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745567870; cv=none; b=aTWwfbq29linIPTylg5PTMeqRcWp97Xr1cc4UnH5uwPc9XUBLfpy2giW+ARXbUDM8KXN2KnqJ8YNhbtaT6lphoDUkYDgIPxnZR89nOiVZbJevwX7mk7252csBXqqJ05nK1dAROrtBw/x0etxeYTFmDx+rZCa2q8iPSDgWIkEHMw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745567870; c=relaxed/simple;
	bh=pGTTSU6r5qCFx68/ePDkDxay99K5hMvnG1+mQubTcIs=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Bk8CWdi53ZXdiwKI7SgWQ8+EMWe/4LF+h/egoQHBLTg8NPPLxh9OtG14TYw3BSlaVRldODd60nw9scMz5pKC8BnW9JPK/sOgHZBYclQIJpqNBHZlKSMtRCCzYkgb91e+xvAzxDST6H5va1RIg7C6IP5JhYchpLjfGYfRcFjBWfk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=O3aXDp7V; arc=none smtp.client-ip=209.85.218.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="O3aXDp7V"
Received: by mail-ej1-f50.google.com with SMTP id a640c23a62f3a-acb39c45b4eso298909866b.1
        for <git@vger.kernel.org>; Fri, 25 Apr 2025 00:57:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1745567867; x=1746172667; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=1SNfHfeYXjTo+sm/hRSWgAmYfL0MRbqevr64/6x1Atg=;
        b=O3aXDp7Vpm1YtSv0nwrVgsMlBwBC4Krr1Cg/ncS9ddl7j0+sPLiuBvxnnvBpgDVY/c
         ncIl1sCPbPSP3ErC6UPwLt/E6tNgxZT6dQIjBQcxFPPPmkSTS8Yyi88oXE/nftL1epXA
         AkjOHPBJKDEAVBAI+7pLIMwTTWYkJrdOE7zEMBzWnvROd8o9cH4AmPG0zQtP3mso4E8r
         bmfnHz2nO0YlnSi3Q8eKEyKHs7KgiPmUqBPISDbXgChkRqIhsIWf36Yg4sLSnFvXpUTD
         qBAIxI10imdDoHdZjPm8cn+haIu7sVkRDaUpsiBuIPQwniVThqXOT1F48jB+SyF2sUV0
         /Tzw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1745567867; x=1746172667;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=1SNfHfeYXjTo+sm/hRSWgAmYfL0MRbqevr64/6x1Atg=;
        b=gdVXSFFVPxWk7gxByjFIvc6fGN/rRPiHjvHWRUtiswqKDgmsiwy4OKV5+az9BgEOm9
         +G7hThKbYi2zbiwVg1tUt5pX+rycxDhfyFJ/IzBzAHK02+t5WE9s5nmOk+l5fHVPWW7s
         XEof8ocF4KzAqJ4n7/qL7m4p9wpwOMqMwiT9sz0wiocutFrVttu+AhK+q7/mg2VmYcEJ
         ib++I5BrciQ2KFFERRVq4qNtYqFo9ehlVMs/WZHfUxv+DFXdPfGAFhv1lh7+USvH/QFx
         Qw1cGIU5nKh3PpNRDKCPKSutqYsHc/8InIqUQyjLgpJydx3B6TwiWcYrPkhf2u70evJ0
         gq0w==
X-Gm-Message-State: AOJu0Yy6vFcDjKSKm1e1kZQt5KTzPTN3avDFHjqGG60fvi1655yDpYe6
	qzRFcmMLT1C3Vi3Eo5WDmufHXMokrZV9WIzsF4DEncRdHLRlBFs/MZJAZhXaREy6wKuzd8QVtSE
	VjZCxOJuY3rLGSFZxhrEvuB6RmL0UTQ==
X-Gm-Gg: ASbGncuQzl7JMdqFCQeiF61VC1crrccQRnisIMDfD94lDFqFkAH2g1t8xge7D1rflH0
	eMCommJcdKx91stur/cZR5x7HAzmqMfUN1Nnu+npVforXgzHwwWWdN2bJ3ZAkCCgwT8KjTVYju4
	GQO276NxkZUIofRw/bL66+pA50z1Wyi3LYo21xbwVzRRu8xXC5UmxHEw==
X-Google-Smtp-Source: AGHT+IERTfxyTvJhy0hpr1l9QMXj/VblxZruUNLrE8vs4EeMpyczg8usr5ESBMGaeUoNzbDPM9XcsooDaYgAItzVJtA=
X-Received: by 2002:a17:907:25c7:b0:ace:4ed1:e2e4 with SMTP id
 a640c23a62f3a-ace73a6bb1cmr99269666b.25.1745567866695; Fri, 25 Apr 2025
 00:57:46 -0700 (PDT)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250425-pks-meson-benchmarks-v4-0-6b89555052c3@pks.im> <20250425-pks-meson-benchmarks-v4-4-6b89555052c3@pks.im>
In-Reply-To: <20250425-pks-meson-benchmarks-v4-4-6b89555052c3@pks.im>
From: Christian Couder <christian.couder@gmail.com>
Date: Fri, 25 Apr 2025 09:57:33 +0200
X-Gm-Features: ATxdqUExEKnIvPf-oJO4BEFSU4mGrlYui7qJewq8rNF8lhiz9TXm249cgNkpZqU
Message-ID: <CAP8UFD0rq7Z=6PUPyPZOXaKyXzbWW7Eb0rDfoTxrd7k4Qo8ciQ@mail.gmail.com>
Subject: Re: [PATCH v4 4/5] meson: wire up benchmarks
To: Patrick Steinhardt <ps@pks.im>
Cc: git@vger.kernel.org, Toon Claes <toon@iotcl.com>, Junio C Hamano <gitster@pobox.com>, 
	Christian Couder <chriscool@tuxfamily.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Apr 25, 2025 at 9:28=E2=80=AFAM Patrick Steinhardt <ps@pks.im> wrot=
e:
>
> Wire up benchmarks in Meson. The setup is mostly the same as how we wire
> up our tests. The only difference is that benchmarks get wired up via
> the `benchmark()` option instead of via `test()`, which gives them a bit
> of special treatment:
>
>   - Benchmarks never run in parallel.
>
>   - Benchmarks aren't run by default when tests are executed.
>
>   - Meson does not inject the `MALLOC_PERTURB` environment variable.

[...]

> diff --git a/meson.build b/meson.build
> index 410bbf93dad..2cd05a9b1ba 100644
> --- a/meson.build
> +++ b/meson.build
> @@ -70,6 +70,12 @@
>  #      # Execute single test interactively such that features like `debu=
g ()` work.
>  #      $ meson test -i --test-args=3D'-ix' t1400-update-ref
>  #
> +#      # Execute all benchmarks.
> +#      $ meson test -i --benchmark
> +#
> +#      # Execute single benchmark.
> +#      $ meson test -i --benchmark p0000-*
> +#
>  #   Test execution is parallelized by default and scales with the number=
 of
>  #   processor cores available. You can change the number of processes by=
 passing
>  #   the `-jN` flag to `meson test`.

Doesn't the above give the impression that benchmarks are also
parallelized by default while the commit message says they are not?
