Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.5 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,RP_MATCHES_RCVD shortcircuit=no
	autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 24B7320373
	for <e@80x24.org>; Mon, 13 Mar 2017 20:11:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753737AbdCMULg (ORCPT <rfc822;e@80x24.org>);
        Mon, 13 Mar 2017 16:11:36 -0400
Received: from mout.gmx.net ([212.227.17.21]:61509 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1753410AbdCMULb (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 13 Mar 2017 16:11:31 -0400
Received: from virtualbox ([95.208.58.29]) by mail.gmx.com (mrgmx102
 [212.227.17.168]) with ESMTPSA (Nemesis) id 0MACmL-1cykiE0m9x-00BL6k; Mon, 13
 Mar 2017 21:11:19 +0100
Date:   Mon, 13 Mar 2017 21:11:17 +0100 (CET)
From:   Johannes Schindelin <johannes.schindelin@gmx.de>
X-X-Sender: virtualbox@virtualbox
To:     git@vger.kernel.org
cc:     Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>,
        Duy Nguyen <pclouds@gmail.com>,
        Brandon Williams <bmwill@google.com>
Subject: [PATCH v6 09/12] Add t1309 to test read_early_config()
In-Reply-To: <cover.1489435755.git.johannes.schindelin@gmx.de>
Message-ID: <6f7131ccaf2f76955983e407491cbc2fcb8ef1ef.1489435755.git.johannes.schindelin@gmx.de>
References: <cover.1489098170.git.johannes.schindelin@gmx.de> <cover.1489435755.git.johannes.schindelin@gmx.de>
User-Agent: Alpine 2.20 (DEB 67 2015-01-07)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K0:CviH0Sb4Q+xIo/U+5IVXygbLlP37DwJAKa0AX6Gj7NQIHgRTMOe
 MUa4lQ5jV9/EM4VwCedPI5oHYxK2Iq7LE8u/NXv5mHbUo0a7MUHiK9AYrUy0NCqENtuFliW
 VotY0YcFmtkiOJs70Ek+u3oiPVd5itQbVIgk/0HmGRk4GKwpm2gYSZVTC+O72pW2khR7di/
 PGiqD4AtUBk0I4DHKTcag==
X-UI-Out-Filterresults: notjunk:1;V01:K0:UUksp++4BHo=:LGMqf72pjkZsazThlgtZxN
 sKg+FqKr+rlDmiHN6MbsNHOV0RsWPJ7gvb/1PkmSCqIaO3JX0UdOkyDvb66Ebu/DNx4Hk27hJ
 2qPe2Q/0p1aitg/xPgSmqcru1TO7X/sep9cv/BqxiioO30scvzGaP8d/vJ44+S059SMa8jWZN
 ABIGtUjORPNguMAfBmBGRH6/m/028GmSiviNx4QWdmv5yNWUOSq2fL8ncNps+Fm5gYrKbSUpT
 0oao6nrlPqsxQWSFWxtyk32B3PmrL9qI/JB/7/onEx4LD/yb/gEsF0/IYiXE5K3sujQkp+3eS
 33qMeR37jLj/a+7U04fXO9xrbgS60iMstIilPi/sS6Onmqe/4qQJXrJ1XrqfkmBVstIK/oKPe
 2bs3wcIKtFWOxIzu3eOpjiuW59Wv1GSHis++T6Kc/2myunelGL4Zqj4EP0lxShoY9FB57vZsb
 FpKKA2K0jJJruRMNOf2Qa4O9dJ3nq6Jrjw4cje4sHJ+QHVHDe72Dk+iV19Op0YyUpgK15lypN
 pwXnZov14ZfulcCzBIeYRsOfWesYXg2AMQHBNMpFkwu0c7t6znjIHQbsXcc7ojl2MVF/bzJGS
 46nGYLuM35uA5tOBlIz6dLVdofM7glykMC4OXhbbFHhjVSlALCqbiaxJDRedvVaIBxbB6RRQn
 6xqa+45XjvEfA47b1BvPQ879Fx8vW6oYb/AAaxksbVd4Xe+YbgITP6Mk5G/CgKpK4uzMMTepY
 6KkG3LBLoPSlunn638ofKqDHB5XeRISO6G/ivqPy07L5ThitXf8beCswvUiNTFR/AjB4gWoQp
 w7S3RIc
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


