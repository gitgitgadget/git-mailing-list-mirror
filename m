Received: from mail-wm1-f52.google.com (mail-wm1-f52.google.com [209.85.128.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D5E8E219A77
	for <git@vger.kernel.org>; Fri, 20 Dec 2024 16:29:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734712200; cv=none; b=ABbWoB7HZgIbFlsBCNMI8LoCLqAqznBjnEMN9gH/RSLoaYYAxtxtz1J7w+cJ0zCspj9WIhbXEzE0876+u1qlskR7X8j6ObvPEH08ez1afw91o7QZGjnxUsaDn/NqUYXXwkTytijz8PC54GS6NhVsU4CICs2uzPvQr3eD9V7K4bY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734712200; c=relaxed/simple;
	bh=flzNogSKFtHtjOuVEagluBIsIRi62UAd1FWvzK2QDdc=;
	h=Message-Id:In-Reply-To:References:From:Date:Subject:Content-Type:
	 MIME-Version:To:Cc; b=fp9U5cH8yXQhUkWvtRGE+vIFVxjAgSeWPA6UtoZFzbgkvWiGsQPrgJz0mIID+7xZ3ft42M+OFFUx7YxtImBZ4M4+pewF4Y8vAsaPxDHcetx8Qx1UMCfhRJvRTgR5iko3Yf1rccM8ZLgr7ahDmo335lkuqrfxxFeJHYSslsf4/lU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=EkuhOYP1; arc=none smtp.client-ip=209.85.128.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="EkuhOYP1"
Received: by mail-wm1-f52.google.com with SMTP id 5b1f17b1804b1-43634b570c1so15624625e9.0
        for <git@vger.kernel.org>; Fri, 20 Dec 2024 08:29:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1734712196; x=1735316996; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=wPv7gW3+/gxEPGygu1vL70zqiy1IAmJ2IbYFm5nADmU=;
        b=EkuhOYP1DlI+RS90OcU8Mwuq3tlOIMb7btdNMAb7XjRJPEWqwLuIYeWDC5nccjnasU
         JVadS70o3zjZDpUDEQBxAuuMWp9HimoWq4FUgdqQ8JlG0U6yuNLq7oOj2KvIlnTcNxih
         TpQu0OMycwT1iIsAdbfRsHMJPw/eQXtGoEBX1ZMEIMBzG4krr+Ru/TGszfjaHfTm3pJC
         pWvsW5PyviRshkwzxlwBUCjMjKjgY/HqqnpjHE+8ZDsu6HmjNehH9JIJS7J9FgznkMn+
         LRg1wx0DpFGWxrZtKeL/P31bwntr/OQC/E6FXsmJjJozc4/U+UhbQlg5eTHZSLFDYTnW
         14nA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1734712196; x=1735316996;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=wPv7gW3+/gxEPGygu1vL70zqiy1IAmJ2IbYFm5nADmU=;
        b=ETj/JHTZU7wxB+oTCBvhDnb/wHVfYo/FO7Q5tY9qKhC3zY6z5GUuyRSlScKu8IpkpL
         qmh+z4hCTH8jBPR6t6BbtcOcYo+EuYfIrVBxP9F1UvaZkxeLSK4SX95vGUwj1ciO6Cji
         aZypwJVJq/v4mWdKIrRisP7TYRr3SIdbRrTluNMh9sI+wkpucT2VpBL5nZIQOkDXwFZj
         NbznMOSazZ6iRGQmElvn4R5PvvuCOzPkzm29DHSwC4ZKCGxu9MiWr5Uveji7u4rHDdXm
         aIr9+USe9Pk8ta9pQogPxIE+Pv0CEYnMjA+KyGOVYG6wV51uDW74d8kwNa2Hkuylny0w
         l+fA==
X-Gm-Message-State: AOJu0Yz5VzjvSoeM2lcd+dnAE+fWh831cc/Q48y8TtyApBht/Q2VnNla
	kYcSQ805WM7dNXT/8plgsp7kcNwIobWwQnMRr8SVZFI0bRmuG3OhU+ORTQ==
X-Gm-Gg: ASbGncs8VzxxDcg0Me1II+mHxS9A8KVEfCR+J1hy8IRlFD4D3PaQGFda+BCWy4tiM+N
	agsOUHrwyhStlyGk9vosq9UCAQs0cyA4D7Xa7moMyTdGc+1kv56VS+ziN/vWkJrMZDMFCeclB66
	QJMkZdK+JGesUKnsy9s71qdlq2zECCVGgoNDcxIRQ6uYLvrn4DxRVMeeSt1E3XIR9gYOSoHr6OB
	O+xAzdD3EpKSbx7oPKvOBn+MGea1BKot4PtvKe+OU0V0tewx1woJOmO3A==
X-Google-Smtp-Source: AGHT+IEu1O/96vJdehOvsKn4NXkh1iPrm0wTPtDvB1/ifrBW4FetT1qndYILDR4Gze3KkkwwOofBaA==
X-Received: by 2002:a05:600c:45cd:b0:434:effb:9f8a with SMTP id 5b1f17b1804b1-4366864619dmr34856015e9.15.1734712195493;
        Fri, 20 Dec 2024 08:29:55 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-436611ea3d5sm50782635e9.5.2024.12.20.08.29.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 20 Dec 2024 08:29:54 -0800 (PST)
Message-Id: <pull.1820.v2.git.1734712193.gitgitgadget@gmail.com>
In-Reply-To: <pull.1820.git.1733515638.gitgitgadget@gmail.com>
References: <pull.1820.git.1733515638.gitgitgadget@gmail.com>
From: "Derrick Stolee via GitGitGadget" <gitgitgadget@gmail.com>
Date: Fri, 20 Dec 2024 16:29:48 +0000
Subject: [PATCH v2 0/5] PATH WALK III: Add 'git backfill' command
Fcc: Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
To: git@vger.kernel.org
Cc: gitster@pobox.com,
    johannes.schindelin@gmx.de,
    peff@peff.net,
    ps@pks.im,
    me@ttaylorr.com,
    johncai86@gmail.com,
    newren@gmail.com,
    christian.couder@gmail.com,
    kristofferhaugsbakk@fastmail.com,
    jonathantanmy@google.com,
    karthik.188@gmail.com,
    Derrick Stolee <stolee@gmail.com>

This is based on v4 of ds/path-walk-1 [1] and an earlier version was part of
my initial path-walk RFC [2].

[1]
https://lore.kernel.org/git/pull.1818.v3.git.1733514358.gitgitgadget@gmail.com/

[2]
https://lore.kernel.org/git/pull.1786.git.1725935335.gitgitgadget@gmail.com/

This series adds a new 'git backfill' command that uses the path-walk API to
download missing blobs in a blobless partial clone. Users can specify
interaction with the sparse-checkout using '--[no-]sparse' but the
'--sparse' option is implied by the existence of a sparse-checkout.

The reason to use the path-walk API is to make sure that the missing objects
are grouped by a common path, giving a reasonable process for batching
requests and expecting the server to compress the resulting packfile nicely
together.

I first prototyped this feature in June 2024 as an exploration and created
the path-walk algorithm for this purpose. It was only my intuition that led
me to believe that batching by path would lead to better packfiles. This has
been proven out as a very important feature due to recent investigations to
compressing full repositories by doing a better job of grouping objects by
path. See the --name-hash-version series [3] or the 'git pack-objects
--path-walk' series [4] (currently on hold as it conflicts with the
--name-hash-version series).

[3]
https://lore.kernel.org/git/pull.1823.v2.git.1733181682.gitgitgadget@gmail.com/

[4]
https://lore.kernel.org/git/pull.1813.v2.git.1729431810.gitgitgadget@gmail.com/

This idea can be further demonstrated by the evidence in testing this
feature: by downloading objects in small batch sizes, the client can force
the server to repack things more efficiently than a full repack.

The example repository I have used in multiple places is the
microsoft/fluentui repo [5] as it has many CHANGELOG.md files that cause
name hash collisions that make the full repack inefficient.

[5] https://github.com/microsoft/fluentui

If we create a blobless clone of the fluentui repo, then this downloads 105
MB across two packfiles (the commits and trees pack, followed by the blobs
needed for an initial checkout). Running 'git backfill --batch-size=' for
different sizes leads to some interesting results:

| Batch Size      | Pack Count | Pack Size | Time   |
|-----------------|------------|-----------|--------|
| (Initial clone) | 2          | 105 MB    |        |
| 5K              | 53         | 348 MB    | 2m 26s |
| 10K             | 28         | 365 MB    | 2m 22s |
| 15K             | 19         | 407 MB    | 2m 21s |
| 20K             | 15         | 393 MB    | 2m 28s |
| 25K             | 13         | 417 MB    | 2m 06s |
| 50K             | 8          | 509 MB    | 1m 34s |
| 100K            | 5          | 535 MB    | 1m 56s |
| 250K            | 4          | 698 MB    | 1m 33s |
| 500K            | 3          | 696 MB    | 1m 42s |


The smaller batches cause the server to realize that the existing deltas
cannot be reused and it finds better deltas. This takes some extra time for
the small batches, but halves the size of the repo. Even in the 500K batch
size, we get less data than the 738 MB of a full clone.

Implementing the --sparse feature is best done by augmenting the path-walk
API to be aware of a pattern list. This works for both cone and non-cone
mode sparse-checkouts.

There are future directions we could take this command, especially to run
the command with a user-specified pathspec. The tricky case for that
additional feature is trying to make the path-walk more efficient by
skipping tree paths that would not lead to a match of the pathspec. It would
likely need optimization in a small subset of pathspec features (such as
prefix matches) to work as efficiently as possible. I did prototype a
version that puts the pathspec match in the callback function within
builtin/backfill.c, but I found that uninspiring and unnecessary for now.


Updates in v2
=============

Thanks for the review on v1.

 * Memory leaks should be plugged now due to the introduction of a
   destructor in v4 of the path-walk API and its extension here to clear the
   pattern list.

 * Documentation is expanded to demonstrate that 'git backfill' can also
   approximate incremental/resumable clones of repositories.

 * Method renames to better match style.

 * --batch-size is renamed to --min-batch-size for clarity and future
   extensibility.

Thanks, -Stolee

Derrick Stolee (5):
  backfill: add builtin boilerplate
  backfill: basic functionality and tests
  backfill: add --min-batch-size=<n> option
  backfill: add --sparse option
  backfill: assume --sparse when sparse-checkout is enabled

 .gitignore                                |   1 +
 Documentation/git-backfill.txt            |  68 +++++++++
 Documentation/technical/api-path-walk.txt |  11 +-
 Makefile                                  |   1 +
 builtin.h                                 |   1 +
 builtin/backfill.c                        | 151 ++++++++++++++++++
 command-list.txt                          |   1 +
 dir.c                                     |  10 +-
 dir.h                                     |   3 +
 git.c                                     |   1 +
 path-walk.c                               |  28 +++-
 path-walk.h                               |  11 ++
 t/helper/test-path-walk.c                 |  22 ++-
 t/t5620-backfill.sh                       | 178 ++++++++++++++++++++++
 t/t6601-path-walk.sh                      |  32 ++++
 15 files changed, 505 insertions(+), 14 deletions(-)
 create mode 100644 Documentation/git-backfill.txt
 create mode 100644 builtin/backfill.c
 create mode 100755 t/t5620-backfill.sh


base-commit: ef543429ed9cb92e209900e7c7fc4f8e0698a306
Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-1820%2Fderrickstolee%2Fbackfill-upstream-v2
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-1820/derrickstolee/backfill-upstream-v2
Pull-Request: https://github.com/gitgitgadget/git/pull/1820

Range-diff vs v1:

 1:  0300aa1b8c3 = 1:  ac86510417a backfill: add builtin boilerplate
 2:  5728dd27021 ! 2:  e4e88794cae backfill: basic functionality and tests
     @@ Documentation/git-backfill.txt: SYNOPSIS
      +grouping blobs that appear at the same path, hopefully leading to good
      +delta compression in the packfile sent by the server.
      +
     ++In this way, `git backfill` provides a mechanism to break a large clone
     ++into smaller chunks. Starting with a blobless partial clone with `git
     ++clone --filter=blob:none` and then running `git backfill` in the local
     ++repository provides a way to download all reachable objects in several
     ++smaller network calls than downloading the entire repository at clone
     ++time.
     ++
      +By default, `git backfill` downloads all blobs reachable from the `HEAD`
      +commit. This set can be restricted or expanded using various options.
      +
     @@ builtin/backfill.c
      +	size_t batch_size;
      +};
      +
     -+static void clear_backfill_context(struct backfill_context *ctx)
     ++static void backfill_context_clear(struct backfill_context *ctx)
      +{
      +	oid_array_clear(&ctx->current_batch);
      +}
     @@ builtin/backfill.c
      +	if (!ret)
      +		download_batch(ctx);
      +
     -+	clear_backfill_context(ctx);
     ++	backfill_context_clear(ctx);
     ++	path_walk_info_clear(&info);
     ++	release_revisions(&revs);
      +	return ret;
      +}
      +
 3:  3cfd23073a0 ! 3:  3fa32822dab backfill: add --batch-size=<n> option
     @@ Metadata
      Author: Derrick Stolee <derrickstolee@github.com>
      
       ## Commit message ##
     -    backfill: add --batch-size=<n> option
     +    backfill: add --min-batch-size=<n> option
      
          Users may want to specify a minimum batch size for their needs. This is only
          a minimum: the path-walk API provides a list of OIDs that correspond to the
     @@ Documentation/git-backfill.txt: git-backfill - Download missing objects in a par
       
       DESCRIPTION
       -----------
     -@@ Documentation/git-backfill.txt: delta compression in the packfile sent by the server.
     +@@ Documentation/git-backfill.txt: time.
       By default, `git backfill` downloads all blobs reachable from the `HEAD`
       commit. This set can be restricted or expanded using various options.
       
      +OPTIONS
      +-------
      +
     -+--batch-size=<n>::
     ++--min-batch-size=<n>::
      +	Specify a minimum size for a batch of missing objects to request
      +	from the server. This size may be exceeded by the last set of
     -+	blobs seen at a given path. Default batch size is 16,000.
     ++	blobs seen at a given path. The default minimum batch size is
     ++	50,000.
      +
       SEE ALSO
       --------
     @@ builtin/backfill.c
       	NULL
       };
       
     + struct backfill_context {
     + 	struct repository *repo;
     + 	struct oid_array current_batch;
     +-	size_t batch_size;
     ++	size_t min_batch_size;
     + };
     + 
     + static void backfill_context_clear(struct backfill_context *ctx)
     +@@ builtin/backfill.c: static int fill_missing_blobs(const char *path UNUSED,
     + 			oid_array_append(&ctx->current_batch, &list->oid[i]);
     + 	}
     + 
     +-	if (ctx->current_batch.nr >= ctx->batch_size)
     ++	if (ctx->current_batch.nr >= ctx->min_batch_size)
     + 		download_batch(ctx);
     + 
     + 	return 0;
      @@ builtin/backfill.c: int cmd_backfill(int argc, const char **argv, const char *prefix, struct reposit
     - 		.batch_size = 50000,
     + 	struct backfill_context ctx = {
     + 		.repo = repo,
     + 		.current_batch = OID_ARRAY_INIT,
     +-		.batch_size = 50000,
     ++		.min_batch_size = 50000,
       	};
       	struct option options[] = {
     -+		OPT_INTEGER(0, "batch-size", &ctx.batch_size,
     -+			    N_("Minimun number of objects to request at a time")),
     ++		OPT_INTEGER(0, "min-batch-size", &ctx.min_batch_size,
     ++			    N_("Minimum number of objects to request at a time")),
       		OPT_END(),
       	};
       
     @@ t/t5620-backfill.sh: test_expect_success 'do partial clone 1, backfill gets all
       	test_line_count = 0 revs2
       '
       
     -+test_expect_success 'do partial clone 2, backfill batch size' '
     ++test_expect_success 'do partial clone 2, backfill min batch size' '
      +	git clone --no-checkout --filter=blob:none	\
      +		--single-branch --branch=main 		\
      +		"file://$(pwd)/srv.bare" backfill2 &&
      +
      +	GIT_TRACE2_EVENT="$(pwd)/batch-trace" git \
     -+		-C backfill2 backfill --batch-size=20 &&
     ++		-C backfill2 backfill --min-batch-size=20 &&
      +
      +	# Batches were used
      +	test_trace2_data promisor fetch_count 20 <batch-trace >matches &&
 4:  19a8efebbad ! 4:  2723143afb3 backfill: add --sparse option
     @@ Commit message
          only does this reduce the cost of clones and fetches, the sparse-checkout
          reduces the number of objects needed to download from a promisor remote.
      
     -    However, history investigations can be expensie as computing blob diffs will
     -    trigger promisor remote requests for one object at a time. This can be
     +    However, history investigations can be expensive as computing blob diffs
     +    will trigger promisor remote requests for one object at a time. This can be
          avoided by downloading the blobs needed for the given sparse-checkout using
          'git backfill' and its new '--sparse' mode, at a time that the user is
          willing to pay that extra cost.
     @@ Documentation/git-backfill.txt: git-backfill - Download missing objects in a par
       DESCRIPTION
       -----------
      @@ Documentation/git-backfill.txt: OPTIONS
     - 	from the server. This size may be exceeded by the last set of
     - 	blobs seen at a given path. Default batch size is 16,000.
     + 	blobs seen at a given path. The default minimum batch size is
     + 	50,000.
       
      +--[no-]sparse::
      +	Only download objects if they appear at a path that matches the
     @@ builtin/backfill.c
      @@ builtin/backfill.c: struct backfill_context {
       	struct repository *repo;
       	struct oid_array current_batch;
     - 	size_t batch_size;
     + 	size_t min_batch_size;
      +	int sparse;
       };
       
     - static void clear_backfill_context(struct backfill_context *ctx)
     + static void backfill_context_clear(struct backfill_context *ctx)
      @@ builtin/backfill.c: static int do_backfill(struct backfill_context *ctx)
       	struct path_walk_info info = PATH_WALK_INFO_INIT;
       	int ret;
       
      +	if (ctx->sparse) {
      +		CALLOC_ARRAY(info.pl, 1);
     -+		if (get_sparse_checkout_patterns(info.pl))
     ++		if (get_sparse_checkout_patterns(info.pl)) {
     ++			path_walk_info_clear(&info);
      +			return error(_("problem loading sparse-checkout"));
     ++		}
      +	}
      +
       	repo_init_revisions(ctx->repo, &revs, "");
     @@ builtin/backfill.c: static int do_backfill(struct backfill_context *ctx)
      @@ builtin/backfill.c: int cmd_backfill(int argc, const char **argv, const char *prefix, struct reposit
       		.repo = repo,
       		.current_batch = OID_ARRAY_INIT,
     - 		.batch_size = 50000,
     + 		.min_batch_size = 50000,
      +		.sparse = 0,
       	};
       	struct option options[] = {
     - 		OPT_INTEGER(0, "batch-size", &ctx.batch_size,
     - 			    N_("Minimun number of objects to request at a time")),
     + 		OPT_INTEGER(0, "min-batch-size", &ctx.min_batch_size,
     + 			    N_("Minimum number of objects to request at a time")),
      +		OPT_BOOL(0, "sparse", &ctx.sparse,
      +			 N_("Restrict the missing objects to the current sparse-checkout")),
       		OPT_END(),
     @@ path-walk.c
       #include "revision.h"
       #include "string-list.h"
       #include "strmap.h"
     -@@ path-walk.c: static int add_children(struct path_walk_context *ctx,
     +@@ path-walk.c: static int add_tree_entries(struct path_walk_context *ctx,
       		if (type == OBJ_TREE)
       			strbuf_addch(&path, '/');
       
     @@ path-walk.c: static int add_children(struct path_walk_context *ctx,
       		if (!(list = strmap_get(&ctx->paths_to_lists, path.buf))) {
       			CALLOC_ARRAY(list, 1);
       			list->type = type;
     +@@ path-walk.c: void path_walk_info_init(struct path_walk_info *info)
     + 	memcpy(info, &empty, sizeof(empty));
     + }
     + 
     +-void path_walk_info_clear(struct path_walk_info *info UNUSED)
     ++void path_walk_info_clear(struct path_walk_info *info)
     + {
     +-	/*
     +-	 * This destructor is empty for now, as info->revs
     +-	 * is not owned by 'struct path_walk_info'.
     +-	 */
     ++	if (info->pl) {
     ++		clear_pattern_list(info->pl);
     ++		free(info->pl);
     ++	}
     + }
      
       ## path-walk.h ##
      @@
     @@ t/helper/test-path-walk.c: int cmd__path_walk(int argc, const char **argv)
       }
      
       ## t/t5620-backfill.sh ##
     -@@ t/t5620-backfill.sh: test_expect_success 'do partial clone 2, backfill batch size' '
     +@@ t/t5620-backfill.sh: test_expect_success 'do partial clone 2, backfill min batch size' '
       	test_line_count = 0 revs2
       '
       
 5:  35a7e4ec4d3 ! 5:  1f765409eaf backfill: assume --sparse when sparse-checkout is enabled
     @@ builtin/backfill.c: int cmd_backfill(int argc, const char **argv, const char *pr
       }
      
       ## t/t5620-backfill.sh ##
     -@@ t/t5620-backfill.sh: test_expect_success 'do partial clone 2, backfill batch size' '
     +@@ t/t5620-backfill.sh: test_expect_success 'do partial clone 2, backfill min batch size' '
       	test_line_count = 0 revs2
       '
       

-- 
gitgitgadget
