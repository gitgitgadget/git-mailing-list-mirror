Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id D6A261F597
	for <e@80x24.org>; Thu, 19 Jul 2018 23:11:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727727AbeGSX4W (ORCPT <rfc822;e@80x24.org>);
        Thu, 19 Jul 2018 19:56:22 -0400
Received: from mail-ua0-f194.google.com ([209.85.217.194]:38154 "EHLO
        mail-ua0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727556AbeGSX4W (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 19 Jul 2018 19:56:22 -0400
Received: by mail-ua0-f194.google.com with SMTP id o11-v6so6322474uak.5
        for <git@vger.kernel.org>; Thu, 19 Jul 2018 16:11:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=ZGX11UAlNLIFSEzfdMGUaocOw6GVruUoygJlUMFplpo=;
        b=m/4V0YQeHOlejhwp58GPgImajrHiIy973lbDP/6bd485pZl9qedtI+Q2JPiVeq+0Yu
         BRgenY+OJEqrS0o57IH5lotbgQa2KvMs8LzzhYkR9Tt8mOT5w/+Z2XkTwe+LQvPK+KUO
         p+UhrgkEyDMavTshvoCb2WodlBd2ZBWJP5wgvp0V01F3g+1MMAy9tYW8e8ljG7jnGRDs
         xV0ANBaxqlxcLJSQ/vOWx8DT4b6ap9YXtjDg9lizTe2p646IwIW+Lq95xnHy+QclTxO+
         eci0rMxBp/YcWlkJ1qLQ+KrJ4KEkDJcJO6V0q0XE9jJ8y+EBSE6411uvY7DWFRuGZZE+
         WSlQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=ZGX11UAlNLIFSEzfdMGUaocOw6GVruUoygJlUMFplpo=;
        b=YKDAbAOp1ZtztKF08x53AK+nVC1UqqhyiOqUzulDOt82dvUOimf4a/eNwtD8MfaLya
         qoKDZvWPhiqvxL1yXgFnlh/oZW0LnTtHi6DkCPIftAXPl6sH/bYKxajE8+9tibGER19e
         yyva+aMY5DL7ZxyBR68v5yIouo8hd5BcoZ7cja/whU4LzTlfWSViqMo5dEls95rA+X9N
         by5o6ez3fBUL9ayHnrtEBZkRstcn4p8URrR5zd2fBjLsx7vyk52vdRadKy78YLp0phXd
         O1KYljLSmIbvt6zlwI/DpPmZgb1FyALkzvYHx05eYjfvLxrJsHGXbF8O/3k3fZkOJmIU
         1k3A==
X-Gm-Message-State: AOUpUlH9wV+DFe/ntc4gxg8gHckSvTuG8mkt1oLHuRhq05omXvX6Mnun
        6MxD/Kb9fX8HPY58s0Os3w58dHrda8RJSgpJCWHmR/jY
X-Google-Smtp-Source: AAOMgpfWqku/M967hJwXR3b4jzAy8b97ihrMaDdE6NJ49e+rdEaibYQHvUhAgga0hg5ADVBlWDWzQUKTgsYkjflgGtY=
X-Received: by 2002:ab0:4f26:: with SMTP id n38-v6mr8167117uah.29.1532041862637;
 Thu, 19 Jul 2018 16:11:02 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:ab0:21c7:0:0:0:0:0 with HTTP; Thu, 19 Jul 2018 16:11:01
 -0700 (PDT)
In-Reply-To: <20180719182442.GA5796@duynguyen.home>
References: <20180718225110.17639-1-newren@gmail.com> <20180719054424.GB23884@sigill.intra.peff.net>
 <CACsJy8BNGboUb0F5NRR9tKj_P24j2ZgB48SCuLEphSHQAU2EUA@mail.gmail.com>
 <20180719151640.GA24997@duynguyen.home> <CABPp-BGE0yAgtOkSC0jUhq3M3ynX9pks5VnjVB_WMkYUVdirzA@mail.gmail.com>
 <20180719172358.GD4868@sigill.intra.peff.net> <20180719173135.GA24563@duynguyen.home>
 <20180719182442.GA5796@duynguyen.home>
From:   Elijah Newren <newren@gmail.com>
Date:   Thu, 19 Jul 2018 16:11:01 -0700
Message-ID: <CABPp-BEo1Ar17uwX=ib8iVYosdwhTXhdMWvi7kgqDb3iPQoj5Q@mail.gmail.com>
Subject: Re: 2.18.0 Regression: packing performance and effectiveness
To:     Duy Nguyen <pclouds@gmail.com>
Cc:     Jeff King <peff@peff.net>, Git Mailing List <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Jul 19, 2018 at 11:24 AM, Duy Nguyen <pclouds@gmail.com> wrote:
> On Thu, Jul 19, 2018 at 07:31:35PM +0200, Duy Nguyen wrote:
>> On Thu, Jul 19, 2018 at 01:23:58PM -0400, Jeff King wrote:
>> > On Thu, Jul 19, 2018 at 09:42:00AM -0700, Elijah Newren wrote:
>> >
>> > > Thanks for the quick turnaround.  Unfortunately, I have some bad news.
>> > > With this patch, I get the following:
>> > >
>> > > $ /usr/bin/time -f 'MaxRSS:%M Time:%e' git gc --aggressive
>> > > Enumerating objects: 4460703, done.
>> > > Counting objects: 100% (4460703/4460703), done.
>> > > Delta compression using up to 40 threads.
>> > > Compressing objects: 100% (3807140/3807140), done.
>> > > Writing objects: 100% (4460703/4460703), done.
>> > > Total 4460703 (delta 2831383), reused 1587071 (delta 0)
>> > > error: failed to unpack compressed delta at offset 183854150 from
>> > > .git/objects/pack/pack-30d4f0b0e5a03dc91a658a0586f4e74cdf4a94d6.pack
>> > > fatal: packed object 20ce811e53dabbb8ef9368c108cbbdfa65639c03 (stored
>> > > in .git/objects/pack/pack-30d4f0b0e5a03dc91a658a0586f4e74cdf4a94d6.pack)
>> > > is corrupt
>> > > error: failed to run prune
>> > > MaxRSS:40025196 Time:2531.52
>> >
>> > Looking at that output, my _guess_ is that we somehow end up with a
>> > bogus delta_size value and write out a truncated entry. But I couldn't
>> > reproduce the issue with smaller test cases.
>>
>> Could it be a race condition?
>
> I'm convinced my code is racy (between two writes). I created a broken
> pack once with 32 threads. Elijah please try again with this new
> patch. It should fix this (I only tried repack a few times so far but
> will continue)
>
> The race is this
>
> 1. Thread one sees a large delta size and NULL delta_size[] array,
>    allocates the new array and in the middle of copying old delta
>    sizes over.
>
> 2. Thread two wants to write a new (large) delta size. It sees that
>    delta_size[] is already allocated, it writes the correct size there
>    (and truncated one in object_entry->delta_size_)
>
> 3. Back to thread one, it now copies the truncated value in
>    delta_size_ from step 2 to delta_size[] array, overwriting the good
>    value that thread two wrote.
>
> There is also a potential read/write race where a read from
> pack_size[] happens when the array is not ready. But I don't think it
> can happen with current try_delta() code. I protect it anyway to be
> safe.

Looking at the output from Peff's instrumentation elsewhere in this
thread, I see a lot of lines like
   mismatched get: 32889efd307c7be376da9e3d45a78305f14ba73a = (, 28)
Does that mean it was reading the array when it wasn't ready?


Anyway, with your latest patch (which I'm labelling fix-v4), git gc
--aggressive completes, git fsck likes the result, and the new table
of stats on this repo becomes:

Version  Pack (MB)  MaxRSS(kB)  Time (s)
-------  ---------  ----------  --------
 2.17.0     5498     43513628    2494.85
 2.18.0    10531     40449596    4168.94
 fix-v1     5509     42509784    2480.74
 fiv-v2     5509     41644104    2468.25
 fiv-v4     5500     44400948    2761.74


So, the pack size is back to what is expected.  The code takes about
10% longer and requires 2% more memory than git-2.17.0, but the pack
size was the main issue.


However, it's interesting to also look at the effect on packing
linux.git (on the same beefy hardware):

Version  Pack (MB)  MaxRSS(kB)  Time (s)
-------  ---------  ----------  --------
 2.17.0     1279     11382932      632.24
 2.18.0     1279     10817568      621.97
 fiv-v4     1279     11484168     1193.67

While the pack size is nice and small, the original memory savings
added in 2.18.0 are gone and the performance is much worse.  :-(
