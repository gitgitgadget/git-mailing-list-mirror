Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MALFORMED_FREEMAIL,
	RCVD_IN_DNSWL_HI shortcircuit=no autolearn=no autolearn_force=no
	version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 7864420248
	for <e@80x24.org>; Thu, 18 Apr 2019 12:06:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388926AbfDRMGa (ORCPT <rfc822;e@80x24.org>);
        Thu, 18 Apr 2019 08:06:30 -0400
Received: from mout.gmx.net ([212.227.15.19]:53313 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2388344AbfDRMG3 (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 18 Apr 2019 08:06:29 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1555589183;
        bh=AV2e9exIuoZrXp+VitS3UMCYtfeeUsPebvy3tLAVbOc=;
        h=X-UI-Sender-Class:Date:From:To:cc:Subject:In-Reply-To:References;
        b=TzVGqvmolGEJLtMSWADEQSSHlfiAlz2N4jGV6ZRWkZ9RAOu7hFA1QMPicqjsDRFab
         TAbEz1AAkz4rpYjQNrHHbdyE2OYte5sgktgWksLDDE97a4SirSS8T1jh0kkE2LRYH1
         qBPP+1SeE2ZmXJzBwQx7pIEGkF6F2O3wZjD3pZgs=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [192.168.0.129] ([37.201.192.14]) by mail.gmx.com (mrgmx001
 [212.227.17.190]) with ESMTPSA (Nemesis) id 0MN1j6-1hAV9y2uoi-006hw4; Thu, 18
 Apr 2019 14:06:22 +0200
Date:   Thu, 18 Apr 2019 14:06:28 +0200 (CEST)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@gitforwindows.org
To:     Junio C Hamano <gitster@pobox.com>
cc:     Johannes Schindelin via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org
Subject: Re: [PATCH 2/7] help -a: do not list commands that are excluded from
 the build
In-Reply-To: <xmqqo957sq2g.fsf@gitster-ct.c.googlers.com>
Message-ID: <nycvar.QRO.7.76.6.1904181403330.46@tvgsbejvaqbjf.bet>
References: <pull.168.git.gitgitgadget@gmail.com> <7dc5293e9e0f8997674b1273393f22954e72c4cd.1555070430.git.gitgitgadget@gmail.com> <xmqqo957sq2g.fsf@gitster-ct.c.googlers.com>
User-Agent: Alpine 2.21.1 (DEB 209 2017-03-23)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K1:n10gFN1UHJ+r3b5Nya3kvHn60O3h6aaoJkyZuoiPNPhhKqxp2rX
 7A+sAc5UBsCvj27ilD6/2jNreMzRHFhlJ2/l41GiDny0dc8/2uWnxdjfzDHio/puieJOiDJ
 +WHTKzzHyywmFd95yCvpdxHhU37dCUe0q2lC8b9S+bMiCzJIXR9Qgl7+kYwEdIjz5erMoIG
 Rw/vuHqh3xFa3s/6Ph3kg==
X-UI-Out-Filterresults: notjunk:1;V03:K0:gqcHyWkmbGU=:XAR2bcyjrR9FeKcFIEUu46
 oqI8Pz7vwEKyDPXWS4dWzbN/C46Un7jFxC6O294dXwVa+Vqe9Zn+AZgzCy8MsUB9wJXa0vU6T
 mzeCdcvQv7MLIVibu7FNyR6Ki4FRZi0uX9drgQCfuO6Vg/W7GG1/BkitUl/Buv305QQJWWtn1
 8kCnig3M7q6P/QRKnKUKbah4t8h1gLbpHdn/h7qoNasB10k6xl6O9h6DWoqTn74bqx4Tx5+fh
 wuCAJV1Q/EHHrsgAvIBBTlB4Hm2fDQ6UX3dn+bnzsZ8gbajYKOfh0a8pOZEPYpNt3ZvqSXBE4
 YOdLKLG+oFIOJTMkdmRIhrQ8BF98tGLBO+tlKrS8wI7zz7gPGg9vtrNKGdAYR+hgTe2I/2kyO
 YDdXMjqmXSx+Lt5Pe3raX3SlAmVFHCbmDAIftaWGYoOmaJ5oF1NpvNz2hy7Bax087H/tf8DyH
 nDauOXl7nlEDBxBEA5Obv72GYxavqwn5z5GyNVtMbfUHLeeuLtrMxahEJYxtwsqelju3UuH/5
 l4hMncZZkT8tk+A9o9QQvBSzNi6CRZLaYtOYiqscpbAVfsmX2TIcZU/DmjWiTbnHnOHusQ7Oz
 wY1V1eZWm9rMnZQKeNnKDDxB68R/1j+HVGWOuPWXZS9BItybKjZDy30GZaXPYkD4LmdfQekp3
 QmVrPUfAnHzvS+MZQkd1jk0T8H8tzfviThQ7NnLRHkI2+Qc5SfHXEEzV1L/6SM45qmQF6UO5O
 GQLyu7H0UzvwFMTHaLkh+1ePXitRA/RR4kq6oanMFYS4fQpXGyjhjZ4WDqfKuk6MP2z8djGwM
 V6sodX59/HSMVgbz47eABGirzs6yAI/VJQRLjSjG0Pb8I8Kf/P0YIX5B+F3Kh5Z0BJZOE746K
 +7mB/CgZt16Kqfv40/1nzlrMID5Nt5rZEZgLqbe1qMi+4tVOr5rLNVkyxQ3jCQ07C2fHCIX/m
 cilE/x5EbUw==
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Junio,

On Mon, 15 Apr 2019, Junio C Hamano wrote:

> "Johannes Schindelin via GitGitGadget" <gitgitgadget@gmail.com>
> writes:
>
> >  SCRIPT_DEFINES =3D $(SHELL_PATH_SQ):$(DIFF_SQ):$(GIT_VERSION):\
> >  	$(localedir_SQ):$(NO_CURL):$(USE_GETTEXT_SCHEME):$(SANE_TOOL_PATH_SQ=
):\
> > diff --git a/generate-cmdlist.sh b/generate-cmdlist.sh
> > index 709d67405b..7867b99d19 100755
> > --- a/generate-cmdlist.sh
> > +++ b/generate-cmdlist.sh
> > @@ -6,7 +6,7 @@ die () {
> >  }
> >
> >  command_list () {
> > -	grep -v '^#' "$1"
> > +	eval grep -ve '^#' $exclude_programs "$1"
>
> The original protects against $IFS in the filename given as $1, but
> with the eval that is no longer true.  We have been feeding the
> constant "command-list.txt" to the program since its inception, and
> I do not expect it to change, so this regression in defensiveness
> does not matter in practice.  Also because # is prefixed with ^, the
> unintended loss of quotes around it when the eval makes the shell
> re-parse the generated command line would not make the remainder
> into a comment.
>
> But it does look brittle, and smells like a trap for less
> experienced shell programmers to blindly copy & paste & tweak
> without understanding what is going on, leading to bugs.
>
> 	eval "grep -v -e '^#' $exclude_programs" <"$1"
>
> or something like that, perhaps?

Yes! Thank you.

> > @@ -93,6 +93,14 @@ EOF
> >  EOF
> >  }
> >
> > +exclude_programs=3D
> > +while test "a$1" =3D "a--exclude-program"
>
> s/a/z/g; if you want to pretend to be old-fashioned, but s/a//g;
> should be sufficient in the modern world.

Don't you know, I always used "a" without realizing. You can see my
misdeed even in git-rebase--preserve-merges.sh. I won't fix it there,
though, as I hope that it'll be gone soon enough.

Will be fixed in the next iteration I send.

Thanks,
Dscho
