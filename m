Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.4 required=3.0 tests=AWL,BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 354471F453
	for <e@80x24.org>; Tue, 18 Sep 2018 23:29:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730537AbeISFEj (ORCPT <rfc822;e@80x24.org>);
        Wed, 19 Sep 2018 01:04:39 -0400
Received: from mail-by2nam03on0128.outbound.protection.outlook.com ([104.47.42.128]:52352
        "EHLO NAM03-BY2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1730438AbeISFEj (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 19 Sep 2018 01:04:39 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=pBPv0x7qpFIjCywICJvI2lmeTtqGYm7nMVlfVZVAxI0=;
 b=U+WGVXiFj8wgJN2bIZ4HidiMuJRP3q0kF2ozVNEifpSxJx7lU7ax1oHXYmSuyc+M0Np6lFZvcdWKiXVse+Bo93bemLCz2e3wT+fEtabXG2+WmdIZ3Le7eJYKY5fal80G9RvRBbUbreeHQcRDmmcIdBRuffYlIUbAvHgjyLKKtfw=
Received: from BL0PR2101MB0962.namprd21.prod.outlook.com (52.132.20.155) by
 BL0PR2101MB0994.namprd21.prod.outlook.com (52.132.23.156) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384_P256) id
 15.20.1185.6; Tue, 18 Sep 2018 23:29:36 +0000
Received: from BL0PR2101MB0962.namprd21.prod.outlook.com
 ([fe80::f0b9:d24f:2522:d7be]) by BL0PR2101MB0962.namprd21.prod.outlook.com
 ([fe80::f0b9:d24f:2522:d7be%2]) with mapi id 15.20.1185.006; Tue, 18 Sep 2018
 23:29:36 +0000
From:   Ben Peart <benpeart@microsoft.com>
To:     "git@vger.kernel.org" <git@vger.kernel.org>
CC:     "gitster@pobox.com" <gitster@pobox.com>,
        "jrnieder@gmail.com" <jrnieder@gmail.com>,
        Ben Peart <Ben.Peart@microsoft.com>,
        Ben Peart <Ben.Peart@microsoft.com>
Subject: [PATCH v3 3/5] fsmonitor: update GIT_TEST_FSMONITOR support
Thread-Topic: [PATCH v3 3/5] fsmonitor: update GIT_TEST_FSMONITOR support
Thread-Index: AQHUT6d17ird1dTN6UyrvxGPAtD0Ow==
Date:   Tue, 18 Sep 2018 23:29:35 +0000
Message-ID: <20180918232916.57736-4-benpeart@microsoft.com>
References: <20180914143708.63024-1-benpeart@microsoft.com>
 <20180918232916.57736-1-benpeart@microsoft.com>
In-Reply-To: <20180918232916.57736-1-benpeart@microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [70.33.148.227]
x-mailer: git-send-email 2.18.0.windows.1
x-clientproxiedby: BN6PR19CA0107.namprd19.prod.outlook.com
 (2603:10b6:404:a0::21) To BL0PR2101MB0962.namprd21.prod.outlook.com
 (2603:10b6:207:30::27)
