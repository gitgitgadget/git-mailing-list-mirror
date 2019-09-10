Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.2 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 772541F463
	for <e@80x24.org>; Tue, 10 Sep 2019 14:00:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732988AbfIJOAa (ORCPT <rfc822;e@80x24.org>);
        Tue, 10 Sep 2019 10:00:30 -0400
Received: from mail-qk1-f193.google.com ([209.85.222.193]:42952 "EHLO
        mail-qk1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726634AbfIJOAa (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 10 Sep 2019 10:00:30 -0400
Received: by mail-qk1-f193.google.com with SMTP id f13so17084800qkm.9
        for <git@vger.kernel.org>; Tue, 10 Sep 2019 07:00:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=mmms6oXwd3+hYEDW1lzK9BUp1oIXKycbV+LO5orr4tM=;
        b=p0Zc9tmQP9a039oUWyDEThiE0QoVmZNN4+be02Rpym25m0ColUU5+iMk+MZLgbJ81j
         NBVxQM/uQc8Hl4dVKUJREd5x4eRoFieXPCc4DOymd7Sr0XcaOycTt+NlRz0s2G4pYbzt
         wtdgoB3I/hJYfBG72qvG1akLJh2iF1KJel1aUr5n3ALBR2BAz1jtmYmOlFE8Qgm/PnPp
         qQquMl4xWl4E3iAYr3rr5VsT09UKDoPDDL9Nbr9msUsIG5DfakmZ2zYN0Zin1u2Ykvh/
         gbaO2GRvbSCu/UNHl8ZLQ/AitWb9slQKfWFTGBZpVT8n/kx1w72o3/HOJlYnCfK0Rule
         L1pA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=mmms6oXwd3+hYEDW1lzK9BUp1oIXKycbV+LO5orr4tM=;
        b=ncklk+gGYvEcVl80yZciqwxZA3K0b1CObpWwX3aOiv1yyuokHxrqtQeHUcG4oK1qw7
         prvIswhCIeSokZvqgxfEriCAxJeOFh107opUEyayEHQZtqvwHTvCRs3AS5w9uEyRP8YD
         T4yw6jo77BQJr9hhGxv8GzvP+BVPpqaQCzyd1oBBOLZ218ilZq0/UbwisGuTnUmHczEY
         8Sue60ch2aKLNEcVGw4r81jpw+6HuNryRoZEBcPdFhY28xcvMA4rYgMsYZBm3fjbOPGs
         ULwq0+wr4hVJZeZgTOPoUqnXFLrEu5QyxAz9nRvPWfOwKYass9HZm5TJpcPgT2C6qy5N
         J+Tw==
X-Gm-Message-State: APjAAAWF+PAwPy3Hsa9RaE8VN0zo9YtEdBNkKwk1b7mW2tC+HmRSsMOZ
        j6kEyrELkD6KB94rh8sF4Pzd5DZT
X-Google-Smtp-Source: APXvYqzdx4RT+lN/b8F47XaR77DWQfg67Ofop/pCqhBPhP816PbEnjPWsakghQO18Ig3/OYr2HmnXA==
X-Received: by 2002:a05:620a:659:: with SMTP id a25mr28942364qka.151.1568124029202;
        Tue, 10 Sep 2019 07:00:29 -0700 (PDT)
Received: from ?IPv6:2001:4898:6808:13e:a969:10f8:f485:d375? ([2001:4898:a800:1012:5a9d:10f8:f485:d375])
        by smtp.gmail.com with ESMTPSA id h7sm5844405qto.16.2019.09.10.07.00.28
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 10 Sep 2019 07:00:28 -0700 (PDT)
Subject: Re: [PATCH v2 0/1] commit-graph: add --[no-]progress to write and
 verify
To:     Garima Singh via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>
References: <pull.315.git.gitgitgadget@gmail.com>
 <pull.315.v2.git.gitgitgadget@gmail.com>
From:   Garima Singh <garimasigit@gmail.com>
Message-ID: <c32f1bb4-9d98-eb27-33c2-251417c2da55@gmail.com>
Date:   Tue, 10 Sep 2019 10:00:29 -0400
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.0
MIME-Version: 1.0
In-Reply-To: <pull.315.v2.git.gitgitgadget@gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Ping :) Any more comments or concerns about this?

On 8/26/2019 12:29 PM, Garima Singh via GitGitGadget wrote:
> Hey Git contributors!
> 
> My name is Garima Singh and I work at Microsoft. I recently started working
> closely with the Microsoft team contributing to the git client ecosystem. I
> am very glad to have the opportunity to work with this community. I am new
> to the world of git client development but I did work on the Git service
> offering of Azure Developer Services for a few years. I am sure I will get
> to learn a lot from all of you.
> 
> Dr. Derrick Stolee helped me pick out my first task (Thanks Stolee!) He
> mentioned an issue in the commit-graph builtin where git did not support
> opting in and out of the progress output. This was bloating up the stderr
> logs in VFS for Git. The progress feature was introduced in 7b0f229222
> ("commit-graph write: add progress output", 2018-09-17) but the ability to
> opt-out was overlooked. This patch adds the --no-progress option so that
> callers can control the amount of logging they receive.
> 
> Looking forward to your review. Cheers! Garima Singh
> 
> CC: stolee@gmail.com, avarab@gmail.com, garimasigit@gmail.com
> 
> Garima Singh (1):
>    commit-graph: add --[no-]progress to write and verify.
> 
>   Documentation/git-commit-graph.txt |  7 ++++--
>   builtin/commit-graph.c             | 21 ++++++++++++-----
>   commit-graph.c                     |  6 +++--
>   t/t5318-commit-graph.sh            | 36 ++++++++++++++++++++++++++++++
>   t/t5324-split-commit-graph.sh      |  2 +-
>   5 files changed, 61 insertions(+), 11 deletions(-)
> 
> 
> base-commit: 745f6812895b31c02b29bdfe4ae8e5498f776c26
> Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-315%2Fgarimasi514%2FcoreGit-commit-graph-progress-toggle-v2
> Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-315/garimasi514/coreGit-commit-graph-progress-toggle-v2
> Pull-Request: https://github.com/gitgitgadget/git/pull/315
> 
> Range-diff vs v1:
> 
>   1:  da89f7dadb ! 1:  47cc99bd15 commit-graph: add --[no-]progress to write and verify.
>       @@ -17,16 +17,19 @@
>         [verse]
>         'git commit-graph read' [--object-dir <dir>]
>        -'git commit-graph verify' [--object-dir <dir>] [--shallow]
>       +-'git commit-graph write' <options> [--object-dir <dir>]
>        +'git commit-graph verify' [--object-dir <dir>] [--shallow] [--[no-]progress]
>       - 'git commit-graph write' <options> [--object-dir <dir>]
>       ++'git commit-graph write' <options> [--object-dir <dir>] [--[no-]progress]
>         
>         
>       + DESCRIPTION
>        @@
>         	commit-graph file is expected to be in the `<dir>/info` directory and
>         	the packfiles are expected to be in `<dir>/pack`.
>         
>        +--[no-]progress::
>       -+	Toggle whether to show progress or not.
>       ++	Turn progress on/off explicitly. If neither is specified, progress is
>       ++	shown if standard error is connected to a terminal.
>         
>         COMMANDS
>         --------
>       @@ -35,11 +38,6 @@
>         --- a/builtin/commit-graph.c
>         +++ b/builtin/commit-graph.c
>        @@
>       - #include "repository.h"
>       - #include "commit-graph.h"
>       - #include "object-store.h"
>       -+#include "unistd.h"
>       -
>         static char const * const builtin_commit_graph_usage[] = {
>         	N_("git commit-graph [--object-dir <objdir>]"),
>         	N_("git commit-graph read [--object-dir <objdir>]"),
>       @@ -74,15 +72,6 @@
>         
>         static int graph_verify(int argc, const char **argv)
>        @@
>       - 	int fd;
>       - 	struct stat st;
>       - 	int flags = 0;
>       --
>       -+	int defaultProgressState = isatty(2);
>       -+	
>       - 	static struct option builtin_commit_graph_verify_options[] = {
>       - 		OPT_STRING(0, "object-dir", &opts.obj_dir,
>       - 			   N_("dir"),
>         			   N_("The object directory to store the graph")),
>         		OPT_BOOL(0, "shallow", &opts.shallow,
>         			 N_("if the commit-graph is split, only verify the tip file")),
>       @@ -90,8 +79,7 @@
>         		OPT_END(),
>         	};
>         
>       -+	opts.progress = defaultProgressState;
>       -+	
>       ++	opts.progress = isatty(2);
>         	argc = parse_options(argc, argv, NULL,
>         			     builtin_commit_graph_verify_options,
>         			     builtin_commit_graph_verify_usage, 0);
>       @@ -101,7 +89,7 @@
>         		flags |= COMMIT_GRAPH_VERIFY_SHALLOW;
>        -
>        +	if (opts.progress)
>       -+		flags |= COMMIT_GRAPH_PROGRESS;
>       ++		flags |= COMMIT_GRAPH_WRITE_PROGRESS;
>        +	
>         	graph_name = get_commit_graph_filename(opts.obj_dir);
>         	open_ok = open_commit_graph(graph_name, &fd, &st);
>       @@ -110,14 +98,11 @@
>         	struct string_list *commit_hex = NULL;
>         	struct string_list lines;
>         	int result = 0;
>       --	unsigned int flags = COMMIT_GRAPH_PROGRESS;
>       --
>       -+	unsigned int flags = 0;
>       -+	int defaultProgressState = isatty(2);
>       -+	
>       +-	enum commit_graph_write_flags flags = COMMIT_GRAPH_WRITE_PROGRESS;
>       ++	enum commit_graph_write_flags flags = 0;
>       +
>         	static struct option builtin_commit_graph_write_options[] = {
>         		OPT_STRING(0, "object-dir", &opts.obj_dir,
>       - 			N_("dir"),
>        @@
>         			N_("start walk at commits listed by stdin")),
>         		OPT_BOOL(0, "append", &opts.append,
>       @@ -130,16 +115,16 @@
>         		OPT_END(),
>         	};
>         
>       -+	opts.progress = defaultProgressState;
>       ++	opts.progress = isatty(2);
>         	split_opts.size_multiple = 2;
>         	split_opts.max_commits = 0;
>         	split_opts.expire_time = 0;
>        @@
>       - 		flags |= COMMIT_GRAPH_APPEND;
>       + 		flags |= COMMIT_GRAPH_WRITE_APPEND;
>         	if (opts.split)
>       - 		flags |= COMMIT_GRAPH_SPLIT;
>       + 		flags |= COMMIT_GRAPH_WRITE_SPLIT;
>        +	if (opts.progress)
>       -+		flags |= COMMIT_GRAPH_PROGRESS;
>       ++		flags |= COMMIT_GRAPH_WRITE_PROGRESS;
>         
>         	read_replace_refs = 0;
>         
>       @@ -153,20 +138,13 @@
>         
>        -	progress = start_progress(_("Verifying commits in commit graph"),
>        -				  g->num_commits);
>       -+	if (flags & COMMIT_GRAPH_PROGRESS)
>       ++	if (flags & COMMIT_GRAPH_WRITE_PROGRESS)
>        +		progress = start_progress(_("Verifying commits in commit graph"),
>        +					g->num_commits);
>        +
>         	for (i = 0; i < g->num_commits; i++) {
>         		struct commit *graph_commit, *odb_commit;
>         		struct commit_list *graph_parents, *odb_parents;
>       - 		uint32_t max_generation = 0;
>       -
>       - 		display_progress(progress, i + 1);
>       -+
>       - 		hashcpy(cur_oid.hash, g->chunk_oid_lookup + g->hash_len * i);
>       -
>       - 		graph_commit = lookup_commit(r, &cur_oid);
>        
>         diff --git a/t/t5318-commit-graph.sh b/t/t5318-commit-graph.sh
>         --- a/t/t5318-commit-graph.sh
>       @@ -175,7 +153,7 @@
>         	git repack
>         '
>         
>       -+test_expect_success 'commit-graph write progress off by default for stderr' '
>       ++test_expect_success 'commit-graph write progress off for redirected stderr' '
>        +	cd "$TRASH_DIRECTORY/full" &&
>        +	git commit-graph write 2>err &&
>        +	test_line_count = 0 err
>       @@ -193,7 +171,7 @@
>        +	test_line_count = 0 err
>        +'
>        +
>       -+test_expect_success 'commit-graph verify progress off by default for stderr' '
>       ++test_expect_success 'commit-graph verify progress off for redirected stderr' '
>        +	cd "$TRASH_DIRECTORY/full" &&
>        +	git commit-graph verify 2>err &&
>        +	test_line_count = 0 err
> 
