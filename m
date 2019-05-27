Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.3 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	FROM_EXCESS_BASE64,HEADER_FROM_DIFFERENT_DOMAINS,LOTS_OF_MONEY,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_NONE
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 59E911F462
	for <e@80x24.org>; Mon, 27 May 2019 11:28:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726722AbfE0L2e (ORCPT <rfc822;e@80x24.org>);
        Mon, 27 May 2019 07:28:34 -0400
Received: from mail-wr1-f65.google.com ([209.85.221.65]:35902 "EHLO
        mail-wr1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725943AbfE0L2d (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 27 May 2019 07:28:33 -0400
Received: by mail-wr1-f65.google.com with SMTP id s17so16602056wru.3
        for <git@vger.kernel.org>; Mon, 27 May 2019 04:28:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=IFI1Zm451vig9qUkxf0bUt1cGmuAL4UFs2kOxpJycZw=;
        b=Cgd55bvd4RVLtPf8cyDwQwYg2XVY8c7VfJsNXYC2pcoNpuJjjRuKZAm9VYhEH9r9aC
         xISHeOtUlYMDgwcK9s03l2UK/bkf2A2qDF+Rk5B/080bkfZYBrlQI4jzwTtJ8Oj/USJc
         m05fkHq5XK18/+r46v1FFGLweyyNC86YjtVeKxOIWdA3Z2e9YB0P3HI/X96kEdQNaGBu
         RfFnsG2N8oEwgnBHGij44Ak8Y7GwV1MT8/jQ5FA6NUQAVES7+rdRmd1sv9LpoIdB2Eii
         QfM/t4EJ37w4rx6WuY5UwGaH6SIQ+b9Wtqx0qfHm34yZoQ16e/2ydebHZQ8DEAyWT7G3
         Q1kw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=IFI1Zm451vig9qUkxf0bUt1cGmuAL4UFs2kOxpJycZw=;
        b=XIHwSa0h+umgGbh2+98q2PajG0ZFuQvMciSnU19iRfmHGHWSMiG++yLjibf3+vqdse
         gsrgE3tKCSSrr9H+Jkg5TvrCMYg77EBSjnMHu2zf8H025uZCf5d7qxg7gmK+ZdhMoPXO
         d2Lh9kX4nZxjBKydnqYmgbzknPQgiMhCTdcwWjX7KnEqdgfUeTEueqc5gLYXBk/Z6DtS
         WcxGNpIfKWWwKii75U9/ChXZcW0UiJayG+u6ep9rymSPpAP9d8dEwmnAfKt8MQqC4e/9
         8ENVgk7xNO7HB27ZcVFXGRi7YaSpUD3Z95d8ZOSC8kjT+QhGQISGqMEo9V9Iz72Tmmny
         C4xQ==
X-Gm-Message-State: APjAAAWxd0OJgR4i95xLh8CRkyvN5ErTeuVoVf9Skxfa/hTcJbdfvk6F
        Uyla4xM4urmPO1UhlZRtkms=
X-Google-Smtp-Source: APXvYqzYnqSA+pFHsTkGOfD/trkjcQeN+5PJnbQD5hXiV5CmyKfsM6tTTGRFvtVXAmXkguaj8TibfA==
X-Received: by 2002:adf:cc8d:: with SMTP id p13mr21259132wrj.114.1558956511441;
        Mon, 27 May 2019 04:28:31 -0700 (PDT)
Received: from szeder.dev (x4db96a1d.dyn.telefonica.de. [77.185.106.29])
        by smtp.gmail.com with ESMTPSA id u2sm32132479wra.82.2019.05.27.04.28.30
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 27 May 2019 04:28:30 -0700 (PDT)
Date:   Mon, 27 May 2019 13:28:28 +0200
From:   SZEDER =?utf-8?B?R8OhYm9y?= <szeder.dev@gmail.com>
To:     Derrick Stolee via GitGitGadget <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org, peff@peff.net, avarab@gmail.com,
        git@jeffhostetler.com, jrnieder@google.com, steadmon@google.com,
        Junio C Hamano <gitster@pobox.com>,
        Derrick Stolee <dstolee@microsoft.com>
Subject: Re: [PATCH v2 08/11] commit-graph: add --split option to builtin
Message-ID: <20190527112828.GK951@szeder.dev>
References: <pull.184.git.gitgitgadget@gmail.com>
 <pull.184.v2.git.gitgitgadget@gmail.com>
 <5ad14f574b6ffa5e233d61098dbcfc29c3632be5.1558554800.git.gitgitgadget@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <5ad14f574b6ffa5e233d61098dbcfc29c3632be5.1558554800.git.gitgitgadget@gmail.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, May 22, 2019 at 12:53:27PM -0700, Derrick Stolee via GitGitGadget wrote:
> diff --git a/t/t5323-split-commit-graph.sh b/t/t5323-split-commit-graph.sh
> new file mode 100755
> index 0000000000..96704b9f5b
> --- /dev/null
> +++ b/t/t5323-split-commit-graph.sh
> @@ -0,0 +1,122 @@
> +#!/bin/sh
> +
> +test_description='split commit graph'
> +. ./test-lib.sh
> +
> +GIT_TEST_COMMIT_GRAPH=0
> +
> +test_expect_success 'setup repo' '
> +	git init &&
> +	git config core.commitGraph true &&
> +	infodir=".git/objects/info" &&
> +	graphdir="$infodir/commit-graphs" &&
> +	test_oid_init
> +'
> +
> +graph_read_expect() {
> +	NUM_BASE=0
> +	if test ! -z $2
> +	then
> +		NUM_BASE=$2
> +	fi
> +	cat >expect <<- EOF
> +	header: 43475048 1 1 3 $NUM_BASE
> +	num_commits: $1
> +	chunks: oid_fanout oid_lookup commit_metadata
> +	EOF
> +	git commit-graph read >output &&
> +	test_cmp expect output
> +}
> +
> +test_expect_success 'create commits and write commit-graph' '
> +	for i in $(test_seq 3)
> +	do
> +		test_commit $i &&
> +		git branch commits/$i
> +	done &&

Please add a "|| return 1" at the end of the for loop's body, i.e.

  for ....
  do
        this &&
        that || return 1
  done

because for loops continue iteration even when the commands in their
body failed, potentially hinding errors.

This applies to the other three for loops below as well.

> +	git commit-graph write --reachable &&
> +	test_path_is_file $infodir/commit-graph &&
> +	graph_read_expect 3
> +'
> +
> +graph_git_two_modes() {
> +	git -c core.commitGraph=true $1 >output
> +	git -c core.commitGraph=false $1 >expect
> +	test_cmp expect output
> +}
> +
> +graph_git_behavior() {
> +	MSG=$1
> +	BRANCH=$2
> +	COMPARE=$3
> +	test_expect_success "check normal git operations: $MSG" '
> +		graph_git_two_modes "log --oneline $BRANCH" &&
> +		graph_git_two_modes "log --topo-order $BRANCH" &&
> +		graph_git_two_modes "log --graph $COMPARE..$BRANCH" &&
> +		graph_git_two_modes "branch -vv" &&
> +		graph_git_two_modes "merge-base -a $BRANCH $COMPARE"
> +	'
> +}
> +
> +graph_git_behavior 'graph exists' commits/3 commits/1
> +
> +verify_chain_files_exist() {
> +	for hash in $(cat $1/commit-graph-chain)
> +	do
> +		test_path_is_file $1/graph-$hash.graph
> +	done
> +}
> +
> +test_expect_success 'add more commits, and write a new base graph' '
> +	git reset --hard commits/1 &&
> +	for i in $(test_seq 4 5)
> +	do
> +		test_commit $i &&
> +		git branch commits/$i
> +	done &&
> +	git reset --hard commits/2 &&
> +	for i in $(test_seq 6 10)
> +	do
> +		test_commit $i &&
> +		git branch commits/$i
> +	done &&
> +	git reset --hard commits/2 &&
> +	git merge commits/4 &&
> +	git branch merge/1 &&
> +	git reset --hard commits/4 &&
> +	git merge commits/6 &&
> +	git branch merge/2 &&
> +	git commit-graph write --reachable &&
> +	graph_read_expect 12
> +'
> +
> +test_expect_success 'add three more commits, write a tip graph' '
> +	git reset --hard commits/3 &&
> +	git merge merge/1 &&
> +	git merge commits/5 &&
> +	git merge merge/2 &&
> +	git branch merge/3 &&
> +	git commit-graph write --reachable --split &&
> +	test_path_is_missing $infodir/commit-graph &&
> +	test_path_is_file $graphdir/commit-graph-chain &&
> +	ls $graphdir/graph-*.graph >graph-files &&
> +	test_line_count = 2 graph-files &&
> +	verify_chain_files_exist $graphdir
> +'
> +
> +graph_git_behavior 'split commit-graph: merge 3 vs 2' merge/3 merge/2
> +
> +test_expect_success 'add one commit, write a tip graph' '
> +	test_commit 11 &&
> +	git branch commits/11 &&
> +	git commit-graph write --reachable --split &&
> +	test_path_is_missing $infodir/commit-graph &&
> +	test_path_is_file $graphdir/commit-graph-chain &&
> +	ls $graphdir/graph-*.graph >graph-files &&
> +	test_line_count = 3 graph-files &&
> +	verify_chain_files_exist $graphdir
> +'
> +
> +graph_git_behavior 'three-layer commit-graph: commit 11 vs 6' commits/11 commits/6
> +
> +test_done
> -- 
> gitgitgadget
> 
