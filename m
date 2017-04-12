Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 765051FA14
	for <e@80x24.org>; Wed, 12 Apr 2017 15:37:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754101AbdDLPhs (ORCPT <rfc822;e@80x24.org>);
        Wed, 12 Apr 2017 11:37:48 -0400
Received: from mail-bn3nam01on0109.outbound.protection.outlook.com ([104.47.33.109]:36533
        "EHLO NAM01-BN3-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1752384AbdDLPhq (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 12 Apr 2017 11:37:46 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector1; h=From:Date:Subject:Message-ID:Content-Type:MIME-Version;
 bh=HrE1EVYtUDBG/um9BFK0M/96JbhkObnBcu3msotYQog=;
 b=nSkBvNqHAIraEfxyGa5Ll6hL4RF8WupligKJWo9FyYdo2FwmbaA1EvJhyqz09YGcWErBimp7sqeEgat9bXqA1PpRFuJw8qjRWYoCt6ue1gW/NP9BkKW6Gb/7SHl+drhEsnr6zuwpc9SFLdLQ6oBSm2lHC2e2fpN9Rdzd4Tav/CE=
Received: from SN2PR03MB2333.namprd03.prod.outlook.com (10.166.210.136) by
 SN2PR03MB2333.namprd03.prod.outlook.com (10.166.210.136) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id
 15.1.1034.10; Wed, 12 Apr 2017 15:37:44 +0000
Received: from SN2PR03MB2333.namprd03.prod.outlook.com ([10.166.210.136]) by
 SN2PR03MB2333.namprd03.prod.outlook.com ([10.166.210.136]) with mapi id
 15.01.1034.011; Wed, 12 Apr 2017 15:37:44 +0000
From:   Kevin Willford <kewillf@microsoft.com>
To:     Duy Nguyen <pclouds@gmail.com>
CC:     Kevin Willford <kcwillford@gmail.com>,
        "git@vger.kernel.org" <git@vger.kernel.org>,
        "gitster@pobox.com" <gitster@pobox.com>,
        "peff@peff.net" <peff@peff.net>
Subject: RE: [PATCH 3/3] reset.c: update files when using sparse to avoid data
 loss.
Thread-Topic: [PATCH 3/3] reset.c: update files when using sparse to avoid
 data loss.
Thread-Index: AQHSr9SG2d/PxqpiCkGFIsgEf/85JqG+aZyAgAJC7XCAARMaAIAAIOZw
Date:   Wed, 12 Apr 2017 15:37:43 +0000
Message-ID: <SN2PR03MB2333B9A0A7A3888F0402594DB7030@SN2PR03MB2333.namprd03.prod.outlook.com>
References: <20170407192357.948-1-kewillf@microsoft.com>
 <20170407192357.948-4-kewillf@microsoft.com> <20170410102429.GB19325@ash>
 <SN2PR03MB2333BCFD2E1A6A400706F94CB7000@SN2PR03MB2333.namprd03.prod.outlook.com>
 <CACsJy8Dw8qfS6G71y3FoT9w7H=FABMx=5R=v8JcPCEHtv1vLcw@mail.gmail.com>
In-Reply-To: <CACsJy8Dw8qfS6G71y3FoT9w7H=FABMx=5R=v8JcPCEHtv1vLcw@mail.gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: gmail.com; dkim=none (message not signed)
 header.d=none;gmail.com; dmarc=none action=none header.from=microsoft.com;
x-originating-ip: [184.155.115.67]
x-microsoft-exchange-diagnostics: 1;SN2PR03MB2333;7:22cc9A0fIF5Z5fQwOGsMBHpCh4NhhhMMm02Nmq/qrU6aMfroNNMldwm7Xl6ybypcSPDw5QeHxHQ8ERTWlJrn379qCCM/eZPmOP+BQmdPD5yr63VGs7yROV5mEXylJNLI2h0WQxkQe5tVqX0FwnmUDIWQT5ZrXgh5x/5AITYAxLqqGObLyl+5no2WZ1ZuiHmPTPx6UI9UuhThop9pLLlgnj5Y67yRJucT5ehfNV1F2UYL7fD2RC4VdrqmD42msMnKHn7JOzBaeau2H8AoqfJ5YjB5FU2cEyOa8mQ7obXHb8cxAxyUFMVoYZW2pNatX2FcN23da0dWw/GrWjrwZoBJ8Q5M2AEhFIWg7+8T9712sEM=
x-ms-office365-filtering-correlation-id: 70fb3715-e148-4579-508e-08d481b9dd08
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: UriScan:;BCL:0;PCL:0;RULEID:(22001)(2017030254075)(48565401081)(201703131423075)(201703031133081);SRVR:SN2PR03MB2333;
x-microsoft-antispam-prvs: <SN2PR03MB2333181D159AC63C120008A9B7030@SN2PR03MB2333.namprd03.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(9452136761055)(100324003535756);
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(61425038)(6040450)(601004)(2401047)(5005006)(8121501046)(10201501046)(93006095)(93001095)(3002001)(6055026)(61426038)(61427038)(6041248)(20161123560025)(20161123562025)(201703131423075)(201702281528075)(201703061421075)(20161123564025)(20161123555025)(6072148);SRVR:SN2PR03MB2333;BCL:0;PCL:0;RULEID:;SRVR:SN2PR03MB2333;
x-forefront-prvs: 027578BB13
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(6009001)(39850400002)(39400400002)(39410400002)(39840400002)(39860400002)(39450400003)(24454002)(13464003)(377454003)(99286003)(8990500004)(54906002)(10290500002)(5005710100001)(189998001)(9686003)(6436002)(2906002)(7696004)(6246003)(8936002)(5660300001)(39060400002)(77096006)(86612001)(4326008)(6506006)(38730400002)(93886004)(110136004)(3280700002)(229853002)(1411001)(53936002)(81166006)(8656002)(86362001)(74316002)(10090500001)(55016002)(102836003)(15650500001)(2900100001)(3660700001)(6916009)(6116002)(66066001)(3846002)(2950100002)(8676002)(53546009)(25786009)(7736002)(122556002)(54356999)(76176999)(50986999)(33656002)(305945005);DIR:OUT;SFP:1102;SCL:1;SRVR:SN2PR03MB2333;H:SN2PR03MB2333.namprd03.prod.outlook.com;FPR:;SPF:None;MLV:ovrnspm;PTR:InfoNoRecords;LANG:en;
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-originalarrivaltime: 12 Apr 2017 15:37:44.0172
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN2PR03MB2333
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

DQo+IC0tLS0tT3JpZ2luYWwgTWVzc2FnZS0tLS0tDQo+IEZyb206IGdpdC1vd25lckB2Z2VyLmtl
cm5lbC5vcmcgW21haWx0bzpnaXQtb3duZXJAdmdlci5rZXJuZWwub3JnXSBPbg0KPiBCZWhhbGYg
T2YgRHV5IE5ndXllbg0KPiBTZW50OiBXZWRuZXNkYXksIEFwcmlsIDEyLCAyMDE3IDc6MjEgQU0N
Cj4gVG86IEtldmluIFdpbGxmb3JkIDxrZXdpbGxmQG1pY3Jvc29mdC5jb20+DQo+IENjOiBLZXZp
biBXaWxsZm9yZCA8a2N3aWxsZm9yZEBnbWFpbC5jb20+OyBnaXRAdmdlci5rZXJuZWwub3JnOw0K
PiBnaXRzdGVyQHBvYm94LmNvbTsgcGVmZkBwZWZmLm5ldA0KPiBTdWJqZWN0OiBSZTogW1BBVENI
IDMvM10gcmVzZXQuYzogdXBkYXRlIGZpbGVzIHdoZW4gdXNpbmcgc3BhcnNlIHRvIGF2b2lkDQo+
IGRhdGEgbG9zcy4NCj4gDQo+IE9uIFdlZCwgQXByIDEyLCAyMDE3IGF0IDU6MzAgQU0sIEtldmlu
IFdpbGxmb3JkIDxrZXdpbGxmQG1pY3Jvc29mdC5jb20+DQo+IHdyb3RlOg0KPiA+IFRoZSBsb3Nz
IG9mIHRoZSBza2lwLXdvcmt0cmVlIGJpdHMgaXMgcGFydCBvZiB0aGUgcHJvYmxlbSBpZiB5b3Ug
YXJlDQo+ID4gdGFsa2luZyBhYm91dCBtb2RpZmllZCBmaWxlcy4gIFRoZSBvdGhlciBpc3N1ZSB0
aGF0IEkgd2FzIGhhdmluZyBpcw0KPiA+IHdoZW4gcnVubmluZyBhIHJlc2V0IGFuZCB0aGVyZSB3
ZXJlIGZpbGVzIGFkZGVkIGluIHRoZSBjb21taXQgdGhhdCBpcw0KPiA+IGJlaW5nIHJlc2V0LCB0
aGVyZSB3aWxsIG5vdCBiZSBhbiBlbnRyeSBpbiB0aGUgaW5kZXggYW5kIG5vdCBhIGZpbGUgb24N
Cj4gPiBkaXNrIHNvIHRoZSBkYXRhIGZvciB0aGF0IGZpbGUgaXMgY29tcGxldGVseSBsb3N0IGF0
IHRoYXQgcG9pbnQuDQo+ID4gInN0YXR1cyIgYWxzbyBkb2Vzbid0IGluY2x1ZGUgYW55dGhpbmcg
YWJvdXQgdGhpcyBsb3NzIG9mIGRhdGEuICBPbg0KPiA+IG1vZGlmaWVkIGZpbGVzIHN0YXR1cyB3
aWxsIGF0IGxlYXN0IGhhdmUgdGhlIGZpbGUgYXMgZGVsZXRlZCBzaW5jZQ0KPiA+IHRoZXJlIGlz
IHN0aWxsIGFuIGluZGV4IGVudHJ5IGJ1dCBhZ2FpbiB0aGUgcHJldmlvdXMgdmVyc2lvbiBvZiB0
aGUgZmlsZSBhbmQgaXQncw0KPiBkYXRhIGlzIGxvc3QuDQo+IA0KPiBXZWxsLCB3ZSBjb3VsZCBo
YXZlICJkZWxldGVkIiBpbmRleCBlbnRyaWVzLCB0aG9zZSBtYXJrZWQgd2l0aA0KPiBDRV9SRU1P
VkUuIFRoZXkgYXJlIG5ldmVyIHdyaXR0ZW4gZG93biB0byBmaWxlIHRob3VnaCwgc28gJ3N0YXR1
cycNCj4gd29uJ3QgYmVuZWZpdCBmcm9tIHRoYXQuIEhvcGVmdWxseSB3ZSBjYW4gcmVzdG9yZSB0
aGUgZmlsZSBiZWZvcmUgdGhlIGluZGV4DQo+IGZpbGUgaXMgd3JpdHRlbiBkb3duIGFuZCB3ZSBy
ZWFsbHkgbG9zZSBza2lwLXdvcmt0cmVlIGJpdHM/DQoNCkJlY2F1c2UgdGhpcyBpcyBhIHJlc2V0
IC0tbWl4ZWQgaXQgd2lsbCBuZXZlciBydW4gdGhyb3VnaCB1bnBhY2tfdHJlZXMgYW5kIA0KVGhl
IGVudHJpZXMgYXJlIG5ldmVyIG1hcmtlZCB3aXRoIENFX1JFTU9WRS4NCg0KPiANCj4gPiBUbyBt
ZSB0aGlzIGlzIHRvdGFsbHkgdW5leHBlY3RlZCBiZWhhdmlvciwgZm9yIGV4YW1wbGUgaWYgSSBh
bSBvbiBhDQo+ID4gY29tbWl0IHdoZXJlIHRoZXJlIGFyZSBvbmx5IGZpbGVzIHRoYXQgd2hlcmUg
YWRkZWQgYW5kIHJ1biBhIHJlc2V0DQo+ID4gSEVBRH4xIGFuZCB0aGVuIGEgc3RhdHVzLCBpdCB3
aWxsIHNob3cgYSBjbGVhbiB3b3JraW5nIGRpcmVjdG9yeS4NCj4gPiBSZWdhcmRsZXNzIG9mIHNr
aXAtd29ya3RyZWUgYml0cyB0aGUgdXNlciBuZWVkcyB0byBoYXZlIHRoZSBkYXRhIGluDQo+ID4g
dGhlIHdvcmtpbmcgZGlyZWN0b3J5IGFmdGVyIHRoZSByZXNldCBvciBkYXRhIGlzIGxvc3Qgd2hp
Y2ggaXMgYWx3YXlzIGJhZC4NCj4gDQo+IEkgYWdyZWUgd2Ugbm8gbG9uZ2VyIGhhdmUgYSBwbGFj
ZSB0byBzYXZlIHRoZSBza2lwLXdvcmt0cmVlIGJpdCwgd2UgaGF2ZSB0bw0KPiByZXN0b3JlIHRo
ZSBzdGF0ZSBiYWNrIGFzIGlmIHNraXAtd29ya3RyZWUgYml0IGRvZXMgbm90IGV4aXN0Lg0KPiBJ
dCB3b3VsZCBiZSBnb29kIGlmIHdlIGNvdWxkIGtlZXAgdGhlIGxvZ2ljIGluIHVucGFja190cmVl
cygpIHRob3VnaC4NCj4gRm9yIGV4YW1wbGUsIGlmIHRoZSBmaWxlIGlzIHByZXNlbnQgb24gZGlz
ayBldmVuIGlmIHNraXAtd29ya3RyZWUgYml0IGlzIG9uLA0KPiB1bnBhY2tfdHJlZXMoKSB3b3Vs
ZCBhYm9ydCBpbnN0ZWFkIG9mIHNpbGVudGx5IG92ZXJ3cml0aW5nIGl0Lg0KPiBUaGlzIGlzIGEg
ZGlmZmVyZW5jZSBiZXR3ZWVuIHNraXAtd29ya3RyZWUgYW5kIGFzc3VtZS11bmNoYW5nZWQgYml0
cy4NCj4gSWYgeW91IGRvIGV4cGxpY2l0IGNoZWNrb3V0X2VudHJ5KCkgeW91IG1pZ2h0IGhhdmUg
dG8gYWRkIG1vcmUgY2hlY2tzIHRvDQo+IGtlZXAgYmVoYXZpb3IgY29uc2lzdGVudC4NCj4gLS0N
Cj4gRHV5DQoNCkJlY2F1c2UgdGhpcyBpcyBhIHJlc2V0IC0tbWl4ZWQgaXQgd2lsbCBmb2xsb3cg
dGhlIGNvZGUgcGF0aCBjYWxsaW5nIHJlYWRfZnJvbV90cmVlDQphbmQgZW5kcyB1cCBjYWxsaW5n
IHVwZGF0ZV9pbmRleF9mcm9tX2RpZmYgaW4gdGhlIGZvcm1hdF9jYWxsYmFjayBvZiB0aGUgZGlm
ZiwNCnNvIHVucGFja190cmVlcygpIGlzIG5ldmVyIGNhbGxlZCBpbiB0aGUgLS1taXhlZCBjYXNl
LiAgVGhpcyBjb2RlIGNoYW5nZSBhbHNvIG9ubHkgYXBwbGllcw0Kd2hlbiB0aGUgZmlsZSBkb2Vz
IG5vdCBleGlzdCBhbmQgdGhlIHNraXAtd29ya3RyZWUgYml0IGlzIG9uIGFuZCB0aGUgdXBkYXRl
ZCANCmluZGV4IGVudHJ5IGVpdGhlciB3aWxsIGJlIG1pc3NpbmcgKGNvdmVycyB0aGUgYWRkZWQg
c2NlbmFyaW8pIG9yIHdhcyBub3QgbWlzc2luZw0KYmVmb3JlIChjb3ZlcnMgdGhlIG1vZGlmaWVk
IHNjZW5hcmlvKS4gIElmIHRoZXJlIGlzIGEgYmV0dGVyIHdheSB0byBnZXQgdGhlIHByZXZpb3Vz
DQppbmRleCBlbnRyeSB0byBkaXNrIHRoYW4gd2hhdCBJIGFtIGRvaW5nLCBJIGFtIGhhcHB5IHRv
IGltcGxlbWVudCBpdCBjb3JyZWN0bHkuDQoNClRoYW5rcywNCktldmluDQo=
