Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AD544ECAAA3
	for <git@archiver.kernel.org>; Fri, 26 Aug 2022 15:35:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243353AbiHZPf1 (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 26 Aug 2022 11:35:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58716 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241376AbiHZPfW (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 26 Aug 2022 11:35:22 -0400
Received: from mout.gmx.net (mout.gmx.net [212.227.17.21])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 45FFF1CFE3
        for <git@vger.kernel.org>; Fri, 26 Aug 2022 08:35:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1661528114;
        bh=fC4bz0KX5jCu42iVQzaEaA7rQj04drbQeEDrY7+Wwv0=;
        h=X-UI-Sender-Class:Date:From:To:cc:Subject:In-Reply-To:References;
        b=byO79GDt8f+nxOlPW0DnQC528tIFnJQr1COyurCsR4gSBOxJOc/X0UHNuJESN8RCx
         uSrT5cfZ1elo/w/4y3gmeRLuTnPpbnfm46fFrbEK3rZDohxgUftzwwcM5tHfWNQuf/
         zaAoUWOfdKZwkti42CDzeCS+JVn5EXPbjb8PoDOI=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [172.23.220.106] ([89.1.212.11]) by mail.gmx.net (mrgmx104
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1N2Dx8-1pQPDL3NF8-013dki; Fri, 26
 Aug 2022 17:35:13 +0200
Date:   Fri, 26 Aug 2022 17:35:14 +0200 (CEST)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
To:     Elijah Newren <newren@gmail.com>
cc:     Johannes Schindelin via GitGitGadget <gitgitgadget@gmail.com>,
        Git Mailing List <git@vger.kernel.org>
Subject: Re: [PATCH 1/3] merge-tree -z: always show the original file name
 first
In-Reply-To: <CABPp-BF24DO7vfYf856gXcfP7pT4moaiz-BUazCwYngmVCP5Pg@mail.gmail.com>
Message-ID: <6p614ron-qrsq-p802-1892-o2r4o8n72p44@tzk.qr>
References: <pull.1327.git.1660892256.gitgitgadget@gmail.com> <c6eb286b60808bc9e69ce9b09fe4389db15db492.1660892256.git.gitgitgadget@gmail.com> <CABPp-BGPioxH2-2Pde8vAqFOOoW7WvCSf_fLzRWZB3uy=9Xc=g@mail.gmail.com> <9p08998o-n88r-2nno-8703-s99o5qpn9o35@tzk.qr>
 <CABPp-BF24DO7vfYf856gXcfP7pT4moaiz-BUazCwYngmVCP5Pg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K1:64hnEneJt+PPTkNJ8RoIFjoqdjaJyTAknpMzRvrXJ1I/tFQjVui
 zPQcSuog94QCGIayyaSjl9dAZnttsS29c7ZzOr28DhgMoer9DsCRPlYpqzCgR1nwN2FZ9o1
 /EQe2kKDi+jcCxpgJFhMHSHZeiAm4Mp05s3tE0N1ytz/AaHZeunGTPWw16fy8q0lHPYuTD4
 zoV3wlpzZV241TeRT4SFQ==
X-UI-Out-Filterresults: notjunk:1;V03:K0:VkOi/TyhDEs=:CBhe+9pjcYCThp4pPpqRmN
 qbldIlaFfDPQtancm/54K+5gfScPMHksIh5eEZ7DyIcVZsB1d9Z5HE5l6AHL39dNqdQoWVqqe
 0V0bjZNXdV6JDoUCqUwUd2OA+9ztHylmqA27KMFGV6AKxmnrkREL4ux/W/3w4NFqove9RGbyx
 BusqDxrbI2XtCKAx/rbs5anK1G1LOgc882D554twZbmT2PGW6f4mRM5WvpYA/aoeAwubTSHG4
 RptHnLz2uAfNye63BmykN2Z/m3rn4lVbTkS6XTH+nAwnD9eFP8GwHbMNNjU08IdIt89Vpg6cl
 1e87mdjNPdVgDLFmGj6zxQpAWoWbVCp/gO8LT/xRUGFpOAnMX88cSL1fc8+oK+bqjv4AFs1G6
 FW5vr6jLA6JB9169kPrfLIak710Yz+9M9YHeVWdoeapE552ZyQVw8xFEyeTPoBjWOyfJBVhjV
 8wlAIUPClb0EqeBYaB71bomGdmumbz3/2IFclgWUlJHluHd4atJeA4hGlh2RC25vZDl/EMccd
 KQfpc/YUSRGlLlkCQezYhmYGsiu30O0moOYARcMwMJeC7HtBn4CQsxiMAvzlq7Nrj/lY5FN21
 hSNTP9kWM0aFWqKSkFTm6CW1tOM922zdCLhgvCMuJ5HzJyrLUehaggmLHyH4XjUzzaCoSfd/h
 LDwDUftKNO1W1uOmjAjAkCryLz7IXf1oU8+36nrAhYeot/eIsGT846RLqPBI+2lh/WRUpXxnP
 kn/zFXyk1ZprqkL8yDCgaZhoAZEOfkAjXAzIqwsVBeujACKXO5iXzMd8MOraKP4dz5jY54nVR
 tyP4UDFhAAvO+cMl9lYQCpYkf46N86vGUT035+MUkQq10VsbAAQjP+XH7Me/FnCO1tHm0amrF
 +pZI73ym4GdSi93OuuiXyHmqN62hHqArQ9hq3eSngF6Qnq3bcoT76XhUs75uUbTmjAsECt0Hu
 P5O2GqzTCca1pY/Pa53bkRyh8zv9GDUwPI81QqQE8PwHfYzIKxPuAHHqi381a6oMEPjS9WrPu
 TTXMuBqNvJrbbLcp1NP2DFdRiw3Xf/gwHNkbmiknbl+qdM+F2umEPki6Sc8ZM59J0nHUZOnUH
 e4FrjTdxrUhpNXJ1NWy5W8QCWzsgSPzR0Q/0Fjy3Ei6YlNQFsSA+/BHbg==
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Elijah,

I'll top-post because I will still need much more time to wrap my head
around everything you said in your very thoughtful reply.

By the way, have I mentioned before how much I appreciate well-edited,
well-crafted mails? It must have taken quite a bit of care and editing to
write this, and I just want to thank you for that.

As to the problem we are discussing: I am fully on board with you on the
necessity to keep the door open for rename detection and recursive merges
and the zoo of conflict types that comes with it.

After thinking about this for a couple of nights, I think I want to tackle
the design from the "other" side, namely from the UI.

At this stage, I _think_ it would do well for me to give a more high-level
context as to my motivating factors.

The thing is, these worktree-less merges do not live in a vacuum. They are
backing the Pull Request UI. There exists a relatively simple UI to
resolve simple merge conflicts, which factors into what I want from `git
merge-tree`.

You've pointed out in the past, very rightfully, that the simple way to
"pre-resolve" conflicts that I have implemented over here is just not good
enough except for a very, very limited manner of driving `git merge-tree`.
These "pre-resolved conflicts" are currently essentially a map of <path>
-> <OID> pairs.

Now, to design a much better way to present conflicts as well as allowing
users to resolve some of them (the simpler ones, like content conflicts)
in a web UI, we need `git merge-tree` to give us not an `ls-files
-u`-style output, that only works reliably for very simple cases.

In general, I think the design would work best if we parsed the `messages`
part exclusively on the server side (ignoring the `ls-files`-like output,
probably even suppressing it) and if we received enough information to
recreate the conflicts from there. Which means that we need the involved
paths (whether munged or not, I am less and less concerned) together with
the modes and OIDs. It would probably be helpful even to provide a tree
OID for the directory part of any file/directory conflict, where the web
UI could then present the contents in a tree view to the user.

This way, we could present multiple conflicts, even multiple conflicts for
the very same file, and allow resolving them individually.

And we could associate resolutions with the exact list of paths, modes and
OIDs involved, then teach `merge-tree` to optionally take such resolutions
into account, to produce merges with resolved conflicts.

Doing it this way will require substantial changes on the server side, in
particular in the UI, which currently does not have any support for
handling conflicts involving renames. It will be a lot of work, and I am
certain that I will have to pivot many times regarding the design of `git
merge-tree` features supporting that UI. I'm excited to start that
journey.

What do you think?

Ciao,
Dscho

On Mon, 22 Aug 2022, Elijah Newren wrote:

> On Mon, Aug 22, 2022 at 1:12 PM Johannes Schindelin
> <Johannes.Schindelin@gmx.de> wrote:
> >
> > Hi Elijah,
> >
> > On Sat, 20 Aug 2022, Elijah Newren wrote:
> >
> > > On Thu, Aug 18, 2022 at 11:57 PM Johannes Schindelin via GitGitGadge=
t
> > > <gitgitgadget@gmail.com> wrote:
> > > >
> > > > From: Johannes Schindelin <johannes.schindelin@gmx.de>
> > > >
> > > > When printing the messages in a machine-readable format (i.e. in `=
-z`
> > > > mode), the intention is to support third-party software that wants=
 to
> > > > present the conflicts in a "pretty" way to human readers.
> > > >
> > > > To that end, `git merge-tree -z` prefixes the conflict messages by=
 a
> > > > variable-size list of paths and a conflict identifier. This list a=
nd
> > > > this identifier are intended to be machine-parseable, the conflict
> > > > message is sort of free-form and not intended to be parsed.
> > > >
> > > > Keeping in mind that the intended use case is to have third-party
> > > > software use `git merge-tree` to perform worktree-less merges and =
then
> > > > present the conflicts (if any) to human readers, it makes much mor=
e
> > > > sense to show the original file names of the involved files instea=
d of
> > > > the ones we internally munged to allow for creating a tree object =
that
> > > > contains entries for both sides of the conflict (which requires th=
em to
> > > > have different names).
> > >
> > > I can see how this would be useful to you if it could be
> > > achieved...well, assuming you replaced "instead of" with "in additio=
n
> > > to".  It'd be a huge undertaking to achieve, though; far beyond what
> > > this series attempts.
> >
> > I feared you would say that :-)
> >
> > And I realize that I should have lead with the context that is relevan=
t to
> > understand what I am driving at.
> >
> > For now, all I am trying to do is to verify that we can achieve identi=
cal
> > results between a new code path that uses `git merge-tree` (with optio=
ns)
> > and an existing code path that uses libgit2 to perform a 3-way merge.
> >
> > To that end, I have added some patches to optionally disable rename
> > detection, to allow specifying a merge base instead of performing a fu=
ll
> > recursive merge, to optionally detect whether the `MERGE_HEAD` is alre=
ady
> > reachable from `HEAD` and in that case exit with a specific exit statu=
s,
> > among other things.
> >
> > And yes, I realize that I "only" benefit from the worktree-less nature=
 of
> > `merge-ort` so far, and not from any other aspects `merge-ort` offers.
> >
> > One thing I need from the result is a list of conflicts in the same fo=
rmat
> > as we would have received if writing out an index with conflicts and t=
hen
> > parsing just the entries with non-zero stages.
>
> Thanks, this is good context.  Especially this last paragraph, where
> you say you want the non-zero stage entries from what would be written
> to the index.  I'll return to this many times.
>
> > So for now, I do not care _so_ much about rename conflicts, or conflic=
ts
> > resulting from merging merge base candidates. I don't want to slam the
> > door shut, of course, but due to a teeny tiny bit of time pressure, I =
want
> > to focus very, very much on the libgit2-like operation for now :-)
> >
> > What I do need, however, is the unmunged filenames as well as the
> > corresponding file modes and the object hashes.
>
> If you're under time pressure...don't you already have all the
> information you need?  Why can't you just parse the <Conflicted file
> info> and <Informational messages> sections to get it?  I'll come back
> to this again with the testcase you highlighted in your series, at the
> very end of the email.
>
> > > I think your attempt here may be based on the presumption that any
> > > hash in a higher stage in the index maps directly to the hash of som=
e
> > > <revision>:<filename> pair from one of the commits being merged.  Th=
at
> > > assumption holds in simple cases, but does not hold generally.
> > > merge-ort has a very strong "(at most) 3 stages" assumption for any
> > > conflict, driven by the need to ultimately represent conflicts in th=
e
> > > index, which is pervasive in the code.
> >
> > This is actually very helpful information, this had not sunk in yet.
> >
> > So when encountering a "stage 3 before stages 1 & 2" situation arises,
> > like in the test case I added, you're saying that I could simply reord=
er
> > those and be done and not have to expect that the `stage 1 & 2` part i=
s
> > followed by _another_ stage 3 part for the same name?
> >
> > Except, of course, that I need the original file names, and the invari=
ant
> > of at most 3 stages holds true only when taking munged file names into
> > account, right?
>
> You are correct that ort is never going to present two "stage 3"
> entries for any path it reports.
>
> stages are very much an index-related concept, and always associated
> with potentially munged filenames in ort.  This importantly means that
> there is no such thing as "the unmunged filename" for some index
> entries.
>
> In order to achieve the "at most 3 stages" assumption plastered all
> over ort, it has to compress information from more than 3
> <revision>:<filename> pairs down to at most 3.  So some of those
> non-zero stage index entries do *not* correspond to a file from
> history.  Any request to get "the original filename" would somehow
> have to respond with up to three filenames instead.  (And likewise,
> any request to get "the original file contents from one of the sides
> of history" would have to respond with the content of up to three
> files instead.)
>
>
> I know, I know, you don't care because you're not dealing with renames
> right now.  But if you're modifying the code, it has to be in a way
> that doesn't paint us into a corner that doesn't work for renames.
>
> > > Trying to create such a direct mapping between higher stage conflict=
s
> > > and <revision>:<filename> pairs from the commits being merged would
> > > require breaking that assumption. That would mean getting rid of man=
y of
> > > the hardcoded array sizes of 3, as well as modifying who knows how m=
any
> > > portions of logic built around this assumption.
> > >
> > > Your attempt also seems to be based on the presumption that the
> > > original value of "path" as passed to process_entry(), represents a
> > > path from one of the two sides of history.  In simple cases, it does=
.
> > > But the assumption does not generally hold.
> >
> > Heh, in my case it always holds because I disable rename detection. Th=
e
> > only time when multiple file names are involved is in case of
> > file/directory conflicts and the like. In which case I still need the
> > original filename.
> >
> > But I would contend that we need to know the original file name(s) eve=
n in
> > the case of renames, so that we can present the users with all the
> > information pertinent to the conflict, to allow them to resolve it (so
> > that they have the full context).
>
> To reiterate, "the original file name(s)" is an ill-posed problem.  It
> only exists for some entries.  (Same for "the original file contents")
>  ...well, unless you rewire ort completely and toss out the "at most 3
> stages" assumption.
>
> > > Further...
> > >
> > > > So let's mention the original file names prominently, as first ite=
m in
> > > > that variable-size list of paths.
> > >
> > > This is in conflict with the needs of other uses of merge-ort:
> > >   * When the user is running an active merge with conflicts written =
to
> > > the index and working tree, the filenames where the conflicts are
> > > recorded may not match the original filenames, and the filenames whe=
re
> > > things are recorded is more useful and thus primary.
> > >   * For remerge-diff, the filename where the conflict would be place=
d
> > > is important because that's where stuff ends up.  Any changes the us=
er
> > > made for the final merge is relative to that munged path, so that
> > > munged path is the important bit, not the original path.
> >
> > Okay, I understand now.
> >
> > So basically, if I need different/additional information, I will _have=
_ to
> > introduce a new flag to trigger code paths that produce that.
> >
> > And my changes to the remerge test cases merely demonstrate precisely =
that
> > need.
> >
> > > Adding additional paths to path_msg() to cover other paths relevant =
to
> > > the conflict make sense, but the primary path really needs to be lef=
t
> > > as-is for these other cases.
> >
> > I fear that I will need much, much more than just the additional paths=
 ;-)
