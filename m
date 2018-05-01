Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI,T_DKIMWL_WL_HIGH shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 85487215F4
	for <e@80x24.org>; Tue,  1 May 2018 12:46:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1755321AbeEAMq0 (ORCPT <rfc822;e@80x24.org>);
        Tue, 1 May 2018 08:46:26 -0400
Received: from mail-by2nam01on0098.outbound.protection.outlook.com ([104.47.34.98]:27747
        "EHLO NAM01-BY2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1755267AbeEAMqZ (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 1 May 2018 08:46:25 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector1; h=From:Date:Subject:Message-ID:Content-Type:MIME-Version;
 bh=VhX114ba8ab/qtah1elcMSP1tltPgvTI2IDdm6IlW9o=;
 b=kcJk5BN0o7o4mMwwE1DPhQ7X1mA2EJjd3Qlo7icUswomLYNgH3Ahvu0NZNY45pqfkpB5M2cB+l5u+l1HKP4BiniJZKqo8EtyOoEYRHlGsfu0ovVJrMOwg7ihOEPBG1xJwaQebh9xdaLA1Add+ZYuQHSyZ6nJ86GXjTgBKSCG+Hw=
Received: from DM5PR2101MB1016.namprd21.prod.outlook.com (52.132.133.38) by
 DM5PR2101MB0918.namprd21.prod.outlook.com (52.132.132.163) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.755.4; Tue, 1 May 2018 12:46:22 +0000
Received: from DM5PR2101MB1016.namprd21.prod.outlook.com
 ([fe80::5d76:2e71:c400:8b83]) by DM5PR2101MB1016.namprd21.prod.outlook.com
 ([fe80::5d76:2e71:c400:8b83%4]) with mapi id 15.20.0755.002; Tue, 1 May 2018
 12:46:22 +0000
From:   Ben Peart <Ben.Peart@microsoft.com>
To:     "git@vger.kernel.org" <git@vger.kernel.org>
CC:     "gitster@pobox.com" <gitster@pobox.com>,
        "j6t@kdbg.org" <j6t@kdbg.org>,
        "pclouds@gmail.com" <pclouds@gmail.com>,
        "sunshine@sunshineco.com" <sunshine@sunshineco.com>,
        "sbeller@google.com" <sbeller@google.com>,
        Ben Peart <Ben.Peart@microsoft.com>
Subject: [PATCH v2] test-drop-caches: simplify delay loading of
 NtSetSystemInformation
Thread-Topic: [PATCH v2] test-drop-caches: simplify delay loading of
 NtSetSystemInformation
Thread-Index: AQHT4UpoWdoxw7a2O0ammLxn933irA==
Date:   Tue, 1 May 2018 12:46:22 +0000
Message-ID: <20180501124603.21896-1-benpeart@microsoft.com>
References: <20180430142555.23260-1-benpeart@microsoft.com>
In-Reply-To: <20180430142555.23260-1-benpeart@microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [70.33.148.227]
x-mailer: git-send-email 2.17.0.windows.1
x-clientproxiedby: BN3PR03CA0063.namprd03.prod.outlook.com
 (2a01:111:e400:7a4d::23) To DM5PR2101MB1016.namprd21.prod.outlook.com
 (2603:10b6:4:a8::38)
x-ms-exchange-messagesentrepresentingtype: 1
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;DM5PR2101MB0918;7:KcpKQM54YUFa4DbJxP2XdKr5W4+XcNsbDmZ8pk1dAygjVWqmuIBn92NCk4wN31KB90d0K8ABhZqSNUtEz/+mErJ6vRSnOvzv8XZZOUV/f2/zWFqtAs1uLgCum33WjA1Db8sAOrmu9cgb3t5DzcN5elG3ufwwkCl3ZPGCYaiTQ1EjYFwuJo6mrsMF5aPyszVPxYsLYMNABBPK7GU1/7TJ4qkf3C6GFJt9xY9ukVV5Uv8LJX5astWiw5VzPMQgu93B;20:fC0y9j4qViY52vv+uolcXb1dcw78s1gPafmCbS5p1Siay7IXb9ZSA8WHRobet8aw4AalumKVKwNYd5eYljO8nDyhwYFjFTXYtFG3sVRD4Cc+bWOI4//BcoGh+E0QxUHLschNScOJj6/HVqcZyz/GpA3xPM4dkJvoBaY0kF2wcY4=
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(48565401081)(5600026)(4534165)(4627221)(201703031133081)(201702281549075)(2017052603328)(7193020);SRVR:DM5PR2101MB0918;
x-ms-traffictypediagnostic: DM5PR2101MB0918:
x-microsoft-antispam-prvs: <DM5PR2101MB09181E31B2172813BADF6091F4810@DM5PR2101MB0918.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(28532068793085)(89211679590171)(166708455590820);
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(8121501046)(5005006)(93006095)(93001095)(10201501046)(3231254)(2018427008)(944501410)(52105095)(3002001)(6055026)(6041310)(20161123564045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123558120)(20161123562045)(20161123560045)(6072148)(201708071742011);SRVR:DM5PR2101MB0918;BCL:0;PCL:0;RULEID:;SRVR:DM5PR2101MB0918;
x-forefront-prvs: 06592CCE58
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(6029001)(376002)(396003)(366004)(39860400002)(39380400002)(346002)(377424004)(189003)(199004)(52116002)(26005)(97736004)(316002)(25786009)(3660700001)(476003)(6506007)(386003)(1076002)(105586002)(3280700002)(2616005)(5660300001)(106356001)(10290500003)(446003)(2900100001)(186003)(6346003)(2906002)(478600001)(36756003)(6486002)(72206003)(68736007)(99286004)(2351001)(54906003)(76176011)(6512007)(22452003)(11346002)(102836004)(50226002)(575784001)(4326008)(86612001)(966005)(6306002)(486006)(6116002)(8656006)(5250100002)(7736002)(53936002)(6436002)(305945005)(6916009)(8676002)(39060400002)(14454004)(1730700003)(81156014)(81166006)(3846002)(5640700003)(8936002)(66066001)(107886003)(2501003)(10090500001)(22906009);DIR:OUT;SFP:1102;SCL:1;SRVR:DM5PR2101MB0918;H:DM5PR2101MB1016.namprd21.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: microsoft.com does not designate
 permitted sender hosts)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Ben.Peart@microsoft.com; 
