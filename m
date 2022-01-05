Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 71AC3C433EF
	for <git@archiver.kernel.org>; Wed,  5 Jan 2022 13:09:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236840AbiAENJa (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 5 Jan 2022 08:09:30 -0500
Received: from mout.gmx.net ([212.227.17.20]:37549 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232983AbiAENJ1 (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 5 Jan 2022 08:09:27 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1641388147;
        bh=oukwfgHaW28K3ZCkoUBnW81hSbVSMXcXTMnY/VoMU1A=;
        h=X-UI-Sender-Class:Date:From:To:cc:Subject:In-Reply-To:References;
        b=PNFbBhkJE2otqrU3Kv2bXfScTZpuDe+3oDXPu1JWdPSIzFa+zn3bsmOGV1g8sKpfA
         b3JQB2E5VR0/hiFzwW4rBHyOIZpZDkCZA7hTe35MHX5wdaKzM5cF6aoh75kD8v0/2j
         +Ha0Zs3ueUsUgdY0Cshv7qsb27H71SyafkQPnp24=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [172.29.215.148] ([89.1.212.167]) by mail.gmx.net (mrgmx104
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1M5fIQ-1n3QHB0t9G-007ENz; Wed, 05
 Jan 2022 14:09:07 +0100
Date:   Wed, 5 Jan 2022 14:09:03 +0100 (CET)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@gitforwindows.org
To:     Teng Long <dyroneteng@gmail.com>
cc:     avarab@gmail.com, congdanhqx@gmail.com, git@vger.kernel.org,
        Junio C Hamano <gitster@pobox.com>, peff@peff.net,
        tenglong.tl@alibaba-inc.com
Subject: Re: [PATCH v8 8/8] ls-tree.c: introduce "--format" option
In-Reply-To: <CADMgQSSjoxqzBDyGXiNC4wHqYGK7z4O0SG0zai85D-DtDHem=w@mail.gmail.com>
Message-ID: <nycvar.QRO.7.76.6.2201051348050.7076@tvgsbejvaqbjf.bet>
References: <cover.1641043500.git.dyroneteng@gmail.com> <e0add802fbbabde7e7b3743127b2d4047f1ce760.1641043500.git.dyroneteng@gmail.com> <nycvar.QRO.7.76.6.2201041533540.7076@tvgsbejvaqbjf.bet>
 <CADMgQSSjoxqzBDyGXiNC4wHqYGK7z4O0SG0zai85D-DtDHem=w@mail.gmail.com>
User-Agent: Alpine 2.21.1 (DEB 209 2017-03-23)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K1:SDFJDFeLc6HJyn/zzzsWmsjlYQEP2DTOdymZwyBObwQ3Q7s4oqI
 aoK7n1+8a1WegLuEpTv/zrJ4sRa/2HqpannbSTs+2YXIWD/RyP37DuZ066LVNpiaP+gkdDp
 mj5FBLpGupxvIgE6Zf+A+lNd/BRzZ5nBwOyfakOtMXn3WwO513SqTi5wjg32mlzc2BT8Fgo
 iHMDG7CaQpp8USrTuv2Tw==
X-UI-Out-Filterresults: notjunk:1;V03:K0:WnWDNqqMwBc=:AdeEkjaqpQLfAZhIO9sMGo
 FCeQmAugNa7kk4xZsBXkhJ5WoduP2uknhvMAXHfocQReuyvPXoZf+osOBROOUghJVvkKSYIaR
 RcPQeWwPOMWQCya65D6kYqw2/hho0FV7arRE6+YY3RdQT+2ax+1h00DTFcNvYI4lca9gTR7pL
 gr2fJYtkz+ndvWguFIPWBSRPZvvrIDwPKVEgRGLL781o5hRpR/N9Hd18zpQ/Ly9KNY5hdLMXB
 OCeIyD/n+aacFG347rCShn0Qz7kyQcyHKF+68NSOJcRww/hvGX3heQIKyaLge/ZdWA32zfi+B
 h4kbwL3z/bpWAfwBLDJgieAiwTBVB3eTYpKEMMUjPb9NNQOsoZvj8IvX0giaWGVcFAzc/VNDI
 hbS400pKtGC86dCA1CoGQQhWuulKj63zlyis1OVFOpRzdhVXJecW8fkrfGumDEVw1wGCSFRkF
 a/nUIi3CMmb7Vzq/q/D45oA2OeMIiEJeGEm/9jnz8vhsSDQJSt9bDU4hr8RI+o0UaWycigBim
 m4UwsSd70tc3no7SmyAWZuSX0UngigP9+6T2KrPre4nGNLmu01p7FMYnGNiJdq2TJycVc+HFF
 B9cKXIhsTI3dzWRK57bCZVvviI39GiTY4wuSGg9hhyEUNgZy7IVxlZF0I9L2hos8E8Rm9kT7E
 q6jqEpLKxcG7s2jLBVka7tHYVtc3+VNzWq3P75pkGq36Z1W960yqXB1W0TPQNnwsSOsMbBumJ
 aSRXxLGuIvarK9DazcSEJwAh59InOWGG/4HQdzqb+Y+iHOIH4eu2YE7aj1p4nwx98+k61HqkQ
 S9ALGn/TF1nqONB7FkFdsPyPc4NEVfGcJZm2kJcpr0u0eok6KGvBVIM/qXl9YSwh4AalUK8xP
 RMLU+e8yabjsZlqaKe3+ctQfAVVyqXWsK8bXUfd2GE2apA9URDEvv9i2yhEHWodqTLbR8HwZB
 QyLBvNrUYWNr0E+2Tt0ALkZ+O36kdVVKgGMt/JF8UsBYOWmbrX1e+W1muchI9o/nJ3obmjlk2
 CKlysetezoNDElBn6aw9gMWd9p8Q9uyIknAu7UhdqvXZcRGcEMk8kpFrFeN0Q1UAW+OqqUzmS
 lI7pf+tFHnP1WI=
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Teng,

On Wed, 5 Jan 2022, Teng Long wrote:

> Johannes Schindelin <Johannes.Schindelin@gmx.de> writes:
>
> > This, along with two other similar instances, triggers the
> > `static-analysis` job in the CI failure of `seen`. The suggested diff =
is:
>
> The second and third I will optimize in the next patch.
>
> The first one. Actually I am a little puzzled from this :
>
> > -               strbuf_addf(line, "%7s", "-");
> > +               strbuf_addstr(line, "-");
>
> > But I think that the first hunk indicates a deeper issue, as `%7s`
> > probably meant to pad the dash to seven dashes (which that format won'=
t
> > accomplish, but `strbuf_addchars()` would)?
>
> "strbuf_addf(line, "%7s", "-");" here is used to align the columns
> with a width of seven chars, not repeat one DASH to seven.

Ah. I misremembered and thought that `"% 7s"` would do that, but you're
correct. See below for more on this.

But first, I wonder why the test suite passes with the `strbuf_addstr()`
call... Is this line not covered by any test case?

About the `%7s` thing: The most obvious resolution is to use `"      -"`
with `strbuf_addstr()`. And I would argue that this is the best
resolution.

If you disagree (and want to spin up a full `sprintf()` every time, just
to add those six space characters), feel free to integrate the following
into your patch series:

=2D- snip --
=46rom a390fcf7eec261c7f0e341bda79f2b1f326d151e Mon Sep 17 00:00:00 2001
From: Johannes Schindelin <johannes.schindelin@gmx.de>
Date: Wed, 5 Jan 2022 14:02:19 +0100
Subject: [PATCH] cocci: allow padding with `strbuf_addf()`

A convenient way to pad strings is to use something like
`strbuf_addf(&buf, "%20s", "Hello, world!")`.

However, the Coccinelle rule that forbids a format `"%s"` with a
constant string argument cast too wide a net, and also forbade such
padding.

Let's be a bit stricter in that Coccinelle rule.

Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
=2D--
 contrib/coccinelle/strbuf.cocci | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/contrib/coccinelle/strbuf.cocci b/contrib/coccinelle/strbuf.c=
occi
index d9ada69b432..2d6e0f58fc8 100644
=2D-- a/contrib/coccinelle/strbuf.cocci
+++ b/contrib/coccinelle/strbuf.cocci
@@ -44,7 +44,7 @@ struct strbuf *SBP;

 @@
 expression E1, E2;
-format F =3D~ "s";
+format F =3D~ "^s$";
 @@
 - strbuf_addf(E1, "%@F@", E2);
 + strbuf_addstr(E1, E2);
=2D-
2.33.0.windows.2
=2D- snap --

Ciao,
Dscho

>
> A little weird about the fix recommendation of  "strbuf_addstr(line, "-"=
);" ,
> because it will only add a single DASH here.
>
> It's the identical result which compares to the "master"[1]  I think wit=
h the
> current codes and I tested the "strbuf_addf()" simply and it seems to wo=
rk
> fine.
>
> [1] https://github.com/git/git/blob/master/builtin/ls-tree.c#L106
