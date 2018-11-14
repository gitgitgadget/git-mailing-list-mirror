Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	FROM_EXCESS_BASE64,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id D5C8F1F87F
	for <e@80x24.org>; Wed, 14 Nov 2018 13:58:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1733080AbeKOABk (ORCPT <rfc822;e@80x24.org>);
        Wed, 14 Nov 2018 19:01:40 -0500
Received: from mail-wm1-f67.google.com ([209.85.128.67]:51765 "EHLO
        mail-wm1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727700AbeKOABk (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 14 Nov 2018 19:01:40 -0500
Received: by mail-wm1-f67.google.com with SMTP id w7-v6so15535886wmc.1
        for <git@vger.kernel.org>; Wed, 14 Nov 2018 05:58:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:references:user-agent:in-reply-to:date
         :message-id:mime-version:content-transfer-encoding;
        bh=LZceYm4gOfQ7VODoRtLAZuq0YUKY94I69xu0v2b49jA=;
        b=r4MOgywZn9rjUkCVx6kqYXCFkD3zx7IeNcUyHl9QXCPM4bFM3BmPQnyyrjoFNBcIdL
         uv2ZoGNeDPbM2eC8fHhe+p48HjasTwPli+OafpCjqyKIEF9QaKxd+TWW5LAx6obSUpjv
         Ci/1UR28/qEB1aQPMBpT7I8WeiFTlS/mczYROXyLvrPcP6u3I+inrX5PEJHNl6vFoIte
         4UgDcSvRAf3Lfbo1YOsMPKIIIxkuUIMgVEp1ui3+4awuTN5Getf1+T/6don9V41wAPf7
         cGqfC4ElipwIvvuXRTT35TlPcJhRkIlQ+FoT8GQgvebweMJIW7Fn4w8BwksGMjXUtE+R
         WDCQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:references:user-agent
         :in-reply-to:date:message-id:mime-version:content-transfer-encoding;
        bh=LZceYm4gOfQ7VODoRtLAZuq0YUKY94I69xu0v2b49jA=;
        b=uBA8HqBJaocwVKufMOPrpadoSgxiPLgG0X2UOd1whRjQTiNSzByELHN0DMuafsxu67
         am/8ZctMLtOlkaTy7rdeNhWbohTSiSM4MiU5XZArzyIvO58B6krylnVbMhS3kYOuZN43
         X4kivZrbdXltloFku9Pt4jBOes2LI7YJxdGfLJSoTe1KecDdR1oYOxs+ZTEhQo/15Hf9
         AN9HfK1lWU3YWyyVw6Fs4LdtS/t+z30X4K2zzjpfklfzc4EjMsdyKxrKivuwfDPQMCoX
         ZNE1ok+a1dFVOdTCSha1WR3bQKr01hrpRkEd4S6wVj594Kg03HAo5pEEIPWSWXJlmv41
         p8Kg==
X-Gm-Message-State: AGRZ1gLXsM7R7nT7IGlaoCRdM1OUCHPQMDc3hDoTFWKg5wtGYxbNETKM
        aShxI3qgSqWY5Iy6IOT0Uqk=
X-Google-Smtp-Source: AJdET5cOkM5MCOkU89D8qYLdybG8sb7Pj4NcpJuA32lhrHYP2Xn7A/XPjMAwFANHK8Pvk0UWTZQ5ow==
X-Received: by 2002:a7b:c095:: with SMTP id r21mr2126638wmh.118.1542203897223;
        Wed, 14 Nov 2018 05:58:17 -0800 (PST)
Received: from evledraar (proxy-gw-a.booking.com. [5.57.21.8])
        by smtp.gmail.com with ESMTPSA id y138sm10889622wmc.16.2018.11.14.05.58.16
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 14 Nov 2018 05:58:16 -0800 (PST)
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     Johannes Schindelin <Johannes.Schindelin@gmx.de>
Cc:     git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
        Phillip Wood <phillip.wood@dunelm.org.uk>,
        gitgitgadget@gmail.com, Pratik Karki <predatoramigo@gmail.com>,
        Jeff King <peff@peff.net>
Subject: Re: [PATCH v2 2/2] tests: add a special setup where rebase.useBuiltin is off
References: <0181114090144.31412-1-avarab@gmail.com> <20181114091506.1452-3-avarab@gmail.com> <nycvar.QRO.7.76.6.1811141452520.39@tvgsbejvaqbjf.bet>
User-agent: Debian GNU/Linux testing (buster); Emacs 25.2.2; mu4e 1.1.0
In-reply-to: <nycvar.QRO.7.76.6.1811141452520.39@tvgsbejvaqbjf.bet>
Date:   Wed, 14 Nov 2018 14:58:15 +0100
Message-ID: <87tvkj222w.fsf@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Wed, Nov 14 2018, Johannes Schindelin wrote:

> Hi Ævar,
>
> On Wed, 14 Nov 2018, Ævar Arnfjörð Bjarmason wrote:
>
>> Add a GIT_TEST_REBASE_USE_BUILTIN=false test mode which is equivalent
>> to running with rebase.useBuiltin=false. This is needed to spot that
>> we're not introducing any regressions in the legacy rebase version
>> while we're carrying both it and the new builtin version.
>>
>> Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
>> ---
>>  builtin/rebase.c | 5 ++++-
>>  t/README         | 4 ++++
>>  2 files changed, 8 insertions(+), 1 deletion(-)
>
> I am slightly surprised not to see any ci/ change in this diffstat. Did
> you mean to add a test axis for Travis, or not?

No, but that's a logical follow-up by someone more familiar with the CI
setup. I'm using this so I can test versions of "next" when building my
own package.
