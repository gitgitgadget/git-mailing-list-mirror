Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-11.4 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI,T_DKIMWL_WL_MED,USER_IN_DEF_DKIM_WL shortcircuit=no
	autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id AE82D1F516
	for <e@80x24.org>; Thu, 21 Jun 2018 22:42:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933918AbeFUWmD (ORCPT <rfc822;e@80x24.org>);
        Thu, 21 Jun 2018 18:42:03 -0400
Received: from mail-yw0-f194.google.com ([209.85.161.194]:40085 "EHLO
        mail-yw0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S933653AbeFUWmC (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 21 Jun 2018 18:42:02 -0400
Received: by mail-yw0-f194.google.com with SMTP id p129-v6so1748500ywg.7
        for <git@vger.kernel.org>; Thu, 21 Jun 2018 15:42:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=6P4hrl88jiCx1pNDAYWv/WYXwTL6X3P6yIhTPb/RToA=;
        b=pO7peN6uw0andwncqA3V09N0JoEK4To6QRL6o3Yq/n9wnvUpxO9JqnS9IeLEAvXvhd
         iz4fFINYKte6OrRTwhaLj9qEdWIga4WNceoU8aRELCtPLEkxUidsPq959o4OyMuoikXt
         kcbGhXc7FM/QvxhkE00Sx6G6yw8+c/PB8yVYLup3wLkC8hx824+ZcJCCvT4PZAtE1fqp
         iQSKFktovOV+ZwuEC6+oJXG8szjYap4dfxsYYhV1GYdKNU21t9JOUJWYjwbocUJJuEok
         1uBrf+oOBE/R9wOekRNq4Jouyqhi8dsZG4uMD8b26fLhsjKpg0rVAOx2iaqF7wDfap9n
         RnJQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=6P4hrl88jiCx1pNDAYWv/WYXwTL6X3P6yIhTPb/RToA=;
        b=DHnkFIO2EtU4ILlkNO52QEX9yFzocJ7lhezLddLF64IGDtul3El9ew2OaosH7c+QO2
         EH4VHn9mNm3ObKxS+N/bU5uqlItDg3G8c2SVmsD2Q4rmd2eDpqgtKqdTfh1pEeBUaTKN
         eVDdCUQD3gZkrQizwzFdW6xKv8CsNBs8Lal+B+vWfet1CUdNNlRFOUti4Q3BOceBJUWm
         gGUb9rSlYzGpAvLXX7nij047uA0hmrutwTjKULQpKMVkq71FL9wTuvsco/uVwoEc4PpJ
         YaEbZy4lUV6VlWWL/zscFXPs7PtEXKI6V5Nc1GtVKi2GwlZqLY/RmUwrAiZTUZytjBNc
         A9Uw==
X-Gm-Message-State: APt69E00uAv1MOLyxESNKMAQDAPnZqEtZS9aqvdh1E2NmP9C5chZ9eg8
        mFulcmDTiOCPiLFsUBUeVTbNX4h8PnjYuSrtvY2cxg==
X-Google-Smtp-Source: ADUXVKKPwC5yv+qShRTII88sNVEvlwHYn1FH8tVJ6m1lp/oQoSUQWTCWQB7prTUzN2kU7Isnc2pNjJWbSS42hVzRm6g=
X-Received: by 2002:a81:e544:: with SMTP id c4-v6mr13015448ywm.345.1529620921000;
 Thu, 21 Jun 2018 15:42:01 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1529616356.git.jonathantanmy@google.com> <da1a513f2508602e0736b6fbe142b2445948bd5c.1529616356.git.jonathantanmy@google.com>
In-Reply-To: <da1a513f2508602e0736b6fbe142b2445948bd5c.1529616356.git.jonathantanmy@google.com>
From:   Stefan Beller <sbeller@google.com>
Date:   Thu, 21 Jun 2018 15:41:49 -0700
Message-ID: <CAGZ79kYYD48PQiSqjqHkrqX9stKbGmEAHc1ArsuUgSHhwv5=Vw@mail.gmail.com>
Subject: Re: [PATCH 5/5] commit-graph: add repo arg to graph readers
To:     Jonathan Tan <jonathantanmy@google.com>
Cc:     git <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

> diff --git a/commit.c b/commit.c
> index 0030e79940..38c12b002f 100644
> --- a/commit.c
> +++ b/commit.c
> @@ -317,7 +317,7 @@ struct tree *get_commit_tree(const struct commit *commit)
>         if (commit->graph_pos == COMMIT_NOT_FROM_GRAPH)
>                 BUG("commit has NULL tree, but was not loaded from commit-graph");
>
> -       return get_commit_tree_in_graph(commit);
> +       return get_commit_tree_in_graph(the_repository, commit);

Here..

>  }
>
>  struct object_id *get_commit_tree_oid(const struct commit *commit)
> @@ -413,7 +413,7 @@ int parse_commit_gently(struct commit *item, int quiet_on_missing)
>                 return -1;
>         if (item->object.parsed)
>                 return 0;
> -       if (parse_commit_in_graph(item))
> +       if (parse_commit_in_graph(the_repository, item))

and here

> +static void test_parse_commit_in_graph(const char *gitdir, const char *worktree,
> +                                      const struct object_id *commit_oid)
> +{
> +       struct repository r;
> +       struct commit *c;
> +       struct commit_list *parent;
> +
> +       /*
> +        * Create a commit independent of any repository.
> +        */
> +       c = lookup_commit(commit_oid);

.. and this one are unfortunate as the rest of the object store series
has not progressed as far as needed.

The lookup_commit series is out there already, and that will
teach lookup_commit a repository argument. When rerolling
that series I need to switch the order of repo_init and lookup_commit
such that we can pass the repo to the lookup.

> +test_expect_success 'setup non-the_repository tests' '

> +test_expect_success 'parse_commit_in_graph works for non-the_repository' '

> +test_expect_success 'get_commit_tree_in_graph works for non-the_repository' '

This is really nice!

Overall this series looks good to me,
Stefan
