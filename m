Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	FROM_EXCESS_BASE64,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id F086A1F453
	for <e@80x24.org>; Sat, 27 Apr 2019 13:06:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726501AbfD0NGU (ORCPT <rfc822;e@80x24.org>);
        Sat, 27 Apr 2019 09:06:20 -0400
Received: from mail-ed1-f65.google.com ([209.85.208.65]:35308 "EHLO
        mail-ed1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726345AbfD0NGU (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 27 Apr 2019 09:06:20 -0400
Received: by mail-ed1-f65.google.com with SMTP id y67so5431590ede.2
        for <git@vger.kernel.org>; Sat, 27 Apr 2019 06:06:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:references:user-agent:in-reply-to:date
         :message-id:mime-version:content-transfer-encoding;
        bh=PZtuSQpjAanlE4djz3cL5qxgSUyX/g1S18DvrLp5UbM=;
        b=qlix2fnNxiFLJuP60YTAlWLi95e1hj30wR71Ybygr7sjbrnrzeDFktyKUvy9793uPa
         64IEhzf2VfFWUR6uAtvso3pNqRZFjG2ARBVnCg5qbdUY3WNfIj7lFR5/U1NXq/dr0oqR
         LpzMB3E4e9hqQKO7CMt7Z8FKMJ3FUl0xQINY7VMlMDIsXQrmJKYDYCUOYEHkCywpnFQc
         J4cq3qBmqIUN7llV4+n2MtC3SY1Nqqy+9w5gBNLeKT99emkNDIS/LfBHxOEWY9Ln3En5
         45U+Snt2WyAMM/qoQ3JbU7eiobIX5/EMGos8IiFjqZ+c6RFzkl2cvVnEMOWZDBbMqdV4
         sWOw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:references:user-agent
         :in-reply-to:date:message-id:mime-version:content-transfer-encoding;
        bh=PZtuSQpjAanlE4djz3cL5qxgSUyX/g1S18DvrLp5UbM=;
        b=qfJ7JcMJ+yW0oLcCg0OXW4CxKnrRr6T5ufwJIhniB+tloECR1GBWwSCMNu9s0sVwpH
         pkDZIwiXUPlbv6PkeMQanm2ihe5Xmgloub2VodqFFl33dOYQ5Q9BigiYrERpc/INTEuA
         QHiuGtNDur4xaYy9cQLzcz2FCcD/ze0MopTKGka0+5ll2pK7BQxMpZJDj1bmWRo4YtgW
         lYrugyWeTG0S4hTifLHFBxSi052KS4ws3fco0aekvIOrkUZCBfTLVENgp2Ar8SIAkc3d
         Iucv4q2mtW3pBGNjG+VtpGvk00cR9JRY/Owi1uKECuIUoRqzXAoGHCE4kjvdoMC77VE1
         DGEQ==
X-Gm-Message-State: APjAAAXlAhOLejSMwxko72Lu2kg7RD0DYfsNcxRoiTNCaxkonIHa4CMG
        Jso10MHXfXSg1FN0GveXhghIPkT+
X-Google-Smtp-Source: APXvYqwO36z7NleGwS/vpQWHVsvMpDcmOuLSy4mxJTJK7zz8AwRdtDrJoackezlRVQRcNZZuYEJ8GQ==
X-Received: by 2002:a17:906:7c0b:: with SMTP id t11mr15367786ejo.100.1556370377523;
        Sat, 27 Apr 2019 06:06:17 -0700 (PDT)
Received: from evledraar (dhcp-077-251-215-224.chello.nl. [77.251.215.224])
        by smtp.gmail.com with ESMTPSA id r4sm1299918edp.78.2019.04.27.06.06.16
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Sat, 27 Apr 2019 06:06:16 -0700 (PDT)
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        Derrick Stolee <stolee@gmail.com>,
        SZEDER =?utf-8?Q?G=C3=A1bor?= <szeder.dev@gmail.com>,
        Eric Sunshine <sunshine@sunshineco.com>,
        Ramsay Jones <ramsay@ramsayjones.plus.com>
Subject: Re: [PATCH v3 4/8] commit-graph: don't early exit(1) on e.g. "git status"
References: <20190314214740.23360-1-avarab@gmail.com> <20190325120834.15529-5-avarab@gmail.com>
User-agent: Debian GNU/Linux buster/sid; Emacs 26.1; mu4e 1.1.0
In-reply-to: <20190325120834.15529-5-avarab@gmail.com>
Date:   Sat, 27 Apr 2019 15:06:15 +0200
Message-ID: <87y33vr41k.fsf@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Mon, Mar 25 2019, =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason wrote:

> Make the commit-graph loading code work as a library that returns an
> error code instead of calling exit(1) when the commit-graph is
> corrupt. This means that e.g. "status" will now report commit-graph
> corruption as an "error: [...]" at the top of its output, but then
> proceed to work normally.
>
> This required splitting up the load_commit_graph_one() function so
> that the code that deals with open()-ing and stat()-ing the graph can
> now be called independently as open_commit_graph().
>
> This is needed because "commit-graph verify" where the graph doesn't
> exist isn't an error. See the third paragraph in
> 283e68c72f ("commit-graph: add 'verify' subcommand",
> 2018-06-27). There's a bug in that logic where we conflate the
> intended ENOENT with other errno values (e.g. EACCES), but this change
> doesn't address that. That'll be addressed in a follow-up change.
>
> I'm then splitting most of the logic out of load_commit_graph_one()
> into load_commit_graph_one_fd_st(), which allows for providing an
> existing file descriptor and stat information to the loading
> code. This isn't strictly needed, but it would be redundant and
> confusing to open() and stat() the file twice for some of the
> codepaths, this allows for calling open_commit_graph() followed by
> load_commit_graph_one_fd_st(). The "graph_file" still needs to be
> passed to that function for the the "graph file %s is too small" error
> message.
>
> This leaves load_commit_graph_one() unused by everything except the
> internal prepare_commit_graph_one() function, so let's mark it as
> "static". If someone needs it in the future we can remove the "static"
> attribute. I could also rewrite its sole remaining
> user ("prepare_commit_graph_one()") to use
> load_commit_graph_one_fd_st() instead, but let's leave it at this.
>
> Signed-off-by: =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason <avarab@gmail.com>
> Signed-off-by: Ramsay Jones <ramsay@ramsayjones.plus.com>
> ---
>  builtin/commit-graph.c  | 21 +++++++++++++++++----
>  commit-graph.c          | 42 +++++++++++++++++++++++++++++------------
>  commit-graph.h          |  4 +++-
>  t/t5318-commit-graph.sh |  2 +-
>  4 files changed, 51 insertions(+), 18 deletions(-)
>
> diff --git a/builtin/commit-graph.c b/builtin/commit-graph.c
> index 4ae502754c..32bcc63427 100644
> --- a/builtin/commit-graph.c
> +++ b/builtin/commit-graph.c
> @@ -42,6 +42,9 @@ static int graph_verify(int argc, const char **argv)
>  {
>  	struct commit_graph *graph =3D NULL;
>  	char *graph_name;
> +	int open_ok;
> +	int fd;
> +	struct stat st;
>
>  	static struct option builtin_commit_graph_verify_options[] =3D {
>  		OPT_STRING(0, "object-dir", &opts.obj_dir,
> @@ -58,11 +61,14 @@ static int graph_verify(int argc, const char **argv)
>  		opts.obj_dir =3D get_object_directory();
>
>  	graph_name =3D get_commit_graph_filename(opts.obj_dir);
> -	graph =3D load_commit_graph_one(graph_name);
> +	open_ok =3D open_commit_graph(graph_name, &fd, &st);
> +	if (!open_ok)
> +		return 0;
> +	graph =3D load_commit_graph_one_fd_st(graph_name, fd, &st);
>  	FREE_AND_NULL(graph_name);
>
>  	if (!graph)
> -		return 0;
> +		return 1;
>
>  	UNLEAK(graph);
>  	return verify_commit_graph(the_repository, graph);
> @@ -72,6 +78,9 @@ static int graph_read(int argc, const char **argv)
>  {
>  	struct commit_graph *graph =3D NULL;
>  	char *graph_name;
> +	int open_ok;
> +	int fd;
> +	struct stat st;
>
>  	static struct option builtin_commit_graph_read_options[] =3D {
>  		OPT_STRING(0, "object-dir", &opts.obj_dir,
> @@ -88,10 +97,14 @@ static int graph_read(int argc, const char **argv)
>  		opts.obj_dir =3D get_object_directory();
>
>  	graph_name =3D get_commit_graph_filename(opts.obj_dir);
> -	graph =3D load_commit_graph_one(graph_name);
>
> +	open_ok =3D open_commit_graph(graph_name, &fd, &st);
> +	if (!open_ok)
> +		die_errno(_("Could not open commit-graph '%s'"), graph_name);
> +
> +	graph =3D load_commit_graph_one_fd_st(graph_name, fd, &st);
>  	if (!graph)
> -		die("graph file %s does not exist", graph_name);
> +		return 1;
>
>  	FREE_AND_NULL(graph_name);
>
> diff --git a/commit-graph.c b/commit-graph.c
> index f8201d888b..3acc032c1b 100644
> --- a/commit-graph.c
> +++ b/commit-graph.c
> @@ -80,25 +80,31 @@ static int commit_graph_compatible(struct repository =
*r)
>  	return 1;
>  }
>
> -struct commit_graph *load_commit_graph_one(const char *graph_file)
> +int open_commit_graph(const char *graph_file, int *fd, struct stat *st)
> +{
> +	*fd =3D git_open(graph_file);
> +	if (*fd < 0)
> +		return 0;
> +	if (fstat(*fd, st)) {
> +		close(*fd);
> +		return 0;
> +	}
> +	return 1;
> +}
> +
> +struct commit_graph *load_commit_graph_one_fd_st(const char *graph_file,
> +						 int fd, struct stat *st)
>  {
>  	void *graph_map;
>  	size_t graph_size;
> -	struct stat st;
>  	struct commit_graph *ret;
> -	int fd =3D git_open(graph_file);
>
> -	if (fd < 0)
> -		return NULL;
> -	if (fstat(fd, &st)) {
> -		close(fd);
> -		return NULL;
> -	}
> -	graph_size =3D xsize_t(st.st_size);
> +	graph_size =3D xsize_t(st->st_size);
>
>  	if (graph_size < GRAPH_MIN_SIZE) {
>  		close(fd);
> -		die(_("graph file %s is too small"), graph_file);
> +		error(_("graph file %s is too small"), graph_file);
> +		return NULL;
>  	}
>  	graph_map =3D xmmap(NULL, graph_size, PROT_READ, MAP_PRIVATE, fd, 0);
>  	ret =3D parse_commit_graph(graph_map, fd, graph_size);
> @@ -106,7 +112,6 @@ struct commit_graph *load_commit_graph_one(const char=
 *graph_file)
>  	if (!ret) {
>  		munmap(graph_map, graph_size);
>  		close(fd);
> -		exit(1);
>  	}
>
>  	return ret;
> @@ -269,6 +274,19 @@ struct commit_graph *parse_commit_graph(void *graph_=
map, int fd,
>  	return graph;
>  }
>
> +static struct commit_graph *load_commit_graph_one(const char *graph_file)
> +{
> +
> +	struct stat st;
> +	int fd;
> +	int open_ok =3D open_commit_graph(graph_file, &fd, &st);
> +
> +	if (!open_ok)
> +		return NULL;
> +
> +	return load_commit_graph_one_fd_st(graph_file, fd, &st);
> +}
> +
>  static void prepare_commit_graph_one(struct repository *r, const char *o=
bj_dir)
>  {
>  	char *graph_name;
> diff --git a/commit-graph.h b/commit-graph.h
> index 096d8bac34..77cc739bc0 100644
> --- a/commit-graph.h
> +++ b/commit-graph.h
> @@ -11,6 +11,7 @@
>  struct commit;
>
>  char *get_commit_graph_filename(const char *obj_dir);
> +int open_commit_graph(const char *graph_file, int *fd, struct stat *st);
>
>  /*
>   * Given a commit struct, try to fill the commit struct info, including:
> @@ -52,7 +53,8 @@ struct commit_graph {
>  	const unsigned char *chunk_extra_edges;
>  };
>
> -struct commit_graph *load_commit_graph_one(const char *graph_file);
> +struct commit_graph *load_commit_graph_one_fd_st(const char *graph_file,
> +						 int fd, struct stat *st);
>
>  struct commit_graph *parse_commit_graph(void *graph_map, int fd,
>  					size_t graph_size);
> diff --git a/t/t5318-commit-graph.sh b/t/t5318-commit-graph.sh
> index ad3a695f76..71d775e313 100755
> --- a/t/t5318-commit-graph.sh
> +++ b/t/t5318-commit-graph.sh
> @@ -377,7 +377,7 @@ corrupt_graph_verify() {
>  	test_must_fail git commit-graph verify 2>test_err &&
>  	grep -v "^+" test_err >err &&
>  	test_i18ngrep "$grepstr" err &&
> -	test_might_fail git status --short
> +	git status --short
>  }
>
>  # usage: corrupt_graph_and_verify <position> <data> <string> [<zero_pos>]

There's still cases left where we'll exit early, e.g. if you do:

    $ git diff -U1
    diff --git a/commit-graph.c b/commit-graph.c
    index 66865acbd7..63773764ce 100644
    --- a/commit-graph.c
    +++ b/commit-graph.c
    @@ -1074,3 +1074,3 @@ void write_commit_graph(const char *obj_dir,
            chunk_offsets[1] =3D chunk_offsets[0] + GRAPH_FANOUT_SIZE;
    -       chunk_offsets[2] =3D chunk_offsets[1] + hashsz * commits.nr;
    +       chunk_offsets[2] =3D chunk_offsets[0] + hashsz * commits.nr;
            chunk_offsets[3] =3D chunk_offsets[2] + (hashsz + 16) * commits=
.nr;

Which is obviously bad, but something I encounterd while hacking up [1]
we'll still hard die as before this patch on:

    $ git status
    fatal: invalid parent position 1734910766
    $

Stacktrace:

    (gdb) bt
    #0  die (err=3D0x5555558008cd "invalid parent position %lu") at usage.c=
:153
    #1  0x000055555565e88c in insert_parent_or_die (r=3D0x5555558d6320 <the=
_repo>, g=3D0x5555559d4ff0, pos=3D1734910766, pptr=3D0x5555559c0f00) at com=
mit-graph.c:383
    #2  0x000055555565eae0 in fill_commit_in_graph (r=3D0x5555558d6320 <the=
_repo>, item=3D0x5555559c0ed0, g=3D0x5555559d4ff0, pos=3D102470) at commit-=
graph.c:426
    #3  0x000055555565ec56 in parse_commit_in_graph_one (r=3D0x5555558d6320=
 <the_repo>, g=3D0x5555559d4ff0, item=3D0x5555559c0ed0) at commit-graph.c:4=
69
    #4  0x000055555565eca5 in parse_commit_in_graph (r=3D0x5555558d6320 <th=
e_repo>, item=3D0x5555559c0ed0) at commit-graph.c:478
    #5  0x000055555565aaf4 in repo_parse_commit_internal (r=3D0x5555558d632=
0 <the_repo>, item=3D0x5555559c0ed0, quiet_on_missing=3D0, use_commit_graph=
=3D1) at commit.c:465
    #6  0x000055555565ac32 in repo_parse_commit_gently (r=3D0x5555558d6320 =
<the_repo>, item=3D0x5555559c0ed0, quiet_on_missing=3D0) at commit.c:490
    #7  0x000055555573347f in repo_parse_commit (r=3D0x5555558d6320 <the_re=
po>, item=3D0x5555559c0ed0) at commit.h:90
    #8  0x0000555555734764 in get_reference (revs=3D0x7fffffffcf50, name=3D=
0x55555582ceb8 "HEAD", oid=3D0x7fffffffce60, flags=3D0) at revision.c:365
    #9  0x000055555573b0e2 in setup_revisions (argc=3D0, argv=3D0x0, revs=
=3D0x7fffffffcf50, opt=3D0x7fffffffcf30) at revision.c:2611
    #10 0x00005555557a6985 in wt_status_collect_changes_index (s=3D0x555555=
8a3de0 <s>) at wt-status.c:618
    #11 0x00005555557a70a5 in wt_status_collect (s=3D0x5555558a3de0 <s>) at=
 wt-status.c:761
    #12 0x0000555555595ede in cmd_status (argc=3D0, argv=3D0x7fffffffdda8, =
prefix=3D0x0) at builtin/commit.c:1408
    #13 0x000055555556f8a2 in run_builtin (p=3D0x5555558931a8 <commands+256=
8>, argc=3D1, argv=3D0x7fffffffdda8) at git.c:444
    #14 0x000055555556fbe3 in handle_builtin (argc=3D1, argv=3D0x7fffffffdd=
a8) at git.c:676
    #15 0x000055555556fe4d in run_argv (argcp=3D0x7fffffffdc4c, argv=3D0x7f=
ffffffdc40) at git.c:743
    #16 0x000055555557014b in cmd_main (argc=3D1, argv=3D0x7fffffffdda8) at=
 git.c:877
    #17 0x000055555562d6d2 in main (argc=3D3, argv=3D0x7fffffffdd98) at com=
mon-main.c:50

I might (or not) get to this some other time, meanwhile sending an
E-Mail report...

1. https://public-inbox.org/git/87zhobr4fl.fsf@evledraar.gmail.com/
