Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 77C61C00140
	for <git@archiver.kernel.org>; Fri,  5 Aug 2022 17:59:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241619AbiHER71 (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 5 Aug 2022 13:59:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40408 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241565AbiHER7J (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 5 Aug 2022 13:59:09 -0400
Received: from mail-wm1-x334.google.com (mail-wm1-x334.google.com [IPv6:2a00:1450:4864:20::334])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 401E974E3D
        for <git@vger.kernel.org>; Fri,  5 Aug 2022 10:59:02 -0700 (PDT)
Received: by mail-wm1-x334.google.com with SMTP id b6so1726091wmq.5
        for <git@vger.kernel.org>; Fri, 05 Aug 2022 10:59:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc;
        bh=YlzXGu+IkBq5nc8bGAgnD7Wkw0Xgo1SBWxVdlSLfsI8=;
        b=H2gdNammmzJuuqQJzg4F9hIuXVFB7f/TmGADxbbi7Xn2xCkjgtHrGTP2KeBII7SgK7
         4AmJebLS+PUJaM10P7tcFBiDuFIgnMDF99LmKx6Ar5fgCtroU7QHyvRzpzHJtTv/lzC8
         tBN9Xg3mccVYIYzeH1p8YmgkOzmSoO4JGLcWJGo+QLJ5f/qwqB4JuaeDeat893CVd8iU
         vQW1kmSBBqsOHHJuiA7QBf6JVpvC3qvk43AG0+5i7xcdchR2ci/3apxLQIW4uD7+g2Ka
         KwZ8ZgAmtq7yiewxt6AxUfr0lU78rskiNFLGXTlMT0f2WuPQ1P2lRQrdiJ7MUyV6pc9R
         haPw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-message-state:from:to:cc;
        bh=YlzXGu+IkBq5nc8bGAgnD7Wkw0Xgo1SBWxVdlSLfsI8=;
        b=ZoPyci1rAePfsX+24dILALXducld0yZ4gV/E5/Mwr7DMoSvfu77wRD+wONOeza0bHB
         4So8rmjTM7cJS1nXuhjRJHuWUw/nxklMyupAcX2k+edYtZ7sfvqympiD0Xy7PxN1Ww0o
         aFlVOJLaHTNyygLhl7NS9UZfz9Ly6pagRF34sh3mgCL/zB+IkxJ+OkN2eCYrDYJG5hr4
         b0ovXplRvyfVdXqDtOayrg25Ce0eLkbKbRYRobDj8k39pMHDm7YZZcHKI80bKiF6eM63
         mStf2PMj/CbGRlir5hlPZPfZkPucwdcglVl3Oa/udqGWxYTSFLa23Sr97/gbJD2HEJ0w
         OBYQ==
X-Gm-Message-State: ACgBeo34iZohQlF48eWlDRZwyOZGyBjPnaS/H3cu5nVEbb5gMeTf3MtB
        PQyR2VGwpDqFNYFphGBF8hD6kgQmtso=
X-Google-Smtp-Source: AA6agR5mr1qoSV4mWlEwZqiIH5WlILllOhXWeUHzpdCVSytTjC/G6Xd5gPO7Pk0fFeLTaiRhITDkwg==
X-Received: by 2002:a05:600c:6002:b0:3a3:5453:bcbe with SMTP id az2-20020a05600c600200b003a35453bcbemr5710439wmb.190.1659722340173;
        Fri, 05 Aug 2022 10:59:00 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id l2-20020a1ced02000000b003a3170a7af9sm5077446wmh.4.2022.08.05.10.58.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 05 Aug 2022 10:58:59 -0700 (PDT)
Message-Id: <c249bface2a6dcd0355620f92579b42a6fa4ea58.1659722324.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1301.v3.git.1659722323.gitgitgadget@gmail.com>
References: <pull.1301.v2.git.1659122979.gitgitgadget@gmail.com>
        <pull.1301.v3.git.1659722323.gitgitgadget@gmail.com>
From:   "Derrick Stolee via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Fri, 05 Aug 2022 17:58:39 +0000
Subject: [PATCH v3 07/11] log: add default decoration filter
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     gitster@pobox.com, me@ttaylorr.com, vdye@github.com,
        steadmon@google.com,
        =?UTF-8?Q?=C3=86var_Arnfj=C3=B6r=C3=B0?= Bjarmason 
        <avarab@gmail.com>, Jeff King <peff@peff.net>,
        Eric Sunshine <sunshine@sunshineco.com>,
        Derrick Stolee <derrickstolee@github.com>,
        Derrick Stolee <derrickstolee@github.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Derrick Stolee <derrickstolee@github.com>

When a user runs 'git log', they expect a certain set of helpful
decorations. This includes:

* The HEAD ref
* Branches (refs/heads/)
* Stashes (refs/stash)
* Tags (refs/tags/)
* Remote branches (refs/remotes/)
* Replace refs (refs/replace/ or $GIT_REPLACE_REF_BASE)

Each of these namespaces was selected due to existing test cases that
verify these namespaces appear in the decorations. In particular,
stashes and replace refs can have custom colors from the
color.decorate.<slot> config option.

While one test checks for a decoration from notes, it only applies to
the tip of refs/notes/commit (or its configured ref name). Notes form
their own kind of decoration instead. Modify the expected output for the
tests in t4013 that expect this note decoration.  There are several
tests throughout the codebase that verify that --decorate-refs,
--decorate-refs-exclude, and log.excludeDecoration work as designed and
the tests continue to pass without intervention.

However, there are other refs that are less helpful to show as
decoration:

* Prefetch refs (refs/prefetch/)
* Rebase refs (refs/rebase-merge/ and refs/rebase-apply/)
* Bundle refs (refs/bundle/) [!]

[!] The bundle refs are part of a parallel series that bootstraps a repo
    from a bundle file, storing the bundle's refs into the repo's
    refs/bundle/ namespace.

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
etc.).  A previous change introduced the ref_namespaces array, which
includes all of these currently-used namespaces. The 'decoration' value
is non-zero when that namespace is associated with a special coloring
and fits into the list of "expected" decorations as described above,
which makes the implementation of this filter very simple.

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

Another alternative would be to exclude the known namespaces that are
not intended to be shown. This would reduce the visible effect of the
change for expert users who use their own custom ref namespaces. The
implementation change would be very simple to swap due to our use of
ref_namespaces:

	int i;
	struct string_list *exclude = decoration_filter->exclude_ref_pattern;

	/*
	 * No command-line or config options were given, so
	 * populate with sensible defaults.
	 */
	for (i = 0; i < NAMESPACE__COUNT; i++) {
		if (ref_namespaces[i].decoration)
			continue;

		string_list_append(exclude, ref_namespaces[i].ref);
	}

The main downside of this approach is that we expect to add new hidden
namespaces in the future, and that means that Git versions will be less
stable in how they behave as those namespaces are added.

It is critical that we provide ways for expert users to disable this
behavior change via command-line options and config keys. These changes
will be implemented in a future change.

Add a test that checks that the defaults are not added when
--decorate-refs is specified. We verify this by showing that HEAD is not
included as it normally would.  Also add a test that shows that the
default filter avoids the unwanted decorations from refs/prefetch,
refs/rebase-merge,
and refs/bundle.

Signed-off-by: Derrick Stolee <derrickstolee@github.com>
---
 Documentation/git-log.txt              |  7 ++--
 builtin/log.c                          | 50 +++++++++++++++++++-------
 t/t4013/diff.log_--decorate=full_--all |  2 +-
 t/t4013/diff.log_--decorate_--all      |  2 +-
 t/t4202-log.sh                         | 20 +++++++++++
 5 files changed, 64 insertions(+), 17 deletions(-)

diff --git a/Documentation/git-log.txt b/Documentation/git-log.txt
index 20e87cecf49..b2ac89dfafc 100644
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
+used as decoration if they match `HEAD`, `refs/heads/`, `refs/remotes/`,
+`refs/stash/`, or `refs/tags/`.
 
 --source::
 	Print out the ref name given on the command line by which each
diff --git a/builtin/log.c b/builtin/log.c
index 88a5e98875a..6683e5ff134 100644
--- a/builtin/log.c
+++ b/builtin/log.c
@@ -162,6 +162,37 @@ static void cmd_log_init_defaults(struct rev_info *rev)
 		parse_date_format(default_date_mode, &rev->date_mode);
 }
 
