Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 87D601F597
	for <e@80x24.org>; Fri, 20 Jul 2018 23:52:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728305AbeGUAmx (ORCPT <rfc822;e@80x24.org>);
        Fri, 20 Jul 2018 20:42:53 -0400
Received: from mail-ua0-f196.google.com ([209.85.217.196]:47046 "EHLO
        mail-ua0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727224AbeGUAmx (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 20 Jul 2018 20:42:53 -0400
Received: by mail-ua0-f196.google.com with SMTP id r18-v6so8461881ual.13
        for <git@vger.kernel.org>; Fri, 20 Jul 2018 16:52:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=CaUiR4h19VA+xvGzefCin1xtyvC4Z8aVzZN+tS1DPis=;
        b=WocVLv7JxG5N/6pJw80IiZIOPZG/EazamqtZPQ0C5OXRbJloB09nZoL0wc8IRls67M
         XYYenrLGEZsMhajnyF3ArGL/xm9/YQ7Ar2iz5ZyMPtatd+Sm8/PZPUKL99prugw2dPDH
         k4yN8A58hNbJCQQEVICs0pnLw0b8VzGT7XjE0/YHohT0x03WEMfS992jRF4v21ldmfzG
         Pq7ni6pF5Sz5iQAEZNLrTeKduttbhrAXjdzc164RCKrx4rsx0h5qzyqqmomwDgtnK5cy
         EGAywPV1i8awEEr0+Aq9F044+rqNXI9tOHWzHH4q58OsQTyeTsvFhtLJBqQpBveYd1bB
         ll+g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=CaUiR4h19VA+xvGzefCin1xtyvC4Z8aVzZN+tS1DPis=;
        b=n31E2KoTvRj0opP3jseHo5XbumeTu/xdwNeCwp/ZQSK0L49CknotzBsUKTOM9B+Ubf
         MJn1hErCoRoxQZjKHgP8vbbbUQ8BJ9WErzBV58AXKSy078fDKVe9MQvXvmuDWAY2jEwA
         TqGf5bRW2I2fqz+9kBWd7ohF+DCw8BOv9/ygmH+37kXalgb94fIz1MiBKLXGfx/si7/s
         /0GK0M7EB8NhMg6LvV9vH8pxrRl2rZ4GXN3qLV5QsW19gQSwJv8/PURualND6Mj6BXrR
         D60pr4MR50Nb4T5TKE8V+Be2qxIK3PufsiU79OjiIlS/npThtpLlURzMcoEmotZK5gnx
         +xiA==
X-Gm-Message-State: AOUpUlFFw6q7nAhFOSrkzMGh3osw7lNhNYI6icUmcYUkz8xIUKMWbuVo
        x/JuMXhQc+Zmh1eutHDsYWwnBRl9IwZ9cxXPPXs=
X-Google-Smtp-Source: AAOMgpcpjDJuGVqYMPt1jbGrmzt+L/Zf/R/exP8Vi12NWEYgUrfggMwE+0jWAXnoqlnKIhyhQ43TMKouah1unYO9rgw=
X-Received: by 2002:a9f:3563:: with SMTP id o90-v6mr2819342uao.79.1532130740405;
 Fri, 20 Jul 2018 16:52:20 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:ab0:21c7:0:0:0:0:0 with HTTP; Fri, 20 Jul 2018 16:52:19
 -0700 (PDT)
In-Reply-To: <CABPp-BGJAWXOCPsej=fWWDJkh-7BAV9m8yEDiy2NVkGTRCmk4A@mail.gmail.com>
References: <20180718225110.17639-1-newren@gmail.com> <20180720153943.575-1-pclouds@gmail.com>
 <CABPp-BGJAWXOCPsej=fWWDJkh-7BAV9m8yEDiy2NVkGTRCmk4A@mail.gmail.com>
From:   Elijah Newren <newren@gmail.com>
Date:   Fri, 20 Jul 2018 16:52:19 -0700
Message-ID: <CABPp-BF5O2-DQMSjN67HYsHHYHP_VH-N-C=k796NwPTvtwf7gQ@mail.gmail.com>
Subject: Re: [PATCH] pack-objects: fix performance issues on packing large deltas
To:     =?UTF-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41jIER1eQ==?= 
        <pclouds@gmail.com>
Cc:     Git Mailing List <git@vger.kernel.org>,
        Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, Jul 20, 2018 at 10:43 AM, Elijah Newren <newren@gmail.com> wrote:
> On Fri, Jul 20, 2018 at 8:39 AM, Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Du=
y <pclouds@gmail.com> wrote:

>> This patch provides a better fallback that is
>>
>> - cheaper in terms of cpu and io because we won't have to read
>>   existing pack files as much
>>
>> - better in terms of pack size because the pack heuristics is back to
>>   2.17.0 time, we do not drop large deltas at all
>>
>> If we encounter any delta (on-disk or created during try_delta phase)
>> that is larger than the 2MB limit, we stop using delta_size_ field for
>> this because it can't contain such size anyway. A new array of delta
>> size is dynamically allocated and can hold all the deltas that 2.17.0
>> can [1]. All current delta sizes are migrated over.
>>
>> With this, we do not have to drop deltas in try_delta() anymore. Of
>> course the downside is we use slightly more memory, even compared to
>> 2.17.0. But since this is considered an uncommon case, a bit more
>> memory consumption should not be a problem.

Is the increased memory only supposed to affect the uncommon case?  I
was able to verify that 2.18.0 used less memory than 2.17.0 (for
either my repo or linux.git), but I don't see nearly the same memory
reduction relative to 2.17.0 for linux.git with your new patches.

>> ---
>>  I'm optimistic that the slowness on linux repo is lock contention
>>  (because if it's not then I have no clue what is). So let's start
>>  doing proper patches.
>
> I'll be testing this shortly...

Using these definitions for versions:

  fix-v5: https://public-inbox.org/git/20180720052829.GA3852@sigill.intra.p=
eff.net/
(plus what it depends on)
  fix-v6: The patch I'm responding to
  fix-v2: https://public-inbox.org/git/20180718225110.17639-3-newren@gmail.=
com/

and inspired by
https://public-inbox.org/git/87po42cwql.fsf@evledraar.gmail.com/, I
ran

   /usr/bin/time -f 'MaxRSS:%M Time:%e' git gc --aggressive

three times on a beefy box (40 cores, 160GB ram, otherwise quiet
system).  If I take the lowest MaxRSS, and the lowest time reported
(regardless of whether from the same run), then the results are as
follows for linux.git (all cases repacked down to 1279 MB, so removing
that from the table):

Version  MaxRSS(kB)  Time (s)
-------  ----------  --------
 2.17.0   11413236    621.36
 2.18.0   10987152    621.80
 fix-v5   11105564    836.29
 fix-v6   11357304    831.73
 fix-v2   10873348    619.96

The runtime could swing up to 10 seconds between runs.  The memory use
also had some variability, but all runs of fix-v2 had lower MaxRSS
than any runs of 2.18.0 (which surprised me); all runs of 2.18.0 used
less memory than any run of fix-v6, and all runs of fix-v6 used less
memory than any run of 2.17.0.  fix-v5 had the most variabiilty in
MaxRSS, ranging from as low as some 2.18.0 runs up to higher than any
2.17.0 runs.

...but maybe that'd change with more than 3 runs of each?

Anyway, this is a lot better than the 1193.67 seconds I saw with
fix-v4 (https://public-inbox.org/git/20180719182442.GA5796@duynguyen.home/,
which Peff fixed up into fix-v5), suggesting it is lock contention,
but we're still about 33% slower than 2.17.0 and we've lost almost all
of the memory savings.  Somewhat surprisingly, the highly simplistic
fix-v2 does a lot better on both measures.


However, I'm just concentrating on a beefy machine; it may be that v6
drastically outperforms v2 on weaker hardware?  Can others measure a
lower memory usage for v6 than v2?


Also, for the original repo with the huge deltas that started it all,
the numbers are (only run once since it takes so long):

Version  Pack (MB)  MaxRSS(kB)  Time (s)
-------  ---------  ----------  --------
 2.17.0     5498     43513628    2494.85
 2.18.0    10531     40449596    4168.94
 fix-v5     5500     42805716    2577.50
 fiv-v6     5509     42814836    2605.36
 fix-v2     5509     41644104    2468.25


>>  If we want a quick fix for 2.18.1. I suggest bumping up
>>  OE_DELTA_SIZE_BITS like Elijah did in his second option. I don't
>>  think it's safe to fast track this patch.
>
> Okay, I'll submit that with a proper commit message then.  Since you
> also bump OE_DELTA_SIZE_BITS in your patch (though to a different
> value), it'll require a conflict resolution when merging maint into
> master, but at least the change won't silently leak through.

...except now I'm wondering if the commit message should mention that
it's just a stopgap fix for 2.18.1, or whether it's actually the fix
that we just want to use going forward as well.
