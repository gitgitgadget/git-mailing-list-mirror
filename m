Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1C4CFC433EF
	for <git@archiver.kernel.org>; Mon, 22 Nov 2021 11:45:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239129AbhKVLsF (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 22 Nov 2021 06:48:05 -0500
Received: from mout.gmx.net ([212.227.15.19]:51459 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S237014AbhKVLsE (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 22 Nov 2021 06:48:04 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1637581480;
        bh=zc8fnnycrgvn6/Bn3SScgiwjmAJ9TIbjbhnh4HVw35c=;
        h=X-UI-Sender-Class:Date:From:To:cc:Subject:In-Reply-To:References;
        b=ZPYr2dcisnB+M+ddyQby7BLh7JX8Z0lUGciqmy9gbcvV1ukXqMU4ElhoTVLhYIB7m
         winxfPIhtINdpC4qV07HaYOqN/jeSJyAlIjB24R0AabmdhxpIOBKx91k3gEW63Jj8D
         00a8TbB4viVRDHpf3HD9SQtTr+lMxr491tAA4blw=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [172.19.219.221] ([89.1.212.219]) by mail.gmx.net (mrgmx005
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1N8XPn-1mbdKj1VdB-014Rkx; Mon, 22
 Nov 2021 12:44:40 +0100
Date:   Mon, 22 Nov 2021 12:44:37 +0100 (CET)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@gitforwindows.org
To:     Junio C Hamano <gitster@pobox.com>
cc:     "brian m. carlson" <sandals@crustytoothpaste.net>,
        git@vger.kernel.org,
        =?UTF-8?Q?Carlo_Marcelo_Arenas_Bel=C3=B3n?= <carenas@gmail.com>,
        =?UTF-8?Q?=C3=86var_Arnfj=C3=B6r=C3=B0_Bjarmason?= 
        <avarab@gmail.com>, Jeff King <peff@peff.net>
Subject: Re: [PATCH 1/1] git-compat-util: add a test balloon for C99
 support
In-Reply-To: <xmqqk0h7423v.fsf@gitster.g>
Message-ID: <nycvar.QRO.7.76.6.2111221242320.63@tvgsbejvaqbjf.bet>
References: <20211114211622.1465981-1-sandals@crustytoothpaste.net> <20211114211622.1465981-2-sandals@crustytoothpaste.net> <nycvar.QRO.7.76.6.2111161129120.21127@tvgsbejvaqbjf.bet> <xmqqk0h7423v.fsf@gitster.g>
User-Agent: Alpine 2.21.1 (DEB 209 2017-03-23)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K1:i878/0lqznpIVnBNPFVs2Fjv5DOfDO5rK9dM+RXOYSz1uQxS7JO
 F5Jt1vqTgpZfUFJHzDBpBrFciy/arrQ29AekZHgS3T7xW/0uzwAYJ0a1MPCqEVbQEtiy+AY
 iJKgPzdF6Ui+o+Bk9aSGfxEpKTuREF61zut6TYG6/oz1PobxwdoIsde35HKf1VQyvIhbf1Q
 490lnnrBwFrO8WBeae3Bw==
X-UI-Out-Filterresults: notjunk:1;V03:K0:aQE0M7IS6Eo=:V2OWkdNrklsKJTALmRnINk
 RZAqmx6s8UKuPpzU/6KctXoi9E3vMCI0mLTLVZdHxTkUam01dbsxaGVceAkV8Za/u7jtX4mlm
 v+bXM9KkYM8V0foCDv6xCrEFQeS5RYg/3OrWJ8bpUhCcgMMjjm8ZwHaw+BrM4JkxvPTwh+dos
 dHD0l8WouWnRgoVKA3WUu7pTbqyOfFvqvBJK7Fw/OvAiGbG6OSzzYhvaPMOjsQe4GYfVCVxix
 5RpOWLMgquq+3v/XNxGgZyldYQGI+tAkJGHA9eDInbxhIB8JKcwt3YcHhXqsfY3PfzVVwtcGH
 QmzL3kZk8smZpuk272+y+xXNi1BcQGriyd9eT61MWRfCNKBgZx5o6ruaBz71/uJnWe7ITnj4m
 LzhYHiileayuCuN20/P9b73Or3lS3oKTn5PjmswhcUjm0UAlrr9QurIfWRhN2B/Md6VVZ58H8
 e1F4UCLoiKXCpv6/Zl3IaXNdiaSu4mTDhKkVdXMGzbxrmSIlTzRJ3CcRwSd7SS0x33FfKyEfw
 FWJR7PMhGB+8QgjipsIk/gcET1ml7Npc1RIjiW/Uxzfv7FmH7CkpboNGbpMavGGNNtIVJmhTs
 moljvn5t6qN2YNb7ERdTIaSBtXnbME1Smqwz+dkvzugWPgkJehUNbYIAd2PGGwLirfN4WRsm+
 /yRmEQfW0UjDlMHShGwbPN9eo2IxSqNh8hnwyK/XRNHj4xaLT7k0YisPQhbBMYjb3xSs/MBc6
 uD28YiSaxuB+6eZmw42G0qj5gU/bW0U49Is9jpuAhxDJl8w+gfFkw6pHKGZOgjSUABvRkIdCm
 gr9SLCvHrDw782EWE7CC30Cf2jBIj6He96hD+ObmgbTz765M4N3l9CKme2pkA4KeyygPgT5MB
 yIBHRKuhdbrX9/9UcCZyeJO0CoLb1HBecRqvuKe4kdCM5W0Zsn2B6IOZy9d+7aRWSuIwP63vY
 R1FV3gnIdp7/ECJfsQCBCXuON3k9ECJrZRtxvldefqPLp+ig71kHNGpGMNpZaKtK+jfU9ri9q
 pH2Ddtb0rgyGruPvyW2dW82wZHw7I7A3R4sJzy7fygKWSMQNu62ZwF8dh5+0+h8RW3d15n5ZL
 Fpso1UvOR9RtMk=
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Junio & brian,

On Wed, 17 Nov 2021, Junio C Hamano wrote:

> Johannes Schindelin <Johannes.Schindelin@gmx.de> writes:
>
> >> Even MSVC, long a holdout against modern C, now supports both C11 and
> >> C17 with an appropriate update.  Moreover, even if people are using a=
n
> >> older version of MSVC on these systems, they will generally need some
> >> implementation of the standard Unix utilities for the testsuite, and =
GNU
> >> coreutils, the most common option, has required C99 since 2009.
> >> Therefore, we can safely assume that a suitable version of GCC or cla=
ng
> >> is available to users even if their version of MSVC is not sufficient=
ly
> >> capable.
> >
> > I am all in favor of this patch!
>
> I like the direction, but ...
>
> >> diff --git a/Makefile b/Makefile
> >> index 12be39ac49..22d9e67542 100644
> >> --- a/Makefile
> >> +++ b/Makefile
> >> @@ -1204,7 +1204,7 @@ endif
> >>  # Set CFLAGS, LDFLAGS and other *FLAGS variables. These might be
> >>  # tweaked by config.* below as well as the command-line, both of
> >>  # which'll override these defaults.
> >> -CFLAGS =3D -g -O2 -Wall
> >> +CFLAGS =3D -g -O2 -Wall -std=3Dgnu99
>
> ... as has been already pointed out, this part probably should not
> be there.  It is not our intention to require gcc/clang, or to
> constrain newer systems to gnu99.

Another data point in favor of dropping this: our FreeBSD CI build reports
a compile error with this:

	[...]
	archive.c:337:35: error: '_Generic' is a C11 extension
	[-Werror,-Wc11-extensions]
			strbuf_addstr(&path_in_archive, basename(path));
							^
	/usr/include/libgen.h:61:21: note: expanded from macro 'basename'
	#define basename(x)     __generic(x, const char *, __old_basename, basena=
me)(x)
				^
	/usr/include/sys/cdefs.h:329:2: note: expanded from macro '__generic'
		_Generic(expr, t: yes, default: no)
		^
	1 error generated.

I verified in https://github.com/gitgitgadget/git/pull/1082 that this
patch is indeed the cause of this compile error.

Ciao,
Dscho
