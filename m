Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F23C5C433FE
	for <git@archiver.kernel.org>; Tue,  4 Oct 2022 09:37:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231181AbiJDJho (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 4 Oct 2022 05:37:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51568 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229592AbiJDJhQ (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 4 Oct 2022 05:37:16 -0400
Received: from mail-oi1-x231.google.com (mail-oi1-x231.google.com [IPv6:2607:f8b0:4864:20::231])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F14C954C8A
        for <git@vger.kernel.org>; Tue,  4 Oct 2022 02:34:01 -0700 (PDT)
Received: by mail-oi1-x231.google.com with SMTP id d64so13881996oia.9
        for <git@vger.kernel.org>; Tue, 04 Oct 2022 02:34:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date;
        bh=Hl1Z8MSvrgb/c4/ddD2sZqaQURIaOzcYznmdxUXouFY=;
        b=lFhTnoG6RXK8s+247ZxHGtr1ZpTKSJlXcPsPvP+dwAAAPx7pGLlOuibVmV4kvWGx5B
         QpZN/zJXBTHrAmHr9AHXnxkXPUyoO1E/YVwEcdLRR9lou2G9AlL5ZnvC4P5RggQT8Fqo
         BjOcOSVBglLOiN8mSWRoJYeiNG9CUPj5WH2UNm7BOPnRbDQzxmIe4PdiJHxEW1ohgbpa
         BfNk05yAgl8Clyl6408IOhWTgIKORYGL+qlYjkuizQxTsbVATYLAwulfA0fROduRITVg
         ktpEAQP5angqCJZcnLfndI5qm/0ZKLbT7OSlK32lvoIwz9Y4be90gvS03RSESWIuDV84
         ZwUw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date;
        bh=Hl1Z8MSvrgb/c4/ddD2sZqaQURIaOzcYznmdxUXouFY=;
        b=xICaUbZaqqLsNMZcHh/DQUSE5dM/k5ILufs7SVuyQjq3sY1D3VRvg0vbQUlf1HB9ya
         zpbCo21dFCEMG5wNmrdTwAyD5L6rUQihEfAp0Q+punlhJ72+DtgXGhHhwPEng6G9Gxgk
         BI04Jo4WsR+5DvFcqPdYlsgqUmzDlKuzziiALi/nBsREjjFNuCAu1j/wXnaXPN6sPWOk
         dDSiaEkfx6XQ0gr6dxqLkSJEHbWmVl6BJF7pgUBmzaK2zze+BcnwCzuGW6iEpQDz0Y8q
         mCG/YOEmkqsvLPpiRzhmg+nj48+jYaE4kna2Xc96VwsD0Gexdgrxrx31JvDnK/TFOSKC
         af5w==
X-Gm-Message-State: ACrzQf1teXTqQq6wtJK//SxBw1QHJtImnnkfffZkip7+xOlfJf/uzMcP
        SVwdbGIv9Pyq5SJpJ2SontnmWk4D3478ARle1Ss=
X-Google-Smtp-Source: AMsMyM4qa4sa52CMAuKq9z/vXHIAKaHA5UY95AvH5ZWviUUre5b4qd+FxsSwWaNQo45BhrclRtWieknej6antsZKshc=
X-Received: by 2002:a05:6808:220c:b0:350:cdf8:8fff with SMTP id
 bd12-20020a056808220c00b00350cdf88fffmr5875127oib.106.1664876029801; Tue, 04
 Oct 2022 02:33:49 -0700 (PDT)
MIME-Version: 1.0
References: <pull.1356.git.1663959324.gitgitgadget@gmail.com> <e301d4c1-8f80-b9cf-142b-cd7bd183d625@gmail.com>
In-Reply-To: <e301d4c1-8f80-b9cf-142b-cd7bd183d625@gmail.com>
From:   Chris P <christophe.poucet@gmail.com>
Date:   Tue, 4 Oct 2022 11:33:38 +0200
Message-ID: <CAN84kK=XKYDzF3tmUiwb4vCGcnWvXvewz7QtZwzNEsvRZ8Em+g@mail.gmail.com>
Subject: Re: [PATCH 00/10] Add the Git Change command
To:     phillip.wood@dunelm.org.uk
Cc:     Christophe Poucet via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org, Christophe Poucet <poucet@google.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

> Thanks for picking this up, having an evolve command would be a really
> useful addition to git. I read the final four patches as I was
> interested to see how a user would use "git change" to track changes to
> a set of commits. Unfortunately because there are no tests and scant
> documentation there are no examples of how to do this. Looking at the
> patches I felt like it would have been helpful to mark them as RFC to
> indicate that the author is requesting feedback but does not consider
> them ready for merging.

Thanks for the feedback, I'll mark them as RFC.

> I'm confused as to why the command is called "change" (which I don't
> find particularly descriptive) when every patch subject is "evolve". It
> definitely makes sense to request feedback on a large topic like this
> before everything is implemented but I'd be nervous of merging the early
> stages before there is a working evolve command. For an example of a
> successful multipart topic see
> https://lore.kernel.org/git/pull.1248.git.1654545325.gitgitgadget@gmail.com/
> Knowing the author of that series the commit messages should also give
> you a good idea of the level of detail expected.

The `git change` command is a lower-level command used to directly
manipulate changes, as a user you should not be engaging with those.
What is missing is the more complicated  `git evolve` command.
I admit that I don't yet know how to implement that or the changes that
need to happen to all create/modify commands.

Still learning git, so apologies for any mistakes and thank you for your
consideration

- simply chris

On Sun, Sep 25, 2022 at 10:40 AM Phillip Wood <phillip.wood123@gmail.com> wrote:
>
> Hi Christophe
>
> On 23/09/2022 19:55, Christophe Poucet via GitGitGadget wrote:
> > I'm reviving the original git evolve work that was started by
> > sxenos@google.com
> > (https://public-inbox.org/git/20190215043105.163688-1-sxenos@google.com/)
> >
> > This work is intended to make it easier to deal with stacked changes.
> >
> > The following set of patches introduces the design doc on the evolve command
> > as well as the basics of the git change command.
>
> Thanks for picking this up, having an evolve command would be a really
> useful addition to git. I read the final four patches as I was
> interested to see how a user would use "git change" to track changes to
> a set of commits. Unfortunately because there are no tests and scant
> documentation there are no examples of how to do this. Looking at the
> patches I felt like it would have been helpful to mark them as RFC to
> indicate that the author is requesting feedback but does not consider
> them ready for merging.
>
> I'm confused as to why the command is called "change" (which I don't
> find particularly descriptive) when every patch subject is "evolve". It
> definitely makes sense to request feedback on a large topic like this
> before everything is implemented but I'd be nervous of merging the early
> stages before there is a working evolve command. For an example of a
> successful multipart topic see
> https://lore.kernel.org/git/pull.1248.git.1654545325.gitgitgadget@gmail.com/
> Knowing the author of that series the commit messages should also give
> you a good idea of the level of detail expected.
>
> Best Wishes
>
> Phillip
>
> > Chris Poucet (4):
> >    sha1-array: implement oid_array_readonly_contains
> >    ref-filter: add the metas namespace to ref-filter
> >    evolve: add delete command
> >    evolve: add documentation for `git change`
> >
> > Stefan Xenos (6):
> >    technical doc: add a design doc for the evolve command
> >    evolve: add support for parsing metacommits
> >    evolve: add the change-table structure
> >    evolve: add support for writing metacommits
> >    evolve: implement the git change command
> >    evolve: add the git change list command
> >
> >   .gitignore                         |    1 +
> >   Documentation/git-change.txt       |   55 ++
> >   Documentation/technical/evolve.txt | 1051 ++++++++++++++++++++++++++++
> >   Makefile                           |    4 +
> >   builtin.h                          |    1 +
> >   builtin/change.c                   |  342 +++++++++
> >   change-table.c                     |  179 +++++
> >   change-table.h                     |  132 ++++
> >   git.c                              |    1 +
> >   metacommit-parser.c                |  110 +++
> >   metacommit-parser.h                |   19 +
> >   metacommit.c                       |  404 +++++++++++
> >   metacommit.h                       |   58 ++
> >   oid-array.c                        |   12 +
> >   oid-array.h                        |    7 +
> >   ref-filter.c                       |   10 +-
> >   ref-filter.h                       |    8 +-
> >   t/helper/test-oid-array.c          |    6 +
> >   t/t0064-oid-array.sh               |   22 +
> >   19 files changed, 2418 insertions(+), 4 deletions(-)
> >   create mode 100644 Documentation/git-change.txt
> >   create mode 100644 Documentation/technical/evolve.txt
> >   create mode 100644 builtin/change.c
> >   create mode 100644 change-table.c
> >   create mode 100644 change-table.h
> >   create mode 100644 metacommit-parser.c
> >   create mode 100644 metacommit-parser.h
> >   create mode 100644 metacommit.c
> >   create mode 100644 metacommit.h
> >
> >
> > base-commit: 4b79ee4b0cd1130ba8907029cdc5f6a1632aca26
> > Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-1356%2Fpoucet%2Fevolve-v1
> > Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-1356/poucet/evolve-v1
> > Pull-Request: https://github.com/gitgitgadget/git/pull/1356
