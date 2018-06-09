Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.5 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 1ECBC1F403
	for <e@80x24.org>; Sat,  9 Jun 2018 15:38:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753786AbeFIPis (ORCPT <rfc822;e@80x24.org>);
        Sat, 9 Jun 2018 11:38:48 -0400
Received: from mail-pl0-f66.google.com ([209.85.160.66]:42296 "EHLO
        mail-pl0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S933091AbeFIPip (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 9 Jun 2018 11:38:45 -0400
Received: by mail-pl0-f66.google.com with SMTP id w17-v6so9900831pll.9
        for <git@vger.kernel.org>; Sat, 09 Jun 2018 08:38:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=QQdRBjpU4LaV000vhENScZwz3GB+3AIGX9m9IW/cu5g=;
        b=Jc0j6lp/DdTaza5DOqlRpBPerphFciMKZWWKCE1cQqn9dEnOQGxjaXrbvGk+13zhRy
         GgE0x0pJEB8zIZTp8PC8tdmNx9XsiL3w6i7mU5w+QbB2UAyl4TMYZYvz1MDIKxQdLlKT
         fQw8aMi2spYSnw1cPF8E5uAsv9iL3xT6XVrfuhVFzuTPX5jE+/2xCmRXU+OGMfqM6yw6
         K2vkVQB4aHL4hFozaKHazGAG2dzK92CAgXYDxh2mI45Kip5kNIJEYzR2X03Og1NFq2Cj
         zJHWbDDQIF4bSXkd0wVGi50t3mufZ2Akbp1u5V9YYT9Gos6ti1GUfh7ZqgqV3CB3aB50
         /gxw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=QQdRBjpU4LaV000vhENScZwz3GB+3AIGX9m9IW/cu5g=;
        b=jYe/rlXVjQhezehOwbKxKpU/28/a4eS3DSNGiyrwNKhFV8ixB6QUOtk1zNtQaUDI3v
         ws3A9MQMlhu86yhyu8C9MUu0TajByi/iFfTkJzKpieNJ1De4CtSfmNm8QlKRXVH9CDLr
         73kOapxP8A7jp0QFkwfOu9Ejj4umGebhJzVtRaywqSkS4nHKpxvoLXmWTf2aHlNh/mD1
         M3KAFY5WJ9nxWtheH3bCktTByK07JdkJbNxmQP5kR9KFkTz1EHlIw2EnFkuflGpiLCp5
         OVPk672N0ANmVAxNhCS9uU1VdALx0EswgojYEJ27t2QU0CG/Xm8YZKxUxlUfCB4ZJ2uc
         uYpQ==
X-Gm-Message-State: APt69E2J5OzImqyH63lBARJ2vbrQJVe8ZBLukb/rbH/pewGCKeoVf7qg
        Fy3qz2H6PdflwxT8SB2GXLZqndalRPwRrRyMEqY=
X-Google-Smtp-Source: ADUXVKKd5qSQHdKdvK8HgVgkzH/n/FWpBiE9FuEJGevUrkQ3BkuijWK+aWG2D1Ut0nGQAcaywmCyzwcVwgzKQvdH1kw=
X-Received: by 2002:a17:902:1e2:: with SMTP id b89-v6mr11222102plb.279.1528558725278;
 Sat, 09 Jun 2018 08:38:45 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a17:90a:760e:0:0:0:0 with HTTP; Sat, 9 Jun 2018 08:38:44
 -0700 (PDT)
In-Reply-To: <20180608224136.20220-20-avarab@gmail.com>
References: <20180608224136.20220-1-avarab@gmail.com> <20180608224136.20220-20-avarab@gmail.com>
From:   =?UTF-8?Q?Martin_=C3=85gren?= <martin.agren@gmail.com>
Date:   Sat, 9 Jun 2018 17:38:44 +0200
Message-ID: <CAN0heSr=4GmPqOgtdbSUH97FcS5owRVd__qJzKA5-WDvRqwmjQ@mail.gmail.com>
Subject: Re: [PATCH 19/20] abbrev: support relative abbrev values
To:     =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>
Cc:     Git Mailing List <git@vger.kernel.org>,
        Junio C Hamano <gitster@pobox.com>,
        Derrick Stolee <dstolee@microsoft.com>,
        Jeff Hostetler <git@jeffhostetler.com>,
        Jeff King <peff@peff.net>,
        Johannes Schindelin <johannes.schindelin@gmx.de>,
        Jonathan Nieder <jrnieder@gmail.com>,
        Linus Torvalds <torvalds@linux-foundation.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 9 June 2018 at 00:41, =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason <avarab@gma=
il.com> wrote:
> diff --git a/Documentation/config.txt b/Documentation/config.txt
> index ab641bf5a9..abf07be7b6 100644
> --- a/Documentation/config.txt
> +++ b/Documentation/config.txt
> @@ -919,6 +919,12 @@ core.abbrev::
>         in your repository, which hopefully is enough for
>         abbreviated object names to stay unique for some time.
>         The minimum length is 4.
> ++
> +This can also be set to relative values such as `+2` or `-2`, which
> +means to add or subtract N characters from the SHA-1 that Git would
> +otherwise print, this allows for producing more future-proof SHA-1s
> +for use within a given project, while adjusting the value for the
> +current approximate number of objects.

How about s/, this/. This/ to break it up a little? Also, you write "+2"
and "-2" but then "N". Unify it?

Also, I'd suggest s/SHA-1/object ID/ to be future-proof.

> diff --git a/Documentation/diff-options.txt b/Documentation/diff-options.=
txt
> index f466600972..f1114a7b8d 100644
> --- a/Documentation/diff-options.txt
> +++ b/Documentation/diff-options.txt
> @@ -384,6 +384,9 @@ endif::git-format-patch[]
>         independent of the `--full-index` option above, which controls
>         the diff-patch output format.  Non default number of
>         digits can be specified with `--abbrev=3D<n>`.
> ++
> +Can also be set to a relative value, see `core.abbrev` in
> +linkgit:git-diff[1].

Good. You then add this paragraph to lots of other places...

> diff --git a/config.c b/config.c
> index 12f762ad92..cd95c6bdfb 100644
> --- a/config.c
> +++ b/config.c
> @@ -1151,6 +1151,17 @@ static int git_default_core_config(const char *var=
, const char *value)
>                         return config_error_nonbool(var);
>                 if (!strcasecmp(value, "auto")) {
>                         default_abbrev =3D -1;
> +               } else if (*value =3D=3D '+' || *value =3D=3D '-') {
> +                       int relative =3D git_config_int(var, value);
> +                       if (relative =3D=3D 0)
> +                               die(_("bad core.abbrev value %s. "

Trailing period? Same below.

> +                                     "relative values must be non-zero")=
,
> +                                   value);
> +                       if (abs(relative) > GIT_SHA1_HEXSZ)
> +                               die(_("bad core.abbrev value %s. "
> +                                     "impossibly out of range"),
> +                                   value);
> +                       default_abbrev_relative =3D relative;
>                 } else {
>                         int abbrev =3D git_config_int(var, value);
>                         if (abbrev < minimum_abbrev || abbrev > 40)
> diff --git a/diff.c b/diff.c
> index e0141cfbc0..f7861b8472 100644
> --- a/diff.c
> +++ b/diff.c
> @@ -4801,16 +4801,28 @@ int diff_opt_parse(struct diff_options *options,
>         else if (!strcmp(arg, "--abbrev"))
>                 options->abbrev =3D DEFAULT_ABBREV;
>         else if (skip_prefix(arg, "--abbrev=3D", &arg)) {
> +               int v;
>                 char *end;
>                 if (!strcmp(arg, ""))
>                         die("--abbrev expects a value, got '%s'", arg);
> -               options->abbrev =3D strtoul(arg, &end, 10);
> +               v =3D strtoul(arg, &end, 10);
>                 if (*end)
>                         die("--abbrev expects a numerical value, got '%s'=
", arg);
> -               if (options->abbrev < MINIMUM_ABBREV) {
> +               if (*arg =3D=3D '+' || *arg =3D=3D '-') {
> +                       if (v =3D=3D 0) {
> +                               die("relative abbrev must be non-zero");
> +                       } else if (abs(v) > the_hash_algo->hexsz) {
> +                               die("relative abbrev impossibly out of ra=
nge");
> +                       } else {
> +                               default_abbrev_relative =3D v;
> +                               options->abbrev =3D DEFAULT_ABBREV;
> +                       }
> +               } else if (v < MINIMUM_ABBREV) {
>                         options->abbrev =3D MINIMUM_ABBREV;
> -               } else if (the_hash_algo->hexsz < options->abbrev) {
> +               } else if (the_hash_algo->hexsz < v) {
>                         options->abbrev =3D the_hash_algo->hexsz;
> +               } else {
> +                       options->abbrev =3D v;

I've cut out a few instances of more-or-less repeated code. Any
possibility of extracting this into a helper? Maybe after you've done
the preparatory work of unifying these sites. Or as part of it, i.e.,
"let's switch this spot to use the helper; that makes it stricter in
this-and-that sense".

These can't all be entirely unified, I guess, but maybe "mostly"?

Martin
