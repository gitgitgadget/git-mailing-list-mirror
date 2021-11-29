Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 17051C433EF
	for <git@archiver.kernel.org>; Mon, 29 Nov 2021 10:02:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349868AbhK2KFs (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 29 Nov 2021 05:05:48 -0500
Received: from zg8tmtyylji0my4xnjeumjiw.icoremail.net ([162.243.161.220]:47472
        "HELO zg8tmtyylji0my4xnjeumjiw.icoremail.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with SMTP id S1350179AbhK2KDq (ORCPT
        <rfc822;git@vger.kernel.org>); Mon, 29 Nov 2021 05:03:46 -0500
Received: from mailtech.cn (unknown [10.12.1.20])
        by hzbj-icmmx-2 (Coremail) with SMTP id AQAAfwBXgdHWpKRhNQBFBg--.22545S2;
        Mon, 29 Nov 2021 18:00:54 +0800 (CST)
Received: from pwxu$coremail.cn ( [112.94.4.17] ) by
 ajax-webmail-mailtech_rd (Coremail) ; Mon, 29 Nov 2021 18:00:24 +0800 (CST)
X-Originating-IP: [112.94.4.17]
Date:   Mon, 29 Nov 2021 18:00:24 +0800 (CST)
X-CM-HeaderCharset: UTF-8
From:   =?UTF-8?Q?Aleen_=E5=BE=90=E6=B2=9B=E6=96=87?= <pwxu@coremail.cn>
To:     "Junio C Hamano" <gitster@pobox.com>
Cc:     =?UTF-8?Q?=E5=BE=90=E6=B2=9B=E6=96=87_=28Aleen=29_via_GitGitGadget?= 
        <gitgitgadget@gmail.com>, "Git Mailing List" <git@vger.kernel.org>,
        "Johannes Schindelin" <Johannes.Schindelin@gmx.de>,
        =?UTF-8?Q?=E5=BE=90=E6=B2=9B=E6=96=87_=28Aleen=29?= 
        <aleen42@vip.qq.com>, =?UTF-8?Q?Ren=C3=A9_Scharfe?= <l.s.r@web.de>,
        "Elijah Newren" <newren@gmail.com>
Subject: Re: Re: [PATCH v11 2/2] am: support --empty=<option> to handle
 empty patches
X-Priority: 3
X-Mailer: Coremail Webmail Server Version XT6.0.3 build 20211103(a39c0bb8)
 Copyright (c) 2002-2021 www.mailtech.cn
 mispb-4edfefde-e422-4ddc-8a36-c3f99eb8cd32-icoremail.net
In-Reply-To: <36706841.2ec.17d6afdb326.Coremail.pwxu@coremail.cn>
References: <pull.1076.v10.git.1637567471.gitgitgadget@gmail.com>
 <pull.1076.v11.git.1637681215.gitgitgadget@gmail.com>
 <6051ad9440a966124e9147ec344ee6d87c46944a.1637681215.git.gitgitgadget@gmail.com>
 <CABPp-BF-eYcJ7eS==VK3M2xOqf5z4KNK4dP6qd_UcfLO1NWBeg@mail.gmail.com>
 <36706841.2ec.17d6afdb326.Coremail.pwxu@coremail.cn>
Content-Transfer-Encoding: base64
Content-Type: text/plain; charset=UTF-8
MIME-Version: 1.0
Message-ID: <7cffa143.3af.17d6b2371c7.Coremail.pwxu@coremail.cn>
X-Coremail-Locale: en_US
X-CM-TRANSID: AgIMCgAXpES4pKRh1AcAAA--.391W
X-CM-SenderInfo: psz03q5fruvzxdlohubq/1tbiAQcBCFGCdORJswAAs2
Authentication-Results: hzbj-icmmx-2; spf=neutral smtp.mail=pwxu@corem
        ail.cn;
X-Coremail-Antispam: 1Uk129KBjvdXoWrAF13tFWrZr47CrW3Xw17GFg_yoWxWrc_CF
        n5W348K3y5Ar13JaySyF1rZFy3X3y5u34DJ3y3Wrn3CryktFs3CF4kArZ8GF1xZrZI9w1Y
        9rsrJFWqk3W2vjkaLaAFLSUrUUUUUb8apTn2vfkv8UJUUUU8wcxFpf9Il3svdxBIdaVrnU
        Uv73VFW2AGmfu7jjvjm3AaLaJ3UjIYCTnIWjDUYxBIdaVFxhVjvjDU0xZFpf9x0zRUUUUU
        UUUU=
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

SXQgaXMgcXVpdGUgY29tcGxpY2F0ZWQgdG8gc3VwcG9ydCAnZ2l0IGNvbW1pdCAtLWFsbG93LWVt
cHR5JyBleHRyYWN0aW5nIG1lc3NhZ2VzCmZyb20gYW4gZW1wdHkgcGF0Y2gsIGJlY2F1c2UgJ2dp
dCBhbScgaGFzIHRvIGZpbmQgc29tZXdoZXJlIHRvIHN0b3JlIHRoZSBwYXJzZWQgc3RhdGUKZm9y
ICdnaXQgY29tbWl0JyB0byByZWFkLiBIb3cgYWJvdXQgZGlyZWN0bHkgc3VwcG9ydGluZyBhbm90
aGVyIGludGVyYWN0aXZlIG9wdGlvbgonLS1hbGxvdy1lbXB0eScgZm9yICdnaXQgYW0nIHRvIGtl
ZXAgcmVjb3JkaW5nPwoKPiBEZWFycyBIYW1hbm8sCj4gCj4gICAgRWxpamFoIE5ld3JlbiBoYXMg
Z2l2ZW4gdHdvIGJldHRlciBzdWdnZXN0aW9uczoKPiAKPiAgICAgICAgMS4gVXNlICdhc2snIHJh
dGhlciB0aGFuICdkaWUnCj4gICAgICAgIDIuIFdoZW4gZXJyb3Jpbmcgb3V0ICdQYXRjaCBpcyBl
bXB0eScsIHByaW50IG91dCBhIHR1dG9yaWFsIGluZm9ybWF0aW9uCj4gICAgICAgICAgIHRvIGhl
bHAgdXNlcnMgdXNpbmcgJ2dpdCBjb21taXQgLS1hbGxvdy1lbXB0eScgdG8ga2VlcCByZWNvcmRp
bmcgYXMgCj4gICAgICAgICAgIGFuIGVtcHR5IGNvbW1pdC4KPiAKPiAgICBTaG91bGQgd2UgY29u
dGludWUgdG8gaW1wbGVtZW50IHRoZXNlIGZlYXR1cmVzIGluIGN1cnJlbnQgUFI/Cj4gCj4gQWxl
ZW4K

