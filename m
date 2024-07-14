Received: from mail-lj1-f182.google.com (mail-lj1-f182.google.com [209.85.208.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6F2072B9A4
	for <git@vger.kernel.org>; Sun, 14 Jul 2024 20:41:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720989703; cv=none; b=IY0O+MM8os/NogVFsvpi+wpwGexIPS728g3LLU91NJ/9Tyb229+YrOG2JDBHSHM+nosJVsq0pAM+UYN6wiTOGV8/aqrRuSvlCQ79qP191EFtzTCkgBRnXb0MFySZv55KRYYJfkfybrOBvfrCFCuxlsLvMc5iByHfnWq84EN5jnU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720989703; c=relaxed/simple;
	bh=bZATWmVgYSv7BvL7X4bmINA7JVUOU+4pbVH1egpxbjI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Content-Type; b=Gqcdpb2GnuuX+XzNb25kSJedKpkp4s8ib6ZEX7CzAe86hRkFs3lAYXs4XUZbc20t97ekiBzdpGy6Hn09elsUxYRzK2fN4dL2lHQ3bpxqkI/AvD2f9zT7GVE2FJAjsFX6yZ5yxe9vnuGSI7KJLwu0GCXRXbUUaJvrHsKX8JM4Xys=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kambanaria.org; spf=none smtp.mailfrom=kambanaria.org; dkim=pass (2048-bit key) header.d=kambanaria-org.20230601.gappssmtp.com header.i=@kambanaria-org.20230601.gappssmtp.com header.b=njqq/8QL; arc=none smtp.client-ip=209.85.208.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kambanaria.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=kambanaria.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kambanaria-org.20230601.gappssmtp.com header.i=@kambanaria-org.20230601.gappssmtp.com header.b="njqq/8QL"
Received: by mail-lj1-f182.google.com with SMTP id 38308e7fff4ca-2eaae2a6dc1so55935361fa.0
        for <git@vger.kernel.org>; Sun, 14 Jul 2024 13:41:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kambanaria-org.20230601.gappssmtp.com; s=20230601; t=1720989699; x=1721594499; darn=vger.kernel.org;
        h=content-transfer-encoding:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=HMXoDweJePiw0KcaO91pumNAdgAFuHI3IRzQdvoZRFg=;
        b=njqq/8QLgC8mQpUEpZd022iRjLrr3SjXVtPQKIYQoVisl8jvjeYKBZAPb/ksx8YvB2
         6uppThIIH/sSMiRKPkVrr4y4mkJElIYRO/1DNn9X8toYiHW0JnbqETFPsHevw0jNTKYy
         /lAFHs29yyqjJeaUe7bcih+AdM4ZbiMb5tIuUAyTLb4YURexucw5v0RFwhtdVwXhmonZ
         zDkWI4kDSHXIrFTiH0C4ORgfYIJtCzNMiLotVzdvuVi+aSIo7qGM0f5qsD0RhxYJ5K2m
         Qr8dIrHnFEat68naRxk9c5WdF+4HXw55AHOywOTaHbsNLnYAvjp+uxpn6DJPN8EbSupf
         Haag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720989699; x=1721594499;
        h=content-transfer-encoding:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=HMXoDweJePiw0KcaO91pumNAdgAFuHI3IRzQdvoZRFg=;
        b=Y+CPkgn6BsTRT4HBhdqOIWZfgPGpdA0XkgxMaJDPdB3hYczIwPEBVDO53yJyPkjTFJ
         PIugDzaCa1JHrV1JG+YsUhAjTlsY+8OM56LKdQF2Ls9PReNq1T8fuiOWAtXh3ev8Qftb
         URrjb1k/TCPlksXC7hm1T6FpLLL1Yy4ql1rVPNH1VSMTUtghntQ978dnULM6duZTDunL
         lLi4kyR7HFOffOJq/kBUH1QyqQYdxOJKB7HF7WyXKPPt+1L0DCKorrxGPFtreosiQ/IK
         w21XF/5Ym68F8QaZ20+H4N6Olgbz+zFCRVVaCgqo8w6Cmy1XtiT0p0Jvx74ej306dJB3
         BPRQ==
X-Gm-Message-State: AOJu0YxrQK+2aKivmo+YYpSpTytCmw8Two5GicmPyxEMltHStSfv/IbR
	xuTm69igOYvWAiHHbP+/FQx6fNS+MWVwWJlP5wpdbuLYzoCrnOC6H7TAogiHo+/Sw7mzIbbtGcF
	F5/8AajM8QeGF6vsovXGbk9oV4Fj1+tD2j1raKcee0cFfrf59HtKw9hS6
X-Google-Smtp-Source: AGHT+IETETVLEi0tmmU3qAzhvzQv4Umaseq/DmArZEy1KHUXROXLJ6hd6LJHSQzepLU/wYGUTFH345zL+PTSR88SC/U=
X-Received: by 2002:a2e:7304:0:b0:2ee:8777:f86e with SMTP id
 38308e7fff4ca-2eeb30e3d4fmr138166351fa.14.1720989699018; Sun, 14 Jul 2024
 13:41:39 -0700 (PDT)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <xmqqttij86lc.fsf@gitster.g> <20240707153526.97984-2-ash@kambanaria.org>
In-Reply-To: <20240707153526.97984-2-ash@kambanaria.org>
From: Alexander Shopov <ash@kambanaria.org>
Date: Sun, 14 Jul 2024 22:41:28 +0200
Message-ID: <CAP6f5MkGQssKyAdgN3rbzfTZtPgETaSjpm3JevuaLg-vh_pNug@mail.gmail.com>
Subject: Re: [PATCH 3 1/1] parse-options: localize mark-up of placeholder text
 in the short help
To: git@vger.kernel.org, gitster@pobox.com, worldhello.net@gmail.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Will the patch for expose substitution hint chars be included in 2.46?
Should I do anything more?
Kind regards:
al_shopov


=D0=9D=D0=B0 =D0=BD=D0=B4, 7.07.2024=E2=80=AF=D0=B3. =D0=B2 17:35 Alexander=
 Shopov <ash@kambanaria.org> =D0=BD=D0=B0=D0=BF=D0=B8=D1=81=D0=B0:
>
> i18n: expose substitution hint chars in functions and macros to
> translators
>
> For example (based on builtin/commit.c and shortened): the "--author"
> option takes a name.  In source this can be represented as:
>
>   OPT_STRING(0, "author", &force_author, N_("author"), N_("override autho=
r")),
>
> When the command is run with "-h" (short help) option (git commit -h),
> the above definition is displayed as:
>
>   --[no-]author <author>    override author
>
> Git does not use translated option names so the first part of the
> above, "--[no-]author", is given as-is (it is based on the 2nd
> argument of OPT_STRING).  However the string "author" in the pair of
> "<>", and the explanation "override author for commit" may be
> translated into user's language.
>
> The user's language may use a convention to mark a replaceable part of
> the command line (called a "placeholder string") differently from
> enclosing it inside a pair of "<>", but the implementation in
> parse-options.c hardcodes "<%s>".
>
> Allow translators to specify the presentation of a placeholder string
> for their languages by overriding the "<%s>".
>
> In case the translator's writing system is sufficiently different than
> Latin the "<>" characters can be substituted by an empty string thus
> effectively skipping them in the output.  For example languages with
> uppercase versions of characters can use that to deliniate
> replaceability.
>
> Alternatively a translator can decide to use characters that are
> visually close to "<>" but are not interpreted by the shell.
>
> Signed-off-by: Alexander Shopov <ash@kambanaria.org>
> ---
>  parse-options.c | 12 +++++++++---
>  1 file changed, 9 insertions(+), 3 deletions(-)
>
> diff --git a/parse-options.c b/parse-options.c
> index 30b9e68f8a..06d962b00e 100644
> --- a/parse-options.c
> +++ b/parse-options.c
> @@ -1070,11 +1070,17 @@ static int usage_argh(const struct option *opts, =
FILE *outfile)
>                 !opts->argh || !!strpbrk(opts->argh, "()<>[]|");
>         if (opts->flags & PARSE_OPT_OPTARG)
>                 if (opts->long_name)
> -                       s =3D literal ? "[=3D%s]" : "[=3D<%s>]";
> +                       s =3D literal ? "[=3D%s]" :
> +                         /* TRANSLATORS: change `<>' to other characters=
 or leave as is */
> +                         _("[=3D<%s>]");
>                 else
> -                       s =3D literal ? "[%s]" : "[<%s>]";
> +                       s =3D literal ? "[%s]" :
> +                         /* TRANSLATORS: change `<>' to other characters=
 or leave as is */
> +                         _("[<%s>]");
>         else
> -               s =3D literal ? " %s" : " <%s>";
> +               s =3D literal ? " %s" :
> +                 /* TRANSLATORS: change `<>' to other characters or leav=
e as is */
> +                 _(" <%s>");
>         return utf8_fprintf(outfile, s, opts->argh ? _(opts->argh) : _(".=
.."));
>  }
>
> --
> 2.45.2
>
