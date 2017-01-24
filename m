Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.5 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RCVD_IN_SORBS_SPAM,RP_MATCHES_RCVD shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id D58201F437
	for <e@80x24.org>; Tue, 24 Jan 2017 18:49:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1750844AbdAXStj (ORCPT <rfc822;e@80x24.org>);
        Tue, 24 Jan 2017 13:49:39 -0500
Received: from mail-io0-f177.google.com ([209.85.223.177]:36072 "EHLO
        mail-io0-f177.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750806AbdAXSti (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 24 Jan 2017 13:49:38 -0500
Received: by mail-io0-f177.google.com with SMTP id j13so142515306iod.3
        for <git@vger.kernel.org>; Tue, 24 Jan 2017 10:49:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=nNJrSLZjGaZpo9GN3s4Mn7UnCdlVOjEvfcobwAOZ7QU=;
        b=P+Y/OYejKcggzVu4r3vAGsg/2z1VlSpCrSO/vKesjjJND1cJlYwVoU7NrRPZAi1cmk
         H7IZKYI/LNDnyBDpym3tJylSQJTmg/ytgeg5KPtaZLPoFOufnSSQkO7TPwlbDxBWiDgY
         PRCU/1rLmtakC5PRZOQ/ns/khSQb8i6J4m25iHlzhfDrrNlrz2iYQidVGruI9KCcLTBE
         wqE7dwG1ZwgmrDJbNFkL9QxNbLj+1PDCnlHQk+P8pDYpAwV1/t/nDUFEkzbWpcPDywOW
         9tA2YbxuXmIVQthG3jkcQbpHTiNyQ1bS/ejjuNVrkZD1xJ1pm2WUn5ZvLzv5i9z4guPd
         FK5w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=nNJrSLZjGaZpo9GN3s4Mn7UnCdlVOjEvfcobwAOZ7QU=;
        b=YNLGaZOVKros7kbh7aEUKmHUTm89napDV203NxBh6WE9UDNYqLkutpBjqx14exg4ub
         5nB7ul33obqUfi0mgyI/mB+dFm4keZ898Gijwb6Vo0yKDVrIMAxN3WMZ80hUDuybK7Em
         PvLT3WkNm0vnKDbxg76WQLoOSjTlhId7y64oAaF9T7mzDEsG5J5p39IGv9wCABLhDerQ
         a3wuRuhYVzwHX/LlmVud/fv/D10y8ZrinqoSVt0ulZS59Q6H8Ms7VLjDjwrDWEdzWgE3
         xciAexomHJfmQGcy/AztAdbQLQZm9sGv59G8kVqWj4Yb9nWWle7sUJa6RSJi98cbeb7I
         rQew==
X-Gm-Message-State: AIkVDXLARzG/AnQqt+tXkQ+cAWUz2+gBmoL0blnw7ENzxmCxKa1IeDOyAiDj/OX9+t8y3xn10zuDtxC5gqsIBgya
X-Received: by 10.107.3.160 with SMTP id e32mr30725712ioi.52.1485283777326;
 Tue, 24 Jan 2017 10:49:37 -0800 (PST)
MIME-Version: 1.0
Received: by 10.79.39.19 with HTTP; Tue, 24 Jan 2017 10:49:36 -0800 (PST)
In-Reply-To: <04fe8035-dbf0-83d2-c465-f746b99ce609@gmail.com>
References: <CAGZ79kZRV7x9B6SHRcHjJweHrjURxWKmN-=Wz_aNw2TPwYh_xw@mail.gmail.com>
 <ebf6c90e-044f-5538-2325-601d002a81fe@gmail.com> <CAGZ79kaf0BhbnJGhkjT_Ys44y4c4AaxV8U_ydWp4bbFMkGRcsQ@mail.gmail.com>
 <e6c5567a-2032-c598-97c8-08518f86b611@gmail.com> <CAGZ79kaS7zt3DKrRuqzzODc1HHEP-xd-8HBC0JA-HvmqAJOZfw@mail.gmail.com>
 <04fe8035-dbf0-83d2-c465-f746b99ce609@gmail.com>
From:   Stefan Beller <sbeller@google.com>
Date:   Tue, 24 Jan 2017 10:49:36 -0800
Message-ID: <CAGZ79kZzekMc=pUN3Q2+zmaSNo-BLJ6TxaQPN8ik1B2+ACy9dw@mail.gmail.com>
Subject: Re: submodule network operations [WAS: Re: [RFC/PATCH 0/4] working
 tree operations: support superprefix]
To:     "Brian J. Davis" <bitminer@gmail.com>
Cc:     Brandon Williams <bmwill@google.com>,
        "git@vger.kernel.org" <git@vger.kernel.org>,
        David Turner <novalis@novalis.org>
Content-Type: text/plain; charset=UTF-8
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Sat, Jan 21, 2017 at 7:53 AM, Brian J. Davis <bitminer@gmail.com> wrote:
>
> On 1/19/2017 7:22 PM, Stefan Beller wrote:
>>>>
>>>> Between the init and the update step you can modify the URLs.
>>>> These commands are just a repetition from the first email, but the
>>>> git commands can be viewed as moving from one state to another
>>>> for submodules; submodules itself can be seen as a state machine
>>>> according to that proposed documentation. Maybe such a state machine
>>>> makes it easier to understand for some people.
>>>
>>>
>>> "Between the init and the update step you can modify the URLs."  Yes I
>>> can
>>> and have to... wish it was not this way.
>>
>> So how would yo u rather want to do it?
>> look at the .gitmodules file beforehand and then run a "submodule update"
>> ?
>> Or a thing like
>>
>>      git -c url.https://internal.insteadOf git://github.com/ \
>>          -c submodule.record-rewritten-urls submodule update
>>
>> (no need for init there as theoretically there is not
>> need for such an intermediate step)
>>
> "Yes please and thank you" ... both.
>
> My thought was to simply allow addition to .gitmodules.  If I understand
> correctly you are proposing, to override these at the command line and
> possibly rewrite them on submodule update, but maybe not save or add to
> .gitmodules. I would then propose both.
> 1) allow user to add to .gitmodules for those who do not care that
> "outsiders" know the internal dev server
> and
> 2) allow to rewrite while not saving to .gitmodules on fresh clone and
> submodule update for thoes that do not want ousiders to known internal dev
> server.
> and possibly:
> 3) allow at command line to add remote to .gitmodules on submodule commands
> (note add optoin in -c <name> = <value> pair)
>
> .gitmodules before:
>
> [submodule "subprojects/wrangler"]
>         path = subprojects/wrangler
>         url = git://github.com/
>
> Then your adapted command:
>
> git -c url.https://internal.insteadOf git://github.com/ \
>         -c submodule.record-rewritten-urls=add,internal --add submodule
> update
>
> would produce
>
> [submodule "subprojects/projname"]
>         path = subprojects/projname
>         remote.origin.url = git://github.com/
>         remote.internal.url =https://internal.insteadOf
>
> Or similar support.

