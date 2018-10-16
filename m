Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.3 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 40C911F453
	for <e@80x24.org>; Tue, 16 Oct 2018 12:26:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727045AbeJPUQV (ORCPT <rfc822;e@80x24.org>);
        Tue, 16 Oct 2018 16:16:21 -0400
Received: from mout.gmx.net ([212.227.15.15]:44401 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726595AbeJPUQV (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 16 Oct 2018 16:16:21 -0400
Received: from [192.168.0.129] ([37.201.193.149]) by mail.gmx.com (mrgmx003
 [212.227.17.190]) with ESMTPSA (Nemesis) id 0MK0ur-1gB1Ve3Syb-001RUL; Tue, 16
 Oct 2018 14:25:55 +0200
Received: from [192.168.0.129] ([37.201.193.149]) by mail.gmx.com (mrgmx003
 [212.227.17.190]) with ESMTPSA (Nemesis) id 0MK0ur-1gB1Ve3Syb-001RUL; Tue, 16
 Oct 2018 14:25:55 +0200
Date:   Tue, 16 Oct 2018 14:25:57 +0200 (DST)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@gitforwindows.org
To:     Jeff King <peff@peff.net>
cc:     Junio C Hamano <gitster@pobox.com>,
        Brendan Forster via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org, Brendan Forster <github@brendanforster.com>
Subject: Re: [PATCH 2/3] http: add support for disabling SSL revocation checks
 in cURL
In-Reply-To: <20181016063323.GA25933@sigill.intra.peff.net>
Message-ID: <nycvar.QRO.7.76.6.1810161424390.4546@tvgsbejvaqbjf.bet>
References: <pull.46.git.gitgitgadget@gmail.com> <764791d13d20478639402e7af95e901223444240.1539598481.git.gitgitgadget@gmail.com> <xmqq1s8q34g2.fsf@gitster-ct.c.googlers.com> <20181016063323.GA25933@sigill.intra.peff.net>
User-Agent: Alpine 2.21.1 (DEB 209 2017-03-23)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K1:Nr9eOyUi890gk7b7Y5n+CvUFlQ+9Xl8NGMi/SfXDbx0BWJZi4zi
 44NI5Ba7oZiewMCHiGopKYkcemwiCS5AjBF0fkw5wi3oHjNHJLZ9NCfrk23FTtIaye3wXt1
 s679RFM7JpHU3eB4OCSS4nC0FN7LaovPi777t1YQnbwofHAXF0G/dvJ+zp6Pr4R3QsD5sLa
 mkouXia0yb6/OZUyGRhRg==
X-UI-Out-Filterresults: notjunk:1;V01:K0:8FHIrnu/zLY=:DTggl6anHMH98Pt+A2ioP1
 bWOSovEhKdnseg/WZmTm2NwNL+h+fKMJMEcssHYM3FKysCmTeMFUL2RL608N0HJb9RBOZdGk9
 rFxwhKE4NwlbY583YJiPdHB219oeQYYu+pqB4F0/DcKZzOIrpPOzkFSPlCQ75gKYAZS010zEs
 R2Hqlr2SRhbRuYOQW5jY23aCFjFXe7L0oaweCUzoNDiToiGoq9FUGFNUGqury9cfC3yWEgKBy
 rIssyAbvbdmf0HlEACH6ocJJC6EyJ1QTbO1ts15qQTAt53GHXf8skWDQMbQrbuVk/mlssPnQv
 lYweZrTsk4u9dRhWOoD6mQZSuFdVbaXdUYuzqHQVhJ4T0QOkaVl1bD26kY1gL2zG3bvvq4Xkx
 29xfqqhxNhNzlEWvSbQBb7OSHz0iYd9xGZ1p0BWJTeQ0QV2nEcaeNfuoX1Nv49UdadvKOI1Sp
 vzlsZL5DTU0PagUBQ1ozv886mkEpUC33OVJIsz8eW5Yb0OUzhVooPIsmIcWABLEuOOGco3XFf
 6EMGJeTnk/4gANrQKRQWurEe5wU+mMTh/8dPqFSG0KMXR+aJb6Hi34NyJtdSIInU1FZhB/UVG
 x94dc2keOdL4a3vZrErNdQ2xLyHkyTGRob8HDfGB/1X/htpxaqv0c5WgbuO4VOGFEdj84xTgF
 sxD5poU/0d4F4xIWu8SJ7BaCmcMxZW8vT4rLbu+fbWC27Y1BqcUZsb/bIMZA1ypdUpu3co61m
 LBauXZVVKj4ojxqBwHYIvCe1CFFrAitJqkDHLZGGPiLazKJ6gt6SfSwaY5SOvqAJqOhK6OVex
 UyhunHd32qGwsx24F58AikQqgSykQSpVRnn3aVy9O+gD9YV7dI=
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Peff,

On Tue, 16 Oct 2018, Jeff King wrote:

> On Tue, Oct 16, 2018 at 01:23:25PM +0900, Junio C Hamano wrote:
> 
> > > +#if LIBCURL_VERSION_NUM >= 0x072c00
> > > +		curl_easy_setopt(result, CURLOPT_SSL_OPTIONS, CURLSSLOPT_NO_REVOKE);
> > > +#else
> > > +		warning("CURLSSLOPT_NO_REVOKE not applied to curl SSL options because\n"
> > > +			"your curl version is too old (>= 7.44.0)");
> > > +#endif
> > 
> > That ">=" is hard to grok.  I think you meant it to be pronounced
> > "requries at least", but that is not a common reading.  People more
> > commonly pronounce it "is greater than or equal to".
> 
> This seemed oddly familiar:
> 
>   https://public-inbox.org/git/8da9d436-88b9-7959-dd9c-65bdd376bf54@mail.mipt.ru/
> 
> Since this one is clearly copied from there, it may be worth fixing the
> original.

Good memory. I just integrated the patch here. It was not signed off, but
it is too obvious to be protected under copyright, so I re-did it, adding
a nice commit message.

Ciao,
Dscho
