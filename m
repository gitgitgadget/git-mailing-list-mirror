Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.2 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	UNPARSEABLE_RELAY shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 4EECA20248
	for <e@80x24.org>; Thu, 18 Apr 2019 09:01:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388324AbfDRJB4 convert rfc822-to-8bit (ORCPT
        <rfc822;e@80x24.org>); Thu, 18 Apr 2019 05:01:56 -0400
Received: from smtppost.atos.net ([193.56.114.164]:6682 "EHLO
        smtppost.atos.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1733049AbfDRJBz (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 18 Apr 2019 05:01:55 -0400
X-Greylist: delayed 400 seconds by postgrey-1.27 at vger.kernel.org; Thu, 18 Apr 2019 05:01:53 EDT
Received: from mail2-ext.my-it-solutions.net (mail2-ext.my-it-solutions.net) by smarthost5.atos.net with smtp
        (TLS: TLSv1/SSLv3,256bits,ECDHE-RSA-AES256-GCM-SHA384)
         id 6a3b_53aa_b7382217_86e1_4faa_a09c_6dd817face6f;
        Thu, 18 Apr 2019 10:55:11 +0200
Received: from mail3-int.my-it-solutions.net ([10.92.32.10])
        by mail2-ext.my-it-solutions.net (8.15.2/8.15.2) with ESMTPS id x3I8tB0G022696
        (version=TLSv1.2 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK)
        for <git@vger.kernel.org>; Thu, 18 Apr 2019 10:55:11 +0200
Received: from DEFTHW99ETZMSX.ww931.my-it-solutions.net (defthw99etzmsx.ww931.my-it-solutions.net [10.86.142.54])
        by mail3-int.my-it-solutions.net (8.15.2/8.15.2) with ESMTPS id x3I8tAlc006983
        (version=TLSv1.2 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL)
        for <git@vger.kernel.org>; Thu, 18 Apr 2019 10:55:10 +0200
Received: from DEERLM99ETQMSX.ww931.my-it-solutions.net (10.86.142.102) by
 DEFTHW99ETZMSX.ww931.my-it-solutions.net (10.86.142.54) with Microsoft SMTP
 Server (TLS) id 14.3.439.0; Thu, 18 Apr 2019 10:55:11 +0200
Received: from EUR04-VI1-obe.outbound.protection.outlook.com (10.86.142.137)
 by hybridsmtp.it-solutions.atos.net (10.86.142.102) with Microsoft SMTP
 Server (TLS) id 14.3.439.0; Thu, 18 Apr 2019 10:55:10 +0200
Received: from AM6PR02MB4950.eurprd02.prod.outlook.com (20.177.199.143) by
 AM6PR02MB4118.eurprd02.prod.outlook.com (20.177.115.218) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1813.12; Thu, 18 Apr 2019 08:55:09 +0000
Received: from AM6PR02MB4950.eurprd02.prod.outlook.com
 ([fe80::147e:c96e:accd:c32b]) by AM6PR02MB4950.eurprd02.prod.outlook.com
 ([fe80::147e:c96e:accd:c32b%6]) with mapi id 15.20.1813.011; Thu, 18 Apr 2019
 08:55:09 +0000
From:   "CHIGOT, CLEMENT" <clement.chigot@atos.net>
To:     "git@vger.kernel.org" <git@vger.kernel.org>
Subject: [PATCH] Makefile: use fileno macro work around on AIX
Thread-Topic: [PATCH] Makefile: use fileno macro work around on AIX
Thread-Index: AQHU9b30g0YvBtQV9EenTNqvceLDfw==
Date:   Thu, 18 Apr 2019 08:55:09 +0000
Message-ID: <AM6PR02MB4950A1A625EEA54D4423C1BCEA260@AM6PR02MB4950.eurprd02.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=clement.chigot@atos.net; 
x-originating-ip: [193.56.241.24]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 33b2a667-7161-4ecd-e503-08d6c3db8fbe
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600141)(711020)(4605104)(2017052603328)(7193020);SRVR:AM6PR02MB4118;
x-ms-traffictypediagnostic: AM6PR02MB4118:
x-microsoft-antispam-prvs: <AM6PR02MB4118A7C48DBE44964EFE952AEA260@AM6PR02MB4118.eurprd02.prod.outlook.com>
x-forefront-prvs: 0011612A55
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(366004)(376002)(346002)(396003)(136003)(39860400002)(199004)(189003)(86362001)(7696005)(4744005)(6436002)(6916009)(66066001)(53346004)(256004)(68736007)(9686003)(99286004)(478600001)(53936002)(2501003)(6116002)(14454004)(3846002)(71200400001)(71190400001)(26005)(25786009)(5640700003)(81166006)(81156014)(186003)(33656002)(1730700003)(2906002)(6506007)(102836004)(97736004)(8676002)(316002)(7736002)(305945005)(5660300002)(55016002)(8936002)(486006)(2351001)(74316002)(476003)(52536014);DIR:OUT;SFP:1102;SCL:1;SRVR:AM6PR02MB4118;H:AM6PR02MB4950.eurprd02.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: atos.net does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: sWxVa3l5fyx8cAx5GouNIGQfSlLbSrSyy0rT53Qz3yBGQYJzJKRm0GHYwNv/+KhYPNELbbMrSMt6dmqJ74J6DSCHtcy/qlK7echyAAQcPkrLaiiblWgNqoUwCCWQBxwPZcfI3Oq+i0AcOdmNg3EvW+w3wdYiS8rWZMxpC/nV/3hOG4HhVndi8MsWXdxu6ggFbeCi7+/zdRepi1hc2kJ7pMaMN8g3GCabJ8AXTjn88mHo3SPreAVZYCmKMYfLq3dxpV7DElE4fCUrn5wEqGKP4HELSzjP3o97bxHhTrw2x20EMT9V24b4dnhLIeFPHbxgahhDf8o3UanUsNlW0ljVDcHqKKI/DJ0EIhp19FKeUo1ymaRR713xqW93xESC48ZovLAvUWtTUsirQrsj8YRasIdQhpojnwltAly9cBuWkwk=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: 8BIT
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-Network-Message-Id: 33b2a667-7161-4ecd-e503-08d6c3db8fbe
X-MS-Exchange-CrossTenant-originalarrivaltime: 18 Apr 2019 08:55:09.5669
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 33440fc6-b7c7-412c-bb73-0e70b0198d5a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM6PR02MB4118
X-OriginatorOrg: atos.net
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Declare FILENO_IS_A_MACRO on AIX

On AIX, fileno(fp) is a macro and need to use the work around already made for BSD's. 

Signed-off-by: Clément Chigot <clement.chigot@atos.net>
---
 config.mak.uname | 1 +
 1 file changed, 1 insertion(+)

diff --git a/config.mak.uname b/config.mak.uname
index 41e85fab1c..86cbe47627 100644
--- a/config.mak.uname
+++ b/config.mak.uname
@@ -269,6 +269,7 @@ ifeq ($(uname_S),AIX)
 	INTERNAL_QSORT = UnfortunatelyYes
 	NEEDS_LIBICONV = YesPlease
 	BASIC_CFLAGS += -D_LARGE_FILES
+	FILENO_IS_A_MACRO = UnfortunatelyYes
 	ifeq ($(shell expr "$(uname_V)" : '[1234]'),1)
 		NO_PTHREADS = YesPlease
 	else
-- 
2.17.1
