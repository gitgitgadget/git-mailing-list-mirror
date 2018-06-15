Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI,T_DKIMWL_WL_HIGH shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id B7B561F403
	for <e@80x24.org>; Fri, 15 Jun 2018 18:27:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1756549AbeFOS1z (ORCPT <rfc822;e@80x24.org>);
        Fri, 15 Jun 2018 14:27:55 -0400
Received: from mail-by2nam01on0097.outbound.protection.outlook.com ([104.47.34.97]:15823
        "EHLO NAM01-BY2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1756546AbeFOS1y (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 15 Jun 2018 14:27:54 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=v9IauXAwV0/0WsfEhIFvI2a36AB3h7urYikOI7hSNko=;
 b=W3tktTQZGcZJJ8WAQmfUYammf56BtgBlKdchRccWn1UNX7cJKYDY5nuXTbE6t8qyvcTk6324qDp3oCiIqswOTlN2F3nr1gAHMRGGd/79WFmypv4ZmYeh7CGC6UP+OarbKq61YSX89PIieFNetiWE/aBX9uB/JxA0Wlp/xjJMHLA=
Received: from BL0PR2101MB1011.namprd21.prod.outlook.com (52.132.24.10) by
 BL0PR2101MB0995.namprd21.prod.outlook.com (52.132.23.157) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384_P256) id
 15.20.884.9; Fri, 15 Jun 2018 18:27:52 +0000
Received: from BL0PR2101MB1011.namprd21.prod.outlook.com
 ([fe80::d1f2:1d69:2567:e0a9]) by BL0PR2101MB1011.namprd21.prod.outlook.com
 ([fe80::d1f2:1d69:2567:e0a9%2]) with mapi id 15.20.0884.004; Fri, 15 Jun 2018
 18:27:52 +0000
From:   Derrick Stolee <dstolee@microsoft.com>
To:     "git@vger.kernel.org" <git@vger.kernel.org>
CC:     "peff@peff.net" <peff@peff.net>,
        "gitster@pobox.com" <gitster@pobox.com>,
        "ramsay@ramsayjones.plus.com" <ramsay@ramsayjones.plus.com>,
        Derrick Stolee <dstolee@microsoft.com>
Subject: [PATCH v2 7/7] ewah_io: delete unused 'ewah_serialize()'
Thread-Topic: [PATCH v2 7/7] ewah_io: delete unused 'ewah_serialize()'
Thread-Index: AQHUBNaRkjhMbR0btkSnAimAlFcPjg==
Date:   Fri, 15 Jun 2018 18:27:52 +0000
Message-ID: <20180615182727.172075-8-dstolee@microsoft.com>
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
x-microsoft-exchange-diagnostics: 1;BL0PR2101MB0995;7:2QyRtVEm+dB2A3ezR5Kzun7J4Bmr/n+3Uu+ZKBfBO4zcfQrdrtmmqEQQ5F2C/8/28+PtI8N07KJPrfzqbBEMCDMFD4+phiXKkmyDmEdk8V+UVqL54eFA7vHPGZRhbVPFIs9nILgYq93mde5m0igdpRR7uTLrxQ+/OVJZ6AezVw4yeP1VZG7YMap5K3N9H3wsH5m6YMW+BsTxKQB5cn886My7wK+pww/R68GRxgmPP/No/jycpX+BzjALtXaphZg9
x-ms-office365-filtering-correlation-id: da89a458-752f-4ae9-8ace-08d5d2edb444
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(4534165)(4627221)(201703031133081)(201702281549075)(5600026)(711020)(48565401081)(2017052603328)(7193020);SRVR:BL0PR2101MB0995;
x-ms-traffictypediagnostic: BL0PR2101MB0995:
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=dstolee@microsoft.com; 
x-microsoft-antispam-prvs: <BL0PR2101MB0995D802E6C85BBE8B705B35A17C0@BL0PR2101MB0995.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(28532068793085)(89211679590171);
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(5005006)(8121501046)(10201501046)(93006095)(93001095)(3231254)(2018427008)(944501410)(52105095)(3002001)(6055026)(149027)(150027)(6041310)(20161123558120)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123560045)(20161123562045)(20161123564045)(6072148)(201708071742011)(7699016);SRVR:BL0PR2101MB0995;BCL:0;PCL:0;RULEID:;SRVR:BL0PR2101MB0995;
x-forefront-prvs: 0704670F76
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(376002)(346002)(39380400002)(366004)(39860400002)(396003)(189003)(199004)(10090500001)(5640700003)(22452003)(6916009)(99286004)(5660300001)(107886003)(8936002)(6116002)(102836004)(54906003)(6486002)(86362001)(5250100002)(316002)(2616005)(2501003)(1076002)(2900100001)(36756003)(97736004)(68736007)(8656006)(6436002)(2906002)(305945005)(10290500003)(478600001)(81166006)(2351001)(186003)(53936002)(486006)(14454004)(105586002)(25786009)(52116002)(7736002)(46003)(76176011)(446003)(106356001)(11346002)(3280700002)(6506007)(3660700001)(6512007)(476003)(86612001)(4326008)(8676002)(386003)(1730700003)(81156014)(22906009);DIR:OUT;SFP:1102;SCL:1;SRVR:BL0PR2101MB0995;H:BL0PR2101MB1011.namprd21.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: microsoft.com does not designate
 permitted sender hosts)
