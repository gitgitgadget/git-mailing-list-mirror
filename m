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
	by dcvr.yhbt.net (Postfix) with ESMTP id A55011F461
	for <e@80x24.org>; Wed, 26 Jun 2019 15:05:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728041AbfFZPFC (ORCPT <rfc822;e@80x24.org>);
        Wed, 26 Jun 2019 11:05:02 -0400
Received: from mout.gmx.net ([212.227.17.20]:48213 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726104AbfFZPFC (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 26 Jun 2019 11:05:02 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1561561486;
        bh=nkQX4PWFtxlsqE2E5ShaJW6qcOikd9FLgKAbU9ZIrrg=;
        h=X-UI-Sender-Class:Date:From:To:cc:Subject:In-Reply-To:References;
        b=eD15foIrag9hhOc5bWfvG3BpnkxIEHBYQFan5XhlVrWsXpv2WnFk5i1RTe5zClx40
         swXAfgEU3wmbpmXRIV+yFJZtzExy3E5IZW+1kkbJH1LsFTCG3J7hxTAn4YijwKpLG9
         WxoP8SMYcDRVPsoLRvbgudCMrmNm8A6QHtrljg8E=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [192.168.0.129] ([37.201.192.51]) by mail.gmx.com (mrgmx102
 [212.227.17.168]) with ESMTPSA (Nemesis) id 0LnUna-1iDZom2SHW-00hbl5; Wed, 26
 Jun 2019 17:04:46 +0200
Date:   Wed, 26 Jun 2019 17:05:06 +0200 (CEST)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@gitforwindows.org
To:     Ramsay Jones <ramsay@ramsayjones.plus.com>
cc:     Duy Nguyen <pclouds@gmail.com>,
        Git Mailing List <git@vger.kernel.org>,
        Junio C Hamano <gitster@pobox.com>,
        Jeff King <peff@peff.net>, Derrick Stolee <stolee@gmail.com>,
        =?UTF-8?Q?=C3=86var_Arnfj=C3=B6r=C3=B0_Bjarmason?= 
        <avarab@gmail.com>
Subject: Re: [PATCH v2 00/10] Add 'ls-files --debug-json' to dump the index
 in json
In-Reply-To: <27211d51-c77f-84f8-49c0-4bc104baa266@ramsayjones.plus.com>
Message-ID: <nycvar.QRO.7.76.6.1906261704330.44@tvgsbejvaqbjf.bet>
References: <20190624130226.17293-1-pclouds@gmail.com> <nycvar.QRO.7.76.6.1906241954290.44@tvgsbejvaqbjf.bet> <CACsJy8BsT-GaVvEmqfk5n1jGmkcLG_bRjqcU0M3yefBmNSxmnA@mail.gmail.com> <nycvar.QRO.7.76.6.1906251311280.44@tvgsbejvaqbjf.bet>
 <CACsJy8B9vd9YaP_FHN-EDEPc_OHgD=MtFu8WymM66PURWX=25Q@mail.gmail.com> <nycvar.QRO.7.76.6.1906251601240.44@tvgsbejvaqbjf.bet> <27211d51-c77f-84f8-49c0-4bc104baa266@ramsayjones.plus.com>
User-Agent: Alpine 2.21.1 (DEB 209 2017-03-23)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K1:JyqieXlqttOZ+WgGNOl2iaU+JccPAPik+cipLhyOj8b+sxXZpCs
 z3QeyyS+3yOmMUyzzzegEuNfxgLPEEitnsRZ9UdfSTcQJWFZCchfVPzUkdzVrM67xg+ZVpc
 QYAypd0FfTGNQPJ2H1MPbqgIVWLNjrqOLn8c6UmtBEmj17CTKmHLABhcbiEYSvxWRZBizAH
 2xuae7rSn1/u5FX3YHZhQ==
X-UI-Out-Filterresults: notjunk:1;V03:K0:wNyN7t1QGfE=:0J4wjzY9205S/iGxtsvIFD
 NC+XEzHrRSFX4TqHv8tyR+0Xo/GFJlz35TLxS7UTTNN1PsC2eLa/GooqCVpgQcR/0u9P85okG
 RxXvaLQXQfUfbbG9aTHSl5e/Kcqco+cIkAgEV8WaYtwU7kBUV9S4OBN4avVVz1KPQo5tKqzEX
 R73GNcgQ5ILOopZtV850D6U5pCWp8agYSCjLGfnEYpGbJtVYLCdlwo4Mz180D2zLhQuv+Nzk1
 6HTeGN8tRK+TYoY7w8QZcJrsFy/UNLE63DXGNl7FxZ2q6B78vhkFQs3a7EpTWrfE1priE5EB8
 PMJtJuCIr6AymgtCcGaZ5DjiuE/ap4ck8pE0x2VAp7wNDHGoe8SI5cfIHz8o/hGRjmpvobEp0
 oUK70nIXb61/1zUuMgQBj9gD9kSA+H+Tz2FGcYCNLrZPpp1ngNmOQocGXNN0xxFRZzvydf3IC
 NHsW4dR8fKjHHR7HSv9pZYbrAFZEnQ+GzxMlxJvsJw4LiK7cZx3Nf0E3RHbYWDtgdmM5CTlUq
 Ba4uIWVQJLWoZKGXMriAyyfGnEmQzrwsAIuPAVx5mu5SyCwExi/IeWAVFGWcnp0THPTsW3EZZ
 DUVZvkvP7x1643XiBmMoKaNwLUBLjrAmGiUfjfYCblbSogNZjcu9hU3gOZ8cXcuPRW+o1/ytN
 ec0cnPlsetbNkQHMJNP+52q0O5Bm1VUAMIRKR4UOR4ZNLN5PAF4kCUdEr3hTtLeDykZYSICsQ
 oSIEQvPdqOxHWPmIr7x/aWCFl/McGCJlImWA+Szlgh83RKGZYcjPkWwpN1Ux5wUa/gED3q/6T
 1YDMTaxDHa3Wx5pRKuRjLOgKRvCgwBhPZFcECbx7lquaqGuEH+oJ0IPHnFPsdRnE+0Ommftbh
 sjLBDL7IjqPYsk5L8tbz5AOiGIZwZHceC8z5WGb4+a52UXcADHAgpUO7n1dnlCpjtmgmJuMbj
 PurhwAZLfM0B8t/hRGUrg2XfkPkWnwniU3dFIyVN86b6/CgX7V3KHb3rux5qoBOlKomtDMkSS
 IrfKFnp3vFTLsMpCO75h+6IMuK8ej/ydBr+lgEIzoqyT0wcTvLoWQy49kcPhcoQibvbEuQ//u
 LnlRXLDMH3SHVtVw4t2Elz4LpHaXblmYYKS
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Ramsay,

On Tue, 25 Jun 2019, Ramsay Jones wrote:

> On 25/06/2019 15:10, Johannes Schindelin wrote:
> > Hi Duy,
> [snip]
>
> >> Again our experiences differ. Mine is mostly about extensions,
> >> probably because I had to work on them more often. For normal entries
> >> "ls-files --debug" gives you 99% what's in the index file already.
> >
> > Like the device. And the ctime. And the file size. And the uid/gid. Is
> > that what you mean?
>
> Hmm, well I think so:
>
>   $ git ls-files --debug git.c git-compat-util.h
>   git-compat-util.h
>     ctime: 1561457278:502638001
>     mtime: 1561457278:502638001
>     dev: 2049	ino: 262663
>     uid: 1000	gid: 1000
>     size: 35440	flags: 0
>   git.c
>     ctime: 1561457278:518646000
>     mtime: 1561457278:518646000
>     dev: 2049	ino: 263083
>     uid: 1000	gid: 1000
>     size: 26837	flags: 0
>   $
>
> I have occasionally added stuff to the '--debug' output
> while debugging something, but the above is usually
> sufficient for my uses. (Having said that, I have not
> had the need to debug extensions [yet!]).

Well, live and learn. So for debugging purposes, we already have a good
facility and would not need JSON at all.

Good to know,
Dscho
