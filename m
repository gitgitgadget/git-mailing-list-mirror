Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI,T_DKIMWL_WL_HIGH shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id C24341F42B
	for <e@80x24.org>; Fri, 14 Sep 2018 14:37:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728102AbeINTwb (ORCPT <rfc822;e@80x24.org>);
        Fri, 14 Sep 2018 15:52:31 -0400
Received: from mail-by2nam03on0100.outbound.protection.outlook.com ([104.47.42.100]:51842
        "EHLO NAM03-BY2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727676AbeINTwa (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 14 Sep 2018 15:52:30 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=UqSv4pnwVCMnfhJ0sWXwfNavlHt+Z2pmblIZhQSMUk0=;
 b=i/lME44LNrTy7c40fwc8Gm2CIxJVh0NlaaIrU+DO9PBSWK7nhNURAR5pJIZNpdnSn7fv0CnT+qbVydkydudRRTsvsR5+mf3Ss+9tNBZJwY79WHfOBqN/MIMNjSsxAP1jILqBXMMpreM+fN8ucWSvP00yHtuqr28pr4oLLlKUpHo=
Received: from MW2PR2101MB0970.namprd21.prod.outlook.com (52.132.146.19) by
 MW2PR2101MB0972.namprd21.prod.outlook.com (52.132.146.21) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1164.5; Fri, 14 Sep 2018 14:37:27 +0000
Received: from MW2PR2101MB0970.namprd21.prod.outlook.com
 ([fe80::3c7b:f2aa:d871:8ae7]) by MW2PR2101MB0970.namprd21.prod.outlook.com
 ([fe80::3c7b:f2aa:d871:8ae7%2]) with mapi id 15.20.1164.008; Fri, 14 Sep 2018
 14:37:27 +0000
From:   Ben Peart <benpeart@microsoft.com>
To:     "git@vger.kernel.org" <git@vger.kernel.org>
CC:     "gitster@pobox.com" <gitster@pobox.com>,
        "t.gummerer@gmail.com" <t.gummerer@gmail.com>,
        "avarab@gmail.com" <avarab@gmail.com>,
        Ben Peart <Ben.Peart@microsoft.com>,
        Ben Peart <Ben.Peart@microsoft.com>
Subject: [PATCH v1 2/4] fsmonitor: update GIT_TEST_FSMONITOR support
Thread-Topic: [PATCH v1 2/4] fsmonitor: update GIT_TEST_FSMONITOR support
Thread-Index: AQHUTDh1CxdAAq1L6E+Cf0697YGGGA==
Date:   Fri, 14 Sep 2018 14:37:27 +0000
Message-ID: <20180914143708.63024-3-benpeart@microsoft.com>
References: <20180914143708.63024-1-benpeart@microsoft.com>
In-Reply-To: <20180914143708.63024-1-benpeart@microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [70.33.148.227]
x-mailer: git-send-email 2.18.0.windows.1
x-clientproxiedby: CY4PR12CA0037.namprd12.prod.outlook.com
 (2603:10b6:903:129::23) To MW2PR2101MB0970.namprd21.prod.outlook.com
 (2603:10b6:302:4::19)
x-ms-exchange-messagesentrepresentingtype: 1
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;MW2PR2101MB0972;6:Fsiq4PCsU5tPcPGPJJxpHWzC1STZOJMZwZPByoAGgKhLSjozmO1B/3dH36B3JbvQWaDA7neteOTcThfofhEcBkADCSrG1nsmWNw4pAQLiICydj/iCMlfAkZM3IspnLBIG92Tg+fdv72z2pJjfRM6V/6LffowoRFLtVdjxlAiwWWqe9MOgUzOIUKvdDmg6oCvlNSUoEWmaUjKTWZHGPWaaNwDttp8SsZruR2OA9mxR34RjRl4+qqXRWw5samVAGCmArntvcyLCyDuzI5jHkXO8feA00HUdAxC3Enufrr0qHFyytHTpOHETUwxKIWhnR77hsz28tl0ebYJk+61rJ3/h2XReR+l/Kj3tY96KzlgplZbpP8xt0/IeA+/subw7FFm3i/oHkYZqQhB7yHQJgJVLEPKEEvD2PxzRigVXweFkxMPMN8+n3gQSaGjKJU2Z4ad3coBh3NhSk03oS4fagVkHg==;5:zgv8a/fvXhD0GNdfVxBP2ZMIYNlL2IpY34nfCPNgMgeg9BLrt9gFl1uTs6PHRSNvVDKHjAYsFsFjDjbiLrO7mc799Ws/X+t0uxbgfyQpFQRkgroXHMFI4PqcL9rsF30+CuTpDKi+/CbttDR56BYKJo2pZhfX+KQ2zQfgy2uMwSs=;7:ibGcOaDXTPMxmtItDNT+L/cCf7hkUenRhQrxPqhg/LgaAQdymdMZqZmqvNLYjEtIHZ9vUUioTSIfp6IXG3JFncln3laeArBrPu0B8KNVzrg/NgZHSe+EuWRTacn5UVqAHB0Hea9blSjl+YzyqZsIsbkCAnkgPchzl0+mSSOXDGH9rAyH5031xHObuK5QGK31a6ttZGy5LDgkWgqkqgg42N+KhiWM2iGger8J2mWm+86ENoJOMKkIhHcy4v+5PA2M
x-ms-office365-filtering-correlation-id: 29da5ebf-f7fd-4567-493b-08d61a4f97b1
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989137)(4534165)(4627221)(201703031133081)(201702281549075)(8990107)(5600074)(711020)(4618075)(2017052603328)(7193020);SRVR:MW2PR2101MB0972;
x-ms-traffictypediagnostic: MW2PR2101MB0972:
x-microsoft-antispam-prvs: <MW2PR2101MB0972E048CB5C44A30FF839E9F4190@MW2PR2101MB0972.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(28532068793085)(89211679590171);
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(8121501046)(5005006)(93006095)(93001095)(3002001)(3231344)(944501410)(52105095)(2018427008)(10201501046)(6055026)(149027)(150027)(6041310)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123560045)(20161123564045)(20161123562045)(20161123558120)(201708071742011)(7699050)(76991041);SRVR:MW2PR2101MB0972;BCL:0;PCL:0;RULEID:;SRVR:MW2PR2101MB0972;
x-forefront-prvs: 07954CC105
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(39860400002)(366004)(136003)(396003)(346002)(376002)(199004)(189003)(486006)(6346003)(3846002)(386003)(22452003)(6506007)(6436002)(26005)(186003)(53936002)(2900100001)(2616005)(446003)(11346002)(5640700003)(5250100002)(6116002)(476003)(14454004)(76176011)(316002)(25786009)(54906003)(6486002)(10090500001)(36756003)(2501003)(99286004)(1076002)(6512007)(102836004)(97736004)(14444005)(52116002)(68736007)(66066001)(2351001)(106356001)(39060400002)(256004)(50226002)(8936002)(10290500003)(81166006)(81156014)(1730700003)(8676002)(107886003)(5660300001)(72206003)(478600001)(305945005)(6916009)(15650500001)(7736002)(2906002)(86612001)(575784001)(4326008)(105586002);DIR:OUT;SFP:1102;SCL:1;SRVR:MW2PR2101MB0972;H:MW2PR2101MB0970.namprd21.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: microsoft.com does not designate
 permitted sender hosts)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Ben.Peart@microsoft.com; 
