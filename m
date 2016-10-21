Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.6 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 89EBC20229
	for <e@80x24.org>; Fri, 21 Oct 2016 15:43:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S935132AbcJUPnW (ORCPT <rfc822;e@80x24.org>);
        Fri, 21 Oct 2016 11:43:22 -0400
Received: from mail-yw0-f172.google.com ([209.85.161.172]:36640 "EHLO
        mail-yw0-f172.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S934306AbcJUPnV (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 21 Oct 2016 11:43:21 -0400
Received: by mail-yw0-f172.google.com with SMTP id u124so100221043ywg.3
        for <git@vger.kernel.org>; Fri, 21 Oct 2016 08:43:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=nc5kNDmzY1ZRjeNzkD6nISThxGtEpOjhOvRbcRUa/NU=;
        b=dAE69ZSnA5oB3hNuBpsmqkG4uzW70zN1ZlQiT4Z7f+IJoQ9mga4dsU2l4trUvEef/T
         bZeNjAvsBZeeHuOpxbWV7BWap6m/zzesCMbQa+7hP41HT+ryisZSRwSWK9JLCybpbt/j
         Bmccr/wJRsRIKSQ5loZeeh7+ppLyfrk7wdsU2JI6ZCVnz8bzWoDyYFv3uoXtzTqZ41It
         jmAHw4V1T1p/isHpxzXkSq3rmEFj/DJXspt+cLTyeBbpgccnFdl+at61cf6g284quLYn
         jQ1akcRgc5iun/83FJ4yIiNotWFy9R1Y9viUMHcvCw7IhzwaBTjKnBE+jC87i2yC2jkq
         NTUQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=nc5kNDmzY1ZRjeNzkD6nISThxGtEpOjhOvRbcRUa/NU=;
        b=ON7P0UlDOw5c0JkQugpkz26xycX5QzNme3lnkFQlYfrZAkiZrSisDt9mPfdGAY89R5
         X0in0AQHBCHH/hry2qMzmg8XvqnN89/LNHWITAooIORnKpXj1LqYlUaU1kiQZU9MsCmm
         ZE9oxaWr5nNn80Nycfnt0R5QgsoB8ngM/hQwe2mWGzO5ubsJDWafsphcF97hz9xIsLYm
         UZyySjf/Eemp7/6Qq6PmDQs3Wo10FD+jkd3NgpnQgNCH137+EkRd40nFlt9xUCfqSbLo
         n5AkIYOrDo1dwUtmiFQvcB3K1VXKnoD1XAWJBiJ+EXmh7mDCoKapNy6APb4lrsbX5OwU
         LPSQ==
X-Gm-Message-State: ABUngvc6QMvUPt9q1f7PiupzmkdJN0ZsyPMmax0yZJdqO7k9ONWYXTehjL8lL2lELIsZdsL5rQMAYX6TnS/BGQ==
X-Received: by 10.129.130.193 with SMTP id s184mr1691452ywf.276.1477064599407;
 Fri, 21 Oct 2016 08:43:19 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.37.10.2 with HTTP; Fri, 21 Oct 2016 08:42:58 -0700 (PDT)
In-Reply-To: <20161021153534.mjed3sqhxjelxzwx@sigill.intra.peff.net>
References: <D9C1E13F-88A2-483E-A549-1C2294EACFEB@gmail.com>
 <CAGZ79kZo3LdcRmrjQTAvgx=H6U2tdjASK3qv5A2K5J2HQ2NvSw@mail.gmail.com>
 <20161021082035.xad6wfny5i6wtshh@sigill.intra.peff.net> <20161021084348.dp4jfpfownodl7nz@sigill.intra.peff.net>
 <CA+P7+xozpk2-WZUYtaKmCazG3Owzpa3bsDejyUuGj0YEQnJWJg@mail.gmail.com> <20161021153534.mjed3sqhxjelxzwx@sigill.intra.peff.net>
From:   Jacob Keller <jacob.keller@gmail.com>
Date:   Fri, 21 Oct 2016 08:42:58 -0700
Message-ID: <CA+P7+xrix3UZDEE1swG_=jBLwWHA04KoYikWBBMNx7aa=Hevmw@mail.gmail.com>
Subject: Re: Prove "Tests out of sequence" Error
To:     Jeff King <peff@peff.net>
Cc:     Stefan Beller <sbeller@google.com>,
        Lars Schneider <larsxschneider@gmail.com>,
        git <git@vger.kernel.org>
Content-Type: text/plain; charset=UTF-8
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, Oct 21, 2016 at 8:35 AM, Jeff King <peff@peff.net> wrote:
> On Fri, Oct 21, 2016 at 08:29:49AM -0700, Jacob Keller wrote:
>
>> > The Travis tests do exactly this (along with --tee to actually save the
>> > output). It seems like a minor miracle that this is the first test
>> > output that has actually triggered as TAP input. I'd suggest that the
>> > problem is not in the test, though, but that our "--verbose" option is
>> > unsuitable for using with a TAP harness.
>> >
>> > The obvious fix would be to send "--verbose" output to stderr, but I
>> > suspect that would end up annoying for people who do:
>> >
>> >   ./t5547-push-quarantine.sh -v | less
>> >
>> > to read long output. Probably we need some option like "--log" which
>> > logs in the same way that "--tee" does, but _without_ sending the data
>> > to stdout. Naively, that just means replacing the "tee" invocation with
>> > "cat", but I suspect it will be a lot more complicated than that,
>> > because we still need to let the TAP output go to stdout.
>>
>> Can we determine that we're running with something monitoring the TAP
>> output? Because then we could make verbose go to stderr instead
>> dynamically?
>
> I think $HARNESS_ACTIVE could tell us that. But the hard part isn't
> activating it; it's directing the verbose output to the log without
> sending it to stdout.
>
> See the patch I posted later in the thread, and my musings on
> auto-activating it. I guess we could do so safely when we see
> $HARNESS_ACTIVE along with "--tee" and "--verbose", though I don't know
> if it's worth the trouble.
>
> For $HARNESS_ACTIVE with _just_ "--verbose", I don't think it would be a
> good idea to activate it. We should either silently ignore --verbose
> then, or complain and die.
>

We should probably do that to make sure people realize what might
happen. I read your series and it has a good explanation of the
possible alternatives. I like the approach you chose.

Thanks,
Jake

> -Peff
