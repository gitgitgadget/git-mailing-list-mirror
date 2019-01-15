Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 583221F62E
	for <e@80x24.org>; Tue, 15 Jan 2019 20:34:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389865AbfAOUeD (ORCPT <rfc822;e@80x24.org>);
        Tue, 15 Jan 2019 15:34:03 -0500
Received: from mail-wr1-f65.google.com ([209.85.221.65]:33746 "EHLO
        mail-wr1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728816AbfAOUeC (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 15 Jan 2019 15:34:02 -0500
Received: by mail-wr1-f65.google.com with SMTP id c14so4555151wrr.0
        for <git@vger.kernel.org>; Tue, 15 Jan 2019 12:34:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version;
        bh=HynkJLiLCYbn5XrdWWkRyP2leBiAYo89o6Fh0jQuJKk=;
        b=D1fvb8g1uyaKkjtvIKJhcQq2cYFmVAJ+xIKRNRfLzT8dYMAzxXMUKGJC2ZdXxjVSLj
         +o0LRE1TWZSqTDjNN3mvScoeXFJKnFZ9vo+Ecy9Dm5duUczwlHxMVVBozR3lLyHCt4Vd
         V/n5WU9XCbbmvgqVjp7VE/ffhjlNaz+2BD5Y3HdvTckmbrWWzyFdHD/BAiEbZNOXXr/l
         /wSXbfHTZYlpJIHqoCbf6/zUt68xBvJ3SXU5cVbpa3+NbC+VPhbhtup/oVC5VXoUh/pr
         aFO5g+irKuIwzmVqcfgQHN3yvSx7vJTs9UtckhZtv+lyAOy0gs4Ers+ACDNmoNgpDiSR
         M8CQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version;
        bh=HynkJLiLCYbn5XrdWWkRyP2leBiAYo89o6Fh0jQuJKk=;
        b=KPO2mIEW/iEH+6ItTYr5nd6P8CQjMFC+ksmrkk+glzrgTDMyP5bZFEIw896lj5K/04
         1EgF9cMeOhwTwQuteDzn+aIrml1q5D4dJ72Bg7nW0swjwy0OStu83PAqV7gtOwgRSSwD
         2MlVSZpf6l6JPW8Ta8KM3WvF+lOZ11dTM9GlmeQLYoCXYEc8b9bYWoXU6RQvVGajv3UD
         9in5S6qABzZTAO756PeKUG2UdnhXK07GHhJBRgnDMQzRzW8KgqEdQ0pku8xL7XaosK3l
         40voY4vM/HU0SJGP04SA6Ljm+uKI9/btcaQRJOYwqI4HGSRcO+P0NETDZoeZQTyPAYi2
         6ZEg==
X-Gm-Message-State: AJcUukcIprvEa6eFMdRfNZSC3lqmG8diCA1U2JYP+Ebnnh8uyo/XuWE1
        OVmCKRTnXpIqywfoaXElUQA=
X-Google-Smtp-Source: ALg8bN5EFNA1++PYTd3l49qHs+we+iMKb2JPnMP54mFduSWAXsSskIpo9547C5IIJCjAPN2AtHhlow==
X-Received: by 2002:adf:8421:: with SMTP id 30mr4736943wrf.153.1547584439560;
        Tue, 15 Jan 2019 12:33:59 -0800 (PST)
Received: from localhost (112.68.155.104.bc.googleusercontent.com. [104.155.68.112])
        by smtp.gmail.com with ESMTPSA id n20sm20851725wmi.11.2019.01.15.12.33.58
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 15 Jan 2019 12:33:58 -0800 (PST)
From:   Junio C Hamano <gitster@pobox.com>
To:     Josh Steadmon <steadmon@google.com>
Cc:     git@vger.kernel.org, stolee@gmail.com, avarab@gmail.com,
        peff@peff.net, szeder.dev@gmail.com
Subject: Re: [PATCH v5 1/3] commit-graph, fuzz: Add fuzzer for commit-graph
References: <cover.1544048946.git.steadmon@google.com>
        <cover.1547582104.git.steadmon@google.com>
        <0b57ecbe1b6c72d95311ba1bb30ea1ed9fd7e3e5.1547582104.git.steadmon@google.com>
Date:   Tue, 15 Jan 2019 12:33:58 -0800
In-Reply-To: <0b57ecbe1b6c72d95311ba1bb30ea1ed9fd7e3e5.1547582104.git.steadmon@google.com>
        (Josh Steadmon's message of "Tue, 15 Jan 2019 11:59:53 -0800")
Message-ID: <xmqqmuo1r77t.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Josh Steadmon <steadmon@google.com> writes:

> Breaks load_commit_graph_one() into a new function,

s/Breaks/Break/

> parse_commit_graph(). The latter function operates on arbitrary buffers,
> which makes it suitable as a fuzzing target. Since parse_commit_graph()
> is only called by load_commit_graph_one() (and the fuzzer described
> below), we omit error messages that would be duplicated by the caller.
>
> Adds fuzz-commit-graph.c, which provides a fuzzing entry point
> compatible with libFuzzer (and possibly other fuzzing engines).
>
> Signed-off-by: Josh Steadmon <steadmon@google.com>
> ---
>  .gitignore          |  1 +
>  Makefile            |  1 +
>  commit-graph.c      | 53 ++++++++++++++++++++++++++++++---------------
>  commit-graph.h      |  3 +++
>  fuzz-commit-graph.c | 16 ++++++++++++++
>  5 files changed, 57 insertions(+), 17 deletions(-)
>  create mode 100644 fuzz-commit-graph.c
>
> diff --git a/.gitignore b/.gitignore
> index 0d77ea5894..8bcf153ed9 100644
> --- a/.gitignore
> +++ b/.gitignore
> @@ -1,3 +1,4 @@
> +/fuzz-commit-graph
>  /fuzz_corpora
>  /fuzz-pack-headers
>  /fuzz-pack-idx
> diff --git a/Makefile b/Makefile
> index 1a44c811aa..6b72f37c29 100644
> --- a/Makefile
> +++ b/Makefile
> @@ -684,6 +684,7 @@ SCRIPTS = $(SCRIPT_SH_INS) \
>  
>  ETAGS_TARGET = TAGS
>  
> +FUZZ_OBJS += fuzz-commit-graph.o
>  FUZZ_OBJS += fuzz-pack-headers.o
>  FUZZ_OBJS += fuzz-pack-idx.o
>  
> diff --git a/commit-graph.c b/commit-graph.c
> index 40c855f185..07dd410f3c 100644
> --- a/commit-graph.c
> +++ b/commit-graph.c
> @@ -84,16 +84,10 @@ static int commit_graph_compatible(struct repository *r)
>  struct commit_graph *load_commit_graph_one(const char *graph_file)
>  {
>  	void *graph_map;
> -	const unsigned char *data, *chunk_lookup;
>  	size_t graph_size;
>  	struct stat st;
> -	uint32_t i;
> -	struct commit_graph *graph;
> +	struct commit_graph *ret;
>  	int fd = git_open(graph_file);
> -	uint64_t last_chunk_offset;
> -	uint32_t last_chunk_id;
> -	uint32_t graph_signature;
> -	unsigned char graph_version, hash_version;
>  
>  	if (fd < 0)
>  		return NULL;
> @@ -108,27 +102,55 @@ struct commit_graph *load_commit_graph_one(const char *graph_file)
>  		die(_("graph file %s is too small"), graph_file);
>  	}
>  	graph_map = xmmap(NULL, graph_size, PROT_READ, MAP_PRIVATE, fd, 0);
> +	ret = parse_commit_graph(graph_map, fd, graph_size);
> +
> +	if (!ret) {
> +		munmap(graph_map, graph_size);
> +		close(fd);
> +		exit(1);
> +	}
> +
> +	return ret;
> +}

Looks like a reasonable splitting of a helper function with a clean
interface.  I like it.

Thanks.


> +struct commit_graph *parse_commit_graph(void *graph_map, int fd,
> +					size_t graph_size)
> +{
> +	const unsigned char *data, *chunk_lookup;
> +	uint32_t i;
> +	struct commit_graph *graph;
> +	uint64_t last_chunk_offset;
> +	uint32_t last_chunk_id;
> +	uint32_t graph_signature;
> +	unsigned char graph_version, hash_version;
> +
> +	if (!graph_map)
> +		return NULL;
> +
> +	if (graph_size < GRAPH_MIN_SIZE)
> +		return NULL;
> +
>  	data = (const unsigned char *)graph_map;
>  
>  	graph_signature = get_be32(data);
>  	if (graph_signature != GRAPH_SIGNATURE) {
>  		error(_("graph signature %X does not match signature %X"),
>  		      graph_signature, GRAPH_SIGNATURE);
> -		goto cleanup_fail;
> +		return NULL;
>  	}
>  
>  	graph_version = *(unsigned char*)(data + 4);
>  	if (graph_version != GRAPH_VERSION) {
>  		error(_("graph version %X does not match version %X"),
>  		      graph_version, GRAPH_VERSION);
> -		goto cleanup_fail;
> +		return NULL;
>  	}
>  
>  	hash_version = *(unsigned char*)(data + 5);
>  	if (hash_version != GRAPH_OID_VERSION) {
>  		error(_("hash version %X does not match version %X"),
>  		      hash_version, GRAPH_OID_VERSION);
> -		goto cleanup_fail;
> +		return NULL;
>  	}
>  
>  	graph = alloc_commit_graph();
> @@ -152,7 +174,8 @@ struct commit_graph *load_commit_graph_one(const char *graph_file)
>  		if (chunk_offset > graph_size - GIT_MAX_RAWSZ) {
>  			error(_("improper chunk offset %08x%08x"), (uint32_t)(chunk_offset >> 32),
>  			      (uint32_t)chunk_offset);
> -			goto cleanup_fail;
> +			free(graph);
> +			return NULL;
>  		}
>  
>  		switch (chunk_id) {
> @@ -187,7 +210,8 @@ struct commit_graph *load_commit_graph_one(const char *graph_file)
>  
>  		if (chunk_repeated) {
>  			error(_("chunk id %08x appears multiple times"), chunk_id);
> -			goto cleanup_fail;
> +			free(graph);
> +			return NULL;
>  		}
>  
>  		if (last_chunk_id == GRAPH_CHUNKID_OIDLOOKUP)
> @@ -201,11 +225,6 @@ struct commit_graph *load_commit_graph_one(const char *graph_file)
>  	}
>  
>  	return graph;
> -
> -cleanup_fail:
> -	munmap(graph_map, graph_size);
> -	close(fd);
> -	exit(1);
>  }
>  
>  static void prepare_commit_graph_one(struct repository *r, const char *obj_dir)
> diff --git a/commit-graph.h b/commit-graph.h
> index 9db40b4d3a..813e7c19f1 100644
> --- a/commit-graph.h
> +++ b/commit-graph.h
> @@ -54,6 +54,9 @@ struct commit_graph {
>  
>  struct commit_graph *load_commit_graph_one(const char *graph_file);
>  
> +struct commit_graph *parse_commit_graph(void *graph_map, int fd,
> +					size_t graph_size);
> +
>  /*
>   * Return 1 if and only if the repository has a commit-graph
>   * file and generation numbers are computed in that file.
> diff --git a/fuzz-commit-graph.c b/fuzz-commit-graph.c
> new file mode 100644
> index 0000000000..cf790c9d04
> --- /dev/null
> +++ b/fuzz-commit-graph.c
> @@ -0,0 +1,16 @@
> +#include "commit-graph.h"
> +
> +struct commit_graph *parse_commit_graph(void *graph_map, int fd,
> +					size_t graph_size);
> +
> +int LLVMFuzzerTestOneInput(const uint8_t *data, size_t size);
> +
> +int LLVMFuzzerTestOneInput(const uint8_t *data, size_t size)
> +{
> +	struct commit_graph *g;
> +
> +	g = parse_commit_graph((void *)data, -1, size);
> +	free(g);
> +
> +	return 0;
> +}
