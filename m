Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 987EA1F404
	for <e@80x24.org>; Thu, 19 Apr 2018 00:02:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752826AbeDSACk (ORCPT <rfc822;e@80x24.org>);
        Wed, 18 Apr 2018 20:02:40 -0400
Received: from mail-wr0-f195.google.com ([209.85.128.195]:41817 "EHLO
        mail-wr0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752245AbeDSACj (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 18 Apr 2018 20:02:39 -0400
Received: by mail-wr0-f195.google.com with SMTP id v24-v6so9187057wra.8
        for <git@vger.kernel.org>; Wed, 18 Apr 2018 17:02:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version;
        bh=wDRkqXQrQrKD2DIuFOr1txw2DYty9lVVLQWeBJSE6IY=;
        b=dSTF1et36SeGFAFPgNFVyyl2hQsp+6xvNsmRnfTSSeVyG8GcUn6Tpz+bJYtIdcrBHy
         UhEAiKyrgRQ5CMkjNqXHQO6z2qaw/HMi5G9F6gK/bk/Srw7KvS1wx/MGmesEmtClLr4m
         V2k24hDow3h4FF+gjUQnEChnMWK1h40SGu9nUWXR25O5d6/XFrn4Qcq69auW2JtrVG0w
         mvIoNvldg0tZ8U8jsJYLF/uwKY8gd8PzrK0G2oJixVfEuGMmzkSeeGjKF0r+clqnxbv0
         TccaRr0bJOQ57bBJT1f2/Xa52zBAv2nX5K/3Czdlvu50hUZN8SLrs+WLXdWjijGPKob8
         EwIA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:references:date:in-reply-to
         :message-id:user-agent:mime-version;
        bh=wDRkqXQrQrKD2DIuFOr1txw2DYty9lVVLQWeBJSE6IY=;
        b=pUqeNuehAduxwyr7e/Uk/vrHs3yQald8JZw6xq84pzqhKwl9oSIT8Q6AyUBFNSlUaL
         MfIzxn2v47M4flM2wWyBSnO6XeGIlGXx/GnbR5wJfmWQprnvV6bI34wQaBPwxmdIXJdF
         AI8k9GFA7hHpFhr7e2dbrFkmX+9Ivz+CoalNh974Ip8HTK0amiKvvPjozNrweSyVfwj7
         QD7EWLffdAxAx84KWRzt8KPGE2pWGwSy7LrtNXfzilqHuWY0eoCY4cnbFq+4KFknPjUA
         AheLPiiYXBDZm3Xn1zcVuEt8V8jCUE2xW5h16wU+gMx7pEAyWLXxUtdMElHQUTgVs+lm
         n/iA==
X-Gm-Message-State: ALQs6tDGtlrsEW0JNPbjk+7Vi3hLpfAEs9KQ1geANhHy/YHviBlG8EHF
        jTrBTM+Ky+9bt84uN4EPL8w=
X-Google-Smtp-Source: AIpwx48VWx3/1hZ9GCmr8EGdP59ez64MIqSctiEBeMD7nbdAABvpJ+tNgIdNnOFK574p10ODInNN6A==
X-Received: by 10.28.22.143 with SMTP id 137mr3040384wmw.58.1524096157883;
        Wed, 18 Apr 2018 17:02:37 -0700 (PDT)
Received: from Laptop-Acer-Aspire-F15 (egc153.neoplus.adsl.tpnet.pl. [83.21.66.153])
        by smtp.gmail.com with ESMTPSA id y100sm26062420wmh.2.2018.04.18.17.02.35
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 18 Apr 2018 17:02:36 -0700 (PDT)
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
Subject: Re: [PATCH v3 8/9] commit-graph: always load commit-graph information
References: <20180409164131.37312-1-dstolee@microsoft.com>
        <20180417170001.138464-1-dstolee@microsoft.com>
        <20180417170001.138464-9-dstolee@microsoft.com>
Date:   Thu, 19 Apr 2018 02:02:35 +0200
In-Reply-To: <20180417170001.138464-9-dstolee@microsoft.com> (Derrick Stolee's
        message of "Tue, 17 Apr 2018 17:00:35 +0000")
Message-ID: <8636zsgj1g.fsf@gmail.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.2 (windows-nt)
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Derrick Stolee <dstolee@microsoft.com> writes:

> Most code paths load commits using lookup_commit() and then
> parse_commit(). In some cases, including some branch lookups, the commit
> is parsed using parse_object_buffer() which side-steps parse_commit() in
> favor of parse_commit_buffer().
>
> With generation numbers in the commit-graph, we need to ensure that any
> commit that exists in the commit-graph file has its generation number
> loaded.

All right, that is nice explanation of the why behind this change.

>
> Create new load_commit_graph_info() method to fill in the information
> for a commit that exists only in the commit-graph file. Call it from
> parse_commit_buffer() after loading the other commit information from
> the given buffer. Only fill this information when specified by the
> 'check_graph' parameter. This avoids duplicate work when we already
> checked the graph in parse_commit_gently() or when simply checking the
> buffer contents in check_commit().

Couldn't this 'check_graph' parameter be a global variable similar to
the 'commit_graph' variable?  Maybe I am not understanding it.

>
> Signed-off-by: Derrick Stolee <dstolee@microsoft.com>
> ---
>  commit-graph.c | 51 ++++++++++++++++++++++++++++++++------------------
>  commit-graph.h |  8 ++++++++
>  commit.c       |  7 +++++--
>  commit.h       |  2 +-
>  object.c       |  2 +-
>  sha1_file.c    |  2 +-
>  6 files changed, 49 insertions(+), 23 deletions(-)
>
> diff --git a/commit-graph.c b/commit-graph.c
> index 688d5b1801..21e853c21a 100644
> --- a/commit-graph.c
> +++ b/commit-graph.c
> @@ -245,13 +245,19 @@ static struct commit_list **insert_parent_or_die(struct commit_graph *g,
>  	return &commit_list_insert(c, pptr)->next;
>  }
>  
> +static void fill_commit_graph_info(struct commit *item, struct commit_graph *g, uint32_t pos)
> +{
> +	const unsigned char *commit_data = g->chunk_commit_data + GRAPH_DATA_WIDTH * pos;
> +	item->generation = get_be32(commit_data + g->hash_len + 8) >> 2;
> +}
> +
>  static int fill_commit_in_graph(struct commit *item, struct commit_graph *g, uint32_t pos)
>  {
>  	uint32_t edge_value;
>  	uint32_t *parent_data_ptr;
>  	uint64_t date_low, date_high;
>  	struct commit_list **pptr;
> -	const unsigned char *commit_data = g->chunk_commit_data + (g->hash_len + 16) * pos;
> +	const unsigned char *commit_data = g->chunk_commit_data + GRAPH_DATA_WIDTH * pos;

I'm probably wrong, but isn't it unrelated change?

>  
>  	item->object.parsed = 1;
>  	item->graph_pos = pos;
> @@ -292,31 +298,40 @@ static int fill_commit_in_graph(struct commit *item, struct commit_graph *g, uin
>  	return 1;
>  }
>  
> +static int find_commit_in_graph(struct commit *item, struct commit_graph *g, uint32_t *pos)
> +{
> +	if (item->graph_pos != COMMIT_NOT_FROM_GRAPH) {
> +		*pos = item->graph_pos;
> +		return 1;
> +	} else {
> +		return bsearch_graph(commit_graph, &(item->object.oid), pos);
> +	}
> +}

All right (after the fix).

> +
>  int parse_commit_in_graph(struct commit *item)
>  {
> +	uint32_t pos;
> +
> +	if (item->object.parsed)
> +		return 0;
>  	if (!core_commit_graph)
>  		return 0;
> -	if (item->object.parsed)
> -		return 1;

Hmmm... previously the function returned 1 if item->object.parsed, now
it returns 0 for this situation.  I don't understand this change.

> -
>  	prepare_commit_graph();
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

Nice refactoring.

>  	return 0;
>  }
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

And the reason for the refactoring.

> +
>  static struct tree *load_tree_for_commit(struct commit_graph *g, struct commit *c)
>  {
>  	struct object_id oid;
> diff --git a/commit-graph.h b/commit-graph.h
> index 260a468e73..96cccb10f3 100644
> --- a/commit-graph.h
> +++ b/commit-graph.h
> @@ -17,6 +17,14 @@ char *get_commit_graph_filename(const char *obj_dir);
>   */
>  int parse_commit_in_graph(struct commit *item);
>  
> +/*
> + * It is possible that we loaded commit contents from the commit buffer,
> + * but we also want to ensure the commit-graph content is correctly
> + * checked and filled. Fill the graph_pos and generation members of
> + * the given commit.
> + */
> +void load_commit_graph_info(struct commit *item);
> +
>  struct tree *get_commit_tree_in_graph(const struct commit *c);
>  
>  struct commit_graph {
> diff --git a/commit.c b/commit.c
> index a70f120878..9ef6f699bd 100644
> --- a/commit.c
> +++ b/commit.c
> @@ -331,7 +331,7 @@ const void *detach_commit_buffer(struct commit *commit, unsigned long *sizep)
>  	return ret;
>  }
>  
> -int parse_commit_buffer(struct commit *item, const void *buffer, unsigned long size)
> +int parse_commit_buffer(struct commit *item, const void *buffer, unsigned long size, int check_graph)
>  {
>  	const char *tail = buffer;
>  	const char *bufptr = buffer;
> @@ -386,6 +386,9 @@ int parse_commit_buffer(struct commit *item, const void *buffer, unsigned long s
>  	}
>  	item->date = parse_commit_date(bufptr, tail);
>  
> +	if (check_graph)
> +		load_commit_graph_info(item);
> +
>  	return 0;
>  }
>  
> @@ -412,7 +415,7 @@ int parse_commit_gently(struct commit *item, int quiet_on_missing)
>  		return error("Object %s not a commit",
>  			     oid_to_hex(&item->object.oid));
>  	}
> -	ret = parse_commit_buffer(item, buffer, size);
> +	ret = parse_commit_buffer(item, buffer, size, 0);
>  	if (save_commit_buffer && !ret) {
>  		set_commit_buffer(item, buffer, size);
>  		return 0;
> diff --git a/commit.h b/commit.h
> index 64436ff44e..b5afde1ae9 100644
> --- a/commit.h
> +++ b/commit.h
> @@ -72,7 +72,7 @@ struct commit *lookup_commit_reference_by_name(const char *name);
>   */
>  struct commit *lookup_commit_or_die(const struct object_id *oid, const char *ref_name);
>  
> -int parse_commit_buffer(struct commit *item, const void *buffer, unsigned long size);
> +int parse_commit_buffer(struct commit *item, const void *buffer, unsigned long size, int check_graph);
>  int parse_commit_gently(struct commit *item, int quiet_on_missing);
>  static inline int parse_commit(struct commit *item)
>  {
> diff --git a/object.c b/object.c
> index e6ad3f61f0..efe4871325 100644
> --- a/object.c
> +++ b/object.c
> @@ -207,7 +207,7 @@ struct object *parse_object_buffer(const struct object_id *oid, enum object_type
>  	} else if (type == OBJ_COMMIT) {
>  		struct commit *commit = lookup_commit(oid);
>  		if (commit) {
> -			if (parse_commit_buffer(commit, buffer, size))
> +			if (parse_commit_buffer(commit, buffer, size, 1))
>  				return NULL;
>  			if (!get_cached_commit_buffer(commit, NULL)) {
>  				set_commit_buffer(commit, buffer, size);
> diff --git a/sha1_file.c b/sha1_file.c
> index 1b94f39c4c..0fd4f0b8b6 100644
> --- a/sha1_file.c
> +++ b/sha1_file.c
> @@ -1755,7 +1755,7 @@ static void check_commit(const void *buf, size_t size)
>  {
>  	struct commit c;
>  	memset(&c, 0, sizeof(c));
> -	if (parse_commit_buffer(&c, buf, size))
> +	if (parse_commit_buffer(&c, buf, size, 0))
>  		die("corrupt commit");
>  }
