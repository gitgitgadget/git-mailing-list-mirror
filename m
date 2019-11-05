Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.2 required=3.0 tests=AWL,BAYES_00,BODY_8BITS,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 1F10B1F454
	for <e@80x24.org>; Tue,  5 Nov 2019 19:14:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390847AbfKETOH (ORCPT <rfc822;e@80x24.org>);
        Tue, 5 Nov 2019 14:14:07 -0500
Received: from smtprelay02.ispgateway.de ([80.67.18.14]:2007 "EHLO
        smtprelay02.ispgateway.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2390526AbfKETOH (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 5 Nov 2019 14:14:07 -0500
Received: from [84.175.180.230] (helo=[192.168.2.6])
        by smtprelay02.ispgateway.de with esmtpsa (TLSv1.2:ECDHE-RSA-AES128-GCM-SHA256:128)
        (Exim 4.92.3)
        (envelope-from <alexandr.miloslavskiy@syntevo.com>)
        id 1iS4HC-0002OK-EH; Tue, 05 Nov 2019 20:14:02 +0100
Subject: Re: [PATCH 1/5] pathspec: add new function to parse file
To:     phillip.wood@dunelm.org.uk,
        Alexandr Miloslavskiy via GitGitGadget 
        <gitgitgadget@gmail.com>, git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>
References: <pull.445.git.1572895605.gitgitgadget@gmail.com>
 <52e7a84a2ee61d6481286f6a32751107efc234d0.1572895605.git.gitgitgadget@gmail.com>
 <e34eba95-f413-ddd3-08c6-4f5b2bed3761@gmail.com>
From:   Alexandr Miloslavskiy <alexandr.miloslavskiy@syntevo.com>
Message-ID: <2145317c-873c-19b9-6ec9-7502656a27ff@syntevo.com>
Date:   Tue, 5 Nov 2019 20:14:02 +0100
User-Agent: Mozilla/5.0 (Windows NT 6.3; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.2.1
MIME-Version: 1.0
In-Reply-To: <e34eba95-f413-ddd3-08c6-4f5b2bed3761@gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-GB
Content-Transfer-Encoding: 8bit
X-Df-Sender: YWxleGFuZHIubWlsb3NsYXZza2l5QHN5bnRldm8uY29t
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 05.11.2019 16:02, Phillip Wood wrote:

>> +    if (!in)
>> +        die(_("could not open '%s' for reading"), file);
> 
> die_errno() would give a more informative message here

Thanks for the pointer!

>> +            if (unquote_c_style(&unquoted, buf.buf, NULL))
>> +                die(_("line is badly quoted"));
> 
> It would be nice to show the offending line in the error message

Good idea.

>> +void parse_pathspec_file(struct pathspec *pathspec,
>> +            unsigned magic_mask,
>> +            unsigned flags,
>> +            const char *prefix,
>> +            const char *file,
>> +            int nul_term_line);
> 
> Do these align with the 's' in "struct pathspec" ?

Sorry, still struggling with my VS that tries to do crazy things. Will fix.
