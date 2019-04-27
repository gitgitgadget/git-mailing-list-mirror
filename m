Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,
	DKIM_ADSP_CUSTOM_MED,DKIM_INVALID,DKIM_SIGNED,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 322411F453
	for <e@80x24.org>; Sat, 27 Apr 2019 05:58:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726032AbfD0F6k (ORCPT <rfc822;e@80x24.org>);
        Sat, 27 Apr 2019 01:58:40 -0400
Received: from mail-pg1-f182.google.com ([209.85.215.182]:40892 "EHLO
        mail-pg1-f182.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726001AbfD0F6j (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 27 Apr 2019 01:58:39 -0400
Received: by mail-pg1-f182.google.com with SMTP id d31so2588458pgl.7
        for <git@vger.kernel.org>; Fri, 26 Apr 2019 22:58:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:user-agent:in-reply-to:references:mime-version
         :content-transfer-encoding:autocrypt:subject:to:cc:from:message-id;
        bh=qbUMX4lnXpzvgs+yL29Qwy9grnHDD5oELMSeIUKbMB4=;
        b=B5C5p3I/glVdsNTV0LmyahXLwoRgmivLAU0cbAi0XABh6xpfRwLBH8hBZDcWIFllBc
         tOx+GOFGgYb2WHM1+vIRT/JVhunGuTHybM4S82dGV6nSWfPzuy0kSB0gd8zn6Iw9vniG
         qBW0qMsNZ9OC392j6I2V/04S1g2nLuT359qOit2Ggvpfa1U6V+Bazv/uWJDLHKBVtOiv
         O+KH66siOPKpWX/TGaleaNCFrBYHcAKlu9RAFdimBXN7ihHTVwInYbsBChaQOSuiGM22
         ewFD7Pt5T3nMdpL3m0cJEte399daLrCRiVGEYBnm9XaKfhbkXaJvgmKrj1T3yU9KUfTG
         4XoQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:user-agent:in-reply-to:references
         :mime-version:content-transfer-encoding:autocrypt:subject:to:cc:from
         :message-id;
        bh=qbUMX4lnXpzvgs+yL29Qwy9grnHDD5oELMSeIUKbMB4=;
        b=cfIj9QkqFagI/D9XyD5zfUONARIe2GGwStM6h1jB6VFmpaTmcZyIzeW4o78PLw8jkJ
         E3qQLTSz3yTuSwzqZQzvKBS8r15J0RprIB+KmfIIgn0JyPZjbSR9YkM3ZWpiWK1/Td73
         6bch16IZc/zTc50FWpsfjEdD/HeSdEBfH2NBcec/0Nj+mwqTMavd8XX2hgjaWbHdj2WI
         sLhDbR0CWhWE+Ua8ci2zaLjMZ+gtysChbH4551zpSLpOB+Ng7tkqnTtvmba7r3XkYllg
         C7csmgayvXzEfVudDoDcTBCjS/P1OVMfO2wKCZ5E1lRuFCuMqbjExdb9Y2hRJDTGnEcP
         Q+qQ==
X-Gm-Message-State: APjAAAUh94+HOzD0eeqHqE4pCkdLvw6E5+Po8zA85WYjgmZmc+Cbmkbb
        eGsn4ioz6Cnb/5r+Yjpp7uA=
X-Google-Smtp-Source: APXvYqyr4W2HC/FC4DDEkjmou30YdUxH+WX/XYoCnWnun0FuHt8WHoU5hWNR0MpA888TYFx4ND1Kww==
X-Received: by 2002:aa7:90ca:: with SMTP id k10mr49836915pfk.144.1556344718696;
        Fri, 26 Apr 2019 22:58:38 -0700 (PDT)
Received: from [100.112.22.39] ([27.62.7.71])
        by smtp.gmail.com with ESMTPSA id r87sm46382968pfa.71.2019.04.26.22.58.37
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 26 Apr 2019 22:58:38 -0700 (PDT)
Date:   Sat, 27 Apr 2019 11:27:22 +0530
User-Agent: K-9 Mail for Android
In-Reply-To: <CAPc5daVL5Jn2M-pban1wPPNOnkjyvUAKynJQBtVBeSzGQoxZ+w@mail.gmail.com>
References: <xmqqsgu6wfv9.fsf@gitster-ct.c.googlers.com> <20190426050531.GA7854@Taylors-MBP.hsd1.wa.comcast.net> <xmqqd0l9uxv1.fsf@gitster-ct.c.googlers.com> <E6B28E44-5859-436B-A620-2FB484EEB657@gmail.com> <CAPc5daVL5Jn2M-pban1wPPNOnkjyvUAKynJQBtVBeSzGQoxZ+w@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: quoted-printable
Autocrypt: addr=kaartic.sivaraam@gmail.com; keydata=
 mQINBFnvIZcBEACjJC0cawLgzPXd2EGPtDQ+HvmrUSLd9TrbUabqiT/YeXGgkYaP3DHwauNeLR0c
 fJhw20cyftoCq7qU6cDtCXcmBb5JzttvrT+4y6RcvoxTsw22i5TYxzZ/O2d9AVov0Jj8JH/L00wZ
 fHExhXok8Qlr9wyU70z9N8GLjaABWevzqrN2eNdV6vdNv7wJFZBTNz4SnNNnHQhAf2ypBgTFQGzQ
 e8Dq5S8YxOZQm6TMFKjXgK6fQy3AuoIk1yOIXkv5tc7LzOIEoiMAnQZ4u8BmOgyXW7s4Uvw+j9yu
 hXGEdqfU4Sfd6EaRNHIPXueEXmsErqamBaQ2anomRdVbroife/jILhxhVYRnkGe+PzJa98csS7aD
 XWAYxiHJHYJdlcqSre5XpfqM0Tqf1CWiEEitNCoKciWywa+EC3bA0cEug/ckF8YcLO9C9sRCg+20
 e9PMg1Aa3lhftJBQSG3oQ15bvMVZ7Vx4/H9LUJL/j5+iMRK8H0Zrg2m5Bxx/JRzBn0wzdmsEaP+1
 J0NYRqt56dPNULRIsHdGTP22Ma/irqNxTX7nBTb+vwXebz6PHiO1gm1wu46tosOI0tfFvAvf/2Hs
 gaYUUffltNcTh21IQVtbCjF2TYcYRVeT/rcZ4WpUcIE8MP9Y+GIRffveumBm3ymBv8527BKpUdIk
 UktD823bFUEUgQARAQABtC1LYWFydGljIFNpdmFyYWFtIDxrYWFydGljLnNpdmFyYWFtQGdtYWls
 LmNvbT6JAlEEEwEIADsCGwMFCwkIBwIGFQgJCgsCBBYCAwECHgECF4ACGQEWIQSaunlPpC6CxtSc
 3Q2951raw9YZaQUCWfnypwAKCRC951raw9YZaX7sD/470YpgttrXPvjhg/kQTu4AGQrLkWLqWXPW
 LHD5U4eeE/P8N3w0jsM+B2tCRDiA41VFWR9yRfVSksQLOlTiHlA5fdmqX0Aho8ZcCW6y3i6TSlSF
 5ug+AjuEnAVRur7LNCah3oPkZpPhQr96EYXYmY+J+fA57MaQk/7BWqxWo/cdZaXu7XfSeFJ3/uxZ
 cmbUXjiBxCZT49CN4pN0GcfL+hFKNcv78S3HlDR5/2xdSbRbpxcwwUsx+V4jxI3gQiuu6fxHak50
 60IJTJ4uX5ckfEQo7Md4tgZu3mrHOqojHywHIogOoZ0udmLqmLYBOi7H1aWCi0xhEIvXp3wFlWG4
 Cs+Zm9e9xpwVP/lPe9+LBBfO6FytUI3hrAhVhUwFjfOsugykFJsBKrAXaxkM1fy+ip74NgbEsE6g
 RTm8Ek41lazPOQ0pQOZ6SPX1VNaFV6vz2HWlaCiRLmlsret7U3yMBpcc++PR2gdRUdv2l3krA4ZJ
 LrZITKKKDLplb7GTmkUlbZ/bpuszjjf40+t/0whyhnoqWuquYUsm2Xv6xasAaImloeOkMZJJ1Ly2
 0sdSCh8rOzqDFAdwu9JHlu4mUSClwEr8iRzO9yn5bJiFNPNqbBiCtVP2wFrWxRdz6rrk/vjTU2lZ
 sIwO4CJZ6ACQsybzhiwNJXOi++mLMMEFyGMT7bQxIbkCDQRZ7yGXARAA4Dll9pMQUa47gquU+blP
 hhlqrW4UjGzWe+gjKkxTp1emUaG2fIPfW9ymmDAXQhC8q/eYyHoEmnJ5lyrNbzxxcNzd9ugFd70a
 ZBQTtW3qlzfUBeMV3wyCtMkNnE702ZtYJkvzNJxmEem5vPlCW9gLsNuNFwo358lG9iKBIR+oachl
 ikxsN0+tocqe4XG+KAh08FenIAjyWidFoX2LQUvuSXX7O0brUg9VbMKTHSTWuZEUqELJUFPjQVV8
 NlgvLRSgz8xTNI+QVybbay1ZNUrI6hKG6GavRibPuAhtEsJ+SMS8lYRk4FkyFOZfpJhKv4uuIbUS
 O4MBffIsj92qAWw0Xt400NaKwh/UOXYS5Rs8o0MCM/Vxa9AYbP5UvhYVb4W4/JDAZXy5o/1myNUq
 pDw8JG4uXYYtxUpo+OaogdJhWT3n3sb7xwFEod/T0Zgttlh3PVnEiXuUsrB+Z0JYZw3/nZXw8rBm
 h1fC735v4t+U9s5YLKVePWvHr12TSV31aTUbZuHDL6fRi93uEqm96VghmkMbSziv3iX+v8RkM93l
 +w7pd0rYUy6H3cUDV9q29DLo9BOFCUzR9enskWQA4ezSx4AV3boNuVFMsFhxgdDqkyqkm+qsSq/w
 YnsIT2uvcg2lqgNyIER4CezzPgXj7sNcXfvFedyAmsiOARt+oIIFjykAEQEAAYkCPAQYAQgAJhYh
 BJq6eU+kLoLG1JzdDb3nWtrD1hlpBQJZ7yGXAhsMBQkFucBRAAoJEL3nWtrD1hlpPfsP/j4ewvV1
 q6ZuBx+IAzHCFpZ60+yyJmHRlwwxlFjjFe9pV+r1/Zb4WxUNbTSyAP65zlTsOXK8nlR0AKXhtjdn
 I2mUrMuHcZgug4vz3NCDgWVeBy70n1kunQJpNc+FEFYZEdRbPpNGWfaMnr5wVtr/O4aPq4sTxs1I
 V6/MUL+tyuqDpzAnpj3deZ/RsiVHjNNwD0hs6nkRoHOjgmi5rUgrebNbJxxTMhJk8OfLcsxx/FPY
 +6Myjnis3dxFCFR37vjSjm9GSRRTxlI5Mq+jGgvag9Ww/nueTxFMUgXWQ6m/aws/FnXBImA8EC9M
 NjH8ZGUN2oThrnbzlBpBnfkCzriCtKxBjxP1ZeDeBuWoI1eZzeXIa+yx1EbLoRcnNCNVFE2dHgYb
 dhFFzR+lvJOOI0BdvO/wWS6zZRi5vLE0EQJX81Glsj6aY4+sIc83NsTaNpaIqIbYIzp/wNN4uUza
 h6XcnVQCm3OtfhW+scjdqUhvihDeWlf684OUTf7huTfYbWOE+DzAT+hrs0oaEXuVlUBBYkZ4Hv7M
 8LuQGn64pFrm4grbF/wxkmvgeyBTQA/A9WNWndlinlFYiZGmDoiZUAcSKA9oBTPc4jXwW/YIfNYw
 d7SlatiwKjF1QxuL1X0QMMPstR/UoVc3sbiabb4Km5jS2oU9q6KpeikRshMIIZ7P/DJ/
Subject: Re: What's cooking in git.git (Apr 2019, #05; Thu, 25)
To:     Junio C Hamano <gitster@pobox.com>
CC:     Taylor Blau <me@ttaylorr.com>,
        Git Mailing List <git@vger.kernel.org>
From:   Kaartic Sivaraam <kaartic.sivaraam@gmail.com>
Message-ID: <BC8CBCB5-4E43-450E-9908-2470ECE353F3@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Junio,



On 27 April 2019 10:36:55 GMT+05:30, Junio C Hamano <gitster@pobox=2Ecom> =
wrote:
>2019=E5=B9=B44=E6=9C=8827=E6=97=A5(=E5=9C=9F) 2:58 Kaartic Sivaraam <kaar=
tic=2Esivaraam@gmail=2Ecom>:
>>
>
>I can click it and reach https://github=2Ecom/git/git/commit/c49927fca0d
>but then
>that is more like "git show c49927fca"=2E I can even go to its second
>parent with
>one click, but that is equivalent to "git show 97dd512a"=2E  The page you
>showed,
>which is a rough equivalent to "git log --oneline 97dd512", is what I
>want to get
>to from there, but I am not sure how to get there X-<=2E

I seem to know of two ways to get to where you want to get to (git log --o=
neline 97dd512) from the page similar to "git show 97dd512" [1]=2E

1=2E A direct way that requires two clicks:
a=2E You should click on the 'Browse files' button you see in the page tha=
t shows output like git show [1]=2E Then you'll get to the page where you s=
ee the files in the repository just like when you checkout 97dd512 [2]=2E
b=2E From that page you could click on the number of commits to get to the=
 page you want to see (page which shows output like "git log --oneline 97dd=
512") [3]=2E

2=2E A simple but indirect way is to edit the URL when you are in page [1]=
, and replace the 'commit' part in it with 'commits'=2E This is not a relia=
ble way as there's a possibility that they could change the URL format but =
it seems to be working well for me so far :-)

Hope that helps=2E

References:

[1]: https://github=2Ecom/git/git/commit/97dd512af7ce4afb4f638ef73b4770921=
c8ca3aa

[2]: https://github=2Ecom/git/git/tree/97dd512af7ce4afb4f638ef73b4770921c8=
ca3aa

[3]: https://github=2Ecom/git/git/commits/97dd512af7ce4afb4f638ef73b477092=
1c8ca3aa

--=20
Sivaraam

Sent from my Android device with K-9 Mail=2E Please excuse my brevity=2E
