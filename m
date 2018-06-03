Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.5 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id E83131F403
	for <e@80x24.org>; Sun,  3 Jun 2018 17:13:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751342AbeFCRNR (ORCPT <rfc822;e@80x24.org>);
        Sun, 3 Jun 2018 13:13:17 -0400
Received: from mail-pg0-f68.google.com ([74.125.83.68]:34301 "EHLO
        mail-pg0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750996AbeFCRNP (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 3 Jun 2018 13:13:15 -0400
Received: by mail-pg0-f68.google.com with SMTP id k2-v6so13376606pgc.1
        for <git@vger.kernel.org>; Sun, 03 Jun 2018 10:13:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=TTY8w5Q/ZAlbAuhcpHXA+jOjFdmNTd7wCNiy8YCXP7U=;
        b=E5wls4rKCdcNApBPE4ekssgUuGfr/sHiJ+976EddCn3NQY1AIqLmccQl1dyohvFzdw
         7huT0GYFjtrWkM4PlpFoqJ6Le9xGL+QsHWGnnB8VhuIhUeOzsXAWMqDp8ChbZe6Yf/6A
         TW9TpqRNozO2AHU9u+tgjebd8JpKw/IYW3x1p9kKiGw0Mns+hehwFg3CjagCSycFhjFN
         xlz7iy13FcXsbujY7Xf2fo1Z99qRZN0Jjy1zzGyNXK2JKMTbSKRa98oAO6kFMzXFWJto
         raG2/F1XVUfhfo6nMCEyVL/ZeJrgqsghPC/BtvX+24rUTsqwsvfMfL3ASqQ3HbeXh5rG
         MoEA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=TTY8w5Q/ZAlbAuhcpHXA+jOjFdmNTd7wCNiy8YCXP7U=;
        b=Rv3V8LJqt0/S/TdFCwQco3VVVuKhn/qRQrJtZNj5L/uCnFc2KldpdMIizPxHltjU2l
         QAiVFThEOKrURxnXUg/qKq+fElZDEdrwH+wi73iYE096Qw97Yyr+5Ix67H4U1Y9AggGM
         xsZ8zpSfpoDboBIC65CULF+Tx1Mt8RUR5O+PLZhopSBDjeuHqAZ3MFBHTEHqAI3NjbAB
         EerQsOEZlVMYfOqrtxZ0GPqOO/SepyhZ+LhUNxrYaBjLz++L7a9Wj/5Tp9lzzWDypYcE
         0XbgaT2o1BN5I5XHfcHFeHoYNuUb2q6oK9qfFOCVGz2wlQOeISAyC6dF2v2EOj2D6gTT
         OSgQ==
X-Gm-Message-State: ALKqPwflrm1XIh19cIyyG+qaVfhgcOHvBhxsDY80+s42J9KHwLTdMO2Z
        hcagZH3snJJ3tZt7DXAzW3HeE2qc5VTmSzVgSiHFiP/c
X-Google-Smtp-Source: ADUXVKIfpirvGp+1jN+r3D0+f6/3mPA0IJBq/OXkpoTwmNhLvqD7ZLb6bzhnNU81GEml5vSC5P98r2EyuujmX+64c8s=
X-Received: by 2002:a62:da59:: with SMTP id w25-v6mr13625182pfl.161.1528045995520;
 Sun, 03 Jun 2018 10:13:15 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a17:90a:760e:0:0:0:0 with HTTP; Sun, 3 Jun 2018 10:13:14
 -0700 (PDT)
In-Reply-To: <20180516225823.235426-6-bmwill@google.com>
References: <20180514215626.164960-1-bmwill@google.com> <20180516225823.235426-1-bmwill@google.com>
 <20180516225823.235426-6-bmwill@google.com>
From:   =?UTF-8?Q?Martin_=C3=85gren?= <martin.agren@gmail.com>
Date:   Sun, 3 Jun 2018 19:13:14 +0200
Message-ID: <CAN0heSr6dPa+--Mut0+3Zgy-mWF0d2762vKU=d08CKhR8BnKmA@mail.gmail.com>
Subject: Re: [PATCH v2 05/36] refspec: convert valid_fetch_refspec to use parse_refspec
To:     Brandon Williams <bmwill@google.com>
Cc:     Git Mailing List <git@vger.kernel.org>,
        =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>,
        Junio C Hamano <gitster@pobox.com>,
        Stefan Beller <sbeller@google.com>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Brandon,

On 17 May 2018 at 00:57, Brandon Williams <bmwill@google.com> wrote:
> Convert 'valid_fetch_refspec()' to use the new 'parse_refspec()'
> function to only parse a single refspec and eliminate an allocation.
>
> Signed-off-by: Brandon Williams <bmwill@google.com>
> ---
>  refspec.c | 17 ++++++++---------
>  refspec.h |  3 ++-
>  2 files changed, 10 insertions(+), 10 deletions(-)
>
> diff --git a/refspec.c b/refspec.c
> index af9d0d4b3..ab37b5ba1 100644
> --- a/refspec.c
> +++ b/refspec.c
> @@ -146,15 +146,6 @@ static struct refspec_item *parse_refspec_internal(int nr_refspec, const char **
>         die("Invalid refspec '%s'", refspec[i]);
>  }
>
> -int valid_fetch_refspec(const char *fetch_refspec_str)
> -{
> -       struct refspec_item *refspec;
> -
> -       refspec = parse_refspec_internal(1, &fetch_refspec_str, 1, 1);
> -       free_refspec(1, refspec);
> -       return !!refspec;
> -}
> -
>  struct refspec_item *parse_fetch_refspec(int nr_refspec, const char **refspec)
>  {
>         return parse_refspec_internal(nr_refspec, refspec, 1, 0);
> @@ -242,3 +233,11 @@ void refspec_clear(struct refspec *rs)
>
>         rs->fetch = 0;
>  }
> +
> +int valid_fetch_refspec(const char *fetch_refspec_str)
> +{
> +       struct refspec_item refspec;
> +       int ret = parse_refspec(&refspec, fetch_refspec_str, REFSPEC_FETCH);
> +       refspec_item_clear(&refspec);
> +       return ret;
> +}

My compiler warned about this function. The `dst` and `src` pointers
will equal some random data on the stack, then they may or may not be
assigned to, then we will call `free()` on them.

At least I *think* that we "may or may not" assign to them. I don't have
much or any time to really dig into this right now unfortunately.

I suppose this could use a REFSPEC_ITEM_INIT, or a memset inside
`parse_refspec()`, but I am very unfamiliar with this code.

Martin
