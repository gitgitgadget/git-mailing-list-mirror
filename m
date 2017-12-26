Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id E20151F424
	for <e@80x24.org>; Tue, 26 Dec 2017 08:40:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1750732AbdLZIkt (ORCPT <rfc822;e@80x24.org>);
        Tue, 26 Dec 2017 03:40:49 -0500
Received: from mail-wm0-f48.google.com ([74.125.82.48]:33583 "EHLO
        mail-wm0-f48.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750705AbdLZIks (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 26 Dec 2017 03:40:48 -0500
Received: by mail-wm0-f48.google.com with SMTP id g130so35231577wme.0
        for <git@vger.kernel.org>; Tue, 26 Dec 2017 00:40:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=W+Hcs3Kl3ucgF492V4NkZi081PfOHbSbduV8ohPwWsE=;
        b=FwzanZBHDTo+89gVc9w/ThNBVE2UIlslzsY3QaPL1BtB8W033R5d8B9SIX3/Ohs9/I
         EVHhniHT8OZXUqti/5XK6R2WyLHb0BTfh0wxqDxmMf5oxjztdAWQJWvxbF2U2KogUwS3
         IkGkfEwwO6/vcIB8wIL3FyIIY+GgqP9N4zHPoreNIu8UyL4f/lUx0VyZLqgd7P726SZA
         Pqzlbg9OgoByLKz9343f2xz1zyoN9yMigJALz+kd5Kp+1x4lwTF6hpVYwngTyoY8u3yB
         IIm+hu15UDBl5Tb7GDO6QbZPKdByxX4CXsnitWL6kwlN185R5sKhLuvwJsML1IoOtKAC
         qz7w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=W+Hcs3Kl3ucgF492V4NkZi081PfOHbSbduV8ohPwWsE=;
        b=gwetzYpdGFvuO3L6fApmB8gKs4vQs44f7d1fOB8ZgOP0MbXp/vwAUuDIQN0hKkVnYy
         VAhKrAkeZ9QxTA7FCbl/iKBpSnAkyiXOjuonl+2y+vF+OsGthGESmmSwWf93FlD/GNAZ
         +klNDqIMli06zYKsh41f3aRq25FQpK7XxOu3Q/0XbMBUhBaEspi5ItyR/QgkPFgd1ZM3
         jWf69z/XJ0p3qKCKpgRcBO+F5AZAoEyHxsIUkpOmC+No4wpD5F9eCeRxZsaE80RTws7T
         s29s936qgNe1boTDjJ+SPo1TB6wDMW2CVGms2vywzHyiGh/IUMgZbFJt023zYfkiNewF
         AlUw==
X-Gm-Message-State: AKGB3mIgkH7Qnm5tlbnaeTmWvN0dmM3cefEWWeYbPFeXzay76Z1IX+IE
        xxd8yD3vzZ64vKMlC8TLabjLP+/Ey0S8Z3oWStA=
X-Google-Smtp-Source: ACJfBov7v9X7E1x+EpABZHOAHNUgyDqtvqmVxjP6gamOgSpued+V0U5HMFIw++wly3OiDxyLkTiS4TRIc8oXfADFf6c=
X-Received: by 10.80.149.152 with SMTP id w24mr30536747eda.76.1514277646767;
 Tue, 26 Dec 2017 00:40:46 -0800 (PST)
MIME-Version: 1.0
Received: by 10.80.174.252 with HTTP; Tue, 26 Dec 2017 00:40:26 -0800 (PST)
In-Reply-To: <20171226060229.GB18783@Carl-MBP.ecbaldwin.net>
References: <CALiLy7pBvyqA+NjTZHOK9t0AFGYbwqwRVD3sZjUg0ZLx5y1h3A@mail.gmail.com>
 <20171225035215.GC1257@thunk.org> <20171226011638.GA16552@Carl-MBP.ecbaldwin.net>
 <CA+P7+xpj4o+N3uy2ea7DM-Y0oY_scayUARZMWP5QCwJEG02bZg@mail.gmail.com> <20171226060229.GB18783@Carl-MBP.ecbaldwin.net>
From:   Jacob Keller <jacob.keller@gmail.com>
Date:   Tue, 26 Dec 2017 00:40:26 -0800
Message-ID: <CA+P7+xpvuCjdnjyQxQg3B5iMwbnx-CerQMAP+bDQHR_-ALJOkQ@mail.gmail.com>
Subject: Re: Bring together merge and rebase
To:     Carl Baldwin <carl@ecbaldwin.net>
Cc:     "Theodore Ts'o" <tytso@mit.edu>,
        Git Mailing List <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Dec 25, 2017 at 10:02 PM, Carl Baldwin <carl@ecbaldwin.net> wrote:
> On Mon, Dec 25, 2017 at 05:47:55PM -0800, Jacob Keller wrote:
>> On Mon, Dec 25, 2017 at 5:16 PM, Carl Baldwin <carl@ecbaldwin.net> wrote:
>> > Anyway, now I am compelled to use github which is also a fine tool and I
>> > appreciate all of the work that has gone into it. About 80% of the time,
>> > I rebase and force push to my branch to update a pull request. I've come
>> > to like the end product of the rebase workflow. However, github doesn't
>> > excel at this approach. For one, it doesn't preserve older revisions
>> > which were already reviewed which makes it is difficult for reviewers to
>> > pick up where they left off the last time. If it preserved them, as
>> > gerrit does, the reviewer can compare a new revision with the most
>> > recent older revision they reviewed to see just what has been addressed
>> > since then.
>>
>> A bit of a tangent here, but a thought I didn't wanna lose: In the
>> general case where a patch was rebased and the original parent pointer
>> was changed, it is actually quite hard to show a diff of what changed
>> between versions.
>>
>> The best I've found is to do something like a 4-way --cc merge diff,
>> which mostly works, but has a few awkward cases, and ends up usually
>> showing double ++ and -- notation.
>>
>> Just something I've thought about a fair bit, trying to come up with
>> some good way to show "what changed between A1 and A2, but ignore all
>> changes between parent P1 and P2 which you don't care that much about
>> in this context.
>
> I ran into this all the time with gerrit. I wrote a script that you'd
> run on a working copy (with no local changes). I'd fetch and checkout
> the latest patchset that I want to review(say, for example, its patchset
> 5) from gerrit. Then, say I wanted to compare it with patch set 3 which
> has a different parent. I'd run this from the top level of my working
> copy.
>
>     compare-to-previous-patchset 3
>
> It would fetch patch set 3 from gerrit, rebase it to the same parent as
> the current patch set on a detached HEAD and then git diff it with the
> current patch set. If there were conflicts, it would just commit the
> conflict markers to the commit. There is no attempt to resolve the
> conflicts. The script was crude but it helped me out many times and it
> was nice to be able to review how conflicts were resolved when those
> came up.
>
> Carl
>

Interesting. That could work fairly well. I usually do something along
the lines of:

git diff patch-new patch-old patch-base-new patch-base-old --cc, which
produces a combined diff format patch which usually works ok.

My biggest gripes are that the gerrit web interface doesn't itself do
something like this (and jgit does not appear to be able to generate
combined diffs at all!)

> PS In case you're curious, here's my script...
>
> #!/bin/bash
>
> remote=gerrit
> previous_patchset=$1; shift
>
> # Assumes we're sitting on the latest patch set.
> new_patch_set_id=$(git rev-parse HEAD)
>
> branch=$(git branch | awk '/^\*/ {print$2}')
> [ "$branch" = "(no" ] && branch=
>
> # set user, host, port, and project from git config
> eval $(echo "$(git config remote.$remote.url)" |
>        sed 's,ssh://\(.*\)@\(.*\):\([[:digit:]]*\)/\(.*\).git,user=\1 host=\2 p<
>
> gerrit() {
>     ssh $user@$host -p $port gerrit ${1+"$@"}
> }
>
> # Grabs a bunch of information from gerrit about the current patch
> eval $(gerrit query --current-patch-set $new_patch_set_id |
>     awk '
>         BEGIN {mode="main"}
>         / currentPatchSet:/ { mode="currentPatchSet" }
>         / ref:/ { printf "new_patch_ref=%s\n", $2 }
>         / number:/ {
>             if (mode=="main") {
>                 printf "review_num=%s\n", $2
>             }
>             if (mode=="currentPatchSet") {
>                 printf "new_patchset=%s\n", $2
>             }
>         }
>     ')
>
> # Fetch the old patch set
> old_patch_ref=${new_patch_ref%$new_patchset}$previous_patchset
> git fetch $remote $old_patch_ref && git checkout FETCH_HEAD
>
> # Rebase the old patch set to the parent of the new patch set.
> if ! git rebase HEAD^ --onto ${new_patch_set_id}^
> then
>     git diff --name-only --diff-filter=U -z | xargs -0 git add
>     git rebase --continue
> fi
>
> previous_patchset_rebased=$(git rev-parse HEAD)
>
> # Go back to the new patch set and diff it against the rebased old one.
> if [ "$branch" ]
> then
>     git checkout $branch
> else
>     git checkout $new_patch_set_id
> fi
> git diff $previous_patchset_rebased

One thing you might do is have it create a temporary worktree in order
to avoid problems with being in the local checkout.

Thanks,
Jake