+static void set_default_decoration_filter(struct decoration_filter *decoration_filter)
+{
+	int i;
+	struct string_list *include = decoration_filter->include_ref_pattern;
+	const struct string_list *config_exclude =
+			git_config_get_value_multi("log.excludeDecoration");
+
+	if (config_exclude) {
+		struct string_list_item *item;
+		for_each_string_list_item(item, config_exclude)
+			string_list_append(decoration_filter->exclude_ref_config_pattern,
+					   item->string);
+	}
+
+	if (decoration_filter->exclude_ref_pattern->nr ||
+	    decoration_filter->include_ref_pattern->nr ||
+	    decoration_filter->exclude_ref_config_pattern->nr)
+		return;
+
+	/*
+	 * No command-line or config options were given, so
+	 * populate with sensible defaults.
+	 */
+	for (i = 0; i < ARRAY_SIZE(ref_namespace); i++) {
+		if (!ref_namespace[i].decoration)
+			continue;
+
+		string_list_append(include, ref_namespace[i].ref);
+	}
+}
+
 static void cmd_log_init_finish(int argc, const char **argv, const char *prefix,
 			 struct rev_info *rev, struct setup_revision_opt *opt)
 {
@@ -171,9 +202,11 @@ static void cmd_log_init_finish(int argc, const char **argv, const char *prefix,
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
@@ -265,16 +298,7 @@ static void cmd_log_init_finish(int argc, const char **argv, const char *prefix,
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
diff --git a/t/t4013/diff.log_--decorate=full_--all b/t/t4013/diff.log_--decorate=full_--all
index 3f9b872eceb..6b0b334a5d6 100644
--- a/t/t4013/diff.log_--decorate=full_--all
+++ b/t/t4013/diff.log_--decorate=full_--all
@@ -20,7 +20,7 @@ Date:   Mon Jun 26 00:06:00 2006 +0000
 
     Rearranged lines in dir/sub
 
-commit cbacedd14cb8b89255a2c02b59e77a2e9a8021a0 (refs/notes/commits)
+commit cbacedd14cb8b89255a2c02b59e77a2e9a8021a0
 Author: A U Thor <author@example.com>
 Date:   Mon Jun 26 00:06:00 2006 +0000
 
diff --git a/t/t4013/diff.log_--decorate_--all b/t/t4013/diff.log_--decorate_--all
index f5e20e1e14a..c7df1f58141 100644
--- a/t/t4013/diff.log_--decorate_--all
+++ b/t/t4013/diff.log_--decorate_--all
@@ -20,7 +20,7 @@ Date:   Mon Jun 26 00:06:00 2006 +0000
 
     Rearranged lines in dir/sub
 
-commit cbacedd14cb8b89255a2c02b59e77a2e9a8021a0 (refs/notes/commits)
+commit cbacedd14cb8b89255a2c02b59e77a2e9a8021a0
 Author: A U Thor <author@example.com>
 Date:   Mon Jun 26 00:06:00 2006 +0000
 
diff --git a/t/t4202-log.sh b/t/t4202-log.sh
index 6b7d8e269f7..4c3ce863074 100755
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
@@ -2198,6 +2204,20 @@ test_expect_success 'log --decorate includes all levels of tag annotated tags' '
 	test_cmp expect actual
 '
 
+test_expect_success 'log --decorate does not include things outside filter' '
+	reflist="refs/prefetch refs/rebase-merge refs/bundle" &&
+
+	for ref in $reflist
+	do
+		git update-ref $ref/fake HEAD || return 1
+	done &&
+
+	git log --decorate=full --oneline >actual &&
+
+	# None of the refs are visible:
+	! grep /fake actual
+'
+
 test_expect_success 'log --end-of-options' '
        git update-ref refs/heads/--source HEAD &&
        git log --end-of-options --source >actual &&
-- 
gitgitgadget

