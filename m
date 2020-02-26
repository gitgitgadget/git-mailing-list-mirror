Return-Path: <SRS0=QAHC=4O=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,MALFORMED_FREEMAIL,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 02F70C4BA13
	for <git@archiver.kernel.org>; Wed, 26 Feb 2020 16:12:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C11122084E
	for <git@archiver.kernel.org>; Wed, 26 Feb 2020 16:12:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=gmx.net header.i=@gmx.net header.b="NzJYBm1m"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727158AbgBZQMz (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 26 Feb 2020 11:12:55 -0500
Received: from mout.gmx.net ([212.227.15.18]:37645 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726278AbgBZQMy (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 26 Feb 2020 11:12:54 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1582733572;
        bh=75DwHqzDROBxwnBjvX/G9RE1peiA4Bj3yGEoRlbwQlE=;
        h=X-UI-Sender-Class:Date:From:To:cc:Subject:In-Reply-To:References;
        b=NzJYBm1mdVaJZhWZQUxsid9mcX03B+GMeEauK5YUvC+SxQRMwzOcaA5q6lfJS/ai7
         u1gU6MgvOKYh6MDmMA+r+2s23lNh+HqLwN+GzhlYG5liHVI66HReKAJApBE8lIxBlj
         UeWnOnPJIVcO8tiLO/bASfMyxwZ2M85KYh+eP+64=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [192.168.0.213] ([37.201.195.86]) by mail.gmx.com (mrgmx004
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1MTAFh-1iz76a3f7n-00UXMS; Wed, 26
 Feb 2020 17:12:51 +0100
Date:   Wed, 26 Feb 2020 17:12:50 +0100 (CET)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@gitforwindows.org
To:     Emily Shaffer <emilyshaffer@google.com>
cc:     git@vger.kernel.org
Subject: Re: [PATCH v8 03/15] bugreport: add tool to generate debugging
 info
In-Reply-To: <20200220015858.181086-4-emilyshaffer@google.com>
Message-ID: <nycvar.QRO.7.76.6.2002261652400.46@tvgsbejvaqbjf.bet>
References: <20200220015858.181086-1-emilyshaffer@google.com> <20200220015858.181086-4-emilyshaffer@google.com>
User-Agent: Alpine 2.21.1 (DEB 209 2017-03-23)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K1:TpVLCSdq2sEQLUGgEHmJx8KeHCI7Nmx/v2B0TkiUF0jxuCrT5d2
 KNb2xwHaL/6xry1pMOljz2d1qNZCAfjPMB87thftLz1bnpDQzV+Y+f3lqCf1AsS+rjlaY4K
 bCNEr8tl8zwUkeyVsG3iyj3rksJSJNTQGnAbCpQSDw8z1VfzAuT7M1loAZX3oPGq3DPj5Z8
 tEsPi2ei55Tm5ioEdxX6Q==
X-UI-Out-Filterresults: notjunk:1;V03:K0:YW2zjLHsF4I=:ZLRBRVvKcoB33wvne1CJRg
 ERcyESIgRKxTYl5pBNo1PHN8DHf+/0nc3azmd8u04Jt7Q6e4tLDZu9gJiawe1asyPNzt6gbcO
 AvFTKuWulRjqYQ6vl3jhTkq3kq7iJ6BvVzSldH5HUBaaLN7mEBmwRHYOueT+XmCyvKEvdQcDM
 f/xXftnCzOUY3oLGFPh/vbQ6EaIEpith1Bhsc738v8lgDzVTvRnBSohKlrQuU7sda/olsBGHy
 cHRrU4ETq5DHbSDZggViXGLvhtKzlig0yy8S6Q994maV89qUTaLHhU5aQl3OwKdZRnXeusfAo
 doT20L87wRCaAhVp5wjggEUjlqxWTjTx+NuEWy9qDqoFXiDA1xKNc0urVsctnYJlnjPUN1aZh
 NQzNSfKJF6scFIifxapgnxKfCKvrKLNoMgh0WyiW2ay0Mg+ZSWq2tNW4ef7nzIIPHfTB/fPK5
 UK5U7UpO1i/ks4iHVpgVdyxzhAWsQgmb+oCj+YyJQv1EaDIOExWDcjgS/4HUBRcLx0l76dqJc
 pW6+jUCnBIMQupI/LkSQ2knU53lMQS0Q+Svx5V37LPZEDCNJc84T9CaDbbrUm1Ed3NreJgdVS
 k21ZFalPquuMd4KJ9C3Yy4yNalGtfH5wzp8zdh6YyuMD7VBDHipjScPo8n5fr/buiTJRVxd1E
 b3tBwDVH7ZkOoiGJ9R2PNVvMrAQlbc68Rsp44o5vRqRquI5Ag7H09ZH1b6VGTCvOWn7dOEvpT
 78TbFMZOnc/lzfW7zjQADARtT9UkFCuIcg63th3NtzXGiN5q2KVohamp4q11J6HOH4RCataDd
 BuB2b/FarCMtyZdUHSWgesQD0nKdjxdwok9S24ja3nGy6ADjxLw5eer1buZ8hzPub08hrDYsB
 dcFhKWRZ+Dbsd+giCF9Kd1O18cYe6OS/rQx5V1b03ZvoErIZ+y7v5g11WD6o7ALVg8cyUBspB
 xxQANqKpUj1LCmKtZYnOJJIN2YBQPW91C9GLmaOojo6NdCtxshyALfXZGdPzBaIWko4JtCFHQ
 dL9J7Lg4TsVElLvq3+Xf0KjCU+Nlf+uc3BK+EImQ8dt+wrVir6owqLGJJHqUGqqcrzpybThen
 sL/jVLiNhUJzagzw199mC55ZzMMja6vwoUV8uHicRaMwMvZNn2yTPXkll64nTDFKbatGeq/FY
 WomdJAfBb9jMGt2LLBKZ1z603qIMvN/FzfSwufTwwa22VGu9oCbKZ2U/qJNALUpIIw294WMRG
 h3zb6NAHnqfrXD1qu
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Emily,

On Wed, 19 Feb 2020, Emily Shaffer wrote:

> diff --git a/bugreport.c b/bugreport.c
> new file mode 100644
> index 0000000000..8d4a76fdac
> --- /dev/null
> +++ b/bugreport.c
> @@ -0,0 +1,94 @@
> +#include "builtin.h"
> +#include "parse-options.h"
> +#include "stdio.h"
> +#include "strbuf.h"
> +#include "time.h"
> +
> +static const char * const bugreport_usage[] =3D {
> +	N_("git bugreport [-o|--output-directory <file>] [-s|--suffix <format>=
]"),
> +	NULL
> +};
> +
> +static int get_bug_template(struct strbuf *template)
> +{
> +	const char template_text[] =3D N_(
> +"Thank you for filling out a Git bug report!\n"
> +"Please answer the following questions to help us understand your issue=
.\n"
> +"\n"
> +"What did you do before the bug happened? (Steps to reproduce your issu=
e)\n"
> +"\n"
> +"What did you expect to happen? (Expected behavior)\n"
> +"\n"
> +"What happened instead? (Actual behavior)\n"
> +"\n"
> +"What's different between what you expected and what actually happened?=
\n"
> +"\n"
> +"Anything else you want to add:\n"
> +"\n"
> +"Please review the rest of the bug report below.\n"
> +"You can delete any lines you don't wish to share.\n");
> +
> +	strbuf_addstr(template, template_text);
> +	return 0;
> +}
> +
> +int cmd_main(int argc, const char **argv)
> +{
> +	struct strbuf buffer =3D STRBUF_INIT;
> +	struct strbuf report_path =3D STRBUF_INIT;
> +	FILE *report;
> +	time_t now =3D time(NULL);
> +	char *option_output =3D NULL;
> +	char *option_suffix =3D "%F-%H%M";

This is not a portable `strftime()` format. Let's squash this in?

=2D- snipsnap --
Subject: [PATCH] fixup??? bugreport: add tool to generate debugging info

The `%F` format is an optional extension to the ISO C standard, see
https://pubs.opengroup.org/onlinepubs/9699919799/functions/strftime.html

And sure enough, in Git for Windows, this leads to a test failure
because that format is not supported in the version of the MSVC runtime
that we're stuck with.

Let's just use the long-hand instead.

Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
=2D--
 bugreport.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/bugreport.c b/bugreport.c
index a3528a2e2b8..3f78db182e6 100644
=2D-- a/bugreport.c
+++ b/bugreport.c
@@ -338,7 +338,7 @@ int cmd_main(int argc, const char **argv)
 	FILE *report;
 	time_t now =3D time(NULL);
 	char *option_output =3D NULL;
-	char *option_suffix =3D "%F-%H%M";
+	char *option_suffix =3D "%Y-%m-%d-%H%M";
 	struct stat statbuf;
 	int nongit_ok =3D 0;

=2D-
2.25.1.windows.1

