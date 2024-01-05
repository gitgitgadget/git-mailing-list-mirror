Received: from mail-lf1-f50.google.com (mail-lf1-f50.google.com [209.85.167.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A27EE5243
	for <git@vger.kernel.org>; Fri,  5 Jan 2024 04:59:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="SiS4XQOX"
Received: by mail-lf1-f50.google.com with SMTP id 2adb3069b0e04-50ea226bda8so1279870e87.2
        for <git@vger.kernel.org>; Thu, 04 Jan 2024 20:59:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1704430781; x=1705035581; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=5QLFf4JrA/ctB/bsonNukBqmr/lWH2pGGIKvduXjJ2I=;
        b=SiS4XQOXRoXlND1vkOuDmDcjFYChgDBTsP5jApaDIFU0Y8X2okzjsr97oBG41XGXrq
         pWsKZ81kSWV2K3P3cfSwf5O1dhBdOuj5cOlW+VAHbPIfwRmcs3Pkqmk8wNAwR5lpzfjf
         0d+CBwX/0prkcX13+X7O1tzJNEmYsai1+25ZOozp2aa5vpUoJqHn5Gr5awMgXCh/xfhF
         tOYajIm8RjO1ZwR1ZKZQJTX+PsCvy4XmKuXGpr0KwQLux2DS7gRKebga0zimDKn77Gzj
         yy6D5jprWRIDp7sbjuGW5P79cjRKfuloTfN70POOm/Zcmz8j6aBzQEDN7Fna3xN4XGB9
         GQMQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1704430781; x=1705035581;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=5QLFf4JrA/ctB/bsonNukBqmr/lWH2pGGIKvduXjJ2I=;
        b=EZPrKzXDc+rkzUGcfStX0+q8FUri0hXzuAXBxmmAoyrA8RuzsLpw8y//FwZlZcU1WA
         zp6JekDYx3o6cJOYHK87R0j8YOdZUtBf+mGr6lLEReSMDacag3nr+3seZaePYW+zs3nt
         0eZnbD/G9ujhEeEdQxi1fEClJ8WsuP63ArvLZSR/bd/hwy4MTZmmqprPExs0R70SemjP
         byKaFYY27Z52xBwLlewiX1rikoeUhwoHSEoru4hSZJqVU55dsii7phD5JVCeRGIh0Y8C
         00G4kLejLx59X/VFxmNEyENuQz9q5NSADb2amEpX8GLoOl+eG48VNUIZSnO8LkGsAk9A
         Paqg==
X-Gm-Message-State: AOJu0YzzP1jyi0270DeLBi+fRyq0UXs23sKtc9O427MYEQu2MzBzGCU0
	X+GOxR54Nfp10zZy4nWGCd14nt1WWA9upYbJOjg=
X-Google-Smtp-Source: AGHT+IEFrqNbNB3vf3BUDyVAjqusNodCX2Zb57aJ67IGgtAeTvVEQsoKbFFAIUd7RlG3UgLdWxE70I9HEXujUHRZoLg=
X-Received: by 2002:a05:6512:4db:b0:50e:8487:1ec0 with SMTP id
 w27-20020a05651204db00b0050e84871ec0mr685708lfq.69.1704430781044; Thu, 04 Jan
 2024 20:59:41 -0800 (PST)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <m0sf3vi86g.fsf@epic96565.epic.com> <CABPp-BFbvRDCbMp9Gs9PuV7WfgoVNwyOOn1rB7fe_8UvEEdehA@mail.gmail.com>
 <m0sf3itvpy.fsf@epic96565.epic.com>
In-Reply-To: <m0sf3itvpy.fsf@epic96565.epic.com>
From: Elijah Newren <newren@gmail.com>
Date: Thu, 4 Jan 2024 20:59:28 -0800
Message-ID: <CABPp-BFpdQ-uSMgOWdRxbPmVKZd1TzaqKVzcD1gnRb4usWo3iA@mail.gmail.com>
Subject: Re: rebase invoking pre-commit
To: Sean Allred <allred.sean@gmail.com>
Cc: Git List <git@vger.kernel.org>, Junio C Hamano <gitster@pobox.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi,

On Sun, Dec 31, 2023 at 4:14=E2=80=AFAM Sean Allred <allred.sean@gmail.com>=
 wrote:
>
> Elijah Newren <newren@gmail.com> writes:
>
> > On Thu, Dec 21, 2023 at 12:59=E2=80=AFPM Sean Allred <allred.sean@gmail=
.com> wrote:
> >> Is there a current reason why pre-commit shouldn't be invoked during
> >> rebase, or is this just waiting for a reviewable patch?
> >>
> >> This was brought up before at [1] in 2015, but that thread so old at
> >> this point that it seemed prudent to double-check before investing tim=
e
> >> in a developing and testing a patch.
> >>
> >> [1]: https://lore.kernel.org/git/1m55i3m.1fum4zo1fpnhncM%25lists@halle=
r-berlin.de/
> >
> > I'm very opinionated here.  I'm just one person, so definitely take
> > this with a grain of salt, but in my view...
> >
> > Personally, I think implementing any per-commit hook in rebase by
> > default is a mistake. It enforces a must-be-in-a-worktree-and-the-
> > worktree-must-be-updated-with-every-replayed-commit mindset, which I
> > find highly problematic[2], even if that's "what we always used to
> > do".
> >
> > [2] https://lore.kernel.org/git/20231124111044.3426007-1-christian.coud=
er@gmail.com/
>
> I'm not hip with what most pre-commit hooks do, but I'll point out that
> a hook like pre-commit assuming there is a worktree is the fault of the
> hook implementation, not of the infrastructure that invokes the hook. I
> imagine most folks on this list are aware that a worktree is not needed
> to create a commit and update a branch to point at it.

Well, since git-commit requires a worktree (cmd_commit in cmd_struct
in git.c has NEED_WORK_TREE in its options), and "pre-commit" is
likely to be inferred to be a "git-commit" thing (in fact, my reading
of the current text of the pre-commit hook in the githooks(1) manpage
seems to suggest that this hook is tied exclusively to git-commit),
assuming a working tree for "pre-commit" doesn't seem like a very far
leap at all.  In fact, I can't see why that assumption is broken given
our current documentation.

Perhaps we'd like to change the documentation and try to avoid such an
assumption...but even in cases where we've made explicit claims in the
past about various assumptions not being reliable, users have gone
ahead and made those assumptions anyway (Hyrum's Law), and then we
have sometimes been unable to make changes that broke those
assumptions.

So, I'm still concerned, especially if this is applied to every commit.

Granted, hooks are already pretty messed up.  We invoke the
post-commit hook -- IF we're using the merge backend (and don't invoke
it if we're using the apply backend), meaning it's not clear to users
whether the post-commit hook will be invoked or not in a rebase.
(Especially since while the backend can be specified directly, it's
often just selected based on other options that are only implemented
by one of the two backends).  I've put a lot of work into making the
rebase backends more consistent and would like them to be even more
so, but the history here is slightly troubling.  The interactive
backend was "fixed" once, accidentally, and then the accident was
realized and was treated as a bug and reverted
(https://lore.kernel.org/git/67a711754efce038914e8ec15c5dec4a5983566d.15711=
35132.git.gitgitgadget@gmail.com/),
leaving us again inconsistent.  At least we've documented the
inconsistency and the desire to change it
(https://lore.kernel.org/git/pull.749.v3.git.git.1586044818132.gitgitgadget=
@gmail.com/).

> FWIW, I would also find such a mindset to be highly problematic :-) I'll
> take a moment here to thank you, Christian, and everyone else in that
> effort for your interest in and work on git-replay; I've been trying to
> watch its activity on-list closely in the hopes that we can adopt it
> into our system once it's ready.

I'm glad others are interested in git-replay.  Sadly, the work on
pushing it forward stopped about a year and a half ago.  All work
since then was limited to pulling out the bits that were ready to be
upstreamed and cleaning those up.

> > Because of that, I would prefer to see this at most be a command line
> > flag. However, we've already got a command line flag that while not
> > identical, is essentially equivalent: "--exec $MY_SCRIPT" (it's not
> > the same because it's a post-commit check, but you get notification of
> > any problematic commits, and an immediate stop of the rebase for you
> > to fix up the problematic commit; fixing up the commit shouldn't be
> > problematic since you are, after all, already rebasing).
>
> Indeed, and an
>
>     --exec 'git hook run pre-commit || git reset --soft HEAD~'
>
> would probably get you farther. I can certainly see an argument for
> this, but from the perspective of designing a system for other
> developers to use, such a rebase would have to be triggered
> automatically (perhaps on pre-push).

Well, there is a pre-push hook...  ;-)

But yeah, it does defer the discovery of the issue for the developer,
which is kind of counter-productive.

> > I see Phillip already responded and suggested not running the
> > pre-commit hook with every commit, but only upon the first commit
> > after a "git rebase --continue".  That seems far more reasonable to me
> > than running on every commit...though even that worries me in regards
> > to what assumptions that entails about what is present in the working
> > tree.
>
> It's worth noting the context here is to prevent developers from
> committing conflict markers, so this would actually be exactly
> sufficient.

Ah, that makes sense what you want to do.  Totally fair.

> Invoking pre-commit at this time would also be consistent with the
> behaviors of prepare-commit-msg, commit-msg, and post-commit -- at least
> when I reword a commit during a rebase.
>
> However, post-commit is executed after each picked commit during a
> rebase

Only if using the merge backend, and even in that case I personally
don't think it should be executed; see the "Hooks" subsection of the
"Behavioral Differences" section of the git-rebase manpage.

> , so pre-commit there would also be consistent.

Or maybe consistently inconsistent (i.e. being consistent with the
inconsistency that exists with the post-commit hook between backends),
and diverging even further from the aspirational goal in the "Hooks"
documentation in the git-rebase manpage.

> > (For example, what about folks with large repositories, so large that
> > a branch switch or full checkout is extremely costly, and which could
> > benefit from resolving conflicts in a separate sparse-checkout
> > worktree, potentially much more sparse than their main checkout?
>
> As it happens, a single checkout of our source runs upwards of 2GB, so
> I'm exactly in the population you're describing :-)  The main reason
> we're moving to Git from SVN is that an SVN checkout can take upwards of
> an hour for us today -- even with some real shenanigans to make them go
> faster. On the Git side, we've also looked into (though I don't recall
> if we had much success with) narrowing the sparsity patterns to just the
> conflicts for conflict resolution workflows -- particularly when moving
> feature code between separate trunks. So I guess I'm also glad we
> weren't too far off in left field on that one! (As I recall, one of the
> main challenges we faced there was ensuring there was enough stuff
> 'still around' so that both binary and project references could resolve
> and folks could use that information to help resolve conflicts.
> Hopefully git-replay can be smart enough to allow some customization on
> that front. We found some success with feeding the list of conflicted
> files into some arbitrary logic that spat out the sparsity pattern to
> use.)

