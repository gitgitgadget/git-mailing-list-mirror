Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 1BA781F404
	for <e@80x24.org>; Fri, 20 Apr 2018 19:10:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1750927AbeDTTKW (ORCPT <rfc822;e@80x24.org>);
        Fri, 20 Apr 2018 15:10:22 -0400
Received: from mail-wr0-f178.google.com ([209.85.128.178]:37944 "EHLO
        mail-wr0-f178.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750841AbeDTTKV (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 20 Apr 2018 15:10:21 -0400
Received: by mail-wr0-f178.google.com with SMTP id h3-v6so25575803wrh.5
        for <git@vger.kernel.org>; Fri, 20 Apr 2018 12:10:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version;
        bh=oyJYhofjAEWdpXALeuFqGx+0LtPKtu2gMeU0S2Xqm4Y=;
        b=mKH/EwQJFx6EFh/8ygUvqg5vVlVj712aOzCKiQBtNo3/aQt81rEsujlmTyvSSfDeyQ
         UuFQ/3MxkQ32oVjMy5UasR244nvVWikXsKpXlz9439l84WKc4CzT8gP/zv2/t3TcRzkM
         5DVufeN7Mo8Vyl5Z5aWI+0et2Qhlj9z6tKlqq5f0E2TDVF7LI7ZaOmFehWLqeOKGdp+T
         vi8Dj7FXkO/96lQoOFACEiHUtYutV1a+nUZ05lXMmu8SItMDFNyw5wLD/i0aHOw0Lf2g
         rDrrDYnv3cawLiMLhFGXuzfuiyjcMhSU/ZisYkRANHu/+ECQgwgvkMUOaXe6m01KlRWt
         8kWw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:references:date:in-reply-to
         :message-id:user-agent:mime-version;
        bh=oyJYhofjAEWdpXALeuFqGx+0LtPKtu2gMeU0S2Xqm4Y=;
        b=Y6he7VKWQvdZc9s9397z3y1uh/Fs1RMSOIYLRFp7ccaE+fhk1qsgeUHX27DhuPNadj
         ighrHd/HfUQGrjknM0oh+kQrRjOfqxAyCsRk3D+zNeft1wQaqrN+c5lzkLPYfUkuG+DA
         BaMQmaIwphQG0+49GQHUnhr1EnuwY8QnZjsfYGOsjuxeSBQqNz8sWhAO5EhszZAGZCSS
         9/+sIb8r0MZYqdDcBn7Xd0Y6KVFjD24vBwUuIl89o6i+a6XJnkorFWlLqSDgfpz9xmAy
         KQrJLHVJWi6SPZrdgTsyCDznJ62uFJlZn+WY8Ta6278wlpMbQ77pY77Y2C+MkEN/HOWD
         sSoA==
X-Gm-Message-State: ALQs6tAK9WgUrlzBzr3uBOiERr/6Zyfb2M6xVwfhY3KaFi2XxCgC88e3
        6XivJEqdIsa/wVKI9XjHubAKxKBh
X-Google-Smtp-Source: AIpwx4+/3VFCfcmiJym1h1IppbsIyTXAJkSKFzAC7d4gh979ebp2OOHvqoBMElZJXSymI8uPgh56tQ==
X-Received: by 2002:adf:d1d1:: with SMTP id m17-v6mr4730503wri.96.1524251420022;
        Fri, 20 Apr 2018 12:10:20 -0700 (PDT)
Received: from Laptop-Acer-Aspire-F15 (egc153.neoplus.adsl.tpnet.pl. [83.21.66.153])
        by smtp.gmail.com with ESMTPSA id 58-v6sm12822307wrv.41.2018.04.20.12.10.18
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 20 Apr 2018 12:10:18 -0700 (PDT)
From:   Jakub Narebski <jnareb@gmail.com>
To:     Derrick Stolee <dstolee@microsoft.com>
Cc:     git@vger.kernel.org, Jeff King <peff@peff.net>,
        Stefan Beller <sbeller@google.com>
Subject: Re: [RFC PATCH 12/12] commit-graph: update design document
References: <20180417181028.198397-1-dstolee@microsoft.com>
        <20180417181028.198397-13-dstolee@microsoft.com>
Date:   Fri, 20 Apr 2018 21:10:18 +0200
In-Reply-To: <20180417181028.198397-13-dstolee@microsoft.com> (Derrick
        Stolee's message of "Tue, 17 Apr 2018 18:10:45 +0000")
Message-ID: <86r2n9d78l.fsf@gmail.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.2 (windows-nt)
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Derrick Stolee <dstolee@microsoft.com> writes:

> The commit-graph feature is now integrated with 'fsck' and 'gc',
> so remove those items from the "Future Work" section of the
> commit-graph design document.

See comments below, but this looks good to me.

What is missing from the "Future Work" section (and which was somewhat
implied by now removed "When this feature stabilizes enough to recommend
to most users") is safety against history [view] changing features:
git-replace, shallow clone and grafts file.  I wrote about this in
"Re: [PATCH v8 04/14] graph: add commit graph design document"
https://public-inbox.org/git/86vacsjdcg.fsf@gmail.com/

JN> The problem in my opinion lies in different direction, namely that
JN> commit grafts can change, changing the view of the history.  If we want
JN> commit-graph file to follow user-visible view of the history of the
JN> project, it needs to respect current version of commit grafts - but what
JN> if commit grafts changed since commit-graph file was generated?
JN> 
JN> Actually, there are currently three ways to affect the view of the
JN> history:
JN> 
JN> a. legacy commit grafts mechanism; it was first, but it is not safe,
JN>    cannot be transferred on fetch / push, and is now deprecated.
JN> 
JN> b. shallow clones, which are kind of specialized and limited grafts;
JN>    they used to limit available functionality, but restrictions are
JN>    being lifted (or perhaps even got lifted)
JN> 
JN> c. git-replace mechanism, where we can create an "overlay" of any
JN>    object, and is intended to be among others replacement for commit
JN>    grafts; safe, transferable, can be turned off with "git
JN>    --no-replace-objects <command>"
JN> 
JN> All those can change; some more likely than others.  The problem is if
JN> they change between writing commit-graph file (respecting old view of
JN> the history) and reading it (where we expect to see the new view).
JN> 
JN> a. grafts file can change: lines can be added, removed or changed
JN> 
JN> b. shallow clones can be deepened or shortened, or even make
JN>    not shallow
JN> 
JN> c. new replacements can be added, old removed, and existing edited
JN> 
JN> 
JN> There are, as far as I can see, two ways of handling the issue of Git
JN> features that can change the view of the project's history, namely:
JN> 
JN>  * Disable commit-graph reading when any of this features are used, and
JN>    always write full graph info.
JN> 
JN>    This may not matter much for shallow clones, where commit count
JN>    should be small anyway, but when using git-replace to stitch together
JN>    current repository with historical one, commit-graph would be
JN>    certainly useful.  Also, git-replace does not need to change history.
JN> 
JN>    On the other hand I think it is the easier solution.
JN> 
JN> Or
JN> 
JN>  * Detect somehow that the view of the history changed, and invalidate
JN>    commit-graph (perhaps even automatically regenerate it).
JN> 
JN>    For shallow clone changes I think one can still use the old
JN>    commit-graph file to generate the new one.  For other cases, the
JN>    metadata is simple to modify, but indices such as generation number
JN>    would need to be at least partially calculated anew.

Note that in all cases one can simply discard generation number
information (treating it as if it was ZERO), and use commit-graph as
values before applying history-changing feature: replacements, grafts or
shallow.

Well, at least for shallow you can do that for generation numbers: using
grafts (deprecated) or replacements to join repository with historical
one would mean that we are no longer have commit-graph transitively
closed under reachability.

>
> Signed-off-by: Derrick Stolee <dstolee@microsoft.com>
> ---
>  Documentation/technical/commit-graph.txt | 9 ---------
>  1 file changed, 9 deletions(-)
>
> diff --git a/Documentation/technical/commit-graph.txt b/Documentation/technical/commit-graph.txt
> index d9f2713efa..d04657b781 100644
> --- a/Documentation/technical/commit-graph.txt
> +++ b/Documentation/technical/commit-graph.txt
> @@ -118,9 +118,6 @@ Future Work
>  - The commit graph feature currently does not honor commit grafts. This can
>    be remedied by duplicating or refactoring the current graft logic.
>  
> -- The 'commit-graph' subcommand does not have a "verify" mode that is
> -  necessary for integration with fsck.
> -

All right (though "verify" mode is actually done via "check" command).

>  - After computing and storing generation numbers, we must make graph
>    walks aware of generation numbers to gain the performance benefits they
>    enable. This will mostly be accomplished by swapping a commit-date-ordered
> @@ -142,12 +139,6 @@ Future Work
>    such as "ensure_tree_loaded(commit)" that fully loads a tree before
>    using commit->tree.
>  
> -- The current design uses the 'commit-graph' subcommand to generate the graph.
> -  When this feature stabilizes enough to recommend to most users, we should
> -  add automatic graph writes to common operations that create many commits.
> -  For example, one could compute a graph on 'clone', 'fetch', or 'repack'
> -  commands.
> -

I'm not sure if this paragraph should be deleted as a whole; it depends
on whether we decide that using git-gc to do automatic graph writes is
enough (git-gc should be ran automatically by git if we get many new
objects anyway, so this gives us almost "compute a graph on 'clone',
'fetch', or 'repack'").

>  - A server could provide a commit graph file as part of the network protocol
>    to avoid extra calculations by clients. This feature is only of benefit if
>    the user is willing to trust the file, because verifying the file is correct
