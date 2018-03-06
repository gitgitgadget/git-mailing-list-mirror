Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 2E47F1F404
	for <e@80x24.org>; Tue,  6 Mar 2018 04:02:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753024AbeCFECl (ORCPT <rfc822;e@80x24.org>);
        Mon, 5 Mar 2018 23:02:41 -0500
Received: from mail-wr0-f174.google.com ([209.85.128.174]:35980 "EHLO
        mail-wr0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752866AbeCFECk (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 5 Mar 2018 23:02:40 -0500
Received: by mail-wr0-f174.google.com with SMTP id v111so19472263wrb.3
        for <git@vger.kernel.org>; Mon, 05 Mar 2018 20:02:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=Xy4Q2UZuigkl/9sQ7H/tJAERsfBtt0pZ0F8oBneYu5I=;
        b=b2ryyzApVDIW7+fhLWuvPU/8XjQ1eSw4Ms/Ysf+xdUDtb84B8Ro/mvSeMMcjOrgDvZ
         9spmM2yHtITrDAbKDdy3Ky5GK8HQ92WE1mfbeT8AZy+hS42DyOd5KmwrZWme7lEU+FW7
         KD4Ljzf8wIZo0FGw2xw93XFvZVrz+DSpLDhrRdFZEhoXHFl0F/P//+ns3mr15RwUZKf8
         5lzQT61hwHrjBZuInkS7TKTZWl1XDDx2pt3oSwNuoyzCtph7Q8r4DjA/5MvG4Unflncj
         cbflF+d+cJ7ZnOms1bmWBM/6l/G/7vgbXn1UJg3dM4kn+QUd7Zs6XrJ/iVHYc0Lr0ESe
         umIA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=Xy4Q2UZuigkl/9sQ7H/tJAERsfBtt0pZ0F8oBneYu5I=;
        b=nDp7V5OUN9TJqjdZYXmfo+Ctxr/7RbTwTZtDSIzDvP9jMXDso2qB+zhraB0LhDI8zj
         a58PQO/bP6NzBDHWzovwOoQd/O08/yf7CGUosHRUcoZI0MWwKxZJQG5BAIDTbCdhbclm
         Kx8VNLmID9JPa/wRdrUuPG48O3BRIpsO2Sh/U2ewyr3KG5cnmufXaWwy67huSNscqjZf
         nDk3axiGqzB5tM758k53gQ+w9X9obnjeeeKi1SMD0ixTHl1m8eTsQVjxf8yecCZTPnMO
         46l6q7slUKaa2ZfvZOh6ukEsC9E5qLBI0vSnBBW7yefn1lra//UrrOn409qn9J/Gyuze
         +6RQ==
X-Gm-Message-State: APf1xPAud5XiTAA3dcwghhstlaob2l8yfDNiM2pFRvatmWoyCAVvCC5K
        xT0maFS5l2qbFvXqFeH39ZlIwO9/Sb8=
X-Google-Smtp-Source: AG47ELt91lbeGmQBw8oG5mta8HvdvzVFY5xJhafJUn9i9KRs1PCQtWESfR5Ox2lGRZtAo8yiJFvL1A==
X-Received: by 10.223.166.103 with SMTP id k94mr13525600wrc.237.1520308959164;
        Mon, 05 Mar 2018 20:02:39 -0800 (PST)
Received: from [192.168.5.102] (cable-24-135-61-30.dynamic.sbb.rs. [24.135.61.30])
        by smtp.gmail.com with ESMTPSA id m55sm18479806wrf.38.2018.03.05.20.02.37
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 05 Mar 2018 20:02:38 -0800 (PST)
Subject: Re: [PATCH v5 00/12] rebase -i: offer to recreate merge commits
To:     Johannes Schindelin <johannes.schindelin@gmx.de>
Cc:     git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
        Jacob Keller <jacob.keller@gmail.com>,
        Stefan Beller <sbeller@google.com>,
        Philip Oakley <philipoakley@iee.org>,
        Eric Sunshine <sunshine@sunshineco.com>,
        Phillip Wood <phillip.wood@dunelm.org.uk>
References: <cover.1518307771.git.johannes.schindelin@gmx.de>
 <cover.1519680483.git.johannes.schindelin@gmx.de>
From:   Igor Djordjevic <igor.d.djordjevic@gmail.com>
Message-ID: <bc9f82fb-fd18-ee45-36a4-921a1381b32e@gmail.com>
Date:   Tue, 6 Mar 2018 05:02:28 +0100
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.6.0
MIME-Version: 1.0
In-Reply-To: <cover.1519680483.git.johannes.schindelin@gmx.de>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Johannes,

On 26/02/2018 22:29, Johannes Schindelin wrote:
> 
> Once upon a time, I dreamt of an interactive rebase that would not
> flatten branch structure, but instead recreate the commit topology
> faithfully.
> 
> My original attempt was --preserve-merges, but that design was so
> limited that I did not even enable it in interactive mode.
> 
> Subsequently, it *was* enabled in interactive mode, with the predictable
> consequences: as the --preserve-merges design does not allow for
> specifying the parents of merge commits explicitly, all the new commits'
> parents are defined *implicitly* by the previous commit history, and
> hence it is *not possible to even reorder commits*.
> 
> This design flaw cannot be fixed. Not without a complete re-design, at
> least. This patch series offers such a re-design.
> 
> Think of --recreate-merges as "--preserve-merges done right".

First of all, thanks for this wonderful improvement to existing `git 
rebase` functionality, I`m really excited to have this in the mainline! :)

But in the light of "--preserve-merges done right", I would like to 
hear your opinion on a topic that might be considered more or less 
important, and thus tackled in a few different ways... :$

Rebasing amended merges :( Even though documentation is quite clear 
about merge conflicts and manual amendments not recreated 
automatically, this might be considered quite an issue (a bug, even), 
as even in case of non-interactive rebase, amended content will be 
dropped - and even worse, it all happens silently, without alerting 
the user (for whom we presume to know what he`s doing, I guess).

Now, might be this is considered the least interesting use case, in 
comparison to all the power of more serious interactive rebases, but 
I would argue it could be the one most used by less adventurous users 
that would simply like to stay up-to-date with upstream, rebasing their 
current work on top of it (think `git pull --rebase=recreate`, even).

As it currently is, and that was the case with `--preserve-merges`, 
too, this will cause them to silently lose their work (amended merge 
content). And while documentation is clear about it, these might be 
less knowledgeable users, too, and thus potentially be the ones we 
should (try to) protect even more, if possible.

Now, in the light of that other, ongoing "merge rebasing" topic[1], 
it seems we really might be able to do much better, actually 
_rebasing_ merges (and keeping manual conflict resolutions/amendments), 
instead of _recreating_ them (and silently loosing content), and doing 
so reliably (or stopping for possible user inspection, but not silently 
doing the wrong thing, even if documented).

This concerns non-interactive rebase the most, but I have ideas on 
making it aligned with interactive one, too, where user could 
actually decide whether to rebase or (re)create the merge (rebase 
becoming the default, intuitively aligned with non-interactive rebase).

But before elaborating, I would like to hear your opinion on whether 
you find it worth to pursue that goal here, before `--recreate-merges` 
hits the mainstream, or it might be just fine as a possible later
improvement, too (if accepted, that is).

My main concern, and why I raised the question inside this topic in 
the first place, is default behavior. With `--recreate-merges` just 
being introduced, we have no backwards compatibility to think about, 
being a unique chance to make default behave as needed (not to say 
"correct", even), and might be really ticking one more of 
"--preserve-merges done right" boxes, and could be a pretty important 
one, too.

But once this becomes widely available, I guess it will be hard to 
improve (fix?) this merge rebasing silent content losing behavior 
(even if we would acknowledge it as a bug), without introducing 
additional options - and without a possibility to make possibly 
"right" behavior a default one, thus further complicating user 
experience.

So, I wanted to hear your stance on this :(

Knowing how much this means to you, it is really not my wish to drag 
this topic further, and if you find it that we`re good here as it is, 
I wouldn`t have any objections - I guess later new `--rebase-merges` 
option is a possibility, too, might be a wrapper around 
`--recreate-merges`, but with actual merge rebasing being a default 
(where merge recreation would still be possible, too)...

Otherwise, if you have any interest in it now, I can further elaborate 
what I`m thinking about, where it might help improve both user 
experience and rebase possibilities, for what might not be too much 
extra work... hopefully :P

Whatever ends up being your response, I`m really grateful for your 
work on this matter so far, and thank you for everything you did.

p.s. lol, now that I said it, and after writing all this, I might 
actually even like the idea of (later) having `--rebase-merges` 
alongside `--recreate-merges`, too, each one clearly communicating 
its default mode of operation - rebase merges vs. recreate merges... 
as one might rightfully expect ;) Eh :P

Regards, Buga

[1] https://public-inbox.org/git/87y3jtqdyg.fsf@javad.com/
