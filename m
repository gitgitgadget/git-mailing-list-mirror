Received: from mail-qv1-f50.google.com (mail-qv1-f50.google.com [209.85.219.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 881C210A01
	for <git@vger.kernel.org>; Wed, 13 Mar 2024 03:11:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710299481; cv=none; b=lAGK7ZrJg5GDdVto3iOv+bvvzrkKxjmTLxStP0rdwRf03m83o++BlBgjk+/DpLj59ggkDviXpM1IXVlPNlElTrx7qA9pjz2G1kUTUKJxOPMGjZ9SW6Yz0P4XfUO7otGRh+Ueh794xwM7uI9PEErfQBrAK49YC5612dt5VLajDBI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710299481; c=relaxed/simple;
	bh=N/hNC/DQ3cWLg8hGEHFecu4ET8ASjdVbA/AeVxov+ic=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=HRB2FlXGDJ9jtOHPRpza7R4F/P5M7BKhG/af4m8evW/7GIoPqIkdeTJ75FYc8ikSPDQUiaXwbQlc1Tyu9s40yjpn+kpcYBmkx1c9/Rk6bMFhJneOvAL7MuRKK2vaTS7kIQWSMCUhqsB8e4Zv1fOzjNJygNXesRQFM4zVuIfUkB8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sunshineco.com; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.219.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sunshineco.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qv1-f50.google.com with SMTP id 6a1803df08f44-690b24973beso3858156d6.0
        for <git@vger.kernel.org>; Tue, 12 Mar 2024 20:11:19 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1710299478; x=1710904278;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=9TYtqCvYVXKNdfyDZtvCS5KstIOMzIIbYleJeqY552I=;
        b=K0BbR5+D2EIYznxHmpNhmkGn+rzrpIpXATFor0pz6Gbszr5O0RMLShehDrkvyY3c7Q
         pwP1tniF0NM9nlALC/No1U91PEw/wc4ZwLpjawgjm0ipjDNOOqxguQQJvbr8AiK9RMp1
         +LhVGXyFLtBmQF4Z1LotTeIwwb/ndbbIqdDpZySGpR6rkPiBI7c7/gM2p8mDz0/ULTDm
         udQ/ZdMGXJWAdcpehWaOkAuQw3NIMHA70JN9Rm/M91Zh6j/8d782DyadRSmlYopqgOQ0
         94reyq2Qv8kgKiap5HmT1qiL7ThINIf/tKfCnujafvfOB7RJ3wY/Y63Aai0vt8rwt7xs
         gexg==
X-Gm-Message-State: AOJu0YzUi9DJoDGnEnMm95AjHGbiF+QEl6UmnoBK79tS5yuPXRrkZ1vt
	zdcR0oV9QyQpd0buYGNRqkR1Eg40rayEaJPxVe48Rql9+PRvQ95TSF/P6k1oe9JkoLxbWt+Zsky
	73RFOc8NRamdRoBNsDF28JM8rztU=
X-Google-Smtp-Source: AGHT+IFPsNvhXHRQ8c9K7z2gBaGALgL8vuXPIV80Ui9h1EWVHK2xDnwPPypNPMLzgPCscjY13DBOn0GgSYGZ6htPEXI=
X-Received: by 2002:a05:6214:c82:b0:690:e164:31e0 with SMTP id
 r2-20020a0562140c8200b00690e16431e0mr2781999qvr.25.1710299478458; Tue, 12 Mar
 2024 20:11:18 -0700 (PDT)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <cover.1709724089.git.ps@pks.im> <cover.1710198711.git.ps@pks.im> <8ceced0fc58e9b4cf1c5e5b678e864f82c1b8c01.1710198711.git.ps@pks.im>
In-Reply-To: <8ceced0fc58e9b4cf1c5e5b678e864f82c1b8c01.1710198711.git.ps@pks.im>
From: Eric Sunshine <sunshine@sunshineco.com>
Date: Tue, 12 Mar 2024 23:11:07 -0400
Message-ID: <CAPig+cRwh4HCi=Q01tGJ0WOb59iE18HWSCNxGogcreOz+2w1WA@mail.gmail.com>
Subject: Re: [PATCH v2 07/13] builtin/config: introduce "get" subcommand
To: Patrick Steinhardt <ps@pks.im>
Cc: git@vger.kernel.org, Kristoffer Haugsbakk <code@khaugsbakk.name>, 
	Taylor Blau <me@ttaylorr.com>, =?UTF-8?Q?Jean=2DNo=C3=ABl_AVILA?= <jn.avila@free.fr>, 
	Junio C Hamano <gitster@pobox.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Mar 11, 2024 at 7:20=E2=80=AFPM Patrick Steinhardt <ps@pks.im> wrot=
e:
> Introduce a new "get" subcommand to git-config(1). Please refer to
> preceding commits regarding the motivation behind this change.
>
> Signed-off-by: Patrick Steinhardt <ps@pks.im>
> ---
> diff --git a/Documentation/git-config.txt b/Documentation/git-config.txt
> @@ -80,6 +76,12 @@ COMMANDS
> +get::
> +       Get value for one or more config options. Values can be filtered =
by
> +       regexes and URLs.Returns error code 1 if the key was not found an=
d the
> +       last value if multiple key values were found. If `--all` is set, =
then
> +       all values will be shown.

s/URLs.Returns/URLs. Returns/

It's not a new problem with this description (since you're mostly just
relocating existing text), but I find the discussion of what is
returned quite confusing and difficult to interpret. Breaking it down
into simpler sentences might help:

    Emits the value of the specified key. If key is present
    multiple times in the configuration, emits the last
    value. If `--all` is specified, emits all values
    associated with key. Returns error code 1 if key
    is not present.

But, doing so may be outside the scope of this patch series and can be
tackled at a later date (or not at all).

> @@ -93,22 +95,16 @@ OPTIONS
> +--all::
> +       With "get", Return all values for a multi-valued key.

s/Return/return/
s/"get"/`get`/

> +---regexp::
> +       With "get", interpret the name as a regular expression. Regular
> +       expression matching is currently case-sensitive and done against =
a
> +       canonicalized version of the key in which section and variable na=
mes
> +       are lowercased, but subsection names are not.

s/"get"/`get`/

> @@ -286,7 +271,7 @@ Valid `<type>`'s include:
>  --default <value>::
> -  When using `--get`, and the requested variable is not found, behave as=
 if
> +  When using `get`, and the requested variable is not found, behave as i=
f
>    <value> were the value assigned to the that variable.

Not a fault of this patch (and need not be fixed by this series): "to
the that" should be either "to the" or "to that".

> @@ -506,25 +509,25 @@ you have to provide a regex matching the value of e=
xactly one line.
>  To query the value for a given key, do
>
>  ------------
> -% git config --get core.filemode
> +% git config get core.filemode
>  ------------
>
>  or
>
>  ------------
> -% git config core.filemode
> +% git config get core.filemode
>  ------------

Meh. We only need to retain one of these examples now, not both, right?

> diff --git a/t/t1300-config.sh b/t/t1300-config.sh
> @@ -17,9 +17,15 @@ do
>  case "$mode" in
>  legacy)
>         mode_prefix=3D"--"
> +       mode_get=3D""
> +       mode_get_all=3D"--get-all"
> +       mode_get_regexp=3D"--get-regexp"
>         ;;
>  subcommands)
>         mode_prefix=3D""
> +       mode_get=3D"get"
> +       mode_get_all=3D"get --all"
> +       mode_get_regexp=3D"get --regexp --all --show-names"
>         ;;
>  *)
>         echo "unknown mode $mode" >&2

The variables added by this patch to the `case` arms invalidate the
suggested simplification in my review of [6/13].
