Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id C4C8C211B4
	for <e@80x24.org>; Sun, 13 Jan 2019 01:41:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726538AbfAMBlk (ORCPT <rfc822;e@80x24.org>);
        Sat, 12 Jan 2019 20:41:40 -0500
Received: from mail-qt1-f193.google.com ([209.85.160.193]:33516 "EHLO
        mail-qt1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726477AbfAMBlk (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 12 Jan 2019 20:41:40 -0500
Received: by mail-qt1-f193.google.com with SMTP id l11so23080852qtp.0
        for <git@vger.kernel.org>; Sat, 12 Jan 2019 17:41:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Hie8Z+w0t2pyJNibR7nvQaAraiZ6V8LpTxCpje1CKf4=;
        b=TuRsQVO9guzYiHGFrlZBhoaPwpLfMExeUKjMNHQnRkB8tjZGwzl2/ikP2vGKFLRIPA
         Xj1qZWdVO0TZ7ACBNSfc+HE6uuClM8Vx10ktAONaUvTitq9hi9C0iLSpQjZxVMDYQVjP
         7hi/MwVz728T16AiIu66lHmyySfCcrBVEiiryBQva3d+EOhHU5NL3V73ydUYiAapRDcx
         9EgFjIqZw//xHUAYebI8J/kF4ja86lh5WiF1YFxHiu5G5ZEgZXi2TPnWp3SRlgHxOLnw
         U5skXMTmFUwM44zGMQXzzhbw7gibcszX6WOK0neD4pSGYQ3zPDxjt4cjplcVaeNeGYtf
         gX8Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Hie8Z+w0t2pyJNibR7nvQaAraiZ6V8LpTxCpje1CKf4=;
        b=EO07qapm1SE4bB0aykiIVER72PyTBcXgL0mY+8abICjk1b/02ZXSAMjuEDBpnquFha
         XHvmwN24KpFPqu5JF03P+7pSPL2SBrn2UN3F4TtKecEdGvkc4nol9Y5QjIEYVSJoLHd3
         rcjprACTpbIOj7pTH0Pzx840WwOWMs344tmMB4Vj3vDUxSZtK7RZKRhTkCSp3FiKVg1k
         TEfzuO4UXGSYak2jYj/1OLZhs39Fs35aIHXqLsS5eVn5XlKzZkHhIavc6JWmxbhEhOga
         Z70VdE+ecbANY7DeZV8Qp4t5a1z2bMA+yK1poIF2OFeq7NJVlKYnQrQayslgGplrrRBv
         5ZQg==
X-Gm-Message-State: AJcUukfnw8V806J8q8SNpXvMedBdtU1UzPfFg7mFv0hZ2TcRN+Kx+lJF
        7Q4l/1ixWX5NcLp1HKkBExxyt+ZA9UiTpXK5rVw=
X-Google-Smtp-Source: ALg8bN46tIZTzv1gsa7Fy8UImzQUzOHpsKUXv2eszf8knAXLf7mx6GHYBtRUpILjJWGLEGCsW10zeo83PzdLVIsvavM=
X-Received: by 2002:ac8:13c5:: with SMTP id i5mr19338643qtj.365.1547343698512;
 Sat, 12 Jan 2019 17:41:38 -0800 (PST)
MIME-Version: 1.0
References: <20190106002619.54741-1-nbelakovski@gmail.com> <CAC05386q2iGoiJ_fRgwoOTF23exEN2D1+oh4VjajEvYQ58O1TQ@mail.gmail.com>
 <20190106002619.54741-3-nbelakovski@gmail.com> <xmqqzhsc8f32.fsf@gitster-ct.c.googlers.com>
 <e313d0b1-54b1-9fe2-6c75-d2ae7b57fe3a@iee.org>
In-Reply-To: <e313d0b1-54b1-9fe2-6c75-d2ae7b57fe3a@iee.org>
From:   Nickolai Belakovski <nbelakovski@gmail.com>
Date:   Sat, 12 Jan 2019 17:41:12 -0800
Message-ID: <CAC05384uh_xRboFhxohRq-vKFrTPDnszSaS3vW+BAv30h-Zd+g@mail.gmail.com>
Subject: Re: [PATCH v5 2/3] branch: Mark and color a branch differently if it
 is checked out in a linked worktree
To:     Philip Oakley <philipoakley@iee.org>
Cc:     Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org,
        Jeff King <peff@peff.net>,
        =?UTF-8?Q?Rafael_Ascens=C3=A3o?= <rafa.almas@gmail.com>,
        =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Jan 10, 2019 at 1:43 PM Philip Oakley <philipoakley@iee.org> wrote:
>
> On 07/01/2019 19:04, Junio C Hamano wrote:
> > I do not think it is warranted to paint the safety features as
> > "limitations".
>
> Is this not just a case of needing to clarify that this is 'safety'
> related to the _users_ mental model (or lack of) relative to the limited
> information that was previously given by the branch command's list.
>
> You are right that there is no data safety issue, but users make
> mistakes when they misunderstand the situation.

Not trying to paint anything one way or another. I found that these
features got in the way of my workflows and didn't see any immediate
reason why they had to exist. Thinking about it a bit more, is it
unreasonable to delete a branch even if it's checked out in a worktree
as long as the user uses git branch --delete --force or -D? This would
leave the worktree in a detached head state, but all the data would be
untouched. The output of deletion could mention that the branch had
been checked out in a worktree so that the user is fully informed.

Checking out the same branch in two worktrees should be technically
possible to implement safely, but I don't see a use case for having
the same branch checked out in multiple worktrees anyway. Why use
multiple worktrees at that point? If a user really wants the same
contents in two directories they can work around this
limitation/safety feature by just making another branch pointing at
the same commit. But anyway I'm just explaining why I chose the word
'limitation'.


> >    If you do want to remove that branch,
> > you need to go to that worktree that has a checkout of that branch,
> > check out a different branch there, and then remove it.  Again,
> > knowing where that other worktree is is the fist thing you need to
> > know.

This just seems silly to me when git branch --delete has a --force
option. But that's off topic.

> >
> >> The git worktree list command contains the relevant information, however
> >> this is a much less frquently used command than git branch.
> > It is not a good justification.  If the "relevant information" given
> > by the command is necessary one, the user can run that command.  If
> > the situation where that "relevant information" becomes necessary is
> > rare, the command is run much less frequently is not a problem---it
> > is expected.  And overloading a more frequently used command with
> > information that is less frequently wanted is actually not a great
> > design.
> But leaving the older command unaware of the newer developments and the
> user unwise as to its missing info is equally a poor situation.
> >
> > A more relevant justification may be that even though the
> > information can already be found in "worktree list" output, it would
> > give us flexibility in presentation to allow the custom format in
> > for-each-ref to show it.
> >
> > So, I am between moderately Meh to fairly negative on this step; Meh
> > in the sense that "thanks to the previous step, we _could_ do this,
> > it does not give incorrect information, and it makes the output more
> > cheerful, but it does not add that much useful and actionable piece
> > of information".

Allow me to add some color to my original commit message. The point of
this patch is so that the user is not surprised when they see the
message that this branch is checked out in another worktree when
trying to delete it or check it out, since they have presumably run
git branch recently and seen the formatted output indicating that a
branch they may want to delete/checkout is checked out in a worktree.
This was my frustration that prompted me to dive into this in the
first place - I'm cleaning up my branches and all of a sudden git
decides it doesn't want to let me delete one because it's checked out
somewhere else, even though I know I don't care about it because I
know the branch has already been merged upstream, or is old, or
whatever. I thought, if git branch output could at least let me know
that it's going to treat some branches differently, I can be proactive
about things and go to my worktree and delete the branch, or skip
trying to clean it up or not check it out.

I'll pursue the above-mentioned topic of allowing git branch -D to
allow the user to delete branches checked out in a worktree
separately, but even if that goes through, I think this patch would
still be useful in that it tells me that I can't check out the
branches that are colored in cyan.

Does that make more sense?
