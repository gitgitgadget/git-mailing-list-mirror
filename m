Return-Path: <SRS0=/23Z=ZO=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 83D7CC432C0
	for <git@archiver.kernel.org>; Fri, 22 Nov 2019 16:18:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 423A32071C
	for <git@archiver.kernel.org>; Fri, 22 Nov 2019 16:18:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=web.de header.i=@web.de header.b="q0KNogOv"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727234AbfKVQSH (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 22 Nov 2019 11:18:07 -0500
Received: from mout.web.de ([212.227.17.11]:47149 "EHLO mout.web.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726666AbfKVQSH (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 22 Nov 2019 11:18:07 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=web.de;
        s=dbaedf251592; t=1574439477;
        bh=viKxSTCtg6n29jze9YB3zuZDUlg+ai8IhV4NE/O8f6g=;
        h=X-UI-Sender-Class:Subject:To:Cc:References:From:Date:In-Reply-To;
        b=q0KNogOvO/2OAEVeC2L2R87r313cYmHtQffHkoJV7zN+onHGawErqOAG3sqZANCVr
         CAoTAy4syayWC1TNZ/HYqFypYGEXAjY+5TvnXsqAHkIfCG9yrh7aggs6z+IvMsHW70
         15lvq2ziukVOXKz1mCldUtay6/TqqdQpTNrMAa+A=
X-UI-Sender-Class: c548c8c5-30a9-4db5-a2e7-cb6cb037b8f9
Received: from [192.168.1.3] ([2.244.174.75]) by smtp.web.de (mrweb103
 [213.165.67.124]) with ESMTPSA (Nemesis) id 0M5g0a-1hb0Qv2XYe-00xfRz; Fri, 22
 Nov 2019 17:17:57 +0100
Subject: Re: coccinelle: improve array.cocci
To:     =?UTF-8?Q?G=c3=a1bor_Szeder?= <szeder.dev@gmail.com>
Cc:     =?UTF-8?Q?Ren=c3=a9_Scharfe?= <l.s.r@web.de>,
        Jeff King <peff@peff.net>, git@vger.kernel.org
References: <5189f847-1af1-f050-6c72-576a977f6f12@web.de>
 <05ab1110-2115-7886-f890-9983caabc52c@web.de>
 <fd15e721-de74-1a4f-be88-7700d583e2f9@web.de>
 <50b265f0-bcab-d0ec-a714-07e94ceaa508@web.de>
 <f28f5fb8-2814-9df5-faf2-7146ed1a1f4d@web.de>
 <0d9cf772-268d-bd00-1cbb-0bbbec9dfc9a@web.de>
 <d291ec11-c0f3-2918-193d-49fcbd65a18e@web.de>
 <d053612d-107b-fdb2-b722-6455ef068239@web.de>
 <4f55b06b-35f3-da06-ae86-8a4068f78027@web.de>
 <06ff24b6-f154-9ec6-7b22-05b0ea664a36@web.de>
 <20191122152950.GZ23183@szeder.dev>
From:   Markus Elfring <Markus.Elfring@web.de>
Autocrypt: addr=Markus.Elfring@web.de; prefer-encrypt=mutual; keydata=
 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 FEE=
Message-ID: <c9cc76dc-615f-ff89-6305-64d897734a4a@web.de>
Date:   Fri, 22 Nov 2019 17:17:56 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.2.2
MIME-Version: 1.0
In-Reply-To: <20191122152950.GZ23183@szeder.dev>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:uMhbtu6DvJ8FSYwTgLFoEeMdK4ki6CkbCDfAzZLxEtyCTFnaLV8
 huiS6B02fVUDF3t+myJVy+KW78sh/zrwEJmU8iB3/DR12CJ9fNTjaFkvsLwuFfXTvti+YAu
 cV8OYMxd4N59sGWx1Si3eRLdYt5ISZqvi+HmVExMjH7Fz5PQJcYTgUwXeFy8YeRyxMIAAwk
 s3BTxQqYfoT9+pvlexLRw==
X-UI-Out-Filterresults: notjunk:1;V03:K0:kOEn4bbFcRo=:GXUira8dUXO/QObSvobrxN
 jtiwN62jMtnD1pI/M+PfiinvA3o7lFrF/24BdkSZ6VHGCf4eesxaBrkL+f0WhabkvX1s0skva
 v3tTm4HyIwlBBxNac8x/NMuLNHqQ08qarR9nhQPLhjoHKB75NfuUYrZEZGUuE/aDhIkIRpOM3
 EorA1/oIvy/TazP0/pH4TV3MnLua3jq6l9qM4VlGlJbp8Q0rVnuU5DCKDN8JRotPKiYlz7omD
 8cFf6n62Stg30qYWCrtbeFUQZJ6DztUJr8MtjpwEAEVClXKk4Xb13kcRE9uYbbuNZKT4UINIw
 DpgYTd3T5tEO3GzAqlz5gPgXi2q9ISdsBmFAxd27qrvfU3vbGk5Qkb3POoE/5bAn9PQTdLUzf
 Hh1xyRiBMpayAmkf+UvuowkcbWB+az8Hs7Z3aV/ul4zPcm6SLwEF2DHRWddHUZnWCXZFrQpn/
 PyHfV+Q74n5u/CBzr4qSgvOmSAwEsMKw0emMZCoICjbcXewmvKSJV0t6oSFCV869ZYODGzr/4
 M9VJGfF9bmG2bdX1jCuQsMf1MwMU3TAJ9i5R9yGg3kG/HvfPmkBmybljosZZThxFuhQz66NAj
 MVloPaVY8fWeAJQnqHgO1kSKdkZjC9KgEuckeTAxzZ62Msj5YHWNv+GgLPcpmQIIgowouF2eo
 iVDlpd4kX0pV9SnTZ2ViGDd4/8iwe/N/dpRmssrW9xb82472DmriXy8YNvvePYoNNKY6hR1CA
 uoCoP2D7hqDVflV3RpjEOlud0QHd0bKCAJVhYhmvhHw8HSfaeLnejUXvMbEsHKblw4Uv3EuPM
 kVcXic+/8hdsn42EfHYWu4jNgrGGOQX0mTMK0LMPXUjkJFbsuQphUzp6mV8Op5daZiuHJQuIr
 0roTXwvpO1hdsVsMX2ORRi/v2zWieknPJ3Jt0QZHwQfImy6649UIQqDrFJvlMFg/sGueyTHEK
 NSJTO7dZ3qUp6NAI5v1kHUIWXFOJIlu6R+CYkmowuoedphtVFK/JFWZLpTeC/n5dWn/TQcXdc
 wOX2+w/VGGLHOibGiBgm+Ocm/izgHWL6MtuKTAAtFWhyhUmTTO/iDMZO6IyP/Q7TrmF8H8kBL
 WLaKjfVTXVf0OkYUUkqRA8aqI2oHftR2/lB4kjb4Sc9bSw+RfNo0j69spEaCcysewgE43ArwU
 tm7K+58T/1tbgmhJot63IX7WZZHIGJvD7xTMM7OevmrOYmBw6g5WJgE21UZt0RsQjDNfGmC0j
 8WQu9e3mLP4Q96m1qia0zaX7LGX23G2SF9Soowqt7dV3qBT9g+d9VQLZvr3s=
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

> I did try --jobs on a couple of occasions,

Thanks for your feedback.


> and the results always varied between broken, not working,

The parallelisation support by the Coccinelle software was questionable
for a while.


> or downright making things even slower.

I wonder about this information.


=E2=80=A6
>   spatch version 1.0.4 with Python support and with PCRE support
=E2=80=A6
>   Fatal error: exception Sys_error("array: No such file or directory")

Another bit of background information:
* https://lore.kernel.org/cocci/99082e9d-8047-eee3-68dd-9849868d4a96@users=
.sourceforge.net/
  https://systeme.lip6.fr/pipermail/cocci/2016-August/003546.html

* https://lore.kernel.org/cocci/alpine.DEB.2.10.1506171707190.2578@hadrien=
/
  https://systeme.lip6.fr/pipermail/cocci/2015-June/002141.html


=E2=80=A6
> Therefore, merely passing in '--jobs <N>' doesn't bring any runtime bene=
fits:

This program parameter should be used for other command variants.

=E2=80=A6
> It appears that batching 'spatch' invocations with 1.0.8 does not
> bring the same benefits as with 1.0.4, but brings slowdowns instead...

Would you like to share your experiences also on the Coccinelle mailing li=
st?

Regards,
Markus
