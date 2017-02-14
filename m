Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD,
	STOX_REPLY_TYPE shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 4A5671FAF4
	for <e@80x24.org>; Tue, 14 Feb 2017 23:27:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1750902AbdBNX1C (ORCPT <rfc822;e@80x24.org>);
        Tue, 14 Feb 2017 18:27:02 -0500
Received: from smtp-out-4.talktalk.net ([62.24.135.68]:25344 "EHLO
        smtp-out-4.talktalk.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750810AbdBNX1B (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 14 Feb 2017 18:27:01 -0500
Received: from PhilipOakley ([92.31.218.76])
        by smtp.talktalk.net with SMTP
        id dmUtctUXAcpskdmUtcMad6; Tue, 14 Feb 2017 23:26:59 +0000
X-Originating-IP: [92.31.218.76]
X-Spam: 0
X-OAuthority: v=2.2 cv=ILRAMUnG c=1 sm=1 tr=0 a=e6L6E7eW+5Nb7SO+DvSdIg==:117
 a=e6L6E7eW+5Nb7SO+DvSdIg==:17 a=IkcTkHD0fZMA:10 a=pGLkceISAAAA:8
 a=ybZZDoGAAAAA:8 a=uPZiAMpXAAAA:8 a=5rxgeBVgAAAA:8 a=QyXUC8HyAAAA:8
 a=ZSvnttpX_xnaqSMRtX8A:9 a=QEXdDO2ut3YA:10 a=6kGIvZw6iX1k4Y-7sg4_:22
 a=0RhZnL1DYvcuLYC8JZ5M:22 a=svzibyHiZmA4t4YY0eFS:22 a=PwKx63F5tFurRwaNxrlG:22
 a=avl4LiGQNoF5OB0DmCJ7:22
Message-ID: <E2C1B7A8FBF94C8CB1C9C5754D882800@PhilipOakley>
Reply-To: "Philip Oakley" <philipoakley@iee.org>
From:   "Philip Oakley" <philipoakley@iee.org>
To:     "Christian Couder" <christian.couder@gmail.com>,
        "Junio C Hamano" <gitster@pobox.com>
Cc:     "Johannes Schindelin" <Johannes.Schindelin@gmx.de>,
        <git-for-windows@googlegroups.com>, "git" <git@vger.kernel.org>
References: <alpine.DEB.2.20.1702101241210.3496@virtualbox> <xmqq60kdbqmy.fsf@gitster.mtv.corp.google.com> <alpine.DEB.2.20.1702142150220.3496@virtualbox> <xmqqd1ek8oqo.fsf@gitster.mtv.corp.google.com> <CAP8UFD1+AgBVqSh=wHteM3uKO+55ZqqD4cHzBUfN0KTPXyvutQ@mail.gmail.com>
Subject: Re: [git-for-windows] Re: Continuous Testing of Git on Windows
Date:   Tue, 14 Feb 2017 23:27:00 -0000
Organization: OPDS
MIME-Version: 1.0
Content-Type: text/plain;
        format=flowed;
        charset="utf-8";
        reply-type=original
Content-Transfer-Encoding: 7bit
X-Priority: 3
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook Express 6.00.2900.5931
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2900.6157
X-CMAE-Envelope: MS4wfCs1ea+K8neuxKQJbm7qpUFncyEWoEcbsV2bqwOrjpqThVsyqlI8TDchz1cuOGOtc/tkbikCR21pz3kaxP9knyBIqa3gEd5/UrAY7SNUCJUWCHP7EPui
 vuelfwp75UREhx1YUeaHnzQCIHzQZYQE+qTugmD9qtRjBThJQDlRsXOm5x+m8OhKcQECl99cV+iYjrReq4NLHS5qKNS4cu9c52thPefU7AZKsrOgH0SiB2ug
 CgjTa6qBYV9o5BQBsBlddVVpq5GKZCWIB0IUyi1SHVxhCgH4WrKZzxqSpNnTfhNpJsAuK6WfgvETJ8b2FHSqng==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: "Christian Couder" <christian.couder@gmail.com>
> On Tue, Feb 14, 2017 at 10:08 PM, Junio C Hamano <gitster@pobox.com> 
> wrote:
>> Johannes Schindelin <Johannes.Schindelin@gmx.de> writes:
>>
>>> On Mon, 13 Feb 2017, Junio C Hamano wrote:
>>>
>>>> Johannes Schindelin <Johannes.Schindelin@gmx.de> writes:
>>>>
>>>> > That is why I taught the Git for Windows CI job that tests the four
>>>> > upstream Git integration branches to *also* bisect test breakages and
>>>> > then upload comments to the identified commit on GitHub
>>>>
>>>> Good.  I do not think it is useful to try 'pu' as an aggregate and
>>>> expect it to always build and work [*1*], but your "bisect and
>>>> pinpoint" approach makes it useful to identify individual topic that
>>>> brings in a breakage.
>>>
>>> Sadly the many different merge bases[*1*] between `next` and `pu` (which
>>> are the obvious good/bad points for bisecting automatically) bring my
>>> build agents to its knees. I may have to disable the bisecting feature 
>>> as
>>> a consequence.
>
> Yeah, this is a bug in the bisect algorithm. Fixing it is in the GSoC
> 2017 Ideas.

There are also a few ideas at the SO answers: 
http://stackoverflow.com/a/5652323/717355

>
>> Probably a less resource intensive approach is to find the tips of
>> the topics not in 'next' but in 'pu' and test them.  That would give
>> you which topic(s) are problematic, which is a better starting point
>> than "Oh, 'pu' does not build".  After identifying which branch is
>> problematic, bisection of individual topic would be of more manageable
>> size.
>
> It is still probably more resource intensive than it couls be.
>
> [...]
>
>> This is one of these times I wish "git bisect --first-parent" were
>> available.
>
> Implementing "git bisect --first-parent" is also part of the GSoC 2017 
> Ideas.
>
> By the way it should not be very difficult as a patch to do this and
> more was proposed a long time ago:
>
> https://public-inbox.org/git/4D3CDDF9.6080405@intel.com/
>
>> The above "log" gives me 27 merges right now, which
>> should be bisectable within 5 rounds to identify a single broken
>> topic (if there is only one breakage, that is).
>
--
Philip 

