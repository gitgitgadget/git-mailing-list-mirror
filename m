Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 48A6120248
	for <e@80x24.org>; Sat, 30 Mar 2019 07:16:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726415AbfC3HQZ (ORCPT <rfc822;e@80x24.org>);
        Sat, 30 Mar 2019 03:16:25 -0400
Received: from mail-ed1-f66.google.com ([209.85.208.66]:35433 "EHLO
        mail-ed1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726378AbfC3HQZ (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 30 Mar 2019 03:16:25 -0400
Received: by mail-ed1-f66.google.com with SMTP id s39so3916224edb.2
        for <git@vger.kernel.org>; Sat, 30 Mar 2019 00:16:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=dX2v2WIE6m885w0c7goZeP0UIaVsTdBt+gNfesw4Og4=;
        b=HXSQFdR7V3esa+2HwEhYPHKqBI2/VLBEnXzRlimb4mxND4X1rYnq2Z8eIse0FeuEXK
         nvmCOiWUnciJ8gyYMnmAJXt5YvVKYD//NWOL/TtmUar1BqL42KHqU5JAcHWpIwuczH/S
         qyQr+AkGY/9oJdmeGFveBqEvOn1YCGACjYOTsvC94OHvsFLhEKdhEoTu2J1z6XTSqeCG
         srEeA4c3Q32KZV645bDvPaan4MfX5SRoz9lz2upJ8OsdtJYPjnL4Ze9MCvzOfjuxBPh5
         mCDFhSzinV/Ie1fmxDG2ql77JdQWqi3xv/4L/i+yZY5POiThF4XIg194F3a8oH9h3SN9
         yWsQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=dX2v2WIE6m885w0c7goZeP0UIaVsTdBt+gNfesw4Og4=;
        b=a8M6FJiasLGRia2NnR11rrYasuYzslsjBILms1TW999KBTmiWvLZU2V+Zrss/N6Wr4
         iehddv2Rr3Lqo1VNUV/BvfzQY6+XHsiFfVc0nnUXO512gMoIJ3wvBlPP3FUj86OTuCyE
         EhI02tmoOVNviZt19JFXPxGHzZ61pFOj3LZL+pSS5JZjy9t7aVer3Cn5RXGKfimL/oAq
         IT5yxJG6jqDoeWZNjZmrEAIXsSIMdGKs4YrGOerA1fZ5mzS6QgOiYmqYdizmuktGdGH1
         Aj6QidELb4fWPvmGkjU2ROY6bSzIDlnYsOfbztWNpjnxcCg1+TUEG55SaQdgez+D8jnz
         c5Yg==
X-Gm-Message-State: APjAAAVsNmVgFrFXsF6z3eoxrt+lkR+BVcHXizvmGWc/yzPpx+wlgCFs
        kuzvbkaajDAePUAUjmiytuDr2LrEKypWA2tiBXg=
X-Google-Smtp-Source: APXvYqxa7WUVOF0ICpTSp1NpkKSPm77MA4l2lVuSxsq63pjjEptVihSWf/k9uzJovBdjhWLQN4pwic/pBSYfMmr/chU=
X-Received: by 2002:aa7:ce0d:: with SMTP id d13mr35361474edv.292.1553930182879;
 Sat, 30 Mar 2019 00:16:22 -0700 (PDT)
MIME-Version: 1.0
References: <CAL7ArXqkVfrnQWYFDYdwMGkZjHCwzyQX4pbKCo=KCzy-zJiRBw@mail.gmail.com>
 <20190329223228.4924-1-rohit.ashiwal265@gmail.com>
In-Reply-To: <20190329223228.4924-1-rohit.ashiwal265@gmail.com>
From:   Christian Couder <christian.couder@gmail.com>
Date:   Sat, 30 Mar 2019 08:16:10 +0100
Message-ID: <CAP8UFD3b8wxj=T+HpeFAQNGLghs8fpEvQusP7Wq-BRZb3c50dg@mail.gmail.com>
Subject: Re: [GSoC][RFC v2] Improve consistency of sequencer commands
To:     Rohit Ashiwal <rohit.ashiwal265@gmail.com>
Cc:     Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Ramkumar Ramachandra <artagnon@gmail.com>,
        git <git@vger.kernel.org>, Elijah Newren <newren@gmail.com>,
        Stephan Beyer <s-beyer@gmx.net>,
        Thomas Gummerer <t.gummerer@gmail.com>,
        Alban Gruin <alban.gruin@gmail.com>, rafa.almas@gmail.com
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Rohit,

On Fri, Mar 29, 2019 at 11:33 PM Rohit Ashiwal
<rohit.ashiwal265@gmail.com> wrote:
>
> This is the v2 of the draft proposal[1]. I've added some details to the proposal,
> it talks more about what to implement instead of how. It is still incomplete.
>
> I'm currently adding more to the overview section, where I'll document the work
> done by Dscho and Alban. After that I'll find files that will be changed while
> implementing rest of the flags, finally add the basic control and/or data flow
> of the 'how' part.

The plan to improve it looks good to me.

> ### List of Contributions at Git:
>
> Repo                              |        Status           |                   Title
> -|-|-
> [git/git][8]                      | Merged in 'next' branch | [Micro][3]**:** Use helper functions in test script

It would be nice to have a link to the last "What's cooking in
git.git" email from Junio so we can easily see the current status of
your patch/patch series.

> [git-for-windows/git][9]          | Merged and released     | [#2077][4]**:** [FIX] git-archive error, gzip -cn : command not found.
> [git-for-windows/build-extra][10] | Merged                  | [#235][5]**:** installer: Fix version of installer and installed file.
>
>
> ## The Project
>
> ### _Improve consistency of sequencer commands_
>
> #### Overview
>
> Stephan Beyer \<s-beyer@gmx.net> tried to introduce git-sequencer as his GSoC
> 2008 [project][6] which executed a sequence of git instructions to  \<HEAD> or
> \<branch> and the sequence was given by a \<file> or through `stdin`. The
> git-sequencer wants to become the common backend for git-am, git-rebase and
> other git commands. Unfortunately, most of the code did not get merged during
> the SoC period but he continued his contributions to the project along with
> Christian Couder \<chriscool@tuxfamily.org> and then mentor Daniel Barkalow
> \<barkalow@iabervon.org>.
>
> The project was continued by Ramkumar Ramachandra \<artagnon@gmail.com> in
> [2011][7], converting it to a builtin and extending its domain to
> git-cherry-pick.

I don't think the sequencer has been converted into a builtin. I am
not sure why Ram wrote that he would do that in his proposal as I
don't think it was really a goal we had.

By the way, you might want to read the sequencer related article in
https://git.github.io/rev_news/2016/10/19/edition-20/ for things that
Dscho did.

> The learnings from all those works will serve as a huge headstart this year for
> me.
>
> As of now, there are still some inconsistencies among these commands, e.g.,
> there is no `--skip` flag in `git-cherry-pick` while one exists for
> `git-rebase`. This project aims to remove inconsistencies in how the command
> line options are handled.

[...]

> 5. `[Bonus]` As familiarity with the code increases, I might be able to implement
> the feature of rewriting commits in time.

I had to go back to the "Points to work on" section to understand what
this was about. Please describe what this is about in a clearer way.

> 6. `[Bonus]` If everything goes well and time permits, discuss with the mentor(s)
> the possibility of deprecating the am backend of rebase. This point is last to
> work on as it provides no "cosmetic" difference on the user side. Elijah
> [mentioned][12] the possibility of a "social" problem that might occur which shall
> be discussed then.

Maybe it would be interesting to see if there is a performance
difference between the 2 backends.

[...]

> #### Relevant Work
>
> Dscho and I had a talk on how a non-am backend should implement `git rebase
> --whitespace=fix`, which he warned may become a large project (as it turns out
> it is a sub-task in one of the [proposed ideas][11]), we were trying to
> integrate this on git-for-windows first.
>
> Keeping warning in mind, I discussed this project with Rafael and he suggested
> (with a little bit uncertainty in mind) that I should work on implementing a
> git-diff flag that generates a patch that when applied, will remove whitespace
> errors which I am currently working on.

Nice!
