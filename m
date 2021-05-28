Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7166FC47087
	for <git@archiver.kernel.org>; Fri, 28 May 2021 05:39:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3D61E6128B
	for <git@archiver.kernel.org>; Fri, 28 May 2021 05:39:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234131AbhE1Fkk (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 28 May 2021 01:40:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55022 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233646AbhE1Fki (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 28 May 2021 01:40:38 -0400
Received: from mail-oo1-xc2d.google.com (mail-oo1-xc2d.google.com [IPv6:2607:f8b0:4864:20::c2d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8504AC061760
        for <git@vger.kernel.org>; Thu, 27 May 2021 22:38:27 -0700 (PDT)
Received: by mail-oo1-xc2d.google.com with SMTP id f22-20020a4aeb160000b029021135f0f404so671065ooj.6
        for <git@vger.kernel.org>; Thu, 27 May 2021 22:38:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=0OwxlCIpFVNQmQU9XoqxO7nqv5mpCbAQijZoFvg1Ass=;
        b=PLLqUFZoXkdBRlqWtLR6UlvwQi62EXVY87eYS9F7NPUUCDdzmCJKoL4QMDwFox/8Ti
         Te/+puoGH/CF264sAj/TyIVSGFpYiUaipnKka5LhXDUuj1wyB035Z2QQMsgUb/jHW4+H
         Pp12nFOV5cPQjUJu+QbaaIxWYB+q9bgld6esshEzCLduWvnaqqKRyWrMTjMWwSeuaB1O
         Ni6MeWmcgPA8doeNzTV8HZojPOrL20A/hdIWEyoc69J4lVdMe3a2duffZhtwNUVBwYCB
         GhvoTl3IekvQq59rlQgF0bMacD8ui7UC3NZXx4EVxijhPRO8ikkwMSnnhdb7pi42IriB
         s3iw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=0OwxlCIpFVNQmQU9XoqxO7nqv5mpCbAQijZoFvg1Ass=;
        b=s7KI1vT3MtT1r1CrtN2xapDK5rNH+FwpYnAB2qL3UgNDABNBHS2hEGUK7uKzej3Eq4
         vOhTcZ/eXJ6wie00GBRW6DDl0TwU8i1qnKeEXdyhmKvcZE01cOLNuMVHKRV66VUb/as1
         E1/a+TTXzXoSuiQUZAJPRHGXZZs3ot1oMqqt0VKhDdrLLYyxcY799gye7DaJlgfYjkfw
         ifyuDlV1QeLV9d+gZZBzE/FRR22VBA1SXf5pBan0b7b+gtbVYbSCO+FjU6VGw0X78uec
         Fe8y3dvOgipriIWXpw5AvcyNr2IsaWkhZN4XYnri7dTTZmayA1ZxkxOuYfpaIVolH5U1
         vR7Q==
X-Gm-Message-State: AOAM530S+BATyeXkcG0ozntXZ7PfK8wFFRzZpvaPKfMPth7seJBUHxXD
        uCQjaWqZgexyYZpta/0ZrD9fIM3YaTZ5cyNl4dVmiA9G9dFQZw==
X-Google-Smtp-Source: ABdhPJxhBUNN4TnG+Y0JMYLS+tM1pW6dFQXb938DgxzRXPzzseCgOnNPr6JvV9423QkMWJgFeharPHEeyxcyyWG6F6s=
X-Received: by 2002:a4a:300b:: with SMTP id q11mr5515150oof.45.1622180306627;
 Thu, 27 May 2021 22:38:26 -0700 (PDT)
MIME-Version: 1.0
References: <20210526100932.2hw4rbazgvd6mzff@pengutronix.de>
 <CABPp-BGBY9kwqRQ+soa8=W2F+=8eQRYS3vWS_7UCC0K0qNTW1g@mail.gmail.com>
 <20210527215947.g2mnds6zj5uv5mjq@pengutronix.de> <20210527221501.rqw3sr6dzrddh7oe@pengutronix.de>
In-Reply-To: <20210527221501.rqw3sr6dzrddh7oe@pengutronix.de>
From:   Elijah Newren <newren@gmail.com>
Date:   Thu, 27 May 2021 22:38:15 -0700
Message-ID: <CABPp-BE48=97k_3tnNqXPjSEfA163F8hoE+HY0Zvz1SWB2B8EA@mail.gmail.com>
Subject: Re: time needed to rebase shortend by using --onto?
To:     =?UTF-8?Q?Uwe_Kleine=2DK=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>
Cc:     Git Mailing List <git@vger.kernel.org>, entwicklung@pengutronix.de
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, May 27, 2021 at 3:15 PM Uwe Kleine-K=C3=B6nig
<u.kleine-koenig@pengutronix.de> wrote:
>
> On Thu, May 27, 2021 at 11:59:47PM +0200, Uwe Kleine-K=C3=B6nig wrote:
> > I assume you are still interested in seeing this branch? I think
> > anonymising it shouldn't be so hard, the patches are not so big. I'll
> > modify the branch to make it shareable and assuming the problem still
> > reproduces with it will share it with you.
>
> You can find the anonymised branch at:
>
>         https://git.pengutronix.de/git/ukl/linux rebase-timing

Cool, this helps.  Short summary:

* I can't reproduce your factor 2 timing difference when rename
detection is active.  There still have to be other factors at play
(e.g. auto-gc).  Can you reproduce those?
* Your timing of merge-base was likely mistaken, due to where HEAD
pointed (see below).
* Without --onto, it looks like a huge chunk of time is spent checking
whether any of the 4 patches happen to match one of the patches in
v5.4..v5.10; passing --reapply-cherry-picks will save that time (that
really ought to be the default IMO, but backward compatibility makes
that impossible).
* Adding --no-fork-point may have also sped up the timing for your
original report (not your follow-up), depending on what's in your
local reflog.
* There are almost certainly other optimization opportunities available her=
e.

More detailed investigation:

You did a few things that were quite a bit different between your
original report and your follow-up about reproducing.  So I'll try to
be clear about what I tried with your repository, but first let me
point out possible points of confusion:

1) In the original report, you clearly had merge.renamelimit set high
enough to detect renames, whereas in the second you didn't.  I can
control for this and show both with and without having a high enough
limit.
2) It appears in the first report that you were likely on a branch
when you ran rebase, whereas in the second you were clearly using a
detached HEAD (by first checking out a specific commit).  Since you
didn't use --no-fork-point, your local reflog would be consulted and
the history of changes to the branch might add to the overall
computation time.  That's something I won't be able to reproduce since
I don't have your reflog.
3) It's hard for me to shake that there might have been an automatic
gc or something else running on the system that occurred between the
first and second runs of your original report.  I obviously can't
reproduce anything like that.
4) The timing of the "git merge-base HEAD v5.10" command you ran was
almost certainly done AFTER the rebase, which gives misleading
results.  When I run the same command AFTER rebasing, I see similarly
really low timings:
$ time git merge-base HEAD v5.10
2c85ebc57b3e1817b6ce1a6b703928e113a90442

