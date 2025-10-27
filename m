Received: from mail-qk1-f174.google.com (mail-qk1-f174.google.com [209.85.222.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B365C1EA7CB
	for <git@vger.kernel.org>; Mon, 27 Oct 2025 00:22:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761524559; cv=none; b=LQhy2rj0ZnSQ/+iMVNQEvFza2WpD54ETPCuKAYl3MvRwH9O31B/uRSe9pPnbXhGUi9f64mEfaaLI8VdCaFVnJTYBwT/GkYuCHTus47M1IXzvQ7FUmYhZjaM5basxugMm3gsSbOrAfLz84Uz3DbplJDkxAUzep1fyKB0H+9mVmbM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761524559; c=relaxed/simple;
	bh=qbSw78r7Gs4DKvll08wpZStbndwvzo7WRY5S7BDyW0k=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Z6hg+F+VwOZg9V4Cpl+ZZymmnVwnBn2WUUzT25jmoWTqZ2TFanc42bgnN9331YVa48J2x+YKQBSfBY1t+Lpcw76BUooAf1UBoUzyimaYHTDf2yewg7B7J/u4EYJFpo8HgdDnQhbHt8JYauGdDUy+CSl6RTu/VVFlMEDuglJbpiw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=sunshineco.com; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.222.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=sunshineco.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qk1-f174.google.com with SMTP id af79cd13be357-863762d794cso68118585a.2
        for <git@vger.kernel.org>; Sun, 26 Oct 2025 17:22:37 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761524557; x=1762129357;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=URpXbaAuE79ttGlQkCgT9oCN1x3IyBAK3xJsETgOs4Q=;
        b=jxe6KqVWcc6520xSD2cbrULKFFQXnsNM1TfOcUJv+F/TNsIY1yf9XWbfUmxJWRhxmq
         IMzIkzxdJFBdkTz80lLRGiXHTVVOsPQJJPUF++UpAUqXRdUa+5Us7A6WV/4pMZnkPZ2F
         RP/b16zYa31jrlf+hMB0dOVQ7mjmjDbYoPIkiksYddQNE6a6AQJ2LDa7sEmAegO8UE15
         ENycwaWipBM8/k3U2KhMiOCptENyWqV3ZYMVJND+smq9f48KpWfl8oJc/sQjWOZ1fABA
         lh6/F4Wn3Fv/jcQLBHffDbgUKS/gDd11iUWhKqvSGqRs19lbLzNwr8L28bfSESkRQUj7
         KoBA==
X-Gm-Message-State: AOJu0YxzjXos+yK7Rz09j+dW5Jq3uDum5/B+OSlJ9B6ILsoIGY2EjNN9
	tXiX1JhXUsiqD/7PSpPL4v9bjFpIjsoH4PBBRfendxb9rusIpdHVwrDGSvR2oy3zb6iz9m4a2Ny
	do7BKszDVX7ynWCSGs1t1o2H0b9N9CQI=
X-Gm-Gg: ASbGncuOphCHG1KSg4hIyzMMJESQQ3Abf3o1ZZ3ZYZ+9/u/AAmi312RenGt9C9CRR32
	cSrHOcfTKgHL60+ugxxV9BNFXv23KivzCJ0eWuoDR5ui13ENhKsHoKltBeUXKu5aoV6jhlfPog+
	HbArsAZ9zqGvqPtpAAuAfIjXf2SLqu8EDFwJRXL75J6/yZzfCrobTPj5p6B4XlIscTsKdhuhSTz
	cDudUcSqvkpljPNvZcCtWmOEGrCBHOIPB6Kj5I/67crflPjyKRpkFncSS//A3mynHyRwGvhi2ik
	ZzxReOqvbg370z/rrSo/eIrf42mW
X-Google-Smtp-Source: AGHT+IGrx5hmXE07MArpxraoK7ECg+7IKb08sHpAHKl8lSIWgaef3QaA6IKgb2vSfi/IYPjUU3xqW09Qm4sAnUHho78=
X-Received: by 2002:a05:6214:2a87:b0:87c:f64:7573 with SMTP id
 6a1803df08f44-87de713c3b7mr195771466d6.3.1761524556669; Sun, 26 Oct 2025
 17:22:36 -0700 (PDT)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250915223618.13093-1-lucasseikioshiro@gmail.com>
 <20251026225409.46647-1-lucasseikioshiro@gmail.com> <20251026225409.46647-3-lucasseikioshiro@gmail.com>
In-Reply-To: <20251026225409.46647-3-lucasseikioshiro@gmail.com>
From: Eric Sunshine <sunshine@sunshineco.com>
Date: Sun, 26 Oct 2025 20:22:25 -0400
X-Gm-Features: AWmQ_blLGYFWbX9GXuhrZ5dRPdeyPfOYniIDfX6CKF6UVtpiNX0Hvgqs-yrdOBU
Message-ID: <CAPig+cSOE1Du52Y8-s=b7HvKQyk-XHdGh3XzZR_tVktut9R1YA@mail.gmail.com>
Subject: Re: [PATCH v3 2/2] repo: add --all to git-repo-info
To: Lucas Seiki Oshiro <lucasseikioshiro@gmail.com>
Cc: git@vger.kernel.org, ps@pks.im, karthik.188@gmail.com, gitster@pobox.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sun, Oct 26, 2025 at 6:54=E2=80=AFPM Lucas Seiki Oshiro
<lucasseikioshiro@gmail.com> wrote:
> Add a new flag `--all` to git-repo-info for requesting values for all
> the available keys. By using this flag, the user can retrieve all the
> values instead of searching what are the desired keys for what they
> wants.
>
> Signed-off-by: Lucas Seiki Oshiro <lucasseikioshiro@gmail.com>
> ---
> diff --git a/Documentation/git-repo.adoc b/Documentation/git-repo.adoc
> @@ -18,13 +18,13 @@ THIS COMMAND IS EXPERIMENTAL. THE BEHAVIOR MAY CHANGE=
.
> +`info [--format=3D(keyvalue|nul)] [-z] [--all | <key>...]`::
>         Retrieve metadata-related information about the current repositor=
y. Only
>         the requested data will be returned based on their keys (see "INF=
O KEYS"
>         section below).
>  +
>  The values are returned in the same order in which their respective keys=
 were
> -requested.
> +requested. The `--all` flag requests the values for all the available ke=
ys.

I'm getting mixed signals from this patch. The documentation says that
it requests all *values*, but... (continued far below)

> diff --git a/builtin/repo.c b/builtin/repo.c
> @@ -124,6 +124,24 @@ static int print_fields(int argc, const char **argv,
> +static void print_all_fields(struct repository *repo,
> +                            enum output_format format)
> +{
> +       struct strbuf valbuf =3D STRBUF_INIT;
> +       struct strbuf quotbuf =3D STRBUF_INIT;
> +
> +       for (unsigned long i =3D 0; i < ARRAY_SIZE(repo_info_fields); i++=
) {
> +               struct field field =3D repo_info_fields[i];

Why do we need to make a copy of the field record? Can't we just use a
const pointer?

    struct field *field =3D &repo_info_fields[i];

or:

   struct field *field =3D repo_info_fields + i;

> +               strbuf_reset(&valbuf);
> +               field.get_value(repo, &valbuf);
> +               print_field(format, field.key, &valbuf, &quotbuf);
> +       }
> +
> +       strbuf_release(&valbuf);
> +       strbuf_release(&quotbuf);
> +}
> @@ -153,11 +172,20 @@ static int repo_info(int argc, const char **argv, c=
onst char *prefix,
> +               OPT_BOOL(0, "all", &all_keys, N_("return all keys")),

(continued from above) ...this gives the impression that it's only
returning *keys*, but not necessarily the values associated with those
keys. Also, "return" is a bit unusual in this context; perhaps say
"request all keys/values" or "print all keys/values" or something.

>                 OPT_END()
>         };
>
>         argc =3D parse_options(argc, argv, prefix, options, repo_usage, 0=
);
>
> +       if (all_keys) {
> +               if (argc)
> +                       die(_("--all and <key> cannot be used together"))=
;
> +
> +               print_all_fields(repo, format);
> +               return 0;
> +       }
> +
>         return print_fields(argc, argv, repo, format);
>  }
>
> diff --git a/t/t1900-repo.sh b/t/t1900-repo.sh
> @@ -4,6 +4,15 @@ test_description=3D'test git repo-info'
> +# git-repo-info keys. It must contain the same keys listed in the const
> +# repo_info_fields, in lexicographical order.
> +REPO_INFO_KEYS=3D'
> +       layout.bare
> +       layout.shallow
> +       object.format
> +       references.format
> +'

I'm not a fan of this since it is so brittle. However, I can't think
of a better alternative at the moment, and we can always revisit it
later if it becomes a maintenance burden.
