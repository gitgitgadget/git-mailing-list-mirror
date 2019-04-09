Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id B884520248
	for <e@80x24.org>; Tue,  9 Apr 2019 05:53:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726091AbfDIFxd (ORCPT <rfc822;e@80x24.org>);
        Tue, 9 Apr 2019 01:53:33 -0400
Received: from mout.web.de ([212.227.15.4]:39357 "EHLO mout.web.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726032AbfDIFxc (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 9 Apr 2019 01:53:32 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=web.de;
        s=dbaedf251592; t=1554789194;
        bh=greTnrlqd5bUZUFXNRzC0yqnZ2dvZ+E+ieh67qXeHFA=;
        h=X-UI-Sender-Class:Subject:To:Cc:References:From:Date:In-Reply-To;
        b=fP+1xwrNpV5dOlOTdWW92Z47bMdZB7D36YVq0Hu51wIolN8Vf7uKioVMn1KAtR/j5
         xG8q/CJV/03urYZJCwKw2oFWC9UXlxmovLNEGWN+BpYjJOStLQKzYH9igs3DKnGVBw
         cnxni5uPIDzktkNFW385qgz433RA+uyuT0GWLJEU=
X-UI-Sender-Class: c548c8c5-30a9-4db5-a2e7-cb6cb037b8f9
Received: from macce.local ([134.30.197.86]) by smtp.web.de (mrweb001
 [213.165.67.108]) with ESMTPSA (Nemesis) id 0MejSy-1hXavi2N0C-00OFBx; Tue, 09
 Apr 2019 07:53:14 +0200
Subject: Re: [PATCH] Unbreak real_path on Windows for already absolute paths
 (with Visual Studio)
To:     Sven Strickroth <email@cs-ware.de>, git@vger.kernel.org
Cc:     gitster@pobox.com, peff@peff.net, johannes.schindelin@gmx.de
References: <6c7d4155-e554-dc9a-053e-f3a8c7cd4075@cs-ware.de>
From:   =?UTF-8?Q?Torsten_B=c3=b6gershausen?= <tboegi@web.de>
Message-ID: <0f629384-638f-bfb9-89da-ade335e364fd@web.de>
Date:   Tue, 9 Apr 2019 07:53:09 +0200
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.11; rv:60.0)
 Gecko/20100101 Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <6c7d4155-e554-dc9a-053e-f3a8c7cd4075@cs-ware.de>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:/F8ZD8FHji8dhv/HHSsym64ZbX30zjKQiC4pBHeO2p3mnRf3+Nk
 dVL0D5uiCeayyTZU3RliAApG6EIVuuQEl5bDGdKKUPOEZUi3xUopmH5QcWHIm8zaJLPt9au
 2uBotmkz3AlN03AXvXKV3w/XDfrybTka018n5TkOeDoYAaCMhjgQQEt0b0aD9J8v6cdNTnN
 4yVqwA6uIJhdumRGrl5BA==
X-UI-Out-Filterresults: notjunk:1;V03:K0:wdQVKjab6w0=:/mwILMeQzO7qg6llF5xSp7
 NU6w9ptzvkSrRj+pd/OtHhYrK2tYrX1IsIe8CWYKxCElTqd1YjiERehPnEUt+1qw5FNo3pVk/
 pgCDc+OTzDeMRs09hN2h9I/n5Yp5KaPGFzfOyzX2ozYVv3MRbwpbFCmWddK04VzLOZqs6T3aU
 f6LDfQhM7uRlORNPSDkXT55+pD+8m4Vws/xiDEgsD8Wj0BWQZkHHvpyajasGgvl9AT30BaT/s
 R0BEln/5LY97uGb2L8CXclmjswu6IuGjG6oPw6VshyP5zf2iUTHPdN45dr55arX2eBRR1aUxm
 SoMb+wmiabz1OP7aTo1s9sq6xDM4w5Z50bCAJMoZu0ql5M6ebncr+slZu7Y+ENF1F6PQo26od
 ngysXKGQGLyw35ibmxH5CLNPPANbmrif/zEThLEaf59hTk5rpcnevgR9ykcIhgECRyT9s01cZ
 +W/A1rQkuHRIlk0N3TYr6HYXWN5XmEAWByOAgtCLtRer2eoDeCEE0hBqZ4wgIzp4olvQNuHXx
 I1YtdfD6zGsofZ59D2hud3VJrtN7PDjraqnPO0PhTbl5sTcf/CFGhnCLNZfbB7Guo7z+iWAvP
 Sxy6LaEwC3206whKSZH3igMk/EEw+HlHZFgJCChHtjRANRTcagoI2nm8ufTV0VstVho4MtrSX
 UoXppyRS/DnXTvqlkS/KyRkEgY10G9jsZ4HLPMZXz1GwYC9HQBAppOJa7r9zHtIwg5evVCoZs
 URwXvvs6E6L6QGoHTYNM11lCUY/4k9Xa/R0py1p3kH6/Td3ntDEL/LiKmq3rPBIrt0mXyEwCj
 ydRfsTomn/dfAMJ0AkvdLp2pSZnaiashMgdOGHzjCmlVFZUwDZIjdDxT0L0ie3uBCO3cggQNk
 bOnmZVde7sI25Q7hNS711ac/S6n2qzuSBsiMKdkbvWoIs3IhJ5GTzRF1OGg5U5
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 2019-04-08 13:16, Sven Strickroth wrote:
> A path such as 'c:/somepath/submodule/../.git/modules/submodule' wasn't
> resolved correctly any more, because the *nix variant of
> offset_1st_component is used instead of the Win32 specific version.
>
> Regression was introduced in commit
> 25d90d1cb72ce51407324259516843406142fe89.

Was it ?
25d90d1cb merged this commit:
1cadad6f6 (junio/tb/use-common-win32-pathfuncs-on-cygwin)

And, if I read that correctly,  1cadad6f6 does not change anything for MSV=
C.
And the problem with the missing/wrong path resolution was there before
1cadad6f6 and after 1cadad6f6.

=46rom that point of view, the patch looks correct, but:

The other question:

In config.mak.uname  we need to add a line
compat/win32/path-utils.o
for the Windows build.
In the git-for windows codebase I see
  COMPAT_OBJS +=3Dcompat/win32/path-utils

3 times:
For Cygwin, MINGW and Windows.

In git.git only for Cygwin and MINGW.

(I don't have MSVC, so I can't test)

>
> Signed-off-by: Sven Strickroth <email@cs-ware.de>
> ---
>  git-compat-util.h | 1 +
>  1 file changed, 1 insertion(+)
>
> diff --git a/git-compat-util.h b/git-compat-util.h
> index e0275da7e0..9be177e588 100644
> --- a/git-compat-util.h
> +++ b/git-compat-util.h
> @@ -210,6 +210,7 @@
>  #include "compat/mingw.h"
>  #include "compat/win32/fscache.h"
>  #elif defined(_MSC_VER)
> +#include "compat/win32/path-utils.h"
>  #include "compat/msvc.h"
>  #include "compat/win32/fscache.h"
>  #else
>

