Return-Path: <SRS0=mA98=7A=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 72247C433E0
	for <git@archiver.kernel.org>; Mon, 18 May 2020 16:47:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4A843207D3
	for <git@archiver.kernel.org>; Mon, 18 May 2020 16:47:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728248AbgERQrR (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 18 May 2020 12:47:17 -0400
Received: from smtp.hosts.co.uk ([85.233.160.19]:62144 "EHLO smtp.hosts.co.uk"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726958AbgERQrR (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 18 May 2020 12:47:17 -0400
Received: from [89.243.191.101] (helo=[192.168.1.37])
        by smtp.hosts.co.uk with esmtpa (Exim)
        (envelope-from <philipoakley@iee.email>)
        id 1jaiv5-00092s-E1; Mon, 18 May 2020 17:47:15 +0100
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
Message-ID: <fc616e86-dfc1-fccf-d22b-ad2aee0d1b16@iee.email>
Date:   Mon, 18 May 2020 17:47:13 +0100
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

Hi all,

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

The docs don't  clarify if a full oid has is required, or a unique
abbreviation within the repository, or just unique within the rebase
instruction sheet.

I'd presume that all it needed was the latter, but could easily expect
the former (full oid) to be 'matching', while the mid ground may be
fairly simple to code...

Philip
