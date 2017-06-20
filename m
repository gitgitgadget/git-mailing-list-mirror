Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.2 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD shortcircuit=no
	autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id DEBF520282
	for <e@80x24.org>; Tue, 20 Jun 2017 21:31:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752479AbdFTVbh (ORCPT <rfc822;e@80x24.org>);
        Tue, 20 Jun 2017 17:31:37 -0400
Received: from mail-pg0-f42.google.com ([74.125.83.42]:34001 "EHLO
        mail-pg0-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751979AbdFTVbg (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 20 Jun 2017 17:31:36 -0400
Received: by mail-pg0-f42.google.com with SMTP id e187so15733976pgc.1
        for <git@vger.kernel.org>; Tue, 20 Jun 2017 14:31:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:cc:subject:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=3QgbIlxSejfCFfpjjEJW3TMGhfv2ZgZSUca8HpZ2dWA=;
        b=kcZMePkt/34fpL7SLthl+IyWQ8HosfH5rcrxG5/sxE80d31QcdCMh9EWipq3Mqn82j
         LCdpHEXW7c00qYxlqpE2qvAGgzer0kD9cNMEiwl/NZibenHTKt9PO9rnwky39D7Dcmq/
         lHmxevq5qTsgeh42lWvVDtww5ZgYStEkbksKq27g7KXJhr8tWm8DkLI5dg0JiYfPWVBh
         K6/MAUZdQhCvJ4PFGMHniXFu4thLsNKb+XTYC1rsrQfDoxny+HuXeSMfQCSErOjalFwM
         3xqvjSIvmitM/BlJqpJ1VKwBXisYNHu5sdWuAUZl07KUbnD0O67ebUA+LgiiIpnfa5zV
         b/0A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=3QgbIlxSejfCFfpjjEJW3TMGhfv2ZgZSUca8HpZ2dWA=;
        b=Z5i//NCOYIfW1OzwllTB5tpARbnNiccD+RW8pu+rXebVHclX837t8o5VSCHFH7qrCd
         6kmzqBl/dGDhNz1UoTCHUbOXatC+j+U5hkj8a9gwcORvSLOTMt0chAuGx84vb2JlYJ6w
         bd0OMhzYErpilRMP7GnX/TqbArW32THBWha2d67bbKr1cNRN6/NnvvbnicOu9956Ln5V
         DkkaKv1haAf4Uea2dLvQjzXp8ICQDQWZl1OIuW0wPBPxBzaUOvdVTYG/P3O3qRZzpHMA
         NPS0dQu4Pu8KDwPA6D8ID8gdB2zviw9nOksignA5tw3AX8pYVNlZWv/5Pa2wHuGn5gnt
         yn3g==
X-Gm-Message-State: AKS2vOzFPz7QtOjyk5ZZO6Wcyx0CHRsmnL+ARTBE45Vu9B/S7fd2rizC
        yNu/qtkLU8un8BYTtbtmrbtP
X-Received: by 10.99.151.1 with SMTP id n1mr34083980pge.255.1497994295229;
        Tue, 20 Jun 2017 14:31:35 -0700 (PDT)
Received: from twelve2.svl.corp.google.com ([2620:0:100e:422:6c40:b92c:899d:9917])
        by smtp.gmail.com with ESMTPSA id g10sm26816421pgr.18.2017.06.20.14.31.34
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Tue, 20 Jun 2017 14:31:34 -0700 (PDT)
Date:   Tue, 20 Jun 2017 14:31:30 -0700
From:   Jonathan Tan <jonathantanmy@google.com>
To:     Brandon Williams <bmwill@google.com>
Cc:     git@vger.kernel.org, sbeller@google.com, jrnieder@gmail.com,
        jacob.keller@gmail.com, Johannes.Schindelin@gmx.de,
        sandals@crustytoothpaste.net, peartben@gmail.com,
        pclouds@gmail.com, gitster@pobox.com, peff@peff.net,
        git@jeffhostetler.com, avarab@gmail.com
Subject: Re: [PATCH v3 04/20] repository: introduce the repository object
Message-ID: <20170620143130.6816e85f@twelve2.svl.corp.google.com>
In-Reply-To: <20170620191951.84791-5-bmwill@google.com>
References: <20170608234100.188529-1-bmwill@google.com>
        <20170620191951.84791-1-bmwill@google.com>
        <20170620191951.84791-5-bmwill@google.com>
X-Mailer: Claws Mail 3.9.3 (GTK+ 2.24.23; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, 20 Jun 2017 12:19:35 -0700
Brandon Williams <bmwill@google.com> wrote:

> Introduce the repository object 'struct repository' which can be used to
> hold all state pertaining to a git repository.
> 
> Some of the benefits of object-ifying a repository are:
> 
>   1. Make the code base more readable and easier to reason about.
> 
>   2. Allow for working on multiple repositories, specifically
>      submodules, within the same process.  Currently the process for
>      working on a submodule involves setting up an argv_array of options
>      for a particular command and then launching a child process to
>      execute the command in the context of the submodule.  This is
>      clunky and can require lots of little hacks in order to ensure
>      correctness.  Ideally it would be nice to simply pass a repository
>      and an options struct to a command.
> 
>   3. Eliminating reliance on global state will make it easier to
>      enable the use of threading to improve performance.

These would indeed be nice to have.

> +/* called after setting gitdir */
> +static void repo_setup_env(struct repository *repo)
> +{
> +	struct strbuf sb = STRBUF_INIT;
> +
> +	if (!repo->gitdir)
> +		BUG("gitdir wasn't set before setting up the environment");
> +
> +	repo->different_commondir = find_common_dir(&sb, repo->gitdir,
> +						    !repo->ignore_env);
> +	repo->commondir = strbuf_detach(&sb, NULL);
> +	repo->objectdir = git_path_from_env(DB_ENVIRONMENT, repo->commondir,
> +					    "objects", !repo->ignore_env);
> +	repo->graft_file = git_path_from_env(GRAFT_ENVIRONMENT, repo->commondir,
> +					     "info/grafts", !repo->ignore_env);
> +	repo->index_file = git_path_from_env(INDEX_ENVIRONMENT, repo->gitdir,
> +					     "index", !repo->ignore_env);
> +}

It seems that this function is only used once in repo_set_gitdir() -
could this be inlined there instead? Then you wouldn't need the comment
and the !repo->gitdir check.

> +static int verify_repo_format(struct repository_format *format,
> +			      const char *commondir)
> +{
> +	int ret = 0;
> +	struct strbuf sb = STRBUF_INIT;
> +
> +	strbuf_addf(&sb, "%s/config", commondir);
> +	read_repository_format(format, sb.buf);
> +	strbuf_reset(&sb);
> +
> +	if (verify_repository_format(format, &sb) < 0) {
> +		warning("%s", sb.buf);
> +		ret = -1;
> +	}
> +
> +	strbuf_release(&sb);
> +	return ret;
> +}

This function is confusingly named - firstly, there is already a
verify_repository_format(), and secondly, this function both reads and
verifies it.

> +void repo_clear(struct repository *repo)
> +{
> +	free(repo->gitdir);
> +	repo->gitdir = NULL;
> +	free(repo->commondir);
> +	repo->commondir = NULL;
> +	free(repo->objectdir);
> +	repo->objectdir = NULL;
> +	free(repo->graft_file);
> +	repo->graft_file = NULL;
> +	free(repo->index_file);
> +	repo->index_file = NULL;
> +	free(repo->worktree);
> +	repo->worktree = NULL;
> +
> +	memset(repo, 0, sizeof(*repo));
> +}

If you're going to memset, you probably don't need to set everything to
NULL.

> +	/* Configurations */
> +	/*
> +	 * Bit used during initialization to indicate if repository state (like
> +	 * the location of the 'objectdir') should be read from the
> +	 * environment.  By default this bit will be set at the begining of
> +	 * 'repo_init()' so that all repositories will ignore the environment.
> +	 * The exception to this is 'the_repository', which doesn't go through
> +	 * the normal 'repo_init()' process.
> +	 */
> +	unsigned ignore_env:1;

If this is only used during initialization, could this be passed as a
separate parameter internally instead of having it here?
