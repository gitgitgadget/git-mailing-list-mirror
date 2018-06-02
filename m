Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 0E7F81F42D
	for <e@80x24.org>; Sat,  2 Jun 2018 12:24:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1750964AbeFBMYA (ORCPT <rfc822;e@80x24.org>);
        Sat, 2 Jun 2018 08:24:00 -0400
Received: from mail-wr0-f194.google.com ([209.85.128.194]:38212 "EHLO
        mail-wr0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750740AbeFBMX7 (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 2 Jun 2018 08:23:59 -0400
Received: by mail-wr0-f194.google.com with SMTP id 94-v6so38659993wrf.5
        for <git@vger.kernel.org>; Sat, 02 Jun 2018 05:23:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version;
        bh=+0UaHRsqGLbZWF/Z+iyQhGB8HKkfwmy8e1sx6rqwALU=;
        b=rTcc412m+PvdgCklRm3JD+xvSGocBNHlOMLeAB3bH1UuPMSuBaRSg0WTy6BmOFtvwE
         hPRw+gcTviyNPMKl7khrAulS6mewJesspGb7vN64FiwB3BAtD6B5TNQSuKMZjrRboshV
         hWkkz8PpuvMitZiowCCLkWp/40E+puixseCUqMiJ3aPknjWojnTWoJGUaNxHIa1V7ilG
         UyX7TK8PBmLLXDQcMJefs78mkBwfD4ESj+IIWVnVKP94b0UA/l6CRtaDyjDIoTEvr/79
         Qbg99vs0WcqFRu7QpS1RAePmiVEYJ1PaQCerfcStrxzUfPEQa7iMvc7fat4OGH+XD9cY
         XRsA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:references:date:in-reply-to
         :message-id:user-agent:mime-version;
        bh=+0UaHRsqGLbZWF/Z+iyQhGB8HKkfwmy8e1sx6rqwALU=;
        b=XZNKfhaIxEHU2/zUCrPKKRsbAIhsuQbOnF5QyRrP4EldPV86z24Tn+TpGxSzs7Y1D8
         L7y8uZ49tKKvXcVG9Xgqwl1zgT0IsY5Rz56hkJBWMBUzGPT/yr95od4X7j/HDmAm1wD/
         Y5dTGJcMI4vNV+K0koKMZUFdGt8jcSbsJ4SUq/HAVI7+pZymZG4ecau206a9ZxQt4W7K
         rVgWGoZGY3OC2MIEgAwcNHejRTpK1G7EIxrcAhSl6YuxkDyc6T4JzLlKjpnxrvxvpB4F
         m90ptD6BLado2SR933trxVBSejKfLbupAGL+SW5zLhTYHxplqhwCZpBIdhNApuebUoD0
         zbCQ==
X-Gm-Message-State: ALKqPwds7Jp41dWyf8C5oCwBcaVYl547zkePywczxqR/Kfxfc3hSEl+a
        vTn49HOaDTKsJKVvMkuImsQ=
X-Google-Smtp-Source: ADUXVKJ7SWtiGdSblofrDpsa2Ga6UUJhhWIQRLoJMJJjmdg67vXMqRvmAmXJTqlOM+a34safVh6POg==
X-Received: by 2002:adf:91e5:: with SMTP id 92-v6mr11255686wri.124.1527942238282;
        Sat, 02 Jun 2018 05:23:58 -0700 (PDT)
Received: from Laptop-Acer-Aspire-F15 (abri204.neoplus.adsl.tpnet.pl. [83.8.102.204])
        by smtp.gmail.com with ESMTPSA id k126-v6sm5593668wmd.45.2018.06.02.05.23.56
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Sat, 02 Jun 2018 05:23:56 -0700 (PDT)
From:   Jakub Narebski <jnareb@gmail.com>
To:     Derrick Stolee <dstolee@microsoft.com>
Cc:     "git\@vger.kernel.org" <git@vger.kernel.org>,
        "gitster\@pobox.com" <gitster@pobox.com>,
        "stolee\@gmail.com" <stolee@gmail.com>,
        "avarab\@gmail.com" <avarab@gmail.com>,
        "marten.agren\@gmail.com" <marten.agren@gmail.com>,
        "peff\@peff.net" <peff@peff.net>
Subject: Re: [PATCH v3 13/20] commit-graph: verify generation number
References: <20180511211504.79877-1-dstolee@microsoft.com>
        <20180524162504.158394-1-dstolee@microsoft.com>
        <20180524162504.158394-14-dstolee@microsoft.com>
Date:   Sat, 02 Jun 2018 14:23:53 +0200
In-Reply-To: <20180524162504.158394-14-dstolee@microsoft.com> (Derrick
        Stolee's message of "Thu, 24 May 2018 16:25:54 +0000")
Message-ID: <868t7xv0km.fsf@gmail.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.2 (windows-nt)
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Derrick Stolee <dstolee@microsoft.com> writes:

> While iterating through the commit parents, perform the generation
> number calculation and compare against the value stored in the
> commit-graph.

All right, that's good.

What about commit-graph files that have GENERATION_NUMBER_ZERO for all
its commits (because we verify single commit-graph file only, there
wouldn't be GENERATION_NUMBER_ZERO mixed with non-zero generation
numbers)?

Unless we can assume that no commit-graph file in the wild would have
GENERATION_NUMBER_ZERO.

>
> The tests demonstrate that having a different set of parents affects
> the generation number calculation, and this value propagates to
> descendants. Hence, we drop the single-line condition on the output.

I don't understand what part of changes this paragraph of the commit
message refers to.

Anyway, changing parents may not lead to changed generation numbers;
take for example commit with single parent, which we change to other
commit with the same generation number.

>
> Signed-off-by: Derrick Stolee <dstolee@microsoft.com>
> ---
>  commit-graph.c          | 18 ++++++++++++++++++
>  t/t5318-commit-graph.sh |  6 ++++++

Sidenote: I have just realized that it may be better to put
validation-related tests into different test file.

>  2 files changed, 24 insertions(+)
>
> diff --git a/commit-graph.c b/commit-graph.c
> index fff22dc0c3..ead92460c1 100644
> --- a/commit-graph.c
> +++ b/commit-graph.c
> @@ -922,6 +922,7 @@ int verify_commit_graph(struct commit_graph *g)
>  	for (i = 0; i < g->num_commits; i++) {
>  		struct commit *graph_commit, *odb_commit;
>  		struct commit_list *graph_parents, *odb_parents;
> +		uint32_t max_generation = 0;
>  
>  		hashcpy(cur_oid.hash, g->chunk_oid_lookup + g->hash_len * i);
>  
> @@ -956,6 +957,9 @@ int verify_commit_graph(struct commit_graph *g)
>  					     oid_to_hex(&graph_parents->item->object.oid),
>  					     oid_to_hex(&odb_parents->item->object.oid));
>  
> +			if (graph_parents->item->generation > max_generation)
> +				max_generation = graph_parents->item->generation;
> +

All right, that calculates the maximum of generation number of commit
parents.

>  			graph_parents = graph_parents->next;
>  			odb_parents = odb_parents->next;
>  		}
> @@ -963,6 +967,20 @@ int verify_commit_graph(struct commit_graph *g)
>  		if (odb_parents != NULL)
>  			graph_report("commit-graph parent list for commit %s terminates early",
>  				     oid_to_hex(&cur_oid));
> +
> +		/*
> +		 * If one of our parents has generation GENERATION_NUMBER_MAX, then
> +		 * our generation is also GENERATION_NUMBER_MAX. Decrement to avoid
> +		 * extra logic in the following condition.
> +		 */

Nice trick.

> +		if (max_generation == GENERATION_NUMBER_MAX)
> +			max_generation--;

What about GENERATION_NUMBER_ZERO?

> +
> +		if (graph_commit->generation != max_generation + 1)
> +			graph_report("commit-graph generation for commit %s is %u != %u",
> +				     oid_to_hex(&cur_oid),
> +				     graph_commit->generation,
> +				     max_generation + 1);

I think we should also check that generation numbers do not exceed
GENERATION_NUMBER_MAX... unless it is already taken care of?

>  	}
>  
>  	return verify_commit_graph_error;
> diff --git a/t/t5318-commit-graph.sh b/t/t5318-commit-graph.sh
> index 12f0d7f54d..673b0d37d5 100755
> --- a/t/t5318-commit-graph.sh
> +++ b/t/t5318-commit-graph.sh
> @@ -272,6 +272,7 @@ GRAPH_BYTE_COMMIT_TREE=$GRAPH_COMMIT_DATA_OFFSET
>  GRAPH_BYTE_COMMIT_PARENT=`expr $GRAPH_COMMIT_DATA_OFFSET + $HASH_LEN`
>  GRAPH_BYTE_COMMIT_EXTRA_PARENT=`expr $GRAPH_COMMIT_DATA_OFFSET + $HASH_LEN + 4`
>  GRAPH_BYTE_COMMIT_WRONG_PARENT=`expr $GRAPH_COMMIT_DATA_OFFSET + $HASH_LEN + 3`
> +GRAPH_BYTE_COMMIT_GENERATION=`expr $GRAPH_COMMIT_DATA_OFFSET + $HASH_LEN + 8`
>  
>  # usage: corrupt_graph_and_verify <position> <data> <string>
>  # Manipulates the commit-graph file at the position
> @@ -366,4 +367,9 @@ test_expect_success 'detect incorrect tree OID' '
>  		"commit-graph parent for"
>  '
>  
> +test_expect_success 'detect incorrect generation number' '
> +	corrupt_graph_and_verify $GRAPH_BYTE_COMMIT_GENERATION "\01" \

I assume that you have checked that it actually corrupts generation
number (without affecting commit date).

> +		"generation"

A very minor nitpick: Not "generation for commit"?

> +'
> +
>  test_done
