Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8285CC07E9D
	for <git@archiver.kernel.org>; Tue, 27 Sep 2022 06:09:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229877AbiI0GJY (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 27 Sep 2022 02:09:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49380 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229530AbiI0GJW (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 27 Sep 2022 02:09:22 -0400
Received: from mail-lj1-x22f.google.com (mail-lj1-x22f.google.com [IPv6:2a00:1450:4864:20::22f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E89C2A8CF4
        for <git@vger.kernel.org>; Mon, 26 Sep 2022 23:09:18 -0700 (PDT)
Received: by mail-lj1-x22f.google.com with SMTP id x29so9817459ljq.2
        for <git@vger.kernel.org>; Mon, 26 Sep 2022 23:09:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date;
        bh=jehZDHAafHdl8KhFfv5YoxCujFluYnXwpLSSvrExTIM=;
        b=WczE5qY2v978Zvzt4+THajT51YV3JOHPsM5jcq3NSaC0ebODgoovWn9jrMme24+2C/
         D1PMBY1vd4loxrlBBWCa31JT4VbxC6VrVQc6PkOh5UeVi4VWv5fBxb2O+60A50ENOyT2
         Ua1PrZ4iSOPTvcmOOLIBbhifjyEkyuiKu14Gj9i216AJjSYTtkNsMOaRYR4tOHw/RmaJ
         IY0461hJ5P1g7tmK5vel3zdV07903cKe5yOZeln950zv3Wtpz6ji9jWXYcwKEH7J+sHi
         cpoLhNLVt0qKxwlEZ/3olC4M5dawtBSmcIgw8nZITL3LUvYwUwbEbPoT/Zu3MoX+Srp1
         r6tA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date;
        bh=jehZDHAafHdl8KhFfv5YoxCujFluYnXwpLSSvrExTIM=;
        b=4Ry96fpMUkNVQ5Y546GC1er03gC0r1BxJ9Cq5KOsVF89rWWaTuncOWyZIQ8kHlHt+g
         +3W7hha2r9aINQt+Wwe+X5/RxSlaqv5rimZf2C5Q2ULSIdBrLyepPStFs5anGhbwoqFR
         /0HOF0VxHdv8mObCO8e6DZO5AWfs+tnyvf8c+vjxM+PsilKuu7MbB5SQuaJ050N2F/Po
         IbH9H2BSpPbgf6qVaJW6twLOQVfTrw9lcyJIXlXPxJ+n2pxDGwDoJCiTehSsPh/Lt9nB
         Kj2JbpqFa8xQTt++D7jmUc1Fe/7Hn2ojmBVNdDUmG2iarDqIGTI5UG26maDxFqj30UEw
         bikQ==
X-Gm-Message-State: ACrzQf1eJlAKH7sGk9YHRzFohowB3VNxFuaMAtApIu2mXCXNoaHaIwF6
        LwErX1rvXdc4F7CMlP4Ui2UGvBu96OAj0f0BrdM=
X-Google-Smtp-Source: AMsMyM6jgHiZaUSyfXfIgEA0/R6lRuyTmNDi6yx62D+ssdV/I8vTl0/SegS0wqbVmUdLapcoei+GF3peb+niazhFd+8=
X-Received: by 2002:a05:651c:903:b0:26c:2f7f:c037 with SMTP id
 e3-20020a05651c090300b0026c2f7fc037mr9686224ljq.325.1664258956350; Mon, 26
 Sep 2022 23:09:16 -0700 (PDT)
MIME-Version: 1.0
References: <pull.1367.git.1664064588846.gitgitgadget@gmail.com> <a89413b5-464b-2d54-5b8c-4502392afde8@github.com>
In-Reply-To: <a89413b5-464b-2d54-5b8c-4502392afde8@github.com>
From:   Elijah Newren <newren@gmail.com>
Date:   Mon, 26 Sep 2022 23:09:04 -0700
Message-ID: <CABPp-BHGrxLPu_S3y2zG-U6uo0rM5TYYEREZa2A=e=d9VZb2PA@mail.gmail.com>
Subject: Re: [PATCH] sparse-checkout.txt: new document with sparse-checkout directions
To:     Victoria Dye <vdye@github.com>
Cc:     Elijah Newren via GitGitGadget <gitgitgadget@gmail.com>,
        Git Mailing List <git@vger.kernel.org>,
        Derrick Stolee <derrickstolee@github.com>,
        Shaoxuan Yuan <shaoxuan.yuan02@gmail.com>,
        Matheus Tavares <matheus.bernardino@usp.br>,
        ZheNing Hu <adlternative@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Sep 26, 2022 at 1:09 PM Victoria Dye <vdye@github.com> wrote:
>
> Elijah Newren via GitGitGadget wrote:
> > From: Elijah Newren <newren@gmail.com>
> >
> > Once upon a time, Matheus wrote some patches to make
> >    git grep [--cached | <REVISION>] ...
> > restrict its output to the sparsity specification when working in a
> > sparse checkout[1].  That effort got derailed by two things:
> >
> >   (1) The --sparse-index work just beginning which we wanted to avoid
> >       creating conflicts for
> >   (2) Never deciding on flag and config names and planned high level
> >       behavior for all commands.
> >
> > More recently, Shaoxuan implemented a more limited form of Matheus'
> > patches that only affected --cached, using a different flag name,
> > but also changing the default behavior in line with what Matheus did.
> > This again highlighted the fact that we never decided on command line
> > flag names, config option names, and the big picture path forward.
> >
> > The --sparse-index work has been mostly complete (or at least released
> > into production even if some small edges remain) for quite some time
> > now.  We have also had several discussions on flag and config names,
> > though we never came to solid conclusions.  Stolee once upon a time
> > suggested putting all these into some document in
> > Documentation/technical[3], which Victoria recently also requested[4].
> > I'm behind the times, but here's a patch attempting to finally do that.
>
> Thank you so much for writing this!
>
> > diff --git a/Documentation/technical/sparse-checkout.txt b/Documentation/technical/sparse-checkout.txt
> > new file mode 100644
> > index 00000000000..b213b2b3f35
> > --- /dev/null
> > +++ b/Documentation/technical/sparse-checkout.txt
> > @@ -0,0 +1,670 @@
> > +Table of contents:
> > +
> > +  * Purpose of sparse-checkouts
> > +  * Desired behavior
> > +  * Subcommand-dependent defaults
> > +  * Implementation Questions
> > +  * Implementation Goals/Plans
> > +  * Known bugs
> > +  * Reference Emails
> > +
> > +
> > +=== Purpose of sparse-checkouts ===
> > +
> > +sparse-checkouts exist to allow users to work with a subset of their
> > +files.
> > +
> > +The idea is simple enough, but there are two different high-level
> > +usecases which affect how some Git subcommands should behave.  Further,
> > +even if we only considered one of those usecases, sparse-checkouts
> > +modify different subcommands in over a half dozen different ways.  Let's
> > +start by considering the high level usecases in this section:
> > +
> > +  A) Users are _only_ interested in the sparse portion of the repo
> > +
> > +  B) Users want a sparse working tree, but are working in a larger whole
>
> Both of these use cases make sense to me! Two thoughts/comments:
>
> 1. This could be a "me" problem, but I regularly struggle with "sparse"
>    having different meanings in similar contexts. For example, a "sparse
>    directory" is one *with* 'SKIP_WORKTREE' applied vs. "the sparse portion
>    of the repo"  here refers to the files *without* 'SKIP_WORKTREE' applied.
>    A quick note/section outlining some standard terminology would be
>    immensely helpful.

Yeah, that's a good point.  I think we maybe misnamed the sparse
directory entries, and that led to other naming problems.

I like your idea of adding a terminology section; I'll add one.

> 2. One detail I'd like this document to clarify is the similarity/difference
>    between "in the sparse portion of the repo" and "does not have
>    'SKIP_WORKTREE' applied." In a well-behaved sparse-checkout, these are
>    one in the same. However, if a user removes 'SKIP_WORKTREE' from a file
>    (either with 'update-index' or by checking it out on disk), commands
>    *sometimes* treat it as inside the sparse checkout (e.g., 'git status'),
>    and some treat it as outside (e.g., 'git add'). Technically, I think it
>    comes down to whether a command uses sparse patterns + 'SKIP_WORKTREE' to
>    determine sparsity vs. just 'SKIP_WORKTREE', but the varying behavior
>    feels inconsistent as an end user.

Yeah, that's a good point, I should address this.  There are
additional ways to get more files too -- resolving conflicts, or
commands like `stash` that auto-vivify intentionally, or commands that
accidentally auto-vivify (various merge backends), etc.  Anyway,
here's my current mental model, in case it helps:

* In a well-behaved situation, the sparse specification is given
directly by the $GIT_DIR/info/sparse-checkout file.
* The working tree can transiently have an expanded sparse
specification, due to a variety of reasons like resolving conflicts or
running various commands that might add or restore files to the
working tree.
   * Such transient differences can and will be automatically removed
as a side-effect of commands which call unpack_trees() (checkout,
merge, reset, etc.).
   * Users can also request such transient differences be corrected
via running `git sparse-checkout reapply`
   * Additional commands are also welcome to implicitly fix these differences.
   * Because of the above three items, users should make no assumption
that files in a transiently expanded (or restricted) sparse
specification will persist unless they manually explicitly request an
expansion or restriction (via e.g. the `set` or `add` subcommands of
sparse-checkout.)
   * (Yes, we avoid removing files when there are unstaged changes or
conflicts, since we don't want to lose user data.  I don't think that
undermines the general point of the last few bullets).
* The behavior wanted when doing something like "git grep expression
REVISION" is roughly what the users would expect from "git checkout
REVISION && git grep expression" (I know, we add "REVISION:" prefixes,
so it's not exactly the same, but it captures the high level idea).
This has a couple ramifications:
   * REVISION may have paths not in the current index, so there is no
path we can consult for a SKIP_WORKTREE setting for those paths.
   * Since a checkout tries to remove transient differences in the
sparse specification, it makes sense to use the corrected sparse
specification (i.e. $GIT_DIR/info/sparse-checkout) rather than
attempting to consult SKIP_WORKTREE anyway.
   * Therefore, a transiently expanded (or restricted) sparse
specification *only* applies to the working tree and perhaps index.
It does not apply for history queries.

We kind of discussed this previously for why SKIP_WORKTREE not
matching the normal sparse specification should only apply to the
worktree and not to history, in the context of grep[*]:

"""
For the worktree and cached cases, we iterate over paths without
the SKIP_WORKTREE bit set, and limit our searches to these paths.  For
the $REVISION case, we limit the paths we search to those that match
the sparsity patterns.  (We do not check the SKIP_WORKTREE bit for the
$REVISION case, because $REVISION may contain paths that do not exist
in HEAD and thus for which we have no SKIP_WORKTREE bit to consult.
The sparsity patterns tell us how the SKIP_WORKTREE bit would be set
if we were to check out $REVISION, so we consult those.  Also, we
don't use the sparsity paths with the worktree or cached cases, both
because we have a bit we can check directly and more efficiently, and
because unmerged entries from a merge or a rebase could cause more
files to temporarily be present than the sparsity patterns would
normally select.)
"""

(That email also discussed the weird case of being given a TREE
instead of a REVISION, which mucks things up a bit.)

[*] https://lore.kernel.org/git/CABPp-BFsCPPNOZ92JQRJeGyNd0e-TCW-LcLyr0i_+VSQJP+GCg@mail.gmail.com/

> > +
> > +=== Desired behavior ===
> > +
> > +As noted in the previous section, despite the simple idea of just
> > +working with a subset of files, there are a range of different
> > +behavioral changes that need to be made to different subcommands to work
> > +well with such a feature.  See [1,2,3,4,5,6,7,8,9,10] for various
> > +examples.  In particular, at [2], we saw that mere composition of other
> > +commands that individually worked correctly in a sparse-checkout context
> > +did not imply that the higher level command would work correctly; it
> > +sometimes requires further tweaks.  So, understanding these differences
> > +can be beneficial.
> > +
> > +* Commands behaving the same regardless of high-level use-case
> > +
> > +  * commands that only look at files within the sparsity specification
> > +
> > +      * status
> > +      * diff (without --cached or REVISION arguments)
> > +      * grep (without --cached or REVISION arguments)
>
> 'status' and 'diff' currently show information about untracked files outside
> the working tree (since, not being in the index, they don't have a
> 'SKIP_WORKTREE' to use).

'status' does, yes, but...I thought 'diff' only applied to tracked
files.  How do you get 'diff' to show information about untracked
files?

(Are you by chance referring to either (1) --no-index which requires
paths to be explicitly specified and thus --[no-]restrict is
irrelevant, or (2) --ignore-submodules, in which case I think
--[no-]restrict is also irrelevant since --[no-]restrict would apply
to the supermodule and the untracked files would just be ones found
within the submodule?)

> Should that change with the proposed '--restrict' option?

Here's how I look at it:

One way to view the purpose of sparse-checkouts is that it subdivides
"tracked" files into two categories -- a sparse subset, and all the
rest.  We mark "all the rest" with SKIP_WORKTREE.  The SKIP_WORKTREE
files are still tracked, just not present in the working copy.
`--restrict` is a modifier that only works to differentiate between
those two groups of tracked files.  In particular, `--restrict` exists
to allow us to specify that operations that normally operate on
tracked files should instead operate on that subset (and likewise,
`--no-restrict` exists to allow us to specify that operations that
default to working on a subset of tracked files should instead operate
on all tracked files).

untracked files are not tracked.  As such `--[no-]restrict` should not
affect how untracked files are treated...except when dealing with the
tracked/untracked boundary and moving files across that boundary (e.g.
with add/rm/mv).  In fact, I think that's why those three commands
have their own special category.

> > +
> > +  * commands that restore files to the working tree that match sparsity patterns, and
> > +    remove unmodified files that don't match those patterns:
> > +
> > +      * switch
> > +      * checkout (the switch-like half)
> > +      * read-tree
> > +      * reset --hard
> > +
> > +      * `restore` & the restore-like half of `checkout` SHOULD be in this above
> > +     category, but are buggy (see the "Known bugs" section below)
>
> These commands do behave differently if there are *modified* files outside
> the sparsity patterns:

I don't understand this claim; using checkout/switch:

$ git sparse-checkout disable
$ git status --porcelain
 M tracked-but-maybe-skipped
$ git checkout main~1
error: Your local changes to the following files would be overwritten
by checkout:
tracked-but-maybe-skipped
Please commit your changes or stash them before you switch branches.
Aborting
$ git sparse-checkout set --no-cone /tracked 2>/dev/null
$ git ls-files -t  # Note: tracked-but-maybe-skipped is outside
sparsity patterns, but modified
H tracked
H tracked-but-maybe-skipped
$ git checkout main~1
error: Your local changes to the following files would be overwritten
by checkout:
tracked-but-maybe-skipped
Please commit your changes or stash them before you switch branches.
Aborting

Exact same error in both sparse and non-sparse checkouts, even when
the sparse-checkout has a modified file outside the sparsity patterns.

> - 'switch', 'checkout' (switch-like), and 'read-tree -m' block the operation
>   & advise on how to clean up the modified files to re-align with the
>   sparsity patterns.

Perhaps you have a different case in mind than I do?  I'm not aware of
anywhere that switch/checkout does this.  (If I modified the above
testcase to have the changes be staged, I still get the same error
both with or without a sparse-checkout, and that error doesn't mention
sparsity patterns in any way.)  I tried grepping around the source
code, but maybe I'm missing something?

> - 'reset --hard' silently drops the modified file and resets the
>   'SKIP_WORKTREE' bit on the corresponding index entry.
>
> With the exception of 'reset --hard' (aggressively and unconditionally
> cleaning the worktree & index is an important aspect of the command, IMO),
> I'd personally like to see commands in this category align with the behavior
> of 'switch' where they don't already.

Oh, are you thinking that `reset --hard` has a different kind of
modification made to it in sparse-checkouts than the other commands in
this category?

I still don't see it, even if that's what you're referring to.  Each
of these commands, in a sparse-checkout, performs its operation within
the sparsity specification, and then attempts to aggressively cull
differences between the sparsity specification and the sparsity
patterns (by marking unmodified files outside the sparsity patterns as
SKIP_WORKTREE and removing them, and marking files matching the
sparsity patterns which were previously SKIP_WORKTREE as
!SKIP_WORKTREE and restoring them to the working tree).  Perhaps some
examples would help:

Having switch/checkout restore paths matching sparsity patterns:
  $ rm tracked
  $ git status --porcelain
   D tracked
  $ git update-index --skip-worktree tracked
  $ git status --porcelain
  $ git ls-files -t
  S tracked
  $

  $ git checkout HEAD~1
  $ git status --porcelain
  $ git ls-files -t
  H tracked

Having switch/checkout remove paths that do not match sparsity patterns:
  $ git ls-files -t
  S tracked-but-maybe-skipped
  $ git show HEAD:tracked-but-maybe-skipped >tracked-but-maybe-skipped
  $ git ls-files -t
  H tracked-but-maybe-skipped

  $ git checkout HEAD~1
  $ git ls-files -t
  S tracked-but-maybe-skipped

So, switch & checkout are doing the same culling that `reset --hard`
is doing.  It's just that all the commands avoid culling when there
are modifications to the file after its normal operation, and by
design, you'll see `reset --hard` have more opportunities to cull
files since it squashes those modifications.

> Regardless of what we decide, though,
> I think it's probably worth documenting the "modified outside of sparsity
> patterns" case.

I'm happy to document if I understand it better; right now I'm just
not following.

> Also, 'read-tree' (no args) doesn't apply the 'SKIP_WORKTREE' bit to *any*
> of the entries it reads into the index. Having all of your files suddenly
> appear "deleted" probably isn't desired behavior, so it might be a good
> candidate for the "Known bugs" section.

Ooh, good catch.  Yeah, I'll add it.

> > +
> > +  * commands that write conflicted files to the working tree, but otherwise will
> > +    omit writing files that do not match the sparsity patterns:
> > +
> > +      * merge
> > +      * rebase
> > +      * cherry-pick
> > +      * revert
> > +
> > +    Note that this somewhat depends upon the merge strategy being used:
> > +      * `ort` behaves as described above
> > +      * `recursive` tries to not vivify files unnecessarily, but does sometimes
> > +     vivify files without conflicts.
> > +      * `octopus` and `resolve` will always vivify any file changed in the merge
> > +     relative to the first parent, which is rather suboptimal.
> > +
> > +  * commands that always ignore sparsity since commits must be full-tree
> > +
> > +      * archive
> > +      * bundle
> > +      * commit
> > +      * format-patch
> > +      * fast-export
> > +      * fast-import
> > +      * commit-tree
> > +
> > +  * commands that write any modified file to the working tree (conflicted or not,
> > +    and whether those paths match sparsity patterns or not):
> > +
> > +      * stash
> > +
> > +      * am/apply probably should be in the above category, but need to be fixed to
> > +     auto-vivify instead of failing
> > +
> > +* Commands that differ for behavior A vs. behavior B:
> > +
> > +  * commands that make modifications:
>
> nit: "make modifications" -> "make modifications to the index"?

More specifically, "make modifications to which files are tracked".
In a sense, these commands determine whether "--[no-]restrict" apply
to _untracked_ files (because those untracked files are about to
become tracked), which is something no other command has to worry
about, and they deserve special treatment because of that.

> > +      * add
> > +      * rm
> > +      * mv
> > +
> > +  * commands that query history
> > +      * diff (with --cached or REVISION arguments)
> > +      * grep (with --cached or REVISION arguments)
> > +      * show (when given commit arguments)
> > +      * bisect
> > +      * blame
> > +     * and annotate
> > +      * log
> > +     * and variants: shortlog, gitk, show-branch, whatchanged
> > +
> > +* Comands I don't know how to classify
> > +
> > +  * ls-files
> > +
> > +    Shows all tracked files by default, and with an option can show
> > +    sparse directory entries instead of expanding them.  Should there be
> > +    a way to restrict to just the non SKIP_WORKTREE files?
>
> Yes, I think "restricting to just non SKIP_WORKTREE files" would be what a
> '--restrict' option would do.

Hmm...yeah, that makes sense...especially if as you say:

> The existing '--sparse' flag really is
> independent of the sparse patterns altogether - it just toggles whether
> sparse directories are shown as-is or expanded. Given your analysis so far,
> '--sparse' should probably be renamed to something that reflects its unique
> behavior ('--no-expand-sparse-directories'? I'm sure someone more creative
> than me could come up with a better name ;) ).

Maybe just `--no-expand`?  I'm also open to further alternatives.

> So, disregarding the special sparse index behavior, I think 'ls-files' fits
> neatly in the "commands that query history" section.

If it fits neatly in the "commands that query history" section, that
implies that `--restrict` should be the default for the behavior A
camp of people.  That may be fine, but...

Junio suggested that leaving ls-files as full-tree by default "would
allow scripters [to] come up with Porcelains that restricts to the
sparse specification more easily."  I know we've certainly used
`ls-files -t` a lot internally.  I guess it's a question of whether we
train such folks to always use `--no-restrict` together with `git
ls-files -t`, whether we actually treat ls-files as a special category
that defaults to full-tree even for the behavior A camp, or whether we
find some kind of middle ground by defaulting to `--restrict` but
making the `-t` option imply `--no-restrict`.  Thoughts?

> > +
> > +    Note that `git ls-files -t` is often used to see what is sparse and
> > +    what is not, which only works with a non-restricted assumption.
> > +
> > +  * checkout-index
> > +
> > +    should it be like `checkout` and pay attention to sparsity paths, or
> > +    be considered special and write to working tree anyway?  The
> > +    interaction with --prefix, and the use of specifically named files
> > +    (rather than globs) makes me wonder.
>
> IMO, it should still pay attention to sparsity paths, even with '--prefix'.
> My interpretation would be that '--restrict' tells it how to *read* the
> index when determining what to write to disk - even with '--prefix', then,
> it'd only write files matching the sparsity patterns. In that case, it seems
> to fit alongside 'switch', 'restore', etc. in "commands that restore files
> to the working tree that match sparsity patterns."

Sounds fair; I like that.

> > +
> > +  * update-index
> > +
> > +    The --[no-]ignore-skip-worktree-entries default is totally bogus,
> > +    but otherwise this command seems okay?  Not sure what category it
> > +    would go under, though.
>
> I'd probably call this a "makes modifications" command (like 'git add', 'git
> rm', etc.), since it adds/removes/modifies items in the index (either their
> content or their flags).

