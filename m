Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.2 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	FROM_EXCESS_BASE64,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id E92F7211B3
	for <e@80x24.org>; Wed,  5 Dec 2018 22:48:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727679AbeLEWsa (ORCPT <rfc822;e@80x24.org>);
        Wed, 5 Dec 2018 17:48:30 -0500
Received: from mail-ed1-f67.google.com ([209.85.208.67]:40479 "EHLO
        mail-ed1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727358AbeLEWsa (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 5 Dec 2018 17:48:30 -0500
Received: by mail-ed1-f67.google.com with SMTP id d3so18437382edx.7
        for <git@vger.kernel.org>; Wed, 05 Dec 2018 14:48:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:references:user-agent:in-reply-to:date
         :message-id:mime-version;
        bh=kp2ETS5yO0e78JxegcXj5eQVMyof9DxJEhnDr2ryXv8=;
        b=JYyVwut/f1Z/0Qy6djDmSo3eCPMoenHqWXc7UGjDkOxQgtYv5lF++g29jjn6zPgNj9
         fX/oAqP6WddHBCxBY4cPkhRML31KQYhRNhjwyn2iaDwrhg+pa6WvBKz1DW1ptBEv33fa
         LCGQtdA1wMcKZQ3pYzqSYUye/jMUU/Xzza9qUW0UA4II7WrZe7I+NsOVbxSxzUHSaDVY
         Z9JgOdDfdHMYFNLE/Z9nj48+G3WYoUCNNkQQNGG4G6sIm6UV9GkDwdMv8irXEKAkcV2F
         uWo8ZZ/3lIC9UZtx7H9ew7j4eLRYlZ5lJCJkU9p/wj87wK1EPR0Ki6ErEpZDW/hRXlqD
         +vGQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:references:user-agent
         :in-reply-to:date:message-id:mime-version;
        bh=kp2ETS5yO0e78JxegcXj5eQVMyof9DxJEhnDr2ryXv8=;
        b=R9nSZF8wxKvP7b9ItFVpHIgfc3w6Fcdb5b9liS36YsiKKcXMId11nx5WCBjk8dMNMU
         SXivzn151BHfXBkz0ouEDc+whVoPhscCAcXRt5RutWHZZBXVrmFT3rXtuzIY8YzWBSR5
         fufr8Eg3ME2sifnoFkTRHh8+LZrig6HxF5S74YL3G2yhebOpK0ycxBWTRzuTd9zSFU0v
         vgWTs4TBYnI2u3NsBCzH6FI9Z+B6+PfYro5k1EOQBytZaXNTcwAXr9db4tPYGmCHsvDr
         A/rFcwqZldAzRWG8zOdO7t1pj545svhtthGJ0AffowNkPAhzExEOtR1xvCuM5/FGB8/3
         PrUg==
X-Gm-Message-State: AA+aEWYQf7ZvL3T2L4mTDGgy1frvGJLDcoFtG2AkxOGPKR/4MUO19CHJ
        OHE94YGxzflsew8YuxhuAN0=
X-Google-Smtp-Source: AFSGD/We7Fx9SXqChnKKgg8uEYz2m4FlPfzOaGEw4qqzjvFMdxmOgHiqnCGa9dgR6sZGa2yMewiWUA==
X-Received: by 2002:a17:906:3ce9:: with SMTP id d9-v6mr20253575ejh.236.1544050108020;
        Wed, 05 Dec 2018 14:48:28 -0800 (PST)
Received: from evledraar (ip545586d2.adsl-surfen.hetnet.nl. [84.85.134.210])
        by smtp.gmail.com with ESMTPSA id c11-v6sm3277797ejz.70.2018.12.05.14.48.27
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 05 Dec 2018 14:48:27 -0800 (PST)
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     Josh Steadmon <steadmon@google.com>
Cc:     git@vger.kernel.org, stolee@gmail.com
Subject: Re: [PATCH 1/2] commit-graph, fuzz: Add fuzzer for commit-graph
References: <cover.1544048946.git.steadmon@google.com> <53e62baaa8769bf8e90991e32e0d123cc6629559.1544048946.git.steadmon@google.com>
User-agent: Debian GNU/Linux buster/sid; Emacs 25.2.2; mu4e 1.1.0
In-reply-to: <53e62baaa8769bf8e90991e32e0d123cc6629559.1544048946.git.steadmon@google.com>
Date:   Wed, 05 Dec 2018 23:48:26 +0100
Message-ID: <874lbrzj2d.fsf@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Wed, Dec 05 2018, Josh Steadmon wrote:

> Breaks load_commit_graph_one() into a new function,
> parse_commit_graph(). The latter function operates on arbitrary buffers,
> which makes it suitable as a fuzzing target.
>
> Adds fuzz-commit-graph.c, which provides a fuzzing entry point
> compatible with libFuzzer (and possibly other fuzzing engines).
>
> Signed-off-by: Josh Steadmon <steadmon@google.com>
> ---
>  .gitignore          |  1 +
>  Makefile            |  1 +
>  commit-graph.c      | 63 +++++++++++++++++++++++++++++++++------------
>  fuzz-commit-graph.c | 18 +++++++++++++
>  4 files changed, 66 insertions(+), 17 deletions(-)
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
> index 40c855f185..0755359b1a 100644
> --- a/commit-graph.c
> +++ b/commit-graph.c
> @@ -46,6 +46,10 @@
>  #define GRAPH_MIN_SIZE (GRAPH_HEADER_SIZE + 4 * GRAPH_CHUNKLOOKUP_WIDTH \
>  			+ GRAPH_FANOUT_SIZE + GRAPH_OID_LEN)
>
> +struct commit_graph *parse_commit_graph(void *graph_map, int fd,
> +					size_t graph_size);
> +
> +
>  char *get_commit_graph_filename(const char *obj_dir)
>  {
>  	return xstrfmt("%s/info/commit-graph", obj_dir);
> @@ -84,16 +88,10 @@ static int commit_graph_compatible(struct repository *r)
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
> @@ -108,27 +106,61 @@ struct commit_graph *load_commit_graph_one(const char *graph_file)
>  		die(_("graph file %s is too small"), graph_file);
>  	}
>  	graph_map = xmmap(NULL, graph_size, PROT_READ, MAP_PRIVATE, fd, 0);
> +	ret = parse_commit_graph(graph_map, fd, graph_size);
> +
> +	if (ret == NULL) {

Code in git usually uses just !ret.

> +		munmap(graph_map, graph_size);
> +		close(fd);
> +		exit(1);

Ouch, exit(1) from load_commit_graph_one()? Can't we return NULL here
instead? Nasty to exit from a library routine, but then I see later...

> @@ -201,11 +235,6 @@ struct commit_graph *load_commit_graph_one(const char *graph_file)
>  	}
>
>  	return graph;
> -
> -cleanup_fail:
> -	munmap(graph_map, graph_size);
> -	close(fd);
> -	exit(1);
>  }

... ah, I see this is where you got the exit(1) from. So it was there
already.

>  static void prepare_commit_graph_one(struct repository *r, const char *obj_dir)
> diff --git a/fuzz-commit-graph.c b/fuzz-commit-graph.c
> new file mode 100644
> index 0000000000..420851d0d2
> --- /dev/null
> +++ b/fuzz-commit-graph.c
> @@ -0,0 +1,18 @@
> +#include "object-store.h"
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
> +	g = parse_commit_graph((void *) data, -1, size);
> +	if (g)
> +		free(g);
> +
> +	return 0;
> +}

I hadn't looked at this before, but see your 5e47215080 ("fuzz: add
basic fuzz testing target.", 2018-10-12) for some prior art.

There's instructions there for a very long "make" invocation. Would be
nice if this were friendlier and we could just do "make test-fuzz" or
something...
