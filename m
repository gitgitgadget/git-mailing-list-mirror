Return-Path: <SRS0=QcP8=4I=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MALFORMED_FREEMAIL,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 26B1BC11D05
	for <git@archiver.kernel.org>; Thu, 20 Feb 2020 13:52:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EEBA320722
	for <git@archiver.kernel.org>; Thu, 20 Feb 2020 13:52:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=gmx.net header.i=@gmx.net header.b="lBBLK5MS"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728216AbgBTNwx (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 20 Feb 2020 08:52:53 -0500
Received: from mout.gmx.net ([212.227.17.20]:52485 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728177AbgBTNwx (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 20 Feb 2020 08:52:53 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1582206770;
        bh=wQiY7lBZ95oKVASPuka+t7sE5uAqsraDgmldNbs3C8I=;
        h=X-UI-Sender-Class:Date:From:To:cc:Subject:In-Reply-To:References;
        b=lBBLK5MSv3qFWwajGnrR+XZKhz1ysa++AIdptuCWbQcA6y1ZyU0bFvfkeLcx/L8LM
         b1tt1AIdEhe16AF45NYUjUEUtOuZAfg7hMJ8H8syZ0sIB4Rvk4uqonnaYHZ+ASB0vn
         OKZcXin6zntS5vHSfKHa3oirD6/RN4FrUOKVHGO8=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [192.168.0.213] ([37.201.195.86]) by mail.gmx.com (mrgmx104
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1MnJhU-1jlZFl3D2C-00jLAE; Thu, 20
 Feb 2020 14:52:49 +0100
Date:   Thu, 20 Feb 2020 14:52:47 +0100 (CET)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@gitforwindows.org
To:     Taylor Blau <me@ttaylorr.com>
cc:     Derrick Stolee <stolee@gmail.com>, Git List <git@vger.kernel.org>
Subject: Re: Git Test Coverage Report (Feb. 18, 2020)
In-Reply-To: <20200219204430.GB5101@syl.local>
Message-ID: <nycvar.QRO.7.76.6.2002201448200.46@tvgsbejvaqbjf.bet>
References: <2c97befe-9be8-9946-b643-91656fa3dcd8@gmail.com> <20200219204430.GB5101@syl.local>
User-Agent: Alpine 2.21.1 (DEB 209 2017-03-23)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K1:1bPacHdxJ7yYxISmUz60EyepbvD2MT8+kigZMcXcjzVtM3AGJP4
 mLGYC0YIYJkNNKwxkMV3kdwokjDCxo+aIaxlqOvvOhYTRH5FoD0LsFQwDX9vGZyc9BuTkzL
 jGt8haJjs0S4rn+2yQpnuMcC+YXLWO1meOsShMWj665AFiGpmE0MXkoRA3YjTSCh/AuCDZA
 1VY5AH+w8GXyb98vmxaTg==
X-UI-Out-Filterresults: notjunk:1;V03:K0:sTI0n/Hw+Pc=:Zn+T5Zt34McUIjC7xbi44+
 TzTiGnO5c01sfMmdV6jpGu5PlqcE6vqZ1obw4+mRutNtkVufIcge8DMCPhTWGkECK37FGrrOn
 qigxv7QUkbdERdfLwj/iJ0RPm0RRu4OfcKktn/9KfF/ZRkxau4dkkZ/b/7oGrPz5OXTIbt5Xv
 FY08o0HsbrAmVdOTPV0XVoy0B9MqI4z+IHw8uCIQgocOs8vMWoqhrkpunqTQOrXlFceR5I1Yj
 z83cdv0UGqBHvhp8d8y96+2ig5iJ3e+IU09gx5FVRwtmFSCLpPUEmNX7d3YrG6O+kb7DK/LSW
 jmdBkD5wF5gYGIkDjETJTchcxJNcx6XLkZIJpCwVh1w0zuwqpnL1efQjF9rhVrECrLvr/vYdq
 B2Fd/cPIXNTHPyTFNZT7LmCDePh+ZWeu4Buesl+Ul2xCeJ3wipdd8WLC4Bi5sspyPOL22SAP3
 Y8plEDXhoNoKahDPiPnS9QclBEuyaBkFUk0nkM+5UQvgM34Hty5xPbijcBkJYfZF4jhiJvfgl
 g45+WplXx21Xj+jC+jyusbcaDVBUYKk8vIQEQnAK6EQJnhUxXMJBPt1ckFDI9ixbLkMQjS7fR
 mUSLbSGDmqdJDncQkpXjm1QwSEhjpsQ34ddEkXtHWWOVHR9OaIMTcmy3hsYMeEbycx8AqhTPK
 JBJjq4APeFaVjXQvsL35V3oUj0yOD/DMAvq+j8t90Qc8KnWwFkeZXjJYxg+8BCxeht72ZwY6i
 y+VWfj0TIxu2jCN/PUkYYCdiYK7k55ReiKCJ6a3zbotg3SMYuKO/+yphiQjXYVJvNMm0K5Ld1
 bTZPbBUwQ1N4uHRmoQmaeZ1Ga4qZ7fkZUxUYYxIZlrvKon2mtdokkSQWRv1hl8h/LLKAJj5/2
 VUB7ItxfGm3oXwN3QtsWz7ZIELPTzNqDZuTXVlGuKnvAFdkCd7pNGplpAqzSEGYCn6kvoKjyq
 woK008k7oenHy+lR+Pa2XGixqcVtG8abRiOCyz9MulH4HZk0/8/AZ0Oz8Ghn5tfOk2mq/X6mQ
 QXpfpscYdooRZvLDSPjO46tvxTt0WkwvNpBLZy2dtsC2brEGYhs5PHf8baliQRhaL3C3gSRcl
 DdTEjeLLWyJ4gJpiOfk4Ftpk9U5qL+cWdl/p6xK7lvQMA7QSqOtgRvLbA7I5murgGxgBNZaDP
 map9orUHMVcQt2B7GwI/n2z7MWlsnBbi/I6W1xFeazcs+Icru5SaHacb+EYGjwXf2XbJEGuxm
 ZMkEH31PfEYua6b8x
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Taylor,

On Wed, 19 Feb 2020, Taylor Blau wrote:

> On Tue, Feb 18, 2020 at 07:46:03AM -0500, Derrick Stolee wrote:
>
> > Taylor Blau	5d5916fd builtin/commit-graph.c: support '--split[=3D<stra=
tegy>]'
> > commit-graph.c
> > 5d5916fd 1751) break;
>
> This 'break' line only changed indentation, so I don't think that this
> is new 'uncovered' code in my series, only that it got a little bit
> harder to trigger.
>
> It is interesting that this is uncovered, but I don't think that there's
> a huge sense of urgency to add tests to cover it.

I could imagine that this is actually not the `break` statement, but the
one before that. It seems to be an issue with the way GCC optimizes that
sometimes GDB (and gcov) have problems attributing precisely the line that
is associated with a given assembler instruction. My guess is that the
optimizer often seems to "reflow" the code, e.g. it would jump to the end
of a switch statement only to jump _back_ to the actual switch case.

So I would expect the report to be legit, but pointing to the incorrect
source code line. At least that's what I seem to recall from the last time
a Test Code Coverage report pointed at one of the `break` statements I had
added.

>
> > Taylor Blau	a599e2c9 builtin/commit-graph.c: introduce '--input=3D<sou=
rce>'
> > builtin/commit-graph.c
> > a599e2c9 75) *to =3D 0;
> > a599e2c9 76) return 0;
>
> These seem more interesting to cover, but only marginally so.
>
> > a599e2c9 86) *to |=3D COMMIT_GRAPH_INPUT_APPEND;
>
> This one I think we could ignore, though, since the same behavior is
> triggered by simply '--append' instead of '--input=3Dappend'. We decided
> in [1] to

to...? :-D

Thanks,
Dscho

>
> Thanks,
> Taylor
>
> [1]: 846706e9-efe2-448d-67a3-a96638e9bcbc@gmail.com
>
