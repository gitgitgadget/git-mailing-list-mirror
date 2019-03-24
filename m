Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 30FD620248
	for <e@80x24.org>; Sun, 24 Mar 2019 01:22:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728235AbfCXBWX (ORCPT <rfc822;e@80x24.org>);
        Sat, 23 Mar 2019 21:22:23 -0400
Received: from mail-pf1-f193.google.com ([209.85.210.193]:36557 "EHLO
        mail-pf1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727635AbfCXBWW (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 23 Mar 2019 21:22:22 -0400
Received: by mail-pf1-f193.google.com with SMTP id p10so3981424pff.3
        for <git@vger.kernel.org>; Sat, 23 Mar 2019 18:22:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=SPe/0gmmkelPt2NPvDLUJeq+HETAR3FjaLYCyE4mpNE=;
        b=b82uLVSlcOyVBHK73T2fKp7n5TKt7YRXGpUBaekUhNUHnb9ypoGrgZ0ahXqFpPAjHc
         TwZyej9DH7QjpyEJZ7WPX1kncBW6okSpIhAyrkunwMwF9niTvzREs6wT7/W3kL7OLRyX
         Fo4AYNF8590LqxXWxNjVbKFQCGjERrLxsHvgDolwy+rW2M+CAMUWYZ1ZffR12KhN4CQ1
         L53+Tf2y7BFgJGQSQn2YccjYmUXM9SX6y0oSr3fkEr6lmK5GcTsohEEK5nR+5Q6/ZrL0
         C0LOLj7ZNMWvMYTf6pes13Q9VCJFzxDskyFOM9aHE6aaTb8NdOYAA8WLBT9w7ofDa+Zv
         A0Pw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=SPe/0gmmkelPt2NPvDLUJeq+HETAR3FjaLYCyE4mpNE=;
        b=FDE5rC+98IYeJwE3Sb3f0oZ45Or8Gmxo7/6R8NCnRmyyLCPWtJf0gcbUrp8MI8WyxE
         IY49nXtkmis/vJ/8GoaM0XQWBO0hYReP5jA2euwJpn/W4ytwTTZYrC596w9AplSRm/eF
         ssLKkv52dw02QCTD7ebZJjsaAFvk5Ax4vTk8hY56KuPmcRX93Gft8iwwEW0tYvAXJ/cg
         LuQ9uFVyKMe1xSsNdK4s/r0khzcWGwO4v7lbRLu93ynjiFCE1zC678a+Vmjz5OcZUUT+
         VrGfJp5qDBfBNurUJRRCnvSNFFTO0O6lH9v5D/J33X6uJuPrgyjq70epEqzisyRu3CPy
         nE6g==
X-Gm-Message-State: APjAAAXShjI50Vvw7uer2ZdaMwKxjAHwpvclHSRRFnrU8jQ2ALDF7SV2
        xArqw4XekjiQUUC1PcCaCVOAPfaNvRo=
X-Google-Smtp-Source: APXvYqxduxftmjTBlNciZ5S+k/3dIf08HeyFkoE9mXKSZzk84id0xxBKTcJamQtobKm1jclDbg+Bsw==
X-Received: by 2002:a63:fd07:: with SMTP id d7mr16255812pgh.199.1553390541796;
        Sat, 23 Mar 2019 18:22:21 -0700 (PDT)
Received: from ar135.iitr.ernet.in ([103.37.201.80])
        by smtp.gmail.com with ESMTPSA id g143sm8623885pfb.157.2019.03.23.18.22.17
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 23 Mar 2019 18:22:21 -0700 (PDT)
From:   Rohit Ashiwal <rohit.ashiwal265@gmail.com>
To:     christian.couder@gmail.com
Cc:     Johannes.Schindelin@gmx.de, artagnon@gmail.com,
        git@vger.kernel.org, newren@gmail.com, rohit.ashiwal265@gmail.com,
        s-beyer@gmx.net, t.gummerer@gmail.com, rafa.almas@gmail.com
Subject: Re: [GSoC][RFC] Proposal: Improve consistency of sequencer commands
Date:   Sun, 24 Mar 2019 06:51:30 +0530
Message-Id: <20190324012130.6762-1-rohit.ashiwal265@gmail.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <CAP8UFD22PMjQBsAf1GYphmtmt8x+sO=q=c_4bHDsS8L31Y_3AA@mail.gmail.com>
References: <CAP8UFD22PMjQBsAf1GYphmtmt8x+sO=q=c_4bHDsS8L31Y_3AA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Christian

On 2019-03-23 22:17 UTC Christian Couder <> wrote:
> On Fri, Mar 22, 2019 at 4:12 PM Rohit Ashiwal
> <rohit.ashiwal265@gmail.com> wrote:
> >
> > Hey People
> >
> > I am Rohit Ashiwal and here my first draft of the proposal for the project
> > titled: `Improve consistency of sequencer commands' this summer. I need your
> > feedback and more than that I need help to improve the timeline of this
> > proposal since it looks very weak. Basically, it lacks the "how" component
> > as I don't know much about the codebase in detail.
> >
> > Thanks
> > Rohit
> >
> > PS: Point one is missing in the timeline from the ideas page[0], can someone
> >     explain what exactly it wants?
> 
> You mean this point from the idea page:
> 
> "The suggestion to fix an interrupted rebase-i or cherry-pick due to a
> commit that became empty via git reset HEAD (in builtin/commit.c)
> instead of git rebase --skip or git cherry-pick --skip ranges from
> annoying to confusing. (Especially since other interrupted am’s and
> rebases both point to am/rebase –skip.). Note that git cherry-pick
> --skip is not yet implemented, so that would have to be added first."

Yes.

> or something else?
> 
> By the way it is not very clear if the proposal uses markdown or
> another related format and if it is also possible (and perhaps even
> better visually) to see it somewhere else (maybe on GitHub). If that's
> indeed possible, please provide a link. It is a good thing though to
> still also send it attached to an email, so that it can be easily
> reviewed and commented on by people who prefer email discussions.

This was intentional. Here is the link of the proposal hosted at gist.github.com[1],
those who prefer text only version here[2] is mailing list link.

> > List of Contributions at Git:
> > -----------------------------
> > Status: Merge in next revision
> 
> Maybe "Merged into the 'next' branch"
> 
> > git/git:
> > [Micro](3): Use helper functions in test script.
> 
> Please give more information than that, for example you could point to
> the commit in the next branch on GitHub and perhaps to the what's
> cooking email from Junio where it can be seen that the patch has been
> merged into next and what's its current status.

Current proposal has added links to those commits.

> > Status: Merged
> > git-for-windows/git:
> > [#2077](4): [FIX] git-archive error, gzip -cn : command not found.

This was released in v2.21.0 [3]

> > Status: Merged
> > git-for-windows/build-extra:
> > [#235](5): installer: Fix version of installer and installed file.
> 
> For Git for Windows contributions I think a link to the pull request
> is enough. It could be nice to know though if the commits are part of
> a released version.

> > The Project: `Improve consistency of sequencer commands'
> > ========================================================
> >
> > Overview
> > --------
> > git-sequencer was introduced by Stephan Beyer <s-beyer@gmx.net> as his
> > GSoC 2008 project[6]. It executed a sequence of git instructions to  <HEAD>
> > or <branch> and the sequence was given by a <file> or through stdin. The
> > git-sequencer wants to become the common backend for git-am, git-rebase
> > and other git commands. The project was continued by Ramkumar <artagnon@gmail.com>
> > in 2011[7], converting it to a builtin and extending its domain to git-cherry-pick.
> 
> Yeah, you can say that it was another GSoC project and maybe give his
> full name (Ramkumar Ramachandra).
> 
> There have been more related work to extend usage of the sequencer
> after these GSoC projects, at least from Dscho and maybe from Alban
> Gruin and Elijah too. I would be nice if you could document that a
> bit.
> 
> > As of now, there are still some inconsistencies among these commands, e.g.,
> > there is no `--skip` flag in `git-cherry-pick` while one exists for `git-rebase`.
> > This project aims to remove inconsistencies in how the command line options are
> > handled.
> 
> 
> > Points to work on:
> > ------------------
> >     - Add `git cherry-pick --skip`
> >     - Implement flags that am-based rebases support, but not interactive
> >           or merge based, in interactive/merge based rebases
> 
> Maybe the flags could be listed.
> 
> >     - [Bonus] Deprecate am-based rebases
> >     - [Bonus] Make a flag to allow rebase to rewrite commit messages that
> >           refer to older commits that were also rebased
> 
> This part of your proposal ("Points to work on") looks weak to me.
> 
> Please try to add more details about what you plan to do, how you
> would describe the new flags in the documentation, which *.c *.h and
> test files might be changed, etc.

I'll soon add details to the proposal, currently digging deep into the mailing list.

> > Proposed Timeline
> > -----------------
> >     + Community Bonding (May 6th - May 26th):
> >         - Introduction to community
> >         - Get familiar with the workflow
> >         - Study and understand the workflow and implementation of the project in detail
> >
> >     + Phase 1  (May 27th - June 23rd):
> >         - Start with implementing `git cherry-pick --skip`
> >         - Write new tests for the just introduced flag(s)
> >         - Analyse the requirements and differences of am-based and other rebases flags
> >
> >     + Phase 2  (June 24th - July 21st):
> >         - Introduce flags of am-based rebases to other kinds.
> >         - Add tests for the same.
> >
> >     + Phase 3  (July 22th - August 19th):
> >         - Act on [Bonus] features
> >         - Documentation
> >         - Clean up tasks
> >
> >
> > Relevant Work
> > =============
> > Dscho and I had a talk on how a non-am backend should implement `git rebase
> > --whitespace=fix`, which he warned may become a large project (as it turns
> > out it is a sub-task in one of the proposed ideas[0]), we were trying to
> > integrate this on git-for-windows first.
> > Keeping warning in mind, I discussed this project with Rafael and he suggested
> > (with a little bit uncertainty in mind) that I should work on implementing
> > a git-diff flag that generates a patch that when applied, will remove whitespace
> > errors which I am currently working on.
> 
> You mean Rafael Ascensão? Please CC him if he is involved in this.

Yes, I'll CC him.

Thanks
Rohit

[1]: https://gist.github.com/r1walz/5588d11065d5231ee451c0136400610e
[2]: https://public-inbox.org/git/20190322151157.9550-1-rohit.ashiwal265@gmail.com/
[3]: https://github.com/git-for-windows/git/releases/tag/v2.21.0.windows.1
