Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9CDC0C433F5
	for <git@archiver.kernel.org>; Fri, 19 Nov 2021 02:11:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7757761A89
	for <git@archiver.kernel.org>; Fri, 19 Nov 2021 02:11:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231546AbhKSCOM (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 18 Nov 2021 21:14:12 -0500
Received: from zg8tmtm4lje5ny4xodqumjaa.icoremail.net ([138.197.184.20]:50512
        "HELO zg8tmtm4lje5ny4xodqumjaa.icoremail.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with SMTP id S229830AbhKSCOM (ORCPT
        <rfc822;git@vger.kernel.org>); Thu, 18 Nov 2021 21:14:12 -0500
X-Greylist: delayed 1531 seconds by postgrey-1.27 at vger.kernel.org; Thu, 18 Nov 2021 21:14:11 EST
Received: from mailtech.cn (unknown [10.12.1.20])
        by hzbj-icmmx-1 (Coremail) with SMTP id AQAAfwBnMa56B5dhAB8VCA--.8275S2;
        Fri, 19 Nov 2021 10:10:02 +0800 (CST)
Received: from pwxu$coremail.cn ( [112.94.4.17] ) by
 ajax-webmail-mailtech_rd (Coremail) ; Fri, 19 Nov 2021 10:11:06 +0800 (CST)
X-Originating-IP: [112.94.4.17]
Date:   Fri, 19 Nov 2021 10:11:06 +0800 (CST)
X-CM-HeaderCharset: UTF-8
From:   =?UTF-8?Q?Aleen_=E5=BE=90=E6=B2=9B=E6=96=87?= <pwxu@coremail.cn>
To:     "Junio C Hamano" <gitster@pobox.com>
Cc:     "Aleen via GitGitGadget" <gitgitgadget@gmail.com>,
        git@vger.kernel.org, =?UTF-8?Q?Ren=C3=A9_Scharfe?= <l.s.r@web.de>,
        "Phillip Wood" <phillip.wood123@gmail.com>,
        Aleen <aleen42@vip.qq.com>
Subject: Re: [PATCH v6 3/3] am: throw an error when passing --empty option
 without value
X-Priority: 3
X-Mailer: Coremail Webmail Server Version XT6.0.3 build 20211103(a39c0bb8)
 Copyright (c) 2002-2021 www.mailtech.cn
 mispb-4edfefde-e422-4ddc-8a36-c3f99eb8cd32-icoremail.net
In-Reply-To: <xmqqr1bdrlpq.fsf@gitster.g>
References: <pull.1076.v5.git.1637141636.gitgitgadget@gmail.com>
 <pull.1076.v6.git.1637232636.gitgitgadget@gmail.com>
 <e907a2b2faa1e3c5854504c23cc6e118c2125817.1637232636.git.gitgitgadget@gmail.com>
 <xmqqr1bdrlpq.fsf@gitster.g>
Content-Transfer-Encoding: base64
Content-Type: text/plain; charset=UTF-8
MIME-Version: 1.0
Message-ID: <526ec6c0.87.17d35f63231.Coremail.pwxu@coremail.cn>
X-Coremail-Locale: en_US
X-CM-TRANSID: AgIMCgCHjFW7B5dh+gIAAA--.130W
X-CM-SenderInfo: psz03q5fruvzxdlohubq/1tbiAQcLCFGCdOPDuQAAs7
Authentication-Results: hzbj-icmmx-1; spf=neutral smtp.mail=pwxu@corem
        ail.cn;
X-Coremail-Antispam: 1Uk129KBjvJXoW7Kw4UWr48uFWUtryUCrWruFg_yoW8Cw4rpa
        1ftr97trsYqF4Fv347Cw1Sq34kXwn5X395Xryay34q9an8X3WIqr4Iga1F9ryUurZ3Xw4Y
        qayqkwnYk34UZ3DanT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUj1kv1TuYvTs0mT0YCTnIWj
        DUYxn0WfASr-VFAU7a7-sFnT9fnUUIcSsGvfJ3UbIYCTnIWIevJa73UjIFyTuYvj4RJUUU
        UUUUU
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

PiBIZXJlIGlzIGEgcGxhY2UgZm9yIHlvdSB0byBleHBsYWluIHdoeSB0aGlzIGNoYW5nZSBtaWdo
dCBiZSBhIGdvb2QKPiBpZGVhIHRvIGRlZmVuZCBpdC4gIElmIHdlIGFwcGxpZWQgMS8zIGFuZCAy
LzMgYnV0IG5vdCB0aGlzIG9uZSwgd2hhdAo+IGhhcHBlbnM/ICAiYW0gLS1lbXB0eSIgKG5vdCAi
YW0gLS1lbXB0eT08Y2hvaWNlPiIpIGlzIGFjY2VwdGVkIGFuZAo+IGJlaGF2ZXMganVzdCBsaWtl
ICJhbSAtLWVtcHR5PWRpZSI/ICBJcyB0aGF0IGEgYmFkIHRoaW5nPwo+IAo+IElmIGl0IGlzIHVu
Y29uZGl0b25hbGx5IGEgYmFkIHRoaW5nLCB0aGVuIHRoaXMgcGF0Y2ggZG9lcyBub3Qgc3RhbmQK
PiBvbiBpdHMgb3duLiAgSXQgc2hvdWxkIGJlIHNxdWFzaGVkIGludG8gdGhlIHByZXZpb3VzIHN0
ZXA7IG90aGVyd2lzZQo+IGl0IHdvdWxkIGJlICJvb3BzLCB3ZSBkaWRuJ3QgdGhpbmsgaXQgdGhy
b3VnaCBhbmQgZmFpbGVkIHRvIGRldGVjdAo+IGFuIGFyZ3VtZW50LWxlc3MgLS1lcnJvciBhcyBh
biBlcnJvciBpbiB0aGUgcHJldmlvdXMgc3RlcCwgYW5kIGhlcmUKPiBpcyBhIGZpeCBmb3IgdGhh
dCBtaXN0YWtlIi4gIFdlIHRyeSBub3QgdG8gZGVsaWJlcmF0ZWx5IGNvbW1pdCBhCj4gbWlzdGFr
ZSBhbmQgdGhlbiBmaXggaXQgdG8gZ2FpbiBjb21taXQgY291bnRzIGluIHRoaXMgcHJvamVjdCAo
b3IKPiBwdXR0aW5nIGl0IGRpZmZlcmVudGx5LCB3ZSB0cnkgdG8gcHJldGVuZCB3ZSBhcmUgYmV0
dGVyIHRoYW4gd2UKPiByZWFsbHkgYXJlIGFuZCBkaWQgbm90IG1ha2UgYSBtaXN0YWtlIGluIHRo
ZSBmaXJzdCBwbGFjZSkuCj4gCj4gT3IgYXJlIHlvdSBnaXZpbmcgbGlzdCBwYXJ0aWNpcGFudHMg
YW5kIHJldmlld2VycyBhIGNob2ljZSBiZXR3ZWVuCj4gIictLWVtcHR5JyBpcyBhIHN5bm9ueW0g
dG8gJy0tZW1wdHk9ZGllJyIgYW5kICInLS1lbXB0eScgYWxvbmUgaXMgYW4KPiBlcnJvciIgYmVj
YXVzZSB5b3UgY2Fubm90IGRlY2lkZSB5b3Vyc2VsZj8gIElmIHRoYXQgaXMgdGhlIGNhc2UsIHlv
dQo+IHJlYWxseSByZWFsbHkgbmVlZCB0byBtYWtlIGl0IGNsZWFyIGluIHRoaXMgcGxhY2UgYmV0
d2VlbiAiRnJvbToiCj4gYW5kICJTaWduZWQtb2ZmLWJ5OiIuICBXaHkgd291bGQgd2Ugd2FudCB0
byB1c2UgdGhpcyBwYXRjaD8gIFdoeQo+IHdvdWxkIHdlIGJlIGJldHRlciB3aXRob3V0IHRoaXMg
cGF0Y2g/Cj4gCj4gSSBoYXZlbid0IHRob3VnaHQgdGhpbmdzIHRocm91Z2gsIGJ1dCBteSBndXQg
ZmVlbGluZyBpcyB0aGF0IHRoZQo+IHNlbWFudGljcyBvZiB0aGUgLS1lbXB0eT08Y2hvaWNlPiBv
cHRpb24gaXMgYmV0dGVyIF93aXRoXyB0aGlzLAo+IGluIG90aGVyIHdvcmRzLCBpdCBtYWtlcyBt
b3JlIHNlbnNlIHRvIGZvcmJpZCAiLS1lbXB0eSIgYWxvbmUuICBTbwo+IGlmIEkgd2VyZSBkb2lu
ZyB0aGlzIHNlcmllcywgSSB3b3VsZCBwcm9iYWJseSBoYXZlIHNxdWFzaGVkIHRoaXMKPiBpbnRv
IHRoZSBwcmV2aW91cyBvbmUsIG1ha2luZyBpdCBhIHR3by1wYXRjaCBzZXJpZXMuCj4gCj4gVGhh
bmtzLgoKSGFtYW5vLCBJIGNvdWxkIG5vdCBtYWtlIHRoaXMgZGVjaXNpb24gbGlrZSB3aGF0IHlv
dSBzYWlkIGJldHdlZW4gIictLWVtcHR5JyBpcyBhIHN5bm9ueW0gdG8gJy0tZW1wdHk9ZGllJyIg
YW5kICInLS1lbXB0eScgYWxvbmUgaXMgYW4gZXJyb3IiLiBJbiBteSBvcGluaW9uLCBpdCBpcyBh
IGxpdHRsZSB3aXJlZCB0aGF0ICctLWVtcHR5JyBzaG91bGQgbm90IGFjdCBhcyAiZGllZCIgc2Vt
YW50aWNhbGx5LiBSZXZlcnNlbHksIGl0IG1heSBiZSBiZXR0ZXIgdG8gc3VwcG9ydCBhIHN5bm9u
eW0gYmV0d2VlbiAnLS1xdWlldCcgYW5kICctLWVtcHR5PXNraXAnLgoKSSB3aWxsIHNxdWFzaCB0
aGUgY29tbWl0IGludG8gdGhlIHByZXZpb3VzIG9uZSBsYXRlciBhbmQgaG9wZSBhbGwgcGFydGlj
aXBhbnRzIGFuZCByZXZpZXdlcnMgbWFrZSBhIGRlY2lzaW9uLgo=

