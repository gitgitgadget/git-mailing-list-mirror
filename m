Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.8 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 8CA421F461
	for <e@80x24.org>; Fri, 28 Jun 2019 16:18:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726770AbfF1QSt (ORCPT <rfc822;e@80x24.org>);
        Fri, 28 Jun 2019 12:18:49 -0400
Received: from mx0b-002e3701.pphosted.com ([148.163.143.35]:37606 "EHLO
        mx0b-002e3701.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726542AbfF1QSt (ORCPT
        <rfc822;git@vger.kernel.org>); Fri, 28 Jun 2019 12:18:49 -0400
Received: from pps.filterd (m0148664.ppops.net [127.0.0.1])
        by mx0b-002e3701.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x5SGGvjd006792;
        Fri, 28 Jun 2019 16:18:40 GMT
Received: from g4t3427.houston.hpe.com (g4t3427.houston.hpe.com [15.241.140.73])
        by mx0b-002e3701.pphosted.com with ESMTP id 2tdn938g8f-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 28 Jun 2019 16:18:40 +0000
Received: from G1W8106.americas.hpqcorp.net (g1w8106.austin.hp.com [16.193.72.61])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-SHA384 (256/256 bits))
        (No client certificate requested)
        by g4t3427.houston.hpe.com (Postfix) with ESMTPS id 960B472;
        Fri, 28 Jun 2019 16:18:39 +0000 (UTC)
Received: from G4W9328.americas.hpqcorp.net (16.208.32.98) by
 G1W8106.americas.hpqcorp.net (16.193.72.61) with Microsoft SMTP Server (TLS)
 id 15.0.1367.3; Fri, 28 Jun 2019 16:18:39 +0000
Received: from G4W10205.americas.hpqcorp.net (2002:10cf:520f::10cf:520f) by
 G4W9328.americas.hpqcorp.net (2002:10d0:2062::10d0:2062) with Microsoft SMTP
 Server (TLS) id 15.0.1367.3; Fri, 28 Jun 2019 16:18:38 +0000
Received: from NAM03-BY2-obe.outbound.protection.outlook.com (15.241.52.11) by
 G4W10205.americas.hpqcorp.net (16.207.82.15) with Microsoft SMTP Server (TLS)
 id 15.0.1367.3 via Frontend Transport; Fri, 28 Jun 2019 16:18:38 +0000
ARC-Seal: i=1; a=rsa-sha256; s=testarcselector01; d=microsoft.com; cv=none;
 b=NBDZT7Qarpol//UEZo8CTvOzOicAgeYCCcPE/fdSOoUuAMHAgIkpUpg3hy6M4vHM1n96h9KEXiboBAa1CMYwKx2LKPJ9Ft1hkDAVC+H7tFQS81/u/i22aGFFTNIsht3GdHe6cIHvM68VCH2kKGm+SXdhBEEKZQZ2N/pgC9GyyDQ=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=testarcselector01;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=2AIig0Fon6d+99brHSqdu3mzWy7VXkOX3alNluuUwfs=;
 b=RsS0HnnUORG5tD2Uc8UNKTjeBVFmnPBBUTP1mHSpwqmGZS5hzfYIZnqpExZhYF0FWnu1UHbEHcZY1hiHAQ0RNJ4tU0OwV4uDStewuf1TwxuXHtl41/+WFnRyLSGxYTPJFd2AQyMiaS9yvXKNRQ6RiQq+9afDnpwUEISMFgbvY94=
ARC-Authentication-Results: i=1; test.office365.com
 1;spf=none;dmarc=none;dkim=none;arc=none
Received: from TU4PR8401MB1216.NAMPRD84.PROD.OUTLOOK.COM (10.169.47.13) by
 TU4PR8401MB0863.NAMPRD84.PROD.OUTLOOK.COM (10.169.46.142) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2008.16; Fri, 28 Jun 2019 16:18:37 +0000
Received: from TU4PR8401MB1216.NAMPRD84.PROD.OUTLOOK.COM
 ([fe80::7d08:b407:2c60:393]) by TU4PR8401MB1216.NAMPRD84.PROD.OUTLOOK.COM
 ([fe80::7d08:b407:2c60:393%4]) with mapi id 15.20.2008.018; Fri, 28 Jun 2019
 16:18:37 +0000
From:   "Vanak, Ibrahim" <ibrahim.vanak@hpe.com>
To:     Jeff Hostetler <git@jeffhostetler.com>, Jeff King <peff@peff.net>
CC:     "git@vger.kernel.org" <git@vger.kernel.org>
Subject: RE: GIT issue while cloning (fatal: pack is corrupted (SHA1
 mismatch)) !!!
Thread-Topic: GIT issue while cloning (fatal: pack is corrupted (SHA1
 mismatch)) !!!
