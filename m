Return-Path: <SRS0=JG/V=3O=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,MALFORMED_FREEMAIL,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 14AAAC2D0CE
	for <git@archiver.kernel.org>; Sat, 25 Jan 2020 00:35:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CD88D20709
	for <git@archiver.kernel.org>; Sat, 25 Jan 2020 00:35:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=gmx.net header.i=@gmx.net header.b="abM0HYf5"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729578AbgAYAf2 (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 24 Jan 2020 19:35:28 -0500
Received: from mout.gmx.net ([212.227.15.18]:58093 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729147AbgAYAf1 (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 24 Jan 2020 19:35:27 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1579912520;
        bh=eAB3WBEpUvligLixJREuF6HepFk9K3dpktPTdDMnlVg=;
        h=X-UI-Sender-Class:Date:From:To:cc:Subject:In-Reply-To:References;
        b=abM0HYf5M/3GL4as9Egydwf8owHQ9OuysoP2BRno+bbfp2fkF0ckJo+Bqog/feXua
         qkbyiVdOzR5HoFIxevn2jvPeEtfLbNtmcWoEMpXLKkjiVY0SzF6WQ53OcxC7ff6v9g
         lVLTpiA8wRpbrE8LGg+ABhd2tvMsganB2poR3gXY=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [192.168.0.213] ([37.201.195.152]) by mail.gmx.com (mrgmx004
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1MYNJg-1j7vFt35IQ-00VTmw; Sat, 25
 Jan 2020 01:35:19 +0100
Date:   Sat, 25 Jan 2020 01:35:03 +0100 (CET)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@gitforwindows.org
To:     =?UTF-8?Q?SZEDER_G=C3=A1bor?= <szeder.dev@gmail.com>
cc:     Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org,
        Yang Zhao <yang.zhao@skyboxlabs.com>
Subject: Re: What's cooking in git.git (Jan 2020, #04; Wed, 22)
In-Reply-To: <20200124120240.GG6837@szeder.dev>
Message-ID: <nycvar.QRO.7.76.6.2001250133510.46@tvgsbejvaqbjf.bet>
References: <xmqqr1zr5e5e.fsf@gitster-ct.c.googlers.com> <20200122235333.GA6837@szeder.dev> <xmqqftg6671g.fsf@gitster-ct.c.googlers.com> <20200123141626.GB6837@szeder.dev> <20200123175645.GF6837@szeder.dev> <nycvar.QRO.7.76.6.2001232237590.46@tvgsbejvaqbjf.bet>
 <20200124120240.GG6837@szeder.dev>
User-Agent: Alpine 2.21.1 (DEB 209 2017-03-23)
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="8323328-2123277827-1579912520=:46"
X-Provags-ID: V03:K1:utQ2tcjwSaFau47r3YTaVzwCURwZ9u5VFq2Ig8V0qFu3ePp2wrc
 OdEZYKRuNlCcHHpPQfdXSqpkyWGh8hXbNkx8kPhfOmcwjadJoGbe1xLYvdM3Z/TWFna9Vg3
 ncejPSJP2jifCEA2vqUqAEKqvo13ogHoTFp3HPDP/4ieVK2Fn05bQMs2twFTlubcG2kNTCr
 9LmpiqsGReNfSossFKB2w==
X-UI-Out-Filterresults: notjunk:1;V03:K0:chV9LJFGjLg=:WLcwpDlfyhEJX8gF1KWdcl
 Qw4tq3tmDqL6R38iuLKRp9TIj2OoQW/t89j8XfpstmipmTT3bU6sqpwZnO/w0p0hxW5OAC9l5
 DFKAjwifGzVcXTJMn/ijhqZVbLsfeABMJzSjRjA4R5CEhwkvFucvuyNXXOSdBjlpK2JE838Vj
 TCjcWqa7JhN2st7wD5Mk5HT3Aa0f7taLEwxneSdxPRIgOPPgHSv+WoHmBi1jOMWo+EVIwB1N+
 spRWxI9JFFaOePbE1Crw1ygVK91WrgzfgKP7kcXuhZhQW5wQJY6zvuayDv9HCPVcPeprsjoyb
 zZL2KyHP2qo+YgBmNw3qftFE3SUFPTBh47x+6e6ZWa4VFGaeRhp3UJYqk7VyQTJy4uZj2Gqpl
 CcGsLkA5wTXWWkUXscWr9l9ZT2FP81hFsIl8Zo5h3UJpg8C/2NmZkn5tEqZ/l506iyAHD4m2o
 8JnyIGSltlPlvzUAvtfr+UFBuuCk8T9zMWZpciBnAbH9e5BNM0/dt0wb9wCnJKUXVxZ0mBAoY
 0GkAy6fUBjfebPW9eYmaUPnd/LMKPlyeoooInAq2FM0y1ztmgZoCF1X1ExO6e2MdWQmY1MKFn
 vV+HR6GSzcgwDJLKAQEAOfr2TE48KbalfE9bJQrgh+i9gf8a8xmJCu+xFy8LM8Ayq1hbErq2C
 KYocH/vdfXxwGl3nPFIofiMb6j9msXSL6tFBxzAa7YFSNCIm26ieRo2mBbQUz8Y0ZYs2nPHO2
 N3UeGfFNqvWO4KYXrZxB6px4VnR2uTzYN4BPomiqWKwSvG+HypAFbL+7IwKjtmKXoDluL6MVz
 7CZ09uQm0Fucg+nABi750Remsx9uxRdNJ2bQsfBiOK0I4g0mEt7Du1d8f4rSbos5LcrErVYA3
 ff7ziBeyjLIQqrBLYE2Cq9OYW18tvjRin+M2X3iuFQe+FWTH+nUUTPGKbJVmSmY7wlsypnXRA
 FzV+KJtqG7Vab1AcUTtfUs+P9cshGx49QQhJyXEMB6OgCuMvt7kvNzZlTF91XaU/TZEtkbXEz
 JLnjWAP8etNvxVnQ8gZUk1B0O/YurSRcm6TXqQQNLMenEUmlWKvTh2oTthzzbVNvj8u4LTcNn
 uuSoAaYCgPfqjWPGV+sW7CL3pTbxEgCCwggyLUr3W84MMQ1DxhtyztTFNpdTqN5Sm+ZoBoPsE
 p9I9ClA437ijtoF508XM/iKQax3nGW4C7P1QGtI3HJ0/V396GuWI+OvGUxhBaT9mI0HvwZuTp
 nlN3vbQ10mpGnaUmI
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323328-2123277827-1579912520=:46
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Hi G=C3=A1bor,

On Fri, 24 Jan 2020, SZEDER G=C3=A1bor wrote:

> On Thu, Jan 23, 2020 at 10:39:12PM +0100, Johannes Schindelin wrote:
> > > diff --git a/ci/lib.sh b/ci/lib.sh
> > > index a90d0dc0fd..c3a8cd2104 100755
> > > --- a/ci/lib.sh
> > > +++ b/ci/lib.sh
> > > @@ -162,6 +162,9 @@ linux-clang|linux-gcc)
> > >  	if [ "$jobname" =3D linux-gcc ]
> > >  	then
> > >  		export CC=3Dgcc-8
> > > +		MAKEFLAGS=3D"$MAKEFLAGS PYTHON_PATH=3D$(which python3)"
> > > +	else
> > > +		MAKEFLAGS=3D"$MAKEFLAGS PYTHON_PATH=3D$(which python2)"
> > >  	fi
> > >
> > >  	export GIT_TEST_HTTPD=3Dtrue
> > > @@ -182,6 +185,9 @@ osx-clang|osx-gcc)
> > >  	if [ "$jobname" =3D osx-gcc ]
> > >  	then
> > >  		export CC=3Dgcc-9
> > > +		MAKEFLAGS=3D"$MAKEFLAGS PYTHON_PATH=3D$(which python3)"
> > > +	else
> > > +		MAKEFLAGS=3D"$MAKEFLAGS PYTHON_PATH=3D$(which python2)"
> > >  	fi
> > >
> > >  	# t9810 occasionally fails on Travis CI OS X
> >
> > My only worry is that this makes it even more obscure what purpose whi=
ch
> > job has. Nothing in the name `osx-gcc` shouts loudly "I want to use Py=
thon
> > 3.x!" to me.
>
> Do they have to shout that loudly in the name?
>
> We could rename these jobs to e.g. 'linux-clang-py2' and the like, but
> I think it would bring little benefit, if any.  In our Travis CI
> builds these Linux/OSX Clang/GCC jobs come from the build matrix,
> therefore the jobname is not visible on the Travis CI web interface or
> API, only in the build logs.  There are some pages on Azure Pipelines
> that do show the jobname (and some that could, but hide it instead),
> but it's just too convoluted (or sometimes even impossible, well, for
> me anyway) to get there.
>
> And if the requested Python binary can't be found, which will
> eventually happen with 'python2', then the non-zero exit code of
> 'which' will abort the build, no matter how the job is called.

I am mostly worried about contributors whose PRs break for "magic"
reasons. If it is not clear where the difference between `linux-gcc` and
`linux-clang` lies, that can cause unintended frustration, and I do not
want to cause that.

Ciao,
Dscho

--8323328-2123277827-1579912520=:46--
