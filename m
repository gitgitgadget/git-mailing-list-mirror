Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-1.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MALFORMED_FREEMAIL,
	RCVD_IN_DNSWL_HI,RCVD_IN_SBL_CSS shortcircuit=no autolearn=no
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id C1B331F461
	for <e@80x24.org>; Mon, 13 May 2019 10:15:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728756AbfEMKPV (ORCPT <rfc822;e@80x24.org>);
        Mon, 13 May 2019 06:15:21 -0400
Received: from mout.gmx.net ([212.227.17.20]:40685 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727272AbfEMKPV (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 13 May 2019 06:15:21 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1557742516;
        bh=UTXh9WV1gIBHwb2UyuaAHWETc06rVM4nwu4btdxrolA=;
        h=X-UI-Sender-Class:Date:From:To:cc:Subject:In-Reply-To:References;
        b=Jtfq1UiwgpONRqnRPwV5BvGLQ+ifoGDA9FX4jNknsfUxKPlzzrkzVSdUIpQhXU2MR
         QE983nrOEymKSxaa+cOXy0sh7Lv+bA8NRcY4U7wdIK5GGVtppne/hiIVgkDBKQUYdN
         CxOxI04BZZbDjFfeB4FKeqLV9cFupYCpGOKZ24LY=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [192.168.0.129] ([37.201.192.51]) by mail.gmx.com (mrgmx103
 [212.227.17.168]) with ESMTPSA (Nemesis) id 0M2cDB-1gaEBq3tzx-00sJPL; Mon, 13
 May 2019 12:15:16 +0200
Date:   Mon, 13 May 2019 12:14:59 +0200 (CEST)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@gitforwindows.org
To:     Elijah Newren <newren@gmail.com>
cc:     gitster@pobox.com, git@vger.kernel.org,
        Eric Sunshine <sunshine@sunshineco.com>,
        Johannes Sixt <j6t@kdbg.org>
Subject: Re: [PATCH v3 0/5] Fix and extend encoding handling in fast
 export/import
In-Reply-To: <20190510205335.19968-1-newren@gmail.com>
Message-ID: <nycvar.QRO.7.76.6.1905131214260.44@tvgsbejvaqbjf.bet>
References: <20190430182523.3339-1-newren@gmail.com> <20190510205335.19968-1-newren@gmail.com>
User-Agent: Alpine 2.21.1 (DEB 209 2017-03-23)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K1:TNd1Zt99MpN2rBKOlITQfql1SwKTdZdrYJlh5KGEoOfBNxQKBM3
 hVZkmRcsnSInThSmhCYhg3wVjs987WJAAOafWAsaPv7IqZqZMmN/D3bLyEOnBdxWpdslpJF
 1ZShjzVxkPk1D2m3ShAqTV2JQzR87dNvB3xNTqVa28iAemLQHrh4kJs2VjQJXEYVsW5vGx3
 wxOMkBvLkFxCh7InxurVA==
X-UI-Out-Filterresults: notjunk:1;V03:K0:0CoKDZp9WZo=:2udesqXP5LjMgUkjMgp8hX
 o3WpI/Xsm8bpyx+8M1OhUTJVu7Ik1woBmQPkHIIvkL2SJU07xJzyYUbbrzNw2K2apxbw+pgBy
 7roMrFCgxN/xWH7amXho5Za088N4z+Zf2Q/eUsznwZJWe/MWbIEObNDTVrvxUtMq5agQaWMEX
 rsHtK5xZ4mAdGWFtFwcupIl+kjmRuAvmFkvfDwLXTLy17DmphDdaP2cqAf7nbRsu1+t8jcrN7
 xvSNQ/k+QgwEX9KtKhJTsAksSeqBuKIADS5jnqsHv/URRhsLhXh4hORc5fShdsUp6WlZGL63/
 lrn8f7/a62AXeOrQMnkfS8HzfMWwUr6EvzPNxWQu4HYWo3AL86GFRz+T8jJMekgBldn8di3x7
 SzFM8hj4IhHahBl4oT9wBm2Fj04Ii300ACFn8aLxGb7fF8D9AdFsPJWRV2XXfRj5Ghzd4Oui8
 GiezDC5SRLaLkV1nyqQIGkVCHyhGy7IxEFAFTS070Pc1e1PcbwZywGCPVaCR70rZIuii52Tkj
 Aa1NMfdaFRvCU2fgZ3tAPeHjgNyw8vDqNe0qsFpFw2LzLOzTSDhLMsOKdJ4uNsntMY+zptAA5
 6nOimvqF5foOexH889sb95BYsqa8/WhXHAbZ3wHVhGLmkQcUMwUaMjsv31WJy/tU8p+lVJTUj
 wgPPR1gjiCD2D5IAnkYwvhU4B700l7pZuqte/PmvyuzLrPQFo+xEGrJSGr/PcQD468MZsoDz6
 aoHjHseBQztdSgBn+ntIQy5rr0X5NFaYtV5uRBaAkCR64/hDXmBKIudFvZ2RTGgLwRndo62tJ
 4MWuEri3M5BYlWnqJDvdB8apabnOijOXnsXLmNKsZoaqCR1WQMeykE1lpb87H/lZmjIP08z4a
 0QD0u8gtMxaca7EP7onyAzbi3qAC3jrtIfN6YeFl95g92PrbBBsE067h6GuLbKHAjdImROQkM
 nB9CkyQuAiQ==
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Elijah,

On Fri, 10 May 2019, Elijah Newren wrote:

>   * Modified the testcases to pass on Windows[1], as verified via
>     gitgitgadget pull request[2].  Required adding a couple new files
>     (which store the desired bytes) and checking the size of the output
>     instead of checking for particular bytes (but the lengths of the
>     expected byte sequences differ so this works fine...).
>
> [1] Failures of previous patchset on Windows noticed and reported by Dsc=
ho;
>     explanation from Hannes is that Windows munges users' command lines =
to
>     force them to be characters instead of bytes.
> [2] https://github.com/gitgitgadget/git/pull/187

Excellent! Thank you!

Ciao,
Dscho
