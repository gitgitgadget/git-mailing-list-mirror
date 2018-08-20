Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI,T_DKIMWL_WL_HIGH shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 47F4B1F954
	for <e@80x24.org>; Mon, 20 Aug 2018 16:52:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727406AbeHTUIX (ORCPT <rfc822;e@80x24.org>);
        Mon, 20 Aug 2018 16:08:23 -0400
Received: from mail-eopbgr710102.outbound.protection.outlook.com ([40.107.71.102]:35723
        "EHLO NAM05-BY2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727278AbeHTUIW (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 20 Aug 2018 16:08:22 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=HFUaD4H19dZP4CgAlNW+Np4a9OAg3GqIqNORmSKjkDw=;
 b=iDIvTbl1GmbOVxpukDzFZIw4rByQDUWKvvLlyBbN+5SPsUf1iWynUQQIXGq52tSF3FgfMpAq7KUxA8TKIdi+hgfxgTlIlTxrklYdk9WRkMP/yMgoiZ06wuPxA40d75eFW7Y237UdmcE+mlbenG47moG1ZbFcFgat6E6sKIbyHI4=
Received: from BL0PR2101MB1011.namprd21.prod.outlook.com (52.132.24.10) by
 BL0PR2101MB0994.namprd21.prod.outlook.com (52.132.23.156) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384_P256) id
 15.20.1080.2; Mon, 20 Aug 2018 16:51:53 +0000
Received: from BL0PR2101MB1011.namprd21.prod.outlook.com
 ([fe80::c997:1e4b:40d8:1a49]) by BL0PR2101MB1011.namprd21.prod.outlook.com
 ([fe80::c997:1e4b:40d8:1a49%2]) with mapi id 15.20.1101.000; Mon, 20 Aug 2018
 16:51:53 +0000
From:   Derrick Stolee <dstolee@microsoft.com>
To:     "git@vger.kernel.org" <git@vger.kernel.org>
CC:     Derrick Stolee <dstolee@microsoft.com>
Subject: [PATCH 1/9] multi-pack-index: provide more helpful usage info
Thread-Topic: [PATCH 1/9] multi-pack-index: provide more helpful usage info
Thread-Index: AQHUOKYYUXdOEn7HlkO1Yi3dlY46Ig==
Date:   Mon, 20 Aug 2018 16:51:53 +0000
Message-ID: <20180820165124.152146-2-dstolee@microsoft.com>
References: <20180820165124.152146-1-dstolee@microsoft.com>
In-Reply-To: <20180820165124.152146-1-dstolee@microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: CY4PR19CA0044.namprd19.prod.outlook.com
 (2603:10b6:903:103::30) To BL0PR2101MB1011.namprd21.prod.outlook.com
 (2603:10b6:207:37::10)
