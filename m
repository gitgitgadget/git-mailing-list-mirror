Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI,T_DKIMWL_WL_HIGH shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 6FD231F403
	for <e@80x24.org>; Fri, 15 Jun 2018 14:30:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S965741AbeFOOah (ORCPT <rfc822;e@80x24.org>);
        Fri, 15 Jun 2018 10:30:37 -0400
Received: from mail-eopbgr710127.outbound.protection.outlook.com ([40.107.71.127]:15136
        "EHLO NAM05-BY2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1756005AbeFOOae (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 15 Jun 2018 10:30:34 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=MG4v3p+ZuzGqnO0bwn5xzuf1Cw8NhVaqLR6XD1Js1Mw=;
 b=RCLg5rF/F/AznA/Y9ZJCi369B0DJJYsLlsAgss2rpnNcSQXCXZcLVT280LfXKcQb34gYkAX+z3oWIQ2KnX1VzpAN8do5RwGDmO+KrEpFue97RBjXJt93FGYPy2qSxrYKqPgl86ORVXrZL/XNzVS+nUB+/DqmT71AGLLxwbLEhZY=
Received: from BL0PR2101MB1011.namprd21.prod.outlook.com (52.132.24.10) by
 BL0PR2101MB1011.namprd21.prod.outlook.com (52.132.24.10) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.884.9; Fri, 15 Jun 2018 14:30:33 +0000
Received: from BL0PR2101MB1011.namprd21.prod.outlook.com
 ([fe80::d1f2:1d69:2567:e0a9]) by BL0PR2101MB1011.namprd21.prod.outlook.com
 ([fe80::d1f2:1d69:2567:e0a9%2]) with mapi id 15.20.0884.004; Fri, 15 Jun 2018
 14:30:33 +0000
From:   Derrick Stolee <dstolee@microsoft.com>
To:     "git@vger.kernel.org" <git@vger.kernel.org>
CC:     "ramsay@ramsayjones.plus.com" <ramsay@ramsayjones.plus.com>,
        "peff@peff.next" <peff@peff.next>,
        Derrick Stolee <dstolee@microsoft.com>
Subject: [PATCH 2/8] ewah/bitmap.c: delete unused 'bitmap_each_bit()'
Thread-Topic: [PATCH 2/8] ewah/bitmap.c: delete unused 'bitmap_each_bit()'
Thread-Index: AQHUBLVqes42n+EhwUagP6Tg3k3REg==
Date:   Fri, 15 Jun 2018 14:30:32 +0000
Message-ID: <20180615143018.170686-3-dstolee@microsoft.com>
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
x-microsoft-exchange-diagnostics: 1;BL0PR2101MB1011;7:Xct3YAa6KjqEEoAki9XM43QtiJFSa4r8I2djfD1qAi/GG1boHrfwGewJo/dzNFNudp61+8MvCpS+xd6D7B31p68ts85qvJLWTlKJS6Zvswzj26Jbb97OSCEdvXIfmNxCEaeMwQdEGlQqsEOInmyT/pyNLOBC6553nFkxO6HxQ8scfeJtatxKKC9X9C61WXeAfaiOmWL1MA3wya2YcYI6r86yHho0gAqIrgyoTZ1rRtLcaCj1Nfs+rdQ0Q/oJ47Js
x-ms-office365-filtering-correlation-id: 1daff48d-6db3-4259-8ad3-08d5d2cc8cfb
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(4534165)(4627221)(201703031133081)(201702281549075)(5600026)(711020)(48565401081)(2017052603328)(7193020);SRVR:BL0PR2101MB1011;
x-ms-traffictypediagnostic: BL0PR2101MB1011:
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=dstolee@microsoft.com; 
x-microsoft-antispam-prvs: <BL0PR2101MB101165C789229E5EE54BB068A17C0@BL0PR2101MB1011.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(28532068793085)(89211679590171);
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(8121501046)(5005006)(3002001)(3231254)(2018427008)(944501410)(52105095)(93006095)(93001095)(10201501046)(6055026)(149027)(150027)(6041310)(20161123564045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123558120)(20161123562045)(20161123560045)(6072148)(201708071742011)(7699016);SRVR:BL0PR2101MB1011;BCL:0;PCL:0;RULEID:;SRVR:BL0PR2101MB1011;
x-forefront-prvs: 0704670F76
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(346002)(39860400002)(376002)(39380400002)(396003)(366004)(199004)(189003)(305945005)(3660700001)(446003)(386003)(68736007)(76176011)(52116002)(6486002)(54906003)(476003)(8936002)(6436002)(53936002)(3280700002)(316002)(22452003)(5660300001)(5640700003)(102836004)(2616005)(2351001)(25786009)(2906002)(99286004)(8676002)(1730700003)(46003)(86362001)(81156014)(11346002)(81166006)(6512007)(86612001)(6506007)(107886003)(97736004)(1076002)(105586002)(6916009)(4326008)(486006)(36756003)(10290500003)(478600001)(106356001)(186003)(6116002)(5250100002)(14454004)(7736002)(2501003)(2900100001)(10090500001)(22906009);DIR:OUT;SFP:1102;SCL:1;SRVR:BL0PR2101MB1011;H:BL0PR2101MB1011.namprd21.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: microsoft.com does not designate
 permitted sender hosts)
x-microsoft-antispam-message-info: gxQEQVmB4z6OdRbWdA7Fk0uxmRSkLNscVKkKL45hbPjqCjxITfD6oHkCQc12GE4SD1xG6FPlzPJAbqaA/OWiJFRFOwEnYftRHlpXXVtzG6ePKwU3kRTJUEnfYZABHgM8s9xYF0qU3+JAyv9ziXmiTxAqEPV5FUyy4c2Ccv9aHlkaTUlCadj64uy/EsJDbj+/
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1daff48d-6db3-4259-8ad3-08d5d2cc8cfb
X-MS-Exchange-CrossTenant-originalarrivaltime: 15 Jun 2018 14:30:32.8433
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
 ewah/bitmap.c | 24 ------------------------
 1 file changed, 24 deletions(-)

diff --git a/ewah/bitmap.c b/ewah/bitmap.c
index d61dc6114a..52f1178db4 100644
--- a/ewah/bitmap.c
+++ b/ewah/bitmap.c
@@ -129,30 +129,6 @@ void bitmap_or_ewah(struct bitmap *self, struct ewah_b=
itmap *other)
 		self->words[i++] |=3D word;
 }
=20
-void bitmap_each_bit(struct bitmap *self, ewah_callback callback, void *da=
ta)
-{
-	size_t pos =3D 0, i;
-
-	for (i =3D 0; i < self->word_alloc; ++i) {
-		eword_t word =3D self->words[i];
-		uint32_t offset;
-
-		if (word =3D=3D (eword_t)~0) {
-			for (offset =3D 0; offset < BITS_IN_EWORD; ++offset)
-				callback(pos++, data);
-		} else {
-			for (offset =3D 0; offset < BITS_IN_EWORD; ++offset) {
-				if ((word >> offset) =3D=3D 0)
-					break;
-
-				offset +=3D ewah_bit_ctz64(word >> offset);
-				callback(pos + offset, data);
-			}
-			pos +=3D BITS_IN_EWORD;
-		}
-	}
-}
-
 size_t bitmap_popcount(struct bitmap *self)
 {
 	size_t i, count =3D 0;
--=20
2.18.0.rc1

