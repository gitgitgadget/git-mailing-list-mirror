Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DE9D9C433F5
	for <git@archiver.kernel.org>; Wed, 23 Mar 2022 20:50:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344790AbiCWUvq (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 23 Mar 2022 16:51:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50660 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240768AbiCWUvo (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 23 Mar 2022 16:51:44 -0400
Received: from mail-pj1-x1049.google.com (mail-pj1-x1049.google.com [IPv6:2607:f8b0:4864:20::1049])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 64BB85A166
        for <git@vger.kernel.org>; Wed, 23 Mar 2022 13:50:14 -0700 (PDT)
Received: by mail-pj1-x1049.google.com with SMTP id t12-20020a17090a448c00b001b9cbac9c43so1676710pjg.2
        for <git@vger.kernel.org>; Wed, 23 Mar 2022 13:50:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to;
        bh=sWdm9hxi3GbU51ORBPx9FmjvGSTOkgComsLxRxBdcFA=;
        b=HpvF2YYB4uL+Ps9N2CSTmW6zasiu9o7h9fMBVfc8Yfq8i+KwavOXV7QULO1vi4Iq/x
         aZYaShqZDFqTHQWBopa2OoUrvYXor1S0SI5vCn+PY2jyvSO288qTSycf3wDtb8tIUgtc
         U4qspKBpwSX0oZdmII8pElD4nGA5cTViXINS6yIRqX4h6lp6zpi+8NBbg0KnZljIIdZR
         looevDyFQyfIPVyl0AhsWqjXAFQJ3RwM6wNh/6ERSe8Rjj907MnSsV4EjeEk47OsFjwp
         nXbBlXP/LV7BhQ7ZyD3peVhLEDIOBndd4RuDqwwYSAPb6PlMWxiKquN6nB4yOrgo7sB4
         qN3g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to;
        bh=sWdm9hxi3GbU51ORBPx9FmjvGSTOkgComsLxRxBdcFA=;
        b=Dq8HK4Ba9DpEbuJW81UfPG6QV2h0uOp3Axv8YGLd3It/N2jdN7rukR3EK3D4Z14GxE
         k8V5hC986uh0t2LHsUjTbl/oo1CLXj7+Ag2KvqvceBpKy4RWBruHEzced8d0oiqew1mQ
         hQFT/X2hqhyrvjHG/maCO1vjOh8luZJKTiMHNMpBYxh5q5JgtM0kZZlXeyKVQoABT9DI
         nKggrneBGg9XOI/wmN1eiWfq4NogwdKLUyhlxHxmsDZKDaNBveIUIHslPX7NOIGiGeXX
         +C/lsUN+f2ibVI/inAxNRhlZ5kf8gAt7GbS1gg+HHRGxuDJ9i7vr/4XVZea2QRZDRE3E
         O1MA==
X-Gm-Message-State: AOAM532G9NpxgsYKV+XhcH7EbWg3pczmIVLieH1vmMLWoe7xNne6nFf0
        oopc80eaEh94jDDRcZ0Bqq0o2dEwKV9MDA==
X-Google-Smtp-Source: ABdhPJzBaVTYf0bCm7EliMpUm1KY5y7urvPwRGtgx0FCN+2gtPrr+t3A176goRJaQoIgLKqXC3Ps7G+O8ZZlmA==
X-Received: from chooglen.c.googlers.com ([fda3:e722:ac3:cc00:24:72f4:c0a8:26d9])
 (user=chooglen job=sendgmr) by 2002:a17:902:dac7:b0:154:4899:85db with SMTP
 id q7-20020a170902dac700b00154489985dbmr2056306plx.9.1648068613862; Wed, 23
 Mar 2022 13:50:13 -0700 (PDT)
Date:   Wed, 23 Mar 2022 13:50:03 -0700
In-Reply-To: <6fa76f28-063b-8964-c0a2-642dae88f1b3@huawei.com>
Message-Id: <kl6la6dgtmv8.fsf@chooglen-macbookpro.roam.corp.google.com>
Mime-Version: 1.0
References: <6fa76f28-063b-8964-c0a2-642dae88f1b3@huawei.com>
Subject: Re: [Question] .git folder file updates for changing head commit
From:   Glen Choo <chooglen@google.com>
To:     John Garry <john.garry@huawei.com>, git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi John, I'm not a big expert on Make (or even Git :p) but think I can
answer some of your questions.

John Garry <john.garry@huawei.com> writes:

> Hi guys,
>
> I have a question about which files in the .git folder are updated as we 
> change the head commit. I could check the codebase myself but prob will 
> make a mistake and maybe some expert would be so kind as to just kindly 
> tell me.
>
> For building the linux perf tool we use the git head commit id as part 
> of the tool version sting. To save time in re-building, the Makefile 
> rule has a dependency on .git/HEAD for rebuilding. An alternative 
> approach would be to compare git log output to check current versus 
> previous build head commit, but that is seen as inefficient time-wise.

You're on the right track because if .git/HEAD doesn't change, the HEAD
is still pointing to either the same commit (if in detached HEAD) or
branch (if not in detached HEAD).

The problem is that when HEAD points to a branch, the branch's 'head
commit' can change, implicitly changing the commit that .git/HEAD
actually points to.

> The problem is that actions like git cherry-pick and git reset --hard 
> HEAD^ may not update .git/HEAD (so don't trigger a rebuild).

That's what's happening here. If your HEAD is pointing to
"refs/heads/main", "cherry-pick" and "reset --hard" will change where
"refs/heads/main" points, but HEAD still points to "refs/heads/main".

Branches are often located in "loose form" under .git/refs/heads/*,
*but* refs can also be stored in a "packed form" under .git/packed-refs
(https://git-scm.com/docs/git-pack-refs). There is also a relatively
new ref storage format called reftable that I'm not familiar with, but
presumably stores its refs in other locations too.

All of this is to say that depending on specific files under .git/
exposes you to a lot of Git internals that really aren't meant for
external consumption. I suggest finding a different approach than
watching Git-internal files for changes.

> Is there some more suitable file(s) which we could use as a dependency? 
>  From my limited experimentation, .git/index seems to always update when 
> the changing head commit.

I think users typically expect the index (and therefore .git/index) to
change when the head commit changes, but this isn't always true e.g.
"reset --soft" will move the branch without changing the index.

P.S. Even if you knew the value of .git/index or .git/HEAD, that
wouldn't tell you whether or not the files in your working directory
have changed, so I'm not sure if you want to use either as Makefile
dependency.

>
> Thanks,
> john
