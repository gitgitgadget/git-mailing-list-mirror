Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id B8AB41F404
	for <e@80x24.org>; Tue,  6 Mar 2018 19:44:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933042AbeCFToA (ORCPT <rfc822;e@80x24.org>);
        Tue, 6 Mar 2018 14:44:00 -0500
Received: from mail-wr0-f195.google.com ([209.85.128.195]:34334 "EHLO
        mail-wr0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S933554AbeCFTnW (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 6 Mar 2018 14:43:22 -0500
Received: by mail-wr0-f195.google.com with SMTP id o8so10660770wra.1
        for <git@vger.kernel.org>; Tue, 06 Mar 2018 11:43:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=NLFA1Y2+KdbI2QhxbqmwdSb+5xIRq/JY2Aes4i2TxnE=;
        b=N9M84ncPVYhmFocVZgebVxcjX+L47YsegNokCU8vBgmSLZHEcVdaDPNd0hD1+5Q5VI
         gULTSYTfSPa8HO9GyejPRT1BS7xKSdnj5yM/l1AYA0CQeVr7g+T3LpRbWVMQUKJGIvEV
         eyq9IlzPzNvbJx6ZVDfAu/ONWor56rOj0khtKXzGhBjEiiuv98JdGht21yQ6ZjpPeDIO
         3SZkwGUI1yVDNSGvBXWO7gbvVgr9gl8Z0mQIaLjNbT2pq6znjy1akB+8GZfmXbhtF2M4
         W0kvxVi+xiCU52QO3Q2tm4CgNir5EcF6Gh0oZMEnJB/+uUO1E7m3YIOsYNCiwLOq6FNZ
         iVRA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=NLFA1Y2+KdbI2QhxbqmwdSb+5xIRq/JY2Aes4i2TxnE=;
        b=WcKPS1fh67H+Lf/SqXuB4Y6idHyPFu2YKYhmkR2AR4eVpDVH2DMKF6vk/VUbxyobH9
         09qx+mZyOxujksTXuPCSP+bvGK1bgsi6KCDC4BuguoXykpR42mwoV27nAQ/jXfXhwjkd
         5lAWH00dg+M4N62Vu+oKJf8ibSxGxtPUJ2BcHgWfmTXUd7GjgxYuBbdfOgxu7wARzeKI
         bpCdlyvNLLOEbYpSWbq5/iW/BsOxvEzQAjRdJsIV6mbub+fWiF/vbaY3GsuuqKEXx87e
         FTnQ6aci9f+4h33DLEOM5a/pQ16L9CFcw/foAFsdb3WmPuMCM6MrxlTuXG2YNrRJNd3k
         FrGw==
X-Gm-Message-State: APf1xPD0F6WfFU7vXB9P8OO6XoruZ5s7tpPuyqEXyFeZsbmbMHGFNvVQ
        zLXgTpR+UpMKUUNYoS9OFhE=
X-Google-Smtp-Source: AG47ELvfrherDQHyhrHl571ObxLYYa+8RGzEIHseL4rzwOsGmZVeAn9OvHOSHGQxjRs0PQLCeiJ68g==
X-Received: by 10.223.172.167 with SMTP id o36mr18120801wrc.34.1520365400846;
        Tue, 06 Mar 2018 11:43:20 -0800 (PST)
Received: from [192.168.5.102] (cable-24-135-61-30.dynamic.sbb.rs. [24.135.61.30])
        by smtp.gmail.com with ESMTPSA id k11sm19788911wre.81.2018.03.06.11.43.18
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 06 Mar 2018 11:43:19 -0800 (PST)
Subject: Re: [RFC] Rebasing merges: a jorney to the ultimate
 solution(RoadClear)
To:     Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Phillip Wood <phillip.wood@dunelm.org.uk>
Cc:     Jacob Keller <jacob.keller@gmail.com>,
        Sergey Organov <sorganov@gmail.com>,
        Git Mailing List <git@vger.kernel.org>,
        Johannes Sixt <j6t@kdbg.org>,
        Junio C Hamano <gitster@pobox.com>
References: <87y3jtqdyg.fsf@javad.com>
 <bbe64321-4d3a-d3fe-8bb9-58b600fabf35@gmail.com>
 <nycvar.QRO.7.76.6.1802270051470.56@ZVAVAG-6OXH6DA.rhebcr.pbec.zvpebfbsg.pbz>
 <CA+P7+xq8UUcLWomUi=PS_hTKfJd3dMAxMmhioDS1bixwcmKAqw@mail.gmail.com>
 <nycvar.QRO.7.76.6.1802271718090.56@ZVAVAG-6OXH6DA.rhebcr.pbec.zvpebfbsg.pbz>
 <4d7f3406-b206-cc22-87df-85700d6a03d9@gmail.com>
 <33da31e9-9101-475d-8901-4b6b3df2f29d@gmail.com>
 <940d959d-151d-68dd-0f13-320ebad0d75b@gmail.com> <87606hoflx.fsf@javad.com>
 <0ac3a3fd-4053-e32e-75ed-8829f22c2e1f@gmail.com> <87a7vss6ax.fsf@javad.com>
 <f1a960dc-cc5c-e7b0-10b6-39e5516655b3@gmail.com>
 <ed4d2b30-2dea-740b-6283-973c798f619d@philandanna.no-ip.org>
 <1298a701-a860-a675-83d7-72f29e14cd2b@talktalk.net>
 <CA+P7+xpgChuvh_vsPktBkOEhF=MjJh1n_3jD0-n4d67j9kYqzw@mail.gmail.com>
 <ee809701-a6d8-157d-09cd-cebbf2e949ec@gmail.com>
 <1580e48a-be44-38dd-79af-8a2a31c5712e@talktalk.net>
 <nycvar.QRO.7.76.6.1803061812090.20700@ZVAVAG-6OXH6DA.rhebcr.pbec.zvpebfbsg.pbz>
From:   Igor Djordjevic <igor.d.djordjevic@gmail.com>
Message-ID: <754e2735-1288-9a8d-c8bd-ab39cf733812@gmail.com>
Date:   Tue, 6 Mar 2018 20:43:09 +0100
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.6.0
MIME-Version: 1.0
In-Reply-To: <nycvar.QRO.7.76.6.1803061812090.20700@ZVAVAG-6OXH6DA.rhebcr.pbec.zvpebfbsg.pbz>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 06/03/2018 19:12, Johannes Schindelin wrote:
> 
> > > And I guess being consistent is pretty important, too - if you add new
> > > content during merge rebase, it should always show up in the merge,
> > > period. 
> >
> > Yes, that should make it easy for the user to know what to expect from
> > rebase.
> 
> Indeed. We have seen time and time again that consistent behavior is the
> only thing that lets us adhere to the Law of Least Surprise.
> 
> And here lies the rub: do we really want to let `merge -C <commit>` behave
> completely differently than `merge`? Granted, in one case we provide a
> template merge commit, in the other case, we do not. And the idea is
> already to behave differently, although that difference only extends to
> the commit message so far.
> 
> But given the benefit (i.e. that the strategy to transform the original
> merge commit into the new merge commit), I am willing to run that risk,
> especially since I foresee only few users wanting to create new merge
> commits from scratch using the `merge` todo command.
> 
> Of course, even then we need to be careful: the user might have
> *changed* or *moved* the original `merge` command. For example, if the
> merge command read:
> 
> 	merge -C deadbee cafecafe bedbedbed
> 
> and the user switched the order of the merged branches into
> 
> 	merge -C deadbee bedbedbed cafecafe
> 
> we would have to detect the changed order of the arguments so that we
> could still find the original branch tips.
> 
> But the user might also have changed the branch(es) to merge completely,
> in which case we might not even be able to find original branch tips.
> 
> My preferred solution would be to let the `merge` command figure out
> whether the passed arguments correspond to the rewritten versions of the
> original merge parents. And only in that case would we use the fancy
> strategy, in all other cases we would fall back to performing a regular
> recursive (or octopus) merge.
> 
> How does that sound?
> 
> It will be slightly inconsistent. But in a defendable way, I think.

I like where this discussion is heading, and here`s what I thought 
about it :)

First, starting from non-interactive rebase, I guess we may now agree 
that _rebasing_ merges is an actually expected behavior, not recreating 
them (thus keeping manual conflict resolutions and amendments, not 
losing them).

Now, interactive rebase is a totally different story, we already said 
user can change pretty much about everything, making merge 
_recreation_ to be a more sane choice, but let`s leave this other 
extreme for a brief moment.

In the least interesting situation, though, user could just review 
and close todo list, without changing anything - and in that case it 
would be important, consistency wise, to behave exactly like in case 
of non-interactive rebase, meaning still rebasing merges, not 
recreating them.

Ok, so that still aligns with what`s written so far - we need to be 
able to rebase merges interactively, too (not just recreate them), to 
stay consistent in less complex interactive rebases.

But, what if user really wants to _recreate_ merges, for whatever 
reason? Come on, this is interactive rebase we`re talking about, why 
being restrictive? :)

Here`s a twist - not letting `merge` trying to be too smart by 
figuring out whether passed arguments correspond to rewritten 
versions of the original merge parents (which would be too 
restrictive, too, I`m afraid), but just be explicit about it, instead!

