Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	FROM_EXCESS_BASE64,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 0780D1F42D
	for <e@80x24.org>; Thu, 24 May 2018 21:15:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S971583AbeEXVPq (ORCPT <rfc822;e@80x24.org>);
        Thu, 24 May 2018 17:15:46 -0400
Received: from mail-wm0-f66.google.com ([74.125.82.66]:55796 "EHLO
        mail-wm0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S967358AbeEXVPo (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 24 May 2018 17:15:44 -0400
Received: by mail-wm0-f66.google.com with SMTP id a8-v6so8859371wmg.5
        for <git@vger.kernel.org>; Thu, 24 May 2018 14:15:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:references:user-agent:in-reply-to:date
         :message-id:mime-version;
        bh=jtlZnp2WbHAs9624OY9N8rmu38IC5A2Oc4m4uZxQqaQ=;
        b=U0Db1lPbSrOXzxjOF8EBu2sbeY8Hfg7nAbx7A/Bssyc2IYqjefzpDgtRYwtvcw6dsy
         NwpOIFh00yj6upX9YdbcScehkZEO6PQrhXayo7CkIqKOxWPdG/6e9TZmzdiPcWXpA/GO
         /KU9TlT66b/FxGq5ssfG4n756ZndbhTOUE2VoCdVa7SWO4qrvqWQLXxVrg9KNo+kSbmL
         ayM14w1c/6Vngpj6KyGcqLOsIGlA+XDaLDjLB42IzZJCAojtyYlw2lFPC1hPHThjnmY7
         1L4OiWN5IE6S8UJu6VcFmpZT6Zk8t3ylQybhfLnA/7yb/bWu2WY+3yLksdmLBK8BzCB/
         iHkw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:references:user-agent
         :in-reply-to:date:message-id:mime-version;
        bh=jtlZnp2WbHAs9624OY9N8rmu38IC5A2Oc4m4uZxQqaQ=;
        b=DD2FqZtInT2IB/z9CQvqJCXV/mE+uQjQ6ajxfhn8BfkPh8cFFpMs9HAXXDOGHtWZ8b
         jrRrtH3VDez2RokWmZN6WujbEKECjXw33m4VAwczavms0EoKqLJ57Z7knjAhg8bGzbgA
         Pr2UobyysP4Czxu+lPqez+NCq6g8RIz5WGG8jh/pnH1fk5jQBP75xX8eMMcjcFIdtAuR
         sWayHnKSceaYwD6RltO0541n4uZ6Jk+Ch6/UQhLe8COiU6tIkIjY4fJw/a2Sz2y6fniO
         /89F8mkIzYx7hlNktI6Y/lHqqgMhIYR0fiWG0mQS6nBBDq7oYBpWFAYFObu2a8qsugIT
         6BWg==
X-Gm-Message-State: ALKqPwdU4MFGaAWTDw+E4ZXpIWKxv6K0kO4EDZjaOCQhJE+wR4+qJwk3
        1qluDl/RABb3OejTf1eMa+Q=
X-Google-Smtp-Source: AB8JxZr1ifSzBkROTXN5ijdltJOIth4CIngTAqmIXShagK7RPYQvmEHMnoavKZSWw7UWiFX+roRjzA==
X-Received: by 2002:a50:b946:: with SMTP id m64-v6mr14018437ede.32.1527196543499;
        Thu, 24 May 2018 14:15:43 -0700 (PDT)
Received: from evledraar (dhcp-089-098-184-206.chello.nl. [89.98.184.206])
        by smtp.gmail.com with ESMTPSA id x49-v6sm12067558edb.5.2018.05.24.14.15.42
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 24 May 2018 14:15:42 -0700 (PDT)
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     Derrick Stolee <dstolee@microsoft.com>
Cc:     "git\@vger.kernel.org" <git@vger.kernel.org>,
        "gitster\@pobox.com" <gitster@pobox.com>,
        "jnareb\@gmail.com" <jnareb@gmail.com>,
        "stolee\@gmail.com" <stolee@gmail.com>,
        "marten.agren\@gmail.com" <marten.agren@gmail.com>,
        "peff\@peff.net" <peff@peff.net>
Subject: Re: [PATCH v3 00/20] Integrate commit-graph into 'fsck' and 'gc'
References: <20180511211504.79877-1-dstolee@microsoft.com> <20180524162504.158394-1-dstolee@microsoft.com>
User-agent: Debian GNU/Linux testing (buster); Emacs 25.2.2; mu4e 1.1.0
In-reply-to: <20180524162504.158394-1-dstolee@microsoft.com>
Date:   Thu, 24 May 2018 23:15:41 +0200
Message-ID: <87po1k7o1u.fsf@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Thu, May 24 2018, Derrick Stolee wrote:

> Thanks for all the feedback on v2. I've tried to make this round's
> review a bit easier by splitting up the commits into smaller pieces.
> Also, the test script now has less boilerplate and uses variables and
> clear arithmetic to explain which bytes are being modified.

Thanks. it's a lot easier.

> One other change worth mentioning: in "commit-graph: add '--reachable'
> option" I put the ref-iteration into a new external
> 'write_commit_graph_reachable()' method inside commit-graph.c. This
> makes the 'gc: automatically write commit-graph files' a simpler change.

Maybe you want this, maybe not, but I came up with this to squash:

    diff --git a/Documentation/config.txt b/Documentation/config.txt
    index 9a3abd87e7..2665522385 100644
    --- a/Documentation/config.txt
    +++ b/Documentation/config.txt
    @@ -900,7 +900,8 @@ the `GIT_NOTES_REF` environment variable.  See linkgit:git-notes[1].

     core.commitGraph::
            Enable git commit graph feature. Allows reading from the
    -       commit-graph file.
    +       commit-graph file. See `gc.commitGraph` for automatically
    +       maintaining the file.

     core.sparseCheckout::
            Enable "sparse checkout" feature. See section "Sparse checkout" in
    @@ -1554,10 +1555,10 @@ gc.autoDetach::
            if the system supports it. Default is true.

     gc.commitGraph::
    -       If true, then gc will rewrite the commit-graph file after any
    -       change to the object database. If '--auto' is used, then the
    -       commit-graph will not be updated unless the threshold is met.
    -       See linkgit:git-commit-graph[1] for details.
    +       If true, then gc will rewrite the commit-graph file when
    +       linkgit:git-gc[1] is run. When using linkgit:git-gc[1]
    +       '--auto' the commit-graph will be updated if housekeeping is
    +       required. See linkgit:git-commit-graph[1] for details.

     gc.logExpiry::
            If the file gc.log exists, then `git gc --auto` won't run

I.e. let's mention the new gc.commitGraph in core.commitGraph, and I
think the "any change to the object database" line in gc.commitGraph is
needlessly confusing, let's just say "when git-gc is run".
