Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 5990F1F85A
	for <e@80x24.org>; Tue, 10 Jul 2018 00:48:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933428AbeGJAs3 (ORCPT <rfc822;e@80x24.org>);
        Mon, 9 Jul 2018 20:48:29 -0400
Received: from mail-qt0-f196.google.com ([209.85.216.196]:33227 "EHLO
        mail-qt0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S933270AbeGJAs0 (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 9 Jul 2018 20:48:26 -0400
Received: by mail-qt0-f196.google.com with SMTP id l10-v6so17014595qtj.0
        for <git@vger.kernel.org>; Mon, 09 Jul 2018 17:48:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:references:from:message-id:date:user-agent:mime-version
         :in-reply-to:content-transfer-encoding:content-language;
        bh=ZiPITmfo9Paut/2znf+y6HunNDNOsqI+0fIMRzUWuS8=;
        b=l6Rx7ana4+rJqQxjS87Gi8PevdvMf+KmXdqeEETeDBgHPUYmYudlLcbEwjjIPvlZsf
         R5NRKhrLx+I9ZgsPWRUmozuz370Rj64SzQmngWokaGwBmVnXQgiDsNEExQm+7A7F66wm
         Bg035cXuL3fh3NgtuEUD3WfNhdGtbTaC3G9Q2tw5Zd7O9ZUC7vHxxokf34Zsp+/WgGvu
         dB09DzIXLKxmb49TMRJVEMVbuFg31cJxxqWf59CzQ7KD1X5J4u63d/5WC1HRwTfnAJ86
         YN6rv7FpZtngL4qQw197Dte0px4+aZUR+dkbWjV/9PkBgSOdunQW3JQxcHXzjKoecOso
         u3zw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding
         :content-language;
        bh=ZiPITmfo9Paut/2znf+y6HunNDNOsqI+0fIMRzUWuS8=;
        b=nNAuidiFGL9C8huFZ34BiJqTmTnvuWAq+gev0EYb9kzeSRH7hGHjExwgPtAEDL4UtE
         vYtNTuC6i7Kz4BEOJ8UrSbO95H/2QyWrdX+7a4X7+YEGrII5q11N4mbYIgkVE5tdxZ0x
         3XU2cspONGqvHwyCMkGd36+bV4nxIRD63p14XBa5/hf0RhLpvgq20o2JK22tuMQjJu9A
         /GqdG/zw0Ckdj3/GYww2/PNGFK4LbeGV4AmxCZEZyj/LnkJXX0vKzjlM+2Zrdb457JpU
         cPN4eSTmv11PekjaEyZHQSLtqvMB8wcxuqCk3F0lw978yqzrJ3F/2HsJWqCe6yb/5PBC
         VMUw==
X-Gm-Message-State: APt69E2XXih9lCl2xDTE8Thu7hWCG9I9P8S6rc+uiX9SqRigXHb7PxWf
        NU/JPeeOVYCLNqFVhvujtFPVouNR
X-Google-Smtp-Source: AAOMgpdFFbcdaDbmyGhNNuEzbJMnlOx6NhavtQaSKnRChdtF1uDJ4ryWrWTUrw2ka1T4Tb9y+S09Yg==
X-Received: by 2002:ac8:2825:: with SMTP id 34-v6mr21670868qtq.377.1531183704943;
        Mon, 09 Jul 2018 17:48:24 -0700 (PDT)
Received: from [10.0.1.23] ([98.122.163.216])
        by smtp.gmail.com with ESMTPSA id r27-v6sm18723564qkr.17.2018.07.09.17.48.24
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 09 Jul 2018 17:48:24 -0700 (PDT)
Subject: Re: [PATCH v2 6/6] commit-graph: add repo arg to graph readers
To:     Jonathan Tan <jonathantanmy@google.com>, git@vger.kernel.org
References: <cover.1529616356.git.jonathantanmy@google.com>
 <cover.1531168854.git.jonathantanmy@google.com>
 <f1ccfdccc851039cf62978d162cd9de99ea619de.1531168854.git.jonathantanmy@google.com>
From:   Derrick Stolee <stolee@gmail.com>
Message-ID: <75ef9935-342a-bbda-4ce6-e5a033f273a9@gmail.com>
Date:   Mon, 9 Jul 2018 20:48:22 -0400
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.0
MIME-Version: 1.0
In-Reply-To: <f1ccfdccc851039cf62978d162cd9de99ea619de.1531168854.git.jonathantanmy@google.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 7/9/2018 4:44 PM, Jonathan Tan wrote:
> Add a struct repository argument to the functions in commit-graph.h that
> read the commit graph. (This commit does not affect functions that write
> commit graphs.)
>
> Because the commit graph functions can now read the commit graph of any
> repository, the global variable core_commit_graph has been removed.
> Instead, the config option core.commitGraph is now read on the first
> time in a repository that a commit is attempted to be parsed using its
> commit graph.
>
> This commit includes a test that exercises the functionality on an
> arbitrary repository that is not the_repository.
>
> Signed-off-by: Jonathan Tan <jonathantanmy@google.com>
> ---
>   Makefile                   |  1 +
>   builtin/fsck.c             |  2 +-
>   cache.h                    |  1 -
>   commit-graph.c             | 60 ++++++++++++++------------
>   commit-graph.h             |  7 +--
>   commit.c                   |  6 +--
>   config.c                   |  5 ---
>   environment.c              |  1 -
>   ref-filter.c               |  2 +-
>   t/helper/test-repository.c | 88 ++++++++++++++++++++++++++++++++++++++
>   t/helper/test-tool.c       |  1 +
>   t/helper/test-tool.h       |  1 +
>   t/t5318-commit-graph.sh    | 35 +++++++++++++++
>   13 files changed, 168 insertions(+), 42 deletions(-)
>   create mode 100644 t/helper/test-repository.c
>
> diff --git a/Makefile b/Makefile
> index 0cb6590f24..bb8bd67201 100644
> --- a/Makefile
> +++ b/Makefile
> @@ -719,6 +719,7 @@ TEST_BUILTINS_OBJS += test-prio-queue.o
>   TEST_BUILTINS_OBJS += test-read-cache.o
>   TEST_BUILTINS_OBJS += test-ref-store.o
>   TEST_BUILTINS_OBJS += test-regex.o
> +TEST_BUILTINS_OBJS += test-repository.o
>   TEST_BUILTINS_OBJS += test-revision-walking.o
>   TEST_BUILTINS_OBJS += test-run-command.o
>   TEST_BUILTINS_OBJS += test-scrap-cache-tree.o
> diff --git a/builtin/fsck.c b/builtin/fsck.c
> index eca7900ee0..2abfb2d782 100644
> --- a/builtin/fsck.c
> +++ b/builtin/fsck.c
> @@ -825,7 +825,7 @@ int cmd_fsck(int argc, const char **argv, const char *prefix)
>   
>   	check_connectivity();
>   
> -	if (core_commit_graph) {
> +	if (!git_config_get_bool("core.commitgraph", &i) && i) {
>   		struct child_process commit_graph_verify = CHILD_PROCESS_INIT;
>   		const char *verify_argv[] = { "commit-graph", "verify", NULL, NULL, NULL };
>   
> diff --git a/cache.h b/cache.h
> index d49092d94d..8dc59bedba 100644
> --- a/cache.h
> +++ b/cache.h
> @@ -813,7 +813,6 @@ extern char *git_replace_ref_base;
>   
>   extern int fsync_object_files;
>   extern int core_preload_index;
> -extern int core_commit_graph;
>   extern int core_apply_sparse_checkout;
>   extern int precomposed_unicode;
>   extern int protect_hfs;
> diff --git a/commit-graph.c b/commit-graph.c
> index af97a10603..8eab199b1b 100644
> --- a/commit-graph.c
> +++ b/commit-graph.c
> @@ -183,15 +183,15 @@ struct commit_graph *load_commit_graph_one(const char *graph_file)
>   	exit(1);
>   }
>   
> -static void prepare_commit_graph_one(const char *obj_dir)
> +static void prepare_commit_graph_one(struct repository *r, const char *obj_dir)
>   {
>   	char *graph_name;
>   
> -	if (the_repository->objects->commit_graph)
> +	if (r->objects->commit_graph)
>   		return;
>   
>   	graph_name = get_commit_graph_filename(obj_dir);
> -	the_repository->objects->commit_graph =
> +	r->objects->commit_graph =
>   		load_commit_graph_one(graph_name);
>   
>   	FREE_AND_NULL(graph_name);
> @@ -203,26 +203,34 @@ static void prepare_commit_graph_one(const char *obj_dir)
>    * On the first invocation, this function attemps to load the commit
>    * graph if the_repository is configured to have one.
>    */
> -static int prepare_commit_graph(void)
> +static int prepare_commit_graph(struct repository *r)
>   {
>   	struct alternate_object_database *alt;
>   	char *obj_dir;
> +	int config_value;
>   
> -	if (the_repository->objects->commit_graph_attempted)
> -		return !!the_repository->objects->commit_graph;
> -	the_repository->objects->commit_graph_attempted = 1;
> +	if (r->objects->commit_graph_attempted)
> +		return !!r->objects->commit_graph;
> +	r->objects->commit_graph_attempted = 1;
>   
> -	if (!core_commit_graph)
> +	if (repo_config_get_bool(r, "core.commitgraph", &config_value) ||
> +	    !config_value)
> +		/*
> +		 * This repository is not configured to use commit graphs, so
> +		 * do not load one. (But report commit_graph_attempted anyway
> +		 * so that commit graph loading is not attempted again for this
> +		 * repository.)
> +		 */

I reacted first to complain about this extra config lookup, but it is 
only run once per repository, so that should be fine.

>   		return 0;
>   
> -	obj_dir = get_object_directory();
> -	prepare_commit_graph_one(obj_dir);
> -	prepare_alt_odb(the_repository);
> -	for (alt = the_repository->objects->alt_odb_list;
> -	     !the_repository->objects->commit_graph && alt;
> +	obj_dir = r->objects->objectdir;
> +	prepare_commit_graph_one(r, obj_dir);
> +	prepare_alt_odb(r);
> +	for (alt = r->objects->alt_odb_list;
> +	     !r->objects->commit_graph && alt;
>   	     alt = alt->next)
> -		prepare_commit_graph_one(alt->path);
> -	return !!the_repository->objects->commit_graph;
> +		prepare_commit_graph_one(r, alt->path);
> +	return !!r->objects->commit_graph;
>   }
>   
>   static void close_commit_graph(void)
> @@ -323,8 +331,6 @@ static int parse_commit_in_graph_one(struct commit_graph *g, struct commit *item
>   {
>   	uint32_t pos;
>   
> -	if (!core_commit_graph)
> -		return 0;
>   	if (item->object.parsed)
>   		return 1;
>   
> @@ -334,20 +340,20 @@ static int parse_commit_in_graph_one(struct commit_graph *g, struct commit *item
>   	return 0;
>   }
>   
> -int parse_commit_in_graph(struct commit *item)
> +int parse_commit_in_graph(struct repository *r, struct commit *item)
>   {
> -	if (!prepare_commit_graph())
> +	if (!prepare_commit_graph(r))
>   		return 0;
> -	return parse_commit_in_graph_one(the_repository->objects->commit_graph, item);
> +	return parse_commit_in_graph_one(r->objects->commit_graph, item);
>   }
>   
> -void load_commit_graph_info(struct commit *item)
> +void load_commit_graph_info(struct repository *r, struct commit *item)
>   {
>   	uint32_t pos;
> -	if (!prepare_commit_graph())
> +	if (!prepare_commit_graph(r))
>   		return;
> -	if (find_commit_in_graph(item, the_repository->objects->commit_graph, &pos))
> -		fill_commit_graph_info(item, the_repository->objects->commit_graph, pos);
> +	if (find_commit_in_graph(item, r->objects->commit_graph, &pos))
> +		fill_commit_graph_info(item, r->objects->commit_graph, pos);
>   }
>   
>   static struct tree *load_tree_for_commit(struct commit_graph *g, struct commit *c)
> @@ -373,9 +379,9 @@ static struct tree *get_commit_tree_in_graph_one(struct commit_graph *g,
>   	return load_tree_for_commit(g, (struct commit *)c);
>   }
>   
> -struct tree *get_commit_tree_in_graph(const struct commit *c)
> +struct tree *get_commit_tree_in_graph(struct repository *r, const struct commit *c)
>   {
> -	return get_commit_tree_in_graph_one(the_repository->objects->commit_graph, c);
> +	return get_commit_tree_in_graph_one(r->objects->commit_graph, c);
>   }
>   
>   static void write_graph_chunk_fanout(struct hashfile *f,
> @@ -691,7 +697,7 @@ void write_commit_graph(const char *obj_dir,
>   	oids.alloc = approximate_object_count() / 4;
>   
>   	if (append) {
> -		prepare_commit_graph_one(obj_dir);
> +		prepare_commit_graph_one(the_repository, obj_dir);
>   		if (the_repository->objects->commit_graph)
>   			oids.alloc += the_repository->objects->commit_graph->num_commits;
>   	}
> diff --git a/commit-graph.h b/commit-graph.h
> index 94defb04a9..76e098934a 100644
> --- a/commit-graph.h
> +++ b/commit-graph.h
> @@ -19,7 +19,7 @@ char *get_commit_graph_filename(const char *obj_dir);
>    *
>    * See parse_commit_buffer() for the fallback after this call.
>    */
> -int parse_commit_in_graph(struct commit *item);
> +int parse_commit_in_graph(struct repository *r, struct commit *item);
>   
>   /*
>    * It is possible that we loaded commit contents from the commit buffer,
> @@ -27,9 +27,10 @@ int parse_commit_in_graph(struct commit *item);
>    * checked and filled. Fill the graph_pos and generation members of
>    * the given commit.
>    */
> -void load_commit_graph_info(struct commit *item);
> +void load_commit_graph_info(struct repository *r, struct commit *item);
>   
> -struct tree *get_commit_tree_in_graph(const struct commit *c);
> +struct tree *get_commit_tree_in_graph(struct repository *r,
> +				      const struct commit *c);
>   
>   struct commit_graph {
>   	int graph_fd;
> diff --git a/commit.c b/commit.c
> index 598cf21cee..b3bbfefc27 100644
> --- a/commit.c
> +++ b/commit.c
> @@ -319,7 +319,7 @@ struct tree *get_commit_tree(const struct commit *commit)
>   	if (commit->graph_pos == COMMIT_NOT_FROM_GRAPH)
>   		BUG("commit has NULL tree, but was not loaded from commit-graph");
>   
> -	return get_commit_tree_in_graph(commit);
> +	return get_commit_tree_in_graph(the_repository, commit);
>   }
>   
>   struct object_id *get_commit_tree_oid(const struct commit *commit)
> @@ -413,7 +413,7 @@ int parse_commit_buffer(struct commit *item, const void *buffer, unsigned long s
>   	item->date = parse_commit_date(bufptr, tail);
>   
>   	if (check_graph)
> -		load_commit_graph_info(item);
> +		load_commit_graph_info(the_repository, item);
>   
>   	return 0;
>   }
> @@ -429,7 +429,7 @@ int parse_commit_internal(struct commit *item, int quiet_on_missing, int use_com
>   		return -1;
>   	if (item->object.parsed)
>   		return 0;
> -	if (use_commit_graph && parse_commit_in_graph(item))
> +	if (use_commit_graph && parse_commit_in_graph(the_repository, item))
>   		return 0;
>   	buffer = read_object_file(&item->object.oid, &type, &size);
>   	if (!buffer)
> diff --git a/config.c b/config.c
> index a0a6ae1980..fcf863b667 100644
> --- a/config.c
> +++ b/config.c
> @@ -1308,11 +1308,6 @@ static int git_default_core_config(const char *var, const char *value)
>   		return 0;
>   	}
>   
> -	if (!strcmp(var, "core.commitgraph")) {
> -		core_commit_graph = git_config_bool(var, value);
> -		return 0;
> -	}
> -
>   	if (!strcmp(var, "core.sparsecheckout")) {
>   		core_apply_sparse_checkout = git_config_bool(var, value);
>   		return 0;
> diff --git a/environment.c b/environment.c
> index 2a6de2330b..d6e5b39425 100644
> --- a/environment.c
> +++ b/environment.c
> @@ -66,7 +66,6 @@ enum push_default_type push_default = PUSH_DEFAULT_UNSPECIFIED;
>   enum object_creation_mode object_creation_mode = OBJECT_CREATION_MODE;
>   char *notes_ref_name;
>   int grafts_replace_parents = 1;
> -int core_commit_graph;
>   int core_apply_sparse_checkout;
>   int merge_log_config = -1;
>   int precomposed_unicode = -1; /* see probe_utf8_pathname_composition() */
> diff --git a/ref-filter.c b/ref-filter.c
> index fa3685d91f..889d97b005 100644
> --- a/ref-filter.c
> +++ b/ref-filter.c
> @@ -1710,7 +1710,7 @@ static enum contains_result contains_tag_algo(struct commit *candidate,
>   
>   	for (p = want; p; p = p->next) {
>   		struct commit *c = p->item;
> -		load_commit_graph_info(c);
> +		load_commit_graph_info(the_repository, c);
>   		if (c->generation < cutoff)
>   			cutoff = c->generation;
>   	}

The changes above are mostly obvious. They don't need too much reading 
to know they are correct.

The tests below form a decently-large patch on their own. Perhaps split 
them out so it is easier to know that we have some interesting things to 
check here.

It's worth spending some extra time looking at this test pattern as I 
believe we will want to follow it with other arbitrary repository changes.


> diff --git a/t/helper/test-repository.c b/t/helper/test-repository.c
> new file mode 100644
> index 0000000000..5fff540a26
> --- /dev/null
> +++ b/t/helper/test-repository.c
> @@ -0,0 +1,88 @@
> +#include "test-tool.h"
> +#include "cache.h"
> +#include "commit-graph.h"
> +#include "commit.h"
> +#include "config.h"
> +#include "object-store.h"
> +#include "object.h"
> +#include "repository.h"
> +#include "tree.h"
> +
> +static void test_parse_commit_in_graph(const char *gitdir, const char *worktree,
> +				       const struct object_id *commit_oid)
> +{
> +	struct repository r;
> +	struct commit *c;
> +	struct commit_list *parent;
> +
> +	/*
> +	 * Create a commit independent of any repository.
> +	 */
> +	c = lookup_commit(commit_oid);
> +
> +	repo_init(&r, gitdir, worktree);
> +
> +	if (!parse_commit_in_graph(&r, c))
> +		die("Couldn't parse commit");
> +
> +	printf("%lu", c->date);
> +	for (parent = c->parents; parent; parent = parent->next)
> +		printf(" %s", oid_to_hex(&parent->item->object.oid));
> +	printf("\n");
> +
> +	repo_clear(&r);
> +}
> +
> +static void test_get_commit_tree_in_graph(const char *gitdir,
> +					  const char *worktree,
> +					  const struct object_id *commit_oid)
> +{
> +	struct repository r;
> +	struct commit *c;
> +	struct tree *tree;
> +
> +	/*
> +	 * Create a commit independent of any repository.
> +	 */
> +	c = lookup_commit(commit_oid);

Would this be more accurate to say we are creating a commit object 
stored in the object cache of the_repository? How would you expect this 
to work if/when lookup_commit() takes an arbitrary repository? You want 
to provide &r, right (after initializing)?

Also, this will conflict with sb/object-store-lookup, won't it? I'm 
guessing this is why you didn't touch the "git commit-graph 
[write|verify]"code paths.

> +
> +	repo_init(&r, gitdir, worktree);

I think you want to move the lookup_commit() to after this.

> +
> +	/*
> +	 * get_commit_tree_in_graph does not automatically parse the commit, so
> +	 * parse it first.
> +	 */
> +	if (!parse_commit_in_graph(&r, c))
> +		die("Couldn't parse commit");
> +	tree = get_commit_tree_in_graph(&r, c);
> +	if (!tree)
> +		die("Couldn't get commit tree");
> +
> +	printf("%s\n", oid_to_hex(&tree->object.oid));
> +
> +	repo_clear(&r);
> +}
> +
> +int cmd__repository(int argc, const char **argv)
> +{
> +	if (argc < 2)
> +		die("must have at least 2 arguments");

I think this "test-tool repository <verb>" pattern is a good way to get 
some testing here.

> +	if (!strcmp(argv[1], "parse_commit_in_graph")) {
> +		struct object_id oid;
> +		if (argc < 5)
> +			die("not enough arguments");
> +		if (parse_oid_hex(argv[4], &oid, &argv[4]))
> +			die("cannot parse oid '%s'", argv[4]);
> +		test_parse_commit_in_graph(argv[2], argv[3], &oid);
> +	} else if (!strcmp(argv[1], "get_commit_tree_in_graph")) {
> +		struct object_id oid;
> +		if (argc < 5)
> +			die("not enough arguments");
> +		if (parse_oid_hex(argv[4], &oid, &argv[4]))
> +			die("cannot parse oid '%s'", argv[4]);
> +		test_get_commit_tree_in_graph(argv[2], argv[3], &oid);
> +	} else {
> +		die("unrecognized '%s'", argv[1]);
> +	}
> +	return 0;
> +}
> diff --git a/t/helper/test-tool.c b/t/helper/test-tool.c
> index 805a45de9c..dafc91c240 100644
> --- a/t/helper/test-tool.c
> +++ b/t/helper/test-tool.c
> @@ -29,6 +29,7 @@ static struct test_cmd cmds[] = {
>   	{ "read-cache", cmd__read_cache },
>   	{ "ref-store", cmd__ref_store },
>   	{ "regex", cmd__regex },
> +	{ "repository", cmd__repository },
>   	{ "revision-walking", cmd__revision_walking },
>   	{ "run-command", cmd__run_command },
>   	{ "scrap-cache-tree", cmd__scrap_cache_tree },
> diff --git a/t/helper/test-tool.h b/t/helper/test-tool.h
> index 7116ddfb94..80cbcf0857 100644
> --- a/t/helper/test-tool.h
> +++ b/t/helper/test-tool.h
> @@ -23,6 +23,7 @@ int cmd__prio_queue(int argc, const char **argv);
>   int cmd__read_cache(int argc, const char **argv);
>   int cmd__ref_store(int argc, const char **argv);
>   int cmd__regex(int argc, const char **argv);
> +int cmd__repository(int argc, const char **argv);
>   int cmd__revision_walking(int argc, const char **argv);
>   int cmd__run_command(int argc, const char **argv);
>   int cmd__scrap_cache_tree(int argc, const char **argv);
> diff --git a/t/t5318-commit-graph.sh b/t/t5318-commit-graph.sh
> index 5947de3d24..4f17d7701e 100755
> --- a/t/t5318-commit-graph.sh
> +++ b/t/t5318-commit-graph.sh
> @@ -431,4 +431,39 @@ test_expect_success 'git fsck (checks commit-graph)' '
>   	test_must_fail git fsck
>   '
>   
> +test_expect_success 'setup non-the_repository tests' '
> +	rm -rf repo &&
> +	git init repo &&
> +	test_commit -C repo one &&
> +	test_commit -C repo two &&
> +	git -C repo config core.commitGraph true &&
> +	git -C repo rev-parse two | \
> +		git -C repo commit-graph write --stdin-commits
> +'
> +
> +test_expect_success 'parse_commit_in_graph works for non-the_repository' '
> +	test-tool repository parse_commit_in_graph \
> +		repo/.git repo "$(git -C repo rev-parse two)" >actual &&
> +	echo $(git -C repo log --pretty="%ct" -1) \
> +		$(git -C repo rev-parse one) >expect &&
> +	test_cmp expect actual &&
> +
> +	test-tool repository parse_commit_in_graph \
> +		repo/.git repo "$(git -C repo rev-parse one)" >actual &&
> +	echo $(git -C repo log --pretty="%ct" -1 one) >expect &&
> +	test_cmp expect actual
> +'
> +
> +test_expect_success 'get_commit_tree_in_graph works for non-the_repository' '
> +	test-tool repository get_commit_tree_in_graph \
> +		repo/.git repo "$(git -C repo rev-parse two)" >actual &&
> +	echo $(git -C repo rev-parse two^{tree}) >expect &&
> +	test_cmp expect actual &&
> +
> +	test-tool repository get_commit_tree_in_graph \
> +		repo/.git repo "$(git -C repo rev-parse one)" >actual &&
> +	echo $(git -C repo rev-parse one^{tree}) >expect &&
> +	test_cmp expect actual
> +'
> +
>   test_done
