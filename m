Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 6AF4E1F404
	for <e@80x24.org>; Sat, 24 Feb 2018 21:42:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751463AbeBXVmH (ORCPT <rfc822;e@80x24.org>);
        Sat, 24 Feb 2018 16:42:07 -0500
Received: from mail-wm0-f41.google.com ([74.125.82.41]:53273 "EHLO
        mail-wm0-f41.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751449AbeBXVmF (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 24 Feb 2018 16:42:05 -0500
Received: by mail-wm0-f41.google.com with SMTP id t74so10877855wme.3
        for <git@vger.kernel.org>; Sat, 24 Feb 2018 13:42:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:references:user-agent:in-reply-to:date
         :message-id:mime-version:content-transfer-encoding;
        bh=qCMLj910T2LFXgnonpmLdaWhYvGTN1goQ2KAbdHooks=;
        b=tlC9RC1mRl/Y9gNHyazgimJPZNppUjKG0nCowQr885zmDWAwqJC8LOv88/d+3uhtS8
         km3JqPhmWarsuOpUb8ceeHLCgx+fxKIZdFEoEQoKnAh5hUYslisuzZwXfDTiyvBPCY05
         qcomqwR5bMMAkRYe4XWvIGIvuW73N1OnHz+dqXO9UaXD/wNdGu9tHjU138v9MhDu5WY9
         c+hgt2N9DAUli9ZnynZCP/0ZQMe+ylMb0eyiZ1GRL3k+Bw1QkX5IIxW8geYoltkqSVWf
         cUPAxf9em7Ekb/eGz0Q6i24W/29SLrVAVYGGQUh4MB59agXg+sZUZ8dwrQHZAE+4q7JF
         BwXw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:references:user-agent
         :in-reply-to:date:message-id:mime-version:content-transfer-encoding;
        bh=qCMLj910T2LFXgnonpmLdaWhYvGTN1goQ2KAbdHooks=;
        b=rQn3v75hDk1ekCRgkwjd7Z0keWhQyq4RO37XpcHMSxgY+G+v1G3CSJtwn8ZwQEo0zN
         s9G+5yfpGwpBZJapMuE0ORBawBdnkcS0ZxVfztEJu78FI4cZEDCIL5tkGcihC+HM5MbI
         3iJhNDOA+4VUxhfBMy9lDKj93eQTVu+z+Tk7V2bjci/sTxc9e6vWdQawazml/mU/wJus
         /wa1CLrlFGKs0+gCZuZGFWePVrBOI8xaXVS5l5xZ9O2AC3wirlt1hCP7modcWTSH+mY/
         mcG7s6Rg/cPTKQP4N3i8IbMjQ76/snqFRcDrZ4gbi1xpkm4B2JPrLsalEW5mkqi3Dya7
         7gtQ==
X-Gm-Message-State: APf1xPDEUnjjaItLah6mPx5aPWc50MS6m+yjoPQ5/DP6MYXzDgGGsbph
        H3l3lhKdkxgWPhuQfKryG1H3SdDf
X-Google-Smtp-Source: AH8x225RFF4UORJvpqTmAxisJj8vJ2zRxIaXXZyF0oNMNPWMespcgGTg2/eMk3Zibe7cqCAMQx6dBg==
X-Received: by 10.80.146.180 with SMTP id k49mr8355617eda.110.1519508524641;
        Sat, 24 Feb 2018 13:42:04 -0800 (PST)
Received: from evledraar (178-84-79-100.dynamic.upc.nl. [178.84.79.100])
        by smtp.gmail.com with ESMTPSA id u16sm4675785edb.95.2018.02.24.13.42.02
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Sat, 24 Feb 2018 13:42:02 -0800 (PST)
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     git@vger.kernel.org, Michael Giuffrida <michaelpg@chromium.org>,
        Michael Schubert <mschub@elegosoft.com>,
        Jeff King <peff@peff.net>,
        Eric Sunshine <sunshine@sunshineco.com>,
        Daniel Barkalow <barkalow@iabervon.org>
Subject: Re: [PATCH v5 00/17] document & test fetch pruning & add fetch.pruneTags
References: <20180121000304.32323-1-avarab@gmail.com>
        <20180209203216.11560-1-avarab@gmail.com>
        <xmqq606pyiqo.fsf@gitster-ct.c.googlers.com>
        <874lm9f6pe.fsf@evledraar.gmail.com>
        <xmqq7er4wzub.fsf@gitster-ct.c.googlers.com>
        <87zi40dqm1.fsf@evledraar.gmail.com>
        <xmqqsh9rs992.fsf@gitster-ct.c.googlers.com>
User-agent: Debian GNU/Linux 9.3 (stretch); Emacs 25.1.1; mu4e 1.1.0
In-reply-to: <xmqqsh9rs992.fsf@gitster-ct.c.googlers.com>
Date:   Sat, 24 Feb 2018 22:42:02 +0100
Message-ID: <87vaemdpzp.fsf@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Fri, Feb 23 2018, Junio C. Hamano jotted:

> Ævar Arnfjörð Bjarmason <avarab@gmail.com> writes:
>
>>> Let's see how others find it useful and/or if the changed code gets
>>> in the way of others (I am not absolutely sure if the changes are
>>> free of regression to existing users who do not use the new
>>> feature).
>>
>> I think if you're on the fence about merging it down (and others don't
>> chime in saying the want it / like it) it makes sense to merge down
>> 1-14/17 and we could discard 15-17/17 for now for a later re-submission
>> and discussion once the earlier part of the series lands in master.
>
> Or we merge everything and let people discover glitches and
> complain.  Reverting the last pieces can wait until then ;-).

Thanks, that obviously works for me.
