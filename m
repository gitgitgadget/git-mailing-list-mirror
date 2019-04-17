Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MALFORMED_FREEMAIL,
	RCVD_IN_DNSWL_HI shortcircuit=no autolearn=no autolearn_force=no
	version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id AE46520248
	for <e@80x24.org>; Wed, 17 Apr 2019 12:07:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731965AbfDQMHa (ORCPT <rfc822;e@80x24.org>);
        Wed, 17 Apr 2019 08:07:30 -0400
Received: from mout.gmx.net ([212.227.17.20]:41153 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731508AbfDQMHa (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 17 Apr 2019 08:07:30 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1555502841;
        bh=H0egpgS8+SPuqTvUhT0Dlc7sY79SBRhO3i1zx+QSpH0=;
        h=X-UI-Sender-Class:Date:From:To:cc:Subject:In-Reply-To:References;
        b=ABGAXnCg30FvxFPBtQFf8NmeEs4fgl4wpeqQbMYN31Wz1wSwj/sVwJpcgUYb1wiGD
         +vLWrwghg9fhKhPykDUsRL2XZqSINlfqwVuReVrm4/MJ1aW2fojydsT7QhRkMRUycz
         OmpPyAWjNrFqrYNOUe4oV4ZX0XApf+0boLfUg2+U=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [192.168.0.129] ([37.201.192.14]) by mail.gmx.com (mrgmx103
 [212.227.17.168]) with ESMTPSA (Nemesis) id 0MEFqW-1h5kyP0Brs-00FT4l; Wed, 17
 Apr 2019 14:07:21 +0200
Date:   Wed, 17 Apr 2019 14:07:25 +0200 (CEST)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@gitforwindows.org
To:     Junio C Hamano <gitster@pobox.com>
cc:     Johannes Schindelin via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org, Denton Liu <liu.denton@gmail.com>,
        =?UTF-8?Q?=C3=86var_Arnfj=C3=B6r=C3=B0_Bjarmason?= 
        <avarab@gmail.com>
Subject: Re: [PATCH v2 8/8] tests: disallow the use of abbreviated options
 (by default)
In-Reply-To: <xmqqef63qt5e.fsf@gitster-ct.c.googlers.com>
Message-ID: <nycvar.QRO.7.76.6.1904171354270.46@tvgsbejvaqbjf.bet>
References: <pull.167.git.gitgitgadget@gmail.com> <pull.167.v2.git.gitgitgadget@gmail.com> <a27d316855a833aa1726fc20c905dc40e41adf2f.1555061837.git.gitgitgadget@gmail.com> <xmqqv9zhwbxt.fsf@gitster-ct.c.googlers.com> <xmqqy34cugdj.fsf@gitster-ct.c.googlers.com>
 <nycvar.QRO.7.76.6.1904151509020.44@tvgsbejvaqbjf.bet> <xmqqef63qt5e.fsf@gitster-ct.c.googlers.com>
User-Agent: Alpine 2.21.1 (DEB 209 2017-03-23)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K1:mqmbLfDQwuelQztyeyo9NwqTsSbBWwwamIt8+StTY3XoQD+mj9z
 GV+IM1xDh3A9lxbcVPoQSe4EG00RwM+U1v0A40GO4NDyH8el61YUa+jA1b19c6u6jLNtjfZ
 IMHURu+jfst8mSnpkM1a9506u8J3T0BRtLYTre1BVxnUjSJ0Gvy3dolH45T/wAJE/kaWKWF
 ipo32z4dtg28xgFCwVOxg==
X-UI-Out-Filterresults: notjunk:1;V03:K0:IWAOh+R7TE4=:+1Jk6SoiKwjR/WVVzMD07i
 oMIWcbKPFiBPHPBmfDEyt+y8/+F17BeBX/+UFiKfXQFqca+XSjfBoljOwCQZU07idDL6AXrMO
 TLbNvHVYsCl2uACOweMGpLl4QECVJjqlQ0IY9ZvSYnrf06zcwALp4v2jTdk/bVAlkifmoQiup
 5lEgOcnIxENNOxEA2wu43XHJE5zQCCM12UBCLU4IQCATWk+kx9QTJH4A6IvG68/Qqg+8HXPuG
 s6MbwfAVPZAtV6pSGriyY6gO0zMvZx/7oyjvhxEabLhWCo16ABQ9P//z7pI5+i3PuhOE5yYKP
 JMjTXQHlqahwuxIQ1NHR+Gv0Ly5uubCTQ4F5rs9S2B0bXj39AEJGZSk8HcuGWexohwPUtZGMC
 87tYR0e1gkRM1yCmhxK9Zc7K9fg5w6HXQxRNwOqvBubKCOBoLSupqYmBUrP14Bq9uBwAXTNb1
 1rMX09cW1rLN38Jen+tYqsm3bpnERX2eiISzd/SfAryK/hwfvRS9/1Dvukoxwhq9GPwc8rxLo
 3Xoh9luv33XlgjpqxUjVRut0dq22JafaKCcWto/Fr1AynaKGfRNSUQJbqIGfCQnpjea++SJI0
 H044Qjg/Zb897sOeBOQhP9NlPy00qCjDW42RPJBj3B6dLjYyY5RfQEWvV1vQ1S5lVWodgCt2I
 piSXXxW/p9rVt4ssbmZEzdmi1kJpv4Fd2XZfCQBQBHx/wWlgS2WJ4POQ5MVCE+eUQtpkV3hTF
 k/eROqaDJRzlHtuKtF2lefS/2Ks7BpR7TKGIpcwoD8HUXesLZEaKIY1FKYXyJlfvBnBvNeFJz
 xvSx2dE1IxFFOhynlvCdnC5WMVba4YARBx6Tp/9a0vhm25pkJ7nyKlvrmjtUvZyXpUsyn8GZ0
 cMIhmEy0v+/gLtq8IKhAYo/Vs/IIctQZ15voPd+V8klrcJcg27hZqQ6tCQUJhEkWMM4CZK1TC
 VZKGS1ADnYw==
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Junio,

On Mon, 15 Apr 2019, Junio C Hamano wrote:

> Johannes Schindelin <Johannes.Schindelin@gmx.de> writes:
>
> > On Mon, 15 Apr 2019, Junio C Hamano wrote:
> >
> >> Junio C Hamano <gitster@pobox.com> writes:
> >>
> >>
> >> > Do you mean more like
> >> > ...
> >> > I think I can agree with either of the two positions...
> >>
> >> I am guessing from the earlier iteration that you wanted to say
> >> "unless it is given explicitly, we turn it on".
> >>
> >> As this last-minute style update that was botched, and a typofix in
> >> the proposed log message in 8/8, are the only differences, let me
> >> locally fix 8/8 up and replace it.
> >
> > Sure. I still would like the `isset` thing, as it makes things more
> > consistent, but I'll not fight for it.
>
> ${var:+isset} is fine.  Instead of
>
> +# Disallow the use of abbreviated options in the test suite by default
> +if test -z "${GIT_TEST_DISALLOW_ABBREVIATED_OPTIONS}"
> +then
> +	GIT_TEST_DISALLOW_ABBREVIATED_OPTIONS=3Dtrue
> +	export GIT_TEST_DISALLOW_ABBREVIATED_OPTIONS
> +fi
> +
>
> if you used
>
> 	if test -z "${GIT_TEST_DISALLOW_ABBREVIATED_OPTIONS:+isset}"
> 	then
> 		...
>
> I won't object.  After all, I know I introduced :+isset pattern to
> our shell script codebase as there are cases where it makes the
> result easier to follow.
>
> But the thing is that your patch had the polarity inverted.

Ah! I finally understand what you are saying. Took me a while, sorry.

> Where you must say "if this thing is not set, assign this value", you
> said "if this thing is set, assign this value", which was totally bogus.
> As long as that is corrected, that's fine.

Of course! It should be `-z` instead of `-n` there.

> Having said that.
>
> When you check if the variable is set, use of the ":+isset" pattern
> makes the result often easier to follow by explicitly letting us
> compare with an explicit "isset" token, e.g.
>
> 	case ",${VAR1:+isset},${VAR2:+isset}," in
> 	*,isset,*)	: at least one is set ;;
> 	*)		: neither is set ;;
> 	esac
>
> This *does* make the code simpler and easier.  But when checking for
> "is it not set?", you can compare with an explicit literal "" and
> that comparison is plenty clear enough.  You won't get as much
> benefit as the "is it set?" test would out of the pattern.  I would
> not say that it is pointless to use the ":+isset" pattern when
> checking "is it not set?", but it is very close.

Well, there is also the subtelty that somebody might *want* to set that
environment variable to the empty string (and obviously they would not
deem it appropriate for us to override their choice).

But I do have bigger fish to fry, so if you're fine with the `isset` thing
(fixed, of course), please go for it. If you'd prefer the version without
it, that's fine enough with me, too.

Ciao,
Dscho
