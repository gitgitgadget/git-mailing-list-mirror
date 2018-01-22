Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id EEB461F404
	for <e@80x24.org>; Mon, 22 Jan 2018 17:58:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751134AbeAVR6G (ORCPT <rfc822;e@80x24.org>);
        Mon, 22 Jan 2018 12:58:06 -0500
Received: from mail-vk0-f41.google.com ([209.85.213.41]:46899 "EHLO
        mail-vk0-f41.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751085AbeAVR6G (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 22 Jan 2018 12:58:06 -0500
Received: by mail-vk0-f41.google.com with SMTP id e125so5484618vkh.13
        for <git@vger.kernel.org>; Mon, 22 Jan 2018 09:58:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=3CfgvsqZ25XsOmAYhyZlgn85IJdwNcnqYatXI7VWYS4=;
        b=jE7D8mGmYb6NglxU6/rIEylWzffd+yZ/8p9ilBk8/Ynl6ig5ancD/RoZmPsztveuzA
         ulT7cSSs2VBfmS16rVkqg8izd56tpabXE5E3f3OAHGr9+oqGypS4Z+l2KJELbFMZUswq
         j8pmZskb8cGd+FxMtuxAFIkMFwYXz8pLMS3urqI+U+C+i9dPO1I/111uprx86Z+NVmqw
         vZZxgl4L2t4j0Tf067SNX04CeC53PkB3o+uPtqwrlRdnq9HBaIYW13WZUO5cnSTrn6P8
         k3QUjxxIKLIsP0fKNHS76gHu34Uu8wxi+ajfSS87kzCujtGok333/cdXgCQ6l6ct09ZE
         5nMQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=3CfgvsqZ25XsOmAYhyZlgn85IJdwNcnqYatXI7VWYS4=;
        b=sqJqkuN6TAWd9KZ5+VOtKpv5Ejj21m80naihZfby9J8qDvBNIy7a6upuU5sAPNgORb
         QOdnhEkyDKif1auREyykYG9ovfKZfpcHfbZhUNRLaHryd86JSMbF6U6k0TBYtaO822WE
         xcmMe8pXRrcGtKUCioDMMkhUG98D/Z8OnwFm5WdS9tJ4xHsuAx8rg0C1O5FLRCeOjKsm
         JhJQf1AI+LOVy4BCC3JnQ52WbGYkq+qMO4HRH9S553jP9NJQ8go13jc0a3RFAAiiibkN
         lajYFu3BOv4sVE1OHM9KpCuIbe1tV+7Nc8e9LYDMLzirzr7W1sDOeNHR02ccL/dw3VyT
         WEZg==
X-Gm-Message-State: AKwxytdMADj+MHkJCqJ2zIAHoVvmH/gcV3vVtgINdXMjyGha88CIc9Sy
        2tDLSkXp3rg04GDEvGGOQB8uI+IVaIXdZaKvY5du3g==
X-Google-Smtp-Source: AH8x227OKOqAU6sleJdA79r5az+1G/v+YqYuS67EaWQvFHpt1NDaBS0ky0aGoQPOuT+SZLVhZOwdEXPwBg4Ow0Qr6t0=
X-Received: by 10.31.33.86 with SMTP id h83mr5022131vkh.183.1516643884869;
 Mon, 22 Jan 2018 09:58:04 -0800 (PST)
MIME-Version: 1.0
Received: by 10.176.8.83 with HTTP; Mon, 22 Jan 2018 09:58:04 -0800 (PST)
In-Reply-To: <CAFAcib-2fxiVxtVWcbvafY3-Br7Y70HMiHFZoT0VfK6JU0Dp9A@mail.gmail.com>
References: <CAFAcib-2fxiVxtVWcbvafY3-Br7Y70HMiHFZoT0VfK6JU0Dp9A@mail.gmail.com>
From:   Elijah Newren <newren@gmail.com>
Date:   Mon, 22 Jan 2018 09:58:04 -0800
Message-ID: <CABPp-BGYs9jo16OZR8NsL-eO9LwEttBxBspvp1-_JjuD2oBYbA@mail.gmail.com>
Subject: Re: git merge-tree: bug report and some feature requests
To:     Josh Bleecher Snyder <josharian@gmail.com>
Cc:     Git Mailing List <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Sat, Jan 20, 2018 at 7:00 PM, Josh Bleecher Snyder
<josharian@gmail.com> wrote:
> Hi, all.
>
> I'm experimenting with some new porcelain for interactive rebase. One
> goal is to leave the work tree untouched for most operations. It looks
> to me like 'git merge-tree' may be the right plumbing command for
> doing the merge part of the pick work of the todo list, one commit at
> a time. If I'm wrong about this, I'd love pointers; what follows may
> still be interesting anyway.

I don't have a concrete alternative (yet?) but here are some pointers
to two alternate merge-without-touching-working-tree possibilities, if
your current route doesn't pan out as well as you like:

I posted some patches last year to make merge-recursive.c be able to
do merges without touching the working tree.  Adding a few flags would
then enable it for any of 'merge', 'cherry-pick', 'am', or
'rebase'...though for unsuccessful merges, there's a clear question of
what/how conflicts should be reported to the user.  That probably
depends a fair amount on the precise use-case.

Although that series was placed on the backburner due to the immediate
driver of the feature going away, I'm still interested in such a
change, though I think it would fall out as a nice side effect of
implementing Junio's proposed ideal-world-merge-recursive rewrite[1].
I have started looking into that[2], but no guarantees about how
quickly I'll find time to finish or even whether I will.

[1] https://public-inbox.org/git/xmqqd147kpdm.fsf@gitster.mtv.corp.google.com
[2] https://github.com/newren/git/blob/ort/ort-cover-letter contains
overview of ideas and notes to myself about what I was hoping to
accomplish; currently it doesn't even compile or do anything

> 4. API suggestion
>
> Here's what I really want 'git merge-tree' to output. :)
...
> If the merge had conflicts, write the "as merged as possible" tree to

You'd need to define "as merged as possible" more carefully, because I
thought you meant a tree containing all the three-way merge conflict
markers and such being present in the "resolved" file, but from your
parenthetical note below it appears you think that is a different tree
that would also be useful to diff against the first one.  That leaves
me wondering what the first tree is. (Is it just the tree where for
each path, if that path had no conflicts associated with it then it's
the merge-resolved-file, and otherwise it's the file contents from the
merge-base?).

Both of these trees are actually rather non-trivial to define.  The
wording above isn't actually sufficient, because content conflicts
aren't the only kind of conflict.  More on that below.

There is already a bunch of code in merge-recursive.c to create a
forcibly-merged-accepting-conflict-markers-in-the-resolution and
record it as a tree (this is used for creating virtual merge bases in
the recursive case, namely when there isn't a single merge-base for
the two branches you are merging).  It might be reusable for what you
want here, but it's not immediately clear whether all the things it
does are appropriate; someone would have to consider the non-content
(path-based) conflicts carefully.

> the object database and give me its sha, and then also give me the
> three-way merge diff output for all conflicts, as a regular patch
> against that tree, using full path names and shas. (Alternatively,
> maybe better, give me a second sha for a tree containing all the
> three-way merge diff patches applied, which I can diff against the
> first tree to find the conflict patches.)

As far as I can tell, you're assuming that it's possible with two
trees that are crafted "just right", that you can tell where the merge
conflicts are, with binary files being your only difficulty.  Content
conflicts aren't the only type that exist; there are also path-based
conflicts.  These type of conflicts also make it difficult to know how
the two trees you are requesting should even be created.

For example, if there is a modify/delete conflict, how can that be
determined from just two trees?  If the first tree has the base
version of the file, then the second tree either has a file at the
same position or it doesn't.  Neither case looks like a conflict, but
the original merge had one.  You need more information.  The exact
same thing can be said for rename/delete conflicts.

Similarly, rename/add (one side renames an existing file to some new
path (say, "new_path"), and the other adds a brand new file at
"new_path), or rename/rename(2to1) (each side renames a different file
to the same location), won't be detectable just by diffing two trees.
These are often handled by moving both files to some other location,
so there's no way to record in a tree that there was a conflict.

rename/rename(1to2) is similar, but instead of two different original
files being renamed to the same thing, this is one file being renamed
differently on different sides of history.

I know that several of the examples above involved rename detection,
which git-merge-trees won't even do, but that means you're even more
likely to face the modify/delete conflict cases.  And our list still
isn't done, either:

Directory/file conflicts (one side puts a directory of the same name
that the other side adds as a file) will also cause problems.

Finally, directory rename detection (currently in pu under review)
adds a few "implicit dir rename" conflict types (renames of multiple
directories would cause multiple files to be renamed to the same
location, or an existing file/dir being in the way of one or more
path(s) getting implicitly renamed).  This means that the number of
types of non-textual conflicts might also grow in the future so it may
be unwise to try to special case existing exceptions with a bag of
clever workarounds.


Hope that helps,
Elijah
