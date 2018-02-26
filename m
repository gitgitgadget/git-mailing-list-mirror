Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.6 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 1C8DC1F576
	for <e@80x24.org>; Mon, 26 Feb 2018 10:54:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752455AbeBZKyZ (ORCPT <rfc822;e@80x24.org>);
        Mon, 26 Feb 2018 05:54:25 -0500
Received: from mail-oi0-f66.google.com ([209.85.218.66]:43519 "EHLO
        mail-oi0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752322AbeBZKyX (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 26 Feb 2018 05:54:23 -0500
Received: by mail-oi0-f66.google.com with SMTP id a207so10280228oii.10
        for <git@vger.kernel.org>; Mon, 26 Feb 2018 02:54:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=N1G6kUHtSWuMQGRi2lhOpf5lPhBWqOBc2RoSXOV8dl8=;
        b=XJGzysIEgWc6xt/KRLcDkFyIh0cHGyK54rKzyECjXjf3/JluML1aczWoCTdLdyeARI
         IdRpY700h1TvhT1cXLhGNcxykp2HTaVCSKnjykgqpdavz+72XEagTKMyLbD/ih9PI0gd
         5M8sngMtIVFAz/Jk89ETTJlHmBLGJQqowriOBiQt58xtg4nh27IPfYvOwL4NO6tu5zoI
         2joAvHTFrk0SEpS7yLXFnzQKtLnqZOoqWiSTnf/QJqYpFa+6H/TZtWDuD0fj4+5TMUS8
         eMzXWUz8tDoPH7pps5MUxmjA/VZ6TkoSONYh40cGr5G6rOz8a09ymsqgYP9T3OrkTjJR
         jPcA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=N1G6kUHtSWuMQGRi2lhOpf5lPhBWqOBc2RoSXOV8dl8=;
        b=FL6QRuqMgeHOPnv11x6LBukKOO+yxy/KUWDmz7zA6kYYo7k6Wjnnb/bd3KoalTJnc3
         tmn36tVO7gRE8ZTSiNtLvA8RtAd0SQt0UX+zdO3YW7hkX4UK0FQ01sY+OpITH50eNqFI
         i96JWWgzVC3q9Q7NPSMjhEn7aOecnt9B5IQFdfWpGjWvYzhKui7iiZ7Wq6hv0HZIGDSd
         SNjMLlZ2YKAVAqxZWoVNDwmRx6WCasmf0wH0HQe5OKpOglup857AM06OMhXvMTS/TYLa
         865e97O0ZvXIlBvbwzLg2j3AcxsnO74ohW/S+hcTt2FF7MLtLCMPz173XafP4T5ugLHE
         GmMg==
X-Gm-Message-State: APf1xPDF72kULUZEfIogpAscoJqI3S8mG8CHQIRPS0lRAjY6LEnAobIa
        TQXcpx6ZvcU3REEQ1cK4vb6/zIrBf2nFMCqRJrQ=
X-Google-Smtp-Source: AG47ELvAldS2V6rq16oRD5GVhP9ruHxRcCrun7YO83YaM1dinc+Z+DucmQzdkDkYQQTrYRMVnzZTepjcZk2S15VUzIA=
X-Received: by 10.202.217.67 with SMTP id q64mr6517062oig.30.1519642463110;
 Mon, 26 Feb 2018 02:54:23 -0800 (PST)
MIME-Version: 1.0
Received: by 10.74.25.140 with HTTP; Mon, 26 Feb 2018 02:53:52 -0800 (PST)
In-Reply-To: <20180225203537.28318-2-avarab@gmail.com>
References: <20180225203537.28318-1-avarab@gmail.com> <20180225203537.28318-2-avarab@gmail.com>
From:   Duy Nguyen <pclouds@gmail.com>
Date:   Mon, 26 Feb 2018 17:53:52 +0700
Message-ID: <CACsJy8Dkq4KCgHtvOt9wmxmSTRUaCPzq9jXRwUvMOEUu7Go3yQ@mail.gmail.com>
Subject: Re: [PATCH 1/2] wildmatch: add interface for precompiling wildmatch() patterns
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
> Add the scaffolding necessary for precompiling wildmatch()
> patterns.
>
> There is currently no point in doing this with the wildmatch()
> function we have now, since it can't make any use of precompiling the
> pattern.
>
> But adding this interface and making use of it will make it easy to
> refactor the wildmatch() function to parse the pattern into opcodes as
> some glob() implementations do, or to drop an alternate wildmatch()
> backend in which trades parsing slowness for faster matching, such as
> the PCRE v2 conversion function that understands the wildmatch()
> syntax.
>
> It's very unlikely that we'll remove the wildmatch() function as a
> convenience wrapper even if we end up requiring a separate compilation
> step in some future implementation. There are a lot of one-shot
> wildmatches in the codebase, in that case most likely wildmatch() will
> be kept around as a shorthand for wildmatch_{compile,match,free}().
>
> I modeled this interface on the PCRE v2 interface. I didn't go with a
> glob(3) & globfree(3)-like interface because that would require every
> wildmatch() user to pass a dummy parameter, which I got rid of in
> 55d3426929 ("wildmatch: remove unused wildopts parameter",
> 2017-06-22).
>
> Signed-off-by: =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason <avarab@gmail.com>
> ---
>  wildmatch.c | 25 +++++++++++++++++++++++++
>  wildmatch.h | 11 +++++++++++
>  2 files changed, 36 insertions(+)
>
> diff --git a/wildmatch.c b/wildmatch.c
> index d074c1be10..032f339391 100644
> --- a/wildmatch.c
> +++ b/wildmatch.c
> @@ -276,3 +276,28 @@ int wildmatch(const char *pattern, const char *text,=
 unsigned int flags)
>  {
>         return dowild((const uchar*)pattern, (const uchar*)text, flags);
>  }
> +
> +struct wildmatch_compiled *wildmatch_compile(const char *pattern,
> +                                            unsigned int flags)
> +{
> +       struct wildmatch_compiled *wildmatch_compiled =3D xmalloc(
> +               sizeof(struct wildmatch_compiled));

struct wildmatch_compiled *data =3D xmalloc(sizeof(*data));

?

It shortens the line a bit. We already use WM_ prefix for wildmatch
flags, perhaps we can use it for wildmatch structs too (e.g.
wm_compiled instead)

> +       wildmatch_compiled->pattern =3D xstrdup(pattern);
> +       wildmatch_compiled->flags =3D flags;
> +
> +       return wildmatch_compiled;
> +}
> +
> +int wildmatch_match(struct wildmatch_compiled *wildmatch_compiled,
> +                   const char *text)
> +{
> +       return wildmatch(wildmatch_compiled->pattern, text,
> +                        wildmatch_compiled->flags);
> +}
> +
> +void wildmatch_free(struct wildmatch_compiled *wildmatch_compiled)
> +{
> +       if (wildmatch_compiled)
> +               free((void *)wildmatch_compiled->pattern);

Why do make pattern type "const char *" then remove "const" with
typecast here? Why not just "char *" in wildmatch_compiled?

If the reason is to avoid other users from peeking in and modifying
it, then perhaps you can move struct wildmatch_compiled to wildmatch.c
and keep it an opaque struct pointer.

> +       free(wildmatch_compiled);
> +}
> diff --git a/wildmatch.h b/wildmatch.h
> index b8c826aa68..2fc00e0ca0 100644
> --- a/wildmatch.h
> +++ b/wildmatch.h
> @@ -10,5 +10,16 @@
>  #define WM_ABORT_ALL -1
>  #define WM_ABORT_TO_STARSTAR -2
>
> +struct wildmatch_compiled {
> +       const char *pattern;
> +       unsigned int flags;
> +};
> +
>  int wildmatch(const char *pattern, const char *text, unsigned int flags)=
;
> +struct wildmatch_compiled *wildmatch_compile(const char *pattern,
> +                                            unsigned int flags);
> +int wildmatch_match(struct wildmatch_compiled *wildmatch_compiled,
> +                   const char *text);
> +void wildmatch_free(struct wildmatch_compiled *wildmatch_compiled);
> +
>  #endif
> --
> 2.15.1.424.g9478a66081
>



--=20
Duy