Thread-Index: AdUVNK2vOdBL1LuLQeCX2A7XwcsEXwAAGetAAAD4WwAAEw7MAAAF1FgAAA1+/nAABZVi4AAFOOfwADhKkgACZUPI8AFbnsCgAAW8HQAB9MhlcA==
Date:   Fri, 28 Jun 2019 16:18:37 +0000
Message-ID: <TU4PR8401MB1216FC788B6A421F8FD82B2EE1FC0@TU4PR8401MB1216.NAMPRD84.PROD.OUTLOOK.COM>
References: <TU4PR8401MB121664A8A588D799803F1E84E11E0@TU4PR8401MB1216.NAMPRD84.PROD.OUTLOOK.COM>
 <20190528093728.GA15106@sigill.intra.peff.net>
 <TU4PR8401MB1216A7B920D40B5063123A94E11E0@TU4PR8401MB1216.NAMPRD84.PROD.OUTLOOK.COM>
 <20190528213004.GF24650@sigill.intra.peff.net>
 <TU4PR8401MB12166DBE2156683ADF28E9A4E11F0@TU4PR8401MB1216.NAMPRD84.PROD.OUTLOOK.COM>
 <TU4PR8401MB1216339F1E7A378C45DF9B36E11F0@TU4PR8401MB1216.NAMPRD84.PROD.OUTLOOK.COM>
 <20190530115742.GC31607@sigill.intra.peff.net>
 <TU4PR8401MB12163C00148C39F0083C732DE1ED0@TU4PR8401MB1216.NAMPRD84.PROD.OUTLOOK.COM>
 <TU4PR8401MB1216962E3F135E850E81E407E1EA0@TU4PR8401MB1216.NAMPRD84.PROD.OUTLOOK.COM>
 <6e78d3b7-07f2-f635-1dac-c4d98961b8eb@jeffhostetler.com>
In-Reply-To: <6e78d3b7-07f2-f635-1dac-c4d98961b8eb@jeffhostetler.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [122.172.149.133]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 24206aad-3cb6-42e0-6a67-08d6fbe44691
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(7168020)(4627221)(201703031133081)(201702281549075)(8990200)(5600148)(711020)(4605104)(1401327)(4618075)(2017052603328)(7167020)(7193020);SRVR:TU4PR8401MB0863;
x-ms-traffictypediagnostic: TU4PR8401MB0863:
x-ms-exchange-purlcount: 1
x-microsoft-antispam-prvs: <TU4PR8401MB08637D0540095731310CA67DE1FC0@TU4PR8401MB0863.NAMPRD84.PROD.OUTLOOK.COM>
x-ms-oob-tlc-oobclassifiers: OLM:5516;
x-forefront-prvs: 00826B6158
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(346002)(136003)(376002)(396003)(366004)(39860400002)(13464003)(189003)(199004)(53754006)(55016002)(966005)(6116002)(7696005)(6306002)(229853002)(2906002)(6436002)(71190400001)(71200400001)(68736007)(102836004)(186003)(55236004)(76176011)(9686003)(14454004)(3846002)(99286004)(53546011)(26005)(6506007)(316002)(110136005)(33656002)(4326008)(256004)(53936002)(478600001)(486006)(11346002)(476003)(64756008)(25786009)(446003)(6246003)(8936002)(66066001)(66476007)(74316002)(66556008)(305945005)(73956011)(66946007)(52536014)(76116006)(81166006)(7736002)(8676002)(5660300002)(86362001)(81156014)(66446008);DIR:OUT;SFP:1102;SCL:1;SRVR:TU4PR8401MB0863;H:TU4PR8401MB1216.NAMPRD84.PROD.OUTLOOK.COM;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: hpe.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: NWn8ceORBj/L/VMz0j++BIaYHGk2TY5S+RCNw4P65SN1sZS/y1e0jARgl5O6VzitOGOwgaGB1hzHvlMiuZsQjK+xjIsr0yoOl+lq8jzYV5zcSt9HHvben9aaCLhXmYvPJglOITLtOGRbbsSH4W43qkj+eLpr9N03TyESNMPU16O7iBoGOIV23WCZgzQF4nSvjpsFM+Z9JqmNHH5beNUT+7QbktXl9JIG9lb5Zd+rhiX4n2UZxSyDMGGXMwirSXN7Njdle5jXQqzE7xZo3D5mjSDnvBxwsoWduZEZyR3y9YmiqL2p2k1KsThfklBnlKNlfo3xnI2m9RIWJ/swQ+AY2a8NiINF8MKOThRxnutmagpOCqIWlCcg9wHyfmrTzYb+6oHrQN13sQENKHzbasOEjRuAO3XAWBzE+IMAgjVqjnU=
Content-Type: text/plain; charset="utf-8"
X-MS-Exchange-CrossTenant-Network-Message-Id: 24206aad-3cb6-42e0-6a67-08d6fbe44691
X-MS-Exchange-CrossTenant-originalarrivaltime: 28 Jun 2019 16:18:37.3963
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 105b2061-b669-4b31-92ac-24d304d195dc
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: ibrahim.vanak@hpe.com
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TU4PR8401MB0863
X-OriginatorOrg: hpe.com
Content-Transfer-Encoding: base64
X-Proofpoint-UnRewURL: 1 URL was un-rewritten
MIME-Version: 1.0
X-HPE-SCL: -1
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2019-06-28_07:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1011 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=999 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1810050000 definitions=main-1906280186
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

