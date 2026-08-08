Received: from mail-oi1-f169.google.com (mail-oi1-f169.google.com [209.85.167.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3B8E936212E
	for <git@vger.kernel.org>; Sat,  8 Aug 2026 09:18:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.167.169
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786180693; cv=pass; b=sYiNMN8bBdWR22fz3XFFTgK0O+gsEcpI5W0GD83Hr+aHTBfz9dzQ74NUUjCS1/JUS6BUehqoj7CN+xv51s/rDOPVpkQKlH07Mq0tr/FJ+g8AaoRpnSzMS/NF1ROV7+kNXnJ/Yx0XAFmBhO10PV66VVjQRHljdvy0hpkKzrFBXtA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786180693; c=relaxed/simple;
	bh=8JGQSZ/D/mlF50On0l9EWpLBBq2/K88ZpvKgaYXKImM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=JwZbmhPNmBe1qeQfjN30cca7sLHl859Fe0xE7NrZ7vuej/AWXQesKiK0jOR0c60uoS0HhGSRg/HTCNK1e8islRGcJKUwxydy25FCbLETDIanX5MHr0jQ1ZocGBElAEXwujGdhUApVfxLEi4uVpWXS0UiniZfoQhrBfHRC7gqTVI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=pf9pUInE; arc=pass smtp.client-ip=209.85.167.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="pf9pUInE"
Received: by mail-oi1-f169.google.com with SMTP id 5614622812f47-4a4836dc117so27381b6e.1
        for <git@vger.kernel.org>; Sat, 08 Aug 2026 02:18:11 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1786180690; cv=none;
        d=google.com; s=arc-20260327;
        b=gtw1+TA92ZgBOCr6tYYlu0+I1fLDC8eUg1NRs8eXwa329bTe4Bk7GZnvamUcFcz0Mr
         hRiX9Woi/ejUfuWD871z7kVilCUVWJddapT04v/8LqAkcYhlyxc7SPfyjE7Q1KupV2S9
         oOAIu4YEpw7siAUPa5uhdJfYAGwaFz+CqiBNDM2s0p+kJpzbwso3jPiHGANOUrplI8cW
         8dREJ+v5k9MfdbQ6npMd//DBe5RarJzOI6f/imSULsCEX7zDGvxeY6oVqDUfx1wNtQ4K
         CXwmNyfPc33g4sthCABS6tRI55n4J+JBArJHHUXHr/L93vtVk51QTTuaFE1+qA7i0NND
         0FWg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=ZjjFysGTB2EIDHJbQBodFSma6a/OUhBtEXdovM2xgAY=;
        fh=mLNKi6CRWp2noOk7QRle3DJYj98F1qdzbS9pIZFtyJg=;
        b=H/BcOUPo9RFdYTPYGqeCsnKv0S7/bFuEP3JJiBR96lJrHDKG/HTU9lYT08KhR4Q3S1
         dXoaNwPxEh9Zf5yweE5FGnKYdLUuARP8pol4B3jdPvmjIci7Tz3r0s1rGtHk1nYVHXQ1
         bjyrFjFUtgelliT3vXNvaHxdVONhWgMrDKDP/hKIaqhWkHQN+JRLoD/k/mNQEDnNcvE9
         6CNlaqwoQVq6BT/xx1WLKHLoRZOyxhZbzsG5q5FMGq0qBGvLYNPFgZSoWLfcn6yu1Efn
         t0ag7eSMEvO2gPgVExARo34Vb5fvbhdmT+Dxx/5HGziFHTqVe19iChPK/yZGd1xrraKA
         +5Jw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1786180690; x=1786785490; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=ZjjFysGTB2EIDHJbQBodFSma6a/OUhBtEXdovM2xgAY=;
        b=pf9pUInEYH8F6ox9wiTA2FSydw1325ImgrLRlsDs38lAFbQz2gFFXersTKl5nItZww
         yNEWOvJyClkr38QEZJYWJhV/iSdyLvuKMP0YbC45w+07XBy5bIx1PbylZQBZj6bR4tPD
         nFEk0ubCl1DDVtn6p0HjMoI0H9sxsQ/TAIC10Q8Onech24KVGwJwj+Tu4W9Wk544AxBU
         isIo6lkwxf8vVDGvB+vZEyheRC7N9ZXiO3+Yd8nVUo6A0B/gDNAY6br8XaCY5IWhUfhd
         ZT5kiTIBDuGT3p4mZDr8pZgkSZpC7PNHZYAsc/WcVIkYYSvHcQ7Xv0Ywi+MyVItogGNU
         L9kw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786180690; x=1786785490;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=ZjjFysGTB2EIDHJbQBodFSma6a/OUhBtEXdovM2xgAY=;
        b=mJOO59ztPIRUPgPiOcteD/Oo2LIMdexn9aKbXeqLBS6SSpjNFSNiBRYih3EIdmrTKX
         0Z9O59nMEV/0UNrYsdzFOTxofF0qFnxQM/iC5y0JuSrHG21+StYRX3md+Hve+EBSEkHg
         GBuV8pZhlIuiXn3UvUzoTN8EkCGHUB9Jn/+tW7wrbDQqeXi1Z1CzUoBJHL4c4IHsIlPV
         6dgmp+7dgocO4gRfx+fKzuvMxcTDuriSsxhLd+mVt3iUvHzVCxnhvaMwTrogx4HDbMDK
         aO1Gggv5hQJYrpYvYH8DWjZqUEuZs6iiFfffBwne/SPIW2OJcHKqvjhwMFPJIQa1rbde
         qMiQ==
X-Forwarded-Encrypted: i=1; AHgh+Rogc+KIeQAlPkXB2coTvauX9GC677HICvSx666uhQmAlogl4rfyFqb5GkjJr1BwHD/LPyY=@vger.kernel.org
X-Gm-Message-State: AOJu0YwEH4xGUAKGi8X55tKGGUOfahSJ+JZTXap7Mk1/XMVPpJP+4QsR
	KLqU3cqwwihaTKdWBi4oKCUHDVXXGV0LXFJfIeSq6nTKhOYMiQI3TCRzodtisua9qGJtBkphKz7
	HAh6Xb5BLECm704hsZV1XwD/7vx6rLP0=
X-Gm-Gg: AR+sD11+E72/qVWmDBpsIIVTLAjuGuY3Pw+ogFZt2LKdN/cYSF7wtWL1ZRTkzY9Vftt
	XFl1ESTWeDnbr/7vvjF/c7EPiZjpe3r9hVxC8MPnjd4bz7m9kETpjgCe25n4kKL21Ryl/hKpmDP
	CNT7hX9M2sCLnspkVTt4d01nmBI9VJMDgkHmhKm3C/P3lF7wSym+RZV7+AhzLn6u6lumJKyJTGO
	RNJRbj3Fs7lNbC1OarpbsuhHAbn/86bxmCuFuouCVMi2sLE8fnw3FSp2NzmnN/8IL3aPna3OKNb
	YTqSq8XbCO9sTYcdfXGxE2O3Q56c8dYaBs2y7Rmavs24fC/RjIP45CyvTkBxmls/qxrCdnHG7aB
	RsHToYIjwgYfYC670lh0HH/EmljBikduRHcWe887+grxDJVKWAc0WBNVWjqHwjqOaqDeoLvmAiQ
	==
X-Received: by 2002:a05:6808:3194:b0:497:e7e2:756e with SMTP id
 5614622812f47-4afae0690f5mr14819487b6e.13.1786180689848; Sat, 08 Aug 2026
 02:18:09 -0700 (PDT)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260728-toon-git-replay-drop-merges-v8-0-ced11dffe749@iotcl.com>
 <20260728-toon-git-replay-drop-merges-v8-3-ced11dffe749@iotcl.com> <anYLeQj4Sx2vZqvy@denethor>
In-Reply-To: <anYLeQj4Sx2vZqvy@denethor>
From: Elijah Newren <newren@gmail.com>
Date: Sat, 8 Aug 2026 02:17:58 -0700
X-Gm-Features: AUfX_myEQJz93T_ma5CTfEwgQ84wdSTmz-DpxLqQN1TlwzVyEj1z31JSS3jhyNs
Message-ID: <CABPp-BEFGku8msiJCcXburV+tcersr6uqEumKaPh-TguA1LjSg@mail.gmail.com>
Subject: Re: [PATCH v8 3/3] replay: offer an option to linearize the commit topology
To: Justin Tobler <jltobler@gmail.com>
Cc: Toon Claes <toon@iotcl.com>, git@vger.kernel.org, 
	Johannes Schindelin <Johannes.Schindelin@gmx.de>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Adding my comments in response to Justin's, since I think he
highlights some good points.

First of all, Toon, thanks for making --linearize and multiple
branches incompatible to avoid concatenating histories.  I really
appreciate it.

On Fri, Aug 7, 2026 at 10:34=E2=80=AFAM Justin Tobler <jltobler@gmail.com> =
wrote:
>
> On 26/07/28 05:45PM, Toon Claes wrote:
> > One of the stated goals of git-replay(1) is to allow implementing the
> > git-rebase(1) functionality on the server side.
> >
> > The default mode of git-rebase(1) is to act as if `--no-rebase-merges`
> > was given. This mode drops merge commits instead of replaying them, and
> > linearizes the history into a sequence of regular (single-parent)
> > commits.
> >
> > Add option `--linearize` to git-replay(1) to do the same. Each replayed
> > commit is stacked on top of the previously replayed one. When a merge i=
s
> > encountered, the commits reachable from all of its sides are replayed
> > into the single line and the merge itself is dropped.
> >
> > If a ref was pointing to a merge commit, that ref is updated to the
> > merge's last replayed ancestor.
>
> Just to clarify, does it really matter if the ref was pointing to the
> merge commit directly? I assume it is just "flattening" the merge
> commits in the revision range.

Toon's clarification is important, though depending on your mental
model it might _appear_ to be an unnecessary clarification.  I think
there are two mental models:
  - Each commit of the branch is replayed and the ref is updated as it
goes.  (This matches underlying implementation mechanics for `git
rebase`, but not for `git replay`.)
  - Each commit of the branch is replayed.  The ref is updated at the
end to the corresponding replay of the final commit.  (Matches
underlying implementation mechanics for `git replay`.)

Readers could possibly assume either mental model without knowing the
underlying mechanics.  Toon's clarification doesn't hurt those who
assume the first style, but is an important clarification for those
who assume the second style.

> > git-replay(1) accepts multiple revision ranges, for example:
> >
> >     $ git replay --onto main topic1 topic2
>
> Per some discussion earlier in the thread, is "accepts multiple revision
> ranges" the correct wording here? Would it be more correct to say
> multiple branches instead?

Yes, please; it would be nice to see this fixed.

> > Without `--linearize` this replays 'topic1' and 'topic2' onto 'main'
> > independently and updates both refs.
>
> Ok, so git-replay(1) updates each branch sepecified separately.

Oh, that's a good callout.  The word "independently" and "separately"
here may well mislead users.  If branches "topic1" and "topic2" share
some history, claiming they are replayed "independently" or
"separately" may cause people to assume the shared history becomes
copied and no longer shared.  I think the word "independently" should
be dropped.  If wanted, we could word this to something like:

Without `--linearize` this replays 'topic1' and 'topic2' onto 'main'
(keeping shared portions of history shared and keeping divergent parts
divergent), and updates both refs.

> > For now this is disallowed with option `--linearize`. Linearizing more
> > than one branch at once would concatenate unrelated histories into a
> > single line, and update each branch to some point in that line. That
> > won't be the result most users want, especially because the order
> > depends on the order of the revision walk, not the order of the branch
> > names on the command line.
>
> I'm not quite sure I follow. Why would the inclusion of the
> `--linearize` option force concatenation of multiple references? Is it
> mot possible to linearize each of the branches in isolation and update
> the reference accordingly?

Maybe:

Due to current implementation limitations, replaying multiple branches
with `--linearize` is disallowed to avoid concatenating unrelated
histories into a single line...

?

> > For the same reason disallow the use of `--contained` with
> > `--linearize`.

Good catch and callout, Toon.

> > Users who want to linearize multiple branches are advised to do this in
> > separate git-replay(1) invocations. Linearizing multiple branches at
> > once might be added later.
>
> Ok.
>
> > Note that `--linearize` is not modeled after git-rebase(1)'s
> > `--rebase-merges[=3D<mode>]` interface. Recreating merges, by preservin=
g
> > their topology, is a distinct operation that would be a separate mode.
> > `--linearize` only drops merges and replays commits linearly. So
> > git-replay(1) uses its own option rather than reusing that interface.
> >
> > Based-on-patches-by: Johannes Schindelin <johannes.schindelin@gmx.de>
> > Signed-off-by: Toon Claes <toon@iotcl.com>
> > ---
> >  Documentation/git-replay.adoc |  19 +++++++-
> >  builtin/replay.c              |   6 ++-
> >  replay.c                      |  60 +++++++++++++++--------
> >  replay.h                      |   5 ++
> >  t/t3650-replay-basics.sh      | 109 ++++++++++++++++++++++++++++++++++=
+++++++-
> >  5 files changed, 176 insertions(+), 23 deletions(-)
> >
> > diff --git a/Documentation/git-replay.adoc b/Documentation/git-replay.a=
doc
> > index a32f72aead..656a6924d9 100644
> > --- a/Documentation/git-replay.adoc
> > +++ b/Documentation/git-replay.adoc
> > @@ -10,7 +10,7 @@ SYNOPSIS
> >  --------
> >  [verse]
> >  (EXPERIMENTAL!) 'git replay' ([--contained] --onto=3D<newbase> | --adv=
ance=3D<branch> | --revert=3D<branch>)
> > -                          [--ref=3D<ref>] [--ref-action=3D<mode>] <rev=
ision-range>
> > +                          [--ref=3D<ref>] [--ref-action=3D<mode>] [--l=
inearize] <revision-range>
> >
> >  DESCRIPTION
> >  -----------
> > @@ -88,6 +88,23 @@ incompatible with `--contained` (which is a modifier=
 for `--onto` only).
> >  +
> >  The default mode can be configured via the `replay.refAction` configur=
ation variable.
> >
> > +--linearize::
> > +     In this mode, each replayed commit is stacked on top of the
> > +     previously replayed one, so all replayed commits are flattened in=
to
> > +     a single linear history.
> > ++
> > +When a merge commit is encountered, the behavior of git-rebase(1)'s
> > +option `--no-rebase-merges` is imitated. All commits in the range

I dislike pointing new users to read a big chunk of another manual
page to understand an option.  I have a personal gripe against the
manual for `git merge-base`, in particular, which feels like in order
to understand various flags you have to understand what at first looks
like an unrelated command and multiple of its options first.  The rest
of your paragraph is a good self-standing description; can you just
move your first sentence to the end of the paragraph and make it a
parenthetical pointing out the similarity of the two options of the
two commands?

> > +reachable from the merge commit are replayed into a linear history, an=
d
> > +the merge commit itself is dropped. A ref that pointed to a merge comm=
it
> > +is updated to the merge's last replayed ancestor.
> > ++
> > +Only a single branch can be linearized at a time: `--linearize` cannot
> > +be combined with multiple positive revisions or with `--contained`,
> > +because that would concatenate otherwise unrelated histories into one
> > +line. To linearize several branches, replay them in separate `git
> > +replay` invocations.
>
> I still don't fully understand the justification here. I'm not sure it
> really needs to be in the documentation though. It may be fine to just
> say "multiple branches are not supported with this option" or something
> along those lines.

It does feel like this unnecessarily explains implementation
shortcomings, and further tries to list them as fundamental
limitations.  (If each commit were tagged with all branches it was
reachable from, then as the replay walked over the commits and
replayed each, it could simply track the last commit for each branch
rather than an overall last commit, and at the end update each branch
to its corresponding last seen commit.  That would allow us to lift
the limitation.)  So, I agree with Justin's suggestion here to just
more simply state that the combination isn't supported.

> > +
> >  <revision-range>::
> >       Range of commits to replay; see "Specifying Ranges" in
> >       linkgit:git-rev-parse[1]. In `--advance=3D<branch>` or
> > diff --git a/builtin/replay.c b/builtin/replay.c
> > index 39e3a86f6c..d39626a37d 100644
> > --- a/builtin/replay.c
> > +++ b/builtin/replay.c
> > @@ -85,7 +85,7 @@ int cmd_replay(int argc,
> >       const char *const replay_usage[] =3D {
> >               N_("(EXPERIMENTAL!) git replay "
> >                  "([--contained] --onto=3D<newbase> | --advance=3D<bran=
ch> | --revert=3D<branch>)\n"
> > -                "[--ref=3D<ref>] [--ref-action=3D<mode>] <revision-ran=
ge>"),
> > +                "[--ref=3D<ref>] [--ref-action=3D<mode>] [--linearize]=
 <revision-range>"),
> >               NULL
> >       };
> >       struct option replay_options[] =3D {
> > @@ -111,6 +111,8 @@ int cmd_replay(int argc,
> >                            N_("mode"),
> >                            N_("control ref update behavior (update|prin=
t)"),
> >                            PARSE_OPT_NONEG),
> > +             OPT_BOOL(0, "linearize", &opts.linearize,
> > +                      N_("drop merge commits, replaying only non-merge=
 commits")),
> >               OPT_END()
> >       };
> >
> > @@ -132,6 +134,8 @@ int cmd_replay(int argc,
> >                                 opts.contained, "--contained");
> >       die_for_incompatible_opt2(!!opts.ref, "--ref",
> >                                 !!opts.contained, "--contained");
> > +     die_for_incompatible_opt2(opts.linearize, "--linearize",
> > +                               !!opts.contained, "--contained");
> >
> >       /* Parse ref action mode from command line or config */
> >       ref_mode =3D get_ref_action_mode(repo, ref_action);
> > diff --git a/replay.c b/replay.c
> > index 7e35f40d37..1e1bc7c10a 100644
> > --- a/replay.c
> > +++ b/replay.c
> > @@ -404,6 +404,12 @@ int replay_revisions(struct rev_info *revs,
> >       set_up_replay_mode(revs->repo, &revs->cmdline, opts->onto,
> >                          &detached_head, &advance, &revert, &onto, &upd=
ate_refs);
> >
> > +     if (opts->linearize &&
> > +         update_refs && strset_get_size(update_refs) > 1) {
> > +             ret =3D error(_("'--linearize' cannot be used with multip=
le revision ranges"));
>
> Should this say "multiple branches" instead?

Yes, please.

Also, should we replace opts->linearize with (opts->linearize || mode
=3D=3D REPLAY_MODE_REVERT) ?  The reason being this line of code below:

> > +                     if (opts->linearize || mode =3D=3D REPLAY_MODE_RE=
VERT)
> > +                             base =3D last_commit;

Trying to revert with multiple branches will (a) concatenate the
reverts into a single branch (which probably *is* what is wanted) and
(b) do so in revision walking order instead of the order of branches
specified by the user on the command line.  That ordering could have
bisection or conflict ramifications that may surprise the user.  Also,
cherry-pick disallows multiple branches (even though concatenation
would be wanted there too) because of this
ignore-user's-command-line-order issue.
