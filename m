Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 223951F453
	for <e@80x24.org>; Thu, 27 Sep 2018 22:00:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727421AbeI1EU6 (ORCPT <rfc822;e@80x24.org>);
        Fri, 28 Sep 2018 00:20:58 -0400
Received: from mail-wm1-f68.google.com ([209.85.128.68]:37277 "EHLO
        mail-wm1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726132AbeI1EU5 (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 28 Sep 2018 00:20:57 -0400
Received: by mail-wm1-f68.google.com with SMTP id y26-v6so294707wma.2
        for <git@vger.kernel.org>; Thu, 27 Sep 2018 15:00:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=rFyHnKhf9cqBHKVKaQhLk8zOuq09jshEZP3Hkp6L+MA=;
        b=ckSrGRjg6er8oCnXRiEWg3ADAX4QZHAxBei79+xKhSyG2yKtRLjjC0wsp97MX2jdRc
         EOx8BA1wJFg/i2ijFZ3//q8Lb7iXA7lt8gOJH/Vt+UJQb1SaRIqF5C1xj6tGzF5WW3Rd
         NH0A+OejYiemM2Tp1H/tRzIgoYyBKwf/z6PQkJeKJlgjS5sgvjdSZBBSgYAtp7RuAdkN
         uLcx6bdkODMA0MrGja3zgYHVdDAWyHhOHQjooFnK1bPoGZt8ShjL3b+EzaAmD+9o8YUX
         JTyTTmB9gksxPrv3+M+1OWGiBv1jXvwVGQRtr75xY1Cvq5R4w2Tb/zBXvYGDisorRoum
         qlAQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=rFyHnKhf9cqBHKVKaQhLk8zOuq09jshEZP3Hkp6L+MA=;
        b=BuVs//zAqFyX0dZkeDHD1SOgAVKbsEwZuRd+eqY26Ahe54TpmIVqmNSpZhVOc67M7j
         ubK+fC0ok1JgMUZRAj28zx1Rj0qFtd4wWugtYDDw6IiMPMLYagQBRHqrohVD260GACLr
         M//JccPIQ9S65fczIH+2Qxucwkd0guohJUL2MZ3p/EUHEFLLhYyXBNEhB9bzKK5zEFHR
         tMtUu79ubS0iMGR1Vggnl+4lafGkVCiOnI3Lv7HzjMnNo4Y9uqZL5IYItVvblKjAnjcB
         fiXVsmBtl3nQ8eE2KkRSX47Ghrr3e1vbmT28uNHkMZClJXJuWAiOVoqg0NUX/yzfOE5N
         qOrA==
X-Gm-Message-State: ABuFfogBE4oa4BV2BFYNQmPIOqn7xCBccBQHCQ/UMo5RZJ3kGVdlLwOY
        Ig/JGIharzaHcWFrH/s+Uky0neHF
X-Google-Smtp-Source: ACcGV60Y31T6F06FY0eWSyj0xlFE9z/Us0twzw5Rn/JzWKZQQfugw57twDABOsKPLfQzxJ0id2QHmQ==
X-Received: by 2002:a1c:1203:: with SMTP id 3-v6mr314711wms.21.1538085631353;
        Thu, 27 Sep 2018 15:00:31 -0700 (PDT)
Received: from localhost.localdomain (AToulouse-658-1-28-140.w86-222.abo.wanadoo.fr. [86.222.27.140])
        by smtp.googlemail.com with ESMTPSA id h206-v6sm243153wmf.25.2018.09.27.15.00.30
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 27 Sep 2018 15:00:30 -0700 (PDT)
From:   Alban Gruin <alban.gruin@gmail.com>
To:     git@vger.kernel.org
Cc:     Stefan Beller <sbeller@google.com>,
        Christian Couder <christian.couder@gmail.com>,
        Pratik Karki <predatoramigo@gmail.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        phillip.wood@dunelm.org.uk, gitster@pobox.com,
        Alban Gruin <alban.gruin@gmail.com>
Subject: [GSoC][PATCH v8 03/20] editor: add a function to launch the sequence editor
Date:   Thu, 27 Sep 2018 23:55:53 +0200
Message-Id: <20180927215610.32210-4-alban.gruin@gmail.com>
X-Mailer: git-send-email 2.19.0
In-Reply-To: <20180927215610.32210-1-alban.gruin@gmail.com>
References: <20180828121045.14933-1-alban.gruin@gmail.com>
 <20180927215610.32210-1-alban.gruin@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

As part of the rewrite of interactive rebase, the sequencer will need to
open the sequence editor to allow the user to edit the todo list.
Instead of duplicating the existing launch_editor() function, this
refactors it to a new function, launch_specified_editor(), which takes
the editor as a parameter, in addition to the path, the buffer and the
environment variables.  launch_sequence_editor() is then added to launch
the sequence editor.

Signed-off-by: Alban Gruin <alban.gruin@gmail.com>
---
No changes since v7.

 cache.h  |  1 +
 editor.c | 27 +++++++++++++++++++++++++--
 strbuf.h |  2 ++
 3 files changed, 28 insertions(+), 2 deletions(-)

diff --git a/cache.h b/cache.h
index d508f3d4f8..a976e26a02 100644
--- a/cache.h
+++ b/cache.h
@@ -1482,6 +1482,7 @@ extern const char *fmt_name(const char *name, const char *email);
 extern const char *ident_default_name(void);
 extern const char *ident_default_email(void);
 extern const char *git_editor(void);
+extern const char *git_sequence_editor(void);
 extern const char *git_pager(int stdout_is_tty);
 extern int is_terminal_dumb(void);
 extern int git_ident_config(const char *, const char *, void *);
diff --git a/editor.c b/editor.c
index 9a9b4e12d1..c985eee1f9 100644
--- a/editor.c
+++ b/editor.c
@@ -1,4 +1,5 @@
 #include "cache.h"
+#include "config.h"
 #include "strbuf.h"
 #include "run-command.h"
 #include "sigchain.h"
@@ -34,10 +35,21 @@ const char *git_editor(void)
 	return editor;
 }
 
-int launch_editor(const char *path, struct strbuf *buffer, const char *const *env)
+const char *git_sequence_editor(void)
 {
-	const char *editor = git_editor();
+	const char *editor = getenv("GIT_SEQUENCE_EDITOR");
+
+	if (!editor)
+		git_config_get_string_const("sequence.editor", &editor);
+	if (!editor)
+		editor = git_editor();
 
+	return editor;
+}
+
+static int launch_specified_editor(const char *editor, const char *path,
+				   struct strbuf *buffer, const char *const *env)
+{
 	if (!editor)
 		return error("Terminal is dumb, but EDITOR unset");
 
@@ -95,3 +107,14 @@ int launch_editor(const char *path, struct strbuf *buffer, const char *const *en
 		return error_errno("could not read file '%s'", path);
 	return 0;
 }
+
+int launch_editor(const char *path, struct strbuf *buffer, const char *const *env)
+{
+	return launch_specified_editor(git_editor(), path, buffer, env);
+}
+
+int launch_sequence_editor(const char *path, struct strbuf *buffer,
+			   const char *const *env)
+{
+	return launch_specified_editor(git_sequence_editor(), path, buffer, env);
+}
diff --git a/strbuf.h b/strbuf.h
index 60a35aef16..66da9822fd 100644
--- a/strbuf.h
+++ b/strbuf.h
@@ -575,6 +575,8 @@ extern void strbuf_add_unique_abbrev(struct strbuf *sb,
  * file's contents are not read into the buffer upon completion.
  */
 extern int launch_editor(const char *path, struct strbuf *buffer, const char *const *env);
+extern int launch_sequence_editor(const char *path, struct strbuf *buffer,
+				  const char *const *env);
 
 extern void strbuf_add_lines(struct strbuf *sb, const char *prefix, const char *buf, size_t size);
 
-- 
2.19.0

