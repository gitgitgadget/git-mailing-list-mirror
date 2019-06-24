Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id EFAA01F461
	for <e@80x24.org>; Mon, 24 Jun 2019 13:03:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730569AbfFXNDU (ORCPT <rfc822;e@80x24.org>);
        Mon, 24 Jun 2019 09:03:20 -0400
Received: from mail-pg1-f194.google.com ([209.85.215.194]:33862 "EHLO
        mail-pg1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728425AbfFXNDT (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 24 Jun 2019 09:03:19 -0400
Received: by mail-pg1-f194.google.com with SMTP id p10so7114864pgn.1
        for <git@vger.kernel.org>; Mon, 24 Jun 2019 06:03:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=mrQ8p9NRDRcPK8HvPOBRujSFKyHRUH2QCCFUlkr783A=;
        b=ft96zKdfwzd8LrID+JrRdMkFw7iMSkQiLYBAe3xxtHdK3iRVgfL6MhLScgJ5439VWD
         afl3zZoYPRG7zfLD+uX4Gq3b5qUCb30lvozSfEoqFb+jC+QEwA8R5nFLZHjohG82CCp6
         W1bOGAWNNnSyN1NeoWkz3v7fQev7ZOKPQmRwVBjd9HD5rDIsjZekTtvP0fVbPumxAOia
         tj+0aD3FULdUw/luIakCx4ATR/H5jKN+K+V4nW1G2z3Yp02pRtKq4HTKFKrTZlezRyyR
         Y6ozH2DfAf1PFpgsZaXVn9NlsY08/G3CglZ6u7706uqh9yffCJ/Zu4ZyJdbOqlyRzNmK
         UM1g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=mrQ8p9NRDRcPK8HvPOBRujSFKyHRUH2QCCFUlkr783A=;
        b=X4pXyZNV4qT2Hboh/IGYFc/5vVbih3WweCyPvCeKMNCTJ5sde6kSsiQVRlnd6MKe2N
         FaarUzD2h7gC6eQPsH0/711f47Sb5hjoRVFTeWLPsrClxT70ELn2sd0/aFui/9NU521t
         bdj3JW8KUykhLGKS1UmhCeEB1SWKl2FYW5lGSO3aIFO6Smx6gvw7Xen4p8U53V9VqHm4
         aH2hbkqGCbjyPUWOraT0UqMXJhZxBtN1SMKLN0w2mAlEuJNMUeg6IdGCAyW9CMM/stgL
         l7S7dGO7GpR9dE4r6MpviV6gzkPRpvfUN2It/X0/K1il5pvCW1fjnrqEyPi3EzbCTKcG
         oImQ==
X-Gm-Message-State: APjAAAXdwfPq4zzmJl/+3/5BCM3bS7TGUf9Nrwt2q9XL9Oz4BLcyubaP
        2m0uqgZR4V2JC1WHN1h8NvPYxHHT
X-Google-Smtp-Source: APXvYqzochGVQStd3OBmAS0GfuqGJ9NMTIxCbwekSWT5/bjLP2G/5xJOonmw/b60J4REhp1gx1VSMQ==
X-Received: by 2002:a63:a506:: with SMTP id n6mr27996632pgf.161.1561381398889;
        Mon, 24 Jun 2019 06:03:18 -0700 (PDT)
Received: from ash ([115.76.181.38])
        by smtp.gmail.com with ESMTPSA id r7sm15781722pfl.134.2019.06.24.06.03.15
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 24 Jun 2019 06:03:18 -0700 (PDT)
Received: by ash (sSMTP sendmail emulation); Mon, 24 Jun 2019 20:03:13 +0700
From:   =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>,
        Derrick Stolee <stolee@gmail.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>
Subject: [PATCH v2 06/10] fsmonitor.c: dump "FSMN" extension as json
Date:   Mon, 24 Jun 2019 20:02:22 +0700
Message-Id: <20190624130226.17293-7-pclouds@gmail.com>
X-Mailer: git-send-email 2.22.0.rc0.322.g2b0371e29a
In-Reply-To: <20190624130226.17293-1-pclouds@gmail.com>
References: <20190624130226.17293-1-pclouds@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Signed-off-by: Nguyễn Thái Ngọc Duy <pclouds@gmail.com>
---
 fsmonitor.c              |  6 ++++++
 t/t3011-ls-files-json.sh | 14 +++++++++++++-
 t/t3011/fsmonitor (new)  | 38 ++++++++++++++++++++++++++++++++++++++
 3 files changed, 57 insertions(+), 1 deletion(-)

diff --git a/fsmonitor.c b/fsmonitor.c
index 1dee0aded1..5ed55ad176 100644
--- a/fsmonitor.c
+++ b/fsmonitor.c
@@ -3,6 +3,7 @@
 #include "dir.h"
 #include "ewah/ewok.h"
 #include "fsmonitor.h"
+#include "json-writer.h"
 #include "run-command.h"
 #include "strbuf.h"
 
@@ -50,6 +51,11 @@ int read_fsmonitor_extension(struct index_state *istate, const void *data,
 	}
 	istate->fsmonitor_dirty = fsmonitor_dirty;
 
+	if (istate->jw) {
+		jw_object_intmax(istate->jw, "version", hdr_version);
+		jw_object_intmax(istate->jw, "last_update", istate->fsmonitor_last_update);
+		jw_object_ewah(istate->jw, "dirty", fsmonitor_dirty);
+	}
 	trace_printf_key(&trace_fsmonitor, "read fsmonitor extension successful");
 	return 0;
 }
diff --git a/t/t3011-ls-files-json.sh b/t/t3011-ls-files-json.sh
index dbb572ce9d..25215f83ae 100755
--- a/t/t3011-ls-files-json.sh
+++ b/t/t3011-ls-files-json.sh
@@ -36,7 +36,7 @@ test_expect_success 'setup' '
 	git add -N ita &&
 
 	strip_number ctime_sec ctime_nsec mtime_sec mtime_nsec &&
-	strip_number device inode uid gid file_offset ext_size &&
+	strip_number device inode uid gid file_offset ext_size last_update &&
 	strip_string oid ident
 '
 
@@ -58,4 +58,16 @@ test_expect_success 'ls-files --json, split index' '
 	)
 '
 
