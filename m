Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 91E241F453
	for <e@80x24.org>; Sat,  9 Feb 2019 08:10:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726741AbfBIIJ7 (ORCPT <rfc822;e@80x24.org>);
        Sat, 9 Feb 2019 03:09:59 -0500
Received: from mout.web.de ([212.227.15.4]:43469 "EHLO mout.web.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725946AbfBIIJ6 (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 9 Feb 2019 03:09:58 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=web.de;
        s=dbaedf251592; t=1549699789;
        bh=wq0x6LIPueF36LVaw+EFfOMVZVJLozuXjO33r9K3nHQ=;
        h=X-UI-Sender-Class:Subject:To:References:From:Date:In-Reply-To;
        b=dqC7GYKOIv4SHaJCpWFwQ9aQ6Hu6njgC81eIVT/oZXcMiZWRyke3j0jNq2URhOSef
         zdbrLuVYr3RvKagfGwqRWOFTmnwF1xsOZitGDnKxZhcOwnKgVzKdR1KIY8tSUIG9S6
         TtaUHCDnzeG0FKDvmIbNyuBRUifTI3jUoIJGwuss=
X-UI-Sender-Class: c548c8c5-30a9-4db5-a2e7-cb6cb037b8f9
Received: from [192.168.209.21] ([195.198.252.176]) by smtp.web.de (mrweb001
 [213.165.67.108]) with ESMTPSA (Nemesis) id 0Mdueb-1gTRMu2SOj-00PZfH; Sat, 09
 Feb 2019 09:09:49 +0100
Subject: Re: t0028-working-tree-encoding.sh failing on musl based systems
 (Alpine Linux)
To:     Rich Felker <dalias@libc.org>,
        "brian m. carlson" <sandals@crustytoothpaste.net>,
        Kevin Daudt <git@lists.ikke.info>, git@vger.kernel.org,
        larsxschneider@gmail.com
References: <20190207215935.GA31515@alpha>
 <20190208001705.GC11927@genre.crustytoothpaste.net>
 <20190208060403.GA29788@brightrain.aerifal.cx>
From:   =?UTF-8?Q?Torsten_B=c3=b6gershausen?= <tboegi@web.de>
Message-ID: <0c3b77bf-2903-1cd0-0fce-2ec01be91d84@web.de>
Date:   Sat, 9 Feb 2019 09:09:40 +0100
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.12; rv:60.0)
 Gecko/20100101 Thunderbird/60.5.0
MIME-Version: 1.0
In-Reply-To: <20190208060403.GA29788@brightrain.aerifal.cx>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:zY/btsOnXI1CcO9nRig6h3OZv6FlveZi/LLWTQKFa4hiOz/VPZD
 ziLn9NArRfoQ58YBPrFQag//YQfz0FVo5Eut9EBp70nJHx/e6WvQnUB+ZwjLLkM+uxtOlS2
 1zqQdssEUL2/6bRCLDQOFrdEQKEpQwCy8U0oBG04hfh21wcrbMQqkW5uJOxAMB60WZG4HSq
 fr62zPsOEK7HUy4mw+JTw==
X-UI-Out-Filterresults: notjunk:1;V03:K0:VRcQlwIhcnk=:cXIhG2FxTK6M/QN8WT6hzg
 kjWhoGY4+ldPSPH3RgEs50lGq6Spdr1CljYShUCMd/N1KExVtYBa71/cbWxZFl/ybd59K20Jz
 Ip28BjjYL/Jca6fymr33eEXfaxDmRXmaZhLZnazGC1lJcrKlhd7i6Nt1haaoDDuXhGZSWAyJN
 LE4KUtAkzmbCAc1SQrUtpVRe7JQ25Ix4mHxHb1SJjootD4CVNJzHcWmeNlzO7yqQ14KHf6VuP
 7Ef7RWjvDdzQzfToVBYVcmCO0Ng0NN650zxDj5x783jixvs+twCLLs61E40yDokqKYOf+qbvK
 g2CveUy0fx8AGMHePKeViAQA/xjN/Ra35mUXX0dtFaFhLpwuNUbl2n/Y8N1sZmqEZj5JQs/B1
 cbbtyZyNWQx2UbkkIyRcyl7FlSWizRh2fD+tt6JJz5YVTlA43I/iy4IzrLZpHEWgkDLiu8dDr
 PqA4Il5zEMBD6XCtbuPLAJyqrytTn+526k6Y+6koASeAPn99EUlEU4DV+6XhLY/rpc+MiBmJ6
 vFikPSVphUXcPnJYsEhYxaVHMoinfSYGW9ezXMfOp+RkEXdL5aANUohKLU0Mn0ZzjX6qN3qOr
 KAoCgf5uWEhiW7VMtg3DuVhIuhM+YER5kZJClzFf8N+0nWtqRVUNbdfRPrSr2Wax5Q9NRe/2d
 BjFuIq4iA9n99IUbHyVD36BKgoH8PosCVA1Oc2oCg/BjKHol5P/UyLnbTUNnZa+3tMHWzyZ+j
 GIvEfbxSe0q0qEvIkcjwNrE+AMIvcLrIV859Nqgh8Lvvo4KfI59t/tJ4nK8EmlLo/HLivk6vv
 4WRQampc+y7Quj9ed8C2Vzwtd/gr0X2zacZAEPZbHSy5tG6wI0cvtu9NNkS43Az68utdDTdmX
 H+oYp3/I1yAK/wI7+Lo1xfKWvh1DPP3OK3JnwD5Lnx4jVjesMWGQZPlW2JHP7M
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 08.02.19 07:04, Rich Felker wrote:
> On Fri, Feb 08, 2019 at 12:17:05AM +0000, brian m. carlson wrote:

[]
>> Even if Git were to produce a BOM to work around this issue, then we'd
>> still have the problem that any program using musl will write data in
>> UTF-16 without a BOM. Moreover, because musl, in violation of the RFC,
>> doesn't read and process BOMs, someone using little-endian UTF-16 (with
>> a proper BOM) with musl and Git will have their data corrupted,
>> according to my reading of the musl website.
>
> That information is outdated and someone from our side should update
> it; since 1.1.19, musl treats "UTF-16" input as ambiguous endianness
> determined by BOM, defaulting to big if there's no BOM. However output
> is always big endian, such that processes conforming to the Unicode
> SHOULD clause will interpret it correctly.
>
> The portable way to get little endian with a BOM is to open a
> conversion descriptor for "UTF-16LE" (which should not add any BOM)
> and write a BOM manually.
>

That is possible in the next upcoming version of Git:

commit 0fa3cc77ee9fb3b6bb53c73688c9b7500f996b83
Merge: cfd9167c15 aab2a1ae48
Author: Junio C Hamano <gitster@pobox.com>
Date:   Wed Feb 6 22:05:21 2019 -0800

    Merge branch 'tb/utf-16-le-with-explicit-bom'

    A new encoding UTF-16LE-BOM has been invented to force encoding to
    UTF-16 with BOM in little endian byte order, which cannot be directly
    generated by using iconv.

    * tb/utf-16-le-with-explicit-bom:
      Support working-tree-encoding "UTF-16LE-BOM"


