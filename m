Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 5B4CA20A1E
	for <e@80x24.org>; Mon, 10 Dec 2018 17:18:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727722AbeLJRSz (ORCPT <rfc822;e@80x24.org>);
        Mon, 10 Dec 2018 12:18:55 -0500
Received: from mail-ua1-f65.google.com ([209.85.222.65]:37565 "EHLO
        mail-ua1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726261AbeLJRSy (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 10 Dec 2018 12:18:54 -0500
Received: by mail-ua1-f65.google.com with SMTP id u19so4095026uae.4
        for <git@vger.kernel.org>; Mon, 10 Dec 2018 09:18:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=UcITCHBmPybMJHLVMbM/e/1CVrOCZur/n+J2h5pwX94=;
        b=tKduuAoKqXqtfnrsvkY2CYhPRp2VBit+UzO52INvDnTW7qkI5QNwkGIOhvmnLX6rsj
         jXadCFgBbEAIsKhmq58pTaGcXCd222KNrNPcanC1muxQ5Vrv/ElOIp0fBNPT0NA70fl8
         c2UIU8GteWy4mdqpm7V0U+sHqIi5kEGalJL6Zoaju1MxXV9rDiC2KaO8iY4/UKLJ2InE
         QQ+aI6yqL1n255XjTd7qcPgbgiUD9HWexnjPvRuJn7DcrUGIaE6gOggs+n5iglMGBEHh
         3QulBVkscSyI5PV9zrRbfpZgRgQBjurDJqCcAIvris0TVZZTMq13fJzB8EJP1Ft3OXso
         FfSQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=UcITCHBmPybMJHLVMbM/e/1CVrOCZur/n+J2h5pwX94=;
        b=E6ezjEC/OEfo3ITIb4Q1bPb5WcSDuXHVi/hhhagztdz0JYkv+zNIn8c/kUlUuXUPB4
         Jm0cVQZt/OfWbHy1SkTRIUzKg5vJ83CAX/Wxka5D7UPsoxSJGFlUUJKVwluJbLnPrKIU
         o0ASVwP1hzzJqGZN6KWkr2gzB5PYb43E/K2cvORDC46susDAczGwgw7mcOnxkC0wpmOQ
         7l0JOKlTB6TBUjuizbmZqrG0tvva3vMmbnE0yiiEVCnCJLGDRrFyipBvsaLsgfcXvW4k
         4OfvK682CupJ4PXN+iU4VXR95hrvySpk2jnDniqjj6YpBtlkoQB11lgUM+2sABovcWrE
         6y8Q==
X-Gm-Message-State: AA+aEWb6mGBn1zq6/3/rl8dL4mm4ovwmwCMYpNY17sz1LiRuVIhzxxVo
        MkO+swPD175y8i5XVb6hEmnKgUNEUJSTujtdb7IySgQ2
X-Google-Smtp-Source: AFSGD/UA1TsawzUSuIqlAbXfokWk+1LfKfZ59N52tXbAA5d0uHhst3pe+s5tufI89PuqYrobAiqia9CxWEdVuNoNedY=
X-Received: by 2002:ab0:210e:: with SMTP id d14mr5890761ual.20.1544462332478;
 Mon, 10 Dec 2018 09:18:52 -0800 (PST)
MIME-Version: 1.0
References: <20181209200449.16342-1-t.gummerer@gmail.com>
In-Reply-To: <20181209200449.16342-1-t.gummerer@gmail.com>
From:   Elijah Newren <newren@gmail.com>
Date:   Mon, 10 Dec 2018 09:18:40 -0800
Message-ID: <CABPp-BFaWtDiBPuGQVU_+VGQtDkemDKnvjHhz+h1sbUGssffmQ@mail.gmail.com>
Subject: Re: [PATCH 0/8] introduce no-overlay and cached mode in git checkout
To:     Thomas Gummerer <t.gummerer@gmail.com>
Cc:     Git Mailing List <git@vger.kernel.org>,
        Junio C Hamano <gitster@pobox.com>,
        =?UTF-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41j?= <pclouds@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Sun, Dec 9, 2018 at 12:04 PM Thomas Gummerer <t.gummerer@gmail.com> wrote:
>
> Here's the series I mentioned a couple of times on the list already,
> introducing a no-overlay mode in 'git checkout'.  The inspiration for
> this came from Junios message in [*1*].
>
> Basically the idea is to also delete files when the match <pathspec>
> in 'git checkout <tree-ish> -- <pathspec>' in the current tree, but
> don't match <pathspec> in <tree-ish>.  The rest of the cases are
> already properly taken care of by 'git checkout'.

Yes, but I'd put it a little differently:

"""
Basically, the idea is when the user run "git checkout --no-overlay
<tree-ish> -- <pathspec>" that the given pathspecs should exactly
match <tree-ish> after the operation completes.  This means that we
also want to delete files that match <pathspec> if those paths are not
found in <tree-ish>.
"""

...and maybe even toss in some comments about the fact that this is
the way git checkout should have always behaved, it just traditionally
hasn't.  (You could also work in comments about how with this new mode
the user can run git diff afterward with the given commit-ish and
pathspecs and get back an empty diff, as expected, which wasn't true
before.  But maybe I'm belaboring the point.)


> The final step in the series is to actually make use of this in 'git
> stash', which simplifies the code there a bit.  I am however happy to
> hold off on this step until the stash-in-C series is merged, so we
> don't delay that further.
>
> In addition to the no-overlay mode, we also add a --cached mode, which
> works only on the index, thus similar to 'git reset <tree-ish> -- <pathspec>'.

If you're adding a --cached mode to make it only work on the index,
should there be a similar mode to allow it to only work on the working
tree?  (I'm not as concerned with that here, but I really think the
new restore-files command by default should only operate on the
working tree, and then have options to affect the index either in
addition or instead of the working tree.)

> Actually deprecating 'git reset <tree-ish> -- <pathspec>' should come
> later, probably not before Duy's restore-files command lands, as 'git
> checkout --no-overlay <tree-ish> -- <pathspec>' is a bit cumbersome to
> type compared to 'git reset <tree-ish> -- <pathspec>'.

Makes sense.

> My hope is also that the no-overlay mode could become the new default
> in the restore-files command Duy is currently working on.

Absolutely, yes.  I don't want another broken command.  :-)


> No documentation yet, as I wanted to get this out for review first.
> I'm not familiar with most of the code I touched here, so there may
> well be much better ways to implement some of this, that I wasn't able
> to figure out.  I'd be very happy with some feedback around that.
>
> Another thing I'm not sure about is how to deal with conflicts.  In
> the cached mode this patch series is not dealing with it at all, as
> 'git checkout -- <pathspec>' when pathspec matches a file with
> conflicts doesn't update the index.  For the no-overlay mode, the file
> is removed if the corresponding stage is not found in the index.  I'm
> however not sure this is the right thing to do in all cases?

Here's how I'd go about analyzing that...

If the user passes a <tree-ish>, then the answer about what to do is
pretty obvious; the <tree-ish> didn't have conflicts, so conflicted
paths in the index that match the pathspec should be overwritten with
whatever version of those paths existed in <tree-ish> (possibly
implying deletion of some paths).

Also, as you point out, --cached means only modify the index and not
the working tree; so if they specify both --cached and provide no
tree, then they've specified a no-op.

So it's only interesting when you have conflicts in the index and
specify --no-overlay without a <tree-ish> or --cached.  This boils
down to "how do we update the working tree to match the index, when
the index is conflicted?"  A couple points to consider:
  * This is somewhat of an edge case
  * In the normal case --no-overlay is only different from --overlay
behavior for directories; it'd be nice if that extended to all cases
  * How does this command behave without a <tree-ish> when
--no-overlay is specified and a directory is given for a <pathspec>
and there aren't any conflicts?  Are we being consistent with that
behavior?


However, I think it turns out that the answer is much simpler than all
that initial analysis or what you say you've implemented.  Here's why:

If <pathspec> is a file which is present in both the working tree and
the index and it has conflicts, then "git checkout -- <pathspec>" will
currently throw an error:

$ git checkout -- subdir/counting
error: path 'subdir/counting' is unmerged

In fact, even if every entry in subdir/ is a path that is in both the
index and the working tree (so that --no-overlay and --overlay ought
to behave the same), if any one of the files in subdir is conflicted,
attempting to checkout the subdir will abort with this same error
message and no paths will be updated at all:

$ git checkout -- subdir
error: path 'subdir/counting' is unmerged

as such, the answer with what to do with --no-overlay mode is pretty
clear: if the <pathspec> matches _any_ path that is conflicted, simply
throw an error and abort the operation without making any changes at
all.
