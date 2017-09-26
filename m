Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 144E720281
	for <e@80x24.org>; Tue, 26 Sep 2017 15:40:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S967934AbdIZPk1 (ORCPT <rfc822;e@80x24.org>);
        Tue, 26 Sep 2017 11:40:27 -0400
Received: from mail-it0-f50.google.com ([209.85.214.50]:56428 "EHLO
        mail-it0-f50.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S965399AbdIZPk0 (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 26 Sep 2017 11:40:26 -0400
Received: by mail-it0-f50.google.com with SMTP id g18so3339050itg.5
        for <git@vger.kernel.org>; Tue, 26 Sep 2017 08:40:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=H66GxwwmdEURZrMX2NaT5Cj0lKm7J7pY/GFuAst2oTg=;
        b=VnQs597j2MC4O9LaZFrJh+NmHOxFo5Ygq7HsMt5/Vwnu6j3C4FB4rHENMrYLO27PhL
         jbWDleT5aVRvi8y27Zmzc2yExwxFk+T5jIAZ75nWC84l+gUcN0dcbpukxQSvAmBUGtQz
         Z9xQeEJEXkUsCIahcF1b426n6FP0zvPCZcSZbg640pYc+4udMjvbSQre4TJN9yKjo0/m
         L85T1IjaBy0BlGLvnzXMgEUTQqZFQwHwt0tV7qQcnS3kLHvQPJY5q/TCn5cgn8Jlu9nl
         ci5aWStinwvU89/a3yhbEyfqcMI1IgC5EpomGxVvGj7hwGChO1dPntrHE8sZxQxJ3lFS
         LuVQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=H66GxwwmdEURZrMX2NaT5Cj0lKm7J7pY/GFuAst2oTg=;
        b=AR91RfrGcoHwmR1rTTOXOLYrTSx376Ya101cEswboTGayFDfySBFwGRNpeNSfBG4iZ
         n+I1CsPr9QQRnDAeBYf+r/SSXgWufM4nYRlKip6joFnNIutENH9tvpLMTtYznVttmmdI
         oTVXIBo49cJ7aGjDeIJYbtNMlFppe5n/UfML1G/V/Az4qzGCxAnEwbuF7tkYP7azvyhr
         Ka5CS3NG8tT413d+f+epDVDjDchbc0RQz2keGHjrYiy0a4FBFUeg6SXdBUGz4dAYk713
         AI1XAgyz6Wrlf3AWD5ImLZDE4X1pP7uq/uX4uWknI4txGIXbek/bgZq1a4grc9Cdymjl
         v7Pg==
X-Gm-Message-State: AHPjjUgmkBCtu7YbaUnjuoyjamF6Mu9TqJlnuu1EUByy/UCN1ussCyWr
        qkBoViE+opOtJu2z2qYKeJ5dEzUUUIBfERylRQk=
X-Google-Smtp-Source: AOwi7QAQtr+TBTgOuSF27z79Z5VIWU/Rit3ujucGA9yLZ4h6XPWDMlAkC4ZGD7KfZRqYSAEo+XiEuRgi+Fx/7Qs56Ig=
X-Received: by 10.36.111.4 with SMTP id x4mr6031827itb.144.1506440425399; Tue,
 26 Sep 2017 08:40:25 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.79.107.136 with HTTP; Tue, 26 Sep 2017 08:40:24 -0700 (PDT)
In-Reply-To: <xmqqbmm0h6h1.fsf@gitster.mtv.corp.google.com>
References: <CAP8UFD2j-UFh+9awz91gtZ-jusq7EUOExMgURO59vpf29jXS4A@mail.gmail.com>
 <xmqqbmm0h6h1.fsf@gitster.mtv.corp.google.com>
From:   Christian Couder <christian.couder@gmail.com>
Date:   Tue, 26 Sep 2017 17:40:24 +0200
Message-ID: <CAP8UFD1C80cHnMtdZ-iTYQpNNErUEJ9TmQ9baG1J2w+pv1ceSw@mail.gmail.com>
Subject: Re: [PATCH v2 0/9] Teach 'run' perf script to read config files
To:     Junio C Hamano <gitster@pobox.com>
Cc:     git <git@vger.kernel.org>, Jeff King <peff@peff.net>,
        Thomas Rast <tr@thomasrast.ch>,
        =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>,
        Roberto Tyley <robertotyley@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Sun, Sep 24, 2017 at 9:59 AM, Junio C Hamano <gitster@pobox.com> wrote:
> Christian Couder <christian.couder@gmail.com> writes:
>
>> (It looks like smtp.gmail.com isn't working anymore for me, so I am
>> trying to send this using Gmail for the cover letter and Submitgit for
>> the patches.)
>
> SubmitGit may want to learn the "change the timestamps of the
> individual patches by 1 second" trick from "git send-email" to help
> threading (you can view inbox/comp.version-control.git/ group over
> nntp and tell your newsreader to sort-by-date).

Roberto is now in CC. I will let him answer about that.

>> Highlevel view of the patches in the series
>> ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
>>
>>   - Patches 1/9 to 4/9 were already in v1 and haven't changed.
>
> It isn't quite clear what _did_ change in the series and what
> lessons were learned form the previous round's discussion here.

In the previous round of discussion, I think the reviewers (you and
Peff) basically agreed that it was worth improving the test framework
to make it possible to easily run many tests, though reviewers were
not sure if what I had planned to do would in the end be a good
solution.

(See https://public-inbox.org/git/20170713065050.19215-1-chriscool@tuxfamily.org/)

So what did change is that I implemented what was in the "Future work"
section in v1.

> The
> sample configuration in the description above (snipped) seems to
> have been extended and it shows that one of the use cases of the
> feature is to allow comparing runs against two versions, which
> looked more or less sensible way to express it.

[...]

> Thanks.  Let me see how well it works ;-)

Thanks for testing ;-)
