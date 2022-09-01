Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9B26CC54EE9
	for <git@archiver.kernel.org>; Thu,  1 Sep 2022 09:41:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233925AbiIAJlk (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 1 Sep 2022 05:41:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32972 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233699AbiIAJlV (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 1 Sep 2022 05:41:21 -0400
Received: from mail-wr1-x42a.google.com (mail-wr1-x42a.google.com [IPv6:2a00:1450:4864:20::42a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 15B6313251A
        for <git@vger.kernel.org>; Thu,  1 Sep 2022 02:41:19 -0700 (PDT)
Received: by mail-wr1-x42a.google.com with SMTP id c7so14896271wrp.11
        for <git@vger.kernel.org>; Thu, 01 Sep 2022 02:41:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date;
        bh=0ZdoFthGz8MCKDxh11/mf2ZhondxWc0EelMNBObOzuc=;
        b=nKsqiYGGZTeuBKpV3n4x4fzEnG7p7KOEjg0W/BqJdwNZZYSjmScUTycEDxVD/6+gZ5
         bJIhK2kmJalpGtEORP0cybqD8lLDGNSfM81vRW2cZoWaw758p4owPlBbjtfw/wAW3Twk
         t9gGB/E1iQS4/EczXI9SG76JOs6EzXPoUx28nWuKIUmEF0mYpjRYbNT2RV0CDRLMl8IC
         hUazIGDcJES5SYPQOMLdVH5VMd5eogHTJJ+ysaTL+BWjcfFO5kgNVwI5lk/mxLyre4x2
         smdD6ie0VLGH3uuP9Do0UdXjK7w4axuscjAxxu9FZxoI9n7jsmvoT682EDXRvqndG31C
         GEPA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-message-state:from:to:cc
         :subject:date;
        bh=0ZdoFthGz8MCKDxh11/mf2ZhondxWc0EelMNBObOzuc=;
        b=jfVRFzR3Z5ovYVoNWOgBsxG4UOsTSb5NgV0pqSHbZOmD1YvZtl4Ki2GUah+aQuf7s+
         JvLa1nBmh0fpzi9WpLVVAbCpbO+rwr1xhMUbu8rzlpI8k2MyHVd5WWB7KKFn1RmkUhol
         hmq0y4FmXAyHkx5Zf5uF5oVRoY92ifxPxWqmpG7npU+0bKqvUDaiYncuTz+F/0tz+WVu
         JJGUSXCu27tD6tmkg85DUdCzqC02gjzXiGkSITNndrBgFzl5jNphhwG2R3Req2AHQCtF
         +LoTDbxQ0LFYQ3rWaXIN/8lY4Q3kXxHAgSuCZxjgDr2Ka/qBmfSvRyaV3Eb1bxKMLDrp
         WXAA==
X-Gm-Message-State: ACgBeo2v5nSkfAOBKojmsoQ3T0gGQTx71pt3MnlpIfCnh2a54qz7zKhK
        d1Tw0Ulxl2a8sDo1Hd+OABNF74ehx0Q=
X-Google-Smtp-Source: AA6agR6ZfzVUB/dHTVev3n3IDx40GLFlbMaQME2l8UqxYVjvr9TKOYMBgjmdOFi0/PT4zLrUmlBJtg==
X-Received: by 2002:a5d:69c9:0:b0:226:d258:2aec with SMTP id s9-20020a5d69c9000000b00226d2582aecmr13199625wrw.45.1662025277271;
        Thu, 01 Sep 2022 02:41:17 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id x4-20020a5d4904000000b0021e30e9e44asm13976352wrq.53.2022.09.01.02.41.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 01 Sep 2022 02:41:16 -0700 (PDT)
Message-Id: <2f7d1490c43be2a1f363484f1c7031db56b6b673.1662025272.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1343.git.1662025272.gitgitgadget@gmail.com>
References: <pull.1343.git.1662025272.gitgitgadget@gmail.com>
From:   "ZheNing Hu via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Thu, 01 Sep 2022 09:41:12 +0000
Subject: [PATCH 3/3] list-object-filter: introduce depth filter
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Christian Couder <christian.couder@gmail.com>,
        =?UTF-8?Q?=C3=86var_Arnfj=C3=B6r=C3=B0?= Bjarmason 
        <avarab@gmail.com>, Jeff King <peff@peff.net>,
        Jeff Hostetler <jeffhost@microsoft.com>,
        Junio C Hamano <gitster@pobox.com>,
        Derrick Stolee <derrickstolee@github.com>,
        Johannes Schindelin <johannes.schindelin@gmx.de>,
        ZheNing Hu <adlternative@gmail.com>,
        ZheNing Hu <adlternative@gmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: ZheNing Hu <adlternative@gmail.com>

'git clone --depth=<depth>' have a obvious disadvantages:
We can't do some git commands that require looking deeper
commits. We might use 'git fetch -unshallow' to lift this
restriction, but that's not a good idea either: it downloads
too much objects.

Rethink this question: why not integrate the functionality
of shallow clone into parital clone? Partial clone has a
very clear advantage: it downloads objects only if the user
needs them.

Therefore, add a filter 'depth=<depth>' which can omits all
commits whose depth is >= <depth> (<depth> > 0), it just look
like  '--depth=<depth>' in git clone, but the git client
doesn't treat it as a shallow clone.

'--filter=depth:<depth>' cannot be used with '--depth',
'--shallow-since', '--shallow-exclude', '--shallow-submodules'.

Signed-off-by: ZheNing Hu <adlternative@gmail.com>
---
 Documentation/rev-list-options.txt  |   6 ++
 builtin/clone.c                     |  10 ++-
 list-objects-filter-options.c       |  30 +++++++
 list-objects-filter-options.h       |   6 ++
 list-objects-filter.c               |  66 ++++++++++++++++
 shallow.c                           |  16 ++++
 shallow.h                           |   2 +
 t/t5616-partial-clone.sh            | 116 ++++++++++++++++++++++++++++
 t/t6112-rev-list-filters-objects.sh |  14 ++++
 upload-pack.c                       |  14 ----
 upload-pack.h                       |  14 ++++
 11 files changed, 279 insertions(+), 15 deletions(-)

diff --git a/Documentation/rev-list-options.txt b/Documentation/rev-list-options.txt
index 1837509566a..4e2905b9e1e 100644
--- a/Documentation/rev-list-options.txt
+++ b/Documentation/rev-list-options.txt
@@ -954,6 +954,12 @@ Note that the form '--filter=sparse:path=<path>' that wants to read
 from an arbitrary path on the filesystem has been dropped for security
 reasons.
 +
+The form '--filter=depth:<depth>' omits all commits whose depth is
+>= <depth>, it just look like '--depth=<depth>' in git clone, but it
+will not be treated as shallow-clone, so if you want to see some deeper
+commits, you can freely do some git commands e.g. git diff to refetch
+missing git objects without 'git fetch --unshallow'.
++
 Multiple '--filter=' flags can be specified to combine filters. Only
 objects which are accepted by every filter are included.
 +
diff --git a/builtin/clone.c b/builtin/clone.c
index c4ff4643ecd..0b168ec18ef 100644
--- a/builtin/clone.c
+++ b/builtin/clone.c
@@ -916,7 +916,8 @@ int cmd_clone(int argc, const char **argv, const char *prefix)
 		usage_msg_opt(_("You must specify a repository to clone."),
 			builtin_clone_usage, builtin_clone_options);
 
-	if (option_depth || option_since || option_not.nr)
+	if (option_depth || option_since || option_not.nr ||
+	    list_objects_filter_choice_exists(&filter_options, LOFC_DEPTH))
 		deepen = 1;
 	if (option_single_branch == -1)
 		option_single_branch = deepen ? 1 : 0;
@@ -1113,6 +1114,13 @@ int cmd_clone(int argc, const char **argv, const char *prefix)
 		die(_("the option '%s' requires '%s'"),
 		    "--also-filter-submodules", "--recurse-submodules");
 
+	if ((option_depth || option_since || option_not.nr ||
+	     option_shallow_submodules) &&
+	     list_objects_filter_choice_exists(&filter_options, LOFC_DEPTH))
+		die(_("--filter='depth:<depth>' cannot be used with "
+		      "--depth, --shallow-since, --shallow-exclude, "
+		      "--shallow-submodules"));
+
 	/*
 	 * apply the remote name provided by --origin only after this second
 	 * call to git_config, to ensure it overrides all config-based values.
diff --git a/list-objects-filter-options.c b/list-objects-filter-options.c
index 4b25287886d..687010b84d4 100644
--- a/list-objects-filter-options.c
+++ b/list-objects-filter-options.c
@@ -31,6 +31,8 @@ const char *list_object_filter_config_name(enum list_objects_filter_choice c)
 		return "sparse:oid";
 	case LOFC_OBJECT_TYPE:
 		return "object:type";
+	case LOFC_DEPTH:
+		return "depth";
 	case LOFC_COMBINE:
 		return "combine";
 	case LOFC__COUNT:
@@ -40,6 +42,23 @@ const char *list_object_filter_config_name(enum list_objects_filter_choice c)
 	BUG("list_object_filter_config_name: invalid argument '%d'", c);
 }
 
+int list_objects_filter_choice_exists(
+	struct list_objects_filter_options *filter_options,
+	enum list_objects_filter_choice choice) {
+	int i;
+
+	if (!filter_options)
+		return 0;
+
+	if (filter_options->choice == choice)
+		return 1;
+	if (filter_options->sub_nr)
+		for (i = 0; i < filter_options->sub_nr; i++)
+			if (filter_options->sub[i].choice == choice)
+				return 1;
+	return 0;
+}
+
 int gently_parse_list_objects_filter(
 	struct list_objects_filter_options *filter_options,
 	const char *arg,
@@ -97,6 +116,17 @@ int gently_parse_list_objects_filter(
 
 		return 0;
 
+	} else if (skip_prefix(arg, "depth:", &v0)) {
+		if (!git_parse_ulong(v0, &filter_options->depth)) {
+			strbuf_addstr(errbuf, _("expected 'depth:<depth>'"));
+			return 1;
+		} else if (atoi(v0) <= 0) {
+			strbuf_addf(errbuf, _("depth %s is not a positive number"), v0);
+			return 1;
+		}
+		filter_options->choice = LOFC_DEPTH;
+		return 0;
+
 	} else if (skip_prefix(arg, "combine:", &v0)) {
 		return parse_combine_filter(filter_options, v0, errbuf);
 
diff --git a/list-objects-filter-options.h b/list-objects-filter-options.h
index ffc02d77e76..a4fd40567d2 100644
--- a/list-objects-filter-options.h
+++ b/list-objects-filter-options.h
@@ -15,6 +15,7 @@ enum list_objects_filter_choice {
 	LOFC_TREE_DEPTH,
 	LOFC_SPARSE_OID,
 	LOFC_OBJECT_TYPE,
+	LOFC_DEPTH,
 	LOFC_COMBINE,
 	LOFC__COUNT /* must be last */
 };
@@ -54,6 +55,7 @@ struct list_objects_filter_options {
 	 */
 
 	char *sparse_oid_name;
+	unsigned long depth;
 	unsigned long blob_limit_value;
 	unsigned long tree_exclude_depth;
 	enum object_type object_type;
@@ -69,6 +71,10 @@ struct list_objects_filter_options {
 	 */
 };
 
+int list_objects_filter_choice_exists(
+	struct list_objects_filter_options *filter_options,
+	enum list_objects_filter_choice choice);
+
 /*
  * Parse value of the argument to the "filter" keyword.
  * On the command line this looks like:
diff --git a/list-objects-filter.c b/list-objects-filter.c
index 76e8659ea73..5b4d8348b54 100644
--- a/list-objects-filter.c
+++ b/list-objects-filter.c
@@ -13,6 +13,8 @@
 #include "oidmap.h"
 #include "oidset.h"
 #include "object-store.h"
+#include "shallow.h"
+#include "upload-pack.h"
 
 /* Remember to update object flag allocation in object.h */
 /*
@@ -69,6 +71,69 @@ struct filter {
 	struct oidset *omits;
 };
 
+static enum list_objects_filter_result filter_noop(
+	struct repository *r,
+	enum list_objects_filter_situation filter_situation,
+	struct object *obj,
+	const char *pathname,
+	const char *filename,
+	struct oidset *omits,
+	void *filter_data_)
+{
+	switch (filter_situation) {
+	default:
+		BUG("unknown filter_situation: %d", filter_situation);
+
+	case LOFS_TAG:
+		assert(obj->type == OBJ_TAG);
+		/* always include all tag objects */
+		return LOFR_MARK_SEEN | LOFR_DO_SHOW;
+
+	case LOFS_COMMIT:
+		assert(obj->type == OBJ_COMMIT);
+		/* always include all commit objects */
+		return LOFR_MARK_SEEN | LOFR_DO_SHOW;
+
+	case LOFS_BEGIN_TREE:
+		assert(obj->type == OBJ_TREE);
+		/* always include all tree objects */
+		return LOFR_MARK_SEEN | LOFR_DO_SHOW;
+
+	case LOFS_END_TREE:
+		assert(obj->type == OBJ_TREE);
+		return LOFR_ZERO;
+
+	case LOFS_BLOB:
+		assert(obj->type == OBJ_BLOB);
+		/* always include all blob objects */
+		return LOFR_MARK_SEEN | LOFR_DO_SHOW;
+	}
+}
+
+static void noop_free(void *filter_data) {
+	/* noop */
+}
+
+static void filter_depth__init(
+	struct traversal_context *ctx,
+	struct list_objects_filter_options *filter_options,
+	struct filter *filter)
+{
+	struct commit_list *result = get_shallow_commits_by_commits(ctx->revs->commits,
+					filter_options->depth,
+					SHALLOW, NOT_SHALLOW);
+
+	while (result) {
+		register_shallow(the_repository, &result->item->object.oid);
+		result = result->next;
+	}
+	free_commit_list(result);
+
+	filter->filter_object_fn = filter_noop;
+	filter->free_fn = noop_free;
+}
+
+
 static enum list_objects_filter_result filter_blobs_none(
 	struct repository *r,
 	enum list_objects_filter_situation filter_situation,
@@ -774,6 +839,7 @@ static filter_init_fn s_filters[] = {
 	filter_trees_depth__init,
 	filter_sparse_oid__init,
 	filter_object_type__init,
+	filter_depth__init,
 	filter_combine__init,
 };
 
diff --git a/shallow.c b/shallow.c
index 8cb768ee5f8..9d1d7668ad8 100644
--- a/shallow.c
+++ b/shallow.c
@@ -122,6 +122,22 @@ static void free_depth_in_slab(int **ptr)
 {
 	FREE_AND_NULL(*ptr);
 }
+
+struct commit_list *get_shallow_commits_by_commits(struct commit_list *commits, int depth,
+		int shallow_flag, int not_shallow_flag) {
+	struct object_array array = OBJECT_ARRAY_INIT;
+	struct commit_list *result = NULL;
+	struct commit_list *commit = commits;
+
+	while (commit) {
+		add_object_array(&commit->item->object, NULL, &array);
+		commit = commit->next;
+	}
+	result = get_shallow_commits(&array, depth, shallow_flag, not_shallow_flag);
+	object_array_clear(&array);
+	return result;
+}
+
 struct commit_list *get_shallow_commits(struct object_array *heads, int depth,
 		int shallow_flag, int not_shallow_flag)
 {
diff --git a/shallow.h b/shallow.h
index aba6ff58294..ed425b72796 100644
--- a/shallow.h
+++ b/shallow.h
@@ -34,6 +34,8 @@ void rollback_shallow_file(struct repository *r, struct shallow_lock *lk);
 
 struct commit_list *get_shallow_commits(struct object_array *heads,
 					int depth, int shallow_flag, int not_shallow_flag);
+struct commit_list *get_shallow_commits_by_commits(
+		struct commit_list *commits, int depth, int shallow_flag, int not_shallow_flag);
 struct commit_list *get_shallow_commits_by_rev_list(
 		int ac, const char **av, int shallow_flag, int not_shallow_flag);
 int write_shallow_commits(struct strbuf *out, int use_pack_protocol,
diff --git a/t/t5616-partial-clone.sh b/t/t5616-partial-clone.sh
index 9aeacc2f6a5..c328f5d76bc 100755
--- a/t/t5616-partial-clone.sh
+++ b/t/t5616-partial-clone.sh
@@ -458,6 +458,122 @@ test_expect_success 'partial clone with unresolvable sparse filter fails cleanly
 	test_i18ngrep "unable to parse sparse filter data in" err
 '
 
+test_expect_success 'setup src repo for depth filter' '
+	git init depth-src &&
+	git -C depth-src config --local uploadpack.allowfilter 1 &&
+	git -C depth-src config --local uploadpack.allowanysha1inwant 1 &&
+	test_commit -C depth-src one &&
+	test_commit -C depth-src two &&
+	test_commit -C depth-src three &&
+	git -C depth-src rm -rf two.t &&
+	git -C depth-src commit -m four
+'
+
+test_expect_success 'partial clone with depth=1 filter succeeds' '
+	rm -rf dst.git &&
+	git clone --no-local --bare \
+		  --filter=depth:1 \
+		  depth-src dst.git &&
+	(
+		cd dst.git &&
+		git cat-file --batch-check --batch-all-objects >object &&
+		grep blob object >blob_count &&
+		test_line_count = 2 blob_count &&
+		grep tree object >tree_count &&
+		test_line_count = 1 tree_count &&
+		grep commit object >commit_count &&
+		test_line_count = 1 commit_count
+	)
+'
+
+test_expect_success 'partial clone with depth=2 filter succeeds' '
+	rm -rf dst.git &&
+	git clone --no-local --bare \
+		  --filter=depth:2 \
+		  depth-src dst.git &&
+	(
+		cd dst.git &&
+		git cat-file --batch-check --batch-all-objects >object &&
+		grep blob object >blob_count &&
+		test_line_count = 3 blob_count &&
+		grep tree object >tree_count &&
+		test_line_count = 2 tree_count &&
+		grep commit object >commit_count &&
+		test_line_count = 2 commit_count
+	)
+'
+
+test_expect_success 'partial clone depth filter combine with blob:none filter succeeds' '
+	rm -rf dst.git &&
+	git clone --no-local --bare \
+		  --filter="combine:depth:1+blob:none" \
+		  depth-src dst.git &&
+	(
+		cd dst.git &&
+		git cat-file --batch-check --batch-all-objects >object &&
+		! grep blob object &&
+		grep tree object >tree_count &&
+		test_line_count = 1 tree_count &&
+		grep commit object >commit_count &&
+		test_line_count = 1 commit_count
+	)
+'
+
+test_expect_success 'refetch other commits after partial clone with depth filter' '
+	rm -rf dst.git &&
+	git clone --no-local --bare \
+		  --filter=depth:1 \
+		  depth-src dst.git &&
+	(
+		cd dst.git &&
+		git cat-file --batch-check --batch-all-objects >object &&
+		grep blob object >blob_count &&
+		test_line_count = 2 blob_count &&
+		grep tree object >tree_count &&
+		test_line_count = 1 tree_count &&
+		grep commit object >commit_count &&
+		test_line_count = 1 commit_count &&
+		# git log will trigger refetch commits
+		git log &&
+		git cat-file --batch-check --batch-all-objects >object &&
+		grep blob object >blob_count &&
+		test_line_count = 2 blob_count &&
+		grep tree object >tree_count &&
+		test_line_count = 4 tree_count &&
+		grep commit object >commit_count &&
+		test_line_count = 4 commit_count &&
+		# git diff will trigger refetch blobs
+		git diff HEAD^ HEAD &&
+		git cat-file --batch-check --batch-all-objects >object &&
+		grep blob object >blob_count &&
+		test_line_count = 3 blob_count &&
+		grep tree object >tree_count &&
+		test_line_count = 4 tree_count &&
+		grep commit object >commit_count &&
+		test_line_count = 4 commit_count
+	)
+'
+
+test_expect_success 'partial clone with depth filter with shallow clone failed' "
+	rm -rf dst.git &&
+	test_must_fail git clone --no-local --bare \
+		  --filter=depth:1 --depth=1 \
+		  depth-src dst.git 2>err &&
+	test_i18ngrep \"fatal: --filter='depth:<depth>' cannot be used with --depth, --shallow-since, --shallow-exclude, --shallow-submodules\" err &&
+	test_must_fail git clone --no-local --bare \
+		  --filter=depth:1  --shallow-since '300000000 +0700' \
+		  depth-src dst.git 2>err &&
+	test_i18ngrep \"fatal: --filter='depth:<depth>' cannot be used with --depth, --shallow-since, --shallow-exclude, --shallow-submodules\" err &&
+	test_must_fail git clone --no-local --bare \
+		  --filter=depth:1 --shallow-exclude one.t \
+		  depth-src dst.git 2>err &&
+	test_i18ngrep \"fatal: --filter='depth:<depth>' cannot be used with --depth, --shallow-since, --shallow-exclude, --shallow-submodules\" err &&
+	test_must_fail git clone --no-local --bare \
+		  --filter=depth:1 --shallow-submodules \
+		  depth-src dst.git 2>err &&
+	test_i18ngrep \"fatal: --filter='depth:<depth>' cannot be used with --depth, --shallow-since, --shallow-exclude, --shallow-submodules\" err
+"
+
 setup_triangle () {
 	rm -rf big-blob.txt server client promisor-remote &&
 
diff --git a/t/t6112-rev-list-filters-objects.sh b/t/t6112-rev-list-filters-objects.sh
index 8d9d6604f05..a562bdffc80 100755
--- a/t/t6112-rev-list-filters-objects.sh
+++ b/t/t6112-rev-list-filters-objects.sh
@@ -417,6 +417,20 @@ test_expect_success 'verify tree:3 includes everything expected' '
 	test_line_count = 10 actual
 '
 
+test_expect_success 'verify depth:1 includes tip commit expected' '
+	git -C r3 rev-list --objects --filter=depth:1 --no-object-names HEAD >objects &&
+	cat objects | git -C r3 cat-file --batch-check="%(objecttype)" >types &&
+	grep commit types >actual &&
+	test_line_count = 1 actual
+'
+
+test_expect_success 'verify depth:2 includes two commits expected' '
+	git -C r3 rev-list --objects --filter=depth:2 --no-object-names HEAD >objects &&
+	cat objects | git -C r3 cat-file --batch-check="%(objecttype)" >types &&
+	grep commit types >actual &&
+	test_line_count = 2 actual
+'
+
 test_expect_success 'combine:... for a simple combination' '
 	git -C r3 rev-list --objects --filter=combine:tree:2+blob:none HEAD \
 		>actual &&
diff --git a/upload-pack.c b/upload-pack.c
index b217a1f469e..d4ffebfa6ab 100644
--- a/upload-pack.c
+++ b/upload-pack.c
@@ -28,20 +28,6 @@
 #include "commit-reach.h"
 #include "shallow.h"
 
-/* Remember to update object flag allocation in object.h */
-#define THEY_HAVE	(1u << 11)
-#define OUR_REF		(1u << 12)
-#define WANTED		(1u << 13)
-#define COMMON_KNOWN	(1u << 14)
-
-#define SHALLOW		(1u << 16)
-#define NOT_SHALLOW	(1u << 17)
-#define CLIENT_SHALLOW	(1u << 18)
-#define HIDDEN_REF	(1u << 19)
-
-#define ALL_FLAGS (THEY_HAVE | OUR_REF | WANTED | COMMON_KNOWN | SHALLOW | \
-		NOT_SHALLOW | CLIENT_SHALLOW | HIDDEN_REF)
-
 /* Enum for allowed unadvertised object request (UOR) */
 enum allow_uor {
 	/* Allow specifying sha1 if it is a ref tip. */
diff --git a/upload-pack.h b/upload-pack.h
index d6ee25ea98e..36add62f6bc 100644
--- a/upload-pack.h
+++ b/upload-pack.h
@@ -1,6 +1,20 @@
 #ifndef UPLOAD_PACK_H
 #define UPLOAD_PACK_H
 
+/* Remember to update object flag allocation in object.h */
+#define THEY_HAVE	(1u << 11)
+#define OUR_REF		(1u << 12)
+#define WANTED		(1u << 13)
+#define COMMON_KNOWN	(1u << 14)
+
+#define SHALLOW		(1u << 16)
+#define NOT_SHALLOW	(1u << 17)
+#define CLIENT_SHALLOW	(1u << 18)
+#define HIDDEN_REF	(1u << 19)
+
+#define ALL_FLAGS (THEY_HAVE | OUR_REF | WANTED | COMMON_KNOWN | SHALLOW | \
+		NOT_SHALLOW | CLIENT_SHALLOW | HIDDEN_REF)
+
 void upload_pack(const int advertise_refs, const int stateless_rpc,
 		 const int timeout);
 
-- 
gitgitgadget
