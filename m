Received: from mail-wm1-f46.google.com (mail-wm1-f46.google.com [209.85.128.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CA0B927457
	for <git@vger.kernel.org>; Sun, 11 Aug 2024 17:34:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723397694; cv=none; b=rrqCjn0X5ttfFeRuuFQSh3ANy6M+P3x/dQLJmEyKFVO8gBIVAyx9Oi2yUu3QyhbGsGHgl9RLjdnu4FSl92w2NnpYaOSyb1paMDDMyjvpcg/H0PWviF0Ozc/yiYZrDkw5BC3NNyfwayVSlfDz8bTgaXafl+NT30njyVLrFd49JmQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723397694; c=relaxed/simple;
	bh=ESIUQX9Wr5cpCTOS7qiuFZ+EJtWKXX+FbL+olrY98tA=;
	h=Message-Id:In-Reply-To:References:From:Date:Subject:Content-Type:
	 MIME-Version:To:Cc; b=jX1P6/9pisgaz2kXDEoOsdjz0vcpGClMrvP6rQznJPEaT3/aTeXcDrOYf6LOy6PVH5TY7UnHOduE8eW+x7pEaUnHw/AcOdM4dOOUaC4+zPmBRwHt99d22m2gQypQYblslPRniscaXQ56P4lcB62SXn4qiLReDxTiblefe4/s29Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=lFLUVpNR; arc=none smtp.client-ip=209.85.128.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="lFLUVpNR"
Received: by mail-wm1-f46.google.com with SMTP id 5b1f17b1804b1-427fc97a88cso27455655e9.0
        for <git@vger.kernel.org>; Sun, 11 Aug 2024 10:34:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1723397691; x=1724002491; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Rx6mM6n557eUWaaSjyOwOkZ7Pp6egEZydkXz71qOjDQ=;
        b=lFLUVpNRh2QuYw45ZYFT+BKq+zlSiCPw7bpZWBlIFEwRIGRApxDUCQVhPuA36DU0kH
         H//hJPwKjQnDH18cb6T4gaH2fOFENotZSq2TDPWr1dp4I5HeqiCuvcUQlKZeCk6F/XpX
         JH7vpdFtcFlcFm3bU1BsPFw8EUnBO53KFtE13bOTDwmEjDLXSMxflurs4pspb6+YPyBF
         9CvumE+ca79gY32QQN1FUpk0JNtbB+EiRiiL2IFsWdWC9p2u0VxavGxM4UKKcAAFxI7p
         ppJ0gOT05+jU4VCIKdo5KrYWXasOb9+VJdIY1HHX3N0nedJ2OhyrkulqFCmBKzJp8urO
         AcVg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723397691; x=1724002491;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Rx6mM6n557eUWaaSjyOwOkZ7Pp6egEZydkXz71qOjDQ=;
        b=J8GP8pfg6O5+KdnlRZgRxAIe3NKzy9+DRm2+wcUJKkFXJjCNTO+zqJOH9YisqxKYhd
         3UsmKp6rZEw3D5qaRuNF8aR+hTZz5L0yBbJjx1t4aShmkTP71x1Y12alJr5Wex4fcPh6
         S5lVguHOqXdaraFRkwaEtrBtoO3MGw9jL8WNmtz8J9f70HEaq2jlA4j2XiUFuUsnjOZR
         j2YMBRBvb5XSN5hrhUGqTsYrCdTsNmsxqr9r2X1MJ7w/CFA0U+on1Q70wcrVomfm7ttl
         6pGh6dO4smPhIFSJo5BsU/2s8sG28aWcqT7CIQV081pqblEasBX80BYGRuosCR0FnTvx
         I37A==
X-Gm-Message-State: AOJu0YzJaU8aaaN79Tcg3cSKZRQJNVDSs/JEXIyjGXJPN6m82A11JtkH
	J6ACtkEluhqkdV6NDDa70raktN7jOul371zXuDLKfen6W1kv9Ruj6By7mA==
X-Google-Smtp-Source: AGHT+IGCqkD4LB9wnBoNkWghtXkeYP8uVPWX/0QzCjDxjZ0iXyCBOxDTV+GiVxrcjE0u9DppRdLAEA==
X-Received: by 2002:adf:e388:0:b0:368:446a:62ba with SMTP id ffacd0b85a97d-36d5e1c7091mr4763102f8f.17.1723397690452;
        Sun, 11 Aug 2024 10:34:50 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-36e4c93802fsm5355738f8f.33.2024.08.11.10.34.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 11 Aug 2024 10:34:50 -0700 (PDT)
Message-Id: <13341e7e51241e077a85ea83eb76d4e48d04be7b.1723397687.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1768.v2.git.1723397687.gitgitgadget@gmail.com>
References: <pull.1768.git.1722550226.gitgitgadget@gmail.com>
	<pull.1768.v2.git.1723397687.gitgitgadget@gmail.com>
From: "Derrick Stolee via GitGitGadget" <gitgitgadget@gmail.com>
Date: Sun, 11 Aug 2024 17:34:46 +0000
Subject: [PATCH v2 2/3] for-each-ref: add 'is-base' token
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
Cc: gitster@pobox.com,
    vdye@github.com,
    Derrick Stolee <stolee@gmail.com>,
    Derrick Stolee <stolee@gmail.com>

From: Derrick Stolee <stolee@gmail.com>

The previous change introduced the get_branch_base_for_tip() method in
commit-reach.c. The motivation of that change was about using a heuristic to
deteremine the base branch for a source commit from a list of candidate
commit tips. This change makes that algorithm visible to users via a new
atom in the 'git for-each-ref' format. This change is very similar to the
chang in 49abcd21da6 (for-each-ref: add ahead-behind format atom,
2023-03-20).

Introduce the 'is-base:<source>' atom, which will indicate that the
algorithm should be computed and the result of the algorithm is reported
using an indicator of the form '(<source>)'. For example, using
'%(is-base:HEAD)' would result in one line having the token '(HEAD)'.

Use the sorted order of refs included in the ref filter to break ties in the
algorithm's heuristic. In the previous change, the motivating examples
include using an L0 trunk, long-lived L1 branches, and temporary release
branches. A caller could communicate the ordered preference among these
categories using the input refpecs and avoiding a different sort mechanism.
This sorting behavior is tested in the test scripts.

It is important to include this atom as a special case to
can_do_iterative_format() to match the expectations created in bd98f9774e1
(ref-filter.c: filter & format refs in the same callback, 2023-11-14). The
ahead-behind atom was one of the special cases, and this similarly requires
using an algorithm across all input refs before starting the format of any
single ref.

In the test script, the format tokens use colons or lack whitespace to avoid
Git complaining about trailing whitespace errors.

Signed-off-by: Derrick Stolee <stolee@gmail.com>
---
 Documentation/git-for-each-ref.txt | 42 ++++++++++++++++
 ref-filter.c                       | 78 +++++++++++++++++++++++++++++-
 ref-filter.h                       | 15 ++++++
 t/t6600-test-reach.sh              | 47 ++++++++++++++++++
 4 files changed, 181 insertions(+), 1 deletion(-)

diff --git a/Documentation/git-for-each-ref.txt b/Documentation/git-for-each-ref.txt
index c1dd12b93cf..d3764401a23 100644
--- a/Documentation/git-for-each-ref.txt
+++ b/Documentation/git-for-each-ref.txt
@@ -264,6 +264,48 @@ ahead-behind:<committish>::
 	commits ahead and behind, respectively, when comparing the output
 	ref to the `<committish>` specified in the format.
 
+is-base:<committish>::
+	In at most one row, `(<committish>)` will appear to indicate the ref
+	that is most likely the ref used as a starting point for the branch
+	that produced `<committish>`. This choice is made using a heuristic:
+	choose the ref that minimizes the number of commits in the
+	first-parent history of `<committish>` and not in the first-parent
+	history of the ref.
++
+For example, consider the following figure of first-parent histories of
+several refs:
++
+----
+*--*--*--*--*--* refs/heads/A
+\
+ \
+  *--*--*--* refs/heads/B
+   \     \
+    \     \
+     *     * refs/heads/C
+      \
+       \
+	*--* refs/heads/D
+----
++
+Here, if `A`, `B`, and `C` are the filtered references, and the format
+string is `%(refname):%(is-base:D)`, then the output would be
++
+----
+refs/heads/A:
+refs/heads/B:(D)
+refs/heads/C:
+----
++
+This is because the first-parent history of `D` has its earliest
+intersection with the first-parent histories of the filtered refs at a
+common first-parent ancestor of `B` and `C` and ties are broken by the
+earliest ref in the sorted order.
++
+Note that this token will not appear if the first-parent history of
+`<committish>` does not intersect the first-parent histories of the
+filtered refs.
+
 describe[:options]::
 	A human-readable name, like linkgit:git-describe[1];
 	empty string for undescribable commits. The `describe` string may
diff --git a/ref-filter.c b/ref-filter.c
index 59ad6f54ddb..59689672da1 100644
--- a/ref-filter.c
+++ b/ref-filter.c
@@ -167,6 +167,7 @@ enum atom_type {
 	ATOM_ELSE,
 	ATOM_REST,
 	ATOM_AHEADBEHIND,
+	ATOM_ISBASE,
 };
 
 /*
@@ -889,6 +890,23 @@ static int ahead_behind_atom_parser(struct ref_format *format,
 	return 0;
 }
 
+static int is_base_atom_parser(struct ref_format *format,
+			       struct used_atom *atom UNUSED,
+			       const char *arg, struct strbuf *err)
+{
+	struct string_list_item *item;
+
+	if (!arg)
+		return strbuf_addf_ret(err, -1, _("expected format: %%(is-base:<committish>)"));
+
+	item = string_list_append(&format->is_base_tips, arg);
+	item->util = lookup_commit_reference_by_name(arg);
+	if (!item->util)
+		die("failed to find '%s'", arg);
+
+	return 0;
+}
+
 static int head_atom_parser(struct ref_format *format UNUSED,
 			    struct used_atom *atom,
 			    const char *arg, struct strbuf *err)
@@ -952,6 +970,7 @@ static struct {
 	[ATOM_ELSE] = { "else", SOURCE_NONE },
 	[ATOM_REST] = { "rest", SOURCE_NONE, FIELD_STR, rest_atom_parser },
 	[ATOM_AHEADBEHIND] = { "ahead-behind", SOURCE_OTHER, FIELD_STR, ahead_behind_atom_parser },
+	[ATOM_ISBASE] = { "is-base", SOURCE_OTHER, FIELD_STR, is_base_atom_parser },
 	/*
 	 * Please update $__git_ref_fieldlist in git-completion.bash
 	 * when you add new atoms
@@ -2334,6 +2353,7 @@ static int populate_value(struct ref_array_item *ref, struct strbuf *err)
 	int i;
 	struct object_info empty = OBJECT_INFO_INIT;
 	int ahead_behind_atoms = 0;
+	int is_base_atoms = 0;
 
 	CALLOC_ARRAY(ref->value, used_atom_cnt);
 
@@ -2475,6 +2495,16 @@ static int populate_value(struct ref_array_item *ref, struct strbuf *err)
 				v->s = xstrdup("");
 			}
 			continue;
+		} else if (atom_type == ATOM_ISBASE) {
+			if (ref->is_base && ref->is_base[is_base_atoms]) {
+				v->s = xstrfmt("(%s)", ref->is_base[is_base_atoms]);
+				free(ref->is_base[is_base_atoms]);
+			} else {
+				/* Not a commit. */
+				v->s = xstrdup("");
+			}
+			is_base_atoms++;
+			continue;
 		} else
 			continue;
 
