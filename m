Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A741CC433FE
	for <git@archiver.kernel.org>; Thu,  3 Nov 2022 09:44:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230426AbiKCJoL (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 3 Nov 2022 05:44:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54836 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230094AbiKCJoH (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 3 Nov 2022 05:44:07 -0400
Received: from mail10.tencent.com (mail10.tencent.com [14.18.183.58])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 40775EE32
        for <git@vger.kernel.org>; Thu,  3 Nov 2022 02:43:54 -0700 (PDT)
Received: from EX-SZ019.tencent.com (unknown [10.28.6.74])
        by mail10.tencent.com (Postfix) with ESMTP id AFD732A666;
        Thu,  3 Nov 2022 17:43:51 +0800 (CST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=tencent.com;
        s=s202002; t=1667468631;
        bh=GUI3mLxD0fYEC1qGtQM6cV4FyULUZdYK2Z/7UNnFqFE=;
        h=From:To:CC:Subject:Date:References:In-Reply-To;
        b=m8j1glQGGoEsain3kAS6aZo1J/oR27QSceAaqvsvsr35QxVeYXCww6RRK1rfZjzR5
         UzUnkKDgJycYJ/AgR6Q9KlOWjb8DZeArw8Yg1+jbN4wbI+UbiFz0WQdEEOTBa7nv9N
         Ze/2q3lGXqTi6cUq5JxOjtH5dvcSkql83GBHCPvY=
Received: from EX-SZ065.tencent.com (10.28.6.17) by EX-SZ019.tencent.com
 (10.28.6.74) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2242.4; Thu, 3 Nov 2022
 17:43:50 +0800
Received: from EX-SZ066.tencent.com (10.28.6.18) by EX-SZ065.tencent.com
 (10.28.6.17) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2242.4; Thu, 3 Nov 2022
 17:43:50 +0800
Received: from EX-SZ066.tencent.com ([fe80::d867:3d3d:29a0:f571]) by
 EX-SZ066.tencent.com ([fe80::d867:3d3d:29a0:f571%6]) with mapi id
 15.01.2242.008; Thu, 3 Nov 2022 17:43:49 +0800
From:   =?utf-8?B?a3lsZXpoYW8o6LW15p+v5a6HKQ==?= <kylezhao@tencent.com>
To:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>,
        "Kyle Zhao via GitGitGadget" <gitgitgadget@gmail.com>
CC:     "git@vger.kernel.org" <git@vger.kernel.org>,
        Elijah Newren <newren@gmail.com>, Taylor Blau <me@ttaylorr.com>
Subject: RE: [Internet]Re: [PATCH v5 1/2] merge-tree.c: add
 --merge-base=<commit> option
Thread-Topic: [Internet]Re: [PATCH v5 1/2] merge-tree.c: add
 --merge-base=<commit> option
Thread-Index: AQHY71+oK/qP2v0Uo02b8o8Yd6/OuK4s8S/w
Date:   Thu, 3 Nov 2022 09:43:49 +0000
Message-ID: <11e8532a5ba746e2b25e689c5d1230cf@tencent.com>
References: <pull.1397.v4.git.1667292904.gitgitgadget@gmail.com>
 <pull.1397.v5.git.1667446182.gitgitgadget@gmail.com>
 <01df0d1a6a7319beada3a3a94b8e36818be2a4d2.1667446182.git.gitgitgadget@gmail.com>
 <221103.868rks301x.gmgdl@evledraar.gmail.com>
In-Reply-To: <221103.868rks301x.gmgdl@evledraar.gmail.com>
Accept-Language: en-AS, zh-CN, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [10.99.16.13]
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

PiANCj4gPiBbLi4uXQ0KPiA+ICt0ZXN0X2V4cGVjdF9zdWNjZXNzICdzcGVjaWZ5IG1lcmdlLWJh
c2UgYXMgcGFyZW50IG9mIGJyYW5jaDInICcNCj4gPiArCSMgU2V0dXANCj4gPiArCWdpdCBpbml0
IGJhc2UtYjItcCAmJiAoDQo+IA0KPiBJdCdzIGdvb2QgcHJhY3RpY2UgdG8gbnVrZSBpdCBhZnRl
ciB0aGUgdGVzdDoNCj4gDQo+IAl0ZXN0X3doZW5fZmluaXNoZWQgInJtIC1yZiBiYXNlLWIyLXAi
ICYmDQo+IAlnaXQgaW5pdCBiYXNlLWIyLXANCj4gDQo+IA0KDQpUaGFua3MgZm9yIHRoZSByZXZp
ZXdzLCBJJ2xsIGZpeCBpdCBpbiB0aGUgbmV4dCBwYXRjaC4NCg0KPiANCj4gQ291bGQgYXZvaWQg
dGhlIHN1YnNoZWxsLWluZyB3aXRoOg0KPiANCj4gCXRlc3RfY29tbWl0IC1DIGJhc2UtYjItcCBj
MSBmaWxlMSAmJg0KPiAJWy4uLl0NCg0KTmljZS4NCg0KDQo=
