Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.4 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id C390F1F404
	for <e@80x24.org>; Tue, 17 Apr 2018 17:51:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752948AbeDQRvA (ORCPT <rfc822;e@80x24.org>);
        Tue, 17 Apr 2018 13:51:00 -0400
Received: from mail-qk0-f193.google.com ([209.85.220.193]:44240 "EHLO
        mail-qk0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752696AbeDQRu4 (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 17 Apr 2018 13:50:56 -0400
Received: by mail-qk0-f193.google.com with SMTP id u15so5830640qkk.11
        for <git@vger.kernel.org>; Tue, 17 Apr 2018 10:50:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-transfer-encoding:content-language;
        bh=65JRezm3UciqlOSWfTFNHjEWlF6/3TA2pDrzjGyqOdA=;
        b=KFZdlnVCaHUXcod2iZlucudKWXvfTaAORtfc5jIhjVz8o9jH+pZWutUNc8TM3aLc9e
         GZNOk8XLwhQAX4uPtEtgC4Gu4qlo3kHTs/tQrohx9Oh22jmqa98oV5LUBm0tz5xM4ZWS
         fHCmD7xmKAjeUDMBBabcmLy8wSW5KSSm9nZVoOSbQaQL4DHs24AeafQHF9NRVWBCPvCf
         EN4f0g2fzPfUErVTeNJWpZ6Gfy0QtptNGlHkK4/MBQNV5woC570FUsyJeMB3EzU7Q1O8
         JGPR/nswHZJLOxUL4aaMfwLnqjnLQHUDTiiGLP1ERpTYzQXtgcawmpN9f6vA0c1d5wcu
         NA3w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding
         :content-language;
        bh=65JRezm3UciqlOSWfTFNHjEWlF6/3TA2pDrzjGyqOdA=;
        b=WgiDUhzKYUaV762m08Q5N1hTwWja+ldiEX9R5RRf916ZNDB7/gS7vwqHgkEwusZ5HJ
         egs88DYfBx1e6cr8xxQqsoSrb8tBMfdUyJwpjbvzYlbss0nqVITltSyymNZmqrV90UYa
         QNFKo9CVDk+v0QKKPybuqbbO+gbbMco37KKCNQ5yor1yB+IbribToij7R+GjT14sdkPb
         /gc45I/H7EwzTBefdLm2h+/wwFkun6xHfsR59G+aeh9sA+Jwpo++D3SeTUrapVjcyQ6L
         zsJh+Af6Jsovu0XrU9Thhvnn37N4dxIVB0CS992fRUcZvCQF1JeTp3RVTkdAlA4JGH56
         k/ag==
X-Gm-Message-State: ALQs6tCtUMsU6q3xsMx2z3LHDbWLrVYUVYGOYLWJ5SjD8qHwHwN+/K7F
        YIja6mNeD54LTLBB0KgSnUY=
X-Google-Smtp-Source: AIpwx4+SLaCAucQ7Vp7UDeywigCDfihbZqjEq+ognlESu+y7m2By+mgTS1CGObBXJR/RXStNgeesXw==
X-Received: by 10.55.19.2 with SMTP id d2mr3217880qkh.258.1523987455706;
        Tue, 17 Apr 2018 10:50:55 -0700 (PDT)
Received: from ?IPv6:2001:4898:6808:13e:f168:6ce6:8ad9:1b7f? ([2001:4898:8010:0:da9e:6ce6:8ad9:1b7f])
        by smtp.gmail.com with ESMTPSA id 70sm4465157qta.39.2018.04.17.10.50.54
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 17 Apr 2018 10:50:54 -0700 (PDT)
Subject: Re: [PATCH v3 8/9] commit-graph: always load commit-graph information
To:     Derrick Stolee <dstolee@microsoft.com>,
        "git@vger.kernel.org" <git@vger.kernel.org>
Cc:     "peff@peff.net" <peff@peff.net>,
        "avarab@gmail.com" <avarab@gmail.com>,
        "sbeller@google.com" <sbeller@google.com>,
        "larsxschneider@gmail.com" <larsxschneider@gmail.com>,
        "bmwill@google.com" <bmwill@google.com>,
        "gitster@pobox.com" <gitster@pobox.com>,
        "sunshine@sunshineco.com" <sunshine@sunshineco.com>,
        "jonathantanmy@google.com" <jonathantanmy@google.com>
References: <20180409164131.37312-1-dstolee@microsoft.com>
 <20180417170001.138464-1-dstolee@microsoft.com>
 <20180417170001.138464-9-dstolee@microsoft.com>
From:   Derrick Stolee <stolee@gmail.com>
Message-ID: <8500bf59-1910-83db-cdd9-9ccc7d2fe39e@gmail.com>
Date:   Tue, 17 Apr 2018 13:50:51 -0400
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.7.0
MIME-Version: 1.0
In-Reply-To: <20180417170001.138464-9-dstolee@microsoft.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 4/17/2018 1:00 PM, Derrick Stolee wrote:
> Most code paths load commits using lookup_commit() and then
> parse_commit(). In some cases, including some branch lookups, the commit
> is parsed using parse_object_buffer() which side-steps parse_commit() in
> favor of parse_commit_buffer().
>
> With generation numbers in the commit-graph, we need to ensure that any
> commit that exists in the commit-graph file has its generation number
> loaded.
>
> Create new load_commit_graph_info() method to fill in the information
> for a commit that exists only in the commit-graph file. Call it from
> parse_commit_buffer() after loading the other commit information from
> the given buffer. Only fill this information when specified by the
> 'check_graph' parameter. This avoids duplicate work when we already
> checked the graph in parse_commit_gently() or when simply checking the
> buffer contents in check_commit().
>
> Signed-off-by: Derrick Stolee <dstolee@microsoft.com>
> ---
>   commit-graph.c | 51 ++++++++++++++++++++++++++++++++------------------
>   commit-graph.h |  8 ++++++++
>   commit.c       |  7 +++++--
>   commit.h       |  2 +-
>   object.c       |  2 +-
>   sha1_file.c    |  2 +-
>   6 files changed, 49 insertions(+), 23 deletions(-)
>
> diff --git a/commit-graph.c b/commit-graph.c
> index 688d5b1801..21e853c21a 100644
> --- a/commit-graph.c
> +++ b/commit-graph.c
> @@ -245,13 +245,19 @@ static struct commit_list **insert_parent_or_die(struct commit_graph *g,
>   	return &commit_list_insert(c, pptr)->next;
>   }
>   
> +static void fill_commit_graph_info(struct commit *item, struct commit_graph *g, uint32_t pos)
> +{
> +	const unsigned char *commit_data = g->chunk_commit_data + GRAPH_DATA_WIDTH * pos;
> +	item->generation = get_be32(commit_data + g->hash_len + 8) >> 2;
> +}
> +
>   static int fill_commit_in_graph(struct commit *item, struct commit_graph *g, uint32_t pos)
>   {
>   	uint32_t edge_value;
>   	uint32_t *parent_data_ptr;
>   	uint64_t date_low, date_high;
>   	struct commit_list **pptr;
> -	const unsigned char *commit_data = g->chunk_commit_data + (g->hash_len + 16) * pos;
> +	const unsigned char *commit_data = g->chunk_commit_data + GRAPH_DATA_WIDTH * pos;
>   
>   	item->object.parsed = 1;
>   	item->graph_pos = pos;
> @@ -292,31 +298,40 @@ static int fill_commit_in_graph(struct commit *item, struct commit_graph *g, uin
>   	return 1;
>   }
>   
> +static int find_commit_in_graph(struct commit *item, struct commit_graph *g, uint32_t *pos)
> +{
> +	if (item->graph_pos != COMMIT_NOT_FROM_GRAPH) {
> +		*pos = item->graph_pos;
> +		return 1;
> +	} else {
> +		return bsearch_graph(commit_graph, &(item->object.oid), pos);

The reference to 'commit_graph' in the above line should be 'g'. Sorry!

> +	}
> +}
> +
>   int parse_commit_in_graph(struct commit *item)
>   {
> +	uint32_t pos;
> +
> +	if (item->object.parsed)
> +		return 0;
>   	if (!core_commit_graph)
>   		return 0;
> -	if (item->object.parsed)
> -		return 1;
> -
>   	prepare_commit_graph();
> -	if (commit_graph) {
> -		uint32_t pos;
> -		int found;
> -		if (item->graph_pos != COMMIT_NOT_FROM_GRAPH) {
> -			pos = item->graph_pos;
> -			found = 1;
> -		} else {
> -			found = bsearch_graph(commit_graph, &(item->object.oid), &pos);
> -		}
> -
> -		if (found)
> -			return fill_commit_in_graph(item, commit_graph, pos);
> -	}
> -
> +	if (commit_graph && find_commit_in_graph(item, commit_graph, &pos))
> +		return fill_commit_in_graph(item, commit_graph, pos);
>   	return 0;
>   }
>   
> +void load_commit_graph_info(struct commit *item)
> +{
> +	uint32_t pos;
> +	if (!core_commit_graph)
> +		return;
> +	prepare_commit_graph();
> +	if (commit_graph && find_commit_in_graph(item, commit_graph, &pos))
> +		fill_commit_graph_info(item, commit_graph, pos);
> +}
> +
>   static struct tree *load_tree_for_commit(struct commit_graph *g, struct commit *c)
>   {
>   	struct object_id oid;
> diff --git a/commit-graph.h b/commit-graph.h
> index 260a468e73..96cccb10f3 100644
> --- a/commit-graph.h
> +++ b/commit-graph.h
> @@ -17,6 +17,14 @@ char *get_commit_graph_filename(const char *obj_dir);
>    */
>   int parse_commit_in_graph(struct commit *item);
>   
> +/*
> + * It is possible that we loaded commit contents from the commit buffer,
> + * but we also want to ensure the commit-graph content is correctly
> + * checked and filled. Fill the graph_pos and generation members of
> + * the given commit.
> + */
> +void load_commit_graph_info(struct commit *item);
> +
>   struct tree *get_commit_tree_in_graph(const struct commit *c);
>   
>   struct commit_graph {
> diff --git a/commit.c b/commit.c
> index a70f120878..9ef6f699bd 100644
> --- a/commit.c
> +++ b/commit.c
> @@ -331,7 +331,7 @@ const void *detach_commit_buffer(struct commit *commit, unsigned long *sizep)
>   	return ret;
>   }
>   
> -int parse_commit_buffer(struct commit *item, const void *buffer, unsigned long size)
> +int parse_commit_buffer(struct commit *item, const void *buffer, unsigned long size, int check_graph)
>   {
>   	const char *tail = buffer;
>   	const char *bufptr = buffer;
> @@ -386,6 +386,9 @@ int parse_commit_buffer(struct commit *item, const void *buffer, unsigned long s
>   	}
>   	item->date = parse_commit_date(bufptr, tail);
>   
> +	if (check_graph)
> +		load_commit_graph_info(item);
> +
>   	return 0;
>   }
>   
> @@ -412,7 +415,7 @@ int parse_commit_gently(struct commit *item, int quiet_on_missing)
>   		return error("Object %s not a commit",
>   			     oid_to_hex(&item->object.oid));
>   	}
> -	ret = parse_commit_buffer(item, buffer, size);
> +	ret = parse_commit_buffer(item, buffer, size, 0);
>   	if (save_commit_buffer && !ret) {
>   		set_commit_buffer(item, buffer, size);
>   		return 0;
> diff --git a/commit.h b/commit.h
> index 64436ff44e..b5afde1ae9 100644
> --- a/commit.h
> +++ b/commit.h
> @@ -72,7 +72,7 @@ struct commit *lookup_commit_reference_by_name(const char *name);
>    */
>   struct commit *lookup_commit_or_die(const struct object_id *oid, const char *ref_name);
>   
> -int parse_commit_buffer(struct commit *item, const void *buffer, unsigned long size);
> +int parse_commit_buffer(struct commit *item, const void *buffer, unsigned long size, int check_graph);
>   int parse_commit_gently(struct commit *item, int quiet_on_missing);
>   static inline int parse_commit(struct commit *item)
>   {
> diff --git a/object.c b/object.c
> index e6ad3f61f0..efe4871325 100644
> --- a/object.c
> +++ b/object.c
> @@ -207,7 +207,7 @@ struct object *parse_object_buffer(const struct object_id *oid, enum object_type
>   	} else if (type == OBJ_COMMIT) {
>   		struct commit *commit = lookup_commit(oid);
>   		if (commit) {
> -			if (parse_commit_buffer(commit, buffer, size))
> +			if (parse_commit_buffer(commit, buffer, size, 1))
>   				return NULL;
>   			if (!get_cached_commit_buffer(commit, NULL)) {
>   				set_commit_buffer(commit, buffer, size);
> diff --git a/sha1_file.c b/sha1_file.c
> index 1b94f39c4c..0fd4f0b8b6 100644
> --- a/sha1_file.c
> +++ b/sha1_file.c
> @@ -1755,7 +1755,7 @@ static void check_commit(const void *buf, size_t size)
>   {
>   	struct commit c;
>   	memset(&c, 0, sizeof(c));
> -	if (parse_commit_buffer(&c, buf, size))
> +	if (parse_commit_buffer(&c, buf, size, 0))
>   		die("corrupt commit");
>   }
>   

