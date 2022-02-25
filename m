Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E9AA8C433F5
	for <git@archiver.kernel.org>; Fri, 25 Feb 2022 15:42:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240394AbiBYPmn (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 25 Feb 2022 10:42:43 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38238 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241142AbiBYPmj (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 25 Feb 2022 10:42:39 -0500
Received: from mout.gmx.net (mout.gmx.net [212.227.15.19])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3374322B97B
        for <git@vger.kernel.org>; Fri, 25 Feb 2022 07:42:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1645803719;
        bh=E3eimylLuA4UdLIMyBkkh1lQM4aVHQT6TKWVVFHAMx0=;
        h=X-UI-Sender-Class:Date:From:To:cc:Subject:In-Reply-To:References;
        b=dtajkcFui+f0gf+fPWQHylsKHF3ic2Sg5O9Sfm0RyZ52dD/Vdb76tJuQSS1d5iqXd
         D72z81bI8Ph6XoK9U6eB5c7esQzSKnyIskggiptjTLiAUBMEO32Xu+WvjMsToEZip2
         zeeG6ZE6ZCpQyJ5cgl3vrCkybAc5EWOIm4dVOYeg=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [172.28.129.168] ([89.1.212.236]) by mail.gmx.net (mrgmx005
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1MHGCo-1nRyKN148u-00DFNw; Fri, 25
 Feb 2022 16:41:59 +0100
Date:   Fri, 25 Feb 2022 16:41:57 +0100 (CET)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@gitforwindows.org
To:     phillip.wood@dunelm.org.uk
cc:     Edward Thomson <ethomson@edwardthomson.com>, git@vger.kernel.org,
        =?UTF-8?Q?=C3=86var_Arnfj=C3=B6r=C3=B0_Bjarmason?= 
        <avarab@gmail.com>, gitster@pobox.com
Subject: Re: [PATCH v2 1/1] xdiff: provide indirection to git functions
In-Reply-To: <e73c6746-9f8d-7e23-3764-18d01307278b@gmail.com>
Message-ID: <nycvar.QRO.7.76.6.2202251639590.11118@tvgsbejvaqbjf.bet>
References: <20220217225218.GA7@edef91d97c94> <20220217225408.GB7@edef91d97c94> <e73c6746-9f8d-7e23-3764-18d01307278b@gmail.com>
User-Agent: Alpine 2.21.1 (DEB 209 2017-03-23)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K1:5Y0j+0EKg83r3fHJBYoj/dy45XMJt65M2axPWI/NGW6fDVTmMYi
 J/wc//oD8P2+P5zGoyLD7JAWBfcUagnSN9oUztCN6yKnGcYHq7SFFd/kJ9Wv8+C6M/Vxvn6
 3j0ZneLLt5sBmRxtjVvt50uVYzdLtf4XV1Rli9174V+4T2OTqeZbaWLtSyxJ29xaCFO9jr7
 cnTW0DtvoFcDRjWfuLpLA==
X-UI-Out-Filterresults: notjunk:1;V03:K0:CQKjZJVbcIQ=:jQjxtMZ0LU978tiponeX2m
 2/MDcr+cme6GyqCjmVBC09NTb1LzOIuyvLZSy0WbpiN+Ah74CSL1AfIvf59hqz6cmRy9ZMq4c
 paGixzJrWMjmkgD2PkmU7wQdx0R9cgMKqqPF/jFhPGNsm0+6b5Sc71M8d0zeXi3YPdAC7w2oA
 g1d7/N7O5gXk+fDsHOowAWecUo2BpA8RUAlv4AuuVbhc+TQjTJLtZeizyul6mwtbadc0EFufU
 Swqfr3vEQAH4dgwedbrhSE/fE3tYZ67mFDQYoHMfSeeqqg6SdXo6sjWwOBkBlZJUrBQQqWpme
 kSPnHOHwfjv1EfUXWP90gbJSS5WeLo646UlSShJt96iRZMZQvv2/GQIcSzOa2grlxfokgV9R5
 a2O2SN7rUPHTJtb87gGVdTnrk6HwdPLn3+3aJ1SZwch6YNgRMjmFzXxwKlKZ2550TMjrmtB27
 /o8Ogbs7JmHbeHKzlklrpPnB0dAF65gWQjAi/qw2znkGCdZRr1quVgv4iTH19EFQY7AnGXza6
 BROkgnOnlT66DlaRhfefJ+tiqP8yMdhurpH1x27wKQAegZseCMXeJQ6lGNxmTYmY8skDttZza
 zP5Tge4goCCfXkEVKkxEHJatPc3emM/tdJr1EnBhZvMzgyUn/lC4VSixLrriW/Y50ZHfwoSYR
 2++GWpjv3LBGwRn/wgWDfZ9/fp1tNjQfTrBF+sckRow5rbG9Fi+mVVIVPurrHrVqJBbmebwQD
 rfu2z2UMzm3YVpbLYXdRgRHGFdqz507Tk1s/17GPMuMRhU0UIkU3zKY0r3MP2+78G6gkJYv67
 esBRpm/YxYRQcyG32RjZtazQpsTOcjSa78zyThoRSSWZtZ0IeJauXEI7Am0dQfg6NdFrAMfWg
 P6QfaKrFBAQyVoX1R3L8GstTcZSjulpzHUplPGqDg/RNKgbcilg9pL94Gqd26KtGt7F518/IF
 Nc7z/ltocJluOOHt20LlTYD9A4F4mPo2/oP3o16ot8I992LWDH3nwtOvTNz6+QYA5PVsPRpQw
 B0B05Krmpz7LwdcQcOrm9F3WH3wAaq3Dn+aw/zxQatq1hmSw/Y8cWN2C/3MIWXzchCyMtk9sN
 xhizG+muduizeU=
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi,

On Tue, 22 Feb 2022, Phillip Wood wrote:

> On 17/02/2022 22:54, Edward Thomson wrote:
> > Provide an indirection layer into the git-specific functionality and
> > utilities in `git-xdiff.h`, prefixing those types and functions with
> > `xdl_` (and `XDL_` for macros).  This allows other projects that use
> > git's xdiff implementation to keep up-to-date; they can now take all t=
he
> > files _except_ `git-xdiff.h`, which they have customized for their own
> > environment.
>
> The changes since V1 look good,

Indeed. This is the range-diff:

=2D- snip --
1:  52c8f141cbe1 ! 1:  e05e9b5e2f27 xdiff: provide indirection to git func=
tions
    @@ xdiff/git-xdiff.h (new)
     +#ifndef GIT_XDIFF_H
     +#define GIT_XDIFF_H
     +
    ++#include "git-compat-util.h"
    ++
     +#define xdl_malloc(x) xmalloc(x)
     +#define xdl_free(ptr) free(ptr)
     +#define xdl_realloc(ptr,x) xrealloc(ptr,x)
    @@ xdiff/xdiffi.c: static void xdl_mark_ignorable_lines(xdchange_t *xs=
cr, xdfenv_t

      ## xdiff/xinclude.h ##
     @@
    + #if !defined(XINCLUDE_H)
      #define XINCLUDE_H

    - #include "git-compat-util.h"
    +-#include "git-compat-util.h"
     +#include "git-xdiff.h"
      #include "xmacros.h"
      #include "xdiff.h"
      #include "xtypes.h"
    -@@
    - #include "xdiffi.h"
    - #include "xemit.h"
    +
    + ## xdiff/xmerge.c ##
    +@@ xdiff/xmerge.c: static int xdl_cleanup_merge(xdmerge_t *c)
    + 		if (c->mode =3D=3D 0)
    + 			count++;
    + 		next_c =3D c->next;
    +-		free(c);
    ++		xdl_free(c);
    + 	}
    + 	return count;
    + }
    +@@ xdiff/xmerge.c: static void xdl_merge_two_conflicts(xdmerge_t *m)
    + 	m->chg1 =3D next_m->i1 + next_m->chg1 - m->i1;
    + 	m->chg2 =3D next_m->i2 + next_m->chg2 - m->i2;
    + 	m->next =3D next_m->next;
    +-	free(next_m);
    ++	xdl_free(next_m);
    + }

    --
    - #endif /* #if !defined(XINCLUDE_H) */
    + /*
=2D- snap --

My ACK from
https://lore.kernel.org/git/nycvar.QRO.7.76.6.2202171644090.348@tvgsbejvaq=
bjf.bet/
still holds. Junio could you please add it before merging it down to
`next`?

Thanks,
Dscho
