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
	by dcvr.yhbt.net (Postfix) with ESMTP id CBE561F462
	for <e@80x24.org>; Tue, 28 May 2019 07:10:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726984AbfE1HKL (ORCPT <rfc822;e@80x24.org>);
        Tue, 28 May 2019 03:10:11 -0400
Received: from mx07-002aaa01.pphosted.com ([185.132.180.47]:10022 "EHLO
        mx07-002aaa01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726203AbfE1HKL (ORCPT
        <rfc822;git@vger.kernel.org>); Tue, 28 May 2019 03:10:11 -0400
Received: from pps.filterd (m0118689.ppops.net [127.0.0.1])
        by mx07-002aaa01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x4S75Zp8003585;
        Tue, 28 May 2019 07:10:06 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=edenred.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=dk201811;
 bh=MivYZBkkmKXyLDxkrX/EJUMtUcmSJPSOOr13m8igxQw=;
 b=GEj8s993EuUGtJVE4rMZYDfbCXrhP+wfs2HW4+tFom7ze0NaY+HHvuYMIRClxiVCZrnz
 Rsx3AqGfUHoNBOedp7vj+6Hrs2eWh4UN03LkDg78kQctaw7bs9gYix6xC1wg9rTmPsrT
 NmihZs8P9BPkTNd9rhOzdIbeKsybRgSkYlx5djkKZpuyddr5q+LobBGDT6PX2+CTA3Qu
 NjPFQhfo2lBmIRRfepSmM8DZ1OK8o6jhIKsjOK70vat3W3dLzjdC3/Qz1Z/q+7O/CcVL
 9HyL722QuzZk0wYuivkinc5/KZlWIOi4hCiz7RXraTsHxuJQx9wfkBivuPrAOi3lmuGL aQ== 
Received: from ehq-smtp-usr-p.edenred.com ([204.103.47.130])
        by mx07-002aaa01.pphosted.com with ESMTP id 2srq7214am-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-SHA384 bits=256 verify=NOT);
        Tue, 28 May 2019 07:10:06 +0000
Received: from ehq-smtp-usr-mx1p18-p.edenred.com () by
 ehq-smtp-usr-mx1p18-p.edenred.com () with  (TLS) id
 15.0.1395.4; Tue, 28 May 2019 09:10:05 +0200
Received: from EUR04-DB3-obe.outbound.protection.outlook.com (104.47.12.56) by
 ehq-smtp-usr-mx1p18-p.edenred.com () with  (TLS) id 15.0.1395.4
 via Frontend Transport; Tue, 28 May 2019 09:10:05 +0200
Received: from DB7PR05MB5573.eurprd05.prod.outlook.com (20.177.193.214) by
 DB7PR05MB5258.eurprd05.prod.outlook.com (20.178.42.18) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1922.20; Tue, 28 May 2019 07:10:04 +0000
Received: from DB7PR05MB5573.eurprd05.prod.outlook.com
 ([fe80::d93a:e741:155:318d]) by DB7PR05MB5573.eurprd05.prod.outlook.com
 ([fe80::d93a:e741:155:318d%6]) with mapi id 15.20.1922.021; Tue, 28 May 2019
 07:10:04 +0000
From:   LU Chuck <Chuck.LU@edenred.com>
To:     Johannes Sixt <j6t@kdbg.org>
CC:     Philip Oakley <philipoakley@iee.org>,
        "git@vger.kernel.org" <git@vger.kernel.org>,
        "chuck.lu@qq.com" <chuck.lu@qq.com>
Subject: RE: git filter-branch re-write history over a range of commits did
 notwork
Thread-Topic: git filter-branch re-write history over a range of commits did
 notwork
Thread-Index: AdUUYk+0TU9swc+jQ+aKfvGwOQfe0wAVrIqAAAQ7KgAAEzBtoAAByCoAAAELfSA=
Date:   Tue, 28 May 2019 07:10:04 +0000
Message-ID: <DB7PR05MB5573B5FC17FD1F221F7AAD558D1E0@DB7PR05MB5573.eurprd05.prod.outlook.com>
References: <DB7PR05MB5573AD842E430342E2BD011B8D1D0@DB7PR05MB5573.eurprd05.prod.outlook.com>
 <db2dcf54-8b1c-39b1-579c-425ef158c6a1@kdbg.org>
 <75618ca1-748d-0761-9108-c7deac63cb53@iee.org>
 <DB7PR05MB5573B5B80C8A9CBE867803D88D1E0@DB7PR05MB5573.eurprd05.prod.outlook.com>
 <fa23e865-94ed-308f-6a19-75b6ea89eec3@kdbg.org>