x-microsoft-antispam-message-info: x/HMchpMuzG8hthtbZOA2QxgTqOC+6KrE9bveDRBvPCmvaKUtC04gS1XK+xNoKXZYk7B+x8o9LhDWme+QzXbfHXpmz5PKP11VDlzXXZBxWNk+T4iiOFCDpxc6vn4Tgys43Z9bKGpWZEi/jjY6t5flt/F1x4341dmrogcgloYk3+6vokqvZCxjcLPQlALQg/6Fyz4N+7Hmvl9mAg87etQBwi6gv4nByUxDJ/DbXIMdrCwBOs5ykMSoD3/hbdwfTVLfob3AZ9iTA0MyTycf3dWfTph9g40ICVGsTEAsp3nnTKvN6O6a/hHRrekYgW+3ihzMbmGsU6/doQSSxQj0rgYO4bECJOZ80QLp//IxHg6w3c=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 29da5ebf-f7fd-4567-493b-08d61a4f97b1
X-MS-Exchange-CrossTenant-originalarrivaltime: 14 Sep 2018 14:37:27.2501
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW2PR2101MB0972
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Rename GIT_FSMONITOR_TEST to GIT_TEST_FSMONITOR for consistency with the
other GIT_TEST_ special setups and properly document its use.

Add logic in t/test-lib.sh to give an error when the old variable is set to
let people know they need to update their environment to use the new
variable. If the new variable is also set, just give a warning so they can
eventually remove the old variable.

