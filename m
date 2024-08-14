Received: from mail-wm1-f48.google.com (mail-wm1-f48.google.com [209.85.128.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A77101AE035
	for <git@vger.kernel.org>; Wed, 14 Aug 2024 10:31:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723631499; cv=none; b=nOkrHUpnh/dYsXfNAOne0dHt7aMA/rzBE3feGS9ux5I37BFf139vztHyFgGElH0wGU30aKhS3Wgd9I1weKIwcWhrmAYUJEgsW6Hkkk0A3z7XEyFqoxuvOOVEo76SDJZLQX+LMlxTDcNEf5R71z+oPbWaQLV67q5N8gDXkxWynEI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723631499; c=relaxed/simple;
	bh=g/TNINRaOJ3pseA6gjVr+qEeU9WWbFmpVqIxro1z4TQ=;
	h=Message-Id:In-Reply-To:References:From:Date:Subject:Content-Type:
	 MIME-Version:To:Cc; b=rDbD8xLBiicg3KeiuEfORJSuX/VSprfVMb0ZrDz7DIiMMSGwQ1M8ozfv0dP36XJHjNwHofQlMzaZEWlhmJgBMD6PQWeCgK0tBW0/j6zCbA/G9HYt60VlWaJAhlfIllkrJ5KA+uudft/n3JEloD2Hztwui2pQTKx0RzS0YW/i/w4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=nG7H4cUG; arc=none smtp.client-ip=209.85.128.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="nG7H4cUG"
Received: by mail-wm1-f48.google.com with SMTP id 5b1f17b1804b1-427fc97a88cso49495945e9.0
        for <git@vger.kernel.org>; Wed, 14 Aug 2024 03:31:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1723631496; x=1724236296; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=F3Itdrhzfpy8fmiygJVuag0mxqZJQoRPae//Uyfg8OI=;
        b=nG7H4cUG/QpUqYUesyp8+KJ82H/h1H/BG4Sg7fwYSb4fpaBGK66Kv6fDACxMYbgbAn
         KRjx5twdWajBMlo7fpY0qWIS2pxmrUKHWidaH9p64FizLP74BYn0i5q9INAnTgNqXpVC
         OAxKX5bXM5nt4fFVMEScpVmxGyzkPoduuHJSWU4JL43K1X9q11LLXj+R58C0NGvIrcxg
         Wi6XkTD1hXoyOCOX/hD2eKzX05xfLLq5FNBcVKl96RUjjQKpj8ZXrUkjPWUHXKYvShgk
         g0d+AI1KItqWw62YlotYqvLw8Enj2RIsr4IrTduOsghR81LowmvDMv0jF+Rh65/Pqz2v
         vDqQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723631496; x=1724236296;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=F3Itdrhzfpy8fmiygJVuag0mxqZJQoRPae//Uyfg8OI=;
        b=lFkHPymvBWPlgdAk7H9FQge1DPc+P1GrZ9aZpyKOnCQPOLU37brCCYadxpeOSmdxag
         MZfCz+vrVe9PEBvF3YTCHflbfS1OufHDZhwKraoFkSJXajG/HgU7gX6ffky4C8Pm59oP
         sDB2HRG8OO9VoKZEAtYF5EIWiffwoBhv4kPkokXAzUbf+yHIlAfrbGhfV3uemZ9VbuCg
         tp4Nfa7LQgjSHKjpgO+UGKEA85ITUmb7FcWDfzDhUV7zS+4u/p2kWk1tu825JKZ6F3rW
         19EASSGKqSYCRh9KYYkhhhgnBR9xje6vmqSEcYoGZN6yrjmfCm9fpppS0l+rCfE0cJxv
         By4w==
X-Gm-Message-State: AOJu0Ywer0SrmmQIyInDbiRJpu1ejiC5pQQdKq7cdQqN2+K4ObdiXLnr
	meuWgRHE+V1A6XWFi5t/bpK7l+bSl2FocgHsND0p/PUMqcRZQqDfGyHxEg==
X-Google-Smtp-Source: AGHT+IFtO3KlSelhNMQyVgb68X7O+ruwTLsL8hwPpJ9wNsRe/3puZRvOykH8fd1vYrw2Vv44+03Daw==
X-Received: by 2002:a05:600c:1f83:b0:426:5cee:4abc with SMTP id 5b1f17b1804b1-429dd23cf16mr16863755e9.20.1723631495137;
        Wed, 14 Aug 2024 03:31:35 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-429ded1ec28sm15502075e9.5.2024.08.14.03.31.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 14 Aug 2024 03:31:34 -0700 (PDT)
Message-Id: <df05cee6003d7ad5ea750835cad763848365c043.1723631490.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1768.v3.git.1723631490.gitgitgadget@gmail.com>
References: <pull.1768.v2.git.1723397687.gitgitgadget@gmail.com>
	<pull.1768.v3.git.1723631490.gitgitgadget@gmail.com>
From: "Derrick Stolee via GitGitGadget" <gitgitgadget@gmail.com>
Date: Wed, 14 Aug 2024 10:31:29 +0000
Subject: [PATCH v3 3/4] for-each-ref: add 'is-base' token
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
 ref-filter.c                       | 77 +++++++++++++++++++++++++++++-
 ref-filter.h                       | 15 ++++++
 t/t6300-for-each-ref.sh            |  9 ++++
 t/t6600-test-reach.sh              | 60 +++++++++++++++++++++++
 5 files changed, 202 insertions(+), 1 deletion(-)

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
index 59ad6f54ddb..3d598f6b6e6 100644
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
 
@@ -2475,6 +2495,15 @@ static int populate_value(struct ref_array_item *ref, struct strbuf *err)
 				v->s = xstrdup("");
 			}
 			continue;
+		} else if (atom_type == ATOM_ISBASE) {
+			if (ref->is_base && ref->is_base[is_base_atoms]) {
+				v->s = xstrfmt("(%s)", ref->is_base[is_base_atoms]);
+				free(ref->is_base[is_base_atoms]);
+			} else {
+				v->s = xstrdup("");
+			}
+			is_base_atoms++;
+			continue;
 		} else
 			continue;
 
