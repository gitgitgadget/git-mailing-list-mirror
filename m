Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-11.7 required=3.0 tests=AWL,BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,USER_IN_DEF_DKIM_WL
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 557E820248
	for <e@80x24.org>; Thu, 18 Apr 2019 18:30:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390679AbfDRSaG (ORCPT <rfc822;e@80x24.org>);
        Thu, 18 Apr 2019 14:30:06 -0400
Received: from mail-oi1-f202.google.com ([209.85.167.202]:40855 "EHLO
        mail-oi1-f202.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2389842AbfDRSaE (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 18 Apr 2019 14:30:04 -0400
Received: by mail-oi1-f202.google.com with SMTP id q82so1313568oif.7
        for <git@vger.kernel.org>; Thu, 18 Apr 2019 11:30:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=8zGygdQZkWZA/LhVWii3lFkGBVtLcprBjTnMwUzgOIc=;
        b=P1vRG2lbI+lnCv7srL2eqRaQ/2VTZYLY4qmyBwQ7kBq2Uj3Af8+BiERcBpqXk5Zoyh
         idnoyVftTLKnmx34FanhGAK3LG2TNFSxMR/rOVnJ9s6OtfULJKZ/FQOzXgVmJK8nq060
         pIWJjW0tTLKOxAiwOl6TGfjPDZ9n/WsPj9qjNkoRtzT+UH+lQxTxon6x+deu3dwFQWSK
         Sx7oVOmzfQKolV9qKCB4qSVTC41pqpsccZptCFTZgyh7IyChaCXKYlsLHlqle5dDiW+b
         tjJKLh51U3MPuT2n86yDswsWBQ3i3GTRGL8e3pxjnDVh5Lq+yJ+CukkfgHX5wg4sXiD7
         9gew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=8zGygdQZkWZA/LhVWii3lFkGBVtLcprBjTnMwUzgOIc=;
        b=dxq428tMH/2D55fD0lWJVoh0D4ujfJ7o99CPt6Hehedt7NKUrFBm+iMkAD/ovdSeIT
         Frsw0QHt/Z5JnH2TYj07TpH0vha7qlEUCvLyq+s24hkjSCl9lqXCTaj+/nRxhHP2JlWr
         XlTVdtwbXmVLc5g2y5ztrfw3HBl+DUI8EyJEPl1uNJ/sCpWX4Us19DDMEaUGUV8XbTft
         s8H6r13IwjBgwN81VhWfT9w+ly86V610jonarbXwYSYkSQlLNb+GWp1N1qJ3hdfnOG9D
         nyShPcugPs79zFzWZq9Yg0joTF9rEJ1tQgMTEnO2N0CZQM3v1NMymYS2Alubi/v7nIWV
         bM9A==
X-Gm-Message-State: APjAAAWW9muQwsBonMXtQyiQ2h0LvryzsFYDyfJvmoicqtSPuom7vcK0
        AOjvgFvKeqDn3mwYByFqqEZwl6n65q/STrgUakl9
X-Google-Smtp-Source: APXvYqw7P/XHm6jT2+4lRg0y4UDs5lOzKUTuFzqp/tPz148eft4OAYt+4oR8UInS7xRf1pQuVn3fcUZAzhLf+RymXYOI
X-Received: by 2002:aca:6289:: with SMTP id w131mr2877353oib.84.1555612203877;
 Thu, 18 Apr 2019 11:30:03 -0700 (PDT)
Date:   Thu, 18 Apr 2019 11:30:00 -0700
In-Reply-To: <CACsJy8BygpTQg5=8+2KkFCpaJBEkKx+ocVZoa0yRBAQvnkXVSw@mail.gmail.com>
Message-Id: <20190418183000.78138-1-jonathantanmy@google.com>
Mime-Version: 1.0
References: <CACsJy8BygpTQg5=8+2KkFCpaJBEkKx+ocVZoa0yRBAQvnkXVSw@mail.gmail.com>
X-Mailer: git-send-email 2.21.0.314.g8007d49101.dirty
Subject: Re: [PATCH] worktree: update is_bare heuristics
From:   Jonathan Tan <jonathantanmy@google.com>
To:     pclouds@gmail.com
Cc:     jonathantanmy@google.com, git@vger.kernel.org,
        Johannes.Schindelin@gmx.de, rappazzo@gmail.com
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

> You actually didn't spell out the problem with "git branch -D", or at
> least the consequence (i.e. the submodule branch is deleted even if
> it's checked out).

Thanks - I'll do that in the commit message.

> >         strbuf_add_absolute_path(&worktree_path, get_git_common_dir());
> > -       is_bare = !strbuf_strip_suffix(&worktree_path, "/.git");
> > -       if (is_bare)
> > +       if (!strbuf_strip_suffix(&worktree_path, "/.git"))
> >                 strbuf_strip_suffix(&worktree_path, "/.");
> 
> We can just call these two calls unconditionally, right? No harm done
> if we don't strip.

We can, and no harm done. But this if/then pattern is also repeated in
other parts of the file (e.g. get_linked_worktree()) so I'll leave it in
for consistency. (Also, for what it's worth, it's slightly faster if
only one strip is done.)

> >         strbuf_addf(&path, "%s/HEAD", get_git_common_dir());
> >
> >         worktree = xcalloc(1, sizeof(*worktree));
> >         worktree->path = strbuf_detach(&worktree_path, NULL);
> > -       worktree->is_bare = is_bare;
> > +       worktree->is_bare = (is_bare_repository_cfg == 1) ||
> 
> core.bare and core.worktree are special. When you access them standing
> from the main worktree, you'll see them. But when you stand from a
> secondary worktree, they are ignored.

Just checking: I think that is_bare_repository_cfg ignores core.bare
only if the config.worktree file is present? In the t2402 test '"list"
all worktrees from linked with a bare main', "git worktree list" still
observes the main worktree as bare. But in any case, you are right that
core.bare is sometimes ignored.

> It's more obvious with
> core.worktree because if that affects all worktrees, what's the point
> of having multiple worktrees. Git will always go to the place
> core.worktree points out.

That's true.

> So if this function is called from a secondary worktree, I'm not sure
> if it still works as expected because is_bare_repo may be false then.

I think you're right that is_bare_repository() will always return false
here. So let's look at the cases where, running from a secondary
worktree, we think that the main worktree should be observed as bare:

 - main worktree did not define core.bare
   - I don't know if this is possible (remember that we're running from
     a secondary worktree). But if it is, it seems that
     is_bare_repository_cfg will be -1, and worktree->is_bare will be
     set to 0 regardless of whether or not it is bare.

 - main worktree defines core.bare as 1; no config.worktree
   - is_bare_repository_cfg is 1, so we see the main worktree as bare.
     (This case is tested in t2402 '"list" all worktrees from linked
     with a bare main'.)

 - main worktree defines core.bare as 1, and secondary worktree defines
   core.bare as 0
   - I think that we'll see is_bare_repository_cfg as 0, so we won't see
     the main worktree as bare.

The only potentially problematic case seems to be the 3rd one.

> For the submodule case, you always stand at the submodule's main
> worktree, so it still works.

Yes.

> I don't think multiple-worktrees-on-submodules will be coming soon, so
> it's probably ok. But maybe leave a note here.

Observing that the problematic case is the 3rd one above, would this
note work:

  NEEDSWORK: If this function is called from a secondary worktree and
  config.worktree is present, is_bare_repository_cfg will reflect the
  contents of config.worktree, not the contents of the main worktree.
  This means that worktree->is_bare may be set to 0 even if the main
  worktree is configured to be bare.
