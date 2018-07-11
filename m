Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI,T_DKIMWL_WL_HIGH shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 2BA441F85D
	for <e@80x24.org>; Wed, 11 Jul 2018 17:54:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732987AbeGKSAI (ORCPT <rfc822;e@80x24.org>);
        Wed, 11 Jul 2018 14:00:08 -0400
Received: from mail-sn1nam02on0135.outbound.protection.outlook.com ([104.47.36.135]:19072
        "EHLO NAM02-SN1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726450AbeGKSAH (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 11 Jul 2018 14:00:07 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=BYpkLD4sr4yK0xDAiargw1j/xwKc4mxW2Qdh2QRR3XA=;
 b=BJnHmwQxa8d4VuKFwMv93OMGOHieXBuZFUY2y7TslzMNgILX1SN1cHfbp/LeWQibdLt+i0Ck69Go9AyCALDyww8OevcAAXHPzK4ENKwivISwnCPk3TNT8YtVXi4luw63z1KhESfPKOaJmZUb5EyfwHGNayvDMfxaifxz8qrNELY=
Received: from BL0PR2101MB1012.namprd21.prod.outlook.com (52.132.24.11) by
 BL0PR2101MB1074.namprd21.prod.outlook.com (52.132.24.20) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.952.4; Wed, 11 Jul 2018 17:54:40 +0000
Received: from BL0PR2101MB1012.namprd21.prod.outlook.com
 ([fe80::d865:2b6c:e0c8:7724]) by BL0PR2101MB1012.namprd21.prod.outlook.com
 ([fe80::d865:2b6c:e0c8:7724%3]) with mapi id 15.20.0952.017; Wed, 11 Jul 2018
 17:54:40 +0000
From:   Ben Peart <Ben.Peart@microsoft.com>
To:     "git@vger.kernel.org" <git@vger.kernel.org>
CC:     "gitster@pobox.com" <gitster@pobox.com>,
        Ben Peart <Ben.Peart@microsoft.com>,
        Ben Peart <Ben.Peart@microsoft.com>
Subject: [PATCH v1] handle lower case drive letters on Windows
Thread-Topic: [PATCH v1] handle lower case drive letters on Windows
Thread-Index: AQHUGUA9WUpXPhD60kqwA1StNOsHQg==
Date:   Wed, 11 Jul 2018 17:54:40 +0000
Message-ID: <20180711175420.16940-1-benpeart@microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [70.33.148.227]
x-mailer: git-send-email 2.17.0.gvfs.1.123.g449c066
x-clientproxiedby: MWHPR0201CA0004.namprd02.prod.outlook.com
 (2603:10b6:301:74::17) To BL0PR2101MB1012.namprd21.prod.outlook.com
 (2603:10b6:207:37::11)
x-ms-exchange-messagesentrepresentingtype: 1
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;BL0PR2101MB1074;7:xPFfWHQ6AeXl76x/HSPkL0Aw+3Z7IaCezn8PfUhng17xsOAEMbgF09+hJ8hHIgJssqeh14qPxQHJFXexUCVDxhe6XD7sGjl0yWL4zZZd1h5a96biKdCjPNptOeqOu/74TP3bkkxC/zPyqPPgVloA9aznZQI1zZVsEd1hmCEKH+bcZJqVxN4N96DqeUH8MPTT45ZX0xCgopv7Szvenlg9nmjslLe9CahbmdCSZkGBtvKriwTZEvPjyaffILlSy9zm
x-ms-office365-filtering-correlation-id: d364df4e-14bc-4975-34d1-08d5e7575f5a
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989117)(5600053)(711020)(4534165)(4627221)(201703031133081)(201702281549075)(8990107)(48565401081)(2017052603328)(7193020);SRVR:BL0PR2101MB1074;
x-ms-traffictypediagnostic: BL0PR2101MB1074:
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Ben.Peart@microsoft.com; 
x-microsoft-antispam-prvs: <BL0PR2101MB107428010C00C38ECAADE6BBF45A0@BL0PR2101MB1074.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(28532068793085)(89211679590171)(166708455590820);
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(8121501046)(5005006)(10201501046)(3002001)(3231311)(944501410)(52105095)(2018427008)(93006095)(93001095)(6055026)(149027)(150027)(6041310)(20161123562045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123564045)(20161123558120)(20161123560045)(6072148)(201708071742011)(7699016);SRVR:BL0PR2101MB1074;BCL:0;PCL:0;RULEID:;SRVR:BL0PR2101MB1074;
x-forefront-prvs: 0730093765
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(376002)(346002)(39860400002)(396003)(366004)(136003)(189003)(199004)(2900100001)(36756003)(22452003)(14454004)(5250100002)(316002)(10090500001)(2501003)(26005)(107886003)(6506007)(25786009)(186003)(386003)(99286004)(305945005)(54906003)(52116002)(4326008)(7736002)(2351001)(105586002)(102836004)(97736004)(106356001)(6436002)(5640700003)(8676002)(68736007)(3846002)(81166006)(1730700003)(66066001)(81156014)(6116002)(6512007)(6306002)(8936002)(53936002)(2906002)(14444005)(50226002)(256004)(478600001)(10290500003)(72206003)(476003)(2616005)(1076002)(86612001)(6916009)(966005)(486006)(6486002)(5660300001);DIR:OUT;SFP:1102;SCL:1;SRVR:BL0PR2101MB1074;H:BL0PR2101MB1012.namprd21.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: microsoft.com does not designate
 permitted sender hosts)
