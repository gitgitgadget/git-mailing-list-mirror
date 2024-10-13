Received: from mail-yb1-f176.google.com (mail-yb1-f176.google.com [209.85.219.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 10A542F5E
	for <git@vger.kernel.org>; Sun, 13 Oct 2024 22:50:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728859827; cv=none; b=g+7MYeu5Ew2Hfe6lRHdyBZHFCzNZgzGlu2u5IiGc6QbhlAVzhlBaUO1UN6oe0P0wtmfojZXmrsmDGmdUt2R1ob00cC/E58AFT5n+EXn2oFei8b/gE/GUpo0gVEepYfW5x4cqOmeyADppcaUqNd1hZh9RbEelwJ5ORKxwENCYh9Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728859827; c=relaxed/simple;
	bh=gejX25Eo/iJC586ej972+j2TJvHTLHCFQhA0NyeOLjA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=hiNOEcEsjEahLyvieLzQxKZojFhoQnH54MrmuyQpoVVeDC81CnONFiQWECpX7B0ENO7HyWDBcLCoKmkqobXlPtrT5l/Nf/BE3bwiJGjGVDIn2bOYcuzE4znIe3EW+WmqWkP01sCzHnAF/Ka3sFuBN21QC81//oK/atgL2fmSxDU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=mit.edu; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.219.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=mit.edu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yb1-f176.google.com with SMTP id 3f1490d57ef6-e2908e8d45eso3029584276.2
        for <git@vger.kernel.org>; Sun, 13 Oct 2024 15:50:25 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728859825; x=1729464625;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=0qq8ZX+JGe4TPoHxR4fsS6mAUGV5Zxiz5dcKOedNZKs=;
        b=B7Z8z3ZHWKTbTiXc2EvOQI/d40hAlcuYLFkE4X4RIBWcKo0yxD92cn1VfGDHhzSP1a
         yU96hv36eF4OkjFzwG8o0C3gTQMDBSv6fB77aMXIrfEymEK5K5+4l4eSJT2GsUEbqrgg
         cZZaxrmbRcaqHmREfIxecNKjKO4Oj/PcVpo2hxnu/8oasi0wHTDSgQzUn8Bi2ut8GkhG
         q1Wwzwt15ZwdA6ortutXsozdtudeBawq6Rf2vm8hrna/uI7OX1K2EXFpSL5AeYFcqKDK
         5BuOCVdQwjqdgkTJByJ5b/b3Myap0dU/3FG/d/ZXJsj1dts9Al32CByVv1xdog25r3w2
         Qe0A==
X-Gm-Message-State: AOJu0Yys8d/VQi6ymZruuCgeZNXuGjtkIqfmXBLBGdNPAaMFpMwKJpvz
	se8TGHUq1BRJ2TgXWS7Ph3TUjMZtmMK9a8FdmTB37B10k+j6iCqBA462o0r9DLvdG7b6Av4qYEG
	0ds7fgU18pnqzfNqVPr9CgwMpwlw=
X-Google-Smtp-Source: AGHT+IEHSn5CBWhg54pVr0vSq9i+8pyIUurNXbwbg+elndrC4V5I1dVGnxwzAfZDijyUWbT9VBv6X/vR9Z3esI031LI=
X-Received: by 2002:a05:6902:705:b0:e24:a0da:f89c with SMTP id
 3f1490d57ef6-e2919da2719mr7035268276.30.1728859824775; Sun, 13 Oct 2024
 15:50:24 -0700 (PDT)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CAOO-Oz3KsyeSjxbRpU-SdPgU5K+mPDcntT6Y4s46Mg_0ko9e_w@mail.gmail.com>
 <ZwoxHYD-e4qo7OyW@pks.im> <CAOO-Oz0+sOpF6YQHSu0ytCO5TL+Anpr1k_9vQx6hebr624WjMA@mail.gmail.com>
 <ZwwmFtF1Y30y8eoU@pks.im>
In-Reply-To: <ZwwmFtF1Y30y8eoU@pks.im>
From: =?UTF-8?Q?Alejandro_R=2E_Sede=C3=B1o?= <asedeno@mit.edu>
Date: Sun, 13 Oct 2024 18:50:09 -0400
Message-ID: <CAOO-Oz2gN1Y9h-p_AJ=7iKzxOK2ShmgEmWzpFrpwwAD2GH=6TQ@mail.gmail.com>
Subject: Re: git no longer builds on SunOS 5.10, a report
To: Patrick Steinhardt <ps@pks.im>
Cc: Git List <git@vger.kernel.org>, Johannes Schindelin <Johannes.Schindelin@gmx.de>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sun, Oct 13, 2024 at 3:57=E2=80=AFPM Patrick Steinhardt <ps@pks.im> wrot=
e:
> diff --git a/t/unit-tests/clar/clar.c b/t/unit-tests/clar/clar.c
> index cef0f023c2..064ca5c2ea 100644
> --- a/t/unit-tests/clar/clar.c
> +++ b/t/unit-tests/clar/clar.c
> @@ -4,6 +4,10 @@
>   * This file is part of clar, distributed under the ISC license.
>   * For full terms see the included COPYING file.
>   */
> +
> +#define _DARWIN_C_SOURCE
> +#define _POSIX_C_SOURCE=3D200809L

token "=3D" is not valid in preprocessor expressions.

2008 postdates my available compiler by many years, so trying to define thi=
s
is not going to get you everything you might expect here.

Fixing the #define to use a space and not =3D results in

/usr/include/sys/feature_tests.h:332:2: #error "Compiler or options
invalid for pre-UNIX 03 X/Open applications and pre-2001 POSIX
applications"

The relevant bits of the header:

#if defined(_STDC_C99) && (defined(__XOPEN_OR_POSIX) && !defined(_XPG6))
#error "Compiler or options invalid for pre-UNIX 03 X/Open applications \
        and pre-2001 POSIX applications"
#elif !defined(_STDC_C99) && \
        (defined(__XOPEN_OR_POSIX) && defined(_XPG6))
#error "Compiler or options invalid; UNIX 03 and POSIX.1-2001 applications =
\
        require the use of c99"
#endif

Removing `#define _POSIX_C_SOURCE 200809L` results in successful compilatio=
n.

> +
>  #include <assert.h>
>  #include <setjmp.h>
>  #include <stdlib.h>
> @@ -271,9 +275,7 @@ static double clar_time_diff(clar_time *start, clar_t=
ime *end)
>
>  static void clar_time_now(clar_time *out)
>  {
> -       struct timezone tz;
> -
> -       gettimeofday(out, &tz);
> +       gettimeofday(out, NULL);
>  }
>
>  static double clar_time_diff(clar_time *start, clar_time *end)
> diff --git a/t/unit-tests/clar/clar/sandbox.h b/t/unit-tests/clar/clar/sa=
ndbox.h
> index e25057b7c4..b499d2e1e6 100644
> --- a/t/unit-tests/clar/clar/sandbox.h
> +++ b/t/unit-tests/clar/clar/sandbox.h
> @@ -122,7 +122,7 @@ static int build_sandbox_path(void)
>
>         if (mkdir(_clar_path, 0700) !=3D 0)
>                 return -1;
> -#elif defined(__TANDEM)
> +#elif defined(__sunos) || defined(__TANDEM)

I think we want __sun here, not __sunos.

>         if (mktemp(_clar_path) =3D=3D NULL)
>                 return -1;
>

-Alejandro
