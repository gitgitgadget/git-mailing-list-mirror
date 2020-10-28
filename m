Return-Path: <SRS0=wsT/=ED=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 33F46C4363A
	for <git@archiver.kernel.org>; Wed, 28 Oct 2020 22:03:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D9B8620EDD
	for <git@archiver.kernel.org>; Wed, 28 Oct 2020 22:03:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729753AbgJ1WDc (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 28 Oct 2020 18:03:32 -0400
Received: from mslow2.mail.gandi.net ([217.70.178.242]:57326 "EHLO
        mslow2.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729723AbgJ1WDb (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 28 Oct 2020 18:03:31 -0400
Received: from relay3-d.mail.gandi.net (unknown [217.70.183.195])
        by mslow2.mail.gandi.net (Postfix) with ESMTP id 167953B4030
        for <git@vger.kernel.org>; Wed, 28 Oct 2020 13:07:42 +0000 (UTC)
X-Originating-IP: 103.82.80.43
Received: from localhost (unknown [103.82.80.43])
        (Authenticated sender: me@yadavpratyush.com)
        by relay3-d.mail.gandi.net (Postfix) with ESMTPSA id 1194A60006;
        Wed, 28 Oct 2020 13:07:19 +0000 (UTC)
From:   Pratyush Yadav <me@yadavpratyush.com>
To:     Filipp Bakanov <filipp@bakanov.su>
Cc:     git@vger.kernel.org
Subject: Re: Proposal: "unadd" command / alias.
References: <CAAdniQ5pRHKUU77XVmZkZ_gUgfYYFpo9=Xt2T6EgzJ3hoT0YMg@mail.gmail.com>
Date:   Wed, 28 Oct 2020 18:37:17 +0530
In-Reply-To: <CAAdniQ5pRHKUU77XVmZkZ_gUgfYYFpo9=Xt2T6EgzJ3hoT0YMg@mail.gmail.com>
        (Filipp Bakanov's message of "Tue, 27 Oct 2020 23:10:00 +0300")
Message-ID: <87eelifqii.fsf@yadavpratyush.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-GND-Spam-Score: 400
X-GND-Status: SPAM
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Oct 27 2020, Filipp Bakanov wrote:

> Hi! I suggest to add "unadd" command, that will undo a git add command.
>
> git unadd path/to/file
>
> It will be an alias to:
>
> git reset HEAD -- path/to/file
>
> The motivation is that I always forget syntax and have to google each
> time I want to undo accidentally added files. Unadd is just much
> easier to remember and quite obvious.

Why do you need to Google when `git status` tells you how to do it?

    $ touch foo
    $ git add foo
    $ git status
    On branch master
    Your branch is up to date with 'origin/master'.

    Changes to be committed:
      (use "git restore --staged <file>..." to unstage)
    	new file:   foo
    
    $ git restore --staged foo
    $ git status
    On branch master
    Your branch is up to date with 'origin/master'.

    Untracked files:
      (use "git add <file>..." to include in what will be committed)
    	foo

    nothing added to commit but untracked files present (use "git add" to track)

-- 
Regards,
Pratyush Yadav
