Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id A5E4B20248
	for <e@80x24.org>; Wed, 10 Apr 2019 17:37:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729641AbfDJRhx (ORCPT <rfc822;e@80x24.org>);
        Wed, 10 Apr 2019 13:37:53 -0400
Received: from mail-ed1-f65.google.com ([209.85.208.65]:46604 "EHLO
        mail-ed1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729055AbfDJRhx (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 10 Apr 2019 13:37:53 -0400
Received: by mail-ed1-f65.google.com with SMTP id d1so2758368edd.13
        for <git@vger.kernel.org>; Wed, 10 Apr 2019 10:37:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:message-id:in-reply-to:references:from:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=QBNY+zM+g0Jzt9KVZ0RFyjAcM0/7a17ywCCrd1K+glM=;
        b=VZVulx1OhQF3owETkn4X3KxnmWE8Fmk6JA2AsZA5ndDDERDP85Vck9a0/LOg0K25QG
         hS0vWQyk+6yYQkGz6YMujid8hQKzFoyazcDNp2lXjsmzNRFMBEpVChE0wwk8OStGUTlV
         4DGPrGGTu7xc3qfus1OmdROzfSfjN3dN1om9xHqBPE9SzAPH3Unkz+orsoVFo+K3JgfH
         9KkVQ9vLLe2eb8oUZlqQ1u6nwLapBbmjoOYS84sQPDP+aLVd1f5OZG+b+gpJAy7KgUJn
         kPbXnsqTf9Qbuz8UJ7Zg2mmyZ2XNPzwyKWYXfEWw6gMloxgeIPtNCfkKYTAXdrgC5gGc
         9w6w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:message-id:in-reply-to:references:from
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=QBNY+zM+g0Jzt9KVZ0RFyjAcM0/7a17ywCCrd1K+glM=;
        b=NkvJtRx6UUdIOZri7s+uYYaArD9ReEMuKPgSdZRTrAS9uUr5nSiWIEBScozyi5GuTY
         8IWgqbke6yiRvMUuK9GX+3DrGJDRjvr6lN+vVulc/Cj5DtcDrZMUrYY2XcdjsqmsumoC
         FhpkpVP5Sa+r/z3NSwP5mUAueF68jqhjHWZmOnyVw1eqeikTWmEnqqyFAqUArBH7G0wU
         PhdobWE+Fyprs0/jz55j80EbyTG5PLNYuMEapjRrtffUwFzux3aJEcL7Z6WvPHOpbBLX
         O/ShDAzOuBLtORgu/Ccg1gqf6VIkb52McnQWrQQpSD5hhx/PFdKGtXF2lzwUG4fjuOPN
         HfYw==
X-Gm-Message-State: APjAAAXfY1JL+i8x93jf0lAPXZEQRzHTfur0Jm/w3bAEOpvDEl3ggXcJ
        cCtiJj9UOGS+PprD8w+YMAPgwOca
X-Google-Smtp-Source: APXvYqyw2CjLBD1sEmAfMa8GdIthonzy7udEXZNc3H8sQOtDA3qrw6mYE0yPBp3rqPeb/VDdWUe+sQ==
X-Received: by 2002:aa7:d3d8:: with SMTP id o24mr28635737edr.53.1554917871024;
        Wed, 10 Apr 2019 10:37:51 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id c7sm10464206edt.70.2019.04.10.10.37.50
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 10 Apr 2019 10:37:50 -0700 (PDT)
Date:   Wed, 10 Apr 2019 10:37:50 -0700 (PDT)
X-Google-Original-Date: Wed, 10 Apr 2019 17:37:38 GMT
Message-Id: <12978dc248a2cd07c90559691b8a2add84f45394.1554917868.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.170.git.gitgitgadget@gmail.com>
References: <pull.170.git.gitgitgadget@gmail.com>
From:   "Johannes Schindelin via GitGitGadget" <gitgitgadget@gmail.com>
Subject: [PATCH 01/11] Start to implement a built-in version of `git add
 --interactive`
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        Johannes Schindelin <johannes.schindelin@gmx.de>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Johannes Schindelin <johannes.schindelin@gmx.de>

This is hardly the first conversion of a Git command that is implemented
as a script to a built-in. So far, the most successful strategy for such
conversions has been to add a built-in helper and call that for more and
more functionality from the script, as more and more parts are
converted.

With the interactive add, we choose a different strategy. The sole
reason for this is that on Windows (where such a conversion has the most
benefits in terms of speed and robustness) we face the very specific
problem that a `system()` call in Perl seems to close `stdin` in the
parent process when the spawned process consumes even one character from
`stdin`. And that just does not work for us here, as it would stop the
main loop as soon as any interactive command was performed by the
helper. Which is almost all of the commands in `git add -i`.

It is almost as if Perl told us once again that it does not want us to
use it on Windows.

Instead, we follow the opposite route where we start with a bare-bones
version of the built-in interactive add, guarded by the new
`add.interactive.useBuiltin` config variable, and then add more and more
functionality to it, until it is feature complete.

At this point, the built-in version of `git add -i` only states that it
cannot do anything yet ;-)

Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
---
 Documentation/config/add.txt |  5 +++++
 Makefile                     |  1 +
 add-interactive.c            | 13 +++++++++++++
 add-interactive.h            | 10 ++++++++++
 builtin/add.c                | 16 +++++++++++++++-
 t/README                     |  4 ++++
 6 files changed, 48 insertions(+), 1 deletion(-)
 create mode 100644 add-interactive.c
 create mode 100644 add-interactive.h

diff --git a/Documentation/config/add.txt b/Documentation/config/add.txt
index 4d753f006e..c9f748f81c 100644
--- a/Documentation/config/add.txt
+++ b/Documentation/config/add.txt
@@ -5,3 +5,8 @@ add.ignore-errors (deprecated)::
 	option of linkgit:git-add[1].  `add.ignore-errors` is deprecated,
 	as it does not follow the usual naming convention for configuration
 	variables.
+
+add.interactive.useBuiltin::
+	[EXPERIMENTAL] Set to `true` to use the experimental built-in
+	implementation of the interactive version of linkgit:git-add[1]
+	instead of the Perl script version. Is `false` by default.
diff --git a/Makefile b/Makefile
index c5240942f2..18e656a32f 100644
--- a/Makefile
+++ b/Makefile
@@ -848,6 +848,7 @@ LIB_H = $(shell $(FIND) . \
 	-name '*.h' -print)
 
 LIB_OBJS += abspath.o
+LIB_OBJS += add-interactive.o
 LIB_OBJS += advice.o
 LIB_OBJS += alias.o
 LIB_OBJS += alloc.o
diff --git a/add-interactive.c b/add-interactive.c
new file mode 100644
index 0000000000..540bf185d8
--- /dev/null
+++ b/add-interactive.c
@@ -0,0 +1,13 @@
+#include "cache.h"
+#include "add-interactive.h"
+#include "config.h"
+
+int add_i_config(const char *var, const char *value, void *cb)
+{
+	return git_default_config(var, value, cb);
+}
+
+int run_add_i(struct repository *r, const struct pathspec *ps)
+{
+	die(_("No commands are available in the built-in `git add -i` yet!"));
+}
diff --git a/add-interactive.h b/add-interactive.h
new file mode 100644
index 0000000000..e6e6e051eb
--- /dev/null
+++ b/add-interactive.h
@@ -0,0 +1,10 @@
+#ifndef ADD_INTERACTIVE_H
+#define ADD_INTERACTIVE_H
+
+int add_i_config(const char *var, const char *value, void *cb);
+
+struct repository;
+struct pathspec;
+int run_add_i(struct repository *r, const struct pathspec *ps);
+
+#endif
diff --git a/builtin/add.c b/builtin/add.c
index db2dfa4350..5a32a755c8 100644
--- a/builtin/add.c
+++ b/builtin/add.c
@@ -20,6 +20,7 @@
 #include "bulk-checkin.h"
 #include "argv-array.h"
 #include "submodule.h"
+#include "add-interactive.h"
 
 static const char * const builtin_add_usage[] = {
 	N_("git add [<options>] [--] <pathspec>..."),
@@ -28,6 +29,7 @@ static const char * const builtin_add_usage[] = {
 static int patch_interactive, add_interactive, edit_interactive;
 static int take_worktree_changes;
 static int add_renormalize;
+static int use_builtin_add_i;
 
 struct update_callback_data {
 	int flags;
@@ -186,6 +188,9 @@ int run_add_interactive(const char *revision, const char *patch_mode,
 	int status, i;
 	struct argv_array argv = ARGV_ARRAY_INIT;
 
+	if (use_builtin_add_i && !patch_mode)
+		return !!run_add_i(the_repository, pathspec);
+
 	argv_array_push(&argv, "add--interactive");
 	if (patch_mode)
 		argv_array_push(&argv, patch_mode);
@@ -319,7 +324,12 @@ static int add_config(const char *var, const char *value, void *cb)
 		ignore_add_errors = git_config_bool(var, value);
 		return 0;
 	}
-	return git_default_config(var, value, cb);
+	if (!strcmp(var, "add.interactive.usebuiltin")) {
+		use_builtin_add_i = git_config_bool(var, value);
+		return 0;
+	}
+
+	return add_i_config(var, value, cb);
 }
 
 static const char embedded_advice[] = N_(
@@ -394,8 +404,12 @@ int cmd_add(int argc, const char **argv, const char *prefix)
 	int require_pathspec;
 	char *seen = NULL;
 	struct lock_file lock_file = LOCK_INIT;
+	int use_builtin_add_i_env =
+		git_env_bool("GIT_TEST_ADD_I_USE_BUILTIN", -1);
 
 	git_config(add_config, NULL);
+	if (use_builtin_add_i_env >= 0)
+		use_builtin_add_i = use_builtin_add_i_env;
 
 	argc = parse_options(argc, argv, prefix, builtin_add_options,
 			  builtin_add_usage, PARSE_OPT_KEEP_ARGV0);
diff --git a/t/README b/t/README
index 886bbec5bc..6408a1847e 100644
--- a/t/README
+++ b/t/README
@@ -383,6 +383,10 @@ GIT_TEST_REBASE_USE_BUILTIN=<boolean>, when false, disables the
 builtin version of git-rebase. See 'rebase.useBuiltin' in
 git-config(1).
 
+GIT_TEST_ADD_I_USE_BUILTIN=<boolean>, when true, enables the
+builtin version of git add -i. See 'add.interactive.useBuiltin' in
+git-config(1).
+
 GIT_TEST_INDEX_THREADS=<n> enables exercising the multi-threaded loading
 of the index for the whole test suite by bypassing the default number of
 cache entries and thread minimums. Setting this to 1 will make the
-- 
gitgitgadget

