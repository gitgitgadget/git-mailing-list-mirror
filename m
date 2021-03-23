Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MALFORMED_FREEMAIL,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 75BCDC433C1
	for <git@archiver.kernel.org>; Tue, 23 Mar 2021 20:53:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 501B6619CB
	for <git@archiver.kernel.org>; Tue, 23 Mar 2021 20:53:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233317AbhCWUwi (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 23 Mar 2021 16:52:38 -0400
Received: from mout.gmx.net ([212.227.15.18]:59823 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S233069AbhCWUw3 (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 23 Mar 2021 16:52:29 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1616532745;
        bh=WP4unXjuVQ09KYRYJA4xLtC1UVW4SuCLu9bAmRkpoZM=;
        h=X-UI-Sender-Class:Date:From:To:cc:Subject:In-Reply-To:References;
        b=H72VleSCrBRiz9jqwBnHLN2atIkyuxtaKemRtUNjBKlr/MstcbFQ1hwKwNuL8zyfr
         6rYxDRxfFWP3Rc7Y8Lrf8wSgNOD928vcFCyoHfFers6FUGKVHU/b12na8dvZ71MlrI
         TO04KB7em0gkoUOV5Mvmstg9XM5MhofvDeAipzu4=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [172.18.9.78] ([213.196.212.127]) by mail.gmx.net (mrgmx004
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1M3lc9-1lOX1u2QVf-000qZh; Tue, 23
 Mar 2021 21:52:25 +0100
Date:   Tue, 23 Mar 2021 21:52:22 +0100 (CET)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@gitforwindows.org
To:     =?UTF-8?Q?=C3=86var_Arnfj=C3=B6r=C3=B0_Bjarmason?= 
        <avarab@gmail.com>
cc:     git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
        Phillip Wood <phillip.wood123@gmail.com>
Subject: Re: [PATCH] rebase: remove transitory rebase.useBuiltin setting &
 env
In-Reply-To: <patch-1.1-df026b00b67-20210323T152302Z-avarab@gmail.com>
Message-ID: <nycvar.QRO.7.76.6.2103232152090.50@tvgsbejvaqbjf.bet>
References: <20190318110152.27246-1-avarab@gmail.com> <patch-1.1-df026b00b67-20210323T152302Z-avarab@gmail.com>
User-Agent: Alpine 2.21.1 (DEB 209 2017-03-23)
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="8323328-825626725-1616532744=:50"
X-Provags-ID: V03:K1:d53J2u82cro/8q/7b9UkKwja8WG1Ct37SStmA+Dnt1BJ44FaOnW
 BvSD0hDZ1Rlb4WfHrTqLi4cvG9Q2hV5X2m6jis6z+gLbzr0ZRq/bOMkrsmB5rwD87/qITod
 NllTuhYmUVW/WA5eFtXICxeduu7gF8Ft3B/+eDLE+PstOASZ0tDS82KKsumAB8zuEocC4hF
 yIqjrHGi26GZyCh3FOWKw==
X-UI-Out-Filterresults: notjunk:1;V03:K0:p7qIGhgiYcU=:g9CMotwR2WQ15gtIAwEi49
 iUP6zeG5azrA0u2wAKyDPjefYMiMdcO8w9dKYdd8vKJNAsLykPKMRB+1MgxNf/CRDvOjKLSTB
 v26hD/D3NtPa+ro14qyAr38nVrstWOlZxlOnYluVJ6cM8Go4qqMBTB3cg42qNKlsZkY7++hbH
 A3Rq0+Og/V1yxevwWn4vul1s/cKwxDfF9lVkCsRIv+T6wy4h6IvtAEJI0uycBX/I8+2c1Dpkt
 ZhnvPekbkfTncyXQn/f3bOVDZyp0d47hKFmGWua7g+E0oiY2/+S5lwzGqaKzRK1k7iL7jfE8N
 XTBLJbb6EvIDCunmB994mpEjdvvTHVyvgHhjeAdCbYfm2Aq2J51KlF5vjH5b0ryVg+Ek+tv/y
 nHOZ1v1bjtrivcFWNCfOpSKVPnitrvBXifeoqdH3uRUJBZHok6KG5JBxJHRdXBbG3gYp4NNCI
 3xUXTevVkizNJBabMjhw5NMGbcA87ZQD2FB+wyVq/SGD5TkiXrQpIeGZRCAZ1UM7CACPHBfjE
 HOyO2t/Hz6xQ9Mk+RquZEdiS12bYN5UHBsdvhjmjiSdujv6jxMGXEZM2CyZUKaWNmGZXBxf8Q
 pFQovdKdL5h59kDZejv3MK57/25TAElC4BpUOqDUIo/gIVCBj0uaid4p6o0PK489JvJoV4lcj
 sx26y12JJ5BLvx+lG0Hbvd44royDZX/b1W5y385kDeHHA83dT8T8BUtoS/OXPB5eq8+WnJvD0
 V4JOysm6Gg20Exby9u/hFc5VYuSqoU+bSHtJkehuE+YGm+pT/5k3PDkk6eTfuqPprddTH3zvP
 qLZRfBk3hMZCyNe5JOw0hxvajoLzndqVW55cA+BaHxlrhQOLj/GRkscX0VNY+UDj9Jbt7TE5g
 umzbM2R4Yp54AupDmuCOCmsrJmE8yI0Zjk/TDVtrRsMh3f+XqHF99lHwVdSd3l+rneumDnbIq
 m5h4dHUR92vDFOoDoBJQe96qSQb6bXKsXg+ZFdFW4NFuYvcj7t3BrLqjOhMIxpgzSFZ7vbRay
 h9+okXby8/fEtntDvaQKzOuIyMYGkOUkWdPOw84nd7f4QPvZAWTtY1r7q+M8XOg/I/bYDRBZH
 4t9PpiikTwN2+0bxllv1lCwogpVDJHA3tYS+GEFV8+hZbFzfLkioFeNGoThcS+LSM7OP/UyxE
 FTO0J3s/6y7fAeVmiEyNQtNhkDntj+CRALiazhiuY9FfVGaZTzyaXDKeYxQH6iNVBiLG6WhR+
 EgVfDGyPMqszQ1e51
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323328-825626725-1616532744=:50
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Hi =C3=86var,

On Tue, 23 Mar 2021, =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason wrote:

> Remove the rebase.useBuiltin setting and the now-obsolete
> GIT_TEST_REBASE_USE_BUILTIN test flag.
>
> This was left in place after my d03ebd411c6 (rebase: remove the
> rebase.useBuiltin setting, 2019-03-18) to help anyone who'd used the
> experimental flag and wanted to know that it was the default, or that
> they should transition their test environment to use the builtin
> rebase unconditionally.
>
> It's been more than long enough for those users to get a headsup about
> this. So remove all the scaffolding that was left inplace after
> d03ebd411c6. I'm also removing the documentation entry, if anyone
> still has this left in their configuration they can do some source
> archaeology to figure out what it used to do, which makes more sense
> than exposing every git user reading the documentation to this legacy
> configuration switch.
>
> Signed-off-by: =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason <avarab@gmail.com>

ACK!
Dscho

> ---
>  Documentation/config/rebase.txt |  7 -------
>  builtin/rebase.c                | 11 -----------
>  t/t3400-rebase.sh               | 16 ----------------
>  3 files changed, 34 deletions(-)
>
> diff --git a/Documentation/config/rebase.txt b/Documentation/config/reba=
se.txt
> index 214f31b451f..8c979cb20f2 100644
> --- a/Documentation/config/rebase.txt
> +++ b/Documentation/config/rebase.txt
> @@ -1,10 +1,3 @@
> -rebase.useBuiltin::
> -	Unused configuration variable. Used in Git versions 2.20 and
> -	2.21 as an escape hatch to enable the legacy shellscript
> -	implementation of rebase. Now the built-in rewrite of it in C
> -	is always used. Setting this will emit a warning, to alert any
> -	remaining users that setting this now does nothing.
> -
>  rebase.backend::
>  	Default backend to use for rebasing.  Possible choices are
>  	'apply' or 'merge'.  In the future, if the merge backend gains
> diff --git a/builtin/rebase.c b/builtin/rebase.c
> index de400f9a197..783b526f6e7 100644
> --- a/builtin/rebase.c
> +++ b/builtin/rebase.c
> @@ -100,7 +100,6 @@ struct rebase_options {
>  	char *strategy, *strategy_opts;
>  	struct strbuf git_format_patch_opt;
>  	int reschedule_failed_exec;
> -	int use_legacy_rebase;
>  	int reapply_cherry_picks;
>  	int fork_point;
>  };
> @@ -1102,11 +1101,6 @@ static int rebase_config(const char *var, const c=
har *value, void *data)
>  		return 0;
>  	}
>
> -	if (!strcmp(var, "rebase.usebuiltin")) {
> -		opts->use_legacy_rebase =3D !git_config_bool(var, value);
> -		return 0;
> -	}
> -
>  	if (!strcmp(var, "rebase.backend")) {
>  		return git_config_string(&opts->default_backend, var, value);
>  	}
> @@ -1441,11 +1435,6 @@ int cmd_rebase(int argc, const char **argv, const=
 char *prefix)
>  	gpg_sign =3D options.gpg_sign_opt ? "" : NULL;
>  	FREE_AND_NULL(options.gpg_sign_opt);
>
> -	if (options.use_legacy_rebase ||
> -	    !git_env_bool("GIT_TEST_REBASE_USE_BUILTIN", -1))
> -		warning(_("the rebase.useBuiltin support has been removed!\n"
> -			  "See its entry in 'git help config' for details."));
> -
>  	strbuf_reset(&buf);
>  	strbuf_addf(&buf, "%s/applying", apply_dir());
>  	if(file_exists(buf.buf))
> diff --git a/t/t3400-rebase.sh b/t/t3400-rebase.sh
> index 587b408063a..0bb88aa982b 100755
> --- a/t/t3400-rebase.sh
> +++ b/t/t3400-rebase.sh
> @@ -388,22 +388,6 @@ test_expect_success 'rebase--merge.sh and --show-cu=
rrent-patch' '
>  	)
>  '
>
> -test_expect_success 'rebase -c rebase.useBuiltin=3Dfalse warning' '
> -	expected=3D"rebase.useBuiltin support has been removed" &&
> -
> -	# Only warn when the legacy rebase is requested...
> -	test_must_fail git -c rebase.useBuiltin=3Dfalse rebase 2>err &&
> -	test_i18ngrep "$expected" err &&
> -	test_must_fail env GIT_TEST_REBASE_USE_BUILTIN=3Dfalse git rebase 2>er=
r &&
> -	test_i18ngrep "$expected" err &&
> -
> -	# ...not when we would have used the built-in anyway
> -	test_must_fail git -c rebase.useBuiltin=3Dtrue rebase 2>err &&
> -	test_must_be_empty err &&
> -	test_must_fail env GIT_TEST_REBASE_USE_BUILTIN=3Dtrue git rebase 2>err=
 &&
> -	test_must_be_empty err
> -'
> -
>  test_expect_success 'switch to branch checked out here' '
>  	git checkout main &&
>  	git rebase main main
> --
> 2.31.0.366.g75c23356abd
>
>

--8323328-825626725-1616532744=:50--