That group has a restrict-or-error behavior.  Do we want update-index
to require a --no-restrict to operate on files outside the sparse
specification?  Maybe we do, for the same reasons we do with
add/rm/mv.  And that certainly would have helped us avoid the
--[no-]ignore-skip-worktree-entries bug.

If we go this route, should some flags imply --no-restrict (such as
--[no-]skip-worktree)?

> > +
> > +  * range-diff
> > +
> > +    Is this like `log` or `format-patch`?
> > +
> > +  * cherry
> > +
> > +    See range-diff

I'm presuming you didn't mean the answers below to apply to the above two.

> > +  * plumbing -- diff-files, diff-index, diff-tree, ls-tree, rev-list
> > +
> > +    should these be tweaked or always operate full-tree?
>
> For these (and the other plumbing/plumbing-ish commands you have listed:
> 'checkout-index', 'update-index', 'read-tree'), I'd lean towards making them
> respect the sparsity patterns consistently with the porcelain layer. Part of
> that is because the line between "plumbing" and "porcelain" is sometimes
> fuzzy (like with 'read-tree'?), so having _very_ different behavior around
> that boundary would probably be confusing. The other part is that I think
> plumbing-based scripts would still fit one of your "A" or "B" user
> archetypes, so full-tree behavior might not be desired anyway.

