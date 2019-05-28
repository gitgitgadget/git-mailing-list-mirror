Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_NONE,
	UNPARSEABLE_RELAY shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id CFF5F1F462
	for <e@80x24.org>; Tue, 28 May 2019 05:42:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726810AbfE1FmP (ORCPT <rfc822;e@80x24.org>);
        Tue, 28 May 2019 01:42:15 -0400
Received: from mx07-002aaa01.pphosted.com ([185.132.180.47]:1683 "EHLO
        mx07-002aaa01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725904AbfE1FmO (ORCPT
        <rfc822;git@vger.kernel.org>); Tue, 28 May 2019 01:42:14 -0400
Received: from pps.filterd (m0118690.ppops.net [127.0.0.1])
        by mx07-002aaa01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x4S5YrJf031555;
        Tue, 28 May 2019 05:42:09 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=edenred.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=dk201811;
 bh=Z/v0zbDBmh4ZN6TI98TqKaFqpxOkoCMDiDX65u+zP+g=;
 b=uLLYp4ssUPQghKmIZUoxy4HcAffOJ8U13kY+p2MaLWhEK24w77fxwmBoHwaeYaexSKY4
 QmmwMFO1He9GHrHBfFeyzTErnXRYvxjtHv4Mdq81Djp6pqOpfZBbmPl880qUBolSnL8b
 l/JGgLplDLqIZu1VED92sNOB8PlSTx8FShqYJ7JkXFdBlyYsJX+QP43NCEdxkzERalZr
 muF3F5YYykLI1/2irVO50IWHvpb4wmMet2fKhrgh9vhGmWJqGmdiCHCIYtx4mDOuduMh
 h5SR6SRsvyfZ0XPJT41SJSNsC0HCipwbzb2fprKlLSiqLa5+xS04xnZF5Y//11deeYpU EA== 
Received: from ehq-smtp-usr-p.edenred.com ([204.103.47.132])
        by mx07-002aaa01.pphosted.com with ESMTP id 2srqfkrv6p-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-SHA384 bits=256 verify=NOT);
        Tue, 28 May 2019 05:42:09 +0000
Received: from ehq-smtp-usr-mx1p18-p.edenred.com () by
 ehq-smtp-usr-mx1p21-p.edenred.com () with  (TLS) id
 15.0.1395.4; Tue, 28 May 2019 07:42:08 +0200
Received: from EUR03-AM5-obe.outbound.protection.outlook.com (104.47.8.53) by
 ehq-smtp-usr-mx1p18-p.edenred.com () with  (TLS) id 15.0.1395.4
 via Frontend Transport; Tue, 28 May 2019 07:42:08 +0200
Received: from DB7PR05MB5573.eurprd05.prod.outlook.com (20.177.193.214) by
 DB7PR05MB6169.eurprd05.prod.outlook.com (20.178.107.14) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1922.17; Tue, 28 May 2019 05:42:07 +0000
Received: from DB7PR05MB5573.eurprd05.prod.outlook.com
 ([fe80::d93a:e741:155:318d]) by DB7PR05MB5573.eurprd05.prod.outlook.com
 ([fe80::d93a:e741:155:318d%6]) with mapi id 15.20.1922.021; Tue, 28 May 2019
 05:42:07 +0000
From:   LU Chuck <Chuck.LU@edenred.com>
To:     Philip Oakley <philipoakley@iee.org>, Johannes Sixt <j6t@kdbg.org>
CC:     "git@vger.kernel.org" <git@vger.kernel.org>,
        "chuck.lu@qq.com" <chuck.lu@qq.com>
Subject: RE: git filter-branch re-write history over a range of commits did
 notwork
Thread-Topic: git filter-branch re-write history over a range of commits did
 notwork