In-Reply-To: <fa23e865-94ed-308f-6a19-75b6ea89eec3@kdbg.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [140.207.1.78]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 708b57e9-38ca-48fe-07db-08d6e33b81ec
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600148)(711020)(4605104)(1401327)(2017052603328)(7193020);SRVR:DB7PR05MB5258;
x-ms-traffictypediagnostic: DB7PR05MB5258:
x-ms-exchange-purlcount: 2
x-microsoft-antispam-prvs: <DB7PR05MB525850818BBA65409CD1CC068D1E0@DB7PR05MB5258.eurprd05.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:7219;
x-forefront-prvs: 00514A2FE6
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(136003)(396003)(346002)(39860400002)(366004)(376002)(199004)(189003)(13464003)(966005)(316002)(71190400001)(5660300002)(71200400001)(52536014)(9686003)(8676002)(81156014)(81166006)(486006)(6306002)(8936002)(256004)(55016002)(14454004)(54906003)(14444005)(478600001)(2906002)(72206003)(3846002)(99286004)(6116002)(7696005)(66066001)(6436002)(6916009)(25786009)(102836004)(4326008)(76176011)(86362001)(66946007)(66446008)(66556008)(66476007)(73956011)(64756008)(26005)(53936002)(76116006)(6246003)(186003)(229853002)(33656002)(446003)(11346002)(476003)(68736007)(7736002)(53546011)(305945005)(74316002)(6506007);DIR:OUT;SFP:1102;SCL:1;SRVR:DB7PR05MB5258;H:DB7PR05MB5573.eurprd05.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: edenred.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: TSQjZcY0CCxxmlQxKn24ZgbGlrIuPj5wQ9KO+DI3bVt4PqRlhNBE/hhzz2GXFe92GF0KKrBsSYX5hCYohjAUsSSqmrD61Pj6g4vNg7L66MqQjWZwBsO9JyVCRGt8ZsyKrrzkJzycdhXdefwe3Uhwtv3nzx92JipD4R2q1V4fqWJfqV3KKXrq++E7qUSqfnD5eKGWlYaLx3jlh5oONwWqwIDYc6ruXCuf8tu2SM9mfXfqvbLCUGhanMqm4wHerjvvHmPZF7QcEPwPeR985LnkJh3lCOuOCgQzCl85FKucWwZUZOm37Altg6/wLMXMslT8FwEnoFPtOeA+SF+6ztZARHYCXCgQZGIB67vYfaMdXbn9Hx/mqOhYqzcuBJ9GYjMTjv6N80ZvvZUHXTuGaRu7oYjWYkGg8wG8bSQvfWk2lo4=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-Network-Message-Id: 708b57e9-38ca-48fe-07db-08d6e33b81ec
X-MS-Exchange-CrossTenant-originalarrivaltime: 28 May 2019 07:10:04.1199
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4c1d9e0f-5c27-4228-a35a-de7b4083ff7b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: chuck.lu@edenred.com
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB7PR05MB5258
X-OriginatorOrg: edenred.com
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2019-05-28_03:,,
 signatures=0
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

