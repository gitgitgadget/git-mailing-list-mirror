Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	FROM_EXCESS_BASE64,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 57B361F45F
	for <e@80x24.org>; Wed,  8 May 2019 20:11:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726945AbfEHULX (ORCPT <rfc822;e@80x24.org>);
        Wed, 8 May 2019 16:11:23 -0400
Received: from mail-wm1-f66.google.com ([209.85.128.66]:50738 "EHLO
        mail-wm1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726709AbfEHULX (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 8 May 2019 16:11:23 -0400
Received: by mail-wm1-f66.google.com with SMTP id p21so204201wmc.0
        for <git@vger.kernel.org>; Wed, 08 May 2019 13:11:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:references:user-agent:in-reply-to:date
         :message-id:mime-version:content-transfer-encoding;
        bh=5OVBl49YTth8Ltj4n1aAFSYLPCEZI4N3ddDPkbjnm6A=;
        b=hTW3Z/cMRgfQGunClwB2cfPYlb4I3Ia0rzA2ig9Gk2WFTV7rvuIUvDFg3CaqFn/TDg
         r7mr9Dd1VQpw4VGROjSh37H4kWQE+fApRJQ7plLXGMEE77FT/eF6sA/vzaXFPs6L0+i1
         Fi2klAHXd+CCnjTwSuI+xiJKC1dAynFt2dfh8ZRCsaAS9nGwFgw9figTM+vqnGRmX2qD
         vNiFlOX0Y9S2ViTGB8RTZO8QWeJNGDAVS+TFQHWlMwTPrrZOgfLvtCMBOVdvzrIiZ6u5
         FVVaAsTB29OKAh5ybpNwK9Cf9xciQZIJYSO53/+uM++//emkoqjkAZzIX9m2xMGlOpNr
         uOdg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:references:user-agent
         :in-reply-to:date:message-id:mime-version:content-transfer-encoding;
        bh=5OVBl49YTth8Ltj4n1aAFSYLPCEZI4N3ddDPkbjnm6A=;
        b=dVR0bphKfXFYi8IyrgVA613vtBVA3VbQntp6y6yIh8iaGTBvmcopHq2392et+DLt+W
         R1V2leEm1304FyODdrvpmv6dd6M0GFDKB2ygWfRINuvzIRcpQDzzip7zlZTeAD+juROf
         uCyPhddSfA40hRxr3zu4HSyS6f0PObgnRXwkhFZ/uHM7xVCNeSiA7AoiUBcOJcWBVX/Q
         ahsTMApbfX1hZG692AWlltk13Oo/IqI/Vw4ZwRRVO/VNQdlIrDCdKrnFdBII/qK6dSpt
         OEi9fzywmv6bMmNgtbbr+N71zZje+XVSmuL9GPhmHsigI82k8P9nlQqF9Tw7BGtJXwu4
         K+kg==
X-Gm-Message-State: APjAAAXooeTbqCwBNkrW6vaXredxzyzc+0pQ5ZB16RtFrf0nbDN11vgO
        5vsug09kAiUPh4plQYwMAVYedWGDiaM=
X-Google-Smtp-Source: APXvYqytGNdyNXb0Yos0lhoB6XFgayDo+6Uw7puMn6hFIwTk9HSK0HEZ2FAh2Xzu+cafHHqmw4pz1A==
X-Received: by 2002:a7b:cc12:: with SMTP id f18mr85361wmh.40.1557346280134;
        Wed, 08 May 2019 13:11:20 -0700 (PDT)
Received: from evledraar (dhcp-077-251-215-224.chello.nl. [77.251.215.224])
        by smtp.gmail.com with ESMTPSA id c9sm12078546wrv.62.2019.05.08.13.11.18
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 08 May 2019 13:11:19 -0700 (PDT)
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     Derrick Stolee <stolee@gmail.com>
Cc:     SZEDER =?utf-8?Q?G=C3=A1bor?= <szeder.dev@gmail.com>,
        Derrick Stolee via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org, peff@peff.net, git@jeffhostetler.com,
        jrnieder@google.com, steadmon@google.com,
        Junio C Hamano <gitster@pobox.com>,
        Derrick Stolee <dstolee@microsoft.com>
Subject: Re: [PATCH 12/17] Documentation: describe split commit-graphs
References: <pull.184.git.gitgitgadget@gmail.com>
        <7bbe8d9150a623ea684c94d129eda1607dd32a79.1557330827.git.gitgitgadget@gmail.com>
        <20190508172029.GP14763@szeder.dev>
        <d5ef1bcb-a910-295f-fc95-e461d34f3883@gmail.com>
User-agent: Debian GNU/Linux buster/sid; Emacs 26.1; mu4e 1.1.0
In-reply-to: <d5ef1bcb-a910-295f-fc95-e461d34f3883@gmail.com>
Date:   Wed, 08 May 2019 22:11:17 +0200
Message-ID: <87pnoshfkq.fsf@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Wed, May 08 2019, Derrick Stolee wrote:

> On 5/8/2019 1:20 PM, SZEDER G=C3=A1bor wrote:
>> On Wed, May 08, 2019 at 08:53:57AM -0700, Derrick Stolee via GitGitGadge=
t wrote:
>>> From: Derrick Stolee <dstolee@microsoft.com>
>> Consider the following sequence of events:
>>
>>   1. There are three commit-graph files in the repository.
>>
>>   2. A git process opens the base commit-graph and commit-graph-1 for
>>      reading.  It doesn't yet open commit-graph-2, because the (for
>>      arguments sake not very fair) scheduler takes the CPU away.
>>
>>   3. Meanwhile, a 'git fetch', well, fetches from a remote, and
>>      upon noticing that it got a lot of commits it decides to collapse
>>      commit-graph-1 and -2 and the new commits, writing a brand new
>>      commit-graph-1.
>>
>>   4. A second fetch fetches from a second remote, and writes
>>      commit-graph-2 (no collapsing this time).
>>
>>   5. Now the crappy scheduler finally decides that it's time to wake
>>      up the waiting git process from step 2, which then finds the new
>>      commit-graph-2 file and opens it for reading.
>>
>>   6. At this point this poor git process has file handles for:
>>
>>      - the base commit-graph file, which is unchanged.
>>
>>      - the old commit-graph-1 which has since been replaced, and does
>>        not yet contain info about the old commit-graph-2 or the
>>        commits received in the first fetch.
>>
>>      - the new commit-graph-2, containing info only about commits
>>        received in the second fetch, and whose parents' graph
>>        positions point either to the base commitg-graph (good, since
>>        unchanged) or to the new commit-graph-1 (uh-oh).
>>
>> What happens next?  If this process tries to access the parent of a
>> commit from commit-graph-2, and the metadata about this parent is in
>> the new commit-graph-1, then I expect all kinds of weird bugs.
>>
>> But will a git process ever try to access a commit that didn't yet
>> existed in the repository when it started opening the commit-graph
>> files?
>
> I'll ignore the improbability of this turn of events (two writes happening
> during the span of trying to read two files) and focus on the fact that
> we can prevent issues here using the 4th TODO item in my cover letter:

