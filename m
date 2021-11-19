Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 35DD1C433EF
	for <git@archiver.kernel.org>; Fri, 19 Nov 2021 17:15:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0C8C561A03
	for <git@archiver.kernel.org>; Fri, 19 Nov 2021 17:15:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235488AbhKSRSR (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 19 Nov 2021 12:18:17 -0500
Received: from zg8tmty3ljk5ljewns4xndka.icoremail.net ([167.99.105.149]:41368
        "HELO zg8tmty3ljk5ljewns4xndka.icoremail.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with SMTP id S236357AbhKSRSP (ORCPT
        <rfc822;git@vger.kernel.org>); Fri, 19 Nov 2021 12:18:15 -0500
Received: from mailtech.cn (unknown [10.12.1.20])
        by hzbj-icmmx-2 (Coremail) with SMTP id AQAAfwB3o9On25dhlP_cBQ--.27005S2;
        Sat, 20 Nov 2021 01:15:39 +0800 (CST)
Received: from pwxu$coremail.cn ( [103.144.148.95] ) by
 ajax-webmail-mailtech_rd (Coremail) ; Sat, 20 Nov 2021 01:14:47 +0800 (CST)
X-Originating-IP: [103.144.148.95]
Date:   Sat, 20 Nov 2021 01:14:47 +0800 (CST)
X-CM-HeaderCharset: UTF-8
From:   =?UTF-8?Q?Aleen_=E5=BE=90=E6=B2=9B=E6=96=87?= <pwxu@coremail.cn>
To:     "Junio C Hamano" <gitster@pobox.com>
Cc:     "Johannes Schindelin" <johannes.schindelin@gmx.de>,
        git@vger.kernel.org, =?UTF-8?Q?Ren=C3=A9_Scharfe?= <l.s.r@web.de>,
        "Phillip Wood" <phillip.wood123@gmail.com>,
        Aleen <aleen42@vip.qq.com>
Subject: Re: [PATCH v6 0/3] am: support --empty=(die|drop|keep) option to
 handle empty patches
X-Priority: 3
X-Mailer: Coremail Webmail Server Version XT6.0.3 build 20211103(a39c0bb8)
 Copyright (c) 2002-2021 www.mailtech.cn
 mispb-4edfefde-e422-4ddc-8a36-c3f99eb8cd32-icoremail.net
In-Reply-To: <xmqqr1bcqe6p.fsf@gitster.g>
References: <pull.1076.v5.git.1637141636.gitgitgadget@gmail.com>
 <pull.1076.v6.git.1637232636.gitgitgadget@gmail.com>
 <xmqqilwpuiv4.fsf@gitster.g>
 <b9c1244.36.17d35decb26.Coremail.pwxu@coremail.cn>
 <xmqqmtm0snol.fsf@gitster.g>
 <2ebb863f.246.17d37140518.Coremail.pwxu@coremail.cn>
 <xmqqr1bcqe6p.fsf@gitster.g>
Content-Transfer-Encoding: base64
Content-Type: text/plain; charset=UTF-8
MIME-Version: 1.0
Message-ID: <6c267a9e.471.17d39318b2b.Coremail.pwxu@coremail.cn>
X-Coremail-Locale: en_US
X-CM-TRANSID: AgIMCgAXXlaK25dhXAsAAA--.585W
X-CM-SenderInfo: psz03q5fruvzxdlohubq/1tbiAQcLCFGCdOPTGwABsI
Authentication-Results: hzbj-icmmx-2; spf=neutral smtp.mail=pwxu@corem
        ail.cn;
X-Coremail-Antispam: 1Uk129KBjvdXoWrZFy5KrW5XrWDXw1Uur43trb_yoW3uwb_Ca
        48GFyDWa1UJFsrJF42yrsxZFWS934DXF90qF4DXr1fJF95Z3WqkFn3Jr9xAF4xGFs5Kwn8
        Gr1xAw40q3y7ZjkaLaAFLSUrUUUUUb8apTn2vfkv8UJUUUU8wcxFpf9Il3svdxBIdaVrnU
        Uv73VFW2AGmfu7jjvjm3AaLaJ3UjIYCTnIWjDUYxBIdaVFxhVjvjDU0xZFpf9x0zRUUUUU
        UUUU=
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

IAo+IENhbiBzb21lYm9keSBmcm9tIEdHRyBsYW5kIGhlbHAgdGhpcyB1c2VyPyAgSSBfdGhpbmtf
IHRoZSBlYXNpZXN0Cj4gd29ya2Fyb3VuZCAob3RoZXIgdGhhbiBub3QgdXNpbmcgR0dHIGFuZCBz
ZW5kaW5nIGUtbWFpbCBpbiB0aGUgb2xkCj4gZmFzaGlvbmVkIHdheSkgaXMgdG8gY29tbWl0IGFu
ZCBzaWduLW9mZiB1bmRlciB0aGUgcmVhbCBuYW1lLCBhbmQKPiBwdXNoIHVuZGVyIHdoYXRldmVy
IEdpdEh1YiB1c2VybmFtZSB0byB0aHJvdyBhIEdHRyBwdWxsIHJlcXVlc3QsCj4gd2hpY2ggR0dH
IHNob3VsZCBiZSBhYmxlIHRvIHRha2UsIGFzIEkgaGF2ZSBzZWVuIHVzZXJzIGZvcndhcmQgb3Ro
ZXIKPiBhdXRob3JzIGNvbW1pdHMganVzdCBmaW5lLgoKV2hlbiBpdCBjb21lcyB0byBHR0csIEkg
anVzdCB3YW50IHRvIGtub3cgd2hldGhlciB0aGlzIGlzIHRoZSBvbmx5CndheSB0byBjb250cmli
dXRlIHRvIEdpdD8gSSB0aGluayB3ZSBjYW4gZGlyZWN0bHkgdXNlIEdpdEh1YiB0bwpydW4gdGhl
IHJldmlld2luZyBwcm9jZWR1cmUsIHJhdGhlciB0aGFuIHNlbmRpbmcgZW1haWxzIGluIHRoaXMg
b2xkCmZhc2hpb25lZCB3YXksIHNpbmNlIHRoYXQgR2l0IGNvZGUgaGFzIGJlZW4gbWFpbnRhaW5l
ZCBpbiBHaXRIdWIuCkUtbWFpbHMgZG9lcyB3ZWxsIGluIHBsYXlpbmcgdGhlIHJvbGUgYXMgYSBu
b3RpZmljYXRpb24gd2F5LiBUaGV5CmhlbHBzIG5vdGhpbmcgaW4gcmV2aWV3aW5nIGNvZGUsIGVz
cGVjaWFsbHkgd2hlbiB3ZSBuZWVkIHRvIHBvaW50IG91dApwcm9ibGVtcyBvciBzdWdnZXN0aW9u
cyByZWZlcnJlZCB0byBjZXJ0YWluIGNvZGUgc25pcHBldHMuCg==

