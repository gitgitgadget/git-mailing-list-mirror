Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.2 required=3.0 tests=BAYES_00,DATE_IN_PAST_12_24,
	DKIM_SIGNED,DKIM_VALID,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 40A3FC63777
	for <git@archiver.kernel.org>; Mon, 23 Nov 2020 09:29:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C7E76206D5
	for <git@archiver.kernel.org>; Mon, 23 Nov 2020 09:29:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=gmx.net header.i=@gmx.net header.b="RSXIUKhr"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727108AbgKWJ3g (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 23 Nov 2020 04:29:36 -0500
Received: from mout.gmx.net ([212.227.17.22]:44731 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725998AbgKWJ3f (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 23 Nov 2020 04:29:35 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1606123756;
        bh=+6D2rtA2m7v1fMzRJHCV7lAxhsTPVamufJF0SqOG+yc=;
        h=X-UI-Sender-Class:Date:From:To:cc:Subject:In-Reply-To:References;
        b=RSXIUKhrEOmOubkLO79ckTJQxdWHh54LYcXNAZELp39UeLAuU6HEDu0uKV1gpcpiN
         kiNokykJzp4SgtBg4LrFusIxeyoECDoNtGVcYWiwaPjsmhnhj5E/A3fLpqA7v1Hi5Y
         w6K7v8Tov2aYdsDTMWh9gPpKNFpqq4SM+2nWiyOU=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [172.26.22.105] ([89.1.213.133]) by mail.gmx.com (mrgmx105
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1MdebB-1k7WME3Bh3-00ZdO9; Mon, 23
 Nov 2020 10:29:15 +0100
Date:   Sun, 22 Nov 2020 20:07:52 +0100 (CET)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@gitforwindows.org
To:     Junio C Hamano <gitster@pobox.com>
cc:     =?UTF-8?Q?=C3=86var_Arnfj=C3=B6r=C3=B0_Bjarmason?= 
        <avarab@gmail.com>, Jeff King <peff@peff.net>, git@vger.kernel.org,
        Theodore Ts'o <tytso@mit.edu>,
        Don Goodman-Wilson <don@goodman-wilson.com>,
        "brian m. carlson" <sandals@crustytoothpaste.net>,
        Felipe Contreras <felipe.contreras@gmail.com>
Subject: Re: [RFC/PATCH] tests: support testing with an arbitrary default
 branch (sort of)
In-Reply-To: <xmqqk0uhxhqh.fsf@gitster.c.googlers.com>
Message-ID: <nycvar.QRO.7.76.6.2011222005160.56@tvgsbejvaqbjf.bet>
References: <nycvar.QRO.7.76.6.2011131519170.18437@tvgsbejvaqbjf.bet> <20201113161320.16458-1-avarab@gmail.com> <20201113191418.GA764688@coredump.intra.peff.net> <nycvar.QRO.7.76.6.2011132229480.18437@tvgsbejvaqbjf.bet> <87h7psg6lz.fsf@evledraar.gmail.com>
 <nycvar.QRO.7.76.6.2011162118060.18437@tvgsbejvaqbjf.bet> <87ima2rdsm.fsf@evledraar.gmail.com> <xmqqsg963bg9.fsf@gitster.c.googlers.com> <nycvar.QRO.7.76.6.2011191030170.56@tvgsbejvaqbjf.bet> <xmqqk0uhxhqh.fsf@gitster.c.googlers.com>
User-Agent: Alpine 2.21.1 (DEB 209 2017-03-23)
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="8323328-667205727-1606072074=:56"
X-Provags-ID: V03:K1:zjXpe83bWLmwLToHychGNZ4poVrfAJabRLa3MpawZYHu/PpIDzv
 i+woWfAk/XgshfyHBT0797XJx9SJkG+XrtJUeeZMgLiGuxKslNWNKF/sUbnk1lyeHR+sQIz
 9/XyVjMO4UBWzEuxRx+e2NoBOprc8cMkWNCZ/XLeTSABoctMxnVWm0jluJd+83UBz1pXGUn
 /8wivCbSw1nRcccAyO6Kw==
X-UI-Out-Filterresults: notjunk:1;V03:K0:UCPESTYRIuw=:OMAQUlqFEA/98+LZcdonto
 Oq7h+oXhAGN8GP3m9H1RFwt8KtVjunmabL09KByM3x13U/k0RSE8RtxmcMQXms9BLCXVtr+S/
 RhHbQgECabEsSkvzcG3U6mEwZnYg7HECr9aQDb2p9OJ+D5mIfqXdgogmEkBeJhw8LiViO3tAi
 M2WSrmAwGM0uKId2F/Fa5BIZmzQ1YvR0Ec6IA6d14gxcHAFT5QOe2HxMfqZqJ3RNickfiuRQ3
 QVG8xxGlTdej0WIT4nq1KEoEWZkjlRYLEeCivg03SSBbBsKdHYQVakObpMTzDN9xSOQDeCQkc
 bvTq64ZtMw+lccDN8/kc1BfsnnoUnOefSO0Rm56N5Yc3cJGpgSrIjo9ClbfFYhwAmP4H74GEa
 NeGNUcoU1WiUltKBMwSV+hY8rnlChkwe2Dztm1NyEkxc4t/p5hpxkEo8lIzHVUfLIQW6YdCZ3
 pMadpj/HsN6kXbe2QXDsmkff/UWpYK14rRaqL9gQrAftIhsWchaVc+43JeEAXNf/57fiq9/7R
 uhHWpnUJOhRUKnybSVGZHrc/xJyPVQPdBHox1uKm2ykUqwrTrqucwMPjXSrqogD5E4IB7/mmW
 mXxGzZ9GCIC5k+LT4KWsCN3j0ZyLBr7E++H9AZuO7aY+yo7bxrR0LlkPuLIZpHK4y06OPBSud
 jwOSg3TJmd6U1bhu4Eb6+j6j8ouPfqaip/EVpJ7TKimaoHBMMJ0yqkmq57ds+S6SUR6aFzNk5
 lVD9e0NKAxONTfpJs6p+s7UlEGCFDDFIQaAWHtL+Cecv5amwXQ6KZSB7BldZgj1l9Ye9RVynL
 2wBf9LYFLR8lH4cUMoiOVyj5QAOkYO7vkjc0GdzmF5BTzvkctK+yg0FZscKaz5ThZlxxo5pCe
 EgHPp4zhNyE72A7xRApYF9hKUK0O9AKP0YdJb8kZ0=
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323328-667205727-1606072074=:56
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Hi Junio,

On Thu, 19 Nov 2020, Junio C Hamano wrote:

> Johannes Schindelin <Johannes.Schindelin@gmx.de> writes:
>
> > On Wed, 18 Nov 2020, Junio C Hamano wrote:
> >
> >> =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason <avarab@gmail.com> writes:
> >>
> >> > P.S.: Shouldn't the pull patch in d18c950a69f be using the advice
> >> >      facility, not warning()?
> >>
> >> I think warning() is the right thing here, as it is self squelching.
> >> Setting pull.rebase (even to 'false') is sufficient---there is no
> >> need to set advise.setpullrebase to 'false' on top.
> >
> > Right. The only reason to use `advise()` would be to allow users to
> > squelch the warning by setting `advice.*`.
> >
> > On the other hand, warnings are not colored, but advice messages are.
> >
> > And now I realize that the same holds for `init.defaultBranch`: it is =
also
> > self-squelching. And it also might benefit from the coloring to make i=
t
> > stand out a bit.
> >
> > Thoughts?
>
> I do not see colors well.  You'll always get "find some other way to
> make it stand out more to those like us---if you canhdo so without
> colors, that would be ideal" from me, so please don't ask me to vote
> for more colors.

=46rom a purely selfish point of view: colors _do_ serve me well. And from=
 a
maintainer's point of view: I added my share of coloring based on users'
feedback, so I think that even if it does not benefit everybody equally
well, it is valuable to add coloring where helpful.

As to the aspect "find some other way to make it stand out", I believe
that `advise()` addresses that _also_, by virtue of prefixing the lines
with the uniform `hint:` prefix (which stands out visually, at least to
me, maybe it also does that for you?).

Ciao,
Dscho

--8323328-667205727-1606072074=:56--
