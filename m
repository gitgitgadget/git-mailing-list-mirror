Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-9.3 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id E519B1FE4E
	for <e@80x24.org>; Thu, 30 Jun 2016 13:07:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751959AbcF3NHA (ORCPT <rfc822;e@80x24.org>);
	Thu, 30 Jun 2016 09:07:00 -0400
Received: from mout.gmx.net ([212.227.15.19]:50777 "EHLO mout.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751432AbcF3NG7 (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 30 Jun 2016 09:06:59 -0400
Received: from virtualbox ([37.24.143.100]) by mail.gmx.com (mrgmx003) with
 ESMTPSA (Nemesis) id 0MUoiS-1aozRD2ZjQ-00YDTo; Thu, 30 Jun 2016 15:06:47
 +0200
Date:	Thu, 30 Jun 2016 15:06:45 +0200 (CEST)
From:	Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@virtualbox
To:	David Turner <novalis@novalis.org>
cc:	git@vger.kernel.org, pclouds@gmail.com, kamggg@gmail.com,
	David Turner <dturner@twopensource.com>,
	Ramsay Jones <ramsay@ramsayjones.plus.com>,
	Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v13 04/20] index-helper: new daemon for caching index
 and related stuff
In-Reply-To: <1466914464-10358-4-git-send-email-novalis@novalis.org>
Message-ID: <alpine.DEB.2.20.1606301457340.12947@virtualbox>
References: <1466914464-10358-1-git-send-email-novalis@novalis.org> <1466914464-10358-4-git-send-email-novalis@novalis.org>
User-Agent: Alpine 2.20 (DEB 67 2015-01-07)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K0:T/xYqjD5/Cn2OMEIjRxG9B3cTgQrRY7DdsvhEsd+fol54Jtqd9H
 kUElg0fLyCvv8zeF5oyDeasOH1t5jbbQ7I9+SQ3eO8f9m0vcfqyJ8jjxZvMTIJD6Ax1FSSD
 8NyTGQXtcOe2448hHLYxosYvUNrbQWzEM2ARLXLc9pb57rZ/SM3IpECnZRYL8Ke7EqDMoxj
 bEb6ONgSGI8Hi/E60+HrA==
X-UI-Out-Filterresults:	notjunk:1;V01:K0:YzJ2dNbxHXU=:WohGtKzaINwNvQGU/xUelz
 H7MdlJYPc/9z2y3LadID8oohcrdkFe0zw3dsxojBB6dzaSIG+aos/vweUxrdvIeFKjVRsi7pi
 gZm/ppbuZD1KcqT1iY8ZPGS9z4O9pvRZCBg4+qA+bES83t2zwH0qwaOoJMYp7KQIIZqjYcHht
 r9mbQt3EeIuhjZVewn0x5R08Q2Dy4pxMgPL+Zilr7331NCAeiu3MmiHf/1Nuwb+C51Fka9aeJ
 u58K+ZiS/LgQarTvEHkK5LRd6S5xyyNb65cBMI5JZoCho+krmhE7s0QpZxJoExLhuomlfKKXa
 gLpvTl6MngvrBOI8tti3Vv3wIKzIoswngojrXoIPmSz0/yp7OYtl2+gjSYwGmDw2aE8ZPIKkG
 TLRiLMZ7J6ArUyu4C2HniJeplVxPx2sXmgTaY0AL9ArDlGFyt8YQqTeI+/3B+kY/uyeAN1CVs
 en55JGZZewd9Zs9Yr1mWljzAzUegWpZKxWCvCvZQlfMNptuatnigc+nosd0vHlXKld0/RwjAx
 S7KD4WfkQthNFXVfdG8ZLp3rbs8YYzNU6iWtEhqtnRXTXm4n+OVP7Rfv7Rkf6TkM8WTm6JRhL
 x2BCXth0DHWWHkBqcE1ffB3r3zo+/oOJTSULtomtmhGW91TEbyFzHzYUui5pg8Gpf0ygfzukJ
 gdjKQh4egq/VsftP27DHBnCmQYH3UK4kNcKl41bNyjXrqoWALlj/rcJeZGhSTshPPqfh/kRcS
 EarifHxWif7couUzT0WdcQtn0yd3fgLAjLEBkZlIKuDKfc43+7LgiUmotN/RavJBcW3GnG3vD
 1LYnHNn
Sender:	git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List:	git@vger.kernel.org

Hi Dave,

On Sun, 26 Jun 2016, David Turner wrote:

> diff --git a/t/t7900-index-helper.sh b/t/t7900-index-helper.sh
> new file mode 100755
> index 0000000..114c112
> --- /dev/null
> +++ b/t/t7900-index-helper.sh
> @@ -0,0 +1,23 @@
> +#!/bin/sh
> +#
> +# Copyright (c) 2016, Twitter, Inc
> +#
> +
> +test_description='git-index-helper
> +
> +Testing git index-helper
> +'
> +
> +. ./test-lib.sh
> +
> +test -n "$NO_MMAP" && {
> +	skip_all='skipping index-helper tests: no mmap'
> +	test_done
> +}

Even when NO_MMAP is empty, there might be no Unix sockets available (such
as is the case on Windows). In any case, you really only want to skip
these tests when index-helper is not available, so would you mind
squashing this patch in?

-- snipsnap --
From: Johannes Schindelin <johannes.schindelin@gmx.de>
Subject: [PATCH] fixup! index-helper: new daemon for caching index and related
 stuff

---
 t/t7900-index-helper.sh | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/t/t7900-index-helper.sh b/t/t7900-index-helper.sh
index 6c9b4dd..12b5bf7 100755
--- a/t/t7900-index-helper.sh
+++ b/t/t7900-index-helper.sh
@@ -10,8 +10,10 @@ Testing git index-helper
 
 . ./test-lib.sh
 
-test -n "$NO_MMAP" && {
-	skip_all='skipping index-helper tests: no mmap'
+git index-helper -h 2>/dev/null
+test $? = 129 ||
+{
+	skip_all='skipping index-helper tests: no index-helper executable'
 	test_done
 }
 
-- 
2.9.0.270.g810e421

