Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI,T_DKIMWL_WL_HIGH shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id E853B1F403
	for <e@80x24.org>; Fri, 15 Jun 2018 14:30:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S965896AbeFOOav (ORCPT <rfc822;e@80x24.org>);
        Fri, 15 Jun 2018 10:30:51 -0400
Received: from mail-eopbgr710105.outbound.protection.outlook.com ([40.107.71.105]:51530
        "EHLO NAM05-BY2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1756005AbeFOOaj (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 15 Jun 2018 10:30:39 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=SYRWIhh/kxUaMKRDN2UHu4Q8lDdVoDlW0QdP09jNzOA=;
 b=W72tFWnaO95vaw3i2x/PiC7RPWnvEBqEwFlQL+KgPHhODyAksJKTx8SPsl9uvThxhsf7kjJw17WVVrEe+1SjxYkhb3NomRgjUJA7VJ6skU5cN5Xd8F15ezLgQYkFl6QdfwTqNMCqiZR9SRDpCXZNLGkQxebwtoF/GN50e4OYQh8=
Received: from BL0PR2101MB1011.namprd21.prod.outlook.com (52.132.24.10) by
 BL0PR2101MB1011.namprd21.prod.outlook.com (52.132.24.10) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.884.9; Fri, 15 Jun 2018 14:30:37 +0000
Received: from BL0PR2101MB1011.namprd21.prod.outlook.com
 ([fe80::d1f2:1d69:2567:e0a9]) by BL0PR2101MB1011.namprd21.prod.outlook.com
 ([fe80::d1f2:1d69:2567:e0a9%2]) with mapi id 15.20.0884.004; Fri, 15 Jun 2018
 14:30:37 +0000
From:   Derrick Stolee <dstolee@microsoft.com>
To:     "git@vger.kernel.org" <git@vger.kernel.org>
CC:     "ramsay@ramsayjones.plus.com" <ramsay@ramsayjones.plus.com>,
        "peff@peff.next" <peff@peff.next>,
        Derrick Stolee <dstolee@microsoft.com>
Subject: [PATCH 5/8] ewah_bitmap: delete unused 'ewah_not()'
Thread-Topic: [PATCH 5/8] ewah_bitmap: delete unused 'ewah_not()'
Thread-Index: AQHUBLVt9rlB9LmW002i9fHYeGOG+w==
Date:   Fri, 15 Jun 2018 14:30:37 +0000
Message-ID: <20180615143018.170686-6-dstolee@microsoft.com>
References: <f25c0798-7778-7146-5349-ae2c2fb560dd@ramsayjones.plus.com>
 <20180615143018.170686-1-dstolee@microsoft.com>
In-Reply-To: <20180615143018.170686-1-dstolee@microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: BN6PR08CA0062.namprd08.prod.outlook.com
 (2603:10b6:404:b9::24) To BL0PR2101MB1011.namprd21.prod.outlook.com
 (2603:10b6:207:37::10)
x-ms-exchange-messagesentrepresentingtype: 1
x-originating-ip: [2001:4898:8010:0:eb4a:5dff:fe0f:730f]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;BL0PR2101MB1011;7:lxoAwMWvMr4vSjEtPuobkFSKBsNhkx0Pu67yCKiPI5xpLKEOli7fszfobDAjHNXcQ9i/YKp+xi0iZtv2BxnwrCxrjjjq09H0LcmoepmksLkCRu9TcOxGtHNI9YUDs9OVfxUojzHWXMN2xBWdm4IaqogCLeWCn4JIscR5NpAZaIBEH2cmukmG8FhD5iBca24YP5AYm8BRNgW6nbtUeA7WCz7fui9VBFBR/oy4pxLkoghqILrLAI5D59q+4XUWXUUT
x-ms-office365-filtering-correlation-id: c6051383-8d13-4d71-9d94-08d5d2cc8f93
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(4534165)(4627221)(201703031133081)(201702281549075)(5600026)(711020)(48565401081)(2017052603328)(7193020);SRVR:BL0PR2101MB1011;
x-ms-traffictypediagnostic: BL0PR2101MB1011:
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=dstolee@microsoft.com; 
x-microsoft-antispam-prvs: <BL0PR2101MB101127ABDB5B2E843FEB6AB6A17C0@BL0PR2101MB1011.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(28532068793085)(89211679590171);
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(8121501046)(5005006)(3002001)(3231254)(2018427008)(944501410)(52105095)(93006095)(93001095)(10201501046)(6055026)(149027)(150027)(6041310)(20161123564045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123558120)(20161123562045)(20161123560045)(6072148)(201708071742011)(7699016);SRVR:BL0PR2101MB1011;BCL:0;PCL:0;RULEID:;SRVR:BL0PR2101MB1011;
x-forefront-prvs: 0704670F76
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(346002)(39860400002)(376002)(39380400002)(396003)(366004)(199004)(189003)(305945005)(3660700001)(446003)(386003)(68736007)(76176011)(52116002)(6486002)(54906003)(476003)(8936002)(6436002)(53936002)(3280700002)(316002)(22452003)(5660300001)(5640700003)(102836004)(2616005)(2351001)(25786009)(2906002)(99286004)(8676002)(1730700003)(46003)(86362001)(81156014)(11346002)(81166006)(6512007)(86612001)(6506007)(107886003)(97736004)(1076002)(105586002)(6916009)(4326008)(486006)(36756003)(10290500003)(478600001)(106356001)(186003)(6116002)(5250100002)(14454004)(7736002)(2501003)(2900100001)(10090500001)(22906009);DIR:OUT;SFP:1102;SCL:1;SRVR:BL0PR2101MB1011;H:BL0PR2101MB1011.namprd21.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: microsoft.com does not designate
 permitted sender hosts)
x-microsoft-antispam-message-info: LcknHxm+4OJdnPjisMo/nsV3QtmTuHl5LySKm4o+T93TrqhTHeXmTzGDDF8c6Y+kFDiujRnOvL5HWa3z28MGZyWwfpJCGbUiFEaKvQ8llvqw1Q8LIpvUxOQWwtI19oRYhyvEgBs8oJhpr5tNDka0RHe8+WMbZnuARmBbBWnLhAbO7XL2mxsRQG9ZdoWWaiGX
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c6051383-8d13-4d71-9d94-08d5d2cc8f93
X-MS-Exchange-CrossTenant-originalarrivaltime: 15 Jun 2018 14:30:37.2614
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL0PR2101MB1011
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
index 21c420770e..4b665d09d9 100644
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

