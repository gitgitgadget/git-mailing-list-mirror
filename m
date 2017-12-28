Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id B10DD1F406
	for <e@80x24.org>; Thu, 28 Dec 2017 14:42:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753424AbdL1OmJ (ORCPT <rfc822;e@80x24.org>);
        Thu, 28 Dec 2017 09:42:09 -0500
Received: from mail-wm0-f42.google.com ([74.125.82.42]:39970 "EHLO
        mail-wm0-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751411AbdL1OmI (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 28 Dec 2017 09:42:08 -0500
Received: by mail-wm0-f42.google.com with SMTP id f206so44030063wmf.5
        for <git@vger.kernel.org>; Thu, 28 Dec 2017 06:42:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:references:user-agent:in-reply-to:date
         :message-id:mime-version;
        bh=YCGxJxEzpmrZSChUL3iduvO01S2oS+PnL7GGk9b6/Xg=;
        b=D45am6QMbc7BwN1hI5CgZUK5iHObvn6IRy9grgajbX7OcXWygJ3BBEn7Speord/3qD
         VWF3EEYk82BE5vtUQENQ6uz+A30X/tMKC5JazkTCOEE5IODF2dXOtPzlTLuexesaPTFy
         Ptw6rd/cHwwHuRSZG9BSTfy1T7P5CmUThQoMneYVfAhpWZI9E94JBuZztMyHsvmfziOz
         yEATgfF4blzYAl/ySnQyQxVqF1uaKPSpsaXHJB6IHQK7MaO35hJNQEWYU3Zs5wxbBKpR
         yAwHXCTQTfMLKWxuACOaaULCELXLm87GWa0mkJf7MVEPkJ+XVNsGT3x8A7iKAOBPPOLQ
         d1mw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:references:user-agent
         :in-reply-to:date:message-id:mime-version;
        bh=YCGxJxEzpmrZSChUL3iduvO01S2oS+PnL7GGk9b6/Xg=;
        b=AFkpNB8kOLz7C13Op3SuZMWqXfqkeJTdFCoB4A0tXqmaAEeZEldWLOVfMWQM8CkaMB
         c14R2fQf2YSI7kgCjks5fufcaOL3XQjXMF6K4Wkm0+6ADrJeJTXNgoCPcpaSqX2bvO9b
         VxiUEzPwP6YwgBKZDRO1yHTs+934fkvzTT6Cl2wJBbg2PYqzXt2e0pfUmQGHTxjSvrXe
         JmYpOPrPNofcbDdSr1DbCrgd5W4bu1lIXBfL0ohGcapEx6eE/7VDGT6vs0dvdme13pmX
         2DdGc1ZKSg3zq4RC2Q5XBg66E/NHhsSkfXwOjgTW5KefQApd1ZbJkcbsdPW9N5ou12yH
         c8GQ==
X-Gm-Message-State: AKGB3mL9x+FxIvVtVetnkkEsd9Moqlh0jpSYtqGZl4uBQdq9MYVFYRCP
        YygFifjqj5v7DHayPkQNQLc=
X-Google-Smtp-Source: ACJfBotirOQc8W1SrzziegAwMHV7rwPqb1MW+ZWrHlgGdZWv+cnSFtBjILzq+kBeeo6ZfqtLBEFb8A==
X-Received: by 10.80.151.125 with SMTP id d58mr38961065edb.236.1514472127467;
        Thu, 28 Dec 2017 06:42:07 -0800 (PST)
Received: from evledraar (proxy-gw-a.booking.com. [5.57.21.8])
        by smtp.gmail.com with ESMTPSA id b7sm29851868eda.60.2017.12.28.06.42.06
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 28 Dec 2017 06:42:06 -0800 (PST)
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     suzuki toshiya <mpsuzuki@hiroshima-u.ac.jp>
Cc:     git@vger.kernel.org
Subject: Re: [PATCH] git-archive: accepts --owner --group aslike GNU tar.
References: <20171228090527.25056-1-mpsuzuki@hiroshima-u.ac.jp>
User-agent: Debian GNU/Linux 9.3 (stretch); Emacs 25.1.1; mu4e 0.9.19
In-reply-to: <20171228090527.25056-1-mpsuzuki@hiroshima-u.ac.jp>
Date:   Thu, 28 Dec 2017 15:42:05 +0100
Message-ID: <87incqrk1u.fsf@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Thu, Dec 28 2017, suzuki toshiya jotted:

Thanks for working on this Just a quick review from skimming this,
haven't actually applied + run this:

> git-archive: accepts --owner --group aslike GNU tar.

Make this:

    git-archive: accept --owner and --group like GNU tar

I.e. imperative voice, s/aslike/like/, no full stop at the end. See
Documentation/SubmittingPatches.

> Current tar output by git-archive has always root:root.
> To generate tar output with non-root owner/group,
> the options like GNU tar are added.

Grammar/wording fixes (IMHO):

    The ownership of files craeted by git-archive is always
    root:root. Add --owner and --group options which work like the GNU
    tar equivalent to allow overriding these defaults.

> * archive.h: add members 'uid', 'gid', 'uname', 'gname'
>   to struct archiver_args.
>
> * archive.c: add functions to reflect the operands of
>   '--owner' and '--group' to archiver_args.
>
> * archive-tar.c: copy 'uid', 'gid', 'uname', 'gname'
>   from archiver_args to the entry headers in tar archive.
>
> * t/parse-tar-file.py: a script to dump uid, gid, uname,
>   gname fields from a tar archive.
>
> * t/t5005-archive-uid-gid.sh: a test script comparing
>   uid, gid, uname, gname between the options and
>   generated tar file.

I'd skip this whole bit, no need to itemize changes per-file, we see
that from the patch, especially stuff like "add xyz struct field".

> ---
>  archive-tar.c              |  8 +++---
>  archive.c                  | 66 ++++++++++++++++++++++++++++++++++++++++++
>  archive.h                  |  4 +++
>  t/parse-tar-file.py        | 56 ++++++++++++++++++++++++++++++++++++
>  t/t5005-archive-uid-gid.sh | 71 ++++++++++++++++++++++++++++++++++++++++++++++
>  5 files changed, 201 insertions(+), 4 deletions(-)
>  create mode 100755 t/parse-tar-file.py
>  create mode 100755 t/t5005-archive-uid-gid.sh
>
> diff --git a/archive-tar.c b/archive-tar.c
> index c6ed96ee7..8546a6229 100644
> --- a/archive-tar.c
> +++ b/archive-tar.c
> @@ -204,10 +204,10 @@ static void prepare_header(struct archiver_args *args,
>  	xsnprintf(header->size, sizeof(header->size), "%011lo", S_ISREG(mode) ? size : 0);
>  	xsnprintf(header->mtime, sizeof(header->mtime), "%011lo", (unsigned long) args->time);
>
> -	xsnprintf(header->uid, sizeof(header->uid), "%07o", 0);
> -	xsnprintf(header->gid, sizeof(header->gid), "%07o", 0);
> -	strlcpy(header->uname, "root", sizeof(header->uname));
> -	strlcpy(header->gname, "root", sizeof(header->gname));
> +	xsnprintf(header->uid, sizeof(header->uid), "%07o", args->uid);
> +	xsnprintf(header->gid, sizeof(header->gid), "%07o", args->gid);
> +	strlcpy(header->uname, args->uname ? args->uname : "root", sizeof(header->uname));
> +	strlcpy(header->gname, args->gname ? args->gname : "root", sizeof(header->gname));
>  	xsnprintf(header->devmajor, sizeof(header->devmajor), "%07o", 0);
>  	xsnprintf(header->devminor, sizeof(header->devminor), "%07o", 0);
>
> diff --git a/archive.c b/archive.c
> index 0b7b62af0..db69041f1 100644
> --- a/archive.c
> +++ b/archive.c
> @@ -8,6 +8,7 @@
>  #include "parse-options.h"
>  #include "unpack-trees.h"
>  #include "dir.h"
> +#include "git-compat-util.h"
>
>  static char const * const archive_usage[] = {
>  	N_("git archive [<options>] <tree-ish> [<path>...]"),
> @@ -417,6 +418,57 @@ static void parse_treeish_arg(const char **argv,
>  	{ OPTION_SET_INT, (s), NULL, (v), NULL, "", \
>  	  PARSE_OPT_NOARG | PARSE_OPT_NONEG | PARSE_OPT_HIDDEN, NULL, (p) }
>
> +static void set_args_uname_uid(struct archiver_args *args,
> +		const char* tar_owner, int set_gid_too)
> +{
> +	if (!args || !tar_owner)
> +		return;
> +
> +	const char* col_pos = strchr(tar_owner, ':');
> +	struct passwd* pw = NULL;
> +
> +	if (col_pos) {
> +		args->uname = xstrndup(tar_owner, col_pos - tar_owner);
> +		args->uid = atoi(col_pos + 1);
> +		return;
> +	}
> +
> +	args->uname = xstrndup(tar_owner, strlen(tar_owner));
> +	pw = getpwnam(tar_owner);
> +	if (!pw)
> +		return;

Both here and in set_args_gname_gid you just silently ignore failures
when you can't find the group, is this really the desired behavior?

Also, it seems there's no way to specify a numeric id / group id, e.g. a
reasonable use-case is hardcoding a group that you don't have on the
computer you make the tarball on. Doesn't GNU tar support that as well?

> +	args->uid = pw->pw_uid;
> +	if (set_gid_too)
> +		args->gid = pw->pw_gid;
> +
> +	return;
> +}
> +
> +static void set_args_gname_gid(struct archiver_args *args,
> +		const char* tar_group)
> +{
> +	if (!args || !tar_group)
> +		return;
> +
> +	const char* col_pos = strchr(tar_group, ':');
> +	struct group* gr = NULL;
> +
> +	if (col_pos) {
> +		args->gname = xstrndup(tar_group, col_pos - tar_group);
> +		args->gid = atoi(col_pos + 1);
> +		return;
> +	}
> +
> +	args->gname = xstrndup(tar_group, strlen(tar_group));
> +	gr = getgrnam(tar_group);
> +	if (!gr)
> +		return;
> +
> +	args->gid = gr->gr_gid;
> +	return;
> +}
> +
>  static int parse_archive_args(int argc, const char **argv,
>  		const struct archiver **ar, struct archiver_args *args,
>  		const char *name_hint, int is_remote)
> @@ -431,6 +483,8 @@ static int parse_archive_args(int argc, const char **argv,
>  	int i;
>  	int list = 0;
>  	int worktree_attributes = 0;
> +	char *tar_owner = NULL;
> +	char *tar_group = NULL;
>  	struct option opts[] = {
>  		OPT_GROUP(""),
>  		OPT_STRING(0, "format", &format, N_("fmt"), N_("archive format")),
> @@ -459,6 +513,8 @@ static int parse_archive_args(int argc, const char **argv,
>  			N_("retrieve the archive from remote repository <repo>")),
>  		OPT_STRING(0, "exec", &exec, N_("command"),
>  			N_("path to the remote git-upload-archive command")),
> +		OPT_STRING(0, "owner", &tar_owner, N_("owner"), N_("<name[:uid]> in tar")),
> +		OPT_STRING(0, "group", &tar_group, N_("group"), N_("<name[:gid]> in tar")),
>  		OPT_END()
>  	};
>
> @@ -507,6 +563,16 @@ static int parse_archive_args(int argc, const char **argv,
>  	args->baselen = strlen(base);
>  	args->worktree_attributes = worktree_attributes;
>
> +	args->uname = NULL;
> +	args->gname = NULL;
> +	args->uid = 0;
> +	args->gid = 0;
> +	set_args_uname_uid(args,
> +		tar_owner,
> +		1 /* init args->gid by pw, if resolved */);
> +	set_args_gname_gid(args,
> +		tar_group);
> +

Some overzelous line wrapping here. This could all just be on one line.

>  	return argc;
>  }
>
> diff --git a/archive.h b/archive.h
> index 62d1d82c1..fad4a5d3e 100644
> --- a/archive.h
> +++ b/archive.h
> @@ -15,6 +15,10 @@ struct archiver_args {
>  	unsigned int worktree_attributes : 1;
>  	unsigned int convert : 1;
>  	int compression_level;
> +	int uid;
> +	int gid;
> +	const char *uname;
> +	const char *gname;
>  };
>
>  #define ARCHIVER_WANT_COMPRESSION_LEVELS 1
> diff --git a/t/parse-tar-file.py b/t/parse-tar-file.py

If you add a helper script please put it in a folder in t/, see "ls
t/*/*.pl" for examples.

> new file mode 100755
> index 000000000..c240a8676
> --- /dev/null
> +++ b/t/parse-tar-file.py
> @@ -0,0 +1,56 @@
> +#!/usr/bin/env python
> +
> +import sys
> +import getopt
> +import tarfile
> +
> +optlist, args = getopt.getopt( sys.argv[1:], "", [
> +				"print=", "show=",
> +				"uniq",
> +				"fail-if-multi",
> +		] )
> +
> +infos_to_print = []
> +uniq = False
> +fail_if_multi = False
> +
> +for opt in optlist:
> +  if opt[0] == "--print":
> +    infos_to_print.append(opt[1])
> +  elif opt[0] == "--show":
> +    infos_to_print.append(opt[1])
> +  elif opt[0] == "--uniq":
> +    uniq = True
> +  elif opt[0] == "--fail-if-multi":
> +    uniq = True
> +    fail_if_multi = True
> +

Also the Git project uses 4-space indent for Python elsewhere AFACT.

> +if len(infos_to_print) == 0:
> +  infos_to_print = ["uid", "gid", "uname", "gname", "name"]
> +
> +tar = tarfile.open( args[0] )
> +out_lines = []
> +for tarinfo in tar:
> +  infos = []
> +  for info_tag in infos_to_print:
> +    if info_tag == "uid":
> +      infos.append( str(tarinfo.uid) )
> +    elif info_tag == "gid":
> +      infos.append( str(tarinfo.gid) )
> +    elif info_tag == "uname" or info_tag == "owner":
> +      infos.append( tarinfo.uname )
> +    elif info_tag == "gname" or info_tag == "group":
> +      infos.append( tarinfo.gname )
> +    elif info_tag == "name" or info_tag == "pathname":
> +      infos.append( tarinfo.name )
> +  out_lines.append( "\t".join(infos) )
> +tar.close()
> +
> +if uniq:
> +  out_lines = list(set(out_lines))
> +  if fail_if_multi and (len(out_lines) > 1):
> +    sys.stderr.write("*** not unique value, " + str(len(out_lines)) + " values found\n")
> +    sys.exit(len(out_lines))
> +
> +for line in out_lines:
> +  print line
> diff --git a/t/t5005-archive-uid-gid.sh b/t/t5005-archive-uid-gid.sh
> new file mode 100755
> index 000000000..2b2a694d8
> --- /dev/null
> +++ b/t/t5005-archive-uid-gid.sh
> @@ -0,0 +1,71 @@
> +#!/bin/sh
> +
> +test_description='test --owner --group options for git-archive'
> +. ./test-lib.sh
> +
> +check_uid_gid_uname_gname_in_tar() {
> +	# $1 tar pathname
> +	# $2 uid (digit in string)
> +	# $3 gid (digit in string)
> +	# $4 uname (string)
> +	# $5 gname (string)
> +	uid=`./parse-tar-file.py --print=uid --fail-if-multi $1`
> +	if test $? != 0 -o x"${uid}" != "x"$2
> +	then
> +	  echo "(some) uid differs from the specified value"
> +	  return $?
> +        fi

Very odd indenting going on here. Should be tabs.

> +
> +	gid=`./parse-tar-file.py --print=gid --fail-if-multi $1`
> +	if test $? != 0 -o x"${gid}" != "x"$3
> +	then
> +	  echo "(some) gid differs from the specified value"
> +	  return $?
> +	  exit $?
> +        fi
> +
> +	uname=`./parse-tar-file.py --print=uname --fail-if-multi $1`
> +	if test $? != 0 -o x"${uname}" != "x"$4
> +	then
> +	  echo "(some) uname differs from the specified value"
> +	  return $?
> +        fi
> +
> +	gname=`./parse-tar-file.py --print=gname --fail-if-multi $1`
> +	if test $? != 0 -o x"${gname}" != "x"$5
> +	then
> +	  echo "(some) gname differs from the specified value"
> +	  return $?
> +        fi
> +
> +	return 0
> +}
> +
> +git init . 1>/dev/null 2>/dev/null
> +touch uid-gid-test.001
> +mkdir uid-gid-test.002
> +mkdir uid-gid-test.002/uid-gid-test.003
> +git add uid-gid-test.001
> +git add uid-gid-test.002
> +git add uid-gid-test.002/uid-gid-test.003
> +git commit -m "uid-gid-test" 2>/dev/null 1>/dev/null

All of this setup stuff should be in a test, see "git grep
test_expect.*setup" for examples. Also see the helpers we have in
t/README, i.e. "test_commit" etc.

> +test_expect_success 'test a case with explicitly specified name/id, owner=nobody:1234 group=nogroup:5678' '
> +	git archive --format=tar --owner nobody:1234 --group nogroup:5678 HEAD > uid-gid-test1.tar &&
> +	check_uid_gid_uname_gname_in_tar uid-gid-test1.tar 1234 5678 nobody nogroup &&
> +	test_result=$? &&
> +	return ${test_result}
> +'

There's no need to assign $? to a variable and then return it, just make
check_uid_gid_uname_gname_in_tar be the last thing you do in the test.

> +
> +test_expect_success 'test a case with only name is specified, owner=(current my name) group=(current my group)' '
> +	my_uid=`id -u` &&
> +	my_gid=`id -g` &&
> +	my_uname=`id -u -n` &&
> +	my_gname=`id -g -n` &&
> +	git archive --format=tar --owner ${my_uname} --group ${my_gname} HEAD > uid-gid-test2.tar &&
> +	check_uid_gid_uname_gname_in_tar uid-gid-test2.tar ${my_uid} ${my_gid} ${my_uname} ${my_gname} &&
> +	test_result=$? &&
> +	return ${test_result}
> +'
> +
> +test_done

I'd probably notice other stuff if I did more than skim this, but I'll
stop for now...
