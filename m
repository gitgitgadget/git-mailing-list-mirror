Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A5A79C433E6
	for <git@archiver.kernel.org>; Fri, 19 Feb 2021 17:12:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7566660235
	for <git@archiver.kernel.org>; Fri, 19 Feb 2021 17:12:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229934AbhBSRMR (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 19 Feb 2021 12:12:17 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50014 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229863AbhBSRMO (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 19 Feb 2021 12:12:14 -0500
Received: from mail-lj1-x22d.google.com (mail-lj1-x22d.google.com [IPv6:2a00:1450:4864:20::22d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 77382C061756
        for <git@vger.kernel.org>; Fri, 19 Feb 2021 09:11:59 -0800 (PST)
Received: by mail-lj1-x22d.google.com with SMTP id o16so19026115ljj.11
        for <git@vger.kernel.org>; Fri, 19 Feb 2021 09:11:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=usp.br; s=usp-google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=i9ssgXZnprCatDnyP/GwFh43S6FMtA8CFgo1P18CaRo=;
        b=eK/QhTBKVbT3e1TGyQ72hWlDvRNJ9gg76uorLzjjqrIyxMQYfxNxp3HeOHQS3zIqEW
         Gr57wDfG+NSBb1KpDMigUtiNIWsAPouu/uAI2MdGnWz6j3eewzVgZZ36iCl8DCeXY1n2
         DWP/eeqzhZSwCLGViJThbxAn5HyVMNTZV8ij0DrKytTF7SB0RxV5o9mT1n70o+gYCJpj
         /n6poRt/qxomb8DbvpuNg0JgwgWRVN4O1Af/D2RmqMn27fq+YfzUoY5OXtjXhsrsAkyd
         oobs18u3MqUTmLM3kbSq6siuKZ/PTPqxyC3Fo7KN3ORvoSPkHPK2XWBnJzHQTG4MTMqO
         k0hg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=i9ssgXZnprCatDnyP/GwFh43S6FMtA8CFgo1P18CaRo=;
        b=WB5BmwZSau1ruwGOCDS56EhRC/S3JeyEC4HS5Fq1e2nc7ReESCSXYpEmTgwtFV2G2q
         pm6jGU9uoabRoSG5QW8cfZEk3h/H56h9X07LsYKaVA67uCVFZXgEcLQgYgi+gg68s6Ri
         RSNidZAd/6GiNaOHgeOa6SI5EJLurIXaGBXFZDUuD8WMVTi8rLxzROUFfT2RQ6yA9Q3n
         M8l9InwlNmj3EsI83By9eqZ9AWZGqZOUOauvsXU5pWDUmQGABToxP+4Ii1goyt749kEI
         sfsbMOvBa8RveSKUofPqcKzk3/22J25/dN7V+jAqjpCNBC8QdCYCdyljjyV9qAiPz+0v
         PEYA==
X-Gm-Message-State: AOAM530u/fKbCLb/QNRMa2CQQ/c224KRu7Ge7puS/jrAhgTVuxzqh5U/
        nwjAEW6W+Org7kRM+u+ZjhUROgS5kcmkO+ZzBg6Dr4LkDs2igQ==
X-Google-Smtp-Source: ABdhPJwO4PKhatLpictRUPHzg4WAC0YtXiqoxoDZrFLsqgv+oPhXk0lHgPIM5uDJlyxFuGb3bIDnnmy2c0e9ngVb7tY=
X-Received: by 2002:a05:6512:1044:: with SMTP id c4mr6262511lfb.538.1613754717957;
 Fri, 19 Feb 2021 09:11:57 -0800 (PST)
MIME-Version: 1.0
References: <cover.1613593946.git.matheus.bernardino@usp.br>
 <8f1bc014ae8a34c0bc43d1a2b8c0ebdbe7e47e02.1613593946.git.matheus.bernardino@usp.br>
 <xmqqo8ggc2u1.fsf@gitster.g>
In-Reply-To: <xmqqo8ggc2u1.fsf@gitster.g>
From:   Matheus Tavares Bernardino <matheus.bernardino@usp.br>
Date:   Fri, 19 Feb 2021 14:11:46 -0300
Message-ID: <CAHd-oW6KVQeGq1aQV+sFD+XJ=cpH3GRWWHasJAZ92Sqiczjq9g@mail.gmail.com>
Subject: Re: [RFC PATCH 6/7] add: warn when pathspec only matches
 SKIP_WORKTREE entries
To:     Junio C Hamano <gitster@pobox.com>
Cc:     git <git@vger.kernel.org>, Elijah Newren <newren@gmail.com>,
        Derrick Stolee <stolee@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Feb 18, 2021 at 9:34 PM Junio C Hamano <gitster@pobox.com> wrote:
>
> Matheus Tavares <matheus.bernardino@usp.br> writes:
>
> > `git add` already refrains from updating SKIP_WORKTREE entries, but it
> > silently succeeds when a pathspec only matches these entries. Instead,
> > let's warn the user and display a hint on how to update these entries.
>
> "Silently succeeds" reads as if it succeeds to update, but that is
> not what you meant.

Ok, I will rephrase this section.

> I guess the warning is justified and is desirable because an attempt
> to add an ignored path would result in a similar hint, e.g.
>
>     $ echo '*~' >.gitignore
>     $ git add x~
>     hint: use -f if you really want to...
>     $ git add .
>
> It is curious why the latter does not warn (even when there is
> nothing yet to be added that is not ignored), but that is what we
> have now.

Yeah, this also happens with other directories:

    $ echo 'dir/file' >.gitignore
    $ mkdir dir
    $ touch dir/file
    $ git add dir
    <no warning>

In your previous example, `git add '*~'` and `git add '[xy]~'` also
wouldn't warn about 'x~'.  IIUC, that's because `add` uses
DIR_COLLECT_IGNORED for fill_directory(), and this option "Only
returns ignored files that match pathspec exactly (no wildcards)."

> > Note: refresh_index() was changed to only mark matches with
> > no-SKIP-WORKTREE entries in the `seen` output parameter. This is exactly
> > the behavior we want for `add`, and only `add` calls this function with
> > a non-NULL `seen` pointer. So the change brings no side effect on
> > other callers.
>
> And possible new callers that wants to learn from seen[] output
> would want the same semantics, presumably?

Hmm, TBH I haven't given much thought about new callers that might
want to use seen[]. Perhaps would it be better to implement this
behind a REFRESH_* flag?

> > +test_expect_success 'do not advice about sparse entries when they do not match the pathspec' '
> > +     setup_sparse_entry &&
> > +     test_must_fail git add nonexistent sp 2>stderr &&
> > +     test_i18ngrep "fatal: pathspec .nonexistent. did not match any files" stderr &&
> > +     test_i18ngrep ! "The following pathspecs only matched index entries" stderr
>
> This is because both of the two pathspec elements given do not match
> the sparse entries?

Oops, 'sp' should not be here. But yes, it doesn't display the advice
because the pathspec didn't match 'sparse_entry'.

> It is curious how the command behaves when
> given a pathspec that is broader, e.g. "." (aka "everything under
> the sun").  We could do "add --dry-run" for the test if we do not
> want to set up .gitignore appropriately and do not want to smudge
> the index with stderr, expect, actual etc.

I'll add a test for '.', and perhaps also another test for the case
where the pathspec matches both sparse and dense entries. For the '.'
case, I think we could use a simple .gitignore with '*' and
'!/sparse_entry'.
