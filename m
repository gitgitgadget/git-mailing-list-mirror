Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.8 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD shortcircuit=no autolearn=no
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id EC0B11F404
	for <e@80x24.org>; Mon,  1 Jan 2018 18:33:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752146AbeAASaC (ORCPT <rfc822;e@80x24.org>);
        Mon, 1 Jan 2018 13:30:02 -0500
Received: from mout.web.de ([212.227.17.11]:60529 "EHLO mout.web.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751770AbeAASaB (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 1 Jan 2018 13:30:01 -0500
Received: from [192.168.178.36] ([91.20.48.24]) by smtp.web.de (mrweb103
 [213.165.67.124]) with ESMTPSA (Nemesis) id 0LuLt5-1exKWj1psF-011kHX; Mon, 01
 Jan 2018 19:29:54 +0100
Subject: Re: [PATCH] git-archive: accept --owner and --group like GNU tar
To:     suzuki toshiya <mpsuzuki@hiroshima-u.ac.jp>, git@vger.kernel.org
References: <20171229140535.10746-1-mpsuzuki@hiroshima-u.ac.jp>
From:   =?UTF-8?Q?Ren=c3=a9_Scharfe?= <l.s.r@web.de>
Message-ID: <81b882a5-0c35-f3c4-78e2-d3e36290fec1@web.de>
Date:   Mon, 1 Jan 2018 19:29:52 +0100
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.5.2
MIME-Version: 1.0
In-Reply-To: <20171229140535.10746-1-mpsuzuki@hiroshima-u.ac.jp>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-Provags-ID: V03:K0:HAQIPfnaAENGxe0ZziX6936adUAZ4RZqomjXKuJbcOtBXhG432r
 KuWl124EGYVbL6KyKEScoqI6uXqWijxRImybRuoF7rfNF/AzzAIarrxTTXJXS+9RAbYMQ38
 XMC1pDIF/SPohrmWjnvdPhD9fNHr3gzr5YVj2DYr/9Iqi7UlHWuFSH9yy5fIfSB9txg/GWU
 v3KPkAUQ75hxb/3MgM7LA==
X-UI-Out-Filterresults: notjunk:1;V01:K0:LzFndb9d+PM=:hnX+PWSH22AVXkTYAI6x2g
 33j+BeEIpdTQexKieQLlHkyOBMk75toQpimoYbg7XxyVpnzNMTSXAz9fI92QE4i8aZ78oBteO
 A+O8INNPPTw9oIsRNDjLp64k/5PBYV9E9AaCss1DuxE+I/3LSkDrWlDgAr9DMR2PUxr48wCiI
 pTGCkEZ0tXs42ZEPmcDb/5vsdP3OfAQCGzNIF/aHI5zpPI/c5Q5m6Ay5YMVtRZbc6tpjW70Bs
 lETNQdZUjZH+jCySwTBQH8LBJvvZJ0ww6wnd7L6M0Se4KAs7eEpYBl+VOUj9pj2eN9IKkafR4
 o0DKeNYChnyKCEmCNPON6jFobYx7NknuHZF/GpwVYdy1CJTBjAAbcQ04Ka8Tq61sVFpb1eNxw
 TTXuNfRBsUnA9YXq2Q++WdME2SRzj3joCHuZ2ZwYEjOwHaOoky3/8nJh8JAnSD83yARdSzekR
 fVhN+m4eZd5FvEIS3EKW5dxkLdUUx2mA4aBltvVYebmhVdXyfYDss3/icsVTRgUHQDh8e1MPs
 kZdsfJw9z/y7D71c+B8TwCM6hJbhUvLxDXkwg4266VgKpLFjnzSsOtOfK+j5YnZuPqkL+OiFz
 QmQLzr105dEREqzFI/0Jdk51w9VMI4psr38S8KvjuQVc67HVKqCikpi5TQa0116M6GFVBgGB8
 gS2sa0RHTasqRVVZLNwFouQzW2alv43DpWRagh2JeAGdgTby7Sm3bSXOFW3QbbVbyOgsODwv1
 LJ+pYMumjYxROvScJBPZOa3DB4Q86Qq3pXEdPtmCiKYtGbjdvhXqjm+nJwGUmmDuy4uWh3VGz
 fBAwo6CHwxDlzW/uw1qTmPf7MjggD6G+7D9k7VFhMmYKAkSysc=
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Am 29.12.2017 um 15:05 schrieb suzuki toshiya:
> The ownership of files created by git-archive is always
> root:root. Add --owner and --group options which work
> like the GNU tar equivalent to allow overriding these
> defaults.

In which situations do you use the new options?

(The sender would need to know the names and/or IDs on the receiving
end.  And the receiver would need to be root to set both IDs, or be a
group member to set the group ID; I guess the latter is more common.)

> Signed-off-by: suzuki toshiya <mpsuzuki@hiroshima-u.ac.jp>
> ---
>   Documentation/git-archive.txt |  13 +++
>   archive-tar.c                 |   8 +-
>   archive.c                     | 224 ++++++++++++++++++++++++++++++++++++++++++
>   archive.h                     |   4 +
>   t/t5005-archive-uid-gid.sh    | 140 ++++++++++++++++++++++++++
>   t/t5005/parse-tar-file.py     |  60 +++++++++++
>   tar.h                         |   2 +
>   7 files changed, 447 insertions(+), 4 deletions(-)
>   create mode 100755 t/t5005-archive-uid-gid.sh
>   create mode 100755 t/t5005/parse-tar-file.py

Would it make sense to support the new options for ZIP files as well?

> diff --git a/Documentation/git-archive.txt b/Documentation/git-archive.txt
> index cfa1e4ebe..0d156f6c1 100644
> --- a/Documentation/git-archive.txt
> +++ b/Documentation/git-archive.txt
> @@ -11,6 +11,7 @@ SYNOPSIS
>   [verse]
>   'git archive' [--format=<fmt>] [--list] [--prefix=<prefix>/] [<extra>]
>   	      [-o <file> | --output=<file>] [--worktree-attributes]
> +	      [--owner [username[:uid]] [--group [groupname[:gid]]
>   	      [--remote=<repo> [--exec=<git-upload-archive>]] <tree-ish>
>   	      [<path>...]
>   
> @@ -63,6 +64,18 @@ OPTIONS
>   	This can be any options that the archiver backend understands.
>   	See next section.
>   
> +--owner=<name>[:<uid>]::
> +	Force <name> as owner and <uid> as uid for the files in the tar
> +	archive.  If <uid> is not supplied, <name> can be either a user
> +	name or numeric UID.  In this case the missing part (UID or
> +	name) will be inferred from the current host's user database.
> +
> +--group=<name>[:<gid>]::
> +	Force <name> as group and <gid> as gid for the files in the tar
> +	archive.  If <gid> is not supplied, <name> can be either a group
> +	name or numeric GID.  In this case the missing part (GID or
> +	name) will be inferred from the current host's group database.
> +

IIUC the default behavior is kept, i.e. without these options the
archive entries appear to be owned by root:root.  I think it's a good
idea to mention this here.

bsdtar has --uname, --uid, --gname, and -gid, which seem simpler.  At
least you could use OPT_STRING and OPT_INTEGER with them (plus a range
check).  And they should be easier to explain.

> diff --git a/archive.c b/archive.c
> index 0b7b62af0..aa4b16b75 100644
> --- a/archive.c
> +++ b/archive.c
> @@ -8,6 +8,7 @@
>   #include "parse-options.h"
>   #include "unpack-trees.h"
>   #include "dir.h"
> +#include "tar.h"
>   
>   static char const * const archive_usage[] = {
>   	N_("git archive [<options>] <tree-ish> [<path>...]"),
> @@ -417,6 +418,223 @@ static void parse_treeish_arg(const char **argv,
>   	{ OPTION_SET_INT, (s), NULL, (v), NULL, "", \
>   	  PARSE_OPT_NOARG | PARSE_OPT_NONEG | PARSE_OPT_HIDDEN, NULL, (p) }
>   
> +/*
> + * GNU tar --owner, --group options reject hexdigit, signed int values.
> + * strtol(), atoi() are too permissive to simulate the behaviour.
> + */
> +#define STR_IS_DIGIT_OK 0
> +#define STR_IS_NOT_DIGIT -1
> +#define STR_IS_DIGIT_TOO_LARGE -2
> +
> +static int try_as_simple_digit(const char *s, unsigned long *dst)
> +{
> +	unsigned long ul;
> +	char *endptr;
> +
> +	if (strlen(s) != strspn(s, "0123456789"))
> +		return STR_IS_NOT_DIGIT;
> +
> +	errno = 0;
> +	ul = strtoul(s, &endptr, 10);
> +
> +	/* catch ERANGE */
> +	if (errno) {
> +		errno = 0;
> +		return STR_IS_DIGIT_TOO_LARGE;
> +	}
> +
> +#if ULONG_MAX > 0xFFFFFFFFUL
> +	/*
> +	 * --owner, --group rejects uid/gid greater than 32-bit
> +	 * limits, even on 64-bit platforms.
> +	 */
> +	if (ul > 0xFFFFFFFFUL)
> +		return STR_IS_DIGIT_TOO_LARGE;
> +#endif

The #if is not really necessary, is it?  Compilers should be able to
optimize the conditional out on 32-bit platforms.

> +static int set_args_uname_uid(struct archiver_args *args,
> +		const char *tar_owner)
> +{
> +	int r;
> +	struct passwd *pw = NULL;
> +
> +	if (!args || !tar_owner)
> +		return NAME_ID_ERR_PARAMS;
> +
> +	r = try_as_name_colon_digit(tar_owner, &(args->uname),
> +				    &(args->uid));
> +	switch (r) {
> +	case STR_IS_NAME_COLON_DIGIT:
> +		return NAME_ID_BOTH_GIVEN;
> +	case STR_HAS_DIGIT_TOO_LARGE:
> +		return NAME_ID_ERR_ID_TOO_LARGE;
> +	case STR_HAS_DIGIT_BROKEN:
> +		return NAME_ID_ERR_SYNTAX;
> +	}
> +
> +	/* the operand is known to be single token */
> +
> +	r = try_as_simple_digit(tar_owner, &(args->uid));
> +	switch (r) {
> +	case STR_IS_DIGIT_TOO_LARGE:
> +		return NAME_ID_ERR_ID_TOO_LARGE;
> +	case STR_IS_DIGIT_OK:
> +		pw = getpwuid(args->uid);
> +		if (!pw) {
> +			args->uname = xstrdup("");
> +			return NAME_ID_NAME_EMPTY;
> +		}
> +		args->uname = xstrdup(pw->pw_name);
> +		return NAME_ID_NAME_GUESSED;
> +	}
> +
> +	/* the operand is known to be non-digit */
> +
> +	args->uname = xstrdup(tar_owner);
> +	pw = getpwnam(tar_owner);
> +	if (!pw)
> +		return NAME_ID_ID_UNTOUCHED;
> +	args->uid = pw->pw_uid;
> +	return NAME_ID_ID_GUESSED;
> +}

How well does this work on Windows?  In daemon.c we avoid calling
getpwnam(3), getgrnam(3) etc. if NO_POSIX_GOODIES is not defined.

> diff --git a/t/t5005-archive-uid-gid.sh b/t/t5005-archive-uid-gid.sh
> new file mode 100755
> index 000000000..c5e08d890
> --- /dev/null
> +++ b/t/t5005-archive-uid-gid.sh
> @@ -0,0 +1,140 @@
> +#!/bin/sh
> +
> +test_description='test --owner --group options for git-archive'
> +. ./test-lib.sh
> +
> +test_expect_success 'create commit with a few empty files' '
> +	git init . 1>/dev/null 2>/dev/null &&
> +	touch uid-gid-test.001 &&
> +	mkdir uid-gid-test.002 &&
> +	mkdir uid-gid-test.002/uid-gid-test.003 &&
> +	git add uid-gid-test.001 &&
> +	git add uid-gid-test.002 &&
> +	git add uid-gid-test.002/uid-gid-test.003 &&
> +	git commit -m "uid-gid-test" 2>/dev/null 1>/dev/null
> +'
> +
> +check_uid_gid_uname_gname_in_tar() {
> +	# $1 tar pathname
> +	# $2 uid (digit in string)
> +	# $3 gid (digit in string)
> +	# $4 uname (string)
> +	# $5 gname (string)
> +	uid=`python "$TEST_DIRECTORY"/t5005/parse-tar-file.py --print=uid --fail-if-multi $1`
> +	if test $? != 0 -o x"${uid}" != "x"$2
> +	then
> +		echo "(some) uid differs from the specified value"
> +		return $?
> +	fi
> +
> +	gid=`python "$TEST_DIRECTORY"/t5005/parse-tar-file.py --print=gid --fail-if-multi $1`
> +	if test $? != 0 -o x"${gid}" != "x"$3
> +	then
> +		echo "(some) gid differs from the specified value"
> +		return $?
> +	fi
> +
> +	uname=`python "$TEST_DIRECTORY"/t5005/parse-tar-file.py --print=uname --fail-if-multi $1`
> +	if test $? != 0 -o x"${uname}" != "x"$4
> +	then
> +		echo "(some) uname differs from the specified value"
> +		return $?
> +	fi
> +
> +	gname=`python "$TEST_DIRECTORY"/t5005/parse-tar-file.py --print=gname --fail-if-multi $1`
> +	if test $? != 0 -o x"${gname}" != "x"$5
> +	then
> +		echo "(some) gname differs from the specified value"
> +		return $?
> +	fi
> +
> +	return 0
> +}

GNU tar and bsdtar show the names of owner and group with -t -v at
least, albeit in slightly different formats.  Can this help avoid
parsing the archive on our own?

But getting a short program like zipdetails for tar would be nice as
well of course. :)

René
