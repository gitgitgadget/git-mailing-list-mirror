Received: from mail-qv1-f54.google.com (mail-qv1-f54.google.com [209.85.219.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C8E6213A3ED
	for <git@vger.kernel.org>; Fri,  1 Aug 2025 21:21:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754083315; cv=none; b=sun9xGLd7ouHVseC6g7bjDIoOUUnPKSwsnTy4ekzIbjjTSrRLCh6KeYGH5WKimbuTeBo2wZMqyF81Bz3R2w6aCsZTZPShcRxzfl6KDPcuRYsxcq2g4PwB5TQ9+H+AjLrujg3z5tfrwARwlRu10Y6eWNOv7RRSqk6HodkMqZSE4U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754083315; c=relaxed/simple;
	bh=xFC7V1EX1Jz2MDXuAx6dHAEMQC1yIfCeuZnc+xV14cA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=K+GLq6cX+vaX+wZrsZAm8/lwbk3S68dBzY6s9xNg3V7geBRE2cbcznHeJ28/Z2KL6yPH3QqYGhN/V8sPBB+UxjBvrxxf7ZwEPZwzjhAJEj0JVpEK6xZqxfFMuEvVPu5O43QSf53yIM2yM5AuXwrkD81JuzE7woClUJWYcOwjRE0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=sunshineco.com; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.219.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=sunshineco.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qv1-f54.google.com with SMTP id 6a1803df08f44-70742520205so5207056d6.2
        for <git@vger.kernel.org>; Fri, 01 Aug 2025 14:21:53 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754083313; x=1754688113;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=QfxpeEZ7BZlVo4/Doq6906w59faYEp0b5NLxpenpcyw=;
        b=PgJQTD73EV6D6AEmCfS4XJ8DRm6y0ajDg/3g/4EIF7cdZq7q1mvpTTOnWO6Eun/oUz
         5TW0FqjEYOLBG4Yp0bMyBCFRwsV5DfmOnSwGFuiuKPuNyh7yp59hSSKFVgTeqd8bJ83G
         3DSvbPJdEdF0BZ7g2hsLRxR4UfK5SphsjfVXaK8ODYoR212DRw9NOXeOqNEZclOZRs5J
         DGeXQGXrzRpJ1jynMzprOjVNRBrzOPjao5UT6/wUTpPvDSTzr+EqgNYcfDvVYnslD4jk
         Oz3CJAoT1W+nY9qoV7I8dAglPTAElLhbVtrwN1WyNN/4s4hwas1BSqc86+HHhYENMVes
         SGQg==
X-Gm-Message-State: AOJu0YxNZwUOGNUn9+RTrr3gNF231mfF1yPH6q/jdRtJGFUVqsAzn39G
	SeC53fhl5cQHcFNv9Hj24gdZM+QzA2EbRUiLkzmbPO1LsKNzdBADhYKEZFspeiVjxl4dACQ3Qjx
	5QgcE/dQNO7Rk+FRgG/50Aud+SLHj3Qw=
X-Gm-Gg: ASbGncuqk9a5bwzQqtH6O1OF7qXek/FGx3+yPpNB8EjMGEyhVsgGtx7sbXLyviMT4Xk
	xJLd7NBN3HKPiPU25XchzYxfUDscjiDtq0Bbz6n1RYg9Wc1iRNmZerHKt5PFfve1g9yn5bQBrg1
	Inp5Tn8ZVhMC9Kg1Y1o3FyPna597QOUVEOsfCvgfTcEtsrOGOSHsTVPEgtsER0v+UbmvWIC6dwN
	rwhdCT4W+CT7TIzIu4PTkdbFw/sG7ZpMip5OJfmQRQJwoSFfy0=
X-Google-Smtp-Source: AGHT+IHlfybO1DkaF5eg1+a+Jqku4a9G/GIsEOhuVB3fTbLWUX3mJNj3yZ8FWUFOXGrNtNvEgDCa5QO4FhvS0xQyH4I=
X-Received: by 2002:a05:622a:d0:b0:4a9:b181:cdd1 with SMTP id
 d75a77b69052e-4af108f0759mr12246991cf.1.1754083312483; Fri, 01 Aug 2025
 14:21:52 -0700 (PDT)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250610152117.14826-1-lucasseikioshiro@gmail.com>
 <20250801131111.8115-1-lucasseikioshiro@gmail.com> <20250801131111.8115-4-lucasseikioshiro@gmail.com>
In-Reply-To: <20250801131111.8115-4-lucasseikioshiro@gmail.com>
From: Eric Sunshine <sunshine@sunshineco.com>
Date: Fri, 1 Aug 2025 17:21:41 -0400
X-Gm-Features: Ac12FXwB0tlyXyu42UsLqQRHnKTSvOP82hnAzV-LKDZxiy_91a8dPix4ptIdwe0
Message-ID: <CAPig+cR=vRu7GwGx_wpS_GZNdX7giosDK12K+qQdOW1va-6oWw@mail.gmail.com>
Subject: Re: [GSoC PATCH v7 3/5] repo: add the field layout.bare
To: Lucas Seiki Oshiro <lucasseikioshiro@gmail.com>
Cc: git@vger.kernel.org, oswald.buddenhagen@gmx.de, ps@pks.im, 
	karthik.188@gmail.com, ben.knoble@gmail.com, gitster@pobox.com, 
	phillip.wood@dunelm.org.uk, jltobler@gmail.com, jn.avila@free.fr
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Aug 1, 2025 at 9:11=E2=80=AFAM Lucas Seiki Oshiro
<lucasseikioshiro@gmail.com> wrote:
> This commit is part of the series that introduces the new subcommand
> git-repo-info.
>
> The flag --is-bare-repository from git-rev-parse is used for retrieving
> whether the current repository is bare. This way, it is used for
> querying repository metadata, fitting in the purpose of git-repo-info.
>
> Then, add a new field layout.bare to the git-repo-info subcommand
> containing that information.
>
> Signed-off-by: Lucas Seiki Oshiro <lucasseikioshiro@gmail.com>
> ---
> diff --git a/builtin/repo.c b/builtin/repo.c
> @@ -16,6 +19,13 @@ struct field {
> +static int get_layout_bare(struct repository *repo UNUSED, struct strbuf=
 *buf)
> +{
> +       strbuf_addstr(buf,
> +                     is_bare_repository() ? "true" : "false");
> +       return 0;
> +}

Nit: You can drop the unnecessary line wrapping:

    strbuf_addstr(buf, is_bare_repository() ? "true" : "false");

But don't re-roll just for this.

> diff --git a/t/t1900-repo.sh b/t/t1900-repo.sh
> @@ -35,6 +35,12 @@ test_repo_info 'ref format files is retrieved correctl=
y' '
> +test_repo_info 'bare repository =3D false is retrieved correctly' '
> +       git init' 'bare' 'layout.bare' 'false'
> +
> +test_repo_info 'bare repository =3D true is retrieved correctly' '
> +       git init --bare' 'nonbare' 'layout.bare' 'true'

The quote placement used in these calls to `test_repo_info` is quite
unusual and more than a little confusing. I'm guessing you did it this
way to avoid having to use a backslash to continue the line or did it
to mimic how `test_expect/fail` is called, but it makes the function
call more difficult to understand than it ought to be. Instead, call
the function in the more traditional way:

    test_repo_info 'bare repository =3D true is retrieved correctly' \
        'git init --bare' 'nonbare' 'layout.bare' 'true'

This comment applies to the previous patch, as well, but I didn't
notice the issue when reviewing that patch.

> @@ -54,4 +60,12 @@ test_expect_success 'only one value is returned if the=
 same key is requested twi
> +test_expect_success 'output is returned correctly when two keys are requ=
ested' '
> +       cat >expect <<-\EOF &&
> +       layout.bare=3Dfalse
> +       references.format=3Dfiles
> +       EOF
> +       git init --ref-format=3Dfiles two-keys &&
> +       git -C two-keys repo info layout.bare references.format
> +'

It's good to see use of the heredoc as suggested in the previous
review, but isn't this test missing something important? Namely, it's
never comparing the actual output to the expected output; in fact,
it's never even capturing the actual output.