x-ms-exchange-messagesentrepresentingtype: 1
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;BL0PR2101MB0994;6:lKGkhVY8MkBYvo3RqK4H++mm7OCBMs2GY0dsv+EW3aVx3tYnYdGtxru5IiMVl4rXUS8gcL4e8KVRjXq+KZmi/YISBBf33/18yAKlvxcwTlninmBRbf44qEpg9f44NWWzCLgzG1E/w8sVxDNlMSzs0ieAUMIA1DZhsjxBTzNJHMLs29iv+GXBhBnNEpy2Q3J33H/+pu+vlTsPZP17/PcqiXtpRrLjqjJnqsLvfyVrfsIS7ApzNUZKCAA49J8ClmSgmvX6bZ7D9SMYZQgycVw6Nzzme2jf0aQjUhxM41+gPTME8ZkDNy+WUW/XrqeRsKWcLsBq6grhWJV+wJg+A8Y8D+JZbo4JEc4EqysbB9ygQntovfzaanpzNQ30rQ/VlLpYFYP9LoMo3M/CfQDi1ns4HKHY+ld1NYHKcZMEDlozK98NfEPj0ODUwa0hj7XRjjzUd0ZgDBgi9eax+2Ox/bxCkA==;5:1jKTfHijkO/oA+rNlMC106bmutgjCLGibUBEUgU5MRdE01ijKBAaC3PtzpgOAmaWZ4YilUgtPAbjaLt+l59go7siQzQadPHdR5XG95gwruKtjog5k1/NSPp31a9H71CxawjszgQoPG0mWWOnjfbLayW8Z0bWVf95iNt7f3/gfjw=;7:4HMgkIidURoDCLNcD5u06j7yeuKUWjhzwMUiqqMgSKu3CscThzUbm7S8edKTxnyCaJnzFK/IgFHPrR26nMUGdk7w1AmgWqCVJ1yk2vyw42goBW3balYtdZw0tAQr4J7SKnKBDcSMfkDDDE1iQjKFtmX1Wee0gU8ZX89UtjIfJUxlqzuQIDWvttdUgDkqXEQcH3g0hjamfepM+lnqxBRWWTH0I0jCHtYLHTwTygm60+y7F5m87ASuBzevqoVthtiM
x-ms-office365-filtering-correlation-id: e271539b-839b-4b1a-bd87-08d61dbe980b
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989299)(4534165)(4627221)(201703031133081)(201702281549075)(8990200)(5600074)(711020)(4618075)(2017052603328)(7193020);SRVR:BL0PR2101MB0994;
x-ms-traffictypediagnostic: BL0PR2101MB0994:
x-microsoft-antispam-prvs: <BL0PR2101MB0994DB43F805D3736D81D0C6F41D0@BL0PR2101MB0994.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(28532068793085)(89211679590171);
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(5005006)(8121501046)(3002001)(10201501046)(3231355)(944501410)(52105095)(2018427008)(93006095)(93001095)(6055026)(149027)(150027)(6041310)(20161123558120)(20161123562045)(20161123564045)(20161123560045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(201708071742011)(7699050)(76991041);SRVR:BL0PR2101MB0994;BCL:0;PCL:0;RULEID:;SRVR:BL0PR2101MB0994;
x-forefront-prvs: 0799B1B2D7
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(346002)(396003)(376002)(366004)(136003)(39860400002)(199004)(189003)(54906003)(14444005)(68736007)(2616005)(2906002)(86612001)(5640700003)(476003)(11346002)(256004)(6506007)(386003)(102836004)(8676002)(3846002)(6512007)(50226002)(36756003)(6116002)(446003)(316002)(486006)(575784001)(6916009)(1076002)(2900100001)(8936002)(66066001)(10290500003)(5660300001)(81156014)(478600001)(1730700003)(72206003)(186003)(14454004)(99286004)(26005)(105586002)(15650500001)(52116002)(53936002)(2351001)(4326008)(81166006)(6486002)(2501003)(97736004)(107886003)(22452003)(76176011)(106356001)(5250100002)(6346003)(39060400002)(10090500001)(6436002)(305945005)(25786009)(7736002);DIR:OUT;SFP:1102;SCL:1;SRVR:BL0PR2101MB0994;H:BL0PR2101MB0962.namprd21.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: microsoft.com does not designate
 permitted sender hosts)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Ben.Peart@microsoft.com; 
x-microsoft-antispam-message-info: 3ODwoA/CPa8uNtf43MaEmjnYzE9ZhLGLOPRIbTmBUBURBxiCw8xxsA4b4/zPydfSPYlmlJLyg4Y2dQn1r7CUDAW+KEyA07i4lKH27h3f/zRUs0qN0N3WO3snFvCCrE8gJPZ6YCJCc7AVIX77PUH4A6WOmJfy/7iif8SvEbsKh3TWUCK2eQo3kmei8hTnUuoHCsXDS8H8UX4mOCmQAercybusyufH6B2uLGvlVwjqoVyDn+JlgotyyQyWfk302ScNhQb6UokgNVuyyoDXDLeOVMs4BcYwXUz7jyPp1iQ54Wsas1YBMfu6NIrAzXBJRjFNUmKdF7MQco8GZ8qzAUML6WumxPTzPHua9xIYtW7B8og=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e271539b-839b-4b1a-bd87-08d61dbe980b
X-MS-Exchange-CrossTenant-originalarrivaltime: 18 Sep 2018 23:29:35.4995
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL0PR2101MB0994
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Rename GIT_FSMONITOR_TEST to GIT_TEST_FSMONITOR for consistency with the
other GIT_TEST_ special setups and properly document its use.

Add logic in t/test-lib.sh to give a warning when the old variable is set t=
o
let people know they need to update their environment to use the new
variable.

Signed-off-by: Ben Peart <Ben.Peart@microsoft.com>
---
 config.c                    |  2 +-
 t/README                    |  4 ++++
 t/t1700-split-index.sh      |  2 +-
 t/t7519-status-fsmonitor.sh |  2 +-
 t/test-lib.sh               | 20 ++++++++++++++++++++
 5 files changed, 27 insertions(+), 3 deletions(-)

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
index 44288cbb59..653688c067 100644
--- a/t/test-lib.sh
+++ b/t/test-lib.sh
@@ -140,6 +140,26 @@ then
 	export GIT_INDEX_VERSION
 fi
=20
+check_var_migration () {
+	old_name=3D$1 new_name=3D$2
+	eval "old_isset=3D\${${old_name}:+isset}"
+	eval "new_isset=3D\${${new_name}:+isset}"
+	case "$old_isset,$new_isset" in
+	isset,)
+		echo >&2 "warning: $old_name is now $new_name"
+		echo >&2 "hint: set $new_name too during the transition period"
+		eval "$new_name=3D\$$old_name"
+		;;
+	isset,isset)
+		# do this later
+		# echo >&2 "warning: $old_name is now $new_name"
+		# echo >&2 "hint: remove $old_name"
+		;;
+	esac
+}
+
+check_var_migration GIT_FSMONITOR_TEST GIT_TEST_FSMONITOR
+
 # Add libc MALLOC and MALLOC_PERTURB test
 # only if we are not executing the test with valgrind
 if expr " $GIT_TEST_OPTS " : ".* --valgrind " >/dev/null ||
--=20
2.18.0.windows.1

