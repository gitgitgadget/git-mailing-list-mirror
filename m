Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.3 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 733761F453
	for <e@80x24.org>; Wed,  7 Nov 2018 06:55:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730261AbeKGQYk (ORCPT <rfc822;e@80x24.org>);
        Wed, 7 Nov 2018 11:24:40 -0500
Received: from bsmtp7.bon.at ([213.33.87.19]:32114 "EHLO bsmtp7.bon.at"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726194AbeKGQYk (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 7 Nov 2018 11:24:40 -0500
Received: from dx.site (unknown [93.83.142.38])
        by bsmtp7.bon.at (Postfix) with ESMTPSA id 42qccp6w8tz5tmf;
        Wed,  7 Nov 2018 07:55:38 +0100 (CET)
Received: from [IPv6:::1] (localhost [IPv6:::1])
        by dx.site (Postfix) with ESMTP id 69E711B09;
        Wed,  7 Nov 2018 07:55:38 +0100 (CET)
Subject: Re: [PATCH 1/1] Windows: force-recompile git.res for differing
 architectures
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Johannes Schindelin via GitGitGadget <gitgitgadget@gmail.com>,
        Johannes Schindelin <johannes.schindelin@gmx.de>,
        git@vger.kernel.org
References: <pull.67.git.gitgitgadget@gmail.com>
 <87794514ef3a83f95d81f89287b81aeed5c92296.1541516148.git.gitgitgadget@gmail.com>
 <c4e3790e-4c41-0d15-38d9-79fa288fb9b3@kdbg.org>
 <xmqqk1lpd65h.fsf@gitster-ct.c.googlers.com>
From:   Johannes Sixt <j6t@kdbg.org>
Message-ID: <ad98ab16-c6bf-7294-f498-d0e7295105fc@kdbg.org>
Date:   Wed, 7 Nov 2018 07:55:38 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.2.1
MIME-Version: 1.0
In-Reply-To: <xmqqk1lpd65h.fsf@gitster-ct.c.googlers.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Am 07.11.18 um 02:32 schrieb Junio C Hamano:
> Johannes Sixt <j6t@kdbg.org> writes:
>> On Linux, when I recompile for a different architecture, CFLAGS would
>> change, so I would have thought that GIT-CFLAGS were the natural
>> choice for a dependency. Don't they change in this case on Windows,
>> too?
> 
> Depending on GIT-CFLAGS would have a better chance of being safe, I
> guess, even though it can at times be overly safe, than GIT-PREFIX,
> I suspect.  As a single user target in Makefile, which is only used
> by Dscho, who intends to stick to /mingw(32|64)/ convention til the
> end of time, I think the posted patch is OK, though.

I think that it's not only Dscho who uses the target (my build 
environment, for example, is different from Dscho's and compiles 
git.res, too). But since the patch helps him most and doesn't hurt 
others, it is good to go. No objection from my side.

-- Hannes
