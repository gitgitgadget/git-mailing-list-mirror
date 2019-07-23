Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_NONE
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 122591F461
	for <e@80x24.org>; Tue, 23 Jul 2019 20:05:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732547AbfGWUFR (ORCPT <rfc822;e@80x24.org>);
        Tue, 23 Jul 2019 16:05:17 -0400
Received: from mx0a-00103a01.pphosted.com ([67.231.144.234]:39306 "EHLO
        mx0a-00103a01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727811AbfGWUFQ (ORCPT
        <rfc822;git@vger.kernel.org>); Tue, 23 Jul 2019 16:05:16 -0400
X-Greylist: delayed 1316 seconds by postgrey-1.27 at vger.kernel.org; Tue, 23 Jul 2019 16:05:15 EDT
Received: from pps.filterd (m0174892.ppops.net [127.0.0.1])
        by mx0a-00103a01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id x6NJdxpl007875;
        Tue, 23 Jul 2019 15:43:06 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ciena.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=06252019;
 bh=f6ENWuwUG9ZqJ15EVPmduizAQ7jnyaDQH+7uI0t0KP0=;
 b=YE61nlF61n+AY7Z/U94YXPVKsWqsNnCEWwHT1U7dPRGWVN/xe9gTbV3qmDJcZ+kBuVUX
 t4Ls17J7X3jwYs9meLLkgLbZq9iyUNuvjycoAHrvZRjqh2ZGk0TJviV05nxq821nxDpd
 T76fM2rGBQhWvaGIF9pR5UH2c9qBLpZhtyrQLsiV6vzfB15fUyIfFOfaDQxqV7VL7RuJ
 METeI7X/uocVdl7nyVfRZ8pUND35xpYG8aabBuR8bmkhcCXgIzdXM/geWt0YakdaYJMK
 F+U0VU19fpcy9UIjv/AoEtDPC46c8nnQUzRUmzcgsYOsaZfoWMaJaUhVMt4blrLxBHqe qg== 
Received: from nam05-dm3-obe.outbound.protection.outlook.com (mail-dm3nam05lp2056.outbound.protection.outlook.com [104.47.49.56])
        by mx0a-00103a01.pphosted.com with ESMTP id 2tx61rgv2c-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-SHA384 bits=256 verify=NOT);
        Tue, 23 Jul 2019 15:43:05 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=EOF8kZJ8VRwbbGOQGT47/6pNjCcR3YamPVQO8IMDalFe1cPZK7H2lbmOVv3uP/8EmJn2/vxXLSqOr9+yd8nAjVthzttdI8fe0mkxhR4yc76HEeEfxaK3NesH+MgRgJT7n4GlPGrR5vYsmv6Cji7/lI29lH8akhD87TXTLlfsoAn54C268+nxR/4BJxpwV3/QoJ81y4xHbNblPdzmbFtgMwC+o3WU5C/FmASYtGPGBVepjkM0KQtXbgy7eqn1iqd9QicsSL6xYTVW6DN1rljunR5IPcDpWmfPb+pfTnYjO8UPKQz9FwON6K1b5cmWhuDH2QyH5XN94T5Kum/Ctq4QpQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=f6ENWuwUG9ZqJ15EVPmduizAQ7jnyaDQH+7uI0t0KP0=;
 b=MBKXyu+GCiVbnVq5ChhOgUhMz7iLkNXiBJTG/ZqRcvDyqhPotjsgHiaqAfO1F6tA9/NX+3DhbgYmx3U/Ib8zggVQZx/BPuXjgjs0+7vYed2qjUgASfqMzOKre4KRPhzPhfK9QbyoI6zwY80ljZjV6TYfjenOglSitj2JQdUYSG0LaoklfnYYiuYCsHDCq3SNMOyydi03SNCc5n3FwCQh2krYM4G+ynVeLIN9D5lV9ynMNyA35pehdxgQTNUniYEY+kOif7RnOi4CkS8qxLfKakIBIQ9oM6/SwsyStcVQI5Kj/HU+73awnXHuVxBAXOTBNsFv2UakStRD/RUjHfKlig==
ARC-Authentication-Results: i=1; mx.microsoft.com 1;spf=pass
 smtp.mailfrom=ciena.com;dmarc=pass action=none
 header.from=ciena.com;dkim=pass header.d=ciena.com;arc=none
Received: from DM6PR04MB4793.namprd04.prod.outlook.com (20.176.107.210) by
 DM6PR04MB3932.namprd04.prod.outlook.com (20.176.87.13) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2094.17; Tue, 23 Jul 2019 19:43:02 +0000
