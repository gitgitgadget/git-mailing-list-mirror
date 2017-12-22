Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 242891F406
	for <e@80x24.org>; Fri, 22 Dec 2017 20:43:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1756776AbdLVUnJ (ORCPT <rfc822;e@80x24.org>);
        Fri, 22 Dec 2017 15:43:09 -0500
Received: from mail-wm0-f43.google.com ([74.125.82.43]:35197 "EHLO
        mail-wm0-f43.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1756760AbdLVUnH (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 22 Dec 2017 15:43:07 -0500
Received: by mail-wm0-f43.google.com with SMTP id f9so23819692wmh.0
        for <git@vger.kernel.org>; Fri, 22 Dec 2017 12:43:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:references:user-agent:in-reply-to:date
         :message-id:mime-version:content-transfer-encoding;
        bh=sNauOH7qMOWxmTwRtrO3YRYo2ugYnqP+VqT0L5ucnI8=;
        b=f8MiyXt1TZTFp6GKggsFiUNmIXzB/s/ezZKLrxWkyoOdLvsITARbo5WrOGjb4/t59Y
         lg2GJ7ykJSVYPUHdKsdaKHpV5TwMK+ebLAqxAuUeo0UIlRvIeh0hNx2/uxLygSLBH90Z
         iRUqVx11wcO+wuU4heqJqpnfCThcBz9G0dYWs0KnjRwuUNUH+32e0Rrh6lUc6elZS1Zd
         QwE0B8gJRYO8F12J9Y69SiUW5BU8DHnG23bNG6BwUAOJmgUWDUO/6NjfZfTOQtck1RZ2
         +PIP6d9oiqB17/y95sw6tFBJ+zoFz+YHStBl+Be0pz01N3/THL212CAB9cZH4bxZQ/Tk
         BBMw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:references:user-agent
         :in-reply-to:date:message-id:mime-version:content-transfer-encoding;
        bh=sNauOH7qMOWxmTwRtrO3YRYo2ugYnqP+VqT0L5ucnI8=;
        b=IDgIVATpAyTlNCieXT8QgZO74hPq7MRnqbs0d45orb5ANSlEaZXmI5GFgby7/ojy+4
         NAifN6eVLPAkwpGncxVL4BvudnHaDhexJRDa4LVJLp5nmf5cFwPOSv4m6pFxQR4UuOTF
         7yshLcLl/loITDmxNL/8G+LWEg8/Aa/HKikC+l+bDJms7iRUgXyR3l77Ey/PSfiqzQiC
         Qnf/pgxzIah2DUF8+dhCAXDd0+QBRD/MFtqvVhtQ4qq5afLRLHm96S+tH8gFXvXh2g0x
         XGS17ewb9jc1LHSRKAyD+iURm87cl0YX0rjqo73HCGGJTxXg6FYrYCn83WB3eTFqcSlQ
         FT7g==
X-Gm-Message-State: AKGB3mKGfHUsZiDd3q3fZ3WFvpoS8EtZYTpq1h1OsOi14Ndyvp3MY+V0
        XzN0VZFLlXv8GWQzqiBQqLI=
X-Google-Smtp-Source: ACJfBovXM8rY3dcJO0OTrCQKRpI4hAy8AHlS1XAhyOHYpEYYEGqm+NeS6JgqW01870iyt1ScFDNIIw==
X-Received: by 10.80.146.207 with SMTP id l15mr16643702eda.194.1513975386819;
        Fri, 22 Dec 2017 12:43:06 -0800 (PST)
Received: from evledraar (178-84-79-100.dynamic.upc.nl. [178.84.79.100])
        by smtp.gmail.com with ESMTPSA id o60sm20247140edb.79.2017.12.22.12.43.05
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 22 Dec 2017 12:43:05 -0800 (PST)
Received: from avar by evledraar with local (Exim 4.89)
        (envelope-from <avarab@gmail.com>)
        id 1eSU9o-0003ly-RU; Fri, 22 Dec 2017 21:43:04 +0100
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     Eric Sunshine <sunshine@sunshineco.com>
Cc:     Git List <git@vger.kernel.org>, Junio C Hamano <gitster@pobox.com>,
        Pat Notz <patnotz@gmail.com>
Subject: Re: [PATCH v2 0/2] support -m"<msg>" combined with commit --fixup
References: <CAPig+cRDi14Rez+6ZJAEdxHpo0Mw7JQFkcuG2oVqv2pP_ZbvhQ@mail.gmail.com> <20171222160056.10102-1-avarab@gmail.com> <CAPig+cQj8=YFRBQZ3+9NJAsr2rNq0GvxrUpmt18ttvmVu1Nyhg@mail.gmail.com>
User-agent: Debian GNU/Linux 9.3 (stretch); Emacs 25.1.1; mu4e 0.9.19
In-reply-to: <CAPig+cQj8=YFRBQZ3+9NJAsr2rNq0GvxrUpmt18ttvmVu1Nyhg@mail.gmail.com>
Date:   Fri, 22 Dec 2017 21:43:04 +0100
Message-ID: <87k1xesdd3.fsf@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Fri, Dec 22 2017, Eric Sunshine jotted:

> On Fri, Dec 22, 2017 at 11:00 AM, Ævar Arnfjörð Bjarmason
> <avarab@gmail.com> wrote:
>> Here's a hopefully ready to apply v2 incorporating feedback from Eric
>> (thanks!). A tbdiff with v1 follows below.
>>
>> Ævar Arnfjörð Bjarmason (2):
>>   commit doc: document that -c, -C, -F and --fixup with -m error
>>   commit: add support for --fixup <commit> -m"<extra message>"
>
> Patch 2/2 doesn't seem to have made it to the list...

Oops, here it comes.

>> 2: bd78a211ed ! 2: 780de6e042 commit: add support for --fixup <commit> -m"<extra message>"
>>     @@ -22,6 +22,21 @@
>>             In such a case you might want to leave a small message,
>>             e.g. "forgot this part, which broke XYZ".
>>
>>     +    With this, --fixup <commit> -m"More" -m"Details" will result in a
>>     +    commit message like:
>>     +
>>     +        !fixup <subject of <commit>>
>>     +
>>     +        More
>>     +
>>     +        Details
>>     +
>>     +    The reason the test being added here seems to squash "More" at the end
>>     +    of the subject line of the commit being fixed up is because the test
>>     +    code is using "%s%b" so the body immediately follows the subject, it's
>>     +    not a bug in this code, and other tests t7500-commit.sh do the same
>>     +    thing.
>
> Did you also intend to mention something about --edit still working
> with -m? (Or do we assume that people will understand automatically
> that it does?)

I thought it was clear enough since it works with --fixup now and with
everything else, and the commit message was already getting long
enough...
