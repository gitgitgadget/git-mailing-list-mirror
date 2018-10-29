Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 1E9931F454
	for <e@80x24.org>; Mon, 29 Oct 2018 05:44:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729136AbeJ2ObL (ORCPT <rfc822;e@80x24.org>);
        Mon, 29 Oct 2018 10:31:11 -0400
Received: from mail-qt1-f194.google.com ([209.85.160.194]:44992 "EHLO
        mail-qt1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729098AbeJ2ObL (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 29 Oct 2018 10:31:11 -0400
Received: by mail-qt1-f194.google.com with SMTP id b22-v6so7872955qtr.11
        for <git@vger.kernel.org>; Sun, 28 Oct 2018 22:44:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=yev5dZ4Pc9n4YYF8FMHCmotg7k1dvnU8/dJ1BUE5RI0=;
        b=Hjln+jW1kN9BeWMfHgS90FK8tIJxdsVHnpCLlFeuP5Nl/NkXPaNPSMEkkigyLnr2k4
         u4TfTS7QbNmHhEIH30eWBrTGkiFylaFSGKfOYCvQMQ1psAAxPAf3SiFTChulPDqowjuj
         fkUtP+leooaz1zk3scGXZvekUSgt3wysA7S8P03XBll2y0WO3T5CcBO99a3qa2SBvMWx
         3/PYv0BlofSuTppCYd3v/yYr+G3rsWpogFW8w5pFm7bYeJvCjj6TN0f3Xtfq0mlJzl6e
         P4nSBeltVVDYyHPRoBHE2Q0+Y8kRihnDBFZnaUy7JjKLJikkEFdjVh5dfomSp0lk5cqk
         8Isw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=yev5dZ4Pc9n4YYF8FMHCmotg7k1dvnU8/dJ1BUE5RI0=;
        b=Eh9z2kyke8hV7XV1UrUjUGCmzarbQGdvNDkCGmpZHoaT7oETPmhCF9zJ4Qj6xXLbes
         BtOfBZqh/3b5FcBu4j39WOZEShZv4BLUEGPt/R2J7NjUQue3DVW59aMzxPcnfsvcGpqr
         34P+jqNZ769E3jlEvR6JJ8W0Pw86mCkpekAXYpNqRCOQ2f8fs5FEACb4+cpDWHiT/+R2
         zSDua77pVQThSNZZINMnwCI1kV2QvqvG77W8jqR55jNrTHSk0wjdWTnV8c78iom2ZC/p
         J8ufHOC5MtgEus6BbgYR8wYkcgdb/f6a4cVOqL/zvIt8LMrlUP6HRNfyDQydYn6jkJs6
         rEIA==
X-Gm-Message-State: AGRZ1gIiJp0bOfsAZVD2tDFHfXKuNxd/FygRCfQ/OnSZ+Dn0YPEzAdcO
        O2LtmmVMhZnx+gYGmwnpU8kPzzHxn8a+ql8nMnw=
X-Google-Smtp-Source: AJdET5dKIGIrh/X13ZOVfpQyLMyuyJb4FxMlQLgm/9dTuGmX7Ny7zAME44XNkXQutS8mNRF5XGgEGHxq0D4B1bSLsR0=
X-Received: by 2002:a0c:bf08:: with SMTP id m8mr11937430qvi.30.1540791841863;
 Sun, 28 Oct 2018 22:44:01 -0700 (PDT)
MIME-Version: 1.0
References: <CAC05386F1X7TsPr6kgkuLWEwsmdiQ4VKTF5RxaHvzpkwbmXPBw@mail.gmail.com>
 <20181025055142.38077-1-nbelakovski@gmail.com> <xmqq4ldajz05.fsf@gitster-ct.c.googlers.com>
 <CAC05385y3fCdG4fd2ADahoE0iT+a5KvEr846UCUCQZMOtzzYGg@mail.gmail.com> <xmqq36sp76kw.fsf@gitster-ct.c.googlers.com>
In-Reply-To: <xmqq36sp76kw.fsf@gitster-ct.c.googlers.com>
From:   Nickolai Belakovski <nbelakovski@gmail.com>
Date:   Sun, 28 Oct 2018 22:43:35 -0700
Message-ID: <CAC05386YPtB5LmHFq3WrAaZ1vmZaBUdGr9hEbyR8KABzj+CzZQ@mail.gmail.com>
Subject: Re: [PATCH] worktree: refactor lock_reason_valid and lock_reason to
 be more sensible
To:     Junio C Hamano <gitster@pobox.com>
Cc:     sunshine@sunshineco.com, git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Sun, Oct 28, 2018 at 8:52 PM Junio C Hamano <gitster@pobox.com> wrote:
>
>
> If the field "reason" should always be populated, there is *no*
> reason why we need the "valid" boolean.  They work as a pair to
> realize lazy population of rarely used field.  The lazy evaluation
> technique is used as an optimization for common case, where majority
> of operations do not care if worktrees are locked and if so why they
> are locked, so that only rare operations that do want to find out
> can ask "is this locked and why?" via is_worktree_locked() interface,
> and at that point we lazily find it out by reading "locked" file.
>
> So it is by design that these fields are not always populated, but
> are populated on demand as book-keeping info internal to the API's
> implementation.  It is not "an issue", and changing it is not a
> "fix".

Having fields in a struct that are not populated by a getter function
with no documentation indicating that they are not populated and no
documentation explaining how to populate them is the issue here.

>
> In addition, if we have already checked, then we do not even do the
> same check again.  If in an earlier call we found out that a worktree
> is not locked, we flip the _valid bit to true while setting _reason
> to NULL, so that the next call can say "oh, that's not locked and we
> can tell that without looking at the filesystem again" [*1*].

I clearly misunderstood the use case of the _valid flag, thanks for
pointing it out.

>
> You are forcing the callers of get_worktrees() to pay the cost to
> check, open and read the "why is this worktree locked?" file for all
> worktrees, whether they care if these worktrees are locked or why
> they are locked.  Such a change can be an improvement *ONLY* if you
> can demonstrate that in the current code most codepaths that call
> get_worktrees() end up calling is_worktree_locked() on all worktrees
> anyways.  If that were the case, not having to lazily evaluate the
> "locked"-ness, but always check upfront, would have a simplification
> value, as either approach would be spending the same cost to open
> and read these "locked" files.
>
> But I do not think it is the case.  Outside builtin/worktree.c (and
> you need to admit "git worktree" is a rather rare command in the
> first place, so you shouldn't be optimizing for that if it hurts
> other codepaths), builtin/branch.c wants to go to all worktrees and
> update their HEAD when a branch is renamed (if the old HEAD is
> pointing at the original name, of course), but that code won't care
> if the worktree is locked at all.  I do not think of any caller of
> get_worktrees() that want to know if it is locked and why for each
> and every one of them, and I'd be surprised if that *is* the
> majority, but as a proposer to burden get_worktrees() with this
> extra cost, you certainly would have audited the callers and made
> sure it is worth making them pay the extra cost?
>
> If we are going to change anything around this area, I'd not be
> surprised that the right move is to go in the opposite direction.
> Right now, you cannot just get "is it locked?" boolean answer (which
> can be obtained by a simple stat(2) call) without getting "why is it
> locked?" (which takes open(2) & read(2) & close(2)), and if you are
> planning a new application that wants to ask "is it locked?" a lot
> without having to know the reason, you may want to make the lazy
> evaluation even lazier by splitting _valid field into two (i.e. a
> "do we know if this is locked?" valid bit covers "is_locked" bit,
> and another "do we know why this is locked?" valid bit accompanies
> "locked_reason" string).  And the callers would ask two separate
> questions: is_worktree_locked() that says true or false, and then
> why_worktree_locked() that yields NULL or string (i.e. essentially
> that is what we have as is_worktree_locked() today).  Of course,
> such a change must also be justified with a code audit to
> demonstrate that only minority case of the callers of is-locked?
> wants to know why
>
>
> [Footnote]
>
> *1* The codepaths that want to know if a worktree is locked or not
> (and wants to learn the reason) are so rare and concentrated in
> builtin/worktree.c, and more importantly, they do not need to ask
> the same question twice, so we can stop caching and make
> is_worktree_locked() always go to the filesystem, I think, and that
> may be a valid change _if_ we allow worktrees to be randomly locked
> and unlocked while we are looking at them, but if we want to worry
> about such concurrent and competing uses, we need a big
> repository-wide lock anyway, and it is the least of our problems
> that the current caching may go stale without getting invalidated.
> The code will be racing against such concurrent processes even if
> you made it to go to the filesystem all the time.
>

Basically, I already implemented most of what you're saying. The v2
proposal does force all callers of get_worktrees to check the lock
status, but by calling stat, not open/read/close. That being said
you're right that even forcing them to call stat when most don't care
is imposing an extra cost for no gain. The v2 proposal no longer
caches the lock reason (in fact it removes it from the worktree
struct), since not only do current users have no need to ask for the
lock_reason twice, none of them ask for it twice in the first place.
The v2 proposal provides a standalone function for getting the actual
reason (leaving it up to callers to cache the result if they like).

I'd be up for removing is_locked from the struct as well and making a
separate standalone function for that.

Either way, I do see an issue with the current code that anybody who
wants to know the lock status and/or lock reason of a worktree gets
faced with a confusing, misleading, and opaque piece of code. I see
two possible remedies:

a) Remove these fields from the worktree struct and provide standalone
functions for answering these questions. Pros are that we follow
single responsibility principle with two standalone functions for
doing so, and we make the route for answering these questions less
circuitous (IMO). Cons are that we remove the caching currently in
place since we're no longer storing this info in the struct, but then
again that caching is not currently being used and can be implemented
by callers if they really need it

b) Update the comments in the code to state that lock_reason and
lock_reason_valid are to be considered private fields and to use
is_worktree_locked for populating them. Pros are that no actual code
changes need to be made. Cons are that, IMO, it's still a strange
piece of code in that it's doing some sort of quasi object oriented
stuff in C, and if we can take the opportunity to make the code look a
bit more canonical I think we should, but that's just my 2 cents.

Of course there's also option c, which is that I leave this alone and
just go back to making my worktree atom :)
