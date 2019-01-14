Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.8 required=3.0 tests=AWL,BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 05023211B4
	for <e@80x24.org>; Mon, 14 Jan 2019 18:18:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726753AbfANSS0 (ORCPT <rfc822;e@80x24.org>);
        Mon, 14 Jan 2019 13:18:26 -0500
Received: from mail-wr1-f66.google.com ([209.85.221.66]:39564 "EHLO
        mail-wr1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726744AbfANSSZ (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 14 Jan 2019 13:18:25 -0500
Received: by mail-wr1-f66.google.com with SMTP id t27so24048976wra.6
        for <git@vger.kernel.org>; Mon, 14 Jan 2019 10:18:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version;
        bh=Sisn3urKGZ9Zl0nRCwrQgBXO68yuAKFZEZjOOOq0kxQ=;
        b=lI6ITcN/dhI+oug62Cg3Knxju8Zu9FMwLjYlaAiynZnSJNBKOXFJuzIWIWtOHXU/LK
         04sPsqflPCdnG5j1dw/O/tfBGRZ5o4eOVWYJf0S2m/kppKdcJzH90K35kmeNpjQ9k0ov
         HsZqKxL+/c0YAshJCFmhDQ1+H2XCQGKeeQzQiRyWgiERa9S0fkSmJb4jWSkjszSrwchh
         zOAZVyrKt11vgmJ3DDk4iab6l3gE19N/BzsSWIhIuSIPNKCgwmuvcfD5YEY5JGunzEoc
         igrkj+EC7lwLxm6Bgjh/zoknbEqI3hhvAUeifgFXd3fmBy5XLIPYuKFOnYFwvEOzQmXb
         Nk+g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version;
        bh=Sisn3urKGZ9Zl0nRCwrQgBXO68yuAKFZEZjOOOq0kxQ=;
        b=EN82qMag0Xuohgx7qaSNOgatYoXYFYXZj6Oo+ZZvmPHWc+8TinfEqcxmxu6zTnoebm
         BQNDLularGAJpaYWiSE8BJ2+a113DhgSZqopCI47+ydtBtwyp6y0fm1pvzwrVwQHGepX
         ehq5vpXY+au+/ddTNDB2zV3zKMsmfArdzu7xf8jTBbk4DgwjhSpumTCHEyaxYz3rEemf
         AGj86UPyOBr2QcWvoLqtkQt9yU2xlwNsjUaOtlQ2b+u8Hq/n3nhnTljhzZRQ2XP6T+c6
         Fm9Atyea0/0pnhKY2ZSvHTR65i4VXQqaRQxoF9H+VXQ3jAEdAktv/mub/hW5K2wLU+pI
         l6FQ==
X-Gm-Message-State: AJcUukfp3HAMSejir8wwSW4SqW9wkDC9WFpU+nLset6iAnrX0kAeocsB
        9d2bvhCewRqfF0Bg3uFvwXs=
X-Google-Smtp-Source: ALg8bN7MLOoAlCK+AIH/bvZykbQmMBFgqcZT/3wQdUVudt5vfpRkWiH2M+XgYt7MBcPPR7DC9820Pg==
X-Received: by 2002:a5d:4a8e:: with SMTP id o14mr24274768wrq.159.1547489903481;
        Mon, 14 Jan 2019 10:18:23 -0800 (PST)
Received: from localhost (168.50.187.35.bc.googleusercontent.com. [35.187.50.168])
        by smtp.gmail.com with ESMTPSA id i192sm30525095wmg.7.2019.01.14.10.18.21
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 14 Jan 2019 10:18:22 -0800 (PST)
From:   Junio C Hamano <gitster@pobox.com>
To:     Nickolai Belakovski <nbelakovski@gmail.com>
Cc:     Philip Oakley <philipoakley@iee.org>, git@vger.kernel.org,
        Jeff King <peff@peff.net>,
        Rafael =?utf-8?Q?Ascens=C3=A3o?= <rafa.almas@gmail.com>,
        =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
Subject: Re: [PATCH v5 2/3] branch: Mark and color a branch differently if it is checked out in a linked worktree
References: <20190106002619.54741-1-nbelakovski@gmail.com>
        <CAC05386q2iGoiJ_fRgwoOTF23exEN2D1+oh4VjajEvYQ58O1TQ@mail.gmail.com>
        <20190106002619.54741-3-nbelakovski@gmail.com>
        <xmqqzhsc8f32.fsf@gitster-ct.c.googlers.com>
        <e313d0b1-54b1-9fe2-6c75-d2ae7b57fe3a@iee.org>
        <CAC05384uh_xRboFhxohRq-vKFrTPDnszSaS3vW+BAv30h-Zd+g@mail.gmail.com>
Date:   Mon, 14 Jan 2019 10:18:21 -0800
In-Reply-To: <CAC05384uh_xRboFhxohRq-vKFrTPDnszSaS3vW+BAv30h-Zd+g@mail.gmail.com>
        (Nickolai Belakovski's message of "Sat, 12 Jan 2019 17:41:12 -0800")
Message-ID: <xmqqbm4jw1aq.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Nickolai Belakovski <nbelakovski@gmail.com> writes:

> Not trying to paint anything one way or another. I found that these
> features got in the way of my workflows and didn't see any immediate
> reason why they had to exist. Thinking about it a bit more, is it
> unreasonable to delete a branch even if it's checked out in a worktree
> as long as the user uses git branch --delete --force or -D?

[For ease of discussion, let's assume that our worktree has a
checkout of branch B, and you are mucking with that branch in
another worktree connected to the same repository]

It is probably a sane enhancement to allow but require --force to
delete branch B in the other worktree.  It is a different matter to
allow "git branch -m AnotherBranch B" run in the other worktree to
overwrite branch B--it will be a disaster if we allowed it and then
committed what we have in our worktree.

> This would
> leave the worktree in a detached head state,

It does not.  It will leave us on branch B that is unborn, and the
next commit will start that branch with a root commit.

> but all the data would be
> untouched. 

As far as the person, who is working in our worktree, is concerned,
she wanted to extend the history of branch B before you deleted it
in another worktree.  But because you deleted B while she was
looking the other way, she ended up creating a root commit, losing
all the history behind that branch.  I'd grant you that "--force"
will give us an excuse when she complains, though.

Most likely, you and she are the same person, but one big point in
the ability to work in multiple worktrees is to allow the user to
switch context and multi-task.  When she gives branch B its own
worktree, she does so because she wants to have a stable place to
work on it, without getting affected by other things she does to the
repository in other worktrees.

