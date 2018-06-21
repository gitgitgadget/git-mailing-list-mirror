Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-11.4 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI,T_DKIMWL_WL_MED,USER_IN_DEF_DKIM_WL shortcircuit=no
	autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id DACBC1F516
	for <e@80x24.org>; Thu, 21 Jun 2018 23:06:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933951AbeFUXGO (ORCPT <rfc822;e@80x24.org>);
        Thu, 21 Jun 2018 19:06:14 -0400
Received: from mail-it0-f73.google.com ([209.85.214.73]:36045 "EHLO
        mail-it0-f73.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S933446AbeFUXGN (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 21 Jun 2018 19:06:13 -0400
Received: by mail-it0-f73.google.com with SMTP id d70-v6so257071itd.1
        for <git@vger.kernel.org>; Thu, 21 Jun 2018 16:06:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:date:in-reply-to:message-id:references:subject:from:to
         :cc;
        bh=3RoYPUtTpvXSun6BgCioR6t58TQHe2kPg++kjDaHwA8=;
        b=ngEOXMqYsB++Tz8CB1cL8/NOanTHJ1XJA3Zlx6b1iY2bJUUpBS1IDT+e3/3GVBr1NI
         K1CxUyOzJu+aeyhcwks/FzGyph9zMQCL5GKx1EBPaB3J7U5/HArEaVAQe8xfnUghESWU
         F30Gw7PnWPNbvDf5xIUc6D7AnPNmIjh8icW3AoRQCDhk1K2isnbCvnERMBj4CrUM6a1J
         n5I1Z6wZF06hFWBrKVAUwWoPAlGd45+hNHivCxuPsNjOkBpYF/H1MtQTx4A8UyzUUeK9
         /+xMszNNHW4v3aUIDDVsUUt9RC+Neq5I0zBGbfpvm4wUqJJu/EwSJ/wcro9GPYnjwzIA
         nCKg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:date:in-reply-to:message-id
         :references:subject:from:to:cc;
        bh=3RoYPUtTpvXSun6BgCioR6t58TQHe2kPg++kjDaHwA8=;
        b=nmEoIYVy7YmXsoME2aOkjQShacmdPoCC4TgRm3Ox9R4NOZR8O7NsfVTxFxdYez3MlV
         9fcILH51YZaKVR2KY7gilYAtBk0Hwe6TJihlsnwchqYo/hWb9wy35X0G+woZoKiMJrLX
         GCo871wFGar+o2CRHZuAmqmahhTMolj616e1uQMIlPr6emWITmfI5clASQ01jiosvgg1
         NHP0G8YQQx8ydliuf+NfhkMoTIMmcZ4hoJcYeHHRqOQZXdCbOQ7s8Nx+T/OGvlQcF00g
         L+g6/yYxA2senKyObGMmfzQ0Y5+uH1owhM1jahklFhEfqdDzshOsCid3V5+wI8FVCR5m
         +i4w==
X-Gm-Message-State: APt69E3lcgeo3tmYbmcbDhC4qvdGiobRuJFR6Drh1JjG0jxgVxRcLGG0
        LHHG8vtZ/mRQKBc6FgisWWHBEKDxR+cm/a3Le8b5
X-Google-Smtp-Source: ADUXVKL1rDgGzBPnnnEJddT6uvgYFdG6xCqbccQ+Wv0aE9RbnCndn9gYYGJMTXHr/380gMCBeeLUYp41M1+GM19kw/Ml
MIME-Version: 1.0
X-Received: by 2002:a24:62ca:: with SMTP id d193-v6mr3340038itc.21.1529622372578;
 Thu, 21 Jun 2018 16:06:12 -0700 (PDT)
Date:   Thu, 21 Jun 2018 16:06:08 -0700
In-Reply-To: <CAGZ79kYYD48PQiSqjqHkrqX9stKbGmEAHc1ArsuUgSHhwv5=Vw@mail.gmail.com>
Message-Id: <20180621230608.86117-1-jonathantanmy@google.com>
References: <CAGZ79kYYD48PQiSqjqHkrqX9stKbGmEAHc1ArsuUgSHhwv5=Vw@mail.gmail.com>
X-Mailer: git-send-email 2.18.0.rc2.347.g0da03f3a46.dirty
Subject: Re: [PATCH 5/5] commit-graph: add repo arg to graph readers
From:   Jonathan Tan <jonathantanmy@google.com>
To:     sbeller@google.com
Cc:     jonathantanmy@google.com, git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

> > diff --git a/commit.c b/commit.c
> > index 0030e79940..38c12b002f 100644
> > --- a/commit.c
> > +++ b/commit.c
> > @@ -317,7 +317,7 @@ struct tree *get_commit_tree(const struct commit *commit)
> >         if (commit->graph_pos == COMMIT_NOT_FROM_GRAPH)
> >                 BUG("commit has NULL tree, but was not loaded from commit-graph");
> >
> > -       return get_commit_tree_in_graph(commit);
> > +       return get_commit_tree_in_graph(the_repository, commit);
> 
> Here..
> 
> >  }
> >
> >  struct object_id *get_commit_tree_oid(const struct commit *commit)
> > @@ -413,7 +413,7 @@ int parse_commit_gently(struct commit *item, int quiet_on_missing)
> >                 return -1;
> >         if (item->object.parsed)
> >                 return 0;
> > -       if (parse_commit_in_graph(item))
> > +       if (parse_commit_in_graph(the_repository, item))
> 
> and here
> 
> > +static void test_parse_commit_in_graph(const char *gitdir, const char *worktree,
> > +                                      const struct object_id *commit_oid)
> > +{
> > +       struct repository r;
> > +       struct commit *c;
> > +       struct commit_list *parent;
> > +
> > +       /*
> > +        * Create a commit independent of any repository.
> > +        */
> > +       c = lookup_commit(commit_oid);
> 
> .. and this one are unfortunate as the rest of the object store series
> has not progressed as far as needed.

I think the first 2 are in reverse - get_commit_tree depends on
get_commit_tree_in_graph and parse_commit_gently depends on
parse_commit_in_graph, so we need the commit-graph functions to be
changed first. But I agree about lookup_commit.

> The lookup_commit series is out there already, and that will
> teach lookup_commit a repository argument. When rerolling
> that series I need to switch the order of repo_init and lookup_commit
> such that we can pass the repo to the lookup.

For future reference, Stefan is talking about this series:
https://public-inbox.org/git/20180613230522.55335-1-sbeller@google.com/

Let me know if you want to reroll yours on top of mine, or vice versa. I
think it's clearer if mine goes in first, though, since (as you said in
that e-mail) parse_commit depends on this change in the commit graph.

> This is really nice!
> 
> Overall this series looks good to me,
> Stefan

Thanks - let's see what others think.
