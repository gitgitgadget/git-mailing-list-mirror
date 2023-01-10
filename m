Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1A8A8C54EBC
	for <git@archiver.kernel.org>; Tue, 10 Jan 2023 15:15:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233501AbjAJPPc (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 10 Jan 2023 10:15:32 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53240 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233364AbjAJPPa (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 10 Jan 2023 10:15:30 -0500
Received: from mx-out2.deshaw.net (mx-out2.deshaw.net [149.77.95.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 757571FF
        for <git@vger.kernel.org>; Tue, 10 Jan 2023 07:15:27 -0800 (PST)
Received: from mx-relay2.deshaw.net (localhost [127.0.0.1])
        by mx-out2.deshaw.net (Postfix) with ESMTPS id ADBE180CB24;
        Tue, 10 Jan 2023 10:15:26 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=deshaw.com; s=k001;
        t=1673363726; bh=9F6XW+m6uRXXrToEyFX5a9/a1AULqKJuo6jwZK+0kOY=;
        h=From:To:CC:Subject:Date:References:In-Reply-To:From;
        b=Rh3dV9I0z/561hep9CVU9f8s2MEdu81cufTmPQRa7I0wBxMlVbwGsZpx+YBWD60NH
         DotUZSkuVoc2n18Uga81I80t5NjkyBstHRbIj6g2bP2OrVuW597xp20dG3C7x/V/a4
         1DCYtb+TalhLSSppScRFv/H+yd1AVypR2sG4nt8o=
Received: from deshaw.com (mail-multi.nyc.deshaw.com [10.219.243.66])
        by mx-relay2.deshaw.net (Postfix) with ESMTPS id A81EE1407CD5;
        Tue, 10 Jan 2023 10:15:26 -0500 (EST)
Received: from exchmbxtoa1a.deshaw.com (exchmbxtoa1a.deshaw.com [10.219.74.16])
        by mail-multi.nyc.deshaw.com (Postfix) with ESMTPS id A07D81F2;
        Tue, 10 Jan 2023 10:15:26 -0500 (EST)
Received: from exchmbxtoa1b.deshaw.com (10.219.74.15) by
 exchmbxtoa1a.deshaw.com (10.219.74.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.16; Tue, 10 Jan 2023 10:15:26 -0500
Received: from exchmbxtoa1b.deshaw.com ([fe80::b55e:2430:4455:ec8c]) by
 exchmbxtoa1b.deshaw.com ([fe80::b55e:2430:4455:ec8c%8]) with mapi id
 15.01.2507.016; Tue, 10 Jan 2023 10:15:26 -0500
From:   "Shupak, Vitaly" <Vitaly.Shupak@deshaw.com>
To:     "brian m. carlson" <sandals@crustytoothpaste.net>
CC:     "git@vger.kernel.org" <git@vger.kernel.org>
Subject: RE: BUG: git prompt breaks with zsh < 5.0.6
Thread-Topic: BUG: git prompt breaks with zsh < 5.0.6
Thread-Index: AdkkTWwUKBHMF2rJR52T9tUx9MJG2AAX8JKAABYpUMA=
Date:   Tue, 10 Jan 2023 15:15:26 +0000
Message-ID: <f1610b3f00284e69a089d40c7182a8ab@deshaw.com>
References: <5807cdbe6d66427c9ff45ea78c2c1ffb@deshaw.com>
 <Y7ylHW8nrsT1eVtW@tapette.crustytoothpaste.net>
In-Reply-To: <Y7ylHW8nrsT1eVtW@tapette.crustytoothpaste.net>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [10.219.66.97]
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-Content-Scanned: Fidelis Mail
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

WWVzLCB0aGF0IHdvcmtzIHRvbw0KDQotLS0tLU9yaWdpbmFsIE1lc3NhZ2UtLS0tLQ0KRnJvbTog
YnJpYW4gbS4gY2FybHNvbiA8c2FuZGFsc0BjcnVzdHl0b290aHBhc3RlLm5ldD4gDQpTZW50OiBN
b25kYXksIEphbnVhcnkgOSwgMjAyMyA2OjM3IFBNDQpUbzogU2h1cGFrLCBWaXRhbHkgPFZpdGFs
eS5TaHVwYWtAZGVzaGF3LmNvbT4NCkNjOiBnaXRAdmdlci5rZXJuZWwub3JnDQpTdWJqZWN0OiBS
ZTogQlVHOiBnaXQgcHJvbXB0IGJyZWFrcyB3aXRoIHpzaCA8IDUuMC42DQoNCk9uIDIwMjMtMDEt
MDkgYXQgMTc6MTI6NTYsIFNodXBhaywgVml0YWx5IHdyb3RlOg0KPiBBIGNoYW5nZSB0byBnaXQt
cHJvbXB0LnNoIGluIHYyLjM4IHRvIHNob3cgcHJlc2VuY2Ugb2YgdW5yZXNvbHZlZCBjb25mbGlj
dHMgY29udGFpbnMgc3ludGF4IHdoaWNoIGlzIG5vdCB2YWxpZCB1bmRlciB6c2ggPCA1LjAuNi4g
VGhpcyB2ZXJzaW9uIG9mIHpzaCBpcyBvbGQsIGJ1dCBpcyBzdGlsbCB0aGUgZGVmYXVsdCBvbiBS
ZWRIYXQgNyBtYWNoaW5lcywgZm9yIGV4YW1wbGUuDQo+IA0KPiBUaGUgb2ZmZW5kaW5nIGJsb2Nr
IGlzOg0KPiANCj4gICAgICAgIGxvY2FsIGNvbmZsaWN0PSIiICMgc3RhdGUgaW5kaWNhdG9yIGZv
ciB1bnJlc29sdmVkIGNvbmZsaWN0cw0KPiAgICAgICAgaWYgW1sgIiR7R0lUX1BTMV9TSE9XQ09O
RkxJQ1RTVEFURX0iID09ICJ5ZXMiIF1dICYmDQo+ICAgICAgICAgICBbWyAkKGdpdCBscy1maWxl
cyAtLXVubWVyZ2VkIDI+L2Rldi9udWxsKSBdXTsgdGhlbg0KPiAgICAgICAgICAgICAgICBjb25m
bGljdD0ifENPTkZMSUNUIg0KPiAgICAgICAgZmkNCj4gDQo+IFtbICQoY29tbWFuZCkgXV0gc3lu
dGF4IGRvZXNuJ3Qgd29yayBpbiBvbGRlciB2ZXJzaW9uIG9mIHpzaCBhbmQgc2hvdWxkIHVzZSBb
WyAtbiAiJChjb21tYW5kKSIgXV0gaW5zdGVhZC4NCg0KRG9lcyBbICIkKGNvbW1hbmQpIiBdIHdv
cms/ICBJIHdvdWxkIGFzc3VtZSBzbywgYmVjYXVzZSB0aGF0J3MgaW4gUE9TSVguDQpJZiBzbywg
dGhhdCBtaWdodCBhbHNvIGJlIGEgdmFsaWQgYXBwcm9hY2ggc2luY2UgaXQgZG9lc24ndCBsb29r
IGxpa2Ugd2UgbmVlZCB0aGUgc3BlY2lhbCBiZWhhdmlvdXIgb2YgdGhlIGRvdWJsZS1icmFja2V0
IG9wZXJhdG9yLg0KLS0NCmJyaWFuIG0uIGNhcmxzb24gKGhlL2hpbSBvciB0aGV5L3RoZW0pDQpU
b3JvbnRvLCBPbnRhcmlvLCBDQQ0K
