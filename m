Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.1 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 51A7E2013E
	for <e@80x24.org>; Fri,  3 Mar 2017 02:07:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751984AbdCCCHL (ORCPT <rfc822;e@80x24.org>);
        Thu, 2 Mar 2017 21:07:11 -0500
Received: from mout.gmx.net ([212.227.15.19]:51973 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751685AbdCCCFu (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 2 Mar 2017 21:05:50 -0500
Received: from virtualbox ([89.204.153.4]) by mail.gmx.com (mrgmx003
 [212.227.17.190]) with ESMTPSA (Nemesis) id 0M2LZc-1cSue11iTM-00s9oa; Fri, 03
 Mar 2017 03:04:37 +0100
Date:   Fri, 3 Mar 2017 03:04:36 +0100 (CET)
From:   Johannes Schindelin <johannes.schindelin@gmx.de>
X-X-Sender: virtualbox@virtualbox
To:     git@vger.kernel.org
cc:     Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>,
        Duy Nguyen <pclouds@gmail.com>
Subject: [PATCH v2 9/9] Test read_early_config()
In-Reply-To: <cover.1488506615.git.johannes.schindelin@gmx.de>
Message-ID: <f27a753830b8fb61a5276ce1d8eeba04ae4dbbfd.1488506615.git.johannes.schindelin@gmx.de>
References: <cover.1481211338.git.johannes.schindelin@gmx.de> <cover.1488506615.git.johannes.schindelin@gmx.de>
User-Agent: Alpine 2.20 (DEB 67 2015-01-07)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K0:UZ1xV11yRWb+0fqGejJS7JbzD8iXwoPib2UzZ4HJSCO73FY0qlp
 WyXc4VLQtPQIYtdzPBEUsxlB8aR9EG9HkGFAqqsbGqwShUthsJAdyiS/JjpB1jQc58tkLQs
 i9yi8lfDdRb+Jj/+D1i2+h6Mm0Qu1QyJimdQYhuuUpXOH23eqpb1zrxOeKrSbSeiK0hNrQf
 +tEzO3OZfq4HEs81M2D+A==
X-UI-Out-Filterresults: notjunk:1;V01:K0:ArXRRWvziS0=:CMhQ/6EQDOWgWiTvEdeUF5
 aqafAYtQiR8ddDFMg63dFrAAHwBUOHyFFR/ZpYyvRi/B5TjgxHlWyA4HNLc3cdL1XcgfaviRt
 rR8Ga/DVHf0mpWmSrUmbQbz58gYa6FkMlObDprJ4J/7w2rKdwpNVT+ANK57hNlrzobouEHbl5
 NhaiRVq3xbjWzMb0RoWjZ5RmAuLTMmx4+PWUnpkUqpjyYSjH28RuQrd4oZLZnqZuRl0ISwWtA
 RJ09WYD4x/Hr2js5zjmFFRfeaW3sbIeb5cVI8T6CHB940uFLxlE+RKlJsR0CH4LCHSeBwFIyi
 CVqHOFC6BAVslejVKnJtgEeu2foRFkzOcc+cwP72G69GRwr+I4u7LKQOrlLuUs/qAO0/vcXOE
 yXvKXlaYAICuCPhz0TkM/IxC973tRoO/6plLeD0erlDxwSkANsS9ORh5xE3bh0D8d6w7j+JkO
 Gvwz87qSE6swanScfWr+9z9MGThj+VKZ06aRaFQesl8p7XulcWknjI2TqAatb9mKxy/v29rp9
 wiXZDlcc0YC2wzSpmTLv5AzdzCNyiUhM8c8jZqB66kWNkKPtLmtT54y96imRQpQHFAP3PlNvZ
 WlUrfbp4kxJ/hn6UJcp4K8wWtWBNfVYQbWkR9+FM2LyfVUCdXmKPYhaHm5bYTSSOTn9m8f96C
 dI98hOWB8I9mX2MeCkeUqMMIdbB5mMz78Y59C+FVehcOD6GGUCdi4n1e3FOZhjYid5r4KZM0v
 vII2pRo13VMlBCRnHK2plDRg5W6aS6UQ2Vxpgk8Mv0fmwjohN3sfRGzIAFJ1+Eaydgc0AREXo
 JAftuIJ
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

So far, we had no explicit tests of that function.

Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
---
 t/helper/test-config.c  | 15 +++++++++++++++
 t/t1309-early-config.sh | 50 +++++++++++++++++++++++++++++++++++++++++++++++++
 2 files changed, 65 insertions(+)
 create mode 100755 t/t1309-early-config.sh

diff --git a/t/helper/test-config.c b/t/helper/test-config.c
index 83a4f2ab869..8e3ed6a76cb 100644
--- a/t/helper/test-config.c
+++ b/t/helper/test-config.c
@@ -66,6 +66,16 @@ static int iterate_cb(const char *var, const char *value, void *data)
 	return 0;
 }
 
+static int early_config_cb(const char *var, const char *value, void *vdata)
+{
+	const char *key = vdata;
+
+	if (!strcmp(key, var))
+		printf("%s\n", value);
+
+	return 0;
+}
+
 int cmd_main(int argc, const char **argv)
 {
 	int i, val;
@@ -73,6 +83,11 @@ int cmd_main(int argc, const char **argv)
 	const struct string_list *strptr;
 	struct config_set cs;
 
+	if (argc == 3 && !strcmp(argv[1], "read_early_config")) {
+		read_early_config(early_config_cb, (void *)argv[2]);
+		return 0;
+	}
+
 	setup_git_directory();
 
 	git_configset_init(&cs);
diff --git a/t/t1309-early-config.sh b/t/t1309-early-config.sh
new file mode 100755
index 00000000000..0c55dee514c
--- /dev/null
+++ b/t/t1309-early-config.sh
@@ -0,0 +1,50 @@
+#!/bin/sh
+
+test_description='Test read_early_config()'
+
+. ./test-lib.sh
+
+test_expect_success 'read early config' '
+	test_config early.config correct &&
+	test-config read_early_config early.config >output &&
+	test correct = "$(cat output)"
+'
+
+test_expect_success 'in a sub-directory' '
+	test_config early.config sub &&
+	mkdir -p sub &&
+	(
+		cd sub &&
+		test-config read_early_config early.config
+	) >output &&
+	test sub = "$(cat output)"
+'
+
+test_expect_success 'ceiling' '
+	test_config early.config ceiling &&
+	mkdir -p sub &&
+	(
+		GIT_CEILING_DIRECTORIES="$PWD" &&
+		export GIT_CEILING_DIRECTORIES &&
+		cd sub &&
+		test-config read_early_config early.config
+	) >output &&
+	test -z "$(cat output)"
+'
+
+test_expect_success 'ceiling #2' '
+	mkdir -p xdg/git &&
+	git config -f xdg/git/config early.config xdg &&
+	test_config early.config ceiling &&
+	mkdir -p sub &&
+	(
+		XDG_CONFIG_HOME="$PWD"/xdg &&
+		GIT_CEILING_DIRECTORIES="$PWD" &&
+		export GIT_CEILING_DIRECTORIES XDG_CONFIG_HOME &&
+		cd sub &&
+		test-config read_early_config early.config
+	) >output &&
+	test xdg = "$(cat output)"
+'
+
+test_done
-- 
2.12.0.windows.1.3.g8a117c48243
