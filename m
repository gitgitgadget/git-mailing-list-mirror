Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	T_RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 66CC51F424
	for <e@80x24.org>; Sat,  7 Apr 2018 09:53:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751310AbeDGJxG (ORCPT <rfc822;e@80x24.org>);
        Sat, 7 Apr 2018 05:53:06 -0400
Received: from mail-oi0-f66.google.com ([209.85.218.66]:39932 "EHLO
        mail-oi0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751093AbeDGJxF (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 7 Apr 2018 05:53:05 -0400
Received: by mail-oi0-f66.google.com with SMTP id q71-v6so3311114oic.6
        for <git@vger.kernel.org>; Sat, 07 Apr 2018 02:53:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=piAh1uCaYTnoJF/FtXY1a81Uaheb94m8ekbAjRHhGTs=;
        b=TWGL3vaniGQQM8u8CzkYQJkZu284qhIl7xEIAsIArBG316XDJCD/z3ZXaLFi3AKvbC
         5l1eRNjEdr+WpDjh6pUM6qUhyQgjKFTYuvLyCfd3G7Cqx0QtF5DEUVF1DuhA4bRL04rX
         1Zk3nw4udCXt3znXHq2bW2OZq2oTNnWAKT7tszcparcTkCEJb68sqNveUUjh+hi5hgHl
         dMCU861jld9EzM7EhtdoR4ZrJ7pL9LaCPnqmlzS3LIRR4XE/NMBO/ulAo0swgkUuthO2
         XnsiXeCz+86JpRTjHWfV7WjpnszIgnOLZIpccSmcpPZEf356+xZ9TQIxPayyK17N+wdk
         KJCg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=piAh1uCaYTnoJF/FtXY1a81Uaheb94m8ekbAjRHhGTs=;
        b=Pognl1jHqF1NDxWnbVPBMD87V3JMStIu5jNFL7jrEcxfoZp+thqv0+hGjVXeUsGrJx
         w3PK9eXIN2mRmDxjVWl5f79ubxRTpdngN/+XTFz1oHu3ciHPQqSqaqPUNBL61N0XYlOV
         AXCSrqUqWUnn8gyklqEGbIVItUH5CaVdzdtA5tJ31glXhiObTNvoL1+noUVkel5PD2Re
         BrETWQuIsJ1tIp8GL0F2uj8EaYmEm1rxnESIt3e7IeOlF+RxUl9y91VlQLKU4sZEzzLc
         7CIzKeWn8f24u4rSLjFFftnwZPkuE24zpzYl8K3qz1dVJB5IbNKD5W5LWXoZNSkrsxKR
         pE4w==
X-Gm-Message-State: ALQs6tDDDPhCpZKczyLPQrmyhaWQK7KMZ+Rb7cbsQale2Kc38IW2/8hA
        Ix2HJFqEkbec3BqmxM6uBS41BvldpLnHNvWOVYU=
X-Google-Smtp-Source: AIpwx4/6LfOOumqc2XljQ4cuy7JaY1Oq6z9fSRXX7NWjP2aI9OswYPn4nMc5RjEoF4GxXI4H3PBJvEQKxVA7PywtVnM=
X-Received: by 2002:aca:5b06:: with SMTP id p6-v6mr18041509oib.216.1523094784858;
 Sat, 07 Apr 2018 02:53:04 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.74.198.152 with HTTP; Sat, 7 Apr 2018 02:52:34 -0700 (PDT)
In-Reply-To: <20180406214236.GF7870@sigill.intra.peff.net>
References: <20180329150322.10722-1-pclouds@gmail.com> <20180331164009.2264-1-avarab@gmail.com>
 <CACsJy8CyB0igY365NMkswSgAi9_rf+XBOMQyJ7XW6iQxQiCEyQ@mail.gmail.com>
 <87woxove8d.fsf@evledraar.gmail.com> <20180403151700.GA24602@duynguyen.home> <20180406214236.GF7870@sigill.intra.peff.net>
From:   Duy Nguyen <pclouds@gmail.com>
Date:   Sat, 7 Apr 2018 11:52:34 +0200
Message-ID: <CACsJy8BOVnu+HXcVbkTKW6YZ8vQnwbAcaF4d2CzUbQLrZjuOJg@mail.gmail.com>
Subject: Re: [PATCH 4/3] Makefile: untangle DEVELOPER and -Werror
To:     Jeff King <peff@peff.net>
Cc:     =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>,
        Git Mailing List <git@vger.kernel.org>,
        Junio C Hamano <gitster@pobox.com>,
        Ramsay Jones <ramsay@ramsayjones.plus.com>,
        Lars Schneider <larsxschneider@gmail.com>,
        ric Sunshine <sunshine@sunshineco.com>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, Apr 6, 2018 at 11:42 PM, Jeff King <peff@peff.net> wrote:
> On Tue, Apr 03, 2018 at 05:17:00PM +0200, Duy Nguyen wrote:
>
>> It's not that complex. With the EAGER_DEVELOPER patch removed, we can
>> have something like this where eager devs just need to put
>>
>>     DEVOPTS = gentle no-suppression
>>
>> and you put
>>
>>     DEVOPTS = gentle
>>
>> (bad naming, I didn't spend time thinking about names)
>
> It seems to me like we're losing the point of DEVELOPER here. I thought
> the idea was to have a turn-key flag you could set to get extra linting
> on your commits. But now we're tweaking all kinds of individual options.
> At some point are we better off just letting you put "-Wno-foo" in your
> CFLAGS yourself?

It's because what AEvar wanted is no longer a dev thing :)

> I don't mind the version-based checks because they're automatic, so the
> feature remains turn-key. But this kind of DEVOPTS seems like a step in
> the wrong direction.
>
> -Peff



-- 
Duy
