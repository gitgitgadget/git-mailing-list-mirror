Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 510F01F461
	for <e@80x24.org>; Fri, 30 Aug 2019 15:21:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727919AbfH3PVa (ORCPT <rfc822;e@80x24.org>);
        Fri, 30 Aug 2019 11:21:30 -0400
Received: from mail-ua1-f67.google.com ([209.85.222.67]:41226 "EHLO
        mail-ua1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727135AbfH3PVa (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 30 Aug 2019 11:21:30 -0400
Received: by mail-ua1-f67.google.com with SMTP id x2so2424246uar.8
        for <git@vger.kernel.org>; Fri, 30 Aug 2019 08:21:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=0lg9+9JnyEOC6OeaTfdI6brws/9CV4ReghCIUtKWz7Y=;
        b=Vn8jv4e0cftZHbsiesJquCMzeb/x1+Tb0QIP+tKFFVegfXMSr5NNI/OHJD0A/JSfd/
         /2PRn0wAUXYR5rI3KZmpHhqo0etgp3vBNMu8krw1lP0YgUn5+qoFO1PnWqvIztXTk6VM
         ah1xKl+xFIzP4hf8tBv6ci3YKkoU4i1lKpjzUXoVgRhMZv4z6BwJCegs10JrOw6uw3Gg
         Ud2E7oGMDwOiH+we4xJCNvUIojWter4yIhsqVEncR8w/hi4QD9HMNPKDD1gNOUQ1UKEZ
         v3Dy2uVOe1lFxjdb/tfmtutcAVjaM/nwFsU7if0QRAnNLEMjJlxGQInGc0I0XsykpEVg
         uyvA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=0lg9+9JnyEOC6OeaTfdI6brws/9CV4ReghCIUtKWz7Y=;
        b=B0KSi5hFhjrFb40UjyiqjKdM+3NL+gcat885XbjJXSCq/qsZzmmy3qvgg2tIj8fnp7
         shTMRiuKWKkjvYanHu9oPEsnsQNgdL/O3uCYDSD4P25JrR1ELzwB1k8qtEpmJfHGHt6w
         a4vtcumdiU83kOkU0EzJzwiWgA0PIglgmuBrXqnVD9tuhjQ4n3ehsyXCZRT4nFQ/jrQG
         UavogqD28jF9e5O8WiLbZ1lvJ32sEqhRgnvPLURmweszNZtvVKhuHwc2Q2nWUZpEYdrK
         KiDPLMBG8z4kNA7NzECilGzyL8W7fB8qA7W0rNYoo8sWu9mk7Rlxep8NYVa7tJJNRTfO
         AGrQ==
X-Gm-Message-State: APjAAAWHpw3erollWV0D0fKCpAO/uqwmBG553CfAVnX0zMkZU/UBbMsp
        NwrmtO4Vfn7tsbuQKufs0imaO71bg+JZ71xd/CQc+UUt
X-Google-Smtp-Source: APXvYqxw3nBb53z0lE/5gdoJPM+XshYGvAin6kGshhAfcXOY5CeZDenJhc04jq/u2YRq3NdOKwWh0pdx5U9F27GkWmM=
X-Received: by 2002:ab0:24d4:: with SMTP id k20mr7884171uan.1.1567178488986;
 Fri, 30 Aug 2019 08:21:28 -0700 (PDT)
MIME-Version: 1.0
References: <CAEV-cEryZZarfz5SQsRphBXeYMPJW7tdSfY8NYnzb_-ra-pGHw@mail.gmail.com>
 <CABPp-BE0ij8zF22xbvjbcq3vG-VwWjUmjNo45Lsm0BEnH=iZ-A@mail.gmail.com> <CAEV-cEp19ehfBwHxh7OGsvTxTchNJLSRZGZXqAsDjyQg-W3rFA@mail.gmail.com>
In-Reply-To: <CAEV-cEp19ehfBwHxh7OGsvTxTchNJLSRZGZXqAsDjyQg-W3rFA@mail.gmail.com>
From:   Elijah Newren <newren@gmail.com>
Date:   Fri, 30 Aug 2019 08:21:17 -0700
Message-ID: <CABPp-BEWn1wHdxWM8cVqmvzYo8HDdUzuh4G-XTN51o8JdvkrCw@mail.gmail.com>
Subject: Re: How to track history of personal changes in a repository?
To:     Matthew McClure <matt@continuousdelta.com>
Cc:     Git Mailing List <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Aug 29, 2019 at 10:58 AM Matthew McClure
<matt@continuousdelta.com> wrote:
>
> On Thu, Aug 29, 2019 at 1:04 PM Elijah Newren <newren@gmail.com> wrote:
> >
> > Perhaps put all the changes in a specific branch and run:
> >   git config branch.${personalBranchName}.pushRemote
> > Do.Not.Push.Changes.From.This.Branch
> > ?  (And make sure that push.default is not set to 'matching'.)
>
> I imagine putting all the changes on a specific branch might be part
> of a solution. I'm looking for ways to keep the changes in the work
> tree as well, even as I switch among other branches I'm working on.

Well, here's some ideas...

If you want personal changes kept in the worktree and aren't worried
about versioning them:

* If the changes are new files that are not tracked, just .gitignore them.
* If the changes are to files that are tracked, AND you aren't making
changes to those same files that do need to be committed and pushed,
use the assume-unchanged bit (see git-update-index(1)).
* If the changes are to files that are tracked and you need to make
other changes to those same files, the best you've probably got is "be
careful while using 'git add -p' to only select the bits that should
be staged".

If you want to keep the personal changes in the worktree AND are
worried about version control:

* You could just make sure that any personal changes are made in
separate commits of their own and put a special string (e.g. "DO NOT
PUSH") in the commit message.  Add a pre-push hook (see githooks) that
checks for this string in any of the commits to be pushed and denies
the push if it is found.  At that point, you'd just rebase to move the
"DO NOT PUSH" to be the last commits in the series, and always make
sure when pushing that you specify a commit older than the current tip
of your branch to push (i.e. using refspecs; see the git-push manpage)
* If you don't like the githook route and if the personal changes are
all in different filenames than exist in other branches, and you're
willing to do a little low-level hackery...then you could put all
these changes in a different branch as mentioned previously, and use
some low-level commands to "checkout" the files from both branches
simultaneously.  The basic way it'd work is that the real branch would
have a .gitignore for all files in your personal changes (whereas the
personal changes branch would have no .gitignore because files have to
be independent; things will just be uglier when you're on that
branch).  You'd use 'git symbolic-ref HEAD $OTHER_BRANCH && git reset'
to swap branches on the fly so you can commit different types of
changes.

Hope that helps,
Elijah
