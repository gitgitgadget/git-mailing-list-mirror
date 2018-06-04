Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.5 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id AF9F01F403
	for <e@80x24.org>; Mon,  4 Jun 2018 11:47:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752946AbeFDLr0 (ORCPT <rfc822;e@80x24.org>);
        Mon, 4 Jun 2018 07:47:26 -0400
Received: from mail-qt0-f194.google.com ([209.85.216.194]:37644 "EHLO
        mail-qt0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752598AbeFDLrO (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 4 Jun 2018 07:47:14 -0400
Received: by mail-qt0-f194.google.com with SMTP id q13-v6so40063162qtp.4
        for <git@vger.kernel.org>; Mon, 04 Jun 2018 04:47:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-transfer-encoding:content-language;
        bh=AnXs6Z/9fGLepxrU8km7UBlwWvoEYuzBzik6J4Z4bBA=;
        b=mAbEz+mvErLrtNwwlYT5vHXMvIFq3WLWLmjo/xZyhQgAEFUMkXsB4/AD16zugSMobB
         BiHM3Y1yZQ22alHZQT9wQ1k4VZsX7cYkORy7ygGSnayR4p0wBdflt8/JUFst0EYalJPL
         eVUKVb1GKrjTVjLl6YGrBq99yS3aYRRTMclgEytIRDpZIVKa/kNl4mhPA2WKirs680eg
         DG9c4mGPSwIvG01Cybh/wJwvyLtdSbkID16W59AZBxzLEn8cMixCLmNfKoLt1yLLSnOo
         OWd/V2lU1uEqr/Z82smaqrZn2zPfm8vhgWjqFZmTpg8s+q5vXfovJAreA6j3QK0pOOxZ
         eaQw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding
         :content-language;
        bh=AnXs6Z/9fGLepxrU8km7UBlwWvoEYuzBzik6J4Z4bBA=;
        b=O8sE8H4TJDTxTRNVacNrAbRok+msoucleM/TOKZtjO8WLjkPXQOES8TSxtGwF9Lmzs
         JJF1L+MZghTiRbe48Z5X4v83+bX07EvuoB8DewYKyHRChppBUDAplaKXFjNyd4vPJD6v
         HJAUH0rtdsFHa52Qb+Y8+3xsWh7kmfcFEtJyCyE8ea8elbuAwmu77UoaiRlH3TPCc6Nx
         zmFZpQTVaA+dNCV0HPmsUBwQFI10ioOIxIFgaIHpJWz0Gla4sQmIPakBpfyp2p+0TSCY
         rSR9BnalKT1g32edzPAPZ8nl/AjdePZVr952JlvigLKHFH/XXskHSKBhQY96SjBXBVkY
         v/Zw==
X-Gm-Message-State: APt69E1ABAESg3fIW3lRNfxODKY6+bxtLa+I3kruN6KpsgzbfcPNzDWt
        jQiSDd4/57IUB8TrgbBn9nI=
X-Google-Smtp-Source: ADUXVKKoqsKfE2aoRUdoz4lWhmCGPgkNczM+UTQoCSq9UqNoQSOEenosV4/L38LVKJUvCDCg5f2n9g==
X-Received: by 2002:ac8:39f:: with SMTP id t31-v6mr10976064qtg.216.1528112833959;
        Mon, 04 Jun 2018 04:47:13 -0700 (PDT)
Received: from ?IPv6:2001:4898:6808:13e:2d1c:9d08:485:87f2? ([2001:4898:8010:0:1652:9d08:485:87f2])
        by smtp.gmail.com with ESMTPSA id 34-v6sm10351985qtt.76.2018.06.04.04.47.12
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 04 Jun 2018 04:47:12 -0700 (PDT)
Subject: Re: [PATCH v3 13/20] commit-graph: verify generation number
To:     Jakub Narebski <jnareb@gmail.com>,
        Derrick Stolee <dstolee@microsoft.com>
Cc:     "git@vger.kernel.org" <git@vger.kernel.org>,
        "gitster@pobox.com" <gitster@pobox.com>,
        "avarab@gmail.com" <avarab@gmail.com>,
        "marten.agren@gmail.com" <marten.agren@gmail.com>,
        "peff@peff.net" <peff@peff.net>
References: <20180511211504.79877-1-dstolee@microsoft.com>
 <20180524162504.158394-1-dstolee@microsoft.com>
 <20180524162504.158394-14-dstolee@microsoft.com> <868t7xv0km.fsf@gmail.com>
From:   Derrick Stolee <stolee@gmail.com>
Message-ID: <51347e11-418b-5714-c6f0-668a9f7a6abf@gmail.com>
Date:   Mon, 4 Jun 2018 07:47:12 -0400
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.8.0
MIME-Version: 1.0
In-Reply-To: <868t7xv0km.fsf@gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 6/2/2018 8:23 AM, Jakub Narebski wrote:
> Derrick Stolee <dstolee@microsoft.com> writes:
>
>> While iterating through the commit parents, perform the generation
>> number calculation and compare against the value stored in the
>> commit-graph.
> All right, that's good.
>
> What about commit-graph files that have GENERATION_NUMBER_ZERO for all
> its commits (because we verify single commit-graph file only, there
> wouldn't be GENERATION_NUMBER_ZERO mixed with non-zero generation
> numbers)?
>
> Unless we can assume that no commit-graph file in the wild would have
> GENERATION_NUMBER_ZERO.

I was expecting that we would not have files in the wild with 
GENERATION_NUMBER_ZERO, but it looks like 2.18 will create files like 
that. I'll put in logic to verify "all are GENERATION_NUMBER_ZERO or all 
have 'correct' generation number".

>
>> The tests demonstrate that having a different set of parents affects
>> the generation number calculation, and this value propagates to
>> descendants. Hence, we drop the single-line condition on the output.
> I don't understand what part of changes this paragraph of the commit
> message refers to.
>
> Anyway, changing parents may not lead to changed generation numbers;
> take for example commit with single parent, which we change to other
> commit with the same generation number.

The tests introduced in the previous commit change the parent list, 
which then changes the generation number in some cases (the stored 
generation number doesn't match the generation number computed based on 
the loaded parents). Since we report as many errors as possible (instead 
of failing on first error) those tests would fail if we say "the _only_ 
error should be the parent list". (This comes up again when we report 
the hash is incorrect, which would appear in every test.)

The test introduced in this commit only changes the generation number, 
so that test will have the one error.

>
>> Signed-off-by: Derrick Stolee <dstolee@microsoft.com>
>> ---
>>   commit-graph.c          | 18 ++++++++++++++++++
>>   t/t5318-commit-graph.sh |  6 ++++++
> Sidenote: I have just realized that it may be better to put
> validation-related tests into different test file.
>
>>   2 files changed, 24 insertions(+)
>>
>> diff --git a/commit-graph.c b/commit-graph.c
>> index fff22dc0c3..ead92460c1 100644
>> --- a/commit-graph.c
>> +++ b/commit-graph.c
>> @@ -922,6 +922,7 @@ int verify_commit_graph(struct commit_graph *g)
>>   	for (i = 0; i < g->num_commits; i++) {
>>   		struct commit *graph_commit, *odb_commit;
>>   		struct commit_list *graph_parents, *odb_parents;
>> +		uint32_t max_generation = 0;
>>   
>>   		hashcpy(cur_oid.hash, g->chunk_oid_lookup + g->hash_len * i);
>>   
>> @@ -956,6 +957,9 @@ int verify_commit_graph(struct commit_graph *g)
>>   					     oid_to_hex(&graph_parents->item->object.oid),
>>   					     oid_to_hex(&odb_parents->item->object.oid));
>>   
>> +			if (graph_parents->item->generation > max_generation)
>> +				max_generation = graph_parents->item->generation;
>> +
> All right, that calculates the maximum of generation number of commit
> parents.
>
>>   			graph_parents = graph_parents->next;
>>   			odb_parents = odb_parents->next;
>>   		}
>> @@ -963,6 +967,20 @@ int verify_commit_graph(struct commit_graph *g)
>>   		if (odb_parents != NULL)
>>   			graph_report("commit-graph parent list for commit %s terminates early",
>>   				     oid_to_hex(&cur_oid));
>> +
>> +		/*
>> +		 * If one of our parents has generation GENERATION_NUMBER_MAX, then
>> +		 * our generation is also GENERATION_NUMBER_MAX. Decrement to avoid
>> +		 * extra logic in the following condition.
>> +		 */
> Nice trick.
>
>> +		if (max_generation == GENERATION_NUMBER_MAX)
>> +			max_generation--;
> What about GENERATION_NUMBER_ZERO?
>
>> +
>> +		if (graph_commit->generation != max_generation + 1)
>> +			graph_report("commit-graph generation for commit %s is %u != %u",
>> +				     oid_to_hex(&cur_oid),
>> +				     graph_commit->generation,
>> +				     max_generation + 1);
> I think we should also check that generation numbers do not exceed
> GENERATION_NUMBER_MAX... unless it is already taken care of?

