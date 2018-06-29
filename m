Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI,T_DKIMWL_WL_HIGH shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 500A21F516
	for <e@80x24.org>; Fri, 29 Jun 2018 16:13:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S966925AbeF2QNV (ORCPT <rfc822;e@80x24.org>);
        Fri, 29 Jun 2018 12:13:21 -0400
Received: from mail-sn1nam01on0129.outbound.protection.outlook.com ([104.47.32.129]:34752
        "EHLO NAM01-SN1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S966877AbeF2QM5 (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 29 Jun 2018 12:12:57 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=rAo6miSmAs4mdjZE4scoaJOEvnpOakwYFm31eBc3R20=;
 b=e0X2U9kA7qoxxqZjsKDBypdIbUvmwApss1hsHBRs+4eygOjZgWItrlo7tG9PxissufCfGhprqXz82NYheCDr4BnFm0jcQIsfdj4czB/EatOoSlByWhRonEEgpVTYeNraBeUQCoTUNUgCa9JJL5k6rhs79D8M1dtF6iaUHITsuO4=
Received: from BL0PR2101MB1011.namprd21.prod.outlook.com (52.132.24.10) by
 BL0PR2101MB1044.namprd21.prod.outlook.com (52.132.24.14) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.930.2; Fri, 29 Jun 2018 16:12:54 +0000
Received: from BL0PR2101MB1011.namprd21.prod.outlook.com
 ([fe80::5072:9195:b05b:ed05]) by BL0PR2101MB1011.namprd21.prod.outlook.com
 ([fe80::5072:9195:b05b:ed05%2]) with mapi id 15.20.0930.012; Fri, 29 Jun 2018
 16:12:54 +0000
From:   Derrick Stolee <dstolee@microsoft.com>
To:     "git@vger.kernel.org" <git@vger.kernel.org>
CC:     "peff@peff.net" <peff@peff.net>,
        "sbeller@google.com" <sbeller@google.com>,
        "jnareb@gmail.com" <jnareb@gmail.com>,
        Derrick Stolee <dstolee@microsoft.com>
Subject: [RFC PATCH 07/13] test-reach
Thread-Topic: [RFC PATCH 07/13] test-reach
Thread-Index: AQHUD8QJnoSvF8/fKU2KNrQSwK9PxQ==
Date:   Fri, 29 Jun 2018 16:12:54 +0000
Message-ID: <20180629161223.229661-8-dstolee@microsoft.com>
References: <20180629161223.229661-1-dstolee@microsoft.com>
In-Reply-To: <20180629161223.229661-1-dstolee@microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: BN7PR06CA0026.namprd06.prod.outlook.com
 (2603:10b6:406:80::39) To BL0PR2101MB1011.namprd21.prod.outlook.com
 (2603:10b6:207:37::10)
x-ms-exchange-messagesentrepresentingtype: 1
x-originating-ip: [2001:4898:8010:0:eb4a:5dff:fe0f:730f]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;BL0PR2101MB1044;7:WnmUoijo2dFA7SqHDmdaYAhCY7hlAhIUlpEeCRaUexT1UClVQFcsbwhhaydUGcskNCSZ49p9u/MsrWDYopdrOobc5OZ9edrVmA/qZ0bzC2nuPObY4DR7Zq09mIvK9gMVraoOkXkR88xPGqjbldZ3nOw2569J6IPnpF4drSLL1bX5d/YRCq/njU37nslBVFY8nEv7BcGpxbDUby6c9rd1GupHVymfjOUtHlaqOQw/wo7U22Njwa/RT+mqqM6+B04o
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 808a8593-f9e0-4fe4-5878-08d5dddb2bd9
x-microsoft-antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989117)(48565401081)(5600033)(711020)(4534165)(4627221)(201703031133081)(201702281549075)(8990107)(2017052603328)(7193020);SRVR:BL0PR2101MB1044;
x-ms-traffictypediagnostic: BL0PR2101MB1044:
x-microsoft-antispam-prvs: <BL0PR2101MB1044E3239DF93D6367720105A14E0@BL0PR2101MB1044.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:;
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(8121501046)(5005006)(3002001)(93006095)(93001095)(3231270)(2018427008)(944501410)(52105095)(10201501046)(6055026)(149027)(150027)(6041310)(20161123558120)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123560045)(20161123562045)(20161123564045)(6072148)(201708071742011)(7699016);SRVR:BL0PR2101MB1044;BCL:0;PCL:0;RULEID:;SRVR:BL0PR2101MB1044;
x-forefront-prvs: 0718908305
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(396003)(136003)(376002)(366004)(39860400002)(346002)(189003)(199004)(305945005)(316002)(68736007)(36756003)(476003)(107886003)(97736004)(2900100001)(106356001)(46003)(105586002)(5640700003)(14454004)(5660300001)(6436002)(54906003)(4326008)(6916009)(39060400002)(86612001)(86362001)(6116002)(2351001)(486006)(99286004)(256004)(25786009)(478600001)(1730700003)(76176011)(1076002)(52116002)(11346002)(8936002)(10290500003)(53936002)(22452003)(2616005)(81166006)(81156014)(6346003)(186003)(386003)(8676002)(446003)(2501003)(10090500001)(2906002)(5250100002)(6512007)(102836004)(6506007)(6486002)(7736002)(217873001);DIR:OUT;SFP:1102;SCL:1;SRVR:BL0PR2101MB1044;H:BL0PR2101MB1011.namprd21.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: microsoft.com does not designate
 permitted sender hosts)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=dstolee@microsoft.com; 
