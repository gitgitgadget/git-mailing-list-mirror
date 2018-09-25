Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-11.5 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI,USER_IN_DEF_DKIM_WL shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 1F6611F453
	for <e@80x24.org>; Tue, 25 Sep 2018 16:24:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729934AbeIYWc5 (ORCPT <rfc822;e@80x24.org>);
        Tue, 25 Sep 2018 18:32:57 -0400
Received: from mail-yw1-f65.google.com ([209.85.161.65]:36459 "EHLO
        mail-yw1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728825AbeIYWc4 (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 25 Sep 2018 18:32:56 -0400
Received: by mail-yw1-f65.google.com with SMTP id e201-v6so3494912ywa.3
        for <git@vger.kernel.org>; Tue, 25 Sep 2018 09:24:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=saO1Nc6OEtTVLWjH3uT7hFkKQFZt91xPfrFF5nGALMg=;
        b=Kmayp6ei6Bz4UR/JOjcJ+4mWfPJG4AWtJOvWvYvcm3tRuGeUGg/0xtWfz8QoateviL
         0RiAe9yFIO0TSq8B50A/QvqPPPYAafOPJPCQ3HDaaR+skrUgq6XNVyVo/3gzGefXV5Jc
         ryaycKX0j8z6+nYGQpA5s8RXfWNWwlvM4AC6lGz/+JYvAVX9BQLdWGdhyiLJ+8NA9mt/
         oYvbZesshfd7wRNc0Z15yUCgkIBkEsMF0xEzn3uUZdiYrMUqABgcSkZEk5nM8r4AEw6Q
         GrZpat9o9QffwgtEmxOO7/QEclRUAGLBf44kz/2GFczmRuj6dkhJR2QOVheC9C63vI4p
         iPgA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=saO1Nc6OEtTVLWjH3uT7hFkKQFZt91xPfrFF5nGALMg=;
        b=C8Q/XExdqwJqLxuayRRj3Hjj76+BBJU9whMyzm79a1FjFGACUd2w6YmW7YgReezsRA
         jaRBY285Wm2wlCp8/4M7AI1KqdxccM3IHUq86+lwqvXzuGnwAMM92zUsPIUUk3/aRb2E
         SwLCROyKM7dHh9VdQKMKd32ybu53Q4HmJ5FSJuj/x3mBBtDG5epIgHYARGX6P2GyIVCY
         yNDoJxhJA+pqdjQtgTcXQGw7gHZcdgx2j4k/rTmlbUAiaQZOTtzTQot+xPlf0j5Mf5DW
         T8vIQYX+JgU+SMIMJEvZtMyzy/7hDBcT1sltg8xN+2KeyAyVBq+r8fpLMrX1nRiOLEJk
         w9HA==
X-Gm-Message-State: ABuFfogVQCqmR/SUo/IOLkGBiB6C3OW251sUYIMxaJlidEvsWmfEK5Ko
        oKm+jKXv3PkYS/WLd7GbsJLSlAA8QttR3VRPa1Dntg==
X-Google-Smtp-Source: ACcGV61Gbu+/yqMJKGG2BqDYtejgESfPnljpA9cUzSiyUUyl4nkJvwAuKO+6c4R9hJZ0jkBZ6Gku3McOV2kaJMGpgZc=
X-Received: by 2002:a81:a11:: with SMTP id 17-v6mr984636ywk.238.1537892681032;
 Tue, 25 Sep 2018 09:24:41 -0700 (PDT)
MIME-Version: 1.0
References: <20180922180500.4689-1-pclouds@gmail.com> <20180922180500.4689-3-pclouds@gmail.com>
 <CAGZ79kZF1+0PTEgF_NwM_AwttJ0sedAP8CT834L5ZGJpxZ+G_Q@mail.gmail.com> <CACsJy8BKTkbc=ZgMnO7Yuk0eaqzZnifo80tnR872_T8b02biqg@mail.gmail.com>
In-Reply-To: <CACsJy8BKTkbc=ZgMnO7Yuk0eaqzZnifo80tnR872_T8b02biqg@mail.gmail.com>
From:   Stefan Beller <sbeller@google.com>
Date:   Tue, 25 Sep 2018 09:24:29 -0700
Message-ID: <CAGZ79kZw8-BiW5VE_YN5X2E07FeMA=XtHpjcUoSFtWNRu44fAQ@mail.gmail.com>
Subject: Re: [PATCH 2/8] Add a place for (not) sharing stuff between worktrees
To:     Duy Nguyen <pclouds@gmail.com>
Cc:     git <git@vger.kernel.org>, Elijah Newren <newren@gmail.com>,
        Jeff King <peff@peff.net>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Sep 25, 2018 at 8:36 AM Duy Nguyen <pclouds@gmail.com> wrote:
>
> On Tue, Sep 25, 2018 at 4:35 AM Stefan Beller <sbeller@google.com> wrote:
> >
> > On Sat, Sep 22, 2018 at 11:05 AM Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc =
Duy <pclouds@gmail.com> wrote:
> > >
> > > When multiple worktrees are used, we need rules to determine if
> > > something belongs to one worktree or all of them. Instead of keeping
> > > adding rules when new stuff comes, have a generic rule:
> > >
> > > - Inside $GIT_DIR, which is per-worktree by default, add
> > >   $GIT_DIR/common which is always shared. New features that want to
> > >   share stuff should put stuff under this directory.
> >
> > So that /common is a directory and you have to use it specifically
> > in new code? That would be easy to overlook when coming up
> > with $GIT_DIR/foo for implementing the git-foo.
>
> There's no easy way out. I have to do _something_ if you want to share
> $GIT_DIR/foo to all worktrees. Either we have to update path.c and add
> "foo" which is not even an option for external commands, or we put
> "foo" in a common place, e.g. $GIT_DIR/common/foo.
>
> > > - Inside refs/, which is shared by default except refs/bisect, add
> > >   refs/local/ which is per-worktree. We may eventually move
> > >   refs/bisect to this new location and remove the exception in refs
> > >   code.
> >
> > That sounds dangerous to me. There is already a concept of
> > local and remote-tracking branches. So I would think that local
> > may soon become an overused word, (just like "index" today or
> > "recursive" to a lesser extend).
> >
> > Could this special area be more explicit?
> > (refs/worktree-local/ ? or after peeking at the docs below
> > refs/un-common/ ?)
>
> refs/un-common sounds really "uncommon" :D. If refs/local is bad, I
> guess we could go with either refs/worktree-local, refs/worktree,
> refs/private, refs/per-worktree... My vote is on refs/worktree. I

refs/worktree sounds good to me (I do not object), but I am not
overly enthused either, as when I think further worktrees and
submodules are both features with a very similar nature in that
they touch a lot of core concepts in Git, but seem to be a niche
feature for the masses for now.

For example I could think of submodules following this addressing
mode as well: submodule/<path>/master sounds similar to the
originally proposed worktree/<name>/<branch> convention.
For now it is not quite clear to me why you would want to have
access to the submodule refs in the superproject, but maybe
the use case will come later.

And with that said, I wonder if the "local" part should be feature agnostic=
,
or if we want to be "local" for worktrees, "local" for remotes, "local"
for submodules (i.e. our own refs vs submodule refs).

> think as long as the word "worktree" is in there, people would notice
> the difference.

That makes sense. But is refs/worktree shared or local? It's not quite
obvious to me, as I could have refs/worktree/<worktree-name>/master
instead when it is shared, so I tend to favor refs/local-worktree/ a bit
more, but that is more typing. :/

=3D=3D
As we grow the worktree feature, do we ever expect the need to
reference the current worktree?

For example when there is a ref "test" that could be unique per
repo and in the common area, so refs/heads/test would describe
it and "test" would get there in DWIM mode.

But then I could also delete the common ref and recreate a "test"
ref in worktree A, in worktree B however DWIMming "test" could still
refer to A's "test" as it is unique (so far) in the repository.
And maybe I would want to check if test exists locally, so I'd
want to ask for "self/test" (with "self" =3D=3D "B" as that is my cwd).

Stefan
