Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id CC84A1F453
	for <e@80x24.org>; Thu,  2 May 2019 10:53:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726324AbfEBKxv (ORCPT <rfc822;e@80x24.org>);
        Thu, 2 May 2019 06:53:51 -0400
Received: from mail-it1-f194.google.com ([209.85.166.194]:38030 "EHLO
        mail-it1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726267AbfEBKxv (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 2 May 2019 06:53:51 -0400
Received: by mail-it1-f194.google.com with SMTP id q19so2583260itk.3
        for <git@vger.kernel.org>; Thu, 02 May 2019 03:53:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=uUr+BYmn+Xo+Vh5aPFwvDDVCYCPuzFDyz+mx5WCoJx0=;
        b=d82mwlUt2Tqivw/EvtDkujMe2++a2B2V0TIVq6pu+tKfo5xWnm+qGc9oGfg/3i+JeJ
         lUIA7J23cRHuLBc/mV3KX1Q5N1ALQqfJ0zjaQHrIx/JIZKLtebPIjMEtj5XZ2UtPsWU+
         4/oHxU8kLErn2D4wAjSc9OnN/eskRBOblSiTORFvwTzm1l6D2nqC9WSo2YXp2dmTEGgh
         9EfMmJeS8clHyTX5mtIfRrmF7Ep9pbKNI939ul8/8vIuU9JNKd1dV7rfMX2KIB6RKrIQ
         qNC9uXSrLpfuRxwjgkZhGJGAplNoO+M/ma9HgENPWLGVS/zwpDcHBDKCqfFsL7pk75HU
         50Fw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=uUr+BYmn+Xo+Vh5aPFwvDDVCYCPuzFDyz+mx5WCoJx0=;
        b=MKVSW9xyYV3gLREcln+WPdHD+hnQuJMgkoJMtjSiHyhuDOT5JUzssLwnFitP3r4xc2
         PucAaJSkGZ4YIeaUqKOjLKtJWf4ARJ3JcXFNhr5P/fxnuLGJ3rVUnImUwl8e1cZopFfw
         svDFdKjzbvX2rojrCOipft0pdJL5mK8+VSLe9DakQnlVsUHIx/MYzu/FMBnGjFzOlcl6
         0u3zjxy6mwK6eO7ukaB8+13ilyWufCJpYm0zTIslA8OnKGFevAiVymtD+5qdJ/AtO9hC
         fbw6dM0q6M3qF/CSUZs3Kn1xQDtps4oVLctwaABSoaGjFl2ycXAfHcr3Sbp1Ix3/1qOq
         V8/w==
X-Gm-Message-State: APjAAAXHNq5w6RtpzRM4LXBp87LZKf2ke9hsmg7+h4k3rncwNvuj5PeM
        cLS8J60fELV4mJdJiwlTRQNu3Hnu0F7aJ3AE1Ts=
X-Google-Smtp-Source: APXvYqzrrFvrgVEv/KLQhnddEJk8YxH2e5w7XLsZYMjoYCFmI3N+F4r8ejQN5uI+1NkDoWVsFlSFb9fBJa2GbV67d7I=
X-Received: by 2002:a24:1104:: with SMTP id 4mr1604643itf.10.1556794430454;
 Thu, 02 May 2019 03:53:50 -0700 (PDT)
MIME-Version: 1.0
References: <20190501101403.20294-1-phillip.wood123@gmail.com>
 <CACsJy8CNUEBXmBcQnRHqdeFJtTvBuZ9thP7QPAw-ZOD+2ty3VA@mail.gmail.com> <d4c36a24-b40c-a6ca-7a05-572ab93a0101@gmail.com>
In-Reply-To: <d4c36a24-b40c-a6ca-7a05-572ab93a0101@gmail.com>
From:   Duy Nguyen <pclouds@gmail.com>
Date:   Thu, 2 May 2019 17:53:24 +0700
Message-ID: <CACsJy8AAj8cRAc+PnS4OJy8M=K7FjCHUsL6Cx-6+RTAbTA_1fQ@mail.gmail.com>
Subject: Re: [PATCH 0/2] read-tree: improve untracked file support
To:     Phillip Wood <phillip.wood@dunelm.org.uk>
Cc:     Git Mailing List <git@vger.kernel.org>,
        Junio C Hamano <gitster@pobox.com>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, May 1, 2019 at 9:58 PM Phillip Wood <phillip.wood123@gmail.com> wrote:
>
>
>
> On 01/05/2019 11:31, Duy Nguyen wrote:
> > On Wed, May 1, 2019 at 5:14 PM Phillip Wood <phillip.wood123@gmail.com> wrote:
> >>
> >> From: Phillip Wood <phillip.wood@dunelm.org.uk>
> >>
> >> These two patches teach read-tree how to avoid overwriting untracked
> >> files when doing '--reset -u' and also how to respect all of git's
> >> standard excludes files. I'd like to see the porcelain commands stop
> >> overwriting untracked files, this is a first step on the way. I'm not
> >> sure if we want to add options to the porcelain commands to protect
> >> untracked files or just change their behavior and add an option to
> >> override that. I'm leaning towards the latter but I'd be interested to
> >> hear what others think.
> >
> > For new commands like git-restore, it's definitely a good thing to not
> > overwrite untracked files.
>
> I agree, unfortunately this series does not help with git-restore, only
> git-switch. For restore on an index without conflicts I think it could
> just use the pathspec in struct unpack_trees_options and set opts.rest =
> UNPACK_RESET_PROTECT_UNTRACKED but that does not help if we want to
> handle conflicted paths differently to non-conflicted paths.

Right. I got confused. You did mention "git checkout <rev> :/" in 1/2,
which is the same as "git restore --source <rev> --staged --worktree
:/" and  can also potentially overwrite untracked files, even though
it does not use unpack-trees and cannot be fixed with this. Never
mind. Let's leave git-restore out of the discussion for now.

> > For existing commands I guess we have to go
> > over them one by one. For "git reset --hard", it should really just
> > overwrite whatever needed to get back to the known good state. "git
> > checkout -f" , not so sure (seems weird that we need force-level-two
> > option to override the protection provided by -f, if we change default
> > behavior)
>
> I think it's fine for "checkout -f" to overwrite untracked files (and if
> "switch --discard-changes" does not then there is no pressing need to
> add such a mode to checkout), --force is a good name for an option that
> nukes everything that gets in it's way. For "reset --hard" I'm not so
> sure, if I have changes to an untracked file I don't wont them
> overwritten by default. There is no porcelain equivalent to "read-tree
> --reset --protect-untracked -u" and I was hoping "reset --hard" may
> become that porcelain equivalent with a new --force or
> --overwrite-untracked option.

My (biased, obviously) view is that "git reset --hard" is very
dangerous and I'm not trying to change that, especially when its
behavior has been like this since forever and I'm sure it's used in
scripts.

Instead "git restore" should be used when you need "git reset --hard
HEAD", the most often use case. And since it's new, changing default
behavior is not a problem. Which brings us back to git-restore :)

But either way, git-restore or git-reset, I still don't see why
untracked files are more valuable in this case than tracked ones to
change the default. I can see that sometimes you may want to restore
just tracked files, or untracked files, almost like filtering with
pathspec.

> For the various "foo --abort" some (most?) are using "reset --merge"
> which I think declines to overwrite untracked files but rebase uses
> "reset --hard" which I'd like to change to protect untracked files in
> the same way that rebase does for the initial checkout and when picking
> commits. I haven't thought about stash.

Yeah it looks like cherry-pick and revert use "reset --merge" too
(reset_for_rollback function). That's all of them. Probably a stupid
question, why can't rebase just use "rebase --merge" like everybody
else?

>
> Best Wishes
>
> Phillip
>


-- 
Duy