SGVsbG8gQUxMLA0KDQpJIGRpZCB0cnkgR0lUX1RSQUNFKiBlbnZpcm9ubWVudCB2YXJpYWJsZXMg
YnV0IGNvdWxkbid0IGlzb2xhdGUgdGhlIHByb2JsZW0uIA0KDQpCdXQgSFBVWCBEZXYgdGVhbSBo
YXZlIHNlZW4gb25lIHNpZ25pZmljYW5jZSBkaWZmZXJlbmNlLCB3aGVuIHRoZXkgd2VyZSB0cmlh
Z2luZyB0aGlzIGlzc3VlLCB0aGUgd2F5cyBHSVQgb3BlcmF0aW9ucyBoYW5kbGVkIGJ5IDIgT1Nz
OiBPbiBsaW51eCwgYXJvdW5kIDQwIHByb2Nlc3NlcyBhcmUgc3Bhd25lZCBmb3IgaGFuZGxpbmcg
YSBHSVQgb3BlcmF0aW9uIHdoZXJlYXMgb24gSFBVWCBvbmx5IG9uZSBwcm9jZXNzIG1hbmFnZXMg
dGhlIG9wZXJhdGlvbi4gSXMgdGhlcmUgc29tZXRoaW5nIHNwZWNpYWwgYmVpbmcgd3JpdHRlbiBm
b3IgbGludXggb24gR0lUIGNvZGUgPw0KDQpDYW4geW91IHBsZWFzZSBoYXZlIGEgbG9vayBpbnRv
IHRoaXMuDQoNClRoYW5rcyAmIFJlZ2FyZHMsDQpJYnJhaGltIFZhbmFrIA0KDQotLS0tLU9yaWdp
bmFsIE1lc3NhZ2UtLS0tLQ0KRnJvbTogSmVmZiBIb3N0ZXRsZXIgW21haWx0bzpnaXRAamVmZmhv
c3RldGxlci5jb21dIA0KU2VudDogVHVlc2RheSwgSnVuZSAxOCwgMjAxOSAxMDo0NSBQTQ0KVG86
IFZhbmFrLCBJYnJhaGltIDxpYnJhaGltLnZhbmFrQGhwZS5jb20+OyBKZWZmIEtpbmcgPHBlZmZA
cGVmZi5uZXQ+DQpDYzogZ2l0QHZnZXIua2VybmVsLm9yZw0KU3ViamVjdDogUmU6IEdJVCBpc3N1
ZSB3aGlsZSBjbG9uaW5nIChmYXRhbDogcGFjayBpcyBjb3JydXB0ZWQgKFNIQTEgbWlzbWF0Y2gp
KSAhISENCg0KDQoNCk9uIDYvMTgvMjAxOSAxMDozMSBBTSwgVmFuYWssIElicmFoaW0gd3JvdGU6
DQo+IEhlbGxvIEFMTCBhZ2FpbiwNCj4gDQo+IEhhcyBhbnlvbmUgdGVzdGVkIHRoZSBwZXJmb3Jt
YW5jZSBvZiBHSVQgb24gSFAtVVggcGxhdGZvcm0/IENhbiBzb21lb25lIHBsZWFzZSBsb29rIGlu
dG8gdGhlIGlzc3VlIHdlIGFyZSBzZWVpbmcuDQo+IA0KPiBUaGFua3MsDQo+IElicmFoaW0NCg0K
DQpZb3UgbWlnaHQgdHJ5IHNldHRpbmcgc29tZSBvZiB0aGUgR0lUX1RSQUNFKiBlbnZpcm9ubWVu
dCB2YXJpYWJsZXMgbGlzdGVkIGluIFsxXSBvbiBib3RoIHlvdXIgSFAtVVggYW5kIExpbnV4IG1h
Y2hpbmVzIGFuZCBzZWUgaWYgeW91IGNhbiBpc29sYXRlIGFueSBwZXJmb3JtYW5jZSBkaWZmZXJl
bmNlcyBiZXR3ZWVuIHRoZW0uDQoNCg0KWzFdIGh0dHBzOi8vZ2l0LXNjbS5jb20vYm9vay9lbi92
Mi9HaXQtSW50ZXJuYWxzLUVudmlyb25tZW50LVZhcmlhYmxlcyANCg==
