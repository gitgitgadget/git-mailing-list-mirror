Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B3ED9ECAAA1
	for <git@archiver.kernel.org>; Fri, 28 Oct 2022 12:21:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230062AbiJ1MVR (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 28 Oct 2022 08:21:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56040 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230216AbiJ1MU7 (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 28 Oct 2022 08:20:59 -0400
X-Greylist: delayed 2204 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Fri, 28 Oct 2022 05:20:33 PDT
Received: from mail10.tencent.com (mail10.tencent.com [14.18.183.58])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E77F22B182
        for <git@vger.kernel.org>; Fri, 28 Oct 2022 05:20:32 -0700 (PDT)
Received: from EX-SZ018.tencent.com (unknown [10.28.6.39])
        by mail10.tencent.com (Postfix) with ESMTP id 28692D46D9;
        Fri, 28 Oct 2022 19:43:46 +0800 (CST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=tencent.com;
        s=s202002; t=1666957426;
        bh=+gFTp+AjWp4maNjxRhMQAqOpSZfJX5EGn/gw32InInw=;
        h=From:To:CC:Subject:Date:References:In-Reply-To;
        b=FlXHzuaAlXk0GwY4TR2AbekmbLTgo0ggO/tYQkDk6DVsm4tzgdwJr/oDwA1siP8Z5
         vIwoPO3HQD2X2wHPfDilth3+DzLCdIu0weXA0rhnSrMpHlbfqjS3rqjv1Pibu4ElU5
         YlbPYOtTKeqpO9El4jm3NbWUjveZhrUMIxl3OMM0=
Received: from EX-SZ093.tencent.com (10.28.6.65) by EX-SZ018.tencent.com
 (10.28.6.39) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2242.4; Fri, 28 Oct
 2022 19:43:46 +0800
Received: from EX-SZ066.tencent.com (10.28.6.18) by EX-SZ093.tencent.com
 (10.28.6.65) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2242.4; Fri, 28 Oct
 2022 19:43:45 +0800
Received: from EX-SZ066.tencent.com ([fe80::d867:3d3d:29a0:f571]) by
 EX-SZ066.tencent.com ([fe80::d867:3d3d:29a0:f571%6]) with mapi id
 15.01.2242.008; Fri, 28 Oct 2022 19:43:45 +0800
From:   =?gb2312?B?a3lsZXpoYW8o1dS/wtPuKQ==?= <kylezhao@tencent.com>
To:     Junio C Hamano <gitster@pobox.com>,
        Kyle Zhao via GitGitGadget <gitgitgadget@gmail.com>
CC:     "git@vger.kernel.org" <git@vger.kernel.org>
Subject: RE: [Internet]Re: [PATCH] merge-tree.c: add --merge-base=<commit>
 option
Thread-Topic: [Internet]Re: [PATCH] merge-tree.c: add --merge-base=<commit>
 option
Thread-Index: AQHY6i9PI8vlVzLUyE2GHEQ42aAfV64jr0UQ
Date:   Fri, 28 Oct 2022 11:43:45 +0000
Message-ID: <ad27a59046e345a68669d3876a75772a@tencent.com>
References: <pull.1397.git.1666872761355.gitgitgadget@gmail.com>
 <xmqqczadm93w.fsf@gitster.g>
In-Reply-To: <xmqqczadm93w.fsf@gitster.g>
Accept-Language: en-AS, zh-CN, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [10.99.16.12]
Content-Type: text/plain; charset="gb2312"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

VGhhbmtzIGZvciB5b3VyIHJldmlld3MuDQoNCj4gSW4gdGhlIG9yaWdpbmFsICJ0cml2aWFsIG1l
cmdlIiBtb2RlLCB0aGUgY29tbWFuZCB0YWtlcyB0aHJlZSB0cmVlcw0KPiB3aXRob3V0IGhhdmlu
ZyB0byBoYXZlIHRoaXMgbmV3IG9wdGlvbi4gIEluIHRoZSBuZXcgIndyaXRlLXRyZWUiDQo+IG1v
ZGUsIGN1cnJlbnRseSBpdCBpcyBpbmNhcGFibGUgb2YgdGFraW5nIHRoZSBiYXNlLCBidXQgaXQg
ZG9lcyBub3QNCj4gaGF2ZSB0byBzdGF5IHRoYXQgd2F5LiAgV291bGRuJ3QgaXQgYmUgc3VmZmlj
aWVudCB0byB1cGRhdGUgdGhlIFVJDQo+IHRvDQo+DQo+ICAgICBnaXQgbWVyZ2UtdHJlZSBbLS13
cml0ZS10cmVlXSBbPG9wdGlvbnM+XSBbPGJhc2UtY29tbWl0Pl0gPGJyYW5jaDE+IDxicmFuY2gy
Pg0KPiAgICAgZ2l0IG1lcmdlLXRyZWUgWy0tdHJpdmlhbC1tZXJnZV0gPGJhc2UtY29tbWl0PiA8
YnJhbmNoMT4gPGJyYW5jaDI+DQo+DQo+IElPVywgd2hlbiB5b3Ugd2FudCB0byBzdXBwbHkgdGhl
IGJhc2UsIHlvdSdkIGJlIGV4cGxpY2l0IGFuZCBhc2sgZm9yDQo+IHRoZSBuZXcgIndyaXRlLXRy
ZWUiIG1vZGUsIGkuZS4NCj4NCj4gICAgICQgZ2l0IG1lcmdlLXRyZWUgLS13cml0ZS10cmVlICQo
Z2l0IG1lcmdlLWJhc2UgYnJhbmNoXiBicmFuY2gpIEhFQUQgYnJhbmNoIA0KPg0KPiB3b3VsZCBi
ZSBob3cgeW91IHdvdWxkIHVzZSBtZXJnZS10cmVlIHRvIGNoZXJyeS1waWNrIHRoZSBjb21taXQg
YXQNCj4gdGhlIHRpcCBvZiB0aGUgYnJhbmNoIG9uIHRvcCBvZiB0aGUgY3VycmVudCBjb21taXQu
DQoNClJlZmVycmluZyB0byBOZXdyZW4ncyByZXBseSwgaWYgd2UgbmVlZCB0byBpbXBsZW1lbnQg
b2N0b3B1cyBtZXJnZXMgZm9yIGdpdC1tZXJnZS10cmVlIGluIHRoZSBmdXR1cmUsICBzdGlsbCBu
ZWVkIGEgbmV3IG9wdGlvbiwgDQpzbyBJIGhhdmVuJ3QgbW9kaWZpZWQgaXQgeWV0Lg0KDQo+PiBA
QCAtNDAyLDYgKzQwMyw3IEBAIHN0cnVjdCBtZXJnZV90cmVlX29wdGlvbnMgew0KPj4gIAlpbnQg
YWxsb3dfdW5yZWxhdGVkX2hpc3RvcmllczsNCj4+ICAJaW50IHNob3dfbWVzc2FnZXM7DQo+PiAg
CWludCBuYW1lX29ubHk7DQo+PiArCWNoYXIqIG1lcmdlX2Jhc2U7DQo+DQo+IFN0eWxlLiAgV2Ug
d3JpdGUgaW4gQywgbm90IGluIEMrKywgYW5kIG91ciBhc3Rlcmlza3Mgc3RpY2sgdG8gdmFyaWFi
bGVzIGFuZCBtZW1iZXJzIG9mIHN0cnVjdHMsIG5vdCB0eXBlcy4NCg0KRG9uZS4NCg0KDQo=
