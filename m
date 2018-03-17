Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 90AFA1F42D
	for <e@80x24.org>; Sat, 17 Mar 2018 07:57:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752723AbeCQH5B (ORCPT <rfc822;e@80x24.org>);
        Sat, 17 Mar 2018 03:57:01 -0400
Received: from mail-lf0-f68.google.com ([209.85.215.68]:38056 "EHLO
        mail-lf0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751832AbeCQHzu (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 17 Mar 2018 03:55:50 -0400
Received: by mail-lf0-f68.google.com with SMTP id y2-v6so16399120lfc.5
        for <git@vger.kernel.org>; Sat, 17 Mar 2018 00:55:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=2UN1YmByy3HY1O7MAakvLGJQp8mcvVlRrYbY1WvxWF4=;
        b=PCLG4G5auFvjWoySEwLf3+4Wj7jZ0oVtItlo1TibN/7+h8So+r+AhnYrr2rPE2vY55
         zDkh1NUK/uSgL1GvKTVDPMj+Syiiookc5/LjIx92vVVQ4DwlaF9Xnz8DLARu5sJ6V8aQ
         nBLDT6MhQUn2jMb282bZKf4ed9SWSqxZRnl1XSNvaRRruaBKfzNBy7UAiDsH7+k7aMrz
         xYhj0divo/kuPh+kobbgbzAOx8jSGz8EFXRiQ7RwmVVxInfPtzJljz9ayJwi9x82MDKW
         3UfNcFwV6TmF035vCMzWXfPWjgGzHj7NtSIMS9wcguiCFmBq2frTGncULg1BcC5jyWnD
         ctUw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=2UN1YmByy3HY1O7MAakvLGJQp8mcvVlRrYbY1WvxWF4=;
        b=AqvArMVAE2qn7+W9G5/UroLqKxMbnOqPgt32CPxLmRs+eumqSQxuwuVQgzYtqV+sha
         fATFd4sNo7chDEIm6hwoHvDqHXn+ITqEG/VbLhSdt5DqrjMg2YtYTMrnsyA/RVgvJSq2
         H9eRGfK05H5anAZAwg1S1z/Zi+lgqeDqh9H3jhx+Ra50GGkp5QJ7YEUJBXycJQ1X61Ki
         cajKfDQeoO12bdnikMb78vEAk7yqUYw/bb23G0xBirL9B1qNZBAvGBUQV7bah1rNfh2/
         qxT9wECZRwz7r8pLla1rhZ4U0+d5O/X8Vmr0onNyqlO/vNcC+Y7QilYs8Sye+CIEc/D8
         Ap8A==
X-Gm-Message-State: AElRT7Er6YlwMEzLfFwTauTZM2jUpHgTfA71Rf5iWuBwmqUPp93UexAz
        vKzuQ51VUDWZdw6pkovU++QQJA==
X-Google-Smtp-Source: AG47ELu1QGXV+pmWhNHfKTVrYoKywJM6NfXaS45ws5a1ottIfg9auf7XZn89GffHHc84B1B1vLTp8g==
X-Received: by 2002:a19:a809:: with SMTP id r9-v6mr3440097lfe.55.1521273349204;
        Sat, 17 Mar 2018 00:55:49 -0700 (PDT)
Received: from localhost.localdomain (c80-216-12-205.bredband.comhem.se. [80.216.12.205])
        by smtp.gmail.com with ESMTPSA id s23sm170224ljd.5.2018.03.17.00.55.47
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 17 Mar 2018 00:55:48 -0700 (PDT)
From:   =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>
To:     git@vger.kernel.org
Cc:     =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>
Subject: [PATCH 17/36] t/helper: merge (unused) test-mergesort into test-tool
Date:   Sat, 17 Mar 2018 08:54:02 +0100
Message-Id: <20180317075421.22032-18-pclouds@gmail.com>
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
 Makefile                  | 2 +-
 t/helper/test-mergesort.c | 3 ++-
 t/helper/test-tool.c      | 1 +
 t/helper/test-tool.h      | 1 +
 4 files changed, 5 insertions(+), 2 deletions(-)

diff --git a/Makefile b/Makefile
index 6552a8f4ed..67f37b849e 100644
--- a/Makefile
+++ b/Makefile
@@ -666,13 +666,13 @@ TEST_BUILTINS_OBJS += test-hashmap.o
 TEST_BUILTINS_OBJS += test-index-version.o
 TEST_BUILTINS_OBJS += test-lazy-init-name-hash.o
 TEST_BUILTINS_OBJS += test-match-trees.o
+TEST_BUILTINS_OBJS += test-mergesort.o
 TEST_BUILTINS_OBJS += test-sha1.o
 
 TEST_PROGRAMS_NEED_X += test-dump-fsmonitor
 TEST_PROGRAMS_NEED_X += test-dump-untracked-cache
 TEST_PROGRAMS_NEED_X += test-fake-ssh
 TEST_PROGRAMS_NEED_X += test-line-buffer
-TEST_PROGRAMS_NEED_X += test-mergesort
 TEST_PROGRAMS_NEED_X += test-mktemp
 TEST_PROGRAMS_NEED_X += test-online-cpus
 TEST_PROGRAMS_NEED_X += test-parse-options
diff --git a/t/helper/test-mergesort.c b/t/helper/test-mergesort.c
index 335cf6b626..31258e40d9 100644
--- a/t/helper/test-mergesort.c
+++ b/t/helper/test-mergesort.c
@@ -1,3 +1,4 @@
+#include "test-tool.h"
 #include "cache.h"
 #include "mergesort.h"
 
@@ -22,7 +23,7 @@ static int compare_strings(const void *a, const void *b)
 	return strcmp(x->text, y->text);
 }
 
-int cmd_main(int argc, const char **argv)
+int test_mergesort(int argc, const char **argv)
 {
 	struct line *line, *p = NULL, *lines = NULL;
 	struct strbuf sb = STRBUF_INIT;
diff --git a/t/helper/test-tool.c b/t/helper/test-tool.c
index cde9f16fc8..4206d96304 100644
--- a/t/helper/test-tool.c
+++ b/t/helper/test-tool.c
@@ -21,6 +21,7 @@ static struct test_cmd cmds[] = {
 	{ "index-version", test_index_version },
 	{ "lazy-init-name-hash", test_lazy_init_name_hash },
 	{ "match-trees", test_match_trees },
+	{ "mergesort", test_mergesort },
 	{ "sha1", test_sha1 },
 };
 
diff --git a/t/helper/test-tool.h b/t/helper/test-tool.h
index 937c408dcc..dff1b804cb 100644
--- a/t/helper/test-tool.h
+++ b/t/helper/test-tool.h
@@ -15,6 +15,7 @@ int test_hashmap(int argc, const char **argv);
 int test_index_version(int argc, const char **argv);
 int test_lazy_init_name_hash(int argc, const char **argv);
 int test_match_trees(int argc, const char **argv);
+int test_mergesort(int argc, const char **argv);
 int test_sha1(int argc, const char **argv);
 
 #endif
-- 
2.16.2.903.gd04caf5039

