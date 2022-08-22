Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 73AF7C28D13
	for <git@archiver.kernel.org>; Mon, 22 Aug 2022 20:12:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233153AbiHVUMu (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 22 Aug 2022 16:12:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38860 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231202AbiHVUMs (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 22 Aug 2022 16:12:48 -0400
Received: from mout.gmx.net (mout.gmx.net [212.227.17.21])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 02A58543C5
        for <git@vger.kernel.org>; Mon, 22 Aug 2022 13:12:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1661199163;
        bh=pZup7DGG/w5cbAgpIRWiSYSJVA/u232vtPTb4SBxMGE=;
        h=X-UI-Sender-Class:Date:From:To:cc:Subject:In-Reply-To:References;
        b=Gk7LGWwyEUqy9aK3VyRpD2lQF4X+/lCAWykWA1C0lyGYUnEZkEDzYZN8NvqIzKZuE
         StpcIxFhjPnChPZGcF9h3Jy45n7fMK3y/4tyjadDaG9JgCYVxc+ql1EoPbGyv7ow2I
         8xxNlev+O+mWH5IJFGHeulebv7e4mUDSre7++M1w=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [172.23.220.106] ([89.1.212.11]) by mail.gmx.net (mrgmx105
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1MXp9Y-1oyFKI39cy-00YBUA; Mon, 22
 Aug 2022 22:12:42 +0200
Date:   Mon, 22 Aug 2022 22:12:42 +0200 (CEST)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
To:     Elijah Newren <newren@gmail.com>
cc:     Johannes Schindelin via GitGitGadget <gitgitgadget@gmail.com>,
        Git Mailing List <git@vger.kernel.org>
Subject: Re: [PATCH 1/3] merge-tree -z: always show the original file name
 first
In-Reply-To: <CABPp-BGPioxH2-2Pde8vAqFOOoW7WvCSf_fLzRWZB3uy=9Xc=g@mail.gmail.com>
Message-ID: <9p08998o-n88r-2nno-8703-s99o5qpn9o35@tzk.qr>
References: <pull.1327.git.1660892256.gitgitgadget@gmail.com> <c6eb286b60808bc9e69ce9b09fe4389db15db492.1660892256.git.gitgitgadget@gmail.com> <CABPp-BGPioxH2-2Pde8vAqFOOoW7WvCSf_fLzRWZB3uy=9Xc=g@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K1:7vlKXk6d+JV/cy0Q7o1Vgn8h2VHmVojfK/jRDxZ3YUrpckcDG2M
 TKzXrN4jEXPR5oHdPt26pwcZyf6CD3BKR38jnu+SJhKXDNXuqhuH4JXxM1tsKAOtLdpJvhU
 4WukxmfOAAWnWuVstDurG4o0ftRm3LQ6gfV80X8H0V1Mfh+IQeXcV26ECfdHLMntQ3Nwc/b
 qwV2Ive3rQaMSg6MjLa6w==
X-UI-Out-Filterresults: notjunk:1;V03:K0:O6Z0j5apaZ0=:RYloHZRddU0FFX9TwbvPeQ
 JHQAJr5bAEPhZw87ghWWvnKehNQCcJPho6vX4dAgcwVL5gS5AzIXWP9TPptNWs+GdQo74IKIP
 MTVBdg9A75dnyrUZuOe240NFKaE6WKqRhgAj6VoG+PtaRKlrvjZo+EJdPhis0cSdgLb9Mw/2x
 61F23vtOJHDBJwasoQuNhialOzptIj9TPnnnjCtIE0+e/w7QgDVc10SeR05I/nBM762IU1KZT
 esVNVCrPFUSLrB0VFIXgMhff8FVyP6albo9GKJzkmBfmNVBN28jlAzVvnKQEhLG4+U3LZzjE2
 NcC3oA+sOgRXxjCZ0OYIkp7NEDj/+QjhtILVyfv2814M9TVX5S+R5ak1f+zfcKufmmgYEgOeQ
 1KEVVUtnvH1R5aVb7lN/pul0qwhvWmY+jQbq9DwaR7rQ1LoJjr97V1x9vg+eaeLbYCbNbolSe
 laykOwUs5qA3hfAsJCGqt3I/HKyWhi70EW99zdWjBdrUnJQ8/Nz/hbfG3w452GJ5uFqRphRx1
 NQsaZhz1acbbSH/Ps3rPX40eNfJ7APESsO1NVaSMAfFqS9SSaIS7odjl05KhQaSZD156wcuQC
 Shd866R8vqoilW62mrm0A+eCjTAeK/WLB7KQvaXA1dA00F+JREr6dB43cw+ptqrFa0hOsflEj
 fTuz63zc49PP1cOs2MPEfsApLXDfCf+nySMAhlQRA98SSTyYsb7gENd/9v3mrI3p0yh6SgK0M
 Wp40zkzlc2RK1rx1fTyaVvlvBngy4azdslsSn5Z4qCvbe+UcDtxpUO9V593pa7hdRo2detFit
 PIdTj8rkY2FWIIZC3CK/NHw9UCO68GBcF7vc7HAhJuHjsKuJISw+lnXzmrSQxgWTDnlh96bGH
 cJmUNRMt1wfLPpMJyocMqLrUMO1gJIlkRifAn/9b7A/taeleWiM6PctIO6PsXwLNxWMmOl3oy
 aOPtwwy89Zw/n9hTQ+h4LQLX08gb1cu8L0IS2JY4UDP5HSRZibxnkZ0NBfDdwD+iAZi4athiR
 w3AIo1XaqmPuWWpp/MMgR9mwftp5D79OlvEXYzpRGAbz5pOSW7TnKL+ZDmO8FTGCK7LZwCBNe
 i+2qbEm1BuvCcZ7dhvXxvi7kKgI+8c9Wrpn0HXFG/Q85qYLPitPNhwF0w==
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Elijah,

On Sat, 20 Aug 2022, Elijah Newren wrote:

> On Thu, Aug 18, 2022 at 11:57 PM Johannes Schindelin via GitGitGadget
> <gitgitgadget@gmail.com> wrote:
> >
> > From: Johannes Schindelin <johannes.schindelin@gmx.de>
> >
> > When printing the messages in a machine-readable format (i.e. in `-z`
> > mode), the intention is to support third-party software that wants to
> > present the conflicts in a "pretty" way to human readers.
> >
> > To that end, `git merge-tree -z` prefixes the conflict messages by a
> > variable-size list of paths and a conflict identifier. This list and
> > this identifier are intended to be machine-parseable, the conflict
> > message is sort of free-form and not intended to be parsed.
> >
> > Keeping in mind that the intended use case is to have third-party
> > software use `git merge-tree` to perform worktree-less merges and then
> > present the conflicts (if any) to human readers, it makes much more
> > sense to show the original file names of the involved files instead of
> > the ones we internally munged to allow for creating a tree object that
> > contains entries for both sides of the conflict (which requires them t=
o
> > have different names).
>
> I can see how this would be useful to you if it could be
> achieved...well, assuming you replaced "instead of" with "in addition
> to".  It'd be a huge undertaking to achieve, though; far beyond what
> this series attempts.

I feared you would say that :-)

And I realize that I should have lead with the context that is relevant to
understand what I am driving at.

For now, all I am trying to do is to verify that we can achieve identical
results between a new code path that uses `git merge-tree` (with options)
and an existing code path that uses libgit2 to perform a 3-way merge.

To that end, I have added some patches to optionally disable rename
detection, to allow specifying a merge base instead of performing a full
recursive merge, to optionally detect whether the `MERGE_HEAD` is already
reachable from `HEAD` and in that case exit with a specific exit status,
among other things.

And yes, I realize that I "only" benefit from the worktree-less nature of
`merge-ort` so far, and not from any other aspects `merge-ort` offers.

One thing I need from the result is a list of conflicts in the same format
as we would have received if writing out an index with conflicts and then
parsing just the entries with non-zero stages.

So for now, I do not care _so_ much about rename conflicts, or conflicts
resulting from merging merge base candidates. I don't want to slam the
door shut, of course, but due to a teeny tiny bit of time pressure, I want
to focus very, very much on the libgit2-like operation for now :-)

What I do need, however, is the unmunged filenames as well as the
corresponding file modes and the object hashes.

> I think your attempt here may be based on the presumption that any
> hash in a higher stage in the index maps directly to the hash of some
> <revision>:<filename> pair from one of the commits being merged.  That
> assumption holds in simple cases, but does not hold generally.
> merge-ort has a very strong "(at most) 3 stages" assumption for any
> conflict, driven by the need to ultimately represent conflicts in the
> index, which is pervasive in the code.

This is actually very helpful information, this had not sunk in yet.

So when encountering a "stage 3 before stages 1 & 2" situation arises,
like in the test case I added, you're saying that I could simply reorder
those and be done and not have to expect that the `stage 1 & 2` part is
followed by _another_ stage 3 part for the same name?

Except, of course, that I need the original file names, and the invariant
of at most 3 stages holds true only when taking munged file names into
account, right?

> Trying to create such a direct mapping between higher stage conflicts
> and <revision>:<filename> pairs from the commits being merged would
> require breaking that assumption. That would mean getting rid of many of
> the hardcoded array sizes of 3, as well as modifying who knows how many
> portions of logic built around this assumption.
>
> Your attempt also seems to be based on the presumption that the
> original value of "path" as passed to process_entry(), represents a
> path from one of the two sides of history.  In simple cases, it does.
> But the assumption does not generally hold.

Heh, in my case it always holds because I disable rename detection. The
only time when multiple file names are involved is in case of
file/directory conflicts and the like. In which case I still need the
original filename.

But I would contend that we need to know the original file name(s) even in
the case of renames, so that we can present the users with all the
information pertinent to the conflict, to allow them to resolve it (so
that they have the full context).

> Further...
>
> > So let's mention the original file names prominently, as first item in
> > that variable-size list of paths.
>
> This is in conflict with the needs of other uses of merge-ort:
>   * When the user is running an active merge with conflicts written to
> the index and working tree, the filenames where the conflicts are
> recorded may not match the original filenames, and the filenames where
> things are recorded is more useful and thus primary.
>   * For remerge-diff, the filename where the conflict would be placed
> is important because that's where stuff ends up.  Any changes the user
> made for the final merge is relative to that munged path, so that
> munged path is the important bit, not the original path.

Okay, I understand now.

So basically, if I need different/additional information, I will _have_ to
introduce a new flag to trigger code paths that produce that.

And my changes to the remerge test cases merely demonstrate precisely that
need.

> Adding additional paths to path_msg() to cover other paths relevant to
> the conflict make sense, but the primary path really needs to be left
> as-is for these other cases.

I fear that I will need much, much more than just the additional paths ;-)
So far, I am parsing the `ls-files -u`-like part so that I get mode and
hash information, but eventually I want to parse that out of the messages
part and that only produces lists of paths so far...

