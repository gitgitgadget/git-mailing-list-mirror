Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 04DF11F461
	for <e@80x24.org>; Wed, 15 May 2019 20:34:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727087AbfEOUeL (ORCPT <rfc822;e@80x24.org>);
        Wed, 15 May 2019 16:34:11 -0400
Received: from mail-vs1-f50.google.com ([209.85.217.50]:41095 "EHLO
        mail-vs1-f50.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726465AbfEOUeL (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 15 May 2019 16:34:11 -0400
Received: by mail-vs1-f50.google.com with SMTP id g187so809804vsc.8
        for <git@vger.kernel.org>; Wed, 15 May 2019 13:34:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=65PT3Fbq10RxlOsOfHY0yRdrOZ72zdhjz8YSMfXmSlw=;
        b=MWD0NWBPmxujsy4VJhALd3X9LOK/88HrP0E0148hufsnpjJJKZ0oh0xHN0cNhd6xpV
         9KwAnYHUnAqyvQ7jBmwIvuMpp6j0fbDYK/2NJxtUAbvjSTL/fcUIFPgU5N+nyL1Tso8I
         ApbcXIxrOsIHkX9o7BF4j4qdwQxSkyR+8Z4d2M0yL5652tT1huIbZcpv24mSnZyHeJ7X
         tSkv+FfHwKcwl1JgxioMDX2ew1hywWrHcb9pbzhQZWnhHoldevDgH3NXCf21C9qhrk+N
         2bqfUfU4zv63C8zjWqPDrN4eW6UCvWt7bVKZ6tQ1zhHHY+brfYJGAm0iAIC126fXX/ar
         2yDg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=65PT3Fbq10RxlOsOfHY0yRdrOZ72zdhjz8YSMfXmSlw=;
        b=ebjINAGSg8zh47bVMWwQoRkBmVbSJMgNqEmMxN7G/OqQm/iLroXOz7x43wR4h8s3y2
         +TRR7rBMOTCGuHUm3z8oTd4YjUCcA8dRuvZAVXO6BhEEbMDkHkiSThwUxnwItzuqzAGr
         r89jWqvi4YofMgE6mBekO0+4RnqMXyRgHAhhFEj/zdaY7ofG6BcZ85Y470to0Xo3tNpK
         Hg7iUe6dVn/wVJCA+3heamia3iMDq9OC3Bv/J0N+ynd6aN5ZdTdr5ynrmxgOiI2N1OaB
         fm+xDamMveS6lmuOMCCTPi/nI1v66aEUfluaAqKBB0Tb+iSvokqQFDLWJG0wxtMCUMAa
         qHUQ==
X-Gm-Message-State: APjAAAVwQ0BxyMs70TzRA1ie26YwB9VOgRj9xwlnjxKOMe3RBFcxfrkm
        0M8oy9CVIBO0rO3PJJBzf4gXLEKI+AZ6pSJili06qqQd4ts=
X-Google-Smtp-Source: APXvYqw3xiW9PPeQeMUIsu8HxpzXtpz48COtP0BcR0Tw97Jt2hEQOkSHK6n/iOa0M6ANrSiE+lQimh+Gud5Hptl+rTk=
X-Received: by 2002:a05:6102:1c7:: with SMTP id s7mr7032386vsq.136.1557952450140;
 Wed, 15 May 2019 13:34:10 -0700 (PDT)
MIME-Version: 1.0
References: <CAA01CsoJf+_-iowdm0EFWd52vOWE1Uo0GGZ55d3RyPJzg6gwgQ@mail.gmail.com>
 <874l5vwxhw.fsf@evledraar.gmail.com>
In-Reply-To: <874l5vwxhw.fsf@evledraar.gmail.com>
From:   Elijah Newren <newren@gmail.com>
Date:   Wed, 15 May 2019 13:33:57 -0700
Message-ID: <CABPp-BGycoHEMN27Z9rAccT5yVRf3N50o4sc3wo8uE_HLR9QbA@mail.gmail.com>
Subject: Re: Merging (joining/stiching/rewriting) history of "unrelated" git repositories
To:     =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>
Cc:     Piotr Krukowiecki <piotr.krukowiecki@gmail.com>,
        Git Mailing List <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, May 15, 2019 at 8:30 AM =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason
<avarab@gmail.com> wrote:
>
> On Wed, May 15 2019, Piotr Krukowiecki wrote:
>
> > Hello,
> >
> > I'm migrating two repositories from svn. I already did svn->git
> > migration (git-svn clone) and now have two git repositories.
> >
> > I would like to merge them into 1 git repository, but to merge also
> > history - branches and tags.
> >
> > The reason is that the svn repositories in fact represent one
> > "project" - you had to download both of then, they are not useful
> > separately. Tags were applied to both repositories, also list of
> > branches is almost identical for both.
> >
> > So right now I have:
> >
> >     - projectA:
> >        master: r1, r4, r5, r7
> >        branch1: r10, r11, r13
> >     - projectB:
> >        master: r2, r3, r6
> >        branch1: r12, r14
> >
> > The content of projectA and projectB is different (let's say projectA
> > is in subfolder A and projectB is in subfolder B). So revisions on
> > projectA branches have only A folder, and revisions on projectB
> > branches have only B folder.
> >
> > But I would like to have:
> >
> >     - projectAB:
> >        master: r1', r2', r3', r4', r5', r6', r7'
> >        branch1: r10', r11', r12', r13', r14'
> >
> > Where all revisions have content from both projects. For example, the
> > r5' should have the "A" folder content the same as r5, but also should
> > have "B" folder content the same as in r3 (because r3 was the last
> > commit to projectB (date-wise) before commit r5 to projectA).
> >
> > There's additional difficulty of handling merges...
> >
> >>
> > Any suggestions on what's the best way to do it?
> >
> >
> > Currently I'm testing join-git-repos.py script
> > (https://github.com/mbitsnbites/git-tools/blob/master/join-git-repos.py=
)
> > but it's slow, memory inefficient and handles "master" branch only...
> >
> >
> > Thanks,
>
> You might be able to use https://github.com/newren/git-filter-repo

Splicing repos is an interesting case, but unless the history is
linear and the branch/tag names exactly match and you are simplify
weaving commits together based on timestamp within the same
branch/tag, then I don't know what algorithm should be used to weave
them together.  There are lots of choices, and "correct" may be very
usecase-specific.

That said, filter-repo was designed to be usable as a library and has
a few simple examples of such usage, including one of splicing some
trivial repos together.  (See
https://github.com/newren/git-filter-repo/blob/master/t/t9391/splice_repos.=
py
and https://github.com/newren/git-filter-repo/blob/master/t/t9391-filter-re=
po-lib-usage.sh#L90-L121)
 As noted there, fast-export's diff against first parent handling
makes splicing commits into the second (or third) parent history of a
merge problematic as new files introduced in such locations would by
default appear to get deleted by the merge unless additional work is
done to also insert the files there.  My example was meant as a simple
testcase that should be easy to inspect by others, so it just worked
with very short linear histories.

Somewhat interestingly, a search on others having tried to solve this
same problem turned up
https://github.com/j5int/jbosstools-gitmigration, which apparently is
based on git_fast_filter, which is the predecessor of filter-repo.
Perhaps that tool would be useful to you as-is, though they apparently
do ignore merges.

If folks have a good idea for a weaving algorithm that appears
generally useful rather than usecase-specific, then I may be
interested in coding it up as a more general example of using
filter-repo as a library.  But every time I've thought about it before
it just sounded too hairy and too usecase specific so I've just punted
on it.

> But I'd say try something even more stupid first:
