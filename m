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
	by dcvr.yhbt.net (Postfix) with ESMTP id 133271F462
	for <e@80x24.org>; Tue, 28 May 2019 09:53:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726453AbfE1JxX (ORCPT <rfc822;e@80x24.org>);
        Tue, 28 May 2019 05:53:23 -0400
Received: from mx07-002aaa01.pphosted.com ([185.132.180.47]:21842 "EHLO
        mx07-002aaa01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726203AbfE1JxX (ORCPT
        <rfc822;git@vger.kernel.org>); Tue, 28 May 2019 05:53:23 -0400
Received: from pps.filterd (m0118689.ppops.net [127.0.0.1])
        by mx07-002aaa01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x4S9pPQM023370;
        Tue, 28 May 2019 09:53:18 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=edenred.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=dk201811;
 bh=tj82zJyWKZmlF9fc748IY3fS4kR5gxENsmLgTCHSH2E=;
 b=3opsuZiIXsYjrYkTN7m73Omml02ZHUJwtTZ367mGriuBvOwQbPxqna8hrzB14MyIF74/
 YtYkyCdsCkVRRt9cv217bqpTTr6Ag/thmAs3GN2zpOuGwrD4NdTSrxZyTLrDstzvHH9s
 +fr3SIy00W5d+OhR87rtjqQi7V3NpFfc2yTGFH7IqCJJWdQyNb8TY/Z647hn2+nenaBf
 eF24ZkjwCzu+MVEF0mDf1Nu3mw3O9xZrxjl6ZWCffkN6avgWbkoir6K6Z/BeYiU0m56u
 51hc+itHv1D9f7p05Kz/MGnMdkHJS9PiGWIAs/wn8vN+Y6/bIkAct/IjTfOLMS+VxjZL nw== 
Received: from ehq-smtp-usr-p.edenred.com ([204.103.47.130])
        by mx07-002aaa01.pphosted.com with ESMTP id 2ss2prg09g-2
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-SHA384 bits=256 verify=NOT);
        Tue, 28 May 2019 09:53:18 +0000
Received: from ehq-smtp-usr-mx1p16-p.edenred.com () by
 ehq-smtp-usr-mx1p18-p.edenred.com () with  (TLS) id
 15.0.1395.4; Tue, 28 May 2019 11:53:17 +0200
Received: from EUR04-DB3-obe.outbound.protection.outlook.com (104.47.12.56) by
 ehq-smtp-usr-mx1p16-p.edenred.com () with  (TLS) id 15.0.1395.4
 via Frontend Transport; Tue, 28 May 2019 11:53:17 +0200
Received: from DB7PR05MB5573.eurprd05.prod.outlook.com (20.177.193.214) by
 DB7PR05MB5576.eurprd05.prod.outlook.com (20.177.193.217) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1922.20; Tue, 28 May 2019 09:53:16 +0000
Received: from DB7PR05MB5573.eurprd05.prod.outlook.com
 ([fe80::d93a:e741:155:318d]) by DB7PR05MB5573.eurprd05.prod.outlook.com
 ([fe80::d93a:e741:155:318d%6]) with mapi id 15.20.1922.021; Tue, 28 May 2019
 09:53:16 +0000
From:   LU Chuck <Chuck.LU@edenred.com>
To:     Philip Oakley <philipoakley@iee.org>, Johannes Sixt <j6t@kdbg.org>
CC:     "git@vger.kernel.org" <git@vger.kernel.org>,
        "chuck.lu@qq.com" <chuck.lu@qq.com>
Subject: RE: git filter-branch re-write history over a range of commits did
 notwork
Thread-Topic: git filter-branch re-write history over a range of commits did
 notwork
Thread-Index: AdUUYk+0TU9swc+jQ+aKfvGwOQfe0wAVrIqAAAQ7KgAAEzBtoAAByCoAAAELfSAABZrSAAAAduNg
Date:   Tue, 28 May 2019 09:53:16 +0000
Message-ID: <DB7PR05MB55736ECF9499B108BD0FB7688D1E0@DB7PR05MB5573.eurprd05.prod.outlook.com>
References: <DB7PR05MB5573AD842E430342E2BD011B8D1D0@DB7PR05MB5573.eurprd05.prod.outlook.com>
 <db2dcf54-8b1c-39b1-579c-425ef158c6a1@kdbg.org>
 <75618ca1-748d-0761-9108-c7deac63cb53@iee.org>
 <DB7PR05MB5573B5B80C8A9CBE867803D88D1E0@DB7PR05MB5573.eurprd05.prod.outlook.com>
 <fa23e865-94ed-308f-6a19-75b6ea89eec3@kdbg.org>
 <DB7PR05MB5573B5FC17FD1F221F7AAD558D1E0@DB7PR05MB5573.eurprd05.prod.outlook.com>
 <3cf99e80-98aa-639b-ac9d-a882da349fc8@iee.org>
In-Reply-To: <3cf99e80-98aa-639b-ac9d-a882da349fc8@iee.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [140.207.1.78]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 04f68b96-84a1-423f-94cf-08d6e3524eae
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600148)(711020)(4605104)(1401327)(2017052603328)(7193020);SRVR:DB7PR05MB5576;
x-ms-traffictypediagnostic: DB7PR05MB5576:
x-ms-exchange-purlcount: 2
x-microsoft-antispam-prvs: <DB7PR05MB55768E522F192CC901142B288D1E0@DB7PR05MB5576.eurprd05.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:5516;
x-forefront-prvs: 00514A2FE6
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(396003)(136003)(366004)(346002)(39860400002)(376002)(13464003)(199004)(189003)(4326008)(53936002)(6246003)(71190400001)(5660300002)(86362001)(25786009)(71200400001)(52536014)(74316002)(478600001)(72206003)(966005)(186003)(26005)(2906002)(66066001)(73956011)(256004)(76116006)(8936002)(81156014)(81166006)(6306002)(14454004)(9686003)(6116002)(7736002)(102836004)(76176011)(8676002)(7696005)(6506007)(305945005)(3846002)(53546011)(68736007)(446003)(486006)(11346002)(476003)(229853002)(54906003)(6436002)(66946007)(55016002)(66476007)(66556008)(110136005)(64756008)(66446008)(316002)(99286004)(33656002);DIR:OUT;SFP:1102;SCL:1;SRVR:DB7PR05MB5576;H:DB7PR05MB5573.eurprd05.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: edenred.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: 1kRbHzuuvNR4bsvbsFofMCu7HQVAT4/fpOK9fsj730nEfvDuONWXM/toYixyRZctLVeqsL14nj4eQ+3EsTtcCytW9xawZt8Dt5rud8JjWqOcqPPrmW+Xu8yoefIWWGUvsc8jNgzwBe173gRHhu37J1+R49cFZ/6jjz1PzEMskU8verqoL1j5uLB9knb2u2zgjoR7M3anmCzcZyJA3WvQ7gUUE5C4eQ1rM/hDkPLVVft5rEtPeZ5UigTSDTalIOz2ZysTZ2u2cLbXbjLko3TELtuucPcGQ4PmzHb2SqrL89y45bs+UOiqD9H/V6NpL1SSZWiyWUZ82J7v+RfMO+oJtwa4LZjulpvoKBQzBbf2a6Vbpo2q0JiXRDqalZFSWtYIBaTW7M7qYuDd3PdzE9cWnq9AdL3Ays3awGQju8GCqU0=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-Network-Message-Id: 04f68b96-84a1-423f-94cf-08d6e3524eae
X-MS-Exchange-CrossTenant-originalarrivaltime: 28 May 2019 09:53:16.5452
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4c1d9e0f-5c27-4228-a35a-de7b4083ff7b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: chuck.lu@edenred.com
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB7PR05MB5576
X-OriginatorOrg: edenred.com
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2019-05-28_04:,,
 signatures=0
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

DQoNCj4gLS0tLS1PcmlnaW5hbCBNZXNzYWdlLS0tLS0NCj4gRnJvbTogUGhpbGlwIE9ha2xleSA8
cGhpbGlwb2FrbGV5QGllZS5vcmc+DQo+IFNlbnQ6IFR1ZXNkYXksIE1heSAyOCwgMjAxOSA1OjM0
IFBNDQo+IFRvOiBMVSBDaHVjayA8Q2h1Y2suTFVAZWRlbnJlZC5jb20+OyBKb2hhbm5lcyBTaXh0
IDxqNnRAa2RiZy5vcmc+DQo+IENjOiBnaXRAdmdlci5rZXJuZWwub3JnOyBjaHVjay5sdUBxcS5j
b20NCj4gU3ViamVjdDogUmU6IGdpdCBmaWx0ZXItYnJhbmNoIHJlLXdyaXRlIGhpc3Rvcnkgb3Zl
ciBhIHJhbmdlIG9mIGNvbW1pdHMgZGlkIG5vdHdvcmsNCj4gDQo+IEhpIENodWNrLA0KPiANCj4g
T24gMjgvMDUvMjAxOSAwODoxMCwgTFUgQ2h1Y2sgd3JvdGU6DQo+IFtzbmlwXQ0KPiA+PiBDb3B5
aW5nIGFuZCBwYXN0aW5nIGV4YW1wbGVzIGxpdGVyYWxseSBpcyBkYW5nZXJvdXMuIFlvdSBzaG91
bGQga25vdw0KPiA+PiB3aGF0IHlvdSBhcmUgZG9pbmcuDQo+ID4+DQo+ID4+ICIuLi4iIGlzIGEg
cmV2aXNpb24gcmFuZ2UgdGhhdCBjb21wdXRlcyB0aGUgbWVyZ2ViYXNlIGJldHdlZW4gSEVBRA0K
PiA+PiBhbmQgSEVBRCwgd2hpY2ggaXMgKHN1cnByaXNlISkgSEVBRCwgYW5kIHRoZW4gaW5jbHVk
ZXMgdGhlIHR3byBlbmQNCj4gPj4gcG9pbnRzLCBidXQgZXhjbHVkZXMgZXZlcnl0aGluZyBiZWxv
dyB0aGUgbWVyZ2ViYXNlLiBTbywgdGhlIHJldmlzaW9uDQo+ID4+IHNwZWNpZmljYXRpb24gdGhh
dCB5b3VyIGNvbW1hbmQgZW5kcyB1cCB3aXRoIGlzDQo+ID4+DQo+ID4+ICAgICAgIEhFQUQgSEVB
RCBeSEVBRCBeNjdkOWQ5IGY3MGJmNA0KPiA+Pg0KPiA+PiBXaGljaCBpcyBlbXB0eSBpZiBmNzBi
ZjQgaXMgYW4gYW5jZXN0b3Igb2YgSEVBRC4NCj4gPiBbTFUgQ2h1Y2tdIFNvcnJ5LCBJIGNhbid0
IHVuZGVyc3RhbmQgdGhpcyBwYXJ0LCBkaWQgeW91IGhhdmUgYW4gZG9jdW1lbnRhdGlvbg0KPiBh
Ym91dCB0aGUgZXhwbGFuYXRpb24gZm9yIC4uLj8NCj4gaHR0cHM6Ly91cmxkZWZlbnNlLnByb29m
cG9pbnQuY29tL3YyL3VybD91PWh0dHBzLTNBX19naXQtMkRzY20uY29tX2RvY3NfZ2l0DQo+IHJl
dmlzaW9ucy0yM0RvY3VtZW50YXRpb25fZ2l0cmV2aXNpb25zLnR4dC0yRFRoZWVtODIzMDgyMDNl
bXRocmVlLTJEZG90Uw0KPiB5bW1ldHJpY0RpZmZlcmVuY2VOb3RhdGlvbiZkPUR3SUNhUSZjPU8x
N202VWRxT0FJWmg5WFE4cFRsNGcmcj1WY0cNCj4gZUllT1pfOF96bHJRTlNib2VuWWx0ZnhHTklY
Tl9xRzZWcFpnWFZSayZtPV9yRG96SFh1YkNGa0VzZmhNcjJRbGFQDQo+IG4taF9LaGZxYTNSRzBj
Tm1yU3hvJnM9cWR5YUpOeTZua0FlLTR1ZmVTNG8xTmR2Z29xUVFoWkRtRGptalFLOWsNCj4gUm8m
ZT0NCltMVSBDaHVja10gVGhhbmtzIGZvciB5b3VyIGRvY3VtZW50YXRpb24gYWJvdXQgdGhlIGV4
cGxhbmF0aW9uLiBQcmV2aW91c2x5IEkgcmVhZCBhbm90aGVyIGRvY3VtZW50YXRpb24gaHR0cHM6
Ly9naXQtc2NtLmNvbS9ib29rL2VuL3YyL0dpdC1Ub29scy1SZXZpc2lvbi1TZWxlY3Rpb24jQ29t
bWl0LVJhbmdlcy4gIA0KICAgICAgICAgIEl0J3Mgd2VpcmQgdGhlIHRocmVlIGRvdHMgaGFzIHR3
byBkaWZmZXJlbnQgZXhwbGFuYXRpb24sIG1heWJlIHRoZXJlIHNob3VsZCBhIHBsYWNlIHRvIGNv
bGxlY3QgdGhlc2UgdHdvIGV4cGxhbmF0aW9uIGZvciB0aHJlZSBkb3RzLg0KPiA+ICAgICAgICAg
ICAiY29tcHV0ZXMgdGhlIG1lcmdlYmFzZSBiZXR3ZWVuIEhFQUQgYW5kIEhFQUQiIEkgaGF2ZSBu
byBpZGVhDQo+IGFib3V0IHRoaXMuIEFuZCB5b3UgYWxzbyB0YWxrZWQgYWJvdXQgbWVyZ2ViYXNl
LCBidXQgaW4gbXkgc2l0dWF0aW9uLCB0aGVyZSBpcyBvbmx5DQo+IG9uZSBicmFuY2ggd2l0aCA1
IGNvbW1pdHMuIEkgZGlkIG5vdCBoYXZlIGEgbWVyZ2ViYXNlLg0KPiA+ICAgICAgICAgICBZb3Ug
Y2FuIGNoZWNrIHRoZSBkZXRhaWwgZGVzY3JpcHRpb24gYmVsb3cuDQo+IFdoZW4gdGhlcmUgaXMg
bm8gc3BlY2lmaWMgcmV2aXNpb25zIGFyb3VuZCB0aGUgdGhyZWUgZG90cyB0aGVuIEhFQUQgaXMg
YXNzdW1lZA0KPiAodG8gc2F2ZSB0eXBpbmcpDQpbTFUgQ2h1Y2tdIEkgZ290IHlvdSBoZXJlLCB0
aGF0J3Mgd2h5IHlvdSBhc2sgbWUgcmVtb3ZlIHRoZSB0aHJlZSBkb3RzIGJlZm9yZSwgcmlnaHQ/
DQo+IA0KPiBbc25pcHBpbmcgdGhlIGNvbW1lbnRzIG9uIHRoZSBhbHRlcm5hdGUgc2NyaXB0XQ0K
