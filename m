Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 7B4D11F597
	for <e@80x24.org>; Mon, 30 Jul 2018 14:40:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731981AbeG3QPX (ORCPT <rfc822;e@80x24.org>);
        Mon, 30 Jul 2018 12:15:23 -0400
Received: from mail-wr1-f65.google.com ([209.85.221.65]:36412 "EHLO
        mail-wr1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731914AbeG3QPW (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 30 Jul 2018 12:15:22 -0400
Received: by mail-wr1-f65.google.com with SMTP id h9-v6so13180994wro.3
        for <git@vger.kernel.org>; Mon, 30 Jul 2018 07:40:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version:content-transfer-encoding;
        bh=xuh7TMuQ+OugEezE1VyXa7uqUjZ/u4+AZKLWtV7l6F8=;
        b=CPq19d4CzP66Di5bCRzspanxBiUwpAA0Xr04EOM8rvq7Z7YvtNZYJ70Gu7vLa4uwE8
         mbdQUvH4tjaUZDEGcbFg+a6e7DoxGN6DZ6tziSj7bJ6F57E1Sk5OY8MN9GSLSOKwDli2
         L4Uc89vOZTdbbVLZnkLjkUQqVDMzhvCWBX1JOOayPJjjN5dsUMbnt5xmgHC0xlfYDkk0
         KKqiaLou+rydwXXi+1HGLjS3iWvExFAZbmKOJoG+NLERTWL+dSj2GuFj64+uAQ/5jPbe
         4KTVFdFcYcrBH2LsWwOMdeJeJvCo3Lu4OgvBhA+E+JsKo24ldmfRj+H0KyOoup4OPQoY
         iSvg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:references:date:in-reply-to
         :message-id:user-agent:mime-version:content-transfer-encoding;
        bh=xuh7TMuQ+OugEezE1VyXa7uqUjZ/u4+AZKLWtV7l6F8=;
        b=Wm75UU5gOA28gd3mcG4Kd+Z4GLselpiISTVu6X7SG8xuHIDxMq0tXjYeyZEXVAvHgJ
         dS0M8POc1dXVMXx+UAdy5NnR3h60jb6uJwFqWdHqdXqBIuUDWyCfoGRhe3auMGCd0IK9
         V2kAxRzEDRKShCi6mIw0fZaXRcO8O+gLmcy/2kp7fhREniAvQyPfQDEjdUbBwQA3/3NN
         rWLn3c4k8yOQTxulkjRLeq0mBtZ97C6Oy+tY1QWO8+JTIn4uG3BwdZBB4JDYJkpViTGV
         ubjRP2X4lhYeMpsKPHkJH6KFq3+2/uFMaI5KsQCmnR4wap3v1cZyv8dqIw8k/qD2wfPQ
         hifw==
X-Gm-Message-State: AOUpUlEOlwOX8KKhhbEKa+VUzz070bAd577qCL3IpFKc72DfEIdtmBdg
        yL9ehcLmczr0zm9YRrRvkO7jb7s6
X-Google-Smtp-Source: AAOMgpfmh4bXB5RHyJwOV7Xw9GgOqitCbRYvudZht/UkO5GjpxPKxFuJfoJO3Eb0f5MxRxM026gFOQ==
X-Received: by 2002:adf:ba12:: with SMTP id o18-v6mr18886269wrg.249.1532961602141;
        Mon, 30 Jul 2018 07:40:02 -0700 (PDT)
Received: from Laptop-Acer-Aspire-F15 (abuo246.neoplus.adsl.tpnet.pl. [83.8.186.246])
        by smtp.gmail.com with ESMTPSA id 185-v6sm17360985wmy.38.2018.07.30.07.40.00
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 30 Jul 2018 07:40:00 -0700 (PDT)
From:   Jakub Narebski <jnareb@gmail.com>
To:     Derrick Stolee <dstolee@microsoft.com>
Cc:     "git\@vger.kernel.org" <git@vger.kernel.org>
Subject: Re: [PATCH] DO-NOT-MERGE: write and read commit-graph always
References: <pull.11.git.gitgitgadget@gmail.com>
        <20180718152244.45513-1-dstolee@microsoft.com>
Date:   Mon, 30 Jul 2018 16:39:59 +0200
In-Reply-To: <20180718152244.45513-1-dstolee@microsoft.com> (Derrick Stolee's
        message of "Wed, 18 Jul 2018 15:22:58 +0000")
Message-ID: <86y3ds6b40.fsf@gmail.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.2 (windows-nt)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Derrick Stolee <dstolee@microsoft.com> writes:

> This commit is not intended to be merged, but is only to create a test
> environment to see what works with the commit-graph feature and what
> does not. The tests that fail are primarily related to corrupting the
> object store to remove a commit from visibility and testing that
> rev-list fails -- except it doesn't when there is a commit-graph that
> prevents parsing from the object database. The following tests will fail
> with this commit, but are not "real" bugs:
>
> t0410-partial-clone.sh, Test 9
> t5307-pack-missing-commit.sh, Tests 3-4
> t6011-rev-list-with-bad-commit.sh, Test 4
>
> The following test fails because the repo has ambiguous merge-bases, and
> the commit-graph changes the walk order so we select a different one.
> This alters the resulting merge from the expected result.
>
> t6024-recursive-merge.sh, Test 4
>
> The tests above are made to pass by deleting the commit-graph file
> before the necessary steps.
>
> Signed-off-by: Derrick Stolee <dstolee@microsoft.com>
> ---
>  builtin/commit.c                    |  2 ++
>  builtin/gc.c                        |  3 +--
>  commit-graph.c                      | 11 -----------
>  t/t0410-partial-clone.sh            |  1 +
>  t/t5307-pack-missing-commit.sh      |  2 ++
>  t/t6011-rev-list-with-bad-commit.sh |  1 +
>  t/t6024-recursive-merge.sh          |  1 +
>  7 files changed, 8 insertions(+), 13 deletions(-)
>
> diff --git a/builtin/commit.c b/builtin/commit.c
> index 158e3f843a..acc31252a9 100644
> --- a/builtin/commit.c
> +++ b/builtin/commit.c
> @@ -33,6 +33,7 @@
>  #include "sequencer.h"
>  #include "mailmap.h"
>  #include "help.h"
> +#include "commit-graph.h"
>=20=20
>  static const char * const builtin_commit_usage[] =3D {
>  	N_("git commit [<options>] [--] <pathspec>..."),
> @@ -1652,6 +1653,7 @@ int cmd_commit(int argc, const char **argv, const c=
har *prefix)
>  		     "not exceeded, and then \"git reset HEAD\" to recover."));
>=20=20
>  	rerere(0);
> +	write_commit_graph_reachable(get_object_directory(), 1);
>  	run_command_v_opt(argv_gc_auto, RUN_GIT_CMD);
>  	run_commit_hook(use_editor, get_index_file(), "post-commit", NULL);
>  	if (amend && !no_post_rewrite) {

This is certainly not for merging.

> diff --git a/builtin/gc.c b/builtin/gc.c
> index e103f0f85d..60ab773087 100644
> --- a/builtin/gc.c
> +++ b/builtin/gc.c
> @@ -41,7 +41,7 @@ static int aggressive_depth =3D 50;
>  static int aggressive_window =3D 250;
>  static int gc_auto_threshold =3D 6700;
>  static int gc_auto_pack_limit =3D 50;
> -static int gc_write_commit_graph;
> +static int gc_write_commit_graph =3D 1;
>  static int detach_auto =3D 1;
>  static timestamp_t gc_log_expire_time;
>  static const char *gc_log_expire =3D "1.day.ago";

This is switching from default to off to default to on.  I think with
this feature we would default to off for a long time (wishful thinking:
maybe automatically enabling it for large repositories, or if
commit-graph file exists already?).

> @@ -131,7 +131,6 @@ static void gc_config(void)
>  	git_config_get_int("gc.aggressivedepth", &aggressive_depth);
>  	git_config_get_int("gc.auto", &gc_auto_threshold);
>  	git_config_get_int("gc.autopacklimit", &gc_auto_pack_limit);
> -	git_config_get_bool("gc.writecommitgraph", &gc_write_commit_graph);
>  	git_config_get_bool("gc.autodetach", &detach_auto);
>  	git_config_get_expiry("gc.pruneexpire", &prune_expire);
>  	git_config_get_expiry("gc.worktreepruneexpire", &prune_worktrees_expire=
);

This is certainly not for merging, as it disables gc.writeCommitGraph
config option entirely.

> diff --git a/commit-graph.c b/commit-graph.c
> index 237d4e7d1b..ed0d27c12e 100644
> --- a/commit-graph.c
> +++ b/commit-graph.c
> @@ -227,22 +227,11 @@ static int prepare_commit_graph(struct repository *=
r)
>  {
>  	struct alternate_object_database *alt;
>  	char *obj_dir;
> -	int config_value;
>=20=20
>  	if (r->objects->commit_graph_attempted)
>  		return !!r->objects->commit_graph;
>  	r->objects->commit_graph_attempted =3D 1;
>=20=20
> -	if (repo_config_get_bool(r, "core.commitgraph", &config_value) ||
> -	    !config_value)
> -		/*
> -		 * This repository is not configured to use commit graphs, so
> -		 * do not load one. (But report commit_graph_attempted anyway
> -		 * so that commit graph loading is not attempted again for this
> -		 * repository.)
> -		 */
> -		return 0;
> -
>  	if (!commit_graph_compatible(r))
>  		return 0;
>

This is certainly not for merging, as it disables core.commitGraph
config option entirely.

> diff --git a/t/t0410-partial-clone.sh b/t/t0410-partial-clone.sh
> index 4984ca583d..c235672b03 100755
> --- a/t/t0410-partial-clone.sh
> +++ b/t/t0410-partial-clone.sh
> @@ -181,6 +181,7 @@ test_expect_success 'rev-list stops traversal at miss=
ing and promised commit' '
>=20=20
>  	git -C repo config core.repositoryformatversion 1 &&
>  	git -C repo config extensions.partialclone "arbitrary string" &&
> +	rm -rf repo/.git/objects/info/commit-graph &&
>  	git -C repo rev-list --exclude-promisor-objects --objects bar >out &&
>  	grep $(git -C repo rev-parse bar) out &&
>  	! grep $FOO out
> diff --git a/t/t5307-pack-missing-commit.sh b/t/t5307-pack-missing-commit=
.sh
> index ae52a1882d..0bb54ae227 100755
> --- a/t/t5307-pack-missing-commit.sh
> +++ b/t/t5307-pack-missing-commit.sh
> @@ -24,10 +24,12 @@ test_expect_success 'check corruption' '
>  '
>=20=20
>  test_expect_success 'rev-list notices corruption (1)' '
> +	rm -rf .git/objects/info/commit-graph &&
>  	test_must_fail git rev-list HEAD
>  '
>=20=20
>  test_expect_success 'rev-list notices corruption (2)' '
> +	rm -rf .git/objects/info/commit-graph &&
>  	test_must_fail git rev-list --objects HEAD
>  '
>=20=20
> diff --git a/t/t6011-rev-list-with-bad-commit.sh b/t/t6011-rev-list-with-=
bad-commit.sh
> index e51eb41f4b..9c9cc4d540 100755
> --- a/t/t6011-rev-list-with-bad-commit.sh
> +++ b/t/t6011-rev-list-with-bad-commit.sh
> @@ -43,6 +43,7 @@ test_expect_success 'corrupt second commit object' \
>=20=20
>  test_expect_success 'rev-list should fail' \
>     '
> +   rm -rf .git/objects/info/commit-graph &&
>     test_must_fail git rev-list --all > /dev/null
>     '
>=20=20
> diff --git a/t/t6024-recursive-merge.sh b/t/t6024-recursive-merge.sh
> index 3f59e58dfb..cec10983cd 100755
> --- a/t/t6024-recursive-merge.sh
> +++ b/t/t6024-recursive-merge.sh
> @@ -61,6 +61,7 @@ GIT_AUTHOR_DATE=3D"2006-12-12 23:00:08" git commit -m F
>  '
>=20=20
>  test_expect_success "combined merge conflicts" "
> +	rm -rf .git/objects/info/commit-graph &&
>  	test_must_fail git merge -m final G
>  "

I wonder though if all those changes to the testsuite shouldn't be
merged.

Regards,
--=20
Jakub Nar=C4=99bski
