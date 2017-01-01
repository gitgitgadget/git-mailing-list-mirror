Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-6.0 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD,
	STOX_REPLY_TYPE shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 892931FCA5
	for <e@80x24.org>; Sun,  1 Jan 2017 12:43:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1755134AbdAAMnm (ORCPT <rfc822;e@80x24.org>);
        Sun, 1 Jan 2017 07:43:42 -0500
Received: from smtp-out-6.talktalk.net ([62.24.135.70]:62712 "EHLO
        smtp-out-6.talktalk.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754991AbdAAMnl (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 1 Jan 2017 07:43:41 -0500
Received: from PhilipOakley ([92.31.218.76])
        by smtp.talktalk.net with SMTP
        id NfU9csHc0gKstNfU9cYQnW; Sun, 01 Jan 2017 12:43:39 +0000
X-Originating-IP: [92.31.218.76]
X-Spam: 0
X-OAuthority: v=2.2 cv=GdBVpkfL c=1 sm=1 tr=0 a=e6L6E7eW+5Nb7SO+DvSdIg==:117
 a=e6L6E7eW+5Nb7SO+DvSdIg==:17 a=IkcTkHD0fZMA:10 a=pGLkceISAAAA:8
 a=ybZZDoGAAAAA:8 a=PKzvZo6CAAAA:8 a=RKUUMD1D7Nltus7t9ZkA:9 a=QEXdDO2ut3YA:10
 a=6kGIvZw6iX1k4Y-7sg4_:22 a=0RhZnL1DYvcuLYC8JZ5M:22 a=q92HNjYiIAC_jH7JDaYf:22
Message-ID: <994A5650F89F4B0080530BF7FD1879FD@PhilipOakley>
Reply-To: "Philip Oakley" <philipoakley@iee.org>
From:   "Philip Oakley" <philipoakley@iee.org>
To:     "Jacob Keller" <jacob.keller@gmail.com>,
        "Junio C Hamano" <gitster@pobox.com>
Cc:     "Jeff King" <peff@peff.net>,
        "Michael Haggerty" <mhagger@alum.mit.edu>,
        "Git mailing list" <git@vger.kernel.org>,
        "David Turner" <novalis@novalis.org>
References: <cover.1483153436.git.mhagger@alum.mit.edu> <20161231064746.6bvis76p5x5ubc2b@sigill.intra.peff.net> <xmqqr34n4ii8.fsf@gitster.mtv.corp.google.com> <CA+P7+xqqVFvDKSCTrGVVdpZB_VHwGdZ3gFQzo+RQqCu0FpOsAQ@mail.gmail.com>
Subject: Re: [PATCH v3 00/23] Delete directories left empty after ref deletion
Date:   Sun, 1 Jan 2017 12:43:40 -0000
Organization: OPDS
MIME-Version: 1.0
Content-Type: text/plain;
        format=flowed;
        charset="UTF-8";
        reply-type=original
Content-Transfer-Encoding: 7bit
X-Priority: 3
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook Express 6.00.2900.5931
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2900.6157
X-CMAE-Envelope: MS4wfGpFafEhA3eLXnVplaDJi8oyrU0SUB0UjNghHiy7vILDspL7ZphcMBrIR5AvwpnPzF67w97uGbpnzMHd1QzFNGa5r3492ehayOvstT8uVxvWlVQszj8m
 o1lpzefbFr/lv4uUDJLS//uAjr2hMJY8L6MU7lrohxmk+FjUjd506ukxf813cCZuMLVba/PlDWhkUWlbC3lG6knHOVKPQC1CeVdUsqNvycpmO4iAy7tUaWqZ
 TComa61Cxf9KoLhuU02g+723eRBYpECwJlMibK20W6hZTidiUNVw+CijEpLhPjwR03Qjw78I14mhvn9pjM/jRg==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: "Jacob Keller" <jacob.keller@gmail.com>
Sent: Sunday, January 01, 2017 9:24 AM
> On Sat, Dec 31, 2016 at 6:32 PM, Junio C Hamano <gitster@pobox.com> wrote:
>> Jeff King <peff@peff.net> writes:
>>
>>> On Sat, Dec 31, 2016 at 04:12:40AM +0100, Michael Haggerty wrote:
>>>
>>>> This is a re-roll of an old patch series. v1 [1] got some feedback,
>>>> which I think was all addressed in v2 [2]. But it seems that v2 fell
>>>> on the floor, and I didn't bother following up because it was in the
>>>> same area of code that was undergoing heavy changes due to the
>>>> pluggable reference backend work. Sorry for the long delay before
>>>> getting back to it.
>>>
>>> I've read through the whole thing, and aside from a few very minor nits
>>> (that I am not even sure are worth a re-roll), I didn't see anything
>>> wrong. And the overall goal and approach seem obviously sound.
>>>
>>>> Michael Haggerty (23):
>>>
>>> I'll admit to being daunted by the number of patches, but it was quite a
>>> pleasant and easy read. Thanks.
>>>
>>> -Peff
>>
>> Thanks, both.  These patches indeed were pleasant.
>
> I do have one comment regarding this series. Is it ever possible for
> an older version of git to be running a process while a new version of
> git which cleans up dirs runs? Is this expected? I just want to make
> sure we don't need to worry about that scenario since otherwise it
> makes it much more challenge.

It is easily possible in the Windows environment where the install philosphy 
is different, and some external vendor tools may even bring in their own 
copy of Git as well. There is also the Portable Git version, so the 
possibility of multiple versions running concurrently is there, though it is 
on Windows...

I certainly have a Git-for-Windows published version, and a recent SDK 
version on my home machines.

>
> My thought as far as I understand it is that it is possible, because a
> user COULD choose to run both this and an older version, but that it
> is unlikely in practice outside of a few developer boxes who
> periodically switch between versions of git, and are unlikely to
> actually run multiple versions at exactly the same time.
>
> Thanks,
> Jake
>
Philip 

