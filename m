Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 41F231F461
	for <e@80x24.org>; Mon, 26 Aug 2019 16:30:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732835AbfHZQaC (ORCPT <rfc822;e@80x24.org>);
        Mon, 26 Aug 2019 12:30:02 -0400
Received: from mail-wr1-f67.google.com ([209.85.221.67]:33595 "EHLO
        mail-wr1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728559AbfHZQaB (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 26 Aug 2019 12:30:01 -0400
Received: by mail-wr1-f67.google.com with SMTP id u16so15967329wrr.0
        for <git@vger.kernel.org>; Mon, 26 Aug 2019 09:29:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:message-id:in-reply-to:references:from:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=2o00LBifrX34qhOLTUEFckd6l8pItCB5P2RXGZBX37I=;
        b=juhf4l+UCnrye82pF3cS3ouIpGhcXdsQdfW/m+PJmcag5cp15HiOMMyfxLoUlH7XPv
         b1njwfEuH7dOiW1iGXPYOv6WdLHCJqvpzy+7KYz4lhQZCA9hq5sXaoAGaQhiblkTJPn8
         hH2Xs+34RAgvdTH5OQodj0anNUJKJ3iDMVrVgPlE7gGkoXkW3XfZpkESe9FAYYLibgb9
         A8QzrzuMeBd37NkC4j1fPVUMxjdKIpdfqLrHa/IhWPXoaInb2M5xD3j+/7h/O0XfIL4N
         fxyWP5f8bni6NMQgmHEQqjRUswyxD0CuyXhHhDy6B4BnBDANDMnYT+wdhGMUYlNLvbTe
         vZRA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:message-id:in-reply-to:references:from
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=2o00LBifrX34qhOLTUEFckd6l8pItCB5P2RXGZBX37I=;
        b=AYX+yhCJO0l4Mf8gz+E1qosWVifQHW0Ji+H/ILBF+qiXg+/rSMaMrsb4pruRHqFl5M
         2N4gp+gTSbeUacA2Ud3dxFpp3OyfWLeRusiGX/+0M2VidpTdg+iGCw1kMcvjpPVlKmb0
         OixLKXg5BupNebenxVpBnYOjSDAqcLMHA7g/kjWFb1wCiMzqs8dgHfvwVhgnxgSGFKds
         Sm0pm96yxeG6zuUSURjUE2B584odX3/d0b4M4YDm8ZSORz5zSJej5XKSmgcXNg3roVq6
         c4TnhHiN3681UUcYP7kv092dT6wiYGHafY1o9RZaiDZnNjn7K+A+zmlh7okJbkEubX2T
         mrwA==
X-Gm-Message-State: APjAAAUDsrNMwSnnP73Y36d41iO30duQ9OgN4jaZkLKz2syjOUWMreQ4
        wKMvHVh6sritIu9pJmmO+12Cu+XqehI=
X-Google-Smtp-Source: APXvYqxtS45ONd7b5oDDCIk8dvReCg5PxlIjcq6lEVih2Ov2f1H9EvXIRJjOEfYsUDHjNPHOvSLDGA==
X-Received: by 2002:adf:a54d:: with SMTP id j13mr22777562wrb.261.1566836998486;
        Mon, 26 Aug 2019 09:29:58 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id s19sm22231795wrb.94.2019.08.26.09.29.57
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 26 Aug 2019 09:29:58 -0700 (PDT)
Date:   Mon, 26 Aug 2019 09:29:58 -0700 (PDT)
X-Google-Original-Date: Mon, 26 Aug 2019 16:29:56 GMT
Message-Id: <pull.315.v2.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.315.git.gitgitgadget@gmail.com>
References: <pull.315.git.gitgitgadget@gmail.com>
From:   "Garima Singh via GitGitGadget" <gitgitgadget@gmail.com>
Subject: [PATCH v2 0/1] commit-graph: add --[no-]progress to write and verify
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hey Git contributors! 

My name is Garima Singh and I work at Microsoft. I recently started working
closely with the Microsoft team contributing to the git client ecosystem. I
am very glad to have the opportunity to work with this community. I am new
to the world of git client development but I did work on the Git service
offering of Azure Developer Services for a few years. I am sure I will get
to learn a lot from all of you. 

Dr. Derrick Stolee helped me pick out my first task (Thanks Stolee!) He
mentioned an issue in the commit-graph builtin where git did not support
opting in and out of the progress output. This was bloating up the stderr
logs in VFS for Git. The progress feature was introduced in 7b0f229222
("commit-graph write: add progress output", 2018-09-17) but the ability to
opt-out was overlooked. This patch adds the --no-progress option so that
callers can control the amount of logging they receive. 

Looking forward to your review. Cheers! Garima Singh

CC: stolee@gmail.com, avarab@gmail.com, garimasigit@gmail.com

Garima Singh (1):
  commit-graph: add --[no-]progress to write and verify.

 Documentation/git-commit-graph.txt |  7 ++++--
 builtin/commit-graph.c             | 21 ++++++++++++-----
 commit-graph.c                     |  6 +++--
 t/t5318-commit-graph.sh            | 36 ++++++++++++++++++++++++++++++
 t/t5324-split-commit-graph.sh      |  2 +-
 5 files changed, 61 insertions(+), 11 deletions(-)


base-commit: 745f6812895b31c02b29bdfe4ae8e5498f776c26
Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-315%2Fgarimasi514%2FcoreGit-commit-graph-progress-toggle-v2
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-315/garimasi514/coreGit-commit-graph-progress-toggle-v2
Pull-Request: https://github.com/gitgitgadget/git/pull/315

Range-diff vs v1:

 1:  da89f7dadb ! 1:  47cc99bd15 commit-graph: add --[no-]progress to write and verify.
     @@ -17,16 +17,19 @@
       [verse]
       'git commit-graph read' [--object-dir <dir>]
      -'git commit-graph verify' [--object-dir <dir>] [--shallow]
     +-'git commit-graph write' <options> [--object-dir <dir>]
      +'git commit-graph verify' [--object-dir <dir>] [--shallow] [--[no-]progress]
     - 'git commit-graph write' <options> [--object-dir <dir>]
     ++'git commit-graph write' <options> [--object-dir <dir>] [--[no-]progress]
       
       
     + DESCRIPTION
      @@
       	commit-graph file is expected to be in the `<dir>/info` directory and
       	the packfiles are expected to be in `<dir>/pack`.
       
      +--[no-]progress::
     -+	Toggle whether to show progress or not.
     ++	Turn progress on/off explicitly. If neither is specified, progress is 
     ++	shown if standard error is connected to a terminal.
       
       COMMANDS
       --------
     @@ -35,11 +38,6 @@
       --- a/builtin/commit-graph.c
       +++ b/builtin/commit-graph.c
      @@
     - #include "repository.h"
     - #include "commit-graph.h"
     - #include "object-store.h"
     -+#include "unistd.h"
     - 
       static char const * const builtin_commit_graph_usage[] = {
       	N_("git commit-graph [--object-dir <objdir>]"),
       	N_("git commit-graph read [--object-dir <objdir>]"),
     @@ -74,15 +72,6 @@
       
       static int graph_verify(int argc, const char **argv)
      @@
     - 	int fd;
     - 	struct stat st;
     - 	int flags = 0;
     --
     -+	int defaultProgressState = isatty(2);
     -+	
     - 	static struct option builtin_commit_graph_verify_options[] = {
     - 		OPT_STRING(0, "object-dir", &opts.obj_dir,
     - 			   N_("dir"),
       			   N_("The object directory to store the graph")),
       		OPT_BOOL(0, "shallow", &opts.shallow,
       			 N_("if the commit-graph is split, only verify the tip file")),
     @@ -90,8 +79,7 @@
       		OPT_END(),
       	};
       
     -+	opts.progress = defaultProgressState;
     -+	
     ++	opts.progress = isatty(2);
       	argc = parse_options(argc, argv, NULL,
       			     builtin_commit_graph_verify_options,
       			     builtin_commit_graph_verify_usage, 0);
     @@ -101,7 +89,7 @@
       		flags |= COMMIT_GRAPH_VERIFY_SHALLOW;
      -
      +	if (opts.progress)
     -+		flags |= COMMIT_GRAPH_PROGRESS;
     ++		flags |= COMMIT_GRAPH_WRITE_PROGRESS;
      +	
       	graph_name = get_commit_graph_filename(opts.obj_dir);
       	open_ok = open_commit_graph(graph_name, &fd, &st);
     @@ -110,14 +98,11 @@
       	struct string_list *commit_hex = NULL;
       	struct string_list lines;
       	int result = 0;
     --	unsigned int flags = COMMIT_GRAPH_PROGRESS;
     --
     -+	unsigned int flags = 0;
     -+	int defaultProgressState = isatty(2);
     -+	
     +-	enum commit_graph_write_flags flags = COMMIT_GRAPH_WRITE_PROGRESS;
     ++	enum commit_graph_write_flags flags = 0;
     + 
       	static struct option builtin_commit_graph_write_options[] = {
       		OPT_STRING(0, "object-dir", &opts.obj_dir,
     - 			N_("dir"),
      @@
       			N_("start walk at commits listed by stdin")),
       		OPT_BOOL(0, "append", &opts.append,
     @@ -130,16 +115,16 @@
       		OPT_END(),
       	};
       
     -+	opts.progress = defaultProgressState;
     ++	opts.progress = isatty(2);
       	split_opts.size_multiple = 2;
       	split_opts.max_commits = 0;
       	split_opts.expire_time = 0;
      @@
     - 		flags |= COMMIT_GRAPH_APPEND;
     + 		flags |= COMMIT_GRAPH_WRITE_APPEND;
       	if (opts.split)
     - 		flags |= COMMIT_GRAPH_SPLIT;
     + 		flags |= COMMIT_GRAPH_WRITE_SPLIT;
      +	if (opts.progress)
     -+		flags |= COMMIT_GRAPH_PROGRESS;
     ++		flags |= COMMIT_GRAPH_WRITE_PROGRESS;
       
       	read_replace_refs = 0;
       
     @@ -153,20 +138,13 @@
       
      -	progress = start_progress(_("Verifying commits in commit graph"),
      -				  g->num_commits);
     -+	if (flags & COMMIT_GRAPH_PROGRESS)
     ++	if (flags & COMMIT_GRAPH_WRITE_PROGRESS)
      +		progress = start_progress(_("Verifying commits in commit graph"),
      +					g->num_commits);
      +
       	for (i = 0; i < g->num_commits; i++) {
       		struct commit *graph_commit, *odb_commit;
       		struct commit_list *graph_parents, *odb_parents;
     - 		uint32_t max_generation = 0;
     - 
     - 		display_progress(progress, i + 1);
     -+
     - 		hashcpy(cur_oid.hash, g->chunk_oid_lookup + g->hash_len * i);
     - 
     - 		graph_commit = lookup_commit(r, &cur_oid);
      
       diff --git a/t/t5318-commit-graph.sh b/t/t5318-commit-graph.sh
       --- a/t/t5318-commit-graph.sh
     @@ -175,7 +153,7 @@
       	git repack
       '
       
     -+test_expect_success 'commit-graph write progress off by default for stderr' '
     ++test_expect_success 'commit-graph write progress off for redirected stderr' '
      +	cd "$TRASH_DIRECTORY/full" &&
      +	git commit-graph write 2>err &&
      +	test_line_count = 0 err
     @@ -193,7 +171,7 @@
      +	test_line_count = 0 err
      +'
      +
     -+test_expect_success 'commit-graph verify progress off by default for stderr' '
     ++test_expect_success 'commit-graph verify progress off for redirected stderr' '
      +	cd "$TRASH_DIRECTORY/full" &&
      +	git commit-graph verify 2>err &&
      +	test_line_count = 0 err

-- 
gitgitgadget
