Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RCVD_IN_SORBS_SPAM,RP_MATCHES_RCVD shortcircuit=no autolearn=no
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 958901F7D2
	for <e@80x24.org>; Mon,  5 Jun 2017 17:53:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751180AbdFERxs (ORCPT <rfc822;e@80x24.org>);
        Mon, 5 Jun 2017 13:53:48 -0400
Received: from mail-pf0-f174.google.com ([209.85.192.174]:33743 "EHLO
        mail-pf0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751168AbdFERxr (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 5 Jun 2017 13:53:47 -0400
Received: by mail-pf0-f174.google.com with SMTP id 83so28657527pfr.0
        for <git@vger.kernel.org>; Mon, 05 Jun 2017 10:53:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=3ZX0klQjLvgpqOZd/C4cHf5zWmFAk/yALPhSiZUYVlU=;
        b=wGoK88FORuKpvDxuGxy/UeEkmL4Z1V3fBLEKIGKXTu2yUoUZkbYfRLAqd8a+UHdH6p
         Ue4C/XmSTBaMYcOlKIuz9cxHeRgtYFDgiNUPl2ktzwxqs+W9CcAcLrnSe9RGdWaksywv
         V6TWe9//undBdKg+FcuwsPAeKkV+Hek14QCvxcIHI7suHO2dnJowecYbSYohlBS22e1c
         N663PoDaGfRyI6ALYgasSSdHv7BXIckfr13KSG8w8/drwwvHuKXPgKEWcPPA30cwY+AV
         IVCZ39J1CprvV7MSW4FJo4lyOwn1YZRdpw4VA/p4TOQWFOqy8x+5WLXzC0qL7z48HsOE
         ESyQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=3ZX0klQjLvgpqOZd/C4cHf5zWmFAk/yALPhSiZUYVlU=;
        b=oDDcH94s+jO8QhnDdFLI86yb483ulg9z1D476VVomFwUujXQ/ed8JM1XCPsPNHjPHD
         hxiIBEV4J9dWxuNNyAEgob0XakqPoK2DBmfZfTu+nrJ5vH7NhwcQNGeex8Fc5qj0yXuw
         ivP0tCxfuKNngd6QVktt6r+L+SJHmXj218qXVDz4oerNy9cHJz2ujxrCdtiCjDtHNaay
         W9FKKIqTDbGPOc9B2eGLe3PqrRe4Pw5AY/eEgjNdpYcPDsKl2bQWg9ZE79sFtPlGUeuC
         IDzSQhPuxHp/9DAbEe2YeL0Pyqh1DMwEWRaAfyhWjd5RrimWQHWcMIV/gmX4NsOpTN2B
         BfAg==
X-Gm-Message-State: AODbwcB+poNgmVZXTZhtNYoobLOUfyUjsiFLMKqOUFPe6Uracg8CBK2s
        ijeyJnbHf9Nx5q/C
X-Received: by 10.99.110.200 with SMTP id j191mr22846482pgc.236.1496685226352;
        Mon, 05 Jun 2017 10:53:46 -0700 (PDT)
Received: from google.com ([2620:0:100e:422:b834:3af4:2e37:8db3])
        by smtp.gmail.com with ESMTPSA id 138sm40996381pgg.67.2017.06.05.10.53.44
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Mon, 05 Jun 2017 10:53:45 -0700 (PDT)
Date:   Mon, 5 Jun 2017 10:53:44 -0700
From:   Brandon Williams <bmwill@google.com>
To:     Stefan Beller <sbeller@google.com>
Cc:     "git@vger.kernel.org" <git@vger.kernel.org>,
        Jonathan Nieder <jrnieder@gmail.com>,
        Jacob Keller <jacob.keller@gmail.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        "brian m. carlson" <sandals@crustytoothpaste.net>,
        Ben Peart <peartben@gmail.com>, Duy Nguyen <pclouds@gmail.com>,
        Junio C Hamano <gitster@pobox.com>,
        Jeff King <peff@peff.net>,
        Jeff Hostetler <git@jeffhostetler.com>,
        =?iso-8859-1?Q?=C6var_Arnfj=F6r=F0?= Bjarmason <avarab@gmail.com>,
        Jonathan Tan <jonathantanmy@google.com>
Subject: Re: [PATCH 06/31] repo: introduce the repository object
Message-ID: <20170605175344.GC40426@google.com>
References: <20170531214417.38857-1-bmwill@google.com>
 <20170531214417.38857-7-bmwill@google.com>
 <CAGZ79kbqsvuBG21teO2kT=H6G-xP0wJbd0f0BTjd9obRMSaxGQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAGZ79kbqsvuBG21teO2kT=H6G-xP0wJbd0f0BTjd9obRMSaxGQ@mail.gmail.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 06/01, Stefan Beller wrote:
> On Wed, May 31, 2017 at 2:43 PM, Brandon Williams <bmwill@google.com> wrote:
> > Introduce the repository object 'struct repo' which can be used hold all
> > state pertaining to a git repository.
> >
> > The aim of object-ifying the repository is to (1) make the code base
> > more readable and easier to reason about and (2) allow for working on
> > multiple repositories, specifically submodules, within the same process.
> >
> > TODO: Add more motivating points for adding a repository object?
> 
> Yes please (or delete this line).
> https://public-inbox.org/git/alpine.DEB.2.21.1.1705221501540.3610@virtualbox/
> 
> > +++ b/repo.c
> > @@ -0,0 +1,124 @@
> > +#include "cache.h"
> > +#include "repo.h"
> > +
> > +/*
> > + * This may be the wrong place for this.
> > + * It may be better to go in env.c or setup for the time being?
> 
> In env.c we say:
> /*
>  * We put all the git config variables in this same object
>  * file, so that programs can link against the config parser
>  * without having to link against all the rest of git.
>  *
>  * In particular, no need to bring in libz etc unless needed,
>  * even if you might want to know where the git directory etc
>  * are.
>  */
> 
> And setup.c only has a few variables that matter there locally.
> So I would think having 'the_repository' in repo.c is acceptable.

And perhaps (far down the road) 'the_repoository' could be removed such
that builtin commands take a pointer to a repo object as a parameter.

> 
> > + */
> > +struct repo the_repository;
> > +
> > +static char *git_path_from_env(const char *envvar, const char *git_dir,
> > +                              const char *path, int fromenv)
> > +{
> > +       if (fromenv) {
> > +               const char *value = getenv(envvar);
> > +               if (value)
> > +                       return xstrdup(value);
> > +       }
> > +
> > +       return xstrfmt("%s/%s", git_dir, path);
> > +}
> > +
> > +static int find_common_dir(struct strbuf *sb, const char *gitdir, int fromenv)
> > +{
> > +       if (fromenv) {
> > +               const char *value = getenv(GIT_COMMON_DIR_ENVIRONMENT);
> > +               if (value) {
> > +                       strbuf_addstr(sb, value);
> > +                       return 1;
> > +               }
> > +       }
> > +
> > +       return get_common_dir_noenv(sb, gitdir);
> > +}
> > +
> > +/* called after setting gitdir */
> > +static void repo_setup_env(struct repo *repo)
> > +{
> > +       struct strbuf sb = STRBUF_INIT;
> > +
> > +       if (!repo->gitdir)
> > +               BUG("gitdir wasn't set before setting up the environment");
> > +
> > +       repo->different_commondir = find_common_dir(&sb, repo->gitdir,
> > +                                                   !repo->ignore_env);
> > +       repo->commondir = strbuf_detach(&sb, NULL);
> > +       repo->objectdir = git_path_from_env(DB_ENVIRONMENT, repo->commondir,
> > +                                           "objects", !repo->ignore_env);
> > +       repo->index_file = git_path_from_env(INDEX_ENVIRONMENT, repo->gitdir,
> > +                                            "index", !repo->ignore_env);
> > +       repo->graft_file = git_path_from_env(GRAFT_ENVIRONMENT, repo->commondir,
> > +                                            "info/grafts", !repo->ignore_env);
> > +       repo->namespace = expand_namespace(repo->ignore_env ? NULL :
> > +                                          getenv(GIT_NAMESPACE_ENVIRONMENT));
> > +}
> > +
> > +static void repo_clear_env(struct repo *repo)
> > +{
> > +       free(repo->gitdir);
> > +       repo->gitdir = NULL;
> > +       free(repo->commondir);
> > +       repo->commondir = NULL;
> > +       free(repo->objectdir);
> > +       repo->objectdir = NULL;
> > +       free(repo->index_file);
> > +       repo->index_file = NULL;
> > +       free(repo->graft_file);
> > +       repo->graft_file = NULL;
> > +       free(repo->namespace);
> > +       repo->namespace = NULL;
> 
> I wonder if we can defer the NULL assignments to
> repo_clear, where we would just do a
> memset(repo, 0, sizeof(struct repo));
> 

Yeah perhaps, clearing the env should either be done when setting gitdir
again (so setting up the env will happen again and we don't need to
clear the fields) or clearing the struct as a whole so using memset
would work.

> > +
> > +       repo_set_gitdir(repo, resolved_gitdir);
> > +
> > +       /* NEEDSWORK: Verify repository format version */
> 
> Care to elaborate on this? I do not understand why we would want
> to check the format version here?

When opening up a repository git needs to check if it understands the
repository format and all extensions.  If it doesn't git needs to bail
out and not operate on the repository.  So a part of initializing a repo
object would be to verify that it understands the repository format
version.

> 
> > +
> > +extern void repo_set_gitdir(struct repo *repo, const char *path);
> > +extern int repo_init(struct repo *repo, const char *path);
> > +extern void repo_clear(struct repo *repo);
> 
> The init and clear method seem obvious to me, but what do we need the
> repo_set_gitdir for externally? I would assume the repo auto-discovers its
> gitdir on its own?

Well I didn't completely overhaul the setup code in this series so I
really just hooked into where the setup code already sets the gitdir,
hence why this function is exposed atm.

-- 
Brandon Williams
