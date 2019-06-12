Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id A49461F462
	for <e@80x24.org>; Wed, 12 Jun 2019 13:29:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732414AbfFLN3i (ORCPT <rfc822;e@80x24.org>);
        Wed, 12 Jun 2019 09:29:38 -0400
Received: from mail-ed1-f68.google.com ([209.85.208.68]:38216 "EHLO
        mail-ed1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727416AbfFLN3i (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 12 Jun 2019 09:29:38 -0400
Received: by mail-ed1-f68.google.com with SMTP id g13so25762565edu.5
        for <git@vger.kernel.org>; Wed, 12 Jun 2019 06:29:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:message-id:in-reply-to:references:from:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=7pWtZcum5j1QVvGh4GYCCCHEgQL/Bqagoot7gFPuJiY=;
        b=vL17LIIS23cpZ8+n68xki07kQauiMbmqozpBSQg2kGvD8ZKNIQaPdzyBtiTlqBzus/
         8zJgYnCI34pXwzwCP4BCjG3Iw64LBcUqLWWAr14Az4M0eMApBnf68YU50iYsUGzSw8hb
         dkm5pZyErwEJeSqyH642yA5cNddVUKWBtP0z1r53sClREcLZPf5zAXzWIdpPhawSp1qB
         ALBYRdlnmzx6amzwRPuYLY4wQljQL+So+lnmqzPGG5NZ0/TU4AhAwqCb3MjdlWSnODnm
         gI2I3LiOgV+m0UQCNzdYEfvuuq+SiAJpDvQTvzzVnzRpikm4VbH9yepUGm/+Zp6W2Qs5
         /TCA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:message-id:in-reply-to:references:from
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=7pWtZcum5j1QVvGh4GYCCCHEgQL/Bqagoot7gFPuJiY=;
        b=C8/vQZAx7fUX8DKD9I6kvzjhhdt0QddiMqrrFYX2EDMHle/HkTJtrbiEfAbW2rSN+5
         AOXVhj5BqAPcfPYz2P9KD8l8KWLU0pnAe7NDudVEJlUoW282jpUpKB46Z3Hh7fZDCKR+
         NTiSL7dc8NV5K7mXze6WZYqRi07oOa8K5k/xJHhxH3Y7idtsv2jgqkn4m4ZqhMc4dbL+
         HjzWgSX0b3D5R0ZRefLWVVj7mnaN2Kl16PmBW71B+9gnX+WBXz6qox+FhxwHHmOepV+d
         rx1z5JKWpknB6BAFh77Q98F3RIRqPGUA578VSmAGDkurdjaFV9ikmolTnoZAsYhhHq7t
         tZJw==
X-Gm-Message-State: APjAAAWVvIjmZKQYa1/bqhM+6eDFz2rhn13j1l+UFAx1V8at5DAUutnr
        9ahCW9fIhNfID8UC/5C9oB9KtUL8
X-Google-Smtp-Source: APXvYqzLhFa/uBMwjRyTDUzalkSDT5R2ERotL1uZ54fyFe0QPq7OZnf3Vhv9meFuQdIbPpNmmLLbYg==
X-Received: by 2002:a05:6402:550:: with SMTP id i16mr88151953edx.212.1560346175765;
        Wed, 12 Jun 2019 06:29:35 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id y3sm1839901edr.27.2019.06.12.06.29.34
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 12 Jun 2019 06:29:35 -0700 (PDT)
Date:   Wed, 12 Jun 2019 06:29:35 -0700 (PDT)
X-Google-Original-Date: Wed, 12 Jun 2019 13:29:22 GMT
Message-Id: <pull.112.v5.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.112.v4.git.gitgitgadget@gmail.com>
References: <pull.112.v4.git.gitgitgadget@gmail.com>
From:   "Derrick Stolee via GitGitGadget" <gitgitgadget@gmail.com>
Subject: [PATCH v5 00/11] Commit-graph write refactor (was: Create commit-graph file format v2)
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     sandals@crustytoothpaste.net, avarab@gmail.com, peff@peff.net,
        Junio C Hamano <gitster@pobox.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

This series replaces ds/commit-graph-file-v2, and I'm using the same
gitgitgadget PR to continue the version numbers and hopefully make that
clear. This is a slight modification on patches 1-11 from the incremental
file format RFC [0].

The commit-graph feature is growing, thanks to all of the contributions by
several community members. This also means that the write_commit_graph()
method is a bit unwieldy now. This series refactors that method to use a
write_commit_graph_context struct that is passed between several smaller
methods. The final result should be a write_commit_graph() method that has a
clear set of steps. Future changes should then be easier to understand.

 * Patches 1-4: these are small changes which either fix issues or just
   provide clean-up. These are mostly borrowed from
   ds/commit-graph-format-v2. 
   
   
 * Patches 5-11: these provide a non-functional refactor of
   write_commit_graph() into several methods using a "struct
   write_commit_graph_context" to share across the methods.
   
   

Updates to commits previously in this thread:

 * "commit-graph: remove Future Work section" no longer says that 'verify'
   takes as long as 'write'. [1]
   
   
 * "commit-graph: return with errors during write" now has a test to check
   we don't die(). [2]
   
   

Ævar: Looking at the old thread, I only saw two comments that still apply to
this series [1] [2]. Please point me to any comments I have missed.

Updates in V5:

 * API calls are updated to return 0 on success and a negative value on
   failure.
   
   
 * Stopped passing 'errno' through an API function, instead returns -1.
   
   
 * "extracting methods" -> "extracting helper functions" in commit messages.
   
   
 * flags are now unsigned ints.
   
   

Thanks, -Stolee

[0] https://public-inbox.org/git/pull.184.git.gitgitgadget@gmail.com/

[1] https://public-inbox.org/git/87o94mql0a.fsf@evledraar.gmail.com/

[2] https://public-inbox.org/git/87pnp2qlkv.fsf@evledraar.gmail.com/

Derrick Stolee (11):
  commit-graph: fix the_repository reference
  commit-graph: return with errors during write
  commit-graph: collapse parameters into flags
  commit-graph: remove Future Work section
  commit-graph: create write_commit_graph_context
  commit-graph: extract fill_oids_from_packs()
  commit-graph: extract fill_oids_from_commit_hex()
  commit-graph: extract fill_oids_from_all_packs()
  commit-graph: extract count_distinct_commits()
  commit-graph: extract copy_oids_to_commits()
  commit-graph: extract write_commit_graph_file()

 Documentation/technical/commit-graph.txt |  17 -
 builtin/commit-graph.c                   |  22 +-
 builtin/commit.c                         |   5 +-
 builtin/gc.c                             |   7 +-
 commit-graph.c                           | 607 +++++++++++++----------
 commit-graph.h                           |  20 +-
 commit.c                                 |   2 +-
 t/t5318-commit-graph.sh                  |   8 +
 8 files changed, 378 insertions(+), 310 deletions(-)


base-commit: 93b4405ffe4ad9308740e7c1c71383bfc369baaa
Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-112%2Fderrickstolee%2Fgraph%2Fv2-head-v5
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-112/derrickstolee/graph/v2-head-v5
Pull-Request: https://github.com/gitgitgadget/git/pull/112

Range-diff vs v4:

  1:  0be7713a25 =  1:  0be7713a25 commit-graph: fix the_repository reference
  2:  a4082b827e !  2:  95f66e85b2 commit-graph: return with errors during write
     @@ -5,14 +5,17 @@
          The write_commit_graph() method uses die() to report failure and
          exit when confronted with an unexpected condition. This use of
          die() in a library function is incorrect and is now replaced by
     -    error() statements and an int return type.
     +    error() statements and an int return type. Return zero on success
     +    and a negative value on failure.
      
          Now that we use 'goto cleanup' to jump to the terminal condition
          on an error, we have new paths that could lead to uninitialized
          values. New initializers are added to correct for this.
      
          The builtins 'commit-graph', 'gc', and 'commit' call these methods,
     -    so update them to check the return value.
     +    so update them to check the return value. Test that 'git commit-graph
     +    write' returns a proper error code when hitting a failure condition
     +    in write_commit_graph().
      
          Signed-off-by: Derrick Stolee <dstolee@microsoft.com>
      
     @@ -23,7 +26,7 @@
       	struct string_list *pack_indexes = NULL;
       	struct string_list *commit_hex = NULL;
       	struct string_list lines;
     -+	int result;
     ++	int result = 0;
       
       	static struct option builtin_commit_graph_write_options[] = {
       		OPT_STRING(0, "object-dir", &opts.obj_dir,
     @@ -49,11 +52,12 @@
      -			   commit_hex,
      -			   opts.append,
      -			   1);
     -+	result = write_commit_graph(opts.obj_dir,
     -+				    pack_indexes,
     -+				    commit_hex,
     -+				    opts.append,
     -+				    1);
     ++	if (write_commit_graph(opts.obj_dir,
     ++			       pack_indexes,
     ++			       commit_hex,
     ++			       opts.append,
     ++			       1))
     ++		result = 1;
       
       	UNLEAK(lines);
      -	return 0;
     @@ -167,12 +171,12 @@
      -				die(_("error opening index for %s"), packname.buf);
      +			if (!p) {
      +				error(_("error adding pack %s"), packname.buf);
     -+				res = 1;
     ++				res = -1;
      +				goto cleanup;
      +			}
      +			if (open_pack_index(p)) {
      +				error(_("error opening index for %s"), packname.buf);
     -+				res = 1;
     ++				res = -1;
      +				goto cleanup;
      +			}
       			for_each_object_in_pack(p, add_packed_commits, &oids,
     @@ -186,7 +190,7 @@
      -		die(_("the commit graph format cannot write %d commits"), count_distinct);
      +	if (count_distinct >= GRAPH_EDGE_LAST_MASK) {
      +		error(_("the commit graph format cannot write %d commits"), count_distinct);
     -+		res = 1;
     ++		res = -1;
      +		goto cleanup;
      +	}
       
     @@ -200,7 +204,7 @@
      -		die(_("too many commits to write graph"));
      +	if (commits.nr >= GRAPH_EDGE_LAST_MASK) {
      +		error(_("too many commits to write graph"));
     -+		res = 1;
     ++		res = -1;
      +		goto cleanup;
      +	}
       
     @@ -213,7 +217,7 @@
      -			  graph_name);
      +		error(_("unable to create leading directories of %s"),
      +			graph_name);
     -+		res = errno;
     ++		res = -1;
      +		goto cleanup;
       	}
       
     @@ -240,6 +244,12 @@
       int generation_numbers_enabled(struct repository *r);
       
      -void write_commit_graph_reachable(const char *obj_dir, int append,
     ++/*
     ++ * The write_commit_graph* methods return zero on success
     ++ * and a negative value on failure. Note that if the repository
     ++ * is not compatible with the commit-graph feature, then the
     ++ * methods will return 0 without writing a commit-graph.
     ++ */
      +int write_commit_graph_reachable(const char *obj_dir, int append,
       				  int report_progress);
      -void write_commit_graph(const char *obj_dir,
  3:  469d0c9a32 !  3:  b4e3ae579a commit-graph: collapse parameters into flags
     @@ -4,8 +4,8 @@
      
          The write_commit_graph() and write_commit_graph_reachable() methods
          currently take two boolean parameters: 'append' and 'report_progress'.
     -    We will soon expand the possible options to send to these methods, so
     -    instead of complicating the parameter list, first simplify it.
     +    As we update these methods, adding more parameters this way becomes
     +    cluttered and hard to maintain.
      
          Collapse these parameters into a 'flags' parameter, and adjust the
          callers to provide flags as necessary.
     @@ -18,8 +18,8 @@
      @@
       	struct string_list *commit_hex = NULL;
       	struct string_list lines;
     - 	int result;
     -+	int flags = COMMIT_GRAPH_PROGRESS;
     + 	int result = 0;
     ++	unsigned int flags = COMMIT_GRAPH_PROGRESS;
       
       	static struct option builtin_commit_graph_write_options[] = {
       		OPT_STRING(0, "object-dir", &opts.obj_dir,
     @@ -39,15 +39,15 @@
       	string_list_init(&lines, 0);
       	if (opts.stdin_packs || opts.stdin_commits) {
      @@
     - 	result = write_commit_graph(opts.obj_dir,
     - 				    pack_indexes,
     - 				    commit_hex,
     --				    opts.append,
     --				    1);
     -+				    flags);
     + 	if (write_commit_graph(opts.obj_dir,
     + 			       pack_indexes,
     + 			       commit_hex,
     +-			       opts.append,
     +-			       1))
     ++			       flags))
     + 		result = 1;
       
       	UNLEAK(lines);
     - 	return result;
      
       diff --git a/builtin/commit.c b/builtin/commit.c
       --- a/builtin/commit.c
     @@ -124,11 +124,17 @@
        */
       int generation_numbers_enabled(struct repository *r);
       
     --int write_commit_graph_reachable(const char *obj_dir, int append,
     --				  int report_progress);
      +#define COMMIT_GRAPH_APPEND     (1 << 0)
      +#define COMMIT_GRAPH_PROGRESS   (1 << 1)
      +
     + /*
     +  * The write_commit_graph* methods return zero on success
     +  * and a negative value on failure. Note that if the repository
     +  * is not compatible with the commit-graph feature, then the
     +  * methods will return 0 without writing a commit-graph.
     +  */
     +-int write_commit_graph_reachable(const char *obj_dir, int append,
     +-				  int report_progress);
      +int write_commit_graph_reachable(const char *obj_dir, unsigned int flags);
       int write_commit_graph(const char *obj_dir,
       		       struct string_list *pack_indexes,
  4:  130007d0e1 =  4:  a5223a37a9 commit-graph: remove Future Work section
  5:  0ca4e18e98 !  5:  b5b8a87676 commit-graph: create write_commit_graph_context
     @@ -3,7 +3,7 @@
          commit-graph: create write_commit_graph_context
      
          The write_commit_graph() method is too large and complex. To simplify
     -    it, we should extract several small methods. However, we will risk
     +    it, we should extract several helper functions. However, we will risk
          repeating a lot of declarations related to progress incidators and
          object id or commit lists.
      
     @@ -11,7 +11,7 @@
          core data structures used in this process. Replace the other local
          variables with the values inside the context object. Following this
          change, we will start to lift code segments wholesale out of the
     -    write_commit_graph() method and into their own methods.
     +    write_commit_graph() method and into helper functions.
      
          Signed-off-by: Derrick Stolee <dstolee@microsoft.com>
      
     @@ -454,7 +454,7 @@
       		for (i = 0; i < pack_indexes->nr; i++) {
       			struct packed_git *p;
      @@
     - 				res = 1;
     + 				res = -1;
       				goto cleanup;
       			}
      -			for_each_object_in_pack(p, add_packed_commits, &oids,
     @@ -610,7 +610,7 @@
      -	if (commits.nr >= GRAPH_EDGE_LAST_MASK) {
      +	if (ctx->commits.nr >= GRAPH_EDGE_LAST_MASK) {
       		error(_("too many commits to write graph"));
     - 		res = 1;
     + 		res = -1;
       		goto cleanup;
       	}
       
     @@ -628,7 +628,7 @@
       		error(_("unable to create leading directories of %s"),
      -			graph_name);
      +			ctx->graph_name);
     - 		res = errno;
     + 		res = -1;
       		goto cleanup;
       	}
       
  6:  30c1b618b1 !  6:  98e243be67 commit-graph: extract fill_oids_from_packs()
     @@ -3,7 +3,7 @@
          commit-graph: extract fill_oids_from_packs()
      
          The write_commit_graph() method is too complex, so we are
     -    extracting methods one by one.
     +    extracting helper functions one by one.
      
          This extracts fill_oids_from_packs() that reads the given
          pack-file list and fills the oid list in the context.
     @@ -43,11 +43,11 @@
      +		p = add_packed_git(packname.buf, packname.len, 1);
      +		if (!p) {
      +			error(_("error adding pack %s"), packname.buf);
     -+			return 1;
     ++			return -1;
      +		}
      +		if (open_pack_index(p)) {
      +			error(_("error opening index for %s"), packname.buf);
     -+			return 1;
     ++			return -1;
      +		}
      +		for_each_object_in_pack(p, add_packed_commits, ctx,
      +					FOR_EACH_OBJECT_PACK_ORDER);
     @@ -89,12 +89,12 @@
      -			p = add_packed_git(packname.buf, packname.len, 1);
      -			if (!p) {
      -				error(_("error adding pack %s"), packname.buf);
     --				res = 1;
     +-				res = -1;
      -				goto cleanup;
      -			}
      -			if (open_pack_index(p)) {
      -				error(_("error opening index for %s"), packname.buf);
     --				res = 1;
     +-				res = -1;
      -				goto cleanup;
      -			}
      -			for_each_object_in_pack(p, add_packed_commits, ctx,
  7:  8cb2613dfa !  7:  fe36c8ad28 commit-graph: extract fill_oids_from_commit_hex()
     @@ -3,7 +3,7 @@
          commit-graph: extract fill_oids_from_commit_hex()
      
          The write_commit_graph() method is too complex, so we are
     -    extracting methods one by one.
     +    extracting helper functions one by one.
      
          Extract fill_oids_from_commit_hex() that reads the given commit
          id list and fille the oid list in the context.
  8:  8f7129672a !  8:  b8dfb663f3 commit-graph: extract fill_oids_from_all_packs()
     @@ -3,7 +3,7 @@
          commit-graph: extract fill_oids_from_all_packs()
      
          The write_commit_graph() method is too complex, so we are
     -    extracting methods one by one.
     +    extracting helper functions one by one.
      
          Extract fill_oids_from_all_packs() that reads all pack-files
          for commits and fills the oid list in the context.
  9:  a37548745b !  9:  40acc6ec37 commit-graph: extract count_distinct_commits()
     @@ -3,7 +3,7 @@
          commit-graph: extract count_distinct_commits()
      
          The write_commit_graph() method is too complex, so we are
     -    extracting methods one by one.
     +    extracting helper functions one by one.
      
          Extract count_distinct_commits(), which sorts the oids list, then
          iterates through to find duplicates.
 10:  57366ffdaa ! 10:  b403c01ef5 commit-graph: extract copy_oids_to_commits()
     @@ -3,7 +3,7 @@
          commit-graph: extract copy_oids_to_commits()
      
          The write_commit_graph() method is too complex, so we are
     -    extracting methods one by one.
     +    extracting helper functions one by one.
      
          Extract copy_oids_to_commits(), which fills the commits list
          with the distinct commits from the oids list. During this loop,
 11:  fc81c8946d ! 11:  7ecf923040 commit-graph: extract write_commit_graph_file()
     @@ -3,7 +3,7 @@
          commit-graph: extract write_commit_graph_file()
      
          The write_commit_graph() method is too complex, so we are
     -    extracting methods one by one.
     +    extracting helper functions one by one.
      
          Extract write_commit_graph_file() that takes all of the information
          in the context struct and writes the data to a commit-graph file.
     @@ -41,7 +41,7 @@
      +		UNLEAK(ctx->graph_name);
      +		error(_("unable to create leading directories of %s"),
      +			ctx->graph_name);
     -+		return errno;
     ++		return -1;
      +	}
      +
      +	hold_lock_file_for_update(&lk, ctx->graph_name, LOCK_DIE_ON_ERROR);
     @@ -124,7 +124,7 @@
      -		UNLEAK(ctx->graph_name);
      -		error(_("unable to create leading directories of %s"),
      -			ctx->graph_name);
     --		res = errno;
     +-		res = -1;
      -		goto cleanup;
      -	}
      -

-- 
gitgitgadget
