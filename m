Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MALFORMED_FREEMAIL,
	RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=no
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 9D1101F4C0
	for <e@80x24.org>; Mon, 21 Oct 2019 19:10:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729270AbfJUTKc (ORCPT <rfc822;e@80x24.org>);
        Mon, 21 Oct 2019 15:10:32 -0400
Received: from mout.gmx.net ([212.227.15.15]:52093 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727211AbfJUTKc (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 21 Oct 2019 15:10:32 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1571685025;
        bh=qywTkF2q6y0y1Sv0XEXUS+C34eogTg1pU7nVJUOKyb8=;
        h=X-UI-Sender-Class:Date:From:To:cc:Subject:In-Reply-To:References;
        b=dhxUkKFemyND141I2n2zUsqbR1xSxe0F0Ba/KLEgKdap6UFjPbOykWQi0NwVZhVl8
         bvjERzuoxPgd8K0IGyh48BH72HWZRCpKWxu5AhfXtUG0ltR3dGWt0rRcsyAlhZkYrn
         azMTL97X5Joijd3JV7ndCgAreIVWkL4POQKWuNOw=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [192.168.0.213] ([37.201.195.166]) by mail.gmx.com (mrgmx005
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1M26rD-1iKiKW1UN7-002ari; Mon, 21
 Oct 2019 21:10:25 +0200
Date:   Mon, 21 Oct 2019 21:10:09 +0200 (CEST)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@gitforwindows.org
To:     Denton Liu <liu.denton@gmail.com>
cc:     Git Mailing List <git@vger.kernel.org>,
        Alban Gruin <alban.gruin@gmail.com>,
        Junio C Hamano <gitster@pobox.com>
Subject: Re: [RFC PATCH 7/7] merge: teach --autostash option
In-Reply-To: <f43c10e4818c91a8c6e9d5e0ce2a04710db3e300.1571246693.git.liu.denton@gmail.com>
Message-ID: <nycvar.QRO.7.76.6.1910212103080.46@tvgsbejvaqbjf.bet>
References: <cover.1571246693.git.liu.denton@gmail.com> <f43c10e4818c91a8c6e9d5e0ce2a04710db3e300.1571246693.git.liu.denton@gmail.com>
User-Agent: Alpine 2.21.1 (DEB 209 2017-03-23)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K1:sZXwagaSGzJQAod6d2hTL+uWNfD3aiQzrQQ+AyRzqtrX/sIc8UT
 0Mns3yG555dLehaTK5CA5ovQZqIGnC6R2H+2FbvUXzFw0vgbacTldpxElQ9LElJKYyN4NvT
 GZO8erV4S1KIRpZRXj9U5Yl3inYZPtSj0knBBjQ0nbkIdz6hfFBiJBT3DZsooyOCQRrZwEP
 ijfYrqwoGLsLEFNAywO+g==
X-UI-Out-Filterresults: notjunk:1;V03:K0:LWbfP+1yvxI=:S6g7y8xRd2tiZTroWSm22z
 N5Ku/9i0d1jrwj6ptb3Ir1Hk7AeUNUjgzw7NZqFMC2eoznRAs375iI2c0m/1qcuJO/qNbZL5F
 2rV7N+azjaf86dvb+bEVAUgK2mJVuncrsQLq29h+T5sgxOEJD/4fu6bBcHSGAx/er+1jWI7QQ
 KH5N7j3Ykh9E+v1aWemJs/7+AG4Pcuv3vohqlDasYMWxsVlHNUghMskv9b9vkpWg+8RzAIbBd
 +pCIBQHw15V8bpxtPCQx0puPs2EmEaFWpZbukKeXhyOesdcAfaXI68FnnfoCgUU/TIRT7altn
 q+KRhIVY9YWzYLEeXaMrAunDkVNKRtIL1l/GLLNltn00OIi9IvFIlPwvkR1jUhtlVQ9j8tngW
 U0OsU+hURnVaJ4YZBqPyDoEgPNYLYkchZw79Q9MJ4sfyUTX1Px+HctULVRWsjaLG13JcWdRIa
 zts3ZUA+2O+2cAUP9gndIqVUrTk+wO0rxPDlFE3sD6YFlmOoCg51iuZpdmo5Bxs0TL4a9Qwl8
 vkd2MAX1vyQtSj51MuuEgqCmjubzgOaPCqRC6NRmFwYJ0SzlhHdtBB+IKJKN7K/3FNZ843j9v
 5Rz/XZMQWEwrk6/stDLLwDYX+OcwxgkM2wJzI8uE8eQm2X48kchTdi0yiSHHfgYEWRxIbGleO
 F43diDXkYd4wF0j7ozTJRsT8xbs/CBXee7obel4AuLpcljOzpEWgr+65zPGRed0H/m2JBEsLB
 rDQBElSXVrQ9ZVpKAe0wFbC8N6SYpUm06LIa6G339zrnKa0fgtFWEwU9Zq2akyYwkp/1zj106
 XxhRXEfpc/5ftTvhgHWsZ3GrLrJgWFJmXrzCYytBKDhYmYWS0UleMYdAdhyvn0dgTPqX+v18+
 jfSk9zLRL9Bht8YWBg3EZ4bIdxpjs62pQQqoAn+esbEFZO2GnHkSU/psryTnkAJsy8hJXLQBV
 UzRojXFOSc6XIOqvwQ+CMFFL2ZWEFRMIgqL/I6M6DSZkeYb6sERrkXDG7VyTLThu9Fg9W0rtv
 SYDnt1lq6Yb9ZWZc1g9dyIBj0te33w1Lgz+twK1b+/3s8n0iW2ERB4FRalRPC7prKpfuEVc3J
 LuoXqC3JF5kVqeVKtAKvrPpJlInDONQEvzdTN/HSSx4x281d73pD3lUKeTDaw9k1VEO38bTYB
 Eh01SKGLMB5ALDaqN3Ebx1fxXbuQ+dao1kHcZlT1aek32+zjf88iHFGX88scnVQeP7uC8LBCM
 g0IaXJROgdoyHOl9Y+rJ1L708YLpHQYPCKgfrSPHLs2DL89+i9znYoJpGaqM=
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Denton,

On Wed, 16 Oct 2019, Denton Liu wrote:

> In rebase, one can pass the `--autostash` option to cause the worktree
> to be automatically stashed before continuing with the rebase. This
> option is missing in merge, however.
>
> Implement the `--autostash` option and corresponding `merge.autoStash`
> option in merge which stashes before merging and then pops after.
>
> Reported-by: Alban Gruin <alban.gruin@gmail.com>

Maybe "Suggested-by" would be more accurate, it is not like this feature
request was a bug report...

> Signed-off-by: Denton Liu <liu.denton@gmail.com>
> ---
>  builtin/merge.c | 13 +++++++++++++
>  builtin/pull.c  |  9 +++++----
>  t/t5520-pull.sh |  8 --------
>  3 files changed, 18 insertions(+), 12 deletions(-)
>
> diff --git a/builtin/merge.c b/builtin/merge.c
> index 062e911441..d1a5eaad0d 100644
> --- a/builtin/merge.c
> +++ b/builtin/merge.c
> @@ -40,6 +40,7 @@
>  #include "branch.h"
>  #include "commit-reach.h"
>  #include "wt-status.h"
> +#include "autostash.h"
>
>  #define DEFAULT_TWOHEAD (1<<0)
>  #define DEFAULT_OCTOPUS (1<<1)
> @@ -58,6 +59,8 @@ static const char * const builtin_merge_usage[] =3D {
>  	NULL
>  };
>
> +static GIT_PATH_FUNC(merge_autostash, "MERGE_AUTOSTASH")
> +
>  static int show_diffstat =3D 1, shortlog_len =3D -1, squash;
>  static int option_commit =3D -1;
>  static int option_edit =3D -1;
> @@ -81,6 +84,7 @@ static int show_progress =3D -1;
>  static int default_to_upstream =3D 1;
>  static int signoff;
>  static const char *sign_commit;
> +static int autostash;
>  static int no_verify;
>
>  static struct strategy all_strategy[] =3D {
> @@ -285,6 +289,8 @@ static struct option builtin_merge_options[] =3D {
>  	OPT_SET_INT(0, "progress", &show_progress, N_("force progress reportin=
g"), 1),
>  	{ OPTION_STRING, 'S', "gpg-sign", &sign_commit, N_("key-id"),
>  	  N_("GPG sign commit"), PARSE_OPT_OPTARG, NULL, (intptr_t) "" },
> +	OPT_BOOL(0, "autostash", &autostash,
> +	      N_("automatically stash/stash pop before and after")),
>  	OPT_BOOL(0, "overwrite-ignore", &overwrite_ignore, N_("update ignored =
files (default)")),
>  	OPT_BOOL(0, "signoff", &signoff, N_("add Signed-off-by:")),
>  	OPT_BOOL(0, "no-verify", &no_verify, N_("bypass pre-merge-commit and c=
ommit-msg hooks")),
> @@ -440,6 +446,7 @@ static void finish(struct commit *head_commit,
>  		strbuf_addf(&reflog_message, "%s: %s",
>  			getenv("GIT_REFLOG_ACTION"), msg);
>  	}
> +	apply_autostash(merge_autostash());

Should this not be guarded by `if (autostash)`?

>  	if (squash) {
>  		squash_message(head_commit, remoteheads);
>  	} else {
> @@ -631,6 +638,9 @@ static int git_merge_config(const char *k, const cha=
r *v, void *cb)
>  	} else if (!strcmp(k, "commit.gpgsign")) {
>  		sign_commit =3D git_config_bool(k, v) ? "" : NULL;
>  		return 0;
> +	} else if (!strcmp(k, "merge.autostash")) {
> +		autostash =3D git_config_bool(k, v);
> +		return 0;
>  	}
>
>  	status =3D fmt_merge_msg_config(k, v, cb);
> @@ -724,6 +734,8 @@ static int try_merge_strategy(const char *strategy, =
struct commit_list *common,
>  		for (j =3D common; j; j =3D j->next)
>  			commit_list_insert(j->item, &reversed);
>
> +		if (autostash)
> +			perform_autostash(merge_autostash());
>  		hold_locked_index(&lock, LOCK_DIE_ON_ERROR);
>  		clean =3D merge_recursive(&o, head,
>  				remoteheads->item, reversed, &result);
> @@ -1288,6 +1300,7 @@ int cmd_merge(int argc, const char **argv, const c=
har *prefix)
>
>  		/* Invoke 'git reset --merge' */
>  		ret =3D cmd_reset(nargc, nargv, prefix);
> +		apply_autostash(merge_autostash());

Again, this should be guarded by `if (autostash)`, methinks.

>  		goto done;
>  	}
>
> diff --git a/builtin/pull.c b/builtin/pull.c
> index d25ff13a60..ee186781ae 100644
> --- a/builtin/pull.c
> +++ b/builtin/pull.c
> @@ -183,7 +183,7 @@ static struct option pull_options[] =3D {
>  		N_("verify that the named commit has a valid GPG signature"),
>  		PARSE_OPT_NOARG),
>  	OPT_BOOL(0, "autostash", &opt_autostash,
> -		N_("automatically stash/stash pop before and after rebase")),
> +		N_("automatically stash/stash pop before and after")),

Makes sense; this is now shared between the rebase and the merge modes.

>  	OPT_PASSTHRU_ARGV('s', "strategy", &opt_strategies, N_("strategy"),
>  		N_("merge strategy to use"),
>  		0),
> @@ -671,6 +671,10 @@ static int run_merge(void)
>  	argv_array_pushv(&args, opt_strategy_opts.argv);
>  	if (opt_gpg_sign)
>  		argv_array_push(&args, opt_gpg_sign);
> +	if (opt_autostash =3D=3D 0)
> +		argv_array_push(&args, "--no-autostash");
> +	else if (opt_autostash =3D=3D 1)
> +		argv_array_push(&args, "--autostash");

Or shorter:

	argv_array_pushf(&args, "%s-autostash", opt_autostash ? "-" : "--no");

Ah, but that would mishandle `-1`. I bet I will be puzzled by this
again. Maybe it would make sense to mention in a code comment that it
can be `-1` in which case we leave it to `rebase` to use the config
settings to determine whether or not to autostash.

>  	if (opt_allow_unrelated_histories > 0)
>  		argv_array_push(&args, "--allow-unrelated-histories");
>
> @@ -918,9 +922,6 @@ int cmd_pull(int argc, const char **argv, const char=
 *prefix)
>  	if (get_oid("HEAD", &orig_head))
>  		oidclr(&orig_head);
>
> -	if (!opt_rebase && opt_autostash !=3D -1)
> -		die(_("--[no-]autostash option is only valid with --rebase."));
> -
>  	autostash =3D config_autostash;
>  	if (opt_rebase) {
>  		if (opt_autostash !=3D -1)
> diff --git a/t/t5520-pull.sh b/t/t5520-pull.sh
> index cf4cc32fd0..75f162495a 100755
> --- a/t/t5520-pull.sh
> +++ b/t/t5520-pull.sh
> @@ -365,14 +365,6 @@ test_expect_success 'pull --rebase --no-autostash &=
 rebase.autostash unset' '
>  	test_pull_autostash_fail --rebase --no-autostash
>  '
>
> -for i in --autostash --no-autostash
> -do
> -	test_expect_success "pull $i (without --rebase) is illegal" '
> -		test_must_fail git pull $i . copy 2>err &&
> -		test_i18ngrep "only valid with --rebase" err
> -	'
> -done
> -

Nice!
Dscho

>  test_expect_success 'pull.rebase' '
>  	git reset --hard before-rebase &&
>  	test_config pull.rebase true &&
> --
> 2.23.0.897.g0a19638b1e
>
>
