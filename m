Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.6 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 4C4FC1FF40
	for <e@80x24.org>; Mon, 19 Dec 2016 17:08:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933887AbcLSRH5 (ORCPT <rfc822;e@80x24.org>);
        Mon, 19 Dec 2016 12:07:57 -0500
Received: from mail-qt0-f171.google.com ([209.85.216.171]:35147 "EHLO
        mail-qt0-f171.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S933848AbcLSRH4 (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 19 Dec 2016 12:07:56 -0500
Received: by mail-qt0-f171.google.com with SMTP id c47so152872862qtc.2
        for <git@vger.kernel.org>; Mon, 19 Dec 2016 09:07:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=AiMIFKMME4o+ZllZf8aDW0Z+4ZpQp+N4BFSut2keOaE=;
        b=BcCgOJu8hgoMJQd7l/gCt58d72seoJZoI5MBlX2Xm/U7kOioHhgSRfvl0ZqfcGtGEb
         PQRGo3ZQkpdeiFcQCvezKs+u2npud3WcjNepYJHXn62WfzqGLc/ojHTbri4w5U9GrXcP
         E9sGHIHGVvbQ+XRQZ0O7o9qUk3bzXr4dTxoeWyu7uht1PN/84Y0Srgjiw1U1k0f104OZ
         n+gd9/qNILm9mQGzeKgxLmkU/LDGn4OTV6p5qdDYSqdqql3i2dHPPHb4eiAeWUVjWktR
         yzThXTxwt72e+ThOe0tsOYJtIj4fumvbH3mc6eaEbzjZwTTR7BuXDNB9mVgsg5CT710c
         kIvg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=AiMIFKMME4o+ZllZf8aDW0Z+4ZpQp+N4BFSut2keOaE=;
        b=n8YatSVkHaZ8auKxTl8yB/iwQZpNqgVm7ghPpi0cYk11ul/MlBg7LnZ9Dfp0Kk5IuI
         XQ7j+rOwKtb4g7TodTlPTzjpJcLY/Mqsuz3vuMlDrHVPXg4pp055U3/QGOO2T/9hXi0i
         tCclT+3n2qPEWJeNwiJ3UpgtUH+46xbuUyClAHPegFQUMiJ1JEYg2tiiqVi9iJ9DUs7n
         qhdKB+lLcuCW8QyZwj8Lm39zA88d+A6IQmY9OuYvJyB6jHNuUHVCwl5hCWHt4l4rKm6Y
         6PzsFWQOpv4KKW3a8Aw7yRujWCG//7f3Cs+74bELZyTSgdyNrOZxda4rwSMEwNs8GBtf
         shEg==
X-Gm-Message-State: AIkVDXIXK8lG9yZYqpNItZK/ab9cyXpc1jZEf8loxY/Z4aq9kWGNgJ9Otc6tCKkMUpzVpA21zKMixAugMjAUMS/I
X-Received: by 10.200.50.53 with SMTP id x50mr15893566qta.207.1482167275507;
 Mon, 19 Dec 2016 09:07:55 -0800 (PST)
MIME-Version: 1.0
Received: by 10.12.147.188 with HTTP; Mon, 19 Dec 2016 09:07:55 -0800 (PST)
In-Reply-To: <CAFAcib9-rUSqyBRpauw3pTf9OPTKLYNf7bdh2gyykBNtJTZKGg@mail.gmail.com>
References: <CAFAcib8yauNRB6UbO8qS2_Ff4fDt-7mMsmgop8d1V0j=RoTBSA@mail.gmail.com>
 <CAGZ79kZ=QK5s0_94+4GNs3M5oo49GLm-KkT5K=yZktxX8C4UCw@mail.gmail.com> <CAFAcib9-rUSqyBRpauw3pTf9OPTKLYNf7bdh2gyykBNtJTZKGg@mail.gmail.com>
From:   Stefan Beller <sbeller@google.com>
Date:   Mon, 19 Dec 2016 09:07:55 -0800
Message-ID: <CAGZ79ka=RzAjrb=7u7p5xnveo=kcNCoGn=TC=0j-CBp8Oby7OA@mail.gmail.com>
Subject: Re: Bug report: $program_name in error message
To:     Josh Bleecher Snyder <josharian@gmail.com>, vascomalmeida@sapo.pt
Cc:     "git@vger.kernel.org" <git@vger.kernel.org>
Content-Type: text/plain; charset=UTF-8
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

+ Vasco Almeida, who authored d323c6b641,
(i18n: git-sh-setup.sh: mark strings for translation, 2016-06-17)

On Sun, Dec 18, 2016 at 1:44 PM, Josh Bleecher Snyder
<josharian@gmail.com> wrote:
>>> To reproduce, run 'git submodule' from within a bare repo. Result:
>>>
>>> $ git submodule
>>> fatal: $program_name cannot be used without a working tree.
>>>
>>> Looks like the intent was for $program_name to be interpolated.
>>
>> Which version of git do you use?
>
> $ git version
> git version 2.11.0
>
>
>>> As an aside, I sent a message a few days ago about a segfault when
>>> working with a filesystem with direct_io on, but it appears not to
>>> have made it to the archives on marc.info. Am I perhaps still
>>> greylisted?
>>
>> Both emails show up in my mailbox (subscribed to the mailing list),
>> so I think that just nobody answered your first email as the answer
>> may be non trivial.
>
> Thanks for the confirmation.
>
> -josh
