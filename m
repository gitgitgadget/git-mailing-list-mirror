Received: from mail-ot1-f46.google.com (mail-ot1-f46.google.com [209.85.210.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B5B7F1FA272
	for <git@vger.kernel.org>; Sun, 19 Apr 2026 01:26:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.210.46
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776561965; cv=pass; b=mzMYZOtITrG1KbKSyrDICQddn0NdWRrEawwTuCvtcJr5NSfCDYrw7jUlY+dE13t5tDs7bri/Iq6faqL3Cvg4VVIECmfvYMXaOzcpWn1yJJW3XHUv4Ha7bdo2Xf1j4flV4dOwndPXtci4YC6xIuDDrZB0/RPiJ4YaqNlbgrsmsJE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776561965; c=relaxed/simple;
	bh=PY5ztFBbHrMbIQ4m4Zz4dIQFyk8b7p2Ea03g9XWPupA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=XOEPZCYSOB8hdT8+uEi8IbfMeoyfRgUGoWlw8/B23zKSpIfePqjciUB8j9To94lWiZp5pPVOABbQGJJWR1Lp2lp5sPlrEBKRvl4GP1UMP6kZIG9s14t4c72GhrtG0HlW+Z1UV1K7LB7GF79n07NEeKV3ve6AxOjrTNEOYesoGkA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=jJyeDOMN; arc=pass smtp.client-ip=209.85.210.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jJyeDOMN"
Received: by mail-ot1-f46.google.com with SMTP id 46e09a7af769-7dbdcb85067so1789179a34.1
        for <git@vger.kernel.org>; Sat, 18 Apr 2026 18:26:03 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1776561963; cv=none;
        d=google.com; s=arc-20240605;
        b=Ajt/6bfPk2dU4kHNmJsOCfn+RshYJeN8P/V4FgcD0UuI1lP3SK4d/1zewUCcqiTrNd
         7Vomsq6j/hXPHOMo58bAuEK2BRjTSbLhvNQ8bK0Y94yETQkKMxVw/QyaTrf/dw5ekxYs
         VwHg7ZS6IgIxgeRSX7M55CmAyJ1ENv2Dja/YC3fsWhoVisR3aDij+67ShGjwZ5peqI0Q
         VxWZLSCf7i2Un4/Jb6RJeaj+MjNwPHrRR3+b5rozJpQ7r5QJ5logFbUxIjca25lDnuMy
         Cto4E7AurHRdfc490hkrcyxhgVB6hqUFykE4FbpIpxkfCN5hqc3DlcE3Xxd+DdyJu7KP
         8ASA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=19/WVCCM5SEU4cmWT+Wrp8BaVhOyqD1yjUedkgGvfAk=;
        fh=0ASywd76WohBCBaIDegnFFV1cK2SRQm/kn/1gdnBZWc=;
        b=CXU535rnjpYjEn/oS2YlmDeG2F8cUHCt3t/6DRkcYOctlALQ+FXh+o9SZ0emafP1w6
         XSe6H73xSA2LpKAZ4P3xa09U0cl1t8OHjp5Bdx6AXuK3gVHGAk+yD5wXj5l1UBvDHqz9
         jF+umGKABpLIXLAoKxklBjKvkbFW7P9kPg2pZrvUDx7OiQRVLzmKGQ8+DEcKhYKcNaNv
         hfQoGMc7tnS4X79UwInf413Nz2NVuhP06EbR5ch2E+vhAAD0BaDry3EMIpT04Uukd0Wy
         SoFbKrpxDJFwGmEvF8hglOz876yMKgUcxRXvh5k5/nLP7rlmukAzBQ5WyVtbRaGmBTwf
         XQOA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1776561963; x=1777166763; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=19/WVCCM5SEU4cmWT+Wrp8BaVhOyqD1yjUedkgGvfAk=;
        b=jJyeDOMNB8ri0pIJ2GgVDEGzSVJOaSAHnz8yfnwX59+jKmXuPUVzExrbXswwJMynNY
         l5uIXJppQRvcnyqiF9H1e3kY1cLQAc543d861mcVbr+5h7VvXraFC9EX0EJmpxA5VInF
         bNC+183Jh7B1J9YoEYvxeYp8Flmh0B3k0XfLWc4fXygIlvR57nZOu/TrdVteWZDvMNwu
         C7TV8qZUFZYEzaVA/IZgMzlVocT0jVxnDn+GYSDNafHosF16oFKx+X0STQbfQ+maB9Os
         D8S3LAgargjr3aTao98QSYlf7F3XSsEp7U8ekV3JhSgO8CLhlu+DVJnszESkGJ+jnlJi
         HdLQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776561963; x=1777166763;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=19/WVCCM5SEU4cmWT+Wrp8BaVhOyqD1yjUedkgGvfAk=;
        b=Hdrt20yjXAyNTloKWedWNZ03oG9mvRU26hOtVpgNM7ENJgktKLU8RvJJMpxmqdlxno
         Cg3vWdJWLY1gY0O/Hdmbp77/X4jgXghILC7p+GjcIitigQUS64OyaNGw8PfdR95T6KiK
         Yxuxv3hzRd4vhCJlUcgQgGueRw/+uyvjPuHZ7nBPoOzGfMlrBQyd6qA1frgQpOLNIH5C
         z/pDLtIa5wMNW5g8IpgrT2knnZ2S8tKMdamEuoCa4I3dWsePyGiIQAicBrQPl+/LUdbm
         urWNkLSiULImbaO4P26XPmPVyl1qqD1jYEdtRzwi+Br1CvC9jF2ewZUBlKdJruLI5F1k
         kuzA==
X-Gm-Message-State: AOJu0YzKFdCDKaE9lHjGNuAKlSPnLPZ+IbL6WFdFevyk2ZqyLBG8SqIB
	9L46XzHg71hJIvbZ6nUnFOZ91axjHPEuw2QIiH0+DyaZiYu2akTLraOOSzL8cLMHuJjaZODgbhK
	hEZm/bYJvyAQyKEMKrg8mTBKgJAqBn40=
X-Gm-Gg: AeBDiev7AiE1Q16UpsS2eVFubMHXxOCtYQWm4zKoxDT2P/eEVxSIPNXVQGLy/OFY8+w
	VrR4NPyMf/IFAMTk9TfmkwbE9hFaQXEKGjlJIg+G7C96wVbR8/mvv+essn9ah/uNoW8iziD7oPa
	Viqe9Op1zacly/uW1oeMt85R2aNhqYmUKVsoI+78XCsSCExHc9MfDhqoDKxQbFSGe4vAfDnbnCS
	W/UECxv/6lS9nBW4r/VKhy1Q+VeHCNT63SDEqgM4akm5g40Jl2s+dVOIt2RyBCPIKvwX4ylNFs7
	xbw/fY43srwMmQjl/1nY1jYmJtW70wwhyC+25aHcBHNpU9kd3eKwE8ZmsNfO4eXUpiUja5HxMB3
	ZyZEQadbId34CgWfehkLaTIaGeZN2E7U94ZGK
X-Received: by 2002:a05:6820:16a3:b0:680:3739:650 with SMTP id
 006d021491bc7-69462f5e249mr4596395eaf.60.1776561962660; Sat, 18 Apr 2026
 18:26:02 -0700 (PDT)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260418163236.2382826-1-szeder.dev@gmail.com>
In-Reply-To: <20260418163236.2382826-1-szeder.dev@gmail.com>
From: Elijah Newren <newren@gmail.com>
Date: Sat, 18 Apr 2026 18:26:00 -0700
X-Gm-Features: AQROBzBwe9f8fL-8VO6I6ZYduHb_yLL8yWJ-aPUjnn9q2e7vbRXFs8-DSj5dRFY
Message-ID: <CABPp-BGV4DGwoSDCjjW2NWBhWXNDfeXwb-tPWSH_13mF0DCiRg@mail.gmail.com>
Subject: Re: [PATCH] t6112: avoid tilde expansion
To: =?UTF-8?Q?SZEDER_G=C3=A1bor?= <szeder.dev@gmail.com>
Cc: git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sat, Apr 18, 2026 at 9:33=E2=80=AFAM SZEDER G=C3=A1bor <szeder.dev@gmail=
.com> wrote:
>
> e987df5fe6 (list-objects-filter: implement composite filters,
> 2019-06-27) introduced a test to "t6112-rev-list-filters-objects.sh"
> that checks the output of a Git command with the following commands:
>
>   grep ~$omitted_1 actual &&
>   grep ~$omitted_2 actual &&
>   grep ~$omitted_3 actual &&
>
> Since the leading tilde in the pattern is not quoted/escaped, it is
> subject to tilde expansion.  So if the system has a user whose
> username happens to be equal to the content of one of those
> "$omitted_*" variables, then "grep" would look for the user's home
> directory.  Luckily, those variables contain object hashes, so this is
> not very likely.
>
> Furthermore, Bash versions v5.0 and earlier seem to be buggy and don't
> handle this particular tilde expansion very well, and either segfault
> right away or, in case of v3.2, get stuck in an endless loop and
> segfault upon receiving ctrl-c.

Interesting find on the bash segfault behavior.

> Quote those words starting with a tilde to avoid these issues.
>
> Signed-off-by: SZEDER G=C3=A1bor <szeder.dev@gmail.com>
> ---
>  t/t6112-rev-list-filters-objects.sh | 6 +++---
>  1 file changed, 3 insertions(+), 3 deletions(-)
>
> diff --git a/t/t6112-rev-list-filters-objects.sh b/t/t6112-rev-list-filte=
rs-objects.sh
> index 39211ef989..e0a825bccf 100755
> --- a/t/t6112-rev-list-filters-objects.sh
> +++ b/t/t6112-rev-list-filters-objects.sh
> @@ -623,9 +623,9 @@ test_expect_success 'verify collecting omits in combi=
ned: filter' '
>         omitted_2=3D$(echo a     | git hash-object --stdin) &&
>         omitted_3=3D$(echo abcde | git hash-object --stdin) &&
>
> -       grep ~$omitted_1 actual &&
> -       grep ~$omitted_2 actual &&
> -       grep ~$omitted_3 actual &&
> +       grep "~$omitted_1" actual &&
> +       grep "~$omitted_2" actual &&
> +       grep "~$omitted_3" actual &&
>         test_line_count =3D 3 actual
>  '
>
> --
> 2.54.0.rc2.650.gc37764ecfc

Looks good to me.  I wasn't able to find any other unquoted ~$ uses in
the testsuite except mid-word (e.g. HEAD~$i), though I suspect your
version of bash seg-faulting is a better check than my grep-fu anyway.
