Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 769241F404
	for <e@80x24.org>; Mon, 12 Mar 2018 22:19:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751282AbeCLWTu (ORCPT <rfc822;e@80x24.org>);
        Mon, 12 Mar 2018 18:19:50 -0400
Received: from mail-wm0-f44.google.com ([74.125.82.44]:34485 "EHLO
        mail-wm0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751323AbeCLWTt (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 12 Mar 2018 18:19:49 -0400
Received: by mail-wm0-f44.google.com with SMTP id a20so15437124wmd.1
        for <git@vger.kernel.org>; Mon, 12 Mar 2018 15:19:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:references:user-agent:in-reply-to:date
         :message-id:mime-version;
        bh=A30VVWw4UFa787GrUy/ovOSL5b42gh93clJXCEDGM8Q=;
        b=Rr44e7NoSSNS1e4p9upq7J8dpLbsV6I6BaCyHEE2z+wcVPY+r5H1u3i8cxFYJHgZgB
         gQ9J7lNo8ult3b2ZpAmDxxAJW2tk3kO44KaUymuyGsJo1zrfUgR/NpjYcRG6FA+KbawV
         zxAI2NPdhU591fVEufcUq/m02BXauDmvcxnCiffcDrpQt5EiDlxvXGk1JmKgZmAlL2yU
         wi9MtS7x9zksSYIYajjPeUNf29LIhXjw486aF8V4BUYVx7RJRZV99JMyQy7ApKxAYt2C
         CbF2QRZP566NdBb3oDs+Y0bOW3J7cGbz3owqAf2QJ4uBdlHyCnwqnqInw1ajJNLcjC99
         I0Eg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:references:user-agent
         :in-reply-to:date:message-id:mime-version;
        bh=A30VVWw4UFa787GrUy/ovOSL5b42gh93clJXCEDGM8Q=;
        b=HQ8K8VOin0GOQ21wl2136YkyknD5T9urCCkdC8SVTivQC7BBgbT4jDQHCiRHU5//U/
         WGpTAkDnodEaQN39LVb/27+MmdhuZ4eRrWyLb2wCs1Bq3Pv15PZRyDNdR0Pj4zhEQi8B
         2/3ypbeUYGW+rbinqZbyi5sE+GgM/pGY+DlPvbGsi3wN3Xyb+maGu1Nq2fu8U6GcD8dZ
         g5rRJsjvTH3Hy73JYBn6ekCohtGWNsAwT2KogfPIS8ZgrKPbYtDTYEjHMJxeGlYp/IzX
         DaIzt4tO7BnQmA8Wp2qYrVs8jAKr2o81RGuiLIBqnPeWRDVE0Uh4e/jMZBtrCxIIcAb5
         5ndQ==
X-Gm-Message-State: AElRT7FD0BPI8mB1kNa4annPCkQFrIu8PNe+IwcEVX50p4VWqWQBuajJ
        yv//y+mS1CsmhdG67qSVotE=
X-Google-Smtp-Source: AG47ELvFIcTrqWonn62h1CQIv+bNPU94KZFEHG7s35akP4vjHPfBNrZdq6ablcHVOcj12uQfrVXolQ==
X-Received: by 10.28.114.8 with SMTP id n8mr6426491wmc.30.1520893187946;
        Mon, 12 Mar 2018 15:19:47 -0700 (PDT)
Received: from evledraar (dhcp-089-098-184-206.chello.nl. [89.98.184.206])
        by smtp.gmail.com with ESMTPSA id l8sm5624717wmf.39.2018.03.12.15.19.46
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 12 Mar 2018 15:19:46 -0700 (PDT)
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     Elijah Newren <newren@gmail.com>
Cc:     Git Mailing List <git@vger.kernel.org>
Subject: Re: Opinions on changing add/add conflict resolution?
References: <CABPp-BEXcvgxcn4-OrDhjUpuOsGCJwE_XT+0eYOK4Ad_O5maOg@mail.gmail.com>
User-agent: Debian GNU/Linux 9.3 (stretch); Emacs 25.1.1; mu4e 1.1.0
In-reply-to: <CABPp-BEXcvgxcn4-OrDhjUpuOsGCJwE_XT+0eYOK4Ad_O5maOg@mail.gmail.com>
Date:   Mon, 12 Mar 2018 23:19:45 +0100
Message-ID: <876061q6m6.fsf@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Mon, Mar 12 2018, Elijah Newren jotted:

> Hi everyone,
>
> I'd like to change add/add conflict resolution.  Currently when such a
> conflict occurs (say at ${path}), git unconditionally does a two-way
> merge of the two files and sticks the result in the working tree at
> ${path}.
>
> I would like to make it instead first check whether the two files are
> similar; if they are, then do the two-way merge, but if they're not,
> then instead write the two files out to separate paths (${path}~HEAD
> and ${path}~$MERGE, while making sure that ${path} is removed from the
> working copy).
>
> Thoughts?
>
> I have a patch series[1] with more details and other changes, but
> wanted to especially get feedback on this issue even from folks that
> didn't have enough time to read the patches or even the cover letter.

Does this mean that e.g. in this case of merging two files, one
containing "foo" and one containing "bar":

    (
        rm -rf /tmp/test.git &&
        git init /tmp/test.git &&
        cd /tmp/test.git &&
        echo foo >README &&
        git add README &&
        git commit -mfoo &&
        git checkout --orphan trunk &&
        git reset --hard &&
        echo bar >README &&
        git add README &&
        git commit -mbar &&
        git merge --allow-unrelated-histories master;
        cat README
    )

That instead of getting:

    <<<<<<< HEAD
    bar
    =======
    foo
    >>>>>>> master

I'd now get these split into different files?

I'm assuming by similarity you're talking about the same heuristic we
apply for git diff -M, i.e. if "moving" a file would consider it
removed/added instead of moved you'd want two files instead of the
two-way merge.

I don't mind this being a configurable option if you want it, but I
don't think it should be on by default, reasons:

 1) There's lots of cases where we totally screw up the "is this
    similar?" check, in particular with small files.

    E.g. let's say you have a config file like 'fs-path "/tmp/git"' and
    in two branches you change that to 'fs-path "/opt/git"' and 'fs-path
    "/var/git"'. The rename detection will think this these have nothing
    to do with each other since they share no common lines, but to a
    human reader they're really similar, and would make sense in the
    context of resolving a bigger merge where /{opt,var}/git changes are
    conflicting.

    This is not some theoretical concern, there's lots of things that
    e.g. use small 5-10 line config files to configure some app that
    because of some combo of indentation changes and changing a couple
    of lines will make git's rename detection totally give up, but to a
    human reader they're 95% the same.

 2) This will play havoc with already established merge tools on top of
    git which a lot of users use instead of manually resolving these in
    vi or whatever.

    If we made this the default they'd need to to deal with this new
    state, and even if it's not the default we'll have some confused
    users wondering why Emacs Ediff or whatever isn't showing the right
    thing because it isn't supporting this yet.

So actually, given that last point in #2 I'm slightly negative on the
whole thing, but maybe splitting it into some new format existing tools
don't understand is compelling enough to justify the downstream breakage.

I don't think we've ever documented the format we leave the tree in
after a failed merge as equivalent to plumbing, but for the purposes of
tools that build on top of git it really is.
