Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 328C1C433EF
	for <git@archiver.kernel.org>; Sun, 23 Jan 2022 16:38:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238741AbiAWQis (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 23 Jan 2022 11:38:48 -0500
Received: from mout.gmx.net ([212.227.17.22]:35551 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S238729AbiAWQir (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 23 Jan 2022 11:38:47 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1642955918;
        bh=vay8cA75E3nG9y5/8upY6ykkD2sC2KskCualvC1SWow=;
        h=X-UI-Sender-Class:Date:From:To:cc:Subject:In-Reply-To:References;
        b=TjHzJ+gYLJrXahNaIegoebVmiteNvGSe6kGPpR+RrCvyO06U6FLms+NzA2IpA3J/m
         NTlnMolzTN2/GrY1779jS7mKy1+1d2dqrmVe5pXckaO9wakB73Fc+NJxEaEMQrE9Gq
         8aEwKB/ft5zmrLD+eVLS3TZ4ieo5UAVT7GWGhmao=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [172.28.174.184] ([89.1.213.181]) by mail.gmx.net (mrgmx105
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1Mkpap-1mQYZF0Btn-00mJz7; Sun, 23
 Jan 2022 17:38:38 +0100
Date:   Sun, 23 Jan 2022 17:38:34 +0100 (CET)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@gitforwindows.org
To:     Junio C Hamano <gitster@pobox.com>
cc:     =?UTF-8?Q?=C3=86var_Arnfj=C3=B6r=C3=B0_Bjarmason?= 
        <avarab@gmail.com>, git@vger.kernel.org,
        Todd Zullinger <tmz@pobox.com>,
        =?UTF-8?Q?Petr_=C5=A0pl=C3=ADchal?= <psplicha@redhat.com>
Subject: Re: [PATCH] checkout: avoid BUG() when hitting a broken repository
In-Reply-To: <xmqqbl04d1s9.fsf_-_@gitster.g>
Message-ID: <nycvar.QRO.7.76.6.2201231738050.2121@tvgsbejvaqbjf.bet>
References: <YemTGQZ97vAPUPY0@pobox.com>        <patch-1.1-21ddf7c628d-20220120T212233Z-avarab@gmail.com>        <xmqqlez8d2e6.fsf@gitster.g> <xmqqbl04d1s9.fsf_-_@gitster.g>
User-Agent: Alpine 2.21.1 (DEB 209 2017-03-23)
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="8323328-1150715683-1642955918=:2121"
X-Provags-ID: V03:K1:ihs7DjRAB2vlEyGqYzEmJNtub+/y+h5diQ1oznnjl3kWnybQynF
 puoMkF5MOXLHA0JOvtVy2FxxIJgNnAPK+IgNq9gM6Y/Hsne1C7KPx3W4uRGC56HySmw+mQU
 rkwgVSwZmLxsWdIFQXIiv6S0OADCfHSPaJ6aeSoZNCjp8dTaEw7UaBU1UdrRCuD1rmMAZuq
 Q3wvk9xsFF8/6JnAqnyXw==
X-UI-Out-Filterresults: notjunk:1;V03:K0:Co2ak8LMJJ8=:4CCb7XSir5VbzVs4sueAHU
 /UdVRxnhPbZpdRnA6SYU/Tpbr0/4KMP3fyN8ukL64vDc4cl4XuXi58OVXb/XmOdz3loc5keUO
 C/Vdr3Z/eqSd3h+5wYO5nSTlj6vSMS5CUJIZmN/ZtfIYOHVF6XGQ10jm+fbPJmZ31JssCatRo
 C5SNcUY+FYW1mSQrsDJonaSAJvmhzr+ZOdJqFVQHBVHdB+tTIuEpOEhzezmrDxxs20ge9Q6II
 kcN1GDmi43/pHNkpwY/NTO5exYmhRsGgnL2ZfcQQLBBCx1sQIQua55vwx6QD+f7btPg/Nbuma
 EubHrTOhh4CBpPxFk4l3DqkRz7GvTzTggYokJUi6PkZkPFwNrbMXra7EUSOZOSdTgHKnZL9Q4
 qLHiM71VHf+c5W8c88WDxYqoN/a2leIOdV2yYp+XUSUDHRnez5ddlgs6VNGAlv8e14Clp6oOu
 Eg2tvdWf8puH5Yv4bZeXzT1OvlvMnKaf59tjNXghTDdhXarishqZkfJMAsIZlcTJFRtxvwBav
 N79lViFxMprCX27NB97TlZBVNOuFNpTqUyXEFC1AD/CSHMXJ6aoBaE5ErUVgg4Qmqe8Q02nYa
 lLwir144iKQeWlmoGyojXfqjvaPRAB3heTiRZKQbfi1sfCU/DOz35W7gppAEiyafUIIYrlr9M
 AAwXFyEg0g/gcTPM9rFtyUdA+1u4zkzzg7ZXpRhJEtuAcU8Xlwd6RsaEVw2vgNJYkBsJM2EOW
 P3xkBiQYfYwyI3xv1uyjpHddJ/FAHgi4zn2ErJdn5HnZc4Jdq9UrwQ5ijmfJ6HGuzQrV1I/gi
 VExxofgalNYde3Z3Tj96OnCIMqMxS3zanaC3NfDPIfh2TrGKge1lwO6NgybUG5JwJSHCg2rYR
 kEFO4lkef9885okPlaVjQnl9jPrjY1gOYpt3cZAu3NS8CVsVrT4hnx/kjdzTTztgQFo7SLNvh
 V6PWkCPieYQDw+tcGAh8GasTbOcWe1fovPI9UOjLIrg+oj81+FsU5F+Sj94fUJPaqNq9vIVj5
 FZ7GmUhaY2WfqzNqE2AqmAYTwWp78vwwaTVG8CFItOXLRi5UfDdAViq9GBP6zAYLAF/4oC13D
 l2igr/oqyzH3qo=
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323328-1150715683-1642955918=:2121
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Hi Junio,

On Fri, 21 Jan 2022, Junio C Hamano wrote:

> So, taking the two earlier comments from me together...
>
> I _think_ I was the one who spotted the funny skip_prefix() whose
> result was not used, and suggested this unrelated check, during the
> review.  Sorry about that.
>
> ----- >8 --------- >8 --------- >8 --------- >8 --------- >8 -----
>
> Subject: [PATCH] checkout: avoid BUG() when hitting a broken repository
>
> When 9081a421 (checkout: fix "branch info" memory leaks, 2021-11-16)
> cleaned up existing memory leaks, we added an unrelated sanity check
> to ensure that a local branch is truly local and not a symref to
> elsewhere that dies with BUG() otherwise.  This was misguided in two
> ways.  First of all, such a tightening did not belong to a leak-fix
> patch.  And the condition it detected was *not* a bug in our program
> but a problem in user data, where warning() or die() would have been
> more appropriate.
>
> As the condition is not fatal (the result of computing the local
> branch name in the code that is involved in the faulty check is only
> used as a textual label for the commit), let's revert the code to
> the original state, i.e. strip "refs/heads/" to compute the local
> branch name if possible, and otherwise leave it NULL.  The consumer
> of the information in merge_working_tree() is prepared to see NULL
> in there and act accordingly.
>
> cf. https://bugzilla.redhat.com/show_bug.cgi?id=3D2042920

The commit message, as well as the patch, look good to me.

Thank you,
Dscho

> Reported-by: Petr =C5=A0pl=C3=ADchal <psplicha@redhat.com>
> Reported-by: Todd Zullinger <tmz@pobox.com>
> Helped-by: =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason <avarab@gmail.com>
> Signed-off-by: Junio C Hamano <gitster@pobox.com>
> ---
>  builtin/checkout.c         |  3 ---
>  t/t2018-checkout-branch.sh | 13 +++++++++++++
>  2 files changed, 13 insertions(+), 3 deletions(-)
>
> diff --git a/builtin/checkout.c b/builtin/checkout.c
> index 43d0275187..1fb34d537d 100644
> --- a/builtin/checkout.c
> +++ b/builtin/checkout.c
> @@ -1094,9 +1094,6 @@ static int switch_branches(const struct checkout_o=
pts *opts,
>  		const char *p;
>  		if (skip_prefix(old_branch_info.path, prefix, &p))
>  			old_branch_info.name =3D xstrdup(p);
> -		else
> -			BUG("should be able to skip past '%s' in '%s'!",
> -			    prefix, old_branch_info.path);
>  	}
>
>  	if (opts->new_orphan_branch && opts->orphan_from_empty_tree) {
> diff --git a/t/t2018-checkout-branch.sh b/t/t2018-checkout-branch.sh
> index 93be1c0eae..5dda5ad4cb 100755
> --- a/t/t2018-checkout-branch.sh
> +++ b/t/t2018-checkout-branch.sh
> @@ -85,6 +85,19 @@ test_expect_success 'setup' '
>  	git branch -m branch1
>  '
>
> +test_expect_success 'checkout a branch without refs/heads/* prefix' '
> +	git clone --no-tags . repo-odd-prefix &&
> +	(
> +		cd repo-odd-prefix &&
> +
> +		origin=3D$(git symbolic-ref refs/remotes/origin/HEAD) &&
> +		git symbolic-ref refs/heads/a-branch "$origin" &&
> +
> +		git checkout -f a-branch &&
> +		git checkout -f a-branch
> +	)
> +'
> +
>  test_expect_success 'checkout -b to a new branch, set to HEAD' '
>  	test_when_finished "
>  		git checkout branch1 &&
> --
> 2.35.0-rc2-150-gc312dde8e9
>
>

--8323328-1150715683-1642955918=:2121--
