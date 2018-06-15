Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI,T_DKIMWL_WL_HIGH shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 751A31F403
	for <e@80x24.org>; Fri, 15 Jun 2018 18:28:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1756555AbeFOS17 (ORCPT <rfc822;e@80x24.org>);
        Fri, 15 Jun 2018 14:27:59 -0400
Received: from mail-by2nam01on0138.outbound.protection.outlook.com ([104.47.34.138]:58324
        "EHLO NAM01-BY2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1756511AbeFOS1w (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 15 Jun 2018 14:27:52 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=k1phpfYoLCFBprekoHYH8ZHz6Bkl2Q15ArExE74WNEQ=;
 b=A9QDlHgk2Cek+uIx6AMktcm68ESNAb39HH5wFLYCN40S4O4xvFoEeSUb2UzyMojkqfzOGyN1pGnGPvcGOKY6E/JaQAdcs1O8ZYHXG4evkW+Ve/cIJlnCnhMp9gVnBrHOojg5MIR7Pc9tOCD9Y846ICTzjeqaEM6REFnsSv1dJ9I=
Received: from BL0PR2101MB1011.namprd21.prod.outlook.com (52.132.24.10) by
 BL0PR2101MB1041.namprd21.prod.outlook.com (52.132.23.161) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.906.1; Fri, 15 Jun 2018 18:27:50 +0000
Received: from BL0PR2101MB1011.namprd21.prod.outlook.com
 ([fe80::d1f2:1d69:2567:e0a9]) by BL0PR2101MB1011.namprd21.prod.outlook.com
 ([fe80::d1f2:1d69:2567:e0a9%2]) with mapi id 15.20.0884.004; Fri, 15 Jun 2018
 18:27:50 +0000
From:   Derrick Stolee <dstolee@microsoft.com>
To:     "git@vger.kernel.org" <git@vger.kernel.org>
CC:     "peff@peff.net" <peff@peff.net>,
        "gitster@pobox.com" <gitster@pobox.com>,
        "ramsay@ramsayjones.plus.com" <ramsay@ramsayjones.plus.com>,
        Derrick Stolee <dstolee@microsoft.com>
Subject: [PATCH v2 6/7] ewah_bitmap: delete unused 'ewah_or()'
Thread-Topic: [PATCH v2 6/7] ewah_bitmap: delete unused 'ewah_or()'
Thread-Index: AQHUBNaQYeBjVPjkbEKn1kKpx5suVw==
Date:   Fri, 15 Jun 2018 18:27:50 +0000
Message-ID: <20180615182727.172075-7-dstolee@microsoft.com>
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
x-microsoft-exchange-diagnostics: 1;BL0PR2101MB1041;7:KPAfkvYKwZl6UL3l3tB+2KqdCFmsWJ5xRpRiWffhxxWP0hQCOTq6yz6InZsd3BTtT1ZmiEDpSCc3o2OXr2eL0YazeWwu2hbRe3i7nDYWKHGrTY38MoO6bNbtbdbQkuW5zaw5ti3X8Trr0pitCBF5urwFJQK8EVR5ksKPRYCKCLMW1qt/NY1zTLHUC2dg2r4sQEr4hGR60ruQzvqFgX/AzqnsdcAzSi6kOEw47/0EI2GoQvmU5VvGoRhaHnAv/kAy
x-ms-office365-filtering-correlation-id: be850abe-d81b-4076-02ab-08d5d2edb330
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(4534165)(4627221)(201703031133081)(201702281549075)(5600026)(711020)(48565401081)(2017052603328)(7193020);SRVR:BL0PR2101MB1041;
x-ms-traffictypediagnostic: BL0PR2101MB1041:
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=dstolee@microsoft.com; 
x-microsoft-antispam-prvs: <BL0PR2101MB1041BC72B95E88AF0425F170A17C0@BL0PR2101MB1041.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(28532068793085)(89211679590171);
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(8121501046)(5005006)(3231254)(2018427008)(944501410)(52105095)(3002001)(93006095)(93001095)(10201501046)(6055026)(149027)(150027)(6041310)(20161123560045)(20161123562045)(20161123558120)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123564045)(6072148)(201708071742011)(7699016);SRVR:BL0PR2101MB1041;BCL:0;PCL:0;RULEID:;SRVR:BL0PR2101MB1041;
x-forefront-prvs: 0704670F76
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(396003)(39380400002)(39860400002)(366004)(346002)(376002)(189003)(199004)(8656006)(2351001)(6116002)(99286004)(6512007)(5250100002)(46003)(52116002)(1730700003)(76176011)(305945005)(7736002)(10090500001)(1076002)(68736007)(2900100001)(8676002)(5660300001)(86362001)(86612001)(2501003)(6916009)(54906003)(486006)(446003)(97736004)(386003)(2906002)(6486002)(6506007)(53936002)(11346002)(107886003)(3280700002)(81166006)(3660700001)(81156014)(316002)(10290500003)(8936002)(22452003)(106356001)(2616005)(25786009)(102836004)(476003)(105586002)(5640700003)(6436002)(14454004)(36756003)(186003)(4326008)(478600001)(22906009);DIR:OUT;SFP:1102;SCL:1;SRVR:BL0PR2101MB1041;H:BL0PR2101MB1011.namprd21.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: microsoft.com does not designate
 permitted sender hosts)
