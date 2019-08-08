Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.4 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 054721F732
	for <e@80x24.org>; Thu,  8 Aug 2019 20:18:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2404575AbfHHUSN (ORCPT <rfc822;e@80x24.org>);
        Thu, 8 Aug 2019 16:18:13 -0400
Received: from mout.gmx.net ([212.227.17.22]:33985 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2404324AbfHHUSM (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 8 Aug 2019 16:18:12 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1565295486;
        bh=CpgeFO8rF3ti2Lip4630QIjQLRpTwSCBNg/4zPiNRdQ=;
        h=X-UI-Sender-Class:Date:From:To:cc:Subject:In-Reply-To:References;
        b=E+zg6SMsEW4cmSRZLjB7TrVAfvyVt7YCihPgo4IxiI8pmjGUYh6a2PCcre02cziJ7
         26U+t5VxIjpQbur6s8tzJqVDNdfIzTQGxiahuVnUNpN7ge8Aar6y9XYw8iWS78W2zj
         haYG2Ihv097gldoiiCHgNS3qNPVJOeIgDKE2onis=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [192.168.0.213] ([37.201.192.51]) by mail.gmx.com (mrgmx103
 [212.227.17.168]) with ESMTPSA (Nemesis) id 0MWCKz-1hpcd23O4v-00XOuP; Thu, 08
 Aug 2019 22:18:05 +0200
Date:   Thu, 8 Aug 2019 22:18:05 +0200 (CEST)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@gitforwindows.org
To:     =?UTF-8?Q?Ren=C3=A9_Scharfe?= <l.s.r@web.de>
cc:     Carlo Arenas <carenas@gmail.com>, git@vger.kernel.org,
        gitster@pobox.com, avarab@gmail.com, michal.kiedrowicz@gmail.com
Subject: Re: [RFC PATCH v3 2/3] grep: make PCRE2 aware of custom allocator
In-Reply-To: <7f42007f-911b-c570-17f6-1c6af0429586@web.de>
Message-ID: <nycvar.QRO.7.76.6.1908082213400.46@tvgsbejvaqbjf.bet>
References: <20190806085014.47776-1-carenas@gmail.com> <20190806163658.66932-1-carenas@gmail.com> <20190806163658.66932-3-carenas@gmail.com> <ab8a378c-0a60-9554-b2dd-ecb3d05229cb@web.de> <CAPUEspip98Mq8FrKTOkEikZhaLPprZXf=E2x3d0b7=c7e5+Gyw@mail.gmail.com>
 <c7f08e19-88a7-ca7f-90b9-54465e621d49@web.de> <CAPUEspj4CrEk6u4+8a5UBisxWsXcwOrOPQ5s9TktA6dZx5s+uQ@mail.gmail.com> <f6056e0c-fe7f-30b3-c2d7-bba2b44d6888@web.de> <CAPUEspi2vu=7uLU19c-wcW+ji63gyeO7poAwS5_7ZhTiBWSxjg@mail.gmail.com>
 <7f42007f-911b-c570-17f6-1c6af0429586@web.de>
User-Agent: Alpine 2.21.1 (DEB 209 2017-03-23)
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="8323328-1859688066-1565295487=:46"
X-Provags-ID: V03:K1:fc2JOt7cwsjEZ1ddfZhAgA+ZkW4YDfvKXE95L0fElZyDrx+Ngp+
 LxSpEn34DK+IwLk7rqSF/6H2ZzyhrYmS02MUnSLb7jkb3aMV3xtVGo/tQnu/KFz2c/QSod0
 TCm8CG2PTv6DxLdZ0S/RY5kmyhYdGqTKoFgB4JuboJmUY2MkrhP8Wf7+AaAhP5pJY1FhF7N
 SbIvfFl6NdE6cCxofBMeg==
X-UI-Out-Filterresults: notjunk:1;V03:K0:Le7P9ORiiI8=:gq9GqZytcbGcwi7XHRM6Rc
 YgGztwhgAnkv/NvBkuX08J0qrNsOXApgQlyWnr/rbxR0NmpiO5/aJduj0MGmmqfRdKD8i9RwV
 ogCnwrBFUwfLL5/IINl53owZtdOmGUohQ0fhYC1JFmwh4eEWqqFYyDJJn1E1XQIU8g3gto9TY
 M91i9/k/tIEQGYJmsa/DGkifnxUXp85KpYpbsGJRyIj6tgjPK3PBZe8VjHcZtIwQxALSpKOvZ
 8XGvqvZs6XX2Q53KJcuhvgsHRyJ41vTQ4EXC5N/jRh2ctF3s8YfYZydDfiyQwyp8DND5R83JH
 c78Gz/lMLyQw7wxv413jF46capXBhW7b1GH/6DJrc0ItMTbgtLY0T5LFaxmuylgSNU/eCPPH0
 a60dCl7XczamcP1u6d86m/VePRtH7Ai8Ub4Jm+g2z4NEiCUOFAgSWobtq5wOAeNANrEaFD8Bo
 3NFAQfRhH8J80LYiLUpboBVG0BQyTzOvCPUzKn5cew4nTWi3LVqcKzJ/wXTU3+cLad0g41xO3
 OhKEsklKNtgKsvb4ZsNJdqHgzAKh02MakqQo461wHjlUVhLRALEnKqSpm0aH9pLW9+9CJmH+K
 DO6/+RljYEmLNk3TObVqMjDCMEwcpWYKk/aHpBO2HY1HTQc/xY0WpepcQmf8UPWu70MGdR1/y
 ATFS9NJ3D0sXgRkVyL8J2oWKyLPVozX7sgdRsCuHiyDRcsEUYRJ3YrIG44CWQQD2XQq/kb3XJ
 WmsEccN59IaL0vRIzSmzra38R4e+v4DU4b7QUwxRMvB0JzDvUUjWGxadDjEuixw7jkLNcly4s
 Tg/UtIIoaMk7h+s+EFfWIyl1uRuC37HEHXy0SnG9FJ1B+Y9jV9XCNtbmLaY7kQeINzV+mTDM1
 X7YYpZWAnsYQLz9STYXewvuOENmGIV8Vz5YOiVVGJ25s2QuNUl4bpYyS8HIVKSdDUOuQVuvYu
 bAb3fTJZ604rLJrkZsfY5MSP3fAGXOLMVx2QU/NPX9/U9gNMTdQMZ8EIXUIBoK36ewLSmFtxR
 kuu7XOsKZPUUnzI8ur+GI7XynHYMpNCgxCU8yVMBT33iU82DtuzF2hZVl3xSuKPcGYwZ6nSEy
 dbhobAbZKgxE8822K2q5rusgcZ1B2cQV8dFglsgNz41DX6gm+UktdbPZDnHlkiYhyXT5u+JY9
 FUxV4=
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323328-1859688066-1565295487=:46
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Hi Ren=C3=A9,

On Thu, 8 Aug 2019, Ren=C3=A9 Scharfe wrote:

> Importing the latest version of nedmalloc might make sense in general.
> The last commit in git://github.com/ned14/nedmalloc.git was done five
> years ago; is it finished?  A diffstat with -b looks like this:
>
>  malloc.c.h  | 1193 ++++++++++++++++++++++++++++-------------
>  nedmalloc.c | 1720 ++++++++++++++++++++++++++++++++++++++++++++++++++++=
+-------
>  nedmalloc.h | 1580 ++++++++++++++++++++++++++++++++++++++++++++++++++++=
=2D--
>  3 files changed, 3840 insertions(+), 653 deletions(-)
>
> Any nedmalloc fans interested in bringing the goodies hidden in there
> to Git (presumably while retaining our local fixes)?

I had looked into this already over two years ago, and had to stop after
investigating a performance regression for two weeks and not getting
anywhere.

Also, nedmalloc fell unmaintained, so I don't necessarily think that it
would be a good idea to  spend a lot of time on it.

In the meantime, there is a much more viable contender: mi-malloc.
Preliminary tests suggest that its performance on Windows is at least as
good as nedmalloc's, and Windows was the use case for which we
integrated nedmalloc into Git's compat/ in the first place.

I have tentative patches to integrate it into Git for Windows, and
basically got side-tracked with other things. Expect to see something
regarding mi-malloc from me in September.

Ciao,
Dscho

--8323328-1859688066-1565295487=:46--
