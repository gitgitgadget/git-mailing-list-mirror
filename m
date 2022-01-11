Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 24685C433F5
	for <git@archiver.kernel.org>; Tue, 11 Jan 2022 22:30:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346490AbiAKWaq (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 11 Jan 2022 17:30:46 -0500
Received: from mout.gmx.net ([212.227.15.19]:41835 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1346488AbiAKWaq (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 11 Jan 2022 17:30:46 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1641940239;
        bh=HU50nEAloFubvR0G1Z9MKzN/oorYzRqgq4nvjgJ13hU=;
        h=X-UI-Sender-Class:Date:From:To:cc:Subject:In-Reply-To:References;
        b=ahu4Po1aC79BmNEsRpR+xfinH9KA2Uym9PrAU8flvdDbH8cUomplql5tZD2DjIoyD
         IOwWEn1jDCcgofyfZdRNHns9KtEFACND04mEd5LEsnu7rgWsPW6vwCHl2JUBwV5oP/
         vATAd4C7XI7BDxWQehJ4rfBxrtgvsyh2doS+rBvE=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [172.24.82.111] ([89.1.215.56]) by mail.gmx.net (mrgmx005
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1Mdeb5-1mYcwQ0cKH-00Ze7A; Tue, 11
 Jan 2022 23:30:39 +0100
Date:   Tue, 11 Jan 2022 23:30:36 +0100 (CET)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@gitforwindows.org
To:     Elijah Newren <newren@gmail.com>
cc:     Christian Couder <christian.couder@gmail.com>,
        Git Mailing List <git@vger.kernel.org>,
        Junio C Hamano <gitster@pobox.com>,
        Christian Couder <chriscool@tuxfamily.org>,
        =?UTF-8?Q?=C3=86var_Arnfj=C3=B6r=C3=B0_Bjarmason?= 
        <avarab@gmail.com>, Taylor Blau <me@ttaylorr.com>
Subject: Re: [RFC PATCH 0/2] Introduce new merge-tree-ort command
In-Reply-To: <CABPp-BHJvFx0fxobYZ2vauK=KfCLF_7So8xABLjqr9rx4SVy-w@mail.gmail.com>
Message-ID: <nycvar.QRO.7.76.6.2201111448140.1081@tvgsbejvaqbjf.bet>
References: <20220105163324.73369-1-chriscool@tuxfamily.org> <CABPp-BFh7UnQtPM=tO8rfp5bPK4-7esouv5KCx1sUSESwEA=Rw@mail.gmail.com> <CAP8UFD0wKnAg5oyMWchXysPTg3K9Vb4M1tRcPzPE81QM903pYg@mail.gmail.com> <CABPp-BHpuLjCYycBwweMW_NdQrS_r3ECmvLb8XjNW-_Rau5NTw@mail.gmail.com>
 <nycvar.QRO.7.76.6.2201101427440.339@tvgsbejvaqbjf.bet> <CABPp-BHJvFx0fxobYZ2vauK=KfCLF_7So8xABLjqr9rx4SVy-w@mail.gmail.com>
User-Agent: Alpine 2.21.1 (DEB 209 2017-03-23)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K1:GFlKjNchUjMIYg+aPCiuzJ3c7lfCNwle0LNLS8D0i0Ru1cYzYLl
 sKBKAWanSA+bsPMwZSjcvpNwa3Vmk8GiLnFxBgOlpvosBuRnU7xxAhM3pdN0lnTbzmitP4n
 uCKQoiW2elY4N1EDvbpmgnCh6BdCpsj1pbjJXD47LAO9168UQSQmUcR8If565wlrt+CVxWw
 jjI2wd4xqEmTjY02ZHM2A==
X-UI-Out-Filterresults: notjunk:1;V03:K0:Qx59kPzxPLI=:5spMi8UpyPT03YrG+wcqsH
 TAfZVfXWE8SHd6zClP0TRfsx/FG4/LPPLk7Zrh3+dPOp5gRFq5QG67deeAXOQSFh0fHjao7FO
 0MSpcu/T3dDS1j21YwLcCFuWvYNCOmFk1a/QtKAMTAeweaPcCaWnn9NuWltmxtkOjXoUajzeI
 r/vYOIja55PhcyZaMo0tjP7oIkZAzeUjFCIqyAAtegBvYwIJnvF4As9PXweSg/fgr/K+LkUC6
 TR5seIVQq8GE9Nx9g6gHrJfo3rfQ1ZaaeNfp2Ol4t9gFwCGHhungyPRFs+sko8Q+UCSiecBR+
 psEq680kw0RPXc8NaMJuaoKeEsqL7rTDRBevM3QRIeohKNePlLoqm+hqj8danhFBbVNaSSCfu
 IQeAa8uRPy86ZMx4tkT/ZP4oHTVWmTbw1vSgQ8Nkx2j08c1dtt+4ewithuk9/TY2MOd+awDwS
 e1i2NRUypqLSVvPi6kx89MVlJ3hRMHBhevBd4A9l2KGN6/mOsRQcB20M8o0P9HkWDy0LkSMaY
 d2yPaD+1jlBYDDOOD6V2JNYM3/WoBpHxrJpOCV7RuxcJmy4LuZKIBmwYrsfO8TZDiux6uVlmM
 ZuVojjHxySvXF824Xl8ueuC/TLoM14ytMJl68KArBFmXuS723FOnD6ImK41S4V0Vdr4L19/dF
 FvJQlO6Z8IlpzsiYkQyVOZ0nRABijERdUVV/1B+xCaZtBIk1D7CFNHG7K9BijOtWPdH3YHvux
 ZcPXMg4ZtnGFjtECtQJPYsbI+7VSKZAVTpfs2mbzXsGgSV4EBgS0PUbYs8XK+mLGxjluppz1C
 /lQKmSeMuf3YDxM/Z1sVsoQCfntS/FTwzyWoBXRg4RRaa90K2gdEcbakqyV57T2dHSZMp10Aa
 MjU4ETHMwSueyLKp3AfDOOcVmiJJosK5YUnlXxguez1FQuOSYAxCzCVCWtOFO7ORmWgXS0ls4
 R1XoHCzxESQvanR+cVZ+aXjgGbUxn+skY6X1XXilZvBdw0HqAKWeK1dM99Gw0CYj1oGUQRUJA
 bCFiknES4VZUWYne864Wzd5mObP7Wdm2XzGsXuzK8Idl2BbSQrc2Nr1cPDJCPr4SEynftPWqN
 0zMpSzE0rnVJwU=
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Elijah,

On Mon, 10 Jan 2022, Elijah Newren wrote:

> On Mon, Jan 10, 2022 at 5:49 AM Johannes Schindelin
> <Johannes.Schindelin@gmx.de> wrote:
> >
> > On Fri, 7 Jan 2022, Elijah Newren wrote:
> >
> > > On Fri, Jan 7, 2022 at 9:58 AM Christian Couder
> > > <christian.couder@gmail.com> wrote:
> > > >
> > > > On Wed, Jan 5, 2022 at 5:54 PM Elijah Newren <newren@gmail.com>
> > > > wrote:
> > > > >
> > > > > On Wed, Jan 5, 2022 at 8:33 AM Christian Couder
> > > > > <christian.couder@gmail.com> wrote:
> > > >
> ...
> >
> > I _bet_ it needs first and foremost the information "is this
> > mergeable?".
> >
> > That is by far the most common question the code I saw had to answer,
> > without any follow-up questions asked.
> >
> > An add-on question is then "which files/directories conflicted?". And
> > there, it really only wanted the file names, along with the OIDs of
> > the respective item in the base, the HEAD and the merge branch.
>
> This might be difficult to provide for some cases, e.g.
> rename/rename(1to2), especially if that conflict gets entangled with any
> others.  Users would also have difficulty gaining these even using the
> command line `git merge` (with either recursive or ort) for these cases.
>
> Also, does this presume three OIDs?  What about the cases where there
> are 4 or 6 for a given path?
>
> I'm a bit worried about the assumptions underlying this request, and
> that it might not be satisfiable in general depending on what those
> assumptions are.

Well, that request is driven by the reality of a web UI.

You cannot reasonably resolve just any merge conflict in a web UI. But you
can easily resolve a trivial content conflict in, say, a README file,
without opening a console window, cloning the repository, starting an
editor, then saving the result after resolving the textual conflict,
committing it, then trying to force-push to the original PR branch (if the
contributor has given you permission to push).

So what I am talking about here really is the case where no rename
conflict happened, no directory/file conflict, no type change. Just the
good ole' textual conflicts where the same lines were modified in
divergent ways.

This means that we need the base, HEAD and MERGE OIDs here (and modes, you
are absolutely correct).

> > In my work in December, I also had to implement another thing that I
> > think we will have to implement in `merge-tree` in one form or
> > another: when users provided merge conflict resolutions via the web
> > UI, we want the merge to succeed. What I implemented was this (in a
> > nutshell, a way to provide file names with associated blob OIDs that
> > resolve the content conflicts):
>
> Interesting.  I'm curious, though -- if they are providing conflict
> resolutions, then would they not have had a previous merge to find out
> what the conflicts were?  If so, wouldn't they be able to provide the
> tree to avoid the need for a second merge?

No, the conflict resolutions are apparently stored independently from the
commits. Probably to allow for the same resolutions to be applied in case
that the PR's target branch changes but leaves the same conflicts.

Again, we are dealing with the realities of a web UI ;-)

BTW I am not saying that the way I implemented it is 100% the best way to
achieve the intended goal. It is quite possible that there is a better
way, or that we need to at least provide the (mode,OID) triplet
corresponding to the conflict, too, so that the merge machinery can verify
that the resolution is applied to the _correct_ conflict ;-)

> > -- snip --
> > Author: Johannes Schindelin <Johannes.Schindelin@gmx.de>
> > Date:   Thu Dec 16 20:46:35 2021 +0100
> > Subject: merge-ort: allow pre-resolving merge conflicts
> >
> > One of merge-ort's particular strengths is that it works well even in =
a
> > worktree-less setting, e.g. in a backend for a server-side merge.
> >
> > In such a scenario, it is conceivable that the merge in question not
> > only results in a conflict, but that the caller figures out some sort =
of
> > resolution before calling the merge again. The second call, of course,
> > is meant to apply the merge conflict resolution.
> >
> > With this commit, we allow just that. The new, optional
> > `pre_resolved_conflicts` field of `struct merge_options` maps paths to
> > the blob OID of the resolution.
> >
> > Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
> >
> > diff --git a/merge-ort.c b/merge-ort.c
> > index a74d4251c3..fa59ce2f97 100644
> > --- a/merge-ort.c
> > +++ b/merge-ort.c
> > @@ -3961,6 +3961,7 @@ static void process_entries(struct merge_options=
 *opt,
> >         prefetch_for_content_merges(opt, &plist);
> >         for (entry =3D &plist.items[plist.nr-1]; entry >=3D plist.item=
s; --entry) {
> >                 char *path =3D entry->string;
> > +               struct object_id *resolved_oid;
> >                 /*
> >                  * NOTE: mi may actually be a pointer to a conflict_in=
fo, but
> >                  * we have to check mi->clean first to see if it's saf=
e to
> > @@ -3972,7 +3973,17 @@ static void process_entries(struct merge_option=
s *opt,
> >                                           &dir_metadata);
> >                 if (mi->clean)
> >                         record_entry_for_tree(&dir_metadata, path, mi)=
;
> > -               else {
> > +               else if (opt->pre_resolved_conflicts &&
> > +                        (resolved_oid =3D
> > +                         strmap_get(opt->pre_resolved_conflicts, path=
))) {
>
> You have a couple problematic assumptions here:
>
>   * What if the user's resolution required fixing a semantic conflict,
> meaning they needed to modify a file that had no conflicts?  Your code
> here would ignore those, because the clean case is handled above.
>
>   * What if the user's resolution required adding a totally new file
> (either because a rename is handled as a separate add/delete, or they
> just needed a new file)?  The loop above isn't over items in
> pre_resolved_conflicts, it just assumes that items in
> pre_resolved_conflicts are also in the plist.items being looped over.

I can see how these assumptions may look ludicrous when coming from the
command-line. But again, we are talking about the realities of a conflict
resolution via a web UI.

So I think that it is out of the question to address non-textual conflicts
in this scenario. And then the assumptions make much more sense.

>
> > +                       mi->clean =3D 1;
> > +                       mi->is_null =3D 0;
> > +                       memcpy(&mi->result.oid, resolved_oid,
> > +                              sizeof(*resolved_oid));
>
> And here's another:
>
>   * What if the provided resolution was a deletion of the file in
> question (especially after e.g. a modify/delete or rename/delete
> conflict)?  Don't you need to have a special check for the zero_oid
> here?
>
> And if I combine the things above:
>
>   * What if the user wants to remove a file and add a directory of
> files in its place at some location in order to resolve things?
> Granted, you didn't handle either deletes or new files above, but if
> you did add both, then you might have this issue.  The code at this
> point used some very carefully constructed logic and order of walking
> items specifically to handle file/delete conflicts correctly.  I'm
> worried that your conflict resolution stuff here might interact badly
> with that.
>
> > +                       if (!mi->result.mode)
> > +                               mi->result.mode =3D 0100644;
>
> How do you know it's not supposed to be 0100755?

I don't ;-)

This was a proof-of-concept, and I meant to look into this a bit further,
trying to figure out from where I could get this information, but I never
got to that.

Now that I think about it, the best solution would probably be for the
mode to be provided in addition to the blob OID, so that the caller has to
decide.

> > +                       record_entry_for_tree(&dir_metadata, path, mi)=
;
> > +               } else {
> >                         struct conflict_info *ci =3D (struct conflict_=
info *)mi;
> >                         process_entry(opt, path, ci, &dir_metadata);
> >                 }
> > diff --git a/merge-recursive.h b/merge-recursive.h
> > index 0795a1d3ec..1f45effdd0 100644
> > --- a/merge-recursive.h
> > +++ b/merge-recursive.h
> > @@ -47,6 +47,13 @@ struct merge_options {
> >         const char *subtree_shift;
> >         unsigned renormalize : 1;
> >
> > +       /*
> > +        * (merge-ORT only) If non-NULL, contains a map from `path` to=
 OID. If
> > +        * the given `path would be marked as conflict, it is instead =
resolved
> > +        * to the specified blob.
> > +        */
> > +       struct strmap *pre_resolved_conflicts;
> > +
> >         /* internal fields used by the implementation */
> >         struct merge_options_internal *priv;
> >  };
> > -- snap --
> >
> > It is a proof-of-concept
>
> Fair enough.
>
> >, therefore it expects the resolved conflicts to
> > be in _files_. I don't think that there is a way to reasonably handle
> > symlink target conflicts or directory/file/symlink conflicts, but ther=
e
> > might be.
>
> You really need (mode,oid) pairs to be provided by the user.  That
> fixes the executable issue I mentioned above, and makes it clear how
> to handle symlinks and file/symlink conflicts.

It's a really good point, too.

> directory/file are still handled by providing individual files, but
> ordering traversal becomes really tricky.  The directory/file case
> might even require the pre_resolved_conflicts to be pulled out of that
> loop somehow.  It'd take some investigative work, or some deep
> thought, or both.

My idea for directory/file conflicts is to essentially teach the web UI to
throw its hands in the air upon encountering them, and telling the user
that it's not possible to resolve these types of conflicts via the UI.

And since my principal driver here is the concrete need for such a
server-side merge with conflict resolution, that's as far as I want to
push `merge-tree`, too, and leave any more complicated resolution to a
future date, or never, whichever comes first.

> > A subsequent commit changed my hacky `merge-tree` hack to optionally
> > accept NUL-terminated merge conflict resolutions in <path>/<OID> pairs=
 via
> > stdin (again, avoiding files to be written where we do not _need_ spen=
d
> > I/O unnecessarily).
> >
> > The biggest problem we faced at the Contributor Summit was that our
> > discussion was not informed by the actual server-side needs. So I woul=
d
> > like to reiterate my challenge to make that the driver. Let's not use =
any
> > hypothetical scenario as the basis for the design of `git merge-tree`,=
 but
> > let's use the concrete requirements of actual server-side merges that =
are
> > currently implemented using libgit2, when trying to figure out what
> > functionality we need from `merge-tree`, and in what shape.
> >
> > Here is an initial list:
> >
> > - need to determine whether a merge will succeed, quickly
> >
> > - need the tree OID for a successful merge
> >
> > - need the list of items that conflict...
>
> I think my version is good up to here.

Yes!

The only thing I would change is to not even bother providing a tree
object in case of conflicts. Either we provide it, and expect the user to
somehow reconstruct the conflict types from there, or we simply don't say
anything about the tree whose (transitive) file contents may or may not
contain conflict markers (or not, think: binary files). Providing a tree
object in case of a failed merge isn't helpful IMO.

> >  , along with OIDs and modes, if the merge failed
>
> Could you clarify what you mean here by OIDs and modes?  For a given
> path, are you just looking for a (pathname, OID, mode) tuple?  (In
> which case, you'd get the OID of a file that potentially has embedded
> conflict markers)
>
> Or are you looking for multiple OIDs and modes for each file?

This. In case of a conflict, I am looking for (mode,OID) for the merge
base (which _can_ be a virtual one in case of recursive merges) as well as
for the two divergent revisions that were supposed to be merged.

I do realize that other types of conflicts can occur, such as a
rename/rename conflict, and we would need a way to represent these in the
output, too. But in such an instance, where no clear (mode,OID) triplet
can be provided that represents the merge conflicts for this file, the
current web UI cannot offer a way to resolve the conflict, so I am a bit
less interested in that scenario.

> If you are looking for multiple OIDs and modes for each file
> (representing where the content came from on the different sides of
> the merge), are you looking for:
>   * the OID and mode of each file that played a part in the merge resolu=
tion
> OR
>   * just the OIDs and modes that would have been recorded in the index
> had the merge been done by `git merge`?

I think the latter was my idea.

But again, you made me think of rename/rename conflicts and friends, and
we would need a way to represent those, too. Even if my current use case
would need to only detect their presence in order to say "nope, can't
resolve that on the web".

> (Those last two possibilities are usually the same answer, but no they
> are not always the same.  The index cannot hold all the OIDs and modes
> in various cases and we have to squash them down to three, possibly
> tossing some information that might have been of interest to the user.
> This can even occur when you have a unique merge base.)
>
> >
> > - need a way to provide merge conflict resolutions
> >
> > And now that I wrote all this, I realize I should have sent it to the
> > `merge-tree` thread, not the `merge-tree-ort` thread...
>
> My submission was RFC and you're providing C, so it's all good in my
> book.  I'm reading both threads.  :-)

:-)

Thank you so much!
Dscho