Signed-off-by: Ben Peart <Ben.Peart@microsoft.com>
---
 config.c                    |  2 +-
 t/README                    |  4 ++++
 t/t1700-split-index.sh      |  2 +-
 t/t7519-status-fsmonitor.sh |  2 +-
 t/test-lib.sh               | 11 +++++++++++
 5 files changed, 18 insertions(+), 3 deletions(-)

diff --git a/config.c b/config.c
index 3461993f0a..3555c63f28 100644
--- a/config.c
+++ b/config.c
@@ -2278,7 +2278,7 @@ int git_config_get_max_percent_split_change(void)
 int git_config_get_fsmonitor(void)
 {
 	if (git_config_get_pathname("core.fsmonitor", &core_fsmonitor))
-		core_fsmonitor =3D getenv("GIT_FSMONITOR_TEST");
+		core_fsmonitor =3D getenv("GIT_TEST_FSMONITOR");
=20
 	if (core_fsmonitor && !*core_fsmonitor)
 		core_fsmonitor =3D NULL;
diff --git a/t/README b/t/README
index 56a417439c..47165f7eab 100644
--- a/t/README
+++ b/t/README
@@ -319,6 +319,10 @@ GIT_TEST_OE_DELTA_SIZE=3D<n> exercises the uncommon pa=
ck-objects code
 path where deltas larger than this limit require extra memory
 allocation for bookkeeping.
=20
+GIT_TEST_FSMONITOR=3D$PWD/t7519/fsmonitor-all exercises the fsmonitor
+code path for utilizing a file system monitor to speed up detecting
+new or changed files.
+
 Naming Tests
 ------------
=20
diff --git a/t/t1700-split-index.sh b/t/t1700-split-index.sh
index b3b4d83eaf..f6a856f24c 100755
--- a/t/t1700-split-index.sh
+++ b/t/t1700-split-index.sh
@@ -6,7 +6,7 @@ test_description=3D'split index mode tests'
=20
 # We need total control of index splitting here
 sane_unset GIT_TEST_SPLIT_INDEX
-sane_unset GIT_FSMONITOR_TEST
+sane_unset GIT_TEST_FSMONITOR
=20
 test_expect_success 'enable split index' '
 	git config splitIndex.maxPercentChange 100 &&
diff --git a/t/t7519-status-fsmonitor.sh b/t/t7519-status-fsmonitor.sh
index 756beb0d8e..d77012ea6d 100755
--- a/t/t7519-status-fsmonitor.sh
+++ b/t/t7519-status-fsmonitor.sh
@@ -8,7 +8,7 @@ test_description=3D'git status with file system watcher'
 # To run the entire git test suite using fsmonitor:
 #
 # copy t/t7519/fsmonitor-all to a location in your path and then set
-# GIT_FSMONITOR_TEST=3Dfsmonitor-all and run your tests.
+# GIT_TEST_FSMONITOR=3Dfsmonitor-all and run your tests.
 #
=20
 # Note, after "git reset --hard HEAD" no extensions exist other than 'TREE=
'
diff --git a/t/test-lib.sh b/t/test-lib.sh
index 44288cbb59..0ef111d808 100644
--- a/t/test-lib.sh
+++ b/t/test-lib.sh
@@ -140,6 +140,17 @@ then
 	export GIT_INDEX_VERSION
 fi
=20
+if test -n "$GIT_FSMONITOR_TEST"
+then
+	if test -n "$GIT_TEST_FSMONITOR"
+	then
+		echo "warning: the GIT_FSMONITOR_TEST variable has been renamed to GIT_T=
EST_FSMONITOR"
+	else
+		echo "error: the GIT_FSMONITOR_TEST variable has been renamed to GIT_TES=
T_FSMONITOR"
+		exit 1
+	fi
+fi
+
 # Add libc MALLOC and MALLOC_PERTURB test
 # only if we are not executing the test with valgrind
 if expr " $GIT_TEST_OPTS " : ".* --valgrind " >/dev/null ||
--=20
2.18.0.windows.1

