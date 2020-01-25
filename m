Return-Path: <SRS0=JG/V=3O=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MALFORMED_FREEMAIL,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 68613C2D0CE
	for <git@archiver.kernel.org>; Sat, 25 Jan 2020 00:14:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 27B4F2071E
	for <git@archiver.kernel.org>; Sat, 25 Jan 2020 00:14:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=gmx.net header.i=@gmx.net header.b="bkvyLDV3"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387425AbgAYAOP (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 24 Jan 2020 19:14:15 -0500
Received: from mout.gmx.net ([212.227.15.18]:56979 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729236AbgAYAOO (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 24 Jan 2020 19:14:14 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1579911249;
        bh=cPdnxlNNk3f00HEILsbXoLfzBaz7b1Kqy6FlO9+ZmwA=;
        h=X-UI-Sender-Class:Date:From:To:cc:Subject:In-Reply-To:References;
        b=bkvyLDV3FPDfzJE+dhcYqqxZ2OTDQNkGCpXQU2LgeZbAaqgegM8QuaSb5gbnpKDE3
         DjKuZzXnTippK66ZuQ7BDsdbosqgjFX8YwajMbMAmOzQvFD12ChJmu6liSKevmlrU2
         yHuR/iE8QEPKeE6djKpAunLxRpZzD70kbKUCUf6M=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [192.168.0.213] ([37.201.195.152]) by mail.gmx.com (mrgmx004
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1M2f9h-1itDgN3DrT-0048BG; Sat, 25
 Jan 2020 01:14:08 +0100
Date:   Sat, 25 Jan 2020 01:13:52 +0100 (CET)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@gitforwindows.org
To:     Yang Zhao <yang.zhao@skyboxlabs.com>
cc:     Junio C Hamano <gitster@pobox.com>,
        =?UTF-8?Q?SZEDER_G=C3=A1bor?= <szeder.dev@gmail.com>,
        Git Users <git@vger.kernel.org>
Subject: Re: What's cooking in git.git (Jan 2020, #04; Wed, 22)
In-Reply-To: <CABvFv3+OfzK_2Wo97dusaj5nomSJTNghJHJa3=+HKH=-Sw12qQ@mail.gmail.com>
Message-ID: <nycvar.QRO.7.76.6.2001250112171.46@tvgsbejvaqbjf.bet>
References: <xmqqr1zr5e5e.fsf@gitster-ct.c.googlers.com> <20200122235333.GA6837@szeder.dev> <xmqqftg6671g.fsf@gitster-ct.c.googlers.com> <20200123141626.GB6837@szeder.dev> <20200123175645.GF6837@szeder.dev> <xmqq8slx51zu.fsf@gitster-ct.c.googlers.com>
 <CABvFv3+OfzK_2Wo97dusaj5nomSJTNghJHJa3=+HKH=-Sw12qQ@mail.gmail.com>
User-Agent: Alpine 2.21.1 (DEB 209 2017-03-23)
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="8323328-1503072076-1579911249=:46"
X-Provags-ID: V03:K1:TKRMu8kmpQtnm18yuofLkxNnKdmyck8jcfSW+ksTcL3Y3tpX7oV
 ov2g8pq3teFUkp1592Suzp7jq+rKzbPinwdA/zoy7S9yyY7/TJ5NKr9cdsGJhIIiIpEQmjV
 xW8A6ywGvcJ3O8spEzron8vntpeCj3JxqMFW8ChELL5vnE5Owgt3eAJOKTmHSH7tk33VGgU
 hy4p0upWJa6GCWuY8LTKw==
X-UI-Out-Filterresults: notjunk:1;V03:K0:yVFwjoNu4uA=:UmyNmBWPMEvpq8d2PCSmSZ
 tyxyjobeiyi5yMIcYFKa45MEkodjG3TndX1imK3sZJoBdfdDHbPVo6f9yEVH5hayM/ji5P07O
 jtnFeV06gXSip4iI2Hv1UVsDGpdiTtC0IgipNYNXaJzLQJHulIG/Yz8UO3EFUgf2FxQcgnpO/
 /iptNgxIREBSCTwz/AtN40IxSfV3TUBSxpTvfgNraPpT2OX3m/LaKTLYVMwBrTLf2edbqwPiQ
 0/TYWyi2t+EDQupI2zdtgosFn4KRkby460NgVsBr1twVvNYDxjJ/8zXg/gd53Pr2G4eLP8o6w
 u/UHF2mPlwJMuus77Qa1sj7/FOqF639SnRk/AFDacbqEDjszY4eYT6JWESdz9zT+1bdxcNltx
 byDE5jgd8DWIK/BImwY7AN9VWXgcKePlDEzQKOEqEdd+ihxq90f9+AeJSIBlphaUVD5LNptxT
 wuoqGiVXMiH0U8RkBtThjXJOmDMUVTYwIOgGXMs1nWiwi7Pp3867wnOdAewXuXAt4CE2MHDwv
 Qi3nxIDY6VQll922ptpSnPvOim5xp09H7D7z5wCc7jRLny0RA9qd8v1NFtF2NjZY+RQVKcD6+
 hmAgixBvNda0cOQrI28Gfv3/HGa668VAIgyzF4u+PZ03JaBiCL2EYnynXmFrx24Q60snqK0Fr
 on+PexNa3aCglgzusKwi7BuhJZGz0k3peM7qaesg9oouIL0mffxqJesD17mX46WvuI4Bvh83K
 dW43y5888SzVbXLTaYEqr+9RiFRFMSmOBV0a5R3SZ/eKs64WsjqVQbYrHP/pZWaDTjbJtUfVj
 xpiLgKvNafiaKQFQNxtQWh69PgFdkcvoG37OtMlFLHwoMi+qwwTEbtEGUajuxhgZJ+n/0qd0X
 RxgoYz8lGJqnHVNJbwjC/c03xg2mkb+d2OUi4HieDcsLpclJkN2SSDYUMqP9s5NvUbdMIOAxK
 v7vFyt154ggJaPlXkic3HCZTF7p8YvipU9Jg7eICefohBLHdPeIpu/B36BhD8DL8gLIczp4zV
 ln0xbsPjwREWXCC6KP0o3FX523LRzynAh0Si23/e6lrTS3QaxcoCZ0Ruho6RYJbggYRfGedyE
 Ph7zzaKPHAm+8dP/qt3AgW+XHfPkD3AA6HM0qplwOILv7mefUursXAhdNVPp2rEkSR6sUNQaY
 GAGsxMqs1afdVxIrOtZ5Y111YXM/aTDlwAKxNFAeEMRM/6BfLljZ2xC5d8n6N0vc6l4XHKikx
 s3ymkzQFtlGDyIaC9
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323328-1503072076-1579911249=:46
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Hi yang,

On Fri, 24 Jan 2020, Yang Zhao wrote:

> On Thu, Jan 23, 2020 at 12:52 PM Junio C Hamano <gitster@pobox.com> wrot=
e:
> >
> > SZEDER G=C3=A1bor <szeder.dev@gmail.com> writes:
> >
> > > Replacing that last patch of the series with the diff below works bo=
th
> > > on Linux and macOS and both on Travis CI and Azure Pipelines.
> > >...
> >
> > Yang, care to do the honors to wrap it up with summary of the
> > decisions as a replacement patch for the last step?
>
> I've done a new rebase on master, did the CI change as discussed, and
> pushed the changes to the GitHub PR
> (https://github.com/git/git/pull/673). osx-gcc test seems to have
> failed something unrelated to these changes, but everything else still
> passes.

This is our good old friend, the flaky test case

	t5516.81 deny fetch unreachable SHA1, allowtipsha1inwant=3Dfalse

It has been discussed before, and it seems that G=C3=A1bor has a patch tha=
t
works, but that he is not completely happy with, yet.

I restarted the job, it should turn green in about 20-25 minutes.

Thanks,
Dscho

>
> The changes I've had to make to make it merge were minimal. I can send
> a new revision to the list later today if that's more convenient.
>
> Thanks,
> --
> yang
>

--8323328-1503072076-1579911249=:46--