An hour?  For a mere 2 GB?  I mean, I know 2 GB isn't exactly tiny and
it's a pain to deal with...but an hour?  Do you have some directories
with an extraordinary number of files directly within them (i.e. not
multiple subdirectories deep, but a directory immediately containing a
huge number of files)?  Or some kind of network filesystem?  Or some
really slow hooks?

Anyway, I'm glad others are concerned with slow checkouts and branch
switches too.  And yeah, the idea was just that we make an initial
sparse checkout limited to the conflicted files, but users can use the
sparse-checkout command to widen as needed.  The bigger piece was
making sure the git code didn't defeat this by unnecessarily expanding
the index (currently with a sparse index, any conflicted files causes
the sparse-index to be expanded to a completely full index).

> > And what if people like that really fast rebase resolution (namely,
> > done in a separate very sparse checkout which also has the advantage
> > of not polluting your current working tree) so much that they use it
> > on smaller repositories as well? Can I not even experiment with this
> > idea because of the historical per-commit-at-least-as-full-as-main
> > -worktree-checkout assumptions we've baked into rebase?)
>
> I'd be interested in reading more about this baked-in assumption. Are
> these mostly laid out in replay-design-notes.txt[3]?

merge-recursive, our default merge backend for about 15 years (and
reused in rebase, cherry-pick, etc. too) only worked in a worktree and
muddied it as it went.  The other merge algorithms also assumed a
worktree was present.  When I wrote merge-ort and removed the
requirement for having a worktree, I naturally wanted to fix rebase
(and cherry-pick) to stop updating the working tree with every single
commit being rebased; it was such a needless waste of resources.  But
that assumption was all over the code and hard to remove.  And, I ran
into several items where it was unclear if "fixing" the code would be
deemed a backward compatibility break.  Hooks were one of the issues.

