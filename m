Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 35AFFC00140
	for <git@archiver.kernel.org>; Mon,  8 Aug 2022 18:15:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243342AbiHHSPh (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 8 Aug 2022 14:15:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47916 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230062AbiHHSPg (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 8 Aug 2022 14:15:36 -0400
Received: from mail-ej1-x62e.google.com (mail-ej1-x62e.google.com [IPv6:2a00:1450:4864:20::62e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BB7D72B2
        for <git@vger.kernel.org>; Mon,  8 Aug 2022 11:15:34 -0700 (PDT)
Received: by mail-ej1-x62e.google.com with SMTP id gb36so18017750ejc.10
        for <git@vger.kernel.org>; Mon, 08 Aug 2022 11:15:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc;
        bh=7eU4s/yr0bIXvO6rfKAGpbQmgb3Ma3+HecEBShlcDDw=;
        b=KnxhjrODVKjRxk9pa6ICNQs3/sDKJ2w8oS86ZjVYxgY3wjpYdWIOjni/eA5vow2HZb
         EXeUg0GJ/695Jog3XGUdFw5uFXMypWscFhwj1O86zo5ptNCLJLxTcMZJLsHYQlgXcoRe
         QkoiJf2Y/x0JeojsOlYx1iYndc/kYLxYnMK2UdI2Zo/iTKT4e4koWHk9oPrUHbYRbk56
         u0wRB9Gv0VKLtSb68pvdj6NlN0c4vYsuBB9MOJxauhWSZTUqvj8dY9fpw729h0YtXsQm
         nMyrcTpnFM9Uo6moVyHoW2OUhU6nhVMYiu/+/wq/hifcxKZUj8R4cwFjH0vNSApBDrb8
         daog==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc;
        bh=7eU4s/yr0bIXvO6rfKAGpbQmgb3Ma3+HecEBShlcDDw=;
        b=gbEcpBhhjqATdHfVs5QIQqO4QN+fseImf4E54oOnYiwc8Od8b+qu/C4y+7f9cuNaPI
         N27H89UrvP1dnQvgmjESw24WVFkxwJtwkFtZN7Cc32DAPN+fw+GC14n5dP5kao1KWy++
         9YAb9TAkugs9XUvzNYZ19I0489j6MA91NPNl8mBNIv2OQOJMO1ZOvOQvnrU6U9AKNgl7
         k6s/do5WDcYShXZYuLHo72s2vwo71WDPU2TRsbVfJrYJE8mUla/cyf8fPsc/F8IRTo0x
         P+lOcypOyQ+FdrdbQPe+3hA1zgy/qI35ZZeVk1fotGqa2mdagv6KIqs1T7kQ+tc2O17M
         fUXQ==
X-Gm-Message-State: ACgBeo2H/qAXvyexeOzw03oOVR3RfpNXvJLkdS1itOJs1kfcFA1HybhK
        VXcdR1sXnBNmUZI6jSt4zNnTQG0l8CaMDtZKSqt0QlczduC4dQ==
X-Google-Smtp-Source: AA6agR72FtPVqVmwZEmbw0BafEBmh7snuD+FVrMU2EC2fmOKHGMpNdwn15XKISpxYhM3zY8lTRZuFPZyq6RUbzKUcVc=
X-Received: by 2002:a17:906:6a2a:b0:730:a3f1:aee with SMTP id
 qw42-20020a1709066a2a00b00730a3f10aeemr15049316ejc.387.1659982533228; Mon, 08
 Aug 2022 11:15:33 -0700 (PDT)
MIME-Version: 1.0
References: <CAKvVO18RVye=PkBRv=trj2GHh8ccGKL5j0mMq2eHQ1SX=wsr8A@mail.gmail.com>
 <patch-1.1-3ff17707481-20220805T141816Z-avarab@gmail.com> <b6299f8a-f75a-0e96-a6a6-55a7280584bf@github.com>
 <Yu02dOo4G8sy8tI6@coredump.intra.peff.net> <xmqqo7wyzlpm.fsf@gitster.g>
In-Reply-To: <xmqqo7wyzlpm.fsf@gitster.g>
From:   Emily Noneman <emily.noneman@gmail.com>
Date:   Mon, 8 Aug 2022 14:15:21 -0400
Message-ID: <CAKvVO18Du5M6broAJ6WqTAk6C4jxtqbXoS=9x03JgSdJAak80Q@mail.gmail.com>
Subject: Re: [PATCH] revision.c: set-up "index_state.repo", don't segfault in pack-objects
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Jeff King <peff@peff.net>,
        Derrick Stolee <derrickstolee@github.com>,
        =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>,
        git@vger.kernel.org, Paul Horn <git@knutwalker.engineer>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

The latest changes seem to have resolved the issue for me. My repo was
a bit different than Pauls, it's a big corporate repo with a partial
checkout and a worktree. What's confusing is that I do see an "index"
file in worktrees/NetLedger_GitRepo , but git 2.37.1 exhibits the
crash. 2.37.1.377.g679aad9e82 works just fine.

On Fri, Aug 5, 2022 at 12:42 PM Junio C Hamano <gitster@pobox.com> wrote:
>
> Jeff King <peff@peff.net> writes:
>
> > Of the two patches, I think 4447d4129d is the better approach. The
> > assumption in the code seems to be that do_read_index() (and thus
> > read_index_from(), etc) will set up istate->repo. That patch fixes a
> > corner case where we failed to do so. And with that fix, there's no need
> > for the callers to set things up ahead of time. So it covers all of
> > those initializers you mentioned.
>
> Yeah, I tend to agree that Martin's fix, which is a more focused
> one, is the better approach between the two.  It was merged to
> the 'master' track only a few days ago.
>
> We are at the end of the week #4 of this 12-week cycle, and we've
> accumulated about two dozens of topics already on 'maint' since the
> first maintenance release v2.37.1 was done, so we may have a chance
> to merge Martin's fix down to 'maint' before tagging the v2.37.2
> release.
>
> One thing that may help is to add a test similar to the situation
> Emily & Paul had to t7063 on top of 4447d4129d before merging it
> down, perhaps?
>
> In your reproduction, the "rm .git/index" step makes the worktree's
> branch "not checked out" (the commit is empty so "worktree add" may
> check out no files, and removing the index will make it as if you
> did "clone --no-checkout") ...
>
>   git init repo
>   cd repo
>   git commit --allow-empty -m base
>
>   git config core.untrackedCache true
>   git worktree add at
>   rm .git/worktrees/wt/index
>
>   git gc
>
> ...  but it is not something an end user is likely to do, so I am
> still curious how this was triggered in real life.
>
> Ah, OK, I think the steps can be tweaked to
>
>       git config core.untrackedCache true
>     - git worktree add at
>     - rm .git/worktrees/wt/index
>     + git worktree add --no-checkout wt
>
>       git gc
>
> i.e. (1) With "worktree add --no-checkout", there is no need to
> manually remove the index file, and (2) "at" is an obvious typo of
> "wt".  This does not require the history to be a singleton empty
> tree, either.
>
> And that is a less implausible thing for users to be doing, but may
> still not be very common.  Perhaps the --no-checkout is a prelude to
> set up a custom sparse checkout pattern, to avoid a wasteful full
> tree checkout before doing so, or something?  If that is the case,
> then the above sequence becomes a very plausible thing for users to
> be doing.
>
> > Emily, Paul: I'm 99% sure this will be the case given my reproduction
> > above, but if you could try reproducing the problem with the current tip
> > of "master" from git.git, that would confirm the findings.
>
> Yes, indded.  That would be very helpful.
>
> Thanks, all, for discussing the problem and its solution(s), and
> thanks in advance for further testing to help the fix forward.
