Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 53568C433F5
	for <git@archiver.kernel.org>; Fri, 19 Nov 2021 07:23:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 259A361AFB
	for <git@archiver.kernel.org>; Fri, 19 Nov 2021 07:23:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231358AbhKSH02 (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 19 Nov 2021 02:26:28 -0500
Received: from zg8tmtyylji0my4xnjqunzqa.icoremail.net ([162.243.164.74]:53704
        "HELO zg8tmtyylji0my4xnjqunzqa.icoremail.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with SMTP id S230296AbhKSH01 (ORCPT
        <rfc822;git@vger.kernel.org>); Fri, 19 Nov 2021 02:26:27 -0500
X-Greylist: delayed 11172 seconds by postgrey-1.27 at vger.kernel.org; Fri, 19 Nov 2021 02:26:27 EST
Received: from mailtech.cn (unknown [10.12.1.20])
        by hzbj-icmmx-2 (Coremail) with SMTP id AQAAfwAnTs4FUZdhNBvXBQ--.10296S2;
        Fri, 19 Nov 2021 15:23:49 +0800 (CST)
Received: from pwxu$coremail.cn ( [112.94.4.17] ) by
 ajax-webmail-mailtech_rd (Coremail) ; Fri, 19 Nov 2021 15:23:18 +0800 (CST)
X-Originating-IP: [112.94.4.17]
Date:   Fri, 19 Nov 2021 15:23:18 +0800 (CST)
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
In-Reply-To: <xmqqmtm0snol.fsf@gitster.g>
References: <pull.1076.v5.git.1637141636.gitgitgadget@gmail.com>
 <pull.1076.v6.git.1637232636.gitgitgadget@gmail.com>
 <xmqqilwpuiv4.fsf@gitster.g>
 <b9c1244.36.17d35decb26.Coremail.pwxu@coremail.cn>
 <xmqqmtm0snol.fsf@gitster.g>
Content-Transfer-Encoding: base64
Content-Type: text/plain; charset=UTF-8
MIME-Version: 1.0
Message-ID: <2ebb863f.246.17d37140518.Coremail.pwxu@coremail.cn>
X-Coremail-Locale: en_US
X-CM-TRANSID: AgIMCgDn7FXmUJdhaQYAAA--.275W
X-CM-SenderInfo: psz03q5fruvzxdlohubq/1tbiAQcLCFGCdOPHDwAIsB
Authentication-Results: hzbj-icmmx-2; spf=neutral smtp.mail=pwxu@corem
        ail.cn;
X-Coremail-Antispam: 1Uk129KBjvdXoWruw1UJF17urWxZrW8ArW8Zwb_yoW3CrX_uF
        Z0qF1DJa1j9a9xtF48Jr4a9r1xGr9rJryrXayUXFnxG34kAFW7GFWDJF9av3Zxt395tr90
        vF4ku3yfZrsYvjkaLaAFLSUrUUUUUb8apTn2vfkv8UJUUUU8wcxFpf9Il3svdxBIdaVrnU
        Uv73VFW2AGmfu7jjvjm3AaLaJ3UjIYCTnIWjDUYxBIdaVFxhVjvjDU0xZFpf9x0zRUUUUU
        UUUU=
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

PiBZZXMuCj4gCj4gQXMgdGhlIFVSTCB5b3Ugd2VyZSByZWZlcnJlZCB0byBleHBsYWlucywgdGhl
IHNpZ24tb2ZmIHByb2NlZHVyZSBpcwo+IHRvIGtlZXAgdHJhY2sgb2YgcHJvdmVuYW5jZSBvZiB0
aGUgY29kZSwgd2hpY2ggaXMgYSBtb3JlICJsZWdhbCIKPiBmb3JtYWwgcmVxdWlyZW1lbnQgdGhh
biBqdXN0ICJJIHVzZSB0aGlzIHBzZXVkb255bSBldmVyeXdoZXJlIi4KPiBXaGVuIGEgYmlnIGNv
bXBhbnkgY29tZXMgdG8gdXMsIGNsYWltaW5nIHRoYXQgInRoaXMgY29kZSBpcyBvdXIKPiBpbnRl
bGxlY3R1YWwgcHJvcGVydHkgc3RvbGVuIGZyb20gdXMiIGFuZCBwb2ludGluZyBhdCBjb2RlIGFk
ZGVkIGJ5Cj4gYSBwYXRjaCBmcm9tIHlvdSwgd2UgZG8gbm90IHdhbnQgdG8gc2VlIHVzIGluIHRo
ZSBwb3NpdGlvbiB0byBoYXZlCj4gdG8gc2F5ICJlaCwgc29tZWJvZHkgd2hvIHVzZXMgcHN1ZWRv
bnltIFggc2lnbmVkIERDTywgYnV0IHdlIGRvIG5vdAo+IGV2ZW4ga25vdyB0aGVpciByZWFsIG5h
bWUiLgoKSSBrbm93IGl0LCBhbmQgYXMgSSBzYWlkIGJlZm9yZSB0aGF0IGdpdGdpdGdhZGdldCBu
ZWVkIFBSIGNyZWF0b3JzIHRvCnNpZ24gb2ZmIHVzZXIgbmFtZSBvZiBHaXRIdWIgYWNjb3VudCwg
YWNjb3JkaW5nIHRvIHRoZSBEQ08gY2hlY2suIEkgY2FuCmNvbmZpcm1lZCB0aGF0ICJBbGVlbiIg
YW5kICJBbGVlbiDlvpDmspvmlociIGFyZSBib3RoIHRoZSByZWFsIG5hbWUgb2YgbWluZSwKdGhl
IGNvbW1pdHRlci4gSSBjYW4gdXNlIHRoZSBhY2NvdW50IGFsZWVuNDJAdmlwLnFxLmNvbSB0byBj
b25maXJtIHRoaXMuCg==

