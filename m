Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-11.4 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI,T_DKIMWL_WL_MED,USER_IN_DEF_DKIM_WL shortcircuit=no
	autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id DDFB01F516
	for <e@80x24.org>; Fri, 22 Jun 2018 17:21:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932885AbeFVRVx (ORCPT <rfc822;e@80x24.org>);
        Fri, 22 Jun 2018 13:21:53 -0400
Received: from mail-io0-f201.google.com ([209.85.223.201]:35448 "EHLO
        mail-io0-f201.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754353AbeFVRVv (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 22 Jun 2018 13:21:51 -0400
Received: by mail-io0-f201.google.com with SMTP id r16-v6so5760615ioj.2
        for <git@vger.kernel.org>; Fri, 22 Jun 2018 10:21:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:date:in-reply-to:message-id:references:subject:from:to
         :cc;
        bh=LSj7FRJjCUugZOjQrMoJ/b7JKp8KZg8akIo2Rg2eAgQ=;
        b=kyFSTHeWT7YjnrD/dUyq33OgqMDTTbMRUYf7HTxcVr9mPDWst4YNxFDzLdnIRTjCcs
         sUflBRAJZNbPA7j2ManVsffnC77OZhsP8L8yRMrai6h2mBFrAa4081CkN5EAYHginevi
         C99GDJ1uQopg2LK7jwNqmZDdvfaVYSZf+tLuhOuXYQGiWiRyDqS5zN2wZ4pIJ513Yuro
         9Yf6kKwqqSMM3J7Bth6PRFRVxwIRuXeYDq/bt3AC94wJo4RF97iZK9TT/rcwYgsJ5lGj
         MX+qP2z1qFIm3ctX0L5bV8JCgmL5Ep2EAlTIg38mF5W+sqSa/Wkc2GGrPnAfcYVmHO4F
         J3Jw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:date:in-reply-to:message-id
         :references:subject:from:to:cc;
        bh=LSj7FRJjCUugZOjQrMoJ/b7JKp8KZg8akIo2Rg2eAgQ=;
        b=Vzxmsp3jfg2YmFv5Gl1UiZEhE59jUOpRJKl7lfztGbHWAaBaXKYV0uD5efL70cSIPD
         Uq7w888JaMrgmLuHmmRqm8H1duhqPqlPqvSk0h3qDlGGpHewUjV1faD6j7UQnJnGhrVO
         zEkcomAiILyWHhKdnJsXeZcCLWpN6a+zobqppv9nGbDCPj9g1MJca2qI4Y1AcwHTdUBM
         wpkLYxd7iiiR5bIz8ghEtCbXwwtsqSza4Te4SRTGPEmf0W6gMWjFh65QlAJIq9oJOqxI
         Yj/sWgY9u/iq5j/zwmnoIPC2QrhUWlkRJ4StK7N+rgcnUGok0b5P6PB4ZocukI1Rbvca
         lFWg==
X-Gm-Message-State: APt69E3LDE8QV0Dxfukt0ZFBCXGYwt9HrE97QpMqhLDyYAr6gK9BTTqj
        5BW7blAqlVvsf09fkwxqse8ByqJoLOKoqgbJZQ8P
X-Google-Smtp-Source: ADUXVKK7H6mOeeaOr6BE8b1Lhq9zE3dGKIkq6paWWAHCewUyN5X3EsQ0d1xkQHSqfAtQnzzaMZqKgd/TV6CCWE822ATQ
MIME-Version: 1.0
X-Received: by 2002:a24:1a44:: with SMTP id 65-v6mr1069949iti.20.1529688111190;
 Fri, 22 Jun 2018 10:21:51 -0700 (PDT)
Date:   Fri, 22 Jun 2018 10:21:46 -0700
In-Reply-To: <d7a42ecf-7261-ec14-5736-b1f9bc70ba64@gmail.com>
Message-Id: <20180622172146.1727-1-jonathantanmy@google.com>
References: <d7a42ecf-7261-ec14-5736-b1f9bc70ba64@gmail.com>
X-Mailer: git-send-email 2.18.0.rc2.347.g0da03f3a46.dirty
Subject: Re: [PATCH 5/5] commit-graph: add repo arg to graph readers
From:   Jonathan Tan <jonathantanmy@google.com>
To:     stolee@gmail.com
Cc:     jonathantanmy@google.com, sbeller@google.com, git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

> On 6/21/2018 7:06 PM, Jonathan Tan wrote:
> >>> diff --git a/commit.c b/commit.c
> >>> index 0030e79940..38c12b002f 100644
> >>> --- a/commit.c
> >>> +++ b/commit.c
> >>> @@ -317,7 +317,7 @@ struct tree *get_commit_tree(const struct commit *commit)
> >>>          if (commit->graph_pos == COMMIT_NOT_FROM_GRAPH)
> >>>                  BUG("commit has NULL tree, but was not loaded from commit-graph");
> >>>
> >>> -       return get_commit_tree_in_graph(commit);
> >>> +       return get_commit_tree_in_graph(the_repository, commit);
> >> Here..
> >>
> >>>   }
> >>>
> >>>   struct object_id *get_commit_tree_oid(const struct commit *commit)
> >>> @@ -413,7 +413,7 @@ int parse_commit_gently(struct commit *item, int quiet_on_missing)
> >>>                  return -1;
> >>>          if (item->object.parsed)
> >>>                  return 0;
> >>> -       if (parse_commit_in_graph(item))
> >>> +       if (parse_commit_in_graph(the_repository, item))
> >> and here
> >>
> >>> +static void test_parse_commit_in_graph(const char *gitdir, const char *worktree,
> >>> +                                      const struct object_id *commit_oid)
> >>> +{
> >>> +       struct repository r;
> >>> +       struct commit *c;
> >>> +       struct commit_list *parent;
> >>> +
> >>> +       /*
> >>> +        * Create a commit independent of any repository.
> >>> +        */
> >>> +       c = lookup_commit(commit_oid);
> >> .. and this one are unfortunate as the rest of the object store series
> >> has not progressed as far as needed.
> > I think the first 2 are in reverse - get_commit_tree depends on
> > get_commit_tree_in_graph and parse_commit_gently depends on
> > parse_commit_in_graph, so we need the commit-graph functions to be
> > changed first. But I agree about lookup_commit.
> >
> >> The lookup_commit series is out there already, and that will
> >> teach lookup_commit a repository argument. When rerolling
> >> that series I need to switch the order of repo_init and lookup_commit
> >> such that we can pass the repo to the lookup.
> > For future reference, Stefan is talking about this series:
> > https://public-inbox.org/git/20180613230522.55335-1-sbeller@google.com/
> >
> > Let me know if you want to reroll yours on top of mine, or vice versa. I
> > think it's clearer if mine goes in first, though, since (as you said in
> > that e-mail) parse_commit depends on this change in the commit graph.
> 
> I was about to comment that I thought 'parse_commit_in_graph' should 
> take a 'struct commit_graph' instead of 'struct repository', except for 
> these lookup_commit() calls will need the repository parameter.

Not sure what you mean by the lookup_commit() calls (if you're referring
to the part quoted above, that is test code), but
parse_commit_in_graph() has to take a struct repository (or at least a
struct object_store, perhaps) because it needs to load the commit graph
for the repository if it is not already loaded.

(An alternative, of course, is to require the user to explicitly load
the graph, but since parse_commit_in_graph() is called from
parse_commit(), I think that this implicit loading is fine.)

> Please also keep in mind that ds/commit-graph-fsck has already updated 
> this method to parse from a specific graph [1]. I'm just waiting for 
> some things like ds/generation-numbers to get into 'master' and some 
> more object-store patches to be final before I re-roll that series. I 
> mentioned this in a message that I had sent, but apparently didn't make 
> it on the list (so I re-sent it recently).
> 
> [1] 
> https://public-inbox.org/git/20180608135548.216405-4-dstolee@microsoft.com/

Thanks - I see that you introduced a new
parse_commit_in_graph_one(struct commit_graph *, struct commit *) and
made the existing parse_commit_in_graph(struct commit *item) use the
former. Combining our changes would be just adding a repository argument
to parse_commit_in_graph() and passing the graph through
parse_commit_in_graph_one() (after prepare_commit_graph() and ensuring
that the graph exists).
