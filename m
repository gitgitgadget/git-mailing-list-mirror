Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id C9A611F51C
	for <e@80x24.org>; Sun, 20 May 2018 12:10:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751030AbeETMKs (ORCPT <rfc822;e@80x24.org>);
        Sun, 20 May 2018 08:10:48 -0400
Received: from mail-wm0-f66.google.com ([74.125.82.66]:33097 "EHLO
        mail-wm0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750994AbeETMKr (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 20 May 2018 08:10:47 -0400
Received: by mail-wm0-f66.google.com with SMTP id x12-v6so8783010wmc.0
        for <git@vger.kernel.org>; Sun, 20 May 2018 05:10:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version:content-transfer-encoding;
        bh=Czcg4/DWcTwSkThGa1vvBSNVslqmu7qfk9RQr1+G9a0=;
        b=R0fXizMuwkAkufCBfa1nZR/4ZrbJlMBuO+16aqeY+dRojkFx2MiqTz6IpTOrloxeOF
         l/9pHPlB591wlp/k/Wr1Rs63V4SoJKzKs60pG4P0PcR/C5szXezkF14Dnm0zlH1JTUAG
         uoLdqqbk2WGZUdwGv2XMXQqfIqixCKWIk7WYrawAmKJO7JeT4TTpV+MUzZc2Bdmvi2hw
         aeDNy4aa3rC6usewPdPMhz6lk7dTewi3dGdgWAOX6fvT9MEF6Urp6HOvHtRmlJpGiLi8
         UB/X3958MFNQKwCexn1YuYZuTvCn0QtYemNUJmhnyQK4peDjWhHTwzqVCtyjdPmMo/WD
         owjw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:references:date:in-reply-to
         :message-id:user-agent:mime-version:content-transfer-encoding;
        bh=Czcg4/DWcTwSkThGa1vvBSNVslqmu7qfk9RQr1+G9a0=;
        b=l0ZqeTb68JAnSkMl0kfvdhBBAa6Kgt7puSuTT8QOiO93VzyatUXjVaEEM195YgfX0t
         Ndxx4EyOjIqKGZSWXjMLMebNNx5+4fHpKvYeK17pVUt6dNnygDjnoCfS2wP5U+mNVAOO
         95rcb867JyWXw14WSB6s55EDGqhAFlQ7TinQaQSVD3tJfuEj0BWii+eakchc6wWaP/zQ
         9a0fw2pOqPPlovbMgV9jtfRjQ4PNGIPBi9aEnQjW0AdQs0k43tHYpgyvcGmItbE7X1z+
         VI2pCYExYQjS0ScjwjZJUfsycc0jaUorDSFQs02ahfHDuZhp2UtMF+kv+IYwRBcgfaZA
         4ZlQ==
X-Gm-Message-State: ALKqPwddODAwgXGqD6tuhVDHnmidoYbb1DN5WvDB6lASIyyjRg/1dy2M
        hx8e1vruMUW9gYjcJXA2q+UbstEh
X-Google-Smtp-Source: AB8JxZopPfMSYaDjiAjvujZewtMdgFzGUH4OY5gBAY9QWkvyIfNvt/Dpiws/oo36X+qcevRn2YTTsQ==
X-Received: by 2002:a1c:b20d:: with SMTP id b13-v6mr8742657wmf.130.1526818245936;
        Sun, 20 May 2018 05:10:45 -0700 (PDT)
Received: from Laptop-Acer-Aspire-F15 (abpv179.neoplus.adsl.tpnet.pl. [83.8.63.179])
        by smtp.gmail.com with ESMTPSA id o12-v6sm16132171wrf.31.2018.05.20.05.10.43
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Sun, 20 May 2018 05:10:44 -0700 (PDT)
From:   Jakub Narebski <jnareb@gmail.com>
To:     Derrick Stolee <dstolee@microsoft.com>
Cc:     git@vger.kernel.org, "avarab\@gmail.com" <avarab@gmail.com>,
        "martin.agren\@gmail.com" <martin.agren@gmail.com>,
        "peff\@peff.net" <peff@peff.net>
Subject: Re: [PATCH v2 01/12] commit-graph: add 'verify' subcommand
References: <20180510173345.40577-1-dstolee@microsoft.com>
        <20180511211504.79877-1-dstolee@microsoft.com>
        <20180511211504.79877-2-dstolee@microsoft.com>
Date:   Sun, 20 May 2018 14:10:41 +0200
In-Reply-To: <20180511211504.79877-2-dstolee@microsoft.com> (Derrick Stolee's
        message of "Fri, 11 May 2018 21:15:15 +0000")
Message-ID: <86d0xqeddq.fsf@gmail.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.2 (windows-nt)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Derrick Stolee <dstolee@microsoft.com> writes:

> If the commit-graph file becomes corrupt, we need a way to verify
> that its contents match the object database. In the manner of
> 'git fsck' we will implement a 'git commit-graph verify' subcommand
> to report all issues with the file.
>
> Add the 'verify' subcommand to the 'commit-graph' builtin and its
> documentation. The subcommand is currently a no-op except for
> loading the commit-graph into memory, which may trigger run-time
> errors that would be caught by normal use. Add a simple test that
> ensures the command returns a zero error code.
>
> If no commit-graph file exists, this is an acceptable state. Do
> not report any errors.

All right.  Nice introductory patch.

>
> During review, we noticed that a FREE_AND_NULL(graph_name) was
> placed after a possible 'return', and this pattern was also in
> graph_read(). Fix that case, too.

This should probably be a separate [micro-]patch.  Especially as Martin
=C3=85gren noticed it is not correct...

>
> Signed-off-by: Derrick Stolee <dstolee@microsoft.com>
> ---
>  Documentation/git-commit-graph.txt |  6 ++++++
>  builtin/commit-graph.c             | 40 ++++++++++++++++++++++++++++++++=
+++++-
>  commit-graph.c                     |  5 +++++
>  commit-graph.h                     |  2 ++
>  t/t5318-commit-graph.sh            | 10 ++++++++++
>  5 files changed, 62 insertions(+), 1 deletion(-)
>
> diff --git a/Documentation/git-commit-graph.txt b/Documentation/git-commi=
t-graph.txt
> index 4c97b555cc..a222cfab08 100644
> --- a/Documentation/git-commit-graph.txt
> +++ b/Documentation/git-commit-graph.txt
> @@ -10,6 +10,7 @@ SYNOPSIS
>  --------
>  [verse]
>  'git commit-graph read' [--object-dir <dir>]
> +'git commit-graph verify' [--object-dir <dir>]
>  'git commit-graph write' <options> [--object-dir <dir>]
>=20=20
>=20=20
> @@ -52,6 +53,11 @@ existing commit-graph file.
>  Read a graph file given by the commit-graph file and output basic
>  details about the graph file. Used for debugging purposes.
>=20=20
> +'verify'::
> +
> +Read the commit-graph file and verify its contents against the object
> +database. Used to check for corrupted data.

I wonder if it would be useful to have an option to verify commit-graph
file without accessing the object database, checking just that it is
well formed.

Anyway, it could be added later, if needed.

> +
>=20=20
>  EXAMPLES
>  --------
> diff --git a/builtin/commit-graph.c b/builtin/commit-graph.c
> index 37420ae0fd..af3101291f 100644
> --- a/builtin/commit-graph.c
> +++ b/builtin/commit-graph.c
> @@ -8,10 +8,16 @@
>  static char const * const builtin_commit_graph_usage[] =3D {
>  	N_("git commit-graph [--object-dir <objdir>]"),
>  	N_("git commit-graph read [--object-dir <objdir>]"),
> +	N_("git commit-graph verify [--object-dir <objdir>]"),
>  	N_("git commit-graph write [--object-dir <objdir>] [--append] [--stdin-=
packs|--stdin-commits]"),
>  	NULL
>  };
>=20=20
> +static const char * const builtin_commit_graph_verify_usage[] =3D {
> +	N_("git commit-graph verify [--object-dir <objdir>]"),
> +	NULL
> +};
> +
>  static const char * const builtin_commit_graph_read_usage[] =3D {
>  	N_("git commit-graph read [--object-dir <objdir>]"),
>  	NULL
> @@ -29,6 +35,36 @@ static struct opts_commit_graph {
>  	int append;
>  } opts;
>=20=20
> +
> +static int graph_verify(int argc, const char **argv)

A reminder for myself: exit code 0 means no errors.

> +{
> +	struct commit_graph *graph =3D 0;
> +	char *graph_name;
> +
> +	static struct option builtin_commit_graph_verify_options[] =3D {
> +		OPT_STRING(0, "object-dir", &opts.obj_dir,
> +			   N_("dir"),
> +			   N_("The object directory to store the graph")),
> +		OPT_END(),
> +	};
> +
> +	argc =3D parse_options(argc, argv, NULL,
> +			     builtin_commit_graph_verify_options,
> +			     builtin_commit_graph_verify_usage, 0);
> +
> +	if (!opts.obj_dir)
> +		opts.obj_dir =3D get_object_directory();

All right, simple handling of a subcommand and its options.


I still think that '--object-dir=3D<path>' should be a git wrapper option,
like '--git-dir=3D<path>' and '--work-tree=3D<path>' (and
'--namespace=3D<path>') are.  It would be command-line option equivalent
to the GIT_OBJECT_DIRECTORY environment variable, just like
--git-dir=3D<path> is for GIT_DIR, and --work-tree=3D<path> is for
GIT_WORK_TREE, etc.

This way the code would be implemented once for all commands, and there
would be no duplicated code for each git-commit-graph subcommand.

But that may be a matter of a separate patch.

> +
> +	graph_name =3D get_commit_graph_filename(opts.obj_dir);

This returns full path of commit-graph file, allocating it.

> +	graph =3D load_commit_graph_one(graph_name);

This reads the file (no checking if core.commitGraph is set, no handling
of alternatives), and verifies that:
 - file is not too small, i.e. smaller than GRAPH_MIN_SIZE
 - it has correct signature
 - it has correct graph version
 - it has correct hash version
 - chunk [offsets] fit within file
 - that OID Fanout, OID Lookup, Commit Data and Large Edges chunks are
   not repeated, though not that all required chunks are present

> +	FREE_AND_NULL(graph_name);

All right, graph_name is not used further, so we free it and set it to
NULL.

Note however that if load_commit_graph_one() finds errors, it would exit
with error code 1... but then exiting the process would free its
resources anyway.

> +
> +	if (!graph)
> +		return 0;

The only case where load_commit_graph_one() returns NULL instead of
exiting is if the file cannot be opened for reading (e.g. it does not
exists, or cannot be opened for reading), or its status cannot be read.

Side question: this is nice defensive programming, but could it happen
that file can be opened for reading, but its status cannot be read?

> +
> +	return verify_commit_graph(graph);

Here we leak graph->fd (it is neither unmapped, nor closed) but that may
not matter as we are exiting anyway.  Well, at least until it gets
libified, then maybe.

> +}
> +
>  static int graph_read(int argc, const char **argv)
>  {
>  	struct commit_graph *graph =3D NULL;
> @@ -50,10 +86,10 @@ static int graph_read(int argc, const char **argv)
>=20=20
>  	graph_name =3D get_commit_graph_filename(opts.obj_dir);
>  	graph =3D load_commit_graph_one(graph_name);
> +	FREE_AND_NULL(graph_name);
>=20=20
>  	if (!graph)
>  		die("graph file %s does not exist", graph_name);
> -	FREE_AND_NULL(graph_name);

Here we use graph_name, which has been just freed and set to NULL.

This should probably be (but I may be wrong):


	if (!graph) {
		UNLEAK(graph_name);
		die("graph file %s does not exist", graph_name);
	}
	FREE_AND_NULL(graph_name);


>=20=20
>  	printf("header: %08x %d %d %d %d\n",
>  		ntohl(*(uint32_t*)graph->data),
> @@ -160,6 +196,8 @@ int cmd_commit_graph(int argc, const char **argv, con=
st char *prefix)
>  			     PARSE_OPT_STOP_AT_NON_OPTION);
>=20=20
>  	if (argc > 0) {
> +		if (!strcmp(argv[0], "verify"))
> +			return graph_verify(argc, argv);
>  		if (!strcmp(argv[0], "read"))
>  			return graph_read(argc, argv);
>  		if (!strcmp(argv[0], "write"))

All right, straightforward adding of a new subcommand.

> diff --git a/commit-graph.c b/commit-graph.c
> index a8c337dd77..b25aaed128 100644
> --- a/commit-graph.c
> +++ b/commit-graph.c
> @@ -817,3 +817,8 @@ void write_commit_graph(const char *obj_dir,
>  	oids.alloc =3D 0;
>  	oids.nr =3D 0;
>  }
> +
> +int verify_commit_graph(struct commit_graph *g)
> +{
> +	return !g;
> +}

All right, nice placeholder.

> diff --git a/commit-graph.h b/commit-graph.h
> index 96cccb10f3..71a39c5a57 100644
> --- a/commit-graph.h
> +++ b/commit-graph.h
> @@ -53,4 +53,6 @@ void write_commit_graph(const char *obj_dir,
>  			int nr_commits,
>  			int append);
>=20=20
> +int verify_commit_graph(struct commit_graph *g);
> +
>  #endif
> diff --git a/t/t5318-commit-graph.sh b/t/t5318-commit-graph.sh
> index 77d85aefe7..6ca451dfd2 100755
> --- a/t/t5318-commit-graph.sh
> +++ b/t/t5318-commit-graph.sh
> @@ -11,6 +11,11 @@ test_expect_success 'setup full repo' '
>  	objdir=3D".git/objects"
>  '
>=20=20
> +test_expect_success 'verify graph with no graph file' '
> +	cd "$TRASH_DIRECTORY/full" &&
> +	git commit-graph verify
> +'

Nice to have this test here, but as it is now it is not an independent
test.  It depends on the fact that other earlier tests did not generate
graph file.

Perhaps it would be better to have a separate directory with repository
without commit graph file, and separate directory with repository with
commit graph file.  Or rename commit graph file if it exists, renaming
it back after tests finishes.  Or something like that.

> +
>  test_expect_success 'write graph with no packs' '
>  	cd "$TRASH_DIRECTORY/full" &&
>  	git commit-graph write --object-dir . &&
> @@ -230,4 +235,9 @@ test_expect_success 'perform fast-forward merge in fu=
ll repo' '
>  	test_cmp expect output
>  '
>=20=20
> +test_expect_success 'git commit-graph verify' '
> +	cd "$TRASH_DIRECTORY/full" &&
> +	git commit-graph verify >output
> +'

This is amost the same tests as the one added earlier, the only
difference is its place in t/t5318-commit-graph.sh.  This test is not
independent.

Though I'm not sure if that would matter much.

> +
>  test_done
