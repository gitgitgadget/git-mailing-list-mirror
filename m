Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.6 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MALFORMED_FREEMAIL,
	RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=no
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id C7A0F1F4C0
	for <e@80x24.org>; Tue, 29 Oct 2019 07:30:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726108AbfJ2HaC (ORCPT <rfc822;e@80x24.org>);
        Tue, 29 Oct 2019 03:30:02 -0400
Received: from mout.gmx.net ([212.227.15.18]:33283 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726088AbfJ2HaB (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 29 Oct 2019 03:30:01 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1572334195;
        bh=Qug6UisRoUL5NyW9ixatMzaO/ijXpyvwPFqkNfQSJXU=;
        h=X-UI-Sender-Class:Date:From:To:cc:Subject:In-Reply-To:References;
        b=Max2anD93Ji1ien/OSaRvTMhcEsDtun/k/cIFycWcnSSLA1mVYyECjOBrgDpwGYEs
         mJvX/OYfrnaSTEZ5VznDZaTNXZKJTLuAH0C1olnXnGbtLwa/pllD2CqlEVN5IfwbpI
         Laqdix/eZzAbQAKcrhMLtqlHILxAC2eyZgdg51Kw=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [192.168.0.213] ([37.201.195.166]) by mail.gmx.com (mrgmx004
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1N5mKP-1hvhGq0s4h-017DU1; Tue, 29
 Oct 2019 08:29:55 +0100
Date:   Tue, 29 Oct 2019 08:29:39 +0100 (CET)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@gitforwindows.org
To:     Junio C Hamano <gitster@pobox.com>
cc:     dev@kipras.org,
        Paul-Sebastian Ungureanu <ungureanupaulsebastian@gmail.com>,
        git@vger.kernel.org
Subject: Re: [FR] Allow `git stash create` to include untracked changes
In-Reply-To: <xmqqa79lbpte.fsf@gitster-ct.c.googlers.com>
Message-ID: <nycvar.QRO.7.76.6.1910290806310.46@tvgsbejvaqbjf.bet>
References: <d02ddc0db596771820b0cfdfae5b1504@kipras.org> <xmqqa79lbpte.fsf@gitster-ct.c.googlers.com>
User-Agent: Alpine 2.21.1 (DEB 209 2017-03-23)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K1:FgiJoVjbyC4Bu92R8j9qLKWc0WLmEwQW8NEcL+q+o/94K1H/umP
 4Jyid7F+7hTSTvaFdRXbZzOJ3FZMSUDloGMPZFH5xrfEAUnisMjCclnYkbVcF08kFCltpRT
 BvTRpzw50DAU1J0VZW8pbBTv26xBZbSaT1RAM6kv9gA8vKjWB+qIHtE4/m1A1hY5dJkLOMu
 7d6KGvVPiBOmJ/ZlcRSXw==
X-UI-Out-Filterresults: notjunk:1;V03:K0:q+ohP3SOP4c=:xMka3raZnl29S9Ed9rHq6v
 f2dFjs7nxjgS67ZmNyWZcyrRXpAurvwZRF2gwj9pdUdRWgaiYfiQ861cwjAaxVBbgcT7LFdlD
 RDRvIJA1+xaTER/SoI2ieKY3FEtIKPkljsTQvZN75hv4LaR6zORv8hSZaNzcomprmC2YJEToA
 WUkTV96GU8KlaIdvmCbeIPrPf8EP5WU8oE5hGoxpCpz2mveBz2Bcr0vCS0V9WdMP0VJyDTQ+F
 dGCo515yErJXZPEF3NY7pMV5rzeAYHC3zBVgZ193QpcJusybZMOE9OABKV7z5LMzDun0LFDdS
 BWb3QD9rezMoex3LmgaXfQp27CGirVzGRA8Ysjd4tWbil69diZEPSkwAzT+94PXOvIA+z20iF
 QF5PacJMY5UUX9cxOnr7DelVoZZT2R3KI9RzLgmdJ+wjC9H5VePOVhp8zPn92uDdao+VNXfGl
 BFtxMU3msOUy8B2oChFfMKyeVKDYWW1+KEnBABV96xoljbMAdvjXRstgclClUqvuxf1PtyHka
 9+Hlp5VPoLGI30cahlsuw0+jVzwLtze/ha+TaeZpSIlHfE82OWYgtfSxK0UbeACpTaKg87ZHt
 9OFnB13hXghJomxHZPo5rqWbZ3J5i+An0uIb7qDIIMuPkUiCkRq6k5J8Y/IYhAvaFCl4c8Uip
 o6Qi+zOXoESO2MHElVLBY4uWAC3ECGKsDHEI4ohSfov2utcqMoWmCzPlTribMPpmHKi8k+9da
 o1C7TBDRMIFbCvQ9jCZfBB6pdN5SZ8v+3xjTU9kH+XC85Ng99GX5KJWmQ6jLLMlK1Dsdv6949
 23RLiHP46uSMebC/d6n96X1CopAhu2DaF86nB98e6huprmcfG4VaKVjhuKDpo3TiV7Hmmes2A
 WeWppySLsnHnUGdAc//iBU6KW4Hz/K3B2LzU0WilyEBG5Jit/+tx7N5Y0Hm5w9p/gwcJ8AkTN
 am0+l9eL72+cAWk0qTSH9uk1oiS0/0nMAFYMp/pDrogTmLNcTYqQvJTkQvlbWSNbMftO1X3My
 ga0E72ABCj/Jy0R7qkqheVH/9JHewpm/ynCWQ0Y9UOcusRqRmBjIK0L4XD/gspflQiX+X61zy
 qvXoMSa1GgyX6R/KwqKdtZGsZejD/LrKpLnR5pkTNomFt944oB/BskFQs9LxTOeTugEjHWtOj
 4iSbjaQNd/kS0+YiQGiLAKD4anAPvUVGH4QjK1B2xrdgWEwI05bzFwx5E1flKXczVZAYjh53O
 Jb91rBL5tflxFuUj0oyXuS6Q6Gk6iMP5TXxzSG+jcC4UrqvlWV9IL9qWe/PY=
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Junio,

On Mon, 28 Oct 2019, Junio C Hamano wrote:

> dev@kipras.org writes:
>
> > Would it be possible for `git stash create` to include untracked
> > changes (probably the same way `git stash push --include-untracked`
> > does)?
>
> Doesn't the subcommand have -u/--include-untracked option?
>
> ... goes and looks git-stash.sh ...
>
> create_stash () {

Careful, this is a false friend. It _is_ work horse of `git stash
create`, but not _quite_ in the way you think:

=2D- snap --
create)
	shift
	create_stash -m "$*" && echo "$w_commit"
	;;
=2D- snap --

So what is the reason for the existence of this command-line parsing:

>
> 	prepare_fallback_ident
>
> 	stash_msg=3D
> 	untracked=3D
> 	while test $# !=3D 0
> 	do
> 		case "$1" in
> 		-m|--message)
> 			...
> 			;;
> 		-u|--include-untracked)
> 			shift
> 			untracked=3D${1?"BUG: create_stash () -u requires an argument"}
> 			;;
> 		...
> 	done
> 	...

Why, `push_stash` calls `create_stash` ;-)

