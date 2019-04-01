Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 35C4820248
	for <e@80x24.org>; Mon,  1 Apr 2019 18:02:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730771AbfDASCV (ORCPT <rfc822;e@80x24.org>);
        Mon, 1 Apr 2019 14:02:21 -0400
Received: from mail-eopbgr700107.outbound.protection.outlook.com ([40.107.70.107]:65249
        "EHLO NAM04-SN1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1729552AbfDASCT (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 1 Apr 2019 14:02:19 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=kastle.onmicrosoft.com; s=selector1-checkvideo-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=wlv4yH9A7EnT2zAaNq4TevAtbp/dwm7OsLwxrKFBVoA=;
 b=ub8PEtHbP7z26f/d1s5qDBkpRRDMysi8Zjo9r7tX89Q8NMdZ7YE5mtWYE8x8+H/Q4KXSBLqoQZcKd8QdRkkCL0cfs3jGkHLFwDuGsOVj1qSE9gicS/xpMAeD2u5UB+DDMnQbsiTdu/Ra6+ZkUjJzrwBSil2Q/8Ju5WfrU1WTSO8=
Received: from DM6PR08MB4956.namprd08.prod.outlook.com (20.176.115.217) by
 DM6PR08MB5465.namprd08.prod.outlook.com (20.178.24.138) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1750.17; Mon, 1 Apr 2019 18:02:10 +0000
Received: from DM6PR08MB4956.namprd08.prod.outlook.com
 ([fe80::1ca7:6cc5:a0b3:e164]) by DM6PR08MB4956.namprd08.prod.outlook.com
 ([fe80::1ca7:6cc5:a0b3:e164%3]) with mapi id 15.20.1750.021; Mon, 1 Apr 2019
 18:02:10 +0000
From:   "Mazo, Andrey" <amazo@checkvideo.com>
To:     "git@vger.kernel.org" <git@vger.kernel.org>
CC:     "Mazo, Andrey" <amazo@checkvideo.com>,
        Luke Diamand <luke@diamand.org>,
        Eric Sunshine <sunshine@sunshineco.com>,
        George Vanburgh <gvanburgh@bloomberg.net>,
        Lars Schneider <larsxschneider@gmail.com>,
        Miguel Torroja <miguel.torroja@gmail.com>,
        Romain Merland <merlorom@yahoo.fr>,
        Vitor Antunes <vitor.hda@gmail.com>,
        Andrew Oakley <aoakley@roku.com>,
        =?iso-8859-1?Q?SZEDER_G=E1bor?= <szeder.dev@gmail.com>,
        Andrey Mazo <ahippo@yandex.com>,
        Junio C Hamano <gitster@pobox.com>
Subject: [PATCH v3 0/8] git-p4: a few assorted fixes for branches, excludes
Thread-Topic: [PATCH v3 0/8] git-p4: a few assorted fixes for branches,
 excludes
Thread-Index: AQHU6LUGbW6r8ueQ60+NtD8GF2ohIw==
Date:   Mon, 1 Apr 2019 18:02:10 +0000
Message-ID: <cover.1554141338.git.amazo@checkvideo.com>
References: <cover.1553207234.git.amazo@checkvideo.com>
In-Reply-To: <cover.1553207234.git.amazo@checkvideo.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: BN6PR16CA0044.namprd16.prod.outlook.com
 (2603:10b6:405:14::30) To DM6PR08MB4956.namprd08.prod.outlook.com
 (2603:10b6:5:4b::25)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=amazo@checkvideo.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-mailer: git-send-email 2.19.2
x-originating-ip: [70.163.25.109]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 60a12a28-7ce5-4651-b60c-08d6b6cc2936
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(5600139)(711020)(4605104)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(2017052603328)(7193020);SRVR:DM6PR08MB5465;
x-ms-traffictypediagnostic: DM6PR08MB5465:
x-ms-exchange-purlcount: 2
x-microsoft-antispam-prvs: <DM6PR08MB5465B4A9965EDF3EA3B97D5ADA550@DM6PR08MB5465.namprd08.prod.outlook.com>
x-forefront-prvs: 0994F5E0C5
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(376002)(366004)(396003)(346002)(136003)(39860400002)(189003)(199004)(105586002)(81156014)(2351001)(446003)(36756003)(76176011)(6916009)(11346002)(71190400001)(305945005)(4326008)(102836004)(478600001)(50226002)(7736002)(25786009)(6116002)(5660300002)(14454004)(2906002)(256004)(14444005)(3846002)(6436002)(1730700003)(53936002)(6512007)(26005)(5640700003)(966005)(71200400001)(66066001)(7416002)(186003)(6486002)(97736004)(86362001)(2501003)(81166006)(99286004)(316002)(6506007)(386003)(8676002)(54906003)(8936002)(486006)(68736007)(52116002)(6306002)(2616005)(476003)(106356001);DIR:OUT;SFP:1102;SCL:1;SRVR:DM6PR08MB5465;H:DM6PR08MB4956.namprd08.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: checkvideo.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: kloqRo8gK2b6Y0LP79Vuz/e55/GjzegDQmAEJ2Y/UBNdrCaVDSgPGefDHF7Y636pYHT11jX1RN/kY29q6UfskO4yqydGJunWXEcS9FsASBGrtBKs/FLQcz9fqL90yPtUAmCLMnJBVhCbuHxtjVptzyyMq0RW+FgH4qLBtiZpyR0+GgtR6vWB99zjccXuTYTRGaqZ87md9k2ZYr13USxD2NZIL0EJc3F7LIc/S+6B73/JmYIszhriO7Rh3eeSOnqAnk55xu9+WYFpRtyJuKa4moS3T0tKCOS8eUzLIeSAZQKnSGTpR3BTTGdSBLCmGNv7hEWEER1obPxWIxYBxFTspsvL5lFGj+7jx5cezboXKMwdixjaEUUubZdPN461mDjjFLSmdaCJU/jwGhAsJWrlBZXPTYZDC0OWMm8lAm4ehPw=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: checkvideo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 60a12a28-7ce5-4651-b60c-08d6b6cc2936
X-MS-Exchange-CrossTenant-originalarrivaltime: 01 Apr 2019 18:02:10.2930
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 7280061d-06ed-4a4e-a2b1-cc9ab5638c09
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR08MB5465
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


This series fixes a few cases with branch detection
and handling of excludes by git-p4.

This is the third iteration of the patch series.
Changes since v2 [2]:
 * Added new test cases for case-insensitive branch detection.
Changes since v1 [1]:
 * Added new test case for excluded paths when detecting branches;
 * Added a new fix for excluded paths when detecting branches.

[1] https://public-inbox.org/git/cover.1551485349.git.amazo@checkvideo.com
[2] https://public-inbox.org/git/cover.1553207234.git.amazo@checkvideo.com/

Range-diff vs v2:
1:  3ac39171d4 =3D 1:  bd009a5ca5 git-p4: detect/prevent infinite loop in g=
itCommitByP4Change()
2:  e644a8ab49 < -:  ---------- git-p4: match branches case insensitively i=
f configured
-:  ---------- > 2:  68b68ce1e4 git-p4: add failing test for "git-p4: match=
 branches case insensitively if configured"
-:  ---------- > 3:  6eaad2582c git-p4: match branches case insensitively i=
f configured
3:  44fed954dc =3D 4:  1bd5e170e0 git-p4: don't groom exclude path list on =
every commit
4:  a0d3fa6add =3D 5:  b657967154 git-p4: add failing test for "don't exclu=
de other files with same prefix"
5:  3330f88a0d =3D 6:  035abfff2a git-p4: don't exclude other files with sa=
me prefix
6:  6170d45951 =3D 7:  2bde24b7e4 git-p4: add failing test for "git-p4: res=
pect excluded paths when detecting branches"
7:  758d8e8486 =3D 8:  6d3ffb98a7 git-p4: respect excluded paths when detec=
ting branches

Andrey Mazo (8):
  git-p4: detect/prevent infinite loop in gitCommitByP4Change()
  git-p4: add failing test for "git-p4: match branches case insensitively i=
f configured"
  git-p4: match branches case insensitively if configured
  git-p4: don't groom exclude path list on every commit
  git-p4: add failing test for "don't exclude other files with same prefix"
  git-p4: don't exclude other files with same prefix
  git-p4: add failing test for "git-p4: respect excluded paths when detecti=
ng branches"
  git-p4: respect excluded paths when detecting branches

 git-p4.py                 |  44 ++++++++-----
 t/t9801-git-p4-branch.sh  | 132 ++++++++++++++++++++++++++++++++++++++
 t/t9817-git-p4-exclude.sh |  51 +++++++++++++--
 3 files changed, 205 insertions(+), 22 deletions(-)


base-commit: 8104ec994ea3849a968b4667d072fedd1e688642
--=20
2.19.2

