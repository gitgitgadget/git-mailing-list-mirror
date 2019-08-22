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
	by dcvr.yhbt.net (Postfix) with ESMTP id 02E031F461
	for <e@80x24.org>; Thu, 22 Aug 2019 03:16:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727923AbfHVDQS (ORCPT <rfc822;e@80x24.org>);
        Wed, 21 Aug 2019 23:16:18 -0400
Received: from mail-ua1-f65.google.com ([209.85.222.65]:39633 "EHLO
        mail-ua1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726785AbfHVDQS (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 21 Aug 2019 23:16:18 -0400
Received: by mail-ua1-f65.google.com with SMTP id k7so1520847uao.6
        for <git@vger.kernel.org>; Wed, 21 Aug 2019 20:16:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=LIgy3vkskIXzVs0uZ6cGkejEqUl80hHjc15KPLpe5DM=;
        b=WRdwEiqcK5eiNtguHEAExtt+EqDi5ZLxsy1lccIWGfGnoXVACZZPmO6H8fD70d6fxX
         E98HalfNErv4RlRD/9gHbD8/1Rs/UxWkr3B4GBWsCee8qBnDNuoVQ41NXfhew00si0J1
         bFdw+onqa2fUT68rJ7nbd9TKstoQJjbBwNm820RrtWnRW+MyDh0H0XU9usxzYS+WUlLK
         Ul3dA/xRkbJeY3MfL3EkJumXOSyCgqitL9WqcvK6uesyRBWQahBmaSjE1wv/GGrUGAex
         k3YkNcIUxzms+4qrsuV6N9OAu3EnhSCGDe/eS6Rw7o8ADqlkM9puNIgLjoZmbPSWg5Xr
         lZMg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=LIgy3vkskIXzVs0uZ6cGkejEqUl80hHjc15KPLpe5DM=;
        b=VspRwgtzFepQfd3/UzhgiH6FrJZuXNr7eLQt8Vzmx4pzBDUM/V5aZSciqv921cyxtd
         hQfJKrRCi/CgIJ6NBrBplgMFAST2tEGfe0qHc21bizOi5J5YGloqzCwNEvbBeXyP5YQt
         Fi4iQSxxTGiS2ynJzuzXlPq2XfCQrkgCdgzbktqrD6jVq9wWv1MyHTUofUmiraKjKGJf
         N+Ms0WB6fWCTAAAi8BOvdioJ/fS9AzFmo+UH70vh8xqrRCoylEgMPRVj1DKzXPmWAJT/
         UpoiM9ZWwTF8hJP7VHA+ejJEpV5DHk7EK56FgpaHnweKi8cjErERJVo9dp8By+cCYA0v
         /8bg==
X-Gm-Message-State: APjAAAUWVgUKojQo2IBLDFXFhU0ivak6P2+eccWiWsSOWqQ136kXxBMn
        Iln4UUvmwO2FrqjlCNPggtF26NZ0HpTi5IskXnn4/w==
X-Google-Smtp-Source: APXvYqzxd62teFNZxFMBJZNRlyvco+mBSjoHIAZiKIPxK4EP0gh546Uylvhrv+HaN9HZq5LG2piPPz7SKF/hSTeNQMM=
X-Received: by 2002:a9f:2230:: with SMTP id 45mr4182941uad.87.1566443777196;
 Wed, 21 Aug 2019 20:16:17 -0700 (PDT)
MIME-Version: 1.0
References: <pull.317.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.317.git.gitgitgadget@gmail.com>
From:   Elijah Newren <newren@gmail.com>
Date:   Wed, 21 Aug 2019 20:16:06 -0700
Message-ID: <CABPp-BEN7TaMvtjoyqRa+_YxLDe8h8NYD9piu86-vWgwiKfbjQ@mail.gmail.com>
Subject: Re: [PATCH 0/2] [RFC] Revert/delay performance regression in 'git
 checkout -b'
To:     Derrick Stolee via GitGitGadget <gitgitgadget@gmail.com>
Cc:     Git Mailing List <git@vger.kernel.org>,
        =?UTF-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41j?= <pclouds@gmail.com>,
        Jeff Hostetler <git@jeffhostetler.com>,
        Junio C Hamano <gitster@pobox.com>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi,

On Wed, Aug 21, 2019 at 12:21 PM Derrick Stolee via GitGitGadget
<gitgitgadget@gmail.com> wrote:
>
> As we were integrating Git 2.23.0 into VFS for Git, we discovered that "git
> checkout -b new-branch" went from 0.3s to 10+s on the Windows OS repo. This
> was an intentional change when writing the "git switch" builtin. Here is the
> commit message for 65f099b ("switch: no worktree status unless real branch
> switch happens" 2019-03-29):
>
> When we switch from one branch to another, it makes sense to show a
> summary of local changes since there could be conflicts, or some files
> left modified.... When switch is used solely for creating a new
> branch (and "switch" to the same commit) or detaching, we don't really
> need to show anything.
>
> "git checkout" does it anyway for historical reasons. But we can start
> with a clean slate with switch and don't have to.
>
> This essentially reverts fa655d8411 (checkout: optimize "git checkout
> -b <new_branch>" - 2018-08-16) and make it default for switch,
> but also for -B and --detach. Users of big repos are encouraged to
> move to switch.
>
> I was considering doing a full, long-term revert of this change to get the
> performance back to normal, but I also saw this feedback on the list for
> this patch:
>
> I like this last bit. The skip_merge_working_tree() function which
> this removes was ugly, difficult to maintain, and difficult to get
> just right (and easy to break -- even by changing parts of the system
> which one might not expect to impact it).

Instead of restoring this easy-to-break code, could we instead
simplify it and make it more robust?  As per the original commit
message, the whole point of the patch is that when you have a huge
index, operations take a while.  But in the special case of "git
checkout -b <new_branch>", there's no need to even check the index.
So, we could:

  * Check if the user is running "git checkout -b <new_branch>"
  * If so, use the performance hack to skip touching the index at all.

This would be much better than what the patch currently does:

  * Check if the user has specified -m, if so they clearly didn't just
specify "git checkout -b <new_branch>"
  * Check if the user has specified -f, if so they clearly didn't just
specify "git checkout -b <new_branch>"
  * Check if the user has specified --detach, if so they clearly
didn't just specify "git checkout -b <new_branch>"
  * ...<lots of other similar steps>...
  * If we got here, since we've checked all other cases (assuming
other people who have touched checkout remembered to add the necessary
checks for each and every new flag), then by deduction the user must
have specified "git checkout -b <new_branch>", so...
  * Use the performance hack to skip touching the index at all.
