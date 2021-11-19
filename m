Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2B738C433F5
	for <git@archiver.kernel.org>; Fri, 19 Nov 2021 01:45:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 061AC61AA7
	for <git@archiver.kernel.org>; Fri, 19 Nov 2021 01:45:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232358AbhKSBso (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 18 Nov 2021 20:48:44 -0500
Received: from azure-sdnproxy.icoremail.net ([52.229.168.213]:50878 "HELO
        azure-sdnproxy-2.icoremail.net" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with SMTP id S229514AbhKSBsn (ORCPT
        <rfc822;git@vger.kernel.org>); Thu, 18 Nov 2021 20:48:43 -0500
Received: from mailtech.cn (unknown [10.12.1.20])
        by hzbj-icmmx-1 (Coremail) with SMTP id AQAAfwCXKrd8AZdhusAUCA--.20459S2;
        Fri, 19 Nov 2021 09:44:28 +0800 (CST)
Received: from pwxu$coremail.cn ( [112.94.4.17] ) by
 ajax-webmail-mailtech_rd (Coremail) ; Fri, 19 Nov 2021 09:45:33 +0800 (CST)
X-Originating-IP: [112.94.4.17]
Date:   Fri, 19 Nov 2021 09:45:33 +0800 (CST)
X-CM-HeaderCharset: UTF-8
From:   =?UTF-8?Q?Aleen_=E5=BE=90=E6=B2=9B=E6=96=87?= <pwxu@coremail.cn>
To:     "Junio C Hamano" <gitster@pobox.com>
Cc:     "Aleen via GitGitGadget" <gitgitgadget@gmail.com>,
        git@vger.kernel.org, =?UTF-8?Q?Ren=C3=A9_Scharfe?= <l.s.r@web.de>,
        "Phillip Wood" <phillip.wood123@gmail.com>,
        Aleen <aleen42@vip.qq.com>
Subject: Re: [PATCH v6 0/3] am: support --empty=(die|drop|keep) option to
 handle empty patches
X-Priority: 3
X-Mailer: Coremail Webmail Server Version XT6.0.3 build 20211103(a39c0bb8)
 Copyright (c) 2002-2021 www.mailtech.cn
 mispb-4edfefde-e422-4ddc-8a36-c3f99eb8cd32-icoremail.net
In-Reply-To: <xmqqilwpuiv4.fsf@gitster.g>
References: <pull.1076.v5.git.1637141636.gitgitgadget@gmail.com>
 <pull.1076.v6.git.1637232636.gitgitgadget@gmail.com>
 <xmqqilwpuiv4.fsf@gitster.g>
Content-Transfer-Encoding: base64
Content-Type: text/plain; charset=UTF-8
MIME-Version: 1.0
Message-ID: <b9c1244.36.17d35decb26.Coremail.pwxu@coremail.cn>
X-Coremail-Locale: en_US
X-CM-TRANSID: AgIMCgAXXla9AZdhgQIAAA--.103W
X-CM-SenderInfo: psz03q5fruvzxdlohubq/1tbiAQcLCFGCdOPCVgADsW
Authentication-Results: hzbj-icmmx-1; spf=neutral smtp.mail=pwxu@corem
        ail.cn;
X-Coremail-Antispam: 1Uk129KBjvdXoW7Jr4UZrWxJw1xWr4rAFykAFb_yoWDtrbEkF
        n5AF1IgF4vvw4UKFn5Wr17ZryFqrW7t34DK3WqqF13C345ZF1DXFZYyFWFv3ZxAa97Wr9x
        uw4fC3W0qrn09jkaLaAFLSUrUUUUjb8apTn2vfkv8UJUUUU8wcxFpf9Il3svdxBIdaVrnU
        Uv73VFW2AGmfu7jjvjm3AaLaJ3UjIYCTnIWjDUYxBIdaVFxhVjvjDU0xZFpf9x0zRUUUUU
        UUUU=
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

PiAtLS0tLU9yaWdpbmFsIE1lc3NhZ2VzLS0tLS1Gcm9tOiJKdW5pbyBDIEhhbWFubyIgPGdpdHN0
ZXJAcG9ib3guY29tPlNlbnQgVGltZToyMDIxLTExLTE5IDA3OjQ3OjExIChGcmlkYXkpVG86IkFs
ZWVuIHZpYSBHaXRHaXRHYWRnZXQiIDxnaXRnaXRnYWRnZXRAZ21haWwuY29tPkNjOmdpdEB2Z2Vy
Lmtlcm5lbC5vcmcsICJSZW7DqSBTY2hhcmZlIiA8bC5zLnJAd2ViLmRlPiwgIlBoaWxsaXAgV29v
ZCIgPHBoaWxsaXAud29vZDEyM0BnbWFpbC5jb20+LCAiQWxlZW4g5b6Q5rKb5paHIiA8cHd4dUBj
b3JlbWFpbC5jbj4sIEFsZWVuIDxhbGVlbjQyQHZpcC5xcS5jb20+U3ViamVjdDpSZTogW1BBVENI
IHY2IDAvM10gYW06IHN1cHBvcnQgLS1lbXB0eT0oZGllfGRyb3B8a2VlcCkgb3B0aW9uIHRvIGhh
bmRsZSBlbXB0eSBwYXRjaGVzCj4gCj4gCj4gQXMgcGVyIGh0dHBzOi8vZ2l0LXNjbS5jb20vZG9j
cy9TdWJtaXR0aW5nUGF0Y2hlcyNzaWduLW9mZjoKPiAKPiAgICBQbGVhc2UgZG9u4oCZdCBoaWRl
IHlvdXIgcmVhbCBuYW1lLgo+IAo+IEkgc3VzcGVjdCB5b3VyIHJlYWwgbmFtZSBpcyBub3QgQWxl
ZW4sIGJ1dCBzb21ldGhpbmcgd2l0aCB4IGFuZCB3IGluCj4gaXQuCj4KCkkgaGF2ZSB1c2VkICJB
bGVlbiIgPGFsZWVuNDJAdmlwLnFxLmNvbT4gYXMgbXkgR2l0SHViIGFjY291bnQgdG8gc2VuZCB0
aGlzIHB1bGwgcmVxdWVzdCwgYnV0IHRoZSBlLW1haWwgc2VydmljZSBkaXNndXN0cyBtZSB0aGF0
IGl0IGlzIHNsb3cgdG8gc2VuZCBlbWFpbHMgdG8gdGhlIGRvbWFpbiAidmdlci5rZXJuZWwub3Jn
Ii4gU28gSSBkZWNpZGVkIHRvIHVzZSBhbm90aGVyIG1haWwgc2VydmljZSB0byBkaXNjdXNzLCAi
QWxlZW4g5b6Q5rKb5paHIiA8cHd4dUBjb3JlbWFpbC5jbj4gYXMgeW91IHNhdy4KCkluIHRoZSBv
cGVuLXNvdXJjZSB3b3JsZCwgSSB1c3VhbGx5IHNpZ25lZCBvZmYgIkFsZWVuIiByYXRoZXIgdGhh
biAiQWxlZW4g5b6Q5rKb5paHIiwgYW5kIGlzIHRoYXQgbmVjZXNzYXJ5IHRvIGNoYW5nZT8=

