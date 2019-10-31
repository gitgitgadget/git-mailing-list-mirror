Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-9.2 required=3.0 tests=AWL,BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,FSL_HELO_FAKE,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE,USER_IN_DEF_DKIM_WL shortcircuit=no
	autolearn=no autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 653F51F4C0
	for <e@80x24.org>; Thu, 31 Oct 2019 00:39:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728113AbfJaAji (ORCPT <rfc822;e@80x24.org>);
        Wed, 30 Oct 2019 20:39:38 -0400
Received: from mail-pl1-f196.google.com ([209.85.214.196]:46143 "EHLO
        mail-pl1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726713AbfJaAji (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 30 Oct 2019 20:39:38 -0400
Received: by mail-pl1-f196.google.com with SMTP id q21so1817750plr.13
        for <git@vger.kernel.org>; Wed, 30 Oct 2019 17:39:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=YX5RQ4rbVe1w0rh7p9S3QB1EaliH5aYbS9A+p0Euc9E=;
        b=vGPiUYrHD9/wRr/NGwHASvwZWn47FiVLmqyinLTt+TqvH6WBt8pDEmm2j/6TIC7tZX
         1bEYoe74JyA0o2S05d8H/y4KvNgTrsm156wY+2bw34HpoGSqpAQ+gc39RUCDWnKd6I/q
         OstWCbVD4C4YyJwkWR7/T8WAi6GwQRt/6DEMKLvWny/IVaQMW5aBQEXCYEMFlZfKqQOK
         3BsspdDvO5SeJaphAVtk5zB1yvt7kd0U+7BPB8BTX6s+fBJK39EmfjiX6dkzvc6pgYnx
         CWR0wxFDribQ0EFDP6sGYU2j/eCR7+Vcs43waa2EBMJfCMI0tdWdz+s9eXcomfDkUqlu
         K/Hg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=YX5RQ4rbVe1w0rh7p9S3QB1EaliH5aYbS9A+p0Euc9E=;
        b=L1nZiKrGLiGvKdapC10jb+v0oXi8rB2ejIxfdjTL6dSFc5bnGmkdOiJhYBx0dOlze9
         rAP8NOhj414pA+2Pcf5QEbQ9+XlkdbFTE/andXyxl7bP8UMwxCDUkqlCociBirnuWZpR
         ErDI1UvHpF02+ZWiz9OUo8iOky3LcY6eP1bFKt6a8NZFGlLolZl048sAcj2uZg0gS1xS
         sebNeXh03dWVATS6Sm6Uek+deSZ6petSRTI4Nz4zPRr0Gc3/PHoOJACvPQPTfD2yl+n+
         b8vyKf5e0mGul/10VHlzz9MKDxUc/ylQXHaJrUtpc9y/e+rymwNHYYBcVCRKYf6f/3NS
         7Smw==
X-Gm-Message-State: APjAAAVb3XsCpBToUkaYbzsRr6Kb1AaL4A015RpzHVe4UM2XayLuLlFx
        C+8vgrEfmdx7AQOOce+8BWNiYw==
X-Google-Smtp-Source: APXvYqwXFpO911+LXgpTeAWx3yH0X2L6JsPWpr01weLj4q3DZ5fcP/lrp5PZAQA4VtNfFwqkCb+bEw==
X-Received: by 2002:a17:902:9882:: with SMTP id s2mr2999148plp.101.1572482374808;
        Wed, 30 Oct 2019 17:39:34 -0700 (PDT)
Received: from google.com ([2620:15c:2ce:0:231c:11cc:aa0a:6dc5])
        by smtp.gmail.com with ESMTPSA id a16sm1124358pfa.53.2019.10.30.17.39.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 30 Oct 2019 17:39:34 -0700 (PDT)
Date:   Wed, 30 Oct 2019 17:39:29 -0700
From:   Emily Shaffer <emilyshaffer@google.com>
To:     Matthew DeVore <matvore@google.com>
Cc:     git@vger.kernel.org, Matthew DeVore <matvore@gmail.com>,
        matvore@comcast.net, jonathantanmy@google.com, jrnieder@gmail.com,
        steadmon@google.com
Subject: Re: [RFC] xl command for visualizing recent history
Message-ID: <20191031003929.GA22855@google.com>
References: <20191029003023.122196-1-matvore@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191029003023.122196-1-matvore@google.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Oct 28, 2019 at 05:30:23PM -0700, Matthew DeVore wrote:
> From: Matthew DeVore <matvore@gmail.com>

Hi Matthew,

Good to hear from you. One comment - the subject of your mail is "[RFC]"
but I think folks are used to receiving mails with RFC patches if the
subject line is formatted like it comes out of 'git format-patch' - that
is, [RFC PATCH].

> 
> "git xl" shows a graph of recent history, including all existing
> branches (unless flagged with a config option) and their upstream
> counterparts.  It is named such because it is easy to type and the
> letter "x" looks like a small graph.

For me, that's not a very compelling reason to name something, and the
only command with such a cryptic name in Git that I can think of is 'git
am'. (mv, gc, rm, and p4 are somewhat self explanatory, and everything
else besides 'gitk' is named with a full word.)

> 
> Like "git branch" it supports filtering the branches shown via
> positional arguments.
> 
> Besides just showing the graph, it also associates refs with all visible
> commits with names in the form of "h/#" where # is an incrementing
> index. After showing the graph, these refs can be used to ergonomically
> invoke some follow-up command like rebase or diff.

It looks like there's a decent amount of this commit message which
really ought to be a note to the reviewers instead. Everything above the
'---' goes into the commit message; everything below it will get
scrubbed when the patch is applied, so you can give more casual notes
there - for example this paragraph, as well as "Omissions I might/will
fix".

> The test cases show non-trivial output which can be used to get an idea
> for what the command is good for, though it doesn't capture the
> coloring.
> 
> The primary goals of this command are:
> 
>  a) deduce what the user wants to see based on what they haven't pushed
>     upstream yet
>  b) show the active branches spatially rather than as a linear list (as
>     in "git branch")
>  c) allow the user to easily refer to commits that appeared in the
>     output
> 
> I considered making the h/# tags stable across invocations such that a
> particular hash will only be tagged with a different number if ~100
> other hashes are tagged since the hash was last tagged. I didn't
> actually implement it this way, instead opting for always re-numbering
> the hashes on each invocation. This means the hash number is
> predictable based on the position the hash appears in the output, which
> is probably better that encouraging users to memorize hash numbers (or
> use them in scripts!).

