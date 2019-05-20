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
	by dcvr.yhbt.net (Postfix) with ESMTP id 05C971F461
	for <e@80x24.org>; Mon, 20 May 2019 10:08:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731342AbfETKI2 (ORCPT <rfc822;e@80x24.org>);
        Mon, 20 May 2019 06:08:28 -0400
Received: from mail-ed1-f66.google.com ([209.85.208.66]:42302 "EHLO
        mail-ed1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729834AbfETKI1 (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 20 May 2019 06:08:27 -0400
Received: by mail-ed1-f66.google.com with SMTP id l25so22956734eda.9
        for <git@vger.kernel.org>; Mon, 20 May 2019 03:08:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:references:user-agent:in-reply-to:date
         :message-id:mime-version;
        bh=UBgqgk0Qwu02ro6320KOjtBbitzbh5UliYcQZd39wVk=;
        b=tcckD2IQwa+y32+woh7epXMLE0tw9EpEEMOxDmu1no24gfrN08e6TRnS+AiJgDD08u
         ZvIBAfWiadl27DLj1ZD8ykcBaR4Ey9z5sxc8XN/tSR/gf6egMOkoctdhoswLBpEuGs6l
         seMC7oxX9VB5UJNJZNtAUOKahdSAWDg7gzs2ie18TzINIV+wSGYCa6phgqeXJZIhN9nk
         YZAEX1MzKLbZiBlq9A/kzYFKQxP61G32rNndrqmBgvRtNuZq2sZkb5me/DaiawUacQ0u
         ts770L0T+B+zwlJ0pF4sCMwv2otANtFUPIU//xALFw1flqD/xW7sCfyoQsgX+im56tmM
         d4Kw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:references:user-agent
         :in-reply-to:date:message-id:mime-version;
        bh=UBgqgk0Qwu02ro6320KOjtBbitzbh5UliYcQZd39wVk=;
        b=k6sLg68pGUHOXp6NgZ7zraawHM4QyY2TzfI57Tb4EME6PosqVmlSdNu9sCs3R5ASja
         r54gx/1PQVpYhADFZQfJ+m5R638XRbjqNrIgMwC5ndJpsIaPq5n62IXJye1+hwdHryjb
         gIScYJR1/2/Ii307aJCoJb04rCp/W6f1+F+514WEcFg8+ToNcRNvXshjDwd0TJPJTWrI
         ojPwGeyZ677WOG0fxT7Qk7ZYx8+HSsf+OSltxhaNa1kDmKeVHoggVj5wOhm235kaK6+a
         zgTiB/jU5aEDQjBnWEyiaENjKjkZc8DHN79m8H2BHw5LSNaVRBDnH2knBWnTNaUkww6D
         LcdA==
X-Gm-Message-State: APjAAAWCK0r2WYLDJupO6erX9j8mkTvXiRZC8GswtCBL5OIUqK7l0pVn
        /VuReS3BjP7aNv+aYoBA5uTB5Mgr
X-Google-Smtp-Source: APXvYqzcJmoIWura/R05a0TO80bXmiOIYpEeC5YUy6Iv+rwVtYFmi9a9m10uhgaencpz5XniFAZt4A==
X-Received: by 2002:a17:906:260b:: with SMTP id h11mr52585304ejc.293.1558346905520;
        Mon, 20 May 2019 03:08:25 -0700 (PDT)
Received: from evledraar (dhcp-077-251-215-224.chello.nl. [77.251.215.224])
        by smtp.gmail.com with ESMTPSA id q24sm1428612ejr.35.2019.05.20.03.08.24
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 20 May 2019 03:08:24 -0700 (PDT)
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     Jakub Narebski <jnareb@gmail.com>
Cc:     "Eric S. Raymond" <esr@thyrsus.com>,
        Derrick Stolee <stolee@gmail.com>, git@vger.kernel.org
Subject: Re: Finer timestamps and serialization in git
References: <20190515191605.21D394703049@snark.thyrsus.com> <ae62476c-1642-0b9c-86a5-c2c8cddf9dfb@gmail.com> <20190515233230.GA124956@thyrsus.com> <87woiqvic4.fsf@evledraar.gmail.com> <86woimox24.fsf@gmail.com> <20190520004559.GA41412@thyrsus.com> <86r28tpikt.fsf@gmail.com>
User-agent: Debian GNU/Linux buster/sid; Emacs 26.1; mu4e 1.1.0
In-reply-to: <86r28tpikt.fsf@gmail.com>
Date:   Mon, 20 May 2019 12:08:24 +0200
Message-ID: <87k1elv3on.fsf@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Mon, May 20 2019, Jakub Narebski wrote:

> "Eric S. Raymond" <esr@thyrsus.com> writes:
>> Jakub Narebski <jnareb@gmail.com>:
>
>>> As far as I understand it this would slow down receiving new commits
>>> tremendously.  Currently great care is taken to not have to parse the
>>> commit object during fetch or push if it is not necessary (thanks to
>>> things such as reachability bitmaps, see e.g. [1]).
>>>
>>> With this restriction you would need to parse each commit to get at
>>> commit timestamp and committer, check if the committer+timestamp is
>>> unique, and bump it if it is not.
>>
>> So, I'd want to measure that rather than simply assuming it's a blocker.
>> Clocks are very cheap these days.
>
> Clocks may be cheap, but parsing is not.
>
> You can receive new commits in the repository by creating them, and from
> other repository (via push or fetch).  In the second case you often get
> many commits at once.
>
> In [1] it is described how using "bitmap index" you can avoid parsing
> commits when deciding which objects to send to the client; they can be
> directly copied to the client (added to the packfile that is sent to
> client).  Thanks to this reachability bitmap (bit vector) the time to
> clone Linux repository decreased from 57 seconds to 1.6 seconds.
>
> It is not a direct correspondence, but there most probably would be the
> same problem with requiring fractional timestamp+committer identity to
> be unique on the receiving side.
>
> [1]: https://githubengineering.com/counting-objects/

We're in violent agreement about the general viability of ESR's proposed
plan, but just a side-note on this point. I don't think this is
right. I.e. I don't think a hypothetical version of git that guarantees
monotonically increasing timestamps will be slow in *this* regard.

For accepting pushes we already unpack all the commits / content / hash
it to perform fsck checks, which is why screwing with the commit
timestamp will fail on push:
https://public-inbox.org/git/87zhnnv0b8.fsf@evledraar.gmail.com/

Same on the client with fetches, although transfer.fsckObjects isn't on
there we do most of the work anyway for hashing & basic validation
purposes.

The bitmaps wouldn't be affected because they're computed after-the-fact
on the basis of reachability, whereas validating increasing timestamps
for a single branch is cheap, you just look at each A..B push
incrementally and see if the timestamps are increasing and past A's
parent.

It's trickier if you're trying to make the same guarantee for *all* ref
updates in a given repo (and locking caveats etc. have been discussed
elsewhere), but not *that* much of a PITA.

We'd need to compare "new" packs/loose objects against the new push, and
an obvious shortcut in such a schema if you required a global lock
anyway would be for the process taking the lock to write out "this is
the current max timestamp" when finished.

In *this* case that's a long way down the journey into crazytown :)

But it is intertesting to think about in general, because with e.g. the
commit-graph we have a set of commits that are "optimized" in some
side-index, so it becomes useful for many algorithms to be able to ask
"what is the current set of unoptimized commits".

Once you have that, and can keep the size of it down with "gc" many
algorithms that require graph traversal become possible, because your
O(n) of needing to consider the "n" unoptimized commits is small enough
v.s. the bulk of "optimized" commits as to not matter.


>>> Also, bumping timestamp means that the commit changed, means that its
>>> contents-based ID changed, means that all commits that follow it needs
>>> to have its contents changed...  And now you need to rewrite many
>>> commits.
>>
>> What "commits that follow it?" By hypothesis, the incoming commit's
>> timestamp is bumped (if it's bumped) when it's first added to a branch
>> or branches, before there are following commits in the DAG.
>
> Errr... the main problem is with distributed nature of Git, i.e. when
> two repositories create different commits with the same
> committer+timestamp value.  You receive commits on fetch or push, and
> you receive many commits at once.
>
> Say you have two repositories, and the history looks like this:
>
>  repo A:   1<---2<---a<---x<---c<---d      <- master
>
>  repo B:   1<---2<---X<---3<---4           <- master
>
> When you push from repo A to repo B, or fetch in repo B from repo A you
> would get the following DAG of revisions
>
>  repo B:   1<---2<---X<---3<---4           <- master
>                  \
>                   \--a<---x<---c<---d      <- repo_A/master
>
> Now let's assume that commits X and x have the came committer and the
> same fractional timestamp, while being different commits.  Then you
> would need to bump timestamp of 'x', changing the commit.  This means
> that 'c' needs to be rewritten too, and 'd' also:
>
>  repo B:   1<---2<---X<---3<---4           <- master
>                  \
>                   \--a<---x'<--c'<--d'     <- repo_A/master
>
> And now for the final nail in the coffing of the Bazaar-esque idea of
> changing commits on arrival.  Say that repository A created new commits,
> and pushed them to B.  You would need to rewrite all future commits from
> this repository too, and you would always fetch all commits starting
> from the first "bumped"
>
>  repo A:   1<---2<---a<---x<---c<---d<---E   <- master
>
> transfer of [<---x<---c<---d<---E], instead of [<--E], because 'x', 'c',
> and 'd' are missing in repo B.
>
>  repo B:   1<---2<---X<---3<---4             <- master
>                  \
>                   \--a<---x'<--c'<--d'<--E'  <- repo_A/master
>
> And there is yet another problem.  Let's assume that repo B created some
> history on top of bump-rewritten commits:
>
>  repo B:   1<---2<---X<---3<---4             <- master
>                  \
>                   \--a<---x'<--c'<--d'<--E'  <- repo_A/master
>                                 \
>                                  \--5        <- next
>
> Then if in repo A you fetch from repo B (remember, in Git there is no
> concept of central repository), you would get the following history
>
>                   /--X'<--3'<--4'            <- repo_B/master
>                  /
>  repo A:   1<---2<---a<---x<---c<---d<---E   <- master
>                      \
>                       \---x'<--c'
>                                 \
>                                  \--5        <- repo_B/master
>
> (because 'X' is now incoming, it needs to be "bumped", therefore
> changing 3' and 4').
>
> The history without all this rewriting looks like this:
>
>                   /--X<---3<---4'            <- repo_B/master
>                  /
>  repo A:   1<---2<---a<---x<---c<---d<---E   <- master
>                                 \
>                                  \--5        <- repo_B/master
>
> Notice the difference?
>
>>>    And you also break the assumptions that the same commits have
>>> the same contents (including date) and the same ID in different
>>> repositories (some of which may include additional branches, some of
>>> which may have been part of network of related repositories, etc.).
>
> See repo A and repo B in above example.
>
>> Wait...unless I completely misunderstand the hash-chain model, doesn't the
>> hash of a commit depend on the hashes of its parents?  If that's the case,
>> commits cannot have portable hashes. If it's not, please correct me.
>>
>> But if it's not, how does your first objection make sense?
>
> Hash of a commit depend in hashes of its parents (Merkle tree). That is
> why signing a commit (or a tag pointing to the commit) signs a whole
> history of a commit.
>
>>>> You don't need a daemon now to write commits to a repository. You can
>>>> just add stuff to the object store, and then later flip the SHA-1 on a
>>>> reference, we lock those indivdiual references, but this sort of thing
>>>> would require a global write lock. This would introduce huge concurrency
>>>> caveats that are non-issues now.
>>>>
>>>> Dumb clients matter. Now you can e.g. have two libgit2 processes writing
>>>> to ref A and B respectively in the same repo, and they never have to
>>>> know about each other or care about IPC.
>>
>> How do they know they're not writing to the same ref?  What keeps
>> *that* operation atomic?
>
> Because different refs are stored in different files (at least for
> "live" refs that are stores in loose ref format).  The lock is taken on
> ref (to update ref and its reflog in sync), there is no need to take
> global lock on all refs.
>
>>> You do realize that dates may not be monotonic (because of imperfections
>>> in clock synchronization), thus the fact that the date is different from
>>> parent does not mean that is different from ancestor.
>>
>> Good point. That means the O(log2 n) version of the check has to be done
>> all the time.  Unfortunate.
>
> Especially with around 1 million of commits (Linux kernel, Chromium,
> AOSP), or even 3M commits (MS Windows repository).
>
>>>>> That's the simple case. The complicated case is checking for date
>>>>> collisions on *other* branches. But there are ways to make that fast,
>>>>> too. There's a very obvious one involving a presort that is is O(log2
>>>>> n) in the number of commits.
>>>
>>> I don't think performance hit you would get would be acceptable.
>>
>> Again, it's bad practice to assume rather than measure. Human intuitions
>> about this sort of thing are notoriously unreliable.
>
> Techniques created to handle very large repositories (with respect to
> number of commits) that make it possible for Git to avoid parsing commit
> objects, namely bitmap index (for 'git fetch'/'clone') and serialized
> commit graph (for 'git log') lead to _significant_ performance
> improvements.
>
> The performance changes from "waiting for Git to finish" to "done in the
> blink of eye" (well, almost).
>
>>>>> Excuse me, but your premise is incorrect.  A git DAG isn't just "any" DAG.
>>>>> The presence of timestamps makes a total ordering possible.
>>>>>
>>>>> (I was a theoretical mathematician in a former life. This is all very
>>>>> familiar ground to me.)
>>>
>>> Maybe in theory, when all clock are synchronized.
>>
>> My assertion does not depend on synchronized clocks, because it doesn't have to.
>>
>> If the timestamps in your repo are unique, there *is* a total ordering -
>> by timestamp. What you don't get is guaranteed consistency with the
>> topo ordering - that is you get no guarantee that a child's timestamp
>> is greater than its parents'. That really would require a common
>> timebase.
>>
>> But I don't need that stronger property, because the purpose of
>> totally ordering the repo is to guarantee the uniqueness of action
>> stamps.  For that, all I need is to be able to generate a unique cookie
>> for each commit that can be inserted in its action stamp.
>
> For cookie to be unique among all forks / clones of the same repository
> you need either centralized naming server, or for the cookie to be based
> on contents of the commit (i.e. be a hash function).
>
>>                                                          For my use cases
>> that cookie should *not* be a hash, because hashes always break N years
>> down.  It should be an eternally stable product of the commit metadata.
>
> Well, the idea for SHA-1 <--> NewHash == SHA-256 transition is to avoid
> having a flag day, and providing full interoperability between
> repositories and Git installations using the old hash ad using new
> hash^1.  This will be done internally by using SHA-1 <--> SHA-256
> mapping.  So after the transition all you need is to publish this
> mapping somewhere, be it with Internet Archive or Software Heritage.
> Problem solved.
>
> P.S. Could you explain to me how one can use action stamp, e.g.
> <esr@thyrsus.com!2019-05-15T20:01:15.473209800Z>, to quickly find the
> commit it refers to?  With SHA-1 id you have either filesystem pathname
> or the index file for pack to find it _fast_.
>
> Footnotes:
> ----------
> 1. That is why where would be no "major format break", thus no place for
>    incompatibile format changes.
>
> Best,
