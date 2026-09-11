Received: from mail-qk1-f174.google.com (mail-qk1-f174.google.com [209.85.222.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2528619D074
	for <git@vger.kernel.org>; Fri, 11 Sep 2026 20:55:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789160142; cv=none; b=VerLoPYgbElpWvDO8/qvq59GjCSQSk5b7wRdWjdtlmtYt/jnrR4pkBGg1xIXUnjV3mdal4v5RQ6ZKBGTGYRyiMc2zq3fQyKUBjI1ndvqFz7XjN+z08NOzqIAj1+3hq7/ZASnZ4VQy5v5yxyl0CFCyd5qBZVSBY0eNXX7V4cNWLY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789160142; c=relaxed/simple;
	bh=/8Z0IProVajhGihun0XEDWsQmw3fBpiLAGc4aVdOqLY=;
	h=Message-Id:In-Reply-To:References:From:Date:Subject:Content-Type:
	 MIME-Version:To:Cc; b=ft/Enw/m/9JYKvA38uQuTC3PG51Xzzx8EQEG6bzb4N3upuMo+6v6KFhI83W6ruUnqYuky7+cb5kNZ87HHoVi8Z9omiVuBvtPUMxzDwDHfgwyCVtDpT7b2ty2K8iiOmCiI9LtxOWYoGIAniK4xvYgWULc7yoSjWs3ut1niMmhjRI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=svnJSuDp; arc=none smtp.client-ip=209.85.222.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="svnJSuDp"
Received: by mail-qk1-f174.google.com with SMTP id af79cd13be357-939f4f694d1so75285985a.1
        for <git@vger.kernel.org>; Fri, 11 Sep 2026 13:55:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1789160140; x=1789764940; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:content-type:fcc
         :subject:date:from:references:in-reply-to:message-id:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=Wz1nc8acoKdplR4hm8TF3fjPXHBNMvNI9XDHL/UEaUQ=;
        b=svnJSuDpX9pvyHl1qGYSC7UecxleoI+1zDCX6r6MfylVht7lLjfNPPMu2kM3M0o/fP
         W8HLOg/i2DDv8BvZ4RNKuVM+1YP+ev5/GEDRVnv977B3G9+xMA4SNLKwE4KrhhmNANVT
         fZM97v/0wyXAdJw/RcLuJdYoNW/J0nWa6RHgX1s9oXm/Mt9WIq0xPenD0Yt/MB5C3mDi
         07ZLn3nRJwDDPH5WQoJ7Ziuud3jgpn/g1zrPdZI2ImgHE28SUhbzT4kCTz3LHUCirk7r
         b7qrcxOBpSO/uVukdECDZSHwFvyVkK+RPr/z2PhbR0mMw8tSwJwT58CQ+KdROhNPsjwB
         8yiA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1789160140; x=1789764940;
        h=cc:to:mime-version:content-transfer-encoding:content-type:fcc
         :subject:date:from:references:in-reply-to:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=Wz1nc8acoKdplR4hm8TF3fjPXHBNMvNI9XDHL/UEaUQ=;
        b=gbGijqi0SoMQF7hOCiIIaShG2fZhts1a1kCnKQWPwwWbsX6L3Fl6muRLaIqEOxTicb
         0ynOXulL4C1LtweA1UgvBZOs0lN7QQBBH/SOon97VtaCM5aVZ/HZa5U0M6db3SpAyssG
         vC2Q8HSxguIZZIvnpcXuYHmVuPYZGuz84YD7BUqtLr5SscotUssaqwd/8lc3xC8YWRrx
         eK+ek6vXBCsLVreQ+Q/s+PhpiN3Uh4BSkTdyZ5o6WCA0XD6+GWXX25iBVmtLfJumfBHi
         g+NiI1yiMYg6EF66SNSiGTAs+MbtQb+1NsndsdGvk5R0tcnS4Y3a9miXqj+bCZQ3fbNl
         qUCA==
X-Gm-Message-State: AFuF++kOIwxFx+NragZ4BLXabi/MUrgT7ZSBIF3sq56vdXyr7jwfMxck
	1tPuLBjzZRxXP65BKmi3mvWY1zO6Ax9vagPLiXpxxv0CjyMhJbUBlUI+cbgJQA==
X-Gm-Gg: AYBFou0RxijjGebPUxqPwTJiGd6EEZ86n/bdw/JKn5YkphwZOrte+BiMrrfudnoyRfZ
	eWpmwHPLvjmGFQiqDS3BpdP/tLQmvuyu45z7F/aOKdvEwUkKfVdGiSRb5XaBXVP9ZZNUJPh/Tyh
	MF8HK2miPDuqe2UyEbuc4TxlMlCuLDCTY4rtB7ocG2YO0UWaWyvuOmXBEIPrLWKA9s0ZZDR0Ey2
	kr+84H3vuTPqiHcs9QyBiRghWVGo1VdyeqobGkn2t6h/9vkA23qhvJrKCpf1O+/yIkrkyliNEIo
	aczj/3wftMCaidpuqFP5I7eXt7dM7h4lWoHLM4PQh+Y4n3Mk1HfhEvaW+JxT/grz7GYlPQX88sz
	U9HYDt150R77gJ7obT1NxzwR+Y5eTO5p71mBrZAjk8b4Tr3SKxETiWe5gaftAFwpSncbt7jmX72
	5d0m1cM7RlTFpZ9TEcRiMhX38W4kJdEoHUAQQ+k4V2r66r8YyzvaedkwVK3/MFz0BWPNeRt4WLq
	3o=
X-Received: by 2002:a05:620a:40d5:b0:939:3100:750c with SMTP id af79cd13be357-939ea0d4de1mr799233385a.22.1789160139537;
        Fri, 11 Sep 2026 13:55:39 -0700 (PDT)
Received: from [127.0.0.1] ([145.132.99.128])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-939e811cffdsm329720285a.46.2026.09.11.13.55.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 11 Sep 2026 13:55:39 -0700 (PDT)
Message-Id: <pull.2401.v2.git.git.1789160138305.gitgitgadget@gmail.com>
In-Reply-To: <pull.2401.git.git.1789144877632.gitgitgadget@gmail.com>
References: <pull.2401.git.git.1789144877632.gitgitgadget@gmail.com>
From: "Harald Nordgren via GitGitGadget" <gitgitgadget@gmail.com>
Date: Fri, 11 Sep 2026 20:55:38 +0000
Subject: [PATCH v2] range-diff: add --matched-only to skip one-sided commits
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
Cc: Harald Nordgren <haraldnordgren@gmail.com>,
    Harald Nordgren <haraldnordgren@gmail.com>

From: Harald Nordgren <haraldnordgren@gmail.com>

Reviewing a range-diff often means scrolling past commits that were
simply added or dropped, when only the ones that correspond between
the two ranges are of interest.

--left-only and --right-only already each suppress one of those
one-sided groups, but they are defined as "only show this side" and
so cannot be given together, which is exactly why show_range_diff()
already rejected that combination. Give the "show only the commits
that correspond on both sides" behavior its own name, --matched-only,
instead of asking users to reach for a combination that errors out.

Extend the existing '--left-only'/'--right-only' conflict check to
also reject any combination with --matched-only, since all three
narrow the output in ways that cannot be combined.

Signed-off-by: Harald Nordgren <haraldnordgren@gmail.com>
---
    range-diff: add --matched-only to skip one-sided commits
    
    Add git range-diff --matched-only to only show commits that correspond
    between the two ranges, skipping ones that were only added or only
    removed.
    
    Changes in v2:
    
     * Update docs and commit message.
     * Use die_for_incompatible_opt3.

Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-git-2401%2FHaraldNordgren%2Frange-diff-matched-only-v2
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-git-2401/HaraldNordgren/range-diff-matched-only-v2
Pull-Request: https://github.com/git/git/pull/2401

Range-diff vs v1:

 1:  edb4471088 ! 1:  6d392249a2 range-diff: add --matched-only to skip one-sided commits
     @@ Commit message
          the two ranges are of interest.
      
          --left-only and --right-only already each suppress one of those
     -    one-sided groups, so give --matched-only its own name for applying
     -    both suppressions at once instead of documenting the combination of
     -    two options whose names read as contradictory together. Internally it
     -    just sets both flags, reusing the existing suppression logic in
     -    show_range_diff().
     +    one-sided groups, but they are defined as "only show this side" and
     +    so cannot be given together, which is exactly why show_range_diff()
     +    already rejected that combination. Give the "show only the commits
     +    that correspond on both sides" behavior its own name, --matched-only,
     +    instead of asking users to reach for a combination that errors out.
      
     -    Extend the existing '--left-only'/'--right-only' conflict check in
     -    show_range_diff() to also reject any combination with --matched-only,
     -    since all three narrow the output in ways that cannot be combined.
     +    Extend the existing '--left-only'/'--right-only' conflict check to
     +    also reject any combination with --matched-only, since all three
     +    narrow the output in ways that cannot be combined.
      
          Signed-off-by: Harald Nordgren <haraldnordgren@gmail.com>
      
     @@ Documentation/git-range-diff.adoc: to revert to color all lines according to the
       
      +`--matched-only`::
      +	Only emit commits that have a corresponding commit in the other
     -+	range, suppressing any commit that exists on only one side. This is
     -+	the same as using `--left-only` and `--right-only` together. Useful
     ++	range, suppressing any commit that exists on only one side. Useful
      +	to skip added or removed commits when reviewing how the commits
      +	that survived a rebase changed.
      +
     @@ builtin/range-diff.c: int cmd_range_diff(int argc,
       	strvec_clear(&log_arg);
      
       ## range-diff.c ##
     +@@
     + #include "userdiff.h"
     + #include "apply.h"
     + #include "revision.h"
     ++#include "parse-options.h"
     + 
     + struct patch_util {
     + 	/* For the search for an exact match */
      @@ range-diff.c: int show_range_diff(const char *range1, const char *range2,
       	struct string_list branch2 = STRING_LIST_INIT_DUP;
       	unsigned int include_merges = range_diff_opts->include_merges;
       
      -	if (range_diff_opts->left_only && range_diff_opts->right_only)
      -		res = error(_("options '%s' and '%s' cannot be used together"), "--left-only", "--right-only");
     -+	if (range_diff_opts->left_only + range_diff_opts->right_only +
     -+	    range_diff_opts->matched_only > 1)
     -+		res = error(_("options '%s', '%s', or '%s' cannot be used together"),
     -+			    "--left-only", "--right-only", "--matched-only");
     -+
     ++	die_for_incompatible_opt3(range_diff_opts->left_only, "--left-only",
     ++				  range_diff_opts->right_only, "--right-only",
     ++				  range_diff_opts->matched_only, "--matched-only");
     + 
     +-	if (!res && read_patches(range1, &branch1, range_diff_opts->log_arg, include_merges))
      +	if (range_diff_opts->matched_only) {
      +		range_diff_opts->left_only = 1;
      +		range_diff_opts->right_only = 1;
      +	}
     - 
     - 	if (!res && read_patches(range1, &branch1, range_diff_opts->log_arg, include_merges))
     ++
     ++	if (read_patches(range1, &branch1, range_diff_opts->log_arg, include_merges))
       		res = error(_("could not parse log for '%s'"), range1);
     + 	if (!res && read_patches(range2, &branch2, range_diff_opts->log_arg, include_merges))
     + 		res = error(_("could not parse log for '%s'"), range2);
      
       ## range-diff.h ##
      @@


 Documentation/git-range-diff.adoc |  9 ++++-
 builtin/range-diff.c              |  5 ++-
 range-diff.c                      | 13 +++++--
 range-diff.h                      |  2 +-
 t/t3206-range-diff.sh             | 63 +++++++++++++++++++++++++++++++
 5 files changed, 86 insertions(+), 6 deletions(-)

diff --git a/Documentation/git-range-diff.adoc b/Documentation/git-range-diff.adoc
index 5cc5e2ed56..d448f897d6 100644
--- a/Documentation/git-range-diff.adoc
+++ b/Documentation/git-range-diff.adoc
@@ -10,7 +10,8 @@ SYNOPSIS
 [synopsis]
 git range-diff [--color=[<when>]] [--no-color] [<diff-options>]
 	[--no-dual-color] [--creation-factor=<factor>]
-	[--left-only | --right-only] [--diff-merges=<format>]
+	[--left-only | --right-only | --matched-only]
+	[--diff-merges=<format>]
 	[--remerge-diff] [--no-notes | --notes[=<ref>]]
 	( <range1> <range2> | <rev1>...<rev2> | <base> <rev1> <rev2> )
 	[[--] <path>...]
@@ -82,6 +83,12 @@ to revert to color all lines according to the outer diff markers
 	Suppress commits that are missing from the second specified range
 	(or the "right range" when using the `<rev1>...<rev2>` form).
 
+`--matched-only`::
+	Only emit commits that have a corresponding commit in the other
+	range, suppressing any commit that exists on only one side. Useful
+	to skip added or removed commits when reviewing how the commits
+	that survived a rebase changed.
+
 `--diff-merges=<format>`::
 	Instead of ignoring merge commits, generate diffs for them using the
 	corresponding `--diff-merges=<format>` option of linkgit:git-log[1],
diff --git a/builtin/range-diff.c b/builtin/range-diff.c
index e54c0f7fe1..8059f92eaa 100644
--- a/builtin/range-diff.c
+++ b/builtin/range-diff.c
@@ -46,7 +46,7 @@ int cmd_range_diff(int argc,
 		.diffopt = &diffopt,
 		.log_arg = &log_arg
 	};
-	int simple_color = -1, left_only = 0, right_only = 0;
+	int simple_color = -1, left_only = 0, right_only = 0, matched_only = 0;
 	struct option range_diff_options[] = {
 		OPT_INTEGER(0, "creation-factor",
 			    &range_diff_opts.creation_factor,
@@ -68,6 +68,8 @@ int cmd_range_diff(int argc,
 			 N_("only emit output related to the first range")),
 		OPT_BOOL(0, "right-only", &right_only,
 			 N_("only emit output related to the second range")),
+		OPT_BOOL(0, "matched-only", &matched_only,
+			 N_("only emit commits that have a corresponding commit in the other range")),
 		OPT_END()
 	};
 	struct option *options;
@@ -186,6 +188,7 @@ int cmd_range_diff(int argc,
 	range_diff_opts.dual_color = simple_color < 1;
 	range_diff_opts.left_only = left_only;
 	range_diff_opts.right_only = right_only;
+	range_diff_opts.matched_only = matched_only;
 	res = show_range_diff(range1.buf, range2.buf, &range_diff_opts);
 
 	strvec_clear(&log_arg);
diff --git a/range-diff.c b/range-diff.c
index 8e2dd2eb19..67cc751658 100644
--- a/range-diff.c
+++ b/range-diff.c
@@ -20,6 +20,7 @@
 #include "userdiff.h"
 #include "apply.h"
 #include "revision.h"
+#include "parse-options.h"
 
 struct patch_util {
 	/* For the search for an exact match */
@@ -591,10 +592,16 @@ int show_range_diff(const char *range1, const char *range2,
 	struct string_list branch2 = STRING_LIST_INIT_DUP;
 	unsigned int include_merges = range_diff_opts->include_merges;
 
-	if (range_diff_opts->left_only && range_diff_opts->right_only)
-		res = error(_("options '%s' and '%s' cannot be used together"), "--left-only", "--right-only");
+	die_for_incompatible_opt3(range_diff_opts->left_only, "--left-only",
+				  range_diff_opts->right_only, "--right-only",
+				  range_diff_opts->matched_only, "--matched-only");
 
-	if (!res && read_patches(range1, &branch1, range_diff_opts->log_arg, include_merges))
+	if (range_diff_opts->matched_only) {
+		range_diff_opts->left_only = 1;
+		range_diff_opts->right_only = 1;
+	}
+
+	if (read_patches(range1, &branch1, range_diff_opts->log_arg, include_merges))
 		res = error(_("could not parse log for '%s'"), range1);
 	if (!res && read_patches(range2, &branch2, range_diff_opts->log_arg, include_merges))
 		res = error(_("could not parse log for '%s'"), range2);
diff --git a/range-diff.h b/range-diff.h
index 9b70a80009..effd10b9b8 100644
--- a/range-diff.h
+++ b/range-diff.h
@@ -19,7 +19,7 @@
 struct range_diff_options {
 	int creation_factor;
 	unsigned dual_color:1;
-	unsigned left_only:1, right_only:1;
+	unsigned left_only:1, right_only:1, matched_only:1;
 	unsigned include_merges:1;
 	size_t max_memory;
 	const struct diff_options *diffopt; /* may be NULL */
diff --git a/t/t3206-range-diff.sh b/t/t3206-range-diff.sh
index ef92704de3..f85fd0c4ad 100755
--- a/t/t3206-range-diff.sh
+++ b/t/t3206-range-diff.sh
@@ -860,6 +860,69 @@ test_expect_success '--left-only/--right-only' '
 	test_cmp expect actual
 '
 
+test_expect_success '--left-only, --right-only and --matched-only are incompatible' '
+	test_must_fail git range-diff --left-only --right-only ...common 2>err &&
+	test_grep "cannot be used together" err &&
+
+	test_must_fail git range-diff --left-only --matched-only ...common 2>err &&
+	test_grep "cannot be used together" err &&
+
+	test_must_fail git range-diff --right-only --matched-only ...common 2>err &&
+	test_grep "cannot be used together" err &&
+
+	test_must_fail git range-diff --left-only --right-only --matched-only \
+		...common 2>err &&
+	test_grep "cannot be used together" err
+'
+
+test_expect_success '--left-only, --right-only and --matched-only each suppress one-sided commits' '
+	test_create_repo matched-only &&
+	(
+		cd matched-only &&
+		git switch --orphan combined-old &&
+		test_commit c-first &&
+		test_commit c-old-only &&
+		test_commit c-common &&
+		git switch -C combined-new c-first &&
+		test_commit c-new-only &&
+		git cherry-pick c-common &&
+
+		old_only_oid=$(git rev-parse --short=7 c-old-only) &&
+		new_only_oid=$(git rev-parse --short=7 c-new-only) &&
+		common_old_oid=$(git rev-parse --short=7 c-common) &&
+		common_new_oid=$(git rev-parse --short=7 HEAD) &&
+
+		git range-diff -s --abbrev=7 combined-old...combined-new >actual &&
+		cat >expect <<-EOF &&
+		1:  $old_only_oid < -:  ------- c-old-only
+		-:  ------- > 1:  $new_only_oid c-new-only
+		2:  $common_old_oid = 2:  $common_new_oid c-common
+		EOF
+		test_cmp expect actual &&
+
+		git range-diff -s --abbrev=7 --left-only combined-old...combined-new \
+			>actual &&
+		cat >expect <<-EOF &&
+		1:  $old_only_oid < -:  ------- c-old-only
+		2:  $common_old_oid = 2:  $common_new_oid c-common
+		EOF
+		test_cmp expect actual &&
+
+		git range-diff -s --abbrev=7 --right-only combined-old...combined-new \
+			>actual &&
+		cat >expect <<-EOF &&
+		-:  ------- > 1:  $new_only_oid c-new-only
+		2:  $common_old_oid = 2:  $common_new_oid c-common
+		EOF
+		test_cmp expect actual &&
+
+		git range-diff -s --abbrev=7 --matched-only combined-old...combined-new \
+			>actual &&
+		echo "2:  $common_old_oid = 2:  $common_new_oid c-common" >expect &&
+		test_cmp expect actual
+	)
+'
+
 test_expect_success 'ranges with pathspecs' '
 	git range-diff topic...mode-only-change -- other-file >actual &&
 	test_line_count = 2 actual &&

base-commit: 47ce80527c56f462cb97db4ca8125342204d3783
-- 
gitgitgadget
