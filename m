Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id BEA561F404
	for <e@80x24.org>; Fri,  9 Feb 2018 19:07:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752374AbeBITHB (ORCPT <rfc822;e@80x24.org>);
        Fri, 9 Feb 2018 14:07:01 -0500
Received: from mail-wr0-f175.google.com ([209.85.128.175]:40426 "EHLO
        mail-wr0-f175.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752294AbeBITG7 (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 9 Feb 2018 14:06:59 -0500
Received: by mail-wr0-f175.google.com with SMTP id o76so6147899wrb.7
        for <git@vger.kernel.org>; Fri, 09 Feb 2018 11:06:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:references:user-agent:in-reply-to:date
         :message-id:mime-version:content-transfer-encoding;
        bh=NJfn4RAfswAY8HwSE5L0JhIPz7KPror6LMtjJa8RGVU=;
        b=sbqQl2oTYTf4ChRKSJ0p7v1r09TYd6lej6xnFviwxakoK7pzitGMdJwDlbb9CLJZIU
         zxkGhs0X8dMQPv2UwyQ+pVIGVESYCoBTMErgcpOMWkbwSrKVzBjE54XMXhRQ+SMS9HYC
         X9OPr3cdWvamwLjmytD4rUnZix8pelNGSXrkykrme/swSaFv5BJNvHBmdgQE+IyTutGe
         shGd/yMH6wL8gA9wl5YFlRrOWnHf7p42bkYTVj/gCgnncLIMSjMzsvSmzPqkg0Nle8I3
         2oboyL6r1M2PQCU5Okk0F5b4UOT8Uz4YZlxltAu+4P4gxfKkSBkbPh02L6t5QlKTl8BU
         hV0w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:references:user-agent
         :in-reply-to:date:message-id:mime-version:content-transfer-encoding;
        bh=NJfn4RAfswAY8HwSE5L0JhIPz7KPror6LMtjJa8RGVU=;
        b=tQnYJp6tLB9HQuQePwpjERwxsmr+ru/4aY97yUQIO1BIamaK2+oYRu1QS3zqKda8rQ
         xM6MriWvhvhfBC+Bo4ZcUU+M5hIlQWDaZhpmwPZo7XpnhXuDSU0mY6KCYEwINTwlPmEG
         jY06pwUt2+28GIXoBxkVb9+34TDj5dliKwQ99JaCl+rQgolWwBq5Nss4Rgu3EOxrky6O
         G1yDk58drTeFpMV5Bk7audMI+6iqr9rJ1S/4JIoazSpX0jZcvI5eYbMxWdBoytzAS5rh
         rmZrs92dEgG1ph/+roF1A2s8KAurS1kOo3eaS9RoYYzEBA/bfNrwbaV0dE/gedI9jRAJ
         gShg==
X-Gm-Message-State: APf1xPD1zPDh7Zj5hT5BKBFgONnJc8pqPZYrOT8bvbJnlDsY0ead6vgW
        sWcH6IzC1JD0jc6XsCz+VEY=
X-Google-Smtp-Source: AH8x224zQuuol1SiD2nZwcfKoAqBeXJwAM9Oc2zrW8SFA+inaMQVnAgLNS2ZVmt3ex2vQhkBWZFHTQ==
X-Received: by 10.223.171.3 with SMTP id q3mr3244769wrc.64.1518203217919;
        Fri, 09 Feb 2018 11:06:57 -0800 (PST)
Received: from evledraar (178-84-79-100.dynamic.upc.nl. [178.84.79.100])
        by smtp.gmail.com with ESMTPSA id m1sm2900521wrb.78.2018.02.09.11.06.56
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 09 Feb 2018 11:06:56 -0800 (PST)
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     Eric Sunshine <sunshine@sunshineco.com>
Cc:     Git List <git@vger.kernel.org>, Junio C Hamano <gitster@pobox.com>,
        Michael Giuffrida <michaelpg@chromium.org>,
        Michael Schubert <mschub@elegosoft.com>,
        Jeff King <peff@peff.net>,
        Daniel Barkalow <barkalow@iabervon.org>
Subject: Re: [PATCH v2 01/17] fetch: don't redundantly NULL something calloc() gave us
References: <20180123221326.28495-1-avarab@gmail.com> <20180208161936.8196-1-avarab@gmail.com> <20180208161936.8196-2-avarab@gmail.com> <CAPig+cTwQj0UPvRy9xAF1kbyR8vx4WCsvb0KXsS5GQcDLiqcuQ@mail.gmail.com>
User-agent: Debian GNU/Linux 9.3 (stretch); Emacs 25.1.1; mu4e 1.0-alpha3
In-reply-to: <CAPig+cTwQj0UPvRy9xAF1kbyR8vx4WCsvb0KXsS5GQcDLiqcuQ@mail.gmail.com>
Date:   Fri, 09 Feb 2018 20:06:53 +0100
Message-ID: <871shum182.fsf@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Fri, Feb 09 2018, Eric Sunshine jotted:

> On Thu, Feb 8, 2018 at 11:19 AM, Ævar Arnfjörð Bjarmason
> <avarab@gmail.com> wrote:
>> Stop redundantly NULL-ing the last element of the refs structure,
>> which was retrieved via calloc(), and is thus guaranteed to be
>> pre-NULL'd.
>> [...]
>> Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
>> ---
>> diff --git a/builtin/fetch.c b/builtin/fetch.c
>> @@ -1302,7 +1302,6 @@ static int fetch_one(struct remote *remote, int argc, const char **argv)
>>                         } else
>>                                 refs[j++] = argv[i];
>>                 }
>> -               refs[j] = NULL;
>>                 ref_nr = j;
>>         }
>
> This is purely subjective, and I neglected to mention it as early as
> v1, but I find that this change hurts readability. Specifically, as
> I'm scanning or reading code, explicit termination conditions, like
> this NULL assignment, are things I'm expecting to see; they're part of
> the idiom of the language. When they're missing, I have to stop, go
> back, and study the code more carefully to see if the "missing bit" is
> a bug or is intentional. And, it's easy to misread xcalloc() as
> xmalloc(), meaning that it's likely that one studying the code would
> conclude that the missing NULL assignment is a bug.
>
> If anything, if this patch wants to eliminate redundancy, I'd expect
> it to change xcalloc() to xmalloc() and keep the NULL assignment, thus
> leaving the idiom intact.

Thanks for all your review, really appreciate it.

I'm going to keep this as-is, reasons:

 * With calloc it's easier to look at the values in a debugger, you get
   NULLs instead of some random garbage for e.g. the ref src/dst. It
   makes it clear it's unset / the tail value.

 * Ditto fewer things to step through / inpect in a debugger. E.g. I
   have a dump of variables before/after in the debugger, with
   assignments like this it's just adding verbosity & something to
   eyeball for something that's never going to change.

 * If there's a bug in the code using calloc is likely to reveal it
   sooner, since you'll be deref-ing NULL instead of some stray
   (possibly still valid) pointer you got from malloc.

 * It looks more in line with established idioms in the codebase. I
   wasn't able to find other cases where we were double-NULL ing
   calloc'd data, but rather stuff like this:

       git grep -W '\bpattern\b' -- '*/ls-remote.c'
