Return-Path: <SRS0=ZAU+=3M=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MALFORMED_FREEMAIL,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3BCC2C2D0DB
	for <git@archiver.kernel.org>; Thu, 23 Jan 2020 11:57:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 03AB320704
	for <git@archiver.kernel.org>; Thu, 23 Jan 2020 11:57:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=gmx.net header.i=@gmx.net header.b="NJ4U3BlS"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728811AbgAWL5E (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 23 Jan 2020 06:57:04 -0500
Received: from mout.gmx.net ([212.227.17.22]:51827 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726219AbgAWL5D (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 23 Jan 2020 06:57:03 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1579780617;
        bh=BhclckR51x1yIwTfrxV/MArKJcccI1ZjUoA6/HdMjFo=;
        h=X-UI-Sender-Class:Date:From:To:cc:Subject:In-Reply-To:References;
        b=NJ4U3BlS+rnsrisWCrGRMUwX5wy/kzskK/kX4XHQz0Z/Ub2ITQ5ISBAHmnVF2mA+8
         r0HmLd1sRnWnYXzGMwOXUn4HgG6vWDq10kT8Meo/DHJkEQztbpUYnQ7dTEWMjszOye
         qrFqB9a8S1byoxc0nD7h01pwCl6X9EhICMc7iCL4=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [192.168.0.213] ([37.201.195.152]) by mail.gmx.com (mrgmx105
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1MvK0X-1jl3Ie1tC5-00rFA3; Thu, 23
 Jan 2020 12:56:57 +0100
Date:   Thu, 23 Jan 2020 12:56:56 +0100 (CET)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@gitforwindows.org
To:     =?UTF-8?Q?SZEDER_G=C3=A1bor?= <szeder.dev@gmail.com>
cc:     Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org,
        Yang Zhao <yang.zhao@skyboxlabs.com>
Subject: Re: What's cooking in git.git (Jan 2020, #04; Wed, 22)
In-Reply-To: <20200122235333.GA6837@szeder.dev>
Message-ID: <nycvar.QRO.7.76.6.2001231256350.46@tvgsbejvaqbjf.bet>
References: <xmqqr1zr5e5e.fsf@gitster-ct.c.googlers.com> <20200122235333.GA6837@szeder.dev>
User-Agent: Alpine 2.21.1 (DEB 209 2017-03-23)
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="8323328-298893037-1579780619=:46"
X-Provags-ID: V03:K1:YpyrkEQh2dZhiigHQoHNKGXjnXe95UqHuc+7lOH0XeVgAsCUFlW
 CHUlIm/7/Ef9i30sQR420EX2jVUX8BVYENP2cliJci67hXylZgxa5TR1UE+qx5t1d1v0IN6
 hIjlpgXrY2fh13qUvv8sV4hxMVBIxZ/wnLgbU9EPe4tNYo/ySxZDFFDBZko0fyFB74WwSMK
 pgNB95PhKpYdWlzcazRww==
X-UI-Out-Filterresults: notjunk:1;V03:K0:uD1Q1IvuFnc=:KBzk/39r5XXtdQxtJDycYe
 nfB2/UYD0C3/LSLj8WjOrr6tN9+jjwunMKsnXnvR49fx91+EBxLCfm2gpHP6iRqAg3GK2SbUu
 vyR+qU5ZUbrQvoYNvJNQkR6bz0/XM959PUWJGulWeZHCj98h3ibwe3q64aNcryou2xzFTXic8
 NcG/ZwsquL8q5sq7Z8OUSTkPo2l+0lkD3AsZ6Je1+cWYQsc5PgMwWLI49cYXyPXC2XaMiWEnb
 eDHCzPEcc8cDRwptqRclSs6MEQWWO9NonaGfmijM1D4knWsehHLTPYQ9F92TuuOPEBJjMccSk
 JH2MV3CT3dH5i5FxcEBTz6HpjlsGp2LnGzHEqmfifqO7uFy6KD6tM00K5D+KcP+3BkOvPfbSa
 ZpqXMXCuA1ivWAGA6zzhw09gBuoUAcD78hmDcmDBoKl1hIgYMBZpJyWsAYWidnhkoCm4GNVi+
 d6rTtTQC/Cu33isTDYxztJOd3/QIbGN+JV4gWYVgRDyQrpJHsGp/0QMXbGOVh9JL9GD2NxcVY
 CQaKbts/Cpn411SFadKNjff0xRMqwPokwd/r3GcExEzC/IXWri40eZPXstNJDAz1Zimntobsu
 JxfqxeMRi1mEn7zxpfdhawQ0b27DORbZcX2LKzQskBOU4VlHsNnokx07jxAtEHSGfWJUbyUjh
 3SN1EtAXHIlVHR7L4RN17sna4XzWgSAuAKMjqSjuiEsqn+HwTPYhMXoIAKyNAnbhxO6D86Qx/
 B3zbbkGJhMNRiruk2qzrSCrCzB4kquuaWuJMnsDK63PgBS6/Zm4Ukbj2lSqVKJIw9r9vqHErj
 UXg8NNYS/4KU+UUZyy+5FPYGqdJt6mX9ZWW1m3TeonPgX112TPVHC+kdYjWXjBrQghd/shnR5
 qujmY1ATAWzY0dOJHEFEbHVkrZa557udn3Zlgj7kk9Ne2HBX01BcHAV8VSmX2drVav7h9f1df
 Z1VQS6UtjuZQl1ghmkqrL9exUHofnPbr+Sbd/pBO6XvjRS1e6BVC8WynFSb5vm5WLMTH8lean
 Oiw/EwAKoesUmobKR9YvYnFIM5QZ4YqYLn4604onM1LpS7x+xGHvA09bK2gJY6NbbNcWXo75f
 JkxtPRkGcuNmb/tWjFRoipieJDTctq01HuFNks83/SUYlietQtxU6OBWFiVZCOeOvuYFUr4uy
 FrzhtLOfkoTMZapG10x716rORYZRbdqxP0h/N7SeTbozy9QCWSrNIsP3gTNo2FnyZok5PCER5
 e7kz9o+EV/esuxgII
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323328-298893037-1579780619=:46
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Hi,

On Thu, 23 Jan 2020, SZEDER G=C3=A1bor wrote:

> On Wed, Jan 22, 2020 at 02:18:05PM -0800, Junio C Hamano wrote:
> > * yz/p4-py3 (2020-01-15) 14 commits
> >  - ci: also run linux-gcc pipeline with python3.5 environment
>
> I still think that this last patch needs to be reworked before this
> series is merged any further.
>
> The only Python script we have is 'git p4', so the Python version is
> only relevant for 'git p4' tests ('t98*'), while the rest of Git and
> the test suite couldn't care less [1].  This patch, however, not only
> builds Git and runs the full test suite for each of the two Python
> versions, but, worse, runs the full test suite _twice_ for each, first
> as a "regular" test run and then again with all the GIT_TEST_* knobs
> enabled.  Consequently, it adds ~50mins to every build's runtime.
>
> That's just too wasteful.
>
>
> [1] Well, there is 'contrib/svn-fe/svnrdump_sim.py' as well, but
>     that's contrib, though it is used in 't9020-remote-svn.sh'.

For what it's worth, I fully support G=C3=A1bor's assessment.

Ciao,
Dscho

>
> >  - git-p4: use python3's input() everywhere
> >  - git-p4: simplify regex pattern generation for parsing diff-tree
> >  - git-p4: use dict.items() iteration for python3 compatibility
> >  - git-p4: use functools.reduce instead of reduce
> >  - git-p4: fix freezing while waiting for fast-import progress
> >  - git-p4: use marshal format version 2 when sending to p4
> >  - git-p4: open .gitp4-usercache.txt in text mode
> >  - git-p4: convert path to unicode before processing them
> >  - git-p4: encode/decode communication with git for python3
> >  - git-p4: encode/decode communication with p4 for python3
> >  - git-p4: remove string type aliasing
> >  - git-p4: change the expansion test from basestring to list
> >  - git-p4: make python2.7 the oldest supported version
> >
> >  Update "git p4" to work with Python 3.
> >
> >  Will merge to 'next'.
>
>

--8323328-298893037-1579780619=:46--
