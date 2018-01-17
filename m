Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 8B8691FADF
	for <e@80x24.org>; Wed, 17 Jan 2018 09:48:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752316AbeAQJsf (ORCPT <rfc822;e@80x24.org>);
        Wed, 17 Jan 2018 04:48:35 -0500
Received: from mail-oi0-f44.google.com ([209.85.218.44]:40871 "EHLO
        mail-oi0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750830AbeAQJsd (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 17 Jan 2018 04:48:33 -0500
Received: by mail-oi0-f44.google.com with SMTP id u83so12675249oie.7
        for <git@vger.kernel.org>; Wed, 17 Jan 2018 01:48:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=573gqXElDnPZ1jVbdgUIBRsgYfVCGBDyFFgV+hbslNk=;
        b=pcBfyZFlqoq7xJYuA4zi/3C1X5fCIYvkEiscLzRNfrj4sBXU1ZAABPHixu0DV7v1Bz
         YCbfVXjcssUWT465RGVYinZrNZ/QlF0UEC2/KVzIc2UZtW1aCKnYwBRZ3PgunSPpDz70
         MXtG4G8t04OC6GQo8RpaEneQb759zMwrh0RBuV2hk/9TLUTjP3AGFId4f2YCI77JnN77
         wzQRW6MOEGLBeLVQ8wWi+yq55Ru3hZA8+7Te2FZYLjJGswzqk3+13qfI4Obhayzi6err
         qRkN9hTs/SwzXzL2XDPGtCNEqHNY5vkLjw/rGGouZmdgEPR3KuewwqTZhtgul8crfH4N
         U3XA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=573gqXElDnPZ1jVbdgUIBRsgYfVCGBDyFFgV+hbslNk=;
        b=t/HueCl0N51TYe4BXHx8f8pfalYEVQVAQ3Kky+aiAIIhasTaUeTE41RujAyUOvV8Wv
         8AYKZlY+YhHb2FANzKESLo0ODpsfxzKekxIJ+o09bAN8jBs8DHqmi6PSkakOvn2VJKER
         UikBkPaZNO/oXZBxuxn2zHqo79Tlvowmin2KbVndG93fEo0RLUHH2+tH0NLIU0W1r+CU
         KCddzPkSO3Gfg+IlDtDmIlYXsSy5WZ8xxCTma2je+g5P+PDztkx3EAs2UCMaxyJoL86Y
         50iFg3xvGYUoNCj20/D2kJ9+yrDR53FKDs1FdfIImgLCeKCkBobEAQtQgZGxQ0bcUf5Z
         1Paw==
X-Gm-Message-State: AKwxyteHyd6tm5txNoPcfviyXpds1WP6zbTqjHX0GtjqE5egIKSPssLb
        n4/FCPINaCkh1KgvntAa92kaeoTVC8i8lvX9QkU=
X-Google-Smtp-Source: ACJfBovk03YQCJBkocCfS40Qkp7yMSKnWiDnJEoVs2aMEWjq9kVfM6g9wgNWINMFwG4UZqt5H9tVSiliLBRV3p4gJa8=
X-Received: by 10.202.60.134 with SMTP id j128mr740905oia.268.1516182512614;
 Wed, 17 Jan 2018 01:48:32 -0800 (PST)
MIME-Version: 1.0
Received: by 10.74.141.5 with HTTP; Wed, 17 Jan 2018 01:48:02 -0800 (PST)
In-Reply-To: <20180117061703.GB5618@alpha.vpn.ikke.info>
References: <20171229135240.GQ3693@zaya.teonanacatl.net> <20171229224825.31062-1-szeder.dev@gmail.com>
 <87y3ll6s0e.fsf@evledraar.gmail.com> <20171230005222.GT3693@zaya.teonanacatl.net>
 <87vago76i8.fsf@evledraar.gmail.com> <xmqq373miw4r.fsf@gitster.mtv.corp.google.com>
 <1516052626.2870893.1236353440.65CA651A@webmail.messagingengine.com>
 <CACsJy8Dzv3qPc1dB1rdvYL+CvEp+hY8ddoBrbCiP5KnqikzyLw@mail.gmail.com>
 <xmqqh8rlvdgh.fsf@gitster.mtv.corp.google.com> <20180117004419.GA14263@duynguyen.dek-tpc.internal>
 <20180117061703.GB5618@alpha.vpn.ikke.info>
From:   Duy Nguyen <pclouds@gmail.com>
Date:   Wed, 17 Jan 2018 16:48:02 +0700
Message-ID: <CACsJy8C0f43cc5TuybEo5wmem9MSdTO+-0tF3c9k4siN1UgwwQ@mail.gmail.com>
Subject: Re: [PATCH] Add shell completion for git remote rm
To:     Kevin Daudt <me@ikke.info>
Cc:     Junio C Hamano <gitster@pobox.com>, Keith Smiley <k@keith.so>,
        =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>,
        Todd Zullinger <tmz@pobox.com>,
        =?UTF-8?Q?SZEDER_G=C3=A1bor?= <szeder.dev@gmail.com>,
        Git Mailing List <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Jan 17, 2018 at 1:17 PM, Kevin Daudt <me@ikke.info> wrote:
> On Wed, Jan 17, 2018 at 07:44:19AM +0700, Duy Nguyen wrote:
>> PS. This also makes me thing about supporting subcommand aliases, so
>> that people can add back 'git remote rm' if they like (or something
>> like 'git r rm' when they alias 'remote' as well). Which is probably a
>> good thing to do. Long command names are fine when you have completion
>> support, they are a pain to type otherwise.
>>
>
> Couldn't they just create an alias like git rrm then, if they use it so
> often that it becomes an issue?

They could. The only exception that may not work is if they want to
insert some options between "r" and "rm". Sometimes option positions
matter. Anyway this is just thinking out loud, maybe we don't really
need it until people scream about it with a valid use case

> Having another layer of aliases does create a lot of complexity.

Yes. It's partly the reason I wanted this actually ;-) Many commands
have gained subcommands nowadays but there's no shared infrastructure
for managing these subcommands. By adding something that works across
the board at subcommand level I'm forced to "fix" this (or probably
never get to do the sub-aliasing because this "fix" takes forever).
-- 
Duy
