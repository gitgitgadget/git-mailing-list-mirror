Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.2 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id EF6D11F461
	for <e@80x24.org>; Thu, 16 May 2019 11:42:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728503AbfEPLmV (ORCPT <rfc822;e@80x24.org>);
        Thu, 16 May 2019 07:42:21 -0400
Received: from mail-it1-f173.google.com ([209.85.166.173]:36737 "EHLO
        mail-it1-f173.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727718AbfEPLmT (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 16 May 2019 07:42:19 -0400
Received: by mail-it1-f173.google.com with SMTP id e184so5676009ite.1
        for <git@vger.kernel.org>; Thu, 16 May 2019 04:42:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=VH/RMDANNgufs0IYruko/PMoL7ljoxsam8g8QTtUKOc=;
        b=RE8Kx4tBK0csps+RbHUUftrBFCje1Di7WnvO3kuK366i3yPQRUCqnOVFVa8D+N3Ysv
         o+aEPzHsu0C8T0BKQbt7huxuRRsP+FoXKXAFs3rKGfHltlEr+/TuJmwEgSWcFsfCDaR/
         +SVtUo08ux7QWRhUwVZ1m+/Seeqa8Qeb5Dqso51jaK8uETsV5bx5bfFFDVMnatedOV5T
         p3kt72n8+w/IzW7VtnxLtXAJ04wX2gSW9wVi2Ziq1/lWD3ubTzkrusMD5dG9aQlHYGJ3
         Y1EbjM6Sxa3TpWRelQ61I6tWN3M074TTjO05Nq1ZFhAWTrbkNcstgNATk/JaXcvijf5a
         +XLA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=VH/RMDANNgufs0IYruko/PMoL7ljoxsam8g8QTtUKOc=;
        b=jtz28bqFp3RDdCZ9Uut/Mh1iA3jHkHVnTKba4Oxy25Q+BmGinZTzFn6nZT6rStORPE
         4mOMCdXYBj8ADHrDhpoNMsfOy/oC0RpY64oviusrUz3U7vWfDht8uunTCpedH1X818zn
         N+mS21gzMdD7XYBKgSkUQsVsze0pqFT0EhXP4Lk89OD3COepe1kXe0N8u0Yhon9an2Rc
         wwr4RlszLDXbZ00ZcuZ4upYCDdCWLGOkfq+Ki8Yy/YrN7yw7EsChAT7kxgsHl+TV92Fi
         tUv42Sw/DxmX4Gah7M04UK4P8/zC+pqw0dC/JXqkNcaoko7ak0VgvdPQwC3g2IY3ZvnR
         meQg==
X-Gm-Message-State: APjAAAVpUjupN5B9Wtyt76zTYGATxJI1Dys8Gz4f1FgvpbJtNfkLDimQ
        S8cvSH6Z6/an2JU8UPR2cWKBlVA3dK5n6obzkAVY8JRJ
X-Google-Smtp-Source: APXvYqxu5lpdJa/Qz36m+RpaQCP8HdwXQjxVPN3un9gQe8Gk4usXWdoeeoJp71ke54p16u3+Y0MRu9uR9548CHko7vk=
X-Received: by 2002:a24:56c1:: with SMTP id o184mr12092670itb.123.1558006938468;
 Thu, 16 May 2019 04:42:18 -0700 (PDT)
MIME-Version: 1.0
References: <CAJFQqN+Z9eX6onaj8vVSqpvf-nOC7-Y0Un4NLUie6x6bGfmvZA@mail.gmail.com>
 <CACsJy8DnkjuZD-9pbhAsFo16jHKt8U831LLxb3-nCQP5_FOmtA@mail.gmail.com> <CAPig+cTQrF1W4LEgOiEoKn4f69OEygFat=4V8aTzf0Rxom2hEw@mail.gmail.com>
In-Reply-To: <CAPig+cTQrF1W4LEgOiEoKn4f69OEygFat=4V8aTzf0Rxom2hEw@mail.gmail.com>
From:   Duy Nguyen <pclouds@gmail.com>
Date:   Thu, 16 May 2019 18:41:51 +0700
Message-ID: <CACsJy8BXxVggL7CWA5Q0d7U4B+encfZ85NshxLJ=VvHhf_LUYg@mail.gmail.com>
Subject: Re: Running 'git worktree add' in 'pre-commit' hook
To:     Eric Sunshine <sunshine@sunshineco.com>
Cc:     Cosmin Polifronie <oppturbv@gmail.com>,
        Git Mailing List <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, May 16, 2019 at 6:33 PM Eric Sunshine <sunshine@sunshineco.com> wrote:
> I researched this also and concluded that it's a bug in git-commit.
> You run afoul of it in other situations, as well. For instance, say
> you have your index file in a non-standard location:
>
>     $ export GIT_INDEX_FILE=../storage/index
>     $ git worktree add --detach other
>     Preparing worktree (detached HEAD c9156d2)
>     fatal: Unable to create '/.../foo/other/../storage/index.lock': No
> such file or directory
>     $
>
> I think the correct fix is for git-commit to assign GIT_INDEX_FILE
> with the absolute path to the index file, not a relative path.

Oh if it's relative $GIT_INDEX_FILE then I think its our environment.c
code that does not work so well when we chdir() away. I vaguely recall
something about this when discussing Jeff's chdir-notify series. But
it turns out that's about chdir() in run-command.c [1]. But the idea
is still the same, all variables are supposed to be relative to $CWD.
Whenever you move $CWD you should reparent all of them, including
$GIT_INDEX_FILE.

[1] https://public-inbox.org/git/CACsJy8CdqpNOw+zdMyugX-902Z=gLNij5_xcmE4jGLRBTqiO1g@mail.gmail.com/
-- 
Duy
