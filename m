Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 783F9C433F5
	for <git@archiver.kernel.org>; Tue, 16 Nov 2021 10:33:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 50FA563217
	for <git@archiver.kernel.org>; Tue, 16 Nov 2021 10:33:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234204AbhKPKgQ (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 16 Nov 2021 05:36:16 -0500
Received: from zg8tmja5ljk3lje4mi4ymjia.icoremail.net ([209.97.182.222]:37162
        "HELO zg8tmja5ljk3lje4mi4ymjia.icoremail.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with SMTP id S234258AbhKPKfU (ORCPT
        <rfc822;git@vger.kernel.org>); Tue, 16 Nov 2021 05:35:20 -0500
X-Greylist: delayed 83867 seconds by postgrey-1.27 at vger.kernel.org; Tue, 16 Nov 2021 05:35:20 EST
Received: from mailtech.cn (unknown [10.12.1.20])
        by hzbj-icmmx-2 (Coremail) with SMTP id AQAAfwBXhNSuiJNhPb2pBQ--.22061S2;
        Tue, 16 Nov 2021 18:32:34 +0800 (CST)
Received: from pwxu$coremail.cn ( [112.94.4.17] ) by
 ajax-webmail-mailtech_rd (Coremail) ; Tue, 16 Nov 2021 18:31:45 +0800 (CST)
X-Originating-IP: [112.94.4.17]
Date:   Tue, 16 Nov 2021 18:31:45 +0800 (CST)
X-CM-HeaderCharset: UTF-8
From:   =?UTF-8?Q?Aleen_=E5=BE=90=E6=B2=9B=E6=96=87?= <pwxu@coremail.cn>
To:     phillip.wood@dunelm.org.uk
Cc:     "Aleen via GitGitGadget" <gitgitgadget@gmail.com>,
        git@vger.kernel.org, =?UTF-8?Q?Ren=C3=A9_Scharfe?= <l.s.r@web.de>,
        Aleen <aleen42@vip.qq.com>, "Junio C Hamano" <gitster@pobox.com>
Subject: Re: [PATCH v4 2/2] am: support --empty-commit option to handle
 empty patches
X-Priority: 3
X-Mailer: Coremail Webmail Server Version XT6.0.3 build 20211103(a39c0bb8)
 Copyright (c) 2002-2021 www.mailtech.cn
 mispb-4edfefde-e422-4ddc-8a36-c3f99eb8cd32-icoremail.net
In-Reply-To: <23de56a6-5b41-d8be-d59c-5a4e025ccd73@gmail.com>
References: <pull.1076.v3.git.1636972769.gitgitgadget@gmail.com>
 <pull.1076.v4.git.1637039888.gitgitgadget@gmail.com>
 <b7e30c9b7abecdc871ddc38122ca042e940cb190.1637039888.git.gitgitgadget@gmail.com>
 <23de56a6-5b41-d8be-d59c-5a4e025ccd73@gmail.com>
Content-Transfer-Encoding: base64
Content-Type: text/plain; charset=UTF-8
MIME-Version: 1.0
Message-ID: <77268d7d.3ce.17d284d7732.Coremail.pwxu@coremail.cn>
X-Coremail-Locale: en_US
X-CM-TRANSID: AgIMCgCHb5yRiJNhxwcAAA--.425W
X-CM-SenderInfo: psz03q5fruvzxdlohubq/1tbiAQcICFGCdOOckQADsM
Authentication-Results: hzbj-icmmx-2; spf=neutral smtp.mail=pwxu@corem
        ail.cn;
X-Coremail-Antispam: 1Uk129KBjvdXoW7GFykZr17Xr45WFykAF43ZFb_yoWfWFg_Kr
        s5K3WUWw4j9FWaqanYyFsIv3yYqwn3G3s3t347WwnxC347AFs8CF4kJryfua97Ja1Utr9x
        Grn0g3sxG3W3WjkaLaAFLSUrUUUUbb8apTn2vfkv8UJUUUU8wcxFpf9Il3svdxBIdaVrnU
        Uv73VFW2AGmfu7jjvjm3AaLaJ3UjIYCTnIWjDUYxBIdaVFxhVjvjDU0xZFpf9x0zRUUUUU
        UUUU=
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

PiA+ICstLWVtcHR5LWNvbW1pdD0oZGllfHNraXB8YXNpcyk6Ogo+ID4gKwlUaGUgY29tbWFuZCB1
c3VhbGx5IGVycm9ycyBvdXQgd2hlbiBzZWVpbmcgYW4gaW5wdXQgZS1tYWlsCj4gPiArCW1lc3Nh
Z2UgdGhhdCBsYWNrcyBhIHBhdGNoLiBXaGVuIHRoaXMgb3B0aW9uIGlzIHNldCB0bwo+ID4gKwkn
c2tpcCcsIHNraXAgc3VjaCBhbiBlLW1haWwgbWVzc2FnZSB3aXRob3V0IG91dHB1dHRpbmcgZXJy
b3IuCj4gPiArCVdoZW4gdGhpcyBvcHRpb24gaXMgc2V0IHRvICdhc2lzJywgY3JlYXRlIGFuIGVt
cHR5IGNvbW1pdCwKPiA+ICsJcmVjb3JkaW5nIHRoZSBjb250ZW50cyBvZiB0aGUgZS1tYWlsIG1l
c3NhZ2UgYXMgaXRzIGxvZy4KPiA+ICsJJ2RpZScgaXMgc3BlY2lmaWVkIGJ5IGRlZmF1bHQuCj4g
Cj4gVGhpcyBmZWVscyBzdWZmaWNpZW50bHkgc2ltaWxhciB0byB0aGUgY2FzZSBvZiBoYW5kbGlu
ZyBlbXB0eSBjb21taXRzIGluIAo+ICdnaXQgcmViYXNlJyB0aGF0IGl0IGlzIHdvcnRoIHRyeWlu
ZyB0byBoYXZlIGEgc2ltaWxhciB1c2VyIGludGVyZmFjZS4gCj4gT3RoZXJ3aXNlIHRoZSB0d28g
Y29tbWFuZHMgaGF2ZSB0d28gZGlmZmVyZW50IG9wdGlvbiBuYW1lcyBkb2luZyBtb3JlIG9yIAo+
IGxlc3MgdGhlIHNhbWUgdGhpbmcuICdnaXQgcmViYXNlJyBoYXMgLS1lbXB0eT1bZHJvcCxrZWVw
LGFza10gd2hlcmUgZHJvcCAKPiBpcyB0aGUgZGVmYXVsdC4gSWYgYW0gd2VyZSB0byBhY2NlcHQg
LS1lbXB0eT1bZHJvcCxrZWVwLGRpZV0gaXQgd291bGQgCj4gb2ZmZXIgYSBzaW1pbGFyIHVzZXIg
ZXhwZXJpZW5jZS4KPiAKPiBCZXN0IFdpc2hlcwo+IAo+IFBoaWxsaXAKCkRlYXJzIFBoaWxsaXAs
CgpJdCBzZWVtcyBhIGdvb2QgaWRlYS4gQ2FuIEhhbWFubyBtYWtlIGEgZGVjaXNpb24/CgpBbGVl
bgo=

