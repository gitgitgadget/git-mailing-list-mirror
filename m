Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.5 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 2AE6D1F403
	for <e@80x24.org>; Tue, 19 Jun 2018 16:20:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S966597AbeFSQUz (ORCPT <rfc822;e@80x24.org>);
        Tue, 19 Jun 2018 12:20:55 -0400
Received: from mail-ot0-f193.google.com ([74.125.82.193]:41353 "EHLO
        mail-ot0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S966480AbeFSQUy (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 19 Jun 2018 12:20:54 -0400
Received: by mail-ot0-f193.google.com with SMTP id d19-v6so302724oti.8
        for <git@vger.kernel.org>; Tue, 19 Jun 2018 09:20:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=wbcUsr9PeYV5kvCZBib6lnZ5guG5lecBVaRKy4GCu4Y=;
        b=M7ZAgu8jn0iPu0x3SH9rOtNEcoS8GycCRIBwhWC/QzpCVFz9b1V72XMOOQZgCaqrN7
         8POHriTOXcwrMyVV7BM5JyZMMewHlA4sdyV471ZSXowGCvtrOhP+tz613wCuz5xzFJt/
         dIS8tSUKcgw1StGCHhwL7Wk1AxDTKEgxGzwCB6yPYing35nc0raPIto40Z/0usuuHjK2
         K4jKNz35KLijM/pZWFwvFxN5SQLNCKcwgb7TP7bVcSPKPv+ebYQHUW6xhhX16H/LOeH/
         JePPUDwUjUfnuyBxZ04K7+Wiv7mqLU+iB/0YKk88r9wzd9tXQ76/HmuBY7uKVZx27c+W
         MGqw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=wbcUsr9PeYV5kvCZBib6lnZ5guG5lecBVaRKy4GCu4Y=;
        b=Fz1HxJkkEP8vJMRbd15D9I89+qOHInklDeYZE6re0BQgQLCtmnJgHRJsGdlTR23xyw
         dEyyvgJamSvfhRIrqIjy3zLJ3bHsmFW+P9P5vqySkF0Gr5x8zqIMKoqrFASYvGQhSGUo
         rEuaMTl/Mbfo17Gk+GtSXyxbgl/ct3Q8Slp1ypm+p3SA8BhWIjadDnmsRPWfZGEs1s4M
         wTkdI5fY8ShxnfCz0m9CSKeCtTwwckQNpC2RqgUokNgOU+kB2zxx/uvfisG/4rbtLFp3
         VKk/nMCAK7uM9CipDm8t5+MxAqRgiYLOOjbdmyZ8iJqAo/yIoxWO/q0Aa1lBWXmQuSSG
         /nKQ==
X-Gm-Message-State: APt69E34JCWuX4YFERfocVNfiPS9iMHTkWJFzjFuRdyb+NnY/35ru9QT
        iNbX6WXyJT3iMNDjyonlHSmrUDbCdSzlmLWU9KfNNQ==
X-Google-Smtp-Source: ADUXVKKZnMkD13K80m8P0gJ6klKuj8nDG8/4uAnQ4EVFB+kDqicNV1vhNczry3cxKuiuzwMAPtH2a/XsnQLkdPrLBQ0=
X-Received: by 2002:a9d:55a8:: with SMTP id m37-v6mr11440605oth.75.1529425253828;
 Tue, 19 Jun 2018 09:20:53 -0700 (PDT)
MIME-Version: 1.0
References: <20180618111919.GA10085@book.hvoigt.net> <CACsJy8CJGditaq4CZfJctVAe9QCdapWQW=W--AumH-4RWWd=vA@mail.gmail.com>
 <20180618181215.GB73085@google.com> <20180619103632.GC10085@book.hvoigt.net>
 <CACsJy8DQ-GGEDiV0iA2kTgNgHcT1sSX2Oqb7VZcjyK1nBOFv+A@mail.gmail.com> <20180619160956.GA21384@duynguyen.home>
In-Reply-To: <20180619160956.GA21384@duynguyen.home>
From:   Duy Nguyen <pclouds@gmail.com>
Date:   Tue, 19 Jun 2018 18:20:27 +0200
Message-ID: <CACsJy8CR=Oo8pEGK=5uSizQKi1Fg8eitbLO19LjqiR53uDC0hA@mail.gmail.com>
Subject: Re: Adding nested repository with slash adds files instead of gitlink
To:     Heiko Voigt <hvoigt@hvoigt.net>
Cc:     Brandon Williams <bmwill@google.com>,
        Git Mailing List <git@vger.kernel.org>,
        Stefan Beller <sbeller@google.com>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Jun 19, 2018 at 6:09 PM Duy Nguyen <pclouds@gmail.com> wrote:
> On Tue, Jun 19, 2018 at 05:16:17PM +0200, Duy Nguyen wrote:
> > No actually, we could do better. Let me see if I can come up with a
> > patch or something...
>
> OK. What we currently do is, when we search for potential untracked
> paths for adding to the index, we unconditionally ignore anything
> inside ".git". For example, if "foo" is a submodule, "git add ." will
> visit "foo/.git" then ignore its content completely.
>
> We could do something very similar: when we visit "foo", if "foo/.git"
> exists, we ignore it as well. In other words, we extend from "ignore
> anything inside a git repository" to "ignore anything inside any other
> git worktree".
>
> The following patch basically does that. If you specify "git add
> foo/bar". It will still visit "foo" first, realize that it's a
> submodule and drop it. At the end, it will not report foo/bar as an
> untracked (i.e. add-able) entry, so you can't add it.

Another note (which I added, then thought otherwise and dropped). I
believe this approach also solves the problem that
die_path_inside_submodule() tries to work around.

When you feed a path inside a submodule, read_directory() code does
not realize it and walk through like it's part of the current worktree
(wrong!). But if read_directory() does the right thing from the
beginning, you don't need this trick. We don't even need this trick if
a submodule is not real on worktree (no ".git" directory there) but
registered in the index as a git link because the d/f check should
catch that and complain loudly anyway when you add a new entry.
-- 
Duy
