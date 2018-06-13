Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-11.4 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI,T_DKIMWL_WL_MED,USER_IN_DEF_DKIM_WL shortcircuit=no
	autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id CAEB91F403
	for <e@80x24.org>; Wed, 13 Jun 2018 18:52:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S935154AbeFMSwa (ORCPT <rfc822;e@80x24.org>);
        Wed, 13 Jun 2018 14:52:30 -0400
Received: from mail-yw0-f195.google.com ([209.85.161.195]:36364 "EHLO
        mail-yw0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S935060AbeFMSwa (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 13 Jun 2018 14:52:30 -0400
Received: by mail-yw0-f195.google.com with SMTP id t198-v6so1246512ywc.3
        for <git@vger.kernel.org>; Wed, 13 Jun 2018 11:52:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=p9W96gtMSjnXT0tC6kRcHoRjUaaL24UMF55blrTd8/M=;
        b=r9bZSyeFrLj04/jZyEYTtfU0bYHuLJTqNit7hyKGG75/aqnOGNZ6uwGSGzXkhmt9QO
         BQFuXzPNn20up60u46uDL7246K/2GbHaK6ER/e6IwJ63wuoSPRWwATl1c2np0fvtEVEF
         WvWPXo5IHEdshH98hqMqLQ24YpGtQM4hFGce44A+gDqZhhrQSVX3HBQpt3irnqYtMOUQ
         Qqn44FDdSDS6DtMaK6orpjjuBvGd980mCFXbklncyy4KdZycNzn1Whq8UFQK3fO9RJ6U
         5d/78SIMKUbGjfvOL62BebOT4LHnvnw0T2a8R2qyCKupeFMqdxgCOtHvRCPMYSIewloh
         R9gQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=p9W96gtMSjnXT0tC6kRcHoRjUaaL24UMF55blrTd8/M=;
        b=DUBMDjRb4uChxg7ayL3mcjEutDlUp9mlvwvfKtfLQXMPMkwDSvDOQPU3Gf1AG8S+y2
         WaJpn26NOJQ14atCQPGGs+6Y39mSluXCjNyVMh8UiNrU0DtuzJqTt2DPMHZCIoYfotr7
         zD8pBz36IZRWSiCSRgl8h3CH7mMSST9suCs7MW/jm06C7n/YsiJGIcyQA/F+8/hLi3u8
         SiJ+84rJTMK7dR9GnomCc1vqWX2VHu+sA0bkdnErq6PUirU4fROpvSHmRF8CsG4X8gqa
         h9OlRszZ4uOI3X6hXl2lwB810M88bu1RUB+ulsBnF758BOsNvBUugG0bSN7RFslxYiDE
         9KdA==
X-Gm-Message-State: APt69E3xupSDglmOSFR+xn2TfTCwPqqzGdWXJgZROVH2s27YF+/yy2Kr
        xXTrjfvCGPU3/h8+OvXhRhHJ7Gsa2OGa9AxI11aKqg==
X-Google-Smtp-Source: ADUXVKJ6AJ0Pa3U2gtQ0ZBzUWT6HXj6F7FzzmwAlpy1BUFjAIX5J7E3bMpE/0zydP9NKhcTnMsW3HFK4Scn5ZkXITGE=
X-Received: by 2002:a81:360a:: with SMTP id d10-v6mr3117251ywa.421.1528915948738;
 Wed, 13 Jun 2018 11:52:28 -0700 (PDT)
MIME-Version: 1.0
References: <20180612235825.12271-1-sbeller@google.com> <xmqq7en27ej0.fsf@gitster-ct.c.googlers.com>
In-Reply-To: <xmqq7en27ej0.fsf@gitster-ct.c.googlers.com>
From:   Stefan Beller <sbeller@google.com>
Date:   Wed, 13 Jun 2018 11:52:17 -0700
Message-ID: <CAGZ79kbTuu9kXXag0aYvDr90D8LXYo2kWhshx=kr5QHk7Lv3AQ@mail.gmail.com>
Subject: Re: [RFC PATCH 0/3] submodules with no working tree shall unset core.worktree
To:     Junio C Hamano <gitster@pobox.com>
Cc:     git <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Jun 13, 2018 at 11:00 AM Junio C Hamano <gitster@pobox.com> wrote:
>
> Stefan Beller <sbeller@google.com> writes:
>
> > The first patch teaches checkout/reset (with --recurse-submodules) to unset
> > the core.worktree config when the new state of the superprojects working tree
> > doesn't contain the submodules working tree.
>
> Are there two cases of "doesn't contain working tree of a submodule"?
>
> The superproject's commit may not have a gitlink to a specific
> submodule in its tree (i.e. there is no way to even "submodule init"
> with such a commit in the superproject's history).

... for example git.git before 2.13 did not have a gitlink for its
sha1collision submodule ...

>   Or there may be
> a gitlink but the user chose not to check it out in the working
> tree.

This is when the submodule is not active or de-initialized or not initialized
to begin with. However there is an empty directory as a place holder.
As long as the empty place holder is there, we do not run into trouble.

> Do they need to be treated differently, or can they be treated the
> same way?

I would think they are the same, as both cases do not have a working tree
for the submodule.

> Also, is the "submodule" feature supposed to play well with multiple
> worktree feature?

It is a long term goal to get this working.

>  Let's imagine that you have two worktrees for a
> single superproject, and the branches of the superproject these two
> worktrees check out are different ones (which is the more sensible
> set-up than checking out the same branch twice).

(git-worktree even prevents you to checkout the same branch),
sounds all very sensible up to here.


> Further imagine
> that the superproject started using a single submodule sometime in
> the past and keeps using it throughout its life since then.
>
>  1. if both of these two branches have the submodule, and two
>     worktrees both are interested in having the submodule checked
>     out via "submodule init/update", where does core.worktree point
>     at?  Do we have two copies of the variable?

Currently in the real world (aka in origin/master), the submodules are
completely duplicated, and do not know about the worktree feature
themselves:

    $ cd .git && find . |grep config |grep sha1co
    ./modules/sha1collisiondetection/config
    ./worktrees/git/modules/sha1collisiondetection/config

(Yes I do have a worktree called "git".)

So for the sake of this patch series this should be okay, as there
is only ever one working tree for a submodule currently.

The current state of affairs is really bad as the submodule is
there twice with all objects and the rest.

>  2. what if one branch predates the use of the submodule in the
>     superproject while the other branch is newer and uses the
>     submodule?  Where does core.worktree point at?

As we have two copies of the repository, one of them points at the
correct place, and the other would be unset.

---

In an ideal world we would want the submodules to use the worktree
feature along-side the superproject, e.g. if the superproject has the
two worktrees as above, the submodule would also get these.

However I have not thought about this future too deeply, as there
are a couple bumps along the road:

Supposedly the submodules main (common) git dir would stay in the
common git dir of the superproject at /modules/<name>.
However where would we put the submodules non-main worktree
git dirs? There are two places, as seen from the superprojects:

  .git/modules/<submodule-name>/worktrees/<worktree-name>
  .git/worktrees/<worktree-name>/modules/<submodule-name>

As worktrees can be removed pretty easily ("git worktree prune"),
I would not put the main parts of a submodule into a worktree part
of the superproject (The user could be in a non-main worktree
when they first ask for the submodule -- we have to make sure
the main git dir goes into the superprojects main git dir under
modules/).

An advantage for
   .git/worktrees/<worktree-name>/modules/<submodule-name>
would be that the worktree of the submodule is coupled to the
worktree of the superproject, i.e. if the user wipes the superprojects
worktree, the submodules accompanying worktree is gone automatically.

An advantage for
  .git/modules/<submodule-name>/worktrees/<worktree-name>
is to have any submodule related things in one place in
  .git/modules/<submodule-name>

Cleanup of the worktrees would be a bit harder as we'd have to
remember to prune the worktrees for all submodules as well
when the superproject removes one of its worktrees.

It is relatively rare to delete the submodule git directory compared to
removing a worktree, such that
  .git/modules/<submodule-name>/worktrees/<worktree-name>
sounds a bit more promising to me.

However the worktree command needs to figure out the worktrees:
    /path/to/super/worktree/submodule $ git worktree list

This would look at its git dir, which is

 .git/modules/<submodule-name>/worktrees/<specific-worktree>

discover the common dir at

 .git/modules/<submodule-name>

and then proceed in listing worktrees by exploring worktrees/.
If we had put it in the other form of
   .git/worktrees/<worktree-name>/modules/<submodule-name>
we'd discover the common git dir at
  .git/modules/<submodule-name>
and list it from there.

However currently we use the existence of directories (both for
submodules as well as worktrees) to infer some knowledge about
the existence of submodules and worktrees, so we cannot just declare
one version or the other to be the future, but we'd have to add some
form of linking, I would think.

Stefan