+test_expect_success 'ls-files --json, fsmonitor extension ' '
+	git init fsmonitor &&
+	(
+		cd fsmonitor &&
+		echo one >one &&
+		git add one &&
+		git update-index --fsmonitor &&
+		cp ../filter.sed . &&
+		compare_json fsmonitor
+	)
+'
+
 test_done
diff --git a/t/t3011/fsmonitor b/t/t3011/fsmonitor
new file mode 100644
index 0000000000..17f2d4a664
--- /dev/null
+++ b/t/t3011/fsmonitor
@@ -0,0 +1,38 @@
+{
+  "version": 2,
+  "oid": <string>,
+  "mtime_sec": <number>,
+  "mtime_nsec": <number>,
+  "entries": [
+    {
+      "id": 0,
+      "name": "one",
+      "mode": "100644",
+      "flags": 0,
+      "oid": <string>,
+      "stat": {
+        "ctime_sec": <number>,
+        "ctime_nsec": <number>,
+        "mtime_sec": <number>,
+        "mtime_nsec": <number>,
+        "device": <number>,
+        "inode": <number>,
+        "uid": <number>,
+        "gid": <number>,
+        "size": 4
+      },
+      "file_offset": <number>
+    }
+  ],
+  "extensions": {
+    "FSMN": {
+      "file_offset": <number>,
+      "ext_size": <number>,
+      "version": 1,
+      "last_update": <number>,
+      "dirty": [
+        0
+      ]
+    }
+  }
+}
-- 
2.22.0.rc0.322.g2b0371e29a

