Return-Path: <SRS0=G+lC=4P=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,MALFORMED_FREEMAIL,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F1952C4BA2D
	for <git@archiver.kernel.org>; Thu, 27 Feb 2020 13:25:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BC8CC2469D
	for <git@archiver.kernel.org>; Thu, 27 Feb 2020 13:25:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=gmx.net header.i=@gmx.net header.b="d2bnzZto"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729178AbgB0NZG (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 27 Feb 2020 08:25:06 -0500
Received: from mout.gmx.net ([212.227.17.21]:44089 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729056AbgB0NZF (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 27 Feb 2020 08:25:05 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1582809898;
        bh=jkr4RoVTwMrCcCqpUqK4vh6ls5lTBTdjpLWXenT0jaI=;
        h=X-UI-Sender-Class:Date:From:To:cc:Subject:In-Reply-To:References;
        b=d2bnzZtopkzzU/d7Q8k7kczrAXXuPmsWC0MMqssZOPTh1Fzcq0tRqyvNdbAmjdZV4
         yzINT6LYVeFESHyc/13YSb26h51TXXqu5PMlyfthJKWkXcYP8rIYIuOnqNB1lThzBb
         1ivux8z9pfslL0+bvbnubY10wZMK2og1YZ980vzc=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [192.168.0.213] ([37.201.195.86]) by mail.gmx.com (mrgmx105
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1Mg6dy-1jcXyh3SDW-00hbu9; Thu, 27
 Feb 2020 14:24:57 +0100
Date:   Thu, 27 Feb 2020 14:24:56 +0100 (CET)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@gitforwindows.org
To:     "brian m. carlson" <sandals@crustytoothpaste.net>
cc:     git@vger.kernel.org
Subject: Re: [PATCH v2 18/24] gpg-interface: improve interface for parsing
 tags
In-Reply-To: <20200226022332.GB7911@camp.crustytoothpaste.net>
Message-ID: <nycvar.QRO.7.76.6.2002271423580.46@tvgsbejvaqbjf.bet>
References: <20200222201749.937983-1-sandals@crustytoothpaste.net> <20200222201749.937983-19-sandals@crustytoothpaste.net> <nycvar.QRO.7.76.6.2002251127320.46@tvgsbejvaqbjf.bet> <20200226022332.GB7911@camp.crustytoothpaste.net>
User-Agent: Alpine 2.21.1 (DEB 209 2017-03-23)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K1:+due9HLFRWIGGag+SC+hQOy9y+dMrz7ty6EO8YFqam/qXFL3Jy1
 T3KkIdgGCxyRLc+VbfOze5f5tv/t4WvLC1j4UsXGNY0bt94IYlD0R00Hk+u70Fru1AUR+uA
 PEeEhErQLCSjlVEYEFPINFPdzyvEJbbyIHLZS5MEQopsIHPJhzg9RhxKJsDXYc4p95LQo1w
 8U9KYgoG7NoOgyJ0wTtPw==
X-UI-Out-Filterresults: notjunk:1;V03:K0:oKVna1cE9GY=:eNOBtv62vHj0gVMwTUjqEl
 /tZrQxOi18995kmqJSdmEk4R/Vi+I8fLYjdTrVQmdAL7EQMIRUM1WoqWXnoAaku3u4ROKBUa0
 R1HDBZgooV4CLCG/l5TkQz5ScGScC0kBMoH79gS/7Qjx142Iw5O4DPrXHvIxN2soTqC1dq+OV
 dC7YANBXcWe600rLBL5CBBdOpdR9cZwzsRveWYNqPmMRohNBsAtfQIbWDzxChoIctf6vyDTB5
 qHfgE0R9Fj2i5KATC6DiagAFzti7srdCxw4FRHOLgHyjnIHX04kjjbb51tiXgLtAlBSRdV2tk
 ZKl4uT3KL38DMxaWerIpCMVo1j2kUDoSMT2SNBh/DPIF1pGpWcNUbbeAPyuMFd01Xr7GfOkYD
 MwSQLfPGpVrLzLUjgkizC2PhtIrA1+ii2IwWVt8lt+NFQnIUhbZ56KF/ueFK4JhA0hRU9bq7d
 JpHCFCiGQca/O5PV4RAJBiOTG+CPnnQFKhX+3iVGLyEsmFeHpuCkVZvvH/jIEbc3Fghu4K8Kz
 Zp4BZiSG3fMyQU2P8nab8oadxIvkGkDgq5TI0ah02mAA4rw4vJOyoU29CgACr/RSEIaaaCyMX
 TjxO2aFG+Tfu6YcFkci7KlLHrZ3lusBKecepYzqRqisKOz0/1gdkLpGcfZ2c9cNpFOC63xiHi
 +IKIoa7mhVU5SFQXDUxYrDdGj78J2uF2cV5OjU7n+CXUY6fSGDkbp+dsIGX05QxfgWJUk5eI7
 TVYO+RJULHXg/yzgsKQvbI07yec3ddpOzh6uATMxOQjrG945UMY1XHcW1nhriA5E4gEsvgMBd
 caa0k587wkojf2vsBelbPS3M2HcWsIw6xK3y4DEgI3nE+s4q+4Zc8opP9xI61jAdoSkTj6M95
 z5YlYCh3i2qz1fsHHhhMUn9STKlA9NvyYVDyy3kSFjBK+5dwSDptPOkgSLGaLk+997UOLC5Lr
 /ZgCKfj6L0L9PKN8CYWDlXApkiR2SlFW/5uLxyqWEYUdqfDf+iiznzsFpy8fVM/+DwFpw2mRE
 GLmP2UFmjlcKnVNJGJ/p3hhte3+VBDCqOXDoZrsROzf0c6f3Se0IA14f1Y6dyAHDb0V+pJtM6
 EFf8tSsKTyPQbALXf+VpxnkowHgXGtLVHvNiGcivF/OKVtvweQAYuAxHXSkpdPHBUjnLQefp0
 Q0oU4NDvIcNDAgZEPgVKEhW2+6BZy18NttwYigzVLRJSIwf3K+SG8FGI+NLrlY48UMEwbYFht
 gMJONKkckdvlw2xH8
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi brian,

On Wed, 26 Feb 2020, brian m. carlson wrote:

> On 2020-02-25 at 10:29:26, Johannes Schindelin wrote:
> >
> > On Sat, 22 Feb 2020, brian m. carlson wrote:
> >
> > > diff --git a/ref-filter.c b/ref-filter.c
> > > index 6867e33648..212f1165bb 100644
> > > --- a/ref-filter.c
> > > +++ b/ref-filter.c
> > > @@ -1161,7 +1161,13 @@ static void find_subpos(const char *buf,
> > >  			unsigned long *nonsiglen,
> > >  			const char **sig, unsigned long *siglen)
> > >  {
> > > +	struct strbuf payload =3D STRBUF_INIT;
> > > +	struct strbuf signature =3D STRBUF_INIT;
> > >  	const char *eol;
> > > +	const char *end =3D buf + strlen(buf);
> > > +	const char *sigstart;
> > > +
> > > +
> > >  	/* skip past header until we hit empty line */
> > >  	while (*buf && *buf !=3D '\n') {
> > >  		eol =3D strchrnul(buf, '\n');
> > > @@ -1174,13 +1180,14 @@ static void find_subpos(const char *buf,
> > >  		buf++;
> > >
> > >  	/* parse signature first; we might not even have a subject line */
> > > -	*sig =3D buf + parse_signature(buf, strlen(buf));
> > > -	*siglen =3D strlen(*sig);
> > > +	parse_signature(buf, end - buf, &payload, &signature);
> > > +	*sig =3D strbuf_detach(&signature, siglen);
> >
> > While I like the spirit of this patch, it makes the Windows build fail=
. I
> > put this on top of Git for Windows' `shears/pu` branch to fix it (mayb=
e
> > you could adopt a variation of it?):
>
> I'm happy to squash this in.  Sorry for the breakage, and thanks for
> catching this.

You're welcome, but credit for catching it should go to Azure Pipelines
;-)

To be honest, I am rather happy how these CI builds help us catch things
already when they are in `pu`. _Quite_ happy.

Ciao,
Dscho
