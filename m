Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id CA7A7202A2
	for <e@80x24.org>; Fri, 20 Oct 2017 21:54:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753015AbdJTVyx (ORCPT <rfc822;e@80x24.org>);
        Fri, 20 Oct 2017 17:54:53 -0400
Received: from mail-wm0-f53.google.com ([74.125.82.53]:56321 "EHLO
        mail-wm0-f53.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752612AbdJTVyv (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 20 Oct 2017 17:54:51 -0400
Received: by mail-wm0-f53.google.com with SMTP id l68so302184wmd.5
        for <git@vger.kernel.org>; Fri, 20 Oct 2017 14:54:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=zbC9hqBC6LwhFEZfElep7a76ZgetbOvgX2f6RQR8/rI=;
        b=VN+61+Ef4IdYKuEOImBFEFgLWo9UZfhtAAxdA6fY/yjxUZ8q4ZP9L+0bzPcQ7Ra2CM
         WcYBju2LYJ4VEPjKcLE8NJ83orrBqTKgGyRDAn1Oy50C/miUGvtdunLcqEa6spkn4vLj
         hCnAKKBylA2eXX6dZ+Z+3GMe/vln8K0cIoBdv8Zk93N1XtEH+It73qKkWaGo8895puAj
         XbRZC9tKuRxXSh2TRdBomapigAIOGilwn3OaEdzeAJdDljRwrEMkg1mR2b+w3+0coHzM
         RrjIER1SN5f5QCNWeYLbbDPO6WNKQWFMywSswcapNk/WzrudvyF6ZyzZm8su7jDVfQvU
         S2LQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=zbC9hqBC6LwhFEZfElep7a76ZgetbOvgX2f6RQR8/rI=;
        b=eQFmhvM8pszeO9eBaVx/ujuxxOUyIRVT0C1hufbusiamaVtE47j+nYPVq2NwsxeZ69
         9XjOB9ZaY8wf0GWYBjtB59tZkSa9ZS/46B0U4Zu5Fa65ctIgLDigBG8TIwISMEUd7cPi
         5fn17kwibKklxQJzrUJAjL/R8rRRYBwSzKG4ytiQDWXk+PIzKejpiDq5H37qBhhABUAG
         ksGgtjy3xP2B6WBBBwFd8qQwEoRymTXzues8gUZnbeGbv4rWKXccUDZKGQUwM4h7GG7/
         7Sh0zyBcLAcKjSF2Ur1dzNQrLA8wh6+DLRL4VdQgrLYehn8MHshQYZ3mToN2cIweNIGS
         /bXQ==
X-Gm-Message-State: AMCzsaU88YZOxG/QFxx6RrTV0AqaKjMI/TzeG+8NpP3dT5cMC1PJo37x
        hFVlgF8SFwu6mWdiwfA/wFddSr1HpM5X9LDCrkTMDA==
X-Google-Smtp-Source: ABhQp+Sz9MYqfNOLpqjmyt+o+zjTTMH17zdp7om0ELZ3ovriXt4TKh8MTRfLFz8UYkiOidlRRlLjRSwKfES+HtS8imI=
X-Received: by 10.80.137.91 with SMTP id f27mr7662221edf.18.1508536490524;
 Fri, 20 Oct 2017 14:54:50 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.80.213.80 with HTTP; Fri, 20 Oct 2017 14:54:29 -0700 (PDT)
In-Reply-To: <CAPig+cQ56ZNaEOkV+ZCq2KsL-2nTockTrEbqvj=j_wO0YtCx6g@mail.gmail.com>
References: <nycvar.QRO.7.76.6.1710201105351.5973@qynat-yncgbc>
 <CA+P7+xpdWJbxtxAggRpYR3eE8qjH6TfbYQS_=20aZM7d2RbC0Q@mail.gmail.com>
 <20171020214312.3kb3ncz2ks7mfxw4@sigill.intra.peff.net> <CAPig+cQ56ZNaEOkV+ZCq2KsL-2nTockTrEbqvj=j_wO0YtCx6g@mail.gmail.com>
From:   Jacob Keller <jacob.keller@gmail.com>
Date:   Fri, 20 Oct 2017 14:54:29 -0700
Message-ID: <CA+P7+xqx3EDbRKq7rwHXn9qeqVTZCZr2vYZ_63THC+UEL5q2Yw@mail.gmail.com>
Subject: Re: hot to get file sizes in git log output
To:     Eric Sunshine <sunshine@sunshineco.com>
Cc:     Jeff King <peff@peff.net>, David Lang <david@lang.hm>,
        Git mailing list <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, Oct 20, 2017 at 2:50 PM, Eric Sunshine <sunshine@sunshineco.com> wrote:
> On Fri, Oct 20, 2017 at 5:43 PM, Jeff King <peff@peff.net> wrote:
>> On Fri, Oct 20, 2017 at 01:44:36PM -0700, Jacob Keller wrote:
>>> On Fri, Oct 20, 2017 at 11:12 AM, David Lang <david@lang.hm> wrote:
>>> > I'm needing to scan through git history looking for the file sizes (looking
>>> > for when a particular file shrunk drastically)
>>> >
>>> > I'm not seeing an option in git log or git whatchanged that gives me the
>>> > file size, am I overlooking something?
>>>
>>> I'm not exactly sure what you mean by size, but if you want to show
>>> how many lines were added and removed by a given commit for each file,
>>> you can use the "--stat" option to produce a diffstat. The "size" of
>>> the files in each commit isn't very meaningful to the commit itself,
>>> but a stat of how much was removed might be more accurate to what
>>> you're looking for.
>>
>> That's a good suggestion, and hopefully could help David answer his
>> original question.
>>
>> I took the request to mean "walk through history, and for each file that
>> a commit touches, show its size". Which is a bit harder to do, and I
>> think you need to script a little:
>
> David's mention of "a particular file", suggests to me that something
> "bad" happened to one file, and he wants to know in which commit that
> "badness" happened. If so, then it sounds like a job for git-bisect.

Yea, if you have a simple script which can tell when the file is
"bad", you could run it through git bisect run pretty easily and
rapidly find the right answer.

Thanks,
Jake
