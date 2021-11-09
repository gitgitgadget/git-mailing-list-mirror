Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9CBECC433EF
	for <git@archiver.kernel.org>; Tue,  9 Nov 2021 16:10:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 80F6161211
	for <git@archiver.kernel.org>; Tue,  9 Nov 2021 16:10:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232742AbhKIQMt (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 9 Nov 2021 11:12:49 -0500
Received: from mout.gmx.net ([212.227.15.15]:55319 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231161AbhKIQMs (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 9 Nov 2021 11:12:48 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1636474190;
        bh=H3ulww6PUo9w18AGT1Nhi7eBjnHK0XAsmgHxAOP0HHE=;
        h=X-UI-Sender-Class:Date:From:To:cc:Subject:In-Reply-To:References;
        b=Mq0Y4oP0208EYsU1iLQQT/lkGyJEBbRqibrhVZftqEEfP7IgBC1hEy1Qt08yTCgsu
         jwJZHcjWvXKzyST7+f71w1gi94WCuCCVWUYEV/XnWg6MpqRswLCmPN8OFkkGz7JitD
         V0/od15UleszdMUfLKhrq43a8hNyc+NL/ZLP2TtU=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [172.22.201.164] ([89.1.212.10]) by mail.gmx.net (mrgmx005
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1MwwZd-1mUi862zvf-00yMmS; Tue, 09
 Nov 2021 17:09:49 +0100
Date:   Tue, 9 Nov 2021 17:09:47 +0100 (CET)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@gitforwindows.org
To:     Anders Kaseorg <andersk@mit.edu>
cc:     Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>,
        git@vger.kernel.org, Andreas Heiduk <andreas.heiduk@mathema.de>
Subject: Re: [PATCH v4 1/4] fetch: Protect branches checked out in all
 worktrees
In-Reply-To: <20211109030028.2196416-1-andersk@mit.edu>
Message-ID: <nycvar.QRO.7.76.6.2111091706290.54@tvgsbejvaqbjf.bet>
References: <a25d105a-875b-fa6a-771a-37936779f067@mit.edu> <20211109030028.2196416-1-andersk@mit.edu>
User-Agent: Alpine 2.21.1 (DEB 209 2017-03-23)
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="8323328-445063716-1636474189=:54"
X-Provags-ID: V03:K1:hyu/Uuoa2JEMDPB1Wpent+DYsUc4bcebYRLTqr2dPd0a7CP+nqt
 MhF9Zc5LHbukX6/ujpni21Fp74qZNArhvoMJDtwSC1DsMnlR9f0wjXBf3miZLLpaw0dZbiD
 Z1J2qf6dgas+lA8v/NM7dv7wBGa86LQ7HQiUD3IfLmnzNYWhAO5am4+7+47Zd68qXZTknvX
 LDQxkpeEc+LqoF9XGVzUQ==
X-UI-Out-Filterresults: notjunk:1;V03:K0:bkbX5W5/xSI=:XcP3d3ceC3sh/UgE5WbsAK
 8ewrXXMCaisphsi5MkDoTUb/83RZ2RKkzS9irYVEKw88a+aqOq7GeYLn4e97JSjKzxfdUmzQf
 j2sOBUqbBwYnvbqbiEIMf+j5SgIChEdsJVApeRPCo2QQnSXJbaWKElr3dLEpHAylqglTvVXGy
 sJUTkZq6AHhKTNuwnlxNCZHrThB6IJAybMJpla94e9PkCKFuZ2bPLAu/s1mSyYRgwaJ2Pg4Xm
 s4grH+h6LlH/FTDfKQsZgA6K1Q8IPC4eGNYhWBOSBTE5kV2QO+jQ6B60E+hDErGx/jv1FF1Cl
 1Y0YqbaEM1u6JDJ0Es2ESlgDsTEJAxjrxun0JkSAUJyvigMHbC0cr8lg1of8ENqj1k9k1Kjnh
 3zTiosWT6uVmIRpbSgx8scYd13QNV1MUKkxUWVVGPy2FiBdGmt1k7EVR5KeabXlXd2KcpFlsn
 h/eqXPZCSwb5Nkp91F79K0IuxVfZATqOiFZsqf0EhS890cYnywp8CMC4GipiooXcAU5r5fdan
 NJbQwlaGPcbFTO9xaflImnN2+Hyf7facSk50TE5FARh/3eyRTHznpUOXXEnhRBcj6lD125Ai4
 sqhJ30zKxggJbqtobQnQFr9oMZ0//i2Cuvx3q1rNbCzq5ERRttizCUbSOKeLTDalK/PMKAdx/
 OoA4DWma/dCL3arCeFkoh5U/p37qDnmAggoclz8v2JhRudg5IBFM83rUZserVQ0RToFRNftJ8
 rnOHquVGhgivM5LjVdAQ6L9VjOkIrnCp0XBFaF7IT3iNPrpt9DVIRRSXnuK5rVF9SaR9E4wDn
 BWyf5g2svasSbd5Uzzcuypes+VT3itOK+RgZtPgtVhRFwM7aMvGy7//9c1pFosCrln2B+fAOt
 Cvm3oNwB78Mmfy9scNSxu1r5IrXPDShKH843HZKS0uMu4ZvetR49Bfgo8803+kH0UAPQ26bZw
 QQHaD9Qd290nUxdL309jI8LPywxeX1gyGMMsxkXAnLEBD2TzNQcLvMHPhSmorwt8LFVFWmpwI
 E0xxtgwVCF8aO+v8lQWgxmiTS8s63wyApmYa0pDJE3g+H5TX01PajrKXYY4Lzld74wXPAYLok
 9uiwsXJUoypjtc=
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323328-445063716-1636474189=:54
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Hi Anders,

On Mon, 8 Nov 2021, Anders Kaseorg wrote:

> Refuse to fetch into the currently checked out branch of any working
> tree, not just the current one.
>
> Fixes this previously reported bug:
>
> https://public-inbox.org/git/cb957174-5e9a-5603-ea9e-ac9b58a2eaad@mathem=
a.de
>
> As a side effect of using find_shared_symref, we=E2=80=99ll also refuse =
the
> fetch when we=E2=80=99re on a detached HEAD because we=E2=80=99re rebasi=
ng or bisecting
> on the branch in question. This seems like a sensible change.
>
> Signed-off-by: Anders Kaseorg <andersk@mit.edu>
> ---
>  builtin/fetch.c       | 28 ++++++++++++++--------------
>  t/t5516-fetch-push.sh | 18 ++++++++++++++++++
>  2 files changed, 32 insertions(+), 14 deletions(-)
>
> diff --git a/builtin/fetch.c b/builtin/fetch.c
> index f7abbc31ff..0ef2170ef9 100644
> --- a/builtin/fetch.c
> +++ b/builtin/fetch.c
> @@ -28,6 +28,7 @@
>  #include "promisor-remote.h"
>  #include "commit-graph.h"
>  #include "shallow.h"
> +#include "worktree.h"
>
>  #define FORCED_UPDATES_DELAY_WARNING_IN_MS (10 * 1000)
>
> @@ -854,7 +855,7 @@ static int update_local_ref(struct ref *ref,
>  			    int summary_width)
>  {
>  	struct commit *current =3D NULL, *updated;
> -	struct branch *current_branch =3D branch_get(NULL);
> +	const struct worktree *wt;
>  	const char *pretty_ref =3D prettify_refname(ref->name);
>  	int fast_forward =3D 0;
>
> @@ -868,16 +869,18 @@ static int update_local_ref(struct ref *ref,
>  		return 0;
>  	}
>
> -	if (current_branch &&
> -	    !strcmp(ref->name, current_branch->name) &&
> -	    !(update_head_ok || is_bare_repository()) &&
> +	if (!update_head_ok &&
> +	    (wt =3D find_shared_symref("HEAD", ref->name)) &&
> +	    !wt->is_bare &&
>  	    !is_null_oid(&ref->old_oid)) {
>  		/*
>  		 * If this is the head, and it's not okay to update
>  		 * the head, and the old value of the head isn't empty...
>  		 */
>  		format_display(display, '!', _("[rejected]"),
> -			       _("can't fetch in current branch"),
> +			       wt->is_current ?
> +			       _("can't fetch in current branch") :
> +			       _("checked out in another worktree"),
>  			       remote, pretty_ref, summary_width);
>  		return 1;
>  	}
> @@ -1387,16 +1390,13 @@ static int prune_refs(struct refspec *rs, struct=
 ref *ref_map,
>
>  static void check_not_current_branch(struct ref *ref_map)
>  {
> -	struct branch *current_branch =3D branch_get(NULL);
> -
> -	if (is_bare_repository() || !current_branch)
> -		return;
> -
> +	const struct worktree *wt;
>  	for (; ref_map; ref_map =3D ref_map->next)
> -		if (ref_map->peer_ref && !strcmp(current_branch->refname,
> -					ref_map->peer_ref->name))
> -			die(_("Refusing to fetch into current branch %s "
> -			    "of non-bare repository"), current_branch->refname);
> +		if (ref_map->peer_ref &&
> +		    (wt =3D find_shared_symref("HEAD", ref_map->peer_ref->name)))

Do we need `&& !wt->is_bare` here, too?

> +			die(_("Refusing to fetch into branch '%s' "
> +			      "checked out at '%s'"),
> +			    ref_map->peer_ref->name, wt->path);
>  }
>
>  static int truncate_fetch_head(void)
> diff --git a/t/t5516-fetch-push.sh b/t/t5516-fetch-push.sh
> index 8212ca56dc..2c2d6fa6e7 100755
> --- a/t/t5516-fetch-push.sh
> +++ b/t/t5516-fetch-push.sh
> @@ -1771,4 +1771,22 @@ test_expect_success 'denyCurrentBranch and worktr=
ees' '
>  	git -C cloned push origin HEAD:new-wt &&
>  	test_must_fail git -C cloned push --delete origin new-wt
>  '
> +
> +test_expect_success 'refuse fetch to current branch of worktree' '
> +	test_when_finished "git worktree remove --force wt" &&

Do we also need `&& git branch -D wt` here?

> +	git worktree add wt &&
> +	test_commit apple &&
> +	test_must_fail git fetch . HEAD:wt &&
> +	git fetch -u . HEAD:wt

Maybe even `test_path_exists wt/apple.t`, to verify that the worktree has
been updated?

These would also apply to the next test case.

> +'
> +
> +test_expect_success 'refuse fetch to current branch of bare repository =
worktree' '
> +	test_when_finished "rm -fr bare.git" &&
> +	git clone --bare . bare.git &&
> +	git -C bare.git worktree add wt &&
> +	test_commit banana &&
> +	test_must_fail git -C bare.git fetch .. HEAD:wt &&
> +	git -C bare.git fetch -u .. HEAD:wt
> +'
> +
>  test_done

Thanks for working on this!
Dscho

--8323328-445063716-1636474189=:54--
