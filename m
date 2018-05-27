Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id E09ED1F42D
	for <e@80x24.org>; Sun, 27 May 2018 19:12:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751343AbeE0TMa (ORCPT <rfc822;e@80x24.org>);
        Sun, 27 May 2018 15:12:30 -0400
Received: from mail-wr0-f195.google.com ([209.85.128.195]:33244 "EHLO
        mail-wr0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751291AbeE0TM3 (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 27 May 2018 15:12:29 -0400
Received: by mail-wr0-f195.google.com with SMTP id a15-v6so16925471wrm.0
        for <git@vger.kernel.org>; Sun, 27 May 2018 12:12:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version;
        bh=/FD/G7/6P2T9YdJcq3GH1rXTkM05LfWKbF1m0hD2QkM=;
        b=oCiWGkrmbt3rf1q8R/DMEu3yXc20ugpYCN0wfg6T17gEIY6qcXrGwYyfNDPlAuc316
         HzXPeAb8ByIADJFYvsONHPUoO0HtmZhhyxFMt+mPp+PRK3KilBPqHeOpE/N2CZcycUOx
         oCpQXpxGVfgHiDRncGZlGIe5kkN7NKiaKjxurp2uidjSp91WKWZP6QepE+8dlfq7ROhv
         m4LGFxVcsC3N1srx0L9TGm20FYK7Io7BDqKwuVXUhc7usqN9mgUPyEZJoUSTCInX+WY6
         gq1EMDtxIdF955pGg529JCahLWyfAr6RmWJX9OzZBsQglVH+vVSM+lhKFBZbav28KDYM
         zxcA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:references:date:in-reply-to
         :message-id:user-agent:mime-version;
        bh=/FD/G7/6P2T9YdJcq3GH1rXTkM05LfWKbF1m0hD2QkM=;
        b=lOVBgWglIqZDaWMuenGHq9DnV6nFSYrlKSWSQSCiAwTX0NwqL5En36pdHXWkyL6CMI
         lXP71Zxef9qAj4jYWV/01RYN0vBRVQHgKFiHpZVRvWmoW70yT77WGwyk7OX3JJN0lUNw
         fMmUSPQVCl9i3YC9jE2OYdMKTMsc9tBybfoxhew5HKn+C+iJlGdhw5Y0RgSLR2dmBvXT
         gPaHGYLiRzxXpVF1M+KqX84zeECTQnyOFSSfFUSUWM+2OORcKOWc7ZQXWleKno8OZ2IP
         QQT1ayd6XV4CS0zqD5ycz/YBWWUHakxF1gCpOQFFn67WDnW67TyMaNRS1UzAvOde9tHg
         VRHw==
X-Gm-Message-State: ALKqPweirkDAp0V00u5XkiTfQiq2SBRHZr3wEWwlvE8wBT5ny8r4l2uA
        D+BNXDOzOZ1JT4lFuuIjaDM=
X-Google-Smtp-Source: AB8JxZqWgzj/QoASes5USbKqAbZQy2NiAcq1vNdzdNkKOdsuPN9W85GPWbAu0goQ3Da+eC9IiPXG2Q==
X-Received: by 2002:adf:9d02:: with SMTP id k2-v6mr7597702wre.213.1527448348447;
        Sun, 27 May 2018 12:12:28 -0700 (PDT)
Received: from Laptop-Acer-Aspire-F15 (egb161.neoplus.adsl.tpnet.pl. [83.21.65.161])
        by smtp.gmail.com with ESMTPSA id 75-v6sm11306441wmw.37.2018.05.27.12.12.25
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Sun, 27 May 2018 12:12:27 -0700 (PDT)
From:   Jakub Narebski <jnareb@gmail.com>
To:     Derrick Stolee <dstolee@microsoft.com>
Cc:     "git\@vger.kernel.org" <git@vger.kernel.org>,
        "gitster\@pobox.com" <gitster@pobox.com>,
        "stolee\@gmail.com" <stolee@gmail.com>,
        "avarab\@gmail.com" <avarab@gmail.com>,
        "marten.agren\@gmail.com" <marten.agren@gmail.com>,
        "peff\@peff.net" <peff@peff.net>
Subject: Re: [PATCH v3 05/20] commit-graph: load a root tree from specific graph
References: <20180511211504.79877-1-dstolee@microsoft.com>
        <20180524162504.158394-1-dstolee@microsoft.com>
        <20180524162504.158394-6-dstolee@microsoft.com>
Date:   Sun, 27 May 2018 21:12:25 +0200
In-Reply-To: <20180524162504.158394-6-dstolee@microsoft.com> (Derrick Stolee's
        message of "Thu, 24 May 2018 16:25:35 +0000")
Message-ID: <86h8mszzdy.fsf@gmail.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.2 (windows-nt)
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Derrick Stolee <dstolee@microsoft.com> writes:

> When lazy-loading a tree for a commit, it will be important to select
> the tree from a specific struct commit_graph. Create a new method that
> specifies the commit-graph file and use that in
> get_commit_tree_in_graph().

Is this for the same reason why parse_commit_in_graph_one() was created
in ptch 03/20?  Why it would be important?

>
> Signed-off-by: Derrick Stolee <dstolee@microsoft.com>
> ---
>  commit-graph.c | 12 +++++++++---
>  1 file changed, 9 insertions(+), 3 deletions(-)

Simple and straightforward refactoring in the same vein as
parse_commit_in_graph_one() one.

>
> diff --git a/commit-graph.c b/commit-graph.c
> index 78ba0edc80..25893ec096 100644
> --- a/commit-graph.c
> +++ b/commit-graph.c
> @@ -358,14 +358,20 @@ static struct tree *load_tree_for_commit(struct commit_graph *g, struct commit *
>  	return c->maybe_tree;
>  }
>  
> -struct tree *get_commit_tree_in_graph(const struct commit *c)
> +static struct tree *get_commit_tree_in_graph_one(struct commit_graph *g,
> +						 const struct commit *c)
>  {
>  	if (c->maybe_tree)
>  		return c->maybe_tree;
>  	if (c->graph_pos == COMMIT_NOT_FROM_GRAPH)
> -		BUG("get_commit_tree_in_graph called from non-commit-graph commit");
> +		BUG("get_commit_tree_in_graph_one called from non-commit-graph commit");

Sidenote: I wonder if it would be better or worse to use __func__ magic
costant variable here (part of C99 and C++11 standards).

> +
> +	return load_tree_for_commit(g, (struct commit *)c);
> +}
>  
> -	return load_tree_for_commit(commit_graph, (struct commit *)c);
> +struct tree *get_commit_tree_in_graph(const struct commit *c)
> +{
> +	return get_commit_tree_in_graph_one(commit_graph, c);
>  }
>  
>  static void write_graph_chunk_fanout(struct hashfile *f,

Looks good to me.
