Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.6 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 37DE91F442
	for <e@80x24.org>; Thu,  9 Nov 2017 19:14:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753214AbdKITOr (ORCPT <rfc822;e@80x24.org>);
        Thu, 9 Nov 2017 14:14:47 -0500
Received: from mail-qt0-f182.google.com ([209.85.216.182]:55287 "EHLO
        mail-qt0-f182.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752622AbdKITOq (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 9 Nov 2017 14:14:46 -0500
Received: by mail-qt0-f182.google.com with SMTP id c36so2842415qtc.11
        for <git@vger.kernel.org>; Thu, 09 Nov 2017 11:14:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=whF+6robA97+MvJNyRfOZ7UnInYBJWAOaCZ6x8jWphI=;
        b=sXpT2QQYmJJA2FB+amZndcpx0npWR4XTFb3RW7UKHI6z68ckCJoAOcJl9wiwKZHk7f
         oY+aUT8T0GPRxTZw5DUdiM7UNh365XKn3rmDxMckJZ6KsuCvKQBbnRfIxgkamQnEycz6
         vvc34qdUqeCxmqv5Jx0AEr1GprysqBqbtbmJ6Eq/C/hO0B+IVNn50q/MwskUWnuwOm+n
         bsxlWw2BMJ4fJJCRxjDd8e+AbGk1XGF0QOpVr892zNgiNHA/AD7lP8Ov2r/gV1hdAu4i
         sNBlpPXuKod2wChDYRjmhc1I+TRhCn4uESiZpbHYXw+xeEK9MuSBuOii4SGfYiyHs/Ip
         3j7w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=whF+6robA97+MvJNyRfOZ7UnInYBJWAOaCZ6x8jWphI=;
        b=OAf6y4SWjQBT0wkwjkHuhyjp+zPQqvieYsyNcP0iiF/uxieug05vfzCngbEyODI9ca
         eWi7kcPrKcffBvsAWQ3/0HdTK3a5A5ypKaC15scG24el0ivt0lGqqCH2mlxdYYgbfRsy
         FK94brhd0tHYIv0bouox1Eo/4d0NUuy2AQOcT7Akw9BnYGZ64nSol30fpdoBQsedoUf4
         cnMz4n3t/9QpKVSsE51N3nGqIcvFtBuBuvDp/cHS/r0JWLO5lXpQFRg105QTPi+hE2dI
         OdEs9YQpL4wvVoWZydK6m8BoAoq1jg7lmmcJzEP7RcxxpUGGppknVxvxvn678yyGzIkv
         bE5A==
X-Gm-Message-State: AJaThX6uf/hTCoC2bQLMAeomUi0y6GOx7wwDw+2hRsj+TN70gV2I3Yx5
        5/AZrez2mudMYBaLge5z51mRrwV7EALgtCfNbASONw==
X-Google-Smtp-Source: AGs4zMZ4OdxCSqkiyh0R/LCnuVcD5MPVDz+MJcC2fGLFAGJvLuyP5r8SaiwjK6Kx5XTiF+8QepvxBIDUS/SzsZaTues=
X-Received: by 10.237.37.71 with SMTP id w7mr2564086qtc.299.1510254885882;
 Thu, 09 Nov 2017 11:14:45 -0800 (PST)
MIME-Version: 1.0
Received: by 10.140.102.70 with HTTP; Thu, 9 Nov 2017 11:14:45 -0800 (PST)
In-Reply-To: <CAKohponsPQC6qTw99+xh1RSu0bZNDSo5TbbZZcYmup3NOW6QmA@mail.gmail.com>
References: <CAKohponsPQC6qTw99+xh1RSu0bZNDSo5TbbZZcYmup3NOW6QmA@mail.gmail.com>
From:   Stefan Beller <sbeller@google.com>
Date:   Thu, 9 Nov 2017 11:14:45 -0800
Message-ID: <CAGZ79ka9VnzYTYgtWgGAhvgn2LRpP_BCQyVvQ8iC1w9XJnRxEw@mail.gmail.com>
Subject: Re: [Query] Separate hooks for Git worktrees
To:     Viresh Kumar <viresh.kumar@linaro.org>
Cc:     Git Mailing List <git@vger.kernel.org>,
        Junio C Hamano <gitster@pobox.com>,
        Vincent Guittot <vincent.guittot@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Nov 9, 2017 at 2:58 AM, Viresh Kumar <viresh.kumar@linaro.org> wrote:
> Hi,
>
> I have a typical use case, where I am using the same
> repository for both Android and Linux kernel branches.
>
> Android needs us to keep a special hook "commit-msg"
> which adds a "Change-Id" to every commit we create.

The standard hook for Gerrit can be {en,dis}-abled via
  git config gerrit.createChangeId {true, false}

> While this works fine with Android, the behavior doesn't change
> by simply changing to a upstream kernel branch and eventually
> by mistake I may end up sending patch with Change-Id to upstream
> kernel as well. And I want to avoid that.
>
> I am looking at ways to make this configuration work for me by
> applying the hook only for Android branches.
>
> I tried using the "git worktrees" command to create a separate
> linked tree for my android branch, but it doesn't have a .git directory
> but just a file linking to the main repository.

We have no worktree specific config yet, though patches for
this were floated on the mailing list.

Though recent versions of git learned to conditionally include
config files. (look for includeIf in man git-config), which I think
could be used to set the option gerrit.createChangeId  depending
on the worktree you are in.

> Any idea how I can get around this problem without having separate
> repositories for kernel and android ?

The proposed approach above might be hacky but sounds as if
it should work?

Thanks,
Stefan
