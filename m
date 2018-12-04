Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.2 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id D50C1211B3
	for <e@80x24.org>; Tue,  4 Dec 2018 16:22:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726808AbeLDQWG (ORCPT <rfc822;e@80x24.org>);
        Tue, 4 Dec 2018 11:22:06 -0500
Received: from mail-io1-f42.google.com ([209.85.166.42]:38388 "EHLO
        mail-io1-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726151AbeLDQWG (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 4 Dec 2018 11:22:06 -0500
Received: by mail-io1-f42.google.com with SMTP id l14so14076939ioj.5
        for <git@vger.kernel.org>; Tue, 04 Dec 2018 08:22:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=m19XGknYipoeR1/YGAAfY+b+CrtDcjU0H6JGy6C/PTk=;
        b=eJbQjz+KMbBoNnE1/9+o5Vo1efsAaJghlj1jd6mehl0dH4cdaf5ncyWrR2aT+FyeA+
         8O9Hvmk9ime8ScCGs/V9bR9F60dNXNhlte6TpgK7RRnCueE34cPbSyuuACLnsyWR3LR+
         7v6WU07XXXSbd1pNwHSjV1vWZyBJC92QOOHKOFTfE53i7XGE/kH+J40TWQr6AjDKJd3G
         xnBMGGEDEWcgLfbQxc3sjutiFQUULZeJ7klcOPBuRqSIgI3VYT2ULDc4SUsXAjD9837/
         9oS35R1dvgGFBLmmwT7WPCqLO3tC5EWwyyk+TCl5UuCTtTd2MGLM2MUqMLbNeE0lZj1o
         lY5g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=m19XGknYipoeR1/YGAAfY+b+CrtDcjU0H6JGy6C/PTk=;
        b=FEcTSMn9J8P3EwW3j21o+BJiUo2gt9KKo6coib/o1eUWu5YiXb3AANjETZjna/adjR
         OqdLybOwB9uvmGi5ZhaFX0vB1x5DCjCrH+5Wy9/8mNAhK6kvIjoMK409FqtTy2NiqCRT
         wvNudrD/VDfF+a5o6BHF+oSPSjYzUmoCXxgSVN7xx2Iv7QLqMogNyGIrv4tJhuQoHw0+
         GksqUXM/f++Tzl6+oZr98CiFTQOYlNw9wukPxhhNzyKnAYKRHsU74dPuJs92fojz1RLk
         JrlNDh68eXzuXDD+8MHyHB6JPHzkEH9N87ugDVc5PJtDvVDV40vB0WrSm1zj5P5svMxU
         QLPA==
X-Gm-Message-State: AA+aEWYzKq2Hmtb2rPKQVdQXnSC0dmhW6LQ6R27UB+0C6hOKC7gDTonA
        12EsrVsJMGpGGblmcqgCHveOoQAEUv+0WyUGy9B/A3u6
X-Google-Smtp-Source: AFSGD/VKzzKCYUL70x1W4L4zm4j+v8otLEXI97G62w49Y7bLMQhjXHZQq0/iWg2jeQz1PS5KOGz/O8CviqnVRnFND9w=
X-Received: by 2002:a6b:6f15:: with SMTP id k21mr6904510ioc.236.1543940524268;
 Tue, 04 Dec 2018 08:22:04 -0800 (PST)
MIME-Version: 1.0
References: <20181127165211.24763-1-pclouds@gmail.com> <20181129215850.7278-1-pclouds@gmail.com>
 <20181129215850.7278-8-pclouds@gmail.com> <CABPp-BHQ68pkvO8yXYuy=0D6ne8u=5CUMDqiN0jtRrxCL55n2g@mail.gmail.com>
In-Reply-To: <CABPp-BHQ68pkvO8yXYuy=0D6ne8u=5CUMDqiN0jtRrxCL55n2g@mail.gmail.com>
From:   Duy Nguyen <pclouds@gmail.com>
Date:   Tue, 4 Dec 2018 17:21:37 +0100
Message-ID: <CACsJy8BTs+WKzTTEF2XVTT-LVJk_exYCz_hN+hXU1Dw+oquBpA@mail.gmail.com>
Subject: Re: [PATCH v3 07/14] checkout: split into switch-branch and restore-files
To:     Elijah Newren <newren@gmail.com>
Cc:     =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>,
        Git Mailing List <git@vger.kernel.org>,
        Junio C Hamano <gitster@pobox.com>,
        Stefan Beller <sbeller@google.com>,
        Thomas Gummerer <t.gummerer@gmail.com>,
        Stefan Xenos <sxenos@google.com>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Thanks for all the comments! There are still some I haven't replied
(either I'll agree and do it anyway, or I'll need some more time to
digest)

On Tue, Dec 4, 2018 at 1:45 AM Elijah Newren <newren@gmail.com> wrote:
> > +'git restore-files' [--from=<tree-ish>] <pathspec>...
>
> Isn't this already inferred by the previous line?  Or was the
> inclusion of --from on the previous line in error?  Looking at the
> git-checkout manpage, it looks like you may have just been copying an
> existing weirdness, but it needs to be fixed.  ;-)

Hehe.

> > +'git restore-files' (-p|--patch) [--from=<tree-ish>] [<pathspec>...]
> > +
> > +DESCRIPTION
> > +-----------
> > +Updates files in the working tree to match the version in the index
> > +or the specified tree.
> > +
> > +'git restore-files' [--from=<tree-ish>] <pathspec>...::
>
> <tree-ish> and <pathspec>?  I understand <commit-ish> and <pathspec>,
> or <tree-ish> but have no clue why it'd be okay to specify <tree-ish>
> and <pathspec> together.  What does that even mean?
>
> Also, rather than fixing from <tree-ish> to <commit-ish> or <commit>,
> perhaps we should just use <revision> here?  (I'm thinking of git
> rev-parse's "Specifying revisions", which suggests "revisions" as a
> good substitute for "commit-ish" that isn't quite so weird for new
> users.)

tree-ish is technically more accurate. But I'm ok with just
<revision>. If you give it a blob oid then you should get a nice
explanation what you're doing wrong anyway.


> > +       Overwrite paths in the working tree by replacing with the
> > +       contents in the index or in the <tree-ish> (most often a
> > +       commit).  When a <tree-ish> is given, the paths that
> > +       match the <pathspec> are updated both in the index and in
> > +       the working tree.
>
> Is that the default we really want for this command?  Why do we
> automatically assume these files are ready for commit?  I understand
> that it's what checkout did, but I'd find it more natural to only
> affect the working tree by default.  We can give it an option for
> affecting the index instead (or perhaps in addition).

Yeah, that behavior of updating the index always bothers me when I use
it but I seemed to forget when working on this.

> > +--ours::
> > +--theirs::
> > +       Check out stage #2 ('ours') or #3 ('theirs') for unmerged
> > +       paths.
> > ++
> > +Note that during `git rebase` and `git pull --rebase`, 'ours' and
> > +'theirs' may appear swapped; `--ours` gives the version from the
> > +branch the changes are rebased onto, while `--theirs` gives the
> > +version from the branch that holds your work that is being rebased.
> > ++
> > +This is because `rebase` is used in a workflow that treats the
> > +history at the remote as the shared canonical one, and treats the
> > +work done on the branch you are rebasing as the third-party work to
> > +be integrated, and you are temporarily assuming the role of the
> > +keeper of the canonical history during the rebase.  As the keeper of
> > +the canonical history, you need to view the history from the remote
> > +as `ours` (i.e. "our shared canonical history"), while what you did
> > +on your side branch as `theirs` (i.e. "one contributor's work on top
> > +of it").
>
> Total aside because I'm not sure what you could change here, but man
> do I hate this.

Uh it's actually documented? I'm always confused by this too. --ours
and --theirs at this point are pretty much tied to stage 2 and 3.
Nothing I can do about it. But if you could come up with some other
option names, then we could make "new ours" to be stage 3 during
rebase, for example.

> > +Part of the linkgit:git[1] suite
>
>
> My single biggest worry about this whole series is that I'm worried
> you're perpetuating and even further ingraining one of the biggest
> usability problems with checkout: people suggest and use it for
> reverting/restoring paths to a previous version, but it doesn't do
> that:
>
> git restore-files --from master~10 Documentation/
> <edit some non-documentation files>
> git add -u
> git commit -m "Rationale for changing files including reverting Documentation/"
>
> In particular, now you have a mixture of files in Documentation/ from
> master~10 (er, now likely master~11) and HEAD~1; any files and
> sub-directories that existed in HEAD~1 still remain and are mixed with
> all other files in Documentation/ from the older commit.
>
> You may think this is a special case, but this particular issue
> results in some pretty bad surprises.  Also, it was pretty surprising
> to me just how difficult it was to implement an svn-like revert in
> EasyGit, in large part because of this 'oversight' in git.  git
> checkout -- <paths> to me has always been fundamentally wrong, but I
> just wasn't sure if I wanted to fight the backward compatibility
> battle and suggest changing it.  With a new command, we definitely
> shouldn't be reinforcing this error.  (And maybe we should consider
> taking the time to fix git checkout too.)

What would be the right behavior for

 git restore-files --from=master~10 Documentation/

then? Consider it an error? I often use "git checkout HEAD" and "git
checkout HEAD^" (usually with -p) but not very far back like
master~10.

> > +If the branch exists in multiple remotes and one of them is named by
> > +the `checkout.defaultRemote` configuration variable, we'll use that
> > +one for the purposes of disambiguation, even if the `<branch>` isn't
> > +unique across all remotes. Set it to
> > +e.g. `checkout.defaultRemote=origin` to always checkout remote
> > +branches from there if `<branch>` is ambiguous but exists on the
> > +'origin' remote. See also `checkout.defaultRemote` in
> > +linkgit:git-config[1].
>
> So switch-branch will be controlled by checkout.* config variables?
> That probably makes the most sense, but it does dilute the advantage
> of adding these simpler commands.
>
> Also, the fact that we're trying to make a simpler command makes me
> think that removing the auto-vivify behavior from the default and
> adding a simple flag which users can pass to request will allow this
> part of the documentation to be hidden behind the appropriate flag,
> which may make it easier for users to compartmentalize the command and
> it's options, enabling them to learn as they go.

Sounds good. I don't know a good name for this new option though so
unless anybody comes up with some suggestion, I'll just disable
checkout.defaultRemote in switch-branch. If it comes back as a new
option, it can always be added later.

> > +'git switch-branch' -c|-C <new_branch> [<start_point>]::
> > +
> > +       Specifying `-c` causes a new branch to be created as if
> > +       linkgit:git-branch[1] were called and then switched to. In
> > +       this case you can use the `--track` or `--no-track` options,
> > +       which will be passed to 'git branch'.  As a convenience,
> > +       `--track` without `-c` implies branch creation; see the
> > +       description of `--track` below.
>
> Can we get rid of --track/--no-track and just provide a flag (which
> takes no arguments) for the user to use?  Problems with --track:
>   * it's not even in your synopsis
>   * user has to repeat themselves (e.g. 'next' in two places from '-c
> next --track origin/next'); this repetition is BOTH laborious AND
> error-prone
>   * it's rather inconsistent: --track is the default due to
> auto-vivify when the user specifies nothing but a branch name that
> doesn't exist yet, but when the user realizes the branch doesn't exist
> yet and asks to have it created then suddenly tracking is not the
> default??

I don't think --track is default anymore (maybe I haven't updated the
man page correctly). The dwim behavior is only activated in
switch-branch when you specify --guess to reduce the amount of magic
we throw at the user. With that in mind, do we still hide
--track/--no-track from switch-branch?

> I'm not sure what's best, but here's some food for thought:
>
>
>    git switch-branch <branch>
> switches to <branch>, if it exists.  Error cases:
>   * If <branch> isn't actually a branch but a <tag> or
> <remote-tracking-branch> or <revision>, error out and suggest using
> --detach.
>   * If <branch> isn't actually a branch but there is a similarly named
> <remote-tracking-branch> (e.g. origin/<branch>), then suggest using
> -c.

I would make these advice so I can hide them. Or if I manage to make
all these hints one line then I'll make it unconditional.

>   git switch-branch -c <branch>
> creates <branch> and, if a relevant-remote-tracking branch exists,
> base the branch on that revision and set the new branch up to track

Hmm.. this is a bit magical and could be surprising. If I create (and
switch to) a new branch foo, I don't necessarily mean tracking
origin/foo (I may not even think about origin/foo when I type the
command). So tentatively no.

> > +If `-C` is given, <new_branch> is created if it doesn't exist;
> > +otherwise, it is reset. This is the transactional equivalent of
> > ++
> > +------------
> > +$ git branch -f <branch> [<start_point>]
> > +$ git switch-branch <branch>
> > +------------
> > ++
> > +that is to say, the branch is not reset/created unless "git
> > +switch-branch" is successful.
>
> ...and when exactly would it fail?  Reading this, it looks like the
> only possible error condition was removed due saying we'll reset the
> branch if it already exists, so it's rather confusing.

Yeah probably just scrape it. The atomic nature is not worth highlighting.


> > +'git switch-branch' --detach [<commit>]::
> > +
> > +       Prepare to work on a unnamed branch on top of <commit> (see
> > +       "DETACHED HEAD" section), and updating the index and the files
> > +       in the working tree.  Local modifications to the files in the
> > +       working tree are kept, so that the resulting working tree will
> > +       be the state recorded in the commit plus the local
> > +       modifications.
> > ++
> > +When the <commit> argument is a branch name, the `--detach` option can
> > +be used to detach HEAD at the tip of the branch (`git switch-branch
> > +<branch>` would check out that branch without detaching HEAD).
> > ++
> > +Omitting <commit> detaches HEAD at the tip of the current branch.
> > +
> > +OPTIONS
> > +-------
> > +-q::
> > +--quiet::
> > +       Quiet, suppress feedback messages.
> > +
> > +--[no-]progress::
> > +       Progress status is reported on the standard error stream
> > +       by default when it is attached to a terminal, unless `--quiet`
> > +       is specified. This flag enables progress reporting even if not
> > +       attached to a terminal, regardless of `--quiet`.
> > +
> > +-f::
> > +--force::
> > +       Proceed even if the index or the working tree differs from
> > +       HEAD.  This is used to throw away local changes.
>
> Haven't thought through this thoroughly, but do we really need an
> option for that instead of telling users to 'git reset --hard HEAD'
> before switching branches if they want their stuff thrown away?

For me it's just a bit more convenient. Hit an error when switching
branch? Recall the command from bash history, stick -f in it and run.
Elsewhere I think both Junio and Thomas (or maybe only Junio) suggests
moving the "git reset" functionality without moving HEAD to one of
these commands, which goes the opposite direction...

> > +-c <new_branch>::
> > +--create <new_branch>::
> > +       Create a new branch named <new_branch> and start it at
> > +       <start_point>; see linkgit:git-branch[1] for details.
> > +
> > +-C <new_branch>::
> > +--force-create <new_branch>::
> > +       Creates the branch <new_branch> and start it at <start_point>;
> > +       if it already exists, then reset it to <start_point>. This is
> > +       equivalent to running "git branch" with "-f"; see
> > +       linkgit:git-branch[1] for details.
>
> Makes sense, but let's get the -b/-B vs. -c/-C consistent.

Another option I'm considering is -n/-N (for _new_ branch). Maybe
-c/-C is good enough.

> > +-l::
> > +       Create the new branch's reflog; see linkgit:git-branch[1] for
> > +       details.
>
> ??  Jettison this.

Yep. It looks weird to me too. reflog is just behind the scene these
days. Nobody need to explicitly ask for reflog anymore.

> > +--orphan <new_branch>::
> > +       Create a new 'orphan' branch, named <new_branch>, started from
> > +       <start_point> and switch to it.  The first commit made on this
>
> What??  started from <start_point>?  The whole point of --orphan is
> you have no parent, i.e. no start point.  Also, why does the
> explanation reference an argument that wasn't in the immediately
> preceding synopsis?

I guess bad phrasing. It should be "switch to <start_point> first,
then prepare the worktree so that the first commit will have no
parent". Or something along that line.

You should really review git-checkout.txt btw ;-)

