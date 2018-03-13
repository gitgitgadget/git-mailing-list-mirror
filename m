Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 3D0131F404
	for <e@80x24.org>; Tue, 13 Mar 2018 00:39:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932267AbeCMAjB (ORCPT <rfc822;e@80x24.org>);
        Mon, 12 Mar 2018 20:39:01 -0400
Received: from mail-ua0-f177.google.com ([209.85.217.177]:36307 "EHLO
        mail-ua0-f177.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932225AbeCMAjA (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 12 Mar 2018 20:39:00 -0400
Received: by mail-ua0-f177.google.com with SMTP id j15so8107161uan.3
        for <git@vger.kernel.org>; Mon, 12 Mar 2018 17:38:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=+fw89n8qV4QjtpmpOIITvMeYACRs5t4YMNOqfOeF/Io=;
        b=h7Ic6ZetUezVXCX7g24IHihl7tqrUYrvLfT3yaJWESZlb+4IG3icwpQ709YpywAokT
         sHA6+y0McO/gyoF4rYDT7IAFg39gmPNDogbYfUhWvi+SJ3blQOyzo2a7VvurF22bLtTB
         JhBc3Gom2uL+/JsMAC6zXTl52/v75XhNzrGWZuDBmlQsgQmYN4NXoYWw/3I63EyqVakx
         7zobtwT7rg1dagcQqFi699b6rqxnVgKwY7JZWrGDBRLuLTUHRZYrsuBSVNoMmLbbKRoy
         FT8kVzP7dG8E/TEhSg4xdlgY+Ws4PXV9SexmJYqSEz7ljSWdsNAimpQzOV+gVeP0zTjO
         /kZw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=+fw89n8qV4QjtpmpOIITvMeYACRs5t4YMNOqfOeF/Io=;
        b=cuRwMChCBnZQLW4xhIVqO077/kGoOo3otYrMNGRLekSAVi5xLqyYjOz1WEzqEymRNv
         aZgL2FOvcEY7LE1K3UclLM5VE9lyuI5lahIxLOn1auBLVWj+2yaQlU/A5Bk2btvi2Vmu
         wjVv+vLFCIa64reXVlxEPos6LgzuNmyNdBU9Cq9uWrswW74zNaOESoWcgP3Cj01Goy9D
         oxQQ4cepf283UvZ44YqjLDkoi9Vzr0oy8EoB9ZhLSEaVYQqGQ4shjthLLWul6KImrMSd
         S7JIqwTJFhex2SrznUJcRyqveB8Kxo3K4xfR9Bvis+hNDAfMWiXMiBLV+xmWsoFTHYsP
         778A==
X-Gm-Message-State: AElRT7EgiysAlpyiQr/Z9VnkmXk4va489t/dWjyeKUh8twtPPnsnMHiP
        DZOnmyxkPo1DLQVfV72jCezV3MlOO8lagLjcnlM=
X-Google-Smtp-Source: AG47ELuVejHPxzG0zbZh2ykJtpnxLouJ9rpYXF2p76gkzaveHt/VYBIKD8C0GF5LumLtaiS+Hffq1k+mFob1WLbdNsY=
X-Received: by 10.176.95.81 with SMTP id z17mr7001676uah.29.1520901539070;
 Mon, 12 Mar 2018 17:38:59 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.176.1.49 with HTTP; Mon, 12 Mar 2018 17:38:58 -0700 (PDT)
In-Reply-To: <20180312213521.GB58506@aiede.svl.corp.google.com>
References: <CABPp-BEXcvgxcn4-OrDhjUpuOsGCJwE_XT+0eYOK4Ad_O5maOg@mail.gmail.com>
 <20180312184734.GA58506@aiede.svl.corp.google.com> <CABPp-BEdh+UOCpFn5Y1_RydR==dDHWTeNtBub+pPjH_06Ub28w@mail.gmail.com>
 <20180312213521.GB58506@aiede.svl.corp.google.com>
From:   Elijah Newren <newren@gmail.com>
Date:   Mon, 12 Mar 2018 17:38:58 -0700
Message-ID: <CABPp-BE653uMpwN4zfCCP8teRGmZ6v5NEyASCR1PTvHhoMKE1w@mail.gmail.com>
Subject: Re: Opinions on changing add/add conflict resolution?
To:     Jonathan Nieder <jrnieder@gmail.com>
Cc:     Git Mailing List <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

I'm worried that my attempt to extract add/add from the rest of the
discussion with rename/add and rename/rename resulted in a false sense
of simplification.  Trying to handle all the edge and corner cases and
remain consistent sometimes gets a little hairy.  Anyway...

On Mon, Mar 12, 2018 at 2:35 PM, Jonathan Nieder <jrnieder@gmail.com> wrote:
> Elijah Newren wrote:
>> On Mon, Mar 12, 2018 at 11:47 AM, Jonathan Nieder <jrnieder@gmail.com> wrote:
>

> Sorry for the lack of clarity.  My understanding was that the proposed
> behavior was to write two files:
>
>         ${path}~HEAD
>         ${path}~MERGE

(Just to be clear: The proposed behavior was to do that only when the
colliding files were dissimilar, and otherwise two-way merging.)

> My proposal is instead to write one file:
>
>         ${path}
>
> with the content that would have gone to ${path}~HEAD.  This is what
> already happens when trying to merge binary files.

Thanks for clarifying.

I feel the analogy to merging binary files breaks down here in more
than one way:

1)

Merging binary files is more complex than you suggest here.  In
particular, when creating a virtual merge base, the resolution chosen
is not the version of the file from HEAD, but the version of the file
from the merge base.  Nasty problems would result otherwise for the
recursive case.

If we tried to match how merging binary files behaved, we run into the
problem that the colliding file conflict case has no common version of
the file from a merge base.  So the same strategy just doesn't apply.
The closest would be outright deleting both versions of the file for
the virtual merge base and punting to the outer merge to deal with it.
That might be okay, but seems really odd to me.  I feel like it'd
unnecessarily increase the number of conflicts users will see, though
maybe it wouldn't be horrible if this was only done when the files
were considered dissimilar anyway.

2)

