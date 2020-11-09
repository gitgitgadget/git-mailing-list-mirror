Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.0 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5E70DC2D0A3
	for <git@archiver.kernel.org>; Mon,  9 Nov 2020 14:46:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 08A412065D
	for <git@archiver.kernel.org>; Mon,  9 Nov 2020 14:46:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=gmx.net header.i=@gmx.net header.b="TVNqiehb"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731732AbgKIOqU (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 9 Nov 2020 09:46:20 -0500
Received: from mout.gmx.net ([212.227.17.22]:37929 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730649AbgKIOqS (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 9 Nov 2020 09:46:18 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1604933167;
        bh=xj7N+Y4HEnvYHrRQMphyu0nYV7L6phE1gW8nRrRUeng=;
        h=X-UI-Sender-Class:Date:From:To:cc:Subject:In-Reply-To:References;
        b=TVNqiehbZIXaYgpio7z1wiyrAqy8zgl9NX5mKXlU9qQGZLl+tnODavYP0AHv71OSY
         erFvWZvdH3NF/5OfZpQpQHNr23XrUTLF49RYmrJcEquph24TO8l4aBMe7AyJGlgpiT
         6326EUbQEZ0DV3K0uDyBrGD6Qnb4P5ictSgcXaM0=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [172.26.25.62] ([213.196.212.205]) by mail.gmx.com (mrgmx104
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1MXGr8-1kojcv2PsM-00YeGi; Mon, 09
 Nov 2020 15:46:07 +0100
Date:   Mon, 9 Nov 2020 15:46:13 +0100 (CET)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@gitforwindows.org
To:     "brian m. carlson" <sandals@crustytoothpaste.net>
cc:     git@vger.kernel.org,
        =?UTF-8?Q?SZEDER_G=C3=A1bor?= <szeder.dev@gmail.com>
Subject: Re: [PATCH v2 2/2] rev-parse: add option for absolute or relative
 path formatting
In-Reply-To: <20201009191511.267461-3-sandals@crustytoothpaste.net>
Message-ID: <nycvar.QRO.7.76.6.2011091457300.18437@tvgsbejvaqbjf.bet>
References: <20201009191511.267461-1-sandals@crustytoothpaste.net> <20201009191511.267461-3-sandals@crustytoothpaste.net>
User-Agent: Alpine 2.21.1 (DEB 209 2017-03-23)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K1:LJ63x170cyV8MY/dB/qoN0qo4nOZgZ0e1T8RNH4cIb5Fx0di7nw
 ApRpVIMoB+/FR/XRQNfhzCYtPC8aSJii/PREIubguLFA+xiKx+3XW4/0Az0p+IMF9l7/42A
 nZTy3dQgU6L3dB2RCR7m8XDBpJHk/5guSI9BuH+Cm/DI/dzhJNk6AZTrPJXdWTnMg1Kh9p3
 ppDW/uALhkOBnNRtb58vQ==
X-UI-Out-Filterresults: notjunk:1;V03:K0:xQjKQL91W8c=:UNMkYd2PycIEXpM2FH+arl
 XMJW3+YqfqbgIqvDFiozQJd75BBCePG8GtypMB8+6cVsAy8RoyoG7SiuQngsEHI73ofNkKBxi
 LL4C6h/KTX45jOklveSZLOAHh73l6FiLsdHExiRzIPyEMDbQdcNs8kC6w1DTRAbSYetgz7pYK
 Cb7fswUs/pFcSJ5DVd4j/cGQRjxwij0kuBVaotw4uoMjjPgjCM5sbLsLi0dG6Hu0CnhmsYoo8
 XXIYITXEFSaeiJRHbXvyHSTxF7Q0fpxeNFBdTQqBQGQDRml8GQ128K5QXBhYzjTWRDbB9TTxS
 bmOI4NjcRHtNU2ErG9VgRwHW2Rzkl3HESvTHN5ksYkd1eRgaf0EaOaFcE/d5LWNSlJtTBLb2d
 tA8zgzzNQGeUO9ud8IpQsHNB6txHx2xheNcRLz1fC4f8FYERag5wWRqJBBXDwBzBqtQNGaO2Z
 NmgNkD4pYE++M32bi3b99jVBT0Hl2xpkS7N4qz+X6MtPbDv9RLpcJxoTmqzoCUHlEITa/npW0
 Z5e/x58iHjQ6PROoTZmCKfr76Nq0/7TuiA5T2osb8kR6r+5CohauYNTMRl4FAG5Z/533At0fn
 IucIpJMybxYTUWbo+uJ82Iuh3YwvrkTNDULqDUKqIz2xatBtu80HcYsx3gz36RbiqygtD+JDa
 ZVzIEElQdoAycz1s9wJaeJNXDhXy1SSo3t5+xVXKyreUBQQ9z4+CoMyMO8AIjbE54CWyoyvDU
 XmemI3q+yT44s2ZemLX9q3tbLc8U3DxO6SuVfMDvEDRPrZoxLyVdBlcP9bS9K7XAQrZIg0eFq
 P16NO0AlpMcbU/LwlQo5G6g5L410v598nQKuPk4eADVMAMpG3R9KCM3uXKh2D26ILTERwuIdg
 dT2eo7smvSc0iSIKDt+0yIWomotGfyeyuFlphR/mY=
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi brian,

On Fri, 9 Oct 2020, brian m. carlson wrote:

> git rev-parse has several options which print various paths.  Some of
> these paths are printed relative to the current working directory, and
> some are absolute.
>
> Normally, this is not a problem, but there are times when one wants
> paths entirely in one format or another.  This can be done trivially if
> the paths are canonical, but canonicalizing paths is not possible on
> some shell scripting environments which lack realpath(1) and also in Go,
> which lacks functions that properly canonicalize paths on Windows.
>
> To help out the scripter, let's provide an option which turns most of
> the paths printed by git rev-parse to be either relative to the current
> working directory or absolute and canonical.  Document which options are
> affected and which are not so that users are not confused.
>
> This approach is cleaner and tidier than providing duplicates of
> existing options which are either relative or absolute.
>
> Note that if the user needs both forms, it is possible to pass an
> additional option in the middle of the command line which changes the
> behavior of subsequent operations.

Good.

> diff --git a/builtin/rev-parse.c b/builtin/rev-parse.c
> index ed200c8af1..ec62b4cd16 100644
> --- a/builtin/rev-parse.c
> +++ b/builtin/rev-parse.c
> @@ -583,6 +583,76 @@ static void handle_ref_opt(const char *pattern, con=
st char *prefix)
>  	clear_ref_exclusion(&ref_excludes);
>  }
>
> +enum format_type {
> +	/* We would like a relative path. */
> +	FORMAT_RELATIVE,
> +	/* We would like a canonical absolute path. */
> +	FORMAT_CANONICAL,
> +	/* We would like the default behavior. */
> +	FORMAT_DEFAULT,
> +};
> +
> +enum default_type {
> +	/* Our default is a relative path. */
> +	DEFAULT_RELATIVE,
> +	/* Our default is a relative path if there's a shared root. */
> +	DEFAULT_RELATIVE_IF_SHARED,
> +	/* Our default is a canonical absolute path. */
> +	DEFAULT_CANONICAL,
> +	/* Our default is not to modify the item. */
> +	DEFAULT_UNMODIFIED,
> +};

I wonder whether it would make sense to consolidate these two enums into a
single one.

> +static void print_path(const char *path, const char *prefix, enum forma=
t_type format, enum default_type def)
> +{
> +	char *cwd =3D NULL;
> +	/*
> +	 * We don't ever produce a relative path if prefix is NULL, so set the
> +	 * prefix to the current directory so that we can produce a relative
> +	 * path whenever possible.  If we're using RELATIVE_IF_SHARED mode, th=
en
> +	 * we want an absolute path unless the two share a common prefix, so d=
on't
> +	 * set it in that case, since doing so causes a relative path to alway=
s
> +	 * be produced if possible.
> +	 */
> +	if (!prefix && (format !=3D FORMAT_DEFAULT || def !=3D DEFAULT_RELATIV=
E_IF_SHARED))
> +		prefix =3D cwd =3D xgetcwd();
> +	if (format =3D=3D FORMAT_DEFAULT && def =3D=3D DEFAULT_UNMODIFIED) {
> +		puts(path);
> +	} else if (format =3D=3D FORMAT_RELATIVE ||
> +		  (format =3D=3D FORMAT_DEFAULT && def =3D=3D DEFAULT_RELATIVE)) {
> +		/*
> +		 * In order for relative_path to work as expected, we need to
> +		 * make sure that both paths are absolute paths.  If we don't,
> +		 * we can end up with an unexpected absolute path that the user
> +		 * didn't want.
> +		 */
> +		struct strbuf buf =3D STRBUF_INIT, realbuf =3D STRBUF_INIT, prefixbuf=
 =3D STRBUF_INIT;
> +		if (!is_absolute_path(path)) {
> +			if (!strbuf_realpath_missing(&realbuf, path))
> +				die(_("Unable to resolve path '%s'"), path);
> +			path =3D realbuf.buf;
> +		}
> +		if (!is_absolute_path(prefix)) {
> +			if (!strbuf_realpath_missing(&prefixbuf, prefix))
> +				die(_("Unable to resolve path '%s'"), path);
> +			prefix =3D prefixbuf.buf;
> +		}
> +		puts(relative_path(path, prefix, &buf));
> +		strbuf_release(&buf);
> +	} else if (format =3D=3D FORMAT_DEFAULT && def =3D=3D DEFAULT_RELATIVE=
_IF_SHARED) {
> +		struct strbuf buf =3D STRBUF_INIT;
> +		puts(relative_path(path, prefix, &buf));
> +		strbuf_release(&buf);
> +	} else {
> +		struct strbuf buf =3D STRBUF_INIT;
> +		if (!strbuf_realpath_missing(&buf, path))
> +			die(_("Unable to resolve path '%s'"), path);
> +		puts(buf.buf);
> +		strbuf_release(&buf);
> +	}
> +	free(cwd);
> +}
> +
>  int cmd_rev_parse(int argc, const char **argv, const char *prefix)
>  {
>  	int i, as_is =3D 0, verify =3D 0, quiet =3D 0, revs_count =3D 0, type =
=3D 0;
> @@ -595,6 +665,7 @@ int cmd_rev_parse(int argc, const char **argv, const=
 char *prefix)
>  	struct object_context unused;
>  	struct strbuf buf =3D STRBUF_INIT;
>  	const int hexsz =3D the_hash_algo->hexsz;
> +	enum format_type format =3D FORMAT_DEFAULT;
>
>  	if (argc > 1 && !strcmp("--parseopt", argv[1]))
>  		return cmd_parseopt(argc - 1, argv + 1, prefix);
> @@ -650,8 +721,7 @@ int cmd_rev_parse(int argc, const char **argv, const=
 char *prefix)
>  			if (!argv[i + 1])
>  				die("--git-path requires an argument");
>  			strbuf_reset(&buf);
> -			puts(relative_path(git_path("%s", argv[i + 1]),
> -					   prefix, &buf));
> +			print_path(git_path("%s", argv[i + 1]), prefix, format, DEFAULT_RELA=
TIVE_IF_SHARED);

One thing that the original code did was to reuse the same `strbuf`. Not
sure whether this matters in practice.

>  			i++;
>  			continue;
>  		}
> @@ -683,6 +753,16 @@ int cmd_rev_parse(int argc, const char **argv, cons=
t char *prefix)
>  					show_file(arg, 0);
>  				continue;
>  			}
> +			if (opt_with_value(arg, "--path-format", &arg)) {
> +				if (!strcmp(arg, "absolute")) {
> +					format =3D FORMAT_CANONICAL;
> +				} else if (!strcmp(arg, "relative")) {
> +					format =3D FORMAT_RELATIVE;
> +				} else {
> +					die("unknown argument to --path-format: %s", arg);
> +				}
> +				continue;
> +			}
>  			if (!strcmp(arg, "--default")) {
>  				def =3D argv[++i];
>  				if (!def)
> @@ -803,7 +883,7 @@ int cmd_rev_parse(int argc, const char **argv, const=
 char *prefix)
>  			if (!strcmp(arg, "--show-toplevel")) {
>  				const char *work_tree =3D get_git_work_tree();
>  				if (work_tree)
> -					puts(work_tree);
> +					print_path(work_tree, prefix, format, DEFAULT_CANONICAL);

The way `print_path()`'s code is structured, it is not immediately obvious
to me whether the patch changes behavior here. I _suspect_ that we're now
calling `strbuf_realpath_missing()` and react to its return value, which
is different from before.

Wouldn't make `DEFAULT_UNMODIFIED` make more sense here?

>  				else
>  					die("this operation must be run in a work tree");
>  				continue;
> @@ -811,7 +891,7 @@ int cmd_rev_parse(int argc, const char **argv, const=
 char *prefix)
>  			if (!strcmp(arg, "--show-superproject-working-tree")) {
>  				struct strbuf superproject =3D STRBUF_INIT;
>  				if (get_superproject_working_tree(&superproject))
> -					puts(superproject.buf);
> +					print_path(superproject.buf, prefix, format, DEFAULT_CANONICAL);

Shouldn't this be `DEFAULT_UNMODIFIED`?

>  				strbuf_release(&superproject);
>  				continue;
>  			}
> @@ -846,16 +926,18 @@ int cmd_rev_parse(int argc, const char **argv, con=
st char *prefix)
>  				const char *gitdir =3D getenv(GIT_DIR_ENVIRONMENT);
>  				char *cwd;
>  				int len;
> +				enum format_type wanted =3D format;
>  				if (arg[2] =3D=3D 'g') {	/* --git-dir */
>  					if (gitdir) {
> -						puts(gitdir);
> +						print_path(gitdir, prefix, format, DEFAULT_UNMODIFIED);
>  						continue;
>  					}
>  					if (!prefix) {
> -						puts(".git");
> +						print_path(".git", prefix, format, DEFAULT_UNMODIFIED);
>  						continue;
>  					}
>  				} else {		/* --absolute-git-dir */
> +					wanted =3D FORMAT_CANONICAL;
>  					if (!gitdir && !prefix)
>  						gitdir =3D ".git";
>  					if (gitdir) {
> @@ -868,14 +950,14 @@ int cmd_rev_parse(int argc, const char **argv, con=
st char *prefix)
>  				}
>  				cwd =3D xgetcwd();
>  				len =3D strlen(cwd);
> -				printf("%s%s.git\n", cwd, len && cwd[len-1] !=3D '/' ? "/" : "");
> +				strbuf_reset(&buf);
> +				strbuf_addf(&buf, "%s%s.git", cwd, len && cwd[len-1] !=3D '/' ? "/"=
 : "");

So `DEFAULT_CANONICAL` ensures a trailing `/`? I do not see that in
`print_path()`'s implementation, and also, I would love to see a different
name for that ("canonical", from my Java past, suggests something like
"real path" to me).

Thanks,
Dscho

>  				free(cwd);
> +				print_path(buf.buf, prefix, wanted, DEFAULT_CANONICAL);
>  				continue;
>  			}
>  			if (!strcmp(arg, "--git-common-dir")) {
> -				strbuf_reset(&buf);
> -				puts(relative_path(get_git_common_dir(),
> -						   prefix, &buf));
> +				print_path(get_git_common_dir(), prefix, format, DEFAULT_RELATIVE_I=
F_SHARED);
>  				continue;
>  			}
>  			if (!strcmp(arg, "--is-inside-git-dir")) {
> @@ -905,8 +987,7 @@ int cmd_rev_parse(int argc, const char **argv, const=
 char *prefix)
>  				if (the_index.split_index) {
>  					const struct object_id *oid =3D &the_index.split_index->base_oid;
>  					const char *path =3D git_path("sharedindex.%s", oid_to_hex(oid));
> -					strbuf_reset(&buf);
> -					puts(relative_path(path, prefix, &buf));
> +					print_path(path, prefix, format, DEFAULT_RELATIVE);
>  				}
>  				continue;
>  			}
> diff --git a/t/t1500-rev-parse.sh b/t/t1500-rev-parse.sh
> index 408b97d5af..51d7d40ec1 100755
> --- a/t/t1500-rev-parse.sh
> +++ b/t/t1500-rev-parse.sh
> @@ -3,6 +3,16 @@
>  test_description=3D'test git rev-parse'
>  . ./test-lib.sh
>
> +test_one () {
> +	dir=3D"$1" &&
> +	expect=3D"$2" &&
> +	shift &&
> +	shift &&
> +	echo "$expect" >expect &&
> +	git -C "$dir" rev-parse "$@" >actual &&
> +	test_cmp expect actual
> +}
> +
>  # usage: [options] label is-bare is-inside-git is-inside-work prefix gi=
t-dir absolute-git-dir
>  test_rev_parse () {
>  	d=3D
> @@ -60,7 +70,13 @@ ROOT=3D$(pwd)
>
>  test_expect_success 'setup' '
>  	mkdir -p sub/dir work &&
> -	cp -R .git repo.git
> +	cp -R .git repo.git &&
> +	git checkout -B main &&
> +	test_commit abc &&
> +	git checkout -b side &&
> +	test_commit def &&
> +	git checkout main &&
> +	git worktree add worktree side
>  '
>
>  test_rev_parse toplevel false false true '' .git "$ROOT/.git"
> @@ -88,6 +104,45 @@ test_rev_parse -C work -g ../repo.git -b t 'GIT_DIR=
=3D../repo.git, core.bare =3D tru
>
>  test_rev_parse -C work -g ../repo.git -b u 'GIT_DIR=3D../repo.git, core=
.bare undefined' false false true ''
>
> +test_expect_success 'rev-parse --path-format=3Dabsolute' '
> +	test_one "." "$ROOT/.git" --path-format=3Dabsolute --git-dir &&
> +	test_one "." "$ROOT/.git" --path-format=3Dabsolute --git-common-dir &&
> +	test_one "sub/dir" "$ROOT/.git" --path-format=3Dabsolute --git-dir &&
> +	test_one "sub/dir" "$ROOT/.git" --path-format=3Dabsolute --git-common-=
dir &&
> +	test_one "worktree" "$ROOT/.git/worktrees/worktree" --path-format=3Dab=
solute --git-dir &&
> +	test_one "worktree" "$ROOT/.git" --path-format=3Dabsolute --git-common=
-dir &&
> +	test_one "." "$ROOT" --path-format=3Dabsolute --show-toplevel &&
> +	test_one "." "$ROOT/.git/objects" --path-format=3Dabsolute --git-path =
objects &&
> +	test_one "." "$ROOT/.git/objects/foo/bar/baz" --path-format=3Dabsolute=
 --git-path objects/foo/bar/baz
> +'
> +
> +test_expect_success 'rev-parse --path-format=3Drelative' '
> +	test_one "." ".git" --path-format=3Drelative --git-dir &&
> +	test_one "." ".git" --path-format=3Drelative --git-common-dir &&
> +	test_one "sub/dir" "../../.git" --path-format=3Drelative --git-dir &&
> +	test_one "sub/dir" "../../.git" --path-format=3Drelative --git-common-=
dir &&
> +	test_one "worktree" "../.git/worktrees/worktree" --path-format=3Drelat=
ive --git-dir &&
> +	test_one "worktree" "../.git" --path-format=3Drelative --git-common-di=
r &&
> +	test_one "." "./" --path-format=3Drelative --show-toplevel &&
> +	test_one "." ".git/objects" --path-format=3Drelative --git-path object=
s &&
> +	test_one "." ".git/objects/foo/bar/baz" --path-format=3Drelative --git=
-path objects/foo/bar/baz
> +'
> +
> +test_expect_success '--path-format=3Drelative does not affect --absolut=
e-git-dir' '
> +	git rev-parse --path-format=3Drelative --absolute-git-dir >actual &&
> +	echo "$ROOT/.git" >expect &&
> +	test_cmp expect actual
> +'
> +
> +test_expect_success '--path-format can change in the middle of the comm=
and line' '
> +	git rev-parse --path-format=3Dabsolute --git-dir --path-format=3Drelat=
ive --git-path objects/foo/bar >actual &&
> +	cat >expect <<-EOF &&
> +	$ROOT/.git
> +	.git/objects/foo/bar
> +	EOF
> +	test_cmp expect actual
> +'
> +
>  test_expect_success 'git-common-dir from worktree root' '
>  	echo .git >expect &&
>  	git rev-parse --git-common-dir >actual &&
>
