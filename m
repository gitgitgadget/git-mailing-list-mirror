Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 95933C4332F
	for <git@archiver.kernel.org>; Tue, 22 Nov 2022 03:52:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232353AbiKVDwy (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 21 Nov 2022 22:52:54 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33528 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232355AbiKVDwo (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 21 Nov 2022 22:52:44 -0500
Received: from mail11.tencent.com (mail11.tencent.com [14.18.178.29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CEA0D2B60C
        for <git@vger.kernel.org>; Mon, 21 Nov 2022 19:52:24 -0800 (PST)
Received: from EX-SZ020.tencent.com (unknown [10.28.6.40])
        by mail11.tencent.com (Postfix) with ESMTP id 52AEE679C0;
        Tue, 22 Nov 2022 11:52:22 +0800 (CST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=tencent.com;
        s=s202002; t=1669089142;
        bh=3oP5lv3aYw8OPUW3Zg/vT1oYnDLnq97nt84vRZQFnlc=;
        h=From:To:CC:Subject:Date:References:In-Reply-To;
        b=ep6xbZZzy5wTm06XMp4z9zEuJ2BnobrObdo1lO4IoUa6M9MWhZpuxF76axUIx/FNE
         F+Meai2dZawFv0tV4ZHvDJ7bU2PONdWsHu2Iq6fMd+Jgvt/MC1k5xGo8Ily0WVFfdc
         EUWqE+OltdBWQb0SGEZX5SPagsh7+WcmOcvXBLNY=
Received: from EX-SZ064.tencent.com (10.28.6.16) by EX-SZ020.tencent.com
 (10.28.6.40) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2242.4; Tue, 22 Nov
 2022 11:52:22 +0800
Received: from EX-SZ066.tencent.com (10.28.6.18) by EX-SZ064.tencent.com
 (10.28.6.16) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2242.4; Tue, 22 Nov
 2022 11:52:21 +0800
Received: from EX-SZ066.tencent.com ([fe80::d867:3d3d:29a0:f571]) by
 EX-SZ066.tencent.com ([fe80::d867:3d3d:29a0:f571%6]) with mapi id
 15.01.2242.008; Tue, 22 Nov 2022 11:52:21 +0800
From:   =?utf-8?B?a3lsZXpoYW8o6LW15p+v5a6HKQ==?= <kylezhao@tencent.com>
To:     Junio C Hamano <gitster@pobox.com>,
        Kyle Zhao via GitGitGadget <gitgitgadget@gmail.com>
CC:     "git@vger.kernel.org" <git@vger.kernel.org>,
        Elijah Newren <newren@gmail.com>,
        Taylor Blau <me@ttaylorr.com>,
        =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>
Subject: RE: [Internet]Re: [PATCH v7 1/2] merge-tree.c: add
 --merge-base=<commit> option
Thread-Topic: [Internet]Re: [PATCH v7 1/2] merge-tree.c: add
 --merge-base=<commit> option
Thread-Index: AQHY/h8k1bpyBk/0aUWLngHzLviDHK5KSUzQ
Date:   Tue, 22 Nov 2022 03:52:21 +0000
Message-ID: <3e5cdd224d76499bbddf55b0b649439b@tencent.com>
References: <pull.1397.v6.git.1667472621.gitgitgadget@gmail.com>
        <pull.1397.v7.git.1668210314.gitgitgadget@gmail.com>
        <1cf1c69b8e8e8e81eccc42b5d8efc605a36ab7eb.1668210314.git.gitgitgadget@gmail.com>
 <xmqqsfibsn9o.fsf@gitster.g>
In-Reply-To: <xmqqsfibsn9o.fsf@gitster.g>
Accept-Language: en-AS, zh-CN, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [10.99.17.237]
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

PiA+ICsJY29uc3QgY2hhciAqbWVyZ2VfYmFzZSA9IE5VTEw7DQo+ID4NCj4gPiAgCWNvbnN0IGNo
YXIgKiBjb25zdCBtZXJnZV90cmVlX3VzYWdlW10gPSB7DQo+ID4gIAkJTl8oImdpdCBtZXJnZS10
cmVlIFstLXdyaXRlLXRyZWVdIFs8b3B0aW9ucz5dIDxicmFuY2gxPg0KPiA+IDxicmFuY2gyPiIp
LCBAQCAtNTE1LDYgKzUzMywxMCBAQCBpbnQgY21kX21lcmdlX3RyZWUoaW50IGFyZ2MsIGNvbnN0
DQo+IGNoYXIgKiphcmd2LCBjb25zdCBjaGFyICpwcmVmaXgpDQo+ID4gIAkJCSAgICZvLnVzZV9z
dGRpbiwNCj4gPiAgCQkJICAgTl8oInBlcmZvcm0gbXVsdGlwbGUgbWVyZ2VzLCBvbmUgcGVyIGxp
bmUgb2YgaW5wdXQiKSwNCj4gPiAgCQkJICAgUEFSU0VfT1BUX05PTkVHKSwNCj4gPiArCQlPUFRf
U1RSSU5HKDAsICJtZXJnZS1iYXNlIiwNCj4gPiArCQkJICAgJm1lcmdlX2Jhc2UsDQo+ID4gKwkJ
CSAgIE5fKCJjb21taXQiKSwNCj4gPiArCQkJICAgTl8oInNwZWNpZnkgYSBtZXJnZS1iYXNlIGZv
ciB0aGUgbWVyZ2UiKSksDQo+ID4gIAkJT1BUX0VORCgpDQo+ID4gIAl9Ow0KPiANCj4gVGhpcyBs
b29rcyB3cm9uZywgdGhvdWdoLg0KPiANCj4gU2hvdWxkbid0ICJnaXQgbWVyZ2UtdHJlZSAtLW1l
cmdlLWJhc2U9WCAtLW1lcmdlLWJhc2U9WSBBIEIiDQo+IGFsbG93IHlvdSB0byBjb21wdXRlIHRo
ZSBtZXJnZSBiZXR3ZWVuIEEgYW5kIEIgaW4gYSBoaXN0b3J5IHdoZXJlIHRoZXJlIGFyZQ0KPiB0
d28gbWVyZ2UgYmFzZXM/DQo+IA0KPiBVbmZvcnR1bmF0ZWx5IHRoaXMgaXMgYWxyZWFkeSBpbiAn
bmV4dCcsIHNvIGxldCdzIHNlZSBhbiBpbmNyZW1lbnRhbCBmaXggb24gdG9wLg0KPiANCj4gVGhh
bmtzLg0KDQpJIGFncmVlLg0KDQpPUFRfU1RSSU5HIG9ubHkgdXNlIHRoZSBsYXN0IHZhbHVlIG9m
ICItLW1lcmdlLWJhc2UiLg0KSXQgd2lsbCBtaXNsZWFkIHVzZXJzLCB0aGV5IG1heSBzcGVjaWZ5
IHRoZSBtZXJnZS1iYXNlIG11bHRpcGxlIHRpbWVzLCBidXQgZm91bmQgaXQgZG9lc24ndCB3b3Jr
Lg0KDQpJIHdlbnQgdG8gY2hlY2sgdGhlIGFwaS1wYXJzZS1vcHRpb24udHh0LCBidXQgSSBkaWRu
J3QgZm91bmQgYW4gZWxlZ2FudCBzb2x1dGlvbiB0byBzdG9wIHdoZW4gdGhlIHVzZXJzIHVzZXMg
dGhlDQpzZWNvbmQgIi0tbWVyZ2UtYmFzZSIuICBEaWQgSSBtaXNzIGl0PyBPciB3ZSBqdXN0IG5l
ZWQgdG8gbWVudGlvbiB0aGlzIGluIHRoZSBnaXQtbWVyZ2UtdHJlZS50eHQsDQpzdWNoIGFzOg0K
IC0tbWVyZ2UtYmFzZT08Y29tbWl0Pjo6DQogCUluc3RlYWQgb2YgZmluZGluZyB0aGUgbWVyZ2Ut
YmFzZXMgZm9yIDxicmFuY2gxPiBhbmQgPGJyYW5jaDI+LA0KLQlzcGVjaWZ5IGEgbWVyZ2UtYmFz
ZSBmb3IgdGhlIG1lcmdlLg0KKyAgICAgICAgICAgIHNwZWNpZnkgYSBtZXJnZS1iYXNlIGZvciB0
aGUgbWVyZ2UuIFRoaXMgb3B0aW9uIGRvZXNuJ3Qgc3VwcG9ydA0KKyAgICAgICAgICAgIGJlaW5n
IHNwZWNpZmllZCBtdWx0aXBsZSB0aW1lcywgb25seSB0aGUgbGFzdCB2YWx1ZSB5b3UgcHJvdmlk
ZSB3aWxsIGJlIHVzZWQuDQoNCg0KVGhhbmtzLA0KS3lsZQ0KDQo=
