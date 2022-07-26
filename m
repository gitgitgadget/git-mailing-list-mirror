Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3AD82C00140
	for <git@archiver.kernel.org>; Tue, 26 Jul 2022 14:04:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239201AbiGZOEX (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 26 Jul 2022 10:04:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45882 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238962AbiGZOES (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 26 Jul 2022 10:04:18 -0400
Received: from mail-wm1-x335.google.com (mail-wm1-x335.google.com [IPv6:2a00:1450:4864:20::335])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 69F662870E
        for <git@vger.kernel.org>; Tue, 26 Jul 2022 07:04:17 -0700 (PDT)
Received: by mail-wm1-x335.google.com with SMTP id j29-20020a05600c1c1d00b003a2fdafdefbso8231143wms.2
        for <git@vger.kernel.org>; Tue, 26 Jul 2022 07:04:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=V7EZjs1m9KOwZJy3i5Dfhc7OxBJ4wvtf8vMGPVUDHXM=;
        b=bSCPWRyuFngn18p2OooPpg4dyNfZawvxwMalr80pwQQMX0y0kIpN7RsZ0JP0vrM4ET
         Hj+LYk5Kt9LGm1tJMF4pG9kb/Njsk0quY/8AzEA9yem31g8EEghbJkDoZgBg+JcOlHEV
         fH2iYE2ClHdv8+ZlE7rmeli43R1dv4fV0PkLrFwnjgGlcR5Cyuj0D4/Oy5iev7GZ1mma
         VWpdG64HbkX7jgoFaffKaXv/Fa4+EihhHpfpedF9xtMdoCPZ+YahnS81xINZud6ChEDw
         A2odMu8qt3ds7TRo4nm32TiH5ePcikAHnJrFTrYErRothCzTtjhsfVNEk1gKC1WgIGQI
         BW+Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=V7EZjs1m9KOwZJy3i5Dfhc7OxBJ4wvtf8vMGPVUDHXM=;
        b=jDNVmgCwHQhjFDyuvU5hMwU17bFLeqyPEFxxFKhvWTpWVeSTin1G8oGyYSTuhxWoqY
         46FT+91aQN0VwBsAIS41Rj+b2bcUjVpReQMP4UnqfAxiyx1FA/rCqsvDTyF+Mn/thFtC
         fbkvTwMCCzTXus6Eb5dhFl9Xw+ageOOwTLXPCfMQK+ze3sR69kOhZLfmHYm+OPbWC9Hq
         if1/o10D7oyHuO2QK6ht2WpMiPFyr6Ybg01EDwyLeW0AZSocRR6C7akNtA80lmf9b0BQ
         SM3lEhunT6SshkQJoRZN3Fw3kuydEpwn+1mA822vjbypjUzSx2Rs8YVTHQGauostI4ul
         ChTw==
X-Gm-Message-State: AJIora90ADdlrflXEwA9WDsrL5WSY+29CD9Snaz408aeR0FHal0GvfZ1
        P4OiTo7/x/t8IcynULMbzoFodE8wLXA=
X-Google-Smtp-Source: AGRyM1ug+NdROE2EM+LhdpEDxF2IWBsTsWTDFwmxR8ke1gDEgW2VJlcTwNpP7XpZxm8jAaK2emybFA==
X-Received: by 2002:a05:600c:893:b0:3a3:1d8:c7b9 with SMTP id l19-20020a05600c089300b003a301d8c7b9mr11975199wmp.156.1658844255465;
        Tue, 26 Jul 2022 07:04:15 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id ay36-20020a05600c1e2400b003a2d6c623f3sm22407984wmb.19.2022.07.26.07.04.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 26 Jul 2022 07:04:14 -0700 (PDT)
Message-Id: <6b40b84773c70244bb13204ec566b713f1bdf865.1658844250.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1301.git.1658844250.gitgitgadget@gmail.com>
References: <pull.1301.git.1658844250.gitgitgadget@gmail.com>
From:   "Derrick Stolee via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Tue, 26 Jul 2022 14:04:09 +0000
Subject: [PATCH 2/3] log: add default decoration filter
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     gitster@pobox.com, me@ttaylorr.com, vdye@github.com,
        steadmon@google.com, Derrick Stolee <derrickstolee@github.com>,
        Derrick Stolee <derrickstolee@github.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Derrick Stolee <derrickstolee@github.com>

When a user runs 'git log', they expect a certain set of helpful
decorations. This includes:

* The HEAD ref
* Branches (refs/heads/)
* Notes (refs/notes/)
* Stashes (refs/stash/)
* Tags (refs/tags/)
* Remote branches (refs/remotes/)

However, there are other refs that are less helpful to show as
decoration:

* Prefetch refs (refs/prefetch/)
* Rebase refs (refs/rebase-merge/ and refs/rebase-apply/)
* Bundle refs (refs/bundle/) [!]

In the case of prefetch refs, 96eaffebbf3d0 (maintenance: set
log.excludeDecoration durin prefetch, 2021-01-19) added logic to add
refs/prefetch/ to the log.excludeDecoration config option. Additional
feedback pointed out that having such a side-effect can be confusing and
perhaps not helpful to users. Instead, we should hide these ref
namespaces that are being used by Git for internal reasons but are not
helpful for the users to see.

The way to provide a seamless user experience without setting the config
is to modify the default decoration filters to match our expectation of
what refs the user actually wants to see.

In builtin/log.c, after parsing the --decorate-refs and
--decorate-refs-exclude options from the command-line, call
set_default_decoration_filter(). This method populates the exclusions
from log.excludeDecoration, then checks if the list of pattern
modifications are empty. If none are specified, then the default set is
restricted to the set of inclusions mentioned earlier (HEAD, branches,
etc.).

Note that the logic in ref_filter_match() in log-tree.c follows this
matching pattern:

 1. If there are exclusion patterns and the ref matches one, then ignore
    the decoration.

 2. If there are inclusion patterns and the ref matches one, then
    definitely include the decoration.

 3. If there are config-based exclusions from log.excludeDecoration and
    the ref matches one, then ignore the decoration.

With this logic in mind, we need to ensure that we do not populate our
new defaults if any of these filters are manually set. Specifically, if
a user runs

	git -c log.excludeDecoration=HEAD log

then we expect the HEAD decoration to not appear. If we left the default
inclusions in the set, then HEAD would match that inclusion before
reaching the config-based exclusions.

A potential alternative would be to check the list of default inclusions
at the end, after the config-based exclusions. This would still create a
behavior change for some uses of --decorate-refs-exclude=<X>, and could
be overwritten somewhat with --decorate-refs=refs/ and
--decorate-refs=HEAD. However, it no longer becomes possible to include
refs outside of the defaults while also excluding some using
log.excludeDecoration.

Add a test that checks that the defaults are not added when
--decorate-refs is specified. We verify this by showing that HEAD is not
included as it normally would.  Also add a test that shows that the
default filter avoids the unwanted decorations from refs/prefetch,
refs/rebase-merge,
and refs/bundle.

There are several tests throughout the codebase that verify that
--decorate-refs, --decorate-refs-exclude, and log.excludeDecoration work
as designed and the tests continue to pass without intervention.

[!] The bundle refs are part of a parallel series that bootstraps a repo
from a bundle file, storing the bundle's refs into the repo's
refs/bundle/ namespace.

Signed-off-by: Derrick Stolee <derrickstolee@github.com>
---
 Documentation/git-log.txt |  7 ++++--
 builtin/log.c             | 53 +++++++++++++++++++++++++++++----------
 t/t4202-log.sh            | 23 +++++++++++++++++
 3 files changed, 68 insertions(+), 15 deletions(-)

diff --git a/Documentation/git-log.txt b/Documentation/git-log.txt
index 20e87cecf49..14b67f3d058 100644
--- a/Documentation/git-log.txt
+++ b/Documentation/git-log.txt
@@ -45,13 +45,16 @@ OPTIONS
 
 --decorate-refs=<pattern>::
 --decorate-refs-exclude=<pattern>::
-	If no `--decorate-refs` is given, pretend as if all refs were
-	included.  For each candidate, do not use it for decoration if it
+	For each candidate reference, do not use it for decoration if it
 	matches any patterns given to `--decorate-refs-exclude` or if it
 	doesn't match any of the patterns given to `--decorate-refs`. The
 	`log.excludeDecoration` config option allows excluding refs from
 	the decorations, but an explicit `--decorate-refs` pattern will
 	override a match in `log.excludeDecoration`.
++
+If none of these options or config settings are given, then references are
+used as decoration if they match `HEAD`, `refs/heads/`, `refs/notes/`,
+`refs/remotes/`, `refs/stash/`, or `refs/tags/`.
 
 --source::
 	Print out the ref name given on the command line by which each
diff --git a/builtin/log.c b/builtin/log.c
index 88a5e98875a..dca06612b8e 100644
--- a/builtin/log.c
+++ b/builtin/log.c
@@ -162,6 +162,40 @@ static void cmd_log_init_defaults(struct rev_info *rev)
 		parse_date_format(default_date_mode, &rev->date_mode);
 }
 
+static void set_default_decoration_filter(struct decoration_filter *decoration_filter)
+{
+	const struct string_list *config_exclude =
+		repo_config_get_value_multi(the_repository, "log.excludeDecoration");
+
+	if (config_exclude) {
+		struct string_list_item *item;
+		for_each_string_list_item(item, config_exclude)
+			string_list_append(decoration_filter->exclude_ref_config_pattern,
+					   item->string);
+	}
+
+	if (!decoration_filter->exclude_ref_pattern->nr &&
+	    !decoration_filter->include_ref_pattern->nr &&
+	    !decoration_filter->exclude_ref_config_pattern->nr) {
+		/*
+		 * No command-line or config options were given, so
+		 * populate with sensible defaults.
+		 */
+		string_list_append(decoration_filter->include_ref_pattern,
+				   "refs/heads/");
+		string_list_append(decoration_filter->include_ref_pattern,
+				   "refs/notes/");
+		string_list_append(decoration_filter->include_ref_pattern,
+				   "refs/stash/");
+		string_list_append(decoration_filter->include_ref_pattern,
+				   "refs/tags/");
+		string_list_append(decoration_filter->include_ref_pattern,
+				   "refs/remotes/");
+		string_list_append(decoration_filter->include_ref_pattern,
+				   "HEAD");
+	}
+}
+
 static void cmd_log_init_finish(int argc, const char **argv, const char *prefix,
 			 struct rev_info *rev, struct setup_revision_opt *opt)
 {
@@ -171,9 +205,11 @@ static void cmd_log_init_finish(int argc, const char **argv, const char *prefix,
 	static struct string_list decorate_refs_exclude = STRING_LIST_INIT_NODUP;
 	static struct string_list decorate_refs_exclude_config = STRING_LIST_INIT_NODUP;
 	static struct string_list decorate_refs_include = STRING_LIST_INIT_NODUP;
-	struct decoration_filter decoration_filter = {&decorate_refs_include,
-						      &decorate_refs_exclude,
-						      &decorate_refs_exclude_config};
+	struct decoration_filter decoration_filter = {
+		.exclude_ref_pattern = &decorate_refs_exclude,
+		.include_ref_pattern = &decorate_refs_include,
+		.exclude_ref_config_pattern = &decorate_refs_exclude_config,
+	};
 	static struct revision_sources revision_sources;
 
 	const struct option builtin_log_options[] = {
@@ -265,16 +301,7 @@ static void cmd_log_init_finish(int argc, const char **argv, const char *prefix,
 	}
 
 	if (decoration_style || rev->simplify_by_decoration) {
-		const struct string_list *config_exclude =
-			repo_config_get_value_multi(the_repository,
-						    "log.excludeDecoration");
-
-		if (config_exclude) {
-			struct string_list_item *item;
-			for_each_string_list_item(item, config_exclude)
-				string_list_append(&decorate_refs_exclude_config,
-						   item->string);
-		}
+		set_default_decoration_filter(&decoration_filter);
 
 		if (decoration_style)
 			rev->show_decorations = 1;
diff --git a/t/t4202-log.sh b/t/t4202-log.sh
index 6b7d8e269f7..1a41096c8e2 100755
--- a/t/t4202-log.sh
+++ b/t/t4202-log.sh
@@ -1031,6 +1031,12 @@ test_expect_success 'decorate-refs-exclude HEAD' '
 	! grep HEAD actual
 '
 
+test_expect_success 'decorate-refs focus from default' '
+	git log --decorate=full --oneline \
+		--decorate-refs="refs/heads" >actual &&
+	! grep HEAD actual
+'
+
 test_expect_success 'log.decorate config parsing' '
 	git log --oneline --decorate=full >expect.full &&
 	git log --oneline --decorate=short >expect.short &&
@@ -2198,6 +2204,23 @@ test_expect_success 'log --decorate includes all levels of tag annotated tags' '
 	test_cmp expect actual
 '
 
+test_expect_success 'log --decorate does not include things outside filter' '
+	reflist="refs/prefetch/ refs/rebase-merge/ refs/bundle/" &&
+
+	for ref in $reflist
+	do
+		mkdir -p .git/$ref &&
+		echo $(git rev-parse HEAD) >.git/$ref/fake || return 1
+	done &&
+
+	git log --decorate=full --oneline >actual &&
+
+	for ref in $reflist
+	do
+		! grep $ref/fake actual || return 1
+	done
+'
+
 test_expect_success 'log --end-of-options' '
        git update-ref refs/heads/--source HEAD &&
        git log --end-of-options --source >actual &&
-- 
gitgitgadget

