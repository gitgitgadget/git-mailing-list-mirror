Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CC959C433EF
	for <git@archiver.kernel.org>; Mon, 29 Nov 2021 09:21:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244737AbhK2JYw (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 29 Nov 2021 04:24:52 -0500
Received: from azure-sdnproxy.icoremail.net ([52.229.168.213]:59773 "HELO
        azure-sdnproxy-2.icoremail.net" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with SMTP id S233086AbhK2JWt (ORCPT
        <rfc822;git@vger.kernel.org>); Mon, 29 Nov 2021 04:22:49 -0500
Received: from mailtech.cn (unknown [10.12.1.20])
        by hzbj-icmmx-1 (Coremail) with SMTP id AQAAfwC3f6zNmqRh2PwuCQ--.56607S2;
        Mon, 29 Nov 2021 17:18:05 +0800 (CST)
Received: from pwxu$coremail.cn ( [112.94.4.17] ) by
 ajax-webmail-mailtech_rd (Coremail) ; Mon, 29 Nov 2021 17:19:11 +0800 (CST)
X-Originating-IP: [112.94.4.17]
Date:   Mon, 29 Nov 2021 17:19:11 +0800 (CST)
X-CM-HeaderCharset: UTF-8
From:   =?UTF-8?Q?Aleen_=E5=BE=90=E6=B2=9B=E6=96=87?= <pwxu@coremail.cn>
To:     "Junio C Hamano" <gitster@pobox.com>
Cc:     =?UTF-8?Q?=E5=BE=90=E6=B2=9B=E6=96=87_=28Aleen=29_via_GitGitGadget?= 
        <gitgitgadget@gmail.com>, "Git Mailing List" <git@vger.kernel.org>,
        "Johannes Schindelin" <Johannes.Schindelin@gmx.de>,
        =?UTF-8?Q?=E5=BE=90=E6=B2=9B=E6=96=87_=28Aleen=29?= 
        <aleen42@vip.qq.com>, =?UTF-8?Q?Ren=C3=A9_Scharfe?= <l.s.r@web.de>,
        "Elijah Newren" <newren@gmail.com>
Subject: Re: [PATCH v11 2/2] am: support --empty=<option> to handle empty
 patches
X-Priority: 3
X-Mailer: Coremail Webmail Server Version XT6.0.3 build 20211103(a39c0bb8)
 Copyright (c) 2002-2021 www.mailtech.cn
 mispb-4edfefde-e422-4ddc-8a36-c3f99eb8cd32-icoremail.net
In-Reply-To: <CABPp-BF-eYcJ7eS==VK3M2xOqf5z4KNK4dP6qd_UcfLO1NWBeg@mail.gmail.com>
References: <pull.1076.v10.git.1637567471.gitgitgadget@gmail.com>
 <pull.1076.v11.git.1637681215.gitgitgadget@gmail.com>
 <6051ad9440a966124e9147ec344ee6d87c46944a.1637681215.git.gitgitgadget@gmail.com>
 <CABPp-BF-eYcJ7eS==VK3M2xOqf5z4KNK4dP6qd_UcfLO1NWBeg@mail.gmail.com>
Content-Transfer-Encoding: base64
Content-Type: text/plain; charset=UTF-8
MIME-Version: 1.0
Message-ID: <36706841.2ec.17d6afdb326.Coremail.pwxu@coremail.cn>
X-Coremail-Locale: en_US
X-CM-TRANSID: AgIMCgCX4kMPm6RhRwcAAA--.301W
X-CM-SenderInfo: psz03q5fruvzxdlohubq/1tbiAQcBCFGCdORIbAAAso
Authentication-Results: hzbj-icmmx-1; spf=neutral smtp.mail=pwxu@corem
        ail.cn;
X-Coremail-Antispam: 1Uk129KBjvJXoWxJFyrZw13KrWfKr4kWw1DGFg_yoW5Wr4fpa
        yYk39Yyrs7Jr1rCwn7Cw4xXFyrWr93tFsxGr15Aw1UuF4DtryI9r4xKFs0vryUWryrZw4j
        vFWYkrWrG3W7u3DanT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUj1kv1TuYvTs0mT0YCTnIWj
        DUYxn0WfASr-VFAU7a7-sFnT9fnUUIcSsGvfJ3UbIYCTnIWIevJa73UjIFyTuYvj4RJUUU
        UUUUU
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

RGVhcnMgSGFtYW5vLAoKICAgRWxpamFoIE5ld3JlbiBoYXMgZ2l2ZW4gdHdvIGJldHRlciBzdWdn
ZXN0aW9uczoKCiAgICAgICAxLiBVc2UgJ2FzaycgcmF0aGVyIHRoYW4gJ2RpZScKICAgICAgIDIu
IFdoZW4gZXJyb3Jpbmcgb3V0ICdQYXRjaCBpcyBlbXB0eScsIHByaW50IG91dCBhIHR1dG9yaWFs
IGluZm9ybWF0aW9uCiAgICAgICAgICB0byBoZWxwIHVzZXJzIHVzaW5nICdnaXQgY29tbWl0IC0t
YWxsb3ctZW1wdHknIHRvIGtlZXAgcmVjb3JkaW5nIGFzIAogICAgICAgICAgYW4gZW1wdHkgY29t
bWl0LgoKICAgU2hvdWxkIHdlIGNvbnRpbnVlIHRvIGltcGxlbWVudCB0aGVzZSBmZWF0dXJlcyBp
biBjdXJyZW50IFBSPwoKQWxlZW4KCj4gPiArLS1lbXB0eT0oZGllfGRyb3B8a2VlcCk6Ogo+ID4g
KyAgICAgICBCeSBkZWZhdWx0LCBvciB3aGVuIHRoZSBvcHRpb24gaXMgc2V0IHRvICdkaWUnLCB0
aGUgY29tbWFuZAo+ID4gKyAgICAgICBlcnJvcnMgb3V0IG9uIGFuIGlucHV0IGUtbWFpbCBtZXNz
YWdlIHRoYXQgbGFja3MgYSBwYXRjaC4gV2hlbgo+ID4gKyAgICAgICB0aGlzIG9wdGlvbiBpcyBz
ZXQgdG8gJ2Ryb3AnLCBza2lwIHN1Y2ggYW4gZS1tYWlsIG1lc3NhZ2UgaW5zdGVhZC4KPiA+ICsg
ICAgICAgV2hlbiB0aGlzIG9wdGlvbiBpcyBzZXQgdG8gJ2tlZXAnLCBjcmVhdGUgYW4gZW1wdHkg
Y29tbWl0LAo+ID4gKyAgICAgICByZWNvcmRpbmcgdGhlIGNvbnRlbnRzIG9mIHRoZSBlLW1haWwg
bWVzc2FnZSBhcyBpdHMgbG9nLgo+IAo+IFdoYXQgZG9lcyAnZXJyb3JzIG91dCcgbWVhbj8gIElz
IHRoZSBhbSBvcGVyYXRpb24gYWJvcnRlZCwgYW5kIHRoZQo+IHVzZXIgcmV0dXJuIHRvIHRoZSBw
cmUtYW0gc3RhdGU/ICBPciBpcyB0aGUgYW0gb3BlcmF0aW9uIGludGVycnVwdGVkLAo+IHdpdGgg
dGhlIHVzZXIgYmVpbmcgYXNrZWQgdG8gY2hvb3NlIHdoZXRoZXIgdG8ga2VlcCBvciBkcm9wIHRo
ZSBwYXRjaD8KPiAgT3Igc29tZXRoaW5nIGVsc2UgKG15IGZpcnN0IHRob3VnaHQgd2FzICJBcmUg
eW91IGdvaW5nIHRvIGxlYXZlIHRoZQo+IGluZGV4IGxvY2tlZD8iKT8gIFRoaXMgZGVzY3JpcHRp
b24gaXMgbm90IHRoYXQgY2xlYXIuICBUbyBtZSwgdGhlCj4gd29yZGluZyBzdWdnZXN0cyBhYm9y
dGVkIChvciB3b3JzZSksIGJ1dCB3aGF0IHlvdSBhY3R1YWxseSBpbXBsZW1lbnRlZAo+IHdhcyBh
biBpbnRlcnJ1cHQtYW5kLWFzay4KPiAKPiBDYW4gSSBzdWdnZXN0IHVzaW5nICdhc2snIGluc3Rl
YWQgb2YgJ2RpZSc/ICBJIHRoaW5rIHRoYXQgd2lsbCBiZQo+IGNsZWFyZXIsIGFuZCBpdCBtYXRj
aGVzIHRoZSB0ZXJtIHVzZWQgYnkgZ2l0IHJlYmFzZSAtLWVtcHR5Lgo+IAo+IEFsc28sIHRoZSBv
bmx5IGluc3RydWN0aW9ucyBnaXZlbiB0byB0aGUgdXNlciB3aGVuIHlvdSBpbnRlcnJ1cHQKPiBp
bmNsdWRlIGhvdyB0byBza2lwIHRoZSBwYXRjaCwgYnV0IEkgZG9uJ3Qgc2VlIGFueXRoaW5nIGZv
ciBob3cgdG8KPiBrZWVwIGl0LiAgVGhlIGluc3RydWN0aW9ucyBhcmU6Cj4gJycnCj4gUGF0Y2gg
aXMgZW1wdHkuCj4gV2hlbiB5b3UgaGF2ZSByZXNvbHZlZCB0aGlzIHByb2JsZW0sIHJ1biAiZ2l0
IGFtIC0tY29udGludWUiLgo+IElmIHlvdSBwcmVmZXIgdG8gc2tpcCB0aGlzIHBhdGNoLCBydW4g
ImdpdCBhbSAtLXNraXAiIGluc3RlYWQuCj4gVG8gcmVzdG9yZSB0aGUgb3JpZ2luYWwgYnJhbmNo
IGFuZCBzdG9wIHBhdGNoaW5nLCBydW4gImdpdCBhbSAtLWFib3J0Ii4KPiAnJycKPiAKPiBJIHRy
aWVkIGl0IG1hbnVhbGx5LCBhbmQgaXQgdHVybnMgb3V0ICJnaXQgYW0gLS1jb250aW51ZSIgd2ls
bCBqdXN0Cj4gc3BpdCBvdXQgYmFzaWNhbGx5IHRoZSBzYW1lIG1lc3NhZ2UgYWdhaW46Cj4gJycn
Cj4gQXBwbHlpbmc6IGVtcHR5IGNvbW1pdAo+IE5vIGNoYW5nZXMgLSBkaWQgeW91IGZvcmdldCB0
byB1c2UgJ2dpdCBhZGQnPwo+IElmIHRoZXJlIGlzIG5vdGhpbmcgbGVmdCB0byBzdGFnZSwgY2hh
bmNlcyBhcmUgdGhhdCBzb21ldGhpbmcgZWxzZQo+IGFscmVhZHkgaW50cm9kdWNlZCB0aGUgc2Ft
ZSBjaGFuZ2VzOyB5b3UgbWlnaHQgd2FudCB0byBza2lwIHRoaXMgcGF0Y2guCj4gV2hlbiB5b3Ug
aGF2ZSByZXNvbHZlZCB0aGlzIHByb2JsZW0sIHJ1biAiZ2l0IGFtIC0tY29udGludWUiLgo+IElm
IHlvdSBwcmVmZXIgdG8gc2tpcCB0aGlzIHBhdGNoLCBydW4gImdpdCBhbSAtLXNraXAiIGluc3Rl
YWQuCj4gVG8gcmVzdG9yZSB0aGUgb3JpZ2luYWwgYnJhbmNoIGFuZCBzdG9wIHBhdGNoaW5nLCBy
dW4gImdpdCBhbSAtLWFib3J0Ii4KPiAnJycKPiAKPiBBbmQgaWYgSSB0cnkgdG8gcnVuIGBnaXQg
Y29tbWl0IC0tYWxsb3ctZW1wdHlgICh3aGljaCBJIGhhcHBlbiB0bwo+IHJlbWVtYmVyIGlzIHRo
ZSBjb21tYW5kIHN1Z2dlc3RlZCBieSBgZ2l0IHJlYmFzZSAtLWVtcHR5PWFza2Agd2hlbiBpdAo+
IHN0b3BzKSwgdGhlbiBJJ20gZ2l2ZW4gYW4gZW1wdHkgZWRpdG9yOyBpdCBpcyBub3QgcHJlLXBv
cHVsYXRlZCB3aXRoCj4gdGhlIGFwcHJvcHJpYXRlIGNvbW1pdCBtZXNzYWdlLiAgQ2FuIHRoZSBw
b3J0aW9uIG9mIHRoZSBlbXB0eSBwYXRjaAo+IGNvcnJlc3BvbmRpbmcgdG8gdGhlIGNvbW1pdCBt
ZXNzYWdlIGJlIGFkZGVkIHRvIC5naXQvQ09NTUlUX0VESVRNU0cgdG8KPiBjb3JyZWN0IHRoYXQ/
ICBBbHNvLCBjYW4gc29tZSBleHRyYSB3b3JkcyBiZSBwcmludGVkIGJlZm9yZQo+IGludGVycnVw
dGluZyB0byBleHBsYWluIHdoYXQgdG8gZG8gd2hlbiB5b3Ugd2FudCB0byBrZWVwIHRoZSBlbXB0
eQo+IGNvbW1pdD8gIFNvbWV0aGluZyBsaWtlOgo+ICIiIgo+IFRoZSBjdXJyZW50IGNvbW1pdCBi
ZWluZyBhcHBsaWVkIGlzIGVtcHR5LiAgSWYgeW91IHdpc2ggdG8gY29tbWl0IGl0Cj4gYW55d2F5
LCB1c2U6Cj4gICAgIGdpdCBjb21taXQgLS1hbGxvdy1lbXB0eQo+ICIiIgo=

