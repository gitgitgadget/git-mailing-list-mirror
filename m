Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE,UNPARSEABLE_RELAY shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id C44791F463
	for <e@80x24.org>; Tue, 17 Sep 2019 15:09:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729117AbfIQPI7 convert rfc822-to-8bit (ORCPT
        <rfc822;e@80x24.org>); Tue, 17 Sep 2019 11:08:59 -0400
Received: from smtppost.atos.net ([193.56.114.176]:31888 "EHLO
        smtppost.atos.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729079AbfIQPI7 (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 17 Sep 2019 11:08:59 -0400
X-Greylist: delayed 609 seconds by postgrey-1.27 at vger.kernel.org; Tue, 17 Sep 2019 11:08:57 EDT
Received: from mail1-ext.my-it-solutions.net (mail1-ext.my-it-solutions.net) by smarthost5.atos.net with smtp
        (TLS: TLSv1/SSLv3,256bits,ECDHE-RSA-AES256-GCM-SHA384)
         id 7a82_56ba_535c3138_fb05_4f5e_9df8_cf64c97d5e3f;
        Tue, 17 Sep 2019 16:58:43 +0200
Received: from mail1-int.my-it-solutions.net ([10.92.32.11])
        by mail1-ext.my-it-solutions.net (8.15.2/8.15.2) with ESMTPS id x8HEwhJk026782
        (version=TLSv1.2 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK)
        for <git@vger.kernel.org>; Tue, 17 Sep 2019 16:58:43 +0200
Received: from DEERLM99ETVMSX.ww931.my-it-solutions.net ([10.86.142.97])
        by mail1-int.my-it-solutions.net (8.15.2/8.15.2) with ESMTPS id x8HEwhsw028316
        (version=TLSv1.2 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL)
        for <git@vger.kernel.org>; Tue, 17 Sep 2019 16:58:43 +0200
Received: from DEERLM99ETUMSX.ww931.my-it-solutions.net (10.86.142.96) by
 DEERLM99ETVMSX.ww931.my-it-solutions.net (10.86.142.97) with Microsoft SMTP
 Server (TLS) id 14.3.439.0; Tue, 17 Sep 2019 16:58:43 +0200
Received: from EUR01-DB5-obe.outbound.protection.outlook.com (10.86.142.137)
 by hybridsmtp.it-solutions.atos.net (10.86.142.96) with Microsoft SMTP Server
 (TLS) id 14.3.439.0; Tue, 17 Sep 2019 16:58:42 +0200
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=m7ojBGns4CqwR/fCt/pUwy14o4C0j7t9nZ2kd44ckgEndKYN6XbU3bmbMCBLuYGjZEPj8Vhb8iGaUSS/VxKsx4vXNHVJIs1TDf7wZB8Bu+zfHI58LiXb2UW/pyP0K8ofmpSjzPPIxNTPx5H5tlYh+a36i3+xMOmEAbc/T/Zb/+VQRTxvZZ7zXCnZvra1ldqcbNOXh2p3wkWqu185XMwd6AzcRrtqbNO2qgbg19wehnMHFjJATywNauLwwMtQ104xEgTTGOJrCvM7Jgeu3egwnLkAYB7OpLUE23Jk08oI2WnW+JXHdpRiVgThxOlZrC1SVeB3+b4ayIoe9Ga7723LxA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=7979AxMGwdxznVJOtidEyt6JJ6dqk68N8Px91J1faPM=;
 b=QswHcLpOqrXIZfoH9qJMW0Czwn3841dan/d3xQO3q9RXqi1+bRjarTwCEL9rZkIMVvd9WgVdqEpPlFvH7efx6akpD74m+YfK9y8P75Ioh6lY60mUqoOZMFF8LqNO0qNT2pyXMotSLlH2z5V2oozmo/CsHzz6MVQZ8k3h5+/FqQgn4OFNEhvybJYdu+xA5sDrkJd/WtIdod2oj7FNP6GtDzhKgfxaOKtZPFmZtuF06s+CG5GkGGTmy3TIPma83+GqrUzq65YneCvTJeFJ16b6zGUbjRJQI+Z0cw+0/bvoXiQuBRY2XUSqVFjvTGQeSJJFu4QvoxGzSnrVDdtsWHYZqg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=atos.net; dmarc=pass action=none header.from=atos.net;
 dkim=pass header.d=atos.net; arc=none
Received: from AM6PR02MB4950.eurprd02.prod.outlook.com (20.177.199.143) by
 AM6PR02MB5286.eurprd02.prod.outlook.com (20.178.91.77) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2263.23; Tue, 17 Sep 2019 14:58:41 +0000
Received: from AM6PR02MB4950.eurprd02.prod.outlook.com
 ([fe80::f519:eb95:46ab:57e1]) by AM6PR02MB4950.eurprd02.prod.outlook.com
 ([fe80::f519:eb95:46ab:57e1%7]) with mapi id 15.20.2263.023; Tue, 17 Sep 2019
 14:58:41 +0000
From:   "CHIGOT, CLEMENT" <clement.chigot@atos.net>
To:     "git@vger.kernel.org" <git@vger.kernel.org>
Subject: [PATCH] contrib/svn-fe: fix shebang for svnrdump_sim.py
Thread-Topic: [PATCH] contrib/svn-fe: fix shebang for svnrdump_sim.py
Thread-Index: AQHVbWfjpf8qbjULekqkto+U7J2AFg==
Date:   Tue, 17 Sep 2019 14:58:41 +0000
Message-ID: <AM6PR02MB49509E34B4DC357582262193EA8F0@AM6PR02MB4950.eurprd02.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=clement.chigot@atos.net; 
x-originating-ip: [193.56.241.25]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 901a2a15-4764-4d90-d37c-08d73b7f873f
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(5600167)(711020)(4605104)(1401327)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(2017052603328)(7193020);SRVR:AM6PR02MB5286;
x-ms-traffictypediagnostic: AM6PR02MB5286:
x-microsoft-antispam-prvs: <AM6PR02MB528646B64FAA9885D978F213EA8F0@AM6PR02MB5286.eurprd02.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:6108;
x-forefront-prvs: 01630974C0
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(4636009)(136003)(396003)(366004)(376002)(346002)(39860400002)(189003)(199004)(2906002)(4744005)(52536014)(478600001)(5640700003)(2501003)(5660300002)(71200400001)(6436002)(71190400001)(99286004)(66946007)(9686003)(305945005)(7736002)(66476007)(256004)(76116006)(14444005)(3846002)(6116002)(91956017)(66556008)(25786009)(64756008)(66446008)(74316002)(14454004)(6916009)(102836004)(2351001)(476003)(486006)(26005)(86362001)(6506007)(8936002)(186003)(55016002)(33656002)(8676002)(66574012)(7696005)(81156014)(1730700003)(66066001)(81166006)(316002);DIR:OUT;SFP:1102;SCL:1;SRVR:AM6PR02MB5286;H:AM6PR02MB4950.eurprd02.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: atos.net does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: 8Y+YMr4FQLKB6P5hlaMMfSYGjEPzmw6GfOLnODHjKzILyEepXG5Kkf3eqUyHfFmDWqffz3nggVbJr/rRei1JE0+oemd1DCvT3oBNUrg8IO12UCU9w9HLE6ppTyxM7ZrdcEeegckT+G1BcH+prjvO3WJv0htjorehvz6Ry2Ar+eDc/p15W1ARn5WPCUZjWljrUpF066lWtFnbZGaX0itAfXU/7FXwMhpCjMjq2izoxWa7YyA0hnwFtqF0ZIRYfIVAboYAbnbs8pQV1UDfCHm0PnMw+qHompiBCnIsArPaW8BJBdzX1/1Wh05IpmU0mbZazasLXZWNzmbRY+DCQ5548yWz/4ESGbRYdhQyr9Eq0iqZKqVhl7O9iW5P6bCzxWN44iUzlfcRkFkd2ro3KlBex6pXHvVGeu6HDOAu8Jih6H4=
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: 8BIT
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-Network-Message-Id: 901a2a15-4764-4d90-d37c-08d73b7f873f
X-MS-Exchange-CrossTenant-originalarrivaltime: 17 Sep 2019 14:58:41.0927
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 33440fc6-b7c7-412c-bb73-0e70b0198d5a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: WW0TpWuaoxvEJF0xLPIBYWzDZX8sE7stlrMZyaRxoVMvUKi5QQOiZxJ+1uPz5fob1JIR9mpH0oIYuDDjRWuyEw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM6PR02MB5286
X-OriginatorOrg: atos.net
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

The shebang for a python script should be "/usr/bin/env python" and not
"/usr/bin/python". On some OSes like AIX, python default path is not under
"/usr/bin" ("/opt/freeware/bin" for AIX).

Note the main reason behind this change is that AIX rpm will add a
dependency on "/usr/bin/python" instead of "/usr/bin/env".

Signed-off-by: Clément Chigot <clement.chigot@atos.net>
---
 contrib/svn-fe/svnrdump_sim.py | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/contrib/svn-fe/svnrdump_sim.py b/contrib/svn-fe/svnrdump_sim.py
index 11ac6f6927..50c6a4f89d 100755
--- a/contrib/svn-fe/svnrdump_sim.py
+++ b/contrib/svn-fe/svnrdump_sim.py
@@ -1,4 +1,4 @@
-#!/usr/bin/python
+#!/usr/bin/env python
 """
 Simulates svnrdump by replaying an existing dump from a file, taking care
 of the specified revision range.
-- 
2.17.1


Clément Chigot
ATOS Bull SAS
1 rue de Provence - 38432 Échirolles - France

