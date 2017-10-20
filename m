Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.5 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD,T_DKIM_INVALID shortcircuit=no autolearn=no
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 2B9B0202A2
	for <e@80x24.org>; Fri, 20 Oct 2017 21:54:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753412AbdJTVyk (ORCPT <rfc822;e@80x24.org>);
        Fri, 20 Oct 2017 17:54:40 -0400
Received: from mail-qk0-f177.google.com ([209.85.220.177]:51646 "EHLO
        mail-qk0-f177.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753015AbdJTVun (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 20 Oct 2017 17:50:43 -0400
Received: by mail-qk0-f177.google.com with SMTP id 17so15980900qkq.8
        for <git@vger.kernel.org>; Fri, 20 Oct 2017 14:50:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:sender:in-reply-to:references:from:date:message-id
         :subject:to:cc;
        bh=rLyX/hSgznH47ZsoYrwiEXo3cZcgQQSJxiEFGgZomTo=;
        b=BMKNgDyhw/3m+uh4fL7Bg+1YMCTR4ZtJktcExmMXelTMuW7nno5GN4VJ8BqRKVdakJ
         I04x8J5uwD6dTYet6Pu/UdKNt7Wi4C84QUVTypldxr7xTH3A065Z3ZW9HGYz9oJgknNP
         CzWTJ0uhBfnrVcap8iKg67TVO5sIqElPMQJrxMqHsQCF9HTrTr9X3x72qSQAOe8Cwc9m
         FSK60SAi2CFnmCqRCH/RHpKhQysgn0+cQe/gfvzGiObemLNYdPyrME+c4D9haUAVRtne
         hOYbwznXrIuQYtRjGwtLEWQdcTlqDsYXbgILhWbQmfJQ75K0iEYhyy9ToeWrh1NYeBtu
         0lrg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:sender:in-reply-to:references:from
         :date:message-id:subject:to:cc;
        bh=rLyX/hSgznH47ZsoYrwiEXo3cZcgQQSJxiEFGgZomTo=;
        b=XyaFdygqfiyTHkJRSLqIqhgOx5iRIcjw3j8fvn+EaCkcLyJ5iXL3bweYimucqR4PTQ
         xc/rjh4uYyPvYypb2SmWQZpwGIL+IfZ4/cLxOPVc13a37/XroRaia/ixXlI5yDb7jfQa
         fgZCsbtpZV6E6fdPOpyvWs6+t2i7KhuB0APBZ7UB4FMeViDTOW5DoqCEKDHoCCe+EV2e
         ZB00hQOy2nHxLfeWqgy+xhlrxt8nC/2Nu1t9f/mcgal3ZDqEpPAOiAwXHFWCHNcYB0b9
         HplyP8OmiACQc8dGIHCWFsbukBctIeLuLJ8RGS8cGqoIZO3AXZ2LwVgUiD9joJgkRu/g
         /FjQ==
X-Gm-Message-State: AMCzsaVC5hTrXWCMaCfNe3MMZoTaXOj3aHgDS22R1UpmgVhy88U6m6c5
        dv2rHJUXzH3zBhRbJu7n1cmsd9zLwZaG4xbiZdc=
X-Google-Smtp-Source: ABhQp+QaxrhuI8Ge60mHAK34MXdrNGjg9Q2HTjMTNTlYfQdfQfI53uKferx9YCtzYVQwj+5vqHwYCh1L9BUDOM2LRwg=
X-Received: by 10.55.139.70 with SMTP id n67mr8647842qkd.135.1508536242245;
 Fri, 20 Oct 2017 14:50:42 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.12.146.118 with HTTP; Fri, 20 Oct 2017 14:50:41 -0700 (PDT)
In-Reply-To: <20171020214312.3kb3ncz2ks7mfxw4@sigill.intra.peff.net>
References: <nycvar.QRO.7.76.6.1710201105351.5973@qynat-yncgbc>
 <CA+P7+xpdWJbxtxAggRpYR3eE8qjH6TfbYQS_=20aZM7d2RbC0Q@mail.gmail.com> <20171020214312.3kb3ncz2ks7mfxw4@sigill.intra.peff.net>
From:   Eric Sunshine <sunshine@sunshineco.com>
Date:   Fri, 20 Oct 2017 17:50:41 -0400
X-Google-Sender-Auth: orXevLzqiXBIHi-pedHzWRw7YSo
Message-ID: <CAPig+cQ56ZNaEOkV+ZCq2KsL-2nTockTrEbqvj=j_wO0YtCx6g@mail.gmail.com>
Subject: Re: hot to get file sizes in git log output
To:     Jeff King <peff@peff.net>
Cc:     Jacob Keller <jacob.keller@gmail.com>, David Lang <david@lang.hm>,
        Git mailing list <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, Oct 20, 2017 at 5:43 PM, Jeff King <peff@peff.net> wrote:
> On Fri, Oct 20, 2017 at 01:44:36PM -0700, Jacob Keller wrote:
>> On Fri, Oct 20, 2017 at 11:12 AM, David Lang <david@lang.hm> wrote:
>> > I'm needing to scan through git history looking for the file sizes (looking
>> > for when a particular file shrunk drastically)
>> >
>> > I'm not seeing an option in git log or git whatchanged that gives me the
>> > file size, am I overlooking something?
>>
>> I'm not exactly sure what you mean by size, but if you want to show
>> how many lines were added and removed by a given commit for each file,
>> you can use the "--stat" option to produce a diffstat. The "size" of
>> the files in each commit isn't very meaningful to the commit itself,
>> but a stat of how much was removed might be more accurate to what
>> you're looking for.
>
> That's a good suggestion, and hopefully could help David answer his
> original question.
>
> I took the request to mean "walk through history, and for each file that
> a commit touches, show its size". Which is a bit harder to do, and I
> think you need to script a little:

David's mention of "a particular file", suggests to me that something
"bad" happened to one file, and he wants to know in which commit that
"badness" happened. If so, then it sounds like a job for git-bisect.
