Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CB6D4C32771
	for <git@archiver.kernel.org>; Tue, 27 Sep 2022 03:11:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230023AbiI0DL4 (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 26 Sep 2022 23:11:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47838 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231286AbiI0DKz (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 26 Sep 2022 23:10:55 -0400
Received: from mail-lj1-x22a.google.com (mail-lj1-x22a.google.com [IPv6:2a00:1450:4864:20::22a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4774F50722
        for <git@vger.kernel.org>; Mon, 26 Sep 2022 20:05:42 -0700 (PDT)
Received: by mail-lj1-x22a.google.com with SMTP id g20so9488105ljg.7
        for <git@vger.kernel.org>; Mon, 26 Sep 2022 20:05:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date;
        bh=V9lrcmUQPChoJl3J2dUMmewBBBOokZ4mWInPlWqzTpY=;
        b=jFjQDP19nd2dt1DSV1b7c+QGW5uqcP0dV+Snwogryca8FGC52JjMkjE5v1ADWGHOki
         HSdTxcOrrkBHLR12DvI1V2fPGD7xxohe5gUok+yDK2CEUOZ4YAec6SClbOlHIrKaRycF
         XjCb1ZDrlp5l3oCXwXPuB9chlK1Nuswz6CYqOlBYn9/ipUUMbho2JKJinPU94ueZFx2f
         20NmAgAar+27bmimxz+iCTEtRzpsPkP2eQEpbeqsJ0F0uJRPdufxeF2LKL+sQf3ctVaK
         oZy8YhxHMwgKhlYccicY4l7p4Levql83SA3eViAnS8KcRCXlBW23Ut2Ouk4QRRFeiyn2
         S0Iw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date;
        bh=V9lrcmUQPChoJl3J2dUMmewBBBOokZ4mWInPlWqzTpY=;
        b=fnkoX5XhcA0koCVqAbLihUC8CsSmNtRQbMGzunx8PFfPU3F1Y8bAQZJYBLBy/eWlEC
         PfUShY0pjRQcK9tHX1Mfg87XaBn0OD8qz+NbtzUP6jQ6b3luDtCXBGtXBpI0icC9UVjZ
         6fYqEUOF4eG3dTn6vNWRUqy9B7iY4yncBRnwtSfax+Evdvgzgkh5xkQEDqYNY9XTeMZb
         l5IXQ4WL+bBKmcpuhGeuyQ0qFU04gMYavkCiWmH1VMTJBRxIZ9QehpfnDbrrqgtEJSG/
         nkvmNKN2U05ktTaxLv8W7t8+AxGz/FvLxEYSoQn/UZ5HRB9S84pcuVV5A4+ple1la7XY
         1N0w==
X-Gm-Message-State: ACrzQf2MGiLA41kWZDeX/s6KmZFg43nATZSRGuXojFg5KekdwoibY8eU
        V4yuWtsa918D/r26QRPprJKIfCBQh6zj5C7jbQw=
X-Google-Smtp-Source: AMsMyM4iAL4c6E44/FxnAbMeFLfKyMWZWyDT8DnT0qelprG/KZ02gUgGd9NJUMo2MF08Syuszpgc2qkIambSNqb6prA=
X-Received: by 2002:a2e:808c:0:b0:26c:33d3:a91d with SMTP id
 i12-20020a2e808c000000b0026c33d3a91dmr9290503ljg.73.1664247940193; Mon, 26
 Sep 2022 20:05:40 -0700 (PDT)
MIME-Version: 1.0
References: <pull.1367.git.1664064588846.gitgitgadget@gmail.com> <xmqqwn9qox1z.fsf@gitster.g>
In-Reply-To: <xmqqwn9qox1z.fsf@gitster.g>
From:   Elijah Newren <newren@gmail.com>
Date:   Mon, 26 Sep 2022 20:05:28 -0700
Message-ID: <CABPp-BFo_0MaBfyhDBfRby4CSHy8brjMY_8nif2S_Aogn-NqUg@mail.gmail.com>
Subject: Re: [PATCH] sparse-checkout.txt: new document with sparse-checkout directions
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Elijah Newren via GitGitGadget <gitgitgadget@gmail.com>,
        Git Mailing List <git@vger.kernel.org>,
        Victoria Dye <vdye@github.com>,
        Derrick Stolee <derrickstolee@github.com>,
        Shaoxuan Yuan <shaoxuan.yuan02@gmail.com>,
        Matheus Tavares <matheus.bernardino@usp.br>,
        ZheNing Hu <adlternative@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Sep 26, 2022 at 10:38 AM Junio C Hamano <gitster@pobox.com> wrote:
>
> "Elijah Newren via GitGitGadget" <gitgitgadget@gmail.com> writes:
>
> > +    In the case of am and apply, those commands only operate on the
> > +    working tree, so they are kind of in the same boat as stash.
>
> "apply" does not touch the HEAD but it can touch the index; when it
> operates with the "--cached" or the "--index" option, it should not
> be considered as a working-tree-only command.

Ah, right, good flag.  This helps resolve part of my question, but
gives me a new question as well.

Without --cached or --index, I think we'd need to make `apply` behave
like `stash` and just auto-vivify any files being tweaked.  If we
don't, we'll lose changes from the patch.

"apply --cached" could possibly just update the index.  However, it
appears to have another bug I need to add to the known bugs section.
`apply --cached` updates the index, but the new index entry fails to
carry over the "SKIP_WORKTREE" bit, making it appear there is an
unstaged deletion of the file.  (Users can run `git sparse-checkout
reapply` afterwards as a workaround.).  This is slightly weird for
files with conflicts (created when running `git apply -3 --cached`)
since those files with content conflicts will not be present in the
working tree, but that's in line with the fact that `git apply -3
--cached` refuses to touch the working tree in general.

In line with `--cached`, we could have "apply --index" do updates to
both the index and the working copy, while ensuring any
"SKIP_WORKTREE" bits are preserved for non-conflicted files.  However,
would preserving "SKIP_WORKTREE" bits be weird for users?  On one
hand, `git apply` without `--index` auto-vivifies files and `--index`
says to "also apply changes to the index" -- but preserving
SKIP_WORKTREE bits would make the `--index` flag also affect how the
working tree is treated, which might seem odd.  On the other hand,
merge/cherry-pick/rebase will update files in the index while leaving
the file missing from the working tree when not conflicted, so there
is some precedent for such behavior.  The question might just be
whether `git apply --index` should be more like mergy behavior, or
more like `git apply`/`git stash` behavior.

> "am" is about recording what is in the patch as a commit.

Does that mean it should behave like "apply --index"?  Or more like
cherry-pick?  (This question might be moot depending on what we choose
for "apply --index", in particular, it won't matter if we preserve
SKIP_WORKTREE bits on non-conflicted files.)

> > +    Perhaps `git am` could run `git sparse-checkout reapply`
> > +    automatically afterward and move into a category more similar to
> > +    merge/rebase/cherry-pick, but it'd still be weird because it'd
> > +    vivify files besides just conflicted ones when there are conflicts.
>
> I do not particularly think it is so bad.

For some reason I was thinking of running `git sparse-checkout
reapply` only if the `am` operation succeeded, which would give us a
special one-off command treatment.  If we instead view it as always
running `git sparse-checkout reapply` whether or not we hit conflicts,
or equivalently, if we view `git am` preserving SKIP_WORKTREE bits on
non-conflicted files, then I agree it's not weird anymore and can be
classified in the same group as merge/rebase/cherry-pick.

But something else you said confuses me...

> How would we handle the case where the user modifies paths outside
> the sparse specification and makes a commit out of the result,
> without using "am"?  We should be consistent with that use case, i.e.
>
>     $ edit path/outside/sparse/specification
>     $ git add path/outside/sparse/specification
>     $ git commit
>
> Do we require some "Yes, I am aware that I need to widen my sparse
> specification to do this, because I am now stepping out of it, and I
> understand that my sparse specification becomes wider after doing
> this operation" confirmation with "add" or "commit"?  If not, then I
> think "am" should silently widen just like these commands.  If they
> do, then "am" should also require such an option.  Perhaps call it
> "--widen-sparse" or whatever.

The command
    $ edit path/outside/sparse/specification
doesn't make sense to me; the file (and perhaps also its leading
directories) are missing.  Most editors will probably tell you that
you are editing a new file, but then it's more of a "rewrite from
scratch" than an "edit".

Typically, we'd expect users who want to edit such files to do so by
first running the `add` or `set` subcommands of sparse-checkout to
change their sparse specification so that the file becomes present.
But then it's no longer outside the sparse specification.  So, I'm not
sure how this angle could help guide our direction.

> By the way, I like the term "sparse specification" very much, as
> we should worry about non-cone mode as well.  Please use it
> consistently in this document after getting a concensus that it
> is a good phrase to use from others---I saw some other words
> used after "sparse" elsewhere in this patch.

:-)

> > +    In the case of ls-files, `git ls-files -t` is often used to see what
> > +    is sparse and not, in which case restricting would not make sense.
>
> I suspect that leaving it tree-wide would allow scripters come up
> with Porcelains that restricts to the sparse specification more
> easily.
