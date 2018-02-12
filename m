Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_DKIM_INVALID,
	T_RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id D17D21F404
	for <e@80x24.org>; Mon, 12 Feb 2018 20:31:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753010AbeBLUba (ORCPT <rfc822;e@80x24.org>);
        Mon, 12 Feb 2018 15:31:30 -0500
Received: from mail-qt0-f194.google.com ([209.85.216.194]:35087 "EHLO
        mail-qt0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750822AbeBLUb3 (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 12 Feb 2018 15:31:29 -0500
Received: by mail-qt0-f194.google.com with SMTP id g14so1132069qti.2
        for <git@vger.kernel.org>; Mon, 12 Feb 2018 12:31:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:sender:in-reply-to:references:from:date:message-id
         :subject:to:cc;
        bh=YiVfXkuiiFmGHfvbBkFBKjhNl2lj6ELuEybXjEXNeB8=;
        b=aHzqvxFhFZ7/IcaUvBEjOfsmjg3DZNHc4ZbqJxxe14deYb078tE71s104UuARqkvZ1
         YmS4naC/sBAY/b81AHsvwTKfzIRvkBf78K2wmayWgvLVY0dw2UGf7Bqrbcum5tQ+Sz20
         Z1cPeTvoHJkP3Ek3Entq9OSjAuDej1k1feCUlBxJO1lf8yc1ODqM7cdPBDXSfhd9jXEU
         vocGfxdHGy999vvx7EYbtcChkEhr4p7aqnNT/Kx5dJbn3CdVQVs17doxKd3C/vvxH3qV
         SKkUocygquEtNtfhZUb5ryeN6/VLRnVDCy749cVbiv/5qAZQAq52DrnYIpt1WHA9wmYV
         xtDQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:sender:in-reply-to:references:from
         :date:message-id:subject:to:cc;
        bh=YiVfXkuiiFmGHfvbBkFBKjhNl2lj6ELuEybXjEXNeB8=;
        b=lNxckhLwhTupgjzYmvut+lzK8gQ+43lj44ld/uxFx+075IIp0KsSRyqBSDms1iiQRy
         48U7DZW6lgSTEziomzwvIuktXK05e6MTdw/udOEpEc9UwuqCO3H0rrQlZnzA+DbSWYaN
         ayhjKO2MJnPPqUI3oek/N1wCQsDH+nZ783B+PbosisnQVOSv7LAXSMJlMZZb+jBGmyYP
         xWOTWTmCYz4iXo42MCA8/LzEZYwEXGQMmGzpHXq6nYviQNV0SiBvgtxrvIAyzFEthJ3V
         68ESvKAXT8E4HhkVYBvWCsuwskHz7g9yqYAIj6rHNbDwyF3PD5uk//yG5BNpjbFg2eqM
         J9mg==
X-Gm-Message-State: APf1xPD7WjUi8K6XUvfskE7MyvunpB4yRoBJAwGt7JMYnK+gTtcSNUSi
        8CX8MP5LDC8wgAkcsI0HMZ7JRcn1/5+sQcPSnlvrnw==
X-Google-Smtp-Source: AH8x224oEqJ8mnn1RQZqvml7oyFmkQAoM41tTEVf8GAC0qvL34oGz5TUkSswZjVxAG7jJ0oqEfK7CRgQzzEL56mj+Ds=
X-Received: by 10.200.51.100 with SMTP id u33mr15241286qta.127.1518467489207;
 Mon, 12 Feb 2018 12:31:29 -0800 (PST)
MIME-Version: 1.0
Received: by 10.12.128.40 with HTTP; Mon, 12 Feb 2018 12:31:28 -0800 (PST)
In-Reply-To: <xmqq7erit2wo.fsf@gitster-ct.c.googlers.com>
References: <20180210010132.33629-1-lars.schneider@autodesk.com>
 <20180212031526.40039-1-sunshine@sunshineco.com> <20180212031526.40039-3-sunshine@sunshineco.com>
 <xmqq7erit2wo.fsf@gitster-ct.c.googlers.com>
From:   Eric Sunshine <sunshine@sunshineco.com>
Date:   Mon, 12 Feb 2018 15:31:28 -0500
X-Google-Sender-Auth: mlnUy8LjWFkT40tRUobh1doRHuE
Message-ID: <CAPig+cQ6Tq3J=bS8ymDqiXqUvoUiP59T=FGZgMw2FOAx0vyo=Q@mail.gmail.com>
Subject: Re: [PATCH 2/2] worktree: add: change to new worktree directory
 before running hook
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Git List <git@vger.kernel.org>,
        Lars Schneider <larsxschneider@gmail.com>,
        "Gumbel, Matthew K" <matthew.k.gumbel@intel.com>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Feb 12, 2018 at 2:37 PM, Junio C Hamano <gitster@pobox.com> wrote:
> Eric Sunshine <sunshine@sunshineco.com> writes:
>> Fix this by changing to the new worktree's directory before running
>> the hook, and adjust the tests to verify that the hook is indeed run
>> within the correct directory.
>
> I like the approach taken by this replacement better.  Just to make
> sure I understand the basic idea, let me rephrase what these two
> patches are doing:
>
>  - "path" that is made absolute in this step is where the new
>    worktree is created, i.e. the top-level of the working tree in
>    the new worktree.  We chdir there and then run the hook script.

Sorry for misleading. The "absolute path" stuff in this patch is
unnecessary; it's probably just left-over from Lars's proposal which
did need to make it absolute when setting GIT_WORK_TREE, and I likely
didn't think hard enough to realize that it doesn't need to be
absolute just for chdir(). I'll drop the unnecessary
absolute_pathdup() in the re-roll.

(The hook path in patch 1/2, on the other hand, does need to be made
absolute since find_hook() returns a relative path before we've
chdir()'d into the new worktree.)

>  - Even though we often see hooks executed inside .git/ directory,
>    for post-checkout, the top-level of the working tree is the right
>    place, as that is where the hook is run by "git checkout" [...]

Patch 1/2's commit message is a bit sloppy in its description of this.
I'll tighten it up in the re-roll.

I'm also not fully convinced that these new overloads of run_hook_*()
are warranted since it's hard to imagine any other case when they
would be useful. It may make sense just to have builtin/worktree.c run
the hook itself for this one-off case.

> I wonder if we need to clear existing GIT_DIR/GIT_WORK_TREE from the
> environment, though.  When a user with a funny configuration (where
> these two environment variables are pointing at unusual places) uses
> "git worktree add" to create another worktree for the repository, it
> would not be sufficient to chdir to defeat them that are appropriate
> for the original, and not for the new, worktree, would it?

Good point. I'll look into sanitizing the environment.
