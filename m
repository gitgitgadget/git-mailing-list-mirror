Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.6 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id BBCDB1F462
	for <e@80x24.org>; Wed,  5 Jun 2019 08:12:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726531AbfFEIMk (ORCPT <rfc822;e@80x24.org>);
        Wed, 5 Jun 2019 04:12:40 -0400
Received: from mout.gmx.net ([212.227.17.21]:36043 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726467AbfFEIMk (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 5 Jun 2019 04:12:40 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1559722348;
        bh=9olsJFxuPyWSRG4qWWoKX4sVGbX9ZYe7pZ2JEo/v1kk=;
        h=X-UI-Sender-Class:Date:From:To:cc:Subject:In-Reply-To:References;
        b=Y6NjJyYWCQ4TsCLTTjEpcYMvUGCW6yELfhGMRthHVz53AJzD3+b4a7Jn/aw3lFmay
         QwhJuG56xxQXUOCypN3CKSi8tIeOOwOXyKumYF0fEc+n7Mw4LFqxSyfaNZZBHxPPLz
         AjrJnxx1yL4HJgI8O7MZECTApsmF9+1mKj9IhBsQ=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [192.168.0.129] ([37.201.192.51]) by mail.gmx.com (mrgmx103
 [212.227.17.168]) with ESMTPSA (Nemesis) id 0MRGvT-1h8ClX2U07-00UcNi; Wed, 05
 Jun 2019 10:12:28 +0200
Date:   Wed, 5 Jun 2019 10:12:12 +0200 (CEST)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@gitforwindows.org
To:     Felipe Contreras <felipe.contreras@gmail.com>
cc:     git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
        Jeff King <peff@peff.net>
Subject: Re: [RFC/PATCH 0/5] Fix fetch regression with transport helpers
In-Reply-To: <20190604021330.16130-1-felipe.contreras@gmail.com>
Message-ID: <nycvar.QRO.7.76.6.1906051005060.1775@tvgsbejvaqbjf.bet>
References: <20190604021330.16130-1-felipe.contreras@gmail.com>
User-Agent: Alpine 2.21.1 (DEB 209 2017-03-23)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K1:0tpZQIX+tFdwhrWyni6cmSM3TcP1LyPZzCAeKJDPXivsn9vt6cQ
 q8015mAgwRuLOhDqSK0kkNRSfgl/1y08q8q64KTN3eBfuru3p4mIXiYPswY9/lsePgTWXDf
 nFxA/6MJkkDEIirqNfpQIikLioiBb8HdGP6FxAnWNCHi+cLJFUMrzlW+yinW7LUFdyU8CH3
 j7IosQcYLvOjmaFpXADdw==
X-UI-Out-Filterresults: notjunk:1;V03:K0:K1d2G7qhrjk=:fF5eIB5mYu+4w0VtTWqF7c
 yBz/J3Sb3g3/knO1nkzrA3Nivx05tOmwM5YOoEkeIf3/+ZSH4FpUvZtxFYCFd7r2CpU9kqrnO
 gwsThZ7OlgXv+nUG5NfXGd6nZ5yfvamor0QCzFww/q0B2J1hFyBQoAfpqam4l6HJsU/+o2vW4
 sdOtk3MyhBnw+hK7n44imDPkAP2Snw6Akl01tIgRF5NCwfI5hOVQHLciJLD9Y/OgWetPtaTrC
 q6dqVqUQjYm0+T1znDSYM8frOsyCXuTjm/0q29pDEaMYQU5I1oC69N8Xnz5sS1hhOjQBaK44x
 Gh2fJWyPgCBWac2NWTMP4KLGl3dtkH1Hbx4GJkBF8I9esbNcCGeBMjwG44h0rvbEOzDaIuxw4
 ZJHzfITDsLf1yL7K5plK73nHjMkvQCrxKpHfCYVwVlEvShn+0xWFzL+YVxa3TiHtENMRKSKFR
 q/n+2MotzPeDTCgGgLg2iVH+OPEdxXHIwjuaZP6vXHPZOJa+uM9BGTlt7RPVGtCr7Px2cu1iT
 E6Iu6cQ9mgT6QQCc7o2OzfKzOEp9OE+uctaSdhXmRTRD6lNtYWEkXHbdWIokK9CQJwlo5weD1
 hUo64VSIJwVL7GqJqjCDSkqExedBroA17KEErUWZHlQ1FSw366lJQura3Fo1GHCjYk2adZbpD
 nYJ0wMyiFanE3HTJdqO9TAUvQ+aGHDsvXyNGRAxI10FvEmokmBlPhIqocms9+Ydmr/Dp5MY6T
 yBMrs4c2p/ESZbizV+E+hoDy/RnaTVeTvdiX8/sDZSXskV4YIT5p5TupfcZoQ9E/wrya4GXS3
 ZB+n6G7e4PDFIKUv142xVPRf6+gW1h9VhatKwX0KUXVNAWAF/yBVsxpUX7TtBKN6oi09fC67r
 4j3a4beID5/y0X9YWcHk026TgYsgSHPMfHhzjH0EHn2GoHKnP6DBeIUTa/kfkoJd9jz9t16qj
 gfyiDHboIuPLinZ+xdGvpJTmTBFc1zNq6BOWAWwgVPzYNxju3DBnD
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, 3 Jun 2019, Felipe Contreras wrote:

> Felipe Contreras (5):
>   t5801 (remote-helpers): cleanup refspec stuff
>   t5801 (remote-helpers): add test to fetch tags
>   fetch: trivial cleanup
>   fetch: make the code more understandable
>   fetch: fix regression with transport helpers
>
>  builtin/fetch.c            | 28 ++++++++++++++++++----------
>  t/t5801-remote-helpers.sh  | 18 ++++++++++++++----
>  t/t5801/git-remote-testgit | 22 +++++++++++++---------
>  3 files changed, 45 insertions(+), 23 deletions(-)

This fails on macOS, in t5601, both in our osx-clang and osx-gcc jobs, as
well as in the StaticAnalysis job. For details, see
https://dev.azure.com/gitgitgadget/git/_build/results?buildId=3D10206

The t5601 failure looks like this:

=2D- snip --
checking prerequisite: CASE_INSENSITIVE_FS

mkdir -p "$TRASH_DIRECTORY/prereq-test-dir" &&
(
	cd "$TRASH_DIRECTORY/prereq-test-dir" &&
	echo good >CamelCase &&
	echo bad >camelcase &&
	test "$(cat CamelCase)" !=3D good

)
++ mkdir -p '/Users/vsts/agent/2.150.3/work/1/s/t/trash
directory.t5601-clone/prereq-test-dir'
++ cd '/Users/vsts/agent/2.150.3/work/1/s/t/trash
directory.t5601-clone/prereq-test-dir'
++ echo good
++ echo bad
+++ cat CamelCase
++ test bad '!=3D' good
prerequisite CASE_INSENSITIVE_FS ok
expecting success:
	grep X icasefs/warning &&
	grep x icasefs/warning &&
	test_i18ngrep "the following paths have collided" icasefs/warning

++ grep X icasefs/warning
error: last command exited with $?=3D1
not ok 99 - colliding file detection
=2D- snap --

My guess is that your changes remove something that was expected before,
and is still expected, and that this was only tested on Linux, and only on
a file system with case-sensitive file names.

The StaticAnalysis job (which is admittedly a misnomer) points out another
few valid issues, but that is probably because Junio applied this patch
series on top of a very old commit. I, at least, could not spot any file
in the Coccinelle report that was touched by this here patch series.

Ciao,
Johannes