x-microsoft-antispam-message-info: WIW+Mv7xTBtk5yXCVZQ4BPFhIV+lcyvndM99tk/95nKVbNdHyiIFAuAm+ICbP3+f/QjoT04HvAFP28Np+Kr/4VJlWw7Fw/TMsT4Y3GF4s20ibbEGsvJubEkwkumjyyrgJPHCjLrjzQEc4s8NvpG8lStULKVU4Ztw6tuUEy0zxzz9YRVZshsZTzYoNKq730lP
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: da89a458-752f-4ae9-8ace-08d5d2edb444
X-MS-Exchange-CrossTenant-originalarrivaltime: 15 Jun 2018 18:27:52.0879
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL0PR2101MB0995
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Reported-by: Ramsay Jones <ramsay@ramsayjones.plus.com>
Signed-off-by: Derrick Stolee <dstolee@microsoft.com>
---
 ewah/ewah_io.c | 10 ----------
 ewah/ewok.h    |  1 -
 2 files changed, 11 deletions(-)

diff --git a/ewah/ewah_io.c b/ewah/ewah_io.c
index bed1994551..86d3f1d02e 100644
--- a/ewah/ewah_io.c
+++ b/ewah/ewah_io.c
@@ -100,16 +100,6 @@ int ewah_serialize_to(struct ewah_bitmap *self,
 	return (3 * 4) + (self->buffer_size * 8);
 }
=20
-static int write_helper(void *fd, const void *buf, size_t len)
-{
-	return write((intptr_t)fd, buf, len);
-}
-
-int ewah_serialize(struct ewah_bitmap *self, int fd)
-{
-	return ewah_serialize_to(self, write_helper, (void *)(intptr_t)fd);
-}
-
 static int write_strbuf(void *user_data, const void *data, size_t len)
 {
 	struct strbuf *sb =3D user_data;
diff --git a/ewah/ewok.h b/ewah/ewok.h
index a540df2aa9..f3ac78ef1a 100644
--- a/ewah/ewok.h
+++ b/ewah/ewok.h
@@ -86,7 +86,6 @@ void ewah_free(struct ewah_bitmap *self);
 int ewah_serialize_to(struct ewah_bitmap *self,
 		      int (*write_fun)(void *out, const void *buf, size_t len),
 		      void *out);
-int ewah_serialize(struct ewah_bitmap *self, int fd);
 int ewah_serialize_native(struct ewah_bitmap *self, int fd);
 int ewah_serialize_strbuf(struct ewah_bitmap *self, struct strbuf *);
=20
--=20
2.18.0.rc1