@@ -2876,6 +2905,7 @@ static void free_array_item(struct ref_array_item *item)
 		free(item->value);
 	}
 	free(item->counts);
+	free(item->is_base);
 	free(item);
 }
 
@@ -3040,6 +3070,49 @@ void filter_ahead_behind(struct repository *r,
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
+		struct commit *c = lookup_commit_reference_by_name_gently(name, 1);
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
@@ -3126,7 +3199,8 @@ static inline int can_do_iterative_format(struct ref_filter *filter,
 	return !(filter->reachable_from ||
 		 filter->unreachable_from ||
 		 sorting ||
-		 format->bases.nr);
+		 format->bases.nr ||
+		 format->is_base_tips.nr);
 }
 
 void filter_and_format_refs(struct ref_filter *filter, unsigned int type,
@@ -3150,6 +3224,7 @@ void filter_and_format_refs(struct ref_filter *filter, unsigned int type,
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
 
diff --git a/t/t6300-for-each-ref.sh b/t/t6300-for-each-ref.sh
index eb6c8204e8b..8d15713cc67 100755
--- a/t/t6300-for-each-ref.sh
+++ b/t/t6300-for-each-ref.sh
@@ -1907,6 +1907,15 @@ test_expect_success 'git for-each-ref with nested tags' '
 	test_cmp expect actual
 '
 
+test_expect_success 'is-base atom with non-commits' '
+	git for-each-ref --format="%(is-base:HEAD) %(refname)" >out 2>err &&
+	grep "(HEAD) refs/heads/main" out &&
+
+	test_line_count = 2 err &&
+	grep "error: object .* is a commit, not a blob" err &&
+	grep "error: bad tag pointer to" err
+'
+
 GRADE_FORMAT="%(signature:grade)%0a%(signature:key)%0a%(signature:signer)%0a%(signature:fingerprint)%0a%(signature:primarykeyfingerprint)"
 TRUSTLEVEL_FORMAT="%(signature:trustlevel)%0a%(signature:key)%0a%(signature:signer)%0a%(signature:fingerprint)%0a%(signature:primarykeyfingerprint)"
 
diff --git a/t/t6600-test-reach.sh b/t/t6600-test-reach.sh
index e789a4720c1..2591f8b8b39 100755
--- a/t/t6600-test-reach.sh
+++ b/t/t6600-test-reach.sh
@@ -673,4 +673,64 @@ test_expect_success 'get_branch_base_for_tip: all reach tip' '
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
+test_expect_success 'for-each-ref is-base: equal to tip' '
+	cat >input <<-\EOF &&
+	refs/heads/commit-4-2
+	refs/heads/commit-5-1
+	EOF
+	cat >expect <<-\EOF &&
+	refs/heads/commit-4-2:(commit-4-2)
+	refs/heads/commit-5-1:
+	EOF
+	run_all_modes git for-each-ref \
+		--format="%(refname):%(is-base:commit-4-2)" --stdin
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

