Received: from mail-qk1-f182.google.com (mail-qk1-f182.google.com [209.85.222.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E163716F265
	for <git@vger.kernel.org>; Sun, 26 Oct 2025 23:53:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761522834; cv=none; b=HDr1mDa8We0DhwIqjZN9XlR0d847SRulUSFWJCtb3EWjdHRgAS3UmSSDEkJDd4Fin1IjrkpLnwMc3iPEiiVq3jwVNQ2bEEyvmmyY3lCTY3qNYYxL7GZXCjqYP3IRWBM+sKCR1N492v84W8VUwWVy//fIfE2fvq5BcCUDZ8bNqbw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761522834; c=relaxed/simple;
	bh=isM9tWZQ9U5aGibBBZRwPMxUN3sEWiaaBTj72XO8Ylk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=l4SShyIlrslHRvXiqFHRTvkkYgH+5YFEoUpYOVJrBnS41fSDLzRMn4cu8ICTBWTbY1G2UYwuUlKoBz8zrV44CYpMvH2pUYeeYpFdAlYyxRk6SuRAUI/MgZsXaTGqQXZxLdm5e17Jbd8+StKsGM1V55KdujBc9ceIHcZNzApP/RU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=sunshineco.com; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.222.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=sunshineco.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qk1-f182.google.com with SMTP id af79cd13be357-89f49ccab1fso45458785a.3
        for <git@vger.kernel.org>; Sun, 26 Oct 2025 16:53:50 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761522829; x=1762127629;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=eRfRrbYsht3a239jIQrBoP6XgW5DRNh7A7yNDrhbkyc=;
        b=AVdFPt/mXTXcqHICpV3tuInRRJFZ8HNrjQ4prNL8wz2oeWAeILklWGq6Q5kM+LtyRa
         W8bHOp+DMRPR0JQYksBWDnB4eqmVRPhAkR41Z2YQcB7strdmZijdi7waFC7H3Og3njWx
         sqE9KlelDy3tXfJ1nobRupTZ6H6NHmxEqpYW2FG3OjUK2DxE5Bf99yvrauug6OWAaEjq
         qmNnrlnMXGuJAiF8PEoyH4I9rxFJhG8KH5BYFDBqbR/qTDHXAGKQAbU821DFvPCJLHoR
         sPicU1d7hMOEW76NpSRM6vvBE7sb8ik3mSbBzjkfikcGB0e5HZ/TzaZ1Ct1UL0sVBBbb
         VQ/A==
X-Gm-Message-State: AOJu0YzRDDzlj4hPhfHMWCik0/8ja/3vQjOe4kpEiM1282MdA6lJJ9CP
	FyMZoWt8PAEBjE9jWbNgQkEVjVCIRodOtm0dvU4ReHDAlxGW4bNG4uoEsCjsLorTHu7VehoB7mX
	zJvmT0+Ld6IOcF2o767jgZhszTNN1jWk=
X-Gm-Gg: ASbGncvfzxD1EwGG93uM9NZqZCmybIAXQYJvcX8i/1VHKtWKhBrxcInejWCoqFA1e/3
	Mx4Fh/vr0jaSwzzvyGQotDEsS3x1844pCndfK6XnjTSKbLCxMh1eWfma6HfdQ/tPY13IAFY6Y8k
	NwPbeODSdJUiGlpl4eySIMlR3xndBKBmF3koMQ40lpXL+DM1suqzaqYQXNcbU4ynU1lfq0Gqa7X
	JrsVUU5I1GrPa4AME3ZDNTv1zrFlyJ/iJL3I/ufWlYGQP5l2tUFCmHobK5ZCLw+2ylYnbNFORXl
	BTRAfqDJOgZlx9Rtsj1/fFcyYtIG
X-Google-Smtp-Source: AGHT+IEsIWAj7u3bn2HFAX6pF9SI2SQdQcWufM38jOV0tSU3UshmG3vZlcSy11Obrr5JFpjvYxFie4fLAC4qOeH+2UU=
X-Received: by 2002:ad4:5c4b:0:b0:87c:cec:70c8 with SMTP id
 6a1803df08f44-87c2068e2f2mr297465196d6.7.1761522829388; Sun, 26 Oct 2025
 16:53:49 -0700 (PDT)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250915223618.13093-1-lucasseikioshiro@gmail.com>
 <20251026225409.46647-1-lucasseikioshiro@gmail.com> <20251026225409.46647-2-lucasseikioshiro@gmail.com>
In-Reply-To: <20251026225409.46647-2-lucasseikioshiro@gmail.com>
From: Eric Sunshine <sunshine@sunshineco.com>
Date: Sun, 26 Oct 2025 19:53:38 -0400
X-Gm-Features: AWmQ_bmQWTcqkpHP0oAn0PIKH7soPoK42qIA_4MY2KHscnH3YypNBa06a3lAgUQ
Message-ID: <CAPig+cQO4_T8K-8wFBDQN-n+rasBF7LR+vJ6ez8swfmDz1ossg@mail.gmail.com>
Subject: Re: [PATCH v3 1/2] repo: factor out field printing to dedicated function
To: Lucas Seiki Oshiro <lucasseikioshiro@gmail.com>
Cc: git@vger.kernel.org, ps@pks.im, karthik.188@gmail.com, gitster@pobox.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sun, Oct 26, 2025 at 6:54=E2=80=AFPM Lucas Seiki Oshiro
<lucasseikioshiro@gmail.com> wrote:
> Move the field printing in git-repo-info to a new function called
> `print_field`, allowing it to be called by functions other than
> `print_fields`.
>
> Signed-off-by: Lucas Seiki Oshiro <lucasseikioshiro@gmail.com>
> ---
> diff --git a/builtin/repo.c b/builtin/repo.c
> @@ -77,6 +77,24 @@ static get_value_fn *get_value_fn_for_key(const char *=
key)
> +static void print_field(enum output_format format, const char *key,
> +                       struct strbuf *valbuf, struct strbuf *quotbuf)
> +{

Let's not pass in 'valbuf' as a 'struct strbuf *' since doing so gives
the false impression that this function will be modifying the strbuf
(which it does not do). Instead, pass in the narrower `const char
*value` which indicates clearly that this function will not be
modifying the value.

> +       strbuf_reset(quotbuf);
> +
> +       switch (format) {
> +       case FORMAT_KEYVALUE:
> +               quote_c_style(valbuf->buf, quotbuf, NULL, 0);
> +               printf("%s=3D%s\n", key, quotbuf->buf);
> +               break;
> +       case FORMAT_NUL_TERMINATED:
> +               printf("%s\n%s%c", key, valbuf->buf, '\0');
> +               break;
> +       default:
> +               BUG("not a valid output format: %d", format);
> +       }
> +}

Moreover, I'd also say that since this is not on a critical path, you
should avoid the premature optimization of passing in `strfbuf
*quotebuf` and instead make `quotebuf` local to this function.

    static void print_field(enum output_format format,
        const char *key, const char *value)
    {
        struct strbuf quotbuf =3D STRBUF_INIT;
        ...stuff...
        strbuf_release(&quotbuf);
    }

>  static int print_fields(int argc, const char **argv,
>                         struct repository *repo,
>                         enum output_format format)
> @@ -97,21 +115,8 @@ static int print_fields(int argc, const char **argv,
>                 }
>
>                 strbuf_reset(&valbuf);
> -               strbuf_reset(&quotbuf);
> -
>                 get_value(repo, &valbuf);
> -
> -               switch (format) {
> -               case FORMAT_KEYVALUE:
> -                       quote_c_style(valbuf.buf, &quotbuf, NULL, 0);
> -                       printf("%s=3D%s\n", key, quotbuf.buf);
> -                       break;
> -               case FORMAT_NUL_TERMINATED:
> -                       printf("%s\n%s%c", key, valbuf.buf, '\0');
> -                       break;
> -               default:
> -                       BUG("not a valid output format: %d", format);
> -               }
> +               print_field(format, key, &valbuf, &quotbuf);
>         }
>
>         strbuf_release(&valbuf);
