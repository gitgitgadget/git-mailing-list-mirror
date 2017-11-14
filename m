Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.6 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id E5C361F43C
	for <e@80x24.org>; Tue, 14 Nov 2017 18:13:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753462AbdKNSNc (ORCPT <rfc822;e@80x24.org>);
        Tue, 14 Nov 2017 13:13:32 -0500
Received: from mail-qt0-f181.google.com ([209.85.216.181]:55448 "EHLO
        mail-qt0-f181.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753164AbdKNSNa (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 14 Nov 2017 13:13:30 -0500
Received: by mail-qt0-f181.google.com with SMTP id v41so27466700qtv.12
        for <git@vger.kernel.org>; Tue, 14 Nov 2017 10:13:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=nh6UMqUL7CjYeZD5OygGxFc1E2FSpxZKG+VExUmWTOs=;
        b=LM7T5DRWi7How+B+stt0fbjO82L769RthQ8dUn0wj1R0vRpI33l2ankB0NKVE7IXfK
         D/fpyxSKrzG9CTCo9HiPhXYNZR9mi/lnR6TkZA5JBbqPCR03Yx5NGvVuibxjAcFAkmVO
         0LR8iKs3ltfWJ/cfnPhbFhUGqxTDiLfQ7+f5unlgN3LjfSa4wobtCnieTtrCmp9XY/DQ
         hhQTTCbg6E3Q+KnT8/53cJWk8XZQ3rudqWQjsLzSdQig2fYiK9L1yvsVjtn52e3y1WVc
         XCZxgO27RrK4sE1bS09ioAQHqaIqiYQ2tNu6KFuPdisda+FWFnhfBM6Pd1jAtPIPWYfL
         EaVA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=nh6UMqUL7CjYeZD5OygGxFc1E2FSpxZKG+VExUmWTOs=;
        b=arpu0X38xX1xV6vco31dRSgPRq/WZmbK9K/pixT3/d3DrNBXTjnSdqivAwzshsy8Gn
         RuMbEl7bJE9xYZbPRUL+tspS8WCfw/PVKXDAOOy4xn3csxowDbOpnlU6Wi9bTAtuo65Q
         mPNf81vy0+Fe7Pvtzjoo8tzBndpfRfa1Xqumrtm7pIhlXzyNZd/9c6aBULa24r/BeT3+
         6Rz9RnS49ijTFR0uIKVYy9ih5AeEnhAkIiX5s594ORBEgXBZ7+a2/Qiz8icoELR1c/PB
         O/7J+m4+niD+elMmt2+/d3zyQyrcT+QpSdBvKbKArbqJsRuQ3NNzf7Wfn7VD2iqy+ENN
         DKDw==
X-Gm-Message-State: AJaThX7g7tbzUCIL+TCmgXTRBVXDQKDn3vUTFgXv80lhkiciS4VxWto6
        XJm7czDsbsxREN2rpDaOTibHaaKoNZBw1P2s9YPzyH1D4us=
X-Google-Smtp-Source: AGs4zMYyDR1i5KB+SLjRoFZGMcCMuwHWoJyCjm0humjeyqhuzAou7VWZ/KvbhWJmwLxp2ziuvEgOkX9G8VlCcBwKais=
X-Received: by 10.55.125.196 with SMTP id y187mr22053722qkc.180.1510683209500;
 Tue, 14 Nov 2017 10:13:29 -0800 (PST)
MIME-Version: 1.0
Received: by 10.140.96.118 with HTTP; Tue, 14 Nov 2017 10:13:28 -0800 (PST)
In-Reply-To: <CABPp-BHDrw_dAESic3xK7kC3jMgKeNQuPQF69OpbVYhRkbhJsw@mail.gmail.com>
References: <CABPp-BHDrw_dAESic3xK7kC3jMgKeNQuPQF69OpbVYhRkbhJsw@mail.gmail.com>
From:   Stefan Beller <sbeller@google.com>
Date:   Tue, 14 Nov 2017 10:13:28 -0800
Message-ID: <CAGZ79kbRY1gY8L361o568391Efoa1epZ1dFQZcTqJiOE7EAJfw@mail.gmail.com>
Subject: Re: submodules and merging (Was: Re: [PATCH 02/30] merge-recursive:
 Fix logic ordering issue)
To:     Elijah Newren <newren@gmail.com>
Cc:     git <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Thanks for your reply!

On Tue, Nov 14, 2017 at 9:17 AM, Elijah Newren <newren@gmail.com> wrote:
> On Mon, Nov 13, 2017 at 3:46 PM, Stefan Beller <sbeller@google.com> wrote:
>> On Mon, Nov 13, 2017 at 3:39 PM, Elijah Newren <newren@gmail.com> wrote:
>>> On Mon, Nov 13, 2017 at 2:12 PM, Stefan Beller <sbeller@google.com> wrote:
>>>> I wanted to debug a very similar issue today just after reviewing this
>>>> series, see
>>>> https://public-inbox.org/git/743acc29-85bb-3773-b6a0-68d4a0b8fd63@ispras.ru/
>>>
>>> Oh, bleh.  That's not a D/F conflict at all, it's the code assuming
>>> there's a D/F conflict because the entry it is processing ("sub") is a
>>> submodule rather than a file, and it panics when it sees "a directory
>>> in the way" -- a directory that just so happens to be named "sub" and
>>> which is in fact the desired submodule, meaning that the working
>>> directory is already good and needs no changes.
>>
>> yup, I came to find the same snippet of code to be the offender,
>> I just haven't figured out how to fix this bug.
>>
>> Thanks for taking a look!
>>
>> As you have a lot of fresh knowledge in the merge-recursive case
>> currently, how would we approach the fix here?
>
> submodules and merging looks pretty broken, to me.  Backing off from
> the current bug and just looking at merging with submodules in
> general, makes me a little uneasy with what I see.  I mean, just look
> at update_file_flags, when it wants the working directory updated, the
> code for a submodule is the following:
>
>     if (update_wd) {
> <snip>
>
>         if (S_ISGITLINK(mode)) {
>             /*
>              * We may later decide to recursively descend into
>              * the submodule directory and update its index
>              * and/or work tree, but we do not do that now.
>              */
>             update_wd = 0;
>             goto update_index;
>         }
>
> So, it just doesn't put anything there, so the working directory is
> made out-of-date immediately.  Users are happy with that?  Maybe it is
> what makes sense, but it surprised me.

Submodules are traditionally not touched by git commands and we are slowly
trying to get that changed. Some commands have a --recurse-submodules
flag now, including checkout, reset; merge is missing this flag as the semantics
are hard to define sensibly, yet.

> From there, we can start stacking on the weird.  For example let's say
> we have this setup:
> O (merge base): path/contents containing "whatever\n"
> A (ours): path is a submodule
> B (theirs): path/contents containing "whatever\nworks\n"
>
> Merging A into B results in
>
> CONFLICT (modify/delete): path/contents deleted in A and modified in
> HEAD. Version HEAD of path/contents left in tree.
> CONFLICT (directory/file): There is a directory with name path in
> HEAD. Adding path as path~A
> Automatic merge failed; fix conflicts and then commit the result.
>
> but path~A is never created, because of the update_file_flags code
> snippet above.  If the user looks at the path directory, it doesn't
> have any submodule info either.  It has just "disappeared", despite
> the claim made in the conflict notice.  Maybe okay, but slightly
> confusing.
>
> Now let's say the user just wants to back out of this merge.  What if
> they run 'git merge --abort'?  Well, they're greeted with:
>
> error: 'path/contents' appears as both a file and as a directory
> error: path/contents: cannot drop to stage #0
> error: Untracked working tree file 'path/contents' would be
> overwritten by merge.
> fatal: Could not reset index file to revision 'HEAD'.
>
> "Would be overwritten by merge"?  We're unmerging, and I agree it
> shouldn't be overwritten, but the fact that it thinks it needs to try
> is worrisome.  And I don't like the fact that it just outright failed.
> Okay, what about 'git reset --hard' at this point:
>
> error: 'path/contents' appears as both a file and as a directory
> error: path/contents: cannot drop to stage #0
> warning: unable to rmdir path: Directory not empty
> HEAD is now at 3e098a0 B
>
> Cannot drop to stage #0?  Oh, boy.  Things must be really messed up.
> Except they're not; it did drop path/contents to stage #0 despite the
> error, and git status is clean again.
>
> Now, let's switch tracks and look at things from the other side.  What
> if the user had been on A and tried to merge B into A?
>
> $ git checkout A
> Switched to branch 'A'
> $ git merge B
> CONFLICT (modify/delete): path/contents deleted in HEAD and modified
> in B. Version B of path/contents left in tree.
> Adding path
> Automatic merge failed; fix conflicts and then commit the result.
>
> path/contents is left in the tree?  But there's a submodule in the
> way!  Did it really put it there...?  Yep:
>
> $ ls -al path/
> total 16
> drwxrwxr-x 3 newren newren 4096 Nov 14 08:40 .
> drwxrwxr-x 4 newren newren 4096 Nov 14 08:38 ..
> -rw-rw-r-- 1 newren newren   15 Nov 14 08:40 contents
> -rw-rw-r-- 1 newren newren    0 Nov 14 08:39 foo
> drwxrwxr-x 8 newren newren 4096 Nov 14 08:40 .git
>
> At least git add and git rm on that location, from the supermodule, do
> the right thing.
>
> $ git add path/contents
> fatal: Pathspec 'path/contents' is in submodule 'path'
> $ git rm path/contents
> path/contents: needs merge
> rm 'path/contents'
>
> But the fact that merge-recursive wrote unmerged entries back to the
> working tree within the submodule feels pretty weird and dirty to me.
> (Luckily, if the locations conflict with something in the submodule,
> it'll write things out to an alternate path, such as path/contents~B,
> so it merely muddies the submodule rather than destroying stuff within
> it).
>
>
> Also, now I'm worried that instead of just D/F (directory/file)
> conflicts, we now have two new classes that need to be checked
> everywhere throughout the code: submodule/file and submodule/directory
> conflicts.  No idea how pervasive of a problem that is.  Maybe there's
> a clever way to handle them all with the current D/F conflict code (it
> certainly didn't take submodules into consideration when it was
> written), but someone would have to take a careful look.  There are
> already many codepaths due to many different conflict types, and folks
> already have to keep several things in their head: renames, directory
> renames, D/F conflicts, recursive cases, dirty files, untracked
> files/directories, and now submodules.  It would be nice if we could
> reduce the number of things folks have to focus on all at once while
> reading merge-recursive.c.  I'm really starting to think we should at
> least change how unpack_trees() and merge-recursive interoperate,
> because at least the dirty files & untracked files/directories should
> be able to be split off, so folks can focus on just the index for most
> the code paths, and everything working tree related could be handled
> separately.  But that's a topic for a different thread.
>
> Anyway, circling back the problem you brought up, there is actually a
> fairly easy fix if you want _just_ this issue cleaned up.  I'll post a
> simple patch, but it doesn't address the above problems so it feels a
> bit like a band-aid to me.

Yes, introducing submodules into the mix is a big mess, because
in the tree it is recorded as if it is a file (only the top level
entry at path/)
but on the file system a submodule is represented as a directory
with contents, so the conflict detection is harder, too.

I had the idea of introducing a command that can "internalize"
a submodule. This would take the tree recorded in the submodule
commit and put it where the submodule was mounted,
The opposite is "externalizing" a submodule, which would turn
a tree into a submodule. (One of the many question is if it will take
the whole history or start with a new fresh initial commit).

But this line of though might be distracting from your original point,
which was that we have so much to keep in mind when doing tree
operations (flags, D/F conflicts, now submodules too). I wonder how
a sensible refactoring would look like to detangle all these aspects,
but still keeping Git fast and not overengineered.

Thanks,
Stefan
