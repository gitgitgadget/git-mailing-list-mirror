Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-7.3 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 26D591FE4E
	for <e@80x24.org>; Thu, 30 Jun 2016 21:05:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751854AbcF3VFC (ORCPT <rfc822;e@80x24.org>);
	Thu, 30 Jun 2016 17:05:02 -0400
Received: from mail-it0-f41.google.com ([209.85.214.41]:35546 "EHLO
	mail-it0-f41.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751840AbcF3VFB (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 30 Jun 2016 17:05:01 -0400
Received: by mail-it0-f41.google.com with SMTP id g127so2119346ith.0
        for <git@vger.kernel.org>; Thu, 30 Jun 2016 14:05:00 -0700 (PDT)
DKIM-Signature:	v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=nUzubDOr9GXh/d7DnpGbyQamn9cHhQSMbtlmapOb6UM=;
        b=DmkSqfna/IW6G6wE0lULCHr/GPZkC77Iq4NLPy+o/9o0lFYnRKWh+zyFZUDDPIEUT7
         FQb3gx5udT+jqdZMlOIw0/3N1ta3kLApSuIJfmxYu+PiBKTeaB6djhpGFh2tpcGL8n9o
         dQnsYVFG2QP/bx+KY6iDqhccWT4OG0cOrNMZYvZdRyLm20KG+PMI+o0oYjudbCwDQWRz
         iEakGTkSs8YpwuLORkBXHj0doSKoBe1m9KsUBQ8sPAC1SjnLvXMW1oNXT448qj/nzhj9
         MdlrMTVYvWeqWKGH8b2yErg8wyv/5Gou/GJg9yEWSBnvrzI9u4OrAj6ZqP9uHhTGhVYc
         1qVQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=nUzubDOr9GXh/d7DnpGbyQamn9cHhQSMbtlmapOb6UM=;
        b=eWE8S+ILaKOPRxYnCTmvZF3w7OtjW2RWYQLtDkl6pHzyhL+nWxXwnznpCaokC6mbHT
         mTJYno+WjTtxFREh7N6JZg/+WyomwsWWyzMyfgcMIa0KaEhnYICk7+SCGuqTghHXvUdL
         T7jCQ2/PBoFQxcZfBFjHuwSX8gJ4WEh0N5ZYTHgkSX1s/U0e/lJa08QKyimxD6vlaqPz
         HGZUe7yyRHvWvQXJL77hUS406oo6mDQh49GReN5mSXxJnhaJHUGDXp96KmbGo968eh0L
         g09b2htMd0HnvI8Dp6ojHs/Erdxt2YxiHwkuVBtlvWC8uxg6s+JpQ2wFifhKYs+cW4qH
         ZYFA==
X-Gm-Message-State: ALyK8tKCvpHS7Nr62L5/BKn5JdxzxNW8UtAru7RwZANaiZyWbibuSI9xVnFlEH3b5yDd47DQnoG6VmViH8gZLg==
X-Received: by 10.36.204.213 with SMTP id x204mr17659070itf.12.1467320699605;
 Thu, 30 Jun 2016 14:04:59 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.107.10.97 with HTTP; Thu, 30 Jun 2016 14:04:59 -0700 (PDT)
In-Reply-To: <CAGZ79kZRJ-O3825r-oXn4YG7Xp6+SXmttBxhzjADgRK5yNa=xQ@mail.gmail.com>
References: <loom.20160620T145755-931@post.gmane.org> <20160622153145.GB16644@paksenarrion.iveqy.com>
 <CAPV8XuZ4wTWBPkwB4grmx-oznnx2koiCFvVLZ-oG+E2v1ipPBw@mail.gmail.com> <CAGZ79kZRJ-O3825r-oXn4YG7Xp6+SXmttBxhzjADgRK5yNa=xQ@mail.gmail.com>
From:	Istvan Zakar <istvan.zakar@gmail.com>
Date:	Thu, 30 Jun 2016 23:04:59 +0200
Message-ID: <CAPV8XuYvt7v9EciZUsb5qgyWDjUFm2fxVfe16xivu-0GcMF8=g@mail.gmail.com>
Subject: Re: Problem with --shallow-submodules option
To:	Stefan Beller <sbeller@google.com>
Cc:	Fredrik Gustafsson <iveqy@iveqy.com>,
	"git@vger.kernel.org" <git@vger.kernel.org>
Content-Type: text/plain; charset=UTF-8
Sender:	git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List:	git@vger.kernel.org

Hi,

Thanks for the clarification, it makes sense now.

Thanks,
    Istvan


On 30 June 2016 at 22:57, Stefan Beller <sbeller@google.com> wrote:
> On Thu, Jun 30, 2016 at 6:27 AM, Istvan Zakar <istvan.zakar@gmail.com> wrote:
>> Hello,
>>
>> Thanks for your answers. I tested it after the changes were made on
>> the git server, and it seems to be working. But some other issue came
>> up.
>>
>> We have quite many submodules in our project so I did some comaprision:
>>
>> If I do a clone with these parameters:
>> --jobs 20 --recurse-submodules
>>
>> The clone lasts ~53 seconds, and the total size of the folder is around 2 GB.
>>
>> If I add the shallow-submodules option, the size of the folder will be
>> a bit below 1GB, so the size decreased as I expected, but the time of
>> the clone itself increased to 90 seconds. It seems the last step of
>> the command, checking out the submodules is executed one-by-one, and
>> not in parallel, so it seems at this step the jobs parameter does not
>> have effect.
>>
>> Is it intentional, or there is some option I missed?
>
> It was intentional at the time of submitting the patches.
> The checkout phase is a bit complicated as it combines the
> newly cloned submodules as well as the submodules to incrementally
> fetch into one bucket and treats them the same.
>
> And for submodules that were fetched incrementally you may run into problems
> when combining that with the local state (e.g. rebase or merge configured in
> `submodule.<name>.update` or passed on the command line), which requires
> human interaction (resolving the merge conflict), which we want to present one
> at a time to the user.
>
> The handling for the user is not quite clear, when to stop, see:
> 15ffb7cde48b73b3d5ce259443db7d2e0ba13750 (submodule update: continue
> when a checkout fails)
> 877449c136539cf8b9b4ed9cfe33a796b7b93f93 (git-submodule.sh: clarify
> the "should we die now" logic)
>
> So we want to die as soon as we see a merge conflict or other
> error that is likely to require some human interaction.
> To do that properly we need to have complicated logic or just update
> one submodule at a time.
>
> For initial checkouts we know that there will be no merge conflicts, i.e.
> it will be a "checkout -f" (with an implicit must_die_on_failure=no)
> So we could run all checkouts of submodules in parallel, too. We'd
> just need to write the patch for that.
>
> As the cloning is already done in parallel, we can hook into the initial
> checkout there easily. I'd build that on top of [1], creating a similar commit.
> In the successful case of `update_clone_task_finished` (the case with
> `!result`  -> return 0;) we would need to add the checkout command to
> the queue instead of just finishing.
>
> [1] https://github.com/gitster/git/commit/665b35eccd39fefd714cb5c332277a6b94fd9386
>
>
>>
>> I'm using git 2.9.0 on client side.
>>
>> Thanks,
>>    Istvan
>>
>> ps: if I update the submodules with --depth 1 parameter in parallel
>> using xargs it lasts about 18 seconds, so it's a workaround for this
>> issue, but it would be nice to do it with a single command.
>>
>>
>>
>>
>> On 22 June 2016 at 17:31, Fredrik Gustafsson <iveqy@iveqy.com> wrote:
>>> On Mon, Jun 20, 2016 at 01:06:39PM +0000, Istvan Zakar wrote:
>>>> I'm working on a relatively big project with many submodules. During
>>>> cloning for testing I tried to decrease the amount of data need to be
>>>> fetched from the server by using --shallow-submodules option in the clone
>>>> command. It seems to check out the tip of the remote repo, and if it's not
>>>> the commit registered in the superproject the submodule update fails
>>>> (obviously). Can I somehow tell to fetch that exact commit I need for my
>>>> superproject?
>>>
>>> Maybe. http://stackoverflow.com/questions/2144406/git-shallow-submodules
>>> gives a good overview of this problem.
>>>
>>> git fetches a branch and is shallow from that branch, which might be an
>>> other sha1 than the one the submodule points to, (as you say). This
>>> is/was one of the drawbacks with this method. However the since git 2.8,
>>> git will try to fetch the sha1 direct (and not the branch). So then it
>>> will work, if(!), the server supports direct access to sha1. This was
>>> previously not allowed due to security concerns (if I recall correctly).
>>>
>>> So the answer is, yes this will work if you've a recent version of git
>>> and support on the server side for doing this. Unfortunately I'm not
>>> sure which git version is needed on the server side for this to work.
>>>
>>> --
>>> Fredrik Gustafsson
>>>
>>> phone: +46 733-608274
>>> e-mail: iveqy@iveqy.com
>>> website: http://www.iveqy.com
>> --
>> To unsubscribe from this list: send the line "unsubscribe git" in
>> the body of a message to majordomo@vger.kernel.org
>> More majordomo info at  http://vger.kernel.org/majordomo-info.html
