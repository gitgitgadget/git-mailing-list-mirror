Return-Path: <SRS0=mJAO=7L=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.7 required=3.0 tests=DATE_IN_PAST_12_24,
	DKIM_SIGNED,DKIM_VALID,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MALFORMED_FREEMAIL,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DFB6DC433DF
	for <git@archiver.kernel.org>; Fri, 29 May 2020 19:12:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id AAA05207F9
	for <git@archiver.kernel.org>; Fri, 29 May 2020 19:12:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=gmx.net header.i=@gmx.net header.b="AKcs5PBW"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727804AbgE2TMa (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 29 May 2020 15:12:30 -0400
Received: from mout.gmx.net ([212.227.15.15]:43387 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726549AbgE2TMa (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 29 May 2020 15:12:30 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1590779538;
        bh=je7kPO0mIf0lr3eBEWvpaj/tz7IK0ozmbPuZommBCuY=;
        h=X-UI-Sender-Class:Date:From:To:cc:Subject:In-Reply-To:References;
        b=AKcs5PBW0cfGY0MWBtBJhe1Au2KyJOAqQgI0NFMbbzXvTMzCMQnKoAog3d8VwFiev
         e60P/BROJnXVgAetdFYNY38CaMhAWX4JPI89LdVLy+d5gNoQKdVAA1uj7VaEI4o4tY
         eTw9n3msdQC7DCXobDcJLcjDnoXj9v7fFncQT/d0=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [172.23.211.123] ([89.1.214.207]) by mail.gmx.com (mrgmx005
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1N8ofE-1iu51o2Gz0-015uLP; Fri, 29
 May 2020 21:12:18 +0200
Date:   Fri, 29 May 2020 04:38:37 +0200 (CEST)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@gitforwindows.org
To:     Phillip Wood <phillip.wood@dunelm.org.uk>
cc:     Junio C Hamano <gitster@pobox.com>,
        Elijah Newren <newren@gmail.com>,
        Rohit Ashiwal <rohit.ashiwal265@gmail.com>,
        =?UTF-8?Q?=C4=90o=C3=A0n_Tr=E1=BA=A7n_C=C3=B4ng_Danh?= 
        <congdanhqx@gmail.com>, Alban Gruin <alban.gruin@gmail.com>,
        Git Mailing List <git@vger.kernel.org>
Subject: Re: [PATCH v4 1/5] rebase -i: add --ignore-whitespace flag
In-Reply-To: <20200527173356.47364-2-phillip.wood123@gmail.com>
Message-ID: <nycvar.QRO.7.76.6.2005290437350.56@tvgsbejvaqbjf.bet>
References: <20200407141125.30872-1-phillip.wood123@gmail.com> <20200527173356.47364-1-phillip.wood123@gmail.com> <20200527173356.47364-2-phillip.wood123@gmail.com>
User-Agent: Alpine 2.21.1 (DEB 209 2017-03-23)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K1:Bj66EYNNaMIuyvSE4Pp2d8XU/c4yeB+NpkcG/CLe7UlnraKFAfk
 Zft3mueCQZEh0YdN0zuBlAjhLenQXUl07vq9M+cn8ecsdnGd3TfqJdMdfQ1Dqy3HwFUsxtV
 KEFN6MTgFMy68v/WPj2z/TrOQMvzQvaIF6XSPFZo9Gr6WFAvrYNuJ5AQ3wjGrnQyk17p6z4
 5h5LD1u3yGof/TRAq9IeQ==
X-UI-Out-Filterresults: notjunk:1;V03:K0:eQzSrxU+6y0=:CWRuCie1oDcLgcoaaHsHLf
 GuMlLREq0cq+F38HHf8mqSr7yau81InRlgaTRfDmJOu77cEJa5i/bM2hrTFAKUWF0jNUvnQn4
 G5zgdrYAUDfrdQ7TU1DRRxjig1qLX5VrZzQ9egz2pNnlOzbm2HvtB1+CWcR6Em5UQ4CAdP22m
 7XkpGFC1XyN1Hz/p1v+1KtOjCJ8ES72V8bijK3i/KN90kiRA/f9lXRDM9QpKlLo2NfkfSFL9y
 3usyAgHZUJeOdbyd1wy3eJ43oeyWDoQElUpIMEQdWYt260tyCJdf/myDYOg2QWMEWUFqauoaK
 jBR00oCwlMPUmjok7vjYKfXDuNZkiYqekB+M0H0H+O7AI200+YlrPf2CuEPzS4lQhWw62gS4k
 7EUTqJSQruFKodG6kRBz2jmW4kE4z4f+m7tFr9rZH+cvTBXdpE5sMipcOiPhN2wsPMwhwYdWN
 mIUwGGRWti3T3Ono5Kgt5eRFFRRiBo3BPnnXAiVBpPLW1EDkpiO/KmegLywHYGQ2gnIf9YBJf
 cm5ts4IJDCykN2zrZXeVIOFqif7idBrWmG4psdlBY8J2HBECNgjRTWMID2RXfQ03IgDmekmJ3
 w9TzwPHtvUvqL4+p52xiV9Jqg7i3kskF5aTJt1tjicZU5VBZZYFkp+jmFiv++5i+Zymrd9y9A
 FuZFD/g4ELAUxVp+oW7Ip67gjytuLwgZN+mawd7x5FDiMfqw0iwUD4WpLSuYjOnkOJFwQAPoF
 Ey89kTudpiYdYHJOwCz9E4uEo4VVmLzQZGMuflyR8Qx5JJjptPpjJ3wvcI5qfgoWD5C12QSN5
 LiU445wfe2IT4ArTXNPeWhE0gWeVCIrSbVbyPSbreYkiOexEdciCWakldZSP2SL+3hQPtIHHP
 5RELln7dO6DiYXcV5qtj0dgVaiECcHUpx0fzPCoRLYZcwRM2SwRmHzi03rgXtmQU1xvtu2jEO
 7P5aKGcrhckoLzZlRW8SY2vAlWLTNduZ9frZkVQjsyI3iN+gf/HWnY6gNtQBFHPUWMQR1zP1n
 PNshBg4E6ECuA4iMEoiy9AdzR+qjEFdIC/M81aqy6b01TnE+SmXqNGdzwZiWafVIgaDGMDEVd
 GayUdLUc4puzN9Oq2qMRvHHKAer+mbN4t1ufIZYk49MCX3T+prKWFlfxM02YmCGx3wVawflU4
 AyS80cNZiwY+p6yeHHQrL97QsV5p/pdd+lRD9l1JiAvlynwmH5wtetEdYRyuaBuk9c7bsTMom
 GDNE6NsCPYY6a7DGf
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Phillip,

sorry to be _so_ late in the game. (And sorry for sending this to you
twice, I managed to skip all the Cc:s due to the Reply-To: header the
first time round.)

On Wed, 27 May 2020, Phillip Wood wrote:

> From: Rohit Ashiwal <rohit.ashiwal265@gmail.com>
>
> Rebase is implemented with two different backends - 'apply' and 'merge'
> each of which support a different set of options. In particuar the apply
> backend supports a number of options implemented by 'git am' that are
> not available to the merge backend. As part of an on going effort to

As a non-native speaker, I am thrown off when reading "available to"
instead of the grammatically correct (I believe) "available in". Likewise,
"on going" instead of "ongoing" just disrupts my workflow.

Maybe these can be fixed?

> remove the apply backend this patch adds support for the
> --ignore-whitespace option to the merge backend. This option treats
> lines with only whitespace changes as unchanged and is implemented in
> the merge backend by translating it to -Xignore-space-change.
>
> Signed-off-by: Rohit Ashiwal <rohit.ashiwal265@gmail.com>
> Signed-off-by: Phillip Wood <phillip.wood@dunelm.org.uk>
> ---
>  Documentation/git-rebase.txt           | 19 +++++-
>  builtin/rebase.c                       | 19 ++++--
>  t/t3422-rebase-incompatible-options.sh |  1 -
>  t/t3436-rebase-more-options.sh         | 86 ++++++++++++++++++++++++++
>  4 files changed, 118 insertions(+), 7 deletions(-)
>  create mode 100755 t/t3436-rebase-more-options.sh
>
> diff --git a/Documentation/git-rebase.txt b/Documentation/git-rebase.txt
> index f7a6033607..b003784f01 100644
> --- a/Documentation/git-rebase.txt
> +++ b/Documentation/git-rebase.txt
> @@ -422,8 +422,23 @@ your branch contains commits which were dropped, th=
is option can be used
>  with `--keep-base` in order to drop those commits from your branch.
>
>  --ignore-whitespace::
> +	Ignore whitespace differences when trying to reconcile
> +differences. Currently, each backend implements an approximation of
> +this behavior:
> ++
> +apply backend: When applying a patch, ignore changes in whitespace in
> +context lines. Unfortunately, this means that if the "old" lines being
> +replaced by the patch differ only in whitespace from the existing
> +file, you will get a merge conflict instead of a successful patch
> +application.
> ++
> +merge backend: Treat lines with only whitespace changes as unchanged
> +when merging. Unfortunately, this means that any patch hunks that were
> +intended to modify whitespace and nothing else will be dropped, even
> +if the other side had no changes that conflicted.
> +
>  --whitespace=3D<option>::
> -	These flags are passed to the 'git apply' program
> +	This flag is passed to the 'git apply' program
>  	(see linkgit:git-apply[1]) that applies the patch.
>  	Implies --apply.
>  +
> @@ -572,7 +587,6 @@ The following options:
>   * --apply
>   * --committer-date-is-author-date
>   * --ignore-date
> - * --ignore-whitespace
>   * --whitespace
>   * -C
>
> @@ -598,6 +612,7 @@ In addition, the following pairs of options are inco=
mpatible:
>   * --preserve-merges and --signoff
>   * --preserve-merges and --rebase-merges
>   * --preserve-merges and --empty=3D
> + * --preserve-merges and --ignore-whitespace
>   * --keep-base and --onto
>   * --keep-base and --root
>
> diff --git a/builtin/rebase.c b/builtin/rebase.c
> index 27a07d4e78..5d8e117276 100644
> --- a/builtin/rebase.c
> +++ b/builtin/rebase.c
> @@ -86,6 +86,7 @@ struct rebase_options {
>  	int signoff;
>  	int allow_rerere_autoupdate;
>  	int autosquash;
> +	int ignore_whitespace;
>  	char *gpg_sign_opt;
>  	int autostash;
>  	char *cmd;
> @@ -108,6 +109,7 @@ struct rebase_options {
>
>  static struct replay_opts get_replay_opts(const struct rebase_options *=
opts)
>  {
> +	struct strbuf strategy_buf =3D STRBUF_INIT;
>  	struct replay_opts replay =3D REPLAY_OPTS_INIT;
>
>  	replay.action =3D REPLAY_INTERACTIVE_REBASE;
> @@ -126,14 +128,20 @@ static struct replay_opts get_replay_opts(const st=
ruct rebase_options *opts)
>  	replay.reschedule_failed_exec =3D opts->reschedule_failed_exec;
>  	replay.gpg_sign =3D xstrdup_or_null(opts->gpg_sign_opt);
>  	replay.strategy =3D opts->strategy;
> +
>  	if (opts->strategy_opts)
> -		parse_strategy_opts(&replay, opts->strategy_opts);
> +		strbuf_addstr(&strategy_buf, opts->strategy_opts);
> +	if (opts->ignore_whitespace)
> +		strbuf_addstr(&strategy_buf, " --ignore-space-change");
> +	if (strategy_buf.len)
> +		parse_strategy_opts(&replay, strategy_buf.buf);

Quite honestly, this is very, very ugly.

I would have expected this at a way earlier layer, namely in
`cmd__rebase()`. Something along these lines:

=2D- snip --
diff --git a/builtin/rebase.c b/builtin/rebase.c
index 37ba76ac3d26..748e08aee2f2 100644
=2D-- a/builtin/rebase.c
+++ b/builtin/rebase.c
@@ -1289,6 +1289,7 @@ int cmd_rebase(int argc, const char **argv, const ch=
ar *prefix)
 	struct strbuf revisions =3D STRBUF_INIT;
 	struct strbuf buf =3D STRBUF_INIT;
 	struct object_id merge_base;
+	int ignore_whitespace =3D 0;
 	enum action action =3D ACTION_NONE;
 	const char *gpg_sign =3D NULL;
 	struct string_list exec =3D STRING_LIST_INIT_NODUP;
@@ -1318,9 +1319,8 @@ int cmd_rebase(int argc, const char **argv, const ch=
ar *prefix)
 			PARSE_OPT_NOARG, NULL, REBASE_DIFFSTAT },
 		OPT_BOOL(0, "signoff", &options.signoff,
 			 N_("add a Signed-off-by: line to each commit")),
-		OPT_PASSTHRU_ARGV(0, "ignore-whitespace", &options.git_am_opts,
-				  NULL, N_("passed to 'git am'"),
-				  PARSE_OPT_NOARG),
+		OPT_BOOL(0, "ignore-whitespace", &ignore_whitespace,
+			 N_("passed to 'git am'")),
 		OPT_PASSTHRU_ARGV(0, "committer-date-is-author-date",
 				  &options.git_am_opts, NULL,
 				  N_("passed to 'git am'"), PARSE_OPT_NOARG),
@@ -1682,6 +1682,15 @@ int cmd_rebase(int argc, const char **argv, const c=
har *prefix)
 		imply_merge(&options, "--rebase-merges");
 	}

+	if (ignore_whitespace) {
+		if (options.type =3D=3D REBASE_APPLY)
+			argv_array_push(&options.git_am_opts,
+					"--ignore-whitespace");
+		else
+			string_list_append(&stragey_options,
+					   "--ignore-space-change");
+	}
+
 	if (strategy_options.nr) {
 		int i;

=2D- snap --


>
>  	if (opts->squash_onto) {
>  		oidcpy(&replay.squash_onto, opts->squash_onto);
>  		replay.have_squash_onto =3D 1;
>  	}
>
> +	strbuf_release(&strategy_buf);
>  	return replay;
>  }
>
> @@ -539,6 +547,8 @@ int cmd_rebase__interactive(int argc, const char **a=
rgv, const char *prefix)
>  	argc =3D parse_options(argc, argv, prefix, options,
>  			builtin_rebase_interactive_usage, PARSE_OPT_KEEP_ARGV0);
>
> +	opts.strategy_opts =3D xstrdup_or_null(opts.strategy_opts);

I am not sure what this is about: `opts.strategy_opts` is of type `char
*`, i.e. it is supposed to be already allocated.

Not that `cmd_rebase__interactive()` matters _all_ that much anymore, of
course: it is only used by the --preserve-merges backend, which will
hopefully be retired soon.

> +
>  	if (!is_null_oid(&squash_onto))
>  		opts.squash_onto =3D &squash_onto;
>
> @@ -991,6 +1001,8 @@ static int run_am(struct rebase_options *opts)
>  	am.git_cmd =3D 1;
>  	argv_array_push(&am.args, "am");
>
> +	if (opts->ignore_whitespace)
> +		argv_array_push(&am.args, "--ignore-whitespace");
>  	if (opts->action && !strcmp("continue", opts->action)) {
>  		argv_array_push(&am.args, "--resolved");
>  		argv_array_pushf(&am.args, "--resolvemsg=3D%s", resolvemsg);
> @@ -1495,16 +1507,15 @@ int cmd_rebase(int argc, const char **argv, cons=
t char *prefix)
>  			PARSE_OPT_NOARG, NULL, REBASE_DIFFSTAT },
>  		OPT_BOOL(0, "signoff", &options.signoff,
>  			 N_("add a Signed-off-by: line to each commit")),
> -		OPT_PASSTHRU_ARGV(0, "ignore-whitespace", &options.git_am_opts,
> -				  NULL, N_("passed to 'git am'"),
> -				  PARSE_OPT_NOARG),
>  		OPT_PASSTHRU_ARGV(0, "committer-date-is-author-date",
>  				  &options.git_am_opts, NULL,
>  				  N_("passed to 'git am'"), PARSE_OPT_NOARG),
>  		OPT_PASSTHRU_ARGV(0, "ignore-date", &options.git_am_opts, NULL,
>  				  N_("passed to 'git am'"), PARSE_OPT_NOARG),
>  		OPT_PASSTHRU_ARGV('C', NULL, &options.git_am_opts, N_("n"),
>  				  N_("passed to 'git apply'"), 0),
> +		OPT_BOOL(0, "ignore-whitespace", &options.ignore_whitespace,
> +			 N_("ignore changes in whitespace")),
>  		OPT_PASSTHRU_ARGV(0, "whitespace", &options.git_am_opts,
>  				  N_("action"), N_("passed to 'git apply'"), 0),
>  		OPT_BIT('f', "force-rebase", &options.flags,
> diff --git a/t/t3422-rebase-incompatible-options.sh b/t/t3422-rebase-inc=
ompatible-options.sh
> index 50e7960702..55ca46786d 100755
> --- a/t/t3422-rebase-incompatible-options.sh
> +++ b/t/t3422-rebase-incompatible-options.sh
> @@ -61,7 +61,6 @@ test_rebase_am_only () {
>  }
>
>  test_rebase_am_only --whitespace=3Dfix
> -test_rebase_am_only --ignore-whitespace
>  test_rebase_am_only --committer-date-is-author-date
>  test_rebase_am_only -C4
>
> diff --git a/t/t3436-rebase-more-options.sh b/t/t3436-rebase-more-option=
s.sh
> new file mode 100755
> index 0000000000..fb5e747e86
> --- /dev/null
> +++ b/t/t3436-rebase-more-options.sh
> @@ -0,0 +1,86 @@
> +#!/bin/sh
> +#
> +# Copyright (c) 2019 Rohit Ashiwal
> +#
> +
> +test_description=3D'tests to ensure compatibility between am and intera=
ctive backends'
> +
> +. ./test-lib.sh
> +
> +. "$TEST_DIRECTORY"/lib-rebase.sh
> +
> +# This is a special case in which both am and interactive backends
> +# provide the same output. It was done intentionally because
> +# both the backends fall short of optimal behaviour.
> +test_expect_success 'setup' '
> +	git checkout -b topic &&
> +	q_to_tab >file <<-\EOF &&
> +	line 1
> +	Qline 2
> +	line 3
> +	EOF
> +	git add file &&
> +	git commit -m "add file" &&
> +	cat >file <<-\EOF &&
> +	line 1
> +	new line 2
> +	line 3
> +	EOF
> +	git commit -am "update file" &&
> +	git tag side &&
> +
> +	git checkout --orphan master &&
> +	sed -e "s/^|//" >file <<-\EOF &&
> +	|line 1
> +	|        line 2
> +	|line 3
> +	EOF
> +	git add file &&
> +	git commit -m "add file" &&
> +	git tag main
> +'

The file contents are repeated in an awfully repetitive manner. That not
only makes things a bit hard to read, it also makes it all too easy to
slip in bugs by mistake. How about something like this instead?

	test_commit file &&

	test_write_lines line1 Qline2 line3 >templ &&

	q_to_tab <templ >file.t &&
	git commit -m tab file.t &&

	sed "s/Q/new /" <templ >file.t &&
	git commit -m new file.t &&
	git tag side &&

	git checkout file -- &&
	sed "s/Q/        /" <templ >file.t &&
	git commit -m spaces file.t

... and then...

> +
> +test_expect_success '--ignore-whitespace works with apply backend' '
> +	cat >expect <<-\EOF &&
> +	line 1
> +	new line 2
> +	line 3
> +	EOF

	sed "s/Q/new /" <templ >expect

> +	test_must_fail git rebase --apply main side &&
> +	git rebase --abort &&
> +	git rebase --apply --ignore-whitespace main side &&
> +	test_cmp expect file

Personally, I prefer to read the contents of `expect` directly before the
`test_cmp expect file.t`

> +'
> +
> +test_expect_success '--ignore-whitespace works with merge backend' '
> +	cat >expect <<-\EOF &&
> +	line 1
> +	new line 2
> +	line 3
> +	EOF

Isn't this totally identical to the `expect` constructed earlier? And in
any case, isn't this identical to `git show main:file.t`, which is what we
_actually_ expect: for the file contents to be identical to the tagged
`main`? I.e.

	git diff --exit-code main

> +	test_must_fail git rebase --merge main side &&
> +	git rebase --abort &&
> +	git rebase --merge --ignore-whitespace main side &&
> +	test_cmp expect file
> +'
> +
> +test_expect_success '--ignore-whitespace is remembered when continuing'=
 '
> +	cat >expect <<-\EOF &&
> +	line 1
> +	new line 2
> +	line 3
> +	EOF
> +	(
> +		set_fake_editor &&
> +		FAKE_LINES=3D"break 1" git rebase -i --ignore-whitespace main side
> +	) &&
> +	git rebase --continue &&
> +	test_cmp expect file

It is a bit funny to see these two invocations _specifically_ pulled out
from the subshell, that's not how we do things in other test scripts:
instead, we run all the Git commands _inside_ the subshell, and all the
verifications after the subshell.

I believe that with my suggestions, this test script will be a ton easier
to read and to maintain. At least it will be a lot DRYer.

Ciao,
Dscho

> +'
> +
> +# This must be the last test in this file
> +test_expect_success '$EDITOR and friends are unchanged' '
> +	test_editor_unchanged
> +'
> +
> +test_done
> --
> 2.26.2
>
>
