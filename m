Return-Path: <SRS0=dWK1=36=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 47733C352A3
	for <git@archiver.kernel.org>; Mon, 10 Feb 2020 15:10:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2703420838
	for <git@archiver.kernel.org>; Mon, 10 Feb 2020 15:10:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729315AbgBJPKg (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 10 Feb 2020 10:10:36 -0500
Received: from smtprelay01.ispgateway.de ([80.67.31.39]:3606 "EHLO
        smtprelay01.ispgateway.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727347AbgBJPKf (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 10 Feb 2020 10:10:35 -0500
Received: from [84.175.181.115] (helo=[192.168.2.6])
        by smtprelay01.ispgateway.de with esmtpsa (TLSv1.2:ECDHE-RSA-AES128-GCM-SHA256:128)
        (Exim 4.92.3)
        (envelope-from <alexandr.miloslavskiy@syntevo.com>)
        id 1j1ALB-0008Pg-10; Mon, 10 Feb 2020 15:47:13 +0100
Subject: Re: [PATCH 4/8] doc: stash: split options from description (2)
To:     Junio C Hamano <gitster@pobox.com>,
        Alexandr Miloslavskiy via GitGitGadget 
        <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org,
        Paul-Sebastian Ungureanu <ungureanupaulsebastian@gmail.com>
References: <pull.530.git.1579190965.gitgitgadget@gmail.com>
 <708363241f4940e5b627af8519345b762deb77ab.1579190965.git.gitgitgadget@gmail.com>
 <xmqqblqwa7d3.fsf@gitster-ct.c.googlers.com>
From:   Alexandr Miloslavskiy <alexandr.miloslavskiy@syntevo.com>
Message-ID: <eed07f5d-4554-6d26-4d71-f1f975e0ff12@syntevo.com>
Date:   Mon, 10 Feb 2020 15:47:13 +0100
User-Agent: Mozilla/5.0 (Windows NT 6.3; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.4.2
MIME-Version: 1.0
In-Reply-To: <xmqqblqwa7d3.fsf@gitster-ct.c.googlers.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-GB
Content-Transfer-Encoding: 7bit
X-Df-Sender: YWxleGFuZHIubWlsb3NsYXZza2l5QHN5bnRldm8uY29t
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 21.01.2020 21:21, Junio C Hamano wrote:
> I have a mixed feelings about this approach.  While I am sympathetic
> to the "have a single place to describe all" approach this patch
> takes, the approach needs to be executed with care when subcommands
> do not share much of the options at all.  Those readers who jump to
> the "OPTIONS" section and try to ignore anything outside the section
> may not easily notice that --keep-index only applies to subcommands
> that creates a new stash, and meaningless to subcommands that lets
> you inspect existing stashes, or apply one to the working tree (and
> optionally to the index), for example.  If the orinal documentation
> did not use "OPTIONS" as the section header and instead said perhaps
> "SUBCOMMANDS", it would have been even better, but otherwise I would
> suspect that the original "the options understood by 'push' are all
> described under the part that begins with 'push [-p] [-k] ...'
> command line" arrangement was much easier to understand when reading
> them through for the first time to learn and also to find what the
> user is looking for after learning the "concept" (e.g. "with
> 'stash', there is a way to stash-away the changes made to the
> working tree") but before becoming familiar with exact set of
> options for each subcommand (e.g. "and there was an option that let
> me stash only partial changes piecemeal, but what was it spelled?").
> 
> If we were to make the result of "a single place to describe all"
> approach anything useful, I think at least
> 
>   (1) the list itself should make it clear that it does not talk
>       about options related to listing and showing at all,
>       before enumerating dashed options.
> 
>   (2) each item in the enumeration should identify which
>       subcommand(s) accept(s) it.
> 
> So, I dunno.

I have updated the patch with (2). Sorry, I didn't understand what you 
mean in (1).

I have included my reasoning in commit message. If you feel against this 
change, I guess I'll just revert it. Afterall, my only goal was to 
describe new options. Tried to change things because I didn't like how 
this doc goes against the layout I have seen in all previous docs I edited.
