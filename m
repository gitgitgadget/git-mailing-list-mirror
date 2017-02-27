Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RCVD_IN_SORBS_SPAM,RP_MATCHES_RCVD shortcircuit=no autolearn=no
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 9EDC61F5FB
	for <e@80x24.org>; Mon, 27 Feb 2017 19:40:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751559AbdB0Tk3 (ORCPT <rfc822;e@80x24.org>);
        Mon, 27 Feb 2017 14:40:29 -0500
Received: from mail-it0-f43.google.com ([209.85.214.43]:37568 "EHLO
        mail-it0-f43.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751563AbdB0TkM (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 27 Feb 2017 14:40:12 -0500
Received: by mail-it0-f43.google.com with SMTP id 203so72581045ith.0
        for <git@vger.kernel.org>; Mon, 27 Feb 2017 11:40:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=3rIrIfDyQ5itdssWPbvsVvC13GiNuEqJ6DjFgxCgmjw=;
        b=ZuFNYZxPllSAlBCo4o0KPq0C+YDN0aqw3nxzhrSF+Sy8Qo3IH+wGHeg+F/Nr/WAU5F
         WuhH9LP6+W/AEtzQ4bBMjYYan4h9V1PKbH1v0i4+8EhBlKB7gl7CUvAXVjVYHOHvrC8i
         l4mOviHH/i8omuU9hWjEaG6YQyEq83JV1SgMsw8/aP0zMwgWKJcG8HGdPqu2uY0GwTpN
         IrpU1PJzstM/U4/xYyrxlV9VmCMbYr5W3wuweCXSbk7ePE74ZHg7s48v0VnfZYW14FAQ
         ErapFH24VO3j0EZjU8baeUA57nF4xZo5J946j6ku3z5qh+93YVnatdGXDzZXdG84v03R
         jFPQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=3rIrIfDyQ5itdssWPbvsVvC13GiNuEqJ6DjFgxCgmjw=;
        b=HPdIzozfVghgPr+SER7zltjqX6SIx3rix8mjhSKE6xXqsoxyNUMM/zRJiAg6xdubb+
         EDpvBeYwE1vnRcJa9PGDFF6A0D80F19WNBMvM2ySpxMOrncqs9a9+YwmgpSrukyKWS3G
         0fIX5Ls2P1wPe3s6tp+Gq8Yo6MBwctUEnBxyunDZfBL4YzGyx31thEUT2vSZDlX/CzAJ
         injxHZ+Ht9a74wyWoz9VFNvP9UYBMGildVH8BNu2CTQFx0QusKjOPpGz2VK4C4xFFuEJ
         8FSL8EFBuw2WFgyRWztLxGhjTcQrFTy8iAYBGazfFlgReQrCeDNrpeKpxP1dC5jS8i7T
         pT9g==
X-Gm-Message-State: AMke39lcWdWOEJA/1sydTrr2fSx512+BI8yognV7lK3vdHUq/FScA0rqCoS6piUTi0JhDPA+QZ1zYOTGJNJhJyBB
X-Received: by 10.36.169.12 with SMTP id r12mr16474332ite.69.1488222552805;
 Mon, 27 Feb 2017 11:09:12 -0800 (PST)
MIME-Version: 1.0
Received: by 10.79.13.1 with HTTP; Mon, 27 Feb 2017 11:09:12 -0800 (PST)
In-Reply-To: <CAC+L6n0YeX_n_AysCLtBWkA+jPHwg7HmOWq2PLj75byxOZE=qQ@mail.gmail.com>
References: <CAC+L6n0YeX_n_AysCLtBWkA+jPHwg7HmOWq2PLj75byxOZE=qQ@mail.gmail.com>
From:   Stefan Beller <sbeller@google.com>
Date:   Mon, 27 Feb 2017 11:09:12 -0800
Message-ID: <CAGZ79ka8saQMKeutE415WxOQ71MnEw1A4uV3b0Pa4gcehx8pdw@mail.gmail.com>
Subject: Re: 'git submodules update' ignores credential.helper config of the
 parent repository
To:     Dmitry Neverov <dmitry.neverov@gmail.com>,
        Duy Nguyen <pclouds@gmail.com>, Jeff King <peff@peff.net>,
        Junio C Hamano <gitster@pobox.com>
Cc:     Git List <git@vger.kernel.org>
Content-Type: text/plain; charset=UTF-8
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Feb 27, 2017 at 5:33 AM, Dmitry Neverov
<dmitry.neverov@gmail.com> wrote:>
>   git -c credential.helper= submodule update
>
> Is it by design?

A similar question came up w.r.t. submodule configuration
recently. It is about url.<URLISH>.insteadOf[1] that is set
in the super project and is expected to work in the submodules.
More reading on some background there, as it is the very same
problem: Which configuration should propagate to the submodules,
how do we tell the users and can the user influence if some
articular settings are propagated?

For both these settings (url...insteadOf and the credentialHelper)
one might think that they absolutely should be propagated
to the submodules, but that may not be true; e.g. a submodule
might be hosted at a different hosting provider, needing a different
credentials setup. (The submodule might be an open source library
that you use, which may even require no credentials at all)

So I think we have to come up with a generic solution to respect
certain settings of the superproject instead of e.g. hard coding
credential.helper to be looked up in the superproject.

So the current proposal (in that mentioned thread) is
to borrow the idea from worktrees that have a similar problem:
split up the config into multiple files and each file applies to
a different worktree or in our case we would have
(A) a config file that applies to the superproject;
(B) a config file that applies to both superproject
     and all submodules
(C) and each submodule has its own config file as well.

---
For worktrees these multiple config files sounded like
the obvious solution, but I wonder if there was also
some bike shedding about other solutions?

I could imagine that we would want to have attributes
for specific configuration, e.g.:

--8<--
[core]
    repositoryformatversion = 0
    filemode = true
    bare = false
    logallrefupdates = true
[remote "origin"]
    url = git://github.com/gitster/git
    fetch = +refs/heads/*:refs/remotes/origin/*
[attribute "submodules"]
    read = true
# this will be read and respected by submodules as well:
[url."internal-git-miror"]
    insteadOf = github.com
[attribute "submodules"]
    read = false
# This (and the beginning of this file) will not be respected
# by submodules
[credential]
    helper =
-->8--

This would change the semantics of a config file as the attribute for
each setting depends on the location (was attribute.FOO.read =
{true, false} read before).

This would be read-compatible with older versions of Git, and it seems
as if it were write compatible as well. Just writing a new value with a specifc
attribute would be interesting to implement.

Thanks,
Stefan


[1] https://public-inbox.org/git/84fcb0bd-85dc-0142-dd58-47a04eaa7c2b@durchholz.org/