merging binary files only has 3 versions of the file to store at a
single $path in the index, which fit naturally in stages 1-3;
rename/add and rename/rename(2to1) have 4 and 6, respectively.  Having
three versions of a file from a 3-way merge makes fairly intuitive
sense.  Have 4 or 6 versions of a file at a path from a 3-way merge is
inherently more complex.  I think that just using the version from
HEAD risks users resolving things incorrectly much more likely than in
the case of a binary merge.


> [...]
>>> Can you add something more about the motivation to the commit message?
>>> E.g. is this about performance, interaction with some tools, to
>>> support some particular workflow, etc?
>>
>> To be honest, I'm a little unsure how without even more excessive and
>> repetitive wording across commits.
>
> Simplest way IMHO is to just put the rationale in patch 5/5. :)  In
> other words, explain the rationale for the end-user facing change in the
> same patch that changes the end-user facing behavior.

Patches 3, 4, and 5 all change end-user facing behavior -- one patch
per conflict type to make the three types behave the same (the first
two patches add more testcases, and write a common function all three
types can use).  The rationale for the sets of changes is largely the
same, and is somewhat lengthy.  Should I repeat the rationale in full
in all three places?

>>                                     Let me attempt here, and maybe you
>> can suggest how to change my commit messages?
>>
>>   * When files are wildly dissimilar -- as you mentioned -- it'd be
>> easier for users to resolve conflicts if we wrote files out to
>> separate paths instead of two-way merging them.
>
> Today what we do (in both the wildly-dissimilar case and the
> less-dissimilar case) is write one proposed resolution to the worktree
> and put the competing versions in the index.  Tools like "git
> mergetool" are then able to pull the competing versions out of the
> index to allow showing them at the same time.
>
> My bias is that I've used VCSes before that wrote multiple competing
> files to the worktree and I have been happier with my experience
> resolving conflicts in git.  E.g. at any step I can run a build to try
> out the current proposed resolution, and there's less of a chance of
> accidentally commiting a ~HEAD file.
>
> [...]
>> There are three types of conflicts representing two (possibly
>> unrelated) files colliding at the same path: add/add, rename/add, and
>> rename/rename(2to1).  add/add does the two-way merge of the colliding
>> files, and the other two conflict types write the two colliding files
>> out to separate paths.
>
> Interesting.  I would be tempted to resolve this inconsistency the
> other way: by doing a half-hearted two-way merge (e.g. by picking one
> of the two versions of the colliding file) and marking the path as
> conflicted in the index.  That way it's more similar to edit/edit,
> too.

Your proposal is underspecified; there are more complicated cases
where your wording could have different meanings.

I also had a backup plan was to propose making rename/add and
rename/rename(2to1) behave more like add/add (instead of making the
behavior for all three a blend of their current behaviors), but the
problem is I have two backup proposals to choose between.  And it
sounds like you're adding a third, which follows your ~HEAD strategy
from above.  Let me see if I can explain why your proposal is
underspecified:

For rename/rename(2to1) we have up to 3 sets of conflicts.  Let's say
we renamed A->C in HEAD and B->C on the other side.  We first need to
do a three-way content merge on the first C (with the other two
versions of A), then we need to do a three-way content merge on the
second C (with the other two versions of B).  This gives us two
different C's, both with possible conflict markers, that want to be
stored at the same pathname.  Let me call these two versions of C, C1
and C2.  C1 and C2 may or may not be similar.  Resolving the fact that
both want to be stored at C is what gives us potentially a third set
of conflicts.

What's your resolution strategy here, for each combination of cases
(has conflict markers or not; is similar to the other C or not;
working on a virtual merge base or not)?

For reference there are two possible backup strategies I could propose here:

Backup Proposal #1: act stricly like add/add:
Do a two-way merge of C1 and C2.  If we end up with nested conflict
markers, oh well.  Good luck, user.

Backup Proposal #2: act like add/add, but only if C1 and C2 don't have
conflict markers.
If C1 or C2 have conflict markers, behave as currently -- record C1
and C2 to different paths.
If C1 and C2 do not have conflict markers, two-way merge them and
record in the worktree at C.

My question for your counter-proposal:
Do you record C1 or C2 as C?  Or do you record the version of C from
HEAD as C?  And what do you pick when creating a virtual merge base?

Problems I see regardless of the choice in your counter-proposal:
  * If you choose C from HEAD, you are ignoring 3 other versions of
"C" (as opposed to just one other version when merging a binary file);
will the user recognize that and know how to look at all four
versions?
  * If you choose C1 or C2, the user will see conflict markers; will
the user recognize that this is only a _subset_ of the conflicts, and
that there's a lot of content that was completely ignored?
  * There is no "merge base of C1 and C2" to use for the virtual merge
base.  What will you use?
