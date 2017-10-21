Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.4 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 43187202A2
	for <e@80x24.org>; Sat, 21 Oct 2017 02:43:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752703AbdJUCnd (ORCPT <rfc822;e@80x24.org>);
        Fri, 20 Oct 2017 22:43:33 -0400
Received: from lang.hm ([66.167.227.134]:47181 "EHLO bifrost.lang.hm"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752605AbdJUCnd (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 20 Oct 2017 22:43:33 -0400
Received: from dlang-laptop ([10.2.0.162])
        by bifrost.lang.hm (8.13.4/8.13.4/Debian-3) with ESMTP id v9L2hMTD008328;
        Fri, 20 Oct 2017 19:43:22 -0700
Date:   Fri, 20 Oct 2017 19:43:22 -0700 (PDT)
From:   David Lang <david@lang.hm>
X-X-Sender: dlang@dlang-laptop
To:     David Lang <david@lang.hm>
cc:     Eric Sunshine <sunshine@sunshineco.com>, Jeff King <peff@peff.net>,
        Jacob Keller <jacob.keller@gmail.com>,
        Git mailing list <git@vger.kernel.org>
Subject: Re: hot to get file sizes in git log output
In-Reply-To: <nycvar.QRO.7.76.6.1710201929210.5973@qynat-yncgbc>
Message-ID: <nycvar.QRO.7.76.6.1710201940440.5973@qynat-yncgbc>
References: <nycvar.QRO.7.76.6.1710201105351.5973@qynat-yncgbc> <CA+P7+xpdWJbxtxAggRpYR3eE8qjH6TfbYQS_=20aZM7d2RbC0Q@mail.gmail.com> <20171020214312.3kb3ncz2ks7mfxw4@sigill.intra.peff.net> <CAPig+cQ56ZNaEOkV+ZCq2KsL-2nTockTrEbqvj=j_wO0YtCx6g@mail.gmail.com>
 <nycvar.QRO.7.76.6.1710201929210.5973@qynat-yncgbc>
User-Agent: Alpine 2.21.1 (DEB 209 2017-03-23)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII; format=flowed
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, 20 Oct 2017, David Lang wrote:

> On Fri, 20 Oct 2017, Eric Sunshine wrote:
>
>>>> I'm not exactly sure what you mean by size, but if you want to show
>>>> how many lines were added and removed by a given commit for each file,
>>>> you can use the "--stat" option to produce a diffstat. The "size" of
>>>> the files in each commit isn't very meaningful to the commit itself,
>>>> but a stat of how much was removed might be more accurate to what
>>>> you're looking for.
>>> 
>>> That's a good suggestion, and hopefully could help David answer his
>>> original question.
>>> 
>>> I took the request to mean "walk through history, and for each file that
>>> a commit touches, show its size". Which is a bit harder to do, and I
>>> think you need to script a little:
>> 
>> David's mention of "a particular file", suggests to me that something
>> "bad" happened to one file, and he wants to know in which commit that
>> "badness" happened. If so, then it sounds like a job for git-bisect.

summarizing (and removing the long explination of why I'm doing this)

for each file (or each file changed in the commit), what is the byte count of 
that file at the time of that commit.

git whatschanged currently reports

commit 17be1c1e1f80086e8ddda1706c8c8d6cf80d26b7
Author: David Lang <david@lang.hm>
Date:   Thu Oct 19 22:00:01 2017 -0700

     update

:100644 100644 bb9dcd3... 8635d2b... M  Default/Current Session

commit d3f94d406e0d5c6ee7b6f6bcea019adff438127c
Author: David Lang <david@lang.hm>
Date:   Thu Oct 19 21:00:01 2017 -0700

     update

:100644 100644 88ece53... bb9dcd3... M  Default/Current Session

commit fea290bd235a444bbd4bc4430fa0844501ae2b8c
Author: David Lang <david@lang.hm>
Date:   Thu Oct 19 06:00:01 2017 -0700

     update

:100644 100644 ff04089... 88ece53... M  Default/Current Session

what is the size of the file "Current Session" for each commit?

David Lang
