Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6D420C433F5
	for <git@archiver.kernel.org>; Mon,  6 Dec 2021 01:35:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230273AbhLFBjN (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 5 Dec 2021 20:39:13 -0500
Received: from azure-sdnproxy.icoremail.net ([52.187.6.220]:59031 "HELO
        azure-sdnproxy-1.icoremail.net" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with SMTP id S231250AbhLFBjM (ORCPT
        <rfc822;git@vger.kernel.org>); Sun, 5 Dec 2021 20:39:12 -0500
Received: from mailtech.cn (unknown [10.12.1.20])
        by hzbj-icmmx-1 (Coremail) with SMTP id AQAAfwCHWbaqaK1hlUmoCQ--.6313S2;
        Mon, 06 Dec 2021 09:34:34 +0800 (CST)
Received: from pwxu$coremail.cn ( [112.94.4.17] ) by
 ajax-webmail-mailtech_rd (Coremail) ; Mon, 6 Dec 2021 09:35:39 +0800 (CST)
X-Originating-IP: [112.94.4.17]
Date:   Mon, 6 Dec 2021 09:35:39 +0800 (CST)
X-CM-HeaderCharset: UTF-8
From:   =?UTF-8?Q?Aleen_=E5=BE=90=E6=B2=9B=E6=96=87?= <pwxu@coremail.cn>
To:     "Junio C Hamano" <gitster@pobox.com>
Cc:     "=?UTF-8?Q?=22=22=E5=BE=90=E6=B2=9B=E6=96=87_=28Aleen=29=22_v?=
        =?UTF-8?Q?ia_GitGitGadget=22?=" <gitgitgadget@gmail.com>,
        git@vger.kernel.org, =?UTF-8?Q?Ren=C3=A9_Scharfe?= <l.s.r@web.de>,
        "Phillip Wood" <phillip.wood123@gmail.com>,
        "Johannes Schindelin" <Johannes.Schindelin@gmx.de>,
        "Elijah Newren" <newren@gmail.com>, Aleen <aleen42@vip.qq.com>
Subject: Re: [PATCH v14 3/3] am: support --allow-empty to record specific
 empty patches
X-Priority: 3
X-Mailer: Coremail Webmail Server Version XT6.0.3 build 20211103(a39c0bb8)
 Copyright (c) 2002-2021 www.mailtech.cn
 mispb-4edfefde-e422-4ddc-8a36-c3f99eb8cd32-icoremail.net
In-Reply-To: <xmqqy253x1pe.fsf@gitster.g>
References: <pull.1076.v13.git.1638266115.gitgitgadget@gmail.com>
 <pull.1076.v14.git.1638329848.gitgitgadget@gmail.com>
 <cbd822d4340f8f3d832e9d6209ee8db6e538fca1.1638329848.git.gitgitgadget@gmail.com>
 <xmqqy253x1pe.fsf@gitster.g>
Content-Transfer-Encoding: base64
Content-Type: text/plain; charset=UTF-8
MIME-Version: 1.0
Message-ID: <7f165c0d.1f.17d8d61d9b1.Coremail.pwxu@coremail.cn>
X-Coremail-Locale: en_US
X-CM-TRANSID: AgIMCgDnxgDraK1hawIAAA--.106W
X-CM-SenderInfo: psz03q5fruvzxdlohubq/1tbiAgAICFGCc56XGAABsy
Authentication-Results: hzbj-icmmx-1; spf=neutral smtp.mail=pwxu@corem
        ail.cn;
X-Coremail-Antispam: 1Uk129KBjvJXoW7uw1rZryfAw4DWFW3ur48Zwb_yoW8tFWUpF
        Z0gw40k3ykGa1xArs3Ww1xWFyF93WkJF45Zr1rAryq9F98uF1Ikr4Sg3yYy3y7Xas3Z3yY
        va1UJr1UKF1qv3DanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUj1kv1TuYvTs0mT0YCTnIWj
        DUYxn0WfASr-VFAU7a7-sFnT9fnUUIcSsGvfJ3UbIYCTnIWIevJa73UjIFyTuYvj4RJUUU
        UUUUU
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

RGVhcnMgSGFtYW5vLAoKICAgIEZvciB0aG9zZSA2IGNhc2VzLCBpdCBzZWVtcyBgZ2l0LWFtYCBz
aG91bGQgb25seSB3b3JrIHdoZW4gdGhlIGFtIHNlc3Npb24KICAgIHdhcyBzdG9wcGVkIGluIHRo
ZSBtaWRkbGUgYWNjb3JkaW5nIHRvIGFuIGVtcHR5IHBhdGNoLCBidXQgbm90IHdoZW4gdGhlIGlu
ZGV4CiAgICBoYXMgbm90IGNoYW5nZWQuIERvZXMgdGhhdCBtZWFuIHdlIHNob3VsZCByZWNvcmQg
YSBuZXcgc3RhdGUgZm9yIHRoZSBhbSBzdGF0ZT8KICAgIElmIHRoYXQncyByaWdodCwgSSB3aWxs
IHRyeSB0byBwYXRjaCBpdCB2aWEgdmVyc2lvbiAxNSwgYW5kIHRyeSB0byBhZGQgYWRkaXRpb25h
bAogICAgdGVzdCBjYXNlcyBmb3IgdGhlc2UgNiBzaXR1YXRpb25zLiBJIHdhcyBhIGxpdHRsZSBi
dXN5IHRob3NlIGRheXMgYW5kIHNvcnJ5IGZvcgogICAgdGhlIGxhdGUgYW5zd2VyLgoKQWxlZW4K
Cj4gVGhlc2UgdHdvIGFyZSAicG9zaXRpdmUiIHRlc3RzLCBpLmUuIHRoZSBmZWF0dXJlIGRvZXMg
dGhlIHJpZ2h0Cj4gdGhpbmcgd2hlbiB1c2VkIGluIHRoZSBleHBlY3RlZCBzaXR1YXRpb24uCj4g
Cj4gSSBhbSB3b3JyaWVkIGFib3V0IHRoZSBjYXNlcyB3aGVyZSAiLS1hbGxvdy1lbXB0eSIgaXMg
dXNlZCBhbmQKPiBjcmVhdGVzIGEgY29tbWl0IHRoYXQgaXMgZW1wdHksIHdoZW4gaXQgaXMgcmVh
c29uYWJseSBleHBlY3RlZCB0bwo+IGVpdGhlciBjcmVhdGUgYSBub24tZW1wdHkgY29tbWl0IG9y
IHN0aWxsIGZhaWwgdGhlIHNhbWUgd2F5IHRvIGdpdmUKPiB0aGUgdXNlciBhbm90aGVyIGNoYW5j
ZSB0byB0cnkuCj4gCj4gRm9yIGV4YW1wbGUsIHdoZW4gImdpdCBhbSAtMyIgZmFpbHMgb24gc3Vj
aCBhbiBlbWFpbCBtZXNzYWdlICh0aGVyZQo+IGFyZSB0d28gZmFpbHVyZSBtb2RlczogKGEpIG9u
ZSByZXN1bHRzIGluIGFuIHVubWVyZ2VkIGluZGV4IGR1ZSB0bwo+IG1lcmdlIGNvbmZsaWN0cywg
KGIpIHRoZSBvdGhlciByZXN1bHRzIGluIGEgY2xlYW4gaW5kZXggZHVlIHRvIG5vdAo+IGZpbmRp
bmcgdGhlIGJsb2Igb2JqZWN0IHJlY29yZGVkIGFzIGEgcHJlaW1hZ2UpLCB3aGF0IGhhcHBlbnMg
d2hlbgo+IHRoZSB1c2VyIHJ1bnMgImdpdCBhbSAtLWFsbG93LWVtcHR5IiwgYWZ0ZXI6Cj4gCj4g
ICgxKSBkb2luZyBub3RoaW5nIHNpbmNlIHRoZSBmYWlsZWQgImdpdCBhbSAtMyIgYXBwbGljYXRp
b24sCj4gICgyKSByZXNvbHZpbmcgdGhlIGNvbmZsaWN0cyBpbiB3b3JraW5nIHRyZWUsIG9yCj4g
ICgzKSByZXNvbHZpbmcgdGhlIGNvbmZsaWN0cyBpbiB3b3JraW5nIHRyZWUgYW5kIHJlY29yZGlu
ZyB0aGUKPiAgICAgIHJlc29sdXRpb24gaW4gdGhlIGluZGV4Lgo+IAo+IFRoZXJlIGFyZSA2IGNh
c2VzIGluIHRoZSBhYm92ZSBtYXRyaXgsIGFuZCAiZ2l0IGFtIC0tYWxsb3ctZW1wdHkiCj4gc2hv
dWxkIG5vdCBjcmVhdGUgYW4gZW1wdHkgY29tbWl0IGluIGFueSBvbmUgb2YgdGhlbS4gIEluIDFh
IGFuZCAxYiwKPiAiZ2l0IGFtIC0tYWxsb3ctZW1wdHkiIHNob3VsZCBjb250aW51ZSB0byBmYWls
ICgiZ2l0IGFtIC0tc2tpcCIKPiB3b3VsZCBiZSBhIHdheSB0byBpZ25vcmUgYW5kIHByb2NlZWQp
LiAgM2EgYW5kIDNiIHNob3VsZCByZWNvcmQgYQo+IG5vbi1lbXB0eSBjb21taXQgYXMgdGhlIHJl
c3VsdC4KPiAKPiBTaW1pbGFybHksIHdoZW4gYW4gZW1haWwgbWVzc2FnZSB3aXRoIGEgcGF0Y2gg
aXMgZ2l2ZW4gdG8gImdpdCBhbSIKPiBhbmQgdGhlIGFwcGxpY2F0aW9uIGZhaWxzLCBhbmQgdGhl
IHVzZXIgcnVucyAiZ2l0IGFtIC0tYWxsb3ctZW1wdHkiCj4gd2l0aG91dCBkb2luZyBhbnl0aGlu
ZyBpbiB0aGUgd29ya2luZyB0cmVlLCB3aGF0IGhhcHBlbnM/ICBJdCBzaG91bGQKPiBub3QgaGFw
cGlseSBjcmVhdGUgYW4gZW1wdHkgY29tbWl0IHdpdGggb25seSB0aGUgbG9nIG1lc3NhZ2UsCj4g
d2l0aG91dCB0aGUgY2hhbmdlLCBidXQgY29udGludWUgdG8gZmFpbC4gIElmIHRoZSB1c2VyIHJl
c29sdmVzIGFuZAo+IHJlZ2lzdGVycyB0aGUgcmVzb2x1dGlvbiB0byB0aGUgaW5kZXggYmVmb3Jl
ICJnaXQgYW0gLS1hbGxvdy1lbXB0eSIsCj4gdGhlbiB0aGUgY29tbWFuZCBzaG91bGQgY3JlYXRl
IGEgbm9uLWVtcHR5IGNvbW1pdC4KPiAKPiBIYXZpbmcgcG9zaXRpdmUgdGVzdHMgYXJlIG9mIGNv
dXJzZSBpbXBvcnRhbnQgdG8gYXZvaWQgcmVncmVzc2lvbiBpbgo+IHRoZSBmdXR1cmUsIGJ1dCBu
ZWdhdGl2ZSB0ZXN0cywgdGhlIG5ldyBhbmQgc2hpbnkgZmVhdHVyZSBkb2VzIG5vdAo+IG1pc2Jl
aGF2ZSB3aGVuIGl0IHNob3VsZG4ndCBldmVuIGtpY2sgaW4sIGlzIGV2ZW4gbW9yZSBpbXBvcnRh
bnQuCj4gCj4gVGhhbmtzLgo=

