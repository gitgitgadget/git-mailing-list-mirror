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
	by dcvr.yhbt.net (Postfix) with ESMTP id 093D41F462
	for <e@80x24.org>; Tue, 28 May 2019 09:59:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726463AbfE1J75 (ORCPT <rfc822;e@80x24.org>);
        Tue, 28 May 2019 05:59:57 -0400
Received: from mx07-002aaa01.pphosted.com ([185.132.180.47]:62908 "EHLO
        mx07-002aaa01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726282AbfE1J74 (ORCPT
        <rfc822;git@vger.kernel.org>); Tue, 28 May 2019 05:59:56 -0400
Received: from pps.filterd (m0118689.ppops.net [127.0.0.1])
        by mx07-002aaa01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x4S9u9II027696;
        Tue, 28 May 2019 09:59:54 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=edenred.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=dk201811;
 bh=GHgSsDt8o1QKNqG+uJEExKLSreazaGRNagknPkoRCww=;
 b=06ooYixfwY3Rki5KAaHW8KQtT1IZxLIi6KKJLApgAabuCeq9jnixAc20XLgnVn/GWu0R
 ooUtmQoUyzZNVf9EOO0SicY7MjaiRbo/4GIbxMMuFGePrijX6/5w8xhYGukgcxy06aZ6
 iIWtdQO1VgZ9lJr4aBF7QPV4eIehfgyNpF22/9oRewwcPC8KaGg2Ra/TNZG2wRWY7guM
 ZLfyOGPjfLigf3In7wZ6jJlxx5USLSk4sH8a6UL6nr1VDY5BoTVHcNJgPAlGuoYzDQGq
 RZDkfAIHj17TZ49xaG6QFmEUGtw53FmH099H/cX2VtdAdLHYtZQyRtCsM2cmCC0m9hG3 yA== 
Received: from ehq-smtp-usr-p.edenred.com ([204.103.47.131])
        by mx07-002aaa01.pphosted.com with ESMTP id 2ss2prg0ta-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-SHA384 bits=256 verify=NOT);
        Tue, 28 May 2019 09:59:53 +0000
Received: from ehq-smtp-usr-mx1p18-p.edenred.com () by
 ehq-smtp-usr-mx1p20-p.edenred.com () with  (TLS) id
 15.0.1395.4; Tue, 28 May 2019 11:59:53 +0200
Received: from EUR01-DB5-obe.outbound.protection.outlook.com (104.47.2.57) by
 ehq-smtp-usr-mx1p18-p.edenred.com () with  (TLS) id 15.0.1395.4
 via Frontend Transport; Tue, 28 May 2019 11:59:53 +0200
Received: from DB7PR05MB5573.eurprd05.prod.outlook.com (20.177.193.214) by
 DB7PR05MB4122.eurprd05.prod.outlook.com (52.134.107.139) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1922.17; Tue, 28 May 2019 09:59:52 +0000
Received: from DB7PR05MB5573.eurprd05.prod.outlook.com
 ([fe80::d93a:e741:155:318d]) by DB7PR05MB5573.eurprd05.prod.outlook.com
 ([fe80::d93a:e741:155:318d%6]) with mapi id 15.20.1922.021; Tue, 28 May 2019
 09:59:52 +0000
From:   LU Chuck <Chuck.LU@edenred.com>
To:     Johannes Sixt <j6t@kdbg.org>
CC:     "git@vger.kernel.org" <git@vger.kernel.org>,
        "chuck.lu@qq.com" <chuck.lu@qq.com>
Subject: RE: git filter-branch re-write history over a range of commits did
 notwork
Thread-Topic: git filter-branch re-write history over a range of commits did
 notwork
