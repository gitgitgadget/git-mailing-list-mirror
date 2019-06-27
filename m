Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MALFORMED_FREEMAIL,
	RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=no
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 156381F461
	for <e@80x24.org>; Thu, 27 Jun 2019 18:53:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726523AbfF0Sxs (ORCPT <rfc822;e@80x24.org>);
        Thu, 27 Jun 2019 14:53:48 -0400
Received: from mout.gmx.net ([212.227.15.15]:44881 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726426AbfF0Sxr (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 27 Jun 2019 14:53:47 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1561661620;
        bh=7LGVsscWb4y5RDtNpDvYpQIxpjW+awkrT/lz5NZLxig=;
        h=X-UI-Sender-Class:Date:From:To:cc:Subject:In-Reply-To:References;
        b=XybiU4/FImwAg5PolwiCWr8zkLJWITm2GJzDIph23dFQaVg6dyGIlh3F6efd5jkfK
         xZBRzr/w6Q04az/v5w6+YZP50wxuyh9Nq6NvkZHtALvwJs4ePalFUih0C9XiZQBCpP
         pREQuE4xVfArQs5atCwOrY56e/1HxnyojNfwKA1Y=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [192.168.0.129] ([37.201.192.51]) by mail.gmx.com (mrgmx003
 [212.227.17.190]) with ESMTPSA (Nemesis) id 0MQ33z-1hcQvA3YNH-005KOL; Thu, 27
 Jun 2019 20:53:39 +0200
Date:   Thu, 27 Jun 2019 20:54:00 +0200 (CEST)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@gitforwindows.org
To:     Eric Sunshine <sunshine@sunshineco.com>
cc:     Johannes Schindelin via GitGitGadget <gitgitgadget@gmail.com>,
        Git List <git@vger.kernel.org>,
        Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 2/2] mingw: use Unicode functions explicitly
In-Reply-To: <CAPig+cTkzeyGjvftxmaA5Du2Dm4myzchJhrnHi=noJ7nLiLp-A@mail.gmail.com>
Message-ID: <nycvar.QRO.7.76.6.1906272051240.44@tvgsbejvaqbjf.bet>
References: <pull.147.git.gitgitgadget@gmail.com> <0c9d2aead5f729942968314679c5a1ca2e0370d0.1561628237.git.gitgitgadget@gmail.com> <CAPig+cTkzeyGjvftxmaA5Du2Dm4myzchJhrnHi=noJ7nLiLp-A@mail.gmail.com>
User-Agent: Alpine 2.21.1 (DEB 209 2017-03-23)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K1:1B/QZpdQpqpC8peu9wm/Eu34KgMguNfeOQ4E91leFSN3cGt7lru
 ig2ChQEtym51rtkP8+xJVcuZj4Wa97wiLI5Ir1I6PmlbEnD9bE4DpMmDnA8jHfO9lpkS8Ns
 0mZcKlYkOiFWfjZjBT1dfpAvgfR4MUgwLb0wdmf6ZEaDof0gKNC+uuNVdjHBUQs/jxRnltn
 BNhAoXbZx4x9j4HJj78fg==
X-UI-Out-Filterresults: notjunk:1;V03:K0:nDEneCu2qiM=:tEfHiNA9FEncBTCre6IoSz
 GMlF1eUsPe7W8keRnyRTw9g8pXDGuRx2nfkzxX0or/R5movqo/AuNi7wxUT9riYbofSDAQcP8
 wpCjWw13RAr7gqVn6MmtVmFoywlk35jcBqf+yvV0R/zT7vNmdBc/+dI1C8RJ823oi85k62j9P
 kEUufIxfEiJyl+0z4u9A2VtN6g2wDr1ZV4ls2ROrIMpHfXZ5psKE20n4GKPpCZ3FA438kStYH
 nCYaOgOQr2lDNkNoGetwWLzZ5SOcdG1d8/pcQviSIp1NCFWwjGNTvLTNY8rzbCGy+ZCS9Tin+
 8m5I2LImIRL1IXQrKhQ9ukugAFuJI0DyQ+IRok6X/5zWsq+guJusuy21k9J2taLCCubO3dJf3
 Ae3N/NRwipzaaSJhITvUFHKp3/7xZ6iWQ0kw8fKJVjUD5IaA+DcT5OLUwbSpAfUEznjaXYr2a
 Br8HwFTMd7yA/Q4E/e/a0QpjgTFzu4WF9HBD/GWpTUuFlwIL34SHli9NMliLdLBSl6HOowCpM
 itq0+SdgMdZJl0zxloSSFboG763PmK2j9H/lKmaXc1/4w4Ww6AeiUeSNW3fHtrX8GWAALmGHo
 LWqtbfh9eDK5HIGNjo1PO236gtvp8B6piK5mEDgBzxqKGbg/RiCBg6MLkG+ZomqoXu/blcm+/
 tU+BEiHPr7knhlvaOhXtPQkewuflgDxuflWg8nft57OwqOs8mJZ8OQK+4vv86VpFJDOLi+/zV
 z4yG99iQTuzwFo2LufIxy2+QWeWBu5Dmf5As2XyDnGjET95n6q6nCuxFFeazOdc1+wbtzFLla
 VeMDdCveVXHoQXcult362XcrHBaT0dzHoAOh4aA40fafEzKUuKGGqF2ZLJH6v52QZpm9Hxavm
 Kfxi/lXH0Sa1+fGCjIKshCFThdREQ9IEeOShIO6SOLZ2n/gqwE9X/VcdiBMTtZHBGKCaBJSEb
 Ol+Fu1gWDndSR/FBo6OvN0bCTQ7xkDUH2UlLkkW+hXhoQRZMz0v6/kJyfe8fSZ9/PWNtVGoPH
 k79+EC2PS8M4cYjSftd4BC56lKI7EX5o5pvy929/Lcujj9M3NuQlVe4MyfBt6XZcoctY4+xF/
 OvqB0gEjAIohgVwnERn/bJnWxzxmhj/Ah4k
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Eric,

On Thu, 27 Jun 2019, Eric Sunshine wrote:

> On Thu, Jun 27, 2019 at 5:37 AM Johannes Schindelin via GitGitGadget
> <gitgitgadget@gmail.com> wrote:
> > Many Win32 API functions actually exist in two variants: one with
> > the `A` suffix that takes ANSI parameters (`char *` or `const char *`)
> > and one with the `W` suffix that takes Unicode parameters (`wchar_t *`
> > or `const wchar_t *`).
> >
> > The ANSI variant assumes that the strings are encoded according to
> > whatever is the current locale. This is not what Git wants to use on
> > Windows: we assume that `char *` variables point to strings encoded in
> > UTF-8.
> >
> > There is a pseudo UTF-8 locale on Windows, but it does not work
> > as one might expect.
>
> What does "does not work as one might expect" mean? The reader is left
> hanging, not knowing why or how the UTF-8 locale on Windows is
> undesirable.

Should I really bore the reader with half-details? At least one of those
behaviors was reported as an unbootable Windows 7, but some others could
not reproduce.

I really did not want to write a novel here that is 1) largely irrelevant
and 2) would take way too long to write because I forgot most of the
details and would have to look them up again.

Hopefully we can do without the full story here, as even one report that
it does not work as expected is enough to make this an unfeasible option
for us, and that's that as far as I am concerned.

Ciao,
Dscho

>
> > In addition, if we overrode the user's locale, that
> > would modify the behavior of programs spawned by Git (such as editors,
> > difftools, etc), therefore we cannot use that pseudo locale.
> >
> > Further, it is actually highly encouraged to use the Unicode versions
> > instead of the ANSI versions, so let's do precisely that.
> >
> > Note: when calling the Win32 API functions _without_ any suffix, it
> > depends whether the `UNICODE` constant is defined before the relevant
> > headers are #include'd. Without that constant, the ANSI variants are
> > used. Let's be explicit and avoid that ambiguity.
> >
> > Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
>
