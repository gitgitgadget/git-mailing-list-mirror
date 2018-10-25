Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id D6E021F453
	for <e@80x24.org>; Thu, 25 Oct 2018 05:47:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727284AbeJYOSZ (ORCPT <rfc822;e@80x24.org>);
        Thu, 25 Oct 2018 10:18:25 -0400
Received: from mail-qt1-f194.google.com ([209.85.160.194]:46906 "EHLO
        mail-qt1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726633AbeJYOSZ (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 25 Oct 2018 10:18:25 -0400
Received: by mail-qt1-f194.google.com with SMTP id c16-v6so8469358qtj.13
        for <git@vger.kernel.org>; Wed, 24 Oct 2018 22:47:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=NuLhRjzjQTOesMWnHeMbD7HlKJmlxENkkR+aekomX4U=;
        b=oU1kT9FOTdyedPxdTew3rALYINhjySSq2zkt7EHJbtdVMFylguXjdUnaRdhEXwJ+oB
         6DfozMlQoOKgykHEay5i5We8ElvEeMqKc/2Ewdw4noHL354u/M6pQ56DHhUa65rhY4V6
         +v1fzqVcaHzP7Wo6KZEFN6JbqSQX9yJsvNbVSMZktEm8dN9yhQMnpj6a4JPLBgtFy7/2
         sODnqnrXaa9dTTCPqHC8eNwDfBltMS2Cw3xymhRoiQ4TTRDTstZkguKkBSw1HTcgBTJH
         s5tJkZSKUz1+KP9ncD1lNwdA2C6tWIN6KyI7FmganIXb8ya7s4k3FzXj4QiT5BiEnBlJ
         zGoA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=NuLhRjzjQTOesMWnHeMbD7HlKJmlxENkkR+aekomX4U=;
        b=Yhg40rFOxOX+nICfWg4OEgX/BDYa5zTEBBmoMQ+D05zX+yfIlvkdj6iaLOhEeDlyv4
         pDly8lKf++xJFuOuuOG5TB7g3GH50WTwjm3LHx8YifKyYAQeEgzjfOmK9c+gSGEio+u2
         P6QFG6HqX2wVQkjicyhk4DMC+9QtezqunSb8tUBOIgJ52c8TIRZpJ7tHZXQvvFOYwU5/
         +78satdUmOtH4DNHnlwY8bRaTePFU2WqVN+tLGOMBNLjAs8QvoxFvl9LQ90SNYGSksE4
         tbMMg/AAx1sdhWkqti8dLhSy79sIOUdfZhxrIb9kcDdluqWZ6Nn5SYIowiGNF1MWhtUi
         sl7g==
X-Gm-Message-State: AGRZ1gJJnDlZqao4bhW7QCMCIIYZ1GM27+Dmm+endTZyNJSdgEDtZD6X
        XlSA9LmSCfvpUw3XnsXrROyBIYpt5Vooqjhrz1o=
X-Google-Smtp-Source: AJdET5dXMUHXRE5oO1EHvNOuuPofLfNyxDCCaQ/9ZG8FVJd/PZOIeX4orQxr5/VJs1seY203EIO+B0f5khq/spZKJQs=
X-Received: by 2002:ac8:740a:: with SMTP id p10-v6mr171525qtq.65.1540446434962;
 Wed, 24 Oct 2018 22:47:14 -0700 (PDT)
MIME-Version: 1.0
References: <20181024063904.36096-1-nbelakovski@gmail.com> <CAPig+cRN_0VVe6dzhnmU73pgo-8ncPzmOx4bRrTBVvReLW6RfQ@mail.gmail.com>
In-Reply-To: <CAPig+cRN_0VVe6dzhnmU73pgo-8ncPzmOx4bRrTBVvReLW6RfQ@mail.gmail.com>
From:   Nickolai Belakovski <nbelakovski@gmail.com>
Date:   Wed, 24 Oct 2018 22:46:48 -0700
Message-ID: <CAC05386F1X7TsPr6kgkuLWEwsmdiQ4VKTF5RxaHvzpkwbmXPBw@mail.gmail.com>
Subject: Re: [PATCH] worktree: populate lock_reason in get_worktrees and light
 refactor/cleanup in worktree files
To:     sunshine@sunshineco.com
Cc:     git@vger.kernel.org, pclouds@gmail.com,
        Michael Rappazzo <rappazzo@gmail.com>,
        Junio C Hamano <gitster@pobox.com>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

The motivation for the change is some work that I'm doing to add a
worktree atom in ref-filter.c. I wanted that atom to be able to access
all fields of the worktree struct and noticed that lock_reason wasn't
getting populated so I figured I'd go and fix that.

I figured that since get_worktrees is already hitting the filesystem
for the directory it wouldn't matter much if it also went and got the
lock reason.

Reviewing this work in the context of your feedback and Junio's
previous comments, I think it makes sense to only have a field in the
struct indicating whether or not the worktree is locked, and have a
separate function for getting the reason. Since the only cases in
which the reason is retrieved in the current codebase are cases where
the program immediately dies, caching seems a moot point. I'll send an
updated patch just after this message.

Thanks for the feedback, happy to receive more.
On Wed, Oct 24, 2018 at 1:11 AM Eric Sunshine <sunshine@sunshineco.com> wrote:
>
> On Wed, Oct 24, 2018 at 2:39 AM <nbelakovski@gmail.com> wrote:
> > lock_reason is now populated during the execution of get_worktrees
> >
> > is_worktree_locked has been simplified, renamed, and changed to internal
> > linkage. It is simplified to only return the lock reason (or NULL in case
> > there is no lock reason) and to not have any side effects on the inputs.
> > As such it made sense to rename it since it only returns the reason.
> >
> > Since this function was now being used to populate the worktree struct's
> > lock_reason field, it made sense to move the function to internal
> > linkage and have callers refer to the lock_reason field. The
> > lock_reason_valid field was removed since a NULL/non-NULL value of
> > lock_reason accomplishes the same effect.
> >
> > Some unused variables within worktree source code were removed.
>
> Thanks for the submission.
>
> One thing which isn't clear from this commit message is _why_ this
> change is desirable at this time, aside from the obvious
> simplification of the code and client interaction (or perhaps those
> are the _why_?).
>
> Although I had envisioned populating the "reason" field greedily in
> the way this patch does, not everyone agrees that doing so is
> desirable. In particular, Junio argued[1,2] for populating it lazily,
> which accounts for the current implementation. That's why I ask about
> the _why_ of this change since it will likely need to be justified in
> a such a way to convince Junio to change his mind.
>
> Thanks.
>
> [1]: https://public-inbox.org/git/xmqq8tyq5czn.fsf@gitster.mtv.corp.google.com/
> [2]: https://public-inbox.org/git/xmqq4m9d0w6v.fsf@gitster.mtv.corp.google.com/
