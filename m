Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8785DC433F5
	for <git@archiver.kernel.org>; Fri, 12 Nov 2021 07:17:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5500360F46
	for <git@archiver.kernel.org>; Fri, 12 Nov 2021 07:17:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232346AbhKLHUC (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 12 Nov 2021 02:20:02 -0500
Received: from azure-sdnproxy.icoremail.net ([52.229.168.213]:37633 "HELO
        azure-sdnproxy-2.icoremail.net" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with SMTP id S230464AbhKLHUB (ORCPT
        <rfc822;git@vger.kernel.org>); Fri, 12 Nov 2021 02:20:01 -0500
X-Greylist: delayed 384 seconds by postgrey-1.27 at vger.kernel.org; Fri, 12 Nov 2021 02:20:00 EST
Received: from mailtech.cn (unknown [10.12.1.20])
        by hzbj-icmmx-2 (Coremail) with SMTP id AQAAfwAXQNB3E45hMcdwBQ--.59330S2;
        Fri, 12 Nov 2021 15:10:47 +0800 (CST)
Received: from pwxu$coremail.cn ( [112.94.4.17] ) by
 ajax-webmail-mailtech_rd (Coremail) ; Fri, 12 Nov 2021 15:10:17 +0800 (CST)
X-Originating-IP: [112.94.4.17]
Date:   Fri, 12 Nov 2021 15:10:17 +0800 (CST)
X-CM-HeaderCharset: UTF-8
From:   =?UTF-8?Q?Aleen_=E5=BE=90=E6=B2=9B=E6=96=87?= <pwxu@coremail.cn>
To:     "Junio C Hamano" <gitster@pobox.com>
Cc:     =?UTF-8?Q?Ren=C3=A9_Scharfe?= <l.s.r@web.de>,
        "Aleen via GitGitGadget" <gitgitgadget@gmail.com>,
        git@vger.kernel.org, Aleen <aleen42@vip.qq.com>
Subject: Re: [PATCH 0/2] am: support --always option to am empty commits
X-Priority: 3
X-Mailer: Coremail Webmail Server Version XT6.0.3 build 20211103(a39c0bb8)
 Copyright (c) 2002-2021 www.mailtech.cn
 mispb-4edfefde-e422-4ddc-8a36-c3f99eb8cd32-icoremail.net
In-Reply-To: <xmqqy25tj2fi.fsf@gitster.g>
References: <pull.1076.git.1636693095.gitgitgadget@gmail.com>
 <6da5e984-1dcf-4c55-976c-49ffb8d128bf@web.de> <xmqqy25tj2fi.fsf@gitster.g>
Content-Transfer-Encoding: base64
Content-Type: text/plain; charset=UTF-8
MIME-Version: 1.0
Message-ID: <40a6024f.23b9.17d12fb977f.Coremail.pwxu@coremail.cn>
X-Coremail-Locale: en_US
X-CM-TRANSID: AgIMCgDHEMBaE45hB_YBAA--.12173W
X-CM-SenderInfo: psz03q5fruvzxdlohubq/1tbiAQcECFGCdONtrAAFsK
Authentication-Results: hzbj-icmmx-2; spf=neutral smtp.mail=pwxu@corem
        ail.cn;
X-Coremail-Antispam: 1Uk129KBjvdXoWrKw18GF4ktFy5XF45Cw15Arb_yoWfCFX_Zr
        WfAF4xWw1UGry5JF1DJF4DZrWaqa1jvr15XrWkZwsxAws3Aan8GFs5G3yIvw13AFZ2qFn3
        u3sxua1Iy3429jkaLaAFLSUrUUUUUb8apTn2vfkv8UJUUUU8wcxFpf9Il3svdxBIdaVrnU
        Uv73VFW2AGmfu7jjvjm3AaLaJ3UjIYCTnIWjDUYxBIdaVFxhVjvjDU0xZFpf9x0zRUUUUU
        UUUU=
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

RGVhcnMgSnVuaW8gQyBIYW1hbm86Cgo+IFJlbsOpIFNjaGFyZmUgPGwucy5yQHdlYi5kZT4gd3Jp
dGVzOgo+IAo+ID4gQW0gMTIuMTEuMjEgdW0gMDU6NTggc2NocmllYiBBbGVlbiB2aWEgR2l0R2l0
R2FkZ2V0Ogo+ID4+IFNpbmNlIHRoYXQgZ2l0IGhhcyBzdXBwb3J0ZWQgdGhlIC0tYWx3YXlzIG9w
dGlvbiBmb3IgdGhlIGdpdC1mb3JtYXQtcGF0Y2gKPiA+PiBjb21tYW5kIHRvIGNyZWF0ZSBhIHBh
dGNoIHdpdGggZW1wdHkgY29tbWl0IG1lc3NhZ2UsIGdpdC1hbSBzaG91bGQgc3VwcG9ydAo+ID4+
IGFwcGx5aW5nIGFuZCBjb21taXR0aW5nIHdpdGggZW1wdHkgcGF0Y2hlcy4KPiA+Cj4gPiBUaGUg
c3ltbWV0cnkgaXMgY29tcGVsbGluZywgYnV0ICJhbHdheXMiIGlzIHF1aXRlIGdlbmVyaWMuICBJ
IGNhbiBzZWUKPiA+IGUuZy4gc29tZW9uZSBleHBlY3RpbmcgImdpdCBhbSAtLWFsd2F5cyIgdG8g
aW1wbHkgLS1rZWVwLW5vbi1wYXRjaC4KPiAKPiBXaGF0IHN5bW1ldHJ5Pwo+IAo+ID4gZ2l0IGNv
bW1pdCBhbmQgY2hlcnJ5LXBpY2sgaGF2ZSAtLWFsbG93LWVtcHR5LCB3aGljaCBpcyAoYSBiaXQp
IG1vcmUKPiA+IHNwZWNpZmljLiAgVGhhdCBzZWVtcyB0byBtZSBhIGJldHRlciBvcHRpb24gbmFt
ZSB0byBjb3B5IGZvciBhIGNvbW1pdC0KPiA+IGNyZWF0aW5nIGNvbW1hbmQgbGlrZSBnaXQgYW0u
Cj4gCj4gVGhhdCBvbmUgSSBjYW4gYmVsaWV2ZSwgZXZlbiB0aG91Z2ggSSBkbyBub3QgbmVjZXNz
YXJpbHkgdGhpbmsgaXQgaXMKPiBhIGdvb2QgaWRlYSB0byBhZGQgc3VjaCBhbiBvcHRpb24uCgpJ
biBzb21lIGNhc2VzIHdoZW4gd2UgbmVlZCB0byBtaWdyYXRlIGNvbW1pdHMgZnJvbSBvbmUgYnJh
bmNoIHRvIGFub3RoZXIgYnJhbmNoLApmcm9tIG9uZSByZXBvIHRvIGFub3RoZXIgcmVwbywgaXQg
c2hvdWxkIGJlIG5lY2Vzc2FyeS4KCkFsZWVu

