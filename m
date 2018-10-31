Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 69EAF1F453
	for <e@80x24.org>; Wed, 31 Oct 2018 05:45:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728689AbeJaOmC (ORCPT <rfc822;e@80x24.org>);
        Wed, 31 Oct 2018 10:42:02 -0400
Received: from mail-ua1-f50.google.com ([209.85.222.50]:39615 "EHLO
        mail-ua1-f50.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728597AbeJaOmC (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 31 Oct 2018 10:42:02 -0400
Received: by mail-ua1-f50.google.com with SMTP id j38so5453568uae.6
        for <git@vger.kernel.org>; Tue, 30 Oct 2018 22:45:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=OD/u14PAanEGl09Xf+gKfGpYI3PYaCI9MBHaVYZ+6bo=;
        b=K4T2b27fSxf4WPsPEfMkWOp1+NNjnhJxdrevBSeUIMaJ080VtbUi8N06hvRWQbreb0
         +VcdH/76Ex0MjSSFuZLoVWj3AjvUwZ6bwlqnKqQmjTkt6l2CXmxvWOpzEGxartIkS5xA
         NJBkQQ9r1mImHYTY4mLaXL4ThkhG9pHDt0KW5A2dC6N9LTBEY7Tpn1Qq7bIjivHRIg7+
         Q1l/KiVjoMDiRWm55T8k0IVhdnMGriU0tvMQvLCBgqP+ADZYdIVa11REKa1+A3RtHpL+
         WPjxKaMnwLBLXpKnZc8elFlie9cnarq3gsLrAZ5GIWVQLHmhsp+gYTPumG6MbJpafHmT
         C8sw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=OD/u14PAanEGl09Xf+gKfGpYI3PYaCI9MBHaVYZ+6bo=;
        b=Htz01qLPTWlRrgZRqh0w7/RQzJaV1Dp3cKC3o4qnePMYuOzjZ22Q2G6su2fGtVdqr0
         tUuj77OuLYGgpx7ruDhv37EY8AgtKMQ24M4A7KLhuyoPwOAWyePuWwbdGg86hp9CKmuI
         kvVSLrxEgqEv9KwSsM2QKlE0EHbn1FDKXt9UvrO2J7Hl4z9upfXLx3yDRRZ69CjAuaRB
         OH7jD9FzDZHnNMgpwpYzGNPNff0rkFy3TNelk+jAdZ4rEkTbcxgfsO368H2Jh5bTgYJz
         5knfgeC5P6/i3NfM/aGuDI+gpL9TO+Tu1tZcarbxoZixufe7wxwKRROhb/A5hmfiE6WD
         RlSw==
X-Gm-Message-State: AGRZ1gKFg5N8adJxkE7DcV6PT2VnnwbVjZgJF+GLlXDdBoHHVW55yLvT
        py8Dzk7Gc63T9VBPp3fIUGDADSTzTylOYg9U4zE=
X-Google-Smtp-Source: AJdET5fL4Y86snGrWsMfogC6c8q5JLB2agbwsV/2Q6ev8KkSJDmXMHlVNw1nPjlpvdEW1UcWgRzYaIGYGFrnl9UlAXU=
X-Received: by 2002:ab0:13ee:: with SMTP id n43mr783693uae.20.1540964725414;
 Tue, 30 Oct 2018 22:45:25 -0700 (PDT)
MIME-Version: 1.0
References: <CABPp-BECpSOxudovjbDG_3W9wus102RW+E+qPmd4g3Qyd-QDKQ@mail.gmail.com>
 <302a9351-6133-f562-8c5a-d688d5cc3c88@gmail.com>
In-Reply-To: <302a9351-6133-f562-8c5a-d688d5cc3c88@gmail.com>
From:   Elijah Newren <newren@gmail.com>
Date:   Tue, 30 Oct 2018 22:45:13 -0700
Message-ID: <CABPp-BHPZD2zRkrbAFOEp4KAT+fAvO4KzFrCsk_Pyy5V65t=ig@mail.gmail.com>
Subject: Re: commit-graph is cool (overcoming add_missing_tags() perf issues)
To:     Derrick Stolee <stolee@gmail.com>
Cc:     Derrick Stolee <dstolee@microsoft.com>,
        Git Mailing List <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Oct 30, 2018 at 7:22 AM Derrick Stolee <stolee@gmail.com> wrote:
>
> On 10/17/2018 2:00 PM, Elijah Newren wrote:
> > Hi,
> >
> > Just wanted to give a shout-out for the commit-graph work and how
> > impressive it is.  I had an internal report from a user that git
> > pushes containing only one new tiny commit were taking over a minute
> > (in a moderate size repo with good network connectivity). After
> > digging for a while, I noticed three unusual things about the repo[1]:
> >    * he had push.followTags set to true
> >    * upstream repo had about 20k tags (despite only 55k commits)
> >    * his repo had an additional 2.5k tags, but none of these were in
> >      the history of the branches he was pushing and thus would not be
> >      included in any pushes.
> >
> > Digging in, almost all the time was CPU-bound and spent in
> > add_missing_tags()[2].  If I'm reading the code correctly, it appears
> > that function loops over each tag, calling in_merge_bases_many() once
> > per tag.  Thus, for his case, we were potentially walking all of
> > history of the main branch 2.5k times.  That seemed rather suboptimal.
>
> Elijah,
>
> Do you still have this repo around? Could you by chance test the
> performance with the new algorithm for add_missing_tags() in [1]?
> Specifically, please test it without a commit-graph file, since your
> data shape already makes use of generation numbers pretty well.
>
> Thanks,
> -Stolee

I nuked it, but turns out I had a backup that I found after digging
around for a bit.  I'll post a comment on the series with the results.

By the way, I've been running pu for about a week with this tweak:

diff --git a/revision.c b/revision.c
index b5108b75ab..d20c687e71 100644
--- a/revision.c
+++ b/revision.c
@@ -1457,6 +1457,7 @@ void repo_init_revisions(struct repository *r,
        revs->pruning.change = file_change;
        revs->pruning.change_fn_data = revs;
        revs->sort_order = REV_SORT_IN_GRAPH_ORDER;
+       revs->topo_order = 1;
        revs->dense = 1;
        revs->prefix = prefix;
        revs->max_age = -1;

Only ran into one small problem once, and it wasn't commit-graph
related; rather it was related to my above patch and needing to not
have topo_order be set.  (I just bailed and used my older
system-installed git from /usr/bin/ in that one case.)  So, I think
the commit-graph stuff is looking pretty good, and I find the recent
thread on further improvements with corrected commit date (among other
possibilities) very intriguing...even if I haven't had much time to
comment or test recently.
