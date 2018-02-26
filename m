Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.6 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id BD0E31F576
	for <e@80x24.org>; Mon, 26 Feb 2018 11:00:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752340AbeBZLAe (ORCPT <rfc822;e@80x24.org>);
        Mon, 26 Feb 2018 06:00:34 -0500
Received: from mail-oi0-f47.google.com ([209.85.218.47]:44407 "EHLO
        mail-oi0-f47.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752114AbeBZLAd (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 26 Feb 2018 06:00:33 -0500
Received: by mail-oi0-f47.google.com with SMTP id b8so10290573oib.11
        for <git@vger.kernel.org>; Mon, 26 Feb 2018 03:00:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=Kx3p6kx5SAl6yxlxIhp8XIDWPVCan/qnizdRMUdcTaA=;
        b=UChaccyBE0RtKlvtooaqfZeKXc3noXCjAshU07LZQePh/7Apmi7aY+H5uxavKzZHpD
         2rlP+Q3bSHzjp2nbE5jh26Tdd9KGKtSS/18RUJFCw9KeofTY76fmPUO5LUsFQWfOSNGz
         CBVgOjOPx5CbfJO/vaq4TNCELxIbnKygLaRW86GZKJ6QJJMOktiy2i3Erhy0HyFfFd/r
         kKbQZF6BpKEyWgnIWeDniT1Icbxc6p+CPaHH51Mn67LJkgQwgWj7LqMRiSaxb9vJShrM
         cqBPTjz1ct2xvW8wFsvWZZhGHo/X5HjUnC/6xql0x/Yp2Bv2F9nzELmfDQItTB1A/4TK
         2cSA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=Kx3p6kx5SAl6yxlxIhp8XIDWPVCan/qnizdRMUdcTaA=;
        b=p5cxV3YXF9XjbF5aMIQcby73A6+0nOE16bF9sQmyBL/cX9+hKIjkfKoG1v0NGGZ5wX
         D2CpKD1TqYb7v8PkvAKHpcAc5PgczAwpClKGnySEBxXzRdKfcEp6Q25cn/VyiMAdvW5w
         PvBkXSpasP851pFK/CsrzguZaat2IaDFqSNYJLrfWl3eTWr5tioQp7AUrvu9XoM7DHb9
         jbiU6OBWdAdwPpfTCw4SniOtSHdwxPPeJyFFV6aOHup5qpigM6kXS+FdJDEQxLc6YiIU
         sre0HPn/QMa8PMEyqv8sKKSbppyqtHLmJ6aG8Vkr0s8VOrQod6HBsMsw/X1alfTgBdki
         vAsw==
X-Gm-Message-State: APf1xPAyMe6FomlLafy08MJF+OCPWtS/zCd9UGBEEtJ1UwT3FwAeJcyf
        gPmx5Atsp7DrqN+/q01QXkeMBeLsUzPoFES0ULI=
X-Google-Smtp-Source: AG47ELvG09LMGXQ5kdzPaPx60ox87ueCr7Z4Msqbgbtu51PGDyr+AKut4dA2Yw21oBIEwYp47dPE/hBlVtRbXOMcpOU=
X-Received: by 10.202.15.21 with SMTP id 21mr6562528oip.216.1519642833193;
 Mon, 26 Feb 2018 03:00:33 -0800 (PST)
MIME-Version: 1.0
Received: by 10.74.25.140 with HTTP; Mon, 26 Feb 2018 03:00:02 -0800 (PST)
In-Reply-To: <20180225203537.28318-3-avarab@gmail.com>
References: <20180225203537.28318-1-avarab@gmail.com> <20180225203537.28318-3-avarab@gmail.com>
From:   Duy Nguyen <pclouds@gmail.com>
Date:   Mon, 26 Feb 2018 18:00:02 +0700
Message-ID: <CACsJy8D09Jm5TLsXvEJHVDM+K2hCd5E-367-BQssErorynM2kQ@mail.gmail.com>
Subject: Re: [PATCH 2/2] wildmatch: use the new precompiling wildmatch()
To:     =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>
Cc:     Git Mailing List <git@vger.kernel.org>,
        Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Feb 26, 2018 at 3:35 AM, =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason
<avarab@gmail.com> wrote:
> diff --git a/config.c b/config.c
> index b0c20e6cb8..0f595de971 100644
> --- a/config.c
> +++ b/config.c
> @@ -210,6 +210,7 @@ static int include_by_gitdir(const struct config_opti=
ons *opts,
>         int ret =3D 0, prefix;
>         const char *git_dir;
>         int already_tried_absolute =3D 0;
> +       struct wildmatch_compiled *wildmatch_compiled =3D NULL;
>
>         if (opts->git_dir)
>                 git_dir =3D opts->git_dir;
> @@ -237,8 +238,10 @@ static int include_by_gitdir(const struct config_opt=
ions *opts,
>                         goto done;
>         }
>
> -       ret =3D !wildmatch(pattern.buf + prefix, text.buf + prefix,
> -                        icase ? WM_CASEFOLD : 0);
> +       if (!wildmatch_compiled)
> +               wildmatch_compiled =3D wildmatch_compile(pattern.buf + pr=
efix,
> +                                                      icase ? WM_CASEFOL=
D : 0);
> +       ret =3D !wildmatch_match(wildmatch_compiled, text.buf + prefix);

This is a one-shot matching. Is it worth converting to the new interface?

>
>         if (!ret && !already_tried_absolute) {
>                 /*
> @@ -257,6 +260,7 @@ static int include_by_gitdir(const struct config_opti=
ons *opts,
>  done:
>         strbuf_release(&pattern);
>         strbuf_release(&text);
> +       wildmatch_free(wildmatch_compiled);
>         return ret;
>  }
>
> diff --git a/refs.c b/refs.c
> index 20ba82b434..c631793d1e 100644
> --- a/refs.c
> +++ b/refs.c
> @@ -213,7 +213,7 @@ char *resolve_refdup(const char *refname, int resolve=
_flags,
>
>  /* The argument to filter_refs */
>  struct ref_filter {
> -       const char *pattern;
> +       struct wildmatch_compiled *code;

This actually makes me think if we should name this struct wildmatch_patter=
n.

>         each_ref_fn *fn;
>         void *cb_data;
>  };
> @@ -291,7 +291,7 @@ static int filter_refs(const char *refname, const str=
uct object_id *oid,
>  {
>         struct ref_filter *filter =3D (struct ref_filter *)data;
>
> -       if (wildmatch(filter->pattern, refname, 0))
> +       if (wildmatch_match(filter->code, refname))
>                 return 0;
>         return filter->fn(refname, oid, flags, filter->cb_data);
>  }
> @@ -454,12 +454,13 @@ int for_each_glob_ref_in(each_ref_fn fn, const char=
 *pattern,
>                 strbuf_addch(&real_pattern, '*');
>         }
>
> -       filter.pattern =3D real_pattern.buf;
> +       filter.code =3D wildmatch_compile(real_pattern.buf, 0);
>         filter.fn =3D fn;
>         filter.cb_data =3D cb_data;
>         ret =3D for_each_ref(filter_refs, &filter);
>
>         strbuf_release(&real_pattern);
> +       wildmatch_free(filter.code);
>         return ret;
>  }
>
> --
> 2.15.1.424.g9478a66081
>
--=20
Duy
