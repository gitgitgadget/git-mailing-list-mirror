Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.219.53
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794410905;
	b=me3ABgrxRsLcMqz3jpHJfTBHS5/J/iXccBjtWacgJQIzWXQzO0PWYTZQfg+UQKVAvhOF
	 Zd6L/nSV6+6dhkFZt0NCHkQ+b+zximCCZtZoGFjfrvLXx1MRsgOLv5UNDVlszbkJbMTXb
	 ab/ga4DyrVbbnNnXo2kh7KacZPJGAcW2cumHZkcqobCZBRO1PviqmMJ79ffUcRPoAyEVY
	 EzN8fsxSFa/YMcZLm+iqdfWgSH4Aru7YVqT07Mr0KT8yP0Uq2ILI0LK7b8V3llMTBfj2Q
	 NoG04c/lpF9kuTHcjZbdDIb1Ut3F1ZqNt1FnXeFOD+/Hznt8b5g3fCTwNe7dgyB3pyg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794410905;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=uC2HTphDxwAuMcNsLV5fuYaFwUBQeiAN7MruCC1rc6M=;
	b=i8xW8St57i/xdNlCIwipyuh2q+g5FBOPzlkcjoSXb8rFkR2xl58usWwnzBj3R0enJaaX
	 BvNI3rgKqWMmDC7mdjHghcoEufDjYnhyt4bEXTZY0O8KUSqoCJKubN+KaAvBYIQUd+uSy
	 dHuhYl9usr3m/eRVEwCFFWSrrO1+BxHScPXSwjleCbEcrka1Lnouf/OvWwhKR/5dGZjyF
	 4DKFymL+SMUjplcc+La+ziP7/WQKASTSwMfDlzLVhlI5PV5XYuPhvGuIPYttj/6vycIKJ
	 CPVKOiiQQVmbejPmMVv1Eo6srJhyODtYGR1HXfqwYcoOHyJ/oz9KU8TCbrPLotAqwgw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=jaspermayone.com;
	spf=pass smtp.mailfrom=singlefeather.com;
	dkim=pass header.d=jaspermayone.com header.i=@jaspermayone.com header.a=rsa-sha256 header.s=google header.b=TeKmuFVv;
	arc=none smtp.remote-ip=209.85.219.53
Received: from mail-qv1-f53.google.com (mail-qv1-f53.google.com [209.85.219.53])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0A1EF606A89A
	for <git@vger.kernel.org>; Wed, 11 Nov 2026 15:28:24 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 0A1EF606A89A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=jaspermayone.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=singlefeather.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=jaspermayone.com header.i=@jaspermayone.com header.a=rsa-sha256 header.s=google header.b=TeKmuFVv
Received: by mail-qv1-f53.google.com with SMTP id 6a1803df08f44-91e98301805so32447196d6.1
        for <git@vger.kernel.org>; Wed, 11 Nov 2026 07:28:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=jaspermayone.com; s=google; t=1794410904; x=1795015704; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=uC2HTphDxwAuMcNsLV5fuYaFwUBQeiAN7MruCC1rc6M=;
        b=TeKmuFVvlNqTOiFDuxWWqTftMC4qsflubniATycbjWn5cUNUQP0nf7mOBFrq2uMkAx
         ApE1wSODRLMmSJ/WBq25WkiT9pdL9231N24JbyoeGf+4gR1mDgFKwHqMrUD1JlaT86MS
         WGVnCJzYnr0rfeEvR7Qse6LkTLIzHH+tBe9hIJs+f0nnBqUehrld5GDzLw2MnTbPfwzR
         +ghA+CNktx5ekbPj7514vzJyINhEB7vM6Fsyh6dV2rBFm6vla9mwBdA62IabLZRXCy1N
         Axzta2WJvY19XUkSHb+nkzLDPxgls3WDalEtUksb7k3MYnXvzjbTz8J+tgU8/TtXvwjW
         Flmg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794410904; x=1795015704;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=uC2HTphDxwAuMcNsLV5fuYaFwUBQeiAN7MruCC1rc6M=;
        b=YiHQfPe3VxfnHrh4ecK53rVPeppLeDVrCqXYBy+eoBG+E42eVII2Ec7tADrm8+bnmH
         JYpIDqZ8p8Ma9dut3IQ0M8s6e43M98jekQHtpjU14VVHcBvDAZw/bmhscAEpcGppOIt3
         Havkes3QixvvRyhml0OognQi6JL+gqoIaCp1hqPqhw14pLGDO2YzRlG3ZGc4h2oaQrxO
         V37i+iChqRCCvYRD1AZ5VRoP2FD4ZpOLZCUytGlpHtTk/Q034WpEu0oihcxdHKvNciCu
         IJtyzt8RjSIOaEN9GGVrMYNSVcxw/GAjI/l6pGH8E35KiyUwMldlqWpDmsE7t3vBR5vN
         w3gw==