That sounds compelling to me, generally.

However, if we are given a tree rather than a revision, we have no way
of knowing where in the directory hierarchy that the tree is found, so
we may not be able to provide `--restrict` behavior (unless we want to
just blindly assume the tree given is a toplevel tree; not sure Junio
would like that based on looking at the commit message of d4789c60aa
("ls-tree: add --full-tree option", 2008-12-25) where such an
assumption was made before).  Thus, things like `git grep $TREE`, `git
diff-tree $TREE1 $TREE2`, or `git ls-tree $TREE` may have to default
to `--no-restrict` when those arguments truly are trees rather than
commits.


> > +=== Subcommand-dependent defaults ===
> > +
> > +Note that we have different defaults (for the desired behavior, not just
> > +the current implementation) depending on the command:
> > +
> > +  * Commands defaulting to --restrict:
> > +    * status
> > +    * diff (without --cached or REVISION arguments)
> > +    * grep (without --cached or REVISION arguments)
> > +    * switch
> > +    * checkout (the switch-like half)
> > +    * read-tree
> > +    * reset (--hard)
> > +    * restore/checkout
> > +    * checkout-index
> > +
> > +    This behavior makes sense; these interact with the working tree.
> > +
> > +  * Commands defaulting to --restrict-unless-conflicts
> > +    * merge
> > +    * rebase
> > +    * cherry-pick
> > +    * revert
> > +
> > +    These also interact with the working tree, but require slightly different
> > +    behavior so that conflicts can be resolved.
> > +
> > +  * Commands defaulting to --no-restrict
> > +    * archive
> > +    * bundle
> > +    * commit
> > +    * format-patch
> > +    * fast-export
> > +    * fast-import
> > +    * commit-tree
> > +
> > +    * ls-files
>
> In line with what I wrote earlier, I think 'ls-files' would belong wherever
> other "commands that query history" go (looks like "Commands whose default
> for --restrict vs. --no-restrict should vary").
>
> > +    * stash
> > +    * am
> > +    * apply
> > +
> > +    These have completely different defaults and perhaps deserve the most detailed
> > +    explanation:
> > +
> > +    In the case of commands in the first group (format-patch,
> > +    fast-export, bundle, archive, etc.), these are commands for
> > +    communicating history, which will be broken if they restrict to a
> > +    subset of the repository.  As such, they operate on full paths and
> > +    have no `--restrict` option for overriding.  Some of these commands may
> > +    take paths for manually restricting what is exported, but it needs to
> > +    be very explicit.
> > +
> > +    In the case of stash, it needs to vivify files to avoid losing the
> > +    user's changes.
> > +
> > +    In the case of am and apply, those commands only operate on the
> > +    working tree, so they are kind of in the same boat as stash.
> > +    Perhaps `git am` could run `git sparse-checkout reapply`
> > +    automatically afterward and move into a category more similar to
> > +    merge/rebase/cherry-pick, but it'd still be weird because it'd
> > +    vivify files besides just conflicted ones when there are conflicts.
> > +
> > +    In the case of ls-files, `git ls-files -t` is often used to see what
> > +    is sparse and not, in which case restricting would not make sense.
> > +    Also, ls-files has traditionally been used to get a list of "all
> > +    tracked files", which would suggest not restricting.  But it's
> > +    slightly funny, because sparse-checkouts essentially split tracked
> > +    files into two categories -- those in the sparse specification and
> > +    those outside -- and how does the user specify which of those two
> > +    types of tracked files they want?
> > +
> > +  * Commands defaulting to --restrict-but-warn (although Behavior A vs. Behavior B
> > +    may affect how verbose the warnings are):
> > +    * add
> > +    * rm
> > +    * mv
>
> I was going to say that, if you consider 'update-index' part of the same
> category as 'git add', it would belong here. However, the "but warn" part
> seems a little weird with a mostly-plumbing command like 'update-index'.

Is it more or less weird with "but error" rather than "but warn"?

> > +
> > +    The defaults here perhaps make sense since they are nearly --restrict, but
> > +    actually using --restrict could cause user confusion if users specify a
> > +    specific filename, so they warn by default.  That logic may sound like
> > +    --no-restrict should be the default, but that's prone to even bigger confusion:
> > +      * `git add <somefile>` if honored and outside the sparse cone, can result in
> > +     the file randomly disappearing later when some subsequent command is run
> > +     (since various commands automatically clean up unmodified files outside
> > +     the sparsity specification).
> > +      * `git rm '*.jpg'` could very negatively surprise users if it deletes files
> > +     outside the range of the user's interest.  Much better to operate on the
> > +     sparsity specification and give the user warnings if other files could have
> > +     matched.
> > +      * `git mv` has similar surprises when moving into or out of the cone, so
> > +     best to restrict and throw warnings if restriction might affect the result.
> > +
> > +    There may be a difference in here between behavior A and behavior B.
> > +    For behavior A, we probably only want to warn if there were no
> > +    suitable matches for files in the sparsity specification, whereas
> > +    for behavior B, we may want to warn even if there are valid files to
> > +    operate on if the result would have been different under
> > +    `--no-restrict`.
>
> I'm a bit confused why '--restrict-but-warn' needs to be separate from
> '--restrict'. Couldn't the '--restrict' behavior for 'add'/'rm'/'mv' just be
> what you described above, since behavior is set on a per-command (or
> per-category) basis?
>
> Also, I might be mistaken, but isn't the current behavior more like
> '--restrict', in that it returns an error code & advisory message if it
> tries to add files outside the sparse patterns? If this is already okay to
> users, what's the benefit of relaxing the error to a warning?
>
> Otherwise, I'm on board with the difference between behaviors A & B (i.e.,
> "some files must be in the sparse-checkout to avoid a warning/error" vs.
> "all files must be in the sparse-checkout to avoid a warning/error").

