Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.4 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	T_RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id E83DF1F404
	for <e@80x24.org>; Tue, 27 Mar 2018 22:18:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752334AbeC0WSL (ORCPT <rfc822;e@80x24.org>);
        Tue, 27 Mar 2018 18:18:11 -0400
Received: from mail-yb0-f175.google.com ([209.85.213.175]:39228 "EHLO
        mail-yb0-f175.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752232AbeC0WSJ (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 27 Mar 2018 18:18:09 -0400
Received: by mail-yb0-f175.google.com with SMTP id k8-v6so144997ybd.6
        for <git@vger.kernel.org>; Tue, 27 Mar 2018 15:18:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=BNzbX96DLyqTCGYgRvoHtY+/dDhMU0vqf3gkdssg5CE=;
        b=CZKMVFZLPpNglKIGimgLCA2cC2Fq2Y/DIrmowjgJXHlxI+YWCLAy0N/Wu3LRbgCGYb
         /jg7z7E0cT1hC+tKI6MPx94dmzIwJaAElQW+Ye6cvRTnCo3bKgbW/uMndtj9J7q3iL6I
         s6WV9jacu7bnJHcISkB/2JvRPuEgish91TMHtvC4KO3k80FiTUPWkz4cze2SRPeRyJfd
         fFPnWA2VOwNKZL7jbHWxSUGZKQ/ztFGVZ3/1E3so/VJ3s0ddt7EUwdYWgddun10eRqt2
         o2l6Qct42Tgu98eRWjqtkeHkoAuUHqm8M9j8hQDvlrA9ha7kyjqXyP/scb59r3vHrNmw
         AczQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=BNzbX96DLyqTCGYgRvoHtY+/dDhMU0vqf3gkdssg5CE=;
        b=tYsEFPx49qoyvpXgoHOzl/E3qtZarWv/W1IaNzDVlhkLAi+5qu5Xy5or7nmW9M6xBh
         GjMzKK/VmwblGASiCT9lxGquH7lPESWJTv+7cGeKiqrUFQOSVJdqqpQYF+lzXvrFB6WV
         flGE3ZZvw57jl0mCPaFz3yYZwnm7AnhyF2ZiXczRCGIF54I4osmcA4XUiw7VmnUglVUY
         BS5pXa5SifeNuDedQbyqtf4tD+oTd0zbVyr4ua2k5JJTNcpipUsX/1ELD+M/uqKy8lWM
         CQjmz/Nvx6MrRfyMrDrYPS3UVtgM5JsoLMeDNesU/xRcobVXa7jY0gCow7i8jJrvXF2W
         3Fhg==
X-Gm-Message-State: AElRT7Hr91RGb+jG+B01PHFjN9p07jcWnik/SwJW/ogTsFpF3C787kNb
        /n6rCu/3U99BW7ilsnCIRPlwLngNeK9W6WwIzoW1Sg==
X-Google-Smtp-Source: AIpwx4/R3zu8emWqkvvAavxIuNZOqPBMGuKsE5/twri3SXsOE5isHomfQECLU0dd6X6m1KNzLIcNQ63EOX7PkNz360A=
X-Received: by 2002:a25:493:: with SMTP id 141-v6mr801747ybe.247.1522189088071;
 Tue, 27 Mar 2018 15:18:08 -0700 (PDT)
MIME-Version: 1.0
References: <20180307211140.19272-1-rcdailey@gmail.com> <CAGZ79kZk7N4zQUS1eMFMPTuPPuo5ViOeLj5hQHV=E+A=OO+D0w@mail.gmail.com>
 <xmqqina56t8h.fsf@gitster-ct.c.googlers.com>
In-Reply-To: <xmqqina56t8h.fsf@gitster-ct.c.googlers.com>
From:   Stefan Beller <sbeller@google.com>
Date:   Tue, 27 Mar 2018 22:17:57 +0000
Message-ID: <CAGZ79kZ_j3_mhk5asNEBgBe_2qD7=18foJgW=p0+p=uJa3U2nw@mail.gmail.com>
Subject: Re: [PATCH] Support long format for log-based submodule diff
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Robert Dailey <rcdailey.lists@gmail.com>,
        git <git@vger.kernel.org>,
        Stefan Beller <stefanbeller@gmail.com>,
        Brandon Williams <bmwill@google.com>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

> >> $ git diff --submodule=log --submodule-log-detail=(long|short)
> >>
> >> I'm not sure what makes sense here. I welcome thoughts/discussion and
> >> will provide follow-up patches.
> >
> > The case of merges is usually configured with --[no-]merges, or
> > --min-parents=<n>.

> But that is a knob that controls an irrelevant aspect of the detail
> in the context of this discussion, isn't it?  This code is about "to
> what degree the things that happened between two submodule commits
> in an adjacent pair of commits in the superproject are summarized?"

And I took it a step further and wanted to give a general solution, which
allows giving any option that the diff machinery accepts to only apply
to the submodule diffing part of the current diff.

> The hack Robert illustrates below is to change it to stop favouring
> such projects with "clean" histories, and show "log --oneline
> --no-merges --left-right".  When presented that way, clean histories
> of topic-branch based projects will suffer by losing conciseness,
> but clean histories of totally linear projects will still be shown
> the same way, and messy history that sometimes merges, sometimes
> merges mergy histories, and sometimes directly builds on the trunk
> will be shown as an enumeration of individual commits in a flat way
> by ignoring merges and not restricting the traversal to the first
> parent chains, which would appear more uniform than what the current
> code shows.

Oh, I realize this is in the *summary* code path, I was thinking about the
show_submodule_inline_diff, which would benefit from more diff options.

> I do not see a point in introducing --min/max-parents as a knob to
> control how the history is summarized.

For a summary a flat list of commits may be fine, ignoring
(ideally non-evil) merges.

> This is a strongly related tangent, but I wonder if we can and/or
> want to share more code with the codepath that prepares the log
> message for a merge.  It summarizes what happened on the side branch
> since it forked from the history it is joining back to (I think it
> is merge.c::shortlog() that computes this)

I do not find code there. To me it looks like builtin/fmt-merge-msg.c
is responsible for coming up with a default merge message?
In that file there is a shortlog() function, which walks revisions
and puts together the subject lines of commits.

> and it is quite similar
> to what Robert wants to use for submodules here.  On the other hand,
> in a project _without_ submodule, if you are pulling history made by
> your lieutenant whose history is full of linear merges of topic
> branches to the mainline, it may not be a bad idea to allow
> fmt-merge-msg to alternatively show something similar to the "diff
> --submodule=log" gives us, i.e. summarize the history of the side
> branch being merged by just listing the commits on the first-parent
> chain.  So I sense some opportunity for cross pollination here.

The cross pollination that I sense is the desire in both cases to freely
specify the format as it may depend on the workflow.

Stefan
