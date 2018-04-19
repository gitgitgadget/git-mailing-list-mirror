Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id C5F7A1F404
	for <e@80x24.org>; Thu, 19 Apr 2018 13:24:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752629AbeDSNYK (ORCPT <rfc822;e@80x24.org>);
        Thu, 19 Apr 2018 09:24:10 -0400
Received: from mail-lf0-f66.google.com ([209.85.215.66]:43354 "EHLO
        mail-lf0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752414AbeDSNYJ (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 19 Apr 2018 09:24:09 -0400
Received: by mail-lf0-f66.google.com with SMTP id v207-v6so118829lfa.10
        for <git@vger.kernel.org>; Thu, 19 Apr 2018 06:24:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version:content-transfer-encoding;
        bh=uvESD/W3akTIFbQRsuQpgeWCqsF/yrOdvlgCiEUHwjE=;
        b=Wln68uerjBypWbRaIzafxehKUlmJUpI9YpkpIyknXHTpECHmtCz5x5erRKXyvx9pXn
         AmqJOHm+w0khuY199Yssia9t7pkVRcra4KHPxQdyaowVmA43kPZto8moNNhm4OiTNE8s
         eAv2q7zNv2mG+2kCGLfpsVSwSQOE1TaNMMMCoLjSGYrlBxkk6+aCq200JSru94v2n9Ep
         sVelS5A4BNLP9mCMG82N7w+YF6E/+soeml4Ex1WJr6mO7Q8tsXQvCzOvdy998Ew0jS8G
         aWzyOsIMvSVqCZwO6Ct+EJF9D/mDc0qTSOfpMyqdSZZ+6kJErloqafVhfxxEG6GO9PTR
         Gr2Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:references:date:in-reply-to
         :message-id:user-agent:mime-version:content-transfer-encoding;
        bh=uvESD/W3akTIFbQRsuQpgeWCqsF/yrOdvlgCiEUHwjE=;
        b=fIUoNvi9AQrxLhX9L592KngGOPxemVugbPmsII07zg7vgNFYnczw84nxU/GYAKeVa0
         adnSVgW3Na9y+H69nmgDtRKbLfnNSYPiLWlJVqA8WGrS13xyTsqy4FcaIuyozYxkfyDo
         JcJgChcR9G9uVccIhdBiDoVlfzHDSJaQp9Iug2Qb1pHOiWj9ekhSSMQt5YCzbdD0Vt0C
         jn1WMDpUZMjIGT+wrymDfRUBw3VfbuSAUuHuhc311mCvwLnLrd240JIlB8XJ/G7yOGon
         hX7ozRT4DwXf8673Z8+YNuZHIpF4R5DSJbHPYz5pSmDlRuvPqRbVCeLy7F2siqfKWSgL
         HrKg==
X-Gm-Message-State: ALQs6tA60wT5X9jsytAjke+gXOl/Afr/DUiXTC1AaIg/7I/bYiaSpst/
        PoiDhkmsQj/cGcC9uKmNlsE=
X-Google-Smtp-Source: AB8JxZogJx46Xbfv0WMHmstZiNTpVwvzpS7IIaI1JFLH1VsIGOf14/AYPuFzaiTjPlUWaH/XTyK3jw==
X-Received: by 2002:a19:e206:: with SMTP id z6-v6mr63278lfg.58.1524144247519;
        Thu, 19 Apr 2018 06:24:07 -0700 (PDT)
Received: from Laptop-Acer-Aspire-F15 ([158.75.2.130])
        by smtp.gmail.com with ESMTPSA id d27-v6sm747640lfb.6.2018.04.19.06.24.06
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 19 Apr 2018 06:24:06 -0700 (PDT)
From:   Jakub Narebski <jnareb@gmail.com>
To:     Derrick Stolee <dstolee@microsoft.com>
Cc:     git@vger.kernel.org, "peff\@peff.net" <peff@peff.net>,
        "sbeller\@google.com" <sbeller@google.com>
Subject: Re: [RFC PATCH 02/12] commit-graph: add 'check' subcommand
References: <20180417181028.198397-1-dstolee@microsoft.com>
        <20180417181028.198397-3-dstolee@microsoft.com>
Date:   Thu, 19 Apr 2018 15:24:06 +0200
In-Reply-To: <20180417181028.198397-3-dstolee@microsoft.com> (Derrick Stolee's
        message of "Tue, 17 Apr 2018 18:10:39 +0000")
Message-ID: <86o9iffhxl.fsf@gmail.com>
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
> its contents match the object database. In the manner of 'git fsck'
> we will implement a 'git commit-graph check' subcommand to report
> all issues with the file.

Bikeshed: should the subcommand be called 'check' or 'verify'?

>
> Add the 'check' subcommand to the 'commit-graph' builtin and its
> documentation. Add a simple test that ensures the command returns
> a zero error code.

It would be nice to have the information that the 'check' subcommand is
currently a [almost no-op] stub in the subject... but that might not
have been possible to fit.

>
> Signed-off-by: Derrick Stolee <dstolee@microsoft.com>
> ---
>  Documentation/git-commit-graph.txt |  7 +++++-
>  builtin/commit-graph.c             | 38 ++++++++++++++++++++++++++++++
>  commit-graph.c                     |  5 ++++
>  commit-graph.h                     |  2 ++
>  t/t5318-commit-graph.sh            |  5 ++++
>  5 files changed, 56 insertions(+), 1 deletion(-)
>
> diff --git a/Documentation/git-commit-graph.txt b/Documentation/git-commi=
t-graph.txt
> index 4c97b555cc..93c7841ba2 100644
> --- a/Documentation/git-commit-graph.txt
> +++ b/Documentation/git-commit-graph.txt
> @@ -9,10 +9,10 @@ git-commit-graph - Write and verify Git commit graph fi=
les
>  SYNOPSIS
>  --------
>  [verse]
> +'git commit-graph check' [--object-dir <dir>]
>  'git commit-graph read' [--object-dir <dir>]
>  'git commit-graph write' <options> [--object-dir <dir>]

I still think that [--object-dir <dir>] should be the optional parameter
to the "git" wrapper, not to the "git commit-graph" command, i.e.

   'git [--object-dir=3D<dir>] commit-graph <command>'

But this can be done later, in a separate patch series.

>=20=20
> -

Stray change.

>  DESCRIPTION
>  -----------
>=20=20
> @@ -52,6 +52,11 @@ existing commit-graph file.
>  Read a graph file given by the commit-graph file and output basic
>  details about the graph file. Used for debugging purposes.
>=20=20
> +'check'::
> +
> +Read the commit-graph file and verify its contents against the object
> +database. Used to check for corrupted data.
> +

I wonder if we should offer to verify file without checking against the
object database (which is the costly part, I think).  But this too can
be added later if needed.

>=20=20
>  EXAMPLES
>  --------
> diff --git a/builtin/commit-graph.c b/builtin/commit-graph.c
> index 37420ae0fd..77c1a04932 100644
> --- a/builtin/commit-graph.c
> +++ b/builtin/commit-graph.c
> @@ -7,11 +7,17 @@
>=20=20
>  static char const * const builtin_commit_graph_usage[] =3D {
>  	N_("git commit-graph [--object-dir <objdir>]"),
> +	N_("git commit-graph check [--object-dir <objdir>]"),
>  	N_("git commit-graph read [--object-dir <objdir>]"),
>  	N_("git commit-graph write [--object-dir <objdir>] [--append] [--stdin-=
packs|--stdin-commits]"),
>  	NULL

Isn't the case that each command would support the
[--object-dir <objdir>] parameter?

>  };
>=20=20
> +static const char * const builtin_commit_graph_check_usage[] =3D {
> +	N_("git commit-graph check [--object-dir <objdir>]"),
> +	NULL
> +};
> +

Looks good to me.

>  static const char * const builtin_commit_graph_read_usage[] =3D {
>  	N_("git commit-graph read [--object-dir <objdir>]"),
>  	NULL
> @@ -29,6 +35,36 @@ static struct opts_commit_graph {
>  	int append;
>  } opts;
>=20=20
> +
> +static int graph_check(int argc, const char **argv)
> +{
> +	struct commit_graph *graph =3D 0;

This is NULL, isn't it?  Shouldn't it be stated as such?

> +	char *graph_name;
> +
> +	static struct option builtin_commit_graph_check_options[] =3D {
> +		OPT_STRING(0, "object-dir", &opts.obj_dir,
> +			   N_("dir"),
> +			   N_("The object directory to store the graph")),

This again is not the directory to _store_ the graph; this is the
directory to _read_ graph from, or directory where the commit graph is
_stored_.

> +		OPT_END(),
> +	};
> +
> +	argc =3D parse_options(argc, argv, NULL,
> +			     builtin_commit_graph_check_options,
> +			     builtin_commit_graph_check_usage, 0);
> +
> +	if (!opts.obj_dir)
> +		opts.obj_dir =3D get_object_directory();
> +
> +	graph_name =3D get_commit_graph_filename(opts.obj_dir);
> +	graph =3D load_commit_graph_one(graph_name);
> +
> +	if (!graph)
> +		die("graph file %s does not exist", graph_name);

Shouldn't we quote pathname?  Shouldn't this error message be marked for
translation?  Shouldn't we use "commit graph file" explicitly?

> +	FREE_AND_NULL(graph_name);
> +
> +	return check_commit_graph(graph);
> +}
> +
>  static int graph_read(int argc, const char **argv)
>  {
>  	struct commit_graph *graph =3D NULL;
> @@ -160,6 +196,8 @@ int cmd_commit_graph(int argc, const char **argv, con=
st char *prefix)
>  			     PARSE_OPT_STOP_AT_NON_OPTION);
>=20=20
>  	if (argc > 0) {
> +		if (!strcmp(argv[0], "check"))
> +			return graph_check(argc, argv);
>  		if (!strcmp(argv[0], "read"))
>  			return graph_read(argc, argv);
>  		if (!strcmp(argv[0], "write"))
> diff --git a/commit-graph.c b/commit-graph.c
> index 3f0c142603..cd0634bba0 100644
> --- a/commit-graph.c
> +++ b/commit-graph.c
> @@ -819,3 +819,8 @@ void write_commit_graph(const char *obj_dir,
>  	oids.alloc =3D 0;
>  	oids.nr =3D 0;
>  }
> +
> +int check_commit_graph(struct commit_graph *g)
> +{
> +	return !g;
> +}

I understand that it is just a start of implementing this feature, but
it looks a bit strange that 'read' command does more sanity checks that
the 'check' command...

> diff --git a/commit-graph.h b/commit-graph.h
> index 96cccb10f3..e8c8d99dff 100644
> --- a/commit-graph.h
> +++ b/commit-graph.h
> @@ -53,4 +53,6 @@ void write_commit_graph(const char *obj_dir,
>  			int nr_commits,
>  			int append);
>=20=20
> +int check_commit_graph(struct commit_graph *g);
> +
>  #endif
> diff --git a/t/t5318-commit-graph.sh b/t/t5318-commit-graph.sh
> index 77d85aefe7..e91053271a 100755
> --- a/t/t5318-commit-graph.sh
> +++ b/t/t5318-commit-graph.sh
> @@ -230,4 +230,9 @@ test_expect_success 'perform fast-forward merge in fu=
ll repo' '
>  	test_cmp expect output
>  '
>=20=20
> +test_expect_success 'git commit-graph check' '
> +	cd "$TRASH_DIRECTORY/full" &&
> +	git commit-graph check >output
> +'

There should also be negative check, that 'git commit-graph check' fails
if there is no commit-graph file, isn't it?

> +
>  test_done

Best,
--=20
Jakub Nar=C4=99bski