x-ms-exchange-messagesentrepresentingtype: 1
x-originating-ip: [2001:4898:e008:1:8b51:5dff:fe0f:730f]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;BL0PR2101MB0994;6:wNZtCPP4kp+BnFGX7aROU3c8d7m9SvfvZocGN+egq9v7aeI12oCfPh5G+dTvfErd3G4gA739kKsPWtivXE1p7XH3e4r51xU6e71MoEUKfKd+6P64FaSu580zOAOm+AsR8OxXOZTaG43EYawVGt4/Ea+kCEyE80ALbVsB8WB1mYZ+PUis5cKOspnJevGUgUxFYjBrBWojAxwPCJY/hsL5hGD2SiZgez5IZj8oMN9GwIeCRCGwMrc9IVa0kFqB5gWQoIg6Fr8GuHi5/OUub5GP+JpS49CjwBrD5K6RhhNn0jWGWm2fzTRCFQjXubM/N/Dkr8Zjn18dPXX7SrMFFNKE0MWM8E5oy2ST0OsvTP00iWo6DpAUf5q3aY5VqCua2RwTKjKSs7Ws9eMO89FH4cutpcRl4M5jd0q03ex4hY+Xew9q93cNUsdIqcGihaaYr3RILThhxTYllEhtJ+m61uHrdg==;5:ilBwOAmG/iIf/tqbQvFQTBNDzNRUBQdRsIv4rIcCfF5xXwmwrYvh63EdKI5YyHhWLUzj875Bw65QXA8qB0ZitEMjArenr0cUK8uxMHU21S8GKj5JNsxlffLU9yKsGvATgrRmrFhxesVib1Y8Pa5yI9Z2dycS/pHx6sv0MuthIII=;7:cg40AGNYgeQKoCT0iG6lmalQGseXvK7c5JjGh+dLVDTefPr5swEZzwqVk5gqlAobpjorpWJsSCHeneUOBLRzLqAEihB2TQz6v0HFTfL0psqtvlOwRmEuKbiHKVMZ7A5rOvStIwSL+uPS1mVrHQvwLLqblJI4ppfoNIG1LjcgJAlT8bz7+VpVO06DN4FXSlvlR7a6PmE65GVqi6CxmYSzaG5WEATCrrn6NEygoIg7pPwAQGJuZAKMcoq0UeHdhzGg
x-ms-office365-filtering-correlation-id: fb6cbcb3-dcff-491e-7204-08d606bd3b26
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989137)(4534165)(4627221)(201703031133081)(201702281549075)(8990107)(5600074)(711020)(4618075)(2017052603328)(7193020);SRVR:BL0PR2101MB0994;
x-ms-traffictypediagnostic: BL0PR2101MB0994:
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=dstolee@microsoft.com; 
x-microsoft-antispam-prvs: <BL0PR2101MB09949B2090024870D91D1136A1320@BL0PR2101MB0994.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(28532068793085)(89211679590171)(211171220733660);
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(20180801012)(6040522)(2401047)(5005006)(8121501046)(3231336)(944501410)(52105095)(2018427008)(10201501046)(93006095)(93001095)(3002001)(6055026)(149027)(150027)(6041310)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123560045)(20161123564045)(20161123562045)(20161123558120)(201708071742011)(7699016);SRVR:BL0PR2101MB0994;BCL:0;PCL:0;RULEID:;SRVR:BL0PR2101MB0994;
x-forefront-prvs: 0770F75EA9
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(396003)(39860400002)(136003)(376002)(346002)(366004)(189003)(199004)(99286004)(7736002)(10090500001)(6916009)(476003)(1076002)(1730700003)(8676002)(81166006)(81156014)(186003)(6116002)(46003)(2616005)(97736004)(486006)(305945005)(52116002)(5250100002)(316002)(446003)(2501003)(386003)(36756003)(6506007)(22452003)(102836004)(11346002)(5660300001)(6486002)(107886003)(6436002)(256004)(4326008)(5640700003)(76176011)(14454004)(106356001)(8936002)(53936002)(2906002)(68736007)(86612001)(2900100001)(25786009)(86362001)(105586002)(478600001)(2351001)(6512007)(10290500003);DIR:OUT;SFP:1102;SCL:1;SRVR:BL0PR2101MB0994;H:BL0PR2101MB1011.namprd21.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: microsoft.com does not designate
 permitted sender hosts)
x-microsoft-antispam-message-info: eg+1s9N9R5DuBhYD/DpLmoLXyxfzvkdeEsEzDc6t8OW7oRQB7zHbGpPVTA5ql17c/MauCP1ssWRReaWhXYrxkImxAtYjVKjO6+Jkn3we/E4mtRRMUn+w4L5V2oPJPVZlR9/QfG2oE/E/RKduHRlBt2utfAQers1z3xvpdFXo8922zEnC9dAKKnikHij2tklN/H4QPkpNmXS2U0UyylLuYXDFUzMBrq8eA406cH+KjT+yR00gfdHriW+bs4HxVnVUalwHfywzoWxcaCWgLx1Q2OdjJRmJfnvNwOps37lK2qhbc5NPlQe5E+jAS7E76yUUYgc5zZBhu5BjeQ2M3sgTYguT97iE6Jipj7RtLa1whF4=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: fb6cbcb3-dcff-491e-7204-08d606bd3b26
X-MS-Exchange-CrossTenant-originalarrivaltime: 20 Aug 2018 16:51:53.5538
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL0PR2101MB0994
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

The multi-pack-index builtin has a very simple command-line
interface. Instead of simply reporting usage, give the user a
hint to why the arguments failed.

Reported-by: Eric Sunshine <sunshine@sunshineco.com>
Signed-off-by: Derrick Stolee <dstolee@microsoft.com>
---
 builtin/multi-pack-index.c | 16 ++++++++--------
 1 file changed, 8 insertions(+), 8 deletions(-)

diff --git a/builtin/multi-pack-index.c b/builtin/multi-pack-index.c
index 6a7aa00cf2..2633efd95d 100644
--- a/builtin/multi-pack-index.c
+++ b/builtin/multi-pack-index.c
@@ -32,16 +32,16 @@ int cmd_multi_pack_index(int argc, const char **argv,
 		opts.object_dir =3D get_object_directory();
=20
 	if (argc =3D=3D 0)
-		goto usage;
+		usage_with_options(builtin_multi_pack_index_usage,
+				   builtin_multi_pack_index_options);
=20
-	if (!strcmp(argv[0], "write")) {
-		if (argc > 1)
-			goto usage;
+	if (argc > 1) {
+		die(_("too many arguments"));
+		return 1;
+	}
=20
+	if (!strcmp(argv[0], "write"))
 		return write_midx_file(opts.object_dir);
-	}
=20
-usage:
-	usage_with_options(builtin_multi_pack_index_usage,
-			   builtin_multi_pack_index_options);
+	die(_("unrecognized verb: %s"), argv[0]);
 }
--=20
2.18.0.118.gd4f65b8d14

