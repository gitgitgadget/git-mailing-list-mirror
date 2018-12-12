Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	FROM_EXCESS_BASE64,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI,T_MIXED_ES shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 4C3A220A1E
	for <e@80x24.org>; Wed, 12 Dec 2018 16:54:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727960AbeLLQyU (ORCPT <rfc822;e@80x24.org>);
        Wed, 12 Dec 2018 11:54:20 -0500
Received: from mail-qt1-f170.google.com ([209.85.160.170]:44546 "EHLO
        mail-qt1-f170.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727943AbeLLQyU (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 12 Dec 2018 11:54:20 -0500
Received: by mail-qt1-f170.google.com with SMTP id n32so21204664qte.11
        for <git@vger.kernel.org>; Wed, 12 Dec 2018 08:54:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=D7iVUVTbkVVQfLQXmSisOg2XjM19cqPnF+pv6try6pY=;
        b=UfGxIXydJ4ZBJGK1Iv/HL6mRBWx66Q3Nf/5Sl1hw1h3hoNlnaANL2g3xNvGIAcexPT
         THTDzRDwVYf1AxrNIBYCBI3ul21xaWHTHXf1pXYKhthyE+Cb9pQ+6Lfu1+H/AsF1an6A
         XULPmjJEldKeBfc7A9WxbRNY8WvRV5SiH3iElXHdsph5hf3nQu6nTDIfjdPRwxz+4sZh
         X2nOn1nE6PIPFXB3pDdyF+E5VCUUmYXpoeYW3Jm+DrH0qZaC8ysL65XvL+EclCJP9+YO
         9g7stZpqCTWK6fmBS/E3oEciqLPyqmAs7atnMYZwd3h6VZ/1Lq4RjCqwOwL4p+VB/v7W
         pggA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=D7iVUVTbkVVQfLQXmSisOg2XjM19cqPnF+pv6try6pY=;
        b=Go6FWeig8hPunuy7AvkU1UCwplIvh4YoXAPJ5cyjIA2+UH3krPrDrrSc2CTcFvIxiQ
         bcFoblsFyNAAe/Of+EpNFx7oYMIByLO/lSKp5Sj3PC+uS3/l52Ul3Zj1ez/3XElyz0EZ
         NR/38W/k2X6dmjhTuXbz6rvYKJbDEUYavJ5KMPXbwQ8MPlU1BD+6ZLK4BLTg575CpDVd
         iNC+GLVPRVkxYuD5p86bFtfTaR6y1L5ZSUDXRjvPneCBEoCIcZQh703ZtiNWvZI3nS1k
         oHq0sc3VzhSf8+VeshZpobjFvbhb8zGwvv1xFCmmx2UtGArghXec06C35Ggoa6YIx8Rr
         Cd/w==
X-Gm-Message-State: AA+aEWYZ/DjNAXvUBZYwHPcxSGGOZ++ZxvbiUn1mf1Tw2SQta2wSyiri
        +itmjUCGrXinVlx5VQI95XX5n42VvscXqa7+oEo=
X-Google-Smtp-Source: AFSGD/WFCEnSFehUeno6LtmHoRYODd16ct1WhNz8+YZchOFb0rkbwZz/bTshbAOBHYI7DdKtM73huHX0H+nXiylK3K0=
X-Received: by 2002:a0c:81c4:: with SMTP id 4mr20512644qve.156.1544633658750;
 Wed, 12 Dec 2018 08:54:18 -0800 (PST)
MIME-Version: 1.0
References: <SN1PR12MB23840AFE62E41D908A40D1B095A70@SN1PR12MB2384.namprd12.prod.outlook.com>
 <20181212112409.GB30673@sigill.intra.peff.net> <SN1PR12MB23849A5B991FB7D9213FB64595A70@SN1PR12MB2384.namprd12.prod.outlook.com>
In-Reply-To: <SN1PR12MB23849A5B991FB7D9213FB64595A70@SN1PR12MB2384.namprd12.prod.outlook.com>
From:   =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>
Date:   Wed, 12 Dec 2018 17:54:07 +0100
Message-ID: <CACBZZX6YsWs7Q3g3UARgBLQZniZUuPPuM2kaw-PHmtO+ZZrnkQ@mail.gmail.com>
Subject: Re: High locking contention during repack?
To:     "Iucha, Florin" <Florin.Iucha@amd.com>
Cc:     Jeff King <peff@peff.net>, Git Mailing List <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Dec 12, 2018 at 5:52 PM Iucha, Florin <Florin.Iucha@amd.com> wrote:
>
> Jeff,
>
> Thank you for the advice, I will reduce the depth.
>
> Running "git pack-objects --all --no-reuse-delta --delta-base-offset --st=
dout </dev/null >/dev/null", it got to 99% fairly quickly, now it has 5 thr=
eads running (using 99.9% CPU), but the "dstat 5" still shows lots of nothi=
ng, with some heavy system activity:
>
> --total-cpu-usage-- -dsk/total- -net/total- ---paging-- ---system--
> usr sys idl wai stl| read  writ| recv  send|  in   out | int   csw
>   1   8  91   0   0| 166k  224k|   0     0 |   0     0 |6892   970
>   0  13  87   0   0|   0     0 | 333B 1758B|   0     0 |2285  1374
>   0  13  87   0   0|   0     0 | 309B 1190B|   0     0 |2233  1265
>   0  13  87   0   0|   0     0 | 282B 1053B|   0     0 |2174  1239
>   0  13  87   0   0|   0     0 | 278B 1251B|   0     0 |1930  1173
>   0  13  87   0   0|   0     0 | 274B  942B|   0     0 |1987  1139
>   0  13  87   0   0|   0     0 | 264B 1168B|   0     0 |1928  1205
>   0  13  87   0   0|   0     0 | 388B 2435B|   0     0 |2245  1280
>   0  13  87   0   0|   0     0 | 268B 1145B|   0     0 |2225  1221
>   0  13  87   0   0|   0     0 | 164B  732B|   0     0 |2607  1333
>   0  13  87   0   0|   0     0 | 156B  996B|   0     0 |2100  1270
>   0  13  87   0   0|   0     0 | 206B 1019B|   0     0 |2192  1296
>   0  13  87   0   0|   0     0 | 198B  824B|   0     0 |2019  1236
>   0  13  87   0   0|   0     0 | 245B  435B|   0     0 |1974  1195
>   0  13  87   0   0|   0     0 | 252B  855B|   0     0 |1852  1166
>   0  13  87   0   0|   0     0 | 230B  758B|   0     0 |2066  1299
>   0  13  87   0   0|   0     0 | 284B  925B|   0     0 |1860  1225
>   0  13  87   0   0|   0     0 | 289B 2682B|   0     0 |1796  1197
>   0  13  87   0   0|   0     0 | 939B 1263B|   0     0 |1913  1304
>   0  13  87   0   0|   0     0 |1212B 1366B|   0     0 |1915  1343
>
> I will try running the command under the debugger and stop it when it get=
s to this point and poke around.

FWIW compiling with gcc's gprof support is probably a better way to
figure out "what was my program doing all this time?".
