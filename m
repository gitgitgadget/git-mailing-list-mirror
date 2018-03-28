Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id AC7581F424
	for <e@80x24.org>; Wed, 28 Mar 2018 10:10:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752858AbeC1KKy (ORCPT <rfc822;e@80x24.org>);
        Wed, 28 Mar 2018 06:10:54 -0400
Received: from mail-ot0-f174.google.com ([74.125.82.174]:41765 "EHLO
        mail-ot0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752694AbeC1KKx (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 28 Mar 2018 06:10:53 -0400
Received: by mail-ot0-f174.google.com with SMTP id i28-v6so2025927otf.8
        for <git@vger.kernel.org>; Wed, 28 Mar 2018 03:10:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=xq5H75vkfPSn2ZJnxC3weLhTIl/iCyjTyeRt+15IcwA=;
        b=uV2LmyW85qPpgSaem8Pn9lb7efePoapxleRJKPoO85aZYcquFSDc2MhA5fOeEOhh2r
         9nZF41WETp8E0AUVyBXIrZNgzc0fWv9VLENAYDBfiyUxUs24b5+sKFNt+XF3ji+X4Qwb
         g0Z5PkiKWLpmADRji0Tzg3CFDdKZlB79doq6mOrsf9KuVkgm1W2uUK7U5gZh4zkBRPQp
         59i+alSZMnRMNxp1Acxx8rHsPjdjb9gvR/w6krlqJZChadyWUVJGkwuP4uO0d6I4K//9
         +rv4jF5dKiuZzgtss+KQToQ4YwRtvPd0vi5kHWBrURndi/SeiZ9gu8JUQH4EHSkVtjn0
         pDIg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=xq5H75vkfPSn2ZJnxC3weLhTIl/iCyjTyeRt+15IcwA=;
        b=Wbs3QiJAIVz1c8vaqHjtQcJ4uRUqihp8FZmT4BL8PGdX8GgguHuprApfG0ZmyDU8QZ
         qPz0Fba1OZpRW1wHfFM+VXxAhtiwv8BCyz4dFFfGlEXs/Dow78yiYyajFvOfNjO2mKGq
         eFAHJO37we/BHoIhZ9E4cgCCYK0VuoQ9PQp0NygQvjg/kgY2/bdAREMxTVhOjCNGtb07
         rmALC/XfF9tON0kvZ7FEpoWg1qzClZQjgbLAsFG7AJJoJ7yYOfSBKR5AUoanhu7RzqlM
         YagF9CtNHh2DoP2w336jSnZhg54a/t06QYpvcHeBJyeOReIajGG/U8F3HHNahBgo5mdf
         rsiw==
X-Gm-Message-State: ALQs6tDSOdYDyrHD5CU0rmLHU31a/IZ0xeHFACM+exTDyEQdNJMlR1bf
        ZnDsWVec3QuZkkuSfEsh2lHf24CCicX0O6Fra7s=
X-Google-Smtp-Source: AIpwx48i2Lb88+v2krEe0/hzALKnPHg6jtqwRQM7GmRds5vcy3b1g0w+OLHz1pEQRxpJ2xaBl7sloDbi7FTr0l+gGo4=
X-Received: by 2002:a9d:ae9:: with SMTP id 96-v6mr1893182otq.75.1522231852564;
 Wed, 28 Mar 2018 03:10:52 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.74.211.131 with HTTP; Wed, 28 Mar 2018 03:10:21 -0700 (PDT)
In-Reply-To: <20180328095203.GB1523@sigill.intra.peff.net>
References: <CACUQV5_3Pw+vnyyNUL4oE4tMLG_wKVdqdVk01rg4V92ufUYHHA@mail.gmail.com>
 <20180327063137.GA24044@sigill.intra.peff.net> <CACsJy8DP53Og1crS1bLoJf6w8cJhjGKy=ggfbsqzJ6AU4eNhPA@mail.gmail.com>
 <20180327164757.GB24747@sigill.intra.peff.net> <CACsJy8Bog6U7X-jvzDhq14heQWx0HA_21HsSYR0nykU9aDsCYQ@mail.gmail.com>
 <20180327173024.GA5017@duynguyen.home> <20180328095203.GB1523@sigill.intra.peff.net>
From:   Duy Nguyen <pclouds@gmail.com>
Date:   Wed, 28 Mar 2018 12:10:21 +0200
Message-ID: <CACsJy8AVcPi=0i7s9o8cy-XGFuOLr72fe9WLRnEqo1SwLJEBOw@mail.gmail.com>
Subject: Re: git complains packed-refs is not a directory when used with
 GIT_DIR and GIT_WORK_TREE envvars.
To:     Jeff King <peff@peff.net>
Cc:     Rafael Ascensao <rafa.almas@gmail.com>,
        Git Mailing List <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Mar 28, 2018 at 11:52 AM, Jeff King <peff@peff.net> wrote:
> On Tue, Mar 27, 2018 at 07:30:24PM +0200, Duy Nguyen wrote:
>
>> On Tue, Mar 27, 2018 at 07:09:36PM +0200, Duy Nguyen wrote:
>> > I would rather have something like ref_store_reinit() in the same
>> > spirit as the second call of set_git_dir() in setup_work_tree. It is
>> > hacky, but it works and keeps changes to minimal (so that it could be
>> > easily replaced later).
>>
>> So in the name of hacky and dirty things, it would look something like
>> this. This passed your test case. The test suite is still running
>> (slow laptop) but I don't expect breakages there.
>
> I think this is the right direction. I mentioned in my last reply that
> it would be nice for this to be a bit more generic, in case we need to
> use it again (and also just to keep the module boundaries sane).

Yes, that's why I called it hacky and dirty :) I keep thinking about
this, so I will probably fix it in a nicer way.

> This part confused me at first:
>
>> +void make_main_ref_store_use_absolute_paths(void)
>> +{
>> +     files_force_absolute_paths(get_main_ref_store());
>> +}
>> +
>> +void make_main_ref_store_use_relative_paths(const char *cwd)
>> +{
>> +     files_make_relative_paths(get_main_ref_store(), cwd);
>> +}
>
> since I thought you were actually turning things into absolute paths.
> But your procedure is basically "turn absolute, then after chdir, turn
> them back relative".
>
> I think it might be clearer if a single call is given both the old and
> new paths. That requires the caller of chdir() storing getcwd() before
> it moves, but I don't think that should be a big deal.

The problem is switching relative paths relies on the old $CWD if I'm
not mistaken and we need  getcwd() for this. I'd love to have one
callback that says "$CWD has been switched from this path to that
path, do whatever you need to" that can be called any time, before or
after chdir(). I'll look more into it.
-- 
Duy
