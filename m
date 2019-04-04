Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.2 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	FROM_EXCESS_BASE64,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id A02F320248
	for <e@80x24.org>; Thu,  4 Apr 2019 17:04:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729409AbfDDREd (ORCPT <rfc822;e@80x24.org>);
        Thu, 4 Apr 2019 13:04:33 -0400
Received: from mail-wm1-f68.google.com ([209.85.128.68]:37824 "EHLO
        mail-wm1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726418AbfDDREd (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 4 Apr 2019 13:04:33 -0400
Received: by mail-wm1-f68.google.com with SMTP id v14so4280713wmf.2
        for <git@vger.kernel.org>; Thu, 04 Apr 2019 10:04:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to
         :user-agent;
        bh=IbRpRd5RfmEDVXIIzSOXiJ/0OXZaBHTFaLTSXiaIrrU=;
        b=BDRbXInFx2yF6Zu+kx0lk3F2w2YXjN3/cZddf7IQQnsgjCoOpI9DCyTUlB+mTsKch9
         Wglp590d7+dc5Dzye4y4q3aIdYeBTtyBWr8931w/q4k2mqxApQ/XmphBRIJoHTxesAH9
         LT8aZC3KREkfrH6dzsSfxNCGtKMK9mtSPyKoRbySExu24ZxO6lP7jiLWHbpq0pif6nJ+
         OJ/VmucKsc8GqKpEDBBwIMiH84oJd1GMd5rIOY0zXqE+74AFNSvk0lDDRSp25eEBfcwC
         nsz09izNvIaZxO96cvLM8bxJSH+Ad5Fe8sie2vbMX/s5BRHgiUA5+v5sVuBBe4HiPgnN
         B5lA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=IbRpRd5RfmEDVXIIzSOXiJ/0OXZaBHTFaLTSXiaIrrU=;
        b=U0h0UsjSh5lqRaUHLzuWvWpmYJLZlzVG2AOj0uVj4T0cEOv2lviMEdKsqtsXpas9tG
         4QNm721SOZwOtxvhGUnokIqf0HbMLj9GMLz7VLX/DXIhRqc6pxyAmlVF5cp52IQGoGoT
         KFPnglt6pQCoYohVqdfLSeo5B9//amxYhggRAQnmdsD62s4LXSECfJpq4FAA54TRIfP4
         wuXhaWeSTPmMnfHV11RV4el6zbb7BYv7Rj5LprkhvcxKAs4Z3SuRIXsN0i2+hZg9tY7Z
         k8tMMzNrWP+9MA82MF801uEhksX2XZHd1oja90FvdmULf8SSSlmYLNTl6zWiCPgJO3gQ
         UCXQ==
X-Gm-Message-State: APjAAAXtaztl8eEZmCsiJdUxmwO9Oss1Jm8blzAUwHnuIw6C/SKrQsvo
        3xLMvkGo20yJ9OU2YL+uRDw=
X-Google-Smtp-Source: APXvYqzQh7deyVjLtvxX25sJ+OPasTcN5i9+1nvAavElmWMUf0503q+p07lVrtYxj8vucKXHBjjFtA==
X-Received: by 2002:a1c:c910:: with SMTP id f16mr4589175wmb.47.1554397471327;
        Thu, 04 Apr 2019 10:04:31 -0700 (PDT)
Received: from szeder.dev (x4db96230.dyn.telefonica.de. [77.185.98.48])
        by smtp.gmail.com with ESMTPSA id d3sm31214810wmf.46.2019.04.04.10.04.29
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 04 Apr 2019 10:04:30 -0700 (PDT)
Date:   Thu, 4 Apr 2019 19:04:27 +0200
From:   SZEDER =?utf-8?B?R8OhYm9y?= <szeder.dev@gmail.com>
To:     =?utf-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41j?= Duy <pclouds@gmail.com>
Cc:     git@vger.kernel.org, gitster@pobox.com, stefanbeller@gmail.com
Subject: Re: [PATCH v2 10/32] commit.c: add repo_get_commit_tree()
Message-ID: <20190404170427.GQ32732@szeder.dev>
References: <20190330111927.18645-1-pclouds@gmail.com>
 <20190403113457.20399-1-pclouds@gmail.com>
 <20190403113457.20399-11-pclouds@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20190403113457.20399-11-pclouds@gmail.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Apr 03, 2019 at 06:34:35PM +0700, Nguyễn Thái Ngọc Duy wrote:
> Signed-off-by: Nguyễn Thái Ngọc Duy <pclouds@gmail.com>

Oh, look, an empty commit message ;)

> ---
>  commit.c                        | 5 +++--
>  commit.h                        | 3 ++-
>  contrib/coccinelle/commit.cocci | 4 ++--
>  3 files changed, 7 insertions(+), 5 deletions(-)
> 
> diff --git a/commit.c b/commit.c
> index a5333c7ac6..f0a5506f04 100644
> --- a/commit.c
> +++ b/commit.c
> @@ -340,7 +340,8 @@ void free_commit_buffer(struct parsed_object_pool *pool, struct commit *commit)
>  	}
>  }
>  
> -struct tree *get_commit_tree(const struct commit *commit)
> +struct tree *repo_get_commit_tree(struct repository *r,
> +				  const struct commit *commit)

