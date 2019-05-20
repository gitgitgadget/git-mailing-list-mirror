Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id EEC9B1F461
	for <e@80x24.org>; Mon, 20 May 2019 09:43:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731427AbfETJnV (ORCPT <rfc822;e@80x24.org>);
        Mon, 20 May 2019 05:43:21 -0400
Received: from mail-wr1-f65.google.com ([209.85.221.65]:33295 "EHLO
        mail-wr1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731393AbfETJnU (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 20 May 2019 05:43:20 -0400
Received: by mail-wr1-f65.google.com with SMTP id d9so825931wrx.0
        for <git@vger.kernel.org>; Mon, 20 May 2019 02:43:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version:content-transfer-encoding;
        bh=f1fFrcrejwp06n/AbWCplMOIUws42c3G0FoPZdEFUSU=;
        b=XSdC7dqAnxqh6r/JjJuIgKWE3+yOUL2sVPs6mgD+1ITqpd+qlmB1wRTIPajSeJ1TU6
         VCPIzukRuKZlOeT7h2jkkYHiWukUxqa2JAgHsm4kI9+sHz0lyJtkpkxBbwfuWLdgHDy9
         ToIVc2LjJdF/LW6kp0rLPOBrcYpMmoWjMSXRL/OkExQCGoc0aDiXpV7Hskkxg0KRF3Li
         A1dpE/kmj5Ra7QywINmmgDmfkf5wDwpDTly9JFMKOd3OCphlaVxs9LRIkD3R68K9O+Ro
         9xmdUxgKhjgggZdSEHYcl8CCVd1cP/nlud5GOBiUVRomJin8w/LQfWECoL3RxbeXFK2y
         D3WA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:references:date:in-reply-to
         :message-id:user-agent:mime-version:content-transfer-encoding;
        bh=f1fFrcrejwp06n/AbWCplMOIUws42c3G0FoPZdEFUSU=;
        b=W2vHpEsGlYB4Vf8b6PqzwKmc28EEvEFkJZJZ/pwBBdRG/6hQx4T+XiFx0cCuMkw8Nq
         7CR7eSH9FPNpwAT9k2oSqrxrLezL9kdPniqpCLq+OptUabQB+A6AJfc3Kmw58jazdmCe
         xVrxXQuZgSFgkqPDrTbRB4ugGHi496xnR5Vtq6IY5QcdxnNx5ewG6C1IBs/cWhO04eg6
         5Kk4isZqf08KNKVS29TjMe4CSvu1JMc/3YnjL0iYitfMm1XfGu+OiGZtSwgts9BCgYcp
         v0OztFKRDMmjffjCu3sFDAsFhkhVZrT+DZZIxxdOCs0HupGbN7a8fhRhmewKF0IXpIEX
         8Wfw==
X-Gm-Message-State: APjAAAWKjIj52GN9PBmTNJ+GLxr9eTS456ZnWC4rLvYBtd09llwMeMXb
        3+cttO/qNNA9pEZAtJlLfrxEABLDovw=
X-Google-Smtp-Source: APXvYqxkDXuEp7TxTBkb+bzozvG9VJABkkZfa7Qe4rQ/yY3PSghjA1dfCDciSYiaoiqVJPCwhTo80g==
X-Received: by 2002:adf:ec0f:: with SMTP id x15mr44393433wrn.120.1558345397766;
        Mon, 20 May 2019 02:43:17 -0700 (PDT)
Received: from Laptop-Acer-Aspire-F15 (egp40.neoplus.adsl.tpnet.pl. [83.21.79.40])
        by smtp.gmail.com with ESMTPSA id a10sm19306919wrm.94.2019.05.20.02.43.16
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 20 May 2019 02:43:16 -0700 (PDT)
From:   Jakub Narebski <jnareb@gmail.com>
To:     "Eric S. Raymond" <esr@thyrsus.com>
Cc:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>,
        Derrick Stolee <stolee@gmail.com>, git@vger.kernel.org
Subject: Re: Finer timestamps and serialization in git
References: <20190515191605.21D394703049@snark.thyrsus.com>
        <ae62476c-1642-0b9c-86a5-c2c8cddf9dfb@gmail.com>
        <20190515233230.GA124956@thyrsus.com>
        <87woiqvic4.fsf@evledraar.gmail.com> <86woimox24.fsf@gmail.com>
        <20190520004559.GA41412@thyrsus.com>
Date:   Mon, 20 May 2019 11:43:14 +0200
In-Reply-To: <20190520004559.GA41412@thyrsus.com> (Eric S. Raymond's message
        of "Sun, 19 May 2019 20:45:59 -0400")
Message-ID: <86r28tpikt.fsf@gmail.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.2 (windows-nt)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

"Eric S. Raymond" <esr@thyrsus.com> writes:
> Jakub Narebski <jnareb@gmail.com>:

>> As far as I understand it this would slow down receiving new commits
>> tremendously.  Currently great care is taken to not have to parse the
>> commit object during fetch or push if it is not necessary (thanks to
>> things such as reachability bitmaps, see e.g. [1]).
>>=20
>> With this restriction you would need to parse each commit to get at
>> commit timestamp and committer, check if the committer+timestamp is
>> unique, and bump it if it is not.
>
> So, I'd want to measure that rather than simply assuming it's a blocker.
> Clocks are very cheap these days.

Clocks may be cheap, but parsing is not.

You can receive new commits in the repository by creating them, and from
other repository (via push or fetch).  In the second case you often get
many commits at once.

In [1] it is described how using "bitmap index" you can avoid parsing
commits when deciding which objects to send to the client; they can be
directly copied to the client (added to the packfile that is sent to
client).  Thanks to this reachability bitmap (bit vector) the time to
clone Linux repository decreased from 57 seconds to 1.6 seconds.

It is not a direct correspondence, but there most probably would be the
same problem with requiring fractional timestamp+committer identity to
be unique on the receiving side.

[1]: https://githubengineering.com/counting-objects/

>> Also, bumping timestamp means that the commit changed, means that its
>> contents-based ID changed, means that all commits that follow it needs
>> to have its contents changed...  And now you need to rewrite many
>> commits.
>
> What "commits that follow it?" By hypothesis, the incoming commit's
> timestamp is bumped (if it's bumped) when it's first added to a branch
> or branches, before there are following commits in the DAG.

Errr... the main problem is with distributed nature of Git, i.e. when
two repositories create different commits with the same
committer+timestamp value.  You receive commits on fetch or push, and
you receive many commits at once.

Say you have two repositories, and the history looks like this:

 repo A:   1<---2<---a<---x<---c<---d      <- master

 repo B:   1<---2<---X<---3<---4           <- master

When you push from repo A to repo B, or fetch in repo B from repo A you
would get the following DAG of revisions

 repo B:   1<---2<---X<---3<---4           <- master
                 \
                  \--a<---x<---c<---d      <- repo_A/master

Now let's assume that commits X and x have the came committer and the
same fractional timestamp, while being different commits.  Then you
would need to bump timestamp of 'x', changing the commit.  This means
that 'c' needs to be rewritten too, and 'd' also:

 repo B:   1<---2<---X<---3<---4           <- master
                 \
                  \--a<---x'<--c'<--d'     <- repo_A/master

And now for the final nail in the coffing of the Bazaar-esque idea of
changing commits on arrival.  Say that repository A created new commits,
and pushed them to B.  You would need to rewrite all future commits from
this repository too, and you would always fetch all commits starting
from the first "bumped"

 repo A:   1<---2<---a<---x<---c<---d<---E   <- master

transfer of [<---x<---c<---d<---E], instead of [<--E], because 'x', 'c',
and 'd' are missing in repo B.

 repo B:   1<---2<---X<---3<---4             <- master
                 \
                  \--a<---x'<--c'<--d'<--E'  <- repo_A/master

And there is yet another problem.  Let's assume that repo B created some
history on top of bump-rewritten commits:

 repo B:   1<---2<---X<---3<---4             <- master
                 \
                  \--a<---x'<--c'<--d'<--E'  <- repo_A/master
                                \
                                 \--5        <- next

Then if in repo A you fetch from repo B (remember, in Git there is no
concept of central repository), you would get the following history

                  /--X'<--3'<--4'            <- repo_B/master
                 /
 repo A:   1<---2<---a<---x<---c<---d<---E   <- master
                     \
                      \---x'<--c'
                                \
                                 \--5        <- repo_B/master

(because 'X' is now incoming, it needs to be "bumped", therefore
changing 3' and 4').

The history without all this rewriting looks like this:

                  /--X<---3<---4'            <- repo_B/master
                 /=20=20=20=20=20=20=20=20=20=20=20
 repo A:   1<---2<---a<---x<---c<---d<---E   <- master
                                \
                                 \--5        <- repo_B/master

Notice the difference?

>>    And you also break the assumptions that the same commits have
>> the same contents (including date) and the same ID in different
>> repositories (some of which may include additional branches, some of
>> which may have been part of network of related repositories, etc.).

See repo A and repo B in above example.

> Wait...unless I completely misunderstand the hash-chain model, doesn't the
> hash of a commit depend on the hashes of its parents?  If that's the case,
> commits cannot have portable hashes. If it's not, please correct me.
>
> But if it's not, how does your first objection make sense?

Hash of a commit depend in hashes of its parents (Merkle tree). That is
why signing a commit (or a tag pointing to the commit) signs a whole
history of a commit.

>>> You don't need a daemon now to write commits to a repository. You can
>>> just add stuff to the object store, and then later flip the SHA-1 on a
>>> reference, we lock those indivdiual references, but this sort of thing
>>> would require a global write lock. This would introduce huge concurrency
>>> caveats that are non-issues now.
>>>
>>> Dumb clients matter. Now you can e.g. have two libgit2 processes writing
>>> to ref A and B respectively in the same repo, and they never have to
>>> know about each other or care about IPC.
>
> How do they know they're not writing to the same ref?  What keeps
> *that* operation atomic?

Because different refs are stored in different files (at least for
"live" refs that are stores in loose ref format).  The lock is taken on
ref (to update ref and its reflog in sync), there is no need to take
global lock on all refs.

>> You do realize that dates may not be monotonic (because of imperfections
>> in clock synchronization), thus the fact that the date is different from
>> parent does not mean that is different from ancestor.
>
> Good point. That means the O(log2 n) version of the check has to be done
> all the time.  Unfortunate.

Especially with around 1 million of commits (Linux kernel, Chromium,
AOSP), or even 3M commits (MS Windows repository).

>>>> That's the simple case. The complicated case is checking for date
>>>> collisions on *other* branches. But there are ways to make that fast,
>>>> too. There's a very obvious one involving a presort that is is O(log2
>>>> n) in the number of commits.
>>=20
>> I don't think performance hit you would get would be acceptable.
>
> Again, it's bad practice to assume rather than measure. Human intuitions
> about this sort of thing are notoriously unreliable.

Techniques created to handle very large repositories (with respect to
number of commits) that make it possible for Git to avoid parsing commit
objects, namely bitmap index (for 'git fetch'/'clone') and serialized
commit graph (for 'git log') lead to _significant_ performance
improvements.

The performance changes from "waiting for Git to finish" to "done in the
blink of eye" (well, almost).

>>>> Excuse me, but your premise is incorrect.  A git DAG isn't just "any" =
DAG.
>>>> The presence of timestamps makes a total ordering possible.
>>>>
>>>> (I was a theoretical mathematician in a former life. This is all very
>>>> familiar ground to me.)
>>=20
>> Maybe in theory, when all clock are synchronized.
>
> My assertion does not depend on synchronized clocks, because it doesn't h=
ave to.
>
> If the timestamps in your repo are unique, there *is* a total ordering -=
=20
> by timestamp. What you don't get is guaranteed consistency with the
> topo ordering - that is you get no guarantee that a child's timestamp
> is greater than its parents'. That really would require a common
> timebase.
>
> But I don't need that stronger property, because the purpose of
> totally ordering the repo is to guarantee the uniqueness of action
> stamps.  For that, all I need is to be able to generate a unique cookie
> for each commit that can be inserted in its action stamp.

For cookie to be unique among all forks / clones of the same repository
you need either centralized naming server, or for the cookie to be based
on contents of the commit (i.e. be a hash function).

>                                                          For my use cases
> that cookie should *not* be a hash, because hashes always break N years
> down.  It should be an eternally stable product of the commit metadata.

Well, the idea for SHA-1 <--> NewHash =3D=3D SHA-256 transition is to avoid
having a flag day, and providing full interoperability between
repositories and Git installations using the old hash ad using new
hash^1.  This will be done internally by using SHA-1 <--> SHA-256
mapping.  So after the transition all you need is to publish this
mapping somewhere, be it with Internet Archive or Software Heritage.
Problem solved.

P.S. Could you explain to me how one can use action stamp, e.g.
<esr@thyrsus.com!2019-05-15T20:01:15.473209800Z>, to quickly find the
commit it refers to?  With SHA-1 id you have either filesystem pathname
or the index file for pack to find it _fast_.

Footnotes:
----------
1. That is why where would be no "major format break", thus no place for
   incompatibile format changes.

Best,
--
Jakub Nar=C4=99bski
