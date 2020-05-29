Return-Path: <SRS0=mJAO=7L=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.7 required=3.0 tests=DATE_IN_PAST_12_24,
	DKIM_SIGNED,DKIM_VALID,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MALFORMED_FREEMAIL,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E81C4C433E0
	for <git@archiver.kernel.org>; Fri, 29 May 2020 19:33:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C0F0620810
	for <git@archiver.kernel.org>; Fri, 29 May 2020 19:33:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=gmx.net header.i=@gmx.net header.b="J4+3R/MH"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728199AbgE2Tc7 (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 29 May 2020 15:32:59 -0400
Received: from mout.gmx.net ([212.227.15.15]:49775 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726751AbgE2Tc7 (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 29 May 2020 15:32:59 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1590780771;
        bh=ycMlAN4eFXlLxElERwrG9AAhstdXYYYssac8nEVN940=;
        h=X-UI-Sender-Class:Date:From:To:cc:Subject:In-Reply-To:References;
        b=J4+3R/MHzusfEOLBIhwlut9HrbsgzmlqQNkGRVXMlskMB0h5mihxdHFbljs+3pMI+
         RKh51VFYNtzV7UG1St4rwdQcc2mM1h48+gEgWY6fQup1h02ALT2utHuRhN2VxxbjZa
         Jh+XRo2GQzrvBcxuCq79hwQr3ZMgOVg4xVJh4xuc=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [172.23.211.123] ([89.1.214.207]) by mail.gmx.com (mrgmx005
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1N17Ye-1izXx32Vxq-012VZ5; Fri, 29
 May 2020 21:32:51 +0200
Date:   Fri, 29 May 2020 04:59:10 +0200 (CEST)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@gitforwindows.org
To:     =?UTF-8?Q?=C4=90o=C3=A0n_Tr=E1=BA=A7n_C=C3=B4ng_Danh?= 
        <congdanhqx@gmail.com>
cc:     Phillip Wood <phillip.wood@dunelm.org.uk>,
        Junio C Hamano <gitster@pobox.com>,
        Elijah Newren <newren@gmail.com>,
        Rohit Ashiwal <rohit.ashiwal265@gmail.com>,
        Alban Gruin <alban.gruin@gmail.com>,
        Git Mailing List <git@vger.kernel.org>
Subject: Re: [PATCH v4 6/5] fixup! rebase: add --reset-author-date
In-Reply-To: <20200528131701.GD1983@danh.dev>
Message-ID: <nycvar.QRO.7.76.6.2005290456190.56@tvgsbejvaqbjf.bet>
References: <20200527173356.47364-6-phillip.wood123@gmail.com> <20200527175748.54468-1-phillip.wood123@gmail.com> <20200528131701.GD1983@danh.dev>
User-Agent: Alpine 2.21.1 (DEB 209 2017-03-23)
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="8323328-495961210-1590721152=:56"
X-Provags-ID: V03:K1:F3Aw7W5z5Njw+QedediwuBo11iG6vkQtOPTd1Flc2jyqk0ul+Mh
 GAtD0ZYdONKc6p910Bs+H6jP83MSaRJXpx9svWdp6smMy7+3BqxTolqxLxrPxmX6q1uRu8P
 99tzZIfIAN931vgGJJ4xY3xvZmDMRzceklVyybwbqlQZh0nqKBiH7X/oTQJ3aBYf5SBnSPO
 zZU6Me5SUIXSvy0Lhp7HA==
X-UI-Out-Filterresults: notjunk:1;V03:K0:+hdqFv2zW5g=:pr1UpjllR917m+Iu0OgOhg
 u+jfpuufhy9k37LXSzlh+nylwRQr88fORKV/5BnQatzDJx7+yZg8xteyFZJYqYC1gYRb0jWk8
 8LiipNyrvaiutrT1t3obl+Knp97K24yIDuUq7OImyDo6DU/gK/9U+B5NYyA3ZTwXK9OoOj+iX
 Rb4gReFi3ExGMb9MbUbkmhuWruZFOPv57Akel9FEQFZ18GQxM0lm33AX0tvvHxgKcX4hiKFqa
 kNgy9gdZKbLoolCx6W4i4eQzOe2ekSUXYpbIRR7a63o1B14qZ7D+u0wRpvTREmZz9nGqfZY7Q
 zWxeFM4/YijuAUS69DYf/Lb02boNQg+gWT6Uxcg5C6DiO6jQq5TrO4J9mfUzUURLoPYqYHIUd
 qDrWUtOx5luy+uR3JN6Do6OoxRh8hIxZ9SgI91REtBCD0NLvdzCGt26J7Nk8YUb6nOTHS+GIk
 ta6zI/CvQ2l1Hb1fbIGek76w2XJI1IKHNiUXpnjqzIsVT29oWKDQbWdkYqFFJdeZHzO3N18pC
 H8jNaF/sjBTIa+pNldwPYiH0dO3TD5qW6uLDkF3kqfaeB+f8Xf/1C4K3OlJABigzB/D3UHHt8
 ockuvsQQJv7dwEBbHc8+rccewnq1rXl7smUQGMwf4Bpcm21264sPwUbl26Gp7OMZbD9n8wGL1
 mRar4qEyMFdN06AJJGaMY5kxiur2QwEHd6JuhdaWAtH/IvE1M0kzD38JeXKthzhPor8JgyWnv
 JZUdMBl57+ywPl3NqOMXCOl+vTRQ5DZ5/8P09nc+5fEmU9qqsfoTGo1go05NhIrkembLbjIuU
 odIFk/9fneqbm6vR7kkATDw7pwrHFQkUQ+KIVeStOc2gG0Ptpw0AcqC0XtFqzbea8/Ggzkdim
 2vnzW9YCtNcsEbaUIY/Vc9fEdnipoAhCEtUAnDZ/OEKb9vTH177grWvzputnFYGPiG97sXzcx
 cw8XUvFM296c/Rnwjhw5V37QEX3i0utMF8kvRBjwR2cyWNjfXXVjdpcOr8YrvZkRRZA0a4mQH
 VGsR4r9C2fZ6qY7eunn95el+ZhMr8dAArv6d4AJbJ/vcPTBYJYKDpvSIfwGP5tjryzn5h3cnQ
 V4NFuEOOJDP8vF+uKWh2n/35r8ez37973LK4gJ6mHcq7m2YX72FeCOqZfTQ3YoRPCbbjTorHr
 Y1M5vwY5ebvcigj0iHkQa/dn0oUqAjRiFGHtPY/ldXUsA3frOHf/bKHpzBXM97srEvMqDFa07
 eS27T3+7RRjfcWAuR
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323328-495961210-1590721152=:56
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Hi,

On Thu, 28 May 2020, =C4=90o=C3=A0n Tr=E1=BA=A7n C=C3=B4ng Danh wrote:

> On 2020-05-27 18:57:48+0100, Phillip Wood <phillip.wood123@gmail.com> wr=
ote:
> > From: Phillip Wood <phillip.wood@dunelm.org.uk>
> >
> > Sorry I somehow forgot to commit this before sending the v4 patches,
> > it fixes up the final patch
> >
> > Signed-off-by: Phillip Wood <phillip.wood@dunelm.org.uk>
> > ---
> >  t/t3436-rebase-more-options.sh | 2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
> >
> > diff --git a/t/t3436-rebase-more-options.sh b/t/t3436-rebase-more-opti=
ons.sh
> > index 5ee193f333..ecfd68397f 100755
> > --- a/t/t3436-rebase-more-options.sh
> > +++ b/t/t3436-rebase-more-options.sh
> > @@ -196,7 +196,7 @@ test_expect_success '--ignore-date is an alias for=
 --reset-author-date' '
> >  	git rebase --apply --ignore-date HEAD^ &&
> >  	git commit --allow-empty -m empty --date=3D"$GIT_AUTHOR_DATE" &&
> >  	git rebase -m --ignore-date HEAD^ &&
> > -	git log -2 --pretty=3D"format:%ai" >authortime &&
> > +	git log -2 --pretty=3D%ai >authortime &&
> >  	grep "+0000" authortime >output &&
> >  	test_line_count =3D 2 output
> >  '
>
> This version addressed all of my concerns, LGTM.
>
> Only the last
>
> 	test_line_count =3D 2 output
>
> puzzled me at first.
> Since it's the only usage of test_line_count in this version
> Turn out, it's equivalence with:
> -----------8<-----------
> diff --git a/t/t3436-rebase-more-options.sh b/t/t3436-rebase-more-option=
s.sh
> index ecfd68397f..abe9af4d8c 100755
> --- a/t/t3436-rebase-more-options.sh
> +++ b/t/t3436-rebase-more-options.sh
> @@ -197,8 +197,7 @@ test_expect_success '--ignore-date is an alias for -=
-reset-author-date' '
>  	git commit --allow-empty -m empty --date=3D"$GIT_AUTHOR_DATE" &&
>  	git rebase -m --ignore-date HEAD^ &&
>  	git log -2 --pretty=3D%ai >authortime &&
> -	grep "+0000" authortime >output &&
> -	test_line_count =3D 2 output
> +	! grep -v "+0000" authortime
>  '
>
>  # This must be the last test in this file
> ------>8------

Good suggestion!

I've read through all 5 patches, and rather than repeating much of what I
said about 1/5 and 2/5 in 4/5, I'll just say it here that it applies
there, too: less repetitions in the test script, and I'd prefer the layer
where the `apply` vs `merge` options are set to be `cmd__rebase()` rather
than `run_am()` (and `get_replay_opts()`).

All in all, it was a pleasant read.

Thanks,
Dscho

--8323328-495961210-1590721152=:56--
