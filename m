Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.2 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 477C01FBEC
	for <e@80x24.org>; Tue,  7 Mar 2017 15:06:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932775AbdCGPG3 (ORCPT <rfc822;e@80x24.org>);
        Tue, 7 Mar 2017 10:06:29 -0500
Received: from mout.gmx.net ([212.227.17.22]:50396 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S932770AbdCGPGR (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 7 Mar 2017 10:06:17 -0500
Received: from virtualbox ([37.201.194.72]) by mail.gmx.com (mrgmx102
 [212.227.17.168]) with ESMTPSA (Nemesis) id 0MI8iw-1chPtQ2HvC-003wzI; Tue, 07
 Mar 2017 15:33:26 +0100
Date:   Tue, 7 Mar 2017 15:33:25 +0100 (CET)
From:   Johannes Schindelin <johannes.schindelin@gmx.de>
X-X-Sender: virtualbox@virtualbox
To:     git@vger.kernel.org
cc:     Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>,
        Duy Nguyen <pclouds@gmail.com>
Subject: [PATCH v4 09/10] Test read_early_config()
In-Reply-To: <cover.1488897111.git.johannes.schindelin@gmx.de>
Message-ID: <a2d57d9cc9b2ef8c9cd0e1f8313b23dd07a52109.1488897111.git.johannes.schindelin@gmx.de>
References: <cover.1488562287.git.johannes.schindelin@gmx.de> <cover.1488897111.git.johannes.schindelin@gmx.de>
User-Agent: Alpine 2.20 (DEB 67 2015-01-07)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K0:rneVH4GlLTb1jToadmYlmess8GBlUFDYtb0bPjezqEwTADRadtI
 llCUUY3TbgnCLlFCBRVBzSHkOslggHc57UpzFOkaSOtCCuNhCW9KzajENP6YDjJ/5IsEf6e
 KETTzSQYX5pDGKncscAxUoS4unyNR+Nyp/frTT+WnB+1+UC9ae75jT64ToKNvrsvKE7pvzH
 wnf7lDsknctAHyGS/Fu6g==
X-UI-Out-Filterresults: notjunk:1;V01:K0:CZjxB6095qk=:RiIkv08uDQkz37li5+hwWh
 5IJ1AhwYUvPN1TZtkdDvmFXWgbAEVPJB7O+t9M3+1PFIy1clJ85pkPdO3ru4PeCNEHzt+zVHF
 Piaa/Hy5DBMYFXv0aqifYNxH3J+Y46eJoyJVPikrzgr4y9HJ5TKOay7pd8M3am2vHkEjnGaKs
 Rn7IgWNZlc2mxhKNhXzHrGIXoS3ZJTjfHZtvCF1/Bp7SpysbLmCHYnA8HFgdY3oYBIvMEpOF6
 fWvHbI9YDDWbwP0ddeC1v0xqB2eYhHrqojs8chantJT8GrvxhUh6GCWdws9Ii0FADGcLyqQDi
 FmA9GmZ5ZLjHQA9QbdRJDxCh1xqPv+MafqvbIVmB/YKyuBjVjj2bM4IxZe4eF7ZuIqs23s/RJ
 kR+kAGhfWxQoPKVUCWFd71felA9iLECAgPzSWeihRwcmxq7c35H5Vo0VkNLXczaAeD+7bQ/ub
 A/ISuYLYUgKNHBT4Szi1AV3M3wVGf2j8uFpP/Nehqrn7pwoIACXNoIx4zcXOOQ08vzK8gBXI2
 cFCf6tUhiZ57UxF2RVxCBCBNyDb2DSeuTCuMMmUQshk7aA62mYG9vz2WqGofyhrQ4YVOYV/LU
 D523e6CU0FHOnLNbvJ2XrngDPkLMk6ph0VEzxji1Js0meT45+hh8DUksJcGk48+ICLrZc2Ooh
 epMLchh0kTNLL3C5NaoPJcQ7XlNFlTzzpPW/mOx195D3SJ29hYjhF11kcUTg+HgdAsBep6flY
 tQTIGvoVdJ+A8J7IspwejtBm9NIQKZMZ7c2Ax/9v5Yiu5gWzpllkCke3tqbM/3zRpLq50EcgX
 klxtcg+xGhYoRMXrhVwX1RFWLPWpqzKu9FJtGrB/S9A6d9DsFFr6NB325p8NWgeNpoPKLGkOq
 SMakVkzfIfTMKgYtNF1DXU3yT7r59JZ0abRfTNK5uKQuvysS3fuXjCC+wZ0dgHPw9JWBgvi2x
 gjeYvEtTascVC+EM0aHddvqfPRDx9kklU/i/tAgbzL5Ma+iu1a/hVSbY03NdmVmi8oBmM5ZsE
 24Uh/jbZXUpnhFhdyWvvxFERHfzRrMNafd7vhApcnG96agtune6L0cZy4y4XlkDdTw==
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


