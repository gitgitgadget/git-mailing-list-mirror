Received: from mail-oi1-f169.google.com (mail-oi1-f169.google.com [209.85.167.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1CC4C35677E
	for <git@vger.kernel.org>; Fri,  7 Aug 2026 16:47:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.167.169
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786121275; cv=pass; b=aEjV4e5tzQnsl6PeFA+faKo7vEVITcDEEVEFC9MLsh6d/8umDw9WT4j2N481PKrOqERtnhb/yrEIBNgDiDB7aRcswZ+u+X2yPlOkYBQoAkSV4VTBnJzJsAzhLWOvwZMNUX233fw7j59xb3EVTQbTyRxby/GvQTKDJYiLPsNGYfo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786121275; c=relaxed/simple;
	bh=ep9ho8XulT5FUI5xmXu/uj+F9yRCkORGoMWnJhDrahM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=kdr9j8YZvFNM3KfLmmrGw6S3KT4SjKSmVXtVdwRorqfux/XqOJgC5LLW1TJOy+OFInO7kxb6ELUvpTMziNIoP0DTlbKDPccB4XRhh/ggk0lYsO9gq7Irxu67/qCflB0xlkfBuwhUav9TGh40DDY0RW1cI6160yDlYPJwZxAtMdI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=GmYXcRAg; arc=pass smtp.client-ip=209.85.167.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="GmYXcRAg"
Received: by mail-oi1-f169.google.com with SMTP id 5614622812f47-49fa951b2c6so2094862b6e.1
        for <git@vger.kernel.org>; Fri, 07 Aug 2026 09:47:53 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1786121273; cv=none;
        d=google.com; s=arc-20260327;
        b=VBAe148p2ozIUiCwFu1RiWfO8nYV8ZGNcVs0Ps4fQ3Ed3CSe0CbPsYSENBSSOaHRnU
         075VupU9pdzfogeK9sIJQtD2DlamodnzxQAWcGXNfGpHJWeI6eBfAgrzR+xJfIGlSnhp
         GFiGA1QNRDK4UMSaNc7/qOR+xKn6ty7e3wyC/rhFdZYhqoS29BbOdJNn4hSNlazvtDtm
         32Iawmr4mO7hoC+l5j6YzsEnR6S9J5JZsn31TNTweMmheZaToRZWWsADjw4XIS+5BAZo
         XNvVt0flZ5/dhw3BzQdMDl6GXXqumSlfssa2ehZIqk8ZP+VPezQLNl7VNnNfFLKRTYQU
         JQ2A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=Fv1XmGC7EL0xj8PgGFqMtix4bUlmneOEMSu6vYB2zY0=;
        fh=DK8LL3LH6ReOJZFKig2hEX6PR8Guoq8wfLCZxzPRT0g=;
        b=H1dosyoP3LeF/ZXpkQkjX5WCrde6XucYUjQFl2hi2KR1O01i9MwaK2M8TNdtYX0e6S
         o017xniPcjRemtg14eruhRkPl8kJDpeaS86gmmqMmOhS2RK8ajpN06r9b2HNKadHxNVV
         q28iYL7CbYR6pRkqoB1MWN1iQelwVg86yG7z4J/hKKOl0ppEYK13anl7bHJFQO5S0Lrb
         0GlS1nmcF/Qa07vq5zGlunOIihqlJcs4aMSdXBcZG4Pe4O6j7R4t6tKAya+B1WaIGpoz
         CwDsSHJYKd8Kg6djD7d3BSjmxbOqKZt84XfVqrYlxMYpvtEWExC7ilZv4N0/opWx1VpM
         8RPA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1786121273; x=1786726073; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=Fv1XmGC7EL0xj8PgGFqMtix4bUlmneOEMSu6vYB2zY0=;
        b=GmYXcRAgAZoODL8ygIbWMIL2o/z6d7EkYq+T6dsQAwL5niME4zLjHouoQLd82hwmMo
         054nx9Fsxt+1gtw2DXNmFyCWfuWa7V6JqeOaAaIqbwtjQtnPT4ZyuDKtza5RuK9u89uI
         NbR+tH5o0WSF6iMELKr0jwPo7q59xCLKVVeKY6U9GCgvuQYsUJaohotWOvWIew8hU0D8
         gHUenObu191ju4wleMykr1D1iryiBCxHeLg+2587CJrV4aWM1YyqhRPVC/1YQDgebdNz
         N2yh+U0ZNQfVnWcNuCof1J5ParYeqM895HPM9ftkgg6DgR5UScapywHpMJ0YitIy2aTY
         uPEA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786121273; x=1786726073;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=Fv1XmGC7EL0xj8PgGFqMtix4bUlmneOEMSu6vYB2zY0=;
        b=hFVjNxX6bY+khkBDYvLlcCDSIN2x2a0yFdurcAo7gdxOHByTjHVL5FmSEeMn86XdQ0
         BqH2kS8anNwxQGGfNmk9BDJOmYxNHXOm5YojFhb3YU0iOVbNjDBdCphCLaoK+wveMhNG
         GeKiunZBEKSLvxj0c3HnHVfz1ohJZ7eSz3lEJK6zdOKtPeJ6w4G6GYpSzErQzZCPny+c
         DcwjS/tAIoVHgUf4TAzPYHHOEH4C7jcLAdgnkFe8ua23kCWWThw69PH9PdmJrCZmFNyT
         n5VytO0o+OkWzqdwwHmUEUrGUIYzyvzco8OL+xNFV+XeiO8W1bTo7/Na6aofMFcm5JEn
         GiqA==
X-Gm-Message-State: AOJu0YzGBqU9O1Jngurc0VaZo8BWTpjWfCLn76PfENNmNKuZSFeYGeei
	YSbdfJ9cs/8maRxxX/ryUsF8Zxnv5zVawBIIFUTIoAOhEfpvA4OffeULCTMscDzuoBJ56VRcQ4F
	fBoJ16dbZ796tgaxc9WmeT4wqnojdV/g=
X-Gm-Gg: AR+sD12RUv7B8qIjTbhjNiZC4skqaIu+V0hnv3aCP4P68gEYOIcXTurTeRiSkQj270H
	Oc93TFm86/VHlva8wtv0RG0P4Tsdf+iTMYwNXNT2bDE6kyMVjANPt6EskKX0NPs3kmpbVZe5D36
	DooZsObzlZ0qsg4MCOuxANOlppPKs/aVueZXxgbAwuWQqHAtpOSgjiLxiCKVVu1OFrYvspjqLrn
	ggvY9V4/s/hXIAgWpgCOnR8psYpFJoTgN1h2CCE2tTNCACe/PpyWayhC+V0xOfP/FIDj/iKWy9y
	kIxMNaxnJfwilo+GX08WfWHtsm4+PkSqqwvRZfz/tTAj61ocwykGhROm3zTmib1JHhJ1iZly74F
	LbcWaSbRmIYFJ6zSr32nwaVzhYseOmHBypCix+zc3mWTPnOZnY4dI+7JcSri7+K4=
X-Received: by 2002:a05:6808:3509:b0:497:8ca:a8fc with SMTP id
 5614622812f47-4b1ab9fa564mr796896b6e.19.1786121272822; Fri, 07 Aug 2026
 09:47:52 -0700 (PDT)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260726083254.GA3528497@coredump.intra.peff.net> <20260726083905.GB3529069@coredump.intra.peff.net>
In-Reply-To: <20260726083905.GB3529069@coredump.intra.peff.net>
From: Elijah Newren <newren@gmail.com>
Date: Fri, 7 Aug 2026 09:47:41 -0700
X-Gm-Features: AUfX_mwpByPuvlhlu-JUZ4eoGhYbDp1djGojVNUhbG9nF_C5Ic1rhmM3vUQaF0k
Message-ID: <CABPp-BEURtn+yh_m=DX1dUe5CY5mzpdmzpqOeZdOQ14sKw43FQ@mail.gmail.com>
Subject: Re: [PATCH 2/2] ci: bump ubuntu image version for static-analysis job
To: Jeff King <peff@peff.net>
Cc: git@vger.kernel.org, tnyman@openai.com, Taylor Blau <me@ttaylorr.com>, 
	Junio C Hamano <gitster@pobox.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sun, Jul 26, 2026 at 1:39=E2=80=AFAM Jeff King <peff@peff.net> wrote:
>
> We recently ran into a case[1] where old versions of coccinelle ran very
> slowly, but newer ones are fine. The version we use in GitHub's CI was
> the old slow version, leading to timeouts of the static-analysis job.
>
> We get the old version because we ask for the ubuntu-22.04 image. That
> has coccinelle 1.1.1, but the "fast" improvement is in coccinelle 1.3.0,
> specifically their 58619b8fe (break up envs for e1 & e2, 2024-08-18).
>
> Bumping to ubuntu-25.10 would be enough to get that new version. But I
> don't see any need to ask for a specific version at all. We originally
> used a specific version because coccinelle wasn't available in ubuntu
> 20.04, so we pinned to 18.04 in d051ed77ee (.github/workflows/main.yml:
> run static-analysis on bionic, 2021-02-08). Later that got bumped in
> ef46584831 (ci: update 'static-analysis' to Ubuntu 22.04, 2022-08-23)
> when 18.04 support was dropped.
>
> It seems like the absence of coccinelle was a blip in 20.04, and we can
> just stick with "latest" going forward.
>
> I tested the result on GitHub's CI. I bumped the matching line in the
> GitLab definition, but didn't have a simple means of testing (but it's
> such a trivial change nothing could go wrong, right?).
>
> [1] https://lore.kernel.org/git/20260724091152.27794-2-tnyman@openai.com/
>
> Signed-off-by: Jeff King <peff@peff.net>
> ---
>  .github/workflows/main.yml | 4 ++--
>  .gitlab-ci.yml             | 2 +-
>  2 files changed, 3 insertions(+), 3 deletions(-)
>
> diff --git a/.github/workflows/main.yml b/.github/workflows/main.yml
> index 85cfedf5b0..205325eb33 100644
> --- a/.github/workflows/main.yml
> +++ b/.github/workflows/main.yml
> @@ -460,8 +460,8 @@ jobs:
>      if: needs.ci-config.outputs.enabled =3D=3D 'yes'
>      env:
>        jobname: StaticAnalysis
> -      CI_JOB_IMAGE: ubuntu-22.04
> -    runs-on: ubuntu-22.04
> +      CI_JOB_IMAGE: ubuntu-latest
> +    runs-on: ubuntu-latest
>      concurrency:
>        group: static-analysis-${{ github.ref }}
>        cancel-in-progress: ${{ needs.ci-config.outputs.skip_concurrent =
=3D=3D 'yes' }}
> diff --git a/.gitlab-ci.yml b/.gitlab-ci.yml
> index 1c4d04da9d..0242283c3c 100644
> --- a/.gitlab-ci.yml
> +++ b/.gitlab-ci.yml
> @@ -227,7 +227,7 @@ test:fuzz-smoke-tests:
>      - ./ci/run-build-and-minimal-fuzzers.sh
>
>  static-analysis:
> -  image: ubuntu:22.04
> +  image: ubuntu:latest
>    stage: analyze
>    needs: [ ]
>    variables:
> --
> 2.55.0.742.gf2bff09aa6

Makes sense to me; looks good.
