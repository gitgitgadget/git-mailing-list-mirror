Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.5 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 48FC91F462
	for <e@80x24.org>; Wed, 29 May 2019 09:11:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726141AbfE2JLi (ORCPT <rfc822;e@80x24.org>);
        Wed, 29 May 2019 05:11:38 -0400
Received: from mout.gmx.net ([212.227.17.20]:43189 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725911AbfE2JLg (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 29 May 2019 05:11:36 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1559121071;
        bh=is5Xt5IVAxYrOfX5x/a9mrhLJ4pqbF/b10CsrG/qH0k=;
        h=X-UI-Sender-Class:Date:From:To:cc:Subject:In-Reply-To:References;
        b=SeXt88ZOlygApZb+e6JPzRAXPV+BR9OGynrqDpcxjRPqpnhZUBYf3wFKqvwbA2zdg
         Qvt6BBxJzP8eeftIouhKdiLUo89VLbdJNkknBILoaM58/UGbG6XgewBqomvMbOqfAa
         YY9G+vVfDRM2b2uzM0PMmpUz06EtRlduoKr3qtE4=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [192.168.0.129] ([37.201.192.51]) by mail.gmx.com (mrgmx104
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1M5wPb-1hXqgn48L5-007VQ4; Wed, 29
 May 2019 11:11:11 +0200
Date:   Wed, 29 May 2019 11:10:53 +0200 (CEST)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@gitforwindows.org
To:     =?UTF-8?Q?=C3=86var_Arnfj=C3=B6r=C3=B0_Bjarmason?= 
        <avarab@gmail.com>
cc:     git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
        Jeff King <peff@peff.net>, Stephen Boyd <swboyd@chromium.org>,
        jrnieder@gmail.com, sandals@crustytoothpaste.net,
        sunshine@sunshineco.com, xypron.glpk@gmx.de,
        Paolo Bonzini <pbonzini@redhat.com>
Subject: Re: [PATCH 4/5] send-email: fix regression in sendemail.identity
 parsing
In-Reply-To: <nycvar.QRO.7.76.6.1905222223380.46@tvgsbejvaqbjf.bet>
Message-ID: <nycvar.QRO.7.76.6.1905291106540.44@tvgsbejvaqbjf.bet>
References: <xmqqsgtd3fw3.fsf@gitster-ct.c.googlers.com> <20190517195545.29729-5-avarab@gmail.com> <nycvar.QRO.7.76.6.1905222223380.46@tvgsbejvaqbjf.bet>
User-Agent: Alpine 2.21.1 (DEB 209 2017-03-23)
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="8323328-1918119686-1559121071=:44"
X-Provags-ID: V03:K1:YOq189N9DHZilcGbj6b+u4P2//74Ac1neZil9rp6GbiFUp4Czjg
 6MHA58Y+XkHyoCC0s1YSLmvpLjxJkvsXzPVqjF5kMg3TkVu3pWpnydKPckXghHhpKY9JS3s
 jUcU8mIIyVmVtCynGD/+BZp5zn9dY9GFh4okzxHqHfQ09+EzZxK8udnMmUakCZ4nagPEP4R
 zACSaKPTEtTn3kw6P+ZtA==
X-UI-Out-Filterresults: notjunk:1;V03:K0:dFeoqPIcisY=:ySh23Ma0lZ/T4ybpvFwipG
 D/zeFtXTkA//hh/SWifk0/2RZuxnZkrLvmRlQrLsAd73l2TpM5EEA0id9o9NVxz81AuRZt+Sq
 5lXo0gxyqf0VQRCOLhrFQWdPu98kILOdotMz8FV51FvLQvXXzVAeySozHNfy0wIiHiVc/y9aq
 nSzuXHmxH4lWmJE/Ao5V4sddg1RM4UwlMaMvRPjXB2UjGPT/lyaxmbsmyspNT7hxqq8vRFawE
 oN5cIqbohmtN3TYbG3UMm7NM+cEDvv0HsXlqvKI4azAX16ie4VYLymMa3SSe5kxOnHl6bXf23
 EtG0i5soza1DkQS5wChGHGsWUpQU1mKf38Vtue7wtCR+b11zZZbBn1p/42GLa9sv7pu6xXznC
 OL+rgsPr0U929+vn8yU3XdpPCJx/yMK0tE38/p5zk+AJn+JFmjUTRzr813/2I9ombl7V8atyT
 gWROVUu6Tz4xdKvuUkvCoqzC2JgBRXQ6nIJMM9s/DZ+cYgExyRqQAjLPPxRI5gWeCV4BcHC6B
 UEJx3REH6xqI4FSoZ5ttvfpow8pAZRDjjLj6NLN8xYq5/EhPGf3Bw/yuimaa8IQw/duo+6wvC
 DG/7aQx8IxH0ZO3ltET7vMP24+S/2WGq7gcBMRSIlRE5EFapAMzJOP+BWLcntboMs0MxaNWeq
 5lCQPtw+PwOoVPGDj7jIk9W02E3CYQ3vxxctG9kD9EudN7XRVtXqKBxU/yC7eOpvoYqUpFzla
 O7dg5Pc0BBkpSoRQS4HoyDm9TfHdXAohO1rNz5SPZeY6NFcSRD1eckLy3wFzClpzOa4yjxks8
 PNQ/3FzkPJVnMEdgd3hlkmm7hVCIJgabrvh7iki9g0Rg3pUcEfE5/m+tmmU9G6bLAItmqHP/d
 T3J5J5Ii95YPqrHlbTPnEX6u7gxfPKWnrgaBUc/XfrtaRV2aYuiWxs94yDM2/ArzLNLJgEn0y
 uS0Szd3bj9IpFD7O2Z6l3M/MBaMdFqMGRZCwjrV4zUWkZhTou7INK
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323328-1918119686-1559121071=:44
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Hi Junio & =C3=86var,

On Wed, 22 May 2019, Johannes Schindelin wrote:

> On Fri, 17 May 2019, =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason wrote:
>
> > [...]
> > +test_expect_success $PREREQ 'sendemail.identity: bool variable fallba=
ck' '
> > +	git -c sendemail.identity=3Dcloud \
> > +		-c sendemail.xmailer=3Dfalse \
> > +		send-email \
> > +		--dry-run \
> > +		--from=3D"nobody@example.com" \
> > +		$patches >stdout &&
> > +	grep "To: cloud@example.com" stdout &&
> > +	! grep "X-Mailer" stdout
> > +'
> > +
>
> These test cases all diligently use the `$PREREQ` prerequisite, but...
>
> >  test_expect_success $PREREQ '--no-to overrides sendemail.to' '
> >  	git send-email \
> >  		--dry-run \
> > @@ -1785,6 +1840,15 @@ test_expect_success '--dump-aliases must be use=
d alone' '
> >  	test_must_fail git send-email --dump-aliases --to=3Djanice@example.c=
om -1 refs/heads/accounting
> >  '
> >
> > +test_expect_success 'aliases and sendemail.identity' '
> > +	test_must_fail git \
> > +		-c sendemail.identity=3Dcloud \
> > +		-c sendemail.aliasesfile=3Ddefault-aliases \
> > +		-c sendemail.cloud.aliasesfile=3Dcloud-aliases \
> > +		send-email -1 2>stderr &&
> > +	test_i18ngrep "cloud-aliases" stderr
> > +'
> > +
>
> This one is missing it. That breaks the Windows job in our Azure Pipelin=
e
> where we leave out all of the Perl bits (to accelerate the tests somewha=
t).

For the record, this is still breaking our Azure Pipeline build.

Junio, would you terribly mind applying this on top (or fetching it from
the `shears/pu` branch at https://github.com/git-for-windows/git)?

=2D- snipsnap --
=46rom 4c946f956d894676f68f5b130ab414d8ea75e97d Mon Sep 17 00:00:00 2001
From: Johannes Schindelin <johannes.schindelin@gmx.de>
Date: Wed, 29 May 2019 11:09:23 +0200
Subject: [PATCH] SQUASH???

Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
=2D--
 t/t9001-send-email.sh | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/t/t9001-send-email.sh b/t/t9001-send-email.sh
index 7caab8160fcf..7c5ef114ac90 100755
=2D-- a/t/t9001-send-email.sh
+++ b/t/t9001-send-email.sh
@@ -1840,7 +1840,7 @@ test_expect_success '--dump-aliases must be used alo=
ne' '
 	test_must_fail git send-email --dump-aliases --to=3Djanice@example.com -=
1 refs/heads/accounting
 '

-test_expect_success 'aliases and sendemail.identity' '
+test_expect_success $PREREQ 'aliases and sendemail.identity' '
 	test_must_fail git \
 		-c sendemail.identity=3Dcloud \
 		-c sendemail.aliasesfile=3Ddefault-aliases \
=2D-
2.22.0.rc1.windows.1.19.g571a93d65ff3

--8323328-1918119686-1559121071=:44--
