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
	by smtp.lore.kernel.org (Postfix) with ESMTP id A2337C2D0E4
	for <git@archiver.kernel.org>; Mon, 23 Nov 2020 20:47:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2EBC920721
	for <git@archiver.kernel.org>; Mon, 23 Nov 2020 20:47:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=gmx.net header.i=@gmx.net header.b="KE3V/RZ9"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728550AbgKWUr1 (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 23 Nov 2020 15:47:27 -0500
Received: from mout.gmx.net ([212.227.17.21]:32781 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727461AbgKWUr0 (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 23 Nov 2020 15:47:26 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1606164444;
        bh=lb5Z/ULU0tH2/JjTymxSwRPKMZZ0ltLP8+XxZGh72KQ=;
        h=X-UI-Sender-Class:Date:From:To:cc:Subject:In-Reply-To:References;
        b=KE3V/RZ9VfTDHJWAAhBwLlNiK0jLYko3Sq5Ek52+GvqC+an4dIKEnVMU+TweU5In5
         XuupJ0V2WwYpK7uALeW2QBzrPdry0Kakqyojzqh4eOQbmXGNtlIXj1ual7RA9BYUbE
         KVSL9rqSNxpCZg60zuSpKFwvBAcDE6fFWEoHcYpY=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [172.26.22.105] ([89.1.213.133]) by mail.gmx.com (mrgmx104
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1MYvY8-1klmqC0KH2-00UslM; Mon, 23
 Nov 2020 21:47:24 +0100
Date:   Mon, 23 Nov 2020 21:47:23 +0100 (CET)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@gitforwindows.org
To:     Philip Oakley <philipoakley@iee.email>
cc:     Johannes Schindelin via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org
Subject: Re: [PATCH 3/3] init: provide useful advice about
 init.defaultBranch
In-Reply-To: <b7df1e27-9ffc-5ca5-3c9a-77dbcff48d19@iee.email>
Message-ID: <nycvar.QRO.7.76.6.2011232146530.56@tvgsbejvaqbjf.bet>
References: <pull.921.git.git.1606087406.gitgitgadget@gmail.com> <253d6706e6ab97e71ec012f6de33c75f3e980701.1606087406.git.gitgitgadget@gmail.com> <b7df1e27-9ffc-5ca5-3c9a-77dbcff48d19@iee.email>
User-Agent: Alpine 2.21.1 (DEB 209 2017-03-23)
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="8323328-1383336044-1606164444=:56"
X-Provags-ID: V03:K1:wCxJ+FmkflA1oZZAQVVeuxWhKm2dRlZkVxJ7/bXfL71TLpFzLyG
 PZjUxtdnylfJly0JPuUzlPJQm/WXiicW/gTjNwQ6DeiVMFRIN4hYh2b6TnbWnhAnub9InYU
 vzCcJ6KdHgUuznFahJkM+pMdR8afSbJ73+vZuDcrW/PPcAOo1cS9JVB7hZCtZsgi32b2sG/
 +nDueP4KoyZ1l0f6TQWdQ==
X-UI-Out-Filterresults: notjunk:1;V03:K0:9G0gotu3jHE=:oaOUhTyv2GbCTg7g23xgwV
 PG+SnV1bRqXI/+S9UjR+WpcQU4gL5O38NZL8FDR+pZt/QJStwiu6h0wPNDVOS6nn3pvqueldv
 FB+BiHkMptG5tPoLCIRg85uO0OTFg3QAdU6tYm7MlvCtXgY4L61dU8nmLtucCEyk9W6MmKfiC
 EXwudrXiijE3JNUCl5oqM3MwMGJqeVKSQ1Q1dAsBu6oMba1czGlpP+AzvZn/R1JluIZjoBKmR
 3zHuMzPLvDHyzmA0iyU9JxUSDCR7/sX5AXhigX/CQF5Ch+F62pM8oi2sl0FwmfRMrZUqN7BaT
 N25QUwOtjwNE74+gDNVxqHJUlOjuKpoDKHfgRBGyqSRGD3T2uMQeTkYwtwWKY4XN4q3g+6jS9
 2DsQTGoKXYwA/HHLYeNLZUSW6rNoxIBc2Bud2D2z/w+hZfEjqEO25r/awiZu+oAqZNE+TTm2B
 HeJr4EPI8IbQ0GMy+mnMCx5/3tIYAD1v5y0xR/t2+WKdMbwaG/bXmb2yCaszRGUT1NrFFgtCq
 izwuBO6r4e2jDYBBz7GgLJHaVGIbkBzCzF5FdQ/qUfSDumHh5JkSNN4/knAa+c/gpHdVyhO9N
 0pjKHK1vmC1L69TDyEERacAhMO+grgB59g7neZGFBtQpy+SKiwwpAfJmQwyb/MxHgZBAnUSUL
 YDHsBz+bizUnImTHK9Zkya4kpUmoFS6X2+FW2zh9+Vqa9PYyHjzkWfu/b4TiWwCvoy7BKFW8k
 kAmLipbwlVvv2NPHaN68DeEvzBCltydThMAJ+sjpGkqMcdvuowsU7DmXDU2m/GC4aV9ggDdxT
 2FFzLTdjPL3OerJotUwcCukgQIeSfww3VZrLkSjclGUnh6jEwcIFtuj9jJ+0GuPXIo7tWs455
 yuRpcSlaZgNOE9zl5jpZST327MOKapd4Md1UGBhdc=
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323328-1383336044-1606164444=:56
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Hi Philip,

On Mon, 23 Nov 2020, Philip Oakley wrote:

> On 22/11/2020 23:23, Johannes Schindelin via GitGitGadget wrote:
> > From: Johannes Schindelin <johannes.schindelin@gmx.de>
> >
> > To give ample warning in case we decide to change the fall-back for an
> > unconfigured `init.defaultBranch`, let's introduce some advice that is
> > shown upon `git init` when that value is not set.
> >
> > Note: three test cases in Git's test suite want to verify that the
> > `stderr` output of `git init` is empty. With this patch, that is only
> > true if `init.defaultBranch` is configured, so let's do exactly that i=
n
> > those test cases. The same reasoning applies to `test_create_repo()`.
> >
> > Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
> > ---
> >  refs.c                        | 13 ++++++++++++-
> >  t/t0001-init.sh               |  9 ++++++++-
> >  t/t1510-repo-setup.sh         |  2 +-
> >  t/t7414-submodule-mistakes.sh |  2 +-
> >  t/test-lib-functions.sh       |  3 ++-
> >  5 files changed, 24 insertions(+), 5 deletions(-)
> >
> > diff --git a/refs.c b/refs.c
> > index 8df03122d6..61d712ca05 100644
> > --- a/refs.c
> > +++ b/refs.c
> > @@ -562,6 +562,14 @@ void expand_ref_prefix(struct strvec *prefixes, c=
onst char *prefix)
> >  		strvec_pushf(prefixes, *p, len, prefix);
> >  }
> >
> > +static const char default_branch_name_advice[] =3D N_(
> > +"Using '%s' as the name for the initial branch. This name is subject\=
n"
> > +"to change.
> This sounds like Git will change the branch name within the user's repo,
> rather than "The default" being subject to change.=C2=A0 So maybe
> s/This/The default/=C2=A0=C2=A0 ?

Yes, that sounds clearer to me. Thank you,
Dscho

>
> Philip
>
> > To configure the name to use as the initial branch name in\n"
> > +"new repositories, or to silence this warning, run:\n"
> > +"\n"
> > +"\tgit config --global init.defaultBranch <name>\n"
> > +);
> > +
> >  char *repo_default_branch_name(struct repository *r, int quiet)
> >  {
> >  	const char *config_key =3D "init.defaultbranch";
> > @@ -574,8 +582,11 @@ char *repo_default_branch_name(struct repository =
*r, int quiet)
> >  	else if (repo_config_get_string(r, config_key, &ret) < 0)
> >  		die(_("could not retrieve `%s`"), config_display_key);
> >
> > -	if (!ret)
> > +	if (!ret) {
> >  		ret =3D xstrdup("master");
> > +		if (!quiet)
> > +			advise(_(default_branch_name_advice), ret);
> > +	}
> >
> >  	full_ref =3D xstrfmt("refs/heads/%s", ret);
> >  	if (check_refname_format(full_ref, 0))
> > diff --git a/t/t0001-init.sh b/t/t0001-init.sh
> > index 69a320489f..754dab3bab 100755
> > --- a/t/t0001-init.sh
> > +++ b/t/t0001-init.sh
> > @@ -163,7 +163,7 @@ test_expect_success 'reinit' '
> >  	(
> >  		mkdir again &&
> >  		cd again &&
> > -		git init >out1 2>err1 &&
> > +		git -c init.defaultBranch=3Dinitial init >out1 2>err1 &&
> >  		git init >out2 2>err2
> >  	) &&
> >  	test_i18ngrep "Initialized empty" again/out1 &&
> > @@ -558,6 +558,13 @@ test_expect_success 'overridden default initial b=
ranch name (config)' '
> >  	grep nmb actual
> >  '
> >
> > +test_expect_success 'advice on unconfigured init.defaultBranch' '
> > +	GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME=3D git -c color.advice=3Dalways=
 \
> > +		init unconfigured-default-branch-name 2>err &&
> > +	test_decode_color <err >decoded &&
> > +	test_i18ngrep "<YELLOW>hint: " decoded
> > +'
> > +
> >  test_expect_success 'overridden default main branch name (env)' '
> >  	test_config_global init.defaultBranch nmb &&
> >  	GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME=3Denv git init main-branch-env =
&&
> > diff --git a/t/t1510-repo-setup.sh b/t/t1510-repo-setup.sh
> > index 9974457f56..5189a520a2 100755
> > --- a/t/t1510-repo-setup.sh
> > +++ b/t/t1510-repo-setup.sh
> > @@ -79,7 +79,7 @@ setup_repo () {
> >  	name=3D$1 worktreecfg=3D$2 gitfile=3D$3 barecfg=3D$4 &&
> >  	sane_unset GIT_DIR GIT_WORK_TREE &&
> >
> > -	git init "$name" &&
> > +	git -c init.defaultBranch=3Drepo init "$name" &&
> >  	maybe_config "$name/.git/config" core.worktree "$worktreecfg" &&
> >  	maybe_config "$name/.git/config" core.bare "$barecfg" &&
> >  	mkdir -p "$name/sub/sub" &&
> > diff --git a/t/t7414-submodule-mistakes.sh b/t/t7414-submodule-mistake=
s.sh
> > index f2e7df59cf..0ed02938f9 100755
> > --- a/t/t7414-submodule-mistakes.sh
> > +++ b/t/t7414-submodule-mistakes.sh
> > @@ -30,7 +30,7 @@ test_expect_success 'no warning when updating entry'=
 '
> >
> >  test_expect_success 'submodule add does not warn' '
> >  	test_when_finished "git rm -rf submodule .gitmodules" &&
> > -	git submodule add ./embed submodule 2>stderr &&
> > +	git -c init.defaultBranch=3Dx submodule add ./embed submodule 2>stde=
rr &&
> >  	test_i18ngrep ! warning stderr
> >  '
> >
> > diff --git a/t/test-lib-functions.sh b/t/test-lib-functions.sh
> > index 59bbf75e83..772152320a 100644
> > --- a/t/test-lib-functions.sh
> > +++ b/t/test-lib-functions.sh
> > @@ -1202,7 +1202,8 @@ test_create_repo () {
> >  	mkdir -p "$repo"
> >  	(
> >  		cd "$repo" || error "Cannot setup test environment"
> > -		"${GIT_TEST_INSTALLED:-$GIT_EXEC_PATH}/git$X" init \
> > +		"${GIT_TEST_INSTALLED:-$GIT_EXEC_PATH}/git$X" \
> > +			-c init.defaultBranch=3Dmaster init \
> >  			"--template=3D$GIT_BUILD_DIR/templates/blt/" >&3 2>&4 ||
> >  		error "cannot run git init -- have you built things yet?"
> >  		mv .git/hooks .git/hooks-disabled
>
>

--8323328-1383336044-1606164444=:56--
