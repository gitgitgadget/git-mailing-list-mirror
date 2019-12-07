Return-Path: <SRS0=g+dp=Z5=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 13BDEC43603
	for <git@archiver.kernel.org>; Sat,  7 Dec 2019 16:54:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E28572176D
	for <git@archiver.kernel.org>; Sat,  7 Dec 2019 16:54:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726455AbfLGQyi (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 7 Dec 2019 11:54:38 -0500
Received: from smtp.hosts.co.uk ([85.233.160.19]:23649 "EHLO smtp.hosts.co.uk"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726414AbfLGQyi (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 7 Dec 2019 11:54:38 -0500
Received: from [92.30.123.115] (helo=[192.168.1.22])
        by smtp.hosts.co.uk with esmtpa (Exim)
        (envelope-from <philipoakley@iee.email>)
        id 1iddLo-0005hm-4j; Sat, 07 Dec 2019 16:54:36 +0000
Subject: Re: Git as data archive
To:     Andreas Kalz <andreas-kalz@gmx.de>, git@vger.kernel.org
References: <21fcdc5f-955a-e027-0d71-15f476f6162c@gmx.de>
From:   Philip Oakley <philipoakley@iee.email>
Message-ID: <60945f9c-d79c-7806-0c5e-3e2affcea001@iee.email>
Date:   Sat, 7 Dec 2019 16:54:37 +0000
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.1
MIME-Version: 1.0
In-Reply-To: <21fcdc5f-955a-e027-0d71-15f476f6162c@gmx.de>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-GB
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Andreas,

On 06/12/2019 18:54, Andreas Kalz wrote:
> Hello,
> I am using git as archive and versioning also for photos. Apart from
> performance issues, I wanted to ask if there are hard limits and
> configurable limits (how to configure?) for maximum single file size and
> maximum .git archive size (Windows 64 Bit system)?
> Thanks in advance for your answer.
> All the best,
> Andreas

On Git the file size is currently limited to size of `long`, rather than 
`size_t`. Hence on Git-for Windows the size limit is 32bit ~4GiB

Any change will be a big change as it ripples through many places in the 
code base and, for some, will feel 'wrong'. I did some work [1-4] on top 
of those of many others that was almost there, but...

The alternative is git-lfs, which I don't personally use (see [4]).

Philip

[1] https://github.com/git-for-windows/git/pull/2179
[2] https://github.com/gitgitgadget/git/pull/115
[3] https://github.com/git-for-windows/git/issues/1063
[4] https://github.com/git-lfs/git-lfs/issues/2434

