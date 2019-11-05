Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.9 required=3.0 tests=AWL,BAYES_00,BODY_8BITS,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id EF65C1F454
	for <e@80x24.org>; Tue,  5 Nov 2019 19:42:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390873AbfKETmp (ORCPT <rfc822;e@80x24.org>);
        Tue, 5 Nov 2019 14:42:45 -0500
Received: from smtprelay03.ispgateway.de ([80.67.18.15]:25178 "EHLO
        smtprelay03.ispgateway.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2390802AbfKETmp (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 5 Nov 2019 14:42:45 -0500
Received: from [84.175.180.230] (helo=[192.168.2.6])
        by smtprelay03.ispgateway.de with esmtpsa (TLSv1.2:ECDHE-RSA-AES128-GCM-SHA256:128)
        (Exim 4.92.3)
        (envelope-from <alexandr.miloslavskiy@syntevo.com>)
        id 1iS4it-0002A4-QV; Tue, 05 Nov 2019 20:42:39 +0100
Subject: Re: [PATCH 5/5] commit: support the --pathspec-from-file option
To:     phillip.wood@dunelm.org.uk,
        Alexandr Miloslavskiy via GitGitGadget 
        <gitgitgadget@gmail.com>, git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>
References: <pull.445.git.1572895605.gitgitgadget@gmail.com>
 <f4847046896848d3f16bc5f3cb7a26271cefd97c.1572895605.git.gitgitgadget@gmail.com>
 <9ca7fa57-c438-7243-6ab1-956d8f132d37@gmail.com>
From:   Alexandr Miloslavskiy <alexandr.miloslavskiy@syntevo.com>
Message-ID: <73fb5aa2-6cdb-424a-5696-a2609d74a034@syntevo.com>
Date:   Tue, 5 Nov 2019 20:42:40 +0100
User-Agent: Mozilla/5.0 (Windows NT 6.3; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.2.1
MIME-Version: 1.0
In-Reply-To: <9ca7fa57-c438-7243-6ab1-956d8f132d37@gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-GB
Content-Transfer-Encoding: 8bit
X-Df-Sender: YWxleGFuZHIubWlsb3NsYXZza2l5QHN5bnRldm8uY29t
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 05.11.2019 17:27, Phillip Wood wrote:

>> Also add new '--pathspec-file-null' switch that mirrors '-z' used in
>> various places. Some porcelain commands, such as `git commit`, already
>> use '-z', therefore it needed a new unambiguous name.
> 
> It might be worth tailoring the message to the command rather than 
> having exactly the same message for commit and reset

I also was somewhat unhappy about duplication. But I didn't figure how 
to do that correctly. Currently the messages for 'git reset' and 'git 
commit' are almost identical.

Maybe in 2nd commit I should say something like "Extend 
`--pathspec-file-null` support to `git commit` (see previous patch for 
`git reset`)" ?

> I think my comments from patch 3 about <pathspecs> and the option names 
> apply here as well

Yes, sure, I will try to apply your suggestions to all patches. 
Hopefully without forgetting things :)

>> +    if (!pathspec.nr && (also || (only && !amend && !allow_empty)))
>> +        die(_("No paths with --include/--only does not make sense."));
> 
> I wonder if there is a way of calling parse_pathspec_file() from 
> parse_and_validate_options() instead. Otherwise we end up validating 
> options here instead which is a bit messy.

Yes, I was also somewhat unhappy about that. I will give it more thought.

> Overall this series is nicely structured and is looking pretty good

Thanks, and also thanks for reviewing my patches!

