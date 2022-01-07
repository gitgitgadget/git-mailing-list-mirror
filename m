Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CC66FC433F5
	for <git@archiver.kernel.org>; Fri,  7 Jan 2022 13:04:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347322AbiAGNED (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 7 Jan 2022 08:04:03 -0500
Received: from mout.gmx.net ([212.227.15.19]:38545 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231883AbiAGND7 (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 7 Jan 2022 08:03:59 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1641560622;
        bh=/EdEv50M6lRg9oE3E+7sSWt7M7jlUuusJ1sxAP9/Gpg=;
        h=X-UI-Sender-Class:Date:From:To:cc:Subject:In-Reply-To:References;
        b=eZfHm7Sd04BqDLi+C2JZMflJYS1IVsSWxNSh9DUa3cb4gDf2O9EMGunCGY5afqux8
         /M3Xkux3/bgurwKFTSE7u5SE72r5ibBbQ3E2GpbOSaM7vCXApsAgAvKuYL4qGm4/9L
         4uPTkAEWrcipXQrTiOxxPbd1/+XGbT8Yfr48eFrE=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [172.25.133.218] ([89.1.215.56]) by mail.gmx.net (mrgmx005
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1MVvL5-1myR3Y3h3N-00RqWb; Fri, 07
 Jan 2022 14:03:41 +0100
Date:   Fri, 7 Jan 2022 14:03:37 +0100 (CET)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@gitforwindows.org
To:     Teng Long <dyroneteng@gmail.com>
cc:     avarab@gmail.com, congdanhqx@gmail.com, git@vger.kernel.org,
        gitster@pobox.com, peff@peff.net, tenglong.tl@alibaba-inc.com
Subject: Re: [PATCH v9 9/9] cocci: allow padding with `strbuf_addf()`
In-Reply-To: <8dafb2b3779715aa277eb825a94af87b72f3e093.1641440700.git.dyroneteng@gmail.com>
Message-ID: <nycvar.QRO.7.76.6.2201071401240.339@tvgsbejvaqbjf.bet>
References: <cover.1641440700.git.dyroneteng@gmail.com> <8dafb2b3779715aa277eb825a94af87b72f3e093.1641440700.git.dyroneteng@gmail.com>
User-Agent: Alpine 2.21.1 (DEB 209 2017-03-23)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K1:oxZWH7kJPDNOQ2eDq7Lu4a8wqyCSkfDvBi34yNJTAJwA8iQEWQB
 6kPxpAOK4+0Fn6OnXGVC8fmyQG97y/THvcEtsdYbCjMzSEaRED0ECUc9Yrc3JsyZmkTWBpY
 QM6YGUESsH62Knuqv7dp+U82y38Ky5SHXaGvLUM6BGWQe9vF1FTq4nnLr7G3b5jIYM+fkch
 uA2aIIczsA/03rkP93hhA==
X-UI-Out-Filterresults: notjunk:1;V03:K0:oLoMpkXY/yY=:0JwIUr6xjnLlNYSFzFwF4X
 6enKsgNLPoK37xX3Ajpgdl4rbnKuXVAZXw9UBoMxfR7ZqK8JySNSxMCLy6Mm+8hQehL7lRNZy
 Uk8JrKOxm+zZo0a1cKW0C2oOvdKCfIerKs+66DrFY8AKyrLxkV5Vh2jl/kmjMo733KvFZmtsb
 /cMgHmtsg7sari614f1cd079smUCXnOXsjSkV+bbPqrqcyJMdBdfAI+8RYuIfv8Z0bRqVJhwG
 O47zOFodV9GLaEl3l76Jq7i0EQ0srfiA7HODpGi31Pknw38a9k2sD0WObCWCJl1oOYyS0CQJy
 S5Nu+IrJoweE4bJmaxWy8B02dySHaLI6dVb01wiVMeZ46jPLj3TX6JPow6EKbp3KLbshI5aOS
 ZI5fuc4q9khFHy+yyME10gYo0LHTs2T9cKgWwh8NqWBI2EHBQdPwDbM+G6kMNWya67iIFKPnB
 wmqnXyb0CrCL7JoSlqlsRIciXVHdeBp6aCdPiHM2CftTPPgevxsmGfrhE2+qlggEdSI2pOOgT
 0ayQLkoSTqh4Bul2Ga5Ip+nFrjH1uBWegDsRxk2C11buS9b2LI8Ng3lk2xZifQRAjnEvsmyvk
 +/kmacKv+ekXgikKlQ9bHLa7fezwFEevQaLZR5kTX3Zjn69LaoO5wFxrbA3Jvx1wWnrHwAU9N
 ZYKd76wZ7+Ivi1QX1UViAPGAudc+pmIx3cL4uaw964ZIy2ZpD/1z4GE9jMe2a6tg5W3fmvSIi
 d56RuW23ZKWkvJTKSplxNN27jh+M5UViLZDQjp3RBnvR4ywaSq0v9TSg2/DjcmdrDcDm5sffw
 gOPviwfCY+qoAixnkHV9i32sbsKtx8Qeqx+ds2CfEt4TFQXcaaDWZHBiIrKgC7z2RfMzUEMqe
 7GnCo10dyEni5Sd88Ohx5DHocNu9rnbux0bi57Krc+GWpyCx+8qpzOFAc34Y3kiOpvXC5R1bf
 MC7MDJeO8etOPZxYjO8SgVRP3ZUgVcnUv2TPGjVC91DY92/FWe1d2RGfHNgtRtAr0hC1CXKa9
 xM1hstC86+WzThPTgfWWmQWmQmuTugu7m91HQj2Yv5eHzrMmBLo/EJewhPWupNVOVOdJ09oD+
 49+RkppfpyOoFw=
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Teng,

On Thu, 6 Jan 2022, Teng Long wrote:

> A convenient way to pad strings is to use something like
> `strbuf_addf(&buf, "%20s", "Hello, world!")`.
>
> However, the Coccinelle rule that forbids a format `"%s"` with a
> constant string argument cast too wide a net, and also forbade such
> padding.
>
> The original rule was introduced by commit:
>
>     https://github.com/git/git/commit/28c23cd4c3902449aff72cb9a4a703220b=
e0d6ac

Doing this in 9/9 is too late, by this time you already introduced the
code site that requires this workaround.

At the same time, I wonder why you want to defend spinning up the
full-blown `printf()` machinery just to pad text that you can easily pad
yourself. It sounds like a lot of trouble to me to introduce this patch
and then use an uncommon method to pad a fixed string at runtime. Too much
trouble for my liking.

Ciao,
Dscho

>
> Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
> Signed-off-by: Teng Long <dyroneteng@gmail.com>
> ---
>  contrib/coccinelle/strbuf.cocci | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/contrib/coccinelle/strbuf.cocci b/contrib/coccinelle/strbuf=
.cocci
> index d9ada69b43..2d6e0f58fc 100644
> --- a/contrib/coccinelle/strbuf.cocci
> +++ b/contrib/coccinelle/strbuf.cocci
> @@ -44,7 +44,7 @@ struct strbuf *SBP;
>
>  @@
>  expression E1, E2;
> -format F =3D~ "s";
> +format F =3D~ "^s$";
>  @@
>  - strbuf_addf(E1, "%@F@", E2);
>  + strbuf_addstr(E1, E2);
> --
> 2.33.0.rc1.1794.g2ae0a9cb82
>
>
