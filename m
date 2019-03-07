Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.2 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 2A68A20248
	for <e@80x24.org>; Thu,  7 Mar 2019 10:01:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726138AbfCGKBA (ORCPT <rfc822;e@80x24.org>);
        Thu, 7 Mar 2019 05:01:00 -0500
Received: from mail-ed1-f68.google.com ([209.85.208.68]:36790 "EHLO
        mail-ed1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726028AbfCGKA7 (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 7 Mar 2019 05:00:59 -0500
Received: by mail-ed1-f68.google.com with SMTP id g9so12913712eds.3
        for <git@vger.kernel.org>; Thu, 07 Mar 2019 02:00:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:message-id:in-reply-to:references:from:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=Un1D71MBJ8CJIdrfkOPeJ/VxnhhpT/6OtiP0nVteoKE=;
        b=VNwLOy5VNUWCjaRhC8a5hqXtAssbxC8H00SZjjS/Yx8Kc5zWPYYvddmX7nVKwAh+RU
         2+HQnQR04NFKSoVZOkMcJeC8+R/1wZFr/UgNdNvUSCxf/FebklAmOgWA0UXeQQYprL/f
         Nm+KyMCI/mj/yxeBHdFwQVmL0ugKyboZwNrRzZPNLrplkErsjekewq1Hc4cVho8ZeIFO
         CarEbwOEnX0zfxaBYjpXuAgbrZdVk5URq/TpdOE/o+IfNfqJJhSK1LEBMQzTP/EnF5pb
         AZ7jBDGgKCRAPHabpgohao/dSLtbNlRYcX6It8OuOGUsdDZtrQbLyCWzHKFn2gxLroIf
         mDbQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:message-id:in-reply-to:references:from
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=Un1D71MBJ8CJIdrfkOPeJ/VxnhhpT/6OtiP0nVteoKE=;
        b=HtMbkglo7nscWwj9l/tNByxGBiZeuR1KNWEjwmRk4986q4MiaAzOvohXulJ3g5eKH0
         7XkSd++fOMSS2WNxcgr7jFwXYe3gC79HMpLp2uUJdbwBRqUZvsgalEHaWLoU+SalKpQC
         VodTNdr2KJ/lgUOKSDwnUhN/tLWSVueNtx08dZw7F1Ata2Isn4j/vRF2wx/w58MGACU2
         EkWrvzLFbjD9B6qevMltrD/+kkojRWbbZPvWmGm498bQM0pIBJcaIhR6b9UcnwazB9pI
         Ch32atDTowIjXBQj50It8vxMY1ZoEbWsNgicx69nzsnVmIDC34tNprvXzE5QfUAFYTkB
         ZeJg==
X-Gm-Message-State: APjAAAUHRbA9jxQ6fn/vdfo2Y0VMfVtB1aHn4lPBUjcKydsejMhfPkd2
        h1qPK2+/bBwiePpIkAGWmhsOaqF0
X-Google-Smtp-Source: APXvYqxHIu+H+Wi/ahiZ5A7hsUBxCsezR58wGhdQ0lfMZuIZQjYT2qennyUiK+IeGlmiSlhkk86U5g==
X-Received: by 2002:aa7:df8b:: with SMTP id b11mr27088457edy.166.1551952856656;
        Thu, 07 Mar 2019 02:00:56 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id a51sm1210135edd.57.2019.03.07.02.00.56
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 07 Mar 2019 02:00:56 -0800 (PST)
Date:   Thu, 07 Mar 2019 02:00:56 -0800 (PST)
X-Google-Original-Date: Thu, 07 Mar 2019 10:00:55 GMT
Message-Id: <6407430da7f75cb2385d243c9820ac8c2ea7fee3.1551952855.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.158.git.gitgitgadget@gmail.com>
References: <pull.158.git.gitgitgadget@gmail.com>
From:   "Johannes Schindelin via GitGitGadget" <gitgitgadget@gmail.com>
Subject: [PATCH 1/1] rebase: deprecate --preserve-merges
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

We have something much better now: --rebase-merges (which is a
complete re-design --preserve-merges, with a lot of issues fixed such as
the inability to reorder commits with --preserve-merges).

Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
---
 Documentation/config/branch.txt |  6 +++---
 Documentation/config/pull.txt   |  6 +++---
 Documentation/git-rebase.txt    | 23 ++++++++++++-----------
 builtin/rebase.c                |  8 ++++++--
 git-rebase--preserve-merges.sh  |  2 ++
 5 files changed, 26 insertions(+), 19 deletions(-)

diff --git a/Documentation/config/branch.txt b/Documentation/config/branch.txt
index 019d60ede2..8f4b3faadd 100644
--- a/Documentation/config/branch.txt
+++ b/Documentation/config/branch.txt
@@ -85,9 +85,9 @@ When `merges`, pass the `--rebase-merges` option to 'git rebase'
 so that the local merge commits are included in the rebase (see
 linkgit:git-rebase[1] for details).
 +
-When preserve, also pass `--preserve-merges` along to 'git rebase'
-so that locally committed merge commits will not be flattened
-by running 'git pull'.
+When `preserve` (deprecated in favor of `merges`), also pass
+`--preserve-merges` along to 'git rebase' so that locally committed merge
+commits will not be flattened by running 'git pull'.
 +
 When the value is `interactive`, the rebase is run in interactive mode.
 +
diff --git a/Documentation/config/pull.txt b/Documentation/config/pull.txt
index bb23a9947d..b87cab31b3 100644
--- a/Documentation/config/pull.txt
+++ b/Documentation/config/pull.txt
@@ -18,9 +18,9 @@ When `merges`, pass the `--rebase-merges` option to 'git rebase'
 so that the local merge commits are included in the rebase (see
 linkgit:git-rebase[1] for details).
 +
-When preserve, also pass `--preserve-merges` along to 'git rebase'
-so that locally committed merge commits will not be flattened
-by running 'git pull'.
+When `preserve` (deprecated in favor of `merges`), also pass
+`--preserve-merges` along to 'git rebase' so that locally committed merge
+commits will not be flattened by running 'git pull'.
 +
 When the value is `interactive`, the rebase is run in interactive mode.
 +
diff --git a/Documentation/git-rebase.txt b/Documentation/git-rebase.txt
index 5629ba4c5d..89202dbb93 100644
--- a/Documentation/git-rebase.txt
+++ b/Documentation/git-rebase.txt
@@ -415,9 +415,9 @@ i.e. commits that would be excluded by gitlink:git-log[1]'s
 the `rebase-cousins` mode is turned on, such commits are instead rebased
 onto `<upstream>` (or `<onto>`, if specified).
 +
-The `--rebase-merges` mode is similar in spirit to `--preserve-merges`, but
-in contrast to that option works well in interactive rebases: commits can be
-reordered, inserted and dropped at will.
+The `--rebase-merges` mode is similar in spirit to the deprecated
+`--preserve-merges`, but in contrast to that option works well in interactive
+rebases: commits can be reordered, inserted and dropped at will.
 +
 It is currently only possible to recreate the merge commits using the
 `recursive` merge strategy; Different merge strategies can be used only via
@@ -427,9 +427,10 @@ See also REBASING MERGES and INCOMPATIBLE OPTIONS below.
 
 -p::
 --preserve-merges::
-	Recreate merge commits instead of flattening the history by replaying
-	commits a merge commit introduces. Merge conflict resolutions or manual
-	amendments to merge commits are not preserved.
+	[DEPRECATED: use --rebase-merges instead] Recreate merge commits
+	instead of flattening the history by replaying commits a merge commit
+	introduces. Merge conflict resolutions or manual amendments to merge
+	commits are not preserved.
 +
 This uses the `--interactive` machinery internally, but combining it
 with the `--interactive` option explicitly is generally not a good
@@ -1020,11 +1021,11 @@ merge cmake
 
 BUGS
 ----
-The todo list presented by `--preserve-merges --interactive` does not
-represent the topology of the revision graph.  Editing commits and
-rewording their commit messages should work fine, but attempts to
-reorder commits tend to produce counterintuitive results. Use
-`--rebase-merges` in such scenarios instead.
+The todo list presented by the deprecated `--preserve-merges --interactive`
+does not represent the topology of the revision graph (use `--rebase-merges`
+instead).  Editing commits and rewording their commit messages should work
+fine, but attempts to reorder commits tend to produce counterintuitive results.
+Use `--rebase-merges` in such scenarios instead.
 
 For example, an attempt to rearrange
 ------------
diff --git a/builtin/rebase.c b/builtin/rebase.c
index 7c7bc13e91..c5f5edf321 100644
--- a/builtin/rebase.c
+++ b/builtin/rebase.c
@@ -1092,8 +1092,8 @@ int cmd_rebase(int argc, const char **argv, const char *prefix)
 			PARSE_OPT_NOARG | PARSE_OPT_NONEG,
 			parse_opt_interactive },
 		OPT_SET_INT('p', "preserve-merges", &options.type,
-			    N_("try to recreate merges instead of ignoring "
-			       "them"), REBASE_PRESERVE_MERGES),
+			    N_("(DEPRECATED) try to recreate merges instead of "
+			       "ignoring them"), REBASE_PRESERVE_MERGES),
 		OPT_BOOL(0, "rerere-autoupdate",
 			 &options.allow_rerere_autoupdate,
 			 N_("allow rerere to update index with resolved "
@@ -1204,6 +1204,10 @@ int cmd_rebase(int argc, const char **argv, const char *prefix)
 		usage_with_options(builtin_rebase_usage,
 				   builtin_rebase_options);
 
+	if (options.type == REBASE_PRESERVE_MERGES)
+		warning(_("--preserve-merges is deprecated in favor of "
+			  "--rebase-merges"));
+
 	if (action != NO_ACTION && !in_progress)
 		die(_("No rebase in progress?"));
 	setenv(GIT_REFLOG_ACTION_ENVIRONMENT, "rebase", 0);
diff --git a/git-rebase--preserve-merges.sh b/git-rebase--preserve-merges.sh
index afbb65765d..eab2e40dc6 100644
--- a/git-rebase--preserve-merges.sh
+++ b/git-rebase--preserve-merges.sh
@@ -105,6 +105,8 @@ warn () {
 	printf '%s\n' "$*" >&2
 }
 
+warn "git rebase --preserve-merges is deprecated. Use --rebase-merges instead."
+
 # Output the commit message for the specified commit.
 commit_message () {
 	git cat-file commit "$1" | sed "1,/^$/d"
-- 
gitgitgadget
