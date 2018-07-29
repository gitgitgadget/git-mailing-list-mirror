Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 3BD4C208E9
	for <e@80x24.org>; Sun, 29 Jul 2018 21:07:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726813AbeG2Wjn (ORCPT <rfc822;e@80x24.org>);
        Sun, 29 Jul 2018 18:39:43 -0400
Received: from mail-wr1-f65.google.com ([209.85.221.65]:37405 "EHLO
        mail-wr1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726712AbeG2Wjn (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 29 Jul 2018 18:39:43 -0400
Received: by mail-wr1-f65.google.com with SMTP id q10-v6so10597124wrd.4
        for <git@vger.kernel.org>; Sun, 29 Jul 2018 14:07:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version;
        bh=Di3VYzdSCMSFx2xH6cDAwkIa1TtzW32TptFuIXd+d1k=;
        b=s5n5D6edBX30xvM5x9fXkrOV516BeIlQITQ+qST+50fqDrTuQdPZHQuHp5ZLy+rg2i
         GQwehgFW4V/nTPNEYuomxoMIOOko4Fqr904/NWLGb6lGZltkDXE8RuOU3Cpewm/24Sas
         pM+H9Q6vTU9Mzt5uusrTi4R+S1LsgJdKvFaJ2x4tuyKD3PmXT+kcdTj2zAXXobR9E06S
         1urS8gEoMUYloCnhy36c57OicG2UM/5cpvQegTJNNe3xHUIcGylJ7ytrcU3vb1PBYqTF
         EN0ElvBjzj+09gE0ZbTd9LtHLVfol+P9rH5Xv31QMz+r46w6uIu+8Gu3HBorOkwWnMhy
         isUg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:references:date:in-reply-to
         :message-id:user-agent:mime-version;
        bh=Di3VYzdSCMSFx2xH6cDAwkIa1TtzW32TptFuIXd+d1k=;
        b=BOTN8pD5T4WVtdELhAczKAMnscA0IMBN+jkD2Jb28c4WB2AU8rq1m/kN8K1nhhsd/h
         xV/SX8JaH5aFZ8cvXjuNZ9mWk/rO6r0KXcNKUtn9bkfMip7oK37/XxVQaRIWq91cXgmm
         eOG1VRp/0Z13QVuTJ6SzU82cxJo3u/491/Lx22OFJJuI/Oxm8PO3kqIt7uSfCAOFloLO
         sD5bu4G0E98npYHhxSB6pmGuVZj+P6vrzo6ZytSvEy5XnEsClbGEpfbAWGbF/imA+PXu
         rj23MfqmxnCMwUNC+sADESWKzlk36yn8m5OIeGK2oigI46R9s7tRSOPL2yLyEM3yg97b
         c3BQ==
X-Gm-Message-State: AOUpUlEeDJXVlKXXrZLVN/UoEuIgAvjy7X8AghjVSIO2IIZrtYADnjZ7
        I2vmX5M4+ojx+4dupWX5AwE=
X-Google-Smtp-Source: AAOMgpcPGlFOFRPc1+1NWQSkmc3i9w1847g81oNEhDKZKki6R1cYuPGlY5rfXiyXuVvG6ptd9RhFXA==
X-Received: by 2002:a5d:48c7:: with SMTP id p7-v6mr15476002wrs.0.1532898471605;
        Sun, 29 Jul 2018 14:07:51 -0700 (PDT)
Received: from Laptop-Acer-Aspire-F15 (abuo246.neoplus.adsl.tpnet.pl. [83.8.186.246])
        by smtp.gmail.com with ESMTPSA id s124-v6sm12548439wmf.47.2018.07.29.14.07.49
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Sun, 29 Jul 2018 14:07:50 -0700 (PDT)
From:   Jakub Narebski <jnareb@gmail.com>
To:     "Derrick Stolee via GitGitGadget" <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
        Derrick Stolee <dstolee@microsoft.com>
Subject: Re: [PATCH 4/8] test-repository: properly init repo
References: <pull.11.git.gitgitgadget@gmail.com>
        <88711a3cf4c045365a40504db94c34675f3bdc4e.1531926932.git.gitgitgadget@gmail.com>
Date:   Sun, 29 Jul 2018 23:07:49 +0200
In-Reply-To: <88711a3cf4c045365a40504db94c34675f3bdc4e.1531926932.git.gitgitgadget@gmail.com>
        (Derrick Stolee via GitGitGadget's message of "Wed, 18 Jul 2018
        08:15:40 -0700 (PDT)")
Message-ID: <86pnz57ntm.fsf@gmail.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.2 (windows-nt)
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

"Derrick Stolee via GitGitGadget" <gitgitgadget@gmail.com> writes:

> From: Derrick Stolee <dstolee@microsoft.com>
>
> Signed-off-by: Derrick Stolee <dstolee@microsoft.com>
> ---
>  t/helper/test-repository.c | 10 ++++++++--
>  1 file changed, 8 insertions(+), 2 deletions(-)
>
> diff --git a/t/helper/test-repository.c b/t/helper/test-repository.c
> index 2762ca656..6a84a53ef 100644
> --- a/t/helper/test-repository.c
> +++ b/t/helper/test-repository.c
> @@ -15,7 +15,10 @@ static void test_parse_commit_in_graph(const char *gitdir, const char *worktree,
>  	struct commit *c;
>  	struct commit_list *parent;
>  
> -	repo_init(&r, gitdir, worktree);
> +	setup_git_env(gitdir);
> +
> +	if (repo_init(&r, gitdir, worktree))
> +		die("Couldn't init repo");

Shouldn't this message be marked for translation?

  +		die(_("Couldn't init repo"));

Perhaps we could provide also more detail about error, if possible.

>  
>  	c = lookup_commit(&r, commit_oid);
>  
> @@ -38,7 +41,10 @@ static void test_get_commit_tree_in_graph(const char *gitdir,
>  	struct commit *c;
>  	struct tree *tree;
>  
> -	repo_init(&r, gitdir, worktree);
> +	setup_git_env(gitdir);
> +
> +	if (repo_init(&r, gitdir, worktree))
> +		die("Couldn't init repo");

I wonder if it would be worth it to extract this idiom into separate
function, called for exaple repo_init_or_die(), to avoid code
duplication (and maybe use it in other places?).

>  
>  	c = lookup_commit(&r, commit_oid);
