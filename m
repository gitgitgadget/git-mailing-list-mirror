Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-12.0 required=3.0 tests=AWL,BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,USER_IN_DEF_DKIM_WL
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id C6C731F453
	for <e@80x24.org>; Mon, 28 Jan 2019 23:25:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727000AbfA1XY7 (ORCPT <rfc822;e@80x24.org>);
        Mon, 28 Jan 2019 18:24:59 -0500
Received: from mail-lj1-f195.google.com ([209.85.208.195]:45987 "EHLO
        mail-lj1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726750AbfA1XY7 (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 28 Jan 2019 18:24:59 -0500
Received: by mail-lj1-f195.google.com with SMTP id s5-v6so15791019ljd.12
        for <git@vger.kernel.org>; Mon, 28 Jan 2019 15:24:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=TiMdpcM1+OA4cA3ECBe0mn9/+k5NUoMmv5+sS8fgNy0=;
        b=iQdO4lb+bq69pyp7/RtJFHPF3oMB453rwjrXR8FVHy+2LYbB6q1adBCcLI8CCj2IBl
         +5b+m/ZXq0lt6WKMkfeaQGkdYHl3Eia7UWO4Jp/YMY+6kwyWgLxryUjelW+uSJ2BFLOQ
         uGJcgZ/xgTvwr52bRX0rbHpqAVAnPRC8AkyMHmUvnVTRSM7/MqyVTVb21wbqudFrAOkC
         vhxvo1R8f70/GNmoRamKzN7W44TW5P9dsn+cFPlyJtvPZbvdo1Y/tMp8BFM8ME9r7BiV
         XZu6kp7kA15VqfszTpFqMK8csXCtrznhAyeeYo0Ge+T+z2pPl+hNdHwf2RfcKkMc+IZo
         jEIA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=TiMdpcM1+OA4cA3ECBe0mn9/+k5NUoMmv5+sS8fgNy0=;
        b=tNFTVWO0rGdZnQTpdU+EImQ0bGsOwv9bxljrTtAKNTyFEznrWCYV5hE6Efi+8Hn412
         eNH9cmvMU5ttGjtbEAaQxWO4laDL5vroDzqNxxgzYPrNBwzzOMLkTjkO7IS1+cxuev/Y
         8DydivgXHEbwrO9Z6hoOBiwcQWt69QCNqxRE77iNu+XOCG90uvxkrxOXXPG/qMo4W9te
         iLePjeBZ4em+XPWGqB7u/GwPkMyY4Eq32lal515DTUBtrDRpshZKZp8s/uIGD052ti2m
         mY/Lu2/TuwUsmdoI+liYfwY9wx3GvjLypwUH/a8LONBjBC+bztJFvVpCPPmgLu8FFQwx
         AExQ==
X-Gm-Message-State: AJcUukdXNAVLUbyFRvjvqB/bXaK/VU8g9SIGAFjRJk9sZ9qgh1pHEANv
        hxgzsWGd3iC1Pjv1Z6+t+XQ0cM2aUS7yL8YgrFb21w==
X-Google-Smtp-Source: ALg8bN4FASbPUio4IClJG8EGyYGeWnkk8C36wOKlJjb0LPKGZyJvCAwDkJjS8YRzkzmjONOgMiNs+RR0tpxK+0QeXFE=
X-Received: by 2002:a2e:4218:: with SMTP id p24-v6mr18653948lja.58.1548717896885;
 Mon, 28 Jan 2019 15:24:56 -0800 (PST)
MIME-Version: 1.0
References: <20190127194415.171035-1-sxenos@google.com> <20190127194415.171035-5-sxenos@google.com>
 <nycvar.QRO.7.76.6.1901280858060.41@tvgsbejvaqbjf.bet> <nycvar.QRO.7.76.6.1901290005390.41@tvgsbejvaqbjf.bet>
In-Reply-To: <nycvar.QRO.7.76.6.1901290005390.41@tvgsbejvaqbjf.bet>
From:   Stefan Xenos <sxenos@google.com>
Date:   Mon, 28 Jan 2019 15:24:45 -0800
Message-ID: <CAPL8ZiuKnvQd1tpbsT+xn2Dt0rMs_ggQKOSz_vMda3i1V1YfHQ@mail.gmail.com>
Subject: Re: [PATCH v3 5/8] evolve: Add the change-table structure
To:     Johannes Schindelin <Johannes.Schindelin@gmx.de>
Cc:     git <git@vger.kernel.org>, Junio C Hamano <gitster@pobox.com>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Sorry, folks. I normally can't do any open source work on weekdays.
That also includes writing responses on the mailing list, so there
will normally be a week or two lag for me to iterate on this sort of
thing.

Feel free to either include this fix or revert my patch if there's a
problem with it - just let me know what you selected. I'll roll with
it and either resubmit with the requested changes or submit the
requested changes as follow-ups.

  - Stefan

On Mon, Jan 28, 2019 at 3:08 PM Johannes Schindelin
<Johannes.Schindelin@gmx.de> wrote:
>
> Hi Junio,
>
> On Mon, 28 Jan 2019, Johannes Schindelin wrote:
>
> > On Sun, 27 Jan 2019, sxenos@google.com wrote:
> >
> > > +   new_item->util = (void*)index;
> >
> > This is not good. You are using a `long` here. The 80s called and want
> > their now-obsolete data types back.
> >
> > If you want a data type that can take an integer but also a pointer, use
> > `intptr_t` instead.
> >
> > But even that is not good practice. What you really want here is to use a
> > union of the data types that you want to store in that `util` field.
> >
> > This is not merely academic, your code causes compile errors on Windows:
> >
> > https://dev.azure.com/gitgitgadget/git/_build/results?buildId=400&view=logs&jobId=fd490c07-0b22-5182-fac9-6d67fe1e939b&taskId=ce91d5d6-0c55-50f5-8ab9-6695c03ab102&lineStart=430&lineEnd=440&colStart=1&colEnd=1
>
> Since Stefan did not grace us with an answer, Junio, could I ask you to
> squash this in (which is by no means a satisfactory fix, but it is a
> stopgap to get `pu` building again)?
>
> -- snipsnap --
> diff --git a/change-table.c b/change-table.c
> index 2e0d935de846..197ce2783532 100644
> --- a/change-table.c
> +++ b/change-table.c
> @@ -103,7 +103,7 @@ void change_table_add(struct change_table *to_modify, const char *refname,
>         new_head->hidden = starts_with(refname, "refs/hiddenmetas/");
>
>         new_item = string_list_insert(&to_modify->refname_to_change_head, refname);
> -       new_item->util = (void*)index;
> +       new_item->util = (void *)(intptr_t)index;
>         // Use pointers to the copy of the string we're retaining locally
>         refname = new_item->string;
>
> @@ -201,6 +201,6 @@ struct change_head* get_change_head(struct change_table *heads,
>                 return NULL;
>         }
>
> -       index = (long)item->util;
> +       index = (long)(intptr_t)item->util;
>         return &(heads->heads.array[index]);
>  }
>
