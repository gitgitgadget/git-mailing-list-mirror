Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C3AC7C07E95
	for <git@archiver.kernel.org>; Sat, 10 Jul 2021 20:07:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9F62F6128B
	for <git@archiver.kernel.org>; Sat, 10 Jul 2021 20:07:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229714AbhGJUKc (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 10 Jul 2021 16:10:32 -0400
Received: from smtprelay01.ispgateway.de ([80.67.31.28]:17913 "EHLO
        smtprelay01.ispgateway.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229515AbhGJUKc (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 10 Jul 2021 16:10:32 -0400
Received: from [84.163.65.41] (helo=[192.168.2.202])
        by smtprelay01.ispgateway.de with esmtpsa  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256
        (Exim 4.94.2)
        (envelope-from <git@mfriebe.de>)
        id 1m2JGT-0004VK-PR; Sat, 10 Jul 2021 22:07:53 +0200
Subject: Re: PATCH: improve git switch documentation
To:     Felipe Contreras <felipe.contreras@gmail.com>,
        Sergey Organov <sorganov@gmail.com>
Cc:     Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
References: <c593a699-eaf2-c7ab-b522-bfd224fce829@mfriebe.de>
 <7870a0ad-8fa1-9dbd-1978-1f44ec6970c5@mfriebe.de>
 <xmqqy2arrmba.fsf@gitster.g>
 <b80bf908-0c31-2b3a-6d6c-1a3fba5b2334@mfriebe.de>
 <87wnqaclz8.fsf@osv.gnss.ru> <60e5f3981de5f_301437208bc@natae.notmuch>
 <87bl7d3l8r.fsf@osv.gnss.ru> <60e61bbd7a37d_3030aa2081a@natae.notmuch>
 <877di13hhe.fsf@osv.gnss.ru>
 <c740a4f0-011f-762e-4f49-f85d1b3abc99@mfriebe.de>
 <60e67389a4adc_306ac1208fd@natae.notmuch>
 <4057b3ac-a77c-0d5f-d3f4-ad781754aae4@mfriebe.de>
 <60e736e72da68_30939020850@natae.notmuch>
 <155308af-42ad-b044-fb37-676251a9b7e1@mfriebe.de>
 <60e762243aab1_30a7b02089@natae.notmuch>
 <2b85a7eb-d0be-65e7-ecbb-1750abf53e53@mfriebe.de>
 <60e79c31aaa72_30b8a4208c1@natae.notmuch>
 <65362688-b65b-661c-20c1-94d7dc2118c7@mfriebe.de>
 <60e874e1c6845_215320861@natae.notmuch>
 <dbfa96f0-558e-ccaf-6e34-6d95c43848b5@mfriebe.de>
 <60e88a4b8592f_16bcb2082b@natae.notmuch>
 <ad58bd54-a9dd-59a9-4fce-f90be469cd60@mfriebe.de>
 <60e9f8d462bd9_7ef20898@natae.notmuch>
From:   Martin <git@mfriebe.de>
Message-ID: <6f43b36b-abe1-41f2-6138-e820c974b1bd@mfriebe.de>
Date:   Sat, 10 Jul 2021 22:07:41 +0200
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
MIME-Version: 1.0
In-Reply-To: <60e9f8d462bd9_7ef20898@natae.notmuch>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-GB
Content-Transfer-Encoding: 7bit
X-Df-Sender: bWVAbWZyaWViZS5kZQ==
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 10/07/2021 21:45, Felipe Contreras wrote:
> Martin wrote:
> No. You can add all the explanation you want after "Resets the branch to
> <head>.", but most of that explanation would be redundant, because as we
> already agreed, there's no way to reset the head of a branch without
> changing the branch.

By that logic a lot of explanations are redundant, because on some 
lever, if every user thinks far enough lots of things can be concluded.

 From the docs (and similar on git checkout)
> --force
> 
>     An alias for --discard-changes.
> --discard-changes
> 
>     Proceed even if the index or the working tree differs from HEAD.
> Both the index and working tree are restored to match the switching 
> target. If --recurse-submodules is specified, submodule content is 
> also restored to match the switching target. This is used to throw
> away local changes.

If the working tree is made to match the target, then it can not retain 
local changes. That can be concluded.
Yet, it is explicitly mentioned.

Does it really hurt to mention it?
People overlook details that to others are blaring obvious.
I agree, we can not mention every potential possibility. But as a 
general rule, if data could be lost, then a mention (an explicit 
mention) should be made.

Yes, commits may be hold by the reflog. Except the reflog is optional. 
And more to the point, the reflog is unknown to plenty of people (never 
mind if they should know it, they do not) So the possibility of loss is 
rather real.

But anyway.
I brought forward my idea. I explained my reasoning.
If it (this part) is downvoted/rejected then that it how it is.


There still is the idea to replace the word "branch" by "branch name" in 
some parts of the git switch documentation.



>>>> So, I still ask:
>>>> - If "--force" to overwrite the work tree can clearly state that change
>>>> to files will be "thrown away".
>>>> - Then why can "force" re-using an existing branch name not do the same?
>>>
>>> Because we would be forcing two things now.
>>
>> Which 2 things?
>>
>> The worktree overwriting is *not* forced by -C
>>
>>     git switch -C b1 b2
>>     git checkout -B b1 b2
>>
>> both give an error if the worktree has changed files.
>>
>> This is only about what happens to the branch.
>>
>> I.e we force the branchname to point to our new branch.
>> And that means the branchname no longe points to the old branch, and the
>> old branch therefore is removed.
> 
> It seems your proposal is to make `git switch -c --force b1 b2` be the same as
> `git switch -C b1 b2`, but that would also make it the same as
> `git switch -C --force b1 b2`. Therefore it would be forcing two things.
> 
> Or is your proposal something else?
> 

No. I definitely want to keep those 2 apart from each other.

For each force-needing action, you should have to specify it's own force 
flag.

I do not want to change the behaviour on that part.

I only compared the
- doc of "-f" for worktree overwrites
with the
- doc -C for branch overwrites.

And I found that the former makes explicit mention of what can be lost, 
the latter leaves it to be concluded.

