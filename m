Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RCVD_IN_SORBS_SPAM,RP_MATCHES_RCVD shortcircuit=no autolearn=no
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id D44502035A
	for <e@80x24.org>; Mon, 10 Jul 2017 02:51:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753128AbdGJCvQ (ORCPT <rfc822;e@80x24.org>);
        Sun, 9 Jul 2017 22:51:16 -0400
Received: from mail-pg0-f43.google.com ([74.125.83.43]:33000 "EHLO
        mail-pg0-f43.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753056AbdGJCvQ (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 9 Jul 2017 22:51:16 -0400
Received: by mail-pg0-f43.google.com with SMTP id k14so42096142pgr.0
        for <git@vger.kernel.org>; Sun, 09 Jul 2017 19:51:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=+HtfT7RYotbEMijN7RfoImoduJ4H4Fa3Ufl9mJhlwDk=;
        b=DSJuFmAoOux8fCkIF6ZtIZb0If02co+hJLCh0SKeODGgZwmTGAZfMjnu8C6lc2OAXI
         UKN+c6hXWNbhR7rPI+v2UKC2Qzi6e6C5RBDDwm5hgd9r+8UhstoW1zBGkgXXwDvNWBjG
         6lh4OSEzbwjLh4xuWBFR4AQY3esyiAtjfQAtK0KtqClI1Kr3cFgdjVqFGZ8YQkrx+9U1
         LJ3HQOZHIkI4UFEosjzw0RZSaLkCJbaZiQRHn04961Zv18MdOahRZa8F/96Cf8SrytHr
         gW5y0ODGxFEo/EU/vMdUJrFSJy2kkFGc1PxGqZu/gU8fjYcol9Ih7CssqxHCDVgTdZ/c
         E6yw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=+HtfT7RYotbEMijN7RfoImoduJ4H4Fa3Ufl9mJhlwDk=;
        b=qbKGFrEMHxZXN+KohQVAeQw10snLo2ze1ZsV7QgN+YCn7p/0mPcBFk5ooU+Ve+KC5m
         yjdwCtqDU82YrpRxMGTGCfBotDE+gvTt7Qy0pRlFiwLK5p9v4NjES64wbTKpPpXDoJUt
         LLInxBzs/Pg5iSpBCN1RnNVzByXrqG52hHVHcBdYAZVo52O5QrzxAZRpxHmBgVXzGROX
         9FsaFSvqawrTCi84NIaj991/tUwObvrXqPUA4vk9zeUY6jruTLlio4F2JYbg5BlHiYxo
         rO7uVL36JjI30U6BnR5NE9BxUNLMEHMln1pDbneigQSrPx03ijGi+02djmkY2Cr5LqJo
         2NoA==
X-Gm-Message-State: AIVw1134kXf/hvR+XUZjzM13VuLtR5CY5AIDtoQ47AqmEXY+BFw1ihyl
        s4oaHtchbcZNVdgdb8VRsrcTCuXwqfYRQa4=
X-Received: by 10.98.81.1 with SMTP id f1mr8862049pfb.94.1499655075335; Sun,
 09 Jul 2017 19:51:15 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.100.183.170 with HTTP; Sun, 9 Jul 2017 19:51:14 -0700 (PDT)
In-Reply-To: <d70bf87c-f8b3-9f02-14bd-b3ceb5e9f7e4@web.de>
References: <d70bf87c-f8b3-9f02-14bd-b3ceb5e9f7e4@web.de>
From:   Stefan Beller <sbeller@google.com>
Date:   Sun, 9 Jul 2017 19:51:14 -0700
Message-ID: <CAGZ79kZgJpLttFOT01XOD-dj8Ag6A_1kkwGngbH2MMaO=_F-NA@mail.gmail.com>
Subject: Re: [PATCH] wt-status: use separate variable for result of shorten_unambiguous_ref
To:     =?UTF-8?Q?Ren=C3=A9_Scharfe?= <l.s.r@web.de>
Cc:     Git List <git@vger.kernel.org>, Junio C Hamano <gitster@pobox.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Sat, Jul 8, 2017 at 3:51 AM, Ren=C3=A9 Scharfe <l.s.r@web.de> wrote:
> Store the pointer to the string allocated by shorten_unambiguous_ref in
> a dedicated variable, short_base, and keep base unchanged.  A non-const
> variable is more appropriate for such an object.  It avoids having to
> cast const away on free and stops redefining the meaning of base, making
> the code slightly clearer.
>
> Signed-off-by: Rene Scharfe <l.s.r@web.de>

Thanks,
Reviewed-by: Stefan Beller <sbeller@google.com>

> ---
>  wt-status.c | 7 ++++---
>  1 file changed, 4 insertions(+), 3 deletions(-)
>
> diff --git a/wt-status.c b/wt-status.c
> index 8d2fb35b08..77c27c5113 100644
> --- a/wt-status.c
> +++ b/wt-status.c
> @@ -1763,6 +1763,7 @@ static void wt_shortstatus_print_tracking(struct wt=
_status *s)
>         const char *branch_color_remote =3D color(WT_STATUS_REMOTE_BRANCH=
, s);
>
>         const char *base;
> +       char *short_base;
>         const char *branch_name;
>         int num_ours, num_theirs;
>         int upstream_is_gone =3D 0;
> @@ -1797,10 +1798,10 @@ static void wt_shortstatus_print_tracking(struct =
wt_status *s)
>                 upstream_is_gone =3D 1;
>         }
>
> -       base =3D shorten_unambiguous_ref(base, 0);
> +       short_base =3D shorten_unambiguous_ref(base, 0);
>         color_fprintf(s->fp, header_color, "...");
> -       color_fprintf(s->fp, branch_color_remote, "%s", base);
> -       free((char *)base);
> +       color_fprintf(s->fp, branch_color_remote, "%s", short_base);
> +       free(short_base);
>
>         if (!upstream_is_gone && !num_ours && !num_theirs)
>                 goto conclude;
> --
> 2.13.2
>