> > So far, I am parsing the `ls-files -u`-like part so that I get mode an=
d
> > hash information, but eventually I want to parse that out of the messa=
ges
> > part and that only produces lists of paths so far...
>
> List of paths + conflict type + detailed conflict message, right?
>
> > And a simple, single list of paths is not enough to convey the informa=
tion
> > that I need. Concretely, I need:
> >
> > - the original file name(s) involved in the conflict,
>
> Trying to get the original file name(s) may well cause you to need to
> include additional conflicts, since they were the cause of the name
> munging.  So, are you displaying multiple conflicts at once, or just
> gathering the extra names and printing them without the extra context?
>  If you do display multiple conflicts at once, are you focusing on one
> conflict and printing the necessary extra conflicts and paths to
> understand that one, and then potentially again listing some of those
> paths and conflicts again separately?
>
> And, to make it worse, what about cases where there is not a clear
> line between where one conflict starts and another ends?  Do you start
> just agglomerating arbitrarily many conflicts together?  And get the
> original names for all of them or some subset?  And then do you print
> all the "original file name(s)" once for the whole set, or once per
> conflict within it?
>
> I'll list some examples of what I mean below with some different
> possibilities...
>
> > - the modes and object hashes corresponding to the different stages
>
> Which you can get by parsing the <Conflict info> section, and
> comparing to the names from your list of paths, right?
>
> > - maybe some provenance information in the future, in case of complex
> >   rename/merge recursions
> >
> > In particular when presenting a file/directory conflict, it will be
> > important to know what stage refers to the file and what stage to the
> > directory (so as to know whether the respective object hash refers to =
a
> > file or even symlink and needs to be read as a blob).
>
> Is this follow-on paragraph meant to be an example of provenance
> information?  Or a separate thought?  I'm struggling a bit to follow.
>
> The stage and mode and hash information all come from the <Conflict
> info> section (i.e. the section with `ls-files -u`-like output).  You
> already have that available.  And the mode gives you the
> file/directory/symlink/submodule type.
>
> No conflict entries for a "tree" are presented (because it'd be kind
> of confusing to have a conflict entry for a tree as well as for
> several files under the tree, and allow the user to resolve them
> independently).  So, when there's a file/directory conflict in
> particular, there will not be a stage provided to represent the
> directory.
>
> But I'm not sure how relevant that all is; it feels like I'm missing
> what you mean here.
>
> > > > Note: For the modify/delete conflict type, we used to mention _onl=
y_ the
> > > > munged name in that path list. To allow for tools to read the tree
> > > > object produced by `git merge-tree -z` into a Git index in order t=
o
> > > > resolve the conflicts, it is necessary to list not only the origin=
al
> > > > name but _also_ the munged name so that the item with the munged f=
ile
> > > > name can be removed from that Git index. Therefore, this patch tea=
ches
> > > > `git merge-tree` to show both the original _and_ the munged name i=
n that
> > > > list.
> > >
> > > This makes sense.  Passing additional valid and relevant information
> > > to callers of merge-tree seems beneficial.
> >
> > And now that you mention this, I realize that this should be pulled ou=
t
> > into its own patch.
> >
> > > > Also note: This patch changes the output of the remerge diff sligh=
tly:
> > > > whereas before, we printed the notice about a file/directory confl=
ict
> > > > under the diff header mentioning the munged file name, we now prin=
t it
> > > > under a separate diff header that mentions the original file name.
> > > > That is the explanation why t4301 is touched by this patch.
> > >
> > > Sounds problematic.
> >
> > Fair enough.
> >
> > > > Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
> > > > ---
> > > >  merge-ort.c                      | 14 +++++++-------
> > > >  t/t4069-remerge-diff.sh          |  8 ++++----
> > > >  t/t4301-merge-tree-write-tree.sh |  4 ++--
> > > >  3 files changed, 13 insertions(+), 13 deletions(-)
> > > >
> > > > diff --git a/merge-ort.c b/merge-ort.c
> > > > index 01f150ef3b5..211f6823e1d 100644
> > > > --- a/merge-ort.c
> > > > +++ b/merge-ort.c
> > > > @@ -3741,6 +3741,7 @@ static void process_entry(struct merge_optio=
ns *opt,
> > > >                           struct conflict_info *ci,
> > > >                           struct directory_versions *dir_metadata)
> > > >  {
> > > > +       const char *orig_path =3D path;
> > > >         int df_file_index =3D 0;
> > > >
> > > >         VERIFY_CI(ci);
> > > > @@ -3787,7 +3788,6 @@ static void process_entry(struct merge_optio=
ns *opt,
> > > >                  */
> > > >                 struct conflict_info *new_ci;
> > > >                 const char *branch;
> > > > -               const char *old_path =3D path;
> > > >                 int i;
> > > >
> > > >                 assert(ci->merged.result.mode =3D=3D S_IFDIR);
> > >
> > > This looks like you are trying to make sure you always have the
> > > "original" path available, meaning a path corresponding to a file fr=
om
> > > one of the commits being merged.  This doesn't quite accomplish that=
,
> > > though.  Some questions:
> > >
> > >   * What about cases where "path" is a location that exists only in
> > > the merge base?  (rename/rename(1to2) is an example where this will
> > > come up)
> >
> > That's a good point. I will need to invent some way to convey all thre=
e
> > original file names in that case, not just one.
>
> Do you?  The CONFLICT_RENAME_RENAME output in the <Informational
> Messages> section will have
>     3
>     path-from-merge-base
>     path-from-side1
>     path-from-side2
>     CONFLICT (rename/rename)
>     <detailed conflict message>
> So the user of merge-tree -z already has the information to tie these
> three filenames together.  Why does process_entry() also need to have
> this information and provide it to subsequent calls?
>
> (Note that for a rename/rename(1to2) without other conflicts involved,
> process_entry() will be called for each path involved, and you'll get
> a <Conflict info> entry for each.  One of those is from the merge
> base.  So you'll have 3 <Conflict info> entries, as well as the above
> <Informational Message> to be able to tie them together.)
>
> However, my comments in the last 2 paragraphs gets us further away
> from my original question from my last email.
>
> In my previous email, I was trying to ask whether you were
> concentrating on being able to say which "side" or "branch" a file was
> from.  Index entries at stage 1 don't come from either side.  Is that
> problematic to you?
>
> > >   * What about cases where "path" is a location that does not exist
> > > anywhere in history?  (directory renames yield such a result.  e.g.
> > > side A renames olddir/ -> newdir/, and side B adds olddir/foo, then
> > > "path" will be newdir/foo)
> >
> > Hmm. As mentioned, I want to focus on the scenario with disabled renam=
es,
> > but not shut the door on rename scenarios like this one.
> >
> > So maybe I need to collect the original names in this instance, too, w=
ith
> > some (machine-parseable) indicator talking about the nature of that
> > origin.
>
> Which I think you can get from the <Informational Messages> that
> already exists... (again, example at the end)
>
> > > > @@ -3838,10 +3838,10 @@ static void process_entry(struct merge_opt=
ions *opt,
> > > >                 strmap_put(&opt->priv->paths, path, new_ci);
> > > >
> > > >                 path_msg(opt, CONFLICT_FILE_DIRECTORY, 0,
> > > > -                        path, old_path, NULL, NULL,
> > > > +                        orig_path, path, NULL, NULL,
> > > >                          _("CONFLICT (file/directory): directory i=
n the way "
> > > >                            "of %s from %s; moving it to %s instead=
."),
> > > > -                        old_path, branch, path);
> > > > +                        orig_path, branch, path);
> > > >                 /*
> > > >                  * Zero out the filemask for the old ci.  At this =
point, ci
> > > > @@ -3921,7 +3921,7 @@ static void process_entry(struct merge_optio=
ns *opt,
> > > >
> > > >                         if (rename_a && rename_b) {
> > > >                                 path_msg(opt, CONFLICT_DISTINCT_MO=
DES, 0,
> > > > -                                        path, a_path, b_path, NUL=
L,
> > > > +                                        orig_path, a_path, b_path=
, NULL,
> > > >                                          _("CONFLICT (distinct typ=
es): %s had "
> > > >                                            "different types on eac=
h side; "
> > > >                                            "renamed both of them s=
o each can "
> > > > @@ -3929,7 +3929,7 @@ static void process_entry(struct merge_optio=
ns *opt,
> > > >                                          path);
> > > >                         } else {
> > > >                                 path_msg(opt, CONFLICT_DISTINCT_MO=
DES, 0,
> > > > -                                        path, rename_a ? a_path :=
 b_path,
> > > > +                                        orig_path, rename_a ? a_p=
ath : b_path,
> > > >                                          NULL, NULL,
> > > >                                          _("CONFLICT (distinct typ=
es): %s had "
> > > >                                            "different types on eac=
h side; "
> > >
> > > I think for both of these last two cases, path =3D=3D orig_path, so =
you
> > > haven't actually made an effective change here.
> >
> > Not quite. If `ci->df_conflict && ci->merged.result.mode !=3D 0`, then=
 we
> > assign `path =3D unique_path(opt, path, branch);` and `path` no longer
> > refers to the same string as `orig_path`.
> >
> > It is possible that there is no actual code path that hits that clause=
 and
> > then also hits the `CONFLICT_DISTINC_MODES` calls, but I think there i=
s:
> > if a file has changed to a symlink in one branch _and_ was replaced by=
 a
> > directory in the other branch.
>
> The "ci->filemask >=3D 6" check that guards this code prevents any such
> possibility.  In particular, from your example, if it was changed to a
> symlink in one branch and replaced by a directory in the other branch,
> then ci->filemask is either 3 or 5, which would prevent the code from
> getting here.
>
> > > (And, as above, I want path to always be the primary_path passed to
> > > path_msg() as other code was written with that assumption in mind.)
> > >
> > > > @@ -4022,7 +4022,7 @@ static void process_entry(struct merge_optio=
ns *opt,
> > > >                         if (S_ISGITLINK(merged_file.mode))
> > > >                                 reason =3D _("submodule");
> > > >                         path_msg(opt, CONFLICT_CONTENTS, 0,
> > > > -                                path, NULL, NULL, NULL,
> > > > +                                orig_path, NULL, NULL, NULL,
> > > >                                  _("CONFLICT (%s): Merge conflict =
in %s"),
> > > >                                  reason, path);
> > > >                 }
> > >
> > > Here's another case where path =3D=3D orig_path, so you haven't made=
 an
> > > effective change.
> >
> > I cannot think of a case where a file/directory conflict can also resu=
lt
> > in a content conflict, so at least in the regular 3-way merge, I think
> > you're right and this changed line does the same as before in all case=
s.
> >
> > > But this one highlights something interesting...
> > >
> > > In addition to the fact that path/orig_path may be a location that
> > > didn't exist on either side of history, there might actually be two
> > > relevant paths from the two different sides of history which are
> > > involved in the content merge, with neither of them being path or
> > > orig_path.  Let me break it down, starting with a simpler two path
> > > case:
> > >
> > > If we have a standard rename, e.g. foo -> bar, and both sides modifi=
ed
> > > the file but did so in a conflicting manner, then we will end up in
> > > this chunk of code.  The conflict info emitted by merge-tree -z whic=
h
> > > is always of the form
> > >   <number-of-paths>NUL<path1>NUL<path2>NUL<pathN>NUL<stable-short-ty=
pe-description>NUL<message>NUL
> > > will in this particular case be
> > >    1<NUL>bar<NUL>Auto-merging<NUL>Auto-merging bar<newline><NUL>
> > >    1<NUL>bar<NUL>CONFLICT (contents)<NUL>CONFLICT (content): Merge
> > > conflict in bar<newline><NUL>
> > > Neither of these messages has any mention of "foo", despite the fact
> > > that "foo" was the name of the file in both the merge base and one
> > > side, and "bar" was only the name of the file on one side.
> >
> > I guess so, as no conflict message will mention the rename: it does no=
t
> > conflict.
>
> Right, so we should probably also produce informational messages for
> normal renames; adding a path_msg() call to the "/* normal rename */"
> code path should do it.  Though, I think we might only want such
> messages when merge-tree -z is being used.  (Or perhaps if some kind
> of higher verbosity is requested?)
>
> > > Now, let's make it more interesting.  side A modifies foo, and renam=
es
> > > olddir/->newdir/.  side B modifies foo in a conflicting manner, and
> > > renames foo->olddir/bar.  Our `merge-tree -z` conflict information
> > > emitted will be of the form
> > >    1<NUL>newdir/bar<NUL>Auto-merging<NUL>Auto-merging newdir/bar<new=
line><NUL>
> > >    1<NUL>newdir/bar<NUL>CONFLICT (contents)<NUL>CONFLICT (content):
> > > Merge conflict in newdir/bar<newline><NUL>
> > > For this more interesting case, the only files that existed were "fo=
o"
> > > and "olddir/bar", neither of which are mentioned in the conflict inf=
o.
> > > The conflict info only reports on "newdir/bar".
> > >
> > > And for both of these examples, your patch doesn't change the existi=
ng
> > > behavior at all since path =3D=3D orig_path for this hunk of the pat=
ch.
> >
> > That is true, too.
> >
> > Which makes me think that the consuming code I have to work with will =
need
> > some elaborate changes when it wants to start supporting renames.
> >
> > But that's not the stage where I'm at right now.
> >
> > > > @@ -4067,7 +4067,7 @@ static void process_entry(struct merge_optio=
ns *opt,
> > > >                          */
> > > >                 } else {
> > > >                         path_msg(opt, CONFLICT_MODIFY_DELETE, 0,
> > > > -                                path, NULL, NULL, NULL,
> > > > +                                orig_path, path, NULL, NULL,
> > > >                                  _("CONFLICT (modify/delete): %s d=
eleted in %s "
> > > >                                    "and modified in %s.  Version %=
s of %s left "
> > > >                                    "in tree."),
> > >
> > > Adding orig_path here after path would make sense, though it's still
> > > incomplete.  For example if a path was modified and renamed on one
> > > side, and deleted on the other, then we'd get to this hunk, and the
> > > modify/delete would omit information about the other path.  Further,
> > > directory renames could be at play, such that neither orig_path nor
> > > path would correspond to a filename in either of the commits being
> > > merged.
> > >
> > > There are also other path_msg() calls that should probably be inform=
ed
> > > of additional filenames due to simple renames: CONFLICT_CONTENTS (as
> > > noted above), CONFLICT_BINARY, and INFO_AUTO_MERGING.
> > >
> > > Going beyond simple renames, if you want "fully original" filenames,
> > > then we'd probably have to audit nearly all the path_msg() calls for
> > > when directory renames are possible, and modify the directory renami=
ng
> > > code to plumb the original name through to this layer.
> > >
> > > And even if we do all that, then we still aren't matching what I thi=
nk
> > > you are expecting where every conflicted higher order entry we repor=
t
> > > maps to a single <revision>:<filename> pairing.  We may have a highe=
r
> > > stage conflict entry that represents merged contents of three
> > > different filecontents from three different filenames.  For example,
> > > if someone has the following setup:
> > >
> > >    Commit O: one file named "original"
> > >    Commit A: modify original + rename to primordial
> > >    Commit B: add file named primordial, modify original differently =
+
> > > rename it to primary
> > >
> > > where A & B both have O as a parent or ancestor, and O is the unique
> > > merge base of A & B.  Now if we try to merge A & B, then the index
> > > will have four higher order entries (using <mode> <hash>
> > > <stage-number> <filename>, as we'd see from either `ls-files -u` sty=
le
> > > output or from the first part of merge-tree -z output):
> > >
> > >     100644 <hash of O:original> 1 original
> > >     100644 <hash of auto-merge of O:original, A:primordial, &
> > > B:primary> 3 primary
> > >     100644 <hash of auto-merge of O:original, A:primordial, &
> > > B:primary> 2 primordial
> > >     100644 <hash of B:primordial> 3 primordial
> > >
> > > Note that the two middle entries, despite having one name attached t=
o
> > > them, actually come from a merge of three different files.  Further,
> > > that hash for those two entries will not have yet appeared as the
> > > contents for any blob in any revision of history, and will in fact
> > > represent a file with conflict markers (even if none of the original
> > > files -- O:original, A:primodial, B:primary -- had any conflicts).
> > > And, the version of "primodial" in the merge-result-tree would likel=
y
> > > have nested conflict markers, despite O being a unique merge base
> > > (meaning we get nested conflict markers without merging merge bases)=
.
> > >
> > > Trying to have all the conflict output from merge-tree map to some
> > > original file the user had from one of their sides of history is thu=
s
> > > a goal that merge-ort is nowhere close to satisfying.  I'm not even
> > > sure it's tractable.
> >
> > Sure, but I am getting more and more convinced that we will need to
> > provide "sort of" the original name. Somehow.
>
> Can I ask in more detail what you want to present to a user?  Maybe
> it'd help frame the conversation more.
>
> Let me provide two examples, each with lots of alternatives, to see if
> any are the kind of output you want to be able to present to a user
> (and assume in each case it's not just a block message but you have
> some kind of programmatic knowledge of the components referenced in
> the message):
>
> Example 1.
>
> Are you thinking of something like "The following files were involved
> in a modify/delete conflict: foo, olddir/bar, newdir/bar,
> newdir/bar~B", followed by three other conflict messages that also invol=
ve
> those same files?
>
> Or, more like: "The following files were involved in a directory
> rename, and in a rename/delete conflict, and in a file/directory
> conflict, and in a modify/delete conflict: foo, olddir/bar,
> newdir/bar, newdir/bar~B"
>
> Or, more like: "The following files were involved in a directory
> rename, and in a rename/delete conflict, and in a file/directory
> conflict, and in a modify/delete conflict: foo (from side A),
> olddir/bar (from side B), newdir/bar (munged name), newdir/bar~B
> (munged name)"
>
> Or, more like: "The file newdir/bar~B has a modify/delete conflict.
> It was renamed to newdir/bar~B from newdir/bar because of a
> file/directory conflict.  It was renamed to newdir/bar from olddir/bar
> because of a directory rename.  It was renamed from foo to olddir/bar
> on side B.  foo was deleted on side A."
>
> Or, more like: "foo was deleted on side A, and renamed to olddir/bar
> on side B.  olddir/bar was renamed to newdir/bar because of a
> directory rename.  newdir/bar was renamed to newdir/bar~B because of a
> file/directory conflict.  newdir/bar~B has a modify/delete conflict."
>
> Or something completely different?
>
>
> Example 2.
>
> Are you thinking of something like: "The following files were involved
> in an add/add conflict: file-one, file-two, file-three, file-four, and
> file-five" ?
>
> Or, is it more like: "The following files were involved in an add/add
> conflict: file-one (from branch A), file-two (from merge base),
> file-three (from branch A), file-three (from branch B), file-four
> (from merge base), and file-five (from branch B)" ?
>
> Or, is it more like: "The following files were involved in an add/add
> conflict: file-three (from [see details]) and file-three (from [see
> details]).  Note that file-three was part of a rename/rename(1to2)
> conflict, which involved file-one (from branch A), file-two (from
> merge base), and file-three (from branch B).  Note that file-three was
> part of a rename/rename(1to2) conflict, which involved file-three
> (from branch A), file-four (from merge base), and file-five (from
> branch B)"
>
> Or, is it more like: "file-three was part of a rename/rename(1to2)
> conflict, which involved file-one (from branch A), file-two (from
> merge base), and file-three (from branch B).  file-three was part of a
> rename/rename(1to2) conflict, which involved file-three (from branch
> A), file-four (from merge base), and file-five (from branch B).
> file-three and file-three are involved in an add/add conflict"
>
> (Of course, all of this example is assuming we're just focusing on the
> ultimate file-three vs file-three add/add conflict, not the additional
> conflicts that file-one and file-five may be involved in.)
>
> Or are you wanting to display something completely different?
>
>
>
> I think we already have enough info to do most of the above.
>
> The main shortcoming is just that path_msg() calls for various
> rename-oriented conflicts might also need to be augmented with
> branches (though perhaps that's natural to do if we consider the list
> passed to it to be a list of names rather than just a list of
> pathnames; then we can just add the branch(s) to the list)
>
> > That is, if there were successful (directory) renames happening before=
 the
> > 3-way merge that resulted in a conflict, then I do not really care if =
the
> > "original original" filename isn't shown. But I do care that the filen=
ame
> > before munging is shown (and yes, we should probably also show the mun=
ged
> > filename).
>
> No, directory renames are part of the filename munging done *by* the
> three-way merge (not before it).  That munging, though, applies before
> process_entry() is called.  Here's an example (from Example 1 above):
>
>    Commit O: foo, olddir/{a,b,c}
>    Commit A: delete foo, rename olddir/ -> newdir/, add newdir/bar/file
>    Commit B: modify foo & rename foo -> olddir/bar
>
> Here, A had a file named "foo".  B had a file named "olddir/bar"
> (renamed from foo).  The merge notices the olddir/ -> newdir/
> directory rename in A and munges the filename further to "newdir/bar".
> The merge also notices that there is a directory in the way of
> "newdir/bar", and thus munges the filename even further to
> "newdir/bar~B".  This would result in two higher order stages in the
> `ls-files -u`-style output, both for newdir/bar~B.
>
> The "original filename" for one of those is "foo" and for the other is
> "olddir/bar".  However, the value for "path" passed to the lone
> "process_entry()" call will be "newdir/bar".  The value of "path"
> after the call to unique_path() will be "newdir/bar~B".  Neither
> "newdir/bar" or "newdir/bar~B" is an original filename.
>
> > And since recursive merges can result in multiple levels of munging, i=
t
> > gets harder to explain what I want, but I think you'll get the idea th=
at
> > the "pre-munged" filename of one conflict could be the "post-munged"
> > filename of a conflict that happened at a lower level of that recursio=
n.
>
> Yes, recursing makes things more interesting.  But even if you assume
> a unique merge-base, you still cannot assume that there is any such
> thing as "the original filename" for an entry in the `ls-files -u` outpu=
t.
>
> > > However, there is a much smaller scoped goal that we could easily
> > > achieve: providing additional filename information in the path_msg()
> > > calls, much like you start to do with the modify/delete case.
> >
> > Sure, but we also need an indicator somehow what purpose each of those
> > additional filenames serve. I guess we could make it implicit, just li=
ke
> > we make it implicit that the first path in a file/directory conflict
> > refers to the file's name and the second to the directory's.
>
> Yes, I mean the point of the <Informational messages> was to provide
> parsable information and this was what I had in mind when I created
> it.
>
> Very minor nitpick, though: the first path refers to the *munged*
> file's name, and the second path refers to the directory's name.  (If
> the file and directory had different names before our additional
> munging, we wouldn't have needed that additional munging).
>
> > But it makes
> > me a bit uneasy and I wish we had more like a structure instead of jus=
t a
> > string that we could print out. That would make it possible to convey
> > from where (as in "which branch?") the file or directory came.
>
> And what about other cases where there is no "the branch" that a file
> came from?  For example, doing rename + add/add:
>
>     Commit O: foo
>     Commit A: modify foo + rename foo->bar
>     Commit B: modify foo, add unrelated bar
>
> In this case, we'll have a "bar" at stage 3 representing B:bar.  We'll
> also get a three-way merge of O:foo, A:bar, and B:foo, stuck in a
> stage 2 entry under the filename bar.  The stage 2 entry for bar did
> not come from one branch, it represents merged contents that came from
> all three commits.
>
> > > > diff --git a/t/t4069-remerge-diff.sh b/t/t4069-remerge-diff.sh
> > > > index 35f94957fce..bc580a242ac 100755
> > > > --- a/t/t4069-remerge-diff.sh
> > > > +++ b/t/t4069-remerge-diff.sh
> > > > @@ -131,11 +131,12 @@ test_expect_success 'setup non-content confl=
icts' '
> > > >  test_expect_success 'remerge-diff with non-content conflicts' '
> > > >         git log -1 --oneline resolution >tmp &&
> > > >         cat <<-EOF >>tmp &&
> > > > +       diff --git a/file_or_directory b/file_or_directory
> > > > +       remerge CONFLICT (file/directory): directory in the way of=
 file_or_directory from HASH (side1); moving it to file_or_directory~HASH =
(side1) instead.
> > > >         diff --git a/file_or_directory~HASH (side1) b/wanted_conte=
nt
> > > >         similarity index 100%
> > > >         rename from file_or_directory~HASH (side1)
> > > >         rename to wanted_content
> > > > -       remerge CONFLICT (file/directory): directory in the way of=
 file_or_directory from HASH (side1); moving it to file_or_directory~HASH =
(side1) instead.
> > > >         diff --git a/letters b/letters
> > > >         remerge CONFLICT (rename/rename): letters renamed to lette=
rs_side1 in HASH (side1) and to letters_side2 in HASH (side2).
> > > >         diff --git a/letters_side2 b/letters_side2
> > > > @@ -168,7 +169,7 @@ test_expect_success 'remerge-diff with non-con=
tent conflicts' '
> > > >  test_expect_success 'remerge-diff w/ diff-filter=3DU: all conflic=
t headers, no diff content' '
> > > >         git log -1 --oneline resolution >tmp &&
> > > >         cat <<-EOF >>tmp &&
> > > > -       diff --git a/file_or_directory~HASH (side1) b/file_or_dire=
ctory~HASH (side1)
> > > > +       diff --git a/file_or_directory b/file_or_directory
> > > >         remerge CONFLICT (file/directory): directory in the way of=
 file_or_directory from HASH (side1); moving it to file_or_directory~HASH =
(side1) instead.
> > > >         diff --git a/letters b/letters
> > > >         remerge CONFLICT (rename/rename): letters renamed to lette=
rs_side1 in HASH (side1) and to letters_side2 in HASH (side2).
> > > > @@ -184,14 +185,13 @@ test_expect_success 'remerge-diff w/ diff-fi=
lter=3DU: all conflict headers, no dif
> > > >         test_cmp expect actual
> > > >  '
> > > >
> > > > -test_expect_success 'remerge-diff w/ diff-filter=3DR: relevant fi=
le + conflict header' '
> > > > +test_expect_success 'remerge-diff w/ diff-filter=3DR: relevant fi=
le' '
> > > >         git log -1 --oneline resolution >tmp &&
> > > >         cat <<-EOF >>tmp &&
> > > >         diff --git a/file_or_directory~HASH (side1) b/wanted_conte=
nt
> > > >         similarity index 100%
> > > >         rename from file_or_directory~HASH (side1)
> > > >         rename to wanted_content
> > > > -       remerge CONFLICT (file/directory): directory in the way of=
 file_or_directory from HASH (side1); moving it to file_or_directory~HASH =
(side1) instead.
> > > >         EOF
> > > >         # We still have some sha1 hashes above; rip them out so te=
st works
> > > >         # with sha256
> > >
> > > All of these look like regressions to me; you discussed these in a
> > > separate email so I'll go into detail in response to that one.
> >
> > Thank you for being so diligent. I always appreciate it when I see a
> > well-written, obviously well-edited mail. I find it very considerate.
> >
> > You did a good job at convincing me that my approach is sub-optimal, a=
nd
> > that we need at least one new flag to get the information that I need =
to
> > produce in my use case because the caller requires it to present a nic=
e
> > conflict resolution UI to the users.
>
> I'm not so sure you need additional information.  Don't the
> <Conflicted file info> and <Informational messages> provide enough
> info already, for the usecases you are considering?  In particular,
> you were trying to add a testcase in your series for a simple
> directory/file conflict, but for such a case you can already determine
> original filenames.  The <Conflicted file info> and <Informational
> messages> sections of the `merge-tree -z` output for these, after
> replacing NUL characters with newlines, would be:
>
>     120000 <HASH> 3 origfile
>     100644 <HASH> 1 origfile~branch
>     100644 <HASH> 2 origfile~branch
>
>     2
>     origfile
>     origfile~branch
>     CONFLICT (distinct modes)
>     CONFLICT (distinct types): whatever had different types on each
> side; renamed one of them so each can be recorded somewhere.
>
> Now, the "distinct modes" conflict always results in filename munging,
> with both names listed.  So, from this output, you know the original
> name is "origfile" whenever you see "origfile~branch".  So now you can
> present all the `ls-files -u` output from the first section with
> remapping munged filenames back to original filenames.
>
> Doesn't that solve your immediate usecase already, without even
> needing any merge-ort changes?
>
