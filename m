Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.2 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 5BD731F462
	for <e@80x24.org>; Tue, 28 May 2019 21:42:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727144AbfE1Vmz (ORCPT <rfc822;e@80x24.org>);
        Tue, 28 May 2019 17:42:55 -0400
Received: from mail-eopbgr740097.outbound.protection.outlook.com ([40.107.74.97]:46768
        "EHLO NAM01-BN3-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726492AbfE1Vmz (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 28 May 2019 17:42:55 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=iowa.onmicrosoft.com;
 s=selector1-iowa-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=smr7MeD1v0C/WQbH1H54WfKnAanBE8ekn0q21Rh46gY=;
 b=Sd19JTQzmM69k2MWN01l8ZVETIPbFQdu/OxxVyO072AOvFQCidExiycwwRHrLwv1gxsPEl1fw9a2BFrt6SiTcWgQy8TR+NtBhg4/O5TKuyhp15ElWC4cCQJtAo78XutqnQvaPRO8wHjHGMVdCNLVJAisu3MvjwCQnCrH6QizNuk=
Received: from SN6PR04MB4431.namprd04.prod.outlook.com (52.135.72.160) by
 SN6PR04MB4733.namprd04.prod.outlook.com (52.135.122.139) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1922.16; Tue, 28 May 2019 21:42:52 +0000
Received: from SN6PR04MB4431.namprd04.prod.outlook.com
 ([fe80::3d7b:10e4:f121:9e0f]) by SN6PR04MB4431.namprd04.prod.outlook.com
 ([fe80::3d7b:10e4:f121:9e0f%6]) with mapi id 15.20.1922.021; Tue, 28 May 2019
 21:42:52 +0000
From:   "Dominy, Patrick A" <patrick-dominy@uiowa.edu>
To:     "git@vger.kernel.org" <git@vger.kernel.org>
Subject: git fsck finds duplicate entries
Thread-Topic: git fsck finds duplicate entries
Thread-Index: AQHVFZ5NDRVTJLyGo0m6Uz7NHTZjug==
Date:   Tue, 28 May 2019 21:42:52 +0000
Message-ID: <2FFF873C-0FCB-4E5F-BEA2-BCE54A623D1E@uiowa.edu>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=patrick-dominy@uiowa.edu; 
x-originating-ip: [2620:0:e50:1020:307b:e8cd:16ce:3374]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 903a8cc6-3c45-49e7-4d1b-08d6e3b56ffa
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(5600148)(711020)(4605104)(1401327)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(2017052603328)(7193020);SRVR:SN6PR04MB4733;
x-ms-traffictypediagnostic: SN6PR04MB4733:
x-microsoft-antispam-prvs: <SN6PR04MB47334898B33B7D7823F6C70C861E0@SN6PR04MB4733.namprd04.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:8273;
x-forefront-prvs: 00514A2FE6
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(366004)(346002)(136003)(396003)(39860400002)(376002)(199004)(189003)(75432002)(786003)(6512007)(4744005)(2351001)(6116002)(36756003)(5660300002)(66556008)(6486002)(486006)(25786009)(88552002)(46003)(2501003)(68736007)(102836004)(316002)(86362001)(2906002)(66946007)(256004)(99286004)(478600001)(7736002)(305945005)(64756008)(14454004)(33656002)(186003)(6506007)(6916009)(81166006)(66476007)(8676002)(1730700003)(81156014)(66446008)(8936002)(82746002)(6436002)(5640700003)(2616005)(476003)(73956011)(91956017)(83716004)(71190400001)(71200400001)(76116006)(53936002);DIR:OUT;SFP:1102;SCL:1;SRVR:SN6PR04MB4733;H:SN6PR04MB4431.namprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: uiowa.edu does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: fXQkGcxld91MlgOu7rGXAdMksi6pG6OWCVHhid862RzBjKnUitxwcEK6lfEW57eJn7ZkGL591Ar4U02Tm3HSjVxj5lRjgFqvM3J7VxMyYezVCQt3H3cdgNbbuWWR7+Bt+L+ihJ/pOdgFyopJDMwJHWoqa5mcJBx5VceQNev9eSr2bUwN0YdW0Vo7hJOhiDxWw557ncCL5u/UKGfHGzqDJ3bOCup197LsXfb1G1YtPjN9Nz7KBUBcBamNeNeEpmzETqQXJtD0X6Aork5Q1yIKo7StsyCngSZl6Vo5F6j4OFSj8/Dbjsolv1HlcGoa2NhKDg76AZRn/VCdGErd2fL9uVF99riAf5UTPGoju519B/dVnfOQhCtCl2X6EPrKQtuhoWoHqEWmnarPj8sIjgaxVR5A9EqloaIgG9ZumZoU7PI=
Content-Type: text/plain; charset="utf-8"
Content-ID: <CDAC013E24ABA04A88A71A6D5A8F3762@namprd04.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: uiowa.edu
X-MS-Exchange-CrossTenant-Network-Message-Id: 903a8cc6-3c45-49e7-4d1b-08d6e3b56ffa
X-MS-Exchange-CrossTenant-originalarrivaltime: 28 May 2019 21:42:52.5525
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 1bc44595-9aba-4fc3-b8ec-7b94a5586fdc
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: pdominy@uiowa.edu
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN6PR04MB4733
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

SGksDQpSdW5uaW5nIGdpdCBmc2NrIGFnYWluc3Qgb25lIG9mIG91ciByZXBvc2l0b3JpZXMgeWll
bGRzIHRoZSBmb2xsb3dpbmc6DQpFcnJvciBpbiB0cmVlIHh4eHh4eHg6IGR1cGxpY2F0ZUVudHJp
ZXM6IGNvbnRhaW5zIGR1cGxpY2F0ZSBmaWxlIGVudHJpZXMNCiANCldlIGFyZSBzdHJ1Z2dsaW5n
IHdpdGggdGhlIGJlc3QgYXBwcm9hY2ggdG8gcmVzb2x2ZSB0aGUgaXNzdWUuICBXZeKAmXZlIHVz
ZWQgZ2l0IHJlcGxhY2UsIHdoaWNoIHN1Y2Nlc3NmdWxseSBjcmVhdGVzIHRoZSByZXBsYWNlIHJl
ZmVyZW5jZSwgYnV0IGZzY2sgc3RpbGwgcmV0dXJucyB0aGUgc2FtZSBkdXBsaWNhdGUgZW50cnkg
ZXJyb3IuDQpUaGUgY29tbWl0IHRoYXQgaW50cm9kdWNlZCB0aGUgaXNzdWUgaGFwcGVuZWQgc29t
ZSB0aW1lIGFnbywgbWFraW5nIGdvaW5nIGJhY2sgdG8gdGhlIGJhZCBjb21taXQgYW5kIHJlcGxh
eWluZyB0aGUgY29tbWl0cyBhIGRhdW50aW5nIHRhc2suDQpBbnkgc3VnZ2VzdGlvbnMgd291bGQg
YmUgbXVjaCBhcHByZWNpYXRlZC4NCiANClRoYW5rcw0KDQo=
