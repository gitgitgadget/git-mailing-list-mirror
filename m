Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.2 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 5254421841
	for <e@80x24.org>; Wed,  2 May 2018 09:38:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751400AbeEBJip (ORCPT <rfc822;e@80x24.org>);
        Wed, 2 May 2018 05:38:45 -0400
Received: from mout.gmx.net ([212.227.17.22]:47195 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751063AbeEBJil (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 2 May 2018 05:38:41 -0400
Received: from localhost.localdomain ([37.201.195.116]) by mail.gmx.com
 (mrgmx101 [212.227.17.168]) with ESMTPSA (Nemesis) id
 0M0tr1-1eM7XF28Vz-00vA9k; Wed, 02 May 2018 11:38:30 +0200
From:   Johannes Schindelin <johannes.schindelin@gmx.de>
To:     git@vger.kernel.org
Cc:     Johannes Schindelin <johannes.schindelin@gmx.de>,
        Junio C Hamano <gitster@pobox.com>,
        Jeff King <peff@peff.net>, Johannes Sixt <j6t@kdbg.org>,
        =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>, Eric Sunshine <sunshine@sunshineco.com>
Subject: [PATCH v2 1/4] test-tool: help verifying BUG() code paths
Date:   Wed,  2 May 2018 11:38:28 +0200
Message-Id: <6e2bfd3a6eb5270c809262f046e6a8b80090b352.1525253892.git.johannes.schindelin@gmx.de>
X-Mailer: git-send-email 2.17.0.windows.1.36.gdf4ca5fb72a
In-Reply-To: <cover.1525253892.git.johannes.schindelin@gmx.de>
References: <20170513032414.mfrwabt4hovujde2@sigill.intra.peff.net> <cover.1525253892.git.johannes.schindelin@gmx.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Provags-ID: V03:K1:kgeji/PeOK3JvOhxwMUkLGpYgzURJeCC1iiNJnYWq3AoRt++wE8
 4fCDIx55sSc+hL5nNOouL+ypPUdJtQnEztwAQlWYNU9qIYathvjGg9YjJqbBVw4T8p3mVZ6
 lKrCb/pWchOT4xdeHUftCtLlTvIir6K2umjOTxIvDQrIwgl5KpTpLUZotKxbHjI7LAFIcjw
 8YSwT12Ua6bDEesQx/eOA==
X-UI-Out-Filterresults: notjunk:1;V01:K0:Yzt8csr3T+A=:ZCxPDBZzwcFVsDTagl3Zod
 wNsdFoEp9yaxmdH45HpSK4WSHc28dCoToTy9wvGuQ88B8AOGLPeVAwA2App6QuDsQZsRqKBiD
 uDMaWBlXxuO81VVblF5yABzPL0ZluQECzNPfT6b0Kfj3ImF/Ege5RX9SS3UBbHxEbTP0Mnt4H
 KTZV2UgRR4B1Qy/AcCrdqCktSkVmUxKBZZ5EKRmR5GiagaNtgQaFKrwuRp1kfwYSB5LB4iw1U
 vPlj/n2lfFFnak/g3kfg9T5Yw14Iek/AKmiQ5rZ2N27UXAx5g+/K3hdXyn9xhAZMXl/r6+ujQ
 m/HaEocrbw5Sb31qk2FN8O7nCBZ4ZXfGuC+AKMa713qMW5sgUCjbyQ+q4yneaXTYFhm+cKB42
 +P/P7sYCnyBdqrpivUSFc2YJAYfjf5BVNATNmE60+lD1SaaNxrVIPoqvPJTF1oDk8CslYVGl7
 E8mbi8L3oYYSLtfLhuvpCfq3rU8Mzm2a7uf+RNnjdb9LgZnFxtnClabzHWU7SEQvfb3SkrlUy
 DLzWQ+1HkrGKf+H1p4Hpnm+WEgNao5JKGiZ7oytJvwhdexKdt08cj/ra/BN03k7U463bq0oIV
 PQYs5ovPZYVEfdhRhUOqSSaMXnyfbCkEhqZlHY9jMSICwYxsrnzizHsaPxI0ERTo4bEuAOm9Y
 pGLecgZyVIz4YYglaIthW4V1c2gaZ5QQl69vGdm14qp72dus+C4XKtqAyw1k9mZGnw3tvr/BG
 +3DqJe0HlTGkfbWbeja7t6VpFfI7BFFdfdWMMIIE+yucRI+ZyavhiwOYpoyHU0h0IUWCsHHRj
 vw6A1rX
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

When we call BUG(), we signal via SIGABRT that something bad happened,
dumping cores if so configured. In some setups these coredumps are
redirected to some central place such as /proc/sys/kernel/core_pattern,
which is a good thing.

However, when we try to verify in our test suite that bugs are caught in
certain code paths, we do *not* want to clutter such a central place
with unnecessary coredumps.

So let's special-case the test helpers (which we use to verify such code
paths) so that the BUG() calls will *not* call abort() but exit with a
special-purpose exit code instead.

Helped-by: Nguyễn Thái Ngọc Duy <pclouds@gmail.com>
Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
---
 t/helper/test-tool.c | 2 ++
 usage.c              | 5 +++++
 2 files changed, 7 insertions(+)

diff --git a/t/helper/test-tool.c b/t/helper/test-tool.c
index 87066ced62a..5176f9f20ae 100644
--- a/t/helper/test-tool.c
+++ b/t/helper/test-tool.c
@@ -47,7 +47,9 @@ static struct test_cmd cmds[] = {
 int cmd_main(int argc, const char **argv)
 {
 	int i;
+	extern int BUG_exit_code;
 
+	BUG_exit_code = 99;
 	if (argc < 2)
 		die("I need a test name!");
 
diff --git a/usage.c b/usage.c
index cdd534c9dfc..9c84dccfa97 100644
--- a/usage.c
+++ b/usage.c
@@ -210,6 +210,9 @@ void warning(const char *warn, ...)
 	va_end(params);
 }
 
+/* Only set this, ever, from t/helper/, when verifying that bugs are caught. */
+int BUG_exit_code;
+
 static NORETURN void BUG_vfl(const char *file, int line, const char *fmt, va_list params)
 {
 	char prefix[256];
@@ -221,6 +224,8 @@ static NORETURN void BUG_vfl(const char *file, int line, const char *fmt, va_lis
 		snprintf(prefix, sizeof(prefix), "BUG: ");
 
 	vreportf(prefix, fmt, params);
+	if (BUG_exit_code)
+		exit(BUG_exit_code);
 	abort();
 }
 
-- 
2.17.0.windows.1.36.gdf4ca5fb72a


