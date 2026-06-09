Received: from mail-qt1-f178.google.com (mail-qt1-f178.google.com [209.85.160.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8795D3CCFD8
	for <git@vger.kernel.org>; Tue,  9 Jun 2026 10:12:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780999922; cv=none; b=PfDXkcTU2fWtQrhyx3wjCl2VL6D1Ys3IAS3d/VqQiGxjCTcQiJyW02BHGqZaMV0n9hVAUlo29XDGDLHcdpRGEQkH6ZpMSKg3q26058xXv9/woj95Wr2nQGB4S/vwDhxkcon1AHOAoAmUWw8W8oOMq6trDHSdeaF1I7p082rDKK0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780999922; c=relaxed/simple;
	bh=ANSemZI6k0QJ39E/l/4qMQgeNSJrgQgnZ2WV6E+d6zM=;
	h=Message-Id:In-Reply-To:References:From:Date:Subject:Content-Type:
	 MIME-Version:To:Cc; b=i9heruyKjUMxbTN5o5B34iL1z0blOWEzBj2KsIVLvcy+UX/NBpi9CDQQCVrnLvLksZfMMyxFC7FGLTb7s9TJeaN+EBOVWW44TT3xeouTTkYe71aoc2SnocfHp4PNwMe2EsAnfgmbgLEOyeFJRDl1ksa0fmHrsSsVW23XyQa2Gyg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=tAF1KF2A; arc=none smtp.client-ip=209.85.160.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="tAF1KF2A"
Received: by mail-qt1-f178.google.com with SMTP id d75a77b69052e-516d0db9372so42933861cf.2
        for <git@vger.kernel.org>; Tue, 09 Jun 2026 03:12:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1780999919; x=1781604719; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=UbcscQ46XIbbG6kC0aXa6J/L91ZclIuUSlGU76W/TQQ=;
        b=tAF1KF2AuITVHkRSJ+Umj8IhExvCqAK1SXPkP+g9+zmIl5FZZFmV1mJo+KRQGKU08P
         4PYla2a0ezbyLpwzINqL0etNKCY6zgt590ePzjdJzs8HZtH7GprrlvauinOlrdoTpovt
         PT/XKx+qUOwnAvuC7qMReKlqOu03DQwvPyGywgWzgTSK5spwT/4K0FyaATtMLcfYOxHr
         M6tZcJ7T/HbipJk/ARUEkwEX/afLRM6uhqtprhudN8fGjjKeRHTJQgsm0Xo8Sx4e6bnV
         8+csL1tMXwiwE6NE3OPLHnyzJRtUOGQ9C77qmLWqBDPDXP/0Eu4sJoHErf/ZW3qwnCGu
         Ad6w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780999919; x=1781604719;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=UbcscQ46XIbbG6kC0aXa6J/L91ZclIuUSlGU76W/TQQ=;
        b=nAY/I0jvzNZZeA5XyBmNhonThJhc2fw36yCA/sTxp/8/XK7zdJtzuDtRi+uFMwWgG/
         sym3wPjMlkNYupTJKZtNV5v6FMB12PRPTL+oQlpcdoeuM0ztLyDYbzcdH8ejC8kPt78O
         6LoAtgjSdvfcD5wWOFtuS4l6bmDDXQueVItGWANtlVZzfRZu+Psuv1KJn8ehwXzzkJ5q
         s1EGO3pz3kOV4r+f+7meOmNo60SNrgkZY/vajCrjuajpR3Bm5GrgGrHX0tTRGGAulwnr
         qCenIxUf3DC2FHdRS+f+YiwdGiZSDJcziowLrfmwP5b8Oetd4Y1ECeJKMvFr+KmPhwt3
         PANg==
X-Gm-Message-State: AOJu0YysSsppTH0gDMrP2MfDv+a58Ug3jxB1kmhbLBWJ4JfyMqLdrbTg
	SCoRVL9HxvhFm+G2bNyXsjVNaYKv2ITqhyQSDaGnGrWgMfRQtkfM19ZBkvVskvXS
X-Gm-Gg: Acq92OGQxTp76nV15NArXGKDR+3ILEdzs6/fWMn2hDXXioXq1xdkk0m1Qom3fyr9oMN
	7fjJ8Kj4zFBcgQXkd14uqioJPr3so8TokzA0Mek2LvJQ6CGFLjoKR/qRY70N9wl5wt5UAJduIkG
	oATUUQPHfUXw2q7t8TBcmGUUBOMJ63qdSHPjj/Nq7dtGvOeVujJ5pj79DqFezvqw6EXQQZ6c5YM
	/3ykn+CMk/TeWF37xX7rLfhFch5gVBnyavi4L8WPK9oAj2oxzXbq274E8XjunjT1N4LiR4gRVCz
	ma8YMbWcLw50d9DAElRHrvaEz93NgdNHJE3ejg0wA28yRQ6HDRDOWr61N8X/L/1AdZZyrvU1jCX
	i02iIZFV2i8EIVNvmqke44t1fBczClBihqp/r5PgOO5m/yBtwIgZgjW/hB8v37pPPR5UG/cc3bc
	kYzPm9r5VB9NQMEtpc1daEUIA5seQqCaCJL6wy582KXhpJ
X-Received: by 2002:a05:622a:6205:b0:517:85e1:38a2 with SMTP id d75a77b69052e-51795c22a42mr271234571cf.31.1780999919331;
        Tue, 09 Jun 2026 03:11:59 -0700 (PDT)
Received: from [127.0.0.1] ([20.42.9.226])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-517940762fbsm127495591cf.18.2026.06.09.03.11.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 09 Jun 2026 03:11:58 -0700 (PDT)
Message-Id: <7383872f4b2f422ec36b11ab5fb31cce08e6106a.1780999917.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.2285.v14.git.git.1780999917.gitgitgadget@gmail.com>
References: <pull.2285.v13.git.git.1780684553.gitgitgadget@gmail.com>
	<pull.2285.v14.git.git.1780999917.gitgitgadget@gmail.com>
From: "Harald Nordgren via GitGitGadget" <gitgitgadget@gmail.com>
Date: Tue, 09 Jun 2026 10:11:52 +0000
Subject: [PATCH v14 1/6] branch: add --forked filter for --list mode
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
Cc: Kristoffer Haugsbakk <kristofferhaugsbakk@fastmail.com>,
    Johannes Sixt <j6t@kdbg.org>,
    Phillip Wood <phillip.wood123@gmail.com>,
    Harald Nordgren <haraldnordgren@gmail.com>,
    Harald Nordgren <haraldnordgren@gmail.com>

From: Harald Nordgren <haraldnordgren@gmail.com>

Add a --forked option to "git branch" list mode that lists only
branches whose configured upstream matches <branch>. The argument
can be a ref (e.g. "origin/main", "master") or a shell glob
(e.g. "origin/*"), and may be repeated to widen the filter.

It is an ordinary list filter, so it combines with the others:

    git branch --merged origin/main --forked 'origin/*'

lists branches forked from origin that are already merged into
origin/main, and --no-merged inverts the question.

This is the building block for --prune-merged, which deletes the
listed branches once they have landed on their upstream.

Signed-off-by: Harald Nordgren <haraldnordgren@gmail.com>
---
 Documentation/git-branch.adoc | 10 +++-
 builtin/branch.c              | 18 ++++++-
 ref-filter.c                  | 70 ++++++++++++++++++++++++++
 ref-filter.h                  | 10 ++++
 t/t3200-branch.sh             | 92 +++++++++++++++++++++++++++++++++++
 5 files changed, 197 insertions(+), 3 deletions(-)

diff --git a/Documentation/git-branch.adoc b/Documentation/git-branch.adoc
index c0afddc424..62ebab6051 100644
--- a/Documentation/git-branch.adoc
+++ b/Documentation/git-branch.adoc
@@ -13,6 +13,7 @@ git branch [--color[=<when>] | --no-color] [--show-current]
 	   [--column[=<options>] | --no-column] [--sort=<key>]
 	   [--merged [<commit>]] [--no-merged [<commit>]]
 	   [--contains [<commit>]] [--no-contains [<commit>]]
+	   [(--forked <branch>)...]
 	   [--points-at <object>] [--format=<format>]
 	   [(-r|--remotes) | (-a|--all)]
 	   [--list] [<pattern>...]
@@ -51,7 +52,8 @@ merged into the named commit (i.e. the branches whose tip commits are
 reachable from the named commit) will be listed.  With `--no-merged` only
 branches not merged into the named commit will be listed.  If the _<commit>_
 argument is missing it defaults to `HEAD` (i.e. the tip of the current
-branch).
+branch).  With `--forked`, only branches whose configured upstream matches
+the given branch or pattern will be listed.
 
 The command's second form creates a new branch head named _<branch-name>_
 which points to the current `HEAD`, or _<start-point>_ if given. As a
@@ -311,6 +313,12 @@ superproject's "origin/main", but tracks the submodule's "origin/main".
 	Only list branches whose tips are not reachable from
 	_<commit>_ (`HEAD` if not specified). Implies `--list`.
 
+`--forked <branch>`::
+	Only list branches whose configured upstream matches
+	_<branch>_. The argument can be a ref (e.g. `origin/main`,
+	`master`) or a shell-style glob (e.g. `'origin/*'`). The
+	option can be repeated to widen the filter. Implies `--list`.
+
 `--points-at <object>`::
 	Only list branches of _<object>_.
 
diff --git a/builtin/branch.c b/builtin/branch.c
index 1572a4f9ef..c159f45b4c 100644
--- a/builtin/branch.c
+++ b/builtin/branch.c
@@ -30,7 +30,7 @@
 #include "commit-reach.h"
 
 static const char * const builtin_branch_usage[] = {
-	N_("git branch [<options>] [-r | -a] [--merged] [--no-merged]"),
+	N_("git branch [<options>] [-r | -a] [--merged] [--no-merged] [(--forked <branch>)...]"),
 	N_("git branch [<options>] [-f] [--recurse-submodules] <branch-name> [<start-point>]"),
 	N_("git branch [<options>] [-l] [<pattern>...]"),
 	N_("git branch [<options>] [-r] (-d | -D) <branch-name>..."),
@@ -673,6 +673,16 @@ static void copy_or_rename_branch(const char *oldname, const char *newname, int
 	free_worktrees(worktrees);
 }
 
+static int parse_opt_forked(const struct option *opt, const char *arg, int unset)
+{
+	struct ref_filter *filter = opt->value;
+
+	BUG_ON_OPT_NEG(unset);
+	if (ref_filter_forked_add(filter, arg) < 0)
+		die(_("'%s' is not a valid branch or pattern"), arg);
+	return 0;
+}
+
 static GIT_PATH_FUNC(edit_description, "EDIT_DESCRIPTION")
 
 static int edit_branch_description(const char *branch_name)
@@ -770,6 +780,9 @@ int cmd_branch(int argc,
 		OPT__FORCE(&force, N_("force creation, move/rename, deletion"), PARSE_OPT_NOCOMPLETE),
 		OPT_MERGED(&filter, N_("print only branches that are merged")),
 		OPT_NO_MERGED(&filter, N_("print only branches that are not merged")),
+		OPT_CALLBACK_F(0, "forked", &filter, N_("branch"),
+			N_("print only branches whose upstream matches <branch> (repeatable)"),
+			PARSE_OPT_NONEG, parse_opt_forked),
 		OPT_COLUMN(0, "column", &colopts, N_("list branches in columns")),
 		OPT_REF_SORT(&sorting_options),
 		OPT_CALLBACK(0, "points-at", &filter.points_at, N_("object"),
@@ -815,7 +828,8 @@ int cmd_branch(int argc,
 		list = 1;
 
 	if (filter.with_commit || filter.no_commit ||
-	    filter.reachable_from || filter.unreachable_from || filter.points_at.nr)
+	    filter.reachable_from || filter.unreachable_from ||
+	    filter.points_at.nr || filter.forked.nr)
 		list = 1;
 
 	noncreate_actions = !!delete + !!rename + !!copy + !!new_upstream +
diff --git a/ref-filter.c b/ref-filter.c
index 1da4c0e60d..1ddd5a3f6d 100644
--- a/ref-filter.c
+++ b/ref-filter.c
@@ -2744,6 +2744,72 @@ static int filter_exclude_match(struct ref_filter *filter, const char *refname)
 	return match_pattern(filter->exclude.v, refname, filter->ignore_case);
 }
 
+static const char *short_upstream_name(const char *full_ref)
+{
+	const char *short_name = full_ref;
+	(void)(skip_prefix(short_name, "refs/heads/", &short_name) ||
+	       skip_prefix(short_name, "refs/remotes/", &short_name));
+	return short_name;
+}
+
+/*
+ * Match the configured upstream of a branch against the registered
+ * --forked patterns. Exact patterns are compared against the full
+ * upstream refname so they are unambiguous; glob patterns are matched
+ * against the abbreviated upstream so that a glob such as origin/...
+ * works as typed.
+ */
+static int filter_forked_match(struct ref_filter *filter, const char *refname)
+{
+	const char *short_name;
+	struct branch *branch;
+	const char *upstream;
+	int i;
+
+	if (!skip_prefix(refname, "refs/heads/", &short_name))
+		return 0;
+	branch = branch_get(short_name);
+	if (!branch)
+		return 0;
+	upstream = branch_get_upstream(branch, NULL);
+	if (!upstream)
+		return 0;
+
+	for (i = 0; i < filter->forked.nr; i++) {
+		const char *pattern = filter->forked.v[i];
+		if (has_glob_specials(pattern)) {
+			if (!wildmatch(pattern, short_upstream_name(upstream),
+				       WM_PATHNAME))
+				return 1;
+		} else if (!strcmp(pattern, upstream)) {
+			return 1;
+		}
+	}
+	return 0;
+}
+
+int ref_filter_forked_add(struct ref_filter *filter, const char *arg)
+{
+	struct object_id oid;
+	char *full_ref = NULL;
+
+	if (has_glob_specials(arg)) {
+		strvec_push(&filter->forked, arg);
+		return 0;
+	}
+
+	if (repo_dwim_ref(the_repository, arg, strlen(arg), &oid,
+			  &full_ref, 0) == 1 &&
+	    (starts_with(full_ref, "refs/heads/") ||
+	     starts_with(full_ref, "refs/remotes/"))) {
+		strvec_push(&filter->forked, full_ref);
+		free(full_ref);
+		return 0;
+	}
+	free(full_ref);
+	return -1;
+}
+
 /*
  * We need to seek to the reference right after a given marker but excluding any
  * matching references. So we seek to the lexicographically next reference.
@@ -2979,6 +3045,9 @@ static struct ref_array_item *apply_ref_filter(const struct reference *ref,
 	if (filter->points_at.nr && !match_points_at(&filter->points_at, ref->oid, ref->name))
 		return NULL;
 
+	if (filter->forked.nr && !filter_forked_match(filter, ref->name))
+		return NULL;
+
 	/*
 	 * A merge filter is applied on refs pointing to commits. Hence
 	 * obtain the commit using the 'oid' available and discard all
@@ -3765,6 +3834,7 @@ void ref_filter_init(struct ref_filter *filter)
 void ref_filter_clear(struct ref_filter *filter)
 {
 	strvec_clear(&filter->exclude);
+	strvec_clear(&filter->forked);
 	oid_array_clear(&filter->points_at);
 	commit_list_free(filter->with_commit);
 	commit_list_free(filter->no_commit);
diff --git a/ref-filter.h b/ref-filter.h
index 120221b47f..9361296e2a 100644
--- a/ref-filter.h
+++ b/ref-filter.h
@@ -67,6 +67,7 @@ struct ref_filter {
 	const char **name_patterns;
 	const char *start_after;
 	struct strvec exclude;
+	struct strvec forked;
 	struct oid_array points_at;
 	struct commit_list *with_commit;
 	struct commit_list *no_commit;
@@ -110,6 +111,7 @@ struct ref_format {
 #define REF_FILTER_INIT { \
 	.points_at = OID_ARRAY_INIT, \
 	.exclude = STRVEC_INIT, \
+	.forked = STRVEC_INIT, \
 }
 #define REF_FORMAT_INIT {             \
 	.use_color = GIT_COLOR_UNKNOWN, \
@@ -172,6 +174,14 @@ void ref_sorting_release(struct ref_sorting *);
 struct ref_sorting *ref_sorting_options(struct string_list *);
 /*  Function to parse --merged and --no-merged options */
 int parse_opt_merge_filter(const struct option *opt, const char *arg, int unset);
+/*
+ * Register a --forked <branch> pattern on the filter. The argument is
+ * either a ref, which is resolved to its full refname, or a shell-style
+ * glob. Branches are kept only when their configured upstream matches
+ * one of the registered patterns. Returns -1 if the argument is not a
+ * valid ref or pattern.
+ */
+int ref_filter_forked_add(struct ref_filter *filter, const char *arg);
 /*  Get the current HEAD's description */
 char *get_head_description(void);
 /*  Set up translated strings in the output. */
diff --git a/t/t3200-branch.sh b/t/t3200-branch.sh
index e7829c2c4b..4e7deddc04 100755
--- a/t/t3200-branch.sh
+++ b/t/t3200-branch.sh
@@ -1717,4 +1717,96 @@ test_expect_success 'errors if given a bad branch name' '
 	test_cmp expect actual
 '
 
+test_expect_success '--forked: setup' '
+	test_create_repo forked-upstream &&
+	test_commit -C forked-upstream base &&
+	git -C forked-upstream branch one base &&
+	git -C forked-upstream branch two base &&
+
+	test_create_repo forked-other &&
+	test_commit -C forked-other other-base &&
+	git -C forked-other branch foreign other-base &&
+
+	git clone forked-upstream forked &&
+	git -C forked remote add other ../forked-other &&
+	git -C forked fetch other &&
+	git -C forked branch local-base &&
+	git -C forked branch --track local-one origin/one &&
+	git -C forked branch --track local-two origin/two &&
+	git -C forked branch --track local-foreign other/foreign &&
+	git -C forked branch detached &&
+	git -C forked branch --track local-trunk local-base
+'
+
+test_expect_success '--forked <upstream-tracking-branch> filters by upstream' '
+	git -C forked branch --forked origin/one --format="%(refname:short)" >actual &&
+	echo local-one >expect &&
+	test_cmp expect actual
+'
+
+test_expect_success '--forked <glob> filters by wildmatch' '
+	git -C forked branch --forked "origin/*" --format="%(refname:short)" >actual &&
+	cat >expect <<-\EOF &&
+	local-one
+	local-two
+	main
+	EOF
+	test_cmp expect actual
+'
+
+test_expect_success '--forked <local-branch> matches branches with local upstream' '
+	git -C forked branch --forked local-base --format="%(refname:short)" >actual &&
+	echo local-trunk >expect &&
+	test_cmp expect actual
+'
+
+test_expect_success '--forked can be repeated to widen the filter' '
+	git -C forked branch --forked origin/one --forked other/foreign --format="%(refname:short)" >actual &&
+	cat >expect <<-\EOF &&
+	local-foreign
+	local-one
+	EOF
+	test_cmp expect actual
+'
+
+test_expect_success '--forked combines literal and glob arguments' '
+	git -C forked branch --forked local-base --forked "other/*" --format="%(refname:short)" >actual &&
+	cat >expect <<-\EOF &&
+	local-foreign
+	local-trunk
+	EOF
+	test_cmp expect actual
+'
+
+test_expect_success '--forked "*/*" covers every remote-tracking upstream' '
+	git -C forked branch --forked "*/*" --format="%(refname:short)" >actual &&
+	cat >expect <<-\EOF &&
+	local-foreign
+	local-one
+	local-two
+	main
+	EOF
+	test_cmp expect actual
+'
+
+test_expect_success '--forked composes with --no-merged' '
+	test_when_finished "git -C forked checkout detached" &&
+	git -C forked checkout local-one &&
+	test_commit -C forked local-only &&
+	git -C forked branch --forked "origin/*" --no-merged origin/one \
+		--format="%(refname:short)" >actual &&
+	echo local-one >expect &&
+	test_cmp expect actual
+'
+
+test_expect_success '--forked rejects unknown branch/pattern' '
+	test_must_fail git -C forked branch --forked nope 2>err &&
+	test_grep "not a valid branch or pattern" err
+'
+
+test_expect_success '--forked requires a value' '
+	test_must_fail git -C forked branch --forked 2>err &&
+	test_grep "requires a value" err
+'
+
 test_done
-- 
gitgitgadget

