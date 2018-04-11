Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI,T_DKIMWL_WL_HIGH shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 2941B1F404
	for <e@80x24.org>; Wed, 11 Apr 2018 21:27:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753878AbeDKSiF (ORCPT <rfc822;e@80x24.org>);
        Wed, 11 Apr 2018 14:38:05 -0400
Received: from mail-by2nam03on0132.outbound.protection.outlook.com ([104.47.42.132]:30641
        "EHLO NAM03-BY2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1753636AbeDKSiB (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 11 Apr 2018 14:38:01 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector1; h=From:Date:Subject:Message-ID:Content-Type:MIME-Version;
 bh=jF49l6lrEvyJuTG4Do0qQhPfmeb8tWjpSdIEfOAWtks=;
 b=T5gTIeQvEkobWtAsEietboiFbPjGkbX9YY+sUUnHk5mFWU/4k9W8cugXPGiLm7lP+t8bGY7Thq3bA4qv+Y049kOhyiSpGJfr/Ye6tAGbfS9+sDuESoSV/DgW6/l4Md/7/gG4N/XTLWQO8Bx/CfA2dUmnSCOTSKP2h3Sumk5ZmQ4=
Received: from BL0PR2101MB1106.namprd21.prod.outlook.com (52.132.24.29) by
 BL0PR2101MB0995.namprd21.prod.outlook.com (52.132.23.157) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384_P256) id
 15.20.696.0; Wed, 11 Apr 2018 18:37:54 +0000
Received: from BL0PR2101MB1106.namprd21.prod.outlook.com
 ([fe80::1516:5e9f:5649:ef8b]) by BL0PR2101MB1106.namprd21.prod.outlook.com
 ([fe80::1516:5e9f:5649:ef8b%4]) with mapi id 15.20.0696.006; Wed, 11 Apr 2018
 18:37:54 +0000
From:   Jameson Miller <jamill@microsoft.com>
To:     "git@vger.kernel.org" <git@vger.kernel.org>
CC:     "gitster@pobox.com" <gitster@pobox.com>,
        "peff@peff.net" <peff@peff.net>,
        "sunshine@sunshineco.com" <sunshine@sunshineco.com>,
        "ramsay@ramsayjones.plus.com" <ramsay@ramsayjones.plus.com>,
        Jameson Miller <jamill@microsoft.com>
Subject: [PATCH v4 1/3] fast-import: rename mem_pool type to mp_block
Thread-Topic: [PATCH v4 1/3] fast-import: rename mem_pool type to mp_block
Thread-Index: AQHT0cQzk3cxg4Z5wUy0kA7B5wbVzw==
Date:   Wed, 11 Apr 2018 18:37:53 +0000
Message-ID: <20180411183738.113809-2-jamill@microsoft.com>
References: <20180321164152.204869-1-jamill@microsoft.com>
In-Reply-To: <20180321164152.204869-1-jamill@microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [2001:4898:8010:1:1060:bd2c:4297:50e]
x-clientproxiedby: BL0PR02CA0037.namprd02.prod.outlook.com
 (2603:10b6:207:3d::14) To BL0PR2101MB1106.namprd21.prod.outlook.com
 (2603:10b6:207:37::29)
x-ms-exchange-messagesentrepresentingtype: 1
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;BL0PR2101MB0995;7:Xz+mg9k5cumTL/ZjAMpl940A1WK04u7McYjldBSdrsokbgWkLt6+X2nMAEN6i9QOnSMdEvudAg4QkLuzxvtRSaou3F8CrtU3OLA4OJJwVlTNE9sGPfRqPVZsQEjoIB5HehUWZPxpb40PBLs33zajCMnIkZqT9VHbS79BDHs6v0sOyA/E2ItW714M+2U8qzZO71GpLfRa9XE+PNrDxudl7ahUHJVZlzRrPKuXBzE/8xCWr1Dwlmk0OLTn1eZfvAhZ;20:1//1XuBzAyo5jqhKqsIdAPUyL7zKSGwQeBYWebE1e0UD1LKUYtpav38xUEUJiz0KPN+rprDokvAKMIeywYTUqTk4o7CGN+PkXmbMGI+TGfeUJgTWXxHx8FHdsxYaDF3cwBEgs4wjHe36xiSDV4ZkDFgFQb6nZhYwrZbBGIrbrBc=
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(5600026)(3008032)(48565401081)(4534165)(4627221)(201703031133081)(201702281549075)(2017052603328)(7193020);SRVR:BL0PR2101MB0995;
x-ms-traffictypediagnostic: BL0PR2101MB0995:
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=jamill@microsoft.com; 
x-microsoft-antispam-prvs: <BL0PR2101MB0995DC6E286EB9EDAB168FDECEBD0@BL0PR2101MB0995.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(28532068793085)(89211679590171);
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(61425038)(6040522)(2401047)(5005006)(8121501046)(10201501046)(93006095)(93001095)(3002001)(3231221)(944501327)(52105095)(6055026)(61426038)(61427038)(6041310)(20161123562045)(20161123564045)(20161123560045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123558120)(6072148)(201708071742011);SRVR:BL0PR2101MB0995;BCL:0;PCL:0;RULEID:;SRVR:BL0PR2101MB0995;
x-forefront-prvs: 0639027A9E
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(366004)(39380400002)(39860400002)(346002)(396003)(376002)(199004)(189003)(5250100002)(5640700003)(2501003)(6436002)(107886003)(53936002)(6512007)(305945005)(7736002)(6916009)(25786009)(478600001)(10290500003)(5660300001)(4326008)(86612001)(86362001)(575784001)(3660700001)(2900100001)(1076002)(14454004)(3280700002)(2906002)(6486002)(97736004)(54906003)(106356001)(186003)(2351001)(36756003)(105586002)(22452003)(52116002)(8656006)(99286004)(316002)(68736007)(386003)(102836004)(6506007)(76176011)(486006)(2616005)(46003)(446003)(11346002)(476003)(6116002)(8936002)(1730700003)(10090500001)(8676002)(81156014)(81166006)(22906009);DIR:OUT;SFP:1102;SCL:1;SRVR:BL0PR2101MB0995;H:BL0PR2101MB1106.namprd21.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: microsoft.com does not designate
 permitted sender hosts)