If you're worried about folks using something like this in a script (and
I would be, given that it's dynamically assigning nicknames to hashes)
then you probably ought to mark it as a porcelain command in
command-list.txt.

> 
> Omissions I might/will fix depending on feedback:
> 
>  a) rather than show HEAD in the graph, show <checked_out_branch> when
>     possible (i.e. "[<master>]" rather than "[HEAD master]").
> 
>  b) don't parse output from `git log` but instead do everything
>     in-process.
> 
>  c) documentation

Sorry not to review the rest of the diff today; I'll try to get to it
sometime soon.

 - Emily

> ---
>  Makefile      |   1 +
>  builtin.h     |   1 +
>  git.c         |   1 +
>  t/t4400-xl.sh | 270 ++++++++++++++++++++++++++++
>  xl.c          | 485 ++++++++++++++++++++++++++++++++++++++++++++++++++
>  5 files changed, 758 insertions(+)
>  create mode 100755 t/t4400-xl.sh
>  create mode 100644 xl.c
> 
> diff --git a/Makefile b/Makefile
> index 03b800da0c..491661f848 100644
> --- a/Makefile
> +++ b/Makefile
> @@ -1022,20 +1022,21 @@ LIB_OBJS += varint.o
>  LIB_OBJS += version.o
>  LIB_OBJS += versioncmp.o
>  LIB_OBJS += walker.o
>  LIB_OBJS += wildmatch.o
>  LIB_OBJS += worktree.o
>  LIB_OBJS += wrapper.o
>  LIB_OBJS += write-or-die.o
>  LIB_OBJS += ws.o
>  LIB_OBJS += wt-status.o
>  LIB_OBJS += xdiff-interface.o
> +LIB_OBJS += xl.o
>  LIB_OBJS += zlib.o
>  
>  BUILTIN_OBJS += builtin/add.o
>  BUILTIN_OBJS += builtin/am.o
>  BUILTIN_OBJS += builtin/annotate.o
>  BUILTIN_OBJS += builtin/apply.o
>  BUILTIN_OBJS += builtin/archive.o
>  BUILTIN_OBJS += builtin/bisect--helper.o
>  BUILTIN_OBJS += builtin/blame.o
>  BUILTIN_OBJS += builtin/branch.o
> diff --git a/builtin.h b/builtin.h
> index 5cf5df69f7..568d09cf7f 100644
> --- a/builtin.h
> +++ b/builtin.h
> @@ -241,16 +241,17 @@ int cmd_update_server_info(int argc, const char **argv, const char *prefix);
>  int cmd_upload_archive(int argc, const char **argv, const char *prefix);
>  int cmd_upload_archive_writer(int argc, const char **argv, const char *prefix);
>  int cmd_upload_pack(int argc, const char **argv, const char *prefix);
>  int cmd_var(int argc, const char **argv, const char *prefix);
>  int cmd_verify_commit(int argc, const char **argv, const char *prefix);
>  int cmd_verify_tag(int argc, const char **argv, const char *prefix);
>  int cmd_version(int argc, const char **argv, const char *prefix);
>  int cmd_whatchanged(int argc, const char **argv, const char *prefix);
>  int cmd_worktree(int argc, const char **argv, const char *prefix);
>  int cmd_write_tree(int argc, const char **argv, const char *prefix);
> +int cmd_xl(int argc, const char **argv, const char *prefix);
>  int cmd_verify_pack(int argc, const char **argv, const char *prefix);
>  int cmd_show_ref(int argc, const char **argv, const char *prefix);
>  int cmd_pack_refs(int argc, const char **argv, const char *prefix);
>  int cmd_replace(int argc, const char **argv, const char *prefix);
>  
>  #endif
> diff --git a/git.c b/git.c
> index ce6ab0ece2..4a1da83a7e 100644
> --- a/git.c
> +++ b/git.c
> @@ -594,20 +594,21 @@ static struct cmd_struct commands[] = {
>  	{ "upload-archive--writer", cmd_upload_archive_writer, NO_PARSEOPT },
>  	{ "upload-pack", cmd_upload_pack },
>  	{ "var", cmd_var, RUN_SETUP_GENTLY | NO_PARSEOPT },
>  	{ "verify-commit", cmd_verify_commit, RUN_SETUP },
>  	{ "verify-pack", cmd_verify_pack },
>  	{ "verify-tag", cmd_verify_tag, RUN_SETUP },
>  	{ "version", cmd_version },
>  	{ "whatchanged", cmd_whatchanged, RUN_SETUP },
>  	{ "worktree", cmd_worktree, RUN_SETUP | NO_PARSEOPT },
>  	{ "write-tree", cmd_write_tree, RUN_SETUP },
> +	{ "xl", cmd_xl, RUN_SETUP },
>  };
>  
>  static struct cmd_struct *get_builtin(const char *s)
>  {
>  	int i;
>  	for (i = 0; i < ARRAY_SIZE(commands); i++) {
>  		struct cmd_struct *p = commands + i;
>  		if (!strcmp(s, p->cmd))
>  			return p;
>  	}
> diff --git a/t/t4400-xl.sh b/t/t4400-xl.sh
> new file mode 100755
> index 0000000000..f6e35bd4da
> --- /dev/null
> +++ b/t/t4400-xl.sh
> @@ -0,0 +1,270 @@
> +#!/bin/sh
> +
> +test_description='git xl'
> +. ./test-lib.sh
> +
> +xl () {
> +	git xl "$@" >actual_raw &&
> +	sed -e "s/ *$//" actual_raw
> +}
> +
> +test_expect_success 'basic' '
> +	test_commit foo &&
> +	git checkout -b branch2 &&
> +	test_commit bar &&
> +
> +	xl >actual &&
> +	hashvl1=$(git rev-parse h/1 | test_copy_bytes 8) &&
> +	hashvl2=$(git rev-parse h/2 | test_copy_bytes 8) &&
> +
> +	echo "\
> +$hashvl1  *  1   committer@example.com  [HEAD branch2]
> +          | bar
> +          |
> +$hashvl2  *  2   committer@example.com  [master]
> +            foo
> +" >expect &&
> +	test_cmp expect actual
> +'
> +
> +test_expect_success 'specify ref names' '
> +	xl master >actual &&
> +
> +	hashvl1=$(git rev-parse h/1 | test_copy_bytes 8) &&
> +	hashvl2=$(git rev-parse h/2 | test_copy_bytes 8) &&
> +
> +	echo "\
> +$hashvl1  *  1   committer@example.com  [HEAD]
> +          | bar
> +          |
> +$hashvl2  *  2   committer@example.com  [master]
> +            foo
> +" >expect &&
> +	test_cmp expect actual
> +'
> +
> +test_expect_success 'deduce graph base' '
> +	git checkout -b branch3 master &&
> +	test_commit baz &&
> +	git branch -d master &&
> +	xl >actual &&
> +
> +	hashvl1=$(git rev-parse h/1 | test_copy_bytes 8) &&
> +	hashvl2=$(git rev-parse h/2 | test_copy_bytes 8) &&
> +	xl_base=$(git rev-parse xl_base | test_copy_bytes 8) &&
> +
> +	echo "\
> +$hashvl1  *  1   committer@example.com  [HEAD branch3]
> +          | baz
> +          |
> +$hashvl2  | *  2   committer@example.com  [branch2]
> +          |/  bar
> +          |
> +$xl_base  *  3   committer@example.com
> +            foo
> +" >expect &&
> +	test_cmp expect actual
> +'
> +
> +test_expect_success 'show upstream branch' '
> +	git init --bare upstream_repo.git &&
> +	git remote add upstream_repo upstream_repo.git &&
> +
> +	git push -u upstream_repo HEAD &&
> +	git branch --set-upstream-to=upstream_repo/branch3 &&
> +	test_commit not_yet_pushed &&
> +
> +	# Exclude branch2 by requesting at least one other ref explicitly.
> +	xl branch3 >actual &&
> +
> +	hashvl1=$(git rev-parse h/1 | test_copy_bytes 8) &&
> +	hashvl2=$(git rev-parse h/2 | test_copy_bytes 8) &&
> +
> +	echo "\
> +$hashvl1  *  1   committer@example.com  [HEAD branch3]
> +          | not_yet_pushed
> +          |
> +$hashvl2  *  2   committer@example.com  [upstream_repo/branch3]
> +            baz
> +" >expect &&
> +	test_cmp expect actual
> +'
> +
> +test_expect_success 'de-dupe upstream branches' '
> +	git checkout -b branch4 upstream_repo/branch3 &&
> +	test_commit baz4 &&
> +
> +	# Make sure we do not show the same upstream branch name twice
> +	# even though two local branches share the same upstream branch.
> +	xl >actual &&
> +
> +	hashvl1=$(git rev-parse h/1 | test_copy_bytes 8) &&
> +	hashvl2=$(git rev-parse h/2 | test_copy_bytes 8) &&
> +	hashvl3=$(git rev-parse h/3 | test_copy_bytes 8) &&
> +	hashvl4=$(git rev-parse h/4 | test_copy_bytes 8) &&
> +	hashvl5=$(git rev-parse h/5 | test_copy_bytes 8) &&
> +
> +	echo "\
> +$hashvl1  *  1   committer@example.com  [HEAD branch4]
> +          | baz4
> +          |
> +$hashvl2  | *  2   committer@example.com  [branch3]
> +          |/  not_yet_pushed
> +          |
> +$hashvl3  *  3   committer@example.com  [upstream_repo/branch3]
> +          | baz
> +          |
> +$hashvl4  | *  4   committer@example.com  [branch2]
> +          |/  bar
> +          |
> +$hashvl5  *  5   committer@example.com
> +            foo
> +" >expect &&
> +	test_cmp expect actual
> +'
> +
> +test_expect_success 'multiple merge bases' '
> +	git merge -m merge1 branch3 &&
> +	test_commit baz5 &&
> +
> +	git checkout branch3 &&
> +	git merge -m merge2 h/1 &&
> +	test_commit baz6 &&
> +
> +	git branch --unset-upstream branch3 &&
> +	xl branch3 branch4 >actual &&
> +
> +	hashvl1=$(git rev-parse h/1 | test_copy_bytes 8) &&
> +	hashvl2=$(git rev-parse h/2 | test_copy_bytes 8) &&
> +	hashvl3=$(git rev-parse h/3 | test_copy_bytes 8) &&
> +	hashvl4=$(git rev-parse h/4 | test_copy_bytes 8) &&
> +	hashvl5=$(git rev-parse h/5 | test_copy_bytes 8) &&
> +	hashvl6=$(git rev-parse h/6 | test_copy_bytes 8) &&
> +
> +	echo "\
> +$hashvl1  *  1   committer@example.com  [HEAD branch3]
> +          | baz6
> +          |
> +$hashvl2  *    2   committer@example.com
> +          |\  merge2
> +          | |
> +$hashvl3  | | *  3   committer@example.com  [branch4]
> +          | | | baz5
> +          | | |
> +$hashvl4  | | *    4   committer@example.com
> +          | | |\  merge1
> +          | |/ /
> +          | | /
> +          | |/
> +          |/|
> +$hashvl5  * |  5   committer@example.com
> +           /  not_yet_pushed
> +          |
> +$hashvl6  *  6   committer@example.com
> +            baz4
> +" >expect &&
> +	test_cmp expect actual
> +'
> +
> +test_expect_success 'orphan branches' '
> +	# If there are some branches to display which do not have a common
> +	# ancestor with the other branches, we show them in a separate graph.
> +	git checkout --orphan branch-a h/6 &&
> +	git commit -m baz7 &&
> +	xl >actual &&
> +
> +	hashvl1=$(git rev-parse h/1 | test_copy_bytes 8) &&
> +	hashvl2=$(git rev-parse h/2 | test_copy_bytes 8) &&
> +	hashvl3=$(git rev-parse h/3 | test_copy_bytes 8) &&
> +	hashvl4=$(git rev-parse h/4 | test_copy_bytes 8) &&
> +	hashvl5=$(git rev-parse h/5 | test_copy_bytes 8) &&
> +	hashvl6=$(git rev-parse h/6 | test_copy_bytes 8) &&
> +	hashvl7=$(git rev-parse h/7 | test_copy_bytes 8) &&
> +	hashvl8=$(git rev-parse h/8 | test_copy_bytes 8) &&
> +	hashvl9=$(git rev-parse h/9 | test_copy_bytes 8) &&
> +	hashv10=$(git rev-parse h/10 | test_copy_bytes 8) &&
> +
> +	echo "\
> +$hashvl1  *  1   committer@example.com  [HEAD branch-a]
> +            baz7
> +
> +$hashvl2  *  2   committer@example.com  [branch3]
> +          | baz6
> +          |
> +$hashvl3  *    3   committer@example.com
> +          |\  merge2
> +          | |
> +$hashvl4  | | *  4   committer@example.com  [branch4]
> +          | | | baz5
> +          | | |
> +$hashvl5  | | *    5   committer@example.com
> +          | | |\  merge1
> +          | |/ /
> +          | | /
> +          | |/
> +          |/|
> +$hashvl6  * |  6   committer@example.com
> +          | | not_yet_pushed
> +          | |
> +$hashvl7  | *  7   committer@example.com
> +          |/  baz4
> +          |
> +$hashvl8  *  8   committer@example.com
> +          | baz
> +          |
> +$hashvl9  | *  9   committer@example.com  [branch2]
> +          |/  bar
> +          |
> +$hashv10  *  10   committer@example.com
> +            foo
> +" >expect &&
> +	test_cmp expect actual &&
> +
> +	# Verify xl_base_# refs have been set correctly.
> +	test_cmp_rev xl_base_1 h/1 &&
> +	test_cmp_rev xl_base_2 h/10
> +'
> +
> +test_expect_success 'hide branches when branch.<branch-name>.no-xl is on' '
> +	git checkout branch4 &&
> +	git config branch.branch-a.no-xl true &&
> +	git config branch.branch2.no-xl true &&
> +	xl >actual &&
> +
> +	hashvl1=$(git rev-parse h/1 | test_copy_bytes 8) &&
> +	hashvl2=$(git rev-parse h/2 | test_copy_bytes 8) &&
> +	hashvl3=$(git rev-parse h/3 | test_copy_bytes 8) &&
> +	hashvl4=$(git rev-parse h/4 | test_copy_bytes 8) &&
> +	hashvl5=$(git rev-parse h/5 | test_copy_bytes 8) &&
> +	hashvl6=$(git rev-parse h/6 | test_copy_bytes 8) &&
> +	hashvl7=$(git rev-parse h/7 | test_copy_bytes 8) &&
> +
> +	echo "\
> +$hashvl1  *  1   committer@example.com  [branch3]
> +          | baz6
> +          |
> +$hashvl2  *    2   committer@example.com
> +          |\  merge2
> +          | |
> +$hashvl3  | | *  3   committer@example.com  [HEAD branch4]
> +          | | | baz5
> +          | | |
> +$hashvl4  | | *    4   committer@example.com
> +          | | |\  merge1
> +          | |/ /
> +          | | /
> +          | |/
> +          |/|
> +$hashvl5  * |  5   committer@example.com
> +          | | not_yet_pushed
> +          | |
> +$hashvl6  | *  6   committer@example.com
> +          |/  baz4
> +          |
> +$hashvl7  *  7   committer@example.com  [upstream_repo/branch3]
> +            baz
> +" >expect &&
> +	test_cmp expect actual
> +'
> +
> +test_done
> diff --git a/xl.c b/xl.c
> new file mode 100644
> index 0000000000..539e590f6b
> --- /dev/null
> +++ b/xl.c
> @@ -0,0 +1,485 @@
> +#include "builtin.h"
> +#include "cache.h"
> +#include "color.h"
> +#include "commit-reach.h"
> +#include "config.h"
> +#include "oidmap.h"
> +#include "ref-filter.h"
> +#include "refs.h"
> +#include "refs/refs-internal.h"
> +#include "remote.h"
> +#include "run-command.h"
> +#include "strbuf.h"
> +
> +#include <errno.h>
> +#include <stdarg.h>
> +#include <stdint.h>
> +#include <stdio.h>
> +#include <stdlib.h>
> +#include <string.h>
> +
> +static void set_ref(
> +	struct ref_transaction *ref_tr,
> +	char const *name,
> +	const struct object_id *oid)
> +{
> +	struct strbuf err = STRBUF_INIT;
> +
> +	if (ref_transaction_update(ref_tr, name, oid, NULL, 0, NULL, &err))
> +		die("%s", err.buf);
> +
> +	strbuf_release(&err);
> +}
> +
> +struct hash_to_ref {
> +	struct oidmap_entry e;
> +
> +	struct ref_array_item **refs;
> +	size_t nr;
> +	size_t alloc;
> +};
> +
> +/* An array of ref_array_item's which are not owned by this structure. */
> +struct ref_selection {
> +	struct ref_array_item **items;
> +	size_t alloc;
> +	size_t nr;
> +};
> +
> +static void populate_hash_to_ref_map(
> +	struct oidmap *m,
> +	struct ref_selection *refs)
> +{
> +	size_t ref_i;
> +	for (ref_i = 0; ref_i < refs->nr; ref_i++) {
> +		struct hash_to_ref *h2r;
> +		struct ref_array_item *ref = refs->items[ref_i];
> +
> +		h2r = oidmap_get(m, &ref->objectname);
> +		if (!h2r) {
> +			h2r = xcalloc(1, sizeof(*h2r));
> +			oidcpy(&h2r->e.oid, &ref->objectname);
> +			oidmap_put(m, h2r);
> +		}
> +		ALLOC_GROW_BY(h2r->refs, h2r->nr, 1, h2r->alloc);
> +		h2r->refs[h2r->nr - 1] = ref;
> +	}
> +}
> +
> +/*
> + * Helps invoke `git log` for a certain kind of graph format and process that
> + * output. One instance of this object lives for the entire invocation of
> + * `git xl` even if multiple disjoint graphs are included.
> + */
> +struct log_processing {
> +	struct strbuf raw_line;
> +	struct strbuf line_buf;
> +	struct strbuf line_prefix;
> +	struct strbuf sym_refs;
> +	struct strbuf tag_name;
> +
> +	struct child_process log_proc;
> +
> +	/* A buffered stream of the output of `git log` */
> +	FILE *stream;
> +
> +	/*
> +	 * Number of hashes found and abbreviated since the first graph was
> +	 * started.
> +	 */
> +	size_t hash_count;
> +
> +	unsigned graph_count;
> +
> +	/*
> +	 * Maps object IDs to hash_to_ref objects which contain all the ref
> +	 * names that ref to the object.
> +	 */
> +	const struct oidmap *h2r;
> +
> +	/*
> +	 * All references that the user desires to be included in a graph. This
> +	 * array may get resorted.
> +	 */
> +	struct ref_selection *refs;
> +
> +	/*
> +	 * Index pointing to the first element that has not been included in a
> +	 * graph yet.
> +	 */
> +	size_t ref_i;
> +
> +	/* Transaction for creating h/# and xl_base(_#) refs. */
> +	struct ref_transaction *ref_tr;
> +};
> +
> +#define LOG_PROCESSING_INIT { \
> +	STRBUF_INIT, \
> +	STRBUF_INIT, \
> +	STRBUF_INIT, \
> +	STRBUF_INIT, \
> +	STRBUF_INIT, \
> +}
> +
> +static void log_processing_finish_proc(struct log_processing *p)
> +{
> +	int err;
> +
> +	fclose(p->stream);
> +	p->stream = NULL;
> +	err = finish_command(&p->log_proc);
> +	if (err)
> +		die(_("log failed or could not be terminated: 0x%x"), err);
> +}
> +
> +static void log_processing_release(struct log_processing *p)
> +{
> +	if (p->stream)
> +		BUG("last log stdout was not closed");
> +	strbuf_release(&p->raw_line);
> +	strbuf_release(&p->line_buf);
> +	strbuf_release(&p->line_prefix);
> +	strbuf_release(&p->sym_refs);
> +	strbuf_release(&p->tag_name);
> +}
> +
> +#define XL_HASH_PREFIX "<{xl_hash}>"
> +
> +/*
> + * Begins a `git log` sub process with a subset of the branches requested.
> + *
> + * This log invocation shows a graph (using --graph) with full hashes. The
> + * hashes are prefixed with XL_HASH_PREFIX so they can get easily extracted.
> + *
> + * This function also sets the xl_base or xl_base_# ref to the merge base of
> + * the branches included.
> + */
> +static int log_processing_start_proc(struct log_processing *p)
> +{
> +	size_t ref_i;
> +	size_t start_ref_i = p->ref_i;
> +	size_t end_ref_i = p->refs->nr;
> +	struct commit *merge_base;
> +
> +	if (p->ref_i == p->refs->nr)
> +		return 0;
> +
> +	/*
> +	 * Split the p->refs[] sub array starting at start_ref_i into two
> +	 * sections, re-ordering if needed.
> +	 *
> +	 * The first section contains all commits which share a common ancestor
> +	 * with p->refs->items[start_ref_i]. The second section contains all
> +	 * other commits. In the process, we determine the merge base of the
> +	 * subset. If there are multiple merge bases, we only keep track of one.
> +	 * This is because `git log --graph <branch1...branchN>` only needs one
> +	 * of the merge bases to intelligently limit the graph size.
> +	 *
> +	 * After the loop is complete, end_ref_i will point to the first item
> +	 * in the second section.
> +	 */
> +	merge_base = lookup_commit(
> +		the_repository, &p->refs->items[start_ref_i]->objectname);
> +	for (ref_i = start_ref_i + 1; ref_i < end_ref_i;) {
> +		struct commit *next = lookup_commit(
> +			the_repository, &p->refs->items[ref_i]->objectname);
> +		struct commit_list *clist = repo_get_merge_bases(
> +			the_repository, merge_base, next);
> +
> +		if (!clist) {
> +			/*
> +			 * The ref at ref_i does not share a common ancestor
> +			 * with the refs processed since start_ref_i. Move the
> +			 * ref at ref_i to the end of the refs array, and move
> +			 * the item already at the end of the array to ref_i.
> +			 * This allows us to postpone processing this orphan
> +			 * branch until the next `git log` invocation.
> +			 */
> +			struct ref_array_item *tmp = p->refs->items[ref_i];
> +			p->refs->items[ref_i] = p->refs->items[--end_ref_i];
> +			p->refs->items[end_ref_i] = tmp;
> +		} else {
> +			merge_base = clist->item;
> +			free_commit_list(clist);
> +			ref_i++;
> +		}
> +	}
> +
> +	p->graph_count++;
> +	if (!start_ref_i && end_ref_i == p->refs->nr) {
> +		/* Only a single log graph in this invocation of `git xl`. */
> +		set_ref(p->ref_tr, "xl_base", &merge_base->object.oid);
> +	} else {
> +		/* Multiple log graphs - use a counter to disambiguate bases. */
> +		struct strbuf xl_base_ref_name = STRBUF_INIT;
> +		strbuf_addf(&xl_base_ref_name, "xl_base_%u", p->graph_count);
> +		set_ref(p->ref_tr, xl_base_ref_name.buf,
> +			&merge_base->object.oid);
> +		strbuf_release(&xl_base_ref_name);
> +	}
> +
> +	child_process_init(&p->log_proc);
> +	p->log_proc.git_cmd = 1;
> +	p->log_proc.out = -1;
> +	p->log_proc.no_stdin = 1;
> +
> +	argv_array_pushl(&p->log_proc.args, "log", "--graph", NULL);
> +	argv_array_pushf(&p->log_proc.args, "--color=%s",
> +			 want_color(GIT_COLOR_UNKNOWN) ? "always" : "never");
> +	argv_array_push(&p->log_proc.args,
> +			"--format=format:" XL_HASH_PREFIX "%H  %ce\n%s\n ");
> +	for (ref_i = start_ref_i; ref_i < end_ref_i; ref_i++)
> +		argv_array_push(
> +			&p->log_proc.args, p->refs->items[ref_i]->refname);
> +	argv_array_pushf(&p->log_proc.args, "^%s^@",
> +			 oid_to_hex(&merge_base->object.oid));
> +	argv_array_push(&p->log_proc.args, "--");
> +
> +	if (start_command(&p->log_proc))
> +		die(_("cannot start log"));
> +
> +	p->stream = xfdopen(p->log_proc.out, "r");
> +
> +	p->ref_i = end_ref_i;
> +
> +	return 1;
> +}
> +
> +static const char *color_on(const char *c)
> +{
> +	return want_color(GIT_COLOR_UNKNOWN) ? c : "";
> +}
> +
> +static const char *color_off(void)
> +{
> +	return want_color(GIT_COLOR_UNKNOWN) ? "\e[0m" : "";
> +}
> +
> +static void maybe_format_symrefs(
> +	struct strbuf *sym_refs,
> +	struct oidmap const *h2r,
> +	const struct object_id *oid)
> +{
> +	struct hash_to_ref const *h2r_entry;
> +	size_t ref_i;
> +
> +	h2r_entry = oidmap_get(h2r, oid);
> +
> +	if (!h2r_entry)
> +		return;
> +
> +	strbuf_addf(sym_refs, "  %s[", color_on("\e[1m"));
> +
> +	for (ref_i = 0; ref_i < h2r_entry->nr; ref_i++) {
> +		char *shortened_ref = shorten_unambiguous_ref(
> +			h2r_entry->refs[ref_i]->refname, /*strict=*/1);
> +
> +		if (ref_i)
> +			strbuf_addch(sym_refs, ' ');
> +
> +		strbuf_addstr(sym_refs, shortened_ref);
> +		free(shortened_ref);
> +	}
> +
> +	strbuf_addf(sym_refs, "]%s", color_off());
> +}
> +
> +static int process_log_line(struct log_processing *p)
> +{
> +	const char *in;
> +	size_t hash_prefix_len = strlen(XL_HASH_PREFIX);
> +
> +	strbuf_reset(&p->raw_line);
> +	strbuf_reset(&p->line_buf);
> +	strbuf_reset(&p->line_prefix);
> +	strbuf_reset(&p->sym_refs);
> +	strbuf_reset(&p->tag_name);
> +
> +	if (strbuf_getline_lf(&p->raw_line, p->stream) == EOF)
> +		return 0;
> +
> +	in = p->raw_line.buf;
> +
> +	while (*in) {
> +		struct object_id oid;
> +		const char *after_hash;
> +
> +		if (p->line_prefix.len ||
> +		    strncmp(XL_HASH_PREFIX, in, hash_prefix_len) ||
> +		    parse_oid_hex(in + hash_prefix_len, &oid, &after_hash)) {
> +			strbuf_addch(&p->line_buf, *in++);
> +			continue;
> +		}
> +
> +		p->hash_count++;
> +		strbuf_addf(&p->line_buf,
> +			    "%s %ld %s",
> +			    color_on("\e[48;5;213m\e[30m"),
> +			    p->hash_count,
> +			    color_off());
> +
> +		strbuf_addf(&p->line_prefix,
> +			    "%s%.8s%s",
> +			    color_on("\e[38;5;147m"),
> +			    in + hash_prefix_len,
> +			    color_off());
> +		in = after_hash;
> +
> +		strbuf_addf(&p->tag_name, "h/%ld", p->hash_count);
> +		set_ref(p->ref_tr, p->tag_name.buf, &oid);
> +
> +		maybe_format_symrefs(&p->sym_refs, p->h2r, &oid);
> +	}
> +
> +	fprintf(stdout, "%8s  %s%s\n",
> +		p->line_prefix.buf,
> +		p->line_buf.buf,
> +		p->sym_refs.buf);
> +
> +	return 1;
> +}
> +
> +static void empty_hash_to_ref_map(struct oidmap *m)
> +{
> +	struct oidmap_iter i;
> +	struct hash_to_ref *h2r;
> +	oidmap_iter_init(m, &i);
> +
> +	while ((h2r = oidmap_iter_next(&i)) != NULL) {
> +		FREE_AND_NULL(h2r->refs);
> +		h2r->alloc = 0;
> +		h2r->nr = 0;
> +	}
> +}
> +
> +static int add_ref(struct ref_array *refs, const char *name)
> +{
> +	struct object_id oid;
> +	size_t ref_i;
> +
> +	/* If we already have the ref, don't add it again. */
> +	for (ref_i = 0; ref_i < refs->nr; ref_i++) {
> +		if (!strcmp(refs->items[ref_i]->refname, name))
> +			return 0;
> +	}
> +
> +	if (get_oid(name, &oid))
> +		die("unknown object: %s", name);
> +	ref_array_push(refs, name, &oid);
> +	
> +	return 1;
> +}
> +
> +static void select_ref(
> +	struct ref_selection *ref_sel,
> +	struct ref_array *refs,
> +	size_t ref_i)
> +{
> +	ALLOC_GROW_BY(ref_sel->items, ref_sel->nr, 1, ref_sel->alloc);
> +	ref_sel->items[ref_sel->nr - 1] = refs->items[ref_i];
> +}
> +
> +static void populate_branch_args(
> +	struct ref_array *refs,
> +	struct ref_selection *ref_sel,
> +	const char **argv)
> +{
> +	struct ref_filter filter = {0};
> +	size_t ref_i;
> +	size_t ref_i_end;
> +	struct strbuf no_xl_config_key = STRBUF_INIT;
> +
> +	filter.name_patterns = argv;
> +	filter_refs(refs, &filter, FILTER_REFS_BRANCHES);
> +
> +	ref_i_end = refs->nr;
> +
> +	/* Add upstream branches of each branch. */
> +	for (ref_i = 0; ref_i < ref_i_end; ref_i++) {
> +		struct branch *branch = branch_get(refs->items[ref_i]->refname);
> +		char *short_name;
> +		const char *upstream;
> +		int no_xl = 0;
> +
> +		if (!branch) {
> +			/*
> +			 * Not actually a branch, but might be HEAD. Select this
> +			 * ref for display.
> +			 */
> +			select_ref(ref_sel, refs, ref_i);
> +			continue;
> +		}
> +
> +		/*
> +		 * Do not show the branch or its upstream if user configured
> +		 * branch.<branch-name>.no-xl = true
> +		 */
> +		short_name = shorten_unambiguous_ref(
> +			branch->name, /*strict=*/1);
> +		strbuf_reset(&no_xl_config_key);
> +		strbuf_addf(&no_xl_config_key, "branch.%s.no-xl", short_name);
> +		FREE_AND_NULL(short_name);
> +
> +		if (!git_config_get_bool(no_xl_config_key.buf, &no_xl) && no_xl)
> +			continue;
> +
> +		select_ref(ref_sel, refs, ref_i);
> +		upstream = branch_get_upstream(branch, NULL);
> +
> +		/*
> +		 * Add the upstream branch if it has not been added as the
> +		 * upstream of some other local branch.
> +		 */
> +		if (upstream && add_ref(refs, upstream))
> +			select_ref(ref_sel, refs, refs->nr - 1);
> +	}
> +
> +	strbuf_release(&no_xl_config_key);
> +}
> +
> +int cmd_xl(int argc, const char **argv, const char *prefx)
> +{
> +	struct oidmap hash_to_ref_map = OIDMAP_INIT;
> +	struct ref_selection ref_sel = {0};
> +	struct ref_array refs = {0};
> +	struct strbuf ref_tr_err = STRBUF_INIT;
> +	struct ref_transaction *ref_tr;
> +	struct log_processing log_processing = LOG_PROCESSING_INIT;
> +
> +	git_config(git_color_config, NULL);
> +
> +	/*
> +	 * Add HEAD first. This way, if we output multiple graphs, the first
> +	 * one will include the currently checked-out ref.
> +	 */
> +	add_ref(&refs, "HEAD");
> +
> +	populate_branch_args(&refs, &ref_sel, argv + 1);
> +
> +	oidmap_init(&hash_to_ref_map, 16);
> +	populate_hash_to_ref_map(&hash_to_ref_map, &ref_sel);
> +
> +	if (!(ref_tr = ref_transaction_begin(&ref_tr_err)))
> +		die("%s", ref_tr_err.buf);
> +
> +	log_processing.h2r = &hash_to_ref_map;
> +	log_processing.ref_tr = ref_tr;
> +	log_processing.refs = &ref_sel;
> +	while (log_processing_start_proc(&log_processing)) {
> +		while (process_log_line(&log_processing)) {}
> +		log_processing_finish_proc(&log_processing);
> +	}
> +
> +	if (ref_transaction_commit(ref_tr, &ref_tr_err))
> +		die("%s", ref_tr_err.buf);
> +
> +	empty_hash_to_ref_map(&hash_to_ref_map);
> +	oidmap_free(&hash_to_ref_map, 1);
> +	ref_array_clear(&refs);
> +	ref_transaction_free(ref_tr);
> +	strbuf_release(&ref_tr_err);
> +	log_processing_release(&log_processing);
> +	FREE_AND_NULL(ref_sel.items);
> +
> +	return 0;
> +}
> -- 
> 2.19.0.605.g01d371f741-goog
> 