FWIW the sort of scenario SZEDER is describing is something I deal with
in production a lot. It doesn't require an unfair scheduler, just that
you have differently nice(1)'d processes accessing the same repo.

So if you have batch "cron" processes their IO scheduling follows their
nice(1) scheduling. It's not atypical to e.g. have some background
thingy sit for seconds or even minutes on an I/O syscall while the
kernel decides everyone else has right of way, since you nice'd that not
caring if it finishes in 10 seconds or 10 hours.

>  4. It would be helpful to add a new optional chunk that contains the
>     trailing hash for the lower level of the commit-graph stack. This chu=
nk
>     would only be for the commit-graph-N files, and would provide a simple
>     way to check that the stack is valid on read, in case we are still
>     worried about other processes reading/writing in the wrong order.
>
> If we have this chunk -- you have convinced me that we need it -- then we
> could ignore the "new" commit-graph-2 because its base graph hash does not
> match. We can continue without dying because we can always parse the "mis=
sing"
> commits from the packs.

Having read the actual code for this & what the format will look like
(last time I didn't have that context[1]) I really don't get why we
don't save ourselves a lot of trouble and do away with this "N" in the
filename idea from the start.

It's just a slight change to the iteration in
prepare_commit_graph_one().

Instead of looping through files N at a time we'd have a discovery step
where we'd need to open() all the files, see which ones say "my parent
hash hash X", and then create a list of those hashes in order to read a
bunch of commit-graph-<HASH> files.

Is that a bit painful? Sure, but way less painful than dealing with the
caveats I'd mentioned in [1] and SZEDER details here.

And the obvious thing would be to save ourselves most of that work every
time we read by writing a .git/objects/commit-graphs/info on
"commit-graph write", which would be the <HASH> of the end of the
"latest" chain. We could also have some side-index listing the whole
"current" chain in order (but I'm more paranoid about locking/updates to
such a thing, maybe we could put it in the last file in a new chunk
....).

If we didn't have such side-indexes then the way the current loading
works it would need to traverse the files back to front, and *then* load
them front to back (as it does now), so that's a slight pain,
obviously. But not a big deal.

With commit-graph-<HASH> all these unlink() race conditions go away,
partial reads due to concurrent graph writing becomes a non-issue (we'd
just leave the old files, "gc" deals with them later..), no need to
carefully fsync() files/dirs etc as we need to carefully juggle N and
N+1 files.

It also becomes easy to "chain" graphs across repos e.g. via
alternates. Say in the scenario github/gitlab have where they have a
"main" repo and other objects on another delta island.

In that case the repo would have a local "tip" file with the last link
in its chain, some of which would then refer back to <HASHes> in other
"parent" alternates.

As long as such a setup has a "gc" process that's not overly eager about
pruning old stuff and considers that constellation of repos as a whole
that should just work. You can freely optimize and rewrite graphs across
repos, just be careful about unlinking old stuff.

I don't see how it would work with commit-graph-N without a *lot* of
painful orchestration (where e.g. you *must* guarantee that the parent
repo ends in N, all child repos start at N+1).

> This allows incremental writes without updating the file format.

FWIW this is some of what I was talking about in [2]. In
ds/commit-graph-format-v2 I had feedback to the effect[3] that the
particular way in which you proposed to update the format (changing the
header) wouldn't be worth it, since old clients dealt with it so badly.

But as noted in [3] I see zero reason for why we can't update the
existing format, we just add new chunks. That allows us to add any new
data in backwards-compatible ways.

I see nothing wrong with solution that has split files in principle,
just with the currently proposed commit-graph-N way of doing that.

I just wonder if we're looking at a "Y" solution to an "X-Y" problem
where "X" was unduly dismissed. If updating the format was a non-issue
(which seems to me to be the case), what then?

I imagine we'd still have just a "commit-graph" file, to write a new one
we'd "cp" that one, then munge that existing file to write something new
to the and and "mv" it in-place. It seems to me a (sane) split-file plan
is better, but I'm not in your head, maybe it was a much better for
reasons I'm not imagining before I apparently talked you out of changing
the format itself :)

1. https://public-inbox.org/git/87bm0jirjj.fsf@evledraar.gmail.com/
2. https://public-inbox.org/git/87r298hhlc.fsf@evledraar.gmail.com/
3. https://public-inbox.org/git/87lfzprkfc.fsf@evledraar.gmail.com/