Thread-Index: AdUUYk+0TU9swc+jQ+aKfvGwOQfe0wAVrIqAACCQbwA=
Date:   Tue, 28 May 2019 09:59:52 +0000
Message-ID: <DB7PR05MB557357AAFE0F0C011A8B0C388D1E0@DB7PR05MB5573.eurprd05.prod.outlook.com>
References: <DB7PR05MB5573AD842E430342E2BD011B8D1D0@DB7PR05MB5573.eurprd05.prod.outlook.com>
 <db2dcf54-8b1c-39b1-579c-425ef158c6a1@kdbg.org>
In-Reply-To: <db2dcf54-8b1c-39b1-579c-425ef158c6a1@kdbg.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [140.207.1.78]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 1630cb1a-8086-4652-f0de-08d6e3533a7f
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600148)(711020)(4605104)(1401327)(2017052603328)(7193020);SRVR:DB7PR05MB4122;
x-ms-traffictypediagnostic: DB7PR05MB4122:
x-ms-exchange-purlcount: 5
x-microsoft-antispam-prvs: <DB7PR05MB4122832136567B34ECBF36FB8D1E0@DB7PR05MB4122.eurprd05.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:597;
x-forefront-prvs: 00514A2FE6
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(396003)(346002)(136003)(376002)(39860400002)(366004)(13464003)(51874003)(189003)(199004)(66066001)(316002)(73956011)(4326008)(7736002)(966005)(33656002)(72206003)(52536014)(14454004)(86362001)(9686003)(6306002)(8676002)(55016002)(68736007)(305945005)(5660300002)(25786009)(6436002)(81156014)(81166006)(8936002)(478600001)(229853002)(66446008)(6246003)(102836004)(76116006)(53936002)(256004)(19627235002)(11346002)(486006)(26005)(446003)(186003)(476003)(74316002)(99286004)(6916009)(54906003)(71200400001)(71190400001)(66556008)(66476007)(66946007)(64756008)(76176011)(2906002)(6506007)(53546011)(7696005)(6116002)(3846002);DIR:OUT;SFP:1102;SCL:1;SRVR:DB7PR05MB4122;H:DB7PR05MB5573.eurprd05.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: edenred.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: Eh7aBtu6aJyAAY2Ij8kjQTcOC3UR5lk9jsq+PoLaKAZd5PkFPDOVprreCEy3T8lg2EcbJFyDFv86JAtMVC+Z0/gPelTURneHNdVYAiB244Aqrf0s8xXUmJzyCsPmKXZ7AhT9Lz38dce77w41B77kc4DsBwbp3zuKCta6gRb6lG+zsQDnbXNqVK9EYpjJ9YVk+6KftG1kreu6sD+yauY/t1dRf8dxR7ah1QwtW6zyEqprNspN881TRWrcVTobfUlHIDgE5NAGj2c7iA7JzvOn047N1fSjZbShYizzr0cBBnBkowgIRs+l0FS0QA1MXinrZpWX/6TBHhZeBirH1ohKozCZ6alHyxMBi7XjfbTtxCzZh/igvha4pJLMzdtbPbfin0wiugHzfLcZzSBcUUgaiEIYfotr4DGpkufMZYluKiI=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-Network-Message-Id: 1630cb1a-8086-4652-f0de-08d6e3533a7f
X-MS-Exchange-CrossTenant-originalarrivaltime: 28 May 2019 09:59:52.2418
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4c1d9e0f-5c27-4228-a35a-de7b4083ff7b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: chuck.lu@edenred.com
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB7PR05MB4122
X-OriginatorOrg: edenred.com
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2019-05-28_04:,,
 signatures=0
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

