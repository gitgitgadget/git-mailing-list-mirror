Return-Path: <SRS0=gV3S=CS=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.4 required=3.0 tests=BAYES_00,DATE_IN_PAST_03_06,
	DKIM_SIGNED,DKIM_VALID,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AE6E3C433E2
	for <git@archiver.kernel.org>; Wed,  9 Sep 2020 08:04:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5F4FA2087C
	for <git@archiver.kernel.org>; Wed,  9 Sep 2020 08:04:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=gmx.net header.i=@gmx.net header.b="VB7DwtYG"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730128AbgIIIDm (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 9 Sep 2020 04:03:42 -0400
Received: from mout.gmx.net ([212.227.17.21]:41343 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728911AbgIIIDF (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 9 Sep 2020 04:03:05 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1599638573;
        bh=2Vvq9bFQlhNuNMBn75hxi7IMQEKamlpfr5YD5wDeGaE=;
        h=X-UI-Sender-Class:Date:From:To:cc:Subject:In-Reply-To:References;
        b=VB7DwtYGdt1THAb6qiecgvXMbuLiw0pTpueA7qBDTFkLaPbpB8dPBfSl5mQf2epQT
         JsK37eXaWXqAiKEGQjLc1nLStEx6qf9MfolRyJLOWt5jsVVp8flx6pUps/s/adIueP
         SmM4HfTjYwD0c/1+VACDdNnI6lKVdAe6w88jspQQ=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [172.29.21.2] ([89.1.215.150]) by mail.gmx.com (mrgmx104
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1MYNJq-1k3OQA36A6-00VOxv; Wed, 09
 Sep 2020 10:02:52 +0200
Date:   Wed, 9 Sep 2020 05:23:32 +0200 (CEST)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@gitforwindows.org
To:     "brian m. carlson" <sandals@crustytoothpaste.net>
cc:     git@vger.kernel.org
Subject: Re: [PATCH] rev-parse: add option for absolute or relative path
 formatting
In-Reply-To: <20200908185017.2005159-1-sandals@crustytoothpaste.net>
Message-ID: <nycvar.QRO.7.76.6.2009090513300.54@tvgsbejvaqbjf.bet>
References: <20200908185017.2005159-1-sandals@crustytoothpaste.net>
User-Agent: Alpine 2.21.1 (DEB 209 2017-03-23)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K1:8P+R+NjYCk142ZwtLLkMhHg3A+GTKbKYoyVadsDZjLQkYICPREk
 8NxBaDeGnJ0XkNqljuFivP6SrOvKyko6RbWTKYGBCtWCdgf7BAxWjA/TujKpwWTt/r95aZl
 elYaJgud5VkWmht+/TXiyMI5fuIk3QH59ABAOSOYaUXjnzo0mIHLtnUNy5VuVyQBaSWPEOS
 wh7THvps/rJZ71tIpR3Wg==
X-UI-Out-Filterresults: notjunk:1;V03:K0:7BN3L+0vQS0=:AABwJzHMRxRryfFTVtruyP
 6rEYgtBm7Ppo7kpLa+JL0idI0krPOVEBte3v5kAwRJ+4RndAxQqmYYjkTyBndYVhhQa5uxSnH
 Pyg1N0zjJZfJvaCsaW2SVDJDCFDiQ3T1GNyOO3OI8L2bu5Te3fPzztpi6gKpMSW7oX6MBgAde
 IfGec4aI/zqT3/TKBUY9TuyG0bo97vdHFfMwUTaOeipLbne51K4Tr0YXT/7qb/j/tS1eYOZjT
 MSYNxPhWHeDudjSRgDpiEMNgKeYzSAlcEVv48c7CMAletw8LOSdbOwSuES82sp/R78OboY772
 CQuAroJmVqN6Il71iZVtXfNI5YhGr9VBazWIK74N1LdpBb1Y+k3L1NoFKXpVfjzfnx7iuw3QO
 CTUXlCQooj0Yl0ADs6B6MpSl88Dz8bJTZL+kqjun/f44QONkt038J88o3ZJuhPJke7BYEre/L
 ZY+CwGl0i9bo8F0poXJrPC3hsa1ymidckx4vbS6aztqNruHRshBaoaEEoPk6P+wLRN0gjAjOb
 t3pkreGK8X+HuXMId+vCKC7UNmZRCTSTXfVOJsHu11SdlT6sInomz/hBjqZfHs6Q+NiQAbE1C
 fDB04BDPrPOrbJQGQiw06dkQEnE/r+v50E6x9MhSxLEX//68/Nkv7sLCCkNG0F3K+b6TMHtIH
 Y3KVQ3BZSIyEb7deVRS8fPqiZ9bftBMiKXfLoRzCirfnjQZ/W6zmIAfkGeZkBtvqFqMMMw71T
 9daBtXT+z6tQGPlrLmAPsY/6sY0Koc+nmNW4urV+7DkzKdrlS3Jz6I5IQCDO8F10oIiKMdAz8
 Q7loRNgjpu2OIkT6HA8PKxpvrTs4SB2gwisNum/CExooIfxqpl2zg9Uv5aRWoBpWfHxv0y/Bi
 Qohzv0DCbPABe2GaN9vqPncri+vUlvfQUvg4ngiV/YC/VwJTUv/63SZzdo0sy9kCnW58TpTdE
 nqOZ94wV5k8gxS9cy5qdu6ZJSNtHTcHL/gT18/LKVJrgicBqqQFexXkjLKJFg6/GkmnR4y3vL
 kQljTqB9UEA6dqRyLz7nKh11hN1D1xU98GnOfxlfWIbAjnACInhONm7r69xgKV653OD289hG0
 ZoYjntYwJD6aH4L9B2y3JCGRfuX1kv2EDitlzByPj839zNUSM6FrhSCznMV1iQ+82ZVybeyx3
 Wm9uY9+eG55uJ++3irFXlZcvbDztZmw2WC8BaZnhN8H4JFSClZvpxrLWyBfhmEoqAi606EGjN
 Q5u6DhqBUM4QufflN4pb2EMN5nS1arW6ZpWJHeQ==
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi brian,

On Tue, 8 Sep 2020, brian m. carlson wrote:

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
> Signed-off-by: brian m. carlson <sandals@crustytoothpaste.net>
> ---

Nicely explained and implemented.

> This impetus for this patch is Git LFS, which is written in Go.  Go
> lacks a cross-platform way to canonicalize paths in the same way that
> Git does, so when Git produces relative paths, such as in some cases
> with --git-common-dir, we end up with problems when users are doing
> things with unusual paths on Windows, such as when using SUBST or
> OneDrive or various other edge cases.  Go upstream does not appear eager
> to address this problem.
>
> The obvious solution to this is to have Git canonicalize all paths, and
> rather than adding yet another one-off, I decided to implement a more
> generic solution.  This can also be valuable for shell scripting
> environments which lack realpath(1) (e.g. macOS, IIRC).
>
> Dscho CC'd for visibility into how this will work on Windows.

On Windows, at least in the version from git-for-windows/git,
`strbuf_realpath()` uses the Win32 API function
`GetFinalPathNameByHandleW()` to canonicalize paths (whenever possible),
meaning that the `subst` issue you mentioned above will be addressed
adequately.

Note: this platform-specific real path handling has not yet made it
upstream, it is still "battle-tested" in Git for Windows.

Thanks,
Dscho

>
>  Documentation/git-rev-parse.txt | 71 ++++++++++++++++------------
>  builtin/rev-parse.c             | 84 ++++++++++++++++++++++++++++-----
>  t/t1500-rev-parse.sh            | 36 +++++++++++++-
>  3 files changed, 148 insertions(+), 43 deletions(-)
>
> diff --git a/Documentation/git-rev-parse.txt b/Documentation/git-rev-par=
se.txt
> index 19b12b6d43..6b95292559 100644
> --- a/Documentation/git-rev-parse.txt
> +++ b/Documentation/git-rev-parse.txt
> @@ -208,6 +208,15 @@ Options for Files
>  	Only the names of the variables are listed, not their value,
>  	even if they are set.
>
> +--path-format=3D(absolute|relative)::
> +	Controls the behavior of certain other options following it on the com=
mand
> +	line. If specified as absolute, the paths printed by those options wil=
l be
> +	absolute and canonical. If specified as relative, the paths will be re=
lative
> +	to the current working directory if that is possible.  The default is =
option
> +	specific.
> +
> +The following options are modified by `--path-format`:
> +
>  --git-dir::
>  	Show `$GIT_DIR` if defined. Otherwise show the path to
>  	the .git directory. The path shown, when relative, is
> @@ -217,13 +226,42 @@ If `$GIT_DIR` is not defined and the current direc=
tory
>  is not detected to lie in a Git repository or work tree
>  print a message to stderr and exit with nonzero status.
>
> +--git-common-dir::
> +	Show `$GIT_COMMON_DIR` if defined, else `$GIT_DIR`.
> +
> +--resolve-git-dir <path>::
> +	Check if <path> is a valid repository or a gitfile that
> +	points at a valid repository, and print the location of the
> +	repository.  If <path> is a gitfile then the resolved path
> +	to the real repository is printed.
> +
> +--git-path <path>::
> +	Resolve "$GIT_DIR/<path>" and takes other path relocation
> +	variables such as $GIT_OBJECT_DIRECTORY,
> +	$GIT_INDEX_FILE... into account. For example, if
> +	$GIT_OBJECT_DIRECTORY is set to /foo/bar then "git rev-parse
> +	--git-path objects/abc" returns /foo/bar/abc.
> +
> +--show-toplevel::
> +	Show the (by default, absolute) path of the top-level directory
> +	of the working tree. If there is no working tree, report an error.
> +
> +--show-superproject-working-tree::
> +	Show the absolute path of the root of the superproject's
> +	working tree (if exists) that uses the current repository as
> +	its submodule.  Outputs nothing if the current repository is
> +	not used as a submodule by any project.
> +
> +--shared-index-path::
> +	Show the path to the shared index file in split index mode, or
> +	empty if not in split-index mode.
> +
> +The following options are unaffected by `--path-format`:
> +
>  --absolute-git-dir::
>  	Like `--git-dir`, but its output is always the canonicalized
>  	absolute path.
>
> ---git-common-dir::
> -	Show `$GIT_COMMON_DIR` if defined, else `$GIT_DIR`.
> -
>  --is-inside-git-dir::
>  	When the current working directory is below the repository
>  	directory print "true", otherwise "false".
> @@ -238,19 +276,6 @@ print a message to stderr and exit with nonzero sta=
tus.
>  --is-shallow-repository::
>  	When the repository is shallow print "true", otherwise "false".
>
> ---resolve-git-dir <path>::
> -	Check if <path> is a valid repository or a gitfile that
> -	points at a valid repository, and print the location of the
> -	repository.  If <path> is a gitfile then the resolved path
> -	to the real repository is printed.
> -
> ---git-path <path>::
> -	Resolve "$GIT_DIR/<path>" and takes other path relocation
> -	variables such as $GIT_OBJECT_DIRECTORY,
> -	$GIT_INDEX_FILE... into account. For example, if
> -	$GIT_OBJECT_DIRECTORY is set to /foo/bar then "git rev-parse
> -	--git-path objects/abc" returns /foo/bar/abc.
> -
>  --show-cdup::
>  	When the command is invoked from a subdirectory, show the
>  	path of the top-level directory relative to the current
> @@ -261,20 +286,6 @@ print a message to stderr and exit with nonzero sta=
tus.
>  	path of the current directory relative to the top-level
>  	directory.
>
> ---show-toplevel::
> -	Show the absolute path of the top-level directory of the working
> -	tree. If there is no working tree, report an error.
> -
> ---show-superproject-working-tree::
> -	Show the absolute path of the root of the superproject's
> -	working tree (if exists) that uses the current repository as
> -	its submodule.  Outputs nothing if the current repository is
> -	not used as a submodule by any project.
> -
> ---shared-index-path::
> -	Show the path to the shared index file in split index mode, or
> -	empty if not in split-index mode.
> -
>  --show-object-format[=3D(storage|input|output)]::
>  	Show the object format (hash algorithm) used for the repository
>  	for storage inside the `.git` directory, input, or output. For
> diff --git a/builtin/rev-parse.c b/builtin/rev-parse.c
> index 669dd2fd6f..311a56ba01 100644
> --- a/builtin/rev-parse.c
> +++ b/builtin/rev-parse.c
> @@ -583,6 +583,55 @@ static void handle_ref_opt(const char *pattern, con=
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
> +
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
> +		  (format =3D=3D FORMAT_DEFAULT && def =3D=3D DEFAULT_RELATIVE) ||
> +		  (format =3D=3D FORMAT_DEFAULT && def =3D=3D DEFAULT_RELATIVE_IF_SHA=
RED)) {
> +		struct strbuf buf =3D STRBUF_INIT;
> +		puts(relative_path(path, prefix, &buf));
> +		strbuf_reset(&buf);
> +	} else {
> +		char *real =3D real_pathdup(path, 1);
> +		puts(real);
> +		free(real);
> +	}
> +	free(cwd);
> +}
> +
>  int cmd_rev_parse(int argc, const char **argv, const char *prefix)
>  {
>  	int i, as_is =3D 0, verify =3D 0, quiet =3D 0, revs_count =3D 0, type =
=3D 0;
> @@ -595,6 +644,7 @@ int cmd_rev_parse(int argc, const char **argv, const=
 char *prefix)
>  	struct object_context unused;
>  	struct strbuf buf =3D STRBUF_INIT;
>  	const int hexsz =3D the_hash_algo->hexsz;
> +	enum format_type format =3D FORMAT_DEFAULT;
>
>  	if (argc > 1 && !strcmp("--parseopt", argv[1]))
>  		return cmd_parseopt(argc - 1, argv + 1, prefix);
> @@ -650,8 +700,7 @@ int cmd_rev_parse(int argc, const char **argv, const=
 char *prefix)
>  			if (!argv[i + 1])
>  				die("--git-path requires an argument");
>  			strbuf_reset(&buf);
> -			puts(relative_path(git_path("%s", argv[i + 1]),
> -					   prefix, &buf));
> +			print_path(git_path("%s", argv[i + 1]), prefix, format, DEFAULT_RELA=
TIVE_IF_SHARED);
>  			i++;
>  			continue;
>  		}
> @@ -683,6 +732,16 @@ int cmd_rev_parse(int argc, const char **argv, cons=
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
> @@ -803,7 +862,7 @@ int cmd_rev_parse(int argc, const char **argv, const=
 char *prefix)
>  			if (!strcmp(arg, "--show-toplevel")) {
>  				const char *work_tree =3D get_git_work_tree();
>  				if (work_tree)
> -					puts(work_tree);
> +					print_path(work_tree, prefix, format, DEFAULT_CANONICAL);
>  				else
>  					die("this operation must be run in a work tree");
>  				continue;
> @@ -811,7 +870,7 @@ int cmd_rev_parse(int argc, const char **argv, const=
 char *prefix)
>  			if (!strcmp(arg, "--show-superproject-working-tree")) {
>  				struct strbuf superproject =3D STRBUF_INIT;
>  				if (get_superproject_working_tree(&superproject))
> -					puts(superproject.buf);
> +					print_path(superproject.buf, prefix, format, DEFAULT_CANONICAL);
>  				strbuf_release(&superproject);
>  				continue;
>  			}
> @@ -846,16 +905,18 @@ int cmd_rev_parse(int argc, const char **argv, con=
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
> @@ -868,14 +929,14 @@ int cmd_rev_parse(int argc, const char **argv, con=
st char *prefix)
>  				}
>  				cwd =3D xgetcwd();
>  				len =3D strlen(cwd);
> -				printf("%s%s.git\n", cwd, len && cwd[len-1] !=3D '/' ? "/" : "");
> +				strbuf_reset(&buf);
> +				strbuf_addf(&buf, "%s%s.git", cwd, len && cwd[len-1] !=3D '/' ? "/"=
 : "");
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
> @@ -905,8 +966,7 @@ int cmd_rev_parse(int argc, const char **argv, const=
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
> index 408b97d5af..6f3811d189 100755
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
> +	git -C "$dir" rev-parse "$@" >actual
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
> +	git checkout -b main &&
> +	test_commit abc &&
> +	git checkout -b side &&
> +	test_commit def &&
> +	git checkout main &&
> +	git worktree add worktree side
>  '
>
>  test_rev_parse toplevel false false true '' .git "$ROOT/.git"
> @@ -88,6 +104,24 @@ test_rev_parse -C work -g ../repo.git -b t 'GIT_DIR=
=3D../repo.git, core.bare =3D tru
>
>  test_rev_parse -C work -g ../repo.git -b u 'GIT_DIR=3D../repo.git, core=
.bare undefined' false false true ''
>
> +test_expect_success 'rev-parse --path-format=3Dabsolute' '
> +	test_one "." "$ROOT/.git" --path-format=3Dabsolute --git-dir &&
> +	test_one "." "$ROOT/.git" --path-format=3Dabsolute --git-common-dir &&
> +	test_one "worktree" "$ROOT/.git/worktrees/worktree" --path-format=3Dab=
solute --git-dir &&
> +	test_one "worktree" "$ROOT/.git" --path-format=3Dabsolute --git-common=
-dir &&
> +	test_one "." "$ROOT" --path-format=3Dabsolute --show-toplevel &&
> +	test_one "." "$ROOT/.git/objects" --path-format=3Dabsolute --git-path =
objects
> +'
> +
> +test_expect_success 'rev-parse --path-format=3Drelative' '
> +	test_one "." ".git" --path-format=3Drelative --git-dir &&
> +	test_one "." ".git" --path-format=3Drelative --git-common-dir &&
> +	test_one "worktree" "../.git/worktrees/worktree" --path-format=3Drelat=
ive --git-dir &&
> +	test_one "worktree" "../.git" --path-format=3Drelative --git-common-di=
r &&
> +	test_one "." "./" --path-format=3Drelative --show-toplevel &&
> +	test_one "." ".git/objects" --path-format=3Drelative --git-path object=
s
> +'
> +
>  test_expect_success 'git-common-dir from worktree root' '
>  	echo .git >expect &&
>  	git rev-parse --git-common-dir >actual &&
>
