Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 0E8EB1F404
	for <e@80x24.org>; Fri, 19 Jan 2018 18:26:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1756107AbeASS0j (ORCPT <rfc822;e@80x24.org>);
        Fri, 19 Jan 2018 13:26:39 -0500
Received: from mail-it0-f51.google.com ([209.85.214.51]:34907 "EHLO
        mail-it0-f51.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1755830AbeASS0i (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 19 Jan 2018 13:26:38 -0500
Received: by mail-it0-f51.google.com with SMTP id e1so3162575ita.0
        for <git@vger.kernel.org>; Fri, 19 Jan 2018 10:26:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=em1aWPbFRzxaJe0nDcK3hVJgGL9+zyx2eQ8ILkyBolY=;
        b=llo4S0BGwpYl+b7D+2U1jPODszB2tx2IzUsZpaIsqV5PaC52Z1H4HZSOeLckj1EWXX
         V2VHAfW2WHe8+C8kjAptPLtM55wB4JUoKg/yi2JSaDh+Ue4drWnSYK/A9RVwgFgDdOXv
         HkxTrvKlJ1UxPJYi1K6B6w+gG17erruqmgUS9Guw1RLO9A9BhzXWeE1VqrkMnjYRwM0S
         ACl4kwiNiOSMtQSduf3/IJO5vdtBhFw3HIjcmw9Bi6uDQeguyAZXWSbPUC8JSp2WqyOP
         pPY/ht+dt8driiBZFYZHpERltoVFhw7Bj8vDTmrHvaCF4Y+VgrEPryQaU3MCwcD9smmW
         qnrA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=em1aWPbFRzxaJe0nDcK3hVJgGL9+zyx2eQ8ILkyBolY=;
        b=k2ODh8csXVdeVPML5S3jjLNWA96tWgnekpKfKnbwCF3QUCSsGgl4TSnrIO0Kt+HP8F
         T+SpgaZIsyaOSC6tvImhYRaD/lY7QOVstThTA0vudcrKhCJUtps6GPo5WPOX8rFi6mWF
         YtAplNZ23JzURP2LOcng8F+d+J2Qt17kll/VTVQsDM2R3l90DzlyzzRU8DO5F8sc2a9T
         Dd7C4qAvA0p7u5kZ5+b3pP0HAQcZi13yZhMuDCMMKiFaaTBcspBK8SWBu9hkxqkUm1Mh
         nSexb88mL+xVwvWaA+WciIjPZjBFHG0+YNqgQnT/r9FgA6KWQQDfKQ0hKhd6WDiEhDta
         aHKg==
X-Gm-Message-State: AKwxytct6QFLsK1103gJudzaEZME63pY9IXBtF5mSDLO6kMIN7q13Wt1
        O1z0C7cx/Tp0Ft9kZpJ8G0ih5sd4eBuUJ67mqpw=
X-Google-Smtp-Source: ACJfBov4alYh6wLDIGjiZAeIFK6gxo7iO38hJ6ft/eqJcrFDMLVxV3Cn2ykFMiSwmvfhCmoz9/Dlh6pmqG7juDT7wR8=
X-Received: by 10.36.249.196 with SMTP id l187mr21744459ith.63.1516386397607;
 Fri, 19 Jan 2018 10:26:37 -0800 (PST)
MIME-Version: 1.0
Received: by 10.79.201.204 with HTTP; Fri, 19 Jan 2018 10:26:37 -0800 (PST)
In-Reply-To: <1516067185-1087-1-git-send-email-gs051095@gmail.com>
References: <1516067185-1087-1-git-send-email-gs051095@gmail.com>
From:   Christian Couder <christian.couder@gmail.com>
Date:   Fri, 19 Jan 2018 19:26:37 +0100
Message-ID: <CAP8UFD0oBfmwx6r8rFMLzCyhEoy6QMQ-5RHJv=2WavYgE9FSMQ@mail.gmail.com>
Subject: Re: [PATCH] mru: Replace mru.[ch] with list.h implementation
To:     Gargi Sharma <gs051095@gmail.com>
Cc:     git <git@vger.kernel.org>,
        =?UTF-8?B?0J7Qu9GPINCi0LXQu9C10LbQvdCw0Y8=?= 
        <olyatelezhnaya@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Jan 16, 2018 at 2:46 AM, Gargi Sharma <gs051095@gmail.com> wrote:
> Replace the custom calls to mru.[ch] with calls to list.h. This patch is the
> final step in removing the mru API completely and inlining the logic.

You might want to say that this provides a significant code reduction
which shows that the mru API is not a very useful abstraction anymore.

> Another discussion, here
> (https://public-inbox.org/git/CAOCi2DGYQr4jFf5ObY2buyhNJeaAPQKF8tbojn2W0b18Eo+Wgw@mail.gmail.com/)
> was on what has to be done with the next pointer of packed git type

I think using "pointer to a 'struct packed_git'" instead of "pointer
of packed git type" would be clearer here, but anyway see below.

> inside the
> packed_git structure. It can be removed _given_ that no one needs to
> access the list in order and can be sent as another patch.

I don't think it's worth pointing to a discussion about a future
improvement in the commit message. You could perhaps even remove all
the above paragraph as this commit is valuable and self contained
enough by itself.

> ---
> Changes in v2:
>         - Add a move to front function to the list API.
>         - Remove memory leak.
>         - Remove redundant remove operations on the list.
>
> The commit has been built on top of ot/mru-on-list branch.

Nice!

>  Makefile               |  1 -
>  builtin/pack-objects.c | 12 ++++++------
>  cache.h                |  9 +++++----
>  list.h                 |  7 +++++++
>  mru.c                  | 27 ---------------------------
>  mru.h                  | 40 ----------------------------------------
>  packfile.c             | 18 +++++++++---------
>  sha1_file.c            |  1 -
>  8 files changed, 27 insertions(+), 88 deletions(-)
>  delete mode 100644 mru.c
>  delete mode 100644 mru.h

Very nice!

[...]

> @@ -1030,8 +1029,9 @@ static int want_object_in_pack(const unsigned char *sha1,
>                                 *found_pack = p;
>                         }
>                         want = want_found_object(exclude, p);
> -                       if (!exclude && want > 0)
> -                               mru_mark(&packed_git_mru, entry);
> +                       if (!exclude && want > 0) {
> +                               list_move_to_front(&p->mru, &packed_git_mru);
> +                       }

Style: we usually remove brackets when there is one line after the
if(...) line. (See the 2 lines that you delete.)

Otherwise the patch looks good to me.

Thanks,
Christian.
