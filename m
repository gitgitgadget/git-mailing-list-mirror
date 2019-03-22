Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=AWL,BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id F336F20248
	for <e@80x24.org>; Fri, 22 Mar 2019 19:54:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726087AbfCVTyQ (ORCPT <rfc822;e@80x24.org>);
        Fri, 22 Mar 2019 15:54:16 -0400
Received: from mail-eopbgr680121.outbound.protection.outlook.com ([40.107.68.121]:13926
        "EHLO NAM04-BN3-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725982AbfCVTyQ (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 22 Mar 2019 15:54:16 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=kastle.onmicrosoft.com; s=selector1-checkvideo-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=mouDDS9k8dBAQPx0w0iEWrBL0vWRUJrLlHDyMiK8dKo=;
 b=rFcuMfIUVTQGO8WUP50wURHkUh9hAqINjmuXpSgMJmInOsVld7mdeG9kPv8x8Ozm9aBMMDqFKgkI56gVYJD3nTllg546mAq/5f8AI4eCZpMZgiVAHJadIsTSc75dB3RLdkfcE1KIkmTnfMaaOmiFH87D0GoL9R9s26d6i9S1fM0=
Received: from BN7PR08MB4945.namprd08.prod.outlook.com (20.176.176.19) by
 BN7PR08MB6004.namprd08.prod.outlook.com (20.176.179.81) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1730.18; Fri, 22 Mar 2019 19:54:12 +0000
Received: from BN7PR08MB4945.namprd08.prod.outlook.com
 ([fe80::5c65:6123:80f4:d975]) by BN7PR08MB4945.namprd08.prod.outlook.com
 ([fe80::5c65:6123:80f4:d975%6]) with mapi id 15.20.1730.017; Fri, 22 Mar 2019
 19:54:12 +0000
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
        Andrey <ahippo@yandex.com>, Junio C Hamano <gitster@pobox.com>
Subject: [RFC PATCH 0/2] git-p4: "alien" branches and load changelist info
 from file
Thread-Topic: [RFC PATCH 0/2] git-p4: "alien" branches and load changelist
 info from file
Thread-Index: AQHU4OkFVMhPXBd7e0iGZccol2HZIA==
Date:   Fri, 22 Mar 2019 19:54:12 +0000
Message-ID: <cover.1553283214.git.amazo@checkvideo.com>
References: <cover.1553207234.git.amazo@checkvideo.com>
In-Reply-To: <cover.1553207234.git.amazo@checkvideo.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: BL0PR02CA0115.namprd02.prod.outlook.com
 (2603:10b6:208:35::20) To BN7PR08MB4945.namprd08.prod.outlook.com
 (2603:10b6:408:28::19)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=amazo@checkvideo.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-mailer: git-send-email 2.19.2
x-originating-ip: [70.163.25.109]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: c8e865a7-8827-4520-c2fd-08d6af002789
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(5600127)(711020)(4605104)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(2017052603328)(7153060)(7193020);SRVR:BN7PR08MB6004;
x-ms-traffictypediagnostic: BN7PR08MB6004:
x-ms-exchange-purlcount: 1
x-microsoft-antispam-prvs: <BN7PR08MB60040C41F0B90462363BF8CEDA430@BN7PR08MB6004.namprd08.prod.outlook.com>
x-forefront-prvs: 09840A4839
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(376002)(366004)(39860400002)(136003)(396003)(346002)(189003)(199004)(106356001)(5640700003)(5660300002)(6486002)(71200400001)(66066001)(2501003)(71190400001)(68736007)(6436002)(53936002)(486006)(6116002)(3846002)(446003)(86362001)(11346002)(476003)(7416002)(186003)(2351001)(6506007)(6916009)(97736004)(102836004)(50226002)(6512007)(36756003)(105586002)(966005)(26005)(8936002)(14454004)(99286004)(4326008)(25786009)(81166006)(54906003)(1730700003)(256004)(386003)(81156014)(316002)(52116002)(305945005)(8676002)(2616005)(76176011)(2906002)(478600001)(6306002)(7736002);DIR:OUT;SFP:1102;SCL:1;SRVR:BN7PR08MB6004;H:BN7PR08MB4945.namprd08.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: checkvideo.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: 4Cz8UGVFJ9cy5NPFvbHhJyeNdzeq0//37teQyr+5jDQ0xQCqZSJyQYzXf5cr05VIHlnO8m/XlLBYjSeUutUAgc/kBNZcqpvtdT5OctTO6qPAziXif344cLJXWUFxOSOGAIBFIL3GP30HHa7RdQBMYkjv8DxpgUxMo3rBy/bXG7ueJU4FDL45rIb5PtHVIZlDto+JrkAVScWNoVRkvTWwdlobYdCSmJ4hcv5pYNSfyAqMzJQX7/NWQ20VB/9BCh/EH3Wdos9gb8BEyNEp91cg9lIavgPWVJXW+CbE1OJ0g6Mby/Cy2aMefiGt60CY5KFv58VOIVwFII4xoVao+1iwrxINxb1bNaV0idbzuAWAGlBe92NakOVbgC5EwDWWIwN8q/kdscicIa4Gh2Cv8Q8MlpUvNbvkK4prfih0bEwWvkc=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: checkvideo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c8e865a7-8827-4520-c2fd-08d6af002789
X-MS-Exchange-CrossTenant-originalarrivaltime: 22 Mar 2019 19:54:12.2908
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 7280061d-06ed-4a4e-a2b1-cc9ab5638c09
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN7PR08MB6004
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


This patch series introduces two experimental features to git-p4,
which unrelated to each other.
 1. The first patch adds support for so-called "alien" branches.
    The feature lets git-p4 create empty commits
    to make the history or tags more accurate.
    It is particularly useful when splitting a large Perforce depot
    into multiple git repositories.
 2. The second patch adds support for loading changelist information from a=
 file.
    (`p4 -G describe` equivalent)
    The original use case is to be able to migrate a Perforce depot,
    which database got a little bit corrupted, into git.

It would be nice to get some feedback to see
if these features are usable in general and are worth mainlining at all.

The patches don't contain documentation or test changes yet,
because I wanted to get feedback first
if there is interest in mainlining these features in the first place.

This patch series should be applied on top of
"[PATCH v2 0/7] git-p4: a few assorted fixes for branches, excludes" [1]

[1] https://public-inbox.org/git/cover.1551485349.git.amazo@checkvideo.com/=
t/#m965fb5895d25d6b42638dd8efbb96e9fa9182978

Andrey Mazo (2):
  git-p4: introduce alien branch mappings
  git-p4: support loading changelist descriptions from files

 git-p4.py | 84 ++++++++++++++++++++++++++++++++++++++++++++++---------
 1 file changed, 71 insertions(+), 13 deletions(-)


base-commit: 8104ec994ea3849a968b4667d072fedd1e688642
prerequisite-patch-id: 23e039fec7a1f5c51c98326a14d788adb1ecb5ba
prerequisite-patch-id: 030a0acdce715ff99916fd412832e5a9471225c3
prerequisite-patch-id: 10661f77392f4131d2375976c77a7cd231fdf9ab
prerequisite-patch-id: a55360c904eba1b9e9c934405d3141eb96c5ad30
prerequisite-patch-id: 46357586199c02d956d53d782a12f1ee0c991302
prerequisite-patch-id: c683e7d6017580df9385a1544af409ca615d770c
prerequisite-patch-id: 411dcb5e95aff036e0cb3e850ea75f2424b260a6
--=20
2.19.2

