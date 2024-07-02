Received: from mail-qk1-f179.google.com (mail-qk1-f179.google.com [209.85.222.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0FC161DA320
	for <git@vger.kernel.org>; Tue,  2 Jul 2024 21:59:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719957601; cv=none; b=SsOVPz+yYxNAbp2DbB6gwbhiqch6EPYuc/ERnRYc/8XmlqTKMMGkNpsci1ZG9zNzNjyfnjUM5YsUP1tRmu5ITzecUqDMeWalMIv66fDgzZ9/HF+2P/3UArZvSXDbtPx10WhPs9XNs7pw+x4AlBdSI8vm5fXFFnpjHt9VdZ36Mn4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719957601; c=relaxed/simple;
	bh=76isa1OapCwB+WZAt4gyK1NZEiP+XnYue64M7IT8EOc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=dEfU8sqDoAxzuVBthtPFlkSc9vb/Vq/m6vxRkGVgUbGD7t/IlzMfyDWxIqMf8T2XgJrXVZ/XIh23+mlR/PS63ZfkYCJXHLT4qzf6PnY2lHwsEw8y+YHI5xM4+Ujm0n997mZt6Rl27BsgcuCNJR/FaHKMR/NOlJHIzj1uAdGmj1c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sunshineco.com; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.222.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sunshineco.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qk1-f179.google.com with SMTP id af79cd13be357-79c0bbff48aso358543285a.1
        for <git@vger.kernel.org>; Tue, 02 Jul 2024 14:59:58 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719957598; x=1720562398;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Vqw/N4r09G7DEeq8Ot8bJ7am0Q9SX+Quq5cu9C/NszQ=;
        b=ieYVNAeV0V+PqWUbSUIYkB9sdMjCr660697Tiq9NpFc3+X7SRDJ5zYFizaCrvLdgMN
         0vu0thTwV5DCw8SLWmHsFiigd95RIydEcZbmk5MhyvUIz//EHa715PUOH1BXUghs0tY6
         0501jhsXPRQdIa6pOD0rOD7xNMueWbdAVplJMfpDdyO/hu/x/7GuAlXYi9OZukwSQQyT
         Rqz0mA+Xjiqbd9G6AuZ/hWY9ftcGXl/1pCGwWiNS3yqFtShBC1KYy1xje5urR02+twEb
         BDSyhrTSppz2qzbzywz5opV+E8sprlxuetRAEnlwBwG1V228ENQFRXhbflORdS+Jykb+
         dMrg==
X-Gm-Message-State: AOJu0Yxgd6OUPUHxM6cwLmZDY5JqdZZHpSDdTUgOd+qFltQLyma3CvrJ
	nCOyYL4TmU0WMZlzDT4WH67j1R4oW1TDsPvfyXe6OrrdhcdtCawP0zfV26Tzsx5mfhSlqmtR9VO
	EfcYKWBYd5PBMHdlKNXr2xB4XPlSzKh3g
X-Google-Smtp-Source: AGHT+IERdfMQCznaEY3gn8i0Sij8vSuHSjD0luxOD2e6VEj7efdjV8Ghs6tkUPQMz9/cdZn6AZEh3icr7w9WpVzMzfI=
X-Received: by 2002:a05:6214:19cd:b0:6b5:d73d:918f with SMTP id
 6a1803df08f44-6b5d73d949bmr32800066d6.0.1719957598026; Tue, 02 Jul 2024
 14:59:58 -0700 (PDT)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240701220815.GA20293@coredump.intra.peff.net>
 <20240701220840.GA20631@coredump.intra.peff.net> <CAPig+cQdioTBinkacLFb7yktm168oB+qyP9MpZtTRE=1aBz5yg@mail.gmail.com>
 <20240702005144.GA27170@coredump.intra.peff.net> <20240702211913.GB120950@coredump.intra.peff.net>
In-Reply-To: <20240702211913.GB120950@coredump.intra.peff.net>
From: Eric Sunshine <sunshine@sunshineco.com>
Date: Tue, 2 Jul 2024 17:59:46 -0400
Message-ID: <CAPig+cQna9nDzr9it2=VN-4_hUctG+t4=97s5h9KqmNHS=cuuw@mail.gmail.com>
Subject: Re: [PATCH 1/2] test-lib: allow test snippets as here-docs
To: Jeff King <peff@peff.net>
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>, =?UTF-8?Q?Ren=C3=A9_Scharfe?= <l.s.r@web.de>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Jul 2, 2024 at 5:19=E2=80=AFPM Jeff King <peff@peff.net> wrote:
> On Mon, Jul 01, 2024 at 08:51:44PM -0400, Jeff King wrote:
> > Obviously we'd want to add to the chainlint tests here. It looks like
> > the current test infrastructure is focused on evaluating snippets, with
> > the test_expect_success part already handled.
>
> So doing this (with the patch I showed earlier):
>
> diff --git a/t/Makefile b/t/Makefile
> @@ -106,18 +106,28 @@ clean: clean-except-prove-cache
> +       for i in $$(grep -L "'" $(CHAINLINTTESTS_SRC)); do \
> +               echo "test_expect_success '$$i' - <<\\\\EOT" && \
> +               sed -e '/^# LINT: /d' $$i && \
> +               echo "EOT"; \
> +       done >>'$(CHAINLINTTMP_SQ)'/tests && \

Unfortunately, `grep -L` is not POSIX.

> does pass. It's just running all of the tests inside an "EOT" block. But
> we have to omit ones that have single quotes in them, because they are
> making the implicit assumption that they're inside a single-quoted block
> (so they do things like '"$foo"', or '\'', etc, which behave differently
> in a here-doc).
>
> It was a nice check that the output is the same in both cases, but it's
> a bit limiting as a test suite, as there's no room to introduce test
> cases that vary the test_expect_success lines.

Agreed. It feels rather hacky and awfully special-case, as it's only
(additionally) checking that the `test_expect_* title - <<EOT` form
works, but doesn't help at all with testing other parsing-related
behaviors of chainlint.pl (which is something I definitely wanted to
be able to do when implementing the Perl version).

> I'm thinking the path forward may be:
>
>   1. Move the test_expect_success wrapping lines into each
>      chainlint/*.test file. It's a little bit of extra boilerplate, but
>      it makes them a bit easier to reason about on their own.

Yes. This is exactly what I had in mind for moving forward. It's just
a one-time noise-patch cost but gives us much more flexibility in
terms of testing.

It also makes spot-testing the chainlint self-test files much simpler.
We would be able to do this:

    ./chainlint.pl chainlint/block.test

rather than much more painful:

    { echo "test_expect_success foo '" && cat chainlint/block.test &&
echo "'"; } >dummy && ./chainlint.pl dummy; rm dummy

or something similar.

>   2. Add a few new tests that use here-docs with a few variations
>      ("<<EOT", "<<\EOT", probably a here-doc inside the test here-doc).
>
> Does that sound OK to you?

Absolutely. I'm very much in favor of these changes.
