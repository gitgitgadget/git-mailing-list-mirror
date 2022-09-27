Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BF2BAC6FA92
	for <git@archiver.kernel.org>; Tue, 27 Sep 2022 07:31:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230206AbiI0HbD (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 27 Sep 2022 03:31:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42518 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229847AbiI0Hax (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 27 Sep 2022 03:30:53 -0400
Received: from mail-lf1-x131.google.com (mail-lf1-x131.google.com [IPv6:2a00:1450:4864:20::131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 659C927FE4
        for <git@vger.kernel.org>; Tue, 27 Sep 2022 00:30:48 -0700 (PDT)
Received: by mail-lf1-x131.google.com with SMTP id a8so14367180lff.13
        for <git@vger.kernel.org>; Tue, 27 Sep 2022 00:30:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date;
        bh=NU/cISwxXagFNLyAcvvR0cPBTuW8dK8hwr48AixyNmA=;
        b=EJTLxRyiOf3vJthkURYTR6NUdilb+b7lcmhiHpnvlE5VUo2PBCs5eLp+9TPaCHQC4f
         Ad8MNvgzVQIj0+q6IZOsCxI9y5VmvFMSPKn+IT1GbmmPRq51lPLeEgT5ezG3QZmzym49
         pCtwcu8IKzooa9tV03BZw1248Kb2BOio4RPIOZtlElmGcpCUWS3v06GGoeT9EQ2Rk8LC
         DgCGUppOQbPGbk4FJhwTNV32dtta6mw4U/kwGgFOjIsFcwcBbXHO/xcSpkoEjnjuj6h7
         akqysZZLGAtsrwMtCxgMr9p5aNFdeMta4crjtIwIPmOFVeotFthXW5xj3CrpKHwSMvtz
         Y0cA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date;
        bh=NU/cISwxXagFNLyAcvvR0cPBTuW8dK8hwr48AixyNmA=;
        b=2gO+kUi2tuuPRUd4vnrGwkxjZPPYVOyIcTrjJ6JJ2TSS4A7uH2W/Okboy8aI3hBtIl
         0HEVyJrpElrmxeORM4yjT9v+8yzqAiknaMMf4pX5kVc/Lpt4ynd/VPkHBW94PNoBabR8
         Q9/NwJmiUKNu6KnZ7T7WhWsR3xXMSu2+l+6X/hk3fg+GNMEbtNV5ZICp1ptsHSSd+wfe
         rhjPEBpVFSGGGZve1xwi0bLVTWyT2ARtiU51ldyI6ZM9h3q0H1EIzOxBCG9aQPR/1jco
         A94sxnl+oIZhX7HRIoy6XjTmuLh0rETXVkQ8XgSa0slvctc+aZ7aaAmrPz1aYjobVMgV
         5qMw==
X-Gm-Message-State: ACrzQf3s6u94iwVsCcT2wa9xZjBxQawW1eSfpaw8YY29ucDpUbpGXeY+
        LrOHyu6ig8pBcLWDO8qdzG5FjZA6kA+1Yngcgr98CDKw
X-Google-Smtp-Source: AMsMyM5Xe3Xto6EVO/aJfWKV3y1BLmGglQYjkctyh6lTYufBJtv6dSGbqHMMLzJUXVHLQXtnSfOPF/H1q9yGC7/J9sE=
X-Received: by 2002:ac2:4c4b:0:b0:49e:939d:69dd with SMTP id
 o11-20020ac24c4b000000b0049e939d69ddmr11138862lfk.516.1664263846531; Tue, 27
 Sep 2022 00:30:46 -0700 (PDT)
MIME-Version: 1.0
References: <pull.1367.git.1664064588846.gitgitgadget@gmail.com>
 <a89413b5-464b-2d54-5b8c-4502392afde8@github.com> <xmqqv8p9ahly.fsf@gitster.g>
In-Reply-To: <xmqqv8p9ahly.fsf@gitster.g>
From:   Elijah Newren <newren@gmail.com>
Date:   Tue, 27 Sep 2022 00:30:34 -0700
Message-ID: <CABPp-BESkb=04vVnqTvZyeCa+7cymX7rosUW3rhtA02khMJKHA@mail.gmail.com>
Subject: Re: [PATCH] sparse-checkout.txt: new document with sparse-checkout directions
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Victoria Dye <vdye@github.com>,
        Elijah Newren via GitGitGadget <gitgitgadget@gmail.com>,
        Git Mailing List <git@vger.kernel.org>,
        Derrick Stolee <derrickstolee@github.com>,
        Shaoxuan Yuan <shaoxuan.yuan02@gmail.com>,
        Matheus Tavares <matheus.bernardino@usp.br>,
        ZheNing Hu <adlternative@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Sep 26, 2022 at 3:36 PM Junio C Hamano <gitster@pobox.com> wrote:
>
> Victoria Dye <vdye@github.com> writes:
>
> >> +* Commands behaving the same regardless of high-level use-case
> >> +
> >> +  * commands that only look at files within the sparsity specification
> >> +
> >> +      * status
> >> +      * diff (without --cached or REVISION arguments)
> >> +      * grep (without --cached or REVISION arguments)
> >
> > 'status' and 'diff' currently show information about untracked files outside
> > the working tree (since, not being in the index, they don't have a
> > 'SKIP_WORKTREE' to use). Should that change with the proposed '--restrict'
> > option?
>
> Most likely not.  When sparsity specification is in effect, as you
> said elsewhere in your response, no files, whether tracked or
> untrcked, should exist that are outside your area of interest.
> Their presence should be reported as anomalies by "git status".
>
> Unless the command is being run with the "-uno" option, that is.

Oh, wow, that's something completely outside what I had considered.  I
had viewed sparse-checkouts as splitting "tracked files" into two
subsets.  As such, `--[no-]restrict` could only affect selecting
whether the smaller or larger set of tracked files was of interest.
From that viewpoint, untracked files seemed orthogonal, and thus there
couldn't be such a thing as an "anamalous untracked file".

But this idea is very interesting.  Hmm...

>
> > - 'switch', 'checkout' (switch-like), and 'read-tree -m' block the operation
> >   & advise on how to clean up the modified files to re-align with the
> >   sparsity patterns.
> > - 'reset --hard' silently drops the modified file and resets the
> >   'SKIP_WORKTREE' bit on the corresponding index entry.
> >
> > With the exception of 'reset --hard' (aggressively and unconditionally
> > cleaning the worktree & index is an important aspect of the command, IMO),
> > I'd personally like to see commands in this category align with the behavior
> > of 'switch' where they don't already. Regardless of what we decide, though,
> > I think it's probably worth documenting the "modified outside of sparsity
> > patterns" case.
>
> True.  I agree on both counts.
>
> > Also, 'read-tree' (no args) doesn't apply the 'SKIP_WORKTREE' bit to *any*
> > of the entries it reads into the index. Having all of your files suddenly
> > appear "deleted" probably isn't desired behavior, so it might be a good
> > candidate for the "Known bugs" section.
>
> I would imagine that it actually is OK to say that it is the
> responsibility of whoever invokes read-tree the plumbing command
> to reapply the skip-worktree bits and/or collapse the index entries
> outside the area of interest into trees afterwards.

I'll keep that in mind, but that sounds very error prone to me.

> >> +* Commands that differ for behavior A vs. behavior B:
> >> +
> >> +  * commands that make modifications:
> >
> > nit: "make modifications" -> "make modifications to the index"?
>
> That clarification actually raises an interesting question.  Do we
> want three level distinction, i.e. different behaviour between
> commands that touch and do not touch the working tree, between those
> that touch and do not touch the index, and between those that touch
> and do not touch the commit?
>
> As the index is merely a way to express what the user did to
> eventually create the next tree to be recorded in the commit, my gut
> feeling is that it may be easier to understand if we treated the
> working tree and the index at the same level, actually.  I.e. if
> grepping in the working tree of a sparse checkout does not find a
> match outside the cones of interest, it may make sense to do the
> same at least by default in "grep --cached" mode.
>
> If I understand Stolee's write-up on the use case of those in the
> camp B, they are more aware of the larger whole and expect to see
> hits outside the area they have checkout when running "grep HEAD".
> But in their use case, they do not touch (only look) the area
> outside their cone of interest, so if we limit the operation to
> their cone of interest by default for working tree, the same default
> probably should apply equally for an operation that inspect the
> index.

That is an interesting angle to view things; I wondered if an idea
along these lines was going to come up when I was first responding to
Shaoxuan.  I also wondered if people would come to different
conclusions on whether "git grep --cached" should search outside the
sparsity-paths depending upon whether the sparse index was in use.

One thing that makes me a little leery about this path is whether we
can consistently apply the scoped-to-sparse-specification rule for
index operations.  For example:

  * You previously agreed that `git format-patch` should ignore sparse
specification and operate full tree.
  * `git apply --cached $PATCH` only updates the index, and you
suggested in an alternate email that apply should operate full-tree
(at least with --index or without --cached, but I assume by extension
it probably also applies with --cached).
  * What if someone ran the last two commands, and then goes to commit
the result?  Do we want to scope `git commit` to only accept staged
changes within the sparse specification by default?  I thought we
wouldn't and marked commit as a full-tree operation, by default.
  * What if someone runs `git diff --cached` just before that commit?
Do we scope the diff to only those paths within the sparse
specification?
  * What if someone runs `git status` just before that commit?  Do we
only show staged changes within the sparse specification?

It feels like "git grep --cached" is perhaps the next thing along this
sequence, and I don't see a clear line where to draw that we should
limit things to the sparse specification for the index while treating
the other operations as full tree; it seems like something feels
broken or inconsistent in this sequence of commands if we attempt to
do so.


Also, I have some users in camp B.  They specifically have been using
"git grep --cached ..." for a few years now to find other code of
interest outside of their current sparse-checkout (often in stubbed
out dependencies or other projects that depend on the area you are
modifying).  This allows them to make internal API changes and find
the other sites that need to be modified, including outside the normal
sparse cone.  Perhaps I could re-teach them to use "git grep ... HEAD"
instead, but it may feel like a bit of a break to them.  I've found
"git grep --cached" being documented by others who wrote various "how
to work in sparse checkouts" documents, all commenting on this being
the trick to do a whole-tree search.  I did warn them that we might
change that command on them (and sparse-checkouts in general have a
warning about potentially changing behavior), but I'm a little
hesitant to do so.  So that's a second reason I lean towards treating
index searches the same as REVISION ones -- full-tree for camp B.