> > +       new branch will have no parents and it will be the root of a new
> > +       history totally disconnected from all the other branches and
> > +       commits.
> > ++
> > +The index and the working tree are adjusted as if you had previously run
> > +"git checkout <start_point>".  This allows you to start a new history
> > +that records a set of paths similar to <start_point> by easily running
> > +"git commit -a" to make the root commit.
> > ++
> > +This can be useful when you want to publish the tree from a commit
> > +without exposing its full history. You might want to do this to publish
> > +an open source branch of a project whose current tree is "clean", but
> > +whose full history contains proprietary or otherwise encumbered bits of
> > +code.
> > ++
> > +If you want to start a disconnected history that records a set of paths
> > +that is totally different from the one of <start_point>, then you should
> > +clear the index and the working tree right after creating the orphan
> > +branch by running "git rm -rf ." from the top level of the working tree.
> > +Afterwards you will be ready to prepare your new files, repopulating the
> > +working tree, by copying them from elsewhere, extracting a tarball, etc.
>
> Ick.  Seems overly complex.  I'd rather that --orphan defaulted to
> clearing the index and working tree, and that one would need to pass
> HEAD for <start_point> if you wanted to start out with all those other
> files.  That would certainly make the explanation a little clearer to
> users, and more natural when they start experimenting with it.
>
> However, --orphan is pretty special case.  Do we perhaps want to leave
> it out of this new command and only include it in checkout?

