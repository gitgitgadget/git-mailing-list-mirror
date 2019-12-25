Return-Path: <SRS0=LPWw=2P=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,MALFORMED_FREEMAIL,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 62B91C2D0DA
	for <git@archiver.kernel.org>; Wed, 25 Dec 2019 11:57:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 355992075B
	for <git@archiver.kernel.org>; Wed, 25 Dec 2019 11:57:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=gmx.net header.i=@gmx.net header.b="V9lybuCi"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726395AbfLYL5q (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 25 Dec 2019 06:57:46 -0500
Received: from mout.gmx.net ([212.227.15.19]:41287 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726289AbfLYL5q (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 25 Dec 2019 06:57:46 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1577275062;
        bh=rJI7ztba5XhA9FZ2nU2z+5Jw/Ksg64GeSYuScJ3b28g=;
        h=X-UI-Sender-Class:Date:From:To:cc:Subject:In-Reply-To:References;
        b=V9lybuCiE2spZWVdt0ijyIPaLYR4fW1W0bpXCiTxexzpxz0LxZnx2JMAEfiXNOlNt
         enS95fW6HfX3meIzC4cXZJiXoyFfblYUG3GOqgxJAI8IugKPn2b/BfNp6LvFQFje9V
         DdTEXmxU7f6FPXpZkpMRMzD1CeeNp3NwjiWxcqk0=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [192.168.0.213] ([37.201.195.152]) by mail.gmx.com (mrgmx005
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1N49h5-1jjVdU4AFt-0101Gl; Wed, 25
 Dec 2019 12:57:42 +0100
Date:   Wed, 25 Dec 2019 12:57:26 +0100 (CET)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@gitforwindows.org
To:     Junio C Hamano <gitster@pobox.com>
cc:     Johannes Schindelin via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org
Subject: Re: [PATCH 9/9] ci: include the built-in `git add -i` in the
 `linux-gcc` job
In-Reply-To: <xmqq5zi96wxc.fsf@gitster-ct.c.googlers.com>
Message-ID: <nycvar.QRO.7.76.6.1912251256500.46@tvgsbejvaqbjf.bet>
References: <pull.175.git.1576968120.gitgitgadget@gmail.com> <9719604a1fb6ec4cf1b1297875cae86c076c9cdd.1576968120.git.gitgitgadget@gmail.com> <xmqq5zi96wxc.fsf@gitster-ct.c.googlers.com>
User-Agent: Alpine 2.21.1 (DEB 209 2017-03-23)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K1:gWzQswSFahA7EGGLiaOH76ybPAWnGbjYRAKsP4D0A6hwR7MeGTN
 kawu7eNTbswCBYfBH6f67W+YBfLQu5s+Yz0djuc59jMKTNGxbyy0075h6wTjq8gouFRoxct
 PbSbPnslODlkfgzC4CjsPV5j62S7JTs/MEDHw9OqxKtV9Eka5+RSlxV8kedvgathWsWV33w
 /lYndQiOZ+K/agJy1nX3w==
X-UI-Out-Filterresults: notjunk:1;V03:K0:WxENhWoqRKA=:Iu2xU1N9jbBp4pSbuguqZW
 PMdISt/vzWe32ByRhW9IHrCcGGPFCzRqFTAdj/cbelKTiafkhduGt892WhVGLsK8Xtkgx3L7v
 QI1z/+STgfLdyBZr1nTcBKJAvJc2O40DGTlEsSTACRHLFRFaF5BH4WsDC4m0Z1e71pq4guOod
 hfxVzudTKkFA+lGBIpn+vlhJRev8+EB++fIbfz1Ysh8XMdL2eHHuuQNUAqI02LYqwj3BVrHHE
 T0r0WalnOnMdIn+mkqJmae0m5k1IGRj0bL3R5hQT/Jm3NC9yenIPw9ojktpkOS09P5M4nEas6
 sqXsx9L7iqfup8vruvOB415czKORz2TlHwUPj3JYzbVj+j+Nt9oBG1f/Ryx0K2omwP85oXKYE
 Ybs9upkHTQ6fMA1L0vgPmmHF9WJgDsUyC2s/9Ggq5T0cjZxREi/cSfFReKbhKcHl+awFJT45U
 MI75dJmAOYyxWvGjbR8cEfQHCixZWQ3qGF8EJ/BKMn5EjiUnppS7itbDM1w+9nZgbpCaUHvGH
 e38wF1xgPbf8DZVyZDLASZ4BS4IXA/APpp96fH9tD+FQB2aPBTzu7Hk6h9aeIpV2N6425O7li
 gga8MT9oslUCb4GUONTbzXjeSDPzrHkpTb3OdIjdRh42kPpGs/q4W1BxJe1bkFuN5ZQJmgVxu
 uUw42AEbc0W9dGM5BISVcODqqQYvFjSHr+awBfPopwIM1uk4U/GyhHDWJdi74lzsVlA9ax4n9
 i/spxjnHB3Lvx2/izfWWbIsLIvgF5hGTA94Yde0f2QPEQBjIG1S9R1Ee2jMTSfvk6Ky6KWJuc
 lSyQCd2HyTMlTrUG6JKcySqeTadc/jjy+R6EH7lHR52eX5mBn08rIdSa9T+ssx9k65KaTNB3P
 z1OrIRzMiwA5YMCdPwvMJoooRClP9vAWzB5212PFhP7kKUjVOvczX5YbHY6dqob28zUcJNiZC
 teHeUYcwoONre58S1sZ2dwMby8ZwSFpVP3gTV1x+eiLHEZXeYPvPObVnunIOEZxbFRYx7Z2w8
 xF8RnOxBLMJ2hH4xv9RHU7mpdTsOFwhv5GLzPqG7GN5ETy2oihzkKJ/kvhxoGZfx9ZW9ixJUX
 LXjshqpNOPeVuOZmhgxaoii2B7C/PNcHuKhYqwF3Ui3Jm3KT/0wBJozYthbHXYYdndN06JcBL
 /JR43PBhVCRy+vjy77cBGu/KocVOUkwVlwnmFv0dIRsSTdKuHHc/PSX3pnuEWkJOLhCl8CHgw
 J2MRNi07awcmbyKJrmwizm7w/Aen0+gcoZFY4DsSO3gLKfVdNV2NKM+JggbU=
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Junio,

On Sat, 21 Dec 2019, Junio C Hamano wrote:

> "Johannes Schindelin via GitGitGadget" <gitgitgadget@gmail.com>
> writes:
>
> > From: Johannes Schindelin <johannes.schindelin@gmx.de>
> >
> > This job runs the test suite twice, once in regular mode, and once wit=
h
> > a whole slew of `GIT_TEST_*` variables set.
> >
> > Now that the built-in version of `git add --interactive` is
> > feature-complete, let's also throw `GIT_TEST_MULTI_PACK_INDEX` into th=
at
>
> Huh?

Right. This is so obvious a copy/edit fail, but don't you know, I read
through these patches multiple times and still failed to notice...

Fixed in v2,
Dscho

>
> > fray.
> >
> > Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
> > ---
> >  ci/run-build-and-tests.sh | 1 +
> >  1 file changed, 1 insertion(+)
> >
> > diff --git a/ci/run-build-and-tests.sh b/ci/run-build-and-tests.sh
> > index ff0ef7f08e..4df54c4efe 100755
> > --- a/ci/run-build-and-tests.sh
> > +++ b/ci/run-build-and-tests.sh
> > @@ -20,6 +20,7 @@ linux-gcc)
> >  	export GIT_TEST_OE_DELTA_SIZE=3D5
> >  	export GIT_TEST_COMMIT_GRAPH=3D1
> >  	export GIT_TEST_MULTI_PACK_INDEX=3D1
> > +	export GIT_TEST_ADD_I_USE_BUILTIN=3D1
> >  	make test
> >  	;;
> >  linux-gcc-4.8)
>
