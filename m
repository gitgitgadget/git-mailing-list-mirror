Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.5 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 1F5091F406
	for <e@80x24.org>; Sat, 12 May 2018 20:55:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751868AbeELUzu (ORCPT <rfc822;e@80x24.org>);
        Sat, 12 May 2018 16:55:50 -0400
Received: from mail-pl0-f65.google.com ([209.85.160.65]:35607 "EHLO
        mail-pl0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751739AbeELUzt (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 12 May 2018 16:55:49 -0400
Received: by mail-pl0-f65.google.com with SMTP id i5-v6so5170157plt.2
        for <git@vger.kernel.org>; Sat, 12 May 2018 13:55:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=uQ9vbmgS3n54Lg5Qs3r46V8eUTF/Yu/ICG3kZsJn8v8=;
        b=mTEYoj0paF7ZQbgj0fRGXyOGCFs6NuLiYbeggTLwhSSg9qisiNKVKzBm/Z3/boZeOZ
         +xVVCrkcnWI7CE4Mp7WT9V41KwFOWey3K5GlDB9Avw2lE1c6JS46cIw0m9ne3OBhPcbs
         GsOCwBjWAKuYotchz8YI49g9jC5Mst8+3Px1Jgcn4NfGSf3A2axrYhqFV5YPTaoiQ9uh
         +cekVjTIhsCYefzgDEXKqbJvPx77BXE6DZ9LnUvrsb3zJjWj2X44BdeNqVvtFH1b80GI
         6YH2cKhjgLmwGKYAtcwYGo7LgldZAg1/9IvnxIW6IxOO4wtXJ8nYuGcoL1OmHBNDlqVU
         XnDA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=uQ9vbmgS3n54Lg5Qs3r46V8eUTF/Yu/ICG3kZsJn8v8=;
        b=ZOHJwwZowaJ8TASez2PF+rYTVbhF2xuZYZC6g9ReBSffJomW2I3TwwOVUFEF3ot4Vy
         GY8rUr5NJyYeFdbnmAzfgGdjxyk8IbANaTuyCE5uxZDDTDfhZqCR6SvSON2hM0hvDs8m
         YqGv19YicZQl0YU6X1qVt9Jspp691OmaVvcp4gMfwS+OFh4yDJZfHt9ZjJb1NslCB++W
         KNZ6K4c1lZO7nURxoYor9qYRxFwLmh0ldoYkKXL5PKgBuB2qDwULr+k7ID0HYlF3uHbP
         FaZRFvGwRzA/3OxnslHIj6/BqkrSUbGkzsSCe3cWIWPIX96Ld3w1lbWXo7Ojp8dGi/cK
         TN4g==
X-Gm-Message-State: ALKqPweX7zWeCVqUM9A43hDWf2dZNpJkq2V7OuyWiWJ7qJFapURjTFJe
        Y5wO3g7Q9hTFlwwCkE84Xc5ie2a6/3BuPM9G+OY=
X-Google-Smtp-Source: AB8JxZopyVQdf+5Gz9lUawX/n3VSKdLdLIxO27qfs3PpqTyzaYkSM3rk7/QEQpRXwL63t58agjbaKVGM7aqLwNq+Ub4=
X-Received: by 2002:a17:902:284b:: with SMTP id e69-v6mr3626861plb.240.1526158549134;
 Sat, 12 May 2018 13:55:49 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.236.187.139 with HTTP; Sat, 12 May 2018 13:55:48 -0700 (PDT)
In-Reply-To: <20180511211504.79877-8-dstolee@microsoft.com>
References: <20180510173345.40577-1-dstolee@microsoft.com> <20180511211504.79877-1-dstolee@microsoft.com>
 <20180511211504.79877-8-dstolee@microsoft.com>
From:   =?UTF-8?Q?Martin_=C3=85gren?= <martin.agren@gmail.com>
Date:   Sat, 12 May 2018 22:55:48 +0200
Message-ID: <CAN0heSqbObaKK0MfUmy7g1fkdi4UYjVSxPaVvEPADHLXG8so0g@mail.gmail.com>
Subject: Re: [PATCH v2 07/12] commit-graph: load a root tree from specific graph
To:     Derrick Stolee <dstolee@microsoft.com>
Cc:     "git@vger.kernel.org" <git@vger.kernel.org>,
        "jnareb@gmail.com" <jnareb@gmail.com>,
        "avarab@gmail.com" <avarab@gmail.com>,
        "peff@peff.net" <peff@peff.net>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 11 May 2018 at 23:15, Derrick Stolee <dstolee@microsoft.com> wrote:

> -struct tree *get_commit_tree_in_graph(const struct commit *c)
> +static struct tree *get_commit_tree_in_graph_one(struct commit_graph *g,
> +                                                const struct commit *c)
>  {
>         if (c->maybe_tree)
>                 return c->maybe_tree;
>         if (c->graph_pos == COMMIT_NOT_FROM_GRAPH)
>                 BUG("get_commit_tree_in_graph called from non-commit-graph commit");

Update the function name in the BUG? Not that it will ever matter. ;-)

(This one is now static, ok.)
