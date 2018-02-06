Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 1D55C1F404
	for <e@80x24.org>; Tue,  6 Feb 2018 14:53:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752450AbeBFOxM (ORCPT <rfc822;e@80x24.org>);
        Tue, 6 Feb 2018 09:53:12 -0500
Received: from mail-qk0-f172.google.com ([209.85.220.172]:34693 "EHLO
        mail-qk0-f172.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752297AbeBFOxE (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 6 Feb 2018 09:53:04 -0500
Received: by mail-qk0-f172.google.com with SMTP id m130so2596619qke.1
        for <git@vger.kernel.org>; Tue, 06 Feb 2018 06:53:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-transfer-encoding:content-language;
        bh=zOkhOq/XxAPqmDWfQ0HYzM1JFUooGU360MqPlnR4iAg=;
        b=N2UGUhYg+aWlTzg/Knrz9JkqOPKs1o0tvRIS75PEK8fRW2C/Mbb6AwKAhPNM8neLWF
         KiKclrijz5mp3ohMROh7J+lirvc657IJk3p6IZsYJYD6nvoBNuXSdvXFoYdjXf7YjAcR
         VmhyhVwStf4Ro7hvKjrFt6Nx9WD47ikWszMRO9uMHKHVZ8Zy7iZF7EWIkbHgJhB4Q9fS
         aa0OJrLQl1EWJk+7XPTlhvGqDo23og8WXSa/s4HMzb3i3JOEGe5qnmtpiGOtteiGiCzk
         HM72lKkbsn7FUldf7mri5zwmzjVU/El8pAclGkgtJIo82oCjlrUwwkBTgvZRAvIffVUR
         7/+Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding
         :content-language;
        bh=zOkhOq/XxAPqmDWfQ0HYzM1JFUooGU360MqPlnR4iAg=;
        b=aI6JM1nP6zZd67i7V7SyjdCoRuhjhtrEYjVO9npvEetkwWGlKd3VMy6BbugFjE8uRE
         BMXumduGgYVlz4wGcnwNBq528xiGPc/4IFwp7CZVM2PLWIRQDxqbpStUJIZ6YTCZZdnu
         TQFdJgHiScCmsewZxzrmbbe8RPegfs73si6ak7BI5HEHJwNZG2l9IsaCsQr05jeAMrZO
         2zUoRqZ+07GY5/MmeUisyN/jeeHMMH6li9jXzhM44yNWoUe/EcEGpXVyuP7iMBL6v0q0
         37xHevitjPemwHceXgo+JF+cOGoTGnD9tgWidKZfUf80Yslto2Vad9bvG8c50ofUla4A
         P6EQ==
X-Gm-Message-State: APf1xPDfsEKhCsyUPjZZRMe3Ur1uFfe4AssgUd/PWoKiKYoEU+hYMe7W
        lyc6AZA2CVdtsTw5HR09SyM=
X-Google-Smtp-Source: AH8x225du68JAh1pJiB8krHwYIHP28oI3Afiu31CMuIQre4Ak995ywg6o7V7SejJ335b8zVeN6wGbA==
X-Received: by 10.55.132.193 with SMTP id g184mr3389712qkd.171.1517928783645;
        Tue, 06 Feb 2018 06:53:03 -0800 (PST)
Received: from ?IPv6:2001:4898:6808:13e:88ad:1fb1:3dd7:9d03? ([2001:4898:8010:0:71e3:1fb1:3dd7:9d03])
        by smtp.gmail.com with ESMTPSA id 23sm8098881qtx.33.2018.02.06.06.53.02
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 06 Feb 2018 06:53:02 -0800 (PST)
Subject: Re: [PATCH v2 11/14] commit: integrate commit graph with commit
 parsing
To:     Jonathan Tan <jonathantanmy@google.com>
Cc:     git@vger.kernel.org, gitster@pobox.com, peff@peff.net,
        git@jeffhostetler.com, sbeller@google.com, dstolee@microsoft.com
References: <1517348383-112294-1-git-send-email-dstolee@microsoft.com>
 <1517348383-112294-12-git-send-email-dstolee@microsoft.com>
 <20180201175151.89555950582a2e6c5279849a@google.com>
From:   Derrick Stolee <stolee@gmail.com>
Message-ID: <11c4f90e-558c-b80c-61f0-f70cdcf6edd9@gmail.com>
Date:   Tue, 6 Feb 2018 09:53:01 -0500
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.6.0
MIME-Version: 1.0
In-Reply-To: <20180201175151.89555950582a2e6c5279849a@google.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 2/1/2018 8:51 PM, Jonathan Tan wrote:
> On Tue, 30 Jan 2018 16:39:40 -0500
> Derrick Stolee <stolee@gmail.com> wrote:
>
>> +/* global storage */
>> +struct commit_graph *commit_graph = 0;
> NULL, not 0.
>
>> +static int bsearch_graph(struct commit_graph *g, struct object_id *oid, uint32_t *pos)
>> +{
>> +	uint32_t last, first = 0;
>> +
>> +	if (oid->hash[0])
>> +		first = ntohl(*(uint32_t*)(g->chunk_oid_fanout + 4 * (oid->hash[0] - 1)));
>> +	last = ntohl(*(uint32_t*)(g->chunk_oid_fanout + 4 * oid->hash[0]));
>> +
>> +	while (first < last) {
>> +		uint32_t mid = first + (last - first) / 2;
>> +		const unsigned char *current;
>> +		int cmp;
>> +
>> +		current = g->chunk_oid_lookup + g->hdr->hash_len * mid;
>> +		cmp = hashcmp(oid->hash, current);
>> +		if (!cmp) {
>> +			*pos = mid;
>> +			return 1;
>> +		}
>> +		if (cmp > 0) {
>> +			first = mid + 1;
>> +			continue;
>> +		}
>> +		last = mid;
>> +	}
>> +
>> +	*pos = first;
>> +	return 0;
>> +}
> This would be better in sha1-lookup.c, something like the reverse of commit
> f1068efefe6d ("sha1_file: drop experimental GIT_USE_LOOKUP search",
> 2017-08-09), except that it can be done using a simple binary search.

I rebased my patch onto your binary search patch, so I'll use that in 
the future.

>
>> +static int full_parse_commit(struct commit *item, struct commit_graph *g,
>> +			     uint32_t pos, const unsigned char *commit_data)
>> +{
>> +	struct object_id oid;
>> +	struct commit *new_parent;
>> +	uint32_t new_parent_pos;
>> +	uint32_t *parent_data_ptr;
>> +	uint64_t date_low, date_high;
>> +	struct commit_list **pptr;
>> +
>> +	item->object.parsed = 1;
>> +	item->graph_pos = pos;
>> +
>> +	hashcpy(oid.hash, commit_data);
>> +	item->tree = lookup_tree(&oid);
>> +
>> +	date_high = ntohl(*(uint32_t*)(commit_data + g->hdr->hash_len + 8)) & 0x3;
>> +	date_low = ntohl(*(uint32_t*)(commit_data + g->hdr->hash_len + 12));
>> +	item->date = (timestamp_t)((date_high << 32) | date_low);
>> +
>> +	pptr = &item->parents;
>> +
>> +	new_parent_pos = ntohl(*(uint32_t*)(commit_data + g->hdr->hash_len));
>> +	if (new_parent_pos == GRAPH_PARENT_NONE)
>> +		return 1;
>> +	get_nth_commit_oid(g, new_parent_pos, &oid);
>> +	new_parent = lookup_commit(&oid);
>> +	if (new_parent) {
>> +		new_parent->graph_pos = new_parent_pos;
>> +		pptr = &commit_list_insert(new_parent, pptr)->next;
>> +	} else {
>> +		die("could not find commit %s", oid_to_hex(&oid));
>> +	}
>> +
>> +	new_parent_pos = ntohl(*(uint32_t*)(commit_data + g->hdr->hash_len + 4));
>> +	if (new_parent_pos == GRAPH_PARENT_NONE)
>> +		return 1;
>> +	if (!(new_parent_pos & GRAPH_LARGE_EDGES_NEEDED)) {
>> +		get_nth_commit_oid(g, new_parent_pos, &oid);
>> +		new_parent = lookup_commit(&oid);
>> +		if (new_parent) {
>> +			new_parent->graph_pos = new_parent_pos;
>> +			pptr = &commit_list_insert(new_parent, pptr)->next;
>> +		} else
>> +			die("could not find commit %s", oid_to_hex(&oid));
>> +		return 1;
>> +	}
>> +
>> +	parent_data_ptr = (uint32_t*)(g->chunk_large_edges + 4 * (new_parent_pos ^ GRAPH_LARGE_EDGES_NEEDED));
>> +	do {
>> +		new_parent_pos = ntohl(*parent_data_ptr);
>> +
>> +		get_nth_commit_oid(g, new_parent_pos & GRAPH_EDGE_LAST_MASK, &oid);
>> +		new_parent = lookup_commit(&oid);
>> +		if (new_parent) {
>> +			new_parent->graph_pos = new_parent_pos & GRAPH_EDGE_LAST_MASK;
>> +			pptr = &commit_list_insert(new_parent, pptr)->next;
>> +		} else
>> +			die("could not find commit %s", oid_to_hex(&oid));
>> +		parent_data_ptr++;
>> +	} while (!(new_parent_pos & GRAPH_LAST_EDGE));
>> +
>> +	return 1;
>> +}
> The part that converts <pointer to parent data> into <struct commit *>
> seems to be duplicated 3 times. Refactor into a function?

Will do.

>
>> +/**
>> + * Fill 'item' to contain all information that would be parsed by parse_commit_buffer.
>> + */
>> +static int fill_commit_in_graph(struct commit *item, struct commit_graph *g, uint32_t pos)
>> +{
>> +	uint32_t new_parent_pos;
>> +	uint32_t *parent_data_ptr;
>> +	const unsigned char *commit_data = g->chunk_commit_data + (g->hdr->hash_len + 16) * pos;
>> +
>> +	new_parent_pos = ntohl(*(uint32_t*)(commit_data + g->hdr->hash_len));
>> +
>> +	if (new_parent_pos == GRAPH_PARENT_MISSING)
>> +		return 0;
>> +
>> +	if (new_parent_pos == GRAPH_PARENT_NONE)
>> +		return full_parse_commit(item, g, pos, commit_data);
>> +
>> +	new_parent_pos = ntohl(*(uint32_t*)(commit_data + g->hdr->hash_len + 4));
>> +
>> +	if (new_parent_pos == GRAPH_PARENT_MISSING)
>> +		return 0;
>> +	if (!(new_parent_pos & GRAPH_LARGE_EDGES_NEEDED))
>> +		return full_parse_commit(item, g, pos, commit_data);
>> +
>> +	new_parent_pos = new_parent_pos ^ GRAPH_LARGE_EDGES_NEEDED;
>> +
>> +	if (new_parent_pos == GRAPH_PARENT_MISSING)
>> +		return 0;
>> +
>> +	parent_data_ptr = (uint32_t*)(g->chunk_large_edges + 4 * new_parent_pos);
>> +	do {
>> +		new_parent_pos = ntohl(*parent_data_ptr);
>> +
>> +		if ((new_parent_pos & GRAPH_EDGE_LAST_MASK) == GRAPH_PARENT_MISSING)
>> +			return 0;
>> +
>> +		parent_data_ptr++;
>> +	} while (!(new_parent_pos & GRAPH_LAST_EDGE));
>> +
>> +	return full_parse_commit(item, g, pos, commit_data);
>> +}
> This function seems to just check for GRAPH_PARENT_MISSING - could that
> check be folded into full_parse_commit() instead? (Then
> full_parse_commit can be renamed to fill_commit_in_graph.)

I'd rather not have a really long method, but I could make the two steps 
their own static methods (one for checking and one for full parsing) to 
make it more clear that there are two steps here.

>
>> @@ -439,9 +656,24 @@ struct object_id *construct_commit_graph(const char *pack_dir)
>>   	char *fname;
>>   	struct commit_list *parent;
>>   
>> +	prepare_commit_graph();
>> +
>>   	oids.num = 0;
>>   	oids.size = 1024;
>> +
>> +	if (commit_graph && oids.size < commit_graph->num_commits)
>> +		oids.size = commit_graph->num_commits;
>> +
>>   	ALLOC_ARRAY(oids.list, oids.size);
>> +
>> +	if (commit_graph) {
>> +		for (i = 0; i < commit_graph->num_commits; i++) {
>> +			oids.list[i] = malloc(sizeof(struct object_id));
>> +			get_nth_commit_oid(commit_graph, i, oids.list[i]);
>> +		}
>> +		oids.num = commit_graph->num_commits;
>> +	}
>> +
>>   	for_each_packed_object(if_packed_commit_add_to_list, &oids, 0);
>>   	QSORT(oids.list, oids.num, commit_compare);

This change auto-includes the commits that were in the existing graph 
into the new graph.

>>   
>> @@ -525,6 +757,11 @@ struct object_id *construct_commit_graph(const char *pack_dir)
>>   	hashcpy(f_hash->hash, final_hash);
>>   	fname = get_commit_graph_filename_hash(pack_dir, f_hash);
>>   
>> +	if (commit_graph) {
>> +		close_commit_graph(commit_graph);
>> +		FREE_AND_NULL(commit_graph);
>> +	}
>> +
>>   	if (rename(graph_name, fname))
>>   		die("failed to rename %s to %s", graph_name, fname);

This change is necessary if we are going to use --delete-expired, as we 
need to unmap the file before we can delete it. Perhaps it would be 
better to close the graph in the builtin instead so that relationship is 
clearer.

> What is the relation of these changes to construct_commit_graph() to the
> rest of the patch?

(answered above, since the two changes have different purposes)

>> diff --git a/commit-graph.h b/commit-graph.h
>> index 43eb0aec84..05ddbbe165 100644
>> --- a/commit-graph.h
>> +++ b/commit-graph.h
>> @@ -4,6 +4,18 @@
>>   #include "git-compat-util.h"
>>   #include "commit.h"
>>   
>> +/**
>> + * Given a commit struct, try to fill the commit struct info, including:
>> + *  1. tree object
>> + *  2. date
>> + *  3. parents.
>> + *
>> + * Returns 1 if and only if the commit was found in the packed graph.
>> + *
>> + * See parse_commit_buffer() for the fallback after this call.
>> + */
>> +extern int parse_commit_in_graph(struct commit *item);
>> +
>>   extern struct object_id *get_graph_head_hash(const char *pack_dir,
>>   					     struct object_id *hash);
>>   extern char* get_commit_graph_filename_hash(const char *pack_dir,
>> @@ -40,7 +52,13 @@ extern struct commit_graph {
>>   
>>   extern int close_commit_graph(struct commit_graph *g);
>>   
>> -extern struct commit_graph *load_commit_graph_one(const char *graph_file, const char *pack_dir);
>> +extern struct commit_graph *load_commit_graph_one(const char *graph_file,
>> +						  const char *pack_dir);
>> +extern void prepare_commit_graph(void);
>> +
>> +extern struct object_id *get_nth_commit_oid(struct commit_graph *g,
>> +					    uint32_t n,
>> +					    struct object_id *oid);
>>   
>>   extern struct object_id *construct_commit_graph(const char *pack_dir);
> This header file now contains functions for reading the commit graph,
> and functions for writing one. It seems to me that those are (and should
> be) quite disjoint, so it might be better to separate them into two.

This header file provides a unified API surface for interacting with 
commit graphs. I'm not a fan of how other write commands are hidden in 
the builtins (like 'builtin/pack-objects.c' for writing packs). If there 
is a better example of how this split has been done in the root 
directory, I'm happy to consider it.

>
>> -int parse_commit_gently(struct commit *item, int quiet_on_missing)
>> +int parse_commit_internal(struct commit *item, int quiet_on_missing, int check_packed)
>>   {
>>   	enum object_type type;
>>   	void *buffer;
>> @@ -385,6 +386,8 @@ int parse_commit_gently(struct commit *item, int quiet_on_missing)
>>   		return -1;
>>   	if (item->object.parsed)
>>   		return 0;
>> +	if (check_packed && parse_commit_in_graph(item))
>> +		return 0;
>>   	buffer = read_sha1_file(item->object.oid.hash, &type, &size);
>>   	if (!buffer)
>>   		return quiet_on_missing ? -1 :
>> @@ -404,6 +407,11 @@ int parse_commit_gently(struct commit *item, int quiet_on_missing)
>>   	return ret;
>>   }
>>   
>> +int parse_commit_gently(struct commit *item, int quiet_on_missing)
>> +{
>> +	return parse_commit_internal(item, quiet_on_missing, 1);
>> +}
> Are you planning to use parse_commit_internal() from elsewhere? (It
> doesn't seem to be the case, at least from this patch series.)

At one point I was using it, but I removed the one caller and forgot to 
clean up.

>
>> diff --git a/log-tree.c b/log-tree.c
>> index fca29d4799..156aed4541 100644
>> --- a/log-tree.c
>> +++ b/log-tree.c
>> @@ -659,8 +659,7 @@ void show_log(struct rev_info *opt)
>>   		show_mergetag(opt, commit);
>>   	}
>>   
>> -	if (!get_cached_commit_buffer(commit, NULL))
>> -		return;
>> +	get_commit_buffer(commit, NULL);
> This undoes an optimization that I discuss in my e-mail message here
> [1]. If we decide to do this, it should at least be called out in the
> commit message.
>
> [1] https://public-inbox.org/git/b88725476d9f13ba4381d85e5fe049f6ef93f621.1506714999.git.jonathantanmy@google.com/

I will call this out more clearly in my commit message next time. My 
problem with the existing code is that it doesn't just ignore the commit 
contents but will actually not write a newline. I noticed during testing 
'git log --oneline' with the graph enabled and the output listed several 
short-shas in one line.

>
>> +_graph_git_two_modes() {
> No need for the name to start with an underscore, I think.
>
>> +    git -c core.commitgraph=true $1 >output
>> +    git -c core.commitgraph=false $1 >expect
>> +    cmp output expect
> Use test_cmp.
>
>> +}
>> +
>> +_graph_git_behavior() {
>> +    BRANCH=$1
>> +    COMPARE=$2
>> +    test_expect_success 'check normal git operations' \
>> +        '_graph_git_two_modes "log --oneline ${BRANCH}" &&
>> +         _graph_git_two_modes "log --topo-order ${BRANCH}" &&
>> +         _graph_git_two_modes "branch -vv" &&
>> +         _graph_git_two_modes "merge-base -a ${BRANCH} ${COMPARE}"'
>> +}
> This makes it difficult to debug failing tests, since they're all named
> the same. Better to just run the commands inline, and wrap the
> invocations of _graph_git_behavior in an appropriately named
> test_expect_success.

I'll add a parameter that adds a message to each test about the state of 
the repo and graph.

Thanks,
-Stolee
