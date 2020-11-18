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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 29D56C5519F
	for <git@archiver.kernel.org>; Wed, 18 Nov 2020 23:56:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8C01E246BC
	for <git@archiver.kernel.org>; Wed, 18 Nov 2020 23:56:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=gmx.net header.i=@gmx.net header.b="DzrjTaUS"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726510AbgKRX4e (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 18 Nov 2020 18:56:34 -0500
Received: from mout.gmx.net ([212.227.17.21]:33821 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726086AbgKRX4d (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 18 Nov 2020 18:56:33 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1605743782;
        bh=AQ9vsh3Mzh29I7KidmJEEgx1Ca+hJAORJF0cQ3s0spA=;
        h=X-UI-Sender-Class:Date:From:To:cc:Subject:In-Reply-To:References;
        b=DzrjTaUSDKcVz0+rMkuSQuXMsgIJ0CnfsFDIR+MnZE2qlGGGlBs0yIbeiN2QKwh16
         i5GKBvmLJ74GD8AKFPa6tc8AmNJFPlWfqRJ5ae0P49Wz18XLeS8wXW+9TDIkIdZjsS
         R9cyCHri1rzMay+QGSywpq6361z/c0kPGeZzMeV0=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [172.26.22.105] ([213.196.212.61]) by mail.gmx.com (mrgmx105
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1N0Fxf-1kIcqH0BF9-00xKMT; Thu, 19
 Nov 2020 00:56:22 +0100
Date:   Thu, 19 Nov 2020 00:56:20 +0100 (CET)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@gitforwindows.org
To:     =?UTF-8?Q?=C3=86var_Arnfj=C3=B6r=C3=B0_Bjarmason?= 
        <avarab@gmail.com>
cc:     git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
        Jeff King <peff@peff.net>,
        Felipe Contreras <felipe.contreras@gmail.com>
Subject: Re: [PATCH v2 28/27] tests: run tests omitted by
 PREPARE_FOR_MAIN_BRANCH
In-Reply-To: <20201118114834.11137-1-avarab@gmail.com>
Message-ID: <nycvar.QRO.7.76.6.2011190044100.56@tvgsbejvaqbjf.bet>
References: <pull.762.v2.git.1605629547.gitgitgadget@gmail.com> <20201118114834.11137-1-avarab@gmail.com>
User-Agent: Alpine 2.21.1 (DEB 209 2017-03-23)
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="8323328-1416743499-1605743783=:56"
X-Provags-ID: V03:K1:Q2QlfvJxkK7LS3OeDzleyK7P8vox5Cd5ZOYgSGgXek1NCHnLnLb
 RIRFAcKEm/tGlZEtt77Qrq67OYhMoEtvIrmsMb/fadUMJhxFnzvnxmivofdzg/8Ir49LAjQ
 xLK0pH5I6IgSmYQ7kp5qieURJ1ETOyPCvYt/Bh0fpMkylG7LB5dALiQkiz1HdTGDqWYGTsk
 Nrkoo6ZT0xIlvvY8F6kXw==
X-UI-Out-Filterresults: notjunk:1;V03:K0:AntySBg8ft8=:Hm4gSumlBfcVnoDS4cXmPu
 B12k0TZo7VQGllhYh6Sc3uoU1AIZ0E1tA83ZGaaR/QavNzZuhv13EgxWpekZ0nz27/N1ePe5t
 GD6t3m+qgW3SbT8YTVQ4RqgOCWDHOtf8CalF434NNiaOA5MG8ihJZke2mJoZDC0E/E/3yfJBQ
 Z9NVkDRTQPIO1DXeOpHOixLjOfNp16NrKhE0FEeGKa0q1/KaDdPfzB03PLpoM9Uki++1PAMs4
 FQxb3B9E8+rvGetXqV5lFsDe+EC4FikByP9XRnW8Mw0bt3FcvYq5sEVXtV4EjYhBkSwna9mlz
 G2K2ANbmNdURamOxKMqSMTRdAmKCoX/COjVVfikHbhg+skfuov4Nw7aEeFe6pCuuI1SgZrFiO
 qVXJR/8fQpRxqx5cHyML6FGhOXsJkbrYo6UssfJlodsGPo0pjDGVsOWr6k2I+0fjFlhYPQrhd
 VgPB0VhCGcArikhJHNzaT6u2bX8apACQO8ls7W4vuEQxQT/5lfQtkZVlRJ1C7rJrLKX0Tvzoy
 ygGryal/DvYDBa/lccRvZARpewLFmr7djursJd2F3Uq8onKSJp883amJ3Ct4RdZd31uvkq80T
 Fox8VU5rmYL5zIfcY0JMWlNJdGeSkSmsSHLXDC7kPQfRiHdjgoTcCY/SMM1uY04Ir68o80RsU
 SUVaDkuVJ//cajSDUS7MJjB93Uq11HFPX9nuwOUDPwtchU6+hW9npjZzn9rq1DHgoNBLi+cSj
 kwT1gyH0LCLqef9EDAGkE2cWW308u2+A4yakJL9YjfFrJdF8vLSiguIZqzwXy/e+dNkEFcWvC
 xAk7+pFFvJqAi+vsWZAFuusm86+sRsWfZpkm9Bwq5QAC+lKgHLyRO7tSg6Fvke0WJBdW1xi8p
 pwi8VBTGWeQhNufbfLRJvRsOtRiWengkTSxZqM+Lc=
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323328-1416743499-1605743783=:56
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Hi =C3=86var,

On Wed, 18 Nov 2020, =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason wrote:

> Reinstate the test coverage lost due to PREPARE_FOR_MAIN_BRANCH. The
> remaining impact of that prerequisite was mainly missing coverage from
> submodule fetches being lost[1], e.g. impacting my in-flight
> ab/retire-parse-remote. Now the prerequisite is effectively a
> noop. This goes on top of [2].
>
> I'm not removing the PREPARE_FOR_MAIN_BRANCH prerequisite to keep this
> change small, instead it's now effectively a noop. It can be removed
> in some later change.
>
> The only remaining occurrences in t5526-fetch-submodules.sh can be
> removed without breakage with:
>
>     perl -pi -e 's/PREPARE_FOR_MAIN_BRANCH //g' t/t5526-fetch-submodules=
.sh
>
> Which at this point leaves only the now-unused prerequisite
> declaration in test-lib.sh.
>
> The coverage in t9902-completion.sh was restored by partially
> reverting[3]. After that we were left with one test in a mixed
> state. It setup "master" but tested for "mai". Change it back to
> "mas", pending a more complete refactoring of that test.
>
> This change only conflicts between next..seen by clashing with Peter
> Kaestle's in-flights submodule fix[4]. Fixing the resulting logic
> error in t5526-fetch-submodules.sh is trivial, simply:
>
>     - compare_refs_in_dir A origin/master B origin/master
>     + compare_refs_in_dir A origin/main B origin/main
>
> 1. 66713e84e7 ("tests: prepare aligned mentions of the default branch na=
me", 2020-10-23)
> 2. https://public-inbox.org/git/pull.762.v2.git.1605629547.gitgitgadget@=
gmail.com/
> 3. 8164360fc8 ("t9902: prepare a test for the upcoming default branch na=
me", 2020-10-23)
> 4. https://public-inbox.org/git/1605196853-37359-1-git-send-email-peter.=
kaestle@nokia.com/
>
> Signed-off-by: =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason <avarab@gmail.com>
> ---

Hmm. I have the feeling that doing this will just delay everything even
further. I had really hoped that we could get this done without "three
steps forward, one step back" dances.

> On Tue, Nov 17 2020, Johannes Schindelin via GitGitGadget wrote:
> > To avoid even more conflicts with topics that did not even make it to =
seen
> > yet, this patch series specifically excludes t3404, t4013, t5310, t552=
6,
> > t6300, t7064, t7817, t9902: in those test scripts, we will still use m=
aster
> > for the time being. Once the topics in question have settled, I will s=
end
> > the appropriate follow-up patches to adjust them to use main instead.
>
> This is not a replacement for that subsequent cleanup, but seems like
> a simple enough thing to have now to reinstate the missing test
> coverage.
>
> Perhaps there's some topics not in "seen" that you have in mind as
> conflicting, but as noted above the conflict produced here with
> in-flight in "seen" is trivial.

The conflicts might be trivial, but every conflict makes it harder to
juggle branch thickets like Junio's `seen`. And those things add up.
They're no fun, and they make life hard and tedious.

t5526 conflicts _semantically_ with `pk/subsub-fetch-fix` (which touches
t5526 and adds a new test case referring to `master`).

t9902 conflicts with `fc/bash-completion-post-2.29`, and in contrast to
the t5526 issue (which is trivial, even if it does require manual fixing),
the t9902 is a bit more hairy to reason about.

So yes, I would love to have that test coverage back, but not by making
the transition to `main` even harder by reverting parts of it.

That's why I promised publicly to take care of the loose ends as quickly
as I can, after the conflicting issues graduate to `next` (or when they
become stalled or even dropped from `seen`).

Ciao,
Dscho

>
> Seems worth having that sooner than later if Junio's willing juggle
> that.
>
>  t/t5526-fetch-submodules.sh | 6 +++---
>  t/t9902-completion.sh       | 6 +++---
>  t/test-lib.sh               | 9 +++------
>  3 files changed, 9 insertions(+), 12 deletions(-)
>
> diff --git a/t/t5526-fetch-submodules.sh b/t/t5526-fetch-submodules.sh
> index dd8e423d25..f45ba02b8a 100755
> --- a/t/t5526-fetch-submodules.sh
> +++ b/t/t5526-fetch-submodules.sh
> @@ -481,7 +481,7 @@ test_expect_success PREPARE_FOR_MAIN_BRANCH "don't f=
etch submodule when newly re
>  	test_i18ncmp expect.err actual.err &&
>  	(
>  		cd submodule &&
> -		git checkout -q master
> +		git checkout -q main
>  	)
>  '
>
> @@ -663,9 +663,9 @@ test_expect_success 'fetch new submodule commits on-=
demand without .gitmodules e
>  	git config -f .gitmodules --remove-section submodule.sub1 &&
>  	git add .gitmodules &&
>  	git commit -m "delete gitmodules file" &&
> -	git checkout -B master &&
> +	git checkout -B main &&
>  	git -C downstream fetch &&
> -	git -C downstream checkout origin/master &&
> +	git -C downstream checkout origin/main &&
>
>  	C=3D$(git -C submodule commit-tree -m "yet another change outside refs=
/heads" HEAD^{tree}) &&
>  	git -C submodule update-ref refs/changes/7 $C &&
> diff --git a/t/t9902-completion.sh b/t/t9902-completion.sh
> index 5c01c75d40..3696b85acb 100755
> --- a/t/t9902-completion.sh
> +++ b/t/t9902-completion.sh
> @@ -1055,13 +1055,13 @@ test_expect_success 'teardown after filtering ma=
tching refs' '
>  	git -C otherrepo branch -D matching/branch-in-other
>  '
>
> -test_expect_success PREPARE_FOR_MAIN_BRANCH '__git_refs - for-each-ref =
format specifiers in prefix' '
> +test_expect_success '__git_refs - for-each-ref format specifiers in pre=
fix' '
>  	cat >expected <<-EOF &&
>  	evil-%%-%42-%(refname)..master
>  	EOF
>  	(
> -		cur=3D"evil-%%-%42-%(refname)..mai" &&
> -		__git_refs "" "" "evil-%%-%42-%(refname).." mai >"$actual"
> +		cur=3D"evil-%%-%42-%(refname)..mas" &&
> +		__git_refs "" "" "evil-%%-%42-%(refname).." mas >"$actual"
>  	) &&
>  	test_cmp expected "$actual"
>  '
> diff --git a/t/test-lib.sh b/t/test-lib.sh
> index d39bdf04ce..ed489b2213 100644
> --- a/t/test-lib.sh
> +++ b/t/test-lib.sh
> @@ -257,7 +257,7 @@ case "$TRASH_DIRECTORY" in
>  esac
>
>  case "$TEST_NUMBER" in
> -3404|4013|5310|5526|6300|7064|7817|9902)
> +3404|4013|5310|6300|7064|7817|9902)
>  	# Avoid conflicts with patch series that are cooking at the same time
>  	# as the patch series changing the default of `init.defaultBranch`.
>  	GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME=3Dmaster
> @@ -1725,12 +1725,9 @@ test_lazy_prereq REBASE_P '
>  	test -z "$GIT_TEST_SKIP_REBASE_P"
>  '
>
> -# Special-purpose prereq for transitioning to a new default branch name=
:
> -# Some tests need more than just a mindless (case-preserving) s/master/=
main/g
> -# replacement. The non-trivial adjustments are guarded behind this
> -# prerequisite, acting kind of as a feature flag
> +# Obsolete, do not use, removed soon!
>  test_lazy_prereq PREPARE_FOR_MAIN_BRANCH '
> -	test "$GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME" =3D main
> +	test "$TEST_NAME" =3D "t5526-fetch-submodules"
>  '
>
>  # Ensure that no test accidentally triggers a Git command
> --
> 2.29.2.222.g5d2a92d10f8
>
>
>

--8323328-1416743499-1605743783=:56--