x-microsoft-antispam-message-info: 5rPAcyKB+8oJeinBfHbc/TdgWY9nqKPYhr9Rmw2pGX6tg2j6pVCPPklVMupZKCU4Cz01F4c+uib98iBG1ZDmlwb3/vLCtK3D71lp+m4ZComht0TxSO1EkqoBpxhNyJqf54P8nXPZutJxnNLo+nS4q900avsw39KSrtkPAoZz0+mf+LKkQfEgfAZ3pldJnTxqmJEBqb0TfYd/9h153yM/H3SSIo1ZkMFc2tqZ7GERCp4JrY6oAYBfjvIriIYVuS9adkkIuFCOmcZIbFS9AI1Wm0M6sCjUyXrmEPo19tfaxRz2By24t2mXRSF4wpgKDIrTfHdcRF1LwGjKM4WQ8Nn+TZdkJSPb8JNhsjhnfOlSwbU=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 808a8593-f9e0-4fe4-5878-08d5dddb2bd9
X-MS-Exchange-CrossTenant-originalarrivaltime: 29 Jun 2018 16:12:54.8825
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL0PR2101MB1044
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

---
 Makefile              |   1 +
 t/helper/test-reach.c | 123 ++++++++++++++++++++++++++++++++++++++++++
 t/helper/test-tool.c  |   1 +
 t/helper/test-tool.h  |   1 +
 t/t6600-test-reach.sh |  81 ++++++++++++++++++++++++++++
 5 files changed, 207 insertions(+)
 create mode 100644 t/helper/test-reach.c
 create mode 100755 t/t6600-test-reach.sh

diff --git a/Makefile b/Makefile
index 89ad873ce0..c2a2c6457e 100644
--- a/Makefile
+++ b/Makefile
@@ -716,6 +716,7 @@ TEST_BUILTINS_OBJS +=3D test-mktemp.o
 TEST_BUILTINS_OBJS +=3D test-online-cpus.o
 TEST_BUILTINS_OBJS +=3D test-path-utils.o
 TEST_BUILTINS_OBJS +=3D test-prio-queue.o
+TEST_BUILTINS_OBJS +=3D test-reach.o
 TEST_BUILTINS_OBJS +=3D test-read-cache.o
 TEST_BUILTINS_OBJS +=3D test-ref-store.o
 TEST_BUILTINS_OBJS +=3D test-regex.o