Sorry, I should have written "error" rather than "warning".  I wanted
these in a separate category, because initially these had
`--no-restrict` behavior and we had really big usability problems.  We
tried to fix this by implementing "--restrict" behavior and just
silently ignoring any paths users gave us outside the sparse
specification.  That reduced complaints and made problems much
smaller, but we still got complaints.  Providing an error message in
some cases due to the restriction (hence --restrict-but-error) is kind
of important to getting the user experience right on these commands.

> > +
> > +  * Commands whose default for --restrict vs. --no-restrict should vary depending
> > +    on Behavior A or Behavior B
> > +    * diff (with --cached or REVISION arguments)
> > +    * grep (with --cached or REVISION arguments)
> > +    * show (when given commit arguments)
> > +    * bisect
> > +    * blame
> > +      * and annotate
> > +    * log
> > +      * and variants: shortlog, gitk, show-branch, whatchanged
> > +
> > +    For now, we default to behavior B for these, which want a default of
> > +    --no-restrict.
> > +
> > +    Note that two of these commands -- diff and grep -- also appeared in
> > +    a different list with a default of --restrict, but only when limited
> > +    to searching the working tree.  The working tree vs. history
> > +    distinction is fundamental in how behavior B operates, so this is
> > +    expected.
> > +
> > +    --restrict may make more sense as the long term default for
> > +    these[12], but that's a fair amount of work to implement, and it'd
> > +    be very problematic for behavior B users.  Making it the default
> > +    now, and then slowly implementing that default in various
> > +    subcommands over multiple releases would mean that behavior B users
> > +    would need to learn to slowly add additional flags to their
> > +    commands, depending on git version, to get the behavior they want.
> > +    That gradual switchover would be painful, so we should avoid it at
> > +    least until it's fully implemented.
>
> I think transitioning to '--restrict' by default is a good plan - as far as
> I can tell, user A types seem more common than user B types, and
> '--restrict' creates a more consistent experience.
>
> Maybe '--restrict' could be made the default earlier in 'scalar' (which
> already sets up a cone-mode sparse-checkout by default)? We'd still
> gradually move towards making the option a global default, but 'scalar'
> might get it some early exposure with users that'd benefit the most from it.