Received: from DM6PR04MB4793.namprd04.prod.outlook.com
 ([fe80::a023:f649:f717:6068]) by DM6PR04MB4793.namprd04.prod.outlook.com
 ([fe80::a023:f649:f717:6068%6]) with mapi id 15.20.2094.013; Tue, 23 Jul 2019
 19:43:01 +0000
From:   "Raitanen, Adam" <araitane@ciena.com>
To:     Jeff King <peff@peff.net>
CC:     James Knight <james.d.knight@live.com>,
        "git@vger.kernel.org" <git@vger.kernel.org>
Subject: RE: [**EXTERNAL**] Re: Possible bug in Makefile when executing
 curl-config
Thread-Topic: [**EXTERNAL**] Re: Possible bug in Makefile when executing
 curl-config
Thread-Index: AdVAxiwguVNvTN0bQWKLWMnA3UfWZQAC/kmAAC8NhxA=
Date:   Tue, 23 Jul 2019 19:43:01 +0000
Message-ID: <DM6PR04MB479387667E7EDEF2A27BFCA2D0C70@DM6PR04MB4793.namprd04.prod.outlook.com>
References: <DM6PR04MB47939645A97D099241AD25F0D0C40@DM6PR04MB4793.namprd04.prod.outlook.com>
 <20190722211219.GB31664@sigill.intra.peff.net>
In-Reply-To: <20190722211219.GB31664@sigill.intra.peff.net>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [174.115.212.20]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: ced4b264-a217-496f-85e2-08d70fa5f91d
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600148)(711020)(4605104)(1401327)(2017052603328)(7193020);SRVR:DM6PR04MB3932;
x-ms-traffictypediagnostic: DM6PR04MB3932:
x-ms-exchange-purlcount: 1
x-microsoft-antispam-prvs: <DM6PR04MB39323CCB405C72058F7A979DD0C70@DM6PR04MB3932.namprd04.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:10000;
x-forefront-prvs: 0107098B6C
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(979002)(4636009)(396003)(136003)(376002)(346002)(39860400002)(366004)(13464003)(199004)(189003)(55016002)(99286004)(33656002)(2906002)(6916009)(14444005)(6246003)(256004)(81156014)(6506007)(53546011)(53936002)(54906003)(26005)(14454004)(316002)(486006)(229853002)(81166006)(76176011)(966005)(186003)(8936002)(102836004)(8676002)(478600001)(4326008)(6436002)(25786009)(64756008)(74316002)(66556008)(66446008)(66946007)(66476007)(305945005)(446003)(66066001)(5660300002)(86362001)(7736002)(3846002)(476003)(52536014)(71190400001)(71200400001)(7696005)(6116002)(9686003)(11346002)(68736007)(76116006)(6306002)(969003)(989001)(999001)(1009001)(1019001);DIR:OUT;SFP:1101;SCL:1;SRVR:DM6PR04MB3932;H:DM6PR04MB4793.namprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: ciena.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: 1Ov4o3AOnViIqHZRvslv39bgVRfttpfFEzk4cMenSXx7i3weWbwJsoUOa5JEpriv0ykb2UYMzCkPRvHSBatFVTDEAWa4OSZgdKC/aTceTYDmhU8TLEUjRRY85QCorMFWnyEdbX4yS+azIGFcibn5qNJ7iUvQwpP2ojpucj+6D5tcaZZ+RIX4+gBXvUct7f8DRxENHoJ/fiytGYNRLp/ZaQWwtXN2l4PT7YW74oZ7Cw7ZEqT9a/47N2BVpZ2C5Y/0OHEf+Gp4QwgkSaQhMHNO4cU54nqw4/hKbQIJiVSs2KqnLLdrt9J1qDljlAupeS5c0rntQrxRRavmBrkKvv/ld+3F3g5r/fJWjTMYg1Qs8yOZ19xn4+458HtAM+Td5Bsu8gax10JH9ukMlIp+nq2Gp96j2sPHQJbtegLdAzWia58=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: ciena.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ced4b264-a217-496f-85e2-08d70fa5f91d
X-MS-Exchange-CrossTenant-originalarrivaltime: 23 Jul 2019 19:43:01.8467
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 457a2b01-0019-42ba-a449-45f99e96b60a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: araitane@ciena.com
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR04MB3932
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:5.22.84,1.0.8
 definitions=2019-07-23_08:2019-07-23,2019-07-23 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxscore=0 clxscore=1011
 priorityscore=1501 malwarescore=0 suspectscore=0 spamscore=0 adultscore=0
 lowpriorityscore=0 bulkscore=0 mlxlogscore=999 impostorscore=0
 phishscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-1906280000 definitions=main-1907230200
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

