Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 2A63020899
	for <e@80x24.org>; Wed,  2 Aug 2017 19:41:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751925AbdHBTlN (ORCPT <rfc822;e@80x24.org>);
        Wed, 2 Aug 2017 15:41:13 -0400
Received: from mail-wr0-f194.google.com ([209.85.128.194]:38546 "EHLO
        mail-wr0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751879AbdHBTlM (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 2 Aug 2017 15:41:12 -0400
Received: by mail-wr0-f194.google.com with SMTP id g32so84156wrd.5
        for <git@vger.kernel.org>; Wed, 02 Aug 2017 12:41:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=JneeuiZhh6/5u3pl/o8rX0+IGqKncGY9wPyV8vE3m3A=;
        b=POOZa+/dbbaHyRrvggetH17ajmD5RtWVsXOG0zaPBDkxLHzH3bzsbnhAyQ6v8nQZSb
         i5626JTTP+jGuli3XzMQlxjGVD2jt/NLPO/GA+zxpxirPyVkw1HikLTDxRmtw0GY6Zbn
         XueBzrW+sHZ0afU1J7RTF9fm4lS29Qw2kDXqgSrMpcIm3VAq9fq2TjZkCcg9v5aFJUFF
         Xu+Vs0oAxsyG/aywQiCKlPZxwKZeKVOcbGL/B4gi9ASgqc/BSVLRqmbolrPAh1mGeq1e
         yytNbPY+L/9+iBj44RHFXNBbGqJyDHlVlWAfh1b9yfw5GWB2ChK5mzBfuk5N7VKVz0ys
         kCvw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=JneeuiZhh6/5u3pl/o8rX0+IGqKncGY9wPyV8vE3m3A=;
        b=k0eNYXrAkwaBamPmcd1Dage7t3u7I+Jmj1/yzJXs9qSsqo5TEPHjUZfEOCZVGYAuea
         4VjiJV2u63oFgakJ8w2GKyO28W46iImd62dW5P2N7GzyJv9DazG9tCMeu1dzuCljxPMS
         gL3l5Z6Tstz4dL9pfDfmgv9uPvIij6nIeU4RObHF2ALTtxcnNOOthqTSKqA8GZhCTstE
         3RyiIkCTf94ff3Vc4DDyF9CUEVB8CFn3uhCgKgpk0sqbNW1DawvXtG1rg3r7lkTcYM0o
         f/iH6eFc0xzaV6AqQl9u4OCqnl+9wBkjaP4gCrD23SKyixAFyvVURITf0GQ2bdoYy3hs
         qylA==
X-Gm-Message-State: AIVw11196CHdnTWqNdTciFQkax6oJ0jgp3qGb1qjWrqVvqE9DqVUuVs/
        OJznp70oXVj12KUF
X-Received: by 10.223.178.212 with SMTP id g78mr17996132wrd.144.1501702870835;
        Wed, 02 Aug 2017 12:41:10 -0700 (PDT)
Received: from localhost.localdomain ([2a02:aa16:5782:c100:1208:b1ff:fee6:d811])
        by smtp.gmail.com with ESMTPSA id t13sm103576wra.22.2017.08.02.12.41.09
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Wed, 02 Aug 2017 12:41:10 -0700 (PDT)
From:   =?UTF-8?q?Martin=20=C3=85gren?= <martin.agren@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>
Subject: [PATCH v3 1/7] builtin.h: take over documentation from api-builtin.txt
Date:   Wed,  2 Aug 2017 21:40:49 +0200
Message-Id: <e660a9cdaff6d114305a475f9a12876b56b473d1.1501701128.git.martin.agren@gmail.com>
X-Mailer: git-send-email 2.14.0.rc1.12.ge2d9c4613
In-Reply-To: <cover.1501701128.git.martin.agren@gmail.com>
References: <cover.1500321657.git.martin.agren@gmail.com> <cover.1501701128.git.martin.agren@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Delete Documentation/technical/api-builtin.txt and move its content
into builtin.h. Format it as a comment. Remove a '+' which was needed
when the information was formatted for AsciiDoc. Similarly, change
"::" to ":".

Document SUPPORT_SUPER_PREFIX, thereby bringing the documentation up to
date with the available flags.

While at it, correct '3 more things to do' to '4 more things to do'.

Signed-off-by: Martin Ågren <martin.agren@gmail.com>
---
I'm still documenting SUPPORT_SUPER_PREFIX. As Junio pointed out, a
nearby patch series is working on losing it (or one user of it). I tried
removing that part, but felt like I was leaving things incomplete.

 Documentation/technical/api-builtin.txt | 73 ------------------------------
 builtin.h                               | 80 +++++++++++++++++++++++++++++++++
 2 files changed, 80 insertions(+), 73 deletions(-)
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
index 498ac80d0..8d87d06da 100644
--- a/builtin.h
+++ b/builtin.h
@@ -6,6 +6,86 @@
 #include "cache.h"
 #include "commit.h"
 
+/*
+ * builtin API
+ * ===========
+ *
+ * Adding a new built-in
+ * ---------------------
+ *
+ * There are 4 things to do to add a built-in command implementation to
+ * Git:
+ *
+ * . Define the implementation of the built-in command `foo` with
+ *   signature:
+ *
+ *	int cmd_foo(int argc, const char **argv, const char *prefix);
+ *
+ * . Add the external declaration for the function to `builtin.h`.
+ *
+ * . Add the command to the `commands[]` table defined in `git.c`.
+ *   The entry should look like:
+ *
+ *	{ "foo", cmd_foo, <options> },
+ *
+ * where options is the bitwise-or of:
+ *
+ * `RUN_SETUP`:
+ *	If there is not a Git directory to work on, abort.  If there
+ *	is a work tree, chdir to the top of it if the command was
+ *	invoked in a subdirectory.  If there is no work tree, no
+ *	chdir() is done.
+ *
+ * `RUN_SETUP_GENTLY`:
+ *	If there is a Git directory, chdir as per RUN_SETUP, otherwise,
+ *	don't chdir anywhere.
+ *
+ * `USE_PAGER`:
+ *
+ *	If the standard output is connected to a tty, spawn a pager and
+ *	feed our output to it.
+ *
+ * `NEED_WORK_TREE`:
+ *
+ *	Make sure there is a work tree, i.e. the command cannot act
+ *	on bare repositories.
+ *	This only makes sense when `RUN_SETUP` is also set.
+ *
+ * `SUPPORT_SUPER_PREFIX`:
+ *
+ *	The built-in supports `--super-prefix`.
+ *
+ * . Add `builtin/foo.o` to `BUILTIN_OBJS` in `Makefile`.
+ *
+ * Additionally, if `foo` is a new command, there are 4 more things to do:
+ *
+ * . Add tests to `t/` directory.
+ *
+ * . Write documentation in `Documentation/git-foo.txt`.
+ *
+ * . Add an entry for `git-foo` to `command-list.txt`.
+ *
+ * . Add an entry for `/git-foo` to `.gitignore`.
+ *
+ *
+ * How a built-in is called
+ * ------------------------
+ *
+ * The implementation `cmd_foo()` takes three parameters, `argc`, `argv,
+ * and `prefix`.  The first two are similar to what `main()` of a
+ * standalone command would be called with.
+ *
+ * When `RUN_SETUP` is specified in the `commands[]` table, and when you
+ * were started from a subdirectory of the work tree, `cmd_foo()` is called
+ * after chdir(2) to the top of the work tree, and `prefix` gets the path
+ * to the subdirectory the command started from.  This allows you to
+ * convert a user-supplied pathname (typically relative to that directory)
+ * to a pathname relative to the top of the work tree.
+ *
+ * The return value from `cmd_foo()` becomes the exit status of the
+ * command.
+ */
+
 #define DEFAULT_MERGE_LOG_LEN 20
 
 extern const char git_usage_string[];
-- 
2.14.0.rc1.12.ge2d9c4613

