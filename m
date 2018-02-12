Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_DKIM_INVALID,
	T_RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 4DC401F404
	for <e@80x24.org>; Mon, 12 Feb 2018 03:27:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932657AbeBLD13 (ORCPT <rfc822;e@80x24.org>);
        Sun, 11 Feb 2018 22:27:29 -0500
Received: from mail-qt0-f194.google.com ([209.85.216.194]:35299 "EHLO
        mail-qt0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932396AbeBLD12 (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 11 Feb 2018 22:27:28 -0500
Received: by mail-qt0-f194.google.com with SMTP id g14so17454292qti.2
        for <git@vger.kernel.org>; Sun, 11 Feb 2018 19:27:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:sender:in-reply-to:references:from:date:message-id
         :subject:to:cc;
        bh=svvUkH0MyF3AKdeZ6zKEGDxDvAGXopKHkjUku2nz+GQ=;
        b=c85/Fr48bnvrpTnVzD5zh9+lwJcA4GJ6901gKFHsrjT1gG0kT2AFFN1Y3UlDlFeNsm
         hAztSMTQRJoyCvEM5rqrZuiWmAVaKtPwh9CWZ1w7drwEIqVG5M+37QqJT+eWnJ9B29ck
         g4snpAgMb9B+n07abS9DwUdJPLHEEiZGvAQBSYPGchb8EWOgZoU91R+C0M37w+lF++ro
         ULpK6mOG7VQBomaCjA3erHl/3f6ptwy+ToVdgi8r9/JcySryQqmoVlUYcttz7SyKrpFo
         uwQk3n+4AmIyeUgU8hqO5XOg/rQ0GirRQtVA2Bea/ViCCHHsZlh5OFm2Qv9BGCS9Y//o
         J2ow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:sender:in-reply-to:references:from
         :date:message-id:subject:to:cc;
        bh=svvUkH0MyF3AKdeZ6zKEGDxDvAGXopKHkjUku2nz+GQ=;
        b=kSeyNjYpL+hBIQ1uN/Y7lCUI4vvA91X9pzelV2rOq8YpbI6NIo6lZ/yjow0SBvZn7h
         iyO9wNUkNLaocU/SmVs8slTbcusUx8vv9nf/gTqJf5NP63ts4sSTcl/fcRgfN8QasDx6
         UPue/GryotaOD70I72riRjszldYeex+9VAmTrDJ2PIvc97k9Jb3rAYOZfE964KTHeAG4
         XWFeKmVifIMdLmxV/Piu+XryGd6pYx9rTjvlUcw2h4YAQjEIGMEecBO8F6TTbGGR6w/y
         LtsVqo46Rq7eQ0jaNWNx1QuBrt/XQAcgoDvm3AjsZeZB9f8Tu9/Gs0+eln6gpXHyWeUS
         6V/g==
X-Gm-Message-State: APf1xPDbcRSL2F/i6pLJSC7fH5BQP6Kb2HcGW736KOY48qw+qqHNurbJ
        EmjV1EGHlnZ8TqgcUREjueUD3s+U2LH6lZl+WHp4Vg==
X-Google-Smtp-Source: AH8x225LF9LgXdwUwlJvdlm+75ObLVaHh8yye0aPhpCuf9lEm+6y4uteu1ES/Xm04SyOZoui8L9lBOMVvB2K3sgdK8o=
X-Received: by 10.237.36.221 with SMTP id u29mr8519593qtc.116.1518406047374;
 Sun, 11 Feb 2018 19:27:27 -0800 (PST)
MIME-Version: 1.0
Received: by 10.12.128.40 with HTTP; Sun, 11 Feb 2018 19:27:27 -0800 (PST)
In-Reply-To: <20180210010132.33629-1-lars.schneider@autodesk.com>
References: <20180210010132.33629-1-lars.schneider@autodesk.com>
From:   Eric Sunshine <sunshine@sunshineco.com>
Date:   Sun, 11 Feb 2018 22:27:27 -0500
X-Google-Sender-Auth: qVWr6fEvpM-3vHFfAkwoyXJn9EU
Message-ID: <CAPig+cQ7MRQVT-1yNF8t6RMHNrgMtYvzOToamaLO==ymxTtLYg@mail.gmail.com>
Subject: Re: [PATCH v1] worktree: set worktree environment in post-checkout hook
To:     Lars Schneider <lars.schneider@autodesk.com>
Cc:     Git List <git@vger.kernel.org>,
        "Gumbel, Matthew K" <matthew.k.gumbel@intel.com>,
        Lars Schneider <larsxschneider@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, Feb 9, 2018 at 8:01 PM,  <lars.schneider@autodesk.com> wrote:
> In ade546be47 (worktree: invoke post-checkout hook (unless
> --no-checkout), 2017-12-07) we taught Git to run the post-checkout hook
> in worktrees. Unfortunately, the environment of the hook was not made
> aware of the worktree. Consequently, a 'git rev-parse --show-toplevel'
> call in the post-checkout hook would return a wrong result.
>
> Fix this by setting the 'GIT_WORK_TREE' environment variable to make
> Git calls within the post-checkout hook aware of the worktree.
>
> Signed-off-by: Lars Schneider <larsxschneider@gmail.com>
> ---
> I think this is a bug in Git 2.16. We noticed it because it caused a
> problem in Git LFS [1]. The modified test case fails with Git 2.16 and
> succeeds with this patch.

Thanks for reporting and diagnosing the problem.

I have some concerns about this patch's fix of setting GIT_WORK_TREE
unconditionally. In particular, such unconditional setting of
GIT_WORK_TREE might cause unforeseen problems. Although the
circumstances may not be quite the same, but the tale told by
86d26f240f (setup.c: re-fix d95138e (setup: set env $GIT_WORK_TREE
when .., 2015-12-20) makes me cautious.

More significantly, though, setting GIT_WORK_TREE seems too
specialized a solution. While it may "fix" Git commands invoked by the
hook, it does nothing for other commands ('cp', 'mv', etc.) which the
hook may employ.

As a review comment, I was going to suggest that you chdir() to the
new worktree directory instead of messing with GIT_WORK_TREE, but when
I tested it myself before making the suggestion, I discovered that the
issue is a bit more involved. The result is that I ended up posting a
patch series[1] to replace this one, with what I believe is a more
correct fix.

[1]: https://public-inbox.org/git/20180212031526.40039-1-sunshine@sunshineco.com/
