Return-Path: <SRS0=d/2q=6J=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DDA9EC54FCB
	for <git@archiver.kernel.org>; Sat, 25 Apr 2020 12:33:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B251C206ED
	for <git@archiver.kernel.org>; Sat, 25 Apr 2020 12:33:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=gmx.net header.i=@gmx.net header.b="kzyY9lYw"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726073AbgDYMdt (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 25 Apr 2020 08:33:49 -0400
Received: from mout.gmx.net ([212.227.15.19]:34037 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725925AbgDYMdt (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 25 Apr 2020 08:33:49 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1587818027;
        bh=Zjov4kXi2dSIgJZcqIseXiiKWdvpkNwv4RoynH78WRg=;
        h=X-UI-Sender-Class:Date:From:To:cc:Subject:In-Reply-To:References;
        b=kzyY9lYwdmJIuQrzsyAH6beYDDmQ9G4P9CGGM7W5/LF1E1lJmBTnMiybPVKzWn9h0
         MYcilizArLvBAjNFwoJR32TMiHC6nJcYGddCEf8HLEgoF6CXL9CFuXtz0mPPge5Wkg
         Hb7ceZVmGVkqnW+nGmJcw8pY3GhZLWXddWxaJbUM=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from MININT-QA14EDB.fritz.box ([89.1.212.117]) by mail.gmx.com
 (mrgmx005 [212.227.17.190]) with ESMTPSA (Nemesis) id
 1M3lY1-1jT9574Avj-000vOz; Sat, 25 Apr 2020 14:33:47 +0200
Date:   Sat, 25 Apr 2020 14:33:47 +0200 (CEST)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@gitforwindows.org
To:     =?UTF-8?Q?Carlo_Marcelo_Arenas_Bel=C3=B3n?= <carenas@gmail.com>
cc:     git@vger.kernel.org
Subject: Re: [PATCH] macos: do not assume brew and gettext are always
 available/wanted
In-Reply-To: <20200425061531.12845-1-carenas@gmail.com>
Message-ID: <nycvar.QRO.7.76.6.2004251430380.18039@tvgsbejvaqbjf.bet>
References: <pull.616.git.1587628367528.gitgitgadget@gmail.com> <20200425061531.12845-1-carenas@gmail.com>
User-Agent: Alpine 2.21.1 (DEB 209 2017-03-23)
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="8323328-1561261481-1587818028=:18039"
X-Provags-ID: V03:K1:C4+XBuQGeZMabV7srGVTgXGz9SKyhD58/funLlTckTvVATt4IKP
 1VAumfmNhfaZM+fLZ8wWStJKHnNbbDjmKXBweBVHXMFO6o0Mq/zi6v78U/7bfluAs1Pofq/
 zhBTn8SJ6+vlqZi9ncrRM1DRYIrc+hs90Q/XwXpQQwA9+JpsBVqBOrYVKI2LCqXWTt+7bt0
 kiyGZNrsDsuG7LY+f6IFw==
X-UI-Out-Filterresults: notjunk:1;V03:K0:h3y0MTeTrcA=:9bQIJ4V7+FTEtRZgy8uA7c
 UpbQjOVUAXOVEYxDGCj/OjMrmv+58RWgHqyZzAHsUbaeDXRMe0ZarmamN/w9kTF/4ZY0MYFWT
 /Enunq5fYOu0tcK66opNMoStqgteTdKyWItuA3GjHvGyE7obMsTsSX9bkLse2SGs6rl90dIDB
 0gTECp2PmEGO+Vt5I7DINt/MdSKo6N7qSs3ufc16vkZ3KVe9IujQzVMvOszqVen71H0lDmn6r
 5Ohee3HvsjNfvAy5biyiER7hIxTv8DlNtipQwHkhW43NXJ7KUixcEnfcBUxchjIcrGe1WbwB9
 rshyYOFOu616V6vjEfW+G06xN21TZPHeTvseU9MdybE/x50POHSstzbthtrI37FHl8mRDhHuA
 IBHSo9sbh6ir34A6vDv1TBJC8J0lKyghT88zOy1bP/0tWLVQJzuexF4QgUuIU4ZozVbToOTVX
 G68egSCfXRn9Xh3se+LT2gi/k9ctyfjzBljsBMxR1seJtjvz7M6l3Pse6UpP2UAzKWRlukCXU
 qcUHCTSEnPX4k2NjIp1NbqjbvXE9UecFXwkn1scp4kdnWQHxORtpUqtt/FozN2w3IY2CpRWoD
 V/1Uk/z3vglpa0aLroYKIv3K0j47UCgbyj3eT4YQgnCgLYpn0ps2gA/ZHoBYf6sQWUqEcKmek
 P4/O2jt1ZzbRc+RNErBrYekTcZu2lPeDuEny2TwKcC7OS44l1P/dPUzptaa5XpJkNjxTor6rL
 72vTXUxsIXTiNU0sf6SUsKBKAhGfmhxeXqlC7rIkvdHIuG7qCBUwS1f6BSpy4pCEZfU91ltFH
 azOoCXMdrLJVXVJzg45GMo15OPTyhRwLIbTWz8x1wTxhpN9TDEpi/bDR+7b/jLXriQDcVhRpa
 BZPp0XLf/BoAYwEZXDmroBJUTBWWtIGzxSf6F5LSkCEcX8M18otiBMApkijPwf6xyGVTSxcaK
 MT5r2rPoJgi24NTewAQS8NSSc2zD7VXZFefbx4irSeesv2p96i0lZiq8X6mLYE0fwS5mogWYF
 k9ABHLG6Z1sPs2/4bBo9cYYhmBN2RWcH/u32x8z4yoPV+MRWmKgw3UL2NEv5eyjEypjAunI+P
 wXBgzwWepI/FBtL0RjKYUm/grPovPu0sDQ9qUG2nmKzFbSUILAt2oaQWV0mXcaj9bBpQkDv9D
 ugF5zFbjTULo9scHtbnC+IuY9z2S56xpRwxBSxn2uNkzaP0yHMjoKCA++qvI456WLDh+elzq3
 o2Jwcb16Pz7dwNgeQ
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323328-1561261481-1587818028=:18039
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Hi Carlo,

On Fri, 24 Apr 2020, Carlo Marcelo Arenas Bel=C3=B3n wrote:

> since 27a7067308 (macos: do let the build find the gettext
> headers/libraries/msgfmt, 2020-04-23) a build with `make NO_GETTEXT=3D1`
> will throw warnings like :
>
>     LINK git
> ld: warning: directory not found for option '-L/usr/local/opt/gettext/li=
b'
>
> localize the change together with all the other package specific tweaks
> and make sure it only applies when both gettext was needed and brew was
> the provider.

Okay, that makes sense, but...

>
> Signed-off-by: Carlo Marcelo Arenas Bel=C3=B3n <carenas@gmail.com>
> ---
>  Makefile         | 9 +++++++++
>  config.mak.uname | 7 ++-----

... moving this into the `Makefile`, i.e. make this even more independent
from Homebrew than before, is probably a bad idea.

I agree with Eric Sunshine who complained that my patch is not dependent
on the use of Homebrew. I haven't found a way to make it more dependent
(there is no `NO_HOMEBREW` knob, even though there are `NO_FINK` and
`NO_DARWIN_PORTS`), but that does not mean that we should make it even
worse.

Will update my patch to guard the options a bit better.

Ciao,
Dscho

>  2 files changed, 11 insertions(+), 5 deletions(-)
>
> diff --git a/Makefile b/Makefile
> index 9804a0758b..031a231ad6 100644
> --- a/Makefile
> +++ b/Makefile
> @@ -1303,6 +1303,15 @@ ifeq ($(uname_S),Darwin)
>  			BASIC_LDFLAGS +=3D -L/opt/local/lib
>  		endif
>  	endif
> +	ifndef NO_GETTEXT
> +		ifeq ($(shell test -d /usr/local/opt/gettext/ && echo y),y)
> +			BASIC_CFLAGS +=3D -I/usr/local/opt/gettext/include
> +			BASIC_LDFLAGS +=3D -L/usr/local/opt/gettext/lib
> +			ifeq ($(shell test -x /usr/local/opt/gettext/bin/msgfmt && echo y),y=
)
> +				MSGFMT =3D /usr/local/opt/gettext/bin/msgfmt
> +			endif
> +		endif
> +	endif
>  	ifndef NO_APPLE_COMMON_CRYPTO
>  		NO_OPENSSL =3D YesPlease
>  		APPLE_COMMON_CRYPTO =3D YesPlease
> diff --git a/config.mak.uname b/config.mak.uname
> index 540d124d2e..0ab8e00938 100644
> --- a/config.mak.uname
> +++ b/config.mak.uname
> @@ -133,11 +133,8 @@ ifeq ($(uname_S),Darwin)
>  	HAVE_BSD_SYSCTL =3D YesPlease
>  	FREAD_READS_DIRECTORIES =3D UnfortunatelyYes
>  	HAVE_NS_GET_EXECUTABLE_PATH =3D YesPlease
> -	BASIC_CFLAGS +=3D -I/usr/local/include -I/usr/local/opt/gettext/includ=
e
> -	BASIC_LDFLAGS +=3D -L/usr/local/lib -L/usr/local/opt/gettext/lib
> -	ifeq ($(shell test -x /usr/local/opt/gettext/bin/msgfmt && echo y),y)
> -		MSGFMT =3D /usr/local/opt/gettext/bin/msgfmt
> -	endif
> +	BASIC_CFLAGS +=3D -I/usr/local/include
> +	BASIC_LDFLAGS +=3D -L/usr/local/lib
>  endif
>  ifeq ($(uname_S),SunOS)
>  	NEEDS_SOCKET =3D YesPlease
>
> base-commit: 27a706730868835ec02a21a9ac4c4fcb3e05d330
> --
> 2.26.2.569.g1d74ac4d14
>
>
>

--8323328-1561261481-1587818028=:18039--
