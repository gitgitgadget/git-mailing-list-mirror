Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AF042C433F5
	for <git@archiver.kernel.org>; Sat,  2 Oct 2021 23:30:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7E2FB6136A
	for <git@archiver.kernel.org>; Sat,  2 Oct 2021 23:30:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234191AbhJBXbx (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 2 Oct 2021 19:31:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41752 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229911AbhJBXbw (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 2 Oct 2021 19:31:52 -0400
Received: from mail-ed1-x533.google.com (mail-ed1-x533.google.com [IPv6:2a00:1450:4864:20::533])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5D133C061714
        for <git@vger.kernel.org>; Sat,  2 Oct 2021 16:30:06 -0700 (PDT)
Received: by mail-ed1-x533.google.com with SMTP id bd28so48899430edb.9
        for <git@vger.kernel.org>; Sat, 02 Oct 2021 16:30:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=mWi9gO3hb6Jl25W86JvP5ya1tUKyTJdJB9wjNbujKK0=;
        b=F1Zx+/3CPCgUvXlaylXwPjbfM8+VDZ+i55VNG7cmGjfGreZLJbZ8yoybtXazaRxIte
         /VZEl35eDH/Edn59vKK3CHpM/KH0nrZtvtV1qU3m6CrTU7VKtcUBTWBPlfWS8+B5tfju
         oOFJ/CHtcfG6XvcjuthQB84NLgrJ944IfrRz34hmjb7SjnIo5p7f2UW+y5zpfrbmQJ9u
         7QN7CZlnvbQuJxSFu7NkfoRuWaX7praCknuGmRE4cmuc7wb31+N1u7Lcgr0eML2+itHZ
         X01rga8rkQyT6Pts249nuWiH/JSafaXL9zf1SLBgf4mR2hH2Ec7pRKear9ACvZ3NKcvc
         lDxQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=mWi9gO3hb6Jl25W86JvP5ya1tUKyTJdJB9wjNbujKK0=;
        b=pWTPuqzketwUviFODhd5IJIHpTzS/YpgxUm9dLHY9FGFgwSPKIpavecjJCMg0mX1Cj
         q70IO1ZcNwDRQB1LBuzIiAcXThH15/nl7VgPPGIuy9a58eWGAOmPcxGlvOq9yjWkJv2n
         LQUkUmEnuvzpdhuCdiQnGV9z3wZg6TfB0AVM3mQnS2LJ5O/THdEnRFiWoR0EF9hNLP3T
         a/24o+e2CpilcDDu0mwdRNZOz8QWsYqwMI2Flmw3l9QzyNlETu8lLLj7eicKMxPopCsf
         t8SlKUlOabO8VpYw4Jk0YlD7XfGzDPzKfpfGQcMDcMUgN8+o54s3amuMeh8FvPvMsnrf
         cWhg==
X-Gm-Message-State: AOAM530Z8D788SvWsDb7gTnC3MhIXAQE8vdktpxS272/1TDQqlmWE7CK
        mluSzEoZ+fuHIa2BBBV2Lk0fug2krnWMULuYATu+t72S6lfmuA==
X-Google-Smtp-Source: ABdhPJyLMUV9bkeo/m/IqQuDinwG6kF1/G03+dSwHYvrcUQ1mGW9M2sUxhm1Fx3mCosoQm7ajjQxe/z46YNxJzC7YUk=
X-Received: by 2002:a05:6402:1d9c:: with SMTP id dk28mr7309565edb.241.1633217404861;
 Sat, 02 Oct 2021 16:30:04 -0700 (PDT)
MIME-Version: 1.0
References: <20211002213046.725892-1-aclopte@gmail.com> <20211002213046.725892-2-aclopte@gmail.com>
In-Reply-To: <20211002213046.725892-2-aclopte@gmail.com>
From:   Elijah Newren <newren@gmail.com>
Date:   Sat, 2 Oct 2021 16:29:52 -0700
Message-ID: <CABPp-BFqJi0q0844NKfU8K5HRpAJ7yP2OkyBUiFQSAw-ZjNoyw@mail.gmail.com>
Subject: Re: [PATCH 2/2] Documentation/git-status: document porcelain status T (typechange)
To:     Johannes Altmanninger <aclopte@gmail.com>
Cc:     Git Mailing List <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Sat, Oct 2, 2021 at 2:38 PM Johannes Altmanninger <aclopte@gmail.com> wrote:
>
> As reported in [1], T is missing from the description of porcelain
> status letters in git-status(1) (whereas T is documented in
> git-diff-files(1) and friends). Document T right after M (modified)
> because the two are very similar.

Good; thanks for sending this in.

> A porcelain status containing C (copied) is impossible because "git
> status" does not detect copies, only renames.

This is no true (since ~2018); here's an example:

    $ cp -a README.md README-copy
    $ echo garbage >>README.md
    $ git add README-copy README.md
    $ git -c status.renames=copy status --porcelain
    C  README.md -> README-copy
    M  README.md

You can also use diff.renames instead of status.renames, since the
latter defaults to the former.  Note that you do need to both modify
and stage README.md in the example above to see the copy status.

> I was going to delete
> mentions of C from git-status.txt because it keeps confusing users [2]
> but a discussion from 2014 suggests that "git status" should re-learn
> to detect copies, which was disabled in 2005 for (obsolete) performance
> reasons [3].

That thread you refer to suggests it was turned off because copy
detection meant the equivalent of find-copies-harder, and that thread
also provided numbers showing find-copies-harder would still be very
painful performance-wise.  Perhaps the "obsolete performance reasons"
was meant to imply that basic copy detection is cheaper since it does
something different today than what status's copy detection did back
then, but summarizing this as "obsolete performance reasons" feels
misleading to me.

> [1] https://github.com/fish-shell/fish-shell/issues/8311
> [2] https://www.reddit.com/r/git/comments/ppc2l9/how_to_get_a_file_with_copied_status/
> [3] https://marc.info/?l=git&m=141755095826447&w=2

Links to lore.kernel.org would be much preferred to marc.info links;
here that would be
https://lore.kernel.org/git/20141202200910.GB23461@peff.net/.

The lore.kernel.org links provide an interface to easily search for
other mailing list messages, and use the Message-ID in the URL which
makes it easier for people to find the message in other locations,
etc.

> Signed-off-by: Johannes Altmanninger <aclopte@gmail.com>
> ---
>  Documentation/git-status.txt | 17 ++++++++++-------
>  1 file changed, 10 insertions(+), 7 deletions(-)
>
> diff --git a/Documentation/git-status.txt b/Documentation/git-status.txt
> index 83f38e3198..40f308c6a6 100644
> --- a/Documentation/git-status.txt
> +++ b/Documentation/git-status.txt
> @@ -207,6 +207,7 @@ show tracked paths:
>
>  * ' ' = unmodified
>  * 'M' = modified
> +* 'T' = file type changed (regular file, symbolic link or submodule)
>  * 'A' = added
>  * 'D' = deleted
>  * 'R' = renamed
> @@ -217,14 +218,16 @@ show tracked paths:
>  X          Y     Meaning
>  -------------------------------------------------
>          [AMD]   not updated
> -M        [ MD]   updated in index
> -A        [ MD]   added to index
> +M        [ MTD]  updated in index
> +T        [ MTD]  type changed in index
> +A        [ MTD]  added to index
>  D                deleted from index
> -R        [ MD]   renamed in index
> -C        [ MD]   copied in index
> -[MARC]           index and work tree matches
> -[ MARC]     M    work tree changed since index
> -[ MARC]     D    deleted in work tree
> +R        [ MTD]  renamed in index
> +C        [ MTD]  copied in index
> +[MTARC]          index and work tree matches
> +[ MTARC]    M    work tree changed since index
> +[ MTARC]    T    type changed in work tree since index
> +[ MTARC]    D    deleted in work tree

Looks good up to here.

>  [ D]        R    renamed in work tree
>  [ D]        C    copied in work tree

This wasn't something you added; it appears these two came from commit
176ea74793 ("wt-status.c: handle worktree renames", 2017-12-27).
However, I don't think the 'D' part of these examples is possible.  If
a file is deleted in the index relative to HEAD (what the 'D' means),
then comparing the index to the worktree means the file didn't even
exist in the index.  Thus no delete pair for that file will be passed
to diffcore-rename, and without a delete pair for some file, there is
nothing for the add pairs to be combined with to create a rename or
copy pair.  So these lines are misleading and should only have a space
in the first column rather than either a space or 'D'.

That said, of course, since this wasn't caused by your patch, you are
under no obligation to fix.  It would go nicely with your series,
though.  Would you like to add another patch to your series to fix
that, or would you rather that I contributed such a patch separately?

Thanks for the contribution!
