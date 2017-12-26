Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	T_RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 7F9CE1F406
	for <e@80x24.org>; Tue, 26 Dec 2017 06:02:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1750777AbdLZGCe (ORCPT <rfc822;e@80x24.org>);
        Tue, 26 Dec 2017 01:02:34 -0500
Received: from mail-it0-f53.google.com ([209.85.214.53]:36139 "EHLO
        mail-it0-f53.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750705AbdLZGCd (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 26 Dec 2017 01:02:33 -0500
Received: by mail-it0-f53.google.com with SMTP id d16so21889595itj.1
        for <git@vger.kernel.org>; Mon, 25 Dec 2017 22:02:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ecbaldwin.net; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=KrAQ8vVDjrAuII4JnU9zgzwLXzFhbofZ8C0DDs1oS2s=;
        b=KKPs7VtlDDQvLZHXJnvHClxQOxhWo/LejICGJB2GDQG06P0zMcuGNMM8gtUaAHrhgJ
         iTWBUsi1wlT8KbDjkJymimoAbBQSLAeLY5VMHCF1eqjEuUvx1S3S//ZIpyru3+MF7qyI
         Zu1W1E2T2EPBht5EpOy6SG1/Bcx8lhK7BVu0c=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=KrAQ8vVDjrAuII4JnU9zgzwLXzFhbofZ8C0DDs1oS2s=;
        b=Xe155VSyANVH0jVVMxZWqN3CS00rl7qzqQY8xkJi/lhVogrDM119t6D+wjy3umEYXr
         LM5cjfTw8Azun08AkRdHY8M2OYRrYN0P/nfkc5flZJ9vChDq+Wqj75g92adlpl9qxq9p
         hyWbQUaOqRAO3VbMum6QM66w1RKE1lxYrVwshgkqkZEVV+sF5GVmbLLS2Isnvsdj/lfH
         2BCofc9rNCGonEZugD45QenHz+nkaI4oqwG2qPQr0VXGQ12V2F8JKnLOHJ5Sny8RNi1E
         fYNDdWMDbliAxyt0/yCV31Jls03QBiSByAcVMQzozUufUvlZoYIBX7YuApgK2WeMoJL2
         QDzg==
X-Gm-Message-State: AKGB3mJ43pydEy1nZW5nWQeJkRz6SqAQFHbziRDc4/PKkYIo4mTCzwDf
        M6+aKnSx9kDPSwBk0qFXozU8SiTic3s=
X-Google-Smtp-Source: ACJfBov0enJ3Q5GxcPJ+CCXGvVoPEofsTDgNSJ4IuWiq9cEkUEOgF3+VscyUd9yeUnT0zDFyvPSlQw==
X-Received: by 10.36.213.67 with SMTP id a64mr31512317itg.87.1514268152749;
        Mon, 25 Dec 2017 22:02:32 -0800 (PST)
Received: from Carl-MBP.ecbaldwin.net ([2601:282:8001:ffba:2d88:37cd:24b:c31f])
        by smtp.gmail.com with ESMTPSA id e185sm8987114itb.27.2017.12.25.22.02.31
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 25 Dec 2017 22:02:32 -0800 (PST)
Date:   Mon, 25 Dec 2017 23:02:30 -0700
From:   Carl Baldwin <carl@ecbaldwin.net>
To:     Jacob Keller <jacob.keller@gmail.com>
Cc:     Theodore Ts'o <tytso@mit.edu>,
        Git Mailing List <git@vger.kernel.org>
Subject: Re: Bring together merge and rebase
Message-ID: <20171226060229.GB18783@Carl-MBP.ecbaldwin.net>
References: <CALiLy7pBvyqA+NjTZHOK9t0AFGYbwqwRVD3sZjUg0ZLx5y1h3A@mail.gmail.com>
 <20171225035215.GC1257@thunk.org>
 <20171226011638.GA16552@Carl-MBP.ecbaldwin.net>
 <CA+P7+xpj4o+N3uy2ea7DM-Y0oY_scayUARZMWP5QCwJEG02bZg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CA+P7+xpj4o+N3uy2ea7DM-Y0oY_scayUARZMWP5QCwJEG02bZg@mail.gmail.com>
User-Agent: Mutt/1.9.2 (2017-12-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Dec 25, 2017 at 05:47:55PM -0800, Jacob Keller wrote:
> On Mon, Dec 25, 2017 at 5:16 PM, Carl Baldwin <carl@ecbaldwin.net> wrote:
> > Anyway, now I am compelled to use github which is also a fine tool and I
> > appreciate all of the work that has gone into it. About 80% of the time,
> > I rebase and force push to my branch to update a pull request. I've come
> > to like the end product of the rebase workflow. However, github doesn't
> > excel at this approach. For one, it doesn't preserve older revisions
> > which were already reviewed which makes it is difficult for reviewers to
> > pick up where they left off the last time. If it preserved them, as
> > gerrit does, the reviewer can compare a new revision with the most
> > recent older revision they reviewed to see just what has been addressed
> > since then.
> 
> A bit of a tangent here, but a thought I didn't wanna lose: In the
> general case where a patch was rebased and the original parent pointer
> was changed, it is actually quite hard to show a diff of what changed
> between versions.
>
> The best I've found is to do something like a 4-way --cc merge diff,
> which mostly works, but has a few awkward cases, and ends up usually
> showing double ++ and -- notation.
>
> Just something I've thought about a fair bit, trying to come up with
> some good way to show "what changed between A1 and A2, but ignore all
> changes between parent P1 and P2 which you don't care that much about
> in this context.

I ran into this all the time with gerrit. I wrote a script that you'd
run on a working copy (with no local changes). I'd fetch and checkout
the latest patchset that I want to review(say, for example, its patchset
5) from gerrit. Then, say I wanted to compare it with patch set 3 which
has a different parent. I'd run this from the top level of my working
copy.

    compare-to-previous-patchset 3

It would fetch patch set 3 from gerrit, rebase it to the same parent as
the current patch set on a detached HEAD and then git diff it with the
current patch set. If there were conflicts, it would just commit the
conflict markers to the commit. There is no attempt to resolve the
conflicts. The script was crude but it helped me out many times and it
was nice to be able to review how conflicts were resolved when those
came up.

Carl

PS In case you're curious, here's my script...

#!/bin/bash

remote=gerrit
previous_patchset=$1; shift

# Assumes we're sitting on the latest patch set.
new_patch_set_id=$(git rev-parse HEAD)

branch=$(git branch | awk '/^\*/ {print$2}')
[ "$branch" = "(no" ] && branch=

# set user, host, port, and project from git config
eval $(echo "$(git config remote.$remote.url)" |
       sed 's,ssh://\(.*\)@\(.*\):\([[:digit:]]*\)/\(.*\).git,user=\1 host=\2 p<

gerrit() {
    ssh $user@$host -p $port gerrit ${1+"$@"}
}

# Grabs a bunch of information from gerrit about the current patch
eval $(gerrit query --current-patch-set $new_patch_set_id |
    awk '
        BEGIN {mode="main"}
        / currentPatchSet:/ { mode="currentPatchSet" }
        / ref:/ { printf "new_patch_ref=%s\n", $2 }
        / number:/ {
            if (mode=="main") {
                printf "review_num=%s\n", $2
            }
            if (mode=="currentPatchSet") {
                printf "new_patchset=%s\n", $2
            }
        }
    ')

# Fetch the old patch set
old_patch_ref=${new_patch_ref%$new_patchset}$previous_patchset
git fetch $remote $old_patch_ref && git checkout FETCH_HEAD

# Rebase the old patch set to the parent of the new patch set.
if ! git rebase HEAD^ --onto ${new_patch_set_id}^
then
    git diff --name-only --diff-filter=U -z | xargs -0 git add
    git rebase --continue
fi

previous_patchset_rebased=$(git rev-parse HEAD)

# Go back to the new patch set and diff it against the rebased old one.
if [ "$branch" ]
then
    git checkout $branch
else
    git checkout $new_patch_set_id
fi
git diff $previous_patchset_rebased
