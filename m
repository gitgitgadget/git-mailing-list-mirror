Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI,T_DKIMWL_WL_HIGH shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 55B831F403
	for <e@80x24.org>; Fri, 15 Jun 2018 18:28:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1756551AbeFOS15 (ORCPT <rfc822;e@80x24.org>);
        Fri, 15 Jun 2018 14:27:57 -0400
Received: from mail-by2nam01on0097.outbound.protection.outlook.com ([104.47.34.97]:26880
        "EHLO NAM01-BY2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1756532AbeFOS1u (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 15 Jun 2018 14:27:50 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=atOtjHNRMAjs2F/Kpflk+R0erDx0e+bWawUhuhtE6M4=;
 b=aUqJ0Ee2hPO7G4uTVIUZTHBaJ3G2LBzOYuGd7ox8Sl0ifAJV76UAPTdK0RvjeffVFhBcgapPkli1q0HgU15eAk2h/9LfYpwHEDiNDRBSYcKemBnBnxa3zOKC5iOD5g4QAE7/kzcChjZWHrUhPea3mvhscsHOBZnkoX2qQbJF0qI=
Received: from BL0PR2101MB1011.namprd21.prod.outlook.com (52.132.24.10) by
 BL0PR2101MB1041.namprd21.prod.outlook.com (52.132.23.161) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.906.1; Fri, 15 Jun 2018 18:27:48 +0000
Received: from BL0PR2101MB1011.namprd21.prod.outlook.com
 ([fe80::d1f2:1d69:2567:e0a9]) by BL0PR2101MB1011.namprd21.prod.outlook.com
 ([fe80::d1f2:1d69:2567:e0a9%2]) with mapi id 15.20.0884.004; Fri, 15 Jun 2018
 18:27:48 +0000
From:   Derrick Stolee <dstolee@microsoft.com>
To:     "git@vger.kernel.org" <git@vger.kernel.org>
CC:     "peff@peff.net" <peff@peff.net>,
        "gitster@pobox.com" <gitster@pobox.com>,
        "ramsay@ramsayjones.plus.com" <ramsay@ramsayjones.plus.com>,
        Derrick Stolee <dstolee@microsoft.com>
Subject: [PATCH v2 5/7] ewah_bitmap: delete unused 'ewah_not()'
Thread-Topic: [PATCH v2 5/7] ewah_bitmap: delete unused 'ewah_not()'
Thread-Index: AQHUBNaPXNpNGE8mZ0acKDGT8AFyZQ==
Date:   Fri, 15 Jun 2018 18:27:48 +0000
Message-ID: <20180615182727.172075-6-dstolee@microsoft.com>
References: <20180615143018.170686-1-dstolee@microsoft.com>
 <20180615182727.172075-1-dstolee@microsoft.com>
In-Reply-To: <20180615182727.172075-1-dstolee@microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: BN6PR10CA0027.namprd10.prod.outlook.com
 (2603:10b6:404:109::13) To BL0PR2101MB1011.namprd21.prod.outlook.com
 (2603:10b6:207:37::10)
x-ms-exchange-messagesentrepresentingtype: 1
x-originating-ip: [2001:4898:8010:0:eb4a:5dff:fe0f:730f]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;BL0PR2101MB1041;7:4Tkk+OX3xHeOAZybvyvUa73EV4i8QrMPz2di5pVfV2wgBpOeYhq/qGvHVXrKz2DOUJc//oxCwZJaAqogB8PSJbex6cK51hSSa4vPQ4V62WVPQW6OXPSMfjWw7abRBJR43YSOIe4DnowlOi9fCbkQN8OsKVf76iS6vA9Ba0OsdcklbSwZebhyjkgiAIvOKKBCnjVGDqsjcozIpfJmUqb4rRpCzpIkfE+fTbRc/pBqGi7mNTVv5BXXE5TBtw2FHSV4
x-ms-office365-filtering-correlation-id: b5d030bf-115a-4f76-7c10-08d5d2edb210
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(4534165)(4627221)(201703031133081)(201702281549075)(5600026)(711020)(48565401081)(2017052603328)(7193020);SRVR:BL0PR2101MB1041;
x-ms-traffictypediagnostic: BL0PR2101MB1041:
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=dstolee@microsoft.com; 
x-microsoft-antispam-prvs: <BL0PR2101MB104109C3F586D5829C401C39A17C0@BL0PR2101MB1041.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(28532068793085)(89211679590171);
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(8121501046)(5005006)(3231254)(2018427008)(944501410)(52105095)(3002001)(93006095)(93001095)(10201501046)(6055026)(149027)(150027)(6041310)(20161123560045)(20161123562045)(20161123558120)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123564045)(6072148)(201708071742011)(7699016);SRVR:BL0PR2101MB1041;BCL:0;PCL:0;RULEID:;SRVR:BL0PR2101MB1041;
x-forefront-prvs: 0704670F76
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(396003)(39380400002)(39860400002)(366004)(346002)(376002)(189003)(199004)(8656006)(2351001)(6116002)(99286004)(6512007)(5250100002)(46003)(52116002)(1730700003)(76176011)(305945005)(7736002)(10090500001)(1076002)(68736007)(2900100001)(8676002)(5660300001)(86362001)(86612001)(2501003)(6916009)(54906003)(486006)(446003)(97736004)(386003)(2906002)(6486002)(6506007)(53936002)(11346002)(107886003)(3280700002)(81166006)(3660700001)(81156014)(316002)(10290500003)(8936002)(22452003)(106356001)(2616005)(25786009)(102836004)(476003)(105586002)(5640700003)(6436002)(14454004)(36756003)(186003)(4326008)(478600001)(22906009);DIR:OUT;SFP:1102;SCL:1;SRVR:BL0PR2101MB1041;H:BL0PR2101MB1011.namprd21.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: microsoft.com does not designate
 permitted sender hosts)
