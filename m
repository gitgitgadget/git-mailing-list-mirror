Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 6A7C820248
	for <e@80x24.org>; Sun, 21 Apr 2019 07:01:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726084AbfDUHBS (ORCPT <rfc822;e@80x24.org>);
        Sun, 21 Apr 2019 03:01:18 -0400
Received: from mail-lf1-f67.google.com ([209.85.167.67]:38633 "EHLO
        mail-lf1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725970AbfDUHBR (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 21 Apr 2019 03:01:17 -0400
Received: by mail-lf1-f67.google.com with SMTP id v1so6834109lfg.5
        for <git@vger.kernel.org>; Sun, 21 Apr 2019 00:01:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=iamXqVT9jZdht5sRqrzatA7in3svfwjeXiaYSMZoXfg=;
        b=onsldaztgYAIE4ShzpC1GVe+m/hKtP4Ssec08zIFnbm7R/8ytqdamhBv0L2ldarQSb
         mj/dzhtWowe5y3FPdWNTMIuOWlOWPLlHJrO5eDVVeDz9eaUNBBt38ZWhdB1Zc+OwA6Mh
         gyUr+ug9STjxu1HLC0lzot5TvqZWclo4X5uY2/s2U9ivnpE7EYxUvv2ennmYeOrx5Dib
         wqhfVhJGwwABgaYJYATRSLsy+q7/Mj+WPpk4K3t/xZygM0/jSmTHwgEryjt46Ek4cbv8
         4jOIjzcrfl2BKstXLnBFYr7/b88geE7mcbHgAHgYRLV336PYHoENyR+EStCA4Yx/HqZC
         VYgw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=iamXqVT9jZdht5sRqrzatA7in3svfwjeXiaYSMZoXfg=;
        b=SNDB7QV0z0Dvhi6F3UiIfVIqL2idwLoDlUS7pniCfHFSmDW3Uq9a8pIckBSto71/Dz
         GKRNQ3BaO4eqIKv8vZAD60ZicepvIneoca/whLbXy7vBpdLMKJU6HmfiZLuB4SCBJc+v
         tpR2OTqgFPlHr8d8PhOPnAmCclqfA45lPVmSkqe8rQfjWujKjGYXllhJFGJIO9deqQXL
         umKo9LsZCA5Fqfh7x93+gO6j3DJ3uDoc8YYZgaBZx45lfk04r7kBlY9usL1zR1v8upcV
         sktLFvWLP1VTX2JmIZxPz7EhAEVHHHNfK+Pg8ojWJlGgT6Q0sX5pSC3XLQZQDZbqo3b2
         G5qA==
X-Gm-Message-State: APjAAAU6ucJwG5lQBfZ4l7dE6VLdT2T5Q3Hl/X1qreUlw/9QAJI+cApe
        RSX724EPMyUZ3fyMHwGwLk+Ypa78Qi8yo7cEIGk=
X-Google-Smtp-Source: APXvYqxH4BWeeUMBPSMY2wiU2+SJ+eCKVKCvKdoX2DsKIwEb/EB8Vaz3ylZ42jA0n1qEh9n87wvLU8Q5MmwtNlqH3P4=
X-Received: by 2002:a19:c511:: with SMTP id w17mr6671536lfe.37.1555830075308;
 Sun, 21 Apr 2019 00:01:15 -0700 (PDT)
MIME-Version: 1.0
References: <20190421040823.24821-1-alexhenrie24@gmail.com> <xmqqftqbdijl.fsf@gitster-ct.c.googlers.com>
In-Reply-To: <xmqqftqbdijl.fsf@gitster-ct.c.googlers.com>
From:   Alex Henrie <alexhenrie24@gmail.com>
Date:   Sun, 21 Apr 2019 01:01:02 -0600
Message-ID: <CAMMLpeRnwrcjn3UAgs5p532pf8=xAwBqh2qg7Cfqun6qsqD06w@mail.gmail.com>
Subject: Re: [PATCH v2] Give git-pull a --reset option
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Git mailing list <git@vger.kernel.org>,
        Eric Sunshine <sunshine@sunshineco.com>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Sat, Apr 20, 2019 at 11:38 PM Junio C Hamano <gitster@pobox.com> wrote:
>
> Alex Henrie <alexhenrie24@gmail.com> writes:
>
> > A common workflow is to make a commit on a local branch, push the branch
> > to the remote, check out the remote branch on a second computer, amend
> > the commit on the second computer, force-push back to the remote branch,
> > and finally submit a pull request. However, if the user switches back to
> > the first computer, they must then run the cumbersome command
> > `git fetch && git reset --hard origin`.
>
> Doesn't anybody sense there is a larger problem if such a workflow
> is "common" in the first place?  In that sequence, when you come
> back to the first repository there is no guarantee that what you are
> losing is exactly what you are willing to lose and nothing else
> (i.e. your earlier WIP you sent to the second repository, which was
> further polished, making the earlier WIP you had here irrelevant).

You may be right. On the other hand, you're expected to think about
what you're doing before running `git push --force` and clobbering a
remote branch. Similarly, you would be expected to think about what
you're doing before running `git pull --reset` and clobbering a local
branch. It's actually easier to recover from accidentally clobbering a
local branch than accidentally clobbering a remote branch because you
can use `git reflog` to find the lost commits.

> If the last "recovery at the first repository" step were "pull --rebase",
> at least you would realize that you have the earlier WIP locally
> that either
>
>     (1) conflicts with the more polished work that have been
>         accepted at the upstream, in which case you can tell the
>         rebase machinery to drop that earlier WIP _after_ making
>         sure that it is only that stale WIP you not only are willing
>         to but actively do want to lose that is getting discarded.
>
>     (2) replays cleanly on top of the updated upstream, which hasn't
>         accepted your pull request made from the second repository
>         with the more polished version, in which case you'd realize
>         that you may have to work on the topic further.  And you
>         have a chance to inspect what you ended up with before using
>         "reset --hard" or "rebase -i" to discard what you no longer
>         need.

I understand that `git pull --rebase` followed by `git rebase --skip`
is a safer workflow. I just feel like an option like `git pull
--reset` should be there for users who know what they're doing, just
like `git push --force` is available for users who know what they're
doing.

> At least, I think the longhand this attempts to replace, "fetch"
> followed by "reset --hard origin" is better because of two reasons.
> It is more explicit that the procedure is destructive, and more
> importantly, it can allow to have (and we should encourage users to
> make a habit to have) an extra step to inspect what the user is
> about to lose with "git log origin.." after "fetch" but before
> "reset --hard".

I'd be happy to emphasize the destructive nature of this option by
calling it `git pull --hard-reset` instead.

> So I have a moderately strong suspicion that "git pull --reset"
> promotes a wrong workflow and should not exist.

It'd be great to get some feedback from other Git users, but in the
end it's up to you and I trust your decision.

-Alex