diff --git a/t/helper/test-reach.c b/t/helper/test-reach.c
new file mode 100644
index 0000000000..d57660af45
--- /dev/null
+++ b/t/helper/test-reach.c
@@ -0,0 +1,123 @@
+#include "test-tool.h"
+#include "cache.h"
+#include "commit-reach.h"
+#include "config.h"
+#include "parse-options.h"
+#include "tag.h"
+
+int cmd__reach(int ac, const char **av)
+{
+	struct object_id oid_A, oid_B;
+	struct commit *A, *B;
+	struct commit **X, **Y;
+	int nr_X, alloc_X, nr_Y, alloc_Y;
+	struct commit_list *list_X, *list_Y;
+	struct strbuf buf =3D STRBUF_INIT;
+
+	setup_git_directory();
+	get_git_config(default_git_config, 0);
+
+	if (argc < 2)
+		exit(1);
+
+	/* load input data */
+	A =3D B =3D NULL;
+	list_X =3D list_Y =3D NULL;
+	nr_X =3D nr_Y =3D 0;
+	alloc_X =3D alloc_Y =3D 16;
+	ALLOC_ARRAY(X, alloc_X);
+	ALLOC_ARRAY(Y, alloc_Y);
+
+	while (strbuf_getline(&buf, stdin) !=3D EOF) {
+		struct object_id oid;
+		struct object *o;
+		struct commit *c;
+		if (buf.len < 3)
+			continue;
+
+		if (get_oid_committish(buf.buf + 2, &oid))
+			die("failed to resolve %s", buf.buf + 2);
+
+		o =3D parse_object(&oid);
+		o =3D deref_tag_noverify(o);
+
+		if (!o)
+			die("failed to load commit for input %s resulting in oid %s\n",
+			    buf.buf, oid_to_hex(&oid));
+
+		c =3D object_as_type(o, OBJ_COMMIT, 0);
+
+		if (!c)
+			die("failed to load commit for input %s resulting in oid %s\n",
+			    buf.buf, oid_to_hex(&oid));
+
+		switch (buf.buf[0]) {
+			case 'A':
+				oidcpy(&oid_A, &oid);
+				A =3D c;
+				break;
+
+			case 'B':
+				oidcpy(&oid_B, &oid);
+				B =3D c;
+				break;
+
+			case 'X':
+				ALLOC_GROW(X, nr_X + 1, alloc_X);
+				X[nr_X++] =3D c;
+				commit_list_insert(c, &list_X);
+				break;
+
+			case 'Y':
+				ALLOC_GROW(Y, nr_Y + 1, alloc_Y);
+				Y[nr_Y++] =3D c;
+				commit_list_insert(c, &list_Y);
+				break;
+
+			default:
+				die("unexpected start of line: %c", buf.buf[0]);
+		}
+	}
+	strbuf_release(&buf);
+
+	if (ac > 2 && !strcmp(av[2], "graph:off"))
+		core_commit_graph =3D 0;
+	if (ac > 2 && !strcmp(av[2], "graph:on"))
+		core_commit_graph =3D 1;
+
+	if (!strcmp(av[1], "ref_newer"))
+		printf("%s:%d\n", av[1], ref_newer(&oid_A, &oid_B));
+	else if (!strcmp(av[1], "in_merge_base"))
+		printf("%s:%d\n", av[1], in_merge_bases(A, B));
+	else if (!strcmp(av[1], "get_merge_bases_many")) {
+		struct commit_list *list =3D get_merge_bases_many(A, nr_X, X);
+		printf("%s(A,X):\n", av[1]);
+		while (list) {
+			printf("%s\n", oid_to_hex(&list->item->object.oid));
+			list =3D list->next;
+		}
+
+		list =3D get_merge_bases_many(B, nr_Y, Y);
+		printf("%s(B,Y):\n", av[1]);
+		while (list) {
+			printf("%s\n", oid_to_hex(&list->item->object.oid));
+			list =3D list->next;
+		}
+	} else if (!strcmp(av[1], "reduce_heads")) {
+		struct commit_list *list =3D reduce_heads(list_X);
+		printf("%s(X):\n", av[1]);
+		while (list) {
+			printf("%s\n", oid_to_hex(&list->item->object.oid));
+			list =3D list->next;
+		}
+
+		list =3D reduce_heads(list_Y);
+		printf("%s(Y):\n", av[1]);
+		while (list) {
+			printf("%s\n", oid_to_hex(&list->item->object.oid));
+			list =3D list->next;
+		}
+	}
+
+	exit(0);
+}
diff --git a/t/helper/test-tool.c b/t/helper/test-tool.c
index 805a45de9c..64d250b602 100644
--- a/t/helper/test-tool.c
+++ b/t/helper/test-tool.c
@@ -26,6 +26,7 @@ static struct test_cmd cmds[] =3D {
 	{ "online-cpus", cmd__online_cpus },
 	{ "path-utils", cmd__path_utils },
 	{ "prio-queue", cmd__prio_queue },
+	{ "reach", cmd__reach },
 	{ "read-cache", cmd__read_cache },
 	{ "ref-store", cmd__ref_store },
 	{ "regex", cmd__regex },
diff --git a/t/helper/test-tool.h b/t/helper/test-tool.h
index 7116ddfb94..0b1d3534b5 100644
--- a/t/helper/test-tool.h
+++ b/t/helper/test-tool.h
@@ -20,6 +20,7 @@ int cmd__mktemp(int argc, const char **argv);
 int cmd__online_cpus(int argc, const char **argv);
 int cmd__path_utils(int argc, const char **argv);
 int cmd__prio_queue(int argc, const char **argv);
+int cmd__reach(int argc, const char **argv);
 int cmd__read_cache(int argc, const char **argv);
 int cmd__ref_store(int argc, const char **argv);
 int cmd__regex(int argc, const char **argv);
diff --git a/t/t6600-test-reach.sh b/t/t6600-test-reach.sh
new file mode 100755
index 0000000000..c9337b6b46
--- /dev/null
+++ b/t/t6600-test-reach.sh
@@ -0,0 +1,81 @@
+#!/bin/sh
+
+test_description=3D'basic commit reachability tests'
+
+. ./test-lib.sh
+
+# Construct a grid-like commit graph with points (x,y)
+# with 1 <=3D x <=3D 10, 1 <=3D y <=3D 10, where (x,y) has
+# parents (x-1, y) and (x, y-1), keeping in mind that
+# we drop a parent if a coordinate is nonpositive.
+#
+#             (10,10)
+#            /       \
+#         (10,9)    (9,10)
+#        /     \   /      \
+#    (10,8)    (9,9)      (8,10)
+#   /     \    /   \      /    \
+#         ( continued...)
+#   \     /    \   /      \    /
+#    (3,1)     (2,2)      (1,3)
+#        \     /    \     /
+#         (2,1)      (2,1)
+#              \    /
+#              (1,1)
+#
+# We use branch 'comit-x-y' to refer to (x,y).
+# This grid allows interesting reachability and
+# non-reachability queries: (x,y) can reach (x',y')
+# if and only if x' <=3D x and y' <=3D y.
+test_expect_success 'setup' '
+	for i in $(test_seq 1 10)
+	do
+		test_commit "1-$i" &&
+		git branch -f commit-1-$i
+	done &&
+	for j in $(test_seq 1 9)
+	do
+		git reset --hard commit-$j-1 &&
+		x=3D$(($j + 1)) &&
+		test_commit "$x-1" &&
+		git branch -f commit-$x-1 &&
+
+		for i in $(test_seq 2 10)
+		do
+			git merge commit-$j-$i -m "$x-$i" &&
+			git branch -f commit-$x-$i
+		done
+	done &&
+	git commit-graph write --reachable
+'
+
+test_reach_two_modes() {
+	test-tool reach $1 graph:off <input >output &&
+	test_cmp output expect &&
+	test-tool reach $1 graph:on <input >output &&
+	test_cmp output expect
+}
+
+test_expect_success 'ref_newer:miss' '
+	cat >input <<- EOF &&
+	A:commit-5-7
+	B:commit-4-9
+	EOF
+	cat >expect <<- EOF &&
+	ref_newer:0
+	EOF
+	test_reach_two_modes "ref_newer"
+'
+
+test_expect_success 'ref_newer:miss' '
+	cat >input <<- EOF &&
+	A:commit-5-7
+	B:commit-2-3
+	EOF
+	cat >expect <<- EOF &&
+	ref_newer:1
+	EOF
+	test_reach_two_modes "ref_newer"
+'
+
+test_done
--=20
2.18.0.118.gd4f65b8d14