X-Gm-Message-State: APuU4Z8PwICkXmZbrENci0kQ93dci4Zk64mN6IgVlMaqWjTklh+cO1bj
	xjCY9sb0xjPz222MFw9YYJLIwd4toE72aRFgthAt0aGIBmh+0OBh9dWHWe8fwzGXQK3MBllN/0e
	fuWVbJR2z1tK25CE0lk0A1Lcbo1q308x5IApaEuU77x8SaYL4qnOGYE1FQbiF630wpzj9BX7nfm
	wdKQYI+UatL1DknvasDcdaxMOYIdkEWhGS507/LJE71Kp3C3fpbDNpjDYSuALo0qVWwQ2pe/Pt6
	s832jzXQgpV6IcGC0drw30j5ffBvqG7veIKOYrHDl0=
X-Gm-Gg: AYBFou3M6R0fz4dLlsaNxRKflQr6bdCNrIQ7lmFAXYcQb8V8UtIDw8nDcauipN4dccf
	1n9ctaocGTvCEB+nbXePrI7cZNe1vxpiveImztcEVhnI64JK23RkDZ+4Fi+5TYmHJ8xY/aoPQve
	XiKepW9zHhfxodsT/5481Fc/kpGq7BfpCNXlsAZwXKm9I4J6JS+a9xy+Su/ljUzZbMAEm0uyGxS
	3Vq8AbGTOZnQDvegvULq4BRNR7HLvSCGP2LIzjVRfBIJoYtSGA3gy+uH5FdpQSgrN7ZtYSx7V0n
	QjWRJ0kH+2WUXfqSFBBrHijAXikxoRopBXe9r1l5MXUe46kgL3/WnSvAXM9gjjVxTUJqAahJKnb
	O5rGO+bc9OkvSd/re6x1lT1iB47wOYUvGDj4tbnASR/rvwXxH7MhG8euIoWGNvh2HfstUur7dpk
	KQw9ShC9jac/C0Yv2B4O5phwy3QI9gSsGLzAkELPxYPk6y362FOhKEY9PppnccP226RJF3Ag7OC
	YbmjK5mnM/NwwiCQ58QAKBUiU7aPtD3DAV2g9RAz2nqX+0YE5ADiIbTGTJeKr8rZ31JA5yqnzV6
	iT3Dr4a9hKepn6t5bYgXmoMwAeS1c5INIr4nP+83gTTonokr43h2fJ7OJnPpcp8fdOTZ1sodLTC
	TIycIYnLeS8u0cpZ1Blhj3u9GUipOF6pdnMyYn/MGMu4bp498nSCIujVxrkg+Fd07Td74Bdysjb
	rV/yOHM7RkiUqUlHoIdjDhvpP1A9KENBDAfohSKOX0bnnx1qjAbJPhTImUmSKWhUL1ef1fSKSeP
	LQrghMbdHC93oT5RGsihbs5JJRbngBEIp4BP5uVjVAbT7STZriqT1o=
X-Received: by 2002:a05:6214:1947:b0:917:a58b:3629 with SMTP id 6a1803df08f44-91f04005bd4mr41135476d6.26.1794410903683;
        Wed, 11 Nov 2026 07:28:23 -0800 (PST)
Received: from remus.wildebeest-stargazer.ts.net ([69.43.88.101])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-91f04c2b8bfsm21341136d6.22.2026.11.11.07.28.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 11 Nov 2026 07:28:23 -0800 (PST)
From: Jasper Mayone <me@jaspermayone.com>
To: git@vger.kernel.org
Cc: gitster@pobox.com,
	phillip.wood123@gmail.com,
	sunshine@sunshineco.com,
	kristofferhaugsbakk@fastmail.com,
	ben.knoble@gmail.com,
	haraldnordgren@gmail.com,
	Jasper Mayone <me@jaspermayone.com>
Subject: [PATCH v5 4/5] ref-filter: add %(currentworktree)
Date: Wed, 11 Nov 2026 10:28:09 -0500
Message-ID: <20261111152811.99986-5-me@jaspermayone.com>
X-Mailer: git-send-email 2.56.0
In-Reply-To: <20261111152811.99986-1-me@jaspermayone.com>
References: <20261102182930.3511-1-me@jaspermayone.com>
 <20261111152811.99986-1-me@jaspermayone.com>
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Post: <mailto:git@vger.kernel.org>
List-Help: <mailto:git+help@vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
List-Owner: <mailto:git+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

%(worktreepath) names the worktree that has a branch checked out, or
is rebasing or bisecting it, but a format cannot tell if that worktree
is the current one. Comparing %(worktreepath) with a fixed path in
%(if:equals=...) does not work for every path, because a ")" ends the
atom.

