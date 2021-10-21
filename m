Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 882FEC433F5
	for <git@archiver.kernel.org>; Thu, 21 Oct 2021 16:13:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6D00A610EA
	for <git@archiver.kernel.org>; Thu, 21 Oct 2021 16:13:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231753AbhJUQPb (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 21 Oct 2021 12:15:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36040 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229702AbhJUQP3 (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 21 Oct 2021 12:15:29 -0400
Received: from mail-pj1-x1029.google.com (mail-pj1-x1029.google.com [IPv6:2607:f8b0:4864:20::1029])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 01C9EC061764
        for <git@vger.kernel.org>; Thu, 21 Oct 2021 09:13:13 -0700 (PDT)
Received: by mail-pj1-x1029.google.com with SMTP id nn3-20020a17090b38c300b001a03bb6c4ebso915748pjb.1
        for <git@vger.kernel.org>; Thu, 21 Oct 2021 09:13:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=OmUAOm/jZvBTisko2odBmiqnoJRlaZxoVjRczJbFoI8=;
        b=Ucw6s78z0mAg1A4w44FkppbAmCy28tgcyE2MMn+/Sse56yb2YeszgMrha7L+Vk/whL
         8uhavoDCxHh4LZDtyVhLuI2VyYGGa3zpZ1ToU3lg6DiYLbipTkhm9jg79eSZb1rzrvfA
         KboAgn64MWBzgs6kt8BatCTC/7IspvHWUh/+r3L66tJy1OxSYl5X8Ezz6UEcrVUIlEqw
         PE08baryC3AJsb5VXIFRm5+vRe/z++b4ViojzLhFWvz5/6o0HxNQcKn6y9UMPa1fiheC
         Jd91iJ4H1dEmIBzZe8OBwI5Y8vGje/02wwGDqSknGUwczTvMhdncI/UXBg8S2PlEbLUl
         LB9w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=OmUAOm/jZvBTisko2odBmiqnoJRlaZxoVjRczJbFoI8=;
        b=3D+QYx398EQ/TIoqvh3pF1pgJJJKFqY3uQbWO4yLm/+F+dlqtx/e1IRivEMtsXH6Pa
         moKrOmZ2aBlS8AXRdMg4dz6bZuILKr89OUFORntRxQsM7SBOp2L6Nvw+8KUssHELJr9L
         /usPOwa3szVxFPfVsBYuO6WIvNDElmxccFeeJqaRl9QYEMtgScQsLF1pAOQdeiyjlEnT
         sVWhMHH3WGar8S2VoP3eKE7ID9O00WWuD//njLGsWrK/5yBAbLH5vNDnBzlU1bFJ6uwE
         7N6+ngII9+BflqDKKB/mcH2giPE7aaRJJRz0sFxenvVrSLQmj7KtGw4CM/aAo1e52Ogk
         LYuQ==
X-Gm-Message-State: AOAM533U5sYoE/EbNnE/p7zqFfjfALC8bniDdTkHAjbR4ZU3OMqNfM7h
        3eZFVlyOTU7xU7TMz0wfn4EwhqazhL1PckQdyguKkmTsi6Q=
X-Google-Smtp-Source: ABdhPJwi8NKWO51NKNbKOL3oxWvdHqf07KSu9pWC6e4RJZmaE/7TbuifbvxAqmKUHyhm7F4uO7nVdf4EZ/G65z5mnl8=
X-Received: by 2002:a17:902:ea09:b0:13f:ac2:c5ae with SMTP id
 s9-20020a170902ea0900b0013f0ac2c5aemr6012346plg.3.1634832792532; Thu, 21 Oct
 2021 09:13:12 -0700 (PDT)
MIME-Version: 1.0
References: <patch-1.1-5a47bf2e9c9-20211021T114223Z-avarab@gmail.com>
In-Reply-To: <patch-1.1-5a47bf2e9c9-20211021T114223Z-avarab@gmail.com>
From:   =?UTF-8?Q?Martin_=C3=85gren?= <martin.agren@gmail.com>
Date:   Thu, 21 Oct 2021 18:13:00 +0200
Message-ID: <CAN0heSqA4uqWahWKTa0ZLBCnFLG4jxEx+18aVQUieX0f6dzWMw@mail.gmail.com>
Subject: Re: [PATCH] leak tests: free() before die for two API functions
To:     =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>
Cc:     Git Mailing List <git@vger.kernel.org>,
        Junio C Hamano <gitster@pobox.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, 21 Oct 2021 at 13:43, =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason <avara=
b@gmail.com> wrote:
>
> Call free() just before die() in two API functions whose tests are
> asserted under SANITIZE=3Dleak. Normally this would not be needed due to
> how SANITIZE=3Dleak works, but in these cases my GCC version (10.2.1-6)
> will fail tests t0001 and t0017 under SANITIZE=3Dleak depending on the
> optimization level.

Seems a bit unfortunate. I have to wonder why these in particular
trigger this compiler bug or whatever it is, but oh well.

> -       if (check_refname_format(full_ref, 0))
> +       if (check_refname_format(full_ref, 0)) {
> +               free(ret);
> +               free(full_ref);
>                 die(_("invalid branch name: %s =3D %s"), config_display_k=
ey, ret);
> +       }
>         free(full_ref);

This looks like use-after-free. Rather than complicating this by, e.g.,
first formatting the string, then freeing `ret`, then dying, could we --
if we really want this workaround -- make the workaround be `UNLEAK`
instead?

Also, if we do something like this patch, I think we should try to avoid
this free-before-die then being cargo-culted all across the codebase.
How about

  UNLEAK(ret); /* work around compiler bug */
  UNLEAK(full_ref); /* work around compiler bug */

or something?

Martin