We get that for free. First, the condition above would fail for at least 
one commit. Second, we literally cannot store a value larger than 
GENERATION_NUMBER_MAX in the commit-graph as there are only 30 bits 
dedicated to the generation number.

>
>>   	}
>>   
>>   	return verify_commit_graph_error;
>> diff --git a/t/t5318-commit-graph.sh b/t/t5318-commit-graph.sh
>> index 12f0d7f54d..673b0d37d5 100755
>> --- a/t/t5318-commit-graph.sh
>> +++ b/t/t5318-commit-graph.sh
>> @@ -272,6 +272,7 @@ GRAPH_BYTE_COMMIT_TREE=$GRAPH_COMMIT_DATA_OFFSET
>>   GRAPH_BYTE_COMMIT_PARENT=`expr $GRAPH_COMMIT_DATA_OFFSET + $HASH_LEN`
>>   GRAPH_BYTE_COMMIT_EXTRA_PARENT=`expr $GRAPH_COMMIT_DATA_OFFSET + $HASH_LEN + 4`
>>   GRAPH_BYTE_COMMIT_WRONG_PARENT=`expr $GRAPH_COMMIT_DATA_OFFSET + $HASH_LEN + 3`
>> +GRAPH_BYTE_COMMIT_GENERATION=`expr $GRAPH_COMMIT_DATA_OFFSET + $HASH_LEN + 8`
>>   
>>   # usage: corrupt_graph_and_verify <position> <data> <string>
>>   # Manipulates the commit-graph file at the position
>> @@ -366,4 +367,9 @@ test_expect_success 'detect incorrect tree OID' '
>>   		"commit-graph parent for"
>>   '
>>   
>> +test_expect_success 'detect incorrect generation number' '
>> +	corrupt_graph_and_verify $GRAPH_BYTE_COMMIT_GENERATION "\01" \
> I assume that you have checked that it actually corrupts generation
> number (without affecting commit date).
>
>> +		"generation"
> A very minor nitpick: Not "generation for commit"?
>
>> +'
>> +
>>   test_done

