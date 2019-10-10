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
	by dcvr.yhbt.net (Postfix) with ESMTP id EB3D11F4C0
	for <e@80x24.org>; Thu, 10 Oct 2019 21:16:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727231AbfJJVQT (ORCPT <rfc822;e@80x24.org>);
        Thu, 10 Oct 2019 17:16:19 -0400
Received: from mout.gmx.net ([212.227.17.22]:38167 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726804AbfJJVQS (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 10 Oct 2019 17:16:18 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1570742168;
        bh=cu7baZuiq67rrgcwM6eP1X/7/LIH/j0caXYzUvsQn3U=;
        h=X-UI-Sender-Class:Date:From:To:cc:Subject:In-Reply-To:References;
        b=SiBdq+dcm4G11snrcvn4T/WphRKrhy6dlDarZ7BahJRY5CiI9JYwj3AW68Mry41Km
         ZfUfTE+mIlP5u7YfVBrbsv+gFoZlf8ERuo8ElZ3N++WfyHDbngIWna5NY8T8Rq+P8z
         RE63nGQo+7Z6pCUynLSW3iH/CPAFXPDVBZKDszaI=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [192.168.0.213] ([37.201.195.166]) by mail.gmx.com (mrgmx104
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1MgvvJ-1hbKcP2X8v-00hOI3; Thu, 10
 Oct 2019 23:16:08 +0200
Date:   Thu, 10 Oct 2019 23:15:52 +0200 (CEST)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@gitforwindows.org
To:     Phillip Wood via GitGitGadget <gitgitgadget@gmail.com>
cc:     git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
        Phillip Wood <phillip.wood@dunelm.org.uk>
Subject: Re: [PATCH 2/3] sequencer: use run_commit_hook()
In-Reply-To: <420ecf442c729878da5219f3c718dd136e4fa2b4.1570732608.git.gitgitgadget@gmail.com>
Message-ID: <nycvar.QRO.7.76.6.1910102314390.46@tvgsbejvaqbjf.bet>
References: <pull.388.git.gitgitgadget@gmail.com> <420ecf442c729878da5219f3c718dd136e4fa2b4.1570732608.git.gitgitgadget@gmail.com>
User-Agent: Alpine 2.21.1 (DEB 209 2017-03-23)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K1:N+vocBaOPGrsR4jYvsa548npfh+hM7Q+H7kyU/AjWQoDM/lGzy2
 Y6gQlFfwJcR6rErOkJ/J4KjzvO5wgIW93F+gEQrcs2Vj9hF7cbQ21Cvs3pHhWrOoq1ybbRD
 xlwy/D9lYUkp/VyxtMoAzUkdd6h3YeFVJ79D3WR3jCl5wKt3JfLyeLNCxu80s5TErH0rbQw
 iwIPWrIFtqq40w0e1idbg==
X-UI-Out-Filterresults: notjunk:1;V03:K0:lr0/coYwsY0=:4MVYwFgMuIo/FqtcIH83Nc
 shPpkKcp+IpRXGHkQPZT8NREyscQcoYYz08gXzxig3qP8x7/BwEEYyqvS28NZ2S4lCR0JY+2u
 RFZPtwU8M6/Nhhk6qePtnuvyMRIFSRx/x+IZmOva/014AALAbFJ+EVxOIc2OE2mRN1Xocx5mK
 ujDcDU4QMergVagkFND61G2xJo3OB4/n6SajU/mX8uoIjoj+vl+oLVDbGPte/hFcYEc2ZXlNT
 W8mgDDiDfEQEoJY3JYfQvyQrCvj9VvDYgOcfrMQ6384i+qdrZCzM5/0HZHOnvUguX1Q8i1ZPF
 ZIVCyOYMUEowk+LLR39lg2VEii2APAZ2ssT7ZcYbzExf5iqNw397e74icULCA5G6M0przaLte
 VBklpgePCVREsvEiivqCCbyvE6+lsYh0QblnL9JIqzknOlTA/LoxM6ElPhckhbgAZSS/UuKzn
 /oZ9DsKnodZwG/Q2PKySYuR5GK3sVtW79zqSIj/KyqyEOxN+L3VxP/O9EkXMi44cGpKGm6GiD
 DUEGlnEKHXVj7BjtHIWVGoMamBNRqEnDQSlpASc1TmBBoxh7L2RtXLN/4rd44ibRf7gW65f5f
 nWzMWM0jZV5ZtxayUQoqN2C0vHWysqFnJQHyG2O69frjnJdoGRGcx/+gqSrGqkXrVFRySOMaJ
 ur1w/yIwHE+bY6KaOZ3k4Ae9FN4Y+hDsU9LB/rL9lRU23tU/l+a/YCdh0XxD+K6lMGxrf1m+B
 ITCxMV6CN4GgJjqDIysx5JXkgqCyvbzmQnJE3VHsrf4+wYg6S+K5dy+lyXoC+Pr0gMiGGyA7j
 o+hS6SbQCW6YwWSyLj/fV/XnLrfqSJtikmdJWXM4v+nsI0mBxadokaIYxWs5fFT4U1FNy8RKd
 gajGYe8QlC8DGF85olr2JtmP8pR9s8o9TBF5yGKsnsl/gtleNeHVvT6TXPNrWkfZpLB1IEwmt
 wosUyIHgZ9UupmNtXceJaFMwkcKWFszaI73BtQnXNz5LJqv/+EZH84JcgcG108bCfqOrAAVmT
 aPg9bvGfUEa7VBEGA4iJblryB7VKgkOlTgZ+GpS0p15Gcj7mwIMiMIIleo1cHedpJw7NgLCQj
 BkfebjQmdPA8oJkc4iA87yIEmXOBj51f6welpTqLiPTbpxhNl2NCYC6b7Og2NGn1zUZsHQK5P
 6Z+3CuahSxoRqIXIbpsVxlwO9F6mEVHAkMghXk2UffeVzMPS6TgCorNBEw1GIcGu2WJDP7yVG
 S3tY2NphDwrutMg/3dpJSnOWCJjdcEYSrwLVKm+IZoEzaPrBNZG3y1hvUovU=
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Phillip,

On Thu, 10 Oct 2019, Phillip Wood via GitGitGadget wrote:

> From: Phillip Wood <phillip.wood@dunelm.org.uk>
>
> This simplifies the implementation of run_prepare_commit_msg_hook() and
> will be used in the next commit.
>
> Signed-off-by: Phillip Wood <phillip.wood@dunelm.org.uk>
> ---
>  builtin/commit.c | 22 ----------------------
>  commit.h         |  3 ---
>  sequencer.c      | 45 ++++++++++++++++++++++++++++++++++-----------
>  sequencer.h      |  2 ++
>  4 files changed, 36 insertions(+), 36 deletions(-)

Hmm. I would have thought that `commit.c` would be a more logical home
for that function (and that the declaration could remain in `commit.h`)?

The general thrust is good, of course: `commit.h` is supposedly a
`libgit.a` header, but `builtin/commit.o` is _not_ included in
`libgit.a`...

Thanks,
Dscho

>
> diff --git a/builtin/commit.c b/builtin/commit.c
> index 1921401117..d898a57f5d 100644
> --- a/builtin/commit.c
> +++ b/builtin/commit.c
> @@ -1443,28 +1443,6 @@ static int git_commit_config(const char *k, const=
 char *v, void *cb)
>  	return git_status_config(k, v, s);
>  }
>
> -int run_commit_hook(int editor_is_used, const char *index_file, const c=
har *name, ...)
> -{
> -	struct argv_array hook_env =3D ARGV_ARRAY_INIT;
> -	va_list args;
> -	int ret;
> -
> -	argv_array_pushf(&hook_env, "GIT_INDEX_FILE=3D%s", index_file);
> -
> -	/*
> -	 * Let the hook know that no editor will be launched.
> -	 */
> -	if (!editor_is_used)
> -		argv_array_push(&hook_env, "GIT_EDITOR=3D:");
> -
> -	va_start(args, name);
> -	ret =3D run_hook_ve(hook_env.argv,name, args);
> -	va_end(args);
> -	argv_array_clear(&hook_env);
> -
> -	return ret;
> -}
> -
>  int cmd_commit(int argc, const char **argv, const char *prefix)
>  {
>  	const char *argv_gc_auto[] =3D {"gc", "--auto", NULL};
> diff --git a/commit.h b/commit.h
> index f5295ca7f3..37684a35f0 100644
> --- a/commit.h
> +++ b/commit.h
> @@ -389,7 +389,4 @@ void verify_merge_signature(struct commit *commit, i=
nt verbose);
>  int compare_commits_by_commit_date(const void *a_, const void *b_, void=
 *unused);
>  int compare_commits_by_gen_then_commit_date(const void *a_, const void =
*b_, void *unused);
>
> -LAST_ARG_MUST_BE_NULL
> -int run_commit_hook(int editor_is_used, const char *index_file, const c=
har *name, ...);
> -
>  #endif /* COMMIT_H */
> diff --git a/sequencer.c b/sequencer.c
> index 2adcf5a639..3ce578c40b 100644
> --- a/sequencer.c
> +++ b/sequencer.c
> @@ -1123,28 +1123,51 @@ void commit_post_rewrite(struct repository *r,
>  	run_rewrite_hook(&old_head->object.oid, new_head);
>  }
>
> +int run_commit_hook(int editor_is_used, const char *index_file,
> +		    const char *name, ...)
> +{
> +	struct argv_array hook_env =3D ARGV_ARRAY_INIT;
> +	va_list args;
> +	int ret;
> +
> +	argv_array_pushf(&hook_env, "GIT_INDEX_FILE=3D%s", index_file);
> +
> +	/*
> +	 * Let the hook know that no editor will be launched.
> +	 */
> +	if (!editor_is_used)
> +		argv_array_push(&hook_env, "GIT_EDITOR=3D:");
> +
> +	va_start(args, name);
> +	ret =3D run_hook_ve(hook_env.argv,name, args);
> +	va_end(args);
> +	argv_array_clear(&hook_env);
> +
> +	return ret;
> +}
> +
>  static int run_prepare_commit_msg_hook(struct repository *r,
>  				       struct strbuf *msg,
>  				       const char *commit)
>  {
>  	struct argv_array hook_env =3D ARGV_ARRAY_INIT;
> -	int ret;
> -	const char *name;
> +	int ret =3D 0;
> +	const char *name, *arg1 =3D NULL, *arg2 =3D NULL;
>
>  	name =3D git_path_commit_editmsg();
>  	if (write_message(msg->buf, msg->len, name, 0))
>  		return -1;
>
> -	argv_array_pushf(&hook_env, "GIT_INDEX_FILE=3D%s", r->index_file);
> -	argv_array_push(&hook_env, "GIT_EDITOR=3D:");
> -	if (commit)
> -		ret =3D run_hook_le(hook_env.argv, "prepare-commit-msg", name,
> -				  "commit", commit, NULL);
> -	else
> -		ret =3D run_hook_le(hook_env.argv, "prepare-commit-msg", name,
> -				  "message", NULL);
> -	if (ret)
> +	if (commit) {
> +		arg1 =3D "commit";
> +		arg2 =3D commit;
> +	} else {
> +		arg1 =3D "message";
> +	}
> +	if (run_commit_hook(0, r->index_file, "prepare-commit-msg", name,
> +			    arg1, arg2, NULL))
>  		ret =3D error(_("'prepare-commit-msg' hook failed"));
> +
>  	argv_array_clear(&hook_env);
>
>  	return ret;
> diff --git a/sequencer.h b/sequencer.h
> index ac66892d71..b0419d6ddb 100644
> --- a/sequencer.h
> +++ b/sequencer.h
> @@ -201,4 +201,6 @@ int write_basic_state(struct replay_opts *opts, cons=
t char *head_name,
>  void sequencer_post_commit_cleanup(struct repository *r);
>  int sequencer_get_last_command(struct repository* r,
>  			       enum replay_action *action);
> +LAST_ARG_MUST_BE_NULL
> +int run_commit_hook(int editor_is_used, const char *index_file, const c=
har *name, ...);
>  #endif /* SEQUENCER_H */
> --
> gitgitgadget
>
>
