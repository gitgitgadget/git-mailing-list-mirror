Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.2 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,NICE_REPLY_A,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E831FC49EA6
	for <git@archiver.kernel.org>; Thu, 24 Jun 2021 22:07:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C8F8F613A9
	for <git@archiver.kernel.org>; Thu, 24 Jun 2021 22:07:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232784AbhFXWJn (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 24 Jun 2021 18:09:43 -0400
Received: from smtp.hosts.co.uk ([85.233.160.19]:32000 "EHLO smtp.hosts.co.uk"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229848AbhFXWJn (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 24 Jun 2021 18:09:43 -0400
Received: from host-78-147-180-220.as13285.net ([78.147.180.220] helo=[192.168.1.37])
        by smtp.hosts.co.uk with esmtpa (Exim)
        (envelope-from <philipoakley@iee.email>)
        id 1lwXVJ-0007nV-97; Thu, 24 Jun 2021 23:07:22 +0100
Subject: Re: [PATCH 1/2] doc: pull: explain what is a fast-forward
To:     Felipe Contreras <felipe.contreras@gmail.com>, git@vger.kernel.org
Cc:     =?UTF-8?Q?V=c3=adt_Ondruch?= <vondruch@redhat.com>,
        Jacob Keller <jacob.keller@gmail.com>,
        Alex Henrie <alexhenrie24@gmail.com>,
        Junio C Hamano <gitster@pobox.com>,
        Jeff King <peff@peff.net>, Elijah Newren <newren@gmail.com>
References: <20210621175234.1079004-1-felipe.contreras@gmail.com>
 <20210621175234.1079004-2-felipe.contreras@gmail.com>
 <b4e612ba-21c7-3bef-d113-0f070449cd87@iee.email>
 <60d49748b8538_2fb2082c@natae.notmuch>
 <c2170f74-b93b-599b-1fb4-45b013c7bff1@iee.email>
 <60d4d75e7622c_242620854@natae.notmuch>
From:   Philip Oakley <philipoakley@iee.email>
Message-ID: <93084036-804d-4c52-2836-42efd5deba1c@iee.email>
Date:   Thu, 24 Jun 2021 23:07:21 +0100
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
MIME-Version: 1.0
In-Reply-To: <60d4d75e7622c_242620854@natae.notmuch>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Content-Language: en-GB
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 24/06/2021 20:05, Felipe Contreras wrote:
> Philip Oakley wrote:
>> Hi Felipe,
>> On 24/06/2021 15:31, Felipe Contreras wrote:
>>> Philip Oakley wrote:
>>>> On 21/06/2021 18:52, Felipe Contreras wrote:
>>>>> --- a/Documentation/git-pull.txt
>>>>> +++ b/Documentation/git-pull.txt
>>>>> @@ -41,16 +41,41 @@ Assume the following history exists and the current branch is
>>>>>  ------------
>>>>>  	  A---B---C master on origin
>>>>>  	 /
>>>>> -    D---E---F---G master
>>>>> +    D---E master
>>>>>  	^
>>>>>  	origin/master in your repository
>>>>>  ------------
>>>>>  
>>>>>  Then "`git pull`" will fetch and replay the changes from the remote
>>>>>  `master` branch since it diverged from the local `master` (i.e., `E`)
>>>>> -until its current commit (`C`) on top of `master` and record the
>>>>> -result in a new commit along with the names of the two parent commits
>>>>> -and a log message from the user describing the changes.
>>>>> +until its current commit (`C`) on top of `master`.
>>>>> +
>>>>> +After the remote changes have been synchronized, the local `master` will
>>>>> +be fast-forwarded to the same commit as the remote one, therefore
>>>> Perhaps s/be fast-forwarded/have been 'fast-forward'ed/ ?
>>> No, there's multiple steps:
>> My key point was to 'quote' the fast-forward term.
> fast-forward is an English word [1], there's no need to quote it as if
> it weren't.

You appear to be arguing that your "explain what is a fast-forward"
(subject line of the patch) doesn't need, within the patch, to explain
that it is about the term "fast-forward", being used in a Git specific
way...

>
>> And then (if suitable, with appropriate grammar corrections) indicate
>> subtly that 'nothing actually moved', we just moved the post-it note
>> showing the branch-name on the DAG [hence the confusion about timing] ;-)
> A branch is a "post-it note", moving the post-it note is the same thing
> as moving the branch.
>
> Both the "origin/master" branch, and the "master" branch moved. So I
> don't know how exactly "nothing actually moved".
>
> Perhaps you meant no commit was created, and therefore the DAG didn't
> change.
>
> Maybe instead of saying "creating a linear history", "representing a
> linear history"?
>
> [1] https://www.merriam-webster.com/dictionary/fast-forward
>
P.