It's been quite a while since I've looked at it, but yes, I suspect
some of the issues are documented (explicitly or implicitly) in the
replay-design-notes.txt file, and you may see some as well in the
"Behavioral differences" section of the git-rebase manpage.

But there may well be additional parts that aren't documented, since I
never went through the full effort to de-worktree-ify rebase, and only
got git-replay doing some basic things.  So, at least part of the
issue is what other unknown assumptions are in the code which people
may have knowingly or unknowingly depended upon.

> > While at it, I should also mention that I'm not a fan of the broken
> > pre-rebase hook; its design ties us to doing a single branch at a
> > time.  Maybe that hook is not quite as bad, though, since we already
> > broke that hook and no one seemed to care (in particular, when
> > --update-refs was implemented).  But if no one seems to care about
> > broken hooks, I think the proper answer is to either get rid of the
> > hook or fix it.
>
> If I were to guess, this likely stems either from an inexact definition
> of the hook in documentation (ultimately resulting in incomplete tests)
> or folks incorrectly assuming what each hook should do based purely on
> its name.

No, neither is true.  The definition is very exact; the problem is
that the definition is excessively rigid.  It says, "The second
parameter is *the* branch being rebased" (emphasis added).  There is
no facility in the hook for rebasing more than one branch or
reference, and if we attempt to pass additional parameters, we're
potentially breaking all the existing pre-rebase hooks (which won't be
prepared to handle the extra parameters and thus may fail to reject
the rebase for those other branches that are being rebased, and thus
defeat the point of the hook).  Therefore, allowing rebase to operate
on multiple branches is a backward compatibility break...though one
that we overlooked/ignored when we added --update-refs.

