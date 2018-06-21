Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.6 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 051BF1F516
	for <e@80x24.org>; Thu, 21 Jun 2018 15:36:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933212AbeFUPgi (ORCPT <rfc822;e@80x24.org>);
        Thu, 21 Jun 2018 11:36:38 -0400
Received: from mail-vk0-f67.google.com ([209.85.213.67]:35008 "EHLO
        mail-vk0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S933188AbeFUPgh (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 21 Jun 2018 11:36:37 -0400
Received: by mail-vk0-f67.google.com with SMTP id o17-v6so2141987vka.2
        for <git@vger.kernel.org>; Thu, 21 Jun 2018 08:36:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=5UAx4c4oGmDCEUQgGIuWC71uPaMhxhDGHKQPdAyZ2tk=;
        b=ITFvHLYNcDuKqGS6yv48Rrcu7GAkGb4Sp+MOFUaa603nLjOxE8yDwGNpwq7Ntl7TiE
         d6MT00hDEsmqUQXvpy79jsODCcOMgm+0L+goWQHbLd5meqtqN+Ap93ulvpwyY4ajYx06
         sxfzY70KFfQ0CgOwjQTTyM4X3+O+9urljUr6rfSO9Bwysv2l6ndyZpCbZVyqRNZwH5u3
         YLk15UebBEm61kRoeE8N2xNfYdopDBhWxddoezAOlnSyGcu1JmVXuqcP762WEwRnZhTh
         yTXot+A/31XvVNfSaki8j3n7chfSAhbeEFL1zYzOtLHJS+IiCEXe9reDRrGnu+APqftL
         i0uA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=5UAx4c4oGmDCEUQgGIuWC71uPaMhxhDGHKQPdAyZ2tk=;
        b=BQq/a9YaaMgXV7tlKi9ongcJcHXs49Y+KxqF30FRGavkjpLVs46Xr+/4ZLahHvQUTL
         g2sfxtTkW9aVHKoF4cKAbaJNW53WFs+ucBFx++DfnNeKUpudxCVCzaDFdZwAfQP2xc0P
         2xhCK6vlP8GElTUPcQX5k/++x7N9dyoW4GAPozPz8kWv0/nIGP33a6Az90PRkwyzUePK
         eOCgFyLLAHTYmbjDKsUW3x9Gfe3iaMiHL236wv+QsKgst8cMXrqQNg4vZEqOUrygVzvA
         WOLQTdKXWFs+TNmdzJ+4y+NxFxgZB6iLpw4+NjWvXQblkmt4p9ZwQgNXQYtLUY3KMi5Q
         Vwrg==
X-Gm-Message-State: APt69E3rX8tGMTY3Pibx8LCbK35S8RDKoyh2XIgeuvg9DPrxgTTKz45F
        pYir8gV1rhwDS4Ff1WHw728NhPUSuiu1YD9vw3o=
X-Google-Smtp-Source: ADUXVKIRkgxYI3S3WZUu9QLZbasrTa5L43wXc3diGN15JiB5ZL5+t+Bi0hYy14YysKDBvpTFUHHNDYgh0FsR47RkszA=
X-Received: by 2002:a1f:e483:: with SMTP id b125-v6mr15253316vkh.149.1529595395967;
 Thu, 21 Jun 2018 08:36:35 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:ab0:5f28:0:0:0:0:0 with HTTP; Thu, 21 Jun 2018 08:36:35
 -0700 (PDT)
In-Reply-To: <nycvar.QRO.7.76.6.1806211242440.11870@tvgsbejvaqbjf.bet>
References: <CABPp-BGxaroePB6aKWAkZeADLB7VE3y1CPy2RyNwpn=+C01g3A@mail.gmail.com>
 <20180607171344.23331-1-newren@gmail.com> <20180607171344.23331-4-newren@gmail.com>
 <nycvar.QRO.7.76.6.1806100006000.77@tvgsbejvaqbjf.bet> <CABPp-BHa+sxuFBa3EmSyio28ytF_ORn950Keh1P=L-VxXtOwMw@mail.gmail.com>
 <nycvar.QRO.7.76.6.1806172337340.77@tvgsbejvaqbjf.bet> <CABPp-BEnJ4q9WGi4BgikpLJ9Aty5-3MR4VozjBk7ie4rGMc-ng@mail.gmail.com>
 <nycvar.QRO.7.76.6.1806211242440.11870@tvgsbejvaqbjf.bet>
From:   Elijah Newren <newren@gmail.com>
Date:   Thu, 21 Jun 2018 08:36:35 -0700
Message-ID: <CABPp-BGh7yW69QwxQb13K0HM38NKmQif3A6C6UULEKYnkEJ5vA@mail.gmail.com>
Subject: Re: [RFC PATCH 3/3] git-rebase.sh: make git-rebase--interactive the default
To:     Johannes Schindelin <Johannes.Schindelin@gmx.de>
Cc:     Git Mailing List <git@vger.kernel.org>,
        Junio C Hamano <gitster@pobox.com>,
        Alban Gruin <alban.gruin@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Dscho,

Thanks for all the food for thought.  This is awesome.

On Thu, Jun 21, 2018 at 3:57 AM, Johannes Schindelin
<Johannes.Schindelin@gmx.de> wrote:
> On Wed, 20 Jun 2018, Elijah Newren wrote:
>> On Sun, Jun 17, 2018 at 2:44 PM, Johannes Schindelin
>> <Johannes.Schindelin@gmx.de> wrote:
>>
>> > I was really referring to speed. But I have to admit that I do not have
>> > any current numbers.
>> >
>> > Another issue just hit me, though: rebase --am does not need to look at as
>> > many Git objects as rebase --merge or rebase -i. Therefore, GVFS users
>> > will still want to use --am wherever possible, to avoid "hydrating"
>> > many objects during their rebase.
>>
>> What is it that makes rebase --am need fewer Git objects than rebase
>> --merge or rebase -i?
>
> Multiple things. The most obvious thing: --cherry-pick. When you call `git
> rebase --am`, it does not try to exclude the patches by looking at
> `rev-list --cherry-pick --right-only <upstream>..<head>`
>
> This really bit us in GVFS Git because we have several thousand developers
> working on the same code base, and you probably read the numbers elsewhere
> how many commits are introduced while a developer goes on so much as a
> week-long vacation.

Ooh, that's interesting.  Here's a crazy idea: I'm curious if this is
essentially a workaround that we could expunge.  In particular,
am-based rebases will drop empty commits (that is, either commits that
are empty to start, or that after being applied are empty).  It never
grew a --no-allow-empty option either.  If rebase -i/-m were to behave
the same, for consistency sake, we could drop the `rev-list
--cherry-pick ...` call.  Granted, that would result in a slight
difference in behavior (it could result in conflicts in some cases
instead of an automatically empty commit), but may well be worth it
for consistencies' sake between rebase backends.  As a side effect of
making the backends consistent, it may also provide a nice performance
boost for the GVFS case by removing the need to do the --cherry-pick
thing.

> Next, rename detection.
>
> I think that bit us even harder because it tries to look at all the files
> that have been changed in upstream in the meantime, which can be *a lot*.
> And if you know that moving files outside of your cozy little sparse
> checkout is unlikely (or moving from the outside into your checkout), then
> all this hydration is pretty wasteful. That's why we had to switch off
> rename detection in GVFS Git.

Actually to be clear, for each side of the merge, rename detection
only needs to look at files that were not present in both the
merge-base and the branch.  Files which were modified but have the
same name are not involved (break detection is not active.).  But yes,
I understand how you can still get an awful lot of files, which makes
it worse when you then go and compare all of them in an O(N*M)
fashion.

>> My guess at what objects are needed by each type:
>>
>> At a high level, rebase --am for each commit will need to compare the
>> commit to its parent to generate a diff (which thus involves walking
>> over the objects in both the commit and its parent, though it should
>> be able to skip over subtrees that are equal), and then will need to
>> look at all the objects in the target commit on which it needs to
>> apply the patch (in order to properly fill the index for a starting
>> point, and used later when creating a new commit).
>
> No, in --am mode, it does not even need to look at all the objects in the
> target commits. Only those objects that correspond to the files that are
> touched by the diff.

Sorry, I mis-spoke.  Unless you've done something special with GVFS, I
believe the --am mode would indeed need to read all the _tree_ objects
in the target commits, but any _file_ object corresponding to a path
not modified by the other side need not be loaded since we can proceed
simply knowing its sha1sum.

> In a massive code base, such as Windows', this makes a huge difference.
> Even comparing the number of files touched by the patches that are to be
> rebased to the number of files that were touched in upstream since you
> rebased last is ridiculous. And a three-way merge needs to consider that
> latter set of files.

Actually, the three-way merge isn't all that different.  For a path
that exists in both branches and the merge base, it first compares
sha1sums (thus it does need to read all the tree objects), and then if
one side has not modified a certain path, it knows the merge result is
the sha1sum from the other side.  Thus, it won't need to read files
that were changed upstream so long as that path wasn't changed on your
side.

In fact, --merge and --interactive have a slight performance advantage
here: if upstream didn't modify the path, then it doesn't need to read
the file from your side to do any diff or comparison.  It can just use
whatever sha1sum you have.  In contrast --am mode will need to read
the relevant file more than once.  Since it first creates a series of
patches, it will have to read the file from your commit and its
parent, create a diff, and then later apply that diff to the target
version, and since the target version matches the merge base it will
end up just recovering the version of the file on your side that you
started with anyway.  (Since that file is already local, though, this
small performance advantage would currently be lost in the noise of
the other problems.)

>> If the application of the diff fails, it falls back to a three-way
>> merge, though the three-way merge shouldn't need any additional objects.
>
> The three-way merge needs to reconcile the diff between branch point and
> your changes to the diff between branch point and upstream's changes. The
> latter can be a lot bigger than the former, in which case --am's
> complexity (O(former)) is much nicer than --merge's (O(former u latter)).

Yeah, renames mess up that whole "a path that exists in both branches
and the merge base" requirement that I stipulated above, and widens
the scope considerably and affects performance rather markedly.  On
the positive side though, the more I read your description, the more I
think my rename performance work may give a speedup for the GVFS
usecase far in excess of the factor of 30 I saw for my usecase.  It
may still not quite match --am mode's outright avoidance of rename
detection, but I still think it should be pretty impressive.  Time
will tell...


Elijah
