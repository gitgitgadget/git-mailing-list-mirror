Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.5 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id A2AF61F51C
	for <e@80x24.org>; Fri, 25 May 2018 11:22:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S966184AbeEYLWH (ORCPT <rfc822;e@80x24.org>);
        Fri, 25 May 2018 07:22:07 -0400
Received: from mail-it0-f65.google.com ([209.85.214.65]:40408 "EHLO
        mail-it0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S965781AbeEYLWG (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 25 May 2018 07:22:06 -0400
Received: by mail-it0-f65.google.com with SMTP id j186-v6so6372799ita.5
        for <git@vger.kernel.org>; Fri, 25 May 2018 04:22:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=ByUUCmRcg4tM7/7B9DrUgSC9Y9i+T2CZO7LACf+nSeg=;
        b=ENVC4Cj2feOya6ZaelS1At7iW+J1Pau2rgbFS4ZGj22curqqcSPT8SpP/NvnmxrgTw
         wTjUG7YaKMjZLVKHFgBG8evpc9nvwtUg7PuvaUYaPcOU8xifYITgcT6mxGgclXTxB4st
         mw40zHVhIPJk2VinCqwpR4CAhcVOJwoRd7tFNbc+jlb6suck+Ehw2cstPE7h7+SeEmL7
         9p67Lg+XOUg8Xs86fUbYXQHrPsXV7AKGMrC9rK90J3FY+YE/7vL0QuEEJoodkurmi0ve
         4NXid9x6HajU/bmrNeIN5mpJYX4Gas5Wyx//XJ8f3uD3dz0nNPiyGe3Pw8x00p4pW2QO
         zZww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=ByUUCmRcg4tM7/7B9DrUgSC9Y9i+T2CZO7LACf+nSeg=;
        b=jIEdIp0iXutaSGr8FhfW7EzhI8oXW3WSmQIvhjvqPJohh+lpm1pdwssmuiPbaz84Ib
         S1gw9WXIGRVxuAnCAX1bamQFfe57o5fwLrZyMXGBX0TSiyy1DSvUR2IcayOrIqhpsaLj
         i1kghhr/PdIQzpXXx2lcHgPf2fA/JEZyYPUCogg8bKAeNOWjmR61a1RjwyPvRQ4Q70/x
         SOCLX6IqTa6w+qzvN6b9RpBRm6cfq/87smOilUdCDRs8TToIfX2Bl9/yfrYoExrf+xKa
         fmgEcau8s4vTmjdUeamTbdhgFX7BPaINnLQ0dksMTPM0ffbA4C716hC3auTvdkv11mCn
         Yspw==
X-Gm-Message-State: ALKqPweiMUVVUm6h/2/AYhg7aE6YfRMKo0VUs6NykkAz7LYbV4UJtSvc
        VD8fDTZDMqGK4iL4qdKxrCTEB7Qu79Q0GH8/kp0=
X-Google-Smtp-Source: ADUXVKJOZr2tD8rMBGaPmh7W9ysgyG0uLzcAO2DdBlTsiFGclzxVxM5Y2lkzgh9yPz6GBb1GY9iAYkmmhXgRSo2x/BA=
X-Received: by 2002:a24:2f89:: with SMTP id j131-v6mr1495472itj.96.1527247326111;
 Fri, 25 May 2018 04:22:06 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a4f:22db:0:0:0:0:0 with HTTP; Fri, 25 May 2018 04:22:05
 -0700 (PDT)
In-Reply-To: <CAMy9T_E_wO-XKn-BoVpnoUn8cGsmE4z11AzbqW+7Ppo=P9zcDg@mail.gmail.com>
References: <20180523052517.4443-1-chriscool@tuxfamily.org>
 <615f57ad-7591-128a-0c42-660312d34ca2@alum.mit.edu> <20180525085906.GA2948@sigill.intra.peff.net>
 <CAMy9T_E_wO-XKn-BoVpnoUn8cGsmE4z11AzbqW+7Ppo=P9zcDg@mail.gmail.com>
From:   Christian Couder <christian.couder@gmail.com>
Date:   Fri, 25 May 2018 13:22:05 +0200
Message-ID: <CAP8UFD2gPoOqFbp18c3UFzp9XpGM8qrojzXsN1s4sXBEhCaF6g@mail.gmail.com>
Subject: Re: [PATCH v2] t: make many tests depend less on the refs being files
To:     Michael Haggerty <mhagger@alum.mit.edu>
Cc:     Jeff King <peff@peff.net>, Git Mailing List <git@vger.kernel.org>,
        Junio C Hamano <gitster@pobox.com>,
        =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>,
        Stefan Beller <sbeller@google.com>,
        Jonathan Nieder <jrnieder@gmail.com>,
        Jonathan Tan <jonathantanmy@google.com>,
        Duy Nguyen <pclouds@gmail.com>,
        Derrick Stolee <stolee@gmail.com>,
        =?UTF-8?Q?Carlos_Mart=C3=ADn_Nieto?= <cmn@dwim.me>,
        David Turner <novalis@novalis.org>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        =?UTF-8?Q?SZEDER_G=C3=A1bor?= <szeder.dev@gmail.com>,
        Christian Couder <chriscool@tuxfamily.org>,
        David Turner <dturner@twopensource.com>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, May 25, 2018 at 11:05 AM, Michael Haggerty <mhagger@alum.mit.edu> wrote:
> On Fri, May 25, 2018 at 10:59 AM, Jeff King <peff@peff.net> wrote:
>> On Fri, May 25, 2018 at 10:48:04AM +0200, Michael Haggerty wrote:
>>
>>> >  test_expect_success "multi-fetch works off a 'clean' repository" '
>>> > -   rm -r "$GIT_DIR/svn" "$GIT_DIR/refs/remotes" "$GIT_DIR/logs" &&
>>> > +   rm -rf "$GIT_DIR/svn" "$GIT_DIR/refs/remotes" &&
>>> > +   git reflog expire --all --expire=all &&
>>> >     mkdir "$GIT_DIR/svn" &&
>>> >     git svn multi-fetch
>>> >     '
>>> >
>>>
>>> `rm -rf "$GIT_DIR/refs/remotes"` is not kosher. I think it can be written
>>>
>>>     printf 'option no-deref\ndelete %s\n' $(git for-each-ref
>>> --format='%(refname)' refs/remotes) | git update-ref --stdin
>>>
>>> as long as the number of references doesn't exceed command-line limits.
>>> This will also take care of the reflogs. Another alternative would be to
>>> write it as a loop.
>>
>> Perhaps:
>>
>>   git for-each-ref --format="option no-deref%0adelete %(refname)" refs/remotes |
>>   git update-ref --stdin
>
> Ah yes, that's nicer. I tried with `\n`, but that's not supported
> (wouldn't it be nice if it were?). I didn't think to try `%0a` (let
> alone look in the documentation!)

Thanks both for this suggestion. I plan to use it in another patch.
