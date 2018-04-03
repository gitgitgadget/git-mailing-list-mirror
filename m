Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.3 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	FROM_EXCESS_BASE64,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	T_RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 126481F424
	for <e@80x24.org>; Tue,  3 Apr 2018 09:19:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1755302AbeDCJTv (ORCPT <rfc822;e@80x24.org>);
        Tue, 3 Apr 2018 05:19:51 -0400
Received: from mail-wm0-f68.google.com ([74.125.82.68]:55728 "EHLO
        mail-wm0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1755172AbeDCJTt (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 3 Apr 2018 05:19:49 -0400
Received: by mail-wm0-f68.google.com with SMTP id b127so31195819wmf.5
        for <git@vger.kernel.org>; Tue, 03 Apr 2018 02:19:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:references:user-agent:in-reply-to:date
         :message-id:mime-version:content-transfer-encoding;
        bh=EDvPYaiL3F0FlWwb8gDIo514loc1XcsDUKGPZIxoTDQ=;
        b=U7Fd3LPJoxsHfxW39iW/tK6CKvwawXg0gQM2INik1t5WTo5qtsX+SiFG1cJrrqDX3s
         enLBRBa/yEqXnnvO08lMys71NUpUDgnbnZJgj7rglp4kYrBUcX16590lpJrKRnuySOoF
         1Z5Bwd/o7ATW91PKAAUZM95xZ9b0dRw20DMtz3Tm0Z819C8yAxvD008VhB+88KAqeFkM
         y/UppVGTwyHKUMm620HJzKJl5xm1YUuNNTdwIugTfgRlyfUqCln2q6n+bfRfqW0NxrbZ
         9AA7zvU2Mi+y7Qir+pbfI74n6m5H9QTlqALHmd4U2nXJ/Rl4Fp57n4XB6jfl/XWq+rWV
         79Vw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:references:user-agent
         :in-reply-to:date:message-id:mime-version:content-transfer-encoding;
        bh=EDvPYaiL3F0FlWwb8gDIo514loc1XcsDUKGPZIxoTDQ=;
        b=Tdy79zacub8NNaoQabp6smwpu/7ySaBCg3atGudlYNMK7jilFelssDuRArgi896E/6
         abN4/zPTA1WsXZYR2vhSQIFCcLgtfiqi6fbWLtYOCYrO6/BOWDCXMM80OSMGMpNri9cq
         eIg1j8KXLrXcskAmhCFTxA+awK8Jl0yz59WSFoKo1JoYZJFms3oryi8fFhwqJVG/BGwG
         A2zBuns8xojgoVp6tddLqjJ6zt0fOko0cp6oALhk31iUVbaNRXy4ni0RFV1+zrFk/NhH
         DyEIlwqaKK13HvjNfYKo6KEX0JCRqyI1YiDNxSWS3zcccGx4R0ZsSfEaTSMRkQXs4LNC
         IOlQ==
X-Gm-Message-State: AElRT7Gm3ViBSqDIRPZdfwQ3vWjIPAJmqO915h7sWQNgtIz4NTQ+8YD2
        Dt1KsaGybOFodSXZl5cgxDAWJ/lx
X-Google-Smtp-Source: AIpwx4+fHdGzVGAtievQZ/al9DHTAKegWxiRyp+pwNm7ukqCp7iqKsv4VYOFcQKBeBJM23EB8UMBPQ==
X-Received: by 10.80.145.111 with SMTP id f44mr15729934eda.29.1522747188437;
        Tue, 03 Apr 2018 02:19:48 -0700 (PDT)
Received: from evledraar (proxy-gw-a.booking.com. [5.57.21.8])
        by smtp.gmail.com with ESMTPSA id a18sm1491899edj.89.2018.04.03.02.19.47
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 03 Apr 2018 02:19:47 -0700 (PDT)
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     Duy Nguyen <pclouds@gmail.com>
Cc:     Git Mailing List <git@vger.kernel.org>,
        Junio C Hamano <gitster@pobox.com>,
        Jeff King <peff@peff.net>,
        Ramsay Jones <ramsay@ramsayjones.plus.com>,
        Lars Schneider <larsxschneider@gmail.com>,
        ric Sunshine <sunshine@sunshineco.com>
Subject: Re: [PATCH 4/3] Makefile: untangle DEVELOPER and -Werror
References: <20180329150322.10722-1-pclouds@gmail.com>
        <20180331164009.2264-1-avarab@gmail.com>
        <CACsJy8CyB0igY365NMkswSgAi9_rf+XBOMQyJ7XW6iQxQiCEyQ@mail.gmail.com>
User-agent: Debian GNU/Linux 9.4 (stretch); Emacs 25.1.1; mu4e 1.1.0
In-reply-to: <CACsJy8CyB0igY365NMkswSgAi9_rf+XBOMQyJ7XW6iQxQiCEyQ@mail.gmail.com>
Date:   Tue, 03 Apr 2018 11:19:46 +0200
Message-ID: <87woxove8d.fsf@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Sat, Mar 31 2018, Duy Nguyen wrote:

> On Sat, Mar 31, 2018 at 6:40 PM, Ævar Arnfjörð Bjarmason
> <avarab@gmail.com> wrote:
>> Change the DEVELOPER flag, and the newly added EAGER_DEVELOPER flag
>> which (approximately) enables -Wextra so that any combination of them
>> and -Werror can be set.
>>
>> I've long wanted to use DEVELOPER=1 in my production builds, but on
>> some old systems I still get warnings, and thus the build would
>> fail. However if the build/tests fail for some other reason, it would
>> still be useful to scroll up and see what the relevant code is warning
>> about.
>>
>> This change allows for that. Now setting DEVELOPER will set -Werror as
>> before, but if DEVELOPER_NONFATAL is set you'll get the same warnings,
>> but without -Werror.
>>
>> I've renamed the newly added EAGER_DEVELOPER flag to
>> DEVELOPER_EXTRA. The reason is that it approximately turns on -Wextra,
>> and it'll be more consistent to add e.g. DEVELOPER_PEDANTIC later than
>> inventing some new name of our own (VERY_EAGER_DEVELOPER?).
>
> Before we go with zillions of *DEVELOPER* maybe we can have something
> like DEVOPTS where you can give multiple keywords to a single variable
> to influence config.mak.dev. This is similar to COMPILER_FEATURES we
> already have in there, but now it's driven by the dev instead of the
> compiler. So you can have keywords like "gentle" (no -Werror) "extra"
> (-Wextra with no suppression) and something else.

We could do that, but I don't think it's that bad. This patch is one
extra option on top of yours, and it's not going to result in some
combinatorial explosion of options, i.e. if we add DEVELOPER_PEDANTIC
we'll just add one extra flag.

But sure, we could make this some string we'd need to parse out similar
to COMPILER_FEATURES, it just seems more complex to me for this task.