A rename to accomodate the additional 'struct repository*'
parameter.  Ok.

>  {
>  	if (commit->maybe_tree || !commit->object.parsed)
>  		return commit->maybe_tree;
> @@ -348,7 +349,7 @@ struct tree *get_commit_tree(const struct commit *commit)
>  	if (commit->graph_pos == COMMIT_NOT_FROM_GRAPH)
>  		BUG("commit has NULL tree, but was not loaded from commit-graph");
>  
> -	return get_commit_tree_in_graph(the_repository, commit);
> +	return get_commit_tree_in_graph(r, commit);
>  }
>  
>  struct object_id *get_commit_tree_oid(const struct commit *commit)
> diff --git a/commit.h b/commit.h
> index 42728c2906..b576201be8 100644
> --- a/commit.h
> +++ b/commit.h
> @@ -143,7 +143,8 @@ void repo_unuse_commit_buffer(struct repository *r,
>   */
>  void free_commit_buffer(struct parsed_object_pool *pool, struct commit *);
>  
> -struct tree *get_commit_tree(const struct commit *);
> +struct tree *repo_get_commit_tree(struct repository *, const struct commit *);
> +#define get_commit_tree(c) repo_get_commit_tree(the_repository, c)

But we still keep 'get_commit_tree' around as a macro wrapper
defaulting to 'the_repository', leaving the 30+ callsites intact.
Good.

Furthermore, the comment describing the 'maybe_tree' field in 'struct
commit's declaration still suggest get_commit_tree():

  * If the commit is loaded from the commit-graph file, then this
  * member may be NULL. Only access it through get_commit_tree()
  * or get_commit_tree_oid().


>  struct object_id *get_commit_tree_oid(const struct commit *);
>  
>  /*
> diff --git a/contrib/coccinelle/commit.cocci b/contrib/coccinelle/commit.cocci
> index c49aa558f0..f5bc639981 100644
> --- a/contrib/coccinelle/commit.cocci
> +++ b/contrib/coccinelle/commit.cocci
> @@ -12,12 +12,12 @@ expression c;
>  
>  // These excluded functions must access c->maybe_tree direcly.
>  @@
> -identifier f !~ "^(get_commit_tree|get_commit_tree_in_graph_one|load_tree_for_commit)$";
> +identifier f !~ "^(repo_get_commit_tree|get_commit_tree_in_graph_one|load_tree_for_commit)$";
>  expression c;
>  @@
>    f(...) {<...
>  - c->maybe_tree
> -+ get_commit_tree(c)
> ++ repo_get_commit_tree(the_repository, c)

So, why this change?

It would also require furher changes to 'commit.cocci', in particular
to the last semantic patch, which is supposed to ensure that
get_commit_tree() doesn't end up on the LHS of an assignment, but with
this change Coccinelle does suggest transfomations with
repo_get_commit_tree() on the LHS.

>    ...>}
>  
>  @@
> -- 
> 2.21.0.479.g47ac719cd3
> 