x-microsoft-antispam-message-info: GJPBDWVEEETWp5xfEfIffkqbW587vnVtv/2f4IIfcKk3Uy9l8e/L5pvQAM+etR7fLJZRsrBs1jNt5tSXc97eO1onJHWlXk21UFULtVVTBSieaszUZgBoRD1ltgAUT2OC8P6/leBXE2y9NbRr3ckUk62kXM4Rjo9Es2ul9VznsibySahJGW+wHFQdEpg19lAkGfkJX5SiqbObtrM2ikRCFa12GvY+/Srz4ScsB0s0sGJdOpLBBTjIUVYK5n23G77+xPz9M3LZpMgsRCfixQ0avTczLt294fmn6FxPzCUNZnYiAvF669bXz8CuPhnZKI9ttbOC/YEiCQvNhL1Hb2vDuVmwKrxTpEpl6PfAdVNLhSA=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d364df4e-14bc-4975-34d1-08d5e7575f5a
X-MS-Exchange-CrossTenant-originalarrivaltime: 11 Jul 2018 17:54:40.1805
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL0PR2101MB1074
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Teach test-drop-caches to handle lower case drive letters on Windows.

Signed-off-by: Ben Peart <Ben.Peart@microsoft.com>
---

Notes:
    Base Ref: master
    Web-Diff: https://github.com/benpeart/git/commit/55b815ee73
    Checkout: git fetch https://github.com/benpeart/git drop-caches-v1 && g=
it checkout 55b815ee73

 t/helper/test-drop-caches.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/t/helper/test-drop-caches.c b/t/helper/test-drop-caches.c
index d6bcfddf13..37047189c3 100644
--- a/t/helper/test-drop-caches.c
+++ b/t/helper/test-drop-caches.c
@@ -16,7 +16,7 @@ static int cmd_sync(void)
 	if ((0 =3D=3D dwRet) || (dwRet > MAX_PATH))
 		return error("Error getting current directory");
=20
-	if ((Buffer[0] < 'A') || (Buffer[0] > 'Z'))
+	if ((toupper(Buffer[0]) < 'A') || (toupper(Buffer[0]) > 'Z'))
 		return error("Invalid drive letter '%c'", Buffer[0]);
=20
 	szVolumeAccessPath[4] =3D Buffer[0];

base-commit: e3331758f12da22f4103eec7efe1b5304a9be5e9
--=20
2.17.0.gvfs.1.123.g449c066