x-microsoft-antispam-message-info: tCt2VyIacW9V6DpCiWF79RQLrBRYhU3nAAfx6AVLkhPuc1YQPOHU/qF+PS2LnCe5gZfyBNai0Xviu9RO4dueH2gowuixGviayr+WjG4FMagNWeRSJZHfQk29TdwBxg/NRauca+WJwC6K/Bs000NRGDujgrboFU+x/lNjn+iUQj+gvrBZCQnSfDHlcbM9hPaf
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: be850abe-d81b-4076-02ab-08d5d2edb330
X-MS-Exchange-CrossTenant-originalarrivaltime: 15 Jun 2018 18:27:50.2986
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
 ewah/ewah_bitmap.c | 69 ----------------------------------------------
 ewah/ewok.h        |  5 ----
 2 files changed, 74 deletions(-)

diff --git a/ewah/ewah_bitmap.c b/ewah/ewah_bitmap.c
index 3fa3edf2a3..017c677f98 100644
--- a/ewah/ewah_bitmap.c
+++ b/ewah/ewah_bitmap.c
@@ -440,75 +440,6 @@ void ewah_xor(
 	out->bit_size =3D max_size(ewah_i->bit_size, ewah_j->bit_size);
 }
=20
-void ewah_or(
-	struct ewah_bitmap *ewah_i,
-	struct ewah_bitmap *ewah_j,
-	struct ewah_bitmap *out)
-{
-	struct rlw_iterator rlw_i;
-	struct rlw_iterator rlw_j;
-	size_t literals;
-
-	rlwit_init(&rlw_i, ewah_i);
-	rlwit_init(&rlw_j, ewah_j);
-
-	while (rlwit_word_size(&rlw_i) > 0 && rlwit_word_size(&rlw_j) > 0) {
-		while (rlw_i.rlw.running_len > 0 || rlw_j.rlw.running_len > 0) {
-			struct rlw_iterator *prey, *predator;
-
-			if (rlw_i.rlw.running_len < rlw_j.rlw.running_len) {
-				prey =3D &rlw_i;
-				predator =3D &rlw_j;
-			} else {
-				prey =3D &rlw_j;
-				predator =3D &rlw_i;
-			}
-
-			if (predator->rlw.running_bit) {
-				ewah_add_empty_words(out, 0,
-					predator->rlw.running_len);
-				rlwit_discard_first_words(prey,
-					predator->rlw.running_len);
-				rlwit_discard_first_words(predator,
-					predator->rlw.running_len);
-			} else {
-				size_t index =3D rlwit_discharge(prey, out,
-					predator->rlw.running_len, 0);
-				ewah_add_empty_words(out, 0,
-					predator->rlw.running_len - index);
-				rlwit_discard_first_words(predator,
-					predator->rlw.running_len);
-			}
-		}
-
-		literals =3D min_size(
-			rlw_i.rlw.literal_words,
-			rlw_j.rlw.literal_words);
-
-		if (literals) {
-			size_t k;
-
-			for (k =3D 0; k < literals; ++k) {
-				ewah_add(out,
-					rlw_i.buffer[rlw_i.literal_word_start + k] |
-					rlw_j.buffer[rlw_j.literal_word_start + k]
-				);
-			}
-
-			rlwit_discard_first_words(&rlw_i, literals);
-			rlwit_discard_first_words(&rlw_j, literals);
-		}
-	}
-
-	if (rlwit_word_size(&rlw_i) > 0)
-		rlwit_discharge(&rlw_i, out, ~0, 0);
-	else
-		rlwit_discharge(&rlw_j, out, ~0, 0);
-
-	out->bit_size =3D max_size(ewah_i->bit_size, ewah_j->bit_size);
-}
-
-
 #define BITMAP_POOL_MAX 16
 static struct ewah_bitmap *bitmap_pool[BITMAP_POOL_MAX];
 static size_t bitmap_pool_size;
diff --git a/ewah/ewok.h b/ewah/ewok.h
index a467645eec..a540df2aa9 100644
--- a/ewah/ewok.h
+++ b/ewah/ewok.h
@@ -157,11 +157,6 @@ void ewah_iterator_init(struct ewah_iterator *it, stru=
ct ewah_bitmap *parent);
  */
 int ewah_iterator_next(eword_t *next, struct ewah_iterator *it);
=20
-void ewah_or(
-	struct ewah_bitmap *ewah_i,
-	struct ewah_bitmap *ewah_j,
-	struct ewah_bitmap *out);
-
 void ewah_xor(
 	struct ewah_bitmap *ewah_i,
 	struct ewah_bitmap *ewah_j,
--=20
2.18.0.rc1

