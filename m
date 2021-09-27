Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5E2D8C433EF
	for <git@archiver.kernel.org>; Mon, 27 Sep 2021 21:03:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3E9F961052
	for <git@archiver.kernel.org>; Mon, 27 Sep 2021 21:03:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237396AbhI0VFP (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 27 Sep 2021 17:05:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37740 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237277AbhI0VFA (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 27 Sep 2021 17:05:00 -0400
Received: from mail-lf1-x12d.google.com (mail-lf1-x12d.google.com [IPv6:2a00:1450:4864:20::12d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 95746C06176A
        for <git@vger.kernel.org>; Mon, 27 Sep 2021 14:03:21 -0700 (PDT)
Received: by mail-lf1-x12d.google.com with SMTP id b20so83476603lfv.3
        for <git@vger.kernel.org>; Mon, 27 Sep 2021 14:03:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=bFbHetZorOZBNqVFCSktLMsZTISTM2eQDPi8CMJksW4=;
        b=WjhzwCMMD6z+cJsh2YraN4uFDkcXvqsufWF92WhilbhU/9Bnshe8lOgnqSuhON+b4U
         KYt+aTglWEuov1WnvkbFY8kjOpFvN7f6pFxJ6qYSJ9WFpSXLNKyl7lE1bdjUHpyxQPA+
         REW8sNpoc/SMiHX0a05uehBEiMkpF8WpC3U2TmyaTknHiquBf7BPd/YveKFXNb79VVBK
         njSiea9rjcxgfbcxwpr2UfvDHrLpio1NYtFBLai/zxr/E/XDj5Z3sED859f7J9/HNlVS
         aqt5xVJFR7cMkpBBk1pJtpPrUcyl9id2t7RoPhbArvmtPoVmpUptO5mqDwznG4L+2JXm
         xqOQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=bFbHetZorOZBNqVFCSktLMsZTISTM2eQDPi8CMJksW4=;
        b=fg49JaYnm9AtV20aQsFF64LhmbPKNKYEzuV+Y/Pfu4M6kSoQLn2lsuNQke/ku2bVe1
         3wQPTaQ84CcBtPGkF1UBleMBg9vstrtXVDM+UO8l/GX99bziaFA1Vgm6PJB9zO2Mi/FR
         IyuYMoncFQcmICPh2PvDgN85MzuTZswHxrUBR/nzNiclKbBzXty9Vrsyi6+1Xmab0ADU
         43PtgncY5Nxd5qYVZ9qTsutKrnrPXS03klhZmLJJsf4Z4GsppEI5Y0RSTaa0ZkLWAyNO
         dMvWp+19WpQNkU+yEqMnPunJ4XZLrhifpK0n7kZd/38jP62SoKmMRP/JduS+flav5CTR
         1MyQ==
X-Gm-Message-State: AOAM532G+nrxwYYpX1D9hSgY+ZwG76OIHMEBhdB7BZEG+5TwSmOshlcP
        alDXHEsW3vkPynDjs/8GukuErfvujPN9fTUGVuzopPTnH+U=
X-Google-Smtp-Source: ABdhPJyRPdi/UxVzFqtPjNmmBwoHf8uQpgFoilMmW4Q+CWeI2BNO54ElrK6bXyO4Tl4bGuxCvY8YFDKek1xtlhyWpAY=
X-Received: by 2002:a05:6512:3403:: with SMTP id i3mr1737902lfr.533.1632776599872;
 Mon, 27 Sep 2021 14:03:19 -0700 (PDT)
MIME-Version: 1.0
References: <pull.1076.v5.git.git.1632514331.gitgitgadget@gmail.com>
 <pull.1076.v6.git.git.1632527609.gitgitgadget@gmail.com> <bdb99822f8c45a8b2855ee2ab38c4460e4b5e22e.1632527609.git.gitgitgadget@gmail.com>
 <xmqq1r59rde8.fsf@gitster.g> <CANQDOdfxZP1GSb29LfcLQ2U84hRsgSq4kfzshPHFU8=o9+BSjg@mail.gmail.com>
In-Reply-To: <CANQDOdfxZP1GSb29LfcLQ2U84hRsgSq4kfzshPHFU8=o9+BSjg@mail.gmail.com>
From:   Neeraj Singh <nksingh85@gmail.com>
Date:   Mon, 27 Sep 2021 14:03:09 -0700
Message-ID: <CANQDOdd5T=6HR5hr1VOom0b+x0ps0yrQOeo8XD5QkSv2BuUNGA@mail.gmail.com>
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

On Mon, Sep 27, 2021 at 1:55 PM Neeraj Singh <nksingh85@gmail.com> wrote:
>
> On Mon, Sep 27, 2021 at 1:07 PM Junio C Hamano <gitster@pobox.com> wrote:
> >
> > "Neeraj Singh via GitGitGadget" <gitgitgadget@gmail.com> writes:
> >
> > > diff --git a/compat/mingw.h b/compat/mingw.h
> > > index c9a52ad64a6..6074a3d3ced 100644
> > > --- a/compat/mingw.h
> > > +++ b/compat/mingw.h
> > > @@ -329,6 +329,9 @@ int mingw_getpagesize(void);
> > >  #define getpagesize mingw_getpagesize
> > >  #endif
> > >
> > > +int win32_fsync_no_flush(int fd);
> > > +#define fsync_no_flush win32_fsync_no_flush
> >
> > ...
> >
> > > diff --git a/wrapper.c b/wrapper.c
> > > index bb4f9f043ce..1a1e2fba9c9 100644
> > > --- a/wrapper.c
> > > +++ b/wrapper.c
> > > @@ -567,6 +567,10 @@ int git_fsync(int fd, enum fsync_action action)
> > >                                                SYNC_FILE_RANGE_WAIT_AFTER);
> > >  #endif
> > >
> > > +#ifdef fsync_no_flush
> > > +             return fsync_no_flush(fd);
> > > +#endif
> > > +
> > >               errno = ENOSYS;
> > >               return -1;
> >
> > This almost makes me wonder if we want to have a fallback
> > implementation of fsync_no_flush() that does
> >
> >    int fsync_no_flush(int unused)
> >    {
> >         errno = ENOSYS;
> >         return -1;
> >    }
> >
> > when nobody (like Windows) define their own fsync_no_flush().  That
> > way, this codepath does not have to have #ifdef/#endif here.
> >
> > This function is already #ifdef ridden anyway, so reducing just one
> > instance may not make much difference, but since I noticed it ...
> >
> > Thanks.
>
> I'll make your suggested change on Github so that it will be available if
> we do another re-roll.
>
> Thanks,
> Nereaj

Actually, while trying your suggestion, my conclusion is that we'd
either have the
inverse ifdef around the fsync_no_flush fallback or an #undef, or some
other confusing
state.  The current ifdeffery is unpleasant to read but not too long
and also pretty direct.
Win32 has an extra level of indirection, but the unix platforms
syscalls are directly written
in one place.

Thanks,
Neeraj
