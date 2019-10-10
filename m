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
	by dcvr.yhbt.net (Postfix) with ESMTP id EB6DA1F4C0
	for <e@80x24.org>; Thu, 10 Oct 2019 21:32:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727346AbfJJVcH (ORCPT <rfc822;e@80x24.org>);
        Thu, 10 Oct 2019 17:32:07 -0400
Received: from mout.gmx.net ([212.227.15.19]:58289 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725867AbfJJVcG (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 10 Oct 2019 17:32:06 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1570743117;
        bh=PuJRZLzdoQ/CV5Jmig1qQH8Q0/n08Knxv6r7vlqop7c=;
        h=X-UI-Sender-Class:Date:From:To:cc:Subject:In-Reply-To:References;
        b=j2ocPcr2r8WwSzgoJfFOAu/kJwMcsB9jxXFOKSvOOmFW21mZ4C4QQgsikCbwwSs94
         z52gWuwFsonwIO7EeUP4ZwndBz2ESwqf9iXFZl62OsxHKkr1daCbjcTNkxtyaNy869
         ex6hdjcUW/fokBPWSQygYa87yCW6IYUoUeujMLHk=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [192.168.0.213] ([37.201.195.166]) by mail.gmx.com (mrgmx005
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1Mqb1W-1hnj132pSi-00meha; Thu, 10
 Oct 2019 23:31:57 +0200
Date:   Thu, 10 Oct 2019 23:31:38 +0200 (CEST)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@gitforwindows.org
To:     Phillip Wood via GitGitGadget <gitgitgadget@gmail.com>
cc:     git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
        Phillip Wood <phillip.wood@dunelm.org.uk>
Subject: Re: [PATCH 3/3] sequencer: run post-commit hook
In-Reply-To: <acaa086a4860b6853bc0f35dae7fcf07d3aa59e7.1570732608.git.gitgitgadget@gmail.com>
Message-ID: <nycvar.QRO.7.76.6.1910102324140.46@tvgsbejvaqbjf.bet>
References: <pull.388.git.gitgitgadget@gmail.com> <acaa086a4860b6853bc0f35dae7fcf07d3aa59e7.1570732608.git.gitgitgadget@gmail.com>
User-Agent: Alpine 2.21.1 (DEB 209 2017-03-23)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K1:w24VrqbcaKvmucMPF5Et3ElEYjWD8ZUXE66Zs/2xZoEoQWI6x/Q
 AZb5NB5ID3nVC7U1n9m19G9rLvlXVw+zmQ5Amr7dXFQ0WQO96bZFGSflgbJwOEx2Apso2K1
 G5f3dO1IS02lf9Kd3aMHyZB2YnX3EGIlvnsM/cZG8MHql2YZSCEbbGMMU1lxxbApkIE0uVj
 XgmcEPEY492pH8Gb6aN5A==
X-UI-Out-Filterresults: notjunk:1;V03:K0:TshunYAe3mo=:SFsCwZJboVOtOXdTcld1Ch
 OXKFq4TxxOPOJrPwiK4gOEaZhgid0eWZOJ+QGMOp6VS8nMRGrsJv1JdmxznJNxzkrKXlgGxa5
 vDVljrlF9eDB9UzcpDzsEkIeCjBkzpF4eNU3D1u69OgEjZVaU/DK7mTc8c68UPMGFm1FXHtl+
 TuL46udB9gPJMPo9kMkaCG6jmJWErkDhHhxBxVzSCMYg+zqvXyOipDWd0z+LJKpG4FNRLGBxa
 /7nPkz7+psSPeEDq9p3SfAyebpGvjxaZGf+pNDQBD86KKQXnfkz4NLF9dLAcEUDulAycFO9fI
 hL4G9I66efxk0gdDVUI7+8JKAwbNMbNxl/OJ3IrSU785fdYqQxToPPBRX2WP7iVpqAw+j74Zx
 cYvvr8mpVe9frPaGjWXdqsNvNIB/NBIt06mlJWEtBWX7Ta7Lqpl4XOTlIqdgFaIMWYUkwxb1j
 9pb/J1l1u8KewB5fwmZhy62TUiMXEG1VdCf2yYRrwzhPcJBOpxZuLjC6+pC0IsmEXENRRGDtf
 BOcgzn72hYiayMbN3YohgA2SpGi0CX9ITNVBshKjL9JcFU/L0JtcNQpNe9qc2qGnCPHeXZd1+
 ChffbTFgrBP9//0tewfGkOndsulyldybZ4NLpdPChvASGpo0ATnZNPYjWNRa5dfegKorG4j+y
 adC35GfarcavXhWxO3zR1qt7dllg2axYjIOC+N9Rq0VRWec6UmFjrzAbwc+4ai5EOsfagOyLN
 gPRLbw6q+dD3/jJjAQX3OKYIvoDxICpz1wOP6BEaI9Tmx/OgfzGPDjNL03AHtq6Qyl20zSu8o
 DQGzi6tgpgPNdUFxLfToWBfwuY58QEaeoNzrPoYcn7WNsL1yCd2oVOyt3jB2/7+vabl4/TpoC
 G/C3U+inkgjTM+L9dfANpsIByP1/DznMSBBJkkiA4sKJVnZOHIdaARtm+pzJ1iuBHHf0zEwmQ
 jkzJn9zDVP5yYA5wX4US+GipfAT7Xo7B+yp5NuuVXBM+y2MTQLIxzjRSr/qEkZNa/yU8eYZk+
 aNYepG6jmcDe0sC169xHPAPMKLosM/L9WvkDmlVHT0BkYJalJ1kY8fxg4VEtpCdCOH8bycii6
 F04NbxRI/crCDV+E8bCFLgPvc4PvKoS8vDJ8gisJbfQ9dsLUap1MXs7ENhyiaTXiwZu5dtrNz
 T4kyON3bFT9OKQnt3xw7SUD2TZdLU27rmO31vwGVLDKXhX+06+/K2FWPPtx8HMhkMeQKZFGHg
 XSLrYgFE+W1F5FmHTNRpaQilPCNGV1yyVBqmi8Vagd0o55KF/s4tQOgRXkSk=
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Phillip,

On Thu, 10 Oct 2019, Phillip Wood via GitGitGadget wrote:

> From: Phillip Wood <phillip.wood@dunelm.org.uk>
>
> Prior to commit 356ee4659b ("sequencer: try to commit without forking
> 'git commit'", 2017-11-24) the sequencer would always run the
> post-commit hook after each pick or revert as it forked `git commit` to
> create the commit. The conversion to committing without forking `git
> commit` omitted to call the post-commit hook after creating the commit.
>
> Signed-off-by: Phillip Wood <phillip.wood@dunelm.org.uk>

Makes sense.

> ---
>  builtin/commit.c              |  2 +-
>  sequencer.c                   |  5 +++++
>  sequencer.h                   |  1 +
>  t/t3404-rebase-interactive.sh | 17 +++++++++++++++++
>  4 files changed, 24 insertions(+), 1 deletion(-)
>
> diff --git a/builtin/commit.c b/builtin/commit.c
> index d898a57f5d..adb8c89c60 100644
> --- a/builtin/commit.c
> +++ b/builtin/commit.c
> @@ -1653,7 +1653,7 @@ int cmd_commit(int argc, const char **argv, const =
char *prefix)
>
>  	repo_rerere(the_repository, 0);
>  	run_command_v_opt(argv_gc_auto, RUN_GIT_CMD);
> -	run_commit_hook(use_editor, get_index_file(), "post-commit", NULL);
> +	run_post_commit_hook(use_editor, get_index_file());

Does it really make sense to abstract the hook name away? It adds a lot
of churn for just two callers...

>  	if (amend && !no_post_rewrite) {
>  		commit_post_rewrite(the_repository, current_head, &oid);
>  	}
> diff --git a/sequencer.c b/sequencer.c
> index 3ce578c40b..b4947f6969 100644
> --- a/sequencer.c
> +++ b/sequencer.c
> @@ -1173,6 +1173,10 @@ static int run_prepare_commit_msg_hook(struct rep=
ository *r,
>  	return ret;
>  }
>
> +void run_post_commit_hook(int editor_is_used, const char *index_file) {
> +	run_commit_hook(editor_is_used, index_file, "post-commit", NULL);
> +}
> +

If we must have a separate `run_post_commit_hook()`, then it should be
an `inline` function, defined in the header. Or even a macro to begin
with.

>  static const char implicit_ident_advice_noconfig[] =3D
>  N_("Your name and email address were configured automatically based\n"
>  "on your username and hostname. Please check that they are accurate.\n"
> @@ -1427,6 +1431,7 @@ static int try_to_commit(struct repository *r,
>  		goto out;
>  	}
>
> +	run_post_commit_hook(0, r->index_file);

So this is the _actual_ change of this patch.

>  	if (flags & AMEND_MSG)
>  		commit_post_rewrite(r, current_head, oid);
>
> diff --git a/sequencer.h b/sequencer.h
> index b0419d6ddb..e3e73c5635 100644
> --- a/sequencer.h
> +++ b/sequencer.h
> @@ -203,4 +203,5 @@ int sequencer_get_last_command(struct repository* r,
>  			       enum replay_action *action);
>  LAST_ARG_MUST_BE_NULL
>  int run_commit_hook(int editor_is_used, const char *index_file, const c=
har *name, ...);
> +void run_post_commit_hook(int editor_is_used, const char *index_file);
>  #endif /* SEQUENCER_H */
> diff --git a/t/t3404-rebase-interactive.sh b/t/t3404-rebase-interactive.=
sh
> index d2f1d5bd23..d9217235b6 100755
> --- a/t/t3404-rebase-interactive.sh
> +++ b/t/t3404-rebase-interactive.sh
> @@ -1467,4 +1467,21 @@ test_expect_success 'valid author header when aut=
hor contains single quote' '
>  	test_cmp expected actual
>  '
>
> +test_expect_success 'post-commit hook is called' '
> +	test_when_finished "rm -f .git/hooks/post-commit commits" &&
> +	mkdir -p .git/hooks &&
> +	write_script .git/hooks/post-commit <<-\EOS &&
> +	git rev-parse HEAD >>commits

Should `commits` be initialized before this script is written, e.g.
using

	>commits &&

?

> +	EOS
> +	set_fake_editor &&

The `set_fake_editor` function sets a global environment variable, and
therefore needs to be run in a subshell. Therefore, this line (as well
as the next one) need to be enclosed in `( ... )`.

> +	FAKE_LINES=3D"edit 4 1 reword 2 fixup 3" git rebase -i A E &&
> +	echo x>file3 &&

We usually leave no space after the `>`, but we _do_ leave a space
_before_ the `>`.

> +	git add file3 &&
> +	FAKE_COMMIT_MESSAGE=3Dedited git rebase --continue &&
> +	# rev-list does not support -g --reverse
> +	git rev-list --no-walk=3Dunsorted HEAD@{5} HEAD@{4} HEAD@{3} HEAD@{2} =
\
> +		HEAD@{1} HEAD >expected &&

Wouldn't this be better as:

	git rev-parse HEAD@{5} HEAD@{4} HEAD@{3} HEAD@{2} HEAD@{1} HEAD \
		>expect &&

> +	test_cmp expected commits

We usually use the name `expect` instead of `expected` in the test
suite.

Thanks,
Dscho

> +'
> +
>  test_done
> --
> gitgitgadget
>
