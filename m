Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id CBD661F462
	for <e@80x24.org>; Tue, 18 Jun 2019 20:50:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730469AbfFRUuY (ORCPT <rfc822;e@80x24.org>);
        Tue, 18 Jun 2019 16:50:24 -0400
Received: from bsmtp7.bon.at ([213.33.87.19]:21395 "EHLO bsmtp7.bon.at"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730102AbfFRUuY (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 18 Jun 2019 16:50:24 -0400
Received: from dx.site (unknown [93.83.142.38])
        by bsmtp7.bon.at (Postfix) with ESMTPSA id 45T0b25Gfwz5tlF;
        Tue, 18 Jun 2019 22:50:22 +0200 (CEST)
Received: from [IPv6:::1] (localhost [IPv6:::1])
        by dx.site (Postfix) with ESMTP id 05231358;
        Tue, 18 Jun 2019 22:50:22 +0200 (CEST)
Subject: Re: [RFC PATCH] userdiff: ship built-in driver config file
To:     Boxuan Li <liboxuan@connect.hku.hk>
Cc:     git@vger.kernel.org, gitster@pobox.com
References: <20190617165450.81916-1-liboxuan@connect.hku.hk>
 <488f215a-cb32-db3f-4a45-0062f0f0a0a9@kdbg.org>
From:   Johannes Sixt <j6t@kdbg.org>
Message-ID: <1856d6bc-2cc5-6759-0ed9-8e4d46b6cc47@kdbg.org>
Date:   Tue, 18 Jun 2019 22:50:21 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <488f215a-cb32-db3f-4a45-0062f0f0a0a9@kdbg.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Am 18.06.19 um 22:32 schrieb Johannes Sixt:
> Am 17.06.19 um 18:54 schrieb Boxuan Li:
>> The userdiff.c has been rewritten to avoid hard-coded built-in
>> driver patterns. Now we ship
>> $(sharedir)/git-core/templates/userdiff that can be read using
>> git_config_from_file() interface, using a very narrow callback
>> function that understands only diff.*.xfuncname,
>> diff.*.wordregex, and diff.*.regIcase.

I forgot to thank you for working on this. It is much appreciated.

>>
>> Signed-off-by: Boxuan Li <liboxuan@connect.hku.hk>
>> ---
>> A few notes and questions:
>> 1. In [diff "tex"] section, \x80 and \xff cannot be parsed by git config parser.
>> I have no idea why this is happening. I changed them to \\x80 and \\xff as a workaround, which
>> resulted in t4034 failure (See https://travis-ci.org/li-boxuan/git/jobs/546729906#L4679).
> 
> I guess, the idea is...

I think you noticed that I read the patch top-to-bottom and understood
the gist of it only near the end.

-- Hannes