And I want something more general than rebase's --update-refs; I want
the ability to replay multiple branches that aren't entirely contained
within each other, and perhaps only have a little common history (or
maybe even none) since the base point(s) we're replaying from.

> Which leads to an interesting point: pre-commit specifically states that
> it is invoked by git-commit -- not that it's invoked whenever a commit
> is created. So perhaps the correct thing to do here (if a hook is in
> fact needed) would be to define a new hook -- but I worry about doing
> that in the current state where there doesn't *seem* to be very rigid
> coordination of when client hooks are invoked in terms of plumbing
> rather than porcelain.

Yeah, as you're discovering, hooks are a mess.  Made all the more
messy by the fact that higher level commands traditionally started as
scripts that invoked other lower-level commands (git-rebase.sh
literally called git-cherry-pick and git-commit, or git-format-patch
and git-am, or git-merge-recursive and git-commit, or ...), and now
that we've discovered inconsistencies between backends, and
performance problems, and whatnot, it is not clear what we should or
even can do.  Also, even when we rewrote the scripts into C code,
we've often done so by reimplementing shell in C -- we just fork
various subprocesses repeatedly (yes, really), and then maybe come
along later and clean it up a little.

> > Anyway, as I mentioned, I'm quite opinionated here.  To the point that
> > I deemed git-rebase in its current form to possibly be unfixable
> > (after first putting a lot of work into improving it over the past
> > years) and eventually introduced a new "git-replay" command which I
> > hope to make into a competent replacement for it.  Given that I do
> > have another command to do my experiments, others on the list may
> > think it's fine to send rebase further down this route, but I was
> > hoping to avoid further drift so that there might be some way of
> > re-implementing rebase on top of my "git-replay" ideas/design.
>
> I appreciate your perspective; you've certainly thought a lot about this
> space -- and I definitely share your goal of consolidating
> implementations for obvious reasons.
>
> So I suppose that leaves me with four possible paths forward:
>
> 1. Pursue invoking pre-commit before each commit in `git rebase` (likely
>    generic in the sequencer) to be consistent with post-commit.
>
>    It sounds like this isn't a popular option, but I'm curious to folks'
>    thoughts on the noted behavior of post-commit here.

