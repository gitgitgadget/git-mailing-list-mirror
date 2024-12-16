Received: from mail-wr1-f52.google.com (mail-wr1-f52.google.com [209.85.221.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 227292063D6
	for <git@vger.kernel.org>; Mon, 16 Dec 2024 14:11:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734358291; cv=none; b=RULfyVp0wjCVhfeIHkPnIqzLdrhhsPiqGqxpu6IJv55bHA1Grwlg2w0Ox3yYDiSZyDpmaefQnpp+JiA7lKltuihhYez1yW2T1pNxkq2uwTUERe1+4bvH7YeXlUPJfejR/Cjj6xmW0IzMQukB+9McAABZ9rzoYWXAzubEGbGtJ2g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734358291; c=relaxed/simple;
	bh=8zCVOGbdjg2xAIwZzcgzz/JYGYVz2keuVOgFXhlyk5I=;
	h=Message-Id:In-Reply-To:References:From:Date:Subject:Content-Type:
	 MIME-Version:To:Cc; b=Z6W7n2sV/3/VtsuSpYItUGuMlbt5ZledBksqkXJoF7zswFRu1TIzziRPFjctZgM34IhhNIY86C69FXEYvtXyIRDRKTfOXM7TQBzIV83ONek/NpjXaNw7llE7dhvyKQjDUQysyhu0I0ar1flWXVh5eJoDMxhhsS9YxeXcDaoZ9IM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Z7bNU5AQ; arc=none smtp.client-ip=209.85.221.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Z7bNU5AQ"
Received: by mail-wr1-f52.google.com with SMTP id ffacd0b85a97d-3862ca8e0bbso3608204f8f.0
        for <git@vger.kernel.org>; Mon, 16 Dec 2024 06:11:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1734358286; x=1734963086; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=tBKMcM3rCrKVYXhCf3GRfeM3dWwruYmHJaDslX3dxGs=;
        b=Z7bNU5AQEFDBETDA3T9YN6urMGpjiY8hDK7yey+jK3PR/i2S6MxFsP41/C7ZgRqBFZ
         myG6WuP+VzjHhtcW1Ad0o9Uc7IwoOwISy1SMEm98A1SiXl2FHl2LhwYPtQVD82Rnov/Z
         Z3h0dLjXOXFR8rmakkUB3+VUTAM4Bq6SkWj/fipIzf0dyArM9AbY5YnXpV44HGbd6iP1
         2fegGhii/72nKC8HNuh8RxdbB+2owiSKzxDp7jefV6Re9xQtkqQ2rpoBqOo31f+gWQ2l
         nGNeGUHnf7kOIWLaHF3wgrw1vhJfNkd/6BIAm++wsfOzg3CDYoEH1pQgXwXbJr/RrrDe
         tBUg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1734358286; x=1734963086;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=tBKMcM3rCrKVYXhCf3GRfeM3dWwruYmHJaDslX3dxGs=;
        b=ZN2mxx4p4gR0v5eHDJ3LDzNcBZrB1z0uM+bxpHVlu2UZntP+XCrvhuKv0McMY4ElM6
         rES8Jz3DYDh0ZVdMAwhOhrKhsOYXtsCLg0ZCjWc4DwMmT2E8F98mpM49kXJZ0YrNExRA
         vWgUudmcDc2ABn0XgNXSkKm25T06YzQwLdOLTu8y60yg5JyPkKfmxXRwcTFFmJ9BQmc1
         gZjw8+CXqsAfBKmRLcQgzQmZDS3KW/2v9ixA4QDXUs/+Zv1nCEHFzrmWocCctHBl/+xg
         V6Qn7A0RGwj/8HO5syQtqG4ki7TVbC6Nz7CmuvKoS9smfNg4PG2+qFQpXgrNtx0jStPQ
         qfuA==
X-Gm-Message-State: AOJu0YywyhmdACyBCz0Khl3epkMfUs5YDwtFvyffQP6v2DPa09oYbd6M
	DWxozHNuX35rRXRKV0lYlUt1vKNtzkusFLV707TLCscVo0SYMQtOS5LD7Q==
X-Gm-Gg: ASbGncv+yG8/607xC9ATGeDuGxW6Q/JV3bJzrgEufYOT2UO+bxJ/OqjwdVLOpy5QH1q
	qFfIxW//dqk5Hug3j9xqCs6+6Tkmw2gKayM6xv2mGCvlOtqYKF25rhXgOdIzAm4/G8nQ6NOzzQl
	hC5Bv5isI3NxOQwMP0RzFpjyQSRdHKMlZFoZEJgZW25rrLquQ7ChxILkkL5E1qQUQxsmuctE74A
	6LrRtj54PIWgmITgaLhCN3ebSMJd5B9Un07MU8d+N1m0GZ/XdLw7NL5Fg==
X-Google-Smtp-Source: AGHT+IEdOu11K2Ol0T1dHW0FwQm/QXbKC0xPYIqgQabuZx9hOLzwSI6Rw9nhUF8sLXCQ7CYMo5S+UA==
X-Received: by 2002:a05:6000:18c6:b0:385:fe66:9f32 with SMTP id ffacd0b85a97d-3888e0bfcc4mr9201399f8f.52.1734358286056;
        Mon, 16 Dec 2024 06:11:26 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-388c801233asm8497297f8f.9.2024.12.16.06.11.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 16 Dec 2024 06:11:25 -0800 (PST)
Message-Id: <ef3c243da1b3215000684a6b2d683dc6bb0017ac.1734358282.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1734.v3.git.1734358282.gitgitgadget@gmail.com>
References: <pull.1734.v2.git.1731073383564.gitgitgadget@gmail.com>
	<pull.1734.v3.git.1734358282.gitgitgadget@gmail.com>
From: "Johannes Schindelin via GitGitGadget" <gitgitgadget@gmail.com>
Date: Mon, 16 Dec 2024 14:11:21 +0000
Subject: [PATCH v3 1/2] range-diff: optionally include merge commits' diffs in
 the analysis
Fcc: Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
To: git@vger.kernel.org
Cc: Philippe Blain <levraiphilippeblain@gmail.com>,
    Johannes Sixt <j6t@kdbg.org>,
    Elijah Newren <newren@gmail.com>,
    Johannes Schindelin <johannes.schindelin@gmx.de>,
    Johannes Schindelin <johannes.schindelin@gmx.de>

From: Johannes Schindelin <johannes.schindelin@gmx.de>

The `git log` command already offers support for including diffs for
merges, via the `--diff-merges=<format>` option.

Let's add corresponding support for `git range-diff`, too. This makes it
more convenient to spot differences between commit ranges that contain
merges.

This is especially true in scenarios with non-trivial merges, i.e.
merges introducing changes other than, or in addition to, what merge ORT
would have produced. Merging a topic branch that changes a function
signature into a branch that added a caller of that function, for
example, would require the merge commit itself to adjust that caller to
the modified signature.

In my code reviews, I found the `--diff-merges=remerge` option
particularly useful.

Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
---
 Documentation/git-range-diff.txt | 13 ++++++++++++-
 builtin/range-diff.c             | 10 ++++++++++
 range-diff.c                     | 17 ++++++++++++-----
 range-diff.h                     |  1 +
 t/t3206-range-diff.sh            | 16 ++++++++++++++++
 5 files changed, 51 insertions(+), 6 deletions(-)

diff --git a/Documentation/git-range-diff.txt b/Documentation/git-range-diff.txt
index 0b393715d70..150b0acbd86 100644
--- a/Documentation/git-range-diff.txt
+++ b/Documentation/git-range-diff.txt
@@ -10,7 +10,7 @@ SYNOPSIS
 [verse]
 'git range-diff' [--color=[<when>]] [--no-color] [<diff-options>]
 	[--no-dual-color] [--creation-factor=<factor>]
-	[--left-only | --right-only]
+	[--left-only | --right-only] [--diff-merges=<format>]
 	( <range1> <range2> | <rev1>...<rev2> | <base> <rev1> <rev2> )
 	[[--] <path>...]
 
@@ -81,6 +81,17 @@ to revert to color all lines according to the outer diff markers
 	Suppress commits that are missing from the second specified range
 	(or the "right range" when using the `<rev1>...<rev2>` format).
 
+--diff-merges=<format>::
+	Instead of ignoring merge commits, generate diffs for them using the
+	corresponding `--diff-merges=<format>` option of linkgit:git-log[1],
+	and include them in the comparison.
++
+Note: In the common case, the `remerge` mode will be the most natural one
+to use, as it shows only the diff on top of what Git's merge machinery would
+have produced. In other words, if a merge commit is the result of a
+non-conflicting `git merge`, the `remerge` mode will represent it with an empty
+diff.
+
 --[no-]notes[=<ref>]::
 	This flag is passed to the `git log` program
 	(see linkgit:git-log[1]) that generates the patches.
diff --git a/builtin/range-diff.c b/builtin/range-diff.c
index aecfae12d3a..9d6236e5116 100644
--- a/builtin/range-diff.c
+++ b/builtin/range-diff.c
@@ -16,6 +16,7 @@ int cmd_range_diff(int argc, const char **argv, const char *prefix)
 {
 	struct diff_options diffopt = { NULL };
 	struct strvec other_arg = STRVEC_INIT;
+	struct strvec diff_merges_arg = STRVEC_INIT;
 	struct range_diff_options range_diff_opts = {
 		.creation_factor = RANGE_DIFF_CREATION_FACTOR_DEFAULT,
 		.diffopt = &diffopt,
@@ -31,6 +32,8 @@ int cmd_range_diff(int argc, const char **argv, const char *prefix)
 		OPT_PASSTHRU_ARGV(0, "notes", &other_arg,
 				  N_("notes"), N_("passed to 'git log'"),
 				  PARSE_OPT_OPTARG),
+		OPT_PASSTHRU_ARGV(0, "diff-merges", &diff_merges_arg,
+				  N_("style"), N_("passed to 'git log'"), 0),
 		OPT_BOOL(0, "left-only", &left_only,
 			 N_("only emit output related to the first range")),
 		OPT_BOOL(0, "right-only", &right_only,
@@ -57,6 +60,12 @@ int cmd_range_diff(int argc, const char **argv, const char *prefix)
 	if (!simple_color)
 		diffopt.use_color = 1;
 
+	/* If `--diff-merges` was specified, imply `--merges` */
+	if (diff_merges_arg.nr) {
+		range_diff_opts.include_merges = 1;
+		strvec_pushv(&other_arg, diff_merges_arg.v);
+	}
+
 	for (i = 0; i < argc; i++)
 		if (!strcmp(argv[i], "--")) {
 			dash_dash = i;
@@ -150,6 +159,7 @@ int cmd_range_diff(int argc, const char **argv, const char *prefix)
 	res = show_range_diff(range1.buf, range2.buf, &range_diff_opts);
 
 	strvec_clear(&other_arg);
+	strvec_clear(&diff_merges_arg);
 	strbuf_release(&range1);
 	strbuf_release(&range2);
 
diff --git a/range-diff.c b/range-diff.c
index 4bd65ab7496..3bd7bff4735 100644
--- a/range-diff.c
+++ b/range-diff.c
@@ -31,7 +31,8 @@ struct patch_util {
  * as struct object_id (will need to be free()d).
  */
 static int read_patches(const char *range, struct string_list *list,
-			const struct strvec *other_arg)
+			const struct strvec *other_arg,
+			unsigned int include_merges)
 {
 	struct child_process cp = CHILD_PROCESS_INIT;
 	struct strbuf buf = STRBUF_INIT, contents = STRBUF_INIT;
@@ -42,7 +43,7 @@ static int read_patches(const char *range, struct string_list *list,
 	size_t size;
 	int ret = -1;
 
-	strvec_pushl(&cp.args, "log", "--no-color", "-p", "--no-merges",
+	strvec_pushl(&cp.args, "log", "--no-color", "-p",
 		     "--reverse", "--date-order", "--decorate=no",
 		     "--no-prefix", "--submodule=short",
 		     /*
@@ -57,6 +58,8 @@ static int read_patches(const char *range, struct string_list *list,
 		     "--pretty=medium",
 		     "--notes",
 		     NULL);
+	if (!include_merges)
+		strvec_push(&cp.args, "--no-merges");
 	strvec_push(&cp.args, range);
 	if (other_arg)
 		strvec_pushv(&cp.args, other_arg->v);
@@ -89,12 +92,15 @@ static int read_patches(const char *range, struct string_list *list,
 		}
 
 		if (skip_prefix(line, "commit ", &p)) {
+			char *q;
 			if (util) {
 				string_list_append(list, buf.buf)->util = util;
 				strbuf_reset(&buf);
 			}
 			CALLOC_ARRAY(util, 1);
-			if (get_oid(p, &util->oid)) {
+			if (include_merges && (q = strstr(p, " (from ")))
+				*q = '\0';
+			if (repo_get_oid(the_repository, p, &util->oid)) {
 				error(_("could not parse commit '%s'"), p);
 				FREE_AND_NULL(util);
 				string_list_clear(list, 1);
@@ -559,13 +565,14 @@ int show_range_diff(const char *range1, const char *range2,
 
 	struct string_list branch1 = STRING_LIST_INIT_DUP;
 	struct string_list branch2 = STRING_LIST_INIT_DUP;
+	unsigned int include_merges = range_diff_opts->include_merges;
 
 	if (range_diff_opts->left_only && range_diff_opts->right_only)
 		res = error(_("options '%s' and '%s' cannot be used together"), "--left-only", "--right-only");
 
-	if (!res && read_patches(range1, &branch1, range_diff_opts->other_arg))
+	if (!res && read_patches(range1, &branch1, range_diff_opts->other_arg, include_merges))
 		res = error(_("could not parse log for '%s'"), range1);
-	if (!res && read_patches(range2, &branch2, range_diff_opts->other_arg))
+	if (!res && read_patches(range2, &branch2, range_diff_opts->other_arg, include_merges))
 		res = error(_("could not parse log for '%s'"), range2);
 
 	if (!res) {
diff --git a/range-diff.h b/range-diff.h
index 04ffe217be6..9753922fee9 100644
--- a/range-diff.h
+++ b/range-diff.h
@@ -10,6 +10,7 @@ struct range_diff_options {
 	int creation_factor;
 	unsigned dual_color:1;
 	unsigned left_only:1, right_only:1;
+	unsigned include_merges:1;
 	const struct diff_options *diffopt; /* may be NULL */
 	const struct strvec *other_arg; /* may be NULL */
 };
diff --git a/t/t3206-range-diff.sh b/t/t3206-range-diff.sh
index b5f4d6a6530..d3c4d2dbb49 100755
--- a/t/t3206-range-diff.sh
+++ b/t/t3206-range-diff.sh
@@ -866,4 +866,20 @@ test_expect_success 'submodule changes are shown irrespective of diff.submodule'
 	test_cmp expect actual
 '
 
+test_expect_success '--diff-merges' '
+	renamed_oid=$(git rev-parse --short renamed-file) &&
+	tree=$(git merge-tree unmodified renamed-file) &&
+	clean=$(git commit-tree -m merge -p unmodified -p renamed-file $tree) &&
+	clean_oid=$(git rev-parse --short $clean) &&
+	conflict=$(git commit-tree -m merge -p unmodified -p renamed-file^ $tree) &&
+	conflict_oid=$(git rev-parse --short $conflict) &&
+
+	git range-diff --diff-merges=1 $clean...$conflict >actual &&
+	cat >expect <<-EOF &&
+	1:  $renamed_oid < -:  ------- s/12/B/
+	2:  $clean_oid = 1:  $conflict_oid merge
+	EOF
+	test_cmp expect actual
+'
+
 test_done
-- 
gitgitgadget

