Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 9EB771F453
	for <e@80x24.org>; Mon, 21 Jan 2019 19:02:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727159AbfAUTCq (ORCPT <rfc822;e@80x24.org>);
        Mon, 21 Jan 2019 14:02:46 -0500
Received: from mail-vs1-f48.google.com ([209.85.217.48]:46889 "EHLO
        mail-vs1-f48.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726575AbfAUTCp (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 21 Jan 2019 14:02:45 -0500
Received: by mail-vs1-f48.google.com with SMTP id n10so13209958vso.13
        for <git@vger.kernel.org>; Mon, 21 Jan 2019 11:02:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=9cfGVpa4sKnFoYcSZPKWu38I66Su3Uxm52DrZDzC7O0=;
        b=WtOJjQTVp/8jMyvWE4rZBvSRoeR2IvPNyBZj1ZxA9iRos6/Cdjb0PLBMDTj7ddEeDK
         nFz3msih+fRDRtE7YnokJ8Vef+2yT7OjS/SI3dt1Hz3tdLrm7NQ2mrMR2wIWBFEfGxGw
         jPLz+yIEeqpZjYNL/YylDFG8hH5IKoKdUzRPCBnBQUjjIiDZchIlFIfC8wOirRPdaOcJ
         Dv3TWoIpsuZM4kd/MGNm2Nc3ZQb78aQX+bruVeKg/cxmIjuiHeObR309CgzllQ/O1V9j
         /j0foKDOfV9cHuwm+/nmNq3GyZpWO6j17axzOlaT2DYcA/xWc60jpt5U7U+IkziT0LWm
         6HpQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=9cfGVpa4sKnFoYcSZPKWu38I66Su3Uxm52DrZDzC7O0=;
        b=Ewxf5dvLM2u6ViMMovZGcS+tCkPCHE0Dom9yq9iC8peVOX5MNNb8SM0KFyFiE3q5R4
         qDeBC6At0eWDOaWJ9/2mAAIlfeht2S9lbO0n99EWWRq2xhnpHX6/4nKkRZ5gNRXcFZe+
         0h9JmyCxmas1vNsxdb7HFOalC3Hm9J/YxDtqbFG5+tOy+FHjlSg2N6mf3Wzmm2YKwBAV
         F/cyUC4+qrH/jOYRgglerxM9+vvp4ZQ3qoygcjkflzUUp4DgT2Hy+Hjt4ucq/9DCzK52
         xLFnhKRph1mUe4sr8ZjfKU9IIU/bZows2abDj0rQiIYuH9LN9IRmym1UOarQEr5MX473
         Iuzw==
X-Gm-Message-State: AJcUukd4Nk8a+UVHHsZdVm7YDg1emTfv7kRgYEZ14ProJmLwA9K7R3RW
        ad4IhUJ5caaS6RRV8ptdk5yFTjkY39AygkJJvq0=
X-Google-Smtp-Source: ALg8bN4ZROkK6PDJ0lQCSfnrDHY+aB1Rlfbps9OME65VytP6UwenegErEOW2DHpUk6gEfnt5Sy/8FLkC3LGPmDgmNlU=
X-Received: by 2002:a67:7657:: with SMTP id r84mr5471148vsc.117.1548097363531;
 Mon, 21 Jan 2019 11:02:43 -0800 (PST)
MIME-Version: 1.0
References: <CABPp-BGxaroePB6aKWAkZeADLB7VE3y1CPy2RyNwpn=+C01g3A@mail.gmail.com>
 <20180607171344.23331-1-newren@gmail.com> <20180607171344.23331-4-newren@gmail.com>
 <nycvar.QRO.7.76.6.1806100006000.77@tvgsbejvaqbjf.bet> <CABPp-BHa+sxuFBa3EmSyio28ytF_ORn950Keh1P=L-VxXtOwMw@mail.gmail.com>
 <nycvar.QRO.7.76.6.1806172337340.77@tvgsbejvaqbjf.bet> <CABPp-BEnJ4q9WGi4BgikpLJ9Aty5-3MR4VozjBk7ie4rGMc-ng@mail.gmail.com>
 <nycvar.QRO.7.76.6.1806211242440.11870@tvgsbejvaqbjf.bet> <CABPp-BGh7yW69QwxQb13K0HM38NKmQif3A6C6UULEKYnkEJ5vA@mail.gmail.com>
 <nycvar.QRO.7.76.6.1901211635080.41@tvgsbejvaqbjf.bet>
In-Reply-To: <nycvar.QRO.7.76.6.1901211635080.41@tvgsbejvaqbjf.bet>
From:   Elijah Newren <newren@gmail.com>
Date:   Mon, 21 Jan 2019 11:02:27 -0800
Message-ID: <CABPp-BEQ2e06zFEgOYp2iA9tvD9gdV-zOtyD3sOnmxCHd=PrSw@mail.gmail.com>
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

On Mon, Jan 21, 2019 at 7:56 AM Johannes Schindelin
<Johannes.Schindelin@gmx.de> wrote:
>
> Hi Elijah,
>
> while looking for the patches I promised to review much earlier, I
> realized that I never answered to this, even older mail. Sorry about that.
>
> [On a positive note: it only has been, what, exactly 7 months since you
> sent it. My record is, I believe, somewhat around 5 years before I
> responded to a mail.]

No worries; I figured it was mostly an exchange of ideas, not a
hammering down of implementation details, and as such, it was
productive with or without further responses.  In fact, I had somewhat
forgotten about this email.

> On Thu, 21 Jun 2018, Elijah Newren wrote:
>
> > Thanks for all the food for thought.  This is awesome.
>
> :-)
>
> > On Thu, Jun 21, 2018 at 3:57 AM, Johannes Schindelin
> > <Johannes.Schindelin@gmx.de> wrote:
> > > On Wed, 20 Jun 2018, Elijah Newren wrote:
> > >> On Sun, Jun 17, 2018 at 2:44 PM, Johannes Schindelin
> > >> <Johannes.Schindelin@gmx.de> wrote:
> > >>
....
> > >> What is it that makes rebase --am need fewer Git objects than rebase
> > >> --merge or rebase -i?
> > >
> > > Multiple things. The most obvious thing: --cherry-pick. When you call `git
....
> > Ooh, that's interesting.  Here's a crazy idea: I'm curious if this is
> > essentially a workaround that we could expunge.
>
> That is indeed a very, very compelling idea.
>
> > In particular, am-based rebases will drop empty commits (that is, either
> > commits that are empty to start, or that after being applied are empty).
> > It never grew a --no-allow-empty option either.  If rebase -i/-m were to
> > behave the same, for consistency sake, we could drop the `rev-list
> > --cherry-pick ...` call.  Granted, that would result in a slight
> > difference in behavior (it could result in conflicts in some cases
> > instead of an automatically empty commit), but may well be worth it for
> > consistencies' sake between rebase backends.  As a side effect of making
> > the backends consistent, it may also provide a nice performance boost
> > for the GVFS case by removing the need to do the --cherry-pick thing.
>
> I very much like the consistency thing. I am slightly worried about the
> ramifications, though.
>
> For example, when I did not use GitGitGadget yet to submit patches, I used
> one of my machines to keep a record of still-in-flight branches, and to
> verify whether a branch had been merged, I simply used `git rebase -i
> upstream/master`. If that showed a `noop`, I was sure that it was merged.
>
> While I no longer have *this* particular use case, I take it as an
> indication that Git users out there are probably using the interactive
> rebase in similar manners.
>
> So we would *in the least* have to keep this as an option, and we would
> have to work with a deprecation notice for a couple of major versions
> before we flip the default.
>
> Having said that, I really like the performance implication of switching
> the default to skip the --cherry-pick, *in particular* with an eye toward
> VFS for Git (TAFKA GVFS).

Handling of empty commits seems to be a bit of a mess in rebase.  --am
just drops them, with no option to do otherwise.  --interactive will
by default drop them if the commit is known apriori to be a clean
cherry-pick, but if the commit is just a subset of something else
upstream then it will instead halt with no option to just drop those
(instead requiring a 'git rebase --skip' for each one after it halts).
interactive rebase has a --keep option to make it not drop the apriori
clean cherry-picks, but will still halt on them anyway much as it does
for commits which were just a subset of upstream changes.  To me, it
would make more sense to have a keep option which doesn't halt
(perhaps acting like a combination of --keep and cherry-pick's
--keep-redundant-commits).  I've been thinking about adding a more
general
   --empty={drop,halt,keep}
option to all types of rebase.  However, I'm curious if we should also
differentiate between starts-empty and becomes-empty.  I know of a lot
of repos which use empty commits for version-related and
publish-related weirdness; perhaps commits which start empty should be
kept, even if commits which become empty during rebase (due to the
same changes having already been made upstream) should be removed.

It's still just an idea floating around in my head.

Anyway, thanks for the extra usecase and backward compatibility
context.  Before worrying about adding extra options and deprecation
periods, though, perhaps we could start by by omitting the
--cherry-pick for implicitly_interactive rebases, like --merge?  (In
particular, I'm thinking that when we switch the default rebase to be
--merge instead of --am[1], we avoid breaking things.)

[1] https://public-inbox.org/git/xmqqh8jeh1id.fsf@gitster-ct.c.googlers.com/

> > > Next, rename detection.
> > >
> > > I think that bit us even harder because it tries to look at all the files
> > > that have been changed in upstream in the meantime, which can be *a lot*.
> > > And if you know that moving files outside of your cozy little sparse
> > > checkout is unlikely (or moving from the outside into your checkout), then
> > > all this hydration is pretty wasteful. That's why we had to switch off
> > > rename detection in GVFS Git.
> >
> > Actually to be clear, for each side of the merge, rename detection
> > only needs to look at files that were not present in both the
> > merge-base and the branch.  Files which were modified but have the
> > same name are not involved (break detection is not active.).  But yes,
> > I understand how you can still get an awful lot of files, which makes
> > it worse when you then go and compare all of them in an O(N*M)
> > fashion.
>
> Yes.
>
> It is made worse by the fact that Git never sprouted an option to tell it
> about *known* renames, even if that would make tons of sense. I mean, it
> is nice that Git tries to detect renames. Really nice. In some cases it
> fails, though, and in other cases it just takes a lot of time, so it would
> be a real boon if there was a way to skip Git's rename detection. It'd be
> similar in spirit to way you can side-step Git's binary file detection, by
> using .gitattributes. (Obviously, the rename thing would need to use a
> different facility than .gitattributes.)

Hmm, I'll have to keep that in the back of my mind.  First I want to
remove all unnecessary time that rename detection takes, which can
often be huge.  But additional performance improvements ideas after
that are something I want to keep a note of.

> > >> My guess at what objects are needed by each type:
> > >>
> > >> At a high level, rebase --am for each commit will need to compare the
> > >> commit to its parent to generate a diff (which thus involves walking
> > >> over the objects in both the commit and its parent, though it should
> > >> be able to skip over subtrees that are equal), and then will need to
> > >> look at all the objects in the target commit on which it needs to
> > >> apply the patch (in order to properly fill the index for a starting
> > >> point, and used later when creating a new commit).
> > >
> > > No, in --am mode, it does not even need to look at all the objects in the
> > > target commits. Only those objects that correspond to the files that are
> > > touched by the diff.
> >
> > Sorry, I mis-spoke.  Unless you've done something special with GVFS, I
> > believe the --am mode would indeed need to read all the _tree_ objects
> > in the target commits, but any _file_ object corresponding to a path
> > not modified by the other side need not be loaded since we can proceed
> > simply knowing its sha1sum.
>
> That *might* be good enough with the "largest repository on the planet".
> Emprically, we determined pretty early on that it is not the commits and
> trees that make the initial clone unbearably large. It's the blobs.
>
> > > In a massive code base, such as Windows', this makes a huge difference.
> > > Even comparing the number of files touched by the patches that are to be
> > > rebased to the number of files that were touched in upstream since you
> > > rebased last is ridiculous. And a three-way merge needs to consider that
> > > latter set of files.
> >
> > Actually, the three-way merge isn't all that different.  For a path
> > that exists in both branches and the merge base, it first compares
> > sha1sums (thus it does need to read all the tree objects), and then if
> > one side has not modified a certain path, it knows the merge result is
> > the sha1sum from the other side.  Thus, it won't need to read files
> > that were changed upstream so long as that path wasn't changed on your
> > side.
>
> True.
>
> > In fact, --merge and --interactive have a slight performance advantage
> > here: if upstream didn't modify the path, then it doesn't need to read
> > the file from your side to do any diff or comparison.  It can just use
> > whatever sha1sum you have.  In contrast --am mode will need to read
> > the relevant file more than once.  Since it first creates a series of
> > patches, it will have to read the file from your commit and its
> > parent, create a diff, and then later apply that diff to the target
> > version, and since the target version matches the merge base it will
> > end up just recovering the version of the file on your side that you
> > started with anyway.  (Since that file is already local, though, this
> > small performance advantage would currently be lost in the noise of
> > the other problems.)
>
> I had not thought of that. You're right, with largish patch series,
> interactive rebase might actually be faster than --am based rebase. I have
> not even tested this, I guess I really should first look at numbers before
> I speak further :0)

I think merge-recursive has some performance problems that are likely
to mask this otherwise inherent advantage that interactive rebase
should enjoy over am-style rebase.  But once those are fixed...

> > >> If the application of the diff fails, it falls back to a three-way
> > >> merge, though the three-way merge shouldn't need any additional objects.
> > >
> > > The three-way merge needs to reconcile the diff between branch point and
> > > your changes to the diff between branch point and upstream's changes. The
> > > latter can be a lot bigger than the former, in which case --am's
> > > complexity (O(former)) is much nicer than --merge's (O(former u latter)).
> >
> > Yeah, renames mess up that whole "a path that exists in both branches
> > and the merge base" requirement that I stipulated above, and widens
> > the scope considerably and affects performance rather markedly.  On
> > the positive side though, the more I read your description, the more I
> > think my rename performance work may give a speedup for the GVFS
> > usecase far in excess of the factor of 30 I saw for my usecase.  It
> > may still not quite match --am mode's outright avoidance of rename
> > detection, but I still think it should be pretty impressive.  Time
> > will tell...
>
> I am very hopeful.
>
> And I also think that one fallout of your work on that front could be to
> teach Git a way to skip/overrule rename detection. After all, it is not
> *all* that common that files are renamed. Take Git's commit history, for
> example. Apart from the huge builtin/ move (for which rename detection
> will fail after many iterations after that move), there were only sporadic
> renames (such as sha1_file.c -> sha1-file.c). In "real" repositories,
> refactorings are also rather rare, for the same reason: they simply cause
> a lot of trouble with a lot of concurrent development going on. If we had
> such a facility (say, via notes) to tell Git: look, don't even bother to
> try to detect renames, at least in *commit range*, just use this here data
> base that I prepared for you, we would not only be able to speed up
> operations such as rebase, we also would have an easy way to solve the
> problem where the rename detection simply fails after sustained
> development because both sides diverged *so much* that Git cannot detect
> any similarity.
>
> Another thought that occurred to me: in the context of GitGitGadget, where
> I cannot rely on the `amlog` notes (because there are too many
> inaccuracies in that information), I was looking for another way to
> identify commits in `pu` that corresponds to the original commits (i.e.
> the commits by the authors themselves, in GitGitGadget's PRs). Sadly, I
> lack the time to work on this with any seriousness, I can only spend a
> couple hours here and there on it, but I *think* that there might be a
> chance to use something like MinHash and/or Locally Sensitive Hashes to
> not only determine near-identical commits, but also correspondences
> between commits and mails on the Git mailing list containing patches. And
> the very same technology should also be able to speed up rename detection,
> much more robustly (and with a much better time complexity) than what we
> have now. Did you look in that direction already?

I've looked at a few different things for speeding up rename
detection, but I've been away from merge-recursive while I've been
working on git repo-filter (or filter-repo or whatever I/we end up
calling it).  I'm hoping to get repo-filter into shape to share with
everyone before or at Git Merge, and then get back to merge
improvements.

I am not familiar with MinHash and Locally Sensitive Hashes, but I'll
add them to the list of things to look into.  Thanks for the idea.
