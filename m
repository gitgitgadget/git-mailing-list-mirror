Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.2 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 070DCC64E7C
	for <git@archiver.kernel.org>; Mon, 23 Nov 2020 12:26:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A36E520888
	for <git@archiver.kernel.org>; Mon, 23 Nov 2020 12:26:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=gmx.net header.i=@gmx.net header.b="DnKzceAP"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730140AbgKWM0Y (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 23 Nov 2020 07:26:24 -0500
Received: from mout.gmx.net ([212.227.17.21]:55215 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730109AbgKWM0R (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 23 Nov 2020 07:26:17 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1606134370;
        bh=1ctkJq6y/4ymNkXbcZgGkdOUmI27EkhTG0PMdeIQp8g=;
        h=X-UI-Sender-Class:Date:From:To:cc:Subject:In-Reply-To:References;
        b=DnKzceAPJ9aaAyzcnOWgl5bKJTJvsfciNZX7MT0NKbBLYFfgZovpM44s97Vc9Ku2Z
         wQX0Adf1jeWtvGgTP3vwFuKNSELAq+aYXZwhwgZMeF8MvioGDiHci9zOJ6oDAawtww
         i4DES51OrhW49dTX/7EhD2ksklqbgxXZCVW6Rnjw=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [172.26.22.105] ([89.1.213.133]) by mail.gmx.com (mrgmx105
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1MybGX-1kJkOF2ZtF-00yytJ; Mon, 23
 Nov 2020 13:26:10 +0100
Date:   Mon, 23 Nov 2020 13:26:09 +0100 (CET)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@gitforwindows.org
To:     Junio C Hamano <gitster@pobox.com>
cc:     Johannes Schindelin via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org
Subject: Re: [PATCH 3/3] init: provide useful advice about
 init.defaultBranch
In-Reply-To: <xmqqft51osnu.fsf@gitster.c.googlers.com>
Message-ID: <nycvar.QRO.7.76.6.2011231308140.56@tvgsbejvaqbjf.bet>
References: <pull.921.git.git.1606087406.gitgitgadget@gmail.com> <253d6706e6ab97e71ec012f6de33c75f3e980701.1606087406.git.gitgitgadget@gmail.com> <xmqqft51osnu.fsf@gitster.c.googlers.com>
User-Agent: Alpine 2.21.1 (DEB 209 2017-03-23)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K1:KIp2A4Hy105sOtlPlzcHCrRTdg+GUPP/EjBdv7MDxgdTQJqnjPa
 Uc2Xz0N9wunxn0BP6kY9hmqBneE4EyQW1Au3EEGtCT97eDrT0pwNqhWQwOFpCAC14aPVJVh
 fhK8eHOW6HpQAUGjVhJWsWdQbZs/2nS+o4O53qE/13JFn2/LrV3XSafHbeV9k8Qg2HPDRMC
 ZGPVyD7exNR15pOrQlVuQ==
X-UI-Out-Filterresults: notjunk:1;V03:K0:3O8OycTUEtw=:qxEuD7mOT28C9NeidLcknt
 6LYZh/l6F9Y7/Sh5X2Esko4eKdHlu5JLxIBVyHm1jNCkLxFuR7ic1Hoo6SdfwX+vB1sKRfVDu
 c7N6OLJ8atb+LGEzjG0GyZJvuKZTTlGCLeDjhIWoRENPlSK/HCUrqVudtX4IkFfZolL4ayovH
 +SqX0PoMkyaKysxW9TRkjJh5L0xkZpSS8yYOtoXO2knCVpFpeqa3WUlZck9HXy5jWEX9332p5
 2F/3xqLlKtkTk8HPFky9pdAmBzc/G63VaL1qChFzqMdJMoPD69YLNGSDV0O5W3L2jNTjFwNyi
 ljM49SavKvaHymhQkFcKDwli75rrXSjDihwBJZilzeZ2/K3WBqQE3HhOgEpaEezuwV5IgDDKX
 vqgB1tx9citOBVrClBTlJVGp7MFxeF9zDO0m0VfCFFe2R8o2mFxQjKB/ID19zxwxcrPly1Kww
 olUflDFOjDl7bUeKPclFlG0oVh8Tf9FvohxvVmwxeIarabWwxtzIR2ZH23SCcf8fm4iRQaK4K
 xLSF+VMMuha2DZRxWGVHVrCMcvFpPLfG0C4mOvddlnXKmPZFFS7A3C8NNboBVmMSimDatxxIs
 WQWdKDcdJTClCbI36Vp3kZqmAzCoHuO+f0cD7lktWskt5ixvXUGHo9EfhdbEy/xhu+lJv+OUs
 /z93oNCNmOO0ZP9Au4NBfzW83XDainZHdhu6HbvwJ0QnaOd95v7VssFiXt70Z7uZlSZWp/i11
 9Elwj3YeYr5DPdLfca6Pt2uZ09tv3ug0sCvPMCiwC+b6HWcHRUqFGKlog++rzAjEyK9oEKXoo
 rNiPsSHbca11ibFyhI/mcw3s21Fs54bQGzkYU+ix0MbcgPxx4vP1TKLuqr5ieAGafCcEv+XS2
 lMU0JruTzLicMNg6K4OnMu7ZyPTyu3d3IEoF/Ic/I=
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Junio,

On Sun, 22 Nov 2020, Junio C Hamano wrote:

> "Johannes Schindelin via GitGitGadget" <gitgitgadget@gmail.com>
> writes:
>
> > From: Johannes Schindelin <johannes.schindelin@gmx.de>
> >
> > To give ample warning in case we decide to change the fall-back for an
> > unconfigured `init.defaultBranch`, let's introduce some advice that is
> > shown upon `git init` when that value is not set.
>
> I know this means well.
>
> I however doubt "ample warning" before we announce an actual
> decision makes user's life any easier in practice, though.

I reworded the commit message to make the rationale more obvious: the
ample warning is to give users a chance to override whatever is Git's
default branch name by configuring `init.defaultBranch`. If they care at
all.

> Until they know what it will be changed to (if we decide not to change
> anything, treat it as changing it to 'master'), they would not be able
> to decide if the name is more suitable for their use case.
>
> I further suspect that their choice will be influenced the most by
> the choice made by the projects they most often interact with, and
> not by our plan.
>
> > +static const char default_branch_name_advice[] =3D N_(
> > +"Using '%s' as the name for the initial branch. This name is subject\=
n"
> > +"to change. To configure the name to use as the initial branch name i=
n\n"
> > +"new repositories, or to silence this warning, run:\n"
>
> s/new repositories/all of your new repositories/ as that is the
> whole point of using --global option below.

Makes sense.

> > +"\n"
> > +"\tgit config --global init.defaultBranch <name>\n"
> > +);
> > +
>
> > +test_expect_success 'advice on unconfigured init.defaultBranch' '
> > +	GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME=3D git -c color.advice=3Dalways=
 \
> > +		init unconfigured-default-branch-name 2>err &&
> > +	test_decode_color <err >decoded &&
> > +	test_i18ngrep "<YELLOW>hint: " decoded
> > +'
> > +
>
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
>
> It is a bit subtle that this not only tests whatever "git submodule"
> test it originally wanted to do but also serves as a test that the
> new advice message is squelched by the presence of the configuration.

Thank you for catching this. It is a debugging left-over.

The real fix for the underlying issue is in the previous commit, which
silences the warning when `init_db()` is called via `clone`, as is the
case here.

I removed it from v2.

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
>
> I wonder if this should be more like
>
> 	-c init.defaultBranch=3D${GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME-master}
>
> so that tests that want a particular branch name would get what they
> want?

As is custom with our `GIT_TEST_*` variables,
`GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME` overrides `init.defaultBranch`.

Therefore, _technically_ what you suggested is not even necessary here.

> Eventually we would need to do the s/master/X/ if/when the actual
> default change happens.

However, _practically_, what you suggested is very helpful, as it will
make it easy to find when (if?) we finish the transition to a new
fall-back.

Thank you for your thorough feedback,
Dscho

> >  			"--template=3D$GIT_BUILD_DIR/templates/blt/" >&3 2>&4 ||
> >  		error "cannot run git init -- have you built things yet?"
> >  		mv .git/hooks .git/hooks-disabled
>
