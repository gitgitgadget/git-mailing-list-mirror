Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E6F98C433F5
	for <git@archiver.kernel.org>; Wed, 10 Nov 2021 19:05:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C9C4761027
	for <git@archiver.kernel.org>; Wed, 10 Nov 2021 19:05:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233658AbhKJTIL (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 10 Nov 2021 14:08:11 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47224 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233620AbhKJTIF (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 10 Nov 2021 14:08:05 -0500
Received: from mail-lf1-x136.google.com (mail-lf1-x136.google.com [IPv6:2a00:1450:4864:20::136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8B159C04C325
        for <git@vger.kernel.org>; Wed, 10 Nov 2021 11:00:34 -0800 (PST)
Received: by mail-lf1-x136.google.com with SMTP id br15so4573229lfb.9
        for <git@vger.kernel.org>; Wed, 10 Nov 2021 11:00:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=C4qs3nVJ+TVmRAD/Dlo45TPfkdrzLZEeNImYXKoc4L4=;
        b=BeaW1rHCUdZ0b/4zyOatHJSk/00wE71R9nXIbKmJS8V1qxZSPUQj5viuLcV99L+ypr
         v7QbbOvjhzK4s3vIM8TFA1Pq/Yco9yfxxcCzukTlcAH5hk5q86Ib4SmakI2mGTM9CRlQ
         wWgeYEKMK4CTpXC61C82yC7h1aQvaaoC8UxjBmXw5Rqo6EQoGHd0M5x0fZ3mSSy5HayQ
         Rktev/qDzXm1J4+B5a6bvAMCf1lE6ZjsFU4ABDq8LFZk7QZfaAJX0cKi1CF9DFE/9Jbr
         uY1EnM97FVu0oHDHXdiwC5TI0rCV/WeR0jJmTFb017ALWE68gwFtLl80eut+EfBwWU4a
         0Rqg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=C4qs3nVJ+TVmRAD/Dlo45TPfkdrzLZEeNImYXKoc4L4=;
        b=3U1BaL6GdEguTe2uIdVHqbyhIyVNuT5y1MCiNglJbJSOvWpmMpm+8vBj2zwJHH65Gq
         HBl1j9rsJos8RIqFHhxguxAYPl4AraDaEL/CjP872KG4p7qDMqTf0r9Mn4zbQ1VOuI8e
         W/DpveRss0UgfZKIV71QxDQ+SCZa7jj60BGG3baFXTXZdDCbVUhUUGEmBbsBGW03xeCR
         TfCfXqPMVOJxRCbiINQy62pQ9X51BaYyc5pXKKhmrBNi3chtdYYadC5/Y7ZeoYQdpzEp
         3d5FeP4HvO8vSnARu+rReMr2cbzkdShp/yE8LyLtTofBs/wQwmhFKN8FXJk163asyzBU
         t8SA==
X-Gm-Message-State: AOAM532CQNOHX5WWQPXHRopNSnNAB2zIOPGqKyIDL9OehBlAWWVeyfZO
        CZbmIcp+XzYj8VJIWZBkE1yhCCHzGN1KlKQOVCg=
X-Google-Smtp-Source: ABdhPJzvhDqz8wQshkxgJRLdOLI8QOaYMIhuMEk7KRUa/nOL5JwneVfChxSiFL0rTEwf1Q5tjnrQiNdxEXstTF537lA=
X-Received: by 2002:ac2:430d:: with SMTP id l13mr1239988lfh.656.1636570832848;
 Wed, 10 Nov 2021 11:00:32 -0800 (PST)
MIME-Version: 1.0
References: <xmqqy25wygek.fsf@gitster.g> <nycvar.QRO.7.76.6.2111101402240.21127@tvgsbejvaqbjf.bet>
 <xmqqpmr8x6zn.fsf@gitster.g>
In-Reply-To: <xmqqpmr8x6zn.fsf@gitster.g>
From:   Alex Henrie <alexhenrie24@gmail.com>
Date:   Wed, 10 Nov 2021 12:00:20 -0700
Message-ID: <CAMMLpeS3Lerps8ioO7Ap=Cs29dDssp5F-KgvENkN5qDg+tZXxQ@mail.gmail.com>
Subject: Re: jc/fix-pull-ff-only-when-already-up-to-date, was Re: What's
 cooking in git.git (Nov 2021, #03; Tue, 9)
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Git mailing list <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Nov 10, 2021 at 10:21 AM Junio C Hamano <gitster@pobox.com> wrote:
>
> Johannes Schindelin <Johannes.Schindelin@gmx.de> writes:
>
> > On Tue, 9 Nov 2021, Junio C Hamano wrote:
> >
> >> * jc/fix-pull-ff-only-when-already-up-to-date (2021-10-29) 1 commit
> >>   (merged to 'next' on 2021-10-29 at ad4753e668)
> >>  + pull: --ff-only should make it a noop when already-up-to-date
> >>
> >>  "git pull --ff-only" and "git pull --rebase --ff-only" should make
> >>  it a no-op to attempt pulling from a remote that is behind us, but
> >>  instead the command errored out by saying it was impossible to
> >>  fast-forward, which may technically be true, but not a useful thing
> >>  to diagnose as an error.  This has been corrected.
> >>
> >>  Will cook in 'next'.
> >
> > I would like to register a vote for advancing this into v2.34.0,
> > still.
>
> I didn't recall I did it as a regression fix, but as a fix for
> relatively old change that is already in released version(s) in the
> field.  If the breakage is new between 2.33.0 and 'master', I think
> it is a good idea to merge it down.

For what it's worth, I also consider this to be a (small) regression
introduced in 2.33.0. So I'd also like to vote for fixing it in 2.34.

-Alex
