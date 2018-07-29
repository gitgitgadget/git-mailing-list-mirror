Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 78E09208E9
	for <e@80x24.org>; Sun, 29 Jul 2018 22:04:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728672AbeG2Xg3 (ORCPT <rfc822;e@80x24.org>);
        Sun, 29 Jul 2018 19:36:29 -0400
Received: from mail-wr1-f67.google.com ([209.85.221.67]:46292 "EHLO
        mail-wr1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726835AbeG2Xg3 (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 29 Jul 2018 19:36:29 -0400
Received: by mail-wr1-f67.google.com with SMTP id h14-v6so10679037wrw.13
        for <git@vger.kernel.org>; Sun, 29 Jul 2018 15:04:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version;
        bh=OgJIcQR5ircIfDp0QuFqdpd0htqoIOxFdp+xfRVd4Pg=;
        b=vXXB461Td3SD8FQqH6fosIBggdSvWGYx7y8NXClurUSzTbwu7AZ2eNMWqTwp+ofgKQ
         NNS0Aj8/NSuFc+yo3LY8XIXfd4XIAaxdLINbU15Q4dXwecMoL3d/YP+sh7An/ELdOUa1
         4t/b+TkEr83ftfyia1pMpFunKFcQSrn565/jc1SCz8kQVX/vcLvMDc6SORC2GcLkwFxF
         kHYqVTeruBrpFXCXhUkgJGsTZmc27DZX7bWO1mQbRKcATvAEIJg9dloT10OpzESB1lQN
         7zDLmgOLmBLmBU25iOhqb5Hz3ke94OcMM3vp1nIpgCObTStT7+GkhNORkERR7mQM3XAH
         wyMw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:references:date:in-reply-to
         :message-id:user-agent:mime-version;
        bh=OgJIcQR5ircIfDp0QuFqdpd0htqoIOxFdp+xfRVd4Pg=;
        b=V7WtHK5NI4StDJK7xD6DAEDEOMmdLpRff4+vpoxrl3Hkm83GerY6+wXHST5k7+smqB
         FgeiiGt2aI+8lrjAHu6eSvHw4AI8iR6P9TPK5rqIYqmB6EcdMUH//1+SRPZ6xPpZqt22
         wiCdcZb3/XdAzVOpjk/FffkbAIBGpecXCmZmsy4c8un9j6WS0zPeO0cNWq+mtV+Ei17C
         3tnjysH5dwP/hoY5CmOwAHJ+Aj/mX0UEfF2yHvvUrzHmS96+ufCO2tF25m1/RhU/ZvBc
         XZteFE1H/J2pWdzZLQcngVkljT/h7s1YBo5OwFtk8ZaxEXx0SJQgLmShJdDZNSkMnv9v
         g+QQ==
X-Gm-Message-State: AOUpUlEQ6DWszlj4t0FOhRJbIKZhjLwWqQkUEhkVkWB9wLmSeZKbOJHt
        qjzPjcVe8w+fy2/DSyuQUyQ=
X-Google-Smtp-Source: AAOMgpdtQfxccqaNjaRIrxu5cU1fmWXgn9Dh+pP/Ipk6xS+XNyFQbnNYuKfZJfR3Ch0OXHVNR4odNg==
X-Received: by 2002:a5d:50cd:: with SMTP id f13-v6mr15506973wrt.73.1532901867343;
        Sun, 29 Jul 2018 15:04:27 -0700 (PDT)
Received: from Laptop-Acer-Aspire-F15 (abuo246.neoplus.adsl.tpnet.pl. [83.8.186.246])
        by smtp.gmail.com with ESMTPSA id h5-v6sm11834093wrr.19.2018.07.29.15.04.24
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Sun, 29 Jul 2018 15:04:25 -0700 (PDT)
From:   Jakub Narebski <jnareb@gmail.com>
To:     "Derrick Stolee via GitGitGadget" <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
        Derrick Stolee <dstolee@microsoft.com>
Subject: Re: [PATCH 6/8] commit-graph: not compatible with grafts
References: <pull.11.git.gitgitgadget@gmail.com>
        <94dd91ac35006ebee3c8808af1fce4ad69975234.1531926932.git.gitgitgadget@gmail.com>
Date:   Mon, 30 Jul 2018 00:04:25 +0200
In-Reply-To: <94dd91ac35006ebee3c8808af1fce4ad69975234.1531926932.git.gitgitgadget@gmail.com>
        (Derrick Stolee via GitGitGadget's message of "Wed, 18 Jul 2018
        08:15:43 -0700 (PDT)")
Message-ID: <86bmap7l7a.fsf@gmail.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.2 (windows-nt)
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

"Derrick Stolee via GitGitGadget" <gitgitgadget@gmail.com> writes:

> From: Derrick Stolee <dstolee@microsoft.com>
>
> Augment commit_graph_compatible(r) to return false when the given
> repository r has commit grafts or is a shallow clone. Test that in these
> situations we ignore existing commit-graph files and we do not write new
> commit-graph files.

Tests for grafts are wrong, as they test replace objects.

>
> Signed-off-by: Derrick Stolee <dstolee@microsoft.com>
> ---
>  commit-graph.c          |  6 ++++++
>  commit.c                |  2 +-
>  commit.h                |  1 +
>  t/t5318-commit-graph.sh | 36 ++++++++++++++++++++++++++++++++++++
>  4 files changed, 44 insertions(+), 1 deletion(-)
>
> diff --git a/commit-graph.c b/commit-graph.c
> index 711099858..5097c7c12 100644
> --- a/commit-graph.c
> +++ b/commit-graph.c
> @@ -60,6 +60,12 @@ static struct commit_graph *alloc_commit_graph(void)
>  
>  static int commit_graph_compatible(struct repository *r)
>  {
> +	prepare_commit_graft(r);
> +	if (r->parsed_objects && r->parsed_objects->grafts_nr)
> +		return 0;
> +	if (is_repository_shallow(r))
> +		return 0;

Do I assume correctly that is_repository_shallow(r) needs
prepare_commit_graph(r) done earlier?  If it is so, all right.

If it is not so, then why put two separate history-"altering" features,
namely grafts and shallow clones in single commit instead of in separate
commits?

> +
>  	prepare_replace_object(r);
>  	if (hashmap_get_size(&r->objects->replace_map->map))
>  		return 0;
> diff --git a/commit.c b/commit.c
> index 39b80bd21..609adaf8a 100644
> --- a/commit.c
> +++ b/commit.c
> @@ -209,7 +209,7 @@ static int read_graft_file(struct repository *r, const char *graft_file)
>  	return 0;
>  }
>  
> -static void prepare_commit_graft(struct repository *r)
> +void prepare_commit_graft(struct repository *r)
>  {
>  	char *graft_file;
>  
> diff --git a/commit.h b/commit.h
> index da0db36eb..5459e279f 100644
> --- a/commit.h
> +++ b/commit.h
> @@ -202,6 +202,7 @@ typedef int (*each_commit_graft_fn)(const struct commit_graft *, void *);
>  
>  struct commit_graft *read_graft_line(struct strbuf *line);
>  int register_commit_graft(struct repository *r, struct commit_graft *, int);
> +void prepare_commit_graft(struct repository *r);
>  struct commit_graft *lookup_commit_graft(struct repository *r, const struct object_id *oid);
>

I guess that prepare_commit_graft() was not needed outside commit.c
before.

>  extern struct commit_list *get_merge_bases(struct commit *rev1, struct commit *rev2);
> diff --git a/t/t5318-commit-graph.sh b/t/t5318-commit-graph.sh
> index c90626f5d..1d9f49af5 100755
> --- a/t/t5318-commit-graph.sh
> +++ b/t/t5318-commit-graph.sh
> @@ -281,6 +281,42 @@ test_expect_success 'replace-objects invalidates commit-graph' '
>  	)
>  '
>  
> +test_expect_success 'commit grafts invalidate commit-graph' '
> +	cd "$TRASH_DIRECTORY" &&
> +	test_when_finished rm -rf graft &&
> +	git clone full graft &&
> +	(
> +		cd graft &&
> +		git commit-graph write --reachable &&
> +		test_path_is_file .git/objects/info/commit-graph &&
> +		git replace --graft HEAD~1 HEAD~3 &&

Errr... this uses *replace objects* mechanism, not graft file!!  The
`--graft` option of git-remote command is here to make it easier to use
replace objects to alter the view of history, and make if easy to
convert from deprected grafts feature to replace objects.

Grafts file structure is described in gitrepository-layout(5) manpage.
You would need to do something like the following:

  +		H1=$(git rev-parse --verify HEAD~1) &&
  +		H3=$(git rev-parse --verify HEAD~3) &&
  +		echo '$H1 $H3' >.git/info/grafts &&


You could have used "git replace --graft HEAD~1 HEAD~3" in previous
commit test, like I wrote in reply to it.

> +		git -c core.commitGraph=false log >expect &&
> +		git -c core.commitGraph=true log >actual &&
> +		test_cmp expect actual &&

All right, we test that we get the same result (when graft-file is
written before altering the view of history) with and without the
commit-graph feature.

Sidenote: shouldn't we use rev-list instead?  Though here git-log is
actually safe to use...

> +		git commit-graph write --reachable &&
> +		git -c core.commitGraph=false --no-replace-objects log >expect &&
> +		git -c core.commitGraph=true --no-replace-objects log >actual &&

The `--no-replace-objects` does not affect the graph file!!  You would
want to remove graft file instead:

  +		git commit-graph write --reachable &&
  +		rm -f .git/info/grafts &&
  +		git -c core.commitGraph=false log >expect &&
  +		git -c core.commitGraph=true log >actual &&

And then check the results.

> +		test_cmp expect actual &&
> +		rm -rf .git/objects/info/commit-graph &&
> +		git commit-graph write --reachable &&
> +		test_path_is_missing .git/objects/info/commit-graph

All right.

Though, if it is the same for grafts and for replacements... nah.
Adding a feature and deleting a feature is different, and it is only a
single repetition.

> +	)
> +'
> +
> +test_expect_success 'replace-objects invalidates commit-graph' '
> +	cd "$TRASH_DIRECTORY" &&
> +	test_when_finished rm -rf shallow &&
> +	git clone --depth 2 "file://$TRASH_DIRECTORY/full" shallow &&

Why do we need to use "file://..." URL, instead of simply "full"?

> +	(
> +		cd shallow &&
> +		git commit-graph write --reachable &&
> +		test_path_is_missing .git/objects/info/commit-graph &&
> +		git fetch origin --unshallow &&
> +		git commit-graph write --reachable &&
> +		test_path_is_file .git/objects/info/commit-graph

All right, so in this case because you need to start (clone) with
shallow feature, the test could be simplified.

> +	)
> +'
> +
>  # the verify tests below expect the commit-graph to contain
>  # exactly the commits reachable from the commits/8 branch.
>  # If the file changes the set of commits in the list, then the