x-microsoft-antispam-message-info: kNwMQJpcXtcX0S6ao7mDmYdv4xTXzdB2UhrWf6P+C7HDk02EiG4Q7/wQVG3UE2cbwt5HTAMfcRKF1P852yJb60BooBaPgTMJceMLjBarrKAwO97b0o2tmknFVaR8l7PyOQ17CO87dCxz9BHrh5AZ00t45KcUX7EWgKnEAkiYkQV945ONWUR5ElE5IP0Ke0aX
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b5d030bf-115a-4f76-7c10-08d5d2edb210
X-MS-Exchange-CrossTenant-originalarrivaltime: 15 Jun 2018 18:27:48.3993
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL0PR2101MB1041
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Reported-by: Ramsay Jones <ramsay@ramsayjones.plus.com>
Signed-off-by: Derrick Stolee <dstolee@microsoft.com>
---
 ewah/ewah_bitmap.c | 19 -------------------
 ewah/ewok.h        |  7 -------
 2 files changed, 26 deletions(-)

diff --git a/ewah/ewah_bitmap.c b/ewah/ewah_bitmap.c
index 559adde37c..3fa3edf2a3 100644
--- a/ewah/ewah_bitmap.c
+++ b/ewah/ewah_bitmap.c
@@ -376,25 +376,6 @@ void ewah_iterator_init(struct ewah_iterator *it, stru=
ct ewah_bitmap *parent)
 		read_new_rlw(it);
 }
=20
-void ewah_not(struct ewah_bitmap *self)
-{
-	size_t pointer =3D 0;
-
-	while (pointer < self->buffer_size) {
-		eword_t *word =3D &self->buffer[pointer];
-		size_t literals, k;
-
-		rlw_xor_run_bit(word);
-		++pointer;
-
-		literals =3D rlw_get_literal_words(word);
-		for (k =3D 0; k < literals; ++k) {
-			self->buffer[pointer] =3D ~self->buffer[pointer];
-			++pointer;
-		}
-	}
-}
-
 void ewah_xor(
 	struct ewah_bitmap *ewah_i,
 	struct ewah_bitmap *ewah_j,
diff --git a/ewah/ewok.h b/ewah/ewok.h
index 8dae8a608c..a467645eec 100644
--- a/ewah/ewok.h
+++ b/ewah/ewok.h
@@ -95,13 +95,6 @@ int ewah_read_mmap(struct ewah_bitmap *self, const void =
*map, size_t len);
=20
 uint32_t ewah_checksum(struct ewah_bitmap *self);
=20
-/**
- * Logical not (bitwise negation) in-place on the bitmap
- *
- * This operation is linear time based on the size of the bitmap.
- */
-void ewah_not(struct ewah_bitmap *self);
-
 /**
  * Call the given callback with the position of every single bit
  * that has been set on the bitmap.
--=20
2.18.0.rc1

