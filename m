Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9D17CC07E95
	for <git@archiver.kernel.org>; Sun, 11 Jul 2021 00:39:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6F70661241
	for <git@archiver.kernel.org>; Sun, 11 Jul 2021 00:39:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231330AbhGKAm2 (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 10 Jul 2021 20:42:28 -0400
Received: from smtprelay04.ispgateway.de ([80.67.31.31]:37630 "EHLO
        smtprelay04.ispgateway.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230168AbhGKAm2 (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 10 Jul 2021 20:42:28 -0400
Received: from [84.163.65.41] (helo=[192.168.2.202])
        by smtprelay04.ispgateway.de with esmtpsa  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256
        (Exim 4.94.2)
        (envelope-from <git@mfriebe.de>)
        id 1m2NUI-0000YK-R8; Sun, 11 Jul 2021 02:38:26 +0200
Subject: Re: Naming the --forec option [[Re: PATCH: improve git switch
 documentation]]
To:     Felipe Contreras <felipe.contreras@gmail.com>,
        Sergey Organov <sorganov@gmail.com>
Cc:     Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
References: <c593a699-eaf2-c7ab-b522-bfd224fce829@mfriebe.de>
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
 <6f43b36b-abe1-41f2-6138-e820c974b1bd@mfriebe.de>
 <60ea07e3495e8_7ef2081d@natae.notmuch>
 <43b8d0bb-67f3-11dd-ec31-e102ce8e3b31@mfriebe.de>
 <60ea2ad64878_2a692084e@natae.notmuch>
From:   Martin <git@mfriebe.de>
Message-ID: <e9c2b9cd-edfb-cbed-9638-382a6b0da59b@mfriebe.de>
Date:   Sun, 11 Jul 2021 02:39:38 +0200
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
MIME-Version: 1.0
In-Reply-To: <60ea2ad64878_2a692084e@natae.notmuch>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-GB
Content-Transfer-Encoding: 7bit
X-Df-Sender: bWVAbWZyaWViZS5kZQ==
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 11/07/2021 01:18, Felipe Contreras wrote:

> That's OK, and in fact I can see how '--reset --new' is clunky, I'm just
> saying it is a possibility. But the main point is that something like
> `git switch --reset` is missing, although `git switch --move` would
> probably do the trick.

How would "git switch --reset" be different from "git switch -N" ?

"--move" is problematic.
- it reminds me of moving the commits. I.e. rebase.
- it actually stands for "rename" (in git branch -m).

The apparent idea:  "move the branch under a new name"
But the branch (base..head) itself stays where it is.
"rename" would be so much more intuitive to me.



>> At least I can say, if I use "-N", I want a *new* branch. I don't care
>> about any old branch under that name.
> 
> Right, I would as well, but in fact I would expect the same from -n
> (although I can see how a newbie might not).
> 
That's why we have to keep in mind that -N is really --force-new.

     A non-force option should not lead to data loss.

Or if something can be lost, then "force" needs to be used.
If the branch-name already points to a branch then of that branch, you 
stand to loose:
- the branch boundaries (base..head)
- in some cases, (some of) the commits hold by it.

So by convention a simple "-n" is protecting me from that.
IMHO that should be expected.


>> Also "--reset" does not have the same alerting properties to me, as
>> "force" or "discard" have.
>> This may be my English, but to me "reset" does not have the same
>> alerting property.
> 
> OK, maybe it's a language issue. I'm not a native English speaker, my
> mother tongue is Spanish, but I'm pretty sure my understanding of
> "reset" is what most people understand: set again.

I am German. And yes "set again" (sometimes "restart", but that does not 
matter here)

If a branch is set, as base and head. Then "reset" means to set those 
two again.

      "set again" => They will still be there.
      (changed indeed, but there)

The commits hold by that branch, are not "set again".
They may become unreachable.

The word "reset" gives no indication on knock on effects.
However, I prefer if those effects are made clear.

 > meriam webster
Quite some of the examples are "put back into working order"
(broken leg / circuit breaker => reset does not loose anything)

Others are restart (at zero) "reset an odometer".
To me personally the emphasis is the "start again", the loss of the 
previous value is a side effect.

Maybe others will take see "loss" part as more prominent.
The question then is, how many might not be that wary of the potential loss?


> 
> So *if* --force was not an alias for --discard-changes, then this would
> make sense:
> 
>    git switch --new --force topic
> 
> It would _force_ the creation of a _new_ branch called "topic".
> 
> Is this close to what you are thinking?

No, again no. I said "I want them to be separate force flags"

As long as we have the unspecific "--force" this must be limited to 
event *not* triggered by added options.

That is
    git switch foo

is not forceful, therefore not allowed to destroy data.
Hence it can not overwrite local changes.
So --force applies to that.

Now if you were currently detached, and made new commits while detached, 
then
    git switch foo
would loose those commits.
Hypothetical, that could require force.

And like the first example it is part of the default behaviour. No 
options are given.

But then using the same --force to force something else would be bad.
So then we need --force-discard-local-changed and 
--force-unlink-detached-commit


git -n newbranch commit
is not default behaviour. It is triggered by the -n option.
If this endangers any data (other than what is covered by default 
cases), then this always needs its own force.
And it has --force-new


It is possible, but I dislike it very much to define that
--force affects the next option that follows.

So that, thin is -N
  git switch --force --new

But those are not
  git switch --new --force
  git switch --force - --new   // the single dash separates the force

I do not like that idea...
