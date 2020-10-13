Return-Path: <SRS0=7dzq=DU=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MALFORMED_FREEMAIL,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A6912C433DF
	for <git@archiver.kernel.org>; Tue, 13 Oct 2020 14:08:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 59763247C6
	for <git@archiver.kernel.org>; Tue, 13 Oct 2020 14:08:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=gmx.net header.i=@gmx.net header.b="h3d6MMvO"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729179AbgJMOIv (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 13 Oct 2020 10:08:51 -0400
Received: from mout.gmx.net ([212.227.17.21]:53271 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727340AbgJMOIv (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 13 Oct 2020 10:08:51 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1602598087;
        bh=/CGx9W9wRIZ8YpejV9IxpazyD3iTF6e7VPRg9lqi/ag=;
        h=X-UI-Sender-Class:Date:From:To:cc:Subject:In-Reply-To:References;
        b=h3d6MMvOtx5pmB24YqxzasDWFMNuuEt9u4IrUQrG5F4hKdaatDKgPNyaAdWY2+LcR
         lnHx9FlFuhYgdT1E98fb/ZP/eMHY2v+024r+PjDLowDYjTz7m0W5prq4FNRbblhSm1
         zx1qlrgSU6FRU7q10AiEZc5hNjzB3zpM6LhRNtsQ=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [172.20.73.169] ([89.1.212.188]) by mail.gmx.com (mrgmx104
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1MV63q-1ksDYX1q2Y-00S5xI; Tue, 13
 Oct 2020 16:08:07 +0200
Date:   Tue, 13 Oct 2020 14:00:31 +0200 (CEST)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@gitforwindows.org
To:     =?UTF-8?Q?Micha=C5=82_K=C4=99pie=C5=84?= <michal@isc.org>
cc:     git@vger.kernel.org
Subject: Re: [PATCH v2 3/3] t: add -I<regex> tests
In-Reply-To: <20201013063846.GF3278@larwa.hq.kempniu.pl>
Message-ID: <nycvar.QRO.7.76.6.2010131337320.50@tvgsbejvaqbjf.bet>
References: <20201001120606.25773-1-michal@isc.org> <20201012091751.19594-1-michal@isc.org> <20201012091751.19594-4-michal@isc.org> <nycvar.QRO.7.76.6.2010121320190.50@tvgsbejvaqbjf.bet> <20201013063846.GF3278@larwa.hq.kempniu.pl>
User-Agent: Alpine 2.21.1 (DEB 209 2017-03-23)
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="8323328-1886952159-1602590433=:50"
X-Provags-ID: V03:K1:g4AIpnyloinabfQ0hXB17zWB8XDHyWRvbk6zHidEOtQhxuUVCvK
 8RUduY/TOfi8vzu9NjrJ/2pC5Ee9Po6S9y7Sttu1nQhhSE9/ReSE4TwedsC5WD1BrTYtdaQ
 vVU+xCw9ko66LFJ6ntVjoIHlZaSgNlwGJBL3g4MEzGz5c4NlO4lbaCwTs0kjSCYZ+HxcLiz
 NvXiZ5ry8yXKNVhu8GaUw==
X-UI-Out-Filterresults: notjunk:1;V03:K0:Dz2tMq4MTpY=:xyFYOsETjB8erMgfsTauCB
 NbBytiTL2TYpZAzSiyB26sBlcCYErtVUkI1hihF6CMkeVdOBJs6eh2VpCH7HYrhSG03FC8t/1
 Lj7YsvaexVBySFcbA18VURNNKFXwnQSBtxC0w8IVrwc6bFkT2R8P8Yg1k9v2115QZdZxS3b50
 XZWeIO5hWsz54N9oIitqEPTAmOoHkbJjfR+ooJucajYy36YGJRova61WPq/US74JaH179DdeH
 yFbnRkFZ9BQpJ4SdU1v96TnZYMzDTVpN81OLIWK1C4PNysEVOXYKcrdmQLJE5zHWc7Itq3tU6
 3/21vbUp9uI9RlCdFKMzzCR0stuTh5h6xozXwAnBb2uK2hDTAkkpCPwGczQKpLyOb0NycYnmc
 XPBIaXLH4NwAFtd4x2abhZOwJWd/Ld7K2lEVilwTZSyUHnnl6h0BZLwPj2oTjcRmfWcDfkmC8
 GiNRc9XsvyvbtR1v1Fk3ya+fX+FFw+tjoQJQyiFKtPXkDi2bClb1uK1EQLYQ2DVI7L6/xxKTP
 3KyAJ+Vtsg0u/0Sy8DPbXQIho5fMklPBlQVj/FijPPWzJUbNRYRxvV63d8fbbPcU3Y46agj5I
 /j+PvDex0eidleXmA0xl9TR7jgbPTVBNFErKNfeFyKsGXJzIha5D+ohFApXaMjmyzFUMd4qjR
 nbK7oTbiPPIR2KbWJN3rCE2ENXPb3FbfS7hURW8Ps5juDqLSpunIG3Mc1F/GkHzr/eovN5dW8
 KdnG21I4wbvjboAXJqHY/VWPNWUL3diMRx3XeNqEkrA86MlSSjwvW/fmuGnYlGVJthqflr74/
 2eDPt7lGgNsZUU0nEz3XeQnLoE5jwjdiqG53+WP2er1sa/l0KXMXDOnrDntnWY2XAN5izRyhJ
 ErD32/OzAuMI9mO1snhNWgnu/uM9snlnPW7b6R4D6YQY4ZKJRERObdLEDbB8j4ESnZFukWnfd
 Eln1g49mLYV92vHnecFZTgGCnqJei0F2Rsh+3p5bKAp6NTmL/8bVrGnBl1h27fRTfEkDAMY+8
 p6ujMEkLG+trAjvwnhT/6nzIgrj9R7nSjArGOBX2rBjf80pUggHLTaHSut6utMTNO2R++1sMl
 FR0rTKEe+9Bgv5INZiBfeCA+5cKJiMndxA54HPoqwyAztr3zKOaN5gys0WQ6Gs/qioPeu/ofV
 dQevdMdJZaJAIr25NDyq29jYow4UrehS7zb3Rt4cqdhdx+n41jGbWIqn45V1ahdtV4hezQuK6
 oyahD+D+GER6yJQUttmeeJuXSNt7j7hlYNU0jQTvJFNGt7yYFUkbOc1VJxYPmQik6Zd6xbkgx
 a0YxUdra
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323328-1886952159-1602590433=:50
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Hi Micha=C5=82,

On Tue, 13 Oct 2020, Micha=C5=82 K=C4=99pie=C5=84 wrote:

> > Hmm. I wonder whether we could do with a much more concise test script=
.
> > The test suite already takes a quite long time to run, which is not a
> > laughing matter: we had issues in the past where contributors would sk=
ip
> > running it because it took too long, and this test is sure to exacerba=
te
> > that problem.
>
> First, let me say that the goal of minimizing the run time of a test
> suite is close to my heart (it is an issue at my day job).  Yet, I
> assumed that this new test would not be detrimental to test suite run
> times as it takes about half a second to run t4069-diff-ignore-regex.sh
> on my machine - and (I hope) its contents are in line with the "tests
> are the best documentation" proverb.

Sadly, the test is not quite as fast on Windows. I just ran this (on a not
quite idle machine, admittedly) and it ended in this:

	# passed all 11 test(s)
	1..11

	real    0m51.470s
	user    0m0.046s
	sys     0m0.015s

Yes, that's almost a minute.

> > I could imagine, for example, that it would be plenty enough to do
> > something like this instead:
> >
> > -- snip --
> > diff --git a/t/t4013-diff-various.sh b/t/t4013-diff-various.sh
> > index 5c7b0122b4f..bf158be137f 100755
> > --- a/t/t4013-diff-various.sh
> > +++ b/t/t4013-diff-various.sh
> > @@ -6,6 +6,7 @@
> >  test_description=3D'Various diff formatting options'
> >
> >  . ./test-lib.sh
> > +. "$TEST_DIRECTORY"/diff-lib.sh
> >
> >  test_expect_success setup '
> >
> > @@ -473,4 +474,24 @@ test_expect_success 'diff-tree --stdin with log f=
ormatting' '
> >  	test_cmp expect actual
> >  '
> >
> > +test_expect_success '-I<regex>' '
> > +	seq 50 >I.txt &&
> > +	sed -e "s/13/ten and three/" -e "/7\$/d" <I.txt >J.txt &&
> > +	test_must_fail git diff --no-index -I"ten.*e" -I"^[124-9]" I.txt J.t=
xt >actual &&
> > +	cat >expect <<-\EOF &&
> > +	diff --git a/I.txt b/J.txt
> > +	--- a/I.txt
> > +	+++ b/J.txt
> > +	@@ -34,7 +31,6 @@
> > +	 34
> > +	 35
> > +	 36
> > +	-37
> > +	 38
> > +	 39
> > +	 40
> > +	EOF
> > +	compare_diff_patch expect actual
> > +'
> > +
> >  test_done
> > -- snap --
> >
> > Note how it tests various things in one go?
>
> Right, neat, though this does not (yet) test:
>
>   - the interaction between -I and --ignore-blank-lines (this is visible
>     in code coverage),

Right. Any chance you can finagle that in, e.g. by yet another `-e`
argument to the `sed` call?

>   - whether the list of hunks emitted varies for different -U<n> values,

I am not worried about that.

>   - diffstat with -I<regex>,

I am not worried about that, either, as `diffstat` consumes `xdiff`'s
output, therefore if one consumer works, another consumer will work, too.

>   - invalid regular expressions.

Right, that should be super easy (and quick) to test.

> Would you like me to add these tests to your proposal or to skip them,
> given that -I uses the same field for marking changes as ignored as
> --ignore-blank-lines does?

I'd say it depends how easily (read: in how small a test case or
modifications to an existing test case) you can add a test for that
interaction.

Thanks,
Dscho

--8323328-1886952159-1602590433=:50--
