Received: from mail-ej1-f42.google.com (mail-ej1-f42.google.com [209.85.218.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EA8565D48A
	for <git@vger.kernel.org>; Fri, 23 Feb 2024 10:01:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708682485; cv=none; b=L8AccK8fZfesKvqoQUlWEoFRcfsnPbnwf2oQSUqiIIHjOY2rwkwEq/LJF6z6h/9m7QML5fdvQyPFrdB1mqR+fIpytACirjt69OfkHeDrAsbz9tyLFho9HxcjxhGHumCGZSceANbv5sg1XhH6yqLUN0Rcl5hjtzrsljD1MceATQc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708682485; c=relaxed/simple;
	bh=FZugirshiZwDgpBKthHn485F9miESgoJDiqhgbUqfdE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=k0hr0j38ypEpuyHd98eqrt8vLMpxZgc29BgGhoKXeouVMK8SxPT36hQKtnBGCxJS83aI1PezegW91hNTLfVjW9ho4eqYRd69kvGcszDrSzsnOaIh8f5HiBfwyHpN14ExQ9TALjQEK3deeZWhQojbidtgTmtvPXdguGhplCBMoAU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=YrsVchnY; arc=none smtp.client-ip=209.85.218.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="YrsVchnY"
Received: by mail-ej1-f42.google.com with SMTP id a640c23a62f3a-a3e552eff09so65375466b.3
        for <git@vger.kernel.org>; Fri, 23 Feb 2024 02:01:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1708682481; x=1709287281; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=EdBjcIhb72wm2Mqt9yDpGuFQvhq8IxfvpuJF0VfZBYs=;
        b=YrsVchnYizWrNzqB7n+MdvMoAlpZaslT+z/Own9lwm9B4/O8Yz2u/ViDK8/5byhJql
         frj7CAxyRr7B/vVJWsZ1rXO1fsg7uLBqpgvZQoLL9h3komptaZgO1GI5qli165gCrQRH
         CT5YO942+kmHHI9IeO3HAKr2PjkqEMkajcykKsvqXce9Z50BCctj2t5IAoD1BdaZOCn0
         4MxfzSRkG+Enx3b+BX7mAk7JbLKjfYhd3gEItV4WorH4DIlch5aO+AiLhxZx+IJNsv7H
         y5uxQikDhGLjwXt7Ua1G+IRIRnmnYjuVEK40VVnMaGf8WHY6VBEhjpWcuwzZM+CPNR/2
         N+3g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708682481; x=1709287281;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=EdBjcIhb72wm2Mqt9yDpGuFQvhq8IxfvpuJF0VfZBYs=;
        b=DKCalzUjNDknHN6u350MeEWq9szSUf6WD6HVOIGixRX/YqXUjtFPzru+Pnu3rEc4Tu
         tqb1zLyKu8+RkMohFRNCpMwdjZ7faukkGDqGEhVZpXB39U73qGdj+KXLpaTaV8LWZwct
         bziV99U3bdJdoQqr4BCbsLbk7nlr6Sbn3anUOuQZkdJ8S0mxjT+XjQFhr3jxcu2otRPc
         hmJdK8BXk9wGlOlZcp6ie3msDejELat4Q+ke5NvAHkqzg9qLFpt5kZUia2b2gsnXcMsr
         rJu2WhZt8rVJl2JXyiTc3cNTwkeN5kDACg4JPCUWVzUEASjGrq9VfQMmQR7yd/HDz44G
         IOVA==
X-Gm-Message-State: AOJu0Yy5ZfPD6p2fuKLrysxgwzDhN+XlbjSx70iRDCNJvNwfOP9xf/VQ
	olfytRscY7XsKC7rBNSz8Cxtw5NelqmJ8IhNSfTdPHVsy2SjcVjPKxVQ9ksb1wY=
X-Google-Smtp-Source: AGHT+IFFa8RWmPLpVjCC1eHolapypUz4gH6+wP+tVTJV3jyRAOA38W4LFigXIm/xTu8gUWhw+jhjMQ==
X-Received: by 2002:a17:906:80c5:b0:a3f:d2cc:e8ae with SMTP id a5-20020a17090680c500b00a3fd2cce8aemr598196ejx.63.1708682480422;
        Fri, 23 Feb 2024 02:01:20 -0800 (PST)
Received: from laptop.fritz.box ([2a02:2455:826e:4900:660d:e728:4b64:50ff])
        by smtp.gmail.com with ESMTPSA id ha1-20020a170906a88100b00a381ca0e589sm6734917ejb.22.2024.02.23.02.01.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 23 Feb 2024 02:01:20 -0800 (PST)
From: Karthik Nayak <karthik.188@gmail.com>
To: git@vger.kernel.org
Cc: gitster@pobox.com,
	ps@pks.im,
	phillip.wood123@gmail.com,
	Karthik Nayak <karthik.188@gmail.com>
Subject: [PATCH v5 5/5] for-each-ref: add new option to include root refs
Date: Fri, 23 Feb 2024 11:01:12 +0100
Message-ID: <20240223100112.44127-6-karthik.188@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240223100112.44127-1-karthik.188@gmail.com>
References: <20240119142705.139374-1-karthik.188@gmail.com>
 <20240223100112.44127-1-karthik.188@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The git-for-each-ref(1) command doesn't provide a way to print root refs
i.e pseudorefs and HEAD with the regular "refs/" prefixed refs.

This commit adds a new option "--include-root-refs" to
git-for-each-ref(1). When used this would also print pseudorefs and HEAD
for the current worktree.

Signed-off-by: Karthik Nayak <karthik.188@gmail.com>
---
 Documentation/git-for-each-ref.txt |  5 ++++-
 builtin/for-each-ref.c             | 10 +++++++---
 ref-filter.c                       | 28 +++++++++++++++++++++++++--
 ref-filter.h                       |  5 ++++-
 refs/reftable-backend.c            | 11 +++++++----
 t/t6302-for-each-ref-filter.sh     | 31 ++++++++++++++++++++++++++++++
 6 files changed, 79 insertions(+), 11 deletions(-)

diff --git a/Documentation/git-for-each-ref.txt b/Documentation/git-for-each-ref.txt
index 3a9ad91b7a..c1dd12b93c 100644
--- a/Documentation/git-for-each-ref.txt
+++ b/Documentation/git-for-each-ref.txt
@@ -10,7 +10,7 @@ SYNOPSIS
 [verse]
 'git for-each-ref' [--count=<count>] [--shell|--perl|--python|--tcl]
 		   [(--sort=<key>)...] [--format=<format>]
-		   [ --stdin | <pattern>... ]
+		   [--include-root-refs] [ --stdin | <pattern>... ]
 		   [--points-at=<object>]
 		   [--merged[=<object>]] [--no-merged[=<object>]]
 		   [--contains[=<object>]] [--no-contains[=<object>]]
@@ -105,6 +105,9 @@ TAB %(refname)`.
 	any excluded pattern(s) are shown. Matching is done using the
 	same rules as `<pattern>` above.
 
+--include-root-refs::
+	List root refs (HEAD and pseudorefs) apart from regular refs.
+
 FIELD NAMES
 -----------
 
diff --git a/builtin/for-each-ref.c b/builtin/for-each-ref.c
index 23d352e371..919282e12a 100644
--- a/builtin/for-each-ref.c
+++ b/builtin/for-each-ref.c
@@ -20,10 +20,10 @@ int cmd_for_each_ref(int argc, const char **argv, const char *prefix)
 {
 	struct ref_sorting *sorting;
 	struct string_list sorting_options = STRING_LIST_INIT_DUP;
-	int icase = 0;
+	int icase = 0, include_root_refs = 0, from_stdin = 0;
 	struct ref_filter filter = REF_FILTER_INIT;
 	struct ref_format format = REF_FORMAT_INIT;
-	int from_stdin = 0;
+	unsigned int flags = FILTER_REFS_REGULAR;
 	struct strvec vec = STRVEC_INIT;
 
 	struct option opts[] = {
@@ -53,6 +53,7 @@ int cmd_for_each_ref(int argc, const char **argv, const char *prefix)
 		OPT_NO_CONTAINS(&filter.no_commit, N_("print only refs which don't contain the commit")),
 		OPT_BOOL(0, "ignore-case", &icase, N_("sorting and filtering are case insensitive")),
 		OPT_BOOL(0, "stdin", &from_stdin, N_("read reference patterns from stdin")),
+		OPT_BOOL(0, "include-root-refs", &include_root_refs, N_("also include HEAD ref and pseudorefs")),
 		OPT_END(),
 	};
 
@@ -96,8 +97,11 @@ int cmd_for_each_ref(int argc, const char **argv, const char *prefix)
 		filter.name_patterns = argv;
 	}
 
+	if (include_root_refs)
+		flags |= FILTER_REFS_ROOT_REFS;
+
 	filter.match_as_path = 1;
-	filter_and_format_refs(&filter, FILTER_REFS_REGULAR, sorting, &format);
+	filter_and_format_refs(&filter, flags, sorting, &format);
 
 	ref_filter_clear(&filter);
 	ref_sorting_release(sorting);
diff --git a/ref-filter.c b/ref-filter.c
index acb960e35c..0ec29f7385 100644
--- a/ref-filter.c
+++ b/ref-filter.c
@@ -2628,6 +2628,12 @@ static int for_each_fullref_in_pattern(struct ref_filter *filter,
 				       each_ref_fn cb,
 				       void *cb_data)
 {
+	if (filter->kind == FILTER_REFS_KIND_MASK) {
+		/* In this case, we want to print all refs including root refs. */
+		return refs_for_each_include_root_refs(get_main_ref_store(the_repository),
+						       cb, cb_data);
+	}
+
 	if (!filter->match_as_path) {
 		/*
 		 * in this case, the patterns are applied after
@@ -2750,6 +2756,9 @@ static int ref_kind_from_refname(const char *refname)
 			return ref_kind[i].kind;
 	}
 
+	if (is_pseudoref(get_main_ref_store(the_repository), refname))
+		return FILTER_REFS_PSEUDOREFS;
+
 	return FILTER_REFS_OTHERS;
 }
 
@@ -2781,7 +2790,16 @@ static struct ref_array_item *apply_ref_filter(const char *refname, const struct
 
 	/* Obtain the current ref kind from filter_ref_kind() and ignore unwanted refs. */
 	kind = filter_ref_kind(filter, refname);
-	if (!(kind & filter->kind))
+
+	/*
+	 * Generally HEAD refs are printed with special description denoting a rebase,
+	 * detached state and so forth. This is useful when only printing the HEAD ref
+	 * But when it is being printed along with other pseudorefs, it makes sense to
+	 * keep the formatting consistent. So we mask the type to act like a pseudoref.
+	 */
+	if (filter->kind == FILTER_REFS_KIND_MASK && kind == FILTER_REFS_DETACHED_HEAD)
+		kind = FILTER_REFS_PSEUDOREFS;
+	else if (!(kind & filter->kind))
 		return NULL;
 
 	if (!filter_pattern_match(filter, refname))
@@ -3049,7 +3067,13 @@ static int do_filter_refs(struct ref_filter *filter, unsigned int type, each_ref
 			ret = for_each_fullref_in("refs/tags/", fn, cb_data);
 		else if (filter->kind & FILTER_REFS_REGULAR)
 			ret = for_each_fullref_in_pattern(filter, fn, cb_data);
-		if (!ret && (filter->kind & FILTER_REFS_DETACHED_HEAD))
+
+		/*
+		 * When printing all ref types, HEAD is already included,
+		 * so we don't want to print HEAD again.
+		 */
+		if (!ret && (filter->kind != FILTER_REFS_KIND_MASK) &&
+		    (filter->kind & FILTER_REFS_DETACHED_HEAD))
 			head_ref(fn, cb_data);
 	}
 
diff --git a/ref-filter.h b/ref-filter.h
index 5416936800..0ca28d2bba 100644
--- a/ref-filter.h
+++ b/ref-filter.h
@@ -22,7 +22,10 @@
 #define FILTER_REFS_REGULAR        (FILTER_REFS_TAGS | FILTER_REFS_BRANCHES | \
 				    FILTER_REFS_REMOTES | FILTER_REFS_OTHERS)
 #define FILTER_REFS_DETACHED_HEAD  0x0020
-#define FILTER_REFS_KIND_MASK      (FILTER_REFS_REGULAR | FILTER_REFS_DETACHED_HEAD)
+#define FILTER_REFS_PSEUDOREFS     0x0040
+#define FILTER_REFS_ROOT_REFS      (FILTER_REFS_DETACHED_HEAD | FILTER_REFS_PSEUDOREFS)
+#define FILTER_REFS_KIND_MASK      (FILTER_REFS_REGULAR | FILTER_REFS_DETACHED_HEAD | \
+				    FILTER_REFS_PSEUDOREFS)
 
 struct atom_value;
 struct ref_sorting;
diff --git a/refs/reftable-backend.c b/refs/reftable-backend.c
index a14f2ad7f4..c23a516ac2 100644
--- a/refs/reftable-backend.c
+++ b/refs/reftable-backend.c
@@ -364,12 +364,15 @@ static int reftable_ref_iterator_advance(struct ref_iterator *ref_iterator)
 			break;
 
 		/*
-		 * The files backend only lists references contained in
-		 * "refs/". We emulate the same behaviour here and thus skip
-		 * all references that don't start with this prefix.
+		 * The files backend only lists references contained in "refs/" unless
+		 * the root refs are to be included. We emulate the same behaviour here.
 		 */
-		if (!starts_with(iter->ref.refname, "refs/"))
+		if (!starts_with(iter->ref.refname, "refs/") &&
+		    !(iter->flags & DO_FOR_EACH_INCLUDE_ROOT_REFS &&
+		     (is_pseudoref(&iter->refs->base, iter->ref.refname) ||
+		      is_headref(&iter->refs->base, iter->ref.refname)))) {
 			continue;
+		}
 
 		if (iter->prefix &&
 		    strncmp(iter->prefix, iter->ref.refname, strlen(iter->prefix))) {
diff --git a/t/t6302-for-each-ref-filter.sh b/t/t6302-for-each-ref-filter.sh
index 82f3d1ea0f..948f1bb5f4 100755
--- a/t/t6302-for-each-ref-filter.sh
+++ b/t/t6302-for-each-ref-filter.sh
@@ -31,6 +31,37 @@ test_expect_success 'setup some history and refs' '
 	git update-ref refs/odd/spot main
 '
 
+test_expect_success '--include-root-refs pattern prints pseudorefs' '
+	cat >expect <<-\EOF &&
+	HEAD
+	ORIG_HEAD
+	refs/heads/main
+	refs/heads/side
+	refs/odd/spot
+	refs/tags/annotated-tag
+	refs/tags/doubly-annotated-tag
+	refs/tags/doubly-signed-tag
+	refs/tags/four
+	refs/tags/one
+	refs/tags/signed-tag
+	refs/tags/three
+	refs/tags/two
+	EOF
+	git update-ref ORIG_HEAD main &&
+	git for-each-ref --format="%(refname)" --include-root-refs >actual &&
+	test_cmp expect actual
+'
+
+test_expect_success '--include-root-refs with other patterns' '
+	cat >expect <<-\EOF &&
+	HEAD
+	ORIG_HEAD
+	EOF
+	git update-ref ORIG_HEAD main &&
+	git for-each-ref --format="%(refname)" --include-root-refs "*HEAD" >actual &&
+	test_cmp expect actual
+'
+
 test_expect_success 'filtering with --points-at' '
 	cat >expect <<-\EOF &&
 	refs/heads/main
-- 
2.43.GIT