=2D- snip --
push_stash () {
	[...]
        untracked=3D
	[...]
                -u|--include-untracked)
			untracked=3Duntracked
			;;
	[...]
        create_stash -m "$stash_msg" -u "$untracked" -- "$@"
	[...]
=2D- snap --

So the reason that `git stash create -u ...` does not work is that it
never was designed to work ;-)

> It is entirely possible that with recent push to rewrite scripted
> Porcelain commands to builtin/, we may have lost a feature or two
> by accident.
>
>   ... goes and checks ...
>
> And it does appear that builtin/stash.c::create_stash() lacks
> support for command line arguments since d4788af8 ("stash: convert
> create to builtin", 2019-02-25).
>
> Would doing
>
> 	export GIT_TEST_STASH_USE_BUILTIN=3Dno
>
> or
>
> 	git config --global stash.usebuiltin no
>
> help in the meantime???

Well, given this code in `builtin/stash.c`, I would imagine that `git
stash push -u ...` works both in the legacy and the built-in version of
`git stash`:

=2D- snip --
static int push_stash(int argc, const char **argv, const char *prefix)
{
	int keep_index =3D -1;
	int patch_mode =3D 0;
	int include_untracked =3D 0;
	int quiet =3D 0;
	const char *stash_msg =3D NULL;
	struct pathspec ps;
	struct option options[] =3D {
		OPT_BOOL('k', "keep-index", &keep_index,
			 N_("keep index")),
		OPT_BOOL('p', "patch", &patch_mode,
			 N_("stash in patch mode")),
		OPT__QUIET(&quiet, N_("quiet mode")),
		OPT_BOOL('u', "include-untracked", &include_untracked,
			 N_("include untracked files in stash")),
		OPT_SET_INT('a', "all", &include_untracked,
			    N_("include ignore files"), 2),
		OPT_STRING('m', "message", &stash_msg, N_("message"),
			   N_("stash message")),
		OPT_END()
	};

	if (argc)
		argc =3D parse_options(argc, argv, prefix, options,
				     git_stash_push_usage,
				     0);

	parse_pathspec(&ps, 0, PATHSPEC_PREFER_FULL | PATHSPEC_PREFIX_ORIGIN,
		       prefix, argv);
	return do_push_stash(&ps, stash_msg, quiet, keep_index, patch_mode,
			     include_untracked);
}
=2D- snap --

So why does `git stash create -u ...` not work? Because the original
design of `git stash create` never intended to take any command-line
arguments other than the stash message. And that design can obviously
not be fixed without breaking backwards compatibility.

What we _could_ do is to add a new command-line option to `git stash
push` that would make it behave like the `create` subsubcommand: _not_
update the `refs/stash` ref but instead print the commit hash.

I am not quite sure how to call this option (`--ephemeral` came to my
mind, as the created commit is not reachable from anywhere and is hence
subject to garbage collection).

A completely different approach would be to allow overriding the ref to
store the stash in, with an empty value triggering the mode where the
ref is not updated but the commit hash would be printed instead. I am
thinking of something like `git stash -r '' push ...`, starting with
this patch:

=2D- snip --
diff --git a/builtin/stash.c b/builtin/stash.c
index bb4f6d8d762..43b0a155b1d 100644
=2D-- a/builtin/stash.c
+++ b/builtin/stash.c
@@ -1553,6 +1553,8 @@ int cmd_stash(int argc, const char **argv, const cha=
r *prefix)
 	struct argv_array args =3D ARGV_ARRAY_INIT;

 	struct option options[] =3D {
+		OPT_STRING('r', "ref", &ref_stash, N_("ref"),
+			   N_("override `refs/stash`")),
 		OPT_END()
 	};

=2D- snap --

The biggest trick will be to make all the code paths safe that assume
that `ref_stash` refers to a valid ref ;-)

Ciao,
Dscho
