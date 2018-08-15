Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	T_DKIM_INVALID shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 055171F404
	for <e@80x24.org>; Wed, 15 Aug 2018 18:07:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726645AbeHOVAY (ORCPT <rfc822;e@80x24.org>);
        Wed, 15 Aug 2018 17:00:24 -0400
Received: from mail-wm0-f67.google.com ([74.125.82.67]:54437 "EHLO
        mail-wm0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725962AbeHOVAY (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 15 Aug 2018 17:00:24 -0400
Received: by mail-wm0-f67.google.com with SMTP id c14-v6so2132784wmb.4
        for <git@vger.kernel.org>; Wed, 15 Aug 2018 11:07:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version:content-transfer-encoding;
        bh=bJJQSlDqXD36kGYICHOqFHzJXaJtSU4Nos14+ka9vyg=;
        b=tP4uwcy69k69iwGKNdGuaaP9xpz4PHShUO7olySrxDWjgcZLj3PBJSqz4IXKuhDfUy
         LkfvTymcYNEtE9W/FZGf4EJ3qG3PUbVSTEZJW1oITM32+EBQFQeBVZy6w9bSWTaAq9rk
         Zm0INmSbgd7MTBwEH4pJjfOhjPONZREmacN3vUcNYWOBw9D0dRCVvIeWifc0Fj5pMRz5
         nkYgG1d+7VQuWHxfuHko4pJo/V4VsQrGSrzWmyBupjU+I0f81tOeQEzv78moSCf739Vm
         zMYKCakD+GhvQ/vpAfTPcG4zA7k6n8qG2c5K+QCuqWPADKx1TIus8JFtTnpT6gMVOIpO
         WbIQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version
         :content-transfer-encoding;
        bh=bJJQSlDqXD36kGYICHOqFHzJXaJtSU4Nos14+ka9vyg=;
        b=ApAKS01qiJoJllX4CGV/bOagvYjfYNQsqiKSCyQmF8Lk5NDONIjsRZDqGes2zZ5yoC
         PvAqg40EZClzoBfrU13Jhx3PnHwzzO7jZPs0KobbrTct6DyuZXBKYiX+PJQnoG6KBJn3
         tCmKNuSxDydQolxIFXCSdGU2flS/AgxZBHu5VfCsmo6gXG27bBV/UlLcYyEGhX40GoOc
         tuaj8HWCiHXOkd46knTJYawLYjVRFTRf/fwOfMB7ntoFPNy5phKoapu6I8W3/ZFf1v4i
         Ly4HOg3wuz3wkMB5SdasBnboIobFFkkyp7lWDNhsp/1tEBKZ7UaJmBDRRCUINi44aTdv
         AUKA==
X-Gm-Message-State: AOUpUlHd2TS/BYW7XemXltauT5VxDOp2h+ATLLxtezlv3HoJ9uUBxaYb
        tIW5JYmEJe8aR76MRSxPXA4=
X-Google-Smtp-Source: AA+uWPxOB7KiSbEOIwmwIQ59dE53tiadv8bQEJu3ukb6suUK1d4ypsUt3WxoQVyh+Kd9BsIHU/U9og==
X-Received: by 2002:a1c:6d17:: with SMTP id i23-v6mr14934645wmc.139.1534356431038;
        Wed, 15 Aug 2018 11:07:11 -0700 (PDT)
Received: from localhost (168.50.187.35.bc.googleusercontent.com. [35.187.50.168])
        by smtp.gmail.com with ESMTPSA id r16-v6sm35284582wru.59.2018.08.15.11.07.10
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 15 Aug 2018 11:07:10 -0700 (PDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
Cc:     git@vger.kernel.org, Eygene Ryabinkin <rea-git@codelabs.ru>,
        Philip Oakley <philipoakley@iee.org>
Subject: Re: [PATCH] Makefile: extend NO_TCLTK=NoThanks to cover docs
References: <20180815151505.12011-1-avarab@gmail.com>
        <xmqq7ekrk1q0.fsf@gitster-ct.c.googlers.com>
        <xmqq1sazk12m.fsf@gitster-ct.c.googlers.com>
        <87lg97qzr4.fsf@evledraar.gmail.com>
Date:   Wed, 15 Aug 2018 11:07:09 -0700
In-Reply-To: <87lg97qzr4.fsf@evledraar.gmail.com> (=?utf-8?B?IsOGdmFyIEFy?=
 =?utf-8?B?bmZqw7Zyw7A=?= Bjarmason"'s
        message of "Wed, 15 Aug 2018 19:57:19 +0200")
Message-ID: <xmqq7ekrijw2.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Ævar Arnfjörð Bjarmason <avarab@gmail.com> writes:

>>>> +ifndef NO_TCLTK
>>>> +MAN1_TXT_WIP += gitk.txt
>>>> +MAN1_TXT = $(MAN1_TXT_WIP)
>>>> +else
>>>> +TCLTK_FILES += git-gui.txt
>>>> +TCLTK_FILES += gitk.txt
>>>> +TCLTK_FILES += git-citool.txt
>>>> +MAN1_TXT = $(filter-out \
>>>> +		$(TCLTK_FILES), \
>>>> +		$(MAN1_TXT_WIP))
>>>> +endif
>>
>> I didn't notice it when I read it for the first time, but asymmetry
>> between these two looks somewhat strange.  If we are adding gitk.txt
>> when we are not declining TCLTK based programs, why can we do
>> without adding git-gui and git-citool at the same time?  If we know
>> we must add gitk.txt when we are not declining TCLTK based programs
>> to MAN1_TXT_WIP in this section, it must mean that when we do not
>> want TCLTK based programs, MAN1_TXT_WIP would not have gitk.txt on
>> it, so why do we even need it on TCLTK_FILES list to filter it out?
>
> The only explicitly listed files are those that don't match the wildcard
> git-*.txt. Therefore if we want gitk.txt we need to explicitly list only
> it, but if we don't want the TCL programs we also need to list the ones
> that match git-*.txt.

Which means that gitk.txt does not have to be on TCLTK_FILES list,
no?
