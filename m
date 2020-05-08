Return-Path: <SRS0=7OUv=6W=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BB976C38A2A
	for <git@archiver.kernel.org>; Fri,  8 May 2020 17:21:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A0B0021775
	for <git@archiver.kernel.org>; Fri,  8 May 2020 17:21:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727099AbgEHRVS (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 8 May 2020 13:21:18 -0400
Received: from smtp.hosts.co.uk ([85.233.160.19]:17370 "EHLO smtp.hosts.co.uk"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726750AbgEHRVS (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 8 May 2020 13:21:18 -0400
Received: from [89.243.191.101] (helo=[192.168.1.37])
        by smtp.hosts.co.uk with esmtpa (Exim)
        (envelope-from <philipoakley@iee.email>)
        id 1jX6gW-0003jr-FP; Fri, 08 May 2020 18:21:17 +0100
Subject: Re: [PATCH] rebase --autosquash: fix a potential segfault
To:     Andrei Rybak <rybak.a.v@gmail.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>
Cc:     Johannes Schindelin via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org, Paul Ganssle <paul@ganssle.io>,
        Jeff King <peff@peff.net>
References: <pull.625.git.1588624804554.gitgitgadget@gmail.com>
 <2367cf9d-2e37-b8c2-6881-f3e6c951a460@gmail.com>
 <nycvar.QRO.7.76.6.2005071626340.56@tvgsbejvaqbjf.bet>
 <1a03a7b4-f436-83c5-f825-3b68c07785e9@iee.email>
 <4f2ddbba-a9ba-a96a-36c1-b233ea861575@gmail.com>
From:   Philip Oakley <philipoakley@iee.email>
Message-ID: <fba3874f-865f-53cc-5901-9dabd4a292c7@iee.email>
Date:   Fri, 8 May 2020 18:21:15 +0100
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.8.0
MIME-Version: 1.0
In-Reply-To: <4f2ddbba-a9ba-a96a-36c1-b233ea861575@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Content-Language: en-GB
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Andrei,
On 08/05/2020 17:57, Andrei Rybak wrote:
> On 2020-05-08 18:43, Philip Oakley wrote:
>> On 07/05/2020 15:27, Johannes Schindelin wrote:
>> Is this ability to have a commit message `fixup! <commit-hash>` documented?
>> I've looked a few times in the past and didn't find it. The docs for
>> `git commit --fixup=` doesn't put the oid in the commit's subject line,
>> rather it puts the subject of the referent commit after the "fixup! ".
>>
>> Searching from a different direction I've just seen it is mentioned in
>> the v1.7.4 release notes.
>>
>> Would a doc fix to clarify this be appropriate or have I missed something?
>>
>> Philip
> Yes, it's documented in description of --autosquash: "A commit matches the `...`
> if the commit subject matches, or if the `...` refers to the commit's hash."
I've never read it that way, especially given the `git commit fixup=`
description. That one strongly suggests that one starts with the subject
and then finds the commit id from that.

We do see in the side discussion that the todo list uses the oid, rather
than the subject, which is given verbatim, but the docs are rather
opaque on the question of oid vs subject. 

If it is only the second guessing of the meaning of those three dots
then maybe the docs do need a  bit of clarification.

Philip
