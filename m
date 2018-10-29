Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 645001F453
	for <e@80x24.org>; Mon, 29 Oct 2018 01:11:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726008AbeJ2J5n (ORCPT <rfc822;e@80x24.org>);
        Mon, 29 Oct 2018 05:57:43 -0400
Received: from mail-qt1-f195.google.com ([209.85.160.195]:34665 "EHLO
        mail-qt1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725969AbeJ2J5n (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 29 Oct 2018 05:57:43 -0400
Received: by mail-qt1-f195.google.com with SMTP id z2-v6so7484778qts.1
        for <git@vger.kernel.org>; Sun, 28 Oct 2018 18:11:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=5VIy2MD6mEg3eSliTNGH0DrtXR+nzOryIhVc1qGIlVk=;
        b=NBz98rmy8+HJ5xifEPsXQ49lQPXp/ATsqF/8Lcc/+VEyt5VRjgFZC+An1zOoWyy9Gw
         czFYmveFziKHleb6KfoyNPUth1DsVskXaVhljLZmbULyksNzk/1fkiou4wLTH74p+3p2
         7pMQ+oP0jKh6hjdL0rQQG1NWbcbvCYKEr0YlnUbjdiRjsMRxp6Pu0DS+Sm0cRFGCfPvm
         vAxY07d1oIzS4f45Uj4zuUljj8Hsn2Wj1U68VbyERBss2bcOW3bmFdTA/sFUW1wrjZtz
         ss3KBdUim2Vn1n+N7bO0L7uNlsS7GMFniPH1/zRxOEks0V+4OlwqWlmSQQyOrrDPRKDT
         AFvA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=5VIy2MD6mEg3eSliTNGH0DrtXR+nzOryIhVc1qGIlVk=;
        b=LlhUKhzCjoi1h4609rkuEZ0Et942L/6r89TAK7vKHAXVAPvCQVwHsSc0Ham/M5JdWK
         d90xtyQa1uGPZ9w8bFQZf+XUlUhGSZ4K8PtIAWL6xTsciIevHJyLttBceFXTVub3F/ZF
         8mvXwwc9LFmpir2F9P6Spzt6smNWNZB4c/YvLB2cs3xtrRU6fkk8jC2EYmokgpXjK8dY
         OxVKHGyUg2j8DKMbrijBQZj+pSPNZC+hDCNWd4ObcE07JYzGKHuJzHNuHhQeJn3akro0
         9vb5lFXiCq6mBxKyNDHw5uVheH3OTZOckX8a3y0R2ceL191xB2QqX9bSol6R3ekvRqH1
         l8Eg==
X-Gm-Message-State: AGRZ1gJrAAkiI5xcaLUOfGXV/5oDX72AM0mBCQ2I65qOuKgQsrgH8Igb
        IhN9h7PMf8yjnD3Oo3AgLB0dXQ1WBcE1+CROar0=
X-Google-Smtp-Source: AJdET5elk1xkm7KjBG+GfRXPU74aGvbvo0zxuKnZDqiL3N7OII13v21MjPVa9Ke0JRF9g20xeKUF4StUb1KZWP+N1Jw=
X-Received: by 2002:ac8:19a7:: with SMTP id u36-v6mr10535668qtj.86.1540775481166;
 Sun, 28 Oct 2018 18:11:21 -0700 (PDT)
MIME-Version: 1.0
References: <CAC05386F1X7TsPr6kgkuLWEwsmdiQ4VKTF5RxaHvzpkwbmXPBw@mail.gmail.com>
 <20181025055142.38077-1-nbelakovski@gmail.com> <xmqq4ldajz05.fsf@gitster-ct.c.googlers.com>
 <CAC05386cSUhBm4TLD5NUeb5Ut9GT5=h-1MvqDnFpuc+UdZFmwg@mail.gmail.com> <CAPig+cT1XYt60PsRGJ0FUa_qCn1vPjdXHygsWzYZYg2Ey=yqkg@mail.gmail.com>
In-Reply-To: <CAPig+cT1XYt60PsRGJ0FUa_qCn1vPjdXHygsWzYZYg2Ey=yqkg@mail.gmail.com>
From:   Nickolai Belakovski <nbelakovski@gmail.com>
Date:   Sun, 28 Oct 2018 18:10:54 -0700
Message-ID: <CAC05387mfDhJ5_=LyzxZZX09MoY1hsmSB1gseNeLCmMOUx2O4A@mail.gmail.com>
Subject: Re: [PATCH] worktree: refactor lock_reason_valid and lock_reason to
 be more sensible
To:     sunshine@sunshineco.com
Cc:     Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org,
        pclouds@gmail.com
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Sun, Oct 28, 2018 at 4:03 PM Eric Sunshine <sunshine@sunshineco.com> wrote:
>
> On Sun, Oct 28, 2018 at 5:55 PM Nickolai Belakovski
> > <nbelakovski@gmail.com> wrote: This was meant to be a reply to
> > https://public-inbox.org/git/CAC05386F1X7TsPr6kgkuLWEwsmdiQ4VKTF5RxaHvzpkwbmXPBw@mail.gmail.com/T/#m8898c8f7c68e1ea234aca21cb2d7776b375c6f51,
> > please look there for some more context. I think it both did and
> > didn't get listed as a reply? In my mailbox I see two separate
> > threads but in public-inbox.org/git it looks like it correctly got
> > labelled as 1 thread. This whole mailing list thing is new to me,
> > thanks for bearing with me as I figure it out :).
>
> Gmail threads messages entirely by subject; it doesn't pay attention
> to In-Reply-To: or other headers for threading, which is why you see
> two separate threads. public-inbox.org, on the other hand, does pay
> attention to the headers, thus understands that all the messages
> belong to the same thread. Gmail's behavior may be considered
> anomalous.
>

Got it, thanks!

> > Next time I'll make sure to change the subject line on updated
> > patches as PATCH v2 (that's the convention, right?).
>
> That's correct.
>

(thumbs up)

> > This is an improvement because it fixes an issue in which the fields
> > lock_reason and lock_reason_valid of the worktree struct were not
> > being populated. This is related to work I'm doing to add a worktree
> > atom to ref-filter.c.
>
> Those fields are considered private/internal. They are not intended to
> be accessed by calling code. (Unfortunately, only 'lock_reason' is
> thus marked; 'lock_reason_valid' should be marked "internal".) Clients
> are expected to retrieve the lock reason only through the provided
> API, is_worktree_locked().
>
> > I see your concerns about extra hits to the filesystem when calling
> > get_worktrees and about users interested in lock_reason having to
> > make extra calls. As regards hits to the filesystem, I could remove
> > is_locked from the worktree struct entirely. To address the second
> > concern, I could refactor worktree_locked_reason to return null if
> > the wt is not locked. I would still want to keep is_worktree_locked
> > around to provide a facility to check whether or not the worktree is
> > locked without having to go get the reason.
> >
> > There's also been some concerns raised about caching. As I pointed
> > out in the other thread, the current use cases for this information
> > die upon accessing it, so caching is a moot point. For the use case
> > of a worktree atom, caching would be relevant, but it could be done
> > within ref-filter.c. Another option is to add the lock_reason back
> > to the worktree struct and have two functions for populating it:
> > get_worktrees_wo_lock_reason and get_worktrees_with_lock_reason. A
> > bit more verbose, but it makes it clear to the caller what they're
> > getting and what they're not getting. I might suggest starting with
> > doing the caching within ref-filter.c first, and if more use cases
> > appear for caching lock_reason we can consider the second option. It
> > could also be get_worktrees and get_worktrees_wo_lock_reason, though
> > I think most callers would be calling the latter name.
> >
> > So, my proposal for driving this patch to completion would be to:
> > -remove is_locked from the worktree struct
> > -refactor worktree_locked_reason to return null if the wt is not locked
> > -refactor calls to is_locked within builtin/worktree.c to call
> > either the refactored worktree_locked_reason or is_worktree_locked
>
> My impression, thus far, is that this all seems to be complicating
> rather than simplifying. These changes also seem entirely unnecessary.
> In [1], I made the observation that it seemed that your new ref-filter
> atom could be implemented with the existing is_worktree_locked() API.
> As far as I can tell, it can indeed be implemented without having to
> make any changes to the worktree API or implementation at all.
>
> The worktree API is both compact and orthogonal, and I haven't yet
> seen a compelling reason to change it. That said, though, the API
> documentation in worktree.h may be lacking, even if the implementation
> is not. I'll say a bit more about that below.
>
> > In addition to making the worktree code clearer, this patch fixes a
> > bug in which the current is_worktree_locked over-eagerly sets
> > lock_reason_valid. There are currently no consumers of
> > lock_reason_valid within master, but obviously we should fix this
> > before they appear :)
>
> As noted above, 'lock_reason_valid' is private/internal. It's an
> accident that it is not annotated such (like 'lock_reason', which is
> correctly annotated as "internal"). So, there should never be any
> external consumers of that field. It also means that there is no bug
> in the current code (as far as I can see) since that field is
> correctly consulted (internally) to determine whether the lock reason
> has been looked up yet.

Thank you for explaining this. Looking at the code now it seems
crystal clear, but, yea I clearly got on the wrong path initially.

>
> The missing "internal only" annotation is unfortunate since it may
> have led you down this road of considering the implementation and API
> broken.
>
> Moreover, the documentation for is_worktree_locked() apparently
> doesn't convey strongly enough that it serves the dual purpose of (1)
> telling you whether or not the worktree is locked, and (2) telling you
> the reason it is locked.
>
> A patch which adds the missing "internal only" annotation to
> 'lock_reason_valid', and which makes it easier to understand the dual
> purpose of is_worktree_locked() would be welcome, especially if it
> helps avoid such confusion in the future.
>
> Aside from that, it doesn't seem like worktree needs any changes for
> the ref-filter atom you have in mind. (Don't interpret this
> observation as me being averse to changes to the API; I'm open to
> improvements, but haven't seen anything yet indicating a bug or
> showing that the API is more difficult than it ought to be.)
>
> [1]: https://public-inbox.org/git/CAPig+cTvKd2DVu7wW_A31p_o7BaNJszu14kNRz9sqk8h45H4-g@mail.gmail.com/

You're right that these changes are not necessary in order to make a
worktree atom.

If there's no interest in this patch I'll withdraw it.

I had found it really surprising that lock_reason was not populated
when I was accessing it while working on the worktree atom. When
digging into it, the "internal use" comment told me nothing, both
because there's no convention (that I'm aware of) within C to mark
fields as such and because it fails to direct the reader to
is_worktree_locked.

How about this, I can make a patch that changes the comment next to
lock_reason to say "/* private - use is_worktree_locked */" (choosing
the word "private" since it's a reserved keyword in C++ and other
languages for implementation details that are meant to be
inaccessible) and a comment next to lock_reason_valid that just says
"/* private */"? I would also suggest renaming is_worktree_locked to
worktree_lock_reason, the former makes me think the function is
returning a boolean, whereas the latter more clearly conveys that a
more detailed piece of information is being returned.

Lemme know what you think.