WWVzIHRoZXJlIGlzIGEgY29uZmlnLm1hay5hdXRvZ2VuIGFuZCBpdCBkb2VzIG5vdCBoYXZlIGFu
IGVudHJ5IGZvciBDVVJMX0NPTkZJRywgYWx0aG91Z2ggaXQgaGFzIGEgY29ycmVjdCBlbnRyeSBm
b3IgQ1VSTERJUi4NCg0KVGhlIGNvbmZpZy5sb2cgYWxzbyBzaG93cyBpdCBjaGVja2luZyBmb3Ig
Y3VybC1jb25maWcgYW5kIG5vdCBmaW5kaW5nIGl0IHRoZW4gcHJvY2VlZGluZyBhbnl3YXk6DQoN
CmNvbmZpZ3VyZTo1OTE3OiBjaGVja2luZyBmb3IgY3VybC1jb25maWcNCmNvbmZpZ3VyZTo1OTQ1
OiByZXN1bHQ6IG5vDQouLi4NCg0KLS0tLS1PcmlnaW5hbCBNZXNzYWdlLS0tLS0NCkZyb206IEpl
ZmYgS2luZyA8cGVmZkBwZWZmLm5ldD4gDQpTZW50OiBNb25kYXksIEp1bHkgMjIsIDIwMTkgNTox
MiBQTQ0KVG86IFJhaXRhbmVuLCBBZGFtIDxhcmFpdGFuZUBjaWVuYS5jb20+DQpDYzogSmFtZXMg
S25pZ2h0IDxqYW1lcy5kLmtuaWdodEBsaXZlLmNvbT47IGdpdEB2Z2VyLmtlcm5lbC5vcmcNClN1
YmplY3Q6IFsqKkVYVEVSTkFMKipdIFJlOiBQb3NzaWJsZSBidWcgaW4gTWFrZWZpbGUgd2hlbiBl
eGVjdXRpbmcgY3VybC1jb25maWcNCg0KWytjYyB0aGUgYXV0aG9yIG9mIHRoYXQgcGF0Y2hdDQoN
Ck9uIE1vbiwgSnVsIDIyLCAyMDE5IGF0IDA3OjQ2OjM3UE0gKzAwMDAsIFJhaXRhbmVuLCBBZGFt
IHdyb3RlOg0KDQo+IEkgYmVsaWV2ZSB0aGVyZSBtYXkgYmUgYSBidWcgaW4gdGhlIE1ha2VmaWxl
IGludHJvZHVjZWQgYnkgdGhlIGZvbGxvd2luZyBjb21taXQ6DQo+IA0KPiBodHRwczovL2dpdGh1
Yi5jb20vZ2l0L2dpdC9jb21taXQvMjNjNGJiZTI4ZTYxOTc0NTc3MTY0ZGIwOWNiZDFkMWM3ZTU2
DQo+IDhjYTQNCj4gDQo+IFRoZSBjb21taXQgd2FzIG1lcmdlZCBpbiAyLjIwLjA6DQo+IA0KPiAq
IFRoZSB3YXkgLWxjdXJsIGxpYnJhcnkgZ2V0cyBsaW5rZWQgaGFzIGJlZW4gc2ltcGxpZmllZCBi
eSB0YWtpbmcNCj4gwqDCoCBhZHZhbnRhZ2Ugb2YgdGhlIGZhY3QgdGhhdCB3ZSBjYW4ganVzdCBh
c2sgY3VybC1jb25maWcgY29tbWFuZCBob3cuDQo+IA0KPiBVbmZvcnR1bmF0ZWx5IGl0IGFzc3Vt
ZXMgdGhhdCBjdXJsLWNvbmZpZyBpcyBpbiB0aGUgcGF0aCB3aGljaCBpcyBub3QgDQo+IGFsd2F5
cyB0aGUgY2FzZS4gV2hlbiB1c2luZyAiLS13aXRoLWN1cmw9L3BhdGgvdG8vY3VybCIgaW4gdGhl
IA0KPiBjb25maWd1cmUgY29tbWFuZCwgdGhlIHBhdGggdG8gdGhlIGFjdHVhbCBjdXJsLWNvbmZp
ZyBleGVjdXRhYmxlIGlzIA0KPiBpZ25vcmVkIGFuZCB0aGUgYnVpbGQgZmFpbHMgYXJvdW5kIGhl
cmU6DQo+IA0KPiDCoMKgwqAgQ0MgaHR0cC1mZXRjaC5vDQo+IG1ha2U6IGN1cmwtY29uZmlnOiBD
b21tYW5kIG5vdCBmb3VuZA0KPiDCoMKgwqAgTElOSyBnaXQtaHR0cC1mZXRjaA0KPiBodHRwLm86
IEluIGZ1bmN0aW9uIGBmaWxsX2FjdGl2ZV9zbG90cyc6DQo+IC90bXAvZ2l0LTIuMjEuMC9odHRw
LmM6MTM4NTogdW5kZWZpbmVkIHJlZmVyZW5jZSB0byBgY3VybF9lYXN5X2NsZWFudXAnDQo+IC4N
Cj4gDQo+IFdlIHdlcmUgYWJsZSB0byB3b3JrYXJvdW5kIHRoaXMgYnkgZm9yY2luZyB0aGUgY29y
cmVjdCBwYXRoIGludG8gdGhlIG1ha2UgZW52Og0KPiANCj4gbWFrZSBDVVJMX0xERkxBR1M9IiQo
L3BhdGgvdG8vY3VybC9jdXJsLWNvbmZpZyAtLWxpYnMpIi4NCj4gDQo+IEkgcmVwcm9kdWNlZCB0
aGUgcHJvYmxlbSBpbiB0aGUgbGF0ZXN0IHZlcnNpb24gMi4yMi4wLg0KDQpGb3IgdGhlIGNhc2Ug
d2l0aG91dCBhdXRvY29uZiwgSSB0aGluayB1c2luZyBDVVJMX0xERkxBR1MgaXMgdGhlIGludGVu
ZGVkIHNhZmV0eSB2YWx2ZS4gVGhvdWdoIHBlcmhhcHMgd2Ugc2hvdWxkIGJlIGZhbGxpbmcgYmFj
ayBtb3JlIGdyYWNlZnVsbHkgdG8gdGhlIG9sZCBiZWhhdmlvciwgbGlrZToNCg0KZGlmZiAtLWdp
dCBhL01ha2VmaWxlIGIvTWFrZWZpbGUNCmluZGV4IDExY2NlYTQwNzEuLjI3ZTU0NmJiZmMgMTAw
NjQ0DQotLS0gYS9NYWtlZmlsZQ0KKysrIGIvTWFrZWZpbGUNCkBAIC0xMzQzLDcgKzEzNDMsNyBA
QCBlbHNlDQogaWZkZWYgQ1VSTF9MREZMQUdTDQogCUNVUkxfTElCQ1VSTCArPSAkKENVUkxfTERG
TEFHUykNCiBlbHNlDQotCUNVUkxfTElCQ1VSTCArPSAkKHNoZWxsICQoQ1VSTF9DT05GSUcpIC0t
bGlicykNCisJQ1VSTF9MSUJDVVJMICs9ICQoc2hlbGwgJChDVVJMX0NPTkZJRykgLS1saWJzIHx8
IGVjaG8gLWxjdXJsKQ0KIGVuZGlmDQogDQogCVJFTU9URV9DVVJMX1BSSU1BUlkgPSBnaXQtcmVt
b3RlLWh0dHAkWA0KDQp3aGljaCBzaG91bGQgd29yayBvbiBtb3N0IHN5c3RlbXMuDQoNCkZvciB5
b3VyIHNwZWNpZmljIGNhc2UsIHdoZXJlIHlvdSBfZG9fIGhhdmUgY3VybC1jb25maWcgYnV0IGl0
J3MganVzdCBub3QgaW4gdGhlIFBBVEgsIHRoZW4gSSB0aGluazoNCg0KICBtYWtlIENVUkxfQ09O
RklHPS9wYXRoL3RvL2N1cmwtY29uZmlnDQoNCndvdWxkIGJlIGEgc2xpZ2h0bHkgY2xlYW5lciBz
b2x1dGlvbi4NCg0KQnV0IGl0IHNvdW5kcyBsaWtlIHlvdSBfZGlkXyB1c2UgdGhlIGF1dG9jb25m
IHNjcmlwdCwgYnV0IGl0IGRpZCBub3QgY29ycmVjdGx5IHNldCBDVVJMX0NPTkZJRy4gRG8geW91
IGhhdmUgYSBjb25maWcubWFrLmF1dG9nZW4gZmlsZSBhZnRlciBydW5uaW5nIC4vY29uZmlndXJl
LCBhbmQgaWYgc28sIGRvZXMgaXQgaGF2ZSBhbiBlbnRyeSBmb3IgQ1VSTF9DT05GSUc/DQoNCkkn
bSBub3QgdG9vIGZhbWlsaWFyIHdpdGggb3VyIGNvbmZpZ3VyZS5hYywgYnV0IGl0IGxvb2tzIGxp
a2UgLS13aXRoLWN1cmwgbWlnaHQganVzdCBwb2ludCBzb21lIHBhdGhzIGZvciBoZWFkZXIvaW5j
bHVkZSBmaWxlcywgYW5kIG5vdCBhY3R1YWxseSB1cGRhdGUgdGhlIGN1cmwtY29uZmlnIHBhdGgu
DQoNCi1QZWZmDQo=
