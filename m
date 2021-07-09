Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EC2DFC07E99
	for <git@archiver.kernel.org>; Fri,  9 Jul 2021 18:23:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C5F41613BF
	for <git@archiver.kernel.org>; Fri,  9 Jul 2021 18:23:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229535AbhGIS0m (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 9 Jul 2021 14:26:42 -0400
Received: from smtprelay08.ispgateway.de ([134.119.228.110]:38596 "EHLO
        smtprelay08.ispgateway.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229491AbhGIS0m (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 9 Jul 2021 14:26:42 -0400
Received: from [84.163.73.96] (helo=[192.168.2.202])
        by smtprelay08.ispgateway.de with esmtpsa  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256
        (Exim 4.94.2)
        (envelope-from <git@mfriebe.de>)
        id 1m1v9n-0005f2-2y; Fri, 09 Jul 2021 20:23:23 +0200
Subject: Re: PATCH: improve git switch documentation
To:     Felipe Contreras <felipe.contreras@gmail.com>,
        Sergey Organov <sorganov@gmail.com>
Cc:     Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
References: <c593a699-eaf2-c7ab-b522-bfd224fce829@mfriebe.de>
 <b667ca37-b3cb-fce2-a298-63c3b839089d@mfriebe.de>
 <xmqqpmw4uwh2.fsf@gitster.g>
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
From:   Martin <git@mfriebe.de>
Message-ID: <ad58bd54-a9dd-59a9-4fce-f90be469cd60@mfriebe.de>
Date:   Fri, 9 Jul 2021 20:23:54 +0200
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
MIME-Version: 1.0
In-Reply-To: <60e88a4b8592f_16bcb2082b@natae.notmuch>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-GB
Content-Transfer-Encoding: 7bit
X-Df-Sender: bWVAbWZyaWViZS5kZQ==
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 09/07/2021 19:41, Felipe Contreras wrote:
> Martin wrote:
>> Well, that is the question as what the action is perceived.
>> I think the example is wrong, rather than the command.
>>
>> -c / -C /-n / -N always *c*reate an *n*ew branch. (create and new really
>> are the same thing here)
>>
>> But if the branch name Foo, is already used?
>> Well, it will still be a *new* branch being *created*.
>> To do that it has to remove the name from the old branch. (effectively
>> removing the old branch).
> 
> But it's not removing the name, it's merely changing the head.
> 
> I don't particularly mind having -C or -N, I just would not use them
> because I like to be explicit. I don't use --new for something that
> already exists.

But that comes down to the "what is a branch" discussion.

It is not creating a new branchname. But it is creating a new branch. 
And then the branchname refers to that new branch.

It changes head, base, and the entire content. That effectively makes it 
new.

If you have a 10 year old car that you nicknamed "speedy", and I come 
along and I replace every part (every screw, every whatever...) with a 
brand new part, would you still call the result a 10 year old car (even 
if (or just because) you still use the nickname) ?


Using "reset", it's similar. Except that human language is slopy.
If I play WOW, and I reset the game. Actually that is already wrong. I 
do not reset the game. It is still the same code, the same images.... I 
do reset my session or status. And after that, I will be in a new 
session, or have a new status.

- "creating" the branch is "setting (up) the branch"
- "re-setting" is doing doing this (creation) again.


>> Nope it does not go away.
>>
>> All this has done, is that it no longer is a "force" command.
>> So the last bit of warning has just gone.
>>
>> And it still needs to be documented inside the "git switch" doc, rather
>> than forwarding the user do yet another doc.
> 
> Yes, but as I said: the documentation writes itself.
> 
>    -n <branch>, --new <branch>
> 
>      Creates a new branch.
> 
>    --reset <branch>
> 
>      Resets the branch to <head>.

And that still leaves it to the user to connect the dots, and come to 
the conclusion that the old branch is no longer holding his valued commits.

We don't ask the user to go make this sort of "connecting the dots", 
when he uses force to override changes in his worktree.

Why?



>> So, I still ask:
>> - If "--force" to overwrite the work tree can clearly state that change
>> to files will be "thrown away".
>> - Then why can "force" re-using an existing branch name not do the same?
> 
> Because we would be forcing two things now. 

Which 2 things?

The worktree overwriting is *not* forced by -C

   git switch -C b1 b2
   git checkout -B b1 b2

both give an error if the worktree has changed files.

This is only about what happens to the branch.

I.e we force the branchname to point to our new branch.
And that means the branchname no longe points to the old branch, and the 
old branch therefore is removed.



> I'd rather not overload
> concepts.
> 
Sorry the concepts are there by whatever the implementation does.

Documenting them does not overload concepts. If they indeed already are 
overloaded, then documentation does not change that.

Btw, not sure what is overloaded here?