I'm glad others support this idea.  A couple years ago, I thought it
was going to be hard to get buy-in to even support it as a config
option.

> > +=== Implementation Questions ===
> > +
> > +  * Does the name --[no-]restrict sound good to others?  Are there better options?
> > +    * Names in use, or appearing in patches, or previously suggested:
> > +      * --sparse/--dense
> > +      * --ignore-skip-worktree-bits
> > +      * --ignore-skip-worktree-entries
> > +      * --ignore-sparsity
> > +      * --[no-]restrict-to-sparse-paths
> > +      * --full-tree/--sparse-tree
> > +      * --[no-]restrict
> > +    * Rationale making me lean slightly towards --[no-]restrict:
> > +      * We want a name that works for many commands, so we need a name that
> > +     does not conflict
> > +      * --[no-]restrict isn't overly long and seems relatively explanatory
> > +      * `--sparse`, as used in add/rm/mv, is totally backwards for
> > +     grep/log/etc.  Changing the meaning of `--sparse` for these
> > +     commands would fix the backwardness, but possibly break existing
> > +     scripts.  Using a new name pairing would allow us to treat
> > +     `--sparse` in these commands as a deprecated alias.
> > +      * There is a different `--sparse`/`--dense` pair for commands using
> > +     revision machinery, so using that naming might cause confusion
> > +      * There is also a `--sparse` in both pack-objects and show-branch, which
> > +     don't conflict but do suggest that `--sparse` is overloaded
> > +      * The name --ignore-skip-worktree-bits is a double negative, is
> > +     quite a mouthful, refers to an implementation detail that many
> > +     users may not be familiar with, and we'd need a negation for it
> > +     which would probably be even more ridiculously long.  (But we
> > +     can make --ignore-skip-worktree-bits a deprecated alias for
> > +     --no-restrict.)
>
> I think '--[no-]restrict' is a good choice - it doesn't have the ambiguity
> of '--sparse' or the so-verbose-it's-confusing nature of
> '--ignore-skip-worktree-(bits|entries)'. My only concern would be with the
> fact that '--[no-]restrict' doesn't clearly indicate its relationship to
> sparse-checkout, but a longer name (like
> '--[no-]restrict-to-sparse-checkout') would be cumbersome, not worth it for
> the little bit of extra info a user would get.

