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
	by dcvr.yhbt.net (Postfix) with ESMTP id 37B5E1F462
	for <e@80x24.org>; Tue, 21 May 2019 00:08:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727078AbfEUAIb (ORCPT <rfc822;e@80x24.org>);
        Mon, 20 May 2019 20:08:31 -0400
Received: from mail-wr1-f66.google.com ([209.85.221.66]:45909 "EHLO
        mail-wr1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726584AbfEUAIb (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 20 May 2019 20:08:31 -0400
Received: by mail-wr1-f66.google.com with SMTP id b18so16406966wrq.12
        for <git@vger.kernel.org>; Mon, 20 May 2019 17:08:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version:content-transfer-encoding;
        bh=hi2IcDzU04QCUopHmbmDmU8BVVsnQJT9xlAdG875Chw=;
        b=NcDownO+YRgMu5er2LLlRMucc5uhxt9zCJR5qpUB7HgSFFdYWjGlOXrK7njchi/yar
         wd4fK4L9kHkAt/TeYr0VFNG/x3+S5t4CfjGQqPPUQQIhi3OF29OI04JiA7VDYHu9KvIc
         +rkeTdkRepfFgufuiuGE73UqlMglO4PkkZNpoWy6Z9DuB106dYI11YBZ8PpZN12UkZD3
         Ths/YHngkvVRqe7UfqXJ/U7tXRpLvFk8toaHnTOjh/nS+Leq3IP2LuE6WjnVx/HNfI2B
         /l0Gk9VM7pdVgMo0HuJ5pTB/OVyuUMPeZDgplbzztjx8qoOQ005aicJXZrsGYjp3ogFs
         wjLQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:references:date:in-reply-to
         :message-id:user-agent:mime-version:content-transfer-encoding;
        bh=hi2IcDzU04QCUopHmbmDmU8BVVsnQJT9xlAdG875Chw=;
        b=kFAnWK+2oaFNrCPQuM3OjnZ9XUm6h5Jcq1KZ3rdDCLHRmLt9MT/dqXAIyoGBZ5HO/R
         5MTrEvy7Ooh3RJVccbb7pszCx5hRuPuge8OipqU/HYiE8IFAGBruoJaVAJ4BYDjTQVyu
         o1FR0UQ50o1rEL0uv3SXLZTAzG3XKrivHt+KeI8Qmmmi53ikzURmCi4Hxd+2W8bXYcxd
         unRu8VeEjaWE9gpILqWAs4NiJIFzCogOppGNUYL8PiKSVbLe2vexsZzpfMekDRjs3SX2
         EC5MsdOd5qWXan0y3U8sLO2GjR2JEJiitmj3LFk1NZZg/OGMZUjxRSMQOHmjntXJpelA
         fkgg==
X-Gm-Message-State: APjAAAXkrI9sQqANPO/rmygHXGlOs9ab+D2YBVsXF8hqMlVqXbEEdxF1
        yGmvtfLJJ9/x7J6AUs+C/6KCrV4IVWk=
X-Google-Smtp-Source: APXvYqypPFfyPLmY+mw/oC8Jy7HOngMLStnOtH6NoSVHiNAAMRqxGaCIbyVpM2W2cTi1Dds8JfZS6Q==
X-Received: by 2002:adf:9794:: with SMTP id s20mr35132567wrb.104.1558397307968;
        Mon, 20 May 2019 17:08:27 -0700 (PDT)
Received: from Laptop-Acer-Aspire-F15 (egf151.neoplus.adsl.tpnet.pl. [83.21.69.151])
        by smtp.gmail.com with ESMTPSA id q16sm1296254wmj.17.2019.05.20.17.08.26
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 20 May 2019 17:08:27 -0700 (PDT)
From:   Jakub Narebski <jnareb@gmail.com>
To:     "Eric S. Raymond" <esr@thyrsus.com>
Cc:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>,
        Derrick Stolee <stolee@gmail.com>, git@vger.kernel.org
Subject: Re: Finer timestamps and serialization in git
References: <20190515191605.21D394703049@snark.thyrsus.com>
        <ae62476c-1642-0b9c-86a5-c2c8cddf9dfb@gmail.com>
        <20190515233230.GA124956@thyrsus.com>
        <87woiqvic4.fsf@evledraar.gmail.com> <86woimox24.fsf@gmail.com>
        <20190520004559.GA41412@thyrsus.com> <86r28tpikt.fsf@gmail.com>
        <20190520141417.GA83559@thyrsus.com>
Date:   Tue, 21 May 2019 02:08:25 +0200
In-Reply-To: <20190520141417.GA83559@thyrsus.com> (Eric S. Raymond's message
        of "Mon, 20 May 2019 10:14:17 -0400")
Message-ID: <86v9y4oeiu.fsf@gmail.com>
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

>>> What "commits that follow it?" By hypothesis, the incoming commit's
>>> timestamp is bumped (if it's bumped) when it's first added to a branch
>>> or branches, before there are following commits in the DAG.
>>=20
>> Errr... the main problem is with distributed nature of Git, i.e. when
>> two repositories create different commits with the same
>> committer+timestamp value.  You receive commits on fetch or push, and
>> you receive many commits at once.
>>=20
>> Say you have two repositories, and the history looks like this:
>>=20
>>  repo A:   1<---2<---a<---x<---c<---d      <- master
>>=20
>>  repo B:   1<---2<---X<---3<---4           <- master
>>=20
>> When you push from repo A to repo B, or fetch in repo B from repo A you
>> would get the following DAG of revisions
>>=20
>>  repo B:   1<---2<---X<---3<---4           <- master
>>                  \
>>                   \--a<---x<---c<---d      <- repo_A/master
>>=20
>> Now let's assume that commits X and x have the came committer and the
>> same fractional timestamp, while being different commits.  Then you
>> would need to bump timestamp of 'x', changing the commit.  This means
>> that 'c' needs to be rewritten too, and 'd' also:
>>=20
>>  repo B:   1<---2<---X<---3<---4           <- master
>>                  \
>>                   \--a<---x'<--c'<--d'     <- repo_A/master
>
> Of course that's true.  But you were talking as though all those commits
> have to be modified *after they're in the DAG*, and that's not the case.
> If any timestamp has to be modified, it only has to happen *once*, at the
> time its commit enters the repo.

The time commit 'x' was created in repo A there was no need to bump the
timestamp.  Same with commit 'X' in repo B (well, unless there is a
central serialization server - which would not fly).  It is only after
push from repo A to repo B that we have two commits: 'x' and 'X' with
the same timestamp.

> Actually, in the normal case only x would need to be modified. The only
> way c would need to be modified is if bumping x's timestamp caused an
> actual collision with c's.
>
> I don't see any conceptual problem with this.  You appear to me to be
> confusing two issues.  Yes, bumping timestamps would mean that all
> hashes downstream in the Merkle tree would be generated differently,
> even when there's no timestamp collision, but so what?  The hash of a
> commit isn't portable to begin with - it can't be, because AFAIK
> there's no guarantee that the ancestry parts of the DAG in two
> repositories where copies of it live contain all the same commits and
> topo relationships.

Errr... how did you get that the hash of a commit is not portable???
Same contents means same hash, i.e. same object identifier.  Two
repositories can have part of history in common (for example different
forks of the same repository, like different "trees" of Linux kernel),
sharing part of DAG.  Same commits, same topo relationships.  That's how
_distributed_ version control works.

[I think we may have been talking past each other.]

>> And now for the final nail in the coffing of the Bazaar-esque idea of
>> changing commits on arrival.  Say that repository A created new commits,
>> and pushed them to B.  You would need to rewrite all future commits from
>> this repository too, and you would always fetch all commits starting
>> from the first "bumped"
>
> I don't see how the second clause of your last sentence follows from the
> first unless commit hashes really are supposed to be portable across
> repositories.  And I don't see how that can be so given that 'git am'
> exists and a branch can thus be rooted at a different place after
> it is transported and integrated.

'git rebase', 'git rebase --interactive' and 'git am' create diffent
commits; that is why their's result is called "history rewriting" (it
actually is creating altered copy, and garbage-collecting old pre-copy
and pre-change version).  Anyway, the recommended practice is to not
rewrite published history (where somebody could have bookmarked it).

Note also that this copy preserves author date, not committer date; also
commits can be deleted, split and merged during "rewrite".

Fetch and push do not use 'git am', and they preserve commits and their
identities.  That is how they can be effective and peformant.

>> Hash of a commit depend in hashes of its parents (Merkle tree). That is
>> why signing a commit (or a tag pointing to the commit) signs a whole
>> history of a commit.
>
> That's what I thought.

[...]
>> For cookie to be unique among all forks / clones of the same repository
>> you need either centralized naming server, or for the cookie to be based
>> on contents of the commit (i.e. be a hash function).
>
> I don't need uniquess across all forks, only uniqueness *within the repo*.

Err, what?  So the proposed "action stamp" identifier is even more
useless?  If you can't use <esr@thyrsus.com!2019-05-15T20:01:15.473209800Z>
to uniquely name revision, so that every person that has that commit can
know which commit is it, what's the use?

Is "action stamp" meant to be some local identifier, like Mercurial's
Subversion-like revision number, good only for local repository?

> I want this for two reasons: (1) so that action stamps are unique, (2)
> so that there is a unique canonical ordering of commits in a fast export
> stream.
>
> (Without that second property there are surgical cases I can't
> regression-test.)

You can always use object identifier (hash) for tiebreaking for second
case use.

>>>                                                          For my use cas=
es
>>> that cookie should *not* be a hash, because hashes always break N years
>>> down.  It should be an eternally stable product of the commit metadata.
>>=20
>> Well, the idea for SHA-1 <--> NewHash =3D=3D SHA-256 transition is to av=
oid
>> having a flag day, and providing full interoperability between
>> repositories and Git installations using the old hash ad using new
>> hash^1.  This will be done internally by using SHA-1 <--> SHA-256
>> mapping.  So after the transition all you need is to publish this
>> mapping somewhere, be it with Internet Archive or Software Heritage.
>> Problem solved.
>
> I don't see it.  How does this prevent old clients from barfing on new
> repositories?

The SHA-1 <--> SHA-256 interoperation is on the client-server level; one
can use old Git that uses SHA-1 from repository that uses SHA-256, and
vice versa.

>> P.S. Could you explain to me how one can use action stamp, e.g.
>> <esr@thyrsus.com!2019-05-15T20:01:15.473209800Z>, to quickly find the
>> commit it refers to?  With SHA-1 id you have either filesystem pathname
>> or the index file for pack to find it _fast_.
>
> For the purposes that make action stamps important I don't really care
> about performance much (though there are fairly obvious ways to
> achieve it).

What ways?

>              My goal is to ensure that revision histories (e.g. in
> their import-stream format) are forward-portable to future VCSes
> without requiring any data outside the stream itself.

In Git you can store "action stamp" in extra extension headers in commit
objects (as was already proposed in this thread).

Best,
--
Jakub Nar=C4=99bski