And a simple, single list of paths is not enough to convey the information
that I need. Concretely, I need:

- the original file name(s) involved in the conflict,
- the modes and object hashes corresponding to the different stages
- maybe some provenance information in the future, in case of complex
  rename/merge recursions

In particular when presenting a file/directory conflict, it will be
important to know what stage refers to the file and what stage to the
directory (so as to know whether the respective object hash refers to a
file or even symlink and needs to be read as a blob).

> > Note: For the modify/delete conflict type, we used to mention _only_ t=
he
> > munged name in that path list. To allow for tools to read the tree
> > object produced by `git merge-tree -z` into a Git index in order to
> > resolve the conflicts, it is necessary to list not only the original
> > name but _also_ the munged name so that the item with the munged file
> > name can be removed from that Git index. Therefore, this patch teaches
> > `git merge-tree` to show both the original _and_ the munged name in th=
at
> > list.
>
> This makes sense.  Passing additional valid and relevant information
> to callers of merge-tree seems beneficial.

And now that you mention this, I realize that this should be pulled out
into its own patch.

> > Also note: This patch changes the output of the remerge diff slightly:
> > whereas before, we printed the notice about a file/directory conflict
> > under the diff header mentioning the munged file name, we now print it
> > under a separate diff header that mentions the original file name.
> > That is the explanation why t4301 is touched by this patch.
>
> Sounds problematic.