I've already said quite a bit about this above, but as a quick
reminder: (1) I'm not sure it makes sense to make something consistent
with something that is inconsistent, and (2) we have a documented
desire to stop calling post-commit from rebase even in the situations
where it is currently called.

> 2. Pursue invoking pre-commit on `git rebase --continue` (likely on any
>    --continue in the sequencer). This has the benefit of using existing
>    configuration on developer machines to purportedly 'do the right
>    thing' when its likely humans are touching code during conflict
>    resolution. It's worth noting this isn't the only reason you might
>    --continue, though, since the naive interpretation of this approach
>    completely ignores sequencer commands like 'break', though it could
>    probably just do what commit-msg does.

In the case of `break`, though, the commit was already transplanted,
so a `--continue` doesn't need to create one before moving on.  Thus,
we could say that only when rebase --continue has an unfinished commit
that needs to be created (i.e. we have a conflicted commit to resolve)
that the `pre-commit` hook gets called.

The idea of having an 'unfinished' commit state is also useful because
interactive rebases make it easy to forget if you're in the middle of
a break/edit or trying to resolve a conflict elsewhere.  That seems to
happen to me far too many times, and I really want `git commit
--amend` to throw an error (unless overridden with e.g. --force) when
you have an unfinished commit that you are working on by resolving
conflicts.  In fact, this state is probably already recorded
somewhere, we just need to make better use of it...but I'm going off
on a tangent now.

> 3. Define and implement a new hook that is called whenever a new commit
>    is about to be (or has been?) written. Such a hook could be
>    specifically designed to discourage assuming there's a working copy,
>    though we're kidding nobody by thinking it won't be used downstream
>    with that assumption. At least we could be explicit about
>    expectations, though.
>
>    This is *probably* a lot more design work than this little paragraph
>    lets on, but I've not personally watched the introduction of a new
>    hook so I don't have context for what to expect.

Yeah, and at least as worded, this suggestion would run afoul of the
logic for the distinction between pre-commit and pre-merge-commit.
And it seems to have all the same problems as #1, unless we restrict
it to just when running "rebase --continue", in which case it's not
clear what it buys us over #2.

> 4. Trigger a rebase --exec in our pre-push. This is certainly the least
>    work in git.git (i.e., no work at all), but it comes with the
>    distinct disadvantage of playing whiplash with the developer's focus.
>    During conflict resolution, they're thinking about conflicts. When
>    you're ready to push, its likely that you're no longer thinking about
>    conflicts.

Yeah, simple to implement but much less helpful.

> Does the behavior of post-commit here change any minds?

No...but although I'm slightly worried about solution #2 (as opposed
to very worried with #1), your usecase for pre-commit seems quite
reasonable.  So, I can get behind #2, though it'd be nice if we could
update the description of the `pre-commit` hook (so that it's clear
that it's not just "git-commit"), and while we're at it perhaps try to
be more explicit about what can and can't be assumed by the hook.
