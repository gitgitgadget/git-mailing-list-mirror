Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id A40EF1F404
	for <e@80x24.org>; Fri, 16 Mar 2018 17:29:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932217AbeCPR3i (ORCPT <rfc822;e@80x24.org>);
        Fri, 16 Mar 2018 13:29:38 -0400
Received: from mail-ot0-f173.google.com ([74.125.82.173]:36497 "EHLO
        mail-ot0-f173.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932581AbeCPR3f (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 16 Mar 2018 13:29:35 -0400
Received: by mail-ot0-f173.google.com with SMTP id 108-v6so11137101otv.3
        for <git@vger.kernel.org>; Fri, 16 Mar 2018 10:29:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=pkPFgH7zm7eARewKSJtg5UQdjB4rVCaqsoBjMZWH5WQ=;
        b=hpbTi04Vf9eXD6VKHCYqY7N4b042dkozr2pfsjzYeLV2GPwmCdIa0OQ9f8bmeRl6dI
         4ExFIpk8NJD1ysB5T+FQ3WP2jj6hzXgirZ1CUUmSd9l6ifCelTxlcF+O+gjVouv15Eja
         6oIGX9SqeZRVAnHrqqqmc3uGOiUn8WvKvfwhSzIxrPGIoTOklcFkvNbhfHKATxFYXJU9
         iGgib7dew3jye7F++JIkOMw0x4/HzbfySgQL1Lo+fMbtDDlZUibBExiQ5btElxMo6M+X
         tVlW+MlD8WGh1rdlkeVMNNn95ovI2DUCWJ8Zwh3YX958HObNe4wvTgMD2mTp3Zhr54mF
         uXzA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=pkPFgH7zm7eARewKSJtg5UQdjB4rVCaqsoBjMZWH5WQ=;
        b=OMRDu5W2KGOYWC/2qT0tK2olDB04jT6fXdn8qrKB0kbV5CRafbpnbdJkb2p/77qn25
         2W12MMJSOxlOiwoj5D3/G+1kI2Z5f5pWMEiZ6qWww5W0F2vApRixFEfqhJlxCf062Xtk
         DYd4/nN/uTHGq/jjQF4u8aaLUXDQvu8x749UP1iNEnBUrDiKcqAptJDwQOTh11Q10qcm
         28nbGDlgXZIlkOnEaZTztADGDxUb6wfffSShhGJqW3aCTuya2f2Tdmvwk4OWJesDwnsI
         JKFTQrEIYiaMJ8jNqQMcGfyG80WMETq51+Uzp+t9oFkqtaNhUlBPpd9TFmyoZjFxoFlD
         ycGw==
X-Gm-Message-State: AElRT7Hpy6k6h5n3vxaguw38w6zXB1Oetz88G32+ge5TLTv+g9iSLWg6
        uAIhNRQrUVE6GfxOxkChv8da9GP5WkRfucSviFU=
X-Google-Smtp-Source: AG47ELsG/9KB/lsFUs6i55oB7wQ+6bjoYr2lFWXSAnOdt7hVJ+8TO0FHhCYQno/kZ1aGCFtdVNTN0TBOdM7pC6V4CVc=
X-Received: by 2002:a9d:36cc:: with SMTP id s12-v6mr1810748otd.304.1521221374661;
 Fri, 16 Mar 2018 10:29:34 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.74.154.146 with HTTP; Fri, 16 Mar 2018 10:29:04 -0700 (PDT)
In-Reply-To: <nycvar.QRO.7.76.6.1803151807060.64@ZVAVAG-6OXH6DA.rhebcr.pbec.zvpebfbsg.pbz>
References: <xmqqtvts22za.fsf@gitster-ct.c.googlers.com> <nycvar.QRO.7.76.6.1803071333590.20700@ZVAVAG-6OXH6DA.rhebcr.pbec.zvpebfbsg.pbz>
 <871sguorb5.fsf@evledraar.gmail.com> <CAD1RUU_EuLSo5fPjZe7v3882Tkx2Dymxn619smS-wuoejKyG+w@mail.gmail.com>
 <87y3iwp2z0.fsf@evledraar.gmail.com> <87woyfdkoi.fsf@evledraar.gmail.com>
 <xmqq37121vz5.fsf@gitster-ct.c.googlers.com> <nycvar.QRO.7.76.6.1803151807060.64@ZVAVAG-6OXH6DA.rhebcr.pbec.zvpebfbsg.pbz>
From:   Duy Nguyen <pclouds@gmail.com>
Date:   Fri, 16 Mar 2018 18:29:04 +0100
Message-ID: <CACsJy8AwyJPJv4mdbZgGo4tobncKPR=sKmv93oon0CD6hwNCxw@mail.gmail.com>
Subject: Re: Why don't we symlink libexec/git-core/* to bin/git?
To:     Johannes Schindelin <Johannes.Schindelin@gmx.de>
Cc:     Junio C Hamano <gitster@pobox.com>,
        =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>,
        Daniel Jacques <dnj@google.com>,
        Git Mailing List <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Mar 15, 2018 at 6:16 PM, Johannes Schindelin
<Johannes.Schindelin@gmx.de> wrote:
> To add some interesting information to this: in MinGit (the light-weight
> "Git for applications" we bundle to avoid adding a hefty 230MB to any
> application that wants to bundle Git for Windows), we simply ignored that
> old promise. We do support hooks written as Unix shell scripts in MinGit,
> and we have not had a single report since offering MinGit with v2.9.2 on
> July 16th, 2016, that it broke anybody's scripts, so it seems that users
> are more sensible than our promises ;-)

That's very good to hear. Perhaps we could slowly move away from
symlinking (or even hard linking) these builtin commands (with a
couple exception like receive-pack and stuff) ? We don't have to do it
right now but we can start announcing that we will drop it in maybe 2
or 3 releases. We do provide a new make target to recreate these links
so that packagers can make a "compat" package that contains just these
links if they want to. But by default a git package will have no
links.
-- 
Duy
