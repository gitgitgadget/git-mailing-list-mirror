Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-11.6 required=3.0 tests=AWL,BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,USER_IN_DEF_DKIM_WL shortcircuit=no
	autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 556A21F453
	for <e@80x24.org>; Wed, 31 Oct 2018 21:12:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729998AbeKAGMR (ORCPT <rfc822;e@80x24.org>);
        Thu, 1 Nov 2018 02:12:17 -0400
Received: from mail-lj1-f180.google.com ([209.85.208.180]:42523 "EHLO
        mail-lj1-f180.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726023AbeKAGMR (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 1 Nov 2018 02:12:17 -0400
Received: by mail-lj1-f180.google.com with SMTP id f3-v6so16187844ljk.9
        for <git@vger.kernel.org>; Wed, 31 Oct 2018 14:12:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=+I7LUGdz80AAK3EUJ+6dF8Q+vwMTACS34krZYUg8cWA=;
        b=k4ygMut+17t1g4vpnbgl1EN7ih+e0YF9Uu+wHHLyuzfi1BiuLs6ofN63B9qSgKWLPy
         l+79Z9ArgX24lzdKAPbgwh/3g+y6UiCSwDnwv6YJU4OQRxvOs8vAfl6BgA4VylGJfFxx
         iwdvYMYo5++sGq1reH8XBre0sB7AFiJSAkXnZBEHZQTEdcf9QvgCDQaSZUGX6TGUPf1A
         UFkqHY8qRprBDn7S2S/EsPktCbrtCBbqMlzJOUGXDmk4w5nSyuqJDSaY4AIC7T5NexQp
         4CRlXVyVsXJQ7M0eRxjIjhqDzDtSq7aoUbctnx27nO/TkkJReWDA+KRi3/DG3GX4yPMc
         Mpfg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=+I7LUGdz80AAK3EUJ+6dF8Q+vwMTACS34krZYUg8cWA=;
        b=ZWk/DAViw2nKaAmxwlFbLpWwc0Hwf3BX//lexLFOkRHNjkhcwb4tQRwr4oq9gohe6I
         Uw1JvoVrVgUo6J4pVntsYFwK1qzuBMG+UNxvKxpdKF0T8hOo5Lt136mekiiIf3/bL5fY
         HttUhVwFV7orGBG5FD/puyw75vYfj6U4ZY5AWoaQSI3yMcFCTuT8ytCewWa+nHEofjtv
         5fdlBeZ5obonpyDW00Zf51yApHGqPOwn3UhMFPnRZQwgSwxLTjyu6p4gq6UZ6fVY9p49
         uTtcDOe9JDZHmtTWoDKuV4jkTzT7ImuwYXdxZoU5xiAIkZFTq2GHMRQNkeyLf40OPnu9
         Zblw==
X-Gm-Message-State: AGRZ1gIwLFV/VBDv6ZeTBkF9nJ5KStE5sk7yTb4mRu49xJW1PgHAfuRW
        nSYmzkzX6kkOmJHC5kSdEDCV6rmnOK3FfGa58zJZwA==
X-Google-Smtp-Source: AJdET5dkWAks1+Fb/Y5j0uxTK/nAQinoJxhDV+O7SrnENMv3cfNzQ8t9OdZq5AS8i8cTtUBLI/BrfzvwcNnurBclYDE=
X-Received: by 2002:a2e:568b:: with SMTP id k11-v6mr3174884lje.105.1541020348095;
 Wed, 31 Oct 2018 14:12:28 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a2e:3e07:0:0:0:0:0 with HTTP; Wed, 31 Oct 2018 14:12:27
 -0700 (PDT)
In-Reply-To: <5539c3ab-9c55-fc9a-6e78-9ab128cc30bc@gmail.com>
References: <CAPL8ZivFmHqS2y+WmNR6faRMnuahiqwPVYsV99NiJ1QLHOs9fQ@mail.gmail.com>
 <5539c3ab-9c55-fc9a-6e78-9ab128cc30bc@gmail.com>
From:   Stefan Xenos <sxenos@google.com>
Date:   Wed, 31 Oct 2018 14:12:27 -0700
Message-ID: <CAPL8ZitjHCT=28K0Yuc4UhhvU8ut33k2vedHWMetJBzMd-D4tw@mail.gmail.com>
Subject: Re: Git Evolve
To:     Derrick Stolee <stolee@gmail.com>
Cc:     git@vger.kernel.org, Stefan Beller <sbeller@google.com>,
        Jonathan Nieder <jrnieder@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Sorry it's taken awhile for me to get back to this thread. I've been
keeping my open source contributions timeboxed, and had to work
through a bit of a backlog before this email thread got back to the
front of the queue.

> What would the command-line experience look like for this workflow? Be specific, including examples!

Yes, I agree that's critical. I'm not going to try to improvise an
answer over email, but I will be sure to include such examples when I
submit the patch to Documentation/technical, after some careful
thought.

> How does one create a commit that obsoletes another?

I was planning to classify all git commands that create commits as
either "modifications" or "clones". Modification commands (such as
rebase or commit --amend) would automatically obsolete their
predecessors. Clone commands (such as cherry-pick) would create copies
without obsoleting the original.

> Are we in the middle of an interactive rebase, or are we simply checking out the commit?

To obsolete a commit, you'd just check it out and amend. You really
wouldn't want to have to do anything extra or put yourself in a
special mode to mark things as obsolete or they wouldn't be much of a
convenience. However, if you were to run the "evolve" command (the
thing that reads the obsolescence markers) and it encountered errors,
you'd be in the middle of something very much like an interactive
rebase.

> How does a use keep track of their progress in a topic?
> How do I view which commits in my topic are obsolete, and to what commits?
> Do obsolescence markers live in the ref space? (This is one way to help answer the question above.)

The answers to these questions are more complicated. I'll be sure to
address them in the technical proposal, but I wouldn't want create a
misunderstanding with an incomplete explanation.

> Can I make multiple commits obsolete into one commit (merge patches)? Can I make my commit obsolete in multiple ways (split a patch)? How is this communicated to the user?

Yes and yes. When a single commit is obsoleted by one or more
non-obsolete commits, this is called divergence and it needs to be
resolved by the user (the evolve command will stop when it encounters
divergence, much like a rebase will stop when it encounters a merge
conflict). Possible resolutions are to discard one of the two
non-obsolete commits by marking them as obsolete, merge the two, or
keep both by cloning one of them and marking it as no longer
obsoleting its predecessor.

Unnecessary divergence isn't a good thing since it requires user
intervention to resolve. Splitting a patch doesn't need to create
divergence (and probably shouldn't). If you split a commit, the
earlier one would be a completely new commit and the latter one would
obsolete the original. Doing it the other way around creates a merge
conflict between the later commit and anything that followed the
original. If both commits obsolete the original, it creates divergence
- and either divergence or a merge would get the user involved
unnecessarily.

A more likely scenario where divergence would occur is of two
different users try to amend the same commit and then share their
results -- or if a user amends a commit, resets back to the original,
and then amends it again.

> Count me in to review the technical details.

Will do!

On Mon, Oct 1, 2018 at 5:37 AM, Derrick Stolee <stolee@gmail.com> wrote:
> On 9/29/2018 7:00 PM, Stefan Xenos wrote:
>>
>> Hello, List!
>
>
> Hello! Welcome.
>
>> I'm interested in porting something like Mercurial's evolve command to
>> Git. I'll be following up with a formal proposal shortly, but before I
>> do I thought I'd introduce myself to the list and find out if anyone
>> else is interested in this topic.
>
>
> I'm CC'ing some contributors who have also expressed interest in this topic.
>
>> What is the evolve command?
>
>
> I'm snipping the rest of your thread because I'm vaguely familiar with how
> this is used in hg, but I haven't used it myself. Instead, I'm going to ask
> you the same questions I asked the last time I had a conversation about this
> with someone. In my opinion, these questions should have good answers before
> we start working on the solution, or else we could paint ourselves into a
> corner as we build the first pieces.
>
> ---
>
> What would the command-line experience look like for this workflow? Be
> specific, including examples!
>
> How does one create a commit that obsoletes another? Are we in the middle of
> an interactive rebase, or are we simply checking out the commit? How does a
> use keep track of their progress in a topic?
>
> How do I view which commits in my topic are obsolete, and to what commits?
>
> If I want to obsolete commits on one machine and then finish the work on
> another machine, how do I do that? Similarly: how can I share obsolete
> commits with other users so they can apply them (or not)?
>
> Do obsolescence markers live in the ref space? (This is one way to help
> answer the question above.)
>
> Can I make multiple commits obsolete into one commit (merge patches)? Can I
> make my commit obsolete in multiple ways (split a patch)? How is this
> communicated to the user?
>
> ---
>
> In my opinion, a good way to move forward is to create a patch that adds a
> design document to Documentation/technical that answers these questions.
> Then we can dig in more to make the vision clearer.
>
> I'm not a UX expert, but this seems like a place where we could use someone
> with expertise in the area. If we are not careful, we could end up with
> something even harder to use than interactive rebase. The main goal here is
> to make it easy to rewrite a topic (plus, the ability to do so in stages).
>
> I look forward to see what goes on in this space. Count me in to review the
> technical details.
>
> Thanks,
> -Stolee
