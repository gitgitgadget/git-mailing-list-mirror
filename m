Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.8 required=3.0 tests=AWL,BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 156F51F803
	for <e@80x24.org>; Mon,  7 Jan 2019 19:04:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727058AbfAGTEF (ORCPT <rfc822;e@80x24.org>);
        Mon, 7 Jan 2019 14:04:05 -0500
Received: from mail-wr1-f68.google.com ([209.85.221.68]:41239 "EHLO
        mail-wr1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726879AbfAGTEF (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 7 Jan 2019 14:04:05 -0500
Received: by mail-wr1-f68.google.com with SMTP id x10so1560940wrs.8
        for <git@vger.kernel.org>; Mon, 07 Jan 2019 11:04:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version;
        bh=L7AEW/El/k3NHnSAzs4WCTCVkAx69zPO7Rc2g5CY9Nc=;
        b=Wxlw6/8Tc4J5TYWIOWOTQPp/hEynAp7WSQqXK8Nxvhz5lPXQ2Eo3o6HkytGsIBQOPy
         SsDa7cl1LKrNxl/K5bKgA+LqWTbgh3/w0YDzqHC3NKiwIz8F6oakRIgaFg6E3OJ3Z6FQ
         Cl0fcX9r7v+vb1aKC1uFN8F7c8xcV8Sk8390VBkBEph0JuFHU576IxZnqodIgK29A7+z
         429LU8Eg1/cCG5oTVx5lYxP72U1g/h8e4SjSPbof5x+43Szf88XOvczkQBufjsRhXmZI
         mt1ludWevem5zIYJeyMX3JId9nHLE4c0MJwpi1mhMoidXsSsVpo3FuYH1dG8/5fN7bCv
         QF4Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version;
        bh=L7AEW/El/k3NHnSAzs4WCTCVkAx69zPO7Rc2g5CY9Nc=;
        b=BPN8CZS91/Nmi4ggu6NON6iPW0mrWAGEX2NMGsHa8Fg8jxX7ulDwbnvGn/sAWHjen9
         Z/woW2qTJ7ysaK8/iP43QcjM1/ggAeWa0cluXyI8oDFe9WdfZGkJxkyNW9MXKd66OJLN
         WyrMFvV08FnVspt5DQoHCCEcUph77WUxTyt4edJpIRNT2TrkEzCYGQ+r/tY5FOidE1QU
         pgkyrYOoTP5+Ywtfz2+gYvUiXoHMje3GXTKtGnfZhRYyfYY0qwsBf+DwjOIhE8MM9spX
         f0Nmx1/wus47IfR5nz6XKmuMYUfs4QjTfyR8uQWal9LZkFaA/+Wvn6Ez3D8TjGifKsnu
         jRBw==
X-Gm-Message-State: AJcUukfFW3WDReBcObZdGqxDaQ5d6BV5y2h4nIcEuJ3fwuXKYZTsMcEn
        ckDw5X1LF0X6IMEFFyam3bI=
X-Google-Smtp-Source: ALg8bN7XF5tHP/z/f9Rr3+dawgYjDCgmL/Jna3wXXc7XZJ3ivWLIAP7lgAHVmC96mVlLG09AscojUQ==
X-Received: by 2002:a5d:46cd:: with SMTP id g13mr54676212wrs.49.1546887842621;
        Mon, 07 Jan 2019 11:04:02 -0800 (PST)
Received: from localhost (168.50.187.35.bc.googleusercontent.com. [35.187.50.168])
        by smtp.gmail.com with ESMTPSA id f137sm7707964wmg.29.2019.01.07.11.04.01
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 07 Jan 2019 11:04:01 -0800 (PST)
From:   Junio C Hamano <gitster@pobox.com>
To:     nbelakovski@gmail.com
Cc:     git@vger.kernel.org, peff@peff.net, rafa.almas@gmail.com,
        avarab@gmail.com
Subject: Re: [PATCH v5 2/3] branch: Mark and color a branch differently if it is checked out in a linked worktree
References: <CAC05386q2iGoiJ_fRgwoOTF23exEN2D1+oh4VjajEvYQ58O1TQ@mail.gmail.com>
        <20190106002619.54741-1-nbelakovski@gmail.com>
        <CAC05386q2iGoiJ_fRgwoOTF23exEN2D1+oh4VjajEvYQ58O1TQ@mail.gmail.com>
        <20190106002619.54741-3-nbelakovski@gmail.com>
Date:   Mon, 07 Jan 2019 11:04:01 -0800
In-Reply-To: <20190106002619.54741-3-nbelakovski@gmail.com> (nbelakovski's
        message of "Sat, 5 Jan 2019 16:26:18 -0800")
Message-ID: <xmqqzhsc8f32.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

nbelakovski@gmail.com writes:

> From: Nickolai Belakovski <nbelakovski@gmail.com>
>
> In order to more clearly display which branches are active, the output
> of git branch is modified to mark branches checkout out in a linked
> worktree with a "+" and color them in cyan (in contrast to the current
> branch, which will still be denoted with a "*" and colored in green)
>
> This is meant to simplify workflows related to worktree, particularly
> due to the limitations of not being able to check out the same branch in
> two worktrees and the inability to delete a branch checked out in a
> worktree. When performing branch operations like checkout and delete, it
> would be useful to know more readily if the branches in which the user
> is interested are already checked out in a worktree.

I do not think it is warranted to paint the safety features as
"limitations".

A branch that is checked out in another worktree cannot be checked
out to be worked on, as that will make the checkout of the other
worktree out of sync.  If you want to work on that branch, you can
either (1) go to that worktree that has a checkout of that branch
and work there, or (2) go to that worktree that has a checkout of
that branch, check out a different branch there, come back to the
worktree you want to work in and check out that branch.  Knowing
where that other worktree is is the first step in either case.

And a branch that is checked out in a worktree cannot be removed, as
it is a sign that it is still being worked on for a branch to have
been checked out somewhere.  If you do want to remove that branch,
you need to go to that worktree that has a checkout of that branch,
check out a different branch there, and then remove it.  Again,
knowing where that other worktree is is the fist thing you need to
know.

But then I am not sure if the feature being added by these patches
is a good match for that justification.

For one thing, it would be more direct and helpful way for

	git checkout one-branch
	git branch -d one-branch

to say "The branch `one-branch` is checked out in a worktree at
$DIRECTORY" when they refused to go ahead.  And that would eliminate
the need for this new feature to help these two use cases.

In fact, these two command already behave that way, so the paragraph
I just commented on is not a good justification for this new feature
at all.

Besides, showing "That branch is checked out somewhere" would not
help user to decide "ah, if I want to work on that branch, I need to
chdir to that directory" with the patch in question, as it only
shows "It is checked out _somewhere_" without saying where.

> The git worktree list command contains the relevant information, however
> this is a much less frquently used command than git branch.

It is not a good justification.  If the "relevant information" given
by the command is necessary one, the user can run that command.  If
the situation where that "relevant information" becomes necessary is
rare, the command is run much less frequently is not a problem---it
is expected.  And overloading a more frequently used command with
information that is less frequently wanted is actually not a great
design.

A more relevant justification may be that even though the
information can already be found in "worktree list" output, it would
give us flexibility in presentation to allow the custom format in
for-each-ref to show it.

So, I am between moderately Meh to fairly negative on this step; Meh
in the sense that "thanks to the previous step, we _could_ do this,
it does not give incorrect information, and it makes the output more
cheerful, but it does not add that much useful and actionable piece
of information".