DQoNCj4gLS0tLS1PcmlnaW5hbCBNZXNzYWdlLS0tLS0NCj4gRnJvbTogSm9oYW5uZXMgU2l4dCA8
ajZ0QGtkYmcub3JnPg0KPiBTZW50OiBUdWVzZGF5LCBNYXkgMjgsIDIwMTkgMjoyMiBBTQ0KPiBU
bzogTFUgQ2h1Y2sgPENodWNrLkxVQGVkZW5yZWQuY29tPg0KPiBDYzogZ2l0QHZnZXIua2VybmVs
Lm9yZzsgY2h1Y2subHVAcXEuY29tDQo+IFN1YmplY3Q6IFJlOiBnaXQgZmlsdGVyLWJyYW5jaCBy
ZS13cml0ZSBoaXN0b3J5IG92ZXIgYSByYW5nZSBvZiBjb21taXRzIGRpZCBub3R3b3JrDQo+IA0K
PiBBbSAyNy4wNS4xOSB1bSAxMDowMSBzY2hyaWViIExVIENodWNrOg0KPiA+IEhpIHRlYW0sDQo+
ID4NCj4gPiAgICAgVGhlIGlzc3VlIGNvbWVzIGZyb20NCj4gaHR0cHM6Ly91cmxkZWZlbnNlLnBy
b29mcG9pbnQuY29tL3YyL3VybD91PWh0dHBzLTNBX19naXRodWIuY29tX2dpdC0yRGZvci0yDQo+
IER3aW5kb3dzX2dpdF9pc3N1ZXNfMjIwNiZkPUR3SUNhUSZjPU8xN202VWRxT0FJWmg5WFE4cFRs
NGcmcj1WY0dlDQo+IEllT1pfOF96bHJRTlNib2VuWWx0ZnhHTklYTl9xRzZWcFpnWFZSayZtPVBD
UzFNMWlmZHg2c0E4VE1DcDdTY0tBDQo+IDMtSGpVZkFhamVQWmZHblEtOTRvJnM9Sjd2dE5jNklo
RWNydVpKQmVDUEpKTTJYUl96Qy0xWjBKWG1OeDlrNWMzcyZlDQo+ID0gLg0KPiA+DQo+ID4gICAg
IEkgd2FudCB0byByZS13cml0ZSBoaXN0b3J5IGJ5IGZpbHRlci1icmFuY2ggY29tbWFuZCBvdmVy
IGEgcmFuZ2Ugb2YNCj4gY29tbWl0cywgYnV0IHRoZSBjb21tYW5kIGRpZCBub3Qgd29yay4NCj4g
PiAgICAgSSBoYXZlIHJlZmVycmVkIHRvIHRoZSBmb2xsb3dpbmcgdGhyZWUgZG9jdW1lbnRhdGlv
biBhYm91dCBob3cgdG8gdXNlIGdpdA0KPiBmaWx0ZXItYnJhbmNoOg0KPiA+DQo+IGh0dHBzOi8v
dXJsZGVmZW5zZS5wcm9vZnBvaW50LmNvbS92Mi91cmw/dT1odHRwcy0zQV9fc3RhY2tvdmVyZmxv
dy5jb21fcXVlcw0KPiB0aW9uc18xNTI1MDA3MF9ydW5uaW5nLTJEZmlsdGVyLTJEYnJhbmNoLTJE
b3Zlci0yRGEtMkRyYW5nZS0yRG9mLTJEY29tDQo+IG1pdHMmZD1Ed0lDYVEmYz1PMTdtNlVkcU9B
SVpoOVhROHBUbDRnJnI9VmNHZUllT1pfOF96bHJRTlNib2VuWWx0Zg0KPiB4R05JWE5fcUc2VnBa
Z1hWUmsmbT1QQ1MxTTFpZmR4NnNBOFRNQ3A3U2NLQTMtSGpVZkFhamVQWmZHblEtOTRvDQo+ICZz
PVhaVHRQa0VxYWpkY0cxdUR4aVgwQUFYN0YyUmFmMGpjdWJ3R1RLRnRxdjAmZT0NCj4gPg0KPiBo
dHRwczovL3VybGRlZmVuc2UucHJvb2Zwb2ludC5jb20vdjIvdXJsP3U9aHR0cHMtM0FfX3N0YWNr
b3ZlcmZsb3cuY29tX3F1ZXMNCj4gdGlvbnNfMjg1MzY5ODBfZ2l0LTJEY2hhbmdlLTJEY29tbWl0
LTJEZGF0ZS0yRHRvLTJEYXV0aG9yLTJEZGF0ZSZkPUQNCj4gd0lDYVEmYz1PMTdtNlVkcU9BSVpo
OVhROHBUbDRnJnI9VmNHZUllT1pfOF96bHJRTlNib2VuWWx0ZnhHTklYTl9xDQo+IEc2VnBaZ1hW
UmsmbT1QQ1MxTTFpZmR4NnNBOFRNQ3A3U2NLQTMtSGpVZkFhamVQWmZHblEtOTRvJnM9NnNjQzAN
Cj4gUHlSRXp3RTY3d0FlclZnUHRkTy1uZ18zUV9NMUlyOHNXSFhtZnMmZT0NCj4gPg0KPiA+IGh0
dHBzOi8vdXJsZGVmZW5zZS5wcm9vZnBvaW50LmNvbS92Mi91cmw/dT1odHRwcy0zQV9fZ2l0LTJE
c2NtLmNvbV9kb2MNCj4gPg0KPiBzX2dpdC0yRGZpbHRlci0yRGJyYW5jaCZkPUR3SUNhUSZjPU8x
N202VWRxT0FJWmg5WFE4cFRsNGcmcj1WY0dlSWVPWg0KPiBfOA0KPiA+DQo+IF96bHJRTlNib2Vu
WWx0ZnhHTklYTl9xRzZWcFpnWFZSayZtPVBDUzFNMWlmZHg2c0E4VE1DcDdTY0tBMy1IalVmDQo+
IEFhamVQDQo+ID4gWmZHblEtOTRvJnM9dFdicmN6b1BiMTFZd3I3WTdIUE84LUxhWFdoYnFyRTRx
Nml5ckNhYk5zayZlPQ0KPiA+DQo+ID4gICAgIFlvdSBjYW4gcmVwcm9kdWNlIHRoZSBwcm9ibGVt
IGJ5IHRoZSBmb2xsb3dpbmcgc3RlcHMNCj4gPiAgICAgMS4gY2xvbmUgdGhlIHJlcG9zaXRvcnkN
Cj4gaHR0cHM6Ly91cmxkZWZlbnNlLnByb29mcG9pbnQuY29tL3YyL3VybD91PWh0dHBzLTNBX19n
aXRodWIuY29tX2NodWNrbHVfTGVlDQo+IHRDb2RlXyZkPUR3SUNhUSZjPU8xN202VWRxT0FJWmg5
WFE4cFRsNGcmcj1WY0dlSWVPWl84X3psclFOU2JvZW4NCj4gWWx0ZnhHTklYTl9xRzZWcFpnWFZS
ayZtPVBDUzFNMWlmZHg2c0E4VE1DcDdTY0tBMy1IalVmQWFqZVBaZkduUS0NCj4gOTRvJnM9RzB1
bk1yUlFyb1VLM2VFM3d1N3hCSUdIOU5iTzA1eWRrRllST0tvSWNVMCZlPQ0KPiA+ICAgICAyLiBj
aGVja291dCB0byB0aGUgdGVtcCBicmFuY2gNCj4gPiAgICAgMy4gcnVuIHRoZSBjb21tYW5kIGdp
dCBmaWx0ZXItYnJhbmNoIC0tZW52LWZpbHRlciAnZXhwb3J0DQo+ID4gR0lUX0NPTU1JVFRFUl9E
QVRFPSIkR0lUX0FVVEhPUl9EQVRFIicgLi4uIDY3ZDlkOS4uZjcwYmY0DQo+IA0KPiBEaWQgeW91
IG5vdCB0ZWxsIHVzIGV2ZXJ5dGhpbmcgYmVjYXVzZSB5b3Ugd3JpdGUgLi4uIGluIHRoaXMgbWVz
c2FnZSB3aGVuIHlvdSBjaXRlZA0KPiB0aGUgY29tbWFuZCB5b3UgdXNlZCwgb3IgZG8geW91IHNh
eSB0aGF0IHlvdSB1c2VkIC4uLg0KPiBsaXRlcmFsbHkgaW4gdGhlIGNvbW1hbmQ/DQpbTFUgQ2h1
Y2tdIExldCdzIG1vdmUgYmFjayBoZXJlLCBJIGtub3cgd2hhdCB0aHJlZSBkb3RzIGRvZXMgbm93
LiBBY2NvcmRpbmcgdGhpcyBkb2N1bWVudGF0aW9uIGh0dHBzOi8vZ2l0LXNjbS5jb20vZG9jcy9n
aXRyZXZpc2lvbnMjRG9jdW1lbnRhdGlvbi9naXRyZXZpc2lvbnMudHh0LVRoZWVtODIzMDgyMDNl
bXRocmVlLWRvdFN5bW1ldHJpY0RpZmZlcmVuY2VOb3RhdGlvbiAuDQogICAgICAgICBUaGVuIHRo
ZSBjb21tYW5kIEkgbmVlZCB0byBydW4gaXMgZ2l0IGZpbHRlci1icmFuY2ggLS1lbnYtZmlsdGVy
ICdleHBvcnQgR0lUX0NPTU1JVFRFUl9EQVRFPSIkR0lUX0FVVEhPUl9EQVRFIicgNjdkOWQ5Li5m
NzBiZjQgDQogICAgICAgICBCdXQgd2h5IEkgZ290IHRoZSBlcnJvciBtZXNzYWdlICIgWW91IG11
c3Qgc3BlY2lmeSBhIHJlZiB0byByZXdyaXRlLiAiLg0KDQogICAgICAgICBXaGVuIEkgdXNlIGNv
bW1hbmQgIiBnaXQgbG9nIDY3ZDlkOS4uZjcwYmY0ICIsIGl0IHdpbGwgbGlzdCA0IGNvbW1pdHMu
IEl0IG1lYW5zIHRoZSBjb21taXRzIHJhbmdlIHdvcmtzLg0KICAgICAgICAgU28sIHRoZSBwcm9i
bGVtIHdvdWxkIGJlLCB3aHkgdGhlIGdpdCBmaWx0ZXItYnJhbmNoIGNvdWxkIG5vdCByZWNvZ25p
emVkIDY3ZDlkOS4uZjcwYmY0IGFzIGEgcmFuZ2Ugb2YgY29tbWl0cz8NCg0KPiANCj4gPiAgICAg
NC4gWW91IHdpbGwgZ290IHRoZSBpbmZvICJGb3VuZCBub3RoaW5nIHRvIHJld3JpdGUiDQo+ID4N
Cj4gPiAgICAgSG93ZXZlciwgaXQgd2FzIHN1cHBvc2VkIHRvIG92ZXJ3cml0ZSB0aGUgaGlzdG9y
eSBmcm9tIGNvbW1pdCA5YzE1ODAgdG8NCj4gY29tbWl0IGY3MGJmNCwgbWFrZSB0aGUgY29tbWl0
IGRhdGUgc2FtZSBhcyBkYXRlLg0KPiA+ICAgICBJIGFtIG5vdCBzdXJlIGlmIEkgYW0gdXNpbmcg
dGhlIGZpbHRlci1icmFuY2ggY29ycmVjdGx5LCBvciBpZiB0aGVyZSBpcyBhIGJ1ZyBpbg0KPiBn
aXQ/DQo+ID4NCj4gPiAgICAgQW55b25lIGNhbiBoZWxwIG1lPyBUaGFua3MgaW4gYWR2YW5jZS4N
Cj4gDQo+IC0tIEhhbm5lcw0K
