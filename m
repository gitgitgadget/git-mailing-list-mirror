Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id B438C1F404
	for <e@80x24.org>; Wed, 27 Dec 2017 22:19:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752004AbdL0WTt (ORCPT <rfc822;e@80x24.org>);
        Wed, 27 Dec 2017 17:19:49 -0500
Received: from mail-yw0-f172.google.com ([209.85.161.172]:44956 "EHLO
        mail-yw0-f172.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751871AbdL0WTs (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 27 Dec 2017 17:19:48 -0500
Received: by mail-yw0-f172.google.com with SMTP id m129so7968392ywb.11
        for <git@vger.kernel.org>; Wed, 27 Dec 2017 14:19:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=1VnQ7UzFJRZ9xXR4saZzpjI3aK/4Pr0BaRm2JXHN2NA=;
        b=l5wirpOoiZNpOc0Bjh2EGiqNQxgTxXNHG+yVNPzCWCtZTxF5pswvHBKleIcSH3LuPe
         6rPL2Xjp3te6yH/GFqmiI7wtgN7Kf8J7KFIJDFO5bZ7TvTu0XQZp3iOcZ0h3MFgmHo9A
         WCk6iILXIRDh6H2EDE9WINQzv6hwM9yC/fPn9jXLAczog7/cPkjpOmCUvaAAJXGIThbn
         IC8vX+iG69N4PIz+MaMpo4vtr+Hzxao/8GXZx/NJf0eeSN/hbwEdJL83S1B7YAM/W3Lm
         TzS4QBD2Z8aBU1v3AVyGqulPd06XmDZksKLuOS+n/Y8fntMFbj3ce8rWLA1sRcXnshgW
         NVlg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=1VnQ7UzFJRZ9xXR4saZzpjI3aK/4Pr0BaRm2JXHN2NA=;
        b=UX6FkDqCWNPkYAh4v+a5zB2zs9LyV3GYYOeQ9WxF28Jb7kUHknOLCF1Y1zfyLiSGKN
         z3d+9dpa5Sa7IDnQIkYuhxmqVBeoO34HPjT2Ujg6+eARixm03bIHOfjGWW19gxuMtad/
         7ZQRZ2jXSdce3aOA36c1Ifrs3SQm/A/cGklmnUohklo2dAcP759ywSChjS0jl5M45D4U
         M570ElmM+4sTXcjH/tzBrzS3O6dirqImxYBmIdwgI2MYm9sJGvHhiJ2/16J0K2n1ELiE
         SsXLfDmd3fB+VktlhxeRpP2yKq6FbGSCNubFtjJeA52shfYIRjEk4l6AoqdKLFBauJBO
         KhJg==
X-Gm-Message-State: AKGB3mJZndBtR9iLeLe//YvB8X6o8WJtNrY359ti4H82RYA8/GmPgBGg
        dIEqLoHOlvF/VDqMgZKvYKRLMM2rErPl2T3j36M=
X-Google-Smtp-Source: ACJfBovH4drNaVZDmkd71wk8bEoAsvxbK3EqxNZVoDCqCvRTKyHG+v8+kbE/y3DrpKo1I4wHVvQGAWOzHzlu70/Ao8A=
X-Received: by 10.129.128.66 with SMTP id q63mr20407969ywf.411.1514413188188;
 Wed, 27 Dec 2017 14:19:48 -0800 (PST)
MIME-Version: 1.0
Received: by 10.129.172.93 with HTTP; Wed, 27 Dec 2017 14:19:27 -0800 (PST)
In-Reply-To: <da288dac49ac1e54db99349a50a7cd684956671c.1513986836.git.johannes.schindelin@gmx.de>
References: <cover.1513986836.git.johannes.schindelin@gmx.de> <da288dac49ac1e54db99349a50a7cd684956671c.1513986836.git.johannes.schindelin@gmx.de>
From:   Liam Beguin <liambeguin@gmail.com>
Date:   Wed, 27 Dec 2017 23:19:27 +0100
Message-ID: <CAKm4OoX+S47iQnBogvU9j4k3pUBtn0uVWkjOKt-M+D6-O+4BzA@mail.gmail.com>
Subject: Re: [PATCH 5/5] sequencer: do not invent whitespace when transforming OIDs
To:     Johannes Schindelin <johannes.schindelin@gmx.de>
Cc:     Git mailing list <git@vger.kernel.org>,
        Junio C Hamano <gitster@pobox.com>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Johannes,

On 23 December 2017 at 00:56, Johannes Schindelin
<johannes.schindelin@gmx.de> wrote:
> For commands that do not have an argument, there is no need to append a
> trailing space at the end of the line.
>
> Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
> ---
>  sequencer.c | 5 ++++-
>  1 file changed, 4 insertions(+), 1 deletion(-)
>
> diff --git a/sequencer.c b/sequencer.c
> index 5632415ea2d..970842e3fcc 100644
> --- a/sequencer.c
> +++ b/sequencer.c
> @@ -2584,7 +2584,10 @@ int transform_todos(unsigned flags)
>                         strbuf_addf(&buf, " %s", oid);
>                 }
>                 /* add all the rest */
> -               strbuf_addf(&buf, " %.*s\n", item->arg_len, item->arg);
> +               if (!item->arg_len)
> +                       strbuf_addch(&buf, '\n');
> +               else
> +                       strbuf_addf(&buf, " %.*s\n", item->arg_len, item->arg);

I also went with that when I was working on this but I thought leaving the
extra whitespace would make the code a little shorter.
Other than that, this change and the others look good.

>         }
>
>         i = write_message(buf.buf, buf.len, todo_file, 0);
> --
> 2.15.1.windows.2

Thanks,
Liam