Yeah, that lack of relationship is annoying, but perhaps we can create
one by adding a --[no-]restrict flag to `sparse checkout (init|set)`?

> > +
> > +  * Should --[no-]restrict be a git global option, or added as options to each
> > +    relevant command?  (Does that make sense given the multitude of different
> > +    default behaviors we have for different options?)
>
> That's an interesting idea! I'd be fine either way, there are pros and cons
> to each. E.g., it feels a little weird putting the option before the command
> ('git --no-restrict add' vs. 'git add --no-restrict'), but the option does
> apply to nearly every command (and it's easier to describe/document from a
> Git-wide perspective than a per-command perspective).

One difficulty with global is that both --restrict and --no-restrict
will be added.  So:
  * What if --restrict is passed with a command that only uses
no-restrict behavior?  For example: stash? apply? commit?  etc.
  * What if --restrict is passed with a command that defaults to
something not-quite-restrict?  Such as add?  Or merge?  Should it
attempt harder to ignore paths outside the sparse specfication?
  * What if --restrict is passed to a command that doesn't understand
or use paths at all?  Such as update-ref?  Or branch?  Or repack?

Do we just ignore in the first and third case, and map it to the
almost-restrict in the second case?

> > +
> > +  * If a config option is added (core.restrictToSparsity?) what should
> > +    the values and description be?  There's a risk of confusion, because
> > +    we only want this config option to affect the history-querying
> > +    commands (log/diff/grep) and maybe the path-modifying worktree
> > +    commands (add/rm/mv), but certainly not most the others.  Previous config
> > +    suggestion here: [13]
>
> For values, maybe 'strict' (for behavior A/'--restrict' across the board),
> 'loose' (for behavior B), 'off'/'none' (for '--no-restrict' across the
> board)? For the description, it could outline each of the use cases and
> highlight notable command behavior differences? Kind of like what you
> already have in [13].

