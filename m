Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id DE2DD20281
	for <e@80x24.org>; Tue, 12 Sep 2017 22:29:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751018AbdILW3u (ORCPT <rfc822;e@80x24.org>);
        Tue, 12 Sep 2017 18:29:50 -0400
Received: from mail-wm0-f54.google.com ([74.125.82.54]:46466 "EHLO
        mail-wm0-f54.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750984AbdILW3t (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 12 Sep 2017 18:29:49 -0400
Received: by mail-wm0-f54.google.com with SMTP id i189so5027512wmf.1
        for <git@vger.kernel.org>; Tue, 12 Sep 2017 15:29:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=52oFbERUPZAtyf5XIiV4q8/p5e80vo82aw/MLeuru3s=;
        b=Boy7COgxTGka2HrRllpIADj1LqJ2l4sUYB0UAUg5gvLJjhPc+Lnzi20qpmH7wnct+b
         4gqbLlASmyOGFOUIeO/lrMVzSQ0OE/sgyuLVcXEXOTcISruGiE7fHhJ8boQlY65VvyAQ
         0v1I4f/Bt9rSDocM31ZzCQU2NOpMkRGfKQ5lEPpQMjj5n5tCX62iTVHEoV47fPugj80+
         dDGUwVrL2gqJKNTveKHY0rNkKFkc4OaTgXw//yJiyVT+oToPwSph0hOITyt3hK/arQ7s
         UGUuCtIfXeiAFr0+ekTP8wV3oU82XgMbqW8PEAP4Z3fmDER75RKfhjcc3x6KHB9srFUT
         tmyw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=52oFbERUPZAtyf5XIiV4q8/p5e80vo82aw/MLeuru3s=;
        b=TUQxV1QqbSj9VuH94+i3mYX2tqws1E1gGU7dp+2LftkYcqFi14LlnzvXU3QWTLXdfq
         NH6H6dzqCBHWkrXbq4ClE+TwuxkWm2mP/PL8gD7LbRYZausy+v7WaY5rXV7msKP4NL6/
         kz1vKduqGvY6bK0spQXOUbCZWkxmNe/ih0Nd6Z2eaoKxYWw4qOBjsHtIi687+NbtH+sZ
         ngE9P45XRAK26rQGxuNwED/JqPCTfUjEQaf9P2xhOgq/HwPnPcIkBtcj4TSPSReO5uFi
         1f+Et3sJXJW8Lbr5CgwI3AaHCioKKkDLvRUNZlNU7YHj00sQWKxpCrQRpG5qggJxdjKE
         GiOg==
X-Gm-Message-State: AHPjjUhRFTVZlk0VIBzRr/WcbDaGEJIy6GrRAYx1gG8rApEy+a3KkLEY
        hp1Wrxc8FmfcWCpK98mQodrGc+iDzWxc5kfIj7A=
X-Google-Smtp-Source: ADKCNb7t04Y8lGYRbqmaoQXxIr03vIZn/FbIJ8RlsXnnGG1dRdHFtvXQQCX0GRNsc0P8BTmOccTjbfNxYHxQXpm+waA=
X-Received: by 10.80.186.110 with SMTP id 43mr13147595eds.18.1505255388387;
 Tue, 12 Sep 2017 15:29:48 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.80.146.185 with HTTP; Tue, 12 Sep 2017 15:29:27 -0700 (PDT)
In-Reply-To: <SN1PR21MB0014435A97BCDA324FD55B46B7690@SN1PR21MB0014.namprd21.prod.outlook.com>
References: <20170908180050.25188-1-kewillf@microsoft.com> <20170908180050.25188-2-kewillf@microsoft.com>
 <xmqqvaktxawk.fsf@gitster.mtv.corp.google.com> <SN1PR21MB0014638E5D9CBFD0D9D85F10B7950@SN1PR21MB0014.namprd21.prod.outlook.com>
 <xmqqr2vgy2yt.fsf@gitster.mtv.corp.google.com> <SN1PR21MB00140C84DC02F3491F4E8469B76A0@SN1PR21MB0014.namprd21.prod.outlook.com>
 <xmqqh8w951ek.fsf@gitster.mtv.corp.google.com> <alpine.DEB.2.21.1.1709111259430.4132@virtualbox>
 <xmqq4ls836z3.fsf@gitster.mtv.corp.google.com> <SN1PR21MB0014435A97BCDA324FD55B46B7690@SN1PR21MB0014.namprd21.prod.outlook.com>
From:   Jacob Keller <jacob.keller@gmail.com>
Date:   Tue, 12 Sep 2017 15:29:27 -0700
Message-ID: <CA+P7+xqxmxexWS=MWNd9=EqG81uhKY-OdG+1mpyWhst6DvH5AA@mail.gmail.com>
Subject: Re: [PATCH 1/1] reset: fix reset when using the sparse-checkout feature.
To:     Kevin Willford <kewillf@microsoft.com>
Cc:     Junio C Hamano <gitster@pobox.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        "git@vger.kernel.org" <git@vger.kernel.org>,
        "peff@peff.net" <peff@peff.net>,
        "pclouds@gmail.com" <pclouds@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Sep 12, 2017 at 1:20 PM, Kevin Willford <kewillf@microsoft.com> wrote:
>> From: Junio C Hamano [mailto:gitster@pobox.com]
>> Sent: Monday, September 11, 2017 9:57 PM
>>
>> Let's imagine a path P that is outside the sparse checkout area.
>> And we check out a commit that has P.  P would still be recorded in
>> the index but it would not materialize in the working tree.  "git
>> status" and friends are asked not to treat this as "locally removed",
>> to prevent "commit -a" from recording a removal, of course.
>>
>> Now, let's further imagine that you have a checkout of the same
>> project but at a commit that does not have P.  Then you reset to
>> another commit that does have P.  My understanding of what Kevin's
>> first test wants to demonstrate is that the index is populated with
>> P (because you did reset to a commit with that path) but it does not
>> materialize in the working tree (perhaps because that is outside the
>> sparse checkout area?), yet there is something missing compared to
>> the earlier case where "git status" and friends are asked not to
>> treat P as "locally removed".  They instead show P as locally removed,
>> and "commit -a" would record a removal---that is indeed a problem.
>>
>> Am I reading the problem description correctly so far?  If so, then
>> my answer to my first question (are we solving a right problem?) is
>> yes.
>>
>
> I think this is where I need to do a better job of explaining so here is a
> simple example.
>
> I have a file "a" that was added in the latest commit.
> $ git log --oneline
> c1fa646 (HEAD -> reset, master) add file a
> 40b342c Initial commit with file i
>
> Running the reset without using a sparse-checkout file
>
> $ git reset HEAD~1
> $ git status
> On branch reset
> Untracked files:
>   (use "git add <file>..." to include in what will be committed)
>
>         a
>
> nothing added to commit but untracked files present (use "git add" to track)
>
> Turning on sparse-checkout and running checkout to make my working
> directory sparse
>
> $ git config core.sparsecheckout true
> $ echo /i > .git/info/sparse-checkout
> $ git checkout -f
>
> Running reset gives me
> $ git reset HEAD~1
> $ git status
> On branch reset
> nothing to commit, working tree clean
> $ git ls-files
> i
>
> file a is gone.  Not in the index and not in the working directory.
> Nothing to let the user know that anything changed.
>
> With a modified file no sparse-checkout
> $ git log --oneline
> 6fbd34a (HEAD -> reset, modified) modified file m
> c734d72 Initial commit with file i and m
> $ git reset HEAD~1
> Unstaged changes after reset:
> M       m
> $ git status
> On branch reset
> Changes not staged for commit:
>   (use "git add <file>..." to update what will be committed)
>   (use "git checkout -- <file>..." to discard changes in working directory)
>
>         modified:   m
>
> no changes added to commit (use "git add" and/or "git commit -a")
>
> With sparse-checkout
> $ git reset HEAD~1
> Unstaged changes after reset:
> D       m
> $ git status
> On branch reset
> Changes not staged for commit:
>   (use "git add/rm <file>..." to update what will be committed)
>   (use "git checkout -- <file>..." to discard changes in working directory)
>
>         deleted:    m
>
> no changes added to commit (use "git add" and/or "git commit -a")
>

Wasn't "m" outside the sparse checkout? Or was it a file in the sparse
checkout? I mean to say, the file after setting up sparse checkout was
one of the "interesting" files that sparse checked out?

Or was it in fact a separate file which wasn't there?

I would think that in sparse-checkout world, you should only *ever*
have the files you list in sparse.

So files outside sparse world should be ignored, not shown and not
show up in status, but they should absolutely not show up in the
working tree either.

You're not "changing" any commits, because the status of the file at
HEAD~1 is exactly what HEAD~1 says it is, but you just don't have a
checked out copy of it.

I think the key problem is that reset is clearing the sparse flag of a
file so that it no longer shows up as sparse, which is why status
subsequently shows the file deleted (since you don't have a local copy
anymore).

Am I understanding the problem correctly? I think your examples above
are not clear because they don't seem to be each complete individually
(The sparse checkout examples should start from a clean world and
explain how they got there rather than relying on imformation in the
prior non sparse example. We should be clear so everyone knows what
the problem is).

If you're performing a sparse checkout and you modify files outside of
the sparse area, I think that will cause problems, and we may not be
making the best efforts to resolve it. I do agree that if you have
created a file "m" when only "i" is in your path, that we should
absolutely not delete "m" but leave it as is.

Thanks,
Jake

> I think we can agree that this is not the correct behavior.
>
>> But this time, I am trying to see if the approach is good.  I am not
>> so sure if the approach taken by this patch is so obviously good as
>> you seem to think.  A logical consequence of the approach "git
>> status thinks that P appears in the index and missing in the working
>> tree is a local removal, so let's squelch it by creating the file in
>> the working tree" is that we will end up fully populating the
>> working tree with paths that are clearly outside the area the user
>> designated as the sparse checkout area---surely that may squelch
>> "status", but to me, it looks like it is breaking what the user
>> wanted to achieve with "sparse checkout" in the first place.
>>
>
> I don't think that we are trying to "squelch" status so much as make
> it consistent with what the user would expect to happen.  If that means
> not resetting entries with the skip-worktree bit or resetting the entries
> but keeping the skip-worktree bit on, okay, but I would argue that is
> not what the user wants because if you are now saying that sparse
> means git will not change files outside the sparse-checkout entries,
> what about merge, rebase, cherry-pick, apply?  Should those only
> change the files that are in the sparse definition?  If so we would
> be changing the commits from the original, i.e.  cherry-pick 123 would
> create a different commit depending on whether or not you are using
> sparse as well as a different commit depending on what is in your
> sparse-checkout.
>
> I see reset being a similar scenario in that if everything is clean, after I
> "reset HEAD~1" I should be able to run "add ." + "commit" and have
> the same commit as before the reset.  If this is changed to only reset
> the sparse entries, there will be staged changes after the reset because
> HEAD has changed but we didn't update the index versions of the files.
> If we do update the index with the "HEAD~1" version of the files and just
> set the skip-worktree bit then the next commit will not have the original
> changes outside the sparse-checkout for the commit.
>
>> When we make a sparse checkout that places P outside the checked-out
>> area, with P in the index and not in the working tree, what asks
>> "git status" and friends not to treat P as "locally removed"?
>> Shouldn't "reset HEAD~1" that resurrected P that was missing in the
>> commit in the state before you did the "reset" be doing the same
>> (e.g. flipping the bit in the index for path P that says "not having
>> this in the working tree is not a removal---it is deliberately not
>> checked out")?  If that is the right approach to solve the issue
>> (which we established is a right problem to solve already), and the
>> approach that the patch wants to take is quite the opposite of it,
>> then my answer to the second question (are we solving the problem
>> with the right approach?) is no.  And at that point, it is moot to
>> ask if the code correctly and/or efficiently implements that wrong
>> solution, isn't it?
>
> I agree that we must determine if there is a problem, which I hope
> we can agree that there is a valid problem to be addressed.  Determining
> if I used the right approach depends on how you see reset working
> correctly using the sparse feature.  Should it match a reset when not
> using sparse or should it reset only sparse files?  I saw issues
> if only the sparse files are the ones reset, which is the reason that
> I went with this approach.
>
> Thanks,
> Kevin
