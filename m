Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=AWL,BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id BCC8820248
	for <e@80x24.org>; Thu, 21 Mar 2019 22:32:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726609AbfCUWcr (ORCPT <rfc822;e@80x24.org>);
        Thu, 21 Mar 2019 18:32:47 -0400
Received: from mail-eopbgr740094.outbound.protection.outlook.com ([40.107.74.94]:26016
        "EHLO NAM01-BN3-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726370AbfCUWcr (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 21 Mar 2019 18:32:47 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=kastle.onmicrosoft.com; s=selector1-checkvideo-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=IxTWKLD4AEtPuAsdwKT+mEDtVxihAuvPlelkwDtcOsE=;
 b=Vu98zR2FRT5AbwUCUznE6lgJH8qUwTN8vuwzxPYvJtfOWsPoOGdZtfL/VJUvgUjsHIjRVYGX0l+i7BRq9kpE3IPKV4KXa2q6OV5vuQc7VSAymm5zSusj+jlvO2/fMXP2akzSkkQR1D8hvIp0CBiL2HE6rpM/0NZ5WHOAyfmgoQk=
Received: from DM6PR08MB4956.namprd08.prod.outlook.com (20.176.115.217) by
 DM6PR08MB4410.namprd08.prod.outlook.com (20.176.82.156) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1730.16; Thu, 21 Mar 2019 22:32:36 +0000
Received: from DM6PR08MB4956.namprd08.prod.outlook.com
 ([fe80::75e5:faf9:290a:a244]) by DM6PR08MB4956.namprd08.prod.outlook.com
 ([fe80::75e5:faf9:290a:a244%3]) with mapi id 15.20.1709.015; Thu, 21 Mar 2019
 22:32:35 +0000
From:   "Mazo, Andrey" <amazo@checkvideo.com>
To:     "git@vger.kernel.org" <git@vger.kernel.org>
CC:     "Mazo, Andrey" <amazo@checkvideo.com>,
        "luke@diamand.org" <luke@diamand.org>,
        "sunshine@sunshineco.com" <sunshine@sunshineco.com>,
        "gvanburgh@bloomberg.net" <gvanburgh@bloomberg.net>,
        "larsxschneider@gmail.com" <larsxschneider@gmail.com>,
        "miguel.torroja@gmail.com" <miguel.torroja@gmail.com>,
        "merlorom@yahoo.fr" <merlorom@yahoo.fr>,
        "vitor.hda@gmail.com" <vitor.hda@gmail.com>,
        "aoakley@roku.com" <aoakley@roku.com>,
        "szeder.dev@gmail.com" <szeder.dev@gmail.com>,
        "ahippo@yandex.com" <ahippo@yandex.com>,
        "gitster@pobox.com" <gitster@pobox.com>
Subject: [PATCH v2 0/7] git-p4: a few assorted fixes for branches, excludes
Thread-Topic: [PATCH v2 0/7] git-p4: a few assorted fixes for branches,
 excludes
Thread-Index: AQHU4DX7aD8586BBEU6JZoh59uSl1Q==
Date:   Thu, 21 Mar 2019 22:32:35 +0000
Message-ID: <cover.1553207234.git.amazo@checkvideo.com>
References: <cover.1551485349.git.amazo@checkvideo.com>
In-Reply-To: <cover.1551485349.git.amazo@checkvideo.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: BN3PR05CA0023.namprd05.prod.outlook.com (2603:10b6:400::33)
 To DM6PR08MB4956.namprd08.prod.outlook.com (2603:10b6:5:4b::25)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=amazo@checkvideo.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-mailer: git-send-email 2.19.2
x-originating-ip: [70.163.25.109]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 08c6144f-2871-4bad-9795-08d6ae4d1dc5
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(5600127)(711020)(4605104)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(2017052603328)(7153060)(7193020);SRVR:DM6PR08MB4410;
x-ms-traffictypediagnostic: DM6PR08MB4410:
x-ms-exchange-purlcount: 1
x-microsoft-antispam-prvs: <DM6PR08MB4410057C6E9BCA9277564E66DA420@DM6PR08MB4410.namprd08.prod.outlook.com>
x-forefront-prvs: 0983EAD6B2
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(396003)(39860400002)(346002)(366004)(136003)(376002)(189003)(199004)(26005)(2906002)(6436002)(68736007)(14444005)(7416002)(36756003)(6486002)(316002)(256004)(106356001)(66066001)(486006)(476003)(97736004)(11346002)(446003)(2501003)(2616005)(105586002)(2351001)(54906003)(6506007)(386003)(6916009)(25786009)(8676002)(966005)(5660300002)(99286004)(76176011)(478600001)(102836004)(81166006)(81156014)(1730700003)(3846002)(6116002)(305945005)(71190400001)(71200400001)(5640700003)(6306002)(4326008)(186003)(7736002)(86362001)(8936002)(53936002)(52116002)(50226002)(6512007)(14454004);DIR:OUT;SFP:1102;SCL:1;SRVR:DM6PR08MB4410;H:DM6PR08MB4956.namprd08.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: checkvideo.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: gfu6SiEPl4lNoTlLgezHvgUSx69YgI8c2sHbTfCnwnSRFiEHYj4u+yurB+otieBP8ovg/7TKUsfBPmi9JWLBAkP0HXHEUA3b2HdA6vz99dj2Mx6J6qCmFRrR57wMotEl2mt1EXFNBeS1yK3RbWOjAc2pbfXCgElj0HMzeq+vSYYXUgZ1i3wo7h4bCQejB0byCazlGwL8QqRVkouO0CgmWaktQj5x08D7bWPjPkN/JSX4/v5r3Xl+LSvCvVRB7IcjD+0Fx8XHd5CZxloZXmj8ZDK3ZfflRCRI/htlQnfGrGM9xRPqTiH8hQ2jCPv6Uo3Mp5kjzzpMGaNeoEQ3gCXLugUDViFY0QRTsv+KjouSBwaKmllmum3j3Jdw5yEbeGmJiQKtWVwfsTEvTbYZb7EgirZFXdy3pjGw66gSKwuZIuU=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: checkvideo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 08c6144f-2871-4bad-9795-08d6ae4d1dc5
X-MS-Exchange-CrossTenant-originalarrivaltime: 21 Mar 2019 22:32:35.8750
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 7280061d-06ed-4a4e-a2b1-cc9ab5638c09
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR08MB4410
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

This series fixes a few cases with branch detection
and handling of excludes by git-p4.

This is the second iteration of the patch series.
Changes since the v1 [1]:
 * Added new test case for excluded paths when detecting branches;
 * Added a new fix for excluded paths when detecting branches.

[1] https://public-inbox.org/git/cover.1551485349.git.amazo@checkvideo.com

Range-diff vs v1:
1:  3ac39171d4 =3D 1:  3ac39171d4 git-p4: detect/prevent infinite loop in g=
itCommitByP4Change()
2:  e644a8ab49 =3D 2:  e644a8ab49 git-p4: match branches case insensitively=
 if configured
3:  44fed954dc =3D 3:  44fed954dc git-p4: don't groom exclude path list on =
every commit
4:  a0d3fa6add =3D 4:  a0d3fa6add git-p4: add failing test for "don't exclu=
de other files with same prefix"
5:  3330f88a0d =3D 5:  3330f88a0d git-p4: don't exclude other files with sa=
me prefix
-:  ---------- > 6:  6170d45951 git-p4: add failing test for "git-p4: respe=
ct excluded paths when detecting branches"
-:  ---------- > 7:  758d8e8486 git-p4: respect excluded paths when detecti=
ng branches

Andrey Mazo (7):
  git-p4: detect/prevent infinite loop in gitCommitByP4Change()
  git-p4: match branches case insensitively if configured
  git-p4: don't groom exclude path list on every commit
  git-p4: add failing test for "don't exclude other files with same prefix"
  git-p4: don't exclude other files with same prefix
  git-p4: add failing test for "git-p4: respect excluded paths when detecti=
ng branches"
  git-p4: respect excluded paths when detecting branches

 git-p4.py                 | 42 ++++++++++++++++++++------------
 t/t9801-git-p4-branch.sh  | 40 ++++++++++++++++++++++++++++++
 t/t9817-git-p4-exclude.sh | 51 +++++++++++++++++++++++++++++++++++----
 3 files changed, 112 insertions(+), 21 deletions(-)


base-commit: 8104ec994ea3849a968b4667d072fedd1e688642
--=20
2.19.2

