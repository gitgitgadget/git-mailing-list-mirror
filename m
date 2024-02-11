Received: from mail-ej1-f47.google.com (mail-ej1-f47.google.com [209.85.218.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1F73F5D759
	for <git@vger.kernel.org>; Sun, 11 Feb 2024 18:39:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707676775; cv=none; b=FsSNpIq1ieeE3Xg8MRjse2FDom/62wVts4ndec+NZHei6AdNBX1dm2O8sBt7xulOG+0DiL094iuljV673y928eu/wNUFGz0P947++K6sFC7pKePyUhEO8umx010SI8xpHYr2mP/7aLbKgpaTLR51vhMQhgMjVkfbxxN4k0s8EWA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707676775; c=relaxed/simple;
	bh=jRAc/WMMEIPT4uWq9Kh7vBImODiVTXJTaRKuyGdIJyA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=s0itaOmQQ+3dZHSC+SgRizpdUY5n042WnzDp3uplaNRxoQi1SDgRPz60J7DerJ7LOLfJOAQtPVuJeVuLdqoqQaGjflos2BY027AbOPw4a55sA9LGHxrozRHZUtkB8yCzIFywUbkz7Y9zTQnLMfrf4kwtMkcbtnlfPfFtui59COA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=PREqzbJa; arc=none smtp.client-ip=209.85.218.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="PREqzbJa"
Received: by mail-ej1-f47.google.com with SMTP id a640c23a62f3a-a34c5ca2537so311045766b.0
        for <git@vger.kernel.org>; Sun, 11 Feb 2024 10:39:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1707676772; x=1708281572; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=7RTpPQlVpONZILhTuiLZqVC72IculsaBZbyoIbQ0HIU=;
        b=PREqzbJazB3ogTeS/A6gDLHcKZuTWAdJDbwjZbONGLIVCKwW5IHryIcE3NLvKTrZJe
         8fn0Ex1X1r0ar2HplTF7ksLNFUw8NTZXNkPqpqB7z5tXuBV99C2C1MqMAUrJhcG8qDkm
         6bhgJBGxRxV9i9M/8M9mSQOQU50L0SknHURu25nkg9SUE9uBSrrC9LRRUvIk1FUqNd6a
         DiylJSiqN6Qdneuu6b/3YoE8pOeyLcEWXYm8qUUey7QU7iCsDYI80D7HXzpIw9kypyE7
         WUIrkM84cjm3IriPubpab79R6CULNWme8TM04woNgwzKRsciVegsvPP1gy0nvwrnWN/s
         f6jA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707676772; x=1708281572;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=7RTpPQlVpONZILhTuiLZqVC72IculsaBZbyoIbQ0HIU=;
        b=Tx0DDSsGZlzOvfz0e0SRjbXwYP+BngdgXi/XHbH7LlrFpfaX9k5JgkWmPzdwIWyd+w
         X0oXt416O6kJIsq09M7lTu40ORznwr2Tq2dHgSvsikuyq9otf0DBOdzIaW8vnqtxk5fi
         En8H3iJzihWF6tCVequblZ3z7HgwN6x6Z3kQkeGQYCxiQhEwfGXWA9hGmbbO2063zCts
         WN0U2VM6QEf4Ud1eFssavIIQrzddlMGTjceU41ioHwdYO7l1t7BPVuFmy2LIwxa37bvt
         uSuFbCKzh7pB4h97bbhD/6Ma6HO84pnXMDGklplLm2ozOwi9MPhUgW6Fxa11PgCuBJLc
         AK4w==
X-Gm-Message-State: AOJu0YyWvF13OIDAyseydDRz54fFQWu2oUmJSrPQ4NcPZ7viOluCfk0Z
	Dn2mojbI9whD2ihmyZLVmaqaCmz9U1xRoSBpyu197OJWdFq59Oga2tt8V8WE
X-Google-Smtp-Source: AGHT+IF/Bo2I7tI0qyH/CTWsTBjxYTagAvVyUKdiAvNRe8IWWl+xIcLThOX4EPug7b1hClOq1F3RYw==
X-Received: by 2002:a17:906:264a:b0:a3c:4dfd:1040 with SMTP id i10-20020a170906264a00b00a3c4dfd1040mr2118258ejc.12.1707676771864;
        Sun, 11 Feb 2024 10:39:31 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCWOiip6S1gXeXWVKuw562thQYwkfHHLFqYG35gfkuaAuKvoIpgpeKRFhEym4CzIiVihMhotIcksMRhDTqSAEcZyRVJle4JWFzxhQqZXzavFspLtMsO7msX9o4supkKhPzkH/QoEMOfnoN/o0A==
Received: from localhost.localdomain (h-213.61.124.196.host.de.colt.net. [213.61.124.196])
        by smtp.gmail.com with ESMTPSA id w12-20020a170906130c00b00a3716299b40sm3069808ejb.155.2024.02.11.10.39.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 11 Feb 2024 10:39:31 -0800 (PST)
From: Karthik Nayak <karthik.188@gmail.com>
To: git@vger.kernel.org
Cc: gitster@pobox.com,
	ps@pks.im,
	phillip.wood123@gmail.com,
	Karthik Nayak <karthik.188@gmail.com>
Subject: [PATCH v4 5/5] for-each-ref: add new option to include root refs
Date: Sun, 11 Feb 2024 19:39:23 +0100
Message-ID: <20240211183923.131278-6-karthik.188@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240211183923.131278-1-karthik.188@gmail.com>
References: <20240119142705.139374-1-karthik.188@gmail.com>
 <20240211183923.131278-1-karthik.188@gmail.com>
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
 builtin/for-each-ref.c             | 11 ++++++++---
 ref-filter.c                       | 27 +++++++++++++++++++++++++-
 ref-filter.h                       |  5 ++++-
 refs/reftable-backend.c            | 11 +++++++----
 t/t6302-for-each-ref-filter.sh     | 31 ++++++++++++++++++++++++++++++
 6 files changed, 80 insertions(+), 10 deletions(-)

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
index 23d352e371..9ed146dad3 100644
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
 
@@ -96,8 +97,12 @@ int cmd_for_each_ref(int argc, const char **argv, const char *prefix)
 		filter.name_patterns = argv;
 	}
 
+	if (include_root_refs) {
+		flags |= FILTER_REFS_ROOT_REFS;
+	}
+
 	filter.match_as_path = 1;
-	filter_and_format_refs(&filter, FILTER_REFS_REGULAR, sorting, &format);
+	filter_and_format_refs(&filter, flags, sorting, &format);
 
 	ref_filter_clear(&filter);
 	ref_sorting_release(sorting);
diff --git a/ref-filter.c b/ref-filter.c
index acb960e35c..0e83e29390 100644
--- a/ref-filter.c
+++ b/ref-filter.c
@@ -2628,6 +2628,12 @@ static int for_each_fullref_in_pattern(struct ref_filter *filter,
 				       each_ref_fn cb,
 				       void *cb_data)
 {
+	if (filter->kind == FILTER_REFS_KIND_MASK) {
+		/* in this case, we want to print all refs including root refs. */
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
 
@@ -2781,6 +2790,16 @@ static struct ref_array_item *apply_ref_filter(const char *refname, const struct
 
 	/* Obtain the current ref kind from filter_ref_kind() and ignore unwanted refs. */
 	kind = filter_ref_kind(filter, refname);
+
+	/*
+	 * When printing HEAD with all other refs, we want to apply the same formatting
+	 * rules as the other refs, so we simply ask it to be treated as a pseudoref.
+	 */
+	if (filter->kind == FILTER_REFS_KIND_MASK && kind == FILTER_REFS_DETACHED_HEAD)
+		kind = FILTER_REFS_PSEUDOREFS;
+	else if (!(kind & filter->kind))
+		return NULL;
+
 	if (!(kind & filter->kind))
 		return NULL;
 
@@ -3049,7 +3068,13 @@ static int do_filter_refs(struct ref_filter *filter, unsigned int type, each_ref
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

