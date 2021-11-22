Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D0539C433F5
	for <git@archiver.kernel.org>; Mon, 22 Nov 2021 07:19:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238579AbhKVHW2 (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 22 Nov 2021 02:22:28 -0500
Received: from zg8tmja5ljk3lje4mi4ymjia.icoremail.net ([209.97.182.222]:47014
        "HELO zg8tmja5ljk3lje4mi4ymjia.icoremail.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with SMTP id S229806AbhKVHW1 (ORCPT
        <rfc822;git@vger.kernel.org>); Mon, 22 Nov 2021 02:22:27 -0500
Received: from mailtech.cn (unknown [10.12.1.20])
        by hzbj-icmmx-2 (Coremail) with SMTP id AQAAfwAHNNSURJthc37xBQ--.49334S2;
        Mon, 22 Nov 2021 15:19:48 +0800 (CST)
Received: from pwxu$coremail.cn ( [112.94.4.17] ) by
 ajax-webmail-mailtech_rd (Coremail) ; Mon, 22 Nov 2021 15:19:18 +0800 (CST)
X-Originating-IP: [112.94.4.17]
Date:   Mon, 22 Nov 2021 15:19:18 +0800 (CST)
X-CM-HeaderCharset: UTF-8
From:   =?UTF-8?Q?Aleen_=E5=BE=90=E6=B2=9B=E6=96=87?= <pwxu@coremail.cn>
To:     "Junio C Hamano" <gitster@pobox.com>
Cc:     "Aleen via GitGitGadget" <gitgitgadget@gmail.com>,
        git@vger.kernel.org, =?UTF-8?Q?Ren=C3=A9_Scharfe?= <l.s.r@web.de>,
        "Phillip Wood" <phillip.wood123@gmail.com>,
        Aleen <aleen42@vip.qq.com>
Subject: Re: [PATCH v8 2/2] am: support --empty=<option> to handle empty
 patches
X-Priority: 3
X-Mailer: Coremail Webmail Server Version XT6.0.3 build 20211103(a39c0bb8)
 Copyright (c) 2002-2021 www.mailtech.cn
 mispb-4edfefde-e422-4ddc-8a36-c3f99eb8cd32-icoremail.net
In-Reply-To: <xmqqbl2ck6u1.fsf@gitster.g>
References: <pull.1076.v7.git.1637298298.gitgitgadget@gmail.com>
 <pull.1076.v8.git.1637563611.gitgitgadget@gmail.com>
 <3ff18e16a7a24fdd8c57b40960e0d6b95c2490e6.1637563611.git.gitgitgadget@gmail.com>
 <xmqqbl2ck6u1.fsf@gitster.g>
Content-Transfer-Encoding: base64
Content-Type: text/plain; charset=UTF-8
MIME-Version: 1.0
Message-ID: <775978a8.236.17d46836f86.Coremail.pwxu@coremail.cn>
X-Coremail-Locale: en_US
X-CM-TRANSID: AgIMCgAnw6l2RJth0AUAAA--.222W
X-CM-SenderInfo: psz03q5fruvzxdlohubq/1tbiAQcOCFGCdOPg2AAOsy
Authentication-Results: hzbj-icmmx-2; spf=neutral smtp.mail=pwxu@corem
        ail.cn;
X-Coremail-Antispam: 1Uk129KBjvdXoWrKFW8tr1fKw4rXw1rCr15Jwb_yoWxKrc_Ga
        yrJF1Iya1vyFWDXa97JFsrZFy3JrWUua48ua4DXrWxu345AF4kGFs5Jry3Ja1kJ3y8ur90
        9Fn5uw18Z343XjkaLaAFLSUrUUUUUb8apTn2vfkv8UJUUUU8wcxFpf9Il3svdxBIdaVrnU
        Uv73VFW2AGmfu7jjvjm3AaLaJ3UjIYCTnIWjDUYxBIdaVFxhVjvjDU0xZFpf9x0zRUUUUU
        UUUU=
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Cj4gUGVyaGFwcyB0aGlzIGxpbmUgc2hvdWxkIGltaXRhdGUgd2hhdCBIYW5zIEtyZW50ZWwgZGlk
IGluCj4gaHR0cHM6Ly9sb3JlLmtlcm5lbC5vcmcvZ2l0L3B1bGwuMTE0My5naXQuZ2l0LjE2Mzcz
NDc4MTMzNjcuZ2l0Z2l0Z2FkZ2V0QGdtYWlsLmNvbS8sCj4gaS5lLiByZWFsIG5hbWUgZmlyc3Qs
IGFuZCB0aGVuIChuaWNrbmFtZSkgaW4gcGFyZW50aGVzZXMuCj4gCj4gQWxzbywgdGhlIGluLWJv
ZHkgIkZyb206IiBsaW5lIHNob3VsZCBtYXRjaCB0aGUgc2lnbiBvZmYuCj4gCj4gSSBjb3JyZWN0
ZWQgd2hhdCBoYXMgYmVlbiBxdWV1ZWQgaW4gJ3NlZW4nIG1hbnVhbGx5IHdoZW4gSSBhcHBsaWVk
Cj4gdGhlIHByZXZpb3VzIHJvdW5kLgo+IAo+ID4gKy0tZW1wdHk9KGRpZXxkcm9wfGtlZXApOjoK
PiAKPiBUaGlzIGlzIHRoZSBvbmx5IGNoYW5nZSByZWxhdGl2ZSB0byB3aGF0IGlzIHF1ZXVlZCAo
d2UgaGFkCj4gIi0tZW1wdHktY29tbWl0Iiwgd2hpY2ggaXMgcmVtbmFudCBmcm9tIGFuIGVhcmxp
ZXIgaXRlcmF0aW9uKSwgYW5kCj4gaXQgbWFrZXMgdGhlIGRvY3VtZW50YXRpb24gY29uc2lzdGVu
dCB3aXRoIHdoYXQgdGhlIGNvZGUgZG9lcy4KPiAKPiBHb29kLgoKSXQgc2VlbXMgdGhlcmUgaXMg
c29tZXRoaW5nIHdyb25nIHdoZW4gc3VibWl0dGluZyB2aWEgIuW+kOaym+aWhyAoQWxlZW4pIDxh
bGVlbjQyQHZpcC5xcS5jb20+Ii4=

