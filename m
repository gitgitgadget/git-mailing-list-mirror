Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-11.4 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI,T_DKIMWL_WL_MED,USER_IN_DEF_DKIM_WL shortcircuit=no
	autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id C87B01F516
	for <e@80x24.org>; Wed, 27 Jun 2018 21:59:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S965529AbeF0V7b (ORCPT <rfc822;e@80x24.org>);
        Wed, 27 Jun 2018 17:59:31 -0400
Received: from mail-yw0-f201.google.com ([209.85.161.201]:40058 "EHLO
        mail-yw0-f201.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754947AbeF0V7a (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 27 Jun 2018 17:59:30 -0400
Received: by mail-yw0-f201.google.com with SMTP id i203-v6so2639700ywg.7
        for <git@vger.kernel.org>; Wed, 27 Jun 2018 14:59:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:date:in-reply-to:message-id:references:subject:from:to
         :cc;
        bh=lCjtYlX5jXAq2yvTuCiP8u/zFddAcrJPdi9E6lqmv9c=;
        b=LEFJKfkA/ILyrNmDcYre4wQt1Heu3dMKr6/b/wInmIJgbCv24tdzNauMtwc+bigUmy
         QqCzD3PnOAJrhB5wAd6IThuU6LnATyuMiPrT7u/B5ESaBZyEWrnQK5kwR8lMNlKs+JP6
         Dh3MOahh35E+wdl3tPrI5uOb0O+j0evg5rQ/cQoKscWrTFqxTs8cFWUk7ZcvxG67K8Ex
         F0ID6eW4cfNn0IajH6gDbRHE8AujBjUavnDmfHs0Ijm5l+StZeq9sZ9JCQeDTNDkQEe1
         LJ6gD7dvT9fKPugVXVv/NIoBH5uPqlVRZdIxtO+JG5mkeFUXP1cjuYG8++PNEVcSpvU3
         Js/g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:date:in-reply-to:message-id
         :references:subject:from:to:cc;
        bh=lCjtYlX5jXAq2yvTuCiP8u/zFddAcrJPdi9E6lqmv9c=;
        b=sa77h2Ha8wpqfDw25Tuxf6nW9NzrrkG1zdqPe3MQqfbeBXo/lsXVOR5zldiiQpzpFu
         uYm0eSEnRwl4vg3mGDOSTP+1GibMCxoPQbFd65cM05Vhe3f7487PPoYJ85IringABbKE
         eONAYzMdcWrhVfWlMG4sYJeu07i6bejZLgHMN1rnunKcXlju8wBhBvQNvhBte3iwJ9Ao
         d1VZtcFqDXM4EF6NeOZXHc+k1ygQX6TJoHTzkhlxzBMXC+v6CraRKkDVWYQ5OrBy9HWW
         ly7vc15sWEmfpx02IRifxpfZjDW8IxTh6kYJ9WEXWqLhGhxJlGpim0tt+4QsI3xrEwFF
         ry1A==
X-Gm-Message-State: APt69E1Sflk+jcabD2zpvFETMUAWoHCw/yvjffB7a8z5AiHNpp1bu8qO
        VzTPte+eruVb6/Z1+YExGeiQybCkJMfqWLD5Jf45
X-Google-Smtp-Source: AAOMgpdtOkJvWedtcRSDZZSdd2d87NL2YDuGjitO9ZqHoxsGHUHueBgkFt6uotNiPgBoYHwNQ6gMyOgUuCMtOslzA3Or
MIME-Version: 1.0
X-Received: by 2002:a81:3b07:: with SMTP id i7-v6mr814478ywa.228.1530136770184;
 Wed, 27 Jun 2018 14:59:30 -0700 (PDT)
Date:   Wed, 27 Jun 2018 14:59:26 -0700
In-Reply-To: <20180627132447.142473-8-dstolee@microsoft.com>
Message-Id: <20180627215926.119376-1-jonathantanmy@google.com>
References: <20180627132447.142473-8-dstolee@microsoft.com>
X-Mailer: git-send-email 2.18.0.rc2.346.g013aa6912e-goog
Subject: Re: [PATCH v7 07/22] commit-graph: add 'verify' subcommand
From:   Jonathan Tan <jonathantanmy@google.com>
To:     stolee@gmail.com
Cc:     git@vger.kernel.org, gitster@pobox.com, avarab@gmail.com,
        sbeller@google.com, jnareb@gmail.com, marten.agren@gmail.com,
        dstolee@microsoft.com, Jonathan Tan <jonathantanmy@google.com>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

> +int verify_commit_graph(struct repository *r, struct commit_graph *g)

I haven't had the time to review this patch set, but I did rebase my
object store refactoring [1] on this and wrote a test:

    static void test_verify_commit_graph(const char *gitdir, const char *worktree)
    {
    	struct repository r;
    	char *graph_name;
    	struct commit_graph *graph;
    
    	repo_init(&r, gitdir, worktree);
    
    	graph_name = get_commit_graph_filename(r.objects->objectdir);
    	graph = load_commit_graph_one(graph_name);
    
    	printf("verification returned %d\n", verify_commit_graph(&r, graph));
    
    	repo_clear(&r);
    }

However, it doesn't work because verify_commit_graph() invokes
parse_commit_internal(), which tries to look up replace refs in
the_repository.

I think that verify_commit_graph() should not take a repository argument
for now. To minimize churn on the review of this patch set, and to
minimize diffs when we migrate parse_commit_internal() (and likely other
functions) to take in a repository argument, I would be OK with
something like the following instead:

    int verify_commit_graph(struct commit_graph *g)
    {
	    /*
	     * NEEDSWORK: Make r into a parameter when all functions
	     * invoked by this function are not hardcoded to operate on
	     * the_repository.
	     */
	    struct repository *r = the_repository;
	    /* ... */

As for my rebased refactoring, I'll send the patches to the mailing list
once Junio updates ds/commit-graph-fsck with these latest changes, so
that I can rebase once again on that and ensure that everything still
works.

[1] https://public-inbox.org/git/cover.1529616356.git.jonathantanmy@google.com/
