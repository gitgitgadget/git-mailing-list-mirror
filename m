Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=AWL,BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_NONE
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 838FA1F731
	for <e@80x24.org>; Fri,  9 Aug 2019 21:34:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726219AbfHIVeL (ORCPT <rfc822;e@80x24.org>);
        Fri, 9 Aug 2019 17:34:11 -0400
Received: from mail-eopbgr710092.outbound.protection.outlook.com ([40.107.71.92]:6380
        "EHLO NAM05-BY2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726022AbfHIVeL (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 9 Aug 2019 17:34:11 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=maggNpnrlj+f6LVr5kn5zGTUw4WX23bbqYYcWVQVye6gTL4EdjhdUK+PGp0xdCmf55O+f7ik0Jwn2eKq0+coeHTJUtM6mraxWhsLAOjJx3aCvNBWkj0QgJY+xHM6SO4ck1Qdx7JrvLOpooMI+XxBWtEkuJU41YJas1uMob73LhwWxPbq2XbsAp/Aj+GEi2VkhDLHyHzpSfIhmesWKz42+w6D5OWmHFnRshtXmRsct273dyf2ZEpyvEOvaIx0TVKK4EpdNjnev/yZltUNvlKC2V9TruxWvvazo8pL0w7dHeYuOAXAkSdQu1Q5vWAhWIooFtN1wVHOmpV5MxA0mknKEA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=oEbNnr+jBFbYzBfr0fXTkHmnpu8d561jTy5ITpga0pE=;
 b=HoUaVYdTHXBCsdIXllH5VXSWLytBXVn+k+zJRZyVSF57F17AxKHJ+vrvAuc3AN6q1C5ndCrI6T7/4QXp0O4fBarvYw7eIjel/+a1pG2JUYwxXXnke0H5venucZ4RcidsqG5yibzYyv8+nj8H42vt8AQ8bEAL5IjE4jI0MqxUccRw6i2W2TSVANWIBW9uk9Saa5eD7rsLL4Pi/n5Nf3eSdkeXyfPJmtokdP8b0Cnp/lxb9gAHf59Q/Ui3l8stIc0ZhIMU4Z1kZCnS9kSGmdnSPq1AYClgCoJ+8bKkl/hWI4HlSrH/jGRPFXN1Nbnav2fhtj3WiJBp3vEirI4MsdBDCg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microsoft.com; dmarc=pass action=none
 header.from=microsoft.com; dkim=pass header.d=microsoft.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=oEbNnr+jBFbYzBfr0fXTkHmnpu8d561jTy5ITpga0pE=;
 b=E9Y/2hs4yuJWF9dAZkNxVm9r3hMu3DE6BSbF5jGkP5R0wbs9jROUDdgZd3PxHz/B8de4YC+JvjUYLCsCvFZq/r65ddpnFSWecAdXl7e4+Hn7pgS1I9JKU718KAXOPmB55Bf78T0aDhGjvtFvLBmcNstihhPZmlYJbZBpm+zz5HY=
Received: from BN8PR21MB1156.namprd21.prod.outlook.com (20.179.72.203) by
 BN8PR21MB1219.namprd21.prod.outlook.com (20.179.73.203) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2157.11; Fri, 9 Aug 2019 21:34:06 +0000
Received: from BN8PR21MB1156.namprd21.prod.outlook.com
 ([fe80::b896:fe09:31ae:e9a4]) by BN8PR21MB1156.namprd21.prod.outlook.com
 ([fe80::b896:fe09:31ae:e9a4%9]) with mapi id 15.20.2157.001; Fri, 9 Aug 2019
 21:34:06 +0000
From:   Cliff Schomburg <clisc@microsoft.com>
To:     =?utf-8?B?U1pFREVSIEfDoWJvcg==?= <szeder.dev@gmail.com>
CC:     "git@vger.kernel.org" <git@vger.kernel.org>
Subject: RE: "git log" does not display refs info when executed via C# Process
 class on Windows
Thread-Topic: "git log" does not display refs info when executed via C#
 Process class on Windows
Thread-Index: AdVO6XCnSWdcLXyxQQWtA59IuPRg6AAAkKqAAAOOazA=
Date:   Fri, 9 Aug 2019 21:34:06 +0000
Message-ID: <BN8PR21MB11566C135B1326AF1B45E4D8B7D60@BN8PR21MB1156.namprd21.prod.outlook.com>
References: <BN8PR21MB11569DAA8A677BF00113F683B7D60@BN8PR21MB1156.namprd21.prod.outlook.com>
 <20190809195031.GK20404@szeder.dev>
In-Reply-To: <20190809195031.GK20404@szeder.dev>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=clisc@microsoft.com; 
x-originating-ip: [24.182.67.250]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 73934667-0a73-4447-e745-08d71d114e9a
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(5600158)(711020)(4605104)(1401327)(4618075)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(2017052603328)(7193020);SRVR:BN8PR21MB1219;
x-ms-traffictypediagnostic: BN8PR21MB1219:
x-ms-exchange-purlcount: 1
x-microsoft-antispam-prvs: <BN8PR21MB1219F515EC2B59644CD941A4B7D60@BN8PR21MB1219.namprd21.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:9508;
x-forefront-prvs: 01244308DF
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(4636009)(39860400002)(136003)(346002)(376002)(366004)(396003)(199004)(189003)(13464003)(66066001)(6246003)(66946007)(102836004)(53936002)(8936002)(7696005)(9686003)(5660300002)(478600001)(6436002)(74316002)(22452003)(446003)(76176011)(305945005)(81166006)(6506007)(229853002)(10290500003)(486006)(7736002)(6916009)(86362001)(11346002)(66446008)(71200400001)(71190400001)(26005)(10090500001)(99286004)(53546011)(966005)(316002)(8990500004)(55016002)(66556008)(4326008)(33656002)(52536014)(3846002)(25786009)(6116002)(186003)(66476007)(14454004)(76116006)(256004)(64756008)(6306002)(81156014)(8676002)(2906002)(476003);DIR:OUT;SFP:1102;SCL:1;SRVR:BN8PR21MB1219;H:BN8PR21MB1156.namprd21.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: microsoft.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: f4iDfQrY6+TinI0QeAbCQphJMY//DrH7HUSv1BAJ5KHHZEtnRrMyXjZWrGOANmQ6qdh0VcRYEzBo1OH2fkFgOHxT6dhXgT9NlJk+IqBiCIQEJdA3D/b7Y9nAkVGAL40nCf7i6iS1u9sh8QscLOtQC6LbZJYxtyXgRwVNJmgDs1Sfidp2lx25xi7B7fika72KqFV4E4p15SbIDujUk9Gip7oK7KlCY5yRensoK1LaGxaovsxJBhZ94zNwqQUZiBKlFCY8zvKEo8/E4MnQUs3Y2ZbEfhKzBrdlXv4j1/MX2PHEJ1B5WO+5kOKn3YX5IYOVN2VOHdAyC6RkpaU6F2f/jDB16mt4nunWTaDdPkOAM94JKRm/NdI6QisFL7+zPxuAyWspV3pXpHT37UAVTGiykJnxivM+4CbZvjYgOuE9xvM=
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 73934667-0a73-4447-e745-08d71d114e9a
X-MS-Exchange-CrossTenant-originalarrivaltime: 09 Aug 2019 21:34:06.4989
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 6Rh+Qobr711sLTywpPC2LEQeuSyIecbMdP179DCC6m1SKDQ0UoyGo5SEYFt9ngZBX6RRnlhBHkP05YSrvA0LOQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN8PR21MB1219
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

U3RyYW5nZWx5LCB3aGVuIEkgcnVuIHRoaXMgY29tbWFuZDoNCg0KR2l0IGxvZyBvcmlnaW4vbWFz
dGVyIC0tcHJldHR5PW9uZWxpbmUgLS1kZWNvcmF0ZSAtMQ0KDQpJIGdldCB0aGUgZm9ybWF0IEkg
d2FudCBmcm9tIFNURE9VVC4gIEhvd2V2ZXIsIHdoZW4gSSB0cnkgdG8gZmlsdGVyIGl0IHRvIHNo
b3cgb25seSB0aGUgdGFnIHJlZnM6DQoNCkdpdCBsb2cgb3JpZ2luL21hc3RlciAtLXByZXR0eT1v
bmVsaW5lIC0tZGVjb3JhdGUgLS1kZWNvcmF0ZS1yZWZzPV50YWcqIC0xDQoNCk5vIHJlZnMgYXJl
IHJldHVybmVkIHRvIHN0YW5kYXJkIG91dHB1dCBhZ2Fpbi4gIE9ubHkgb24gdGhlIGNvbW1hbmQg
bGluZS4NCg0KRG9lcyAtLWRlY29yYXRlLXJlZnMgbm90IHJldHVybiB0byBTVERPVVQ/DQoNClRo
YW5rcywNCkNsaWZmDQoNCi0tLS0tT3JpZ2luYWwgTWVzc2FnZS0tLS0tDQpGcm9tOiBTWkVERVIg
R8OhYm9yIDxzemVkZXIuZGV2QGdtYWlsLmNvbT4gDQpTZW50OiBGcmlkYXksIEF1Z3VzdCA5LCAy
MDE5IDM6NTEgUE0NClRvOiBDbGlmZiBTY2hvbWJ1cmcgPGNsaXNjQG1pY3Jvc29mdC5jb20+DQpD
YzogZ2l0QHZnZXIua2VybmVsLm9yZw0KU3ViamVjdDogUmU6ICJnaXQgbG9nIiBkb2VzIG5vdCBk
aXNwbGF5IHJlZnMgaW5mbyB3aGVuIGV4ZWN1dGVkIHZpYSBDIyBQcm9jZXNzIGNsYXNzIG9uIFdp
bmRvd3MNCg0KT24gRnJpLCBBdWcgMDksIDIwMTkgYXQgMDc6MzY6MTlQTSArMDAwMCwgQ2xpZmYg
U2Nob21idXJnIHdyb3RlOg0KPiBJIGhhdmUgYW4gb3BlbiBHaXQgZm9yIFdpbmRvd3MgaXNzdWUg
aGVyZToNCj4gaHR0cHM6Ly9uYW0wNi5zYWZlbGlua3MucHJvdGVjdGlvbi5vdXRsb29rLmNvbS8/
dXJsPWh0dHBzJTNBJTJGJTJGZ2l0aA0KPiB1Yi5jb20lMkZnaXQtZm9yLXdpbmRvd3MlMkZnaXQl
MkZpc3N1ZXMlMkYyMjg1JmFtcDtkYXRhPTAyJTdDMDElN0NjbGlzDQo+IGMlNDBtaWNyb3NvZnQu
Y29tJTdDMTc2ODllZThkMzJkNDg1MjhjMzIwOGQ3MWQwMmQ4ZDUlN0M3MmY5ODhiZjg2ZjE0MWEN
Cj4gZjkxYWIyZDdjZDAxMWRiNDclN0MxJTdDMCU3QzYzNzAwOTc3MTAxMzY1ODczOCZhbXA7c2Rh
dGE9UEtQZFJJMG1DNjVMeA0KPiAySjVldFlucDBmeXpzayUyQlhTR3pHQldhMTJCTEtFRSUzRCZh
bXA7cmVzZXJ2ZWQ9MA0KPiANCj4gImdpdCBsb2ciIHdvcmtzIGFzIGV4cGVjdGVkIGZyb20gdGhl
IGNvbW1hbmQgcHJvbXB0LiAgQnV0IHdoZW4gSSBleGVjdXRlIGl0IHZpYSBDIyBQcm9jZXNzIGNs
YXNzIGFuZCByZWFkIGZyb20gU3RhbmRhcmQgT3V0cHV0LCB0aGUgcmVmcyBhcmUgbWlzc2luZy4N
Cj4gDQo+IElzIGFueW9uZSBmYW1pbGlhciB3aXRoIHRoaXMgaXNzdWU/ICBBbnkgaWRlYSB3aHkg
dGhlIG91dHB1dCB0byBDTUQgYW5kIFNURE9VVCB3b3VsZCBiZSBkaWZmZXJlbnQ/DQoNCkRlY29y
YXRpb25zLCBsaWtlIGNvbG9yIGFuZCByZWZzIHBvaW50aW5nIHRvIGEgY29tbWl0LCBhcmUgZm9y
IGh1bWFucywgYW5kIGh1bWFucyByZWFkIHRoZSB0ZXJtaW5hbC4gIElmIHRoZSBjb21tYW5kJ3Mg
b3V0cHV0IGRvZXNuJ3QgZ28gdG8gYSB0ZXJtaW5hbCwgdGhlbiBubyBzdWNoIGRlY29yYXRpb25z
IGFyZSBzaG93biBieSBkZWZhdWx0Lg0KDQpUcnkgaW52b2tpbmcgJ2dpdCBsb2cgLS1kZWNvcmF0
ZSc7IG9yLCBiZXR0ZXIgeWV0LCB1c2UgeW91ciBjdXN0b20gJy0tZm9ybWF0PScsIGVzcGVjaWFs
bHkgaWYgeW91IGludGVuZCB0byBwYXJzZSB0aGUgb3V0cHV0LCANCg0K