Add %(currentworktree), which gives the path of the current worktree
when that worktree has the branch, and an empty string otherwise.
branch.c records these branches when it reads the worktrees, in a
second map next to the one that %(worktreepath) uses, so the lookup is
one map lookup per ref.

The next commit uses it in "git branch".

Suggested-by: Phillip Wood <phillip.wood123@gmail.com>
Signed-off-by: Jasper Mayone <me@jaspermayone.com>
---
 Documentation/git-for-each-ref.adoc |  7 +++++++
 branch.c                            | 25 ++++++++++++++++++-------
 branch.h                            |  7 +++++++
 ref-filter.c                        | 10 ++++++++++
 t/t6302-for-each-ref-filter.sh      | 21 +++++++++++++++++++++
 5 files changed, 63 insertions(+), 7 deletions(-)

diff --git a/Documentation/git-for-each-ref.adoc b/Documentation/git-for-each-ref.adoc
index 4456b4809a..5e2da92ee2 100644
--- a/Documentation/git-for-each-ref.adoc
+++ b/Documentation/git-for-each-ref.adoc
@@ -193,6 +193,13 @@ but if used together the last option is selected.
 	the `NUL` after the path and then for the `LF` that ends each
 	record.
 
+`currentworktree`::
+	The absolute path to the current worktree, if the ref is checked
+	out there, in the same sense as for `worktreepath`. Empty string
+	otherwise, also when the ref is checked out only in other
+	worktrees. Use it with `%(if)` to treat the current worktree
+	differently from the others.
+
 `ahead-behind:<commit-ish>`::
 	Two integers, separated by a space, demonstrating the number of
 	commits ahead and behind, respectively, when comparing the output
diff --git a/branch.c b/branch.c
index 87f3ffc35f..4de789b7ae 100644
--- a/branch.c
+++ b/branch.c
@@ -386,6 +386,8 @@ static int initialized_checked_out_branches;
 static struct strmap current_checked_out_branches = STRMAP_INIT;
 /* Like current_checked_out_branches, without the "update-ref" branches. */
 static struct strmap checked_out_worktrees = STRMAP_INIT;
+/* The subset of checked_out_worktrees that the current worktree has. */
+static struct strmap current_worktree_branches = STRMAP_INIT;
 
 enum branch_checkout_kind {
 	BRANCH_CHECKOUT_KIND_CHECKOUT,
@@ -404,11 +406,11 @@ static struct checked_out_branch *checked_out_branches;
 static size_t checked_out_branches_alloc, checked_out_branches_nr;
 
 static void register_checked_out_branch(const char *prefix, const char *name,
-					const char *path,
+					const struct worktree *wt,
 					enum branch_checkout_kind kind)
 {
 	char *refname = xstrfmt("%s%s", prefix, name);
-	char *path_copy = xstrdup(path);
+	char *path_copy = xstrdup(wt->path);
 
 	ALLOC_GROW(checked_out_branches, checked_out_branches_nr + 1,
 		   checked_out_branches_alloc);
@@ -418,8 +420,11 @@ static void register_checked_out_branch(const char *prefix, const char *name,
 	checked_out_branches_nr++;
 
 	strmap_put(&current_checked_out_branches, refname, path_copy);
-	if (kind != BRANCH_CHECKOUT_KIND_UPDATE_REF)
+	if (kind != BRANCH_CHECKOUT_KIND_UPDATE_REF) {
 		strmap_put(&checked_out_worktrees, refname, path_copy);
+		if (wt->is_current)
+			strmap_put(&current_worktree_branches, refname, path_copy);
+	}
 }
 
 static void prepare_checked_out_branches(void)
@@ -443,7 +448,7 @@ static void prepare_checked_out_branches(void)
 			continue;
 
 		if (wt->head_ref) {
-			register_checked_out_branch("", wt->head_ref, wt->path,
+			register_checked_out_branch("", wt->head_ref, wt,
 						    BRANCH_CHECKOUT_KIND_CHECKOUT);
 		}
 
@@ -451,7 +456,7 @@ static void prepare_checked_out_branches(void)
 		    (state.rebase_in_progress || state.rebase_interactive_in_progress) &&
 		    state.branch) {
 			register_checked_out_branch("refs/heads/", state.branch,
-						    wt->path,
+						    wt,
 						    BRANCH_CHECKOUT_KIND_REBASE);
 		}
 		wt_status_state_free_buffers(&state);
@@ -460,7 +465,7 @@ static void prepare_checked_out_branches(void)
 		    state.bisecting_from) {
 			register_checked_out_branch("refs/heads/",
 						    state.bisecting_from,
-						    wt->path,
+						    wt,
 						    BRANCH_CHECKOUT_KIND_BISECT);
 		}
 		wt_status_state_free_buffers(&state);
@@ -471,7 +476,7 @@ static void prepare_checked_out_branches(void)
 			struct string_list_item *item;
 			for_each_string_list_item(item, &update_refs) {
 				register_checked_out_branch("", item->string,
-							    wt->path,
+							    wt,
 							    BRANCH_CHECKOUT_KIND_UPDATE_REF);
 			}
 			string_list_clear(&update_refs, 1);
@@ -495,6 +500,12 @@ const char *branch_checked_out_worktree(const char *refname)
 	return strmap_get(&checked_out_worktrees, refname);
 }
 
