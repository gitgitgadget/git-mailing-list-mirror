Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 10D2C1F45A
	for <e@80x24.org>; Tue, 13 Aug 2019 20:01:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726186AbfHMUBE (ORCPT <rfc822;e@80x24.org>);
        Tue, 13 Aug 2019 16:01:04 -0400
Received: from mout.gmx.net ([212.227.17.21]:36461 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725923AbfHMUBD (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 13 Aug 2019 16:01:03 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1565726448;
        bh=0X8tIceRBMyDnsBYzVnt9ElV/J+BzZdTq/MeOnuz15I=;
        h=X-UI-Sender-Class:Date:From:To:cc:Subject:In-Reply-To:References;
        b=TXF4jmLRDIx6gRWBR7HcCdXdlVWgixRTnNuNFlWO2eh9w5papJPtPTptGTZtGC0GR
         0xIPKz97tBzcalLKzWGzO9/OT19pnLg3oatoXkIOVDzyWOHpzxZA9N4pOmpYNwyZnG
         ykcLj43Rb84XAJhLWzgiatJZCs30vi72Ty4KPCsw=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [192.168.2.63] ([77.165.132.136]) by mail.gmx.com (mrgmx103
 [212.227.17.168]) with ESMTPSA (Nemesis) id 0MfEsY-1hdKw13K4g-00Ompq; Tue, 13
 Aug 2019 22:00:48 +0200
Date:   Tue, 13 Aug 2019 22:00:44 +0200 (CEST)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@gitforwindows.org
To:     Junio C Hamano <gitster@pobox.com>
cc:     Jeff King <peff@peff.net>, Carlo Arenas <carenas@gmail.com>,
        git@vger.kernel.org, l.s.r@web.de
Subject: Re: [RFC PATCH] http: use xmalloc with cURL
In-Reply-To: <xmqqd0ha9ml4.fsf@gitster-ct.c.googlers.com>
Message-ID: <nycvar.QRO.7.76.6.1908132200110.656@tvgsbejvaqbjf.bet>
References: <20190810220251.3684-1-carenas@gmail.com> <nycvar.QRO.7.76.6.1908111317540.46@tvgsbejvaqbjf.bet> <CAPUEspg62pRNH6=_VvWDxQ4YujHUJAoTTampc0L4t68QMj30xg@mail.gmail.com> <20190812195537.GA14223@sigill.intra.peff.net>
 <xmqqd0ha9ml4.fsf@gitster-ct.c.googlers.com>
User-Agent: Alpine 2.21.1 (DEB 209 2017-03-23)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K1:d5JquEMGWO726CMNYMihyKZjNoGfRzzk5B7aVVkQ7+TqpSBQjdJ
 4gc5MJsxdzH2SrGSp45GGVwAMBGTutVYRePY21oFaL2pBjYAaavlDYsV9ppw5HeFa/RDr7+
 doB1LaV3iHVoCBKg4N7UnYqC2v5IqN0xyWxYEp4FUaEzsdyd17unDRV4xjV7aZwmNnMSAHD
 W0qFMpLe3NVGaXeBvPB2g==
X-UI-Out-Filterresults: notjunk:1;V03:K0:VQqIL1GFi7c=:RhLzNChjTWesz8s92KydJd
 0p4hXy7VonM1Z0RQg3Yy9bazo76cTKooo4Xa7OQQD+rt2w08iz6ZFWLPUitgjI0rwM435zMl+
 xrZWMqSF+XCnqOMtSDRduU1XKP4gJeQb1ks+rnSlIsWHcd6Aj+DxOO/yJ1hCUUuV3Oyw1x1Rc
 pvXt7U3FLaFiVjMckuGKp2b1RDE6nW7smAsW8cm3DZq7q7rZVFd2DN9ECfkommjLTpNbQ5XOb
 pWpFc1EA5P9U2l4a1vuEqLFIE+uUDT3B4i+EqLZ36lpidzMpCpP8QGOrZz4s0rPbytRTKp4iT
 64CDOAbdB+UozpqSeOx+m6YxQoHqJkyUIALK3MlmRHFU3riAc8V5GMJeV3sD61bhTXJixDM0E
 41l6IPliOe8oCBI9kv0uosXjDe2Xeh8aSDxgvvymu3wFoY96DZ62r+IrfiFUDqlbwJzenS1GG
 cWz/QEB0b1K1IvzyzbIwHmLp6sgrZZUtqCvj+5b34nTZuWMHV5Ipf5uUSAoSyM6B+MZOarwCa
 kSoCBbz69YevQvxaPqxnmoIofyY+KR3h+Bu4nUuE35jSYDSgq8JSfBOa44c/4D2z9zSgHrUxU
 31o2tKAGFGMXiYIXsp05fNqqplb9QYAhzN3pTpuyGIdV+AD2JRy/kqnQgBRHBLPta9u4V3Wo9
 AsJaZXAqcnqcCq6cOTifX1eUCVFXuecpSNuYFhzfZL/XUS3zbc0ESOtGFI/qqpZWXCt2+72MM
 wyJWmOqd56pOQEpjyXv4CglVB/lAhErUt2EN+tpjUIx3PcjIiReYMImRz+mQk19SNCz40W0m8
 MhhrkyQ8ku4twkWiCGD5gkmRm19TRB3Ahn1RGD4fgBuINPj4+PnM8E8Uf9y70UFk1sGmwLiWX
 1bzz8nVUcohFqHfJ3uufKAHJja7Hy4w+62H526Z3gKinAFKtrsN+6IdayHCTxONDNluDz2UOw
 Z1wpOnkE2rWF8ncYYxRSoYd+EEanXZOdPoygpzEjs5MP9qYc6BBas8o/mcmOynCUtpiOxF6Zc
 2hjdcO0F8oI0oepX6L6FDFl+d9vjqGqBEMCRzhO4a/SQJLyyi55GpcfRuEhvXJ6FJhZSeI9Z8
 rsI6y2IAsk8OeHT34geCbq1wO3+vNpK3vI4+oZVRy3y6sRaJAJ1vBtb4DfaGSKo62zqGre9dA
 8ZT4c=
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi,

On Mon, 12 Aug 2019, Junio C Hamano wrote:

> Jeff King <peff@peff.net> writes:
>
> > I think it might be worth just eliminating the whole idea.
>
> I kinda like the simplification ;-) An even thinner wrapper that
> calls malloc() and dies if it gets NULL, without any "try-to-free"
> logic.

This is one of those instances where I wish we would have some reliable
data rather than having to guess whether it is a good idea or not.

Ciao,
DScho
