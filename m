Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-11.6 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI,USER_IN_DEF_DKIM_WL shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id A63381F453
	for <e@80x24.org>; Sun, 30 Sep 2018 20:18:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728596AbeJACwZ (ORCPT <rfc822;e@80x24.org>);
        Sun, 30 Sep 2018 22:52:25 -0400
Received: from mail-lj1-f176.google.com ([209.85.208.176]:41439 "EHLO
        mail-lj1-f176.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728518AbeJACwZ (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 30 Sep 2018 22:52:25 -0400
Received: by mail-lj1-f176.google.com with SMTP id u21-v6so3154399lja.8
        for <git@vger.kernel.org>; Sun, 30 Sep 2018 13:18:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=3krKiRcJ6TM0AAiSTG/d8rmBMSLBL9YxDxhdPU5QFCo=;
        b=EvEzMlvyVBlDyIo7xVefQOfyu3OX+XUB5CGm1L0SdaEF8xLtXaXaThoqmP1T5PVr16
         Xi8czDJv/DaWwS0x0lhD4rnEBACOJ2y04HBPm2gemzkQ1Y6yWArls55qjQdLCXYyaO+3
         79EJ8A+AhaAoLQGFlJ1X8XpcivoMHuVWg/Kbk2O7Z277F6AjoMd4TNbAh8teVELlvYz3
         YquIz0WonQgxxYKpdR1MZ6JhTd/+aA0uvN9Lfgzk+IuUivJcwiM4fdIwc8F7W5WYR5Xx
         p11RbX9Z+qKi6SLZ9kz0OMqSS1AgWSqLyJVNT041iBXhjeLhvwjM/a5Qg72yevyYF+Us
         Oraw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=3krKiRcJ6TM0AAiSTG/d8rmBMSLBL9YxDxhdPU5QFCo=;
        b=uczcuWdQYzD3ibAfgBZphhxlCV7EM7NN/YRoqdF1AczE6ZeDV5KchX7K/bchV6b4ui
         /QI0sDzDTsTkTi+hvFuJvotLjeLv4yD24qDGyx6x37QzgvyJQaN6mKAQNAkJMwScoOBl
         JkzVGyq0AMhh3xhlmE8/9bJflPMo+xSTc/Li4WniOtK3ax8mNnPYKmwFslH6ENJG2xTv
         LGdBIadEMmxyIVIqf8q7vPf05ncUPxt05nLciXWdNxb4ULyWug7ISLQ9ClIuUbYFcGRZ
         5Nr2wm/1tbB0qJtnhIHsndynvsrJh9fTbl2uoZST5E8PvBxycpFNRJ+/kAHHbMmOFxd5
         csVw==
X-Gm-Message-State: ABuFfojjTdkm5lidHxOiGYXvYKvNhU/ZLbVW6tj6M/OHunq7LLMwq83k
        vWvLLXlSo1CbEk+Y+/NpEvZFk/JjS+ElvNa6CsHLT6KNigRdpg==
X-Google-Smtp-Source: ACcGV60YaFO9qeniKXX1yOrTA1ADfjBgfFAVMvNEcGj4qGugBpaI5LpCME30GfFvTfDbJRZNy7YtEf2C6Jrrq3j01A0=
X-Received: by 2002:a2e:5614:: with SMTP id k20-v6mr4302648ljb.48.1538338679703;
 Sun, 30 Sep 2018 13:17:59 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a2e:2e13:0:0:0:0:0 with HTTP; Sun, 30 Sep 2018 13:17:59
 -0700 (PDT)
In-Reply-To: <xmqqbm8f952b.fsf@gitster-ct.c.googlers.com>
References: <CAPL8ZivFmHqS2y+WmNR6faRMnuahiqwPVYsV99NiJ1QLHOs9fQ@mail.gmail.com>
 <xmqqbm8f952b.fsf@gitster-ct.c.googlers.com>
From:   Stefan Xenos <sxenos@google.com>
Date:   Sun, 30 Sep 2018 13:17:59 -0700
Message-ID: <CAPL8ZiuzxmgNRE5mVy64xpm_bwbEdkV_X_cAW9B=6LU1T_YF9w@mail.gmail.com>
Subject: Re: Git Evolve
To:     Junio C Hamano <gitster@pobox.com>
Cc:     git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

> If we lose the Change-Id: footer without adding any new cruft in the
> commit object header, that would be a great success.  It would
> be a failure if we end up touching the object header.

Yes, I was thinking along the same lines.

If obsolescence graph is stored as part of the commit header, it would
get unconditionally shared whenever that commit is pushed, and I would
consider it a desirable property if users could choose whether to push
just a commit or a the obsolescence graph that contains the commit.
Sometimes the reason you're amending a commit may be because the
original contained content that shouldn't be pushed.

Putting it in the header would also either cause it to get retained
forever by git gc or create a situation where we permit dangling
references - and neither seem desirable to me. It would be nice if
users could retain the obsolescence graph for stuff a user is actively
working on, but we could discard it (with 0 cost) for commits they're
done with or were never interested in editing.

On Sat, Sep 29, 2018 at 5:55 PM, Junio C Hamano <gitster@pobox.com> wrote:
> Stefan Xenos <sxenos@google.com> writes:
>
>> What is the evolve command?
>> ...
>> - Systems like gerrit would no longer need to rely on "change-id" tags
>> in commit comments to associate commits with the change that they
>> edit, since git itself would have that information.
>> ...
>> Is anyone else interested in this? Please email me directly or on this
>> list. Let's chat: I want to make sure that whatever we come up with is
>> at least as good as any similar technology that has come before.
>
> As you listed in the related technologies section, I think the
> underlying machinery that supports "rebase -i", especially with the
> recent addition of redoing the existing merges (i.e. "rebase -i
> -r"), may be enough to rewrite the histories that were built on top
> of a commit that has been obsoleted by amending.
>
> I would imagine that the main design effort you would need to make
> is to figure out a good way to
>
>  (1) keep track of which commits are obsoleted by which other ones
>      [*1*], and
>
>  (2) to figure out what histories are still to be rebuilt in what
>      order on top of what commit efficiently.
>
> Once these are done, you should be able to write out the sequence of
> instructions to feed the same sequencer machinery used by the
> "rebase -i" command.
>
> [Side note]
>
> *1* It is very desirable to keep track of the evolution of a change
>     without polluting the commit object with things like Change-Id:
>     and other cruft, either in the body or in the header.  If we
>     lose the Change-Id: footer without adding any new cruft in the
>     commit object header, that would be a great success.  It would
>     be a failure if we end up touching the object header.
>
>
>
>
