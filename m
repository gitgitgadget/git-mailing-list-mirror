Return-Path: <SRS0=05is=6N=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7353FC83000
	for <git@archiver.kernel.org>; Wed, 29 Apr 2020 21:30:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 56F3120B1F
	for <git@archiver.kernel.org>; Wed, 29 Apr 2020 21:30:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726891AbgD2VaW (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 29 Apr 2020 17:30:22 -0400
Received: from bsmtp.bon.at ([213.33.87.14]:49554 "EHLO bsmtp.bon.at"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726511AbgD2VaW (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 29 Apr 2020 17:30:22 -0400
Received: from dx.site (unknown [93.83.142.38])
        by bsmtp.bon.at (Postfix) with ESMTPSA id 49CBWJ0bZhz5tlG;
        Wed, 29 Apr 2020 23:30:20 +0200 (CEST)
Received: from [IPv6:::1] (localhost [IPv6:::1])
        by dx.site (Postfix) with ESMTP id 6239316AB;
        Wed, 29 Apr 2020 23:30:19 +0200 (CEST)
Subject: Re: [PATCH 0/4] t: replace incorrect test_must_fail usage (part 5)
To:     Taylor Blau <me@ttaylorr.com>
Cc:     Denton Liu <liu.denton@gmail.com>,
        Git Mailing List <git@vger.kernel.org>
References: <cover.1588162842.git.liu.denton@gmail.com>
 <20200429195035.GB3920@syl.local>
From:   Johannes Sixt <j6t@kdbg.org>
Message-ID: <90edb162-e035-bdb7-a2d2-ffc6bd075977@kdbg.org>
Date:   Wed, 29 Apr 2020 23:30:19 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
MIME-Version: 1.0
In-Reply-To: <20200429195035.GB3920@syl.local>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Am 29.04.20 um 21:50 schrieb Taylor Blau:
> This comment has nothing to do with your series, but I am curious if you
> are planning on touching 'test_might_fail' at all. These can be useful
> for non-Git commands, too, such as 'test_might_fail umask 022' on
> systems that may or may not do something sensible with umask.

When it's not a git command that might fail, the idiom is

	... &&
	{ umask 022 || :; } &&
	...

-- Hannes
