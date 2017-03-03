Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.0 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id C1C2720133
	for <e@80x24.org>; Fri,  3 Mar 2017 17:33:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752251AbdCCRdt (ORCPT <rfc822;e@80x24.org>);
        Fri, 3 Mar 2017 12:33:49 -0500
Received: from mout.gmx.net ([212.227.15.15]:53076 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752232AbdCCRdt (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 3 Mar 2017 12:33:49 -0500
Received: from virtualbox ([89.204.154.17]) by mail.gmx.com (mrgmx001
 [212.227.17.190]) with ESMTPSA (Nemesis) id 0MIMUZ-1cj1rm1NFP-004B6a; Fri, 03
 Mar 2017 18:33:33 +0100
Date:   Fri, 3 Mar 2017 18:33:32 +0100 (CET)
From:   Johannes Schindelin <johannes.schindelin@gmx.de>
X-X-Sender: virtualbox@virtualbox
To:     git@vger.kernel.org
cc:     Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>,
        Duy Nguyen <pclouds@gmail.com>
Subject: [PATCH v3 9/9] Test read_early_config()
In-Reply-To: <cover.1488562287.git.johannes.schindelin@gmx.de>
Message-ID: <3e0790a6ea61b6f4f59df013e9233affb93e8634.1488562287.git.johannes.schindelin@gmx.de>
References: <cover.1488506615.git.johannes.schindelin@gmx.de> <cover.1488562287.git.johannes.schindelin@gmx.de>
User-Agent: Alpine 2.20 (DEB 67 2015-01-07)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K0:Y33tLgFc1B3HrvH3MXMjtZQ7Tv0/4AER16RaqkyN2q0+72q+akz
 WN8gk78Vj15Kz9XI43H9PlmlnspRK3jccVOX2CKEqMIazaWShErvuFHveRmfhgYCsWyXImF
 SwD6sllHAcoDXlE4kOqR806uhRndtxAfkfYlkRdSJLQIa2HmWKctB/bX7Y6fO8QWysbCPbz
 Pr/TlE7Trhn5m794xqOfQ==
X-UI-Out-Filterresults: notjunk:1;V01:K0:z7NC2LW8at4=:ghJTmn4RVPU7LhJAM44awB
 miBmy0vn3nlxmom9eAgRH/uAoONuDWy77+VSFc9mB+mSSffz6l0JwaoZWM2DAKfnIMbpk67Y7
 kx/W+twtRZN/szBtZu3jOUZsthOiXbe+gVrTOssWCB6I8wH7htiEkzc/hu73uzkrkk7ZDtG8m
 6CjLQq9kigljD30Mzrzu9p/QPEwFEl0EFquS4Pcsw3p/5WHXAtYnnpexg/fReulRK7p66u35A
 +JifIux0JCAbUPVh0uJer33v8mhQbHAl63Z0We/NE9Xz+1mMT/JgCLpvLT3dqhrbmo0TmwLpS
 EEP/qsZ/vw1VuJ1DNS5x3zU33bMvnGSzzYkoKZH5cQR6GSIPvj5uBBTl8CGbfLJWmCU5Ktes2
 4eQkwQUBQO7lBhybxLvgS+1xOBjWIPea5Ux4z9RTVPzIOgo86XUKvp30BIWGYYa7X9sPuGk1k
 VWoaYA3bzOUkCTWQiQjMxophhJrTn3WHWJR7ML5h6DjiU9cHKNG7XuHheu3XAWM9hobcM2o5I
 W+W8HkksBy+VLJd+BNB3J/EHx5FNs2uT/9litjXbbbl8Vfnz0dmunNNEC7ly19l68pFGUu+jY
 5QBJBqg3pKfQpf/HmLuKyWvoZcdA0BSqvqKNHNFL9BHGIXBWpECswHb39/KJ0WafgstKXAOrB
 7X0qofW6cUGbOEL6BVUVDomPHQdIX998189dY++eVTUURCJ9ykLNLy7BJwneLszt7uPjVWfUp
 sq7lcy6TmFki829hQ5jQFvolMT/S0pd3h5gZhIV452mGbM2hUuQnUW7xkKIycmRpV3dB4Bsuq
 tsf9Xcc
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
