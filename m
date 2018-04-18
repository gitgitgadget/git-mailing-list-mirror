Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 27CBC1F404
	for <e@80x24.org>; Wed, 18 Apr 2018 14:31:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752939AbeDRObY (ORCPT <rfc822;e@80x24.org>);
        Wed, 18 Apr 2018 10:31:24 -0400
Received: from mail-wr0-f195.google.com ([209.85.128.195]:34983 "EHLO
        mail-wr0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752738AbeDRObW (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 18 Apr 2018 10:31:22 -0400
Received: by mail-wr0-f195.google.com with SMTP id w3-v6so5456897wrg.2
        for <git@vger.kernel.org>; Wed, 18 Apr 2018 07:31:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version;
        bh=bL28G/WsDDHVmK2MmjsalfM+lbafdcwiRQ/xKfke3jU=;
        b=RNoVHBOqbALn5qOynpl5DeTijGYiwc5lOqAt3f0k+p2SZPZKZabUOB/Q+r2UNIGj2p
         NGWDzNgYvYbpolvLbMod10bLPXveXIBDg0pqBCxlBnslWCRWv9IjXO5jL5Btg0ZUZIG/
         xTIU95H4YLyHbDZQv8NZMNmCKGtkdWLLlQiO3QAi7+WddIsdvS2623kn27WfnsY9sxmK
         ckRSUm8aKFdDrgueHWsEECaJbF+jyB6gkJshqv4NjVg4Em5VyUW0OK+QjgLjHftos2/N
         rb6T7dkzJq0CDV2pHotozsMSSaHdPLNVvnT0vvQiT1dsUE7Dfvppp/C+rgduYmFEbRhu
         w6Ew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:references:date:in-reply-to
         :message-id:user-agent:mime-version;
        bh=bL28G/WsDDHVmK2MmjsalfM+lbafdcwiRQ/xKfke3jU=;
        b=pC2/ZVAX55g+0lbW4infW9W3XO1MAOYyn9X/DMfPSt6Gog8OkcJaOOkJ2GWgNB9gg5
         7fXGXw8xYz8bayS91MIbzBxKz5ynJiukueXcnxtv2K2ZAfJsoY9cP5PScS1bQLWxPg4F
         ZLauk8XNXVesAjEipQdcCGDVjUw+llXThxe6rYpzRxOlwDU/lV4qnFKg5i//n+0iYDU4
         mC/2JteGKVeoXeny255Wfe+j6vp839KFayryEXAk+MGJbqUudyW2WJj7/Ys61Uln/Bxg
         L2lWLkKrU5mfjU6wqjYT+j3r7PTcdN/T8mlTV17lOhCEvWgCf86dEoxCP8f3wg+r/2Af
         VWaw==
X-Gm-Message-State: ALQs6tAJ5+CT5i1U8TciN7KmKQ30AHflvBwFP1NgVHz8p9bPcGtSEjUn
        m5KXnZdqBuIIU1csUvl4NSc=
X-Google-Smtp-Source: AIpwx4+eD+YKPNwhg9q2flOd7Ii9ft2USaVD8HAgGwz+y09ark80kMCtJ1AAXLtLTV+4ow+LCmFwbQ==
X-Received: by 2002:adf:ad94:: with SMTP id w20-v6mr1967385wrc.83.1524061881446;
        Wed, 18 Apr 2018 07:31:21 -0700 (PDT)
Received: from Laptop-Acer-Aspire-F15 (egd172.neoplus.adsl.tpnet.pl. [83.21.67.172])
        by smtp.gmail.com with ESMTPSA id v66sm2702506wmd.41.2018.04.18.07.31.19
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 18 Apr 2018 07:31:20 -0700 (PDT)
From:   Jakub Narebski <jnareb@gmail.com>
To:     Derrick Stolee <dstolee@microsoft.com>
Cc:     "git\@vger.kernel.org" <git@vger.kernel.org>,
        "peff\@peff.net" <peff@peff.net>,
        "stolee\@gmail.com" <stolee@gmail.com>,
        "avarab\@gmail.com" <avarab@gmail.com>,
        "sbeller\@google.com" <sbeller@google.com>,
        "larsxschneider\@gmail.com" <larsxschneider@gmail.com>,
        "bmwill\@google.com" <bmwill@google.com>,
        "gitster\@pobox.com" <gitster@pobox.com>,
        "sunshine\@sunshineco.com" <sunshine@sunshineco.com>,
        "jonathantanmy\@google.com" <jonathantanmy@google.com>
Subject: Re: [PATCH v3 3/9] commit: use generations in paint_down_to_common()
References: <20180409164131.37312-1-dstolee@microsoft.com>
        <20180417170001.138464-1-dstolee@microsoft.com>
        <20180417170001.138464-4-dstolee@microsoft.com>
Date:   Wed, 18 Apr 2018 16:31:18 +0200
In-Reply-To: <20180417170001.138464-4-dstolee@microsoft.com> (Derrick Stolee's
        message of "Tue, 17 Apr 2018 17:00:21 +0000")
Message-ID: <864lk8io21.fsf@gmail.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.2 (windows-nt)
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Derrick Stolee <dstolee@microsoft.com> writes:

> Define compare_commits_by_gen_then_commit_date(), which uses generation
> numbers as a primary comparison and commit date to break ties (or as a
> comparison when both commits do not have computed generation numbers).
>
> Since the commit-graph file is closed under reachability, we know that
> all commits in the file have generation at most GENERATION_NUMBER_MAX
> which is less than GENERATION_NUMBER_INFINITY.
>
> This change does not affect the number of commits that are walked during
> the execution of paint_down_to_common(), only the order that those
> commits are inspected. In the case that commit dates violate topological
> order (i.e. a parent is "newer" than a child), the previous code could
> walk a commit twice: if a commit is reached with the PARENT1 bit, but
> later is re-visited with the PARENT2 bit, then that PARENT2 bit must be
> propagated to its parents. Using generation numbers avoids this extra
> effort, even if it is somewhat rare.

Does it mean that it gives no measureable performance improvements for
typical test cases?

>
> Signed-off-by: Derrick Stolee <dstolee@microsoft.com>
> ---
>  commit.c | 20 +++++++++++++++++++-
>  commit.h |  1 +
>  2 files changed, 20 insertions(+), 1 deletion(-)
>
> diff --git a/commit.c b/commit.c
> index 711f674c18..a44899c733 100644
> --- a/commit.c
> +++ b/commit.c
> @@ -640,6 +640,24 @@ static int compare_commits_by_author_date(const void *a_, const void *b_,
>  	return 0;
>  }
>  
> +int compare_commits_by_gen_then_commit_date(const void *a_, const void *b_, void *unused)
> +{
> +	const struct commit *a = a_, *b = b_;
> +
> +	/* newer commits first */
> +	if (a->generation < b->generation)
> +		return 1;
> +	else if (a->generation > b->generation)
> +		return -1;
> +
> +	/* use date as a heuristic when generataions are equal */

Very minor typo in above comment:

s/generataions/generations/

> +	if (a->date < b->date)
> +		return 1;
> +	else if (a->date > b->date)
> +		return -1;
> +	return 0;
> +}
> +
>  int compare_commits_by_commit_date(const void *a_, const void *b_, void *unused)
>  {
>  	const struct commit *a = a_, *b = b_;
> @@ -789,7 +807,7 @@ static int queue_has_nonstale(struct prio_queue *queue)
>  /* all input commits in one and twos[] must have been parsed! */
>  static struct commit_list *paint_down_to_common(struct commit *one, int n, struct commit **twos)
>  {
> -	struct prio_queue queue = { compare_commits_by_commit_date };
> +	struct prio_queue queue = { compare_commits_by_gen_then_commit_date };
>  	struct commit_list *result = NULL;
>  	int i;
>  
> diff --git a/commit.h b/commit.h
> index aac3b8c56f..64436ff44e 100644
> --- a/commit.h
> +++ b/commit.h
> @@ -341,6 +341,7 @@ extern int remove_signature(struct strbuf *buf);
>  extern int check_commit_signature(const struct commit *commit, struct signature_check *sigc);
>  
>  int compare_commits_by_commit_date(const void *a_, const void *b_, void *unused);
> +int compare_commits_by_gen_then_commit_date(const void *a_, const void *b_, void *unused);
>  
>  LAST_ARG_MUST_BE_NULL
>  extern int run_commit_hook(int editor_is_used, const char *index_file, const char *name, ...);