DQoNCj4gLS0tLS1PcmlnaW5hbCBNZXNzYWdlLS0tLS0NCj4gRnJvbTogSm9oYW5uZXMgU2l4dCA8
ajZ0QGtkYmcub3JnPg0KPiBTZW50OiBUdWVzZGF5LCBNYXkgMjgsIDIwMTkgMjoyMyBQTQ0KPiBU
bzogTFUgQ2h1Y2sgPENodWNrLkxVQGVkZW5yZWQuY29tPg0KPiBDYzogUGhpbGlwIE9ha2xleSA8
cGhpbGlwb2FrbGV5QGllZS5vcmc+OyBnaXRAdmdlci5rZXJuZWwub3JnOyBjaHVjay5sdUBxcS5j
b20NCj4gU3ViamVjdDogUmU6IGdpdCBmaWx0ZXItYnJhbmNoIHJlLXdyaXRlIGhpc3Rvcnkgb3Zl
ciBhIHJhbmdlIG9mIGNvbW1pdHMgZGlkIG5vdHdvcmsNCj4gDQo+IEFtIDI4LjA1LjE5IHVtIDA3
OjQyIHNjaHJpZWIgTFUgQ2h1Y2s6DQo+ID4+IEZyb206IFBoaWxpcCBPYWtsZXkgPHBoaWxpcG9h
a2xleUBpZWUub3JnPiBUaGUgdGhyZWUgZG90cyBpcyBwcm92aWRlZA0KPiA+PiBpbiB0aGUgbGl0
ZXJhbCBFWEFNUExFUyBzZWN0aW9uIG9mIHRoZSBtYW4gcGFnZS4gVGhhdCBpcyBwcm9iYWJseSBh
bg0KPiA+PiBlcnJvciwgYXMgSSB0aGluayBpdCBpcyBtZWFudCB0byBiZSBhbiBlbGxpcHNpcyB0
byBpbmRpY2F0ZSAnaW5zZXJ0DQo+ID4+IG90aGVyIG9wdGlvbnMgaGVyZScuDQo+ID4+DQo+ID4+
IFNpbXBseSByZW1vdmUgdGhlIHRocmVlIGRvdHMgKCdzeW1tZXRyaWMgZGlmZiBub3RhdGlvbicp
IC4NCj4gPj4NCj4gPj4gTm90IHN1cmUgd2hhdCB0aGUgY29ycmVjdCBjaGFuZ2UgdG8gdGhlIG1h
biBwYWdlIHNob3VsZCBiZSwgYnV0DQo+ID4+IGNsZWFybHkgaXQgaGFzIGNhdXNlZCBjb25mdXNp
b24uIEl0IGFsc28gdGFrZXMgYSBtb21lbnQgdG8gcHJvcGVybHkNCj4gPj4gcmVhbGlzZSB3aGlj
aCBjb21taXRzIHRoZSB0d28gZG90IG5vdGF0aW9uIHdpbGwgcmVmZXIgdG8gaW4gdGhlDQo+ID4+
IGV4YW1wbGUgd2hpY2ggbWF5IGZ1cnRoZXIgY29tcG91bmQgdGhlIGNvbmZ1c2lvbiBhYm91dCB0
aGUgdGhyZWUgZG90cy4NCj4gPj4NCj4gPj4gUGhpbGlwDQo+ID4gW0xVIENodWNrXSBIaSBIYW5u
ZXMsDQo+ID4gICAgICAgICAgSSB1c2VkIC4uLiBsaXRlcmFsbHkgd2hlbiBJIGNpdGVkIHRoZSBj
b21tYW5kLiBJIHdyaXRlIHRoZSBjb21tYW5kDQo+IHdpdGggLi4uIGRpcmVjdGx5IGFzIHRoZSBk
b2N1bWVudCBpbnRyb2R1Y2UgdGhlIHVzYWdlIGxpa2UgdGhhdC4NCj4gPiAgICAgICAgICBZb3Ug
Y2FuIGNoZWNrIHRoZSBkb2N1bWVudA0KPiBodHRwczovL3VybGRlZmVuc2UucHJvb2Zwb2ludC5j
b20vdjIvdXJsP3U9aHR0cHMtM0FfX2dpdC0yRHNjbS5jb21fZG9jc19naXQNCj4gLTJEZmlsdGVy
LTJEYnJhbmNoLTIzLTVGZXhhbXBsZXMmZD1Ed0lDYVEmYz1PMTdtNlVkcU9BSVpoOVhROHBUbDRn
Jg0KPiByPVZjR2VJZU9aXzhfemxyUU5TYm9lbllsdGZ4R05JWE5fcUc2VnBaZ1hWUmsmbT1WdU5k
T3pjZW82OFpVbktPQQ0KPiBjRVBLSmNXSkdWYmo5clZ4N21xRU1Ca0Y5cyZzPWZ3VF9Zc0hWSWNa
TGtaa1hjd04wWHpFZlladVpWdmtUaFNNLQ0KPiBWX28ybmE4JmU9ICBhYm91dCB0aGUgLS1lbnYt
ZmlsdGVyIHNlY3Rpb24uDQo+IA0KPiBDb3B5aW5nIGFuZCBwYXN0aW5nIGV4YW1wbGVzIGxpdGVy
YWxseSBpcyBkYW5nZXJvdXMuIFlvdSBzaG91bGQga25vdyB3aGF0IHlvdQ0KPiBhcmUgZG9pbmcu
DQo+IA0KPiAiLi4uIiBpcyBhIHJldmlzaW9uIHJhbmdlIHRoYXQgY29tcHV0ZXMgdGhlIG1lcmdl
YmFzZSBiZXR3ZWVuIEhFQUQgYW5kIEhFQUQsDQo+IHdoaWNoIGlzIChzdXJwcmlzZSEpIEhFQUQs
IGFuZCB0aGVuIGluY2x1ZGVzIHRoZSB0d28gZW5kIHBvaW50cywgYnV0IGV4Y2x1ZGVzDQo+IGV2
ZXJ5dGhpbmcgYmVsb3cgdGhlIG1lcmdlYmFzZS4gU28sIHRoZSByZXZpc2lvbiBzcGVjaWZpY2F0
aW9uIHRoYXQgeW91cg0KPiBjb21tYW5kIGVuZHMgdXAgd2l0aCBpcw0KPiANCj4gICAgICBIRUFE
IEhFQUQgXkhFQUQgXjY3ZDlkOSBmNzBiZjQNCj4gDQo+IFdoaWNoIGlzIGVtcHR5IGlmIGY3MGJm
NCBpcyBhbiBhbmNlc3RvciBvZiBIRUFELg0KW0xVIENodWNrXSBTb3JyeSwgSSBjYW4ndCB1bmRl
cnN0YW5kIHRoaXMgcGFydCwgZGlkIHlvdSBoYXZlIGFuIGRvY3VtZW50YXRpb24gYWJvdXQgdGhl
IGV4cGxhbmF0aW9uIGZvciAuLi4/DQogICAgICAgICAiY29tcHV0ZXMgdGhlIG1lcmdlYmFzZSBi
ZXR3ZWVuIEhFQUQgYW5kIEhFQUQiIEkgaGF2ZSBubyBpZGVhIGFib3V0IHRoaXMuIEFuZCB5b3Ug
YWxzbyB0YWxrZWQgYWJvdXQgbWVyZ2ViYXNlLCBidXQgaW4gbXkgc2l0dWF0aW9uLCB0aGVyZSBp
cyBvbmx5IG9uZSBicmFuY2ggd2l0aCA1IGNvbW1pdHMuIEkgZGlkIG5vdCBoYXZlIGEgbWVyZ2Vi
YXNlLg0KICAgICAgICAgWW91IGNhbiBjaGVjayB0aGUgZGV0YWlsIGRlc2NyaXB0aW9uIGJlbG93
Lg0KPiANCj4gPiAgICAgICAgICBIaSBQaGlsaXAsDQo+ID4gICAgICAgICAgSSBhbHNvIHRyaWVk
IHRvIGV4ZWN1dGUgdGhlIGNvbW1hbmQgd2l0aG91dCAuLi4sDQo+ID4gICAgICAgICAgZ2l0IGZp
bHRlci1icmFuY2ggLS1lbnYtZmlsdGVyICdleHBvcnQNCj4gR0lUX0NPTU1JVFRFUl9EQVRFPSIk
R0lUX0FVVEhPUl9EQVRFIicgNjdkOWQ5Li5mNzBiZjQNCj4gPiAgICAgICAgICB0aGVuIEkgd2ls
bCBnZXQgYW5vdGhlciBlcnJvciAiIFlvdSBtdXN0IHNwZWNpZnkgYSByZWYgdG8gcmV3cml0ZS4i
DQo+IA0KPiBZb3UgY2Fubm90IHJlc3RyaWN0IHlvdXIgZmlsdGVyIHRvIGEgc3Vic2V0IG9mIGNv
bW1pdHMgbGlrZSB0aGlzLiBBZnRlciBhbGwsIGFsbCBjb21taXRzDQo+IHRoYXQgZGVzY2VuZCBm
cm9tIG9uZSBvZiB0aGUgcmV3cml0dGVuIGNvbW1pdHMgbXVzdCBhbHNvIGNoYW5nZSwgdXAgdG8g
YW5kDQo+IGluY2x1ZGluZyB0byB0aGUgYnJhbmNoIHJlZnMuIFRoZXJlZm9yZSwgaXQgaXMgbmVj
ZXNzYXJ5IHRvIG1lbnRpb24gdGhlIGJyYW5jaGVzDQo+IHRoYXQgeW91IHJld3JpdGUgaW4gdGhp
cyBtYW5uZXIuDQo+IA0KPiBQZXJoYXBzOg0KPiANCj4gICAgZ2l0IGZpbHRlci1icmFuY2ggLS1l
bnYtZmlsdGVyICcNCj4gICAgICBpZiBnaXQgbWVyZ2UtYmFzZSAtLWlzLWFuY2VzdG9yICRHSVRf
Q09NTUlUIGY3MGJmNDsgdGhlbg0KPiAgICAgICAgZXhwb3J0IEdJVF9DT01NSVRURVJfREFURT0i
JEdJVF9BVVRIT1JfREFURSINCj4gICAgICBmaScgLS0gNjdkOWQ5Li5tYXN0ZXINCj4gDQo+IFRo
aXMgYXNzdW1lcyB0aGF0IG9ubHkgYnJhbmNoIG1hc3RlciBpcyBhZmZlY3RlZCBieSB0aGUgcmV3
cml0aW5nLiBVc2UgLS1hbGwgaWYgeW91DQo+IGhhdmUgbWFueSBhZmZlY3RlZCBicmFuY2hlcy4N
CltMVSBDaHVja10gSGkgSGFubmVzLA0KICAgICAgICAgSSBoYXZlIHRyaWVkIHdpdGggdGhlIGNv
bW1hbmQgeW91IHByb3ZpZGVkLCB3aGF0IEkgZ290IGlzIA0KICAgICAgICAgICAgIFJld3JpdGUg
MzFjZDVlZjZmMDY4YzQ2MjIyZmUxODU4NzBjMDljOTU5ZGQ3MTEzZSAoNy83KSAoNiBzZWNvbmRz
IHBhc3NlZCwgcmVtYWluaW5nIDAgcHJlZGljdGVkKQ0KICAgICAgICAgICAgIFdBUk5JTkc6IFJl
ZiAncmVmcy9oZWFkcy9tYXN0ZXInIGlzIHVuY2hhbmdlZA0KICAgICAgICAgSSBhbSB3b25kZXJp
bmcgd2h5IEkgZ290IHRoaXMgd2FybmluZywgd2hhdCBJIGRpZCBoYXZlIG5vdGhpbmcgdG8gZG8g
d2l0aCBtYXN0ZXIgYnJhbmNoLg0KICAgICAgICAgSSBhbSBub3Qgb24gYnJhbmNoIG1hc3Rlci4g
TXkgY3VycmVudCBicmFuY2ggaXMgdGVtcCBhbmQgSEVBRCBwb2ludCB0byB0ZW1wIGJyYW5jaCwg
YW5kIHRlbXAgcG9pbnQgdG8gY29tbWl0IGY3MGJmNC4NCiAgICAgICAgIEFjdHVhbGx5IHlvdSBj
YW4gY2xvbmUgdGhlIHJlcG9zaXRvcnkgaHR0cHM6Ly9naXRodWIuY29tL2NodWNrbHUvTGVldENv
ZGUgYW5kIGdpdCBjaGVja291dCAtYiB0ZW1wIG9yaWdpbi90ZW1wLiBUaGVuIGRvIGEgc2ltcGxl
IHRlc3QuDQoNCiAgICAgICAgIE15IHB1cnBvc2UgaXMgYXMgSSBtZW50aW9uZWQgaW4gbGFzdCBl
bWFpbCwNCiAgICAgICAgIEkgaGF2ZSBmaXZlIGNvbW1pdHMgQSxCLEMsRCxFIHdpdGggY29tbWl0
IGlkIGFzIGZvbGxvd2luZzoNCiAgICAgICAgIEEoNjdkOWQ5KTwtLUIoOWMxNTgwKTwtLUMoMmVl
YzRkKTwtLUQoYTQ1OTk1KTwtLUUoZjcwYmY0KSAgDQogICAgICAgICBUaGUgdGVtcCBicmFuY2gg
cG9pbnQgdG8gY29tbWl0IEUoZjcwYmY0KSBhbmQgdGhlIEhFQUQgcG9pbnQgdG8gdGVtcCBicmFu
Y2guDQogICAgICAgICBUaGUgY29tbWl0cyBCLEMsRCxFICdzIGNvbW1pdGVyIGRhdGUgYW5kIGF1
dGhvciBkYXRlIGFyZSBub3QgdGhlIHNhbWUuIEkgd2FudCB0byB1c2UgZmlsdGVyLWJyYW5jaCBj
b21tYW5kIHRvIG1ha2UgdGhlIGNvbW1pdGVyIGRhdGUgc2FtZSBhcyB0aGUgYXV0aG9yIGRhdGUu
DQoNCj4gDQo+IC0tIEhhbm5lcw0K
