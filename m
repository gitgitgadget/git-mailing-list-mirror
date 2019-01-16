Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-11.6 required=3.0 tests=AWL,BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,USER_IN_DEF_DKIM_WL
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 783781F62E
	for <e@80x24.org>; Wed, 16 Jan 2019 22:07:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732898AbfAPWHf (ORCPT <rfc822;e@80x24.org>);
        Wed, 16 Jan 2019 17:07:35 -0500
Received: from mail-ed1-f65.google.com ([209.85.208.65]:35036 "EHLO
        mail-ed1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732926AbfAPWGh (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 16 Jan 2019 17:06:37 -0500
Received: by mail-ed1-f65.google.com with SMTP id x30so6761108edx.2
        for <git@vger.kernel.org>; Wed, 16 Jan 2019 14:06:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=iM9o9LIbl92AYb40QqLPBMi6cQKPmXxu2xh/5tdRXe0=;
        b=CkXjB4gA3VZjvI2z9+N8FW/xBzbnlq27V4LR3NXpo34lst61oj9qz2t6nlkxOBdxwn
         yb3uqNAvdCBuFOoydNCI8c4Qten4F1NU69lR93HQ2OoB6xc47RmVrsRqrygZ4PCvDJwE
         bWAk86VzRN1o2wCikPYjyJk6nw5dA7q/Cd3/i2Q8EzpYoDFZkURUntjFB8elssR9U0Vq
         pt3lbK7xf/AV37OQdg1MPEP8+uMi2b3d03KfFy7ICYHun+oV2xJ/SN8BhShP6C1j3PcT
         ha08qQcqMTnPj1na+yRvkdM6xMoYlzBbHOKr8xFFJ6diqvtBeuVfrgkiZBqob8uQocuG
         ux+g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=iM9o9LIbl92AYb40QqLPBMi6cQKPmXxu2xh/5tdRXe0=;
        b=mTRWJX24kJnYyMg7IikB23+6FIQPIscjjVLrVF/8RftY6CvK+9mr6fYddk/AbVUkJ5
         NiISHmN9fTCjGhGjuAAB3LN0jPdFKcssRsDSHgI6cHDIHxtEDF8KAUwN8kf4EN1uIt0H
         8mV5qSD5CFpd+NFrqdidn7ib0y6rMs4yA11HaMV28LDaotYu4rIc5rvlJtYoW1qIRu73
         YGG5jDk/zi5EJsIcoi/ssylTa/7oxplYzZ22PVmr4lNnXYcaY4Rid02bC4EoBHFa85nT
         o3u5tPCvdZOeRXPfEB/YaJ8bYJ/jcqFI0w8FjVkbpuof9coVSmwFIh+zaIayc2mAOjmr
         0OnA==
X-Gm-Message-State: AJcUukcSgxSFK+uEQMsdqduwQyWBskAPw2ISiPTZRqY/VQ9reEn15Xye
        hrjpLz3KLe5r1S1M0fH9muFK1mpJH1WUGWpdLxkJ3g==
X-Google-Smtp-Source: ALg8bN4J5rOZmB2t4g1OM1PRQ8fcePXGxayyI9WHWaD6TredcBzteb7x84cbfvc7JACAzvYy1pd8mXVYjAQxsbIRX3U=
X-Received: by 2002:a50:f70a:: with SMTP id g10mr8908891edn.25.1547676395604;
 Wed, 16 Jan 2019 14:06:35 -0800 (PST)
MIME-Version: 1.0
References: <20190116103159.9305-1-pclouds@gmail.com> <20190116103159.9305-2-pclouds@gmail.com>
In-Reply-To: <20190116103159.9305-2-pclouds@gmail.com>
From:   Stefan Beller <sbeller@google.com>
Date:   Wed, 16 Jan 2019 14:06:24 -0800
Message-ID: <CAGZ79kYWi0EDr-XvoXm=-Oo-_9FiieNHbWzA5o8TiirLw+xXBg@mail.gmail.com>
Subject: Re: [PATCH 01/10] doc: about submodule support with multiple worktrees
To:     =?UTF-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41jIER1eQ==?= 
        <pclouds@gmail.com>
Cc:     git <git@vger.kernel.org>,
        =?UTF-8?Q?Tomasz_=C5=9Aniatowski?= <tsniatowski@vewd.com>,
        Jonathan Nieder <jrnieder@gmail.com>,
        Marc Branchaud <marcnarc@xiplink.com>,
        Junio C Hamano <gitster@pobox.com>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

> The third problem is a big and complicaed one. Submodule clones

complicated

> (inside the superproject) are per-worktree. So if you have two
> worktrees, and these have one submodule, you need space for _two_
> clones. This is definitely not elegant. The tenative plan is to move

tentative?

> clones from $GIT_COMMON_DIR/worktrees/X/modules to
> $GIT_COMMON_DIR/common/modules.

... from the submodule side of things this is big problem,
as the submodule is usually assumed at $GIT_DIR/modules/<name>
(I think we have not been strict in $GIT_DIR $GIT_COMMON_DIR
in the submodule code)

So the plan is to neither use
$GIT_COMMON_DIR/worktrees/X/modules/Y
$GIT_COMMON_DIR/modules/Y/worktrees/X
but to create a new third location at
$GIT_COMMON_DIR/common/modules
to which either new submodule worktrees
or superproject worktrees that happen to have this submodule
can point to?

>
> The latter directory is shared across all worktrees. Once we keep the
> clone in a common place, the submodule's worktree can be created and
> managed with git-worktree[1].

So even when the user has never heard of worktrees, the internal structure
will be worktree oriented, the common dir in common/modules/Y and in
$GIT_DIR/modules/Y we could just have a worktree git dir?

> Another good point about this approach is we could finally safely
> allow "git worktree remove" to work with submodules. With current
> solution, removing $GIT_COMMON_DIR/worktrees/X directory means also
> removing potentially precious clones inside the "modules" subdir.

yup, very sensible.

I like this approach very much.
