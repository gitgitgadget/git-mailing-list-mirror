Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 71E98C433EF
	for <git@archiver.kernel.org>; Tue, 30 Nov 2021 05:45:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238365AbhK3Fsc (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 30 Nov 2021 00:48:32 -0500
Received: from zg8tmja5ljk3lje4mi4ymjia.icoremail.net ([209.97.182.222]:36211
        "HELO zg8tmja5ljk3lje4mi4ymjia.icoremail.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with SMTP id S232397AbhK3Fsb (ORCPT
        <rfc822;git@vger.kernel.org>); Tue, 30 Nov 2021 00:48:31 -0500
Received: from mailtech.cn (unknown [10.12.1.20])
        by hzbj-icmmx-1 (Coremail) with SMTP id AQAAfwBnMa4guqVhaBI7CQ--.44739S2;
        Tue, 30 Nov 2021 13:44:00 +0800 (CST)
Received: from pwxu$coremail.cn ( [112.94.4.17] ) by
 ajax-webmail-mailtech_rd (Coremail) ; Tue, 30 Nov 2021 13:45:06 +0800 (CST)
X-Originating-IP: [112.94.4.17]
Date:   Tue, 30 Nov 2021 13:45:06 +0800 (CST)
X-CM-HeaderCharset: UTF-8
From:   =?UTF-8?Q?Aleen_=E5=BE=90=E6=B2=9B=E6=96=87?= <pwxu@coremail.cn>
To:     "Elijah Newren" <newren@gmail.com>
Cc:     "Junio C Hamano" <gitster@pobox.com>,
        =?UTF-8?Q?=E5=BE=90=E6=B2=9B=E6=96=87_=28Aleen=29_via_GitGitGadget?= 
        <gitgitgadget@gmail.com>, "Git Mailing List" <git@vger.kernel.org>,
        "Johannes Schindelin" <Johannes.Schindelin@gmx.de>,
        =?UTF-8?Q?=E5=BE=90=E6=B2=9B=E6=96=87_=28Aleen=29?= 
        <aleen42@vip.qq.com>, =?UTF-8?Q?Ren=C3=A9_Scharfe?= <l.s.r@web.de>
Subject: Re: [PATCH v12 3/3] am: support --allow-empty to record specific
 empty patches
X-Priority: 3
X-Mailer: Coremail Webmail Server Version XT6.0.3 build 20211103(a39c0bb8)
 Copyright (c) 2002-2021 www.mailtech.cn
 mispb-4edfefde-e422-4ddc-8a36-c3f99eb8cd32-icoremail.net
In-Reply-To: <CABPp-BEOJs7E4Cn35UkzNAQ+Qp3me-ZPc36+LyaTnqi_RFXNAg@mail.gmail.com>
References: <pull.1076.v10.git.1637567471.gitgitgadget@gmail.com>
 <pull.1076.v11.git.1637681215.gitgitgadget@gmail.com>
 <6051ad9440a966124e9147ec344ee6d87c46944a.1637681215.git.gitgitgadget@gmail.com>
 <CABPp-BF-eYcJ7eS==VK3M2xOqf5z4KNK4dP6qd_UcfLO1NWBeg@mail.gmail.com>
 <36706841.2ec.17d6afdb326.Coremail.pwxu@coremail.cn>
 <7cffa143.3af.17d6b2371c7.Coremail.pwxu@coremail.cn>
 <CABPp-BEOJs7E4Cn35UkzNAQ+Qp3me-ZPc36+LyaTnqi_RFXNAg@mail.gmail.com>
Content-Transfer-Encoding: base64
Content-Type: text/plain; charset=UTF-8
MIME-Version: 1.0
Message-ID: <3a5c138f.208.17d6f601149.Coremail.pwxu@coremail.cn>
X-Coremail-Locale: en_US
X-CM-TRANSID: AgIMCgC37RpiuqVh7QQAAA--.186W
X-CM-SenderInfo: psz03q5fruvzxdlohubq/1tbiAgACCFGCc557bwACsg
Authentication-Results: hzbj-icmmx-1; spf=neutral smtp.mail=pwxu@corem
        ail.cn;
X-Coremail-Antispam: 1Uk129KBjvJXoW7Aw17tFy8XFWxZry8Gw48Zwb_yoW8Aw17pF
        W2gFZ5Krs3XF18Zrnagw1IqFyFvrWUJF98JFn5urW09a98Wrn7tr47K3W3uFWxCF95A3y2
        va1jyr1ftw4DAaDanT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUj1kv1TuYvTs0mT0YCTnIWj
        DUYxn0WfASr-VFAU7a7-sFnT9fnUUIcSsGvfJ3UbIYCTnIWIevJa73UjIFyTuYvj4RJUUU
        UUUUU
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

SSBoYXZlIGludHJvZHVjZWQgYW4gaW50ZXJhY3RpdmUgb3B0aW9uIGAtLWFsbG93LWVtcHR5YCBp
biBhIG5ldyBpbmRlcGVuZGVudCBjb21taXQsCmFuZCBpdCBpcyBub3QgdGhlIHN5bm9ueW0gb2Yg
dGhlIGAtLWVtcHR5YCBvcHRpb24gYmVjYXVzZSBpdCBpcyBvbmx5IGZvciB0aGUgY2FzZSBpbgph
IG1pZGRsZSBhbSBzZXNzaW9uIHdoZXJlIHVzZXJzIGNhbiByZXNvbHZlICJkaWVkIiBwcm9ibGVt
cyBieSBjaG9vc2luZyB3aGV0aGVyIHRvCnJlY29yZCBjdXJyZW50IGVtcHR5IHBhdGNoLiBUaGUg
YC0tZW1wdHlgIG9wdGlvbiBhY3RzIGxpa2UgYSBzdHJhdGVneSBvcHRpb24gdG8gdGVsbApgZ2l0
LWFtYCBob3cgdG8gaGFuZGxlIHdoZW4gbWVldGluZyBhbnkgZW1wdHkgcGF0Y2hlcy4KCj4gT24g
TW9uLCBOb3YgMjksIDIwMjEgYXQgMjowMCBBTSBBbGVlbiDlvpDmspvmlocgPHB3eHVAY29yZW1h
aWwuY24+IHdyb3RlOgo+ID4KPiA+IEl0IGlzIHF1aXRlIGNvbXBsaWNhdGVkIHRvIHN1cHBvcnQg
J2dpdCBjb21taXQgLS1hbGxvdy1lbXB0eScgZXh0cmFjdGluZyBtZXNzYWdlcwo+ID4gZnJvbSBh
biBlbXB0eSBwYXRjaCwgYmVjYXVzZSAnZ2l0IGFtJyBoYXMgdG8gZmluZCBzb21ld2hlcmUgdG8g
c3RvcmUgdGhlIHBhcnNlZCBzdGF0ZQo+ID4gZm9yICdnaXQgY29tbWl0JyB0byByZWFkLgo+IAo+
IC5naXQvQ09NTUlUX0VESVRNU0cgaXMgc3VjaCBhIHBsYWNlIHRoYXQgYWxyZWFkeSBleGlzdHMs
IGFzc3VtaW5nIHlvdQo+IGFyZSBqdXN0IGV4dHJhY3RpbmcgYSBjb21taXQgbWVzc2FnZS4KPiAK
PiA+IEhvdyBhYm91dCBkaXJlY3RseSBzdXBwb3J0aW5nIGFub3RoZXIgaW50ZXJhY3RpdmUgb3B0
aW9uCj4gPiAnLS1hbGxvdy1lbXB0eScgZm9yICdnaXQgYW0nIHRvIGtlZXAgcmVjb3JkaW5nPwo+
IAo+IC0tZW1wdHk9a2VlcCB3YXMgYWxyZWFkeSBwYXJ0IG9mIHlvdXIgcGF0Y2ggc2VyaWVzOyBJ
IGRvbid0IHNlZSB3aHkKPiB5b3UnZCBuZWVkIHRvIGFkZCBhIHN5bm9ueW0gKC0tYWxsb3ctZW1w
dHkpIGZvciBpdC4KPiAKPiBJIHRoaW5rIHlvdSB3ZXJlIHRyeWluZyB0byBhc2sgaWYgeW91IGNv
dWxkIGp1c3QgbGVhdmUgb3V0IHRoZQo+IGltcGxlbWVudGF0aW9uIG9mIC0tZW1wdHk9YXNrIChv
ciAtLWVtcHR5PWRpZSkgZnJvbSB5b3VyIHBhdGNoZXMuCj4gVGhhdCdzIHVzdWFsbHkgZmluZSwg
YnV0IHRoZXJlIGlzIGEgc21hbGwgd3JpbmtsZSBoZXJlIHNpbmNlIGl0IHdhcwo+IHlvdXIgY2hv
c2VuIGRlZmF1bHQuICBZb3UnbGwgaGF2ZSB0byBwaWNrIGEgZGlmZmVyZW50IGRlZmF1bHQsIGFu
ZAo+IHBvc3NpYmx5IGFsZXJ0IHVzZXJzIGluIHRoZSBkb2N1bWVudGF0aW9uIHRoYXQgdGhlIGRl
ZmF1bHQgbWF5IGNoYW5nZQo+IGluIHRoZSBmdXR1cmUgaWYvd2hlbiB0aGUgb3RoZXIgb3B0aW9u
IGlzIGltcGxlbWVudGVkLgo+IAo+ID4gPiBEZWFycyBIYW1hbm8sCj4gPiA+Cj4gPiA+ICAgIEVs
aWphaCBOZXdyZW4gaGFzIGdpdmVuIHR3byBiZXR0ZXIgc3VnZ2VzdGlvbnM6Cj4gPiA+Cj4gPiA+
ICAgICAgICAxLiBVc2UgJ2FzaycgcmF0aGVyIHRoYW4gJ2RpZScKPiA+ID4gICAgICAgIDIuIFdo
ZW4gZXJyb3Jpbmcgb3V0ICdQYXRjaCBpcyBlbXB0eScsIHByaW50IG91dCBhIHR1dG9yaWFsIGlu
Zm9ybWF0aW9uCj4gPiA+ICAgICAgICAgICB0byBoZWxwIHVzZXJzIHVzaW5nICdnaXQgY29tbWl0
IC0tYWxsb3ctZW1wdHknIHRvIGtlZXAgcmVjb3JkaW5nIGFzCj4gPiA+ICAgICAgICAgICBhbiBl
bXB0eSBjb21taXQuCj4gPiA+Cj4gPiA+ICAgIFNob3VsZCB3ZSBjb250aW51ZSB0byBpbXBsZW1l
bnQgdGhlc2UgZmVhdHVyZXMgaW4gY3VycmVudCBQUj8KPiA+ID4KPiA+ID4gQWxlZW4=

