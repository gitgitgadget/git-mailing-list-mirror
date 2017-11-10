Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.6 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 074031F42B
	for <e@80x24.org>; Fri, 10 Nov 2017 18:00:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753524AbdKJSAx (ORCPT <rfc822;e@80x24.org>);
        Fri, 10 Nov 2017 13:00:53 -0500
Received: from mail-qk0-f174.google.com ([209.85.220.174]:56061 "EHLO
        mail-qk0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753503AbdKJSAw (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 10 Nov 2017 13:00:52 -0500
Received: by mail-qk0-f174.google.com with SMTP id x195so12876727qkb.12
        for <git@vger.kernel.org>; Fri, 10 Nov 2017 10:00:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=wKkOj7DbAW4XXAQgmuTp4Td8e6qHPkY02KnQI0oMiEA=;
        b=D4JM6DTta8aa3rCu6czq7+fd21sED01GtKOFCGHhuZh+jTb3ufovxYDQHv09EdlCNC
         5BGiyxGk4H2nSu8c5zQnzHUUqLM9a2PK3Rpsvol2Gg5zIGk/wrW7hKc54s3SKt2eyIAR
         ZOzGZAoQSPVekD1tfuP2LJeCjcUeQkPO0Ps083WZXsAmL/zSjGcY6n45/xnuAqcGlxur
         qsnfX1yG3Y5Avs5s8sDfPEW8H3+81BSivvMqISpghfuW5ovI7jTNOrwAS6ZQP9Kn8y+g
         4fqBZhyaEWBAk3PbiaeO7oILTQCvJhbp2l4ZKKOMMan6pKqtcZGq35JhheIv6kYNe2al
         +/HA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=wKkOj7DbAW4XXAQgmuTp4Td8e6qHPkY02KnQI0oMiEA=;
        b=Su4OfeV9oA1vVqpSqlUd14ict1Fidc5af+MNpKTNSLd0tSkbYZ+W4xciylInpRwjC8
         24bwyTkGDfSko1EYDMA/scE0m+J3eKpeYRRrf10OKrHk9rxSaUnhwcAG3lx/D1h+gtzD
         cCs3Xh+U1iDy2FG4JHM+1Q0TiFACZ9pbzURQ1dSJp+bnURwgeg+eYWYzsDWMfuIXZzYW
         KqxS8+JWBP8U22JFAAFKLc6mePhWGw3peBzEh4oZihSLxJsWq7c5AwfYi8GGAs/ZSoDh
         tbVBt0UsgDlOr+AcRwr2wdyHMmoBpxreKbe3dyqHcASErcCe+4KLpXsYb+ULgNDFW+f0
         neDw==
X-Gm-Message-State: AJaThX6Awt1QFYZqgOhWNng12nSgSnwrZFG9Ox0XcXVYcMF5Ngfdg41u
        bDV3U5kWA9j0ZCWhdYcignM4WoGhhm/3Mt8jXy5VOQ==
X-Google-Smtp-Source: AGs4zMab17PTBeap/TnDbnmO3d/JuXUSMjSRB9PmKJTIV2cBMwKcrtJuO8Jt7kFQJpEAxFG7bMpbBxsto7xNQ/ro0H0=
X-Received: by 10.55.175.132 with SMTP id y126mr1915466qke.45.1510336851676;
 Fri, 10 Nov 2017 10:00:51 -0800 (PST)
MIME-Version: 1.0
Received: by 10.140.102.70 with HTTP; Fri, 10 Nov 2017 10:00:51 -0800 (PST)
In-Reply-To: <xmqq60aihgod.fsf@gitster.mtv.corp.google.com>
References: <CAKohponsPQC6qTw99+xh1RSu0bZNDSo5TbbZZcYmup3NOW6QmA@mail.gmail.com>
 <CAGZ79ka9VnzYTYgtWgGAhvgn2LRpP_BCQyVvQ8iC1w9XJnRxEw@mail.gmail.com> <xmqq60aihgod.fsf@gitster.mtv.corp.google.com>
From:   Stefan Beller <sbeller@google.com>
Date:   Fri, 10 Nov 2017 10:00:51 -0800
Message-ID: <CAGZ79kZ8PKBwe+aWTUOgPwV2tNQS7+dUrLTVsWhzemj-e35kaA@mail.gmail.com>
Subject: Re: [Query] Separate hooks for Git worktrees
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Viresh Kumar <viresh.kumar@linaro.org>,
        Git Mailing List <git@vger.kernel.org>,
        Vincent Guittot <vincent.guittot@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Nov 9, 2017 at 9:00 PM, Junio C Hamano <gitster@pobox.com> wrote:
> Stefan Beller <sbeller@google.com> writes:
>
>> We have no worktree specific config yet, though patches for
>> this were floated on the mailing list.
>>
>> Though recent versions of git learned to conditionally include
>> config files. (look for includeIf in man git-config), which I think
>> could be used to set the option gerrit.createChangeId  depending
>> on the worktree you are in.
>>
>>> Any idea how I can get around this problem without having separate
>>> repositories for kernel and android ?
>>
>> The proposed approach above might be hacky but sounds as if
>> it should work?
>
> If you meant "conditional include" by "proposed approach above", I
> do not see which part you found possibly hacky.

Compared to a per-worktree configuration that you can setup via

    git config --for-worktree=X key value

the setup using conditional includes seems hacky to me.
(I just realize that these conditional includes can be set using
regular git-config, so maybe it is not as hacky as I thought.)

>  It is to allow
> different set of configurations to apply depending on where you are
> working at, which I think was invented exactly for something like
> this.

From a UX perspective, I can imagine a way easier workflow,
but the data model seems to make sense.

> It certainly is not any hackier than using the same repository to
> house separately manged projects even if they may be related
> projects.

Well it is the same project with different upstream workflows.
For example I would imagine that Viresh wants to cherry-pick
from one branch to another, or even send the same patch
(just with different commit messages, with or without the
ChangeId) to the different upstreams?

> Where does the aversion of "having separate repositories" primarily
> come from?  Is it bad due to disk consumption?  Is it bad because
> you cannot do "git diff android-branch kernel-branch"?  Something
> else?

Yeah, that is an interesting question!
(I suspect workflow related things, diff/cherry-pick)

> If it is purely disk consumption that is an issue, perhaps the real
> solution is to make it easier to maintain separate repositories
> while sharing as much disk space as possible.  GC may have to be
> made a lot more robust in the presense of alternate object stores,
> for example.
