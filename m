Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.2 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI,T_DKIMWL_WL_MED shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id C50B11F404
	for <e@80x24.org>; Tue, 28 Aug 2018 09:59:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727404AbeH1NuU (ORCPT <rfc822;e@80x24.org>);
        Tue, 28 Aug 2018 09:50:20 -0400
Received: from smtp-out-5.talktalk.net ([62.24.135.69]:44986 "EHLO
        smtp-out-5.talktalk.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727094AbeH1NuU (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 28 Aug 2018 09:50:20 -0400
Received: from [192.168.1.47] ([80.2.221.225])
        by smtp.talktalk.net with SMTP
        id uamQf6NncdJAeuamQfjmh6; Tue, 28 Aug 2018 10:59:24 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=talktalk.net;
        s=cmr1711; t=1535450364;
        bh=cqpHwiQeokiRIqpyfwzOOvcjtPrEahmcvREbX+G+O3s=;
        h=Reply-To:Subject:To:Cc:References:From:Date:In-Reply-To;
        b=TqNfo/olFK+v11rTJypPRNH6nOnj0QXOgSrve/TUj7Y51+3RV+eYoXdTrWPx+LTiO
         EHoAOzaSwvocb3IXldsZOfMP8IAz0APyZGd3LBx82XbejN1vFzumSSysF6N5gnpOD5
         CxE053skXd+xZPmwNZoYmr1WqmjxPc/NHQtg2m7s=
X-Originating-IP: [80.2.221.225]
X-Spam: 0
X-OAuthority: v=2.3 cv=V8BTL9vi c=1 sm=1 tr=0 a=g2gnxnp7LLDBudNdzH9G8Q==:117
 a=g2gnxnp7LLDBudNdzH9G8Q==:17 a=IkcTkHD0fZMA:10 a=uPZiAMpXAAAA:8
 a=MulqWcVwai4obZlxjmgA:9 a=QEXdDO2ut3YA:10
Reply-To: phillip.wood@dunelm.org.uk
Subject: Re: Would a config var for --force-with-lease be useful?
To:     Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        =?UTF-8?Q?Constantin_Wei=c3=9fer?= <i7c@posteo.de>
Cc:     Scott Johnson <jaywir3@gmail.com>, git@vger.kernel.org,
        =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>,
        Junio C Hamano <gitster@pobox.com>
References: <CAEFop40OJ5MRwM8zxE44yB0f2Fxw9YsUdM1e-H=Nn9e=sAGJ=w@mail.gmail.com>
 <153520405068.637.7595973048355361242@cwe>
 <nycvar.QRO.7.76.6.1808272306271.73@tvgsbejvaqbjf.bet>
From:   Phillip Wood <phillip.wood@talktalk.net>
Message-ID: <b5b1987e-d761-64c5-a58e-6863bb80d848@talktalk.net>
Date:   Tue, 28 Aug 2018 10:59:22 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <nycvar.QRO.7.76.6.1808272306271.73@tvgsbejvaqbjf.bet>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-HK
Content-Transfer-Encoding: 8bit
X-CMAE-Envelope: MS4wfJLFus0UOju00uMpiAKGdpVh/PoZAfFbVIKd5hC01mYNrpdrq7LFoG3cn0J43KeZYu9NzfFo+1LK9rJAEsOLa/vlUcq/t/r99Ia3QSiNpqoZ3DdEVsJQ
 g8X6IWyI9VmitEcJTuWSRLgOlrl45RkJEuAv0RtGOYER93S/LB6ToBJXa1KzbgSICFQEW8y3Blz7t3e1N84a0yiSKLWSC64oALLsxCoTOszjIDHLqUwBsQ6q
 u7G8kRGm4GVKb8CffT99Cp/ZVbSCeNy3xFUFV49uHQyhUklj8AiSIgTBJjyz+syjH2WOVjaUj3PAxm9tRZWwaA==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Johannes

On 27/08/18 22:21, Johannes Schindelin wrote:
> Hi,
> 
> On Sat, 25 Aug 2018, Constantin Weißer wrote:
> 
>> I think there are two aspects to using "force with lease".
> 
> There is a third, very, very important aspect.
> 
> When you use --force-with-lease (and I, for one, do, all the time), keep
> in mind that it assumes that you are at least aware of the latest fetched
> ref.
> 
> Let's add a little color to this, to make it less theoretical, and more
> relateable. Let's assume that you work on a branch, say,
> `make-this-thing-work`, and you have to work on this branch on two
> different machines, because it is a finicky thing you need to make work.
> Let's add even more color by saying that one of your machines is a windows
> machine, and the other one an old IRIX machine. We will call them
> `windoze` and `irixxx`.
> 
> The common use case for `--force-with-lease`, at least as far as I know,
> is that this branch is pushed from one of these setups first, say,
> `windoze`, and fetched on the other, then a fixup is necessary and you
> rebase the branch with `--autosquash` to make it compile on IRIX, and then
> you push with `--force-with-lease` a day later, just in case that you
> forgot to re-fetch something that you did on the `windoze` machine.

I have this workflow scripted to sync between my desktop and laptop and 
use it a lot.

> (Something like this happened to me recently, where one of my branches did
> not compile in a Linux VM with an older cURL, and I had to fix a
> Windows-targeting branch to keep it cross-platform)
> 
> The `--force-with-lease` option helps here, and quite a bit.
> 
> It would totally lose its usefulness, though, if you use a tool that
> auto-fetches those remote branches. For example, "synchronizing" in
> <name-your-favorite-git-gui-here>.
> 
> In that case, you did not see what was fetched, and you might have missed
> updates, and you will overwrite them, even if you tried to be careful by
> using `--for-ce-with-lease`.
> 
> I proposed, a couple of months ago, to either fix `--force-with-lease`, or
> to deprecate it in favor of a new option, with a new behavior. The new
> behavior would look at the *reflog*, much as the `--fork-point` option of
> `git rebase`: in addition to the regular `--force-with-lease` server-side
> checks, a client-side check *first* verifies that the remote-tracking
> branch is reachable at least from *one* of the items in the reflog of the
> branch we are about to push.

I think to be completely safe you only want to check the reflog items 
added since the last push, you can get that time by walking the reflog 
of the remote branch. (In my script I have to settle for using the hash 
of the last push rather than the time as there are no pretty format 
specifiers for the reflog dates, just commit and author dates). The 
script also implements a pull command that will rebase any local changes 
since the last push on top of the remote changes so long as the local 
changes are descendants of the last push (i.e rebase --onto $new_remote 
$last_push - I've never been sure if this is the same as using 
--fork-point or not).

> That is, it would ensure that even if we rebased locally, we did
> incorporate the tip commit of the remote-tracking branch, at some stage.
> 
> Granted, there are probably cases where you would fetch, look at the
> remote-tracking branch, and reject those changes without integrating those
> into the local branch. In that case, you would want to relax to the
> current behavior of `--force-with-lease`. But I would expect that to
> happen only rarely.
> 
> The safety by the proposed behavior would make it a lot easier to accept a
> config setting that makes this the default.

I agree having this as an option to push would be very useful for this 
sort of work flow.

Best Wishes

Phillip

> 
> I guess that is the reason why that config setting does not exist yet: we
> would want to have that new behavior in place first...
> 
> Ciao,
> Johannes
> 
>>
>> Firstly, you, a person aware of the option, using it. In this case I
>> think an alias is very fitting, because you get quickly used to just
>> typing `git pf` or so. Plus, you don't have the disadvantage you
>> described: if you’re working on a machine without your alias, you’ll
>> just notice immediately and type the full option.
>>
>> The other aspect is working in a team. The problem there is, that most
>> (at least in my surroundings) use plain --force and you have to make
>> them aware of --force-with-lease. But with an option or an alias, you
>> depend on them using force with lease instead of plain force, so again I
>> don't really see the advantage of such an option.
>>
>> And lastly, a question: say you are using your proposed option and it is
>> turned on. Now, git refuses to push, you clarify the situation and
>> actually mean to push --force now. How would you do this? 1) turn off 2)
>> push 3) turn option on again?
>>
>> Regards,
>> Constantin
>>
>> Quoting Scott Johnson (2018-08-24 18:39:27)
>>> Hello Everyone:
>>>
>>> I'm considering writing a patch that adds a configuration variable
>>> that will allow the user to default the command:
>>>
>>> git push --force
>>>
>>> to:
>>>
>>> git push --force-with-lease
>>>
>>> As discussed here:
>>>
>>> https://stackoverflow.com/questions/30542491/push-force-with-lease-by-default
>>>
>>> Now, I understand that there are downsides to having this enabled,
>>> namely that a user who has this enabled might forget that they have it
>>> enabled, and, as such, on a machine that _doesn't_ have it enabled (of
>>> which they are unfamiliar) might then run the more consequential
>>> command "git push --force", but my thinking is that adding this as a
>>> feature to the git codebase as an _optional_ (i.e. not enabled by
>>> default) configuration variable would then save some of us who use a
>>> "rebase-then-force-push for pull request" workflow some time and
>>> headaches.
>>>
>>> Of course, I don't want to submit a patch if this is a feature that
>>> isn't likely to be accepted, so I wanted to get some thoughts from the
>>> mailing list regarding this idea.
>>>
>>> Thank you,
>>>
>>> ~Scott Johnson
