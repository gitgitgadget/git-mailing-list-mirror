Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD shortcircuit=no
	autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id B66161F8CF
	for <e@80x24.org>; Fri,  9 Jun 2017 14:54:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751612AbdFIOyH (ORCPT <rfc822;e@80x24.org>);
        Fri, 9 Jun 2017 10:54:07 -0400
Received: from mail-pg0-f41.google.com ([74.125.83.41]:32937 "EHLO
        mail-pg0-f41.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751566AbdFIOxU (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 9 Jun 2017 10:53:20 -0400
Received: by mail-pg0-f41.google.com with SMTP id f185so27394650pgc.0
        for <git@vger.kernel.org>; Fri, 09 Jun 2017 07:53:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to
         :user-agent;
        bh=mNYx4ayE/dVGWgpPp9PsF+DyyRmvw5fVRKeKajHo1z0=;
        b=Zr9SnrGZGiYTdihXTqLTjy+woS7X+/z4dYUjeb5eqDBNUoubTcrXa7T4fatuar30HL
         Tvr1vizNNHQqL0941l/rEaJqGrUotriALhWfB7SsfJCoHN4nb5iU5rS76dLsFXyXj8R0
         LChjwN2khqE9fkdFpw8d/D/Mniez/8dY258TyNucWU9CfC/hmSZeDPX2r2GvG7U5/Ny/
         w6u1zKXunMWDXgbUfdqwB9psFBEgoqI6M4n7t201/NidwdG0sXYiuMWa4ZpXA7m3uwhI
         SgWFvxjqAWpm78xnqiWKZKoQDlFD67I0uXmlqW5Uh1MsWAI185KzfKS1cajau4t7h5fS
         P+2A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=mNYx4ayE/dVGWgpPp9PsF+DyyRmvw5fVRKeKajHo1z0=;
        b=tjajZWsbF3M7IVNEyIIjC1ceevDfdEw+CoC9VEOc3JEBS/yvpZq0QAQoLoh/WM2a7O
         vfiUleVFelcXo4bV6Sp/EGyLHumy/Y+0pXf1hjdB1h5nBXk5s9mlja9B5WWfQz5N9s9L
         ezc6KHDApZpR3zoDwYrw9ZYOV9l0wO7iyqIF16vnZQtyKs5TewhgBSo8+W9ltv1I8VFb
         pMj880OUpXR1FEj5w1Gf+cIZB4P3vzhPUoh1HuaSMMyyf74AFS8JInHSBTiLimRxTWzd
         vt51nyTtdS6y1OTquVVcCPbTjQZSSuaur9hJ3gVb76qqVoThT+ipq6ZRQ9L8ldSaREdr
         dluw==
X-Gm-Message-State: AODbwcC+EY8vbf7ewR7vrWq6SkEK7iQaZxkGssFglL+olYEBWsX2fNsM
        kLJpg+h0xLTMTfTD
X-Received: by 10.84.137.3 with SMTP id 3mr40685707plm.68.1497019999659;
        Fri, 09 Jun 2017 07:53:19 -0700 (PDT)
Received: from google.com ([2620:0:100e:422:95c0:15a:33cb:7a91])
        by smtp.gmail.com with ESMTPSA id 18sm3858648pfo.92.2017.06.09.07.53.18
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Fri, 09 Jun 2017 07:53:18 -0700 (PDT)
Date:   Fri, 9 Jun 2017 07:53:17 -0700
From:   Brandon Williams <bmwill@google.com>
To:     =?iso-8859-1?Q?=C6var_Arnfj=F6r=F0?= Bjarmason <avarab@gmail.com>
Cc:     git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 0/2] Add a freez() wrapper
Message-ID: <20170609145317.GB81269@google.com>
References: <20170608234100.188529-8-bmwill@google.com>
 <20170609085346.19974-1-avarab@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20170609085346.19974-1-avarab@gmail.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 06/09, Ævar Arnfjörð Bjarmason wrote:
> On Fri, Jun 9, 2017 at 1:40 AM, Brandon Williams <bmwill@google.com> wrote:
> > Introduce the repository object 'struct repository' which can be used to
> > hold all state pertaining to a git repository.
> > [...]
> > +static void repo_clear_env(struct repository *repo)
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
> > +}
> 
> When seeing this I wondered if it couldn't be less noisy as:

One of the other alternatives is using memset, but that's difficult to
only clear only a few fields.

> 
> > +       freez(repo->gitdir);
> > +       freez(repo->commondir);
> > +       freez(repo->objectdir);
> > +       freez(repo->index_file);
> > +       freez(repo->graft_file);
> > +       freez(repo->namespace);
> 
> It's not a problem with your patch, but something I thought would be
> nice to have in general, so here's a patch series to implement that.

This also could makes things a little less error prone.  Thanks!

> 
> Ævar Arnfjörð Bjarmason (2):
>   git-compat-util: add a freez() wrapper around free(x); x = NULL
>   *.[ch] refactoring: make use of the freez() wrapper
> 
>  alias.c                  |  6 ++----
>  apply.c                  |  3 +--
>  attr.c                   |  6 ++----
>  blame.c                  |  3 +--
>  branch.c                 |  3 +--
>  builtin/am.c             | 18 +++++-------------
>  builtin/clean.c          |  6 ++----
>  builtin/config.c         |  6 ++----
>  builtin/index-pack.c     |  6 ++----
>  builtin/pack-objects.c   | 12 ++++--------
>  builtin/unpack-objects.c |  3 +--
>  builtin/worktree.c       |  6 ++----
>  commit-slab.h            |  3 +--
>  commit.c                 |  3 +--
>  config.c                 |  3 +--
>  credential.c             |  9 +++------
>  diff-lib.c               |  3 +--
>  diff.c                   |  6 ++----
>  diffcore-rename.c        |  6 ++----
>  dir.c                    |  9 +++------
>  fast-import.c            |  6 ++----
>  git-compat-util.h        |  1 +
>  gpg-interface.c          | 15 +++++----------
>  grep.c                   | 12 ++++--------
>  help.c                   |  3 +--
>  http-push.c              | 24 ++++++++----------------
>  http.c                   | 15 +++++----------
>  imap-send.c              |  3 +--
>  line-log.c               |  6 ++----
>  ll-merge.c               |  3 +--
>  mailinfo.c               |  3 +--
>  object.c                 |  3 +--
>  pathspec.c               |  3 +--
>  prio-queue.c             |  3 +--
>  read-cache.c             |  6 ++----
>  ref-filter.c             |  3 +--
>  refs/files-backend.c     |  3 +--
>  refs/ref-cache.c         |  3 +--
>  remote-testsvn.c         |  3 +--
>  rerere.c                 |  3 +--
>  sequencer.c              |  3 +--
>  sha1-array.c             |  3 +--
>  sha1_file.c              |  3 +--
>  split-index.c            |  3 +--
>  transport-helper.c       | 27 +++++++++------------------
>  transport.c              |  3 +--
>  tree-diff.c              |  6 ++----
>  tree-walk.c              |  3 +--
>  tree.c                   |  3 +--
>  49 files changed, 98 insertions(+), 197 deletions(-)
> 
> -- 
> 2.13.0.506.g27d5fe0cd
> 

-- 
Brandon Williams
