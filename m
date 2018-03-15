Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_DKIM_INVALID,
	T_RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id F0A241F404
	for <e@80x24.org>; Thu, 15 Mar 2018 23:25:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933090AbeCOXZS (ORCPT <rfc822;e@80x24.org>);
        Thu, 15 Mar 2018 19:25:18 -0400
Received: from mail-qt0-f193.google.com ([209.85.216.193]:34119 "EHLO
        mail-qt0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932673AbeCOXZS (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 15 Mar 2018 19:25:18 -0400
Received: by mail-qt0-f193.google.com with SMTP id l25so9145230qtj.1
        for <git@vger.kernel.org>; Thu, 15 Mar 2018 16:25:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:sender:in-reply-to:references:from:date:message-id
         :subject:to:cc;
        bh=2wPk/v12I5RWalKuRKMhVxabpMv++hKjssj4Ta9u+8s=;
        b=Nt3RE1eR952kY+IzVwAaQOX2GjGY9BYEGqGPJiCRjc7HsDoIAY8oIo+9tje0xgrqXh
         mLwFN50pfqwfxCyC7LPJrgQFUUPgyw4dBAxVOXaoew+9tSii69FqT4474iUxrWNqjoQO
         pC2ZsRGbKBgZ8jWvvAQDhXHuOdjrhrHTMKx+7FEK8h+uu0aQPFigFC3xQgPl1x2+6xjL
         ORMUl8lHCAARXVNcN3iWWJPtYQ/obZCg09Fq6AhpVhh+97d/++IQmtG+2vHyFCyEyyqJ
         vSE2isV/kZT7ef52NQOWcYHGMYRwq0/tUUeEhH4Sq9XlCnyIkHWUlqGllG6xZL6Km0Zv
         bkng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:sender:in-reply-to:references:from
         :date:message-id:subject:to:cc;
        bh=2wPk/v12I5RWalKuRKMhVxabpMv++hKjssj4Ta9u+8s=;
        b=WH04adW+kyR72Lu7VqGa0rXRdxMJpAxWtRsEoCJkO39OSgdilnN3FRIz2+WezpymNi
         kN1njneW5fQdjIRDdzYxAW4NW2nB5TkNJCDsTdTxXQrn6v2p/3NhvSgCjTeE/onOcZw6
         yHOQ9kXKnnmkN8eQ/+OiohAI2UK/84kRdpuEsOmgrR2UkEXuJyx1qALHJr/tcsIxMrEB
         qCTwWBUGsj2j9ZflopBNrfjV6xYn8xudtlQoYn5szKxtgaCzpl2q6KH95EEVR+a1gxsu
         NQ7WY1pdsOclHPJfODU1jZ6etVSZH8DKfgDASE0fFlcV6ILKyYbkkxJSlN2TucbKhtR7
         HOlw==
X-Gm-Message-State: AElRT7H0kaWcAFV1tZmqkLUx1Q+n+ydlpkbMGcsdThHG60PfZdpl1lj3
        5CY7FxAeiqocCx2AFNwnulWskuvKOgvraw4+WCU=
X-Google-Smtp-Source: AG47ELtt4sbw2eeVifqKPqELTcjkwnbfO6y6nhS03mg7Fu7mI+td2XQVeL2mFDCI6wpGQzzmHKrBXX7E4fppJNMf2ZE=
X-Received: by 10.200.17.132 with SMTP id d4mr15413614qtj.97.1521156317197;
 Thu, 15 Mar 2018 16:25:17 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.12.132.66 with HTTP; Thu, 15 Mar 2018 16:25:16 -0700 (PDT)
In-Reply-To: <20180315225746.18119-5-lars.schneider@autodesk.com>
References: <20180315225746.18119-1-lars.schneider@autodesk.com> <20180315225746.18119-5-lars.schneider@autodesk.com>
From:   Eric Sunshine <sunshine@sunshineco.com>
Date:   Thu, 15 Mar 2018 19:25:16 -0400
X-Google-Sender-Auth: r4RXm6XuvCjyznBWC20OtepejnU
Message-ID: <CAPig+cSvBi1pJYC-DND1_x9rHhmoAPs90B_3Fg53-X5FjtCQhA@mail.gmail.com>
Subject: Re: [PATCH v12 04/10] utf8: teach same_encoding() alternative UTF
 encoding names
To:     Lars Schneider <lars.schneider@autodesk.com>
Cc:     Git List <git@vger.kernel.org>, Junio C Hamano <gitster@pobox.com>,
        =?UTF-8?Q?Torsten_B=C3=B6gershausen?= <tboegi@web.de>,
        Johannes Sixt <j6t@kdbg.org>, Jeff King <peff@peff.net>,
        Ramsay Jones <ramsay@ramsayjones.plus.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        =?UTF-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41jIER1eQ==?= 
        <pclouds@gmail.com>, Lars Schneider <larsxschneider@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Mar 15, 2018 at 6:57 PM,  <lars.schneider@autodesk.com> wrote:
> The function same_encoding() checked only for alternative UTF-8 encoding
> names. Teach it to check for all kinds of alternative UTF encoding
> names.
>
> Signed-off-by: Lars Schneider <larsxschneider@gmail.com>
> ---
> diff --git a/utf8.c b/utf8.c
> @@ -401,11 +401,27 @@ void strbuf_utf8_replace(struct strbuf *sb_src, int pos, int width,
> +static int same_utf_encoding(const char *src, const char *dst)
> +{
> +       if (istarts_with(src, "utf") && istarts_with(dst, "utf")) {
> +               /* src[3] or dst[3] might be '\0' */
> +               int i = (src[3] == '-' ? 4 : 3);
> +               int j = (dst[3] == '-' ? 4 : 3);
> +               return !strcasecmp(src+i, dst+j);
> +       }
> +       return 0;
> +}

Alternate implementation without magic numbers:

    if (iskip_prefix(src, "utf", &src) &&
        iskip_prefix(dst, "utf", &dst)) {
        if (*src == '-')
            src++;
        if (*dst == '-')
            dst++;
        return !strcasecmp(src, dst);
    }
    return 0;

... assuming you add an iskip_prefix() function (patterned after skip_prefix()).

>  int is_encoding_utf8(const char *name)
>  {
>         if (!name)
>                 return 1;
> -       if (!strcasecmp(name, "utf-8") || !strcasecmp(name, "utf8"))
> +       if (same_utf_encoding("utf-8", name))
>                 return 1;
>         return 0;
>  }
> @@ -414,6 +430,8 @@ int same_encoding(const char *src, const char *dst)
>  {
>         if (is_encoding_utf8(src) && is_encoding_utf8(dst))
>                 return 1;
> +       if (same_utf_encoding(src, dst))
> +               return 1;
>         return !strcasecmp(src, dst);
>  }

This seems odd. I would have expected the newly-added generalized
conditional to replace the original UTF-8-specific conditional, not
supplement it. That is, shouldn't the entire function body be:

    if (same_utf_encoding(src, dst))
        return 1;
    return !strcasecmp(src, dst);

?
