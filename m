Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	FROM_EXCESS_BASE64,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 318F81F42D
	for <e@80x24.org>; Tue, 22 May 2018 11:39:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752599AbeEVLjc (ORCPT <rfc822;e@80x24.org>);
        Tue, 22 May 2018 07:39:32 -0400
Received: from mail-wm0-f65.google.com ([74.125.82.65]:51498 "EHLO
        mail-wm0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751390AbeEVLip (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 22 May 2018 07:38:45 -0400
Received: by mail-wm0-f65.google.com with SMTP id j4-v6so31072857wme.1
        for <git@vger.kernel.org>; Tue, 22 May 2018 04:38:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:references:user-agent:in-reply-to:date
         :message-id:mime-version;
        bh=MVB3m04vYdQa7PY4428kDM85T2zrB5KEg2jQWtRhl8E=;
        b=tOAA636qvaLEZAXxi6l/L+isSw2rqKhhy3Dp+6aU+DBBM+vFNE5TCcRXXZUwb1DB7r
         lP3RsIArx5siYas+7/pCVyWsprmOnulS4GoMVZCeqQmhVTm34CmreLyEZrzjVZ74+IsG
         pGjo2HX0mO7s9rJFjCz0UNhXxjOsCa9e5JMweCBCSht+8S+/hX9uJQ4v/ild2e/t/O3A
         ub74L5BHgZpPgWMzXZBjoij0Iwcb8alaOt1F4fjQH9RJi4LRJ0o7CmksXenFKaejBUF6
         U29stsqAfJQOiEFYBmwDMtQjq3fdz5wcceELP8prh244wDh5n13KtrZAzMkby92eLo5g
         bF6w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:references:user-agent
         :in-reply-to:date:message-id:mime-version;
        bh=MVB3m04vYdQa7PY4428kDM85T2zrB5KEg2jQWtRhl8E=;
        b=uh+mwyKdphE+NF3ytKbO8XpguXTkFpYo3JKCuAeJE/VpjjPutwaNNLfUgNq3BdFjRk
         tkjNoAR0luJ2fLfekPwJVV7QAseVOCD7LMtfktE9jY5VkHIw/mUM1jyerj6EDlNgZY6P
         S87mYDVHpKitGCMycg697kiBUC2gI04ZUbJG3kfHWYoiRF7Uwg+jD69C5/GU7i0qwb1U
         wZBI89aKHe5lgSNAXp9FBJHd3ZVMKcYkgDcUSYCeIO3QhTA/gSb3ztp0Gy7Gzu9FapmV
         4+6UnW5eFVtKmtRpJtvb2qxr46x9pPCuOZxqRK7ve4JiX4HzIc9sfieqibcIDShV73QP
         3qgg==
X-Gm-Message-State: ALKqPwfERJIgulBO/jBd00fyJAr9QrRkgta8qy+L1Lc3lqdGUUPwiWdY
        bOA4Nu4V87Lxh3JaQ2lwWUk=
X-Google-Smtp-Source: AB8JxZpm6tepZ/JQZ1pgvGkCXFPrPd9fCuvw3994d7C4YAyDNlACtnmicBhv/GucBdRwDpkJnRkEtQ==
X-Received: by 2002:a1c:8045:: with SMTP id b66-v6mr866201wmd.108.1526989123809;
        Tue, 22 May 2018 04:38:43 -0700 (PDT)
Received: from evledraar (dhcp-089-098-184-206.chello.nl. [89.98.184.206])
        by smtp.gmail.com with ESMTPSA id z66-v6sm16494519wme.13.2018.05.22.04.38.42
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 22 May 2018 04:38:42 -0700 (PDT)
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     Jeff King <peff@peff.net>
Cc:     Stefan Beller <sbeller@google.com>,
        Igor Djordjevic <igor.d.djordjevic@gmail.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        git <git@vger.kernel.org>, Junio C Hamano <gitster@pobox.com>,
        Thomas Rast <tr@thomasrast.ch>,
        Thomas Gummerer <t.gummerer@gmail.com>,
        Ramsay Jones <ramsay@ramsayjones.plus.com>,
        Jacob Keller <jacob.keller@gmail.com>,
        Eric Sunshine <sunshine@sunshineco.com>
Subject: Re: [PATCH v2 02/18] Add a new builtin: branch-diff
References: <cover.1525448066.git.johannes.schindelin@gmx.de>
        <a1ea0320b64527ee6ce9856dcf359513d13052b7.1525448066.git.johannes.schindelin@gmx.de>
        <20180505182631.GC17700@sigill.intra.peff.net>
        <nycvar.QRO.7.76.6.1805052355190.77@tvgsbejvaqbjf.bet>
        <39282590-576f-1ac1-6a16-80ad317ec7ed@gmail.com>
        <nycvar.QRO.7.76.6.1805061408150.77@tvgsbejvaqbjf.bet>
        <e0db15c5-e897-5b03-20ff-d83f38496e61@gmail.com>
        <nycvar.QRO.7.76.6.1805062124470.77@tvgsbejvaqbjf.bet>
        <3b4591cd-6dde-31ee-f0b1-42b5353086e5@gmail.com>
        <CAGZ79kZbRCH2OiTW1Ge31R9JN+vWD6tcjNWVGSzkSBcYZvwDjw@mail.gmail.com>
        <20180508034429.GA7242@sigill.intra.peff.net>
User-agent: Debian GNU/Linux testing (buster); Emacs 25.2.2; mu4e 1.1.0
In-reply-to: <20180508034429.GA7242@sigill.intra.peff.net>
Date:   Tue, 22 May 2018 13:38:41 +0200
Message-ID: <87in7f9aym.fsf@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Tue, May 08 2018, Jeff King wrote:

> On Mon, May 07, 2018 at 03:24:59PM -0700, Stefan Beller wrote:
>
>> Hence I propose "git range-diff", similar to topic-diff, that
>> was proposed earlier.
>>
>> * it "diffs ranges" of commits.
>> * it can also deal with out-of-git things like patch series,
>>   but that is a mere by product and may not be desired.
>>   Just like git-diff can also compare two files outside a git
>>   repo, that would not be a good use case.
>>   Keep the name Git-centric!
>> * it autocompletes well.
>
> FWIW, I like this by far of all of the suggested names.

I agree, "range-diff" is the best one mentioned so far.
