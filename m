Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-1.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MALFORMED_FREEMAIL,
	RCVD_IN_DNSWL_HI,RCVD_IN_SBL_CSS shortcircuit=no autolearn=no
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id F2F011F461
	for <e@80x24.org>; Tue, 14 May 2019 15:13:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726151AbfENPNV (ORCPT <rfc822;e@80x24.org>);
        Tue, 14 May 2019 11:13:21 -0400
Received: from mout.gmx.net ([212.227.15.15]:50669 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725901AbfENPNU (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 14 May 2019 11:13:20 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1557846776;
        bh=kE0jbP1RlzuM8EE7TNMaFTCBEHiL0OzhP4xOOEaTAks=;
        h=X-UI-Sender-Class:Date:From:To:cc:Subject:In-Reply-To:References;
        b=lSV3bCa9tSmnybcHhdcPNVxNul5XDmtkFUqr/rkiEQ3kGHA7tbLdG69elPqJfe+Qj
         Mw2lsIkMLZAozlhIiqFR6xEpeIcYmZVDqch4NJ8tdpHaEHf5l473p2IZfeLoFb5M1s
         4bSvjER7UZ5s9nOr+mZrznAGr9+vsBw26t7UInt0=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [192.168.0.129] ([37.201.192.51]) by mail.gmx.com (mrgmx003
 [212.227.17.190]) with ESMTPSA (Nemesis) id 0MbxJ8-1h9Rvy2A4s-00JG53; Tue, 14
 May 2019 17:12:56 +0200
Date:   Tue, 14 May 2019 17:12:39 +0200 (CEST)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@gitforwindows.org
To:     "brian m. carlson" <sandals@crustytoothpaste.net>
cc:     git@vger.kernel.org, Jeff King <peff@peff.net>,
        Duy Nguyen <pclouds@gmail.com>,
        Junio C Hamano <gitster@pobox.com>,
        Johannes Sixt <j6t@kdbg.org>,
        =?UTF-8?Q?=C3=86var_Arnfj=C3=B6r=C3=B0_Bjarmason?= 
        <avarab@gmail.com>, Phillip Wood <phillip.wood123@gmail.com>,
        Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: [PATCH v2 1/7] run-command: add preliminary support for multiple
 hooks
In-Reply-To: <20190514002332.121089-2-sandals@crustytoothpaste.net>
Message-ID: <nycvar.QRO.7.76.6.1905141653130.44@tvgsbejvaqbjf.bet>
References: <20190514002332.121089-1-sandals@crustytoothpaste.net> <20190514002332.121089-2-sandals@crustytoothpaste.net>
User-Agent: Alpine 2.21.1 (DEB 209 2017-03-23)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K1:4fQrlgEWop6ATpym0lydD2LpFJ/6YR4F7EP3EnH6NEMgzmlwlYI
 0qpeq15ZMbsHDJVr8REEc8GaIb4qehEy2XPIuNUEX790DF32Ea/OsXMinvN3ajPgY1s2QrP
 x4lfuekCM2BUUG6HxQe1fiQhgerLu9NU27VK8gVhAvR59S6MDqwHM2IXUHp1OnMrBrzME4O
 1ashNZ7APBmTZkZeRIT8A==
X-UI-Out-Filterresults: notjunk:1;V03:K0:EVeT0+JVSg4=:uoMJEqcZg95+Ca+/pEpE54
 3Y7KDTNm6S+Z0wHd1pZ1dKUogavMp+C6tZ5IxEJu3smbUopOtBkkjfjmOKO0rqSa84xcx9Cno
 IuC8IvlOLGzMX6R5s6eL68G7iePfBImMN4MtsvKZBaoaHDVbWcPdngHMZgQOzXHeqh+Sj6Pmx
 FduqJamgxubvLIqZrm1DCyx83Ji5nof40R3EX1Mj32M1rIF+zJdaVyXw5raggS9psA/FVOOy9
 wBr7V0f1AyCPijGLRIFPYhGg4qJQPDQth8bgAUxsZwoiDjyVU2XhGBQP1i13JE/XiPNvn1lOa
 GsyUHUxraSLSJAyEEczvi4Cr4ZVs6iohFjp3IyiDU9dfAy/Bu/JTv5GZUoJ2szyQ8hjX+5owN
 iOVXdw6KKGBZ/Kf2RYEDrUnjw4CfV9xPnN7txiNVs599K17howBRfYQH6Hp90MiNWiPFUiYjF
 IZUvtIMMxjUoNdeqb1AQOZAjWOX2oBYj5rGh8QFMrkJP+EvkEyUA0SHU6PbDwmA+4490NDAVa
 A2g/XbubB/Ew50QdW0d+xGwTY1Z329vqjHG+X9ngx9dzbvWZaU9lSzd4KNfjiGOSYgb5peC1q
 uiiirNZvxPe0VZZ+zTDaEDegxGyJuVLBBweMnG8t9adbbmXf0ghEjh15cgNeXGSq6LfwOnUlg
 5ci4N68tcvYOALLJJZIT3yX/enpqVW4LYFQKcIDM4kR5JxtRaDm7NzI8E8tsu56BPgzBIraFY
 7LbmgpOL6JpZminQEU2oEhnE+B2KlZwmWrwUQtyBTVdB1hQ6v8QVKywvIMdYHpc9jmXbETUKs
 JuG6U+YSHgw4qAtCCs7PBKAmSPMA8kNaGZ1+2xR/qiEPy1kpy0vt1SWTKbuHeGTWKaIXK2XCu
 jpg6vw960OaqVZnMxK92AtLpObGS4AC7fmYievyBkX8PIeKgDEXteCadKmLrmcOECg4RTAjOT
 GQYXditvfXQ==
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi brian,

On Tue, 14 May 2019, brian m. carlson wrote:

> diff --git a/builtin/commit.c b/builtin/commit.c
> index 833ecb316a..29bf80e0d1 100644
> --- a/builtin/commit.c
> +++ b/builtin/commit.c
> @@ -943,7 +943,7 @@ static int prepare_to_commit(const char *index_file,=
 const char *prefix,
>  		return 0;
>  	}
>
> -	if (!no_verify && find_hook("pre-commit")) {
> +	if (!no_verify && find_hooks("pre-commit", NULL)) {

Hmm. This makes me concerned, as `find_hook()` essentially boiled down to
a semi-fast `stat()` check, but `find_hooks()` needs to really look,
right?

It might make sense to somehow keep the list of discovered and executed
hooks, as we already have a call to `run_commit_hook()` to execute the
`pre-commit` hook at the beginning of this function.

Speaking of which... Shouldn't that `run_commit_hook()` call be adjusted
at the same time, or else we have an inconsistent situation?

>  		/*
>  		 * Re-read the index as pre-commit hook could have updated it,
>  		 * and write it out as a tree.  We must do this before we invoke
> diff --git a/run-command.c b/run-command.c
> index 3449db319b..eb075ac86b 100644
> --- a/run-command.c
> +++ b/run-command.c
> @@ -1308,53 +1308,143 @@ int async_with_fork(void)
>  #endif
>  }
>
> +/*
> + * Return 1 if a hook exists at path (which may be modified) using acce=
ss(2)
> + * with check (which should be F_OK or X_OK), 0 otherwise. If strip is =
true,
> + * additionally consider the same filename but with STRIP_EXTENSION add=
ed.
> + * If check is X_OK, warn if the hook exists but is not executable.
> + */
> +static int has_hook(struct strbuf *path, int strip, int check)
> +{
> +	if (access(path->buf, check) < 0) {
> +		int err =3D errno;
> +
> +		if (strip) {
> +#ifdef STRIP_EXTENSION
> +			strbuf_addstr(path, STRIP_EXTENSION);
> +			if (access(path->buf, check) >=3D 0)
> +				return 1;
> +			if (errno =3D=3D EACCES)
> +				err =3D errno;
> +#endif
> +		}

How about simply guarding the entire `if()`? It is a bit unusual to guard
*only* the inside block ;-)

> +
> +		if (err =3D=3D EACCES && advice_ignored_hook) {

Didn't you want to test for `X_OK` here, too? The code comment above the
function seems to suggest that.

> +			static struct string_list advise_given =3D STRING_LIST_INIT_DUP;
> +
> +			if (!string_list_lookup(&advise_given, path->buf)) {
> +				string_list_insert(&advise_given, path->buf);
> +				advise(_("The '%s' hook was ignored because "
> +					 "it's not set as executable.\n"
> +					 "You can disable this warning with "
> +					 "`git config advice.ignoredHook false`."),
> +				       path->buf);
> +			}
> +		}
> +		return 0;
> +	}
> +	return 1;

Wouldn't it make sense to do this very early? Something like

	if (!access(path->buf, check))
		return 1;

first thing in the function, that that part is already out of the way and
we don't have to indent so much.

> +}
> +
>  const char *find_hook(const char *name)
>  {
>  	static struct strbuf path =3D STRBUF_INIT;
>
>  	strbuf_reset(&path);
>  	strbuf_git_path(&path, "hooks/%s", name);
> -	if (access(path.buf, X_OK) < 0) {
> -		int err =3D errno;
> -
> -#ifdef STRIP_EXTENSION
> -		strbuf_addstr(&path, STRIP_EXTENSION);
> -		if (access(path.buf, X_OK) >=3D 0)
> -			return path.buf;
> -		if (errno =3D=3D EACCES)
> -			err =3D errno;
> -#endif
> -
> -		if (err =3D=3D EACCES && advice_ignored_hook) {
> -			static struct string_list advise_given =3D STRING_LIST_INIT_DUP;
> -
> -			if (!string_list_lookup(&advise_given, name)) {
> -				string_list_insert(&advise_given, name);
> -				advise(_("The '%s' hook was ignored because "
> -					 "it's not set as executable.\n"
> -					 "You can disable this warning with "
> -					 "`git config advice.ignoredHook false`."),
> -				       path.buf);
> -			}
> -		}
> -		return NULL;

So that's where this comes from ;-)

> +	if (has_hook(&path, 1, X_OK)) {
> +		return path.buf;
>  	}
> -	return path.buf;
> +	return NULL;
>  }
>
> -int run_hook_ve(const char *const *env, const char *name, va_list args)
> +int find_hooks(const char *name, struct string_list *list)
>  {
> -	struct child_process hook =3D CHILD_PROCESS_INIT;
> -	const char *p;
> +	struct strbuf path =3D STRBUF_INIT;
> +	DIR *d;
> +	struct dirent *de;
>
> -	p =3D find_hook(name);
> -	if (!p)
> +	/*
> +	 * We look for a single hook. If present, return it, and skip the
> +	 * individual directories.
> +	 */
> +	strbuf_git_path(&path, "hooks/%s", name);
> +	if (has_hook(&path, 1, X_OK)) {
> +		if (list)
> +			string_list_append(list, path.buf);
> +		return 1;
> +	}
> +
> +	if (has_hook(&path, 1, F_OK))
>  		return 0;
>
> -	argv_array_push(&hook.args, p);
> -	while ((p =3D va_arg(args, const char *)))
> -		argv_array_push(&hook.args, p);
> -	hook.env =3D env;
> +	strbuf_reset(&path);
> +	strbuf_git_path(&path, "hooks/%s.d", name);
> +	d =3D opendir(path.buf);
> +	if (!d) {
> +		if (list)
> +			string_list_clear(list, 0);
> +		return 0;
> +	}
> +	while ((de =3D readdir(d))) {
> +		if (!strcmp(de->d_name, ".") || !strcmp(de->d_name, ".."))
> +			continue;
> +		strbuf_reset(&path);
> +		strbuf_git_path(&path, "hooks/%s.d/%s", name, de->d_name);
> +		if (has_hook(&path, 0, X_OK)) {
> +			if (list)
> +				string_list_append(list, path.buf);
> +			else
> +				return 1;
> +		}
> +	}
> +	closedir(d);
> +	strbuf_reset(&path);
> +	if (!list->nr) {
> +		return 0;
> +	}
> +
> +	string_list_sort(list);
> +	return 1;
> +}
> +
> +int for_each_hook(const char *name,
> +		  int (*handler)(const char *name, const char *path, void *),
> +		  void *data)
> +{
> +	struct string_list paths =3D STRING_LIST_INIT_DUP;
> +	int i, ret =3D 0;
> +
> +	find_hooks(name, &paths);
> +	for (i =3D 0; i < paths.nr; i++) {
> +		const char *p =3D paths.items[i].string;
> +
> +		ret =3D handler(name, p, data);
> +		if (ret)
> +			break;
> +	}
> +
> +	string_list_clear(&paths, 0);
> +	return ret;
> +}
> +
> +struct hook_data {
> +	const char *const *env;
> +	struct string_list *args;
> +};
> +
> +static int do_run_hook_ve(const char *name, const char *path, void *cb)
> +{
> +	struct hook_data *data =3D cb;
> +	struct child_process hook =3D CHILD_PROCESS_INIT;
> +	struct string_list_item *arg;
> +
> +	argv_array_push(&hook.args, path);
> +	for_each_string_list_item(arg, data->args) {
> +		argv_array_push(&hook.args, arg->string);
> +	}
> +
> +	hook.env =3D data->env;
>  	hook.no_stdin =3D 1;
>  	hook.stdout_to_stderr =3D 1;
>  	hook.trace2_hook_name =3D name;
> @@ -1362,6 +1452,21 @@ int run_hook_ve(const char *const *env, const cha=
r *name, va_list args)
>  	return run_command(&hook);
>  }
>
> +int run_hook_ve(const char *const *env, const char *name, va_list args)
> +{
> +	struct string_list arglist =3D STRING_LIST_INIT_DUP;
> +	struct hook_data data =3D {env, &arglist};
> +	const char *p;
> +	int ret =3D 0;
> +
> +	while ((p =3D va_arg(args, const char *)))
> +		string_list_append(&arglist, p);
> +
> +	ret =3D for_each_hook(name, do_run_hook_ve, &data);
> +	string_list_clear(&arglist, 0);
> +	return ret;
> +}
> +
>  int run_hook_le(const char *const *env, const char *name, ...)
>  {
>  	va_list args;
> diff --git a/run-command.h b/run-command.h
> index a6950691c0..1b3677fcac 100644
> --- a/run-command.h
> +++ b/run-command.h
> @@ -4,6 +4,7 @@
>  #include "thread-utils.h"
>
>  #include "argv-array.h"
> +#include "string-list.h"
>
>  struct child_process {
>  	const char **argv;
> @@ -68,6 +69,20 @@ int run_command(struct child_process *);
>   * overwritten by further calls to find_hook and run_hook_*.
>   */
>  extern const char *find_hook(const char *name);
> +/*
> + * Returns the paths to all hook files, or NULL if all hooks are missin=
g or
> + * disabled.

Left-over comment?

> + * Returns 1 if there are hooks; 0 otherwise. If hooks is not NULL, sto=
res the
> + * names of the hooks into them in the order they should be executed.
> + */
> +int find_hooks(const char *name, struct string_list *hooks);
> +/*
> + * Invokes the handler function once for each hook. Returns 0 if all ho=
oks were
> + * successful, or the exit status of the first failing hook.
> + */
> +int for_each_hook(const char *name,
> +		  int (*handler)(const char *name, const char *path, void *),
> +		  void *data);

My gut says that it would make sense for `struct repository *` to sprout a
hashmap for hook lookup that would be populated by demand, and allowed
things like

	hash_hook(r, "pre-commit")

I can't follow up with code, though, as I'm off for the day!

Ciao,
Dscho

>  LAST_ARG_MUST_BE_NULL
>  extern int run_hook_le(const char *const *env, const char *name, ...);
>  extern int run_hook_ve(const char *const *env, const char *name, va_lis=
t args);
> diff --git a/t/lib-hooks.sh b/t/lib-hooks.sh
> new file mode 100644
> index 0000000000..721250aea0
> --- /dev/null
> +++ b/t/lib-hooks.sh
> @@ -0,0 +1,172 @@
> +create_multihooks () {
> +	mkdir -p "$MULTIHOOK_DIR"
> +	for i in "a $1" "b $2" "c $3"
> +	do
> +		echo "$i" | (while read script ex
> +		do
> +			mkdir -p "$MULTIHOOK_DIR"
> +			write_script "$MULTIHOOK_DIR/$script" <<-EOF
> +			mkdir -p "$OUTPUTDIR"
> +			touch "$OUTPUTDIR/$script"
> +			exit $ex
> +			EOF
> +		done)
> +	done
> +}
> +
> +# Run the multiple hook tests.
> +# Usage: test_multiple_hooks [--ignore-exit-status] HOOK COMMAND [SKIP-=
COMMAND]
> +# HOOK:  the name of the hook to test
> +# COMMAND: command to test the hook for; takes a single argument indica=
ting test
> +# name.
> +# SKIP-COMMAND: like $1, except the hook should be skipped.
> +# --ignore-exit-status: the command does not fail if the exit status fr=
om the
> +# hook is nonzero.
> +test_multiple_hooks () {
> +	local must_fail cmd skip_cmd hook
> +	if test "$1" =3D "--ignore-exit-status"
> +	then
> +		shift
> +	else
> +		must_fail=3D"test_must_fail"
> +	fi
> +	hook=3D"$1"
> +	cmd=3D"$2"
> +	skip_cmd=3D"$3"
> +
> +	HOOKDIR=3D"$(git rev-parse --absolute-git-dir)/hooks"
> +	OUTPUTDIR=3D"$(git rev-parse --absolute-git-dir)/../hook-output"
> +	HOOK=3D"$HOOKDIR/$hook"
> +	MULTIHOOK_DIR=3D"$HOOKDIR/$hook.d"
> +	rm -f "$HOOK" "$MULTIHOOK_DIR" "$OUTPUTDIR"
> +
> +	test_expect_success "$hook: with no hook" '
> +		$cmd foo
> +	'
> +
> +	if test -n "$skip_cmd"
> +	then
> +		test_expect_success "$hook: skipped hook with no hook" '
> +			$skip_cmd bar
> +		'
> +	fi
> +
> +	test_expect_success 'setup' '
> +		mkdir -p "$HOOKDIR" &&
> +		write_script "$HOOK" <<-EOF
> +		mkdir -p "$OUTPUTDIR"
> +		touch "$OUTPUTDIR/simple"
> +		exit 0
> +		EOF
> +	'
> +
> +	test_expect_success "$hook: with succeeding hook" '
> +		test_when_finished "rm -fr \"$OUTPUTDIR\"" &&
> +		$cmd more &&
> +		test -f "$OUTPUTDIR/simple"
> +	'
> +
> +	if test -n "$skip_cmd"
> +	then
> +		test_expect_success "$hook: skipped but succeeding hook" '
> +			test_when_finished "rm -fr \"$OUTPUTDIR\"" &&
> +			$skip_cmd even-more &&
> +			! test -f "$OUTPUTDIR/simple"
> +		'
> +	fi
> +
> +	test_expect_success "$hook: with both simple and multiple hooks, simpl=
e success" '
> +		test_when_finished "rm -fr \"$OUTPUTDIR\"" &&
> +		create_multihooks 0 1 0 &&
> +		$cmd yet-more &&
> +		test -f "$OUTPUTDIR/simple" &&
> +		! test -f "$OUTPUTDIR/a" &&
> +		! test -f "$OUTPUTDIR/b" &&
> +		! test -f "$OUTPUTDIR/c"
> +	'
> +
> +	test_expect_success 'setup' '
> +		rm -fr "$MULTIHOOK_DIR" &&
> +
> +		# now a hook that fails
> +		write_script "$HOOK" <<-EOF
> +		mkdir -p "$OUTPUTDIR"
> +		touch "$OUTPUTDIR/simple"
> +		exit 1
> +		EOF
> +	'
> +
> +	test_expect_success "$hook: with failing hook" '
> +		test_when_finished "rm -fr \"$OUTPUTDIR\"" &&
> +		$must_fail $cmd another &&
> +		test -f "$OUTPUTDIR/simple"
> +	'
> +
> +	if test -n "$skip_cmd"
> +	then
> +		test_expect_success "$hook: skipped but failing hook" '
> +			test_when_finished "rm -fr \"$OUTPUTDIR\"" &&
> +			$skip_cmd stuff &&
> +			! test -f "$OUTPUTDIR/simple"
> +		'
> +	fi
> +
> +	test_expect_success "$hook: with both simple and multiple hooks, simpl=
e failure" '
> +		test_when_finished "rm -fr \"$OUTPUTDIR\"" &&
> +		create_multihooks 0 1 0 &&
> +		$must_fail $cmd more-stuff &&
> +		test -f "$OUTPUTDIR/simple" &&
> +		! test -f "$OUTPUTDIR/a" &&
> +		! test -f "$OUTPUTDIR/b" &&
> +		! test -f "$OUTPUTDIR/c"
> +	'
> +
> +	test_expect_success "$hook: multiple hooks, all successful" '
> +		test_when_finished "rm -fr \"$OUTPUTDIR\"" &&
> +		rm -f "$HOOK" &&
> +		create_multihooks 0 0 0 &&
> +		$cmd content &&
> +		test -f "$OUTPUTDIR/a" &&
> +		test -f "$OUTPUTDIR/b" &&
> +		test -f "$OUTPUTDIR/c"
> +	'
> +
> +	test_expect_success "$hook: hooks after first failure not executed" '
> +		test_when_finished "rm -fr \"$OUTPUTDIR\"" &&
> +		create_multihooks 0 1 0 &&
> +		$must_fail $cmd more-content &&
> +		test -f "$OUTPUTDIR/a" &&
> +		test -f "$OUTPUTDIR/b" &&
> +		! test -f "$OUTPUTDIR/c"
> +	'
> +
> +	test_expect_success POSIXPERM "$hook: non-executable hook not executed=
" '
> +		test_when_finished "rm -fr \"$OUTPUTDIR\"" &&
> +		create_multihooks 0 1 0 &&
> +		chmod -x "$MULTIHOOK_DIR/b" &&
> +		$cmd things &&
> +		test -f "$OUTPUTDIR/a" &&
> +		! test -f "$OUTPUTDIR/b" &&
> +		test -f "$OUTPUTDIR/c"
> +	'
> +
> +	test_expect_success POSIXPERM "$hook: multiple hooks not executed if s=
imple hook present" '
> +		test_when_finished "rm -fr \"$OUTPUTDIR\" && rm -f \"$HOOK\"" &&
> +		write_script "$HOOK" <<-EOF &&
> +		mkdir -p "$OUTPUTDIR"
> +		touch "$OUTPUTDIR/simple"
> +		exit 0
> +		EOF
> +		create_multihooks 0 1 0 &&
> +		chmod -x "$HOOK" &&
> +		$cmd other-things &&
> +		! test -f "$OUTPUTDIR/simple" &&
> +		! test -f "$OUTPUTDIR/a" &&
> +		! test -f "$OUTPUTDIR/b" &&
> +		! test -f "$OUTPUTDIR/c"
> +	'
> +
> +	test_expect_success 'cleanup' '
> +		rm -fr "$MULTIHOOK_DIR"
> +	'
> +}
> diff --git a/t/t7503-pre-commit-hook.sh b/t/t7503-pre-commit-hook.sh
> index 984889b39d..d63d059e04 100755
> --- a/t/t7503-pre-commit-hook.sh
> +++ b/t/t7503-pre-commit-hook.sh
> @@ -3,6 +3,7 @@
>  test_description=3D'pre-commit hook'
>
>  . ./test-lib.sh
> +. "$TEST_DIRECTORY/lib-hooks.sh"
>
>  test_expect_success 'with no hook' '
>
> @@ -136,4 +137,18 @@ test_expect_success 'check the author in hook' '
>  	git show -s
>  '
>
> +commit_command () {
> +	echo "$1" >>file &&
> +	git add file &&
> +	git commit -m "$1"
> +}
> +
> +commit_no_verify_command () {
> +	echo "$1" >>file &&
> +	git add file &&
> +	git commit --no-verify -m "$1"
> +}
> +
> +test_multiple_hooks pre-commit commit_command commit_no_verify_command
> +
>  test_done
>
