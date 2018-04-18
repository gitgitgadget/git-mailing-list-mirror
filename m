Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 0ADC91F404
	for <e@80x24.org>; Wed, 18 Apr 2018 23:19:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753213AbeDRXTW (ORCPT <rfc822;e@80x24.org>);
        Wed, 18 Apr 2018 19:19:22 -0400
Received: from mail-wr0-f195.google.com ([209.85.128.195]:45865 "EHLO
        mail-wr0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753197AbeDRXTV (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 18 Apr 2018 19:19:21 -0400
Received: by mail-wr0-f195.google.com with SMTP id u11-v6so9021987wri.12
        for <git@vger.kernel.org>; Wed, 18 Apr 2018 16:19:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version;
        bh=YTDc9cUOII/B1PFrhrfoaNRT1webURcMWhXTf0yNCMM=;
        b=eGjDH3KfGEyBmdXo/pBPwL/N2NhwtUSZETGc2cCiFyREgeY9Jk85eihqZJujREPoHi
         W6ItfL5ZZsxGUeOAfDwX/7v4+nE01DeCfcR8rUxa5ZqaaBRuACSSmOmBtJDBjyWi4r8N
         5yGMnQN65SlRt79O9JtXyjSIZIIJmYukf76i9Aqf2QcfJ9PV21vRV16iHMcodXYzzMYb
         JB35ODR6iRG4KvDelaSflW/LTt0lMFFWs7hWowJ5gCEdmq76VQ20A2YWQjn1NABAHRZK
         JzLfx8KuJYue+kuFp/Pylnnah2jT2oYmThk1cDjjKrT1d+OBv0IHIr0IAc5CFrpTDCsW
         KLlQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:references:date:in-reply-to
         :message-id:user-agent:mime-version;
        bh=YTDc9cUOII/B1PFrhrfoaNRT1webURcMWhXTf0yNCMM=;
        b=VhZCjfwMMb0zM0j9JL9BrLb/e3zhzscPFqWKjYyGtTLwfD7p68bslCGkeJbuCqJ6Ew
         ovBbHuToJzLee7Z0Wo5QSMPbHIZbNHIJrKRtSaiJ8aDnx6VkyZW+cOxOi8DOC1Irz7A9
         CjGlobVELXQluTMjidZ3LBLwkfQFILNZL9F/osAJHhmM3E4FP/sDQurEdz+yh9ZxDX8D
         SyUMtVM/PtMExjEbxAPb8wU7IBHAKTrsWEPj9DKQCPosqI4ntxr0RmGde5QP6Cj/Zt6p
         w/zUYDs00wlAtffyr8OLLgLMS9pNHMOZilS9F+f65Gqu50q5vgdlS/Gk8qUDeFLqN88O
         3C4A==
X-Gm-Message-State: ALQs6tA4ag6m0OGnXn/MtotA1JcWsicEKClrSu1b1wPvYifE5UOl0e+n
        hqSVGrUDWCW6AGYeZ4kijtg=
X-Google-Smtp-Source: AIpwx4+f3Q49cwVZOiZK2k9Doat0h2no1FETZ5n08zK8y5qewGG/7u6yXqEWJu28lzE3hcwUOlS6ZA==
X-Received: by 10.28.16.85 with SMTP id 82mr2797886wmq.4.1524093559835;
        Wed, 18 Apr 2018 16:19:19 -0700 (PDT)
Received: from Laptop-Acer-Aspire-F15 (egc153.neoplus.adsl.tpnet.pl. [83.21.66.153])
        by smtp.gmail.com with ESMTPSA id p10-v6sm1647615wre.77.2018.04.18.16.19.17
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 18 Apr 2018 16:19:18 -0700 (PDT)
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
Subject: Re: [PATCH v3 7/9] commit: add short-circuit to paint_down_to_common()
References: <20180409164131.37312-1-dstolee@microsoft.com>
        <20180417170001.138464-1-dstolee@microsoft.com>
        <20180417170001.138464-8-dstolee@microsoft.com>
Date:   Thu, 19 Apr 2018 01:19:17 +0200
In-Reply-To: <20180417170001.138464-8-dstolee@microsoft.com> (Derrick Stolee's
        message of "Tue, 17 Apr 2018 17:00:32 +0000")
Message-ID: <86bmeggl1m.fsf@gmail.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.2 (windows-nt)
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Derrick Stolee <dstolee@microsoft.com> writes:

> When running 'git branch --contains', the in_merge_bases_many()
> method calls paint_down_to_common() to discover if a specific
> commit is reachable from a set of branches. Commits with lower
> generation number are not needed to correctly answer the
> containment query of in_merge_bases_many().

Right. This description is not entirely clear to me, but I don't have a
better proposal. Good enough, I guess.

>
> Add a new parameter, min_generation, to paint_down_to_common() that
> prevents walking commits with generation number strictly less than
> min_generation. If 0 is given, then there is no functional change.

Is it new parameter really needed, i.e. do you really need to change the
signature of this function?  See below for details.

>
> For in_merge_bases_many(), we can pass commit->generation as the
> cutoff,...

This is the only callsite that uses min_generation with non-zero value,
and it uses commit->generation to fill it... while commit itself is one
of exiting parameters.

> [...], and this saves time during 'git branch --contains' queries
> that would otherwise walk "around" the commit we are inspecting.

If I understand the code properly, what happens is that we can now
short-circuit if all commits that are left are lower than the target
commit.

This is because max-order priority queue is used: if the commit with
maximum generation number is below generation number of target commit,
then target commit is not reachable from any commit in the priority
queue (all of which has generation number less or equal than the commit
at head of queue, i.e. all are same level or deeper); compare what I
have written in [1]

[1]: https://public-inbox.org/git/866052dkju.fsf@gmail.com/

Do I have that right?  If so, it looks all right to me.

>
> For a copy of the Linux repository, where HEAD is checked out at
> v4.13~100, we get the following performance improvement for
> 'git branch --contains' over the previous commit:
>
> Before: 0.21s
> After:  0.13s
> Rel %: -38%

Nice.

>
> Signed-off-by: Derrick Stolee <dstolee@microsoft.com>
> ---
>  commit.c | 18 ++++++++++++++----
>  1 file changed, 14 insertions(+), 4 deletions(-)
>
> diff --git a/commit.c b/commit.c
> index bceb79c419..a70f120878 100644
> --- a/commit.c
> +++ b/commit.c
> @@ -805,11 +805,14 @@ static int queue_has_nonstale(struct prio_queue *queue)
>  }
>  
>  /* all input commits in one and twos[] must have been parsed! */
> -static struct commit_list *paint_down_to_common(struct commit *one, int n, struct commit **twos)
> +static struct commit_list *paint_down_to_common(struct commit *one, int n,
> +						struct commit **twos,
> +						int min_generation)
>  {
>  	struct prio_queue queue = { compare_commits_by_gen_then_commit_date };
>  	struct commit_list *result = NULL;
>  	int i;
> +	uint32_t last_gen = GENERATION_NUMBER_INFINITY;

Do we really need to change the signature of paint_down_to_common(), or
would it be enough to create a local variable min_generation set
initially to one->generation.

 +      uint32_t min_generation = one->generation;
 +	uint32_t last_gen = GENERATION_NUMBER_INFINITY;

>  
>  	one->object.flags |= PARENT1;
>  	if (!n) {
> @@ -828,6 +831,13 @@ static struct commit_list *paint_down_to_common(struct commit *one, int n, struc
>  		struct commit_list *parents;
>  		int flags;
>  
> +		if (commit->generation > last_gen)
> +			BUG("bad generation skip");
> +		last_gen = commit->generation;
> +
> +		if (commit->generation < min_generation)
> +			break;
> +

I think, after looking at the whole post-image code, that it is all
right.

>  		flags = commit->object.flags & (PARENT1 | PARENT2 | STALE);
>  		if (flags == (PARENT1 | PARENT2)) {
>  			if (!(commit->object.flags & RESULT)) {
> @@ -876,7 +886,7 @@ static struct commit_list *merge_bases_many(struct commit *one, int n, struct co
>  			return NULL;
>  	}
>  
> -	list = paint_down_to_common(one, n, twos);
> +	list = paint_down_to_common(one, n, twos, 0);
>  
>  	while (list) {
>  		struct commit *commit = pop_commit(&list);
> @@ -943,7 +953,7 @@ static int remove_redundant(struct commit **array, int cnt)
>  			filled_index[filled] = j;
>  			work[filled++] = array[j];
>  		}
> -		common = paint_down_to_common(array[i], filled, work);
> +		common = paint_down_to_common(array[i], filled, work, 0);
>  		if (array[i]->object.flags & PARENT2)
>  			redundant[i] = 1;
>  		for (j = 0; j < filled; j++)
> @@ -1067,7 +1077,7 @@ int in_merge_bases_many(struct commit *commit, int nr_reference, struct commit *
>  	if (commit->generation > min_generation)
>  		return 0;
>  
> -	bases = paint_down_to_common(commit, nr_reference, reference);
> +	bases = paint_down_to_common(commit, nr_reference, reference, commit->generation);

Is it the only case where we would call paint_down_to_common() with
non-zero last parameter?  Would we always use commit->generation where
commit is the first parameter of paint_down_to_common()?

If both are true and will remain true, then in my humble opinion it is
not necessary to change the signature of this function.

>  	if (commit->object.flags & PARENT2)
>  		ret = 1;
>  	clear_commit_marks(commit, all_flags);
