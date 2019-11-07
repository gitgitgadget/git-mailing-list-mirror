Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 2C3CB1F454
	for <e@80x24.org>; Thu,  7 Nov 2019 11:40:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387894AbfKGLkC (ORCPT <rfc822;e@80x24.org>);
        Thu, 7 Nov 2019 06:40:02 -0500
Received: from smtprelay01.ispgateway.de ([80.67.31.28]:7222 "EHLO
        smtprelay01.ispgateway.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728051AbfKGLkC (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 7 Nov 2019 06:40:02 -0500
Received: from [24.134.116.61] (helo=[192.168.92.208])
        by smtprelay01.ispgateway.de with esmtpsa (TLSv1.2:ECDHE-RSA-AES128-GCM-SHA256:128)
        (Exim 4.92.3)
        (envelope-from <alexandr.miloslavskiy@syntevo.com>)
        id 1iSg8r-0002O7-Is; Thu, 07 Nov 2019 12:39:57 +0100
Subject: Re: [PATCH 4/5] doc: commit: unify <pathspec> description
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Alexandr Miloslavskiy via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org
References: <pull.445.git.1572895605.gitgitgadget@gmail.com>
 <251d06e27f6bc93b190450ae6e1087a3126b5e52.1572895605.git.gitgitgadget@gmail.com>
 <xmqq8sotvcar.fsf@gitster-ct.c.googlers.com>
 <6cd64094-d229-ef96-86fd-e64accd759d4@syntevo.com>
 <xmqqk18cqlij.fsf@gitster-ct.c.googlers.com>
From:   Alexandr Miloslavskiy <alexandr.miloslavskiy@syntevo.com>
Message-ID: <ffcc5857-a6c8-1cf5-f5b6-334e778c576c@syntevo.com>
Date:   Thu, 7 Nov 2019 12:39:55 +0100
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.2.1
MIME-Version: 1.0
In-Reply-To: <xmqqk18cqlij.fsf@gitster-ct.c.googlers.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-GB
Content-Transfer-Encoding: 7bit
X-Df-Sender: YWxleGFuZHIubWlsb3NsYXZza2l5QHN5bnRldm8uY29t
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 07.11.2019 6:54, Junio C Hamano wrote:
> I am reacting to this from your change that you omitted quoting in
> your reply:
> 
>> +For more details about the <pathspec> syntax, see the 'pathspec' entry
>> +in linkgit:gitglossary[7].
> 
> That sentence is for those who have some notion of <pathspec> but
> does not know enough about its syntax.

In the perfect world, I would expect _every_ 'pathspec' word in text to 
be an HTML-style link to a dedicated article, not just a paragraph in 
glossary.

MSDN is in general a good example [1]: there, it's easy to read only a 
small portion of article, ignoring anything you're not interested in, 
and still have all links at hand.

Regarding dedicated page: the content of 'pathspec' in glossary is 
already long enough for a page, and it could benefit from additional 
examples. Also, having a dedicated page makes linking easier, so that 
user doesn't have to scroll glossary.

Regarding links: I don't really understand what git's doc format allows. 
Is it just pure text in worst (or even average) case?

If it's usually something with clickable links, it could be worth to 
just insert links everywhere.

If it's usually plaintext, then "see the 'pathspec' entry in 
linkgit:gitglossary[7]" is a bit too verbose to repeat on every 
occasion. Still, I'd like to see links everywhere. One big reason is to 
let reader know that the explanation actually exists!

A compromise solution is to give every article header like this:

     This article uses the following terms which are explained
     in linkgit:gitglossary[7]:
     * pathspec
     * tree-ish
     * refspec

If it's close to top of article, then chances are that everyone will 
notice it. Also, it will not require extra verbosity in plaintext.

> CVS does not let you specify <commit> like "master^{/^fix frotz}~4";
> A user a user who is familiar with CVS's commits would still want to
> refer to the section "For details about the <commit> syntax".
> 
> I am not advocating to add the reference to SPECIFYING REVISIONS
> section; instead we should let readers know that every time they see
> <defined word>, they can refer to the glossary for more details.

I now think that my arguments apply to <pathspec> AND <commit> in the 
same way. Indeed a user can't know complex <commit> variants until 
he/she reads it in git docs.

----

[1] 
https://docs.microsoft.com/en-us/windows/win32/api/fileapi/nf-fileapi-createfilea