x-microsoft-antispam-message-info: 4QElyZNMM9cYwp4AAdPuvPAzyjAZfionOpRDrzQDIfuTY64fHb2rMZ+xvgYaxstIXWA35qxhZl7OhF76Hpt0vWqrmlmjUhTHegpYpCDdDG8ShVuHaubuQJ1YtE2uhlKN5Qz4G46byIyiNGQ+fbOV0fexSb58JBIbhvJkNzZHywCUqGUNpOCDUNJXfCyIhSGF7rSBJEW13U3aaWoWU4tbKM7ro+tkESc9zvwHlYygcUb09NpGvz6L1p6PLUwgqJ1+XMxUMtVwhOohTnQLlbYSnxTPzBmIcJeEf86fCGDZOQWTJu0XVzUlXpJ1oYZiWbNPcNdrW7tG/wMDxmzKNzoZ8o7DRjzgadEPvgHQR8KPNkVzBikQVVlf1odtikmEf5vDTzALI43kkhwN4SaIoSQ5kdNw8vit7p1/yyfJY3RANhE=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Office365-Filtering-Correlation-Id: 90d96571-dffb-4c3f-4c83-08d59fdb5623
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 90d96571-dffb-4c3f-4c83-08d59fdb5623
X-MS-Exchange-CrossTenant-originalarrivaltime: 11 Apr 2018 18:37:53.7893
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL0PR2101MB0995
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

This is part of a patch series to extract the memory pool logic in
fast-import into a more generalized version. The existing mem_pool type
maps more closely to a "block of memory" (mp_block) in the more
generalized memory pool. This commit renames the mem_pool to mp_block to
reduce churn in future patches.

Signed-off-by: Jameson Miller <jamill@microsoft.com>
---
 fast-import.c | 20 ++++++++++----------
 1 file changed, 10 insertions(+), 10 deletions(-)

diff --git a/fast-import.c b/fast-import.c
index 99f8f56e8c..38af0a294b 100644
--- a/fast-import.c
+++ b/fast-import.c
@@ -211,8 +211,8 @@ struct last_object {
 	unsigned no_swap : 1;
 };
=20
-struct mem_pool {
-	struct mem_pool *next_pool;
+struct mp_block {
+	struct mp_block *next_block;
 	char *next_free;
 	char *end;
 	uintmax_t space[FLEX_ARRAY]; /* more */
@@ -306,9 +306,9 @@ static int global_argc;
 static const char **global_argv;
=20
 /* Memory pools */
-static size_t mem_pool_alloc =3D 2*1024*1024 - sizeof(struct mem_pool);
+static size_t mem_pool_alloc =3D 2*1024*1024 - sizeof(struct mp_block);
 static size_t total_allocd;
-static struct mem_pool *mem_pool;
+static struct mp_block *mp_block_head;
=20
 /* Atom management */
 static unsigned int atom_table_sz =3D 4451;
@@ -638,14 +638,14 @@ static unsigned int hc_str(const char *s, size_t len)
=20
 static void *pool_alloc(size_t len)
 {
-	struct mem_pool *p;
+	struct mp_block *p;
 	void *r;
=20
 	/* round up to a 'uintmax_t' alignment */
 	if (len & (sizeof(uintmax_t) - 1))
 		len +=3D sizeof(uintmax_t) - (len & (sizeof(uintmax_t) - 1));
=20
-	for (p =3D mem_pool; p; p =3D p->next_pool)
+	for (p =3D mp_block_head; p; p =3D p->next_block)
 		if ((p->end - p->next_free >=3D len))
 			break;
=20
@@ -654,12 +654,12 @@ static void *pool_alloc(size_t len)
 			total_allocd +=3D len;
 			return xmalloc(len);
 		}
-		total_allocd +=3D sizeof(struct mem_pool) + mem_pool_alloc;
-		p =3D xmalloc(st_add(sizeof(struct mem_pool), mem_pool_alloc));
-		p->next_pool =3D mem_pool;
+		total_allocd +=3D sizeof(struct mp_block) + mem_pool_alloc;
+		p =3D xmalloc(st_add(sizeof(struct mp_block), mem_pool_alloc));
+		p->next_block =3D mp_block_head;
 		p->next_free =3D (char *) p->space;
 		p->end =3D p->next_free + mem_pool_alloc;
-		mem_pool =3D p;
+		mp_block_head =3D p;
 	}
=20
 	r =3D p->next_free;
--=20
2.14.3