I'm a little lost on your third case there.  How would a
"`--no-restrict` across the board" setting be useful?  Doesn't having
checkout/switch default to --no-restrict defeat the point of
sparse-checkouts?  I suspect you meant something else by "across the
board", but I don't know what other usecase exists that defines the
edge of the board for your scenario.

> > +
> > +  * Should --sparse in ls-files be made an alias for --restrict?
> > +    `--restrict` is certainly a near synonym in cone-mode, but even then
> > +    it's not quite the same.  In non-cone mode, ls-files' `--sparse`
> > +    option has no effect, and in cone-mode it still shows the sparse
> > +    directory entries which are technically outside the sparsity
> > +    specification.
>
> I don't think so (for the reasons I mentioned earlier - tl;dr --sparse and
> --restrict are conceptually quite different, and functionally independent).
> I do think '--sparse' should be renamed as part of the "Implementation
> Goals/Plans", though.

Yeah, sounds good.

> > +
> > +  * Should --ignore-skip-worktree-bits in checkout-index, checkout, and
> > +    restore be made deprecated aliases for --no-restrict?  (They have the
> > +    same meaning.)
> > +
> > +  * Should --ignore-skip-worktree-entries in update-index be made a
> > +    deprecated alias for --no-restrict?  (Or, better yet, should the
> > +    option just be nuked from orbit after flipping the default, since
> > +    the reverse option is never wanted and the sole purpose of this
> > +    option was to turn off a bug?)
>
> That's an interesting bit of history! I tend to think of 'update-index' as
> "plumbing add/rm", so I think there's still a benefit to having a
> '--restrict' mode.
>
> In any case, if I'm reading this correctly, these two options are subtly
> different than what's proposed for '--restrict', since IIRC they don't take
> into account the sparse patterns at all (only operating based on
> 'SKIP_WORKTREE'). If '--restrict' will involve also using the sparse
> patterns, the behavior would change. I'm happy with doing that (I think the
> change would be beneficial), but it should probably be explicitly noted
> either here or whenever those commands are updated.

