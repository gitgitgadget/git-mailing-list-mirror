Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7D016C433EF
	for <git@archiver.kernel.org>; Mon, 22 Nov 2021 07:04:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232108AbhKVHHd (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 22 Nov 2021 02:07:33 -0500
Received: from azure-sdnproxy.icoremail.net ([52.229.168.213]:52920 "HELO
        azure-sdnproxy-2.icoremail.net" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with SMTP id S229806AbhKVHHc (ORCPT
        <rfc822;git@vger.kernel.org>); Mon, 22 Nov 2021 02:07:32 -0500
Received: from mailtech.cn (unknown [10.12.1.20])
        by hzbj-icmmx-1 (Coremail) with SMTP id AQAAfwBnM7CyQJthCJunCA--.31581S2;
        Mon, 22 Nov 2021 15:03:14 +0800 (CST)
Received: from pwxu$coremail.cn ( [112.94.4.17] ) by
 ajax-webmail-mailtech_rd (Coremail) ; Mon, 22 Nov 2021 15:04:18 +0800 (CST)
X-Originating-IP: [112.94.4.17]
Date:   Mon, 22 Nov 2021 15:04:18 +0800 (CST)
X-CM-HeaderCharset: UTF-8
From:   =?UTF-8?Q?Aleen_=E5=BE=90=E6=B2=9B=E6=96=87?= <pwxu@coremail.cn>
To:     "Junio C Hamano" <gitster@pobox.com>
Cc:     git@vger.kernel.org, =?UTF-8?Q?Ren=C3=A9_Scharfe?= <l.s.r@web.de>,
        "Phillip Wood" <phillip.wood123@gmail.com>,
        Aleen <aleen42@vip.qq.com>,
        =?UTF-8?Q?Aleen_=E5=BE=90=E6=B2=9B=E6=96=87_via_GitGitGadget?= 
        <gitgitgadget@gmail.com>
Subject: Re: [PATCH v9 2/2] am: support --empty=<option> to handle empty
 patches
X-Priority: 3
X-Mailer: Coremail Webmail Server Version XT6.0.3 build 20211103(a39c0bb8)
 Copyright (c) 2002-2021 www.mailtech.cn
 mispb-4edfefde-e422-4ddc-8a36-c3f99eb8cd32-icoremail.net
In-Reply-To: <d2ec18b36afab430287882aed4528a8efc90508a.1637564555.git.gitgitgadget@gmail.com>
References: <pull.1076.v8.git.1637563611.gitgitgadget@gmail.com>
 <pull.1076.v9.git.1637564554.gitgitgadget@gmail.com>
 <d2ec18b36afab430287882aed4528a8efc90508a.1637564555.git.gitgitgadget@gmail.com>
Content-Transfer-Encoding: base64
Content-Type: text/plain; charset=UTF-8
MIME-Version: 1.0
Message-ID: <4390f9f1.21d.17d4675b43d.Coremail.pwxu@coremail.cn>
X-Coremail-Locale: en_US
X-CM-TRANSID: AgIMCgAnw6nyQJthpAUAAA--.215W
X-CM-SenderInfo: psz03q5fruvzxdlohubq/1tbiAQcOCFGCdOPg2AAMsw
Authentication-Results: hzbj-icmmx-1; spf=neutral smtp.mail=pwxu@corem
        ail.cn;
X-Coremail-Antispam: 1Uk129KBjvdXoWrZFy5KrW5XrWDXw1Uur43trb_yoWxuFg_ua
        4kZFZ8Wa18JFZIvFsrJr98Z3yfK34DZryDXF1DXrs3WFyruF4ruFnavr9xA3Z5Cay3W3WU
        C3Z3u340g3y3ZjkaLaAFLSUrUUUUjb8apTn2vfkv8UJUUUU8wcxFpf9Il3svdxBIdaVrnU
        Uv73VFW2AGmfu7jjvjm3AaLaJ3UjIYCTnIWjDUYxBIdaVFxhVjvjDU0xZFpf9x0zRUUUUU
        UUUU=
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

PiBDYW4gc29tZWJvZHkgZnJvbSBHR0cgbGFuZCBoZWxwIHRoaXMgdXNlcj8gIEkgX3RoaW5rXyB0
aGUgZWFzaWVzdAo+IHdvcmthcm91bmQgKG90aGVyIHRoYW4gbm90IHVzaW5nIEdHRyBhbmQgc2Vu
ZGluZyBlLW1haWwgaW4gdGhlIG9sZAo+IGZhc2hpb25lZCB3YXkpIGlzIHRvIGNvbW1pdCBhbmQg
c2lnbi1vZmYgdW5kZXIgdGhlIHJlYWwgbmFtZSwgYW5kCj4gcHVzaCB1bmRlciB3aGF0ZXZlciBH
aXRIdWIgdXNlcm5hbWUgdG8gdGhyb3cgYSBHR0cgcHVsbCByZXF1ZXN0LAo+IHdoaWNoIEdHRyBz
aG91bGQgYmUgYWJsZSB0byB0YWtlLCBhcyBJIGhhdmUgc2VlbiB1c2VycyBmb3J3YXJkIG90aGVy
Cj4gYXV0aG9ycyBjb21taXRzIGp1c3QgZmluZS4KClNvcnJ5IGZvciB0aGUgd3JvbmcgcmVwb3J0
LCBhbmQgSSBoYXZlIGNoZWNrZWQgdGhhdCB0aGUgRENPIGludGVncmF0ZWQgYnkgR0dHIGhhcyBv
bmx5IGNoZWNrZWQKd2hldGhlciB0aGUgY29tbWl0dGVyIG5hbWUgaXMgdGhlIHNhbWUgYXMgdGhl
IHNpZ25lZCBuYW1lLiBTbyBJIGhhdmUgY2hhbmdlZCBpdCwgYW5kIHJlLXN1Ym1pdHRlZAppdCB2
aWEgdmVyc2lvbiA5LgoKPiBgLS1lbXB0eS1jb21taXQ9KGRpZXxkcm9wfGtlZXApOjpgCgpCZXNp
ZGVzLCBJIGhhdmUgYWxzbyBmaXhlZCBhIG1pc3NlZCBtaXN0YWtlLCB3aGljaCBhbHNvIGV4aXN0
cyBpbiB0aGUgYHNlZW5gIGJyYW5jaC4=

