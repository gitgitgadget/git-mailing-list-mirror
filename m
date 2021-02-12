Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.2 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1E0E3C433E0
	for <git@archiver.kernel.org>; Fri, 12 Feb 2021 16:16:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D5A5564E70
	for <git@archiver.kernel.org>; Fri, 12 Feb 2021 16:16:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231754AbhBLQQy (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 12 Feb 2021 11:16:54 -0500
Received: from mout.gmx.net ([212.227.17.22]:43865 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229788AbhBLQQr (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 12 Feb 2021 11:16:47 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1613146509;
        bh=I7fdOZ/GE6neN3l3BzlJm7IPPfKqIzNB2FEz9gZk4DQ=;
        h=X-UI-Sender-Class:Date:From:To:cc:Subject:In-Reply-To:References;
        b=eeobvURfrqu/Xb0lZ7scKR6zGg2rOOybYKt6hf78uy0aerwFG4A2qmnBn64gIdTSe
         9DIy460SHewJPG0mdNsrzhytSXfIoBN0COMv8WU5mrhBJrGzFwQs2bHEO17sVKWo8k
         YuGVK5lzm/0Z0zxdyQHLLISUCYa9fJ8696e334X8=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [172.19.95.40] ([213.196.212.209]) by mail.gmx.net (mrgmx104
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1MVvPJ-1lIbs01jRl-00RmLP; Fri, 12
 Feb 2021 17:15:09 +0100
Date:   Fri, 12 Feb 2021 17:15:09 +0100 (CET)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@gitforwindows.org
To:     Junio C Hamano <gitster@pobox.com>
cc:     git@vger.kernel.org, ZheNing Hu <adlternative@gmail.com>
Subject: Re: [PATCH] diff: --{rotate,skip}-to=<path>
In-Reply-To: <xmqqo8gqwasu.fsf@gitster.c.googlers.com>
Message-ID: <nycvar.QRO.7.76.6.2102121713390.29765@tvgsbejvaqbjf.bet>
References: <xmqqo8gqwasu.fsf@gitster.c.googlers.com>
User-Agent: Alpine 2.21.1 (DEB 209 2017-03-23)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K1:5wYmD6/a2nb7swZApLfTNEjml+xSLYOSjkfYt23sVsaO8m9eo/6
 IZPp0MSRRjCJ22c/6ObmMxoydR1/czTuVQ62dzXzNekNKWUruraoby3iThZGT1KymS14Av4
 RR07A5LdZGKIi2/nMemgnAK3hlx+xUGYxzSCGi2ADanO2USUjKTb1dnMLSsSpsK0OJqid43
 V3tvWNKqn2O9hNXjPwk2w==
X-UI-Out-Filterresults: notjunk:1;V03:K0:LsO/YUqdY54=:7q2V140f9PibamwT7gjJP1
 jBRABmy41SA5/aVJInQuvysm4alqEjw4tA1prprWtiI1AyJDb2bI7Xs2dExWG0fBJbdpBgk+e
 bkCga9q8sPeJiWSSmuMCnKFBL+3tFrs8S1/x306tZzMlxNR/c+lOrNo3ltmxzYpZA4K9pqRnJ
 1ARgOgLrtyCn4XMh22FMlrVVWTDOCtWP1DH+6q7hvfziDh42GT+EukRTbyUI9ySZlmZu8c+2u
 t2/SIV6iE+218M/GbSjiOUOEp/pUdP+aQ7kWDDGNSFuN7R52dJWB9aQakACDAhj9Zh4sky9+e
 TsB3752TTbXOORTn5kT4SeYrf8cL0S1ORVO8SLWnxgjy5gOfTUrGZx1M97RXusLH/Rnez/F7G
 Lqp5vpXVguWgVtreP0wuImTQH0Tf+qPJd7rrI+UTuHRlx9D4FdDbgQ9H8+Sft9lKAT3JzUxyk
 VxrLNpDcQDJIEIUd82a8hGA/wPXhDrgq8mINvhJfmh/v57W6KsqbRUXsniERurHb7ZTruLxAV
 6ILqCgFIUR388BE+RsdMRJ293X5OPOg9MF7MSJbJKN3Xzs++CPQmuV8Q0n0NSp3iw442ntt16
 LNzMGSJlhoJjpFWHejQteU8e4JVojxBS8+7CvsHoI2I4nSenAyS298ungbYXMbk4QUy1z1jyR
 TzAhILIhE/zoHVlsrpunM4lS+aECh7QtPJDYUgdxG8LnVdRAhEsbGeCc3+vtgqrOxIWYShs/4
 5bzfwaNbHsKf4UBgOhK4eFvl8v7bwwhmbPaGrDXcRh7jtyTvBVAocNLj8zW9KyZkdFSVPsPzk
 rR0MsbS7ubIY8/v57W5IAgvpWelPTu7s5oS3yhgZpfWY96OjJUHMXpmda0AoDGR7cI09yi37d
 /JyNQU0iBcBHb3jBxDMJLy/pSPZ24BYPdo7tXTTaU=
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi,

On Thu, 11 Feb 2021, Junio C Hamano wrote:

> In the implementation of "git difftool", there is a case where the
> user wants to start viewing the diffs at a specific path and
> continue on to the rest, optionally wrapping around to the
> beginning.  Since it is somewhat cumbersome to implement such a
> feature as a post-processing step of "git diff" output, let's
> support it internally with two new options.
>
>  - "git diff --rotate-to=3DC", when the resulting patch would show
>    paths A B C D E without the option, would "rotate" the paths to
>    shows patch to C D E A B instead.  It is an error when there is
>    no patch for C is shown.
>
>  - "git diff --skip-to=3DC" would instead "skip" the paths before C,
>    and shows patch to C D E.  Again, it is an error when there is no
>    patch for C is shown.
>
>  - "git log [-p]" also accepts these two options, but it is not an
>    error if there is no change to the specified path.  Instead, the
>    set of output paths are rotated or skipped to the specified path
>    or the first path that sorts after the specified path.

This is more a drive-by comment, as I have no stake in this, but don't we
already have a more generic solution via `-O<orderfile>`? See
https://git-scm.com/docs/git-diff#Documentation/git-diff.txt--Oltorderfile=
gt
for details.

Thanks,
Dscho

>
> Signed-off-by: Junio C Hamano <gitster@pobox.com>
> ---
>
>  * Please do not take the presense of --skip-to and --rotate-to as
>    encouraging "git difftool" to gain the same pair of options.  I
>    think "--skip-to" would suffice for the originally presented use
>    case (i.e. eeek, my difftool session got interrupted when I was
>    looking at path X, and I only have just a few more paths to go,
>    X, Y and Z) and if that is the case, there is no need to expose
>    "--rotate-to" to the end users.  Of course, if it is easy to quit
>    the "difftool" session in the middle, then giving the users only
>    "--rotate-to" without exposing "--skip-to" is also OK.
>
>    I decided to diagnose a pathname that is not in the diff-queue as
>    an error when running the "diff" family, while allowing the
>    command to continue when running the "log" family, so it may turn
>    out to be that "git difftool --skip-to" do not have to implement
>    its own error handling after all.
>
>    It has been quite a long time for me to write any real patch with
>    a non-trivial amount of code change myself, so I may be getting
>    rusty, but it is refreshing to write code every so often ;-)
>
>  Documentation/diff-options.txt |  8 ++++
>  Documentation/gitdiffcore.txt  | 21 ++++++++++
>  Makefile                       |  1 +
>  builtin/diff-files.c           |  1 +
>  builtin/diff-index.c           |  2 +
>  builtin/diff-tree.c            |  3 ++
>  builtin/diff.c                 |  1 +
>  diff.c                         | 21 ++++++++++
>  diff.h                         | 21 ++++++++++
>  diffcore-rotate.c              | 46 ++++++++++++++++++++++
>  diffcore.h                     |  1 +
>  t/t4056-diff-order.sh          | 72 +++++++++++++++++++++++++++++++++-
>  12 files changed, 197 insertions(+), 1 deletion(-)
>  create mode 100644 diffcore-rotate.c
>
> diff --git a/Documentation/diff-options.txt b/Documentation/diff-options=
.txt
> index e5733ccb2d..7c5b3cf42b 100644
> --- a/Documentation/diff-options.txt
> +++ b/Documentation/diff-options.txt
> @@ -700,6 +700,14 @@ matches a pattern if removing any number of the fin=
al pathname
>  components matches the pattern.  For example, the pattern "`foo*bar`"
>  matches "`fooasdfbar`" and "`foo/bar/baz/asdf`" but not "`foobarx`".
>
> +--skip-to=3D<file>::
> +--rotate-to=3D<file::
> +	Discard the files before the named <file> from the output
> +	(i.e. 'skip to'), or move them to the end of the output
> +	(i.e. 'rotate to').  These were invented primarily for use
> +	of the `git difftool` command, and may not be very useful
> +	otherwise.
> +
>  ifndef::git-format-patch[]
>  -R::
>  	Swap two inputs; that is, show differences from index or
> diff --git a/Documentation/gitdiffcore.txt b/Documentation/gitdiffcore.t=
xt
> index c970d9fe43..2bd1220477 100644
> --- a/Documentation/gitdiffcore.txt
> +++ b/Documentation/gitdiffcore.txt
> @@ -74,6 +74,7 @@ into another list.  There are currently 5 such transfo=
rmations:
>  - diffcore-merge-broken
>  - diffcore-pickaxe
>  - diffcore-order
> +- diffcore-rotate
>
>  These are applied in sequence.  The set of filepairs 'git diff-{asteris=
k}'
>  commands find are used as the input to diffcore-break, and
> @@ -276,6 +277,26 @@ Documentation
>  t
>  ------------------------------------------------
>
> +diffcore-rotate: For Changing At Which Path Output Starts
> +---------------------------------------------------------
> +
> +This transformation takes one pathname, and rotates the set of
> +filepairs so that the filepair for the given pathname comes first,
> +optionally discarding the paths that come before it.  This is used
> +to implement the `--skip-to` and the `--rotate-to` options.  It is
> +an error when the specified pathname is not in the set of filepairs,
> +but it is not useful to error out when used with "git log" family of
> +commands, because it is unreasonable to expect that a given path
> +would be modified by each and every commit shown by the "git log"
> +command.  For this reason, when used with "git log", the filepair
> +that sorts the same as, or the first one that sorts after, the given
> +pathname is where the output starts.
> +
> +Use of this transformation combined with diffcore-order will produce
> +unexpected results, as the input to this transformation is likely
> +not sorted when diffcore-order is in effect.
> +
> +
>  SEE ALSO
>  --------
>  linkgit:git-diff[1],
> diff --git a/Makefile b/Makefile
> index 5a239cac20..9b1bde2e0e 100644
> --- a/Makefile
> +++ b/Makefile
> @@ -863,6 +863,7 @@ LIB_OBJS +=3D diffcore-delta.o
>  LIB_OBJS +=3D diffcore-order.o
>  LIB_OBJS +=3D diffcore-pickaxe.o
>  LIB_OBJS +=3D diffcore-rename.o
> +LIB_OBJS +=3D diffcore-rotate.o
>  LIB_OBJS +=3D dir-iterator.o
>  LIB_OBJS +=3D dir.o
>  LIB_OBJS +=3D editor.o
> diff --git a/builtin/diff-files.c b/builtin/diff-files.c
> index 4742a4559b..e037efb07e 100644
> --- a/builtin/diff-files.c
> +++ b/builtin/diff-files.c
> @@ -54,6 +54,7 @@ int cmd_diff_files(int argc, const char **argv, const =
char *prefix)
>  	}
>  	if (!rev.diffopt.output_format)
>  		rev.diffopt.output_format =3D DIFF_FORMAT_RAW;
> +	rev.diffopt.rotate_to_strict =3D 1;
>
>  	/*
>  	 * Make sure there are NO revision (i.e. pending object) parameter,
> diff --git a/builtin/diff-index.c b/builtin/diff-index.c
> index 7f5281c461..06635e8fb2 100644
> --- a/builtin/diff-index.c
> +++ b/builtin/diff-index.c
> @@ -41,6 +41,8 @@ int cmd_diff_index(int argc, const char **argv, const =
char *prefix)
>  	if (!rev.diffopt.output_format)
>  		rev.diffopt.output_format =3D DIFF_FORMAT_RAW;
>
> +	rev.diffopt.rotate_to_strict =3D 1;
> +
>  	/*
>  	 * Make sure there is one revision (i.e. pending object),
>  	 * and there is no revision filtering parameters.
> diff --git a/builtin/diff-tree.c b/builtin/diff-tree.c
> index 9fc95e959f..b6a9a9328e 100644
> --- a/builtin/diff-tree.c
> +++ b/builtin/diff-tree.c
> @@ -156,6 +156,8 @@ int cmd_diff_tree(int argc, const char **argv, const=
 char *prefix)
>  	if (merge_base && opt->pending.nr !=3D 2)
>  		die(_("--merge-base only works with two commits"));
>
> +	opt->diffopt.rotate_to_strict =3D 1;
> +
>  	/*
>  	 * NOTE!  We expect "a..b" to expand to "^a b" but it is
>  	 * perfectly valid for revision range parser to yield "b ^a",
> @@ -192,6 +194,7 @@ int cmd_diff_tree(int argc, const char **argv, const=
 char *prefix)
>  		int saved_nrl =3D 0;
>  		int saved_dcctc =3D 0;
>
> +		opt->diffopt.rotate_to_strict =3D 0;
>  		if (opt->diffopt.detect_rename) {
>  			if (!the_index.cache)
>  				repo_read_index(the_repository);
> diff --git a/builtin/diff.c b/builtin/diff.c
> index 5cfe1717e8..f1b88c7389 100644
> --- a/builtin/diff.c
> +++ b/builtin/diff.c
> @@ -491,6 +491,7 @@ int cmd_diff(int argc, const char **argv, const char=
 *prefix)
>  	}
>
>  	rev.diffopt.flags.recursive =3D 1;
> +	rev.diffopt.rotate_to_strict =3D 1;
>
>  	setup_diff_pager(&rev.diffopt);
>
> diff --git a/diff.c b/diff.c
> index 69e3bc00ed..71e4738548 100644
> --- a/diff.c
> +++ b/diff.c
> @@ -5348,6 +5348,19 @@ static int diff_opt_word_diff_regex(const struct =
option *opt,
>  	return 0;
>  }
>
> +static int diff_opt_rotate_to(const struct option *opt, const char *arg=
, int unset)
> +{
> +	struct diff_options *options =3D opt->value;
> +
> +	BUG_ON_OPT_NEG(unset);
> +	if (!strcmp(opt->long_name, "skip-to"))
> +		options->skip_instead_of_rotate =3D 1;
> +	else
> +		options->skip_instead_of_rotate =3D 0;
> +	options->rotate_to =3D arg;
> +	return 0;
> +}
> +
>  static void prep_parse_options(struct diff_options *options)
>  {
>  	struct option parseopts[] =3D {
> @@ -5599,6 +5612,12 @@ static void prep_parse_options(struct diff_option=
s *options)
>  			  DIFF_PICKAXE_REGEX, PARSE_OPT_NONEG),
>  		OPT_FILENAME('O', NULL, &options->orderfile,
>  			     N_("control the order in which files appear in the output")),
> +		OPT_CALLBACK_F(0, "rotate-to", options, N_("<path>"),
> +			       N_("show the change in the specified path first"),
> +			       PARSE_OPT_NONEG, diff_opt_rotate_to),
> +		OPT_CALLBACK_F(0, "skip-to", options, N_("<path>"),
> +			       N_("skip the output to the specified path"),
> +			       PARSE_OPT_NONEG, diff_opt_rotate_to),
>  		OPT_CALLBACK_F(0, "find-object", options, N_("<object-id>"),
>  			       N_("look for differences that change the number of occurrence=
s of the specified object"),
>  			       PARSE_OPT_NONEG, diff_opt_find_object),
> @@ -6669,6 +6688,8 @@ void diffcore_std(struct diff_options *options)
>  		diffcore_pickaxe(options);
>  	if (options->orderfile)
>  		diffcore_order(options->orderfile);
> +	if (options->rotate_to)
> +		diffcore_rotate(options);
>  	if (!options->found_follow)
>  		/* See try_to_follow_renames() in tree-diff.c */
>  		diff_resolve_rename_copy();
> diff --git a/diff.h b/diff.h
> index 2ff2b1c7f2..45300e3597 100644
> --- a/diff.h
> +++ b/diff.h
> @@ -227,6 +227,27 @@ enum diff_submodule_format {
>  struct diff_options {
>  	const char *orderfile;
>
> +	/*
> +	 * "--rotate-to=3D<file>" would start showing at <file> and when
> +	 * the output reaches the end, wrap around by default.
> +	 * Setting skip_instead_of_rotate to true stops the output at the
> +	 * end, effectively discarding the earlier part of the output
> +	 * before <file>'s diff (this is used to implement the
> +	 * "--skip-to=3D<file>" option).
> +	 *
> +	 * When rotate_to_strict is set, it is an error if there is no
> +	 * <file> in the diff.  Otherwise, the output starts at the
> +	 * path that is the same as, or first path that sorts after,
> +	 * <file>.  Because it is unreasonable to require the exact
> +	 * match for "git log -p --rotate-to=3D<file>" (i.e. not all
> +	 * commit would touch that single <file>), "git log" sets it
> +	 * to false.  "git diff" sets it to true to detect an error
> +	 * in the command line option.
> +	 */
> +	const char *rotate_to;
> +	int skip_instead_of_rotate;
> +	int rotate_to_strict;
> +
>  	/**
>  	 * A constant string (can and typically does contain newlines to look =
for
>  	 * a block of text, not just a single line) to filter out the filepair=
s
> diff --git a/diffcore-rotate.c b/diffcore-rotate.c
> new file mode 100644
> index 0000000000..445f060ab0
> --- /dev/null
> +++ b/diffcore-rotate.c
> @@ -0,0 +1,46 @@
> +/*
> + * Copyright (C) 2021, Google LLC.
> + * Based on diffcore-order.c, which is Copyright (C) 2005, Junio C Hama=
no
> + */
> +#include "cache.h"
> +#include "diff.h"
> +#include "diffcore.h"
> +
> +void diffcore_rotate(struct diff_options *opt)
> +{
> +	struct diff_queue_struct *q =3D &diff_queued_diff;
> +	struct diff_queue_struct outq;
> +	int rotate_to, i;
> +
> +	if (!q->nr)
> +		return;
> +
> +	for (i =3D 0; i < q->nr; i++) {
> +		int cmp =3D strcmp(opt->rotate_to, q->queue[i]->two->path);
> +		if (!cmp)
> +			break; /* exact match */
> +		if (!opt->rotate_to_strict && cmp < 0)
> +			break; /* q->queue[i] is now past the target pathname */
> +	}
> +
> +	if (q->nr <=3D i) {
> +		/* we did not find the specified path */
> +		if (opt->rotate_to_strict)
> +			die(_("No such path '%s' in the diff"), opt->rotate_to);
> +		return;
> +	}
> +
> +	DIFF_QUEUE_CLEAR(&outq);
> +	rotate_to =3D i;
> +
> +	for (i =3D rotate_to; i < q->nr; i++)
> +		diff_q(&outq, q->queue[i]);
> +	for (i =3D 0; i < rotate_to; i++) {
> +		if (opt->skip_instead_of_rotate)
> +			diff_free_filepair(q->queue[i]);
> +		else
> +			diff_q(&outq, q->queue[i]);
> +	}
> +	free(q->queue);
> +	*q =3D outq;
> +}
> diff --git a/diffcore.h b/diffcore.h
> index d2a63c5c71..c1592bcd01 100644
> --- a/diffcore.h
> +++ b/diffcore.h
> @@ -164,6 +164,7 @@ void diffcore_rename(struct diff_options *);
>  void diffcore_merge_broken(void);
>  void diffcore_pickaxe(struct diff_options *);
>  void diffcore_order(const char *orderfile);
> +void diffcore_rotate(struct diff_options *);
>
>  /* low-level interface to diffcore_order */
>  struct obj_order {
> diff --git a/t/t4056-diff-order.sh b/t/t4056-diff-order.sh
> index 63ea7144bb..aec1d9d1b4 100755
> --- a/t/t4056-diff-order.sh
> +++ b/t/t4056-diff-order.sh
> @@ -1,6 +1,6 @@
>  #!/bin/sh
>
> -test_description=3D'diff order'
> +test_description=3D'diff order & rotate'
>
>  GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME=3Dmain
>  export GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME
> @@ -127,4 +127,74 @@ do
>  	'
>  done
>
> +### rotate and skip
> +
> +test_expect_success 'rotate and skip setup' '
> +	>sample1.t &&
> +	>sample2.t &&
> +	>sample3.t &&
> +	>sample4.t &&
> +	git add sample[1234].t &&
> +	git commit -m "added" sample[1234].t &&
> +	echo modified >>sample1.t &&
> +	echo modified >>sample2.t &&
> +	echo modified >>sample4.t &&
> +	git commit -m "updated" sample[1234].t
> +'
> +
> +test_expect_success 'diff --rotate-to' '
> +	git diff --rotate-to=3Dsample2.t --name-only HEAD^ >actual &&
> +	test_write_lines sample2.t sample4.t sample1.t >expect &&
> +	test_cmp expect actual
> +'
> +
> +test_expect_success 'diff --skip-to' '
> +	git diff --skip-to=3Dsample2.t --name-only HEAD^ >actual &&
> +	test_write_lines sample2.t sample4.t >expect &&
> +	test_cmp expect actual
> +'
> +
> +test_expect_success 'diff --rotate/skip-to error condition' '
> +	test_must_fail git diff --rotate-to=3Dsample3.t HEAD^ &&
> +	test_must_fail git diff --skip-to=3Dsample3.t HEAD^
> +'
> +
> +test_expect_success 'log --rotate-to' '
> +	git log --rotate-to=3Dsample3.t --raw HEAD~2.. >raw &&
> +	# just distill the commit header and paths
> +	sed -n -e "s/^commit.*/commit/p" \
> +	       -e "/^:/s/^.*	//p" raw >actual &&
> +
> +	cat >expect <<-\EOF &&
> +	commit
> +	sample4.t
> +	sample1.t
> +	sample2.t
> +	commit
> +	sample3.t
> +	sample4.t
> +	sample1.t
> +	sample2.t
> +	EOF
> +
> +	test_cmp expect actual
> +'
> +
> +test_expect_success 'log --skip-to' '
> +	git log --skip-to=3Dsample3.t --raw HEAD~2.. >raw &&
> +	# just distill the commit header and paths
> +	sed -n -e "s/^commit.*/commit/p" \
> +	       -e "/^:/s/^.*	//p" raw >actual &&
> +
> +	cat >expect <<-\EOF &&
> +	commit
> +	sample4.t
> +	commit
> +	sample3.t
> +	sample4.t
> +	EOF
> +
> +	test_cmp expect actual
> +'
> +
>  test_done
> --
> 2.30.1-633-gb004a83696
>
>
