Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 240EBC433F5
	for <git@archiver.kernel.org>; Mon, 10 Jan 2022 13:49:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230236AbiAJNtf (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 10 Jan 2022 08:49:35 -0500
Received: from mout.gmx.net ([212.227.17.22]:42101 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S234216AbiAJNte (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 10 Jan 2022 08:49:34 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1641822567;
        bh=jRD3yHk2yq2HETPbpDMTXI6nLoExuHPje1koq/NV/Tw=;
        h=X-UI-Sender-Class:Date:From:To:cc:Subject:In-Reply-To:References;
        b=Z2kB2xNhxtc30dXaaLcn2WdOrVxoisZUjwBC6Oenws/eeuj20C9BZpwyYFPmWrkj6
         SkIHq0vn7SuAHbD7aQQ7g/9y1NwA8eWawhUXeDYxsXqp26RJy+4F+I5FGsjnfHroBI
         rt06k3x9sMeUtwdcDmN3oJw4qvUAq/zXRGLKiVwA=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [172.25.133.218] ([89.1.215.56]) by mail.gmx.net (mrgmx104
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1MGz1f-1nC5qO2kIl-00E8vF; Mon, 10
 Jan 2022 14:49:27 +0100
Date:   Mon, 10 Jan 2022 14:49:26 +0100 (CET)
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
In-Reply-To: <CABPp-BHpuLjCYycBwweMW_NdQrS_r3ECmvLb8XjNW-_Rau5NTw@mail.gmail.com>
Message-ID: <nycvar.QRO.7.76.6.2201101427440.339@tvgsbejvaqbjf.bet>
References: <20220105163324.73369-1-chriscool@tuxfamily.org> <CABPp-BFh7UnQtPM=tO8rfp5bPK4-7esouv5KCx1sUSESwEA=Rw@mail.gmail.com> <CAP8UFD0wKnAg5oyMWchXysPTg3K9Vb4M1tRcPzPE81QM903pYg@mail.gmail.com>
 <CABPp-BHpuLjCYycBwweMW_NdQrS_r3ECmvLb8XjNW-_Rau5NTw@mail.gmail.com>
User-Agent: Alpine 2.21.1 (DEB 209 2017-03-23)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K1:cfrE31o8P6V4E8zYsUqTsBSbm8eYU7Ut/+Cj3HTWQP3lGpvX/EP
 XHvlPGPoQKey7cAX5b2h3g5TVLQk0FNtn3r43ndz7b9PNEeO09MijQ8dShqSfPl7bx7Y1Gu
 dsFvs6tK6F8gFFzMfLLh/GS38zaIvfTK6/ff6Fy33G7F2qrxjIxYmS3vtCMISAXlgOlNXKL
 ST0sfOjL+yWE6xgX6PtMA==
X-UI-Out-Filterresults: notjunk:1;V03:K0:WNRgVilJGGE=:ocDeI42UTfuAuEpkTo8prM
 fKqY+ZuiBeMxk27Y2xZ3dVPsdg80oh+KNGI2fY9Zkk/YqQrmXh2cmpsCqA+xcqSO+wXdDA9zW
 TRqKGPmqoXsULKz19TLCqFEVh4e6DpRtHZFvAj7RF/1DuYOotOi00tHLq4rfy9LCTEPAzzs1E
 5c8BIEbpJciKMM+ypkqCsr+zEmdwO0QbnTdigJx2appBkJ2ssIa0mBXTyQCumwGLhO5h+nIdY
 j+n8F2klSlIN7tMYZ5xwJJH0q+cMaAbYo8jcDyS2GJjLUUIE+wD9I7G1sf4np8UwzyDERDNa3
 KY0s8qi7TpowIVg+lh8BHW82/SeWoPBIrGDVMcUIg5ySpX39IPx0aiwwj7jSOA9J1RVAckkcb
 RMQOjnn7r4cy/HAocrM9GlkFNk5otlqmmHpWb1nhWGswvHLiZ+qO0TCJKeQH2zTvWaeOb5zla
 56R0OUTLkpMHf9pMlclUVe64emDdPW4idD/QFrvL1qtvejqDWbrg+Bw+p+nOCGGdew04YTmcG
 /RJGQz5Jjsfxy0cVDtd8aqVyWS4KbLOwMyPJHYdPpeKhiRCDKOJvmGzcp41jgop6jL89WiTp+
 31jhLXIaBnh2UXBwEKDolt2Fle0TdwgLqqglHVFac6lNWyxGQ76lYDuh4hpNIwxKAIJqWeiY5
 FfgpshnixLyUBWA02woQrSrH7TNw5tVb8O+dsoyDheoPjzBvmQT/IsuTcDMuvxIHT0giN5wkz
 lUqlGKhl08pZFZhFekpZhA09ar5enRsszjYRUhEdqoUNkrObWiG660OaKEEDTtk2gMJ4roHYo
 fduPICWbM52Cd38VwqNhPaugSE+Pi96SS9dkmn2SYTwq/V5n6dff8fioJYgsCIMg5zDIT2SRn
 9hfyaUGTxinRv7IgFKJnx588uYqTYFkeRlROx29ZlCJFcQKIKn5VbXtqwJH++ploc0V4PFgfT
 KrsF52X4shsE0hN6IPdox/ZYvyLbnJuCqpndwct1dh0T9iFMFsdntkMfOi5ICD++GuRWrmT+V
 NOzNtIGffESUqgw4Lu2PZZpIuAo2VJTu0Nlw7/aEEO1qfwBLxwF3Nw4Op2qcWwCGV8NZzviuY
 7EFqe4lUsN4A+8=
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Elijah,

On Fri, 7 Jan 2022, Elijah Newren wrote:

> On Fri, Jan 7, 2022 at 9:58 AM Christian Couder
> <christian.couder@gmail.com> wrote:
> >
> > On Wed, Jan 5, 2022 at 5:54 PM Elijah Newren <newren@gmail.com> wrote:
> > >
> > > On Wed, Jan 5, 2022 at 8:33 AM Christian Couder
> > > <christian.couder@gmail.com> wrote:
> >
> > > > The current `git merge-tree` command though seems to have a number=
 of
> > > > issues, especially:
> > > >
> > > >   - it's too much related to the old merge recursive strategy whic=
h is
> > > >     not the default anymore since v2.34.0 and is likely to be
> > > >     deprecated over time,
> > > >
> > > >   - it seems to output things in its own special format, which is =
not
> > > >     easy to customize, and which needs special code and logic to p=
arse
> > >
> > > I agree we don't want those...but why would new merge-tree options
> > > have to use the old merge strategy or the old output format?
> >
> > Yeah, it's not necessary if there are 2 separate modes, a "real" mode
> > (like what you implemented with --real in your recent patch series)
> > and a "trivial" mode (which is the name you give to the old code).
> >
> > Adding modes like this to a command is likely to make the command and
> > its documentation more difficult to understand though. For example I
> > think that we created `git switch` because the different modes of `git
> > checkout` made the command hard to learn.
> >
> > I gave other reasons in [1] why I prefer a separate command.
> >
> > [1] https://lore.kernel.org/git/CAP8UFD1LgfZ0MT9=3DcMvxCcox++_MBBhWG9T=
wf42cMiXL42AdpQ@mail.gmail.com/
>
> I can see where you're coming from, but I think the particular
> comparison you use isn't quite apples to apples.  `git checkout` has a
> "change branches" mode and a "revert specific paths" mode.  While
> those have significant implementation overlap, they seem like
> different concepts to users.  For merge-tree, the implementation is
> completely orthogonal between the two modes, but the concept is
> basically the same from the user viewpoint.  Yes, the output differs
> in the two merge-tree modes, but command line arguments are often used
> to tweak the output (much like diff has different output styles based
> on various flags).  In fact, in [1] where you suggest a new command
> you suggest that it should have "roughly the same features as git
> merge-tree and a similar interface".  To me, that suggests that the
> two may be good candidates for being similar commands.
>
> That said, I'm not against a new command.  Personally, my main reason
> for using merge-tree wasn't because that's where I thought it was best
> to put it, but just that (IIRC) each of Dscho, Peff, and Junio
> suggested that location.
>
> My biggest gripe was just the command name...

I am against a new command for what essentially serves the original
purpose of `merge-tree`.

The fact that `merge-tree` has not seen any work in almost 12 years is
testament not only to how hard it was to disentangle the work-tree
requirement from the recursive merge (it is one of my favorite
counterexamples when anybody claims that you can easily prototype code in
a script and then convert it to C), but the fact that there is no user
within Git itself (apart from t/t4300-merge-tree.sh, which does not count)
speaks volumes about the design of that `merge-tree` tool.

So it's only fair to breathe life into it by letting it do what it was
meant to do all along.

> > Also `git merge-tree` currently outputs diffs, so I thought it would
> > be sad if the new command couldn't do it.
> >
> > [2] https://lore.kernel.org/git/211109.861r3qdpt8.gmgdl@evledraar.gmai=
l.com/
>
> Hmm, I had a totally different opinion.  I felt the diffs in the
> current merge-tree was a hack to deal with the fact that they didn't
> have good tools to make use of the results, and ended up providing a
> Rube-Goldberg scheme to do anything useful with it.

Indeed. When I had a look how libgit2 is used to perform a server-side
merge, I saw how careful the code is not to produce anything unneeded. And
since the `merge` operation is performed a ton of times even without any
user interaction, producing a diff is the _least_ of said code's concerns.

> Providing a tree is a concrete and easily usable object for end users.
> They can feed that tree to other git commands to do additional things,
> and obviates the need for the Rube-Goldberg contraption.

I strongly concur.

So I would like to reiterate my challenge to you, Christian: could you
have a look at the server-side merge of GitLab, and see what it actually
would need of the `git merge-tree` command?

I _bet_ it needs first and foremost the information "is this mergeable?".

That is by far the most common question the code I saw had to answer,
without any follow-up questions asked.

An add-on question is then "which files/directories conflicted?". And
there, it really only wanted the file names, along with the OIDs of the
respective item in the base, the HEAD and the merge branch.

In my work in December, I also had to implement another thing that I think
we will have to implement in `merge-tree` in one form or another: when
users provided merge conflict resolutions via the web UI, we want the
merge to succeed. What I implemented was this (in a nutshell, a way to
provide file names with associated blob OIDs that resolve the content
conflicts):

=2D- snip --
Author: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Date:   Thu Dec 16 20:46:35 2021 +0100
Subject: merge-ort: allow pre-resolving merge conflicts

One of merge-ort's particular strengths is that it works well even in a
worktree-less setting, e.g. in a backend for a server-side merge.

In such a scenario, it is conceivable that the merge in question not
only results in a conflict, but that the caller figures out some sort of
resolution before calling the merge again. The second call, of course,
is meant to apply the merge conflict resolution.

With this commit, we allow just that. The new, optional
`pre_resolved_conflicts` field of `struct merge_options` maps paths to
the blob OID of the resolution.

Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>

diff --git a/merge-ort.c b/merge-ort.c
index a74d4251c3..fa59ce2f97 100644
=2D-- a/merge-ort.c
+++ b/merge-ort.c
@@ -3961,6 +3961,7 @@ static void process_entries(struct merge_options *op=
t,
 	prefetch_for_content_merges(opt, &plist);
 	for (entry =3D &plist.items[plist.nr-1]; entry >=3D plist.items; --entry=
) {
 		char *path =3D entry->string;
+		struct object_id *resolved_oid;
 		/*
 		 * NOTE: mi may actually be a pointer to a conflict_info, but
 		 * we have to check mi->clean first to see if it's safe to
@@ -3972,7 +3973,17 @@ static void process_entries(struct merge_options *o=
pt,
 					  &dir_metadata);
 		if (mi->clean)
 			record_entry_for_tree(&dir_metadata, path, mi);
-		else {
+		else if (opt->pre_resolved_conflicts &&
+			 (resolved_oid =3D
+			  strmap_get(opt->pre_resolved_conflicts, path))) {
+			mi->clean =3D 1;
+			mi->is_null =3D 0;
+			memcpy(&mi->result.oid, resolved_oid,
+			       sizeof(*resolved_oid));
+			if (!mi->result.mode)
+				mi->result.mode =3D 0100644;
+			record_entry_for_tree(&dir_metadata, path, mi);
+		} else {
 			struct conflict_info *ci =3D (struct conflict_info *)mi;
 			process_entry(opt, path, ci, &dir_metadata);
 		}
diff --git a/merge-recursive.h b/merge-recursive.h
index 0795a1d3ec..1f45effdd0 100644
=2D-- a/merge-recursive.h
+++ b/merge-recursive.h
@@ -47,6 +47,13 @@ struct merge_options {
 	const char *subtree_shift;
 	unsigned renormalize : 1;

+	/*
+	 * (merge-ORT only) If non-NULL, contains a map from `path` to OID. If
+	 * the given `path would be marked as conflict, it is instead resolved
+	 * to the specified blob.
+	 */
+	struct strmap *pre_resolved_conflicts;
+
 	/* internal fields used by the implementation */
 	struct merge_options_internal *priv;
 };
=2D- snap --

It is a proof-of-concept, therefore it expects the resolved conflicts to
be in _files_. I don't think that there is a way to reasonably handle
symlink target conflicts or directory/file/symlink conflicts, but there
might be.

A subsequent commit changed my hacky `merge-tree` hack to optionally
accept NUL-terminated merge conflict resolutions in <path>/<OID> pairs via
stdin (again, avoiding files to be written where we do not _need_ spend
I/O unnecessarily).

The biggest problem we faced at the Contributor Summit was that our
discussion was not informed by the actual server-side needs. So I would
like to reiterate my challenge to make that the driver. Let's not use any
hypothetical scenario as the basis for the design of `git merge-tree`, but
let's use the concrete requirements of actual server-side merges that are
currently implemented using libgit2, when trying to figure out what
functionality we need from `merge-tree`, and in what shape.

Here is an initial list:

- need to determine whether a merge will succeed, quickly

- need the tree OID for a successful merge

- need the list of items that conflict, along with OIDs and modes, if the
  merge failed

- need a way to provide merge conflict resolutions

And now that I wrote all this, I realize I should have sent it to the
`merge-tree` thread, not the `merge-tree-ort` thread...

Ciao,
Dscho