@@ -2876,6 +2906,7 @@ static void free_array_item(struct ref_array_item *item)
 		free(item->value);
 	}
 	free(item->counts);
+	free(item->is_base);
 	free(item);
 }
 
@@ -3040,6 +3071,49 @@ void filter_ahead_behind(struct repository *r,
 	free(commits);
 }
 
+void filter_is_base(struct repository *r,
+		    struct ref_format *format,
+		    struct ref_array *array)
+{
+	struct commit **bases;
+	size_t bases_nr = 0;
+	struct ref_array_item **back_index;
+
+	if (!format->is_base_tips.nr || !array->nr)
+		return;
+
+	CALLOC_ARRAY(back_index, array->nr);
+	CALLOC_ARRAY(bases, array->nr);
+
+	for (size_t i = 0; i < array->nr; i++) {
+		const char *name = array->items[i]->refname;
+		struct commit *c = lookup_commit_reference_by_name(name);
+
+		CALLOC_ARRAY(array->items[i]->is_base, format->is_base_tips.nr);
+
+		if (!c)
+			continue;
+
+		back_index[bases_nr] = array->items[i];
+		bases[bases_nr] = c;
+		bases_nr++;
+	}
+
+	for (size_t i = 0; i < format->is_base_tips.nr; i++) {
+		struct commit *tip = format->is_base_tips.items[i].util;
+		int base_index = get_branch_base_for_tip(r, tip, bases, bases_nr);
+
+		if (base_index < 0)
+			continue;
+
+		/* Store the string for use in output later. */
+		back_index[base_index]->is_base[i] = xstrdup(format->is_base_tips.items[i].string);
+	}
+
+	free(back_index);
+	free(bases);
+}
+
 static int do_filter_refs(struct ref_filter *filter, unsigned int type, each_ref_fn fn, void *cb_data)
 {
 	int ret = 0;
@@ -3126,7 +3200,8 @@ static inline int can_do_iterative_format(struct ref_filter *filter,
 	return !(filter->reachable_from ||
 		 filter->unreachable_from ||
 		 sorting ||
-		 format->bases.nr);
+		 format->bases.nr ||
+		 format->is_base_tips.nr);
 }
 
 void filter_and_format_refs(struct ref_filter *filter, unsigned int type,
@@ -3150,6 +3225,7 @@ void filter_and_format_refs(struct ref_filter *filter, unsigned int type,
 		struct ref_array array = { 0 };
 		filter_refs(&array, filter, type);
 		filter_ahead_behind(the_repository, format, &array);
+		filter_is_base(the_repository, format, &array);
 		ref_array_sort(sorting, &array);
 		print_formatted_ref_array(&array, format);
 		ref_array_clear(&array);
diff --git a/ref-filter.h b/ref-filter.h
index 0ca28d2bba6..20419a56218 100644
--- a/ref-filter.h
+++ b/ref-filter.h
@@ -48,6 +48,7 @@ struct ref_array_item {
 	struct commit *commit;
 	struct atom_value *value;
 	struct ahead_behind_count **counts;
+	char **is_base;
 
 	char refname[FLEX_ARRAY];
 };
@@ -101,6 +102,9 @@ struct ref_format {
 	/* List of bases for ahead-behind counts. */
 	struct string_list bases;
 
+	/* List of bases for is-base indicators. */
+	struct string_list is_base_tips;
+
 	struct {
 		int max_count;
 		int omit_empty;
@@ -114,6 +118,7 @@ struct ref_format {
 #define REF_FORMAT_INIT {             \
 	.use_color = -1,              \
 	.bases = STRING_LIST_INIT_DUP, \
+	.is_base_tips = STRING_LIST_INIT_DUP, \
 }
 
 /*  Macros for checking --merged and --no-merged options */
@@ -203,6 +208,16 @@ void filter_ahead_behind(struct repository *r,
 			 struct ref_format *format,
 			 struct ref_array *array);
 
+/*
+ * If the provided format includes is-base atoms, then compute the base checks
+ * for those tips against all refs.
+ *
+ * If this is not called, then any is-base atoms will be blank.
+ */
+void filter_is_base(struct repository *r,
+		    struct ref_format *format,
+		    struct ref_array *array);
+
 void ref_filter_init(struct ref_filter *filter);
 void ref_filter_clear(struct ref_filter *filter);
 
diff --git a/t/t6600-test-reach.sh b/t/t6600-test-reach.sh
index 3069efc8601..6c7f92bcb38 100755
--- a/t/t6600-test-reach.sh
+++ b/t/t6600-test-reach.sh
@@ -659,4 +659,51 @@ test_expect_success 'get_branch_base_for_tip: all reach tip' '
 	test_all_modes get_branch_base_for_tip
 '
 
+test_expect_success 'for-each-ref is-base: none reach' '
+	cat >input <<-\EOF &&
+	refs/heads/commit-1-1
+	refs/heads/commit-4-2
+	refs/heads/commit-4-4
+	refs/heads/commit-8-4
+	EOF
+	cat >expect <<-\EOF &&
+	refs/heads/commit-1-1:
+	refs/heads/commit-4-2:(commit-2-3)
+	refs/heads/commit-4-4:
+	refs/heads/commit-8-4:
+	EOF
+	run_all_modes git for-each-ref \
+		--format="%(refname):%(is-base:commit-2-3)" --stdin
+'
+
+test_expect_success 'for-each-ref is-base: all reach' '
+	cat >input <<-\EOF &&
+	refs/heads/commit-4-2
+	refs/heads/commit-5-1
+	EOF
+	cat >expect <<-\EOF &&
+	refs/heads/commit-4-2:(commit-4-1)
+	refs/heads/commit-5-1:
+	EOF
+	run_all_modes git for-each-ref \
+		--format="%(refname):%(is-base:commit-4-1)" --stdin
+'
+
+test_expect_success 'for-each-ref is-base:multiple' '
+	cat >input <<-\EOF &&
+	refs/heads/commit-1-1
+	refs/heads/commit-4-2
+	refs/heads/commit-4-4
+	refs/heads/commit-8-4
+	EOF
+	cat >expect <<-\EOF &&
+	refs/heads/commit-1-1[-]
+	refs/heads/commit-4-2[(commit-2-3)-]
+	refs/heads/commit-4-4[-]
+	refs/heads/commit-8-4[-(commit-6-5)]
+	EOF
+	run_all_modes git for-each-ref \
+		--format="%(refname)[%(is-base:commit-2-3)-%(is-base:commit-6-5)]" --stdin
+'
+
 test_done
-- 
gitgitgadget

