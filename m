Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 7DCAC211B4
	for <e@80x24.org>; Sun,  6 Jan 2019 18:19:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726072AbfAFSTw (ORCPT <rfc822;e@80x24.org>);
        Sun, 6 Jan 2019 13:19:52 -0500
Received: from mail-qt1-f193.google.com ([209.85.160.193]:37431 "EHLO
        mail-qt1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726034AbfAFSTw (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 6 Jan 2019 13:19:52 -0500
Received: by mail-qt1-f193.google.com with SMTP id t33so45517171qtt.4
        for <git@vger.kernel.org>; Sun, 06 Jan 2019 10:19:50 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=yIivrXOrRgLPQaQ4gAJ9hXEv49oBbbpID7+CwkXn0iw=;
        b=Vq1ynce9basT093b8qv1HOOt7c8CXC86iQAron1GnypQiPdzAzITiN+QYdr9LT2GP3
         jQJLAWKeop2rOCqXk8ELZV3VXdD2LnODlgBMnqTGaIql69sI8mHOr59MxsXuYiTGMVLh
         jFsuY7NoGxExRMe1aWy/mpOdKeus2CoUBFP892Na8mbF2MZb0ZloPbc9aMUr4p3mJCJL
         fiY2jQ55LD5Zq/KsaEEQBpHhTUce1I9Tbhv+ja5/ryMDKMk1mlD/I4IybubZpBEPWn1b
         7MyTJObJ5a5p8ToWbXcQbdBAwIuZkjOAiCUJhiml75eG63wnC3ecBkLiYckI34gWVyPl
         eT5g==
X-Gm-Message-State: AJcUukdlgfXEHWWR7Nm0On2u3HOV6EwaRWLJ9ACGffgoYI6SX8o0UZYF
        aQVRotSHZt5Opf4LlKv1QBNxbYBGoOt9w/eugsI=
X-Google-Smtp-Source: ALg8bN426y5XqYz/1SB9t10nW0ejJ9t1f5svUIMhZ1mnQTue5RtIDDQy5rW4EE/VYgTLwhPny0su7rW71t8WrTJAN3U=
X-Received: by 2002:a0c:9d81:: with SMTP id s1mr57694544qvd.82.1546798790211;
 Sun, 06 Jan 2019 10:19:50 -0800 (PST)
MIME-Version: 1.0
References: <20181223192435.24803-1-sunshine@sunshineco.com> <20190106180914.GE25639@hank.intra.tgummerer.com>
In-Reply-To: <20190106180914.GE25639@hank.intra.tgummerer.com>
From:   Eric Sunshine <sunshine@sunshineco.com>
Date:   Sun, 6 Jan 2019 13:19:39 -0500
Message-ID: <CAPig+cT3k4HVNY8B9bFL0Ty2stGVgzDdTuANDE829Fdj-u6S3Q@mail.gmail.com>
Subject: Re: [PATCH] doc/config: do a better job of introducing 'worktree.guessRemote'
To:     Thomas Gummerer <t.gummerer@gmail.com>
Cc:     Git List <git@vger.kernel.org>,
        =?UTF-8?B?0J7Qu9C10LMg0KHQsNC80L7QudC70L7Qsg==?= <splarv@ya.ru>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Sun, Jan 6, 2019 at 1:09 PM Thomas Gummerer <t.gummerer@gmail.com> wrote:
> On 12/23, Eric Sunshine wrote:
> > The documentation for this option jumps right in with "With `add`",
> > without explaining that `add` is a sub-command of "git worktree".
> > Together with rather odd grammatical structure of the remainder of the
> > sentence, the description can be difficult for newcomers to understand.
> > Clarify by improving the grammar and mentioning "git worktree add"
> > explicitly.
>
> Thanks, this reads much better indeed.  I was briefly wondering if a
> similar change is needed in the documentation for the 'git worktree'
> command itself.  It currently reads:
>
>         With `worktree add <path>`, without `<commit-ish>`, instead
>         of creating a new branch from HEAD, if there exists a tracking
>         branch in exactly one remote matching the basename of `<path>`,
>         base the new branch on the remote-tracking branch, and mark
>         the remote-tracking branch as "upstream" from the new branch.
>
> I do think the documentation for the config option is slightly easier
> to read, especially with your improvements below.  Dunno if it's worth
> adjusting the test in the 'git worktree' documentation as well?

Such a change to git-worktree.txt could be done, though I think it's
outside the scope of this patch since "With ...," is not nearly so
confusing in the context of git-worktree.txt given that the reader
_knows_ that he/she is reading (exclusively) about "git worktree".
Also, almost all of the options in git-worktree.txt are phrased "With
...,", so such a change would be more all-encompassing.
