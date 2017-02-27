Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 5B8272022D
	for <e@80x24.org>; Mon, 27 Feb 2017 00:34:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751407AbdB0Aeu (ORCPT <rfc822;e@80x24.org>);
        Sun, 26 Feb 2017 19:34:50 -0500
Received: from mail-ua0-f180.google.com ([209.85.217.180]:36170 "EHLO
        mail-ua0-f180.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751118AbdB0Aet (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 26 Feb 2017 19:34:49 -0500
Received: by mail-ua0-f180.google.com with SMTP id 72so19068083uaf.3
        for <git@vger.kernel.org>; Sun, 26 Feb 2017 16:34:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=TAXv1R3ckXVWRVpELqX6sRouYbAY8RINrUp0ZyS8IRs=;
        b=asmm980eZaTuFrameEDUioo10IJOKHXC2LEX4/XbnnBw4L6NPeKXwZb6RbeGXumjPG
         WViOTA22l97YJMuHSSfPUQwfTjbJqSQLipranePiAAIxi9IxFl2yFJO4E7OjVm/ViBa4
         i08mN32mdreKa+okMw0Fa38JS/qK6MY1RCJ8Q8mTZ92BSBl4QS9aODE/XvUGRAskB9J0
         ELaPLHf7510+dRqBZeFMcHY6z/SWBfEoD0/xPAmLnPIcPg6PCSjmNALTvI88/PFsIEmR
         F1wr/N8DYSvkyUfZqMp2pTmqNZemDOZfGFoiajcTkdzby3GFG8A1yQPeSnCdGVLhKw2E
         3Y0w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=TAXv1R3ckXVWRVpELqX6sRouYbAY8RINrUp0ZyS8IRs=;
        b=UT9TNjz7shTfD0/eKJRgI3PxYasJlUdOja1f2RCOJmrDneJ/+CyYtcLiDcrRGx6Lbq
         c1emwNdgGgkzm0JrujnhEqQgVLulJPxGOsxBuyyrGi+slvXk8aGRzFUVsIesKjsZUKmG
         GYqtV4CBcbt/Lg8UjGmd55KaXMfu5SzIS0NJ+rLJ+g4oM7vSG7TPQF0FVu+HwJ7rEA1b
         8VHADVBTNRbb3ngNfNLnJeXxaydKiTxJIyX+vG763r3yPh1A36V0Oq9L/nsfloCqhn/D
         2+fpYfuhhw2O00O4/4ZIdJMn1tPGkE9i8OkzVisJsorbbAvVtia2tS48jM4mFGAWndFr
         MH4w==
X-Gm-Message-State: AMke39loxXjMXmcbJP792x6IcUYLNUGkmXdB4khQ0+2UlsihQIZeWKCn34+krE6v7Q6YMcDTYOOpoHurLG9eRA==
X-Received: by 10.31.67.209 with SMTP id q200mr3038331vka.43.1488155688442;
 Sun, 26 Feb 2017 16:34:48 -0800 (PST)
MIME-Version: 1.0
Received: by 10.159.34.73 with HTTP; Sun, 26 Feb 2017 16:34:08 -0800 (PST)
In-Reply-To: <71030110-EB19-4F54-95F1-443D3EAE5286@gmail.com>
References: <CAJZjrdXP3n5fOLx4rEEkbJT7JBMPUqk4Qdutm6KpvMVUMwCSPQ@mail.gmail.com>
 <BAB1EE0E-B258-4108-AE24-110172086DE4@gmail.com> <CAJZjrdXg=jTXO+Dox9gTby-_JX+Lw_deihbUmbHe8V92dWJ0tg@mail.gmail.com>
 <71030110-EB19-4F54-95F1-443D3EAE5286@gmail.com>
From:   Samuel Lijin <sxlijin@gmail.com>
Date:   Sun, 26 Feb 2017 18:34:08 -0600
Message-ID: <CAJZjrdVaUvrfq5+fAurrtMME42Om+-QyXZEVpNDGAbG9iieggA@mail.gmail.com>
Subject: Re: [PATCH] travis-ci: run scan-build every time
To:     Lars Schneider <larsxschneider@gmail.com>
Cc:     "git@vger.kernel.org" <git@vger.kernel.org>,
        Jeff King <peff@peff.net>
Content-Type: text/plain; charset=UTF-8
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Sun, Feb 26, 2017 at 8:12 AM, Lars Schneider
<larsxschneider@gmail.com> wrote:
>
>> On 26 Feb 2017, at 03:09, Samuel Lijin <sxlijin@gmail.com> wrote:
>>
>> On Sat, Feb 25, 2017 at 3:48 PM, Lars Schneider
>> <larsxschneider@gmail.com> wrote:
>>>
>>>> On 24 Feb 2017, at 18:29, Samuel Lijin <sxlijin@gmail.com> wrote:
>>>>
>>>> It's worth noting that there seems to be a weird issue with scan-build
>>>> where it *will* generate a report for something locally, but won't do it
>>>> on Travis. See [2] for an example where I have a C program with a
>>>> very obvious memory leak but scan-build on Travis doesn't generate
>>>> a report (despite complaining about it in stdout), even though it does
>>>> on my local machine.
>>>>
>>>> [1] https://travis-ci.org/sxlijin/git/builds/204853233
>>>> [2] https://travis-ci.org/sxlijin/travis-testing/jobs/205025319#L331-L342
>>>
>>> Scan-build stores the report in some temp folder. I assume you can't access
>>> this folder on TravisCI. Try the scan-build option "-o scan-build-results"
>>> to store the report in the local directory.
>>
>> That occurred to me, but I don't quite think that's the issue. I just
>> noticed that on the repo I use to test build matrices, jobs 1-8 don't
>> generate a report, but 9-14 and 19-20 do [1]. I don't think it's an
>> issue with write permissions (scan-build complains much more vocally
>> if that happens), but it doesn't seem to matter if the output dir is
>> in the tmpfs [2] or a local directory [3].
>>
>> [1] https://travis-ci.org/sxlijin/travis-testing/builds/205054253
>> [2] https://travis-ci.org/sxlijin/git/jobs/205028920#L1000
>> [2] https://travis-ci.org/sxlijin/git/jobs/205411705#L998
>
> Scan-build somehow replaces the compiler. My guess is that you
> tell scan-build to substitute clang but "make" is really using
> gcc or something?

Your hunch is spot-on. I took a look at the Makefile and lo and
behold, it overrides $CC [1]. Looking at the commit which introduced
it [2] I have to admit I'm somewhat surprised that scan-build works at
all...

[1] https://github.com/git/git/blob/master/Makefile#L454
[2] https://github.com/git/git/commit/6d62c983f7d91565a15e49955b3ed94ae7c73434

> I reported something strange about the compilers
> on TravisCI some time ago but I can't find it anymore. I think I
> remember on OSX they always use clang even if you define gcc.
> Maybe it makes sense to reach out to TravisCI support in case
> this is a bug on their end?
>
> Based on your work I tried the following and it seems to work:
> https://travis-ci.org/larsxschneider/git/jobs/205507241
> https://github.com/larsxschneider/git/commit/faf4ecfdca1a732459c1f93c334928ee2826d490

That's promising!

> - Lars
