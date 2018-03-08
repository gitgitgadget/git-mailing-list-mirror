Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 4A0E01F404
	for <e@80x24.org>; Thu,  8 Mar 2018 00:32:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S934087AbeCHAcY (ORCPT <rfc822;e@80x24.org>);
        Wed, 7 Mar 2018 19:32:24 -0500
Received: from mail-ot0-f193.google.com ([74.125.82.193]:39300 "EHLO
        mail-ot0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932905AbeCHAcX (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 7 Mar 2018 19:32:23 -0500
Received: by mail-ot0-f193.google.com with SMTP id h8so3868040oti.6
        for <git@vger.kernel.org>; Wed, 07 Mar 2018 16:32:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=+bNvWpPdpdYo0UWzKBSQzYvkcIcBl1sGDctxAVTX6rY=;
        b=RubrMzFRQUVipQNh4EkNRM8v3bCYlnyWOCEqRkPI9nrP6690WBLjltGWPUcyLXJSef
         OruZMqVeilGnQ8j7Bc/bm7fuuxmMvQ4KNbKA8iZ7hZauYOa38fljNT+Hw8KV/u6f1AXK
         3PyEW5l6Ozl6oLUzQfCEPbvDDi6YYQE5S73rQDMNvAePjYn4b2k2qOBeqnymTC9YDIkJ
         mlIOZm0wdy6tO1c/aPTP1K8EppbgRiwK786U0BbWMg3NeEnNibBYNmEt8Ijo3mWpe2bu
         DpzMmsXesNSpgyvi8YeE0XP51bg8axZpvGAqpbnPtzv1nY7lljCRvqJr1iWBs6Yj2sJy
         jFRg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=+bNvWpPdpdYo0UWzKBSQzYvkcIcBl1sGDctxAVTX6rY=;
        b=jnnOwTnuIrJQlKgavbONsg9q4QR5kMiZEeG8xgqdF8FJuH0CQLVGvNLtdGroYmyCSz
         hYaIjZ0ycluw8xj7ehfLRLpuJ0OkNvbhgChSm1nEECeMBwv+Ntg1sUp1OIUMayy3ZY6g
         yRfUyPSRGRvS6C6k9XSPkO8WL6x4yULTAvyyOPul3CZRquBOlcll6kToOcOuTLvJxFuO
         0buteRihHsFlf1DF532t3zqNVWmRj/Sy5OcIQzeoYd/ahn6F1U9jrsAKpxgVcy6UPvVp
         AXSIWx7OU7GACx9h/07JEYevYDJciQ496dJQ6IIreXhlrYnwOb/8VaqqVewbPx+8TyDP
         B40w==
X-Gm-Message-State: AElRT7Hrj4lOc8/jlj7X8BqE7MTZ5/3zVtBkXeGcQuuvPN6MQBHdXvqi
        5udK2/omlEdTSCCAXJvqwMPpdKOpi4bp5Qov4GguSg==
X-Google-Smtp-Source: AG47ELvoQFdIT+d70oFoAOU3pAKA+4KCLPsDOcM8xvEzUrpXJS+QH3F1PvSPlzSVG4gPhrlgkBkVS/X+RYLPNAxgAQU=
X-Received: by 10.157.11.4 with SMTP id a4mr17859159ota.65.1520469143226; Wed,
 07 Mar 2018 16:32:23 -0800 (PST)
MIME-Version: 1.0
Received: by 10.74.25.140 with HTTP; Wed, 7 Mar 2018 16:31:52 -0800 (PST)
In-Reply-To: <20180307173026.30058-4-lars.schneider@autodesk.com>
References: <20180307173026.30058-1-lars.schneider@autodesk.com> <20180307173026.30058-4-lars.schneider@autodesk.com>
From:   Duy Nguyen <pclouds@gmail.com>
Date:   Thu, 8 Mar 2018 07:31:52 +0700
Message-ID: <CACsJy8DWMmC9mvz783XQFHUopbVMH00LoqpW-CQunzg0qgiEEA@mail.gmail.com>
Subject: Re: [PATCH v10 3/9] strbuf: add a case insensitive starts_with()
To:     lars.schneider@autodesk.com
Cc:     Git Mailing List <git@vger.kernel.org>,
        Junio C Hamano <gitster@pobox.com>,
        =?UTF-8?Q?Torsten_B=C3=B6gershausen?= <tboegi@web.de>,
        Johannes Sixt <j6t@kdbg.org>,
        Eric Sunshine <sunshine@sunshineco.com>,
        Jeff King <peff@peff.net>,
        Ramsay Jones <ramsay@ramsayjones.plus.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Lars Schneider <larsxschneider@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Mar 8, 2018 at 12:30 AM,  <lars.schneider@autodesk.com> wrote:
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
> index 68b2ad531e..f648da0c11 100644
> --- a/git-compat-util.h
> +++ b/git-compat-util.h
> @@ -455,6 +455,7 @@ extern void (*get_warn_routine(void))(const char *warn, va_list params);
>  extern void set_die_is_recursing_routine(int (*routine)(void));
>
>  extern int starts_with(const char *str, const char *prefix);
> +extern int startscase_with(const char *str, const char *prefix);

This name is a bit hard to read. Boost [1] goes with istarts_with. I
wonder if it's better. If not I guess either starts_with_case or
starts_case_with will improve readability.

[1] http://www.boost.org/doc/libs/1_41_0/doc/html/boost/algorithm/istarts_with.html

>
>  /*
>   * If the string "str" begins with the string found in "prefix", return 1.
> diff --git a/strbuf.c b/strbuf.c
> index b635f0bdc4..5779a2d591 100644
> --- a/strbuf.c
> +++ b/strbuf.c
> @@ -11,6 +11,15 @@ int starts_with(const char *str, const char *prefix)
>                         return 0;
>  }
>
> +int startscase_with(const char *str, const char *prefix)
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



-- 
Duy
