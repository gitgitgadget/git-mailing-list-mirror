Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.1 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,RP_MATCHES_RCVD shortcircuit=no
	autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id A81B0201B0
	for <e@80x24.org>; Tue, 28 Feb 2017 20:36:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751592AbdB1UgY (ORCPT <rfc822;e@80x24.org>);
        Tue, 28 Feb 2017 15:36:24 -0500
Received: from mout.gmx.net ([212.227.15.15]:61608 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751570AbdB1Uei (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 28 Feb 2017 15:34:38 -0500
Received: from virtualbox ([37.201.192.48]) by mail.gmx.com (mrgmx001
 [212.227.17.190]) with ESMTPSA (Nemesis) id 0LnPSg-1c6hAs46yU-00hcao; Tue, 28
 Feb 2017 21:34:09 +0100
Date:   Tue, 28 Feb 2017 21:34:07 +0100 (CET)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@virtualbox
To:     git@vger.kernel.org
cc:     Junio C Hamano <gitster@pobox.com>,
        Lars Schneider <larsxschneider@gmail.com>
Subject: Re: [PATCH] Travis: also test on 32-bit Linux
In-Reply-To: <c76a133a57514a332828099d342c9763fd946bfa.1488309430.git.johannes.schindelin@gmx.de>
Message-ID: <alpine.DEB.2.20.1702282019460.3767@virtualbox>
References: <c76a133a57514a332828099d342c9763fd946bfa.1488309430.git.johannes.schindelin@gmx.de>
User-Agent: Alpine 2.20 (DEB 67 2015-01-07)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K0:ORxa9TehBLvEIfEV14TzbCdPeGIoiaKbeyltxur+ytEsSYuOs6T
 ww75FF+TRQRQFWmWzNoEXfXCNb44/NNrsU94dJRDg3i8lENNhkbXQRQzkX3DgC6WQYD/b8h
 Du/tTNOIdMTRr5xHPXmhsqn+Tm7eyHRCsSMPgh+YGqyWzK/KnyEyxib0z+Ou0+bS29jw4BG
 AAg8Uu3DjYlzt2rpw5xhg==
X-UI-Out-Filterresults: notjunk:1;V01:K0:9I+p95+veXE=:CItKztH5w6KeOFHLiDqOFp
 Py743Gt8fNzhlVosJ/8vrI+HzwL2MSL5SygWpiSTnUQcdkomEEP08ECf8eKVbVjDnUadOaQr5
 Ke+orbF2Z0DKHk3qQMqeU7AgQ057QxKT2msssBDMYvgMqYREcLVfaafadm7aHpw/kpNu6/xn5
 KXQFWJMEjzSo8sKF7dgFjgj3wMZfaRsQWcPlslQlC1KBqVATczwVSuN717x2K1+Pce+hbaRuA
 F5jK8Xq9oV/nYCQw3n+58HJ1cc2PwWrbSEbUQiAKE0mSALeQmMpfL3TXJoFH2mOpK/AMGrNSM
 Bo0nXn1SeCGmh4LIpMLbOSVo50r6R+s1ty67ZGxGwJAMWfU6irbhNMGgWoSmUaZQMRP+HizsC
 zcUmtWj6XYyW1krtiKVI8e+VN8bZrR+btkEsZKpvtMNx+U4F4uniQU0slUgxzNnG/zPJw/aYr
 hi3qpY50yk775jzVIud/34hB2s1FcdtJrm4rNMJl+lNZCix59+0hTWUNe3AduwfNMGx3kfBFG
 WSg6U8mcWsbTaezmR1oFGZlcin1q92T9YggwZwbUTKfM/47/yt+NJdTu/NfDLTTt+m+iBso/M
 ZdW+g0ZgXZO27pjxNxJe7vS0DGrENt5lnxvwg5Aes79eXlNcb7PCLG5YLtT7y7CeBhnQXVjZx
 +9OKTYg485htteR+xGH+ygyyXC7G0BPEzYIjYjOSunUJuBSjy6yjhhdRU5J8Mfs6RlSO92nX9
 1uYhKhnNCNB04sI05KOfuS/hVDYHcPXOymvFjFEKDM0maQV4oXkjyloSqXctEyw3sbelLyyU/
 iEP3I7TUh4MSg1jwc7iIfoSCoFGHw==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi,

On Tue, 28 Feb 2017, Johannes Schindelin wrote:

> When Git v2.9.1 was released, it had a bug that showed only on Windows
> and on 32-bit systems: our assumption that `unsigned long` can hold
> 64-bit values turned out to be wrong.
> 
> This could have been caught earlier if we had a Continuous Testing set
> up that includes a build and test run on 32-bit Linux.
> 
> Let's do this (and take care of the Windows build later). This patch
> asks Travis CI to install a Docker image with 32-bit libraries and then
> goes on to build and test Git using this 32-bit setup.

For the record, I first tested this with the LONG_IS_32BIT flag forced to
`true` so that the date tests must fail. They did fail as expected (search
for "not ok" in this output):

	https://travis-ci.org/git/git/jobs/206199002

(I actually cannot see the log right now, Travis seems to be under heavy
load...)

A much cleaned up version that does not force that LONG_IS_32BIT produced
this log:

	https://travis-ci.org/git/git/jobs/206228708

(Same here, my browser fails to load the log, probably because Travis
experiences quite high a load...)

Please note that this approach is not without problems. It would appear
that Travis currently has serious problems to even *reach* the Docker Hub,
and therefore cannot download the Docker image:

	https://travis-ci.org/git/git/jobs/206292947#L6

Ciao,
Johannes
