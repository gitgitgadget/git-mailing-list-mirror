Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 05EFEC433EF
	for <git@archiver.kernel.org>; Mon, 27 Sep 2021 20:55:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D7F5561052
	for <git@archiver.kernel.org>; Mon, 27 Sep 2021 20:55:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236908AbhI0U5G (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 27 Sep 2021 16:57:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35464 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237164AbhI0U5B (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 27 Sep 2021 16:57:01 -0400
Received: from mail-lf1-x12f.google.com (mail-lf1-x12f.google.com [IPv6:2a00:1450:4864:20::12f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9E743C061769
        for <git@vger.kernel.org>; Mon, 27 Sep 2021 13:55:22 -0700 (PDT)
Received: by mail-lf1-x12f.google.com with SMTP id u18so81650275lfd.12
        for <git@vger.kernel.org>; Mon, 27 Sep 2021 13:55:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=0ilENSc7ljaqrtf8+X/0KCtgr6LDj7TKndgnWCLiyhg=;
        b=igrOC5E4HQzK4STEWQzu/A8E2sR0IAvR5L/u0h+4nQtJ50oUOHtqGc8d00RVD8XN2O
         lJM3SU0v/gxeEz7RDB4ikdTcom8OLQ6o5Ad6POhBR06vuHt3xvYUxJSBuIcHyLEileo5
         f+7xcG54K0a7FkctlZUZFBmfXHYjRq04J69vtnybVxnN1Fg//TzfIoGpQMNWenjyCc7I
         jnu50/gTZ4k1vscVhMuzluC8udE+4E/NezVlGhNXduVoIrySrl1F7fiUjZYN89BYNNxy
         5WmNCEphwuuAcozR5AJDQ/AG2lEWcoKR0xL2T+/59R0iq/z05qBEqcsK3nmeR0Az75cJ
         ZXeA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=0ilENSc7ljaqrtf8+X/0KCtgr6LDj7TKndgnWCLiyhg=;
        b=5kQiTND0TgdClPgI6jke+zDGc0x1toX+Pm45Ho3Vexva5Me5j+oT2a0WE0DaFHNhB3
         T0tObAS9pDaaNSeqGLkQYQ+J4BxlUIOb9yf28GLg0CNq95W+nzf9H2hfo2A1J3KGCoKf
         CBX+r5vPBKx4bGPhkiNuYDOjHL9bp9IuVr3JSj/LgOkKUmxNkZjCg2ILlB1U51W1dF/T
         gesRqpnxXOEfvdPaTyeK+Hvw2cTHYmqQEznRUXHLuh0+4wh0rXZVt8Ghr0F+Y2O1k/Hk
         ye/RoskO4P8Hi8hiwiNnKti4Y+t5P+pklxqSlN+nTU3SZbrsIh648y9wNAxdoJ/kntSD
         8dlQ==
X-Gm-Message-State: AOAM531TCDE+YKNaHMmd1SoHO3VXCIhosb2+ue5XWgi5IR3kJ003x07m
        azzL5UwN/Q01qgLsJ7pOP/3KiaukZfHS0MrrZK80JHSCAKg=
X-Google-Smtp-Source: ABdhPJx1d1EeUU7cUpdc0dqtpXN2ye+nNOOr4OKrYXQ5GhOS48HIwo+u/DKbkHi2xTEZNFEhl/bXR4kFsVZFW26U99Q=
X-Received: by 2002:a2e:97ce:: with SMTP id m14mr1908106ljj.73.1632776120968;
 Mon, 27 Sep 2021 13:55:20 -0700 (PDT)
MIME-Version: 1.0
References: <pull.1076.v5.git.git.1632514331.gitgitgadget@gmail.com>
 <pull.1076.v6.git.git.1632527609.gitgitgadget@gmail.com> <bdb99822f8c45a8b2855ee2ab38c4460e4b5e22e.1632527609.git.gitgitgadget@gmail.com>
 <xmqq1r59rde8.fsf@gitster.g>
In-Reply-To: <xmqq1r59rde8.fsf@gitster.g>
From:   Neeraj Singh <nksingh85@gmail.com>
Date:   Mon, 27 Sep 2021 13:55:10 -0700
Message-ID: <CANQDOdfxZP1GSb29LfcLQ2U84hRsgSq4kfzshPHFU8=o9+BSjg@mail.gmail.com>
Subject: Re: [PATCH v6 4/8] core.fsyncobjectfiles: add windows support for
 batch mode
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Neeraj Singh via GitGitGadget <gitgitgadget@gmail.com>,
        Git List <git@vger.kernel.org>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Jeff King <peff@peff.net>,
        Jeff Hostetler <jeffhost@microsoft.com>,
        Christoph Hellwig <hch@lst.de>,
        =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>,
        "Randall S. Becker" <rsbecker@nexbridge.com>,
        Bagas Sanjaya <bagasdotme@gmail.com>,
        "Neeraj K. Singh" <neerajsi@microsoft.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Sep 27, 2021 at 1:07 PM Junio C Hamano <gitster@pobox.com> wrote:
>
> "Neeraj Singh via GitGitGadget" <gitgitgadget@gmail.com> writes:
>
> > diff --git a/compat/mingw.h b/compat/mingw.h
> > index c9a52ad64a6..6074a3d3ced 100644
> > --- a/compat/mingw.h
> > +++ b/compat/mingw.h
> > @@ -329,6 +329,9 @@ int mingw_getpagesize(void);
> >  #define getpagesize mingw_getpagesize
> >  #endif
> >
> > +int win32_fsync_no_flush(int fd);
> > +#define fsync_no_flush win32_fsync_no_flush
>
> ...
>
> > diff --git a/wrapper.c b/wrapper.c
> > index bb4f9f043ce..1a1e2fba9c9 100644
> > --- a/wrapper.c
> > +++ b/wrapper.c
> > @@ -567,6 +567,10 @@ int git_fsync(int fd, enum fsync_action action)
> >                                                SYNC_FILE_RANGE_WAIT_AFTER);
> >  #endif
> >
> > +#ifdef fsync_no_flush
> > +             return fsync_no_flush(fd);
> > +#endif
> > +
> >               errno = ENOSYS;
> >               return -1;
>
> This almost makes me wonder if we want to have a fallback
> implementation of fsync_no_flush() that does
>
>    int fsync_no_flush(int unused)
>    {
>         errno = ENOSYS;
>         return -1;
>    }
>
> when nobody (like Windows) define their own fsync_no_flush().  That
> way, this codepath does not have to have #ifdef/#endif here.
>
> This function is already #ifdef ridden anyway, so reducing just one
> instance may not make much difference, but since I noticed it ...
>
> Thanks.

I'll make your suggested change on Github so that it will be available if
we do another re-roll.

Thanks,
Nereaj
