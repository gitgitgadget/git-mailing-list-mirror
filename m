Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.6 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 259EF1F403
	for <e@80x24.org>; Tue, 12 Jun 2018 15:46:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754319AbeFLPqw (ORCPT <rfc822;e@80x24.org>);
        Tue, 12 Jun 2018 11:46:52 -0400
Received: from mail-vk0-f66.google.com ([209.85.213.66]:34808 "EHLO
        mail-vk0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754056AbeFLPqv (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 12 Jun 2018 11:46:51 -0400
Received: by mail-vk0-f66.google.com with SMTP id q135-v6so14685671vkh.1
        for <git@vger.kernel.org>; Tue, 12 Jun 2018 08:46:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=8T3XchEXaQSzTeq+LmOT08gGSbxUrl98y7H+/KIN3Tc=;
        b=gBv53mVXcyP3Ndx3HpGu7Ur2LvIf1NudDOWQS1ZiCVvnedsTvlTW9uw2CUpdkNvmZt
         J+B8UvdtPYrkQiJ+8n1s0DDBtfkA5r/E3ZR86d2UOb7HwVOr5zZx56zWKbN0Vz+FgWgN
         iLOJZjy1Ew50d4cLgOc1WjhmQj1J7BAF+Jkp2CYCW6SwAs93fWrFCp9kNr0u0J24WcEm
         xlFNLs5WaT+sc45fAiy/T7cqk5Xf8WC5I+m9nQc1Iy81I/sIuS/WDc/tqCITsKCREvaF
         MI7ktqjVx8iUj0HygQkCfJ9ijQW8LrG0CIUqQ0GVVeU+/BYtQHQOgIgSqMZ1rThcLPdP
         DQdA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=8T3XchEXaQSzTeq+LmOT08gGSbxUrl98y7H+/KIN3Tc=;
        b=FDIRgUj0ym56JkYkNBS9XnV+q7bt7jg7829bL8QZOBj3s1x3u2xrfsf17Jn3vB8RQa
         W60g+OV/6aQUTBvC5gFQiW2PhVAtLsKSnvAh+HEd4p6o5ePAy5DaJ4YFd4YObCAO3pbb
         JiL/ZYxZvtpoBEJYYcQqJy+j63M5g8R7SIlREF7gsBzBk5puDJ328j3eK3oqzlL0ZIVe
         EG6GTKpZnFgzHCTQ0WAoXqSfjLC1lP62TKAwCtKpq6xiQnBEwRAJzUFTBsxgWxvMEQmd
         j+X69TyUEXOUA/5ctccme/xSGporpLUUn0jm+ibAbSfpiiNUwGXnxiuSzkg+fMMsdjrz
         Jd3A==
X-Gm-Message-State: APt69E02/fEh0ITN6CKG1tQth3AS+AdVJEnPMM3nKGud5WxswGZ/bJfL
        6FmeiB1u7YtkRUpZkdN/JgytN2DuK0m6/7G97eY=
X-Google-Smtp-Source: ADUXVKKviMsaRcH4LupK6xLp0YpX+pv7N52puTJnKkkKW0yO0NOHPhMe9FxEhU+eG7N0nL8eO4SbUcEaKDXAbY/RbAM=
X-Received: by 2002:a1f:e483:: with SMTP id b125-v6mr605322vkh.149.1528818410525;
 Tue, 12 Jun 2018 08:46:50 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:ab0:5f28:0:0:0:0:0 with HTTP; Tue, 12 Jun 2018 08:46:49
 -0700 (PDT)
In-Reply-To: <20180611135714.29378-2-alban.gruin@gmail.com>
References: <20180611135714.29378-1-alban.gruin@gmail.com> <20180611135714.29378-2-alban.gruin@gmail.com>
From:   Elijah Newren <newren@gmail.com>
Date:   Tue, 12 Jun 2018 08:46:49 -0700
Message-ID: <CABPp-BHG41ePN1jRxADfb47FnXfKgJ++Jv=DUiTPwpUJUi=C=w@mail.gmail.com>
Subject: Re: [GSoC][PATCH 1/1] rebase--interactive: rewrite the edit-todo
 functionality in C
To:     Alban Gruin <alban.gruin@gmail.com>
Cc:     Git Mailing List <git@vger.kernel.org>,
        Stefan Beller <sbeller@google.com>,
        Christian Couder <christian.couder@gmail.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Phillip Wood <phillip.wood@dunelm.org.uk>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Alban,

On Mon, Jun 11, 2018 at 6:57 AM, Alban Gruin <alban.gruin@gmail.com> wrote:
> This rewrites the edit-todo functionality from shell to C.
>
> To achieve that, a new command mode, `edit-todo`, is added, and the
> `write-edit-todo` flag is removed, as the shell script does not need to
> write the edit todo help message to the todo list anymore.
>
> The shell version is then stripped in favour of a call to the helper.

I looked over the patch and didn't see any problems (though I haven't
worked with rebase--helper before, or the code for todo list editing),
but when I went to apply the patch it failed telling me:

Applying: rebase--interactive: rewrite the edit-todo functionality in C
error: sha1 information is lacking or useless (builtin/rebase--helper.c).
error: could not build fake ancestor
Patch failed at 0001 rebase--interactive: rewrite the edit-todo
functionality in C
Use 'git am --show-current-patch' to see the failed patch

I tried each of master, next, and pu (as of today) to see if it might
apply there.  On which commit is this patch based?  (Do you have other
local commits that this was based on top of?)


Elijah
