Return-Path: <SRS0=Rj9+=DP=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.2 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MALFORMED_FREEMAIL,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1BA13C433E7
	for <git@archiver.kernel.org>; Thu,  8 Oct 2020 09:32:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9E2D9206E5
	for <git@archiver.kernel.org>; Thu,  8 Oct 2020 09:32:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=gmx.net header.i=@gmx.net header.b="i7seVG5m"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729155AbgJHJcL (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 8 Oct 2020 05:32:11 -0400
Received: from mout.gmx.net ([212.227.17.20]:51575 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725852AbgJHJcL (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 8 Oct 2020 05:32:11 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1602149524;
        bh=3amB8eZRdO38ONZfYIlQ6vRJ0DNBcNXx5PGyP+Rd5Ck=;
        h=X-UI-Sender-Class:Date:From:To:cc:Subject:In-Reply-To:References;
        b=i7seVG5mjR9ygyMIsOlqNYKT3hl6H6QVdHIYIMqcPmaLzWPfogSD+kkAlgjcvN3Z2
         wdk2nrvQmt3KGYpWmb1XEyMInoWZLE/nxVdwXOBwK0bvo2BK7h6mji/Z7OtG4KAUSf
         R1ZY76n+Vl90GW/Ckpdb+hH4FJc1lc3y3XMNrqmU=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [172.20.73.169] ([213.196.213.184]) by mail.gmx.com (mrgmx105
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1MNt0C-1k2A8402oq-00OElD; Thu, 08
 Oct 2020 11:32:04 +0200
Date:   Thu, 8 Oct 2020 11:32:03 +0200 (CEST)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@gitforwindows.org
To:     Denton Liu <liu.denton@gmail.com>
cc:     Git Mailing List <git@vger.kernel.org>,
        Junio C Hamano <gitster@pobox.com>
Subject: Re: [RFC PATCH] Makefile: create externcheck target
In-Reply-To: <1c2ee1c40ccde18a008262aeaf23a17da2064eae.1602142232.git.liu.denton@gmail.com>
Message-ID: <nycvar.QRO.7.76.6.2010081125390.50@tvgsbejvaqbjf.bet>
References: <9e5a8625cab217bd6aaba68da081bc801354b903.1602059508.git.liu.denton@gmail.com> <1c2ee1c40ccde18a008262aeaf23a17da2064eae.1602142232.git.liu.denton@gmail.com>
User-Agent: Alpine 2.21.1 (DEB 209 2017-03-23)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K1:lTCiZNsHVscGblkrZoy7THW7sXAo9L4yHQKtCUfMLerplG1+cuA
 vuPWiiZ3nLyb8XtPy9o2fRRKsX84KWnGCyQr1LTM6PUdhUfFYa+ZWOeFJEYc3RqdSu68XXy
 Rp7Tsls0sOAX/3SDcLxxGxsyNSXQh9170uRncIOECD9dPpEUqjtps2viQSxBRe1NINsyktd
 7CPn2RHpvWgZ/q5vh00zg==
X-UI-Out-Filterresults: notjunk:1;V03:K0:8OieevPobA0=:KjQW3HGg3I6/StKXPuN84h
 nKrXMWT7e33PQOLfrmXy0+hASiGMUtk9Jrq83mkmXyez9NYsnIeqjEgQAlcQuHf6dmtJ5n+y0
 1eoITRMDZKupoFHxs58W1gUI1feRW+mqHLi6xv/dXN2vMQttlV7esbrdTv0ZYfPqn06I/PaVe
 aLRelowaq1WDJ7XG9YvRbxuLBKBHO1EO2GUktBSfGnaoW1w2rcn+bdrE2fjttXXje3rWJcon8
 kO0qqNQzGoRWfB3XoC8RuzYCiYxpGei68jqJSYrcYjsvGI3rH+J1T/3iUQzfcfAU/K63zPrhC
 Ow9nyCfXpDlxZHWzg0qkMGBCr4w34B/YHoLXr7PuJZiHVR+8PXWcyJt+l2+9dw8auZoOKdC6m
 Hgd8c6peJLgL1tI91B4CO2LGP/AE235dlprKAD3oY8eHhZyDk2ieDM/q+dnXOzXlFO2n4xsN4
 DYzk4jSDFkbcgp6qhcLI12PdHvYwIW/JWQPmO0z+3f2g4xxIm4PcCYNknfzXY/IJlI6LeLuOn
 AQ8zXbd7ZSjA5HMzFM4jAhlc+A08zffuAOcXC4cAw78/mKo8q3nVw9kUlYfYDHu5CwTwnoKtu
 QJTS8GOLsCDP6kOmcb/HyjW/BvlLjNC7tsA7Sb5JQ4/nt8lP1olHQ6JAlH1WJYylUFC4KjohS
 H4rQX7bgQnUnV5kZJGYZJhtmgI9CF+j9eU1X3E8vh+84lnsZcPIQ/df3F6ceYmovrJIDjJZDl
 O3GKFRajqp4J72XZcNcOV9qAmbalAN6HdYj++rmQfuukEIoRsDm2moKFb0NJK0zXm5/wL8G/i
 P9jE89RcVDTsdmEY4YGIkiV0mAofIoq4tfkGQoG3tNnlYYE6iScxsoiSEXPBSdr2NLIYTOabY
 W/eYLrSx3NAqP8K1iGX6yUiT0zgeJ3XXoh29+BboThnHVDiLaMtnWZUDr4xG5Uslu3vDxpNtV
 t5klbw2YkIJ0GTYW+m43A6P3av7eQnOVhbIrqQPUXMEOJh8KS6m6av+FC7aTD99TICL6a/SU1
 zDeuzv27khnBEBl0c7mY4PBOVpTvJlJtpvBo9Oa7sbvy7Y/z7+pT+kmP0l/u5XPb6lfMXln2Y
 yqACuVDlXBAKmhG2A0sIRC1XnmVKk82gW97XNy/Np5MAJJmMy+BrAuVqfpxtPYB0iI1Au4xqe
 UHIAaTTbUOd8amg7uqwPgLdKn0l9Yj3AMQPQpmhQrBA6EJBQEIPvi/8vipEIjTA832wneTX5q
 uuwqkSEmQShCm0ZbcOmXmetEMujO1LjcMWpEpRA==
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Denton,

On Thu, 8 Oct 2020, Denton Liu wrote:

> In b199d7147a (*.[ch]: remove extern from function declarations using
> sed, 2019-04-29), we used sed to remove extern from function
> definitions. In order to help find and remove future instances of this,
> teach Makefile the `externcheck` target which runs the sed script
> included in that commit on all applicable source files.
>
> Signed-off-by: Denton Liu <liu.denton@gmail.com>
> ---
>
> Notes:
>     I run this target periodically to ensure that no new instances of ex=
tern
>     function definitions are introduced. Is this something that we want =
to
>     consider adding for real?

Sure, and then hook it up in `ci/run-static-analysis.sh`.

But maybe add it _after_ coccicheck-pending, and add it to the `.PHONY`
line that's just outside of this patch's context lines?

Ciao,
Dscho

P.S.: I am not really certain that the `\s` is portable, I do not see any
mention of it in
https://pubs.opengroup.org/onlinepubs/009695399/basedefs/xbd_chap09.html#t=
ag_09_03
and would therefore expect BSD sed not to handle this correctly. In any
case, the `-i` is _not_ portable, as BSD sed takes a mandatory argument
(see
https://stackoverflow.com/questions/5694228/sed-in-place-flag-that-works-b=
oth-on-mac-bsd-and-linux
for more details).

>
>  Makefile | 3 +++
>  1 file changed, 3 insertions(+)
>
> diff --git a/Makefile b/Makefile
> index 5311b1d2c4..791faa24cf 100644
> --- a/Makefile
> +++ b/Makefile
> @@ -2885,6 +2885,9 @@ COCCI_SOURCES =3D $(filter-out $(THIRD_PARTY_SOURC=
ES),$(FOUND_C_SOURCES))
>  	fi
>  coccicheck: $(addsuffix .patch,$(filter-out %.pending.cocci,$(wildcard =
contrib/coccinelle/*.cocci)))
>
> +externcheck: $(filter-out $(THIRD_PARTY_SOURCES),$(filter %.c %.h,$(she=
ll $(FIND_SOURCE_FILES))))
> +	sed -i 's/^\(\s*\)extern \([^(]*([^*]\)/\1\2/' $^
> +
>  # See contrib/coccinelle/README
>  coccicheck-pending: $(addsuffix .patch,$(wildcard contrib/coccinelle/*.=
pending.cocci))
>
> --
> 2.29.0.rc0.261.g7178c9af9c
>
>
