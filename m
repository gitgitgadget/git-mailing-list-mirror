Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_NONE
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id D8D801F454
	for <e@80x24.org>; Mon, 11 Nov 2019 18:21:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726954AbfKKSVY (ORCPT <rfc822;e@80x24.org>);
        Mon, 11 Nov 2019 13:21:24 -0500
Received: from mail-eopbgr690124.outbound.protection.outlook.com ([40.107.69.124]:37895
        "EHLO NAM04-CO1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726845AbfKKSVX (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 11 Nov 2019 13:21:23 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=LetRJKn1KzM9M3zHN+qA4CmWZq6ezJmFmBA3WQQn35RwiFaBG4f0lImt88lsbXl3QSDfQB1lvDkAJTrXqfXuHenor77t1ryXGWejF3Ow+hAWsZcqxFt6zs8GxdY+EHSeWfe1Yy/9wWs33fMBrIdDlLbpLvdUXhmqSH44tvx7RCdwsRwRs5jOcZ+fbHkIMXeX0PunbPEXulG/Wm/tShId+fqAAWJr7EB/W2jG8cbDPRSY7s+3le8uTfaYg0KimegJUzbB609WGj5G6Hd4rbNN1nQHPgYA1YINCFjl463hT1oQvhRQv4NtatIKqK92pUmthi0Rgs+tWJvPJrIe8rCbpg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=pCGb2u+l5XBIOhiJvRIVOur8ecP6xZR1sqeLMcw2nPs=;
 b=ZCeu6iqOhPpVp1rJZNuVZB1h2Q+knIh18YtpFxuyodKBcvi1fDbvY9IJ6iv77UAnCjiWsvSg5qG1ckMs+9wDuS8Db9jULY4Jb3f5IiuG/x+ygAZR+4hrZQMhxVbPHG5hqlOoWxThlbWkGxJSwaxj3bepr/Z3n4y1vj0PwS8w1Ot+Y3KYL4FkjJY8hpldjSsWhqW8p5l+UA7hTjBjWyCLCIWQAYOWO86BtciYkhPFxbm+8GjHQiTcp6SQ9rWgUqCbNJBMQ7usgkBLjbCXxFUKjI4nmgHb7R2GAVqnwBsrCSe+wtjJYfmXpRJPot91GwA6kq8kCprCqGw9cYrsSSZ3RQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microsoft.com; dmarc=pass action=none
 header.from=microsoft.com; dkim=pass header.d=microsoft.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=pCGb2u+l5XBIOhiJvRIVOur8ecP6xZR1sqeLMcw2nPs=;
 b=BC7nextBrG4llQ28JwzuzVDLMB27EMh2w37HHUUND03xKsnEnSPVGNrMTwissANKEvnOyZoYQxCowbwi6hxaKy6lx7h8K1kZr3Mhz5NRjIc/aLF4icUHyySs/a1ND7/p28sexuC5B++0KmrJk7MZXeKXcYHopht1A9eDOwUkG3M=
Received: from BN6PR21MB0786.namprd21.prod.outlook.com (10.175.132.14) by
 BN6PR21MB0835.namprd21.prod.outlook.com (10.173.205.13) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2451.21; Mon, 11 Nov 2019 18:21:20 +0000
Received: from BN6PR21MB0786.namprd21.prod.outlook.com
 ([fe80::48c9:e508:91f4:78a5]) by BN6PR21MB0786.namprd21.prod.outlook.com
 ([fe80::48c9:e508:91f4:78a5%6]) with mapi id 15.20.2451.018; Mon, 11 Nov 2019
 18:21:20 +0000
From:   Kevin Willford <Kevin.Willford@microsoft.com>
To:     Utsav Shah <ukshah2@illinois.edu>
CC:     Junio C Hamano <gitster@pobox.com>,
        Utsav Shah via GitGitGadget <gitgitgadget@gmail.com>,
        William Baker <William.Baker@microsoft.com>,
        "git@vger.kernel.org" <git@vger.kernel.org>
Subject: RE: [PATCH 0/1] fsmonitor: skip sanity check if the index is split
Thread-Topic: [PATCH 0/1] fsmonitor: skip sanity check if the index is split
Thread-Index: AQHVlgN2N/HqI42iV0qrhHi8d+RSPaeFNvObgAAE2KKAAOHjoIAAIGCAgAAHwkA=
Date:   Mon, 11 Nov 2019 18:21:19 +0000
Message-ID: <BN6PR21MB078648200A11238D0FD992FC91740@BN6PR21MB0786.namprd21.prod.outlook.com>
References: <pull.458.git.1573196960.gitgitgadget@gmail.com>
 <xmqqh83bjig6.fsf@gitster-ct.c.googlers.com>
 <xmqqa793jhne.fsf@gitster-ct.c.googlers.com>
 <BN6PR21MB07869E8D1DCAF189C4E472A891740@BN6PR21MB0786.namprd21.prod.outlook.com>
 <CABhpXbdyfxF3xVrjHUDzN7inu6O+CVVxG1wc9shhy33XiDoNPA@mail.gmail.com>
In-Reply-To: <CABhpXbdyfxF3xVrjHUDzN7inu6O+CVVxG1wc9shhy33XiDoNPA@mail.gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Kevin.Willford@microsoft.com; 
x-originating-ip: [174.126.253.32]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 4fbbedbd-eabf-4f26-9e48-08d766d3f348
x-ms-traffictypediagnostic: BN6PR21MB0835:|BN6PR21MB0835:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <BN6PR21MB08351626CF0F6C98B91C58C391740@BN6PR21MB0835.namprd21.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:8882;
x-forefront-prvs: 0218A015FA
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(39860400002)(366004)(346002)(376002)(396003)(136003)(189003)(199004)(54094003)(305945005)(14454004)(74316002)(6506007)(229853002)(2906002)(7736002)(8936002)(33656002)(10290500003)(6436002)(86362001)(4326008)(6246003)(6306002)(102836004)(9686003)(8676002)(5660300002)(52536014)(6916009)(55016002)(25786009)(66066001)(2171002)(53546011)(99286004)(26005)(186003)(66556008)(486006)(66446008)(64756008)(76176011)(10090500001)(476003)(7696005)(316002)(22452003)(66476007)(71190400001)(54906003)(11346002)(8990500004)(446003)(81166006)(81156014)(478600001)(256004)(14444005)(966005)(71200400001)(6116002)(76116006)(3846002)(66946007);DIR:OUT;SFP:1102;SCL:1;SRVR:BN6PR21MB0835;H:BN6PR21MB0786.namprd21.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: microsoft.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: /uLjvm866TC7XqnP2Zm304HJ2CLsXxpK6Q9aKNJ7PiPgiZKhR4W6PlqolePRPjqDACiJJlvSZzgndrQPNLlrbRRCmBiJB67yY5BYsARzrhySb7tLBN9Z65J5sbO9zmFenv0aGGTI7jFTYH3e3D9PXc4557eCMIBpcyJ4ci2DpgfCYtp7kWqnDKZrdZ2pPJHy1lsBnMspdQJ4z2GlD2gjoAgkDRvYLI+n5UAyFbZMP7GaJ0p2/mybbd7qyaKNMdhjq4OW7Cqlg730tgEKnPuV5EdVrj+ErwY6mes74G/zOWbW/gvAQCCJ+vu1YqIYbmr+4hAle0y+o4oFfq0wSJML8DVFpkVFR9IuUbHFJDwjp14DqOTI2LSkBrm/qGB+JgCd9fMClvUz5ccBXvHzdiIYYa8gvndCBksbBkgHAZLelbDBOKyDCmTZKiY82H7Y50rC
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4fbbedbd-eabf-4f26-9e48-08d766d3f348
X-MS-Exchange-CrossTenant-originalarrivaltime: 11 Nov 2019 18:21:19.9850
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: XqNkMBtMdbL2q91rp8Fc7bWTbFyvtpEUepvuEp8KCt6+5/fmBIPikyliX5XM8DB8XFinXdMo2daMTtnTSgXk7A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN6PR21MB0835
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

PiBGcm9tOiBVdHNhdiBTaGFoIDx1a3NoYWgyQGlsbGlub2lzLmVkdT4NCj4gU2VudDogTW9uZGF5
LCBOb3ZlbWJlciAxMSwgMjAxOSAxMDoyNiBBTQ0KPiANCj4gT24gTW9uLCBOb3YgMTEsIDIwMTkg
YXQgODo1NSBBTSBLZXZpbiBXaWxsZm9yZA0KPiA8S2V2aW4uV2lsbGZvcmRAbWljcm9zb2Z0LmNv
bT4gd3JvdGU6DQo+ID4NCj4gPiA+IEZyb206IGdpdC1vd25lckB2Z2VyLmtlcm5lbC5vcmcgPGdp
dC1vd25lckB2Z2VyLmtlcm5lbC5vcmc+IE9uDQo+ID4gPiBCZWhhbGYgT2YgSnVuaW8gQyBIYW1h
bm8NCj4gPiA+IFNlbnQ6IFN1bmRheSwgTm92ZW1iZXIgMTAsIDIwMTkgNzowMSBQTQ0KPiA+ID4N
Cj4gPiA+IEp1bmlvIEMgSGFtYW5vIDxnaXRzdGVyQHBvYm94LmNvbT4gd3JpdGVzOg0KPiA+ID4N
Cj4gPiA+ID4gIlV0c2F2IFNoYWggdmlhIEdpdEdpdEdhZGdldCIgPGdpdGdpdGdhZGdldEBnbWFp
bC5jb20+IHdyaXRlczoNCj4gPiA+ID4NCj4gPiA+ID4+IEF0IHRoZSB2ZXJ5IGxlYXN0LCB0aGlz
IHBhdGNoIG1pdGlnYXRlcyBhbiBvdmVyLWVhZ2VyIGNoZWNrIGZvcg0KPiA+ID4gPj4gc3BsaXQg
aW5kZXggdXNlcnMgd2hpbGUgbWFpbnRhaW5pbmcgZ29vZCBpbnZhcmlhbnRzIGZvciB0aGUgc3Rh
bmRhcmQNCj4gY2FzZS4NCj4gPiA+ID4NCj4gPiA+ID4gT0ssIGl0IHNvdW5kcyBtb3JlIGxpa2Ug
dGhpcyAiaXQgZG9lcyBub3QgbWFrZSBhbnkgc2Vuc2UgdG8NCj4gPiA+ID4gY29tcGFyZSB0aGUg
cG9zaXRpb24gaW4gdGhlIGZzbW9uaXRvciBiaXRtYXAgKHdoaWNoIGNvdmVycyB0aGUNCj4gPiA+
ID4gZW50aXJlIHRoaW5nKSB3aXRoIHRoZSBwb3NpdGlvbiBpbiBqdXN0IGEgc3BsaXQgcGFydCBv
ZiB0aGUgaW5kZXgNCj4gPiA+ID4gKHdoaWNoIGNvdmVycyBvbmx5IHRoZSBkZWx0YSBvdmVyIHRo
ZSBiYXNlIGluZGV4KSI/ICBJZiB0aGF0IGlzDQo+ID4gPiA+IHRoZSBjYXNlLCBpdCBtZWFucyB0
aGF0IHRoZSAiY2hlY2siIGlzIGV2ZW4gd29yc2UgdGhhbiBiZWluZw0KPiA+ID4gPiAib3Zlci1l
YWdlciItLS1pdCBzaW1wbHkgaXMgbm90IGNvcnJlY3QuDQo+ID4gPg0KPiA+ID4gSGF2aW5nIHNh
aWQgYWxsIHRoYXQsIEkgd29uZGVyIGlmIHdlIGFyZSBkb2luZyB0aGUgcmlnaHQgdGhpbmcgd2l0
aA0KPiA+ID4gb3Igd2l0aG91dCAzNDQ0ZWMyZSAoImZzbW9uaXRvcjogZG9uJ3QgZmlsbCBiaXRt
YXAgd2l0aCBlbnRyaWVzIHRvDQo+ID4gPiBiZSByZW1vdmVkIiwgMjAxOS0xMC0NCj4gPiA+IDEx
KSBpbiB0aGUgc3BsaXQtaW5kZXggbW9kZSBpbiB0aGUgZmlyc3QgcGxhY2UuDQo+ID4gPg0KPiA+
ID4gVGhlIGZhY3QgdGhhdCB5b3VyICJsb29zZW4gdGhlIGNoZWNrIGFuZCBhbGxvdyAncG9zJyB0
aGF0IGlkZW50aWZpZXMNCj4gPiA+IGEgdHJhY2tlZCBwYXRoIHVzZWQgYnkgdGhlIGZzbW9uaXRv
ciBiaXRtYXAgdG8gYmUgbGFyZ2VyIHRoYW4gdGhlDQo+ID4gPiBzaXplIG9mIHRoZSBpc3RhdGUt
DQo+ID4gPiA+Y2FjaGVbXSIgcGF0Y2ggdW5kZXIgZGlzY3Vzc2lvbiBpcyBuZWVkZWQgaXMgdGhh
dCAncG9zJyBtYXkNCj4gPiA+ID5zb21ldGltZXMgYmUNCj4gPiA+IGxhcmdlciB0aGFuIGlzYXRl
LT5jYWNoZVtdIG5vPyAgVGhlbiB3aGF0IGhhcHBlbnMgaW4gdGhpcyBodW5rLCBmb3INCj4gZXhh
bXBsZT8NCj4gPiA+DQo+ID4gPiBkaWZmIC0tZ2l0IGEvZnNtb25pdG9yLmMgYi9mc21vbml0b3Iu
YyBpbmRleCAyMzFlODNhOTRkLi4xZjRhYTFiMTUwDQo+ID4gPiAxMDA2NDQNCj4gPiA+IC0tLSBh
L2ZzbW9uaXRvci5jDQo+ID4gPiArKysgYi9mc21vbml0b3IuYw0KPiA+ID4gQEAgLTE0LDggKzE0
LDEzIEBAIHN0cnVjdCB0cmFjZV9rZXkgdHJhY2VfZnNtb25pdG9yID0NCj4gPiA+IFRSQUNFX0tF
WV9JTklUKEZTTU9OSVRPUik7ICBzdGF0aWMgdm9pZA0KPiA+ID4gZnNtb25pdG9yX2V3YWhfY2Fs
bGJhY2soc2l6ZV90IHBvcywgdm9pZCAqaXMpICB7DQo+ID4gPiAgICAgICBzdHJ1Y3QgaW5kZXhf
c3RhdGUgKmlzdGF0ZSA9IChzdHJ1Y3QgaW5kZXhfc3RhdGUgKilpczsNCj4gPiA+IC0gICAgIHN0
cnVjdCBjYWNoZV9lbnRyeSAqY2UgPSBpc3RhdGUtPmNhY2hlW3Bvc107DQo+ID4gPiArICAgICBz
dHJ1Y3QgY2FjaGVfZW50cnkgKmNlOw0KPiA+ID4NCj4gPiA+ICsgICAgIGlmIChwb3MgPj0gaXN0
YXRlLT5jYWNoZV9ucikNCj4gPiA+ICsgICAgICAgICAgICAgQlVHKCJmc21vbml0b3JfZGlydHkg
aGFzIG1vcmUgZW50cmllcyB0aGFuIHRoZSBpbmRleA0KPiA+ID4gKCUiUFJJdU1BWCIgPj0gJXUp
IiwNCj4gPiA+ICsgICAgICAgICAgICAgICAgICh1aW50bWF4X3QpcG9zLCBpc3RhdGUtPmNhY2hl
X25yKTsNCj4gPiA+ICsNCj4gPiA+ICsgICAgIGNlID0gaXN0YXRlLT5jYWNoZVtwb3NdOw0KPiA+
ID4gICAgICAgY2UtPmNlX2ZsYWdzICY9IH5DRV9GU01PTklUT1JfVkFMSUQ7DQo+ID4gPg0KPiA+
ID4gVGhlIGlzdGF0ZS0+Y2FjaGVbXSBpcyBhIGR5bmFtaWMgYXJyYXkgd2hvc2Ugc2l6ZSBpcyBt
YW5hZ2VkIHZpYSB0aGUNCj4gPiA+IHVzdWFsDQo+ID4gPiBBTExPQ19HUk9XKCkgdXNpbmcgaXN0
YXRlLT5jYWNoZV9uciBhbmQgaXN0YXRlLT5jYWNoZV9hbGxvYywgd2hldGhlcg0KPiA+ID4gdGhl
IHNwbGl0LWluZGV4IGZlYXR1cmUgaXMgaW4gdXNlLiAgV2hlbiB5b3VyIHBhdGNoIG1ha2VzIGEN
Cj4gPiA+IGRpZmZlcmVuY2UsIHRoZW4sIGRvZXNuJ3QgdGhlIGFjY2VzcyB0byBpc3RhdGUtPmNh
Y2hlW10gcGljayB1cCBhDQo+ID4gPiByYW5kb20gZ2FyYmFnZSBhbmQgdGhlbiBmbGlwIHRoZSBi
aXQ/DQo+ID4gPg0KPiA+ID4gUHV6emxlZC4uLiAgSW4gYW55IGNhc2UsICJjaGVjayBpcyB3b3Jz
ZSB0aGFuIG92ZXItZWFnZXIsIGl0IHNpbXBseQ0KPiA+ID4gaXMgd3JvbmciIEkgd3JvdGUgaW4g
dGhlIG1lc3NhZ2UgSSBhbSByZXNwb25kaW5nIHRvIGlzIHRvdGFsbHkNCj4gPiA+IGluY29ycmVj
dCwgaXQgc2VlbXMuICBJdCBzbWVsbHMgbGlrZSBsaWZ0aW5nIHRoZSBjaGVjayB3b3VsZCBqdXN0
DQo+ID4gPiBoaWRlIHRoZSB1bmRlcmx5aW5nIHByb2JsZW0gdW5kZXIgdGhlIHJ1Zz8NCj4gPg0K
PiA+IEkgYWdyZWUuICBUaGUgb25seSAyIHBsYWNlcyB0aGF0IGV4Y2x1ZGluZyB0aGUgc3BsaXQt
aW5kZXggbWFrZSBzZW5zZQ0KPiA+IGFyZSBpbiByZWFkX2ZzbW9uaXRvcl9leHRlbnNpb24gYW5k
IHdyaXRlX2ZzbW9uaXRvcl9leHRlbnNpb24gYmVjYXVzZQ0KPiA+IHRoZSBpbmRleF9zdGF0ZSB0
aGF0IGlzIGJlaW5nIHBhc3NpbmcgaW50byB0aG9zZSBtZXRob2RzIGNvdWxkIGJlIHRoZQ0KPiA+
IGRlbHRhIGluZGV4IGluIHdoaWNoIGNhc2UgdGhlIG51bWJlciBvZiBlbnRyaWVzIGZvciB0aGUg
ZnNtb25pdG9yDQo+ID4gYml0bWFwIHdvdWxkIGFsbW9zdCBhbHdheXMgYmUgbW9yZSBhbmQgY2F1
c2UgdGhlIEJVRyB0byBiZSBoaXQgd2hpY2ggaXQNCj4gc2hvdWxkIG5vdCBiZS4NCj4gPg0KPiA+
IFRoZSByZWFzb24gaXQgaXMgbm90IG5lZWRlZCBhbmQgc2hvdWxkIG5vdCBiZSBpbiB0aGUgb3Ro
ZXIgMiBwbGFjZXMgaXMNCj4gPiB0aGV5IGFyZSByYW4gZnJvbSB0d2Vha19mc21vbml0b3Igd2hp
Y2ggaXMgcmFuIGF0IHBvc3RfcmVhZF9pbmRleF9mcm9tDQo+ID4gd2hpY2ggaXMgYWZ0ZXIgdGhl
IGJhc2UgYW5kIGRlbHRhIGluZGV4ZXMgaGF2ZSBiZWVuIGxvYWRlZCBpbnRvIHRoZQ0KPiA+IGlu
ZGVzX3N0YXRlIGFuZCB0aGUgaW5kZXhfc3RhdGUgd2lsbCBoYXZlIGFsbCB0aGUgZW50cmllcyBh
bmQgaWYgdGhlDQo+ID4gZnNtb25pdG9yIGJpdG1hcCBpcyBiaWdnZXIgdGhhbiB0aGUgbnVtYmVy
IG9mIGVudHJpZXMgdGhlbiB0aGUgQlVHIHNob3VsZA0KPiBiZSBoaXQuDQo+IA0KPiBUaGFua3Mu
IFdoYXQgZXhhY3RseSBpcyB0aGUgZGVsdGEgaW5kZXg/IElzIGl0IHRoZSAic3BsaXQiIGluZGV4
LCB2cyB0aGUgc2hhcmVkDQo+IGluZGljZXM/DQoNClllcyB0aGUgZGVsdGEgaXMgdGhlIHNhbWUg
YXMgdGhlIHNwbGl0IGluZGV4IG1lbnRpb25lZCBoZXJlDQpodHRwczovL2dpdC1zY20uY29tL2Rv
Y3MvZ2l0LXVwZGF0ZS1pbmRleCNfc3BsaXRfaW5kZXguDQoNCj4gSSB3YXMgc3VycHJpc2VkIHRv
IHNlZSBjYWNoZV9uciBiZWluZyB6ZXJvLiBNeSB1bmRlcnN0YW5kaW5nIHdhcw0KPiB0aGF0IGNh
Y2hlIGFuZCBjYWNoZV9uciB3b3VsZCBhbHdheXMgYmUgdGhlIG1hdGVyaWFsaXplZCB2ZXJzaW9u
IG9mIHRoZQ0KPiBlbnRpcmUgaW5kZXgsIHdoaWNoIGlzIGNsZWFybHkgaW5jb3JyZWN0Lg0KDQpN
b3N0IG9mIHRoZSB0aW1lIHRoYXQgaXMgY29ycmVjdCBidXQgaWYgeW91IGxvb2sgaW4gcmVhZF9p
bmRleF9mcm9tLCB0aGUNCmluZGV4IGlzIGxvYWRlZCB3aXRoIHRoZSBjYWxsIHRvDQoNCnJldCA9
IGRvX3JlYWRfaW5kZXgoaXN0YXRlLCBwYXRoLCAwKTsNCg0KVGhpcyB3aWxsIHJlYWQgdGhlIGlu
ZGV4IGV4dGVuc2lvbnMgc28gcmVhZF9mc21vbml0b3JfZXh0ZW5zaW9uIHdpbGwgYmUNCmNhbGxl
ZCBhbmQgdGhlIGNhY2hlIHdpbGwgb25seSBoYXZlIHRoZSBlbnRyaWVzIGZyb20gdGhlIHNwbGl0
L2RlbHRhIGluZGV4Lg0KDQpUaGUgYmFzZS9zaGFyZWQgaW5kZXggaXNuJ3QgbG9hZGVkIGFuZCBp
biB0aGUgY2FjaGUgdW50aWwgbGF0ZXIgd2hlbg0KbWVyZ2VfYmFzZV9pbmRleChpc3RhdGUpOyBp
cyBjYWxsZWQgd2hpY2ggaXMgcmlnaHQgYmVmb3JlIHRoZSBjYWxsIHRvDQpwb3N0X3JlYWRfaW5k
ZXhfZnJvbSB3aGVyZSB0d2Vha19mc21vbml0b3Igd2lsbCBnZXQgY2FsbGVkIGZyb20uDQo=