real 0m0.004s

Whereas BEFORE rebasing, I see significantly bigger times

$ time git merge-base HEAD v5.10
219d54332a09e8d8741c1e1982f5eae56099de85

real 0m1.750s

It would have been clearer to just use the command "time git
merge-base v5.10 origin/rebase-timing" (or whatever the original
un-rebased branch was instead of using HEAD).




Okay, with all that out of the way, I cloned your repo and ran a bunch
of timings.  I first ran:
    $ git config merge.renamelimit 9999
to make sure renames are detected.  I'll override it below when I
don't want renames detected.

With this config, on my machine, using git v2.32.0-rc1:
    53.908s  git rebase v5.10
    47.668s  git rebase --onto v5.10 v5.4

    18.574s  git -c merge.renamelimit=3D1000 rebase v5.10
    11.800s  git -c merge.renamelimit=3D1000 rebase --onto v5.10 v5.4

    16.610s  git rebase -sort v5.10
    10.780s  git rebase -sort --onto v5.10 v5.4

    10.670s  git rebase -sort --reapply-cherry-picks v5.10
    10.589s  git rebase -sort --reapply-cherry-picks --onto v5.10 v5.4

Using my development version of git (has a few more optimizations):
    16.073s  git rebase -sort v5.10
     9.778s  git rebase -sort --onto v5.10 v5.4

     9.541s  git rebase -sort --reapply-cherry-picks v5.10
     9.062s  git rebase -sort --reapply-cherry-picks --onto v5.10 v5.4

Using my development version + replacing can_fast_forward() with "return 0"=
:
     9.221s  git rebase -sort --reapply-cherry-picks v5.10
     8.124s  git rebase -sort --reapply-cherry-picks --onto v5.10 v5.4