Thread-Index: AdUUYk+0TU9swc+jQ+aKfvGwOQfe0wAVrIqAAAQ7KgAAEzBtoA==
Date:   Tue, 28 May 2019 05:42:06 +0000
Message-ID: <DB7PR05MB5573B5B80C8A9CBE867803D88D1E0@DB7PR05MB5573.eurprd05.prod.outlook.com>
References: <DB7PR05MB5573AD842E430342E2BD011B8D1D0@DB7PR05MB5573.eurprd05.prod.outlook.com>
 <db2dcf54-8b1c-39b1-579c-425ef158c6a1@kdbg.org>
 <75618ca1-748d-0761-9108-c7deac63cb53@iee.org>
In-Reply-To: <75618ca1-748d-0761-9108-c7deac63cb53@iee.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [140.207.1.78]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 98d96972-790e-47ae-fd25-08d6e32f387d
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600148)(711020)(4605104)(1401327)(2017052603328)(7193020);SRVR:DB7PR05MB6169;
x-ms-traffictypediagnostic: DB7PR05MB6169:
x-ms-exchange-purlcount: 5
x-microsoft-antispam-prvs: <DB7PR05MB6169114128C0C28996FE14A18D1E0@DB7PR05MB6169.eurprd05.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:353;
x-forefront-prvs: 00514A2FE6
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(39860400002)(396003)(366004)(376002)(346002)(136003)(51874003)(13464003)(199004)(189003)(64756008)(66556008)(66446008)(81166006)(81156014)(25786009)(66476007)(73956011)(66946007)(54906003)(5660300002)(7696005)(7736002)(8936002)(305945005)(66066001)(68736007)(26005)(486006)(76176011)(71200400001)(86362001)(19627235002)(71190400001)(476003)(4326008)(52536014)(102836004)(76116006)(53546011)(256004)(186003)(8676002)(446003)(11346002)(110136005)(6506007)(99286004)(53936002)(33656002)(966005)(6436002)(6306002)(14454004)(72206003)(9686003)(316002)(55016002)(478600001)(229853002)(74316002)(6116002)(3846002)(2906002)(6246003);DIR:OUT;SFP:1102;SCL:1;SRVR:DB7PR05MB6169;H:DB7PR05MB5573.eurprd05.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: edenred.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: x4iLaQLE0Zl22j1bbZi8L22AOidviTJ+caLZqra2N7Kre92/ATcjZ5WjAOtD28+dhqyc52sOl7QrQ4AlobbHzsyRqN4tEadKDvP0gtoZwW8qchWpb8QK2MmE8XWQmpIsymfMGG3l652wE8cCyC9SdW7oGTDBjsXcEUKHq8BLsdUSWHfmQGrdLyCFMh7FnpkIozUc4gX/LcCk2XMADcLzGkj7Z4tFoaTCHCxoYZvhpmnxfW/+XPtsYsrUAzOT/03WqpzSiKYIuwlUxenP4ARwxLvoVwvZGo5tS4HVOOhek875scThNl0hr9Rk9zB8+kin1bZyZ9zJ7soIWdA9iP74mraQx5xbrHEHQysXk0F9RqN/t3fOolljrCCWbjmiuyd1taIrzgi+ChSAztDYpikorlsb+x/mBiSek7jI0QfLtqU=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-Network-Message-Id: 98d96972-790e-47ae-fd25-08d6e32f387d
X-MS-Exchange-CrossTenant-originalarrivaltime: 28 May 2019 05:42:06.9633
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4c1d9e0f-5c27-4228-a35a-de7b4083ff7b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: chuck.lu@edenred.com
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB7PR05MB6169
X-OriginatorOrg: edenred.com
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2019-05-28_02:,,
 signatures=0
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

