Return-Path: <SRS0=DNVg=EI=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.2 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C0498C00A89
	for <git@archiver.kernel.org>; Mon,  2 Nov 2020 21:18:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 67A04207BB
	for <git@archiver.kernel.org>; Mon,  2 Nov 2020 21:18:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725968AbgKBVSV (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 2 Nov 2020 16:18:21 -0500
Received: from smtp.hosts.co.uk ([85.233.160.19]:40384 "EHLO smtp.hosts.co.uk"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725833AbgKBVSV (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 2 Nov 2020 16:18:21 -0500
Received: from host-89-243-187-160.as13285.net ([89.243.187.160] helo=[192.168.1.37])
        by smtp.hosts.co.uk with esmtpa (Exim)
        (envelope-from <philipoakley@iee.email>)
        id 1kZhDW-0000SG-6J; Mon, 02 Nov 2020 21:18:19 +0000
Subject: Re: Broken-point Continuingly-cloning
To:     Wenyin Wei <wenyin.wei.ww@gmail.com>, git@vger.kernel.org
References: <CABKv=+456ECj_JgHZwnjPt_3H4odWmuM=3+G0FF+X+0noVcCfg@mail.gmail.com>
From:   Philip Oakley <philipoakley@iee.email>
Message-ID: <5adca37d-20df-ba9d-fd26-097c2cbdead2@iee.email>
Date:   Mon, 2 Nov 2020 21:18:18 +0000
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.4.0
MIME-Version: 1.0
In-Reply-To: <CABKv=+456ECj_JgHZwnjPt_3H4odWmuM=3+G0FF+X+0noVcCfg@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Content-Language: en-GB
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 02/11/2020 11:37, Wenyin Wei wrote:
> Dear Git Community,
>
> Consider the number of large repositories using Git has increased
> these years dramatically, is it possible for Git to make a
> discontinuous clone way? The required continuity for a git clone has
> been hard for large repos, and developers have strived by the somewhat
> ugly way, `git fetch –depth=<increasing n>`.
>
> 1. https://stackoverflow.com/questions/38618885/error-rpc-failed-curl-transfer-closed-with-outstanding-read-data-remaining
> 2. https://stackoverflow.com/questions/60878838/git-rpc-failed-curl-18-transfer-closed-with-outstanding-read-data-remaining
>
> It would be appreciated for many developers to see that git could
> support something like broken-point continuingly-cloning. I am not
> sure whether the `git clone git@......` way supports this
> functionality, but even so, some mirror hubs in China, to accelerate
> cloning, only support the `https` way and then become anxious while
> cloning. Anticipate your comments and reply.
>
> Best Wishes,
> Wenyin Wei
Do have a look at the Partial Clone methods which IIUC have been
developed to align with the problem of large repos (such as Windows).
This filters the download to just those that have been selected as 'needed.

There was also, separately, some patches to IIRC keep alive connections
for places with slow internet connections.

The list archive is at https://lore.kernel.org/git/ and is relatively
easy to search.

[e.g. keepalive]
https://lore.kernel.org/git/20160715104347.GL19271@sigill.intra.peff.net/
