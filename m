Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.3 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 921471F404
	for <e@80x24.org>; Fri, 16 Feb 2018 16:55:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1161532AbeBPQzL (ORCPT <rfc822;e@80x24.org>);
        Fri, 16 Feb 2018 11:55:11 -0500
Received: from mail-pg0-f52.google.com ([74.125.83.52]:38449 "EHLO
        mail-pg0-f52.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1755519AbeBPQzH (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 16 Feb 2018 11:55:07 -0500
Received: by mail-pg0-f52.google.com with SMTP id l24so2848168pgc.5
        for <git@vger.kernel.org>; Fri, 16 Feb 2018 08:55:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=vCr5py8J0w+VlBR51tIe3vs5CYvoNhReis7EIoZVsz8=;
        b=V3npDoyEgO/TahfMUWXf0BOuGfJ3r+cpDrrzNS1BKT0+FNpK1Ae5zT9PJL5v1bNDaN
         YbDcger5TEvDUo1RcXqGULG7H222O8U1XQRl+k5wJbkhfUDFgJf3tN3SJosJJDHSXDz9
         9gQyz4Zp7OMiFFsEN7vIi9B3fuKXr43l88Vfn3kSjwqidSeCgRwc5AbwQPHoOKPItK9a
         Uo9I2nekVQxNw2gyIA8hpqQ5WDBVeRglu4FQ5Qw4vcFor+g6dc8Bloeexcss5SoGvyZh
         4MtELOIVI3X4jyfPDqLrX714qwBxUDCen4XvmxUJJ0gC0btr7sS0eKJXxywodUXyBkzY
         +yOQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=vCr5py8J0w+VlBR51tIe3vs5CYvoNhReis7EIoZVsz8=;
        b=oa1ZckKG+xPz4dVXtP6YXkO+/2yw06RIdA3XBJlpW3Zky5Zny0kyUjaD1q++Zu5mjF
         6WQuuGob3k8iDEjunPax68NfVFKKI+21E+llqf8Z0Z7Olwt01WRhBmIzerqCQNS9U9Fa
         S3fwNgh4R8UnVRmRAsL4nGxn5m1ssH74Xc9wCe36H+voM6oBIP5agofVh2GjekCBdh2U
         DuNCAFXAAdIJRe/hfz9MUn1atTKpJe7/Xnz7cdlX5ziLcZ/kT4HBkm35UHKPDOCXwtMn
         SRo+xFvEnSby9Tzbz/1TWK8ACA5WNQpUafHZNdmFwI6gZ6MGJ3OM4vgEFopzZeJRQ3Hf
         YjWw==
X-Gm-Message-State: APf1xPBXzD8ZqMEVfuaLyWN9racFN/+w42VwL2uSTvt03cAPDgkH3fpF
        XT8mWZWHacfYIePnXOWwhTIn0a1y
X-Google-Smtp-Source: AH8x224TIWCYOowRIkZhrv/JtxkK2N8++Pe5ktGuAJSeQgO8dbuCXV3Y6pAHKwdM/EndOEPozT/Kog==
X-Received: by 10.98.54.197 with SMTP id d188mr2611681pfa.234.1518800106773;
        Fri, 16 Feb 2018 08:55:06 -0800 (PST)
Received: from slxbook4.ads.autodesk.com ([62.159.156.210])
        by smtp.gmail.com with ESMTPSA id u85sm21559438pfi.80.2018.02.16.08.55.04
        (version=TLS1 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Fri, 16 Feb 2018 08:55:06 -0800 (PST)
Content-Type: text/plain; charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 9.3 \(3124\))
Subject: Re: [PATCH v3] worktree: add: fix 'post-checkout' not knowing new worktree location
From:   Lars Schneider <larsxschneider@gmail.com>
In-Reply-To: <20180215230952.51887-1-sunshine@sunshineco.com>
Date:   Fri, 16 Feb 2018 17:55:02 +0100
Cc:     git <git@vger.kernel.org>, matthew.k.gumbel@intel.com,
        Junio C Hamano <gitster@pobox.com>
Content-Transfer-Encoding: quoted-printable
Message-Id: <E978DDBD-AD31-41EC-969B-E6AAC7D4FAF3@gmail.com>
References: <20180215191841.40848-1-sunshine@sunshineco.com> <20180215230952.51887-1-sunshine@sunshineco.com>
To:     Eric Sunshine <sunshine@sunshineco.com>
X-Mailer: Apple Mail (2.3124)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


> On 16 Feb 2018, at 00:09, Eric Sunshine <sunshine@sunshineco.com> =
wrote:
>=20
> Although "git worktree add" learned to run the 'post-checkout' hook in
> ade546be47 (worktree: invoke post-checkout hook, 2017-12-07), it
> neglected to change to the directory of the newly-created worktree
> before running the hook. Instead, the hook runs within the directory
> from which the "git worktree add" command itself was invoked, which
> effectively neuters the hook since it knows nothing about the new
> worktree directory.
>=20
> Further, ade546be47 failed to sanitize the environment before running
> the hook, which means that user-assigned values of GIT_DIR and
> GIT_WORK_TREE could mislead the hook about the location of the new
> worktree. In the case of "git worktree add" being run from a bare
> repository, the GIT_DIR=3D"." assigned by Git itself leaks into the =
hook's
> environment and breaks Git commands; this is so even when the working
> directory is correctly changed to the new worktree before the hook =
runs
> since ".", relative to the new worktree directory, does not point at =
the
> bare repository.
>=20
> Fix these problems by (1) changing to the new worktree's directory
> before running the hook, and (2) sanitizing the environment of GIT_DIR
> and GIT_WORK_TREE so hooks can't be confused by misleading values.
>=20
> Enhance the t2025 'post-checkout' tests to verify that the hook is
> indeed run within the correct directory and that Git commands invoked =
by
> the hook compute Git-dir and top-level worktree locations correctly.
>=20
> While at it, also add two new tests: (1) verify that the hook is run
> within the correct directory even when the new worktree is created =
from
> a sibling worktree (as opposed to the main worktree); (2) verify that
> the hook is provided with correct context when the new worktree is
> created from a bare repository (test provided by Lars Schneider).

Thanks! This patch works great and fixes the problem!
More comments below.


> Implementation Notes:
>=20
> Rather than sanitizing the environment of GIT_DIR and GIT_WORK_TREE, =
an
> alternative would be to set them explicitly, as is already done for
> other Git commands run internally by "git worktree add". This patch =
opts
> instead to sanitize the environment in order to clearly document that
> the worktree is fully functional by the time the hook is run, thus =
does
> not require special environmental overrides.
>=20
> The hook is run manually, rather than via run_hook_le(), since it =
needs
> to change the working directory to that of the worktree, and
> run_hook_le() does not provide such functionality. As this is a =
one-off
> case, adding 'run_hook' overloads which allow the directory to be set
> does not seem warranted at this time.

Although this is an one-off case, I would still prefer it if all hook=20
invocations would happen in a central place to avoid future surprises.


> Reported-by: Lars Schneider <larsxschneider@gmail.com>
> Signed-off-by: Eric Sunshine <sunshine@sunshineco.com>
> ---
>=20
> This is a re-roll of [1] which fixes "git worktree add" to provide
> proper context to the 'post-checkout' hook so that the hook knows the
> location of the newly-created worktree.
>=20
> Changes since v2:
>=20
> * Fix crash due to missing NULL-terminator on 'env' list passed to
>  run_command().
>=20
> [1]: =
https://public-inbox.org/git/20180215191841.40848-1-sunshine@sunshineco.co=
m/
>=20
> builtin/worktree.c      | 20 ++++++++++++---
> t/t2025-worktree-add.sh | 54 ++++++++++++++++++++++++++++++++++-------
> 2 files changed, 62 insertions(+), 12 deletions(-)
>=20
> diff --git a/builtin/worktree.c b/builtin/worktree.c
> index 7cef5b120b..f69f862947 100644
> --- a/builtin/worktree.c
> +++ b/builtin/worktree.c
> @@ -345,9 +345,23 @@ static int add_worktree(const char *path, const =
char *refname,
> 	 * Hook failure does not warrant worktree deletion, so run hook =
after
> 	 * is_junk is cleared, but do return appropriate code when hook =
fails.
> 	 */
> -	if (!ret && opts->checkout)
> -		ret =3D run_hook_le(NULL, "post-checkout", =
oid_to_hex(&null_oid),
> -				  oid_to_hex(&commit->object.oid), "1", =
NULL);
> +	if (!ret && opts->checkout) {
> +		const char *hook =3D find_hook("post-checkout");
> +		if (hook) {
> +			const char *env[] =3D { "GIT_DIR", =
"GIT_WORK_TREE", NULL };
> +			cp.git_cmd =3D 0;
> +			cp.no_stdin =3D 1;
> +			cp.stdout_to_stderr =3D 1;
> +			cp.dir =3D path;
> +			cp.env =3D env;
> +			cp.argv =3D NULL;
> +			argv_array_pushl(&cp.args, absolute_path(hook),
> +					 oid_to_hex(&null_oid),
> +					 =
oid_to_hex(&commit->object.oid),
> +					 "1", NULL);
> +			ret =3D run_command(&cp);
> +		}
> +	}
>=20
> 	argv_array_clear(&child_env);
> 	strbuf_release(&sb);
> diff --git a/t/t2025-worktree-add.sh b/t/t2025-worktree-add.sh
> index 2b95944973..d0d2e4f7ec 100755
> --- a/t/t2025-worktree-add.sh
> +++ b/t/t2025-worktree-add.sh
> @@ -451,32 +451,68 @@ test_expect_success 'git worktree =
--no-guess-remote option overrides config' '
> '
>=20
> post_checkout_hook () {
> -	test_when_finished "rm -f .git/hooks/post-checkout" &&
> -	mkdir -p .git/hooks &&
> -	write_script .git/hooks/post-checkout <<-\EOF
> -	echo $* >hook.actual
> +	gitdir=3D${1:-.git}
> +	test_when_finished "rm -f $gitdir/hooks/post-checkout" &&
> +	mkdir -p $gitdir/hooks &&
> +	write_script $gitdir/hooks/post-checkout <<-\EOF
> +	{
> +		echo $*
> +		git rev-parse --git-dir --show-toplevel

I also checked `pwd` here in my suggested test case.
I assume you think this check is not necessary?


> +	} >hook.actual
> 	EOF
> }
>=20
> test_expect_success '"add" invokes post-checkout hook (branch)' '
> 	post_checkout_hook &&
> -	printf "%s %s 1\n" $_z40 $(git rev-parse HEAD) >hook.expect &&
> +	{
> +		echo $_z40 $(git rev-parse HEAD) 1 &&
> +		echo $(pwd)/.git/worktrees/gumby &&
> +		echo $(pwd)/gumby
> +	} >hook.expect &&
> 	git worktree add gumby &&
> -	test_cmp hook.expect hook.actual
> +	test_cmp hook.expect gumby/hook.actual
> '
>=20
> test_expect_success '"add" invokes post-checkout hook (detached)' '
> 	post_checkout_hook &&
> -	printf "%s %s 1\n" $_z40 $(git rev-parse HEAD) >hook.expect &&
> +	{
> +		echo $_z40 $(git rev-parse HEAD) 1 &&
> +		echo $(pwd)/.git/worktrees/grumpy &&
> +		echo $(pwd)/grumpy
> +	} >hook.expect &&
> 	git worktree add --detach grumpy &&
> -	test_cmp hook.expect hook.actual
> +	test_cmp hook.expect grumpy/hook.actual
> '
>=20
> test_expect_success '"add --no-checkout" suppresses post-checkout =
hook' '
> 	post_checkout_hook &&
> 	rm -f hook.actual &&
> 	git worktree add --no-checkout gloopy &&
> -	test_path_is_missing hook.actual
> +	test_path_is_missing gloopy/hook.actual
> +'
> +
> +test_expect_success '"add" in other worktree invokes post-checkout =
hook' '
> +	post_checkout_hook &&
> +	{
> +		echo $_z40 $(git rev-parse HEAD) 1 &&
> +		echo $(pwd)/.git/worktrees/guppy &&
> +		echo $(pwd)/guppy
> +	} >hook.expect &&
> +	git -C gloopy worktree add --detach ../guppy &&
> +	test_cmp hook.expect guppy/hook.actual
> +'
> +
> +test_expect_success '"add" in bare repo invokes post-checkout hook' '
> +	rm -rf bare &&
> +	git clone --bare . bare &&
> +	{
> +		echo $_z40 $(git --git-dir=3Dbare rev-parse HEAD) 1 &&
> +		echo $(pwd)/bare/worktrees/goozy &&
> +		echo $(pwd)/goozy
> +	} >hook.expect &&
> +	post_checkout_hook bare &&
> +	git -C bare worktree add --detach ../goozy &&
> +	test_cmp hook.expect goozy/hook.actual
> '
>=20
> test_done
> --=20
> 2.16.1.370.g5c508858fb
>=20

