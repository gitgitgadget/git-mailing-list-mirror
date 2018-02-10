Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.3 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 0EDF71F404
	for <e@80x24.org>; Sat, 10 Feb 2018 01:28:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751049AbeBJB2X (ORCPT <rfc822;e@80x24.org>);
        Fri, 9 Feb 2018 20:28:23 -0500
Received: from mail-wr0-f194.google.com ([209.85.128.194]:33730 "EHLO
        mail-wr0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751028AbeBJB2W (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 9 Feb 2018 20:28:22 -0500
Received: by mail-wr0-f194.google.com with SMTP id s5so9965518wra.0
        for <git@vger.kernel.org>; Fri, 09 Feb 2018 17:28:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=sdrOXRfuguAVOmlanFD9z9qor7CeJZYNAiyjv9UO4+I=;
        b=T2BICLlMfZ+jepF93E9Zd7rXDR8G0+hiNELmy0Ura8wouMcEg+PfgedxnviWEjurDE
         ffAKLeLRvkWNccbsqCfbANIUUr6RtK7sXX+GGm07QFqCUX1+K2jn/U3VhTBDRgPpbv1y
         HIXeu0PmamKuy5GlOorX6sjcAmq8NDet8M0cgapXmktw7gPu/+LaVStC2kuqJ8Jrh+rg
         B57N6SBiAOboFmOpLzRaJqfiaiuIA52MCg7Msx+THi4TUN3SLuKnrYDVf0Io7A6UlLgk
         Aam62Vehi/hRfCwRFXXytFMvc2OMcSasvTILThwtJ54spsNfa/SRdcepUy+p5EhB+JX1
         H5CQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=sdrOXRfuguAVOmlanFD9z9qor7CeJZYNAiyjv9UO4+I=;
        b=f466ECy80U7E3b7fst+levOegtyRxMm7PQ73Q7QwdvZdwHBxw2ByCsdkLi3SZIfFj8
         /zd5kQNzHkcjQegOcb2JcGDWNowDSbM4qAD1AOBZQoDPd+nciK6UgGUf1QMd5cRCptQI
         CxaFlh6Pn0pS88yVk1Qci7D52ZONepzqL8Qgp4QE2oEjOtQaGYzqBcoI6a2pjmr9gGnE
         yu9vngf5f2E2F942f90B4UlqXELyWa2FlG4Ixk6gl+Gydxg1uPjgp0bUuSlXinPcp0M5
         Cqc2YS463Cn9qz6amZQ3yUHt40iQ/wA3ho9W/MKQPIuZfT7W1FaUaW9X3OwCZ6HhMC3r
         M4DQ==
X-Gm-Message-State: APf1xPC/qqxnEOe/0bnthcw8Vkjt0i8bZVkMa1Qq75JFiKuZPOUifdC3
        KcCA5O4gGzP7FNA2bMrjCIU=
X-Google-Smtp-Source: AH8x227csKaPOuhsfSKtPyIt+6ptGqzJDDlXsuklRFDSWyiTGS6LpphRbj43fPAG4cHNKsL1Kn+uhw==
X-Received: by 10.223.182.169 with SMTP id j41mr4145784wre.203.1518226100943;
        Fri, 09 Feb 2018 17:28:20 -0800 (PST)
Received: from slxbook4.fritz.box (p5DDB474A.dip0.t-ipconnect.de. [93.219.71.74])
        by smtp.gmail.com with ESMTPSA id y90sm6529460wrc.24.2018.02.09.17.28.19
        (version=TLS1 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Fri, 09 Feb 2018 17:28:20 -0800 (PST)
Content-Type: text/plain; charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 9.3 \(3124\))
Subject: Re: [PATCH v1] worktree: set worktree environment in post-checkout hook
From:   Lars Schneider <larsxschneider@gmail.com>
In-Reply-To: <20180210010132.33629-1-lars.schneider@autodesk.com>
Date:   Sat, 10 Feb 2018 02:28:16 +0100
Cc:     git@vger.kernel.org, sunshine@sunshineco.com,
        matthew.k.gumbel@intel.com
Content-Transfer-Encoding: quoted-printable
Message-Id: <E0DC5330-F3D5-4945-A206-B583F83F0DFD@gmail.com>
References: <20180210010132.33629-1-lars.schneider@autodesk.com>
To:     lars.schneider@autodesk.com
X-Mailer: Apple Mail (2.3124)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


> On 10 Feb 2018, at 02:01, lars.schneider@autodesk.com wrote:
>=20
> From: Lars Schneider <larsxschneider@gmail.com>
>=20
> In ade546be47 (worktree: invoke post-checkout hook (unless
> --no-checkout), 2017-12-07) we taught Git to run the post-checkout =
hook
> in worktrees. Unfortunately, the environment of the hook was not made
> aware of the worktree. Consequently, a 'git rev-parse --show-toplevel'
> call in the post-checkout hook would return a wrong result.
>=20
> Fix this by setting the 'GIT_WORK_TREE' environment variable to make
> Git calls within the post-checkout hook aware of the worktree.
>=20
> Signed-off-by: Lars Schneider <larsxschneider@gmail.com>
> ---
>=20
> Hi,
>=20
> I think this is a bug in Git 2.16. We noticed it because it caused a
> problem in Git LFS [1]. The modified test case fails with Git 2.16 and
> succeeds with this patch.
>=20
> Cheers,
> Lars
>=20
>=20
> [1] https://github.com/git-lfs/git-lfs/issues/2848
>=20
>=20
> Notes:
>    Base Ref: v2.16.1
>    Web-Diff: https://github.com/larsxschneider/git/commit/214e9342e7
>    Checkout: git fetch https://github.com/larsxschneider/git =
fix-worktree-add-v1 && git checkout 214e9342e7
>=20
> builtin/worktree.c      |  7 +++++--
> t/t2025-worktree-add.sh | 11 +++++++++--
> 2 files changed, 14 insertions(+), 4 deletions(-)
>=20
> diff --git a/builtin/worktree.c b/builtin/worktree.c
> index 7cef5b120b..032f9b86bf 100644
> --- a/builtin/worktree.c
> +++ b/builtin/worktree.c
> @@ -345,9 +345,12 @@ static int add_worktree(const char *path, const =
char *refname,
> 	 * Hook failure does not warrant worktree deletion, so run hook =
after
> 	 * is_junk is cleared, but do return appropriate code when hook =
fails.
> 	 */
> -	if (!ret && opts->checkout)
> -		ret =3D run_hook_le(NULL, "post-checkout", =
oid_to_hex(&null_oid),
> +	if (!ret && opts->checkout) {
> +		struct argv_array env =3D ARGV_ARRAY_INIT;
> +		argv_array_pushf(&env, "GIT_WORK_TREE=3D%s", =
absolute_path(path));
> +		ret =3D run_hook_le(env.argv, "post-checkout", =
oid_to_hex(&null_oid),
> 				  oid_to_hex(&commit->object.oid), "1", =
NULL);

As I hit "send" I realized that I forgot to cleanup.
@Junio: Can you squash this in?

	argv_array_clear(&env);

Thanks,
Lars

> +	}
>=20
> 	argv_array_clear(&child_env);
> 	strbuf_release(&sb);
> diff --git a/t/t2025-worktree-add.sh b/t/t2025-worktree-add.sh
> index 2b95944973..d022ac0c26 100755
> --- a/t/t2025-worktree-add.sh
> +++ b/t/t2025-worktree-add.sh
> @@ -455,19 +455,26 @@ post_checkout_hook () {
> 	mkdir -p .git/hooks &&
> 	write_script .git/hooks/post-checkout <<-\EOF
> 	echo $* >hook.actual
> +	git rev-parse --show-toplevel >>hook.actual
> 	EOF
> }
>=20
> test_expect_success '"add" invokes post-checkout hook (branch)' '
> 	post_checkout_hook &&
> -	printf "%s %s 1\n" $_z40 $(git rev-parse HEAD) >hook.expect &&
> +	cat >hook.expect <<-EOF &&
> +		$_z40 $(git rev-parse HEAD) 1
> +		$(pwd)/gumby
> +	EOF
> 	git worktree add gumby &&
> 	test_cmp hook.expect hook.actual
> '
>=20
> test_expect_success '"add" invokes post-checkout hook (detached)' '
> 	post_checkout_hook &&
> -	printf "%s %s 1\n" $_z40 $(git rev-parse HEAD) >hook.expect &&
> +	cat >hook.expect <<-EOF &&
> +		$_z40 $(git rev-parse HEAD) 1
> +		$(pwd)/grumpy
> +	EOF
> 	git worktree add --detach grumpy &&
> 	test_cmp hook.expect hook.actual
> '
>=20
> base-commit: 8279ed033f703d4115bee620dccd32a9ec94d9aa
> --
> 2.16.1
>=20