Fair enough.

> > Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
> > ---
> >  merge-ort.c                      | 14 +++++++-------
> >  t/t4069-remerge-diff.sh          |  8 ++++----
> >  t/t4301-merge-tree-write-tree.sh |  4 ++--
> >  3 files changed, 13 insertions(+), 13 deletions(-)
> >
> > diff --git a/merge-ort.c b/merge-ort.c
> > index 01f150ef3b5..211f6823e1d 100644
> > --- a/merge-ort.c
> > +++ b/merge-ort.c
> > @@ -3741,6 +3741,7 @@ static void process_entry(struct merge_options *=
opt,
> >                           struct conflict_info *ci,
> >                           struct directory_versions *dir_metadata)
> >  {
> > +       const char *orig_path =3D path;
> >         int df_file_index =3D 0;
> >
> >         VERIFY_CI(ci);
> > @@ -3787,7 +3788,6 @@ static void process_entry(struct merge_options *=
opt,
> >                  */
> >                 struct conflict_info *new_ci;
> >                 const char *branch;
> > -               const char *old_path =3D path;
> >                 int i;
> >
> >                 assert(ci->merged.result.mode =3D=3D S_IFDIR);
>
> This looks like you are trying to make sure you always have the
> "original" path available, meaning a path corresponding to a file from
> one of the commits being merged.  This doesn't quite accomplish that,
> though.  Some questions:
>
>   * What about cases where "path" is a location that exists only in
> the merge base?  (rename/rename(1to2) is an example where this will
> come up)

That's a good point. I will need to invent some way to convey all three
original file names in that case, not just one.

>   * What about cases where "path" is a location that does not exist
> anywhere in history?  (directory renames yield such a result.  e.g.
> side A renames olddir/ -> newdir/, and side B adds olddir/foo, then
> "path" will be newdir/foo)

Hmm. As mentioned, I want to focus on the scenario with disabled renames,
but not shut the door on rename scenarios like this one.

So maybe I need to collect the original names in this instance, too, with
some (machine-parseable) indicator talking about the nature of that
origin.

> > @@ -3838,10 +3838,10 @@ static void process_entry(struct merge_options=
 *opt,
> >                 strmap_put(&opt->priv->paths, path, new_ci);
> >
> >                 path_msg(opt, CONFLICT_FILE_DIRECTORY, 0,
> > -                        path, old_path, NULL, NULL,
> > +                        orig_path, path, NULL, NULL,
> >                          _("CONFLICT (file/directory): directory in th=
e way "
> >                            "of %s from %s; moving it to %s instead."),
> > -                        old_path, branch, path);
> > +                        orig_path, branch, path);
> >                 /*
> >                  * Zero out the filemask for the old ci.  At this poin=
t, ci
> > @@ -3921,7 +3921,7 @@ static void process_entry(struct merge_options *=
opt,
> >
> >                         if (rename_a && rename_b) {
> >                                 path_msg(opt, CONFLICT_DISTINCT_MODES,=
 0,
> > -                                        path, a_path, b_path, NULL,
> > +                                        orig_path, a_path, b_path, NU=
LL,
> >                                          _("CONFLICT (distinct types):=
 %s had "
> >                                            "different types on each si=
de; "
> >                                            "renamed both of them so ea=
ch can "
> > @@ -3929,7 +3929,7 @@ static void process_entry(struct merge_options *=
opt,
> >                                          path);
> >                         } else {
> >                                 path_msg(opt, CONFLICT_DISTINCT_MODES,=
 0,
> > -                                        path, rename_a ? a_path : b_p=
ath,
> > +                                        orig_path, rename_a ? a_path =
: b_path,
> >                                          NULL, NULL,
> >                                          _("CONFLICT (distinct types):=
 %s had "
> >                                            "different types on each si=
de; "
>
> I think for both of these last two cases, path =3D=3D orig_path, so you
> haven't actually made an effective change here.

Not quite. If `ci->df_conflict && ci->merged.result.mode !=3D 0`, then we
assign `path =3D unique_path(opt, path, branch);` and `path` no longer
refers to the same string as `orig_path`.

It is possible that there is no actual code path that hits that clause and
then also hits the `CONFLICT_DISTINC_MODES` calls, but I think there is:
if a file has changed to a symlink in one branch _and_ was replaced by a
directory in the other branch.

> (And, as above, I want path to always be the primary_path passed to
> path_msg() as other code was written with that assumption in mind.)
>
> > @@ -4022,7 +4022,7 @@ static void process_entry(struct merge_options *=
opt,
> >                         if (S_ISGITLINK(merged_file.mode))
> >                                 reason =3D _("submodule");
> >                         path_msg(opt, CONFLICT_CONTENTS, 0,
> > -                                path, NULL, NULL, NULL,
> > +                                orig_path, NULL, NULL, NULL,
> >                                  _("CONFLICT (%s): Merge conflict in %=
s"),
> >                                  reason, path);
> >                 }
>
> Here's another case where path =3D=3D orig_path, so you haven't made an
> effective change.

I cannot think of a case where a file/directory conflict can also result
in a content conflict, so at least in the regular 3-way merge, I think
you're right and this changed line does the same as before in all cases.

> But this one highlights something interesting...
>
> In addition to the fact that path/orig_path may be a location that
> didn't exist on either side of history, there might actually be two
> relevant paths from the two different sides of history which are
> involved in the content merge, with neither of them being path or
> orig_path.  Let me break it down, starting with a simpler two path
> case:
>
> If we have a standard rename, e.g. foo -> bar, and both sides modified
> the file but did so in a conflicting manner, then we will end up in
> this chunk of code.  The conflict info emitted by merge-tree -z which
> is always of the form
>   <number-of-paths>NUL<path1>NUL<path2>NUL<pathN>NUL<stable-short-type-d=
escription>NUL<message>NUL
> will in this particular case be
>    1<NUL>bar<NUL>Auto-merging<NUL>Auto-merging bar<newline><NUL>
>    1<NUL>bar<NUL>CONFLICT (contents)<NUL>CONFLICT (content): Merge
> conflict in bar<newline><NUL>
> Neither of these messages has any mention of "foo", despite the fact
> that "foo" was the name of the file in both the merge base and one
> side, and "bar" was only the name of the file on one side.

I guess so, as no conflict message will mention the rename: it does not
conflict.

> Now, let's make it more interesting.  side A modifies foo, and renames
> olddir/->newdir/.  side B modifies foo in a conflicting manner, and
> renames foo->olddir/bar.  Our `merge-tree -z` conflict information
> emitted will be of the form
>    1<NUL>newdir/bar<NUL>Auto-merging<NUL>Auto-merging newdir/bar<newline=
><NUL>
>    1<NUL>newdir/bar<NUL>CONFLICT (contents)<NUL>CONFLICT (content):
> Merge conflict in newdir/bar<newline><NUL>
> For this more interesting case, the only files that existed were "foo"
> and "olddir/bar", neither of which are mentioned in the conflict info.
> The conflict info only reports on "newdir/bar".
>
> And for both of these examples, your patch doesn't change the existing
> behavior at all since path =3D=3D orig_path for this hunk of the patch.

That is true, too.

Which makes me think that the consuming code I have to work with will need
some elaborate changes when it wants to start supporting renames.

But that's not the stage where I'm at right now.

> > @@ -4067,7 +4067,7 @@ static void process_entry(struct merge_options *=
opt,
> >                          */
> >                 } else {
> >                         path_msg(opt, CONFLICT_MODIFY_DELETE, 0,
> > -                                path, NULL, NULL, NULL,
> > +                                orig_path, path, NULL, NULL,
> >                                  _("CONFLICT (modify/delete): %s delet=
ed in %s "
> >                                    "and modified in %s.  Version %s of=
 %s left "
> >                                    "in tree."),
>
> Adding orig_path here after path would make sense, though it's still
> incomplete.  For example if a path was modified and renamed on one
> side, and deleted on the other, then we'd get to this hunk, and the
> modify/delete would omit information about the other path.  Further,
> directory renames could be at play, such that neither orig_path nor
> path would correspond to a filename in either of the commits being
> merged.
>
> There are also other path_msg() calls that should probably be informed
> of additional filenames due to simple renames: CONFLICT_CONTENTS (as
> noted above), CONFLICT_BINARY, and INFO_AUTO_MERGING.
>
> Going beyond simple renames, if you want "fully original" filenames,
> then we'd probably have to audit nearly all the path_msg() calls for
> when directory renames are possible, and modify the directory renaming
> code to plumb the original name through to this layer.
>
> And even if we do all that, then we still aren't matching what I think
> you are expecting where every conflicted higher order entry we report
> maps to a single <revision>:<filename> pairing.  We may have a higher
> stage conflict entry that represents merged contents of three
> different filecontents from three different filenames.  For example,
> if someone has the following setup:
>
>    Commit O: one file named "original"
>    Commit A: modify original + rename to primordial
>    Commit B: add file named primordial, modify original differently +
> rename it to primary
>
> where A & B both have O as a parent or ancestor, and O is the unique
> merge base of A & B.  Now if we try to merge A & B, then the index
> will have four higher order entries (using <mode> <hash>
> <stage-number> <filename>, as we'd see from either `ls-files -u` style
> output or from the first part of merge-tree -z output):
>
>     100644 <hash of O:original> 1 original
>     100644 <hash of auto-merge of O:original, A:primordial, &
> B:primary> 3 primary
>     100644 <hash of auto-merge of O:original, A:primordial, &
> B:primary> 2 primordial
>     100644 <hash of B:primordial> 3 primordial
>
> Note that the two middle entries, despite having one name attached to
> them, actually come from a merge of three different files.  Further,
> that hash for those two entries will not have yet appeared as the
> contents for any blob in any revision of history, and will in fact
> represent a file with conflict markers (even if none of the original
> files -- O:original, A:primodial, B:primary -- had any conflicts).
> And, the version of "primodial" in the merge-result-tree would likely
> have nested conflict markers, despite O being a unique merge base
> (meaning we get nested conflict markers without merging merge bases).
>
> Trying to have all the conflict output from merge-tree map to some
> original file the user had from one of their sides of history is thus
> a goal that merge-ort is nowhere close to satisfying.  I'm not even
> sure it's tractable.

Sure, but I am getting more and more convinced that we will need to
provide "sort of" the original name. Somehow.

That is, if there were successful (directory) renames happening before the
3-way merge that resulted in a conflict, then I do not really care if the
"original original" filename isn't shown. But I do care that the filename
before munging is shown (and yes, we should probably also show the munged
filename).

And since recursive merges can result in multiple levels of munging, it
gets harder to explain what I want, but I think you'll get the idea that
the "pre-munged" filename of one conflict could be the "post-munged"
filename of a conflict that happened at a lower level of that recursion.

> However, there is a much smaller scoped goal that we could easily
> achieve: providing additional filename information in the path_msg()
> calls, much like you start to do with the modify/delete case.

Sure, but we also need an indicator somehow what purpose each of those
additional filenames serve. I guess we could make it implicit, just like
we make it implicit that the first path in a file/directory conflict
refers to the file's name and the second to the directory's. But it makes
me a bit uneasy and I wish we had more like a structure instead of just a
string that we could print out. That would make it possible to convey
from where (as in "which branch?") the file or directory came.

> > diff --git a/t/t4069-remerge-diff.sh b/t/t4069-remerge-diff.sh
> > index 35f94957fce..bc580a242ac 100755
> > --- a/t/t4069-remerge-diff.sh
> > +++ b/t/t4069-remerge-diff.sh
> > @@ -131,11 +131,12 @@ test_expect_success 'setup non-content conflicts=
' '
> >  test_expect_success 'remerge-diff with non-content conflicts' '
> >         git log -1 --oneline resolution >tmp &&
> >         cat <<-EOF >>tmp &&
> > +       diff --git a/file_or_directory b/file_or_directory
> > +       remerge CONFLICT (file/directory): directory in the way of fil=
e_or_directory from HASH (side1); moving it to file_or_directory~HASH (sid=
e1) instead.
> >         diff --git a/file_or_directory~HASH (side1) b/wanted_content
> >         similarity index 100%
> >         rename from file_or_directory~HASH (side1)
> >         rename to wanted_content
> > -       remerge CONFLICT (file/directory): directory in the way of fil=
e_or_directory from HASH (side1); moving it to file_or_directory~HASH (sid=
e1) instead.
> >         diff --git a/letters b/letters
> >         remerge CONFLICT (rename/rename): letters renamed to letters_s=
ide1 in HASH (side1) and to letters_side2 in HASH (side2).
> >         diff --git a/letters_side2 b/letters_side2
> > @@ -168,7 +169,7 @@ test_expect_success 'remerge-diff with non-content=
 conflicts' '
> >  test_expect_success 'remerge-diff w/ diff-filter=3DU: all conflict he=
aders, no diff content' '
> >         git log -1 --oneline resolution >tmp &&
> >         cat <<-EOF >>tmp &&
> > -       diff --git a/file_or_directory~HASH (side1) b/file_or_director=
y~HASH (side1)
> > +       diff --git a/file_or_directory b/file_or_directory
> >         remerge CONFLICT (file/directory): directory in the way of fil=
e_or_directory from HASH (side1); moving it to file_or_directory~HASH (sid=
e1) instead.
> >         diff --git a/letters b/letters
> >         remerge CONFLICT (rename/rename): letters renamed to letters_s=
ide1 in HASH (side1) and to letters_side2 in HASH (side2).
> > @@ -184,14 +185,13 @@ test_expect_success 'remerge-diff w/ diff-filter=
=3DU: all conflict headers, no dif
> >         test_cmp expect actual
> >  '
> >
> > -test_expect_success 'remerge-diff w/ diff-filter=3DR: relevant file +=
 conflict header' '
> > +test_expect_success 'remerge-diff w/ diff-filter=3DR: relevant file' =
'
> >         git log -1 --oneline resolution >tmp &&
> >         cat <<-EOF >>tmp &&
> >         diff --git a/file_or_directory~HASH (side1) b/wanted_content
> >         similarity index 100%
> >         rename from file_or_directory~HASH (side1)
> >         rename to wanted_content
> > -       remerge CONFLICT (file/directory): directory in the way of fil=
e_or_directory from HASH (side1); moving it to file_or_directory~HASH (sid=
e1) instead.
> >         EOF
> >         # We still have some sha1 hashes above; rip them out so test w=
orks
> >         # with sha256
>
> All of these look like regressions to me; you discussed these in a
> separate email so I'll go into detail in response to that one.

Thank you for being so diligent. I always appreciate it when I see a
well-written, obviously well-edited mail. I find it very considerate.

You did a good job at convincing me that my approach is sub-optimal, and
that we need at least one new flag to get the information that I need to
produce in my use case because the caller requires it to present a nice
conflict resolution UI to the users.

Back to the drawing table for me, I guess.

Thank you!
Dscho
