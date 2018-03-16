Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 2D9E81F404
	for <e@80x24.org>; Fri, 16 Mar 2018 17:33:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753586AbeCPRdy (ORCPT <rfc822;e@80x24.org>);
        Fri, 16 Mar 2018 13:33:54 -0400
Received: from mail-lf0-f65.google.com ([209.85.215.65]:37898 "EHLO
        mail-lf0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752854AbeCPRdw (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 16 Mar 2018 13:33:52 -0400
Received: by mail-lf0-f65.google.com with SMTP id y2-v6so14382858lfc.5
        for <git@vger.kernel.org>; Fri, 16 Mar 2018 10:33:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=ohF7z1VI+ex8fi96Q9jiV2bj/Wi1hJkRqVann/6pC5k=;
        b=T6JD3/aozenit68HL8pXDtAq1FrE/7Q3coy5rM9h5Qx/XFUm+TaNGV8DCO3Mim5Vnp
         8mGc8jUE/FnYBXkHHful1n7AlvOeupQXKBOZyhFjZf7rrUuhsK9tYk8ADOoXn++u0AHA
         oS+ErinurTY5wjHiKZMaU+6d0JuUzUhhV0wzXn6l8w0Phf2o9ts0WqKlsqOHCa9cSDRR
         XEGuNpOpixj6yR4JRn080bXD1MYgRkh4d1yaHI0s8IxCzXKB0m9NEkiBrPxRAZn5uF/c
         94CUTwTqOweFQo5TQEuFjX7iNAyjR3hYnJVZWgEEs6uedRQyxsv3ZQegmMu4aVpswu0M
         e+Eg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=ohF7z1VI+ex8fi96Q9jiV2bj/Wi1hJkRqVann/6pC5k=;
        b=GewotmJB3nN+i5pd2l7Oly5vXsMFausJQm+wwCFm2jpINUc/YxZkhDWoDls84v+XFQ
         C6VVaANjloUJnqyuNN+hhODjYfWZItyf7qeXbIPLfAGIauz44acoQaKhnpekmx8yGHop
         Wc1BaaYiXV4gatMJ/Hh8cgv1HhAhNpJYMvZl+PxIQnWYwl6CvWFhS3/cU1ACKuH1X3US
         5qi9mS8qx45fj/ntULywAGIM/cLa6rEv0mk3SKEvum03TvHQAmRsEagtgzqLUDewkMdz
         VrKYpoRqsOmVis8wdpB7suKVUEdjiEqU4LM75/ulsgdjEh++bMjpM83t130JvWhaaE6a
         PAzw==
X-Gm-Message-State: AElRT7Ew+ftL/6wuvZjQ2p+dVuT6Dkb6bHiN32AHfgdtHgUiiMxwC5RQ
        je/4Vk1kAnOwZHyneoNzX6CGcSG3IwFFnUtxaes=
X-Google-Smtp-Source: AG47ELu8MwlgdCxu58YuY3wN0Yv8adoQzMSDbA5cn8zwgEXZz5LP49U1H37A72AC+9giSZ9PtUoCXsyP5sfULT0WLuQ=
X-Received: by 2002:a19:2145:: with SMTP id h66-v6mr1909797lfh.63.1521221630866;
 Fri, 16 Mar 2018 10:33:50 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.179.88.153 with HTTP; Fri, 16 Mar 2018 10:33:50 -0700 (PDT)
In-Reply-To: <20180315225746.18119-4-lars.schneider@autodesk.com>
References: <20180315225746.18119-1-lars.schneider@autodesk.com> <20180315225746.18119-4-lars.schneider@autodesk.com>
From:   Morten Welinder <mwelinder@gmail.com>
Date:   Fri, 16 Mar 2018 13:33:50 -0400
Message-ID: <CANv4PNmx9ok0pYxQD1TLfTveWyF8LqhhvT_JpvqrnP8q6+UbKg@mail.gmail.com>
Subject: Re: [PATCH v12 03/10] strbuf: add a case insensitive starts_with()
To:     lars.schneider@autodesk.com
Cc:     GIT Mailing List <git@vger.kernel.org>,
        Junio C Hamano <gitster@pobox.com>, tboegi@web.de,
        j6t@kdbg.org, sunshine@sunshineco.com, Jeff King <peff@peff.net>,
        Ramsay Jones <ramsay@ramsayjones.plus.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        pclouds@gmail.com, Lars Schneider <larsxschneider@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

You need to cast those arguments of tolower to (unsigned char).  That's
arguably a bug of the language.

Character values less than zero aren't valid for tolower, unless they
happen to equal
EOF in which case the tolower calls don't mean what you want them to mean.  Per
the man page:

"If c is neither an unsigned char value nor EOF, the behavior of these
functions is undefined."

M.


On Thu, Mar 15, 2018 at 6:57 PM,  <lars.schneider@autodesk.com> wrote:
> From: Lars Schneider <larsxschneider@gmail.com>
>
> Check in a case insensitive manner if one string is a prefix of another
> string.
>
> This function is used in a subsequent commit.
>
> Signed-off-by: Lars Schneider <larsxschneider@gmail.com>
> ---
>  git-compat-util.h | 1 +
>  strbuf.c          | 9 +++++++++
>  2 files changed, 10 insertions(+)
>
> diff --git a/git-compat-util.h b/git-compat-util.h
> index 68b2ad531e..95c9b34832 100644
> --- a/git-compat-util.h
> +++ b/git-compat-util.h
> @@ -455,6 +455,7 @@ extern void (*get_warn_routine(void))(const char *warn, va_list params);
>  extern void set_die_is_recursing_routine(int (*routine)(void));
>
>  extern int starts_with(const char *str, const char *prefix);
> +extern int istarts_with(const char *str, const char *prefix);
>
>  /*
>   * If the string "str" begins with the string found in "prefix", return 1.
> diff --git a/strbuf.c b/strbuf.c
> index b635f0bdc4..99812b8488 100644
> --- a/strbuf.c
> +++ b/strbuf.c
> @@ -11,6 +11,15 @@ int starts_with(const char *str, const char *prefix)
>                         return 0;
>  }
>
> +int istarts_with(const char *str, const char *prefix)
> +{
> +       for (; ; str++, prefix++)
> +               if (!*prefix)
> +                       return 1;
> +               else if (tolower(*str) != tolower(*prefix))
> +                       return 0;
> +}
> +
>  int skip_to_optional_arg_default(const char *str, const char *prefix,
>                                  const char **arg, const char *def)
>  {
> --
> 2.16.2
>
