Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.4 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A8053C433DB
	for <git@archiver.kernel.org>; Wed,  3 Feb 2021 17:24:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 44EC464F4B
	for <git@archiver.kernel.org>; Wed,  3 Feb 2021 17:24:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232299AbhBCRYA (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 3 Feb 2021 12:24:00 -0500
Received: from bsmtp.bon.at ([213.33.87.14]:11526 "EHLO bsmtp.bon.at"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232230AbhBCRXq (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 3 Feb 2021 12:23:46 -0500
Received: from dx.site (unknown [93.83.142.38])
        by bsmtp.bon.at (Postfix) with ESMTPSA id 4DW7ml64ftz5tlF;
        Wed,  3 Feb 2021 18:23:03 +0100 (CET)
Received: from [IPv6:::1] (localhost [IPv6:::1])
        by dx.site (Postfix) with ESMTP id 1F46A49F0;
        Wed,  3 Feb 2021 18:23:03 +0100 (CET)
Subject: Re: [PATCH] annotate-tests: quote variable expansions containing path
 names
To:     Jeff King <peff@peff.net>,
        Philippe Blain <levraiphilippeblain@gmail.com>
Cc:     Git Mailing List <git@vger.kernel.org>
References: <cec4f442-03ea-e846-2613-f390b1e4d31b@kdbg.org>
 <762b6a24-15ef-7578-6064-eb82832699a4@gmail.com>
 <YBoy/F3tS3JtyhDX@coredump.intra.peff.net>
From:   Johannes Sixt <j6t@kdbg.org>
Message-ID: <f667e887-0ba0-af0a-91a9-d84d833422b0@kdbg.org>
Date:   Wed, 3 Feb 2021 18:23:03 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.7.0
MIME-Version: 1.0
In-Reply-To: <YBoy/F3tS3JtyhDX@coredump.intra.peff.net>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Am 03.02.21 um 06:22 schrieb Jeff King:
> On Sat, Jan 30, 2021 at 12:14:56PM -0500, Philippe Blain wrote:
> 
>> Apart from that, maybe we could set up one of the CI jobs to
>> clone git.git into a path with spaces, to try to avoid these
>> kind of errors in the future ?
> 
> We put a space in the temporary trash directory created by the test
> suite for exactly this purpose. So I was curious why it didn't detect
> this problem.
> 
> It looks like it's because the issue is with $TEST_DIRECTORY, which is
> outside the trash directory.

Yes, correct. I was also suprised at first that this was not caught.

-- Hannes
