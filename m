Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.2 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 304C21F404
	for <e@80x24.org>; Wed, 15 Aug 2018 15:21:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729527AbeHOSOC (ORCPT <rfc822;e@80x24.org>);
        Wed, 15 Aug 2018 14:14:02 -0400
Received: from mail-it0-f65.google.com ([209.85.214.65]:55404 "EHLO
        mail-it0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729347AbeHOSOB (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 15 Aug 2018 14:14:01 -0400
Received: by mail-it0-f65.google.com with SMTP id d10-v6so2199422itj.5
        for <git@vger.kernel.org>; Wed, 15 Aug 2018 08:21:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=47niag9qzgrqNdFWS3vdrWteB+oLjO6cqJD3gi0L+yQ=;
        b=tVdXtIJenYgSqIEjHlPI+Mq+MRsqJjP/Va3dyasVAevSm7XLXnXqirEerOzDlIGDnC
         WSqwVuKOCblJTzFWMvsXWYdBhehGBVJF42XIgV6bjQKsoGAJflQnjP0ggWqG9Im9po6q
         DTOwbU2J/FT2/AFDF4ZVFfcQCcMtIMGZFzLgmlOgHsJn5K7lkYUZXySIEFjuLzZQjSNv
         2nhuP9B63TKtQaJph6Hb8NTgHo8ZEn/PDIsvTrqs8M0rM29RkXQ+68ZY7QzegT6fUJSy
         A+9ljDFoAJe3jykpzAAaVpg4EvvjCPmlaiecumxzMt1meXxixd4I7awXjcciel0XwVVB
         giQQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=47niag9qzgrqNdFWS3vdrWteB+oLjO6cqJD3gi0L+yQ=;
        b=WxYds4RbtwsREhPy4OcE16OI/k0UDCU4drRK77KIvmqXcCL3LSs/8Bnh0J2C+uP53W
         gBMLhxpkLKuMnyCMg6GgJJQBGu/jCqhzCPl9/wlyV6peDZj0PuBTZyFJAm90ehNdf1sq
         q6DZ6gFnrLCtd4p3D4zZh5KnTGT+j6F65OVuKKnNeNSwrEiLqvA2sbU/9BwosXL8tEwV
         lhX5SDzWGYPBsQ0A4JmP4BUTsPAaqYsunQMum6RwOfcJwWvXh08Cqh/EbldITvWrJFCL
         FIKjhxaDEUm3cuktwkWJGF1evqdt7ADNW8k+g0/qb/6g5Tdj6rZhZmVIwa0ulSeNL+Ut
         YvAA==
X-Gm-Message-State: AOUpUlE+Y+ZEU7MzcYcJb2Hplp27abYPgkSHj/y7LzfsfylwlCXb54G5
        /cRNPvJmaeT1Z7wVFKMUf0LZcrUynHkAxug+wt8=
X-Google-Smtp-Source: AA+uWPystxvD1zwYDETX/Ilgr3erFDZc2Sdc6vMWO1xHu6G+BZyPSc+TuSr78wZSP83ZOx6/skHwB6U7ZDagu/XvGNg=
X-Received: by 2002:a24:c888:: with SMTP id w130-v6mr19546332itf.78.1534346486483;
 Wed, 15 Aug 2018 08:21:26 -0700 (PDT)
MIME-Version: 1.0
References: <95e4f9df528a40bf3f3e648318904500343abf9a.camel@infinera.com>
 <20180814223820.123723-1-sbeller@google.com> <xmqqo9e4y2gr.fsf@gitster-ct.c.googlers.com>
 <xmqqk1osy1qo.fsf@gitster-ct.c.googlers.com>
In-Reply-To: <xmqqk1osy1qo.fsf@gitster-ct.c.googlers.com>
From:   Duy Nguyen <pclouds@gmail.com>
Date:   Wed, 15 Aug 2018 17:20:59 +0200
Message-ID: <CACsJy8DH+c0tHS9VpirdE97G3+roWhvXfb-jcjW7n-5nuZo3=A@mail.gmail.com>
Subject: Re: [PATCH 1/2] store submodule in common dir
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Stefan Beller <sbeller@google.com>, joakim.tjernlund@infinera.com,
        Git Mailing List <git@vger.kernel.org>,
        Brandon Williams <bmwill@google.com>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Aug 15, 2018 at 1:20 AM Junio C Hamano <gitster@pobox.com> wrote:
> Theoretically we should be able to make modules/kernel%2fv2.[24]
> additional "worktree"s of modules/kernel%2fv2.6, but given that
> these are all "bare" repositories without an attached working tree,
> I am not sure how that would supposed to work.  Thinking about
> having multiple worktrees on a single bare repository makes me head
> spin and ache X-<;-)

I could only read the mail subject this morning and thought a bit
about it on the train, and came to the same conclusion that "git
worktree" is the way to go.

The bareness should not affect this at all.  If you meant core.bare,
it can only affect the main repo. But what I'm thinking is repos with
only linked worktrees and no main one. So when you "submodule update"
a repo, you "clone -n", then "git worktree add" to put a worktree in
place. The repo is strictly speaking not bare, it just does not have a
main worktree.

The main HEAD should be detached so that it does not block any
worktree from checking out branches. If we could get away without the
main HEAD, that would be great, but HEAD is part of the repo signature
so it has to stay (and we may end up keeping more objects for this
HEAD even after every other heads don't need the same objects
anymore).

This also solves the problem with mupltiple worktrees on a repo with
submodules, where we have the same problems (if I add a new worktree
of the superproject, where do the new submodules go?). In this case
ideally all worktrees should have separate ref namespaces to maintain
the "separate repo" view that we currently have, but I guess we can
live with sharing refs for a while.

And simply sharing $GIT_DIR/modules won't work. For starter, it breaks
existing setups. What I've wanted to do is adding a shared "common"
directory. Then you could have "common/modules" (among other future
common stuff), which is shared across all worktrees, but you don't
have to add extra share rules since it's already covered by the
"common" rule.
-- 
Duy
