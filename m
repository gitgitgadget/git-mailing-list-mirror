Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C5D12C433EF
	for <git@archiver.kernel.org>; Tue,  7 Dec 2021 01:06:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1352296AbhLGBKL (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 6 Dec 2021 20:10:11 -0500
Received: from azure-sdnproxy.icoremail.net ([207.46.229.174]:55237 "HELO
        azure-sdnproxy-1.icoremail.net" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with SMTP id S243594AbhLGBKK (ORCPT
        <rfc822;git@vger.kernel.org>); Mon, 6 Dec 2021 20:10:10 -0500
Received: from mailtech.cn (unknown [10.12.1.20])
        by hzbj-icmmx-1 (Coremail) with SMTP id AQAAfwA3CLVXs65h69TBCQ--.8438S2;
        Tue, 07 Dec 2021 09:05:27 +0800 (CST)
Received: from pwxu$coremail.cn ( [112.94.4.17] ) by
 ajax-webmail-mailtech_rd (Coremail) ; Tue, 7 Dec 2021 09:06:33 +0800 (CST)
X-Originating-IP: [112.94.4.17]
Date:   Tue, 7 Dec 2021 09:06:33 +0800 (CST)
X-CM-HeaderCharset: UTF-8
From:   =?UTF-8?Q?Aleen_=E5=BE=90=E6=B2=9B=E6=96=87?= <pwxu@coremail.cn>
To:     "Junio C Hamano" <gitster@pobox.com>
Cc:     "Elijah Newren" <newren@gmail.com>,
        "Git Mailing List" <git@vger.kernel.org>,
        =?UTF-8?Q?=E5=BE=90=E6=B2=9B=E6=96=87_=28Aleen=29?= 
        <aleen42@vip.qq.com>,
        "Aleen via GitGitGadget" <gitgitgadget@gmail.com>,
        "Johannes Schindelin" <johannes.schindelin@gmx.de>,
        =?UTF-8?Q?=C3=86var_Arnfj=C3=B6r=C3=B0_Bjarmason?= 
        <avarab@gmail.com>
Subject: Re: What's cooking in git.git (Nov 2021, #07; Mon, 29)
X-Priority: 3
X-Mailer: Coremail Webmail Server Version XT6.0.3 build 20211103(a39c0bb8)
 Copyright (c) 2002-2021 www.mailtech.cn
 mispb-4edfefde-e422-4ddc-8a36-c3f99eb8cd32-icoremail.net
In-Reply-To: <xmqqwnkhhck4.fsf@gitster.g>
References: <xmqqzgpm2xrd.fsf@gitster.g>
 <CABPp-BE4uYBFnb-AgVJhNo6iK4da5hiEFEBhd=7Ea3Ov=4K4zw@mail.gmail.com>
 <d95f092.3f.17d73a85761.Coremail.pwxu@coremail.cn>
 <CABPp-BG9jHaJYekDnvZT+8QW_fLGM_bmz-oOqzJswaotyVDFBA@mail.gmail.com>
 <211203.861r2tsfej.gmgdl@evledraar.gmail.com>
 <CABPp-BGE5Ff=adH3nREMDm38DGLEmtRTcPwuJowHw-ckwpbmqQ@mail.gmail.com>
 <211203.86wnklqx05.gmgdl@evledraar.gmail.com>
 <30b4169a.18.17d8d589b6d.Coremail.pwxu@coremail.cn>
 <xmqqilw2i6w1.fsf@gitster.g>
 <6fa17536.18b.17d8e7c7a09.Coremail.pwxu@coremail.cn>
 <xmqqwnkhhck4.fsf@gitster.g>
Content-Transfer-Encoding: base64
Content-Type: text/plain; charset=UTF-8
MIME-Version: 1.0
Message-ID: <584bbe43.e.17d926d909f.Coremail.pwxu@coremail.cn>
X-Coremail-Locale: en_US
X-CM-TRANSID: AgIMCgCXn2OZs65h1AEAAA--.32W
X-CM-SenderInfo: psz03q5fruvzxdlohubq/1tbiAQcICFGCdOSxGAAEso
Authentication-Results: hzbj-icmmx-1; spf=neutral smtp.mail=pwxu@corem
        ail.cn;
X-Coremail-Antispam: 1Uk129KBjvJXoW7tw4furykurWxtry5Xr4xZwb_yoW8uw48p3
        ySgF4SkrnrJFZ7Xw1fZw1Iga4rZr4kGFZ8JFyjkrykZr45Wr1xKFWIgw1F93Zruws5Wa1j
        vayYgw1fJ3W2937anT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUj1kv1TuYvTs0mT0YCTnIWj
        DUYxn0WfASr-VFAU7a7-sFnT9fnUUIcSsGvfJ3UbIYCTnIWIevJa73UjIFyTuYvj4RJUUU
        UUUUU
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

RGVhcnMgSGFtYW5vLAoKICAgIEkgaGF2ZSBkb3VidGVkIHRoYXQgc2luY2UgdGhhdCB0aGUgZGVm
YXVsdCBiZWhhdmlvdXIgaXMgdGhhdCBzdG9wcGluZwogICAgd2hlbiBtZWV0aW5nIGNvbW1pdCBt
ZXNzYWdlcyBsYWNraW5nIGEgcGF0Y2ggYW5kIGdpdmluZyBjb250cm9sIGJhY2sKICAgIHRvIHRo
ZSB1c2VyLCBpcyB0aGF0IG5lY2Vzc2FyeSB0byBwcm92aWRlIGR1cGxpY2F0ZWQgJy0tZW1wdHk9
ZGllJz8KICAgIFNob3VsZCB3ZSBqdXN0IHByb3ZpZGUgJy0tZW1wdHk9KGRyb3B8a2VlcCknPwoK
QWxlZW4KCj4gU29ycnksIGJ1dCBJIGFtIGFmcmFpZCB0aGF0IEkgc3RpbGwgZG9uJ3QgZ2V0IGl0
LiAgCj4gCj4gQXMgd2UgY2FuIHNlZSwgdGhlIEVSUl9FTVBUWV9DT01NSVQgY2FzZSBhbHJlYWR5
IGV4aXN0cyBhbmQgdGhhdCBpcwo+IHRoZSBiZWhhdmlvdXIgd2Ugd2FudCB3aGVuIHdlIHNheSAi
Y3JlYXRlIGNvbW1pdHMgZnJvbSB0aGUgbWVzc2FnZXMKPiB3aXRoIHBhdGNoZXMsIHN0b3AgYW5k
IGdpdmUgbWUgY29udHJvbCBiYWNrIHdoZW4geW91IHNlZSBhbiBlbXB0eQo+IGNvbW1pdCwgc28g
dGhhdCBJIGNhbiBkZWNpZGUgd2hhdCB0byBkbyIuICBBbmQgb25lIG9mIHRoZSB0aGluZ3MgeW91
Cj4gY2FuIGRvIGF0IHRoYXQgcG9pbnQgaXMgImFtIC0tYWJvcnQiIHRoYXQgY2F1c2VzIHRoZSBh
bV9kZXN0cm95KCkgdG8KPiBiZSBjYWxsZWQuCj4gCj4gVGhhdCBpcyB2ZXJ5IG11Y2ggaW4gbGlu
ZSB3aXRoIHRoZSBiZWhhdmlvdXIgdGhlIHVzZXJzIGFyZSB1c2VkIHRvCj4gc2VlIGZyb20gImdp
dCBhbSIgd2hlbiBpdCBkZXRlY3RzIGNvbmRpdGlvbnMgb3RoZXIgdGhhbiAidGhlcmUgaXMgbm8K
PiBwYXRjaCIgdGhhdCBuZWVkcyB0byBzdG9wIGFuZCBnaXZlIGNvbnRyb2wgYmFjayB0byB0aGUg
dXNlciwKPiBlLmcuIHdoZW4gdGhlIHBhdGNoIGRvZXMgbm90IGFwcGx5IGNsZWFubHkgb3IgdGhl
IGxvZyBtZXNzYWdlIGRpZAo+IG5vdCBwYXNzIG1zZyBob29rLiAgYW1fZGVzdHJveSgpIGlzIGRl
c3RydWN0aXZlLCBhbmQgbGltaXRpbmcgc3VjaCBhCj4gZGVzdHJ1Y3RpdmUgb3BlcmF0aW9uIHRv
ICJhbSAtLWFib3J0IiB3b3VsZCBhdm9pZCBtaXN0YWtlcyBhbmQKPiBzdXJwcmlzZXMuICBJIGRv
IG5vdCBrbm93IHdoZXJlIHlvdSBnb3QgIkluIGNvbW1vbiBjYXNlcywgZGllIHNob3VsZAo+IHN0
b3AgdGhlIHdob2xlIiBmcm9tLCBidXQgaXQgaXMgbm90IGEgZnJpZW5kbHkgdGhpbmcgdG8gZG8g
dG8gb3VyCj4gdXNlcnMuCj4gCj4gV2h5IHNob3VsZCB0aGUgImluIGFkZGl0aW9uLCBzdG9wIHdo
ZW4gdGhlcmUgaXMgbm8gcGF0Y2giLCB3aGljaCBpcwo+IHdoYXQgd2UgYWxyZWFkeSBoYW5kbGUg
anVzdCBmaW5lLCBuZWVkcyB0byBiZWNvbWUgZGlmZmVyZW50PyAgTW9yZQo+IGltcG9ydGFudGx5
LCBpcyBpdCB3b3J0aCBmb3JjaW5nIHRoZSB1c2VycyB0byBiZSBhd2FyZSBvZiB0aGUKPiBkaWZm
ZXJlbmNlIGFuZCBiZSBleHRyYSBjYXJlZnVsIHRvIGF2b2lkIGl0Pwo+IAo+IEl0IGlzIG15IHVu
ZGVyc3RhbmRpbmcgdGhhdCB0aGUgT05MWSByZWFzb24gdGhlIHBhdGNoIHByb3Bvc2VzIHRvCj4g
YWRkIGFuIG9wdGlvbiBvdGhlciB0aGFuICJza2lwIHRoZSBzdGVwIiBhbmQgImNyZWF0ZSBhbiBl
bXB0eQo+IGNvbW1pdCIgaXMgdG8gYWxsb3cgYW4gZWFybGllciAiLS1lbXB0eT1za2lwIiBvbiB0
aGUgY29tbWFuZCBsaW5lIHRvCj4gYmUgb3ZlcnJpZGRlbiBieSBhIGxhdGVyICItLWVtcHR5PWRp
ZSIuICBJZiB0aGF0IG9wdGlvbiBkb2VzIG5vdAo+IG1ha2UgdGhlIGNvbW1hbmQgYmVoYXZlIGlk
ZW50aWNhbGx5IHRvICItLWVtcHR5PTxhbnl0aGluZz4iIG9wdGlvbgo+IG9uIHRoZSBjb21tYW5k
IGxpbmUsIGkuZS4gRVJSX0VNUFRZX0NPTU1JVCBjYXNlLCBpdCBkb2VzIG5vdCBzZXJ2ZQo+IHRo
ZSBpbnRlbmRlZCBwdXJwb3NlIG9mIG92ZXJyaWRpbmcgdGhlIGVhcmxpZXIgb3B0aW9uIHRvIHJl
dmVydCB0aGUKPiBiZWhhdmlvdXIgYmFjayB0byB0aGUgZGVmYXVsdC4KPiAKPiBCeSB0aGUgd2F5
LCBJIGFncmVlIHdpdGggYW4gZWFybGllciBjb21tZW50IChJIHRoaW5rIGl0IHdhcyBmcm9tIERz
Y2hvKQo+IHRoYXQgdGhlc2UgbmFtZXMgc2hvdWxkIHNheSAiJHtET19USElTfV9PTl9FTVBUWV9D
T01NSVQiOyB0aGUgYWJvdmUKPiB3aXRob3V0ICJPTiIgZmVlbHMgc29tZXdoYXQgc3RyYW5nZS4K
PiAKPiBUaGFua3MuCg==

