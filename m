Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.2 required=3.0 tests=AWL,BAYES_00,BODY_8BITS,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 8A9AB1F453
	for <e@80x24.org>; Sat,  3 Nov 2018 12:33:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728530AbeKCVoe (ORCPT <rfc822;e@80x24.org>);
        Sat, 3 Nov 2018 17:44:34 -0400
Received: from mail-wr1-f52.google.com ([209.85.221.52]:34274 "EHLO
        mail-wr1-f52.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727256AbeKCVod (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 3 Nov 2018 17:44:33 -0400
Received: by mail-wr1-f52.google.com with SMTP id j26-v6so4617247wre.1
        for <git@vger.kernel.org>; Sat, 03 Nov 2018 05:33:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version:content-transfer-encoding;
        bh=VTxrLaihbKse1k7ERBGykKlL5hFV4XknaLcBQlPVyaY=;
        b=rKDy4pZl6AG9ZK/Fo+Wltefdww3fG4tg9QFnjxpHHk7FeYKndmSm3NGvVn+Wt7RTa3
         ei2g8k7PZRq5BnHNY+8bPulTX/RJ9t4/YuU1lomK6wuCV4gphRNR+jeNEyWH7JUMxGJk
         D5CanUvqokKwY9ljzy47ea9U+aVF9m+fTZv8wfn4m/+aAagZ2eSr0AO93h+O3h33YJ/E
         gpCB19q6fkh8EDUfwEc4Nnr76qFm/egq8QPFvZaYp7fthImiEOSVqjPE/zy+1ymHAZ/h
         6dkHdBD8qwxlnl2q12r8KRjsPAT4pMdhNM049jzusMXzdmV9E9YZrSlQePhHI2ZNrenr
         6Fmw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:references:date:in-reply-to
         :message-id:user-agent:mime-version:content-transfer-encoding;
        bh=VTxrLaihbKse1k7ERBGykKlL5hFV4XknaLcBQlPVyaY=;
        b=Ox7BrKLKPDFFfq43VqEfnvtwcJlXBTWB2enlX2w7qOTOSEEFEkHzze8+iwj/8xf8hu
         l2S/JoIgx7m6thxFAuQj4z0YYmkSZujlzNNMi6RYpnUUA8lnSxaDvy/ZVV82rnR4Vqtf
         0E+lKbp8FGTCrulMhKuwF0jJ9e3qNa8NpO3NPV4q4BwU/EaG3vpUVVK9dPf0fzBuiqJp
         vqjkUs4gjYb8FWBfdOUEFSwaouaTZ6x8/PtxWWnrrmUWL8pKHpZUW2Itou/seWrNL91i
         /CNcdsICPHm+Q0uBydKbVlE+RT0L4LVbEHUJM/L30MAo/BmnBJIrtzyqd4C+SAQf0YZz
         0L8g==
X-Gm-Message-State: AGRZ1gIh43Q+vM+yKZOePbnS6RpRrubSBmA3KU+LGLywaz6ry8s33xeS
        w3g0i8m1Ggfqe1wf/hTVtK8=
X-Google-Smtp-Source: AJdET5evZaXL/P6iDKjJUeeQllgEOfeTsQnULL6AhG4wP6XIos+94ckDES02jepBUvI22kLSwFOf2w==
X-Received: by 2002:adf:82c9:: with SMTP id 67-v6mr12650474wrc.131.1541248398300;
        Sat, 03 Nov 2018 05:33:18 -0700 (PDT)
Received: from Laptop-Acer-Aspire-F15 (egi27.neoplus.adsl.tpnet.pl. [83.21.72.27])
        by smtp.gmail.com with ESMTPSA id j40-v6sm10025833wre.48.2018.11.03.05.33.16
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Sat, 03 Nov 2018 05:33:17 -0700 (PDT)
From:   Jakub Narebski <jnareb@gmail.com>
To:     Derrick Stolee <stolee@gmail.com>
Cc:     Git List <git@vger.kernel.org>, Jeff King <peff@peff.net>,
        Junio C Hamano <gitster@pobox.com>,
        Derrick Stolee <dstolee@microsoft.com>,
        =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
Subject: Re: [RFC] Generation Number v2
References: <6367e30a-1b3a-4fe9-611b-d931f51effef@gmail.com>
        <86efc50yq5.fsf@gmail.com>
        <0c6b42e4-e825-ff70-a528-e118abf4c435@gmail.com>
Date:   Sat, 03 Nov 2018 13:33:14 +0100
In-Reply-To: <0c6b42e4-e825-ff70-a528-e118abf4c435@gmail.com> (Derrick
        Stolee's message of "Thu, 1 Nov 2018 09:29:38 -0400")
Message-ID: <861s82wdbp.fsf@gmail.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.2 (windows-nt)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Derrick Stolee <stolee@gmail.com> writes:
> On 11/1/2018 8:27 AM, Jakub Narebski wrote:
>> Derrick Stolee <stolee@gmail.com> writes:
>>
>>> Please also let me know about any additional tests that I could
>>> run. Now that I've got a lot of test scripts built up, I can re-run
>>> the test suite pretty quickly.
>>
>> I would add straighforward 1-to-N and N-to-1 reachability tests in the
>> form of `git branch / tag --contains` and `git branch / tag --merged`,
>> and perhaps also ahead-behind calculations used by `git status`, and
>> N-to-M reachability tests used by tag following code in push and fetch.

1-to-N and N-to-1 can be done with `git branch --merged` / `--contains`.

>> Possibly also A...B walk, if it is not implemented via calculating
>> merge-base.
>
> I believe this uses paint_down_to_common(), but looks at the PARENT1 and
> PARENT2 flags afterward to determine the left/right/both relationships.

Right, so I guess this is the same internal mechanism that `git
merge-base` utilizes, just used a bit differently.  Thus benchmarking
`git merge-base` should cover also A...B performance, I guess.

>> Maybe even --ancestry-path walk, though I am not sure how important best
>> performance for rhis case is (we would want good performance, but
>> perhaps best is not needed for rarely used command).
>
> Currently, the implementation of --ancestry-path does not use a
> reachability index.

Well, using reachability index would certainly give it a boost.

[...]
>>> Generation Number Performance Test
>>> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
>>>
>>> Git uses the commit history to answer many basic questions, such as
>>> computing a merge-base. Some of these algorithms can benefit from a
>>> _reachability index_, which is a condition that allows us to answer
>>> "commit A cannot reach commit B" in some cases. These require pre-
>>> computing some values that we can load and use at run-time. Git
>>> already has a notion of _generation number_, stores it in the commit-
>>> graph file, and uses it in several reachability algorithms.
>>
>> Note that there are other kinds of reachability indices.
>>
>> First, there are reachability indices that can answer the full
>> reachability query (if commit A can reach commit B, or if commit A
>> cannot reach commit B) directly, without walking the commit graph at
>> all: so called label-only approach.  For example one could store for
>> each commit the compressed list of all commits reachable from it
>> (transitive closure compression).
>>
>> Those, I think (but I have not checked), would be of not much use for
>> Git, as the size of the index grows stronger than linear with the number
>> of commits, as grows the time to compute such index.  So probably of no
>> use to Git, at least not directly (Git uses so called "bitmap index",
>> see e.g. [1], which stores reachability bit-vector as compressed
>> bitmap... but not for all commits, only for a small subset).
>>
>>
>> Second, beside negative-cut reachability indexes, that can answer with
>> certainity that "commit A cannot reach commit B", like the generation
>> numbers (also known as level, or topological level), there also
>> positive-cut indexes (usually if not always based on the spanning tree
>> or trees for the DAG), that can answer when "commit A can reach commit
>> B".
>>
>> I think that those can lead to significant speedups for at least some
>> types of commit traversal and reachability queries that Git needs to
>> answer.  But currently no algorithms has a provision for using
>> positive-cut filter index.  Anyway, such index would be auxiliary thing,
>> see the next point.
>>
>>
>> Third, we require more than having reachability index in the sense of
>> having some kind of _labelling_, often composite, that can answer either
>> "commit A cannot reach commit B" or "commit A can reach commit B",
>> depending on the type.  Git for most operations needs more, namely an
>> actual _ordering_, that is a weak order (or to be more exact a total
>> preorder, i.e. there can be two different commits with the same
>> "generation number" or index, but always either idx(A) =E2=89=B2 idx(B) =
or
>> idx(B) =E2=89=B2 idx(A)) and not only partial ordering (where there can =
be
>> incomparable elements, i.e neither idx(A) =E2=89=BC idx(B) nor idx(B) =
=E2=89=BC idx(A)).
>> This is because it needs to be used in priority queue to decide which
>> commit to travel next; more on that later.  This is also why there can
>> be only one such "main" reachability _index_.
>>
>> [1]: https://githubengineering.com/counting-objects/
>
> Thanks for the details. At the moment, I'm only interested in improving o=
ur
> negative-cut reachability index, as we have algorithms that can take
> advantage of them (and can compare their performance directly).

Right, I can agree with that.  Positive-cut reachability index use would
need to be added separately.

What I wanted to emphasize is the need for a _number_ (or a total
preorder), not simply an _index_ (a label, perhaps a composite one).
This means, as I wrote, that there would be only one main "generation
number".  It also limits the number of possible reachability indexes to
consider.

[...]
>> In Git there are at least four different types of graph traversal
>> queries, with somewhat different requirements, and affected differently
>> by various reachability indexes.
>>
>>
>> ## Pure reachability queries
>>
>> First there are pure reachability queries, when we are interested only
>> in nswering he question whether commit A can reach commit B or not.  We
>> are nt interested in list of commits between A and B; if reachability
>> index, be it negative-cut or positive-cut, can answer the question, it
>> is all we need.  If we need to walk (perform online search), then we are
>> interested in just being able to arrive; we need to walk only one path.
>>
>> This query can be performed one-to-one, one-to-many (which of commits
>> from the list can be reached from commit A), many-to-one (which commits
>> from the list can reach commit B), and many-to-many -- the latest for
>> example with recently added get_reachable_subset().
>>
>> These types of queries are done by "git branch --contains" (and
>> "--no-contains") and "git branch --merged" (and "--no-merged"), the same
>> for "git tag"; if I remember it correctly those were among first
>> operations that were sped up by commit-graph mechanism.  Many-to-many
>> queries are done for tag following in "git push" and "git fetch".
>>
>> Note that those queries are missing from gen-test.
>
> These are definitely a good idea to pursue further testing. The only
> thing I can think of right now is that the tests can be hard to set up,
> but perhaps`git branch --remote --contains` or `git tag --contains`
> would be interesting.

Also `git tab --merged`, for the "reverse" check; then this should cover
both sides of N-to-M queries used by `git fetch` (add_missing_tags() via
new get_reachable_subset()).

In any case, if all else fails, we can add new test-something script...

>> ## Topological ordering
>>
>> Here reachability index is used to find out in-degree of considered
>> commits (starting from a set of starting points).  Here we don't really
>> need to walk all paths, but we need to walk all possible ways of
>> arriving at given commit.
>
> You make a good point here about the difference between "all paths to C"
> and "all children of C", since the number of paths can grow exponentially
> (and frequently does in Git) but the number of children is linear (and
> small in practice).

Sidenote: I wonder how the distribution of number of parent
(out-degree), numbers of childern (in-degree), and number of paths to a
commit looks like.

>> Though I guess the [new] incremental algorithm could be modified to only
>> check for in-degree being zero or non-zero.  Would it make it slower or
>> faster; I guess in absence of good positive-cut reachability filter it
>> would make it slower.
>
> I don't understand how a positive-cut filter helps in this case. The point
> of the in-degreecalculation is to say "we already output all commits that
> can reach this commit" beforewe output another commit. How could a
> positive-cut filter help here?

That was more of an idle thought than a concrete proposal.

With the new 3-phase algorithm, we populate topo_queue with commits of
an in-degree of zero, calculating this on-degree if necessary.  I
thought that those pre-candidates could have been eliminated early with
positive-cut index, instead of having to compute in-degree in full.

[...]
>> ## Strict ancestry, or ancestry path
>>
>> When given a range of commits to display (e.g. A..B), only display
>> commits that exist directly on the ancestry chain between B and A,
>> i.e. commits that are both descendants of B, and ancestors of A.  In
>> other words, find all paths from B to A (if they exist).
>>
>> In this case we want to walk all the paths, heavily pruning.  This
>> should be less dependent on reachability index quality as an index (as
>> an ordering), and more on pruning ability of the filter.
>>
>> This case is not tested in gen-test, but I wonder how often this feature
>> is actualy used (if it would be worth adding it to the benchmark, and if
>> so, with what weight behind it).
>
> As mentioned earlier, the --ancestry-path algorithm does not currently us=
e a
> negative-cut filter, so we would not gather any data on this at the momen=
t.
>
> However, I imagine the algorithm is similar to the typical A..B case, as =
we
> need to discover the (po)set difference, construct the reversed digraph on
> those commits, and walk backwards from A. Assuming the difference is much
> smaller than the entire commit graph, then the main cost is the walk that
> discovers the difference, and hence is covered somewhat by the `git log
> --topo-order A..B` tests.

I would say that --ancestry-path is a little like A..B walk, a little
like the in-degree computing in --topo-order (because in in-degree
computing we are also interested only in paths that arrive at given
commit).

[...]
>>> **V1: (Epoch, Date) Pairs.**
>>>
>>> For each commit, store a pair of values called the _epoch_ and the _dat=
e_.
>>> The date is the normal commit date. The _epoch_ of a commit is the mini=
mum
>>> X such that X is at least the maximum epoch of each parent, and at least
>>> one more than the epoch of any parent whose date is larger than the date
>>> of this commit (i.e. there is clock skew between this commit and this
>>> parent). In this way, we can use the following reachability index:
>>>
>>>  =C2=A0=C2=A0 If epoch(A) < epoch(B), then A cannot reach B.
>>>  =C2=A0=C2=A0 If epoch(A) =3D=3D epoch(B) and date(A) < date(B), then A=
 cannot reach B.
>>
>> I wonder what makes it perform worse than corrected date aka V3.
>
> In the example `git merge-base v4.8 v4.9` in the Linux repo, the topology
> includes two commits (say, C1 and C2) of low generation number but high
> commit-date. These commits also have low epoch. However, there are 607
> commits in the repo whose commit date is smaller than a parent's commit
> date. This means that the epoch in themain trunk of the repo can be as
> high as 607, while the epoch for C1 and C2 is likely in the single digits.
> This means that we need to walk all commits with epoch greater than
> min { epoch(C1), epoch(C2) } before we explore C1 and C2 and terminate
> the walk.
>
> In V3, the commits C1 and C2 have high corrected commit date, higher than
> any of the commits that require positive offset to overcome the clock skew
> with their parents. This allows the walk to be very similar to the old
> algorithm, as seen in this `git merge-base A B` test summary:
>
> Linux c8d2bc9bc39e 69973b830859
[I have added names of algorithms / generationn numbers here]

> =C2=A0 OLD: 167468        -----         no reachability index
> =C2=A0=C2=A0 V0: 635579        gen(C)        (Minimum) Generation Number
> =C2=A0=C2=A0 V1: 630138        epoch(C)      (Epoch, Date) Pairs
> =C2=A0=C2=A0 V2:=C2=A0 33716        maxgen(C)     Maximum Generation Numb=
ers
> =C2=A0=C2=A0 V3: 167496        cdate(C)      Corrected Commit Date
> =C2=A0=C2=A0 V4: 153774        felineX(C)    FELINE Index

Ah, so the problem with (Epoch, Date) pairs is that the trunk acquires
high epoch, while side branches (which may be shortcuts) often have
lower epoch.  Makes sense, if maybe not obvious without such
examination.

>>> **V2: Maximum Generation Numbers.**
>>> The _maximum generation number_ of a commit (denoted by maxgen(A)) is
>>> defined using its _children_ and the total number of commits in the rep=
o.
>>> If A is a commit with no children (that is, there is no commit B with
>>> A as a parent) then maxgen(A) is equal to the number of commits in the =
repo.
>>> For all other commits A, maxgen(A) is one less than the minimum maxgen(=
B)
>>> among children B. This can be computed by initializing maxgen(C) to the
>>> number of commits, then walking the commit graph in topological order,
>>> assigning maxgen(P) =3D min { maxgen(P), maxgen(C) - 1 } for each paren=
t P
>>> of the currently-walking commit C. We then have the same reachability
>>> index as minimum generation number:
>>>
>>>  =C2=A0 If maxgen(A) < maxgen(B), then A cannot reach B.
>>
>> If I understand it correctly, this is the same as reverse generation
>> numbers, or reverse topological levels; in other words genertion numbers
>> on reversed graph -- only transformed:
>>
>>     maxgen(A) =3D=3D number_of_commits - (revgen(A) - 1)

Actually using number_of_commits may not be the best choice here with
respect to number of commits that need to have maxgen(C) be recalculated
on update...

>> We define revgen(A) in the following way:
>> - for head tips (for source nodes), i.e. commits with in-degree of 0,
>>    with no children, have revgen(A) =3D 1 (revgen(A) =3D 0 is left for
>>    commits outside commit-graph, which translates to INFINITY for
>>    maxgen(A)).
>> - otherwise, it is 1 more than maximum revgen(C) of its children
>>
>> They are equivalent, but maxgen(A) is "backward compatibile", that is
>> the rechability condition is exactly the same as for ordinary generation
>> numbers:
>>
>>  =C2=A0=C2=A0=C2=A0 If gen(A) < gen(B), then A cannot reach B.
>>  =C2=A0=C2=A0=C2=A0 If maxgen(A) < maxgen(B), then A cannot reach B.
>>
>> But
>>
>>  =C2=A0=C2=A0=C2=A0 If revgen(A) > revgen(B), then A cannot reach B.
>
> Yes, these are the same idea, and the reason to phrase it as I did is to
> keep the inequality in the same direction.

...and if using gen(C) as a starting point, you avoid rewriting whole
DAG on update.

Definition of maxgen'(C):

  - if A is commit without children (that is, there is no commit B with
    A as a parent), then maxgen'(A) =3D gen(A)
  - otherwise, maxgen'(A) =3D -1 + min_{B has A as parent}(maxgen'(B))

Update algorithm:

  1. compute gen(A) for all new commits, which is O(changes)
  2. select commit A with highest gen(A) that doesn't have maxgen'(A):
     [such commit does not have any children, because of gen() properties]
     and add it to queue Q
     2.1. take commit C from the queue Q
     2.2. for each parent P of commit C
          2.2.1. if maxgen'(P) <=3D maxgen'(C) - 1, continue
          2.2.2. update maxgen'(P) to maxgen'(C) - 1
          2.2.3. add P to queue Q

I have tested this version of maxgen(C) algorithm in a very few cases in
other post in this thread [3], and it looks like the amount of commits
that need to have maxgen() recalculated is limited.

[3]: https://public-inbox.org/git/86ftwjzv1h.fsf@gmail.com/

[...]
>>> _Commentary:_ The known examples where (minimum) generation numbers per=
form
>>> worse than commit date heuristics involve commits with recent commit da=
tes
>>> but whose parents have very low generation number compared to most rece=
nt
>>> commits. In a way, minimum generation numbers increase the odds that we
>>> can say "A cannot reach B" when A is fixed and B is selected at random.
>>> Maximum generation numbers increase the odds that we can say "A cannot
>>> reach B" when B is fixed and A is selected at random. This helps us when
>>> we are exploring during a reachability algorithm and have explored few
>>> commits and want to say that the large set of unexplored commits cannot
>>> reach any of the explored commits.
>>>
>> I guess that the situation where shortcut path have recent date, while
>> having less commits in path (and thus lover ordinary generation number)
>> is more common in real commit graphs because one might want to base a
>> commit (for example a bugfix) on an old commit, but commits usually get
>> merged quickly, and not left for long time.  If they re left for long
>> time, they usually needs correction (via rebase) before being merged,
>> and again we have commit with date close to the date of merge, leading
>> to a shortcut.
>>
>> Does this reasoning looks correct to you?
>
> These "bug fixes based on old commits" cases are few and far between, so
> are not enough to explain how often maximum generation number works well.
> Instead, I would say that it works well because the typical Git pattern is
> to merge into a single trunk. In the case of projects like Linux, there a=
re
> multiple "trunks" that are run by lieutenants and are merged into a "super
> trunk"; even in these cases, the number of trunks is much smaller than the
> number of topics. Let's focus on a single-trunk model for the
> discussion below.
>
> When working with a single trunk, most merge commits are in the first-par=
ent
> historyof that trunk. As we travel down those trunks, the maximum generat=
ion
> is decreasing. This means that the number of commits that can have equal
> generation is limited bythe number of commits in a single topic, which is
> typically small. This is opposed to the minimum generation, which can be
> unbounded. For example, if everyone bases their Git patches on the latest
> release, then if we walk into those topics, then we need to walk all the =
way
> to that release to determine reachability.
>
> Here is a picture, representing each topic as an interval of consecutive
> generation values:
>
> # Minimum Generation Numbers:
>
> v2.19.0----------M1----M2----M3----M4
> =C2=A0=C2=A0=C2=A0 |\=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0 /=C2=A0=C2=A0=C2=A0=C2=A0 /=C2=A0=C2=A0=C2=A0=C2=A0 /=C2=A0=C2=A0=C2=A0=
=C2=A0 /
> =C2=A0=C2=A0=C2=A0 | [topic1]-/ =C2=A0=C2=A0=C2=A0 /=C2=A0=C2=A0=C2=A0=C2=
=A0 /=C2=A0=C2=A0=C2=A0=C2=A0 /
> =C2=A0=C2=A0=C2=A0 |\=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0 /=C2=A0=C2=A0=C2=A0=C2=A0 /=C2=A0=C2=A0=C2=A0=
=C2=A0 /
> =C2=A0=C2=A0=C2=A0 | [topic2]-----/=C2=A0=C2=A0=C2=A0=C2=A0 /=C2=A0=C2=A0=
=C2=A0=C2=A0 /
> =C2=A0=C2=A0=C2=A0 |\ =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 /=C2=A0=C2=A0=C2=A0=C2=A0 /
> =C2=A0=C2=A0=C2=A0 | [topic3]---------/ =C2=A0=C2=A0=C2=A0 /
> =C2=A0=C2=A0=C2=A0=C2=A0 \=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0 /
> =C2=A0 =C2=A0=C2=A0=C2=A0 [topic4]-------------/
>
> =C2=A0 =C2=A0 =3D=3D=3D=3D=3Dgeneration=3D=3D=3D=3D>
>
> # Maximum Generation Numbers:
>
> v2.19.0----------M1----M2----M3----M4
> =C2=A0=C2=A0=C2=A0 |\=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0 /=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 |=C2=A0=C2=A0=C2=A0=C2=A0 |=C2=A0=C2=A0=
=C2=A0=C2=A0 |
> =C2=A0=C2=A0=C2=A0 | [topic1]-/ =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 |=C2=A0=C2=
=A0=C2=A0=C2=A0 |=C2=A0=C2=A0=C2=A0=C2=A0 |
> =C2=A0=C2=A0=C2=A0 |\=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 |=C2=A0=C2=A0=C2=A0=C2=A0 |=
=C2=A0=C2=A0=C2=A0=C2=A0 |
> =C2=A0=C2=A0=C2=A0 | \-------[topic2]/ =C2=A0=C2=A0=C2=A0=C2=A0 |=C2=A0=
=C2=A0=C2=A0=C2=A0 |
> =C2=A0=C2=A0=C2=A0 |\=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0 |=C2=A0=C2=A0=C2=A0=C2=A0 |
> =C2=A0=C2=A0=C2=A0 | \-------------[topic3]/=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0 |
> =C2=A0=C2=A0=C2=A0=C2=A0 \=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 |
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 \-------------------[topic4]/
>
> =C2=A0=C2=A0=C2=A0 =3D=3D=3D=3D=3Dgeneration=3D=3D=3D=3D>

All right, so the problem with (minimum) generation numbers performance
will be exhibited in any project that utilizes the topic branch
workflow.

Nice to know the case.

>>> **V3: Corrected Commit Date.**
>>> For a commit C, let its _corrected commit date_ (denoted by cdate(C))
>>> be the maximum of the commit date of C and the [corrected] commit dates=
 of its
>>> parents.
>>
>> Wouldn't it be better to use the maximum of the commit date of C, and
>> one second more than the corrected commit dates of its parents?  This
>> way corrected dates would be strictly monotonic along the chain.
>>
>> Sidenote: in theory, sufficiently bad clock skew (like e.g. wrong year
>> in the future) could screw large swatches of the commit graph.  In
>> practice, in real-life repositories, this doesn't happen, I guess.
>
> Yes, you're right. Congyi Wu from the Azure Repos server team pointed
> this out to me privately, as well. His example was someone merging a
> commit with date 3000-01-01, and making all later commits be
> useless. Adding one to the commit dates of the parents "fixes" this
> issue by reverting our negative-cut index to be equivalent to minimum
> generation number for all commits with this commit in their history.

I wonder if the problem with bad clock skew with the date far in the
future could be solved by using instead for such cases (where
date(parent) > date(commit) + large Delta) the average of the commit and
of the grandparents (parents of parent commit with such large positive
clock skew).  Though this wouldn't be strictly speaking immutable...

Another edge case, which I hope is not a problem in real-life
repositories, is clock skew very far in the past, and storing offsets in
30-bits.  If there was some malformed commit which has 0 as commit date
epoch (Unix time), i.e. 1970-01-01, then the delta / offset may not fit
in 30 bits that we use for storing generation numbers; there are 32+2 =3D
34 bits for comit date.  Something to think about.

[...]
>>> ### Comparing Reachability Index Versions Viability
>>>
>>> Before considering how well these indexes perform during our algorithm
>>> runs, let's take a moment to consider the implementation details and
>>> how they relate to the existing commit-graph file format and existing
>>> Git clients.
>>>
>>> * **Compatible?** In our test implementation, we use a previously unused
>>>  =C2=A0 byte of data in the commit-graph format to indicate which reach=
ability
>>>  =C2=A0 index version we are using. Existing clients ignore this value,=
 so we
>>>  =C2=A0 will want to consider if these new indexes are _backwards compa=
tible_.
>>>  =C2=A0 That is, will they still report correct values if they ignore t=
his byte
>>>  =C2=A0 and use the generation number column from the commit-graph file=
 assuming
>>>  =C2=A0 the values are minimum generation numbers?
>>
>> In other words "backward compatibility" for a reachability index means
>> that the reachability condition is exactly the same as it was:
>>
>>  =C2=A0=C2=A0=C2=A0 If index(A) < index(B), then A cannot reach B.
>>
>> and also values of the reachability index are written in place of
>> generation numbers in the commit-graph.

Note that it is backwards-compatibility only for use of generation
numbers, but of course not for an update.

>>> * **Immutable?** Git objects are _immutable_. If you change an object y=
ou
>>>  =C2=A0 actually create a new object with a new object ID. Are the valu=
es we
>>>  =C2=A0 store for these reachability indexes also immutable?
>>>
>>> * **Local?** Are these values **locally computable**? That is, do we on=
ly
>>>  =C2=A0 need to look at the parents of a commit (assuming those parents=
 have
>>>  =C2=A0 computed values) in order to determine the value at that commit?
>>>
>> Those two features imply that the number of commits that we need to walk
>> to be able to update reachability index after appending new commits is
>> O(new commits), which means O(changes).  I would allow for simple
>> transformations of other values, e.g. adding a constant; we need to
>> rewrite commit-graph file anyway.
>>
>> I wonder if there are reachability indexes that are either immutable but
>> not local, or not immutable but local.  Doesn't being local imply
>> immutability, with some common-sense assumptions (like no random choice
>> for parent-less commits)?
>
> Local probably implies immutable, but the reverse does not. The
> example I gave elsewhere in the thread was "number of commits
> reachable from C". You can't determine this directly from the values
> of your parents, but it doesn't change even if you add more commits to
> the graph.

Right, reach(C) is immutable but not local.

Local may not mean immutable if the starting points, i.e. parentless
commits, get assingled not-immutable values.  But I don't see how that
could happen without some randomness.

>>> Data
>>> ----
>>>
>>> We focused on three types of performance tests that test the indexes
>>> in different ways. Each test lists the `git` command that is used,
>>> and the table lists which repository is used and which inputs.
>>>
>>> ### Test 1: `git log --topo-order -N`
[...]
>>>
>>> | Repo=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 | N=C2=A0=C2=A0=
=C2=A0=C2=A0 | V0=C2=A0=C2=A0=C2=A0=C2=A0 | V1=C2=A0=C2=A0=C2=A0=C2=A0 | V2=
=C2=A0=C2=A0=C2=A0=C2=A0 | V3=C2=A0=C2=A0=C2=A0=C2=A0 | V4=C2=A0=C2=A0=C2=
=A0 |
>>> |--------------|-------|--------|--------|--------|--------|-------|
>>> | android-base | 100=C2=A0=C2=A0 |=C2=A0 5,487 |=C2=A0 8,534 |=C2=A0 6,=
937 |=C2=A0 6,419 | 6,453 |
>>> | android-base | 1000=C2=A0 | 36,029 | 44,030 | 41,493 | 41,206 |45,431=
 |
>>> | chromium=C2=A0=C2=A0=C2=A0=C2=A0 | 100=C2=A0=C2=A0 |=C2=A0=C2=A0=C2=
=A0 101 |424,406 |=C2=A0=C2=A0=C2=A0 101 |=C2=A0=C2=A0=C2=A0 101 |=C2=A0=C2=
=A0 101 |
>>> | gerrit=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 | 100=C2=A0=C2=A0 |=C2=A0 =
8,212 |=C2=A0 8,533 |=C2=A0=C2=A0=C2=A0 164 |=C2=A0=C2=A0=C2=A0 159 |=C2=A0=
=C2=A0 162 |
>>> | gerrit=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 | 1000=C2=A0 |=C2=A0 8,512=
 |=C2=A0 8,533 |=C2=A0 1,990 |=C2=A0 1,973 | 3,766 |
>>> | Linux=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 | 100=C2=A0=C2=A0 | 1=
2,458 | 12,444 | 13,683 | 13,123 |13,124 |
>>> | Linux=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 | 1000=C2=A0 | 24,436=
 | 26,247 | 27,878 | 26,430 |27,875 |
>>> | Linux=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 | 10000 | 30,364 | 28=
,891 | 27,878 | 26,430 |27,875 |
>>> | electron=C2=A0=C2=A0=C2=A0=C2=A0 | 1000=C2=A0 | 19,927 | 18,733 |=C2=
=A0 1,072 | 18,214 |18,214 |
>>> | Ffmpeg=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 | 10000 | 32,154 | 47,429 =
| 10,435 | 11,054 |11,054 |
>>> | jgit=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 | 1000=C2=A0 |=
=C2=A0 1,550 |=C2=A0 6,264 |=C2=A0 1,067 |=C2=A0 1,060 | 1,233 |
>>> | julia=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 | 10000 | 43,043 | 43=
,043 | 10,201 | 23,505 |23,828 |
>>> | odoo=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 | 1000=C2=A0 | 1=
7,175 |=C2=A0 9,714 |=C2=A0 4,043 |=C2=A0 4,046 | 4,111 |
>>> | php-src=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 | 1000=C2=A0 | 19,014 | 27,530 =
|=C2=A0 1,311 |=C2=A0 1,305 | 1,320 |
>>> | rails=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 | 100=C2=A0=C2=A0 |=
=C2=A0 1,420 |=C2=A0 2,041 |=C2=A0 1,757 |=C2=A0 1,428 | 1,441 |
>>> | rails=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 | 1000=C2=A0 |=C2=A0 =
7,952 | 10,145 | 10,053 |=C2=A0 8,373 | 8,373 |
>>> | swift=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 | 1000=C2=A0 |=C2=A0 =
1,914 |=C2=A0 4,004 |=C2=A0 2,071 |=C2=A0 1,939 | 1,940 |
>>> | tensorflow=C2=A0=C2=A0 | 1000=C2=A0 | 10,019 | 39,221 |=C2=A0 6,711 |=
 10,051 |10,051 |
>>> | TypeScript=C2=A0=C2=A0 | 1000=C2=A0 |=C2=A0 2,873 | 12,014 |=C2=A0 3,=
049 |=C2=A0 2,876 | 2,876 |
>>
>> Do I understand it correctly that the range of N for a given project is
>> limited by the depth of the project history (hence maximum N of 10000
>> for Linux kernel, but only 100 for chromium)?
>
> I ran the tests with N equal to 100, 1000, and 10000 on all repos, but on=
ly
> included results for values that were interesting. For chromium, something
> about the topology let all versions (except V1) report N + 1, so I
> didn't include the other values.

Ah, that information (only interesting cases were included) would be
something good to know.

I wonder if the relative performance of different generation numbers is
correlated with the topology of the commit graph, for example with
increment patterns to intergation patterns ratio in the commit metagraph
(like --simplify-by-decoration), like in [4] and related works.

[4] Marco Biazzini, Martin Monperrus, Benoit Baudry "On Analyzing the
    Topology of Commit Histories in Decentralized Version Control
    Systems", DOI: 10.1109/ICSME.2014.48 (2014)

>> I wonder what the OLD numbers are for these operations.
>
> The OLD numbers are equal to the number of commits reachable from HEAD
> in every case. I didn't think this was interesting to report. You can
> see the numbers for yourself in the output data file:
>
> https://github.com/derrickstolee/gen-test/blob/master/topo-order-summary.=
txt

Thanks for the info.

--=20
Jakub Nar=C4=99bski