DQoNCj4gLS0tLS1PcmlnaW5hbCBNZXNzYWdlLS0tLS0NCj4gRnJvbTogUGhpbGlwIE9ha2xleSA8
cGhpbGlwb2FrbGV5QGllZS5vcmc+DQo+IFNlbnQ6IFR1ZXNkYXksIE1heSAyOCwgMjAxOSA0OjIz
IEFNDQo+IFRvOiBKb2hhbm5lcyBTaXh0IDxqNnRAa2RiZy5vcmc+OyBMVSBDaHVjayA8Q2h1Y2su
TFVAZWRlbnJlZC5jb20+DQo+IENjOiBnaXRAdmdlci5rZXJuZWwub3JnOyBjaHVjay5sdUBxcS5j
b20NCj4gU3ViamVjdDogUmU6IGdpdCBmaWx0ZXItYnJhbmNoIHJlLXdyaXRlIGhpc3Rvcnkgb3Zl
ciBhIHJhbmdlIG9mIGNvbW1pdHMgZGlkIG5vdHdvcmsNCj4gDQo+IEhpIENodWNrLA0KPiANCj4g
T24gMjcvMDUvMjAxOSAxOToyMSwgSm9oYW5uZXMgU2l4dCB3cm90ZToNCj4gPiBBbSAyNy4wNS4x
OSB1bSAxMDowMSBzY2hyaWViIExVIENodWNrOg0KPiA+PiBIaSB0ZWFtLA0KPiA+Pg0KPiA+PiAg
ICAgIFRoZSBpc3N1ZSBjb21lcyBmcm9tDQo+IGh0dHBzOi8vdXJsZGVmZW5zZS5wcm9vZnBvaW50
LmNvbS92Mi91cmw/dT1odHRwcy0zQV9fZ2l0aHViLmNvbV9naXQtMkRmb3ItMg0KPiBEd2luZG93
c19naXRfaXNzdWVzXzIyMDYmZD1Ed0lDYVEmYz1PMTdtNlVkcU9BSVpoOVhROHBUbDRnJnI9VmNH
ZQ0KPiBJZU9aXzhfemxyUU5TYm9lbllsdGZ4R05JWE5fcUc2VnBaZ1hWUmsmbT15Rm03bEFka1JM
Tk1UMDU4U0hRVWpNDQo+IFJGS3pKTkRGdGVYbG9oS3BaSFZDcyZzPVNtMXAzWW95MjF4SzBfellC
WjVpeExvLUZrM0dBc1h5Z0MzSTZoVFpLVGcNCj4gJmU9IC4NCj4gPj4NCj4gPj4gICAgICBJIHdh
bnQgdG8gcmUtd3JpdGUgaGlzdG9yeSBieSBmaWx0ZXItYnJhbmNoIGNvbW1hbmQgb3ZlciBhIHJh
bmdlIG9mDQo+IGNvbW1pdHMsIGJ1dCB0aGUgY29tbWFuZCBkaWQgbm90IHdvcmsuDQo+ID4+ICAg
ICAgSSBoYXZlIHJlZmVycmVkIHRvIHRoZSBmb2xsb3dpbmcgdGhyZWUgZG9jdW1lbnRhdGlvbiBh
Ym91dCBob3cgdG8gdXNlDQo+IGdpdCBmaWx0ZXItYnJhbmNoOg0KPiA+Pg0KPiBodHRwczovL3Vy
bGRlZmVuc2UucHJvb2Zwb2ludC5jb20vdjIvdXJsP3U9aHR0cHMtM0FfX3N0YWNrb3ZlcmZsb3cu
Y29tX3F1ZXMNCj4gdGlvbnNfMTUyNTAwNzBfcnVubmluZy0yRGZpbHRlci0yRGJyYW5jaC0yRG92
ZXItMkRhLTJEcmFuZ2UtMkRvZi0yRGNvbQ0KPiBtaXRzJmQ9RHdJQ2FRJmM9TzE3bTZVZHFPQUla
aDlYUThwVGw0ZyZyPVZjR2VJZU9aXzhfemxyUU5TYm9lbllsdGYNCj4geEdOSVhOX3FHNlZwWmdY
VlJrJm09eUZtN2xBZGtSTE5NVDA1OFNIUVVqTVJGS3pKTkRGdGVYbG9oS3BaSFYNCj4gQ3Mmcz1h
WU1WcXJFalZsc2pHWkNSYnFGM2RiUFB1YnYyZHROYkdFVHJFcXRPMDFFJmU9DQo+ID4+DQo+IGh0
dHBzOi8vdXJsZGVmZW5zZS5wcm9vZnBvaW50LmNvbS92Mi91cmw/dT1odHRwcy0zQV9fc3RhY2tv
dmVyZmxvdy5jb21fcXVlcw0KPiB0aW9uc18yODUzNjk4MF9naXQtMkRjaGFuZ2UtMkRjb21taXQt
MkRkYXRlLTJEdG8tMkRhdXRob3ItMkRkYXRlJmQ9RA0KPiB3SUNhUSZjPU8xN202VWRxT0FJWmg5
WFE4cFRsNGcmcj1WY0dlSWVPWl84X3psclFOU2JvZW5ZbHRmeEdOSVhOX3ENCj4gRzZWcFpnWFZS
ayZtPXlGbTdsQWRrUkxOTVQwNThTSFFVak1SRkt6Sk5ERnRlWGxvaEtwWkhWQ3Mmcz1SdmpPDQo+
IGpPRVhVd3pZSnAtTzNqc3N1TnBteUNXVy1VT2l0OHJ3RnJjS1dCRSZlPQ0KPiA+Pg0KPiA+PiBo
dHRwczovL3VybGRlZmVuc2UucHJvb2Zwb2ludC5jb20vdjIvdXJsP3U9aHR0cHMtM0FfX2dpdC0y
RHNjbS5jb21fZG8NCj4gPj4NCj4gY3NfZ2l0LTJEZmlsdGVyLTJEYnJhbmNoJmQ9RHdJQ2FRJmM9
TzE3bTZVZHFPQUlaaDlYUThwVGw0ZyZyPVZjR2VJZU8NCj4gWg0KPiA+Pg0KPiBfOF96bHJRTlNi
b2VuWWx0ZnhHTklYTl9xRzZWcFpnWFZSayZtPXlGbTdsQWRrUkxOTVQwNThTSFFVak1SRkt6DQo+
IEpOREZ0DQo+ID4+IGVYbG9oS3BaSFZDcyZzPWZvNmFmRk5rT20zNWxlZndUOE1xMV9MVERXOWZK
V1M3cTZkdXB6dGlQa28mZT0NCj4gPj4NCj4gPj4gICAgICBZb3UgY2FuIHJlcHJvZHVjZSB0aGUg
cHJvYmxlbSBieSB0aGUgZm9sbG93aW5nIHN0ZXBzDQo+ID4+ICAgICAgMS4gY2xvbmUgdGhlIHJl
cG9zaXRvcnkNCj4gaHR0cHM6Ly91cmxkZWZlbnNlLnByb29mcG9pbnQuY29tL3YyL3VybD91PWh0
dHBzLTNBX19naXRodWIuY29tX2NodWNrbHVfTGVlDQo+IHRDb2RlXyZkPUR3SUNhUSZjPU8xN202
VWRxT0FJWmg5WFE4cFRsNGcmcj1WY0dlSWVPWl84X3psclFOU2JvZW4NCj4gWWx0ZnhHTklYTl9x
RzZWcFpnWFZSayZtPXlGbTdsQWRrUkxOTVQwNThTSFFVak1SRkt6Sk5ERnRlWGxvaEtwWg0KPiBI
VkNzJnM9YW1OQzhDWWotOU5heTIxYXgzN2VHd19jXzkybGgwWjZfVks3c1RnQ3dYUSZlPQ0KPiA+
PiAgICAgIDIuIGNoZWNrb3V0IHRvIHRoZSB0ZW1wIGJyYW5jaA0KPiA+PiAgICAgIDMuIHJ1biB0
aGUgY29tbWFuZCBnaXQgZmlsdGVyLWJyYW5jaCAtLWVudi1maWx0ZXIgJ2V4cG9ydA0KPiA+PiBH
SVRfQ09NTUlUVEVSX0RBVEU9IiRHSVRfQVVUSE9SX0RBVEUiJyAuLi4gNjdkOWQ5Li5mNzBiZjQN
Cj4gPiBEaWQgeW91IG5vdCB0ZWxsIHVzIGV2ZXJ5dGhpbmcgYmVjYXVzZSB5b3Ugd3JpdGUgLi4u
IGluIHRoaXMgbWVzc2FnZQ0KPiA+IHdoZW4geW91IGNpdGVkIHRoZSBjb21tYW5kIHlvdSB1c2Vk
LCBvciBkbyB5b3Ugc2F5IHRoYXQgeW91IHVzZWQgLi4uDQo+ID4gbGl0ZXJhbGx5IGluIHRoZSBj
b21tYW5kPw0KPiANCj4gVGhlIHRocmVlIGRvdHMgaXMgcHJvdmlkZWQgaW4gdGhlIGxpdGVyYWwg
RVhBTVBMRVMgc2VjdGlvbiBvZiB0aGUgbWFuIHBhZ2UuIFRoYXQgaXMNCj4gcHJvYmFibHkgYW4g
ZXJyb3IsIGFzIEkgdGhpbmsgaXQgaXMgbWVhbnQgdG8gYmUgYW4gZWxsaXBzaXMgdG8gaW5kaWNh
dGUgJ2luc2VydCBvdGhlcg0KPiBvcHRpb25zIGhlcmUnLg0KPiANCj4gU2ltcGx5IHJlbW92ZSB0
aGUgdGhyZWUgZG90cyAoJ3N5bW1ldHJpYyBkaWZmIG5vdGF0aW9uJykgLg0KPiANCj4gTm90IHN1
cmUgd2hhdCB0aGUgY29ycmVjdCBjaGFuZ2UgdG8gdGhlIG1hbiBwYWdlIHNob3VsZCBiZSwgYnV0
IGNsZWFybHkgaXQgaGFzDQo+IGNhdXNlZCBjb25mdXNpb24uIEl0IGFsc28gdGFrZXMgYSBtb21l
bnQgdG8gcHJvcGVybHkgcmVhbGlzZSB3aGljaCBjb21taXRzIHRoZQ0KPiB0d28gZG90IG5vdGF0
aW9uIHdpbGwgcmVmZXIgdG8gaW4gdGhlIGV4YW1wbGUgd2hpY2ggbWF5IGZ1cnRoZXIgY29tcG91
bmQgdGhlDQo+IGNvbmZ1c2lvbiBhYm91dCB0aGUgdGhyZWUgZG90cy4NCj4gDQo+IFBoaWxpcA0K
W0xVIENodWNrXSBIaSBIYW5uZXMsDQogICAgICAgICBJIHVzZWQgLi4uIGxpdGVyYWxseSB3aGVu
IEkgY2l0ZWQgdGhlIGNvbW1hbmQuIEkgd3JpdGUgdGhlIGNvbW1hbmQgd2l0aCAuLi4gZGlyZWN0
bHkgYXMgdGhlIGRvY3VtZW50IGludHJvZHVjZSB0aGUgdXNhZ2UgbGlrZSB0aGF0Lg0KICAgICAg
ICAgWW91IGNhbiBjaGVjayB0aGUgZG9jdW1lbnQgaHR0cHM6Ly9naXQtc2NtLmNvbS9kb2NzL2dp
dC1maWx0ZXItYnJhbmNoI19leGFtcGxlcyBhYm91dCB0aGUgLS1lbnYtZmlsdGVyIHNlY3Rpb24u
DQoNCiAgICAgICAgIEhpIFBoaWxpcCwNCiAgICAgICAgIEkgYWxzbyB0cmllZCB0byBleGVjdXRl
IHRoZSBjb21tYW5kIHdpdGhvdXQgLi4uLCANCiAgICAgICAgIGdpdCBmaWx0ZXItYnJhbmNoIC0t
ZW52LWZpbHRlciAnZXhwb3J0IEdJVF9DT01NSVRURVJfREFURT0iJEdJVF9BVVRIT1JfREFURSIn
IDY3ZDlkOS4uZjcwYmY0DQogICAgICAgICB0aGVuIEkgd2lsbCBnZXQgYW5vdGhlciBlcnJvciAi
IFlvdSBtdXN0IHNwZWNpZnkgYSByZWYgdG8gcmV3cml0ZS4iDQoNCiAgICAgICAgIEhpIHRlYW0N
CiAgICAgICAgIEkgaGF2ZSBmaXZlIGNvbW1pdHMgQSxCLEMsRCxFIHdpdGggY29tbWl0IGlkIGFz
IGZvbGxvd2luZzoNCiAgICAgICAgIEEoNjdkOWQ5KTwtLUIoOWMxNTgwKTwtLUMoMmVlYzRkKTwt
LUQoYTQ1OTk1KTwtLUUoZjcwYmY0KSAgDQogICAgICAgICBUaGUgY29tbWl0cyBCLEMsRCxFICdz
IGNvbW1pdGVyIGRhdGUgYW5kIGF1dGhvciBkYXRlIGFyZSBub3QgdGhlIHNhbWUuIEkgd2FudCB0
byB1c2UgZmlsdGVyLWJyYW5jaCBjb21tYW5kIHRvIG1ha2UgdGhlIGNvbW1pdGVyIGRhdGUgc2Ft
ZSBhcyB0aGUgYXV0aG9yIGRhdGUuDQogICAgICAgICBJIGFtIHVzaW5nIHRoZSBmb2xsb3dpbmcg
Y29tbWFuZCB0byBhY2hpZXZlIHJlLXdyaXRlIGhpc3Rvcnk6DQogICAgICAgICBnaXQgZmlsdGVy
LWJyYW5jaCAtLWVudi1maWx0ZXIgJ2V4cG9ydCBHSVRfQ09NTUlUVEVSX0RBVEU9IiRHSVRfQVVU
SE9SX0RBVEUiJyAuLi4gQS4uRQ0KICAgICAgICAgSG93ZXZlciB0aGUgY29tbWFuZCBkaWQgbm90
IHdvcmsuDQoNCj4gPg0KPiA+PiAgICAgIDQuIFlvdSB3aWxsIGdvdCB0aGUgaW5mbyAiRm91bmQg
bm90aGluZyB0byByZXdyaXRlIg0KPiA+Pg0KPiA+PiAgICAgIEhvd2V2ZXIsIGl0IHdhcyBzdXBw
b3NlZCB0byBvdmVyd3JpdGUgdGhlIGhpc3RvcnkgZnJvbSBjb21taXQgOWMxNTgwDQo+IHRvIGNv
bW1pdCBmNzBiZjQsIG1ha2UgdGhlIGNvbW1pdCBkYXRlIHNhbWUgYXMgZGF0ZS4NCj4gPj4gICAg
ICBJIGFtIG5vdCBzdXJlIGlmIEkgYW0gdXNpbmcgdGhlIGZpbHRlci1icmFuY2ggY29ycmVjdGx5
LCBvciBpZiB0aGVyZSBpcyBhIGJ1ZyBpbg0KPiBnaXQ/DQo+ID4+DQo+ID4+ICAgICAgQW55b25l
IGNhbiBoZWxwIG1lPyBUaGFua3MgaW4gYWR2YW5jZS4NCj4gPiAtLSBIYW5uZXMNCg0K
