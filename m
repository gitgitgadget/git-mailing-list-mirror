Return-Path: <SRS0=R55k=B3=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.9 required=3.0 tests=BAYES_00,DATE_IN_PAST_03_06,
	DKIM_SIGNED,DKIM_VALID,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MALFORMED_FREEMAIL,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1849DC433E1
	for <git@archiver.kernel.org>; Mon, 17 Aug 2020 09:05:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D71B02063A
	for <git@archiver.kernel.org>; Mon, 17 Aug 2020 09:05:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=gmx.net header.i=@gmx.net header.b="C1+0ZzJL"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728149AbgHQJFV (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 17 Aug 2020 05:05:21 -0400
Received: from mout.gmx.net ([212.227.17.21]:35767 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727001AbgHQJFO (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 17 Aug 2020 05:05:14 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1597655078;
        bh=IDTSZFQZNTtycStiLPVRghlIDmHg/0y27a3LRvMDQvE=;
        h=X-UI-Sender-Class:Date:From:To:cc:Subject:In-Reply-To:References;
        b=C1+0ZzJL3AsIz0W+vo2xIkJ4dE0HYcSsTWCAGpQtRU6VFMgFrUZEVJWhDxJtYCFj5
         Jxbo2pI/NOZ3mrsK22+/p3q+NtbY8nV02ZEjxmkWPOvlqk7Yqyblt07ZjrhIyPowp1
         Pc2jdp6st4yei6JETMQrLuoMVtihAKKM2puxAkro=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [172.24.183.59] ([89.1.215.233]) by mail.gmx.com (mrgmx105
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1MbAgq-1keixq0nNo-00bdAR; Mon, 17
 Aug 2020 11:04:38 +0200
Date:   Mon, 17 Aug 2020 06:41:31 +0200 (CEST)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@gitforwindows.org
To:     Jeff King <peff@peff.net>
cc:     Sibi Siddharthan <sibisiv.siddharthan@gmail.com>,
        Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
Subject: Re: What's cooking in git.git (Aug 2020, #01; Mon, 3)
In-Reply-To: <20200814124011.GA4104592@coredump.intra.peff.net>
Message-ID: <nycvar.QRO.7.76.6.2008170640160.56@tvgsbejvaqbjf.bet>
References: <xmqq8sevt1lf.fsf@gitster.c.googlers.com> <20200804185057.GA1400256@coredump.intra.peff.net> <xmqqr1sms0f0.fsf@gitster.c.googlers.com> <20200804192053.GA1400936@coredump.intra.peff.net> <nycvar.QRO.7.76.6.2008121516560.50@tvgsbejvaqbjf.bet>
 <20200812141958.GA32453@coredump.intra.peff.net> <CAKw82xxOZFcsMw47TSrD7-pXpqO7O0_m84o96iH6+ZVeN9j1uw@mail.gmail.com> <20200812160653.GA42443@coredump.intra.peff.net> <nycvar.QRO.7.76.6.2008141352430.54@tvgsbejvaqbjf.bet>
 <20200814124011.GA4104592@coredump.intra.peff.net>
User-Agent: Alpine 2.21.1 (DEB 209 2017-03-23)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K1:DBTS5nx3IVqwGpTidsKaDMjVh9/OoTHyE9EPpwEuveVP595dFJy
 BA3k2Jy8wZcvhatZwF2JnCqFNWO8A9a/ttWYfXvU/Xqyor4VHn4D/uhANtJLtmgN+6ttiLT
 ozrQamvh08V8vYToil3/abFvgzmm69pLgML8a4TZriRkXaP3PY/2Pf2rAxbzZm7Arj3BkNo
 Ls1UF7iH7Y43QDKhksFsw==
X-UI-Out-Filterresults: notjunk:1;V03:K0:PEDlVxhRN4g=:4ponZzAbgLZAeQFs4Plrqb
 L39joVLsUPQAp18tAPdL+wEDFDBPhqYudhU/D5o2qrrs3HZ2OeZGERteinA3Ny6PXBUFp5SlV
 x2mz/VV/dMvto7p4i6W/SVIK48YYPNGLmfZiA2GmwqjqP+cBErnTkkP5jOlD7P5qU8dOqp0tF
 RgMxWM+lv9ouwbsHaxZDoSvni2oNLGKApXGg9c+/Hy22ppH/gRx64C0tjLgli6Ps+Q+bTdoJz
 fVbogOui4j+z2ZuUssGew+ICi9xcyQ7/qEDDlg8NB3iEXlz1PqZWEDLg6v2NllxS5VMsiQNZ/
 UxccLf85MVW2wKzJkK8VqTXNGU3P6pml6O2OVU5XF66OkOh+bV70TRtK0GU3/q1+RB2lFbH2k
 lljgDjo+l03UFU7IJftM37PNkFNGYYi/KRMC3P3rQEsKMMRpLE7Vsoa4TCiEe8ndhgbkk9yZg
 kmvGI863+BdC8Qn7q7Fkmos6ODfX14fH/7raa1Q10Wwf1a0uYZCDQnhRTaktTNLWjQP7O8i4x
 y9J3Fi3L8QErbr6a2N+PVe2TIrpUV2fawOr2sGXtPyLTmNNNXWyB0K40MazpgviFUgMGNg5BR
 adAafJOo4FRzI286FeOQDTB1JQer3ftlce3lJImkv+kIAxspiHbzbMIPp2t5L8SerjS+skyd8
 wl2G870Qa92lifUCTTeOfRVAwgvxwvOiKYBGIHuvDW7ziRDb8ge9z40Ma3WKoMuwbeyE7gef6
 eOcFM0l9765VxAOVPHPiYfonGbqEJqZCcumzzugIQ7fX7lqM/XnceBT3OZFwYgJkXdlfCK62L
 lGvAvN/fXIDLuR/C9sQpw5eVI5XapIVFdsi42B6dfMLRXvq9Z2x3tSfzaSCFrMRusm0Uhy12i
 5d6VxiyxXtgPSVIN95FfM73G8dJGIbl4re24+SditnWLv8+kw4LJq9MWL7wM2vTZtIWgeyywv
 W/V15Pz5GSBy+6SZdgsBO7jANhovKYwBmubuTA+O/VKOnC6M6h2MfP/kvlYGl8xByismdxCQP
 PCeKWwCMh6t89ydgb49rNv/rrAln1ZuV68CbFisD2ksiKVjcFIPWal3PHvGyMZNidfg9oHpqZ
 z7OdcC75s8UcfvbY3ZMPFU2vM0eAl0D/OPyH290n3dCLfmuP6TfrM6QlqGaN+g/V9S41AnE6p
 eRYGxbt13L3sIJw7uwfEVfbNOmsrUxl6OCDNooYOhsKf8EmFxQx3lFPD2u9abvPWM+eOK4ayK
 dmATYOeV0PcLysqCU3FWukIBzKs83kqKhaWPV4A==
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Peff,

On Fri, 14 Aug 2020, Jeff King wrote:

> On Fri, Aug 14, 2020 at 02:08:28PM +0200, Johannes Schindelin wrote:
>
> > On Wed, 12 Aug 2020, Jeff King wrote:
> >
> > > From my perspective as somebody who does not work on Windows, I wond=
er
> > > how much value there is in running vsbuild _and_ Windows CI for aver=
age
> > > developers. I have certainly gotten information from these jobs (e.g=
.,
> > > when introducing a portability problem, or missing a refactoring spo=
t in
> > > Windows-only code). But I don't think I've ever gotten information f=
rom
> > > vsbuild that wasn't also in the regular windows build.
> >
> > There have not been a _ton_ of these instances, but there have been a
> > couple:
>
> Thanks, that was exactly the kind of data I was interested in.
>
> > I cannot find any more instances, so yes, I agree that the
> > `vs-build`/`vs-test` jobs might not be _all_ that necessary. So maybe =
we
> > should do something like this?
>
> Let's leave it be for now. The topics I had to adjust due to cmake were
> ones that I'd had sitting around for a while. So while I hit problems
> immediately, now that the queue is drained it's not clear to me how
> often it will come up in practice.
>
> > -- snipsnap --
> > diff --git a/.github/workflows/main.yml b/.github/workflows/main.yml
> > index 30425404eb3..2549fff8edd 100644
> > --- a/.github/workflows/main.yml
> > +++ b/.github/workflows/main.yml
> > @@ -122,7 +122,7 @@ jobs:
> >          path: ${{env.FAILED_TEST_ARTIFACTS}}
> >    vs-build:
> >      needs: ci-config
> > -    if: needs.ci-config.outputs.enabled =3D=3D 'yes'
> > +    if: (github.repository =3D=3D 'git/git' || github.repository =3D=
=3D 'gitgitgadget/git') && needs.ci-config.outputs.enabled =3D=3D 'yes'
>
> If we do go this route, I'd consider defaulting it to on and just
> letting people disable it through needs.ci-config.outputs.vsbuild or
> similar.

Okay, let's leave it for now, and if there are more instances, go the
`config-repo/ci/config/` route.

Ciao,
Dscho
