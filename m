Received: from mail-pg1-f170.google.com (mail-pg1-f170.google.com [209.85.215.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D1EDA33D6EE
	for <git@vger.kernel.org>; Sun,  2 Aug 2026 21:28:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785706122; cv=none; b=DGICMQVO8xtMLGZQ0oAOftwGUglxOE7rip4VIqEv3d847AewCK7yX7ka15Wjr8sYeCtgK/UDZO0k+5+iB8trEzibUccNLmjis5m8Mr3zXr+eD9OXxNfRKK5V5X89Hy2qnhQdgtHfl9trMqV9p3wIX+svevtc2EEBCYKG5z1wAyM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785706122; c=relaxed/simple;
	bh=6YlWtL1K2+dTr2S9Qnw0kzIPDY/6lbO5wd7ZhvjiLkw=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=jEnT1aIsqGfaKgxApEpvensj7cUQFphea4YC7Xb3XK8rZ2eDjtkOoCabXRggimrF/abc04nd56oOYfrVdtH6rfUZP3KEwaCegPKI8fwENtgjDe5H3Zbt6WHc/din6A+CFBAFqIvCCDrcoi2Xrli/Ne+nkiTC2qimqR3Iu635COI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=imHCVkkg; arc=none smtp.client-ip=209.85.215.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="imHCVkkg"
Received: by mail-pg1-f170.google.com with SMTP id 41be03b00d2f7-ca957432c7fso1798054a12.1
        for <git@vger.kernel.org>; Sun, 02 Aug 2026 14:28:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1785706120; x=1786310920; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=yVfptjT19WjngqEjwRtwXLF/fGT92YWy31xgl9dB+S8=;
        b=imHCVkkgpfn9Wu75xve/zfpl0ZOxwAAu1hcXusJDLFgK+cht64YDL260hmOWWzUmn2
         dtn4jDK2GeWLWi/hQG44eJuMNW7epp4UXt6O4JBtRFEynStIa+wGhJD9edjO5voKNjWk
         QmAksOaN2QH5PCsapbZPaqF0ndtD1d4LFXfIWqV3QIcif1dHr9jFxVpFACxkvDxK0K9w
         WP1TMCiTh2FKEcTbnZOFPewNjgO3ZZTBVxR4mlBTMBUOPOdJulOA2pto2MIxRBzLU1xd
         J2myYQxAa2CnmNHv9FOWXn7JRrjoT+VZhHiWv98pzpgJpDpISomwLmURUy1miHz5VAqg
         Q6QQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785706120; x=1786310920;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=yVfptjT19WjngqEjwRtwXLF/fGT92YWy31xgl9dB+S8=;
        b=AE+kdLVRwKqDIMqsdtALGJaLDX6MKIKzki6p/wvfjCOz6SFH3krxQwm7ppaQLB3NW4
         r/gU9gYBxuR4SfWMoyfGpFI8q8zixfuB1XpFkBPBKmq3NLV9ZaFw+QYlTI1hrRQe6kyk
         plNwgv55uTuyzCmuu7uvAqovi0qRBVJlitWULOBikZ5NnZLkUnMEfdNt6g04kg6E+dNn
         uA/WkmHeI1TvuuYWsuI9/F9W5DI+uWHA3N5QBS1j8D6fBCIj4Zdg0olvXxdcf3cevLQC
         /T2vs/xdshomRHnZtWb1/mhtsZqE6HdZ68OcxPHwDMZXm4WVroSrKRmIW0ME6mJsyBDq
         U4cw==
X-Gm-Message-State: AOJu0YyH787jJ//e32+SZT36kCVHO1IS8t4s5HUlvgk77KAS28NcM1mN
	6FyImFpwFpbPnByjI//lZBanrU4spevGN/kCe87HIB+AXU7mxXynB7Cic+W4faeV
X-Gm-Gg: AR+sD13U2ipundS1/Ctixr/jj/wN139Wl1+oX4luQoHTMTROGsOFvo2Mz///Jm5EoFX
	9UeAPSJm1qKJI52n1XThoZf0Xfi8MJysFmNNxBvkrSIQuBNtXiyqtr9crNt9eIosmxS1MJdTGp3
	1t0oC/uV9uTz+q4qwlF8beztqcQmOfuMlL3TqEcM7R+FDjLYThFtUqUTLEpiVBrJwC5rM7jFz/q
	tIkkN20WvgJUHlHWSkcXrJNZWXRMj+7kw85Xg0HsAGnjGtIf10IfK4iBODYRh8OEYPDWQZBXeEy
	eNsf2wO3sM0wQKhPon0RDqps0zK/Vi8Ri+xFwAV8rxbrrU7icOfQ9NLnenJ47oDfa+tQG0Ori05
	WW9empgItaXZzjbGo9o4VZDv97ncqbSODmqF3WsEEgJb4RiCZG57hFQPUXVw7qZKBjON4zu1EEX
	YugyX8fq1Hr37CpMErQH6qXx/aHj+djlyNybWbGoB+hIvXizdz8Qvv/HBoSi6D2xAbPlM2Nmo3d
	kBRluObaZFnSw==
X-Received: by 2002:a05:6300:6186:b0:3c3:7ac4:dac7 with SMTP id adf61e73a8af0-3c92a7bb5eemr7707921637.45.1785706120082;
        Sun, 02 Aug 2026 14:28:40 -0700 (PDT)
Received: from sahitya-07.tail6abcb.ts.net ([2401:4900:8fba:2589:a129:af81:ad06:5213])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-13fab4fdb80sm23166098c88.15.2026.08.02.14.28.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 02 Aug 2026 14:28:39 -0700 (PDT)
From: Sahitya Chandra <sahityajb@gmail.com>
To: git@vger.kernel.org
Cc: Derrick Stolee <stolee@gmail.com>,
	Junio C Hamano <gitster@pobox.com>,
	Elijah Newren <newren@gmail.com>,
	=?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= <avarab@gmail.com>,
	Jeff King <peff@peff.net>,
	Patrick Steinhardt <ps@pks.im>,
	Sahitya Chandra <sahityajb@gmail.com>
Subject: [PATCH] read-cache: avoid sparse-index expansion for unborn HEAD
Date: Mon,  3 Aug 2026 02:58:26 +0530
Message-ID: <20260802212826.1090943-1-sahityajb@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

repo_index_has_changes() normally checks whether the index differs from
a tree by passing that tree to the diff machinery. When no tree is
passed, it tries to use HEAD for that comparison.

If HEAD does not resolve, as on an unborn branch, the function falls
back to walking the index directly. With a sparse index, however, sparse
directory entries may stand in for many paths, so the fallback first
expands the index before reporting the changed paths.

That expansion is unnecessary. An unborn HEAD is equivalent for this
check to comparing the index against the empty tree: every index entry
is new relative to that tree.

Use the empty tree when HEAD cannot be resolved. This keeps the
unborn-branch case on the same diff code path as the normal
tree-comparison case, avoiding the sparse-index expansion while still
letting callers see paths inside sparse directories.

Teach test-tool read-cache to exercise repo_index_has_changes(), and
add a t1092 check that the unborn-branch case reports paths inside a
sparse directory without expanding the index.

Signed-off-by: Sahitya Chandra <sahityajb@gmail.com>
---
 read-cache.c                             | 46 ++++++++++--------------
 t/helper/test-read-cache.c               | 19 ++++++++++
 t/t1092-sparse-checkout-compatibility.sh | 16 +++++++++
 3 files changed, 53 insertions(+), 28 deletions(-)

diff --git a/read-cache.c b/read-cache.c
index 6c449f393d..88ee9ba935 100644
--- a/read-cache.c
+++ b/read-cache.c
@@ -2505,39 +2505,29 @@ int repo_index_has_changes(struct repository *repo,
 			   struct tree *tree,
 			   struct strbuf *sb)
 {
-	struct index_state *istate = repo->index;
+	struct diff_options opt;
 	struct object_id cmp;
 	int i;
 
 	if (tree)
 		cmp = tree->object.oid;
-	if (tree || !repo_get_oid_tree(repo, "HEAD", &cmp)) {
-		struct diff_options opt;
-
-		repo_diff_setup(repo, &opt);
-		opt.flags.exit_with_status = 1;
-		if (!sb)
-			opt.flags.quick = 1;
-		diff_setup_done(&opt);
-		do_diff_cache(&cmp, &opt);
-		diffcore_std(&opt);
-		for (i = 0; sb && i < diff_queued_diff.nr; i++) {
-			if (i)
-				strbuf_addch(sb, ' ');
-			strbuf_addstr(sb, diff_queued_diff.queue[i]->two->path);
-		}
-		diff_flush(&opt);
-		return opt.flags.has_changes != 0;
-	} else {
-		/* TODO: audit for interaction with sparse-index. */
-		ensure_full_index(istate);
-		for (i = 0; sb && i < istate->cache_nr; i++) {
-			if (i)
-				strbuf_addch(sb, ' ');
-			strbuf_addstr(sb, istate->cache[i]->name);
-		}
-		return !!istate->cache_nr;
-	}
+	else if (repo_get_oid_tree(repo, "HEAD", &cmp))
+		oidcpy(&cmp, repo->hash_algo->empty_tree);
+
+	repo_diff_setup(repo, &opt);
+	opt.flags.exit_with_status = 1;
+	if (!sb)
+		opt.flags.quick = 1;
+	diff_setup_done(&opt);
+	do_diff_cache(&cmp, &opt);
+	diffcore_std(&opt);
+	for (i = 0; sb && i < diff_queued_diff.nr; i++) {
+		if (i)
+			strbuf_addch(sb, ' ');
+		strbuf_addstr(sb, diff_queued_diff.queue[i]->two->path);
+	}
+	diff_flush(&opt);
+	return opt.flags.has_changes != 0;
 }
 
 static int write_index_ext_header(struct hashfile *f,
diff --git a/t/helper/test-read-cache.c b/t/helper/test-read-cache.c
index 6b08ba8f07..ee629fbc69 100644
--- a/t/helper/test-read-cache.c
+++ b/t/helper/test-read-cache.c
@@ -4,6 +4,7 @@
 #include "config.h"
 #include "environment.h"
 #include "read-cache-ll.h"
+#include "repo-settings.h"
 #include "repository.h"
 #include "setup.h"
 
@@ -12,6 +13,24 @@ int cmd__read_cache(int argc, const char **argv)
 	int i, cnt = 1;
 	const char *name = NULL;
 
+	if (argc == 2 && !strcmp(argv[1], "--index-has-changes")) {
+		struct strbuf sb = STRBUF_INIT;
+		int ret;
+
+		setup_git_directory(the_repository);
+		repo_config(the_repository, git_default_config, NULL);
+		prepare_repo_settings(the_repository);
+		the_repository->settings.command_requires_full_index = 0;
+
+		repo_read_index(the_repository);
+		ret = repo_index_has_changes(the_repository, NULL, &sb);
+		printf("has_changes=%d\n", ret);
+		if (sb.len)
+			printf("dirty=%s\n", sb.buf);
+		strbuf_release(&sb);
+		return 0;
+	}
+
 	if (argc > 1 && skip_prefix(argv[1], "--print-and-refresh=", &name)) {
 		argc--;
 		argv++;
diff --git a/t/t1092-sparse-checkout-compatibility.sh b/t/t1092-sparse-checkout-compatibility.sh
index 4140c4d8ef..90239a862d 100755
--- a/t/t1092-sparse-checkout-compatibility.sh
+++ b/t/t1092-sparse-checkout-compatibility.sh
@@ -1558,6 +1558,22 @@ test_expect_success 'sparse-index is not expanded' '
 	)
 '
 
+test_expect_success 'sparse-index is not expanded: index has changes on unborn branch' '
+	init_repos &&
+	git -C sparse-index checkout --orphan unborn &&
+	git -C sparse-index ls-files --sparse --stage >cache &&
+	test_grep "^040000 .*	folder1/$" cache &&
+
+	rm -f trace2.txt &&
+	GIT_TRACE2_EVENT="$(pwd)/trace2.txt" GIT_TRACE2_EVENT_NESTING=10 \
+		test-tool -C sparse-index read-cache --index-has-changes \
+		>sparse-index-out 2>sparse-index-error &&
+	test_region ! index ensure_full_index trace2.txt &&
+	test_must_be_empty sparse-index-error &&
+	test_grep "has_changes=1" sparse-index-out &&
+	test_grep "folder1/a" sparse-index-out
+'
+
 test_expect_success 'sparse-index is not expanded: merge conflict in cone' '
 	init_repos &&
 

base-commit: a97fcc37c2bc6340a8d7ce78dedf227aac4e9aa7
-- 
2.43.0

