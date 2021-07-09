Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BF243C07E99
	for <git@archiver.kernel.org>; Fri,  9 Jul 2021 16:51:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 938BA613AF
	for <git@archiver.kernel.org>; Fri,  9 Jul 2021 16:51:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229606AbhGIQyB (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 9 Jul 2021 12:54:01 -0400
Received: from smtprelay06.ispgateway.de ([80.67.31.104]:13780 "EHLO
        smtprelay06.ispgateway.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229459AbhGIQyB (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 9 Jul 2021 12:54:01 -0400
Received: from [84.163.73.96] (helo=[192.168.2.202])
        by smtprelay06.ispgateway.de with esmtpsa  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256
        (Exim 4.94.2)
        (envelope-from <git@mfriebe.de>)
        id 1m1tho-0007Et-LU; Fri, 09 Jul 2021 18:50:24 +0200
Subject: Re: PATCH: improve git switch documentation
To:     Felipe Contreras <felipe.contreras@gmail.com>,
        Sergey Organov <sorganov@gmail.com>
Cc:     Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
References: <c593a699-eaf2-c7ab-b522-bfd224fce829@mfriebe.de>
 <xmqqk0mcy6g2.fsf@gitster.g>
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
From:   Martin <git@mfriebe.de>
Message-ID: <dbfa96f0-558e-ccaf-6e34-6d95c43848b5@mfriebe.de>
Date:   Fri, 9 Jul 2021 18:51:12 +0200
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
MIME-Version: 1.0
In-Reply-To: <60e874e1c6845_215320861@natae.notmuch>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-GB
Content-Transfer-Encoding: 8bit
X-Df-Sender: bWVAbWZyaWViZS5kZQ==
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 09/07/2021 18:10, Felipe Contreras wrote:
> Martin wrote:
>> As for "git switch -C"
>> This should IMHO change to (the 2nd arg, actually depends on the point
>> "1" above)
>>      git switch (-c|-C) <branch-name> [<base-commit>]
>>
>> I suggest to not call it "new-branch-name" because, it might be an
>> existing name.
> 
> I think the name is all wrong. As Ævar pointed out --new (-n) is much
> better. Also it doesn't make much sense to use "create" or "new" for
> something that already exists.

The n versus c issue is IMHO separate. Maybe tiny overlaps.

I see it mostly in the light of -c should be for "copy".

On "git checkout" it is "-b" for branch. That works, if you perceive 
"branch" as a verb. "The action of branching creates a new branch".

If needs must, that would work as "git switch -b" to.

Actually, "new" or "create" would make sense in "git branch". But in git 
switch, they actually raise the question "create what?" / "new what?".


> 
> I think you saw a correct issue: `git switch -C` might be used
> incorrectly, but changing to the documentation would have limited value
> (and only for the ones that read it).
> 
> I think if the branch already exists, the user has to be explicit to
> what he wants to do and use `git switch --reset <branch> <commit>`

Well, that is the question as what the action is perceived.
I think the example is wrong, rather than the command.

-c / -C /-n / -N always *c*reate an *n*ew branch. (create and new really 
are the same thing here)

But if the branch name Foo, is already used?
Well, it will still be a *new* branch being *created*.
To do that it has to remove the name from the old branch. (effectively 
removing the old branch).


>> 3)
>>
>>      newbbranch  versus new-branch  versus  new_branch
>>
>> That is something that just needs to be decided.
>> "new_branch" is in git checkout.
> 
> I'd rather have <branch>, but as I already said, the more ground you try
> to cover the more impossible it will be to actually land the changes.

Well ok, if you shorten it to one word that solves it too.
But for anything that for some reason needs two words, IMHO there should 
be one style. "one word", "-" or "_".
Currently different styles are mixed.


>>
>> Look at
>>     git checkout --force
>>> --force
>>>      When switching branches, proceed even if the index or the working tree differs from HEAD. This is used to throw away local changes.
>>
> 
> All these issues go away if we have:
> 
>    git switch --reset <branch> <commit>
> 
> And instead of -C, we have:
> 
>    git switch --new --reset <branch> <commit>
> 
> This creates a new branch if it doesn't exist, or if it exists resets
> it.

Nope it does not go away.

All this has done, is that it no longer is a "force" command.
So the last bit of warning has just gone.

And it still needs to be documented inside the "git switch" doc, rather 
than forwarding the user do yet another doc.

Also making the user read the "git reset" doc does not help, unless we 
point out that this is a --hard reset, rather than "modifying the index".

I would on that account argue that "git reset --hard/mixed/soft" should 
be "force" commands.

And the "git reset" documentation, as well as "git branch -f" / git 
checkout -B", also miss the information why they are "force".
It is true, this information can be derived, if one
- knows the concepts (which one should do)
- and actually connects the dots (humans do have a tendency to overlook 
things, especially if they are only indirectly referred to)

So, I still ask:
- If "--force" to overwrite the work tree can clearly state that change 
to files will be "thrown away".
- Then why can "force" re-using an existing branch name not do the same?

And that is the same, never mind if we call it -C, -B or --reset.





