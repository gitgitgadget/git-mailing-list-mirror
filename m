Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.0 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,RP_MATCHES_RCVD shortcircuit=no
	autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id D0D8D203C1
	for <e@80x24.org>; Wed, 16 Nov 2016 09:47:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S935544AbcKPJrl (ORCPT <rfc822;e@80x24.org>);
        Wed, 16 Nov 2016 04:47:41 -0500
Received: from mout.gmx.net ([212.227.15.15]:53471 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S935910AbcKPJr2 (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 16 Nov 2016 04:47:28 -0500
Received: from virtualbox ([37.24.142.46]) by mail.gmx.com (mrgmx003
 [212.227.17.190]) with ESMTPSA (Nemesis) id 0Lugbo-1cp7La1sw4-00zrAU; Wed, 16
 Nov 2016 10:47:10 +0100
Date:   Wed, 16 Nov 2016 10:47:08 +0100 (CET)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@virtualbox
To:     Junio C Hamano <gitster@pobox.com>
cc:     Lars Schneider <larsxschneider@gmail.com>,
        Johannes Sixt <j6t@kdbg.org>, git <git@vger.kernel.org>,
        Jeff King <peff@peff.net>
Subject: Re: [PATCH] t0021, t5615: use $PWD instead of $(pwd) in PATH-like
 shell variables
In-Reply-To: <alpine.DEB.2.20.1611151753300.3746@virtualbox>
Message-ID: <alpine.DEB.2.20.1611161041040.3746@virtualbox>
References: <f4336a7fa3df8c0b426c3d01ada8d7d8f38e588a.1478881741.git.johannes.schindelin@gmx.de> <xmqq37iy3q0s.fsf@gitster.mtv.corp.google.com> <fa11def5-a878-a5c8-6e7b-627ea8cda7e2@kdbg.org> <2b69d098-92ef-77b0-367a-516e9edbe257@kdbg.org>
 <xmqqa8d53ky9.fsf@gitster.mtv.corp.google.com> <alpine.DEB.2.20.1611121237230.3746@virtualbox> <xmqqtwbcyyfe.fsf@gitster.mtv.corp.google.com> <0BEC2674-20B5-4AD1-851A-97CA34C0CE7F@gmail.com> <xmqqshqux9il.fsf@gitster.mtv.corp.google.com>
 <alpine.DEB.2.20.1611151753300.3746@virtualbox>
User-Agent: Alpine 2.20 (DEB 67 2015-01-07)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K0:bQaKdTaTwIZEZYx+9enUSUYgdDFZdOFNxp8MYgfvU/8DqAmisdz
 hMiqmpTqMWOayy8x+9g6fBdO7mFp2vtaFRtpkTdpTSpQ4HIa3Lti9sb2KSHTJ7DgpSTzbAS
 MxJhD1vVZCkkZQj/RcAWFRAWEXU9DnD5vXkoeOVCbaUMjVcTvfjx1CQNUF9dGGOjVIQVIe8
 8YEPSThUpwuq19U/jW20g==
X-UI-Out-Filterresults: notjunk:1;V01:K0:UHmEpDRilqo=:pdpcG0FK0sp+z12zSOYHJE
 R2JW/5MiAmQ08yyvjDhwFiTfaViNMCRCjzpScb4wkatjQGrx71y9efY5iihLT4d2Kt/18eV0x
 gjpMfIatr3BQ07oEs3fCBsy+IgpubAMcHqxL3gmnEQ43fq8CClP28NW5PV5jdj09/oM8T7U9h
 ZR4cVHetYwG9T0ZADI8SZaGMlgTaj1vSUsvOJftlqJy1RL9Qr7Tf7/UezdS+JZ9607W4AQeRZ
 Li+O8TJ/jaCRl/B+d/HsphgMVrjMokE5SGvDCct52QP7bXfGA3fhXPAAESlhy9+jQsmgszagk
 ad6kHtxygW3crEGiOrIm1SQ3E+N/nSsdhiKY13YZXjBps4j65LxUW4Fjpfeg4bhtcCm3j1eD6
 ILsZf4jHO+PsYD/ISqCsHANcfw7w4utQfz4vzaniuiZrXxvHMPRhlJMS4G3D3uVV+Y7QMfE/T
 qy29NS7g1hm0BOSS/cvWh23GB7gWtQ8d9F4yjWhWkOixxvIL6gKEL0XLAUezaKJN6AuP8s4ZF
 crfpIUd/i2/6Kfh3IS0dPWrevlttZRL0jkyLDuGmFKZI8LirWXdKKf2FKC5PvK4SUXZNDyCpc
 SR+Oj7jtxA7I6T1FCTgJPMAg5962JZHAMC9Ev9vqdTmJJ0OVo+2lVq0C0LcvHEHS5A4HnnbbU
 TBvwuNQvIMfkZBeZ+w0pjjs+X696VijO5M31xUxSDZYq0nOoz+dV+McynMnftkwa8qw6ica2o
 z7mqQPbhyltsGXz4DamJgLpcRQXR69/0Dv1AcKZ9ja20K2VlQt5ZUmd+wEkk+V9jQgqj2NMH3
 WOxg7Sq
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi,

On Tue, 15 Nov 2016, Johannes Schindelin wrote:

> On Mon, 14 Nov 2016, Junio C Hamano wrote:
> 
> > Dscho's mention of 'still times out' may be an indiciation that
> > something unspecified on 'pu' is not ready to be merged to 'next',
> > but blocking all of 'pu' with a blanket statement is not useful,
> > and that was where my response comes from.
> 
> Until the time when the test suite takes less than the insane three hours
> to run, I am afraid that a blanket statement on `pu` is the best I can do.

Well, I should add that the test suite does not take 3 hours to run for
`pu` these days.

It used to time out after four hours until two days ago (I think; I was a
bit too busy with other CI work to pay close attention to the constantly
failing `pu` job, with quite a few failing `next`s and even a couple of
failing `master`s thrown in).

As of two days ago, the test suite takes no time at all. The build already
fails (which makes me wonder why a couple of patch series I contributed
had such a hard time getting into `pu` when they compiled and tested
just fine, whereas some obviously non-building stuff gets into `pu`
already, makes no sense to me).

This is the offending part from last night's build:

-- snipsnap --
2016-11-16T00:31:57.5321220Z copy.c: In function 'copy_dir_1':
2016-11-16T00:31:57.5321220Z copy.c:369:8: error: implicit declaration of function 'lchown' [-Werror=implicit-function-declaration]
2016-11-16T00:31:57.5321220Z     if (lchown(dest, source_stat.st_uid, source_stat.st_gid) < 0)
2016-11-16T00:31:57.5321220Z         ^~~~~~
2016-11-16T00:31:57.5321220Z copy.c:391:7: error: implicit declaration of function 'mknod' [-Werror=implicit-function-declaration]
2016-11-16T00:31:57.5321220Z    if (mknod(dest, source_stat.st_mode, source_stat.st_rdev) < 0)
2016-11-16T00:31:57.5321220Z        ^~~~~
2016-11-16T00:31:57.5321220Z copy.c:405:7: error: implicit declaration of function 'utimes' [-Werror=implicit-function-declaration]
2016-11-16T00:31:57.5321220Z    if (utimes(dest, times) < 0)
2016-11-16T00:31:57.5321220Z        ^~~~~~
2016-11-16T00:31:57.5321220Z copy.c:407:7: error: implicit declaration of function 'chown' [-Werror=implicit-function-declaration]
2016-11-16T00:31:57.5321220Z    if (chown(dest, source_stat.st_uid, source_stat.st_gid) < 0) {
2016-11-16T00:31:57.5321220Z        ^~~~~
2016-11-16T00:31:57.7982432Z     CC ctype.o
2016-11-16T00:31:58.1418929Z cc1.exe: all warnings being treated as errors
2016-11-16T00:31:58.6368128Z make: *** [Makefile:1988: copy.o] Error 1

