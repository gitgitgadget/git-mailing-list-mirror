Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	T_DKIMWL_WL_MED shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 6F2521F404
	for <e@80x24.org>; Sun,  2 Sep 2018 21:38:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726991AbeICBzU (ORCPT <rfc822;e@80x24.org>);
        Sun, 2 Sep 2018 21:55:20 -0400
Received: from mail-oi0-f43.google.com ([209.85.218.43]:37556 "EHLO
        mail-oi0-f43.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726600AbeICBzU (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 2 Sep 2018 21:55:20 -0400
Received: by mail-oi0-f43.google.com with SMTP id p84-v6so30457887oic.4
        for <git@vger.kernel.org>; Sun, 02 Sep 2018 14:38:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=mintlab-nl.20150623.gappssmtp.com; s=20150623;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to;
        bh=mqEAgL5EZ5aiAxjIxBlXyMKdqTLcL3L/vy4tzH/t2wg=;
        b=UgMpDElEaZnoslO/mLkETPh+DVylo48GZoaGTqvcRbUtjWne/z18nuX4NfkjdBJqk+
         LhdYWMGFEJdbfOmM6417NG4danT7y4pEi3dcJqa9Hw12Ex+V/v+1yl8xgE/8Cww3ALNJ
         1D4A4Q6vYfFeUAgbcc0ENM6ysnba7M0vXNftXIpxsy0IoRCK3TW+XZ+BmDhAWYB2n7NM
         mhJHIndSQWqfgYM90zCCUURaoD2NGWwXVc7AXOdMXmtHN3HL20asVkCGtdD23ixPUhyq
         Gtxo6/AnntZxBLfA5D9FjnmB1MZxEzsbnCYXbmr2sRgwbWquMwHeanG5q1aGI835e/Il
         LR0g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to;
        bh=mqEAgL5EZ5aiAxjIxBlXyMKdqTLcL3L/vy4tzH/t2wg=;
        b=qitdWyKipRm6B8djFvlRbb3QcyXobLf6NvQdxLg49TPmhbX/jTv0oVhvGVyyliqOKl
         v09i10C/xeVa+8HbdAg46NcLeelyaiTnQCQmW/ZxlXibvgzbnQq46U2ewOO3uOFSI9sy
         +yomLmUDToogueEX693pMOPNspCgDzh52boO1UxzIAUGh3MAzKjKWf5+r/CuJCUOEtAw
         d+nqqJFCQ4OUzmOUkaR1cmyocaspA45tOR4xn06bWF5uvJcyrOeSXB4WnWHfMkSCRHK9
         yzAD+DadgwAi2l3PZG4LHslauIHyOHRlYk/efQmyS+i9fmvaBXaPVOArn5WEE7Xr3xYf
         EnHQ==
X-Gm-Message-State: APzg51BPYcLaFzefagjYObbkU8dnFmnHe60W+YDb8SyLkDW2Itb6b2ox
        iIHcXZuGhzIY01vZ0EZxZxaTYHJVJCZAgahS1yWoCGz2yS0=
X-Google-Smtp-Source: ANB0VdYE585v8vXZUZcaljUYD3n/WzL82P0LVOjzqNqbGMiqbOZh/O9cfG3evFCfnFs2siML9DO2ZOdsrB5EIU4NDgs=
X-Received: by 2002:aca:f105:: with SMTP id p5-v6mr13273274oih.342.1535924289093;
 Sun, 02 Sep 2018 14:38:09 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a4a:b149:0:0:0:0:0 with HTTP; Sun, 2 Sep 2018 14:38:08 -0700 (PDT)
In-Reply-To: <874lfad537.fsf@evledraar.gmail.com>
References: <CAEpdsiYHri8FJ8VohnwxmPwDM4-0J4J9Zb9wTZjYYRnYqsb=nA@mail.gmail.com>
 <87pnxzdib7.fsf@evledraar.gmail.com> <CAEpdsianZo+_+dunOvF=kK4w_qt_5RjA-o8+ySv70vRALZ3X2g@mail.gmail.com>
 <CAEpdsiZFMphQTdJnqFYH03M80W8CcrCbr2Uewktm0jy4D+Fz1A@mail.gmail.com> <874lfad537.fsf@evledraar.gmail.com>
From:   Wesley Schwengle <wesley@mintlab.nl>
Date:   Sun, 2 Sep 2018 23:38:08 +0200
Message-ID: <CAEpdsiZSNe6e5JvGF4UHaf5+3zBq61uJAgQ5YDSr1v4er7inhQ@mail.gmail.com>
Subject: Re: Feature request: hooks directory
To:     Git mailinglist <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi all,

I've made some progress with the hook.d implementation. It isn't
finished, as it is my first C project I'm still somewhat rocky with
how pointers and such work, but I'm getting somewhere. I haven't
broken any tests \o/.
 You have a nice testsuite btw. Feel free to comment on the code.

I've moved some of the hooks-code found in run-command.c to hooks.c

You can see the progress on gitlab: https://gitlab.com/waterkip/git
or on github: https://github.com/waterkip/git
The output of format-patch is down below.

I have some questions regarding the following two functions in run-command.c:
* run_hook_le
* run_hook_ve

What do the postfixes le and ve mean?

Cheers,
Wesley

format-patch:

From 129d8aff8257b22210beadc155cdbcae99b0fc4b Mon Sep 17 00:00:00 2001
From: Wesley Schwengle <wesley@schwengle.net>
Date: Sun, 2 Sep 2018 02:40:04 +0200
Subject: [PATCH] WIP: Add hook.d support in git

Add a generic mechanism to find and execute one or multiple hooks found
in $GIT_DIR/hooks/<hook> and/or $GIT_DIR/hooks/<hooks>.d/*

The API is as follows:

#include "hooks.h"

array hooks   = find_hooks('pre-receive');
int hooks_ran = run_hooks(hooks);

The implemented behaviour is:

* If we find a hooks/<hook>.d directory and the hooks.multiHook flag isn't
  set we make use of that directory.

* If we find a hooks/<hook>.d and we also have hooks/<hook> and the
  hooks.multiHook isn't set or set to false we don't use the hook.d
  directory. If the hook isn't set we issue a warning to the user
  telling him/her that we support multiple hooks via the .d directory
  structure

* If the hooks.multiHook is set to true we use the hooks/<hook> and all
  the entries found in hooks/<hook>.d

* All the scripts are executed and fail on the first error
---
 Makefile               |   1 +
 TODO-hooks.md          |  38 ++++++++++++
 builtin/am.c           |   4 +-
 builtin/commit.c       |   4 +-
 builtin/receive-pack.c |  10 +--
 builtin/worktree.c     |   3 +-
 cache.h                |   1 +
 config.c               |   5 ++
 environment.c          |   1 +
 hooks.c                | 134 +++++++++++++++++++++++++++++++++++++++++
 hooks.h                |  35 +++++++++++
 run-command.c          |  36 +----------
 run-command.h          |   6 --
 sequencer.c            |   7 ++-
 transport.c            |   3 +-
 15 files changed, 237 insertions(+), 51 deletions(-)
 create mode 100644 TODO-hooks.md
 create mode 100644 hooks.c
 create mode 100644 hooks.h

diff --git a/Makefile b/Makefile
index 5a969f583..f5eddf1d7 100644
--- a/Makefile
+++ b/Makefile
@@ -810,6 +810,7 @@ LIB_H = $(shell $(FIND) . \
  -name Documentation -prune -o \
  -name '*.h' -print)

+LIB_OBJS += hooks.o
 LIB_OBJS += abspath.o
 LIB_OBJS += advice.o
 LIB_OBJS += alias.o
diff --git a/TODO-hooks.md b/TODO-hooks.md
new file mode 100644
index 000000000..13b15bffb
--- /dev/null
+++ b/TODO-hooks.md
@@ -0,0 +1,38 @@
+# All hooks
+# See Documentation/githooks.txt for more information about each and every hook
+# that git knows about
+commit-msg
+fsmoninor-watchman
+p4-pre-submit
+post-applypatch
+post-checkout
+post-commit
+post-merge
+post-receive
+post-rewrite
+post-update
+pre-applypatch
+pre-auto-gc
+pre-commit
+pre-push
+pre-rebase
+pre-receive
+prepare-commit-msg
+push-to-checkout
+sendemail-validate
+update
+
+# builtin/receive-pack.c
+feed_recieve_hook
+find_hook
+find_receive_hook
+push_to_checkout_hook
+receive_hook_feed_state
+run_and_feed_hook
+run_hook_le
+run_receive_hook
+run_update_hook
+
+
+# run-command.c
+find_hook
diff --git a/builtin/am.c b/builtin/am.c
index 9f7ecf6ec..d1276dd47 100644
--- a/builtin/am.c
+++ b/builtin/am.c
@@ -34,6 +34,8 @@
 #include "packfile.h"
 #include "repository.h"

+#include "hooks.h"
+
 /**
  * Returns 1 if the file is empty or does not exist, 0 otherwise.
  */
@@ -509,7 +511,7 @@ static int run_applypatch_msg_hook(struct am_state *state)
 static int run_post_rewrite_hook(const struct am_state *state)
 {
  struct child_process cp = CHILD_PROCESS_INIT;
- const char *hook = find_hook("post-rewrite");
+ const char *hook = find_hooks("post-rewrite");
  int ret;

  if (!hook)
diff --git a/builtin/commit.c b/builtin/commit.c
index 0d9828e29..389224d66 100644
--- a/builtin/commit.c
+++ b/builtin/commit.c
@@ -34,6 +34,8 @@
 #include "mailmap.h"
 #include "help.h"

+#include "hooks.h"
+
 static const char * const builtin_commit_usage[] = {
  N_("git commit [<options>] [--] <pathspec>..."),
  NULL
@@ -932,7 +934,7 @@ static int prepare_to_commit(const char
*index_file, const char *prefix,
  return 0;
  }

- if (!no_verify && find_hook("pre-commit")) {
+ if (!no_verify && find_hooks("pre-commit")) {
  /*
  * Re-read the index as pre-commit hook could have updated it,
  * and write it out as a tree.  We must do this before we invoke
diff --git a/builtin/receive-pack.c b/builtin/receive-pack.c
index c17ce94e1..dd10ef4af 100644
--- a/builtin/receive-pack.c
+++ b/builtin/receive-pack.c
@@ -28,6 +28,8 @@
 #include "object-store.h"
 #include "protocol.h"

+#include "hooks.h"
+
 static const char * const receive_pack_usage[] = {
  N_("git receive-pack <git-dir>"),
  NULL
@@ -685,7 +687,7 @@ static int run_and_feed_hook(const char
*hook_name, feed_fn feed,
  const char *argv[2];
  int code;

- argv[0] = find_hook(hook_name);
+ argv[0] = find_hooks(hook_name);
  if (!argv[0])
  return 0;

@@ -794,7 +796,7 @@ static int run_update_hook(struct command *cmd)
  struct child_process proc = CHILD_PROCESS_INIT;
  int code;

- argv[0] = find_hook("update");
+ argv[0] = find_hooks("update");
  if (!argv[0])
  return 0;

@@ -1008,7 +1010,7 @@ static const char *update_worktree(unsigned char *sha1)

  argv_array_pushf(&env, "GIT_DIR=%s", absolute_path(get_git_dir()));

- if (!find_hook(push_to_checkout_hook))
+ if (!find_hooks(push_to_checkout_hook))
  retval = push_to_deploy(sha1, &env, work_tree);
  else
  retval = push_to_checkout(sha1, &env, work_tree);
@@ -1167,7 +1169,7 @@ static void run_update_post_hook(struct command *commands)
  struct child_process proc = CHILD_PROCESS_INIT;
  const char *hook;

- hook = find_hook("post-update");
+ hook = find_hooks("post-update");
  if (!hook)
  return;

diff --git a/builtin/worktree.c b/builtin/worktree.c
index 41e771439..93fd4c175 100644
--- a/builtin/worktree.c
+++ b/builtin/worktree.c
@@ -12,6 +12,7 @@
 #include "refs.h"
 #include "utf8.h"
 #include "worktree.h"
+#include "hooks.h"

 static const char * const worktree_usage[] = {
  N_("git worktree add [<options>] <path> [<commit-ish>]"),
@@ -344,7 +345,7 @@ static int add_worktree(const char *path, const
char *refname,
  * is_junk is cleared, but do return appropriate code when hook fails.
  */
  if (!ret && opts->checkout) {
- const char *hook = find_hook("post-checkout");
+ const char *hook = find_hooks("post-checkout");
  if (hook) {
  const char *env[] = { "GIT_DIR", "GIT_WORK_TREE", NULL };
  cp.git_cmd = 0;
diff --git a/cache.h b/cache.h
index 4d014541a..04cb06bba 100644
--- a/cache.h
+++ b/cache.h
@@ -837,6 +837,7 @@ extern int quote_path_fully;
 extern int has_symlinks;
 extern int minimum_abbrev, default_abbrev;
 extern int ignore_case;
+extern int hookd_enabled;
 extern int assume_unchanged;
 extern int prefer_symlink_refs;
 extern int warn_ambiguous_refs;
diff --git a/config.c b/config.c
index 3461993f0..07a073ab9 100644
--- a/config.c
+++ b/config.c
@@ -1491,6 +1491,11 @@ int git_default_config(const char *var, const
char *value, void *dummy)
  pack_compression_seen = 1;
  return 0;
  }
+ if (!strcmp(var, "hooks.multihook")) {
+ hookd_enabled = git_config_bool(var, value);
+ return 0;
+ }
+

  /* Add other config variables here and to Documentation/config.txt. */
  return 0;
diff --git a/environment.c b/environment.c
index 3f3c8746c..27569e671 100644
--- a/environment.c
+++ b/environment.c
@@ -73,6 +73,7 @@ int precomposed_unicode = -1; /* see
probe_utf8_pathname_composition() */
 unsigned long pack_size_limit_cfg;
 enum hide_dotfiles_type hide_dotfiles = HIDE_DOTFILES_DOTGITONLY;
 enum log_refs_config log_all_ref_updates = LOG_REFS_UNSET;
+int hookd_enabled = -1;

 #ifndef PROTECT_HFS_DEFAULT
 #define PROTECT_HFS_DEFAULT 0
diff --git a/hooks.c b/hooks.c
new file mode 100644
index 000000000..d2950a2da
--- /dev/null
+++ b/hooks.c
@@ -0,0 +1,134 @@
+#include "hooks.h"
+#include "cache.h"
+#include "run-command.h"
+#include "string-list.h"
+#include "config.h"
+
+//#include <sys/types.h>
+//#include <sys/stat.h>
+//#include <sys/sysmacros.h>
+
+static const char *_get_hook(struct strbuf *path)
+{
+ char *name = path->buf;
+ int err;
+ if (access(name, X_OK) >= 0) {
+ return name;
+ }
+ err = errno;
+
+// Check for .exe
+#ifdef STRIP_EXTENSION
+ strbuf_addstr(path, STRIP_EXTENSION);
+ name = path->buf;
+ if (access(name, X_OK) >= 0)
+ return name;
+ if (errno == EACCES)
+ err = errno;
+#endif
+
+ if (err == EACCES && advice_ignored_hook) {
+ static struct string_list advise_given = STRING_LIST_INIT_DUP;
+
+ if (!string_list_lookup(&advise_given, name)) {
+ string_list_insert(&advise_given, name);
+ advise(_("The '%s' hook was ignored because "
+ "it's not set as executable.\n"
+ "You can disable this warning with "
+ "`git config advice.ignoredHook false`."),
+        name);
+ }
+ }
+ return NULL;
+}
+
+static void get_hooks_from_directory(const char *name, struct
string_list *list)
+{
+
+ struct strbuf path = STRBUF_INIT;
+ strbuf_git_path(&path, "hooks/%s.d", name);
+
+ struct dirent *de;
+ DIR *hooksd_dir;
+ static struct strbuf hooksd_script = STRBUF_INIT;
+
+ if ((hooksd_dir = opendir(path.buf)) == NULL) {
+ return;
+ }
+
+ while ((de = readdir(hooksd_dir)) != NULL) {
+ struct stat stbuf;
+
+ strbuf_reset(&hooksd_script);
+ strbuf_addf(&hooksd_script, "%s/%s", path.buf, de->d_name);
+
+ if (stat(hooksd_script.buf, &stbuf) == -1) {
+ continue;
+ }
+ else if ((stbuf.st_mode & S_IFMT) == S_IFDIR) {
+ continue;
+ }
+
+ const char *hook = _get_hook(&hooksd_script);
+ if (hook) {
+ //printf("Found hook script %s\n", hook);
+ string_list_append(list, hook);
+ }
+
+ strbuf_release(&hooksd_script);
+ }
+
+ strbuf_release(&hooksd_script);
+ strbuf_release(&path);
+ return;
+}
+
+//const struct string_list *find_hooks(const char *name)
+const char *find_hooks(const char *name)
+{
+
+ struct string_list list = STRING_LIST_INIT_NODUP;
+ const char *hook_path;
+
+ struct strbuf path = STRBUF_INIT;
+ strbuf_git_path(&path, "hooks/%s", name);
+
+ hook_path = _get_hook(&path);
+
+ if (hook_path) {
+ string_list_append(&list, hook_path);
+ }
+
+ if (hookd_enabled == 1) {
+ get_hooks_from_directory(name, &list);
+
+ if (hook_path)
+ return hook_path;
+ return NULL;
+ }
+ else if (hookd_enabled == 0) {
+ if (hook_path)
+ return hook_path;
+ return NULL;
+ }
+ else {
+ static struct string_list advise_given = STRING_LIST_INIT_DUP;
+
+ get_hooks_from_directory(name, &list);
+ if (   hook_path && list.nr > 1
+     && !string_list_lookup(&advise_given, name)) {
+ string_list_insert(&advise_given, name);
+ advise(_("You have a hook plus hook.d dir for %s. This"
+ " behaviour is now supported by git.\nYou can"
+ " disable this warning with `git config"
+ " hooks.multiHook false` to disable reading\n"
+ "the hook.d directory or run `git config"
+ " hooks.multiHook true` to enable the\nhook.d"
+ " directory. Ignoring the hook.d directory"
+ " for now"), name);
+ }
+ if (hook_path)
+ return hook_path;
+ return NULL;
+ }
+}
diff --git a/hooks.h b/hooks.h
new file mode 100644
index 000000000..278d63344
--- /dev/null
+++ b/hooks.h
@@ -0,0 +1,35 @@
+#ifndef HOOKS_H
+#define HOOKS_H
+
+#ifndef NO_PTHREADS
+#include <pthread.h>
+#endif
+/*
+ * Returns all the hooks found in either
+ * $GIT_DIR/hooks/$hook and/or $GIT_DIR/hooks/$hook.d/
+ *
+ * Note that this points to static storage that will be
+ * overwritten by further calls to find_hooks and run_hook_*.
+ */
+//extern const struct string_list *find_hooks(const char *name);
+extern const char *find_hooks(const char *name);
+
+/* Unsure what this does/is/etc */
+//LAST_ARG_MUST_BE_NULL
+
+/*
+ * Run all the runnable hooks found in
+ * $GIT_DIR/hooks/$hook and/or $GIT_DIR/hooks/$hook.d/
+ *
+ */
+//extern int run_hooks_le(const char *const *env, const char *name, ...);
+//extern int run_hooks_ve(const char *const *env, const char *name,
va_list args);
+
+#endif
+
+/* Workings of hooks
+ *
+ * array_of_hooks      = find_hooks(name);
+ * number_of_hooks_ran = run_hooks(array_of_hooks);
+ *
+ */
diff --git a/run-command.c b/run-command.c
index 84b883c21..6b57147fa 100644
--- a/run-command.c
+++ b/run-command.c
@@ -7,6 +7,7 @@
 #include "strbuf.h"
 #include "string-list.h"
 #include "quote.h"
+#include "hooks.h"

 void child_process_init(struct child_process *child)
 {
@@ -1246,46 +1247,13 @@ int finish_async(struct async *async)
 #endif
 }

-const char *find_hook(const char *name)
-{
- static struct strbuf path = STRBUF_INIT;
-
- strbuf_reset(&path);
- strbuf_git_path(&path, "hooks/%s", name);
- if (access(path.buf, X_OK) < 0) {
- int err = errno;
-
-#ifdef STRIP_EXTENSION
- strbuf_addstr(&path, STRIP_EXTENSION);
- if (access(path.buf, X_OK) >= 0)
- return path.buf;
- if (errno == EACCES)
- err = errno;
-#endif
-
- if (err == EACCES && advice_ignored_hook) {
- static struct string_list advise_given = STRING_LIST_INIT_DUP;
-
- if (!string_list_lookup(&advise_given, name)) {
- string_list_insert(&advise_given, name);
- advise(_("The '%s' hook was ignored because "
- "it's not set as executable.\n"
- "You can disable this warning with "
- "`git config advice.ignoredHook false`."),
-        path.buf);
- }
- }
- return NULL;
- }
- return path.buf;
-}

 int run_hook_ve(const char *const *env, const char *name, va_list args)
 {
  struct child_process hook = CHILD_PROCESS_INIT;
  const char *p;

- p = find_hook(name);
+ p = find_hooks(name);
  if (!p)
  return 0;

diff --git a/run-command.h b/run-command.h
index 3932420ec..3009e49b1 100644
--- a/run-command.h
+++ b/run-command.h
@@ -58,12 +58,6 @@ int finish_command(struct child_process *);
 int finish_command_in_signal(struct child_process *);
 int run_command(struct child_process *);

-/*
- * Returns the path to the hook file, or NULL if the hook is missing
- * or disabled. Note that this points to static storage that will be
- * overwritten by further calls to find_hook and run_hook_*.
- */
-extern const char *find_hook(const char *name);
 LAST_ARG_MUST_BE_NULL
 extern int run_hook_le(const char *const *env, const char *name, ...);
 extern int run_hook_ve(const char *const *env, const char *name, va_list args);
diff --git a/sequencer.c b/sequencer.c
index 84bf598c3..dfa58fae1 100644
--- a/sequencer.c
+++ b/sequencer.c
@@ -30,6 +30,7 @@
 #include "oidset.h"
 #include "commit-slab.h"
 #include "alias.h"
+#include "hooks.h"

 #define GIT_REFLOG_ACTION "GIT_REFLOG_ACTION"

@@ -996,7 +997,7 @@ static int run_rewrite_hook(const struct object_id *oldoid,
  int code;
  struct strbuf sb = STRBUF_INIT;

- argv[0] = find_hook("post-rewrite");
+ argv[0] = find_hooks("post-rewrite");
  if (!argv[0])
  return 0;

@@ -1265,7 +1266,7 @@ static int try_to_commit(struct strbuf *msg,
const char *author,
  goto out;
  }

- if (find_hook("prepare-commit-msg")) {
+ if (find_hooks("prepare-commit-msg")) {
  res = run_prepare_commit_msg_hook(msg, hook_commit);
  if (res)
  goto out;
@@ -3496,7 +3497,7 @@ static int pick_commits(struct todo_list
*todo_list, struct replay_opts *opts)
  st.st_size > 0) {
  struct child_process child = CHILD_PROCESS_INIT;
  const char *post_rewrite_hook =
- find_hook("post-rewrite");
+ find_hooks("post-rewrite");

  child.in = open(rebase_path_rewritten_list(), O_RDONLY);
  child.git_cmd = 1;
diff --git a/transport.c b/transport.c
index 06ffea277..a2930f4fd 100644
--- a/transport.c
+++ b/transport.c
@@ -22,6 +22,7 @@
 #include "protocol.h"
 #include "object-store.h"
 #include "color.h"
+#include "hooks.h"

 static int transport_use_color = -1;
 static char transport_colors[][COLOR_MAXLEN] = {
@@ -1019,7 +1020,7 @@ static int run_pre_push_hook(struct transport *transport,
  struct strbuf buf;
  const char *argv[4];

- if (!(argv[0] = find_hook("pre-push")))
+ if (!(argv[0] = find_hooks("pre-push")))
  return 0;

  argv[1] = transport->remote->name;

-- 
Wesley Schwengle, Developer
Mintlab B.V., https://www.zaaksysteem.nl
E: wesley@mintlab.nl
T:  +31 20 737 00 05
