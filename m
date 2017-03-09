Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.2 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id E0AD2202F8
	for <e@80x24.org>; Thu,  9 Mar 2017 22:25:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753038AbdCIWZb (ORCPT <rfc822;e@80x24.org>);
        Thu, 9 Mar 2017 17:25:31 -0500
Received: from mout.gmx.net ([212.227.17.21]:64746 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752799AbdCIWZa (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 9 Mar 2017 17:25:30 -0500
Received: from virtualbox ([37.201.193.18]) by mail.gmx.com (mrgmx103
 [212.227.17.168]) with ESMTPSA (Nemesis) id 0M4GND-1bvNJo1OpH-00rp9S; Thu, 09
 Mar 2017 23:25:23 +0100
Date:   Thu, 9 Mar 2017 23:25:06 +0100 (CET)
From:   Johannes Schindelin <johannes.schindelin@gmx.de>
X-X-Sender: virtualbox@virtualbox
To:     git@vger.kernel.org
cc:     Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>,
        Duy Nguyen <pclouds@gmail.com>,
        Brandon Williams <bmwill@google.com>
Subject: [PATCH v5 09/11] Test read_early_config()
In-Reply-To: <cover.1489098170.git.johannes.schindelin@gmx.de>
Message-ID: <72b36d27cefc0060f170b33f19cf504bb0338c1c.1489098170.git.johannes.schindelin@gmx.de>
References: <cover.1488897111.git.johannes.schindelin@gmx.de> <cover.1489098170.git.johannes.schindelin@gmx.de>
User-Agent: Alpine 2.20 (DEB 67 2015-01-07)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K0:8c/YkPkufWJWb2xtoZf6R/cMrrJO1CKb/1UMNwmwiqF/QWM+H+Z
 gygwL4nEg7OCmQZ3WN0srFYGgLvh+k3msIeE7PUSFe+2hn6nj5072TJyZuUefB3VDe39QC+
 6s1oAPt3dKIyNhGoa6b82pfzOdIAudoI8n+9zgiISLjoelKk4g5KtSjgbvz/KAOSF1wwxGR
 riodqZEEHIDDzrRR44mMQ==
X-UI-Out-Filterresults: notjunk:1;V01:K0:PEtjjhXmdT8=:xYPsMc21QDPDIuREIN2UDv
 KTmlzBoleyN2a4C5QWJ0WCD+Uq0PNelpcsnox2eqAyXRkNi3SyKVlyi/yGPxwjJX7uBF0pzUv
 ep7FfXNFCSDGEl3BZ0TTAn/W6KAM2kNW+sROB6S0yghbHuy6uB29hglgckVE82YSt1HgGC5wk
 SbCxaMyNooutQZZ7WUfoJbR8y1rh6LfQhAL2tFwgK/0meym00Z+gLzdYHaDTXn9YOT92FcQlC
 x71wCotzhQXQ1Tc6FnTyJBwl5wcKm9mjnLImHjgWIdj9ka9oLnFxluV8GMz+RkNK8QQHa0R9s
 K8mX/blTFxeBL0ZRXT9mdr8cKN/9WwNn5DyqLuhjZVBgeTaoSaS2TY4Vyonw0IFnczWFBJ7we
 f4ouGyh+pJWaENZaaB95H9k6QHZZv2/o6ri3FZ3jj+Vp7LmmnD2sUdzQidV0PR7J4oxXpY5p8
 VNVtUP3arXxBhN2iWBGcN1MNbmcZ9YLH01Xbarv+amuqshonSX6Si9oo8Y/TzYz830zxy1n8d
 R+8TbxtBp5FxcjSVHI+bXBGe4YalhPFvO3dnzoOcyt25Jqq8Bm2JDrQM/2dTOdiCIVVN2m2mU
 J6T3as+6OgznGLbWXB7H52aX8f6vkG9En34dl3slneRSau61f96tS6A+J8c+lFluPfaFJ1Y1P
 VaBxchCGL4auwtaZFls7i+aL12eDgN6jQX/BhWWo6ijw73q8bQA6CIkZP0p4qYHpJj3+NCjJa
 6tHdfZfHRewuOWBhvMaMuanBOhCwpSG9AarZLKtrXfO8B0iDucvWkzHzL6939B+u6tjlAV32G
 QG1Eqho
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
2.12.0.windows.1.7.g94dafc3b124


