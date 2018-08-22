Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI,T_DKIMWL_WL_HIGH shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id F41661F97E
	for <e@80x24.org>; Wed, 22 Aug 2018 13:16:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728992AbeHVQk6 (ORCPT <rfc822;e@80x24.org>);
        Wed, 22 Aug 2018 12:40:58 -0400
Received: from mail-eopbgr710121.outbound.protection.outlook.com ([40.107.71.121]:36711
        "EHLO NAM05-BY2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1728057AbeHVQk6 (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 22 Aug 2018 12:40:58 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=nWtWrvcQ9nO1o1okMeqrIx5rGs458Zj0z5teuk7tIPU=;
 b=ax6yFs+KS1OU1piXRSM76ZcYWcCVARSa0Sd0GQO1Z79pHD1mq84L5EeNdSi09sZ34+3MdOtB7/stc0J5Dnj8U9bHTjDmkzexxmEcrMksM6j51bi9tasWaZvsy1Pi5jWD2q6ba7jnwXkiyjqK1L0KHwaXeumHUJMlzqO3PefhgUc=
Received: from BL0PR2101MB1011.namprd21.prod.outlook.com (52.132.24.10) by
 BL0PR2101MB0980.namprd21.prod.outlook.com (52.132.23.154) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1101.2; Wed, 22 Aug 2018 13:16:03 +0000
Received: from BL0PR2101MB1011.namprd21.prod.outlook.com
 ([fe80::c997:1e4b:40d8:1a49]) by BL0PR2101MB1011.namprd21.prod.outlook.com
 ([fe80::c997:1e4b:40d8:1a49%2]) with mapi id 15.20.1101.005; Wed, 22 Aug 2018
 13:16:03 +0000
From:   Derrick Stolee <dstolee@microsoft.com>
To:     "git@vger.kernel.org" <git@vger.kernel.org>
CC:     "gitster@pobox.com" <gitster@pobox.com>,
        "szeder.dev@gmail.com" <szeder.dev@gmail.com>,
        Derrick Stolee <dstolee@microsoft.com>
Subject: [PATCH] config: fix commit-graph related config docs
Thread-Topic: [PATCH] config: fix commit-graph related config docs
Thread-Index: AQHUOhpGKaqqmNOPJESWAObZlI1XSA==
Date:   Wed, 22 Aug 2018 13:16:02 +0000
Message-ID: <20180822131547.56899-1-dstolee@microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: BN6PR12CA0033.namprd12.prod.outlook.com
 (2603:10b6:405:70::19) To BL0PR2101MB1011.namprd21.prod.outlook.com
 (2603:10b6:207:37::10)
x-ms-exchange-messagesentrepresentingtype: 1
x-originating-ip: [2001:4898:8010:0:eb4a:5dff:fe0f:730f]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;BL0PR2101MB0980;6:9a2bYwg75ayP/kOP+vArwQIBWC4p21nXimACoILdx3RJHRYreR7p6Cxdcv19peWRciIk+lMGvl/GleVvtakI+kNz/eO0hfiKgz99OlZmQ3m2hzZe/+z0Fr1scxLaeTJlHaa0/isOf2BLmDeGqLvMwI9/AF/iHCZJOJIb2km4K/49vYl5Bgv7UnO15lJDUpdZCEreqHnIKiUQrqhl1TdKv1mrDX/LTBXhDBk+IbK6FjLSXuC7XeWjWQa32psny+tVFv4Lq7e4cN2VB8cWHZTZakEa8ZM3sUKyBSKn2zgEsKduTQqMlgsudNOEJkjfHPM3kexhbFJKJ9v5ca45PxwVR6CWnEbuVBmEgp2+UN0yx+KStUAvuHFW+QU6yb4IXLSF//nMn0zk5uILYQJevzGQnqUhuoTMd+Wnew02W6ByhRbzWsUKdrZifoJtKhLvCJwaBMcBSTvKkg0KidSRXWL25A==;5:JCqwsBDYgu0hErfb0HscDPWO0B1gWrI8htVON7HyqhviHbVLP1Yu2ErhyhEv3PssRnKslAo0yiIfFacnSTid5E9kLI401kKsapG5g2N+ynFQvCtnwoe31K7rv0cywjsNPyPFdRArNFMYxxs/DMuFGoIzRr62Cqv7lcTN/7AGTGo=;7:qty2lMwdw43YgxpKNraNSym71maBWN/N8uhrxF4WwUkGDHK8HICrKkdp23F0wT8nefbrHmRjXtAJxIHYC+/kpnUCsneXyT+F6YlwvzjL/N9GKpLsz7zma7u6naQ5YRnvLIVqSGzUOVJ1nHWswVNQyuug3EIec7P7aN2obdYasoPCGjCdK87+DuDSh+ooc8JKwMBu0ynMfCSB5NmjZQi/B0oN9FWJzqQDKR49PL4QxOSB8JBj+Oa1EWKlTuEYD53Q
x-ms-office365-filtering-correlation-id: d9057aec-431b-4d80-b5ef-08d6083168b0
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989137)(4534165)(4627221)(201703031133081)(201702281549075)(8990107)(5600074)(711020)(4618075)(2017052603328)(7193020);SRVR:BL0PR2101MB0980;
x-ms-traffictypediagnostic: BL0PR2101MB0980:
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=dstolee@microsoft.com; 
x-microsoft-antispam-prvs: <BL0PR2101MB0980BCB3774388BDEC0BC0B5A1300@BL0PR2101MB0980.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(28532068793085)(89211679590171)(85827821059158);
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(5005006)(8121501046)(3002001)(93006095)(93001095)(10201501046)(3231336)(944501410)(52105095)(2018427008)(6055026)(149027)(150027)(6041310)(20161123562045)(20161123564045)(20161123560045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123558120)(201708071742011)(7699037)(76991021);SRVR:BL0PR2101MB0980;BCL:0;PCL:0;RULEID:;SRVR:BL0PR2101MB0980;
x-forefront-prvs: 0772E5DAD5
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(136003)(39860400002)(376002)(346002)(366004)(396003)(189003)(199004)(8676002)(6116002)(10090500001)(6306002)(81156014)(81166006)(97736004)(86612001)(1730700003)(256004)(14444005)(68736007)(86362001)(6486002)(6512007)(5640700003)(6436002)(6916009)(8936002)(53936002)(39060400002)(305945005)(7736002)(5660300001)(107886003)(2900100001)(22452003)(476003)(54906003)(36756003)(10290500003)(4326008)(2501003)(2616005)(5250100002)(966005)(1857600001)(478600001)(486006)(316002)(25786009)(2351001)(99286004)(102836004)(6506007)(386003)(186003)(1076002)(52116002)(105586002)(106356001)(14454004)(2906002)(46003);DIR:OUT;SFP:1102;SCL:1;SRVR:BL0PR2101MB0980;H:BL0PR2101MB1011.namprd21.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: microsoft.com does not designate
 permitted sender hosts)