x-microsoft-antispam-message-info: e3y+737LqPAlFlJU3AiURwl+O5GchnA9Rpu5/YPOngPrwTF6LknwSWs8hVCBT3diEYWDyt3kK3cNuAIOTetOWR56mB8Q8JxRzl5J68aJbMMUJnr0lrHhemMyklphCDvP70R4ndWUEVPP2Nct12Wb+/aMws4rDUtDDezgnbGeO1PaKIi/pqB766+pN0cn8qmt
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Office365-Filtering-Correlation-Id: a2b2caab-ec3e-40f0-8150-08d5af618b0b
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a2b2caab-ec3e-40f0-8150-08d5af618b0b
X-MS-Exchange-CrossTenant-originalarrivaltime: 01 May 2018 12:46:22.8212
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR2101MB0918
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Take advantage of the recent addition of support for lazy loading functions=
[1]
on Windows to simplify the loading of NtSetSystemInformation.

[1] db2f7c48cb (Win32: simplify loading of DLL functions, 2017-09-25)

Signed-off-by: Ben Peart <benpeart@microsoft.com>
---

Notes:
    Base Ref: master
    Web-Diff: https://github.com/benpeart/git/commit/3c9974548a
    Checkout: git fetch https://github.com/benpeart/git test-drop-caches-v2=
 && git checkout 3c9974548a
   =20
    ### Interdiff (v1..v2):
   =20
    diff --git a/t/helper/test-drop-caches.c b/t/helper/test-drop-caches.c
    index dd41da1a2c..d6bcfddf13 100644
    --- a/t/helper/test-drop-caches.c
    +++ b/t/helper/test-drop-caches.c
    @@ -1,8 +1,8 @@
     #include "test-tool.h"
     #include "git-compat-util.h"
    -#include "lazyload.h"
   =20
     #if defined(GIT_WINDOWS_NATIVE)
    +#include "lazyload.h"
   =20
     static int cmd_sync(void)
     {
    @@ -83,6 +83,7 @@ static int cmd_dropcaches(void)
     {
     	HANDLE hProcess =3D GetCurrentProcess();
     	HANDLE hToken;
    +	DECLARE_PROC_ADDR(ntdll.dll, DWORD, NtSetSystemInformation, INT, PVOI=
D, ULONG);
     	SYSTEM_MEMORY_LIST_COMMAND command;
     	int status;
   =20
    @@ -94,7 +95,6 @@ static int cmd_dropcaches(void)
   =20
     	CloseHandle(hToken);
   =20
    -	DECLARE_PROC_ADDR(ntdll.dll, DWORD, NtSetSystemInformation, INT, PVOI=
D, ULONG);
     	if (!INIT_PROC_ADDR(NtSetSystemInformation))
     		return error("Could not find NtSetSystemInformation() function");
   =20
    ### Patches

 t/helper/test-drop-caches.c | 16 ++++------------
 1 file changed, 4 insertions(+), 12 deletions(-)

diff --git a/t/helper/test-drop-caches.c b/t/helper/test-drop-caches.c
index 838760898b..d6bcfddf13 100644
--- a/t/helper/test-drop-caches.c
+++ b/t/helper/test-drop-caches.c
@@ -2,6 +2,7 @@
 #include "git-compat-util.h"
=20
 #if defined(GIT_WINDOWS_NATIVE)
+#include "lazyload.h"
=20
 static int cmd_sync(void)
 {
@@ -82,8 +83,7 @@ static int cmd_dropcaches(void)
 {
 	HANDLE hProcess =3D GetCurrentProcess();
 	HANDLE hToken;
-	HMODULE ntdll;
-	DWORD(WINAPI *NtSetSystemInformation)(INT, PVOID, ULONG);
+	DECLARE_PROC_ADDR(ntdll.dll, DWORD, NtSetSystemInformation, INT, PVOID, U=
LONG);
 	SYSTEM_MEMORY_LIST_COMMAND command;
 	int status;
=20
@@ -95,14 +95,8 @@ static int cmd_dropcaches(void)
=20
 	CloseHandle(hToken);
=20
-	ntdll =3D LoadLibrary("ntdll.dll");
-	if (!ntdll)
-		return error("Can't load ntdll.dll, wrong Windows version?");
-
-	NtSetSystemInformation =3D
-		(DWORD(WINAPI *)(INT, PVOID, ULONG))GetProcAddress(ntdll, "NtSetSystemIn=
formation");
-	if (!NtSetSystemInformation)
-		return error("Can't get function addresses, wrong Windows version?");
+	if (!INIT_PROC_ADDR(NtSetSystemInformation))
+		return error("Could not find NtSetSystemInformation() function");
=20
 	command =3D MemoryPurgeStandbyList;
 	status =3D NtSetSystemInformation(
@@ -115,8 +109,6 @@ static int cmd_dropcaches(void)
 	else if (status !=3D STATUS_SUCCESS)
 		error("Unable to execute the memory list command %d", status);
=20
-	FreeLibrary(ntdll);
-
 	return status;
 }
=20

base-commit: 1f1cddd558b54bb0ce19c8ace353fd07b758510d
--=20
2.17.0.windows.1