I started this by simply splitting git-checkout in two commands that,
combined, can do everything git-checkout can. Then suggestions to have
better default came in and I think we started to drift further to
_removing_ options and falling back to git-checkout.

I think we could still keep "complicated" options as long as they are
clearly described and don't surprise users until they figure them out.
That way I don't have to go back to git-checkout and deal with all the
ambiguation it creates.

> > +-m::
> > +--merge::
> > +       If you have local modifications to one or more files that are
> > +       different between the current branch and the branch to which
> > +       you are switching, the command refuses to switch branches in
> > +       order to preserve your modifications in context.  However,
> > +       with this option, a three-way merge between the current
> > +       branch, your working tree contents, and the new branch is
> > +       done, and you will be on the new branch.
> > ++
> > +When a merge conflict happens, the index entries for conflicting
> > +paths are left unmerged, and you need to resolve the conflicts
> > +and mark the resolved paths with `git add` (or `git rm` if the merge
> > +should result in deletion of the path).
> > +
> > +--conflict=<style>::
> > +       The same as --merge option above, but changes the way the
> > +       conflicting hunks are presented, overriding the
> > +       merge.conflictStyle configuration variable.  Possible values are
> > +       "merge" (default) and "diff3" (in addition to what is shown by
> > +       "merge" style, shows the original contents).
> > +
> > +--ignore-other-worktrees::
> > +       `git switch-branch` refuses when the wanted ref is already
> > +       checked out by another worktree. This option makes it check
> > +       the ref out anyway. In other words, the ref can be held by
> > +       more than one worktree.
>
> seems rather dangerous...is the goal to be an easier-to-use suggestion
> for new users while checkout continues to exist, or is this command
> meant to handle all branch switching functionality that checkout has?