So, it could be something like:

	merge -C deadbee 123abc:cafecafe 234bcd:bedbedbed


The format is still something to think about, but the point is rather 
simple - explicitly map old and new merge parents, showing this 
inside todo list by default.

This makes it much easier for later processing (and correct, no need 
to guess which one goes where), but also gives more power to the 
user, being able to decide which merge parents get "rebased", and 
which ones should go into the merge just like "new".

So if a user gets an interactive todo list like that and just closes 
it, we still have exact situation like non-interactive rebase (and no 
guessing on implementation side).

But, user might still decide to introduce new merge parents into the 
mix, even, where we could then just be merging those (as there is no 
old merge parent to actually rebase from):

	merge -C deadbee 123abc:cafecafe 234bcd:bedbedbed new-branch
	
Here, "new-branch" is something new, introduced inside interactive 
rebase, and it will be just merged into the other two (which are 
still being rebased).

Also, another example - if original merge parent "123abc" was merged 
from the other side using `-s ours` strategy, that means all the 
content this branch originally had will still be missing from the 
rebased merge (expect for what`s been cherry-picked elsewhere).

But, I would argue it`s quite legit to want to revise that decision, 
and let that content in this time. To make that happen, one would 
just remove "123abc:" from the todo list:

	merge -C deadbee cafecafe 234bcd:bedbedbed new-branch

..., meaning that only "bedbedbed" should be rebased according 
original merge parent "234bcd", where both "cafecafe" and "new-branch" 
should be just merged in, no previous context existing (no rebase).

In the end, user might even decide to swap old/new parent mapping, 
and that should be possible, too (might be pretty strange, though, 
causing conflicts, but we shouldn`t judge).

Or, one could map old merge parent to some totally new merge parent, 
like "new-branch" in that example above, all this being a fair game.

As one might suspect, to recreate merge from scratch instead, just 
drop all the old merge parents mappings:

	merge -C deadbee cafecafe bedbedbed


There, in my opinion, something like this provides the most 
consistent user experience (we always behave the same), while adding 
additional possibilities on top (getting to actually decide which 
merge parents get rebased, and which just merged), plus avoids all 
guess work (old and new merge parents, to be used for merge rebasing, 
are explicitly mapped).

What do you think? (unrelated to the parent mapping format itself, 
which could/should probably be made better, if possible)

Regards, Buga
