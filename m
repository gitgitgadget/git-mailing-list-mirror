Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 4F0C61F42D
	for <e@80x24.org>; Sat, 17 Mar 2018 07:56:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752372AbeCQHz7 (ORCPT <rfc822;e@80x24.org>);
        Sat, 17 Mar 2018 03:55:59 -0400
Received: from mail-lf0-f65.google.com ([209.85.215.65]:36238 "EHLO
        mail-lf0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752368AbeCQHz4 (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 17 Mar 2018 03:55:56 -0400
Received: by mail-lf0-f65.google.com with SMTP id z143-v6so12272270lff.3
        for <git@vger.kernel.org>; Sat, 17 Mar 2018 00:55:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=CPUeZeoDXaEq4f0nCLu3SUASZn3zGhqnk5QavUSFv/U=;
        b=tWE1sJK93nGHWMqHaigRo1DjEFO5K7/vO+GWPuM64Rt33dBQQ7Ugfn/XRN3x5C4Wiq
         6OS0/HZpAT4YR30cUJHL+JI/BPoaqGd4uyyE8wPyH+6SUfJ1ZMeEvp+9ppIiVID2C1nT
         HNvtQEsJaaAbYsur8QcTG4ljQFMnpCCraAHm2wkgbtDqtJtIM18aO1A6a7dr7ZfbTTLf
         VT4P0lMYI59j/Fm9aQZz05NDuJlTsjCPM+NlEmSmdL4arPqpV6Yuh8bRQYgdL9Kb9YgZ
         f48c5HP4I8xUGfOEQWpM+MjMkJ3Th2+Bg2zvfc0TtfCoNCYmmgqhLSANqwHwUwvb0QTH
         w/TQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=CPUeZeoDXaEq4f0nCLu3SUASZn3zGhqnk5QavUSFv/U=;
        b=WaNy/4UKMB4l9DV2Rl5jhKskwjdZufGSWlBAbr1vsRMC1TNyvwDOzfoDRcYFZzXOS0
         8lb+9ad/qm/jhp4t5PO61sTkmsuFrtBsH25KkP2rxRfw9EbBhqS8zn5hcjs/k9h+nH5A
         3AeJr0He+Xt3RBcpA10LBL6o4Oca0ruf592Hw+J5H+DBraHr4GD2t/t6FXyga3gha5lh
         fhqaD2CNMKWSVzscFw7nYNdDK/4A5eQe3KppfJmSq7CwwGY86VuZIkpEB5KhsIpDgs1C
         Fse36YkQKmfcRkHRc9F6KUlZKBKxFM9BFv+oWQL0ObJBN4SOu6BTFgeFwUEmBYKEMCG1
         0WfA==
X-Gm-Message-State: AElRT7FGOiIUBA1cInM+2y4/Gmpf1VbAFK3TQrcSFJ0BjQ59mYcx9Yx9
        Bsmb6KnqPiMGzyFp1T8smme3IQ==
X-Google-Smtp-Source: AG47ELuSLYk/1Py3O1niwMU80TB0hrXbFFZqXg0Gr/7+swZuYCnjt1v38wlmtClPCk1bFuga+NbWgQ==
X-Received: by 10.46.122.15 with SMTP id v15mr3370826ljc.141.1521273354930;
        Sat, 17 Mar 2018 00:55:54 -0700 (PDT)
Received: from localhost.localdomain (c80-216-12-205.bredband.comhem.se. [80.216.12.205])
        by smtp.gmail.com with ESMTPSA id s23sm170224ljd.5.2018.03.17.00.55.53
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 17 Mar 2018 00:55:53 -0700 (PDT)
From:   =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>
To:     git@vger.kernel.org
Cc:     =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>
Subject: [PATCH 21/36] t/helper: merge test-prio-queue into test-tool
Date:   Sat, 17 Mar 2018 08:54:06 +0100
Message-Id: <20180317075421.22032-22-pclouds@gmail.com>
X-Mailer: git-send-email 2.16.2.903.gd04caf5039
In-Reply-To: <20180317075421.22032-1-pclouds@gmail.com>
References: <20180317075421.22032-1-pclouds@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Signed-off-by: Nguyễn Thái Ngọc Duy <pclouds@gmail.com>
---
 Makefile                   | 2 +-
 t/helper/test-prio-queue.c | 3 ++-
 t/helper/test-tool.c       | 1 +
 t/helper/test-tool.h       | 1 +
 t/t0009-prio-queue.sh      | 6 +++---
 5 files changed, 8 insertions(+), 5 deletions(-)

diff --git a/Makefile b/Makefile
index 751ea6cad7..076c778494 100644
--- a/Makefile
+++ b/Makefile
@@ -670,6 +670,7 @@ TEST_BUILTINS_OBJS += test-mergesort.o
 TEST_BUILTINS_OBJS += test-mktemp.o
 TEST_BUILTINS_OBJS += test-online-cpus.o
 TEST_BUILTINS_OBJS += test-path-utils.o
+TEST_BUILTINS_OBJS += test-prio-queue.o
 TEST_BUILTINS_OBJS += test-sha1.o
 
 TEST_PROGRAMS_NEED_X += test-dump-fsmonitor
@@ -677,7 +678,6 @@ TEST_PROGRAMS_NEED_X += test-dump-untracked-cache
 TEST_PROGRAMS_NEED_X += test-fake-ssh
 TEST_PROGRAMS_NEED_X += test-line-buffer
 TEST_PROGRAMS_NEED_X += test-parse-options
-TEST_PROGRAMS_NEED_X += test-prio-queue
 TEST_PROGRAMS_NEED_X += test-read-cache
 TEST_PROGRAMS_NEED_X += test-write-cache
 TEST_PROGRAMS_NEED_X += test-ref-store
diff --git a/t/helper/test-prio-queue.c b/t/helper/test-prio-queue.c
index ae58fff359..a50216e332 100644
--- a/t/helper/test-prio-queue.c
+++ b/t/helper/test-prio-queue.c
@@ -1,3 +1,4 @@
+#include "test-tool.h"
 #include "cache.h"
 #include "prio-queue.h"
 
@@ -16,7 +17,7 @@ static void show(int *v)
 	free(v);
 }
 
-int cmd_main(int argc, const char **argv)
+int test_prio_queue(int argc, const char **argv)
 {
 	struct prio_queue pq = { intcmp };
 
diff --git a/t/helper/test-tool.c b/t/helper/test-tool.c
index 23e843ab46..24ce124868 100644
--- a/t/helper/test-tool.c
+++ b/t/helper/test-tool.c
@@ -25,6 +25,7 @@ static struct test_cmd cmds[] = {
 	{ "mktemp", test_mktemp },
 	{ "online-cpus", test_online_cpus },
 	{ "path-utils", test_path_utils },
+	{ "prio-queue", test_prio_queue },
 	{ "sha1", test_sha1 },
 };
 
diff --git a/t/helper/test-tool.h b/t/helper/test-tool.h
index 4bcca38f8e..713be481d5 100644
--- a/t/helper/test-tool.h
+++ b/t/helper/test-tool.h
@@ -19,6 +19,7 @@ int test_mergesort(int argc, const char **argv);
 int test_mktemp(int argc, const char **argv);
 int test_online_cpus(int argc, const char **argv);
 int test_path_utils(int argc, const char **argv);
+int test_prio_queue(int argc, const char **argv);
 int test_sha1(int argc, const char **argv);
 
 #endif
diff --git a/t/t0009-prio-queue.sh b/t/t0009-prio-queue.sh
index 94045c3fad..e56dfce668 100755
--- a/t/t0009-prio-queue.sh
+++ b/t/t0009-prio-queue.sh
@@ -17,7 +17,7 @@ cat >expect <<'EOF'
 10
 EOF
 test_expect_success 'basic ordering' '
-	test-prio-queue 2 6 3 10 9 5 7 4 5 8 1 dump >actual &&
+	test-tool prio-queue 2 6 3 10 9 5 7 4 5 8 1 dump >actual &&
 	test_cmp expect actual
 '
 
@@ -30,7 +30,7 @@ cat >expect <<'EOF'
 6
 EOF
 test_expect_success 'mixed put and get' '
-	test-prio-queue 6 2 4 get 5 3 get get 1 dump >actual &&
+	test-tool prio-queue 6 2 4 get 5 3 get get 1 dump >actual &&
 	test_cmp expect actual
 '
 
@@ -43,7 +43,7 @@ NULL
 NULL
 EOF
 test_expect_success 'notice empty queue' '
-	test-prio-queue 1 2 get get get 1 2 get get get >actual &&
+	test-tool prio-queue 1 2 get get get 1 2 get get get >actual &&
 	test_cmp expect actual
 '
 
-- 
2.16.2.903.gd04caf5039

