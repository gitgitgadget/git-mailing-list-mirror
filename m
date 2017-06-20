Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.2 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD shortcircuit=no
	autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 2CFCE20282
	for <e@80x24.org>; Tue, 20 Jun 2017 21:56:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752515AbdFTV4O (ORCPT <rfc822;e@80x24.org>);
        Tue, 20 Jun 2017 17:56:14 -0400
Received: from mail-pf0-f179.google.com ([209.85.192.179]:36282 "EHLO
        mail-pf0-f179.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752164AbdFTV4O (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 20 Jun 2017 17:56:14 -0400
Received: by mail-pf0-f179.google.com with SMTP id x63so75302862pff.3
        for <git@vger.kernel.org>; Tue, 20 Jun 2017 14:56:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=heRXII5IwAvL62Ia3jZhEb4ZoEkhqSzJGpzVFuFxyyg=;
        b=pFfahiQKGkjqZ1qRtdd+APuqi9fTQhOj1Eh4x/ra2tf4UzfWO+atJ100Ic2b/lihVP
         VqyCrlD6+WkwEh05CcxUC3Nxm6RH8MX/KikrdYbGcs+viDoypHHRuWONVf1Zc8IKQOcm
         TJJxRsOHb5oueAwma8aTAvPz8bIKq9nRe7z5x+E94x4A5TSZ2Q4/udpJ3o2qQcmftVNB
         Ugyubbe0hIHz7PSD3YLZaiZS+c/m1pAs1IEqasETzPbFL9HJTlqvCE3F4pwD4VbmE9Us
         m1KvYZ3GZpHexhubP/kndqj4En0JIcBx45vTOEIg5sOGZQBl9ZXFHSWDuHM3BIbfCyji
         FD7A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=heRXII5IwAvL62Ia3jZhEb4ZoEkhqSzJGpzVFuFxyyg=;
        b=qdMvphQYg3G6nViN80ma21kgGscTYCokVI4ArhULirE7bdG1qhfd8GUXa3m4vsaoxG
         pOdekHttXDvE3++CQruC4zGFazwYffwuTvb39wJFS8/10klwt67ZVBTq3pq4YLI4lHSt
         BcAK8vVYBg+sPBaqJwXzJOL4LGwAwI3Y7Umzme3O9hsqlfgknA5cKEbttZtOMkujIu3W
         B0FvwhC1w4N72fgtVj1e/EDQlDEZ6A0jMmWkBprpepagWe/Yl7H11MeAdbV7yE87hsKC
         W/lwfs5Kdgt6lGeeEnQMG1+cMJgKh6/6W8jIdQf3cDDm5Aq9no259A14T6EiiU9fYG44
         Ncbw==
X-Gm-Message-State: AKS2vOxSCpQnfA6VUsB0/u4miBII+nKfUQWLbYYs1oYRbTk6cq4KqAAU
        XxXjXUfhtxnsfEsb
X-Received: by 10.84.196.131 with SMTP id l3mr7246758pld.232.1497995773261;
        Tue, 20 Jun 2017 14:56:13 -0700 (PDT)
Received: from google.com ([2620:0:100e:422:292c:ffc6:f991:bee9])
        by smtp.gmail.com with ESMTPSA id k70sm29235958pfg.72.2017.06.20.14.56.11
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Tue, 20 Jun 2017 14:56:12 -0700 (PDT)
Date:   Tue, 20 Jun 2017 14:56:10 -0700
From:   Brandon Williams <bmwill@google.com>
To:     Jonathan Tan <jonathantanmy@google.com>
Cc:     git@vger.kernel.org, sbeller@google.com, jrnieder@gmail.com,
        jacob.keller@gmail.com, Johannes.Schindelin@gmx.de,
        sandals@crustytoothpaste.net, peartben@gmail.com,
        pclouds@gmail.com, gitster@pobox.com, peff@peff.net,
        git@jeffhostetler.com, avarab@gmail.com
Subject: Re: [PATCH v3 04/20] repository: introduce the repository object
Message-ID: <20170620215610.GC60134@google.com>
References: <20170608234100.188529-1-bmwill@google.com>
 <20170620191951.84791-1-bmwill@google.com>
 <20170620191951.84791-5-bmwill@google.com>
 <20170620143130.6816e85f@twelve2.svl.corp.google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20170620143130.6816e85f@twelve2.svl.corp.google.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 06/20, Jonathan Tan wrote:
> On Tue, 20 Jun 2017 12:19:35 -0700
> Brandon Williams <bmwill@google.com> wrote:
> 
> > Introduce the repository object 'struct repository' which can be used to
> > hold all state pertaining to a git repository.
> > 
> > Some of the benefits of object-ifying a repository are:
> > 
> >   1. Make the code base more readable and easier to reason about.
> > 
> >   2. Allow for working on multiple repositories, specifically
> >      submodules, within the same process.  Currently the process for
> >      working on a submodule involves setting up an argv_array of options
> >      for a particular command and then launching a child process to
> >      execute the command in the context of the submodule.  This is
> >      clunky and can require lots of little hacks in order to ensure
> >      correctness.  Ideally it would be nice to simply pass a repository
> >      and an options struct to a command.
> > 
> >   3. Eliminating reliance on global state will make it easier to
> >      enable the use of threading to improve performance.
> 
> These would indeed be nice to have.
> 
> > +/* called after setting gitdir */
> > +static void repo_setup_env(struct repository *repo)
> > +{
> > +	struct strbuf sb = STRBUF_INIT;
> > +
> > +	if (!repo->gitdir)
> > +		BUG("gitdir wasn't set before setting up the environment");
> > +
> > +	repo->different_commondir = find_common_dir(&sb, repo->gitdir,
> > +						    !repo->ignore_env);
> > +	repo->commondir = strbuf_detach(&sb, NULL);
> > +	repo->objectdir = git_path_from_env(DB_ENVIRONMENT, repo->commondir,
> > +					    "objects", !repo->ignore_env);
> > +	repo->graft_file = git_path_from_env(GRAFT_ENVIRONMENT, repo->commondir,
> > +					     "info/grafts", !repo->ignore_env);
> > +	repo->index_file = git_path_from_env(INDEX_ENVIRONMENT, repo->gitdir,
> > +					     "index", !repo->ignore_env);
> > +}
> 
> It seems that this function is only used once in repo_set_gitdir() -
> could this be inlined there instead? Then you wouldn't need the comment
> and the !repo->gitdir check.

I'd like to keep them separate as it makes things a little clearer in my
opinion, smaller functions and the like.

> 
> > +static int verify_repo_format(struct repository_format *format,
> > +			      const char *commondir)
> > +{
> > +	int ret = 0;
> > +	struct strbuf sb = STRBUF_INIT;
> > +
> > +	strbuf_addf(&sb, "%s/config", commondir);
> > +	read_repository_format(format, sb.buf);
> > +	strbuf_reset(&sb);
> > +
> > +	if (verify_repository_format(format, &sb) < 0) {
> > +		warning("%s", sb.buf);
> > +		ret = -1;
> > +	}
> > +
> > +	strbuf_release(&sb);
> > +	return ret;
> > +}
> 
> This function is confusingly named - firstly, there is already a
> verify_repository_format(), and secondly, this function both reads and
> verifies it.

This one is static to the file, and i don't think its named confusingly
as it does just what it says it does. I'm trying to limit how much other
code I change so I had to make this function.

> 
> > +void repo_clear(struct repository *repo)
> > +{
> > +	free(repo->gitdir);
> > +	repo->gitdir = NULL;
> > +	free(repo->commondir);
> > +	repo->commondir = NULL;
> > +	free(repo->objectdir);
> > +	repo->objectdir = NULL;
> > +	free(repo->graft_file);
> > +	repo->graft_file = NULL;
> > +	free(repo->index_file);
> > +	repo->index_file = NULL;
> > +	free(repo->worktree);
> > +	repo->worktree = NULL;
> > +
> > +	memset(repo, 0, sizeof(*repo));
> > +}
> 
> If you're going to memset, you probably don't need to set everything to
> NULL.
> 
> > +	/* Configurations */
> > +	/*
> > +	 * Bit used during initialization to indicate if repository state (like
> > +	 * the location of the 'objectdir') should be read from the
> > +	 * environment.  By default this bit will be set at the begining of
> > +	 * 'repo_init()' so that all repositories will ignore the environment.
> > +	 * The exception to this is 'the_repository', which doesn't go through
> > +	 * the normal 'repo_init()' process.
> > +	 */
> > +	unsigned ignore_env:1;
> 
> If this is only used during initialization, could this be passed as a
> separate parameter internally instead of having it here?

It would feel a little wonky to be a parameter as 'the_repository' is
initialized differently than a repository would normally be.  Theres
been a lot of cleanup to the setup logic but it would need to be cleaned
up even more to have this be a param.

-- 
Brandon Williams
