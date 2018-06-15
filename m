Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI,T_DKIMWL_WL_HIGH shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 19EA31F403
	for <e@80x24.org>; Fri, 15 Jun 2018 14:30:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1756181AbeFOOac (ORCPT <rfc822;e@80x24.org>);
        Fri, 15 Jun 2018 10:30:32 -0400
Received: from mail-by2nam01on0129.outbound.protection.outlook.com ([104.47.34.129]:49504
        "EHLO NAM01-BY2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1756005AbeFOOab (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 15 Jun 2018 10:30:31 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=bNM40FLWXJvy5iOPe7fkY082xvORBPv6nRlEkcwxyMw=;
 b=ajbQyWn0O9d2MKqBRpLGlL4KlH2i3PKvTq+IoSYqKyBV/cIs/15PJcmkogCGJg/Ys1/99Us38ft/HS/lJiTiSm8oVlKut/vkS+eZjjEgj/2BuEqN1CZqTpiFWsJrfdfxWbLFdyQRiRpo++5q3k2H2f60t+LZ3uOTUZQ0SUSZOvE=
Received: from BL0PR2101MB1011.namprd21.prod.outlook.com (52.132.24.10) by
 BL0PR2101MB1123.namprd21.prod.outlook.com (52.132.20.151) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.884.10; Fri, 15 Jun 2018 14:30:29 +0000
Received: from BL0PR2101MB1011.namprd21.prod.outlook.com
 ([fe80::d1f2:1d69:2567:e0a9]) by BL0PR2101MB1011.namprd21.prod.outlook.com
 ([fe80::d1f2:1d69:2567:e0a9%2]) with mapi id 15.20.0884.004; Fri, 15 Jun 2018
 14:30:29 +0000
From:   Derrick Stolee <dstolee@microsoft.com>
To:     "git@vger.kernel.org" <git@vger.kernel.org>
CC:     "ramsay@ramsayjones.plus.com" <ramsay@ramsayjones.plus.com>,
        "peff@peff.next" <peff@peff.next>,
        Derrick Stolee <dstolee@microsoft.com>
Subject: [PATCH 0/8] Delete unused methods in EWAH bitmap
Thread-Topic: [PATCH 0/8] Delete unused methods in EWAH bitmap
Thread-Index: AQHUBLVoWrDkLw4+zUitu1VkqiZPhA==
Date:   Fri, 15 Jun 2018 14:30:29 +0000
Message-ID: <20180615143018.170686-1-dstolee@microsoft.com>
References: <f25c0798-7778-7146-5349-ae2c2fb560dd@ramsayjones.plus.com>
In-Reply-To: <f25c0798-7778-7146-5349-ae2c2fb560dd@ramsayjones.plus.com>
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
x-microsoft-exchange-diagnostics: 1;BL0PR2101MB1123;7:DCcStHmqExpdxxt1cdX47PE1UCqTmCoYxMMwVWXjosxBzuVBudCeuAqymY5ug1FKe/PPsIcEbZVWqdS9SBQki82OfoG3tjE7OmBG1Oh1qfsRBlSGx6pLfrM2U7Bb8LTi3nfRMXtT6KJIxTlmZblLQ6Qjn0F5U/GtU1jVDkmfTnS70O6Wr2anTlWexsQ4AUL3/2tugGWA/cN3j6/tx8H7Fq9c4Z8832YN6Vf6PcfNRRzoeugSzljtp8kUYm3KNdlB
x-ms-office365-filtering-correlation-id: 164af265-8ef9-4bc1-b112-08d5d2cc8afd
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(4534165)(4627221)(201703031133081)(201702281549075)(5600026)(711020)(48565401081)(2017052603328)(7193020);SRVR:BL0PR2101MB1123;
x-ms-traffictypediagnostic: BL0PR2101MB1123:
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=dstolee@microsoft.com; 
x-microsoft-antispam-prvs: <BL0PR2101MB112386797EF23F83ABFDE92DA17C0@BL0PR2101MB1123.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:;
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(5005006)(8121501046)(10201501046)(3231254)(2018427008)(944501410)(52105095)(93006095)(93001095)(3002001)(6055026)(149027)(150027)(6041310)(20161123558120)(20161123562045)(20161123564045)(20161123560045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(6072148)(201708071742011)(7699016);SRVR:BL0PR2101MB1123;BCL:0;PCL:0;RULEID:;SRVR:BL0PR2101MB1123;
x-forefront-prvs: 0704670F76
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(346002)(396003)(366004)(376002)(39860400002)(39380400002)(189003)(199004)(14454004)(5660300001)(68736007)(46003)(10290500003)(2906002)(478600001)(107886003)(36756003)(76176011)(105586002)(97736004)(186003)(106356001)(5640700003)(6512007)(3660700001)(6486002)(6436002)(86612001)(86362001)(3280700002)(4326008)(6916009)(305945005)(6506007)(8936002)(99286004)(8676002)(2900100001)(7736002)(54906003)(1730700003)(10090500001)(5250100002)(2351001)(2616005)(81156014)(81166006)(476003)(6116002)(25786009)(1076002)(102836004)(316002)(2501003)(53936002)(486006)(11346002)(52116002)(446003)(22452003)(386003)(59450400001)(22906009);DIR:OUT;SFP:1102;SCL:1;SRVR:BL0PR2101MB1123;H:BL0PR2101MB1011.namprd21.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: microsoft.com does not designate
 permitted sender hosts)
x-microsoft-antispam-message-info: xsTUaPCnpLn5cfSoBVS1SbjWWHyxSsIoqpOIloMkxPPLGADXnNMpmXc6mBLQf5nSijZycIw9NpdRR3aijXcvotbPJyYUM0jBo6kJCE3KRtX5AUF+nVnbCv0MTmmQf2nbE04pFIEkt6Y+cx+HhGsnBDL+qulTbZu2VDueWQ23YfE+uSzve1Ey15+vSPPsQVhg
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 164af265-8ef9-4bc1-b112-08d5d2cc8afd
X-MS-Exchange-CrossTenant-originalarrivaltime: 15 Jun 2018 14:30:29.5390
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL0PR2101MB1123
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

The EWAH bitmap code includes several logical operations that are
important for a general-purpose bitmap library. However, Git only
uses the XOR operation for storing deltas between reachability
bitmaps. This means that we can delete the following unused methods:

* ewah_and()
* ewah_and_not()
* ewah_not()
* ewah_or()
* ewah_serialize()
* ewah_serialize_native()

We can also delete the unused methods bitmap_clear() and
bitmap_each_bit().

Derrick Stolee (8):
  ewah/bitmap.c: delete unused 'bitmap_clear()'
  ewah/bitmap.c: delete unused 'bitmap_each_bit()'
  ewah_bitmap: delete unused 'ewah_and()'
  ewah_bitmap: delete unused 'ewah_and_not()'
  ewah_bitmap: delete unused 'ewah_not()'
  ewah_bitmap: delete unused 'ewah_or()'
  ewah_io: delete unused 'ewah_serialize()'
  ewah_io: delete unused 'ewah_serialize_native()'

 ewah/bitmap.c      |  32 -------
 ewah/ewah_bitmap.c | 229 ---------------------------------------------
 ewah/ewah_io.c     |  36 -------
 ewah/ewok.h        |  24 -----
 4 files changed, 321 deletions(-)


base-commit: fc54c1af3ec09bab8b8ea09768c2da4069b7f53e
--=20
2.18.0.rc1

