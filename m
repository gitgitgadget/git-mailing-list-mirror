Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	FROM_EXCESS_BASE64,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 506591F404
	for <e@80x24.org>; Sat,  7 Apr 2018 12:36:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751529AbeDGMgR (ORCPT <rfc822;e@80x24.org>);
        Sat, 7 Apr 2018 08:36:17 -0400
Received: from mail-wm0-f65.google.com ([74.125.82.65]:55718 "EHLO
        mail-wm0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751475AbeDGMgQ (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 7 Apr 2018 08:36:16 -0400
Received: by mail-wm0-f65.google.com with SMTP id b127so8315703wmf.5
        for <git@vger.kernel.org>; Sat, 07 Apr 2018 05:36:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:references:user-agent:in-reply-to:date
         :message-id:mime-version;
        bh=DBaTO42cw4Kw1ScteuZJy9X1QF5p0WJ7kmbDW0ObAAM=;
        b=vTVaqHEymZX2ldwidIMb+McAHeujIwGsKQcNfrBE4rG1VmwyI8PTPJXEtTDnZ/yrP7
         +NJh5A5JnzIppXCayeCK/VlVDRaabUxyiDuhKJUNr5hacpakpizsqQ6BcN9OYhg0nyTa
         91dgCHB8eckAlMeZKuZum7UjhbFo19z25EkiIVKxPJP7Cx4hDIrXzGshUioSUbyLchLd
         H47SESpov3/XvBZF5Fv+wAFtbTr5Z/c21hqCFoOhI5M/xeLrOVA29ZG6uYTqN/tyEc6L
         fUpRHT1SDl9A1f6FN7x+0yLC7Bm8cVW2NnsHnECOwiFHYMpuTi8C/1T0rITELrDVrsDy
         dXng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:references:user-agent
         :in-reply-to:date:message-id:mime-version;
        bh=DBaTO42cw4Kw1ScteuZJy9X1QF5p0WJ7kmbDW0ObAAM=;
        b=JAPzjicZDSLtwNDdjz8yP2z6KYIv7Z/KyxLXubOdfEIkMfEAvXNLpi4m2BmFKQwPbR
         9pAABfvEk7qPL0KFQ1HB1G6Fstj9ESPX+RwxN8Julon14vMhn5UzKj2DVnz6DECVMsHk
         XhlQ76zjR4H+kwszIN6Qi2Jqcbd279S0acEGo9RmQFI2HnJMsmDmAvlhfypYdox+l/YF
         a/XBieevwNEUxkPUyzV3klbrWe4MxicUjZ3ZD8b6s8iqcERWsTnuXVial8Z2F0i4Ysd9
         qUCkjgUhUghSkCqy2xIezojUVmhzFv959fVXXFVuzkjqYAr31vA6zN0acyRNfaa/a/Nm
         kokw==
X-Gm-Message-State: ALQs6tC1t+1B/v9MsEnsg0qpxmDLe0WgtHyiE7DDSD+lAALH9aFALKxr
        ymE6RedRN+45H+c8LrgwUaE=
X-Google-Smtp-Source: AIpwx4/iE37/DNAnl45FPrS3WtKeBOeqt4F2jh8dUz9beg06LAX52m2QfeRwHdggCrm8R+eU0u3bSg==
X-Received: by 10.80.222.205 with SMTP id d13mr11462588edl.76.1523104575379;
        Sat, 07 Apr 2018 05:36:15 -0700 (PDT)
Received: from evledraar (dhcp-089-098-184-206.chello.nl. [89.98.184.206])
        by smtp.gmail.com with ESMTPSA id v21sm2542914edb.75.2018.04.07.05.36.13
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Sat, 07 Apr 2018 05:36:14 -0700 (PDT)
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     Duy Nguyen <pclouds@gmail.com>
Cc:     Jeff King <peff@peff.net>, Git Mailing List <git@vger.kernel.org>,
        Junio C Hamano <gitster@pobox.com>,
        Ramsay Jones <ramsay@ramsayjones.plus.com>,
        Lars Schneider <larsxschneider@gmail.com>,
        ric Sunshine <sunshine@sunshineco.com>
Subject: Re: [PATCH 4/3] Makefile: untangle DEVELOPER and -Werror
References: <20180329150322.10722-1-pclouds@gmail.com>
        <20180331164009.2264-1-avarab@gmail.com>
        <CACsJy8CyB0igY365NMkswSgAi9_rf+XBOMQyJ7XW6iQxQiCEyQ@mail.gmail.com>
        <87woxove8d.fsf@evledraar.gmail.com>
        <20180403151700.GA24602@duynguyen.home>
        <20180406214236.GF7870@sigill.intra.peff.net>
        <CACsJy8BOVnu+HXcVbkTKW6YZ8vQnwbAcaF4d2CzUbQLrZjuOJg@mail.gmail.com>
User-agent: Debian GNU/Linux 9.4 (stretch); Emacs 25.1.1; mu4e 1.1.0
In-reply-to: <CACsJy8BOVnu+HXcVbkTKW6YZ8vQnwbAcaF4d2CzUbQLrZjuOJg@mail.gmail.com>
Date:   Sat, 07 Apr 2018 14:36:12 +0200
Message-ID: <87r2nryz0j.fsf@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Sat, Apr 07 2018, Duy Nguyen wrote:

> On Fri, Apr 6, 2018 at 11:42 PM, Jeff King <peff@peff.net> wrote:
>> On Tue, Apr 03, 2018 at 05:17:00PM +0200, Duy Nguyen wrote:
>>
>>> It's not that complex. With the EAGER_DEVELOPER patch removed, we can
>>> have something like this where eager devs just need to put
>>>
>>>     DEVOPTS = gentle no-suppression
>>>
>>> and you put
>>>
>>>     DEVOPTS = gentle
>>>
>>> (bad naming, I didn't spend time thinking about names)
>>
>> It seems to me like we're losing the point of DEVELOPER here. I thought
>> the idea was to have a turn-key flag you could set to get extra linting
>> on your commits. But now we're tweaking all kinds of individual options.
>> At some point are we better off just letting you put "-Wno-foo" in your
>> CFLAGS yourself?
>
> It's because what AEvar wanted is no longer a dev thing :)

It's still a dev thing, but just for a slightly different use-case. I
hack my patches up with DEVELOPER=1, and then eventually deploy a
patched git version with those (and others) on top of the latest release
tag.

At that point I want the same compiler assertions, but might be building
on much older compilers, so I just want the warning output without
-Werror.

Anyway, I see you've pushed a new version with DEVOPTS. I'll submit mine
on top of that once your new version lands (unless you want to try to
integrate it yourself).
