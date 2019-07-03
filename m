Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MALFORMED_FREEMAIL,
	RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=no
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id D30E51F461
	for <e@80x24.org>; Wed,  3 Jul 2019 11:25:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726780AbfGCLZy (ORCPT <rfc822;e@80x24.org>);
        Wed, 3 Jul 2019 07:25:54 -0400
Received: from mout.gmx.net ([212.227.15.18]:37345 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726581AbfGCLZy (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 3 Jul 2019 07:25:54 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1562153148;
        bh=52J4CWnxL0VQMQOILkvE3zkx8EcuSBcFYc4tARCtC/s=;
        h=X-UI-Sender-Class:Date:From:To:cc:Subject:In-Reply-To:References;
        b=e6haSy2UTnou6ohWHqkkdV/4g+B9ANMkomMIgbJfFaSksDmpCzDykMaMFiF7gfLED
         FXcVEP+iSCKTn+q2B685VqqZSyDds6C2jH2b/3SqaOVSr1BjQuLk2hYI75R6lQzzym
         jpVp5FZul+fstc4/g4ZXLbMIe+QD5ka3olm4rmTg=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [192.168.0.129] ([37.201.192.51]) by mail.gmx.com (mrgmx003
 [212.227.17.190]) with ESMTPSA (Nemesis) id 0Lpspj-1iD0f63rzL-00flYE; Wed, 03
 Jul 2019 13:25:48 +0200
Date:   Wed, 3 Jul 2019 13:26:16 +0200 (CEST)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@gitforwindows.org
To:     Karsten Blees via GitGitGadget <gitgitgadget@gmail.com>
cc:     git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
        Karsten Blees <blees@dcon.de>
Subject: Re: [PATCH 1/1] gettext: always use UTF-8 on native Windows
In-Reply-To: <ff37a2646a848e3eca8d02a001844986a3fa366b.1561625060.git.gitgitgadget@gmail.com>
Message-ID: <nycvar.QRO.7.76.6.1907031321270.44@tvgsbejvaqbjf.bet>
References: <pull.217.git.gitgitgadget@gmail.com> <ff37a2646a848e3eca8d02a001844986a3fa366b.1561625060.git.gitgitgadget@gmail.com>
User-Agent: Alpine 2.21.1 (DEB 209 2017-03-23)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K1:D5aQrEXtAs+j6xUcyWDZhM7+XjIyJEUMOHH3Zx2H6aUvvIJdzcn
 mhlIqQOj6bCs+mF+BgQUVBGDqO7VSiZtt/Ur52Kf0/lI02jF01nk52Cu+JjIi/ozzZ/ROdJ
 Twui/N5gN4bR3Y5fgsT0B6N0q8TSOkMfoNczrRKkhKBUcf4wGCIkeS8uvPeqpK5k4uHQHmH
 KJ7GjVfovetbEFWgAIYGw==
X-UI-Out-Filterresults: notjunk:1;V03:K0:xj5ocEyKc9w=:ZWb8LzoMLiV6dg7LkJlYqp
 S3QoFOPCdOYZc5BK0bp7GqH7MDpKfB7KHiX5zVR0b/9FUJ2ZGgseQIyjQtiuulv5YnYBv+6WG
 4VuiGJWjfdaiv7Dl6PoDusM7xq3Dz/MfD2Ron/IwH3oEOf6UrlvIoBXnV8C3UzjjLA3xozETv
 JDUDl271lRdJk9kOoCAKNAknilmo6V9EcvRxH9Acaq1sN8whAoUyb2PN00YM9Y3azvqZSMvLj
 AWO7W1rKGt3+aLcLSA3JnpUG0oY1eqvMOzM0gKJyEMbFpM+RvJi/ZqOybQkSA0YDZbCy+393Q
 uydpritXWQcoKl3GTRiXV3+AdKJLBrr7FP3e5SZerUmnzeOTXPojkfbU8CnSJOQZasSKMu8wT
 uYcUP4gu0cwp7a5oIIhHZHMG6L5wk2IUrQ0Vdo5TqDSPYQCyDSz9Y2GYIE2NjB0SCBPe0mX4x
 ELiXb6tYWEQSRv7x4xZD6R7Ejvv9GDkTEbEj4ZdhAs4l55uKj1/TLsRsnaoQT12He56a/wBka
 IeOMhaaRyUrGa0jhUEOxvLoWkoIgM2ru3nf4cQdC/u4PIjk2sWrhPRH9Qwfcnw5X18Qa7rvlQ
 IPv2DO9hzvn585QnHxMOJO9TIq7ivUp8465LZUCGd37akV9aC0U7AAfQbqAxuCjKR/XCcAY4G
 ta2WxL8fwOKYbz+64lbZnfS1yHvzn5xndNd7T3213u3Q6aFqaz1VMZlJuLCydVLzgnRMLdfAe
 /h+Di/bETAS/yVOHNp3dbnhZiNbRKn4ijIa95QZKKbi8TychINel0X+7/ULHqnw0S6kBm1+gI
 f+CIcSkX3nMALkBEXulGE6f3bUlz+18GJRjUM8pdu1QlTpwwQ//BJdxvHuiGTKZ5mI36beYWw
 AdarX7buEWTWA0WpSAktn0EUbE8/lpomWj3BqOpVISOQUYRu5QLe3P3vFg7kmUW3nb29NTmxT
 g7stN09PbYDnsYy+ZuYk3xEFJ6ycbTllBPdydd2nqSWw4VFHrz3Ls4JRcNRpk9tgPAG1/vPLP
 Q/LOaVRtZMiyc2GTEQLqRBpS6dOIT+hVDdOHHnbG4ikteblUFShPdy5HB1YO1llO5fHuqep4v
 48G7UUblYz81/+1M60fuJgGbB1V8PgmN92Z
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi,

On Thu, 27 Jun 2019, Karsten Blees via GitGitGadget wrote:

> diff --git a/gettext.c b/gettext.c
> index d4021d690c..d8423e5c41 100644
> --- a/gettext.c
> +++ b/gettext.c
> @@ -12,7 +12,9 @@
>  #ifndef NO_GETTEXT
>  #	include <locale.h>
>  #	include <libintl.h>
> -#	ifdef HAVE_LIBCHARSET_H
> +#	ifdef GIT_WINDOWS_NATIVE
> +#		define locale_charset() "UTF-8"
> +#	elif defined HAVE_LIBCHARSET_H
>  #		include <libcharset.h>
>  #	else
>  #		include <langinfo.h>

Sadly, this has a really unfortunate interaction with ab/no-kwset: the
latter patch series contains test cases that rely on being able to
use `LC_ALL=C` to prevent Git from assuming UTF-8 encoding.

I have this tentative patch queued up on Git for Windows' `shears/pu`
branch (i.e. the ever-green branch that continuously rebases all of Git
for Windows' patch thicket on top of `pu`):
https://github.com/git-for-windows/git/commit/e561446d

For you convenience:

-- snip --
diff --git a/gettext.c b/gettext.c
index 7da80db453c4..35d2c1218db2 100644
--- a/gettext.c
+++ b/gettext.c
@@ -13,7 +13,23 @@
 #	include <locale.h>
 #	include <libintl.h>
 #	ifdef GIT_WINDOWS_NATIVE
-#		define locale_charset() "UTF-8"
+
+static const char *locale_charset(void)
+{
+	const char *env = getenv("LC_ALL"), *dot;
+
+	if (!env || !*env)
+		env = getenv("LC_CTYPE");
+	if (!env || !*env)
+		env = getenv("LANG");
+
+	if (!env)
+		return "UTF-8";
+
+	dot = strchr(env, '.');
+	return !dot ? env : dot + 1;
+}
+
 #	elif defined HAVE_LIBCHARSET_H
 #		include <libcharset.h>
 #	else
-- snap --

Junio, please hold off from advancing `kb/windows-force-utf8` until this
is resolved.

Also: does that diff look okay? Or would you rather want to avoid having
that function defined in that #if...#endif block?

Ciao,
Dscho
