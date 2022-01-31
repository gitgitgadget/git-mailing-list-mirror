Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7AA83C433EF
	for <git@archiver.kernel.org>; Mon, 31 Jan 2022 22:08:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231454AbiAaWH7 (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 31 Jan 2022 17:07:59 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58326 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231462AbiAaWHz (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 31 Jan 2022 17:07:55 -0500
Received: from mail-wr1-x42b.google.com (mail-wr1-x42b.google.com [IPv6:2a00:1450:4864:20::42b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5ABC0C06173B
        for <git@vger.kernel.org>; Mon, 31 Jan 2022 14:07:55 -0800 (PST)
Received: by mail-wr1-x42b.google.com with SMTP id e8so28227586wrc.0
        for <git@vger.kernel.org>; Mon, 31 Jan 2022 14:07:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:in-reply-to:references:from:date:subject:mime-version
         :content-transfer-encoding:fcc:to:cc;
        bh=pz4l60nqjTP/xK3XTg6XqoLscYS+trH9OCEOGty2PVc=;
        b=nygXvU2bJ+ia0xhyLuhLt2jTVutrWRtt3nQhHTR16PBfwR9nPF7YaOrNvz2Fnhm2yS
         qtIVH8E2uCVlXKv9U1Xf3P9PtpLb1cnQX2aEETc2sUTvRc2R2RegCihctPEsYtEKJfdL
         TddU1zg9/5Om0D5pvIC9v18mHUzNJllvwRug3TtaATPzPsDzwFCk97X/63i2jkGCQXMt
         W66ln7w7rHMEXg9ZV/lnJlsXCnh9uVDuAC87pMRlhjUyiGjkOcehHSisxXLTUfa0A949
         4pvqg1fjg5iL6J5E92UF10rGr3df/HxqoQvYWrqzRUXCjX7/Z7+xpgkCiudjAoXFGdVg
         IOcw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:mime-version:content-transfer-encoding:fcc:to:cc;
        bh=pz4l60nqjTP/xK3XTg6XqoLscYS+trH9OCEOGty2PVc=;
        b=3XwDXqJfffFu1gZXznm2kiS4sMJQAg16K5ISBqi37FEBeb7zlMIciMuFTpkxbptFEw
         Hp/tcAaxrcQ/CGHVAi1ylC6IBXQH3gvE9AJCyzsvbB+wUbXIj3ynzkPfdYw3/MRQGHts
         KnStsL2Uy1cutkgkZtoZVS2/2FxjjViOtdGrtmv/RWt+//3izx670p8W889ZAMvw1bXB
         LMYu4U+AlUgbA9yWigIDUtrNO/XS7JQNgPk1dWtdUtD1VnFbWZxJ0w25I4EoRwN4zarw
         3Vvi/ZxAwnb5bsV/XgnhLHf79Xn5ktiFrcHhHUmQN8O9Yhe8vhdsslwqkLUrAEwlbanM
         1iKw==
X-Gm-Message-State: AOAM532sn85ISj5yyIRIedkE0T7ClV/P0Mg9ioC6N/Kaaa0c6Hk51/LO
        JztBOqW4LAePu7PJ10kclXiLHcILPro=
X-Google-Smtp-Source: ABdhPJzINdr9dG0SB2hPEC+W6njsSSwxaq4Sc6gtWCoHfRsyIPRDDGje+eaYPdqqwLbO8MB5/xrz9w==
X-Received: by 2002:adf:ec83:: with SMTP id z3mr19144406wrn.707.1643666873800;
        Mon, 31 Jan 2022 14:07:53 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id j5sm12476380wrq.31.2022.01.31.14.07.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 31 Jan 2022 14:07:53 -0800 (PST)
Message-Id: <cdaa576aac178f83e73b16e4390c196b26b49d1d.1643666870.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1123.v4.git.1643666870.gitgitgadget@gmail.com>
References: <pull.1123.v3.git.1643580113.gitgitgadget@gmail.com>
        <pull.1123.v4.git.1643666870.gitgitgadget@gmail.com>
From:   "=?UTF-8?q?Jean-No=C3=ABl=20Avila?= via GitGitGadget" 
        <gitgitgadget@gmail.com>
Date:   Mon, 31 Jan 2022 22:07:48 +0000
Subject: [PATCH v4 3/4] i18n: remove from i18n strings that do not hold
 translatable parts
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Fcc:    Sent
To:     git@vger.kernel.org
Cc:     Johannes Sixt <j6t@kdbg.org>,
        Phillip Wood <phillip.wood123@gmail.com>,
        =?UTF-8?Q?Jean-No=C3=ABl?= Avila <jn.avila@free.fr>,
        =?UTF-8?q?Jean-No=C3=ABl=20Avila?= <jn.avila@free.fr>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: =?UTF-8?q?Jean-No=C3=ABl=20Avila?= <jn.avila@free.fr>

Signed-off-by: Jean-Noël Avila <jn.avila@free.fr>
---
 archive.c                    | 2 +-
 builtin/bisect--helper.c     | 6 +++---
 builtin/count-objects.c      | 2 +-
 builtin/hash-object.c        | 2 +-
 builtin/help.c               | 4 ++--
 builtin/mktag.c              | 2 +-
 builtin/mktree.c             | 2 +-
 builtin/notes.c              | 6 +++---
 builtin/prune-packed.c       | 2 +-
 builtin/rebase.c             | 2 +-
 builtin/reflog.c             | 2 +-
 builtin/remote.c             | 2 +-
 builtin/replace.c            | 2 +-
 builtin/sparse-checkout.c    | 8 ++++----
 builtin/stripspace.c         | 4 ++--
 builtin/submodule--helper.c  | 2 +-
 builtin/update-server-info.c | 2 +-
 17 files changed, 26 insertions(+), 26 deletions(-)

diff --git a/archive.c b/archive.c
index d571249cf39..e29d0e00f6c 100644
--- a/archive.c
+++ b/archive.c
@@ -12,7 +12,7 @@
 
 static char const * const archive_usage[] = {
 	N_("git archive [<options>] <tree-ish> [<path>...]"),
-	N_("git archive --list"),
+	"git archive --list",
 	N_("git archive --remote <repo> [--exec <cmd>] [<options>] <tree-ish> [<path>...]"),
 	N_("git archive --remote <repo> [--exec <cmd>] --list"),
 	NULL
diff --git a/builtin/bisect--helper.c b/builtin/bisect--helper.c
index 28a2e6a5750..f962dbd4303 100644
--- a/builtin/bisect--helper.c
+++ b/builtin/bisect--helper.c
@@ -22,15 +22,15 @@ static GIT_PATH_FUNC(git_path_bisect_run, "BISECT_RUN")
 
 static const char * const git_bisect_helper_usage[] = {
 	N_("git bisect--helper --bisect-reset [<commit>]"),
-	N_("git bisect--helper --bisect-terms [--term-good | --term-old | --term-bad | --term-new]"),
+	"git bisect--helper --bisect-terms [--term-good | --term-old | --term-bad | --term-new]",
 	N_("git bisect--helper --bisect-start [--term-{new,bad}=<term> --term-{old,good}=<term>]"
 					    " [--no-checkout] [--first-parent] [<bad> [<good>...]] [--] [<paths>...]"),
-	N_("git bisect--helper --bisect-next"),
+	"git bisect--helper --bisect-next",
 	N_("git bisect--helper --bisect-state (bad|new) [<rev>]"),
 	N_("git bisect--helper --bisect-state (good|old) [<rev>...]"),
 	N_("git bisect--helper --bisect-replay <filename>"),
 	N_("git bisect--helper --bisect-skip [(<rev>|<range>)...]"),
-	N_("git bisect--helper --bisect-visualize"),
+	"git bisect--helper --bisect-visualize",
 	N_("git bisect--helper --bisect-run <cmd>..."),
 	NULL
 };
diff --git a/builtin/count-objects.c b/builtin/count-objects.c
index 3fae474f6f1..07b94195962 100644
--- a/builtin/count-objects.c
+++ b/builtin/count-objects.c
@@ -87,7 +87,7 @@ static int print_alternate(struct object_directory *odb, void *data)
 }
 
 static char const * const count_objects_usage[] = {
-	N_("git count-objects [-v] [-H | --human-readable]"),
+	"git count-objects [-v] [-H | --human-readable]",
 	NULL
 };
 
diff --git a/builtin/hash-object.c b/builtin/hash-object.c
index c7b3ad74c60..04e2442ec7c 100644
--- a/builtin/hash-object.c
+++ b/builtin/hash-object.c
@@ -81,7 +81,7 @@ int cmd_hash_object(int argc, const char **argv, const char *prefix)
 {
 	static const char * const hash_object_usage[] = {
 		N_("git hash-object [-t <type>] [-w] [--path=<file> | --no-filters] [--stdin] [--] <file>..."),
-		N_("git hash-object  --stdin-paths"),
+		"git hash-object  --stdin-paths",
 		NULL
 	};
 	const char *type = blob_type;
diff --git a/builtin/help.c b/builtin/help.c
index d387131dd83..b4f2ad3f94e 100644
--- a/builtin/help.c
+++ b/builtin/help.c
@@ -77,8 +77,8 @@ static struct option builtin_help_options[] = {
 static const char * const builtin_help_usage[] = {
 	N_("git help [-a|--all] [--[no-]verbose]]\n"
 	   "         [[-i|--info] [-m|--man] [-w|--web]] [<command>]"),
-	N_("git help [-g|--guides]"),
-	N_("git help [-c|--config]"),
+	"git help [-g|--guides]",
+	"git help [-c|--config]",
 	NULL
 };
 
diff --git a/builtin/mktag.c b/builtin/mktag.c
index 3b2dbbb37e6..c7b905c614b 100644
--- a/builtin/mktag.c
+++ b/builtin/mktag.c
@@ -7,7 +7,7 @@
 #include "config.h"
 
 static char const * const builtin_mktag_usage[] = {
-	N_("git mktag"),
+	"git mktag",
 	NULL
 };
 static int option_strict = 1;
diff --git a/builtin/mktree.c b/builtin/mktree.c
index ae78ca1c029..8bdaada922a 100644
--- a/builtin/mktree.c
+++ b/builtin/mktree.c
@@ -63,7 +63,7 @@ static void write_tree(struct object_id *oid)
 }
 
 static const char *mktree_usage[] = {
-	N_("git mktree [-z] [--missing] [--batch]"),
+	"git mktree [-z] [--missing] [--batch]",
 	NULL
 };
 
diff --git a/builtin/notes.c b/builtin/notes.c
index 05d60483e82..f99593a1853 100644
--- a/builtin/notes.c
+++ b/builtin/notes.c
@@ -32,8 +32,8 @@ static const char * const git_notes_usage[] = {
 	N_("git notes [--ref <notes-ref>] edit [--allow-empty] [<object>]"),
 	N_("git notes [--ref <notes-ref>] show [<object>]"),
 	N_("git notes [--ref <notes-ref>] merge [-v | -q] [-s <strategy>] <notes-ref>"),
-	N_("git notes merge --commit [-v | -q]"),
-	N_("git notes merge --abort [-v | -q]"),
+	"git notes merge --commit [-v | -q]",
+	"git notes merge --abort [-v | -q]",
 	N_("git notes [--ref <notes-ref>] remove [<object>...]"),
 	N_("git notes [--ref <notes-ref>] prune [-n] [-v]"),
 	N_("git notes [--ref <notes-ref>] get-ref"),
@@ -89,7 +89,7 @@ static const char * const git_notes_prune_usage[] = {
 };
 
 static const char * const git_notes_get_ref_usage[] = {
-	N_("git notes get-ref"),
+	"git notes get-ref",
 	NULL
 };
 
diff --git a/builtin/prune-packed.c b/builtin/prune-packed.c
index b7b9281a8ce..da3273a268b 100644
--- a/builtin/prune-packed.c
+++ b/builtin/prune-packed.c
@@ -3,7 +3,7 @@
 #include "prune-packed.h"
 
 static const char * const prune_packed_usage[] = {
-	N_("git prune-packed [-n | --dry-run] [-q | --quiet]"),
+	"git prune-packed [-n | --dry-run] [-q | --quiet]",
 	NULL
 };
 
diff --git a/builtin/rebase.c b/builtin/rebase.c
index 36490d06c8a..64796c6a785 100644
--- a/builtin/rebase.c
+++ b/builtin/rebase.c
@@ -36,7 +36,7 @@ static char const * const builtin_rebase_usage[] = {
 		"[--onto <newbase> | --keep-base] [<upstream> [<branch>]]"),
 	N_("git rebase [-i] [options] [--exec <cmd>] [--onto <newbase>] "
 		"--root [<branch>]"),
-	N_("git rebase --continue | --abort | --skip | --edit-todo"),
+	"git rebase --continue | --abort | --skip | --edit-todo",
 	NULL
 };
 
diff --git a/builtin/reflog.c b/builtin/reflog.c
index a4b1dd27e13..ee5ee8d8cf6 100644
--- a/builtin/reflog.c
+++ b/builtin/reflog.c
@@ -800,7 +800,7 @@ static int cmd_reflog_exists(int argc, const char **argv, const char *prefix)
  */
 
 static const char reflog_usage[] =
-N_("git reflog [ show | expire | delete | exists ]");
+"git reflog [ show | expire | delete | exists ]";
 
 int cmd_reflog(int argc, const char **argv, const char *prefix)
 {
diff --git a/builtin/remote.c b/builtin/remote.c
index 299c466116d..6f27ddc47bd 100644
--- a/builtin/remote.c
+++ b/builtin/remote.c
@@ -14,7 +14,7 @@
 #include "commit-reach.h"
 
 static const char * const builtin_remote_usage[] = {
-	N_("git remote [-v | --verbose]"),
+	"git remote [-v | --verbose]",
 	N_("git remote add [-t <branch>] [-m <master>] [-f] [--tags | --no-tags] [--mirror=<fetch|push>] <name> <url>"),
 	N_("git remote rename <old> <new>"),
 	N_("git remote remove <name>"),
diff --git a/builtin/replace.c b/builtin/replace.c
index 6ff1734d587..ac92337c0ec 100644
--- a/builtin/replace.c
+++ b/builtin/replace.c
@@ -22,7 +22,7 @@ static const char * const git_replace_usage[] = {
 	N_("git replace [-f] <object> <replacement>"),
 	N_("git replace [-f] --edit <object>"),
 	N_("git replace [-f] --graft <commit> [<parent>...]"),
-	N_("git replace [-f] --convert-graft-file"),
+	"git replace [-f] --convert-graft-file",
 	N_("git replace -d <object>..."),
 	N_("git replace [--format=<format>] [-l [<pattern>]]"),
 	NULL
diff --git a/builtin/sparse-checkout.c b/builtin/sparse-checkout.c
index 679c1070368..771c9869a1c 100644
--- a/builtin/sparse-checkout.c
+++ b/builtin/sparse-checkout.c
@@ -43,7 +43,7 @@ static void write_patterns_to_file(FILE *fp, struct pattern_list *pl)
 }
 
 static char const * const builtin_sparse_checkout_list_usage[] = {
-	N_("git sparse-checkout list"),
+	"git sparse-checkout list",
 	NULL
 };
 
@@ -419,7 +419,7 @@ static int update_modes(int *cone_mode, int *sparse_index)
 }
 
 static char const * const builtin_sparse_checkout_init_usage[] = {
-	N_("git sparse-checkout init [--cone] [--[no-]sparse-index]"),
+	"git sparse-checkout init [--cone] [--[no-]sparse-index]",
 	NULL
 };
 
@@ -762,7 +762,7 @@ static int sparse_checkout_set(int argc, const char **argv, const char *prefix)
 }
 
 static char const * const builtin_sparse_checkout_reapply_usage[] = {
-	N_("git sparse-checkout reapply [--[no-]cone] [--[no-]sparse-index]"),
+	"git sparse-checkout reapply [--[no-]cone] [--[no-]sparse-index]",
 	NULL
 };
 
@@ -800,7 +800,7 @@ static int sparse_checkout_reapply(int argc, const char **argv)
 }
 
 static char const * const builtin_sparse_checkout_disable_usage[] = {
-	N_("git sparse-checkout disable"),
+	"git sparse-checkout disable",
 	NULL
 };
 
diff --git a/builtin/stripspace.c b/builtin/stripspace.c
index be33eb83c1b..1e34cf2bebd 100644
--- a/builtin/stripspace.c
+++ b/builtin/stripspace.c
@@ -15,8 +15,8 @@ static void comment_lines(struct strbuf *buf)
 }
 
 static const char * const stripspace_usage[] = {
-	N_("git stripspace [-s | --strip-comments]"),
-	N_("git stripspace [-c | --comment-lines]"),
+	"git stripspace [-s | --strip-comments]",
+	"git stripspace [-c | --comment-lines]",
 	NULL
 };
 
diff --git a/builtin/submodule--helper.c b/builtin/submodule--helper.c
index c5d3fc3817f..b80aa9898ac 100644
--- a/builtin/submodule--helper.c
+++ b/builtin/submodule--helper.c
@@ -2883,7 +2883,7 @@ static int module_config(int argc, const char **argv, const char *prefix)
 	const char *const git_submodule_helper_usage[] = {
 		N_("git submodule--helper config <name> [<value>]"),
 		N_("git submodule--helper config --unset <name>"),
-		N_("git submodule--helper config --check-writeable"),
+		"git submodule--helper config --check-writeable",
 		NULL
 	};
 
diff --git a/builtin/update-server-info.c b/builtin/update-server-info.c
index 4321a344567..880fffec587 100644
--- a/builtin/update-server-info.c
+++ b/builtin/update-server-info.c
@@ -4,7 +4,7 @@
 #include "parse-options.h"
 
 static const char * const update_server_info_usage[] = {
-	N_("git update-server-info [--force]"),
+	"git update-server-info [--force]",
 	NULL
 };
 
-- 
gitgitgadget

