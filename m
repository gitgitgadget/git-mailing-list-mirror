Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 65D892095E
	for <e@80x24.org>; Sat, 25 Mar 2017 16:48:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751352AbdCYQsM (ORCPT <rfc822;e@80x24.org>);
        Sat, 25 Mar 2017 12:48:12 -0400
Received: from mail-it0-f43.google.com ([209.85.214.43]:35308 "EHLO
        mail-it0-f43.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751258AbdCYQsL (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 25 Mar 2017 12:48:11 -0400
Received: by mail-it0-f43.google.com with SMTP id y18so36651780itc.0
        for <git@vger.kernel.org>; Sat, 25 Mar 2017 09:48:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=hBobWD9TzE/LzOK2vfTwe8y79pTuMWdfq/aLXkn9RNo=;
        b=L0Hpk2hW8DbuvUBTRvByKaEtvIoNd4HgM/oCAZaRf9WzwCMoqu988HmvQ3uIMa6TPg
         PntcJR1crB+FzrhM96xjuZl3v753dWb3AMtET8kS9XUIueraTtNM+eXlC6Vm0XoukDcx
         +/O3b+yuHYUnJlTpxubjEtl/rBnu4aTOBsMbHM/J7MFujpytsk3ShWaWT2IshXec/g9M
         MEeRSJ5uJhBf54FcHZ8UFkEL3syvTrO1Fb9MKfoXXFtpi9K5t8JuitcPEjmfi7OtMPkf
         gXiX92Kgv99gl2KwOlI6VjOn8Ye4fxx40sjZn5A2cCtAt6nt0way/7+kWqJK7q2mrvMN
         DmRQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=hBobWD9TzE/LzOK2vfTwe8y79pTuMWdfq/aLXkn9RNo=;
        b=K0kf9HffpzG3hegQMPZGjqWWNhQpMn5qs+y8xWPR8pBIIqgtuoAR70iFXJfohAl9Z0
         XmupKWxkM54nvFOxSBrUPQ0xqm0vjlKPBleOM9P5DOE+ImcYJOlT1rYo8i00U61I+WAP
         Lcy8+fUQoTz48H5Cy1p/t8RR0CSttOsdb5lv3Hq/mk1mdgo2pOEW3gYEa+yBPmbLAW39
         077BuvK1Y4Xin+MkS0669KbUjESdX3jgKwRO9FhR75bNGlbHa9HD2UEJZIMcmuvKqmTP
         x1TFHDjliPGwHg4XiRtHCNmNaGS2sFkTcl6eD57V5tUXJ9WP3Uwy+Bc1oms2w6R2TJn8
         tV2A==
X-Gm-Message-State: AFeK/H1I1pdqQ15iMoLSzUBnExrcKoptLSS2hbceXdi56GaYf7q0BnupWOirfiuKlQ8y6TVQeelTXX6DQWWWrw==
X-Received: by 10.36.29.66 with SMTP id 63mr2322005itj.91.1490460490108; Sat,
 25 Mar 2017 09:48:10 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.107.130.208 with HTTP; Sat, 25 Mar 2017 09:47:49 -0700 (PDT)
In-Reply-To: <20170324231013.23346-1-avarab@gmail.com>
References: <CACBZZX4FksU6NujPZ_3GZ45EQ+KdJj5G2sajtRipE1wbaA3URA@mail.gmail.com>
 <20170324231013.23346-1-avarab@gmail.com>
From:   =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>
Date:   Sat, 25 Mar 2017 17:47:49 +0100
Message-ID: <CACBZZX6iz5QpfpOO6s9c-GY7+ZZ2uXBxqgKfSRhU+__P0VLC5g@mail.gmail.com>
Subject: Re: [PATCH/RFC] parse-options: add facility to make options configurable
To:     Git Mailing List <git@vger.kernel.org>
Cc:     Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>,
        "brian m . carlson" <sandals@crustytoothpaste.net>,
        Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>,
        Duy Nguyen <pclouds@gmail.com>,
        Brandon Williams <bmwill@google.com>,
        =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

 On Sat, Mar 25, 2017 at 12:10 AM, =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason
<avarab@gmail.com> wrote:
> [...]
> This is all very proof-of-concept, and uses the ugly hack of s/const
> // for the options struct because I'm now keeping state in it, as
> noted in one of the TODO comments that should be moved.
> [...]
>  static int parse_long_opt(struct parse_opt_ctx_t *p, const char *arg,
> -                          const struct option *options)
> +                          struct option *options)
>  {
>         const struct option *all_opts =3D options;
> [...]
> @@ -313,7 +314,17 @@ static int parse_long_opt(struct parse_opt_ctx_t *p,=
 const char *arg,
>                                 continue;
>                         p->opt =3D rest + 1;
>                 }
> -               return get_value(p, options, all_opts, flags ^ opt_flags)=
;
> +               if (!(ret =3D get_value(p, options, all_opts, flags ^ opt=
_flags))) {
> +                       /* TODO: Keep some different state on the side
> +                        * with info about what options we've
> +                        * retrieved via the CLI for use in the loop
> +                        * in parse_options_step, instead of making
> +                        * the 'options' non-const
> +                        */
> +                       if (options->flags & PARSE_OPT_CONFIGURABLE)
> +                               options->flags |=3D PARSE_OPT_VIA_CLI;
> +               }
> +               return ret;
>         }
> [...]
> +
> +       /* The loop above is driven by the argument vector, so we need
> +        * to make a second pass and find those options that are
> +        * configurable, and haven't been set via the command-line */
> +       for (; options->type !=3D OPTION_END; options++) {
> +               if (!(options->flags & PARSE_OPT_CONFIGURABLE))
> +                       continue;
> +
> +               if (options->flags & PARSE_OPT_VIA_CLI)
> +                       continue;
> +
> +               /* TODO: Maybe factor the handling of OPTION_CALLBACK
> +                * in get_value() into a function.
> +                *
> +                * Do we also need to save away the state from the
> +                * loop above to handle unset? I think not, I think
> +                * we're always unset here by definition, right?
> +                */
> +               return (*options->conf_callback)(options, NULL, 1) ? (-1)=
 : 0;
> +       }
> +
> [...]

After looking at some of the internal APIs I'm thinking of replacing
this pattern with a hashmap.c hashmap where the keys are a
sprintf("%d:%s", short_name, long_name) to uniquely identify the
option. There's no other obvious way to uniquely address an option. I
guess I could just equivalently and more cheaply use the memory
address of each option to identify them, but that seems a bit hacky.

> @@ -110,6 +112,9 @@ struct option {
>         int flags;
>         parse_opt_cb *callback;
>         intptr_t defval;
> +
> +       const char *conf_key;
> +       parse_opt_cb *conf_callback;
>  };

I've already found that this needs to be a char **conf_key, since
several command-line options have multiple ways to spell the option
name, e.g. add.ignoreerrors & add.ignore-errors, pack.writebitmaps &
repack.writebitmaps etc.