Note the following timings too (git version doesn't really matter):
    6.495s  git switch --quiet --detach v5.10
    1.741s  git merge-base v5.10 origin/rebase-timing

So a theoretical lower bound is somewhere around 6.5s with --onto, and
8s without it, since these operations are just necessary.  fast-rebase
gets really close to that theoretical lower bound; it involves running
all three of the following commands (because it won't do the checkout
for you and needs a branch name):
    6.495s  git switch --quiet --detach v5.10
    0.005s  git branch -f rebase-timing origin/rebase-timing
    0.176s  test-tool fast-rebase --onto HEAD v5.4 rebase-timing
for a combined time of 6.676s.

Going back to the real rebase command, though (with my
still-not-upstream git version), using trace2 and summing across
common region names, I saw the following timings:

$ git switch --quiet --detach origin/rebase-timing && summarize-perf
git rebase -sort --reapply-cherry-picks v5.10
Successfully rebased and updated detached HEAD.
Accumulated times:
    2.104 : <unmeasured> (21.3%)
    6.628 : 7 : label:unpack_trees
       6.354 : <unmeasured> (95.9%)
       0.192 : 7 : ..label:traverse_trees
       0.082 : 1 : ..label:update
       0.000 : 1 : ..label:Filtering content
    0.515 : 4 : label:refresh
    0.380 : 6 : label:do_write_index
/home/newren/floss/uwe-linux/.git/index.lock
       0.375 : <unmeasured> (98.7%)
       0.005 : 6 : ..label:write
    0.103 : 4 : label:preload
    0.081 : 4 : label:checkout
       0.000 : <unmeasured> ( 0.2%)
       0.081 : 4 : ..label:unpack_trees
          0.014 : <unmeasured> (17.7%)
          0.065 : 4 : ....label:traverse_trees
          0.002 : 4 : ....label:update
          0.000 : 4 : ....label:Filtering content
    0.069 : 7 : label:do_read_index .git/index
       0.060 : <unmeasured> (88.0%)
       0.008 : 7 : ..label:read
    0.011 : 4 : label:incore_nonrecursive
       0.000 : <unmeasured> ( 2.8%)
       0.009 : 4 : ..label:process_entries
          0.000 : <unmeasured> ( 1.3%)
          0.008 : 4 : ....label:processing
          0.000 : 4 : ....label:process_entries setup
             0.000 : <unmeasured> (21.9%)
             0.000 : 4 : ......label:plist special sort
             0.000 : 4 : ......label:plist copy
             0.000 : 4 : ......label:plist grow
          0.000 : 4 : ....label:process_entries cleanup
       0.002 : 4 : ..label:collect_merge_info
          0.000 : <unmeasured> ( 6.5%)
          0.002 : 4 : ....label:traverse_trees
       0.000 : 4 : ..label:merge_start
          0.000 : <unmeasured> (54.4%)
          0.000 : 4 : ....label:allocate/init
          0.000 : 4 : ....label:sanity checks
       0.000 : 4 : ..label:renames
    0.000 : 4 : label:write_auto_merge
    0.000 : 4 : label:record_conflicted
Estimated measurement overhead (.010 ms/region-measure * 134): 0.00134
Timing including forking:  9.917 (0.026 additional seconds)

From this, the things that stood out to me were:
    2.104 : <unmeasured> (21.3%)

2.1 of the 9.9 seconds was in rebase somewhere without trace2 regions
to record it.  From above, clearly one big chunk of this time is from
can_fast_forward().  But that's only like 0.5-1.0s.  What's all the
rest?  And can we get rid of most of it somehow?

    6.628 : 7 : label:unpack_trees

This corresponds to the time to switch to v5.10 before starting to apply pa=
tches

    0.515 : 4 : label:refresh

I think this is wasted time trying to re-sync the data from the fact
that rebase shells out to external processes to do work it should do
in-process (namely, "git commit").

    0.380 : 6 : label:do_write_index
/home/newren/floss/uwe-linux/.git/index.lock
    0.081 : 4 : label:checkout
    0.069 : 7 : label:do_read_index .git/index

3/4 of this is wasted time from the fact that rebase updates the
working copy and index with every commit instead of just at the end of
the operation.  The "preload" marker may also belong here, or maybe up
with the preload.

    0.011 : 4 : label:incore_nonrecursive

It only took 11 milliseconds to do the actual merging and creating the
new blobs and trees -- and that includes the rename detection time.
