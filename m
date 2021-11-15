Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 37AE9C433EF
	for <git@archiver.kernel.org>; Mon, 15 Nov 2021 11:14:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0F01D63210
	for <git@archiver.kernel.org>; Mon, 15 Nov 2021 11:14:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231269AbhKOLRm (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 15 Nov 2021 06:17:42 -0500
Received: from azure-sdnproxy.icoremail.net ([52.229.168.213]:59931 "HELO
        azure-sdnproxy-2.icoremail.net" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with SMTP id S231211AbhKOLRj (ORCPT
        <rfc822;git@vger.kernel.org>); Mon, 15 Nov 2021 06:17:39 -0500
Received: from mailtech.cn (unknown [10.12.1.20])
        by hzbj-icmmx-1 (Coremail) with SMTP id AQAAfwDXqLWrQJJhpzPCBw--.4099S2;
        Mon, 15 Nov 2021 19:13:03 +0800 (CST)
Received: from pwxu$coremail.cn ( [112.94.4.17] ) by
 ajax-webmail-mailtech_rd (Coremail) ; Mon, 15 Nov 2021 19:13:47 +0800 (CST)
X-Originating-IP: [112.94.4.17]
Date:   Mon, 15 Nov 2021 19:13:47 +0800 (CST)
X-CM-HeaderCharset: UTF-8
From:   =?UTF-8?Q?Aleen_=E5=BE=90=E6=B2=9B=E6=96=87?= <pwxu@coremail.cn>
To:     "Junio C Hamano" <gitster@pobox.com>
Cc:     git@vger.kernel.org, =?UTF-8?Q?Ren=C3=A9_Scharfe?= <l.s.r@web.de>,
        Aleen <aleen42@vip.qq.com>,
        "Aleen via GitGitGadget" <gitgitgadget@gmail.com>
Subject: Re: [PATCH v3 2/2] am: support --empty-commit option to handle
 empty patches
X-Priority: 3
X-Mailer: Coremail Webmail Server Version XT6.0.3 build 20211103(a39c0bb8)
 Copyright (c) 2002-2021 www.mailtech.cn
 mispb-4edfefde-e422-4ddc-8a36-c3f99eb8cd32-icoremail.net
In-Reply-To: <ef33ce8c6f9e1e1519d3908edd3491fd00d78ac7.1636972769.git.gitgitgadget@gmail.com>
References: <pull.1076.v2.git.1636700040.gitgitgadget@gmail.com>
 <pull.1076.v3.git.1636972769.gitgitgadget@gmail.com>
 <ef33ce8c6f9e1e1519d3908edd3491fd00d78ac7.1636972769.git.gitgitgadget@gmail.com>
Content-Transfer-Encoding: base64
Content-Type: text/plain; charset=UTF-8
MIME-Version: 1.0
Message-ID: <60d0c28e.2943.17d234d975d.Coremail.pwxu@coremail.cn>
X-Coremail-Locale: en_US
X-CM-TRANSID: AgIMCgAHD7_rQJJhxxMCAA--.11800W
X-CM-SenderInfo: psz03q5fruvzxdlohubq/1tbiAQcHCFGCdOONIwAAsj
Authentication-Results: hzbj-icmmx-1; spf=neutral smtp.mail=pwxu@corem
        ail.cn;
X-Coremail-Antispam: 1Uk129KBjvdXoW7Xw17Kw17JryxXw4rWFW3Jrb_yoWkXrbEga
        4DWFs3G347ZFsIyF4YqF13ur4rX3yUGw1DArZ7XFZ8A34fZF4kuF1kWFWfAw18J3y29FWF
        9r1jv390yr17ZjkaLaAFLSUrUUUU1b8apTn2vfkv8UJUUUU8wcxFpf9Il3svdxBIdaVrnU
        Uv73VFW2AGmfu7jjvjm3AaLaJ3UjIYCTnIWjDUYxBIdaVFxhVjvjDU0xZFpf9x0zRUUUUU
        UUUU=
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

RGVhcnMgSGFtYW5vLAoKU29ycnkgYWJvdXQgdGhlIGxhdGUgc3VibWlzc2lvbiwgYW5kIEkgaGF2
ZSBtb2RpZmllZCBpdCB0byBzdXBwb3J0IHRoZSBgLS1lbXB0eS1jb21taXQ9KGRpZXxza2lwfGFz
aXMpYCBwYXR0ZXJuLgoKPiArdGVzdF9leHBlY3Rfc3VjY2VzcyAncmVjb3JkIGFzIGFuIGVtcHR5
IGNvbW1pdCB3aGVuIG1lZXRpbmcgZS1tYWlsIG1lc3NhZ2UgdGhhdCBsYWNrcyBhIHBhdGNoJyAn
Cj4gKwlnaXQgYW0gLS1lbXB0eS1jb21taXQ9YXNpcyBlbXB0eS1jb21taXQucGF0Y2ggJiYKPiAr
CXRlc3RfcGF0aF9pc19taXNzaW5nIC5naXQvcmViYXNlLWFwcGx5ICYmCj4gKwlnaXQgc2hvdyBl
bXB0eS1jb21taXQgLS1mb3JtYXQ9IiVCIiA+ZXhwZWN0ZWQgJiYKPiArCWdpdCBzaG93IEhFQUQg
LS1mb3JtYXQ9IiVCIiA+YWN0dWFsICYmCj4gKwlncmVwIC1mIGFjdHVhbCBleHBlY3RlZCAmJgo+
ICsKPiArCWdpdCBhbSAtLWVtcHR5LWNvbW1pdD1hc2lzIGNvdmVyLWxldHRlci5wYXRjaCAmJgo+
ICsJdGVzdF9wYXRoX2lzX21pc3NpbmcgLmdpdC9yZWJhc2UtYXBwbHkgJiYKPiArCWdpdCBzaG93
IGVtcHR5LWNvbW1pdCAtLWZvcm1hdD0iJUIiID5leHBlY3RlZCAmJgo+ICsJZ2l0IHNob3cgSEVB
RCAtLWZvcm1hdD0iJUIiID5hY3R1YWwgJiYKPiArCWdyZXAgLWYgYWN0dWFsIGV4cGVjdGVkCj4g
KycKCldoZW4gaXQgY29tZXMgdG8gdGhlIGxhc3QgdGVzdCBjYXNlLCB0aGVyZSBhcmUgc29tZSBh
Y2NpZGVudGFsIGNvbnRlbnRzIHJlY29nbml6ZWQgYXMgY29tbWl0IG1lc3NhZ2VzIGluc2lkZSBh
biBlbXB0eSBwYXRjaCwgbGlrZToKCjEuIHZlcnNpb24gc2lnbmF0dXJlczoKICA+IC0tIAogID4g
Mi4zNC4wLnJjMi4zOTAuZ2VmMzNjZThjNmYKMi4gaW5mb3JtYXRpb24gb2YgY292ZXIgbGV0dGVy
OgogID4gKioqIEJMVVJCIEhFUkUgKioqCiAgPgogID4gQSBVIFRob3IgKDEpOgogID4gICBlbXB0
eSBjb21taXQKCkkgZG9uJ3QgdGhpbmsgaXQgaXMgbmVjZXNzYXJ5IHRvIGZpeCBpdCB3aXRoaW4g
YG1haWxpbmZvLmNgLiBDYW4geW91IGdpdmUgbWUgc29tZSBzdWdnZXN0aW9ucyBvbiB3aGV0aGVy
IHRoaXMgY2FzZSBzaG91bGQgYmUgaGFuZGxlZD8KCkFsZWVu