I think this was avoided until now as it would rewrite/add history.
So what if you want ot "just mirror" a large project with a lot
of submodules? You would want to do that without touching
the history, hence we'd need to do such a configuration in a separate
place. IIRC there was a proposal to have a ref e.g.
"refs/submodule/config", that can overwrite/extend the .gitmodules
file with your own configuration. It is a ref, such that mirroring would
work, but not part of the main history, such that yoiu can still change it.

I think to get it right we need to enable a workflow that allows easy
"multi-step" mirroring, e.g. A (source of truth) can be mirrored to B,
who can overlay the .gitmodules to point to server-B, which then can
be mirrored by C, who can have its own serverC.

When C forgot to configure all the submodules, it should fall back to
serverB as that was closest, and if that is unconfigured it should
fallback to A IMO.



>
>>>> [remote "origin"]
>>>>     url = https://github.com/..
>>>> [remote "inhouse"]
>>>>     url = https://inhouse.corp/..
>>>>
>>>> But where do we clone it from?
>>>> (Or do we just do a "git init" on that submodule and fetch
>>>> from both remotes? in which order?)
>>>
>>> origin by default and inhouse if specified. There is already a implied
>>> default (origin). The idea was not to do both but rather what is
>>> specified.
>>> Origin and inhouse are just names for remotes. If one wanted a
>>> "--all-remotes" could pull from everywhere in the Ether if feature was to
>>> be
>>> implemented.
>>
>> How is origin implied to be the default?
>> Should there be an order (e.g. if you cannot find it at inhouse get it
>> from github,
>> if they are down, get it from kernel.org)
>
> As it is in the Highlander series... "there can be only one" (remote).   So
> that is what I mean by origin.  The only remote allowed is the "origin"
> unless changed by the user... but there can still only be one *currently*.
> Though I see your point as it is not labeled "origin".  It is not labeled at
> all.  Apologies for confusion there.

"origin" is just a common name for a remote, like "master" is a common name
for branches. There is nothing inherently special about these except for
their automatic setup after cloning/initializing a repo.

So you can delete the master branch (which I did in a project
that I am not the authoritative maintainer of; I only have feature
branches), and
the repository just works fine.
