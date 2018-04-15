Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 5DB341F404
	for <e@80x24.org>; Sun, 15 Apr 2018 22:48:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751931AbeDOWsY (ORCPT <rfc822;e@80x24.org>);
        Sun, 15 Apr 2018 18:48:24 -0400
Received: from mail-wr0-f181.google.com ([209.85.128.181]:36816 "EHLO
        mail-wr0-f181.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751489AbeDOWsX (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 15 Apr 2018 18:48:23 -0400
Received: by mail-wr0-f181.google.com with SMTP id q13so17538835wre.3
        for <git@vger.kernel.org>; Sun, 15 Apr 2018 15:48:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version;
        bh=zywzVOdWkE/B0RjLTXpYgXBztDlmuj04kvz7dEO98rg=;
        b=SU5sGnh2Em/lGWlUngkbhSHys7zOJE7JNr+IPQdK2m5eQhdB2z1OlTs6WHyK9+dbHC
         KTAjTiXhKMcs8jEWknF+QonXx9jW7rdV8OLyHk/gzqN/UxcSVNjdK9aN6FyY7hv7/BLn
         ZaQAbqTXc6tCeajOzhxSjIyTvagWQFl6IIxGQiGW52aHap6QMFrvW3XjM4ZWBvD3e2v7
         EafWN3WAPwZDkB3/z604ObdBBQAS4InMRTKWaufFa1vJ02Y5V9Q2JcoEONC1tWAHnhp2
         xr00pvDmOmOaU2u5/tztrvFBQUpxr8fytItO7CpQlb9WpZDDMhX0l46sxQczq3QiIRa8
         mUfg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:references:date:in-reply-to
         :message-id:user-agent:mime-version;
        bh=zywzVOdWkE/B0RjLTXpYgXBztDlmuj04kvz7dEO98rg=;
        b=T34dDV2XQfDXDBGy8bVv/5Sm2s1t9ZtBqau+y4Bdr5xLthCbFbB+ExN7bcFm5gcyqQ
         xEvrYq55WvLXk2BTSnXlC/STv9PpTuvOynfu5Cz2s1C5dE9rLYB8aCGOfB9X+4xxb5iQ
         6+OQ4ZTcbxvZDJIjC/WKjC/AAFmZybKiFsHyxR1b8RMBTXaZI44Dgk42CzdBZutdkh++
         LC1Oity6SicZIM0S7zJpfBDTBZvdPS8GSrUEGqVDIO/KfrEwButxkL1MK4mBh53jWMe7
         FgQXEnKJg0mIaHoUDVnAtgBwjAdwxylgvkNZWNHyR9QUegivs8WokysxBT5PSXaMGBiU
         ekmA==
X-Gm-Message-State: ALQs6tAbCQq1hkJnalh2YixLHFHh2s5zWPFaEW+2uTGQEXHuuNFBMnBz
        caPBepGEfYntxIvWu+TmlmM=
X-Google-Smtp-Source: AIpwx4/S4eG6O/WNEMpm2uFW+pOxqdKVqdMPwN+w9vmeZ2HW3iK3IYD7o2IqfRUQFbNpMYcEdWENrQ==
X-Received: by 10.223.145.162 with SMTP id 31mr8155317wri.124.1523832501544;
        Sun, 15 Apr 2018 15:48:21 -0700 (PDT)
Received: from Laptop-Acer-Aspire-F15 (egm16.neoplus.adsl.tpnet.pl. [83.21.76.16])
        by smtp.gmail.com with ESMTPSA id d18sm8219570wre.5.2018.04.15.15.48.19
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Sun, 15 Apr 2018 15:48:20 -0700 (PDT)
From:   Jakub Narebski <jnareb@gmail.com>
To:     Derrick Stolee <stolee@gmail.com>
Cc:     git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
        Ramsay Jones <ramsay@ramsayjones.plus.com>,
        Stefan Beller <sbeller@google.com>,
        SZEDER =?utf-8?Q?G=C3=A1bor?= <szeder.dev@gmail.com>,
        Jeff Hostetler <git@jeffhostetler.com>,
        Jeff King <peff@peff.net>,
        Derrick Stolee <dstolee@microsoft.com>
Subject: Re: [PATCH v8 04/14] graph: add commit graph design document
References: <20180402203427.170177-1-dstolee@microsoft.com>
        <20180410125608.39443-1-dstolee@microsoft.com>
        <20180410125608.39443-5-dstolee@microsoft.com>
Date:   Mon, 16 Apr 2018 00:48:15 +0200
In-Reply-To: <20180410125608.39443-5-dstolee@microsoft.com> (Derrick Stolee's
        message of "Tue, 10 Apr 2018 08:55:58 -0400")
Message-ID: <86vacsjdcg.fsf@gmail.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.2 (windows-nt)
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Derrick Stolee <stolee@gmail.com> writes:

> +Future Work
> +-----------
> +
> +- The commit graph feature currently does not honor commit grafts. This can
> +  be remedied by duplicating or refactoring the current graft logic.

The problem in my opinion lies in different direction, namely that
commit grafts can change, changing the view of the history.  If we want
commit-graph file to follow user-visible view of the history of the
project, it needs to respect current version of commit grafts - but what
if commit grafts changed since commit-graph file was generated?

Actually, there are currently three ways to affect the view of the
history:

a. legacy commit grafts mechanism; it was first, but it is not safe,
   cannot be transferred on fetch / push, and is now deprecated.

b. shallow clones, which are kind of specialized and limited grafts;
   they used to limit available functionality, but restrictions are
   being lifted (or perhaps even got lifted)

c. git-replace mechanism, where we can create an "overlay" of any
   object, and is intended to be among others replacement for commit
   grafts; safe, transferable, can be turned off with "git
   --no-replace-objects <command>"

All those can change; some more likely than others.  The problem is if
they change between writing commit-graph file (respecting old view of
the history) and reading it (where we expect to see the new view).

a. grafts file can change: lines can be added, removed or changed

b. shallow clones can be deepened or shortened, or even make
   not shallow

c. new replacements can be added, old removed, and existing edited


There are, as far as I can see, two ways of handling the issue of Git
features that can change the view of the project's history, namely:

 * Disable commit-graph reading when any of this features are used, and
   always write full graph info.

   This may not matter much for shallow clones, where commit count
   should be small anyway, but when using git-replace to stitch together
   current repository with historical one, commit-graph would be
   certainly useful.  Also, git-replace does not need to change history.

   On the other hand I think it is the easier solution.

Or

 * Detect somehow that the view of the history changed, and invalidate
   commit-graph (perhaps even automatically regenerate it).

   For shallow clone changes I think one can still use the old
   commit-graph file to generate the new one.  For other cases, the
   metadata is simple to modify, but indices such as generation number
   would need to be at least partially calculated anew.

Happily, you don't need to do this now.  It can be done in later series;
on the other hand this would be required before the switch can be turned
from "default off" to "default on" for commit-graph feature (configured
with core.commitGraph).

So please keep up the good work with sending nicely digestible patch
series.

> +
> +- The 'commit-graph' subcommand does not have a "verify" mode that is
> +  necessary for integration with fsck.

The "read" mode has beginnings of "verify", or at least "fsck", isn't
it?

[...]
> +- The current design uses the 'commit-graph' subcommand to generate the graph.
> +  When this feature stabilizes enough to recommend to most users, we should
> +  add automatic graph writes to common operations that create many commits.
> +  For example, one could compute a graph on 'clone', 'fetch', or 'repack'
> +  commands.

Automatic is good ("git gc --auto").

But that needs handling of view chaning features such as commit grafts,
isn't it?

> +
> +- A server could provide a commit graph file as part of the network protocol
> +  to avoid extra calculations by clients. This feature is only of benefit if
> +  the user is willing to trust the file, because verifying the file is correct
> +  is as hard as computing it from scratch.

Should server send different commit-graph file / info depending on
whether client fetches from refs/replaces/* nameespace?

> +
> +Related Links
> +-------------

Thank you for providing them (together with summary).

> +[0] https://bugs.chromium.org/p/git/issues/detail?id=8
> +    Chromium work item for: Serialized Commit Graph
> +
> +[1] https://public-inbox.org/git/20110713070517.GC18566@sigill.intra.peff.net/
> +    An abandoned patch that introduced generation numbers.
> +
> +[2] https://public-inbox.org/git/20170908033403.q7e6dj7benasrjes@sigill.intra.peff.net/
> +    Discussion about generation numbers on commits and how they interact
> +    with fsck.
> +
> +[3] https://public-inbox.org/git/20170908034739.4op3w4f2ma5s65ku@sigill.intra.peff.net/
> +    More discussion about generation numbers and not storing them inside
> +    commit objects. A valuable quote:
> +
> +    "I think we should be moving more in the direction of keeping
> +     repo-local caches for optimizations. Reachability bitmaps have been
> +     a big performance win. I think we should be doing the same with our
> +     properties of commits. Not just generation numbers, but making it
> +     cheap to access the graph structure without zlib-inflating whole
> +     commit objects (i.e., packv4 or something like the "metapacks" I
> +     proposed a few years ago)."
> +
> +[4] https://public-inbox.org/git/20180108154822.54829-1-git@jeffhostetler.com/T/#u
> +    A patch to remove the ahead-behind calculation from 'status'.
