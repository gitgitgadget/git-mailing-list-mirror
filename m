Received: from mout.gmx.net (mout.gmx.net [212.227.15.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 624241A317D
	for <git@vger.kernel.org>; Sun, 17 May 2026 14:33:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.15.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779028401; cv=none; b=h5uAuf3U9sTu9jWs0uRmsf7KCZWLU1ZDr6lZUuy4YzdBOdJLP2np+zvYFdVZbDekx/8tSNo3NjdKb1hs55EZy3H3+MqJuqJUc4t8VwhTln00abxTyeops0/gDZEztVfva5z7StMQbUgp0fN5bSvEVKrPcIGbErbC+oIjTPSqrPc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779028401; c=relaxed/simple;
	bh=iCicVOiqMDxxSr3osQmyjr7oDwfBobZ4M2cnxUqzpCU=;
	h=Date:From:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=Unle+q9ufnai9TPG95WXxwax5LyuT3aGYSU6VSNes8ZohJIs2Vc9396aqWTtUZYnJA7/mjaOh8wDskgWormp5EJdFfwE4CxcSfEebFJ2w07Cr4YU8fW7qAicUK3arMIbj5IT2m/jAxD8Oi/3TItR4oNW5JR3n5pXR1CMjZCtvRQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de; spf=pass smtp.mailfrom=gmx.de; dkim=pass (2048-bit key) header.d=gmx.de header.i=johannes.schindelin@gmx.de header.b=qM38mWeT; arc=none smtp.client-ip=212.227.15.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmx.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.de header.i=johannes.schindelin@gmx.de header.b="qM38mWeT"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.de;
	s=s31663417; t=1779028396; x=1779633196;
	i=johannes.schindelin@gmx.de;
	bh=03+QaPJ+p4YQr7DDRAav3HA1wav8n1+snNikaCGWNHA=;
	h=X-UI-Sender-Class:Date:From:To:cc:Subject:In-Reply-To:Message-ID:
	 References:MIME-Version:Content-Type:cc:content-transfer-encoding:
	 content-type:date:from:message-id:mime-version:reply-to:subject:
	 to;
	b=qM38mWeTjQ+Fc+3yzRp3rTBqeQzBp+oGBxc8qRu6TcDhI6SjKlTiyL5MPCRLgFsY
	 iAWqDzhCFyenfcYv10MvMUrmT402FmRi2lXlG14c2/qts7qF5AMebrTz2m2ljHS8F
	 5XaVTnu6h2g/qp0HdBSW0phafDbpE0JlWNqtoUA2eVx0jc68W1D+uJR3oXLvSPEsy
	 mBhVHjCg1FuLCp9w7Zvxo98k7w0PQ0XK2hjUeeeTS2Q+ol3YxvBo3YoJt7BvQB2LI
	 s+QM0wUWIwU+Muc7/vkMQdnrnIXf5q0GeeFSZp1THWd1Xbp7qdvWAJEiqmBK04vqX
	 SdvnBt/GQEnlCJgw7Q==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from client.hidden.invalid by mail.gmx.net (mrgmx004
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1N49lD-1xNliH2ZtJ-015bMK; Sun, 17
 May 2026 16:33:16 +0200
Date: Sun, 17 May 2026 16:33:15 +0200 (CEST)
From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
To: Phillip Wood <phillip.wood123@gmail.com>
cc: Johannes Schindelin via GitGitGadget <gitgitgadget@gmail.com>, 
    git@vger.kernel.org, Elijah Newren <newren@gmail.com>, 
    Patrick Steinhardt <ps@pks.im>
Subject: Re: [PATCH/RFC 1/5] replay: support replaying 2-parent merges
In-Reply-To: <3dd21593-9945-4f9c-a9a0-f5c66504da49@gmail.com>
Message-ID: <cb707cf0-5964-1303-6745-1b504e011792@gmx.de>
References: <pull.2106.git.1778107405.gitgitgadget@gmail.com> <034ab0f83822e6db67baa423d9fcb753b12b5ac8.1778107405.git.gitgitgadget@gmail.com> <72901ee2-1212-46cd-b752-f451cce6e1ff@gmail.com> <3dd21593-9945-4f9c-a9a0-f5c66504da49@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="8323328-381085256-1779028396=:100"
X-Provags-ID: V03:K1:8y89DHwMEOcrGu9iVvNxV8LGvNcHZDohYHYm+ZnaeZ54/L6IQQi
 lQOgKaRpc/uUkQvnU7/hU3t+959k2B7xt+T1nFGRGza1mbaJAARz8om62/96NoXxEeDpK/T
 x9plHUSCvmzsB5+IqRQRIs6jgE5XMDHhqWtebobpCfVq+XnxwSdWFAOTtKczZ3dlkfLtRX2
 jC0tEwWEfnHsCiwmUAKwA==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:tH5zoaqIfJI=;sni6AOAdjipl7OxQyDWQBv7andm
 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

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323328-381085256-1779028396=:100
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Hi Phillip,

On Fri, 8 May 2026, Phillip Wood wrote:

> On 08/05/2026 10:36, Phillip Wood wrote:
> >=20
> > On 06/05/2026 23:43, Johannes Schindelin via GitGitGadget wrote:
> > >
> > > Elijah Newren spelled out a way to lift this limitation in his
> > > replay-design-notes [1] and prototyped it in a 2022
> > > work-in-progress sketch [2]. The idea is that a merge commit M on
> > > parents (P1, P2) records both an automatic merge of those parents
> > > AND any manual layer the author put on top of that automatic merge
> > > (textual conflict resolution and any semantic edit outside conflict
> > > markers). Replaying M onto rewritten parents (P1', P2') must
> > > preserve that manual layer, but the rewritten parents change the
> > > automatic merge, so a simple cherry-pick is wrong: the manual layer
> > > would be re-introduced on top of stale auto-merge text.
> > >
> > > What works instead is a three-way merge of three trees the existing
> > > infrastructure already knows how to compute. Let R be the recursive
> > > auto-merge of (P1, P2), O be M's actual tree and N be the recursive
> > > auto-merge of (P1', P2'). Then `git diff R O` is morally
> > > `git show --remerge-diff M`: it captures exactly what the author
> > > added on top of the automatic merge. A non-recursive 3-way merge
> > > with R as the merge base, O as side 1 and N as side 2 layers that
> > > manual contribution onto the freshly auto-merged rewritten parents
> > > (N) and produces the replayed tree.
> >=20
> > So we cherry-pick the difference between the user's conflict resolutio=
n O
> > and the auto-merge M of the original parents onto the auto-merge N of =
the
> > replayed parents. If we have a topology that looks like
> >=20
> >  =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 |
> >  =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 A
> >  =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 /|\
> >  =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 / B \
> >  =C2=A0=C2=A0=C2=A0=C2=A0 E=C2=A0 |=C2=A0 D
> >  =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 C /
> >  =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 |/
> >  =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 O
> >=20
> > then running
> >=20
> >  =C2=A0=C2=A0=C2=A0 git replay --onto E --ancestry-path B..O
> >=20
> > will replay C and O onto E. If the changes in E and D conflict but tho=
se
> > conflicts do not overlap with the conflicts in M that were resolved to
> > create O then the replayed version of O will contain conflict markers =
from
> > the conflicting changes in E and D. Because the previous conflict reso=
lution
> > applies to N without conflicts we do not recognize that there are stil=
l
> > conflicts in N that need to be resolved.
> >=20
> > Having realized this I went to look at Elijah's notes and they recogni=
ze
> > this possibility and suggest extending the xdiff merge code to detect =
when N
> > has conflicts that do not correspond to the conflicts in M. That sound=
s like
> > quite a lot of work. I've not put much effort into coming up with a
> > counterexample but think that because "git replay" and "git history" d=
o not
> > yet allow the commits in the merged branches to be edited we may be ab=
le to
> > safely use the implementation proposed in this series if both merge pa=
rents
> > have been rebased (or we might want all the merge bases of the new mer=
ge to
> > be a descendants of "--onto"). In the example above if both the parent=
s were
> > rebased onto E then any new conflicts would happen when picking D rath=
er
> > than when recreating the merge.
>=20
> One further thought - if only one of the parents has been rebased (i.e. =
we're
> replaying O with parents P1' and P2) then can we just cherry-pick the me=
rge -
> instead of merging P1' and P2, use P1 as the merge-base with O and P1' a=
s the
> merge heads?

That's a really good idea! That should _especially_ work well for the
conflict markers in case of conflicts.

Ciao,
Johannes

>=20
> Thanks
>=20
> Phillip
>=20
> > Thanks
> >=20
> > Phillip
> >=20
> > > Implement `pick_merge_commit()` along those lines and dispatch to it
> > > from `replay_revisions()` when the commit being replayed has exactly
> > > two parents. Two specific points (learned the hard way) keep
> > > non-trivial cases working where the WIP sketch [2] bailed out.
> > > First, R and N use identical `merge_options.branch1` and `branch2`
> > > labels ("ours"/"theirs"). When the original parents conflicted on a
> > > region of a file, both R and N produce textually identical conflict
> > > markers; the outer non-recursive merge then sees N =3D=3D R in that
> > > region and the user's manual resolution from O wins cleanly. Without
> > > this, the conflict-marker text would differ between R and N (because
> > > the inner merges would label the conflicts differently), and the
> > > outer merge would itself be unclean even when the user did supply a
> > > clean resolution. Second, an unclean inner merge
> > > (`result.clean =3D=3D 0`) is _not_ fatal: the tree merge-ort produce=
s in
> > > that case still has well-defined contents (with conflict markers in
> > > the conflicted files) and is a valid input to the outer
> > > non-recursive merge. Only a real error (`< 0`) propagates as
> > > failure.
> > >
> > > The replay propagates the textual diffs the user actually made in M;
> > > it does _not_ extrapolate symbol-level intent. If rewriting the
> > > parents pulls in genuinely new content (for example, a brand-new
> > > caller of a function that the merge renamed), that new content stays
> > > as the rewritten parents have it. Symbol-aware refactoring is out of
> > > scope here, just as it is for plain rebase.
> > >
> > > Octopus merges (more than two parents) and revert-of-merge are not
> > > supported and are surfaced as explicit errors at the dispatch point.
> > > The "split" sub-command of `git history` continues to refuse when
> > > the targeted commit is itself a merge: split semantics do not apply
> > > to merges. The pre-walk gate in `builtin/history.c` that previously
> > > rejected any merge in the rewrite path now only rejects octopus
> > > merges; rename it accordingly.
> > >
> > > A small refactor in `create_commit()` makes the merge case possible:
> > > the helper now takes a `struct commit_list *parents` rather than a
> > > single parent pointer and takes ownership of the list. The single
> > > existing caller in `pick_regular_commit()` builds and passes a
> > > one-element list; the new `pick_merge_commit()` builds a two-element
> > > list, with the order of the `from` and `merge` parents preserved.
> > >
> > > Update the negative expectations in t3451, t3452 and t3650 that were
> > > asserting the now-retired "not supported yet" message, replacing
> > > them with positive coverage where it fits. Octopus rejection and
> > > revert-of-merge rejection are covered by new positive tests in
> > > t3650. A dedicated test script with merge-replay scenarios driven by
> > > a new test-tool fixture builder will follow in a subsequent commit.
> > >
> > > [1] https://github.com/newren/git/blob/replay/replay-design-notes.tx=
t
> > > [2] https://github.com/newren/git/
> > > commit/4c45e8955ef9bf7d01fd15d9106b3bdb8ea91b45
> > >
> > > Helped-by: Elijah Newren <newren@gmail.com>
> > > Assisted-by: Claude Opus 4.7
> > > Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
> > > ---
> > > =C2=A0 builtin/history.c=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0 |=C2=A0 16 ++-
> > > =C2=A0 replay.c=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 | 209 ++++++++++++++++=
++++++++++++++++++++--
> > > =C2=A0 t/t3451-history-reword.sh |=C2=A0 21 ++--
> > > =C2=A0 t/t3452-history-split.sh=C2=A0 |=C2=A0=C2=A0 6 +-
> > > =C2=A0 t/t3650-replay-basics.sh=C2=A0 |=C2=A0 46 ++++++++-
> > > =C2=A0 5 files changed, 269 insertions(+), 29 deletions(-)
> > >
> > > diff --git a/builtin/history.c b/builtin/history.c
> > > index 9526938085..00097b2226 100644
> > > --- a/builtin/history.c
> > > +++ b/builtin/history.c
> > > @@ -195,15 +195,15 @@ static int parse_ref_action(const struct optio=
n
> > > *opt, const char *value, int uns
> > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 return 0;
> > > =C2=A0 }
> > > -static int revwalk_contains_merges(struct repository *repo,
> > > -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 const struct strvec *revwalk_ar=
gs)
> > > +static int revwalk_contains_octopus_merges(struct repository *repo,
> > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 const s=
truct strvec *revwalk_args)
> > > =C2=A0 {
> > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 struct strvec args =3D STRVEC_INIT;
> > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 struct rev_info revs;
> > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 int ret;
> > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 strvec_pushv(&args, revwalk_args->v);
> > > -=C2=A0=C2=A0=C2=A0 strvec_push(&args, "--min-parents=3D2");
> > > +=C2=A0=C2=A0=C2=A0 strvec_push(&args, "--min-parents=3D3");
> > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 repo_init_revisions(repo, &revs, NULL=
);
> > > @@ -217,7 +217,7 @@ static int revwalk_contains_merges(struct reposi=
tory
> > > *repo,
> > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 }
> > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 if (get_revision(&revs)) {
> > > -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 ret =3D error(_("replayi=
ng merge commits is not supported yet!"));
> > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 ret =3D error(_("replayi=
ng octopus merges is not supported"));
> > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 goto out;
> > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 }
> > > @@ -289,7 +289,7 @@ static int setup_revwalk(struct repository *repo=
,
> > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 strvec_push(&=
args, "HEAD");
> > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 }
> > > -=C2=A0=C2=A0=C2=A0 ret =3D revwalk_contains_merges(repo, &args);
> > > +=C2=A0=C2=A0=C2=A0 ret =3D revwalk_contains_octopus_merges(repo, &a=
rgs);
> > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 if (ret < 0)
> > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 goto out;
> > > @@ -482,6 +482,9 @@ static int cmd_history_reword(int argc,
> > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 if (ret < 0) {
> > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 ret =3D error=
(_("failed replaying descendants"));
> > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 goto out;
> > > +=C2=A0=C2=A0=C2=A0 } else if (ret) {
> > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 ret =3D error(_("conflic=
t during replay; some descendants were not
> > > rewritten"));
> > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 goto out;
> > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 }
> > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 ret =3D 0;
> > > @@ -721,6 +724,9 @@ static int cmd_history_split(int argc,
> > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 if (ret < 0) {
> > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 ret =3D error=
(_("failed replaying descendants"));
> > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 goto out;
> > > +=C2=A0=C2=A0=C2=A0 } else if (ret) {
> > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 ret =3D error(_("conflic=
t during replay; some descendants were not
> > > rewritten"));
> > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 goto out;
> > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 }
> > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 ret =3D 0;
> > > diff --git a/replay.c b/replay.c
> > > index f96f1f6551..3dbce095f9 100644
> > > --- a/replay.c
> > > +++ b/replay.c
> > > @@ -1,6 +1,7 @@
> > > =C2=A0 #define USE_THE_REPOSITORY_VARIABLE
> > > =C2=A0 #include "git-compat-util.h"
> > > +#include "commit-reach.h"
> > > =C2=A0 #include "environment.h"
> > > =C2=A0 #include "hex.h"
> > > =C2=A0 #include "merge-ort.h"
> > > @@ -77,15 +78,21 @@ static void generate_revert_message(struct strbu=
f
> > > *msg,
> > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 repo_unuse_commit_buffer(repo, commit=
, message);
> > > =C2=A0 }
> > > +/*
> > > + * Build a new commit with the given tree and parent list, copying
> > > author,
> > > + * extra headers and (for pick mode) the commit message from `based=
_on`.
> > > + *
> > > + * Takes ownership of `parents`: it will be freed before returning,=
 even
> > > on
> > > + * error. Parent order is preserved as supplied by the caller.
> > > + */
> > > =C2=A0 static struct commit *create_commit(struct repository *repo,
> > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 struct tree *=
tree,
> > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 struct commit=
 *based_on,
> > > -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 struct commit *parent,
> > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 struct commit_list *paren=
ts,
> > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 enum replay_m=
ode mode)
> > > =C2=A0 {
> > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 struct object_id ret;
> > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 struct object *obj =3D NULL;
> > > -=C2=A0=C2=A0=C2=A0 struct commit_list *parents =3D NULL;
> > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 char *author =3D NULL;
> > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 char *sign_commit =3D NULL; /* FIXME:=
 cli users might want to sign
> > > again */
> > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 struct commit_extra_header *extra =3D=
 NULL;
> > > @@ -96,7 +103,6 @@ static struct commit *create_commit(struct reposi=
tory
> > > *repo,
> > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 const char *orig_message =3D NULL;
> > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 const char *exclude_gpgsig[] =3D { "g=
pgsig", "gpgsig-sha256", NULL };
> > > -=C2=A0=C2=A0=C2=A0 commit_list_insert(parent, &parents);
> > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 extra =3D read_commit_extra_headers(b=
ased_on, exclude_gpgsig);
> > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 if (mode =3D=3D REPLAY_MODE_REVERT) {
> > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 generate_reve=
rt_message(&msg, based_on, repo);
> > > @@ -273,6 +279,7 @@ static struct commit *pick_regular_commit(struct
> > > repository *repo,
> > > =C2=A0 {
> > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 struct commit *base, *replayed_base;
> > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 struct tree *pickme_tree, *base_tree,=
 *replayed_base_tree;
> > > +=C2=A0=C2=A0=C2=A0 struct commit_list *parents =3D NULL;
> > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 if (pickme->parents) {
> > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 base =3D pick=
me->parents->item;
> > > @@ -327,7 +334,143 @@ static struct commit *pick_regular_commit(stru=
ct
> > > repository *repo,
> > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 if (oideq(&replayed_base_tree->object=
.oid, &result->tree-=20
> > > >object.oid) &&
> > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 !oideq(&pickm=
e_tree->object.oid, &base_tree->object.oid))
> > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 return replay=
ed_base;
> > > -=C2=A0=C2=A0=C2=A0 return create_commit(repo, result->tree, pickme,=
 replayed_base,
> > > mode);
> > > +=C2=A0=C2=A0=C2=A0 commit_list_insert(replayed_base, &parents);
> > > +=C2=A0=C2=A0=C2=A0 return create_commit(repo, result->tree, pickme,=
 parents, mode);
> > > +}
> > > +
> > > +/*
> > > + * Replay a 2-parent merge commit by composing three calls into
> > > merge-ort:
> > > + *
> > > + *=C2=A0=C2=A0 R =3D recursive merge of pickme's two original paren=
ts (auto- remerge
> > > of
> > > + *=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 the original merge, acceptin=
g any conflicts)
> > > + *=C2=A0=C2=A0 N =3D recursive merge of the (possibly rewritten) pa=
rents
> > > + *=C2=A0=C2=A0 O =3D pickme's tree (the user's actual merge, includ=
ing any manual
> > > + *=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 resolutions)
> > > + *
> > > + * The picked tree comes from a non-recursive merge using R as the =
base,
> > > + * O as side1 and N as side2. `git diff R O` is morally `git show
> > > + * --remerge-diff $oldmerge`, so this layers the user's original ma=
nual
> > > + * resolution on top of the freshly auto-merged rewritten parents (=
see
> > > + * `replay-design-notes.txt` on the `replay` branch of newren/git).
> > > + *
> > > + * If the outer 3-way merge is unclean, propagate the conflict stat=
us to
> > > + * the caller via `result->clean =3D 0` and return NULL. The two in=
ner
> > > + * merges (R and N) being unclean is _not_ fatal: the conflict-mark=
ered
> > > + * trees they produce are valid inputs to the outer merge, and usin=
g
> > > + * identical labels for both inner merges keeps the marker text
> > > + * byte-equal between R and N so the user's resolution recorded in =
O
> > > + * collapses the conflict cleanly there. Octopus merges (more than =
two
> > > + * parents) and revert-of-merge are rejected by the caller before t=
his
> > > + * function is invoked.
> > > + */
> > > +static struct commit *pick_merge_commit(struct repository *repo,
> > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 struct commit *pickme,
> > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 kh_oid_map_t *replayed_co=
mmits,
> > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 struct merge_options *mer=
ge_opt,
> > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 struct merge_result *resu=
lt)
> > > +{
> > > +=C2=A0=C2=A0=C2=A0 struct commit *parent1, *parent2;
> > > +=C2=A0=C2=A0=C2=A0 struct commit *replayed_par1, *replayed_par2;
> > > +=C2=A0=C2=A0=C2=A0 struct tree *pickme_tree;
> > > +=C2=A0=C2=A0=C2=A0 struct merge_options remerge_opt =3D { 0 };
> > > +=C2=A0=C2=A0=C2=A0 struct merge_options new_merge_opt =3D { 0 };
> > > +=C2=A0=C2=A0=C2=A0 struct merge_result remerge_res =3D { 0 };
> > > +=C2=A0=C2=A0=C2=A0 struct merge_result new_merge_res =3D { 0 };
> > > +=C2=A0=C2=A0=C2=A0 struct commit_list *parent_bases =3D NULL;
> > > +=C2=A0=C2=A0=C2=A0 struct commit_list *replayed_bases =3D NULL;
> > > +=C2=A0=C2=A0=C2=A0 struct commit_list *parents;
> > > +=C2=A0=C2=A0=C2=A0 struct commit *picked =3D NULL;
> > > +=C2=A0=C2=A0=C2=A0 char *ancestor_name =3D NULL;
> > > +
> > > +=C2=A0=C2=A0=C2=A0 parent1 =3D pickme->parents->item;
> > > +=C2=A0=C2=A0=C2=A0 parent2 =3D pickme->parents->next->item;
> > > +
> > > +=C2=A0=C2=A0=C2=A0 /*
> > > +=C2=A0=C2=A0=C2=A0=C2=A0 * Map the merge's parents to their replaye=
d counterparts. With the
> > > +=C2=A0=C2=A0=C2=A0=C2=A0 * boundary commits pre-seeded into `replay=
ed_commits`, every parent
> > > +=C2=A0=C2=A0=C2=A0=C2=A0 * either has an explicit mapping (rewritte=
n or boundary -> onto) or
> > > +=C2=A0=C2=A0=C2=A0=C2=A0 * sits outside the rewrite range entirely;=
 the latter must stay at
> > > +=C2=A0=C2=A0=C2=A0=C2=A0 * the original parent commit, so use `pare=
nt` itself as the fallback
> > > +=C2=A0=C2=A0=C2=A0=C2=A0 * for both sides.
> > > +=C2=A0=C2=A0=C2=A0=C2=A0 */
> > > +=C2=A0=C2=A0=C2=A0 replayed_par1 =3D mapped_commit(replayed_commits=
, parent1, parent1);
> > > +=C2=A0=C2=A0=C2=A0 replayed_par2 =3D mapped_commit(replayed_commits=
, parent2, parent2);
> > > +
> > > +=C2=A0=C2=A0=C2=A0 /*
> > > +=C2=A0=C2=A0=C2=A0=C2=A0 * R: auto-remerge of the original parents.
> > > +=C2=A0=C2=A0=C2=A0=C2=A0 *
> > > +=C2=A0=C2=A0=C2=A0=C2=A0 * Use the same branch labels for the inner=
 merges that compute R
> > > +=C2=A0=C2=A0=C2=A0=C2=A0 * and N so conflict markers (if any) are t=
extually identical
> > > +=C2=A0=C2=A0=C2=A0=C2=A0 * between the two; the outer non-recursive=
 merge can then collapse
> > > +=C2=A0=C2=A0=C2=A0=C2=A0 * the manual resolution from O against the=
m.
> > > +=C2=A0=C2=A0=C2=A0=C2=A0 */
> > > +=C2=A0=C2=A0=C2=A0 init_basic_merge_options(&remerge_opt, repo);
> > > +=C2=A0=C2=A0=C2=A0 remerge_opt.show_rename_progress =3D 0;
> > > +=C2=A0=C2=A0=C2=A0 remerge_opt.branch1 =3D "ours";
> > > +=C2=A0=C2=A0=C2=A0 remerge_opt.branch2 =3D "theirs";
> > > +=C2=A0=C2=A0=C2=A0 if (repo_get_merge_bases(repo, parent1, parent2,=
 &parent_bases) < 0)
> > > {
> > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 result->clean =3D -1;
> > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 goto out;
> > > +=C2=A0=C2=A0=C2=A0 }
> > > +=C2=A0=C2=A0=C2=A0 merge_incore_recursive(&remerge_opt, parent_base=
s,
> > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 parent1, parent2, &remerge_res)=
;
> > > +=C2=A0=C2=A0=C2=A0 parent_bases =3D NULL; /* consumed by merge_inco=
re_recursive */
> > > +=C2=A0=C2=A0=C2=A0 if (remerge_res.clean < 0) {
> > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 result->clean =3D remerg=
e_res.clean;
> > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 goto out;
> > > +=C2=A0=C2=A0=C2=A0 }
> > > +
> > > +=C2=A0=C2=A0=C2=A0 /* N: fresh merge of the (possibly rewritten) pa=
rents. */
> > > +=C2=A0=C2=A0=C2=A0 init_basic_merge_options(&new_merge_opt, repo);
> > > +=C2=A0=C2=A0=C2=A0 new_merge_opt.show_rename_progress =3D 0;
> > > +=C2=A0=C2=A0=C2=A0 new_merge_opt.branch1 =3D "ours";
> > > +=C2=A0=C2=A0=C2=A0 new_merge_opt.branch2 =3D "theirs";
> > > +=C2=A0=C2=A0=C2=A0 if (repo_get_merge_bases(repo, replayed_par1, re=
played_par2,
> > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 &replayed_bases) < 0) {
> > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 result->clean =3D -1;
> > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 goto out;
> > > +=C2=A0=C2=A0=C2=A0 }
> > > +=C2=A0=C2=A0=C2=A0 merge_incore_recursive(&new_merge_opt, replayed_=
bases,
> > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 replayed_par1, replayed_par2, &=
new_merge_res);
> > > +=C2=A0=C2=A0=C2=A0 replayed_bases =3D NULL; /* consumed by merge_in=
core_recursive */
> > > +=C2=A0=C2=A0=C2=A0 if (new_merge_res.clean < 0) {
> > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 result->clean =3D new_me=
rge_res.clean;
> > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 goto out;
> > > +=C2=A0=C2=A0=C2=A0 }
> > > +
> > > +=C2=A0=C2=A0=C2=A0 /*
> > > +=C2=A0=C2=A0=C2=A0=C2=A0 * Outer non-recursive merge: base=3DR, sid=
e1=3DO (pickme), side2=3DN.
> > > +=C2=A0=C2=A0=C2=A0=C2=A0 */
> > > +=C2=A0=C2=A0=C2=A0 pickme_tree =3D repo_get_commit_tree(repo, pickm=
e);
> > > +=C2=A0=C2=A0=C2=A0 ancestor_name =3D xstrfmt("auto-remerge of %s",
> > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0 oid_to_hex(&pickme->object.oid));
> > > +=C2=A0=C2=A0=C2=A0 merge_opt->ancestor =3D ancestor_name;
> > > +=C2=A0=C2=A0=C2=A0 merge_opt->branch1 =3D short_commit_name(repo, p=
ickme);
> > > +=C2=A0=C2=A0=C2=A0 merge_opt->branch2 =3D "merge of replayed parent=
s";
> > > +=C2=A0=C2=A0=C2=A0 merge_incore_nonrecursive(merge_opt,
> > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 remerge_res.tree,
> > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 pickme_tree,
> > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 new_merge_res.tree,
> > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 result);
> > > +=C2=A0=C2=A0=C2=A0 merge_opt->ancestor =3D NULL;
> > > +=C2=A0=C2=A0=C2=A0 merge_opt->branch1 =3D NULL;
> > > +=C2=A0=C2=A0=C2=A0 merge_opt->branch2 =3D NULL;
> > > +=C2=A0=C2=A0=C2=A0 if (!result->clean)
> > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 goto out;
> > > +
> > > +=C2=A0=C2=A0=C2=A0 parents =3D NULL;
> > > +=C2=A0=C2=A0=C2=A0 commit_list_insert(replayed_par2, &parents);
> > > +=C2=A0=C2=A0=C2=A0 commit_list_insert(replayed_par1, &parents);
> > > +=C2=A0=C2=A0=C2=A0 picked =3D create_commit(repo, result->tree, pic=
kme, parents,
> > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 REPLAY_MODE_PICK);
> > > +
> > > +out:
> > > +=C2=A0=C2=A0=C2=A0 free(ancestor_name);
> > > +=C2=A0=C2=A0=C2=A0 free_commit_list(parent_bases);
> > > +=C2=A0=C2=A0=C2=A0 free_commit_list(replayed_bases);
> > > +=C2=A0=C2=A0=C2=A0 merge_finalize(&remerge_opt, &remerge_res);
> > > +=C2=A0=C2=A0=C2=A0 merge_finalize(&new_merge_opt, &new_merge_res);
> > > +=C2=A0=C2=A0=C2=A0 return picked;
> > > =C2=A0 }
> > > =C2=A0 void replay_result_release(struct replay_result *result)
> > > @@ -407,17 +550,63 @@ int replay_revisions(struct rev_info *revs,
> > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 merge_opt.show_rename_progress =3D 0;
> > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 last_commit =3D onto;
> > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 replayed_commits =3D kh_init_oid_map(=
);
> > > +
> > > +=C2=A0=C2=A0=C2=A0 /*
> > > +=C2=A0=C2=A0=C2=A0=C2=A0 * Seed the rewritten-commit map with each =
negative-side ("BOTTOM")
> > > +=C2=A0=C2=A0=C2=A0=C2=A0 * cmdline entry pointing at `onto`. This m=
atters for merge replay:
> > > +=C2=A0=C2=A0=C2=A0=C2=A0 * a 2-parent merge whose first parent is t=
he boundary (e.g. the
> > > +=C2=A0=C2=A0=C2=A0=C2=A0 * commit being reworded) must replay onto =
the rewritten boundary,
> > > +=C2=A0=C2=A0=C2=A0=C2=A0 * yet pick_merge_commit uses a self fallba=
ck so the second parent
> > > +=C2=A0=C2=A0=C2=A0=C2=A0 * (a side branch outside the rewrite range=
) is preserved as-is.
> > > +=C2=A0=C2=A0=C2=A0=C2=A0 * Pre-seeding the boundary disambiguates t=
he two: in the map ->
> > > +=C2=A0=C2=A0=C2=A0=C2=A0 * rewritten, missing -> kept as-is.
> > > +=C2=A0=C2=A0=C2=A0=C2=A0 *
> > > +=C2=A0=C2=A0=C2=A0=C2=A0 * Only do this for the pick path; revert m=
ode chains reverts
> > > +=C2=A0=C2=A0=C2=A0=C2=A0 * through last_commit and a pre-seeded bou=
ndary would short-circuit
> > > +=C2=A0=C2=A0=C2=A0=C2=A0 * that chain.
> > > +=C2=A0=C2=A0=C2=A0=C2=A0 */
> > > +=C2=A0=C2=A0=C2=A0 if (mode =3D=3D REPLAY_MODE_PICK) {
> > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 for (size_t i =3D 0; i <=
 revs->cmdline.nr; i++) {
> > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 =
struct rev_cmdline_entry *e =3D &revs->cmdline.rev[i];
> > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 =
struct commit *boundary;
> > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 =
khint_t pos;
> > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 =
int hr;
> > > +
> > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 =
if (!(e->flags & BOTTOM))
> > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0 continue;
> > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 =
boundary =3D lookup_commit_reference_gently(revs->repo,
> > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 &e->item->oid=
, 1);
> > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 =
if (!boundary)
> > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0 continue;
> > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 =
pos =3D kh_put_oid_map(replayed_commits,
> > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0 boundary->object.oid, &hr);
> > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 =
if (hr !=3D 0)
> > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0 kh_value(replayed_commits, pos) =3D onto;
> > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 }
> > > +=C2=A0=C2=A0=C2=A0 }
> > > +
> > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 while ((commit =3D get_revision(revs)=
)) {
> > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 const struct =
name_decoration *decoration;
> > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 khint_t pos;
> > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 int hr;
> > > -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 if (commit->parents && c=
ommit->parents->next)
> > > -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 =
die(_("replaying merge commits is not supported yet!"));
> > > -
> > > -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 last_commit =3D pick_reg=
ular_commit(revs->repo, commit,
> > > replayed_commits,
> > > -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0 mode =3D=3D REPLAY_MODE_REVERT ? last_commit :
> > > onto,
> > > -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0 &merge_opt, &result, mode);
> > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 if (commit->parents && c=
ommit->parents->next) {
> > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 =
if (commit->parents->next->next) {
> > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0 ret =3D error(_("replaying octopus merges is not
> > > supported"));
> > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0 goto out;
> > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 =
}
> > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 =
if (mode =3D=3D REPLAY_MODE_REVERT) {
> > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0 ret =3D error(_("reverting merge commits is not
> > > supported"));
> > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0 goto out;
> > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 =
}
> > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 =
last_commit =3D pick_merge_commit(revs->repo, commit,
> > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0 replayed_commits,
> > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0 &merge_opt, &result);
> > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 } else {
> > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 =
last_commit =3D pick_regular_commit(revs->repo, commit,
> > > replayed_commits,
> > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 mode =3D=3D REPLAY_MODE_REVERT ? last=
_commit :
> > > onto,
> > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 &merge_opt, &result, mode);
> > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 }
> > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 if (!last_com=
mit)
> > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0 break;
> > > diff --git a/t/t3451-history-reword.sh b/t/t3451-history-reword.sh
> > > index de7b357685..d103f866a2 100755
> > > --- a/t/t3451-history-reword.sh
> > > +++ b/t/t3451-history-reword.sh
> > > @@ -201,12 +201,21 @@ test_expect_success 'can reword a merge commit=
' '
> > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 git switch - =
&&
> > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 git merge the=
irs &&
> > > -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 # It is not possible to =
replay merge commits embedded in the
> > > -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 # history (yet).
> > > -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 test_must_fail git -c co=
re.editor=3Dfalse history reword HEAD~
> > > 2>err &&
> > > -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 test_grep "replaying mer=
ge commits is not supported yet" err &&
> > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 # Reword a non-merge com=
mit whose descendants include the
> > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 # merge: replay carries =
the merge through.
> > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 reword_with_message HEAD=
~ <<-EOF &&
> > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 ours reworded
> > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 EOF
> > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 expect_graph <<-EOF &&
> > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 *=C2=A0=C2=A0 Merge tag =
${SQ}theirs${SQ}
> > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 |\\
> > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 | * theirs
> > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 * | ours reworded
> > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 |/
> > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 * base
> > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 EOF
> > > -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 # But it is possible to =
reword a merge commit directly.
> > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 # And reword a merge com=
mit directly.
> > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 reword_with_m=
essage HEAD <<-EOF &&
> > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 Reworded merg=
e commit
> > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 EOF
> > > @@ -214,7 +223,7 @@ test_expect_success 'can reword a merge commit' =
'
> > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 *=C2=A0=C2=A0=
 Reworded merge commit
> > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 |\
> > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 | * theirs
> > > -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 * | ours
> > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 * | ours reworded
> > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 |/
> > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 * base
> > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 EOF
> > > diff --git a/t/t3452-history-split.sh b/t/t3452-history-split.sh
> > > index 8ed0cebb50..ad6309f98b 100755
> > > --- a/t/t3452-history-split.sh
> > > +++ b/t/t3452-history-split.sh
> > > @@ -36,7 +36,7 @@ expect_tree_entries () {
> > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 test_cmp expect actual
> > > =C2=A0 }
> > > -test_expect_success 'refuses to work with merge commits' '
> > > +test_expect_success 'refuses to split a merge commit' '
> > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 test_when_finished "rm -rf repo" &&
> > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 git init repo &&
> > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 (
> > > @@ -49,9 +49,7 @@ test_expect_success 'refuses to work with merge co=
mmits'
> > > '
> > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 git switch - =
&&
> > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 git merge the=
irs &&
> > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 test_must_fai=
l git history split HEAD 2>err &&
> > > -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 test_grep "cannot split =
up merge commit" err &&
> > > -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 test_must_fail git histo=
ry split HEAD~ 2>err &&
> > > -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 test_grep "replaying mer=
ge commits is not supported yet" err
> > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 test_grep "cannot split =
up merge commit" err
> > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 )
> > > =C2=A0 '
> > > diff --git a/t/t3650-replay-basics.sh b/t/t3650-replay-basics.sh
> > > index 3353bc4a4d..368b1b0f9a 100755
> > > --- a/t/t3650-replay-basics.sh
> > > +++ b/t/t3650-replay-basics.sh
> > > @@ -103,10 +103,48 @@ test_expect_success 'cannot advance target ...
> > > ordering would be ill-defined' '
> > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 test_cmp expect actual
> > > =C2=A0 '
> > > -test_expect_success 'replaying merge commits is not supported yet' =
'
> > > -=C2=A0=C2=A0=C2=A0 echo "fatal: replaying merge commits is not supp=
orted yet!"=20
> > > >expect &&
> > > -=C2=A0=C2=A0=C2=A0 test_must_fail git replay --advance=3Dmain main.=
.topic-with-merge
> > > 2>actual &&
> > > -=C2=A0=C2=A0=C2=A0 test_cmp expect actual
> > > +test_expect_success 'using replay to rebase a 2-parent merge' '
> > > +=C2=A0=C2=A0=C2=A0 # main..topic-with-merge contains a 2-parent mer=
ge (P) introduced
> > > +=C2=A0=C2=A0=C2=A0 # via test_merge. Use --ref-action=3Dprint so th=
is test does not
> > > +=C2=A0=C2=A0=C2=A0 # mutate state for subsequent tests in this file=
.
> > > +=C2=A0=C2=A0=C2=A0 git replay --ref-action=3Dprint --onto main main=
..topic-with-merge=20
> > > >result &&
> > > +=C2=A0=C2=A0=C2=A0 test_line_count =3D 1 result &&
> > > +
> > > +=C2=A0=C2=A0=C2=A0 new_tip=3D$(cut -f 3 -d " " result) &&
> > > +
> > > +=C2=A0=C2=A0=C2=A0 # Result is still a 2-parent merge.
> > > +=C2=A0=C2=A0=C2=A0 git cat-file -p $new_tip >cat &&
> > > +=C2=A0=C2=A0=C2=A0 grep -c "^parent " cat >count &&
> > > +=C2=A0=C2=A0=C2=A0 echo 2 >expect &&
> > > +=C2=A0=C2=A0=C2=A0 test_cmp expect count &&
> > > +
> > > +=C2=A0=C2=A0=C2=A0 # Merge subject is preserved.
> > > +=C2=A0=C2=A0=C2=A0 echo P >expect &&
> > > +=C2=A0=C2=A0=C2=A0 git log -1 --format=3D%s $new_tip >actual &&
> > > +=C2=A0=C2=A0=C2=A0 test_cmp expect actual &&
> > > +
> > > +=C2=A0=C2=A0=C2=A0 # The replayed merge sits on top of main: walkin=
g back via the
> > > +=C2=A0=C2=A0=C2=A0 # first-parent chain reaches main.
> > > +=C2=A0=C2=A0=C2=A0 git merge-base --is-ancestor main $new_tip
> > > +'
> > > +
> > > +test_expect_success 'replaying an octopus merge is rejected' '
> > > +=C2=A0=C2=A0=C2=A0 # Build an octopus side-branch so the rest of th=
e test state stays
> > > +=C2=A0=C2=A0=C2=A0 # untouched.
> > > +=C2=A0=C2=A0=C2=A0 test_when_finished "git update-ref -d refs/heads=
/octopus-tip" &&
> > > +=C2=A0=C2=A0=C2=A0 octopus_tip=3D$(git commit-tree -p topic4 -p top=
ic1 -p topic3 \
> > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 -m "octopus" $(git rev-p=
arse topic4^{tree})) &&
> > > +=C2=A0=C2=A0=C2=A0 git update-ref refs/heads/octopus-tip "$octopus_=
tip" &&
> > > +
> > > +=C2=A0=C2=A0=C2=A0 test_must_fail git replay --ref-action=3Dprint -=
-onto main \
> > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 topic4..octopus-tip 2>ac=
tual &&
> > > +=C2=A0=C2=A0=C2=A0 test_grep "octopus merges" actual
> > > +'
> > > +
> > > +test_expect_success 'reverting a merge commit is rejected' '
> > > +=C2=A0=C2=A0=C2=A0 test_must_fail git replay --ref-action=3Dprint -=
-revert=3Dtopic-with-
> > > merge \
> > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 topic4..topic-with-merge=
 2>actual &&
> > > +=C2=A0=C2=A0=C2=A0 test_grep "reverting merge commits" actual
> > > =C2=A0 '
> > > =C2=A0 test_expect_success 'using replay to rebase two branches, one=
 on top of
> > > other' '
> >=20
>=20
>=20
>=20

--8323328-381085256-1779028396=:100--