I think of `--restrict` as "apply operation to the sparse
specification", and as noted above, I view the sparse specification as
able to transiently diverge from the canonical sparsity patterns in
$GIT_DIR/info/sparse-checkout.

However, that's not really relevant here, because the difference
between sparse specification and sparsity patterns only matters for
--restrict.  In contrast, --no-restrict means apply operation to all
paths in both cases, making that subtle difference a moot point.

Since in this case these flags map to --no-restrict, we don't need to
worry about that distinction.

> > +
> > +  * sparse-checkout: once behavior A is fully implemented, should we
> > +    take an interim measure to easy people into switching the default?
>
> nit: s/easy/ease/

Indeed, thanks for catching.

> > +    Namely, if folks are not already in a sparse checkout, then require
> > +    `sparse-checkout init/set` to take a `--[no-]restrict` flag (which
> > +    would set core.restrictToSparse according to the setting given), and
> > +    throw an error if the flag is not provided?  That error would be a
> > +    great place to warn folks that the default may change in the future,
> > +    and get them used to specifying what they want so that the eventual
> > +    default switch is seamless for them.
>
> Sounds like a good approach to me! It avoids needing to constantly
> re-specify '--[no-]restrict' on every 'sparse-checkout set' (because it sets
> the config), and also provides visibility to users.

:-)

> > +
> > +  * clone: should we provide some mechanism for tying partial clones and
> > +    sparse checkouts together better.  Maybe an option
> > +     --sparse=dir1,dir2,...,dirN
> > +    which:
> > +       * Does initial fetch with `--filter=blob:none`
> > +       * Does the `sparse-checkout set --cone dir1 dir2 ... dirN` thing
> > +       * Runs a `git rev-list --objects --all -- dir1 dir2 ... dirN` to
> > +      fault in the missing blobs within the sparse
> > +      specification...except that rev-list needs some kind of options
> > +      to also get files from leading directories too.
> > +       * Sets --restrict mode to allow focusing on the cone of interest
> > +      (and to permit disconnected development)
>
> Similar to the '--restrict' default, this could also be a good fit for
> 'scalar clone'.

It's awesome that you're already thinking about how to get early testing.

> > +
> > +
> > +=== Implementation Goals/Plans ===
>
> The rest of this (+the "Known bugs" section) all look good to me.
>
> Thanks again for writing this document, I really appreciate the time &
> effort you put into it! It'll serve as a clear reference for work on
> sparse-checkout going forward, and ultimately make sparse-checkout usage a
> much better experience for users.

Thanks for taking the time to read through it and provide detailed feedback!

>
> > base-commit: 1b3d6e17fe83eb6f79ffbac2f2c61bbf1eaef5f8
>
