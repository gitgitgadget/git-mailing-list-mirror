Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 33EE11F404
	for <e@80x24.org>; Thu,  8 Mar 2018 16:08:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S934378AbeCHQIS (ORCPT <rfc822;e@80x24.org>);
        Thu, 8 Mar 2018 11:08:18 -0500
Received: from mail-wm0-f53.google.com ([74.125.82.53]:40049 "EHLO
        mail-wm0-f53.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S933922AbeCHQIR (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 8 Mar 2018 11:08:17 -0500
Received: by mail-wm0-f53.google.com with SMTP id t6so250081wmt.5
        for <git@vger.kernel.org>; Thu, 08 Mar 2018 08:08:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=igPgJvzhr0NCrNJHwtt3/beQ5b8du1YOBJXgYJcInnA=;
        b=cVVOd1VskuB9HtGYkF7T5Q8KhkGt1tvTr7tFGe0ua7Xy4+xlS/UpfuiLuELmDF+t83
         jljsErXmyJJvgAQPtYpx4d39tFRxso6HylwHXfN5DAnx5bpTZMzdFsOfPhQqz/rscecL
         qNByiI4KvpIh4F8tD/b2p89YQoi63ajrL7Z5/Bu+IlsBsO2KVhiCs8CmgcQ6AiOX91hu
         IZSQ+qOSYTWtgdXA/7UFTspOM2qwS2vt5ZT1SuMNAmXw/7R5TudbehUqKeLj91kceuV5
         drGol0D6QOAzxSDgAKgoni0Nfqxtj9EsJarNMFX75gtiMecbKVsk6ya5vT2exZatNs7Z
         clUA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=igPgJvzhr0NCrNJHwtt3/beQ5b8du1YOBJXgYJcInnA=;
        b=iR7n0KqyLNCLB8pSepC8y+ZS7niPzDxC5poeWivJjG8YxDWJyPC532EFY0D4QcZlVf
         dcA3JY17+TFYJ7maIMstQRF7BxVx1GXRUSI/PyeTmmPVAADidNvgNdNMXN9igGFe7vsC
         dxsppfyyT2IT16JjfAggpfAgaHmv4/DVmEeuls/B/Sn5uSPfwcV7nnL4/1/3R5Ske0K7
         R4EpxtdvqbzeT2OkHZbdrfevNehuzgGUsP0rD8h1dqqrBaVMMqI2P1zOWhr3M+skyi3r
         K7Sy+LYECT8aCd9m6f5rjpwUSbR1/HAreAXP9RnwrQ7+rFb7K0wykIZy7gdCQp72Jlov
         CJCA==
X-Gm-Message-State: APf1xPCyQ0h+ECsoywiHJW4dQqmIljKPOoXl54zQQzsJbOKHKxbPN0et
        ocoZiWiG50bZ6N9Np+jeBQMCHmytPOSOQzMogHo=
X-Google-Smtp-Source: AG47ELusPfZVPnTzWQSggejRdeiOLA8QvZTC4eSuFrWWyTLuo1ek8UlRRV4N4cYa3L5IyLSQ5fvNkWfAM0TfXsJfhwI=
X-Received: by 10.80.232.69 with SMTP id k5mr32619376edn.133.1520525296133;
 Thu, 08 Mar 2018 08:08:16 -0800 (PST)
MIME-Version: 1.0
Received: by 10.80.139.133 with HTTP; Thu, 8 Mar 2018 08:07:55 -0800 (PST)
In-Reply-To: <c5a5c2cc-6a11-440f-5b9b-964ae1ca07dd@talktalk.net>
References: <87y3jtqdyg.fsf@javad.com> <CA+P7+xq8UUcLWomUi=PS_hTKfJd3dMAxMmhioDS1bixwcmKAqw@mail.gmail.com>
 <nycvar.QRO.7.76.6.1802271718090.56@ZVAVAG-6OXH6DA.rhebcr.pbec.zvpebfbsg.pbz>
 <4d7f3406-b206-cc22-87df-85700d6a03d9@gmail.com> <33da31e9-9101-475d-8901-4b6b3df2f29d@gmail.com>
 <940d959d-151d-68dd-0f13-320ebad0d75b@gmail.com> <87606hoflx.fsf@javad.com>
 <0ac3a3fd-4053-e32e-75ed-8829f22c2e1f@gmail.com> <87a7vss6ax.fsf@javad.com>
 <f1a960dc-cc5c-e7b0-10b6-39e5516655b3@gmail.com> <ed4d2b30-2dea-740b-6283-973c798f619d@philandanna.no-ip.org>
 <1298a701-a860-a675-83d7-72f29e14cd2b@talktalk.net> <CA+P7+xpgChuvh_vsPktBkOEhF=MjJh1n_3jD0-n4d67j9kYqzw@mail.gmail.com>
 <ee809701-a6d8-157d-09cd-cebbf2e949ec@gmail.com> <1580e48a-be44-38dd-79af-8a2a31c5712e@talktalk.net>
 <nycvar.QRO.7.76.6.1803061812090.20700@ZVAVAG-6OXH6DA.rhebcr.pbec.zvpebfbsg.pbz>
 <754e2735-1288-9a8d-c8bd-ab39cf733812@gmail.com> <nycvar.QRO.7.76.6.1803070810550.20700@ZVAVAG-6OXH6DA.rhebcr.pbec.zvpebfbsg.pbz>
 <c5a5c2cc-6a11-440f-5b9b-964ae1ca07dd@talktalk.net>
From:   Jacob Keller <jacob.keller@gmail.com>
Date:   Thu, 8 Mar 2018 08:07:55 -0800
Message-ID: <CA+P7+xoOVzxnmZN893ND4+55=OhtrE-gt7jRhtxoOUL=G_CrgA@mail.gmail.com>
Subject: Re: [RFC] Rebasing merges: a jorney to the ultimate solution(RoadClear)
To:     Phillip Wood <phillip.wood@dunelm.org.uk>
Cc:     Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Igor Djordjevic <igor.d.djordjevic@gmail.com>,
        Sergey Organov <sorganov@gmail.com>,
        Git Mailing List <git@vger.kernel.org>,
        Johannes Sixt <j6t@kdbg.org>,
        Junio C Hamano <gitster@pobox.com>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Mar 8, 2018 at 3:20 AM, Phillip Wood <phillip.wood@talktalk.net> wrote:
> On 07/03/18 07:26, Johannes Schindelin wrote:
>> Hi Buga,
>>
>> On Tue, 6 Mar 2018, Igor Djordjevic wrote:
>>
>>> On 06/03/2018 19:12, Johannes Schindelin wrote:
>>>>
>>>>>> And I guess being consistent is pretty important, too - if you add new
>>>>>> content during merge rebase, it should always show up in the merge,
>>>>>> period.
>>>>>
>>>>> Yes, that should make it easy for the user to know what to expect from
>>>>> rebase.
>>>>
>>>> [...]
>>>>
>>>> It will be slightly inconsistent. But in a defendable way, I think.
>>>
>>> I like where this discussion is heading, and here`s what I thought
>>> about it :)
>>>
>>> [...]
>>>
>>> Here`s a twist - not letting `merge` trying to be too smart by
>>> figuring out whether passed arguments correspond to rewritten
>>> versions of the original merge parents (which would be too
>>> restrictive, too, I`m afraid), but just be explicit about it, instead!
>>
>> That's the missing piece, I think.
>>
>>> So, it could be something like:
>>>
>>>      merge -C deadbee 123abc:cafecafe 234bcd:bedbedbed
>>
>> I like where this is heading, too, but I do not think that we can do this
>> on a per-MERGE_HEAD basis. The vast majority of merge commits, in
>> practice, have two parents. So the `merge` command would actually only
>> have one revision to merge (because HEAD is the implicit first parent). So
>> that is easy.
>>
>> But as soon as you go octopus, you can either perform an octopus merge, or
>> rebase the original merge commit. You cannot really mix and match here.
>>
>> Unless we reimplement the octopus merge (which works quite a bit
>> differently from the "rebase merge commit" strategy, even if it is
>> incremental, too), which has its own challenges: if there are merge
>> conflicts before merging the last MERGE_HEAD, the octopus merge will exit
>> with status 2, telling you "Should not be doing an octopus.". While we
>> will want to keep merge conflict markers and continue with the "rebase the
>> original merge commit" strategy.
>>
>> And it would slam the door shut for adding support for *other* merge
>> strategies to perform a more-than-two-parents merge.
>>
>> Also, I do not think that it makes a whole lot of sense in practice to let
>> users edit what will be used for "original parent". If the user wants to
>> do complicated stuff, they can already do that, via `exec`. The `merge`
>> command really should be about facilitating common workflows, guiding the
>> user to what is sane.
>>
>> Currently my favorite idea is to introduce a new flag: -R (for "rebase the
>> original merge commit"). It would look like this:
>>
>>       merge -R -C <original-merge> <merge-head> # <oneline>
>>
>> This flag would of course trigger the consistency check (does the number
>> of parents of the original merge commit agree with the parameter list? Was
>> an original merge commit specified to begin with?), and it would not fall
>> back to the recursive merge, but error out if that check failed.
>>
>> Side note: I wonder whether we really need to perform the additional check
>> that ensures that the <merge-head> refers to the rewritten version of the
>> original merge commit's parent.
>>
>> Second side note: if we can fast-forward, currently we prefer that, and I
>> think we should keep that behavior with -R, too.
>
> I think that would be a good idea to avoid unpleasant surprises.
>
>> If the user wants to force a new merge, they simply remove that -R flag.
>>
>> What do you think?
>
> I did wonder about using 'pick <original-merge>' for rebasing merges and
> keeping 'merge ...' for recreating them but I'm not sure if that is a
> good idea. It has the advantage that the user cannot specify the wrong
> parents for the merge to be rebased as 'git rebase' would work out if
> the parents have been rebased, but maybe it's a bit magical to use pick
> for merge commits. Also there isn't such a simple way for the user to go
> from 'rabase this merge' to 'recreate this merge' as they'd have to
> write the whole merge line themselves (though I guess something like
> emacs' git-rebase.el would be able to help with that)
>
> Best Wishes
>
> Phillip
>

Since the ultimate commit hashes of newly rebased commits would be
unknown at the time of writing the todo file, I'm not sure how this
would work to specify the parents?

>
>> Ciao,
>> Dscho
>>
>
