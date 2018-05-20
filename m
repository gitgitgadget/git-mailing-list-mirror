Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.5 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 4B7C81F51C
	for <e@80x24.org>; Sun, 20 May 2018 18:40:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751659AbeETSkq (ORCPT <rfc822;e@80x24.org>);
        Sun, 20 May 2018 14:40:46 -0400
Received: from mail-lf0-f66.google.com ([209.85.215.66]:38757 "EHLO
        mail-lf0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751045AbeETSkh (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 20 May 2018 14:40:37 -0400
Received: by mail-lf0-f66.google.com with SMTP id z142-v6so20767919lff.5
        for <git@vger.kernel.org>; Sun, 20 May 2018 11:40:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=QcnO2FyiZn+4zYTF3F9mu7VgC0kaQVJCOL4j8ohURW0=;
        b=AimfhvMui/w4loJEfqK10WqY8TxJNI3QG+ESjPW+rm0jlVWy7KzXqimMU0SBFa/8vx
         hs0iUy66ChRMGgcIvBNoiPzIILFZd7PtpnkfPByJZrpAqL9ZIR5unk45WQhbEXIZrT24
         FQ7PxRwBa4WQ8d3s1rLPr4NZlgNe7JFZI6+KCSNwWW/JLfETDjdMWnh0YHrHmX6MaSre
         oEzVDO5UbpNGXLGYSURiJJlu2vjAjbFtnvaHRvAHpdp2Z44FUTyeFoYNrj64ARTx+Vgn
         v+/TY4H4PPZ5gP2iD0zCNgBtsRrClGDqAwWI9Cxne+pXefiKKLmCvaLgAkSHTIfx8BHq
         fdCg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=QcnO2FyiZn+4zYTF3F9mu7VgC0kaQVJCOL4j8ohURW0=;
        b=o/S95v6J8HT1juxsOUfBiSvqvrr1VHuR4NJ7B/3msUOAl5m4BApivExxtr5hJ+QbYE
         hs1uI+57ZsVp2WzjaLn727g65pOnoGuC+2k/BbuccCD8ijtU7R5xJLsVOnrJ6r2aYPCb
         7JIDxuQiffUlIV99WclFFmKeygGBxjPWPwVnVaPmht9+JUwSm2h2z/aFT+MtlnfUbtBk
         KAV24NLFIAgStNnmvBpV3AbE5wpHtS7ch2TRtBOtU6YKdOaH9H1jV6qzm3vZejy0KjOc
         WZ1iU7I18R3bv6xh5tT4SBqDTfaNfk2DvfkfhRu9reqlT7E7Apw4NYz+mfmqm4tGnB0Q
         C8BQ==
X-Gm-Message-State: ALKqPwfCSOM7hhPxiP8hF0RZfjU27WSQ4VlWM/kA0GPegyH15loR9vWC
        uGkZ7nF768gTimZqJ5nsLojMMw==
X-Google-Smtp-Source: AB8JxZqeaUt0gOhCKnZWhADi0He6HArIY+iykTZOVJWDP2w2WmP+B3eGJXAQIxfsxlmMeV9KN4736g==
X-Received: by 2002:a19:a30c:: with SMTP id m12-v6mr20704919lfe.35.1526841635934;
        Sun, 20 May 2018 11:40:35 -0700 (PDT)
Received: from localhost.localdomain (c80-216-12-205.bredband.comhem.se. [80.216.12.205])
        by smtp.gmail.com with ESMTPSA id k5-v6sm2176906lji.39.2018.05.20.11.40.34
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 20 May 2018 11:40:35 -0700 (PDT)
From:   =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        =?UTF-8?q?SZEDER=20G=C3=A1bor?= <szeder.dev@gmail.com>,
        Eric Sunshine <sunshine@sunshineco.com>,
        =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>
Subject: [PATCH v2 14/17] Move declaration for alias.c to alias.h
Date:   Sun, 20 May 2018 20:40:06 +0200
Message-Id: <20180520184009.976-15-pclouds@gmail.com>
X-Mailer: git-send-email 2.17.0.705.g3525833791
In-Reply-To: <20180520184009.976-1-pclouds@gmail.com>
References: <20180519042752.8666-1-pclouds@gmail.com>
 <20180520184009.976-1-pclouds@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Signed-off-by: Nguyễn Thái Ngọc Duy <pclouds@gmail.com>
---
 alias.c         | 1 +
 alias.h         | 9 +++++++++
 builtin/help.c  | 1 +
 builtin/merge.c | 1 +
 cache.h         | 5 -----
 connect.c       | 1 +
 git.c           | 1 +
 pager.c         | 1 +
 sequencer.c     | 1 +
 shell.c         | 1 +
 10 files changed, 17 insertions(+), 5 deletions(-)
 create mode 100644 alias.h

diff --git a/alias.c b/alias.c
index bf146e5263..e9726ce8c5 100644
--- a/alias.c
+++ b/alias.c
@@ -1,4 +1,5 @@
 #include "cache.h"
+#include "alias.h"
 #include "config.h"
 
 struct config_alias_data {
diff --git a/alias.h b/alias.h
new file mode 100644
index 0000000000..fbf1d22a94
--- /dev/null
+++ b/alias.h
@@ -0,0 +1,9 @@
+#ifndef __ALIAS_H__
+#define __ALIAS_H__
+
+char *alias_lookup(const char *alias);
+int split_cmdline(char *cmdline, const char ***argv);
+/* Takes a negative value returned by split_cmdline */
+const char *split_cmdline_strerror(int cmdline_errno);
+
+#endif
diff --git a/builtin/help.c b/builtin/help.c
index 5727fb5e51..6b4b3df90d 100644
--- a/builtin/help.c
+++ b/builtin/help.c
@@ -9,6 +9,7 @@
 #include "run-command.h"
 #include "column.h"
 #include "help.h"
+#include "alias.h"
 
 #ifndef DEFAULT_HELP_FORMAT
 #define DEFAULT_HELP_FORMAT "man"
diff --git a/builtin/merge.c b/builtin/merge.c
index 9db5a2cf16..e3681cd850 100644
--- a/builtin/merge.c
+++ b/builtin/merge.c
@@ -34,6 +34,7 @@
 #include "string-list.h"
 #include "packfile.h"
 #include "tag.h"
+#include "alias.h"
 
 #define DEFAULT_TWOHEAD (1<<0)
 #define DEFAULT_OCTOPUS (1<<1)
diff --git a/cache.h b/cache.h
index bbaf5c349a..111116ea13 100644
--- a/cache.h
+++ b/cache.h
@@ -1835,11 +1835,6 @@ extern int ws_blank_line(const char *line, int len, unsigned ws_rule);
 void overlay_tree_on_index(struct index_state *istate,
 			   const char *tree_name, const char *prefix);
 
-char *alias_lookup(const char *alias);
-int split_cmdline(char *cmdline, const char ***argv);
-/* Takes a negative value returned by split_cmdline */
-const char *split_cmdline_strerror(int cmdline_errno);
-
 /* setup.c */
 struct startup_info {
 	int have_repository;
diff --git a/connect.c b/connect.c
index c3a014c5ba..ff078d28dc 100644
--- a/connect.c
+++ b/connect.c
@@ -13,6 +13,7 @@
 #include "transport.h"
 #include "strbuf.h"
 #include "protocol.h"
+#include "alias.h"
 
 static char *server_capabilities;
 static const char *parse_feature_value(const char *, const char *, int *);
diff --git a/git.c b/git.c
index 4d5b8a9931..19f73b3fa3 100644
--- a/git.c
+++ b/git.c
@@ -3,6 +3,7 @@
 #include "exec_cmd.h"
 #include "help.h"
 #include "run-command.h"
+#include "alias.h"
 
 #define RUN_SETUP		(1<<0)
 #define RUN_SETUP_GENTLY	(1<<1)
diff --git a/pager.c b/pager.c
index 92b23e6cd1..1f4688fa03 100644
--- a/pager.c
+++ b/pager.c
@@ -2,6 +2,7 @@
 #include "config.h"
 #include "run-command.h"
 #include "sigchain.h"
+#include "alias.h"
 
 #ifndef DEFAULT_PAGER
 #define DEFAULT_PAGER "less"
diff --git a/sequencer.c b/sequencer.c
index 667f35ebdf..1288a36ebd 100644
--- a/sequencer.c
+++ b/sequencer.c
@@ -23,6 +23,7 @@
 #include "hashmap.h"
 #include "notes-utils.h"
 #include "sigchain.h"
+#include "alias.h"
 
 #define GIT_REFLOG_ACTION "GIT_REFLOG_ACTION"
 
diff --git a/shell.c b/shell.c
index 234b2d4f16..3ce77b8e34 100644
--- a/shell.c
+++ b/shell.c
@@ -3,6 +3,7 @@
 #include "exec_cmd.h"
 #include "strbuf.h"
 #include "run-command.h"
+#include "alias.h"
 
 #define COMMAND_DIR "git-shell-commands"
 #define HELP_COMMAND COMMAND_DIR "/help"
-- 
2.17.0.705.g3525833791

