Received: from mail-il1-f182.google.com (mail-il1-f182.google.com [209.85.166.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0E00925485E
	for <git@vger.kernel.org>; Mon, 12 May 2025 17:36:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747071397; cv=none; b=QLPv2gtfCte0wzcvzgqUtP/4+9ElgXgwyUne517IPqJXVWfrg0bHS50Wlf3v4R2gJn+0XLv5LpM5zNQ00X6yFmzZLNbVv8CPJG95NjDhVhQF3ygfJtComaOszzvaPPr/UvDg3lBiHHqSeddu2HKHkRFWxwyBk04nXcZlsP5AYtw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747071397; c=relaxed/simple;
	bh=7YJNW5y+2SD4f7/6eNzQ7/482PdW2Eftht41ydNgXyk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=IPlptFvB4zVqMM4WU9plX4JJtkIidTgFkPqnObt674ApxBzoDvazEJGY+hN71NnFXhzvzjAVlv/x5KPuljvSJxvbD0m+39sg6Pq6mOu+EQL+imuGmRl1n+ShoIavshQzW6EuvRoD1HzqRMhYjWDKAYEZ5buWIjU7yyaYX9V9eI8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=jKU/d94K; arc=none smtp.client-ip=209.85.166.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jKU/d94K"
Received: by mail-il1-f182.google.com with SMTP id e9e14a558f8ab-3da74959554so12513455ab.2
        for <git@vger.kernel.org>; Mon, 12 May 2025 10:36:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1747071395; x=1747676195; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=6uYHyiGKDbvT5T0XWLsyW7hcnfI2HPlDeyrQVH+5saY=;
        b=jKU/d94KOU/4CoGsobQ7bCOu3bgryZZ+B8EwldeffyWp+DtmnScVldGpW36XJe7onA
         sCAchZjBxN2+5RXCcBQc8jv7CgY0Gfb9De6avX9pOohhtQzDbO0bvktP7LROE7x7OuwE
         B+BjxLcvXaJ7MybduqSoRWtokunWDecVgWrspey6Ywp5MwaxyLxLwakAo7T+EF2ozF4J
         jGQrIaIERJAiRuQ02ocKQqnkSHJ/4tjWRu4t2EMifJM7/OrW/cWQGnmwRWuMV6hXS/ME
         oWmTrnrY+fNODDrFUxiIwYS3c+AKfnYG+3w49CyTFEbjBHojVDLjYGGUpja4DbPjQrlD
         MwgQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1747071395; x=1747676195;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=6uYHyiGKDbvT5T0XWLsyW7hcnfI2HPlDeyrQVH+5saY=;
        b=EDGShD8rMmC0TgMgeYYIi9jXizD17FC457d8KgR2+SJniiVIAjD4hFR4uL1V9hNT2C
         0klvGkOTxswDlm9598No5Tc1bw5/3LK/qCu1TCD2ZlRZHQGy+jCa29qum5GtQBAt7EqM
         q4nzbT1qKeGeWEFZ3vgxrh2fhT+wrWJ0ODtHX5UUwLU4da68e2FLYbhoVMDOOxvjmNxX
         3BcsgzVygy2OXanVH+TbbaUO9G3LTY8gFm9a6lB6ZppG+Go9AtFqrwyHAo7i/VcwzabU
         GJbi6yXJa5Wz3/uHrO/Sr9KUO5zpZaaBdv4NW3TBzWLkDn2uwOPH+UK8Awj3Ajbk3K26
         pqRA==
X-Gm-Message-State: AOJu0YxqqKB7Uhex280vcERr6vxaEck62997t16Auc43GyZVQ9HkB2tV
	/h1pFydpeEP45hCETLP0JKs4wu1q4Tv4mBjHTfR77HjfN7Zsiqq0SRKH/1JMI9gulDIHrCV2wl5
	qoX+z2/kgsw43nRuTACgFU0AVtobNqfSC
X-Gm-Gg: ASbGncvd2VB5iCp7wW8ekvcYrURN6xcVAI1ktZ3Wa1ekAn4FMqMZ6CREs76DnUgIvCG
	q59seI+FbeoIJd435U38cR52C28LMP51Mi5PQpf4mhkVZ+hoQSCgo0vs7fEC5LLbndq9oMiTi2Q
	hpwDmLeRwl3OgyHUsO8l0UvE1vxnSdH5HHYuWM9KiIAAJuTNzgc+rIDzq7QhQIDXZE9g==
X-Google-Smtp-Source: AGHT+IHgyUChPHpOa4e02r8N5ush7Miv2H5plvCizrUM4i9BR1HaEmw0CXX8eR2JUeY95FcnTi8JAv92gmMC5aUMWsY=
X-Received: by 2002:a05:6e02:1a06:b0:3d9:39ae:b23c with SMTP id
 e9e14a558f8ab-3da7e21751dmr170461805ab.20.1747071394836; Mon, 12 May 2025
 10:36:34 -0700 (PDT)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250501225958.2947677-1-gitster@pobox.com> <20250503005814.3030099-1-gitster@pobox.com>
 <20250503005814.3030099-3-gitster@pobox.com>
In-Reply-To: <20250503005814.3030099-3-gitster@pobox.com>
From: Elijah Newren <newren@gmail.com>
Date: Mon, 12 May 2025 10:36:23 -0700
X-Gm-Features: AX0GCFscUE3GGFbT1sX52QmkDzVvY55GEcf3bSM5sGNVAJDYeMs3Oz6EIvDPZ9s
Message-ID: <CABPp-BGXT5w8UxfnbELLFNvVQ1LTSj0oZVFi-XvCZ=0=NXUnEQ@mail.gmail.com>
Subject: Re: [PATCH v3 2/6] doc: prepare for a world without whatchanged
To: Junio C Hamano <gitster@pobox.com>
Cc: git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, May 2, 2025 at 5:58=E2=80=AFPM Junio C Hamano <gitster@pobox.com> w=
rote:
>
> These documents mention "whatchanged" as an example, that can be
> substituted by something else.

Perhaps:

These documents mention "whatchanged" as an example, which can be
substituted with something else.

?

>  A new hypothetical command "walken"
> would come near "whatchanged" but since the latter may be going
> away, we can say it would come near "version", as the fictitious
> command sorts between them.  Similarly, we do not have to use
> "whatchanged" as an example of a subcommand that is also implemented
> in builtin/log.c file; we can instead mention "show".
>
> Both of these changes allow us not to worry about adjusting these
> places when "whatchanged" is finally removed.

Could I suggest (now changing my previous suggestion to handle the
entire commit message):

doc: prepare for a world without whatchanged

Some documentation examples reference `whatchanged`, either as a
placeholder command or as an example of source structure.

To reduce the need for future edits when `whatchanged` is removed,
these references are replaced with alternatives:

- In `MyFirstObjectWalk.adoc`, we use `version` as the nearby anchor
  point for `walken`, instead of `whatchanged`.
- In `user-manual.adoc`, we now cite `show` instead of `whatchanged`
  as a command that coexists with `log` in builtin/log.c.

This avoids needing further cleanup when `whatchanged` is retired.

> Signed-off-by: Junio C Hamano <gitster@pobox.com>
> ---
>  Documentation/MyFirstObjectWalk.adoc | 4 ++--
>  Documentation/user-manual.adoc       | 2 +-
>  2 files changed, 3 insertions(+), 3 deletions(-)
>
> diff --git a/Documentation/MyFirstObjectWalk.adoc b/Documentation/MyFirst=
ObjectWalk.adoc
> index d6e9dfdbbe..102a465a48 100644
> --- a/Documentation/MyFirstObjectWalk.adoc
> +++ b/Documentation/MyFirstObjectWalk.adoc
> @@ -83,13 +83,13 @@ int cmd_walken(int argc, const char **argv, const cha=
r *prefix)
>  }
>  ----
>
> -Also add the relevant line in `builtin.h` near `cmd_whatchanged()`:
> +Also add the relevant line in `builtin.h` near `cmd_version()`:
>
>  ----
>  int cmd_walken(int argc, const char **argv, const char *prefix);
>  ----
>
> -Include the command in `git.c` in `commands[]` near the entry for `whatc=
hanged`,
> +Include the command in `git.c` in `commands[]` near the entry for `versi=
on`,
>  maintaining alphabetical ordering:
>
>  ----
> diff --git a/Documentation/user-manual.adoc b/Documentation/user-manual.a=
doc
> index d2b478ad23..7124345966 100644
> --- a/Documentation/user-manual.adoc
> +++ b/Documentation/user-manual.adoc
> @@ -4240,7 +4240,7 @@ command `git`.  The source side of a builtin is
>  - an entry in `BUILTIN_OBJECTS` in the `Makefile`.
>
>  Sometimes, more than one builtin is contained in one source file.  For
> -example, `cmd_whatchanged()` and `cmd_log()` both reside in `builtin/log=
.c`,
> +example, `cmd_show()` and `cmd_log()` both reside in `builtin/log.c`,
>  since they share quite a bit of code.  In that case, the commands which =
are
>  _not_ named like the `.c` file in which they live have to be listed in
>  `BUILT_INS` in the `Makefile`.
> --
> 2.49.0-601-ga5925c3955

Patch looks good.
