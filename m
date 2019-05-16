Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	FROM_EXCESS_BASE64,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 089081F461
	for <e@80x24.org>; Thu, 16 May 2019 09:50:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726717AbfEPJuj (ORCPT <rfc822;e@80x24.org>);
        Thu, 16 May 2019 05:50:39 -0400
Received: from mail-ed1-f65.google.com ([209.85.208.65]:42954 "EHLO
        mail-ed1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726336AbfEPJuj (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 16 May 2019 05:50:39 -0400
Received: by mail-ed1-f65.google.com with SMTP id l25so4327714eda.9
        for <git@vger.kernel.org>; Thu, 16 May 2019 02:50:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:references:user-agent:in-reply-to:date
         :message-id:mime-version;
        bh=jr6GeVBqXeD+guPq42vYm2/xWet4ghGW3ttvcKWjpBk=;
        b=kPXd7DKW6IfDJw+N/wAGDCZkrHo3Icro/cUQ3N2xAvj0VGLLnsI9I7VbLZ8KmzVvl/
         8kD3KzPasv5/nJDErZIjNLcYP9hOD7KceGgJ8/mVmSgKXhdEOOtKYdrnYN2aADeIfBOf
         tXROTakXJ/lSvxgmjDoxl1hxLGc2ywYfLU/aVpV3wIMV3V789mAKvcW2dGybw/rWuzdL
         fN1XjI+GSVbXKLk2oi5vC9PDAVCAYNr3OlFM6uesMqMAidzJaIWqwvG3bB8/HkAWu1/f
         UcmrFobaaqh0wFtFlNxr22x2p1IXQ9Y252mOalKUkzDUv/QcuOuzBCYPRFlx4fjmiEvw
         WX2Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:references:user-agent
         :in-reply-to:date:message-id:mime-version;
        bh=jr6GeVBqXeD+guPq42vYm2/xWet4ghGW3ttvcKWjpBk=;
        b=RVwSiiMdTDZUfvmO/b3JtO6QyNUtT/DZtzBbRmmIlut0tq303XB1eV8w/qiWm/By7M
         hZudt4+O1r2shPbtwspIn4K1CXrI+OfalL0xpBHnlTI8H9rqqyiSBY37miGulfRbdisD
         EY3jveCPXlNi8pg+d0SnG9y15kEwy1oO4BFQ2T9rImBN/yarfWH/3jqQFm2rdLMoDVFe
         aGK4pwpBoev5Er4Jra9J8wz0ZvzFEu64IsxX5TZ/A0WBUA0376WgaF7LwwlOTmF8B0eZ
         L3cPxo1rcdPssjbh3PbC8yJlaJFjRIQL7VOEOX6ufrEAJz6FPevOdPuN+Zj1gMGqdrec
         rwJg==
X-Gm-Message-State: APjAAAVNf9rfO9+qm9sJzpyy0kHnSSBjuXHjJJFu0bGkrpBSlx1C9c+i
        DDNtZ8a8gSmx+tDQEStih0BFBnLJFIE=
X-Google-Smtp-Source: APXvYqyMRttm/99Z+5J8qxsQ+isuEo7s/kICXaeFD9ixgcvT/PYOzHgh4bIqSDBiVa1SO6Ys97G5oQ==
X-Received: by 2002:a17:906:5c12:: with SMTP id e18mr7930208ejq.157.1558000237140;
        Thu, 16 May 2019 02:50:37 -0700 (PDT)
Received: from evledraar (dhcp-077-251-215-224.chello.nl. [77.251.215.224])
        by smtp.gmail.com with ESMTPSA id z32sm1696820edz.85.2019.05.16.02.50.36
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 16 May 2019 02:50:36 -0700 (PDT)
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     esr@thyrsus.com
Cc:     Derrick Stolee <stolee@gmail.com>, git@vger.kernel.org
Subject: Re: Finer timestamps and serialization in git
References: <20190515191605.21D394703049@snark.thyrsus.com> <ae62476c-1642-0b9c-86a5-c2c8cddf9dfb@gmail.com> <20190515233230.GA124956@thyrsus.com>
User-agent: Debian GNU/Linux buster/sid; Emacs 26.1; mu4e 1.1.0
In-reply-to: <20190515233230.GA124956@thyrsus.com>
Date:   Thu, 16 May 2019 11:50:35 +0200
Message-ID: <87woiqvic4.fsf@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Thu, May 16 2019, Eric S. Raymond wrote:

> Derrick Stolee <stolee@gmail.com>:
>> On 5/15/2019 3:16 PM, Eric S. Raymond wrote:
>> > The deeper problem is that I want something from Git that I cannot
>> > have with 1-second granularity. That is: a unique timestamp on each
>> > commit in a repository.
>>
>> This is impossible in a distributed version control system like Git
>> (where the commits are immutable). No matter your precision, there is
>> a chance that two machiens commit at the exact same moment on two different
>> machines and then those commits are merged into the same branch.
>
> It's easy to work around that problem. Each git daemon has to single-thread
> its handling of incoming commits at some level, because you need a lock on the
> file system to guarantee consistent updates to it.

You don't need a daemon now to write commits to a repository. You can
just add stuff to the object store, and then later flip the SHA-1 on a
reference, we lock those indivdiual references, but this sort of thing
would require a global write lock. This would introduce huge concurrency
caveats that are non-issues now.

Dumb clients matter. Now you can e.g. have two libgit2 processes writing
to ref A and B respectively in the same repo, and they never have to
know about each other or care about IPC.

Also, even if you have daemons accepting pushes they can now be on
different computers sharing things over e.g. an NFS filesystem. Now you
need some FS-based serialization protcol for commits and their
timestamps.

> So if a commit comes in that would be the same as the date of the
> previous commit on the current branch, you bump the incoming commit timestamp.
> That's the simple case. The complicated case is checking for date
> collisions on *other* branches. But there are ways to make that fast,
> too. There's a very obvious one involving a presort that is is O(log2
> n) in the number of commits.

What Derrick mentioned downthread of this "I rebase your pushes" being
fundimentally un-git applies, but let's assume we can somehow get past
that for the sake of argument.

The model you're trying to impose here of "within a repo I want to
serialize all X" just doesn't play with how git views the world. Git
cares about graphs being serialized, it doesn't care about arbitrary
sets of graphs.

E.g. let's say I push a commit X to github, and now I want to push the
same history to gitlab, I might be twarted because they have some
side-ref they themselves make (e.g. the PR or MR refs) which conflicts
with this "timestamps must monotonically increase across all branches in
a repo" view of the world.

The only thing that matters in git in this regard is how individual refs
behave, we then by convention tend to have a 1=1 mapping between those
sets of refs and a repository, but in a lot of cases it's
many=1. E.g. in cases where such a hosting site might have one
underlying repo store exposed to multiple users via ref namespace
prefixes.

> I wouldn't have brought this up in the first place if I didn't have a
> pretty clear idea how to do it in code!
>
>> Even when you specify a committer, there are many environments where a set
>> of parallel machines are creating commits with the same identity.
>
> If those commit sets become the same commit in the final graph, this is
> not a problem for total ordering.
>
>> > Why do I want this? There are number of reasons, all related to a
>> > mathematical concept called "total ordering".  At present, commits in
>> > a Git repository only have partial ordering.
>>
>> This is true of any directed acyclic graph. If you want a total ordering
>> that is completely unambiguous, then you should think about maintaining
>> a linear commit history by requiring rebasing instead of merging.
>
> Excuse me, but your premise is incorrect.  A git DAG isn't just "any" DAG.
> The presence of timestamps makes a total ordering possible.
>
> (I was a theoretical mathematician in a former life. This is all very
> familiar ground to me.)
>
>> > One consequence is that
>> > action stamps - the committer/date pairs I use as VCS-independent commit
>> > identifications in reposurgeon - are not unique.  When a patch sequence
>> > is applied, it can easily happen fast enough to give several successive
>> > commits the same committer-ID and timestamp.
>>
>> Sorting by committer/date pairs sounds like an unhelpful idea, as that
>> does not take any graph topology into account. It happens that commits
>> can actually have an _earlier_ commit date than its parent.
>
> Yes, I'm aware of that.  The uniqueness properties that make a total
> ordering desirable are not actually dependent on timestamp order
> coinciding with topo order.
>
>> Changing the granularity of timestamps requires changing the commit format,
>> which is probably a non-starter.
>
> That's why I started by noting that you're going to have to break the
> format anyway to move to an ECDSA hash (or whatever you end up using).
>
> I'm saying that *since you'll need to do that anyway*, it's a good time
> to think about making timestamps finer-grained and unique.

We should really discuss proposed format changes separately from tacking
them onto the SHA-256 transition, because as I noted upthread your
premise that you need a format change for this isn't true. *If* this was
a good idea it's something you can add to commit objects.

And yeah, git-interpret-trailers is a bit of a kludge, which is why I
mentioned you can add new headers to the format, this is e.g. how GPG
signed commits work.

Of course whether it makes any sense to add such a thing to the format
is another matter, I'm not at all convinced, but that's a separate
discussion from how it would be done.
