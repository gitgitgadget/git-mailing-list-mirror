Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.5 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 7E0C11F85D
	for <e@80x24.org>; Wed, 11 Jul 2018 09:38:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732341AbeGKJmA (ORCPT <rfc822;e@80x24.org>);
        Wed, 11 Jul 2018 05:42:00 -0400
Received: from mail-ed1-f68.google.com ([209.85.208.68]:35911 "EHLO
        mail-ed1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726423AbeGKJmA (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 11 Jul 2018 05:42:00 -0400
Received: by mail-ed1-f68.google.com with SMTP id t3-v6so18710575eds.3
        for <git@vger.kernel.org>; Wed, 11 Jul 2018 02:38:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=lN2K6eGFx7K/cNKDfcxNA3+1xw5lSfmDYbHcYWB1fVk=;
        b=dABch5ErSW8muqA102LU9Mjmc8AbQ+RgtbKTRURMVaPy1pCow91BtZW1MBwgq8Z9lj
         /RTGf8eRQTZARoPdCgEoiDRQOl9MscvMRlPcirPNSeSO8xucmhvFUGpZUnTNlccaYo+q
         DTECGG8+TNIP9NpsGunNnDjYJlE3dv/X2EXJVTExXCcVXER9IuSA3o4Qovu2OcZhlEyM
         KPkMyqpQO9pY6Zlj25ts0TxR8Zw5teC48jsd+jBku+t0D0nofP4eoe4/hJzE4JKBa/j2
         KowPc3TutXGFqKcpMvNFjKqRWgfa93J4MKoXZRMOAcUFePFC7EXbTqBDm++d+FbYtIvb
         HdLQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=lN2K6eGFx7K/cNKDfcxNA3+1xw5lSfmDYbHcYWB1fVk=;
        b=nCK2R3EEUVPUB4MvZwsBOF04lV3ajkbGvix1ONAudhJahS5yrzfDU6ayS9ZvJI90V+
         2dPAWTjceifnKBEE8kkPQE4AEtX6HalMhLwBEJzx6teDaitNvZZmLLDK3wyU7qlHuxBe
         iizYB09qUhz/YdCRr+sVcxrszZHY9bfnl2UNJwB0k0fiVU1/sw+d+EQVTxPfxFBgSYar
         06JFYkIv7cY2MqVc0awnXyKA6x/0qWEeW4i8mz1zUbakYhbYCOz3QM/G7KpYLb0Yz4yn
         gPTamIkjNAlpQDXVeyjjUJM2d4LkOlwua5peUHafZIE6f9vd3VqEPWsWFO6bt5g3hxEF
         2sFg==
X-Gm-Message-State: APt69E3mwdsddWYHOze52/B3k86UigYPQNjMPen8AxRtRBmPtJKJpbRu
        AGDgCIa+Dj1uGZhTbaWIb8A=
X-Google-Smtp-Source: AAOMgpdl1RTRu+gb6gPLXauwblSk4mikzwb50PvTNgzvBU0P+kLo1RKU/sFs7Cc3gSxevC0vVRPbiQ==
X-Received: by 2002:aa7:d7d0:: with SMTP id e16-v6mr25500419eds.82.1531301913320;
        Wed, 11 Jul 2018 02:38:33 -0700 (PDT)
Received: from localhost.localdomain (x4db1cc71.dyn.telefonica.de. [77.177.204.113])
        by smtp.gmail.com with ESMTPSA id l9-v6sm7999666edi.73.2018.07.11.02.38.31
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Wed, 11 Jul 2018 02:38:32 -0700 (PDT)
From:   =?UTF-8?q?SZEDER=20G=C3=A1bor?= <szeder.dev@gmail.com>
To:     Derrick Stolee <stolee@gmail.com>
Cc:     =?UTF-8?q?SZEDER=20G=C3=A1bor?= <szeder.dev@gmail.com>,
        git@vger.kernel.org, gitster@pobox.com, avarab@gmail.com,
        sbeller@google.com, jnareb@gmail.com, marten.agren@gmail.com,
        Derrick Stolee <dstolee@microsoft.com>
Subject: Re: [PATCH v7 06/22] commit-graph: load a root tree from specific graph
Date:   Wed, 11 Jul 2018 11:38:22 +0200
Message-Id: <20180711093822.2123-1-szeder.dev@gmail.com>
X-Mailer: git-send-email 2.18.0.273.g57f1ecce9c
In-Reply-To: <20180627132447.142473-7-dstolee@microsoft.com>
References: <20180608135548.216405-1-dstolee@microsoft.com> <20180627132447.142473-1-dstolee@microsoft.com> <20180627132447.142473-7-dstolee@microsoft.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


> When lazy-loading a tree for a commit, it will be important to select
> the tree from a specific struct commit_graph. Create a new method that
> specifies the commit-graph file and use that in
> get_commit_tree_in_graph().
> 
> Signed-off-by: Derrick Stolee <dstolee@microsoft.com>
> ---
>  commit-graph.c | 12 +++++++++---
>  1 file changed, 9 insertions(+), 3 deletions(-)
> 
> diff --git a/commit-graph.c b/commit-graph.c
> index e77b19971d..9e228d3bb5 100644
> --- a/commit-graph.c
> +++ b/commit-graph.c
> @@ -362,14 +362,20 @@ static struct tree *load_tree_for_commit(struct commit_graph *g, struct commit *
>  	return c->maybe_tree;
>  }
>  
> -struct tree *get_commit_tree_in_graph(const struct commit *c)
> +static struct tree *get_commit_tree_in_graph_one(struct commit_graph *g,
> +						 const struct commit *c)
>  {
>  	if (c->maybe_tree)
>  		return c->maybe_tree;

Coccinelle and 'commit.cocci' complain about this change, because it
renames a function directly accessing struct commit's maybe_tree
member.

In 'commit.cocci' the regex listing the names of functions that are
allowed to access c->maybe_tree directly should be updated accordingly
as well.

>  	if (c->graph_pos == COMMIT_NOT_FROM_GRAPH)
> -		BUG("get_commit_tree_in_graph called from non-commit-graph commit");
> +		BUG("get_commit_tree_in_graph_one called from non-commit-graph commit");
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
> -- 
> 2.18.0.24.g1b579a2ee9
> 
> 