+const char *branch_checked_out_current_worktree(const char *refname)
+{
+	prepare_checked_out_branches();
+	return strmap_get(&current_worktree_branches, refname);
+}
+
 const char *branch_bisecting(const char *refname)
 {
 	prepare_checked_out_branches();
diff --git a/branch.h b/branch.h
index 60cb92a3e4..744e1eec1d 100644
--- a/branch.h
+++ b/branch.h
@@ -115,6 +115,13 @@ const char *branch_checked_out(const char *refname);
  */
 const char *branch_checked_out_worktree(const char *refname);
 
+/*
+ * Like branch_checked_out_worktree(), but only for the current
+ * worktree: return its path if it has the branch 'refname' checked
+ * out, or is rebasing or bisecting it. Otherwise return NULL.
+ */
+const char *branch_checked_out_current_worktree(const char *refname);
+
 /*
  * If the branch at 'refname' is currently used for bisecting in a
  * worktree, then return the path to that worktree.
diff --git a/ref-filter.c b/ref-filter.c
index b636e56199..498d09da8f 100644
--- a/ref-filter.c
+++ b/ref-filter.c
@@ -142,6 +142,7 @@ enum atom_type {
 	ATOM_HEAD,
 	ATOM_COLOR,
 	ATOM_WORKTREEPATH,
+	ATOM_CURRENTWORKTREE,
 	ATOM_ALIGN,
 	ATOM_END,
 	ATOM_IF,
@@ -960,6 +961,7 @@ static struct {
 	[ATOM_HEAD] = { "HEAD", SOURCE_NONE, FIELD_STR, head_atom_parser },
 	[ATOM_COLOR] = { "color", SOURCE_NONE, FIELD_STR, color_atom_parser },
 	[ATOM_WORKTREEPATH] = { "worktreepath", SOURCE_NONE },
+	[ATOM_CURRENTWORKTREE] = { "currentworktree", SOURCE_NONE },
 	[ATOM_ALIGN] = { "align", SOURCE_NONE, FIELD_STR, align_atom_parser },
 	[ATOM_END] = { "end", SOURCE_NONE },
 	[ATOM_IF] = { "if", SOURCE_NONE, FIELD_STR, if_atom_parser },
@@ -2420,6 +2422,14 @@ static int populate_value(struct ref_array_item *ref, struct strbuf *err)
 				v->s = xstrdup("");
 			continue;
 		}
+		else if (atom_type == ATOM_CURRENTWORKTREE) {
+			const char *path = NULL;
+
+			if (ref->kind == FILTER_REFS_BRANCHES)
+				path = branch_checked_out_current_worktree(ref->refname);
+			v->s = xstrdup(path ? path : "");
+			continue;
+		}
 		else if (atom_type == ATOM_SYMREF)
 			refname = get_symref(atom, ref);
 		else if (atom_type == ATOM_UPSTREAM) {
diff --git a/t/t6302-for-each-ref-filter.sh b/t/t6302-for-each-ref-filter.sh
index 317ed6f6cd..32522f1ff3 100755
--- a/t/t6302-for-each-ref-filter.sh
+++ b/t/t6302-for-each-ref-filter.sh
@@ -617,6 +617,27 @@ test_expect_success 'worktree atom ignores the HEAD of a bare repository' '
 	test_cmp expect actual
 '
 
+test_expect_success 'currentworktree atom' '
+	test_when_finished "git -C current rebase --abort; rm -rf current; git worktree prune; git branch -D current" &&
+	git worktree add -b current current main &&
+	git -C current commit --allow-empty -m rebase-me &&
+	test_must_fail git -C current rebase -f -x false main &&
+	git for-each-ref --format="%(refname:short) [%(currentworktree)]" \
+		refs/heads/main refs/heads/current >actual &&
+	cat >expect <<-EOF &&
+	current []
+	main [$(pwd)]
+	EOF
+	test_cmp expect actual &&
+	git -C current for-each-ref --format="%(refname:short) [%(currentworktree)]" \
+		refs/heads/main refs/heads/current >actual &&
+	cat >expect <<-EOF &&
+	current [$(pwd)/current]
+	main []
+	EOF
+	test_cmp expect actual
+'
+
 test_expect_success 'start after with empty value' '
 	cat >expect <<-\EOF &&
 	refs/heads/main
-- 
2.56.0

