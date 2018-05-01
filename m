Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.4 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 95793215F4
	for <e@80x24.org>; Tue,  1 May 2018 12:10:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754846AbeEAMKY (ORCPT <rfc822;e@80x24.org>);
        Tue, 1 May 2018 08:10:24 -0400
Received: from mail-qt0-f172.google.com ([209.85.216.172]:41756 "EHLO
        mail-qt0-f172.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754734AbeEAMKX (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 1 May 2018 08:10:23 -0400
Received: by mail-qt0-f172.google.com with SMTP id g13-v6so14309538qth.8
        for <git@vger.kernel.org>; Tue, 01 May 2018 05:10:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-transfer-encoding:content-language;
        bh=HXp4f74uhykh2N1M9vcmxvVGwr88L8qvqQIBppha3xk=;
        b=lM1WjwMtSQcMwUvTl7PEQoESbwE/ffkEXZnSDgHj2vat73fYwO4vSKd5n1f4j5gu7r
         ZpymKnxGkJ3VDT+Huch5VLK7V6lNKugkuhR0801yq9j/BnTzRam6SmrCcCBcII+FPn/Y
         M16ghpO+XK7quq+d7WQj5Kc+4nIbS2Pm51BC2jM9CGBvIZ1/Cg12Y6o4Mk4ssBpLy4CZ
         X7I8KHUYZhAuSyjVelN6gllkyUxp1O0pXc6cncG0xHWev1/TMOkV3VHgcJVh4f+xq+tl
         WhT0Sdn/BihVelLYRqbI1dyArv3Na3c6XfJZF/70WxI9Zh2KmPBfuh+BfEAz1RUhcZoz
         MP3w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding
         :content-language;
        bh=HXp4f74uhykh2N1M9vcmxvVGwr88L8qvqQIBppha3xk=;
        b=QVT9n0T6wTCvEeh9esQzSBgoUQRwCp/MNN/d6T1OoIIjs/L4fSiG14/QO64Il0kLvx
         h93dtaEv/f3a54GiJlCYXTW29WRPjDUytDF5wWaAmCRG//DkeBnj9fkWs1Fk7vhL882P
         3FOTrLqMQz5GL3gGLvOAtT3GB7OBhc8bnUuuKVJmEEVFexFlEQ9OvaWlh5GVCD7GAg3k
         W6E8Zk0RBQaO4/RDlj+Fhf6KqOKPjrgI5tENz6Ag5f4L6t6FsMzf6cyQ0NlAYNGrVFXa
         +pxlW3fbevGo5f/iSJBrG5DEUxBwp0wkWYz9ky4tP4nSzUy+sEMnW+GXcUPJi5AC+Dig
         KPdw==
X-Gm-Message-State: ALQs6tDkEulz/PtfadyUQQGpDFr/guiffx9lQLXTZ8E56OTkm5HwoUG5
        MFNfO+npsLSC5AibNMANItQ=
X-Google-Smtp-Source: AB8JxZr1h6BXwMHhpgqBPDJXOvVkMNzPCK7Qf23tsF8fihTkqcsuU9x7cgwJqYdZh9t3xORoiVDUug==
X-Received: by 2002:aed:3df4:: with SMTP id j49-v6mr13704493qtf.110.1525176622283;
        Tue, 01 May 2018 05:10:22 -0700 (PDT)
Received: from ?IPv6:2001:4898:6808:13e:c4e6:7a22:56f1:df04? ([2001:4898:8010:0:ae1c:7a22:56f1:df04])
        by smtp.gmail.com with ESMTPSA id i45-v6sm8462647qta.12.2018.05.01.05.10.21
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 01 May 2018 05:10:21 -0700 (PDT)
Subject: Re: [PATCH v4 03/10] commit-graph: compute generation numbers
To:     Jakub Narebski <jnareb@gmail.com>,
        Derrick Stolee <dstolee@microsoft.com>
Cc:     "git@vger.kernel.org" <git@vger.kernel.org>,
        "gitster@pobox.com" <gitster@pobox.com>,
        "peff@peff.net" <peff@peff.net>,
        "avarab@gmail.com" <avarab@gmail.com>
References: <20180417170001.138464-1-dstolee@microsoft.com>
 <20180425143735.240183-1-dstolee@microsoft.com>
 <20180425143735.240183-4-dstolee@microsoft.com> <86r2myidmq.fsf@gmail.com>
From:   Derrick Stolee <stolee@gmail.com>
Message-ID: <0bd1ffe0-c727-653a-46a3-f9d4ea17bec2@gmail.com>
Date:   Tue, 1 May 2018 08:10:20 -0400
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.7.0
MIME-Version: 1.0
In-Reply-To: <86r2myidmq.fsf@gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 4/29/2018 5:08 AM, Jakub Narebski wrote:
> Derrick Stolee <dstolee@microsoft.com> writes:
>
>> While preparing commits to be written into a commit-graph file, compute
>> the generation numbers using a depth-first strategy.
> Sidenote: for generation numbers it does not matter if we use
> depth-first or breadth-first strategy, but it is more natural to use
> depth-first search because generation numbers need post-order processing
> (parents before child).
>
>> The only commits that are walked in this depth-first search are those
>> without a precomputed generation number. Thus, computation time will be
>> relative to the number of new commits to the commit-graph file.
> A question: what happens if the existing commit graph is from older
> version of git and has _ZERO for generation numbers?
>
> Answer: I see that we treat both _INFINITY (not in commit-graph) and
> _ZERO (in commit graph but not computed) as not computed generation
> numbers.  All right.
>
>> If a computed generation number would exceed GENERATION_NUMBER_MAX, then
>> use GENERATION_NUMBER_MAX instead.
> All right, though I guess this would remain theoretical for a long
> while.
>
> We don't have any way of testing this, at least not without recompiling
> Git with lower value of GENERATION_NUMBER_MAX -- which means not
> automatically, isn't it?
>
>> Signed-off-by: Derrick Stolee <dstolee@microsoft.com>
>> ---
>>   commit-graph.c | 45 +++++++++++++++++++++++++++++++++++++++++++++
>>   1 file changed, 45 insertions(+)
>>
>> diff --git a/commit-graph.c b/commit-graph.c
>> index 9ad21c3ffb..047fa9fca5 100644
>> --- a/commit-graph.c
>> +++ b/commit-graph.c
>> @@ -439,6 +439,9 @@ static void write_graph_chunk_data(struct hashfile *f, int hash_len,
>>   		else
>>   			packedDate[0] = 0;
>>   
>> +		if ((*list)->generation != GENERATION_NUMBER_INFINITY)
>> +			packedDate[0] |= htonl((*list)->generation << 2);
>> +
> If we stumble upon commit marked as "not in commit-graph" while writing
> commit graph, it is a BUG(), isn't it?
>
> (Problem noticed by Junio.)

Since we are computing the values for all commits in the list, this 
condition is not important and will be removed.

>
> It is a bit strange to me that the code uses get_be32 for reading, but
> htonl for writing.  Is Git tested on non little-endian machines, like
> big-endian ppc64 or s390x, or on mixed-endian machines (or
> selectable-endian machines with data endianness set to non
> little-endian, like ia64)?  If not, could we use for example openSUSE
> Build Service (https://build.opensuse.org/) for this?

Since we are packing two values into 64 bits, I am using htonl() here to 
arrange the 30-bit generation number alongside the 34-bit commit date 
value, then writing with hashwrite(). The other 32-bit integers are 
written with hashwrite_be32() to avoid translating this data in-memory.

>
>>   		packedDate[1] = htonl((*list)->date);
>>   		hashwrite(f, packedDate, 8);
>>   
>> @@ -571,6 +574,46 @@ static void close_reachable(struct packed_oid_list *oids)
>>   	}
>>   }
>>   
>> +static void compute_generation_numbers(struct commit** commits,
>> +				       int nr_commits)
>> +{
>> +	int i;
>> +	struct commit_list *list = NULL;
> All right, commit_list will work as stack.
>
>> +
>> +	for (i = 0; i < nr_commits; i++) {
>> +		if (commits[i]->generation != GENERATION_NUMBER_INFINITY &&
>> +		    commits[i]->generation != GENERATION_NUMBER_ZERO)
>> +			continue;
> All right, we consider _INFINITY and _SERO as not computed.  If
> generation number is computed (by 'recursion' or from commit graph), we
> (re)use it.  This means that generation number calculation is
> incremental, as intended -- good.
>
>> +
>> +		commit_list_insert(commits[i], &list);
> Start depth-first walks from commits given.
>
>> +		while (list) {
>> +			struct commit *current = list->item;
>> +			struct commit_list *parent;
>> +			int all_parents_computed = 1;
> Here all_parents_computed is a boolean flag.  I see that it is easier to
> start with assumption that all parents will have computed generation
> numbers.
>
>> +			uint32_t max_generation = 0;
> The generation number value of 0 functions as sentinel; generation
> numbers start from 1.  Not that it matters much, as lowest possible
> generation number is 1, and we could have started from that value.

Except that for a commit with no parents, we want it to receive 
generation number max_generation + 1 = 1, so this value of 0 is important.

>
>> +
>> +			for (parent = current->parents; parent; parent = parent->next) {
>> +				if (parent->item->generation == GENERATION_NUMBER_INFINITY ||
>> +				    parent->item->generation == GENERATION_NUMBER_ZERO) {
>> +					all_parents_computed = 0;
>> +					commit_list_insert(parent->item, &list);
>> +					break;
> If some parent doesn't have generation number calculated, we add it to
> stack (and break out of loop because it is depth-first walk), and mark
> this situation.  All right.
>
>> +				} else if (parent->item->generation > max_generation) {
>> +					max_generation = parent->item->generation;
> Otherwise, update max_generation.  All right.
>
>> +				}
>> +			}
>> +
>> +			if (all_parents_computed) {
>> +				current->generation = max_generation + 1;
>> +				pop_commit(&list);
>> +			}
>> +
>> +			if (current->generation > GENERATION_NUMBER_MAX)
>> +				current->generation = GENERATION_NUMBER_MAX;
> This conditional should be inside all_parents_computed test, for example
> like this:
>
>    +			if (all_parents_computed) {
>    +				current->generation = max_generation + 1;
>    +				if (current->generation > GENERATION_NUMBER_MAX)
>    +					current->generation = GENERATION_NUMBER_MAX;
>    +
>    +				pop_commit(&list);
>    +			}
>
> (Noticed by Junio.)
>
> Sidenote: when we revisit the commit, returning from depth-first walk of
> one of its parents, we calculate max_generation from scratch again.
> This does not matter for performance, as it's just data access and
> calculating maximum - any workaround to not restart those calculations
> would take more time and memory.  And it's simple.
>
>> +		}
>> +	}
>> +}
>> +
>>   void write_commit_graph(const char *obj_dir,
>>   			const char **pack_indexes,
>>   			int nr_packs,
>> @@ -694,6 +737,8 @@ void write_commit_graph(const char *obj_dir,
>>   	if (commits.nr >= GRAPH_PARENT_MISSING)
>>   		die(_("too many commits to write graph"));
>>   
>> +	compute_generation_numbers(commits.list, commits.nr);
>> +
> Nice and simple.  All right.
>
> I guess that we do not pass "struct packed_commit_list commits" as
> argument to compute_generation_numbers instead of "struct commit**
> commits.list" and "int commits.nr" to compute_generation_numbers() to
> keep the latter nice and generic?

Good catch. There is no reason to not use packed_commit_list here.

>
>>   	graph_name = get_commit_graph_filename(obj_dir);
>>   	fd = hold_lock_file_for_update(&lk, graph_name, 0);
> Best,