As explained above. I'm still thinking the latter, but with fewer
surprises and confusion. Though I guess I could be convinced to go
with the former (the problem with the former is, even as a
no-longer-new user, I still find git-checkout not that pleasant to use
and want a better replacement)

> > +<branch>::
> > +       Branch to checkout; if it refers to a branch (i.e., a name that,
> > +       when prepended with "refs/heads/", is a valid ref), then that
> > +       branch is checked out. Otherwise, if it refers to a valid
> > +       commit, your HEAD becomes "detached" and you are no longer on
> > +       any branch (see below for details).
>
> I thought we requiring --detach in order to detach.  Does this
> paragraph need updating?  Also, if we require --detach when we'll be
> detaching HEAD, then this paragraph gets a LOT simpler.

Yep. I really need to read through the document and update all of it.

> > +You can use the `"@{-N}"` syntax to refer to the N-th last
> > +branch/commit checked out using "git checkout" operation. You may
> > +also specify `-` which is synonymous to `"@{-1}`.
> > ++
> > +As a special case, you may use `"A...B"` as a shortcut for the
> > +merge base of `A` and `B` if there is exactly one merge base. You can
> > +leave out at most one of `A` and `B`, in which case it defaults to `HEAD`.
>
> I actually didn't know about the A...B special case for checkout.
> Interesting...but I'm starting to wonder if this is too much info for
> a "simplified command".

I could just hint about A...B and send the user to git-checkout.txt if
they need to know more. They can learn about git-checkout that way
too.
-- 
Duy
