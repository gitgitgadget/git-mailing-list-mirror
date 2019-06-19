Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 8131A1F462
	for <e@80x24.org>; Wed, 19 Jun 2019 06:30:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725901AbfFSGa3 (ORCPT <rfc822;e@80x24.org>);
        Wed, 19 Jun 2019 02:30:29 -0400
Received: from bsmtp7.bon.at ([213.33.87.19]:11977 "EHLO bsmtp7.bon.at"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725881AbfFSGa2 (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 19 Jun 2019 02:30:28 -0400
Received: from dx.site (unknown [93.83.142.38])
        by bsmtp7.bon.at (Postfix) with ESMTPSA id 45TFSL5gqSz5tlK;
        Wed, 19 Jun 2019 08:30:26 +0200 (CEST)
Received: from [IPv6:::1] (localhost [IPv6:::1])
        by dx.site (Postfix) with ESMTP id 08252208D;
        Wed, 19 Jun 2019 08:30:26 +0200 (CEST)
Subject: Re: [RFC PATCH] userdiff: ship built-in driver config file
To:     Jeff King <peff@peff.net>
Cc:     Boxuan Li <liboxuan@connect.hku.hk>, git@vger.kernel.org,
        gitster@pobox.com
References: <20190617165450.81916-1-liboxuan@connect.hku.hk>
 <488f215a-cb32-db3f-4a45-0062f0f0a0a9@kdbg.org>
 <20190619034929.GA515@sigill.intra.peff.net>
From:   Johannes Sixt <j6t@kdbg.org>
Message-ID: <1da78555-96eb-1206-679b-527911f6af29@kdbg.org>
Date:   Wed, 19 Jun 2019 08:30:25 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <20190619034929.GA515@sigill.intra.peff.net>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Am 19.06.19 um 05:49 schrieb Jeff King:
> On Tue, Jun 18, 2019 at 10:32:47PM +0200, Johannes Sixt wrote:
> 
>> Am 17.06.19 um 18:54 schrieb Boxuan Li:
>>> diff --git a/templates/this--userdiff b/templates/this--userdiff
>>> new file mode 100644
>>> index 0000000000..85114a7229
>>> --- /dev/null
>>> +++ b/templates/this--userdiff
>>
>> Why place this file in .git? To have per-repository diff drivers, we can
>> already specify them via 'git config'. This file should be installed in
>> the system.
> 
> I think it _could_ actually just be part of the system /etc/gitconfig,
> though it is kind of big, and Git has a tendency to parse the config
> more than necessary. I wonder if would add a noticeable slowdown.

But /etc/gitconfig would be the wrong place, because it would not be
updated when a new version ships with new patterns.

I would suggest to install the file as $prefix/share/git-core/userdiff
although the name "userdiff" sounds like an accident. How about
.../filetypes?

-- Hannes
