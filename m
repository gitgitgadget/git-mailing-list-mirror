Return-Path: <SRS0=BxWL=AF=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A8243C433E0
	for <git@archiver.kernel.org>; Wed, 24 Jun 2020 12:51:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8191B20663
	for <git@archiver.kernel.org>; Wed, 24 Jun 2020 12:51:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=gmx.net header.i=@gmx.net header.b="lqMZrvbd"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390911AbgFXMvY (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 24 Jun 2020 08:51:24 -0400
Received: from mout.gmx.net ([212.227.17.20]:38677 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2388942AbgFXMvX (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 24 Jun 2020 08:51:23 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1593003072;
        bh=Ykf1nFaFk9Xqxv1tXtz887qOhZbGKBOQ/nDn5JqeRKA=;
        h=X-UI-Sender-Class:Date:From:To:cc:Subject:In-Reply-To:References;
        b=lqMZrvbdkO5+J1LzugeovK9+z2hhOlTdJqiCxMUYTdt1kufbNa09P063+0Lttn1h1
         Hj8Yig7j4IT9ji9vZ6m/PyTnxq7tK7ivZ9/YkuV8WDt3BeX5DTwkmu9nJ5jy/4SY3a
         XH+b4ZHC2esz7mjm1wN5gZtmJC/DyQ/uA9o9k4WM=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [192.168.227.237] ([89.1.212.7]) by mail.gmx.com (mrgmx104
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1N3bX1-1inlOx3ERv-010bLM; Wed, 24
 Jun 2020 14:51:08 +0200
Date:   Wed, 24 Jun 2020 14:51:08 +0200 (CEST)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@gitforwindows.org
To:     Philippe Blain <levraiphilippeblain@gmail.com>
cc:     Johannes Schindelin via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org, don@goodman-wilson.com, stolee@gmail.com,
        peff@peff.net, sandals@crustytoothpaste.net,
        Matt Rogers <mattr94@gmail.com>,
        Eric Sunshine <sunshine@sunshineco.com>,
        Taylor Blau <me@ttaylorr.com>,
        Phillip Wood <phillip.wood123@gmail.com>,
        Alban Gruin <alban.gruin@gmail.com>,
        Johannes Sixt <j6t@kdbg.org>,
        Denton Liu <liu.denton@gmail.com>,
        =?UTF-8?Q?=C3=86var_Arnfj=C3=B6r=C3=B0_Bjarmason?= 
        <avarab@gmail.com>
Subject: Re: [PATCH v3 3/8] submodule: use a better fall-back for missing
 remote.<name>.branch
In-Reply-To: <D2ED942B-9397-472A-B017-190016531547@gmail.com>
Message-ID: <nycvar.QRO.7.76.6.2006241444280.54@tvgsbejvaqbjf.bet>
References: <pull.656.v2.git.1592225416.gitgitgadget@gmail.com> <pull.656.v3.git.1592951611.gitgitgadget@gmail.com> <6bda69541b12e93cfcf7b841b8691296dc82eeba.1592951611.git.gitgitgadget@gmail.com> <D2ED942B-9397-472A-B017-190016531547@gmail.com>
User-Agent: Alpine 2.21.1 (DEB 209 2017-03-23)
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="8323328-1232997827-1593003071=:54"
X-Provags-ID: V03:K1:sKKtgG5aSa45VAWpgftbXV5VBj2S4KFF4cjuTwdwuAOu/bxUXmo
 5e+fozr6O0dnsLYLUuV1xarUKl6/TYRW09wDCuHHsYNm2E8QZb+vYUi6qUYAstDla1ni7Ma
 AosBVKWRgcBD1B6U2lQhuZt/9BbEFcq8I7mUCDfQEVaRSo6KFMuim6w6A9bGG8N4hiVS4I4
 Nq9YCJpd2BhviHiX25HjQ==
X-UI-Out-Filterresults: notjunk:1;V03:K0:1GCoCA6hePI=:DLA9nSK57ndCP2IdtjEuIe
 dotKviR4Yhbb48Z+pOmC6drB+0DpI0J9l3s4T9PEzzeGyQj8h4+Rbqpsqm9ed7BlOiTq0/bS/
 xRN96FN4IfVdzVA+5LxURm1rjXZhi/FfmywJ4p+HEa1mOwXxt+5z6m5saksxNeuhCgsnh3IKW
 wa0m4RcucP33djC8HZ+JJbHqEtCGxANboFuE+B1fYVvB9vuuHJv879DrkjMQBJsvcnlodWjou
 4N04v6TUnucnnWXZYStdIdU8M/X341nDz6834RDEbO1TjMafZ74oGGSSM2s6WC2BgckZr1rOb
 SyGi8FKDfWvmYS+I6TuTfxBAECGOj1st+k/rY3JI2UlOJN2QJlQtZYTQY+bh/ozkhK1VhW+ai
 WSIUm8ju9qjJj/lIkjPmqV/4I8VKPUwLs7CuoieL+2Qcj7SksTk5tRBw1MwSG4Yo7tXNcSl8K
 JGd+TfaDxWQxOixEdROQDhNU+IkDv3uA4t+agZ6btzjnZSIb2SlZdx7Ft79ynvENPEh9JotB7
 zdY8I4fGipH0QICxSqMwkIYKlBdhBcVQD9W5mBoLT2Kn9wD6cmQcOR6lcE4EuqjM+j7YIjJBp
 /d/l1kgBBCHdCN1LCOpoEztFKtWC8yFeAd2YB0W0dzT26bsgz0D/n/GnvN5nRw6bEyjzBFojo
 tgm3VaBiZXhcO0Ws87RIVBeRvE0yc3RnvNgFrJg8dYWxh728inlQ68Gzgsl/T7CD+8J3sarDj
 0ew3v1Vq9qKSmtEEuc9O+QqwLjEKwCH2XeKyRz0nrCnU03BBU5i3OrFAEbC13EOVwQqmVyosx
 TlznUEF+BRk5gesDhuO8QYysc5r0KsDZb8DTpW0ZYnFh4y4pGou77gNLEX0xxe6ihuH1oIfpO
 vtZVWJK8pR+X6m7ss/PhTDExDjJgS4uIC8+9RrNgTjn12Vax6RRTVn1InDtYtLLH44o4CH+aN
 FwwhlsMWe5Ppdvot0H15MyzC34g8UmVZtn2AeVzy4+izlqE7xWljDtWop9q9kbVB58QoZCiAj
 KYr6ooIE2xePU1x8rrHeB6PuFpL3P96vTznsrPoxyoSqNGjzWGIOBgKpUoo/2KcbhkUT+RDtf
 bUDzp3EPaRg+UZNTc7E7j29OGYy9Xg5h7sRow3okj6zwdjnl109vhk3Mnu6DB7CIQgTmt4bid
 7SdhPZtiypGDkdNzGn1/FTgd2l2eA7y+US/r5I4hYmZGFtyRZscXjhS1p47pKrt+ZYcJMNDcu
 86Z77R6WUKtmUgDkAXfyBAN3ZGVOnkxX1vg80hQ==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323328-1232997827-1593003071=:54
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Hi Philippe,

On Tue, 23 Jun 2020, Philippe Blain wrote:

> > Le 23 juin 2020 =C3=A0 18:33, Johannes Schindelin via GitGitGadget <gi=
tgitgadget@gmail.com> a =C3=A9crit :
> >
> > From: Johannes Schindelin <johannes.schindelin@gmx.de>
> >
> > When `remote.<name>.branch` is not configured, `git submodule update`
> > currently falls back to using the branch name `master`. A much better
> > idea, however, is to use `HEAD`: on all Git servers running reasonably
> > recent Git versions, the symref `HEAD` points to the main branch.
>
> To be pedantic, it is up to the maintainer/developers to make sure that
> HEAD on the canonic repository indeed points to the branch that is
> considered the 'main' branch of the project; the Git version does not
> really matter IMO... I've seen plenty of repos at work that have HEAD
> pointing to `master` but `master` is not used, or not anymore...

Oh, but in this case, my main concern was servers that are so old that
`HEAD` is not a symref, in which case it can be a bit tricky to figure out
the default branch.

In any case, I feel this is such a minor point that I don't really want to
spend a lot of time on this paragraph.

> > Note: t7419 demonstrates that there _might_ be use cases out there tha=
t
> > _expect_ `git submodule update --remote` to update submodules to the
> > remote `master` branch even if the remote `HEAD` points to another
> > branch. Arguably, this patch makes the behavior more intuitive, but
> > there is a slight possibility that this might cause regressions in
> > obscure setups.
> >
> > Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
>
> I think that's an excellent idea. However I'd be more explicit in the
> commit message title:
>
> submodule: fall back to remote's HEAD for missing remote.<name>.branch

Great!

> meta comment: I never know where is the best place to make suggestions
> about changing the commit message title, since I can't quote it in my
> replies!

True. You could copy it, but that's not the same.

> > ---
> > Documentation/git-submodule.txt |  4 ++--
> > builtin/submodule--helper.c     |  2 +-
> > t/t7406-submodule-update.sh     | 16 ++++++++++++++++
> > t/t7419-submodule-set-branch.sh |  7 +++++--
> > 4 files changed, 24 insertions(+), 5 deletions(-)
>
> I think Documentation/gitmodules.txt (`submodule.<name>.branch` header)
>  should also be changed to reflect the behaviour change:
>
> diff --git a/Documentation/gitmodules.txt b/Documentation/gitmodules.txt
> index 67275fd187..539b4e1997 100644
> --- a/Documentation/gitmodules.txt
> +++ b/Documentation/gitmodules.txt
> @@ -49,9 +49,9 @@ submodule.<name>.update::
>
>  submodule.<name>.branch::
>  	A remote branch name for tracking updates in the upstream submodule.
> -	If the option is not specified, it defaults to 'master'.  A special
> -	value of `.` is used to indicate that the name of the branch in the
> -	submodule should be the same name as the current branch in the
> +	If the option is not specified, it defaults to the remote 'HEAD'.
> +	A special value of `.` is used to indicate that the name of the branch
> +	in the submodule should be the same name as the current branch in the
>  	current repository.  See the `--remote` documentation in
>  	linkgit:git-submodule[1] for details.

Excellent, I used that verbatim. Thank you!

> > diff --git a/Documentation/git-submodule.txt b/Documentation/git-submo=
dule.txt
> > index c9ed2bf3d5..b20f85e622 100644
> > --- a/Documentation/git-submodule.txt
> > +++ b/Documentation/git-submodule.txt
> > @@ -284,7 +284,7 @@ OPTIONS
> > 	`.gitmodules` for `update --remote`.  A special value of `.` is used =
to
> > 	indicate that the name of the branch in the submodule should be the
> > 	same name as the current branch in the current repository.  If the
> > -	option is not specified, it defaults to 'master'.
> > +	option is not specified, it defaults to 'HEAD'.
>
> Just to be extra clear (it's easy to get confused with submodules!) I'd
> say explicitly:
>
> If the option is not specified, it defaults to the remote 'HEAD'.

Good idea. I incorporated that, too.

> > -f::
> > --force::
> > @@ -322,7 +322,7 @@ OPTIONS
> > 	the superproject's recorded SHA-1 to update the submodule, use the
> > 	status of the submodule's remote-tracking branch.  The remote used
> > 	is branch's remote (`branch.<name>.remote`), defaulting to `origin`.
> > -	The remote branch used defaults to `master`, but the branch name may
> > +	The remote branch used defaults to `HEAD`, but the branch name may
>
> Same thing here:
>
> The remote branch used defaults to the remote `HEAD`.

And that.

> > 	be overridden by setting the `submodule.<name>.branch` option in
> > 	either `.gitmodules` or `.git/config` (with `.git/config` taking
> > 	precedence).
>
> Also, you seem to have missed the `master` reference in the description =
of
> the 'set-branch' subcommand. Something like this would do, I think:
>
> diff --git a/Documentation/git-submodule.txt b/Documentation/git-submodu=
le.txt
> index c9ed2bf3d5..8cf5831a72 100644
> --- a/Documentation/git-submodule.txt
> +++ b/Documentation/git-submodule.txt
> @@ -183,7 +183,7 @@ set-branch (-d|--default) [--] <path>::
>  	Sets the default remote tracking branch for the submodule. The
>  	`--branch` option allows the remote branch to be specified. The
>  	`--default` option removes the submodule.<name>.branch configuration
> -	key, which causes the tracking branch to default to 'master'.
> +	key, which causes the tracking branch to default to the remote 'HEAD'.
>
>  set-url [--] <path> <newurl>::
>  	Sets the URL of the specified submodule to <newurl>. Then, it will

And that.

> The rest of the patch looks good.

Awesome. Thank you for helping me improve this patch series!

Ciao,
Dscho

--8323328-1232997827-1593003071=:54--
