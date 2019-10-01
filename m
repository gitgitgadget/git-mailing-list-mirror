Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 050D31F4BD
	for <e@80x24.org>; Tue,  1 Oct 2019 16:12:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731362AbfJAQMn (ORCPT <rfc822;e@80x24.org>);
        Tue, 1 Oct 2019 12:12:43 -0400
Received: from mail-ua1-f65.google.com ([209.85.222.65]:40386 "EHLO
        mail-ua1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726063AbfJAQMm (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 1 Oct 2019 12:12:42 -0400
Received: by mail-ua1-f65.google.com with SMTP id i13so5647712uaq.7
        for <git@vger.kernel.org>; Tue, 01 Oct 2019 09:12:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Uwg598raz+KTGi6DcZwCePsBLdqBMZMzvQkrpgBYf/I=;
        b=ndRk5OLEJ/2izeBV1lU8Udaaz7xRzte26UTHrWSQHMuD7q7k/sXC7H44bBaNbb1Tz4
         37e3S7qqWkfWxI5+z5CC7SbjQbpx0IZcowYyGa1ZeFgvkcHNcc4O+wpvrjY+IRtDrjQU
         8gwiUNZ2qHwF4dwl/6yFHD7SjpjptEPRCMjE73C6REnlD0hABXL3b9bDpa5TJxgQR6KN
         SBdCWiSxPzhO527BBNMVYWTDE9tOr9tAa59hk2CE7mxbDW+ub/s9juwMUFf0oBYUoVAd
         U6khe/KbdwIKfF1LZXtBo1OmUDK/Bv4iw+tO6W9GKxoWsygG7uVsgIbTb0a1OFy8f6uH
         WH7A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Uwg598raz+KTGi6DcZwCePsBLdqBMZMzvQkrpgBYf/I=;
        b=LYLQHJv0yS0UyVpGobCD+YGdc8BIVCyw8mnXYoG30heSUoIvixo9gdxppOg14DvLe8
         wxRoFwhh/Wvmt26j3hyeRQ1EjyucVDoYiPRnODNHzZapAaYnl78uwE9mqdXK+rQivsOj
         bbQGartgRU1aRN2dGRCqH53V+Z1+e7QFT8h9ccgsldwg25Md5nGaAqSPdjgkCVZ5xu/5
         QBOjwMeEVbdgokCkNFLiLZ7NZyy+nyCulJA3BrvC26Qo1vHQiXsT8+mezJDNu9ZOhJFY
         GwDmdGFEmzwWXlJuGwzBsPbS49LKokAl3Zbj9tyk1gzPRmIohoQcAESp2JNjRc12V9QR
         /C5w==
X-Gm-Message-State: APjAAAVNiJlaL5Unf02bZQ4Yc3CuRONllaWH9EIweslB5LCaqEsH5T9v
        ZPuO78/ofLjPNTXntoi3y1JfDcU2wyceTpmOqZc=
X-Google-Smtp-Source: APXvYqwpjv8+25jCXIMHdv2/hs4ZTCqPNcFTI8hzv3ErWd1FXKBhLlfE5mrrFT1Z9cMBIzBX5kDFIPTbU/f6/PrsFeM=
X-Received: by 2002:a9f:31cd:: with SMTP id w13mr1462106uad.81.1569946358348;
 Tue, 01 Oct 2019 09:12:38 -0700 (PDT)
MIME-Version: 1.0
References: <CAHd-oW7e5qCuxZLBeVDq+Th3E+E4+P8=WzJfK8WcG2yz=n_nag@mail.gmail.com>
 <CAKPyHN3G-j6p8YZmk+07Sb3tL9vua_R-hJ=W81O7vCYr07AkxA@mail.gmail.com>
In-Reply-To: <CAKPyHN3G-j6p8YZmk+07Sb3tL9vua_R-hJ=W81O7vCYr07AkxA@mail.gmail.com>
From:   Elijah Newren <newren@gmail.com>
Date:   Tue, 1 Oct 2019 09:12:26 -0700
Message-ID: <CABPp-BGuFhDwWZBRaD3nA8ui46wor-4=Ha1G1oApsfF8KNpfGQ@mail.gmail.com>
Subject: Re: git-grep in sparse checkout
To:     Bert Wesarg <bert.wesarg@googlemail.com>
Cc:     Matheus Tavares Bernardino <matheus.bernardino@usp.br>,
        git <git@vger.kernel.org>, Jeff King <peff@peff.net>,
        Derrick Stolee <dstolee@microsoft.com>,
        Taylor Blau <me@ttaylorr.com>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Oct 1, 2019 at 6:30 AM Bert Wesarg <bert.wesarg@googlemail.com> wrote:
>
> Hi,
>
> On Tue, Oct 1, 2019 at 3:06 PM Matheus Tavares Bernardino
> <matheus.bernardino@usp.br> wrote:
> >
> > Hi,
> >
> > During Git Summit it was mentioned that git-grep searches outside
> > sparsity pattern which is not aligned with user expectation. I took a
> > quick look at it and it seems the reason is
> > builtin/grep.c:grep_cache() (which also greps worktree) will grep the
> > object store when a given index entry has the CE_SKIP_WORKTREE bit
> > turned on.
> >
>
> I also had once this problem and found that out and wrote a patch. I
> was just about to send this patch out.
>
> Btw, ls-files should also learn to skip worktree files.
>
> Stay tuned.

I too have a small patch for just grep without --cached or revisions
(it's only a few lines), but it's very incomplete as that is the only
usecase it handles.  For the usecases I'm closest too, what users have
reported they want is essentially a miniature repo where they work on
stuff they care about and ignore the rest.  As such, the desired
functionality for these users is:

* git grep, by default, should only search within the sparsity pattern
* git grep --cached and git grep $REVISION should also only search
within the sparsity pattern
* git diff $REV1 $REV2, git diff $REV1, etc., should by default only
search within sparsity patterns
* git log should by default only show commits modifying files matching
the sparsity patterns
* for all of these, there should be some kind of
--ignore-sparsity-patterns flag to allow searching outside the
sparsity pattern
* other commands (archive, bisect, clean?, gitk, shortlog, blame,
fsck?, etc.) likely need to pay attention to sparsity patterns as
well, but there are some special cases:

* merge, cherry-pick, and rebase (anything touching the merge
machinery) will need to expand the size of the non-sparse worktree if
there are files outside the sparsity patterns with conflicts.  (Though
merge should do a better job of not expanding the non-sparse worktree
when files can cleanly be resolved.)
* ls-files has a -t option which can be used to differentiate which
entries in the index are skip-worktree (S) and which are not.  As
such, use of that flag should probably imply
--ignore-sparsity-patterns
* fast-export and format-patch are not about viewing history but about
exporting it, and limiting to sparsity patterns would result in the
creation of an incompatible history.  As such, they should error out
without a --ignore-sparsity-patterns when invoked from a repository
that has a sparse checkout.
* We may want to augment status with additional information to remind
users they are in a sparse checkout
* New worktrees, by default, should copy the sparsity-patterns of the
worktree they were created from (much like a new shell inherits the
current working directory of it's parent process)

I should note here that Stolee wasn't so sure about having 'log' only
show commits that touched files within the sparse patterns, so we may
need some kind of config setting and have a good usability story for
what each of the settings means and usecases in order to guide how to
handle weird cases better.

Also, as if that weren't enough, there are two more challenges too:
1) As pointed out by Dscho in the contributor summit, we want
intersection of pathspecs specified by the user and those in the
sparsity patterns; e.g. if the user says `git diff $REV -- '*.c' `, we
want to show them a diff against $REV of all .c files that are within
their sparsity patterns.
2) We have two different kinds of path patterns, one for .gitignore
and sparse-checkout, and the other for command-line pathspecs.  See
https://public-inbox.org/git/xmqq4l1qpiaw.fsf@gitster-ct.c.googlers.com/.
These differences might make the implementation more difficult, and
making the two types of path patterns have more overlap might be a
necessary first step.

However, the "work with a miniature repo" probably makes the VFS for
Git and partial clone stuff easier -- we don't have to worry about the
incessant need to download more blobs after the initial partial clone
because git commands by default would avoid requesting them.  It also
would work quite nicely with a partial index -- we could have a
directory entry in the index and marked as skip-worktree and avoid
having all the paths under it show up in the index.  That would
accelerate many operations within git.



I'd love to work on this, but I've got plenty of other things on my
plate at the moment, so I probably won't get time for it at least
until the middle of next year.  But I thought I'd send out what I view
as the bigger picture.  Also, this is very much still idea stage; the
contributor summit refined some of the ideas and there may be more
refinement as more people in the list chime in.


Hope that helps,
Elijah
