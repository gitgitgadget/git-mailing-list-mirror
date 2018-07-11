Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI,T_DKIMWL_WL_HIGH shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id CE6A51F85D
	for <e@80x24.org>; Wed, 11 Jul 2018 21:41:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390491AbeGKVrt (ORCPT <rfc822;e@80x24.org>);
        Wed, 11 Jul 2018 17:47:49 -0400
Received: from mail-bl2nam02on0122.outbound.protection.outlook.com ([104.47.38.122]:12608
        "EHLO NAM02-BL2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S2389121AbeGKVrt (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 11 Jul 2018 17:47:49 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=KrUXnzc22E2KNI31q0P51AXCxDtBWBvzgLEqXta232I=;
 b=FeT7RpMRJmPq4IEfiOJIjFDUPbn2gSzd1jeh/r5rWEJDcIhxkL8vNx7h6RVEHbrM0NcrZ0WP6UKgR/sP6n/NdhvnID7NsL3ZIsCb7fLISuEKZMyYyVkw8m87YzZiSeFuPOnlesXrgpe0AbKxzq5WwP28dm31CqNcuj2EpXYGaqY=
Received: from BL0PR2101MB1012.namprd21.prod.outlook.com (52.132.24.11) by
 BL0PR2101MB1060.namprd21.prod.outlook.com (52.132.24.18) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.952.4; Wed, 11 Jul 2018 21:41:26 +0000
Received: from BL0PR2101MB1012.namprd21.prod.outlook.com
 ([fe80::d865:2b6c:e0c8:7724]) by BL0PR2101MB1012.namprd21.prod.outlook.com
 ([fe80::d865:2b6c:e0c8:7724%3]) with mapi id 15.20.0952.017; Wed, 11 Jul 2018
 21:41:26 +0000
From:   Ben Peart <Ben.Peart@microsoft.com>
To:     Ben Peart <Ben.Peart@microsoft.com>
CC:     "git@vger.kernel.org" <git@vger.kernel.org>,
        "gitster@pobox.com" <gitster@pobox.com>,
        "sbeller@google.com" <sbeller@google.com>,
        Ben Peart <Ben.Peart@microsoft.com>,
        Ben Peart <Ben.Peart@microsoft.com>
Subject: [PATCH v2] handle lower case drive letters on Windows
Thread-Topic: [PATCH v2] handle lower case drive letters on Windows
Thread-Index: AQHUGV/rQxoDRab+A0SVbRKOt9Xf/w==
Date:   Wed, 11 Jul 2018 21:41:26 +0000
Message-ID: <20180711214110.17396-1-benpeart@microsoft.com>
References: <20180711175420.16940-1-benpeart@microsoft.com>
In-Reply-To: <20180711175420.16940-1-benpeart@microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [70.33.148.227]
x-mailer: git-send-email 2.17.0.gvfs.1.123.g449c066
x-clientproxiedby: CY4PR02CA0046.namprd02.prod.outlook.com
 (2603:10b6:903:117::32) To BL0PR2101MB1012.namprd21.prod.outlook.com
 (2603:10b6:207:37::11)
x-ms-exchange-messagesentrepresentingtype: 1
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;BL0PR2101MB1060;7:xXi7Q5XguKWbenKENcQq158BAcF8YeQ9b/eksi1mmb52TbXgRkWmW/5ReglbFz/rdqQvGAlW9tZwBA2ZP7pOGtZfuqB3J6DJ+0y+w7ncqi/8EoWdtyQYJfk+AEnq6ZPV6B6WZ6rBZrsKvPmpW6vi3tQG81yeO7jNPmv8wxvtYA0gIusK0LYedNHsPS7otKXN8Jd3gZlyxUCE1WuQ7Xbj6XOr8+j53wAV3P71iGneNpuY6eUNfoUV51kDAIsaREPn
x-ms-office365-filtering-correlation-id: 6ae7fcc9-8859-4581-f76d-08d5e7770dc6
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989117)(5600053)(711020)(48565401081)(2017052603328)(7193020);SRVR:BL0PR2101MB1060;
x-ms-traffictypediagnostic: BL0PR2101MB1060:
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Ben.Peart@microsoft.com; 
x-microsoft-antispam-prvs: <BL0PR2101MB10603AC79A8BB2FD4E84B116F45A0@BL0PR2101MB1060.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(28532068793085)(89211679590171)(166708455590820);
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(5005006)(8121501046)(3002001)(93006095)(93001095)(10201501046)(3231311)(944501410)(52105095)(2018427008)(6055026)(149027)(150027)(6041310)(20161123560045)(20161123562045)(20161123558120)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123564045)(6072148)(201708071742011)(7699016);SRVR:BL0PR2101MB1060;BCL:0;PCL:0;RULEID:;SRVR:BL0PR2101MB1060;
x-forefront-prvs: 0730093765
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(39860400002)(396003)(346002)(136003)(376002)(366004)(189003)(199004)(107886003)(1511001)(81166006)(81156014)(86612001)(66066001)(25786009)(305945005)(8676002)(8936002)(10290500003)(478600001)(966005)(386003)(102836004)(3846002)(72206003)(68736007)(26005)(76176011)(256004)(4326008)(6862004)(10090500001)(97736004)(6116002)(1076002)(14444005)(7736002)(2616005)(5660300001)(106356001)(2906002)(50226002)(52116002)(6486002)(99286004)(316002)(6506007)(11346002)(54906003)(2900100001)(446003)(476003)(37006003)(6636002)(6436002)(14454004)(22452003)(36756003)(53936002)(486006)(6306002)(6512007)(5250100002)(105586002);DIR:OUT;SFP:1102;SCL:1;SRVR:BL0PR2101MB1060;H:BL0PR2101MB1012.namprd21.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: microsoft.com does not designate
 permitted sender hosts)
x-microsoft-antispam-message-info: yfaOqrIyMXgDhthsL2MG5y6t/WKlIYIz0DFLnsemRxoc5xprsC8eBV2VmqoKrWB6kvlIfKEM6vOXVKQi1STwvigmzjuLC8I+2OTNpQzqL14kITwsaL8aJfwif3mIxmY+ywkYl4S5HuFvibXL+8SVqFBJ6RpSpijbBx+b09c/rUZ4ppxc5IQXJ9kVckTMRPaCDgBDHPvzqFyxDJ0zsWiwaVYNoF5lRZAXf2hSrLqr8gLVW/CoRK0Z1eGVtwL81MJns9GvPp1DCuFdzcjpMA5qgMU++Q9Q1lAZCEPnOwOOOJwhIkvDqLtXJERbDjD9kNgWgEvIPu03BtEIsPItoPR3EuCNVozE0Zt8sXAf6B8DTXE=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6ae7fcc9-8859-4581-f76d-08d5e7770dc6
X-MS-Exchange-CrossTenant-originalarrivaltime: 11 Jul 2018 21:41:26.9029
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL0PR2101MB1060
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Windows, if a tool calls SetCurrentDirectory with a lower case drive
letter, the subsequent call to GetCurrentDirectory will return the same
lower case drive letter. If that happens, test-drop-caches will error out a=
s
it does not correctly to handle lower case drive letters.

Signed-off-by: Ben Peart <Ben.Peart@microsoft.com>
---

Notes:
    Base Ref: master
    Web-Diff: https://github.com/benpeart/git/commit/b497c111a7
    Checkout: git fetch https://github.com/benpeart/git drop-caches-v2 && g=
it checkout b497c111a7
   =20
    ### Interdiff (v1..v2):
   =20
    ### Patches

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

