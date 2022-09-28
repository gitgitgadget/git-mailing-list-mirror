Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 03E19C32771
	for <git@archiver.kernel.org>; Wed, 28 Sep 2022 06:13:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232496AbiI1GNr (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 28 Sep 2022 02:13:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59606 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232156AbiI1GNj (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 28 Sep 2022 02:13:39 -0400
Received: from mail-lf1-x12d.google.com (mail-lf1-x12d.google.com [IPv6:2a00:1450:4864:20::12d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EC843122A44
        for <git@vger.kernel.org>; Tue, 27 Sep 2022 23:13:37 -0700 (PDT)
Received: by mail-lf1-x12d.google.com with SMTP id d42so18940397lfv.0
        for <git@vger.kernel.org>; Tue, 27 Sep 2022 23:13:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date;
        bh=Yu6qf0uq/vJpUUwIoLAEsS807CZab1s2lQGq/oYZuzE=;
        b=UGY3BBngF4oDWZEei9Of4YE0KrLhxoC37Boq0ppVSOoPt9j3AjtsvG1EUqfx4LkNDy
         DmqpevTurk3WwROqQAUUt2ndFv4Ahg3glKM2LbKnmrfYCVT99wMBkE5dCXs3rCUWEr4n
         erom6yZCo9utvEyVSdh94azTeFarZDE3fn/c4ZxtKpvB/WRY6SjlioWmliRSRLYcep80
         O2LYyJrBHO19VgBtzBgMLdIjDd1e90qv3RuwPb5/5DxY+iH4yPnuYcioajw97203i8YE
         O4CbX7LDHQANfTyIcZCknWBxC6MRRCSv5AoN19Lm9fE/uz2A63hoNFoQkZ1iRGDqk9vM
         hhzw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date;
        bh=Yu6qf0uq/vJpUUwIoLAEsS807CZab1s2lQGq/oYZuzE=;
        b=A4h1piYxKlJ8xvYdSfcsoMZXCLCCMxYnpp684eTxAfCIuf5XTxEuaYHBC53Q0a7jpy
         /GWQlptk8dAg62XzjRPFSCuZOb0EjWLfj8IgZ9zAhXpd2FPlN68UGb45frZ0FHR459UD
         KDh6uxg4mTGFCmzRTD9hlkdjjpeYj5YNNuyb2MfkaM1DvrSayP4J9nD4iaWkV9v4IARk
         Mwj3EXkbSDqqK5y9Yv/rVAQbgjT7nwhvmmJ/cLf4goH6b9EiMmhuZ8ETlphfTrNs41Ve
         1K5bVsw9QkNbd+iLJGORCEQ2kt1eISP5nRMWcyPlzZ+vvu4g1wkQlttKBI8SqAuCu0PB
         Loog==
X-Gm-Message-State: ACrzQf1TK+QxOpSq7iIt/wFovFIAAqYpzaLhGYeuTNafWzoqnPGNTvx3
        i+FSAc42OfVCuGFtiY4SaS2lkdUCCYb1ACl+hpk=
X-Google-Smtp-Source: AMsMyM77mxBiAMVG7saomlU3+XKA8wJtdQZbGsyLkqdpwHZhI99gRFzky6+63oepWewd6QH6iYOP0Un7JQGagAwaOLM=
X-Received: by 2002:a05:6512:b82:b0:4a0:5970:115c with SMTP id
 b2-20020a0565120b8200b004a05970115cmr10883124lfv.531.1664345616202; Tue, 27
 Sep 2022 23:13:36 -0700 (PDT)
MIME-Version: 1.0
References: <pull.1367.git.1664064588846.gitgitgadget@gmail.com>
 <a89413b5-464b-2d54-5b8c-4502392afde8@github.com> <xmqqv8p9ahly.fsf@gitster.g>
 <CABPp-BESkb=04vVnqTvZyeCa+7cymX7rosUW3rhtA02khMJKHA@mail.gmail.com> <xmqqzgek7qd9.fsf@gitster.g>
In-Reply-To: <xmqqzgek7qd9.fsf@gitster.g>
From:   Elijah Newren <newren@gmail.com>
Date:   Tue, 27 Sep 2022 23:13:24 -0700
Message-ID: <CABPp-BEuPMZzTc5Lj_cO43XpivZ3+TKhxC11oqzP5_YSLsBrsw@mail.gmail.com>
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

On Tue, Sep 27, 2022 at 9:07 AM Junio C Hamano <gitster@pobox.com> wrote:
>
> Elijah Newren <newren@gmail.com> writes:
>
> > Oh, wow, that's something completely outside what I had considered.  I
> > had viewed sparse-checkouts as splitting "tracked files" into two
> > subsets.  As such, `--[no-]restrict` could only affect selecting
> > whether the smaller or larger set of tracked files was of interest.
> > From that viewpoint, untracked files seemed orthogonal, and thus there
> > couldn't be such a thing as an "anamalous untracked file".
> >
> > But this idea is very interesting.  Hmm...
>
> We need to design the behaviour of "git add" sensibly.  Even we say
> "untracked files are just one class and there are two classes of
> tracked ones, those path of current interest and those that are
> uninteresting", we would need to say "'git add F' behaves this way
> if F would become 'tracked path of current interest' when added, but
> the command behaves this other way if F becomes 'tracked path that
> is not interesting right now'".  It may be cleaner to separate the
> untracked ones along the same line as the tracked ones.
>
> Which in turn would mean that the skip-worktree bit cannot be the
> source of truth.  Sparsity specification (either pattern matching or
> being in listed directories) authoritatively decides if a path is of
> the current interest or not.  This is simply because untracked ones
> cannot have that bit ;-)  We can treat the skip-worktree bit as mere
> implementation detail, a measure for optimization.

I like this idea.  Seems I should then move 'status' into the category
with add/rm/mv -- commands that need to be modified to treat untracked
files carefully.

Of course, this also may drag "git clean" into that category...though
I'm not sure how or if it'd differ.


[...]
> > It feels like "git grep --cached" is perhaps the next thing along this
> > sequence, and I don't see a clear line where to draw that we should
> > limit things to the sparse specification for the index while treating
> > the other operations as full tree; it seems like something feels
> > broken or inconsistent in this sequence of commands if we attempt to
> > do so.
>
> OK, it seems that "--cached" has many cases that it wants to operate
> on full tree.  I am in general more in favor of making things work
> on full tree, simply because I feel it would have less chance of
> going wrong, so defaulting to --no-restrict would be fine ;-)

Yeah, I think for the camp B folks, "--no-restrict" may make more
sense for operations searching or comparing to the index.

However, there's also another possibility I'm still mulling over.  To
understand it, first note that relative to the working tree, the
"sparse specification" can temporarily differ from the "paths matching
the sparsity patterns", because additional files might be transiently
present.  This most often happens due to conflicts, and we want
worktree related operations that behave under "restrict" mode (such as
"diff" or "grep" or "switch") to operate on all present tracked
files[1].  With that understanding, we could similarly consider that
relative to the index, the "sparse specification" could temporarily
differ from the "paths matching the sparsity patterns", because
additional paths outside the sparsity patterns could have been
modified in the index (e.g. during a merge or rebase or whatever).

Using a temporarily expanded sparsity specification may allow a
"restrict-like" behavior to make sense for index-related operations.
I currently think that'd be more useful for the camp A folks than the
camp B folks, though.

Either way, I don't think the index should use the sparsity defined by
or for the working tree.  The idea of using the working tree sparsity
for index-related operations may sound nice at first, but I think it
only behaves well when all paths modified in the index or working tree
are limited to those paths matching the sparsity patterns.  And
there's too many normal cases where that just doesn't hold.

[1] See also 82386b4496 ("Merge branch 'en/present-despite-skipped'",
2022-03-09)