x-microsoft-antispam-message-info: gZ/QMwi7a5dVDtTDrT9jJz00pkdiOBf2bhv5XgG2q6JxmRltkIk88uLEUVjUHaX8ifaDQPygryDQJl+Jep3g9+rmoTJtosWNYOsQiHhBn12JUcM8VWyl6QS7UJiIkUt2ZEHvLbCoKUOv0Us/KbtjMNk44qBtSe37iQL/dgXLoUqJ+21VRjyH1Da4fzUSkzIChOx1UAJamijJYus4IICXlJyKMySrrQ72U9cJFAWyISyWBFTjoWLj8Tjd9Wu2WOTNXjTtIGj/UwgAoL/5b3oUqjdBcH6W4VLShoUrJ4n07Txt7+rkuenQe++l2wc/7BcbebCouojJs1yGZy69UhM0ziK/UV3o1e5W+Rb4MkNcl54=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="utf-8"
Content-ID: <FBBBAFBECAB2C046B967D8D97655B038@namprd21.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d9057aec-431b-4d80-b5ef-08d6083168b0
X-MS-Exchange-CrossTenant-originalarrivaltime: 22 Aug 2018 13:16:02.8679
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL0PR2101MB0980
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

VGhlIGNvcmUuY29tbWl0R3JhcGggY29uZmlnIHNldHRpbmcgd2FzIGFjY2lkZW50YWxseSByZW1v
dmVkIGZyb20NCnRoZSBjb25maWcgZG9jdW1lbnRhdGlvbi4gSW4gdGhhdCBzYW1lIHBhdGNoLCB0
aGUgY29uZmlnIHNldHRpbmcNCnRoYXQgd3JpdGVzIGEgY29tbWl0LWdyYXBoIGR1cmluZyBnYXJi
YWdlIGNvbGxlY3Rpb24gd2FzIGluY29ycmVjdGx5DQp3cml0dGVuIHRvIHRoZSBkb2MgYXMgImdj
LmNvbW1pdEdyYXBoIiBpbnN0ZWFkIG9mICJnYy53cml0ZUNvbW1pdEdyYXBoIi4NCg0KUmVwb3J0
ZWQtYnk6IFN6ZWRlciBHw6Fib3IgPHN6ZWRlci5kZXZAZ21haWwuY29tPg0KU2lnbmVkLW9mZi1i
eTogRGVycmljayBTdG9sZWUgPGRzdG9sZWVAbWljcm9zb2Z0LmNvbT4NCi0tLQ0KDQpTemVkZXIg
cmVwb3J0ZWQgdGhpcyBpbiBbMV0gYW5kIEkgZm9yZ290IHVudGlsIG5vdyB0byBjb21lIGJhY2sg
dG8gaXQuDQoNClsxXSBodHRwczovL3B1YmxpYy1pbmJveC5vcmcvZ2l0LzIwMTgwODAzMDkzOTA5
LjI4NTMtMS1zemVkZXIuZGV2QGdtYWlsLmNvbS8NCg0KIERvY3VtZW50YXRpb24vY29uZmlnLnR4
dCB8IDYgKysrKystDQogMSBmaWxlIGNoYW5nZWQsIDUgaW5zZXJ0aW9ucygrKSwgMSBkZWxldGlv
bigtKQ0KDQpkaWZmIC0tZ2l0IGEvRG9jdW1lbnRhdGlvbi9jb25maWcudHh0IGIvRG9jdW1lbnRh
dGlvbi9jb25maWcudHh0DQppbmRleCAxYzQyMzY0OTg4Li5mODQ2NTQzNDE0IDEwMDY0NA0KLS0t
IGEvRG9jdW1lbnRhdGlvbi9jb25maWcudHh0DQorKysgYi9Eb2N1bWVudGF0aW9uL2NvbmZpZy50
eHQNCkBAIC05MTcsNyArOTE3LDExIEBAIGNvcmUubm90ZXNSZWY6Og0KIFRoaXMgc2V0dGluZyBk
ZWZhdWx0cyB0byAicmVmcy9ub3Rlcy9jb21taXRzIiwgYW5kIGl0IGNhbiBiZSBvdmVycmlkZGVu
IGJ5DQogdGhlIGBHSVRfTk9URVNfUkVGYCBlbnZpcm9ubWVudCB2YXJpYWJsZS4gIFNlZSBsaW5r
Z2l0OmdpdC1ub3Rlc1sxXS4NCiANCi1nYy5jb21taXRHcmFwaDo6DQorY29yZS5jb21taXRHcmFw
aDo6DQorCUVuYWJsZSBnaXQgY29tbWl0IGdyYXBoIGZlYXR1cmUuIEFsbG93cyByZWFkaW5nIGZy
b20gdGhlDQorCWNvbW1pdC1ncmFwaCBmaWxlLg0KKw0KK2djLndyaXRlQ29tbWl0R3JhcGg6Og0K
IAlJZiB0cnVlLCB0aGVuIGdjIHdpbGwgcmV3cml0ZSB0aGUgY29tbWl0LWdyYXBoIGZpbGUgd2hl
bg0KIAlsaW5rZ2l0OmdpdC1nY1sxXSBpcyBydW4uIFdoZW4gdXNpbmcgbGlua2dpdDpnaXQtZ2Nb
MV0NCiAJJy0tYXV0bycgdGhlIGNvbW1pdC1ncmFwaCB3aWxsIGJlIHVwZGF0ZWQgaWYgaG91c2Vr
ZWVwaW5nIGlzDQoNCmJhc2UtY29tbWl0OiA3ZThiZmIwNDEyNTgxZGFmOGYzYzg5OTA5ZjFkMzc4
NDRlODYxMGRkDQotLSANCjIuMTkuMC5yYzANCg0K
