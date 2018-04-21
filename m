Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.4 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id CB49E1F424
	for <e@80x24.org>; Sat, 21 Apr 2018 08:32:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752633AbeDUIcJ (ORCPT <rfc822;e@80x24.org>);
        Sat, 21 Apr 2018 04:32:09 -0400
Received: from mail-pf0-f196.google.com ([209.85.192.196]:42976 "EHLO
        mail-pf0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752547AbeDUIcH (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 21 Apr 2018 04:32:07 -0400
Received: by mail-pf0-f196.google.com with SMTP id o16so5313032pfk.9
        for <git@vger.kernel.org>; Sat, 21 Apr 2018 01:32:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=s9ZLX30Ab0glvFXph2cZ+YNuKFmiHy25/5wkpKbe/Go=;
        b=AItZaWRJ7oX0EXnsrvm3hgh9JmsQQQ6s4OYRR0JNfKEIGS/2lyzeprnrLiKy0CKege
         bPTzroFSrEimtg7CHtUsg0VB6XONjPKx0ONHDXtLx3ZnCEkr4wTAZyDA6fTooxIWlBJY
         RLGiA0KdA6bqfHRxnZLc0/WDx1ACl/PNnO+YV3Zch46x0wAgFcqfcW0zza075rNrmIQA
         RUdzXeZyT4QdL609YQ/G4wKjXgvweT9I1IhZDuko9cpKuwX2Jz9VTocx11g/WZ+gx8S0
         KC+ZTGR97A/cH4Aqi1XSfl7GxxPvP0vLQvuxyQKYSLxhNZfDFfIkg0JapUcCsaeMz05k
         whDg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=s9ZLX30Ab0glvFXph2cZ+YNuKFmiHy25/5wkpKbe/Go=;
        b=ohVXfSxZkdhGdi/KwyjVTqLtQuV9gqlUCorQ9axA8nNwNBC14z+X2kieS+8EXW6mkB
         2EFmN/lhGkM92sqGwK/Z6bafdWzinJ6ZglX0T6ZBWI8iJ1hHSwGXdSq8CaSEZdis3kMg
         cmtRBSUuSkErNWjF0ELrvuk7hwTKYdSkVhzcs9J+pB045VDqt6ZzVcCEqkli2S6w7En8
         2FbJ9sWVNN+eBj90TJoPMLVu07qzCMUYvUexmq2klaDGo4KFNpqbRfQ3dcIebWPY/urH
         bHU+qWSlxIqKCAL5lP1Y2obEYLTTJVIzfro73oTPWNJ5a8k4gdHhcF3v0mcBEXPPlwOm
         jV6A==
X-Gm-Message-State: ALQs6tAhQjydC8tiLTlTZ53X5sJcTLvNYQ2hiwSIsyCfx2pFJ3ejlml+
        BFYoLQb12bpbYgMyHkx+4HnUpVvexd8wVcHBhmU=
X-Google-Smtp-Source: AIpwx4+vQha1kaC427vEqX3EkI0Gxmnw3G/GiK9ePeiBJuRYbnAJmHyZgRv6CBXZ8H08WiDI8Se4/G0wtlDQQJtvlLI=
X-Received: by 10.99.123.83 with SMTP id k19mr10814931pgn.146.1524299526867;
 Sat, 21 Apr 2018 01:32:06 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.236.150.4 with HTTP; Sat, 21 Apr 2018 01:32:06 -0700 (PDT)
In-Reply-To: <20180421034535.GD24606@syl.local>
References: <cover.1524281843.git.me@ttaylorr.com> <20180421034535.GD24606@syl.local>
From:   =?UTF-8?Q?Martin_=C3=85gren?= <martin.agren@gmail.com>
Date:   Sat, 21 Apr 2018 10:32:06 +0200
Message-ID: <CAN0heSoa2CLNF7vdsmfkc2rbz2XhM_77XnuK9=5wf4LAnmX=Ww@mail.gmail.com>
Subject: Re: [PATCH 3/6] grep.[ch]: teach columnnum, color_columnno to grep_opt
To:     Taylor Blau <me@ttaylorr.com>
Cc:     Git Mailing List <git@vger.kernel.org>,
        Junio C Hamano <gitster@pobox.com>,
        =?UTF-8?Q?Ren=C3=A9_Scharfe?= <l.s.r@web.de>,
        Jeff King <peff@peff.net>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 21 April 2018 at 05:45, Taylor Blau <me@ttaylorr.com> wrote:
> diff --git a/grep.c b/grep.c
> index 29bc799ecf..7872a5d868 100644
> --- a/grep.c
> +++ b/grep.c
> @@ -95,6 +95,10 @@ int grep_config(const char *var, const char *value, void *cb)
>                 opt->linenum = git_config_bool(var, value);
>                 return 0;
>         }
> +       if (!strcmp(var, "grep.columnnumber")) {
> +               opt->columnnum = git_config_bool(var, value);
> +               return 0;
> +       }
>
>         if (!strcmp(var, "grep.fullname")) {
>                 opt->relative = !git_config_bool(var, value);
> @@ -111,6 +115,8 @@ int grep_config(const char *var, const char *value, void *cb)
>                 color = opt->color_function;
>         else if (!strcmp(var, "color.grep.linenumber"))
>                 color = opt->color_lineno;
> +       else if (!strcmp(var, "color.grep.columnumber"))
> +               color = opt->color_columnno;

missing 'n' (s/umnum/umnnum/). Those characters are almost perfectly
designed for hiding precisely this mistake. ;-)
