Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E8B3CC433B4
	for <git@archiver.kernel.org>; Mon,  3 May 2021 14:12:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9FD3B61040
	for <git@archiver.kernel.org>; Mon,  3 May 2021 14:12:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234125AbhECONE (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 3 May 2021 10:13:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45386 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229900AbhECONE (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 3 May 2021 10:13:04 -0400
Received: from mail-lj1-x22d.google.com (mail-lj1-x22d.google.com [IPv6:2a00:1450:4864:20::22d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E8436C06174A
        for <git@vger.kernel.org>; Mon,  3 May 2021 07:12:10 -0700 (PDT)
Received: by mail-lj1-x22d.google.com with SMTP id l22so6914350ljc.9
        for <git@vger.kernel.org>; Mon, 03 May 2021 07:12:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=usp.br; s=usp-google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Ub84RjrgRQ/+ADeAciNS4+kLgr6EKGpTc1uD1atTvpc=;
        b=nAyPl7+dBMHQIV+rmgPEnUkFFdwRB/bxSpGm8aLSbbMfMy+yfd2GOIfNGz11JygUiR
         8bF9LDe5D/OyhJ2nWJUs32sn9gU18qrAU61Gpn6aAfzS1S/8FKD5J4t6pxERk5ynuWpt
         JsUpriz+dtlxdLvEJFbKNnCDMdBedNXe2x+zosOxKDl2Xm/5D4cXpWt2UWhnJ0+J8jZV
         S63VWGhcqy3vnB0j9ZrhgyRZaINGO8O2LwJErz9Zy0WGNfgh836lvgFxlX3ERiXjPN+n
         L9xA1jPEQNOiX8te8YEAWr0RN7aF6dOigbNy/gBFtAl1cRGN4tx3rYedalobzjBU2uyE
         BUTw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Ub84RjrgRQ/+ADeAciNS4+kLgr6EKGpTc1uD1atTvpc=;
        b=MeN2F2xgToJkwLTTMKA1R7A+28R0fRqnsNNyjgA7YcvR9qni9FnooxAppK9wHNsUce
         b86yuTIKTnM6TrLfOaqMsViiILIPsoaafz9ImTTLbwEpFyJzoBjSN+aEI8QDtJdUg6DI
         soX+nffYb0ApS6CPRoiStPj/qE5HuHbDUF6UdyWnSSBxltqzsahXetREQ7ajsS2Y68uN
         nLgiEL4hQPfCLGQ9W00f/AxasDC8eFIPKj1FnBw6jd2J3pa5fKxHtsQx6iGrMGRM0iki
         dS7JrV7gBpZpCfCSBAJG/0uyewivL2iyEh3GXpFK3MZuMQDzxFKy+O3Xi6eWYNU5BylU
         SL8A==
X-Gm-Message-State: AOAM533YwEB4NvP3opqLSQyPEmJytsx6ftBMTfrXHQR5aGNnFQu8ywgK
        yS0AHEn6j9yvOF5ZqlOKfUdzm0MUs5fXTTT5hIfyOw==
X-Google-Smtp-Source: ABdhPJzQMMM7nURwXZ2DjVoJwOnONWR/N7AsvqfC+K/Sbx3GpGv7aGWm/YFOZ2jT7FYJFTndbbvmAWc7snBHF9ERwJ8=
X-Received: by 2002:a05:651c:513:: with SMTP id o19mr13721382ljp.291.1620051129461;
 Mon, 03 May 2021 07:12:09 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1619818517.git.matheus.bernardino@usp.br>
 <f870040bfb3e73ee8cd27352b0acc65bb54be560.1619818517.git.matheus.bernardino@usp.br>
 <CAP8UFD1dz=u-nXyxSKArP-fAiX6mq3FV+oiiKCHCqbWMMf4TWw@mail.gmail.com>
In-Reply-To: <CAP8UFD1dz=u-nXyxSKArP-fAiX6mq3FV+oiiKCHCqbWMMf4TWw@mail.gmail.com>
From:   Matheus Tavares Bernardino <matheus.bernardino@usp.br>
Date:   Mon, 3 May 2021 11:11:58 -0300
Message-ID: <CAHd-oW6ErNfar43R4gt_i480xnrp8Nu8B6t+Aya_p11-ia8QGQ@mail.gmail.com>
Subject: Re: [PATCH v2 1/8] make_transient_cache_entry(): optionally alloc
 from mem_pool
To:     Christian Couder <christian.couder@gmail.com>
Cc:     git <git@vger.kernel.org>, Jeff Hostetler <git@jeffhostetler.com>,
        Derrick Stolee <stolee@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Sat, May 1, 2021 at 2:06 PM Christian Couder
<christian.couder@gmail.com> wrote:
>
> >  struct cache_entry *make_transient_cache_entry(unsigned int mode,
> >                                                const struct object_id *oid,
> >                                                const char *path,
> > -                                              int stage);
> > +                                              int stage, struct mem_pool *mp);
>
> It's a bit strange that `int stage` isn't on its own line here, as
> other parameters are. And if line length was the issue, it looks like
> it could have been on the same line as `const char *path`.
>
> > -struct cache_entry *make_transient_cache_entry(unsigned int mode, const struct object_id *oid,
> > -                                              const char *path, int stage)
> > +struct cache_entry *make_transient_cache_entry(unsigned int mode,
> > +                                              const struct object_id *oid,
> > +                                              const char *path, int stage,
>
> Here also, it's a bit strange that `int stage` isn't on its own line,
> as it looks like you want  to put others parameters on their own line.
> And this is not consistent with the above declaration.

Thanks. I'll put each parameter in its own line and make this
consistent with the declaration.
