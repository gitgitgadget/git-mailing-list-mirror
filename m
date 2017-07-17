Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 12AC120357
	for <e@80x24.org>; Mon, 17 Jul 2017 20:11:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751335AbdGQULb (ORCPT <rfc822;e@80x24.org>);
        Mon, 17 Jul 2017 16:11:31 -0400
Received: from mail-lf0-f68.google.com ([209.85.215.68]:36153 "EHLO
        mail-lf0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751317AbdGQULa (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 17 Jul 2017 16:11:30 -0400
Received: by mail-lf0-f68.google.com with SMTP id c199so4326lfg.3
        for <git@vger.kernel.org>; Mon, 17 Jul 2017 13:11:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=x3IaTl+qRKZ/AWAMLd9c9/n5o/FsWQJ3mfjiJpbx5OI=;
        b=gc+6xDWiXQ/QFTSIHfp2XiFN7/nskokX/OHQ/xDHk7XO+WVJhLaUIvAxYyEU4LsSmg
         BELtpcaSCp+1FauVLvaSb6eWB2L10roMSGQvnFeQIkEyl5NdrxPIVWK/8LJ/LGDnWA73
         haEWi0SSvNHmgDosoA0YktQsC59Rx0A1swHEQnnWuyv1wOeO5RjI8DSqQ/qwNTyCx6e9
         Mi1cWCCWHnEnLytE31+NNOm6sQJ4uX8Xi+vyUm+GrkUbd5RYaJEHVU5Gt6B29Ijzz3wr
         RrQzetRkqQSSnPUJQxFSv5eS4zXCHg8irwQT1a18QHvsPR83TBRGroN1bHnp+8eEPUGj
         lLpA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=x3IaTl+qRKZ/AWAMLd9c9/n5o/FsWQJ3mfjiJpbx5OI=;
        b=VV02JBfLPBNU7CI5cmANmxJ97iPzWG+Fq97mRAR72Kdf9mOhhpWiMnJAtpfFjntCeU
         cDhoqrjGUWRKlQ8ujW43aVJ/5Ef9e8Ii8YUwlLS5+BwsBGqtR+9AFoZWMCMl2F5jFy94
         JsC1pIU3S9fTJmT+oruN2MVTIJ5Wnwm4+YpgkehQAYyLsBM/IYomHOhCmk4gq/KjIPnz
         D9eU37pC1QaXLi4oKlWTUttxFOqcK0x/kndrRbw5OP1d1Cnjx37GwRUVlhqjcfsUz5sw
         qISMSAoA+FO5ESFwATJGQ79CRNHeEA24Bn82Nb94iq0rzjWTlLQfOzqduZOIFJfb5rxY
         9bWg==
X-Gm-Message-State: AIVw111CbWmWA4niKfptMO5LKj/k+DEBALL41VR0PLSryov0N4sLgZZO
        HKDK+osKf7e5HBOG
X-Received: by 10.25.157.202 with SMTP id g193mr8144164lfe.184.1500322288303;
        Mon, 17 Jul 2017 13:11:28 -0700 (PDT)
Received: from localhost.localdomain (c83-248-253-33.bredband.comhem.se. [83.248.253.33])
        by smtp.gmail.com with ESMTPSA id l12sm30752ljb.39.2017.07.17.13.11.26
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Mon, 17 Jul 2017 13:11:27 -0700 (PDT)
From:   =?UTF-8?q?Martin=20=C3=85gren?= <martin.agren@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>,
        Brandon Williams <bmwill@google.com>
Subject: [PATCH v2 01/10] builtin.h: take over documentation from api-builtin.txt
Date:   Mon, 17 Jul 2017 22:10:43 +0200
Message-Id: <77fdbe70b0807bb9593714f4d43ae96404a73538.1500321657.git.martin.agren@gmail.com>
X-Mailer: git-send-email 2.14.0.rc0
In-Reply-To: <cover.1500321657.git.martin.agren@gmail.com>
References: <cover.1499723297.git.martin.agren@gmail.com> <cover.1500321657.git.martin.agren@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Delete Documentation/technical/api-builtin.txt and move its content
verbatim into builtin.h. Just wrap it in /* ... */. In order to make
the move obviously correct, do not change any formatting, not even to
format the comment into Git's preferred style. That will be done in a
follow-up patch.

Signed-off-by: Martin Ågren <martin.agren@gmail.com>
---
 Documentation/technical/api-builtin.txt | 73 -------------------------------
 builtin.h                               | 76 +++++++++++++++++++++++++++++++++
 2 files changed, 76 insertions(+), 73 deletions(-)
 delete mode 100644 Documentation/technical/api-builtin.txt

diff --git a/Documentation/technical/api-builtin.txt b/Documentation/technical/api-builtin.txt
deleted file mode 100644
index 22a39b929..000000000
--- a/Documentation/technical/api-builtin.txt
+++ /dev/null
@@ -1,73 +0,0 @@
-builtin API
-===========
-
-Adding a new built-in
----------------------
-
-There are 4 things to do to add a built-in command implementation to
-Git:
-
-. Define the implementation of the built-in command `foo` with
-  signature:
-
-	int cmd_foo(int argc, const char **argv, const char *prefix);
-
-. Add the external declaration for the function to `builtin.h`.
-
-. Add the command to the `commands[]` table defined in `git.c`.
-  The entry should look like:
-
-	{ "foo", cmd_foo, <options> },
-+
-where options is the bitwise-or of:
-
-`RUN_SETUP`::
-	If there is not a Git directory to work on, abort.  If there
-	is a work tree, chdir to the top of it if the command was
-	invoked in a subdirectory.  If there is no work tree, no
-	chdir() is done.
-
-`RUN_SETUP_GENTLY`::
-	If there is a Git directory, chdir as per RUN_SETUP, otherwise,
-	don't chdir anywhere.
-
-`USE_PAGER`::
-
-	If the standard output is connected to a tty, spawn a pager and
-	feed our output to it.
-
-`NEED_WORK_TREE`::
-
-	Make sure there is a work tree, i.e. the command cannot act
-	on bare repositories.
-	This only makes sense when `RUN_SETUP` is also set.
-
-. Add `builtin/foo.o` to `BUILTIN_OBJS` in `Makefile`.
-
-Additionally, if `foo` is a new command, there are 3 more things to do:
-
-. Add tests to `t/` directory.
-
-. Write documentation in `Documentation/git-foo.txt`.
-
-. Add an entry for `git-foo` to `command-list.txt`.
-
-. Add an entry for `/git-foo` to `.gitignore`.
-
-
-How a built-in is called
-------------------------
-
-The implementation `cmd_foo()` takes three parameters, `argc`, `argv,
-and `prefix`.  The first two are similar to what `main()` of a
-standalone command would be called with.
-
-When `RUN_SETUP` is specified in the `commands[]` table, and when you
-were started from a subdirectory of the work tree, `cmd_foo()` is called
-after chdir(2) to the top of the work tree, and `prefix` gets the path
-to the subdirectory the command started from.  This allows you to
-convert a user-supplied pathname (typically relative to that directory)
-to a pathname relative to the top of the work tree.
-
-The return value from `cmd_foo()` becomes the exit status of the
-command.
diff --git a/builtin.h b/builtin.h
index 498ac80d0..51cb0249d 100644
--- a/builtin.h
+++ b/builtin.h
@@ -6,6 +6,82 @@
 #include "cache.h"
 #include "commit.h"
 
+/*
+builtin API
+===========
+
+Adding a new built-in
+---------------------
+
+There are 4 things to do to add a built-in command implementation to
+Git:
+
+. Define the implementation of the built-in command `foo` with
+  signature:
+
+	int cmd_foo(int argc, const char **argv, const char *prefix);
+
+. Add the external declaration for the function to `builtin.h`.
+
+. Add the command to the `commands[]` table defined in `git.c`.
+  The entry should look like:
+
+	{ "foo", cmd_foo, <options> },
++
+where options is the bitwise-or of:
+
+`RUN_SETUP`::
+	If there is not a Git directory to work on, abort.  If there
+	is a work tree, chdir to the top of it if the command was
+	invoked in a subdirectory.  If there is no work tree, no
+	chdir() is done.
+
+`RUN_SETUP_GENTLY`::
+	If there is a Git directory, chdir as per RUN_SETUP, otherwise,
+	don't chdir anywhere.
+
+`USE_PAGER`::
+
+	If the standard output is connected to a tty, spawn a pager and
+	feed our output to it.
+
+`NEED_WORK_TREE`::
+
+	Make sure there is a work tree, i.e. the command cannot act
+	on bare repositories.
+	This only makes sense when `RUN_SETUP` is also set.
+
+. Add `builtin/foo.o` to `BUILTIN_OBJS` in `Makefile`.
+
+Additionally, if `foo` is a new command, there are 3 more things to do:
+
+. Add tests to `t/` directory.
+
+. Write documentation in `Documentation/git-foo.txt`.
+
+. Add an entry for `git-foo` to `command-list.txt`.
+
+. Add an entry for `/git-foo` to `.gitignore`.
+
+
+How a built-in is called
+------------------------
+
+The implementation `cmd_foo()` takes three parameters, `argc`, `argv,
+and `prefix`.  The first two are similar to what `main()` of a
+standalone command would be called with.
+
+When `RUN_SETUP` is specified in the `commands[]` table, and when you
+were started from a subdirectory of the work tree, `cmd_foo()` is called
+after chdir(2) to the top of the work tree, and `prefix` gets the path
+to the subdirectory the command started from.  This allows you to
+convert a user-supplied pathname (typically relative to that directory)
+to a pathname relative to the top of the work tree.
+
+The return value from `cmd_foo()` becomes the exit status of the
+command.
+ */
+
 #define DEFAULT_MERGE_LOG_LEN 20
 
 extern const char git_usage_string[];
-- 
2.14.0.rc0

