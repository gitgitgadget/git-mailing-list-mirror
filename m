Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 16047C433DB
	for <git@archiver.kernel.org>; Wed, 31 Mar 2021 09:15:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id DB53D619BB
	for <git@archiver.kernel.org>; Wed, 31 Mar 2021 09:15:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234622AbhCaJPC (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 31 Mar 2021 05:15:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33992 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234648AbhCaJOl (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 31 Mar 2021 05:14:41 -0400
Received: from mail-oi1-x22e.google.com (mail-oi1-x22e.google.com [IPv6:2607:f8b0:4864:20::22e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D96E2C061574
        for <git@vger.kernel.org>; Wed, 31 Mar 2021 02:14:40 -0700 (PDT)
Received: by mail-oi1-x22e.google.com with SMTP id w70so19430998oie.0
        for <git@vger.kernel.org>; Wed, 31 Mar 2021 02:14:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=QRx3nI6obSAtCJJ7xCPfOKkoO94cmDacAPDJZtFRjgs=;
        b=GWmwczvBphPNLaeLYz5mYx140oxro7iBC3jtSqvEqZOK4KGqLqxDE3vpe4T/rrkfJI
         dukvSzKZPobwu1rPRgzC48VZ6Pw/osECRnUoTCDMQ4zIG6qALuVqcukM9AjKBXeBUpK7
         m9KBqwARPslDJV/tolvTJ5z25cLwA5ksukl3sCqGX41vDUKQi6jj85QQ1TuI9f9Z19ra
         RmFr8jSs5Pq4XU/yIfrnJ/UwRVJpFWdjQNagEm5VFk+0rYic8gBhxJnaFGCkoN3p9CX4
         j3RHNghdTHFEhD+/uREyeTaRkxvcr+FWRNNDgXk/mwpCNOn8f9WkH4uh7Y3vlUVYwDMT
         +e+w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=QRx3nI6obSAtCJJ7xCPfOKkoO94cmDacAPDJZtFRjgs=;
        b=e/7W1lXlhsAVFT4WPTxCk/+lX2athcGqGW15ab8016JdS5GDhI4rzP+Kux1K00aaSF
         X74bUnb+KmlIKec+B7T9ALfW24FT9KqpYo1TLcd9os62LBSqwSzHEaaDfJY3ac6x7vEZ
         xESaxOU3kRU3UF/EmDlIlEKURUpf90Qi5EFLvSiBqBvd+ve4XDUIrBcRPqLdfzMNDepb
         0ObOp/rOuJEOqzHhIss9TqStDFEFnaY42j/xNNp6ZxPWPap9Ae0rc7LajoUIIQTteplY
         TFGQ++Ko6Dfajo4fDEuwupiU2vQYlY/dRM0ipuCu23aGjGQD8dANOKOqm9C1RrBtXJEI
         z4Kg==
X-Gm-Message-State: AOAM530TlFKPw3CJMbIao38PTAi9WYsP84QwJ9JfcRbd81cZ14VzLMnX
        sRzaGyN1jep1/NTrnZkoaCGk5Z2omiPsVVgSi0vyDjanSmc=
X-Google-Smtp-Source: ABdhPJye6JD9GhewggpIjFslk2gvAzPpG9RxyydXMpVK0WDP6rG+9DEi4yfHda8pXjrH72cIXA5dbiyJbA1xmohju4Q=
X-Received: by 2002:aca:6545:: with SMTP id j5mr1612717oiw.31.1617182080283;
 Wed, 31 Mar 2021 02:14:40 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1615588108.git.matheus.bernardino@usp.br>
 <34a61a0d03868c43d68a04bca8d86dd98de2aa28.1615588109.git.matheus.bernardino@usp.br>
 <xmqqsg4sowks.fsf@gitster.g> <xmqqo8fgovuz.fsf@gitster.g> <CAHd-oW4V4_XrY7XfQO1gLEZZmzcLbG0_M2ys+Meh4Ysu0Psz0Q@mail.gmail.com>
 <xmqqlfajnn6w.fsf@gitster.g> <CAHd-oW4kRLjV9Sq3CFt-V1Ot9pYFzJggU1zPp3Hcuw=qWfq7Mg@mail.gmail.com>
In-Reply-To: <CAHd-oW4kRLjV9Sq3CFt-V1Ot9pYFzJggU1zPp3Hcuw=qWfq7Mg@mail.gmail.com>
From:   Elijah Newren <newren@gmail.com>
Date:   Wed, 31 Mar 2021 02:14:29 -0700
Message-ID: <CABPp-BGjuz1ZEriCOhrpakQCQ8AZ12ovir5Vm233nadvywcWcA@mail.gmail.com>
Subject: Re: [PATCH v3 5/7] refresh_index(): add REFRESH_DONT_MARK_SPARSE_MATCHES
 flag
To:     Matheus Tavares Bernardino <matheus.bernardino@usp.br>
Cc:     Junio C Hamano <gitster@pobox.com>, git <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi,

On Tue, Mar 30, 2021 at 11:51 AM Matheus Tavares Bernardino
<matheus.bernardino@usp.br> wrote:
>
> On Fri, Mar 19, 2021 at 1:05 PM Junio C Hamano <gitster@pobox.com> wrote:
> >
> > Matheus Tavares Bernardino <matheus.bernardino@usp.br> writes:
> >
> > >> In other words, the change makes me wonder why we are not adding a
> > >> flag that says "do we or do we not want to match paths outside the
> > >> sparse checkout cone?", with which the seen[] would automatically
> > >> record the right thing.
> > >
> > > Yeah, makes sense. I didn't want to make the flag skip the sparse
> > > paths unconditionally (i.e. without matching them) because then we
> > > would also skip the ce_stage() checkings below and the later
> > > ce_mark_uptodate(). And I wasn't sure whether this could cause any
> > > unwanted side effects.
> > >
> > > But thinking more carefully about this now, unmerged paths should
> > > never have the SKIP_WORKTREE bit set anyway, right? What about the
> > > CE_UPTODATE mark, would it be safe to skip it? I'm not very familiar
> > > with this code, but I'll try to investigate more later.
>
> Sorry I haven't given any update on this yet. From what I could see so
> far, it seems OK to ignore the skip_worktree entries in
> refresh_index() when it is called from `git add --refresh`. But
> because we would no longer mark the skip_worktree entries that match
> the pathspec with CE_UPTODATE, do_write_index() would start checking
> if they are racy clean (this is only done when `!ce_uptodate(ce)`),
> which could add some lstat() overhead.
>
> However, this made me think what happens today if we do have a racy
> clean entry with the skip_worktree bit set... `git add --refresh` will
> probably update the index without noticing that the entry is racy
> clean (because it won't check CE_UPTODATE entries, and skip_worktree
> entries will have this bit set in refresh_index()). Thus the entries'
> size won't be truncated to zero when writing the index, and the entry
> will appear unchanged even if we later unset the skip_worktree bit.
>
> But can we have a "racy clean skip_worktree entry"? Yes, this seems
> possible e.g. if the following sequence happens fast enough for mtime
> to be the same before and after the update:
>
>   echo x >file
>   git update-index --refresh --skip-worktree file
>   echo y>file
>
> Here is a more complete example which artificially creates a "racy
> clean skip_worktree entry", runs `git add --refresh`, and shows that
> the racy clean entry was not detected:
>
> # Setup
> echo sparse >sparse
> echo dense >dense
> git add .
> git commit -m files
>
> # Emulate a racy clean situation
> touch -d yesterday date
> touch -r date sparse
> git update-index --refresh --skip-worktree sparse
> touch -r date .git/index
> echo xparse >sparse
> touch -r date sparse
>
> # `git add` will now write a new index without checking if
> # `sparse` is racy clean nor truncating its size
> touch -r date dense
> git add --refresh .
>
> git update-index --no-skip-worktree sparse
> git status
> <doesn't show that `sparse` was modified>
>
> This situation feels rather uncommon, but perhaps the same could
> happen with `git sparse-checkout set` instead of `git update-index
> --refresh --skip-worktree`? IDK. This made me think whether
> refresh_index() should really mark skip_worktree entries with
> CE_UPTODATE, in the first place.
>
> Any thoughts?

Wow, that's a weird one.  Nice digging.  I don't understand the racily
clean stuff that well, or the CE_UPTODATE handling...but based on my
meager understanding of these things I'd say that marking
skip_worktree entries with CE_UPTODATE seems wrong and I'd agree with
your hunch that we shouldn't be updating it for those files.  If an
entry is skip_worktree, it's assumed to not be present in the working
tree and that we'll treat it as "unchanged".  So, when the filehappens
to be present despite that bit being set, checking the files' stat
information or pretending to have done so so we can claim it is up to
date seems wrong to me.  In fact, I'd say the mere recognition that
the file is present in the working tree despite being SKIP_WORKTREE to
me implies it's not "up-to-date" for at least one definition of that
term.

I suspect that if someone flips the skip-worktree bit on and off for a
file without removing it from the working tree, not marking
skip_worktree entries with CE_UPTODATE as you mention above might
force us to incur the cost of an extra stat on said file when we run
"git status" later.  If so, I think that's a totally reasonable cost,
so if that was your worry, I'd say that this is shifting the cost
where it belongs.

But, like I said, I'm not very familiar with the racily clean code or
CE_UPTODATE, so it's possible I said something above that doesn't even
make sense.  Does my reasoning help at all?
