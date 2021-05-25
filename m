Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.7 required=3.0 tests=BAYES_00,DATE_IN_PAST_06_12,
	DKIM_SIGNED,DKIM_VALID,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E79A3C2B9F8
	for <git@archiver.kernel.org>; Tue, 25 May 2021 09:18:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id BB7E561409
	for <git@archiver.kernel.org>; Tue, 25 May 2021 09:18:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232468AbhEYJT2 (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 25 May 2021 05:19:28 -0400
Received: from mout.gmx.net ([212.227.15.19]:34157 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232434AbhEYJT2 (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 25 May 2021 05:19:28 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1621934261;
        bh=ssVf7jz6sgo+DdFdzpp5TEcNilQ5sm4JDb1iAhB6x5A=;
        h=X-UI-Sender-Class:Date:From:To:cc:Subject:In-Reply-To:References;
        b=d0VA/umSpYwvczPevPLKRQRrVDmDTE/N4PkxIxfpt8AET30XC9/tk+c7ixO6SCQBU
         8xb04TTSj5UZVUXHkmO+bgEnENVcvXBg3JJA+zBwi8R3MM+whanNW4AWwt8xXJ6X8F
         gE8/Bhi66ANR576IPwQJHLlM9Lsb0Ey3tAOO7TxA=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [172.20.198.229] ([89.1.213.183]) by mail.gmx.net (mrgmx004
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1MD9X9-1lcyrl3fhh-009Bxp; Tue, 25
 May 2021 11:17:40 +0200
Date:   Tue, 25 May 2021 03:50:08 +0200 (CEST)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@gitforwindows.org
To:     Junio C Hamano <gitster@pobox.com>
cc:     =?UTF-8?Q?=C3=86var_Arnfj=C3=B6r=C3=B0_Bjarmason?= 
        <avarab@gmail.com>,
        "brian m. carlson" <sandals@crustytoothpaste.net>,
        Felipe Contreras <felipe.contreras@gmail.com>,
        Derrick Stolee <stolee@gmail.com>,
        Bagas Sanjaya <bagasdotme@gmail.com>,
        =?UTF-8?Q?L=C3=A9na=C3=AFc_Huard?= <lenaic@lhuard.fr>,
        git@vger.kernel.org, Derrick Stolee <dstolee@microsoft.com>,
        Eric Sunshine <sunshine@sunshineco.com>,
        =?UTF-8?Q?=C4=90o=C3=A0n_Tr=E1=BA=A7n_C=C3=B4ng_Danh?= 
        <congdanhqx@gmail.com>, Phillip Wood <phillip.wood123@gmail.com>,
        =?UTF-8?Q?Martin_=C3=85gren?= <martin.agren@gmail.com>
Subject: Re: [PATCH v3 4/4] maintenance: optionally use systemd timers on
 Linux
In-Reply-To: <xmqqim38jfja.fsf@gitster.g>
Message-ID: <nycvar.QRO.7.76.6.2105250327550.57@tvgsbejvaqbjf.bet>
References: <20210509213217.449489-1-lenaic@lhuard.fr> <20210520221359.75615-1-lenaic@lhuard.fr> <20210520221359.75615-5-lenaic@lhuard.fr> <715d8115-641b-5c06-d514-36911eb169ef@gmail.com> <44d937a0-e876-e185-f409-a4fd61eae580@gmail.com>
 <nycvar.QRO.7.76.6.2105220856320.57@tvgsbejvaqbjf.bet> <60aaa09aebce4_454920811@natae.notmuch> <YKrk4dEjEm6+48ji@camp.crustytoothpaste.net> <87wnrooa17.fsf@evledraar.gmail.com> <xmqqim38jfja.fsf@gitster.g>
User-Agent: Alpine 2.21.1 (DEB 209 2017-03-23)
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="8323328-85033175-1621907411=:57"
X-Provags-ID: V03:K1:w/M+muaqutMHEureo2xTx8kKgI3oASwgU0T1R/2yrkwgYul4R0a
 tja4U1TfbDwgXoNNpsDofNM9alEP+RFHPvDd7MrCGIcOasdNet4jxlVsH/e0COjkSFvilaK
 tSDAMTtDMS/P+ACVKPIvTKvGyeAkZjTfSfszKGjjhKmEfiRIHRDffKJQhnD3fvJNXNNyUSD
 WviCL/6IflR75DRRwhyDQ==
X-UI-Out-Filterresults: notjunk:1;V03:K0:vooNZ5Ba8jk=:OiufFSAT5JC6rLDJDdfpPX
 BchRGL2myno6QX5ZnqlB+MeiXSbKW0+06Gva+W1a/tH7wg+LV5nEZ358QCN9vfU6bBcWFRy28
 ghft6wiw9BMo0c4ptWojex5SGXrGcQmRC4uYwQT5lYJRIPgN65L7P06z7alksrdXjrKhLA7w9
 kcLKtdL1/ZJlawAr5boWTl83X3yRjLk5IbG87ULKr3hnPhG3M4NKFsyBMB/LZEAIwMilNBz8q
 kBU3aD0J6gP4RSkW/6BhAvwaVwA4IxCKVKujrh+TQwRjiFsBgPJ70EO0Z/eqsgB6zsqcBaz5T
 TlpPt7lx0tHK2jM51mlGEAsHx6r0LY9POdrk/wlfouVRe49JHaVl+pEo1TTNYfDcFcYIvcqF+
 JghaVwi8ldRWnyUT4aJIeVvCpRJIwgyln1v3ryFHmRFBSNrQWUD+NnLRAbxkpUPMv7ZYaBK76
 USJWBpoKe5LPTsMRnha2fj/gH+SI00qRk5rrkX0sc8LYIk7jbBh/URxR+QAciNk28Cm5byqzU
 wLkqoGt9HNr+jCv9AxSW0uiwpQT+fQlJtfXBkkYMVchLORgyBArz1Kjy5UCxPWUZBYwhIW2+V
 xWy2JP/wPpkkJnc4tdVDYYoUKHUbca6vzS6ETi1k2mkhE5fgKJfn3/zbdK2WIYVWQOL6Aw9qG
 1bv4SYpdNgqiFQaV5WzO3EzIPRT4tBoZTSC7P3Pt++kPSHain1MaxlLW1VPuG272rj2LuCe08
 0zg+V462GUxuYz1huBulPCP7lfUg4g/keg2C4lTTehO3Ys62JdmAEYBlR0Mnd4K2FUiV8+pG5
 v57pjI179LbCh5GVAdGgbeffzqYF3pKFmV8gImI2Vr847mRwGG7RXezkUDB1SkeuCaf4sBPW9
 z3aMOXf+Jsp1l4k1t6i7Jm3NycD7OLW3f/uden7dIc+81Eltd4EuB7kUA2icNifi3h6RtxhXE
 KVfgAdbQEA2C9/wE3+cmOa+4V7kD7wukK8YSlgTuJbCUbp84pMZvK4gs1EQjiTgVcBtA4wCF5
 ebKFg/8V86aCvamKaO5vkEr+l3FJRxnuQ60jhD1Yv607QDuI3I+luEFhaL2jwVKw67H66LL9X
 OtRO9JA69FYB+drfTS0w9/HUmpvs95wM4S2x8WGWKQoRH6oiR/xiUcGrhWYGZJ8gIbka27TLQ
 e2OuKVWXi4lzpSZ5haalurgv+mYN+hzUi4WkfpPNrxbDdsCS1bHGTk/ZrIUVyHlQJyFb5NnJq
 QoCGd0p+gLsy0HWsh
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323328-85033175-1621907411=:57
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Hi,

On Tue, 25 May 2021, Junio C Hamano wrote:

> =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason <avarab@gmail.com> writes:
>
> > Personally I don't care whether someone submits a patch where their
> > commit message discusses an example of "he", "she", "they", "it" or
> > whatever. It's just meant as an example, and not some statement about
> > what the gender (or lack thereof) of such a user *should* be.
> >
> > It's immediately obvious what the author meant in this case, and that
> > the particular wording is arbitrary. For the purposes of discussing th=
e
> > contribution it matters whether it's unclear or ambiguous, which it's
> > not.
>
> Nicely put.  Thanks.

_Personally_ I don't care either. Because I am exactly in that group of
young, Caucasian male developers that are so highly overrepresented in our
community already. I will never have a problem thinking that I don't
belong here. I never had that problem.

And I believe that you, =C3=86var, are very much in the same boat. You wil=
l
never feel as if you don't belong in tech. You're Caucasian, male, and
like me, come with an abundance of confidence.

Now, let's go for a little thought experiment. Let's pretend for a moment
that we lacked that confidence. That we were trying to enter a community
with almost no male members at all. Where an email thread was going on
about inviting us to join, using no male pronouns, or putting them last.
And remember: no confidence, no representation. Now, would you dare
chiming in, offering myself as a target? I know I wouldn't. Yet that's
exactly the atmosphere we're fostering here.

What you say, matters. _How_ you say it, matters.

In other words, I think that the _personal_ opinions of everybody who
spoke up in this mail thread (you might have noticed that all of us are
male, you could even call it a "male thread") are not the problem we are
discussing. Personal opinions are kind of missing the point here. By a
mile. And then some.

The actual point is that we want to avoid giving the impression that
only people who feel included by the pronoun "he" are invited. That we
only really care about male users and developers, and pay only scant
tribute to the rest.

And yes, even "he/she", or "(s)he" would give that impression, by
emphasizing a priority order. And "they" simply would not do that. And if
it makes a few male readers slightly uncomfortable, it might present a
fine opportunity to exercise some empathy with those who feel
uncomfortable and excluded all the time.

Thank you,
Johannes

--8323328-85033175-1621907411=:57--
